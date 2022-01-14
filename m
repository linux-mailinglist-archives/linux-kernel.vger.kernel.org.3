Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7557548E7CB
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 10:47:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240104AbiANJqp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 04:46:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbiANJqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 04:46:43 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82164C061574;
        Fri, 14 Jan 2022 01:46:42 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id w16so32887652edc.11;
        Fri, 14 Jan 2022 01:46:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=CJJp16XvB61zfc0mom+YXoBX1NkRJX5jIJ0wUN6p1U0=;
        b=DhWFS7DBWVC9oy5m12HFDmTQeONzXzS+zL/UkUxZalJkNH/8NTPPTSNlnU06nDAHt0
         znpDfJ29q87pyu4RjOtpr+kin+3J/4ntdU8d3+f2PBkIWuiNZ/5hpjSwvGRLeUnN+5wk
         4cMvbeU2a9wWayuIjx06Ujbv20e03VL4l1L7up31bxUikQy/+6Ebu6L6VmeR8dXYHgu8
         7ab61znWeEXnV4m0bdQV5RM1STerrRJC7AlVEDaVIhZdpnf3HdQmLXFg8MkTaWd068HA
         I68m62yvV81rt1lT3T0Hb/Uu/M0t3EUUpw2dvXZ8rQoZETrrnXie67It6Ppv9eclH4OG
         bTjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CJJp16XvB61zfc0mom+YXoBX1NkRJX5jIJ0wUN6p1U0=;
        b=pBbemh4XDePsPWkESc6KzuClvfRQGfNAAuxaBV6WndlVH0/1SHAaIFLAeKETEjV4C7
         NfxdRNqqAJryHC+sWrvu60/pz+6pP8ubkebX4yK3rh+jkwzG/uCC2fSFDD+za+hbYjlU
         NZa79RxjewyGwhXFqlMOu9BRLVphl3oiW8cLRP07QBvKASzTSqr4fb2VXU9KyVNPeDDM
         4NG6N05cE3/eePWfJkgppVd3pNXVPIUW7BMa2ptxpRS1nRXssyn8IPFmIGU+RuLTpjg6
         /zuvvi+6Ttc4Whekb/v92ze5LV+/QENeL0YCAEQcanAVKjXtT5AyImOvRGhvL65OVRUN
         rVOQ==
X-Gm-Message-State: AOAM5336l1kLB/4tdHmx/eJIY23K/9a8U9zwCxb0Rz/jE1Wfmid4KASA
        BWKfL4Icym8XoXIcuQDIKQJ1G2UYX+gL4wWMU3FzQKhOPEeBvw==
X-Google-Smtp-Source: ABdhPJytF5xROs6L3+siWxigPjNg2rtNknZ0aH9Q1UXnb4ama7jR03TaPtwF3/UCEXq4+xOHXhGxPAf/B+C7h5R+6mE=
X-Received: by 2002:a17:906:3ed0:: with SMTP id d16mr6659456ejj.636.1642153601100;
 Fri, 14 Jan 2022 01:46:41 -0800 (PST)
MIME-Version: 1.0
References: <1640331779-18277-1-git-send-email-wellslutw@gmail.com>
 <1640331779-18277-3-git-send-email-wellslutw@gmail.com> <CAHp75Vd3iMM+NteJXP_mMAyw5momk3xzp1Y2GX-YJZfFSAwo9A@mail.gmail.com>
 <f87b21407ed44630a86b2661deab4a58@sphcmbx02.sunplus.com.tw>
 <CAHp75VcPB_K6RD8tnMarwGCeaOKcQ_knxvKEW9WNn_4ce41szw@mail.gmail.com>
 <cf53f5dc57e342078ec14a771ba639ca@sphcmbx02.sunplus.com.tw>
 <CAHp75Vf0=Sf8sGtgCo7bMjVFGYDcJOasLqdSHTnQ0YPgSbrr2g@mail.gmail.com> <9e15ccc8ee844f1eab320001bc8bc235@sphcmbx02.sunplus.com.tw>
In-Reply-To: <9e15ccc8ee844f1eab320001bc8bc235@sphcmbx02.sunplus.com.tw>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 14 Jan 2022 11:46:04 +0200
Message-ID: <CAHp75VfxtGue7bbMm_MU2GWwWo4aZLW2Pj_U9ocCQmWr6wfGMw@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] pinctrl: Add driver for Sunplus SP7021
To:     =?UTF-8?B?V2VsbHMgTHUg5ZGC6Iqz6aiw?= <wells.lu@sunplus.com>
Cc:     Wells Lu <wellslutw@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "dvorkin@tibbo.com" <dvorkin@tibbo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 14, 2022 at 4:51 AM Wells Lu =E5=91=82=E8=8A=B3=E9=A8=B0 <wells=
.lu@sunplus.com> wrote:

...

> > > > > > > +       bool "Sunplus SP7021 PinMux and GPIO driver"
> > > > > >
> > > > > > Why bool and not tristate?
> > > > >
> > > > > Pinctrl driver is selected by many drivers in SP7021 platform.
> > > > > We never build it as a module, but build-in to kernel.
> > > > > So we use "bool".
> > > > >
> > > > > Should we set it to tristate?
> > > >
> > > > You still haven't answered "why", so I can't tell you.
> > >
> > > I am puzzled because I think I have answered "why".
> >
> > Nope. :-)
> >
> > > Because Pinctrl driver is necessary for all SP7021-based platforms.
> >
> > "Why?" Why is it necessary (to be built-in)?
>
> Pinctrl is necessary to be built-in because drivers of boot-device,
> like eMMC, SD card, NAND flash, and NOR flash drivers, need it.
>
> SP7021 supports booting from eMMC, SD card, NAND flash and NOR flash
> devices. Their drivers need Pinctrl driver probes in advance.

On x86 platforms, for example, booting from eMMC and SD card does not
require a pin control driver to be built-in. Why is this requirement
for SP platforms?

--=20
With Best Regards,
Andy Shevchenko
