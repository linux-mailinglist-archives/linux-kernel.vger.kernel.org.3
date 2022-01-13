Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B5E248D9A9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 15:24:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235636AbiAMOYQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 09:24:16 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:42539 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230165AbiAMOYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 09:24:15 -0500
Received: from mail-wr1-f48.google.com ([209.85.221.48]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MBjA4-1n2UBW0DSm-00C9MI; Thu, 13 Jan 2022 15:24:14 +0100
Received: by mail-wr1-f48.google.com with SMTP id k18so10355889wrg.11;
        Thu, 13 Jan 2022 06:24:13 -0800 (PST)
X-Gm-Message-State: AOAM533tEZAwRlPx4iIUeWVpit2fa8o/mS27pINOdlThUZ7S/RiVKHz2
        V8MmMrWiunOqBsZrvU8fCzADPvgD4hXe2W2szV4=
X-Google-Smtp-Source: ABdhPJzwdYNeuVL1yYVlSfvEK+FTNzOKpNJueoBQfapcDBGMQlXdww3vJ6mdjQ5Vf5ltdNIbHFcn1y8+QiEEWUP219Q=
X-Received: by 2002:a5d:6ac7:: with SMTP id u7mr4238291wrw.219.1642083853640;
 Thu, 13 Jan 2022 06:24:13 -0800 (PST)
MIME-Version: 1.0
References: <20220113121143.22280-1-alim.akhtar@samsung.com>
 <CGME20220113122413epcas5p46cb2cafb73936c423017240f98f72845@epcas5p4.samsung.com>
 <20220113121143.22280-15-alim.akhtar@samsung.com> <55c22c3a-57ea-3320-ccb9-f03643563235@canonical.com>
In-Reply-To: <55c22c3a-57ea-3320-ccb9-f03643563235@canonical.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 13 Jan 2022 15:23:57 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0etf+AybUe5O9uRLAbo4J145t0-ThkEccNtKzue+0-qA@mail.gmail.com>
Message-ID: <CAK8P3a0etf+AybUe5O9uRLAbo4J145t0-ThkEccNtKzue+0-qA@mail.gmail.com>
Subject: Re: [PATCH 14/23] arm64: dts: fsd: Add initial device tree support
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Alim Akhtar <alim.akhtar@samsung.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        SoC Team <soc@kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        "moderated list:ARM/SAMSUNG EXYNOS ARM ARCHITECTURES" 
        <linux-samsung-soc@vger.kernel.org>,
        Pankaj Dubey <pankaj.dubey@samsung.com>, linux-fsd@tesla.com,
        Arjun K V <arjun.kv@samsung.com>,
        Aswani Reddy <aswani.reddy@samsung.com>,
        Ajay Kumar <ajaykumar.rs@samsung.com>,
        Sriranjani P <sriranjani.p@samsung.com>,
        Chandrasekar R <rcsekar@samsung.com>,
        Shashank Prashar <s.prashar@samsung.com>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:7BPRVd2KsOfp6FWr24wAaVhirUW9rNpHQv7NpYpVUsp7tt30Dha
 j23Kxt68dpwB+bLGGHBrcSzKIQ4yWozz8SrjACzkvHE+i6sYk/WuegjVFQk/clMoW+sBV66
 dxzEdNexgwNZQOZc72vSJlCuhYLKhfGujPiZx9AcNC8A8Yz3AQ25InyytdgH2u9UdAJ1Cnw
 HoL0wZwLRKqo1TtUXoTOQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:/Lf+mNMsya4=:ODGibD+HcJW7nRTYSF9hYn
 NnndQEhNXlcWzFS0FC5kjCBHUwmGWi3JBWpP4E3ojJjycuh+WQZF2dZ3X8pM5G1PW/Pa2q4mz
 h7CvoTb8whYSKYbWpcf2GqqyJS63UbdJwfrQgY+RmljmcL8O+ubi1+FLTmxAU8GKMJbZ5Y+Oe
 jkRpXagkJ1FvcD7T0FYD6/utdUIrsAQ0DHWmh1Q7SJ1ZGnkMwW0GQ6YB1kx9uf1nZykkBSZiq
 OD9S2iP4reWW7HrhZxog69dGoG1VqSNQTFBzyND4NXwwjsmmtVdhIwp3jS0P7v84rKOO0xbnT
 DSw8vmVMXFNXk9ND7OSCuc1t++ZuVpGN8VEA+ue4IXzXYDTWMjfIWIRRcxB572mad4LzX15UO
 +L26WPBEnftclnZB1FO71dq5yejhJtHOSdZygvNlpIDsg9GdN8AFCPI6wEKGbU3oCWI4ivB7J
 v33R/zIKq4Nd3u8NE2J+vphKXc6p8kSjoV9b/HF2v16fo7lwX5Cdw5YEw0hoezzFHnnnLpfrY
 H6gq2ioZCCLqyzqCuXllY7rlzZcU8AsZLigNpjUHFH6QlCjr08jeuf1re8ngqSVT6sK216tuP
 dyP0c+3Rxdg2tNh+0beQxAk6sact2u9B/MU9JoHthtNeHoE+DbvFdWXmvP4ssDlxaQBVv/UIL
 JYe2Xl10EUnvLI8wkRwVb/B/M+7d6gWPoOtWUX6Cc7Z03k4OigwIfSTUy7knrxki2fJ4=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 13, 2022 at 2:16 PM Krzysztof Kozlowski
<krzysztof.kozlowski@canonical.com> wrote:
> >  ARM/TETON BGA MACHINE SUPPORT
> >  M:   "Mark F. Brown" <mark.brown314@gmail.com>
> >  L:   linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> > diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
> > index 54e3910e8b9b..bb8a047c2359 100644
> > --- a/arch/arm64/Kconfig.platforms
> > +++ b/arch/arm64/Kconfig.platforms
> > @@ -267,6 +267,12 @@ config ARCH_TEGRA
> >       help
> >         This enables support for the NVIDIA Tegra SoC family.
> >
> > +config ARCH_TESLA_FSD
> > +     bool "ARMv8 based Tesla platform"
> > +     select ARCH_EXYNOS
>
> How similar it is? I think it is better to duplicate Exynos
> selections/options here, instead of selecting entire ARCH. If this would
> require "depends on ARCH_EXYNOS || ARCH_TESLA_FSD" everywhere in the
> drivers, it's a hint that it is not a separate SoC but it is an Exynos,
> so it might not need a new sub-architecture.

Agreed, the SoC family options mainly exist so we can quickly enable or
disable drivers based on what a kernel is built for. If most of the drivers
for this SoC are shared with Exynos, I think having a single option is
sufficient, but it may be worth pointing out both in the help text.

If we want to have a separate option (mainly to help users find it), maybe
a 'depends on ARCH_EXYNOS' would be better. How many uses of
ARCH_TESLA_FSD are there?

        Arnd
