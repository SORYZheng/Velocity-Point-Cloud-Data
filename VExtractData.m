clc
clear
close all
%% 加载数据
for loop=3
load(['E:\BaiduNetdiskDownload\6节点数据采集\节点1\测试人员001\动作002\node1_001_002_',num2str(loop),'.mat']);
%% 构建5维信息
fHistSave(1).pointCloud(5,:) =0;
%% 删除多余帧数以及增加缺失的帧数
if size(fHistSave,2) == 1501
    fHistSave(1501)=[];
end
if size(fHistSave,2) == 751
    fHistSave(751)=[];
end
if size(fHistSave,2) == 752
    fHistSave(751:752)=[];
end
if size(fHistSave,2)==749
    fHistSave(750).pointCloud(5,:)=[0,1];
end
%% 帧数
Framenum = size(fHistSave,2);
%% 判断帧间隔
if Framenum ~= 750
    FrameInterval = 70;
else
    FrameInterval = 30;
end
%% 提取点云数据
for i=1:Framenum
    Pointnum = size(fHistSave(i).pointCloud,2);
    if size(fHistSave(i).pointCloud,1) == 4
        fHistSave(i).pointCloud(5,:)=0;
    end
    PointData(i,:,1:Pointnum)=(fHistSave(i).pointCloud);
end
%% 点云数据(1)
TD=1; %时延TD-1帧
for ii=(FrameInterval+TD):FrameInterval:Framenum
    ii
    if ii+FrameInterval-1 > size(fHistSave, 2)
        break;
    else
        data = PointData(ii:ii+FrameInterval-1,:,:);
        VPointCloud = squeeze(data(:,3,:));
 %% 速度点云图像
        figure()
        set(0,'DefaultFigureVisible', 'off')
        sz=16;
        scatter(1:FrameInterval,VPointCloud,sz,'k','filled')
        % plot(VPointCloud,'.','MarkerEdgeColor','b','markersize',15);
        % colorbar
        axis xy
        set(gca,'FontName','Times New Roman','FontSize',24)
        xlabel("Frame (num)",'FontSize',24)
        ylabel("Velocity (m/s)",'FontSize',24)
        axis off
        ylim([-2, 2])
        saveas(gcf,['C:\Users\lenovo\Desktop\新建文件夹\node1_001_002_',num2str(loop)','_',num2str(ii),'.png']);
    end
end
end