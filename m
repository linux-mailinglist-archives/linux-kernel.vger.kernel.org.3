Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA4E2478607
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 09:13:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233450AbhLQINP convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 17 Dec 2021 03:13:15 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:48427 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233366AbhLQINO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 03:13:14 -0500
Received: from mail-wm1-f48.google.com ([209.85.128.48]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MKKdD-1nDC0U1SG7-00LoN8; Fri, 17 Dec 2021 09:13:13 +0100
Received: by mail-wm1-f48.google.com with SMTP id a83-20020a1c9856000000b00344731e044bso1068442wme.1;
        Fri, 17 Dec 2021 00:13:13 -0800 (PST)
X-Gm-Message-State: AOAM530yv2wc7/t0oA2JE4+dReJCpeCYIRQY1dDQd5OMAJBcL4jXnIN3
        ubejnx0Uhf2i4vMw+vp1/cpw4EVlaRkR0NK4d9U=
X-Google-Smtp-Source: ABdhPJyggF+SZFik5LBFQ4ssWD/gg+584v/f/uX0O18oUqIIJZenFT8dqWLwYMQ6qsjUbkDrg/Yvbjz9eIEFVqN8Qh4=
X-Received: by 2002:a7b:c448:: with SMTP id l8mr8354989wmi.173.1639728792948;
 Fri, 17 Dec 2021 00:13:12 -0800 (PST)
MIME-Version: 1.0
References: <cover.1639557112.git.tonyhuang.sunplus@gmail.com>
 <c3a3b64c38807b2f344c3df500eb4c60b885eadf.1639557112.git.tonyhuang.sunplus@gmail.com>
 <CAK8P3a0CnCK-Dfodp-jTzZApM_1NpdY7DV2fRqnO=gaju5xGwg@mail.gmail.com>
 <CAHpW4oQmtd-gG1HYZT-Dk=QAvXKsKebzcOaVtrEeoujwoL9zSg@mail.gmail.com> <316c16afbff74160b07bd74444f3b8e1@sphcmbx02.sunplus.com.tw>
In-Reply-To: <316c16afbff74160b07bd74444f3b8e1@sphcmbx02.sunplus.com.tw>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 17 Dec 2021 09:12:57 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0cA7iL=ug6hiqWAV1-qFSoCN-R7jrXv0cqByUDJV4x0Q@mail.gmail.com>
Message-ID: <CAK8P3a0cA7iL=ug6hiqWAV1-qFSoCN-R7jrXv0cqByUDJV4x0Q@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] misc: Add iop driver for Sunplus SP7021
To:     =?UTF-8?B?VG9ueSBIdWFuZyDpu4Pmh7fljpo=?= <tony.huang@sunplus.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>,
        gregkh <gregkh@linuxfoundation.org>,
        =?UTF-8?B?V2VsbHMgTHUg5ZGC6Iqz6aiw?= <wells.lu@sunplus.com>,
        =?UTF-8?B?6buD5oe35Y6a?= <tonyhuang.sunplus@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:cFpsGEMbS/vHLxVLxPO0RZmqW2Nfms366JcgZRRtWYHTS9SQj2m
 2Y+M7pVvyAG+1uJWLvy5BM2JomGGOp0NEFfHNTw4Lwp28XXu9ZQizACo3q0gnSST/NwzvNe
 oSPcttuKLA6U+CL5ZMdCUBj9fTdNQw3vKDOq3BN0GuEryeAc7cnYwh2Z0PBLr2Rp0nJ/QE8
 t9E5pz9gXnwVf8q2+vEjg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:1u/EtCvCa+g=:Gm2xc15psrh99D1fLoPuql
 aOBla+HlcVXeJ1+/eFf02gMYRCfwFO1pqGUYtvS2GjEw1b9lC31gIxXDS26Zh71YSH9ueSqo2
 1QwQ3WqRRMCHzPIghqFbJ89VwxlfufaBCenTeGYQZdu1quxJrztriF7qw6b1Yh/n5DMbxuYra
 jBNe0V1R29ZldZFhnRMLO8ugJ7Byr4CaSd7cGtQcI5n+PU1SsOG/4RhfzI3+ixwge3eD88wkU
 IxwTNsVv5uOROItL3jHwwv03jY6X9QV2e9zRWLcBZOxOw3rwDjUjfnPj+p4X7l2qHELV/nWkT
 IDvfBvUovTXtSLnKMnQJb557q7lKGKWiUuoUi208isxDm554aMAOFqfHdF8vVohQyi7rgR91+
 K8Gy6x7udBb40aO/YdNWrW+oSRPX2ieDqbh/M9vpePS0VkeAE/tLhKr3J+Kf6zzBPvDJq/bY5
 ad27d4xr9F74yGty1cu8RkXC2T3433Yn69Zoq4OSEA2kYGiM4yB0QXZnicyIDwn/0dVYHWplM
 nscJaMSYuf31eGkJ+3sF4103M/VHHaudLWRRDvCFPRCQldQURnN2MMP4f7ORGEvILpPeo4ZH0
 wtPSRElnzN0inPmR6u/izHEEmmkxjCtzQMmwby+2AF+5RLC7igPq6ThG/fVcrlx/3K3ar6Tjm
 ZcD2Ftjdok+JsyaDiP6ao0Ab5M417uENr/B6gDIMmmIxKtGkX+yZSocaLFK2B3EZ3Hu1B+yFk
 H/kq5oZMgBMrYfZ37KpP1wCqLoWhghMCt0JUUxlLFfixued3/Z3eT7LneuJYAmIrWl8DdpAPB
 bOhXiA8xtBSwRKWbn5Pd7yewA/mIafKyuYQ89fseAo4cX6OSCw=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 17, 2021 at 3:44 AM Tony Huang 黃懷厚 <tony.huang@sunplus.com> wrote:
>
> Dear Arnd:
>
>
>
> On Thu, Dec 16, 2021 at 2:38 AM Tony Huang <tonyhuang.sunplus@gmail.com> wrote:
> >>
> >> IOP (IO Processor) embedded inside SP7021 which is used as
> >> Processor for I/O control, RTC wake-up and cooperation with
> >> CPU & PMC in power management purpose.
> >> The IOP core is DQ8051, so also named IOP8051,
> >> it supports dedicated JTAG debug pins which share with SP7021.
> >> In standby mode operation, the power spec reach 400uA.
> >>
> >> Signed-off-by: Tony Huang <tonyhuang.sunplus@gmail.com>
> >> ---
> >> Changes in v4:
> >>  - Addressed comments from Arnd Bergmann.
>
> >I don't think you did: I asked you specifically to add code to interact with
> >the existing in-kernel interfaces to use the functionality provided by the
> >device. Pick any (at least two) subsystems and add support, but leave
> >out any custom user space interfaces (miscdevice, debugfs, sysfs, ...)
> >for the moment.
>
>
>
> 1. IOP can run sp_iop_platform_driver_shudown() through the poweroff command
> and the kernel. Perform system power-off actions.

Do you mean that this method a) cleanly shuts down the iop before the
system is powered down, or b) the driver_shutdown() callback is used to
initiate the powerdown of the system itself?

In case of a) I would not count that as exposing functionality, what you do here
is just part of any driver. If instead you are trying to use b), this
is the wrong
way of doing it, see drivers/power/reset/ for examples of how to do it right.

> 2. Wake up the system by relying on the 8051 internal RTC wake-up mechanism
> and external GPIO input signals to wake up.

I think those should be exposed with drivers/rtc for the RTC and drivers/gpio/
for the GPIO driver, and then you can use the device tree to configure which
GPIO to use as a wakeup and how it's connected to the RTC.

> 3.So you ask me to control IOP(8051) through file_operations, not through DEVICE_ATTR

No, neither of them. Use the appropriate drivers/*/ subsystems for any
functionality that has an existing subsystem. If there is something that the iop
does that does not yet have a subsystem, that requires a more thorough design
discussion for creating a new user interface, ideally in a hardware-independent
way. You should not start with that until all the normal features (rtc, wakeup,
suspend, gpio, ...) are supported.

       Arnd
