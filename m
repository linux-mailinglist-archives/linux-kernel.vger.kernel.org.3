Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CBD8494A11
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 09:51:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359425AbiATIuv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 03:50:51 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:51351 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359384AbiATIut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 03:50:49 -0500
Received: from mail-wm1-f50.google.com ([209.85.128.50]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1M2w4S-1n9Nl516nU-003Iri; Thu, 20 Jan 2022 09:50:47 +0100
Received: by mail-wm1-f50.google.com with SMTP id i187-20020a1c3bc4000000b0034d2ed1be2aso18739180wma.1;
        Thu, 20 Jan 2022 00:50:47 -0800 (PST)
X-Gm-Message-State: AOAM532+T5PvVkwuwVqOAgwW+JAlCBQwuxJ/v/rEw11TyDyI2Vm2oy2m
        5oL27DNA+HYoJVpKnzG7qUhcJcIzrtBw4hiH2Wk=
X-Google-Smtp-Source: ABdhPJwa2TLFWWtVzRt+gvdo3caSsHZVcnbUi/A/hVZ7P0/vZnDNJpHv52UMEl2oHT4PQoB1G9hWQmqPRnKWtHwc0qw=
X-Received: by 2002:a1c:2784:: with SMTP id n126mr5427772wmn.1.1642668646881;
 Thu, 20 Jan 2022 00:50:46 -0800 (PST)
MIME-Version: 1.0
References: <20220120080347.1595379-1-laurent@vivier.eu> <20220120080347.1595379-3-laurent@vivier.eu>
In-Reply-To: <20220120080347.1595379-3-laurent@vivier.eu>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 20 Jan 2022 09:50:30 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1oN8NrUjkh2X8jHQbyz42Xo6GSa=5n0gD6vQcXRjmq1Q@mail.gmail.com>
Message-ID: <CAK8P3a1oN8NrUjkh2X8jHQbyz42Xo6GSa=5n0gD6vQcXRjmq1Q@mail.gmail.com>
Subject: Re: [PATCH v11 2/5] tty: goldfish: introduce gf_ioread32()/gf_iowrite32()
To:     Laurent Vivier <laurent@vivier.eu>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rtc@vger.kernel.org, John Stultz <john.stultz@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:hjIIYFRUUftOuns46pp36ouon+Tk8dXglaJJkI5uFMgrWcu517j
 n69BfYDFLCyRSD3bRS7eYpW7kYAdDUQ2B7fNXsUyGaGFz3MqorGhZfb7MPy2FAYhOikPrNb
 2/OArlbT47nI5ipx2ZbTud9SnRXTo7+xCF6JZmisUOnX61sGAZS444c9LrjiHQC2r9O0MYG
 7US8SFjqpWwkZJZng+XVg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:HcOR5JkVswQ=:JnjTHhX2usyp9GNrmWwikf
 cAsJ6rg4xHyqAjHaCvnCwN4DeG5OLAe5vu/tatZ8yfBu1+1HPYN1XDVL1RmO/SxnBFflI7MBF
 UrUheH1rZk2KNwgOxkljSOlrk2jwUw7vuPA4N8nA0aXQz5c1lnNPYu3UXo6cQSkOJsvui0cph
 NMIHWFMOXPpTmoIh8CMNWEq2Lxt3n4GRUNp4bau/JHjRjj6zE35mv+qPgNkQ80ukbvq5BFXKx
 ZxBC7w014NPW3e9hDnWtpYjoHHjUe8ZY4S1RIvuhSD/u2dqAvVMTg8iAyU/Xe9fk/oXJnk1UK
 c4FexPtqJ5GD2D5y2u+d+6xAgco76evBhazktf43no+RTWRtluz6moJFbF74CtSG0zoHaOAbK
 c+IJH5xvkR493RA/g9+o7ra2fwFCa7Sd7kqKy4/Mm6dZ2CTNqNCUDuBYPd1lVJ4XWUat/Jhxu
 vSpV4cEpWSdnD2ZhaeFgkIjPk6X8xduudTUpy2cG8ajd5zo9u6vvkfaRCTZSh84CAKTgvMnl/
 JzFIEawqZ9zRkTdkhtr2JXEGzY1AsA76+3YKFRM8dkmyLFEo0zH6Nn5JbTGk+BbjmGsrkjmBO
 4VhQrXYkNcaaBYx9lP6mIx+hvzvoSpoe0RHWX6wYcXArbEYH4weo1E81Q/FvQPv8GnD3CWj36
 ZdlAxEG0RgSBsYIOI6fbAbbzCRyGx4p5kNswSXQyfu1AT36n2Q5lal9dl0aNJ37Pqq7dWT8lH
 +M6arKhHIxTLdEkY9u+4k5HgojZLeTucZRa8/1aQDiCl9Qtdr37Rx/ELUWRFZFGMMPbVYNJR/
 LPrWpg1QsopFjPVfXhdqtUXrVxRorv+rJbeXgVyhT9V23Yruj0=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2022 at 9:03 AM Laurent Vivier <laurent@vivier.eu> wrote:
>
> Revert
> commit da31de35cd2f ("tty: goldfish: use __raw_writel()/__raw_readl()")
>
> to use accessors defined by the architecture.
>
> Define by default the accessor to be little-endian as we
> have only little-endian architectures using goldfish devices.
>
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>

The patch looks good, but the description seems wrong to me:

Talking about "little-endian architectures" makes no sense here, the
point is that the device was clearly defined as having little-endian
registers, and your earlier patch broke this driver when running
on big-endian kernels (if anyone ever tried this).

This means you should also add

Cc: stable@vger.kernel.org # v5.11+
Fixes: da31de35cd2f ("tty: goldfish: use __raw_writel()/__raw_readl()")

The fact that m68k gets this wrong is just a bug in qemu, but it's
probably impossible to fix that since there is no way of knowing which
other operating systems have started relying on that bug over the years.

It might be a good idea to revisit the qemu implementation and make
sure that the extra byteswap is only inserted on m68k and not on
other targets, but hopefully there are no new targets based on goldfish
anymore and we don't need to care.

        Arnd
