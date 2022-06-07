Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F193F54023F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 17:17:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343953AbiFGPRL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 11:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245065AbiFGPRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 11:17:08 -0400
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8627678ECB;
        Tue,  7 Jun 2022 08:17:07 -0700 (PDT)
Received: by mail-io1-f52.google.com with SMTP id a10so15788458ioe.9;
        Tue, 07 Jun 2022 08:17:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SjlVFdnR7tYxM3f/CB6jirW0jGfTyiV+Y5jKRvu7N1I=;
        b=s877vHbaKA9MSmRAvrZNXnPsQAYmu+F3VyJSYEp1unKXgHRVfeqHbOzMslEmr10U+3
         I4BVJAh94m4KXLjvhcsPvMCmVung+lcQteHvzeOf/p+qzhW73Ss6CPZZLGYAR1qIy2gM
         TbqoowXOk5vQAYoXcwOG3109iFs+e2dcDZ1y5ZkDd4nt8vg/Um51uxZqlTEmCorHxjHo
         pB2susAL5fBAU6zRW2NpuClOu8kTnILbw63qojPOjgC+uNcTaqaM27QFqdE6y36vA0Ya
         0VBH8U/NoeGcEOyK4n/p4CV/C5t64sBGdunuO9WAJKynaWVH3AKoVWClHsJe4nDrwayz
         G9Og==
X-Gm-Message-State: AOAM532jkOUrtrS4Ig0bfjrBYWbCLnfqdLPCjduf+BOBvW5jZ8VasB6r
        o6pxBI8h1dacvHvjmCEwB/Bye6bLWg==
X-Google-Smtp-Source: ABdhPJzeQ1o4uHp2G2vvHri3+rguSybk1tpA6g0SN4mirpEdhY9wF4Tm3Db5kCMXTu/0HyRttUBqtg==
X-Received: by 2002:a05:6638:13d5:b0:331:a6f2:3dbf with SMTP id i21-20020a05663813d500b00331a6f23dbfmr7413793jaj.9.1654615026710;
        Tue, 07 Jun 2022 08:17:06 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id t22-20020a5d8496000000b0065dc93eae5dsm6677682iom.7.2022.06.07.08.17.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 08:17:06 -0700 (PDT)
Received: (nullmailer pid 3267286 invoked by uid 1000);
        Tue, 07 Jun 2022 15:17:03 -0000
Date:   Tue, 7 Jun 2022 09:17:03 -0600
From:   Rob Herring <robh@kernel.org>
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Cc:     linus.walleij@linaro.org, brgl@bgdev.pl,
        krzysztof.kozlowski+dt@linaro.org, wens@csie.org, jic23@kernel.org,
        lee.jones@linaro.org, sre@kernel.org, broonie@kernel.org,
        gregkh@linuxfoundation.org, lgirdwood@gmail.com, lars@metafoo.de,
        rafael@kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/10] dt-bindings: gpio: Add AXP192 GPIO bindings
Message-ID: <20220607151703.GB3254370-robh@kernel.org>
References: <20220603135714.12007-1-aidanmacdonald.0x0@gmail.com>
 <20220603135714.12007-6-aidanmacdonald.0x0@gmail.com>
 <20220605225504.GA3678983-robh@kernel.org>
 <7w5P7NKqcSgfwmILB1hRmmdtkmw7UXrH@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7w5P7NKqcSgfwmILB1hRmmdtkmw7UXrH@localhost>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 07, 2022 at 11:34:19AM +0100, Aidan MacDonald wrote:
> 
> Rob Herring <robh@kernel.org> writes:
> 
> > On Fri, Jun 03, 2022 at 02:57:09PM +0100, Aidan MacDonald wrote:
> >> The AXP192 PMIC is different enough from the PMICs supported by
> >> the AXP20x GPIO driver to warrant a separate driver. The AXP192
> >> driver also supports interrupts and pinconf settings.
> >> 
> >> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
> >> ---
> >>  .../bindings/gpio/x-powers,axp192-gpio.yaml   | 59 +++++++++++++++++++
> >>  1 file changed, 59 insertions(+)
> >>  create mode 100644 Documentation/devicetree/bindings/gpio/x-powers,axp192-gpio.yaml
> >> 
> >> diff --git a/Documentation/devicetree/bindings/gpio/x-powers,axp192-gpio.yaml b/Documentation/devicetree/bindings/gpio/x-powers,axp192-gpio.yaml
> >> new file mode 100644
> >> index 000000000000..7a985640ade8
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/gpio/x-powers,axp192-gpio.yaml
> >> @@ -0,0 +1,59 @@
> >> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> >> +%YAML 1.2
> >> +---
> >> +$id: "http://devicetree.org/schemas/gpio/x-powers,axp192-gpio.yaml#"
> >> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> >> +
> >> +title: X-Powers AXP192 GPIO Device Tree Bindings
> >> +
> >> +maintainers:
> >> +  - Chen-Yu Tsai <wens@csie.org>
> >> +
> >> +properties:
> >> +  "#gpio-cells":
> >> +    const: 2
> >> +    description: >
> >> +      The first cell is the pin number and the second is the GPIO flags.
> >> +
> >> +  compatible:
> >> +    oneOf:
> >> +      - enum:
> >
> > No need for 'oneOf' with only 1 entry.
> >
> 
> Got it.
> 
> >> +          - x-powers,axp192-gpio
> >> +
> >> +  gpio-controller: true
> >> +
> >> +patternProperties:
> >> +  "^.*-pins?$":
> >
> > You can omit '^.*'
> >
> > Why does 's' need to be optional?
> >
> 
> TBH I just copied this from x-powers,axp209-gpio.yaml. A similar pattern
> is used in a few other bindings, eg. allwinner,sun4i-a10-pinctrl.yaml.
> I guess it's to allow the node names to sound more natural when there's
> only one pin.

Those cases were for compatibility with existing users. That shouldn't 
be the case here.

Rob
