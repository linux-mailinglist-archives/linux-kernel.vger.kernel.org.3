Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13DA15113A5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 10:40:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359522AbiD0IoB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 04:44:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359504AbiD0Inz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 04:43:55 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3367C6E8C4;
        Wed, 27 Apr 2022 01:40:44 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id x9so650754qts.6;
        Wed, 27 Apr 2022 01:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eJlUeapMnOfpwREKcsIgJOrrITk3NWVTgwWNmTCLAtI=;
        b=YKm7kJ/pDW1wFFAcxodyXoQujQZSyGD/8GN/BvtSljfT6C1c2XrV7AwcrXA09AcFqo
         Ea7Fl3YdEJUPBUMqx8gZm2dXEXXRIQYkqFEEMwAvS8JYdIpkdsLouB2LBz/1M5uJCU31
         2YMbl72IGXQK+IPbklgyrJiWRt1vV6fytCa3Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eJlUeapMnOfpwREKcsIgJOrrITk3NWVTgwWNmTCLAtI=;
        b=loDpt3sye5zj7DDhzq1CMjGIEplvV0WJNRln73rI1nG2tOfK9zdVKZw8hqjkDU5jxs
         +oHIhYQ4eiZ1HU1Wdkw/Kr+Z8Q57EbVti1TyzDijs/Uhfmjuju+VVMNudwbG6SNoy3Bs
         qcuj/EfBsBLCa2XZtBrJccX+2xQ0QY43LQFR7zdDQxoqLEPhOf4Vb89fNBlnDgpSWqtS
         uzUqZXHcZUI8OqIa0p1tf5MVNVcr83Bqc0NJKD49s4wQJfffQWIMsUgIMzdxgye6EJDr
         VTfV6KmzOABY//EAGOrgTwmSo/+/MzdIS0Gf7V17IjAliKi+VxTC4TAYTNx7lUQDV27T
         aMcg==
X-Gm-Message-State: AOAM5338Xc+f2mukyVAZvqKwR8N3+bjRNX204Jm0PWq1/UNz+zPdjlER
        Ewq3eV4fv8zLwGCMkRbIvWoreSbMR4cQSeGcg1s=
X-Google-Smtp-Source: ABdhPJz7u6QFUIyAqmlAbptkQX27xNjPXzJqkvLo3DkCXNYQl3fmZULOd0r6Yd1z/5k3pa/vq43HUyHdFsZ0UC7iQfQ=
X-Received: by 2002:a05:622a:1456:b0:2f2:4ff:39a1 with SMTP id
 v22-20020a05622a145600b002f204ff39a1mr18285680qtx.164.1651048843300; Wed, 27
 Apr 2022 01:40:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220422192139.2592632-1-robh@kernel.org>
In-Reply-To: <20220422192139.2592632-1-robh@kernel.org>
From:   Joel Stanley <joel@jms.id.au>
Date:   Wed, 27 Apr 2022 08:40:31 +0000
Message-ID: <CACPK8XcQNJNyzqdjMQuCP+z-L-A9mcMqs-HJJrh9MscasV+D=A@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: pinctrl: aspeed: Drop referenced nodes in examples
To:     Rob Herring <robh@kernel.org>
Cc:     Andrew Jeffery <andrew@aj.id.au>,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Apr 2022 at 19:21, Rob Herring <robh@kernel.org> wrote:
>
> The additional nodes in the example referenced from the pinctrl node
> 'aspeed,external-nodes' properties are either incorrect (aspeed,ast2500-lpc)
> or not documented with a schema (aspeed,ast2500-gfx). There's no need to
> show these nodes as part of the pinctrl example, so just remove them.
>
> Signed-off-by: Rob Herring <robh@kernel.org>

Nak.

This removes the information on how to use the bindings. Surely we
prefer to over document rather than under document?


> ---
>  .../pinctrl/aspeed,ast2500-pinctrl.yaml       | 81 ++++---------------
>  1 file changed, 16 insertions(+), 65 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/pinctrl/aspeed,ast2500-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/aspeed,ast2500-pinctrl.yaml
> index 7c25c8d51116..9db904a528ee 100644
> --- a/Documentation/devicetree/bindings/pinctrl/aspeed,ast2500-pinctrl.yaml
> +++ b/Documentation/devicetree/bindings/pinctrl/aspeed,ast2500-pinctrl.yaml
> @@ -76,73 +76,24 @@ additionalProperties: false
>  examples:
>    - |
>      #include <dt-bindings/clock/aspeed-clock.h>
> -    apb {
> -        compatible = "simple-bus";
> -        #address-cells = <1>;
> -        #size-cells = <1>;
> -        ranges;
> -
> -        syscon: scu@1e6e2000 {
> -            compatible = "aspeed,ast2500-scu", "syscon", "simple-mfd";
> -            reg = <0x1e6e2000 0x1a8>;
> -            #clock-cells = <1>;
> -            #reset-cells = <1>;
> -
> -            pinctrl: pinctrl {
> -                compatible = "aspeed,ast2500-pinctrl";
> -                aspeed,external-nodes = <&gfx>, <&lhc>;
> -
> -                pinctrl_i2c3_default: i2c3_default {
> -                    function = "I2C3";
> -                    groups = "I2C3";
> -                };
> -
> -                pinctrl_gpioh0_unbiased_default: gpioh0 {
> -                    pins = "A18";
> -                    bias-disable;
> -                };
> +    scu@1e6e2000 {
> +        compatible = "aspeed,ast2500-scu", "syscon", "simple-mfd";
> +        reg = <0x1e6e2000 0x1a8>;
> +        #clock-cells = <1>;
> +        #reset-cells = <1>;
> +
> +        pinctrl: pinctrl {
> +            compatible = "aspeed,ast2500-pinctrl";
> +            aspeed,external-nodes = <&gfx>, <&lhc>;
> +
> +            pinctrl_i2c3_default: i2c3_default {
> +                function = "I2C3";
> +                groups = "I2C3";
>              };
> -        };
> -
> -        gfx: display@1e6e6000 {
> -            compatible = "aspeed,ast2500-gfx", "syscon";
> -            reg = <0x1e6e6000 0x1000>;
> -            reg-io-width = <4>;
> -            clocks = <&syscon ASPEED_CLK_GATE_D1CLK>;
> -            resets = <&syscon ASPEED_RESET_CRT1>;
> -            interrupts = <0x19>;
> -            syscon = <&syscon>;
> -            memory-region = <&gfx_memory>;
> -        };
> -    };
> -
> -    lpc: lpc@1e789000 {
> -        compatible = "aspeed,ast2500-lpc", "simple-mfd";
> -        reg = <0x1e789000 0x1000>;
> -
> -        #address-cells = <1>;
> -        #size-cells = <1>;
> -        ranges = <0x0 0x1e789000 0x1000>;
> -
> -        lpc_host: lpc-host@80 {
> -            compatible = "aspeed,ast2500-lpc-host", "simple-mfd", "syscon";
> -            reg = <0x80 0x1e0>;
> -            reg-io-width = <4>;
>
> -            #address-cells = <1>;
> -            #size-cells = <1>;
> -            ranges = <0x0 0x80 0x1e0>;
> -
> -            lhc: lhc@20 {
> -                   compatible = "aspeed,ast2500-lhc";
> -                   reg = <0x20 0x24>, <0x48 0x8>;
> +            pinctrl_gpioh0_unbiased_default: gpioh0 {
> +                pins = "A18";
> +                bias-disable;
>              };
>          };
>      };
> -
> -    gfx_memory: framebuffer {
> -        size = <0x01000000>;
> -        alignment = <0x01000000>;
> -        compatible = "shared-dma-pool";
> -        reusable;
> -    };
> --
> 2.32.0
>
