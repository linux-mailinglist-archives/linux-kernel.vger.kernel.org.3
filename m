Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 342CA58A7FC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 10:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240461AbiHEIWr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 04:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbiHEIWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 04:22:44 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DF5710559
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 01:22:42 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id v7so2303593ljj.4
        for <linux-kernel@vger.kernel.org>; Fri, 05 Aug 2022 01:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=1LJkG8nBPlONg+x2ajiEWGYMKRAAVhUFaBW+yRjYWwg=;
        b=VE7n5YEEOa/h0CyMrnEPdxz2csLw4AH7Q2IY4fzE2wNIzl9m5aWXDCKCG0E79/l6Cu
         dt0JrNlzdJu6Pnb8inJYmBf/mWcPtrZlbOD5KAlrIoDbN8vjxjkCCgC3wsfWKWHw1Src
         YuzQcDSrraqDXLo5IY8Q66Z2DQQcQKbGD0lWlTWTsobBWK5+UJXdIkK2UMJShjiKzVKP
         d3ldbpv0gGslMewtbyKKLi+HymEO9VzGTui9I/O7JxsrDs9y/oy2Ezh6tIrEqZj1F826
         kC61je8BYT8rg35iQwhX9xV3Emg4bog8WeY3ws/6tHV+n98X+QXWHCAdSS9LmCc5TEld
         oRRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=1LJkG8nBPlONg+x2ajiEWGYMKRAAVhUFaBW+yRjYWwg=;
        b=DoGhN1k3PfvT/rnlhyUAWLpnjc3eXcRNtmQCspRp8SnVQ4/yIIwfilbmp49W0EUEQc
         RXiQK0wCHkBivhggV6u5e6JHahFgQDc2yxpyM9oajcUhFyXMAlVlN4b/BIM1WCJdhfxg
         Ps89dWdU58IarMZBtcyaRowo9u36HmBOm9Qp4QAk8kLE/X9l8imppuSPd5jbBAtz+Tjx
         82bRW71KoOvqYgYz5PTCN0NtTEMIcvlJYUFDODNZk4CoXWpQnV2eRb7DvBiO6rh2H2Zh
         sOpdZwnTvF5H4AJgdsiYkUKRpATj7JvpF7mOufjOzJ4OLq/o4MFUREVgLu12csWgPLvx
         /W8w==
X-Gm-Message-State: ACgBeo11xs0P9DxAqo8a6MUwvqxxzg3bK909YTELLhH7Tn8AoFCdpfaQ
        f7xSNyGp06+AaO7dhVeHGd7OEw==
X-Google-Smtp-Source: AA6agR7Ea9geoQMbksv44W2F3UjwGOSjIA1BDHbmoxPxU7bOoaGRaiHypXeMwUPEiZCLYO+nt0xYEQ==
X-Received: by 2002:a05:651c:3d9:b0:25e:505f:2355 with SMTP id f25-20020a05651c03d900b0025e505f2355mr1843178ljp.453.1659687760949;
        Fri, 05 Aug 2022 01:22:40 -0700 (PDT)
Received: from [192.168.1.6] ([77.222.167.48])
        by smtp.gmail.com with ESMTPSA id s15-20020a056512314f00b0048aea84fa80sm392189lfi.87.2022.08.05.01.22.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Aug 2022 01:22:40 -0700 (PDT)
Message-ID: <e963157e-5ff0-f0c1-2299-50528cf291c3@linaro.org>
Date:   Fri, 5 Aug 2022 10:22:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v4 3/4] arm64: dts: meson: Add DDR PMU node
Content-Language: en-US
To:     Jiucheng Xu <jiucheng.xu@amlogic.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Chris Healy <cphealy@gmail.com>
References: <20220805071426.2598818-1-jiucheng.xu@amlogic.com>
 <20220805071426.2598818-3-jiucheng.xu@amlogic.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220805071426.2598818-3-jiucheng.xu@amlogic.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/08/2022 09:14, Jiucheng Xu wrote:
> Add DDR PMU device node for G12 series SoC
> 
> Signed-off-by: Jiucheng Xu <jiucheng.xu@amlogic.com>
> ---
> Changes v3 -> v4:
>   - No change
> 
> Changes v2 -> v3:
>   - No change
> 
> Changes v1 -> v2:
>   - Remove model, dmc_nr, chann_nr properties
>   - Add g12a-ddr-pmu, g12b-ddr-pmu, sm1-ddr-pmu compatibles as
>     identifier
> ---
>  arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi | 7 +++++++
>  arch/arm64/boot/dts/amlogic/meson-g12a.dtsi       | 4 ++++
>  arch/arm64/boot/dts/amlogic/meson-g12b.dtsi       | 4 ++++
>  arch/arm64/boot/dts/amlogic/meson-sm1.dtsi        | 4 ++++
>  4 files changed, 19 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
> index 45947c1031c4..7e556fe575be 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
> @@ -2146,6 +2146,13 @@ hdmi_tx_out: endpoint {
>  			};
>  		};
>  
> +		ddr_pmu: ddr_pmu@ff638000 {

No underscores in node names.

Node names should be generic, so pmu.
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

> +			compatible = "amlogic,g12-ddr-pmu";
> +			reg = <0x0 0xff638000 0x0 0x100
> +			       0x0 0xff638c00 0x0 0x100>;
> +			interrupts = <GIC_SPI 52 IRQ_TYPE_EDGE_RISING>;
> +		};
> +
>  		gic: interrupt-controller@ffc01000 {
>  			compatible = "arm,gic-400";
>  			reg = <0x0 0xffc01000 0 0x1000>,
> diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
> index fb0ab27d1f64..4a32e081e70e 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
> @@ -133,3 +133,7 @@ map1 {
>  		};
>  	};
>  };
> +
> +&ddr_pmu {
> +	compatible = "amlogic,g12a-ddr-pmu";
> +};

Adding nodes at the end causes conflicts. They should be added in some
order...

Best regards,
Krzysztof
