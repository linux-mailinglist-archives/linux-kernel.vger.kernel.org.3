Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6050A506EA5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 15:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352731AbiDSNpw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 09:45:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352698AbiDSNpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 09:45:09 -0400
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B3C338BC3;
        Tue, 19 Apr 2022 06:41:27 -0700 (PDT)
Received: by mail-qv1-f47.google.com with SMTP id b17so13114966qvp.6;
        Tue, 19 Apr 2022 06:41:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jGm6guTALRSU5+PRnvbVJaHFz19D6EpgjjGAnT9VVE4=;
        b=4JEdMvpbiMgx28XR8Fg5kRuOMFgA9V7b+ZKqAkqsa7OEJ6xaPAfwXNr+2nfUddWQ81
         0JX78BD+/tj7SmI3szrVygKlS4aLCEzix1GzpQpfXtcK5qJwrZfJc5VrPJKs8GK0/qM0
         FojlNz4PM21owIFDaY7VTImXCvwTzcLvAKz9C6V2xdQ4mONsm6Qznc4kKeuaVA+yNbDl
         K3rePScJRjo5C5a3g07g6oqgPGfkdA7x89QL2+toLxu+TI3d5sNs55366iYQ8HJFYsIG
         +2dMXVoR6nP67uUK35gKLw01j4PVEVNfkRcLoNMTkpYZ5vDyU4zBBdzxaMxP6/q5I274
         MuNQ==
X-Gm-Message-State: AOAM531Om/8lcbjdS1arIqFg0EyMZC5IOr7EUjoxdgCe2z7fUi1LPXp1
        h4fKJeuUudwRxMh7WmtQaGMK7e96Ih/7SA==
X-Google-Smtp-Source: ABdhPJyJ1A6FiVgoio+yHvhRxV4zyEMQE1hZTjjz04uYHzDT/C4103SoGyxgz50tdbvVg2oLGHnFjw==
X-Received: by 2002:a0c:e8ca:0:b0:446:e7a:61af with SMTP id m10-20020a0ce8ca000000b004460e7a61afmr11308174qvo.37.1650375686852;
        Tue, 19 Apr 2022 06:41:26 -0700 (PDT)
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com. [209.85.219.181])
        by smtp.gmail.com with ESMTPSA id s4-20020ae9de04000000b0069c3a577b0asm24755qkf.51.2022.04.19.06.41.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Apr 2022 06:41:26 -0700 (PDT)
Received: by mail-yb1-f181.google.com with SMTP id s33so3657508ybi.12;
        Tue, 19 Apr 2022 06:41:26 -0700 (PDT)
X-Received: by 2002:a05:6902:724:b0:644:c37b:4e21 with SMTP id
 l4-20020a056902072400b00644c37b4e21mr14534539ybt.6.1650375686021; Tue, 19 Apr
 2022 06:41:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220419132716.1392407-1-arnd@kernel.org>
In-Reply-To: <20220419132716.1392407-1-arnd@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 19 Apr 2022 15:41:14 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUW+jPUJzdJ-xWQYxDy4SMJ1PDFbFDsBk9Km-+EObgsvA@mail.gmail.com>
Message-ID: <CAMuHMdUW+jPUJzdJ-xWQYxDy4SMJ1PDFbFDsBk9Km-+EObgsvA@mail.gmail.com>
Subject: Re: [PATCH] [v2] m68k: coldfire: drop ISA_DMA_API support
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Greg Ungerer <gerg@linux-m68k.org>, Arnd Bergmann <arnd@arndb.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Finn Thain <fthain@linux-m68k.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 19, 2022 at 3:27 PM Arnd Bergmann <arnd@kernel.org> wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> After a build regression report, I took a look at possible users of
> CONFIG_ISA_DMA_API on m68k and found none, which Greg confirmed. The
> CONFIG_GENERIC_ISA_DMA option in turn is only needed to implement
> ISA_DMA_API, and is clearly not used on the platforms with ISA support.
>
> The CONFIG_ISA support for AMIGA_PCMCIA is probably also unneeded,
> but this is less clear. Unlike other PCMCIA implementations, this one
> does not use the drivers/pcmcia subsystem at all and just supports
> the "apne" network driver. When it was first added, one could use
> ISA drivers on it as well, but this probably broke at some point.
>
> With no reason to keep this, let's just drop the corresponding files
> and prevent the remaining ISA drivers that use this from getting built.
>
> The remaining definitions in asm/dma.h are used for PCI support.
>
> Link: https://lore.kernel.org/lkml/9e5ee1c3-ca80-f343-a1f5-66f3dd1c0727@linux-m68k.org/
> Cc: Greg Ungerer <gerg@linux-m68k.org>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> v2: drop GENERIC_ISA_DMA as well, add some background on CONFIG_ISA.

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
