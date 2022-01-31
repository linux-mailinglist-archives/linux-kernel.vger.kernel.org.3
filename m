Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CD2D4A47C9
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 14:10:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378546AbiAaNJ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 08:09:57 -0500
Received: from mx0a-00549402.pphosted.com ([205.220.166.134]:6898 "EHLO
        mx0a-00549402.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1358817AbiAaNJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 08:09:55 -0500
X-Greylist: delayed 1478 seconds by postgrey-1.27 at vger.kernel.org; Mon, 31 Jan 2022 08:09:55 EST
Received: from pps.filterd (m0233778.ppops.net [127.0.0.1])
        by mx0b-00549402.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 20UMIlVf030161;
        Mon, 31 Jan 2022 12:44:51 GMT
Received: from deu01-fr2-obe.outbound.protection.outlook.com (mail-fr2deu01lp2173.outbound.protection.outlook.com [104.47.11.173])
        by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 3dvuxws2q8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Jan 2022 12:44:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fHoZt0u4tB4n9aipS5ccMmJZAwhXKpJAy7yIADobHaGnwl7nRHq4Yy6Nu9sdCjX+lqNz/tupxk5xy3K283sScsMx/tpfsZtULA05fyDX90eCrT0vEKoaZp1Xy/HaHKoh4f249amlUDi6PhIMqtLVhQ18Vadg49AcpEa4CDAJ3Q8OPFj05nM2vD0w9yKDITVSj3qzoxkNGI55ii490ORbG36+eRjPs4zkcfbtppq7AZTUrGodYbV3/Y1RAqz8p0ORFGtsrnfY8SHJUGK0pwNem9rRtY5DAwy/230JwANyCid0pGTKBcAU5oXpHzloXtDlV5o3etRLR9PTsR4c7aHIfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RxgURzKx2QJu4fG3Rm73vE4VcMiaDD+NCefYVOi9GFk=;
 b=QTsSYermb3HRZ/WuBhmrqB+WIGlZm2R/uXfCykWVP2IbQ8O2jnIgaHvrGmUjqmPPRuSRNVR50Cm0tdXg2qJBu59W84tFXvG7v4yRIr4FGr/G9r/ZIN2K6xWY+r3wtDjOkGMuIsEkV6tjksydrhgINYjToGljdVW2oi2kCxc0qKRHgK+Ci6xBHYyI0Mr5Wjeiavb6QAl96SIiHGkNqKRPlIsafDIqzSwv423EafNftg5R/jyvQS78YYWUP3w0ijzOFXWAMCfaO+vA7ZJQAw3hFPQY93FzD+375TTGfRt6H6rD3zEsEPq5jv0NNOLgY9RQLrdj9WkCrH7UpDPQMDMDAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RxgURzKx2QJu4fG3Rm73vE4VcMiaDD+NCefYVOi9GFk=;
 b=Inut3zDbj527VQBvwQutj3IIKU42nxhhFnXBBvUSg8wWv2c6TBSRpfysyZrMTvUFYLWtqUsCRNQbYNZrSk4BIRrqWsGgIR/OVkYlUaUk4l96bsQO3sAnmk+DFw+z1A56BI6Uw119SllPzXu79MGsUVIhaAJEUYt6y6Dgpy05d+pgf4R2NeGkDhGXZ/BIbJitohel5Jp6ueY7iZjPGz/EjwYFQefwWeO7PdYHlWlnyoPz3ZZWSeD6rpe3oCm0ALCprV1nEze0oveiZ1FrB45vGgbXJDsEABp5h1qR+CWPA0DTKr9M82+CxJ3/gL2mmvcoRdI1Y8ChNZX2Uf2IBzrQsg==
Received: from FR3P281MB0537.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:34::10)
 by FR2P281MB0902.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:65::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.6; Mon, 31 Jan
 2022 12:44:47 +0000
Received: from FR3P281MB0537.DEUP281.PROD.OUTLOOK.COM
 ([fe80::2040:6496:a1a1:21c4]) by FR3P281MB0537.DEUP281.PROD.OUTLOOK.COM
 ([fe80::2040:6496:a1a1:21c4%4]) with mapi id 15.20.4951.010; Mon, 31 Jan 2022
 12:44:47 +0000
From:   Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Nikos Latmos <n.latmos@deepsea.ai>
CC:     "jmaneyrol@invensense.com" <jmaneyrol@invensense.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PROBLEM]: Error during probing process in inv_icm42600_i2c
 driver
Thread-Topic: [PROBLEM]: Error during probing process in inv_icm42600_i2c
 driver
Thread-Index: AQHX7ECw/Lg/R0uDEEmXs2ntUly1Bqx8AIWAgAFmCu4=
Date:   Mon, 31 Jan 2022 12:44:47 +0000
Message-ID: <FR3P281MB0537EEAEC0F836E5CC895C2BCE259@FR3P281MB0537.DEUP281.PROD.OUTLOOK.COM>
References: <20211208135644.3523024-1-n.latmos@deepsea.ai>
        <CAC-bbXbkt0oYPn+EWLdEYKyj8G_muWGDZWTApyFv3cb591dc0A@mail.gmail.com>
 <20220130151737.43ef5b08@jic23-huawei>
In-Reply-To: <20220130151737.43ef5b08@jic23-huawei>
Accept-Language: en-US, fr-FR
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: 42749824-7cea-3310-1be7-dd00c6fecba2
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f8e752b7-a671-46df-d487-08d9e4b776f9
x-ms-traffictypediagnostic: FR2P281MB0902:EE_
x-microsoft-antispam-prvs: <FR2P281MB09022197B7273596568B7B1DCE259@FR2P281MB0902.DEUP281.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jbZl83JI4c+pIGWL70MpjoBEjOm+z21qmbqQdRYKVk7SiH5BgsnIqasj53vBqd9obuJMcYRHZHC3qivdeNwSeuBFLgsgEZWZxDobcbZ1FIP7Kw1efeFZDGiGQboN4esCDl4ouqXB/KJq4/ANGidlKYzgI5Y+qljlm4MEYp03puhvMf7a4dIMSnYdeov6eFp/Uwg7H+v7lwQ9usCZB2+qZl/rir5nDZyeq46lPqviLT3WvfWinOz5oTcmkoNcZSnSJvdPN4TnG7OYtlNxseLdKRuTRF2zqurpaaQ6N3v4+Vu5BiD5V976NU01eC8lbvFTW2M4b6H666QvzpvUq5e9JGm9jr04B1oybT/UJ/IR5I5d+Ed8pDDIl80fY6Y0elJ3Jd6iCYl/Er4vI9mYdfxVjTqrXFTZTB4WzdrjkIBPS8o0G86ZrM5FQEX4Mhf1oBi6r0BqH0JIwQKa1oE+2PwWse3/OZDAEOY47FgYFtG6hsjVAJeDlPqOUsrd53cE+32UpXJmfLiJqF+9ZRZppb8QNTcTvQHTv8OwViTW3WlOJknla+pfRokI8X/gPV0wZl2t5AHSzN7FvcyUqBe7LYoW7o03PkI2abGMEysQGmdwwM8641GdBuY/M0WaGNelFAzHv9HGHNZXTfjhs37ewNu35MBkR8TM9KVYz/l/49gcNuLloEWlLYaCvhJOYvBeEMVTunmtIsgVdzUv8VioWZrcaw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR3P281MB0537.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(66476007)(64756008)(76116006)(66556008)(38070700005)(66446008)(55016003)(5660300002)(83380400001)(52536014)(122000001)(66946007)(8936002)(4326008)(8676002)(91956017)(53546011)(9686003)(7696005)(6506007)(33656002)(26005)(186003)(508600001)(71200400001)(316002)(54906003)(110136005)(38100700002)(2906002)(20210929001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ubUH8lQDfpt7xGzvsiNFdp1lDnb29Df1uBjuQflwUHTFmlve4tc3JIv9ji?=
 =?iso-8859-1?Q?iyqaPDyz/m3w+26roGnHNBLuHq8dprdSDnqmWZfsAcYCy2ku7KVpqFGWN9?=
 =?iso-8859-1?Q?Ru+jjNTfIsUNxLNPS+Gq3ChoWW57OpygjfQUXyFjUDGf2LKYxb1xm72x7A?=
 =?iso-8859-1?Q?UXlQm6/lvCwSfQ/f/XMctlIgRPet407ynSozFSJ6XVZtzk9jLMCtUqSyMn?=
 =?iso-8859-1?Q?2d2YmbbXxwOFLslla+k1g7r3uZZUp13cIvSHbVuNdetS9GhQ+yUJ2QbiY8?=
 =?iso-8859-1?Q?eYyPd1NagIxk9ppd5cPzjlT4WY0sn0OCMWq8MEUnFWV/F29Bn2gNtbiI2H?=
 =?iso-8859-1?Q?JvQPAQn+sfC58x0bxb+NpaTEPsxuuDqk9PVHHXibcqXsGR/GPaKaXX1loO?=
 =?iso-8859-1?Q?RwDmJKHfhteLoISJwIGw0un4H9KjlKhD9BZMJekncwthIFSl9gBanOjn+Y?=
 =?iso-8859-1?Q?zUV/zDgSxArFSTxzveVmdPAHLjsWP1AFDPDlJi8JagQvYasUTYejOu1MAe?=
 =?iso-8859-1?Q?g8cAXPYU0g4Szjd0QBbPIW216JgrZTgK+713OcHVIy8QEt/Ksiqo3ogNR9?=
 =?iso-8859-1?Q?seWrn8Am0LaAimBizrrc30aCKB/+2u8FoCEQYyAFKW3gPfqBxwv/txBx/r?=
 =?iso-8859-1?Q?51QQD5D/oz2ozO2rD2PCsCrKmr28RmLkck6PWd61jBxEkxd+NgAX0jJHnF?=
 =?iso-8859-1?Q?rBojEQAvuLpxBQ99F7u27fJ34ZaUDtY4OwJsbTthicUcM91DTLcP+k404I?=
 =?iso-8859-1?Q?Kb5PG6y2FN+/G6LgQAVmv05HKYghO6jMi8+IfK6zrOcWGuL/DbHpsDn3pm?=
 =?iso-8859-1?Q?mt+/DjKirGxPxQ9WMaeuc+Oegt66H4bZj0/i6rQPrYU2JRBXroCB7Xwu6d?=
 =?iso-8859-1?Q?BRrlnawd3fIzXh0oQIieeZb+pL+P2MjDMrwVAPJa0MhaIuhEy5MAAn/BWA?=
 =?iso-8859-1?Q?epGv6jRKwgDQAZQ2XKowZpeHlqherpLnLcjm71iW+aw07hyoQf2KZpaK86?=
 =?iso-8859-1?Q?J5E0alfWG8neeAPMVobW+rxey9T9qF3qKFEfVqxzCSrotIwOGWuXCcY0FQ?=
 =?iso-8859-1?Q?il2vhGWP/tTOVh7Br7Ey9idr/S9vVDs515ENaRh9Gp7R6daKeZIpNbN8UG?=
 =?iso-8859-1?Q?7Sut971RJmfkNHiGiY6+IC7iStQgFCBxAKvZxoNwV3c3u0CLeUAdGgllPG?=
 =?iso-8859-1?Q?WjM1bSVYgJab7Slc6slUDVWLK+vxIgVxhy32UuHn+gxkPiX/xEwiYzhOf1?=
 =?iso-8859-1?Q?4sn4uTJ8pEa8j7hgVZgt3f+fJavLAi5YlpaoCHBy3zRTS9HLmKcEyistr0?=
 =?iso-8859-1?Q?R/oNplywWvpuRnBKgRhH1xGfxxYEZX4s1syndnKgSF4tfWGtTyLHUNgK4X?=
 =?iso-8859-1?Q?zJXoCkgtREOfJUWi2yqqgLe69LjfhyICRu7azccQS3JdEgwh78ekLxvS6Y?=
 =?iso-8859-1?Q?hUPQJwVaNBs4BuCDIouZwJFl5qQ/iaQCH1Lua47xSAZybV4AixYl98ELz/?=
 =?iso-8859-1?Q?A9ac+pNT4VyVG7ibwQS8Q8x8/WOLk1NVzwS0S4TB57o7sT+JO3SZGKqv7o?=
 =?iso-8859-1?Q?BbOVBd7JGycqborDFdZHJ0R29zGMmlsNmdZAIEleaHzhUI56tboWKacZtj?=
 =?iso-8859-1?Q?zqIRHQiTzLHebGKlQMzLFcBBjxGbFvk+RjluuwvztIQOZllOfghkg9MIJe?=
 =?iso-8859-1?Q?8oKTiMinM3SYyY4FjpE2F+Ao+ItCRxMviekSeTgF?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: tdk.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: FR3P281MB0537.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: f8e752b7-a671-46df-d487-08d9e4b776f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2022 12:44:47.4618
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GUyM9sihl01JvFH/DsptGwxsPiNWcEyR33meu8cGIB2vUuaG0lO6WQGUP9CnafZsyxIl8/W9vOOJpy8MihfcWQqS4guaF0MYFb4niPi6uBY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR2P281MB0902
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-31_05,2022-01-28_01,2021-12-02_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,=0A=
=0A=
this is a known issue. When setting I2C parameters, it enables some specifi=
c filter for improving transfer quality. These filters are by default disab=
led to enable I3C usage.=0A=
=0A=
This operation creates a spike in the lines that make the transaction fails=
 even if it is in fact doing OK.=0A=
=0A=
Do not change the register value. The fix is to ignore the return value of =
the regmap_update_bits done on INV_ICM42600_REG_INTF_CONFIG6.=0A=
=0A=
If you want to create a patch, it would be very welcomed I could review it.=
=0A=
=0A=
Thanks,=0A=
JB=0A=
=0A=
=0A=
From: Jonathan Cameron <jic23@kernel.org>=0A=
Sent: Sunday, January 30, 2022 16:17=0A=
To: Nikos Latmos <n.latmos@deepsea.ai>=0A=
Cc: jmaneyrol@invensense.com <jmaneyrol@invensense.com>; lars@metafoo.de <l=
ars@metafoo.de>; linux-iio@vger.kernel.org <linux-iio@vger.kernel.org>; lin=
ux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>=0A=
Subject: Re: [PROBLEM]: Error during probing process in inv_icm42600_i2c dr=
iver =0A=
=A0=0A=
=A0CAUTION: This email originated from outside of the organization. Please =
make sure the sender is who they say they are and do not click links or ope=
n attachments unless you recognize the sender and know the content is safe.=
=0A=
=0A=
On Wed, 8 Dec 2021 16:33:52 +0200=0A=
Nikos Latmos <n.latmos@deepsea.ai> wrote:=0A=
=0A=
> Hello,=0A=
> =0A=
> I have an ARM device based on the Broadcom BCM2837 processor (quad-core=
=0A=
> ARM Cortex-A53, 1.2GHz), which has an Invensense ICM-42605 IMU chip=0A=
> connected over I2C. I'm running an unmodified Linux 5.4.83 kernel. The I2=
C=0A=
> driver for my device is in the following path:=0A=
> drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c.=0A=
> =0A=
> The problem is that the device driver cannot be probed. More specifically=
,=0A=
> dmesg returns the following error message:=0A=
> =0A=
> inv-icm42600-i2c 0-0068: mounting matrix not found: using identity...=0A=
> inv-icm42600-i2c 0-0068: 0-0068 supply vdd not found, using dummy regulat=
or=0A=
> inv-icm42600-i2c 0-0068: 0-0068 supply vddio not found, using dummy regul=
ator=0A=
> inv-icm42600-i2c: probe of 0-0068 failed with error -121=0A=
> =0A=
> During the debugging procedure, I found out that the failure occurred whe=
n=0A=
> the driver tried to set up the I2C bus parameters. More precisely, by set=
ting=0A=
> the INV_ICM42600_REG_INTF_CONFIG6 register according to the values descri=
bed=0A=
> in the datasheet for the I2C communication, actually caused the probe fun=
ction=0A=
> to fail and return the error -121.=0A=
> =0A=
> After I experimented with different values in the specific register bits,=
=0A=
> I came to the conclusion, that the setting of the bit=0A=
> INV_ICM42600_INTF_CONFIG6_I3C_SDR_EN caused the system to successfully=0A=
> probe the driver. Any other bit setting combinations failed to do so.=0A=
> =0A=
> Any hints on why would the driver behave so?=0A=
> =0A=
> Here is a patch that I have so far and it seems to solve the issue.=0A=
> =0A=
> Best regards,=0A=
> Nick Latmos=0A=
=0A=
Hi All,=0A=
=0A=
Anyone familiar with this part able to help Nick?=0A=
=0A=
Thanks,=0A=
=0A=
Jonathan=0A=
=0A=
> =0A=
> =0A=
> From d7b3922cd0182ba880ff729edb4a156b55dfb6f0 Mon Sep 17 00:00:00 2001=0A=
> From: nicklat <n.latmos@deepsea.ai>=0A=
> Date: Wed, 8 Dec 2021 15:51:28 +0200=0A=
> Subject: [PATCH] iio: imu: inv_icm42600: enable SDR mode=0A=
> =0A=
> Add SDR (Single Data Rate) support.=0A=
> In SDR mode, data is only clocked on one edge of the clock.=0A=
> =0A=
> Without this option enabled, the probing process fails.=0A=
> =0A=
> Signed-off-by: nicklat <n.latmos@deepsea.ai>=0A=
> ---=0A=
>=A0 drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c | 3 ++-=0A=
>=A0 1 file changed, 2 insertions(+), 1 deletion(-)=0A=
> =0A=
> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c=0A=
> b/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c=0A=
> index 85b1934cec60..ea31f102fbca 100644=0A=
> --- a/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c=0A=
> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c=0A=
> @@ -21,7 +21,8 @@ static int inv_icm42600_i2c_bus_setup(struct=0A=
> inv_icm42600_state *st)=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0 /* setup interface registers */=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D regmap_update_bits(st->map, INV_ICM42600_=
REG_INTF_CONFIG6,=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 INV_ICM42600_INTF_CONFIG6_MASK,=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 INV_ICM42600_INTF_CONFIG6_I3C_EN);=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 INV_ICM42600_INTF_CONFIG6_I3C_EN |=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 INV_ICM42600_INTF_CONFIG6_I3C_SDR_EN);=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0 if (ret)=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;=0A=
> =0A=
> --=0A=
> 2.25.1=0A=
