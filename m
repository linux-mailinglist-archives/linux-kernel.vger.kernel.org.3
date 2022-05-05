Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15B4651BB09
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 10:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350561AbiEEI4d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 04:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232713AbiEEI42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 04:56:28 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1DC24839F;
        Thu,  5 May 2022 01:52:49 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id CF7DE1F44DA3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1651740768;
        bh=gL+MfgXtaLijztUn2+qpxh5p8GDURmo5rL/MwSHGVsY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=c98MzQTxkRnVSk9Y+nNeRtpz2nU6xrCYIWJQimUmRSwW9uenjftZc1eD/cOee1MHQ
         5G4/Tk1+ijKUdhRWjM0GwzWnHyRH5DEBBoTOD4wohGtfF8RI8OyOwzmVTKxwo1OPdg
         nrpq3cmNtYz0A4e3l37u8C/zJnM15A7vecvSz6Y9905FFqr11PRWSzjFIm10ioAVjA
         ftTVjEkvzvzTHsQfDU2ZgSuFOUWmQq//X0GizA5alJKjzMMlPAtzWrbD984EFnXcaA
         QiLKc9AgGbD0SnN9CLz+SyVzjakLqDOfvJR4dymNugj36+afvQyhQH11aK+tCLaAVx
         VXIhzovJg2miQ==
Message-ID: <d1c548bb-8a36-79bf-498d-c909bf7e7679@collabora.com>
Date:   Thu, 5 May 2022 10:52:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/3] ASoC: dt-bindings: mediatek: mt8192: Add i2s-share
 properties
Content-Language: en-US
To:     Jiaxin Yu <jiaxin.yu@mediatek.com>,
        =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>, Mark Brown <broonie@kernel.org>
Cc:     kernel@collabora.com,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shane Chien <shane.chien@mediatek.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
References: <20220429203039.2207848-1-nfraprado@collabora.com>
 <20220429203039.2207848-2-nfraprado@collabora.com>
 <4826c824-40ce-5726-ed95-5be069233ca7@collabora.com>
 <cbf2fcbae25408b95875278eb37e829bf4671430.camel@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <cbf2fcbae25408b95875278eb37e829bf4671430.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 05/05/22 10:48, Jiaxin Yu ha scritto:
> On Thu, 2022-05-05 at 10:08 +0200, AngeloGioacchino Del Regno wrote:
>> Il 29/04/22 22:30, Nícolas F. R. A. Prado ha scritto:
>>> The Mediatek AFE PCM controller for MT8192 allows sharing of an I2S
>>> bus
>>> between two busses. Add a pattern for these properties in the
>>> dt-binding.
>>>
>>> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
>>> ---
>>>
>>>    Documentation/devicetree/bindings/sound/mt8192-afe-pcm.yaml | 5
>>> +++++
>>>    1 file changed, 5 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/sound/mt8192-afe-
>>> pcm.yaml b/Documentation/devicetree/bindings/sound/mt8192-afe-
>>> pcm.yaml
>>> index 7a25bc9b8060..5b03c8dbf318 100644
>>> --- a/Documentation/devicetree/bindings/sound/mt8192-afe-pcm.yaml
>>> +++ b/Documentation/devicetree/bindings/sound/mt8192-afe-pcm.yaml
>>> @@ -54,6 +54,11 @@ properties:
>>>          - const: aud_infra_clk
>>>          - const: aud_infra_26m_clk
>>>    
>>> +patternProperties:
>>> +  "^i2s[0-35-9]-share$":
>>> +    description: Name of the I2S bus that is shared with this bus
>>> +    pattern: "^I2S[0-35-9]$"
>>> +
>>>    required:
>>>      - compatible
>>>      - interrupts
>>>
>>
>> The only other way of doing this would be to complicate this in the
>> driver
>> so that we can do something like
>>
>> "i2s-share = <0 2>";  instead of  i2s0-share = "I2S2";
>>
>> ...and I don't think that this would be any more straightforward than
>> the
>> provided way.
>>
>> There's an improvement that we can do to that pattern description
>> though,
>> which would be explaining that declaring 'i2s0-share = "I2S2"' means
>> that
>> I2S2's data pin will be used as DATA-OUT, while i2s0 is DATA-IN.
>>
>> Another thing that comes to mind here is that this is a MediaTek
>> specific
>> property and *not* a generic one, which means that both the driver
>> and
>> this binding should be fixed to get a "mediatek," prefix, so, this
>> property
>> should - in reality - be "mediatek,i2s[0-35-9]-share" instead.
>>
>> I think that everyone agrees about that, but let's see what the
>> others say.
>>
>> Cheers,
>> Angelo
> 
> Hi Angelo,
> 
> 'i2s0-share = "I2S2"' means that if we want use I2S0, there need open
> I2S2 to provide clock. Conversely, if we want to use I2S2, we don't
> need to open I2S0. However, MediaTek I2S0 and I2S2 hardware are
> generally designed as input. So usually we use 'i2s0-share = "I2S1"'.
> Even numbers represent input, odd numbers represent output.
> 
> Yes, I think adding the "mediatek," prefix is the right way to define a
> non-generic property.
> 

Hello Jiaxin,

if I get this correctly, i2s0-share = "I2S2" would be *invalid*... as you
just explained, i2sX, where:

X = even number -> always DATA IN
X = odd number  -> always DATA OUT

...this means that the dt-binding needs a pattern to specify that only odd
can be assigned to only even.

Nicolas, take note! :-) :-)

Thanks,
Angelo
