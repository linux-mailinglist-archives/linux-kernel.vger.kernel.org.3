Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F32A4D64DC
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 16:46:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349302AbiCKPrJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 10:47:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348795AbiCKPrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 10:47:03 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1564F1C6656
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 07:45:59 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id u7so12495158ljk.13
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 07:45:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=10XF3Sb+t0GCaPOcQ9XoyXqUIC9CjyYdWscRYcObAxw=;
        b=MqSyuOe34h+f5EWwR/oM3slrJ38qINF04yiqUGK9i44Eg7rBVyesJHW1EnFC5kq8Fz
         lk+2YfR6+b43HpQckMotOid77fcXOQCYnCzxj1VBwif0v7RCPtuA/XLZTOUL3TGLQ5aP
         rQQEfHcA3U6Ckvf/b/iG+3oXnpYqaTOumz8wAkXkJ28WbzSqpcBZIFq8ncUer5twWgks
         FOJuSVG0lF2of7EiLc6kYvyyb0pg3ayR7my6BVOGNSBBms3Z+ikWZdLDJdqgvWdJqhJe
         L4QlwgEkOq4Qz46/Q/RRjPefsiQTSwFPLy5q6vZRgKOnqEz3+Npwf2GWlZojgDZgRcgm
         baow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=10XF3Sb+t0GCaPOcQ9XoyXqUIC9CjyYdWscRYcObAxw=;
        b=5GS6T+ai3QqN/PO7Phf4UhK9V5e2lBKMRZDRm9+15E383s8mTX7x0dYDLQea1K3tzY
         /u5MdbV4cYyWdBEvtEKy82pMvyvpBogRe0x1f5x197VH4BPRU3LPY+cA1hHsR4CUB5uH
         D0Bv/PhdeXXaOgCLnbGNL52Z9MPO5YTc15yR0lFu1wFRwo2fkypEZ60mx7C9IFVdKVj7
         dpRkanjN6Qm/WcafGPwZCb5V7M8I38vJZnK5R1LGK/WIQ3dG/qCrXQ1zGM3iPgoUs35C
         fHRsMTPVP2bP2hl+tIvj3kHbYMOvbKMfk3UrBuwGshyj2oA0Kvm4YLT/EcQEssY0ajgs
         yZaw==
X-Gm-Message-State: AOAM533OThM9m/TcyWE4fRZSy9Gkyjjvw6p+vlJbZVgTn0u1vumTif1O
        e8KVvR20zyENRmwEry7OK3MQmHY+Bz8GG5wA76QfbA==
X-Google-Smtp-Source: ABdhPJyKLXL/cjixS70H+wB5WRjtfcEBo2CKEa89VicVYZWBqrQ7uCDzqe5Ilvrer3zvBAGc4wkBHELro4zTjGulY/w=
X-Received: by 2002:a2e:8603:0:b0:246:24c:b79c with SMTP id
 a3-20020a2e8603000000b00246024cb79cmr6543962lji.367.1647013557376; Fri, 11
 Mar 2022 07:45:57 -0800 (PST)
MIME-Version: 1.0
References: <20220304135134.47827-1-yann.gautier@foss.st.com>
 <20220304135134.47827-2-yann.gautier@foss.st.com> <CAPDyKFq_TsBLjW2WxC-Fvu6qDs9MJ1=QPo9gOLRykJ5p2pJbGw@mail.gmail.com>
 <b465353f-9291-f159-ba0b-4cd9577fc676@foss.st.com>
In-Reply-To: <b465353f-9291-f159-ba0b-4cd9577fc676@foss.st.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 11 Mar 2022 16:45:21 +0100
Message-ID: <CAPDyKFqu_Y2ixbw380t5qA_rXTPLMWasqpBmaMqP0nHUOqzQhw@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: mmc: mmci: add a property to disable DMA LLI
To:     Yann Gautier <yann.gautier@foss.st.com>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Christophe Kerello <christophe.kerello@foss.st.com>,
        Linus Walleij <linus.walleij@linaro.org>,
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

On Thu, 10 Mar 2022 at 17:00, Yann Gautier <yann.gautier@foss.st.com> wrote:
>
> On 3/8/22 11:57, Ulf Hansson wrote:
> > Hi Yann,
> >
> > On Fri, 4 Mar 2022 at 14:52, Yann Gautier <yann.gautier@foss.st.com> wrote:
> >>
> >> On STMicroelectronics variant of PL18x, the DMA Linked Lists are supported
> >> starting from revision v2 of the peripheral. But it has limitations,
> >> as all the buffers should be aligned on block size (except the last one).
> >> But this cannot be guaranteed with SDIO. We should then have a property
> >> to disable the support of LLI.
> >
> > Indeed, the buffer handling with SDIO is somewhat special, which also
> > has been discussed several times on LKML before. In principle, we need
> > the SDIO func drivers to respect buffer limitations that should be
> > specified by the mmc host drivers. Quite similar to what we already
> > have for block devices, like ->max_seg_size, ->max_seg, etc, that is
> > set per mmc host.
> >
> > I realize that implementing something like the above requires bigger
> > changes, which is why mmc host drivers instead validates the sglists
> > and the elements. In some cases that means returning an error code and
> > in others it could mean falling back to a non-DMA based I/O mode.
> >
> > For the stm32_sdmmc variant, it looks like the sglist validation is
> > being managed in sdmmc_idma_validate_data() already. Can it be
> > extended to cover this case too, rather than using a DT property?
> >
> > Kind regards
> > Uffe
>
> Hi Ulf,
>
> OK, I'll check what can be done for this. Patches 1 and 2 can be
> dropped, they will be reworked.

Okay.

> But patch 3 of this series could be taken, as not linked to LLI
> management. Should I push it again alone, or could you review it directly?

I have some comments/questions on it, but perhaps it makes it easier
for people to follow the discussion if it is done separately. So
please push it alone, then I will review it.

[...]

Kind regards
Uffe
