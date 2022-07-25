Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79CA957FAE4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 10:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233499AbiGYIG6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 04:06:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbiGYIGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 04:06:54 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB92A12D17;
        Mon, 25 Jul 2022 01:06:53 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D3DDB66015BF;
        Mon, 25 Jul 2022 09:06:51 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1658736412;
        bh=5je1JKpUJlB29V7pZ646kfrspMHPU26RVKHjjnCC810=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=eCZ6M8pFeqt1zYxSTYWA+hO5De8L5rf3MWpLw7HDDzEVI/eb9TU6hAz+X7tGxcwhN
         Ve01gMszvlnfgiW5w7tXRtx8S4G4lyIOSZEyO8Ca91W8CwqsUq8k0MScGz+KS7urjk
         9HV2/kbuCso4L0pCfH75Gs3vOitE9IgiFt0q1mGpKwz6vMngMrltbLChmHIMp1usy2
         GHJL9r/xE7DbZPk/Ky8TRt2DCw25knq6Kr4IhSo18/P7ZXKg3h47T7gg0YqORkcKJ6
         xLFy24/VlEZ50VqWgtYZbrOTfvujECreX5Rbn9ddZgvScqcB7a3gY9yTok9rCYFjma
         2w3bLHw9ULEvw==
Message-ID: <94bea93e-484d-e635-4e94-5ffe14b127f4@collabora.com>
Date:   Mon, 25 Jul 2022 10:06:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 1/8] arm64: dts: mediatek: cherry: Enable the System
 Companion Processor
Content-Language: en-US
To:     Chen-Yu Tsai <wenst@chromium.org>,
        Tinghan Shen <tinghan.shen@mediatek.com>
Cc:     matthias.bgg@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220721145017.918102-1-angelogioacchino.delregno@collabora.com>
 <20220721145017.918102-2-angelogioacchino.delregno@collabora.com>
 <CAGXv+5Ekk_ndyPGVmWWRFkE3uveDHSczyf2OsdhOtqfSHxvnMw@mail.gmail.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <CAGXv+5Ekk_ndyPGVmWWRFkE3uveDHSczyf2OsdhOtqfSHxvnMw@mail.gmail.com>
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

Il 25/07/22 06:21, Chen-Yu Tsai ha scritto:
> On Thu, Jul 21, 2022 at 10:50 PM AngeloGioacchino Del Regno
> <angelogioacchino.delregno@collabora.com> wrote:
>>
>> MT8195 features a SCP like some other older SoCs, and Cherry uses it
>> for various tasks. Add the required pin configuration and DMA pool
>> and enable the node.
>>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> ---
>>   .../boot/dts/mediatek/mt8195-cherry.dtsi      | 28 +++++++++++++++++++
>>   1 file changed, 28 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
>> index fcc600674339..feebbe367e93 100644
>> --- a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
>> +++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
>> @@ -104,6 +104,18 @@ usb_vbus: regulator-5v0-usb-vbus {
>>                  enable-active-high;
>>                  regulator-always-on;
>>          };
>> +
>> +       reserved_memory: reserved-memory {
>> +               #address-cells = <2>;
>> +               #size-cells = <2>;
>> +               ranges;
>> +
>> +               scp_mem: memory@50000000 {
>> +                       compatible = "shared-dma-pool";
>> +                       reg = <0 0x50000000 0 0x2900000>;
>> +                       no-map;
>> +               };
>> +       };
>>   };
>>
>>   &i2c0 {
>> @@ -600,6 +612,14 @@ pins-low-power-pupd {
>>                  };
>>          };
>>
>> +       scp_pins: scp-default-pins {
>> +               pins-vreq {
>> +                       pinmux = <PINMUX_GPIO76__FUNC_SCP_VREQ_VAO>;
>> +                       bias-disable;
>> +                       input-enable;
>> +               };
>> +       };
>> +
>>          spi0_pins: spi0-default-pins {
>>                  pins-cs-mosi-clk {
>>                          pinmux = <PINMUX_GPIO132__FUNC_SPIM0_CSB>,
>> @@ -643,6 +663,14 @@ &pmic {
>>          interrupts-extended = <&pio 222 IRQ_TYPE_LEVEL_HIGH>;
>>   };
>>
>> +&scp {
>> +       status = "okay";
>> +
>> +       memory-region = <&scp_mem>;
>> +       pinctrl-names = "default";
>> +       pinctrl-0 = <&scp_pins>;
> 
> firmware-name = "mediatek/mt8195/scp.img";
> 

My intention was to actually add this line here. I must've erroneously
dropped it during cleanup/rebase...

> Or maybe this should be added to the base mt8195.dtsi?
> 
> The entry for mt8192 was added to mt8192-asurada.dtsi though.
> 
> Tinghan, could you ask internally whether the SCP firmware should be
> tied to the SoC or the projects involving the SoC?

In my opinion, even if that may be tied to the SoCs, we should still declare
it in the machine(/platform) devicetree as (even if *luckily* this is not the
case on Chromebooks), firmwares may be signed with a OEM key and may differ
just for that.

I'll send a v3 with that fix ASAP.

Cheers,
Angelo

> 
> Thanks
> ChenYu
> 
>> +};
>> +
>>   &spi0 {
>>          status = "okay";
>>
>> --
>> 2.35.1
>>
>>


