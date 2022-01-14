Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12AED48E904
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 12:17:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236393AbiANLRW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 06:17:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbiANLRV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 06:17:21 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20086C061574;
        Fri, 14 Jan 2022 03:17:21 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id o6so33773631edc.4;
        Fri, 14 Jan 2022 03:17:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=45IsoyUFs05UjmT6vES5f8wHj27//gmuBJIoFOvqsrg=;
        b=EyZyFIE3jqFT7NgA8yE+G0QtldmIR7voX/RG7OScka0V8joYtLLnXZJ962QHfXo7Ek
         Og8EOdSOYBunD1Nk4/LQ0kWfxsSRNKutMfzvhnt0Whd0h4ItBc7UOzpBuyaput+1VzIP
         ysyMZK5ZN2Eltko/BUnrygeVUk5+D0W2pQo0XCHnGQH3i/hzZGlKZxeVQnP+tp1iY/bX
         HBCaTa/OgOPk2UV8qifaWz8/5niDGI5ojkpguHju5CAeoqv4TmK2/weV2K/giFGUshQC
         q2CxsoMc/F7eQGrMZRxUJ4H+kR4GOXGcf70EzLTNHSIw7w+L7OoruwD82DSfYJBRSidA
         AxGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=45IsoyUFs05UjmT6vES5f8wHj27//gmuBJIoFOvqsrg=;
        b=XexVH73UqCAUbVzVkCgTuKn5iCZoV5sk+FTvwMQGjuilvKPAnDdlOPzGOvdXtne8Zc
         QCW/s/AZ+HWoYA9qa3JFh09B13P+AZEeB2ZtgIZzgVJbI3Xg+ikamzAT/BW9R4/ppPlW
         uOFA+42gAnSmlCyVBGTvYPafYz/I+4zFdzvjLWg1LDncwtgv+MqgjKh9hGQ9hGW/0q8q
         pbi0TduiKVc/lLb3uWo/aG82DIm/M87PukdyYgLDddbERELcBfuCfM4TzAq27AUGVyvy
         9ctYsLKCU5HdHHWMvJcsnuECYTDNjNbUz8crjWm3b2U79Vygqe4XJlqdRJzBcYLL6Udv
         npUQ==
X-Gm-Message-State: AOAM533U47JZiGFa3d7JLPM/4V8B/nOcs4UgzZzQUo1OPxb9kFzDlO1j
        1B/pW5vx/tiLWRpsjqyE5+4SRbEHup4TlfzJHB0=
X-Google-Smtp-Source: ABdhPJy96Gr9ab5YVTlCZnTNpf9s27u81X1qMWomspeqxnz7zPIsqkK9FKFyU5kF68PRfdJvGIymp8QFjmgsThi8s5Y=
X-Received: by 2002:a17:906:b24d:: with SMTP id ce13mr6843513ejb.44.1642159039557;
 Fri, 14 Jan 2022 03:17:19 -0800 (PST)
MIME-Version: 1.0
References: <1640331779-18277-1-git-send-email-wellslutw@gmail.com>
 <1640331779-18277-3-git-send-email-wellslutw@gmail.com> <CAHp75Vd3iMM+NteJXP_mMAyw5momk3xzp1Y2GX-YJZfFSAwo9A@mail.gmail.com>
 <f87b21407ed44630a86b2661deab4a58@sphcmbx02.sunplus.com.tw>
 <CAHp75VcPB_K6RD8tnMarwGCeaOKcQ_knxvKEW9WNn_4ce41szw@mail.gmail.com>
 <cf53f5dc57e342078ec14a771ba639ca@sphcmbx02.sunplus.com.tw>
 <CAHp75Vf0=Sf8sGtgCo7bMjVFGYDcJOasLqdSHTnQ0YPgSbrr2g@mail.gmail.com>
 <9e15ccc8ee844f1eab320001bc8bc235@sphcmbx02.sunplus.com.tw>
 <CAHp75VfxtGue7bbMm_MU2GWwWo4aZLW2Pj_U9ocCQmWr6wfGMw@mail.gmail.com> <b9c1876c9d0f48a3a8d7e091d47fc069@sphcmbx02.sunplus.com.tw>
In-Reply-To: <b9c1876c9d0f48a3a8d7e091d47fc069@sphcmbx02.sunplus.com.tw>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 14 Jan 2022 13:16:43 +0200
Message-ID: <CAHp75VdTm5T=VGgrqfp+3bLAu4chosirJ2uBeoA5MxvV+FMg_Q@mail.gmail.com>
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

On Fri, Jan 14, 2022 at 12:55 PM Wells Lu =E5=91=82=E8=8A=B3=E9=A8=B0 <well=
s.lu@sunplus.com> wrote:

...

> > > > > > > > > +       bool "Sunplus SP7021 PinMux and GPIO driver"
> > > > > > > >
> > > > > > > > Why bool and not tristate?
> > > > > > >
> > > > > > > Pinctrl driver is selected by many drivers in SP7021 platform=
.
> > > > > > > We never build it as a module, but build-in to kernel.
> > > > > > > So we use "bool".
> > > > > > >
> > > > > > > Should we set it to tristate?
> > > > > >
> > > > > > You still haven't answered "why", so I can't tell you.
> > > > >
> > > > > I am puzzled because I think I have answered "why".
> > > >
> > > > Nope. :-)
> > > >
> > > > > Because Pinctrl driver is necessary for all SP7021-based platform=
s.
> > > >
> > > > "Why?" Why is it necessary (to be built-in)?
> > >
> > > Pinctrl is necessary to be built-in because drivers of boot-device,
> > > like eMMC, SD card, NAND flash, and NOR flash drivers, need it.
> > >
> > > SP7021 supports booting from eMMC, SD card, NAND flash and NOR flash
> > > devices. Their drivers need Pinctrl driver probes in advance.
> >
> > On x86 platforms, for example, booting from eMMC and SD card does not r=
equire a pin
> > control driver to be built-in. Why is this requirement for SP platforms=
?

> Because all pins of boot-device multiplex with GPIO pins.
>
> SP7021 platforms support multi boot devices, including eMMC, SD card,
> SPI-NOR flash, SPI-NAND flash. Each boot device has control-bit(s)
> to enable it.
>
> For example #1, if control-bits of SPI-NOR flash is set 1,
> GPIO 83, 84, 86, 87 are connected to SPI-NOR flash.
> If control-bits of SPI-NOR flash is set 2,
> GPIO 76, 78, 79, 81 are connected to SPI-NOR flash.
> If control-bits of SPI-NOR flash is set 0, no pin is
> connected SPI-NOR flash.
>
> For example #2, if control-bits of eMMC device is set 1,
> GPIO 72, 73, 74, 75, 76, 77, 78, 79, 80, 81 are connected to
> eMMC device.
> If control-bits of eMMC device is set 0, no pin is connected
> eMMC device.
>
> For example #3, if control-bits of SDCard device is set 1,
> GPIO 65, 66, 67, 68, 69, 70 are connected to SD Card device.
> If control-bits of SDCard device is set 0, no pin is connected
> SDCard device.
>
> Note that all pins multiplex with GPIO pins.
>
> Normally, only a boot-device is enabled. All other GPIO pins
> are released for peripherals (controlled by fully-pinmux
> Or group pinmux) or IO processor

Thanks for this detailed picture of the HW configuration.

> Pinctrl driver is responsible for setup the pins.
> If Pinctrl fails to probe, boot-device also fails to probe.

But have you tried to compile it as a module and supply it in the initramfs=
?

What kernel does in this case it takes address of initramfs from
memory (I believe you have bootloader that capable to setup kernel,
initramfs, command line, and device
tree blob and pass the control to the kernel) at some point, mounts it
and probes the modules that are required to get your boot device
ready.

--=20
With Best Regards,
Andy Shevchenko
