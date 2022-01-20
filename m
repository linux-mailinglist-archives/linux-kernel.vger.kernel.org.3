Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60BE249491D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 09:08:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231338AbiATIGw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 03:06:52 -0500
Received: from mail-eopbgr70045.outbound.protection.outlook.com ([40.107.7.45]:12517
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232881AbiATIGv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 03:06:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xmeg9Xmb3CFxfbMGWMMJzJxIqlVwBgsXdwu71glpZMUQevRxJILpKUQw0heP0skV7umxDnxYsOgZMTSls4hwj7+gniEn59ek3FsA2UoYMY2CUNaP3u3bJCA6q9vFvUGEk07vfdpysPGlGcjP2pYQft/pDAQ5UabELaM/XAvLtFI5kHVSgAclmUANEBqNvGQwjjvf/l1fIkt7kaQFYwWOpLO6M6Xs0aarjCEpH0Od7ok8qve0iuK1Ru+E8h95jg7+azlp1OWmAnnbhksD2RbemnQB9BlHv6NOnjxKJoA6/d6oF3VWYTJCyCv27h3LcPLxSl8Dh8krwDJJvdKGBhjkNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OqPwZSsH14UOuR0dtrUTTkkHJ8iosg1cSe0+kApCKv0=;
 b=RprgLqWi5DRqdyNW01S3ilCKOXZkIB/7K8tl2sMrK1XzcpjTHoduUON3xN+N2hzV6/oVvcG69MXAVLrRuZJZsJ6FNLaomdxPJ6kJuE4xYKgKwAkVzu/2ulLGw4tcy/k8/Vh8XHfP2FKnGjf8yAYaUTlzAxmaydxHi/UutbR6PN02bvUYmFLzGeDRyZb3QEysQQSpIN9OeiM64i5cqprgz4VhXHyp73fGXnXTKF78/rrM/QlqW+KnrxObZrBJ6ocPdMl1/cflL5N2B2BQDj/LWafM40WXPXRVzFc80yhyAmaZ91emiRcxjRKdGz/HegSHegRU2dTsxrhP/w6WhPPgYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OqPwZSsH14UOuR0dtrUTTkkHJ8iosg1cSe0+kApCKv0=;
 b=On5POIeX7b/gGzfoBIvT/pBCpLKQJDQFItIpDLlDB2cxX3GVMNROG9iYUEsZFOFhW73VHKUmz8L3SLugxnSXs3An5DQhMeV4Pl2CWP3RZytGbnI2Eb7yK0M2g8iY7mcuLpBpWHJWGotUuvA97rHCfqQLayYNG5k8FVHIjcvt6d8=
Received: from AS8PR04MB8946.eurprd04.prod.outlook.com (2603:10a6:20b:42d::18)
 by VI1PR0401MB2336.eurprd04.prod.outlook.com (2603:10a6:800:27::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8; Thu, 20 Jan
 2022 08:06:48 +0000
Received: from AS8PR04MB8946.eurprd04.prod.outlook.com
 ([fe80::499c:8428:4926:b53]) by AS8PR04MB8946.eurprd04.prod.outlook.com
 ([fe80::499c:8428:4926:b53%8]) with mapi id 15.20.4909.010; Thu, 20 Jan 2022
 08:06:48 +0000
From:   Leo Li <leoyang.li@nxp.com>
To:     Michael Walle <michael@walle.cc>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: RE: [PATCH 2/7] arm64: dts: ls1028a: move Mali DP500 node into /soc
Thread-Topic: [PATCH 2/7] arm64: dts: ls1028a: move Mali DP500 node into /soc
Thread-Index: AQHXnm3BBIB1udn3FU2SEpI7fAArKKxsazhw
Date:   Thu, 20 Jan 2022 08:06:48 +0000
Message-ID: <AS8PR04MB89460673836CDB9AEFC0C09A8F5A9@AS8PR04MB8946.eurprd04.prod.outlook.com>
References: <20210831134013.1625527-1-michael@walle.cc>
 <20210831134013.1625527-3-michael@walle.cc>
In-Reply-To: <20210831134013.1625527-3-michael@walle.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4efdb5d5-936c-4e40-4b42-08d9dbebcf20
x-ms-traffictypediagnostic: VI1PR0401MB2336:EE_
x-microsoft-antispam-prvs: <VI1PR0401MB2336448F4C5DC909B06B13A48F5A9@VI1PR0401MB2336.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5pfShyJuB0T4xSolNy6qL2tLRtcyegHIKYSz2lx4YZoG+xy5oOSNFfjaaQ3nQBjCC68ZTgzTi6fS7f+zotDW4j/t+rowPo6KO2z1i6Epds4zG2A2agFgQB4cvGYBPDTs5B73ex4Mghvb8s1/8J/HHRq02bGR2jQAf+44FPiEJsUopEYubcrYD65DqPOdBr69a9+i+epyl+FDxQGwVF6noOQ1RIFlofC9StMIuq561USNUfUhy+Ac46vifUBaSATXwocSPS8s5ydc/764Z9ZmSNeuzPk0U0RyICos30HRbsGjHf5yFQFmpE/EpkeD9BYMFUQYkm1xbffjNNXMm6cWBokAuPX0UC7YV/T5bQHdu+SBw+O5vhRFCUioyzWZCGMwSV4hphEUH/zX8OK9MyMFIor2eODM6kG0sOr1Vlm7+8m0Jfqh+w4M2/3CJfdNZJmEMxWfCLVrnwuP2RgifJ3dfbX6CaJGwcuilijgLFwIveYrSVZMFDT8dzn8ZsmZxnX0VZpW3fyUzitK7zUe2xctoQl/4ea0c/556OVjjRx1u8SlKFt1uqqu9hwn7CV8oL7ceU474Gk0OBilC+n10IEkGdOXSZklwP6Xj+2XaIwECAqM/tEqU8T5cEkjkoQXg5pyIeGxVIUwmZ7Nk4xwYmG4PkGUCPooF2FrynadqjAD+BMJjWW1xhzp31H/0PEW7eV8tQlLxJpJE6MPsQ9HLYdLhw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8946.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(33656002)(6506007)(71200400001)(86362001)(66946007)(83380400001)(64756008)(66476007)(26005)(52536014)(54906003)(76116006)(53546011)(8936002)(122000001)(7696005)(508600001)(38100700002)(5660300002)(66446008)(55016003)(110136005)(186003)(2906002)(4326008)(8676002)(316002)(38070700005)(66556008)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cXIe1ww9AO3w7Vf8ocI+6ZcstEWD72sOcZc8yWt8S4QauVaZt38X69Nc/58H?=
 =?us-ascii?Q?3k4ERyaQ6NDAFgEAfK3I4sAhbZC7R9c+8kxjVgq35+sEPfzuQD87gPUT3hxs?=
 =?us-ascii?Q?whNvjOcrHiQ2m2iIWBXzClgN8dPHHA+SoKFZMkxiZGz9LxehjzdltUZ3uWhk?=
 =?us-ascii?Q?yFlc165tk8pP+sVsAdu9dZgt7AoljgYGukFFfQTo4NA/vYRpMyBwsp+kXM4m?=
 =?us-ascii?Q?M2I9lrFyzbQAdo17DRas4xS2Amc/eNGysqzeoyjlcJp3XagmCPjjRcc210Zs?=
 =?us-ascii?Q?0woczV72EPg46ZbCq6f7P0EFn/pW9CCBoxvDFB72+5snM+lnD0TGG8lZZnzg?=
 =?us-ascii?Q?txkCLsFz+iZGOUJ+IAyRxbX62N7cE7UHIdYb/mNzajzHG6WHDFVm6hqOYdOG?=
 =?us-ascii?Q?IWtXMi2YIHIo/1gZgj4MKdZqKZQga4TgW6MBSczRlknFy06AzGNoZcCQCE7b?=
 =?us-ascii?Q?DlKnMP4muFfUzQ4dfm0aprJr4iGr3+qLCoPvijXevsLXRLUfuTqf47YFm8rl?=
 =?us-ascii?Q?2aVmK9wTObuj1KUcZqDR6N5CraXp8P0iztav4DD2Ruf37Mq0A6XvRoSg/T6+?=
 =?us-ascii?Q?1pAvH9MUbhDuE7/0ukDSx9GkjbZNvHV8TARGfDUIjSqdGu7d5d+1eELEsmjq?=
 =?us-ascii?Q?QLR3Sn1YYOow+hoGDO+AUEwFxTvtbDn4r1zlYzt8isK0Ava4/kb/X17WKWuK?=
 =?us-ascii?Q?hr+NUH/AxfBNGbo8I4D4xxE0ruYsZwzxfyiSEsw9/m8GhHfCQwIDNhKwVL9D?=
 =?us-ascii?Q?aACjPzkcgtiYcrEgMqos6daQENaM+Y9txePDMSnw4zWjRAqRX8AYek/09/1m?=
 =?us-ascii?Q?SmR2ITPyjvYsCNUeyOA35KajI+msl+KDcyb7RhW8BSFBUwBYLu390XpJ3DB5?=
 =?us-ascii?Q?OBDr/q5+DhcQ31pbPnlu4drKzF1ZQE2yVt0EoGADAdAj3apbMWsHKLZrcw/4?=
 =?us-ascii?Q?NFrVhShrVGoy98aVe1NdOiIj2d7N2YjBXwxqh/9GWou5S/nn/ksAOvtzSVOK?=
 =?us-ascii?Q?BYeBHy4xyDbOZ1FYouPP6WZakTPRIjttlJX9+DLGlwXZVZDo3f9o0+YhmKDK?=
 =?us-ascii?Q?MLiEL5rjEPez4MjfAT+uvAACauIyKnPkeiyNPQDBefowXEfRD7dmm8cbC64O?=
 =?us-ascii?Q?432zYpbxD0IQ7x1d5nUkaGln5rNxrZdY9qggxueny1cxmwtI4CeYg+CtSk+o?=
 =?us-ascii?Q?jr4V2X2Inar9Ywr2Z1nOQ3/QUzYEO2eW8pRlifqcaBkeSMTrv3EaSvrrMkwW?=
 =?us-ascii?Q?qAJ7Mg+P2oIoTjcPVhk9UrEFWTMINIFYAuh1EQSwVbMvyb+LuIFAzYh+gSBD?=
 =?us-ascii?Q?TUNmT4MeU+Ocg7V0P+To8fHOnSU6tFEWtxjc6fJpmLClSW4vykmoel0Bw2G4?=
 =?us-ascii?Q?zOMzpu4RPBKhIxqPIK6LXfT24TkZA8+VOOB+iN1zcHI65Fvhullvrls6FTyr?=
 =?us-ascii?Q?6vHosDGoqZccRIhu1hLcgBMs5Lfv0//Qm3KiZ1TcxZd08TERJs70O/3TDtI1?=
 =?us-ascii?Q?Q8bb6yilDuQPtlmbtVbmYOp7Q7z2k+D08t7KuH43mJVaV53hVs/8pX1ZfVhu?=
 =?us-ascii?Q?m3KWHMWNUbTpQlj+jjftvrpNMzC97BvDH9SvH7bDhZz/YxHun7EqekEWOpae?=
 =?us-ascii?Q?vQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8946.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4efdb5d5-936c-4e40-4b42-08d9dbebcf20
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2022 08:06:48.7495
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KVGnLai0FhY+O5c5XBgvc/ij9+DuejHj0fjfPIKm0F9cFHeo67rqMmB6imKBRBXubtHsPRYmtNOSfM/Csq4zyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2336
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Michael Walle <michael@walle.cc>
> Sent: Tuesday, August 31, 2021 9:40 PM
> To: linux-arm-kernel@lists.infradead.org; devicetree@vger.kernel.org; lin=
ux-
> kernel@vger.kernel.org
> Cc: Shawn Guo <shawnguo@kernel.org>; Leo Li <leoyang.li@nxp.com>; Rob
> Herring <robh+dt@kernel.org>; Vladimir Oltean <vladimir.oltean@nxp.com>;
> Michael Walle <michael@walle.cc>
> Subject: [PATCH 2/7] arm64: dts: ls1028a: move Mali DP500 node into /soc
>=20
> Move it inside the /soc subnode because it is part of the CCSR space.

I just noticed that the dp0_out label has been changed to dpi0_out besides =
the move.  Is this an intentional change or a typo?  If intentional we prob=
ably should mention it, otherwise we should change it back as it is breakin=
g build for off-tree patch that uses the label.

>=20
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---
>  .../arm64/boot/dts/freescale/fsl-ls1028a.dtsi | 41 ++++++++++---------
>  1 file changed, 21 insertions(+), 20 deletions(-)
>=20
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> index 9a65a7118faa..92e4f004c1c2 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> @@ -793,6 +793,27 @@ QORIQ_CLK_PLL_DIV(16)>,
>  			clock-names =3D "wdog_clk", "apb_pclk";
>  		};
>=20
> +		malidp0: display@f080000 {
> +			compatible =3D "arm,mali-dp500";
> +			reg =3D <0x0 0xf080000 0x0 0x10000>;
> +			interrupts =3D <0 222 IRQ_TYPE_LEVEL_HIGH>,
> +				     <0 223 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names =3D "DE", "SE";
> +			clocks =3D <&dpclk>,
> +				 <&clockgen QORIQ_CLK_HWACCEL 2>,
> +				 <&clockgen QORIQ_CLK_HWACCEL 2>,
> +				 <&clockgen QORIQ_CLK_HWACCEL 2>;
> +			clock-names =3D "pxlclk", "mclk", "aclk", "pclk";
> +			arm,malidp-output-port-lines =3D /bits/ 8 <8 8 8>;
> +			arm,malidp-arqos-value =3D <0xd000d000>;
> +
> +			port {
> +				dpi0_out: endpoint {
> +
> +				};
> +			};
> +		};
> +
>  		sai1: audio-controller@f100000 {
>  			#sound-dai-cells =3D <0>;
>  			compatible =3D "fsl,vf610-sai";
> @@ -1139,24 +1160,4 @@ ftm_alarm0: timer@2800000 {
>  		};
>  	};
>=20
> -	malidp0: display@f080000 {
> -		compatible =3D "arm,mali-dp500";
> -		reg =3D <0x0 0xf080000 0x0 0x10000>;
> -		interrupts =3D <0 222 IRQ_TYPE_LEVEL_HIGH>,
> -			     <0 223 IRQ_TYPE_LEVEL_HIGH>;
> -		interrupt-names =3D "DE", "SE";
> -		clocks =3D <&dpclk>,
> -			 <&clockgen QORIQ_CLK_HWACCEL 2>,
> -			 <&clockgen QORIQ_CLK_HWACCEL 2>,
> -			 <&clockgen QORIQ_CLK_HWACCEL 2>;
> -		clock-names =3D "pxlclk", "mclk", "aclk", "pclk";
> -		arm,malidp-output-port-lines =3D /bits/ 8 <8 8 8>;
> -		arm,malidp-arqos-value =3D <0xd000d000>;
> -
> -		port {
> -			dp0_out: endpoint {
> -
> -			};
> -		};
> -	};
>  };
> --
> 2.30.2

