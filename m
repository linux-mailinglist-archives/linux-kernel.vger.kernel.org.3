Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0B8D584395
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 17:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232360AbiG1Pvy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 11:51:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231586AbiG1Pvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 11:51:52 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA37B2FFF2;
        Thu, 28 Jul 2022 08:51:50 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E145C6601B38;
        Thu, 28 Jul 2022 16:51:48 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1659023509;
        bh=nI5LpKShenHgPTD6bJf1SzWZXrJS0BX0gmqnjEX+i7w=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=UG7DkYETX6GEoZQvkA3B/J4GAGt8vLnuOJLdAmjjdHy2J0r/757BpDxP+9t+VGDxG
         PDMf3D+K/lChMrZXhpFnX873iwOtlED+V0vk6vDSbtIA1XxvQyIwj9jc9uglA2AwgV
         y5mwcizu7aBPJvnMd7yYfGPgBpPV2xCemQ3cWBBr3Ct7AFUoLod3btfQXEQXexVPb7
         /SomR4/cxboHfP3aYRYXwYyooCg9MWMwSSVneWAVwJdsuLVSMiWnomqYPm0anCoADG
         ggpWVS0+KLMbh47c3SDwMMkqZuffVHBDHYbw9kUlWM3qK+W357oQ7sL1zof/W/M9Ng
         kxH6YMxuokrQg==
Message-ID: <689b439f-531b-9b3d-2e48-b7b83c50b3dd@collabora.com>
Date:   Thu, 28 Jul 2022 17:51:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2] arm64: dts: mt8173-oak: Switch to SMC watchdog
Content-Language: en-US
To:     Pin-yen Lin <treapking@chromium.org>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Eizan Miyamoto <eizan@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Evan Benn <evanbenn@chromium.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
References: <20220727094034.1372745-1-treapking@chromium.org>
 <c455adea-2d18-60af-7175-a4e283e3dcb8@collabora.com>
 <CAEXTbpc7W40-vYcTVTNo7ikQ-n0O246AsbPntNb4q2nBErYVQw@mail.gmail.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <CAEXTbpc7W40-vYcTVTNo7ikQ-n0O246AsbPntNb4q2nBErYVQw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 28/07/22 17:39, Pin-yen Lin ha scritto:
> On Thu, Jul 28, 2022 at 7:21 PM AngeloGioacchino Del Regno
> <angelogioacchino.delregno@collabora.com> wrote:
>>
>> Il 27/07/22 11:40, Pin-yen Lin ha scritto:
>>> Switch to SMC watchdog because we need direct control of HW watchdog
>>> registers from kernel. The corresponding firmware was uploaded in
>>> https://review.trustedfirmware.org/c/TF-A/trusted-firmware-a/+/3405.
>>>
>>> Signed-off-by: Pin-yen Lin <treapking@chromium.org>
>>> ---
>>>
>>> Changes in v2:
>>> - Move the modifications to mt8173-elm.dtsi and add some comments.
>>>
>>>    arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi | 12 ++++++++++++
>>>    1 file changed, 12 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi b/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
>>> index e21feb85d822..b2269770abc3 100644
>>> --- a/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
>>> +++ b/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
>>> @@ -161,6 +161,18 @@ hdmi_connector_in: endpoint {
>>>                        };
>>>                };
>>>        };
>>> +
>>> +     soc {
>>> +             /*
>>> +              * Disable the original MMIO watch dog and switch to the SMC watchdog,
>>> +              * which operates on the same MMIO.
>>> +              */
>>> +             /delete-node/ watchdog@10007000;
>>
>> Unfortunately, we're not quite there yet.
>> The comment is fine, but...
>>
>> There's no need to /delete-node/: you can just do it like
>>
>> /*
>>    * Disable the original MMIO watch dog and switch to the SMC watchdog,
>>    * which operates on the same MMIO.
>>    */
>> &watchdog {
>>          status = "disabled";
>> };
>>
>> and...
>>
>>> +
>>> +             watchdog {
>>
>> This isn't addressable, hence it belongs to the root node, not to soc.
>> If you did that because of naming issues, I would propose to call it
>> smc-watchdog instead of watchdog.
>>
>>
>>> +                     compatible = "arm,smc-wdt";
>>
> Thanks for the suggestion. I'll modify it accordingly in v3.
> 
>> P.S.: No timeout-sec?
> 
> The example in the binding file has a timeout-sec property, but it is
> not defined in the binding nor used in the driver...
> The driver seems to talk with the firmware to get a timeout value[1]
> instead of reading it from the devicetree.
> 

Oh. I admit I trusted the binding blindly, didn't check the actual driver code.

On a note, we should check why is that binding partially wrong and eventually
fix it (remove the property), or add the capability to the driver, but feel free
to ignore that for now, as this is not relevant for the context of this specific
change that you're trying to do here.

P.S.: I just noticed that the commit title is also wrong. s/mt8173-oak/mt8173-elm/g

Waiting for a v3!


> [1]: https://elixir.bootlin.com/linux/latest/source/drivers/watchdog/arm_smc_wdt.c#L138
>>
>> Regards,
>> Angelo
>>
>>> +             };
>>> +     };
>>>    };
>>>
>>>    &mfg_async {
>>>
>>

