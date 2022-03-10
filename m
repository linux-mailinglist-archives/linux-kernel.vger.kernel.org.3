Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7B2F4D425D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 09:20:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240299AbiCJIVN convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 10 Mar 2022 03:21:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240279AbiCJIVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 03:21:09 -0500
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 348E37EA1A;
        Thu, 10 Mar 2022 00:20:09 -0800 (PST)
Received: by mail-qt1-f175.google.com with SMTP id s15so4000453qtk.10;
        Thu, 10 Mar 2022 00:20:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VXCwsz1vlxRfyJE4o5+R6FHrnMiGPF9OZgitO+Nevyc=;
        b=1VnvRBgE966LFf+pkHbZblfvOSLEedEyzIMClMcbnucaD/kDhCzREy3wsAQvhNIzS0
         fGP8t+V7+bmt3yu8q0/K1feogJnzEceAsEMzVHzjkV5LEL8IlPW/zWSOV1V9VTobrbTO
         WyestBLNiNG1/yHvLjHc2B+Oc1fxJ4mKg/w7nJ/KXDVLSz/0DNi8UZVIF5S8MXI6jUXR
         r5fchmQU3jWlXhjcckgrciRAo5rRPLtOLQf8GxlKj+Nh2kxG+ZD94votk/AR07S3iqrS
         a9WFa+KvlnogQABbi4ygLRzVDdijzgPHnwDzxEMtwToDFNpdHTPiKqwVh4i3ViHs1BZ/
         ksLg==
X-Gm-Message-State: AOAM5332ElyyMYMt5e6MgbraVpk6lwMCkZTjkKrWL1aoHohfhMTqRitp
        WlRjTNvQeVl/EWvV3iRDaFZG/DN6v0TaJQ==
X-Google-Smtp-Source: ABdhPJzYJvEw8bUf5xBR6XkHULSNNJu1guSwW1bkZGZgjiTnWekCQx7voDZ+1cZQ2tD39nCnBl8Giw==
X-Received: by 2002:a05:622a:1454:b0:2de:922e:3209 with SMTP id v20-20020a05622a145400b002de922e3209mr2899776qtx.471.1646900407541;
        Thu, 10 Mar 2022 00:20:07 -0800 (PST)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com. [209.85.128.178])
        by smtp.gmail.com with ESMTPSA id c16-20020a05622a059000b002dc93dc92d1sm2774990qtb.48.2022.03.10.00.20.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Mar 2022 00:20:06 -0800 (PST)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-2db2add4516so49821587b3.1;
        Thu, 10 Mar 2022 00:20:06 -0800 (PST)
X-Received: by 2002:a81:5a08:0:b0:2db:d8c6:7e4f with SMTP id
 o8-20020a815a08000000b002dbd8c67e4fmr3028923ywb.256.1646900406218; Thu, 10
 Mar 2022 00:20:06 -0800 (PST)
MIME-Version: 1.0
References: <20220310072239.4489-1-zajec5@gmail.com>
In-Reply-To: <20220310072239.4489-1-zajec5@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 10 Mar 2022 09:19:54 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWQNDABuT9uwAugrzdQM31wFtXX_9F8MviC-BRc-YngKw@mail.gmail.com>
Message-ID: <CAMuHMdWQNDABuT9uwAugrzdQM31wFtXX_9F8MviC-BRc-YngKw@mail.gmail.com>
Subject: Re: [PATCH] tty: serial: bcm63xx: use more precise Kconfig symbol
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafał,

On Thu, Mar 10, 2022 at 8:22 AM Rafał Miłecki <zajec5@gmail.com> wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
>
> Patches lowering SERIAL_BCM63XX dependencies led to a discussion and
> documentation change regarding "depends" usage. Adjust Kconfig entry to
> match current guidelines. Make this symbol available for relevant
> architectures only.
>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Ref: f35a07f92616 ("tty: serial: bcm63xx: lower driver dependencies")
> Ref: 18084e435ff6 ("Documentation/kbuild: Document platform dependency practises")
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>

Thanks for your patch!

> --- a/drivers/tty/serial/Kconfig
> +++ b/drivers/tty/serial/Kconfig
> @@ -1100,7 +1100,8 @@ config SERIAL_TIMBERDALE
>  config SERIAL_BCM63XX
>         tristate "Broadcom BCM63xx/BCM33xx UART support"
>         select SERIAL_CORE
> -       depends on COMMON_CLK
> +       depends on MIPS || ARM || ARM64 || COMPILE_TEST
> +       default ARCH_BCM4908 || BCM63XX || BMIPS_GENERIC

So ARCH_BCM4908 covers ARM64, and BCM63XX || BMIPS_GENERIC
cover MIPS.  Is there some symbol covering ARM so we can change the
depends to

    depends on FOO || ARCH_BCM4908 || BCM63XX || BMIPS_GENERIC || COMPILE_TEST

?

Anyway, this is definitely a step in the good direction!

>         help
>           This enables the driver for the onchip UART core found on
>           the following chipsets:

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
