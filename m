Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E7E452CEA1
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 10:49:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235573AbiESIta (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 04:49:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbiESIt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 04:49:28 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AD989C2E7;
        Thu, 19 May 2022 01:49:27 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 2D2E71F457DA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652950165;
        bh=LIEE/DC/g0SkHl+EFOTJ13O6qGxGzI1hYQZDDR7zMDM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=TUYPhKQytOflfHPzajhaBGNY1IwPJBUdEVigdX+ahYs0xUJ23UwS0YMy9VpeSYcAQ
         W/C3F9Rwg8tapasSwQChQ2giLkiK3c2EbTHgvWdcbV145Vs5EsVlbtBHcjvhD85o6u
         8NP20JplXkGE4vxfrOAvujfc9daEmzfmba86ISQSXaB0BQUUlnPNv9VNzu7Hc2E2oq
         LJmmUwyAOaDV01JP2vwcsRtccSkSnK+n0PE1yvjcKPiqQBLGkSngrBJ1b/W3107SM+
         bcRsTGGSf1NzHfiLaLi7EUs3/+xo68zw55mTFaFDb0+uTrDrh8GBjAzbKvkgF2FN02
         KT47s4uNzi03Q==
Message-ID: <a253f338-c162-17b8-f412-95cd63195151@collabora.com>
Date:   Thu, 19 May 2022 10:49:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v2 7/7] clk: mediatek: Add MediaTek Helio X10 MT6795 clock
 drivers
Content-Language: en-US
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     Miles Chen <miles.chen@mediatek.com>, bgolaszewski@baylibre.com,
        chun-jie.chen@mediatek.com, ck.hu@mediatek.com,
        devicetree@vger.kernel.org, fparent@baylibre.com,
        ikjn@chromium.org, jason-jh.lin@mediatek.com, kernel@collabora.com,
        konrad.dybcio@somainline.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        marijn.suijten@somainline.org, martin.botka@somainline.org,
        matthias.bgg@gmail.com, mturquette@baylibre.com,
        p.zabel@pengutronix.de, paul.bouchara@somainline.org,
        phone-devel@vger.kernel.org, rex-bc.chen@mediatek.com,
        robh+dt@kernel.org, sam.shih@mediatek.com, sboyd@kernel.org,
        tinghan.shen@mediatek.com, weiyi.lu@mediatek.com,
        y.oudjana@protonmail.com, ~postmarketos/upstreaming@lists.sr.ht
References: <20220518111652.223727-8-angelogioacchino.delregno@collabora.com>
 <20220519045340.11198-1-miles.chen@mediatek.com>
 <11bf21cd-85c4-f64c-2af7-7695e71aee07@collabora.com>
 <CAGXv+5H4gF5GXzfk8mjkG4Kry8uCs1CQbKoViBuc9LC+XdHH=A@mail.gmail.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <CAGXv+5H4gF5GXzfk8mjkG4Kry8uCs1CQbKoViBuc9LC+XdHH=A@mail.gmail.com>
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

Il 19/05/22 10:37, Chen-Yu Tsai ha scritto:
> On Thu, May 19, 2022 at 4:17 PM AngeloGioacchino Del Regno
> <angelogioacchino.delregno@collabora.com> wrote:
>>
>> Il 19/05/22 06:53, Miles Chen ha scritto:
>>>
>>> Hi Angelo,
>>>
>>>> Add the clock drivers for the entire clock tree of MediaTek Helio X10
>>>> MT6795, including system clocks (apmixedsys, infracfg, pericfg, topckgen)
>>>> and multimedia clocks (mmsys, mfg, vdecsys, vencsys).
>>>>
>>>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>>>> ---
>>>> drivers/clk/mediatek/Kconfig                 |  37 ++
>>>> drivers/clk/mediatek/Makefile                |   6 +
>>>> drivers/clk/mediatek/clk-mt6795-apmixedsys.c | 157 +++++
>>>> drivers/clk/mediatek/clk-mt6795-infracfg.c   | 148 +++++
>>>> drivers/clk/mediatek/clk-mt6795-mfg.c        |  50 ++
>>>> drivers/clk/mediatek/clk-mt6795-mm.c         | 106 ++++
>>>> drivers/clk/mediatek/clk-mt6795-pericfg.c    | 160 +++++
>>>> drivers/clk/mediatek/clk-mt6795-topckgen.c   | 611 +++++++++++++++++++
>>>> drivers/clk/mediatek/clk-mt6795-vdecsys.c    |  55 ++
>>>> drivers/clk/mediatek/clk-mt6795-vencsys.c    |  50 ++
>>>> 10 files changed, 1380 insertions(+)
>>>> create mode 100644 drivers/clk/mediatek/clk-mt6795-apmixedsys.c
>>>> create mode 100644 drivers/clk/mediatek/clk-mt6795-infracfg.c
>>>> create mode 100644 drivers/clk/mediatek/clk-mt6795-mfg.c
>>>> create mode 100644 drivers/clk/mediatek/clk-mt6795-mm.c
>>>> create mode 100644 drivers/clk/mediatek/clk-mt6795-pericfg.c
>>>> create mode 100644 drivers/clk/mediatek/clk-mt6795-topckgen.c
>>>> create mode 100644 drivers/clk/mediatek/clk-mt6795-vdecsys.c
>>>> create mode 100644 drivers/clk/mediatek/clk-mt6795-vencsys.c
>>>>
>>>> diff --git a/drivers/clk/mediatek/Kconfig b/drivers/clk/mediatek/Kconfig
>>>> index d5936cfb3bee..da8142dff3c3 100644
>>>> --- a/drivers/clk/mediatek/Kconfig
>>>> +++ b/drivers/clk/mediatek/Kconfig
>>>> @@ -259,6 +259,43 @@ config COMMON_CLK_MT6779_AUDSYS
>>>>       help
>>>>         This driver supports Mediatek MT6779 audsys clocks.
>>>>
>>>> +config COMMON_CLK_MT6795
>>>> +    tristate "Clock driver for MediaTek MT6795"
>>>> +    depends on ARCH_MEDIATEK || COMPILE_TEST
>>>> +    select COMMON_CLK_MEDIATEK
>>>> +    default ARCH_MEDIATEK
>>>> +    help
>>>> +      This driver supports MediaTek MT6795 basic clocks and clocks
>>>> +      required for various peripherals found on MediaTek.
>>>
>>> Thanks for doing this, I was wondering if we can use only COMMON_CLK_MT6795 to build all
>>> clk-mt6795-*? like CONFIG_COMMON_CLK_MT8195 style:
>>>
>>> obj-$(CONFIG_COMMON_CLK_MT8195) += clk-mt8195-apmixedsys.o clk-mt8195-topckgen.o \
>>>                                   clk-mt8195-peri_ao.o clk-mt8195-infra_ao.o \
>>>                                   clk-mt8195-cam.o clk-mt8195-ccu.o clk-mt8195-img.o \
>>>                                   clk-mt8195-ipe.o clk-mt8195-mfg.o clk-mt8195-scp_adsp.o \
>>>                                   clk-mt8195-vdec.o clk-mt8195-vdo0.o clk-mt8195-vdo1.o \
>>>                                   clk-mt8195-venc.o clk-mt8195-vpp0.o clk-mt8195-vpp1.o \
>>>                                   clk-mt8195-wpe.o clk-mt8195-imp_iic_wrap.o \
>>>                                   clk-mt8195-apusys_pll.o
>>>
>>> So we do not have to keep other COMMON_CLK_MT6795_* configs.
>>>
>>
>> I don't think that this would bring any benefit - it's the opposite, if anything!
>>
>> Think about platforms that don't need any ISP functionality, or are headless (hence
>> not requiring anything for dsi/hdmi/dp and display and/or media generally): what
>> I've done is splitting the clock drivers that are critical for any functionality
>> of the SoC to the ones that are enabling "facultative" functionality.
>>
>> Hence, the usecases for this kind of splitting are:
>> 1. Somewhat rare (corner) cases: someone may not want to compile in any of the
>>      mm/venc/vdec/mfg clock drivers because they don't need the functionality at
>>      all (probably, including the other related drivers), or;
>> 2. It would be possible to compile as built-in only the "main" drivers (apmixed,
>>      infra, peri, topck) to achieve a boot (ex.: you need eMMC to boot, at least)
>>      and then compile the mm/venc/vdec/mfg as modules to be loaded after mounting
>>      a rootfs (where you probably also have mediatek-drm, vcodec, etc as modules).
> 
> I assume you mean split them into two groups:
> 
>    - essential for booting to a state capable of loading modules from storage
>      So apmixedsys + topckgen + infra_ao + peri_ao + imp_iic_wrap (maybe?)
>    - everything else
> 
> The whole MT8195 clock driver suite is roughly 70KB, with half of that for
> the four essential clock drivers.
> 
> If the system is really that limited in storage, you probably are already
> running a highly customized config and build system. And kind of doesn't
> make sense that that is a real limitation for the larger chips like the
> MT8195.
> 
> IMO having two Kconfig symbols for one chip is still much better than
> having ten though.
> 

For MT8195... and 92, 83, 73... and others from the same era, being them for
chromebooks, iot, smartphones and whatever else... yeah you're totally right.

The issue starts raising when looking at older SoCs featuring an older bootloader
that does have a kernel size limitation; for example, to make the loader happy on
MT6795, I had to strip the defconfig a lot and keep the Android-style boot.img
smaller than 10MB (that's Image.gz-dtb + ramdisk).

As for everything else, including newer platforms like MT8195...
I'm nitpicking now, but being able to have a smaller kernel image means less time
spent on loading from storage and less decompression time: but that specific one
would be a broad discussion with too many variables to consider, so... again,
read that as something very nitpicking and nothing else :-)

>> For this reason, I would propose to actually split the MT8195 clocks as well
>> and the ones for other models to achieve what I explained so that, in the future,
>> when this entire framework will fully support (read: fully tested) modularity,
>> we will be able to set these to compile as module by default, which would greatly
>> reduce the kernel size.
>> That's important, not only for MediaTek SoCs, but also for others (nxp, qcom, etc)
>> that don't need MediaTek clock drivers at all, since upstream we build one kernel
>> image for all, and not specialized images.
> 
> AFAIK the upstream defconfig was never intended for end users to directly
> consume. It is only there for all the automated testing. End users should
> either generate their own config, or have their distros come up with
> something sane, like building everything as modules. The soc maintainers
> (if not Linus) were quite clear about this.
> 

I appreciate the reminder, but I think that CIs are already able to ship modules
during testing, and for compile-test purposes, it would probably even make more
sense to compile as module (as that's where things sometimes start failing: see
what we're doing here...), but I'm not arguing anyway.

Cheers,
Angelo


