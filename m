Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32BA356B372
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 09:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237494AbiGHHZQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 03:25:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237413AbiGHHZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 03:25:13 -0400
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 308001837B
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 00:25:13 -0700 (PDT)
Received: by mail-qt1-f169.google.com with SMTP id e7so625507qts.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jul 2022 00:25:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VqT3m8gA4t9MFZN2vHoFQVMTXYsGoD6rUVaQJigFX7s=;
        b=HaZ4G39/vnYuvfYtOLXjbdld6ETo8O1KHaAKUbMreT2xSEAFAHKl/IzFxK0HO6th5E
         IG5VPupc8cCq7lMESzsmG6W1/Y4Z7LaVu3cWye00b8h4H4DCXuNXhVErJSNP6djkvNuy
         CNiiYTUonw7MxdK6Agy1KX43CKkCliouZtecPjESif4z6AALgZYX1unTR8zbJBIqFWpW
         9iaWWmHq8snv13MDoFgGQp3fO8qdn5N4TMDpY8pXnMIs3zM1oVdEWnpd+rrPifLp994D
         QF4DoCyA+VwoAAN/kj05UEjwhHIo8ySX/cqGwGcb+7yNwgKxLb5+BLWTKSIh8CwSXvHI
         9+vA==
X-Gm-Message-State: AJIora+OX0fIYfnQSQR07gGUtW85thjhiWym/X3YpSpgFxnc5ALE6WCP
        rN2g5kSZNXbgEIpNE4+OukhNzD9+xrXRCQ==
X-Google-Smtp-Source: AGRyM1tSOZ2/yvNtiKGYZp2OI9fiqa5pHFJdHD9+n8AXDGsZoKSaTr0vBSJuDr7zVab2/e0wEpFoqA==
X-Received: by 2002:ac8:478b:0:b0:31a:89a8:ea63 with SMTP id k11-20020ac8478b000000b0031a89a8ea63mr1743388qtq.79.1657265112152;
        Fri, 08 Jul 2022 00:25:12 -0700 (PDT)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com. [209.85.128.172])
        by smtp.gmail.com with ESMTPSA id u5-20020a37ab05000000b006b4748535a1sm10260190qke.16.2022.07.08.00.25.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Jul 2022 00:25:11 -0700 (PDT)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-3137316bb69so190553947b3.10
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jul 2022 00:25:11 -0700 (PDT)
X-Received: by 2002:a81:5404:0:b0:31c:c24d:94b0 with SMTP id
 i4-20020a815404000000b0031cc24d94b0mr2436888ywb.502.1657265110382; Fri, 08
 Jul 2022 00:25:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220531174514.1586248-1-laurent@vivier.eu> <CAMuHMdUbUZU3YA6nDC_LDAfUYQVmHTuCzrCfxDqwF=ZZyR5fqw@mail.gmail.com>
 <YseHZq/u9OkVltxW@zx2c4.com>
In-Reply-To: <YseHZq/u9OkVltxW@zx2c4.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 8 Jul 2022 09:24:59 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX7JPKJbth9xw4MbPbi29fgQNSva0r394JX-etEZiUJ_A@mail.gmail.com>
Message-ID: <CAMuHMdX7JPKJbth9xw4MbPbi29fgQNSva0r394JX-etEZiUJ_A@mail.gmail.com>
Subject: Re: [PATCH] m68k: virt: Kconfig minor fixes
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Laurent Vivier <laurent@vivier.eu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason,

On Fri, Jul 8, 2022 at 3:25 AM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> On Thu, Jun 02, 2022 at 09:13:14AM +0200, Geert Uytterhoeven wrote:
> > On Tue, May 31, 2022 at 7:45 PM Laurent Vivier <laurent@vivier.eu> wrote:
> > > Select VIRTIO_MENU as it is needed by VIRTIO_MMIO.
> > >
> > > Add an ending period at the end the virt machine help message.
> > >
> > > Reported-by: Randy Dunlap <rdunlap@infradead.org>
> > > Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> >
> > Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > i.e. will queue in the m68k for-v5.20 branch.
>
> Shouldn't this fix make it for 5.19? It causes Kconfig warnings during
> builds. So this seems like a ordinary mid-cycle bug that can be fixed.
>
> For example, if you ctrl+f for "unmet direct" in this log, you'll see
> this splat in the wireguard CI:
> https://build.wireguard.com/random/108f4fea7b6053dfd09039af74c0ac0c32c956be/m68k.log

These are merely configuration warnings, there is no build or runtime
failure.
I reverted this patch, disabled CONFIG_VIRTIO_MENU (which BTW defaults
to y), built and booted a kernel fine, and could login on the console.

So IMHO it can wait.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
