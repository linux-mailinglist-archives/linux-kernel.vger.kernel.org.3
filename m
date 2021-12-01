Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EFCD464E79
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 14:06:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349473AbhLANKJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 08:10:09 -0500
Received: from mail-ua1-f54.google.com ([209.85.222.54]:47090 "EHLO
        mail-ua1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349470AbhLANKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 08:10:02 -0500
Received: by mail-ua1-f54.google.com with SMTP id az37so48764900uab.13;
        Wed, 01 Dec 2021 05:06:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AgwbFm5gkjwOtodlhi0zJJvcgS/i7V2fCpFuxG8kd94=;
        b=Jyvtm+6VZ1RGnb/UF5Vm2HvEcmFtsdfMZ5s5FZuwhPAzmzps3fGeV6/BftmLs8sXHV
         s71tVkjgsFI4KTQJ/aqj9HiPbS3UNdPmEBViSTgCGx/BHPdUGkywaSbrUThizp07XUpS
         FkHGwSaUj7YmL3DX9shMazC+URsI488X6vW7p1nOw5MDWr3vLdB/MK4egkaap+kjSQqL
         LmAsGMoSG7VFgjN90qy9AyiSdiwGdoxjfBLXe47doiU6OA4TO6fXn+YFzu0oE5NbJq8e
         DUGF4orm2PJCcltkYMeDiltd3h2HdMed3W8UCocM3HTv18220QBKFfMUtTs3+DSSjFGs
         n6Rg==
X-Gm-Message-State: AOAM533oN2GyOETqR8O6IEJF/qy5pqkmZe7W6uOaG2wiZ8fPXU9RHXd0
        tBPwlTEgMseey0amVJNGlokDFNcsxguS1w==
X-Google-Smtp-Source: ABdhPJzq0/vFLXekmqPdt2QkRJrW/G+np5DNNGqURV3YxjfADxXe/vodZVtnBIWxOE6mWhETKhsm6w==
X-Received: by 2002:a67:bb11:: with SMTP id m17mr6696201vsn.5.1638364000316;
        Wed, 01 Dec 2021 05:06:40 -0800 (PST)
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com. [209.85.222.46])
        by smtp.gmail.com with ESMTPSA id 15sm11833419vkj.49.2021.12.01.05.06.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Dec 2021 05:06:40 -0800 (PST)
Received: by mail-ua1-f46.google.com with SMTP id r15so48823383uao.3;
        Wed, 01 Dec 2021 05:06:39 -0800 (PST)
X-Received: by 2002:a05:6102:c89:: with SMTP id f9mr7151505vst.68.1638363999694;
 Wed, 01 Dec 2021 05:06:39 -0800 (PST)
MIME-Version: 1.0
References: <20211130164558.85584-1-tsbogend@alpha.franken.de> <20211130164558.85584-3-tsbogend@alpha.franken.de>
In-Reply-To: <20211130164558.85584-3-tsbogend@alpha.franken.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 1 Dec 2021 14:06:28 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXr1bT3U_XKvHKowfQwaW6-4XevYngoNzQFu-bYwdMP_A@mail.gmail.com>
Message-ID: <CAMuHMdXr1bT3U_XKvHKowfQwaW6-4XevYngoNzQFu-bYwdMP_A@mail.gmail.com>
Subject: Re: [PATCH 3/3] MIPS: TXX9: Remove TX4939 SoC support
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        MTD Maling List <linux-mtd@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On Tue, Nov 30, 2021 at 5:46 PM Thomas Bogendoerfer
<tsbogend@alpha.franken.de> wrote:
> After removal of RBTX4939 board support remove code for the TX4939 SoC.
>
> Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>

Thanks for your patch!

> ---
>  arch/mips/pci/Makefile                |   1 -
>  arch/mips/pci/pci-tx4939.c            | 107 -----
>  arch/mips/txx9/Kconfig                |   8 -
>  arch/mips/txx9/generic/Makefile       |   1 -
>  arch/mips/txx9/generic/irq_tx4939.c   | 216 ----------
>  arch/mips/txx9/generic/setup_tx4939.c | 568 --------------------------
>  drivers/char/hw_random/Kconfig        |  13 -
>  drivers/char/hw_random/Makefile       |   1 -
>  drivers/char/hw_random/tx4939-rng.c   | 157 -------
>  drivers/mtd/nand/raw/Kconfig          |   2 +-
>  10 files changed, 1 insertion(+), 1073 deletions(-)
>  delete mode 100644 arch/mips/pci/pci-tx4939.c
>  delete mode 100644 arch/mips/txx9/generic/irq_tx4939.c
>  delete mode 100644 arch/mips/txx9/generic/setup_tx4939.c
>  delete mode 100644 drivers/char/hw_random/tx4939-rng.c

You forgot to remove arch/mips/include/asm/txx9/tx4939.h.

My rbtx4927 still works fine afterwards, so
Tested-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
