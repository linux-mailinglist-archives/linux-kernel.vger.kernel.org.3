Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4685C472F81
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 15:38:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239555AbhLMOip (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 09:38:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236562AbhLMOio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 09:38:44 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40A1FC061574;
        Mon, 13 Dec 2021 06:38:44 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id e3so53546120edu.4;
        Mon, 13 Dec 2021 06:38:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7ulTlAyJ+0gig0bYh3fs1Ip8F1fzXQZyuJZ/YPuguLw=;
        b=lZ8YFoDSfFuucQF7zOHh3zMptJIw1KjPSftSZcDYAiIb20YPH06ynxHrfsRqNcK2SX
         xIxD/HVhWg7DvdDYF4KBHzAYcVl0eRc5Jr18pwwWwb6HZgs2PRQsyU+2hYuc+IzIP93S
         4DGRVLMZGm0OcdZss0p8RoaPAH8xI8EDk0Pd3dwC7hGfn8Q2o6INApoCsXBzI6sJVsYz
         tI59ABfcazAPVnIgOQKiTfA5OP1Tz7aXXUNOgmeZo5CKJnwr7Ln0ubOrTRbW2Lj4JH8N
         Vpwu8kyHc4RsEVr456l16o9i/LLmn2W4ICRoJaEFOpuQRLdvs1+KMdLh2VRdQG0A/Cl7
         Fj7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7ulTlAyJ+0gig0bYh3fs1Ip8F1fzXQZyuJZ/YPuguLw=;
        b=8KU4V1GM3xX+gZAUtWge1Osf4VjifYPWzFet/6DSNGinv8FVPol9R5X6b5ZY459SLf
         mDUerE5TBKTDqZJmG3PkM5U25GcxZkSWIEFlhvZ01s+6yDHpotedgh0m/Xzl0vD5keCa
         qA7jqe1uH6Z2V3AR/x4yla5+Vdz04XRFXleWV1NgmSzI7K3DP0h+cQrsIEaC1H7HKN2S
         /oXejc5SuweOMl5O8Wn+llWvSPZcSsiJ8sS2oHH08WFh2wc3jig3K0sWcfPzjqhbER/K
         Vbm+qQKQB8J9uF1DibCMbSBdrss4JJUgUmHZeviM2+tGJQd30lV4nvMJvaOUDo1xFKKY
         d3WA==
X-Gm-Message-State: AOAM5328K2fIYXE8XKouzZbP0Q9Vp1FxptWtRYTFo+NSvOHlWfqRobdI
        p27f0YtWbphEEGYjWvEvvAu2zJZcHZtUBPAlybE=
X-Google-Smtp-Source: ABdhPJwt9cyLzqilStUsTt23zQ2vaSHvanEm+TGpw5mM5fiEHzOL49uhChxpFJdpiVl4nyq/Swz6KvFChOKbUqa86Zo=
X-Received: by 2002:a05:6402:84f:: with SMTP id b15mr59579780edz.342.1639406322763;
 Mon, 13 Dec 2021 06:38:42 -0800 (PST)
MIME-Version: 1.0
References: <20211213120502.20661-1-henning.schild@siemens.com> <20211213132113.09104069@md1za8fc.ad001.siemens.net>
In-Reply-To: <20211213132113.09104069@md1za8fc.ad001.siemens.net>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 13 Dec 2021 16:37:11 +0200
Message-ID: <CAHp75VfHcQup26Z0h5v=Z7tkBRo0VhyTZBsyztxX5hx-LV55Ng@mail.gmail.com>
Subject: Re: [PATCH v5 0/4] add device drivers for Siemens Industrial PCs
To:     Henning Schild <henning.schild@siemens.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        linux-watchdog@vger.kernel.org,
        Srikanth Krishnakar <skrishnakar@gmail.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Gerd Haeussler <gerd.haeussler.ext@siemens.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Mark Gross <mgross@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Pavel Machek <pavel@ucw.cz>, Enrico Weigelt <lkml@metux.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2021 at 2:21 PM Henning Schild
<henning.schild@siemens.com> wrote:
>
> This is now the outcome of the phone call i had with Andy concerning
> the use of pinctrl. I could lay out why it is not "that easy" and why
> we do access GPIO memory not in a "general purpose" way.
>
> Yes we have thousands of devices out there with missing ACPI entries
> so pinctrl does not come up. But our firmware guys will not add them,
> because they strictly only address security fixes and not functional
> changes. (stable ...)
> Adding new ACPI entries could have unforeseeable side-effects on
> devices already at the end-user, where many (also proprietary low-level
> SW components (OS/hypervisor)) could be in use.
>
> I hope in coming generations we will not forget such entries again, in
> fact it is not even clear who forgot to put them in. Might even have
> been Intel to begin with.

Yep and on top of that we agreed that whenever the better solution
comes out (meaning P2SB generic way of handling whichever it will be),
Siemens would help in testing and will move their driver forward to
support that solution. With all that said,

Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Am Mon, 13 Dec 2021 13:04:58 +0100
> schrieb Henning Schild <henning.schild@siemens.com>:
>
> > changes since v4:
> > - make everything around GPIO memory usage more verbose
> >   - commit messages, FIXME in p1, cover-letter
> >
> > changes since v3:
> >
> > - fix io access width and region reservations
> > - fix style in p1
> >
> > changes since v2:
> >
> > - remove "simatic-ipc" prefix from LED names
> > - fix style issues found in v2, mainly LED driver
> > - fix OEM specific dmi code, and remove magic numbers
> > - more "simatic_ipc" name prefixing
> > - improved pmc quirk code using callbacks
> >
> > changes since v1:
> >
> > - fixed lots of style issues found in v1
> >   - (debug) printing
> >   - header ordering
> > - fixed license issues GPLv2 and SPDX in all files
> > - module_platform_driver instead of __init __exit
> > - wdt simplifications cleanup
> > - lots of fixes in wdt driver, all that was found in v1
> > - fixed dmi length in dmi helper
> > - changed LED names to allowed ones
> > - move led driver to simple/
> > - switched pmc_atom to dmi callback with global variable
> >
> >
> > This series adds support for watchdogs and leds of several x86 devices
> > from Siemens.
> >
> > It is structured with a platform driver that mainly does
> > identification of the machines. It might trigger loading of the
> > actual device drivers by attaching devices to the platform bus.
> >
> > The identification is vendor specific, parsing a special binary DMI
> > entry. The implementation of that platform identification is applied
> > on pmc_atom clock quirks in the final patch.
> >
> > It is all structured in a way that we can easily add more devices and
> > more platform drivers later. Internally we have some more code for
> > hardware monitoring, more leds, watchdogs etc. This will follow some
> > day.
> >
> > The LED as well as the watchdog drivers access GPIO memory directly.
> > Using pinctrl is not possible because the machines lack ACPI entries
> > for the pinctrl drivers. Updates to the ACPI tables are not expected.
> > So we can rule out a conflict where two drivers would try and access
> > that GPIO memory.
> > So we do not use those pins as "general purpose" but as "Siemens
> > purpose", after having identified the devices very clearly.
> >
> > Henning Schild (4):
> >   platform/x86: simatic-ipc: add main driver for Siemens devices
> >   leds: simatic-ipc-leds: add new driver for Siemens Industial PCs
> >   watchdog: simatic-ipc-wdt: add new driver for Siemens Industrial PCs
> >   platform/x86: pmc_atom: improve critclk_systems matching for Siemens
> >     PCs
> >
> >  drivers/leds/Kconfig                          |   3 +
> >  drivers/leds/Makefile                         |   3 +
> >  drivers/leds/simple/Kconfig                   |  11 +
> >  drivers/leds/simple/Makefile                  |   2 +
> >  drivers/leds/simple/simatic-ipc-leds.c        | 202 ++++++++++++++++
> >  drivers/platform/x86/Kconfig                  |  12 +
> >  drivers/platform/x86/Makefile                 |   3 +
> >  drivers/platform/x86/pmc_atom.c               |  54 +++--
> >  drivers/platform/x86/simatic-ipc.c            | 176 ++++++++++++++
> >  drivers/watchdog/Kconfig                      |  11 +
> >  drivers/watchdog/Makefile                     |   1 +
> >  drivers/watchdog/simatic-ipc-wdt.c            | 228
> > ++++++++++++++++++ .../platform_data/x86/simatic-ipc-base.h      |
> > 29 +++ include/linux/platform_data/x86/simatic-ipc.h |  72 ++++++
> >  14 files changed, 786 insertions(+), 21 deletions(-)
> >  create mode 100644 drivers/leds/simple/Kconfig
> >  create mode 100644 drivers/leds/simple/Makefile
> >  create mode 100644 drivers/leds/simple/simatic-ipc-leds.c
> >  create mode 100644 drivers/platform/x86/simatic-ipc.c
> >  create mode 100644 drivers/watchdog/simatic-ipc-wdt.c
> >  create mode 100644 include/linux/platform_data/x86/simatic-ipc-base.h
> >  create mode 100644 include/linux/platform_data/x86/simatic-ipc.h
> >
>


-- 
With Best Regards,
Andy Shevchenko
