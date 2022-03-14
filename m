Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 267BA4D886B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 16:44:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242716AbiCNPpE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 11:45:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239274AbiCNPpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 11:45:01 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C615B37AA9;
        Mon, 14 Mar 2022 08:43:49 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id B28021F43616
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1647272628;
        bh=ADzj3fLd13xtixMp7V/4dBx2nvQk/TI/NlWYAjevHCE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Sw/EoPvKWc6kW+FWBU3OG2SSMzeLgqWD3uYuEJ/xB75XLFyTIwTvUaOG/9cPd5Frq
         05lFDS4zWpuF5Yjy4RO8+x5PZh9i0wAAcL5vVC37pNUh0ICiisKvlXB+WX0LbTEkfC
         OZrTCpgEfbBb8CMJOIXddtXPmCrboZk04+5FwKfIVdVOpk1HVj4q8ox/0gudGMGNWg
         Fh7Hw05kQ6KXbET6w8lMc+hMDm69o+fbftrU4I9dcqTQ0Vge84dVPHzxfC9I5lzCP1
         avdnB7Mwi2s8PjZz8fbwHt1HQ3/a4hPb/k1PCmJo8P7wFoI+nwFgdP+GBnER6Os8PL
         1FfR/1Nou3skg==
Message-ID: <c284dd18-107c-6050-61ec-ec5d00517d04@collabora.com>
Date:   Mon, 14 Mar 2022 16:43:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH 06/24] media: platform: rename mtk-vcodec/ to
 mediatek/mtk-vcodec/
Content-Language: en-US
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        =?UTF-8?Q?Niklas_S=c3=b6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Alexandre Courbot <acourbot@chromium.org>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Dmitry Osipenko <digetx@gmail.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Hirokazu Honda <hiroh@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Irui Wang <irui.wang@mediatek.com>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jiasheng Jiang <jiasheng@iscas.ac.cn>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Ming Qian <ming.qian@nxp.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Steve Cho <stevecho@chromium.org>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Tzung-Bi Shih <tzungbi@google.com>,
        Yong Wu <yong.wu@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <cover.1647167750.git.mchehab@kernel.org>
 <53a632ce79c9d02673d7540e18d681f123afb801.1647167750.git.mchehab@kernel.org>
 <17120e5dcc7b7fdac207a41d764a13db7b270380.camel@collabora.com>
 <20220314153733.63d1451f@coco.lan>
 <30eae66e-5dd2-9868-dd2a-aab377ffd821@collabora.com>
 <20220314164234.5666592e@coco.lan>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220314164234.5666592e@coco.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 14/03/22 16:42, Mauro Carvalho Chehab ha scritto:
> Em Mon, 14 Mar 2022 16:02:43 +0100
> AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com> escreveu:
> 
>> Il 14/03/22 15:37, Mauro Carvalho Chehab ha scritto:
>>> Em Mon, 14 Mar 2022 09:09:45 -0400
>>> Nicolas Dufresne <nicolas.dufresne@collabora.com> escreveu:
>>>    
>>>> Le dimanche 13 mars 2022 à 11:51 +0100, Mauro Carvalho Chehab a écrit :
>>>>> As the end goal is to have platform drivers split by vendor,
>>>>> rename mtk-vcodec/ to mediatek/mtk-vcodec/.
>>>>
>>>> Was thinking all these mtk-* directory didn't fit with the platform/ semantic. I
>>>> totally support this change. I suppose jpeg/mdp/vpu also needs to be moved. And
>>>> mdp3 and various vcodec patches will need a new submission.
>>>
>>> They were all moved too, each one on a separate patch in this series:
>>>    
>>
>> Hello Mauro, Nicolas
>>
>> I was wondering if we could also drop the 'mtk-' prefix from the folder names,
>> as 'mtk' effectively stands for 'mediatek'... so we would have them as:
>>
>> mediatek/jpeg
>> mediatek/mdp
> 
>> mediatek/mdp3
> 
> Hmm... I guess this one didn't reach upstream yet.

Hehehe, sorry, I tend to always think forward... sometimes too much :))

> 
>> mediatek/vcodec
>> mediatek/vpu
>>
>> mediatek/mtk-... looks a bit repetitive :)
> 
> Ok, but I'll likely place this on a separate patch at the end of this
> series. Rebasing such series has been no fun ;-)
> 

Sure, thank you!

>>
>> Cheers,
>> Angelo
>>
>>>       $ LANG=C tree -d drivers/media/platform/
>>>       drivers/media/platform/
>>>       |-- allegro-dvt
>>>       |-- allwinner
>>>       |   |-- sun4i-csi
>>>       |   |-- sun6i-csi
>>>       |   |-- sun8i-di
>>>       |   `-- sun8i-rotate
>>>       |-- amlogic
>>>       |   `-- meson-ge2d
>>>       |-- amphion
>>>       |-- aspeed
>>>       |-- atmel
>>>       |-- cadence
>>>       |-- chips-media
>>>       |-- intel
>>>       |-- marvell
>>>       |-- mediatek
>>>       |   |-- mtk-jpeg
>>>       |   |-- mtk-mdp
>>>       |   |-- mtk-vcodec
>>>       |   |   |-- vdec
>>>       |   |   `-- venc
>>>       |   `-- mtk-vpu
>>>       |-- nvidia
>>>       |   `-- tegra-vde
>>>       |-- nxp
>>>       |   `-- imx-jpeg
>>>       |-- qcom
>>>       |   |-- camss
>>>       |   `-- venus
>>>       |-- renesas
>>>       |   |-- rcar-vin
>>>       |   `-- vsp1
>>>       |-- rockchip
>>>       |   |-- rga
>>>       |   `-- rkisp1
>>>       |-- samsung
>>>       |   |-- exynos-gsc
>>>       |   |-- exynos4-is
>>>       |   |-- s3c-camif
>>>       |   |-- s5p-g2d
>>>       |   |-- s5p-jpeg
>>>       |   `-- s5p-mfc
>>>       |-- stm
>>>       |   |-- sti
>>>       |   |   |-- bdisp
>>>       |   |   |-- c8sectpfe
>>>       |   |   |-- delta
>>>       |   |   `-- hva
>>>       |   `-- stm32
>>>       |       `-- dma2d
>>>       |-- ti
>>>       |   |-- am437x
>>>       |   |-- cal
>>>       |   |-- davinci
>>>       |   |-- omap
>>>       |   |-- omap3isp
>>>       |   `-- vpe
>>>       |-- ti-vpe
>>>       |-- via
>>>       `-- xilinx
>>>    
>>>>   
>>>>>
>>>>> Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
>>>>
>>>> Acked-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
>>>>   
>>>>> ---
>>>>>
>>>>> To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
>>>>> See [PATCH 00/24] at: https://lore.kernel.org/all/cover.1647167750.git.mchehab@kernel.org/
>>>>>
>>>>>    MAINTAINERS                                                     | 2 +-
>>>>>    drivers/media/platform/Kconfig                                  | 2 +-
>>>>>    drivers/media/platform/Makefile                                 | 2 +-
>>>>>    drivers/media/platform/{ => mediatek}/mtk-vcodec/Kconfig        | 0
>>>>>    drivers/media/platform/{ => mediatek}/mtk-vcodec/Makefile       | 0
>>>>>    .../media/platform/{ => mediatek}/mtk-vcodec/mtk_vcodec_dec.c   | 0
>>>>>    .../media/platform/{ => mediatek}/mtk-vcodec/mtk_vcodec_dec.h   | 0
>>>>>    .../platform/{ => mediatek}/mtk-vcodec/mtk_vcodec_dec_drv.c     | 0
>>>>>    .../platform/{ => mediatek}/mtk-vcodec/mtk_vcodec_dec_hw.c      | 0
>>>>>    .../platform/{ => mediatek}/mtk-vcodec/mtk_vcodec_dec_hw.h      | 0
>>>>>    .../platform/{ => mediatek}/mtk-vcodec/mtk_vcodec_dec_pm.c      | 0
>>>>>    .../platform/{ => mediatek}/mtk-vcodec/mtk_vcodec_dec_pm.h      | 0
>>>>>    .../{ => mediatek}/mtk-vcodec/mtk_vcodec_dec_stateful.c         | 0
>>>>>    .../{ => mediatek}/mtk-vcodec/mtk_vcodec_dec_stateless.c        | 0
>>>>>    .../media/platform/{ => mediatek}/mtk-vcodec/mtk_vcodec_drv.h   | 0
>>>>>    .../media/platform/{ => mediatek}/mtk-vcodec/mtk_vcodec_enc.c   | 0
>>>>>    .../media/platform/{ => mediatek}/mtk-vcodec/mtk_vcodec_enc.h   | 0
>>>>>    .../platform/{ => mediatek}/mtk-vcodec/mtk_vcodec_enc_drv.c     | 0
>>>>>    .../platform/{ => mediatek}/mtk-vcodec/mtk_vcodec_enc_pm.c      | 0
>>>>>    .../platform/{ => mediatek}/mtk-vcodec/mtk_vcodec_enc_pm.h      | 0
>>>>>    .../media/platform/{ => mediatek}/mtk-vcodec/mtk_vcodec_fw.c    | 0
>>>>>    .../media/platform/{ => mediatek}/mtk-vcodec/mtk_vcodec_fw.h    | 0
>>>>>    .../platform/{ => mediatek}/mtk-vcodec/mtk_vcodec_fw_priv.h     | 0
>>>>>    .../platform/{ => mediatek}/mtk-vcodec/mtk_vcodec_fw_scp.c      | 0
>>>>>    .../platform/{ => mediatek}/mtk-vcodec/mtk_vcodec_fw_vpu.c      | 0
>>>>>    .../media/platform/{ => mediatek}/mtk-vcodec/mtk_vcodec_intr.c  | 0
>>>>>    .../media/platform/{ => mediatek}/mtk-vcodec/mtk_vcodec_intr.h  | 0
>>>>>    .../media/platform/{ => mediatek}/mtk-vcodec/mtk_vcodec_util.c  | 0
>>>>>    .../media/platform/{ => mediatek}/mtk-vcodec/mtk_vcodec_util.h  | 0
>>>>>    .../platform/{ => mediatek}/mtk-vcodec/vdec/vdec_h264_if.c      | 0
>>>>>    .../platform/{ => mediatek}/mtk-vcodec/vdec/vdec_h264_req_if.c  | 0
>>>>>    .../media/platform/{ => mediatek}/mtk-vcodec/vdec/vdec_vp8_if.c | 0
>>>>>    .../media/platform/{ => mediatek}/mtk-vcodec/vdec/vdec_vp9_if.c | 0
>>>>>    .../media/platform/{ => mediatek}/mtk-vcodec/vdec_drv_base.h    | 0
>>>>>    drivers/media/platform/{ => mediatek}/mtk-vcodec/vdec_drv_if.c  | 0
>>>>>    drivers/media/platform/{ => mediatek}/mtk-vcodec/vdec_drv_if.h  | 0
>>>>>    drivers/media/platform/{ => mediatek}/mtk-vcodec/vdec_ipi_msg.h | 0
>>>>>    .../media/platform/{ => mediatek}/mtk-vcodec/vdec_msg_queue.c   | 0
>>>>>    .../media/platform/{ => mediatek}/mtk-vcodec/vdec_msg_queue.h   | 0
>>>>>    drivers/media/platform/{ => mediatek}/mtk-vcodec/vdec_vpu_if.c  | 0
>>>>>    drivers/media/platform/{ => mediatek}/mtk-vcodec/vdec_vpu_if.h  | 0
>>>>>    .../platform/{ => mediatek}/mtk-vcodec/venc/venc_h264_if.c      | 0
>>>>>    .../media/platform/{ => mediatek}/mtk-vcodec/venc/venc_vp8_if.c | 0
>>>>>    .../media/platform/{ => mediatek}/mtk-vcodec/venc_drv_base.h    | 0
>>>>>    drivers/media/platform/{ => mediatek}/mtk-vcodec/venc_drv_if.c  | 0
>>>>>    drivers/media/platform/{ => mediatek}/mtk-vcodec/venc_drv_if.h  | 0
>>>>>    drivers/media/platform/{ => mediatek}/mtk-vcodec/venc_ipi_msg.h | 0
>>>>>    drivers/media/platform/{ => mediatek}/mtk-vcodec/venc_vpu_if.c  | 0
>>>>>    drivers/media/platform/{ => mediatek}/mtk-vcodec/venc_vpu_if.h  | 0
>>>>>    49 files changed, 3 insertions(+), 3 deletions(-)
>>>>>    rename drivers/media/platform/{ => mediatek}/mtk-vcodec/Kconfig (100%)
>>>>>    rename drivers/media/platform/{ => mediatek}/mtk-vcodec/Makefile (100%)
>>>>>    rename drivers/media/platform/{ => mediatek}/mtk-vcodec/mtk_vcodec_dec.c (100%)
>>>>>    rename drivers/media/platform/{ => mediatek}/mtk-vcodec/mtk_vcodec_dec.h (100%)
>>>>>    rename drivers/media/platform/{ => mediatek}/mtk-vcodec/mtk_vcodec_dec_drv.c (100%)
>>>>>    rename drivers/media/platform/{ => mediatek}/mtk-vcodec/mtk_vcodec_dec_hw.c (100%)
>>>>>    rename drivers/media/platform/{ => mediatek}/mtk-vcodec/mtk_vcodec_dec_hw.h (100%)
>>>>>    rename drivers/media/platform/{ => mediatek}/mtk-vcodec/mtk_vcodec_dec_pm.c (100%)
>>>>>    rename drivers/media/platform/{ => mediatek}/mtk-vcodec/mtk_vcodec_dec_pm.h (100%)
>>>>>    rename drivers/media/platform/{ => mediatek}/mtk-vcodec/mtk_vcodec_dec_stateful.c (100%)
>>>>>    rename drivers/media/platform/{ => mediatek}/mtk-vcodec/mtk_vcodec_dec_stateless.c (100%)
>>>>>    rename drivers/media/platform/{ => mediatek}/mtk-vcodec/mtk_vcodec_drv.h (100%)
>>>>>    rename drivers/media/platform/{ => mediatek}/mtk-vcodec/mtk_vcodec_enc.c (100%)
>>>>>    rename drivers/media/platform/{ => mediatek}/mtk-vcodec/mtk_vcodec_enc.h (100%)
>>>>>    rename drivers/media/platform/{ => mediatek}/mtk-vcodec/mtk_vcodec_enc_drv.c (100%)
>>>>>    rename drivers/media/platform/{ => mediatek}/mtk-vcodec/mtk_vcodec_enc_pm.c (100%)
>>>>>    rename drivers/media/platform/{ => mediatek}/mtk-vcodec/mtk_vcodec_enc_pm.h (100%)
>>>>>    rename drivers/media/platform/{ => mediatek}/mtk-vcodec/mtk_vcodec_fw.c (100%)
>>>>>    rename drivers/media/platform/{ => mediatek}/mtk-vcodec/mtk_vcodec_fw.h (100%)
>>>>>    rename drivers/media/platform/{ => mediatek}/mtk-vcodec/mtk_vcodec_fw_priv.h (100%)
>>>>>    rename drivers/media/platform/{ => mediatek}/mtk-vcodec/mtk_vcodec_fw_scp.c (100%)
>>>>>    rename drivers/media/platform/{ => mediatek}/mtk-vcodec/mtk_vcodec_fw_vpu.c (100%)
>>>>>    rename drivers/media/platform/{ => mediatek}/mtk-vcodec/mtk_vcodec_intr.c (100%)
>>>>>    rename drivers/media/platform/{ => mediatek}/mtk-vcodec/mtk_vcodec_intr.h (100%)
>>>>>    rename drivers/media/platform/{ => mediatek}/mtk-vcodec/mtk_vcodec_util.c (100%)
>>>>>    rename drivers/media/platform/{ => mediatek}/mtk-vcodec/mtk_vcodec_util.h (100%)
>>>>>    rename drivers/media/platform/{ => mediatek}/mtk-vcodec/vdec/vdec_h264_if.c (100%)
>>>>>    rename drivers/media/platform/{ => mediatek}/mtk-vcodec/vdec/vdec_h264_req_if.c (100%)
>>>>>    rename drivers/media/platform/{ => mediatek}/mtk-vcodec/vdec/vdec_vp8_if.c (100%)
>>>>>    rename drivers/media/platform/{ => mediatek}/mtk-vcodec/vdec/vdec_vp9_if.c (100%)
>>>>>    rename drivers/media/platform/{ => mediatek}/mtk-vcodec/vdec_drv_base.h (100%)
>>>>>    rename drivers/media/platform/{ => mediatek}/mtk-vcodec/vdec_drv_if.c (100%)
>>>>>    rename drivers/media/platform/{ => mediatek}/mtk-vcodec/vdec_drv_if.h (100%)
>>>>>    rename drivers/media/platform/{ => mediatek}/mtk-vcodec/vdec_ipi_msg.h (100%)
>>>>>    rename drivers/media/platform/{ => mediatek}/mtk-vcodec/vdec_msg_queue.c (100%)
>>>>>    rename drivers/media/platform/{ => mediatek}/mtk-vcodec/vdec_msg_queue.h (100%)
>>>>>    rename drivers/media/platform/{ => mediatek}/mtk-vcodec/vdec_vpu_if.c (100%)
>>>>>    rename drivers/media/platform/{ => mediatek}/mtk-vcodec/vdec_vpu_if.h (100%)
>>>>>    rename drivers/media/platform/{ => mediatek}/mtk-vcodec/venc/venc_h264_if.c (100%)
>>>>>    rename drivers/media/platform/{ => mediatek}/mtk-vcodec/venc/venc_vp8_if.c (100%)
>>>>>    rename drivers/media/platform/{ => mediatek}/mtk-vcodec/venc_drv_base.h (100%)
>>>>>    rename drivers/media/platform/{ => mediatek}/mtk-vcodec/venc_drv_if.c (100%)
>>>>>    rename drivers/media/platform/{ => mediatek}/mtk-vcodec/venc_drv_if.h (100%)
>>>>>    rename drivers/media/platform/{ => mediatek}/mtk-vcodec/venc_ipi_msg.h (100%)
>>>>>    rename drivers/media/platform/{ => mediatek}/mtk-vcodec/venc_vpu_if.c (100%)
>>>>>    rename drivers/media/platform/{ => mediatek}/mtk-vcodec/venc_vpu_if.h (100%)
>>>>>
>>>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>>>> index 2203d98bbcf1..bfe014870a77 100644
>>>>> --- a/MAINTAINERS
>>>>> +++ b/MAINTAINERS
>>>>> @@ -12147,7 +12147,7 @@ M:	Andrew-CT Chen <andrew-ct.chen@mediatek.com>
>>>>>    S:	Supported
>>>>>    F:	Documentation/devicetree/bindings/media/mediatek-vcodec.txt
>>>>>    F:	Documentation/devicetree/bindings/media/mediatek-vpu.txt
>>>>> -F:	drivers/media/platform/mtk-vcodec/
>>>>> +F:	drivers/media/platform/mediatek/mtk-vcodec/
>>>>>    F:	drivers/media/platform/mtk-vpu/
>>>>>    
>>>>>    MEDIATEK MMC/SD/SDIO DRIVER
>>>>> diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
>>>>> index a45fd3fe103e..8ba10b657164 100644
>>>>> --- a/drivers/media/platform/Kconfig
>>>>> +++ b/drivers/media/platform/Kconfig
>>>>> @@ -80,7 +80,7 @@ source "drivers/media/platform/intel/Kconfig"
>>>>>    source "drivers/media/platform/marvell/Kconfig"
>>>>>    source "drivers/media/platform/mediatek/mtk-jpeg/Kconfig"
>>>>>    source "drivers/media/platform/mediatek/mtk-mdp/Kconfig"
>>>>> -source "drivers/media/platform/mtk-vcodec/Kconfig"
>>>>> +source "drivers/media/platform/mediatek/mtk-vcodec/Kconfig"
>>>>>    source "drivers/media/platform/mtk-vpu/Kconfig"
>>>>>    source "drivers/media/platform/nxp/Kconfig"
>>>>>    source "drivers/media/platform/omap/Kconfig"
>>>>> diff --git a/drivers/media/platform/Makefile b/drivers/media/platform/Makefile
>>>>> index 6f5d09cd8f9b..637a3a7ac036 100644
>>>>> --- a/drivers/media/platform/Makefile
>>>>> +++ b/drivers/media/platform/Makefile
>>>>> @@ -20,7 +20,7 @@ obj-y += intel/
>>>>>    obj-y += marvell/
>>>>>    obj-y += mediatek/mtk-jpeg/
>>>>>    obj-y += mediatek/mtk-mdp/
>>>>> -obj-y += mtk-vcodec/
>>>>> +obj-y += mediatek/mtk-vcodec/
>>>>>    obj-y += mtk-vpu/
>>>>>    obj-y += nxp/
>>>>>    obj-y += omap/
>>>>> diff --git a/drivers/media/platform/mtk-vcodec/Kconfig b/drivers/media/platform/mediatek/mtk-vcodec/Kconfig
>>>>> similarity index 100%
>>>>> rename from drivers/media/platform/mtk-vcodec/Kconfig
>>>>> rename to drivers/media/platform/mediatek/mtk-vcodec/Kconfig
>>>>> diff --git a/drivers/media/platform/mtk-vcodec/Makefile b/drivers/media/platform/mediatek/mtk-vcodec/Makefile
>>>>> similarity index 100%
>>>>> rename from drivers/media/platform/mtk-vcodec/Makefile
>>>>> rename to drivers/media/platform/mediatek/mtk-vcodec/Makefile
>>>>> diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec.c b/drivers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_dec.c
>>>>> similarity index 100%
>>>>> rename from drivers/media/platform/mtk-vcodec/mtk_vcodec_dec.c
>>>>> rename to drivers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_dec.c
>>>>> diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec.h b/drivers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_dec.h
>>>>> similarity index 100%
>>>>> rename from drivers/media/platform/mtk-vcodec/mtk_vcodec_dec.h
>>>>> rename to drivers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_dec.h
>>>>> diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_drv.c b/drivers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_dec_drv.c
>>>>> similarity index 100%
>>>>> rename from drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_drv.c
>>>>> rename to drivers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_dec_drv.c
>>>>> diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_hw.c b/drivers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_dec_hw.c
>>>>> similarity index 100%
>>>>> rename from drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_hw.c
>>>>> rename to drivers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_dec_hw.c
>>>>> diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_hw.h b/drivers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_dec_hw.h
>>>>> similarity index 100%
>>>>> rename from drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_hw.h
>>>>> rename to drivers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_dec_hw.h
>>>>> diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_pm.c b/drivers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_dec_pm.c
>>>>> similarity index 100%
>>>>> rename from drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_pm.c
>>>>> rename to drivers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_dec_pm.c
>>>>> diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_pm.h b/drivers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_dec_pm.h
>>>>> similarity index 100%
>>>>> rename from drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_pm.h
>>>>> rename to drivers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_dec_pm.h
>>>>> diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_stateful.c b/drivers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_dec_stateful.c
>>>>> similarity index 100%
>>>>> rename from drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_stateful.c
>>>>> rename to drivers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_dec_stateful.c
>>>>> diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_stateless.c b/drivers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_dec_stateless.c
>>>>> similarity index 100%
>>>>> rename from drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_stateless.c
>>>>> rename to drivers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_dec_stateless.c
>>>>> diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_drv.h b/drivers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_drv.h
>>>>> similarity index 100%
>>>>> rename from drivers/media/platform/mtk-vcodec/mtk_vcodec_drv.h
>>>>> rename to drivers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_drv.h
>>>>> diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c b/drivers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_enc.c
>>>>> similarity index 100%
>>>>> rename from drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c
>>>>> rename to drivers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_enc.c
>>>>> diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.h b/drivers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_enc.h
>>>>> similarity index 100%
>>>>> rename from drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.h
>>>>> rename to drivers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_enc.h
>>>>> diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_drv.c b/drivers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_enc_drv.c
>>>>> similarity index 100%
>>>>> rename from drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_drv.c
>>>>> rename to drivers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_enc_drv.c
>>>>> diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_pm.c b/drivers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_enc_pm.c
>>>>> similarity index 100%
>>>>> rename from drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_pm.c
>>>>> rename to drivers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_enc_pm.c
>>>>> diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_pm.h b/drivers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_enc_pm.h
>>>>> similarity index 100%
>>>>> rename from drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_pm.h
>>>>> rename to drivers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_enc_pm.h
>>>>> diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_fw.c b/drivers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_fw.c
>>>>> similarity index 100%
>>>>> rename from drivers/media/platform/mtk-vcodec/mtk_vcodec_fw.c
>>>>> rename to drivers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_fw.c
>>>>> diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_fw.h b/drivers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_fw.h
>>>>> similarity index 100%
>>>>> rename from drivers/media/platform/mtk-vcodec/mtk_vcodec_fw.h
>>>>> rename to drivers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_fw.h
>>>>> diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_fw_priv.h b/drivers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_fw_priv.h
>>>>> similarity index 100%
>>>>> rename from drivers/media/platform/mtk-vcodec/mtk_vcodec_fw_priv.h
>>>>> rename to drivers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_fw_priv.h
>>>>> diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_fw_scp.c b/drivers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_fw_scp.c
>>>>> similarity index 100%
>>>>> rename from drivers/media/platform/mtk-vcodec/mtk_vcodec_fw_scp.c
>>>>> rename to drivers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_fw_scp.c
>>>>> diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_fw_vpu.c b/drivers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_fw_vpu.c
>>>>> similarity index 100%
>>>>> rename from drivers/media/platform/mtk-vcodec/mtk_vcodec_fw_vpu.c
>>>>> rename to drivers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_fw_vpu.c
>>>>> diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_intr.c b/drivers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_intr.c
>>>>> similarity index 100%
>>>>> rename from drivers/media/platform/mtk-vcodec/mtk_vcodec_intr.c
>>>>> rename to drivers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_intr.c
>>>>> diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_intr.h b/drivers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_intr.h
>>>>> similarity index 100%
>>>>> rename from drivers/media/platform/mtk-vcodec/mtk_vcodec_intr.h
>>>>> rename to drivers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_intr.h
>>>>> diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_util.c b/drivers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_util.c
>>>>> similarity index 100%
>>>>> rename from drivers/media/platform/mtk-vcodec/mtk_vcodec_util.c
>>>>> rename to drivers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_util.c
>>>>> diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_util.h b/drivers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_util.h
>>>>> similarity index 100%
>>>>> rename from drivers/media/platform/mtk-vcodec/mtk_vcodec_util.h
>>>>> rename to drivers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_util.h
>>>>> diff --git a/drivers/media/platform/mtk-vcodec/vdec/vdec_h264_if.c b/drivers/media/platform/mediatek/mtk-vcodec/vdec/vdec_h264_if.c
>>>>> similarity index 100%
>>>>> rename from drivers/media/platform/mtk-vcodec/vdec/vdec_h264_if.c
>>>>> rename to drivers/media/platform/mediatek/mtk-vcodec/vdec/vdec_h264_if.c
>>>>> diff --git a/drivers/media/platform/mtk-vcodec/vdec/vdec_h264_req_if.c b/drivers/media/platform/mediatek/mtk-vcodec/vdec/vdec_h264_req_if.c
>>>>> similarity index 100%
>>>>> rename from drivers/media/platform/mtk-vcodec/vdec/vdec_h264_req_if.c
>>>>> rename to drivers/media/platform/mediatek/mtk-vcodec/vdec/vdec_h264_req_if.c
>>>>> diff --git a/drivers/media/platform/mtk-vcodec/vdec/vdec_vp8_if.c b/drivers/media/platform/mediatek/mtk-vcodec/vdec/vdec_vp8_if.c
>>>>> similarity index 100%
>>>>> rename from drivers/media/platform/mtk-vcodec/vdec/vdec_vp8_if.c
>>>>> rename to drivers/media/platform/mediatek/mtk-vcodec/vdec/vdec_vp8_if.c
>>>>> diff --git a/drivers/media/platform/mtk-vcodec/vdec/vdec_vp9_if.c b/drivers/media/platform/mediatek/mtk-vcodec/vdec/vdec_vp9_if.c
>>>>> similarity index 100%
>>>>> rename from drivers/media/platform/mtk-vcodec/vdec/vdec_vp9_if.c
>>>>> rename to drivers/media/platform/mediatek/mtk-vcodec/vdec/vdec_vp9_if.c
>>>>> diff --git a/drivers/media/platform/mtk-vcodec/vdec_drv_base.h b/drivers/media/platform/mediatek/mtk-vcodec/vdec_drv_base.h
>>>>> similarity index 100%
>>>>> rename from drivers/media/platform/mtk-vcodec/vdec_drv_base.h
>>>>> rename to drivers/media/platform/mediatek/mtk-vcodec/vdec_drv_base.h
>>>>> diff --git a/drivers/media/platform/mtk-vcodec/vdec_drv_if.c b/drivers/media/platform/mediatek/mtk-vcodec/vdec_drv_if.c
>>>>> similarity index 100%
>>>>> rename from drivers/media/platform/mtk-vcodec/vdec_drv_if.c
>>>>> rename to drivers/media/platform/mediatek/mtk-vcodec/vdec_drv_if.c
>>>>> diff --git a/drivers/media/platform/mtk-vcodec/vdec_drv_if.h b/drivers/media/platform/mediatek/mtk-vcodec/vdec_drv_if.h
>>>>> similarity index 100%
>>>>> rename from drivers/media/platform/mtk-vcodec/vdec_drv_if.h
>>>>> rename to drivers/media/platform/mediatek/mtk-vcodec/vdec_drv_if.h
>>>>> diff --git a/drivers/media/platform/mtk-vcodec/vdec_ipi_msg.h b/drivers/media/platform/mediatek/mtk-vcodec/vdec_ipi_msg.h
>>>>> similarity index 100%
>>>>> rename from drivers/media/platform/mtk-vcodec/vdec_ipi_msg.h
>>>>> rename to drivers/media/platform/mediatek/mtk-vcodec/vdec_ipi_msg.h
>>>>> diff --git a/drivers/media/platform/mtk-vcodec/vdec_msg_queue.c b/drivers/media/platform/mediatek/mtk-vcodec/vdec_msg_queue.c
>>>>> similarity index 100%
>>>>> rename from drivers/media/platform/mtk-vcodec/vdec_msg_queue.c
>>>>> rename to drivers/media/platform/mediatek/mtk-vcodec/vdec_msg_queue.c
>>>>> diff --git a/drivers/media/platform/mtk-vcodec/vdec_msg_queue.h b/drivers/media/platform/mediatek/mtk-vcodec/vdec_msg_queue.h
>>>>> similarity index 100%
>>>>> rename from drivers/media/platform/mtk-vcodec/vdec_msg_queue.h
>>>>> rename to drivers/media/platform/mediatek/mtk-vcodec/vdec_msg_queue.h
>>>>> diff --git a/drivers/media/platform/mtk-vcodec/vdec_vpu_if.c b/drivers/media/platform/mediatek/mtk-vcodec/vdec_vpu_if.c
>>>>> similarity index 100%
>>>>> rename from drivers/media/platform/mtk-vcodec/vdec_vpu_if.c
>>>>> rename to drivers/media/platform/mediatek/mtk-vcodec/vdec_vpu_if.c
>>>>> diff --git a/drivers/media/platform/mtk-vcodec/vdec_vpu_if.h b/drivers/media/platform/mediatek/mtk-vcodec/vdec_vpu_if.h
>>>>> similarity index 100%
>>>>> rename from drivers/media/platform/mtk-vcodec/vdec_vpu_if.h
>>>>> rename to drivers/media/platform/mediatek/mtk-vcodec/vdec_vpu_if.h
>>>>> diff --git a/drivers/media/platform/mtk-vcodec/venc/venc_h264_if.c b/drivers/media/platform/mediatek/mtk-vcodec/venc/venc_h264_if.c
>>>>> similarity index 100%
>>>>> rename from drivers/media/platform/mtk-vcodec/venc/venc_h264_if.c
>>>>> rename to drivers/media/platform/mediatek/mtk-vcodec/venc/venc_h264_if.c
>>>>> diff --git a/drivers/media/platform/mtk-vcodec/venc/venc_vp8_if.c b/drivers/media/platform/mediatek/mtk-vcodec/venc/venc_vp8_if.c
>>>>> similarity index 100%
>>>>> rename from drivers/media/platform/mtk-vcodec/venc/venc_vp8_if.c
>>>>> rename to drivers/media/platform/mediatek/mtk-vcodec/venc/venc_vp8_if.c
>>>>> diff --git a/drivers/media/platform/mtk-vcodec/venc_drv_base.h b/drivers/media/platform/mediatek/mtk-vcodec/venc_drv_base.h
>>>>> similarity index 100%
>>>>> rename from drivers/media/platform/mtk-vcodec/venc_drv_base.h
>>>>> rename to drivers/media/platform/mediatek/mtk-vcodec/venc_drv_base.h
>>>>> diff --git a/drivers/media/platform/mtk-vcodec/venc_drv_if.c b/drivers/media/platform/mediatek/mtk-vcodec/venc_drv_if.c
>>>>> similarity index 100%
>>>>> rename from drivers/media/platform/mtk-vcodec/venc_drv_if.c
>>>>> rename to drivers/media/platform/mediatek/mtk-vcodec/venc_drv_if.c
>>>>> diff --git a/drivers/media/platform/mtk-vcodec/venc_drv_if.h b/drivers/media/platform/mediatek/mtk-vcodec/venc_drv_if.h
>>>>> similarity index 100%
>>>>> rename from drivers/media/platform/mtk-vcodec/venc_drv_if.h
>>>>> rename to drivers/media/platform/mediatek/mtk-vcodec/venc_drv_if.h
>>>>> diff --git a/drivers/media/platform/mtk-vcodec/venc_ipi_msg.h b/drivers/media/platform/mediatek/mtk-vcodec/venc_ipi_msg.h
>>>>> similarity index 100%
>>>>> rename from drivers/media/platform/mtk-vcodec/venc_ipi_msg.h
>>>>> rename to drivers/media/platform/mediatek/mtk-vcodec/venc_ipi_msg.h
>>>>> diff --git a/drivers/media/platform/mtk-vcodec/venc_vpu_if.c b/drivers/media/platform/mediatek/mtk-vcodec/venc_vpu_if.c
>>>>> similarity index 100%
>>>>> rename from drivers/media/platform/mtk-vcodec/venc_vpu_if.c
>>>>> rename to drivers/media/platform/mediatek/mtk-vcodec/venc_vpu_if.c
>>>>> diff --git a/drivers/media/platform/mtk-vcodec/venc_vpu_if.h b/drivers/media/platform/mediatek/mtk-vcodec/venc_vpu_if.h
>>>>> similarity index 100%
>>>>> rename from drivers/media/platform/mtk-vcodec/venc_vpu_if.h
>>>>> rename to drivers/media/platform/mediatek/mtk-vcodec/venc_vpu_if.h
>>>>   
>>>
>>>
>>>
>>> Thanks,
>>> Mauro
>>
>>
> 
> 
> 
> Thanks,
> Mauro


