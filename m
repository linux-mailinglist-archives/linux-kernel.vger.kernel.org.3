Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A03A94941CE
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 21:33:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232416AbiASUc6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 15:32:58 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:45309 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244968AbiASUcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 15:32:47 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 30FD55C00B1;
        Wed, 19 Jan 2022 15:32:46 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 19 Jan 2022 15:32:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alyssa.is; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=1hAx2SHoxOsF0wV29nkbjhCv5xx
        UY8BjVUj+zxx5i+U=; b=ipPea52e4gBXcAa7C6P3BZfE2KpeEcDyikFFOhQa6q3
        rvrXPm95tWkCSNYHyKGnBgLK5cF2KHY1Es7j35nLtU1vhKQQmstrdbJpUNTM3Wxc
        tz8dgo9w+yNEvgTcQODbKcJCLWLddOSEOKKLjNAbyriJVBDJHETUcbZF9BRupq+T
        rR7xR/zO7yudZLLdxVRviQyP4NHNRo6xMDdYZxw0wWh4/U5ytJ6WK5Es2TArP0zK
        OC+T7DbkfXFFS0jlEUzycvT9EGX8+uncedSp1f/pRLK1pQHb5hkowc3PBE23kM5x
        Xgumr5/+ITRrFrNeZJVBfC5+9klkUWkTu/UH9n3lm7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=1hAx2S
        HoxOsF0wV29nkbjhCv5xxUY8BjVUj+zxx5i+U=; b=OAUVkfP7T4xJEsesQmzT7A
        avUghW1wwrDmG2FSZPt0FvrBNqJIrZenUOTTN4tRk8bnP8g7Az1J57zxumsniiBj
        enHOjE6lbvSS6DC9adxCIR+LmPGqDvIebMTp+BKb42NGwbSvpwOCZ9KIh4KMuTgi
        iUDtiV3suZ9Edqrzo5tnLhLs9xYgE762a2FIf8ELzliSjWWb1jNgs8WjNHYVbWIr
        ZED3ZLAD9G9lpRwWNV36sckHljU7VY9RPdw/554DlJmR1kHg+lRh31TaHZzZNGVR
        hO/evqrpBuPU0hKuzzy6ySKlrGQ5M7CtoDTGhUiLHH0m0PDgyqL2dXFcqsHLKFUg
        ==
X-ME-Sender: <xms:bnXoYVQX0u-pGDpyWp6fDH8px1Ax5xsSX4oWWj4_aKhC-SDsny_McA>
    <xme:bnXoYeyCz37zz8U_Jtz5SKsKjlAMzRxGeLQnhBQgotxmWYDoZJPfEFOLMxkXtSi3l
    lkvjci-1wmGtTEhKg>
X-ME-Received: <xmr:bnXoYa0e674ESKEzQhp1AuRUn63-nkAT9Ksaz5UksSlFyFhRHc50gMcKAIfsrfUM6VwAYuSItBAa5dW__EdX7VUZRTQmzM0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudeigdejlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtjeenucfhrhhomheptehlhihsshgr
    ucftohhsshcuoehhihesrghlhihsshgrrdhisheqnecuggftrfgrthhtvghrnhephfffve
    dvjeeukeekteduhfeltedugfelgeejteefleehffefveeigefguddtiefgnecuffhomhgr
    ihhnpehgihhthhhusgdrtghomhdpmhhrtghhrhhomhgvsghogidrthgvtghhnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepqhihlhhishhssegv
    vhgvrdhqhihlihhsshdrnhgvth
X-ME-Proxy: <xmx:bnXoYdDpChrBWV0N1qU4kVS2e1BMeOqDHkkPH7I3cpuoxWvW2rr8dA>
    <xmx:bnXoYegxugxbEQeX-7Wu80YuOQf5zk3K4zMIuPyjai22SsWUVPhQgA>
    <xmx:bnXoYRpM5GanlYNx6L8mgqUZqy7MYHJBaDRaG346DTaefuhj3MZmYA>
    <xmx:bnXoYWfex_nM9PcvXxIKYhwgSGMAB0W8fUWHYb0UD54vbGo24vNtdw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Jan 2022 15:32:45 -0500 (EST)
Received: by eve.qyliss.net (Postfix, from userid 1000)
        id 9C1418E4A; Wed, 19 Jan 2022 20:32:43 +0000 (UTC)
Date:   Wed, 19 Jan 2022 20:32:43 +0000
From:   Alyssa Ross <hi@alyssa.is>
To:     "Mr. Chromebox" <mrchromebox@gmail.com>,
        Prashant Malani <pmalani@chromium.org>
Cc:     Benson Leung <bleung@google.com>,
        Benson Leung <bleung@chromium.org>,
        linux-kernel@vger.kernel.org,
        Tim Wawrzynczak <twawrzynczak@chromium.org>
Subject: Re: Null pointer dereference in cros-ec-typec
Message-ID: <20220119203243.3zh6mcb2fauczn5k@eve>
References: <YecV+rh/4rzygUbx@google.com>
 <CACeCKaeHAV1RLovgMt43uFtHioOeKNrqEbaPq8ZtKNiCS_tTsQ@mail.gmail.com>
 <CACeCKac0BctZae4n2CiAnpD4J-Dn+h2ROkx7CEVA9EmnobbNUw@mail.gmail.com>
 <CAFTm+6APx0PkRgp+7LLEOi=2E-7ZSgYdQ824U1XB+q1wMPNg3g@mail.gmail.com>
 <CACeCKaeAaS3QcLwvcPNYVtkKxaBViij53TBjOXvwcpKQk+NDbA@mail.gmail.com>
 <CAFTm+6BC--tNjbez_f_A_ckK7gjkbBMWHYSExxQcp9+u60Z2WQ@mail.gmail.com>
 <CACeCKaeAUy8JCO9hv7XjeQA_P_At9SN_Cuw2v=YD01gfwvGXFQ@mail.gmail.com>
 <20220119023752.ad34u6hgjpkpk4dw@eve>
 <CACeCKafA4eDNgEbACjorCHBdrLaG6YviRS+gA=Xr-XD+GVaxZw@mail.gmail.com>
 <CAFTm+6DMuxx_qiPEU4VwweZVvuFhReWTogYMychH1gXnn47xHw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5d3cgqzho6ik5ctz"
Content-Disposition: inline
In-Reply-To: <CAFTm+6DMuxx_qiPEU4VwweZVvuFhReWTogYMychH1gXnn47xHw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5d3cgqzho6ik5ctz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 19, 2022 at 12:44:06PM -0600, Mr. Chromebox wrote:
> On Wed, Jan 19, 2022 at 12:24 PM Prashant Malani <pmalani@chromium.org> w=
rote:
> >
> > Thanks Alyssa,
> >
> > It looks like the right fix here should go in coreboot.
> >
> > I'll wait for a response from Matt regarding whether those EC commands
> > are supported on the eve EC firmware image Mr.Chromebox releases.
>
> looking at Chrome-EC branch firmware-eve-9584.B,
>
> EC_CMD_GET_PD_PORT_CAPS is *not* supported
> EC_CMD_USB_PD_PORTS is supported
>
> no difference in this regard between my updated EC firmware and the
> latest stock EC firmware provided by Google for EVE
>
> > I have a fix but I can't test it since :
> > - I am not sure how the Mr.Chromebox eve BIOS is compiled.
>
> same build system as upstream coreboot
>
> > - I don't have an eve.
>
> me neither :)

I'd be more than happy to test Coreboot patches on my eve and report
back on anything that needs to be checked, if that helps?  I've built
and installed it from source before.

> >
> > On Tue, Jan 18, 2022 at 6:37 PM Alyssa Ross <hi@alyssa.is> wrote:
> > >
> > > On Tue, Jan 18, 2022 at 04:35:45PM -0800, Prashant Malani wrote:
> > > > There seem to be some differences.
> > > > The Mr.Chromebox GOOG0004 device doesn't have any connectors listed.
> > > > See here for a BIOS snippet from voxel:
> > > > Scope (\_SB.PCI0.LPCB.EC0.CREC)
> > > >     {
> > > >         Device (USBC)
> > > >         {
> > > >             Name (_HID, "GOOG0014")  // _HID: Hardware ID
> > > >             Name (_DDN, "ChromeOS EC Embedded Controller USB Type-C
> > > > Control")  // _DDN: DOS Device Name
> > > >             Device (CON0)
> > > >             {
> > > >                 ...
> > > >             }
> > > >
> > > >             Device (CON1)
> > > >             {
> > > >                ...
> > > >             }
> > > >         }
> > > >     }
> > > >
> > > > Does the EC on this device support EC_CMD_GET_PD_PORT_CAPS , or
> > > > EC_CMD_USB_PD_PORTS ?
> > > > It doesn't look like the EC is returning anything for these command=
s,
> > > > which are used to populate GOOG0014.
> > > >
> > > > The CREC device looks about right:
> > > >
> > > > Device (CREC)
> > > >             {
> > > >                 Name (_HID, "GOOG0004")  // _HID: Hardware ID
> > > >                 Name (_UID, One)  // _UID: Unique ID
> > > >                 Name (_DDN, "EC Command Device")  // _DDN: DOS Devi=
ce Name
> > > >                 Name (_PRW, Package (0x02)  // _PRW: Power Resource=
s for Wake
> > > >                 {
> > > >                    ....
> > > >                 })
> > > >              }
> > > >
> > > > 2 observations:
> > > > - We probably shouldn't be generating a GOOG0014 device at all if t=
he
> > > > EC_CMD_GET_PD_PORT_CAPS and EC_CMD_USB_PD_PORTS commands aren't
> > > > supported by the EC. I can work with coreboot to make that change
> > > > - Is the order of probing for some reason causing the GOOG0014 child
> > > > device to not be linked to the GOOG0004 device? Alyssa, does the
> > > > following diff help:
> > >
> > > With the diff applied, I no longer see the Oops from cros_ec_typec, a=
nd
> > > I can reboot normally.  But, it looks like the driver is deferred
> > > indefinitely =E2=80=94 I added a debug print after the check, and it =
was never
> > > triggered.
> > >
> > > > diff --git a/drivers/platform/chrome/cros_ec_typec.c
> > > > b/drivers/platform/chrome/cros_ec_typec.c
> > > > index 5de0bfb0bc4d..7059912b75c1 100644
> > > > --- a/drivers/platform/chrome/cros_ec_typec.c
> > > > +++ b/drivers/platform/chrome/cros_ec_typec.c
> > > > @@ -1076,6 +1076,10 @@ static int cros_typec_probe(struct platform_=
device *pdev)
> > > >
> > > >         typec->dev =3D dev;
> > > >         typec->ec =3D dev_get_drvdata(pdev->dev.parent);
> > > > +
> > > > +       if (!typec->ec)
> > > > +               return -EPROBE_DEFER;
> > > > +
> > > >         platform_set_drvdata(pdev, typec);
> > > >
> > > >         ret =3D cros_typec_get_cmd_version(typec);
> > > >
> > > >
> > > > On Tue, Jan 18, 2022 at 2:34 PM Mr. Chromebox <mrchromebox@gmail.co=
m> wrote:
> > > > >
> > > > > On Tue, Jan 18, 2022 at 4:16 PM Prashant Malani <pmalani@chromium=
=2Eorg> wrote:
> > > > > >
> > > > > > Hi Matt,
> > > > > >
> > > > > > On Tue, Jan 18, 2022 at 2:04 PM Mr. Chromebox <mrchromebox@gmai=
l.com> wrote:
> > > > > > >
> > > > > > > hi Prashant,
> > > > > > >
> > > > > > > my releases track upstream coreboot; my most recent release w=
as based
> > > > > > > on coreboot 4.14 (I'm behind on getting a 4.15-based release =
out).
> > > > > > >
> > > > > > > A quick perusal of the source for src/ec/google/chromeec/ doe=
sn't show
> > > > > > > any recent changes to the location of the GOOG0014 ACPI devic=
e. The
> > > > > > > most recent change was 2 years ago (so, landed in the 4.12 re=
lease),
> > > > > > > which moved the USB-C child device to its present location: u=
nder
> > > > > > > \_SB.PCI0.LPCB.EC0.CREC
> > > > > > >
> > > > > > > ref: https://github.com/coreboot/coreboot/commit/eec30f7beae0=
74c3f80a182cc2950ed8e4f0a640
> > > > > > >
> > > > > > > prior to that, it was located under  \_SB.PCI0.LPCB.EC0.
> > > > > > >
> > > > > > > I also dumped/disassembled the ACPI from a recent build to co=
nfirm the above.
> > > > > >
> > > > > > Is it possible to share the disassembled ACPI tables? We can th=
en
> > > > > > compare it to the ones on shipping Chromebooks to identify a
> > > > > > discrepancy.
> > > > > > If the GOOG0014 device is correctly listed as a child of the EC=
 device
> > > > > > (GOOG0004), then the kernel ACPI framework should be setting
> > > > > > GOOG0004 as a parent (and dev_get_drvdata(pdev->dev.parent) sho=
uldn't
> > > > > > return NULL).
> > > > >
> > > > > as the GOOG0014 device is runtime-generated, it's located in the =
SSDT:
> > > > >
> > > > > External (_SB_.PCI0.LPCB.EC0_.CREC, DeviceObj)
> > > > > ...
> > > > > Scope (\_SB.PCI0.LPCB.EC0.CREC)
> > > > > {
> > > > >     Device (USBC)
> > > > >     {
> > > > >         Name (_HID, "GOOG0014")  // _HID: Hardware ID
> > > > >         Name (_DDN, "ChromeOS EC Embedded Controller USB Type-C
> > > > > Control")  // _DDN: DOS Device Name
> > > > >     }
> > > > > }
> > > > >
> > > > > GOOG0004 is defined in the DSDT, under EC0:
> > > > >
> > > > > Device (CREC)
> > > > > {
> > > > >     Name (_HID, "GOOG0004")  // _HID: Hardware ID
> > > > >     Name (_UID, One)  // _UID: Unique ID
> > > > >     Name (_DDN, "EC Command Device")  // _DDN: DOS Device Name
> > > > >     Name (_PRW, Package (0x02)  // _PRW: Power Resources for Wake
> > > > >     {
> > > > >         0x70,
> > > > >         0x05
> > > > >     })
> > > > > ...
> > > > > }
> > > > >
> > > > > -Matt
> > > > >
> > > > > > > regards,
> > > > > > > Matt / MrChromebox
> > > > > > >
> > > > > > > On Tue, Jan 18, 2022 at 2:12 PM Prashant Malani <pmalani@chro=
mium.org> wrote:
> > > > > > > >
> > > > > > > > (+Mr.Chromebox team; using the address listed in
> > > > > > > > https://mrchromebox.tech/#support )
> > > > > > > >
> > > > > > > > Hi Team Mr.Chromebox,
> > > > > > > >
> > > > > > > > Could you kindly provide some more detail regarding how the=
 GOOG0014
> > > > > > > > Type C ACPI device is set up in the Mr Chromebox BIOS for C=
hromebooks
> > > > > > > > (the driver expects it to be embedded in the GOOG0004 EC de=
vice)?
> > > > > > > > We want to enable Alyssa and other developers using the Mr.=
Chromebox
> > > > > > > > BIOS to have a functional cros-ec-typec driver, so would li=
ke to help
> > > > > > > > ensure that the device is set up correctly in ACPI.
> > > > > > > >
> > > > > > > > Thanks!
> > > > > > > >
> > > > > > > > -Prashant
> > > > > > > >
> > > > > > > > On Tue, Jan 18, 2022 at 11:49 AM Prashant Malani <pmalani@c=
hromium.org> wrote:
> > > > > > > > >
> > > > > > > > > Hi Benson and Alyssa,
> > > > > > > > >
> > > > > > > > > On Tue, Jan 18, 2022 at 11:33 AM Benson Leung <bleung@goo=
gle.com> wrote:
> > > > > > > > > >
> > > > > > > > > > Hi Alyssa,
> > > > > > > > > >
> > > > > > > > > > Thanks for reaching out.
> > > > > > > > > >
> > > > > > > > > > On Tue, Jan 18, 2022 at 04:37:54PM +0000, Alyssa Ross w=
rote:
> > > > > > > > > > > My distribution recently enabled the Chrome OS EC Typ=
e C control driver
> > > > > > > > > > > in its kernel builds.  On my Google Pixelbook i7 (eve=
), the driver reports
> > > > > > > > > > > a null pointer dereference at boot.  From what I can =
tell, this happens
> > > > > > > > > > > because typec->ec is set to NULL in cros_typec_probe.=
  Other drivers,
> > > > > > > > > > > like cros-usbpd-notify, appear to be set up to handle=
 this case.  As a
> > > > > > > > > > > result of this bug, I'm no longer able to reboot my c=
omputer, because
> > > > > > > > > > > udevd hangs while trying to do something with the dev=
ice whose driver
> > > > > > > > > > > isn't working.
> > > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > I've copied Prashant, who's the author of the typec dri=
ver as well as
> > > > > > > > > > cros-usbpd-notify.
> > > > > > > > > >
> > > > > > > > > > Prashant, any thoughts on a more graceful failure out o=
f the typec driver's
> > > > > > > > > > probe in case there's no ec object?
> > > > > > > > >
> > > > > > > > > We can add a NULL check and just abort the driver probe i=
f the pointer is
> > > > > > > > > not valid (the driver is useless without that pointer any=
way).
> > > > > > > > >
> > > > > > > > > A note: The NULL check makes sense on older drivers like =
cros-usbpd-notify since
> > > > > > > > > they can exist in ACPI configurations where they are *not=
* embedded
> > > > > > > > > inside the GOOG0004
> > > > > > > > > EC device (on older Chromebooks). That is not the case fo=
r the EC Type C device.
> > > > > > > > >
> > > > > > > > > This raises another issue: the custom BIOS from Mr. Chrom=
ebox is
> > > > > > > > > likely not setting
> > > > > > > > > up the EC Type C ACPI (GOOG0014) device correctly; it *mu=
st* be
> > > > > > > > > embedded inside the overall
> > > > > > > > > EC device (GOOG0004). If this is not being done, then the=
 GOOG0014
> > > > > > > > > device should not
> > > > > > > > > be added to the ACPI tables at all.
> > > > > > > > >
> > > > > > > > > I would like to understand whether the above was intentio=
nal from the
> > > > > > > > > Mr. Chromebox BIOS developers;
> > > > > > > > > otherwise we are letting an incorrect ACPI configuration =
just fail
> > > > > > > > > with a probe error.
> > > > > > > > >
> > > > > > > > > Thanks,
> > > > > > > > >
> > > > > > > > > -Prashant
> > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > > Here's the full Oops.  I was able to reproduce the is=
sue with every
> > > > > > > > > > > kernel I tried, from 5.10 to mainline.
> > > > > > > > > > >
> > > > > > > > > > > cros-usbpd-notify-acpi GOOG0003:00: Couldn't get Chro=
me EC device pointer.
> > > > > > > > > > > input: Intel Virtual Buttons as /devices/pci0000:00/0=
000:00:1f.0/PNP0C09:00/INT33D6:00/input/input14
> > > > > > > > > > > BUG: kernel NULL pointer dereference, address: 000000=
00000000d8
> > > > > > > > > > > #PF: supervisor read access in kernel mode
> > > > > > > > > > > #PF: error_code(0x0000) - not-present page
> > > > > > > > > > > PGD 0 P4D 0
> > > > > > > > > > > Oops: 0000 [#1] SMP PTI
> > > > > > > > > > > CPU: 1 PID: 561 Comm: systemd-udevd Not tainted 5.15.=
12 #4
> > > > > > > > > > > Hardware name: Google Eve/Eve, BIOS MrChromebox-4.14 =
08/06/2021
> > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > Ah, here's the problem. It looks like this is a custom =
bios from Mr Chromebox,
> > > > > > > > > > so this is not a bios combination we validate at Google.
> > > > > > > > > >
> > > > > > > > > > Thank you for the report. We'll look into fixing this a=
nd marking the fix
> > > > > > > > > > for stable kernels so that it goes back to 5.10.
> > > > > > > > > >
> > > > > > > > > > Thanks,
> > > > > > > > > >
> > > > > > > > > > Benson
> > > > > > > > > >
> > > > > > > > > > > RIP: 0010:__mutex_lock+0x59/0x8c0
> > > > > > > > > > > Code: 53 48 89 cb 48 83 ec 70 89 75 9c be 3d 02 00 00=
 4c 89 45 90 e8 18 47 33 ff e8 e3 e2 ff ff 44 8b 35 a4 85 e8 02 45 85 f6 75=
 0a <4d> 3b 6d 68 0f 85 bf 07 00 00 65 ff 05 b6 5b 23 75 ff 75 90 4d 8d
> > > > > > > > > > > RSP: 0018:ffffb44580a4bb50 EFLAGS: 00010246
> > > > > > > > > > > RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000=
000000000001
> > > > > > > > > > > RDX: 0000000000000000 RSI: ffffffff8bf91320 RDI: ffff=
922cbba50e20
> > > > > > > > > > > RBP: ffffb44580a4bbf0 R08: 0000000000000000 R09: ffff=
922c5bac8140
> > > > > > > > > > > R10: ffffb44580a4bc10 R11: 0000000000000000 R12: 0000=
000000000000
> > > > > > > > > > > R13: 0000000000000070 R14: 0000000000000000 R15: 0000=
000000000001
> > > > > > > > > > > FS:  00007f55338d6b40(0000) GS:ffff922fae200000(0000)=
 knlGS:0000000000000000
> > > > > > > > > > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > > > > > > > > > CR2: 00000000000000d8 CR3: 000000011bbb2006 CR4: 0000=
0000003706e0
> > > > > > > > > > > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000=
000000000000
> > > > > > > > > > > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000=
000000000400
> > > > > > > > > > > Call Trace:
> > > > > > > > > > >  <TASK>
> > > > > > > > > > >  ? fs_reclaim_acquire+0x4d/0xd0
> > > > > > > > > > >  ? lock_is_held_type+0xaa/0x120
> > > > > > > > > > >  ? cros_ec_cmd_xfer_status+0x1f/0x110
> > > > > > > > > > >  ? lock_is_held_type+0xaa/0x120
> > > > > > > > > > >  ? cros_ec_cmd_xfer_status+0x1f/0x110
> > > > > > > > > > >  cros_ec_cmd_xfer_status+0x1f/0x110
> > > > > > > > > > >  cros_typec_ec_command+0x91/0x1c0 [cros_ec_typec]
> > > > > > > > > > >  cros_typec_probe+0x7f/0x5a8 [cros_ec_typec]
> > > > > > > > > > >  platform_probe+0x3f/0x90
> > > > > > > > > > >  really_probe+0x1f5/0x3f0
> > > > > > > > > > >  __driver_probe_device+0xfe/0x180
> > > > > > > > > > >  driver_probe_device+0x1e/0x90
> > > > > > > > > > >  __driver_attach+0xc4/0x1d0
> > > > > > > > > > >  ? __device_attach_driver+0xe0/0xe0
> > > > > > > > > > >  ? __device_attach_driver+0xe0/0xe0
> > > > > > > > > > >  bus_for_each_dev+0x67/0x90
> > > > > > > > > > >  bus_add_driver+0x12e/0x1f0
> > > > > > > > > > >  driver_register+0x8f/0xe0
> > > > > > > > > > >  ? 0xffffffffc04ec000
> > > > > > > > > > >  do_one_initcall+0x67/0x320
> > > > > > > > > > >  ? rcu_read_lock_sched_held+0x3f/0x80
> > > > > > > > > > >  ? trace_kmalloc+0x38/0xe0
> > > > > > > > > > >  ? kmem_cache_alloc_trace+0x17c/0x2b0
> > > > > > > > > > >  do_init_module+0x5c/0x270
> > > > > > > > > > >  __do_sys_finit_module+0x95/0xe0
> > > > > > > > > > >  do_syscall_64+0x3b/0x90
> > > > > > > > > > >  entry_SYSCALL_64_after_hwframe+0x44/0xae
> > > > > > > > > > > RIP: 0033:0x7f55344b1f3d
> > > > > > > > > > > Code: 5b 41 5c c3 66 0f 1f 84 00 00 00 00 00 f3 0f 1e=
 fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f=
 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d bb ee 0e 00 f7 d8 64 89 01 48
> > > > > > > > > > > RSP: 002b:00007fff187f1388 EFLAGS: 00000246 ORIG_RAX:=
 0000000000000139
> > > > > > > > > > > RAX: ffffffffffffffda RBX: 000055a53acbe6e0 RCX: 0000=
7f55344b1f3d
> > > > > > > > > > > RDX: 0000000000000000 RSI: 00007f553461732c RDI: 0000=
00000000000e
> > > > > > > > > > > RBP: 0000000000020000 R08: 0000000000000000 R09: 0000=
000000000002
> > > > > > > > > > > R10: 000000000000000e R11: 0000000000000246 R12: 0000=
7f553461732c
> > > > > > > > > > > R13: 000055a53ad94010 R14: 0000000000000007 R15: 0000=
55a53ad95690
> > > > > > > > > > >  </TASK>
> > > > > > > > > > > Modules linked in: fjes(+) cros_ec_typec(+) typec int=
el_vbtn(+) cros_usbpd_notify sparse_keymap soc_button_array int3403_thermal=
 int340x_thermal_zone int3400_thermal acpi_thermal_rel cros_kbd_led_backlig=
ht zram ip_tables i915 hid_multitouch i2c_algo_bit ttm crct10dif_pclmul crc=
32_pclmul crc32c_intel drm_kms_helper nvme ghash_clmulni_intel sdhci_pci cq=
hci cec nvme_core sdhci serio_raw drm mmc_core i2c_hid_acpi i2c_hid video p=
inctrl_sunrisepoint fuse
> > > > > > > > > > > CR2: 00000000000000d8
> > > > > > > > > > > ---[ end trace 4a12c4896d70352b ]---
> > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > --
> > > > > > > > > > Benson Leung
> > > > > > > > > > Staff Software Engineer
> > > > > > > > > > Chrome OS Kernel
> > > > > > > > > > Google Inc.
> > > > > > > > > > bleung@google.com
> > > > > > > > > > Chromium OS Project
> > > > > > > > > > bleung@chromium.org

--5d3cgqzho6ik5ctz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEH9wgcxqlHM/ARR3h+dvtSFmyccAFAmHodWQACgkQ+dvtSFmy
ccCACA/+NcfWu0mMt0+0EJm4oJQVt/xbpmT98hAFw/6vqb7jFi87NbbGcmuc5kpm
3VBnQiBs5hWhiiugHmae7/nj2tqVm53vqBzi6YT/60PJzhLhhDi3XCUhGR1R6K0/
ZMgYaeW42689OTQ3kkYAu0gHiDM6OjwC7e7mY09LJW8vod6zidt04dLAoX95AJSs
rTIif0I0nID6YTg+BUEQNvhVY14cR/UoS8zaCE8oo+XzeuQSuqqcxG8vwvYvK8aX
/0N3N2Xbj7maLaPr4c3PMWVc3R8MjI3mJjRX3/QwY/H5EWBoIL430A1B+SYPp38U
UqjBs3ZZAvDtRL5frQPulOuVJlcgMwPrKqBaQRzo0jgZhNM8S0eeJUohZ6PtDmK+
XrN2zbwETUXOzEw2/n/aH4ISxrwayAsFD0imB2MbAgbavkbWVG1Ut4A2LIXhI3GD
LoljfPZmcnlxufy2G8WlG2XTtW0JMY+QhZUvPvo8rxLs+5utSx5YKxvfc86wWHNZ
opSqtn4paSGzp5R5xx+nsRVMVVnFowQdsHSHRmdVCri5POAsgR5oCLL2HowTkPG8
cESfa36cU5yj/+aJGqB+VTpw3EY1I6cmVFoxYJE5pULAVOY/ARRLgDwWaxs8sk+n
riPkJ4mvx+z2paYAlRJfOonrscgK5MippgPa7L1dAOSAQWvtLjc=
=V8lZ
-----END PGP SIGNATURE-----

--5d3cgqzho6ik5ctz--
