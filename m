Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 402C446BD74
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 15:20:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237524AbhLGOYB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 09:24:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbhLGOX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 09:23:59 -0500
Received: from lb2-smtp-cloud8.xs4all.net (lb2-smtp-cloud8.xs4all.net [IPv6:2001:888:0:108::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA1EFC061574;
        Tue,  7 Dec 2021 06:20:27 -0800 (PST)
Received: from cust-b5b5937f ([IPv6:fc0c:c16d:66b8:757f:c639:739b:9d66:799d])
        by smtp-cloud8.xs4all.net with ESMTPA
        id ubKHm0IBcQyExubKLm7GOu; Tue, 07 Dec 2021 15:20:25 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=s2;
        t=1638886825; bh=nHsNw5awsuV5Hy14rbgowmf8bWApqDSwX8s3aD8P2yI=;
        h=Subject:To:From:Message-ID:Date:MIME-Version:Content-Type:From:
         Subject;
        b=ZtHZie7OZNJDrjzcX/OzbGFws1fkSDvkAmwqmRqFMDyC6kl6L9JwM/bSQa0zYS9H5
         yCCdKE3dfyD0WnY1Y5qqCt3kPByAAqRr9rJ610n86EDf24LB7lAbqu9mPX2Mye+TWO
         BmDMnr/CjutYkSEFRIEUiGZqxZEWyHA0P29css3/Mo0xdXUHerysMqaY1rhFnvSmiM
         VT8Z4MBOMbWyBZVbvSvYukRMPnfIq7zWBsRV/aF8f+hldQGVZg6clCvtKzac3kSKBG
         Ns0Oc1pzE2TfO+PSzPczni1VapTqWhORAS3rkQTDfDynw+JXfCnl3+sU6037OBM/tM
         SCgHQI6Th8gtg==
Subject: Re: [PATCH v10 3/3] media: platform: mtk-mdp3: add Mediatek MDP3
 driver
To:     Moudy Ho <moudy.ho@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Rob Landley <rob@landley.net>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexandre Courbot <acourbot@chromium.org>, tfiga@chromium.org,
        drinkcat@chromium.org, pihsun@chromium.org, hsinyi@google.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Maoguang Meng <maoguang.meng@mediatek.com>,
        daoyuan huang <daoyuan.huang@mediatek.com>,
        Ping-Hsun Wu <ping-hsun.wu@mediatek.com>,
        menghui.lin@mediatek.com, sj.huang@mediatek.com,
        allen-kh.cheng@mediatek.com, randy.wu@mediatek.com,
        jason-jh.lin@mediatek.com, roy-cw.yeh@mediatek.com,
        river.cheng@mediatek.com, srv_heupstream@mediatek.com
References: <20211202062733.20338-1-moudy.ho@mediatek.com>
 <20211202062733.20338-4-moudy.ho@mediatek.com>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
Message-ID: <c48154b9-b202-c47c-c27e-53aa97877430@xs4all.nl>
Date:   Tue, 7 Dec 2021 15:20:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211202062733.20338-4-moudy.ho@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfOWUbPfTiPTqirbiNfEpShw1ekwWSNVBklXd6tW+PX5RoibUYVNnPuH1W0Sv0F/PxUpzjBPYWp0cFS0vnE0gpKSfURIOaucsX732AgIM+ukOGzSQ9wNA
 nNnYbD1UZ18/W5nHu8Jdnsu5LExcznoZ96e4mfwARYr8+Z0HfVPAMBfun5q680aBlYglJgElkR85tMLPnuGafp2JNHqwZo4voWHP3kkJAL4ku+Ey5XUMj5Hl
 R6Cw+5fE4WW1/x0VYrv8uDcKit8XpThhu57lAawTiJY+TAy/d1wqcdF29tLhKe5/uyM9i7bEhtH+SBJiby48tziakD1nL7UU97IX2QMi7/zDEk65wzk6O2+v
 +7ClTGLyDmjZTsq5jiebvx/jkJug7aBm/ngg8QRc3NleZLDdUONuEU69khFL/DUTnwNtIsf0S+ypPvi9SpUwMrzOlEP8op9f4FSJuuArR6HAF8EhXgaWqI5L
 sKg2tn3nrnXEc/Lyai9bQ2GCFiG7lrbCcYIMxJ8hc4dPqh4Wt/s/uOc35CiEKFGrUmWRLusxLk+U8EGs71Fq5rVP9VtAgoaljmREZjXLnQmoIl9QW0UeDYwN
 0Zju9vqI3wGRJQPd7mU0XeCaTSv/lsAvgun6F9aXDf3Nsb9biM4ZBw1orB07QHtS0kg/HMGln/Fs9UAaZgPN3zwedh7sVxdm+RJTjeDX6BTP/IXJURYXroSJ
 PMiBIWTVEPbAgDPRnLs1KlsswAiaPOShDBmyaXsbR+rjrPcQUl2fE5pvS4a524SBwYerXIjYWa6pgJojCm/8VXZqvFWriISWzcrSxMcQ87KejhSrH58jJV9P
 1ip6T8HAuYJeQnakhyJvnJzJoiHP+D0Seqv1AZKrGNie5N3N5O8hhcJ+nTZjq6WNQTm8UqDliBTI/Wla1eARP6k5cf/5cpNb39QYCHU/C2NVKB2aUW5+z9n8
 D666FGOVbX9MXHfdDgpcPlCSt4NdXu7T6m4hWKjCEk/jyWGt8SeTWlNwZT3tnb0gvt2S/XL/aOX9ZYSvVbv3I2wlg1fmKBPQZmurZGXo1bG2yg7TsHhtZhZ+
 4qqZ3FMxz4TQ6MMGbv2VNXPyTtUOg9j+M1ou4j/rvwQsyHV/vDHX0XdfajSbtToN2/qoTaaWu9J6yvnbtB7PMr8U/KGItkRPAbzfjvjF89hv3fcgpEdj2m80
 mF4aMINaCg/sPBn5NMJ/cYyMTgc51/C+aWz0cgNDOnm7sccv+xSleD8ON+tEeF80URdI2LEWbuJPF2HP5uI3PBbFpPjcAYrko85mxOI++BFm5lTwaLAEP6ma
 C3VMFSKoUv7SjFozzjEDwedHPTjBFVyeI5EOh9uV5qzroYDxVk4Q9nQJf20a2ahuF30LnYL+aQqi8zA4FvPgjBz8w+mUl1z9vJ/UIkrIHiwYqGyFMpaqEb9l
 8TEivMpj4iTZNGVI
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/2/21 7:27 AM, Moudy Ho wrote:
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
> Each modules' register table is defined in file with "mdp_reg_" prefix
> GCE related API, operation control  sited in mtk-mdp3-cmdq.c
> V4L2 m2m device functions are implemented in mtk-mdp3-m2m.c
> Probe, power, suspend/resume, system level functions are defined in
> mtk-mdp3-core.c
> 
> Signed-off-by: Ping-Hsun Wu <ping-hsun.wu@mediatek.com>
> Signed-off-by: daoyuan huang <daoyuan.huang@mediatek.com>
> Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>
> Reported-by: kernel test robot <lkp@intel.com>
> ---
>  drivers/media/platform/Kconfig                |   19 +
>  drivers/media/platform/Makefile               |    2 +
>  drivers/media/platform/mtk-mdp3/Makefile      |    6 +
>  .../media/platform/mtk-mdp3/mdp_reg_ccorr.h   |   19 +
>  drivers/media/platform/mtk-mdp3/mdp_reg_isp.h |   27 +
>  .../media/platform/mtk-mdp3/mdp_reg_rdma.h    |   65 +
>  drivers/media/platform/mtk-mdp3/mdp_reg_rsz.h |   39 +
>  .../media/platform/mtk-mdp3/mdp_reg_wdma.h    |   47 +
>  .../media/platform/mtk-mdp3/mdp_reg_wrot.h    |   55 +
>  drivers/media/platform/mtk-mdp3/mtk-img-ipi.h |  280 ++++
>  .../media/platform/mtk-mdp3/mtk-mdp3-cmdq.c   |  505 +++++++
>  .../media/platform/mtk-mdp3/mtk-mdp3-cmdq.h   |   46 +
>  .../media/platform/mtk-mdp3/mtk-mdp3-comp.c   | 1264 +++++++++++++++++
>  .../media/platform/mtk-mdp3/mtk-mdp3-comp.h   |  147 ++
>  .../media/platform/mtk-mdp3/mtk-mdp3-core.c   |  338 +++++
>  .../media/platform/mtk-mdp3/mtk-mdp3-core.h   |   76 +
>  .../media/platform/mtk-mdp3/mtk-mdp3-m2m.c    |  789 ++++++++++
>  .../media/platform/mtk-mdp3/mtk-mdp3-m2m.h    |   49 +
>  .../media/platform/mtk-mdp3/mtk-mdp3-regs.c   |  737 ++++++++++
>  .../media/platform/mtk-mdp3/mtk-mdp3-regs.h   |  372 +++++
>  .../media/platform/mtk-mdp3/mtk-mdp3-vpu.c    |  312 ++++
>  .../media/platform/mtk-mdp3/mtk-mdp3-vpu.h    |   78 +
>  22 files changed, 5272 insertions(+)
>  create mode 100644 drivers/media/platform/mtk-mdp3/Makefile
>  create mode 100644 drivers/media/platform/mtk-mdp3/mdp_reg_ccorr.h
>  create mode 100644 drivers/media/platform/mtk-mdp3/mdp_reg_isp.h
>  create mode 100644 drivers/media/platform/mtk-mdp3/mdp_reg_rdma.h
>  create mode 100644 drivers/media/platform/mtk-mdp3/mdp_reg_rsz.h
>  create mode 100644 drivers/media/platform/mtk-mdp3/mdp_reg_wdma.h
>  create mode 100644 drivers/media/platform/mtk-mdp3/mdp_reg_wrot.h
>  create mode 100644 drivers/media/platform/mtk-mdp3/mtk-img-ipi.h
>  create mode 100644 drivers/media/platform/mtk-mdp3/mtk-mdp3-cmdq.c
>  create mode 100644 drivers/media/platform/mtk-mdp3/mtk-mdp3-cmdq.h
>  create mode 100644 drivers/media/platform/mtk-mdp3/mtk-mdp3-comp.c
>  create mode 100644 drivers/media/platform/mtk-mdp3/mtk-mdp3-comp.h
>  create mode 100644 drivers/media/platform/mtk-mdp3/mtk-mdp3-core.c
>  create mode 100644 drivers/media/platform/mtk-mdp3/mtk-mdp3-core.h
>  create mode 100644 drivers/media/platform/mtk-mdp3/mtk-mdp3-m2m.c
>  create mode 100644 drivers/media/platform/mtk-mdp3/mtk-mdp3-m2m.h
>  create mode 100644 drivers/media/platform/mtk-mdp3/mtk-mdp3-regs.c
>  create mode 100644 drivers/media/platform/mtk-mdp3/mtk-mdp3-regs.h
>  create mode 100644 drivers/media/platform/mtk-mdp3/mtk-mdp3-vpu.c
>  create mode 100644 drivers/media/platform/mtk-mdp3/mtk-mdp3-vpu.h
> 
> diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
> index cf4adc64c953..e6c1e8892154 100644
> --- a/drivers/media/platform/Kconfig
> +++ b/drivers/media/platform/Kconfig
> @@ -315,6 +315,25 @@ config VIDEO_MEDIATEK_MDP
>  	    To compile this driver as a module, choose M here: the
>  	    module will be called mtk-mdp.
>  
> +config VIDEO_MEDIATEK_MDP3
> +	tristate "Mediatek MDP v3 driver"
> +	depends on MTK_IOMMU || COMPLIE_TEST

Typo: COMPLIE_TEST -> COMPILE_TEST

After fixing this, trying to build this driver on my PC results in:

ERROR: modpost: "mtk_mmsys_mdp_connect" [drivers/media/platform/mtk-mdp3/mtk-mdp3.ko] undefined!
ERROR: modpost: "mtk_mmsys_mdp_camin_ctrl" [drivers/media/platform/mtk-mdp3/mtk-mdp3.ko] undefined!
ERROR: modpost: "mtk_mmsys_mdp_isp_ctrl" [drivers/media/platform/mtk-mdp3/mtk-mdp3.ko] undefined!
ERROR: modpost: "mtk_mutex_prepare" [drivers/media/platform/mtk-mdp3/mtk-mdp3.ko] undefined!
ERROR: modpost: "mtk_mmsys_mdp_disconnect" [drivers/media/platform/mtk-mdp3/mtk-mdp3.ko] undefined!
ERROR: modpost: "mtk_mutex_unprepare" [drivers/media/platform/mtk-mdp3/mtk-mdp3.ko] undefined!
ERROR: modpost: "mtk_mutex_get_mdp_mod" [drivers/media/platform/mtk-mdp3/mtk-mdp3.ko] undefined!
ERROR: modpost: "mtk_mutex_put" [drivers/media/platform/mtk-mdp3/mtk-mdp3.ko] undefined!
ERROR: modpost: "mtk_mutex_mdp_get" [drivers/media/platform/mtk-mdp3/mtk-mdp3.ko] undefined!
ERROR: modpost: "mtk_mutex_add_mod_by_cmdq" [drivers/media/platform/mtk-mdp3/mtk-mdp3.ko] undefined!
WARNING: modpost: suppressed 1 unresolved symbol warnings because there were too many)

include/linux/soc/mediatek/mtk-mmsys.h should probably provide dummy functions
if CONFIG_MTK_MMSYS is undefined. Ditto for include/linux/soc/mediatek/mtk-mutex.h.

Regards,

	Hans
