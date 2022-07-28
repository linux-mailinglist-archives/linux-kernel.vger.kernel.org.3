Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E4D7583BE2
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 12:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235626AbiG1KQE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 06:16:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234747AbiG1KQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 06:16:01 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80A75550AB
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 03:16:00 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id t17so2212736lfk.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 03:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=dI10duHMDNmaJknvYmD+fuJsCt7TqWfzF/cnzOU7UpE=;
        b=v0Sx289TviS3yA2Yyz6iJziQkpjXI+OPGSN41Lee2WtzudVS5DYX3cAlZiiIaqIViu
         xcE4PoYKieXWKBnZyTYx8l9SIk5ul2SQdD89alWUGgcTXlF6D9y/fiWVnXX2Nym0vEtn
         Cse70XFUNHS3q8FVy09GYZ/7jn+weOw19bvajMeNmPZ42Me9fbDDLRmQxjLt7wFBAiam
         daGlON5KkxXS84UUtdr43LSDIvGj3zyt8fM4pq65J21m+Sz9KAXHI5I5nVctvY5YnU6L
         SmXs9CQA1XX0xB9QEt5xsDzHLDyx7166w5dvsYRN3qgVh7ch9JL5WVsZy/BuN6R01p66
         KLkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=dI10duHMDNmaJknvYmD+fuJsCt7TqWfzF/cnzOU7UpE=;
        b=BWS8oi9JRkT6lsCbF0d01VzJJHEqUC6/Vkrfd/owHJy8Fbe1IlqoLsCW4JWuEO/ewr
         kxwa1RcgVwxv17LNHA7vm2KBc2JkpY/UetcC7xnf1K0gg12iPEAba/X65UTEJIxiFB5v
         zLWk5h2ylQnav0j/4IRUGdBUMfMncgVJR50coA/N+ZwSbunK8m5d2M293XvWzBrTiKBo
         aY/bSazD3vKdkOukwezEUJ1/5XAgEws8rbk3wnJYFUTMFNLj3lSPpsyWJ6TurVBK10/w
         lTEy4jQAN6lrRwMlidXSdzCjA2sgC+N/zys3iSfaT/ZEwIlc+b4sD1E8EZaQzKmCvL1/
         +iwA==
X-Gm-Message-State: AJIora/JHF+pAVxcvsWeN2c3e7nkq095d8EB5tJcMLfmYDexfL32E3lP
        n18nUkYmHQXsWTDLsRdNoC6VcQ==
X-Google-Smtp-Source: AGRyM1s8LOJyDO4TBVbKzUNGxlK1NOytoHtgjaBH7enoIbBxOyHyxQe19MFvmaimT3SEYUAAQ9c/JA==
X-Received: by 2002:a19:4f12:0:b0:48a:7a26:7f92 with SMTP id d18-20020a194f12000000b0048a7a267f92mr9292666lfb.503.1659003358804;
        Thu, 28 Jul 2022 03:15:58 -0700 (PDT)
Received: from [192.168.3.197] (78-26-46-173.network.trollfjord.no. [78.26.46.173])
        by smtp.gmail.com with ESMTPSA id a21-20020a056512201500b0048a86468531sm135120lfb.61.2022.07.28.03.15.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Jul 2022 03:15:58 -0700 (PDT)
Message-ID: <52832d25-f60b-8b89-fc8e-0379f6f37689@linaro.org>
Date:   Thu, 28 Jul 2022 12:15:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH RFC v1 2/2] devicetree: bindings: bus: add Wiegand driver
 documentation
Content-Language: en-US
To:     =?UTF-8?Q?Martin_Za=c5=a5ovi=c4=8d?= <m.zatovic1@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     devicetree@vger.kernel.org, mani@kernel.org,
        hemantk@codeaurora.org, elder@linaro.org, f.fainelli@gmail.com,
        linus.walleij@linaro.org, Michael.Srba@seznam.cz,
        jeffrey.l.hugo@gmail.com, gregkh@linuxfoundation.org,
        bjorn.andersson@linaro.org, saravanak@google.com,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org
References: <20220728091712.13395-1-m.zatovic1@gmail.com>
 <20220728091712.13395-2-m.zatovic1@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220728091712.13395-2-m.zatovic1@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/07/2022 11:17, Martin Zaťovič wrote:
> Wiegand write-only driver requires definitions of two GPIO lines
> in the devicetree. This adds the documentation of their
> definitions.
> 

Subject prefix consistent with subsystem, so:
dt-bindings: bus: add Wiegand bus

There should be no references to drivers in bindings. Bindings also go
before the actual driver in the patchset.


> Signed-off-by: Martin Zaťovič <m.zatovic1@gmail.com>
> ---
>  .../devicetree/bindings/bus/wiegand-gpio.yaml | 66 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 67 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/bus/wiegand-gpio.yaml
> 
> diff --git a/Documentation/devicetree/bindings/bus/wiegand-gpio.yaml b/Documentation/devicetree/bindings/bus/wiegand-gpio.yaml
> new file mode 100644
> index 000000000000..74733aadc61e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/bus/wiegand-gpio.yaml
> @@ -0,0 +1,66 @@
> +# SPDX-License-Identifier: GPL-2.0-only

Dual license please.

> +
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/bus/wiegand-gpio.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Wiegand write-only GPIO driver
> +
> +maintainers:
> +  - Martin Zaťovič <m.zatovic1@gmail.com>
> +
> +description: |
> +  Wiegand interface is a wiring standard popularized in the 1980s. To this day
> +  many card readers, fingerprint readers, sensors, etc. use Wiegand interface
> +  particularly for access control applications. It utilizes two wires to
> +  transmit the data - D0 and D1.
> +
> +  Both data lines are initially pulled up. To send a bit of value 1, the D1
> +  line is set low. Similarly to send a bit of value 0, the D0 line is set low.
> +  Standard Wiegand formats include 26, 36 and 37 bit and they reserve the first
> +  and last bits for parity. The first(MSB) parity bit is set to 1 if the parity
> +  of the first half of the payload is odd. The last(LSB) parity bit is set to 1
> +  if the parity of the second half of the payload even.
> +
> +properties:
> +  $nodename:
> +    pattern: "^wiegand-gpio(@[0-9a-f]+)?$"
> +
> +  compatible:
> +    contains:

Nope. See example-schema.

> +      const: gpio,wiegand-gpio
> +    description:
> +      Shall contain "wiegand-gpio" for the driver to match with this node.

No description. See example-schema.
> +
> +  wiegand-data-hi-gpios:

I propose just data-hi-gpios

> +    description:
> +      gpio used to transmit bits the value of which is 1, it should be
> +      flagged as active high with GPIO_ACTIVE_HIGH from
> +      <dt-bindings/gpio/gpio.h>.
> +    maxItems: 1
> +
> +  wiegand-data-lo-gpios:

data-lo-gpios

> +    description:
> +      gpio used to transmit bits the value of which is 1, it should be
> +      flagged as active high with GPIO_ACTIVE_HIGH from
> +      <dt-bindings/gpio/gpio.h>.
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - wiegand-data-hi-gpios
> +  - wiegand-data-lo-gpios
> +
> +additionalProperties: true

Nope. This must be false, unless you create here a bus bindings. But in
such case you example is incomplete.

> +
> +examples:
> +  - |
> +    wiegand-gpio {

Just wiegand.

https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

> +        compatible = "wiegand-gpio";
> +        pinctrl-names = "default";
> +        pinctrl-0 = <&pinctrl_uart1_wiegand>;
> +        wiegand-data-hi-gpios = <&gpio2 1 GPIO_ACTIVE_HIGH>;
> +        wiegand-data-lo-gpios = <&gpio2 2 GPIO_ACTIVE_HIGH>;
> +        status = "okay";

No need for status.

> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9a519530e44e..c7db1e41cc02 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -21589,6 +21589,7 @@ F:	drivers/rtc/rtc-sd3078.c
>  WIEGAND WRITE-ONLY GPIO DRIVER
>  M:	Martin Zaťovič <m.zatovic1@gmail.com>
>  S:	Maintained
> +F:	Documentation/devicetree/bindings/bus/wiegand-gpio.yaml
>  F:	drivers/bus/wiegand-gpio.c
>  F:	drivers/bus/wiegand-gpio.h
>  


Best regards,
Krzysztof
