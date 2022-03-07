Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 448724CF441
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 10:07:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234008AbiCGJIr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 04:08:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233162AbiCGJIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 04:08:45 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA4D6DF55;
        Mon,  7 Mar 2022 01:07:50 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 2631B1F43859
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1646644069;
        bh=mKuKc24peBTHJq96oPXVMVEPFG1UMKdTfUdLfSGxtH0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=S+nr6l6ud+gdKu5ahDRDne/nb8H6YRD77OPWBF4KsxIFPSWoe0DszZrrWihtjWXaT
         KIcAbqgmYkYHkpqe6Z6JIVmXD00hmusob2Umsc2496UYcKdboInRXDfzCggoz19RLR
         yUcKjJLTR5n9L4ijWAvo0cXjEp1LFJ2idl8PREEPXlHFCtEDOHQS3xaoyiRnW2c6Is
         Tx6TPN7W1wrUrHC8GJH3UPzLbd3U+G4/vlXNJyg0fofeJG/E+3SOzatheWUZxcRDZa
         SK2WUgGituRC1LNkpgBKcCC0WJyGTNKbC2Oj4PfAu+ykatmh19xUR76VCfEYLa1aZ8
         g2zwcLTBmrPYA==
Message-ID: <e2299a96-9f91-0ca3-1617-18029b3940d2@collabora.com>
Date:   Mon, 7 Mar 2022 10:07:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [v2 01/17] ASoC: mediatek: mt6366: add codec driver
Content-Language: en-US
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
 <b22976ee-6426-cabf-f153-fbe093611e97@collabora.com>
 <6555d89deb9087825f865b9d4265f07465e7ae09.camel@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <6555d89deb9087825f865b9d4265f07465e7ae09.camel@mediatek.com>
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

Il 05/03/22 05:24, Jiaxin Yu ha scritto:
> On Fri, 2022-02-18 at 15:54 +0100, AngeloGioacchino Del Regno wrote:
>> Il 17/02/22 14:41, Jiaxin Yu ha scritto:
>>> Mt6366 is a new version of mt6358, and they are same about audio
>>> part.
>>> So we can reuse the driver of mt6358.
>>>
>>> Signed-off-by: Jiaxin Yu <jiaxin.yu@mediatek.com>
>>
>> Hello Jiaxin,
>> I'm sorry but this commit makes very little sense.
>>
>> If you want to advertise MT6366 support, please write a note and/or
>> a new compatible string inside of the mt6358 driver (and dt-
>> bindings),
>> then, please drop this commit.
>>
> 
> Hello angelogioacchino,
> 
> Thank you for your advice.
> 
> If I add a new compatible string inside of the mt6358 driver and dt-
> bindings, then the machine driver which want to use mt6366 should
> select SND_SOC_MT6358.
> 
> like below:
> 
> config SND_SOC_MT8186_MT6366_DA7219_MAX98357
> 	tristate "ASoC Audio driver for MT8186 with DA7219 MAX98357A
> codec"
>   	depends on I2C && GPIOLIB
>   	depends on SND_SOC_MT8186 && MTK_PMIC_WRAP
>   	select SND_SOC_MT6366   ==> SND_SOC_MT6358
> 	...
> 
> I just doubt it's enough to make sense. I originally wanted to put this
> relationship in the sound/soc/codecs layer. So that this relationship
> is not perceived by users(machine driver).
> However, if the general practice is like this, I will adopt your
> suggestion. Thank you again.
> 

Yes this is acceptable, please do it like that.

Thanks,
Angelo

>>
>>> ---
>>>    sound/soc/codecs/Kconfig  | 8 ++++++++
>>>    sound/soc/codecs/Makefile | 1 +
>>>    2 files changed, 9 insertions(+)
>>>
>>> diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
>>> index 8fa24783ce01..6631094678f5 100644
>>> --- a/sound/soc/codecs/Kconfig
>>> +++ b/sound/soc/codecs/Kconfig
>>> @@ -132,6 +132,7 @@ config SND_SOC_ALL_CODECS
>>>    	imply SND_SOC_MT6351
>>>    	imply SND_SOC_MT6358
>>>    	imply SND_SOC_MT6359
>>> +	imply SND_SOC_MT6366
>>>    	imply SND_SOC_MT6660
>>>    	imply SND_SOC_NAU8315
>>>    	imply SND_SOC_NAU8540
>>> @@ -1888,6 +1889,13 @@ config SND_SOC_MT6359_ACCDET
>>>    	  for ASoC codec soc-jack detection mechanism.
>>>    	  Select N if you don't have jack on board.
>>>    
>>> +config SND_SOC_MT6366
>>> +	tristate "MediaTek MT6366 Codec"
>>> +	depends on MTK_PMIC_WRAP
>>> +	help
>>> +	  Enable support for the platform which uses MT6366 as
>>> +	  external codec device.
>>> +
>>>    config SND_SOC_MT6660
>>>    	tristate "Mediatek MT6660 Speaker Amplifier"
>>>    	depends on I2C
>>> diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
>>> index 42d00aa4ee46..1279684feaf0 100644
>>> --- a/sound/soc/codecs/Makefile
>>> +++ b/sound/soc/codecs/Makefile
>>> @@ -465,6 +465,7 @@ obj-$(CONFIG_SND_SOC_MT6351)	+= snd-soc-
>>> mt6351.o
>>>    obj-$(CONFIG_SND_SOC_MT6358)	+= snd-soc-mt6358.o
>>>    obj-$(CONFIG_SND_SOC_MT6359)	+= snd-soc-mt6359.o
>>>    obj-$(CONFIG_SND_SOC_MT6359_ACCDET) += mt6359-accdet.o
>>> +obj-$(CONFIG_SND_SOC_MT6366)	+= snd-soc-mt6358.o
>>>    obj-$(CONFIG_SND_SOC_MT6660)	+= snd-soc-mt6660.o
>>>    obj-$(CONFIG_SND_SOC_NAU8315)   += snd-soc-nau8315.o
>>>    obj-$(CONFIG_SND_SOC_NAU8540)   += snd-soc-nau8540.o
>>
>>
> 

