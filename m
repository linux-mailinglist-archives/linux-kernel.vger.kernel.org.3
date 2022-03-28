Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C355D4E9A18
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 16:50:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244065AbiC1Ovu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 10:51:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237283AbiC1Ovs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 10:51:48 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13FEB3F8A7;
        Mon, 28 Mar 2022 07:50:06 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 157AE1F404A0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1648479005;
        bh=rh1r1C45HfSaIbukyLwkQj2wc8+C93F7ZOfSvSOU2o4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Gm788Xsmn/QVrAO0hM+4de4tvTGjuuQWcofmlA/NObYcXRpCLczAB9EceIFF+RA+f
         6YROwpBLFZrNKk2LvanhAbBgBOR4rFQ/fctRk4p2FQ4ZpVUj5ufjJJVhn6mIwDi456
         F0oRcUMx8s2PESeOjf06VwhO2LHllFHJpJj/B/CqrFEko2GOKnz/UmXpXCUZSAMbIU
         7B7bB1v2H4/Rdq3FBOn8QQkyneNIh60bQYvExblMH840ebePsWjvmgEwHVRAGhVepu
         MLemwNev0VUqSuhOdykoq0wC0TU1muVwYWFICjzAcITBsShepSyR8TBnmO4d2P8hEG
         /LqBP7Tixh4dA==
Message-ID: <0b042c71-4d07-76a6-53bb-94bbd4bad6c0@collabora.com>
Date:   Mon, 28 Mar 2022 16:50:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 2/4] arm64: dts: mediatek: Add device-tree for MT8195
 Demo board
Content-Language: en-US
To:     Fabien Parent <fparent@baylibre.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220327200312.3090515-1-fparent@baylibre.com>
 <20220327200312.3090515-3-fparent@baylibre.com>
 <94d231cf-ce4c-22f5-b9af-41ae68f1e659@collabora.com>
 <20220328144107.ed4xwzuiezzixqrx@radium>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220328144107.ed4xwzuiezzixqrx@radium>
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

Il 28/03/22 16:41, Fabien Parent ha scritto:
> On Mon, Mar 28, 2022 at 03:47:09PM +0200, AngeloGioacchino Del Regno wrote:
>> Il 27/03/22 22:03, Fabien Parent ha scritto:
>>> Add basic device-tree for the MT8195 Demo board. The
>>> Demo board is made by MediaTek and has a MT8195 SoC,
>>> associated with the MT6359 and MT6360 PMICs, and
>>> the MT7921 connectivity chip.
>>>
>>> The IOs available on that board are:
>>> * 1 USB Type-C connector with DP aux mode support
>>> * 1 USB Type-A connector
>>> * 1 full size HDMI RX and 1 full size HDMI TX connector
>>> * 1 uSD slot
>>> * 40 pins header
>>> * SPI interface header
>>> * 1 M.2 slot
>>> * 1 audio jack
>>> * 1 micro-USB port for serial debug
>>> * 2 connectors for DSI displays
>>> * 3 connectors for CSI cameras
>>> * 1 connector for a eDP panel
>>> * 1 MMC storage
>>>
>>> This commit adds basic support in order to be able to boot.
>>>
>>> Signed-off-by: Fabien Parent <fparent@baylibre.com>
>>> ---
>>> v2:
>>>    * remove empty i2c nodes
>>>    * remove empty spi node
>>>    * remove unused pcie pinctrls
>>>    * fixup node nodes to not contains underscore
>>>    * rename mt6360 pmic node
>>>    * move mmc1 node right after mmc0 node
>>>    * use generic node name for gpio-keys
>>>    * uniformize pinctrl node names
>>>
>>>    arch/arm64/boot/dts/mediatek/Makefile        |   1 +
>>>    arch/arm64/boot/dts/mediatek/mt8195-demo.dts | 447 +++++++++++++++++++
>>>    2 files changed, 448 insertions(+)
>>>    create mode 100644 arch/arm64/boot/dts/mediatek/mt8195-demo.dts
>>>
>>
>> ..snip..
>>
>>> diff --git a/arch/arm64/boot/dts/mediatek/mt8195-demo.dts b/arch/arm64/boot/dts/mediatek/mt8195-demo.dts
>>> new file mode 100644
>>> index 000000000000..d94b4e01159a
>>> --- /dev/null
>>> +++ b/arch/arm64/boot/dts/mediatek/mt8195-demo.dts
>>> @@ -0,0 +1,447 @@
>>
>> ..snip..
>>
>>> +
>>> +	gpio-keys {
>>> +		compatible = "gpio-keys";
>>> +		input-name = "gpio-keys";
>>> +		pinctrl-names = "default";
>>> +		pinctrl-0 = <&gpio_keys_pins>;
>>> +
>>> +		key-0 {
>>
>> key-volup is more descriptive, can you please change that?
> 
> Which review should I follow, yours or the one from Krzysztof? Because both reviews are contradictory
> 

There are a lot of "vol-down", "vol-up" (etc) instances, lots of which are on
Qualcomm device-trees... so I guess this is just about personal preference...

Honestly, before sending my review I forgot to check Krzysztof's one (sorry!!),
but I think that this kind of node names is highly subjective... at least, I am
not aware of any rule about having to use "generic" names.

Check Documentation/devicetree/bindings/input/gpio-keys.yaml - in the example,
you can find "specific" node names, like:

         up {

             label = "GPIO Key UP";

In any case, as I said, it's my personal preference to have it named as something
like "key-volup" or "vol-up" or .. a name that is describing the key, but, as a
personal preference, it is nothing mandatory, not even from my side.

If anyone else has reasons to disagree, shrug, it's fine :))

>>
>>> +			gpios = <&pio 106 GPIO_ACTIVE_LOW>;
>>> +			label = "volume_up";
>>> +			linux,code = <KEY_VOLUMEUP>;
>>> +			wakeup-source;
>>> +			debounce-interval = <15>;
>>> +		};
>>> +	};
>>> +};
