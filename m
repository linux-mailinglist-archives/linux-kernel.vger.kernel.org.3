Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3F654F22E9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 08:13:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbiDEGPE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 02:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbiDEGPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 02:15:01 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2F9C6A019
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 23:13:03 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a6so13534044ejk.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 23:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=rZeprPWOtqKRGMgfqMRvv0PvLM+lTF/w3B6BQ9TTNXg=;
        b=Ng5jt/B96yk3lkXFR+3TAdD6coPaC5Hx76Pu8opMabaJwCQN7vIv975l6acHKa66cP
         mukI7V/b36aEA3niPOEAvU83i4RROk+mfgoJtY6nrHiFzgyUry0PuX1oxclM9TU1bkjl
         6wEQi9waenyT9WCNeHYBHg8klOAinEYbMIB6iSaVd4MKIQ6Qsrfv0ebOOhTzHYwWYelE
         LdOtc584ihPlzczA45nWxtdd/RCDDhTf73SKi3kYGAtwXn31Fd2zg/1c+G9Wrlh3sX3i
         +I7V6PRRT2wXRz8yv3LzP+bES6codvmVGrNdte6zmsFLNr+I9FxbIiRfQYn7AFL22Jip
         P2sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=rZeprPWOtqKRGMgfqMRvv0PvLM+lTF/w3B6BQ9TTNXg=;
        b=hYoNWTwnnhUd9g5agIGAPkUNdpqHxrMC/fs2BdTSgPwntp9CRkBJIB4yWX6GUJZpT3
         iADfjdUXbbx66CGfQoGM1bwez8f9E5FiV7ATMoXNKc70Pc/IU/241f7Nz0gYm+SAY5WS
         fcQalcQ9rejXJeSPSJy0TfZpr7nJG3akQPp0MosDBVLRXIRAw2Lsykd9sOJaRs61Unbs
         3bzjnkZkBR/GX4ydXa8znQUv0zgO9lCqP3psnT2l/Rjw1MTuKWMOxGXHZUhdt6ZHHvMz
         1WkAqex6IR4l6hLxOUwwuwuQvEVTnlxJ1wwBzjqQcWjAdn5XBrUVw0rg2r/bWJLV/YzK
         XvHA==
X-Gm-Message-State: AOAM532AfRxPMyjBUK0bHhuR+If2McDKpyYI4HdTy/3tLVScFa6OZbmm
        cnh+ftlBwyYAxbzLXnCFJ+xZvg==
X-Google-Smtp-Source: ABdhPJzhiqjVHwaMmE2HIwa9wbO5hpaWli1dKwQoRSQSdZPVfVvMH4WtmdyYT/m5YYLIABIsNv0ZtQ==
X-Received: by 2002:a17:907:3e1c:b0:6e4:e1b3:5384 with SMTP id hp28-20020a1709073e1c00b006e4e1b35384mr1892893ejc.700.1649139182083;
        Mon, 04 Apr 2022 23:13:02 -0700 (PDT)
Received: from [192.168.0.179] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id p13-20020a50d88d000000b0041cd1a083f7sm2655884edj.1.2022.04.04.23.13.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Apr 2022 23:13:01 -0700 (PDT)
Message-ID: <a50638db-d131-2083-d64e-a8164d377759@linaro.org>
Date:   Tue, 5 Apr 2022 08:13:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 2/2] arm64: dts: rockchip: Add Hardkernel ODROID-M1 board
Content-Language: en-US
To:     Dongjin Kim <tobetter@gmail.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220329094446.415219-1-tobetter@gmail.com>
 <20220329094446.415219-2-tobetter@gmail.com>
 <2a5f002f-8a61-e5b0-a574-ee99591c4c12@kernel.org> <YkuqTBAi8d48NAOR@anyang>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <YkuqTBAi8d48NAOR@anyang>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/04/2022 04:32, Dongjin Kim wrote:
> On Tue, Mar 29, 2022 at 07:12:16PM +0200, Krzysztof Kozlowski wrote:
>> On 29/03/2022 11:44, Dongjin Kim wrote:
>>> This patch is to add a device tree for new board Hardkernel ODROID-M1
>>> based on Rockchip RK3568, includes basic peripherals -
>>> uart/eMMC/uSD/i2c and on-board ethernet.
>>
>> I think the email got corrupted (incorrect To addresses).
>>
> Thank you for reviewing and sorry for late reply.
>>>
>>> Signed-off-by: Dongjin Kim <tobetter@gmail.com>
>>> ---
>>>  arch/arm64/boot/dts/rockchip/Makefile         |   1 +
>>>  .../boot/dts/rockchip/rk3568-odroid-m1.dts    | 406 ++++++++++++++++++
>>>  2 files changed, 407 insertions(+)
>>>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3568-odroid-m1.dts
>>>
>>> diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
>>> index 4ae9f35434b8..81d160221227 100644
>>> --- a/arch/arm64/boot/dts/rockchip/Makefile
>>> +++ b/arch/arm64/boot/dts/rockchip/Makefile
>>> @@ -61,3 +61,4 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-pinenote-v1.2.dtb
>>>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-quartz64-a.dtb
>>>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-evb1-v10.dtb
>>>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-bpi-r2-pro.dtb
>>> +dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-odroid-m1.dtb
>>> diff --git a/arch/arm64/boot/dts/rockchip/rk3568-odroid-m1.dts b/arch/arm64/boot/dts/rockchip/rk3568-odroid-m1.dts
>>> new file mode 100644
>>> index 000000000000..d1a5d43127e9
>>> --- /dev/null
>>> +++ b/arch/arm64/boot/dts/rockchip/rk3568-odroid-m1.dts
>>> @@ -0,0 +1,406 @@
>>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>>> +/*
>>> + * Copyright (c) 2022 Hardkernel Co., Ltd.
>>> + *
>>> + */
>>> +
>>> +/dts-v1/;
>>> +#include <dt-bindings/gpio/gpio.h>
>>> +#include <dt-bindings/leds/common.h>
>>> +#include <dt-bindings/pinctrl/rockchip.h>
>>> +#include "rk3568.dtsi"
>>> +
>>> +/ {
>>> +	model = "Hardkernel ODROID-M1";
>>> +	compatible = "rockchip,rk3568-odroid-m1", "rockchip,rk3568";
>>> +
>>> +	aliases {
>>> +		ethernet0 = &gmac0;
>>> +		i2c0 = &i2c3;
>>> +		i2c3 = &i2c0;
>>> +		mmc0 = &sdhci;
>>> +		mmc1 = &sdmmc0;
>>> +		serial0 = &uart1;
>>> +		serial1 = &uart0;
>>> +	};
>>> +
>>> +	chosen: chosen {
>>
>> No need for label.
>>
> Ok. Will fix it.
>>> +		stdout-path = "serial2:1500000n8";
>>> +	};
>>> +
>>> +	dc_12v: dc-12v {
>>
>> Generic node name, so "regulator" or "regulator-0"
>>
> I've followed the node names as already merged device tree files
> for other boards and thought this would be acceptable. Same for other
> node names 'vcc3v3-sys' and node names with underscore below.

Poor code once it gets in, it's difficult to get it out... Don't use it
as an example. :)


Best regards,
Krzysztof
