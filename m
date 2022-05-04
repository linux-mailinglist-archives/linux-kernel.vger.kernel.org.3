Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 204FD519B34
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 11:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346961AbiEDJMr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 05:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346934AbiEDJMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 05:12:39 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7D8C1A827;
        Wed,  4 May 2022 02:09:03 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 164771F43CB0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1651655341;
        bh=cyGLJPmNem2nlpr6KMEZ/v4BP/CfNFyUllyY7Ug96Hg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=UZhuaJrSn2xRicCSrJYO47i5VM4OegSSaMbWQq+ZrU+iu9zHVw6ryx62slWbpRJAO
         xUdwDXLQqwxa+mfkww15wpfxKRg+/Zf5RQ8ZAsnjcK7Wg5zp7Xx9ietLi65BgtBIU6
         myqeqy/0bS7Zxg1kr2SxV4Y+005On1iZ6S+WZ5RFREV6kUFaNOoCxHFVfE1FGBCYAx
         V5J9gscBOPaKv1gzs1HqHqPhewtJYcug9iUaJBQKfvsz/+n34Yu3wU9/g5eia53eJw
         uyMaDhbxsTSpjyMtTqxO31tV8HLd7gaJ9oZu7WeB+vaLdLXcQMRp1Ge+JxjyOPHSdS
         E9cfBTzAPkheA==
Message-ID: <8c9bc4cc-09f1-71db-6386-b486e67d6a2a@collabora.com>
Date:   Wed, 4 May 2022 11:08:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 1/2] dt-bindings: pinctrl: Add MediaTek MT6795 pinctrl
 bindings
Content-Language: en-US
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>
Cc:     linus.walleij@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        sean.wang@kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
References: <20220503142537.152499-1-angelogioacchino.delregno@collabora.com>
 <20220503142537.152499-2-angelogioacchino.delregno@collabora.com>
 <20220504003340.224exvr33qevi3sj@notapiano>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220504003340.224exvr33qevi3sj@notapiano>
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

Il 04/05/22 02:33, Nícolas F. R. A. Prado ha scritto:
> Hi Angelo,
> 
> On Tue, May 03, 2022 at 04:25:36PM +0200, AngeloGioacchino Del Regno wrote:
>> Add devicetree and pinfunc bindings for MediaTek Helio X10 MT6795.
>>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> ---
>>   .../pinctrl/mediatek,pinctrl-mt6795.yaml      | 224 +++++
>>   include/dt-bindings/pinctrl/mt6795-pinfunc.h  | 908 ++++++++++++++++++
>>   2 files changed, 1132 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/pinctrl/mediatek,pinctrl-mt6795.yaml
>>   create mode 100644 include/dt-bindings/pinctrl/mt6795-pinfunc.h
>>
> 
> ...
> 
>> +
>> +          bias-pull-down:
>> +            oneOf:
>> +              - type: boolean
>> +              - enum: [100, 101, 102, 103]
>> +                description: mt6795 pull down PUPD/R0/R1 type define value.
>> +            description: |
>> +               For normal pull down type, it is not necessary to specify R1R0
>> +               values; When pull down type is PUPD/R0/R1, adding R1R0 defines
>> +               will set different resistance values.
>> +
>> +          bias-pull-up:
>> +            oneOf:
>> +              - type: boolean
>> +              - enum: [100, 101, 102, 103]
>> +                description: mt6795 pull up PUPD/R0/R1 type define value.
>> +            description: |
>> +               For normal pull up type, it is not necessary to specify R1R0
>> +               values; When pull up type is PUPD/R0/R1, adding R1R0 defines
>> +               will set different resistance values.
>> +
>> +          bias-disable: true
>> +
>> +          output-high: true
>> +
>> +          output-low: true
>> +
>> +          input-enable: true
>> +
>> +          input-disable: true
>> +
>> +          input-schmitt-enable: true
>> +
>> +          input-schmitt-disable: true
>> +
>> +          mediatek,pull-up-adv:
>> +            description: |
>> +              Pull up setings for 2 pull resistors, R0 and R1. User can
>> +              configure those special pins. Valid arguments are described as below:
>> +              0: (R1, R0) = (0, 0) which means R1 disabled and R0 disabled.
>> +              1: (R1, R0) = (0, 1) which means R1 disabled and R0 enabled.
>> +              2: (R1, R0) = (1, 0) which means R1 enabled and R0 disabled.
>> +              3: (R1, R0) = (1, 1) which means R1 enabled and R0 enabled.
>> +            $ref: /schemas/types.yaml#/definitions/uint32
>> +            enum: [0, 1, 2, 3]
>> +
>> +          mediatek,pull-down-adv:
>> +            description: |
>> +              Pull down settings for 2 pull resistors, R0 and R1. User can
>> +              configure those special pins. Valid arguments are described as below:
>> +              0: (R1, R0) = (0, 0) which means R1 disabled and R0 disabled.
>> +              1: (R1, R0) = (0, 1) which means R1 disabled and R0 enabled.
>> +              2: (R1, R0) = (1, 0) which means R1 enabled and R0 disabled.
>> +              3: (R1, R0) = (1, 1) which means R1 enabled and R0 enabled.
>> +            $ref: /schemas/types.yaml#/definitions/uint32
>> +            enum: [0, 1, 2, 3]
> 
> I'm actually myself trying to figure out why there are two ways of setting
> R0/R1 in the dt-binding (and which should preferred for mt8192 and others):
> 1. passing 0-3 to mediatek,pull-{up,down}-adv
> 2. passing one of the MTK_PUPD_SET_R1R0_** flags to bias-pull-{up,down}
> 
> When the pin is of type MTK_PULL_PUPD_R1R0_TYPE (which should be the only case
> in which it makes sense to consider mediatek,pull-{up,down}-adv AFAIU), they end
> up doing the same thing, it's:
> 
> mtk_pinconf_bias_set_combo() -> mtk_pinconf_bias_set_pupd_r1_r0()
> vs
> mtk_pinconf_adv_pull_set()
> 
> ... and they write to the same registers.
> 
> Unless I'm missing something here.
> 
> Thanks,
> Nícolas

Hey!

Yes you're missing something important :-P

First of all, the flow all depends on the pinctrl driver "type": we have
the common (v1), moore and paris.
I will leave this research to you, or this reply will become a wall of text,
so let's go on with the latter details, which are relative to the paris one.

You should check pinctrl/mediatek/pinctrl-mt(model).c: here, you declare a
struct mtk_pin_soc containing pointers to pins data and function callbacks,
such as bias_{get,set}_combo() and adv_pull_{set,get}().


Now to the real deal, examples below:

- Declaring property "mediatek,pull-up-adv" means that you get through
   MTK_PIN_CONFIG_PU_ADV case, which calls the adv_pull_set() callback;
- Declaring property "bias-pull-up", however, means that you get through
   PIN_CONFIG_BIAS_PULL_UP, which calls bias_set_combo().

For adv_pull_set() callback being mtk_pinconf_adv_pull_set() the following happens:
- Write to registers PIN_REG_R0, PIN_REG_R1 (set resistor 0,1 en/disabled);
- Write to registers PIN_REG_PUPD (pull up, or down)
- If below writes fail (because no r0r1/pupd declared in your driver's table),
   the code will call the bias_set() callback as a fallback.

For bias_set_combo() cb being mtk_pinconf_bias_set_combo() the following happens:
- Check pull_type mask, it may be one or a combination (OR) of:
   - MTK_PULL_RSEL_TYPE
   - MTK_PULL_PU_PD_TYPE
   - MTK_PULL_PULLSEL_TYPE
   - MTK_PULL_PUPD_R1R0_TYPE
- Call function(s!) mtk_pinconf_bias_set_{rsel,pu_pd,pullsel_pullen,pupd_r1_r0},
   depending on the bits set in the pull_type mask.

All of the aforementioned functions will perform a different register write for
different pullup/pulldown settings..

bias-pull-up:
One of the cases in which you want to use the combo is when you need to set a
combination of, let's say, PULLSEL and R1R0 (enabling a default pull, adding a
series resistance of parallel R1R0 resistors to the default value), which is
similar to RSEL_TYPE, but for SoCs that don't have the RSEL_TYPE register layout.

mediatek,pull-up-adv:
One of the cases in which you want to use the adv_pull_set is when you want to
set *only* R1R0+PUPD or *only* PULLSEL (when r1r0/pupd not supported), but also
*never* modify PU_PD or RSEL registers.


It's a bit tricky to understand, but this stuff is really on a per-SoC basis, as
not all of them will behave like the other... so if you check only pinctrl-paris,
or only pinctrl-mtk-common-v2, you will inevitably go offroad with your research.
The MediaTek pinctrl mutates behavior in a combination of the aforementioned two
*and* the SoC-specific pinctrl data (pinctrl-mt6795.c).

Though, maybe-and-I-say-maybe (because I haven't performed a *full* research on
that topic), it *may be* possible to refactor the mtk pinctrl framework to get
rid of the mediatek,pull-up-adv property and do it all from the standard pinconf
bias-pull-up property instead with some driver magic... but.. in any case, that's
for another time - definitely not now (for me, at least - but if anyone wants to
explore this territory and produce more cleanups, you're encouraged to).


Please note that I tried to simplify the explanation as much as possible and
something inside may have to be "interpreted the right way", when looking for
details that are way more advanced compared to the basics that are explained
here... but you see, it's already a big wall of text... :-) :-)

Cheers,
Angelo
