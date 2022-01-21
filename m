Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 846434958BA
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 05:01:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233828AbiAUEBv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 23:01:51 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:53956
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231519AbiAUEBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 23:01:49 -0500
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 9E00F40024
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 04:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1642737708;
        bh=4kHu2XYyfVu0N83f5P1MXdyIklLz/98ljBKcgS3bWe0=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=GjAbwjm3ii/N00ZwuUPWi9l5nMz6N5Rlpyjv44cakQ2MMEl7WncqfgOf/f9edm4f+
         9vP+W16oBAkLrLNfzbXyhYV6qXCvgH4DA0vkOZE3KnnsI6Hl1yRdNuhz6C8yo6oJf7
         +xLPCPSe4Q+xeszHFAG2QAl+tL/1RoHkqcyZ6xc4os50Z6YTAmRK+j8xl7Ic67nojJ
         C14dUIS5WF22BLI23Bfiut4UDplPqnsDYUvr4Li21iCatESHkh9djclCtWHP1WpzRl
         2VoO4yurvXBoUtE8XMoUuxQBYMX+CD1XcilwjISBbnLJ/rwOT+COD2+qp18WjrcdLn
         0EPv+gvUbi8Ow==
Received: by mail-oi1-f200.google.com with SMTP id g4-20020acab604000000b002c8b24c3964so5145937oif.22
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 20:01:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4kHu2XYyfVu0N83f5P1MXdyIklLz/98ljBKcgS3bWe0=;
        b=3AsGwxhVvVfOg/K5C8jbfmDARVUEOOcjxhZUzosDweSO1+dy+anoxwPRSvj+HIoemB
         pX7nHE7wKmhGVra7UGaeCoqAwpO26g4hkeXTBVjLNK4ZoM7OODxGGDDyaNLKPbc/yv9K
         VHWvJK0cRAoHxDrZUgXDaCHSygb24wlMeChtA1uxQW/2wziT75nB145TsdAi3rjWwsVK
         2rwssCJgAXXj0DZayEEfOxc/ACb7Mh2SKTy/ktj4+R86fZeqiw+1awvOl0ssxm+uCRy4
         y8zwYrsg6EUIzDnBNt2gBX1OekFNdaTXJbrs/1m3oMpedzyDWWwOUmUx4lgtv/2NO64L
         N/bQ==
X-Gm-Message-State: AOAM530dNs1tedK8AR6VKqxooJdDLB8ptdcS+5WGyOxQ4vnDQBSMgJ67
        h5PfHQAPDhmYU62IBIR1OmyPrFJ5g9V4shc7+uM6og1rFu5WsupHgSswwp8votp5o+PqSmbl/EB
        Dv5jy6JhZ1hpwgddzT1RxWF3fPGLYEITGuRMTspzx7wvf6y0OlW2n6CH4uQ==
X-Received: by 2002:a9d:480e:: with SMTP id c14mr1511907otf.233.1642737706834;
        Thu, 20 Jan 2022 20:01:46 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyseZj+ek4BeoHOtF//WkmuO66+iqWcXsWmB3o/kKx7ClQ5FpOwebYv2dscfj0+zK6N02U3WyJjFIqj5xm+ybY=
X-Received: by 2002:a9d:480e:: with SMTP id c14mr1511895otf.233.1642737706604;
 Thu, 20 Jan 2022 20:01:46 -0800 (PST)
MIME-Version: 1.0
References: <20220120051929.1625791-1-kai.heng.feng@canonical.com> <YelxMFOiqnfIVmyy@lunn.ch>
In-Reply-To: <YelxMFOiqnfIVmyy@lunn.ch>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Fri, 21 Jan 2022 12:01:35 +0800
Message-ID: <CAAd53p7NjvzsBs2aWTP-3GMjoyefMmLB3ou+7fDcrNVfKwALHw@mail.gmail.com>
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

On Thu, Jan 20, 2022 at 10:26 PM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Thu, Jan 20, 2022 at 01:19:29PM +0800, Kai-Heng Feng wrote:
> > BIOS on Dell Edge Gateway 3200 already makes its own phy LED setting, so
> > instead of setting another value, keep it untouched and restore the saved
> > value on system resume.
> >
> > Introduce config_led() callback in phy_driver() to make the implemtation
> > generic.
>
> I'm also wondering if we need to take a step back here and get the
> ACPI guys involved. I don't know much about ACPI, but shouldn't it
> provide a control method to configure the PHYs LEDs?
>
> We already have the basics for defining a PHY in ACPI. See:
>
> https://www.kernel.org/doc/html/latest/firmware-guide/acpi/dsd/phy.html

These properties seem to come from device-tree.

>
> so you could extend this to include a method to configure the LEDs for
> a specific PHY.

How to add new properties? Is it required to add new properties to
both DT and ACPI?
Looks like many drivers use _DSD freely, but those properties are not
defined in ACPI spec...

Kai-Heng

>
>   Andrew
