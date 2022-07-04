Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E9D0565052
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 11:06:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233542AbiGDJGw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 05:06:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232531AbiGDJGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 05:06:50 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1D53B7E7;
        Mon,  4 Jul 2022 02:06:49 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id BECD066015C4;
        Mon,  4 Jul 2022 10:06:47 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1656925608;
        bh=ZLaV/c/rcUgSuQPVP2rou6vYx2Qty36P/udcHxe9V40=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=khwsrNIdeMvoixIqNmkbZ3jCLNdaVHSmHSAIRQwlbY+zvpzs/v4XSY9GveHyRDJvh
         8B0n85T7AEPlmGjkqwUpr0aeApKoFXEr5pUcpn7+qj1JKrt+gGbMSa31twx3fqBPha
         8avirJFoTaK4HHAtJtJhV5S0TJcIiqzn9/WPsZHospgh6TTMaPpD4nWOUJjnjR1pzI
         OSOdAHGHqiUwan8MUQJIYgk/niuBMgNb+2pUvR3+00r3Rye8TxjDNG+9Tfbnp8Gd6Z
         2+QMhaK6oNKnMrfA+ebrS69u/+bDJMjzHeMRcBxC74jRsKXcsENErBguXR59FQS6iP
         uZGIiRg3jpQGw==
Message-ID: <623cb2a8-ff28-9bda-04a9-0c64c31616b1@collabora.com>
Date:   Mon, 4 Jul 2022 11:06:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 02/11] arm64: dts: mediatek: Introduce MT8195 Cherry
 platform's Tomato
Content-Language: en-US
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        hsinyi@chromium.org, allen-kh.cheng@mediatek.com, gtk3@inbox.ru,
        luca@z3ntu.xyz, sam.shih@mediatek.com, sean.wang@mediatek.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20220630153316.308767-1-angelogioacchino.delregno@collabora.com>
 <20220630153316.308767-3-angelogioacchino.delregno@collabora.com>
 <20220701221158.iuw5fehgkjrqw6zh@notapiano>
 <CAGXv+5FwDuUjbP4THBsXorps12in-=JUtB-4VO5ygDBuQn1SeQ@mail.gmail.com>
 <91e60954-d44d-f99f-2b4f-c164fb33cc0e@collabora.com>
 <CAGXv+5HUQ1pNSDqyiH8taec8ykeaztjNY5dQPKTcJPpYh5JS9g@mail.gmail.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <CAGXv+5HUQ1pNSDqyiH8taec8ykeaztjNY5dQPKTcJPpYh5JS9g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 04/07/22 11:05, Chen-Yu Tsai ha scritto:
> On Mon, Jul 4, 2022 at 4:59 PM AngeloGioacchino Del Regno
> <angelogioacchino.delregno@collabora.com> wrote:
>>
>> Il 04/07/22 06:17, Chen-Yu Tsai ha scritto:
>>> On Sat, Jul 2, 2022 at 6:12 AM Nícolas F. R. A. Prado
>>> <nfraprado@collabora.com> wrote:
>>>>
>>>> On Thu, Jun 30, 2022 at 05:33:07PM +0200, AngeloGioacchino Del Regno wrote:
>>>>> Introduce the MT8195 Cherry Chromebook platform, including three
>>>>> revisions of Cherry Tomato boards.
>>>>>
>>>>> This basic configuration allows to boot Linux on all board revisions
>>>>> and get a serial console from a ramdisk.
>>>>>
>>>>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>>>>> ---
>>>>>    arch/arm64/boot/dts/mediatek/Makefile         |  3 +++
>>>>>    .../dts/mediatek/mt8195-cherry-tomato-r1.dts  | 11 ++++++++
>>>>>    .../dts/mediatek/mt8195-cherry-tomato-r2.dts  | 11 ++++++++
>>>>>    .../dts/mediatek/mt8195-cherry-tomato-r3.dts  | 12 +++++++++
>>>>>    .../boot/dts/mediatek/mt8195-cherry.dtsi      | 26 +++++++++++++++++++
>>>>>    5 files changed, 63 insertions(+)
>>>>>    create mode 100644 arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r1.dts
>>>>>    create mode 100644 arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r2.dts
>>>>>    create mode 100644 arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r3.dts
>>>>>    create mode 100644 arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
>>>> [..]
>>>>> diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r1.dts b/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r1.dts
>>>>> new file mode 100644
>>>>> index 000000000000..17e9e4d6f6ab
>>>>> --- /dev/null
>>>>> +++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r1.dts
>>>>> @@ -0,0 +1,11 @@
>>>>> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
>>>>> +/*
>>>>> + * Copyright (C) 2021 MediaTek Inc.
>>>>> + */
>>>>> +/dts-v1/;
>>>>> +#include "mt8195-cherry.dtsi"
>>>>> +
>>>>> +/ {
>>>>> +     model = "MediaTek Tomato (rev1) board";
>>>>
>>>> Given that the compatible is "google," I believe we'll want to rename the model
>>>> to "Google Tomato", much like was commented on the Asurada series [1], but
>>>> better to have confirmation from someone from Google. Chen-Yu? :)
>>>
>>> I asked for clarification internally and it turns out we didn't get the
>>> Asurada series quite right either.
>>>
>>> Google only owns the reference design, that is Asurada for MT8192 and
>>> Cherry for MT8195. The vendor own the end product design that is based
>>> off of Google's reference design.
>>>
>>> So for Tomato, the vendor is Acer. Note that "Tomato" and the other
>>> codenames seen in ChromeOS are public codenames that Google uses.
>>>
>>> The compatible string will likely stay "google,XXX", since this is set
>>> in firmware, and updating it after the product has shipped poses both
>>> a significant hurdle and risk.
>>>
>>
>> Yeah, makes sense. Should we call this "Acer Tomato (revX) board" then?
>> ...if we do that, though, we need to know if the other revisions of Tomato
>> are also from Acer, or we would be getting one right and all the others wrong.
> 
> AFAIK each "device build" is its own project and gets its own codename,
> otherwise it would get real confusing for us internally really fast.

All clear.

Thanks,
Angelo

> 
> ChenYu
> 
>> Cheers,
>> Angelo
>>
>>>
>>> Regards
>>> ChenYu
>>>
>>>> Otherwise,
>>>>
>>>> Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
>>>>
>>>> Thanks,
>>>> Nícolas
>>>>
>>>> [1] https://lore.kernel.org/all/CAGXv+5Gv2pjPXynz6HCdgux+giPDC5qRk+KW1aFduVz82rM=+g@mail.gmail.com/
>>>>
>>>>> +     compatible = "google,tomato-rev1", "google,tomato", "mediatek,mt8195";
>>>>> +};
>>>> [..]
>>>>> --
>>>>> 2.35.1
>>>>>
>>


-- 
AngeloGioacchino Del Regno
Software Engineer

Collabora Ltd.
Platinum Building, St John's Innovation Park, Cambridge CB4 0DS, UK
Registered in England & Wales, no. 5513718
