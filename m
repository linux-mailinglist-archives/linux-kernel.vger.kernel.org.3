Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67B4C4DC3F5
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 11:29:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232589AbiCQKaQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 06:30:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232580AbiCQKaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 06:30:13 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E36B71DE6F7
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 03:28:55 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id b28so8228646lfc.4
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 03:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=evVQCysX6Rx7a3D/7RcWBO7GE40bsv+u7P/uPmKpk7M=;
        b=yKC/4m1t5uLvBlxgP+/XKZr+12jY9AhZH/djhFxd3lkoc97/kNbZTWObla3KwnoYx3
         dIZdi8z4NJ+Rf6jO3NiyaYvTGBZP3cFr2WuOVqbhi+PvwOttk8Ulx5uaxbum1aiqX8zf
         14jYMo1VA+grUCtwiN+UcvP0vgUaCdgZixnkAhpIpV2ryO+w+acFBdJm/eb0BnjcbYTN
         EA9Fe/nevFd6S7NoJ2W17oaJB2EnuNHAUdhO/kNpQ6Lfu1wfA5LQ2ugJuHuJrrz7VxNX
         BjTkgvJsRP3Nzu+YuH2rsYMcSkOasI+Zxy/7GZ0NnbhFX/K/rDxUOq/5Y9ZxtB/fReNu
         +L9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=evVQCysX6Rx7a3D/7RcWBO7GE40bsv+u7P/uPmKpk7M=;
        b=kj9XQkH4W7iRwIEPn4FVYPKFNdkNt3wmd0Hrs8nuIPsISiRHMDY0/MHu0YDYuuMZA7
         pJ6XaNOb/qLmzrZuiMMFamZIkSkhNhU+2VApynAY5aBUnJFQSE+9PAXkellOkNVKx7mk
         Cx8hCv2DpA31HY/mOqbRQvgGaEqRfXOAbE+Qs8ccT/0BXxZngWkPArci9xAYhJ4hxBZQ
         Tp+7O9p3uaNw7/SX+dQtY8npjmkwOVkfMKxnNLK5G/cfej50wdqDP38/FeMinQoqg3kY
         IJ32TTRgcdcyfDxWg+XJ/Gxt423MAM1KC7jfXig4sppXLfTDruCjf4MUdulL142Zn253
         PxIQ==
X-Gm-Message-State: AOAM5336Tm877iQY8JOOEAyeFRwvfsINVBwyHmUUORtSWESOYdnqqPXn
        vUzxsLeCBNMUgJ6DeEOuiJQQ1oMM6B14Hb3t4TpscA==
X-Google-Smtp-Source: ABdhPJxOxpMGtMW4kX0cLix6E7EHQ8pGbUJbmoU5EspHj5uKWZwuPoe9PovuhtKY9BYniV4wXPDSe7/ByKWjTJQYCmw=
X-Received: by 2002:ac2:4e98:0:b0:448:3039:d170 with SMTP id
 o24-20020ac24e98000000b004483039d170mr2632125lfr.233.1647512934185; Thu, 17
 Mar 2022 03:28:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220304135134.47827-1-yann.gautier@foss.st.com>
 <20220304135134.47827-2-yann.gautier@foss.st.com> <CACRpkdYQz+-im3n-r0_8RKL7so2bHS=aZobty4BbzixmPzms-Q@mail.gmail.com>
 <0bc53018-fce4-4104-fa47-6e60d2367d69@foss.st.com> <CAPDyKFqgQZFH3LT1Z+G9N0MVfhFwoiUr9N2sKFaejTWcH+dNXg@mail.gmail.com>
 <6bfade04-36b4-98c3-2796-ebeaa230f52e@foss.st.com>
In-Reply-To: <6bfade04-36b4-98c3-2796-ebeaa230f52e@foss.st.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 17 Mar 2022 11:28:18 +0100
Message-ID: <CAPDyKFpE7yUvfyGSBpaZf2Vy3VbNm6PEzFcnYAupc0wg+49_zA@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: mmc: mmci: add a property to disable DMA LLI
To:     Yann Gautier <yann.gautier@foss.st.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Christophe Kerello <christophe.kerello@foss.st.com>,
        Ludovic Barre <ludovic.barre@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Russell King <linux@armlinux.org.uk>,
        Marek Vasut <marex@denx.de>, kernel@dh-electronics.com,
        Manivannan Sadhasivam <mani@kernel.org>,
        Grzegorz Szymaszek <gszymaszek@short.pl>
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

On Thu, 17 Mar 2022 at 11:18, Yann Gautier <yann.gautier@foss.st.com> wrote:
>
> On 3/17/22 11:00, Ulf Hansson wrote:
> > On Tue, 15 Mar 2022 at 09:26, Yann Gautier <yann.gautier@foss.st.com> wrote:
> >>
> >> On 3/14/22 23:43, Linus Walleij wrote:
> >>> "On Fri, Mar 4, 2022 at 2:52 PM Yann Gautier <yann.gautier@foss.st.com> wrote:
> >>>
> >>>> On STMicroelectronics variant of PL18x, the DMA Linked Lists are supported
> >>>> starting from revision v2 of the peripheral. But it has limitations,
> >>>> as all the buffers should be aligned on block size (except the last one).
> >>>> But this cannot be guaranteed with SDIO. We should then have a property
> >>>> to disable the support of LLI.
> >>>>
> >>>> Signed-off-by: Yann Gautier <yann.gautier@foss.st.com>
> >>>
> >>> Actually I think this is present also on the ux500 variants. See:
> >>> commit 2253ed4b36dc876d1598c4dab5587e537ec68c34
> >>> "mmc: mmci: Support any block sizes for ux500v2 and qcom variant"
> >>>
> >>> Spot the variant data "dma_power_of_2".
> >>>
> >>> So whatever property you add
> >>> to the variant data (not in the device tree please) should
> >>> be added to the ux500 variants as well, it will *VERY* likely
> >>> have a problem with LLI elements not being a power of 2
> >>> as it is the ancestor of later STMicro variants.
> >>>
> >>> It might actually be the reason for some annoying WiFi error
> >>> messages I have seen :/
> >>>
> >>> Yours,
> >>> Linus Walleij
> >>
> >> Hi Linus,
> >>
> >> The STM32 variant uses an internal DMA, and the DMA functions are in its
> >> dedicated file. So I was planning to do the same as what is done in
> >> meson-gx-mmc.c: using a bounce buffer to copy from/to in case DMA
> >> constraints are not fulfilled. Not sure it can help for Ux500.
> >
>
> Hi Ulf,
>
> > We already have a bounce buffer in mmci_pio_read(), but we need one in
> > mmc_pio_write() too, which hasn't been implemented yet.
>
> The idea is to keep using our internal DMA, and not switch to pio mode.

Okay, but doesn't that become awfully inefficient, especially if we
end up with several smaller sg-list-elements.

The switch to pio would only be temporary for the particular request
that has "bogus" buffers.

>
> >
> >>
> >> Ulf, before I send my new series (although it is not ready yet), would
> >> you be OK with the bounce buffer idea?
> >
> > Yes, that works for me.
> I have patches almost ready, I'll send that soon.

Okay!

>
> >
> > On the other hand, it would be even better if we could specify the
> > buffer limitations per mmc host instance, so upper layers (SDIO func
> > drivers) could conform to these - and use better buffers, to achieve a
> > better performance.
>
> We've seen things that could be improved in the wifi driver. I'll check
> what could be done.

Great!

Kind regards
Uffe
