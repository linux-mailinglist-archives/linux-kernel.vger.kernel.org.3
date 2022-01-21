Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2376F496090
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 15:17:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381007AbiAUORk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 09:17:40 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:44800
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350707AbiAUORc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 09:17:32 -0500
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 0DD403F32C
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 14:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1642774651;
        bh=C15GD333u2dlFDIS89CpDK65jwsFW00MaLZn7bJW6aM=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=HO0VqGjtPHAW4zTrp6tLVPKu2yamcSIgNywRZECfZFHPG4QWljdwy9imxsb+ls8gw
         xDLE8p9FFuaNH4n+oJwhBGXPHSfz84wVQbn+APoEYjjpDAIhWgxEHXd7V0geGvANVA
         Zh2HPmwcZrLsIkytDC5fCnIyufGNUdF8DOAsTGjRDXh2TI/IOGyiHoQ4OFpdlZYPL2
         cZKLadFmp5eIbXDZzMUvqhZ76U/JKqJnRpKsEgBoR6u23rbfHNBylGkww+jk9Xa1x1
         rgJsa34F6J1DykLTsBEGRcjxKT8vN69fY5jKmEV+sWlN8OSefeXzeeOpGzGAEWp4SF
         TlU6CyMnhYpUw==
Received: by mail-ot1-f71.google.com with SMTP id t1-20020a9d7481000000b005919e9a1347so5567352otk.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 06:17:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C15GD333u2dlFDIS89CpDK65jwsFW00MaLZn7bJW6aM=;
        b=xhTiT2vVldznSCpI/yZg2fsiwsj+7+OxzmG69jPabGh9ZvNJynFiZP6ub8IP3Tu8Rp
         vYywhJalxOuUNHrsGPWHZ8jmq9l1uobI3NXGOmM53xKtDrs72A4Y303YrIDpf2xwIcJ9
         ozZtenqARQgJvBisZnCpbDdi3f7dWycoZK13pKbEkbxCe6n9sqp8FN5wAK20AIowbnV3
         bQls2ZOWzzZGM0LAUOxB14llP5zHocuW8+lCvJiHBCjhcckDocdchArk5MW49SfjDdKX
         8uVP0NkQNnw1HWdvq5xmaqW+I+PI7PWCchFHyxLb5qGg5Ddfx0/yb9a5TtXI5KkeLV57
         JIgA==
X-Gm-Message-State: AOAM5326TQjX/lt+iZkf8W8sWnUkHNlhCUau0/6kCeCy8x3yCxKuTby8
        wGrLPUgdImf7EXcybdiq3Ga4bsrHE7QLVZDiu4viCxj7lSd2FXEVTMfgHM+zQCH+jjLOrjitI0H
        xxbp3n3GGGdQS9/LHxvtzH+K4M45NAjVYS2vjk/l9Z6ZuIqOK7vsFBOgV5A==
X-Received: by 2002:a9d:6f0e:: with SMTP id n14mr2868609otq.269.1642774649891;
        Fri, 21 Jan 2022 06:17:29 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyjyQYmJzzz2UYJ55dcEmEYSMnUIqWkplegZ1x9EtTl1rxIQz108FwtIFS1NvH6aznxz7/zf7zcr4m/Fbj1psg=
X-Received: by 2002:a9d:6f0e:: with SMTP id n14mr2868583otq.269.1642774649588;
 Fri, 21 Jan 2022 06:17:29 -0800 (PST)
MIME-Version: 1.0
References: <20220120051929.1625791-1-kai.heng.feng@canonical.com>
 <YelxMFOiqnfIVmyy@lunn.ch> <CAAd53p7NjvzsBs2aWTP-3GMjoyefMmLB3ou+7fDcrNVfKwALHw@mail.gmail.com>
 <Yeqzhx3GbMzaIbj6@lunn.ch>
In-Reply-To: <Yeqzhx3GbMzaIbj6@lunn.ch>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Fri, 21 Jan 2022 22:17:18 +0800
Message-ID: <CAAd53p5pF+SRfwGfJaBTPkH7+9Z6vhPHcuk-c=w8aPTzMBxPcg@mail.gmail.com>
Subject: Re: [PATCH v2] net: phy: marvell: Honor phy LED set by system
 firmware on a Dell hardware
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     hkallweit1@gmail.com, linux@armlinux.org.uk,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 21, 2022 at 9:22 PM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Fri, Jan 21, 2022 at 12:01:35PM +0800, Kai-Heng Feng wrote:
> > On Thu, Jan 20, 2022 at 10:26 PM Andrew Lunn <andrew@lunn.ch> wrote:
> > >
> > > On Thu, Jan 20, 2022 at 01:19:29PM +0800, Kai-Heng Feng wrote:
> > > > BIOS on Dell Edge Gateway 3200 already makes its own phy LED setting, so
> > > > instead of setting another value, keep it untouched and restore the saved
> > > > value on system resume.
> > > >
> > > > Introduce config_led() callback in phy_driver() to make the implemtation
> > > > generic.
> > >
> > > I'm also wondering if we need to take a step back here and get the
> > > ACPI guys involved. I don't know much about ACPI, but shouldn't it
> > > provide a control method to configure the PHYs LEDs?
> > >
> > > We already have the basics for defining a PHY in ACPI. See:
> > >
> > > https://www.kernel.org/doc/html/latest/firmware-guide/acpi/dsd/phy.html
> >
> > These properties seem to come from device-tree.
>
> They are similar to what DT has, but expressed in an ACPI way. DT has
> been used with PHY drivers for a long time, but ACPI is new. The ACPI
> standard also says nothing about PHYs. So Linux has defined its own
> properties, which we expect all ACPI machine to use. According to the
> ACPI maintainers, this is within the ACPI standard. Maybe at some
> point somebody will submit the current definitions to the standards
> body for approval, or maybe the standard will do something completely
> different, but for the moment, this is what we have, and what you
> should use.

Right, so we can add a new property, document it, and just use it?
Maybe others will use the new property once we set the precedence?

>
> > > so you could extend this to include a method to configure the LEDs for
> > > a specific PHY.
> >
> > How to add new properties? Is it required to add new properties to
> > both DT and ACPI?
>
> Since all you are adding is a boolean, 'Don't touch the PHY LED
> configuration', it should be easy to do for both.

If adding a brand new property is acceptable, let me discuss it the vendor.

>
> What is interesting for Marvell PHYs is WoL, which is part of LED
> configuration. I've not checked, but i guess there are other PHYs
> which reuse LED output for a WoL interrupt. So it needs to be clearly
> defined if we expect the BIOS to also correctly configure WoL, or if
> Linux is responsible for configuring WoL, even though it means
> changing the LED configuration.

How about what Heiner proposed? Maybe we should leave the LED as is,
and restore it on system resume?

Kai-Heng

>
>          Andrew
