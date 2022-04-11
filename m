Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E24224FB8B0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 11:56:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344902AbiDKJ63 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 05:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235994AbiDKJ6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 05:58:23 -0400
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0193941334;
        Mon, 11 Apr 2022 02:56:10 -0700 (PDT)
Received: by mail-qt1-f182.google.com with SMTP id o18so8632424qtk.7;
        Mon, 11 Apr 2022 02:56:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O7QWdPF9wFARWEpFmkRlF+ejhR6FxhyYYT3eOvfg8Zw=;
        b=5psvg43/DtqxhYLFwn3pBE+VGGcfDQw69MAipfDrQWasKB0xv6PzQLKEjdEktPN0U2
         7uhzdyDefKxJGMH4huOf4tl8f2fNKewDWIdFsdnoO81DGmMdSZb39S6RNAB2vUS2i3G3
         +yXwQ7y1p7TjYZjorUcgyl3whLHpfZ9WMXMX9qLxAzYcEA8+XP0xUR9k3kL1aWO6OqNh
         GnEr31p5EVKTjDOYBT5GyX4Jwr5+V+H46/sUgdRw5s8vYuCqKW9LM7Lcx7mWQUCBbKSr
         U+JILX+1FWMWDgvsn7OjY4GzxEqBNxrrHnIGTu14fOo3U/Bk7aYfmHEO7uWGIAuMCbyU
         Z0AQ==
X-Gm-Message-State: AOAM533+MmyEb8zvb5vFtTVAhi6BvLwqxrG5xHJDTw2VmUvj6pQ8J0pQ
        m9v5DDRhisqi8UWNqxb4CFf+b4niX6NG/Q==
X-Google-Smtp-Source: ABdhPJxJuL2ZWi0mhsTvs+bSBUdKPCu8byMUZlBikR/lfgTSX1IQwQQ5g9NnMVhSwN32zJmeU4jKWw==
X-Received: by 2002:a05:622a:1896:b0:2ef:483b:16b9 with SMTP id v22-20020a05622a189600b002ef483b16b9mr785790qtc.610.1649670969057;
        Mon, 11 Apr 2022 02:56:09 -0700 (PDT)
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com. [209.85.219.170])
        by smtp.gmail.com with ESMTPSA id z8-20020ac87f88000000b002e1cecad0e4sm24678071qtj.33.2022.04.11.02.56.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Apr 2022 02:56:08 -0700 (PDT)
Received: by mail-yb1-f170.google.com with SMTP id p65so8226866ybp.9;
        Mon, 11 Apr 2022 02:56:08 -0700 (PDT)
X-Received: by 2002:a05:6902:101:b0:633:ccde:cfca with SMTP id
 o1-20020a056902010100b00633ccdecfcamr21144323ybh.207.1649670968330; Mon, 11
 Apr 2022 02:56:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220406201523.243733-1-laurent@vivier.eu>
In-Reply-To: <20220406201523.243733-1-laurent@vivier.eu>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 11 Apr 2022 11:55:57 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWkPcHW3Ba19giDHJC6g-GNmQ7HnZAavutxh3q_ZF5y6Q@mail.gmail.com>
Message-ID: <CAMuHMdWkPcHW3Ba19giDHJC6g-GNmQ7HnZAavutxh3q_ZF5y6Q@mail.gmail.com>
Subject: Re: [PATCH v16 0/4] m68k: Add Virtual M68k Machine
To:     Laurent Vivier <laurent@vivier.eu>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-rtc@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alessandro Zummo <a.zummo@towertech.it>
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

On Wed, Apr 6, 2022 at 10:15 PM Laurent Vivier <laurent@vivier.eu> wrote:
> The most powerful m68k machine emulated by QEMU is a Quadra 800,
> but this machine is very limited: only 1 GiB of memory and only some
> specific interfaces, with no DMA.
>
> The Virtual M68k Machine is based on Goldfish interfaces defined by Google
> for Android simulator. It uses Goldfish-rtc (timer and RTC),
> Goldfish-pic (PIC) and Goldfish-tty (for early tty).
>
> The machine is created with 128 virtio-mmio buses, and they can
> be used to add serial console, GPU, disk, NIC, HID, hwrng, 9PFS...
>
> The virtual m68k machine has been merged in QEMU and will be available
> with the release 6.0.
>
> This series introduces the support of this new machine in the linux kernel.

Thanks, queued in the m68k for-v5.19 branch.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
