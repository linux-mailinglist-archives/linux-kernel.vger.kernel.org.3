Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68784496060
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 15:05:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380909AbiAUOFC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 09:05:02 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:44140
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1380896AbiAUOE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 09:04:27 -0500
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com [209.85.161.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id B476A3F19C
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 14:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1642773865;
        bh=3OQ/VaDIuTDhMC1t1W5jGAk9lH9/vCwpiE19iLKBlBc=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=Ac0b3abZRX6hCnauPzNCt+mtMRBeERZ6i1f3GriO138x6os+/SJFuWrm/PFPMqBVp
         DNME9hpaKucHUD88jaPAy/Uz+Kjz8fP7dKYFMrTWpifErDzrsR/xJ4QH1kJoLpMFMT
         DMuQffpdVLcxIbAu09AQyopk2minRWA37TGtk/XrK1MylTWuLwe0snAE6bXsH2kdsx
         S4pWB8w/26x4WVWaWF7GmIXIpPTaDopGj84rKgDestPIT0nW+Xi2Vk69lEqqHMEUXe
         YZGkpSe3DYyjLqWZqYkPBQl3fOBso4hYF5WSry4kB2g1Nh8pgEgWPOYGgGCoaLMoNJ
         Al78YSGHYrDmQ==
Received: by mail-oo1-f71.google.com with SMTP id t26-20020a4ad0ba000000b002de9567955cso2509337oor.5
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 06:04:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3OQ/VaDIuTDhMC1t1W5jGAk9lH9/vCwpiE19iLKBlBc=;
        b=eTtexXmj+qlXTicldiESd2tN7ZKGRp+KwzmbwvL6mkZoI/XKu7xors0e35Qy4jUA53
         U2J+jlD46PJGiqkc+kd25u5uVTi7hCbUh50kYTOvcqZoiA0ZPg0lGtUmsznZn3oaQ/7U
         pkke1K+dXRLJOO6o9FnuYbGOmW/E5RWYaSpL6C/zmmF7UGIhfI6LEGOmzWo3f7iOO8aW
         nnSz9YSAP6u1zNz6HUBBqfU4kq8RTEZMQ4AmfZcjRyg+EpkdJQJQTFEuAG8R/es+Rh/H
         E8+HEgMDmR+c193OQrxG/s7dQlPWxkLZmF06a6ar0FqpCQgPEI/WcKGOShkaF5JpuAgR
         x4zw==
X-Gm-Message-State: AOAM5328efKUw0yiatsLtYsFIoB8Pz169PmfKu0veGmcoffPfotXhdvV
        LMmacXOHo/hSuWgvn5d03BvQbwPhz6oOdy7N2CHIw1n/juBtSOprcNqIRruKAio80jJwtt80IZV
        cUzSUjN16dNrBZ2x4pcyzFWO9uPt3BjT2L+JcxQtWbHl4Ysr32yb/3oHg5g==
X-Received: by 2002:a9d:6f0e:: with SMTP id n14mr2822774otq.269.1642773861223;
        Fri, 21 Jan 2022 06:04:21 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyVtaGcho3igX1lqUTemDHDs4BAm+GxXC1OfPO/KgxOSm0eeAE8Nd5NPl6H219ecy1ttNMMRO60EzgHiH7q1Tk=
X-Received: by 2002:a9d:6f0e:: with SMTP id n14mr2822645otq.269.1642773859362;
 Fri, 21 Jan 2022 06:04:19 -0800 (PST)
MIME-Version: 1.0
References: <20220120051929.1625791-1-kai.heng.feng@canonical.com>
 <Yelnzrrd0a4Bl5AL@lunn.ch> <CAAd53p45BbLy0T8AG5QTKhP00zMBsMHfm7i-bTmZmQWM5DpLnQ@mail.gmail.com>
 <Yeqve+KhJKbZJNCL@lunn.ch>
In-Reply-To: <Yeqve+KhJKbZJNCL@lunn.ch>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Fri, 21 Jan 2022 22:04:08 +0800
Message-ID: <CAAd53p7of_W26DfZwemZjBYNrkqtoY=NwHDG=6g9vvZfDn3Wwg@mail.gmail.com>
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

On Fri, Jan 21, 2022 at 9:05 PM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > > Since you talked about suspend/resume, does this machine support WoL?
> > > Is the BIOS configuring LED2 to be used as an interrupt when WoL is
> > > enabled in the BIOS? Do you need to save/restore that configuration
> > > over suspend/review? And prevent the driver from changing the
> > > configuration?
> >
> > This NIC on the machine doesn't support WoL.
>
> I'm surprised about that. Are you really sure?

Yes I am sure.

>
> What are you doing for resume? pressing the power button?

Power button, RTC. The system has another igb NIC, which supports WoL.

>
> > > > +static const struct dmi_system_id platform_flags[] = {
> > > > +     {
> > > > +             .matches = {
> > > > +                     DMI_MATCH(DMI_SYS_VENDOR, "Dell EMC"),
> > > > +                     DMI_MATCH(DMI_PRODUCT_NAME, "Edge Gateway 3200"),
> > > > +             },
> > > > +             .driver_data = (void *)PHY_USE_FIRMWARE_LED,
> > > > +     },
> > >
> > > This needs a big fat warning, that it will affect all LEDs for PHYs
> > > which linux is driving, on that machine. So PHYs on USB dongles, PHYs
> > > in SFPs, PHYs on plugin PCIe card etc.
> > >
> > > Have you talked with Dells Product Manager and do they understand the
> > > implications of this?
> >
> > Right, that's why the original approach is passing the flag from the MAC driver.
> > That approach can be more specific and doesn't touch unrelated PHYs.
>
> More specific, but still will go wrong at some point, A PCEe card
> using that MAC etc. And this is general infrastructure you are adding
> here, it can be used by any machine, any combination of MAC and PHY
> etc. So you need to clearly document its limits so others are not
> surprised.

The dwmac-intel device is an integrated end point connects directly to
the host bridge, so it won't be in a form of PCIe addin card.

Kai-Heng

>
>         Andrew
