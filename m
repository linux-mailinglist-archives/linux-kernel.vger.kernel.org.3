Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A519468C99
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 19:15:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237117AbhLESSh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 13:18:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237102AbhLESSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 13:18:36 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3552C061714;
        Sun,  5 Dec 2021 10:15:08 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id y12so33518734eda.12;
        Sun, 05 Dec 2021 10:15:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=SqpxYZMXggh8b1bfYQBh49tAcZib8Y6s1iaC8Hm+BT4=;
        b=Sqf4i4BaUOCNXqqYbfnTwk1s9f/lrX0Np2cQAFBFhMaSWKhpbAVN+uKijYpPO93A6Y
         N2YywPQC7L0sBTosu96xEiMfWJI32nUNaZ3ko77p2epREaMe3SwiuxteLrCSqbi2ucy5
         mv/5evqFx5sHDNNHSGI1+WwdlufINIDaYHqI5a3QnR+F5V5dn0JWuUuklzsRhk6CaDaV
         vhX8KP1SJ5yeff9CZvLdwcBbIANQWJhLuJ//D7cs1ITxAOAoGbc94+LCWOX/cEmpOPUj
         BMnxp2mallUK8Ky1I6q9WyP06rSdXSu+sSnGBpPGm/4H4fx2m4Fli+d5qd+7rkNlHi/O
         TVQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=SqpxYZMXggh8b1bfYQBh49tAcZib8Y6s1iaC8Hm+BT4=;
        b=STwecnBTO4Ze5j4ZBI22yA2yH6SCFXHFdz+wwoJer5M4XqNXZrPMtZ0QNtdiVC3TU2
         osfkZqHuay3O8Q0qt+v5pR4XS+uJKwskAfgn4rO3z2KgMO37q+jauAqAgnzCdfilflSf
         0ehw7YvgQR9FdVwQ0A6VNT89AC3lw1HxbmjzxKvBGGYx0v/lcG0PE9sWIzRh+jR5/Ts2
         1VIxl1dBMibSAME54PCcSsDl1X9XhzBU8WUpl2hpxp4AzQVyUXhfi0Pz236dYtuzQ+1i
         q2f/Euo1NSV1vvYXNqgOE8VFnumiSUBQmuYnIqqvcTz8N11x3QusQWFDw1EIsahzmMb3
         S0zA==
X-Gm-Message-State: AOAM533mcLJ+BzMFhm7niF9OyuhsVnw4doOOv+hJpjM73D1Kqj6arbT9
        FOc8SPf3DXpTnqaOpqXtvvAl9aJ7p3+pDJrY
X-Google-Smtp-Source: ABdhPJwMG/LiVD2dLyeMtVmYcHkmckkGlgfY5QHSjrklYHMCivYr9eaW6k2dbUhYmswDoH6czVEmYA==
X-Received: by 2002:a05:6402:440b:: with SMTP id y11mr47249774eda.25.1638728107268;
        Sun, 05 Dec 2021 10:15:07 -0800 (PST)
Received: from ?IPv6:2a02:ab88:368f:2080:eab:126a:947d:3008? ([2a02:ab88:368f:2080:eab:126a:947d:3008])
        by smtp.gmail.com with ESMTPSA id l16sm6567822edb.59.2021.12.05.10.15.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Dec 2021 10:15:06 -0800 (PST)
Message-ID: <60f5c2e98e3a2048f86a79c3aa1ed945dc0cb4aa.camel@gmail.com>
Subject: Re: [PATCH 6/6] arm64: dts: exynos: Add initial device tree support
 for Exynos7885 SoC
From:   David Virag <virag.david003@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Sam Protsenko <semen.protsenko@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Date:   Sun, 05 Dec 2021 19:14:23 +0100
In-Reply-To: <de24b968-f359-25bf-76d7-69328401f83d@canonical.com>
References: <20211205153302.76418-1-virag.david003@gmail.com>
         <20211205153302.76418-7-virag.david003@gmail.com>
         <de24b968-f359-25bf-76d7-69328401f83d@canonical.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2021-12-05 at 18:31 +0100, Krzysztof Kozlowski wrote:

[...]

> > +       fimc_is_mclk0_in: fimc_is_mclk0_in {
> > +               samsung,pins = "gpc0-0";
> > +               samsung,pin-function = <EXYNOS_PIN_FUNC_INPUT>;
> > +               samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> > +               samsung,pin-drv = <2>;
> > +       };
> > +
> > +       fimc_is_mclk0_out: fimc_is_mclk0_out {
> > +               samsung,pins = "gpc0-0";
> > +               samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
> > +               samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> > +               samsung,pin-drv = <2>;
> > +       };
> > +
> > +       fimc_is_mclk0_fn: fimc_is_mclk0_fn {
> 
> I cannot get the point of these pin configurations - three groups
> with
> only function difference. How this would be used by the driver? Maybe
> just keep the one really used. Same for others below.
> 

They seem to be changed in some cases by the FIMC-IS and/or Camera
module drivers in the downstream kernel. I'm not exactly sure about why
and how are they needed, as the code for FIMC-IS is quite large and
it's not my priority to work on it right now. I can remove these
configurations for now if that's okay, maybe I, or someone else will
re-add it later if it's needed.

> 
> > +               samsung,pins = "gpc0-0";
> > +               samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> > +               samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> > +               samsung,pin-drv = <2>;
> > +       };
> > +

[...]

> > +
> > +       arm-pmu {
> > +               compatible = "arm,armv8-pmuv3";
> 
> Wrong compatible. Please use specific, although I don't know which
> one
> you have - 53 or 73... since you have two clusters, I would expect
> two
> PMUs, hmm....

I was thinking the same, but there's a problem: As I'm also guessing we
have two PMUs for the a53 and a73 cores, we'd need to seperate it but I
have no access to the documentation that would let me know which
interrupts we would need for both of these PMUs. The downstream dts
doesn't tell us anything specific in this case, and I have no idea how
else am I supposed to know which interrupts are right without a TRM.

I'd be guessing either the 82, 83 or the 218, 219 interrupts would be
the right one for the a73 cores, and I suspect that it should be 82 and
83, but I can't really confirm this.

Do you have any idea how to proceed in this case? Maybe there is a way
to test which ones would be right?

> 
> > +               interrupts = <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>,
> > +                            <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>,
> > +                            <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>,
> > +                            <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>,
> > +                            <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>,
> > +                            <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>,
> > +                            <GIC_SPI 218 IRQ_TYPE_LEVEL_HIGH>,
> > +                            <GIC_SPI 219 IRQ_TYPE_LEVEL_HIGH>;
> > +               interrupt-affinity = <&cpu6>,
> > +                                    <&cpu7>,
> > +                                    <&cpu0>,
> > +                                    <&cpu1>,
> > +                                    <&cpu2>,
> > +                                    <&cpu3>,
> > +                                    <&cpu4>,
> > +                                    <&cpu5>;
> > +       };
> > +

[...]

> Best regards,
> Krzysztof

The rest of the things you mentioned will be fixed in v2

Best Regards,
David
