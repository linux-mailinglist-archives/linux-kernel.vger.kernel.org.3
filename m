Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF99B52A058
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 13:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344321AbiEQLZP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 07:25:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbiEQLZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 07:25:07 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 578EF4BBA5;
        Tue, 17 May 2022 04:25:05 -0700 (PDT)
X-UUID: 47870f8dd43246989887ffb08d59aafe-20220517
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:1e3771ee-b460-42bd-bb0e-39745a5d4905,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-META: VersionHash:2a19b09,CLOUDID:f5a07ee2-edbf-4bd4-8a34-dfc5f7bb086d,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil
        ,QS:0,BEC:nil
X-UUID: 47870f8dd43246989887ffb08d59aafe-20220517
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1492008741; Tue, 17 May 2022 19:25:01 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Tue, 17 May 2022 19:24:59 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkmbs11n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Tue, 17 May 2022 19:24:59 +0800
Message-ID: <789773e86ff45705a7b87d8aa13e315903b5ad69.camel@mediatek.com>
Subject: Re: [PATCH v15 3/3] media: platform: mtk-mdp3: add Mediatek MDP3
 driver
From:   Rex-BC Chen <rex-bc.chen@mediatek.com>
To:     Moudy Ho <moudy.ho@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
CC:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Rob Landley <rob@landley.net>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        <tfiga@chromium.org>, <drinkcat@chromium.org>,
        <pihsun@chromium.org>, <hsinyi@google.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        daoyuan huang <daoyuan.huang@mediatek.com>,
        Ping-Hsun Wu <ping-hsun.wu@mediatek.com>,
        <allen-kh.cheng@mediatek.com>, <xiandong.wang@mediatek.com>,
        <randy.wu@mediatek.com>, <jason-jh.lin@mediatek.com>,
        <roy-cw.yeh@mediatek.com>, <river.cheng@mediatek.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <cellopoint.kai@gmail.com>
Date:   Tue, 17 May 2022 19:24:59 +0800
In-Reply-To: <20220512092306.6895-4-moudy.ho@mediatek.com>
References: <20220512092306.6895-1-moudy.ho@mediatek.com>
         <20220512092306.6895-4-moudy.ho@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-05-12 at 17:23 +0800, Moudy Ho wrote:
> This patch adds driver for Mediatek's Media Data Path ver.3 (MDP3).
> It provides the following functions:
>   color transform, format conversion, resize, crop, rotate, flip
>   and additional image quality enhancement.
> 
> The MDP3 driver is mainly used for Google Chromebook products to
> import the new architecture to set the HW settings as shown below:
>   User -> V4L2 framework
>     -> MDP3 driver -> SCP (setting calculations)
>       -> MDP3 driver -> CMDQ (GCE driver) -> HW
> 
> Each modules' related operation control is sited in mtk-mdp3-comp.c
> Each modules' register table is defined in file with "mdp_reg_"
> prefix
> GCE related API, operation control  sited in mtk-mdp3-cmdq.c
> V4L2 m2m device functions are implemented in mtk-mdp3-m2m.c
> Probe, power, suspend/resume, system level functions are defined in
> mtk-mdp3-core.c
> 
> v4l2-compliance 1.22.1, 32 bits, 32-bit time_t
> 
> Compliance test for mtk-mdp3 device /dev/video2:
> 
> Driver Info:
> 	Driver name      : mtk-mdp3
> 	Card type        : 14001000.mdp3-rdma0
> 	Bus info         : platform:mtk-mdp3
> 	Driver version   : 5.18.0
> 	Capabilities     : 0x84204000
> 		Video Memory-to-Memory Multiplanar
> 		Streaming
> 		Extended Pix Format
> 		Device Capabilities
> 	Device Caps      : 0x04204000
> 		Video Memory-to-Memory Multiplanar
> 		Streaming
> 		Extended Pix Format
> 
> Required ioctls:
> 	test VIDIOC_QUERYCAP: OK
> 	test invalid ioctls: OK
> 
> Allow for multiple opens:
> 	test second /dev/video2 open: OK
> 	test VIDIOC_QUERYCAP: OK
> 	test VIDIOC_G/S_PRIORITY: OK
> 	test for unlimited opens: OK
> 
> Debug ioctls:
> 	test VIDIOC_DBG_G/S_REGISTER: OK (Not Supported)
> 	test VIDIOC_LOG_STATUS: OK (Not Supported)
> 
> Input ioctls:
> 	test VIDIOC_G/S_TUNER/ENUM_FREQ_BANDS: OK (Not Supported)
> 	test VIDIOC_G/S_FREQUENCY: OK (Not Supported)
> 	test VIDIOC_S_HW_FREQ_SEEK: OK (Not Supported)
> 	test VIDIOC_ENUMAUDIO: OK (Not Supported)
> 	test VIDIOC_G/S/ENUMINPUT: OK (Not Supported)
> 	test VIDIOC_G/S_AUDIO: OK (Not Supported)
> 	Inputs: 0 Audio Inputs: 0 Tuners: 0
> 
> Output ioctls:
> 	test VIDIOC_G/S_MODULATOR: OK (Not Supported)
> 	test VIDIOC_G/S_FREQUENCY: OK (Not Supported)
> 	test VIDIOC_ENUMAUDOUT: OK (Not Supported)
> 	test VIDIOC_G/S/ENUMOUTPUT: OK (Not Supported)
> 	test VIDIOC_G/S_AUDOUT: OK (Not Supported)
> 	Outputs: 0 Audio Outputs: 0 Modulators: 0
> 
> Input/Output configuration ioctls:
> 	test VIDIOC_ENUM/G/S/QUERY_STD: OK (Not Supported)
> 	test VIDIOC_ENUM/G/S/QUERY_DV_TIMINGS: OK (Not Supported)
> 	test VIDIOC_DV_TIMINGS_CAP: OK (Not Supported)
> 	test VIDIOC_G/S_EDID: OK (Not Supported)
> 
> Control ioctls:
> 	test VIDIOC_QUERY_EXT_CTRL/QUERYMENU: OK
> 	test VIDIOC_QUERYCTRL: OK
> 	test VIDIOC_G/S_CTRL: OK
> 	test VIDIOC_G/S/TRY_EXT_CTRLS: OK
> 	test VIDIOC_(UN)SUBSCRIBE_EVENT/DQEVENT: OK
> 	test VIDIOC_G/S_JPEGCOMP: OK (Not Supported)
> 	Standard Controls: 4 Private Controls: 0
> 
> Format ioctls:
> 	test VIDIOC_ENUM_FMT/FRAMESIZES/FRAMEINTERVALS: OK
> 	test VIDIOC_G/S_PARM: OK (Not Supported)
> 	test VIDIOC_G_FBUF: OK (Not Supported)
> 	test VIDIOC_G_FMT: OK
> 	test VIDIOC_TRY_FMT: OK
> 	test VIDIOC_S_FMT: OK
> 	test VIDIOC_G_SLICED_VBI_CAP: OK (Not Supported)
> 	test Cropping: OK
> 	test Composing: OK
> 	test Scaling: OK
> 
> Codec ioctls:
> 	test VIDIOC_(TRY_)ENCODER_CMD: OK (Not Supported)
> 	test VIDIOC_G_ENC_INDEX: OK (Not Supported)
> 	test VIDIOC_(TRY_)DECODER_CMD: OK (Not Supported)
> 
> Buffer ioctls:
> 	test VIDIOC_REQBUFS/CREATE_BUFS/QUERYBUF: OK
> 	test VIDIOC_EXPBUF: OK
> 	test Requests: OK (Not Supported)
> 	test TIME32/64: OK
> 
> Test input 0:
> 
> Streaming ioctls:
> 	test read/write: OK (Not Supported)
> 	test blocking wait: OK
> 
> 	Video Output Multiplanar: Frame #002
> 	Video Output Multiplanar: Frame #003
> 	Video Output Multiplanar: Frame #004
> 	Video Output Multiplanar: Frame #005
> 	Video Output Multiplanar: Frame #006
> 	Video Output Multiplanar: Frame #007
> 	Video Output Multiplanar: Frame #008
> 	Video Output Multiplanar: Frame #009
> 	Video Output Multiplanar: Frame #010
> 	Video Output Multiplanar: Frame #011
> 	Video Output Multiplanar: Frame #012
> 	Video Output Multiplanar: Frame #013
> 	Video Output Multiplanar: Frame #014
> 	Video Output Multiplanar: Frame #015
> 	Video Output Multiplanar: Frame #016
> 	Video Output Multiplanar: Frame #017
> 	Video Output Multiplanar: Frame #018
> 	Video Output Multiplanar: Frame #019
> 	Video Output Multiplanar: Frame #020
> 	Video Output Multiplanar: Frame #021
> 	Video Output Multiplanar: Frame #022
> 	Video Output Multiplanar: Frame #023
> 	Video Output Multiplanar: Frame #024
> 	Video Output Multiplanar: Frame #025
> 	Video Output Multiplanar: Frame #026
> 	Video Output Multiplanar: Frame #027
> 	Video Output Multiplanar: Frame #028
> 	Video Output Multiplanar: Frame #029
> 	Video Output Multiplanar: Frame #030
> 	Video Output Multiplanar: Frame #031
> 	Video Output Multiplanar: Frame #032
> 	Video Output Multiplanar: Frame #033
> 	Video Output Multiplanar: Frame #034
> 	Video Output Multiplanar: Frame #035
> 	Video Output Multiplanar: Frame #036
> 	Video Output Multiplanar: Frame #037
> 	Video Output Multiplanar: Frame #038
> 	Video Output Multiplanar: Frame #039
> 	Video Output Multiplanar: Frame #040
> 	Video Output Multiplanar: Frame #041
> 	Video Output Multiplanar: Frame #042
> 	Video Output Multiplanar: Frame #043
> 	Video Output Multiplanar: Frame #044
> 	Video Output Multiplanar: Frame #045
> 	Video Output Multiplanar: Frame #046
> 	Video Output Multiplanar: Frame #047
> 	Video Output Multiplanar: Frame #048
> 	Video Output Multiplanar: Frame #049
> 	Video Output Multiplanar: Frame #050
> 	Video Output Multiplanar: Frame #051
> 	Video Output Multiplanar: Frame #052
> 	Video Output Multiplanar: Frame #053
> 	Video Output Multiplanar: Frame #054
> 	Video Output Multiplanar: Frame #055
> 	Video Output Multiplanar: Frame #056
> 	Video Output Multiplanar: Frame #057
> 	Video Output Multiplanar: Frame #058
> 	Video Output Multiplanar: Frame #059
> 
> 	Video Capture Multiplanar: Captured 58 buffers
> 	test MMAP (no poll): OK
> 
> 	Video Output Multiplanar: Frame #002 (select)
> 	Video Output Multiplanar: Frame #003 (select)
> 	Video Output Multiplanar: Frame #004 (select)
> 	Video Output Multiplanar: Frame #005 (select)
> 	Video Output Multiplanar: Frame #006 (select)
> 	Video Output Multiplanar: Frame #007 (select)
> 	Video Output Multiplanar: Frame #008 (select)
> 	Video Output Multiplanar: Frame #009 (select)
> 	Video Output Multiplanar: Frame #010 (select)
> 	Video Output Multiplanar: Frame #011 (select)
> 	Video Output Multiplanar: Frame #012 (select)
> 	Video Output Multiplanar: Frame #013 (select)
> 	Video Output Multiplanar: Frame #014 (select)
> 	Video Output Multiplanar: Frame #015 (select)
> 	Video Output Multiplanar: Frame #016 (select)
> 	Video Output Multiplanar: Frame #017 (select)
> 	Video Output Multiplanar: Frame #018 (select)
> 	Video Output Multiplanar: Frame #019 (select)
> 	Video Output Multiplanar: Frame #020 (select)
> 	Video Output Multiplanar: Frame #021 (select)
> 	Video Output Multiplanar: Frame #022 (select)
> 	Video Output Multiplanar: Frame #023 (select)
> 	Video Output Multiplanar: Frame #024 (select)
> 	Video Output Multiplanar: Frame #025 (select)
> 	Video Output Multiplanar: Frame #026 (select)
> 	Video Output Multiplanar: Frame #027 (select)
> 	Video Output Multiplanar: Frame #028 (select)
> 	Video Output Multiplanar: Frame #029 (select)
> 	Video Output Multiplanar: Frame #030 (select)
> 	Video Output Multiplanar: Frame #031 (select)
> 	Video Output Multiplanar: Frame #032 (select)
> 	Video Output Multiplanar: Frame #033 (select)
> 	Video Output Multiplanar: Frame #034 (select)
> 	Video Output Multiplanar: Frame #035 (select)
> 	Video Output Multiplanar: Frame #036 (select)
> 	Video Output Multiplanar: Frame #037 (select)
> 	Video Output Multiplanar: Frame #038 (select)
> 	Video Output Multiplanar: Frame #039 (select)
> 	Video Output Multiplanar: Frame #040 (select)
> 	Video Output Multiplanar: Frame #041 (select)
> 	Video Output Multiplanar: Frame #042 (select)
> 	Video Output Multiplanar: Frame #043 (select)
> 	Video Output Multiplanar: Frame #044 (select)
> 	Video Output Multiplanar: Frame #045 (select)
> 	Video Output Multiplanar: Frame #046 (select)
> 	Video Output Multiplanar: Frame #047 (select)
> 	Video Output Multiplanar: Frame #048 (select)
> 	Video Output Multiplanar: Frame #049 (select)
> 	Video Output Multiplanar: Frame #050 (select)
> 	Video Output Multiplanar: Frame #051 (select)
> 	Video Output Multiplanar: Frame #052 (select)
> 	Video Output Multiplanar: Frame #053 (select)
> 	Video Output Multiplanar: Frame #054 (select)
> 	Video Output Multiplanar: Frame #055 (select)
> 	Video Output Multiplanar: Frame #056 (select)
> 	Video Output Multiplanar: Frame #057 (select)
> 	Video Output Multiplanar: Frame #058 (select)
> 	Video Output Multiplanar: Frame #059 (select)
> 
> 	Video Capture Multiplanar: Captured 58 buffers
> 	test MMAP (select): OK
> 
> 	Video Output Multiplanar: Frame #002 (epoll)
> 	Video Output Multiplanar: Frame #003 (epoll)
> 	Video Output Multiplanar: Frame #004 (epoll)
> 	Video Output Multiplanar: Frame #005 (epoll)
> 	Video Output Multiplanar: Frame #006 (epoll)
> 	Video Output Multiplanar: Frame #007 (epoll)
> 	Video Output Multiplanar: Frame #008 (epoll)
> 	Video Output Multiplanar: Frame #009 (epoll)
> 	Video Output Multiplanar: Frame #010 (epoll)
> 	Video Output Multiplanar: Frame #011 (epoll)
> 	Video Output Multiplanar: Frame #012 (epoll)
> 	Video Output Multiplanar: Frame #013 (epoll)
> 	Video Output Multiplanar: Frame #014 (epoll)
> 	Video Output Multiplanar: Frame #015 (epoll)
> 	Video Output Multiplanar: Frame #016 (epoll)
> 	Video Output Multiplanar: Frame #017 (epoll)
> 	Video Output Multiplanar: Frame #018 (epoll)
> 	Video Output Multiplanar: Frame #019 (epoll)
> 	Video Output Multiplanar: Frame #020 (epoll)
> 	Video Output Multiplanar: Frame #021 (epoll)
> 	Video Output Multiplanar: Frame #022 (epoll)
> 	Video Output Multiplanar: Frame #023 (epoll)
> 	Video Output Multiplanar: Frame #024 (epoll)
> 	Video Output Multiplanar: Frame #025 (epoll)
> 	Video Output Multiplanar: Frame #026 (epoll)
> 	Video Output Multiplanar: Frame #027 (epoll)
> 	Video Output Multiplanar: Frame #028 (epoll)
> 	Video Output Multiplanar: Frame #029 (epoll)
> 	Video Output Multiplanar: Frame #030 (epoll)
> 	Video Output Multiplanar: Frame #031 (epoll)
> 	Video Output Multiplanar: Frame #032 (epoll)
> 	Video Output Multiplanar: Frame #033 (epoll)
> 	Video Output Multiplanar: Frame #034 (epoll)
> 	Video Output Multiplanar: Frame #035 (epoll)
> 	Video Output Multiplanar: Frame #036 (epoll)
> 	Video Output Multiplanar: Frame #037 (epoll)
> 	Video Output Multiplanar: Frame #038 (epoll)
> 	Video Output Multiplanar: Frame #039 (epoll)
> 	Video Output Multiplanar: Frame #040 (epoll)
> 	Video Output Multiplanar: Frame #041 (epoll)
> 	Video Output Multiplanar: Frame #042 (epoll)
> 	Video Output Multiplanar: Frame #043 (epoll)
> 	Video Output Multiplanar: Frame #044 (epoll)
> 	Video Output Multiplanar: Frame #045 (epoll)
> 	Video Output Multiplanar: Frame #046 (epoll)
> 	Video Output Multiplanar: Frame #047 (epoll)
> 	Video Output Multiplanar: Frame #048 (epoll)
> 	Video Output Multiplanar: Frame #049 (epoll)
> 	Video Output Multiplanar: Frame #050 (epoll)
> 	Video Output Multiplanar: Frame #051 (epoll)
> 	Video Output Multiplanar: Frame #052 (epoll)
> 	Video Output Multiplanar: Frame #053 (epoll)
> 	Video Output Multiplanar: Frame #054 (epoll)
> 	Video Output Multiplanar: Frame #055 (epoll)
> 	Video Output Multiplanar: Frame #056 (epoll)
> 	Video Output Multiplanar: Frame #057 (epoll)
> 	Video Output Multiplanar: Frame #058 (epoll)
> 	Video Output Multiplanar: Frame #059 (epoll)
> 
> 	Video Capture Multiplanar: Captured 58 buffers
> 	test MMAP (epoll): OK
> 	test USERPTR (no poll): OK (Not Supported)
> 	test USERPTR (select): OK (Not Supported)
> 	test DMABUF: Cannot test, specify --expbuf-device
> 
> Total for mtk-mdp3 device /dev/video2: 53, Succeeded: 53, Failed: 0,
> Warnings: 0
> 
> Signed-off-by: Ping-Hsun Wu <ping-hsun.wu@mediatek.com>
> Signed-off-by: daoyuan huang <daoyuan.huang@mediatek.com>
> Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>
> ---
>  drivers/media/platform/mediatek/Kconfig       |   1 +
>  drivers/media/platform/mediatek/Makefile      |   1 +
>  drivers/media/platform/mediatek/mdp3/Kconfig  |  20 +
>  drivers/media/platform/mediatek/mdp3/Makefile |   6 +
>  .../platform/mediatek/mdp3/mdp_reg_ccorr.h    |  19 +
>  .../platform/mediatek/mdp3/mdp_reg_rdma.h     |  65 ++
>  .../platform/mediatek/mdp3/mdp_reg_rsz.h      |  39 +
>  .../platform/mediatek/mdp3/mdp_reg_wdma.h     |  47 +
>  .../platform/mediatek/mdp3/mdp_reg_wrot.h     |  55 +
>  .../platform/mediatek/mdp3/mtk-img-ipi.h      | 290 +++++
>  .../platform/mediatek/mdp3/mtk-mdp3-cmdq.c    | 486 +++++++++
>  .../platform/mediatek/mdp3/mtk-mdp3-cmdq.h    |  48 +
>  .../platform/mediatek/mdp3/mtk-mdp3-comp.c    | 987
> ++++++++++++++++++
>  .../platform/mediatek/mdp3/mtk-mdp3-comp.h    | 185 ++++
>  .../platform/mediatek/mdp3/mtk-mdp3-core.c    | 379 +++++++
>  .../platform/mediatek/mdp3/mtk-mdp3-core.h    |  95 ++
>  .../platform/mediatek/mdp3/mtk-mdp3-m2m.c     | 772 ++++++++++++++
>  .../platform/mediatek/mdp3/mtk-mdp3-m2m.h     |  48 +
>  .../platform/mediatek/mdp3/mtk-mdp3-regs.c    | 736 +++++++++++++
>  .../platform/mediatek/mdp3/mtk-mdp3-regs.h    | 370 +++++++
>  .../platform/mediatek/mdp3/mtk-mdp3-vpu.c     | 312 ++++++
>  .../platform/mediatek/mdp3/mtk-mdp3-vpu.h     |  78 ++
>  22 files changed, 5039 insertions(+)
>  create mode 100644 drivers/media/platform/mediatek/mdp3/Kconfig
>  create mode 100644 drivers/media/platform/mediatek/mdp3/Makefile
>  create mode 100644
> drivers/media/platform/mediatek/mdp3/mdp_reg_ccorr.h
>  create mode 100644
> drivers/media/platform/mediatek/mdp3/mdp_reg_rdma.h
>  create mode 100644
> drivers/media/platform/mediatek/mdp3/mdp_reg_rsz.h
>  create mode 100644
> drivers/media/platform/mediatek/mdp3/mdp_reg_wdma.h
>  create mode 100644
> drivers/media/platform/mediatek/mdp3/mdp_reg_wrot.h
>  create mode 100644 drivers/media/platform/mediatek/mdp3/mtk-img-
> ipi.h
>  create mode 100644 drivers/media/platform/mediatek/mdp3/mtk-mdp3-
> cmdq.c
>  create mode 100644 drivers/media/platform/mediatek/mdp3/mtk-mdp3-
> cmdq.h
>  create mode 100644 drivers/media/platform/mediatek/mdp3/mtk-mdp3-
> comp.c
>  create mode 100644 drivers/media/platform/mediatek/mdp3/mtk-mdp3-
> comp.h
>  create mode 100644 drivers/media/platform/mediatek/mdp3/mtk-mdp3-
> core.c
>  create mode 100644 drivers/media/platform/mediatek/mdp3/mtk-mdp3-
> core.h
>  create mode 100644 drivers/media/platform/mediatek/mdp3/mtk-mdp3-
> m2m.c
>  create mode 100644 drivers/media/platform/mediatek/mdp3/mtk-mdp3-
> m2m.h
>  create mode 100644 drivers/media/platform/mediatek/mdp3/mtk-mdp3-
> regs.c
>  create mode 100644 drivers/media/platform/mediatek/mdp3/mtk-mdp3-
> regs.h
>  create mode 100644 drivers/media/platform/mediatek/mdp3/mtk-mdp3-
> vpu.c
>  create mode 100644 drivers/media/platform/mediatek/mdp3/mtk-mdp3-
> vpu.h
> 
> diff --git a/drivers/media/platform/mediatek/Kconfig
> b/drivers/media/platform/mediatek/Kconfig
> index af47d9888552..84104e2cd024 100644
> --- a/drivers/media/platform/mediatek/Kconfig
> +++ b/drivers/media/platform/mediatek/Kconfig
> @@ -6,3 +6,4 @@ source "drivers/media/platform/mediatek/jpeg/Kconfig"
>  source "drivers/media/platform/mediatek/mdp/Kconfig"
>  source "drivers/media/platform/mediatek/vcodec/Kconfig"
>  source "drivers/media/platform/mediatek/vpu/Kconfig"
> +source "drivers/media/platform/mediatek/mdp3/Kconfig"
> diff --git a/drivers/media/platform/mediatek/Makefile
> b/drivers/media/platform/mediatek/Makefile
> index d3850a13f128..38e6ba917fe5 100644
> --- a/drivers/media/platform/mediatek/Makefile
> +++ b/drivers/media/platform/mediatek/Makefile
> @@ -3,3 +3,4 @@ obj-y += jpeg/
>  obj-y += mdp/
>  obj-y += vcodec/
>  obj-y += vpu/
> +obj-y += mdp3/
> diff --git a/drivers/media/platform/mediatek/mdp3/Kconfig
> b/drivers/media/platform/mediatek/mdp3/Kconfig
> new file mode 100644
> index 000000000000..6640763c7c5e
> --- /dev/null
> +++ b/drivers/media/platform/mediatek/mdp3/Kconfig
> @@ -0,0 +1,20 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +config VIDEO_MEDIATEK_MDP3
> +	tristate "Mediatek MDP v3 driver"
> +	depends on MTK_IOMMU || COMPLIE_TEST
> +	depends on VIDEO_DEV
> +	depends on ARCH_MEDIATEK || COMPILE_TEST
> +	depends on MTK_MMSYS
> +	depends on HAS_DMA
> +	select VIDEOBUF2_DMA_CONTIG
> +	select V4L2_MEM2MEM_DEV
> +	select VIDEO_MEDIATEK_VPU
> +	select MTK_CMDQ
> +	select MTK_SCP
> +	default n
> +	help
> +	    It is a v4l2 driver and present in Mediatek MT8183 SoC.
> +	    The driver supports for scaling and color space conversion.
> +
> +	    To compile this driver as a module, choose M here: the
> +	    module will be called mtk-mdp3.
> diff --git a/drivers/media/platform/mediatek/mdp3/Makefile
> b/drivers/media/platform/mediatek/mdp3/Makefile
> new file mode 100644
> index 000000000000..8772f5ac2867
> --- /dev/null
> +++ b/drivers/media/platform/mediatek/mdp3/Makefile
> @@ -0,0 +1,6 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +mtk-mdp3-y += mtk-mdp3-core.o mtk-mdp3-vpu.o mtk-mdp3-regs.o
> +mtk-mdp3-y += mtk-mdp3-m2m.o
> +mtk-mdp3-y += mtk-mdp3-comp.o mtk-mdp3-cmdq.o
> +
> +obj-$(CONFIG_VIDEO_MEDIATEK_MDP3) += mtk-mdp3.o
> \ No newline at end of file

Hello Moudy,

I think you should fix "\ No newline at end of file".

BRs,
Rex

