Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F59C488F88
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 06:17:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238662AbiAJFRe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 00:17:34 -0500
Received: from mail-bn8nam11on2076.outbound.protection.outlook.com ([40.107.236.76]:25697
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238633AbiAJFRa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 00:17:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U9zvXLN3AJJM6ncOxBojaSYAECmKYpoZDcfTZn8psg+SPEoMrAjgn3XLxN5lO2iv1aEhtxHCgYf7qD7goBP4bk0Y/wBguUvl77iPQo2bFXHx5ArhsqAGxJmb+Esj4y4r1tBlt1iMfnjQ7oYfsPTwo1l84AqWYUKTa8u+QaOJWkqX5jI5RFnFZuOYJrEdWMJhnNQruy3q/KSfPP7Z6C94MTbyFKdN1J2XYHbmjxgJIwNxNHCTm73Rca75XEnv1OZqUWe6m8qIN4skHpnOFkQyGAYHWjY0svzgLC4RM8dLW3hr/Lr54KziSbBtIYSlvKpI0A3GNr8MTxVI1sGTLaVIcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tSj8yCeiU2q4yj3tR9DkoRoILFHCMxlRBUEU/a0i6Ik=;
 b=Wo1RaQ9AbPGAep1TYJ80Mm90kp+sia6UoAP85zoFCua0j0EP/DmVgM3W9ypmfuGTvhpgpHgUL/t4snVbxG//tXhVEoQO+0zrBlP5MapRvsrFP7CDKg0yvLlHGGEMNkSz0bd/QvSsHb8wesj21hsRw9xkYU+Pkaskdnp7fk5aXwqtCuqBxvB6MGG0pbwzlhmEAdBg1Riq3ZTElCrRSjHThmlTGEjOf0sooN4zvFRx0ijeIhoD+vgAOiqmgX8AgpXD8GX08bK/1AcDb+UBpUixejmWsNGF2BxWAGa6w+kVZq0aDX/WKoe58k79pmt7Ui4WapPpwSTqLfQCmI9VnuUv8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tSj8yCeiU2q4yj3tR9DkoRoILFHCMxlRBUEU/a0i6Ik=;
 b=FsCKlS/iHM8iVpZh3ug8YP1z8nPRpHFMRnzuHsRR5D99B3TtXe3Nwvdhsr+Y5mDFxvDXUhRzfLjqeTe4hV/IMFjtcFMDNsdNV8Hr8exBqT9VihtXKhkLsGWCf1F1k1K4t52zifrmyCjLe6WgIQ3NCipwciLsb4pso5DHmw4PKvQ=
Received: from BY5PR02MB6916.namprd02.prod.outlook.com (2603:10b6:a03:234::18)
 by SJ0PR02MB7247.namprd02.prod.outlook.com (2603:10b6:a03:29b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Mon, 10 Jan
 2022 05:17:27 +0000
Received: from BY5PR02MB6916.namprd02.prod.outlook.com
 ([fe80::d9bd:e183:6827:b40d]) by BY5PR02MB6916.namprd02.prod.outlook.com
 ([fe80::d9bd:e183:6827:b40d%5]) with mapi id 15.20.4867.012; Mon, 10 Jan 2022
 05:17:26 +0000
From:   Anand Ashok Dumbre <ANANDASH@xilinx.com>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        git <git@xilinx.com>, Michal Simek <michals@xilinx.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "heikki.krogerus@linux.intel.com" <heikki.krogerus@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        'Anand Dumbre' <ananddumbre8@gmail.com>
Subject: RE: [PATCH v12 0/5] Add Xilinx AMS Driver
Thread-Topic: [PATCH v12 0/5] Add Xilinx AMS Driver
Thread-Index: AQHX6IwflNA+ZWcGRkSBPHlmcIY+IKwzh/sQgAGJe4CAJt/eAA==
Date:   Mon, 10 Jan 2022 05:17:26 +0000
Message-ID: <BY5PR02MB6916F611A1B0511B814D840EA9509@BY5PR02MB6916.namprd02.prod.outlook.com>
References: <20211203212358.31444-1-anand.ashok.dumbre@xilinx.com>
        <BY5PR02MB691657682B94F4D3DBDA007EA9769@BY5PR02MB6916.namprd02.prod.outlook.com>
 <20211216113717.1c0e43dc@jic23-huawei>
In-Reply-To: <20211216113717.1c0e43dc@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=xilinx.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 49f6ec37-1393-4276-adab-08d9d3f87e07
x-ms-traffictypediagnostic: SJ0PR02MB7247:EE_
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-microsoft-antispam-prvs: <SJ0PR02MB7247195B660F1246D4D5279FA9509@SJ0PR02MB7247.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AVXo2uU6oV3xIR7Jcnx1DlLaJL4ZamBgA4MiGjocy65ykZg5jxxFSKVXSbdLOcI+81uO2VJAxlk8yl7faZDTESn6uI37Rvh/g71wQjQZfjevQr7s/MYdy9A0xb3obr+RkUxIo9jKjZ8t2ghmSuDcghte/rcRPxY79qFKr7qEsusZOIwbP8oiTSGKYQjdysIZMXPs44Gb8gWRvSIPBmPgJi7/06G6tpKvTWA9u0/P8heXmpETvZW2EjCbVkcZ2hjZLljLkY3Rht9VWza/zQ1HVTaY5RHiDf4nbophrDtsdJn9PPflAxab2tiE1LEfgv2JIud4uWig/Y4oWEoXL9WA4tCd2Dg2cSTV0OC7MWxztyGvXs9N5zi28iDvlg9ifj0mkqMyaK58u4aG8WE6T06T6aWfdvj80OnJ0Ykp5Oq+vas6ozC8aaikN+6O+VKsCLzBeobmjB9ov/0CsBRGQ+GbOq8KjJXn+YffNVnhFJ7CNKB9YsGxV7EAJQXSApwwsUuSCBoxZIsB3IwahHovhU60bbG4eJePGME2ra35o/cWQre0bm9wRl803xOy/A0Iyv/uSsbVw+tsDgqnCCaYOxs/XwC7bE3MBkmtruHIB2SHzdnBXdGrsgTepmd+gEblygIR8aHglwejF41yrHQvwsvwYsBW/4E9jNmKeUZwPHuTy0AY12Yqq1OywSeyGGMXBhnWtB6/WLlQvVtsVK7tU1k3gQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR02MB6916.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66556008)(6916009)(7416002)(38070700005)(66446008)(66946007)(316002)(76116006)(52536014)(38100700002)(66476007)(64756008)(86362001)(83380400001)(122000001)(33656002)(9686003)(4326008)(6506007)(53546011)(55016003)(54906003)(508600001)(26005)(5660300002)(186003)(71200400001)(8676002)(8936002)(2906002)(7696005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?o/u+Wsw1G/SdJ+MsS1X53A1N4RgwvbZwQ0bAL5PcCqAiHl+Gu1uOdrj6Hbdk?=
 =?us-ascii?Q?13F39BRYLqKH9I2rIeHqT9bn/9nxm7xupJrUa/533nzpOwFh0VJ4HNgc6qMf?=
 =?us-ascii?Q?1Az2Yn1NkQMAbeFYXpAboXfsaSnK0rGkJkbFgxgvXXAgFBeGSsRja6N7AMtl?=
 =?us-ascii?Q?ssGQidohHlTJXvDcTcIwtxUtizMHDqVIkBIhrJonXlxo4qEfihKlsi508Mdv?=
 =?us-ascii?Q?O6ztbrpFj0Wmyi8MtZQPt4Ui0gp+AsLwg76rTVIlv7HuoqKy9oyFC+VTsQPd?=
 =?us-ascii?Q?aVkJkL4djZPzRXSbRLhPpj2BfQN7KIlyL0ngqnUV1zGGctqF1s4XVAGgRd56?=
 =?us-ascii?Q?FJO0b5hCf0ZPNtCXYAqorybk23f+7NepYsFsZkgJmSlkszG6srjJSKL5Lb+c?=
 =?us-ascii?Q?6g7ilGAMRET4YDdm0m8fqNOjAQheBH07JcagWR3fb1ucyK2nsDoP+NJNhZOw?=
 =?us-ascii?Q?aM9ZqvClrCKi78Mn/PlYdpIRpTHZfEoYIWjnAq5gYMn0hTK9JtsjyrF1geWw?=
 =?us-ascii?Q?EehdH71v9MoRjIMhVmYP2EFX93tR6Vr1juu9Np1t7TFH9Z1PgwbxdNo9w3Df?=
 =?us-ascii?Q?7e2tJzsq7gtPLZJbfbg4f0x3TnvBX53Wru2SxzhYI/X8Fg1XlmslIDyb7zss?=
 =?us-ascii?Q?wSjK+DsrE41cEky/zmptM/vR4mTojti4zVxYRw2z4lCWtyfUgiM0IM/LaIk+?=
 =?us-ascii?Q?KsX9Lch+HjfcnYLZwfNj4LqfVm4fgN5zAle4F8LY6vD9hMGEEsRpc3Tzqjvd?=
 =?us-ascii?Q?mjLM2UkHxFjHQ1nYjvhyYPLXRw8F/EZLdzVKziRXrT9nurSuYQAHe4KOnl0y?=
 =?us-ascii?Q?z6GAhiLc1L0zgZUwYdiaUQwvRE/OwbEJ7Xqbhilcy6yknbHbnG3Uss2ADUTT?=
 =?us-ascii?Q?8slq5/vguBBdV4ZUKBCSyrHXWkh+Q5OSpLkGRQ3edmfmHU2P3MgfYf9aSWqw?=
 =?us-ascii?Q?x4SzC6CIs9zTpTGNsMdeFWOzV4bFcQn7C4BP9xzF8jt4y70o/zVUOsuDxYL5?=
 =?us-ascii?Q?HjHFBo0K1hQimDBewbr5WV21lek/BTdqnAD3F2PjwMySqNZJVu4IIXyq3zMl?=
 =?us-ascii?Q?st2STmWWb0vp6YTX3YAlvJvTUrYThbNILwvlkCI8AuQ3WS5dDmutsKXla4WD?=
 =?us-ascii?Q?Kye9wJFYtz7rhml7beSfYHSmTlULy2+93uN9vj45lEbnEWqdsZ4Zl3fKKDAm?=
 =?us-ascii?Q?D3TPszbIQzYcAW8eknJFWwXMY62SS3TTtAm1S3kBphQ/1wE/GFu6VDKjzncD?=
 =?us-ascii?Q?LE/5oc/+R7VczNbnfik/M0UYaMFTYup/i3VKM17aJyJzJD71hh++Up+rxvd/?=
 =?us-ascii?Q?FnWPpvM+INQySsPOkVWqkv4++JHfEj88EZA3rj1b8MEVGFLs0AxrSRw/LN87?=
 =?us-ascii?Q?4PzjUFIf91xAlXpDxgLS6tflS/y8GZVmY38rMg7gkO+CmzC74e0qgLliiWJK?=
 =?us-ascii?Q?3x8orBQQl5aA+Y628SYyb2BaBGTWkGewUy3S5vP63kYCtuttWAysDyKblerR?=
 =?us-ascii?Q?55xLnKZOP5imLrl2WBlBszMFWBS+Hjf7kE3rGCNfRSDdLAaJ+Lin96Nxsu8z?=
 =?us-ascii?Q?S33CIaPgmmwnjAQWvc3W9QLH5EorccuudsgoHKgYMIvI/GHJSUlpFwIVLKfN?=
 =?us-ascii?Q?6LjDUlygdbaZBz2Px4mTJHk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR02MB6916.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49f6ec37-1393-4276-adab-08d9d3f87e07
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2022 05:17:26.6905
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i6F+BPE+c78KTornXUXaFCJC6tYcx6kpvliL4p7CZp/eB3sY4Wey78EQUId0klTgmCCgiGM0gHTySyUsahj82g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7247
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Cameron,

I see in the patchwork that the patches have been accepted.=20
When can I expect to see the driver in mainline?

Thanks,
Anand

> -----Original Message-----
> From: Jonathan Cameron <jic23@kernel.org>
> Sent: Thursday 16 December 2021 5:07 PM
> To: Anand Ashok Dumbre <ANANDASH@xilinx.com>
> Cc: linux-kernel@vger.kernel.org; lars@metafoo.de; linux-
> iio@vger.kernel.org; git <git@xilinx.com>; Michal Simek
> <michals@xilinx.com>; gregkh@linuxfoundation.org; rafael@kernel.org;
> linux-acpi@vger.kernel.org; heikki.krogerus@linux.intel.com; Andy
> Shevchenko <andriy.shevchenko@linux.intel.com>; 'Anand Dumbre'
> <ananddumbre8@gmail.com>
> Subject: Re: [PATCH v12 0/5] Add Xilinx AMS Driver
>=20
> On Wed, 15 Dec 2021 12:11:21 +0000
> Anand Ashok Dumbre <ANANDASH@xilinx.com> wrote:
>=20
> > Ping!
>=20
> Other than ideally getting a few more eyes on the stuff in drivers/base I=
'm
> fine with this series.
>=20
> Thanks,
>=20
> Jonathan
>=20
> >
> > > -----Original Message-----
> > > From: Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
> > > Sent: Friday 3 December 2021 9:24 PM
> > > To: linux-kernel@vger.kernel.org; jic23@kernel.org; lars@metafoo.de;
> > > linux- iio@vger.kernel.org; git <git@xilinx.com>; Michal Simek
> > > <michals@xilinx.com>; gregkh@linuxfoundation.org; rafael@kernel.org;
> > > linux-acpi@vger.kernel.org; heikki.krogerus@linux.intel.com
> > > Cc: Anand Ashok Dumbre <ANANDASH@xilinx.com>
> > > Subject: [PATCH v12 0/5] Add Xilinx AMS Driver
> > >
> > > Add Xilinx AMS driver which is used for Xilinx's ZynqMP AMS controlle=
r.
> > > This AMS driver is used to report various interface voltages and
> > > temperatures across the system.
> > > This driver will be used by iio-hwmon to repport voltages and
> > > temperatures across the system by using various channel interfaces.
> > > This driver handles AMS module including PS-Sysmon & PL-Sysmon. The
> > > binding documentation is added for understanding of AMS, PS, PL
> > > Sysmon Channels.
> > >
> > > Changes in v2:
> > > 	- Added documentation for sysfs (Patch-2)
> > > 	- Addressed code style review comments
> > > 	- Patch-2 (Now it is Patch-3)
> > > 		- Arranged the includes in alphabetical order
> > > 		- Removed the wrapper 'ams_pl_write_reg()' and used writel
> > > 		  instead
> > > 		- Removed the unnecessary delay of 1ms and used polling of
> EOC
> > > 		  instead
> > > 		- Removed spin_lock and used mutex only.
> > > 		- Used request_irq() instead of devm_request_irq() and
> handled
> > > 		  respective error conditions
> > > 		- Moved contents of xilinx-ams.h to inline with xilinx-ams.c
> > > 	- Patch-1
> > > 		- Addressed Documentation style comments
> > >
> > > Changes in v3:
> > > 	- Updated bindings document with the suggested modification in v2
> > > review
> > > 	- Removed documentation for sysfs
> > > 	- Removed extended names for channels in the Xilinx AMS driver
> > > 	- Modified dts to use ranges for child nodes
> > > 	- Reduced address and size cells to 32-bit instead of 64-bit
> > >
> > > Changes in v4:
> > > 	- Updated bindings document with the suggested modification in v3
> > > review
> > > 	- Changed the Device Tree property 'ranges' for child nodes
> > > 	- Used Channel Numbers as 'reg' value in DT to avoid confusion
> > > 	- Removed unused NULL arguments as suggested in v3 patch review
> > > 	- Addressed comments on Device Tree property naming
> > >
> > > Changes in v5:
> > > 	- Updated bindings document to the YAML format
> > > 	- Updated bindings document with the suggested modification in v4
> > > review
> > > 	- Renamed iio_pl_info struct to iio_ams_info in Xilinx AMS driver
> > > 	- Updated the Xilinx AMS driver to not use iio_priv_to_dev function
> > > 	- Updated Xilinx AMS node to reflect the changes in bindings
> > > document
> > > 	- Update MAINTAINERS file
> > >
> > > Changes in v6:
> > > 	- Removed all tabs from bindings document.
> > > 	- Removed the xlnx,ext-channels node from the device tree since
> > > 	  it is not neeeded.
> > > 	- Fixed unit addresses for ps-ams and pl-ams.
> > > 	- Removed the names property from bindings.
> > > 	- Fixed warnings from checkpatch.pl in the driver.
> > > 	- devm_add_action_or_reset() used for exit/error path.
> > > 	- devm_request_irq() for managed irq request instead of
> > > 	  request_irq()
> > >
> > > Changes in v7:
> > > 	- Added use of FIELD_PREP and FIELD_GET.
> > > 	- Added the spinlocks back the v1 which were removed in v2 for
> > > 	  no justifiable reason and replaced with the same mutex. This
> > > 	  caused deadlocks.
> > > 	- Removed the buffered mode information from channel config.
> > > 	- Usage of wrapper functions for devm_add_action_or_reset
> > > 	  callbacks to avoid typecasting functions.
> > > 	- Usage of devm_platform_iremap_resource().
> > > 	- Handled platform_get_irq() return values.
> > > 	- Removed the remove() callback.
> > > 	- Fixed the dt-bindings.
> > >
> > > Changes in v8:
> > > 	- Replaced *_of_() APIs with fwnode.
> > > 	- Added missing headers.
> > > 	- Fixed documentation.
> > > 	- Added devm_add_action_or_reset() for iounmap.
> > > 	- Restructured read_raw function.
> > > 	- Added helper functions.
> > > 	- Usage of GENMASK for all masks.
> > > 	- Added defaults for most switch cases. Some can't be added
> > > 	  since the default will never occur.
> > >
> > > Changes in v9:
> > > 	- Added a fwnode_iomap().
> > > 	- Fixed Kconfig indentation.
> > > 	- Added the overflow checks before memory allocation.
> > > 	- Usage of fwnode_iomap() instead of iomap().
> > > 	- Rename ams_parse_dt() to ams_parse_firmware().
> > >
> > > Changes in v10:
> > > 	- Fixed licence in zynqmp.dtsi.
> > > 	- Changed the macros to use BIT().
> > > 	- Realign some code to fit within 100 chars.
> > > 	- Modified readl_poll_timeout usage.
> > > 	- Usage of array_size() instead of check_mul_overflow().
> > > 	- Usage of dev_err_probe() instead of dev_err().
> > > 	- Usage of kcalloc instead of kzalloc()
> > >
> > > Changes in v11:
> > > 	- Added missing bitfield.h.
> > > 	- Fixed AMS_ALARM_THR_MIN macro.
> > > 	- Added terminators to enums where necessary.
> > > 	- Added explicit values as suggested to enums.
> > > 	- Removed redundant macros.
> > > 	- Added delay value for readl_poll_timeout.
> > > 	- Corrected shadowed error return.
> > > 	- Corrected formatting errors.
> > > 	- Added default cases where missing.
> > > 	- Made ams_parse_firmware() a single parameter functions.
> > > 	- Usage of devm_kcalloc() and devm_krealloc().
> > > 	- Directly returning from dev_err_probe().
> > > 	- Renamed masked_alarm to current_masked_alarm.
> > >
> > > Changes in v12:
> > > 	- GENMASK_ULL usage for 64bit values.
> > > 	- Added ams_iounmap_ps and amsiomap_pl instead of generic
> > > 	  function.
> > > 	- Hex values to use all capital letters.
> > > 	- Fixed a case of wrong kernel doc.
> > > 	- Modified macro voltage names to reflect the scale.
> > > 	- Maximize single line usage wherever possible.
> > > 	- Handling of fwnode_iomap when CONFIG_OF_ADDRESS is not
> > > 	  enabled.
> > > 	- ams_read_raw() - Reduce the size of switch statements by
> > > 	  using helper functions for IIO_CHAN_INFO_SCALE.
> > > 	- ams_read_raw() - Mutex unlocking in a single place using goto.
> > >
> > > Anand Ashok Dumbre (5):
> > >   device property: Add fwnode_iomap()
> > >   arm64: zynqmp: DT: Add Xilinx AMS node
> > >   iio: adc: Add Xilinx AMS driver
> > >   dt-bindings: iio: adc: Add Xilinx AMS binding documentation
> > >   MAINTAINERS: Add maintainer for xilinx-ams
> > >
> > >  .../bindings/iio/adc/xlnx,zynqmp-ams.yaml     |  227 +++
> > >  MAINTAINERS                                   |    7 +
> > >  arch/arm64/boot/dts/xilinx/zynqmp.dtsi        |   24 +
> > >  drivers/base/property.c                       |   16 +
> > >  drivers/iio/adc/Kconfig                       |   15 +
> > >  drivers/iio/adc/Makefile                      |    1 +
> > >  drivers/iio/adc/xilinx-ams.c                  | 1450 +++++++++++++++=
++
> > >  include/linux/property.h                      |    2 +
> > >  8 files changed, 1742 insertions(+)  create mode 100644
> > > Documentation/devicetree/bindings/iio/adc/xlnx,zynqmp-ams.yaml
> > >  create mode 100644 drivers/iio/adc/xilinx-ams.c
> > >
> > > --
> > > 2.17.1
> >

