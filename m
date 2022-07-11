Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 184695705BB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 16:36:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231294AbiGKOgK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 10:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiGKOgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 10:36:09 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10E8365572;
        Mon, 11 Jul 2022 07:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1657550155;
        bh=DINkJDHugX/iLt6KCztwk/iCqEfBYvl9VubtRoa42D8=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=D+/HFeiCy9H/U5NDeue5bpHBQl1eLwEh4IP+WQHMoav1wuE0TfHQbLe4ZnNse0lcV
         FTbjWN3L8PSKvyh5yesXJGyW3v2VVpEccbI+9iB3uzYr9nVKFJRgzvZo13EF+VfDb8
         9zhFv4aqt4eHG4NXtoIAsNQ7wJMDD0+Hb9JuTKwU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from dyn3207-67.wlan.ic.ac.uk ([146.169.207.67]) by mail.gmx.net
 (mrgmx104 [212.227.17.174]) with ESMTPSA (Nemesis) id
 1M3lcJ-1oBjj60zGl-000pvJ; Mon, 11 Jul 2022 16:35:55 +0200
Message-ID: <0e8611ad73017bc204372f491ae5666dd60885a9.camel@gmx.co.uk>
Subject: Re: input/i8042: Malfunctioning brightness keys on HP Elite
 Dragonfly G2
From:   Alex Dewar <alex.dewar@gmx.co.uk>
To:     "Lopez, Jorge A (Security)" <jorge.lopez2@hp.com>,
        Hans de Goede <hdegoede@redhat.com>,
        "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        "tiwai@suse.de" <tiwai@suse.de>,
        "markgross@kernel.org" <markgross@kernel.org>
Cc:     "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>
Date:   Mon, 11 Jul 2022 15:35:54 +0100
In-Reply-To: <PH0PR84MB19536D04A5625D4DC8B76AF1A8879@PH0PR84MB1953.NAMPRD84.PROD.OUTLOOK.COM>
References: <20220629094314.b7xmfb3xccj7vs6v@ic-alex-elitebook>
         <3fedf676645bfa638c9a6c656121083abc2c98ea.camel@gmx.co.uk>
         <8b893c42-e514-bcef-0513-070b3723cdcc@redhat.com>
         <df7313597d2ac3212f10c05aa3d369728f030c86.camel@gmx.co.uk>
         <c89d39eb-17b9-8800-c8ff-8d236b80de2f@redhat.com>
         <PH0PR84MB195309F5BA5B96858024E61FA8879@PH0PR84MB1953.NAMPRD84.PROD.OUTLOOK.COM>
         <PH0PR84MB19536D04A5625D4DC8B76AF1A8879@PH0PR84MB1953.NAMPRD84.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.3 
MIME-Version: 1.0
X-Provags-ID: V03:K1:mkX6o6pK+J5SJpfHS+S0yxxYG4rQM1yv80MihpgYOG7DG2s9jLR
 4oj8TRtJNoz43lnEFet24YoCKMcNLvIR8W9hpupsRiY39fqH1JbJzNPYwOXYV5WVD0weAgD
 4GZlkwrsyk/4Saw7y7IsAgDfDAFlypUifv9hOdjdZJ8U/2fBQEmorwdPs6jPgXf6PDtGKxB
 B7tEx48ynC3P+IEqnRGpA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:hxHdsAnloPg=:5rf6qlNnaOM+88InnFoKPO
 LTLDqPIWWyXcdMTs0KOrbHDdzwLGgpHVwnxlLbDIyaiTXXFIPN7iROKxkxg+Lcp7ZMp3YUJZ2
 IG7f+VgcWQwk8u5nkvDhRqpFUeo6TmDRGmkS0JZF8jaTz5o3xBURw2jTqMXBf4LrNlOLp9pNh
 rcPhthfClqnSG7b8oKgp95mzHD+M1ykCwHyaIlQYqfYCCSDBvwnhFxwvxf+MHOlw3fycDqtVS
 gMW3aNQOiPOtOjUZwrvwN2a8cewZ9BdW69u70xi1H+VfcAXe2nSA6JmRwDntrb7MV56a67xsk
 ITcjFYUkIxfLVlUtMY7ZZa0WW+6VC8NzEgowiE+IMF8CWa4vBUL2rXUbIuqaqv9n0dO/Mv7uh
 9zDr+uTZKLzOnZK4WyojygwcH7diUXAdWH2GtKw0hXeAZOS5l93TgqpjFKoL4G2xS7P+Nmjw6
 yOXgZXGRaS3LiV67iwxOh/IoaIpR08nSO6kc67WSDy9cdlVYRoX397brKBjPEq7NXPlRhXOpB
 ANUhZzm7PgPN37PGXqaq8HyZHOEoGozSF6m6/JBCx9rB3Jy5XEzwogbSp/I/qHy5MY0+TgaG1
 hhMcjxgAkizI8aoWO6j6LvImdE+vAJrDhqwr5tOkK6H/e2qmrDnlVzF2vBo2xL5S+4TViaZT3
 n3xOgjW5Mh+yGbcvvevUAw43biUaKTo63srl64H3WLFE1uEaOSrLjNG2kKNsReYsx5qTdG9FE
 eRzhImRlqWtU8MzRf7vP8v3P0JRdRhBAhW/bAVIZcVUNxHoGS4rVGHpZLBGjC7dxH5u6ibTHJ
 bohAPVAUOog6Bf+wEnIq/VPKj0vLOL640HbTJ7Ta25Kd2Pgw3NiZ8UoqzTBUTyDLpgnO8I+9c
 oYrhthWLclSu4dATXxIdZRg2kXnp1sBVYfNqI1J/9bLK3aU2wuXfubYbAdnxf4T8tAArtxEMk
 zmOSZbg3aLEST0Z9MMuFK9Y19CCNI9z42yGta/aQAfCd5TJS74MgEMigs8zhopyQCeICCXDpV
 8DhjcAT22J4ClyNUAB+VRrOgV4VQRHMjx2kNkv7BA+7rhcXTZPDvFbtWNXmyaU4rGiyBlf85I
 daVPxtRq8aqpxkQyU1pXwbMg8MbfPhzi/m1u1Hyxi8sMz/pAalNvlTvew==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-07-11 at 14:26 +0000, Lopez, Jorge A (Security) wrote:
> Hi Alex,
>=20
> I confirmed brightness up/down and mute are AT translated set of keys
> and not handled by HP-WMI driver.
> BIOS should be sending an 0x4 event which keycode 224 (brightness
> up), 225 (brightness down), and 190 (microphone).
> Instead, BIOS is sending keycode 190 for all three keys.
>=20
> I will search for an Elite Dragonfly G2 unit and try to duplicate the
> problem.=C2=A0 Please send the BIOS version your system is running on.
> This problem could have been reported and fixed in the latest BIOS
> version.
>=20
> Look forward to hearing back from you.
>=20
>=20
> Regards,
>=20
> Jorge Lopez
> Hewlett-Packard=20
>=20
> =E2=80=9COnce you stop learning, you start dying=E2=80=9D
> Albert Einstein

Hi Jorge,

Thanks for looking into this =F0=9F=99=82

Here is my BIOS info:
Handle 0x0001, DMI type 0, 26 bytes
BIOS Information
        Vendor: HP
        Version: T90 Ver. 01.04.01
        Release Date: 06/01/2021
        Address: 0xF0000
        Runtime Size: 64 kB
        ROM Size: 32 MB
        Characteristics:
                PCI is supported
                PC Card (PCMCIA) is supported
                BIOS is upgradeable
                BIOS shadowing is allowed
                Boot from CD is supported
                Selectable boot is supported
                EDD is supported
                Print screen service is supported (int 5h)
                8042 keyboard services are supported (int 9h)
                Serial services are supported (int 14h)
                Printer services are supported (int 17h)
                ACPI is supported
                USB legacy is supported
                Smart battery is supported
                BIOS boot specification is supported
                Function key-initiated network boot is supported
                Targeted content distribution is supported
                UEFI is supported
        BIOS Revision: 4.1
        Firmware Revision: 55.29

I should maybe add that I think the keyboard was working fine when I
had Windows 10 running on this machine and I haven't updated the BIOS
since installing Linux.

In case it's relevant, I'm running Arch Linux with the following
kernel:
Linux ic-alex-elitebook 5.18.9-arch1-1 #1 SMP PREEMPT_DYNAMIC Sat, 02
Jul 2022 21:03:06 +0000 x86_64 GNU/Linux

Best,
Alex

>=20
> -----Original Message-----
> From: Lopez, Jorge A (Security)=20
> Sent: Monday, July 11, 2022 8:10 AM
> To: 'Hans de Goede' <hdegoede@redhat.com>; Alex Dewar
> <alex.dewar@gmx.co.uk>; dmitry.torokhov@gmail.com; tiwai@suse.de;
> markgross@kernel.org
> Cc: linux-input@vger.kernel.org; linux-kernel@vger.kernel.org;
> platform-driver-x86@vger.kernel.org
> Subject: RE: input/i8042: Malfunctioning brightness keys on HP Elite
> Dragonfly G2
>=20
> Hi Alex,
>=20
> Let me investigate this issue.=C2=A0 The driver maps some keys, so it is
> possible the list is incomplete.=C2=A0=20
> It is expected hp_wmi driver to be loaded, Correct?
> Can you provide the BIOS version current in your system?
>=20
>=20
> Regards,
>=20
> Jorge Lopez
> Hewlett-Packard=20
>=20
> =E2=80=9COnce you stop learning, you start dying=E2=80=9D
> Albert Einstein
>=20
> -----Original Message-----
> From: Hans de Goede <hdegoede@redhat.com>
> Sent: Monday, July 11, 2022 7:10 AM
> To: Alex Dewar <alex.dewar@gmx.co.uk>; dmitry.torokhov@gmail.com;
> tiwai@suse.de; markgross@kernel.org; Lopez, Jorge A (Security)
> <jorge.lopez2@hp.com>
> Cc: linux-input@vger.kernel.org; linux-kernel@vger.kernel.org;
> platform-driver-x86@vger.kernel.org
> Subject: Re: input/i8042: Malfunctioning brightness keys on HP Elite
> Dragonfly G2
>=20
> Hi Alex,
>=20
> On 7/11/22 09:49, Alex Dewar wrote:
> > Hi Hans,
> >=20
> > On Sat, 2022-07-09 at 16:56 +0200, Hans de Goede wrote:
> > > Hi,
> > >=20
> > > On 7/5/22 19:25, Alex Dewar wrote:
> > > > Friendly ping? =F0=9F=99=82
> > > >=20
> > > > I'm also CC'ing the x86 platform people into this, as I'm not
> > > > sure=20
> > > > whether this problem is something more within their remit.
> > >=20
> > > Please test the atbkd device with "sudo evemu-record" or "sudo=20
> > > evtest"
> > > and if the brightness keys generate events there, write down the
> > > raw=20
> > > event codes (MSC events).
> >=20
> > I tried this but unfortunately this doesn't seem to be the whole
> > story.
> > If I press "decrease brightness" I get:
> > Event: time 1657525393.922727, -------------- SYN_REPORT ----------
> > --
> > Event: time 1657525397.043348, type 4 (EV_MSC), code 4 (MSC_SCAN),=20
> > value 81
> > Event: time 1657525397.043348, type 1 (EV_KEY), code 190 (KEY_F20),
> > value 1
> > Event: time 1657525397.043348, -------------- SYN_REPORT ----------
> > --
> > Event: time 1657525397.050384, type 4 (EV_MSC), code 4 (MSC_SCAN),=20
> > value 81
> > Event: time 1657525397.050384, type 1 (EV_KEY), code 190 (KEY_F20),
> > value 0
> >=20
> > And if I press "increase brightness" I get:
> > Event: time 1657525397.050384, -------------- SYN_REPORT ----------
> > --
> > Event: time 1657525398.607184, type 4 (EV_MSC), code 4 (MSC_SCAN),=20
> > value 81
> > Event: time 1657525398.607184, type 1 (EV_KEY), code 190 (KEY_F20),
> > value 1
> > Event: time 1657525398.607184, -------------- SYN_REPORT ----------
> > --
> > Event: time 1657525398.614190, type 4 (EV_MSC), code 4 (MSC_SCAN),=20
> > value 81
> > Event: time 1657525398.614190, type 1 (EV_KEY), code 190 (KEY_F20),
> > value 0
> >=20
> > There's no difference! And I also get the same thing if I press the
> > *actual* mute mic button =F0=9F=98=9E.
> >=20
> > Any ideas?
>=20
> From this it looks like we need to use some other interface to get
> these events (+ ignore the above events).
>=20
> Do you have a "HP WMI hotkeys" device in your list of input devices?=C2=
=A0
> And are you getting any events on that ?
>=20
> Likewise do you have a "Video Bus" device and any events on that ?
>=20
> I've also added Jorge from HP to the Cc. Jorge, can you help with
> this ?
>=20
> Regards,
>=20
> Hans
>=20

