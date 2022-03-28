Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 053DB4E9A4E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 17:03:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244172AbiC1PEo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 11:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240427AbiC1PEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 11:04:42 -0400
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9149B5FF1D;
        Mon, 28 Mar 2022 08:03:01 -0700 (PDT)
Received: by mail-wm1-f43.google.com with SMTP id bg31-20020a05600c3c9f00b00381590dbb33so8739679wmb.3;
        Mon, 28 Mar 2022 08:03:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ZrgiKCrxWRZyk32G1TmboPczQSoLsqVVgxz7YTO8i5k=;
        b=HEJwJjXBJGjPtk0lOHQ7mYyCnkWOanN8CBBlM+NC202fYWkcZFs6gugKwazdHA7yox
         ZVMsElJw1eNq92q6GGgCpwUqKifiGMsatgSQn9dlI5qTggNFksDoIl8tJX5O6p/1aWJn
         V6BryumpnPv8fzeS7vZq+czXv3W55cyjMWHgDPOHkD9HYrPQdPZt740KDxQq4z6dxliP
         l27QcZsxHpUxydONyfToCn2dIHLNFrbu00aM6xLPaG+x9yIhQ/rXbPbctFa7J/FIxcaS
         buwks5MbvnfDD/8NZec8uBAwlc7JeBqI7By7TiGRBqiWrtJND5Nkd5nMkr5hfFlF8MOy
         Xx9A==
X-Gm-Message-State: AOAM532hOzS4kUxf5ERS+IDA8u1BFfnntmJ1StlnOYA53nN1fuxH6WHT
        I/Xi5/7/kTpI8Ica3We4JrU=
X-Google-Smtp-Source: ABdhPJywupQH4SLAOIVaFYSgWXt+32QtCxN7pfRTFCK+LtCkmyy4u4ZTBg9yk9tY4OCAa0YsiEG1Lg==
X-Received: by 2002:a1c:2744:0:b0:382:a9b7:1c8a with SMTP id n65-20020a1c2744000000b00382a9b71c8amr26485495wmn.187.1648479779943;
        Mon, 28 Mar 2022 08:02:59 -0700 (PDT)
Received: from [192.168.0.162] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.googlemail.com with ESMTPSA id y7-20020a5d4ac7000000b00203e4c8bdf1sm12587975wrs.93.2022.03.28.08.02.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Mar 2022 08:02:59 -0700 (PDT)
Message-ID: <e0ace708-3754-d7af-35ee-c73e7b15a443@kernel.org>
Date:   Mon, 28 Mar 2022 17:02:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 2/4] arm64: dts: mediatek: Add device-tree for MT8195
 Demo board
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Fabien Parent <fparent@baylibre.com>
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
 <0b042c71-4d07-76a6-53bb-94bbd4bad6c0@collabora.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <0b042c71-4d07-76a6-53bb-94bbd4bad6c0@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/03/2022 16:50, AngeloGioacchino Del Regno wrote:
> Il 28/03/22 16:41, Fabien Parent ha scritto:
>> On Mon, Mar 28, 2022 at 03:47:09PM +0200, AngeloGioacchino Del Regno wrote:
>>> Il 27/03/22 22:03, Fabien Parent ha scritto:
>>>> Add basic device-tree for the MT8195 Demo board. The
>>>> Demo board is made by MediaTek and has a MT8195 SoC,
>>>> associated with the MT6359 and MT6360 PMICs, and
>>>> the MT7921 connectivity chip.
>>>>
>>>> The IOs available on that board are:
>>>> * 1 USB Type-C connector with DP aux mode support
>>>> * 1 USB Type-A connector
>>>> * 1 full size HDMI RX and 1 full size HDMI TX connector
>>>> * 1 uSD slot
>>>> * 40 pins header
>>>> * SPI interface header
>>>> * 1 M.2 slot
>>>> * 1 audio jack
>>>> * 1 micro-USB port for serial debug
>>>> * 2 connectors for DSI displays
>>>> * 3 connectors for CSI cameras
>>>> * 1 connector for a eDP panel
>>>> * 1 MMC storage
>>>>
>>>> This commit adds basic support in order to be able to boot.
>>>>
>>>> Signed-off-by: Fabien Parent <fparent@baylibre.com>
>>>> ---
>>>> v2:
>>>>    * remove empty i2c nodes
>>>>    * remove empty spi node
>>>>    * remove unused pcie pinctrls
>>>>    * fixup node nodes to not contains underscore
>>>>    * rename mt6360 pmic node
>>>>    * move mmc1 node right after mmc0 node
>>>>    * use generic node name for gpio-keys
>>>>    * uniformize pinctrl node names
>>>>
>>>>    arch/arm64/boot/dts/mediatek/Makefile        |   1 +
>>>>    arch/arm64/boot/dts/mediatek/mt8195-demo.dts | 447 +++++++++++++++++++
>>>>    2 files changed, 448 insertions(+)
>>>>    create mode 100644 arch/arm64/boot/dts/mediatek/mt8195-demo.dts
>>>>
>>>
>>> ..snip..
>>>
>>>> diff --git a/arch/arm64/boot/dts/mediatek/mt8195-demo.dts b/arch/arm64/boot/dts/mediatek/mt8195-demo.dts
>>>> new file mode 100644
>>>> index 000000000000..d94b4e01159a
>>>> --- /dev/null
>>>> +++ b/arch/arm64/boot/dts/mediatek/mt8195-demo.dts
>>>> @@ -0,0 +1,447 @@
>>>
>>> ..snip..
>>>
>>>> +
>>>> +	gpio-keys {
>>>> +		compatible = "gpio-keys";
>>>> +		input-name = "gpio-keys";
>>>> +		pinctrl-names = "default";
>>>> +		pinctrl-0 = <&gpio_keys_pins>;
>>>> +
>>>> +		key-0 {
>>>
>>> key-volup is more descriptive, can you please change that?
>>
>> Which review should I follow, yours or the one from Krzysztof? Because both reviews are contradictory
>>
> 
> There are a lot of "vol-down", "vol-up" (etc) instances, lots of which are on
> Qualcomm device-trees... so I guess this is just about personal preference...
> 
> Honestly, before sending my review I forgot to check Krzysztof's one (sorry!!),
> but I think that this kind of node names is highly subjective... at least, I am
> not aware of any rule about having to use "generic" names.

Node names should be generic, not descriptive. See Devicetree specification:
"The name of a node should be somewhat generic, reflecting the function
of the device and not its precise programming
 model. If appropriate, the name should be one of the following choices:
...
- keyboard

- key

- keys
"

I prefer key-0 but "volup-key" or "key-volup" could work too (but these
are still specific, not generic).

Using other DTS as examples is wrong, because most of submissions are
wrong and almost half of my bindings and DTS reviews include that
comment - generic node names. To be fair, most of my DTS contributions
also contained specific node names till I learnt that rule...

Anyway, it's not that important. :)

Thanks for other changes in the DTS.

> 
> Check Documentation/devicetree/bindings/input/gpio-keys.yaml - in the example,
> you can find "specific" node names, like:
> 
>          up {
> 
>              label = "GPIO Key UP";
> 
> In any case, as I said, it's my personal preference to have it named as something
> like "key-volup" or "vol-up" or .. a name that is describing the key, but, as a
> personal preference, it is nothing mandatory, not even from my side.
> 
> If anyone else has reasons to disagree, shrug, it's fine :))


Best regards,
Krzysztof
