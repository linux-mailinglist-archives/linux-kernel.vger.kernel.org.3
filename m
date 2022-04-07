Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F4B94F8962
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 00:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbiDGVA3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 17:00:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbiDGVA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 17:00:26 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADA2C15E88F
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 13:58:18 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id g20so7850142edw.6
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 13:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=gOv/51dHbvSvAxLzxG0YE6pJrgjLizkZFj88kA5U1Ts=;
        b=LtV+LimrEebMzUK1IOhvEXGb2ymNgMZl7qh+Db0K2zNRN9P2+inYAeLmBHYB2w6OkO
         mn/kik52wDH8tc8FUpvnPbCEntUH62DwQiMG6ydiIqlYKJmkEYvdOUC8WI9fYcl0ysB1
         H6FwSKAovj274rvZkqlyUAzRkERYk49kh8aZUoMkYXZSgZxVakbuGIBuJ5MwSay6PeWy
         mzuQZ7aln0oPp2FhclYJyvKN5snzc2HBQQSTWgLAs7rRk1QNqx4VpUvRU2ENIa5w2Yxt
         4cczopCH7g7pzQE8kYQ/fYdIrqeKWaHCjByr9giggQf34469Y2UAfBvapmZcmSD+hqiH
         /fjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=gOv/51dHbvSvAxLzxG0YE6pJrgjLizkZFj88kA5U1Ts=;
        b=0ZnPgwW/2RtecoJ5mDGIh++3mFgEEeRw7yWxi95jCSL9daz9eeEhfXSg4abNb0v7yQ
         wdkfBK79cZV16ufL8gzw+8MwXeKgh+FSFryOhLKc8S4eOn/ac58ytF/J1VRLsDzki+sy
         45hygOd+qH8uCJDnDgWlEaROKAVJGRJWkyUlieLSUd2D19l1GCfsUe3H9mp2XWs6ij7Z
         b6KYpqrLz9vuP1dQbHwl9MMPutwTBLHmbmTPFm4tFDs5IJGD4X2NDkXD7xlrGIpITJQD
         wjb8gPojju09Ox2+0TjvhBVPgdSmU1AgU23KkYyCwgLo+QQAVsKk0FA9S8l+dkGiQv3P
         ZbMw==
X-Gm-Message-State: AOAM530p4A079J0AOCGZefjDbx0Mv7KagSIX+y04IgTj5oDODIZx8l9m
        UrZS1Z9A1DDJvYGEf0XHMcPjIA==
X-Google-Smtp-Source: ABdhPJzKZKgo7bJk0AYUXlwb2y8mbmmQYcn7Gd1R46cDu+04zIt7arhMKkYnlMab8y4eU6cP1/Q3hg==
X-Received: by 2002:a05:6402:3604:b0:41c:c4e6:2988 with SMTP id el4-20020a056402360400b0041cc4e62988mr16115607edb.157.1649365097189;
        Thu, 07 Apr 2022 13:58:17 -0700 (PDT)
Received: from [192.168.0.187] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id b11-20020a17090630cb00b006e83fb1e6b1sm738450ejb.100.2022.04.07.13.58.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Apr 2022 13:58:16 -0700 (PDT)
Message-ID: <827e5f9c-13ef-08fb-d167-80c6c4ea5631@linaro.org>
Date:   Thu, 7 Apr 2022 22:58:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 11/11] arm64: dts: Add Pensando Elba SoC support
Content-Language: en-US
To:     Brad Larson <brad@pensando.io>,
        linux-arm-kernel@lists.infradead.org
Cc:     arnd@arndb.de, linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        broonie@kernel.org, fancer.lancer@gmail.com,
        adrian.hunter@intel.com, ulf.hansson@linaro.org, olof@lixom.net,
        dac2@pensando.io, linux-gpio@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220406233648.21644-1-brad@pensando.io>
 <20220406233648.21644-12-brad@pensando.io>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220406233648.21644-12-brad@pensando.io>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/04/2022 01:36, Brad Larson wrote:
> Add Pensando common and Elba SoC specific device nodes
> 
> Signed-off-by: Brad Larson <brad@pensando.io>
> ---
> Change from V3:
> - Changed to dual copyright (GPL-2.0+ OR MIT)
> - Minor changes from review input

Thank you for your patch. There is something to discuss/improve.

(...)

> +&i2c0 {
> +	clock-frequency = <100000>;
> +	status = "okay";
> +	rtc@51 {
> +		compatible = "nxp,pcf85263";
> +		reg = <0x51>;
> +	};
> +};
> +
> +&spi0 {
> +	num-cs = <4>;
> +	cs-gpios = <0>, <0>, <&porta 1 GPIO_ACTIVE_LOW>,
> +		   <&porta 7 GPIO_ACTIVE_LOW>;
> +	status = "okay";
> +	spi0_cs0@0 {

Generic node name needed matching the class of a devicxe.

> +		compatible = "semtech,sx1301";	/* Enable spidev */

This comment is a bit odd... did you just use random compatible from
spidev instead of defining proper compatible?


> +		#address-cells = <1>;
> +		#size-cells = <1>;

Why address/size cells?

> +		spi-max-frequency = <12000000>;
> +		reg = <0>;

Please put reg just after compatible. It's the most common pattern.

> +	};
> +
> +	spi0_cs1@1 {
> +		compatible = "semtech,sx1301";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		spi-max-frequency = <12000000>;
> +		reg = <1>;
> +	};
> +

(...)

> +
> +		emmc: mmc@30440000 {
> +			compatible = "pensando,elba-sd4hc", "cdns,sd4hc";
> +			clocks = <&emmc_clk>;
> +			interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
> +			reg = <0x0 0x30440000 0x0 0x10000>,
> +			      <0x0 0x30480044 0x0 0x4>;	/* byte-lane ctrl */
> +			cdns,phy-input-delay-sd-highspeed = <0x4>;
> +			cdns,phy-input-delay-legacy = <0x4>;
> +			cdns,phy-input-delay-sd-uhs-sdr50 = <0x6>;
> +			cdns,phy-input-delay-sd-uhs-ddr50 = <0x16>;
> +			mmc-ddr-1_8v;
> +			status = "disabled";
> +		};
> +
> +		mssoc: mssoc@307c0000 {

Generic node name.

> +			compatible = "syscon", "simple-mfd";

This does not look correct. Syscon is okay, but why do you need
simple-mfd (there are no children here)?

> +			reg = <0x0 0x307c0000 0x0 0x3000>;
> +		};
> +	};
> +};


Best regards,
Krzysztof
