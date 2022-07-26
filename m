Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA48580EB3
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 10:11:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232054AbiGZILw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 04:11:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiGZILt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 04:11:49 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE04727150;
        Tue, 26 Jul 2022 01:11:47 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 1CA406601596;
        Tue, 26 Jul 2022 09:11:46 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1658823106;
        bh=dAET0aJ9O9CxvAJfCeQORiWmh5LRUFbf9om4jQFdjY4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ZjmkO9Cn8oeBIVweESZI6SC07GIY7x7cS4W52UqDgn69x85kP/lIrwfXAYWqiCf5M
         rn8ZnmU9ODb+8q4TNoSx5fPkPjz7fkiRRFV692mQL9AfTzwdh8bcblyhFUNcCmyOjM
         WO3jl2RsJxt6ZeNI0ZMHjeYMuRHJCHMrlUI83HkYD07BMwbuGkdaKT3raK1tHdxcH5
         7PsL7c1ka4DQqoE+d+vQJGK55JiFuVO8HHMFr9qku45vRP1+7rgiKFHnnFcuN5N50x
         FLN3Tp7ADiAgauA9+kHZlqSqlFP/bA6568qODWXXMtD62+h4c8CzgwrrM6mAzEHLTx
         jZbOmXia3+ZNw==
Message-ID: <5d8690e4-a4ec-4ee9-4bed-bc6bf32ae80b@collabora.com>
Date:   Tue, 26 Jul 2022 10:11:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 4/8] arm64: dts: mediatek: cherry: Enable secondary
 SD/MMC controller
Content-Language: en-US
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     matthias.bgg@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220721145017.918102-1-angelogioacchino.delregno@collabora.com>
 <20220721145017.918102-5-angelogioacchino.delregno@collabora.com>
 <CAGXv+5FutJb_MRwSVgjV7tByBvfq3AFsSxs6ETUZaNzrfpywgg@mail.gmail.com>
 <781f6d3e-412e-1553-c2c2-23c9a897626b@collabora.com>
 <CAGXv+5Gdwcj1n0q8e8ReoUOZX18pbtbxV7oof06Q2_nJMNY-cw@mail.gmail.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <CAGXv+5Gdwcj1n0q8e8ReoUOZX18pbtbxV7oof06Q2_nJMNY-cw@mail.gmail.com>
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

Il 26/07/22 06:04, Chen-Yu Tsai ha scritto:
> On Mon, Jul 25, 2022 at 6:20 PM AngeloGioacchino Del Regno
> <angelogioacchino.delregno@collabora.com> wrote:
>>
>> Il 25/07/22 10:54, Chen-Yu Tsai ha scritto:
>>> On Thu, Jul 21, 2022 at 10:51 PM AngeloGioacchino Del Regno
>>> <angelogioacchino.delregno@collabora.com> wrote:
>>>>
>>>> As of now, all of the boards based on the cherry platform have a
>>>> usable secondary SD/MMC controller, usually for SD cards: enable
>>>> it to allow both booting from it and generally accessing external
>>>> storage.
>>>>
>>>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>>>> ---
>>>>    .../boot/dts/mediatek/mt8195-cherry.dtsi      | 62 +++++++++++++++++++
>>>>    1 file changed, 62 insertions(+)
>>>>
>>>> diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
>>>> index 2853f7f76c90..8859957c7b27 100644
>>>> --- a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
>>>> +++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
>>>> @@ -17,6 +17,7 @@ aliases {
>>>>                   i2c5 = &i2c5;
>>>>                   i2c7 = &i2c7;
>>>>                   mmc0 = &mmc0;
>>>> +               mmc1 = &mmc1;
>>>>                   serial0 = &uart0;
>>>>           };
>>>>
>>>> @@ -227,6 +228,24 @@ &mmc0 {
>>>>           vqmmc-supply = <&mt6359_vufs_ldo_reg>;
>>>>    };
>>>>
>>>> +&mmc1 {
>>>> +       status = "okay";
>>>> +
>>>> +       bus-width = <4>;
>>>> +       cap-sd-highspeed;
>>>> +       cd-gpios = <&pio 54 GPIO_ACTIVE_LOW>;
>>>> +       max-frequency = <200000000>;
>>>> +       no-mmc;
>>>> +       no-sdio;
>>>> +       pinctrl-names = "default", "state_uhs";
>>>> +       pinctrl-0 = <&mmc1_pins_default>;
>>>> +       pinctrl-1 = <&mmc1_pins_uhs>;
>>>> +       sd-uhs-sdr50;
>>>> +       sd-uhs-sdr104;
>>>> +       vmmc-supply = <&mt_pmic_vmch_ldo_reg>;
>>>> +       vqmmc-supply = <&mt_pmic_vmc_ldo_reg>;
>>>> +};
>>>> +
>>>>    /* for CPU-L */
>>>>    &mt6359_vcore_buck_reg {
>>>>           regulator-always-on;
>>>> @@ -575,6 +594,49 @@ pins-rst {
>>>>                   };
>>>>           };
>>>>
>>>> +       mmc1_pins_default: mmc1-default-pins {
>>>> +               pins-cmd-dat {
>>>> +                       pinmux = <PINMUX_GPIO110__FUNC_MSDC1_CMD>,
>>>> +                                <PINMUX_GPIO112__FUNC_MSDC1_DAT0>,
>>>> +                                <PINMUX_GPIO113__FUNC_MSDC1_DAT1>,
>>>> +                                <PINMUX_GPIO114__FUNC_MSDC1_DAT2>,
>>>> +                                <PINMUX_GPIO115__FUNC_MSDC1_DAT3>;
>>>> +                       input-enable;
>>>> +                       drive-strength = <8>;
>>>> +                       bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
>>>> +               };
>>>> +
>>>> +               pins-clk {
>>>> +                       pinmux = <PINMUX_GPIO111__FUNC_MSDC1_CLK>;
>>>> +                       drive-strength = <8>;
>>>> +                       bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
>>>> +               };
>>>> +
>>>> +               pins-insert {
>>>> +                       pinmux = <PINMUX_GPIO54__FUNC_GPIO54>;
>>>> +                       bias-pull-up;
>>>> +               };
>>>> +       };
>>>> +
>>>> +       mmc1_pins_uhs: mmc1-uhs-pins {
>>>> +               pins-cmd-dat {
>>>> +                       pinmux = <PINMUX_GPIO110__FUNC_MSDC1_CMD>,
>>>> +                                <PINMUX_GPIO112__FUNC_MSDC1_DAT0>,
>>>> +                                <PINMUX_GPIO113__FUNC_MSDC1_DAT1>,
>>>> +                                <PINMUX_GPIO114__FUNC_MSDC1_DAT2>,
>>>> +                                <PINMUX_GPIO115__FUNC_MSDC1_DAT3>;
>>>> +                       input-enable;
>>>> +                       drive-strength = <8>;
>>>> +                       bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
>>>> +               };
>>>> +
>>>> +               pins-clk {
>>>> +                       pinmux = <PINMUX_GPIO111__FUNC_MSDC1_CLK>;
>>>> +                       drive-strength = <8>;
>>>> +                       bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
>>>> +               };
>>>
>>> I wonder if pins-insert should be duplicated here. And there's no
>>> difference between the standard and UHS pinconfigs. One would expect
>>> higher drive strength on the UHS set, if two sets were required.
>>> So maybe we should just have one set, and use that one for both
>>> the default and uhs states.
>>>
>>
>> I don't think that it would really make a lot of sense to duplicate the
>> insertion pin setup in the UHS-specific pinctrl set...
>>
>> Whenever you remove the uSD card, the controller goes back to default,
>> as the first steps in card initialization are always happening at low
>> speed and only after that we can switch to UHS speeds... so we do expect
>> that the first-ever state is always `default` (by spec!), which means
>> that we are also ensuring that the insertion pin setup is always done.
> 
> Right. What I wanted to say was that, besides the insertion pin, there's
> no difference between the default and uhs states here. So why have two
> copies instead of one that is referenced twice? (the uhs state is required
> by the binding).
> 

OH!!!! Right. Yes I definitely agree with you on that one.

Let's split the pins-insert in `mmc1_pins_det: mmc1-detect-pins` and add
a reference to it in the default pinctrl, that's a sensible option.

I'll do that for v3!

> ChenYu
> 
>> Cheers,
>> Angelo
>>
>>> Otherwise,
>>>
>>> Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
>>> Tested-by: Chen-Yu Tsai <wenst@chromium.org>
>>>
>>>> +       };
>>>> +
>>>>           nor_pins_default: nor-default-pins {
>>>>                   pins-ck-io {
>>>>                           pinmux = <PINMUX_GPIO142__FUNC_SPINOR_IO0>,
>>>> --
>>>> 2.35.1
>>>>
>>>>
>>


-- 
AngeloGioacchino Del Regno
Software Engineer

Collabora Ltd.
Platinum Building, St John's Innovation Park, Cambridge CB4 0DS, UK
Registered in England & Wales, no. 5513718
