Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29F354932FF
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 03:38:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350933AbiASCiC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 21:38:02 -0500
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:52189 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238636AbiASCh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 21:37:56 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 10A8C3201FD3;
        Tue, 18 Jan 2022 21:37:54 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 18 Jan 2022 21:37:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alyssa.is; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=o+gqiaXveu0uvhsGksunLb1bCgQ
        7emHxE8ggFJen2U4=; b=SkekZZ2L0lZPLcP5yg8n1CPjEu57LKjKFOCd61vRzcj
        rAsajryz2PP6dNePS/xEMwiJjejcB65Oidff4JFJla6Fuh9Hk47iQWYs1svYJLnD
        71F6SpgRhd2DzyMos69IVEZ2/MU++A9WrPBGXZqGXGBu6WAl2CHG+GaSHWu1+Njl
        Ra4uoa3dbDarYkrjoQm1TuiEb9+BR/fIkED90gGU/xqnCi4nTmxFDp5f4pNLjLhv
        SbEq/9mdg+Wo+2oQFz4Lu2ZAisdktoEGYeUUebo97BmMHV/kMDe56bkcCSyBmJQR
        CfU8ICt1xjhdYPtwZJdMF9PaPbEUqiMfEk/u+oqZHBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=o+gqia
        Xveu0uvhsGksunLb1bCgQ7emHxE8ggFJen2U4=; b=KJuiz2W1+1Cc08oRoS+N5E
        CCKn91oI6B+ySjfVS2z+C0I7s24qaMo6WRrxLnhIXs2k46plfy0LWUioEl8b+hfQ
        worMUy/v45Yif+NkAv7nx695yVsdX8VZSn2QZHuQh0P7R9ahWgg0dISfVv0v3IZw
        uu0x6Bfyl0nWTqyrJbeK16P6M90G9NWHYRKP7aS+tfbfrnJ3mOYBOSdmZ6uJVtf/
        7WNifuGwb2QObziCrg4l/gbBUir0JrFhDZ2/g5dVdthPrGRk3rIM7nqDHyfaCFdI
        tT4UgwzwBTqNNC9ReOyKNpeMeA6v1hZO/9Qk9eZtJ2KuCpY6f9b/LmbaPC8x5SQA
        ==
X-ME-Sender: <xms:gnnnYWI-Uxykq4_NlHqmlLBRlsMZ8ARfkv3FYmoVZXgTN7BOyKjT-w>
    <xme:gnnnYeK3y5-hX-39CRfGy1ewdSjvJzxsuXPvXQ2VAZZ2eV3bYSiHt0Gj0-SXmTmw7
    p0U_TrXud_bAxKMNQ>
X-ME-Received: <xmr:gnnnYWuvqogACkLQbeuJzyUIcZG6togSb6Sq2JAdJu-zUyXawEkitwSYcGnuspalHacGK7KDWHCatJj_jUgtiXdQVoVtvVA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudeggdegjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtjeenucfhrhhomheptehlhihsshgr
    ucftohhsshcuoehhihesrghlhihsshgrrdhisheqnecuggftrfgrthhtvghrnhephfffve
    dvjeeukeekteduhfeltedugfelgeejteefleehffefveeigefguddtiefgnecuffhomhgr
    ihhnpehgihhthhhusgdrtghomhdpmhhrtghhrhhomhgvsghogidrthgvtghhnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepqhihlhhishhssegv
    vhgvrdhqhihlihhsshdrnhgvth
X-ME-Proxy: <xmx:gnnnYbY-zk8J19nrswtHmQwdv-b8KnZ9X3Ve8gMlGNL-GPtCGW2OxA>
    <xmx:gnnnYdb7Mydyiogxe1lE-BtmRmtEU8YeiyzbyPJUObfu1jpzOrzS7Q>
    <xmx:gnnnYXAak6M1ziLRPw-PA_RgimuXEsAD8dcp7G8P03cKPcWY0__EnQ>
    <xmx:gnnnYcXynHYCqO1Bx4BpWOYVd7aMMcLyvncq2weTH1nty3A-Pz4EBQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Jan 2022 21:37:53 -0500 (EST)
Received: by eve.qyliss.net (Postfix, from userid 1000)
        id BF6F58270; Wed, 19 Jan 2022 02:37:52 +0000 (UTC)
Date:   Wed, 19 Jan 2022 02:37:52 +0000
From:   Alyssa Ross <hi@alyssa.is>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     "Mr. Chromebox" <mrchromebox@gmail.com>,
        Benson Leung <bleung@google.com>,
        Benson Leung <bleung@chromium.org>,
        linux-kernel@vger.kernel.org,
        Tim Wawrzynczak <twawrzynczak@chromium.org>
Subject: Re: Null pointer dereference in cros-ec-typec
Message-ID: <20220119023752.ad34u6hgjpkpk4dw@eve>
References: <20220118163754.nfy53mfjpazgw2a2@eve>
 <YecV+rh/4rzygUbx@google.com>
 <CACeCKaeHAV1RLovgMt43uFtHioOeKNrqEbaPq8ZtKNiCS_tTsQ@mail.gmail.com>
 <CACeCKac0BctZae4n2CiAnpD4J-Dn+h2ROkx7CEVA9EmnobbNUw@mail.gmail.com>
 <CAFTm+6APx0PkRgp+7LLEOi=2E-7ZSgYdQ824U1XB+q1wMPNg3g@mail.gmail.com>
 <CACeCKaeAaS3QcLwvcPNYVtkKxaBViij53TBjOXvwcpKQk+NDbA@mail.gmail.com>
 <CAFTm+6BC--tNjbez_f_A_ckK7gjkbBMWHYSExxQcp9+u60Z2WQ@mail.gmail.com>
 <CACeCKaeAUy8JCO9hv7XjeQA_P_At9SN_Cuw2v=YD01gfwvGXFQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="yr2tsegdvfyv5z5t"
Content-Disposition: inline
In-Reply-To: <CACeCKaeAUy8JCO9hv7XjeQA_P_At9SN_Cuw2v=YD01gfwvGXFQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yr2tsegdvfyv5z5t
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 18, 2022 at 04:35:45PM -0800, Prashant Malani wrote:
> There seem to be some differences.
> The Mr.Chromebox GOOG0004 device doesn't have any connectors listed.
> See here for a BIOS snippet from voxel:
> Scope (\_SB.PCI0.LPCB.EC0.CREC)
>     {
>         Device (USBC)
>         {
>             Name (_HID, "GOOG0014")  // _HID: Hardware ID
>             Name (_DDN, "ChromeOS EC Embedded Controller USB Type-C
> Control")  // _DDN: DOS Device Name
>             Device (CON0)
>             {
>                 ...
>             }
>
>             Device (CON1)
>             {
>                ...
>             }
>         }
>     }
>
> Does the EC on this device support EC_CMD_GET_PD_PORT_CAPS , or
> EC_CMD_USB_PD_PORTS ?
> It doesn't look like the EC is returning anything for these commands,
> which are used to populate GOOG0014.
>
> The CREC device looks about right:
>
> Device (CREC)
>             {
>                 Name (_HID, "GOOG0004")  // _HID: Hardware ID
>                 Name (_UID, One)  // _UID: Unique ID
>                 Name (_DDN, "EC Command Device")  // _DDN: DOS Device Name
>                 Name (_PRW, Package (0x02)  // _PRW: Power Resources for =
Wake
>                 {
>                    ....
>                 })
>              }
>
> 2 observations:
> - We probably shouldn't be generating a GOOG0014 device at all if the
> EC_CMD_GET_PD_PORT_CAPS and EC_CMD_USB_PD_PORTS commands aren't
> supported by the EC. I can work with coreboot to make that change
> - Is the order of probing for some reason causing the GOOG0014 child
> device to not be linked to the GOOG0004 device? Alyssa, does the
> following diff help:

With the diff applied, I no longer see the Oops from cros_ec_typec, and
I can reboot normally.  But, it looks like the driver is deferred
indefinitely =E2=80=94 I added a debug print after the check, and it was ne=
ver
triggered.

> diff --git a/drivers/platform/chrome/cros_ec_typec.c
> b/drivers/platform/chrome/cros_ec_typec.c
> index 5de0bfb0bc4d..7059912b75c1 100644
> --- a/drivers/platform/chrome/cros_ec_typec.c
> +++ b/drivers/platform/chrome/cros_ec_typec.c
> @@ -1076,6 +1076,10 @@ static int cros_typec_probe(struct platform_device=
 *pdev)
>
>         typec->dev =3D dev;
>         typec->ec =3D dev_get_drvdata(pdev->dev.parent);
> +
> +       if (!typec->ec)
> +               return -EPROBE_DEFER;
> +
>         platform_set_drvdata(pdev, typec);
>
>         ret =3D cros_typec_get_cmd_version(typec);
>
>
> On Tue, Jan 18, 2022 at 2:34 PM Mr. Chromebox <mrchromebox@gmail.com> wro=
te:
> >
> > On Tue, Jan 18, 2022 at 4:16 PM Prashant Malani <pmalani@chromium.org> =
wrote:
> > >
> > > Hi Matt,
> > >
> > > On Tue, Jan 18, 2022 at 2:04 PM Mr. Chromebox <mrchromebox@gmail.com>=
 wrote:
> > > >
> > > > hi Prashant,
> > > >
> > > > my releases track upstream coreboot; my most recent release was bas=
ed
> > > > on coreboot 4.14 (I'm behind on getting a 4.15-based release out).
> > > >
> > > > A quick perusal of the source for src/ec/google/chromeec/ doesn't s=
how
> > > > any recent changes to the location of the GOOG0014 ACPI device. The
> > > > most recent change was 2 years ago (so, landed in the 4.12 release),
> > > > which moved the USB-C child device to its present location: under
> > > > \_SB.PCI0.LPCB.EC0.CREC
> > > >
> > > > ref: https://github.com/coreboot/coreboot/commit/eec30f7beae074c3f8=
0a182cc2950ed8e4f0a640
> > > >
> > > > prior to that, it was located under  \_SB.PCI0.LPCB.EC0.
> > > >
> > > > I also dumped/disassembled the ACPI from a recent build to confirm =
the above.
> > >
> > > Is it possible to share the disassembled ACPI tables? We can then
> > > compare it to the ones on shipping Chromebooks to identify a
> > > discrepancy.
> > > If the GOOG0014 device is correctly listed as a child of the EC device
> > > (GOOG0004), then the kernel ACPI framework should be setting
> > > GOOG0004 as a parent (and dev_get_drvdata(pdev->dev.parent) shouldn't
> > > return NULL).
> >
> > as the GOOG0014 device is runtime-generated, it's located in the SSDT:
> >
> > External (_SB_.PCI0.LPCB.EC0_.CREC, DeviceObj)
> > ...
> > Scope (\_SB.PCI0.LPCB.EC0.CREC)
> > {
> >     Device (USBC)
> >     {
> >         Name (_HID, "GOOG0014")  // _HID: Hardware ID
> >         Name (_DDN, "ChromeOS EC Embedded Controller USB Type-C
> > Control")  // _DDN: DOS Device Name
> >     }
> > }
> >
> > GOOG0004 is defined in the DSDT, under EC0:
> >
> > Device (CREC)
> > {
> >     Name (_HID, "GOOG0004")  // _HID: Hardware ID
> >     Name (_UID, One)  // _UID: Unique ID
> >     Name (_DDN, "EC Command Device")  // _DDN: DOS Device Name
> >     Name (_PRW, Package (0x02)  // _PRW: Power Resources for Wake
> >     {
> >         0x70,
> >         0x05
> >     })
> > ...
> > }
> >
> > -Matt
> >
> > > > regards,
> > > > Matt / MrChromebox
> > > >
> > > > On Tue, Jan 18, 2022 at 2:12 PM Prashant Malani <pmalani@chromium.o=
rg> wrote:
> > > > >
> > > > > (+Mr.Chromebox team; using the address listed in
> > > > > https://mrchromebox.tech/#support )
> > > > >
> > > > > Hi Team Mr.Chromebox,
> > > > >
> > > > > Could you kindly provide some more detail regarding how the GOOG0=
014
> > > > > Type C ACPI device is set up in the Mr Chromebox BIOS for Chromeb=
ooks
> > > > > (the driver expects it to be embedded in the GOOG0004 EC device)?
> > > > > We want to enable Alyssa and other developers using the Mr.Chrome=
box
> > > > > BIOS to have a functional cros-ec-typec driver, so would like to =
help
> > > > > ensure that the device is set up correctly in ACPI.
> > > > >
> > > > > Thanks!
> > > > >
> > > > > -Prashant
> > > > >
> > > > > On Tue, Jan 18, 2022 at 11:49 AM Prashant Malani <pmalani@chromiu=
m.org> wrote:
> > > > > >
> > > > > > Hi Benson and Alyssa,
> > > > > >
> > > > > > On Tue, Jan 18, 2022 at 11:33 AM Benson Leung <bleung@google.co=
m> wrote:
> > > > > > >
> > > > > > > Hi Alyssa,
> > > > > > >
> > > > > > > Thanks for reaching out.
> > > > > > >
> > > > > > > On Tue, Jan 18, 2022 at 04:37:54PM +0000, Alyssa Ross wrote:
> > > > > > > > My distribution recently enabled the Chrome OS EC Type C co=
ntrol driver
> > > > > > > > in its kernel builds.  On my Google Pixelbook i7 (eve), the=
 driver reports
> > > > > > > > a null pointer dereference at boot.  From what I can tell, =
this happens
> > > > > > > > because typec->ec is set to NULL in cros_typec_probe.  Othe=
r drivers,
> > > > > > > > like cros-usbpd-notify, appear to be set up to handle this =
case.  As a
> > > > > > > > result of this bug, I'm no longer able to reboot my compute=
r, because
> > > > > > > > udevd hangs while trying to do something with the device wh=
ose driver
> > > > > > > > isn't working.
> > > > > > > >
> > > > > > >
> > > > > > > I've copied Prashant, who's the author of the typec driver as=
 well as
> > > > > > > cros-usbpd-notify.
> > > > > > >
> > > > > > > Prashant, any thoughts on a more graceful failure out of the =
typec driver's
> > > > > > > probe in case there's no ec object?
> > > > > >
> > > > > > We can add a NULL check and just abort the driver probe if the =
pointer is
> > > > > > not valid (the driver is useless without that pointer anyway).
> > > > > >
> > > > > > A note: The NULL check makes sense on older drivers like cros-u=
sbpd-notify since
> > > > > > they can exist in ACPI configurations where they are *not* embe=
dded
> > > > > > inside the GOOG0004
> > > > > > EC device (on older Chromebooks). That is not the case for the =
EC Type C device.
> > > > > >
> > > > > > This raises another issue: the custom BIOS from Mr. Chromebox is
> > > > > > likely not setting
> > > > > > up the EC Type C ACPI (GOOG0014) device correctly; it *must* be
> > > > > > embedded inside the overall
> > > > > > EC device (GOOG0004). If this is not being done, then the GOOG0=
014
> > > > > > device should not
> > > > > > be added to the ACPI tables at all.
> > > > > >
> > > > > > I would like to understand whether the above was intentional fr=
om the
> > > > > > Mr. Chromebox BIOS developers;
> > > > > > otherwise we are letting an incorrect ACPI configuration just f=
ail
> > > > > > with a probe error.
> > > > > >
> > > > > > Thanks,
> > > > > >
> > > > > > -Prashant
> > > > > >
> > > > > > >
> > > > > > > > Here's the full Oops.  I was able to reproduce the issue wi=
th every
> > > > > > > > kernel I tried, from 5.10 to mainline.
> > > > > > > >
> > > > > > > > cros-usbpd-notify-acpi GOOG0003:00: Couldn't get Chrome EC =
device pointer.
> > > > > > > > input: Intel Virtual Buttons as /devices/pci0000:00/0000:00=
:1f.0/PNP0C09:00/INT33D6:00/input/input14
> > > > > > > > BUG: kernel NULL pointer dereference, address: 000000000000=
00d8
> > > > > > > > #PF: supervisor read access in kernel mode
> > > > > > > > #PF: error_code(0x0000) - not-present page
> > > > > > > > PGD 0 P4D 0
> > > > > > > > Oops: 0000 [#1] SMP PTI
> > > > > > > > CPU: 1 PID: 561 Comm: systemd-udevd Not tainted 5.15.12 #4
> > > > > > > > Hardware name: Google Eve/Eve, BIOS MrChromebox-4.14 08/06/=
2021
> > > > > > >
> > > > > > >
> > > > > > > Ah, here's the problem. It looks like this is a custom bios f=
rom Mr Chromebox,
> > > > > > > so this is not a bios combination we validate at Google.
> > > > > > >
> > > > > > > Thank you for the report. We'll look into fixing this and mar=
king the fix
> > > > > > > for stable kernels so that it goes back to 5.10.
> > > > > > >
> > > > > > > Thanks,
> > > > > > >
> > > > > > > Benson
> > > > > > >
> > > > > > > > RIP: 0010:__mutex_lock+0x59/0x8c0
> > > > > > > > Code: 53 48 89 cb 48 83 ec 70 89 75 9c be 3d 02 00 00 4c 89=
 45 90 e8 18 47 33 ff e8 e3 e2 ff ff 44 8b 35 a4 85 e8 02 45 85 f6 75 0a <4=
d> 3b 6d 68 0f 85 bf 07 00 00 65 ff 05 b6 5b 23 75 ff 75 90 4d 8d
> > > > > > > > RSP: 0018:ffffb44580a4bb50 EFLAGS: 00010246
> > > > > > > > RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000=
000001
> > > > > > > > RDX: 0000000000000000 RSI: ffffffff8bf91320 RDI: ffff922cbb=
a50e20
> > > > > > > > RBP: ffffb44580a4bbf0 R08: 0000000000000000 R09: ffff922c5b=
ac8140
> > > > > > > > R10: ffffb44580a4bc10 R11: 0000000000000000 R12: 0000000000=
000000
> > > > > > > > R13: 0000000000000070 R14: 0000000000000000 R15: 0000000000=
000001
> > > > > > > > FS:  00007f55338d6b40(0000) GS:ffff922fae200000(0000) knlGS=
:0000000000000000
> > > > > > > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > > > > > > CR2: 00000000000000d8 CR3: 000000011bbb2006 CR4: 0000000000=
3706e0
> > > > > > > > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000=
000000
> > > > > > > > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000=
000400
> > > > > > > > Call Trace:
> > > > > > > >  <TASK>
> > > > > > > >  ? fs_reclaim_acquire+0x4d/0xd0
> > > > > > > >  ? lock_is_held_type+0xaa/0x120
> > > > > > > >  ? cros_ec_cmd_xfer_status+0x1f/0x110
> > > > > > > >  ? lock_is_held_type+0xaa/0x120
> > > > > > > >  ? cros_ec_cmd_xfer_status+0x1f/0x110
> > > > > > > >  cros_ec_cmd_xfer_status+0x1f/0x110
> > > > > > > >  cros_typec_ec_command+0x91/0x1c0 [cros_ec_typec]
> > > > > > > >  cros_typec_probe+0x7f/0x5a8 [cros_ec_typec]
> > > > > > > >  platform_probe+0x3f/0x90
> > > > > > > >  really_probe+0x1f5/0x3f0
> > > > > > > >  __driver_probe_device+0xfe/0x180
> > > > > > > >  driver_probe_device+0x1e/0x90
> > > > > > > >  __driver_attach+0xc4/0x1d0
> > > > > > > >  ? __device_attach_driver+0xe0/0xe0
> > > > > > > >  ? __device_attach_driver+0xe0/0xe0
> > > > > > > >  bus_for_each_dev+0x67/0x90
> > > > > > > >  bus_add_driver+0x12e/0x1f0
> > > > > > > >  driver_register+0x8f/0xe0
> > > > > > > >  ? 0xffffffffc04ec000
> > > > > > > >  do_one_initcall+0x67/0x320
> > > > > > > >  ? rcu_read_lock_sched_held+0x3f/0x80
> > > > > > > >  ? trace_kmalloc+0x38/0xe0
> > > > > > > >  ? kmem_cache_alloc_trace+0x17c/0x2b0
> > > > > > > >  do_init_module+0x5c/0x270
> > > > > > > >  __do_sys_finit_module+0x95/0xe0
> > > > > > > >  do_syscall_64+0x3b/0x90
> > > > > > > >  entry_SYSCALL_64_after_hwframe+0x44/0xae
> > > > > > > > RIP: 0033:0x7f55344b1f3d
> > > > > > > > Code: 5b 41 5c c3 66 0f 1f 84 00 00 00 00 00 f3 0f 1e fa 48=
 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <4=
8> 3d 01 f0 ff ff 73 01 c3 48 8b 0d bb ee 0e 00 f7 d8 64 89 01 48
> > > > > > > > RSP: 002b:00007fff187f1388 EFLAGS: 00000246 ORIG_RAX: 00000=
00000000139
> > > > > > > > RAX: ffffffffffffffda RBX: 000055a53acbe6e0 RCX: 00007f5534=
4b1f3d
> > > > > > > > RDX: 0000000000000000 RSI: 00007f553461732c RDI: 0000000000=
00000e
> > > > > > > > RBP: 0000000000020000 R08: 0000000000000000 R09: 0000000000=
000002
> > > > > > > > R10: 000000000000000e R11: 0000000000000246 R12: 00007f5534=
61732c
> > > > > > > > R13: 000055a53ad94010 R14: 0000000000000007 R15: 000055a53a=
d95690
> > > > > > > >  </TASK>
> > > > > > > > Modules linked in: fjes(+) cros_ec_typec(+) typec intel_vbt=
n(+) cros_usbpd_notify sparse_keymap soc_button_array int3403_thermal int34=
0x_thermal_zone int3400_thermal acpi_thermal_rel cros_kbd_led_backlight zra=
m ip_tables i915 hid_multitouch i2c_algo_bit ttm crct10dif_pclmul crc32_pcl=
mul crc32c_intel drm_kms_helper nvme ghash_clmulni_intel sdhci_pci cqhci ce=
c nvme_core sdhci serio_raw drm mmc_core i2c_hid_acpi i2c_hid video pinctrl=
_sunrisepoint fuse
> > > > > > > > CR2: 00000000000000d8
> > > > > > > > ---[ end trace 4a12c4896d70352b ]---
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > > --
> > > > > > > Benson Leung
> > > > > > > Staff Software Engineer
> > > > > > > Chrome OS Kernel
> > > > > > > Google Inc.
> > > > > > > bleung@google.com
> > > > > > > Chromium OS Project
> > > > > > > bleung@chromium.org

--yr2tsegdvfyv5z5t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEH9wgcxqlHM/ARR3h+dvtSFmyccAFAmHneW8ACgkQ+dvtSFmy
ccC6xxAAj+atilDwg6j9P0+rPEmAtnj+QUNxenU1agG8ZRRxkyr/MdfcWz1IBhus
BHrvLMc8y1BHXlyYvLU+43VM9vsAaeJg8zA3c9IsT6IORk3wajReEzdlEPoCbPwf
w2r8CvbBXnfMRnEZLf3NAWsT3+6gRVXpja9pidl9YUHnd7SE29djprOlSuYYp9Fp
Dug6euedFOY0/rrlFckSIEJu4KZzmffgC+xOUpnk3hCUnHnhMu8EIPFA40XDpt/d
tqHK7GyJaAoEYN2q5GQxsGxVXd2eqrCPoBED+b6nBbjfTTZ4NJlwGANeo4KOYdhq
NUl0jKxQ0toasItLboGaM0DdYhuABrVb/684SDI3bRHZ/8ZN7lscFJYyWF4Ay03Y
WUYwfgkdXY8HQuCvqrFMgaiAs72x2V7mP8GAUrGhS7DLpkrDcbIBpwosTVd2+C2P
/kbxqlhPUPL0XiGt192gI3H4SYTYCaZ6xy7mmc9OT9/IX6dQRoL/+dz7BYEWYdzw
P7PbUKXsxpVTUolLzFh3mYGGeXwVzb5BSgcCBqA3ZziGWtxEv7umveYyVnUVdjs3
cl32oULcshAuWpj1fmVADlKSfqU1I9aw+FUf/HFYy8NjS5AFSx78/CZWPF+bqpxE
pdbobZssnvuu+gDWy2D0Ptr7gK3s2klh3arlzYBRoicvHAX38kY=
=XE7p
-----END PGP SIGNATURE-----

--yr2tsegdvfyv5z5t--
