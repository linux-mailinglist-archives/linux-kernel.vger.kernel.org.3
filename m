Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A53E4D5EA7
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 10:43:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347582AbiCKJog convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 11 Mar 2022 04:44:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbiCKJob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 04:44:31 -0500
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C452E17BC7B;
        Fri, 11 Mar 2022 01:43:28 -0800 (PST)
Received: by mail-qv1-f44.google.com with SMTP id e22so6569064qvf.9;
        Fri, 11 Mar 2022 01:43:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/HUxs0nSCg7GyOeJqVRb99UMJe6feL25jT8YqOq9aIM=;
        b=TaulkoaRGnfOpc3pYJij4XV+EY700eGijGuLtrS9iZFw9dQF20Bb36FxqjhYh7XceN
         H/iVb+y+ztMdqnUFBAxyqyzWyYO3adClUYzAn6/KWWwSoAx/JYEGUUy2Y10jNHZnXnTe
         /dZdWhItYxwZv3H5yYXhqWBm8TVUaemPrh2BH9gA/aOPyksg4x1GpMRN6dUfutXwjm8g
         V6VO8nOjm5tdp9yb7GZi4ZuO7vkkmfD1PkJ3tEOR8jDLUeEr8bVxuHU/pC8HFr59EAZG
         wUzcR/2RfdomTi3XG1PGwtNIvgkW4I5hy4p0Tz05zqhKxhOr8EXFFcw2977BGx6Uc8Kh
         86Fw==
X-Gm-Message-State: AOAM531TKKJWOhz8W6AF7L8Xz0VD2EWfz0UDmlwEhI2Pz0RpKPNZAB+E
        FvVCNLHxPkulHlr57YANptoWY1Zi172Sjw==
X-Google-Smtp-Source: ABdhPJy+azsOCUhGIXJN6LVj8KHHwHkZ13Mimr3eppMxmGxZQzntyq+Gir/70aByE9RT6LKQkD0QBw==
X-Received: by 2002:a05:6214:19c6:b0:433:82b:b900 with SMTP id j6-20020a05621419c600b00433082bb900mr6903303qvc.7.1646991807532;
        Fri, 11 Mar 2022 01:43:27 -0800 (PST)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com. [209.85.219.179])
        by smtp.gmail.com with ESMTPSA id g21-20020ac85815000000b002e06e2623a7sm4978511qtg.0.2022.03.11.01.43.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Mar 2022 01:43:26 -0800 (PST)
Received: by mail-yb1-f179.google.com with SMTP id x200so16087443ybe.6;
        Fri, 11 Mar 2022 01:43:25 -0800 (PST)
X-Received: by 2002:a25:c54a:0:b0:628:9d7f:866a with SMTP id
 v71-20020a25c54a000000b006289d7f866amr7431768ybe.546.1646991804635; Fri, 11
 Mar 2022 01:43:24 -0800 (PST)
MIME-Version: 1.0
References: <20220311093233.10012-1-zajec5@gmail.com>
In-Reply-To: <20220311093233.10012-1-zajec5@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 11 Mar 2022 10:43:12 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWjOa7Mv_=HChjqPjSQ2T-b7Z9ZGEAT35q39x_Uy3zeLQ@mail.gmail.com>
Message-ID: <CAMuHMdWjOa7Mv_=HChjqPjSQ2T-b7Z9ZGEAT35q39x_Uy3zeLQ@mail.gmail.com>
Subject: Re: [PATCH V3] tty: serial: bcm63xx: use more precise Kconfig symbol
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

On Fri, Mar 11, 2022 at 10:32 AM Rafał Miłecki <zajec5@gmail.com> wrote:
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
> ---
> V2: Use precise "depends" (exact platforms)
> V3: Don't default y for COMPILE_TEST

Thanks for the update!

> --- a/drivers/tty/serial/Kconfig
> +++ b/drivers/tty/serial/Kconfig
> @@ -1100,7 +1100,8 @@ config SERIAL_TIMBERDALE
>  config SERIAL_BCM63XX
>         tristate "Broadcom BCM63xx/BCM33xx UART support"
>         select SERIAL_CORE
> -       depends on COMMON_CLK
> +       depends on ARCH_BCM4908 || ARCH_BCM_63XX || BCM63XX || BMIPS_GENERIC || COMPILE_TEST
> +       default ARCH_BCM4908 || ARCH_BCM_63XX || BCM63XX || BMIPS_GENERIC

I'm still not convinced about the default, as it wasn't there before,
hence all existing config files must already have it.
But if the BCM people think it's good to have, I'll shut up ;-)

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

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
