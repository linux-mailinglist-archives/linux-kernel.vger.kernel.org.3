Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C21A4684A1
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 13:01:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354791AbhLDMFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 07:05:04 -0500
Received: from mail-db8eur05on2067.outbound.protection.outlook.com ([40.107.20.67]:21344
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1354342AbhLDMFB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 07:05:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A9kS7z1e5rATivq/Hb3Uz5h2mvJdsRSKzP8oiQUOdFLmUbJL/8Vi01m14W5qcBsPSYaGJtvOFToeFWm5MWHbVuyCJ6JoGxPpr9hnKmbqzbKgi1HTx7TFeaU3HcEKwQP+kWqsIbGi9F3+jxBk7ZwQFu7dyZVtZMrGLUX3FIc1MNcbfYSDU+2Vvn9l8UEbwseEWgHsxF47AMcOD4TNKvRBv5fKXm9XzWP0i4KTeH1DQDykXZRVwUxWb457QVdldYWGJgMnpwz6m+EV3zggN6yipJ3cDG2qZDGTHRMPtCo9IZqJfbjQWvpNge5t4v08v1b1ZuIlDttjPXroFG7yQiW5cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6OHn8MvxAo80EOEsDnBblfrZhNS4zSOmpynbTOHQKLA=;
 b=hCe01weMmK1DcR/pRUoEjb5FWu5gkUsUZ7pj3rLsLl+r6/0e91g0gA8I1ZbnmxdzbucWK+Sk+oQAWPgGCjy9pyiIAuDdEEhXPLXEoILBeFZ8m4qS2ZIUs0wLoowsu63bxJI0ZU6A7oSxjUcdbT2JgwHq5KYiMK1atZ0IaUhELhhyoItdMCN7K4mPa5wsl8oHWm5ufPpqGVvzrQrxRfeMYT85M9CJsV7vRQR5t1sXF8QIIGVz9imnt/CIMow2PqJ8p123U1jpN90tJb1XQjlG3YLwZN9I9m1Z9BQPhfqj1dCUudunk+YA7ixkWNsmKZ3g9zGrK6AKqa3uuSPLGqm8Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6OHn8MvxAo80EOEsDnBblfrZhNS4zSOmpynbTOHQKLA=;
 b=OV8num5eE+VNi9JXGiT5yVKGQng2a/xoFqeHw+6mYWL8nfAW7JPc7PIYFbyHIpBSOqhOpPJKR2O8LABo0bLFfmIIF70zHnZyKR6U68JNmE5dDcvi0FlYe+VEGA+mKLnU0l/4vzcp6tU+7xZWGk3jrKjeyj5Y9rA6yweV8MXYpLM=
Received: from VI1PR04MB5136.eurprd04.prod.outlook.com (2603:10a6:803:55::19)
 by VI1PR0402MB2800.eurprd04.prod.outlook.com (2603:10a6:800:b8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20; Sat, 4 Dec
 2021 12:01:34 +0000
Received: from VI1PR04MB5136.eurprd04.prod.outlook.com
 ([fe80::796e:38c:5706:b802]) by VI1PR04MB5136.eurprd04.prod.outlook.com
 ([fe80::796e:38c:5706:b802%3]) with mapi id 15.20.4755.020; Sat, 4 Dec 2021
 12:01:34 +0000
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     Leo Li <leoyang.li@nxp.com>
CC:     Shawn Guo <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Vabhav Sharma <vabhav.sharma@nxp.com>,
        Fugang Duan <fugang.duan@nxp.com>
Subject: Re: [PATCH v2 7/8] arm64: dts: ls1028a-qds: enable lpuart1
Thread-Topic: [PATCH v2 7/8] arm64: dts: ls1028a-qds: enable lpuart1
Thread-Index: AQHX6KRRXDQDoJ5Wo0a7qoFPrvvwoKwiPBOA
Date:   Sat, 4 Dec 2021 12:01:33 +0000
Message-ID: <20211204120133.2izcjota6xrwu5s3@skbuf>
References: <20211204001718.8511-1-leoyang.li@nxp.com>
 <20211204001718.8511-8-leoyang.li@nxp.com>
In-Reply-To: <20211204001718.8511-8-leoyang.li@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: edf15f64-eae3-43ae-ea9f-08d9b71dd11f
x-ms-traffictypediagnostic: VI1PR0402MB2800:
x-microsoft-antispam-prvs: <VI1PR0402MB2800C1768DA6B618FC65CA00E06B9@VI1PR0402MB2800.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1169;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fDksf3ycobMf9uTbLKq39RvddbcFo6AEse5U15zwYQChTcgkGiH7lQ2GrELImTfzvowjxc6qDZuGxGJJ75+/CFlB7NPvB79KC+Stz65fROveBAoS70kV2gAhJJDcnD8hwrSKs5TwywGXl8PtwpwcLTzXVoEl6ySUdqt/zHJ3xFzdcwFu7qV7XkWrJK1+DXUGkGd1N+vwXx3kCLrg19ts+w4f4V3Lg8qaLri+iTOSR0yq9VsxATIwHeQtk9SmApBNDRSVFLqBsSP7uMloBMueil9deFt0aTBm12PLMt4nVzlh5lnwmBOHfoh+ruyonFOUfL4S9RbEJbRSNkiXROPubVvO+EQoXg3dEHLnN/CHsWxpRe1oFIPNkvBbcgXnpUdBu6r597fHviek3BoRwqjRXIpMxRdRY2SVFPNC9c6iA9vyE0fA4sl695sIctMa7Hgvo+ryAu5PJvkf5ODMJ79ul+Qd7CQvOk/FTfjRxk2/qrXmEFhXWCnRSUsaj+Z9LYyJ3RL1yP4bh8VLPxF9QmI0eDqNrcAk2bFVO0FdLz3Pu4NOxnruXeivjeeM4zr/3cE6YOmO0zRY3INtX8hL4U76aRQ0PBd9IOMJ7SreulTLU72tTXvkNorWa7ROWf5/00/PhsAroH0uHE2qVZMmxXI4wtYtX32pdbJDtzdB13sKJCbPolg8KiO/D1BBPH5bhQol74jHB3akaeWMhpsAGHqFpg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5136.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(7916004)(366004)(508600001)(186003)(6486002)(38100700002)(6636002)(71200400001)(122000001)(9686003)(6512007)(38070700005)(66446008)(66556008)(64756008)(86362001)(66476007)(4744005)(83380400001)(316002)(76116006)(6862004)(91956017)(44832011)(66946007)(33716001)(6506007)(2906002)(26005)(4326008)(8936002)(8676002)(54906003)(1076003)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?a+R37yAIZNv57wKzgeA+mgorpAt560wQGvQzYg4FfHxUJfcwMRRZ4IzX4R41?=
 =?us-ascii?Q?dXX9Z8i13oygz6nQdAq3zO1KAp5YVB6uWZtJNBb3myjPmBR+jnPJmTTdzeK4?=
 =?us-ascii?Q?ztmeZnUiuoLHYkclF949bgxcqIXqkFgSiYuM6g5k+JUiE4fUhLUWdOMq9Lmt?=
 =?us-ascii?Q?NfBFc6Zxk0iDSpWUB6rJyKUF/yEesSlWZK1Nsl0MNVVrty08H9uRW7mkII6y?=
 =?us-ascii?Q?ogpDy6J2qEmW6GG4mEh7yO5w0xTqOaexzMxeWF8BaH3vIgIapltVw9tDRDat?=
 =?us-ascii?Q?vwaO4co6QqENZFPyv8Ud0HWBHLzE42ySdRafHqqL2jFsNqQlO4fZJwCKYJmL?=
 =?us-ascii?Q?YTnyc1AdSwFFHNM3YlnrB+PJNej+Zbc/jAjGZJ7mOR8O3TA9SCDSMEGxqf3g?=
 =?us-ascii?Q?ULK8A8xGPnKKGjZFiLiG/L/Yhg1PjUU8mrXCT1W4Wwe0BgzgTGtVMf3OUyHE?=
 =?us-ascii?Q?r+eSyqtpYFGQ4JLrj7abPY4TQLNLO80XUOaTsomBGpdMLVEELGrOi31NIrja?=
 =?us-ascii?Q?IIVF+enU8tFp9iCB1hqXxMuo4L52VhrbtWyI4XQg9/iYGDH+JOYnHFFbQfsY?=
 =?us-ascii?Q?HN9dbYprdGlnoCwCxdzlaqwgg/gGgOmOIpRrYfgEkB67JFFE0D3FD4Ee5l4L?=
 =?us-ascii?Q?lH5q5Nr2kkKtZNm7RE1V+zZr1Us1QiNjp7SWOwERtBALjRM7Gq797+NhrbGE?=
 =?us-ascii?Q?oxvp8DE42l+ODRWzE9uEZoWnnsx+na1wfxdTLF0IRbDl3wxZqPlwtfTgOTDC?=
 =?us-ascii?Q?ofslPzfh5Bg1gaPBysQ+SPLHAdsjtIQSuCGXWrMrNr+zHUkrviMJx9TGre37?=
 =?us-ascii?Q?rC6YVvDhXDKn1qY2RyrcGZk5tJtvCnwHkcblDNzOlY6/GHAN9SZDQD1/nGJa?=
 =?us-ascii?Q?4Jx2A3RJyKRNboPs0TiblLz6YD3UUVyPjxWexYXivyRC9dI0on18n+xsvHYz?=
 =?us-ascii?Q?4GioiFH1keKOVEqoXPiFlm6P84POgUr/MFJqnsnabWL5ghqAqt8eWlnit+zj?=
 =?us-ascii?Q?b0UkcnRtE9uzqq/5tuEtZcE2kc7nxwIRzmZjMoaHBb861Z8/GcjZD6UhEQRt?=
 =?us-ascii?Q?bSA7u+vKUVpkYwhqpGyuISrUrhvDPGVpgMAX1rGWSm6O8WaYgr0899yU+Njr?=
 =?us-ascii?Q?7UmDmJtx64yK8Qmz8JaETa9By5vTLIDSnmjcojlTXd9mHZUmAS7D3lcXTSXU?=
 =?us-ascii?Q?qY1bFb4EnGCX0eqFe5rZJ85PaFOHMPOAGIlcowsTr8Y0SUZ/s/KWs01YM+TN?=
 =?us-ascii?Q?lLnn9w29p42/Cw9JWmX0frSjpm8fZ7DiZeXHuPVj0khMh+noDsc/O0T225ri?=
 =?us-ascii?Q?vs/kzPZCG+rqJDE4kEiCz3WZUvOvNCh9L/SYhtS2/r+Wh7zscur9NypaHSlT?=
 =?us-ascii?Q?cljk4FkvXe+HCplB+vzo5dDh5sMq9FrScl7yyipVYi440bFI+ouKIQC0+CgR?=
 =?us-ascii?Q?aXSxShzBd84Y6q3SH6JdJlkzMOzyBclSbdh4hj0QrzL6SV4trZCJ0RYnto28?=
 =?us-ascii?Q?yS9MHJw+2mvvfdaXzLGXiVN1PfMKCYq41jTnCS1dG+0QEr01ZBhCInx3a6ix?=
 =?us-ascii?Q?f/0FgPD9BV3HK5nZfHxJn/Qut6pVNIjL111Nkg40sZFHmDA1z7Iehu0fnXk0?=
 =?us-ascii?Q?xoVZVAnfbTeXumUX41oJQz8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9FB0FA6A8889944C9A82BE7A1F1D502A@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5136.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edf15f64-eae3-43ae-ea9f-08d9b71dd11f
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2021 12:01:33.8694
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k9WsWBOl/Jdrq8k03ghvNjueOT5P8mgNTjfEidnlygrxj1tZ5PRop7lBX3Tb5Y2Yg3DjeRZ0QrqzCaQIIr0MKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB2800
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 03, 2021 at 06:17:17PM -0600, Li Yang wrote:
> From: Vabhav Sharma <vabhav.sharma@nxp.com>
>=20
> LPUART nodes by default are disabled in LS1028A device
> tree, Enabling LPUART1 node.
>=20
> Signed-off-by: Vabhav Sharma <vabhav.sharma@nxp.com>
> Acked-by: Fugang Duan <fugang.duan@nxp.com>
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

This needs your Signed-off-by tag too, since you're carrying the patch.

> ---
>  arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts b/arch/arm=
64/boot/dts/freescale/fsl-ls1028a-qds.dts
> index baa1cc9b9835..782853a449cc 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts
> @@ -336,6 +336,10 @@ &lpuart0 {
>  	status =3D "okay";
>  };
> =20
> +&lpuart1 {
> +	status =3D "okay";
> +};
> +
>  &sai1 {
>  	status =3D "okay";
>  };
> --=20
> 2.25.1
>=
