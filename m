Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFFAB57011D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 13:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbiGKLtT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 07:49:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbiGKLtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 07:49:03 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADBFBDF19
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 04:49:02 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-31cf1adbf92so46020077b3.4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 04:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qGmoEbCcCmBZ5PtrI4CWjZErm9cf1g9ryntT9MP8MrM=;
        b=XGVKWEyxJb9xuAIFPiWBpSUe4aWaf1AnywbHtlMI2PtJDDXu44C51YoucXMjC5Lj59
         c2Qo8QqmpO2pTG0gggOMdDP6Kkq22IGC9fA0MeJuJaMHIFMJUIC65JncudCPHyoAeTir
         AHxMKzFVb2Z8nkvGnzLjSPOy7m6E9DVvap2aLPpAl7puHuInQHjsdngI6eZuyUCa42td
         +lELivcOFNzxI9vSmjJ8tWx2ULQN+sxJ/5BK6GYUT83ncxiKWFYX4pldeLfffcpNVlXq
         Zl5mT+muJh0+riTPxwqCNMwR5a/NN70iNUfSyHNM8g40Fk60GjE54dvAaIRgB3Ucivh5
         GLDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qGmoEbCcCmBZ5PtrI4CWjZErm9cf1g9ryntT9MP8MrM=;
        b=rFopFfZxyNas+BqvZsvB/e9Zw3y/4W81BEa7FTdomv8GDvnGyW4YBjPWWAAXakuK2w
         6wdEtFwW+do6fCS2L2N8BcHTxEqkf/nDvn4Jm9G3AOCob5bJWrk/BFyYMYw29cRV0vtP
         vyyR5AE/LDSbdpft1+YtLL/jYqrlrrOVogit40+Vf8Dz6/MBeZsT2XJdca/RjbN9tNXj
         BXJtrJvLxGa3Q6MTXzfE61pemEBQAE3PglboZ8Jns5BEuwvKonJlN7Q5yMcIr16znvO0
         rM1N/MQ0jtfu8vxEBy0/WTBivQ+CxWOM4E+Gj1BfWqT8d7A7vCbPqyn4gIr3ii6D+c72
         OiAQ==
X-Gm-Message-State: AJIora/WFRNzyzGP/5ISGvsDvjKvKIgDmrc5DU551CpxmGB2uGhWnbOb
        Ylu9m7797D0F3caZvA7ausklSSlfTzDvN/8uFRSbIv3sljU=
X-Google-Smtp-Source: AGRyM1tuBs5g49jQdrVKq5+pDm18mRPEM9JnXT9engICXzXPhl2iUNwU0lgzV0cAY35ah4eN0zrp2mht8Sj0RiGsVAw=
X-Received: by 2002:a0d:f801:0:b0:31d:851:96b8 with SMTP id
 i1-20020a0df801000000b0031d085196b8mr19060152ywf.448.1657540141893; Mon, 11
 Jul 2022 04:49:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220703111057.23246-1-aidanmacdonald.0x0@gmail.com>
 <20220703111057.23246-4-aidanmacdonald.0x0@gmail.com> <CACRpkdamknwRPGEeGGQGQPtKw=dPXa79GAJy+E6y+03NakN=cA@mail.gmail.com>
 <GrX3yDSwNOGIBcWmKqusaJ3dDqNGLr3Y@localhost> <CACRpkdbHg-vTj6CnkF=oMxtpy+FxEPdn2_qKzgtsT0TYU6Nv-g@mail.gmail.com>
 <ZTG1etjWj47jkqTxIRgriV6pQhW9dasf@localhost>
In-Reply-To: <ZTG1etjWj47jkqTxIRgriV6pQhW9dasf@localhost>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 11 Jul 2022 13:48:50 +0200
Message-ID: <CACRpkdYEeNY=PmGaNfV=K7cJPJu1vyUa3wREbCU8hCJVJb5YfA@mail.gmail.com>
Subject: Re: [PATCH 3/3] gpio: regmap: Support a custom ->to_irq() hook
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>,
        Marc Zyngier <maz@kernel.org>
Cc:     michael@walle.cc, brgl@bgdev.pl, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Wed, Jul 6, 2022 at 4:21 PM Aidan MacDonald
<aidanmacdonald.0x0@gmail.com> wrote:

> If moving to hierarchical IRQ chips is the plan, could we add a note
> to say .to_irq() is discouraged and shouldn't be used in new code?
> Based on what you're saying (which I agree makes sense) it sounds
> like there's really no reason to ever use .to_irq().

There is a reason to use .to_itq() to get the irq associated with
a GPIO, in a Linux kernel context. Especially when doing exactly
what IRQ keys are doing: finding the IRQ for a GPIO line, if any.

But it is not intended to provide a random IRQ from anywhere
else in the system. Maybe I could clarify that.

There are many old boardfile-instances of GPIO where .to_irq()
may be doing something really funky, these are not really up to
date with the current idea of how we model systems in hardware
description languages such as DT or ACPI DSDT.

There may be archs that do not even have DT or ACPI or similar,
there it would be fine to use it in a more liberal way. This may
be the case for m68k or something so I cannot speak about
everything here.

I understand that it might be annoying that this is a bit fuzzy
around the edges.

> Okay, that sounds like a good plan. I'll look more carefully at the
> existing drivers and see if I can use existing gpiolib helpers.
>
> One potential issue (from reading the code) is that hierarchical IRQ
> domains seemingly can't have a non-hierarchical domain as the parent:
> irq_domain_alloc_irqs_parent() calls irq_domain_alloc_irqs_hierarchy()
> and the latter fails with -ENOSYS for a non-hierarchical domain.

Yes that is a characteristic of hierarchical irq domains, they have to
be hierarchical all the way down. It is very often what we want
as well.

> In my case I'm using a regmap IRQ chip, which is non-hierarchical,
> so perhaps that will need to be expanded?

Yes I'm sorry if it adds work to your plate :(

However I think the end result would be very useful for everyone.
Maybe Marc Z has something to add here?

Yours,
Linus Walleij
