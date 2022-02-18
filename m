Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D8FD4BBB06
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 15:54:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236200AbiBROyc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 09:54:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233795AbiBROyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 09:54:31 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50E8154FA5;
        Fri, 18 Feb 2022 06:54:14 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id BDAD81F46B85
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1645196052;
        bh=waAoYQrd/zon1ObYSebR32rz8jo/+xh5mii/0mQIta0=;
        h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
        b=J+5IrzL1aUstLqU1jHWBQ5y184NmlTZ1BA8PdukNZ1FcXWUD9gFtXQDbbh9hfmF7u
         XxavwG7XoNIZ/APJ3iwjJt2CEguvvFNPMJ3sLk3pv+0qQAPXSmMvULlrQXg3SO4gbo
         3Z/4jfHGHpKS8E1Fprko/SPC3zn8RurvHt5ukJ4JRaSQstIYUbnPtnk1caRtn/Z6j3
         mGRmknFUMigs7RnN/+87mHydSLVl3zdzY9lMnJ3ZbVNv9ze63b9spIfQWUoqKZIKYn
         dDJA5v4hjnLwnnBTW87vYzingVYERkjLoNe8JLafl1IJCK7JkVQZiXiUUQblhX00/T
         +J+n0x5OarDQg==
Message-ID: <b22976ee-6426-cabf-f153-fbe093611e97@collabora.com>
Date:   Fri, 18 Feb 2022 15:54:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [v2 01/17] ASoC: mediatek: mt6366: add codec driver
To:     Jiaxin Yu <jiaxin.yu@mediatek.com>, broonie@kernel.org
Cc:     lgirdwood@gmail.com, tiwai@suse.com, robh+dt@kernel.org,
        matthias.bgg@gmail.com, perex@perex.cz, p.zabel@pengutronix.de,
        geert+renesas@glider.be, trevor.wu@mediatek.com,
        tzungbi@google.com, aaronyu@google.com, zhangqilong3@huawei.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220217134205.15400-1-jiaxin.yu@mediatek.com>
 <20220217134205.15400-2-jiaxin.yu@mediatek.com>
Content-Language: en-US
In-Reply-To: <20220217134205.15400-2-jiaxin.yu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 17/02/22 14:41, Jiaxin Yu ha scritto:
> Mt6366 is a new version of mt6358, and they are same about audio part.
> So we can reuse the driver of mt6358.
> 
> Signed-off-by: Jiaxin Yu <jiaxin.yu@mediatek.com>

Hello Jiaxin,
I'm sorry but this commit makes very little sense.

If you want to advertise MT6366 support, please write a note and/or
a new compatible string inside of the mt6358 driver (and dt-bindings),
then, please drop this commit.


> ---
>   sound/soc/codecs/Kconfig  | 8 ++++++++
>   sound/soc/codecs/Makefile | 1 +
>   2 files changed, 9 insertions(+)
> 
> diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
> index 8fa24783ce01..6631094678f5 100644
> --- a/sound/soc/codecs/Kconfig
> +++ b/sound/soc/codecs/Kconfig
> @@ -132,6 +132,7 @@ config SND_SOC_ALL_CODECS
>   	imply SND_SOC_MT6351
>   	imply SND_SOC_MT6358
>   	imply SND_SOC_MT6359
> +	imply SND_SOC_MT6366
>   	imply SND_SOC_MT6660
>   	imply SND_SOC_NAU8315
>   	imply SND_SOC_NAU8540
> @@ -1888,6 +1889,13 @@ config SND_SOC_MT6359_ACCDET
>   	  for ASoC codec soc-jack detection mechanism.
>   	  Select N if you don't have jack on board.
>   
> +config SND_SOC_MT6366
> +	tristate "MediaTek MT6366 Codec"
> +	depends on MTK_PMIC_WRAP
> +	help
> +	  Enable support for the platform which uses MT6366 as
> +	  external codec device.
> +
>   config SND_SOC_MT6660
>   	tristate "Mediatek MT6660 Speaker Amplifier"
>   	depends on I2C
> diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
> index 42d00aa4ee46..1279684feaf0 100644
> --- a/sound/soc/codecs/Makefile
> +++ b/sound/soc/codecs/Makefile
> @@ -465,6 +465,7 @@ obj-$(CONFIG_SND_SOC_MT6351)	+= snd-soc-mt6351.o
>   obj-$(CONFIG_SND_SOC_MT6358)	+= snd-soc-mt6358.o
>   obj-$(CONFIG_SND_SOC_MT6359)	+= snd-soc-mt6359.o
>   obj-$(CONFIG_SND_SOC_MT6359_ACCDET) += mt6359-accdet.o
> +obj-$(CONFIG_SND_SOC_MT6366)	+= snd-soc-mt6358.o
>   obj-$(CONFIG_SND_SOC_MT6660)	+= snd-soc-mt6660.o
>   obj-$(CONFIG_SND_SOC_NAU8315)   += snd-soc-nau8315.o
>   obj-$(CONFIG_SND_SOC_NAU8540)   += snd-soc-nau8540.o


