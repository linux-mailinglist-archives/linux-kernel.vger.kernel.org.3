Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FD3B49B55F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 14:51:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346797AbiAYNvV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 08:51:21 -0500
Received: from mail-tycjpn01on2139.outbound.protection.outlook.com ([40.107.114.139]:51983
        "EHLO JPN01-TYC-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1577788AbiAYNs5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 08:48:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CKMpYG8cr82mneH11qUchvRZQYLLbYGvIg0zf/A/dOLX7zYHAaOwseHXGkFGH4plikCSxOxfnLzpFCyvdQSKBzX7fKrKI9YseZnCk1VwFPfxFG80sNY0s1zO0QFp4o9Pau97FvfEkNyz2Ei/cv62qkRf1Jni5C1bFMrP3en2b0kyP1IvudNcErIA+yAH7/2SxSM6dczWxWFKsi42ZReP4x09X6WVkJOV0ss/vTeCNPoUJWyFi0Nq2OVRrQlExVONOlg1E6gmDMlq9NzKRhp7ka3GWiaDga9qI3ZJf7uDc+/UlCFGKkvklxs1Opz7E95FYvkgM/kNXDOASmoAc0i/RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TJpB6sURq4ygGdjQEFOr5uAX2AaxU0WpOGkkLSpJm4U=;
 b=fcUdfwUsQnOSOAM9zIvR5LraAd8gejvjU3hs8GaMV1C5QUF50LfIDX7cyvByZhsDHvNO4bOxMXRLqj+dgfRstdcVJpFtYjvORCfZvRLTGlMzuB7wtj6GuUU465bwzhREX+xZcXpuXgDngutBhmZUpNc4V8hJHr1nRpF0MPCpdYmCvnQGDl3TyjapkV5cfA3EoY1jyOSfkfpvAGNMj9aZmaBTHv7ak0Qp1pzXYXri+dJOfJbvalkSnynB0Ub2eEOV8SSOo0iZ8oFFP0J1bL+VuGk9Ud3T1JoChUT8eum5Wi7CMbT5Nq2fXChyFSKgrt1Ib699VmMffCDOj1wRfnSuDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TJpB6sURq4ygGdjQEFOr5uAX2AaxU0WpOGkkLSpJm4U=;
 b=ezIJRPrtPYZNVNz1xB8UQ0QrtDlaehSHjIvaqF6cFJ3KTdUZOCKAGxVMrqW1eZa9fAlBhCUQvzDwS57Ht9YuzMpmx+doZcaWoF+4PheRMmbj20pcDRF7WjBPDjHBoWSvMjCMdAwhiw9TwLViv/4A6dcWHfExno1hbnLU256bPwc=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYCPR01MB8342.jpnprd01.prod.outlook.com (2603:1096:400:15f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Tue, 25 Jan
 2022 13:48:53 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::3847:4115:3fbe:619]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::3847:4115:3fbe:619%7]) with mapi id 15.20.4909.019; Tue, 25 Jan 2022
 13:48:53 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        Pavel Machek <pavel@denx.de>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH 3/3] ASoC: sh: rz-ssi: Remove duplicate macros
Thread-Topic: [PATCH 3/3] ASoC: sh: rz-ssi: Remove duplicate macros
Thread-Index: AQHYEe8ASm7GHUanHkaN/pCBI2EqGaxzwDJQ
Date:   Tue, 25 Jan 2022 13:48:53 +0000
Message-ID: <OS0PR01MB5922EAE24C481973BC55DC40865F9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20220125132457.14984-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220125132457.14984-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220125132457.14984-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 490e5788-b1bf-42d8-3adf-08d9e0096cd8
x-ms-traffictypediagnostic: TYCPR01MB8342:EE_
x-microsoft-antispam-prvs: <TYCPR01MB8342117E68CDB64D3061FA4B865F9@TYCPR01MB8342.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2887;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /3C6fwqTDYLMFA1sufb/Ja5OI/hO/7O952eJBBKS3mIU4j0T5Qg5zg8fq+OBx4OvfL3KiJGCfi/xVpSFy7X9iddej4lW42PNz5S0NACZePlXIn5Ka2x2LtP7evmPoRCQhXE5pJ70q32t7VN6FPvp1mR2+CaVOPkd/8jYZx8L8ja84z7wa6j/EZSSHAFnLc+C0lJKbwJY8Tz45SOGl3SiAOcia9G3bzm1hv9VeZuu5pPwi5wLXcBq1IfLKZIzwnQ2AzSCoxRY9KZxRkr177s/hGTcRt78/o10Tdaz1aAaHRrxH9tdZPZnTtjYh55wzuC8Aoge5b8UPLeS+W25nQajzav5sibc40c9CreamXwRjb6tnrdN/6C9G8BHxoHteSsmg3HmlCkWuffT3aPkJN21s1UNXkH1PcpN8mFGSDAD4VOc1yKgeZk5i8Mer4o3Jzz7Qfz70JEblCkUC5neeMSzABcuTQY3lhKhU4X15adiPcD+u/hUPRKdKDLpvsR1U6ZApH+aQ0eQih9X4eV1Hm4sAZZ03lQ8SL8qAZ4VwPT6AIxq0NXBTpnpAYwIX85e83/g56K0XO6gOair7C/Rqe6PfLWOnwWbtvYTZ1NQ/XbSpBuaqjA3aQMQI+vCe/7HJa9De7UEgsAnnq4+BA19t+RwLyAdt3PPWM2C0V/I1ekE5J6d/BH1uUmizaouKi4rI8V2+Kls2ChgMWXMo1OKoLReJw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(83380400001)(508600001)(54906003)(110136005)(71200400001)(186003)(316002)(33656002)(26005)(64756008)(66946007)(76116006)(66476007)(66556008)(66446008)(38070700005)(53546011)(122000001)(7696005)(6506007)(9686003)(52536014)(4326008)(8676002)(5660300002)(38100700002)(8936002)(107886003)(55016003)(2906002)(86362001)(20210929001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2qbkQfN/pyqcUXS3ZAbvxDGhd/iSlatIlp8lac2PSbEziglapw56E0TIKx8W?=
 =?us-ascii?Q?A1lmtZPmT7OolzI+9b5+vSSEAGhw7kR3stYOrbunxv2tzaHES9jH30A0geyt?=
 =?us-ascii?Q?BW73BtPpYWrtGVLiwX+HJFdKhyc1ujNSNhVqf5p40H0o1JTUwe2uXcA4iY6F?=
 =?us-ascii?Q?UgKZTDQ284CUZ6dJxXpU6ep3v81Zih+OiHlEVnX7uoSvyEOAhywf1f9OxEy0?=
 =?us-ascii?Q?RAHMwZpvO3QjgPibALu6eoJ2cM6CvKam76yNSbP2Hv3qXWWIkY6dfY0mq5NC?=
 =?us-ascii?Q?mEoT+G+fbi8PSZmUU/gvfnPMLMb9y+igevqDS8wUdm09hd31d9ZsjiDitAYO?=
 =?us-ascii?Q?AhweAQNhX9E1YUzivufVhE4RIp5e8udt+z5hF8NyNSIGroVUAWZLDG5OQQXa?=
 =?us-ascii?Q?XWhK9ORfIuq37kENCVbd8QOMPcU+RrZT5ZGyGEjOaI+C4unvMfcseRV3lEaI?=
 =?us-ascii?Q?4pLKzfpIrhwHt5NnCCBL3eHtyrXyLorXHJ3cy13JTesyZRqBLhUkdqdZ3DwM?=
 =?us-ascii?Q?5P00nT+3CPOE++2cquAoJPKmg0bVYBrhAj+DvvIX6kF8CCNsZemNj6hTRYo9?=
 =?us-ascii?Q?KgpgJ95opA8Clac5+N5BYx7Q3v5RB7c5Xc3G5PdbnY0CESje12nUsjsaKNjR?=
 =?us-ascii?Q?Ay1b+l/ClxHAz11oy20Y84Q79T34domdeGfZi/7cO4jLREgIt+Rd5CgSiEUz?=
 =?us-ascii?Q?OUgBoszoAQ2Mm+pZFHLx5ImMuCkxJDZWBdHurSw1YuUonE6WEykAl6Udf3qm?=
 =?us-ascii?Q?+FQVafv0dGgWsS7BSX++q7rLC9+CB4OYPrUWCE2UmfD/lCQSXnpEJwgLw81/?=
 =?us-ascii?Q?RIogTn0ARP5DpL3b0IZFcnA+S+RQwe6XK3c5WHduYXInIsFioPXpHaYZl0ZE?=
 =?us-ascii?Q?KVS6eQmnGh+o145ejlo6xRIp0wzkNCP/SIGpf/flfww0IDq+GWbCn9KOIM3O?=
 =?us-ascii?Q?SGT6VUVZ9SQKx+i5+LVgYwVlYR+qqUSbp/AzV+DAMrDa5lmCzNwp7grJZR7E?=
 =?us-ascii?Q?XpDD8NV9wHm43VFH1HJ0ClgmIa9tMMyaTOTqmV86S9zZ+aZdfmW141ast1R1?=
 =?us-ascii?Q?j8V9lQnhyDl+VO4Ccn1/YULbBADuo9XSEzaHgFF71OLvmVQPj8MjilNm6C/e?=
 =?us-ascii?Q?kVixEX+gJot/Y5ruKwCPnb0TX/ptc3dEDE010zH4PHdkBYuver5wwFFfm3Gt?=
 =?us-ascii?Q?1QmE2d+dIDVnmBe+A3Y9CsEyRx77WZ4ITdAqpkXBda8mkuek8VDgtNbgkbW8?=
 =?us-ascii?Q?rrH6aY99c5D6U230WM+obv0Z8OF79h8QuwAEJ0fIGCiQvHgRrDvrgxKL+NBb?=
 =?us-ascii?Q?GTCoaznnQh6iWlF7q2WS4ncaDU840aquJz0jb0RcEkZmB0x4A4pvU8w2MCtX?=
 =?us-ascii?Q?4N+LAqcGty+iFCHkE7OUm0jJqpdhq2GEsvLcHjFOvkHJ7I2RfcsU96+9ksTo?=
 =?us-ascii?Q?eVNq1c+aBSvLrvCxLQqkzjSEFoEJMgiGfEr9qKDl/HAA1E89JO1GRi5F3U0K?=
 =?us-ascii?Q?oaKwZWwkylfBq/eBVUJSEe9WE1ZaXH0Za+2R9dAa97gCaFshiNJQn2rfMsTM?=
 =?us-ascii?Q?ggUPG+iAXeOdW8Fi3M0M2FvuFhbvNasgxPcR08dV34zAq8wpXO+o3P4qlEgh?=
 =?us-ascii?Q?p+cv1vPdJ+LCuGhR8trKZKYIr5JZa+paycGD+bGGUF4PFVBG11KASWwurbd/?=
 =?us-ascii?Q?oAXSNg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 490e5788-b1bf-42d8-3adf-08d9e0096cd8
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2022 13:48:53.4448
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1FicbNRqjfQCysZE1AquFsyoQfllNSOmboj6G5axLNFMo1eK2d67WyiIrsRodDGEIoieUX9gOr/TqmhDR7YjAMMoAaDeiEDJGNuBgHx37Lw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8342
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prabhakar,

Thanks for the patch

> -----Original Message-----
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Sent: 25 January 2022 13:25
> To: Mark Brown <broonie@kernel.org>; Liam Girdwood <lgirdwood@gmail.com>;
> Jaroslav Kysela <perex@perex.cz>; Takashi Iwai <tiwai@suse.com>; alsa-
> devel@alsa-project.org; Pavel Machek <pavel@denx.de>
> Cc: linux-kernel@vger.kernel.org; linux-renesas-soc@vger.kernel.org; Biju
> Das <biju.das.jz@bp.renesas.com>; Prabhakar <prabhakar.csengg@gmail.com>;
> Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Subject: [PATCH 3/3] ASoC: sh: rz-ssi: Remove duplicate macros
>=20
> Remove SSICR_MST and SSICR_CKDV macros which are defined more than once.
>=20
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>

Cheers,
Biju

> ---
>  sound/soc/sh/rz-ssi.c | 2 --
>  1 file changed, 2 deletions(-)
>=20
> diff --git a/sound/soc/sh/rz-ssi.c b/sound/soc/sh/rz-ssi.c index
> 1a46c9f3c4e5..e8edaed05d4c 100644
> --- a/sound/soc/sh/rz-ssi.c
> +++ b/sound/soc/sh/rz-ssi.c
> @@ -28,8 +28,6 @@
>  /* SSI REGISTER BITS */
>  #define SSICR_DWL(x)		(((x) & 0x7) << 19)
>  #define SSICR_SWL(x)		(((x) & 0x7) << 16)
> -#define SSICR_MST		BIT(14)
> -#define SSICR_CKDV(x)		(((x) & 0xf) << 4)
>=20
>  #define SSICR_CKS		BIT(30)
>  #define SSICR_TUIEN		BIT(29)
> --
> 2.17.1

