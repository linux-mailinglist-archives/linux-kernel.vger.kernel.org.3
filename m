Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B30B496071
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 15:06:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350920AbiAUOGi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 09:06:38 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:45386
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350747AbiAUOGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 09:06:37 -0500
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 0C1E73FFD0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 14:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1642773996;
        bh=gsucdAdnAt+qawYVmHjSJKScVDH3+ziXYTq9TSgSLmM=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=PYAY3aK2mCn1IH/TnVYVVQTss3g5A+ZiZeFJXlevCpd1AnlgAmEIOpZq2N1AElOGC
         clhkgPiRxKszsAs5jVnvjWjOdY9IUb8EnDePU1bP+BBEBBbQ7kbrXX5tXMONAQWnSo
         1Tx6WUS0FtQcCdI70q3aSDTDfdt3FmUO3vIpaCrAhAHKIt/WngkkCN0hRooNGMk9eU
         CFAFk2nuelUDnBimLbrvaBbNIDMiCvymNDfAlk1odSNUHdJW/wZcNWPpuFq3KTG1Nx
         cQjsBQpWxe7DW7CsEYz94JBTI6sKWxA8K+wg8cG3aI27bxi1N0X7YTHSz23oiRsUPy
         I/j5Qd78DjBwQ==
Received: by mail-oi1-f198.google.com with SMTP id w195-20020acaadcc000000b002c8db42ff84so5730612oie.11
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 06:06:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gsucdAdnAt+qawYVmHjSJKScVDH3+ziXYTq9TSgSLmM=;
        b=qNc83kPc+FnXFEsT/+5HMMjjI1NAIOvb/A7RusNzr6wSQquej9ou1jhvYCtQ7Oog3I
         5sVab1kL7hj0kxsUktVVHJTHTTpPzQi2TTagRR/N9C/+1fOcXgaAn7sMF9AQnJKKOU0U
         YFgAAoBD+J24IeT93ci073rDApLOtf9dfbQn3XM6CFPDEH0GlKt5Cb0dy5FMl3bFfMIB
         2rgO6qpdRBzV6TRyFqFu9p0y7sX/cykXXkQrd/LF22hIqnrQqNVQmJSlYtxz9AS0aKuB
         clhMMdWohyIagbGtC7K8zSaXDQkAdohul2KF3l2xvM5WO80I4DxeF4R71S5FJO3+ktuQ
         Nwfw==
X-Gm-Message-State: AOAM533NrKoWfTojgT5/IOJBMRB7fTI/4pBnMHrDqvbU0mhV6vtsO84D
        +dWe9hyRajIJqBQMzTAAIs/rtgBQrrbvKEI9dFyM++vSOVrbs5kPr/bKAywffdl4J5nV22BnBUK
        YCjSVrGlfUZrSRb/B2+5DmTefcV6ikqG0OPalMjaAFYCwNutuFJqg4okopg==
X-Received: by 2002:a9d:6f0e:: with SMTP id n14mr2830874otq.269.1642773994841;
        Fri, 21 Jan 2022 06:06:34 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwLe0uxL6DXDEfmDU3PioZe0YlmQrLFaefnz3Q3nSyxYua4m/q2j6GAlzunza6qJecQbF/lsG/IDcxqHEKkJHg=
X-Received: by 2002:a9d:6f0e:: with SMTP id n14mr2830853otq.269.1642773994615;
 Fri, 21 Jan 2022 06:06:34 -0800 (PST)
MIME-Version: 1.0
References: <20220120051929.1625791-1-kai.heng.feng@canonical.com>
 <Yelnzrrd0a4Bl5AL@lunn.ch> <CAAd53p45BbLy0T8AG5QTKhP00zMBsMHfm7i-bTmZmQWM5DpLnQ@mail.gmail.com>
 <YeqwyeVvFQoH+9Uu@lunn.ch>
In-Reply-To: <YeqwyeVvFQoH+9Uu@lunn.ch>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Fri, 21 Jan 2022 22:06:23 +0800
Message-ID: <CAAd53p6C5SsYwKt4xsJ+qiqhrF45UW_VG8O+EiJcgeWy=MqzPw@mail.gmail.com>
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

On Fri, Jan 21, 2022 at 9:10 PM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > > > -static void marvell_config_led(struct phy_device *phydev)
> > > > +static int marvell_find_led_config(struct phy_device *phydev)
> > > >  {
> > > > -     u16 def_config;
> > > > -     int err;
> > > > +     int def_config;
> > > > +
> > > > +     if (phydev->dev_flags & PHY_USE_FIRMWARE_LED) {
> > > > +             def_config = phy_read_paged(phydev, MII_MARVELL_LED_PAGE, MII_PHY_LED_CTRL);
> > > > +             return def_config < 0 ? -1 : def_config;
> > >
> > > What about the other two registers which configure the LEDs?
> >
> > Do you mean the other two LEDs? They are not used on this machine.
>
> Have you read the datasheet for the PHY? It has three registers for
> configuring the LEDs. There is one register which controls the blink
> mode, a register which controls polarity, and a third register which
> controls how long each blink lasts, and interrupts. If you are going
> to save the configuration over suspend/resume you probably need to
> save all three.

OK, will change it in next iteration.

>
> This last register is also important for WoL, which is why i asked
> about it.

The Marvell PHY on the system doesn't support WoL.

Kai-Heng

>
>       Andrew
