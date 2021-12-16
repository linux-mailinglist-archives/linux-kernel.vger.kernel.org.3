Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B395E477AD7
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 18:45:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240268AbhLPRpg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 12:45:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240046AbhLPRpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 12:45:31 -0500
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6B8CC06173E
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 09:45:30 -0800 (PST)
Received: by mail-ua1-x933.google.com with SMTP id w23so48502250uao.5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 09:45:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LDeVCQVHmAVidYDO/s0mhbIRYWBFtG/sro/1UJrEiAk=;
        b=r3DchQ3BYcmS7+9HivblR0/OCV2aiEuq0vRQyfBo9nYoN5ljTajRsY2bvPMBtakq7G
         +te8MME+r/8GsnYuRcUQ/MoloFY/xJiYWVw5XAH6rKePdC5hhzuyskuTxhZmIWzWpwr9
         l4dK/XSmj/eDKPPWinf0IkrSo0g2jVgQWomLY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LDeVCQVHmAVidYDO/s0mhbIRYWBFtG/sro/1UJrEiAk=;
        b=2A+1p3jBm3I6Q0eq8GD8d083Y6G11oBX7qhoqeMLG/5GLgu28hgDYMMR0ssAhHW03M
         +l4jsZy730RKCEf3KzodgZ0m/gXpRB6HSljIHngApSI2a37W7BSnXZFVEmx4UmSzkriE
         9OPReO1dG3nwue0bsMtKQspgGgqq0c/9OC/qR5Y/mJJ3Cl4gikIYkS+cAB9UICckvUU0
         FUg25LmQTxbZKS5CA9BqC//MO3QQCiDJExNGsjIXWAOV5H40EOo75gbcSZobqAqVYvQu
         rkzn7XVT6SrvmKd9pSRGFR2xjMjmfTFK8QaO/c0T3at5tHBqmctchDN/z+DbGnY0Batr
         aD9w==
X-Gm-Message-State: AOAM532c5kvDwDAaxzyMzfoZlArSIF29bGyYhGLQ10DgP/wtQUYi7pOD
        VAqUkDYj1/5He0J4i5x53h28O0CsXLkL6ePOb3AT9kJxe4E=
X-Google-Smtp-Source: ABdhPJzzuHdSOS9xdR7Q4na1iHF9/jKZ5rqheojoaoWwBNRSHrpeBFKT9JDn/twOrqzQVNpVN+r50de3IubMLxLUy7g=
X-Received: by 2002:a05:6102:c89:: with SMTP id f9mr717811vst.43.1639676730006;
 Thu, 16 Dec 2021 09:45:30 -0800 (PST)
MIME-Version: 1.0
References: <20211216105246.3548133-1-daniel@0x0f.com> <CABgxDoKJRc_qORcpFx=eNPS=bGV68hPrbeH0VtcQ2Jjx2ruqmg@mail.gmail.com>
 <CAFr9PX=AAssT1imCfpU_piGBOemD23RGBZzngznyia-4TXrK=g@mail.gmail.com> <CABgxDoLuOoE5qzzymE-htYz68Nrh8TzZ4d=LgbuNhJs9geevZg@mail.gmail.com>
In-Reply-To: <CABgxDoLuOoE5qzzymE-htYz68Nrh8TzZ4d=LgbuNhJs9geevZg@mail.gmail.com>
From:   Daniel Palmer <daniel@0x0f.com>
Date:   Fri, 17 Dec 2021 02:48:34 +0900
Message-ID: <CAFr9PXnqXkjxja_NLbAeJELtScNCemkKNy9obJqvWkk_RY7m+g@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] ARM: mstar: Initial Miyoo Mini support
To:     Romain Perier <romain.perier@gmail.com>
Cc:     devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Romain,

On Fri, 17 Dec 2021 at 02:34, Romain Perier <romain.perier@gmail.com> wrote:
> Well, I agree it is confusing. So I have discussed privately about
> this with Arnd (on IRC):

Yeah. I think in the same document for submitting patches it also says
no html (obvious), no links.. ;)

> <rperier> What is the real usage of the "Link:" tag ? it is mainly
> used as background informations for referencing archives or patches on
> lore.k.o  , but it can also be used for referencing something else or
> not ?
> (like information for a board)
> [...]
> <arnd> right, it's pretty much never wrong to add a Link: tag for the
> patch submission that was picked up, but you can also add it for any
> other reference, e.g.issue trackers or datasheets that may be relevant
>
> ----
>
> Which replies to the question, so it is okay for me ;)

Thank you for going the extra mile and confirming with Arnd.
I want to start adding a link to our wiki for every board we add as
the documentation is all over the place for these things, suddenly
disappears etc.

There's a 3 commit series coming for another SSD202D board in a few
days that will look just like this one.
Maybe now you have the sbc2d70 board you could add the DTS for that
too and we can pull all of these new boards in one DT pull request?

Cheers,

Daniel
