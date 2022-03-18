Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 584354DD717
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 10:29:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234390AbiCRJa2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 05:30:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234222AbiCRJa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 05:30:26 -0400
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD6022E710D;
        Fri, 18 Mar 2022 02:29:07 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id p15so2444758lfk.8;
        Fri, 18 Mar 2022 02:29:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:content-language:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=r/KSxIU//Kws3RC8d1JZQRYfzJorheEdEELxh9Sq7qA=;
        b=2F6XDHOFeRVHgQgJwHSiTZG6g0T3ND7i4engvfIvHNpMsKG3k4LfqU0EEIYTfW8xvO
         IA1KBO1NjM/N/ffhTsh54iOTSFxNWo4Qif7uDrWpcDsBVjTKL0G/8V2xiifw1aoQN0cZ
         0og6nNsJjrOYsTIjadivCR7CiL1yNBd1XWuq0Q3oTou3WIyrayqebya+qUtjpdJ4D+m9
         1vEHXMPEGoN+9JUgto+AmhJ9611UtvkAqcPJa1BM4xV5G73Yxh73/1Mpmulmi6sIkMFE
         OYB7PSHIN3GZMq9/XwuUvB9nZl66YWVHbiyjS+vkkzeG2V183hUyaY4O1EcdiXmVstmY
         LkTA==
X-Gm-Message-State: AOAM533tYEZoCRJMEGtINc7G/LlcAFdsKVj6pUIavxKQ1lqpnZBYGMyk
        sYWr3fjOQaiws4lUz8lQI6SvNWEZiMk=
X-Google-Smtp-Source: ABdhPJx8xw66Z8uwazCQLCXROoTk/i0PVK2wYPF4n5X7S+EtHm/rvn1phJnuKrNseuP0HIrj1O+zqg==
X-Received: by 2002:a05:6512:228b:b0:448:92d7:892a with SMTP id f11-20020a056512228b00b0044892d7892amr5521975lfu.543.1647595746040;
        Fri, 18 Mar 2022 02:29:06 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.googlemail.com with ESMTPSA id x14-20020ac25dce000000b00448547b66a1sm764797lfq.266.2022.03.18.02.29.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Mar 2022 02:29:05 -0700 (PDT)
Message-ID: <67600921-a4ea-367e-6b45-c4a1a12ae88b@kernel.org>
Date:   Fri, 18 Mar 2022 10:29:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
From:   Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH 3/5 v2] dt-bindings: gnss: Rewrite sirfstar binding in
 YAML
Content-Language: en-US
To:     Linus Walleij <linus.walleij@linaro.org>,
        Johan Hovold <johan@kernel.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20220317225844.1262643-1-linus.walleij@linaro.org>
 <20220317225844.1262643-3-linus.walleij@linaro.org>
In-Reply-To: <20220317225844.1262643-3-linus.walleij@linaro.org>
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

On 17/03/2022 23:58, Linus Walleij wrote:
> This rewrites the SiRFstar DT bindings in YAML.
> 
> Cc: devicetree@vger.kernel.org
> Cc: Krzysztof Kozlowski <krzk@kernel.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v1->v2:
> - Change additionalProperties: false to uneavaluatedProperties: false
>   so new common properties get available immediately
> - This should also make the checker robot happy about
>   lna-supply
> ---
>  .../devicetree/bindings/gnss/sirfstar.txt     | 46 ------------
>  .../devicetree/bindings/gnss/sirfstar.yaml    | 71 +++++++++++++++++++
>  2 files changed, 71 insertions(+), 46 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/gnss/sirfstar.txt
>  create mode 100644 Documentation/devicetree/bindings/gnss/sirfstar.yaml
> 
> diff --git a/Documentation/devicetree/bindings/gnss/sirfstar.txt b/Documentation/devicetree/bindings/gnss/sirfstar.txt
> deleted file mode 100644
> index f4252b6b660b..000000000000
> --- a/Documentation/devicetree/bindings/gnss/sirfstar.txt
> +++ /dev/null
> @@ -1,46 +0,0 @@
> -SiRFstar-based GNSS Receiver DT binding
> -
> -SiRFstar chipsets are used in GNSS-receiver modules produced by several
> -vendors and can use UART, SPI or I2C interfaces.
> -
> -Please see Documentation/devicetree/bindings/gnss/gnss.txt for generic
> -properties.
> -
> -Required properties:
> -
> -- compatible	: Must be one of
> -
> -			"fastrax,uc430"
> -			"linx,r4"
> -			"wi2wi,w2sg0004"
> -			"wi2wi,w2sg0008i"
> -			"wi2wi,w2sg0084i"
> -
> -- vcc-supply	: Main voltage regulator (pin name: 3V3_IN, VCC, VDD)
> -
> -Required properties (I2C):
> -- reg		: I2C slave address
> -
> -Required properties (SPI):
> -- reg		: SPI chip select address
> -
> -Optional properties:
> -
> -- sirf,onoff-gpios	: GPIO used to power on and off device (pin name: ON_OFF)
> -- sirf,wakeup-gpios	: GPIO used to determine device power state
> -			  (pin name: RFPWRUP, WAKEUP)
> -- timepulse-gpios	: Time pulse GPIO (pin name: 1PPS, TM)
> -
> -Example:
> -
> -serial@1234 {
> -	compatible = "ns16550a";
> -
> -	gnss {
> -		compatible = "wi2wi,w2sg0084i";
> -
> -		vcc-supply = <&gnss_reg>;
> -		sirf,onoff-gpios = <&gpio0 16 GPIO_ACTIVE_HIGH>;
> -		sirf,wakeup-gpios = <&gpio0 17 GPIO_ACTIVE_HIGH>;
> -	};
> -};
> diff --git a/Documentation/devicetree/bindings/gnss/sirfstar.yaml b/Documentation/devicetree/bindings/gnss/sirfstar.yaml
> new file mode 100644
> index 000000000000..9f80add3e61b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/gnss/sirfstar.yaml
> @@ -0,0 +1,71 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/gnss/sirfstar.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: SiRFstar GNSS Receiver Device Tree Bindings
> +
> +allOf:
> +  - $ref: gnss-common.yaml#

The allOf should be just before "properties:" (also in patch #2).

> +
> +maintainers:
> +  - Johan Hovold <johan@kernel.org>
> +
> +description:
> +  The SiRFstar GNSS receivers have incarnated over the years in different
> +  chips, starting from the SiRFstarIII which was a chip that was introduced in
> +  2004 and used in a lot of dedicated GPS devices. In 2009 SiRF was acquired
> +  by CSR (Cambridge Silicon Radio) and in 2012 the CSR GPS business was
> +  acquired by Samsung, while some products remained with CSR. In 2014 CSR
> +  was acquired by Qualcomm who still sell some of the SiRF products.
> +
> +  SiRF chips can be used over UART, I2C or SPI buses.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - fastrax,uc430
> +      - linx,r4
> +      - wi2wi,w2sg0004
> +      - wi2wi,w2sg0008i
> +      - wi2wi,w2sg0084i
> +
> +  reg:
> +    description:
> +      The I2C Address, SPI chip select address. Not required on UART buses.
> +
> +  vcc-supply:
> +    description:
> +      Main voltage regulator, pin names such as 3V3_IN, VCC, VDD.
> +
> +  timepulse-gpios:
> +    description: Comes with pin names such as 1PPS or TM

You don't need this, I think. It's coming from gnss-common.yaml.



Best regards,
Krzysztof
