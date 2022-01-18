Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C792D4930D4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 23:34:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349992AbiARWec (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 17:34:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237457AbiARWeb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 17:34:31 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22BEFC061574
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 14:34:31 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id c66so1219565wma.5
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 14:34:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Mtx/+u3/1+SJRDHf6NqhofAWX7zLc3WCVoGOq4k7yT0=;
        b=Y+3xla4F2rF7LboX48yoosaRPWxP6VX6qjMsuncU57EtZhxeUoVWxAHSTZ8k7eAfXt
         drhlsscSAqDNd8okXZCnRs0bEpsm8Yq1odVuwBPtAxms3Ufl5FA8wJ50QIl9714weMDh
         MaB9Na/UDeqxRR12JVUK4mVrBqXLsNrZlxVZAG7SA3QQbQWqmc1bcPr+WyNsmrs7HhzN
         1e3MJZkZRAnbPZxfw7UEMc3qpqyVAEYHRzkk5HVrveQWPZUJ9UGlKKIw87sX76HP+FqE
         4mZ3aCgRqB481ShKCUSL/LllQLZEYwrg16Ybc7+mBdHXdtT6L7KwmwPuB1l+FSHyAt7z
         xVVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Mtx/+u3/1+SJRDHf6NqhofAWX7zLc3WCVoGOq4k7yT0=;
        b=w68ZS4f/6h3KMCNlRUuGGKPze0OVeuoRhaFiDNHWhc0hql89tUtczszkMsWf4VLbwI
         62EbbFlJbLYitr1Qm66GE+n5MEURgXGGslQ6HxGnodQBul+eOXCHN7qtmbT0CodQvVJJ
         yUpAwhtw3lejMg4SuxMCSbEUmYZdjIjdUj8o7H0o0DjpLUVRWvZnSJPY6uT8o9JIj9AT
         ontVxvS70/Sb+uo6DUwQhPYy8mc7vqzPr5p1+Hn6oe6DAdlx6eNdDaac2lynUpYwzhZp
         5JgpXIlRAAQHIdmf269qpHEu8r7JBXsrIbIucb5PYQBW1JctK5cgmQYr3VW/YSeirsXo
         eA+g==
X-Gm-Message-State: AOAM533O0T1igReqniuwHBQ/N377s8qCO+It6vho+uU4dC7KUeCmkcAr
        B/XwuCkF0T+MooP+ZP2i9g2CCAX7MaPR1iQBkYY=
X-Google-Smtp-Source: ABdhPJyt2w+Sgrj9GNrriPjVlBmoVmQM0NOZ7jfLj2QOzUmQRiWHQhcKV2hy8A7/nr3+YuoszcohYhUxdKxGOVdtTpI=
X-Received: by 2002:a05:600c:3b20:: with SMTP id m32mr591587wms.7.1642545269414;
 Tue, 18 Jan 2022 14:34:29 -0800 (PST)
MIME-Version: 1.0
References: <20220118163754.nfy53mfjpazgw2a2@eve> <YecV+rh/4rzygUbx@google.com>
 <CACeCKaeHAV1RLovgMt43uFtHioOeKNrqEbaPq8ZtKNiCS_tTsQ@mail.gmail.com>
 <CACeCKac0BctZae4n2CiAnpD4J-Dn+h2ROkx7CEVA9EmnobbNUw@mail.gmail.com>
 <CAFTm+6APx0PkRgp+7LLEOi=2E-7ZSgYdQ824U1XB+q1wMPNg3g@mail.gmail.com> <CACeCKaeAaS3QcLwvcPNYVtkKxaBViij53TBjOXvwcpKQk+NDbA@mail.gmail.com>
In-Reply-To: <CACeCKaeAaS3QcLwvcPNYVtkKxaBViij53TBjOXvwcpKQk+NDbA@mail.gmail.com>
From:   "Mr. Chromebox" <mrchromebox@gmail.com>
Date:   Tue, 18 Jan 2022 16:34:18 -0600
Message-ID: <CAFTm+6BC--tNjbez_f_A_ckK7gjkbBMWHYSExxQcp9+u60Z2WQ@mail.gmail.com>
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

On Tue, Jan 18, 2022 at 4:16 PM Prashant Malani <pmalani@chromium.org> wrot=
e:
>
> Hi Matt,
>
> On Tue, Jan 18, 2022 at 2:04 PM Mr. Chromebox <mrchromebox@gmail.com> wro=
te:
> >
> > hi Prashant,
> >
> > my releases track upstream coreboot; my most recent release was based
> > on coreboot 4.14 (I'm behind on getting a 4.15-based release out).
> >
> > A quick perusal of the source for src/ec/google/chromeec/ doesn't show
> > any recent changes to the location of the GOOG0014 ACPI device. The
> > most recent change was 2 years ago (so, landed in the 4.12 release),
> > which moved the USB-C child device to its present location: under
> > \_SB.PCI0.LPCB.EC0.CREC
> >
> > ref: https://github.com/coreboot/coreboot/commit/eec30f7beae074c3f80a18=
2cc2950ed8e4f0a640
> >
> > prior to that, it was located under  \_SB.PCI0.LPCB.EC0.
> >
> > I also dumped/disassembled the ACPI from a recent build to confirm the =
above.
>
> Is it possible to share the disassembled ACPI tables? We can then
> compare it to the ones on shipping Chromebooks to identify a
> discrepancy.
> If the GOOG0014 device is correctly listed as a child of the EC device
> (GOOG0004), then the kernel ACPI framework should be setting
> GOOG0004 as a parent (and dev_get_drvdata(pdev->dev.parent) shouldn't
> return NULL).

as the GOOG0014 device is runtime-generated, it's located in the SSDT:

External (_SB_.PCI0.LPCB.EC0_.CREC, DeviceObj)
...
Scope (\_SB.PCI0.LPCB.EC0.CREC)
{
    Device (USBC)
    {
        Name (_HID, "GOOG0014")  // _HID: Hardware ID
        Name (_DDN, "ChromeOS EC Embedded Controller USB Type-C
Control")  // _DDN: DOS Device Name
    }
}

GOOG0004 is defined in the DSDT, under EC0:

Device (CREC)
{
    Name (_HID, "GOOG0004")  // _HID: Hardware ID
    Name (_UID, One)  // _UID: Unique ID
    Name (_DDN, "EC Command Device")  // _DDN: DOS Device Name
    Name (_PRW, Package (0x02)  // _PRW: Power Resources for Wake
    {
        0x70,
        0x05
    })
...
}

-Matt

> > regards,
> > Matt / MrChromebox
> >
> > On Tue, Jan 18, 2022 at 2:12 PM Prashant Malani <pmalani@chromium.org> =
wrote:
> > >
> > > (+Mr.Chromebox team; using the address listed in
> > > https://mrchromebox.tech/#support )
> > >
> > > Hi Team Mr.Chromebox,
> > >
> > > Could you kindly provide some more detail regarding how the GOOG0014
> > > Type C ACPI device is set up in the Mr Chromebox BIOS for Chromebooks
> > > (the driver expects it to be embedded in the GOOG0004 EC device)?
> > > We want to enable Alyssa and other developers using the Mr.Chromebox
> > > BIOS to have a functional cros-ec-typec driver, so would like to help
> > > ensure that the device is set up correctly in ACPI.
> > >
> > > Thanks!
> > >
> > > -Prashant
> > >
> > > On Tue, Jan 18, 2022 at 11:49 AM Prashant Malani <pmalani@chromium.or=
g> wrote:
> > > >
> > > > Hi Benson and Alyssa,
> > > >
> > > > On Tue, Jan 18, 2022 at 11:33 AM Benson Leung <bleung@google.com> w=
rote:
> > > > >
> > > > > Hi Alyssa,
> > > > >
> > > > > Thanks for reaching out.
> > > > >
> > > > > On Tue, Jan 18, 2022 at 04:37:54PM +0000, Alyssa Ross wrote:
> > > > > > My distribution recently enabled the Chrome OS EC Type C contro=
l driver
> > > > > > in its kernel builds.  On my Google Pixelbook i7 (eve), the dri=
ver reports
> > > > > > a null pointer dereference at boot.  From what I can tell, this=
 happens
> > > > > > because typec->ec is set to NULL in cros_typec_probe.  Other dr=
ivers,
> > > > > > like cros-usbpd-notify, appear to be set up to handle this case=
.  As a
> > > > > > result of this bug, I'm no longer able to reboot my computer, b=
ecause
> > > > > > udevd hangs while trying to do something with the device whose =
driver
> > > > > > isn't working.
> > > > > >
> > > > >
> > > > > I've copied Prashant, who's the author of the typec driver as wel=
l as
> > > > > cros-usbpd-notify.
> > > > >
> > > > > Prashant, any thoughts on a more graceful failure out of the type=
c driver's
> > > > > probe in case there's no ec object?
> > > >
> > > > We can add a NULL check and just abort the driver probe if the poin=
ter is
> > > > not valid (the driver is useless without that pointer anyway).
> > > >
> > > > A note: The NULL check makes sense on older drivers like cros-usbpd=
-notify since
> > > > they can exist in ACPI configurations where they are *not* embedded
> > > > inside the GOOG0004
> > > > EC device (on older Chromebooks). That is not the case for the EC T=
ype C device.
> > > >
> > > > This raises another issue: the custom BIOS from Mr. Chromebox is
> > > > likely not setting
> > > > up the EC Type C ACPI (GOOG0014) device correctly; it *must* be
> > > > embedded inside the overall
> > > > EC device (GOOG0004). If this is not being done, then the GOOG0014
> > > > device should not
> > > > be added to the ACPI tables at all.
> > > >
> > > > I would like to understand whether the above was intentional from t=
he
> > > > Mr. Chromebox BIOS developers;
> > > > otherwise we are letting an incorrect ACPI configuration just fail
> > > > with a probe error.
> > > >
> > > > Thanks,
> > > >
> > > > -Prashant
> > > >
> > > > >
> > > > > > Here's the full Oops.  I was able to reproduce the issue with e=
very
> > > > > > kernel I tried, from 5.10 to mainline.
> > > > > >
> > > > > > cros-usbpd-notify-acpi GOOG0003:00: Couldn't get Chrome EC devi=
ce pointer.
> > > > > > input: Intel Virtual Buttons as /devices/pci0000:00/0000:00:1f.=
0/PNP0C09:00/INT33D6:00/input/input14
> > > > > > BUG: kernel NULL pointer dereference, address: 00000000000000d8
> > > > > > #PF: supervisor read access in kernel mode
> > > > > > #PF: error_code(0x0000) - not-present page
> > > > > > PGD 0 P4D 0
> > > > > > Oops: 0000 [#1] SMP PTI
> > > > > > CPU: 1 PID: 561 Comm: systemd-udevd Not tainted 5.15.12 #4
> > > > > > Hardware name: Google Eve/Eve, BIOS MrChromebox-4.14 08/06/2021
> > > > >
> > > > >
> > > > > Ah, here's the problem. It looks like this is a custom bios from =
Mr Chromebox,
> > > > > so this is not a bios combination we validate at Google.
> > > > >
> > > > > Thank you for the report. We'll look into fixing this and marking=
 the fix
> > > > > for stable kernels so that it goes back to 5.10.
> > > > >
> > > > > Thanks,
> > > > >
> > > > > Benson
> > > > >
> > > > > > RIP: 0010:__mutex_lock+0x59/0x8c0
> > > > > > Code: 53 48 89 cb 48 83 ec 70 89 75 9c be 3d 02 00 00 4c 89 45 =
90 e8 18 47 33 ff e8 e3 e2 ff ff 44 8b 35 a4 85 e8 02 45 85 f6 75 0a <4d> 3=
b 6d 68 0f 85 bf 07 00 00 65 ff 05 b6 5b 23 75 ff 75 90 4d 8d
> > > > > > RSP: 0018:ffffb44580a4bb50 EFLAGS: 00010246
> > > > > > RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00000000000000=
01
> > > > > > RDX: 0000000000000000 RSI: ffffffff8bf91320 RDI: ffff922cbba50e=
20
> > > > > > RBP: ffffb44580a4bbf0 R08: 0000000000000000 R09: ffff922c5bac81=
40
> > > > > > R10: ffffb44580a4bc10 R11: 0000000000000000 R12: 00000000000000=
00
> > > > > > R13: 0000000000000070 R14: 0000000000000000 R15: 00000000000000=
01
> > > > > > FS:  00007f55338d6b40(0000) GS:ffff922fae200000(0000) knlGS:000=
0000000000000
> > > > > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > > > > CR2: 00000000000000d8 CR3: 000000011bbb2006 CR4: 00000000003706=
e0
> > > > > > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000000=
00
> > > > > > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000000004=
00
> > > > > > Call Trace:
> > > > > >  <TASK>
> > > > > >  ? fs_reclaim_acquire+0x4d/0xd0
> > > > > >  ? lock_is_held_type+0xaa/0x120
> > > > > >  ? cros_ec_cmd_xfer_status+0x1f/0x110
> > > > > >  ? lock_is_held_type+0xaa/0x120
> > > > > >  ? cros_ec_cmd_xfer_status+0x1f/0x110
> > > > > >  cros_ec_cmd_xfer_status+0x1f/0x110
> > > > > >  cros_typec_ec_command+0x91/0x1c0 [cros_ec_typec]
> > > > > >  cros_typec_probe+0x7f/0x5a8 [cros_ec_typec]
> > > > > >  platform_probe+0x3f/0x90
> > > > > >  really_probe+0x1f5/0x3f0
> > > > > >  __driver_probe_device+0xfe/0x180
> > > > > >  driver_probe_device+0x1e/0x90
> > > > > >  __driver_attach+0xc4/0x1d0
> > > > > >  ? __device_attach_driver+0xe0/0xe0
> > > > > >  ? __device_attach_driver+0xe0/0xe0
> > > > > >  bus_for_each_dev+0x67/0x90
> > > > > >  bus_add_driver+0x12e/0x1f0
> > > > > >  driver_register+0x8f/0xe0
> > > > > >  ? 0xffffffffc04ec000
> > > > > >  do_one_initcall+0x67/0x320
> > > > > >  ? rcu_read_lock_sched_held+0x3f/0x80
> > > > > >  ? trace_kmalloc+0x38/0xe0
> > > > > >  ? kmem_cache_alloc_trace+0x17c/0x2b0
> > > > > >  do_init_module+0x5c/0x270
> > > > > >  __do_sys_finit_module+0x95/0xe0
> > > > > >  do_syscall_64+0x3b/0x90
> > > > > >  entry_SYSCALL_64_after_hwframe+0x44/0xae
> > > > > > RIP: 0033:0x7f55344b1f3d
> > > > > > Code: 5b 41 5c c3 66 0f 1f 84 00 00 00 00 00 f3 0f 1e fa 48 89 =
f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3=
d 01 f0 ff ff 73 01 c3 48 8b 0d bb ee 0e 00 f7 d8 64 89 01 48
> > > > > > RSP: 002b:00007fff187f1388 EFLAGS: 00000246 ORIG_RAX: 000000000=
0000139
> > > > > > RAX: ffffffffffffffda RBX: 000055a53acbe6e0 RCX: 00007f55344b1f=
3d
> > > > > > RDX: 0000000000000000 RSI: 00007f553461732c RDI: 00000000000000=
0e
> > > > > > RBP: 0000000000020000 R08: 0000000000000000 R09: 00000000000000=
02
> > > > > > R10: 000000000000000e R11: 0000000000000246 R12: 00007f55346173=
2c
> > > > > > R13: 000055a53ad94010 R14: 0000000000000007 R15: 000055a53ad956=
90
> > > > > >  </TASK>
> > > > > > Modules linked in: fjes(+) cros_ec_typec(+) typec intel_vbtn(+)=
 cros_usbpd_notify sparse_keymap soc_button_array int3403_thermal int340x_t=
hermal_zone int3400_thermal acpi_thermal_rel cros_kbd_led_backlight zram ip=
_tables i915 hid_multitouch i2c_algo_bit ttm crct10dif_pclmul crc32_pclmul =
crc32c_intel drm_kms_helper nvme ghash_clmulni_intel sdhci_pci cqhci cec nv=
me_core sdhci serio_raw drm mmc_core i2c_hid_acpi i2c_hid video pinctrl_sun=
risepoint fuse
> > > > > > CR2: 00000000000000d8
> > > > > > ---[ end trace 4a12c4896d70352b ]---
> > > > >
> > > > >
> > > > >
> > > > > --
> > > > > Benson Leung
> > > > > Staff Software Engineer
> > > > > Chrome OS Kernel
> > > > > Google Inc.
> > > > > bleung@google.com
> > > > > Chromium OS Project
> > > > > bleung@chromium.org
