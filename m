Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEDEA4C65C2
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 10:34:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234358AbiB1JfT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 04:35:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231855AbiB1JfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 04:35:14 -0500
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E9E042499
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 01:34:28 -0800 (PST)
Received: by mail-vs1-f45.google.com with SMTP id e5so12243879vsg.12
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 01:34:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fsIvmUNCo/5VWlA0/Y4MVhiq1d6Mv6B/6S6hygEcBfA=;
        b=10tyhhhhVp944MspqnZqUCmH2NF4L+8TWqg8k/lApLy6WtCdFEHQtyrlLI5G5C153/
         Fer8qBC7kKaSCKnpJF+cbu2despalZw+Olp7YyKJDs4WH2UDc1zuyFRSb25mZYsZEnZf
         M1xQny8wYhS0x13meyoXe3Ni/R/VZR9spfOsiXZZGtbfwdvW6XE0jMK8JpajZuQZvJa4
         qQsEK1f9ItaurfU/Xq8zz0NMcBk+TLHeiqb4Ie5cj8EqrrLYJ58wI6eZtcfeG39ARdsB
         znUYp9a8nZKS3io4lu2OfaPu4W2FcNJEbjwHqgiiMpCOcv0dZ1Zi/8kPEY4LKJwzO6MF
         EuTQ==
X-Gm-Message-State: AOAM530pRK0qiS2+lNXFNilrK/jvEa2DBnTskxc+L+K3gA+8Dv54AWUG
        ZtnSTX+6Cq8j/tSeK0CHV6C5ymNUF2FH9Q==
X-Google-Smtp-Source: ABdhPJwDLsY6WSrrINSZ8kHohDExTo0IHnBmeP0AnAQ214qi+108EIFAqHAD32xQsV7MTSSh6b0hIw==
X-Received: by 2002:a67:e0cf:0:b0:31a:6079:cabf with SMTP id m15-20020a67e0cf000000b0031a6079cabfmr6983679vsl.39.1646040867082;
        Mon, 28 Feb 2022 01:34:27 -0800 (PST)
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com. [209.85.217.50])
        by smtp.gmail.com with ESMTPSA id m13-20020a056122138d00b0032c5d72c395sm1597580vkp.55.2022.02.28.01.34.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Feb 2022 01:34:26 -0800 (PST)
Received: by mail-vs1-f50.google.com with SMTP id d11so12290441vsm.5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 01:34:26 -0800 (PST)
X-Received: by 2002:a67:e113:0:b0:30e:303d:d1d6 with SMTP id
 d19-20020a67e113000000b0030e303dd1d6mr6829157vsl.38.1646040866438; Mon, 28
 Feb 2022 01:34:26 -0800 (PST)
MIME-Version: 1.0
References: <YhjYPIRvDnV7XAzV@kroah.com> <CAHk-=wjLvye-_qj-J=dVWhFf7S8noL6d-szRtFYq_hoOk6J1Eg@mail.gmail.com>
 <Yhndy5cTzhJh7abq@kroah.com>
In-Reply-To: <Yhndy5cTzhJh7abq@kroah.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 28 Feb 2022 10:34:15 +0100
X-Gmail-Original-Message-ID: <CAMuHMdX35YGpACUsk3iUhk3KF96PB3fxs1jfQ75g6_ddFS=rXQ@mail.gmail.com>
Message-ID: <CAMuHMdX35YGpACUsk3iUhk3KF96PB3fxs1jfQ75g6_ddFS=rXQ@mail.gmail.com>
Subject: Re: [GIT PULL] Staging driver fix for 5.17-rc6
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-staging@lists.linux.dev
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

On Sat, Feb 26, 2022 at 9:08 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> On Fri, Feb 25, 2022 at 11:57:43AM -0800, Linus Torvalds wrote:
> > On Fri, Feb 25, 2022 at 5:23 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> > > It resolves a reported problem in the fbtft fb_st7789v.c driver that
> > > could cause the display to be flipped in cold weather.
> >
> > LOL. WTF?
> >
> > I just had to read the commit message for that odd thing.
>
> Here it is in the real world, I should have added this to the changelog,
> but I figured the url might not be permanent:
>         https://www.core77.com/posts/111994/Hyundais-Strange-Cold-Weather-UI-Bug-Digital-Dashboard-Rotates-Flips-Display

Don't keep your production drivers too long in staging?

(sorry, couldn't resist :-)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
