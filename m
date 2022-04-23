Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D6A550C97B
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 13:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235127AbiDWLEn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 07:04:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235119AbiDWLEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 07:04:41 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D556EE72
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 04:01:44 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id u15so20792666ejf.11
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 04:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=LHmY2xwINMDmsMCSFyrWvP32U1UFWvxcjtuJ1jWoEo8=;
        b=bkfUnXTW6NgiKWqZqKm6y1XcF0ll1Wi4GL/LHk+5jJhoRjFZHxscMDoB0k0O+kmHYb
         8k6jnRkGfummRkLgNxvnIbdLm1e+5IWzNijpkAy/qPT/BW1XJT08YqO8gpvGpyYehi6m
         narNu7bN2eO/SNCgB3j+CH947E+qMEjaaRrV0V826M98pmTthzLdIhNRrbR6NGObItDJ
         qjRIznmZBcLUSsUvvTWDu9DHrr7co19vFtFUYRHIv6gIZgJhBUwfD2AyzFOK7U0Z32W+
         RFF0+h86wBwqPTLcFyQvgOTXosG8+MzkMgASYdZeXOnFDOt4ItYQJe4NDGWDjX6p9Dh8
         7xiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=LHmY2xwINMDmsMCSFyrWvP32U1UFWvxcjtuJ1jWoEo8=;
        b=CIetnVHdlnW8C1VH1HZqElZWfl+Pq9IZgSE24v1I7sdbKiphHme397DozLOdymyXoO
         LcetlEJAy0PY4uwR6zjYBRuE7tL+1y27PbhAFfzygn36GXoIQFjEb4O48WzG+56+5RDl
         SKFop7tsJnGMzDmltdVqcWG3mZLuvVl7LQGdVSYttN7+vUTnXBEgBESL5WvBlvBAyF1b
         XNF5qtuV0B6C3zF+Gf2+cZFgRx39P4vIFGSCVSV06Qyzwft9S4Cqns9iwf8QGxORHeaW
         1cWF29pHsW/GKaYkK1qVVXb368JT5gKMqUW7tckwID+jIwvQQk5hky2L1v9iGq9c6oJf
         3XAQ==
X-Gm-Message-State: AOAM5328BDe9fGajHr+famUW94lR1NSBia3yQ6mnrSWUGDn04tpyuJbu
        bUtDomOAmf/izRKJul7DKR8rYQ==
X-Google-Smtp-Source: ABdhPJx7f3eBltsR1q92iRD15gznKevMrDm2DUl4St7PblCWhjHPBTDP7o+4TaC9xxn8R/mIUe1JMQ==
X-Received: by 2002:a17:906:99c1:b0:6ef:d995:11ac with SMTP id s1-20020a17090699c100b006efd99511acmr7668019ejn.244.1650711703402;
        Sat, 23 Apr 2022 04:01:43 -0700 (PDT)
Received: from [192.168.0.234] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id lb26-20020a170907785a00b006ea4d2928e5sm1569590ejc.218.2022.04.23.04.01.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Apr 2022 04:01:42 -0700 (PDT)
Message-ID: <7a4222dc-35ee-4809-9e16-64aadf00081a@linaro.org>
Date:   Sat, 23 Apr 2022 13:01:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v5 10/11] arch: arm: boot: dts: Introduce HPE GXP Device
 tree
Content-Language: en-US
To:     nick.hawkins@hpe.com, verdun@hpe.com, joel@jms.id.au,
        arnd@arndb.de, openbmc@lists.ozlabs.org
Cc:     Olof Johansson <olof@lixom.net>, soc@kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220421192132.109954-1-nick.hawkins@hpe.com>
 <20220421192132.109954-11-nick.hawkins@hpe.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220421192132.109954-11-nick.hawkins@hpe.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/04/2022 21:21, nick.hawkins@hpe.com wrote:
> From: Nick Hawkins <nick.hawkins@hpe.com>
> 

Thank you for your patch. There is something to discuss/improve.

> +/include/ "hpe-gxp.dtsi"
> +
> +/ {
> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +	compatible = "hpe,gxp-dl360gen10","hpe,gxp";

Missing space after ','.

> +	model = "Hewlett Packard Enterprise ProLiant dl360 Gen10";
> +};
> diff --git a/arch/arm/boot/dts/hpe-gxp.dtsi b/arch/arm/boot/dts/hpe-gxp.dtsi
> new file mode 100644
> index 000000000000..a3a082d21101
> --- /dev/null
> +++ b/arch/arm/boot/dts/hpe-gxp.dtsi
> @@ -0,0 +1,128 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Device Tree file for HPE GXP
> + */
> +
> +/dts-v1/;
> +/ {
> +	model = "Hewlett Packard Enterprise GXP BMC";
> +	compatible = "hpe,gxp","hpe,gxp-dl360gen10";

The same.

> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		cpu@0 {
> +			compatible = "arm,cortex-a9";
> +			reg = <0>;
> +			device_type = "cpu";
> +		};
> +	};
> +
> +	clocks {
> +

No need for blank line.

> +		pll: pll {

Generic node names, so either "clock-0" or "pll-clock"

> +			compatible = "fixed-clock";
> +			#clock-cells = <0>;
> +			clock-frequency = <1600000000>;
> +		};
> +
> +		iopclk: iopclk {

"clock-1" or "iop-clock"

> +			compatible = "fixed-factor-clock";
> +			#clock-cells = <0>;
> +			clock-div = <4>;
> +			clock-mult = <1>;
> +			clocks = <&pll>;
> +		};
> +	};

(...)

> +
> +			usb0: usb@efe0000 {
> +				compatible = "hpe,gxp-ehci","generic-ehci";

Here and in other places - always missing a space.

> +				reg = <0xefe0000 0x100>;
> +				interrupts = <7>;
> +				interrupt-parent = <&vic0>;
> +			};
> +
> +			st: timer@80 {
> +				compatible = "hpe,gxp-timer","simple-mfd";
> +				reg = <0x80 0x16>;
> +				interrupts = <0>;
> +				interrupt-parent = <&vic0>;
> +				clocks = <&iopclk>;
> +				clock-names = "iopclk";
> +				watchdog {
> +					compatible = "hpe,gxp-wdt";
> +				};
> +			};
> +
> +			usb1: usb@efe0100 {
> +				compatible = "hpe,gxp-ohci","generic-ohci";
> +				reg = <0xefe0100 0x110>;
> +				interrupts = <6>;
> +				interrupt-parent = <&vic0>;
> +			};
> +		};
> +	};
> +

No need for blank line.

> +};


Best regards,
Krzysztof
