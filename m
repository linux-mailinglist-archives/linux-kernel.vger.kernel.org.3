Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E92EC4E7E25
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 01:28:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbiCZA3z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 20:29:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbiCZA3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 20:29:53 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A376220EE
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 17:28:18 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id j2so16790215ybu.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 17:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ajmVfUjVraKEGeWNaXT0KlukOs2ED2I2lT0SzvNdYtU=;
        b=Jh0HLutlAwLD/oROUaD5fyXpntKhKasPw9z83Zpm/ZK9Bln2OujHui1+VLqihtKFtn
         YmqIBtcp49SlkcXEAZ1HOYgEQksgpUD4RaI/UPeKQhPFF+OCgMnhnS2b+2lXvUg1FlpU
         AQzGhFRNAM/+o4KeujiuYWVWPNi3AlEiIR3xt25mjRza9o3Wfz1Y5E1AHu4Kajp2cQG8
         bQXGyL/5iszS/slBcX6WcBS6OEmaMjo8awnEYA3RZQJMCIBpTsBH4ghvaazszy11WtEl
         neRsxn8ySiwLRGIlEYktmpzccvySZd6TGoOeOSzix1sA6beaL4BPwEwFcFa3dh+L7dir
         hr+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ajmVfUjVraKEGeWNaXT0KlukOs2ED2I2lT0SzvNdYtU=;
        b=lK7degx5m1NbVCVKKJfJiqny9XH/PnWxS1whQ+jscccZ5MCGRxmui7m94x8lr6oXBU
         T74oilDA93EoDjWGmlRelzJmGWYE6m7EUQ0xbdtRnhLwpjgdjFb69Z1sZpviemB9wb8D
         Y+Jn/TJVdx4W7mbe66RidegH3yblRdPN7myBHBjpWvNEL7OMuBFRKQIJXRZhO+dl0tX8
         qgZO7fnveCnOm6nuYKzXDCxSGSk95xbzyyfTE+qYnfZEcqcsfDLZwD0V03msfRz5VQGC
         Vi6oPqbbmvdKrgKDjw2rBOuaDb3LsgfV/foi+emdGln4e1giSMXDaSazkoydi+TDyxFy
         d6GQ==
X-Gm-Message-State: AOAM533JeTRjEkx4szhIi3ND9psjwKkE28eYJdJbjAKqBbD4CVsvDEsb
        RNVFCnilkoZfM9rXObwN/uliP/hIZT9oq2dtG6lTSA==
X-Google-Smtp-Source: ABdhPJyxa9MGQl0pdOi9Ifu9ht/10WCanAofdVFLwCgiqgNFYJF4hSCYhy2OEGZq9v7kSbNUpREoqo4FUWR5xNa5L1w=
X-Received: by 2002:a25:ab64:0:b0:633:6d02:ebc8 with SMTP id
 u91-20020a25ab64000000b006336d02ebc8mr12889732ybi.492.1648254497476; Fri, 25
 Mar 2022 17:28:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220315083723.97822-1-krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220315083723.97822-1-krzysztof.kozlowski@canonical.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 26 Mar 2022 01:28:06 +0100
Message-ID: <CACRpkdZATQubzrzqq2b4VY+W3Pb9RfzOGRiF+34YhEqpSKyUZg@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: gpio: add common consumer GPIO lines
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 15, 2022 at 9:37 AM Krzysztof Kozlowski
<krzysztof.kozlowski@canonical.com> wrote:

> Typical GPIO lines like enable, powerdown, reset or wakeup are not
> documented as common, which leads to new variations of these (e.g.
> pwdn-gpios).  Add a common schema which serves also as a documentation
> for preferred naming.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

I like the idea!

> +  enable-gpios:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +
> +  reset-gpios:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +
> +  powerdown-gpios:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +
> +  pwdn-gpios:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    description: Use powerdown-gpios
> +    deprecated: true
> +
> +  wakeup-gpios:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array

I would underscore either on each one or in a global description:
that lines on components that indicate they are active low
such as RESETN, RESET* etc MUST have the flag in the
second cell set to GPIO_ACTIVE_LOW.

Yours,
Linus Walleij
