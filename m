Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 216F54D5E19
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 10:14:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344505AbiCKJO4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 11 Mar 2022 04:14:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235073AbiCKJOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 04:14:53 -0500
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FC841BB716;
        Fri, 11 Mar 2022 01:13:50 -0800 (PST)
Received: by mail-qt1-f173.google.com with SMTP id s15so6804816qtk.10;
        Fri, 11 Mar 2022 01:13:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Qy21Roxk7Jw81ENX+w2eLBpFqTOjz71afyIHHh67koY=;
        b=JpCokKohe3Vf6rV0NTt7oC3LuZNFXf3lalpq710xBlXxLjP2eKb7PkiC+OSjJl53nt
         Z0QuHwf9Kkn2yg/6IEMO8vZckX7jRngd/1y+J1aZ3aKGErp/++6AfL8cA5pBspuGmFrK
         oEatYWvGQZJifD/bs/iIE8Ohg0J5YN0R9Rr0AbWlPm9mWqWc1Dmgy+8QDrB2OPfQo50X
         zLljhon77fGq1VLrDo2EoKNavvt4BbU3Zw7xC446OUC/i+CYQsJPkOj9eS9xkRorguDO
         z7yVX2pAZ02pQ8nGl7vd66kloMN0kBjISmKi6o6KExM5+j9+di8Q1AxCTPMFmMWIa2q7
         dY0w==
X-Gm-Message-State: AOAM532YaNCgB4mWftw3f7LItZ8g3r9/zQU9/2l7+CbuFpSEcrC42hxb
        JVhAzZwgEKMKe1JONXWcpJMZSEVy0/fu4w==
X-Google-Smtp-Source: ABdhPJys4pNJaGnGgKuKQ6lJQlNzMX6ZiS2VMpULUfPkF+iD+DvbEAJ1gNytidkPvG3lnWYOMfjsKA==
X-Received: by 2002:ac8:5743:0:b0:2e0:6069:8c54 with SMTP id 3-20020ac85743000000b002e060698c54mr7372813qtx.30.1646990028615;
        Fri, 11 Mar 2022 01:13:48 -0800 (PST)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com. [209.85.219.177])
        by smtp.gmail.com with ESMTPSA id f19-20020ac859d3000000b002de4d014733sm4993038qtf.13.2022.03.11.01.13.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Mar 2022 01:13:48 -0800 (PST)
Received: by mail-yb1-f177.google.com with SMTP id z30so16005797ybi.2;
        Fri, 11 Mar 2022 01:13:47 -0800 (PST)
X-Received: by 2002:a25:dc4:0:b0:629:2337:f9ea with SMTP id
 187-20020a250dc4000000b006292337f9eamr7243141ybn.6.1646990027606; Fri, 11 Mar
 2022 01:13:47 -0800 (PST)
MIME-Version: 1.0
References: <20220310072239.4489-1-zajec5@gmail.com> <CAMuHMdWQNDABuT9uwAugrzdQM31wFtXX_9F8MviC-BRc-YngKw@mail.gmail.com>
 <145c66e0-2ba5-712c-57de-82378328ec3f@gmail.com> <7d7ed784-f01f-44a0-4387-cd7a76a8abe4@gmail.com>
In-Reply-To: <7d7ed784-f01f-44a0-4387-cd7a76a8abe4@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 11 Mar 2022 10:13:36 +0100
X-Gmail-Original-Message-ID: <CAMuHMdU92K9ZLptwJPG_opA4Reg61ksOgQ-P+2niHX=bf306Kg@mail.gmail.com>
Message-ID: <CAMuHMdU92K9ZLptwJPG_opA4Reg61ksOgQ-P+2niHX=bf306Kg@mail.gmail.com>
Subject: Re: [PATCH] tty: serial: bcm63xx: use more precise Kconfig symbol
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Kevin Cernekee <cernekee@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
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

Hi Florian,

On Thu, Mar 10, 2022 at 10:49 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
> On 3/10/22 12:33 AM, Rafał Miłecki wrote:
> > On 10.03.2022 09:19, Geert Uytterhoeven wrote:
> >> On Thu, Mar 10, 2022 at 8:22 AM Rafał Miłecki <zajec5@gmail.com> wrote:
> >>> From: Rafał Miłecki <rafal@milecki.pl>
> >>>
> >>> Patches lowering SERIAL_BCM63XX dependencies led to a discussion and
> >>> documentation change regarding "depends" usage. Adjust Kconfig entry to
> >>> match current guidelines. Make this symbol available for relevant
> >>> architectures only.
> >>>
> >>> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> >>> Ref: f35a07f92616 ("tty: serial: bcm63xx: lower driver dependencies")
> >>> Ref: 18084e435ff6 ("Documentation/kbuild: Document platform
> >>> dependency practises")
> >>> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> >>
> >> Thanks for your patch!
> >>
> >>> --- a/drivers/tty/serial/Kconfig
> >>> +++ b/drivers/tty/serial/Kconfig
> >>> @@ -1100,7 +1100,8 @@ config SERIAL_TIMBERDALE
> >>>   config SERIAL_BCM63XX
> >>>          tristate "Broadcom BCM63xx/BCM33xx UART support"
> >>>          select SERIAL_CORE
> >>> -       depends on COMMON_CLK
> >>> +       depends on MIPS || ARM || ARM64 || COMPILE_TEST
> >>> +       default ARCH_BCM4908 || BCM63XX || BMIPS_GENERIC
> >>
> >> So ARCH_BCM4908 covers ARM64, and BCM63XX || BMIPS_GENERIC
> >> cover MIPS.  Is there some symbol covering ARM so we can change the
> >> depends to
> >>
> >>      depends on FOO || ARCH_BCM4908 || BCM63XX || BMIPS_GENERIC ||
> >> COMPILE_TEST
> >>
> >> ?
> >
> > Florian, Kevin: do you know what other platforms need that driver?
>
> Yes that would be ARCH_BCM_63XX.

Had to read this twice, before I realized this is different from BCM63XX.

As we already have

    drivers/char/hw_random/Kconfig:    ARCH_BCM_63XX || BCM63XX ||
BMIPS_GENERIC || COMPILE_TEST
    drivers/spi/Kconfig: depends on BCM63XX || BMIPS_GENERIC ||
ARCH_BCM_63XX || COMPILE_TEST

and drivers/tty/serial/Kconfig would be a third case, would it make
sense to unify BCM63XX and ARCH_BCM_63XX into a single symbol?
We already share several ARCH_* symbols between arm and arm64,
and I expect more will be shared with riscv in the future
(e.g. ARCH_RENESAS).

Or are MIPS BCM63xx and ARM BCM63xx too dissimilar?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
