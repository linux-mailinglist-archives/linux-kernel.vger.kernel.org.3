Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15CC0470887
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 19:21:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245042AbhLJSY7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 13:24:59 -0500
Received: from mail-ot1-f45.google.com ([209.85.210.45]:36740 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232317AbhLJSY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 13:24:57 -0500
Received: by mail-ot1-f45.google.com with SMTP id w6-20020a9d77c6000000b0055e804fa524so10466716otl.3;
        Fri, 10 Dec 2021 10:21:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CGnO4bxnTAqMK/uthYlBDN3+OwLPbg309qxpgobdKxI=;
        b=JQqLUENsrI5IkcGF/2AE7ycxBmUBO2UNBstuoJohEA0+HuZ484A3lSp4Ja90GQ86iN
         qb5t7UH541mwYt6JJGuNyUu/O820AGmPInoFqKpblNWXbnWo+Q3RLKCuH6tQzovpEsiZ
         hV4EEfLrmr7yZqm0rhO9/qIus1ZGp6+6KtoLtGu01DZ0stX47Co7obUtXIXSRbr23wFQ
         EFGVSVQ5+TYPgQoaqcUvCSSdlBgxlAoaaohZEi+PTVJrkNZG2qUgWbjI+PHC2/+07u8r
         0ekNfZlw5etMpZRSU2LMYuF6XtuSZ5ioBCMmBNbD1d1CweZ6+cRbRzPimvJVLn47mDdC
         aMew==
X-Gm-Message-State: AOAM532jLfLGtHvqpXTRh4Jup1gIGunr6bQwXLZv3TgswDXkkrsQyUkY
        uMwwZN/Mi9IjddJdmjpm1ckZizSAJfyVwqMnYjc=
X-Google-Smtp-Source: ABdhPJxyUbegeOKjvJ3CxiHL7dwpj9EzFVDPRUNdKiJGM3d307QrxgUO9bUGZj0EMwemLB2snxZHAeDirffJcqK0rDM=
X-Received: by 2002:a05:6830:1e57:: with SMTP id e23mr12377743otj.16.1639160481982;
 Fri, 10 Dec 2021 10:21:21 -0800 (PST)
MIME-Version: 1.0
References: <20211126180101.27818-1-digetx@gmail.com> <20211126180101.27818-5-digetx@gmail.com>
In-Reply-To: <20211126180101.27818-5-digetx@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 10 Dec 2021 19:21:11 +0100
Message-ID: <CAJZ5v0h_OfrQ92KqsUdiKAfUrXDT9dPXzq4S=b6zi4k_2cPAjg@mail.gmail.com>
Subject: Re: [PATCH v4 04/25] reboot: Correct typo in a comment
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Joshua Thompson <funaho@jurai.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Sebastian Reichel <sre@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Lee Jones <lee.jones@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, alankao@andestech.com,
        "K . C . Kuen-Chern Lin" <kclin@andestech.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-csky@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-riscv@lists.infradead.org,
        Linux-sh list <linux-sh@vger.kernel.org>,
        xen-devel@lists.xenproject.org,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 26, 2021 at 7:02 PM Dmitry Osipenko <digetx@gmail.com> wrote:
>
> Correct s/implemenations/implementations/ in <reboot.h>.
>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>

This patch clearly need not be part of this series.

> ---
>  include/linux/reboot.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/reboot.h b/include/linux/reboot.h
> index af907a3d68d1..7c288013a3ca 100644
> --- a/include/linux/reboot.h
> +++ b/include/linux/reboot.h
> @@ -63,7 +63,7 @@ struct pt_regs;
>  extern void machine_crash_shutdown(struct pt_regs *);
>
>  /*
> - * Architecture independent implemenations of sys_reboot commands.
> + * Architecture independent implementations of sys_reboot commands.
>   */
>
>  extern void kernel_restart_prepare(char *cmd);
> --
> 2.33.1
>
