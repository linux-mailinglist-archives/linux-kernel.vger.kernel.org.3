Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A3A452CE2C
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 10:20:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235348AbiESIS4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 04:18:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235360AbiESISZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 04:18:25 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A74F674C2;
        Thu, 19 May 2022 01:17:55 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 381B91F456C5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652948273;
        bh=eD2ru9XjyXdFYpgVa6vCzArC7QokELVFLBgVpk9fE5k=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=bLpM9O1gomsPgvpgDyaAvmQUgJV/gnrLklryRv/G3NT5w0WWNtYAqVe/2kJ1dHzPp
         UFqkcP0CSEiCzUy9GyqKewPXkaKFz8ImtQfSEL411GT3GSVZBNBDLO23zd3SGBS0Zl
         anzhjL1Xr3pLMqtcJ2nSH8m6TKeYC0B0mrwPs52hP6ZRoe9YU4OWRv5zuYDccZFh6c
         piqVr+Ct3kUW7tgChrd0Rm9Tw3OiZMjZeHhMztzQwcDnaWrARSqiD57m04O+i7dsb3
         4s5vz2UK4ywVyPCXQORcvzN1jvzoRid3cme4M+ynzTnIWLZngVFlY+NiuZPOdTd2q7
         sjnzjf7+tBK2Q==
Message-ID: <11bf21cd-85c4-f64c-2af7-7695e71aee07@collabora.com>
Date:   Thu, 19 May 2022 10:17:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v2 7/7] clk: mediatek: Add MediaTek Helio X10 MT6795 clock
 drivers
Content-Language: en-US
To:     Miles Chen <miles.chen@mediatek.com>
Cc:     bgolaszewski@baylibre.com, chun-jie.chen@mediatek.com,
        ck.hu@mediatek.com, devicetree@vger.kernel.org,
        fparent@baylibre.com, ikjn@chromium.org, jason-jh.lin@mediatek.com,
        kernel@collabora.com, konrad.dybcio@somainline.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        marijn.suijten@somainline.org, martin.botka@somainline.org,
        matthias.bgg@gmail.com, mturquette@baylibre.com,
        p.zabel@pengutronix.de, paul.bouchara@somainline.org,
        phone-devel@vger.kernel.org, rex-bc.chen@mediatek.com,
        robh+dt@kernel.org, sam.shih@mediatek.com, sboyd@kernel.org,
        tinghan.shen@mediatek.com, weiyi.lu@mediatek.com,
        wenst@chromium.org, y.oudjana@protonmail.com,
        ~postmarketos/upstreaming@lists.sr.ht
References: <20220518111652.223727-8-angelogioacchino.delregno@collabora.com>
 <20220519045340.11198-1-miles.chen@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220519045340.11198-1-miles.chen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 19/05/22 06:53, Miles Chen ha scritto:
> 
> Hi Angelo,
> 
>> Add the clock drivers for the entire clock tree of MediaTek Helio X10
>> MT6795, including system clocks (apmixedsys, infracfg, pericfg, topckgen)
>> and multimedia clocks (mmsys, mfg, vdecsys, vencsys).
>>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> ---
>> drivers/clk/mediatek/Kconfig                 |  37 ++
>> drivers/clk/mediatek/Makefile                |   6 +
>> drivers/clk/mediatek/clk-mt6795-apmixedsys.c | 157 +++++
>> drivers/clk/mediatek/clk-mt6795-infracfg.c   | 148 +++++
>> drivers/clk/mediatek/clk-mt6795-mfg.c        |  50 ++
>> drivers/clk/mediatek/clk-mt6795-mm.c         | 106 ++++
>> drivers/clk/mediatek/clk-mt6795-pericfg.c    | 160 +++++
>> drivers/clk/mediatek/clk-mt6795-topckgen.c   | 611 +++++++++++++++++++
>> drivers/clk/mediatek/clk-mt6795-vdecsys.c    |  55 ++
>> drivers/clk/mediatek/clk-mt6795-vencsys.c    |  50 ++
>> 10 files changed, 1380 insertions(+)
>> create mode 100644 drivers/clk/mediatek/clk-mt6795-apmixedsys.c
>> create mode 100644 drivers/clk/mediatek/clk-mt6795-infracfg.c
>> create mode 100644 drivers/clk/mediatek/clk-mt6795-mfg.c
>> create mode 100644 drivers/clk/mediatek/clk-mt6795-mm.c
>> create mode 100644 drivers/clk/mediatek/clk-mt6795-pericfg.c
>> create mode 100644 drivers/clk/mediatek/clk-mt6795-topckgen.c
>> create mode 100644 drivers/clk/mediatek/clk-mt6795-vdecsys.c
>> create mode 100644 drivers/clk/mediatek/clk-mt6795-vencsys.c
>>
>> diff --git a/drivers/clk/mediatek/Kconfig b/drivers/clk/mediatek/Kconfig
>> index d5936cfb3bee..da8142dff3c3 100644
>> --- a/drivers/clk/mediatek/Kconfig
>> +++ b/drivers/clk/mediatek/Kconfig
>> @@ -259,6 +259,43 @@ config COMMON_CLK_MT6779_AUDSYS
>> 	help
>> 	  This driver supports Mediatek MT6779 audsys clocks.
>>
>> +config COMMON_CLK_MT6795
>> +	tristate "Clock driver for MediaTek MT6795"
>> +	depends on ARCH_MEDIATEK || COMPILE_TEST
>> +	select COMMON_CLK_MEDIATEK
>> +	default ARCH_MEDIATEK
>> +	help
>> +	  This driver supports MediaTek MT6795 basic clocks and clocks
>> +	  required for various peripherals found on MediaTek.
> 
> Thanks for doing this, I was wondering if we can use only COMMON_CLK_MT6795 to build all
> clk-mt6795-*? like CONFIG_COMMON_CLK_MT8195 style:
> 
> obj-$(CONFIG_COMMON_CLK_MT8195) += clk-mt8195-apmixedsys.o clk-mt8195-topckgen.o \
> 				   clk-mt8195-peri_ao.o clk-mt8195-infra_ao.o \
> 				   clk-mt8195-cam.o clk-mt8195-ccu.o clk-mt8195-img.o \
> 				   clk-mt8195-ipe.o clk-mt8195-mfg.o clk-mt8195-scp_adsp.o \
> 				   clk-mt8195-vdec.o clk-mt8195-vdo0.o clk-mt8195-vdo1.o \
> 				   clk-mt8195-venc.o clk-mt8195-vpp0.o clk-mt8195-vpp1.o \
> 				   clk-mt8195-wpe.o clk-mt8195-imp_iic_wrap.o \
> 				   clk-mt8195-apusys_pll.o
> 
> So we do not have to keep other COMMON_CLK_MT6795_* configs.
> 

I don't think that this would bring any benefit - it's the opposite, if anything!

Think about platforms that don't need any ISP functionality, or are headless (hence
not requiring anything for dsi/hdmi/dp and display and/or media generally): what
I've done is splitting the clock drivers that are critical for any functionality
of the SoC to the ones that are enabling "facultative" functionality.

Hence, the usecases for this kind of splitting are:
1. Somewhat rare (corner) cases: someone may not want to compile in any of the
    mm/venc/vdec/mfg clock drivers because they don't need the functionality at
    all (probably, including the other related drivers), or;
2. It would be possible to compile as built-in only the "main" drivers (apmixed,
    infra, peri, topck) to achieve a boot (ex.: you need eMMC to boot, at least)
    and then compile the mm/venc/vdec/mfg as modules to be loaded after mounting
    a rootfs (where you probably also have mediatek-drm, vcodec, etc as modules).

For this reason, I would propose to actually split the MT8195 clocks as well
and the ones for other models to achieve what I explained so that, in the future,
when this entire framework will fully support (read: fully tested) modularity,
we will be able to set these to compile as module by default, which would greatly
reduce the kernel size.
That's important, not only for MediaTek SoCs, but also for others (nxp, qcom, etc)
that don't need MediaTek clock drivers at all, since upstream we build one kernel
image for all, and not specialized images.

Regards,
Angelo


> 
> thanks,
> Miles
> 
>> +
>> +config COMMON_CLK_MT6795_MFGCFG
>> +	tristate "Clock driver for MediaTek MT6795 mfgcfg"
>> +	depends on COMMON_CLK_MT6795
>> +	default COMMON_CLK_MT6795
>> +	help
>> +	  This driver supports MediaTek MT6795 mfgcfg clocks.
>> +
>> +config COMMON_CLK_MT6795_MMSYS
>> +       tristate "Clock driver for MediaTek MT6795 mmsys"
>> +       depends on COMMON_CLK_MT6795
>> +	default COMMON_CLK_MT6795
>> +       help
>> +         This driver supports MediaTek MT6795 mmsys clocks.
>> +
>> +config COMMON_CLK_MT6795_VDECSYS
>> +	tristate "Clock driver for MediaTek MT6795 VDECSYS"
>> +	depends on COMMON_CLK_MT6795
>> +	default COMMON_CLK_MT6795
>> +	help
>> +	  This driver supports MediaTek MT6795 vdecsys clocks.
>> +
>> +config COMMON_CLK_MT6795_VENCSYS
>> +	tristate "Clock driver for MediaTek MT6795 VENCSYS"
>> +	depends on COMMON_CLK_MT6795
>> +	default COMMON_CLK_MT6795
>> +	help
>> +	  This driver supports MediaTek MT6795 vencsys clocks.
>> +
>> config COMMON_CLK_MT6797
>> 	bool "Clock driver for MediaTek MT6797"
>> 	depends on (ARCH_MEDIATEK && ARM64) || COMPILE_TEST
>> diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
>> index caf2ce93d666..57f0bf90e934 100644
>> --- a/drivers/clk/mediatek/Makefile
>> +++ b/drivers/clk/mediatek/Makefile
>> @@ -17,6 +17,12 @@ obj-$(CONFIG_COMMON_CLK_MT6779_VDECSYS) += clk-mt6779-vdec.o
>> obj-$(CONFIG_COMMON_CLK_MT6779_VENCSYS) += clk-mt6779-venc.o
>> obj-$(CONFIG_COMMON_CLK_MT6779_MFGCFG) += clk-mt6779-mfg.o
>> obj-$(CONFIG_COMMON_CLK_MT6779_AUDSYS) += clk-mt6779-aud.o
>> +obj-$(CONFIG_COMMON_CLK_MT6795) += clk-mt6795-apmixedsys.o clk-mt6795-infracfg.o \
>> +				   clk-mt6795-pericfg.o clk-mt6795-topckgen.o
>> +obj-$(CONFIG_COMMON_CLK_MT6795_MFGCFG) += clk-mt6795-mfg.o
>> +obj-$(CONFIG_COMMON_CLK_MT6795_MMSYS) += clk-mt6795-mm.o
>> +obj-$(CONFIG_COMMON_CLK_MT6795_VDECSYS) += clk-mt6795-vdecsys.o
>> +obj-$(CONFIG_COMMON_CLK_MT6795_VENCSYS) += clk-mt6795-vencsys.o
> 
> 
> 
>> obj-$(CONFIG_COMMON_CLK_MT6797) += clk-mt6797.o
>> obj-$(CONFIG_COMMON_CLK_MT6797_IMGSYS) += clk-mt6797-img.o
>> obj-$(CONFIG_COMMON_CLK_MT6797_MMSYS) += clk-mt6797-mm.o
>> diff --git a/drivers/clk/mediatek/clk-mt6795-apmixedsys.c b/drivers/clk/mediatek/clk-mt6795-apmixedsys.c
>> new file mode 100644
>> index 000000000000..766e83765cbb
>> --- /dev/null
>> +++ b/drivers/clk/mediatek/clk-mt6795-apmixedsys.c
>> @@ -0,0 +1,157 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*


