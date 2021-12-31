Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA7AF482496
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Dec 2021 16:35:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231131AbhLaPfg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Dec 2021 10:35:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbhLaPfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Dec 2021 10:35:31 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA72EC061574;
        Fri, 31 Dec 2021 07:35:30 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id bm14so109936580edb.5;
        Fri, 31 Dec 2021 07:35:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BBVQBI32yp8CmROb7EIEEt0uoANYGmZ8VFjWYLn1/iE=;
        b=Wtfq/hghpzkqguPYyuVfRXtDuTYP+nJPkVl1+1wJuk872XWUKZo6qOEDLIlPxRHWAT
         X+7r6LZbAHBJPpyGPw9Z4QDk54TAM4gOfoDEKr0yp6m11x8rD4uPhCN3Zf63x6Vr/Mrb
         t+2s4gcAivQkisTiWBSS1NZq99nwsVCry0anMNAIY0IcOLSOF+CJTVVzuJ37Ny9Wb6Mp
         S+X+2yMA9vMQ0k5KA+3PC5Pp2Hzm+Z9FecP0g+IjWjocFbT4J5XteBACvY9w1VeMZtCA
         /g1L05tejxjQTs4gNjI+ZnCJEl2GxLPTl/5NuqfitiBZU8AcnJ+m5ZzVbvsWA540s1l4
         B7xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BBVQBI32yp8CmROb7EIEEt0uoANYGmZ8VFjWYLn1/iE=;
        b=myUVz9V26DLRGotUkLrikEsBc9Dmh8t10wVWNT62qtSezxe/KQax2tHcqKYuZJ4x9F
         QOwjC2vvgMl1IzpE/akuXyUR9Qpq27MhDEzjNrPOaZB211kylOD+XCUFTpSBDzXOxdzh
         zOL78y0UBigIeUrIARIpR2vn5Nbbujk2Gj4WEsMxDD/nuMtkv/NIfNGKj1+nb/Qmn2hD
         0F6+BrS75WnccOyqMo2PhnDtp+0GBFXcQwTq+9OkFBpd1Q8F0r1zazB9RWVjkQmJDZq6
         LkhAs4eve1LJ5VNJD37MH7AyIJHDm36fUZzPiCwUheQZnuR566QSaNEa3/tvp+4t2ls/
         1sRA==
X-Gm-Message-State: AOAM532LJrcFHqpTLWZXNdYy4dQ+oEZRjyrSZ2offWWRzJ7aizCe73m8
        CAp1RFqtIwbebvneuVHdeCqrNVaKdSlst5aSykY=
X-Google-Smtp-Source: ABdhPJxGK+Pm5sWduX627fyQasmcKs55chqIihJcOe0FByR/1MmTk77LC/Vquahf0V4cZaxByRogNK/b5U9E844slWE=
X-Received: by 2002:a17:907:75dc:: with SMTP id jl28mr28283563ejc.13.1640964929172;
 Fri, 31 Dec 2021 07:35:29 -0800 (PST)
MIME-Version: 1.0
References: <20211230102110.3861-1-yu.tu@amlogic.com> <20211230102110.3861-2-yu.tu@amlogic.com>
 <CAFBinCCwjS36ss_4sU+o9m8gEprFsVZbqcxgpQxczTNohZqFdA@mail.gmail.com> <a296e666-368b-4cd5-427e-30fc66a15b49@amlogic.com>
In-Reply-To: <a296e666-368b-4cd5-427e-30fc66a15b49@amlogic.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Fri, 31 Dec 2021 16:35:18 +0100
Message-ID: <CAFBinCA2V=sx95Q=+4nLDXFK1Os11XVWtK8KauxixVwYXLUz1Q@mail.gmail.com>
Subject: Re: [PATCH V3 1/6] tty: serial: meson: Drop the legacy compatible
 strings and clock code
To:     Yu Tu <yu.tu@amlogic.com>
Cc:     linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Vyacheslav <adeep@lexina.in>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 31, 2021 at 11:27 AM Yu Tu <yu.tu@amlogic.com> wrote:
[...]
> >> -/* Legacy bindings, should be removed when no more used */
> >> -OF_EARLYCON_DECLARE(meson, "amlogic,meson-uart",
> >> -                   meson_serial_early_console_setup);
> > This part is still needed as long as above series is not merged yet.
> > If we remove this then earlycon will stop working on the 32-bit SoCs
> > unless [0] is merged.
> >
> > All other code below - except the of_device_id entry - can still be
> > removed since meson8.dtsi and meson8b.dtsi are using the non-legacy
> > clocks already.
> >
> > Sorry for only noticing this now.
> >
> I will add it back in the next patch and delete it after your submission
> is merged.
I have just seen that Greg has already added this patch to the tty-next tree [1]
In this case there's nothing to do on your end - I'll simply ask Neil
to also queue my 32-bit SoC UART .dts fixes [0] for 5.17


Best regards,
Martin


[0] https://patchwork.kernel.org/project/linux-amlogic/cover/20211227180026.4068352-1-martin.blumenstingl@googlemail.com/
[1] https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git/commit/?h=tty-next&id=ad234e2bac274a43c9fa540bde8cd9f0c627b71f
