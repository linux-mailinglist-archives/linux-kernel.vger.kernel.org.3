Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA3C25091A0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 22:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382267AbiDTUvw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 16:51:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358062AbiDTUvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 16:51:51 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8945E109D
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 13:49:04 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id t67so5104611ybi.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 13:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LpRJb08UNsAeD/BGStPXY1JWld5Gs95lH64pYZ6orgE=;
        b=PeI41Cw+3CrJgCF7NF0DdwSj7RBlF44kughU3RlOvBrzMjU1Uq/7E9/Bf42CLQ2U5z
         1IwvhHEmCScfEAq2kRy+7SWZchlZzvzzXl5PGAcCLORbwijG3U+0/KriZKxPMSruHm8P
         gCfU5qVgw+XaLOjTys/QlVH/L5dA9uNQzp5PaH6zE8Ek42JWEBnXxI5vfqAdvcX60A1R
         QVFWD2qMdauzF+7hbiNQkVzclCfx5V3IxK6OqDJr7RNGDZEf5dE8lMM/oj/RQ4ihC8xX
         4aVRxdLbPv0Lu6dzR5il3WJawpwXOXm7eFcoMOiRfTUZyYbhfPjAEhREIwGa3G3FU93O
         tdBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LpRJb08UNsAeD/BGStPXY1JWld5Gs95lH64pYZ6orgE=;
        b=xDCC6U1Zee8lbTBZU6uECuWC0O/7pjZ6PLypiq5XZjalW7v6Mqefm9HqU833cde7os
         yEGtew6R8D14iAaJp32DcwiMs89UAQxsIhlAvcO9Tn3P23Y39xfzhEctOLQbeNnp8g7J
         USbKfTV4ol7i3eX2BbPi0K/ZUkfVVOwg1HzZz7+FzoN7S2gTn8317Tgxaab0P4b6/jeA
         Ijxqt9j20o4r9OcpO6eRbw4UCbJkxROoh/2JSYlFNxRHbP3032QN+tNlVzQikh7js3qy
         gejKWuEpTKlUCPTaitovYLlys7oEJ5qZpUTGsFqTpPe8chf3CSl4TyyYC+MCqT0QsebH
         7HXw==
X-Gm-Message-State: AOAM532bRE6RXM7oV7kswQSWSBaGMtazd7HWNC/KnLFZz7V9rfDfRYCx
        gGQXYb4oHoNAR+XjLMOdGycUlgLP49pzPOJowXbsgw==
X-Google-Smtp-Source: ABdhPJzkRs3dHVJIbaNrCahjZbRnpps/qnUhYxpcB/UsWZPjZ6hfdX7hgHxrmzA5Dt6HYz1lYiN1b76YPMPL00KHXuk=
X-Received: by 2002:a25:73cc:0:b0:644:f4a3:6f4f with SMTP id
 o195-20020a2573cc000000b00644f4a36f4fmr17566471ybc.369.1650487743526; Wed, 20
 Apr 2022 13:49:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220414081916.11766-1-xiazhengqiao@huaqin.corp-partner.google.com>
 <20220414081916.11766-2-xiazhengqiao@huaqin.corp-partner.google.com>
In-Reply-To: <20220414081916.11766-2-xiazhengqiao@huaqin.corp-partner.google.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 20 Apr 2022 22:48:52 +0200
Message-ID: <CACRpkdZ--RCgM65nnEd=ebFQpQAPqZDvrBotynYTf+sdisAbsQ@mail.gmail.com>
Subject: Re: [RESEND v2 2/2] dt-bindings: display: Add STARRY 2081101QFH032011-53G
To:     xiazhengqiao <xiazhengqiao@huaqin.corp-partner.google.com>
Cc:     thierry.reding@gmail.com, sam@ravnborg.org, airlied@linux.ie,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 14, 2022 at 10:19 AM xiazhengqiao
<xiazhengqiao@huaqin.corp-partner.google.com> wrote:

> Add dt-bindings for 10.1" TFT LCD module called STARRY 2081101
> QFH032011-53G.
>
> Signed-off-by: xiazhengqiao <xiazhengqiao@huaqin.corp-partner.google.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

(...)

> +  enable-gpios:
> +    description: a GPIO spec for the enable pin

The way this is used in the code makes me suspect this should
be named reset-gpios. What is the name of the pin on the
panel?

It also appears you should tag this as active low so in that case
write that in the description "always tag with GPIO_ACTIVE_LOW"
(and alter the code in the driver to match the inversion)

> +  pp1800-supply:
> +    description: core voltage supply

Hm the name of this supply makes me think the display controller is
actually named pp1800. Is this correct?

> +            enable-gpios = <&pio 45 0>;

Don't use ordinal flags in examples.

examples:
  - |
    #include <dt-bindings/gpio/gpio.h>
(...)
    reset-gpios = <&gpio4 11 GPIO_ACTIVE_LOW>;

Yours,
Linus Walleij
