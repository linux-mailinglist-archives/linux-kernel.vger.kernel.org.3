Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76541472BB1
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 12:40:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236352AbhLMLko (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 06:40:44 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:33572 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231463AbhLMLkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 06:40:42 -0500
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1BD5StQO021923;
        Mon, 13 Dec 2021 05:40:33 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 references : in-reply-to : subject : date : message-id : mime-version :
 content-type : content-transfer-encoding; s=PODMain02222019;
 bh=AyJDsqK4TktiOaHc93I1NcIFPacc8LcRVfCNYLD2O7k=;
 b=HDfpfr0+/AVc9nGh3qru+D9pPm1nSCza8DzBZj3Zy6s7NBf3a2KI+S6YIaF+uqKcZHeb
 vI4pMLOyddWgW0QC9Be4p+RRljAGAY4iQayTJ7oMnn4Lr9JNV2e6lZm7t5jJtrqq2NdV
 XK4EC5Kx2gy3EU7dCaQZ2OOIN8qlYT75fITAng9ab4S96f+2LxH4mG+betKRMF9nWKuq
 qToVOr+O/wi/UpKo9Cx9BIdo53BXYZM+af4zF45DSX6qEmLu7hS9gQwaG1+ShUUuOYvh
 aFVqHt2e0GJ5txTyowyKecKO0Rob/K2VO0SlPD0TZYfQ4HoRutKug0cTnIFpwtrNXKW0 8g== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3cwc0bs810-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 13 Dec 2021 05:40:33 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Mon, 13 Dec
 2021 11:40:31 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Mon, 13 Dec 2021 11:40:31 +0000
Received: from LONN2DGDQ73 (unknown [198.90.238.114])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id D027AB13;
        Mon, 13 Dec 2021 11:40:30 +0000 (UTC)
From:   Stefan Binding <sbinding@opensource.cirrus.com>
To:     'Hans de Goede' <hdegoede@redhat.com>,
        'Mark Brown' <broonie@kernel.org>,
        "'Rafael J . Wysocki'" <rafael@kernel.org>,
        'Len Brown' <lenb@kernel.org>,
        'Mark Gross' <markgross@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>,
        <patches@opensource.cirrus.com>
References: <20211210154050.3713-1-sbinding@opensource.cirrus.com> <8160a1c8-544d-6d95-4f80-224c7a9a9d40@redhat.com>
In-Reply-To: <8160a1c8-544d-6d95-4f80-224c7a9a9d40@redhat.com>
Subject: RE: [PATCH v2 0/6] Support Spi in i2c-multi-instantiate driver
Date:   Mon, 13 Dec 2021 11:40:30 +0000
Message-ID: <002401d7f016$3bb4f260$b31ed720$@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-gb
Thread-Index: AQHKVo1VqSuCeo4owGzltFIRzsdrTwLFQoXGrDVIrYA=
X-Proofpoint-ORIG-GUID: Ap_HBtL1SbmuCLSLjWcTDUoGQGP6jXpD
X-Proofpoint-GUID: Ap_HBtL1SbmuCLSLjWcTDUoGQGP6jXpD
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> -----Original Message-----
> From: Hans de Goede <hdegoede@redhat.com>
> Sent: 10 December 2021 16:55
> To: Stefan Binding <sbinding@opensource.cirrus.com>; Mark Brown
> <broonie@kernel.org>; Rafael J . Wysocki <rafael@kernel.org>; Len =
Brown
> <lenb@kernel.org>; Mark Gross <markgross@kernel.org>
> Cc: linux-kernel@vger.kernel.org; linux-spi@vger.kernel.org; linux-
> acpi@vger.kernel.org; platform-driver-x86@vger.kernel.org;
> patches@opensource.cirrus.com
> Subject: Re: [PATCH v2 0/6] Support Spi in i2c-multi-instantiate =
driver
>=20
> Hi Stefan,
>=20
> On 12/10/21 16:40, Stefan Binding wrote:
> > Add support for SPI bus in the ic2-multi-instantiate driver as
> > upcoming laptops will need to multi instantiate SPI devices from a
> > single device node, which has multiple SpiSerialBus entries at the
> > ACPI table.
> >
> > With the new SPI support, i2c-multi-instantiate becomes
> > bus-multi-instantiate and is moved to the ACPI folder.
> >
> > The intention is to support the SPI bus by re-using the current I2C
> > multi instantiate, instead of creating a new SPI multi instantiate, =
to
> > make it possible for peripherals that can be controlled by I2C or =
SPI
> > to have the same HID at the ACPI table.
> >
> > The new driver (Bus multi instantiate, bmi) checks for the =
hard-coded
> > bus type and returns -ENODEV in case of zero devices found for that
> > bus. In the case of automatic bus detection, the driver will give
> > preference to I2C.
> >
> > The expectation is for a device node in the ACPI table to have
> > multiple I2cSerialBus only or multiple SpiSerialBus only, not a mix =
of
> > both; and for the case where there are both entries in one device
> > node, only the I2C ones would be probed.
> >
> > This new bus multi instantiate will be used in CS35L41 HDA new =
driver,
> > being upstreamed:
> > https://lkml.org/lkml/2021/11/23/723
>=20
> Unfortunately you never really answered my questions about v1 of this
> series:
>=20
> https://lore.kernel.org/platform-driver-x86/a1f546c2-5c63-573a-c032-
> 603c792f3f7c@redhat.com/
>=20
> So looking at the linked CS35L41 HDA series there is a single ACPI =
device node
> with a HID of CLSA0100 which describes two CS35L41 amplifiers =
connected
> over I2C ?

Yes, the related series uses HID CLSA0100, which contains 2 I2C devices =
inside a
single node. This ID was mistakenly used for this laptop, and instead =
CSC3551=20
has been used for subsequent laptops.

>=20
> I assume you are doing this work because there are also designs where =
there
> is a similar CLSA0100 ACPI device which also describes two CS35L41 =
amplifiers
> but then connected over SPI ?

Yes, there are several laptop designs which use an equivalent ACPI which =
describes
2 or 4 CS35L41 amplifiers which are connected either via I2C or via SPI.
Both designs use the same ACPI design and have 2-4 devices (either I2C =
or SPI)
defined inside a single ACPI node for HID CSC3551.
Note that the devices inside the node can be either SPI or I2C, but =
never SPI
and I2C.

>=20
> It would really help if you can:
>=20
> 1. Answer my questions from v1

I hope my colleague Lucas has answered these questions now.

> 2. Provide a concrete example of a device where these changes will be
> necessary to make things work, preferably with a link to an actual =
ACPI DSDT
> of that device.

This is the CSC3551 node for a laptop with 4 SPI nodes, with a shared =
IRQ:

 Scope (_SB.PC00.SPI0)
    {
        Device (GSPK)
        {
            Name (_HID, "CSC3551")  // _HID: Hardware ID
            Method (AUID, 0, NotSerialized)
            {
                Return ("103C89C3")
            }

            Method (_SUB, 0, NotSerialized)  // _SUB: Subsystem ID
            {
                Return (AUID ())
            }

            Name (_UID, One)  // _UID: Unique ID
            Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource =
Settings
            {
                Name (RBUF, ResourceTemplate ()
                {
                    SpiSerialBusV2 (0x0000, PolarityLow, FourWireMode, =
0x08,
                        ControllerInitiated, 0x003D0900, =
ClockPolarityLow,
                        ClockPhaseFirst, "\\_SB.PC00.SPI0",
                        0x00, ResourceConsumer, , Exclusive,
                        )
                    SpiSerialBusV2 (0x0001, PolarityLow, FourWireMode, =
0x08,
                        ControllerInitiated, 0x003D0900, =
ClockPolarityLow,
                        ClockPhaseFirst, "\\_SB.PC00.SPI0",
                        0x00, ResourceConsumer, , Exclusive,
                        )
                    SpiSerialBusV2 (0x0002, PolarityLow, FourWireMode, =
0x08,
                        ControllerInitiated, 0x003D0900, =
ClockPolarityLow,
                        ClockPhaseFirst, "\\_SB.PC00.SPI0",
                        0x00, ResourceConsumer, , Exclusive,
                        )
                    SpiSerialBusV2 (0x0003, PolarityLow, FourWireMode, =
0x08,
                        ControllerInitiated, 0x003D0900, =
ClockPolarityLow,
                        ClockPhaseFirst, "\\_SB.PC00.SPI0",
                        0x00, ResourceConsumer, , Exclusive,
                        )
                    GpioIo (Exclusive, PullUp, 0x0000, 0x0000, =
IoRestrictionOutputOnly,
                        "\\_SB.GPI0", 0x00, ResourceConsumer, ,
                        )
                        {   // Pin list
                            0x0000
                        }
                    GpioIo (Exclusive, PullUp, 0x0000, 0x0000, =
IoRestrictionOutputOnly,
                        "\\_SB.GPI0", 0x00, ResourceConsumer, ,
                        )
                        {   // Pin list
                            0x0000
                        }
                    GpioIo (Exclusive, PullUp, 0x0000, 0x0000, =
IoRestrictionOutputOnly,
                        "\\_SB.GPI0", 0x00, ResourceConsumer, ,
                        )
                        {   // Pin list
                            0x0000
                        }
                    GpioIo (Exclusive, PullDown, 0x0000, 0x0000, =
IoRestrictionOutputOnly,
                        "\\_SB.GPI0", 0x00, ResourceConsumer, ,
                        )
                        {   // Pin list
                            0x0000
                        }
                    GpioIo (Shared, PullUp, 0x0064, 0x0000, =
IoRestrictionInputOnly,
                        "\\_SB.GPI0", 0x00, ResourceConsumer, ,
                        )
                        {   // Pin list
                            0x0000
                        }
                    GpioInt (Edge, ActiveBoth, Shared, PullUp, 0x0064,
                        "\\_SB.GPI0", 0x00, ResourceConsumer, ,
                        )
                        {   // Pin list
                            0x0000
                        }
                })
                CreateWordField (RBUF, 0xCA, ACS1)
                CreateWordField (RBUF, 0xA7, ACS2)
                CreateWordField (RBUF, 0xED, ACS3)
                CreateWordField (RBUF, 0x0110, ARST)
                CreateWordField (RBUF, 0x0133, AINT)
                CreateWordField (RBUF, 0x0156, AIN2)
                ACS1 =3D GNUM (0x090E0016)
                ACS2 =3D GNUM (0x090E0017)
                ACS3 =3D GNUM (0x090C0006)
                ARST =3D GNUM (0x09070017)
                AINT =3D GNUM (0x09070013)
                AIN2 =3D GNUM (0x09070013)
                Return (RBUF) /* \_SB_.PC00.SPI0.GSPK._CRS.RBUF */
            }

            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                Return (0x0F)
            }

            Method (_DIS, 0, NotSerialized)  // _DIS: Disable Device
            {
            }
            Name (_DSD, Package ()  // _DSD: Device-Specific Data
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* =
Device Properties for _DSD */,
                Package ()
                {
                    Package () { "cirrus,dev-index", Package () { 0, 1, =
2, 3 } },
                    Package ()
                    {
                        "reset-gpios", Package ()
                        {
                            ^GSPK, 3, 0, 0,
                            ^GSPK, 3, 0, 0,
                            ^GSPK, 3, 0, 0,
                            ^GSPK, 3, 0, 0,
                        },
                    },
                    Package () { "cirrus,speaker-position",     Package =
() { 1, 0, 1, 0 } },
                    Package () { "cirrus,gpio1-func",           Package =
() { 3, 3, 3, 3 } },
                    Package () { "cirrus,gpio2-func",           Package =
() { 2, 2, 2, 2 } },
                    Package () { "cirrus,boost-ind-nanohenry",  Package =
() { 1000, 1000, 1000, 1000 } },
                    Package () { "cirrus,boost-peak-milliamp",  Package =
() { 4500, 4500, 4500, 4500 } },
                    Package () { "cirrus,boost-cap-microfarad", Package =
() { 24, 24, 24, 24 } },
                }
            })
        }
    }

This is just our node from the DSDT, we are working to obtain and share =
the full DSDT, if still required.

>=20
> Until you can better clarify why this is necessary, this series gets a =
nack from
> me. The i2c-mult-instantiate code is a hack to deal with some rather =
sub-
> optimal choices made in DSDTs used on devices shipped with Windows and
> unless absolutely necessary I would rather not see this get expanded =
to SPI.
>=20
> Regards,
>=20
> Hans

Thanks,

Stefan


