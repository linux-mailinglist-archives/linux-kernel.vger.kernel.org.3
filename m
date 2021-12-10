Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6D0746FDF3
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 10:37:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238563AbhLJJlH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 04:41:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbhLJJlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 04:41:06 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 989CCC061746;
        Fri, 10 Dec 2021 01:37:31 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id 131so19922485ybc.7;
        Fri, 10 Dec 2021 01:37:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jTTqTSeVWhePE44IwQg6aUNKq4YqbWzy6Vy449Rr4PY=;
        b=Ad9s0IOzhFfzQ8FAyCIgNcL42WU3LycPM6wSBdGi97oFrivpj2JrsUkabx7rZln1AF
         TK1LO9rZfwwItIxlEuMyGI8JihiJSZTruLCrjyUrKug7KFoT4kTSqnodSs+TUUQviS7E
         qXKPn02Y1AHxV19ZnLne8Z8k/d/xZCnQ9q2LI9VDzu/P8ImxBQf+WLMCZZ1Luoy30XJW
         TlTPwR1e96Eiev1skhduZkpyMzNliBjiFLqVMhJTvd8ERZF3syXT/YnIOuV3LlwhnleY
         4iHiIrSw7FctTcJ6GGg0+ptrm6xf4wV+Ne8UZ/hD6EN1rXFdEndBl6HzulrN0NOqB7SU
         /WYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jTTqTSeVWhePE44IwQg6aUNKq4YqbWzy6Vy449Rr4PY=;
        b=pBsw1C472/PZ8uA5MRkU554eEcwWZoVXjsriX1nnAwppifUWeZ7MT4x6f4hctTsov3
         LsdTt2wcV35G49pSAkFFLQRJead8cNmitnZfEkxx0UC483S+ltQaq++ApsMnYX1vrEFn
         /RNSb5tQriQuNCiLlNLgNQ8zKaj3+aSISNQwldNWHPHqNOIDbfizAzUC/XO2GdzduRNS
         GVGu3Od2mzlNMS0wDXbgWEu7d45aHzx4D3Emn2WSZP+gY88W0lNDTdnLauPtArQkOHIE
         Gbqii382bCqpXuS6nifaOoxj3kGfy2KWoxFIJgcTZ6GY05+jGAb3gMXc405fI2gwrCAn
         5qMA==
X-Gm-Message-State: AOAM533KVDjABxDAiu01RxDzZ91nFTs55to1KkyU+QHR7zQVCzeMhAKH
        mpblBr9zzwWvMSDK70Gy953HV6lT37KVEyFLuJQ=
X-Google-Smtp-Source: ABdhPJw99RXIuMM1D17R51607ElhuT/bzKFzp8BPahTe4tFT6QFRy2/+3CAyFszPRRI49TTS9+QmqvxHikikYeqnj/E=
X-Received: by 2002:a25:4213:: with SMTP id p19mr13181614yba.41.1639129050834;
 Fri, 10 Dec 2021 01:37:30 -0800 (PST)
MIME-Version: 1.0
References: <20211110225808.16388-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CA+V-a8sCVkbwYeVGsQpv2q0OjwUSB_jqmjPptHN-ENSdU+pT1Q@mail.gmail.com>
 <CA+V-a8tTm=n+TuE5N1Ptkvh6n1sYjSZWpQpmY1F5RiwK-ocvFQ@mail.gmail.com> <CACRpkdYDNQGWr8u18K7duy9MUd-njuyFQkXvZ4VQuvxXNOOicw@mail.gmail.com>
In-Reply-To: <CACRpkdYDNQGWr8u18K7duy9MUd-njuyFQkXvZ4VQuvxXNOOicw@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Fri, 10 Dec 2021 09:37:05 +0000
Message-ID: <CA+V-a8uTGv20dYacb7ieL_G+Nwy-o7PXqyCT68nVFfdAE3dJhA@mail.gmail.com>
Subject: Re: [RFC PATCH v3 0/7] Renesas RZ/G2L IRQC support
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Marc Zyngier <maz@kernel.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 10, 2021 at 2:04 AM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Fri, Dec 10, 2021 at 2:09 AM Lad, Prabhakar
> <prabhakar.csengg@gmail.com> wrote:
>
> > I plan to post a non RFC version soon, can I have your feedback on this please.
>
> I actually cannot see the patches (just this cover letter) I wonder if
> they got stuck.
>
I was able to locate them in gpio patchwork
https://patchwork.ozlabs.org/project/linux-gpio/cover/20211110225808.16388-1-prabhakar.mahadev-lad.rj@bp.renesas.com/

> For
> gpio: gpiolib: Allow free() callback to be overridden
> gpio: gpiolib: Add ngirq member to struct gpio_irq_chip
>
> I trust whatever Marc
> says. If he agrees we need this, then we need this.
>
OK.

> Yours,
> Linus Walleij

Cheers,
Prabhakar
