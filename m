Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E57F49AE82
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 09:52:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1452871AbiAYIu4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 03:50:56 -0500
Received: from mail-ua1-f51.google.com ([209.85.222.51]:46606 "EHLO
        mail-ua1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1452282AbiAYIru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 03:47:50 -0500
Received: by mail-ua1-f51.google.com with SMTP id c36so36002122uae.13
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 00:47:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AlenwNbrW3HyQCtaJwFpWckVmU5Z8Lu18+yoa5O/tis=;
        b=t0ELgdYkuDJUTGewOeuFYsF+wWL+u/6fk+iBldOEdgdqUAZSB7bF0Ikmdv2DF9Ner9
         BrhDlp1bMlk753Wkb36t63N0dHSFlxQ0psnnfBSmdAfgLJqrD/duu49CXoOB9kWpGUo0
         /RcZBY1UWpkNXp09x05GIqgofHr8ZyleWfnT1yeAa69PyFU8qgyth7SyFWy9UiMY8lk1
         XC1bUUI3LUJAz8RtWgwmuuGeWlZbhsUWLHSDD37e1CsG+yhSrBOElQJKfOBx8EPx81c6
         dJAKtOOUkGU6WaIGJaZVzgzezAtnWKzYo2fMOJWQf4xEVxyW/hE7MTffrmB8sfKvVPBP
         uKmQ==
X-Gm-Message-State: AOAM531Y4L/42v09NPXvP6oABShbjIkQL6gLh9L70oq5v6cnLJNhnEkZ
        2ti3N7rxhWuzkwdi29OEAZI+D7vyXQOC1Q==
X-Google-Smtp-Source: ABdhPJwkgUvQRUgs3FL6ZUYhxpnLU0hC7s0dZKtWZ5l5CodJkUHfj9yMfN+KuaeuSib9EOWAgMISIw==
X-Received: by 2002:a9f:2ace:: with SMTP id d14mr6918837uaj.141.1643100468172;
        Tue, 25 Jan 2022 00:47:48 -0800 (PST)
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com. [209.85.222.52])
        by smtp.gmail.com with ESMTPSA id b26sm3936258uam.6.2022.01.25.00.47.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jan 2022 00:47:48 -0800 (PST)
Received: by mail-ua1-f52.google.com with SMTP id l1so34178618uap.8
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 00:47:47 -0800 (PST)
X-Received: by 2002:a67:b009:: with SMTP id z9mr3762032vse.57.1643100467677;
 Tue, 25 Jan 2022 00:47:47 -0800 (PST)
MIME-Version: 1.0
References: <20220125073137.1.83124@7e6451f583e7>
In-Reply-To: <20220125073137.1.83124@7e6451f583e7>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 25 Jan 2022 09:47:36 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVYhwpP0vSK4LT+50ZqB9opD8gcm-2aor8wAc49=GR+-w@mail.gmail.com>
Message-ID: <CAMuHMdVYhwpP0vSK4LT+50ZqB9opD8gcm-2aor8wAc49=GR+-w@mail.gmail.com>
Subject: Re: kisskb: FAILED linux-next/m68k-allmodconfig/m68k-gcc8 Tue Jan 25, 18:24
To:     linux-m68k <linux-m68k@lists.linux-m68k.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Yury Norov <yury.norov@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2022 at 8:31 AM <noreply@ellerman.id.au> wrote:
> FAILED linux-next/m68k-allmodconfig/m68k-gcc8 Tue Jan 25, 18:24
>
> http://kisskb.ellerman.id.au/kisskb/buildresult/14688953/
>
> Commit:   Add linux-next specific files for 20220125
>           d25ee88530253138d0b20d43511ca5acbda4e9f7
> Compiler: m68k-linux-gcc (GCC) 8.1.0 / GNU ld (GNU Binutils) 2.30
>
> Possible errors
> ---------------
>
> arch/m68k/include/asm/bitops.h:329:20: error: array subscript 2 is above array bounds of 'long unsigned int[1]' [-Werror=array-bounds]
> cc1: all warnings being treated as errors
> make[4]: *** [scripts/Makefile.build:289: drivers/net/ipa/ipa_mem.o] Error 1
> make[3]: *** [scripts/Makefile.build:572: drivers/net/ipa] Error 2
> make[2]: *** [scripts/Makefile.build:572: drivers/net] Error 2
> make[1]: *** [Makefile:1965: drivers] Error 2
> make: *** [Makefile:226: __sub-make] Error 2
>
> No warnings found in log.

The code that causes this is drivers/net/ipa/ipa_mem.c:ipa_mem_valid():

        DECLARE_BITMAP(regions, IPA_MEM_COUNT) = { };
        ...
        for_each_clear_bit(mem_id, regions, IPA_MEM_COUNT) {
                if (ipa_mem_id_required(ipa, mem_id))
                        dev_err(dev, "required memory region %u missing\n",
                                mem_id);
        }

This only happens with gcc-8, not with gcc-9, so it might be a
compiler bug. I don't see anything wrong with c:ipa_mem_valid()
nor with m68k's find_first_zero_bit().

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
