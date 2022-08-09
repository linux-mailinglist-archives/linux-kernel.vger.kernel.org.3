Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23BE958D33A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 07:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234039AbiHIFf0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 01:35:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbiHIFfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 01:35:23 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9125410549
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 22:35:21 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id o2so8242184lfb.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 22:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=CLBtSz5zowSZP2ptgXBelVuwhiidhEQF9DkU5FwAQ2o=;
        b=MIpIA6sm7TY729nBdnH4Wjr8uM1YUZ558QURpKR1u4L6EukE1jenbkTuOPMgrdlh7I
         y64Rd1JDLgrBmydt+dOufa6MsrJ8A0KKSQKIz1ym3JS+Tm72PR+sAbNLdqeh81rVeiV6
         0oIPXwJyLmtA0jIq5cDmoiQrlGiriLCxmIyTsP5W38yajddj+q316fl2NnVSUZsBCTsb
         U7onCSrDA3qRVMG91zDQv2bixKEo96W4h94qKqJO+uNe2XsH79owEtjkBd6yaYRpSSNU
         OStd7KBlAMSexeY3jL0xH4PDeBsLHx9OjWzTB9DW3mO2Rlzpe+wssVNThK9J93hgw/y9
         qJwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=CLBtSz5zowSZP2ptgXBelVuwhiidhEQF9DkU5FwAQ2o=;
        b=fTe1sqUtdkmkawGF0V8cfYNfSqoBGvBWi8cJeci+b8IqGdBuwcM3pvKK1vZSu0mg2B
         hljwUNt3O4Cb5yk+onWRrh8AtqwswNOrz4IminRwPGKr/uB/IPKupyxf8FnH0G1dyGx3
         XYgXCGC/oFNmVd4qS6ZMwwqRdBE1O51lJjj1DVtINtn7Vz7KycYHrhu84kUy+duY+iUe
         cUF/tGbZ8Q897TTo+v0toOGlZ9VReFFgwZbfZtJ5Zje9LA1xE+ngOXjfA9ec/kOkMRxn
         aSmnnt+6Znnd16d6dI8Aqm4Y7XSvqDm9lHSlt0ENMVTvikMgfo71MosYQpei+W0k/HcJ
         eCYA==
X-Gm-Message-State: ACgBeo050tNRKHbwfH+MI5am9MMbO7/eHyk0kp2MMlAB9y3i4OQnyNf3
        g4uHZ34S3mQa93QonWMEk8Batw==
X-Google-Smtp-Source: AA6agR5fYMdcvjSWJZrYBeyOmmE7yWtMoqDT5jX7CoahSz6MfG2ZP8zWFR9aonG3W/hDYJLVtWYDBw==
X-Received: by 2002:a05:6512:2390:b0:48c:ef98:4103 with SMTP id c16-20020a056512239000b0048cef984103mr2172907lfv.265.1660023319961;
        Mon, 08 Aug 2022 22:35:19 -0700 (PDT)
Received: from [192.168.1.39] ([83.146.140.105])
        by smtp.gmail.com with ESMTPSA id e15-20020a05651236cf00b0047255d211b2sm1633301lfs.225.2022.08.08.22.35.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Aug 2022 22:35:19 -0700 (PDT)
Message-ID: <27f83048-ac75-97eb-c9f0-0829de30e1ad@linaro.org>
Date:   Tue, 9 Aug 2022 08:35:18 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2 2/2] ARM: msm8960: Add Samsung Galaxy Express support
Content-Language: en-US
To:     Rudraksha Gupta <guptarud@gmail.com>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, david@ixit.cz,
        devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org
References: <20220808234723.5184-2-guptarud@gmail.com>
 <20220809000300.6384-1-guptarud@gmail.com>
 <20220809000300.6384-2-guptarud@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220809000300.6384-2-guptarud@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/08/2022 03:03, Rudraksha Gupta wrote:
> This adds a very basic device tree file for the Samsung Galaxy Express
> SGH-I437. Currently, the following things work: UART, eMMC, SD Card, and
> USB.

Use subject prefix matching the subsystem.

> 
> Signed-off-by: Rudraksha Gupta <guptarud@gmail.com>
> ---
> v2:
>  - Group the correct changes together
> 
>  arch/arm/boot/dts/Makefile                    |   1 +
>  .../dts/qcom-msm8960-samsung-expressatt.dts   | 337 ++++++++++++++++++
>  2 files changed, 338 insertions(+)
>  create mode 100644 arch/arm/boot/dts/qcom-msm8960-samsung-expressatt.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 05d8aef6e5d2..d55f196ad733 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -1049,6 +1049,7 @@ dtb-$(CONFIG_ARCH_QCOM) += \
>  	qcom-msm8660-surf.dtb \
>  	qcom-msm8916-samsung-serranove.dtb \
>  	qcom-msm8960-cdp.dtb \
> +	qcom-msm8960-samsung-expressatt.dtb \
>  	qcom-msm8974-lge-nexus5-hammerhead.dtb \
>  	qcom-msm8974-sony-xperia-rhine-amami.dtb \
>  	qcom-msm8974-sony-xperia-rhine-honami.dtb \
> diff --git a/arch/arm/boot/dts/qcom-msm8960-samsung-expressatt.dts b/arch/arm/boot/dts/qcom-msm8960-samsung-expressatt.dts
> new file mode 100644
> index 000000000000..cf557f0c9a59
> --- /dev/null
> +++ b/arch/arm/boot/dts/qcom-msm8960-samsung-expressatt.dts
> @@ -0,0 +1,337 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +#include <dt-bindings/input/input.h>
> +#include "qcom-msm8960.dtsi"
> +
> +/ {
> +	model = "Samsung Galaxy S3 SGH-I437";
> +	compatible = "samsung,expressatt", "qcom,msm8960";

Undocumented compatible. Run checkpatch.

> +
> +	aliases {
> +		serial0 = &gsbi5_serial;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges;

These three properties are confusing. Why adding them?


> +	};
> +
> +	soc {
> +		gsbi@16400000 {

Override by alias.

> +			status = "ok";

okay, not ok. Status goes at the end of properties.


> +			qcom,mode = <GSBI_PROT_I2C_UART>;
> +			serial@16440000 {
> +				status = "ok";

Same comments.

> +			};
> +		};
> +
> +		amba {
> +			/* eMMC */
> +			sdcc1: mmc@12400000 {

OK, I'll abandon the review. This file is really not matching anything
in the upstream. Please start your work from a proper upstreamed, recent
board.

Best regards,
Krzysztof
