Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F036E531D19
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 22:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243047AbiEWSAr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 14:00:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241189AbiEWRcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 13:32:47 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B4427982A;
        Mon, 23 May 2022 10:27:28 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-30007f11f88so24447917b3.7;
        Mon, 23 May 2022 10:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sTAZGlEUmX/o2HerHezmpZJYpBk/Tk//TO+SFL1h0zA=;
        b=pN4ceqx3jRqPDNbZxMO8S9NplGCGhu5NZGlEejwVpgTIpU/7Eyj86+mcv240DqoKIB
         TPReO8r/4SM21FZvUgntCTTdurUlJ5mLo9g7bqG2ocJDosfEmIwHXyrGOCjbU6wDOs83
         fG+rkIVl2t+Wktu9X0gBXqVOb6OuX/sxcB1Tg84f8HyAyOknb8mjSP/YMihayC/Qx7NP
         fuFYzJxMzGEv7uzFInqftcmOkkT9vmmRLaOns7cghOZG5ZeJcBheQyROBJE9eWAN0EMF
         +DsJDJdA3qPlMOz334GBPaxozXAt7G7i852jHnf7qWw6v0Rv3Ozp3qB31ZCsWZ22wW2M
         B/CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sTAZGlEUmX/o2HerHezmpZJYpBk/Tk//TO+SFL1h0zA=;
        b=fM4WvityEK09LtVeUHKX7MRRqGhtDxoXenIoCogx6bicGf5m511pZfKIx4oe+8HUyz
         bJKgsKUPaxsOvxh4zUGE3Yk/gzzO+YRuc6FPkmSXrjo7lmZpTIIQfv65yf/Khof2r6Ue
         3h1kIh8qXwVKWCleBFZPrbwmMs/1dVuMWqFl9lD6eQGXmcKhyI1iy+7HyDqDpNLXG3Cf
         +3aUHR+H3WZhsYQvTcDUgo55p7IGI84/GN9DlJXmjwpQv7NvAfJNFkq6qpnxTpQJJxOf
         MyfKzwdejX+xdlsg+eSngjUTu0BZReI/YJM0FKo/JJNv5DxxVQ0zkrR/qdZUMPocNAPr
         TSag==
X-Gm-Message-State: AOAM530RLopEba7IH4Wh/08EUH9tfM/RCXnPugXdUft0Iz8UFOPknU/J
        T5nJz69PrMBW6K4uI6zxZpZGQM/SqLtdFqMXiOeMeIlvjt4=
X-Google-Smtp-Source: ABdhPJyfb8N3rzOUX/Kjr0IcB2wzgmkTx8SdieSrc6hUMHn9O6f7sUVSBxw6MHCLQeIkZi6lnS9ZRTgE+qAWFNZBBrU=
X-Received: by 2002:a0d:e2ca:0:b0:2ff:369c:a3ee with SMTP id
 l193-20020a0de2ca000000b002ff369ca3eemr25119387ywe.292.1653326847797; Mon, 23
 May 2022 10:27:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220518192924.20948-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220518192924.20948-4-prabhakar.mahadev-lad.rj@bp.renesas.com> <CACRpkda1pfL8tk0S_0bHvj4kWYrLTTeOz3b_A9qK5DJwHWeTXw@mail.gmail.com>
In-Reply-To: <CACRpkda1pfL8tk0S_0bHvj4kWYrLTTeOz3b_A9qK5DJwHWeTXw@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Mon, 23 May 2022 18:27:01 +0100
Message-ID: <CA+V-a8uR6EHr9ZqbBkLLKwLTPO4asthYaWTYE8c4NGFUt9Gmcg@mail.gmail.com>
Subject: Re: [PATCH v4 3/7] gpio: gpiolib: Add ngirq member to struct gpio_irq_chip
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Marc Zyngier <maz@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Thank you for the review.

On Thu, May 19, 2022 at 2:26 PM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Wed, May 18, 2022 at 9:30 PM Lad Prabhakar
> <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
>
> > Supported GPIO IRQs by the chip is not always equal to the number of GPIO
> > pins. For example on Renesas RZ/G2L SoC where it has GPIO0-122 pins but at
> > a given point a maximum of only 32 GPIO pins can be used as IRQ lines in
> > the IRQC domain.
> >
> > This patch adds ngirq member to struct gpio_irq_chip and passes this as a
> > size to irq_domain_create_hierarchy()/irq_domain_create_simple() if it is
> > being set in the driver otherwise fallbacks to using ngpio.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> NAK
>
> As pointed out this is a property of the hardware and thus you should
> derive this property of the hardware from the compatible string.
>
> For example by passing per-variant .data in struct of_device_id.
>
> Unique hardware properties means unique hardware means it should
> have a unique compatible string. Otherwise something is wrong
> with the compatibles.
>
Agreed, I will drop this.

Cheers,
Prabhakar
