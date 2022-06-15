Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8434254D212
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 21:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350142AbiFOTz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 15:55:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243859AbiFOTzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 15:55:23 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03D562AE19
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 12:55:20 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id 89so9890782qvc.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 12:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20210112.gappssmtp.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :content-transfer-encoding:user-agent:mime-version;
        bh=V5JIc+5dNK1atqPHmDQIc7wBHclTkuhMw+ntqX4B5rs=;
        b=ZGcI1op+K+MsKdeFAf5fLkpxMJifaBoJMzQuRmUKd2WB+iwT7nnofcBbPNGt3P9tRG
         rbdGdC8VdgbXERltf21hCRZesLa3DzHL/fYq5f2T/bv2Ly8dtwUBBkkO4rJENxlcESDq
         70y+ZFkAK8WcBBIvkUnaFCkEx4NPhnvzrLE1P3avHuIa+Uzf9ZtRbFn378uxjXFN79JE
         evjrs8hRhIlMtPGdalccK5cyOXL77wNzOt7SHgxukJWztlkhuLpTbY6XCaI9p4FHRnhx
         I8Yx0jrTWGNz2xV1ISTljQdBJD+tWQWBXAhL/OfQROCYrgZWRJ2432sr6NQqbtfGf/24
         /TBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-transfer-encoding:user-agent:mime-version;
        bh=V5JIc+5dNK1atqPHmDQIc7wBHclTkuhMw+ntqX4B5rs=;
        b=LSH8ka0Oyz/FYBM/acW8mUraptQRbdomaV5SpaF/XY3RA3CEdkC8//XQ/wuoN5AL12
         VUJKsNfmydxTmWTFwqJy8LASjDTDuehcZt2ei1lKdcPU8NcSMUfFFGXy+cqOsO6b8qTL
         s7dB5sHh5qrU61eEoM3QIkbuVgdhInOhn5+d1mXBi7AGLa2A+at+HgJOHYKYOx8FzK7Z
         lnsJa/sxCeZIAClZSPLeYJ4rCmnSDVJ5dAMcZwQHcVN0BuxBZMpqXSeJkiA8AWT7Ssgr
         DCHemtTPaDLVAJwb16rmOJFGmCA9nhd5n0SYsCjyfQq/pHkAGVhmuLbyEmpKlceT32QX
         fFEQ==
X-Gm-Message-State: AJIora+0tlaQMAvhsENy6s8DcG25JQEWq5/aSQIOM4713dRTAfA4yL7d
        sOWdNfFFkYi3kqw925Ap/IQgtw==
X-Google-Smtp-Source: AGRyM1ve0eBOGRemSxGnoS5W61J4sda6ud25Csrm6IncqrDK7waNZEahDVuOl4D4eoVxJHf0UF2c3A==
X-Received: by 2002:a05:622a:1aa1:b0:305:ad7:229f with SMTP id s33-20020a05622a1aa100b003050ad7229fmr1137181qtc.45.1655322918084;
        Wed, 15 Jun 2022 12:55:18 -0700 (PDT)
Received: from nicolas-tpx395.localdomain (192-222-136-102.qc.cable.ebox.net. [192.222.136.102])
        by smtp.gmail.com with ESMTPSA id s12-20020a05620a0bcc00b006a6ae636ce0sm7551844qki.131.2022.06.15.12.55.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 12:55:17 -0700 (PDT)
Message-ID: <2735b66aef88ef5dc623702d27efc3a931d2fdd3.camel@ndufresne.ca>
Subject: Re: [V1] media: mtk-mdp3: Add Mediatek MDP3 Driver
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Moudy Ho <moudy.ho@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     Maoguang Meng <maoguang.meng@mediatek.com>,
        Hsin-Yi Wang <hsinyi@google.com>,
        daoyuan huang <daoyuan.huang@mediatek.com>,
        Ping-Hsun Wu <ping-hsun.wu@mediatek.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Rob Landley <rob@landley.net>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        tfiga@chromium.org, drinkcat@chromium.org, acourbot@chromium.org,
        pihsun@chromium.org, menghui.lin@mediatek.com,
        sj.huang@mediatek.com, ben.lok@mediatek.com, randy.wu@mediatek.com,
        srv_heupstream@mediatek.com, Rex-BC Chen <Rex-BC.Chen@mediatek.com>
Date:   Wed, 15 Jun 2022 15:55:14 -0400
In-Reply-To: <20210623091457.18002-1-moudy.ho@mediatek.com>
References: <20210623091457.18002-1-moudy.ho@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1 (3.44.1-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le mercredi 23 juin 2021 =C3=A0 17:14 +0800, Moudy Ho a =C3=A9crit=C2=A0:
> From: mtk18742 <moudy.ho@mediatek.com>
>=20
> Add MDP3 driver for MT8183
>=20
> Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>
> ---
>  drivers/media/platform/Kconfig                |   17 +
>  drivers/media/platform/Makefile               |    2 +
>  drivers/media/platform/mtk-mdp3/Makefile      |    9 +
>  drivers/media/platform/mtk-mdp3/isp_reg.h     |   37 +
>  .../media/platform/mtk-mdp3/mdp-platform.h    |   58 +
>  .../media/platform/mtk-mdp3/mdp_reg_ccorr.h   |   75 +
>  .../media/platform/mtk-mdp3/mdp_reg_rdma.h    |  206 +++
>  drivers/media/platform/mtk-mdp3/mdp_reg_rsz.h |  109 ++
>  .../media/platform/mtk-mdp3/mdp_reg_wdma.h    |  125 ++
>  .../media/platform/mtk-mdp3/mdp_reg_wrot.h    |  115 ++
>  .../media/platform/mtk-mdp3/mmsys_config.h    |  188 +++
>  drivers/media/platform/mtk-mdp3/mmsys_mutex.h |   35 +
>  .../media/platform/mtk-mdp3/mmsys_reg_base.h  |   38 +
>  drivers/media/platform/mtk-mdp3/mtk-img-ipi.h |  282 ++++
>  .../media/platform/mtk-mdp3/mtk-mdp3-cmdq.c   |  538 ++++++
>  .../media/platform/mtk-mdp3/mtk-mdp3-cmdq.h   |   53 +
>  .../media/platform/mtk-mdp3/mtk-mdp3-comp.c   | 1437 +++++++++++++++++
>  .../media/platform/mtk-mdp3/mtk-mdp3-comp.h   |  157 ++
>  .../media/platform/mtk-mdp3/mtk-mdp3-core.c   |  266 +++
>  .../media/platform/mtk-mdp3/mtk-mdp3-core.h   |   86 +
>  .../media/platform/mtk-mdp3/mtk-mdp3-debug.c  |  973 +++++++++++
>  .../media/platform/mtk-mdp3/mtk-mdp3-debug.h  |   39 +
>  .../media/platform/mtk-mdp3/mtk-mdp3-m2m.c    |  803 +++++++++
>  .../media/platform/mtk-mdp3/mtk-mdp3-m2m.h    |   42 +
>  .../media/platform/mtk-mdp3/mtk-mdp3-regs.c   |  748 +++++++++
>  .../media/platform/mtk-mdp3/mtk-mdp3-regs.h   |  373 +++++
>  .../media/platform/mtk-mdp3/mtk-mdp3-vpu.c    |  313 ++++
>  .../media/platform/mtk-mdp3/mtk-mdp3-vpu.h    |   79 +
>  28 files changed, 7203 insertions(+)
>  create mode 100644 drivers/media/platform/mtk-mdp3/Makefile
>  create mode 100644 drivers/media/platform/mtk-mdp3/isp_reg.h
>  create mode 100644 drivers/media/platform/mtk-mdp3/mdp-platform.h
>  create mode 100644 drivers/media/platform/mtk-mdp3/mdp_reg_ccorr.h
>  create mode 100644 drivers/media/platform/mtk-mdp3/mdp_reg_rdma.h
>  create mode 100644 drivers/media/platform/mtk-mdp3/mdp_reg_rsz.h
>  create mode 100644 drivers/media/platform/mtk-mdp3/mdp_reg_wdma.h
>  create mode 100644 drivers/media/platform/mtk-mdp3/mdp_reg_wrot.h
>  create mode 100644 drivers/media/platform/mtk-mdp3/mmsys_config.h
>  create mode 100644 drivers/media/platform/mtk-mdp3/mmsys_mutex.h
>  create mode 100644 drivers/media/platform/mtk-mdp3/mmsys_reg_base.h
>  create mode 100644 drivers/media/platform/mtk-mdp3/mtk-img-ipi.h
>  create mode 100644 drivers/media/platform/mtk-mdp3/mtk-mdp3-cmdq.c
>  create mode 100644 drivers/media/platform/mtk-mdp3/mtk-mdp3-cmdq.h
>  create mode 100644 drivers/media/platform/mtk-mdp3/mtk-mdp3-comp.c
>  create mode 100644 drivers/media/platform/mtk-mdp3/mtk-mdp3-comp.h
>  create mode 100644 drivers/media/platform/mtk-mdp3/mtk-mdp3-core.c
>  create mode 100644 drivers/media/platform/mtk-mdp3/mtk-mdp3-core.h
>  create mode 100644 drivers/media/platform/mtk-mdp3/mtk-mdp3-debug.c
>  create mode 100644 drivers/media/platform/mtk-mdp3/mtk-mdp3-debug.h
>  create mode 100644 drivers/media/platform/mtk-mdp3/mtk-mdp3-m2m.c
>  create mode 100644 drivers/media/platform/mtk-mdp3/mtk-mdp3-m2m.h
>  create mode 100644 drivers/media/platform/mtk-mdp3/mtk-mdp3-regs.c
>  create mode 100644 drivers/media/platform/mtk-mdp3/mtk-mdp3-regs.h
>  create mode 100644 drivers/media/platform/mtk-mdp3/mtk-mdp3-vpu.c
>  create mode 100644 drivers/media/platform/mtk-mdp3/mtk-mdp3-vpu.h
>=20
> diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kcon=
fig
> index 157c924686e4..dd2d3f0f732f 100644
> --- a/drivers/media/platform/Kconfig
> +++ b/drivers/media/platform/Kconfig
> @@ -299,6 +299,23 @@ config VIDEO_MEDIATEK_MDP
>  	    To compile this driver as a module, choose M here: the
>  	    module will be called mtk-mdp.
> =20
> +config VIDEO_MEDIATEK_MDP3
> +	tristate "Mediatek MDP3 driver"
> +	depends on MTK_IOMMU || COMPILE_TEST
> +	depends on VIDEO_DEV && VIDEO_V4L2
> +	depends on ARCH_MEDIATEK || COMPILE_TEST
> +	depends on MTK_SCP && MTK_CMDQ
> +	select VIDEOBUF2_DMA_CONTIG
> +	select V4L2_MEM2MEM_DEV
> +	select VIDEO_MEDIATEK_VPU
> +	help
> +	    It is a v4l2 driver and present in Mediatek MT8183 SoCs.
> +	    The driver supports for scaling and color space conversion.
> +	    Supports ISP PASS2(DIP) direct link for yuv image output.
> +
> +	    To compile this driver as a module, choose M here: the
> +	    module will be called mtk-mdp3.
> +
>  config VIDEO_MEDIATEK_VCODEC
>  	tristate "Mediatek Video Codec driver"
>  	depends on MTK_IOMMU || COMPILE_TEST
> diff --git a/drivers/media/platform/Makefile b/drivers/media/platform/Mak=
efile
> index eedc14aafb32..4d65f8fb75f6 100644
> --- a/drivers/media/platform/Makefile
> +++ b/drivers/media/platform/Makefile
> @@ -76,6 +76,8 @@ obj-$(CONFIG_VIDEO_MEDIATEK_VCODEC)	+=3D mtk-vcodec/
> =20
>  obj-$(CONFIG_VIDEO_MEDIATEK_MDP)	+=3D mtk-mdp/
> =20
> +obj-$(CONFIG_VIDEO_MEDIATEK_MDP3)	+=3D mtk-mdp3/
> +
>  obj-$(CONFIG_VIDEO_MEDIATEK_JPEG)	+=3D mtk-jpeg/
> =20
>  obj-$(CONFIG_VIDEO_QCOM_CAMSS)		+=3D qcom/camss/
> diff --git a/drivers/media/platform/mtk-mdp3/Makefile b/drivers/media/pla=
tform/mtk-mdp3/Makefile
> new file mode 100644
> index 000000000000..3c1ccb36ea9f
> --- /dev/null
> +++ b/drivers/media/platform/mtk-mdp3/Makefile
> @@ -0,0 +1,9 @@
> +# SPDX-License-Identifier: GPL-2.0
> +mtk-mdp3-y +=3D mtk-mdp3-core.o mtk-mdp3-vpu.o mtk-mdp3-regs.o
> +mtk-mdp3-y +=3D mtk-mdp3-m2m.o
> +mtk-mdp3-y +=3D mtk-mdp3-comp.o mtk-mdp3-cmdq.o
> +
> +mtk-mdp3-y +=3D mtk-mdp3-debug.o
> +
> +obj-$(CONFIG_VIDEO_MEDIATEK_MDP3) +=3D mtk-mdp3.o
> +
> diff --git a/drivers/media/platform/mtk-mdp3/isp_reg.h b/drivers/media/pl=
atform/mtk-mdp3/isp_reg.h
> new file mode 100644
> index 000000000000..a8b2f22bae8c
> --- /dev/null
> +++ b/drivers/media/platform/mtk-mdp3/isp_reg.h
> @@ -0,0 +1,37 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2019 MediaTek Inc.
> + * Author: Ping-Hsun Wu <ping-hsun.wu@mediatek.com>
> + */
> +
> +#ifndef __ISP_REG_H__
> +#define __ISP_REG_H__
> +
> +enum ISP_DIP_CQ {
> +	ISP_DRV_DIP_CQ_THRE0 =3D 0,
> +	ISP_DRV_DIP_CQ_THRE1,
> +	ISP_DRV_DIP_CQ_THRE2,
> +	ISP_DRV_DIP_CQ_THRE3,
> +	ISP_DRV_DIP_CQ_THRE4,
> +	ISP_DRV_DIP_CQ_THRE5,
> +	ISP_DRV_DIP_CQ_THRE6,
> +	ISP_DRV_DIP_CQ_THRE7,
> +	ISP_DRV_DIP_CQ_THRE8,
> +	ISP_DRV_DIP_CQ_THRE9,
> +	ISP_DRV_DIP_CQ_THRE10,
> +	ISP_DRV_DIP_CQ_THRE11,
> +	ISP_DRV_DIP_CQ_NUM,
> +	ISP_DRV_DIP_CQ_NONE,
> +	/* we only need 12 CQ threads in this chip,
> +	 *so we move the following enum behind ISP_DRV_DIP_CQ_NUM
> +	 */
> +	ISP_DRV_DIP_CQ_THRE12,
> +	ISP_DRV_DIP_CQ_THRE13,
> +	ISP_DRV_DIP_CQ_THRE14,
> +	ISP_DRV_DIP_CQ_THRE15,	/* CQ_THREAD15 does not connect to GCE */
> +	ISP_DRV_DIP_CQ_THRE16,	/* CQ_THREAD16 does not connect to GCE */
> +	ISP_DRV_DIP_CQ_THRE17,	/* CQ_THREAD17 does not connect to GCE */
> +	ISP_DRV_DIP_CQ_THRE18,	/* CQ_THREAD18 does not connect to GCE */
> +};
> +
> +#endif  // __ISP_REG_H__
> diff --git a/drivers/media/platform/mtk-mdp3/mdp-platform.h b/drivers/med=
ia/platform/mtk-mdp3/mdp-platform.h
> new file mode 100644
> index 000000000000..d474580306b7
> --- /dev/null
> +++ b/drivers/media/platform/mtk-mdp3/mdp-platform.h
> @@ -0,0 +1,58 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2018 MediaTek Inc.
> + * Author: Ping-Hsun Wu <ping-hsun.wu@mediatek.com>
> + */
> +
> +#ifndef __MDP_PLATFORM_H__
> +#define __MDP_PLATFORM_H__
> +
> +#include "mtk-mdp3-comp.h"
> +
> +/* CAM */
> +#define MDP_WPEI           MDP_COMP_WPEI
> +#define MDP_WPEO           MDP_COMP_WPEO
> +#define MDP_WPEI2          MDP_COMP_WPEI2
> +#define MDP_WPEO2          MDP_COMP_WPEO2
> +#define MDP_IMGI           MDP_COMP_ISP_IMGI
> +#define MDP_IMGO           MDP_COMP_ISP_IMGO
> +#define MDP_IMG2O          MDP_COMP_ISP_IMG2O
> +
> +/* IPU */
> +#define MDP_IPUI           MDP_COMP_NONE
> +#define MDP_IPUO           MDP_COMP_NONE
> +
> +/* MDP */
> +#define MDP_CAMIN          MDP_COMP_CAMIN
> +#define MDP_CAMIN2         MDP_COMP_CAMIN2
> +#define MDP_RDMA0          MDP_COMP_RDMA0
> +#define MDP_RDMA1          MDP_COMP_NONE
> +#define MDP_AAL0           MDP_COMP_AAL0
> +#define MDP_CCORR0         MDP_COMP_CCORR0
> +#define MDP_SCL0           MDP_COMP_RSZ0
> +#define MDP_SCL1           MDP_COMP_RSZ1
> +#define MDP_SCL2           MDP_COMP_NONE
> +#define MDP_TDSHP0         MDP_COMP_TDSHP0
> +#define MDP_COLOR0         MDP_COMP_COLOR0
> +#define MDP_WROT0          MDP_COMP_WROT0
> +#define MDP_WROT1          MDP_COMP_NONE
> +#define MDP_WDMA           MDP_COMP_WDMA
> +#define MDP_PATH0_SOUT     MDP_COMP_PATH0_SOUT
> +#define MDP_PATH1_SOUT     MDP_COMP_PATH1_SOUT
> +
> +#define MDP_TOTAL          (MDP_COMP_WDMA + 1)
> +
> +/* Platform options */
> +#define ESL_SETTING			1
> +#define RDMA_SUPPORT_10BIT		1
> +#define RDMA0_RSZ1_SRAM_SHARING		1
> +#define RDMA_UPSAMPLE_REPEAT_ONLY	1
> +#define RSZ_DISABLE_DCM_SMALL_TILE	0
> +#define WROT_FILTER_CONSTRAINT		0
> +#define WROT0_DISP_SRAM_SHARING		0
> +
> +#define MM_MUTEX_MOD_OFFSET	0x30
> +#define MM_MUTEX_SOF_OFFSET	0x2c
> +
> +#endif  /* __MDP_PLATFORM_H__ */
> +
> diff --git a/drivers/media/platform/mtk-mdp3/mdp_reg_ccorr.h b/drivers/me=
dia/platform/mtk-mdp3/mdp_reg_ccorr.h
> new file mode 100644
> index 000000000000..2e8624446502
> --- /dev/null
> +++ b/drivers/media/platform/mtk-mdp3/mdp_reg_ccorr.h
> @@ -0,0 +1,75 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2019 MediaTek Inc.
> + * Author: Ping-Hsun Wu <ping-hsun.wu@mediatek.com>
> + */
> +
> +#ifndef __MDP_REG_CCORR_H__
> +#define __MDP_REG_CCORR_H__
> +
> +#include "mmsys_reg_base.h"
> +
> +#define MDP_CCORR_EN                0x000
> +#define MDP_CCORR_RESET             0x004
> +#define MDP_CCORR_INTEN             0x008
> +#define MDP_CCORR_INTSTA            0x00c
> +#define MDP_CCORR_STATUS            0x010
> +#define MDP_CCORR_CFG               0x020
> +#define MDP_CCORR_INPUT_COUNT       0x024
> +#define MDP_CCORR_OUTPUT_COUNT      0x028
> +#define MDP_CCORR_CHKSUM            0x02c
> +#define MDP_CCORR_SIZE              0x030
> +#define MDP_CCORR_Y2R_00            0x034
> +#define MDP_CCORR_Y2R_01            0x038
> +#define MDP_CCORR_Y2R_02            0x03c
> +#define MDP_CCORR_Y2R_03            0x040
> +#define MDP_CCORR_Y2R_04            0x044
> +#define MDP_CCORR_Y2R_05            0x048
> +#define MDP_CCORR_R2Y_00            0x04c
> +#define MDP_CCORR_R2Y_01            0x050
> +#define MDP_CCORR_R2Y_02            0x054
> +#define MDP_CCORR_R2Y_03            0x058
> +#define MDP_CCORR_R2Y_04            0x05c
> +#define MDP_CCORR_R2Y_05            0x060
> +#define MDP_CCORR_COEF_0            0x080
> +#define MDP_CCORR_COEF_1            0x084
> +#define MDP_CCORR_COEF_2            0x088
> +#define MDP_CCORR_COEF_3            0x08c
> +#define MDP_CCORR_COEF_4            0x090
> +#define MDP_CCORR_SHADOW            0x0a0
> +#define MDP_CCORR_DUMMY_REG         0x0c0
> +#define MDP_CCORR_ATPG              0x0fc
> +
> +/* MASK */
> +#define MDP_CCORR_EN_MASK           0x00000001
> +#define MDP_CCORR_RESET_MASK        0x00000001
> +#define MDP_CCORR_INTEN_MASK        0x00000003
> +#define MDP_CCORR_INTSTA_MASK       0x00000003
> +#define MDP_CCORR_STATUS_MASK       0xfffffff3
> +#define MDP_CCORR_CFG_MASK          0x70001317
> +#define MDP_CCORR_INPUT_COUNT_MASK  0x1fff1fff
> +#define MDP_CCORR_OUTPUT_COUNT_MASK 0x1fff1fff
> +#define MDP_CCORR_CHKSUM_MASK       0xffffffff
> +#define MDP_CCORR_SIZE_MASK         0x1fff1fff
> +#define MDP_CCORR_Y2R_00_MASK       0x01ff01ff
> +#define MDP_CCORR_Y2R_01_MASK       0x1fff01ff
> +#define MDP_CCORR_Y2R_02_MASK       0x1fff1fff
> +#define MDP_CCORR_Y2R_03_MASK       0x1fff1fff
> +#define MDP_CCORR_Y2R_04_MASK       0x1fff1fff
> +#define MDP_CCORR_Y2R_05_MASK       0x1fff1fff
> +#define MDP_CCORR_R2Y_00_MASK       0x01ff01ff
> +#define MDP_CCORR_R2Y_01_MASK       0x07ff01ff
> +#define MDP_CCORR_R2Y_02_MASK       0x07ff07ff
> +#define MDP_CCORR_R2Y_03_MASK       0x07ff07ff
> +#define MDP_CCORR_R2Y_04_MASK       0x07ff07ff
> +#define MDP_CCORR_R2Y_05_MASK       0x07ff07ff
> +#define MDP_CCORR_COEF_0_MASK       0x1fff1fff
> +#define MDP_CCORR_COEF_1_MASK       0x1fff1fff
> +#define MDP_CCORR_COEF_2_MASK       0x1fff1fff
> +#define MDP_CCORR_COEF_3_MASK       0x1fff1fff
> +#define MDP_CCORR_COEF_4_MASK       0x1fff1fff
> +#define MDP_CCORR_SHADOW_MASK       0x00000007
> +#define MDP_CCORR_DUMMY_REG_MASK    0xffffffff
> +#define MDP_CCORR_ATPG_MASK         0x00000003
> +
> +#endif  // __MDP_REG_CCORR_H__
> diff --git a/drivers/media/platform/mtk-mdp3/mdp_reg_rdma.h b/drivers/med=
ia/platform/mtk-mdp3/mdp_reg_rdma.h
> new file mode 100644
> index 000000000000..d7f5d9275d6d
> --- /dev/null
> +++ b/drivers/media/platform/mtk-mdp3/mdp_reg_rdma.h
> @@ -0,0 +1,206 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2019 MediaTek Inc.
> + * Author: Ping-Hsun Wu <ping-hsun.wu@mediatek.com>
> + */
> +
> +#ifndef __MDP_REG_RDMA_H__
> +#define __MDP_REG_RDMA_H__
> +
> +#include "mmsys_reg_base.h"
> +
> +#define MDP_RDMA_EN                     0x000
> +#define MDP_RDMA_RESET                  0x008
> +#define MDP_RDMA_INTERRUPT_ENABLE       0x010
> +#define MDP_RDMA_INTERRUPT_STATUS       0x018
> +#define MDP_RDMA_CON                    0x020
> +#define MDP_RDMA_GMCIF_CON              0x028
> +#define MDP_RDMA_SRC_CON                0x030
> +#define MDP_RDMA_SRC_BASE_0             0xf00
> +#define MDP_RDMA_SRC_BASE_1             0xf08
> +#define MDP_RDMA_SRC_BASE_2             0xf10
> +#define MDP_RDMA_UFO_DEC_LENGTH_BASE_Y  0xf20
> +#define MDP_RDMA_UFO_DEC_LENGTH_BASE_C  0xf28
> +#define MDP_RDMA_MF_BKGD_SIZE_IN_BYTE   0x060
> +#define MDP_RDMA_MF_BKGD_SIZE_IN_PXL    0x068
> +#define MDP_RDMA_MF_SRC_SIZE            0x070
> +#define MDP_RDMA_MF_CLIP_SIZE           0x078
> +#define MDP_RDMA_MF_OFFSET_1            0x080
> +#define MDP_RDMA_MF_PAR                 0x088
> +#define MDP_RDMA_SF_BKGD_SIZE_IN_BYTE   0x090
> +#define MDP_RDMA_SF_PAR                 0x0b8
> +#define MDP_RDMA_MB_DEPTH               0x0c0
> +#define MDP_RDMA_MB_BASE                0x0c8
> +#define MDP_RDMA_MB_CON                 0x0d0
> +#define MDP_RDMA_SB_DEPTH               0x0d8
> +#define MDP_RDMA_SB_BASE                0x0e0
> +#define MDP_RDMA_SB_CON                 0x0e8
> +#define MDP_RDMA_VC1_RANGE              0x0f0
> +#define MDP_RDMA_SRC_END_0              0x100
> +#define MDP_RDMA_SRC_END_1              0x108
> +#define MDP_RDMA_SRC_END_2              0x110
> +#define MDP_RDMA_SRC_OFFSET_0           0x118
> +#define MDP_RDMA_SRC_OFFSET_1           0x120
> +#define MDP_RDMA_SRC_OFFSET_2           0x128
> +#define MDP_RDMA_SRC_OFFSET_W_0         0x130
> +#define MDP_RDMA_SRC_OFFSET_W_1         0x138
> +#define MDP_RDMA_SRC_OFFSET_W_2         0x140
> +#define MDP_RDMA_SRC_OFFSET_0_P         0x148
> +#define MDP_RDMA_TRANSFORM_0            0x200
> +#define MDP_RDMA_TRANSFORM_1            0x208
> +#define MDP_RDMA_TRANSFORM_2            0x210
> +#define MDP_RDMA_TRANSFORM_3            0x218
> +#define MDP_RDMA_TRANSFORM_4            0x220
> +#define MDP_RDMA_TRANSFORM_5            0x228
> +#define MDP_RDMA_TRANSFORM_6            0x230
> +#define MDP_RDMA_TRANSFORM_7            0x238
> +#define MDP_RDMA_DMABUF_CON_0           0x240
> +#define MDP_RDMA_DMAULTRA_CON_0         0x248
> +#define MDP_RDMA_DMABUF_CON_1           0x250
> +#define MDP_RDMA_DMAULTRA_CON_1         0x258
> +#define MDP_RDMA_DMABUF_CON_2           0x260
> +#define MDP_RDMA_DMAULTRA_CON_2         0x268
> +#define MDP_RDMA_DITHER_CON             0x288
> +#define MDP_RDMA_RESV_DUMMY_0           0x2a0
> +#define MDP_RDMA_CHKS_EXTR              0x300
> +#define MDP_RDMA_CHKS_INTW              0x308
> +#define MDP_RDMA_CHKS_INTR              0x310
> +#define MDP_RDMA_CHKS_ROTO              0x318
> +#define MDP_RDMA_CHKS_SRIY              0x320
> +#define MDP_RDMA_CHKS_SRIU              0x328
> +#define MDP_RDMA_CHKS_SRIV              0x330
> +#define MDP_RDMA_CHKS_SROY              0x338
> +#define MDP_RDMA_CHKS_SROU              0x340
> +#define MDP_RDMA_CHKS_SROV              0x348
> +#define MDP_RDMA_CHKS_VUPI              0x350
> +#define MDP_RDMA_CHKS_VUPO              0x358
> +#define MDP_RDMA_DEBUG_CON              0x380
> +#define MDP_RDMA_MON_STA_0              0x400
> +#define MDP_RDMA_MON_STA_1              0x408
> +#define MDP_RDMA_MON_STA_2              0x410
> +#define MDP_RDMA_MON_STA_3              0x418
> +#define MDP_RDMA_MON_STA_4              0x420
> +#define MDP_RDMA_MON_STA_5              0x428
> +#define MDP_RDMA_MON_STA_6              0x430
> +#define MDP_RDMA_MON_STA_7              0x438
> +#define MDP_RDMA_MON_STA_8              0x440
> +#define MDP_RDMA_MON_STA_9              0x448
> +#define MDP_RDMA_MON_STA_10             0x450
> +#define MDP_RDMA_MON_STA_11             0x458
> +#define MDP_RDMA_MON_STA_12             0x460
> +#define MDP_RDMA_MON_STA_13             0x468
> +#define MDP_RDMA_MON_STA_14             0x470
> +#define MDP_RDMA_MON_STA_15             0x478
> +#define MDP_RDMA_MON_STA_16             0x480
> +#define MDP_RDMA_MON_STA_17             0x488
> +#define MDP_RDMA_MON_STA_18             0x490
> +#define MDP_RDMA_MON_STA_19             0x498
> +#define MDP_RDMA_MON_STA_20             0x4a0
> +#define MDP_RDMA_MON_STA_21             0x4a8
> +#define MDP_RDMA_MON_STA_22             0x4b0
> +#define MDP_RDMA_MON_STA_23             0x4b8
> +#define MDP_RDMA_MON_STA_24             0x4c0
> +#define MDP_RDMA_MON_STA_25             0x4c8
> +#define MDP_RDMA_MON_STA_26             0x4d0
> +#define MDP_RDMA_MON_STA_27             0x4d8
> +#define MDP_RDMA_MON_STA_28             0x4e0
> +
> +/* MASK */
> +#define MDP_RDMA_EN_MASK                    0x00000001
> +#define MDP_RDMA_RESET_MASK                 0x00000001
> +#define MDP_RDMA_INTERRUPT_ENABLE_MASK      0x00000007
> +#define MDP_RDMA_INTERRUPT_STATUS_MASK      0x00000007
> +#define MDP_RDMA_CON_MASK                   0x00001110
> +#define MDP_RDMA_GMCIF_CON_MASK             0xfffb3771
> +#define MDP_RDMA_SRC_CON_MASK               0xf3ffffff
> +#define MDP_RDMA_SRC_BASE_0_MASK            0xffffffff
> +#define MDP_RDMA_SRC_BASE_1_MASK            0xffffffff
> +#define MDP_RDMA_SRC_BASE_2_MASK            0xffffffff
> +#define MDP_RDMA_UFO_DEC_LENGTH_BASE_Y_MASK 0xffffffff
> +#define MDP_RDMA_UFO_DEC_LENGTH_BASE_C_MASK 0xffffffff
> +#define MDP_RDMA_MF_BKGD_SIZE_IN_BYTE_MASK  0x001fffff
> +#define MDP_RDMA_MF_BKGD_SIZE_IN_PXL_MASK   0x001fffff
> +#define MDP_RDMA_MF_SRC_SIZE_MASK           0x1fff1fff
> +#define MDP_RDMA_MF_CLIP_SIZE_MASK          0x1fff1fff
> +#define MDP_RDMA_MF_OFFSET_1_MASK           0x003f001f
> +#define MDP_RDMA_MF_PAR_MASK                0x1ffff3ff
> +#define MDP_RDMA_SF_BKGD_SIZE_IN_BYTE_MASK  0x001fffff
> +#define MDP_RDMA_SF_PAR_MASK                0x1ffff3ff
> +#define MDP_RDMA_MB_DEPTH_MASK              0x0000007f
> +#define MDP_RDMA_MB_BASE_MASK               0x0000ffff
> +#define MDP_RDMA_MB_CON_MASK                0x3fff1fff
> +#define MDP_RDMA_SB_DEPTH_MASK              0x0000007f
> +#define MDP_RDMA_SB_BASE_MASK               0x0000ffff
> +#define MDP_RDMA_SB_CON_MASK                0x3fff1fff
> +#define MDP_RDMA_VC1_RANGE_MASK             0x001f1f11
> +#define MDP_RDMA_SRC_END_0_MASK             0xffffffff
> +#define MDP_RDMA_SRC_END_1_MASK             0xffffffff
> +#define MDP_RDMA_SRC_END_2_MASK             0xffffffff
> +#define MDP_RDMA_SRC_OFFSET_0_MASK          0xffffffff
> +#define MDP_RDMA_SRC_OFFSET_1_MASK          0xffffffff
> +#define MDP_RDMA_SRC_OFFSET_2_MASK          0xffffffff
> +#define MDP_RDMA_SRC_OFFSET_W_0_MASK        0x0000ffff
> +#define MDP_RDMA_SRC_OFFSET_W_1_MASK        0x0000ffff
> +#define MDP_RDMA_SRC_OFFSET_W_2_MASK        0x0000ffff
> +#define MDP_RDMA_SRC_OFFSET_0_P_MASK        0xffffffff
> +#define MDP_RDMA_TRANSFORM_0_MASK           0xff110777
> +#define MDP_RDMA_TRANSFORM_1_MASK           0x1ff7fdff
> +#define MDP_RDMA_TRANSFORM_2_MASK           0x1ff7fdff
> +#define MDP_RDMA_TRANSFORM_3_MASK           0x1fff1fff
> +#define MDP_RDMA_TRANSFORM_4_MASK           0x1fff1fff
> +#define MDP_RDMA_TRANSFORM_5_MASK           0x1fff1fff
> +#define MDP_RDMA_TRANSFORM_6_MASK           0x1fff1fff
> +#define MDP_RDMA_TRANSFORM_7_MASK           0x00001fff
> +#define MDP_RDMA_DMABUF_CON_0_MASK          0x077f007f
> +#define MDP_RDMA_DMAULTRA_CON_0_MASK        0x7f7f7f7f
> +#define MDP_RDMA_DMABUF_CON_1_MASK          0x073f003f
> +#define MDP_RDMA_DMAULTRA_CON_1_MASK        0x3f3f3f3f
> +#define MDP_RDMA_DMABUF_CON_2_MASK          0x071f001f
> +#define MDP_RDMA_DMAULTRA_CON_2_MASK        0x1f1f1f1f
> +
> +#define MDP_RDMA_DITHER_CON_MASK            0xffffffff
> +#define MDP_RDMA_RESV_DUMMY_0_MASK          0xffffffff
> +#define MDP_RDMA_CHKS_EXTR_MASK             0xffffff01
> +#define MDP_RDMA_CHKS_INTW_MASK             0xffffff01
> +#define MDP_RDMA_CHKS_INTR_MASK             0xffffff01
> +#define MDP_RDMA_CHKS_ROTO_MASK             0xffffff01
> +#define MDP_RDMA_CHKS_SRIY_MASK             0xffffff01
> +#define MDP_RDMA_CHKS_SRIU_MASK             0xffffff01
> +#define MDP_RDMA_CHKS_SRIV_MASK             0xffffff01
> +#define MDP_RDMA_CHKS_SROY_MASK             0xffffff01
> +#define MDP_RDMA_CHKS_SROU_MASK             0xffffff01
> +#define MDP_RDMA_CHKS_SROV_MASK             0xffffff01
> +#define MDP_RDMA_CHKS_VUPI_MASK             0xffffff01
> +#define MDP_RDMA_CHKS_VUPO_MASK             0xffffff01
> +#define MDP_RDMA_DEBUG_CON_MASK             0x00001f11
> +#define MDP_RDMA_MON_STA_0_MASK             0xffffffff
> +#define MDP_RDMA_MON_STA_1_MASK             0xffffffff
> +#define MDP_RDMA_MON_STA_2_MASK             0xffffffff
> +#define MDP_RDMA_MON_STA_3_MASK             0xffffffff
> +#define MDP_RDMA_MON_STA_4_MASK             0xffffffff
> +#define MDP_RDMA_MON_STA_5_MASK             0xffffffff
> +#define MDP_RDMA_MON_STA_6_MASK             0xffffffff
> +#define MDP_RDMA_MON_STA_7_MASK             0xffffffff
> +#define MDP_RDMA_MON_STA_8_MASK             0xffffffff
> +#define MDP_RDMA_MON_STA_9_MASK             0xffffffff
> +#define MDP_RDMA_MON_STA_10_MASK            0xffffffff
> +#define MDP_RDMA_MON_STA_11_MASK            0xffffffff
> +#define MDP_RDMA_MON_STA_12_MASK            0xffffffff
> +#define MDP_RDMA_MON_STA_13_MASK            0xffffffff
> +#define MDP_RDMA_MON_STA_14_MASK            0xffffffff
> +#define MDP_RDMA_MON_STA_15_MASK            0xffffffff
> +#define MDP_RDMA_MON_STA_16_MASK            0xffffffff
> +#define MDP_RDMA_MON_STA_17_MASK            0xffffffff
> +#define MDP_RDMA_MON_STA_18_MASK            0xffffffff
> +#define MDP_RDMA_MON_STA_19_MASK            0xffffffff
> +#define MDP_RDMA_MON_STA_20_MASK            0xffffffff
> +#define MDP_RDMA_MON_STA_21_MASK            0xffffffff
> +#define MDP_RDMA_MON_STA_22_MASK            0xffffffff
> +#define MDP_RDMA_MON_STA_23_MASK            0xffffffff
> +#define MDP_RDMA_MON_STA_24_MASK            0xffffffff
> +#define MDP_RDMA_MON_STA_25_MASK            0xffffffff
> +#define MDP_RDMA_MON_STA_26_MASK            0xffffffff
> +#define MDP_RDMA_MON_STA_27_MASK            0xffffffff
> +#define MDP_RDMA_MON_STA_28_MASK            0xffffffff
> +
> +#endif  // __MDP_REG_RDMA_H__
> diff --git a/drivers/media/platform/mtk-mdp3/mdp_reg_rsz.h b/drivers/medi=
a/platform/mtk-mdp3/mdp_reg_rsz.h
> new file mode 100644
> index 000000000000..7f0683f3c60d
> --- /dev/null
> +++ b/drivers/media/platform/mtk-mdp3/mdp_reg_rsz.h
> @@ -0,0 +1,109 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2019 MediaTek Inc.
> + * Author: Ping-Hsun Wu <ping-hsun.wu@mediatek.com>
> + */
> +
> +#ifndef __MDP_REG_RSZ_H__
> +#define __MDP_REG_RSZ_H__
> +
> +#include "mmsys_reg_base.h"
> +
> +#define PRZ_ENABLE                                        0x000
> +#define PRZ_CONTROL_1                                     0x004
> +#define PRZ_CONTROL_2                                     0x008
> +#define PRZ_INT_FLAG                                      0x00c
> +#define PRZ_INPUT_IMAGE                                   0x010
> +#define PRZ_OUTPUT_IMAGE                                  0x014
> +#define PRZ_HORIZONTAL_COEFF_STEP                         0x018
> +#define PRZ_VERTICAL_COEFF_STEP                           0x01c
> +#define PRZ_LUMA_HORIZONTAL_INTEGER_OFFSET                0x020
> +#define PRZ_LUMA_HORIZONTAL_SUBPIXEL_OFFSET               0x024
> +#define PRZ_LUMA_VERTICAL_INTEGER_OFFSET                  0x028
> +#define PRZ_LUMA_VERTICAL_SUBPIXEL_OFFSET                 0x02c
> +#define PRZ_CHROMA_HORIZONTAL_INTEGER_OFFSET              0x030
> +#define PRZ_CHROMA_HORIZONTAL_SUBPIXEL_OFFSET             0x034
> +#define PRZ_RSV                                           0x040
> +#define PRZ_DEBUG_SEL                                     0x044
> +#define PRZ_DEBUG                                         0x048
> +#define PRZ_TAP_ADAPT                                     0x04c
> +#define PRZ_IBSE_SOFTCLIP                                 0x050
> +#define PRZ_IBSE_YLEVEL_1                                 0x054
> +#define PRZ_IBSE_YLEVEL_2                                 0x058
> +#define PRZ_IBSE_YLEVEL_3                                 0x05c
> +#define PRZ_IBSE_YLEVEL_4                                 0x060
> +#define PRZ_IBSE_YLEVEL_5                                 0x064
> +#define PRZ_IBSE_GAINCONTROL_1                            0x068
> +#define PRZ_IBSE_GAINCONTROL_2                            0x06c
> +#define PRZ_DEMO_IN_HMASK                                 0x070
> +#define PRZ_DEMO_IN_VMASK                                 0x074
> +#define PRZ_DEMO_OUT_HMASK                                0x078
> +#define PRZ_DEMO_OUT_VMASK                                0x07c
> +#define PRZ_ATPG                                          0x0fc
> +#define PRZ_PAT1_GEN_SET                                  0x100
> +#define PRZ_PAT1_GEN_FRM_SIZE                             0x104
> +#define PRZ_PAT1_GEN_COLOR0                               0x108
> +#define PRZ_PAT1_GEN_COLOR1                               0x10c
> +#define PRZ_PAT1_GEN_COLOR2                               0x110
> +#define PRZ_PAT1_GEN_POS                                  0x114
> +#define PRZ_PAT1_GEN_TILE_POS                             0x124
> +#define PRZ_PAT1_GEN_TILE_OV                              0x128
> +#define PRZ_PAT2_GEN_SET                                  0x200
> +#define PRZ_PAT2_GEN_COLOR0                               0x208
> +#define PRZ_PAT2_GEN_COLOR1                               0x20c
> +#define PRZ_PAT2_GEN_POS                                  0x214
> +#define PRZ_PAT2_GEN_CURSOR_RB0                           0x218
> +#define PRZ_PAT2_GEN_CURSOR_RB1                           0x21c
> +#define PRZ_PAT2_GEN_TILE_POS                             0x224
> +#define PRZ_PAT2_GEN_TILE_OV                              0x228
> +
> +/* MASK */
> +#define PRZ_ENABLE_MASK                                   0x00010001
> +#define PRZ_CONTROL_1_MASK                                0xfffffff3
> +#define PRZ_CONTROL_2_MASK                                0x0ffffaff
> +#define PRZ_INT_FLAG_MASK                                 0x00000033
> +#define PRZ_INPUT_IMAGE_MASK                              0xffffffff
> +#define PRZ_OUTPUT_IMAGE_MASK                             0xffffffff
> +#define PRZ_HORIZONTAL_COEFF_STEP_MASK                    0x007fffff
> +#define PRZ_VERTICAL_COEFF_STEP_MASK                      0x007fffff
> +#define PRZ_LUMA_HORIZONTAL_INTEGER_OFFSET_MASK           0x0000ffff
> +#define PRZ_LUMA_HORIZONTAL_SUBPIXEL_OFFSET_MASK          0x001fffff
> +#define PRZ_LUMA_VERTICAL_INTEGER_OFFSET_MASK             0x0000ffff
> +#define PRZ_LUMA_VERTICAL_SUBPIXEL_OFFSET_MASK            0x001fffff
> +#define PRZ_CHROMA_HORIZONTAL_INTEGER_OFFSET_MASK         0x0000ffff
> +#define PRZ_CHROMA_HORIZONTAL_SUBPIXEL_OFFSET_MASK        0x001fffff
> +#define PRZ_RSV_MASK                                      0xffffffff
> +#define PRZ_DEBUG_SEL_MASK                                0x0000000f
> +#define PRZ_DEBUG_MASK                                    0xffffffff
> +#define PRZ_TAP_ADAPT_MASK                                0x03ffffff
> +#define PRZ_IBSE_SOFTCLIP_MASK                            0x000fffff
> +#define PRZ_IBSE_YLEVEL_1_MASK                            0xffffffff
> +#define PRZ_IBSE_YLEVEL_2_MASK                            0xffffffff
> +#define PRZ_IBSE_YLEVEL_3_MASK                            0xffffffff
> +#define PRZ_IBSE_YLEVEL_4_MASK                            0xffffffff
> +#define PRZ_IBSE_YLEVEL_5_MASK                            0x0000ff3f
> +#define PRZ_IBSE_GAINCONTROL_1_MASK                       0xffffffff
> +#define PRZ_IBSE_GAINCONTROL_2_MASK                       0x0fffff0f
> +#define PRZ_DEMO_IN_HMASK_MASK                            0xffffffff
> +#define PRZ_DEMO_IN_VMASK_MASK                            0xffffffff
> +#define PRZ_DEMO_OUT_HMASK_MASK                           0xffffffff
> +#define PRZ_DEMO_OUT_VMASK_MASK                           0xffffffff
> +#define PRZ_ATPG_MASK                                     0x00000003
> +#define PRZ_PAT1_GEN_SET_MASK                             0x00ff00fd
> +#define PRZ_PAT1_GEN_FRM_SIZE_MASK                        0x1fff1fff
> +#define PRZ_PAT1_GEN_COLOR0_MASK                          0x00ff00ff
> +#define PRZ_PAT1_GEN_COLOR1_MASK                          0x00ff00ff
> +#define PRZ_PAT1_GEN_COLOR2_MASK                          0x00ff00ff
> +#define PRZ_PAT1_GEN_POS_MASK                             0x1fff1fff
> +#define PRZ_PAT1_GEN_TILE_POS_MASK                        0x1fff1fff
> +#define PRZ_PAT1_GEN_TILE_OV_MASK                         0x0000ffff
> +#define PRZ_PAT2_GEN_SET_MASK                             0x00ff0003
> +#define PRZ_PAT2_GEN_COLOR0_MASK                          0x00ff00ff
> +#define PRZ_PAT2_GEN_COLOR1_MASK                          0x000000ff
> +#define PRZ_PAT2_GEN_POS_MASK                             0x1fff1fff
> +#define PRZ_PAT2_GEN_CURSOR_RB0_MASK                      0x00ff00ff
> +#define PRZ_PAT2_GEN_CURSOR_RB1_MASK                      0x000000ff
> +#define PRZ_PAT2_GEN_TILE_POS_MASK                        0x1fff1fff
> +#define PRZ_PAT2_GEN_TILE_OV_MASK                         0x0000ffff
> +
> +#endif // __MDP_REG_RSZ_H__
> diff --git a/drivers/media/platform/mtk-mdp3/mdp_reg_wdma.h b/drivers/med=
ia/platform/mtk-mdp3/mdp_reg_wdma.h
> new file mode 100644
> index 000000000000..c274b54c1f18
> --- /dev/null
> +++ b/drivers/media/platform/mtk-mdp3/mdp_reg_wdma.h
> @@ -0,0 +1,125 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2019 MediaTek Inc.
> + * Author: Ping-Hsun Wu <ping-hsun.wu@mediatek.com>
> + */
> +
> +#ifndef __MDP_REG_WDMA_H__
> +#define __MDP_REG_WDMA_H__
> +
> +#include "mmsys_reg_base.h"
> +
> +#define WDMA_INTEN              0x000
> +#define WDMA_INTSTA             0x004
> +#define WDMA_EN                 0x008
> +#define WDMA_RST                0x00c
> +#define WDMA_SMI_CON            0x010
> +#define WDMA_CFG                0x014
> +#define WDMA_SRC_SIZE           0x018
> +#define WDMA_CLIP_SIZE          0x01c
> +#define WDMA_CLIP_COORD         0x020
> +#define WDMA_DST_ADDR           0xf00
> +#define WDMA_DST_W_IN_BYTE      0x028
> +#define WDMA_ALPHA              0x02c
> +#define WDMA_BUF_CON1           0x038
> +#define WDMA_BUF_CON2           0x03c
> +#define WDMA_C00                0x040
> +#define WDMA_C02                0x044
> +#define WDMA_C10                0x048
> +#define WDMA_C12                0x04c
> +#define WDMA_C20                0x050
> +#define WDMA_C22                0x054
> +#define WDMA_PRE_ADD0           0x058
> +#define WDMA_PRE_ADD2           0x05c
> +#define WDMA_POST_ADD0          0x060
> +#define WDMA_POST_ADD2          0x064
> +#define WDMA_DST_U_ADDR         0xf04
> +#define WDMA_DST_V_ADDR         0xf08
> +#define WDMA_DST_UV_PITCH       0x078
> +#define WDMA_DST_ADDR_OFFSET    0x080
> +#define WDMA_DST_U_ADDR_OFFSET  0x084
> +#define WDMA_DST_V_ADDR_OFFSET  0x088
> +#define PROC_TRACK_CON_0        0x090
> +#define PROC_TRACK_CON_1        0x094
> +#define PROC_TRACK_CON_2        0x098
> +#define WDMA_FLOW_CTRL_DBG      0x0a0
> +#define WDMA_EXEC_DBG           0x0a4
> +#define WDMA_CT_DBG             0x0a8
> +#define WDMA_SMI_TRAFFIC_DBG    0x0ac
> +#define WDMA_PROC_TRACK_DBG_0   0x0b0
> +#define WDMA_PROC_TRACK_DBG_1   0x0b4
> +#define WDMA_DEBUG              0x0b8
> +#define WDMA_DUMMY              0x100
> +#define WDMA_DITHER_0           0xe00
> +#define WDMA_DITHER_5           0xe14
> +#define WDMA_DITHER_6           0xe18
> +#define WDMA_DITHER_7           0xe1c
> +#define WDMA_DITHER_8           0xe20
> +#define WDMA_DITHER_9           0xe24
> +#define WDMA_DITHER_10          0xe28
> +#define WDMA_DITHER_11          0xe2c
> +#define WDMA_DITHER_12          0xe30
> +#define WDMA_DITHER_13          0xe34
> +#define WDMA_DITHER_14          0xe38
> +#define WDMA_DITHER_15          0xe3c
> +#define WDMA_DITHER_16          0xe40
> +#define WDMA_DITHER_17          0xe44
> +
> +/* MASK */
> +#define WDMA_INTEN_MASK             0x00000003
> +#define WDMA_INTSTA_MASK            0x00000003
> +#define WDMA_EN_MASK                0x00000001
> +#define WDMA_RST_MASK               0x00000001
> +#define WDMA_SMI_CON_MASK           0x0fffffff
> +#define WDMA_CFG_MASK               0xff03bff0
> +#define WDMA_SRC_SIZE_MASK          0x3fff3fff
> +#define WDMA_CLIP_SIZE_MASK         0x3fff3fff
> +#define WDMA_CLIP_COORD_MASK        0x3fff3fff
> +#define WDMA_DST_ADDR_MASK          0xffffffff
> +#define WDMA_DST_W_IN_BYTE_MASK     0x0000ffff
> +#define WDMA_ALPHA_MASK             0x800000ff
> +#define WDMA_BUF_CON1_MASK          0xd1ff01ff
> +#define WDMA_BUF_CON2_MASK          0xffffffff
> +#define WDMA_C00_MASK               0x1fff1fff
> +#define WDMA_C02_MASK               0x00001fff
> +#define WDMA_C10_MASK               0x1fff1fff
> +#define WDMA_C12_MASK               0x00001fff
> +#define WDMA_C20_MASK               0x1fff1fff
> +#define WDMA_C22_MASK               0x00001fff
> +#define WDMA_PRE_ADD0_MASK          0x01ff01ff
> +#define WDMA_PRE_ADD2_MASK          0x000001ff
> +#define WDMA_POST_ADD0_MASK         0x01ff01ff
> +#define WDMA_POST_ADD2_MASK         0x000001ff
> +#define WDMA_DST_U_ADDR_MASK        0xffffffff
> +#define WDMA_DST_V_ADDR_MASK        0xffffffff
> +#define WDMA_DST_UV_PITCH_MASK      0x0000ffff
> +#define WDMA_DST_ADDR_OFFSET_MASK   0x0fffffff
> +#define WDMA_DST_U_ADDR_OFFSET_MASK 0x0fffffff
> +#define WDMA_DST_V_ADDR_OFFSET_MASK 0x0fffffff
> +#define PROC_TRACK_CON_0_MASK       0x70000fff
> +#define PROC_TRACK_CON_1_MASK       0x00ffffff
> +#define PROC_TRACK_CON_2_MASK       0x00ffffff
> +#define WDMA_FLOW_CTRL_DBG_MASK     0x0000f3ff
> +#define WDMA_EXEC_DBG_MASK          0x003f003f
> +#define WDMA_CT_DBG_MASK            0x3fff3fff
> +#define WDMA_SMI_TRAFFIC_DBG_MASK   0xffffffff
> +#define WDMA_PROC_TRACK_DBG_0_MASK  0xffffffff
> +#define WDMA_PROC_TRACK_DBG_1_MASK  0xffffffff
> +#define WDMA_DEBUG_MASK             0xffffffff
> +#define WDMA_DUMMY_MASK             0xffffffff
> +#define WDMA_DITHER_0_MASK          0x0111ff11
> +#define WDMA_DITHER_5_MASK          0x0000ffff
> +#define WDMA_DITHER_6_MASK          0x0001f3ff
> +#define WDMA_DITHER_7_MASK          0x00000333
> +#define WDMA_DITHER_8_MASK          0x03ff0001
> +#define WDMA_DITHER_9_MASK          0x03ff03ff
> +#define WDMA_DITHER_10_MASK         0x00000733
> +#define WDMA_DITHER_11_MASK         0x00003331
> +#define WDMA_DITHER_12_MASK         0xffff0031
> +#define WDMA_DITHER_13_MASK         0x00000777
> +#define WDMA_DITHER_14_MASK         0x00000371
> +#define WDMA_DITHER_15_MASK         0x77770001
> +#define WDMA_DITHER_16_MASK         0x77777777
> +#define WDMA_DITHER_17_MASK         0x0001ffff
> +
> +#endif  // __MDP_REG_WDMA_H__
> diff --git a/drivers/media/platform/mtk-mdp3/mdp_reg_wrot.h b/drivers/med=
ia/platform/mtk-mdp3/mdp_reg_wrot.h
> new file mode 100644
> index 000000000000..b757a288267d
> --- /dev/null
> +++ b/drivers/media/platform/mtk-mdp3/mdp_reg_wrot.h
> @@ -0,0 +1,115 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2019 MediaTek Inc.
> + * Author: Ping-Hsun Wu <ping-hsun.wu@mediatek.com>
> + */
> +
> +#ifndef __MDP_REG_WROT_H__
> +#define __MDP_REG_WROT_H__
> +
> +#include "mmsys_reg_base.h"
> +
> +#define VIDO_CTRL                   0x000
> +#define VIDO_DMA_PERF               0x004
> +#define VIDO_MAIN_BUF_SIZE          0x008
> +#define VIDO_SOFT_RST               0x010
> +#define VIDO_SOFT_RST_STAT          0x014
> +#define VIDO_INT_EN                 0x018
> +#define VIDO_INT                    0x01c
> +#define VIDO_CROP_OFST              0x020
> +#define VIDO_TAR_SIZE               0x024
> +#define VIDO_BASE_ADDR              0xf00
> +#define VIDO_OFST_ADDR              0x02c
> +#define VIDO_STRIDE                 0x030
> +#define VIDO_BASE_ADDR_C            0xf04
> +#define VIDO_OFST_ADDR_C            0x038
> +#define VIDO_STRIDE_C               0x03c
> +#define VIDO_DITHER                 0x054
> +#define VIDO_BASE_ADDR_V            0xf08
> +#define VIDO_OFST_ADDR_V            0x068
> +#define VIDO_STRIDE_V               0x06c
> +#define VIDO_RSV_1                  0x070
> +#define VIDO_DMA_PREULTRA           0x074
> +#define VIDO_IN_SIZE                0x078
> +#define VIDO_ROT_EN                 0x07c
> +#define VIDO_FIFO_TEST              0x080
> +#define VIDO_MAT_CTRL               0x084
> +#define VIDO_MAT_RMY                0x088
> +#define VIDO_MAT_RMV                0x08c
> +#define VIDO_MAT_GMY                0x090
> +#define VIDO_MAT_BMY                0x094
> +#define VIDO_MAT_BMV                0x098
> +#define VIDO_MAT_PREADD             0x09c
> +#define VIDO_MAT_POSTADD            0x0a0
> +#define VIDO_DITHER_00              0x0a4
> +#define VIDO_DITHER_02              0x0ac
> +#define VIDO_DITHER_03              0x0b0
> +#define VIDO_DITHER_04              0x0b4
> +#define VIDO_DITHER_05              0x0b8
> +#define VIDO_DITHER_06              0x0bc
> +#define VIDO_DITHER_07              0x0c0
> +#define VIDO_DITHER_08              0x0c4
> +#define VIDO_DITHER_09              0x0c8
> +#define VIDO_DITHER_10              0x0cc
> +#define VIDO_DEBUG                  0x0d0
> +#define VIDO_ARB_SW_CTL             0x0d4
> +#define MDP_WROT_TRACK_CTL          0x0e0
> +#define MDP_WROT_TRACK_WINDOW       0x0e4
> +#define MDP_WROT_TRACK_TARGET       0x0e8
> +#define MDP_WROT_TRACK_STOP         0x0ec
> +#define MDP_WROT_TRACK_PROC_CNT0    0x0f0
> +#define MDP_WROT_TRACK_PROC_CNT1    0x0f4
> +
> +/* MASK */
> +#define VIDO_CTRL_MASK                  0xf530711f
> +#define VIDO_DMA_PERF_MASK              0x3fffffff
> +#define VIDO_MAIN_BUF_SIZE_MASK         0x1fff7f77
> +#define VIDO_SOFT_RST_MASK              0x00000001
> +#define VIDO_SOFT_RST_STAT_MASK         0x00000001
> +#define VIDO_INT_EN_MASK                0x00003f07
> +#define VIDO_INT_MASK                   0x00000007
> +#define VIDO_CROP_OFST_MASK             0x1fff1fff
> +#define VIDO_TAR_SIZE_MASK              0x1fff1fff
> +#define VIDO_BASE_ADDR_MASK             0xffffffff
> +#define VIDO_OFST_ADDR_MASK             0x0fffffff
> +#define VIDO_STRIDE_MASK                0x0000ffff
> +#define VIDO_BASE_ADDR_C_MASK           0xffffffff
> +#define VIDO_OFST_ADDR_C_MASK           0x0fffffff
> +#define VIDO_STRIDE_C_MASK              0x0000ffff
> +#define VIDO_DITHER_MASK                0xff000001
> +#define VIDO_BASE_ADDR_V_MASK           0xffffffff
> +#define VIDO_OFST_ADDR_V_MASK           0x0fffffff
> +#define VIDO_STRIDE_V_MASK              0x0000ffff
> +#define VIDO_RSV_1_MASK                 0xffffffff
> +#define VIDO_DMA_PREULTRA_MASK          0x00ffffff
> +#define VIDO_IN_SIZE_MASK               0x1fff1fff
> +#define VIDO_ROT_EN_MASK                0x00000001
> +#define VIDO_FIFO_TEST_MASK             0x00000fff
> +#define VIDO_MAT_CTRL_MASK              0x000000f3
> +#define VIDO_MAT_RMY_MASK               0x1fff1fff
> +#define VIDO_MAT_RMV_MASK               0x1fff1fff
> +#define VIDO_MAT_GMY_MASK               0x1fff1fff
> +#define VIDO_MAT_BMY_MASK               0x1fff1fff
> +#define VIDO_MAT_BMV_MASK               0x00001fff
> +#define VIDO_MAT_PREADD_MASK            0x1ff7fdff
> +#define VIDO_MAT_POSTADD_MASK           0x1ff7fdff
> +#define VIDO_DITHER_00_MASK             0x0000ff3f
> +#define VIDO_DITHER_02_MASK             0xffff3fff
> +#define VIDO_DITHER_03_MASK             0x0000003f
> +#define VIDO_DITHER_04_MASK             0xbfffffff
> +#define VIDO_DITHER_05_MASK             0xffff7fff
> +#define VIDO_DITHER_06_MASK             0x003ff773
> +#define VIDO_DITHER_07_MASK             0x00007777
> +#define VIDO_DITHER_08_MASK             0x00007777
> +#define VIDO_DITHER_09_MASK             0x00007777
> +#define VIDO_DITHER_10_MASK             0x0001ffff
> +#define VIDO_DEBUG_MASK                 0xffffffff
> +#define VIDO_ARB_SW_CTL_MASK            0x00000007
> +#define MDP_WROT_TRACK_CTL_MASK         0x0000001f
> +#define MDP_WROT_TRACK_WINDOW_MASK      0x00000fff
> +#define MDP_WROT_TRACK_TARGET_MASK      0x00ffffff
> +#define MDP_WROT_TRACK_STOP_MASK        0x00ffffff
> +#define MDP_WROT_TRACK_PROC_CNT0_MASK   0xffffffff
> +#define MDP_WROT_TRACK_PROC_CNT1_MASK   0x00000001
> +
> +#endif  // __MDP_REG_WROT_H__
> diff --git a/drivers/media/platform/mtk-mdp3/mmsys_config.h b/drivers/med=
ia/platform/mtk-mdp3/mmsys_config.h
> new file mode 100644
> index 000000000000..5cdfb864dadf
> --- /dev/null
> +++ b/drivers/media/platform/mtk-mdp3/mmsys_config.h
> @@ -0,0 +1,188 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2019 MediaTek Inc.
> + * Author: Ping-Hsun Wu <ping-hsun.wu@mediatek.com>
> + */
> +
> +#ifndef __MMSYS_CONFIG_H__
> +#define __MMSYS_CONFIG_H__
> +
> +#include "mmsys_reg_base.h"
> +
> +#define MMSYS_INTEN                   0x000
> +#define MMSYS_INTSTA                  0x004
> +#define MJC_APB_TX_CON                0x00c
> +
> +#define ISP_MOUT_EN                   0xf80
> +#define MDP_RDMA0_MOUT_EN             0xf84
> +#define MDP_RDMA1_MOUT_EN             0xf88
> +#define MDP_PRZ0_MOUT_EN              0xf8c
> +#define MDP_PRZ1_MOUT_EN              0xf90
> +#define MDP_COLOR_MOUT_EN             0xf94
> +#define IPU_MOUT_EN                   0xf98
> +#define DISP_TO_WROT_SOUT_SEL         0xfa0
> +#define MDP_COLOR_IN_SOUT_SEL         0xfa4
> +#define MDP_PATH0_SOUT_SEL            0xfa8
> +#define MDP_PATH1_SOUT_SEL            0xfac
> +#define MDP_TDSHP_SOUT_SEL            0xfb0
> +
> +#define DISP_OVL0_MOUT_EN             0xf00
> +#define DISP_OVL0_2L_MOUT_EN          0xf04
> +#define DISP_OVL1_2L_MOUT_EN          0xf08
> +#define DISP_DITHER0_MOUT_EN          0xf0c
> +#define DISP_RSZ_MOUT_EN              0xf10
> +
> +#define MMSYS_MOUT_RST                0x048
> +#define MDP_PRZ0_SEL_IN               0xfc0
> +#define MDP_PRZ1_SEL_IN               0xfc4
> +#define MDP_TDSHP_SEL_IN              0xfc8
> +#define DISP_WDMA0_SEL_IN             0xfcc
> +#define MDP_WROT0_SEL_IN              0xfd0
> +#define MDP_WDMA_SEL_IN               0xfd4
> +#define MDP_COLOR_OUT_SEL_IN          0xfd8
> +#define MDP_COLOR_SEL_IN              0xfdc
> +#define MDP_PATH0_SEL_IN              0xfe0
> +#define MDP_PATH1_SEL_IN              0xfe4
> +
> +#define DISP_COLOR_OUT_SEL_IN         0xf20
> +#define DISP_PATH0_SEL_IN             0xf24
> +#define DISP_WDMA0_PRE_SEL_IN         0xf28
> +#define DSI0_SEL_IN                   0xf2c
> +#define DSI1_SEL_IN                   0xf30
> +#define DISP_OVL0_SEL_IN              0xf34
> +#define DISP_OVL0_2L_SEL_IN           0xf38
> +#define OVL_TO_RSZ_SEL_IN             0xf3c
> +#define OVL_TO_WDMA_SEL_IN            0xf40
> +#define OVL_TO_WROT_SEL_IN            0xf44
> +#define DISP_RSZ_SEL_IN               0xf48
> +#define DISP_RDMA0_SOUT_SEL_IN        0xf50
> +#define DISP_RDMA1_SOUT_SEL_IN        0xf54
> +#define MDP_TO_DISP0_SOUT_SEL_IN      0xf58
> +#define MDP_TO_DISP1_SOUT_SEL_IN      0xf5c
> +#define DISP_RDMA0_RSZ_IN_SOUT_SEL_IN 0xf60
> +#define DISP_RDMA0_RSZ_OUT_SEL_IN     0xf64
> +#define MDP_AAL_MOUT_EN               0xfe8
> +#define MDP_AAL_SEL_IN                0xfec
> +#define MDP_CCORR_SEL_IN              0xff0
> +#define MDP_CCORR_SOUT_SEL            0xff4
> +
> +#define MMSYS_MISC                    0x0f0
> +#define MMSYS_SMI_LARB_SEL            0x0f4
> +#define MMSYS_SODI_REQ_MASK           0x0f8
> +#define MMSYS_CG_CON0                 0x100
> +#define MMSYS_CG_SET0                 0x104
> +#define MMSYS_CG_CLR0                 0x108
> +#define MMSYS_CG_CON1                 0x110
> +#define MMSYS_CG_SET1                 0x114
> +#define MMSYS_CG_CLR1                 0x118
> +#define MMSYS_HW_DCM_DIS0             0x120
> +#define MMSYS_HW_DCM_DIS_SET0         0x124
> +#define MMSYS_HW_DCM_DIS_CLR0         0x128
> +#define MMSYS_HW_DCM_DIS1             0x130
> +#define MMSYS_HW_DCM_DIS_SET1         0x134
> +#define MMSYS_HW_DCM_DIS_CLR1         0x138
> +#define MMSYS_HW_DCM_EVENT_CTL1       0x13c
> +#define MMSYS_SW0_RST_B               0x140
> +#define MMSYS_SW1_RST_B               0x144
> +#define MMSYS_LCM_RST_B               0x150
> +#define LARB6_AXI_ASIF_CFG_WD         0x180
> +#define LARB6_AXI_ASIF_CFG_RD         0x184
> +#define PROC_TRACK_EMI_BUSY_CON       0x190
> +#define DISP_FAKE_ENG_EN              0x200
> +#define DISP_FAKE_ENG_RST             0x204
> +#define DISP_FAKE_ENG_CON0            0x208
> +#define DISP_FAKE_ENG_CON1            0x20c
> +#define DISP_FAKE_ENG_RD_ADDR         0x210
> +#define DISP_FAKE_ENG_WR_ADDR         0x214
> +#define DISP_FAKE_ENG_STATE           0x218
> +#define DISP_FAKE_ENG2_EN             0x220
> +#define DISP_FAKE_ENG2_RST            0x224
> +#define DISP_FAKE_ENG2_CON0           0x228
> +#define DISP_FAKE_ENG2_CON1           0x22c
> +#define DISP_FAKE_ENG2_RD_ADDR        0x230
> +#define DISP_FAKE_ENG2_WR_ADDR        0x234
> +#define DISP_FAKE_ENG2_STATE          0x238
> +#define MMSYS_MBIST_CON               0x800
> +#define MMSYS_MBIST_DONE              0x804
> +#define MMSYS_MBIST_HOLDB             0x808
> +#define MMSYS_MBIST_MODE              0x80c
> +#define MMSYS_MBIST_FAIL0             0x810
> +#define MMSYS_MBIST_FAIL1             0x814
> +#define MMSYS_MBIST_FAIL2             0x818
> +#define MMSYS_MBIST_DEBUG             0x820
> +#define MMSYS_MBIST_DIAG_SCANOUT      0x824
> +#define MMSYS_MBIST_PRE_FUSE          0x828
> +#define MMSYS_MBIST_BSEL0             0x82c
> +#define MMSYS_MBIST_BSEL1             0x830
> +#define MMSYS_MBIST_BSEL2             0x834
> +#define MMSYS_MBIST_BSEL3             0x838
> +#define MMSYS_MBIST_HDEN              0x83c
> +#define MDP_RDMA0_MEM_DELSEL          0x840
> +#define MDP_RDMA1_MEM_DELSEL          0x844
> +#define MDP_RSZ_MEM_DELSEL            0x848
> +#define MDP_TDSHP_MEM_DELSEL          0x84c
> +#define MDP_AAL_MEM_DELSEL            0x850
> +
> +#define MDP_WROT0_MEM_DELSEL          0x854
> +#define MDP_WDMA_MEM_DELSEL           0x858
> +#define DISP_OVL_MEM_DELSEL           0x85c
> +#define DISP_OVL_2L_MEM_DELSEL        0x860
> +#define DISP_RDMA_MEM_DELSEL          0x864
> +#define DISP_WDMA0_MEM_DELSEL         0x868
> +#define DISP_GAMMA_MEM_DELSEL         0x870
> +#define DSI_MEM_DELSEL                0x874
> +#define DISP_SPLIT_MEM_DELSEL         0x878
> +#define DISP_DSC_MEM_DELSEL           0x87c
> +#define MMSYS_DEBUG_OUT_SEL           0x88c
> +#define MMSYS_MBIST_RP_RST_B          0x890
> +#define MMSYS_MBIST_RP_FAIL0          0x894
> +#define MMSYS_MBIST_RP_FAIL1          0x898
> +#define MMSYS_MBIST_RP_OK0            0x89c
> +#define MMSYS_MBIST_RP_OK1            0x8a0
> +#define MMSYS_DUMMY0                  0x8a4
> +#define MMSYS_DUMMY1                  0x8a8
> +#define MMSYS_DUMMY2                  0x8ac
> +#define MMSYS_DUMMY3                  0x8b0
> +#define DISP_DL_VALID_0               0x8b4
> +#define DISP_DL_VALID_1               0x8b8
> +#define DISP_DL_VALID_2               0x8bc
> +#define DISP_DL_READY_0               0x8c0
> +#define DISP_DL_READY_1               0x8c4
> +#define DISP_DL_READY_2               0x8C8
> +#define MDP_DL_VALID_0                0x8cc
> +#define MDP_DL_VALID_1                0x8d0
> +#define MDP_DL_READY_0                0x8d4
> +#define MDP_DL_READY_1                0x8d8
> +#define SMI_LARB0_GREQ                0x8dc
> +#define DISP_MOUT_MASK                0x8e0
> +#define DISP_MOUT_MASK1               0x8e4
> +#define MDP_MOUT_MASK                 0x8e8
> +#define MMSYS_POWER_READ              0x8ec
> +#define TOP_RELAY_FSM_RD              0x960
> +#define MDP_ASYNC_CFG_WD              0x934
> +#define MDP_ASYNC_CFG_RD              0x938
> +#define MDP_ASYNC_IPU_CFG_WD          0x93C
> +#define MDP_ASYNC_CFG_IPU_RD          0x940
> +#define MDP_ASYNC_CFG_OUT_RD          0x958
> +#define MDP_ASYNC_IPU_CFG_OUT_RD      0x95C
> +#define ISP_RELAY_CFG_WD              0x994
> +#define ISP_RELAY_CNT_RD              0x998
> +#define ISP_RELAY_CNT_LATCH_RD        0x99c
> +#define IPU_RELAY_CFG_WD              0x9a0
> +#define IPU_RELAY_CNT_RD              0x9a4
> +#define IPU_RELAY_CNT_LATCH_RD        0x9a8
> +
> +/* MASK */
> +#define MMSYS_SW0_RST_B_MASK          0xffffffff
> +#define MMSYS_SW1_RST_B_MASK          0xffffffff
> +#define MDP_COLOR_IN_SOUT_SEL_MASK    0x0000000f
> +#define DISP_COLOR_OUT_SEL_IN_MASK    0xffffffff
> +#define MDP_ASYNC_CFG_WD_MASK         0xffffffff
> +#define MDP_ASYNC_IPU_CFG_WD_MASK     0xffffffff
> +#define MMSYS_HW_DCM_DIS0_MASK        0xffffffff
> +#define MMSYS_HW_DCM_DIS1_MASK        0xffffffff
> +#define MDP_ASYNC_CFG_WD_MASK         0xffffffff
> +#define ISP_RELAY_CFG_WD_MASK         0xffffffff
> +#define IPU_RELAY_CFG_WD_MASK         0xffffffff
> +
> +#endif  // __MMSYS_CONFIG_H__
> diff --git a/drivers/media/platform/mtk-mdp3/mmsys_mutex.h b/drivers/medi=
a/platform/mtk-mdp3/mmsys_mutex.h
> new file mode 100644
> index 000000000000..fb8c179f11af
> --- /dev/null
> +++ b/drivers/media/platform/mtk-mdp3/mmsys_mutex.h
> @@ -0,0 +1,35 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2019 MediaTek Inc.
> + * Author: Ping-Hsun Wu <ping-hsun.wu@mediatek.com>
> + */
> +
> +#ifndef __MMSYS_MUTEX_H__
> +#define __MMSYS_MUTEX_H__
> +
> +#include "mmsys_reg_base.h"
> +#include "mdp-platform.h"
> +
> +#define MM_MUTEX_INTEN              0x00
> +#define MM_MUTEX_INTSTA             0x04
> +#define MM_MUTEX_CFG                0x08
> +
> +#define MM_MUTEX_EN                 (0x20 + mutex_id * 0x20)
> +#define MM_MUTEX_GET                (0x24 + mutex_id * 0x20)
> +#define MM_MUTEX_RST                (0x28 + mutex_id * 0x20)
> +#define MM_MUTEX_MOD                (MM_MUTEX_MOD_OFFSET + mutex_id * 0x=
20)
> +#define MM_MUTEX_SOF                (MM_MUTEX_SOF_OFFSET + mutex_id * 0x=
20)
> +
> +// MASK
> +#define MM_MUTEX_INTEN_MASK         0x0fff
> +#define MM_MUTEX_INTSTA_MASK        0x0fff
> +#define MM_MUTEX_DEBUG_OUT_SEL_MASK 0x03
> +#define MM_MUTEX_CFG_MASK           0x01
> +
> +#define MM_MUTEX_EN_MASK            0x01
> +#define MM_MUTEX_GET_MASK           0x03
> +#define MM_MUTEX_RST_MASK           0x01
> +#define MM_MUTEX_MOD_MASK           0x07ffffff
> +#define MM_MUTEX_SOF_MASK           0x0f
> +
> +#endif  // __MMSYS_MUTEX_H__
> diff --git a/drivers/media/platform/mtk-mdp3/mmsys_reg_base.h b/drivers/m=
edia/platform/mtk-mdp3/mmsys_reg_base.h
> new file mode 100644
> index 000000000000..738ecd525474
> --- /dev/null
> +++ b/drivers/media/platform/mtk-mdp3/mmsys_reg_base.h
> @@ -0,0 +1,38 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2019 MediaTek Inc.
> + * Author: Ping-Hsun Wu <ping-hsun.wu@mediatek.com>
> + */
> +
> +#ifndef __MMSYS_REG_BASE_H__
> +#define __MMSYS_REG_BASE_H__
> +
> +#define MM_REG_WRITE_MASK(cmd, id, base, ofst, val, mask, ...) \
> +	cmdq_pkt_write_mask(cmd->pkt, id, \
> +		(base) + (ofst), (val), (mask), ##__VA_ARGS__)
> +#define MM_REG_WRITE(cmd, id, base, ofst, val, mask, ...) \
> +	MM_REG_WRITE_MASK(cmd, id, base, ofst, val, \
> +		(((mask) & (ofst##_MASK)) =3D=3D (ofst##_MASK)) ? \
> +			(0xffffffff) : (mask), ##__VA_ARGS__)
> +
> +#define MM_REG_WAIT(cmd, evt) \
> +	cmdq_pkt_wfe(cmd->pkt, cmd->event[(evt)], true)
> +
> +#define MM_REG_WAIT_NO_CLEAR(cmd, evt) \
> +	cmdq_pkt_wait_no_clear(cmd->pkt, cmd->event[(evt)])
> +
> +#define MM_REG_CLEAR(cmd, evt) \
> +	cmdq_pkt_clear_event(cmd->pkt, cmd->event[(evt)])
> +
> +#define MM_REG_SET_EVENT(cmd, evt) \
> +	cmdq_pkt_set_event(cmd->pkt, cmd->event[(evt)])
> +
> +#define MM_REG_POLL_MASK(cmd, id, base, ofst, val, mask, ...) \
> +	cmdq_pkt_poll_mask(cmd->pkt, id, \
> +		(base) + (ofst), (val), (mask), ##__VA_ARGS__)
> +#define MM_REG_POLL(cmd, id, base, ofst, val, mask, ...) \
> +	MM_REG_POLL_MASK(cmd, id, base, ofst, val, \
> +		(((mask) & (ofst##_MASK)) =3D=3D (ofst##_MASK)) ? \
> +			(0xffffffff) : (mask), ##__VA_ARGS__)
> +
> +#endif  // __MM_REG_BASE_H__
> diff --git a/drivers/media/platform/mtk-mdp3/mtk-img-ipi.h b/drivers/medi=
a/platform/mtk-mdp3/mtk-img-ipi.h
> new file mode 100644
> index 000000000000..1c9b0e95658d
> --- /dev/null
> +++ b/drivers/media/platform/mtk-mdp3/mtk-img-ipi.h
> @@ -0,0 +1,282 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2018 MediaTek Inc.
> + * Author: Holmes Chiou <holmes.chiou@mediatek.com>
> + *         Ping-Hsun Wu <ping-hsun.wu@mediatek.com>
> + */
> +
> +#ifndef __MTK_IMG_IPI_H__
> +#define __MTK_IMG_IPI_H__
> +
> +#include <linux/types.h>
> +
> +/* ISP-MDP generic input information */
> +
> +#define IMG_MAX_HW_INPUTS	3
> +
> +#define IMG_MAX_HW_OUTPUTS	4
> +
> +#define IMG_MAX_PLANES		3
> +
> +#define IMG_IPI_INIT    1
> +#define IMG_IPI_DEINIT  2
> +#define IMG_IPI_FRAME   3
> +#define IMG_IPI_DEBUG   4
> +
> +struct img_addr {
> +	u64 va; /* Used by Linux OS access */
> +	u32 pa; /* Used by CM4 access */
> +	u32 iova; /* Used by IOMMU HW access */
> +} __attribute__ ((__packed__));
> +
> +struct tuning_addr {
> +	u64	present;
> +	u32	pa;	/* Used by CM4 access */
> +	u32	iova;	/* Used by IOMMU HW access */
> +} __attribute__ ((__packed__));
> +
> +
> +struct img_sw_addr {
> +	u64 va; /* Used by APMCU access */
> +	u32 pa; /* Used by CM4 access */
> +} __attribute__ ((__packed__));
> +
> +struct img_plane_format {
> +	u32 size;
> +	u16 stride;
> +} __attribute__ ((__packed__));
> +
> +struct img_pix_format {
> +	u16 width;
> +	u16 height;
> +	u32 colorformat; /* enum mdp_color */
> +	u16 ycbcr_prof; /* enum mdp_ycbcr_profile */
> +	struct img_plane_format plane_fmt[IMG_MAX_PLANES];
> +} __attribute__ ((__packed__));
> +
> +struct img_image_buffer {
> +	struct img_pix_format format;
> +	u32 iova[IMG_MAX_PLANES];
> +	/* enum mdp_buffer_usage, FD or advanced ISP usages */
> +	u32 usage;
> +} __attribute__ ((__packed__));
> +
> +#define IMG_SUBPIXEL_SHIFT	20
> +
> +struct img_crop {
> +	s16 left;
> +	s16 top;
> +	u16 width;
> +	u16 height;
> +	u32 left_subpix;
> +	u32 top_subpix;
> +	u32 width_subpix;
> +	u32 height_subpix;
> +} __attribute__ ((__packed__));
> +
> +#define IMG_CTRL_FLAG_HFLIP	BIT(0)
> +#define IMG_CTRL_FLAG_DITHER	BIT(1)
> +#define IMG_CTRL_FLAG_SHARPNESS	BIT(4)
> +#define IMG_CTRL_FLAG_HDR	BIT(5)
> +#define IMG_CTRL_FLAG_DRE	BIT(6)
> +
> +struct img_input {
> +	struct img_image_buffer buffer;
> +	u16 flags; /* HDR, DRE, dither */
> +} __attribute__ ((__packed__));
> +
> +struct img_output {
> +	struct img_image_buffer buffer;
> +	struct img_crop crop;
> +	s16 rotation;
> +	u16 flags; /* H-flip, sharpness, dither */
> +} __attribute__ ((__packed__));
> +
> +struct img_ipi_frameparam {
> +	u32 index;
> +	u32 frame_no;
> +	u64 timestamp;
> +	u8 type; /* enum mdp_stream_type */
> +	u8 state;
> +	u8 num_inputs;
> +	u8 num_outputs;
> +	u64 drv_data;
> +	struct img_input inputs[IMG_MAX_HW_INPUTS];
> +	struct img_output outputs[IMG_MAX_HW_OUTPUTS];
> +	struct tuning_addr tuning_data;
> +	struct img_addr subfrm_data;
> +	struct img_sw_addr config_data;
> +	struct img_sw_addr self_data;
> +} __attribute__ ((__packed__));
> +
> +struct img_sw_buffer {
> +	u64	handle;		/* Used by APMCU access */
> +	u32	scp_addr;	/* Used by CM4 access */
> +} __attribute__ ((__packed__));
> +
> +struct img_ipi_param {
> +	u8 usage;
> +	struct img_sw_buffer frm_param;
> +} __attribute__ ((__packed__));
> +
> +struct img_frameparam {
> +	struct list_head list_entry;
> +	struct img_ipi_frameparam frameparam;
> +};
> +
> +/* ISP-MDP generic output information */
> +
> +struct img_comp_frame {
> +	u32 output_disable:1;
> +	u32 bypass:1;
> +	u16 in_width;
> +	u16 in_height;
> +	u16 out_width;
> +	u16 out_height;
> +	struct img_crop crop;
> +	u16 in_total_width;
> +	u16 out_total_width;
> +} __attribute__ ((__packed__));
> +
> +struct img_region {
> +	s16 left;
> +	s16 right;
> +	s16 top;
> +	s16 bottom;
> +} __attribute__ ((__packed__));
> +
> +struct img_offset {
> +	s16 left;
> +	s16 top;
> +	u32 left_subpix;
> +	u32 top_subpix;
> +} __attribute__ ((__packed__));
> +
> +struct img_comp_subfrm {
> +	u32 tile_disable:1;
> +	struct img_region in;
> +	struct img_region out;
> +	struct img_offset luma;
> +	struct img_offset chroma;
> +	s16 out_vertical; /* Output vertical index */
> +	s16 out_horizontal; /* Output horizontal index */
> +} __attribute__ ((__packed__));
> +
> +#define IMG_MAX_SUBFRAMES	14
> +
> +struct mdp_rdma_subfrm {
> +	u32 offset[IMG_MAX_PLANES];
> +	u32 offset_0_p;
> +	u32 src;
> +	u32 clip;
> +	u32 clip_ofst;
> +} __attribute__ ((__packed__));
> +
> +struct mdp_rdma_data {
> +	u32 src_ctrl;
> +	u32 control;
> +	u32 iova[IMG_MAX_PLANES];
> +	u32 iova_end[IMG_MAX_PLANES];
> +	u32 mf_bkgd;
> +	u32 mf_bkgd_in_pxl;
> +	u32 sf_bkgd;
> +	u32 ufo_dec_y;
> +	u32 ufo_dec_c;
> +	u32 transform;
> +	struct mdp_rdma_subfrm subfrms[IMG_MAX_SUBFRAMES];
> +} __attribute__ ((__packed__));
> +
> +struct mdp_rsz_subfrm {
> +	u32 control2;
> +	u32 src;
> +	u32 clip;
> +} __attribute__ ((__packed__));
> +
> +struct mdp_rsz_data {
> +	u32 coeff_step_x;
> +	u32 coeff_step_y;
> +	u32 control1;
> +	u32 control2;
> +	struct mdp_rsz_subfrm subfrms[IMG_MAX_SUBFRAMES];
> +} __attribute__ ((__packed__));
> +
> +struct mdp_wrot_subfrm {
> +	u32 offset[IMG_MAX_PLANES];
> +	u32 src;
> +	u32 clip;
> +	u32 clip_ofst;
> +	u32 main_buf;
> +} __attribute__ ((__packed__));
> +
> +struct mdp_wrot_data {
> +	u32 iova[IMG_MAX_PLANES];
> +	u32 control;
> +	u32 stride[IMG_MAX_PLANES];
> +	u32 mat_ctrl;
> +	u32 fifo_test;
> +	u32 filter;
> +	struct mdp_wrot_subfrm subfrms[IMG_MAX_SUBFRAMES];
> +} __attribute__ ((__packed__));
> +
> +struct mdp_wdma_subfrm {
> +	u32 offset[IMG_MAX_PLANES];
> +	u32 src;
> +	u32 clip;
> +	u32 clip_ofst;
> +} __attribute__ ((__packed__));
> +
> +struct mdp_wdma_data {
> +	u32 wdma_cfg;
> +	u32 iova[IMG_MAX_PLANES];
> +	u32 w_in_byte;
> +	u32 uv_stride;
> +	struct mdp_wdma_subfrm subfrms[IMG_MAX_SUBFRAMES];
> +} __attribute__ ((__packed__));
> +
> +struct isp_data {
> +	u64 dl_flags; /* 1 << (enum mdp_comp_type) */
> +	u32 smxi_iova[4];
> +	u32 cq_idx;
> +	u32 cq_iova;
> +	u32 tpipe_iova[IMG_MAX_SUBFRAMES];
> +} __attribute__ ((__packed__));
> +
> +struct img_compparam {
> +	u16 type; /* enum mdp_comp_type */
> +	u16 id; /* enum mdp_comp_id */
> +	u32 input;
> +	u32 outputs[IMG_MAX_HW_OUTPUTS];
> +	u32 num_outputs;
> +	struct img_comp_frame frame;
> +	struct img_comp_subfrm subfrms[IMG_MAX_SUBFRAMES];
> +	u32 num_subfrms;
> +	union {
> +		struct mdp_rdma_data rdma;
> +		struct mdp_rsz_data rsz;
> +		struct mdp_wrot_data wrot;
> +		struct mdp_wdma_data wdma;
> +		struct isp_data isp;
> +	};
> +} __attribute__ ((__packed__));
> +
> +#define IMG_MAX_COMPONENTS	20
> +
> +struct img_mux {
> +	u32 reg;
> +	u32 value;
> +};
> +
> +struct img_mmsys_ctrl {
> +	struct img_mux sets[IMG_MAX_COMPONENTS * 2];
> +	u32 num_sets;
> +};
> +
> +struct img_config {
> +	struct img_compparam components[IMG_MAX_COMPONENTS];
> +	u32 num_components;
> +	struct img_mmsys_ctrl ctrls[IMG_MAX_SUBFRAMES];
> +	u32 num_subfrms;
> +} __attribute__ ((__packed__));
> +
> +#endif  /* __MTK_IMG_IPI_H__ */
> +
> diff --git a/drivers/media/platform/mtk-mdp3/mtk-mdp3-cmdq.c b/drivers/me=
dia/platform/mtk-mdp3/mtk-mdp3-cmdq.c
> new file mode 100644
> index 000000000000..151485933eae
> --- /dev/null
> +++ b/drivers/media/platform/mtk-mdp3/mtk-mdp3-cmdq.c
> @@ -0,0 +1,538 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2018 MediaTek Inc.
> + * Author: Ping-Hsun Wu <ping-hsun.wu@mediatek.com>
> + */
> +
> +#include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
> +#include "mtk-mdp3-cmdq.h"
> +#include "mtk-mdp3-comp.h"
> +#include "mtk-mdp3-core.h"
> +#include "mtk-mdp3-debug.h"
> +#include "mtk-mdp3-m2m.h"
> +
> +#include "mdp-platform.h"
> +#include "mmsys_mutex.h"
> +
> +#define DISP_MUTEX_MDP_FIRST	(5)
> +#define DISP_MUTEX_MDP_COUNT	(5)
> +
> +#define MDP_PATH_MAX_COMPS	IMG_MAX_COMPONENTS
> +
> +struct mdp_path {
> +	struct mdp_dev		*mdp_dev;
> +	struct mdp_comp_ctx	comps[MDP_PATH_MAX_COMPS];
> +	u32			num_comps;
> +	const struct img_config	*config;
> +	const struct img_ipi_frameparam *param;
> +	const struct v4l2_rect	*composes[IMG_MAX_HW_OUTPUTS];
> +	struct v4l2_rect	bounds[IMG_MAX_HW_OUTPUTS];
> +};
> +
> +#define has_op(ctx, op) \
> +	(ctx->comp->ops && ctx->comp->ops->op)
> +#define call_op(ctx, op, ...) \
> +	(has_op(ctx, op) ? ctx->comp->ops->op(ctx, ##__VA_ARGS__) : 0)
> +
> +struct mdp_path_subfrm {
> +	s32	mutex_id;
> +	u32	mutex_mod;
> +	s32	sofs[MDP_PATH_MAX_COMPS];
> +	u32	num_sofs;
> +};
> +
> +static bool is_output_disable(const struct img_compparam *param, u32 cou=
nt)
> +{
> +	return (count < param->num_subfrms) ?
> +		(param->frame.output_disable ||
> +		param->subfrms[count].tile_disable) :
> +		true;
> +}
> +
> +static int mdp_path_subfrm_require(struct mdp_path_subfrm *subfrm,
> +				   const struct mdp_path *path,
> +				   struct mdp_cmd *cmd, u32 count)
> +{
> +	const struct img_config *config =3D path->config;
> +	const struct mdp_comp_ctx *ctx;
> +	phys_addr_t mm_mutex =3D path->mdp_dev->mm_mutex.reg_base;
> +	s32 mutex_id =3D -1;
> +	u32 mutex_sof =3D 0;
> +	int mdp_color =3D 0;
> +	int index;
> +	u8 subsys_id =3D path->mdp_dev->mm_mutex.subsys_id;
> +
> +	/* Default value */
> +	memset(subfrm, 0, sizeof(*subfrm));
> +
> +	for (index =3D 0; index < config->num_components; index++) {
> +		ctx =3D &path->comps[index];
> +		if (is_output_disable(ctx->param, count))
> +			continue;
> +		switch (ctx->comp->id) {
> +		/**********************************************
> +		 * Name            MSB LSB
> +		 * DISP_MUTEX_MOD   23   0
> +		 *
> +		 * Specifies which modules are in this mutex.
> +		 * Every bit denotes a module. Bit definition:
> +		 *  2 mdp_rdma0
> +		 *  4 mdp_rsz0
> +		 *  5 mdp_rsz1
> +		 *  6 mdp_tdshp
> +		 *  7 mdp_wrot0
> +		 *  8 mdp_wdma
> +		 *  13 mdp_color
> +		 *  23 mdp_aal
> +		 *  24 mdp_ccorr
> +		 **********************************************/
> +		case MDP_AAL0:
> +			subfrm->mutex_mod |=3D 1 << 23;
> +			break;
> +		case MDP_CCORR0:
> +			subfrm->mutex_mod |=3D 1 << 24;
> +			break;
> +		case MDP_COLOR0:
> +			if (mdp_color)
> +				subfrm->mutex_mod |=3D 1 << 13;
> +			break;
> +		case MDP_WDMA:
> +			subfrm->mutex_mod |=3D 1 << 8;
> +			subfrm->sofs[subfrm->num_sofs++] =3D MDP_WDMA;
> +			break;
> +		case MDP_WROT0:
> +			subfrm->mutex_mod |=3D 1 << 7;
> +			subfrm->sofs[subfrm->num_sofs++] =3D MDP_WROT0;
> +			break;
> +		case MDP_TDSHP0:
> +			subfrm->mutex_mod |=3D 1 << 6;
> +			subfrm->sofs[subfrm->num_sofs++] =3D MDP_TDSHP0;
> +			break;
> +		case MDP_SCL1:
> +			subfrm->mutex_mod |=3D 1 << 5;
> +			subfrm->sofs[subfrm->num_sofs++] =3D MDP_SCL1;
> +			break;
> +		case MDP_SCL0:
> +			subfrm->mutex_mod |=3D 1 << 4;
> +			subfrm->sofs[subfrm->num_sofs++] =3D MDP_SCL0;
> +			break;
> +		case MDP_RDMA0:
> +			mutex_id =3D DISP_MUTEX_MDP_FIRST + 1;
> +			subfrm->mutex_mod |=3D 1 << 2;
> +			subfrm->sofs[subfrm->num_sofs++] =3D MDP_RDMA0;
> +			break;
> +		case MDP_IMGI:
> +			mutex_id =3D DISP_MUTEX_MDP_FIRST;
> +			break;
> +		case MDP_WPEI:
> +			mutex_id =3D DISP_MUTEX_MDP_FIRST + 3;
> +			break;
> +		case MDP_WPEI2:
> +			mutex_id =3D DISP_MUTEX_MDP_FIRST + 4;
> +			break;
> +		default:
> +			break;
> +		}
> +	}
> +
> +	subfrm->mutex_id =3D mutex_id;
> +	if (-1 =3D=3D mutex_id) {
> +		mdp_err("No mutex assigned");
> +		return -EINVAL;
> +	}
> +
> +	if (subfrm->mutex_mod) {
> +		/* Set mutex modules */
> +		MM_REG_WRITE(cmd, subsys_id, mm_mutex, MM_MUTEX_MOD,
> +			     subfrm->mutex_mod, 0x07FFFFFF);
> +		MM_REG_WRITE(cmd, subsys_id, mm_mutex, MM_MUTEX_SOF,
> +			     mutex_sof, 0x00000007);
> +	}
> +	return 0;
> +}
> +
> +static int mdp_path_subfrm_run(const struct mdp_path_subfrm *subfrm,
> +			       const struct mdp_path *path,
> +			       struct mdp_cmd *cmd)
> +{
> +	phys_addr_t mm_mutex =3D path->mdp_dev->mm_mutex.reg_base;
> +	s32 mutex_id =3D subfrm->mutex_id;
> +	u8 subsys_id =3D path->mdp_dev->mm_mutex.subsys_id;
> +
> +	if (-1 =3D=3D mutex_id) {
> +		mdp_err("Incorrect mutex id");
> +		return -EINVAL;
> +	}
> +
> +	if (subfrm->mutex_mod) {
> +		int index;
> +
> +		/* Wait WROT SRAM shared to DISP RDMA */
> +		/* Clear SOF event for each engine */
> +		for (index =3D 0; index < subfrm->num_sofs; index++) {
> +			switch (subfrm->sofs[index]) {
> +			case MDP_RDMA0:
> +				MM_REG_CLEAR(cmd, RDMA0_SOF);
> +				break;
> +			case MDP_TDSHP0:
> +				MM_REG_CLEAR(cmd, TDSHP0_SOF);
> +				break;
> +			case MDP_SCL0:
> +				MM_REG_CLEAR(cmd, RSZ0_SOF);
> +				break;
> +			case MDP_SCL1:
> +				MM_REG_CLEAR(cmd, RSZ1_SOF);
> +				break;
> +			case MDP_WDMA:
> +				MM_REG_CLEAR(cmd, WDMA0_SOF);
> +				break;
> +			case MDP_WROT0:
> +#if WROT0_DISP_SRAM_SHARING
> +				MM_REG_WAIT_NO_CLEAR(cmd, WROT0_SRAM_READY);
> +#endif
> +				MM_REG_CLEAR(cmd, WROT0_SOF);
> +				break;
> +			default:
> +				break;
> +			}
> +		}
> +
> +		/* Enable the mutex */
> +		MM_REG_WRITE(cmd, subsys_id, mm_mutex, MM_MUTEX_EN, 0x1,
> +			     0x00000001);
> +
> +		/* Wait SOF events and clear mutex modules (optional) */
> +		for (index =3D 0; index < subfrm->num_sofs; index++) {
> +			switch (subfrm->sofs[index]) {
> +			case MDP_RDMA0:
> +				MM_REG_WAIT(cmd, RDMA0_SOF);
> +				break;
> +			case MDP_TDSHP0:
> +				MM_REG_WAIT(cmd, TDSHP0_SOF);
> +				break;
> +			case MDP_SCL0:
> +				MM_REG_WAIT(cmd, RSZ0_SOF);
> +				break;
> +			case MDP_SCL1:
> +				MM_REG_WAIT(cmd, RSZ1_SOF);
> +				break;
> +			case MDP_WDMA:
> +				MM_REG_WAIT(cmd, WDMA0_SOF);
> +				break;
> +			case MDP_WROT0:
> +				MM_REG_WAIT(cmd, WROT0_SOF);
> +				break;
> +			default:
> +				break;
> +			}
> +		}
> +	}
> +	return 0;
> +}
> +
> +static int mdp_path_ctx_init(struct mdp_dev *mdp, struct mdp_path *path)
> +{
> +	const struct img_config *config =3D path->config;
> +	int index, ret;
> +
> +	if (config->num_components < 1)
> +	    return -EINVAL;
> +
> +	for (index =3D 0; index < config->num_components; index++) {
> +		ret =3D mdp_comp_ctx_init(mdp, &path->comps[index],
> +					&config->components[index],
> +					path->param);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int mdp_path_config_subfrm(struct mdp_cmd *cmd, struct mdp_path *=
path,
> +				  u32 count)
> +{
> +	struct mdp_path_subfrm subfrm;
> +	const struct img_config *config =3D path->config;
> +	const struct img_mmsys_ctrl *ctrl =3D &config->ctrls[count];
> +	const struct img_mux *set;
> +	struct mdp_comp_ctx *ctx;
> +	phys_addr_t mmsys =3D path->mdp_dev->mmsys.reg_base;
> +	int index, ret;
> +	u8 subsys_id =3D path->mdp_dev->mmsys.subsys_id;
> +
> +	/* Acquire components */
> +	ret =3D mdp_path_subfrm_require(&subfrm, path, cmd, count);
> +	if (ret)
> +		return ret;
> +	/* Enable mux settings */
> +	for (index =3D 0; index < ctrl->num_sets; index++) {
> +		set =3D &ctrl->sets[index];
> +		MM_REG_WRITE_MASK(cmd, subsys_id, mmsys, set->reg, set->value,
> +				  0xFFFFFFFF);
> +	}
> +	/* Config sub-frame information */
> +	for (index =3D (config->num_components - 1); index >=3D 0; index--) {
> +		ctx =3D &path->comps[index];
> +		if (is_output_disable(ctx->param, count))
> +			continue;
> +		ret =3D call_op(ctx, config_subfrm, cmd, count);
> +		if (ret)
> +			return ret;
> +	}
> +	/* Run components */
> +	ret =3D mdp_path_subfrm_run(&subfrm, path, cmd);
> +	if (ret)
> +		return ret;
> +	/* Wait components done */
> +	for (index =3D 0; index < config->num_components; index++) {
> +		ctx =3D &path->comps[index];
> +		if (is_output_disable(ctx->param, count))
> +			continue;
> +		ret =3D call_op(ctx, wait_comp_event, cmd);
> +		if (ret)
> +			return ret;
> +	}
> +	/* Advance to the next sub-frame */
> +	for (index =3D 0; index < config->num_components; index++) {
> +		ctx =3D &path->comps[index];
> +		ret =3D call_op(ctx, advance_subfrm, cmd, count);
> +		if (ret)
> +			return ret;
> +	}
> +	/* Disable mux settings */
> +	for (index =3D 0; index < ctrl->num_sets; index++) {
> +		set =3D &ctrl->sets[index];
> +		MM_REG_WRITE_MASK(cmd, subsys_id, mmsys, set->reg, 0,
> +				  0xFFFFFFFF);
> +	}
> +	return 0;
> +}
> +
> +static int mdp_path_config(struct mdp_dev *mdp, struct mdp_cmd *cmd,
> +			   struct mdp_path *path)
> +{
> +	const struct img_config *config =3D path->config;
> +	struct mdp_comp_ctx *ctx;
> +	int index, count, ret;
> +
> +	/* Config path frame */
> +	/* Reset components */
> +	for (index =3D 0; index < config->num_components; index++) {
> +		ctx =3D &path->comps[index];
> +		ret =3D call_op(ctx, init_comp, cmd);
> +		if (ret)
> +			return ret;
> +	}
> +	/* Config frame mode */
> +	for (index =3D 0; index < config->num_components; index++) {
> +		const struct v4l2_rect *compose =3D
> +			path->composes[ctx->param->outputs[0]];
> +
> +		ctx =3D &path->comps[index];
> +		ret =3D call_op(ctx, config_frame, cmd, compose);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	/* Config path sub-frames */
> +	for (count =3D 0; count < config->num_subfrms; count++) {
> +		ret =3D mdp_path_config_subfrm(cmd, path, count);
> +		if (ret)
> +			return ret;
> +	}
> +	/* Post processing information */
> +	for (index =3D 0; index < config->num_components; index++) {
> +		ctx =3D &path->comps[index];
> +		ret =3D call_op(ctx, post_process, cmd);
> +		if (ret)
> +			return ret;
> +	}
> +	return 0;
> +}
> +
> +static void mdp_auto_release_work(struct work_struct *work)
> +{
> +	struct mdp_cmdq_cb_param *cb_param;
> +	struct mdp_dev *mdp;
> +
> +	cb_param =3D container_of(work, struct mdp_cmdq_cb_param,
> +				auto_release_work);
> +	mdp =3D cb_param->mdp;
> +
> +	mdp_comp_clocks_off(&mdp->pdev->dev, cb_param->comps,
> +			    cb_param->num_comps);
> +
> +	kfree(cb_param->comps);
> +	kfree(cb_param);
> +
> +	atomic_dec(&mdp->job_count);
> +	wake_up(&mdp->callback_wq);
> +}
> +
> +static void mdp_handle_cmdq_callback(struct cmdq_cb_data data)
> +{
> +	struct mdp_cmdq_cb_param *cb_param;
> +	struct mdp_dev *mdp;
> +
> +	if (!data.data) {
> +		mdp_err("%s:no callback data\n", __func__);
> +		return;
> +	}
> +
> +	cb_param =3D (struct mdp_cmdq_cb_param *)data.data;
> +	mdp =3D cb_param->mdp;
> +
> +	if (cb_param->mdp_ctx)
> +		mdp_m2m_job_finish(cb_param->mdp_ctx);
> +#ifdef MDP_DEBUG
> +	if (data.sta =3D=3D CMDQ_CB_ERROR) {
> +		struct mdp_func_struct *p_func =3D mdp_get_func();
> +
> +		p_func->mdp_dump_mmsys_config();
> +		mdp_dump_info(~0, 1);
> +	}
> +#endif
> +
> +	if (cb_param->user_cmdq_cb) {
> +		struct cmdq_cb_data user_cb_data;
> +
> +		user_cb_data.sta =3D data.sta;
> +		user_cb_data.data =3D cb_param->user_cb_data;
> +		cb_param->user_cmdq_cb(user_cb_data);
> +	}
> +
> +	cmdq_pkt_destroy(cb_param->pkt);
> +	INIT_WORK(&cb_param->auto_release_work, mdp_auto_release_work);
> +	if (!queue_work(mdp->clock_wq, &cb_param->auto_release_work)) {
> +		mdp_err("%s:queue_work fail!\n", __func__);
> +		mdp_comp_clocks_off(&mdp->pdev->dev, cb_param->comps,
> +				    cb_param->num_comps);
> +
> +		kfree(cb_param->comps);
> +		kfree(cb_param);
> +
> +		atomic_dec(&mdp->job_count);
> +		wake_up(&mdp->callback_wq);
> +	}
> +}
> +
> +int mdp_cmdq_send(struct mdp_dev *mdp, struct mdp_cmdq_param *param)
> +{
> +	struct mdp_cmd cmd;
> +	struct mdp_path path;
> +	struct mdp_cmdq_cb_param *cb_param =3D NULL;
> +	struct mdp_comp *comps =3D NULL;
> +	int i, ret;
> +
> +	if (atomic_read(&mdp->suspended))
> +		return -ECANCELED;
> +
> +	atomic_inc(&mdp->job_count);
> +
> +	cmd.pkt =3D cmdq_pkt_create(mdp->cmdq_clt, SZ_16K);
> +	if (IS_ERR(cmd.pkt)) {
> +		atomic_dec(&mdp->job_count);
> +		wake_up(&mdp->callback_wq);
> +		return PTR_ERR(cmd.pkt);
> +	}
> +	cmd.event =3D &mdp->event[0];
> +
> +	path.mdp_dev =3D mdp;
> +	path.config =3D param->config;
> +	path.param =3D param->param;
> +	for (i =3D 0; i < param->param->num_outputs; i++) {
> +		path.bounds[i].left =3D 0;
> +		path.bounds[i].top =3D 0;
> +		path.bounds[i].width =3D
> +			param->param->outputs[i].buffer.format.width;
> +		path.bounds[i].height =3D
> +			param->param->outputs[i].buffer.format.height;
> +		path.composes[i] =3D param->composes[i] ?
> +			param->composes[i] : &path.bounds[i];
> +	}
> +
> +	ret =3D mdp_path_ctx_init(mdp, &path);
> +	if (ret) {
> +		pr_info("%s mdp_path_ctx_init error\n", __func__);
> +		goto err_destory_pkt;
> +	}
> +
> +	for (i =3D 0; i < param->config->num_components; i++)
> +			mdp_comp_clock_on(&mdp->pdev->dev, path.comps[i].comp);
> +
> +	ret =3D mdp_path_config(mdp, &cmd, &path);
> +	if (ret) {
> +		pr_info("%s mdp_path_config error\n", __func__);
> +		goto err_destory_pkt;
> +	}
> +
> +	cb_param =3D kzalloc(sizeof(*cb_param), GFP_KERNEL);
> +	if (!cb_param) {
> +		ret =3D -ENOMEM;
> +		goto err_destory_pkt;
> +	}
> +
> +	comps =3D kcalloc(param->config->num_components, sizeof(*comps),
> +			GFP_KERNEL);
> +	if (!comps) {
> +		mdp_err("%s:comps alloc fail!\n", __func__);
> +		ret =3D -ENOMEM;
> +		goto err_destory_pkt;
> +	}
> +
> +	for (i =3D 0; i < param->config->num_components; i++)
> +		memcpy(&comps[i], path.comps[i].comp,
> +		       sizeof(struct mdp_comp));
> +	cb_param->mdp =3D mdp;
> +	cb_param->user_cmdq_cb =3D param->cmdq_cb;
> +	cb_param->user_cb_data =3D param->cb_data;
> +	cb_param->pkt =3D cmd.pkt;
> +	cb_param->comps =3D comps;
> +	cb_param->num_comps =3D param->config->num_components;
> +	cb_param->mdp_ctx =3D param->mdp_ctx;
> +
> +	cmdq_pkt_finalize(cmd.pkt);
> +	ret =3D cmdq_pkt_flush_async(cmd.pkt,
> +				   mdp_handle_cmdq_callback,
> +				   (void *)cb_param);
> +	if (ret) {
> +		mdp_err("%s:cmdq_pkt_flush_async fail!\n", __func__);
> +		goto err_clock_off;
> +	}
> +	return 0;
> +
> +err_clock_off:
> +	mdp_comp_clocks_off(&mdp->pdev->dev, cb_param->comps,
> +				    cb_param->num_comps);
> +err_destory_pkt:
> +	cmdq_pkt_destroy(cmd.pkt);
> +	atomic_dec(&mdp->job_count);
> +	wake_up(&mdp->callback_wq);
> +	if (comps)
> +		kfree(comps);
> +	if (cb_param)
> +		kfree(cb_param);
> +
> +	return ret;
> +}
> +
> +int mdp_cmdq_sendtask(struct platform_device *pdev, struct img_config *c=
onfig,
> +		      struct img_ipi_frameparam *param,
> +		      struct v4l2_rect *compose,
> +		      void (*cmdq_cb)(struct cmdq_cb_data data), void *cb_data)
> +{
> +	struct mdp_dev *mdp =3D platform_get_drvdata(pdev);
> +	struct mdp_cmdq_param task =3D {
> +		.config =3D config,
> +		.param =3D param,
> +		.composes[0] =3D compose,
> +		.cmdq_cb =3D cmdq_cb,
> +		.cb_data =3D cb_data,
> +	};
> +
> +	return mdp_cmdq_send(mdp, &task);
> +}
> +EXPORT_SYMBOL_GPL(mdp_cmdq_sendtask);
> +
> diff --git a/drivers/media/platform/mtk-mdp3/mtk-mdp3-cmdq.h b/drivers/me=
dia/platform/mtk-mdp3/mtk-mdp3-cmdq.h
> new file mode 100644
> index 000000000000..f6394d3d0358
> --- /dev/null
> +++ b/drivers/media/platform/mtk-mdp3/mtk-mdp3-cmdq.h
> @@ -0,0 +1,53 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2018 MediaTek Inc.
> + * Author: Ping-Hsun Wu <ping-hsun.wu@mediatek.com>
> + */
> +
> +#ifndef __MTK_MDP3_CMDQ_H__
> +#define __MTK_MDP3_CMDQ_H__
> +
> +#include <linux/platform_device.h>
> +#include <linux/videodev2.h>
> +#include <linux/soc/mediatek/mtk-cmdq.h>
> +#include "mtk-img-ipi.h"
> +
> +struct platform_device *mdp_get_plat_device(struct platform_device *pdev=
);
> +
> +int mdp_cmdq_sendtask(struct platform_device *pdev, struct img_config *c=
onfig,
> +		      struct img_ipi_frameparam *param,
> +		      struct v4l2_rect *compose,
> +		      void (*cmdq_cb)(struct cmdq_cb_data data), void *cb_data);
> +
> +struct mdp_cmd {
> +	struct cmdq_pkt *pkt;
> +	s32 *event;
> +};
> +
> +struct mdp_cmdq_param {
> +	struct img_config *config;
> +	struct img_ipi_frameparam *param;
> +	const struct v4l2_rect *composes[IMG_MAX_HW_OUTPUTS];
> +
> +	void (*cmdq_cb)(struct cmdq_cb_data data);
> +	void *cb_data;
> +	void *mdp_ctx;
> +};
> +
> +struct mdp_cmdq_cb_param {
> +	struct work_struct auto_release_work;
> +	struct mdp_dev *mdp;
> +	void (*user_cmdq_cb)(struct cmdq_cb_data data);
> +	void *user_cb_data;
> +	struct cmdq_pkt *pkt;
> +	struct mdp_comp *comps;
> +	u8 num_comps;
> +	void *mdp_ctx;
> +};
> +
> +struct mdp_dev;
> +
> +int mdp_cmdq_send(struct mdp_dev *mdp, struct mdp_cmdq_param *param);
> +
> +#endif  /* __MTK_MDP3_CMDQ_H__ */
> +
> diff --git a/drivers/media/platform/mtk-mdp3/mtk-mdp3-comp.c b/drivers/me=
dia/platform/mtk-mdp3/mtk-mdp3-comp.c
> new file mode 100644
> index 000000000000..e89fd02bb556
> --- /dev/null
> +++ b/drivers/media/platform/mtk-mdp3/mtk-mdp3-comp.c
> @@ -0,0 +1,1437 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2018 MediaTek Inc.
> + * Author: Ping-Hsun Wu <ping-hsun.wu@mediatek.com>
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/of_platform.h>
> +#include <linux/of_address.h>
> +#include <linux/pm_runtime.h>
> +#include "mtk-mdp3-comp.h"
> +#include "mtk-mdp3-core.h"
> +#include "mtk-mdp3-regs.h"
> +
> +#include "mdp-platform.h"
> +#include "mmsys_config.h"
> +#include "mdp_reg_rdma.h"
> +#include "mdp_reg_ccorr.h"
> +#include "mdp_reg_rsz.h"
> +#include "mdp_reg_wrot.h"
> +#include "mdp_reg_wdma.h"
> +#include "isp_reg.h"
> +
> +static s64 get_comp_flag(const struct mdp_comp_ctx *ctx)
> +{
> +#if RDMA0_RSZ1_SRAM_SHARING
> +	if (ctx->comp->id =3D=3D MDP_RDMA0)
> +		return (1 << MDP_RDMA0) | (1 << MDP_SCL1);
> +#endif
> +	return 1 << ctx->comp->id;
> +}
> +
> +static int init_rdma(struct mdp_comp_ctx *ctx, struct mdp_cmd *cmd)
> +{
> +	phys_addr_t base =3D ctx->comp->reg_base;
> +	u8 subsys_id =3D ctx->comp->subsys_id;
> +#if RDMA0_RSZ1_SRAM_SHARING
> +	struct mdp_comp *prz1 =3D ctx->comp->mdp_dev->comp[MDP_SCL1];
> +
> +	/* Disable RSZ1 */
> +	if (ctx->comp->id =3D=3D MDP_RDMA0 && prz1)
> +		MM_REG_WRITE(cmd, subsys_id, prz1->reg_base, PRZ_ENABLE,
> +			     0x00000000, 0x00000001);
> +#endif
> +	/* Reset RDMA */
> +	MM_REG_WRITE(cmd, subsys_id, base, MDP_RDMA_RESET, 0x00000001,
> +		     0x00000001);
> +	MM_REG_POLL(cmd, subsys_id, base, MDP_RDMA_MON_STA_1, 0x00000100,
> +		    0x00000100);
> +	MM_REG_WRITE(cmd, subsys_id, base, MDP_RDMA_RESET, 0x00000000,
> +		     0x00000001);
> +	return 0;
> +}
> +
> +static int config_rdma_frame(struct mdp_comp_ctx *ctx, struct mdp_cmd *c=
md,
> +			     const struct v4l2_rect *compose)
> +{
> +	const struct mdp_rdma_data *rdma =3D &ctx->param->rdma;
> +	u32 colorformat =3D ctx->input->buffer.format.colorformat;
> +	bool block10bit =3D MDP_COLOR_IS_10BIT_PACKED(colorformat);
> +	bool en_ufo =3D MDP_COLOR_IS_UFP(colorformat);
> +	phys_addr_t base =3D ctx->comp->reg_base;
> +	u8 subsys_id =3D ctx->comp->subsys_id;
> +
> +#if RDMA_SUPPORT_10BIT
> +	if (block10bit)
> +		MM_REG_WRITE(cmd, subsys_id, base, MDP_RDMA_RESV_DUMMY_0,
> +			     0x00000007, 0x00000007);
> +	else
> +		MM_REG_WRITE(cmd, subsys_id, base, MDP_RDMA_RESV_DUMMY_0,
> +			     0x00000000, 0x00000007);
> +#endif
> +
> +	/* Setup smi control */
> +	MM_REG_WRITE(cmd, subsys_id, base, MDP_RDMA_GMCIF_CON,
> +		     (1 <<  0) +
> +		     (7 <<  4) + //burst type to 8
> +		     (1 << 16),  //enable pre-ultra
> +		     0x00030071);
> +
> +	/* Setup source frame info */
> +	MM_REG_WRITE(cmd, subsys_id, base, MDP_RDMA_SRC_CON, rdma->src_ctrl,
> +		     0x03C8FE0F);
> +#if RDMA_SUPPORT_10BIT
> +	if (en_ufo) {
> +		/* Setup source buffer base */
> +		MM_REG_WRITE(cmd, subsys_id,
> +			     base, MDP_RDMA_UFO_DEC_LENGTH_BASE_Y,
> +			     rdma->ufo_dec_y, 0xFFFFFFFF);
> +		MM_REG_WRITE(cmd, subsys_id,
> +			     base, MDP_RDMA_UFO_DEC_LENGTH_BASE_C,
> +			     rdma->ufo_dec_c, 0xFFFFFFFF);
> +		/* Set 10bit source frame pitch */
> +		if (block10bit)
> +			MM_REG_WRITE(cmd, subsys_id,
> +				     base, MDP_RDMA_MF_BKGD_SIZE_IN_PXL,
> +				     rdma->mf_bkgd_in_pxl, 0x001FFFFF);
> +	}
> +#endif
> +	MM_REG_WRITE(cmd, subsys_id, base, MDP_RDMA_CON, rdma->control,
> +		     0x00001110);
> +	/* Setup source buffer base */
> +	MM_REG_WRITE(cmd, subsys_id, base, MDP_RDMA_SRC_BASE_0, rdma->iova[0],
> +		     0xFFFFFFFF);
> +	MM_REG_WRITE(cmd, subsys_id, base, MDP_RDMA_SRC_BASE_1, rdma->iova[1],
> +		     0xFFFFFFFF);
> +	MM_REG_WRITE(cmd, subsys_id, base, MDP_RDMA_SRC_BASE_2, rdma->iova[2],
> +		     0xFFFFFFFF);
> +	/* Setup source buffer end */
> +	MM_REG_WRITE(cmd, subsys_id, base, MDP_RDMA_SRC_END_0,
> +		     rdma->iova_end[0], 0xFFFFFFFF);
> +	MM_REG_WRITE(cmd, subsys_id, base, MDP_RDMA_SRC_END_1,
> +		     rdma->iova_end[1], 0xFFFFFFFF);
> +	MM_REG_WRITE(cmd, subsys_id, base, MDP_RDMA_SRC_END_2,
> +		     rdma->iova_end[2], 0xFFFFFFFF);
> +	/* Setup source frame pitch */
> +	MM_REG_WRITE(cmd, subsys_id, base, MDP_RDMA_MF_BKGD_SIZE_IN_BYTE,
> +		     rdma->mf_bkgd, 0x001FFFFF);
> +	MM_REG_WRITE(cmd, subsys_id, base, MDP_RDMA_SF_BKGD_SIZE_IN_BYTE,
> +		     rdma->sf_bkgd, 0x001FFFFF);
> +	/* Setup color transform */
> +	MM_REG_WRITE(cmd, subsys_id, base, MDP_RDMA_TRANSFORM_0,
> +		     rdma->transform, 0x0F110000);
> +
> +	return 0;
> +}
> +
> +static int config_rdma_subfrm(struct mdp_comp_ctx *ctx,
> +			      struct mdp_cmd *cmd, u32 index)
> +{
> +	const struct mdp_rdma_subfrm *subfrm =3D &ctx->param->rdma.subfrms[inde=
x];
> +	const struct img_comp_subfrm *csf =3D &ctx->param->subfrms[index];
> +	u32 colorformat =3D ctx->input->buffer.format.colorformat;
> +	bool block10bit =3D MDP_COLOR_IS_10BIT_PACKED(colorformat);
> +	bool en_ufo =3D MDP_COLOR_IS_UFP(colorformat);
> +	phys_addr_t base =3D ctx->comp->reg_base;
> +	u8 subsys_id =3D ctx->comp->subsys_id;
> +
> +	/* Enable RDMA */
> +	MM_REG_WRITE(cmd, subsys_id, base, MDP_RDMA_EN, 0x00000001,
> +		     0x00000001);
> +
> +	/* Set Y pixel offset */
> +	MM_REG_WRITE(cmd, subsys_id, base, MDP_RDMA_SRC_OFFSET_0,
> +		     subfrm->offset[0], 0xFFFFFFFF);
> +#if RDMA_SUPPORT_10BIT
> +	/* Set 10bit UFO mode */
> +	if (block10bit && en_ufo)
> +		MM_REG_WRITE(cmd, subsys_id, base, MDP_RDMA_SRC_OFFSET_0_P,
> +			     subfrm->offset_0_p, 0xFFFFFFFF);
> +#endif
> +	/* Set U pixel offset */
> +	MM_REG_WRITE(cmd, subsys_id, base, MDP_RDMA_SRC_OFFSET_1,
> +		     subfrm->offset[1], 0xFFFFFFFF);
> +	/* Set V pixel offset */
> +	MM_REG_WRITE(cmd, subsys_id, base, MDP_RDMA_SRC_OFFSET_2,
> +		     subfrm->offset[2], 0xFFFFFFFF);
> +	/* Set source size */
> +	MM_REG_WRITE(cmd, subsys_id, base, MDP_RDMA_MF_SRC_SIZE, subfrm->src,
> +		     0x1FFF1FFF);
> +	/* Set target size */
> +	MM_REG_WRITE(cmd, subsys_id, base, MDP_RDMA_MF_CLIP_SIZE,
> +		     subfrm->clip, 0x1FFF1FFF);
> +	/* Set crop offset */
> +	MM_REG_WRITE(cmd, subsys_id, base, MDP_RDMA_MF_OFFSET_1,
> +		     subfrm->clip_ofst, 0x003F001F);
> +
> +#if RDMA_UPSAMPLE_REPEAT_ONLY
> +	if ((csf->in.right - csf->in.left + 1) > 320)
> +		MM_REG_WRITE(cmd, subsys_id, base, MDP_RDMA_RESV_DUMMY_0,
> +			     0x00000004, 0x00000004);
> +#endif
> +
> +	return 0;
> +}
> +
> +static int wait_rdma_event(struct mdp_comp_ctx *ctx, struct mdp_cmd *cmd=
)
> +{
> +	phys_addr_t base =3D ctx->comp->reg_base;
> +	u8 subsys_id =3D ctx->comp->subsys_id;
> +
> +	if (ctx->comp->alias_id =3D=3D 0)
> +		MM_REG_WAIT(cmd, RDMA0_DONE);
> +	else
> +		pr_err("Do not support RDMA1_DONE event\n");
> +
> +	/* Disable RDMA */
> +	MM_REG_WRITE(cmd, subsys_id, base, MDP_RDMA_EN, 0x00000000,
> +		     0x00000001);
> +	return 0;
> +}
> +
> +static const struct mdp_comp_ops rdma_ops =3D {
> +	.get_comp_flag =3D get_comp_flag,
> +	.init_comp =3D init_rdma,
> +	.config_frame =3D config_rdma_frame,
> +	.config_subfrm =3D config_rdma_subfrm,
> +	/* .reconfig_frame =3D reconfig_rdma_frame, */
> +	/* .reconfig_subfrms =3D reconfig_rdma_subfrms, */
> +	.wait_comp_event =3D wait_rdma_event,
> +	.advance_subfrm =3D NULL,
> +	.post_process =3D NULL,
> +};
> +
> +static int init_rsz(struct mdp_comp_ctx *ctx, struct mdp_cmd *cmd)
> +{
> +	phys_addr_t base =3D ctx->comp->reg_base;
> +	u8 subsys_id =3D ctx->comp->subsys_id;
> +
> +	/* Reset RSZ */
> +	MM_REG_WRITE(cmd, subsys_id, base, PRZ_ENABLE, 0x00010000,
> +		     0x00010000);
> +	MM_REG_WRITE(cmd, subsys_id, base, PRZ_ENABLE, 0x00000000,
> +		     0x00010000);
> +	/* Enable RSZ */
> +	MM_REG_WRITE(cmd, subsys_id, base, PRZ_ENABLE, 0x00000001,
> +		     0x00000001);
> +	return 0;
> +}
> +
> +static int config_rsz_frame(struct mdp_comp_ctx *ctx, struct mdp_cmd *cm=
d,
> +			    const struct v4l2_rect *compose)
> +{
> +	const struct mdp_rsz_data *rsz =3D &ctx->param->rsz;
> +	phys_addr_t base =3D ctx->comp->reg_base;
> +	u8 subsys_id =3D ctx->comp->subsys_id;
> +
> +	if (ctx->param->frame.bypass) {
> +		/* Disable RSZ */
> +		MM_REG_WRITE(cmd, subsys_id, base, PRZ_ENABLE, 0x00000000,
> +			     0x00000001);
> +
> +		return 0;
> +	}
> +
> +	MM_REG_WRITE(cmd, subsys_id, base, PRZ_CONTROL_1, rsz->control1,
> +		     0x03FFFDF3);
> +	MM_REG_WRITE(cmd, subsys_id, base, PRZ_CONTROL_2, rsz->control2,
> +		     0x0FFFC290);
> +	MM_REG_WRITE(cmd, subsys_id, base, PRZ_HORIZONTAL_COEFF_STEP,
> +		     rsz->coeff_step_x, 0x007FFFFF);
> +	MM_REG_WRITE(cmd, subsys_id, base, PRZ_VERTICAL_COEFF_STEP,
> +		     rsz->coeff_step_y, 0x007FFFFF);
> +	return 0;
> +}
> +
> +static int config_rsz_subfrm(struct mdp_comp_ctx *ctx,
> +			     struct mdp_cmd *cmd, u32 index)
> +{
> +	const struct mdp_rsz_subfrm *subfrm =3D &ctx->param->rsz.subfrms[index]=
;
> +	const struct img_comp_subfrm *csf =3D &ctx->param->subfrms[index];
> +	phys_addr_t base =3D ctx->comp->reg_base;
> +	u8 subsys_id =3D ctx->comp->subsys_id;
> +
> +	MM_REG_WRITE(cmd, subsys_id, base, PRZ_CONTROL_2, subfrm->control2,
> +		     0x00003800);
> +	MM_REG_WRITE(cmd, subsys_id, base, PRZ_INPUT_IMAGE, subfrm->src,
> +		     0xFFFFFFFF);
> +#if RSZ_DISABLE_DCM_SMALL_TILE
> +	if ((csf->in.right - csf->in.left + 1) <=3D 16)
> +		MM_REG_WRITE(cmd, subsys_id, base, PRZ_CONTROL_1, 1 << 27,
> +			     1 << 27);
> +#endif
> +	MM_REG_WRITE(cmd, subsys_id, base, PRZ_LUMA_HORIZONTAL_INTEGER_OFFSET,
> +		     csf->luma.left, 0x0000FFFF);
> +	MM_REG_WRITE(cmd, subsys_id,
> +		     base, PRZ_LUMA_HORIZONTAL_SUBPIXEL_OFFSET,
> +		     csf->luma.left_subpix, 0x001FFFFF);
> +	MM_REG_WRITE(cmd, subsys_id, base, PRZ_LUMA_VERTICAL_INTEGER_OFFSET,
> +		     csf->luma.top, 0x0000FFFF);
> +	MM_REG_WRITE(cmd, subsys_id, base, PRZ_LUMA_VERTICAL_SUBPIXEL_OFFSET,
> +		     csf->luma.top_subpix, 0x001FFFFF);
> +	MM_REG_WRITE(cmd, subsys_id,
> +		     base, PRZ_CHROMA_HORIZONTAL_INTEGER_OFFSET,
> +		     csf->chroma.left, 0x0000FFFF);
> +	MM_REG_WRITE(cmd, subsys_id,
> +		     base, PRZ_CHROMA_HORIZONTAL_SUBPIXEL_OFFSET,
> +		     csf->chroma.left_subpix, 0x001FFFFF);
> +
> +	MM_REG_WRITE(cmd, subsys_id, base, PRZ_OUTPUT_IMAGE, subfrm->clip,
> +		     0xFFFFFFFF);
> +
> +	return 0;
> +}
> +
> +static int advance_rsz_subfrm(struct mdp_comp_ctx *ctx,
> +			      struct mdp_cmd *cmd, u32 index)
> +{
> +#if RSZ_DISABLE_DCM_SMALL_TILE
> +	const struct img_comp_subfrm *csf =3D &ctx->param->subfrms[index];
> +	phys_addr_t base =3D ctx->comp->reg_base;
> +	u8 subsys_id =3D ctx->comp->subsys_id;
> +
> +	if ((csf->in.right - csf->in.left + 1) <=3D 16)
> +		MM_REG_WRITE(cmd, subsys_id, base, PRZ_CONTROL_1, 0, 1 << 27);
> +#endif
> +	return 0;
> +}
> +
> +static const struct mdp_comp_ops rsz_ops =3D {
> +	.get_comp_flag =3D get_comp_flag,
> +	.init_comp =3D init_rsz,
> +	.config_frame =3D config_rsz_frame,
> +	.config_subfrm =3D config_rsz_subfrm,
> +	/* .reconfig_frame =3D NULL, */
> +	/* .reconfig_subfrms =3D NULL, */
> +	.wait_comp_event =3D NULL,
> +	.advance_subfrm =3D advance_rsz_subfrm,
> +	.post_process =3D NULL,
> +};
> +
> +static int init_wrot(struct mdp_comp_ctx *ctx, struct mdp_cmd *cmd)
> +{
> +	phys_addr_t base =3D ctx->comp->reg_base;
> +	u8 subsys_id =3D ctx->comp->subsys_id;
> +
> +#if WROT_FILTER_CONSTRAINT
> +	/* Wait WROT SRAM shared to DISP RDMA */
> +	if (ctx->comp->alias_id =3D=3D 0)
> +		pr_err("Do not support WROT0_SRAM_READY event\n");
> +	else
> +		pr_err("Do not support WROT1_SRAM_READY event\n");
> +#endif
> +	/* Reset WROT */
> +	MM_REG_WRITE(cmd, subsys_id, base, VIDO_SOFT_RST, 0x01, 0x00000001);
> +	MM_REG_POLL(cmd, subsys_id, base, VIDO_SOFT_RST_STAT, 0x01,
> +		    0x00000001);
> +	MM_REG_WRITE(cmd, subsys_id, base, VIDO_SOFT_RST, 0x00, 0x00000001);
> +	MM_REG_POLL(cmd, subsys_id, base, VIDO_SOFT_RST_STAT, 0x00,
> +		    0x00000001);
> +	return 0;
> +}
> +
> +static int config_wrot_frame(struct mdp_comp_ctx *ctx, struct mdp_cmd *c=
md,
> +			     const struct v4l2_rect *compose)
> +{
> +	const struct mdp_wrot_data *wrot =3D &ctx->param->wrot;
> +	phys_addr_t base =3D ctx->comp->reg_base;
> +	u8 subsys_id =3D ctx->comp->subsys_id;
> +
> +	/* Write frame base address */
> +	MM_REG_WRITE(cmd, subsys_id, base, VIDO_BASE_ADDR, wrot->iova[0],
> +		     0xFFFFFFFF);
> +	MM_REG_WRITE(cmd, subsys_id, base, VIDO_BASE_ADDR_C, wrot->iova[1],
> +		     0xFFFFFFFF);
> +	MM_REG_WRITE(cmd, subsys_id, base, VIDO_BASE_ADDR_V, wrot->iova[2],
> +		     0xFFFFFFFF);
> +	/* Write frame related registers */
> +	MM_REG_WRITE(cmd, subsys_id, base, VIDO_CTRL, wrot->control,
> +		     0xF131510F);
> +	/* Write frame Y pitch */
> +	MM_REG_WRITE(cmd, subsys_id, base, VIDO_STRIDE, wrot->stride[0],
> +		     0x0000FFFF);
> +	/* Write frame UV pitch */
> +	MM_REG_WRITE(cmd, subsys_id, base, VIDO_STRIDE_C, wrot->stride[1],
> +		     0x0000FFFF);
> +	MM_REG_WRITE(cmd, subsys_id, base, VIDO_STRIDE_V, wrot->stride[2],
> +		     0x0000FFFF);
> +	/* Write matrix control */
> +	MM_REG_WRITE(cmd, subsys_id, base, VIDO_MAT_CTRL, wrot->mat_ctrl,
> +		     0x000000F3);
> +
> +	/* Set the fixed ALPHA as 0xFF */
> +	MM_REG_WRITE(cmd, subsys_id, base, VIDO_DITHER, 0xFF000000,
> +		     0xFF000000);
> +	/* Set VIDO_EOL_SEL */
> +	MM_REG_WRITE(cmd, subsys_id, base, VIDO_RSV_1, 0x80000000,
> +		     0x80000000);
> +	/* Set VIDO_FIFO_TEST */
> +	if (wrot->fifo_test !=3D 0)
> +		MM_REG_WRITE(cmd, subsys_id, base, VIDO_FIFO_TEST,
> +			     wrot->fifo_test, 0x00000FFF);
> +
> +#if WROT_FILTER_CONSTRAINT
> +	/* Filter enable */
> +	MM_REG_WRITE(cmd, subsys_id, base, VIDO_MAIN_BUF_SIZE, wrot->filter,
> +		     0x00000077);
> +#endif
> +
> +	return 0;
> +}
> +
> +static int config_wrot_subfrm(struct mdp_comp_ctx *ctx,
> +			      struct mdp_cmd *cmd, u32 index)
> +{
> +	const struct mdp_wrot_subfrm *subfrm =3D &ctx->param->wrot.subfrms[inde=
x];
> +	phys_addr_t base =3D ctx->comp->reg_base;
> +	u8 subsys_id =3D ctx->comp->subsys_id;
> +
> +	/* Write Y pixel offset */
> +	MM_REG_WRITE(cmd, subsys_id, base, VIDO_OFST_ADDR,
> +		     subfrm->offset[0], 0x0FFFFFFF);
> +	/* Write U pixel offset */
> +	MM_REG_WRITE(cmd, subsys_id, base, VIDO_OFST_ADDR_C,
> +		     subfrm->offset[1], 0x0FFFFFFF);
> +	/* Write V pixel offset */
> +	MM_REG_WRITE(cmd, subsys_id, base, VIDO_OFST_ADDR_V,
> +		     subfrm->offset[2], 0x0FFFFFFF);
> +	/* Write source size */
> +	MM_REG_WRITE(cmd, subsys_id, base, VIDO_IN_SIZE, subfrm->src,
> +		     0x1FFF1FFF);
> +	/* Write target size */
> +	MM_REG_WRITE(cmd, subsys_id, base, VIDO_TAR_SIZE, subfrm->clip,
> +		     0x1FFF1FFF);
> +	MM_REG_WRITE(cmd, subsys_id, base, VIDO_CROP_OFST, subfrm->clip_ofst,
> +		     0x1FFF1FFF);
> +
> +	MM_REG_WRITE(cmd, subsys_id, base, VIDO_MAIN_BUF_SIZE,
> +		     subfrm->main_buf, 0x1FFF7F00);
> +
> +	/* Enable WROT */
> +	MM_REG_WRITE(cmd, subsys_id, base, VIDO_ROT_EN, 0x01, 0x00000001);
> +
> +	return 0;
> +}
> +
> +static int wait_wrot_event(struct mdp_comp_ctx *ctx, struct mdp_cmd *cmd=
)
> +{
> +	phys_addr_t base =3D ctx->comp->reg_base;
> +	u8 subsys_id =3D ctx->comp->subsys_id;
> +
> +	if (ctx->comp->alias_id =3D=3D 0)
> +		MM_REG_WAIT(cmd, WROT0_DONE);
> +	else
> +		pr_err("Do not support WROT1_DONE event\n");
> +#if WROT_FILTER_CONSTRAINT
> +	/* Filter disable */
> +	MM_REG_WRITE(cmd, subsys_id, base, VIDO_MAIN_BUF_SIZE,
> +		     (0 << 4) +
> +		(0 << 0),
> +		0x00000077);
> +#endif
> +	/* Disable WROT */
> +	MM_REG_WRITE(cmd, subsys_id, base, VIDO_ROT_EN, 0x00, 0x00000001);
> +
> +	return 0;
> +}
> +
> +static const struct mdp_comp_ops wrot_ops =3D {
> +	.get_comp_flag =3D get_comp_flag,
> +	.init_comp =3D init_wrot,
> +	.config_frame =3D config_wrot_frame,
> +	.config_subfrm =3D config_wrot_subfrm,
> +	/* .reconfig_frame =3D reconfig_wrot_frame, */
> +	/* .reconfig_subfrms =3D reconfig_wrot_subfrms, */
> +	.wait_comp_event =3D wait_wrot_event,
> +	.advance_subfrm =3D NULL,
> +	.post_process =3D NULL,
> +};
> +
> +static int init_wdma(struct mdp_comp_ctx *ctx, struct mdp_cmd *cmd)
> +{
> +	phys_addr_t base =3D ctx->comp->reg_base;
> +	u8 subsys_id =3D ctx->comp->subsys_id;
> +
> +	/* Reset WDMA */
> +	MM_REG_WRITE(cmd, subsys_id, base, WDMA_RST, 0x1, 0x00000001);
> +	MM_REG_POLL(cmd, subsys_id, base, WDMA_FLOW_CTRL_DBG, 0x01,
> +		    0x00000001);
> +	MM_REG_WRITE(cmd, subsys_id, base, WDMA_RST, 0x0, 0x00000001);
> +	return 0;
> +}
> +
> +static int config_wdma_frame(struct mdp_comp_ctx *ctx, struct mdp_cmd *c=
md,
> +			     const struct v4l2_rect *compose)
> +{
> +	const struct mdp_wdma_data *wdma =3D &ctx->param->wdma;
> +	phys_addr_t base =3D ctx->comp->reg_base;
> +	u8 subsys_id =3D ctx->comp->subsys_id;
> +
> +	MM_REG_WRITE(cmd, subsys_id, base, WDMA_BUF_CON2, 0x10101050,
> +		     0xFFFFFFFF);
> +
> +	/* Setup frame information */
> +	MM_REG_WRITE(cmd, subsys_id, base, WDMA_CFG, wdma->wdma_cfg,
> +		     0x0F01B8F0);
> +	/* Setup frame base address */
> +	MM_REG_WRITE(cmd, subsys_id, base, WDMA_DST_ADDR,   wdma->iova[0],
> +		     0xFFFFFFFF);
> +	MM_REG_WRITE(cmd, subsys_id, base, WDMA_DST_U_ADDR, wdma->iova[1],
> +		     0xFFFFFFFF);
> +	MM_REG_WRITE(cmd, subsys_id, base, WDMA_DST_V_ADDR, wdma->iova[2],
> +		     0xFFFFFFFF);
> +	/* Setup Y pitch */
> +	MM_REG_WRITE(cmd, subsys_id, base, WDMA_DST_W_IN_BYTE,
> +		     wdma->w_in_byte, 0x0000FFFF);
> +	/* Setup UV pitch */
> +	MM_REG_WRITE(cmd, subsys_id, base, WDMA_DST_UV_PITCH,
> +		     wdma->uv_stride, 0x0000FFFF);
> +	/* Set the fixed ALPHA as 0xFF */
> +	MM_REG_WRITE(cmd, subsys_id, base, WDMA_ALPHA, 0x800000FF,
> +		     0x800000FF);
> +
> +	return 0;
> +}
> +
> +static int config_wdma_subfrm(struct mdp_comp_ctx *ctx,
> +			      struct mdp_cmd *cmd, u32 index)
> +{
> +	const struct mdp_wdma_subfrm *subfrm =3D &ctx->param->wdma.subfrms[inde=
x];
> +	phys_addr_t base =3D ctx->comp->reg_base;
> +	u8 subsys_id =3D ctx->comp->subsys_id;
> +
> +	/* Write Y pixel offset */
> +	MM_REG_WRITE(cmd, subsys_id, base, WDMA_DST_ADDR_OFFSET,
> +		     subfrm->offset[0], 0x0FFFFFFF);
> +	/* Write U pixel offset */
> +	MM_REG_WRITE(cmd, subsys_id, base, WDMA_DST_U_ADDR_OFFSET,
> +		     subfrm->offset[1], 0x0FFFFFFF);
> +	/* Write V pixel offset */
> +	MM_REG_WRITE(cmd, subsys_id, base, WDMA_DST_V_ADDR_OFFSET,
> +		     subfrm->offset[2], 0x0FFFFFFF);
> +	/* Write source size */
> +	MM_REG_WRITE(cmd, subsys_id, base, WDMA_SRC_SIZE, subfrm->src,
> +		     0x3FFF3FFF);
> +	/* Write target size */
> +	MM_REG_WRITE(cmd, subsys_id, base, WDMA_CLIP_SIZE, subfrm->clip,
> +		     0x3FFF3FFF);
> +	/* Write clip offset */
> +	MM_REG_WRITE(cmd, subsys_id, base, WDMA_CLIP_COORD, subfrm->clip_ofst,
> +		     0x3FFF3FFF);
> +
> +	/* Enable WDMA */
> +	MM_REG_WRITE(cmd, subsys_id, base, WDMA_EN, 0x01, 0x00000001);
> +
> +	return 0;
> +}
> +
> +static int wait_wdma_event(struct mdp_comp_ctx *ctx, struct mdp_cmd *cmd=
)
> +{
> +	phys_addr_t base =3D ctx->comp->reg_base;
> +	u8 subsys_id =3D ctx->comp->subsys_id;
> +
> +	MM_REG_WAIT(cmd, WDMA0_DONE);
> +	/* Disable WDMA */
> +	MM_REG_WRITE(cmd, subsys_id, base, WDMA_EN, 0x00, 0x00000001);
> +	return 0;
> +}
> +
> +static const struct mdp_comp_ops wdma_ops =3D {
> +	.get_comp_flag =3D get_comp_flag,
> +	.init_comp =3D init_wdma,
> +	.config_frame =3D config_wdma_frame,
> +	.config_subfrm =3D config_wdma_subfrm,
> +	/* .reconfig_frame =3D reconfig_wdma_frame, */
> +	/* .reconfig_subfrms =3D reconfig_wdma_subfrms, */
> +	.wait_comp_event =3D wait_wdma_event,
> +	.advance_subfrm =3D NULL,
> +	.post_process =3D NULL,
> +};
> +
> +static int init_ccorr(struct mdp_comp_ctx *ctx, struct mdp_cmd *cmd)
> +{
> +	phys_addr_t base =3D ctx->comp->reg_base;
> +	u8 subsys_id =3D ctx->comp->subsys_id;
> +
> +	/* CCORR enable */
> +	MM_REG_WRITE(cmd, subsys_id, base, MDP_CCORR_EN, 0x1, 0x1);
> +	/* Relay mode */
> +	MM_REG_WRITE(cmd, subsys_id, base, MDP_CCORR_CFG, 0x1, 0x1);
> +	return 0;
> +}
> +
> +static int config_ccorr_frame(struct mdp_comp_ctx *ctx, struct mdp_cmd *=
cmd,
> +			      const struct v4l2_rect *compose)
> +{
> +	/* Disabled function */
> +	return 0;
> +}
> +
> +static int config_ccorr_subfrm(struct mdp_comp_ctx *ctx,
> +			       struct mdp_cmd *cmd, u32 index)
> +{
> +	const struct img_comp_subfrm *csf =3D &ctx->param->subfrms[index];
> +	phys_addr_t base =3D ctx->comp->reg_base;
> +	u8 subsys_id =3D ctx->comp->subsys_id;
> +	u32 hsize, vsize;
> +
> +	hsize =3D csf->in.right - csf->in.left + 1;
> +	vsize =3D csf->in.bottom - csf->in.top + 1;
> +	MM_REG_WRITE(cmd, subsys_id, base, MDP_CCORR_SIZE,
> +		     (hsize << 16) + (vsize <<  0), 0x1FFF1FFF);
> +	return 0;
> +}
> +
> +static const struct mdp_comp_ops ccorr_ops =3D {
> +	.get_comp_flag =3D get_comp_flag,
> +	.init_comp =3D init_ccorr,
> +	.config_frame =3D config_ccorr_frame,
> +	.config_subfrm =3D config_ccorr_subfrm,
> +	/* .reconfig_frame =3D NULL, */
> +	/* .reconfig_subfrms =3D NULL, */
> +	.wait_comp_event =3D NULL,
> +	.advance_subfrm =3D NULL,
> +	.post_process =3D NULL,
> +};
> +
> +static int init_isp(struct mdp_comp_ctx *ctx, struct mdp_cmd *cmd)
> +{
> +	const struct isp_data *isp =3D &ctx->param->isp;
> +	phys_addr_t mmsys =3D ctx->comp->mdp_dev->mmsys.reg_base;
> +	u8 subsys_id =3D ctx->comp->mdp_dev->mmsys.subsys_id;
> +
> +	/* Direct link */
> +	if (isp->dl_flags & (1 << MDP_CAMIN)) {
> +		mdp_dbg(2, "SW_RST ASYNC");
> +		/* Reset MDP_DL_ASYNC_TX */
> +		/* Bit  3: MDP_DL_ASYNC_TX / MDP_RELAY */
> +		MM_REG_WRITE(cmd, subsys_id, mmsys, MMSYS_SW0_RST_B, 0x0,
> +			     0x00000008);
> +		MM_REG_WRITE(cmd, subsys_id, mmsys, MMSYS_SW0_RST_B, 1 << 3,
> +			     0x00000008);
> +		/* Reset MDP_DL_ASYNC_RX */
> +		/* Bit  10: MDP_DL_ASYNC_RX */
> +		MM_REG_WRITE(cmd, subsys_id, mmsys, MMSYS_SW1_RST_B, 0x0,
> +			     0x00000400);
> +		MM_REG_WRITE(cmd, subsys_id, mmsys, MMSYS_SW1_RST_B, 1 << 10,
> +			     0x00000400);
> +
> +		/* Enable sof mode */
> +		MM_REG_WRITE(cmd, subsys_id, mmsys, ISP_RELAY_CFG_WD, 0 << 31,
> +			     0x80000000);
> +	}
> +
> +	if (isp->dl_flags & (1 << MDP_CAMIN2)) {
> +		mdp_dbg(2, "SW_RST ASYNC2");
> +		/* Reset MDP_DL_ASYNC2_TX */
> +		/* Bit  4: MDP_DL_ASYNC2_TX / MDP_RELAY2 */
> +		MM_REG_WRITE(cmd, subsys_id, mmsys, MMSYS_SW0_RST_B, 0x0,
> +			     0x00000010);
> +		MM_REG_WRITE(cmd, subsys_id, mmsys, MMSYS_SW0_RST_B, 1 << 4,
> +			     0x00000010);
> +		/* Reset MDP_DL_ASYNC2_RX */
> +		/* Bit  11: MDP_DL_ASYNC2_RX */
> +		MM_REG_WRITE(cmd, subsys_id, mmsys, MMSYS_SW1_RST_B, 0x0,
> +			     0x00000800);
> +		MM_REG_WRITE(cmd, subsys_id, mmsys, MMSYS_SW1_RST_B, 1 << 11,
> +			     0x00000800);
> +
> +		/* Enable sof mode */
> +		MM_REG_WRITE(cmd, subsys_id, mmsys, IPU_RELAY_CFG_WD, 0 << 31,
> +			     0x80000000);
> +	}
> +
> +	return 0;
> +}
> +
> +static int config_isp_frame(struct mdp_comp_ctx *ctx, struct mdp_cmd *cm=
d,
> +			    const struct v4l2_rect *compose)
> +{
> +	const struct isp_data *isp =3D &ctx->param->isp;
> +	phys_addr_t base =3D ctx->comp->reg_base;
> +	u8 subsys_id =3D ctx->comp->subsys_id;
> +
> +	/* DIP_X_SMX1I_BASE_ADDR, DIP_X_SMX1O_BASE_ADDR */
> +	MM_REG_WRITE_MASK(cmd, subsys_id, base, 0x2890, isp->smxi_iova[0],
> +			  0xFFFFFFFF);
> +	MM_REG_WRITE_MASK(cmd, subsys_id, base, 0x27D0, isp->smxi_iova[0],
> +			  0xFFFFFFFF);
> +	/* DIP_X_SMX2I_BASE_ADDR, DIP_X_SMX2O_BASE_ADDR */
> +	MM_REG_WRITE_MASK(cmd, subsys_id, base, 0x28C0, isp->smxi_iova[1],
> +			  0xFFFFFFFF);
> +	MM_REG_WRITE_MASK(cmd, subsys_id, base, 0x2800, isp->smxi_iova[1],
> +			  0xFFFFFFFF);
> +	/* DIP_X_SMX3I_BASE_ADDR, DIP_X_SMX3O_BASE_ADDR */
> +	MM_REG_WRITE_MASK(cmd, subsys_id, base, 0x28F0, isp->smxi_iova[2],
> +			  0xFFFFFFFF);
> +	MM_REG_WRITE_MASK(cmd, subsys_id, base, 0x2830, isp->smxi_iova[2],
> +			  0xFFFFFFFF);
> +	/* DIP_X_SMX4I_BASE_ADDR, DIP_X_SMX4O_BASE_ADDR */
> +	MM_REG_WRITE_MASK(cmd, subsys_id, base, 0x2920, isp->smxi_iova[3],
> +			  0xFFFFFFFF);
> +	MM_REG_WRITE_MASK(cmd, subsys_id, base, 0x2860, isp->smxi_iova[3],
> +			  0xFFFFFFFF);
> +
> +	switch (isp->cq_idx) {
> +	case ISP_DRV_DIP_CQ_THRE0:
> +		MM_REG_WRITE_MASK(cmd, subsys_id, base, 0x2208,
> +				  isp->cq_iova, 0xFFFFFFFF);
> +		break;
> +	case ISP_DRV_DIP_CQ_THRE1:
> +		MM_REG_WRITE_MASK(cmd, subsys_id, base, 0x2214,
> +				  isp->cq_iova, 0xFFFFFFFF);
> +		break;
> +	case ISP_DRV_DIP_CQ_THRE2:
> +		MM_REG_WRITE_MASK(cmd, subsys_id, base, 0x2220,
> +				  isp->cq_iova, 0xFFFFFFFF);
> +		break;
> +	case ISP_DRV_DIP_CQ_THRE3:
> +		MM_REG_WRITE_MASK(cmd, subsys_id, base, 0x222C,
> +				  isp->cq_iova, 0xFFFFFFFF);
> +		break;
> +	case ISP_DRV_DIP_CQ_THRE4:
> +		MM_REG_WRITE_MASK(cmd, subsys_id, base, 0x2238,
> +				  isp->cq_iova, 0xFFFFFFFF);
> +		break;
> +	case ISP_DRV_DIP_CQ_THRE5:
> +		MM_REG_WRITE_MASK(cmd, subsys_id, base, 0x2244,
> +				  isp->cq_iova, 0xFFFFFFFF);
> +		break;
> +	case ISP_DRV_DIP_CQ_THRE6:
> +		MM_REG_WRITE_MASK(cmd, subsys_id, base, 0x2250,
> +				  isp->cq_iova, 0xFFFFFFFF);
> +		break;
> +	case ISP_DRV_DIP_CQ_THRE7:
> +		MM_REG_WRITE_MASK(cmd, subsys_id, base, 0x225C,
> +				  isp->cq_iova, 0xFFFFFFFF);
> +		break;
> +	case ISP_DRV_DIP_CQ_THRE8:
> +		MM_REG_WRITE_MASK(cmd, subsys_id, base, 0x2268,
> +				  isp->cq_iova, 0xFFFFFFFF);
> +		break;
> +	case ISP_DRV_DIP_CQ_THRE9:
> +		MM_REG_WRITE_MASK(cmd, subsys_id, base, 0x2274,
> +				  isp->cq_iova, 0xFFFFFFFF);
> +		break;
> +	case ISP_DRV_DIP_CQ_THRE10:
> +		MM_REG_WRITE_MASK(cmd, subsys_id, base, 0x2280,
> +				  isp->cq_iova, 0xFFFFFFFF);
> +		break;
> +	case ISP_DRV_DIP_CQ_THRE11:
> +		MM_REG_WRITE_MASK(cmd, subsys_id, base, 0x228C,
> +				  isp->cq_iova, 0xFFFFFFFF);
> +		break;
> +	case ISP_DRV_DIP_CQ_THRE12:
> +		MM_REG_WRITE_MASK(cmd, subsys_id, base, 0x2298,
> +				  isp->cq_iova, 0xFFFFFFFF);
> +		break;
> +	case ISP_DRV_DIP_CQ_THRE13:
> +		MM_REG_WRITE_MASK(cmd, subsys_id, base, 0x22A4,
> +				  isp->cq_iova, 0xFFFFFFFF);
> +		break;
> +	case ISP_DRV_DIP_CQ_THRE14:
> +		MM_REG_WRITE_MASK(cmd, subsys_id, base, 0x22B0,
> +				  isp->cq_iova, 0xFFFFFFFF);
> +		break;
> +	/* From CQ15 to CQ18, these do not connect to GCE */
> +	default:
> +		mdp_err("Do not support this cq (%d)", isp->cq_idx);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int config_isp_subfrm(struct mdp_comp_ctx *ctx,
> +			     struct mdp_cmd *cmd, u32 index)
> +{
> +	phys_addr_t base =3D ctx->comp->reg_base;
> +	u8 subsys_id =3D ctx->comp->subsys_id;
> +
> +	MM_REG_WRITE_MASK(cmd, subsys_id, base, 0x2304,
> +			  ctx->param->isp.tpipe_iova[index], 0xFFFFFFFF);
> +	return 0;
> +}
> +
> +static int wait_isp_event(struct mdp_comp_ctx *ctx, struct mdp_cmd *cmd)
> +{
> +	const struct isp_data *isp =3D &ctx->param->isp;
> +	phys_addr_t base =3D ctx->comp->reg_base;
> +	u8 subsys_id =3D ctx->comp->subsys_id;
> +
> +	/* MDP_DL_SEL: select MDP_CROP */
> +	if (isp->dl_flags & (1 << MDP_CAMIN))
> +		MM_REG_WRITE_MASK(cmd, subsys_id, base, 0x0030, 0x00000000,
> +				  0x00000200);
> +	/* MDP2_DL_SEL: select MDP_CROP2 */
> +	if (isp->dl_flags & (1 << MDP_CAMIN2))
> +		MM_REG_WRITE_MASK(cmd, subsys_id, base, 0x0030, 0x00000000,
> +				  0x00000C00);
> +
> +	switch (isp->cq_idx) {
> +	case ISP_DRV_DIP_CQ_THRE0:
> +		MM_REG_WRITE_MASK(cmd, subsys_id, base, 0x2000, 0x0001,
> +				  0x00000001);
> +		MM_REG_WAIT(cmd, ISP_P2_0_DONE);
> +		break;
> +	case ISP_DRV_DIP_CQ_THRE1:
> +		MM_REG_WRITE_MASK(cmd, subsys_id, base, 0x2000, 0x0002,
> +				  0x00000002);
> +		MM_REG_WAIT(cmd, ISP_P2_1_DONE);
> +		break;
> +	case ISP_DRV_DIP_CQ_THRE2:
> +		MM_REG_WRITE_MASK(cmd, subsys_id, base, 0x2000, 0x0004,
> +				  0x00000004);
> +		MM_REG_WAIT(cmd, ISP_P2_2_DONE);
> +		break;
> +	case ISP_DRV_DIP_CQ_THRE3:
> +		MM_REG_WRITE_MASK(cmd, subsys_id, base, 0x2000, 0x0008,
> +				  0x00000008);
> +		MM_REG_WAIT(cmd, ISP_P2_3_DONE);
> +		break;
> +	case ISP_DRV_DIP_CQ_THRE4:
> +		MM_REG_WRITE_MASK(cmd, subsys_id, base, 0x2000, 0x0010,
> +				  0x00000010);
> +		MM_REG_WAIT(cmd, ISP_P2_4_DONE);
> +		break;
> +	case ISP_DRV_DIP_CQ_THRE5:
> +		MM_REG_WRITE_MASK(cmd, subsys_id, base, 0x2000, 0x0020,
> +				  0x00000020);
> +		MM_REG_WAIT(cmd, ISP_P2_5_DONE);
> +		break;
> +	case ISP_DRV_DIP_CQ_THRE6:
> +		MM_REG_WRITE_MASK(cmd, subsys_id, base, 0x2000, 0x0040,
> +				  0x00000040);
> +		MM_REG_WAIT(cmd, ISP_P2_6_DONE);
> +		break;
> +	case ISP_DRV_DIP_CQ_THRE7:
> +		MM_REG_WRITE_MASK(cmd, subsys_id, base, 0x2000, 0x0080,
> +				  0x00000080);
> +		MM_REG_WAIT(cmd, ISP_P2_7_DONE);
> +		break;
> +	case ISP_DRV_DIP_CQ_THRE8:
> +		MM_REG_WRITE_MASK(cmd, subsys_id, base, 0x2000, 0x0100,
> +				  0x00000100);
> +		MM_REG_WAIT(cmd, ISP_P2_8_DONE);
> +		break;
> +	case ISP_DRV_DIP_CQ_THRE9:
> +		MM_REG_WRITE_MASK(cmd, subsys_id, base, 0x2000, 0x0200,
> +				  0x00000200);
> +		MM_REG_WAIT(cmd, ISP_P2_9_DONE);
> +		break;
> +	case ISP_DRV_DIP_CQ_THRE10:
> +		MM_REG_WRITE_MASK(cmd, subsys_id, base, 0x2000, 0x0400,
> +				  0x00000400);
> +		MM_REG_WAIT(cmd, ISP_P2_10_DONE);
> +		break;
> +	case ISP_DRV_DIP_CQ_THRE11:
> +		MM_REG_WRITE_MASK(cmd, subsys_id, base, 0x2000, 0x0800,
> +				  0x00000800);
> +		MM_REG_WAIT(cmd, ISP_P2_11_DONE);
> +		break;
> +	case ISP_DRV_DIP_CQ_THRE12:
> +		MM_REG_WRITE_MASK(cmd, subsys_id, base, 0x2000, 0x1000,
> +				  0x00001000);
> +		MM_REG_WAIT(cmd, ISP_P2_12_DONE);
> +		break;
> +	case ISP_DRV_DIP_CQ_THRE13:
> +		MM_REG_WRITE_MASK(cmd, subsys_id, base, 0x2000, 0x2000,
> +				  0x00002000);
> +		MM_REG_WAIT(cmd, ISP_P2_13_DONE);
> +		break;
> +	case ISP_DRV_DIP_CQ_THRE14:
> +		MM_REG_WRITE_MASK(cmd, subsys_id, base, 0x2000, 0x4000,
> +				  0x00004000);
> +		MM_REG_WAIT(cmd, ISP_P2_14_DONE);
> +		break;
> +	/* From CQ15 to CQ18, these do not connect to GCE */
> +	default:
> +		mdp_err("Do not support this cq (%d)", isp->cq_idx);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct mdp_comp_ops imgi_ops =3D {
> +	.get_comp_flag =3D get_comp_flag,
> +	.init_comp =3D init_isp,
> +	.config_frame =3D config_isp_frame,
> +	.config_subfrm =3D config_isp_subfrm,
> +	/* .reconfig_frame =3D reconfig_isp_frame, */
> +	/* .reconfig_subfrms =3D reconfig_isp_subfrms, */
> +	.wait_comp_event =3D wait_isp_event,
> +	.advance_subfrm =3D NULL,
> +	.post_process =3D NULL,
> +};
> +
> +static int config_camin_subfrm(struct mdp_comp_ctx *ctx,
> +			       struct mdp_cmd *cmd, u32 index)
> +{
> +	const struct img_comp_subfrm *csf =3D &ctx->param->subfrms[index];
> +	phys_addr_t base =3D ctx->comp->reg_base;
> +	u8 subsys_id =3D ctx->comp->subsys_id;
> +	u32 isp_dl_w, isp_dl_h;
> +
> +	isp_dl_w =3D csf->in.right - csf->in.left + 1;
> +	isp_dl_h =3D csf->in.bottom - csf->in.top + 1;
> +
> +	/* Config for direct link */
> +	if (ctx->comp->alias_id =3D=3D 0) {
> +#ifdef MDP_ASYNC_CFG_WD
> +		MM_REG_WRITE(cmd, subsys_id, base, MDP_ASYNC_CFG_WD,
> +			     (isp_dl_h << 16) + isp_dl_w, 0x3FFF3FFF);
> +#endif
> +#ifdef ISP_RELAY_CFG_WD
> +		MM_REG_WRITE(cmd, subsys_id, base, ISP_RELAY_CFG_WD,
> +			     (isp_dl_h << 16) + isp_dl_w, 0x3FFF3FFF);
> +#endif
> +	} else {
> +#ifdef MDP_ASYNC_IPU_CFG_WD
> +		MM_REG_WRITE(cmd, subsys_id, base, MDP_ASYNC_IPU_CFG_WD,
> +			     (isp_dl_h << 16) + isp_dl_w, 0x3FFF3FFF);
> +#endif
> +#ifdef IPU_RELAY_CFG_WD
> +		MM_REG_WRITE(cmd, subsys_id, base, IPU_RELAY_CFG_WD,
> +			     (isp_dl_h << 16) + isp_dl_w, 0x3FFF3FFF);
> +#endif
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct mdp_comp_ops camin_ops =3D {
> +	.get_comp_flag =3D get_comp_flag,
> +	.init_comp =3D NULL,
> +	.config_frame =3D NULL,
> +	.config_subfrm =3D config_camin_subfrm,
> +	/* .reconfig_frame =3D NULL, */
> +	/* .reconfig_subfrms =3D NULL, */
> +	.wait_comp_event =3D NULL,
> +	.advance_subfrm =3D NULL,
> +	.post_process =3D NULL,
> +};
> +
> +static const struct mdp_comp_ops *mdp_comp_ops[MDP_COMP_TYPE_COUNT] =3D =
{
> +	[MDP_COMP_TYPE_RDMA] =3D		&rdma_ops,
> +	[MDP_COMP_TYPE_RSZ] =3D		&rsz_ops,
> +	[MDP_COMP_TYPE_WROT] =3D		&wrot_ops,
> +	[MDP_COMP_TYPE_WDMA] =3D		&wdma_ops,
> +	[MDP_COMP_TYPE_PATH] =3D		NULL,
> +
> +	[MDP_COMP_TYPE_CCORR] =3D		&ccorr_ops,
> +
> +	[MDP_COMP_TYPE_IMGI] =3D		&imgi_ops,
> +	[MDP_COMP_TYPE_EXTO] =3D		NULL,
> +	[MDP_COMP_TYPE_DL_PATH] =3D	&camin_ops,
> +};
> +
> +struct mdp_comp_match {
> +	enum mdp_comp_type	type;
> +	u32			alias_id;
> +};
> +
> +static const struct mdp_comp_match mdp_comp_matches[MDP_MAX_COMP_COUNT] =
=3D {
> +	[MDP_COMP_WPEI] =3D	{ MDP_COMP_TYPE_WPEI, 0 },
> +	[MDP_COMP_WPEO] =3D	{ MDP_COMP_TYPE_EXTO, 2 },
> +	[MDP_COMP_WPEI2] =3D	{ MDP_COMP_TYPE_WPEI, 1 },
> +	[MDP_COMP_WPEO2] =3D	{ MDP_COMP_TYPE_EXTO, 3 },
> +	[MDP_COMP_ISP_IMGI] =3D	{ MDP_COMP_TYPE_IMGI, 0 },
> +	[MDP_COMP_ISP_IMGO] =3D	{ MDP_COMP_TYPE_EXTO, 0 },
> +	[MDP_COMP_ISP_IMG2O] =3D	{ MDP_COMP_TYPE_EXTO, 1 },
> +
> +	[MDP_COMP_CAMIN] =3D	{ MDP_COMP_TYPE_DL_PATH, 0 },
> +	[MDP_COMP_CAMIN2] =3D	{ MDP_COMP_TYPE_DL_PATH, 1 },
> +	[MDP_COMP_RDMA0] =3D	{ MDP_COMP_TYPE_RDMA, 0 },
> +	[MDP_COMP_CCORR0] =3D	{ MDP_COMP_TYPE_CCORR, 0 },
> +	[MDP_COMP_RSZ0] =3D	{ MDP_COMP_TYPE_RSZ, 0 },
> +	[MDP_COMP_RSZ1] =3D	{ MDP_COMP_TYPE_RSZ, 1 },
> +	[MDP_COMP_PATH0_SOUT] =3D	{ MDP_COMP_TYPE_PATH, 0 },
> +	[MDP_COMP_PATH1_SOUT] =3D	{ MDP_COMP_TYPE_PATH, 1 },
> +	[MDP_COMP_WROT0] =3D	{ MDP_COMP_TYPE_WROT, 0 },
> +	[MDP_COMP_WDMA] =3D	{ MDP_COMP_TYPE_WDMA, 0 },
> +};
> +
> +static const char * const gce_event_names[MDP_MAX_EVENT_COUNT] =3D {
> +	[RDMA0_SOF] =3D "rdma0_sof",
> +	[RDMA0_DONE] =3D "rdma0_done",
> +	[RSZ0_SOF] =3D "rsz0_sof",
> +	[RSZ1_SOF] =3D "rsz1_sof",
> +	[TDSHP0_SOF] =3D "tdshp0_sof",
> +	[WROT0_SOF] =3D "wrot0_sof",
> +	[WROT0_DONE] =3D "wrot0_done",
> +	[WDMA0_SOF] =3D "wdma0_sof",
> +	[WDMA0_DONE] =3D "wdma0_done",
> +
> +	[ISP_P2_0_DONE] =3D "isp_p2_0_done",
> +	[ISP_P2_1_DONE] =3D "isp_p2_1_done",
> +	[ISP_P2_2_DONE] =3D "isp_p2_2_done",
> +	[ISP_P2_3_DONE] =3D "isp_p2_3_done",
> +	[ISP_P2_4_DONE] =3D "isp_p2_4_done",
> +	[ISP_P2_5_DONE] =3D "isp_p2_5_done",
> +	[ISP_P2_6_DONE] =3D "isp_p2_6_done",
> +	[ISP_P2_7_DONE] =3D "isp_p2_7_done",
> +	[ISP_P2_8_DONE] =3D "isp_p2_8_done",
> +	[ISP_P2_9_DONE] =3D "isp_p2_9_done",
> +	[ISP_P2_10_DONE] =3D "isp_p2_10_done",
> +	[ISP_P2_11_DONE] =3D "isp_p2_11_done",
> +	[ISP_P2_12_DONE] =3D "isp_p2_12_done",
> +	[ISP_P2_13_DONE] =3D "isp_p2_13_done",
> +	[ISP_P2_14_DONE] =3D "isp_p2_14_done",
> +
> +	[WPE_DONE] =3D "wpe_done",
> +	[WPE_B_DONE] =3D "wpe_b_done",
> +};
> +
> +static const struct of_device_id mdp_comp_dt_ids[] =3D {
> +	{
> +		.compatible =3D "mediatek,mt8183-mdp-rdma",
> +		.data =3D (void *)MDP_COMP_TYPE_RDMA,
> +	}, {
> +		.compatible =3D "mediatek,mt8183-mdp-ccorr",
> +		.data =3D (void *)MDP_COMP_TYPE_CCORR,
> +	}, {
> +		.compatible =3D "mediatek,mt8183-mdp-rsz",
> +		.data =3D (void *)MDP_COMP_TYPE_RSZ,
> +	}, {
> +		.compatible =3D "mediatek,mt8183-mdp-wrot",
> +		.data =3D (void *)MDP_COMP_TYPE_WROT,
> +	}, {
> +		.compatible =3D "mediatek,mt8183-mdp-wdma",
> +		.data =3D (void *)MDP_COMP_TYPE_WDMA,
> +	}, {
> +		.compatible =3D "mediatek,mt8183-mdp-path",
> +		.data =3D (void *)MDP_COMP_TYPE_PATH,
> +	}, {
> +		.compatible =3D "mediatek,mt8183-mdp-imgi",
> +		.data =3D (void *)MDP_COMP_TYPE_IMGI,
> +	}, {
> +		.compatible =3D "mediatek,mt8183-mdp-exto",
> +		.data =3D (void *)MDP_COMP_TYPE_EXTO,
> +	}, {
> +		.compatible =3D "mediatek,mt8183-mdp-dl",
> +		.data =3D (void *)MDP_COMP_TYPE_DL_PATH,
> +	},
> +	{}
> +};
> +
> +static int mdp_comp_get_id(enum mdp_comp_type type, u32 alias_id)
> +{
> +	int i;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(mdp_comp_matches); i++)
> +		if (mdp_comp_matches[i].type =3D=3D type &&
> +		    mdp_comp_matches[i].alias_id =3D=3D alias_id)
> +			return i;
> +	return -ENODEV;
> +}
> +
> +void mdp_comp_clock_on(struct device *dev, struct mdp_comp *comp)
> +{
> +	int i, err;
> +
> +	if (comp->comp_dev) {
> +		err =3D pm_runtime_get_sync(comp->comp_dev);
> +		if (err < 0)
> +			dev_err(dev,
> +				"Failed to get larb, err %d. type:%d id:%d\n",
> +				err, comp->type, comp->id);
> +	}
> +
> +	for (i =3D 0; i < ARRAY_SIZE(comp->clks); i++) {
> +		if (IS_ERR(comp->clks[i]))
> +			break;
> +		err =3D clk_prepare_enable(comp->clks[i]);
> +		if (err)
> +			dev_err(dev,
> +				"Failed to enable clock %d, err %d. type:%d id:%d\n",
> +				i, err, comp->type, comp->id);
> +	}
> +}
> +
> +void mdp_comp_clock_off(struct device *dev, struct mdp_comp *comp)
> +{
> +	int i;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(comp->clks); i++) {
> +		if (IS_ERR(comp->clks[i]))
> +			break;
> +		clk_disable_unprepare(comp->clks[i]);
> +	}
> +
> +	if (comp->comp_dev)
> +		pm_runtime_put(comp->comp_dev);
> +}
> +
> +void mdp_comp_clocks_on(struct device *dev, struct mdp_comp *comps, int =
num)
> +{
> +	int i;
> +
> +	for (i =3D 0; i < num; i++)
> +		mdp_comp_clock_on(dev, &comps[i]);
> +}
> +
> +void mdp_comp_clocks_off(struct device *dev, struct mdp_comp *comps, int=
 num)
> +{
> +	int i;
> +
> +	for (i =3D 0; i < num; i++)
> +		mdp_comp_clock_off(dev, &comps[i]);
> +}
> +
> +static int mdp_get_subsys_id(struct device *dev, struct device_node *nod=
e,
> +			     struct mdp_comp *comp)
> +{
> +	struct platform_device *comp_pdev;
> +	struct cmdq_client_reg  *cmdq_reg;
> +	int ret =3D 0;
> +
> +	if (!dev || !node || !comp)
> +		return -EINVAL;
> +
> +	comp_pdev =3D of_find_device_by_node(node);
> +
> +	if (!comp_pdev) {
> +		dev_err(dev, "get comp_pdev fail! comp id=3D%d type=3D%d\n",
> +			comp->id, comp->type);
> +		return -ENODEV;
> +	}
> +
> +	cmdq_reg =3D kzalloc(sizeof(*cmdq_reg), GFP_KERNEL);
> +	if (!cmdq_reg)
> +		return -ENOMEM;
> +
> +	ret =3D cmdq_dev_get_client_reg(&comp_pdev->dev, cmdq_reg, 0);
> +	if (ret !=3D 0) {
> +		dev_err(&comp_pdev->dev,
> +			"cmdq_dev_get_subsys fail!\n");
> +		kfree(cmdq_reg);
> +		return -EINVAL;
> +	}
> +
> +	comp->subsys_id =3D cmdq_reg->subsys;
> +	dev_err(&comp_pdev->dev, "subsys id=3D%d\n", cmdq_reg->subsys);
> +
> +	kfree(cmdq_reg);
> +
> +	return 0;
> +}
> +
> +static void __mdp_comp_init(struct mdp_dev *mdp, struct device_node *nod=
e,
> +			    struct mdp_comp *comp)
> +{
> +	struct resource res;
> +	phys_addr_t base;
> +
> +	if (of_address_to_resource(node, 0, &res) < 0)
> +		base =3D 0L;
> +	else
> +		base =3D 0L | res.start;
> +
> +	comp->mdp_dev =3D mdp;
> +	/* comp->dev_node =3D of_node_get(node); */
> +	comp->regs =3D of_iomap(node, 0);
> +	comp->reg_base =3D base;
> +}
> +
> +static int mdp_comp_init(struct mdp_dev *mdp, struct device_node *node,
> +			 struct mdp_comp *comp, enum mdp_comp_id id)
> +{
> +	struct device *dev =3D &mdp->pdev->dev;
> +	int i;
> +
> +	if (id < 0 || id >=3D MDP_MAX_COMP_COUNT) {
> +		dev_err(dev, "Invalid component id %d\n", id);
> +		return -EINVAL;
> +	}
> +
> +	__mdp_comp_init(mdp, node, comp);
> +	comp->type =3D mdp_comp_matches[id].type;
> +	comp->id =3D id;
> +	comp->alias_id =3D mdp_comp_matches[id].alias_id;
> +	comp->ops =3D mdp_comp_ops[comp->type];
> +
> +	for (i =3D 0; i < ARRAY_SIZE(comp->clks); i++) {
> +		comp->clks[i] =3D of_clk_get(node, i);
> +		if (IS_ERR(comp->clks[i]))
> +			break;
> +	}
> +
> +	mdp_get_subsys_id(dev, node, comp);
> +
> +	return 0;
> +}
> +
> +static struct mdp_comp *mdp_comp_create(struct mdp_dev *mdp,
> +					struct device_node *node,
> +					enum mdp_comp_id id)
> +{
> +	struct device *dev =3D &mdp->pdev->dev;
> +	struct mdp_comp *comp;
> +	int ret;
> +
> +	if (mdp->comp[id])
> +		return ERR_PTR(-EEXIST);
> +
> +	comp =3D devm_kzalloc(dev, sizeof(*comp), GFP_KERNEL);
> +	if (!comp)
> +		return ERR_PTR(-ENOMEM);
> +
> +	ret =3D mdp_comp_init(mdp, node, comp, id);
> +	if (ret) {
> +		kfree(comp);
> +		return ERR_PTR(ret);
> +	}
> +	mdp->comp[id] =3D comp;
> +
> +	dev_info(dev, "%s type:%d alias:%d id:%d base:%#x regs:%p\n",
> +		dev->of_node->name, comp->type, comp->alias_id, id,
> +		(u32)comp->reg_base, comp->regs);
> +	return comp;
> +}
> +
> +static int mdp_sub_comps_create(struct mdp_dev *mdp, struct device_node =
*node)
> +{
> +	struct device *dev =3D &mdp->pdev->dev;
> +	struct property *prop;
> +	const char *name;
> +	int index =3D 0;
> +
> +	of_property_for_each_string(node, "mdp-comps", prop, name) {
> +		const struct of_device_id *matches =3D mdp_comp_dt_ids;
> +		enum mdp_comp_type type =3D MDP_COMP_NONE;
> +		u32 alias_id;
> +		int id, ret;
> +		struct mdp_comp *comp;
> +
> +		for (; matches->compatible[0]; matches++) {
> +			if (of_compat_cmp(name, matches->compatible,
> +				strlen(matches->compatible)) =3D=3D 0) {
> +				type =3D (enum mdp_comp_type)matches->data;
> +				break;
> +			}
> +		}
> +
> +		ret =3D of_property_read_u32_index(node, "mdp-comp-ids",
> +			index, &alias_id);
> +		if (ret) {
> +			dev_warn(dev, "Skipping unknown component %s\n", name);
> +			return ret;
> +		}
> +
> +		id =3D mdp_comp_get_id(type, alias_id);
> +		if (id < 0) {
> +			dev_err(dev, "Failed to get component id: "
> +				"%s type %d, alias %d\n", name, type, alias_id);
> +			return -ENODEV;
> +		}
> +
> +		comp =3D mdp_comp_create(mdp, node, id);
> +		if (IS_ERR(comp))
> +			return PTR_ERR(comp);
> +
> +		index++;
> +	}
> +	return 0;
> +}
> +
> +static void mdp_comp_deinit(struct mdp_comp *comp)
> +{
> +	if (!comp)
> +		return;
> +
> +	if (comp->regs)
> +		iounmap(comp->regs);
> +	/* of_node_put(comp->dev_node); */
> +}
> +
> +static int mdp_imgi_init(struct mdp_dev *mdp, const char *ref_name)
> +{
> +	struct device_node *node;
> +	struct device *dev =3D &mdp->pdev->dev;
> +	int ret;
> +
> +	node =3D of_parse_phandle(dev->of_node, ref_name, 0);
> +	if (!node) {
> +		dev_err(dev, "Failed to parse dt %s\n", ref_name);
> +		return -EINVAL;
> +	}
> +
> +	ret =3D mdp_sub_comps_create(mdp, node);
> +	of_node_put(node);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static int mdp_mm_init(struct mdp_dev *mdp, struct mdp_comp *comp,
> +		       const char *ref_name)
> +{
> +	struct device_node *node;
> +	struct device *dev =3D &mdp->pdev->dev;
> +	int ret;
> +
> +	node =3D of_parse_phandle(dev->of_node, ref_name, 0);
> +	if (!node) {
> +		dev_err(dev, "Failed to parse dt %s\n", ref_name);
> +		return -EINVAL;
> +	}
> +
> +	__mdp_comp_init(mdp, node, comp);
> +	mdp_get_subsys_id(dev, node, comp);
> +	if (!comp->reg_base) {
> +		dev_err(dev, "Failed to init %s base\n", ref_name);
> +		of_node_put(node);
> +		return -EINVAL;
> +	}
> +
> +	ret =3D mdp_sub_comps_create(mdp, node);
> +	of_node_put(node);
> +	if (ret)
> +		return ret;
> +	return 0;
> +}
> +
> +void mdp_component_deinit(struct mdp_dev *mdp)
> +{
> +	int i;
> +
> +	mdp_comp_deinit(&mdp->mmsys);
> +	mdp_comp_deinit(&mdp->mm_mutex);
> +	for (i =3D 0; i < ARRAY_SIZE(mdp->comp); i++) {
> +		if (mdp->comp[i]) {
> +			mdp_comp_deinit(mdp->comp[i]);
> +			kfree(mdp->comp[i]);
> +		}
> +	}
> +}
> +
> +int mdp_component_init(struct mdp_dev *mdp)
> +{
> +	struct device *dev =3D &mdp->pdev->dev;
> +	struct device_node *node, *parent;
> +	struct platform_device *pdev;
> +	u32 alias_id;
> +	int i, ret;
> +
> +	for (i =3D RDMA0_SOF; i < MDP_MAX_EVENT_COUNT; i++) {
> +		s32 event_id;
> +
> +		if (!dev)
> +			return -EINVAL;
> +		if (of_property_read_u32_index(dev->of_node,
> +					       "mediatek,gce-events",
> +					       i, &event_id)) {
> +			dev_err(dev, "can't parse gce-events property");
> +
> +			return -ENODEV;
> +		}
> +		mdp->event[i] =3D (event_id < 0) ? -i : event_id;
> +		dev_info(dev, "Get event %s id:%d\n",
> +			 gce_event_names[i], mdp->event[i]);
> +	}
> +
> +	ret =3D mdp_mm_init(mdp, &mdp->mmsys, "mediatek,mmsys");
> +	if (ret)
> +		goto err_init_mm;
> +
> +	ret =3D mdp_mm_init(mdp, &mdp->mm_mutex, "mediatek,mm-mutex");
> +	if (ret)
> +		goto err_init_comps;
> +
> +	ret =3D mdp_imgi_init(mdp, "mediatek,imgsys");
> +	if (ret)
> +		goto err_init_comps;
> +
> +	parent =3D dev->of_node->parent;
> +	/* Iterate over sibling MDP function blocks */
> +	for_each_child_of_node(parent, node) {
> +		const struct of_device_id *of_id;
> +		enum mdp_comp_type type;
> +		int id;
> +		struct mdp_comp *comp;
> +
> +		of_id =3D of_match_node(mdp_comp_dt_ids, node);
> +		if (!of_id)
> +			continue;
> +
> +		if (!of_device_is_available(node)) {
> +			dev_info(dev, "Skipping disabled component %pOF\n",
> +				 node);
> +			continue;
> +		}
> +
> +		type =3D (enum mdp_comp_type)of_id->data;
> +		ret =3D of_property_read_u32(node, "mediatek,mdp-id", &alias_id);
> +		if (ret) {
> +			dev_warn(dev, "Skipping unknown component %pOF\n",
> +				 node);
> +			continue;
> +		}
> +		id =3D mdp_comp_get_id(type, alias_id);
> +		if (id < 0) {
> +			dev_err(dev,
> +				"Fail to get component id: type %d alias %d\n",
> +				type, alias_id);
> +			continue;
> +		}
> +
> +		comp =3D mdp_comp_create(mdp, node, id);
> +		if (IS_ERR(comp))
> +			goto err_init_comps;
> +
> +		ret =3D mdp_sub_comps_create(mdp, node);
> +		if (ret)
> +			goto err_init_comps;
> +
> +		/* Only DMA capable components need the pm control */
> +		comp->comp_dev =3D NULL;
> +		if (comp->type !=3D MDP_COMP_TYPE_RDMA &&
> +		    comp->type !=3D MDP_COMP_TYPE_WROT &&
> +			comp->type !=3D MDP_COMP_TYPE_WDMA)
> +			continue;
> +
> +		pdev =3D of_find_device_by_node(node);
> +		if (!pdev) {
> +			dev_warn(dev, "can't find platform device of node:%s\n",
> +				 node->name);
> +			return -ENODEV;
> +		}
> +
> +		comp->comp_dev =3D &pdev->dev;
> +		pm_runtime_enable(comp->comp_dev);
> +	}
> +	return 0;
> +
> +err_init_comps:
> +	mdp_component_deinit(mdp);
> +err_init_mm:
> +	return ret;
> +}
> +
> +int mdp_comp_ctx_init(struct mdp_dev *mdp, struct mdp_comp_ctx *ctx,
> +		      const struct img_compparam *param,
> +	const struct img_ipi_frameparam *frame)
> +{
> +	int i;
> +
> +	if (param->type < 0 || param->type >=3D MDP_MAX_COMP_COUNT) {
> +		mdp_err("Invalid component id %d", param->type);
> +		return -EINVAL;
> +	}
> +
> +	ctx->comp =3D mdp->comp[param->type];
> +	if (!ctx->comp) {
> +		mdp_err("Uninit component id %d", param->type);
> +		return -EINVAL;
> +	}
> +
> +	ctx->param =3D param;
> +	ctx->input =3D &frame->inputs[param->input];
> +	for (i =3D 0; i < param->num_outputs; i++)
> +		ctx->outputs[i] =3D &frame->outputs[param->outputs[i]];
> +	return 0;
> +}
> +
> diff --git a/drivers/media/platform/mtk-mdp3/mtk-mdp3-comp.h b/drivers/me=
dia/platform/mtk-mdp3/mtk-mdp3-comp.h
> new file mode 100644
> index 000000000000..f5d514a51236
> --- /dev/null
> +++ b/drivers/media/platform/mtk-mdp3/mtk-mdp3-comp.h
> @@ -0,0 +1,157 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2018 MediaTek Inc.
> + * Author: Ping-Hsun Wu <ping-hsun.wu@mediatek.com>
> + */
> +
> +#ifndef __MTK_MDP3_COMP_H__
> +#define __MTK_MDP3_COMP_H__
> +
> +#include "mtk-mdp3-cmdq.h"
> +
> +enum mdp_comp_type {
> +	MDP_COMP_TYPE_INVALID =3D 0,
> +
> +	MDP_COMP_TYPE_RDMA,
> +	MDP_COMP_TYPE_RSZ,
> +	MDP_COMP_TYPE_WROT,
> +	MDP_COMP_TYPE_WDMA,
> +	MDP_COMP_TYPE_PATH,
> +
> +	MDP_COMP_TYPE_TDSHP,
> +	MDP_COMP_TYPE_COLOR,
> +	MDP_COMP_TYPE_DRE,
> +	MDP_COMP_TYPE_CCORR,
> +	MDP_COMP_TYPE_HDR,
> +
> +	MDP_COMP_TYPE_IMGI,
> +	MDP_COMP_TYPE_WPEI,
> +	MDP_COMP_TYPE_EXTO,	/* External path */
> +	MDP_COMP_TYPE_DL_PATH,	/* Direct-link path */
> +
> +	MDP_COMP_TYPE_COUNT	/* ALWAYS keep at the end */
> +};
> +
> +enum mdp_comp_id {
> +	MDP_COMP_NONE =3D -1,	/* Invalid engine */
> +
> +	/* ISP */
> +	MDP_COMP_WPEI =3D 0,
> +	MDP_COMP_WPEO,		/* 1 */
> +	MDP_COMP_WPEI2,		/* 2 */
> +	MDP_COMP_WPEO2,		/* 3 */
> +	MDP_COMP_ISP_IMGI,	/* 4 */
> +	MDP_COMP_ISP_IMGO,	/* 5 */
> +	MDP_COMP_ISP_IMG2O,	/* 6 */
> +
> +	/* IPU */
> +	MDP_COMP_IPUI,		/* 7 */
> +	MDP_COMP_IPUO,		/* 8 */
> +
> +	/* MDP */
> +	MDP_COMP_CAMIN,		/* 9 */
> +	MDP_COMP_CAMIN2,	/* 10 */
> +	MDP_COMP_RDMA0,		/* 11 */
> +	MDP_COMP_AAL0,		/* 12 */
> +	MDP_COMP_CCORR0,	/* 13 */
> +	MDP_COMP_RSZ0,		/* 14 */
> +	MDP_COMP_RSZ1,		/* 15 */
> +	MDP_COMP_TDSHP0,	/* 16 */
> +	MDP_COMP_COLOR0,	/* 17 */
> +	MDP_COMP_PATH0_SOUT,	/* 18 */
> +	MDP_COMP_PATH1_SOUT,	/* 19 */
> +	MDP_COMP_WROT0,		/* 20 */
> +	MDP_COMP_WDMA,		/* 21 */
> +
> +	/* Dummy Engine */
> +	MDP_COMP_RDMA1,		/* 22 */
> +	MDP_COMP_RSZ2,		/* 23 */
> +	MDP_COMP_TDSHP1,	/* 24 */
> +	MDP_COMP_WROT1,		/* 25 */
> +
> +	MDP_MAX_COMP_COUNT	/* ALWAYS keep at the end */
> +};
> +
> +enum mdp_comp_event {
> +	RDMA0_SOF,
> +	RDMA0_DONE,
> +	RSZ0_SOF,
> +	RSZ1_SOF,
> +	TDSHP0_SOF,
> +	WROT0_SOF,
> +	WROT0_DONE,
> +	WDMA0_SOF,
> +	WDMA0_DONE,
> +
> +	ISP_P2_0_DONE,
> +	ISP_P2_1_DONE,
> +	ISP_P2_2_DONE,
> +	ISP_P2_3_DONE,
> +	ISP_P2_4_DONE,
> +	ISP_P2_5_DONE,
> +	ISP_P2_6_DONE,
> +	ISP_P2_7_DONE,
> +	ISP_P2_8_DONE,
> +	ISP_P2_9_DONE,
> +	ISP_P2_10_DONE,
> +	ISP_P2_11_DONE,
> +	ISP_P2_12_DONE,
> +	ISP_P2_13_DONE,
> +	ISP_P2_14_DONE,
> +
> +	WPE_DONE,
> +	WPE_B_DONE,
> +
> +	MDP_MAX_EVENT_COUNT	/* ALWAYS keep at the end */
> +};
> +
> +struct mdp_comp_ops;
> +
> +struct mdp_comp {
> +	struct mdp_dev			*mdp_dev;
> +	void __iomem			*regs;
> +	phys_addr_t			reg_base;
> +	u8				subsys_id;
> +	struct clk			*clks[4];
> +	struct device			*comp_dev;
> +	enum mdp_comp_type		type;
> +	enum mdp_comp_id		id;
> +	u32				alias_id;
> +	const struct mdp_comp_ops	*ops;
> +};
> +
> +struct mdp_comp_ctx {
> +	struct mdp_comp			*comp;
> +	const struct img_compparam	*param;
> +	const struct img_input		*input;
> +	const struct img_output		*outputs[IMG_MAX_HW_OUTPUTS];
> +};
> +
> +struct mdp_comp_ops {
> +	s64 (*get_comp_flag)(const struct mdp_comp_ctx *ctx);
> +	int (*init_comp)(struct mdp_comp_ctx *ctx, struct mdp_cmd *cmd);
> +	int (*config_frame)(struct mdp_comp_ctx *ctx, struct mdp_cmd *cmd,
> +			    const struct v4l2_rect *compose);
> +	int (*config_subfrm)(struct mdp_comp_ctx *ctx,
> +			     struct mdp_cmd *cmd, u32 index);
> +	int (*wait_comp_event)(struct mdp_comp_ctx *ctx,
> +			       struct mdp_cmd *cmd);
> +	int (*advance_subfrm)(struct mdp_comp_ctx *ctx,
> +			      struct mdp_cmd *cmd, u32 index);
> +	int (*post_process)(struct mdp_comp_ctx *ctx, struct mdp_cmd *cmd);
> +};
> +
> +struct mdp_dev;
> +
> +int mdp_component_init(struct mdp_dev *mdp);
> +void mdp_component_deinit(struct mdp_dev *mdp);
> +void mdp_comp_clock_on(struct device *dev, struct mdp_comp *comp);
> +void mdp_comp_clock_off(struct device *dev, struct mdp_comp *comp);
> +void mdp_comp_clocks_on(struct device *dev, struct mdp_comp *comps, int =
num);
> +void mdp_comp_clocks_off(struct device *dev, struct mdp_comp *comps, int=
 num);
> +int mdp_comp_ctx_init(struct mdp_dev *mdp, struct mdp_comp_ctx *ctx,
> +		      const struct img_compparam *param,
> +	const struct img_ipi_frameparam *frame);
> +
> +#endif  /* __MTK_MDP3_COMP_H__ */
> +
> diff --git a/drivers/media/platform/mtk-mdp3/mtk-mdp3-core.c b/drivers/me=
dia/platform/mtk-mdp3/mtk-mdp3-core.c
> new file mode 100644
> index 000000000000..a42e436d3a8c
> --- /dev/null
> +++ b/drivers/media/platform/mtk-mdp3/mtk-mdp3-core.c
> @@ -0,0 +1,266 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2018 MediaTek Inc.
> + * Author: Ping-Hsun Wu <ping-hsun.wu@mediatek.com>
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/module.h>
> +#include <linux/of_platform.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/remoteproc.h>
> +#include <linux/remoteproc/mtk_scp.h>
> +#include <media/videobuf2-dma-contig.h>
> +#include "mtk-mdp3-core.h"
> +#include "mtk-mdp3-debug.h"
> +#include "mtk-mdp3-m2m.h"
> +
> +/* MDP debug log level (0-3). 3 shows all the logs. */
> +int mtk_mdp_debug;
> +EXPORT_SYMBOL(mtk_mdp_debug);
> +module_param_named(debug, mtk_mdp_debug, int, 0644);
> +
> +static const struct of_device_id mdp_of_ids[] =3D {
> +	{ .compatible =3D "mediatek,mt8183-mdp3", },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, mdp_of_ids);
> +
> +struct platform_device *mdp_get_plat_device(struct platform_device *pdev=
)
> +{
> +	struct device *dev =3D &pdev->dev;
> +	struct device_node *mdp_node;
> +	struct platform_device *mdp_pdev;
> +
> +	mdp_node =3D of_parse_phandle(dev->of_node, "mediatek,mdp3", 0);
> +	if (!mdp_node) {
> +		dev_err(dev, "can't get mdp node\n");
> +		return NULL;
> +	}
> +
> +	mdp_pdev =3D of_find_device_by_node(mdp_node);
> +	of_node_put(mdp_node);
> +	if (WARN_ON(!mdp_pdev)) {
> +		dev_err(dev, "mdp pdev failed\n");
> +		return NULL;
> +	}
> +
> +	return mdp_pdev;
> +}
> +EXPORT_SYMBOL_GPL(mdp_get_plat_device);
> +
> +int mdp_vpu_get_locked(struct mdp_dev *mdp)
> +{
> +	int ret =3D 0;
> +
> +	if (mdp->vpu_count++ =3D=3D 0) {
> +		ret =3D rproc_boot(mdp->rproc_handle);
> +		if (ret) {
> +			dev_err(&mdp->pdev->dev,
> +				"vpu_load_firmware failed %d\n", ret);
> +			goto err_load_vpu;
> +		}
> +		ret =3D mdp_vpu_register(mdp);
> +		if (ret) {
> +			dev_err(&mdp->pdev->dev,
> +				"mdp_vpu register failed %d\n", ret);
> +			goto err_reg_vpu;
> +		}
> +		ret =3D mdp_vpu_dev_init(&mdp->vpu, mdp->scp, &mdp->vpu_lock);
> +		if (ret) {
> +			dev_err(&mdp->pdev->dev,
> +				"mdp_vpu device init failed %d\n", ret);
> +			goto err_init_vpu;
> +		}
> +	}
> +	return 0;
> +
> +err_init_vpu:
> +	mdp_vpu_unregister(mdp);
> +err_reg_vpu:
> +err_load_vpu:
> +	mdp->vpu_count--;
> +	return ret;
> +}
> +
> +void mdp_vpu_put_locked(struct mdp_dev *mdp)
> +{
> +	if (--mdp->vpu_count =3D=3D 0) {
> +		mdp_vpu_dev_deinit(&mdp->vpu);
> +		mdp_vpu_unregister(mdp);
> +	}
> +}
> +
> +static int mdp_probe(struct platform_device *pdev)
> +{
> +	struct device *dev =3D &pdev->dev;
> +	struct mdp_dev *mdp;
> +	int ret;
> +
> +	mdp =3D devm_kzalloc(dev, sizeof(*mdp), GFP_KERNEL);
> +	if (!mdp)
> +		return -ENOMEM;
> +
> +	mdp->pdev =3D pdev;
> +	ret =3D mdp_component_init(mdp);
> +	if (ret) {
> +		dev_err(dev, "Failed to initialize mdp components\n");
> +		goto err_return;
> +	}
> +
> +	mdp->job_wq =3D alloc_workqueue(MDP_MODULE_NAME, WQ_FREEZABLE, 0);
> +	if (!mdp->job_wq) {
> +		dev_err(dev, "Unable to create job workqueue\n");
> +		ret =3D -ENOMEM;
> +		goto err_deinit_comp;
> +	}
> +
> +	mdp->clock_wq =3D alloc_workqueue(MDP_MODULE_NAME "-clock", WQ_FREEZABL=
E,
> +					0);
> +	if (!mdp->clock_wq) {
> +		dev_err(dev, "Unable to create clock workqueue\n");
> +		ret =3D -ENOMEM;
> +		goto err_destroy_job_wq;
> +	}
> +
> +	mdp->scp =3D scp_get(pdev);
> +	if (!mdp->scp) {
> +		dev_err(&pdev->dev, "Could not get scp device\n");
> +		ret =3D -ENODEV;
> +		goto err_destroy_clock_wq;
> +	}
> +
> +	mdp->rproc_handle =3D scp_get_rproc(mdp->scp);
> +	dev_info(&pdev->dev, "MDP rproc_handle: %pK", mdp->rproc_handle);
> +
> +	mutex_init(&mdp->vpu_lock);
> +	mutex_init(&mdp->m2m_lock);
> +
> +	mdp->cmdq_clt =3D cmdq_mbox_create(dev, 0);
> +	if (IS_ERR(mdp->cmdq_clt)) {
> +		ret =3D PTR_ERR(mdp->cmdq_clt);
> +		goto err_put_scp;
> +	}
> +
> +	init_waitqueue_head(&mdp->callback_wq);
> +	ida_init(&mdp->mdp_ida);
> +	platform_set_drvdata(pdev, mdp);
> +
> +#ifdef MDP_DEBUG
> +	mdp_debug_init(pdev);
> +#endif
> +
> +	vb2_dma_contig_set_max_seg_size(&pdev->dev, DMA_BIT_MASK(32));
> +
> +	ret =3D v4l2_device_register(dev, &mdp->v4l2_dev);
> +	if (ret) {
> +		dev_err(dev, "Failed to register v4l2 device\n");
> +		ret =3D -EINVAL;
> +		goto err_mbox_destroy;
> +	}
> +
> +	ret =3D mdp_m2m_device_register(mdp);
> +	if (ret) {
> +		v4l2_err(&mdp->v4l2_dev, "Failed to register m2m device\n");
> +		goto err_unregister_device;
> +	}
> +
> +	dev_dbg(dev, "mdp-%d registered successfully\n", pdev->id);
> +	return 0;
> +
> +err_unregister_device:
> +	v4l2_device_unregister(&mdp->v4l2_dev);
> +err_mbox_destroy:
> +	cmdq_mbox_destroy(mdp->cmdq_clt);
> +err_put_scp:
> +	scp_put(mdp->scp);
> +err_destroy_clock_wq:
> +	destroy_workqueue(mdp->clock_wq);
> +err_destroy_job_wq:
> +	destroy_workqueue(mdp->job_wq);
> +err_deinit_comp:
> +		mdp_component_deinit(mdp);
> +err_return:
> +	dev_dbg(dev, "Errno %d\n", ret);
> +	return ret;
> +}
> +
> +static int mdp_remove(struct platform_device *pdev)
> +{
> +	struct mdp_dev *mdp =3D platform_get_drvdata(pdev);
> +
> +	mdp_m2m_device_unregister(mdp);
> +	v4l2_device_unregister(&mdp->v4l2_dev);
> +
> +	scp_put(mdp->scp);
> +
> +	destroy_workqueue(mdp->job_wq);
> +	destroy_workqueue(mdp->clock_wq);
> +
> +	pm_runtime_disable(&pdev->dev);
> +
> +	vb2_dma_contig_clear_max_seg_size(&pdev->dev);
> +	mdp_component_deinit(mdp);
> +
> +#ifdef MDP_DEBUG
> +	mdp_debug_deinit();
> +#endif
> +
> +	mdp_vpu_shared_mem_free(&mdp->vpu);
> +
> +	dev_dbg(&pdev->dev, "%s driver unloaded\n", pdev->name);
> +	return 0;
> +}
> +
> +static int __maybe_unused mdp_suspend(struct device *dev)
> +{
> +	struct mdp_dev *mdp =3D dev_get_drvdata(dev);
> +	int ret;
> +
> +	atomic_set(&mdp->suspended, 1);
> +
> +	if (atomic_read(&mdp->job_count)) {
> +		ret =3D wait_event_timeout(mdp->callback_wq,
> +					 !atomic_read(&mdp->job_count),
> +					 2 * HZ);
> +		if (ret =3D=3D 0) {
> +			dev_err(dev,
> +				"%s:flushed cmdq task incomplete, count=3D%d\n",
> +				__func__, atomic_read(&mdp->job_count));
> +			return -EBUSY;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int __maybe_unused mdp_resume(struct device *dev)
> +{
> +	struct mdp_dev *mdp =3D dev_get_drvdata(dev);
> +
> +	atomic_set(&mdp->suspended, 0);
> +
> +	return 0;
> +}
> +
> +static const struct dev_pm_ops mdp_pm_ops =3D {
> +	SET_SYSTEM_SLEEP_PM_OPS(mdp_suspend, mdp_resume)
> +};
> +
> +static struct platform_driver mdp_driver =3D {
> +	.probe		=3D mdp_probe,
> +	.remove		=3D mdp_remove,
> +	.driver =3D {
> +		.name	=3D MDP_MODULE_NAME,
> +		.pm	=3D &mdp_pm_ops,
> +		.of_match_table =3D of_match_ptr(mdp_of_ids),
> +	},
> +};
> +
> +module_platform_driver(mdp_driver);
> +
> +MODULE_AUTHOR("Ping-Hsun Wu <ping-hsun.wu@mediatek.com>");
> +MODULE_DESCRIPTION("Mediatek image processor 3 driver");
> +MODULE_LICENSE("GPL v2");
> +
> diff --git a/drivers/media/platform/mtk-mdp3/mtk-mdp3-core.h b/drivers/me=
dia/platform/mtk-mdp3/mtk-mdp3-core.h
> new file mode 100644
> index 000000000000..19f46da487aa
> --- /dev/null
> +++ b/drivers/media/platform/mtk-mdp3/mtk-mdp3-core.h
> @@ -0,0 +1,86 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2018 MediaTek Inc.
> + * Author: Ping-Hsun Wu <ping-hsun.wu@mediatek.com>
> + */
> +
> +#ifndef __MTK_MDP3_CORE_H__
> +#define __MTK_MDP3_CORE_H__
> +
> +#include <media/v4l2-device.h>
> +#include <media/v4l2-mem2mem.h>
> +#include "mtk-mdp3-comp.h"
> +#include "mtk-mdp3-vpu.h"
> +
> +#define MDP_MODULE_NAME	"mtk-mdp3"
> +
> +enum mdp_buffer_usage {
> +	MDP_BUFFER_USAGE_HW_READ,
> +	MDP_BUFFER_USAGE_MDP,
> +	MDP_BUFFER_USAGE_MDP2,
> +	MDP_BUFFER_USAGE_ISP,
> +	MDP_BUFFER_USAGE_WPE,
> +};
> +
> +struct mdp_dev {
> +	struct platform_device	*pdev;
> +	struct mdp_comp		mmsys;
> +	struct mdp_comp		mm_mutex;
> +	struct mdp_comp		*comp[MDP_MAX_COMP_COUNT];
> +	s32			event[MDP_MAX_EVENT_COUNT];
> +
> +	struct workqueue_struct	*job_wq;
> +	struct workqueue_struct	*clock_wq;
> +	struct mdp_vpu_dev	vpu;
> +	struct mtk_scp		*scp;
> +	struct rproc		*rproc_handle;
> +	/* synchronization protect for accessing vpu working buffer info */
> +	struct mutex		vpu_lock;
> +	s32			vpu_count;
> +	u32			id_count;
> +	struct ida		mdp_ida;
> +	struct cmdq_client	*cmdq_clt;
> +	wait_queue_head_t	callback_wq;
> +
> +	struct v4l2_device	v4l2_dev;
> +	struct video_device	*m2m_vdev;
> +	struct v4l2_m2m_dev	*m2m_dev;
> +	/* synchronization protect for m2m device operation */
> +	struct mutex		m2m_lock;
> +	atomic_t		suspended;
> +	atomic_t		job_count;
> +};
> +
> +int mdp_vpu_get_locked(struct mdp_dev *mdp);
> +void mdp_vpu_put_locked(struct mdp_dev *mdp);
> +int mdp_vpu_register(struct mdp_dev *mdp);
> +void mdp_vpu_unregister(struct mdp_dev *mdp);
> +
> +extern int mtk_mdp_debug;
> +
> +#define DEBUG
> +#if defined(DEBUG)
> +
> +#define mdp_dbg(level, fmt, ...)\
> +	do {\
> +		if (mtk_mdp_debug >=3D (level))\
> +			pr_info("[MTK-MDP3] %d %s:%d: " fmt,\
> +				level, __func__, __LINE__, ##__VA_ARGS__);\
> +	} while (0)
> +
> +#define mdp_err(fmt, ...)\
> +	pr_err("[MTK-MDP3][ERR] %s:%d: " fmt, __func__, __LINE__,\
> +		##__VA_ARGS__)
> +
> +#else
> +
> +#define mdp_dbg(level, fmt, ...)	do {} while (0)
> +#define mdp_err(fmt, ...)		do {} while (0)
> +
> +#endif
> +
> +#define mdp_dbg_enter() mdp_dbg(3, "+")
> +#define mdp_dbg_leave() mdp_dbg(3, "-")
> +
> +#endif  /* __MTK_MDP3_CORE_H__ */
> +
> diff --git a/drivers/media/platform/mtk-mdp3/mtk-mdp3-debug.c b/drivers/m=
edia/platform/mtk-mdp3/mtk-mdp3-debug.c
> new file mode 100644
> index 000000000000..98f3f77bd591
> --- /dev/null
> +++ b/drivers/media/platform/mtk-mdp3/mtk-mdp3-debug.c
> @@ -0,0 +1,973 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2018 MediaTek Inc.
> + * Author: Daoyuan Huang <daoyuan.huang@mediatek.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/compiler_types.h>
> +#include <linux/io.h>
> +#include <linux/of_address.h>
> +
> +#include "mmsys_reg_base.h"
> +#include "mtk-mdp3-core.h"
> +#include "mtk-mdp3-debug.h"
> +#include "mtk-mdp3-regs.h"
> +
> +struct mdp_module_base_va {
> +	void __iomem *MDP_RDMA0;
> +	void __iomem *MDP_RSZ0;
> +	void __iomem *MDP_RSZ1;
> +	void __iomem *MDP_TDSHP;
> +	void __iomem *MDP_COLOR;
> +	void __iomem *MDP_AAL;
> +	void __iomem *MDP_CCORR;
> +	void __iomem *MDP_WROT0;
> +	void __iomem *MDP_WDMA;
> +	void __iomem *SMI_LARB0;
> +};
> +
> +struct RegDef {
> +	int offset;
> +	const char *name;
> +};
> +
> +struct mdp_debug_context {
> +	struct platform_device *mdp_device;
> +	struct mdp_func_struct mdp_func_pointer;
> +	struct mdp_module_base_va mdp_mod_base_va;
> +	void __iomem *mdp_mmsys_base_va;
> +};
> +
> +static struct mdp_debug_context g_mdp_debug;
> +
> +#define MMSYS_CONFIG_BASE	g_mdp_debug.mdp_mmsys_base_va
> +#define MDP_RDMA0_BASE		g_mdp_debug.mdp_mod_base_va.MDP_RDMA0
> +#define MDP_RSZ0_BASE		g_mdp_debug.mdp_mod_base_va.MDP_RSZ0
> +#define MDP_RSZ1_BASE		g_mdp_debug.mdp_mod_base_va.MDP_RSZ1
> +#define MDP_TDSHP_BASE		g_mdp_debug.mdp_mod_base_va.MDP_TDSHP
> +#define MDP_COLOR_BASE		g_mdp_debug.mdp_mod_base_va.MDP_COLOR
> +#define MDP_AAL_BASE		g_mdp_debug.mdp_mod_base_va.MDP_AAL
> +#define MDP_CCORR_BASE		g_mdp_debug.mdp_mod_base_va.MDP_CCORR
> +#define MDP_WROT0_BASE		g_mdp_debug.mdp_mod_base_va.MDP_WROT0
> +#define MDP_WDMA_BASE		g_mdp_debug.mdp_mod_base_va.MDP_WDMA
> +
> +#define MDP_REG_GET32(addr)	(readl((void *)addr) & 0xffffffff)
> +#define MDP_REG_SET32(addr, val)	writel(val, addr)
> +
> +static const char *mdp_get_rsz_state(const uint32_t state);
> +
> +struct mdp_func_struct *mdp_get_func(void)
> +{
> +	return &g_mdp_debug.mdp_func_pointer;
> +}
> +
> +static void __iomem *mdp_alloc_reference_VA_by_name(const char *ref_name=
)
> +{
> +	struct device_node *node;
> +	struct device *dev =3D &(g_mdp_debug.mdp_device->dev);
> +	void __iomem *VA;
> +
> +	node =3D of_parse_phandle(dev->of_node, ref_name, 0);
> +	if (!node) {
> +		mdp_err("DEV: cannot parse node name:%s\n", ref_name);
> +		return 0;
> +	}
> +
> +	VA =3D of_iomap(node, 0);
> +	of_node_put(node);
> +	mdp_dbg(2, "DEV: VA ref(%s): 0x%p\n", ref_name, VA);
> +
> +	return VA;
> +}
> +
> +static void mdp_free_module_base_VA(void __iomem *VA)
> +{
> +	iounmap(VA);
> +}
> +
> +static void mdp_init_module_base_VA(void)
> +{
> +	struct mdp_module_base_va *mod_base_va =3D &(g_mdp_debug.mdp_mod_base_v=
a);
> +	struct device_node *rdma_node =3D g_mdp_debug.mdp_device->dev.of_node;
> +	void __iomem *va;
> +
> +	if (rdma_node) {
> +		va =3D of_iomap(rdma_node, 0);
> +		of_node_put(rdma_node);
> +		mod_base_va->MDP_RDMA0 =3D va;
> +		mdp_dbg(2, "MDP_RDMA va: 0x%p\n", va);
> +	} else
> +		mdp_err("%s:MDP_RDMA node missing!\n", __func__);
> +
> +	mod_base_va->MDP_RSZ0 =3D mdp_alloc_reference_VA_by_name("mdp_rsz0");
> +	mod_base_va->MDP_RSZ1 =3D mdp_alloc_reference_VA_by_name("mdp_rsz1");
> +	mod_base_va->MDP_WROT0 =3D mdp_alloc_reference_VA_by_name("mdp_wrot0");
> +	mod_base_va->MDP_WDMA =3D mdp_alloc_reference_VA_by_name("mdp_wdma0");
> +	mod_base_va->MDP_TDSHP =3D mdp_alloc_reference_VA_by_name("mdp_tdshp0")=
;
> +	mod_base_va->MDP_COLOR =3D mdp_alloc_reference_VA_by_name("mdp_color0")=
;
> +	mod_base_va->MDP_AAL =3D mdp_alloc_reference_VA_by_name("mdp_aal0");
> +	mod_base_va->MDP_CCORR =3D mdp_alloc_reference_VA_by_name("mdp_ccorr0")=
;
> +	mod_base_va->SMI_LARB0 =3D
> +		mdp_alloc_reference_VA_by_name("mediatek,larb");
> +}
> +
> +static void mdp_deinit_module_base_VA(void)
> +{
> +	struct mdp_module_base_va *mod_base_va =3D &(g_mdp_debug.mdp_mod_base_v=
a);
> +
> +	mdp_free_module_base_VA(mod_base_va->MDP_RDMA0);
> +	mdp_free_module_base_VA(mod_base_va->MDP_RSZ0);
> +	mdp_free_module_base_VA(mod_base_va->MDP_RSZ1);
> +	mdp_free_module_base_VA(mod_base_va->MDP_WROT0);
> +	mdp_free_module_base_VA(mod_base_va->MDP_WDMA);
> +	mdp_free_module_base_VA(mod_base_va->MDP_TDSHP);
> +	mdp_free_module_base_VA(mod_base_va->MDP_COLOR);
> +	mdp_free_module_base_VA(mod_base_va->MDP_AAL);
> +	mdp_free_module_base_VA(mod_base_va->MDP_CCORR);
> +	mdp_free_module_base_VA(mod_base_va->SMI_LARB0);
> +	memset(mod_base_va, 0, sizeof(struct mdp_module_base_va));
> +}
> +
> +static void mdp_map_mmsys_VA(void)
> +{
> +	g_mdp_debug.mdp_mmsys_base_va =3D
> +		mdp_alloc_reference_VA_by_name("mediatek,mmsys");
> +}
> +
> +static void mdp_unmap_mmsys_VA(void)
> +{
> +	mdp_free_module_base_VA(g_mdp_debug.mdp_mmsys_base_va);
> +}
> +
> +static uint32_t mdp_rdma_get_reg_offset_src_addr_virtual(void)
> +{
> +	return 0;
> +}
> +
> +static uint32_t mdp_wrot_get_reg_offset_dst_addr_virtual(void)
> +{
> +	return 0;
> +}
> +
> +static uint32_t mdp_wdma_get_reg_offset_dst_addr_virtual(void)
> +{
> +	return 0;
> +}
> +
> +/* MDP engine dump */
> +static void mdp_dump_rsz_common(void __iomem *base, const char *label)
> +{
> +	uint32_t value[8];
> +	uint32_t request[8];
> +	uint32_t state;
> +
> +	if (!base) {
> +		mdp_err("=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D [MDP] %s Status=
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D\n",
> +			label);
> +		mdp_err("%s:base=3D0!\n", __func__);
> +		return;
> +	}
> +
> +	value[0] =3D MDP_REG_GET32(base + 0x004);
> +	value[1] =3D MDP_REG_GET32(base + 0x00C);
> +	value[2] =3D MDP_REG_GET32(base + 0x010);
> +	value[3] =3D MDP_REG_GET32(base + 0x014);
> +	value[4] =3D MDP_REG_GET32(base + 0x018);
> +	MDP_REG_SET32(base + 0x040, 0x00000001);
> +	value[5] =3D MDP_REG_GET32(base + 0x044);
> +	MDP_REG_SET32(base + 0x040, 0x00000002);
> +	value[6] =3D MDP_REG_GET32(base + 0x044);
> +	MDP_REG_SET32(base + 0x040, 0x00000003);
> +	value[7] =3D MDP_REG_GET32(base + 0x044);
> +
> +	mdp_err("=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D [MDP] %s Status =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D\n",
> +		label);
> +	mdp_err("RSZ_CONTROL: 0x%08x, RSZ_INPUT_IMAGE: 0x%08x\n",
> +		 value[0], value[1]);
> +	mdp_err("RSZ_OUTPUT_IMAGE: 0x%08x RSZ_VERTICAL_COEFF_STEP: 0x%08x\n",
> +		 value[2], value[3]);
> +	mdp_err("RSZ_HORIZONTAL_COEFF_STEP: 0x%08x, RSZ_DEBUG_1: 0x%08x\n",
> +		 value[4], value[5]);
> +	mdp_err(", RSZ_DEBUG_2: 0x%08x, RSZ_DEBUG_3: 0x%08x\n",
> +		 value[6], value[7]);
> +
> +	/* parse state */
> +	/* .valid=3D1/request=3D1: upstream module sends data */
> +	/* .ready=3D1: downstream module receives data */
> +	state =3D value[6] & 0xF;
> +	request[0] =3D state & (0x1);	/* out valid */
> +	request[1] =3D (state & (0x1 << 1)) >> 1;	/* out ready */
> +	request[2] =3D (state & (0x1 << 2)) >> 2;	/* in valid */
> +	request[3] =3D (state & (0x1 << 3)) >> 3;	/* in ready */
> +	request[4] =3D (value[1] & 0x1FFF);	/* input_width */
> +	request[5] =3D (value[1] >> 16) & 0x1FFF;	/* input_height */
> +	request[6] =3D (value[2] & 0x1FFF);	/* output_width */
> +	request[7] =3D (value[2] >> 16) & 0x1FFF;	/* output_height */
> +
> +	mdp_err("RSZ inRdy,inRsq,outRdy,outRsq: %d,%d,%d,%d (%s)\n",
> +		request[3], request[2], request[1], request[0],
> +		mdp_get_rsz_state(state));
> +	mdp_err("RSZ input_width,input_height,output_width,output_height:");
> +	mdp_err("%d,%d,%d,%d\n",
> +		 request[4], request[5], request[6], request[7]);
> +}
> +
> +static void mdp_dump_tdshp_common(void __iomem *base, const char *label)
> +{
> +	uint32_t value[8];
> +
> +	if (!base) {
> +		mdp_err("=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D [MDP] %s Status=
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D\n",
> +			label);
> +		mdp_err("%s:base=3D0!\n", __func__);
> +		return;
> +	}
> +
> +	value[0] =3D MDP_REG_GET32(base + 0x114);
> +	value[1] =3D MDP_REG_GET32(base + 0x11C);
> +	value[2] =3D MDP_REG_GET32(base + 0x104);
> +	value[3] =3D MDP_REG_GET32(base + 0x108);
> +	value[4] =3D MDP_REG_GET32(base + 0x10C);
> +	value[5] =3D MDP_REG_GET32(base + 0x120);
> +	value[6] =3D MDP_REG_GET32(base + 0x128);
> +	value[7] =3D MDP_REG_GET32(base + 0x110);
> +
> +	mdp_err("=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D [MDP] %s Status =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D\n",
> +		label);
> +	mdp_err("TDSHP INPUT_CNT: 0x%08x, OUTPUT_CNT: 0x%08x\n",
> +		value[0], value[1]);
> +	mdp_err("TDSHP INTEN: 0x%08x, INTSTA: 0x%08x, 0x10C: 0x%08x\n",
> +		value[2], value[3], value[4]);
> +	mdp_err("TDSHP CFG: 0x%08x, IN_SIZE: 0x%08x, OUT_SIZE: 0x%08x\n",
> +		value[7], value[5], value[6]);
> +}
> +
> +static void mdp_virtual_function_setting(void)
> +{
> +	struct mdp_func_struct *pfunc =3D mdp_get_func();
> +
> +	pfunc->mdp_dump_rsz =3D mdp_dump_rsz_common;
> +	pfunc->mdp_dump_tdshp =3D mdp_dump_tdshp_common;
> +	pfunc->mdp_rdma_get_src_base_addr =3D
> +		mdp_rdma_get_reg_offset_src_addr_virtual;
> +	pfunc->mdp_wrot_get_reg_offset_dst_addr =3D
> +		mdp_wrot_get_reg_offset_dst_addr_virtual;
> +	pfunc->mdp_wdma_get_reg_offset_dst_addr =3D
> +		mdp_wdma_get_reg_offset_dst_addr_virtual;
> +}
> +
> +static void mdp_dump_mmsys_config(void)
> +{
> +	int i;
> +	uint32_t value;
> +	static const struct RegDef configRegisters[] =3D {
> +		{0xF80, "ISP_MOUT_EN"},
> +		{0xF84, "MDP_RDMA0_MOUT_EN"},
> +		{0xF8C, "MDP_PRZ0_MOUT_EN"},
> +		{0xF90, "MDP_PRZ1_MOUT_EN"},
> +		{0xF94, "MDP_COLOR_MOUT_EN"},
> +		{0xF98, "IPU_MOUT_EN"},
> +		{0xFE8, "MDP_AAL_MOUT_EN"},
> +		/* {0x02C, "MDP_TDSHP_MOUT_EN"}, */
> +		{0xF00, "DISP_OVL0_MOUT_EN"},
> +		{0xF04, "DISP_OVL0_2L_MOUT_EN"},
> +		{0xF08, "DISP_OVL1_2L_MOUT_EN"},
> +		{0xF0C, "DISP_DITHER0_MOUT_EN"},
> +		{0xF10, "DISP_RSZ_MOUT_EN"},
> +		/* {0x040, "DISP_UFOE_MOUT_EN"}, */
> +		/* {0x040, "MMSYS_MOUT_RST"}, */
> +		{0xFA0, "DISP_TO_WROT_SOUT_SEL"},
> +		{0xFA4, "MDP_COLOR_IN_SOUT_SEL"},
> +		{0xFA8, "MDP_PATH0_SOUT_SEL"},
> +		{0xFAC, "MDP_PATH1_SOUT_SEL"},
> +		{0xFB0, "MDP_TDSHP_SOUT_SEL"},
> +		{0xFC0, "MDP_PRZ0_SEL_IN"},
> +		{0xFC4, "MDP_PRZ1_SEL_IN"},
> +		{0xFC8, "MDP_TDSHP_SEL_IN"},
> +		{0xFCC, "DISP_WDMA0_SEL_IN"},
> +		{0xFDC, "MDP_COLOR_SEL_IN"},
> +		{0xF20, "DISP_COLOR_OUT_SEL_IN"},
> +		{0xFD0, "MDP_WROT0_SEL_IN"},
> +		{0xFD4, "MDP_WDMA_SEL_IN"},
> +		{0xFD8, "MDP_COLOR_OUT_SEL_IN"},
> +		{0xFDC, "MDP_COLOR_SEL_IN "},
> +		/* {0xFDC, "DISP_COLOR_SEL_IN"}, */
> +		{0xFE0, "MDP_PATH0_SEL_IN"},
> +		{0xFE4, "MDP_PATH1_SEL_IN"},
> +		{0xFEC, "MDP_AAL_SEL_IN"},
> +		{0xFF0, "MDP_CCORR_SEL_IN"},
> +		{0xFF4, "MDP_CCORR_SOUT_SEL"},
> +		/* {0x070, "DISP_WDMA1_SEL_IN"}, */
> +		/* {0x074, "DISP_UFOE_SEL_IN"}, */
> +		{0xF2C, "DSI0_SEL_IN"},
> +		{0xF30, "DSI1_SEL_IN"},
> +		{0xF50, "DISP_RDMA0_SOUT_SEL_IN"},
> +		{0xF54, "DISP_RDMA1_SOUT_SEL_IN"},
> +		{0x0F0, "MMSYS_MISC"},
> +		/* ACK and REQ related */
> +		{0x8B4, "DISP_DL_VALID_0"},
> +		{0x8B8, "DISP_DL_VALID_1"},
> +		{0x8C0, "DISP_DL_READY_0"},
> +		{0x8C4, "DISP_DL_READY_1"},
> +		{0x8CC, "MDP_DL_VALID_0"},
> +		{0x8D0, "MDP_DL_VALID_1"},
> +		{0x8D4, "MDP_DL_READY_0"},
> +		{0x8D8, "MDP_DL_READY_1"},
> +		{0x8E8, "MDP_MOUT_MASK"},
> +		{0x948, "MDP_DL_VALID_2"},
> +		{0x94C, "MDP_DL_READY_2"},
> +		{0x950, "DISP_DL_VALID_2"},
> +		{0x954, "DISP_DL_READY_2"},
> +		{0x100, "MMSYS_CG_CON0"},
> +		{0x110, "MMSYS_CG_CON1"},
> +		/* Async DL related */
> +		{0x960, "TOP_RELAY_FSM_RD"},
> +		{0x934, "MDP_ASYNC_CFG_WD"},
> +		{0x938, "MDP_ASYNC_CFG_RD"},
> +		{0x958, "MDP_ASYNC_CFG_OUT_RD"},
> +		{0x95C, "MDP_ASYNC_IPU_CFG_OUT_RD"},
> +		{0x994, "ISP_RELAY_CFG_WD"},
> +		{0x998, "ISP_RELAY_CNT_RD"},
> +		{0x99C, "ISP_RELAY_CNT_LATCH_RD"},
> +		{0x9A0, "IPU_RELAY_CFG_WD"},
> +		{0x9A4, "IPU_RELAY_CNT_RD"},
> +		{0x9A8, "IPU_RELAY_CNT_LATCH_RD"}
> +	};
> +
> +	if (!MMSYS_CONFIG_BASE) {
> +		mdp_err("%s:MMSYS_CONFIG_BASE=3D0!\n", __func__);
> +		return;
> +	}
> +
> +	for (i =3D 0; i < ARRAY_SIZE(configRegisters); i++) {
> +		value =3D MDP_REG_GET32(MMSYS_CONFIG_BASE +
> +			configRegisters[i].offset);
> +		mdp_err("%s: 0x%08x\n", configRegisters[i].name, value);
> +	}
> +}
> +
> +static const char *mdp_get_rdma_state(uint32_t state)
> +{
> +	switch (state) {
> +	case 0x1:
> +		return "idle";
> +	case 0x2:
> +		return "wait sof";
> +	case 0x4:
> +		return "reg update";
> +	case 0x8:
> +		return "clear0";
> +	case 0x10:
> +		return "clear1";
> +	case 0x20:
> +		return "int0";
> +	case 0x40:
> +		return "int1";
> +	case 0x80:
> +		return "data running";
> +	case 0x100:
> +		return "wait done";
> +	case 0x200:
> +		return "warm reset";
> +	case 0x400:
> +		return "wait reset";
> +	default:
> +		return "";
> +	}
> +}
> +
> +static const char *mdp_get_rsz_state(const uint32_t state)
> +{
> +	switch (state) {
> +	case 0x5:
> +		return "downstream hang";	/* 0,1,0,1 */
> +	case 0xa:
> +		return "upstream hang";	/* 1,0,1,0 */
> +	default:
> +		return "";
> +	}
> +}
> +
> +static const char *mdp_get_wdma_state(uint32_t state)
> +{
> +	switch (state) {
> +	case 0x1:
> +		return "idle";
> +	case 0x2:
> +		return "clear";
> +	case 0x4:
> +		return "prepare";
> +	case 0x8:
> +		return "prepare";
> +	case 0x10:
> +		return "data running";
> +	case 0x20:
> +		return "eof wait";
> +	case 0x40:
> +		return "soft reset wait";
> +	case 0x80:
> +		return "eof done";
> +	case 0x100:
> +		return "sof reset done";
> +	case 0x200:
> +		return "frame complete";
> +	default:
> +		return "";
> +	}
> +}
> +
> +static void mdp_dump_rdma_common(void __iomem *base, const char *label)
> +{
> +	uint32_t value[17];
> +	uint32_t state;
> +	uint32_t grep;
> +
> +	if (!base) {
> +		mdp_err("=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D [MDP] %s Status=
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D\n",
> +			label);
> +		mdp_err("%s:base=3D0!\n", __func__);
> +		return;
> +	}
> +
> +	value[0] =3D MDP_REG_GET32(base + 0x030);
> +	value[1] =3D MDP_REG_GET32(base +
> +		   mdp_get_func()->mdp_rdma_get_src_base_addr());
> +	value[2] =3D MDP_REG_GET32(base + 0x060);
> +	value[3] =3D MDP_REG_GET32(base + 0x070);
> +	value[4] =3D MDP_REG_GET32(base + 0x078);
> +	value[5] =3D MDP_REG_GET32(base + 0x080);
> +	value[6] =3D MDP_REG_GET32(base + 0x100);
> +	value[7] =3D MDP_REG_GET32(base + 0x118);
> +	value[8] =3D MDP_REG_GET32(base + 0x130);
> +	value[9] =3D MDP_REG_GET32(base + 0x400);
> +	value[10] =3D MDP_REG_GET32(base + 0x408);
> +	value[11] =3D MDP_REG_GET32(base + 0x410);
> +	value[12] =3D MDP_REG_GET32(base + 0x420);
> +	value[13] =3D MDP_REG_GET32(base + 0x430);
> +	value[14] =3D MDP_REG_GET32(base + 0x440);
> +	value[15] =3D MDP_REG_GET32(base + 0x4D0);
> +	value[16] =3D MDP_REG_GET32(base + 0x0);
> +
> +	mdp_err("=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D [MDP] %s Status =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D\n",
> +		label);
> +	mdp_err
> +	    ("RDMA_SRC_CON: 0x%08x, RDMA_SRC_BASE_0: 0x%08x\n",
> +	     value[0], value[1]);
> +	mdp_err
> +	    ("RDMA_MF_BKGD_SIZE_IN_BYTE: 0x%08x RDMA_MF_SRC_SIZE: 0x%08x\n",
> +	     value[2], value[3]);
> +	mdp_err("RDMA_MF_CLIP_SIZE: 0x%08x, RDMA_MF_OFFSET_1: 0x%08x\n",
> +		value[4], value[5]);
> +	mdp_err("RDMA_SRC_END_0: 0x%08x, RDMA_SRC_OFFSET_0: 0x%08x\n",
> +		 value[6], value[7]);
> +	mdp_err("RDMA_SRC_OFFSET_W_0: 0x%08x, RDMA_MON_STA_0: 0x%08x\n",
> +		 value[8], value[9]);
> +	mdp_err("RDMA_MON_STA_1: 0x%08x, RDMA_MON_STA_2: 0x%08x\n",
> +		 value[10], value[11]);
> +	mdp_err("RDMA_MON_STA_4: 0x%08x, RDMA_MON_STA_6: 0x%08x\n",
> +		 value[12], value[13]);
> +	mdp_err("RDMA_MON_STA_8: 0x%08x, RDMA_MON_STA_26: 0x%08x\n",
> +		 value[14], value[15]);
> +	mdp_err("RDMA_EN: 0x%08x\n",
> +		 value[16]);
> +
> +	/* parse state */
> +	mdp_err("RDMA ack:%d req:%d\n", (value[9] & (1 << 11)) >> 11,
> +		 (value[9] & (1 << 10)) >> 10);
> +	state =3D (value[10] >> 8) & 0x7FF;
> +	grep =3D (value[10] >> 20) & 0x1;
> +	mdp_err("RDMA state: 0x%x (%s)\n", state, mdp_get_rdma_state(state));
> +	mdp_err("RDMA horz_cnt: %d vert_cnt:%d\n",
> +		value[15] & 0xFFF, (value[15] >> 16) & 0xFFF);
> +
> +	mdp_err("RDMA grep:%d =3D> suggest to ask SMI help:%d\n", grep, grep);
> +}
> +
> +static void mdp_dump_rot_common(void __iomem *base, const char *label)
> +{
> +	uint32_t value[47];
> +
> +	if (!base) {
> +		mdp_err("=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D [MDP] %s Status=
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D\n",
> +			label);
> +		mdp_err("%s:base=3D0!\n", __func__);
> +		return;
> +	}
> +
> +	value[0] =3D MDP_REG_GET32(base + 0x000);
> +	value[1] =3D MDP_REG_GET32(base + 0x008);
> +	value[2] =3D MDP_REG_GET32(base + 0x00C);
> +	value[3] =3D MDP_REG_GET32(base + 0x024);
> +	value[4] =3D MDP_REG_GET32(base +
> +		   mdp_get_func()->mdp_wrot_get_reg_offset_dst_addr());
> +	value[5] =3D MDP_REG_GET32(base + 0x02C);
> +	value[6] =3D MDP_REG_GET32(base + 0x004);
> +	value[7] =3D MDP_REG_GET32(base + 0x030);
> +	value[8] =3D MDP_REG_GET32(base + 0x078);
> +	value[9] =3D MDP_REG_GET32(base + 0x070);
> +	MDP_REG_SET32(base + 0x018, 0x00000100);
> +	value[10] =3D MDP_REG_GET32(base + 0x0D0);
> +	MDP_REG_SET32(base + 0x018, 0x00000200);
> +	value[11] =3D MDP_REG_GET32(base + 0x0D0);
> +	MDP_REG_SET32(base + 0x018, 0x00000300);
> +	value[12] =3D MDP_REG_GET32(base + 0x0D0);
> +	MDP_REG_SET32(base + 0x018, 0x00000400);
> +	value[13] =3D MDP_REG_GET32(base + 0x0D0);
> +	MDP_REG_SET32(base + 0x018, 0x00000500);
> +	value[14] =3D MDP_REG_GET32(base + 0x0D0);
> +	MDP_REG_SET32(base + 0x018, 0x00000600);
> +	value[15] =3D MDP_REG_GET32(base + 0x0D0);
> +	MDP_REG_SET32(base + 0x018, 0x00000700);
> +	value[16] =3D MDP_REG_GET32(base + 0x0D0);
> +	MDP_REG_SET32(base + 0x018, 0x00000800);
> +	value[17] =3D MDP_REG_GET32(base + 0x0D0);
> +	MDP_REG_SET32(base + 0x018, 0x00000900);
> +	value[18] =3D MDP_REG_GET32(base + 0x0D0);
> +	MDP_REG_SET32(base + 0x018, 0x00000A00);
> +	value[19] =3D MDP_REG_GET32(base + 0x0D0);
> +	MDP_REG_SET32(base + 0x018, 0x00000B00);
> +	value[20] =3D MDP_REG_GET32(base + 0x0D0);
> +	MDP_REG_SET32(base + 0x018, 0x00000C00);
> +	value[21] =3D MDP_REG_GET32(base + 0x0D0);
> +	MDP_REG_SET32(base + 0x018, 0x00000D00);
> +	value[22] =3D MDP_REG_GET32(base + 0x0D0);
> +	MDP_REG_SET32(base + 0x018, 0x00000E00);
> +	value[23] =3D MDP_REG_GET32(base + 0x0D0);
> +	MDP_REG_SET32(base + 0x018, 0x00000F00);
> +	value[24] =3D MDP_REG_GET32(base + 0x0D0);
> +	MDP_REG_SET32(base + 0x018, 0x00001000);
> +	value[25] =3D MDP_REG_GET32(base + 0x0D0);
> +	MDP_REG_SET32(base + 0x018, 0x00001100);
> +	value[26] =3D MDP_REG_GET32(base + 0x0D0);
> +	MDP_REG_SET32(base + 0x018, 0x00001200);
> +	value[27] =3D MDP_REG_GET32(base + 0x0D0);
> +	MDP_REG_SET32(base + 0x018, 0x00001300);
> +	value[28] =3D MDP_REG_GET32(base + 0x0D0);
> +	MDP_REG_SET32(base + 0x018, 0x00001400);
> +	value[29] =3D MDP_REG_GET32(base + 0x0D0);
> +	MDP_REG_SET32(base + 0x018, 0x00001500);
> +	value[30] =3D MDP_REG_GET32(base + 0x0D0);
> +	MDP_REG_SET32(base + 0x018, 0x00001600);
> +	value[31] =3D MDP_REG_GET32(base + 0x0D0);
> +	MDP_REG_SET32(base + 0x018, 0x00001700);
> +	value[32] =3D MDP_REG_GET32(base + 0x0D0);
> +	MDP_REG_SET32(base + 0x018, 0x00001800);
> +	value[33] =3D MDP_REG_GET32(base + 0x0D0);
> +	MDP_REG_SET32(base + 0x018, 0x00001900);
> +	value[34] =3D MDP_REG_GET32(base + 0x0D0);
> +	MDP_REG_SET32(base + 0x018, 0x00001A00);
> +	value[35] =3D MDP_REG_GET32(base + 0x0D0);
> +	MDP_REG_SET32(base + 0x018, 0x00001B00);
> +	value[36] =3D MDP_REG_GET32(base + 0x0D0);
> +	MDP_REG_SET32(base + 0x018, 0x00001C00);
> +	value[37] =3D MDP_REG_GET32(base + 0x0D0);
> +	MDP_REG_SET32(base + 0x018, 0x00001D00);
> +	value[38] =3D MDP_REG_GET32(base + 0x0D0);
> +	MDP_REG_SET32(base + 0x018, 0x00001E00);
> +	value[39] =3D MDP_REG_GET32(base + 0x0D0);
> +	MDP_REG_SET32(base + 0x018, 0x00001F00);
> +	value[40] =3D MDP_REG_GET32(base + 0x0D0);
> +	MDP_REG_SET32(base + 0x018, 0x00002000);
> +	value[41] =3D MDP_REG_GET32(base + 0x0D0);
> +	MDP_REG_SET32(base + 0x018, 0x00002100);
> +	value[42] =3D MDP_REG_GET32(base + 0x0D0);
> +	value[43] =3D MDP_REG_GET32(base + 0x01C);
> +	value[44] =3D MDP_REG_GET32(base + 0x07C);
> +	value[45] =3D MDP_REG_GET32(base + 0x010);
> +	value[46] =3D MDP_REG_GET32(base + 0x014);
> +
> +	mdp_err("=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D [MDP] %s Status =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D\n",
> +		label);
> +	mdp_err("ROT_CTRL: 0x%08x, ROT_MAIN_BUF_SIZE: 0x%08x\n",
> +		 value[0], value[1]);
> +	mdp_err("ROT_SUB_BUF_SIZE: 0x%08x, ROT_TAR_SIZE: 0x%08x\n",
> +		 value[2], value[3]);
> +	mdp_err("ROT_BASE_ADDR: 0x%08x, ROT_OFST_ADDR: 0x%08x\n",
> +		 value[4], value[5]);
> +	mdp_err("ROT_DMA_PERF: 0x%08x, ROT_STRIDE: 0x%08x\n",
> +		 value[6], value[7]);
> +	mdp_err("ROT_IN_SIZE: 0x%08x, ROT_EOL: 0x%08x\n",
> +		 value[8], value[9]);
> +	mdp_err("ROT_DBUGG_1: 0x%08x, ROT_DEBUBG_2: 0x%08x\n",
> +		 value[10], value[11]);
> +	mdp_err("ROT_DBUGG_3: 0x%08x, ROT_DBUGG_4: 0x%08x\n",
> +		 value[12], value[13]);
> +	mdp_err("ROT_DEBUBG_5: 0x%08x, ROT_DBUGG_6: 0x%08x\n",
> +		 value[14], value[15]);
> +	mdp_err("ROT_DBUGG_7: 0x%08x, ROT_DEBUBG_8: 0x%08x\n",
> +		 value[16], value[17]);
> +	mdp_err("ROT_DBUGG_9: 0x%08x, ROT_DBUGG_A: 0x%08x\n",
> +		 value[18], value[19]);
> +	mdp_err("ROT_DEBUBG_B: 0x%08x, ROT_DBUGG_C: 0x%08x\n",
> +		 value[20], value[21]);
> +	mdp_err("ROT_DBUGG_D: 0x%08x, ROT_DEBUBG_E: 0x%08x\n",
> +		 value[22], value[23]);
> +	mdp_err("ROT_DBUGG_F: 0x%08x, ROT_DBUGG_10: 0x%08x\n",
> +		 value[24], value[25]);
> +	mdp_err("ROT_DEBUBG_11: 0x%08x, ROT_DEBUG_12: 0x%08x\n",
> +		 value[26], value[27]);
> +	mdp_err("ROT_DBUGG_13: 0x%08x, ROT_DBUGG_14: 0x%08x\n",
> +		 value[28], value[29]);
> +	mdp_err("ROT_DEBUG_15: 0x%08x, ROT_DBUGG_16: 0x%08x\n",
> +		 value[30], value[31]);
> +	mdp_err("ROT_DBUGG_17: 0x%08x, ROT_DEBUG_18: 0x%08x\n",
> +		 value[32], value[33]);
> +	mdp_err("ROT_DBUGG_19: 0x%08x, ROT_DBUGG_1A: 0x%08x\n",
> +		 value[34], value[35]);
> +	mdp_err("ROT_DEBUG_1B: 0x%08x, ROT_DBUGG_1C: 0x%08x\n",
> +		 value[36], value[37]);
> +	mdp_err("ROT_DBUGG_1D: 0x%08x, ROT_DEBUG_1E: 0x%08x\n",
> +		 value[38], value[39]);
> +	mdp_err("ROT_DBUGG_1F: 0x%08x, ROT_DBUGG_20: 0x%08x\n",
> +		 value[40], value[41]);
> +	mdp_err("ROT_DEBUG_21: 0x%08x\n",
> +		 value[42]);
> +	mdp_err("VIDO_INT: 0x%08x, VIDO_ROT_EN: 0x%08x\n",
> +		value[43], value[44]);
> +	mdp_err("VIDO_SOFT_RST: 0x%08x, VIDO_SOFT_RST_STAT: 0x%08x\n",
> +		value[45], value[46]);
> +}
> +
> +static void mdp_dump_color_common(void __iomem *base, const char *label)
> +{
> +	uint32_t value[13];
> +
> +	if (!base) {
> +		mdp_err("=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D [MDP] %s Status=
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D\n",
> +			label);
> +		mdp_err("%s:base=3D0!\n", __func__);
> +		return;
> +	}
> +
> +	value[0] =3D MDP_REG_GET32(base + 0x400);
> +	value[1] =3D MDP_REG_GET32(base + 0x404);
> +	value[2] =3D MDP_REG_GET32(base + 0x408);
> +	value[3] =3D MDP_REG_GET32(base + 0x40C);
> +	value[4] =3D MDP_REG_GET32(base + 0x410);
> +	value[5] =3D MDP_REG_GET32(base + 0x420);
> +	value[6] =3D MDP_REG_GET32(base + 0xC00);
> +	value[7] =3D MDP_REG_GET32(base + 0xC04);
> +	value[8] =3D MDP_REG_GET32(base + 0xC08);
> +	value[9] =3D MDP_REG_GET32(base + 0xC0C);
> +	value[10] =3D MDP_REG_GET32(base + 0xC10);
> +	value[11] =3D MDP_REG_GET32(base + 0xC50);
> +	value[12] =3D MDP_REG_GET32(base + 0xC54);
> +
> +	mdp_err("=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D [MDP] %s Status =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D\n",
> +		label);
> +	mdp_err("COLOR CFG_MAIN: 0x%08x\n", value[0]);
> +	mdp_err("COLOR PXL_CNT_MAIN: 0x%08x, LINE_CNT_MAIN: 0x%08x\n",
> +		value[1], value[2]);
> +	mdp_err("COLOR WIN_X_MAIN: 0x%08x, WIN_Y_MAIN: 0x%08x\n",
> +		value[3], value[4]);
> +	mdp_err("DBG_CFG_MAIN: 0x%08x, COLOR START: 0x%08x\n",
> +		value[5], value[6]);
> +	mdp_err("INTEN: 0x%08x, INTSTA: 0x%08x\n",
> +		value[7], value[8]);
> +	mdp_err("COLOR OUT_SEL: 0x%08x, FRAME_DONE_DEL: 0x%08x\n",
> +		value[9], value[10]);
> +	mdp_err
> +	    ("COLOR INTERNAL_IP_WIDTH: 0x%08x, INTERNAL_IP_HEIGHT: 0x%08x\n",
> +	     value[11], value[12]);
> +}
> +
> +static void mdp_dump_wdma_common(void __iomem *base, const char *label)
> +{
> +	uint32_t value[56];
> +	uint32_t state;
> +	/* grep bit =3D 1, WDMA has sent request to SMI,
> +	 *and not receive done yet
> +	 */
> +	uint32_t grep;
> +	uint32_t isFIFOFull;	/* 1 for WDMA FIFO full */
> +	int i;
> +
> +	if (!base) {
> +		mdp_err("=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D [MDP] %s Status=
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D\n",
> +			label);
> +		mdp_err("%s:base=3D0!\n", __func__);
> +		return;
> +	}
> +
> +	value[0] =3D MDP_REG_GET32(base + 0x014);
> +	value[1] =3D MDP_REG_GET32(base + 0x018);
> +	value[2] =3D MDP_REG_GET32(base + 0x028);
> +	value[3] =3D MDP_REG_GET32(base +
> +		   mdp_get_func()->mdp_wdma_get_reg_offset_dst_addr());
> +	value[4] =3D MDP_REG_GET32(base + 0x078);
> +	value[5] =3D MDP_REG_GET32(base + 0x080);
> +	value[6] =3D MDP_REG_GET32(base + 0x0A0);
> +	value[7] =3D MDP_REG_GET32(base + 0x0A8);
> +
> +	for (i =3D 0; i < 16; i++) {
> +		MDP_REG_SET32(base + 0x014, (0x10000000 * i) |
> +			      (value[0] & (0x0FFFFFFF)));
> +		value[8 + (3 * i)] =3D MDP_REG_GET32(base + 0x014);
> +		value[9 + (3 * i)] =3D MDP_REG_GET32(base + 0x0AC);
> +		value[10 + (3 * i)] =3D MDP_REG_GET32(base + 0x0B8);
> +	}
> +
> +	mdp_err("=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D [MDP] %s Status =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D\n",
> +		label);
> +	mdp_err("[MDP]WDMA_CFG: 0x%08x, WDMA_SRC_SIZE: 0x%08x\n",
> +		 value[0], value[1]);
> +	mdp_err("WDMA_DST_W_IN_BYTE =3D 0x%08x, [MDP]WDMA_DST_ADDR0: 0x%08x\n",
> +		 value[2], value[3]);
> +	mdp_err
> +	    ("WDMA_DST_UV_PITCH: 0x%08x, WDMA_DST_ADDR_OFFSET0 =3D 0x%08x\n",
> +	     value[4], value[5]);
> +	mdp_err("[MDP]WDMA_STATUS: 0x%08x, WDMA_INPUT_CNT: 0x%08x\n",
> +		value[6], value[7]);
> +
> +	/* Dump Addtional WDMA debug info */
> +	for (i =3D 0; i < 16; i++) {
> +		mdp_err("WDMA_DEBUG_%x 014:0x%08x, 0ac:0x%08x, 0b8:0x%08x\n",
> +			i, value[8 + (3 * i)], value[9 + (3 * i)],
> +			value[10 + (3 * i)]);
> +	}
> +
> +	/* parse WDMA state */
> +	state =3D value[6] & 0x3FF;
> +	grep =3D (value[6] >> 13) & 0x1;
> +	isFIFOFull =3D (value[6] >> 12) & 0x1;
> +
> +	mdp_err("WDMA state:0x%x (%s)\n", state, mdp_get_wdma_state(state));
> +	mdp_err("WDMA in_req:%d in_ack:%d\n", (value[6] >> 15) & 0x1,
> +		(value[6] >> 14) & 0x1);
> +
> +	/* note WDMA send request(i.e command) to SMI first,
> +	 * then SMI takes request data from WDMA FIFO
> +	 */
> +	/* if SMI dose not process request and upstream HWs */
> +	/* such as MDP_RSZ send data to WDMA, WDMA FIFO will full finally */
> +	mdp_err("WDMA grep:%d, FIFO full:%d\n", grep, isFIFOFull);
> +	mdp_err("WDMA suggest: Need SMI help:%d, Need check WDMA config:%d\n",
> +		(grep), ((grep =3D=3D 0) && (isFIFOFull =3D=3D 1)));
> +}
> +
> +static void mdp_dump_rsz(void __iomem *base, const char *label)
> +{
> +	uint32_t value[11];
> +	uint32_t request[4];
> +	uint32_t state;
> +
> +	if (!base) {
> +		mdp_err("=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D [MDP] %s Status=
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D\n",
> +			label);
> +		mdp_err("%s:base=3D0!\n", __func__);
> +		return;
> +	}
> +
> +	value[0] =3D MDP_REG_GET32(base + 0x004);
> +	value[1] =3D MDP_REG_GET32(base + 0x008);
> +	value[2] =3D MDP_REG_GET32(base + 0x010);
> +	value[3] =3D MDP_REG_GET32(base + 0x014);
> +	value[4] =3D MDP_REG_GET32(base + 0x018);
> +	value[5] =3D MDP_REG_GET32(base + 0x01C);
> +	MDP_REG_SET32(base + 0x044, 0x00000001);
> +	value[6] =3D MDP_REG_GET32(base + 0x048);
> +	MDP_REG_SET32(base + 0x044, 0x00000002);
> +	value[7] =3D MDP_REG_GET32(base + 0x048);
> +	MDP_REG_SET32(base + 0x044, 0x00000003);
> +	value[8] =3D MDP_REG_GET32(base + 0x048);
> +	value[9] =3D MDP_REG_GET32(base + 0x100);
> +	value[10] =3D MDP_REG_GET32(base + 0x200);
> +	mdp_err("=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D [MDP] %s Status =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D\n",
> +		label);
> +	mdp_err("RSZ_CONTROL_1: 0x%08x, RSZ_CONTROL_2: 0x%08x\n",
> +		 value[0], value[1]);
> +	mdp_err("RSZ_INPUT_IMAGE: 0x%08x, RSZ_OUTPUT_IMAGE: 0x%08x\n",
> +		 value[2], value[3]);
> +	mdp_err("RSZ_HORIZONTAL_COEFF_STEP: 0x%08x\n", value[4]);
> +	mdp_err("RSZ_VERTICAL_COEFF_STEP: 0x%08x\n", value[5]);
> +	mdp_err
> +	    ("RSZ_DEBUG_1: 0x%08x, RSZ_DEBUG_2: 0x%08x, RSZ_DEBUG_3: 0x%08x\n",
> +	     value[6], value[7], value[8]);
> +	mdp_err("PAT1_GEN_SET: 0x%08x, PAT2_GEN_SET: 0x%08x\n",
> +		value[9], value[10]);
> +	/* parse state */
> +	/* .valid=3D1/request=3D1: upstream module sends data */
> +	/* .ready=3D1: downstream module receives data */
> +	state =3D value[7] & 0xF;
> +	request[0] =3D state & (0x1);	/* out valid */
> +	request[1] =3D (state & (0x1 << 1)) >> 1;	/* out ready */
> +	request[2] =3D (state & (0x1 << 2)) >> 2;	/* in valid */
> +	request[3] =3D (state & (0x1 << 3)) >> 3;	/* in ready */
> +	mdp_err("RSZ inRdy,inRsq,outRdy,outRsq: %d,%d,%d,%d (%s)\n",
> +		request[3], request[2], request[1], request[0],
> +		mdp_get_rsz_state(state));
> +}
> +
> +static void mdp_dump_tdshp(void __iomem *base, const char *label)
> +{
> +	uint32_t value[10];
> +
> +	if (!base) {
> +		mdp_err("=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D [MDP] %s Status=
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D\n",
> +			label);
> +		mdp_err("%s:base=3D0!\n", __func__);
> +		return;
> +	}
> +
> +	value[0] =3D MDP_REG_GET32(base + 0x114);
> +	value[1] =3D MDP_REG_GET32(base + 0x11C);
> +	value[2] =3D MDP_REG_GET32(base + 0x104);
> +	value[3] =3D MDP_REG_GET32(base + 0x108);
> +	value[4] =3D MDP_REG_GET32(base + 0x10C);
> +	value[5] =3D MDP_REG_GET32(base + 0x110);
> +	value[6] =3D MDP_REG_GET32(base + 0x120);
> +	value[7] =3D MDP_REG_GET32(base + 0x124);
> +	value[8] =3D MDP_REG_GET32(base + 0x128);
> +	value[9] =3D MDP_REG_GET32(base + 0x12C);
> +	mdp_err("=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D [MDP] %s Status =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D\n",
> +		label);
> +	mdp_err("TDSHP INPUT_CNT: 0x%08x, OUTPUT_CNT: 0x%08x\n",
> +		value[0], value[1]);
> +	mdp_err("TDSHP INTEN: 0x%08x, INTSTA: 0x%08x, STATUS: 0x%08x\n",
> +		value[2], value[3], value[4]);
> +	mdp_err("TDSHP CFG: 0x%08x, IN_SIZE: 0x%08x, OUT_SIZE: 0x%08x\n",
> +		value[5], value[6], value[8]);
> +	mdp_err("TDSHP OUTPUT_OFFSET: 0x%08x, BLANK_WIDTH: 0x%08x\n",
> +		value[7], value[9]);
> +}
> +
> +static void mdp_dump_aal(void __iomem *base, const char *label)
> +{
> +	uint32_t value[9];
> +
> +	if (!base) {
> +		mdp_err("=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D [MDP] %s Status=
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D\n",
> +			label);
> +		mdp_err("%s:base=3D0!\n", __func__);
> +		return;
> +	}
> +
> +	value[0] =3D MDP_REG_GET32(base + 0x00C);    /* MDP_AAL_INTSTA       */
> +	value[1] =3D MDP_REG_GET32(base + 0x010);    /* MDP_AAL_STATUS       */
> +	value[2] =3D MDP_REG_GET32(base + 0x024);    /* MDP_AAL_INPUT_COUNT  */
> +	value[3] =3D MDP_REG_GET32(base + 0x028);    /* MDP_AAL_OUTPUT_COUNT */
> +	value[4] =3D MDP_REG_GET32(base + 0x030);    /* MDP_AAL_SIZE         */
> +	value[5] =3D MDP_REG_GET32(base + 0x034);    /* MDP_AAL_OUTPUT_SIZE  */
> +	value[6] =3D MDP_REG_GET32(base + 0x038);    /* MDP_AAL_OUTPUT_OFFSET*/
> +	value[7] =3D MDP_REG_GET32(base + 0x4EC);    /* MDP_AAL_TILE_00      */
> +	value[8] =3D MDP_REG_GET32(base + 0x4F0);    /* MDP_AAL_TILE_01      */
> +	mdp_err("=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D [MDP] %s Status =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D\n",
> +		label);
> +	mdp_err("AAL_INTSTA: 0x%08x, AAL_STATUS: 0x%08x\n",
> +		value[0], value[1]);
> +	mdp_err("AAL_INPUT_COUNT: 0x%08x, AAL_OUTPUT_COUNT: 0x%08x\n",
> +		value[2], value[3]);
> +	mdp_err("AAL_SIZE: 0x%08x\n", value[4]);
> +	mdp_err("AAL_OUTPUT_SIZE: 0x%08x, AAL_OUTPUT_OFFSET: 0x%08x\n",
> +		value[5], value[6]);
> +	mdp_err("AAL_TILE_00: 0x%08x, AAL_TILE_01: 0x%08x\n",
> +		value[7], value[8]);
> +}
> +
> +static void mdp_dump_ccorr(void __iomem *base, const char *label)
> +{
> +	uint32_t value[5];
> +
> +	if (!base) {
> +		mdp_err("=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D [MDP] %s Status=
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D\n",
> +			label);
> +		mdp_err("%s:base=3D0!\n", __func__);
> +		return;
> +	}
> +
> +	value[0] =3D MDP_REG_GET32(base + 0x00C);/* MDP_CCORR_INTSTA         */
> +	value[1] =3D MDP_REG_GET32(base + 0x010);/* MDP_CCORR_STATUS         */
> +	value[2] =3D MDP_REG_GET32(base + 0x024);/* MDP_CCORR_INPUT_COUNT    */
> +	value[3] =3D MDP_REG_GET32(base + 0x028);/* MDP_CCORR_OUTPUT_COUNT   */
> +	value[4] =3D MDP_REG_GET32(base + 0x030);/* MDP_CCORR_SIZE       */
> +	mdp_err("=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D [MDP] %s Status =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D\n",
> +		label);
> +	mdp_err("CCORR_INTSTA: 0x%08x, CCORR_STATUS: 0x%08x\n",
> +		value[0], value[1]);
> +	mdp_err("CCORR_INPUT_COUNT: 0x%08x, CCORR_OUTPUT_COUNT: 0x%08x\n",
> +		value[2], value[3]);
> +	mdp_err("CCORR_SIZE: 0x%08x\n",
> +		value[4]);
> +}
> +
> +static uint32_t mdp_rdma_get_reg_offset_src_addr(void)
> +{
> +	return 0xF00;
> +}
> +
> +static uint32_t mdp_wrot_get_reg_offset_dst_addr(void)
> +{
> +	return 0xF00;
> +}
> +
> +static uint32_t mdp_wdma_get_reg_offset_dst_addr(void)
> +{
> +	return 0xF00;
> +}
> +
> +static void mdp_platform_function_setting(void)
> +{
> +	struct mdp_func_struct *pFunc =3D mdp_get_func();
> +
> +	pFunc->mdp_dump_mmsys_config =3D mdp_dump_mmsys_config;
> +	pFunc->mdp_dump_rsz =3D mdp_dump_rsz;
> +	pFunc->mdp_dump_tdshp =3D mdp_dump_tdshp;
> +	pFunc->mdp_rdma_get_src_base_addr =3D mdp_rdma_get_reg_offset_src_addr;
> +	pFunc->mdp_wrot_get_reg_offset_dst_addr =3D
> +		mdp_wrot_get_reg_offset_dst_addr;
> +	pFunc->mdp_wdma_get_reg_offset_dst_addr =3D
> +		mdp_wdma_get_reg_offset_dst_addr;
> +}
> +
> +int32_t mdp_dump_info(uint64_t comp_flag, int log_level)
> +{
> +	if (comp_flag & (1LL << MDP_COMP_RDMA0))
> +		mdp_dump_rdma_common(MDP_RDMA0_BASE, "RDMA0");
> +	if (comp_flag & (1LL << MDP_COMP_AAL0))
> +		mdp_dump_aal(MDP_AAL_BASE, "AAL0");
> +	if (comp_flag & (1LL << MDP_COMP_CCORR0))
> +		mdp_dump_ccorr(MDP_CCORR_BASE, "CCORR0");
> +	if (comp_flag & (1LL << MDP_COMP_RSZ0))
> +		mdp_get_func()->mdp_dump_rsz(MDP_RSZ0_BASE, "RSZ0");
> +	if (comp_flag & (1LL << MDP_COMP_RSZ1))
> +		mdp_get_func()->mdp_dump_rsz(MDP_RSZ1_BASE, "RSZ1");
> +	if (comp_flag & (1LL << MDP_COMP_TDSHP0))
> +		mdp_get_func()->mdp_dump_tdshp(MDP_TDSHP_BASE, "TDSHP");
> +	if (comp_flag & (1LL << MDP_COMP_COLOR0))
> +		mdp_dump_color_common(MDP_COLOR_BASE, "COLOR0");
> +	if (comp_flag & (1LL << MDP_COMP_WROT0))
> +		mdp_dump_rot_common(MDP_WROT0_BASE, "WROT0");
> +	if (comp_flag & (1LL << MDP_COMP_WDMA))
> +		mdp_dump_wdma_common(MDP_WDMA_BASE, "WDMA");
> +
> +	return 0;
> +}
> +
> +void mdp_debug_init(struct platform_device *pDevice)
> +{
> +	pr_err("%s:start\n", __func__);
> +	g_mdp_debug.mdp_device =3D pDevice;
> +
> +	mdp_init_module_base_VA();
> +	mdp_map_mmsys_VA();
> +	mdp_virtual_function_setting();
> +	mdp_platform_function_setting();
> +
> +	pr_err("%s:end\n", __func__);
> +}
> +
> +void mdp_debug_deinit(void)
> +{
> +	mdp_deinit_module_base_VA();
> +	mdp_unmap_mmsys_VA();
> +}
> +
> diff --git a/drivers/media/platform/mtk-mdp3/mtk-mdp3-debug.h b/drivers/m=
edia/platform/mtk-mdp3/mtk-mdp3-debug.h
> new file mode 100644
> index 000000000000..083f03367809
> --- /dev/null
> +++ b/drivers/media/platform/mtk-mdp3/mtk-mdp3-debug.h
> @@ -0,0 +1,39 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2018 MediaTek Inc.
> + * Author: Daoyuan Huang <daoyuan.huang@mediatek.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#ifndef __MTK_MDP3_DEBUG_H__
> +#define __MTK_MDP3_DEBUG_H__
> +
> +#include <linux/soc/mediatek/mtk-cmdq.h>
> +
> +#define MDP_DEBUG
> +
> +struct mdp_func_struct {
> +	void (*mdp_dump_mmsys_config)(void);
> +	void (*mdp_dump_rsz)(void __iomem *base, const char *label);
> +	void (*mdp_dump_tdshp)(void __iomem *base, const char *label);
> +	uint32_t (*mdp_rdma_get_src_base_addr)(void);
> +	uint32_t (*mdp_wrot_get_reg_offset_dst_addr)(void);
> +	uint32_t (*mdp_wdma_get_reg_offset_dst_addr)(void);
> +};
> +
> +void mdp_debug_init(struct platform_device *pDevice);
> +void mdp_debug_deinit(void);
> +struct mdp_func_struct *mdp_get_func(void);
> +int32_t mdp_dump_info(uint64_t comp_flag, int log_level);
> +
> +
> +#endif  /* __MTK_MDP3_DEBUG_H__ */
> +
> diff --git a/drivers/media/platform/mtk-mdp3/mtk-mdp3-m2m.c b/drivers/med=
ia/platform/mtk-mdp3/mtk-mdp3-m2m.c
> new file mode 100644
> index 000000000000..536574f6bc32
> --- /dev/null
> +++ b/drivers/media/platform/mtk-mdp3/mtk-mdp3-m2m.c
> @@ -0,0 +1,803 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2018 MediaTek Inc.
> + * Author: Ping-Hsun Wu <ping-hsun.wu@mediatek.com>
> + */
> +
> +#include <linux/platform_device.h>
> +#include <media/v4l2-ioctl.h>
> +#include <media/v4l2-event.h>
> +#include <media/videobuf2-dma-contig.h>
> +#include "mtk-mdp3-m2m.h"
> +
> +static inline struct mdp_m2m_ctx *fh_to_ctx(struct v4l2_fh *fh)
> +{
> +	return container_of(fh, struct mdp_m2m_ctx, fh);
> +}
> +
> +static inline struct mdp_m2m_ctx *ctrl_to_ctx(struct v4l2_ctrl *ctrl)
> +{
> +	return container_of(ctrl->handler, struct mdp_m2m_ctx, ctrl_handler);
> +}
> +
> +static inline struct mdp_frame *ctx_get_frame(struct mdp_m2m_ctx *ctx,
> +					      enum v4l2_buf_type type)
> +{
> +	if (V4L2_TYPE_IS_OUTPUT(type))
> +		return &ctx->curr_param.output;
> +	else
> +		return &ctx->curr_param.captures[0];
> +}
> +
> +static void mdp_m2m_ctx_set_state(struct mdp_m2m_ctx *ctx, u32 state)
> +{
> +	mutex_lock(&ctx->curr_param.state_lock);
> +	ctx->curr_param.state |=3D state;
> +	mutex_unlock(&ctx->curr_param.state_lock);
> +}
> +
> +static bool mdp_m2m_ctx_is_state_set(struct mdp_m2m_ctx *ctx, u32 mask)
> +{
> +	bool ret;
> +
> +	mutex_lock(&ctx->curr_param.state_lock);
> +	ret =3D (ctx->curr_param.state & mask) =3D=3D mask;
> +	mutex_unlock(&ctx->curr_param.state_lock);
> +	return ret;
> +}
> +
> +static void mdp_m2m_ctx_lock(struct vb2_queue *q)
> +{
> +	struct mdp_m2m_ctx *ctx =3D vb2_get_drv_priv(q);
> +
> +	mutex_lock(&ctx->mdp_dev->m2m_lock);
> +}
> +
> +static void mdp_m2m_ctx_unlock(struct vb2_queue *q)
> +{
> +	struct mdp_m2m_ctx *ctx =3D vb2_get_drv_priv(q);
> +
> +	mutex_unlock(&ctx->mdp_dev->m2m_lock);
> +}
> +
> +static void mdp_m2m_job_abort(void *priv)
> +{
> +}
> +
> +static void mdp_m2m_process_done(void *priv, int vb_state)
> +{
> +	struct mdp_m2m_ctx *ctx =3D priv;
> +	struct vb2_v4l2_buffer *src_vbuf, *dst_vbuf;
> +	u32 valid_output_flags =3D V4L2_BUF_FLAG_TIMECODE |
> +				 V4L2_BUF_FLAG_TSTAMP_SRC_MASK |
> +				 V4L2_BUF_FLAG_KEYFRAME |
> +				 V4L2_BUF_FLAG_PFRAME | V4L2_BUF_FLAG_BFRAME;
> +
> +	src_vbuf =3D (struct vb2_v4l2_buffer *)
> +			v4l2_m2m_src_buf_remove(ctx->m2m_ctx);
> +	dst_vbuf =3D (struct vb2_v4l2_buffer *)
> +			v4l2_m2m_dst_buf_remove(ctx->m2m_ctx);
> +
> +	src_vbuf->sequence =3D ctx->frame_count;
> +	dst_vbuf->sequence =3D src_vbuf->sequence;
> +	dst_vbuf->timecode =3D src_vbuf->timecode;
> +	dst_vbuf->flags &=3D ~valid_output_flags;
> +	dst_vbuf->flags |=3D src_vbuf->flags & valid_output_flags;
> +
> +	v4l2_m2m_buf_done(src_vbuf, vb_state);
> +	v4l2_m2m_buf_done(dst_vbuf, vb_state);
> +	v4l2_m2m_job_finish(ctx->mdp_dev->m2m_dev, ctx->m2m_ctx);
> +
> +	ctx->curr_param.frame_no =3D ctx->frame_count++;
> +}
> +
> +static void mdp_m2m_worker(struct work_struct *work)
> +{
> +	struct mdp_m2m_ctx *ctx =3D container_of(work, struct mdp_m2m_ctx, work=
);
> +	struct mdp_frame *frame;
> +	struct vb2_v4l2_buffer *src_vb, *dst_vb;
> +	struct img_ipi_frameparam param =3D {0};
> +	struct mdp_cmdq_param task =3D {0};
> +	enum vb2_buffer_state vb_state =3D VB2_BUF_STATE_ERROR;
> +	int ret;
> +
> +	if (mdp_m2m_ctx_is_state_set(ctx, MDP_M2M_CTX_ERROR)) {
> +		dev_err(&ctx->mdp_dev->pdev->dev,
> +			"mdp_m2m_ctx is in error state\n");
> +		goto worker_end;
> +	}
> +
> +	param.frame_no =3D ctx->curr_param.frame_no;
> +	param.type =3D ctx->curr_param.type;
> +	param.num_inputs =3D 1;
> +	param.num_outputs =3D 1;
> +
> +	frame =3D ctx_get_frame(ctx, V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE);
> +	src_vb =3D v4l2_m2m_next_src_buf(ctx->m2m_ctx);
> +	mdp_set_src_config(&param.inputs[0], frame, &src_vb->vb2_buf);
> +
> +	frame =3D ctx_get_frame(ctx, V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE);
> +	dst_vb =3D v4l2_m2m_next_dst_buf(ctx->m2m_ctx);
> +	mdp_set_dst_config(&param.outputs[0], frame, &dst_vb->vb2_buf);
> +
> +	dst_vb->vb2_buf.timestamp =3D src_vb->vb2_buf.timestamp;
> +	param.timestamp =3D src_vb->vb2_buf.timestamp;
> +
> +	ret =3D mdp_vpu_process(&ctx->vpu, &param);
> +	if (ret) {
> +		dev_err(&ctx->mdp_dev->pdev->dev,
> +			"VPU MDP process failed: %d\n", ret);
> +		goto worker_end;
> +	}
> +
> +	task.config =3D ctx->vpu.config;
> +	task.param =3D &param;
> +	task.composes[0] =3D &frame->compose;
> +	task.cmdq_cb =3D NULL;
> +	task.cb_data =3D NULL;
> +	task.mdp_ctx =3D ctx;
> +
> +	ret =3D mdp_cmdq_send(ctx->mdp_dev, &task);
> +	if (ret) {
> +		dev_err(&ctx->mdp_dev->pdev->dev,
> +			"CMDQ sendtask failed: %d\n", ret);
> +		goto worker_end;
> +	}
> +
> +	return;
> +
> +worker_end:
> +	mdp_m2m_process_done(ctx, vb_state);
> +}
> +
> +static void mdp_m2m_device_run(void *priv)
> +{
> +	struct mdp_m2m_ctx *ctx =3D priv;
> +
> +	queue_work(ctx->mdp_dev->job_wq, &ctx->work);
> +}
> +
> +static int mdp_m2m_start_streaming(struct vb2_queue *q, unsigned int cou=
nt)
> +{
> +	struct mdp_m2m_ctx *ctx =3D vb2_get_drv_priv(q);
> +	int ret;
> +
> +	ret =3D 0;//pm_runtime_get_sync(&ctx->mdp_dev->pdev->dev);
> +	if (ret < 0)
> +		mdp_dbg(1, "[%d] pm_runtime_get_sync failed:%d", ctx->id, ret);
> +
> +	ctx->frame_count =3D 0;
> +
> +	return 0;
> +}
> +
> +static struct vb2_v4l2_buffer *mdp_m2m_buf_remove(struct mdp_m2m_ctx *ct=
x,
> +						  unsigned int type)
> +{
> +	if (V4L2_TYPE_IS_OUTPUT(type))
> +		return (struct vb2_v4l2_buffer *)
> +			v4l2_m2m_src_buf_remove(ctx->m2m_ctx);
> +	else
> +		return (struct vb2_v4l2_buffer *)
> +			v4l2_m2m_dst_buf_remove(ctx->m2m_ctx);
> +}
> +
> +static void mdp_m2m_stop_streaming(struct vb2_queue *q)
> +{
> +	struct mdp_m2m_ctx *ctx =3D vb2_get_drv_priv(q);
> +	struct vb2_v4l2_buffer *vb;
> +
> +	vb =3D mdp_m2m_buf_remove(ctx, q->type);
> +	while (vb) {
> +		v4l2_m2m_buf_done(vb, VB2_BUF_STATE_ERROR);
> +		vb =3D mdp_m2m_buf_remove(ctx, q->type);
> +	}
> +
> +	//pm_runtime_put(&ctx->mdp_dev->pdev->dev);
> +}
> +
> +static int mdp_m2m_queue_setup(struct vb2_queue *q,
> +			       unsigned int *num_buffers,
> +			       unsigned int *num_planes, unsigned int sizes[],
> +			       struct device *alloc_devs[])
> +{
> +	struct mdp_m2m_ctx *ctx =3D vb2_get_drv_priv(q);
> +	struct v4l2_pix_format_mplane *pix_mp;
> +	u32 i;
> +
> +	pix_mp =3D &ctx_get_frame(ctx, q->type)->format.fmt.pix_mp;
> +
> +	/* from VIDIOC_CREATE_BUFS */
> +	if (*num_planes) {
> +		if (*num_planes !=3D pix_mp->num_planes)
> +			return -EINVAL;
> +		for (i =3D 0; i < pix_mp->num_planes; ++i)
> +			if (sizes[i] < pix_mp->plane_fmt[i].sizeimage)
> +				return -EINVAL;
> +	} else {/* from VIDIOC_REQBUFS */
> +		*num_planes =3D pix_mp->num_planes;
> +		for (i =3D 0; i < pix_mp->num_planes; ++i)
> +			sizes[i] =3D pix_mp->plane_fmt[i].sizeimage;
> +	}
> +
> +	mdp_dbg(2, "[%d] type:%d, planes:%u, buffers:%u, size:%u,%u,%u",
> +		ctx->id, q->type, *num_planes, *num_buffers,
> +		sizes[0], sizes[1], sizes[2]);
> +	return 0;
> +}
> +
> +static int mdp_m2m_buf_prepare(struct vb2_buffer *vb)
> +{
> +	struct mdp_m2m_ctx *ctx =3D vb2_get_drv_priv(vb->vb2_queue);
> +	struct v4l2_pix_format_mplane *pix_mp;
> +	struct vb2_v4l2_buffer *v4l2_buf =3D to_vb2_v4l2_buffer(vb);
> +	u32 i;
> +
> +	v4l2_buf->field =3D V4L2_FIELD_NONE;
> +
> +	if (!V4L2_TYPE_IS_OUTPUT(vb->type)) {
> +		pix_mp =3D &ctx_get_frame(ctx, vb->type)->format.fmt.pix_mp;
> +		for (i =3D 0; i < pix_mp->num_planes; ++i) {
> +			vb2_set_plane_payload(vb, i,
> +					      pix_mp->plane_fmt[i].sizeimage);
> +		}
> +	}
> +	return 0;
> +}
> +
> +static int mdp_m2m_buf_out_validate(struct vb2_buffer *vb)
> +{
> +	struct vb2_v4l2_buffer *v4l2_buf =3D to_vb2_v4l2_buffer(vb);
> +
> +	v4l2_buf->field =3D V4L2_FIELD_NONE;
> +
> +	return 0;
> +}
> +
> +static void mdp_m2m_buf_queue(struct vb2_buffer *vb)
> +{
> +	struct mdp_m2m_ctx *ctx =3D vb2_get_drv_priv(vb->vb2_queue);
> +	struct vb2_v4l2_buffer *v4l2_buf =3D to_vb2_v4l2_buffer(vb);
> +
> +	v4l2_buf->field =3D V4L2_FIELD_NONE;
> +
> +	v4l2_m2m_buf_queue(ctx->m2m_ctx, to_vb2_v4l2_buffer(vb));
> +}
> +
> +static const struct vb2_ops mdp_m2m_qops =3D {
> +	.queue_setup	=3D mdp_m2m_queue_setup,
> +	.wait_prepare	=3D mdp_m2m_ctx_unlock,
> +	.wait_finish	=3D mdp_m2m_ctx_lock,
> +	.buf_prepare	=3D mdp_m2m_buf_prepare,
> +	.start_streaming =3D mdp_m2m_start_streaming,
> +	.stop_streaming	=3D mdp_m2m_stop_streaming,
> +	.buf_queue	=3D mdp_m2m_buf_queue,
> +	.buf_out_validate =3D mdp_m2m_buf_out_validate,
> +};
> +
> +static int mdp_m2m_querycap(struct file *file, void *fh,
> +			    struct v4l2_capability *cap)
> +{
> +	struct mdp_m2m_ctx *ctx =3D fh_to_ctx(fh);
> +
> +	strlcpy(cap->driver, MDP_MODULE_NAME, sizeof(cap->driver));
> +	strlcpy(cap->card, ctx->mdp_dev->pdev->name, sizeof(cap->card));
> +	strlcpy(cap->bus_info, "platform:mt8183", sizeof(cap->bus_info));
> +	cap->capabilities =3D V4L2_CAP_VIDEO_M2M_MPLANE | V4L2_CAP_STREAMING |
> +			V4L2_CAP_DEVICE_CAPS; /* | V4L2_CAP_META_OUTPUT */
> +	cap->device_caps =3D V4L2_CAP_VIDEO_M2M_MPLANE | V4L2_CAP_STREAMING;
> +	return 0;
> +}
> +
> +static int mdp_m2m_enum_fmt_mplane(struct file *file, void *fh,
> +				   struct v4l2_fmtdesc *f)
> +{
> +	return mdp_enum_fmt_mplane(f);
> +}
> +
> +static int mdp_m2m_g_fmt_mplane(struct file *file, void *fh,
> +				struct v4l2_format *f)
> +{
> +	struct mdp_m2m_ctx *ctx =3D fh_to_ctx(fh);
> +	struct mdp_frame *frame;
> +	struct v4l2_pix_format_mplane *pix_mp;
> +
> +	frame =3D ctx_get_frame(ctx, f->type);
> +	*f =3D frame->format;
> +	pix_mp =3D &f->fmt.pix_mp;
> +	pix_mp->colorspace =3D ctx->curr_param.colorspace;
> +	pix_mp->xfer_func =3D ctx->curr_param.xfer_func;
> +	pix_mp->ycbcr_enc =3D ctx->curr_param.ycbcr_enc;
> +	pix_mp->quantization =3D ctx->curr_param.quant;
> +
> +	mdp_dbg(2, "[%d] type:%d, frame:%ux%u colorspace=3D%d", ctx->id, f->typ=
e,
> +		f->fmt.pix_mp.width, f->fmt.pix_mp.height,
> +		f->fmt.pix_mp.colorspace);
> +	return 0;
> +}
> +
> +static int mdp_m2m_s_fmt_mplane(struct file *file, void *fh,
> +				struct v4l2_format *f)
> +{
> +	struct mdp_m2m_ctx *ctx =3D fh_to_ctx(fh);
> +	struct mdp_frame *frame =3D ctx_get_frame(ctx, f->type);
> +	struct mdp_frame *capture;
> +	const struct mdp_format *fmt;
> +	struct vb2_queue *vq;
> +
> +	mdp_dbg(2, "[%d] type:%d", ctx->id, f->type);
> +
> +	fmt =3D mdp_try_fmt_mplane(f, &ctx->curr_param, ctx->id);
> +	if (!fmt) {
> +		mdp_err("[%d] try_fmt failed, type:%d", ctx->id, f->type);
> +		return -EINVAL;
> +	}
> +
> +	vq =3D v4l2_m2m_get_vq(ctx->m2m_ctx, f->type);
> +	if (vb2_is_streaming(vq)) {
> +		dev_info(&ctx->mdp_dev->pdev->dev, "Queue %d busy\n", f->type);
> +		return -EBUSY;
> +	}
> +
> +	frame->format =3D *f;
> +	frame->mdp_fmt =3D fmt;
> +	frame->ycbcr_prof =3D mdp_map_ycbcr_prof_mplane(f, fmt->mdp_color);
> +	frame->usage =3D V4L2_TYPE_IS_OUTPUT(f->type) ?
> +		MDP_BUFFER_USAGE_HW_READ : MDP_BUFFER_USAGE_MDP;
> +
> +	capture =3D ctx_get_frame(ctx, V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE);
> +	if (V4L2_TYPE_IS_OUTPUT(f->type)) {
> +		capture->crop.c.left =3D 0;
> +		capture->crop.c.top =3D 0;
> +		capture->crop.c.width =3D f->fmt.pix_mp.width;
> +		capture->crop.c.height =3D f->fmt.pix_mp.height;
> +		ctx->curr_param.colorspace =3D f->fmt.pix_mp.colorspace;
> +		ctx->curr_param.ycbcr_enc =3D f->fmt.pix_mp.ycbcr_enc;
> +		ctx->curr_param.quant =3D f->fmt.pix_mp.quantization;
> +		ctx->curr_param.xfer_func =3D f->fmt.pix_mp.xfer_func;
> +	} else {
> +		capture->compose.left =3D 0;
> +		capture->compose.top =3D 0;
> +		capture->compose.width =3D f->fmt.pix_mp.width;
> +		capture->compose.height =3D f->fmt.pix_mp.height;
> +	}
> +
> +	ctx->frame_count =3D 0;
> +
> +	mdp_dbg(2, "[%d] type:%d, frame:%ux%u", ctx->id, f->type,
> +		f->fmt.pix_mp.width, f->fmt.pix_mp.height);
> +	return 0;
> +}
> +
> +static int mdp_m2m_try_fmt_mplane(struct file *file, void *fh,
> +				  struct v4l2_format *f)
> +{
> +	struct mdp_m2m_ctx *ctx =3D fh_to_ctx(fh);
> +
> +	if (!mdp_try_fmt_mplane(f, &ctx->curr_param, ctx->id))
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +static int mdp_m2m_reqbufs(struct file *file, void *fh,
> +			   struct v4l2_requestbuffers *reqbufs)
> +{
> +	struct mdp_m2m_ctx *ctx =3D fh_to_ctx(fh);
> +
> +	return v4l2_m2m_reqbufs(file, ctx->m2m_ctx, reqbufs);
> +}
> +
> +static int mdp_m2m_streamon(struct file *file, void *fh,
> +			    enum v4l2_buf_type type)
> +{
> +	struct mdp_m2m_ctx *ctx =3D fh_to_ctx(fh);
> +	struct mdp_frame *capture;
> +	int ret;
> +	bool out_streaming, cap_streaming;
> +
> +	capture =3D ctx_get_frame(ctx, V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE);
> +	out_streaming =3D ctx->m2m_ctx->out_q_ctx.q.streaming;
> +	cap_streaming =3D ctx->m2m_ctx->cap_q_ctx.q.streaming;
> +
> +	/* Check to see if scaling ratio is within supported range */
> +	if ((V4L2_TYPE_IS_OUTPUT(type) && cap_streaming) ||
> +	    (!V4L2_TYPE_IS_OUTPUT(type) && out_streaming)) {
> +		ret =3D mdp_check_scaling_ratio(&capture->crop.c,
> +					      &capture->compose,
> +					      capture->rotation,
> +					      ctx->curr_param.limit);
> +		if (ret) {
> +			dev_info(&ctx->mdp_dev->pdev->dev,
> +				 "Out of scaling range\n");
> +			return ret;
> +		}
> +	}
> +
> +	if (!mdp_m2m_ctx_is_state_set(ctx, MDP_VPU_INIT)) {
> +		ret =3D mdp_vpu_get_locked(ctx->mdp_dev);
> +		if (ret)
> +			return ret;
> +
> +		ret =3D mdp_vpu_ctx_init(&ctx->vpu, &ctx->mdp_dev->vpu,
> +				       MDP_DEV_M2M);
> +		if (ret) {
> +			dev_err(&ctx->mdp_dev->pdev->dev,
> +				"VPU init failed %d\n", ret);
> +			return -EINVAL;
> +		}
> +		mdp_m2m_ctx_set_state(ctx, MDP_VPU_INIT);
> +	}
> +
> +	return v4l2_m2m_streamon(file, ctx->m2m_ctx, type);
> +}
> +
> +static int mdp_m2m_g_selection(struct file *file, void *fh,
> +			       struct v4l2_selection *s)
> +{
> +	struct mdp_m2m_ctx *ctx =3D fh_to_ctx(fh);
> +	struct mdp_frame *frame;
> +	bool valid =3D false;
> +
> +	if (s->type <=3D V4L2_BUF_TYPE_META_OUTPUT) {
> +		if (V4L2_TYPE_IS_OUTPUT(s->type))
> +			valid =3D mdp_target_is_crop(s->target);
> +		else
> +			valid =3D mdp_target_is_compose(s->target);
> +	}
> +
> +	if (!valid) {
> +		mdp_dbg(1, "[%d] invalid type:%u target:%u", ctx->id, s->type,
> +			s->target);
> +		return -EINVAL;
> +	}
> +
> +	switch (s->target) {
> +	case V4L2_SEL_TGT_CROP:
> +		frame =3D ctx_get_frame(ctx, V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE);
> +		s->r =3D frame->crop.c;
> +		return 0;
> +	case V4L2_SEL_TGT_COMPOSE:
> +		frame =3D ctx_get_frame(ctx, V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE);
> +		s->r =3D frame->compose;
> +		return 0;
> +	case V4L2_SEL_TGT_CROP_DEFAULT:
> +	case V4L2_SEL_TGT_CROP_BOUNDS:
> +	case V4L2_SEL_TGT_COMPOSE_DEFAULT:
> +	case V4L2_SEL_TGT_COMPOSE_BOUNDS:
> +		frame =3D ctx_get_frame(ctx, s->type);
> +		s->r.left =3D 0;
> +		s->r.top =3D 0;
> +		s->r.width =3D frame->format.fmt.pix_mp.width;
> +		s->r.height =3D frame->format.fmt.pix_mp.height;
> +		return 0;
> +	}
> +	return -EINVAL;
> +}
> +
> +static int mdp_m2m_s_selection(struct file *file, void *fh,
> +			       struct v4l2_selection *s)
> +{
> +	struct mdp_m2m_ctx *ctx =3D fh_to_ctx(fh);
> +	struct mdp_frame *frame =3D ctx_get_frame(ctx, s->type);
> +	struct mdp_frame *capture;
> +	struct v4l2_rect r;
> +	bool valid =3D false;
> +	int ret;
> +
> +	if (s->type <=3D V4L2_BUF_TYPE_META_OUTPUT) {
> +		if (V4L2_TYPE_IS_OUTPUT(s->type))
> +			valid =3D (s->target =3D=3D V4L2_SEL_TGT_CROP);
> +		else
> +			valid =3D (s->target =3D=3D V4L2_SEL_TGT_COMPOSE);
> +	}
> +	if (!valid) {
> +		mdp_dbg(1, "[%d] invalid type:%u target:%u", ctx->id, s->type,
> +			s->target);
> +		return -EINVAL;
> +	}
> +
> +	ret =3D mdp_try_crop(&r, s, frame, ctx->id);
> +	if (ret)
> +		return ret;
> +	capture =3D ctx_get_frame(ctx, V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE);
> +
> +	if (mdp_target_is_crop(s->target))
> +		capture->crop.c =3D r;
> +	else
> +		capture->compose =3D r;
> +
> +	s->r =3D r;
> +	memset(s->reserved, 0, sizeof(s->reserved));
> +
> +	ctx->frame_count =3D 0;
> +	return 0;
> +}
> +
> +static const struct v4l2_ioctl_ops mdp_m2m_ioctl_ops =3D {
> +	.vidioc_querycap		=3D mdp_m2m_querycap,
> +	.vidioc_enum_fmt_vid_cap	=3D mdp_m2m_enum_fmt_mplane,
> +	.vidioc_enum_fmt_vid_out	=3D mdp_m2m_enum_fmt_mplane,
> +	.vidioc_g_fmt_vid_cap_mplane	=3D mdp_m2m_g_fmt_mplane,
> +	.vidioc_g_fmt_vid_out_mplane	=3D mdp_m2m_g_fmt_mplane,
> +	.vidioc_s_fmt_vid_cap_mplane	=3D mdp_m2m_s_fmt_mplane,
> +	.vidioc_s_fmt_vid_out_mplane	=3D mdp_m2m_s_fmt_mplane,
> +	.vidioc_try_fmt_vid_cap_mplane	=3D mdp_m2m_try_fmt_mplane,
> +	.vidioc_try_fmt_vid_out_mplane	=3D mdp_m2m_try_fmt_mplane,
> +	.vidioc_reqbufs			=3D mdp_m2m_reqbufs,
> +	.vidioc_querybuf		=3D v4l2_m2m_ioctl_querybuf,
> +	.vidioc_qbuf			=3D v4l2_m2m_ioctl_qbuf,
> +	.vidioc_expbuf			=3D v4l2_m2m_ioctl_expbuf,
> +	.vidioc_dqbuf			=3D v4l2_m2m_ioctl_dqbuf,
> +	.vidioc_create_bufs		=3D v4l2_m2m_ioctl_create_bufs,
> +	.vidioc_streamon		=3D mdp_m2m_streamon,
> +	.vidioc_streamoff		=3D v4l2_m2m_ioctl_streamoff,
> +	.vidioc_g_selection		=3D mdp_m2m_g_selection,
> +	.vidioc_s_selection		=3D mdp_m2m_s_selection,
> +	.vidioc_subscribe_event		=3D v4l2_ctrl_subscribe_event,
> +	.vidioc_unsubscribe_event	=3D v4l2_event_unsubscribe,
> +};
> +
> +static int mdp_m2m_queue_init(void *priv,
> +			      struct vb2_queue *src_vq,
> +			      struct vb2_queue *dst_vq)
> +{
> +	struct mdp_m2m_ctx *ctx =3D priv;
> +	int ret;
> +
> +	src_vq->type =3D V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE;
> +	src_vq->io_modes =3D VB2_MMAP | VB2_DMABUF;
> +	src_vq->ops =3D &mdp_m2m_qops;
> +	src_vq->mem_ops =3D &vb2_dma_contig_memops;
> +	src_vq->drv_priv =3D ctx;
> +	src_vq->buf_struct_size =3D sizeof(struct v4l2_m2m_buffer);
> +	src_vq->timestamp_flags =3D V4L2_BUF_FLAG_TIMESTAMP_COPY;
> +	src_vq->dev =3D &ctx->mdp_dev->pdev->dev;
> +
> +	ret =3D vb2_queue_init(src_vq);
> +	if (ret)
> +		return ret;
> +
> +	dst_vq->type =3D V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE;
> +	dst_vq->io_modes =3D VB2_MMAP | VB2_DMABUF;
> +	dst_vq->ops =3D &mdp_m2m_qops;
> +	dst_vq->mem_ops =3D &vb2_dma_contig_memops;
> +	dst_vq->drv_priv =3D ctx;
> +	dst_vq->buf_struct_size =3D sizeof(struct v4l2_m2m_buffer);
> +	dst_vq->timestamp_flags =3D V4L2_BUF_FLAG_TIMESTAMP_COPY;
> +	dst_vq->dev =3D &ctx->mdp_dev->pdev->dev;
> +
> +	return vb2_queue_init(dst_vq);
> +}
> +
> +static int mdp_m2m_s_ctrl(struct v4l2_ctrl *ctrl)
> +{
> +	struct mdp_m2m_ctx *ctx =3D ctrl_to_ctx(ctrl);
> +	struct mdp_frame *capture;
> +
> +	if (ctrl->flags & V4L2_CTRL_FLAG_INACTIVE)
> +		return 0;
> +
> +	capture =3D ctx_get_frame(ctx, V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE);
> +	switch (ctrl->id) {
> +	case V4L2_CID_HFLIP:
> +		capture->hflip =3D ctrl->val;
> +		break;
> +	case V4L2_CID_VFLIP:
> +		capture->vflip =3D ctrl->val;
> +		break;
> +	case V4L2_CID_ROTATE:
> +		capture->rotation =3D ctrl->val;
> +		break;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct v4l2_ctrl_ops mdp_m2m_ctrl_ops =3D {
> +	.s_ctrl	=3D mdp_m2m_s_ctrl,
> +};
> +
> +static int mdp_m2m_ctrls_create(struct mdp_m2m_ctx *ctx)
> +{
> +	v4l2_ctrl_handler_init(&ctx->ctrl_handler, MDP_MAX_CTRLS);
> +	ctx->ctrls.hflip =3D v4l2_ctrl_new_std(&ctx->ctrl_handler,
> +					     &mdp_m2m_ctrl_ops, V4L2_CID_HFLIP,
> +					     0, 1, 1, 0);
> +	ctx->ctrls.vflip =3D v4l2_ctrl_new_std(&ctx->ctrl_handler,
> +					     &mdp_m2m_ctrl_ops, V4L2_CID_VFLIP,
> +					     0, 1, 1, 0);
> +	ctx->ctrls.rotate =3D v4l2_ctrl_new_std(&ctx->ctrl_handler,
> +					      &mdp_m2m_ctrl_ops,
> +					      V4L2_CID_ROTATE, 0, 270, 90, 0);
> +
> +	if (ctx->ctrl_handler.error) {
> +		int err =3D ctx->ctrl_handler.error;
> +
> +		v4l2_ctrl_handler_free(&ctx->ctrl_handler);
> +		dev_err(&ctx->mdp_dev->pdev->dev,
> +			"Failed to register controls\n");
> +		return err;
> +	}
> +	return 0;
> +}
> +
> +static int mdp_m2m_open(struct file *file)
> +{
> +	struct video_device *vdev =3D video_devdata(file);
> +	struct mdp_dev *mdp =3D video_get_drvdata(vdev);
> +	struct mdp_m2m_ctx *ctx;
> +	int ret;
> +	struct v4l2_format default_format;
> +
> +	ctx =3D kzalloc(sizeof(*ctx), GFP_KERNEL);
> +	if (!ctx)
> +		return -ENOMEM;
> +
> +	if (mutex_lock_interruptible(&mdp->m2m_lock)) {
> +		ret =3D -ERESTARTSYS;
> +		goto err_free_ctx;
> +	}
> +
> +	ctx->id =3D ida_alloc(&mdp->mdp_ida, GFP_KERNEL);
> +	ctx->mdp_dev =3D mdp;
> +
> +	v4l2_fh_init(&ctx->fh, vdev);
> +	vdev->device_caps =3D V4L2_CAP_VIDEO_M2M_MPLANE | V4L2_CAP_STREAMING;
> +	file->private_data =3D &ctx->fh;
> +	ret =3D mdp_m2m_ctrls_create(ctx);
> +	if (ret)
> +		goto err_exit_fh;
> +
> +	/* Use separate control handler per file handle */
> +	ctx->fh.ctrl_handler =3D &ctx->ctrl_handler;
> +	v4l2_fh_add(&ctx->fh);
> +
> +	ctx->m2m_ctx =3D v4l2_m2m_ctx_init(mdp->m2m_dev, ctx, mdp_m2m_queue_ini=
t);
> +	if (IS_ERR(ctx->m2m_ctx)) {
> +		dev_err(&mdp->pdev->dev, "Failed to initialize m2m context\n");
> +		ret =3D PTR_ERR(ctx->m2m_ctx);
> +		goto err_release_handler;
> +	}
> +	ctx->fh.m2m_ctx =3D ctx->m2m_ctx;
> +
> +	INIT_WORK(&ctx->work, mdp_m2m_worker);
> +
> +	ret =3D mdp_frameparam_init(&ctx->curr_param);
> +	if (ret) {
> +		dev_err(&mdp->pdev->dev,
> +			"Failed to initialize mdp parameter\n");
> +		goto err_release_m2m_ctx;
> +	}
> +
> +	mutex_unlock(&mdp->m2m_lock);
> +
> +	/* Default format */
> +	memset(&default_format, 0, sizeof(default_format));
> +	default_format.type =3D V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE;
> +	default_format.fmt.pix_mp.width =3D 32;
> +	default_format.fmt.pix_mp.height =3D 32;
> +	default_format.fmt.pix_mp.pixelformat =3D V4L2_PIX_FMT_YUV420M;
> +	mdp_m2m_s_fmt_mplane(file, &ctx->fh, &default_format);
> +	default_format.type =3D V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE;
> +	mdp_m2m_s_fmt_mplane(file, &ctx->fh, &default_format);
> +
> +	mdp_dbg(1, "%s [%d]", dev_name(&mdp->pdev->dev), ctx->id);
> +
> +	return 0;
> +
> +err_release_m2m_ctx:
> +	v4l2_m2m_ctx_release(ctx->m2m_ctx);
> +err_release_handler:
> +	v4l2_ctrl_handler_free(&ctx->ctrl_handler);
> +	v4l2_fh_del(&ctx->fh);
> +err_exit_fh:
> +	v4l2_fh_exit(&ctx->fh);
> +	mutex_unlock(&mdp->m2m_lock);
> +err_free_ctx:
> +	kfree(ctx);
> +
> +	return ret;
> +}
> +
> +static int mdp_m2m_release(struct file *file)
> +{
> +	struct mdp_m2m_ctx *ctx =3D fh_to_ctx(file->private_data);
> +	struct mdp_dev *mdp =3D video_drvdata(file);
> +
> +	mutex_lock(&mdp->m2m_lock);
> +	v4l2_m2m_ctx_release(ctx->m2m_ctx);
> +	if (mdp_m2m_ctx_is_state_set(ctx, MDP_VPU_INIT)) {
> +		mdp_vpu_ctx_deinit(&ctx->vpu);
> +		mdp_vpu_put_locked(mdp);
> +	}
> +
> +	v4l2_ctrl_handler_free(&ctx->ctrl_handler);
> +	v4l2_fh_del(&ctx->fh);
> +	v4l2_fh_exit(&ctx->fh);
> +	ida_free(&mdp->mdp_ida, ctx->id);
> +	mutex_unlock(&mdp->m2m_lock);
> +
> +	mdp_dbg(1, "%s [%d]", dev_name(&mdp->pdev->dev), ctx->id);
> +	kfree(ctx);
> +
> +	return 0;
> +}
> +
> +static const struct v4l2_file_operations mdp_m2m_fops =3D {
> +	.owner		=3D THIS_MODULE,
> +	.poll		=3D v4l2_m2m_fop_poll,
> +	.unlocked_ioctl	=3D video_ioctl2,
> +	.mmap		=3D v4l2_m2m_fop_mmap,
> +	.open		=3D mdp_m2m_open,
> +	.release	=3D mdp_m2m_release,
> +};
> +
> +static const struct v4l2_m2m_ops mdp_m2m_ops =3D {
> +	.device_run	=3D mdp_m2m_device_run,
> +	.job_abort	=3D mdp_m2m_job_abort,
> +};
> +
> +int mdp_m2m_device_register(struct mdp_dev *mdp)
> +{
> +	struct device *dev =3D &mdp->pdev->dev;
> +	int ret =3D 0;
> +
> +	mdp->m2m_vdev =3D video_device_alloc();
> +	if (!mdp->m2m_vdev) {
> +		dev_err(dev, "Failed to allocate video device\n");
> +		ret =3D -ENOMEM;
> +		goto err_video_alloc;
> +	}
> +	//mdp->m2m_vdev->device_caps =3D V4L2_CAP_VIDEO_M2M_MPLANE |
> +	//	V4L2_CAP_STREAMING;
> +	mdp->m2m_vdev->fops =3D &mdp_m2m_fops;
> +	mdp->m2m_vdev->ioctl_ops =3D &mdp_m2m_ioctl_ops;
> +	mdp->m2m_vdev->release =3D video_device_release;
> +	mdp->m2m_vdev->lock =3D &mdp->m2m_lock;
> +	mdp->m2m_vdev->vfl_dir =3D VFL_DIR_M2M;
> +	mdp->m2m_vdev->v4l2_dev =3D &mdp->v4l2_dev;
> +	snprintf(mdp->m2m_vdev->name, sizeof(mdp->m2m_vdev->name), "%s:m2m",
> +		 MDP_MODULE_NAME);
> +	video_set_drvdata(mdp->m2m_vdev, mdp);
> +
> +	mdp->m2m_dev =3D v4l2_m2m_init(&mdp_m2m_ops);
> +	if (IS_ERR(mdp->m2m_dev)) {
> +		dev_err(dev, "Failed to initialize v4l2-m2m device\n");
> +		ret =3D PTR_ERR(mdp->m2m_dev);
> +		goto err_m2m_init;
> +	}
> +
> +	ret =3D video_register_device(mdp->m2m_vdev, VFL_TYPE_VIDEO, 2);
> +	if (ret) {
> +		dev_err(dev, "Failed to register video device\n");
> +		goto err_video_register;
> +	}
> +
> +	v4l2_info(&mdp->v4l2_dev, "Driver registered as /dev/video%d",
> +		  mdp->m2m_vdev->num);
> +	return 0;
> +
> +err_video_register:
> +	v4l2_m2m_release(mdp->m2m_dev);
> +err_m2m_init:
> +	video_device_release(mdp->m2m_vdev);
> +err_video_alloc:
> +
> +	return ret;
> +}
> +
> +void mdp_m2m_device_unregister(struct mdp_dev *mdp)
> +{
> +	video_unregister_device(mdp->m2m_vdev);
> +	video_device_release(mdp->m2m_vdev);
> +	v4l2_m2m_release(mdp->m2m_dev);
> +}
> +
> +void mdp_m2m_job_finish(struct mdp_m2m_ctx *ctx)
> +{
> +	enum vb2_buffer_state vb_state =3D VB2_BUF_STATE_DONE;
> +
> +	mdp_m2m_process_done(ctx, vb_state);
> +}
> +
> diff --git a/drivers/media/platform/mtk-mdp3/mtk-mdp3-m2m.h b/drivers/med=
ia/platform/mtk-mdp3/mtk-mdp3-m2m.h
> new file mode 100644
> index 000000000000..c3f340f7ec49
> --- /dev/null
> +++ b/drivers/media/platform/mtk-mdp3/mtk-mdp3-m2m.h
> @@ -0,0 +1,42 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2018 MediaTek Inc.
> + * Author: Ping-Hsun Wu <ping-hsun.wu@mediatek.com>
> + */
> +
> +#ifndef __MTK_MDP3_M2M_H__
> +#define __MTK_MDP3_M2M_H__
> +
> +#include <media/v4l2-ctrls.h>
> +#include "mtk-mdp3-core.h"
> +#include "mtk-mdp3-vpu.h"
> +#include "mtk-mdp3-regs.h"
> +
> +#define MDP_MAX_CTRLS	10
> +
> +struct mdp_m2m_ctrls {
> +	struct v4l2_ctrl	*hflip;
> +	struct v4l2_ctrl	*vflip;
> +	struct v4l2_ctrl	*rotate;
> +};
> +
> +struct mdp_m2m_ctx {
> +	u32				id;
> +	struct mdp_dev			*mdp_dev;
> +	struct v4l2_fh			fh;
> +	struct v4l2_ctrl_handler	ctrl_handler;
> +	struct mdp_m2m_ctrls		ctrls;
> +	struct v4l2_m2m_ctx		*m2m_ctx;
> +	struct mdp_vpu_ctx		vpu;
> +	struct work_struct		work;
> +	u32				frame_count;
> +
> +	struct mdp_frameparam		curr_param;
> +};
> +
> +int mdp_m2m_device_register(struct mdp_dev *mdp);
> +void mdp_m2m_device_unregister(struct mdp_dev *mdp);
> +void mdp_m2m_job_finish(struct mdp_m2m_ctx *ctx);
> +
> +#endif  /* __MTK_MDP3_M2M_H__ */
> +
> diff --git a/drivers/media/platform/mtk-mdp3/mtk-mdp3-regs.c b/drivers/me=
dia/platform/mtk-mdp3/mtk-mdp3-regs.c
> new file mode 100644
> index 000000000000..0c4c942b5f9c
> --- /dev/null
> +++ b/drivers/media/platform/mtk-mdp3/mtk-mdp3-regs.c
> @@ -0,0 +1,748 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2018 MediaTek Inc.
> + * Author: Ping-Hsun Wu <ping-hsun.wu@mediatek.com>
> + */
> +
> +#include <media/v4l2-common.h>
> +#include <media/videobuf2-v4l2.h>
> +#include <media/videobuf2-dma-contig.h>
> +#include "mtk-mdp3-core.h"
> +#include "mtk-mdp3-regs.h"
> +
> +static const struct mdp_format mdp_formats[] =3D {
> +	{
> +		.pixelformat	=3D V4L2_PIX_FMT_GREY,
> +		.mdp_color	=3D MDP_COLOR_GREY,
> +		.depth		=3D { 8 },
> +		.row_depth	=3D { 8 },
> +		.num_planes	=3D 1,
> +		.flags		=3D MDP_FMT_FLAG_OUTPUT | MDP_FMT_FLAG_CAPTURE,
> +	}, {
> +		.pixelformat	=3D V4L2_PIX_FMT_RGB565X,
> +		.mdp_color	=3D MDP_COLOR_RGB565,
> +		.depth		=3D { 16 },
> +		.row_depth	=3D { 16 },
> +		.num_planes	=3D 1,
> +		.flags		=3D MDP_FMT_FLAG_OUTPUT | MDP_FMT_FLAG_CAPTURE,
> +	}, {
> +		.pixelformat	=3D V4L2_PIX_FMT_RGB565,
> +		.mdp_color	=3D MDP_COLOR_BGR565,
> +		.depth		=3D { 16 },
> +		.row_depth	=3D { 16 },
> +		.num_planes	=3D 1,
> +		.flags		=3D MDP_FMT_FLAG_OUTPUT | MDP_FMT_FLAG_CAPTURE,
> +	}, {
> +		.pixelformat	=3D V4L2_PIX_FMT_RGB24,
> +		.mdp_color	=3D MDP_COLOR_RGB888,
> +		.depth		=3D { 24 },
> +		.row_depth	=3D { 24 },
> +		.num_planes	=3D 1,
> +		.flags		=3D MDP_FMT_FLAG_OUTPUT | MDP_FMT_FLAG_CAPTURE,
> +	}, {
> +		.pixelformat	=3D V4L2_PIX_FMT_BGR24,
> +		.mdp_color	=3D MDP_COLOR_BGR888,
> +		.depth		=3D { 24 },
> +		.row_depth	=3D { 24 },
> +		.num_planes	=3D 1,
> +		.flags		=3D MDP_FMT_FLAG_OUTPUT | MDP_FMT_FLAG_CAPTURE,
> +	}, {
> +		.pixelformat	=3D V4L2_PIX_FMT_ABGR32,
> +		.mdp_color	=3D MDP_COLOR_BGRA8888,
> +		.depth		=3D { 32 },
> +		.row_depth	=3D { 32 },
> +		.num_planes	=3D 1,
> +		.flags		=3D MDP_FMT_FLAG_OUTPUT | MDP_FMT_FLAG_CAPTURE,
> +	}, {
> +		.pixelformat	=3D V4L2_PIX_FMT_ARGB32,
> +		.mdp_color	=3D MDP_COLOR_ARGB8888,
> +		.depth		=3D { 32 },
> +		.row_depth	=3D { 32 },
> +		.num_planes	=3D 1,
> +		.flags		=3D MDP_FMT_FLAG_OUTPUT | MDP_FMT_FLAG_CAPTURE,
> +	}, {
> +		.pixelformat	=3D V4L2_PIX_FMT_UYVY,
> +		.mdp_color	=3D MDP_COLOR_UYVY,
> +		.depth		=3D { 16 },
> +		.row_depth	=3D { 16 },
> +		.num_planes	=3D 1,
> +		.walign		=3D 1,
> +		.flags		=3D MDP_FMT_FLAG_OUTPUT | MDP_FMT_FLAG_CAPTURE,
> +	}, {
> +		.pixelformat	=3D V4L2_PIX_FMT_VYUY,
> +		.mdp_color	=3D MDP_COLOR_VYUY,
> +		.depth		=3D { 16 },
> +		.row_depth	=3D { 16 },
> +		.num_planes	=3D 1,
> +		.walign		=3D 1,
> +		.flags		=3D MDP_FMT_FLAG_OUTPUT | MDP_FMT_FLAG_CAPTURE,
> +	}, {
> +		.pixelformat	=3D V4L2_PIX_FMT_YUYV,
> +		.mdp_color	=3D MDP_COLOR_YUYV,
> +		.depth		=3D { 16 },
> +		.row_depth	=3D { 16 },
> +		.num_planes	=3D 1,
> +		.walign		=3D 1,
> +		.flags		=3D MDP_FMT_FLAG_OUTPUT | MDP_FMT_FLAG_CAPTURE,
> +	}, {
> +		.pixelformat	=3D V4L2_PIX_FMT_YVYU,
> +		.mdp_color	=3D MDP_COLOR_YVYU,
> +		.depth		=3D { 16 },
> +		.row_depth	=3D { 16 },
> +		.num_planes	=3D 1,
> +		.walign		=3D 1,
> +		.flags		=3D MDP_FMT_FLAG_OUTPUT | MDP_FMT_FLAG_CAPTURE,
> +	}, {
> +		.pixelformat	=3D V4L2_PIX_FMT_YUV420,
> +		.mdp_color	=3D MDP_COLOR_I420,
> +		.depth		=3D { 12 },
> +		.row_depth	=3D { 8 },
> +		.num_planes	=3D 1,
> +		.walign		=3D 1,
> +		.halign		=3D 1,
> +		.flags		=3D MDP_FMT_FLAG_OUTPUT | MDP_FMT_FLAG_CAPTURE,
> +	}, {
> +		.pixelformat	=3D V4L2_PIX_FMT_YVU420,
> +		.mdp_color	=3D MDP_COLOR_YV12,
> +		.depth		=3D { 12 },
> +		.row_depth	=3D { 8 },
> +		.num_planes	=3D 1,
> +		.walign		=3D 1,
> +		.halign		=3D 1,
> +		.flags		=3D MDP_FMT_FLAG_OUTPUT | MDP_FMT_FLAG_CAPTURE,
> +	}, {
> +		.pixelformat	=3D V4L2_PIX_FMT_NV12,
> +		.mdp_color	=3D MDP_COLOR_NV12,
> +		.depth		=3D { 12 },
> +		.row_depth	=3D { 8 },
> +		.num_planes	=3D 1,
> +		.walign		=3D 1,
> +		.halign		=3D 1,
> +		.flags		=3D MDP_FMT_FLAG_OUTPUT | MDP_FMT_FLAG_CAPTURE,
> +	}, {
> +		.pixelformat	=3D V4L2_PIX_FMT_NV21,
> +		.mdp_color	=3D MDP_COLOR_NV21,
> +		.depth		=3D { 12 },
> +		.row_depth	=3D { 8 },
> +		.num_planes	=3D 1,
> +		.walign		=3D 1,
> +		.halign		=3D 1,
> +		.flags		=3D MDP_FMT_FLAG_OUTPUT | MDP_FMT_FLAG_CAPTURE,
> +	}, {
> +		.pixelformat	=3D V4L2_PIX_FMT_NV16,
> +		.mdp_color	=3D MDP_COLOR_NV16,
> +		.depth		=3D { 16 },
> +		.row_depth	=3D { 8 },
> +		.num_planes	=3D 1,
> +		.walign		=3D 1,
> +		.flags		=3D MDP_FMT_FLAG_OUTPUT,
> +	}, {
> +		.pixelformat	=3D V4L2_PIX_FMT_NV61,
> +		.mdp_color	=3D MDP_COLOR_NV61,
> +		.depth		=3D { 16 },
> +		.row_depth	=3D { 8 },
> +		.num_planes	=3D 1,
> +		.walign		=3D 1,
> +		.flags		=3D MDP_FMT_FLAG_OUTPUT,
> +	}, {
> +		.pixelformat	=3D V4L2_PIX_FMT_NV24,
> +		.mdp_color	=3D MDP_COLOR_NV24,
> +		.depth		=3D { 24 },
> +		.row_depth	=3D { 8 },
> +		.num_planes	=3D 1,
> +		.flags		=3D MDP_FMT_FLAG_OUTPUT,
> +	}, {
> +		.pixelformat	=3D V4L2_PIX_FMT_NV42,
> +		.mdp_color	=3D MDP_COLOR_NV42,
> +		.depth		=3D { 24 },
> +		.row_depth	=3D { 8 },
> +		.num_planes	=3D 1,
> +		.flags		=3D MDP_FMT_FLAG_OUTPUT,
> +	}, {
> +		.pixelformat	=3D V4L2_PIX_FMT_MT21C,
> +		.mdp_color	=3D MDP_COLOR_420_BLK_UFO,
> +		.depth		=3D { 8, 4 },
> +		.row_depth	=3D { 8, 8 },
> +		.num_planes	=3D 2,
> +		.walign		=3D 4,
> +		.halign		=3D 5,
> +		.flags		=3D MDP_FMT_FLAG_OUTPUT,
> +	}, {
> +		.pixelformat	=3D V4L2_PIX_FMT_NV12MT,
> +		.mdp_color	=3D MDP_COLOR_420_BLK,
> +		.depth		=3D { 8, 4 },
> +		.row_depth	=3D { 8, 8 },
> +		.num_planes	=3D 2,
> +		.walign		=3D 4,
> +		.halign		=3D 5,
> +		.flags		=3D MDP_FMT_FLAG_OUTPUT,
> +	}, {
> +		.pixelformat	=3D V4L2_PIX_FMT_NV12M,
> +		.mdp_color	=3D MDP_COLOR_NV12,
> +		.depth		=3D { 8, 4 },
> +		.row_depth	=3D { 8, 8 },
> +		.num_planes	=3D 2,
> +		.walign		=3D 1,
> +		.halign		=3D 1,
> +		.flags		=3D MDP_FMT_FLAG_OUTPUT | MDP_FMT_FLAG_CAPTURE,
> +	}, {
> +		.pixelformat	=3D V4L2_PIX_FMT_NV21M,
> +		.mdp_color	=3D MDP_COLOR_NV21,
> +		.depth		=3D { 8, 4 },
> +		.row_depth	=3D { 8, 8 },
> +		.num_planes	=3D 2,
> +		.walign		=3D 1,
> +		.halign		=3D 1,
> +		.flags		=3D MDP_FMT_FLAG_OUTPUT | MDP_FMT_FLAG_CAPTURE,
> +	}, {
> +		.pixelformat	=3D V4L2_PIX_FMT_NV16M,
> +		.mdp_color	=3D MDP_COLOR_NV16,
> +		.depth		=3D { 8, 8 },
> +		.row_depth	=3D { 8, 8 },
> +		.num_planes	=3D 2,
> +		.walign		=3D 1,
> +		.flags		=3D MDP_FMT_FLAG_OUTPUT,
> +	}, {
> +		.pixelformat	=3D V4L2_PIX_FMT_NV61M,
> +		.mdp_color	=3D MDP_COLOR_NV61,
> +		.depth		=3D { 8, 8 },
> +		.row_depth	=3D { 8, 8 },
> +		.num_planes	=3D 2,
> +		.walign		=3D 1,
> +		.flags		=3D MDP_FMT_FLAG_OUTPUT,
> +	}, {
> +		.pixelformat	=3D V4L2_PIX_FMT_YUV420M,
> +		.mdp_color	=3D MDP_COLOR_I420,
> +		.depth		=3D { 8, 2, 2 },
> +		.row_depth	=3D { 8, 4, 4 },
> +		.num_planes	=3D 3,
> +		.walign		=3D 1,
> +		.halign		=3D 1,
> +		.flags		=3D MDP_FMT_FLAG_OUTPUT | MDP_FMT_FLAG_CAPTURE,
> +	}, {
> +		.pixelformat	=3D V4L2_PIX_FMT_YVU420M,
> +		.mdp_color	=3D MDP_COLOR_YV12,
> +		.depth		=3D { 8, 2, 2 },
> +		.row_depth	=3D { 8, 4, 4 },
> +		.num_planes	=3D 3,
> +		.walign		=3D 1,
> +		.halign		=3D 1,
> +		.flags		=3D MDP_FMT_FLAG_OUTPUT | MDP_FMT_FLAG_CAPTURE,
> +	}
> +};
> +
> +static const struct mdp_limit mdp_def_limit =3D {
> +	.out_limit =3D {
> +		.wmin	=3D 16,
> +		.hmin	=3D 16,
> +		.wmax	=3D 8176,
> +		.hmax	=3D 8176,
> +	},
> +	.cap_limit =3D {
> +		.wmin	=3D 2,
> +		.hmin	=3D 2,
> +		.wmax	=3D 8176,
> +		.hmax	=3D 8176,
> +	},
> +	.h_scale_up_max =3D 32,
> +	.v_scale_up_max =3D 32,
> +	.h_scale_down_max =3D 20,
> +	.v_scale_down_max =3D 128,
> +};
> +
> +static const struct mdp_format *mdp_find_fmt(u32 pixelformat, u32 type)
> +{
> +	u32 i, flag;
> +
> +	flag =3D V4L2_TYPE_IS_OUTPUT(type) ? MDP_FMT_FLAG_OUTPUT :
> +					MDP_FMT_FLAG_CAPTURE;
> +	for (i =3D 0; i < ARRAY_SIZE(mdp_formats); ++i) {
> +		if (!(mdp_formats[i].flags & flag))
> +			continue;
> +		if (mdp_formats[i].pixelformat =3D=3D pixelformat)
> +			return &mdp_formats[i];
> +	}
> +	return NULL;
> +}
> +
> +static const struct mdp_format *mdp_find_fmt_by_index(u32 index, u32 typ=
e)
> +{
> +	u32 i, flag, num =3D 0;
> +
> +	flag =3D V4L2_TYPE_IS_OUTPUT(type) ? MDP_FMT_FLAG_OUTPUT :
> +					MDP_FMT_FLAG_CAPTURE;
> +	for (i =3D 0; i < ARRAY_SIZE(mdp_formats); ++i) {
> +		if (!(mdp_formats[i].flags & flag))
> +			continue;
> +		if (index =3D=3D num)
> +			return &mdp_formats[i];
> +		num++;
> +	}
> +	return NULL;
> +}
> +
> +enum mdp_ycbcr_profile mdp_map_ycbcr_prof_mplane(struct v4l2_format *f,
> +						 u32 mdp_color)
> +{
> +	struct v4l2_pix_format_mplane *pix_mp =3D &f->fmt.pix_mp;
> +
> +	if (MDP_COLOR_IS_RGB(mdp_color))
> +		return MDP_YCBCR_PROFILE_FULL_BT601;
> +
> +	switch (pix_mp->colorspace) {
> +	case V4L2_COLORSPACE_JPEG:
> +		return MDP_YCBCR_PROFILE_JPEG;
> +	case V4L2_COLORSPACE_REC709:
> +	case V4L2_COLORSPACE_DCI_P3:
> +		if (pix_mp->quantization =3D=3D V4L2_QUANTIZATION_FULL_RANGE)
> +			return MDP_YCBCR_PROFILE_FULL_BT709;
> +		return MDP_YCBCR_PROFILE_BT709;
> +	case V4L2_COLORSPACE_BT2020:
> +		if (pix_mp->quantization =3D=3D V4L2_QUANTIZATION_FULL_RANGE)
> +			return MDP_YCBCR_PROFILE_FULL_BT2020;
> +		return MDP_YCBCR_PROFILE_BT2020;
> +	default:
> +		if (pix_mp->quantization =3D=3D V4L2_QUANTIZATION_FULL_RANGE)
> +			return MDP_YCBCR_PROFILE_FULL_BT601;
> +		return MDP_YCBCR_PROFILE_BT601;
> +	}
> +}
> +
> +static void mdp_bound_align_image(u32 *w, unsigned int wmin, unsigned in=
t wmax,
> +				  unsigned int walign,
> +				u32 *h, unsigned int hmin, unsigned int hmax,
> +				unsigned int halign, unsigned int salign)
> +{
> +	unsigned int org_w, org_h, wstep, hstep;
> +
> +	org_w =3D *w;
> +	org_h =3D *h;
> +	v4l_bound_align_image(w, wmin, wmax, walign, h, hmin, hmax, halign,
> +			      salign);
> +
> +	wstep =3D 1 << walign;
> +	hstep =3D 1 << halign;
> +	if (*w < org_w && (*w + wstep) <=3D wmax)
> +		*w +=3D wstep;
> +	if (*h < org_h && (*h + hstep) <=3D hmax)
> +		*h +=3D hstep;
> +}
> +
> +static int mdp_clamp_align(s32 *x, int min, int max, unsigned int align)
> +{
> +	unsigned int mask;
> +
> +	if (min < 0 || max < 0)
> +		return -ERANGE;
> +
> +	/* Bits that must be zero to be aligned */
> +	mask =3D ~((1 << align) - 1);
> +
> +	min =3D 0 ? 0 : ((min + ~mask) & mask);
> +	max =3D max & mask;
> +	if ((unsigned int)min > (unsigned int)max)
> +		return -ERANGE;
> +
> +	/* Clamp to aligned min and max */
> +	*x =3D clamp(*x, min, max);
> +
> +	/* Round to nearest aligned value */
> +	if (align)
> +		*x =3D (*x + (1 << (align - 1))) & mask;
> +	return 0;
> +}
> +
> +int mdp_enum_fmt_mplane(struct v4l2_fmtdesc *f)
> +{
> +	const struct mdp_format *fmt;
> +
> +	if (!V4L2_TYPE_IS_MULTIPLANAR(f->type))
> +		return -EINVAL;
> +
> +	fmt =3D mdp_find_fmt_by_index(f->index, f->type);
> +	if (!fmt)
> +		return -EINVAL;
> +
> +	/* f->description */
> +	f->pixelformat =3D fmt->pixelformat;
> +	return 0;
> +}
> +
> +const struct mdp_format *mdp_try_fmt_mplane(struct v4l2_format *f,
> +					    struct mdp_frameparam *param,
> +					    u32 ctx_id)
> +{
> +	struct v4l2_pix_format_mplane *pix_mp =3D &f->fmt.pix_mp;
> +	const struct mdp_format *fmt;
> +	const struct mdp_pix_limit *pix_limit;
> +	u32 wmin, wmax, hmin, hmax, org_w, org_h;
> +	unsigned int i;
> +
> +	if (!V4L2_TYPE_IS_MULTIPLANAR(f->type))
> +		return NULL;
> +
> +	fmt =3D mdp_find_fmt(pix_mp->pixelformat, f->type);
> +	if (!fmt)
> +		fmt =3D mdp_find_fmt_by_index(0, f->type);
> +	if (!fmt) {
> +		mdp_dbg(0, "[%d] pixelformat %c%c%c%c invalid", ctx_id,
> +			(pix_mp->pixelformat & 0xff),
> +			(pix_mp->pixelformat >>  8) & 0xff,
> +			(pix_mp->pixelformat >> 16) & 0xff,
> +			(pix_mp->pixelformat >> 24) & 0xff);
> +		return NULL;
> +	}
> +
> +	pix_mp->field =3D V4L2_FIELD_NONE;
> +	pix_mp->flags =3D 0;
> +	pix_mp->pixelformat =3D fmt->pixelformat;
> +	if (!V4L2_TYPE_IS_OUTPUT(f->type)) {
> +		pix_mp->colorspace =3D param->colorspace;
> +		pix_mp->xfer_func =3D param->xfer_func;
> +		pix_mp->ycbcr_enc =3D param->ycbcr_enc;
> +		pix_mp->quantization =3D param->quant;
> +	}
> +	memset(pix_mp->reserved, 0, sizeof(pix_mp->reserved));
> +
> +	pix_limit =3D V4L2_TYPE_IS_OUTPUT(f->type) ? &param->limit->out_limit :
> +		&param->limit->cap_limit;
> +	wmin =3D pix_limit->wmin;
> +	wmax =3D pix_limit->wmax;
> +	hmin =3D pix_limit->hmin;
> +	hmax =3D pix_limit->hmax;
> +	org_w =3D pix_mp->width;
> +	org_h =3D pix_mp->height;
> +
> +	mdp_bound_align_image(&pix_mp->width, wmin, wmax, fmt->walign,
> +			      &pix_mp->height, hmin, hmax, fmt->halign,
> +				fmt->salign);
> +	if (org_w !=3D pix_mp->width || org_h !=3D pix_mp->height)
> +		mdp_dbg(1, "[%d] size change: %ux%u to %ux%u", ctx_id,
> +			org_w, org_h, pix_mp->width, pix_mp->height);
> +
> +	if (pix_mp->num_planes && pix_mp->num_planes !=3D fmt->num_planes)
> +		mdp_dbg(1, "[%d] num of planes change: %u to %u", ctx_id,
> +			pix_mp->num_planes, fmt->num_planes);
> +	pix_mp->num_planes =3D fmt->num_planes;
> +
> +	for (i =3D 0; i < pix_mp->num_planes; ++i) {
> +		u32 min_bpl =3D (pix_mp->width * fmt->row_depth[i]) / 8;
> +		u32 bpl =3D pix_mp->plane_fmt[i].bytesperline;
> +		u32 si;
> +
> +		if (bpl < min_bpl)
> +			bpl =3D min_bpl;
> +		si =3D (bpl * pix_mp->height * fmt->depth[i]) / fmt->row_depth[i];
> +
> +		pix_mp->plane_fmt[i].bytesperline =3D bpl;
> +		if (pix_mp->plane_fmt[i].sizeimage < si)
> +			pix_mp->plane_fmt[i].sizeimage =3D si;
> +		memset(pix_mp->plane_fmt[i].reserved, 0,
> +		       sizeof(pix_mp->plane_fmt[i].reserved));
> +		mdp_dbg(2, "[%d] p%u, bpl:%u (%u), sizeimage:%u (%u)", ctx_id,
> +			i, bpl, min_bpl, pix_mp->plane_fmt[i].sizeimage, si);
> +	}
> +
> +	return fmt;
> +}
> +
> +static int mdp_clamp_start(s32 *x, int min, int max, unsigned int align,
> +			   u32 flags)
> +{
> +	if (flags & V4L2_SEL_FLAG_GE)
> +		max =3D *x;
> +	if (flags & V4L2_SEL_FLAG_LE)
> +		min =3D *x;
> +	return mdp_clamp_align(x, min, max, align);
> +}
> +
> +static int mdp_clamp_end(s32 *x, int min, int max, unsigned int align,
> +			 u32 flags)
> +{
> +	if (flags & V4L2_SEL_FLAG_GE)
> +		min =3D *x;
> +	if (flags & V4L2_SEL_FLAG_LE)
> +		max =3D *x;
> +	return mdp_clamp_align(x, min, max, align);
> +}
> +
> +int mdp_try_crop(struct v4l2_rect *r, const struct v4l2_selection *s,
> +		 struct mdp_frame *frame, u32 ctx_id)
> +{
> +	s32 left, top, right, bottom;
> +	u32 framew, frameh, walign, halign;
> +	int ret;
> +
> +	mdp_dbg(2, "[%d] target:%d, set:(%d,%d) %ux%u", ctx_id, s->target,
> +		s->r.left, s->r.top, s->r.width, s->r.height);
> +
> +	left =3D s->r.left;
> +	top =3D s->r.top;
> +	right =3D s->r.left + s->r.width;
> +	bottom =3D s->r.top + s->r.height;
> +	framew =3D frame->format.fmt.pix_mp.width;
> +	frameh =3D frame->format.fmt.pix_mp.height;
> +
> +	if (mdp_target_is_crop(s->target)) {
> +		walign =3D 1;
> +		halign =3D 1;
> +	} else {
> +		walign =3D frame->mdp_fmt->walign;
> +		halign =3D frame->mdp_fmt->halign;
> +	}
> +
> +	mdp_dbg(2, "[%d] align:%u,%u, bound:%ux%u", ctx_id,
> +		walign, halign, framew, frameh);
> +
> +	ret =3D mdp_clamp_start(&left, 0, right, walign, s->flags);
> +	if (ret)
> +		return ret;
> +	ret =3D mdp_clamp_start(&top, 0, bottom, halign, s->flags);
> +	if (ret)
> +		return ret;
> +	ret =3D mdp_clamp_end(&right, left, framew, walign, s->flags);
> +	if (ret)
> +		return ret;
> +	ret =3D mdp_clamp_end(&bottom, top, frameh, halign, s->flags);
> +	if (ret)
> +		return ret;
> +
> +	r->left =3D left;
> +	r->top =3D top;
> +	r->width =3D right - left;
> +	r->height =3D bottom - top;
> +
> +	mdp_dbg(2, "[%d] crop:(%d,%d) %ux%u", ctx_id,
> +		r->left, r->top, r->width, r->height);
> +	return 0;
> +}
> +
> +int mdp_check_scaling_ratio(const struct v4l2_rect *crop,
> +			    const struct v4l2_rect *compose, s32 rotation,
> +	const struct mdp_limit *limit)
> +{
> +	u32 crop_w, crop_h, comp_w, comp_h;
> +
> +	crop_w =3D crop->width;
> +	crop_h =3D crop->height;
> +	if (90 =3D=3D rotation || 270 =3D=3D rotation) {
> +		comp_w =3D compose->height;
> +		comp_h =3D compose->width;
> +	} else {
> +		comp_w =3D compose->width;
> +		comp_h =3D compose->height;
> +	}
> +
> +	if ((crop_w / comp_w) > limit->h_scale_down_max ||
> +	    (crop_h / comp_h) > limit->v_scale_down_max ||
> +	    (comp_w / crop_w) > limit->h_scale_up_max ||
> +	    (comp_h / crop_h) > limit->v_scale_up_max)
> +		return -ERANGE;
> +	return 0;
> +}
> +
> +/* Stride that is accepted by MDP HW */
> +static u32 mdp_fmt_get_stride(const struct mdp_format *fmt,
> +			      u32 bytesperline, unsigned int plane)
> +{
> +	enum mdp_color c =3D fmt->mdp_color;
> +	u32 stride;
> +
> +	stride =3D (bytesperline * MDP_COLOR_BITS_PER_PIXEL(c))
> +		/ fmt->row_depth[0];
> +	if (plane =3D=3D 0)
> +		return stride;
> +	if (plane < MDP_COLOR_GET_PLANE_COUNT(c)) {
> +		if (MDP_COLOR_IS_BLOCK_MODE(c))
> +			stride =3D stride / 2;
> +		return stride;
> +	}
> +	return 0;
> +}
> +
> +/* Stride that is accepted by MDP HW of format with contiguous planes */
> +static u32 mdp_fmt_get_stride_contig(const struct mdp_format *fmt,
> +				     u32 pix_stride, unsigned int plane)
> +{
> +	enum mdp_color c =3D fmt->mdp_color;
> +	u32 stride =3D pix_stride;
> +
> +	if (plane =3D=3D 0)
> +		return stride;
> +	if (plane < MDP_COLOR_GET_PLANE_COUNT(c)) {
> +		stride =3D stride >> MDP_COLOR_GET_H_SUBSAMPLE(c);
> +		if (MDP_COLOR_IS_UV_COPLANE(c) && !MDP_COLOR_IS_BLOCK_MODE(c))
> +			stride =3D stride * 2;
> +		return stride;
> +	}
> +	return 0;
> +}
> +
> +/* Plane size that is accepted by MDP HW */
> +static u32 mdp_fmt_get_plane_size(const struct mdp_format *fmt,
> +				  u32 stride, u32 height, unsigned int plane)
> +{
> +	enum mdp_color c =3D fmt->mdp_color;
> +	u32 bytesperline;
> +
> +	bytesperline =3D (stride * fmt->row_depth[0])
> +		/ MDP_COLOR_BITS_PER_PIXEL(c);
> +	if (plane =3D=3D 0)
> +		return bytesperline * height;
> +	if (plane < MDP_COLOR_GET_PLANE_COUNT(c)) {
> +		height =3D height >> MDP_COLOR_GET_V_SUBSAMPLE(c);
> +		if (MDP_COLOR_IS_BLOCK_MODE(c))
> +			bytesperline =3D bytesperline * 2;
> +		return bytesperline * height;
> +	}
> +	return 0;
> +}
> +
> +static void mdp_prepare_buffer(struct img_image_buffer *b,
> +			       struct mdp_frame *frame, struct vb2_buffer *vb)
> +{
> +	struct v4l2_pix_format_mplane *pix_mp =3D &frame->format.fmt.pix_mp;
> +	unsigned int i;
> +
> +	b->format.colorformat =3D frame->mdp_fmt->mdp_color;
> +	b->format.ycbcr_prof =3D frame->ycbcr_prof;
> +	for (i =3D 0; i < pix_mp->num_planes; ++i) {
> +		u32 stride =3D mdp_fmt_get_stride(frame->mdp_fmt,
> +			pix_mp->plane_fmt[i].bytesperline, i);
> +
> +		b->format.plane_fmt[i].stride =3D stride;
> +		/*
> +		 * TODO(crbug.com/901264): The way to pass an offset within a
> +		 * DMA-buf is not defined in V4L2 specification, so we abuse
> +		 * data_offset for now. Fix it when we have the right interface,
> +		 * including any necessary validation and potential alignment
> +		 * issues.
> +		 */
> +		b->format.plane_fmt[i].size =3D
> +			mdp_fmt_get_plane_size(frame->mdp_fmt, stride,
> +					       pix_mp->height, i) -
> +					       vb->planes[i].data_offset;
> +		b->iova[i] =3D vb2_dma_contig_plane_dma_addr(vb, i) +
> +			     vb->planes[i].data_offset;

As the comment says, data_offset is not valdiated at all for capture device=
s and
is only validated so that (length - data_offset > 0) for OUTPUT devices. So=
 this
is going out of spec and leave the door open for buffer overflow triggered =
by
users.
=20
> +	}
> +	for (; i < MDP_COLOR_GET_PLANE_COUNT(b->format.colorformat); ++i) {
> +		u32 stride =3D mdp_fmt_get_stride_contig(frame->mdp_fmt,
> +			b->format.plane_fmt[0].stride, i);
> +
> +		b->format.plane_fmt[i].stride =3D stride;
> +		b->format.plane_fmt[i].size =3D
> +			mdp_fmt_get_plane_size(frame->mdp_fmt, stride,
> +					       pix_mp->height, i);
> +		b->iova[i] =3D b->iova[i - 1] + b->format.plane_fmt[i - 1].size;
> +	}
> +	b->usage =3D frame->usage;
> +}
> +
> +void mdp_set_src_config(struct img_input *in,
> +			struct mdp_frame *frame, struct vb2_buffer *vb)
> +{
> +	in->buffer.format.width =3D frame->format.fmt.pix_mp.width;
> +	in->buffer.format.height =3D frame->format.fmt.pix_mp.height;
> +	mdp_prepare_buffer(&in->buffer, frame, vb);
> +
> +	/* in->flags |=3D ; */	/* HDR, DRE, dither */
> +}
> +
> +static u32 mdp_to_fixed(u32 *r, struct v4l2_fract *f)
> +{
> +	u32 q;
> +
> +	if (f->denominator =3D=3D 0) {
> +		*r =3D 0;
> +		return 0;
> +	}
> +
> +	q =3D f->numerator / f->denominator;
> +	*r =3D div_u64(((u64)f->numerator - q * f->denominator) <<
> +		     IMG_SUBPIXEL_SHIFT, f->denominator);
> +	return q;
> +}
> +
> +static void mdp_set_src_crop(struct img_crop *c, struct mdp_crop *crop)
> +{
> +	c->left =3D crop->c.left
> +		+ mdp_to_fixed(&c->left_subpix, &crop->left_subpix);
> +	c->top =3D crop->c.top
> +		+ mdp_to_fixed(&c->top_subpix, &crop->top_subpix);
> +	c->width =3D crop->c.width
> +		+ mdp_to_fixed(&c->width_subpix, &crop->width_subpix);
> +	c->height =3D crop->c.height
> +		+ mdp_to_fixed(&c->height_subpix, &crop->height_subpix);
> +}
> +
> +static void mdp_set_orientation(struct img_output *out,
> +				s32 rotation, bool hflip, bool vflip)
> +{
> +	u8 flip =3D 0;
> +
> +	if (hflip)
> +		flip ^=3D 1;
> +	if (vflip) {
> +		/*
> +		 * A vertical flip is equivalent to
> +		 * a 180-degree rotation with a horizontal flip
> +		 */
> +		rotation +=3D 180;
> +		flip ^=3D 1;
> +	}
> +
> +	out->rotation =3D rotation % 360;
> +	if (flip !=3D 0)
> +		out->flags |=3D IMG_CTRL_FLAG_HFLIP;
> +	else
> +		out->flags &=3D ~IMG_CTRL_FLAG_HFLIP;
> +}
> +
> +void mdp_set_dst_config(struct img_output *out,
> +			struct mdp_frame *frame, struct vb2_buffer *vb)
> +{
> +	out->buffer.format.width =3D frame->compose.width;
> +	out->buffer.format.height =3D frame->compose.height;
> +	mdp_prepare_buffer(&out->buffer, frame, vb);
> +	mdp_set_src_crop(&out->crop, &frame->crop);
> +	mdp_set_orientation(out, frame->rotation, frame->hflip, frame->vflip);
> +
> +	/* out->flags |=3D ; */	/* sharpness, dither */
> +}
> +
> +int mdp_frameparam_init(struct mdp_frameparam *param)
> +{
> +	struct mdp_frame *frame;
> +
> +	if (!param)
> +		return -EINVAL;
> +
> +	INIT_LIST_HEAD(&param->list);
> +	mutex_init(&param->state_lock);
> +	param->limit =3D &mdp_def_limit;
> +	param->type =3D MDP_STREAM_TYPE_BITBLT;
> +
> +	frame =3D &param->output;
> +	frame->format.type =3D V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE;
> +	frame->mdp_fmt =3D mdp_try_fmt_mplane(&frame->format, param, 0);
> +	frame->ycbcr_prof =3D
> +		mdp_map_ycbcr_prof_mplane(&frame->format,
> +					  frame->mdp_fmt->mdp_color);
> +	frame->usage =3D MDP_BUFFER_USAGE_HW_READ;
> +
> +	param->num_captures =3D 1;
> +	frame =3D &param->captures[0];
> +	frame->format.type =3D V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE;
> +	frame->mdp_fmt =3D mdp_try_fmt_mplane(&frame->format, param, 0);
> +	frame->ycbcr_prof =3D
> +		mdp_map_ycbcr_prof_mplane(&frame->format,
> +					  frame->mdp_fmt->mdp_color);
> +	frame->usage =3D MDP_BUFFER_USAGE_MDP;
> +	frame->crop.c.width =3D param->output.format.fmt.pix_mp.width;
> +	frame->crop.c.height =3D param->output.format.fmt.pix_mp.height;
> +	frame->compose.width =3D frame->format.fmt.pix_mp.width;
> +	frame->compose.height =3D frame->format.fmt.pix_mp.height;
> +
> +	return 0;
> +}
> +
> diff --git a/drivers/media/platform/mtk-mdp3/mtk-mdp3-regs.h b/drivers/me=
dia/platform/mtk-mdp3/mtk-mdp3-regs.h
> new file mode 100644
> index 000000000000..b41c419afb10
> --- /dev/null
> +++ b/drivers/media/platform/mtk-mdp3/mtk-mdp3-regs.h
> @@ -0,0 +1,373 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2018 MediaTek Inc.
> + * Author: Ping-Hsun Wu <ping-hsun.wu@mediatek.com>
> + */
> +
> +#ifndef __MTK_MDP3_REGS_H__
> +#define __MTK_MDP3_REGS_H__
> +
> +#include <linux/videodev2.h>
> +#include <media/videobuf2-core.h>
> +#include "mtk-img-ipi.h"
> +
> +/*
> + * MDP native color code
> + * Plane count: 1, 2, 3
> + * H-subsample: 0, 1, 2
> + * V-subsample: 0, 1
> + * Color group: 0-RGB, 1-YUV, 2-raw
> + */
> +#define MDP_COLOR(PACKED, LOOSE, VIDEO, PLANE, HF, VF, BITS, GROUP, SWAP=
, ID)\
> +	(((PACKED) << 27) | ((LOOSE) << 26) | ((VIDEO) << 23) |\
> +	 ((PLANE) << 21) | ((HF) << 19) | ((VF) << 18) | ((BITS) << 8) |\
> +	 ((GROUP) << 6) | ((SWAP) << 5) | ((ID) << 0))
> +
> +#define MDP_COLOR_IS_10BIT_PACKED(c)    ((0x08000000 & (c)) >> 27)
> +#define MDP_COLOR_IS_10BIT_LOOSE(c)    (((0x0c000000 & (c)) >> 26) =3D=
=3D 1)
> +#define MDP_COLOR_IS_10BIT_TILE(c)     (((0x0c000000 & (c)) >> 26) =3D=
=3D 3)
> +#define MDP_COLOR_IS_UFP(c)             ((0x02000000 & (c)) >> 25)
> +#define MDP_COLOR_IS_INTERLACED(c)      ((0x01000000 & (c)) >> 24)
> +#define MDP_COLOR_IS_BLOCK_MODE(c)      ((0x00800000 & (c)) >> 23)
> +#define MDP_COLOR_GET_PLANE_COUNT(c)    ((0x00600000 & (c)) >> 21)
> +#define MDP_COLOR_GET_H_SUBSAMPLE(c)    ((0x00180000 & (c)) >> 19)
> +#define MDP_COLOR_GET_V_SUBSAMPLE(c)    ((0x00040000 & (c)) >> 18)
> +#define MDP_COLOR_BITS_PER_PIXEL(c)     ((0x0003ff00 & (c)) >>  8)
> +#define MDP_COLOR_GET_GROUP(c)          ((0x000000c0 & (c)) >>  6)
> +#define MDP_COLOR_IS_SWAPPED(c)         ((0x00000020 & (c)) >>  5)
> +#define MDP_COLOR_GET_UNIQUE_ID(c)      ((0x0000001f & (c)) >>  0)
> +#define MDP_COLOR_GET_HW_FORMAT(c)      ((0x0000001f & (c)) >>  0)
> +
> +#define MDP_COLOR_IS_RGB(c)		(MDP_COLOR_GET_GROUP(c) =3D=3D 0)
> +#define MDP_COLOR_IS_YUV(c)		(MDP_COLOR_GET_GROUP(c) =3D=3D 1)
> +#define MDP_COLOR_IS_UV_COPLANE(c)	((MDP_COLOR_GET_PLANE_COUNT(c) =3D=3D=
 2) &&\
> +					 MDP_COLOR_IS_YUV(c))
> +
> +enum mdp_color {
> +	MDP_COLOR_UNKNOWN	=3D 0,
> +
> +	//MDP_COLOR_FULLG8,
> +	MDP_COLOR_FULLG8_RGGB	=3D MDP_COLOR(0, 0, 0, 1, 0, 0,  8, 2,  0, 21),
> +	MDP_COLOR_FULLG8_GRBG	=3D MDP_COLOR(0, 0, 0, 1, 0, 1,  8, 2,  0, 21),
> +	MDP_COLOR_FULLG8_GBRG	=3D MDP_COLOR(0, 0, 0, 1, 1, 0,  8, 2,  0, 21),
> +	MDP_COLOR_FULLG8_BGGR	=3D MDP_COLOR(0, 0, 0, 1, 1, 1,  8, 2,  0, 21),
> +	MDP_COLOR_FULLG8	=3D MDP_COLOR_FULLG8_BGGR,
> +
> +	//MDP_COLOR_FULLG10,
> +	MDP_COLOR_FULLG10_RGGB	=3D MDP_COLOR(0, 0, 0, 1, 0, 0, 10, 2,  0, 21),
> +	MDP_COLOR_FULLG10_GRBG	=3D MDP_COLOR(0, 0, 0, 1, 0, 1, 10, 2,  0, 21),
> +	MDP_COLOR_FULLG10_GBRG	=3D MDP_COLOR(0, 0, 0, 1, 1, 0, 10, 2,  0, 21),
> +	MDP_COLOR_FULLG10_BGGR	=3D MDP_COLOR(0, 0, 0, 1, 1, 1, 10, 2,  0, 21),
> +	MDP_COLOR_FULLG10	=3D MDP_COLOR_FULLG10_BGGR,
> +
> +	//MDP_COLOR_FULLG12,
> +	MDP_COLOR_FULLG12_RGGB	=3D MDP_COLOR(0, 0, 0, 1, 0, 0, 12, 2,  0, 21),
> +	MDP_COLOR_FULLG12_GRBG	=3D MDP_COLOR(0, 0, 0, 1, 0, 1, 12, 2,  0, 21),
> +	MDP_COLOR_FULLG12_GBRG	=3D MDP_COLOR(0, 0, 0, 1, 1, 0, 12, 2,  0, 21),
> +	MDP_COLOR_FULLG12_BGGR	=3D MDP_COLOR(0, 0, 0, 1, 1, 1, 12, 2,  0, 21),
> +	MDP_COLOR_FULLG12	=3D MDP_COLOR_FULLG12_BGGR,
> +
> +	//MDP_COLOR_FULLG14,
> +	MDP_COLOR_FULLG14_RGGB	=3D MDP_COLOR(0, 0, 0, 1, 0, 0, 14, 2,  0, 21),
> +	MDP_COLOR_FULLG14_GRBG	=3D MDP_COLOR(0, 0, 0, 1, 0, 1, 14, 2,  0, 21),
> +	MDP_COLOR_FULLG14_GBRG	=3D MDP_COLOR(0, 0, 0, 1, 1, 0, 14, 2,  0, 21),
> +	MDP_COLOR_FULLG14_BGGR	=3D MDP_COLOR(0, 0, 0, 1, 1, 1, 14, 2,  0, 21),
> +	MDP_COLOR_FULLG14	=3D MDP_COLOR_FULLG14_BGGR,
> +
> +	MDP_COLOR_UFO10		=3D MDP_COLOR(0, 0, 0, 1, 0, 0, 10, 2,  0, 24),
> +
> +	//MDP_COLOR_BAYER8,
> +	MDP_COLOR_BAYER8_RGGB	=3D MDP_COLOR(0, 0, 0, 1, 0, 0,  8, 2,  0, 20),
> +	MDP_COLOR_BAYER8_GRBG	=3D MDP_COLOR(0, 0, 0, 1, 0, 1,  8, 2,  0, 20),
> +	MDP_COLOR_BAYER8_GBRG	=3D MDP_COLOR(0, 0, 0, 1, 1, 0,  8, 2,  0, 20),
> +	MDP_COLOR_BAYER8_BGGR	=3D MDP_COLOR(0, 0, 0, 1, 1, 1,  8, 2,  0, 20),
> +	MDP_COLOR_BAYER8	=3D MDP_COLOR_BAYER8_BGGR,
> +
> +	//MDP_COLOR_BAYER10,
> +	MDP_COLOR_BAYER10_RGGB	=3D MDP_COLOR(0, 0, 0, 1, 0, 0, 10, 2,  0, 20),
> +	MDP_COLOR_BAYER10_GRBG	=3D MDP_COLOR(0, 0, 0, 1, 0, 1, 10, 2,  0, 20),
> +	MDP_COLOR_BAYER10_GBRG	=3D MDP_COLOR(0, 0, 0, 1, 1, 0, 10, 2,  0, 20),
> +	MDP_COLOR_BAYER10_BGGR	=3D MDP_COLOR(0, 0, 0, 1, 1, 1, 10, 2,  0, 20),
> +	MDP_COLOR_BAYER10	=3D MDP_COLOR_BAYER10_BGGR,
> +
> +	//MDP_COLOR_BAYER12,
> +	MDP_COLOR_BAYER12_RGGB	=3D MDP_COLOR(0, 0, 0, 1, 0, 0, 12, 2,  0, 20),
> +	MDP_COLOR_BAYER12_GRBG	=3D MDP_COLOR(0, 0, 0, 1, 0, 1, 12, 2,  0, 20),
> +	MDP_COLOR_BAYER12_GBRG	=3D MDP_COLOR(0, 0, 0, 1, 1, 0, 12, 2,  0, 20),
> +	MDP_COLOR_BAYER12_BGGR	=3D MDP_COLOR(0, 0, 0, 1, 1, 1, 12, 2,  0, 20),
> +	MDP_COLOR_BAYER12	=3D MDP_COLOR_BAYER12_BGGR,
> +
> +	//MDP_COLOR_BAYER14,
> +	MDP_COLOR_BAYER14_RGGB	=3D MDP_COLOR(0, 0, 0, 1, 0, 0, 14, 2,  0, 20),
> +	MDP_COLOR_BAYER14_GRBG	=3D MDP_COLOR(0, 0, 0, 1, 0, 1, 14, 2,  0, 20),
> +	MDP_COLOR_BAYER14_GBRG	=3D MDP_COLOR(0, 0, 0, 1, 1, 0, 14, 2,  0, 20),
> +	MDP_COLOR_BAYER14_BGGR	=3D MDP_COLOR(0, 0, 0, 1, 1, 1, 14, 2,  0, 20),
> +	MDP_COLOR_BAYER14	=3D MDP_COLOR_BAYER14_BGGR,
> +
> +	MDP_COLOR_RGB48		=3D MDP_COLOR(0, 0, 0, 1, 0, 0, 48, 0,  0, 23),
> +	/* For bayer+mono raw-16 */
> +	MDP_COLOR_RGB565_RAW	=3D MDP_COLOR(0, 0, 0, 1, 0, 0, 16, 2,  0, 0),
> +
> +	MDP_COLOR_BAYER8_UNPAK	=3D MDP_COLOR(0, 0, 0, 1, 0, 0,  8, 2,  0, 22),
> +	MDP_COLOR_BAYER10_UNPAK	=3D MDP_COLOR(0, 0, 0, 1, 0, 0, 10, 2,  0, 22),
> +	MDP_COLOR_BAYER12_UNPAK	=3D MDP_COLOR(0, 0, 0, 1, 0, 0, 12, 2,  0, 22),
> +	MDP_COLOR_BAYER14_UNPAK	=3D MDP_COLOR(0, 0, 0, 1, 0, 0, 14, 2,  0, 22),
> +
> +	/* Unified formats */
> +	MDP_COLOR_GREY		=3D MDP_COLOR(0, 0, 0, 1, 0, 0,  8, 1,  0, 7),
> +
> +	MDP_COLOR_RGB565	=3D MDP_COLOR(0, 0, 0, 1, 0, 0, 16, 0,  0, 0),
> +	MDP_COLOR_BGR565	=3D MDP_COLOR(0, 0, 0, 1, 0, 0, 16, 0,  1, 0),
> +	MDP_COLOR_RGB888	=3D MDP_COLOR(0, 0, 0, 1, 0, 0, 24, 0,  1, 1),
> +	MDP_COLOR_BGR888	=3D MDP_COLOR(0, 0, 0, 1, 0, 0, 24, 0,  0, 1),
> +	MDP_COLOR_RGBA8888	=3D MDP_COLOR(0, 0, 0, 1, 0, 0, 32, 0,  1, 2),
> +	MDP_COLOR_BGRA8888	=3D MDP_COLOR(0, 0, 0, 1, 0, 0, 32, 0,  0, 2),
> +	MDP_COLOR_ARGB8888	=3D MDP_COLOR(0, 0, 0, 1, 0, 0, 32, 0,  1, 3),
> +	MDP_COLOR_ABGR8888	=3D MDP_COLOR(0, 0, 0, 1, 0, 0, 32, 0,  0, 3),
> +
> +	MDP_COLOR_UYVY		=3D MDP_COLOR(0, 0, 0, 1, 1, 0, 16, 1,  0, 4),
> +	MDP_COLOR_VYUY		=3D MDP_COLOR(0, 0, 0, 1, 1, 0, 16, 1,  1, 4),
> +	MDP_COLOR_YUYV		=3D MDP_COLOR(0, 0, 0, 1, 1, 0, 16, 1,  0, 5),
> +	MDP_COLOR_YVYU		=3D MDP_COLOR(0, 0, 0, 1, 1, 0, 16, 1,  1, 5),
> +
> +	MDP_COLOR_I420		=3D MDP_COLOR(0, 0, 0, 3, 1, 1,  8, 1,  0, 8),
> +	MDP_COLOR_YV12		=3D MDP_COLOR(0, 0, 0, 3, 1, 1,  8, 1,  1, 8),
> +	MDP_COLOR_I422		=3D MDP_COLOR(0, 0, 0, 3, 1, 0,  8, 1,  0, 9),
> +	MDP_COLOR_YV16		=3D MDP_COLOR(0, 0, 0, 3, 1, 0,  8, 1,  1, 9),
> +	MDP_COLOR_I444		=3D MDP_COLOR(0, 0, 0, 3, 0, 0,  8, 1,  0, 10),
> +	MDP_COLOR_YV24		=3D MDP_COLOR(0, 0, 0, 3, 0, 0,  8, 1,  1, 10),
> +
> +	MDP_COLOR_NV12		=3D MDP_COLOR(0, 0, 0, 2, 1, 1,  8, 1,  0, 12),
> +	MDP_COLOR_NV21		=3D MDP_COLOR(0, 0, 0, 2, 1, 1,  8, 1,  1, 12),
> +	MDP_COLOR_NV16		=3D MDP_COLOR(0, 0, 0, 2, 1, 0,  8, 1,  0, 13),
> +	MDP_COLOR_NV61		=3D MDP_COLOR(0, 0, 0, 2, 1, 0,  8, 1,  1, 13),
> +	MDP_COLOR_NV24		=3D MDP_COLOR(0, 0, 0, 2, 0, 0,  8, 1,  0, 14),
> +	MDP_COLOR_NV42		=3D MDP_COLOR(0, 0, 0, 2, 0, 0,  8, 1,  1, 14),
> +
> +	/* Mediatek proprietary formats */
> +	/* UFO encoded block mode */
> +	MDP_COLOR_420_BLK_UFO	=3D MDP_COLOR(0, 0, 5, 2, 1, 1, 256, 1, 0, 12),
> +	/* Block mode */
> +	MDP_COLOR_420_BLK	=3D MDP_COLOR(0, 0, 1, 2, 1, 1, 256, 1, 0, 12),
> +	/* Block mode + field mode */
> +	MDP_COLOR_420_BLKI	=3D MDP_COLOR(0, 0, 3, 2, 1, 1, 256, 1, 0, 12),
> +	/* Block mode */
> +	MDP_COLOR_422_BLK	=3D MDP_COLOR(0, 0, 1, 1, 1, 0, 512, 1, 0, 4),
> +
> +	MDP_COLOR_IYU2		=3D MDP_COLOR(0, 0, 0, 1, 0, 0, 24,  1, 0, 25),
> +	MDP_COLOR_YUV444	=3D MDP_COLOR(0, 0, 0, 1, 0, 0, 24,  1, 0, 30),
> +
> +	/* Packed 10-bit formats */
> +	MDP_COLOR_RGBA1010102	=3D MDP_COLOR(1, 0, 0, 1, 0, 0, 32,  0, 1, 2),
> +	MDP_COLOR_BGRA1010102	=3D MDP_COLOR(1, 0, 0, 1, 0, 0, 32,  0, 0, 2),
> +	/* Packed 10-bit UYVY */
> +	MDP_COLOR_UYVY_10P	=3D MDP_COLOR(1, 0, 0, 1, 1, 0, 20,  1, 0, 4),
> +	/* Packed 10-bit NV21 */
> +	MDP_COLOR_NV21_10P	=3D MDP_COLOR(1, 0, 0, 2, 1, 1, 10,  1, 1, 12),
> +	/* 10-bit block mode */
> +	MDP_COLOR_420_BLK_10_H	=3D MDP_COLOR(1, 0, 1, 2, 1, 1, 320, 1, 0, 12),
> +	/* 10-bit HEVC tile mode */
> +	MDP_COLOR_420_BLK_10_V	=3D MDP_COLOR(1, 1, 1, 2, 1, 1, 320, 1, 0, 12),
> +	/* UFO encoded 10-bit block mode */
> +	MDP_COLOR_420_BLK_U10_H	=3D MDP_COLOR(1, 0, 5, 2, 1, 1, 320, 1, 0, 12),
> +	/* UFO encoded 10-bit HEVC tile mode */
> +	MDP_COLOR_420_BLK_U10_V	=3D MDP_COLOR(1, 1, 5, 2, 1, 1, 320, 1, 0, 12),
> +
> +	/* Loose 10-bit formats */
> +	MDP_COLOR_UYVY_10L	=3D MDP_COLOR(0, 1, 0, 1, 1, 0, 20,  1, 0, 4),
> +	MDP_COLOR_VYUY_10L	=3D MDP_COLOR(0, 1, 0, 1, 1, 0, 20,  1, 1, 4),
> +	MDP_COLOR_YUYV_10L	=3D MDP_COLOR(0, 1, 0, 1, 1, 0, 20,  1, 0, 5),
> +	MDP_COLOR_YVYU_10L	=3D MDP_COLOR(0, 1, 0, 1, 1, 0, 20,  1, 1, 5),
> +	MDP_COLOR_NV12_10L	=3D MDP_COLOR(0, 1, 0, 2, 1, 1, 10,  1, 0, 12),
> +	MDP_COLOR_NV21_10L	=3D MDP_COLOR(0, 1, 0, 2, 1, 1, 10,  1, 1, 12),
> +	MDP_COLOR_NV16_10L	=3D MDP_COLOR(0, 1, 0, 2, 1, 0, 10,  1, 0, 13),
> +	MDP_COLOR_NV61_10L	=3D MDP_COLOR(0, 1, 0, 2, 1, 0, 10,  1, 1, 13),
> +	MDP_COLOR_YV12_10L	=3D MDP_COLOR(0, 1, 0, 3, 1, 1, 10,  1, 1, 8),
> +	MDP_COLOR_I420_10L	=3D MDP_COLOR(0, 1, 0, 3, 1, 1, 10,  1, 0, 8),
> +};
> +
> +/* Minimum Y stride that is accepted by MDP HW */
> +static inline u32 mdp_color_get_min_y_stride(enum mdp_color c, u32 width=
)
> +{
> +	return ((MDP_COLOR_BITS_PER_PIXEL(c) * width) + 4) >> 3;
> +}
> +
> +/* Minimum UV stride that is accepted by MDP HW */
> +static inline u32 mdp_color_get_min_uv_stride(enum mdp_color c, u32 widt=
h)
> +{
> +	u32 min_stride;
> +
> +	if (MDP_COLOR_GET_PLANE_COUNT(c) =3D=3D 1)
> +		return 0;
> +	min_stride =3D mdp_color_get_min_y_stride(c, width)
> +		>> MDP_COLOR_GET_H_SUBSAMPLE(c);
> +	if (MDP_COLOR_IS_UV_COPLANE(c) && !MDP_COLOR_IS_BLOCK_MODE(c))
> +		min_stride =3D min_stride * 2;
> +	return min_stride;
> +}
> +
> +/* Minimum Y plane size that is necessary in buffer */
> +static inline u32 mdp_color_get_min_y_size(enum mdp_color c,
> +					   u32 width, u32 height)
> +{
> +	if (MDP_COLOR_IS_BLOCK_MODE(c))
> +		return ((MDP_COLOR_BITS_PER_PIXEL(c) * width) >> 8) * height;
> +	return mdp_color_get_min_y_stride(c, width) * height;
> +}
> +
> +/* Minimum UV plane size that is necessary in buffer */
> +static inline u32 mdp_color_get_min_uv_size(enum mdp_color c,
> +					    u32 width, u32 height)
> +{
> +	height =3D height >> MDP_COLOR_GET_V_SUBSAMPLE(c);
> +	if (MDP_COLOR_IS_BLOCK_MODE(c) && (MDP_COLOR_GET_PLANE_COUNT(c) > 1))
> +		return ((MDP_COLOR_BITS_PER_PIXEL(c) * width) >> 8) * height;
> +	return mdp_color_get_min_uv_stride(c, width) * height;
> +}
> +
> +/* Combine colorspace, xfer_func, ycbcr_encoding, and quantization */
> +enum mdp_ycbcr_profile {
> +	/* V4L2_YCBCR_ENC_601 and V4L2_QUANTIZATION_LIM_RANGE */
> +	MDP_YCBCR_PROFILE_BT601,
> +	/* V4L2_YCBCR_ENC_709 and V4L2_QUANTIZATION_LIM_RANGE */
> +	MDP_YCBCR_PROFILE_BT709,
> +	/* V4L2_YCBCR_ENC_601 and V4L2_QUANTIZATION_FULL_RANGE */
> +	MDP_YCBCR_PROFILE_JPEG,
> +	MDP_YCBCR_PROFILE_FULL_BT601 =3D MDP_YCBCR_PROFILE_JPEG,
> +
> +	/* Colorspaces not support for capture */
> +	/* V4L2_YCBCR_ENC_BT2020 and V4L2_QUANTIZATION_LIM_RANGE */
> +	MDP_YCBCR_PROFILE_BT2020,
> +	/* V4L2_YCBCR_ENC_709 and V4L2_QUANTIZATION_FULL_RANGE */
> +	MDP_YCBCR_PROFILE_FULL_BT709,
> +	/* V4L2_YCBCR_ENC_BT2020 and V4L2_QUANTIZATION_FULL_RANGE */
> +	MDP_YCBCR_PROFILE_FULL_BT2020,
> +};
> +
> +#define MDP_FMT_FLAG_OUTPUT	BIT(0)
> +#define MDP_FMT_FLAG_CAPTURE	BIT(1)
> +
> +struct mdp_format {
> +	u32	pixelformat;
> +	u32	mdp_color;
> +	u8	depth[VIDEO_MAX_PLANES];
> +	u8	row_depth[VIDEO_MAX_PLANES];
> +	u8	num_planes;
> +	u8	walign;
> +	u8	halign;
> +	u8	salign;
> +	u32	flags;
> +};
> +
> +struct mdp_pix_limit {
> +	u32	wmin;
> +	u32	hmin;
> +	u32	wmax;
> +	u32	hmax;
> +};
> +
> +struct mdp_limit {
> +	struct mdp_pix_limit	out_limit;
> +	struct mdp_pix_limit	cap_limit;
> +	u32			h_scale_up_max;
> +	u32			v_scale_up_max;
> +	u32			h_scale_down_max;
> +	u32			v_scale_down_max;
> +};
> +
> +enum mdp_stream_type {
> +	MDP_STREAM_TYPE_UNKNOWN,
> +	MDP_STREAM_TYPE_BITBLT,
> +	MDP_STREAM_TYPE_GPU_BITBLT,
> +	MDP_STREAM_TYPE_DUAL_BITBLT,
> +	MDP_STREAM_TYPE_2ND_BITBLT,
> +	MDP_STREAM_TYPE_ISP_IC,
> +	MDP_STREAM_TYPE_ISP_VR,
> +	MDP_STREAM_TYPE_ISP_ZSD,
> +	MDP_STREAM_TYPE_ISP_IP,
> +	MDP_STREAM_TYPE_ISP_VSS,
> +	MDP_STREAM_TYPE_ISP_ZSD_SLOW,
> +	MDP_STREAM_TYPE_WPE,
> +	MDP_STREAM_TYPE_WPE2,
> +};
> +
> +struct mdp_crop {
> +	struct v4l2_rect	c;
> +	struct v4l2_fract	left_subpix;
> +	struct v4l2_fract	top_subpix;
> +	struct v4l2_fract	width_subpix;
> +	struct v4l2_fract	height_subpix;
> +};
> +
> +struct mdp_frame {
> +	struct v4l2_format	format;
> +	const struct mdp_format	*mdp_fmt;
> +	u32			ycbcr_prof;	/* enum mdp_ycbcr_profile */
> +	u32			usage;		/* enum mdp_buffer_usage */
> +	struct mdp_crop		crop;
> +	struct v4l2_rect	compose;
> +	s32			rotation;
> +	u32			hflip:1;
> +	u32			vflip:1;
> +	u32			hdr:1;
> +	u32			dre:1;
> +	u32			sharpness:1;
> +	u32			dither:1;
> +};
> +
> +static inline bool mdp_target_is_crop(u32 target)
> +{
> +	return (target =3D=3D V4L2_SEL_TGT_CROP) ||
> +		(target =3D=3D V4L2_SEL_TGT_CROP_DEFAULT) ||
> +		(target =3D=3D V4L2_SEL_TGT_CROP_BOUNDS);
> +}
> +
> +static inline bool mdp_target_is_compose(u32 target)
> +{
> +	return (target =3D=3D V4L2_SEL_TGT_COMPOSE) ||
> +		(target =3D=3D V4L2_SEL_TGT_COMPOSE_DEFAULT) ||
> +		(target =3D=3D V4L2_SEL_TGT_COMPOSE_BOUNDS);
> +}
> +
> +#define MDP_MAX_CAPTURES	IMG_MAX_HW_OUTPUTS
> +
> +#define MDP_VPU_INIT		BIT(0)
> +#define MDP_M2M_CTX_ERROR	BIT(1)
> +
> +struct mdp_frameparam {
> +	struct list_head	list;
> +	/* synchronization protect for m2m context state */
> +	struct mutex		state_lock;
> +	u32			state;
> +	const struct mdp_limit	*limit;
> +	u32			type;	/* enum mdp_stream_type */
> +	u32			frame_no;
> +	struct mdp_frame	output;
> +	struct mdp_frame	captures[MDP_MAX_CAPTURES];
> +	u32			num_captures;
> +	enum v4l2_colorspace		colorspace;
> +	enum v4l2_ycbcr_encoding	ycbcr_enc;
> +	enum v4l2_xfer_func		xfer_func;
> +	enum v4l2_quantization		quant;
> +};
> +
> +int mdp_enum_fmt_mplane(struct v4l2_fmtdesc *f);
> +const struct mdp_format *mdp_try_fmt_mplane(struct v4l2_format *f,
> +					    struct mdp_frameparam *param,
> +					    u32 ctx_id);
> +enum mdp_ycbcr_profile mdp_map_ycbcr_prof_mplane(struct v4l2_format *f,
> +						 u32 mdp_color);
> +int mdp_try_crop(struct v4l2_rect *r, const struct v4l2_selection *s,
> +		 struct mdp_frame *frame, u32 ctx_id);
> +int mdp_check_scaling_ratio(const struct v4l2_rect *crop,
> +			    const struct v4l2_rect *compose, s32 rotation,
> +	const struct mdp_limit *limit);
> +void mdp_set_src_config(struct img_input *in,
> +			struct mdp_frame *frame, struct vb2_buffer *vb);
> +void mdp_set_dst_config(struct img_output *out,
> +			struct mdp_frame *frame, struct vb2_buffer *vb);
> +
> +int mdp_frameparam_init(struct mdp_frameparam *param);
> +
> +#endif  /* __MTK_MDP3_REGS_H__ */
> +
> diff --git a/drivers/media/platform/mtk-mdp3/mtk-mdp3-vpu.c b/drivers/med=
ia/platform/mtk-mdp3/mtk-mdp3-vpu.c
> new file mode 100644
> index 000000000000..a1b2065aabbd
> --- /dev/null
> +++ b/drivers/media/platform/mtk-mdp3/mtk-mdp3-vpu.c
> @@ -0,0 +1,313 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2018 MediaTek Inc.
> + * Author: Ping-Hsun Wu <ping-hsun.wu@mediatek.com>
> + */
> +
> +#include <linux/remoteproc.h>
> +#include <linux/remoteproc/mtk_scp.h>
> +#include "mtk-mdp3-vpu.h"
> +#include "mtk-mdp3-core.h"
> +
> +#define MDP_VPU_MESSAGE_TIMEOUT 500U
> +#define vpu_alloc_size		0x600000
> +
> +static inline struct mdp_dev *vpu_to_mdp(struct mdp_vpu_dev *vpu)
> +{
> +	return container_of(vpu, struct mdp_dev, vpu);
> +}
> +
> +static int mdp_vpu_shared_mem_alloc(struct mdp_vpu_dev *vpu)
> +{
> +	if (vpu->work && vpu->work_addr)
> +		return 0;
> +
> +	vpu->work =3D dma_alloc_coherent(scp_get_device(vpu->scp), vpu_alloc_si=
ze,
> +				       &vpu->work_addr, GFP_KERNEL);
> +
> +	if (!vpu->work)
> +		return -ENOMEM;
> +	else
> +		return 0;
> +}
> +
> +void mdp_vpu_shared_mem_free(struct mdp_vpu_dev *vpu)
> +{
> +	if (vpu->work && vpu->work_addr)
> +		dma_free_coherent(scp_get_device(vpu->scp), vpu_alloc_size,
> +				  vpu->work, vpu->work_addr);
> +}
> +
> +static void mdp_vpu_ipi_handle_init_ack(void *data, unsigned int len,
> +					void *priv)
> +{
> +	struct mdp_ipi_init_msg *msg =3D (struct mdp_ipi_init_msg *)data;
> +	struct mdp_vpu_dev *vpu =3D
> +		(struct mdp_vpu_dev *)(unsigned long)msg->drv_data;
> +
> +	if (!vpu->work_size)
> +		vpu->work_size =3D msg->work_size;
> +
> +	vpu->status =3D msg->status;
> +	complete(&vpu->ipi_acked);
> +}
> +
> +static void mdp_vpu_ipi_handle_deinit_ack(void *data, unsigned int len,
> +					  void *priv)
> +{
> +	struct mdp_ipi_deinit_msg *msg =3D (struct mdp_ipi_deinit_msg *)data;
> +	struct mdp_vpu_dev *vpu =3D
> +		(struct mdp_vpu_dev *)(unsigned long)msg->drv_data;
> +
> +	vpu->status =3D msg->status;
> +	complete(&vpu->ipi_acked);
> +}
> +
> +static void mdp_vpu_ipi_handle_frame_ack(void *data, unsigned int len,
> +					 void *priv)
> +{
> +	struct img_sw_addr *addr =3D (struct img_sw_addr *)data;
> +	struct img_ipi_frameparam *param =3D
> +		(struct img_ipi_frameparam *)(unsigned long)addr->va;
> +	struct mdp_vpu_ctx *ctx =3D
> +		(struct mdp_vpu_ctx *)(unsigned long)param->drv_data;
> +
> +	if (param->state) {
> +		struct mdp_dev *mdp =3D vpu_to_mdp(ctx->vpu_dev);
> +
> +		dev_info(&mdp->pdev->dev, "VPU MDP failure:%d\n", param->state);
> +	}
> +	complete(&ctx->vpu_dev->ipi_acked);
> +}
> +
> +int mdp_vpu_register(struct mdp_dev *mdp)
> +{
> +	int err;
> +	struct mtk_scp *scp =3D mdp->scp;
> +	struct device *dev =3D &mdp->pdev->dev;
> +
> +	err =3D scp_ipi_register(scp, SCP_IPI_MDP_INIT,
> +			       mdp_vpu_ipi_handle_init_ack, NULL);
> +	if (err) {
> +		dev_err(dev, "scp_ipi_register failed %d\n", err);
> +		goto err_ipi_init;
> +	}
> +	err =3D scp_ipi_register(scp, SCP_IPI_MDP_DEINIT,
> +			       mdp_vpu_ipi_handle_deinit_ack, NULL);
> +	if (err) {
> +		dev_err(dev, "scp_ipi_register failed %d\n", err);
> +		goto err_ipi_deinit;
> +	}
> +	err =3D scp_ipi_register(scp, SCP_IPI_MDP_FRAME,
> +			       mdp_vpu_ipi_handle_frame_ack, NULL);
> +	if (err) {
> +		dev_err(dev, "scp_ipi_register failed %d\n", err);
> +		goto err_ipi_frame;
> +	}
> +	return 0;
> +
> +err_ipi_frame:
> +	scp_ipi_unregister(scp, SCP_IPI_MDP_DEINIT);
> +err_ipi_deinit:
> +	scp_ipi_unregister(scp, SCP_IPI_MDP_INIT);
> +err_ipi_init:
> +
> +	return err;
> +}
> +
> +void mdp_vpu_unregister(struct mdp_dev *mdp)
> +{
> +	scp_ipi_unregister(mdp->scp, SCP_IPI_MDP_INIT);
> +	scp_ipi_unregister(mdp->scp, SCP_IPI_MDP_DEINIT);
> +	scp_ipi_unregister(mdp->scp, SCP_IPI_MDP_FRAME);
> +}
> +
> +static int mdp_vpu_sendmsg(struct mdp_vpu_dev *vpu, enum scp_ipi_id id,
> +			   void *buf, unsigned int len)
> +{
> +	struct mdp_dev *mdp =3D vpu_to_mdp(vpu);
> +	int ret;
> +
> +	if (!vpu->scp) {
> +		dev_dbg(&mdp->pdev->dev, "vpu scp is NULL");
> +		return -EINVAL;
> +	}
> +	ret =3D scp_ipi_send(vpu->scp, id, buf, len, 2000);
> +
> +	if (ret) {
> +		dev_err(&mdp->pdev->dev, "scp_ipi_send failed %d\n", ret);
> +		return -EPERM;
> +	}
> +	ret =3D wait_for_completion_timeout(
> +		&vpu->ipi_acked, msecs_to_jiffies(MDP_VPU_MESSAGE_TIMEOUT));
> +	if (!ret)
> +		ret =3D -ETIME;
> +	else if (vpu->status)
> +		ret =3D -EINVAL;
> +	else
> +		ret =3D 0;
> +	return ret;
> +}
> +
> +int mdp_vpu_dev_init(struct mdp_vpu_dev *vpu, struct mtk_scp *scp,
> +		     struct mutex *lock)
> +{
> +	struct mdp_ipi_init_msg msg =3D {
> +		.drv_data =3D (unsigned long)vpu,
> +	};
> +	size_t mem_size;
> +	phys_addr_t pool;
> +	const size_t pool_size =3D sizeof(struct mdp_config_pool);
> +	struct mdp_dev *mdp =3D vpu_to_mdp(vpu);
> +	int err;
> +
> +	init_completion(&vpu->ipi_acked);
> +	vpu->scp =3D scp;
> +	vpu->lock =3D lock;
> +	vpu->work_size =3D 0;
> +	err =3D mdp_vpu_sendmsg(vpu, SCP_IPI_MDP_INIT, &msg, sizeof(msg));
> +	if (err)
> +		goto err_work_size;
> +	/* vpu work_size was set in mdp_vpu_ipi_handle_init_ack */
> +
> +	mem_size =3D vpu_alloc_size;
> +	if (mdp_vpu_shared_mem_alloc(vpu)) {
> +		dev_err(&mdp->pdev->dev, "VPU memory alloc fail!");
> +		goto err_mem_alloc;
> +	}
> +
> +	pool =3D ALIGN((phys_addr_t)vpu->work + vpu->work_size, 8);
> +	if (pool + pool_size - (phys_addr_t)vpu->work > mem_size) {
> +		dev_err(&mdp->pdev->dev,
> +			"VPU memory insufficient: %zx + %zx > %zx",
> +			vpu->work_size, pool_size, mem_size);
> +		err =3D -ENOMEM;
> +		goto err_mem_size;
> +	}
> +
> +	dev_dbg(&mdp->pdev->dev,
> +		"VPU work:%pK pa:%pad sz:%zx pool:%pa sz:%zx (mem sz:%zx)",
> +		vpu->work, &vpu->work_addr, vpu->work_size,
> +		&pool, pool_size, mem_size);
> +	vpu->pool =3D (struct mdp_config_pool *)pool;
> +	msg.work_addr =3D vpu->work_addr;
> +	msg.work_size =3D vpu->work_size;
> +	err =3D mdp_vpu_sendmsg(vpu, SCP_IPI_MDP_INIT, &msg, sizeof(msg));
> +	if (err)
> +		goto err_work_size;
> +
> +	memset(vpu->pool, 0, sizeof(*vpu->pool));
> +	return 0;
> +
> +err_work_size:
> +	switch (vpu->status) {
> +	case -MDP_IPI_EBUSY:
> +		err =3D -EBUSY;
> +		break;
> +	case -MDP_IPI_ENOMEM:
> +		err =3D -ENOSPC;	/* -ENOMEM */
> +		break;
> +	}
> +	return err;
> +err_mem_size:
> +err_mem_alloc:
> +	return err;
> +}
> +
> +int mdp_vpu_dev_deinit(struct mdp_vpu_dev *vpu)
> +{
> +	struct mdp_ipi_deinit_msg msg =3D {
> +		.drv_data =3D (unsigned long)vpu,
> +		.work_addr =3D vpu->work_addr,
> +	};
> +
> +	return mdp_vpu_sendmsg(vpu, SCP_IPI_MDP_DEINIT, &msg, sizeof(msg));
> +}
> +
> +static struct img_config *mdp_config_get(struct mdp_vpu_dev *vpu,
> +					 enum mdp_config_id id, uint32_t *addr)
> +{
> +	struct img_config *config;
> +
> +	if (id < 0 || id >=3D MDP_CONFIG_POOL_SIZE)
> +		return ERR_PTR(-EINVAL);
> +
> +	mutex_lock(vpu->lock);
> +	vpu->pool->cfg_count[id]++;
> +	config =3D &vpu->pool->configs[id];
> +	*addr =3D vpu->work_addr +
> +		((unsigned long)config - (phys_addr_t)vpu->work);
> +	mutex_unlock(vpu->lock);
> +
> +	return config;
> +}
> +
> +static int mdp_config_put(struct mdp_vpu_dev *vpu,
> +			  enum mdp_config_id id,
> +			  const struct img_config *config)
> +{
> +	int err =3D 0;
> +
> +	if (id < 0 || id >=3D MDP_CONFIG_POOL_SIZE)
> +		return -EINVAL;
> +	if (vpu->lock)
> +		mutex_lock(vpu->lock);
> +	if (!vpu->pool->cfg_count[id] || config !=3D &vpu->pool->configs[id])
> +		err =3D -EINVAL;
> +	else
> +		vpu->pool->cfg_count[id]--;
> +	if (vpu->lock)
> +		mutex_unlock(vpu->lock);
> +	return err;
> +}
> +
> +int mdp_vpu_ctx_init(struct mdp_vpu_ctx *ctx, struct mdp_vpu_dev *vpu,
> +		     enum mdp_config_id id)
> +{
> +	ctx->config =3D mdp_config_get(vpu, id, &ctx->inst_addr);
> +	if (IS_ERR(ctx->config)) {
> +		int err =3D PTR_ERR(ctx->config);
> +
> +		ctx->config =3D NULL;
> +		return err;
> +	}
> +	ctx->config_id =3D id;
> +	ctx->vpu_dev =3D vpu;
> +	return 0;
> +}
> +
> +int mdp_vpu_ctx_deinit(struct mdp_vpu_ctx *ctx)
> +{
> +	int err =3D mdp_config_put(ctx->vpu_dev, ctx->config_id, ctx->config);
> +
> +	ctx->config_id =3D 0;
> +	ctx->config =3D NULL;
> +	ctx->inst_addr =3D 0;
> +	return err;
> +}
> +
> +int mdp_vpu_process(struct mdp_vpu_ctx *ctx, struct img_ipi_frameparam *=
param)
> +{
> +	struct mdp_vpu_dev *vpu =3D ctx->vpu_dev;
> +	struct mdp_dev *mdp =3D vpu_to_mdp(vpu);
> +	struct img_sw_addr addr;
> +
> +	if (!ctx->vpu_dev->work || !ctx->vpu_dev->work_addr) {
> +		if (mdp_vpu_shared_mem_alloc(vpu)) {
> +			dev_err(&mdp->pdev->dev, "VPU memory alloc fail!");
> +			return -ENOMEM;
> +		}
> +	}
> +	memset((void *)ctx->vpu_dev->work, 0, ctx->vpu_dev->work_size);
> +	memset(ctx->config, 0, sizeof(*ctx->config));
> +	param->config_data.va =3D (unsigned long)ctx->config;
> +	param->config_data.pa =3D ctx->inst_addr;
> +	param->drv_data =3D (unsigned long)ctx;
> +
> +	memcpy((void *)ctx->vpu_dev->work, param, sizeof(*param));
> +	addr.pa =3D ctx->vpu_dev->work_addr;
> +	addr.va =3D (phys_addr_t)ctx->vpu_dev->work;
> +	return mdp_vpu_sendmsg(ctx->vpu_dev, SCP_IPI_MDP_FRAME,
> +		&addr, sizeof(addr));
> +}
> +
> diff --git a/drivers/media/platform/mtk-mdp3/mtk-mdp3-vpu.h b/drivers/med=
ia/platform/mtk-mdp3/mtk-mdp3-vpu.h
> new file mode 100644
> index 000000000000..4be8f861a93e
> --- /dev/null
> +++ b/drivers/media/platform/mtk-mdp3/mtk-mdp3-vpu.h
> @@ -0,0 +1,79 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2018 MediaTek Inc.
> + * Author: Ping-Hsun Wu <ping-hsun.wu@mediatek.com>
> + */
> +
> +#ifndef __MTK_MDP3_VPU_H__
> +#define __MTK_MDP3_VPU_H__
> +
> +#include <linux/platform_device.h>
> +#include "mtk-img-ipi.h"
> +
> +enum mdp_ipi_result {
> +	MDP_IPI_SUCCESS	=3D 0,
> +	MDP_IPI_ENOMEM	=3D 12,
> +	MDP_IPI_EBUSY	=3D 16,
> +	MDP_IPI_EINVAL	=3D 22,
> +	MDP_IPI_EMINST	=3D 24,
> +	MDP_IPI_ERANGE	=3D 34,
> +	MDP_IPI_NR_ERRNO,
> +
> +	MDP_IPI_EOTHER	=3D MDP_IPI_NR_ERRNO,
> +	MDP_IPI_PATH_CANT_MERGE,
> +	MDP_IPI_OP_FAIL,
> +};
> +
> +struct mdp_ipi_init_msg {
> +	u32	status;
> +	u64	drv_data;
> +	u32	work_addr;	/* [in] working buffer address */
> +	u32	work_size;	/* [in] working buffer size */
> +} __attribute__ ((__packed__));
> +
> +struct mdp_ipi_deinit_msg {
> +	u32	status;
> +	u64	drv_data;
> +	u32	work_addr;
> +} __attribute__ ((__packed__));
> +
> +enum mdp_config_id {
> +	MDP_DEV_M2M =3D 0,
> +	MDP_CONFIG_POOL_SIZE	/* ALWAYS keep at the end */
> +};
> +
> +struct mdp_config_pool {
> +	u64			cfg_count[MDP_CONFIG_POOL_SIZE];
> +	struct img_config	configs[MDP_CONFIG_POOL_SIZE];
> +};
> +
> +struct mdp_vpu_dev {
> +	/* synchronization protect for accessing vpu working buffer info */
> +	struct mutex		*lock;
> +	struct mtk_scp		*scp;
> +	struct completion	ipi_acked;
> +	void			*work;
> +	dma_addr_t		work_addr;
> +	size_t			work_size;
> +	struct mdp_config_pool	*pool;
> +	u32			status;
> +};
> +
> +struct mdp_vpu_ctx {
> +	struct mdp_vpu_dev	*vpu_dev;
> +	u32			config_id;
> +	struct img_config	*config;
> +	u32			inst_addr;
> +};
> +
> +void mdp_vpu_shared_mem_free(struct mdp_vpu_dev *vpu);
> +int mdp_vpu_dev_init(struct mdp_vpu_dev *vpu, struct mtk_scp *scp,
> +		     struct mutex *lock);
> +int mdp_vpu_dev_deinit(struct mdp_vpu_dev *vpu);
> +int mdp_vpu_ctx_init(struct mdp_vpu_ctx *ctx, struct mdp_vpu_dev *vpu,
> +		     enum mdp_config_id id);
> +int mdp_vpu_ctx_deinit(struct mdp_vpu_ctx *ctx);
> +int mdp_vpu_process(struct mdp_vpu_ctx *vpu, struct img_ipi_frameparam *=
param);
> +
> +#endif  /* __MTK_MDP3_VPU_H__ */
> +

