Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B819F4F87AE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 21:06:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236267AbiDGTI3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 15:08:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235718AbiDGTIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 15:08:25 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED0EC1B9899
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 12:06:23 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id x20so7506965edi.12
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 12:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=gOv/51dHbvSvAxLzxG0YE6pJrgjLizkZFj88kA5U1Ts=;
        b=O9N5piyZ8ghdKuId5L9aiMvkNuf62owbuCE+bZDTC6+xdnskK2aUwjkRUGOHdchCvA
         /J+QuQpbFJM/EfFm8RsWGeBGnPnBdya6DSH3nBGlfOGxOQfphaxLgDC+zzgMMt+VmjXu
         OSMZhW68bPY1HCTsk1/kZgPdo6KTzbrFSetJ89hvIb1T7A9C/NsRlGJk36F6rGcSxWLF
         js+BATsURtMBOD9XP5WBgZ8B9ahlWlXnGEpQSISIIdLvqgDDKE4wkVtb80Yln+Nyneo5
         sOOhyqrnY0o9IB8O7pFrrQJI/FsA2bBNe7fN2rsX34K5jkhc7gGS5VTCFiWFKPd1F1JU
         lubQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=gOv/51dHbvSvAxLzxG0YE6pJrgjLizkZFj88kA5U1Ts=;
        b=KJfHDg794cN6nucDhiDZ3eK8oXAo1tBnjPCGgj4vC4F2q6Fq1jxqIT54KfkLHsAgw8
         ESPio3HumFdq7UD2TGdpZSk2GAEwjlNbJbh6YdXv7qCt7mWORjA5qlJZMPiQoA8yHA1m
         /zaALaq7ZtuP1rbeScj/ftVWWfmxM+bFzPturQAxjlKHMR63Vi8nYJPNibtDBQ1p5pZw
         pFejbNVbi8lGy5eANd3DhfI0JEjN3c9yIOl2CA4jYOpduPQ6ApAQyBD/kNmhePIdbxGd
         vC2NaTGNu6dnLV9p7Orw24KKZarp4eHRhRJ9fSj/z/sBprNi6YRM9VJJR7J0EuwfU38o
         msYA==
X-Gm-Message-State: AOAM530YBwfDZ0Ww/QMget33+jBPeRsFw7qbN84s0V/dIluUeZ4AhMSd
        qiY79m4yyOiXfZb0Hu/Ybfo4Rg==
X-Google-Smtp-Source: ABdhPJyhh/Yt+dDqYCjKan4H/N0nxJOJereGCAdjBh0lD6wnLfFa+OHp2IVxiD8+UeuiyRjWGDtvFA==
X-Received: by 2002:a50:e79b:0:b0:41c:dd2c:3e19 with SMTP id b27-20020a50e79b000000b0041cdd2c3e19mr15774315edn.291.1649358382461;
        Thu, 07 Apr 2022 12:06:22 -0700 (PDT)
Received: from [192.168.0.187] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id q15-20020a1709060e4f00b006cdf4535cf2sm7890988eji.67.2022.04.07.12.06.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Apr 2022 12:06:21 -0700 (PDT)
Message-ID: <eed2f337-3d5a-3440-d19e-c5ff032409ab@linaro.org>
Date:   Thu, 7 Apr 2022 21:06:20 +0200
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
        autolearn=unavailable autolearn_force=no version=3.4.6
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
