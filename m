Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67BD74D7E09
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 10:01:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237775AbiCNJCc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 05:02:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237788AbiCNJCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 05:02:19 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EBC342A32;
        Mon, 14 Mar 2022 02:01:03 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id DEE661F43B23
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1647248461;
        bh=oPfRK2FlwSAxSpdbLvSWmWhgfzN2gWEN45IqscDe+ks=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=MgZCFoLmTFJGMbknh/8pjSR/JiUHD+6YaHFhKIVmrBhpIBcBYt9IFSW5i0ncGVp+m
         JKf2Nlu29xtCS2ueo+4WCVabQN40X3r9W24iLPvekAJoTnETCwpdr0gY5qp6dtnM7i
         OsJboo2zNhr6vAcf/S7SRi+dHu4PpAPnZGYJ4+cGjachXrtMBZRx96IhZzx2P3nBj5
         vmkj/8C3nd3ynT4TF5rKLD/cNy7rpXt/BIxBhLfdwtHPpFyZvMfdvoRV0B6M9ZSFzN
         +nV/waCUpEP/IjqvwAnt4pdWqr/1d16RM4i1DrSWEuX8bW782zjK3j11qjarOUbIRE
         h3KWww5Xz6WMw==
Message-ID: <db4d4b19-0c44-0bad-3544-01237bbb6c07@collabora.com>
Date:   Mon, 14 Mar 2022 10:00:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH 4/5] ASoC: mediatek: mt8195: add machine driver with
 mt6359, max98390 and rt5682
Content-Language: en-US
To:     Trevor Wu <trevor.wu@mediatek.com>, broonie@kernel.org,
        tiwai@suse.com, robh+dt@kernel.org, matthias.bgg@gmail.com
Cc:     alsa-devel@alsa-project.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, aaronyu@google.com,
        yc.hung@mediatek.com
References: <20220308072435.22460-1-trevor.wu@mediatek.com>
 <20220308072435.22460-5-trevor.wu@mediatek.com>
 <e812796f-6b9b-fe9d-50a7-b681d7b174fd@collabora.com>
 <5fafa7d8a23fbdce82272529d817816f42c4ac37.camel@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <5fafa7d8a23fbdce82272529d817816f42c4ac37.camel@mediatek.com>
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

Il 12/03/22 17:18, Trevor Wu ha scritto:
> On Thu, 2022-03-10 at 16:21 +0100, AngeloGioacchino Del Regno wrote:
>> Il 08/03/22 08:24, Trevor Wu ha scritto:
>>> This patch adds support for mt8195 board with mt6359, max98390 and
>>> rt5682.
>>>
>>> Signed-off-by: Trevor Wu <trevor.wu@mediatek.com>
>>
>> Hello Trevor,
>> thanks for the patch! However, there's something to improve...
>>
>>> ---
>>>    sound/soc/mediatek/Kconfig                    |   16 +
>>>    sound/soc/mediatek/mt8195/Makefile            |    5 +
>>>    .../mt8195/mt8195-mt6359-max98390-rt5682.c    | 1058
>>> +++++++++++++++++
>>>    3 files changed, 1079 insertions(+)
>>>    create mode 100644 sound/soc/mediatek/mt8195/mt8195-mt6359-
>>> max98390-rt5682.c
>>>    
>>>
> 
> [...]
>>> +
>>> +static const struct snd_soc_dapm_widget
>>> +	mt8195_mt6359_max98390_rt5682_widgets[] = {
>>> +	SND_SOC_DAPM_SPK("Left Speaker", NULL),
>>> +	SND_SOC_DAPM_SPK("Right Speaker", NULL),
>>> +	SND_SOC_DAPM_HP("Headphone Jack", NULL),
>>
>> We can at least partially reuse existing UCM2 configuration if you
>> slightly change the names for these controls.
>>
> 
> I don't know what the UCM2 configuration means.
> Could you give me more information?
> 

UCM == Use Case Manager;
In short, it's userspace (alsa-lib) configuration for sound cards, allowing
to configure the various mixers for various usecases (speaker/headphone/HDMI
playback, headset/internal microphone, etc).

Check this GitHub repository for more information:
https://github.com/alsa-project/alsa-ucm-conf/tree/master/ucm2

> 
>> Specifically, MAX98090 (yes I know it's a different codec) has names
>> "Speaker Left", "Speaker Right" instead, we will be able to at least
>> partially reuse these (or get uniform naming, which is still good).
>> As for the "Headphone Jack", it's simply "Headphone".
>>
>> Please note that the actual control names in userspace will be,
>> exactly,
>>
>> "Speaker Left Switch", "Speaker Right Switch",
>> "Headphone Left Switch", "Headphone Right Switch"...
>>
>> ....where "Switch" gets automatically appended because of the control
>> type.
>>
>>> +	SND_SOC_DAPM_MIC("Headset Mic", NULL),
>>
>> This "Headset Mic" name is fine.
>>
>>> +	SND_SOC_DAPM_MIXER(SOF_DMA_DL2, SND_SOC_NOPM, 0, 0, NULL, 0),
>>> +	SND_SOC_DAPM_MIXER(SOF_DMA_DL3, SND_SOC_NOPM, 0, 0, NULL, 0),
>>> +	SND_SOC_DAPM_MIXER(SOF_DMA_UL4, SND_SOC_NOPM, 0, 0, NULL, 0),
>>> +	SND_SOC_DAPM_MIXER(SOF_DMA_UL5, SND_SOC_NOPM, 0, 0, NULL, 0),
>>> +};
>>> +
> [...]
>>> +
>>> +static struct snd_soc_dai_link
>>> mt8195_mt6359_max98390_rt5682_dai_links[] = {
>>
>>
>> ... again, different name, same contents ...
>>
>>
>> And I won't go on repeating the same thing over and over again.
>> I think that the best idea here is to either create a mt8195-mt6359-
>> rt5682-common.c
>> file, or to rename the others to something else and get them all in
>> the same file.
>>
>>
>> Regards,
>> Angelo
> 
> Hi Angelo,
> 
> Thanks for your review.
> Please forgive me for deleting some comments above.
> I totally agree that most code can be reused.
> I will try revising and merging all mt8195 machine drivers in a file.

No worries. Looking forward to see the next version.
Thank you!

Regards,
Angelo

> 
> Thanks,
> Trevor
> 


