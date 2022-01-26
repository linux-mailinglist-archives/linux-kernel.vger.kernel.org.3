Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6729149D31C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 21:07:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbiAZUG5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 15:06:57 -0500
Received: from mail-ua1-f47.google.com ([209.85.222.47]:41920 "EHLO
        mail-ua1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbiAZUG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 15:06:56 -0500
Received: by mail-ua1-f47.google.com with SMTP id l1so783516uap.8;
        Wed, 26 Jan 2022 12:06:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JOMO0KZ96VSwI3Fjhw3+4AOK+IYIb4PO2J4HKTLIIaQ=;
        b=X0XYO/n1DupouvnpqOCFLU2v1pT18GA+bPgigahbiy31gp1FHyJHO51To4WpECZmXj
         denJBKKYk+r6HNg2b3GmnmXDCPEe2+3dWfZ/Sw+VqqaYGNuhb5nFnjOi4mKDAOidRiIR
         djlkdBsi0SbtYWYASk8NxrXJvpq+kDrb9DeP0s7V35OI7ubwauydk94c/AzHwT44/oIE
         bVS2tj56wNjr90Z2gbDcWmzvjhEB+c9EmnNGwSMc+pfdDIB5rje+3h+K3IxcXUGEHT0A
         p2nQStW8XUrtZbvw09YYr3mQBh1rcAhWeOC5LNq3W9sFWyDYYQwv5rlkRFrcXrZxfJF8
         XBxw==
X-Gm-Message-State: AOAM531ke0ZgZIvgpMrdstAGEQu4EDUWm6jnvVa8zexYydNAUxa4ZAQE
        LFnsR+rKAoe4eZ6CCDSI7mur9MXm/35Cjnax
X-Google-Smtp-Source: ABdhPJzb70/955t+BXZneTnoeiTOLdgG4GHjinhGygd6Kn7CFyXYeUIiDICYiHS64kuthSy5pCBdBA==
X-Received: by 2002:a05:6102:510d:: with SMTP id bm13mr327492vsb.51.1643227616092;
        Wed, 26 Jan 2022 12:06:56 -0800 (PST)
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com. [209.85.222.46])
        by smtp.gmail.com with ESMTPSA id b191sm60862vkb.32.2022.01.26.12.06.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jan 2022 12:06:55 -0800 (PST)
Received: by mail-ua1-f46.google.com with SMTP id p7so803372uao.6;
        Wed, 26 Jan 2022 12:06:55 -0800 (PST)
X-Received: by 2002:a67:5f83:: with SMTP id t125mr263175vsb.68.1643227615416;
 Wed, 26 Jan 2022 12:06:55 -0800 (PST)
MIME-Version: 1.0
References: <cover.1639744468.git.geert@linux-m68k.org> <4f409ac939e260a4657a0e6e6518ef8736527822.1639744468.git.geert@linux-m68k.org>
 <CAAhSdy3g9WsBmQk7KOgdVNSw9qUouxF2i==q9M3WQq3iabXv7Q@mail.gmail.com> <CAL_Jsq++-Sp45vna5-WhPsnrxp1_J1krrBUPgd2y3xkp5=sTSw@mail.gmail.com>
In-Reply-To: <CAL_Jsq++-Sp45vna5-WhPsnrxp1_J1krrBUPgd2y3xkp5=sTSw@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 26 Jan 2022 21:06:44 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXuM4wJKC7TgNd7VbZJ1xM0xBgB4os6S0WXpJUdsmxK4A@mail.gmail.com>
Message-ID: <CAMuHMdXuM4wJKC7TgNd7VbZJ1xM0xBgB4os6S0WXpJUdsmxK4A@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: timer: sifive,clint: Fix number of interrupts
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Anup Patel <anup@brainfault.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Anup Patel <anup.patel@wdc.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Wed, Jan 26, 2022 at 8:37 PM Rob Herring <robh+dt@kernel.org> wrote:
> On Fri, Dec 17, 2021 at 6:48 AM Anup Patel <anup@brainfault.org> wrote:
> > On Fri, Dec 17, 2021 at 6:08 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > The number of interrupts lacks an upper bound, thus assuming one,
> > > causing properly grouped "interrupts-extended" properties to be flagged
> > > as an error by "make dtbs_check".
> > >
> > > Fix this by adding the missing "maxItems".  As the architectural maximum
> > > is 4095 interrupts, using that as the limit would be unpractical.  Hence
> > > limit it to 10 interrupts (two interrupts for a system management core,
> > > and two interrupts per core for other cores).  This should be sufficient
> > > for now, and the limit can always be increased when the need arises.
> >
> > Same comment as the PLIC DT binding patch.
> >
> > The "maxItems" should represent CLINT spec constraints so
> > please don't add any synthetic value here.
>
> I agree.
>
> Geert, are you going to respin these?

Sure, will do, now we have an agreement.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
