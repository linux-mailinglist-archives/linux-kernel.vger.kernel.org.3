Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6F314E5F62
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 08:29:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347679AbiCXH36 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 03:29:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbiCXH3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 03:29:55 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2093.outbound.protection.outlook.com [40.107.117.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C49F634E;
        Thu, 24 Mar 2022 00:28:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UWsG2SDvCf/exVWLTexG5JtjCxtY77cNkxBrWyJM027nqfEN51tot8ImRyiLO1zFpLuoU9yRa5EThQdhbCAnNoEea1i81teDcXIotwzU16K8Khzmx2PYhH9jF7oa+KGF1paar0fCzXhac1NBYpHHQnutPLwUKXkR/PWp5BGHKBPVl1a7ogos6qYj1kFtyV5Z0yLQFTEGksEzGzz3vRH44FZqZ6IrdRW/jaKCNw7FmETnJAl3beNV5ihPYKqF+/YQG8LbrMZZqge0Ea7nVUWs0uPSSvqQWLJ4K2esLTNZVxdToXtUZ9afB7PDkoRluVirv0bBnga/ruz6QjiQw6Ab1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o71qp7XnV3+vzOgmxMKX46Newv0v4HOuPetlJde34hU=;
 b=NE17dkp8LrU086mh8pIo0QgXWa03oXfen5c6NqjfYcl+9YL5FpUJRRe3fpqyjo7MREFHuSW4ZatzFXNmzuuXZE4vxs+1LyDIgEVWzQzXanFu7sSlHKJWsew+adq0m6UK65sWHXdd4woiDI17rXD8md7xOrjzETOtqtYx6kDupwtTh1M2iyqGpjKagv26/MtRBzLqx87Q/rj6KnocGfGpsTS51sWcz2OIosT5F5FB/qod+IyRqqOQfLNbtpmh65W2xx+kBq5JkOf6+CfnbupLcLTmc5wX9A0MnVeedjQd4fDfkAwM8H28gPtCoYpJJlfl8/34V2RTHlm9PCRdJmxyng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o71qp7XnV3+vzOgmxMKX46Newv0v4HOuPetlJde34hU=;
 b=Z7urmxVjA3U0n9ExnVn+hH0yTkFNghCmDm3DC9nzHHqoBaaHDUFkoOzT+/89Nt2AfyJCZVquOEcZVFUNuOhLyac1+sraQoklwgo2lVLNtu9AAX7cVHsvy5c2I66dmJZDdEQWMXA/GjLt71XeRf+CIG0KZ5GdqWvTLL2tAKZGriK++rbx63I6jARYRZShCfSzApoeyylprh5u4BvAvSmeyGuaSc7Ut+2pGJ3qwk6MScFUcJ9rKHYHT0E9G9/CT36VYYVxcyXiTG+e2OHYVAiDHz2yyFsnChuMZsJCi8cjcWcpoaJG/30aJVRCjaoSyaFNKSAGjoCVoX7TtW0xURxHOw==
Received: from SG2PR06MB2315.apcprd06.prod.outlook.com (2603:1096:4:b::19) by
 SG2PR06MB2298.apcprd06.prod.outlook.com (2603:1096:4:8::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5081.19; Thu, 24 Mar 2022 07:28:18 +0000
Received: from SG2PR06MB2315.apcprd06.prod.outlook.com
 ([fe80::ac36:fcaf:45dc:f830]) by SG2PR06MB2315.apcprd06.prod.outlook.com
 ([fe80::ac36:fcaf:45dc:f830%6]) with mapi id 15.20.5081.019; Thu, 24 Mar 2022
 07:28:18 +0000
From:   Howard Chiu <howard_chiu@aspeedtech.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        "andrew@aj.id.au" <andrew@aj.id.au>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v1 3/3] ARM: dts: aspeed: ast2600-evb: Support KVM
Thread-Topic: [PATCH v1 3/3] ARM: dts: aspeed: ast2600-evb: Support KVM
Thread-Index: Adg/ULsYAzQniKaxROKN3Gl5bB7qyQ==
Date:   Thu, 24 Mar 2022 07:28:18 +0000
Message-ID: <SG2PR06MB23154FA2D344640D9BEE586DE6199@SG2PR06MB2315.apcprd06.prod.outlook.com>
Accept-Language: en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: eea47e45-b904-4cce-6eee-08da0d67ddfd
x-ms-traffictypediagnostic: SG2PR06MB2298:EE_
x-microsoft-antispam-prvs: <SG2PR06MB2298F882D4E7F9F6D0C37DAFE6199@SG2PR06MB2298.apcprd06.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WH9wFqr4PTO3MWBpGTkklZZgtxiglQzJf9LD4C893Hrw7k624CYoZLyH2vbrkBd+U2acm/n5ubC920PqJMhU+u9cvoIqW8wm7xCBOqBleBkcihKW4MxGz3xhuGkObTZfvH8qbfsJ8qA4kf7RH6fY5fNmuzRzGZJd8S4OW5Nx7Vl7FmoU/zDn9KPOPJdk8F5x4IAAgI68zdg+zmZq/nPkaneJajQwk4tiOCI/O/jIIG7ARr3LG36QcTxxCaNmm9/foNElFXt4maBiGjRxERsq7pMhw8+MQe79u103q1eP+fAy8T3WxZj32r1wM5CjElAP4CUXqwz7irm4pRw+5BZ84DFZAgaEZ7haqV89ifbjns7xfTB9Fe98nR7OkzDY5bgCXWWndi8YIXt+kDfLFia2DS4dyX4poera9vw8hSNXM2o+xaTgF0ciy2plhcZNyp/c0KRynyeqLqvDbvp64jMiJKIuV0qSWYJFi4m+Q15CRH7oKozLZC/67nh12ICiIhw3efIP3ZvncZGc8QFyECYQRv117A9DyGarE0AbJZtc62V4Kyr1fNZot7h8Hb9C9A6dtPQueaNG/LOBSXNluxdgOjk/G/0xGP5/X/d1uRotSCujwQDllbONXf9ve6nBYpQnCUsNCG7zWOub3xo/K68K3wEK3e8+5/24bBfqjBzYRsxgffgX1KHcU+zKJQVpgs4sREAjSXel/8TMvZb4vUgCPg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB2315.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(136003)(346002)(376002)(39850400004)(396003)(26005)(107886003)(186003)(83380400001)(38070700005)(38100700002)(122000001)(86362001)(76116006)(6506007)(64756008)(66946007)(7696005)(66556008)(66446008)(55016003)(66476007)(508600001)(33656002)(4326008)(5660300002)(71200400001)(8676002)(2906002)(52536014)(316002)(8936002)(110136005)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2Ys5MADLSzMLqUArR3YDEVdX+FXT0xl26RO1YDhX+KqhTVvlxu88nnked5iF?=
 =?us-ascii?Q?Sin1VWBXtVKi7QjzDn2/vfb9aESlIbSx4JxdhkyBq9lh8wTjt4cx80WVEV8W?=
 =?us-ascii?Q?P+p/xexl5gHnlsB7AjkkoHGEvMnyKfYwhm1Cq22Ghi59IJYiDmSc1UNwEYU3?=
 =?us-ascii?Q?uUefUZB6cBXaWavhpqrUqF3JVIRkqfyrPNjiBnyMtBp6OzhXq55s5VY/xQOT?=
 =?us-ascii?Q?VAG/o+nVJDNz9JX262WX54vIZqaN4dxvlGPbqb79ywDFwrMPlDCZp88R1myP?=
 =?us-ascii?Q?GYl6MnyhvFa6fnmjue+ihjwH60FL9E4TZRQeSL0U8KycMkgAmgnJrIjIERW8?=
 =?us-ascii?Q?Q44sgGcQWPts6Er5p6B63h7fNGdzzp4+pdEtTtwbL/BcJLVz2fcJDZ1sKAER?=
 =?us-ascii?Q?7itdY2gUVbFPaCiIbeHB0as6e8fAbrb+7r6pSMLSF5JCvYVYzXn8dQTjgYJU?=
 =?us-ascii?Q?wiaVDfMza4bDNKk48iXj9THSJXrgMeBKzFBz7vJuVx0hmjOAGcnub09XrOgL?=
 =?us-ascii?Q?om5TC3Nff4wNu63yDgParK3N+pssVMlTIaXkMKQ9GmPKOrTQ4mYOEIYHcB4M?=
 =?us-ascii?Q?JRTkGZNdMjQFcjMAfxMBuFy4MShkdQV8OguAxKXefJgPxqbAsIW+DUH5Ii+k?=
 =?us-ascii?Q?ptOgEqWeFQEBAHvE+JJYBFYDLs5z7UyRuHF/GfWoJ0iXKX8eI58kN0Pfiiva?=
 =?us-ascii?Q?HWU2oUn9UWLMPHim6OnvXn/Q8seKGjxQWpnIoSBes0bJqsivbtMSVhLCwEg3?=
 =?us-ascii?Q?oLDvIe0hcLffS7kcfvFAA9BwLIPXR00Qh6L3h70oQEOJjrXSbU2zh2uL+i4x?=
 =?us-ascii?Q?hOSlQXIa27B9vtFSuhPnkcsDTsTMY02xO8qUYagxGvTdaWUWtjz0VDZp8pwY?=
 =?us-ascii?Q?D0BdenD1srvVl+DJIwU15QM9O57RasIFR2iPLe+LRx7zLO5GmWug1cbgEXga?=
 =?us-ascii?Q?n4ZBDyxIjpT7uCp1LvZiK0ddJ25XwD/n6ViRNA5IHaUfM1/SAXfYP8CztN98?=
 =?us-ascii?Q?pyk2I+rolHLu1fizWcFsouffBaZL0vnTXOKgl8MkuuqQeg7358jfLUSFOgFx?=
 =?us-ascii?Q?azLWesaRrAjpOMdvXIlO8Cglen+4tM1s7dAvbYIZpa/mPROptdWFJivrHQRT?=
 =?us-ascii?Q?56REU7LN5U/oc0gVSAjlhHMLBoxW5YPNoAKO6T6UdPcYjNqsxFMObP8XQesf?=
 =?us-ascii?Q?UoPrp4uKxREcGxMO/uBkMAexALoz04tNUKZ5g1ocIKIRmHFHoXfFoItn3Vtx?=
 =?us-ascii?Q?LYY/e4VCKGhLnU8LApFYAG5X5NZAzfUs0/klq4HEv4rEWQxvWiwzDPlrcc1m?=
 =?us-ascii?Q?euOsJ3nOLP5IgiiTc0WG012ofZ9ISQjP7UJaK9P60+VwaAFccZMsGkCTF3ml?=
 =?us-ascii?Q?xaG4ZIv8lOW2udkzcFqS/XFu+ax/aUEbBaAGA5Ti5PrRHHrdOf9hVDh1KLCq?=
 =?us-ascii?Q?Ip7JyvpRo2hGmwTT103FOJeuZzs1Zl7hpdDinLLxJPFqdDCT/SoQRA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB2315.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eea47e45-b904-4cce-6eee-08da0d67ddfd
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2022 07:28:18.1169
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EvUWaZd7VqC/qq3yDNzHlihG7coX5sVj9VP7/TStaIMsLznr5MVVm1ccWc9fwCotofl9Dkei+fPoEWChVlxh0niMxzC78e1nW0pKx1iQyJ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB2298
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable video engine driver and reserve memory for it.
Enable USB driver for HID support

Signed-off-by: Howard Chiu <howard_chiu@aspeedtech.com>
---
 arch/arm/boot/dts/aspeed-ast2600-evb.dts | 39 +++++++++++++++++++-----
 1 file changed, 31 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed-ast2600-evb.dts b/arch/arm/boot/dts/a=
speed-ast2600-evb.dts
index b7eb552640cb..d535a711bf5a 100644
--- a/arch/arm/boot/dts/aspeed-ast2600-evb.dts
+++ b/arch/arm/boot/dts/aspeed-ast2600-evb.dts
@@ -23,6 +23,19 @@ memory@80000000 {
 		reg =3D <0x80000000 0x80000000>;
 	};
=20
+	reserved-memory {
+		#address-cells =3D <1>;
+		#size-cells =3D <1>;
+		ranges;
+
+		video_engine_memory: video {
+			size =3D <0x04000000>;
+			alignment =3D <0x01000000>;
+			compatible =3D "shared-dma-pool";
+			reusable;
+		};
+	};
+
 	vcc_sdhci0: regulator-vcc-sdhci0 {
 		compatible =3D "regulator-fixed";
 		regulator-name =3D "SDHCI0 Vcc";
@@ -250,14 +263,6 @@ &fsim0 {
 	status =3D "okay";
 };
=20
-&ehci1 {
-	status =3D "okay";
-};
-
-&uhci {
-	status =3D "okay";
-};
-
 &sdc {
 	status =3D "okay";
 };
@@ -300,3 +305,21 @@ &sdhci1 {
 	vqmmc-supply =3D <&vccq_sdhci1>;
 	clk-phase-sd-hs =3D <7>, <200>;
 };
+
+&ehci1 {
+	status =3D "okay";
+};
+
+&uhci {
+	status =3D "okay";
+};
+
+&vhub {
+	status =3D "okay";
+	pinctrl-names =3D "default";
+};
+
+&video {
+	status =3D "okay";
+	memory-region =3D <&video_engine_memory>;
+};
--=20
2.25.1

