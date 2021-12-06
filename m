Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 140E2469049
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 07:00:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237567AbhLFGED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 01:04:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbhLFGEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 01:04:02 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 154DFC061354
        for <linux-kernel@vger.kernel.org>; Sun,  5 Dec 2021 22:00:34 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id l22so22645123lfg.7
        for <linux-kernel@vger.kernel.org>; Sun, 05 Dec 2021 22:00:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=X+l2JmyM/i+d2RSQ/zp3tUVK1rYseki7sagC2lFSmkA=;
        b=mzeNzPimwjogbyuO3VC8+pQb8p5vB/osgaP9wh2sA3/OLmFZNxTPVi3XIe70NCKIcb
         Gy32d2qT6gR4SqIm5rP6UCTLo8rEj34up2oSLZt5NV1d3OwG+9OenhO90kTM2AFscgil
         B3zmxdGBSLTchMA+PoYyKj4ajvgQ+0SgBMIRMsverubJPZ/zCgsZAZNKw8v3tRbjZe3L
         PlEvTanZDaUbXgRXMuFzFfiVGAwEpYBxsZCFqttnMhlzQ2oGsjKN7ZikHpy9wxCqGh1O
         DGR8o9tvct5W4xxw4kWO6XOl3ueihtIoagsEOdVBUb2EEjJbUPOhPS2FucY17aXTkPJg
         krZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=X+l2JmyM/i+d2RSQ/zp3tUVK1rYseki7sagC2lFSmkA=;
        b=CVlF30BO7WuxNqlhXxkigwZ97qXwG1jUqAN67UELEo3ggkjnzMi+B6bdYCn7CVBPzf
         p4jDNo41K6SHWNfIhZCylitAghNctTmRpDcZ+Dvimgv7r4CR+lUhndQoyOgNMMq/IOEe
         miNrPV+esbCiG+kaZPm1lMvPikGN99/BquKn0vIV66NF+xT+Ff5/WJMdJEfDd7Et3wIH
         DhBUNbSBNbgHjp02gsq2IM18wApot5fs0qmas+Y4KGtNzJaA48WMSWYZy2mZCOT3nO/s
         /YAdiJN2FJQcqtDLsn6Gr6geACWgTiYbcnvfMCv3pm0iRDeieK3fSJX7RkiD5cbdHx9k
         9P2w==
X-Gm-Message-State: AOAM533YzY6jhONqHEUgfyWKF3KyjsDrIAfRFJHOExmSy+mzKtaD41wf
        MD83/bWbYFB448ortvtTAQjBLrBTw3G8AgY8lWg=
X-Google-Smtp-Source: ABdhPJy7GtWV5tJ9a/icXjZGJ3GMF+7hZ5zBMyC07/aaNiA7RP/93FCbbMwwyWw6toDL1X/GAFCPaTIrUGMXzyl95rk=
X-Received: by 2002:ac2:4e0b:: with SMTP id e11mr32623178lfr.208.1638770432374;
 Sun, 05 Dec 2021 22:00:32 -0800 (PST)
MIME-Version: 1.0
References: <CAHhAz+jpmksehY4BSH9jJPYuY+jykSHtx9TNiG-gAkq10zaXSQ@mail.gmail.com>
 <fe9dbf81-e060-36ab-b769-215af3d65ba7@linaro.org>
In-Reply-To: <fe9dbf81-e060-36ab-b769-215af3d65ba7@linaro.org>
From:   Muni Sekhar <munisekharrms@gmail.com>
Date:   Mon, 6 Dec 2021 11:30:21 +0530
Message-ID: <CAHhAz+iEQTtfxXB8sNEL4WxFjUZo5LYTo4EVyH0mT2=NH3VaUA@mail.gmail.com>
Subject: Re: Time: new clocksource
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     tglx@linutronix.de, LKML <linux-kernel@vger.kernel.org>,
        kernelnewbies <kernelnewbies@kernelnewbies.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 4, 2021 at 3:18 AM Daniel Lezcano <daniel.lezcano@linaro.org> w=
rote:
>
> Hi Sekhar,
>
> On 03/12/2021 17:50, Muni Sekhar wrote:
> > Hi All,
> >
> > We have a Digital PLL with 64 bit timer counter hardware and the
> > counter is accessible from the CPU over the PCIe bus.
> >
> > Is it possible to add this timer counter hardware as new clocksource
> > driver? To do this, can someone please point me to the existing
> > reference source code(or patch) for this task.
>
> You can refer to the drivers located in drivers/clocksource
I don't see the option in menuconfig to build the clocksource driver
as a loadable kernel module, for example CONFIG_X86_PM_TIMER=3Dm instead
of CONFIG_X86_PM_TIMER=3Dy.
So a clocksource driver should always be part of the kernel built-in
module? If so, what's the reason for that?

>
> git annotate on one of the driver can give you the initial commit where
> recent submissions explain the timer internals.
>
> > Suppose if it is possible to add a new clocksource driver for this
> > hardware then does any userspace get_timestamp* API would get the time
> > from this new hardware?
>
> It should if the timer is selected as the clocksource
>
>
> --
> <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for AR=
M SoCs
>
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog



--=20
Thanks,
Sekhar
