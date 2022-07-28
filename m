Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50272583AF5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 11:07:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235388AbiG1JHI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 05:07:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234498AbiG1JHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 05:07:06 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BA84550A1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 02:07:02 -0700 (PDT)
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 19FED3F139
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 09:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1658999220;
        bh=o//0J/rFHiNnqttRw+SylsLKNgE8xkBj7uOZ2eW9hjI=;
        h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=ZCnJWEKfd+8xEbVnwCqtMKEZ+QvXVgxf2JYOLXPoZBUrmT0YoecuQXynl6FS1V2lg
         obdJZ3iAHxJ+6tzgcvlCRLzwp7XGw86V4G4mV0kv4yyoO/0+GX2/KHcuzRPsqYwUWo
         5OT/VeF9jfADlHvdvrpT0wE+kgUyjiudv1UKTPz0JvoFLRCva89c2jv+X6fqUpcwI4
         QNIlYdqjBlaq6nX7JiQDjblYPeAKKQSVroaETwBkrPzeJ4ih0PrCttoc6alm53HuSw
         fQ9IzkCqyfIefLb7v4BuIJYVEyHMqpP/IInTnIw/xTgLSvgYi1F93G0meKC+RMjZw0
         uft/CvngGpp2Q==
Received: by mail-ed1-f70.google.com with SMTP id m20-20020a056402431400b0043be03aa310so706626edc.23
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 02:07:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:organization:references:in-reply-to:message-id:subject
         :cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=o//0J/rFHiNnqttRw+SylsLKNgE8xkBj7uOZ2eW9hjI=;
        b=5olJE2ENXhIdCr+jmPOLmKz+kpAiVGtpFTQILCC51WmQok+qnx5nUn8JtgTNTzuQOb
         4GEIodf8LxbOAen2ba8ygkb47BOk5lH7gcyVM7vvsAtl1gszE5twvojBKRfsFQV2kvgY
         bUTXjjaNd5E/uJBYCLo2jdZ1SyYNW2lWbuWtGadAU7OTTGCDYuVbgYdC9eEmm9MXYHK3
         UQKMHI82eTKup5q4qVh2o4WD0aR0uvdP2gDG6i0fs0/GryKuCNECd0L5GNG6uKyCaMy7
         ioSEpXzCHP7RNa6SXnOrZsszmaP9Gn6SMrhC4CQAKchSuH9jDugDWa6ZdUCTwZtECsbg
         TItg==
X-Gm-Message-State: AJIora8qA+P0j/RGnYAQBTjCA5Kl4IjGTi7lFpI3qf+17z79TQN/g/bR
        4L0v57dY6H9VeZ9gAdjeDLL/hKkpXB3c0QGWLR1zgnin7aVLe8XUyvRpLkvUK4buXt9RHpIYNrJ
        9QBWkaL0bOj/EcC0J3TH++GUPOcxldR8ZTC6CrF6ZHg==
X-Received: by 2002:a17:907:2cca:b0:72b:4188:f95b with SMTP id hg10-20020a1709072cca00b0072b4188f95bmr20876603ejc.153.1658999219246;
        Thu, 28 Jul 2022 02:06:59 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uXGjRAGeQQE87hxFqJHsLbeWyOTab0clfdZhMxDR+EPfgB/vTnnU26UDwkNtC2bYI2jWW5eg==
X-Received: by 2002:a17:907:2cca:b0:72b:4188:f95b with SMTP id hg10-20020a1709072cca00b0072b4188f95bmr20876580ejc.153.1658999218703;
        Thu, 28 Jul 2022 02:06:58 -0700 (PDT)
Received: from gollum ([194.191.244.86])
        by smtp.gmail.com with ESMTPSA id j13-20020a170906410d00b0072af0b036f3sm187789ejk.41.2022.07.28.02.06.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 02:06:57 -0700 (PDT)
Date:   Thu, 28 Jul 2022 11:06:53 +0200
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Robin Murphy <robin.murphy@arm.com>, stefan.wahren@i2se.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Robin Murphy <robin.murphy@arm.con>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org
Subject: Re: bcm2711_thermal: Kernel panic - not syncing: Asynchronous
 SError Interrupt
Message-ID: <20220728103513.38e93fa9@gollum>
In-Reply-To: <f309790a-a41b-cb2d-811e-51dc08154c04@gmail.com>
References: <20210210114829.2915de78@gollum>
 <6d9ca41b4ad2225db102da654d38bc61f6c1c111.camel@suse.de>
 <35e17dc9-c88d-582f-607d-1d90b20868fa@arm.com>
 <c6774af169854dc1d4efa272b439e80cea8cd8ff.camel@suse.de>
 <6612b35f-86bb-bb1e-bae8-188366495dbe@gmail.com>
 <20220727100510.4723ec84@smeagol>
 <f309790a-a41b-cb2d-811e-51dc08154c04@gmail.com>
Organization: Canonical Ltd
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/gg=cdQaozDLXr0EmOin=E5P";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/gg=cdQaozDLXr0EmOin=E5P
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 27 Jul 2022 14:51:24 -0700
Florian Fainelli <f.fainelli@gmail.com> wrote:

> On 7/27/22 01:05, Juerg Haefliger wrote:
> > On Wed, 10 Feb 2021 14:59:45 -0800
> > Florian Fainelli <f.fainelli@gmail.com> wrote:
> >  =20
> >> On 2/10/2021 8:55 AM, Nicolas Saenz Julienne wrote: =20
> >>> Hi Robin,
> >>>
> >>> On Wed, 2021-02-10 at 16:25 +0000, Robin Murphy wrote:   =20
> >>>> On 2021-02-10 13:15, Nicolas Saenz Julienne wrote:   =20
> >>>>> [ Add Robin, Catalin and Florian in case they want to chime in ]
> >>>>>
> >>>>> Hi Juerg, thanks for the report!
> >>>>>
> >>>>> On Wed, 2021-02-10 at 11:48 +0100, Juerg Haefliger wrote:   =20
> >>>>>> Trying to dump the BCM2711 registers kills the kernel:
> >>>>>>
> >>>>>> # cat /sys/kernel/debug/regmap/dummy-avs-monitor\@fd5d2000/range
> >>>>>> 0-efc
> >>>>>> # cat /sys/kernel/debug/regmap/dummy-avs-monitor\@fd5d2000/registe=
rs
> >>>>>>
> >>>>>> [   62.857661] SError Interrupt on CPU1, code 0xbf000002 -- SError=
   =20
> >>>>>
> >>>>> So ESR's IDS (bit 24) is set, which means it's an 'Implementation D=
efined
> >>>>> SError,' hence IIUC the rest of the error code is meaningless to an=
yone outside
> >>>>> of Broadcom/RPi.   =20
> >>>>
> >>>> It's imp-def from the architecture's PoV, but the implementation in =
this=20
> >>>> case is Cortex-A72, where 0x000002 means an attributable, containabl=
e=20
> >>>> Slave Error:
> >>>>
> >>>> https://developer.arm.com/documentation/100095/0003/system-control/a=
arch64-register-descriptions/exception-syndrome-register--el1-and-el3?lang=
=3Den
> >>>>
> >>>> In other words, the thing at the other end of an interconnect=20
> >>>> transaction said "no" :)
> >>>>
> >>>> (The fact that Cortex-A72 gets too far ahead of itself to take it as=
 a=20
> >>>> synchronous external abort is a mild annoyance, but hey...)   =20
> >>>
> >>> Thanks for both your clarifications! Reading arm documentation is a s=
kill on
> >>> its own.   =20
> >>
> >> Yes it is.
> >> =20
> >>>    =20
> >>>>> The regmap is created through the following syscon device:
> >>>>>
> >>>>> 	avs_monitor: avs-monitor@7d5d2000 {
> >>>>> 		compatible =3D "brcm,bcm2711-avs-monitor",
> >>>>> 			     "syscon", "simple-mfd";
> >>>>> 		reg =3D <0x7d5d2000 0xf00>;
> >>>>>
> >>>>> 		thermal: thermal {
> >>>>> 			compatible =3D "brcm,bcm2711-thermal";
> >>>>> 			#thermal-sensor-cells =3D <0>;
> >>>>> 		};
> >>>>> 	};
> >>>>>
> >>>>> I've done some tests with devmem, and the whole <0x7d5d2000 0xf00> =
range is
> >>>>> full of addresses that trigger this same error. Also note that as p=
er Florian's
> >>>>> comments[1]: "AVS_RO_REGISTERS_0: 0x7d5d2200 - 0x7d5d22e3." But fro=
m what I can
> >>>>> tell, at least 0x7d5d22b0 seems to be faulty too.
> >>>>>
> >>>>> Any ideas/comments? My guess is that those addresses are marked som=
ehow as
> >>>>> secure, and only for VC4 to access (VC4 is RPi4's co-processor). Ul=
timately,
> >>>>> the solution is to narrow the register range exposed by avs-monitor=
 to whatever
> >>>>> bcm2711-thermal needs (which is ATM a single 32bit register).   =20
> >>>>
> >>>> When a peripheral decodes a region of address space, nobody says it =
has=20
> >>>> to accept accesses to *every* address in that space; registers may b=
e=20
> >>>> sparsely populated, and although some devices might be "nice" and ma=
ke=20
> >>>> unused areas behave as RAZ/WI, others may throw slave errors if you =
poke=20
> >>>> at the wrong places. As you note, in a TrustZone-aware device some=20
> >>>> registers may only exist in one or other of the Secure/Non-Secure=20
> >>>> address spaces.
> >>>>
> >>>> Even when there is a defined register at a given address, it still=20
> >>>> doesn't necessarily accept all possible types of access; it wouldn't=
 be=20
> >>>> particularly friendly, but a device *could* have, say, some register=
s=20
> >>>> that support 32-bit accesses and others that only support 16-bit=20
> >>>> accesses, and thus throw slave errors if you do the wrong thing in t=
he=20
> >>>> wrong place.
> >>>>
> >>>> It really all depends on the device itself.   =20
> >>>
> >>> All in all, assuming there is no special device quirk to apply, the f=
eeling I'm
> >>> getting is to just let the error be. As you hint, firmware has no bla=
me here,
> >>> and debugfs is a 'best effort, zero guarantees' interface after all. =
  =20
> >>
> >> We should probably fill a regmap_access_table to deny reading registers
> >> for which there is no address decoding and possibly another one to deny
> >> writing to the read-only registers. =20
> >=20
> >=20
> > Below is a patch that adds a read access table but it seems wrong to in=
clude
> > 'internal.h' and add the table in the thermal driver. Shouldn't this ha=
ppen
> > in a higher layer, somehow between syscon and the thermal node? =20
>=20
> What is the purpose of doing doing this though that cannot already be don=
e using devmem/devmem2 if the point is explore the address space?

The goal is to prevent a kernel crash when doing
$ cat /sys/kernel/debug/regmap/dummy-avs-monitor\@fd5d2000/registers

...Juerg

--Sig_/gg=cdQaozDLXr0EmOin=E5P
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEhZfU96IuprviLdeLD9OLCQumQrcFAmLiUa0ACgkQD9OLCQum
QrfwCw//ZkKuqE9VxttN2czCLKeZ3LGIxVup3J4kF3toAJUygwN6P/k9wBHQnlf1
Pf4I9LJ1rpGe6FjIWLwzGXqo1eiPifd2mM56Fzf4hfdNaRen1TOCkdvmDlDGyb+S
8siFH43Ld/q9FxZpDb8FS+3oZh9OjC1wHZO2CyKQe6E2qsTkltOkdmkYfu5p0KCR
3AIWbPmTPCkYUp5xx/KxwcaIYIvVOsYrPvH305EFYUaQY8Jn/Zi6uWz5hd4YaT5R
8bqI3oHAD8eS4TbC8J0wO8s3u7k7vraW6bk+p0pvEcnlwtJUX4Kvp0Vv/g455FGs
pA+X1oijLh5QVzk2/G46wJQKmzv4jS+mB75c5oaU0vDZnELqE2raHWupYJmis3LL
NOkc7bE1FqBMQH91WRyPuvKubX+OqKDtCONAE3BwfUmyHuG3hXd3dyRpJI50S6l3
kH3uj5+QQPMHKzmHQUo7a7krcP2UQuI1z8jG0hJWZaOL89Av3S+vlLg7qlvp0qzZ
iSnVzlACeaexyK2M+jhm4Sf1K5ZHnrX6YJ7TAH9jZXpyQES3VI7o90SYFgvbn4Ry
ZM4fSIGLKhe8c+DtaidstZWRl/Hasn2Uek7BoilymKEAF8YSSMXU9buyg3uhuay5
0PPssXcJheirCTWhVck4u8vH1mZkmJwZ1aQ+lmfTLxQFugLHtUI=
=PR7p
-----END PGP SIGNATURE-----

--Sig_/gg=cdQaozDLXr0EmOin=E5P--
