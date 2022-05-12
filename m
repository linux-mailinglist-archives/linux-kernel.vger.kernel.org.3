Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42CBE52507F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 16:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355534AbiELOpd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 10:45:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355136AbiELOp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 10:45:29 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1EF9261956
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 07:45:27 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id s11so2737284edy.6
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 07:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=86Y3qB2Q1oABTG6e44OykaTrEHahmd3AvCtiNg4nxpQ=;
        b=LKZ8InSLVqhaLckt9graInopCDghzh23IQLi6bZa0Gn3VD/huah0HRk9cMwuwePD0I
         xM/uLMYjArAzV514ulNocAlSSn28zvAfQ538sU9lVzd9E7L1ubNLKCVHgOwzWkwGGwqg
         Jn2Jmqt7VwLU38PIN6zrhzKCDpaNFHAg7oEyyHU7JuwKDifwXNrEz4UVOjfkUjDhNM4s
         TgGFFwjQSHh6GFypJWP9mXBRu6g3zEh1kAkjm1jmPj+8QSzQWT/LMmex9jHhrAFJg7Pn
         LZkf/5CWOwP6UqKg2afYIn3ihmcQIARNqscAyBr6ArJcioPn79Pkd3L6lHMg7z3HfePD
         hdOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=86Y3qB2Q1oABTG6e44OykaTrEHahmd3AvCtiNg4nxpQ=;
        b=bFbrgWqR9QOVbM90xtpoKgBwsik7kqxShK2GQyRN4zBigGZsEZt7YBMOyKW7g/8HJn
         IeNy7Nma/mp9s63UIpvpfi225boMHpeZ1mIKd3e4nEb66fN1wolT/N/tAsHQbbkd38zV
         bV3pYN2EGZN/X/jiCqgwAmFM/K0geREx86s/3LPjcpKJ2S0D3dm+e/+vskKxoCtPbWPN
         Nb8p9WE1M5jOM9GlfCWORPj8+I59t71EU6GAaMRjOeg2UphBs7iRX20NfDIDJk7tYoe0
         QAq5usduo9Wq5AetkCmnyQTmNpqe8Ye24aYWtnUwnbn4yHGyW+ig5CTVQuG/vMQb7aRO
         QlHA==
X-Gm-Message-State: AOAM530NNn9TeZcEcKUU97BPf6VE/EabIG3LjJRwSQlnAYlSQgQJM+iu
        9CvOJnpEmRmJj/mgiW0oEaOujg==
X-Google-Smtp-Source: ABdhPJwjNCFMDty7OszTUnQ7n5hySx0R/Cjtvd6LjeVbwgLA/J+s5+SVWUtKKOaSIWSe5+4XSC0agA==
X-Received: by 2002:a05:6402:2750:b0:428:53bb:3433 with SMTP id z16-20020a056402275000b0042853bb3433mr35611673edd.22.1652366726344;
        Thu, 12 May 2022 07:45:26 -0700 (PDT)
Received: from [192.168.0.161] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id sb12-20020a1709076d8c00b006f3ef214e04sm2129101ejc.106.2022.05.12.07.45.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 May 2022 07:45:25 -0700 (PDT)
Message-ID: <5ec00142-dc46-06e6-c991-c33394db614c@linaro.org>
Date:   Thu, 12 May 2022 16:45:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v6 2/3] arm64: dts: marvell: Add Armada 98DX2530 SoC and
 RD-AC5X board
Content-Language: en-US
To:     Chris Packham <Chris.Packham@alliedtelesis.co.nz>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "andrew@lunn.ch" <andrew@lunn.ch>,
        "gregory.clement@bootlin.com" <gregory.clement@bootlin.com>,
        "sebastian.hesselbarth@gmail.com" <sebastian.hesselbarth@gmail.com>,
        "kostap@marvell.com" <kostap@marvell.com>,
        "robert.marko@sartura.hr" <robert.marko@sartura.hr>,
        Vadym Kochan <vadym.kochan@plvision.eu>
Cc:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <20220510231002.1160798-1-chris.packham@alliedtelesis.co.nz>
 <20220510231002.1160798-3-chris.packham@alliedtelesis.co.nz>
 <1372f51c-0158-dbe3-a0bf-aeeb83f4fec3@linaro.org>
 <48c5ce46-906b-3aaa-afcc-8d0eafbd098c@alliedtelesis.co.nz>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <48c5ce46-906b-3aaa-afcc-8d0eafbd098c@alliedtelesis.co.nz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/05/2022 01:49, Chris Packham wrote:
> 
>>> +		spi_clock: spi-clock {
>>> +			compatible = "fixed-clock";
>>> +			#clock-cells = <0>;
>>> +			clock-frequency = <200000000>;
>>> +		};
>> My questions about these clocks are still unanswered. Why do you define
>> fixed-clocks. Aren't these part of clock controller?
> 
> Not one that I have any information on. Marvell don't put it in their 
> customer facing documentation so I can only speculate. The 25MHz 
> oscillator goes into the chip, from there I guess that it is fed in some 
> fashion to both the CPU block (CnM in Marvell speak) and to the switch 
> block. Where exactly it gets divided into these individual peripheral 
> clocks I don't really know.

Hm, so it seems you do not have a proper clock-controller (or cannot
create one). OK then, but these are silly stubs, you know. :)

> 
>>> +	};
>>> +};
>>> diff --git a/arch/arm64/boot/dts/marvell/rd-ac5x.dts b/arch/arm64/boot/dts/marvell/rd-ac5x.dts
>>> new file mode 100644
>>> index 000000000000..7ac87413e023
>>> --- /dev/null
>>> +++ b/arch/arm64/boot/dts/marvell/rd-ac5x.dts
>>> @@ -0,0 +1,90 @@
>>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>>> +/*
>>> + * Device Tree For AC5X.
>>> + *
>>> + * Copyright (C) 2021 Marvell
>>> + *
>>> + */
>>> +/*
>>> + * Device Tree file for Marvell Alleycat 5X development board
>>> + * This board file supports the B configuration of the board
>>> + */
>>> +
>>> +/dts-v1/;
>>> +
>>> +#include "armada-98dx2530.dtsi"
>>> +
>>> +/ {
>>> +	model = "Marvell RD-AC5X Board";
>>> +	compatible = "marvell,ac5x", "marvell,ac5";
>>  From the bindings I understood ac5x is a SoC, not board. If ac5x is a
>> board, not a SoC, then compatible should be rather "marvell,rd-ac5x".
> 
> So If I understand the convention the full compatible would be:
> 
> compatible = "marvell,rd-ac5x", "marvell,ac5x", "marvell,ac5";

Yes, this looks correct.

> 
>>
>>> +
>>> +	memory@0 {
>>> +		device_type = "memory";
>>> +		reg = <0x2 0x00000000 0x0 0x40000000>;
>>> +	};
>>> +};
>>> +
>>> +&mdio {
>>> +	phy0: ethernet-phy@0 {
>>> +		reg = <0>;
>>> +	};
>>> +};
>>> +
>>> +&i2c0 {
>>> +	status = "okay";
>>> +};
>>> +
>>> +&i2c1 {
>>> +	status = "okay";
>>> +};
>>> +
>>> +&eth0 {
>>> +	status = "okay";
>>> +	phy-handle = <&phy0>;
>>> +};
>>> +
>>> +&usb0 {
>>> +	status = "okay";
>>> +};
>>> +
>>> +&usb1 {
>>> +	status = "okay";
>>> +};
>>> +
>>> +&spi0 {
>>> +	status = "okay";
>>> +
>>> +	spiflash0: flash@0 {
>>> +		compatible = "jedec,spi-nor";
>>> +		spi-max-frequency = <50000000>;
>>> +		spi-tx-bus-width = <1>; /* 1-single, 2-dual, 4-quad */
>>> +		spi-rx-bus-width = <1>; /* 1-single, 2-dual, 4-quad */
>>> +		reg = <0>;
>>> +
>>> +		#address-cells = <1>;
>>> +		#size-cells = <1>;
>>> +
>>> +		partition@0 {
>>> +			label = "spi_flash_part0";
>>> +			reg = <0x0 0x800000>;
>>> +		};
>>> +
>>> +		parition@1 {
>>> +			label = "spi_flash_part1";
>>> +			reg = <0x800000 0x700000>;
>>> +		};
>>> +
>>> +		parition@2 {
>>> +			label = "spi_flash_part2";
>>> +			reg = <0xF00000 0x100000>;
>>> +		};
>>> +	};
>>> +};
>>> +
>>> +&usb1 {
>>> +	compatible = "chipidea,usb2";
>> Why compatible is defined per board?
> 
> That came from the Marvell SDK. On some boards this is used as a 
> device/OTG interface. But regardless it should have one in the SoC dtsi. 

Yes, please.

> As for why they used the "chipidea,usb2" compatible I have no idea. I'll 
> remove this and add the correct compatible to the SoC.

They could reuse some other block. Pretty often for such cases there is
a dedicated compatible and fallback, e.g.:
Documentation/devicetree/bindings/usb/rockchip,dwc3.yaml

Best regards,
Krzysztof
