Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49A224F9447
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 13:38:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234878AbiDHLkR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 07:40:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230312AbiDHLkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 07:40:15 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 093FB3EF0F;
        Fri,  8 Apr 2022 04:38:12 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id i27so16726876ejd.9;
        Fri, 08 Apr 2022 04:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aQTMkqSfFhl91Cc0GUZ1r40OnFQa6gJ5Xa9eGXPe3QY=;
        b=ay22Mzf7xEG4Xo6lXaOF5bzT6fbmSM7LljcZeltTGhjVGqTp0+GhNQBQWNiOksmy1Z
         0dECOKMK53lDKH4LXjY8F2YWN1YPml4hzRccRepsMw0FZkypuf/vBfwiH1hd/Ncw7bHN
         rYNw9plPjJhn2AIHbxARkkXQP5f7ux+pm2bQjGq4g7KyNUabsvLnOQa85Ksn3L2nFxC8
         eToU8uqYqBecK99X32eGYvcmBe42Kk6VtDHXnLZojqYRYj6198nODbWbSunP5PBlZKPu
         j1pyYi6hJWlnlBcDcQnxzkxOkrzz0I4OjshpGH1WVtaAjrhBDVn2bnS1WTNkIjY8fe04
         pJ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aQTMkqSfFhl91Cc0GUZ1r40OnFQa6gJ5Xa9eGXPe3QY=;
        b=HrDCYUYZenl3XNlQBPMtd75LEaK84tmaCR7Rb9w6jI7zmW4AGPxoewydQCol9r+UqV
         rB4vHPpTEgvNy1nkWwDyJ5Uc+ETxwzxvLhDv6ImOh6KplTi/OZ2pmIsrGlVc/e7hzT0c
         n5BIfE2msQ+eII28XnRpUvWWGElCoTA4Y9ZKW/Kr0dSdW2uyraRTsBuigKytTA5Jy9Sq
         GMfYvkz7qGUPTAOIv4gWfPLMk4dIPQ72YqJXgnT1eTe6GDS6iPSMNkcAcNiIt5jX4pMs
         83E8vgtaruKbaiKY01hWyItDZwIgAshCuRROzOxZmkFanf5IAmmE3kZfC4FGtH7Re5ut
         fY6Q==
X-Gm-Message-State: AOAM531s0HLADWz5eRuebI/axcdjDIIOHPr73XpPNeytPeRWhWw2YWWD
        PXmiC2JBOT/ZUXhwey+WHW1ZyDcuhMc0qcVKSH0=
X-Google-Smtp-Source: ABdhPJzfswmEDudd532KIvJjC3KNAd22CqiWCt9MqgTK7JU06acMZpBdYDNh1a6YlRxJJaqA4bX5LVjm6tPgCUOuB2I=
X-Received: by 2002:a17:907:a411:b0:6e1:2084:99d2 with SMTP id
 sg17-20020a170907a41100b006e1208499d2mr1045774ejc.639.1649417890559; Fri, 08
 Apr 2022 04:38:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220405135444.199295-1-maz@kernel.org> <20220405135444.199295-11-maz@kernel.org>
In-Reply-To: <20220405135444.199295-11-maz@kernel.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 8 Apr 2022 14:33:56 +0300
Message-ID: <CAHp75Ve5tMyUdj-cYV0pzL4zvVitTwC_gGv50-ZHTETiiQSbeA@mail.gmail.com>
Subject: Re: [PATCH v2 10/10] Documentation: Update the recommended pattern
 for GPIO irqchips
To:     Marc Zyngier <maz@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Thierry Reding <thierry.reding@gmail.com>,
        Joey Gouly <joey.gouly@arm.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Jeffrey Hugo <jeffrey.l.hugo@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm@vger.kernel.org,
        Android Kernel Team <kernel-team@android.com>
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

On Wed, Apr 6, 2022 at 1:57 PM Marc Zyngier <maz@kernel.org> wrote:
>
> Update the documentation to get rid of the per-gpio_irq_chip
> irq_chip structure, and give examples of the new pattern.

...

> +  static void my_gpio_mask_irq(struct irq_data *d)
> +  {
> +      struct gpio_chip *gc = irq_desc_get_handler_data(d);
> +
> +      /*
> +       * Perform any necessary action to mask the interrupt,
> +       * and then call into the core code to synchronise the
> +       * state.
> +       */
> +
> +      gpiochip_disable_irq(gc, d->hwirq);

(1)

> +  }
> +
> +  static void my_gpio_unmask_irq(struct irq_data *d)
> +  {
> +      struct gpio_chip *gc = irq_desc_get_handler_data(d);

> +      gpiochip_disable_irq(gc, d->hwirq);

(2)

> +      /*
> +       * Perform any necessary action to unmask the interrupt,
> +       * after having called into the core code to synchronise
> +       * the state.
> +       */
> +  }

If (1) and (2) being the same is not a mistake (typo) it probably
needs additional explanation.

...

> +  static void my_gpio_mask_irq(struct irq_data *d)
> +  {
> +      struct gpio_chip *gc = irq_desc_get_handler_data(d);
> +
> +      /*
> +       * Perform any necessary action to mask the interrupt,
> +       * and then call into the core code to synchronise the
> +       * state.
> +       */

> +      gpiochip_disable_irq(gc, d->hwirq);

(3)

> +  }
> +
> +  static void my_gpio_unmask_irq(struct irq_data *d)
> +  {
> +      struct gpio_chip *gc = irq_desc_get_handler_data(d);

> +      gpiochip_disable_irq(gc, d->hwirq);

(4)

> +      /*
> +       * Perform any necessary action to unmask the interrupt,
> +       * after having called into the core code to synchronise
> +       * the state.
> +       */
> +  }

Ditto for (3) & (4).

...

> +  static void my_gpio_mask_irq(struct irq_data *d)
> +  {
> +      struct gpio_chip *gc = irq_desc_get_handler_data(d);
> +
> +      /*
> +       * Perform any necessary action to mask the interrupt,
> +       * and then call into the core code to synchronise the
> +       * state.
> +       */
> +
> +      gpiochip_disable_irq(gc, d->hwirq);

(5)

> +      irq_mask_mask_parent(d);
> +  }
> +
> +  static void my_gpio_unmask_irq(struct irq_data *d)
> +  {
> +      struct gpio_chip *gc = irq_desc_get_handler_data(d);

> +      gpiochip_disable_irq(gc, d->hwirq);

(6)

> +      /*
> +       * Perform any necessary action to unmask the interrupt,
> +       * after having called into the core code to synchronise
> +       * the state.
> +       */
> +
> +      irq_mask_unmask_parent(d);
> +  }

Ditto for (5) & (6).

--
With Best Regards,
Andy Shevchenko
