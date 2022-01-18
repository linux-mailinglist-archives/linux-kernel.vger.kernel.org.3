Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0753449304B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 23:05:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237654AbiARWE6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 17:04:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233791AbiARWE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 17:04:57 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF8DEC061574
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 14:04:56 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id ay14-20020a05600c1e0e00b0034d7bef1b5dso2676185wmb.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 14:04:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dA1mI+zf6fWnHViA8ku/8QUjpA5uE9l+7rlJGihFL9c=;
        b=R4qovofJLw2tMurrpNf/rITMGnDKsHQMfq3k5NjK3DOaXiJVG1Unbp2FXRtrCQ6tkn
         qCDP4xY4f4sM+KcTl3MQB50hkfuNE+8jE/BrIydIz4+vE3Bu/xrFJDU7zJs0fOmY71kt
         RX38qoWDlP69QjFFja5L9CRfyC2X2PGzx21tuLek+u4fVMS63bFBXQPNpHsPRdi3Ma1f
         X0gkcSb0IpscvDKJs3qMaKudlM9Lyc3K4vbeod8Kili7BMSCWThIz0Iq4CF3+ujkLpcf
         y6O1/mS+UxN0TzywuQXu+wcVl/teZxBdjYNNS8jiXMFF1/Rz/zVckiV2i8tz0f0foMoI
         kAdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dA1mI+zf6fWnHViA8ku/8QUjpA5uE9l+7rlJGihFL9c=;
        b=2Of4i7684XXMPRIoAEFA6hFMGmM8qyidf+OpcC1xfH+TSq9VMJTl0mjrPJm1GS2hyq
         nCLTW2X3CN4ZduLj3qrPd+pLeeZLsW6cgm4tyxZ6D2zSveph0X54aPLxmRpxEhhQ3Gep
         Dc1W/8U6l8BL6OBckb/2SGEpqFY+Vam9S09eRL8N3UI103f9ukGId+Ac/WJqDu107vz4
         HSZRojG1DlczE9syLFmRMlVIlndP6b1bSRLnbm7v+DZMTwZ1Y8iED/+46gZJCFCrLUJ6
         trGfhp6t0eynAbYaHSTMBzDGjPj9mUNDuNSu3hhFioc2axjoNhaY4yGZqcu5oJCS3jD6
         w6Yg==
X-Gm-Message-State: AOAM530Q35ry1FQP8cLyal5qF+NBOpd58vkxjY9ovipakMvAITuHbNae
        z1mGBvN5itcG+qlrD7EEDG53nuVUbFuUG4d1ZgM=
X-Google-Smtp-Source: ABdhPJwUfnJsm00zdFmX1ww+9jvzZDU2o5XLxf04CjAtjlGHqf1xjezkh99DXvsDJzgdWuB9qI3W6repkxwylqmBhJc=
X-Received: by 2002:a05:600c:3b20:: with SMTP id m32mr508621wms.7.1642543495102;
 Tue, 18 Jan 2022 14:04:55 -0800 (PST)
MIME-Version: 1.0
References: <20220118163754.nfy53mfjpazgw2a2@eve> <YecV+rh/4rzygUbx@google.com>
 <CACeCKaeHAV1RLovgMt43uFtHioOeKNrqEbaPq8ZtKNiCS_tTsQ@mail.gmail.com> <CACeCKac0BctZae4n2CiAnpD4J-Dn+h2ROkx7CEVA9EmnobbNUw@mail.gmail.com>
In-Reply-To: <CACeCKac0BctZae4n2CiAnpD4J-Dn+h2ROkx7CEVA9EmnobbNUw@mail.gmail.com>
From:   "Mr. Chromebox" <mrchromebox@gmail.com>
Date:   Tue, 18 Jan 2022 16:04:43 -0600
Message-ID: <CAFTm+6APx0PkRgp+7LLEOi=2E-7ZSgYdQ824U1XB+q1wMPNg3g@mail.gmail.com>
Subject: Re: Null pointer dereference in cros-ec-typec
To:     Prashant Malani <pmalani@chromium.org>
Cc:     Benson Leung <bleung@google.com>, Alyssa Ross <hi@alyssa.is>,
        Benson Leung <bleung@chromium.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi Prashant,

my releases track upstream coreboot; my most recent release was based
on coreboot 4.14 (I'm behind on getting a 4.15-based release out).

A quick perusal of the source for src/ec/google/chromeec/ doesn't show
any recent changes to the location of the GOOG0014 ACPI device. The
most recent change was 2 years ago (so, landed in the 4.12 release),
which moved the USB-C child device to its present location: under
\_SB.PCI0.LPCB.EC0.CREC

ref: https://github.com/coreboot/coreboot/commit/eec30f7beae074c3f80a182cc2=
950ed8e4f0a640

prior to that, it was located under  \_SB.PCI0.LPCB.EC0.

I also dumped/disassembled the ACPI from a recent build to confirm the abov=
e.

regards,
Matt / MrChromebox

On Tue, Jan 18, 2022 at 2:12 PM Prashant Malani <pmalani@chromium.org> wrot=
e:
>
> (+Mr.Chromebox team; using the address listed in
> https://mrchromebox.tech/#support )
>
> Hi Team Mr.Chromebox,
>
> Could you kindly provide some more detail regarding how the GOOG0014
> Type C ACPI device is set up in the Mr Chromebox BIOS for Chromebooks
> (the driver expects it to be embedded in the GOOG0004 EC device)?
> We want to enable Alyssa and other developers using the Mr.Chromebox
> BIOS to have a functional cros-ec-typec driver, so would like to help
> ensure that the device is set up correctly in ACPI.
>
> Thanks!
>
> -Prashant
>
> On Tue, Jan 18, 2022 at 11:49 AM Prashant Malani <pmalani@chromium.org> w=
rote:
> >
> > Hi Benson and Alyssa,
> >
> > On Tue, Jan 18, 2022 at 11:33 AM Benson Leung <bleung@google.com> wrote=
:
> > >
> > > Hi Alyssa,
> > >
> > > Thanks for reaching out.
> > >
> > > On Tue, Jan 18, 2022 at 04:37:54PM +0000, Alyssa Ross wrote:
> > > > My distribution recently enabled the Chrome OS EC Type C control dr=
iver
> > > > in its kernel builds.  On my Google Pixelbook i7 (eve), the driver =
reports
> > > > a null pointer dereference at boot.  From what I can tell, this hap=
pens
> > > > because typec->ec is set to NULL in cros_typec_probe.  Other driver=
s,
> > > > like cros-usbpd-notify, appear to be set up to handle this case.  A=
s a
> > > > result of this bug, I'm no longer able to reboot my computer, becau=
se
> > > > udevd hangs while trying to do something with the device whose driv=
er
> > > > isn't working.
> > > >
> > >
> > > I've copied Prashant, who's the author of the typec driver as well as
> > > cros-usbpd-notify.
> > >
> > > Prashant, any thoughts on a more graceful failure out of the typec dr=
iver's
> > > probe in case there's no ec object?
> >
> > We can add a NULL check and just abort the driver probe if the pointer =
is
> > not valid (the driver is useless without that pointer anyway).
> >
> > A note: The NULL check makes sense on older drivers like cros-usbpd-not=
ify since
> > they can exist in ACPI configurations where they are *not* embedded
> > inside the GOOG0004
> > EC device (on older Chromebooks). That is not the case for the EC Type =
C device.
> >
> > This raises another issue: the custom BIOS from Mr. Chromebox is
> > likely not setting
> > up the EC Type C ACPI (GOOG0014) device correctly; it *must* be
> > embedded inside the overall
> > EC device (GOOG0004). If this is not being done, then the GOOG0014
> > device should not
> > be added to the ACPI tables at all.
> >
> > I would like to understand whether the above was intentional from the
> > Mr. Chromebox BIOS developers;
> > otherwise we are letting an incorrect ACPI configuration just fail
> > with a probe error.
> >
> > Thanks,
> >
> > -Prashant
> >
> > >
> > > > Here's the full Oops.  I was able to reproduce the issue with every
> > > > kernel I tried, from 5.10 to mainline.
> > > >
> > > > cros-usbpd-notify-acpi GOOG0003:00: Couldn't get Chrome EC device p=
ointer.
> > > > input: Intel Virtual Buttons as /devices/pci0000:00/0000:00:1f.0/PN=
P0C09:00/INT33D6:00/input/input14
> > > > BUG: kernel NULL pointer dereference, address: 00000000000000d8
> > > > #PF: supervisor read access in kernel mode
> > > > #PF: error_code(0x0000) - not-present page
> > > > PGD 0 P4D 0
> > > > Oops: 0000 [#1] SMP PTI
> > > > CPU: 1 PID: 561 Comm: systemd-udevd Not tainted 5.15.12 #4
> > > > Hardware name: Google Eve/Eve, BIOS MrChromebox-4.14 08/06/2021
> > >
> > >
> > > Ah, here's the problem. It looks like this is a custom bios from Mr C=
hromebox,
> > > so this is not a bios combination we validate at Google.
> > >
> > > Thank you for the report. We'll look into fixing this and marking the=
 fix
> > > for stable kernels so that it goes back to 5.10.
> > >
> > > Thanks,
> > >
> > > Benson
> > >
> > > > RIP: 0010:__mutex_lock+0x59/0x8c0
> > > > Code: 53 48 89 cb 48 83 ec 70 89 75 9c be 3d 02 00 00 4c 89 45 90 e=
8 18 47 33 ff e8 e3 e2 ff ff 44 8b 35 a4 85 e8 02 45 85 f6 75 0a <4d> 3b 6d=
 68 0f 85 bf 07 00 00 65 ff 05 b6 5b 23 75 ff 75 90 4d 8d
> > > > RSP: 0018:ffffb44580a4bb50 EFLAGS: 00010246
> > > > RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000001
> > > > RDX: 0000000000000000 RSI: ffffffff8bf91320 RDI: ffff922cbba50e20
> > > > RBP: ffffb44580a4bbf0 R08: 0000000000000000 R09: ffff922c5bac8140
> > > > R10: ffffb44580a4bc10 R11: 0000000000000000 R12: 0000000000000000
> > > > R13: 0000000000000070 R14: 0000000000000000 R15: 0000000000000001
> > > > FS:  00007f55338d6b40(0000) GS:ffff922fae200000(0000) knlGS:0000000=
000000000
> > > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > > CR2: 00000000000000d8 CR3: 000000011bbb2006 CR4: 00000000003706e0
> > > > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > > > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > > > Call Trace:
> > > >  <TASK>
> > > >  ? fs_reclaim_acquire+0x4d/0xd0
> > > >  ? lock_is_held_type+0xaa/0x120
> > > >  ? cros_ec_cmd_xfer_status+0x1f/0x110
> > > >  ? lock_is_held_type+0xaa/0x120
> > > >  ? cros_ec_cmd_xfer_status+0x1f/0x110
> > > >  cros_ec_cmd_xfer_status+0x1f/0x110
> > > >  cros_typec_ec_command+0x91/0x1c0 [cros_ec_typec]
> > > >  cros_typec_probe+0x7f/0x5a8 [cros_ec_typec]
> > > >  platform_probe+0x3f/0x90
> > > >  really_probe+0x1f5/0x3f0
> > > >  __driver_probe_device+0xfe/0x180
> > > >  driver_probe_device+0x1e/0x90
> > > >  __driver_attach+0xc4/0x1d0
> > > >  ? __device_attach_driver+0xe0/0xe0
> > > >  ? __device_attach_driver+0xe0/0xe0
> > > >  bus_for_each_dev+0x67/0x90
> > > >  bus_add_driver+0x12e/0x1f0
> > > >  driver_register+0x8f/0xe0
> > > >  ? 0xffffffffc04ec000
> > > >  do_one_initcall+0x67/0x320
> > > >  ? rcu_read_lock_sched_held+0x3f/0x80
> > > >  ? trace_kmalloc+0x38/0xe0
> > > >  ? kmem_cache_alloc_trace+0x17c/0x2b0
> > > >  do_init_module+0x5c/0x270
> > > >  __do_sys_finit_module+0x95/0xe0
> > > >  do_syscall_64+0x3b/0x90
> > > >  entry_SYSCALL_64_after_hwframe+0x44/0xae
> > > > RIP: 0033:0x7f55344b1f3d
> > > > Code: 5b 41 5c c3 66 0f 1f 84 00 00 00 00 00 f3 0f 1e fa 48 89 f8 4=
8 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01=
 f0 ff ff 73 01 c3 48 8b 0d bb ee 0e 00 f7 d8 64 89 01 48
> > > > RSP: 002b:00007fff187f1388 EFLAGS: 00000246 ORIG_RAX: 0000000000000=
139
> > > > RAX: ffffffffffffffda RBX: 000055a53acbe6e0 RCX: 00007f55344b1f3d
> > > > RDX: 0000000000000000 RSI: 00007f553461732c RDI: 000000000000000e
> > > > RBP: 0000000000020000 R08: 0000000000000000 R09: 0000000000000002
> > > > R10: 000000000000000e R11: 0000000000000246 R12: 00007f553461732c
> > > > R13: 000055a53ad94010 R14: 0000000000000007 R15: 000055a53ad95690
> > > >  </TASK>
> > > > Modules linked in: fjes(+) cros_ec_typec(+) typec intel_vbtn(+) cro=
s_usbpd_notify sparse_keymap soc_button_array int3403_thermal int340x_therm=
al_zone int3400_thermal acpi_thermal_rel cros_kbd_led_backlight zram ip_tab=
les i915 hid_multitouch i2c_algo_bit ttm crct10dif_pclmul crc32_pclmul crc3=
2c_intel drm_kms_helper nvme ghash_clmulni_intel sdhci_pci cqhci cec nvme_c=
ore sdhci serio_raw drm mmc_core i2c_hid_acpi i2c_hid video pinctrl_sunrise=
point fuse
> > > > CR2: 00000000000000d8
> > > > ---[ end trace 4a12c4896d70352b ]---
> > >
> > >
> > >
> > > --
> > > Benson Leung
> > > Staff Software Engineer
> > > Chrome OS Kernel
> > > Google Inc.
> > > bleung@google.com
> > > Chromium OS Project
> > > bleung@chromium.org
