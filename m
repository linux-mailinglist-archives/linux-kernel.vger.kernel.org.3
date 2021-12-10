Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 962254708F0
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 19:35:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245440AbhLJSjE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 10 Dec 2021 13:39:04 -0500
Received: from mail-oi1-f174.google.com ([209.85.167.174]:33614 "EHLO
        mail-oi1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbhLJSjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 13:39:00 -0500
Received: by mail-oi1-f174.google.com with SMTP id q25so14506367oiw.0;
        Fri, 10 Dec 2021 10:35:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cmWwBA8Prvw8yKg8YllQ7/9D+dqLH//9VzjE/Uy0t0I=;
        b=T1/HWPpmCqjZoOXrPzArHnW6919486jnuwLeXg0jqas0Gw7pOfSxrEQM69M5iCruoD
         aLPx6pLlMhKwqECaWRolng+5QRNmPPFTyUWLNcfdZp2emOXkatLQKphpMSeNMigcKekI
         0282gYYmG6v99S5rkbDXrKXN0xO0I79/FHY/Z8CQK/6lKKLc8WE2grdbCSI7NU7+Ox2c
         gLf3QgLblpk8wn9dZv8zj5ZZRZjqtTksyAJGNvRYzBbIzbdYmrV5NEFu24aMF7duygQQ
         WDbiVOIcvdytyH6sD38xY5pElpHdQJSlO7kEVqN7ol0Xl55TkYevA19mim8hgFSmDUdS
         rFDQ==
X-Gm-Message-State: AOAM530/atxOoYcEaBTGvUMhUD8wvOV1VGjK4hwfRYcDkt17vqKu8v6r
        RMRM5BBdjUBVljaoZLY0WiTrXWxUJvTPv5CANl8=
X-Google-Smtp-Source: ABdhPJy55tGpIDxF+0NXDym/GuLq/jPswo3lW9bQPH3JZ5naSMZQfeBVB0yUiflqPmuJ6rchV13JR6onKlnNSicDR4M=
X-Received: by 2002:aca:eb0b:: with SMTP id j11mr14005588oih.51.1639161324582;
 Fri, 10 Dec 2021 10:35:24 -0800 (PST)
MIME-Version: 1.0
References: <20211126180101.27818-1-digetx@gmail.com> <20211126180101.27818-8-digetx@gmail.com>
 <CAJZ5v0i=zgubEtF5-Wnaqa5FMnfVUdSnEmD11-LAuYCH8ZCwrA@mail.gmail.com> <acf8289e-6ab8-6eda-ec06-e9044ddd9a92@gmail.com>
In-Reply-To: <acf8289e-6ab8-6eda-ec06-e9044ddd9a92@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 10 Dec 2021 19:35:13 +0100
Message-ID: <CAJZ5v0gvuteY4EtXWTKmh4-Wt-Z_dPcqfDLwc-ja1uovbV3rpw@mail.gmail.com>
Subject: Re: [PATCH v4 07/25] reboot: Remove extern annotation from function prototypes
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
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
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 10, 2021 at 7:16 PM Dmitry Osipenko <digetx@gmail.com> wrote:
>
> 10.12.2021 21:09, Rafael J. Wysocki пишет:
> > On Fri, Nov 26, 2021 at 7:02 PM Dmitry Osipenko <digetx@gmail.com> wrote:
> >>
> >> There is no need to annotate function prototypes with 'extern', it makes
> >> code less readable. Remove unnecessary annotations from <reboot.h>.
> >>
> >> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> >
> > I'm not sure that this is really useful.
> >
> > Personally, I tend to respect the existing conventions like this.
> >
> > Surely, this change is not required for the rest of the series to work.
>
> Problem that such things start to spread all over the kernel with a
> copy-paste approach if there is nobody to clean up the code.
>
> This is not a common convention and sometimes it's getting corrected [1].
>
> [1] https://git.kernel.org/linus/6d7434931

In separate patches outside of series adding new features, if one is
so inclined.
