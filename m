Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FE8E4EA5F8
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 05:25:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231702AbiC2D0E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 23:26:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231689AbiC2D0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 23:26:02 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2110.outbound.protection.outlook.com [40.107.215.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D00A8E1250;
        Mon, 28 Mar 2022 20:24:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HwNHEfwn5kPRFhiQZN2gr7eMSQLN05JATOv8za6xpngIytaribH7GrDHM7J6Ky8dPwiJCS7JAeFri7Pozs6Ea0N6ltGJ5H9dEPJSt2UUV5j6govHYwiiQ1vYY5xEUpKl3YtaYYflJQZdv8qKn9cdtm7q41xxgJvhHCfDXbzanJCvxiYzxyUVD1kZJGkh5OxIMIc3Q17bl6kvS4MCUMtUgjg9VQzzu2foag1b8adIXZLdOiumGF1vuglWMl/lOGU8qFBUnb2L2p8Ryu3NC+L5HNkrkKVFZN2lRSWSheTOvs3H+mc30UEXOfPewZ2UMY8uut8j0flkbl6zv0yAX1ZI3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Njy91h3N2pLFwf7hdeBah0EkI/CQ2MTL/T2tA9lqun8=;
 b=f34EP+NfvgF449ifvqZ4hep0pSvTocuMxojgA47t9+4AfYmcENYXhcc4Qen8llrN5reP2l0Kmwrix5XsO5PQBch2kvhmAOcWZ3yorjkN+29OrZ9Ag3ZVS0XhwJ0DhNbzd7r/S0JN4uXb0pmX9uYh69E0qWI0TatwbMi9QZeDlziPF08NFUadjieRtoop0MAlVeSO81QPq4WJ16BYYwuHEctcPwuZRdImBdD8EfurlZ8TfHQrs5O9XDUfkJLPIkwBeOrg9wvotY9wU8nyhBlH/UI2QTLwV97EFhyNayQjWxI41Z2A8c21okYj/5PuIKsxxykl2DDnYSQOXFLsrHhdTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Njy91h3N2pLFwf7hdeBah0EkI/CQ2MTL/T2tA9lqun8=;
 b=VYfHMcoSXuzBANsAx+xYyCQnjoIoPedTqA6LRh+O0MLCXTGFpo14mCLRcCqVSPfn1hLwuazAzEbQIHva8tjlcjDXWtQzULN1tMM9gD1Z514wZ57a+74goYYxOvx3EJWnl1E3yi/0deZuvTwAHjrhdtTQYVLKRnKknmFKCBamsr/BpfqHystS98NF5yHRVY/m78oxDgLAEmZvljLQgF9ghOt9zGjXrptlI7ilqPrFfRzOOxz1F+EYk6GzpiGqVsRjAU/NCDyiIJtggzwUAMM/Pb7bvTYZqfJefOHnblwMWlSJ7U+bfx+X4+NpsdSWdzZHXYbX6bMa797Go0ReNMyBbA==
Received: from SG2PR06MB2315.apcprd06.prod.outlook.com (2603:1096:4:b::19) by
 SI2PR06MB4106.apcprd06.prod.outlook.com (2603:1096:4:f7::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5102.19; Tue, 29 Mar 2022 03:24:10 +0000
Received: from SG2PR06MB2315.apcprd06.prod.outlook.com
 ([fe80::69db:d6a9:d891:e1fc]) by SG2PR06MB2315.apcprd06.prod.outlook.com
 ([fe80::69db:d6a9:d891:e1fc%7]) with mapi id 15.20.5102.023; Tue, 29 Mar 2022
 03:24:10 +0000
From:   Howard Chiu <howard_chiu@aspeedtech.com>
To:     Andrew Jeffery <andrew@aj.id.au>, Rob Herring <robh+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v4 3/3] ARM: dts: aspeed: ast2600-evb: Enable virtual hub
Thread-Topic: [PATCH v4 3/3] ARM: dts: aspeed: ast2600-evb: Enable virtual hub
Thread-Index: AdhDHCPizwz11c+oTYCkTWVlcfbcaw==
Date:   Tue, 29 Mar 2022 03:24:10 +0000
Message-ID: <SG2PR06MB23155E8A6193118544A7DBF3E61E9@SG2PR06MB2315.apcprd06.prod.outlook.com>
Accept-Language: en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4c13a33f-417f-433a-2cc0-08da11339774
x-ms-traffictypediagnostic: SI2PR06MB4106:EE_
x-microsoft-antispam-prvs: <SI2PR06MB41068A3D9AD5CC789C54AEE2E61E9@SI2PR06MB4106.apcprd06.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IIqrntTcJPZ3PMHEzByADw7exCSbUQBzIB+VyeugLpF5iaX3Si0H4lBNFdGHA2Q/U18lhAqSY2GQf0bHBPKk6Q+tPrZycoGzXqTC44iBqEx1ZEBzAivSGxEq9ttGiDW5ufXJfbf+7GZEYec14zvsTE3qjwmk5V1dkkacZtWi/a3qVSje2+KKxRfddSctW9aek9LkYUfBev1rFhUoLazfTu1Faiz7emwgraHluxVZB7JsQbkHIW88IYH58lT1c7fPXTId2soRu0ADC4iOdlea3AfLgpaJkF72TP3+N17jRPWQLg2W7/KeK17d0KC2pwSBZuyFrTt4cE0n7tsZOThf+zD3reUvFXY501km7jpllgFtY05k9Pq7999zz0ALKWYa/4PNQc2Ws/OCIEk/oDhwAEtFzphLgDm8E+bY+xqiZRne9C8Ms5cvGt0eBx26eJP1XpZwqWy41GTvB7hr4PNEBLYaZnyhAS9fGlW+kfNC3mOCPM5u5umCZ9RJpLwIi83EMNnQ7k6q+zBCQvSKwqCbhXd9EItIWJFxrCrs+iduIPfPlu0hUGxUFUl3E57FzOb4gEj6WcviLA81Su574go/zZox+NKRPKVGJV9onFVEC45w8MnP/n90bDOQcj24LRx5oPaXOFPh8ZtIzO60e/zZfc6L7nS9YcWnp5taqxh2KGDJIgEtAVmiWejjs0yQMJ6Tiy33IxUlBVgJu0vQb+4M4Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB2315.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(396003)(136003)(39840400004)(366004)(346002)(376002)(8936002)(4744005)(5660300002)(2906002)(55016003)(316002)(110136005)(71200400001)(26005)(186003)(107886003)(508600001)(6506007)(7696005)(9686003)(38070700005)(86362001)(52536014)(38100700002)(122000001)(83380400001)(4326008)(66476007)(66946007)(33656002)(66556008)(66446008)(64756008)(8676002)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?m7oaV1nZLrysPevDO85ODbRSpeJrwjIYvlyyr4XHKjwyqCXzH11sRt8dl450?=
 =?us-ascii?Q?BqESuFDEe9vgJ8BxskYvqPAdt8TOpY9tz6PAmdGEd4c2FlF8s0AP9kHNrE9p?=
 =?us-ascii?Q?YVfSYHr+moPl6AcYNQoy3WNcWOL28RoegVJz3DPcPv08+NOyUaJTaDW6DMMV?=
 =?us-ascii?Q?wX7VgXpcwN4Q0osrpwk9dRk1i8jwOEX8nMDEiHq9jmNbvNE2iaU5CN+KUmA0?=
 =?us-ascii?Q?PCgbFAvA4rW727YAo4B1vluxDjBPiuIK0WjWGxOSzGQpmwEHYxDbSZGJayp1?=
 =?us-ascii?Q?2AwEzAFVVM+ec5m2ksD19uunBm7G/ZGonqLlmyOoOFT3dMzPvMrN4/oCHX9Y?=
 =?us-ascii?Q?cpiVHDQkDmwIaL0jO/qz0Fp50ZmOLYuhFYUbK+27tKfgcvl80T4Qpc/g6doi?=
 =?us-ascii?Q?ReAqjIrvOOH2SJ7/jcHyjDdAWgbqLHeet2uRTcdBctG0DxmVpy6maXyWsL6j?=
 =?us-ascii?Q?tqtiqCClR7iYAd/RbHScVCB/X76z8g5By9Qr0X4Kr2NiQGmm9laZBiv2niN6?=
 =?us-ascii?Q?WrLZsaleaSNRwD9B+nIOm7oifKmABypqv5h+fHwgRRMcIGTOs+sssWdexMbK?=
 =?us-ascii?Q?dt5upJAk7zVi/FwjU6bNLK2o3JJh7yiPiiB6VzwKI+TO9YKKirXvZOEAVyhM?=
 =?us-ascii?Q?6Rv2x3lz7JdsZwxinJsOcDIA4i0mvUp614UnXy1Ti4HjVJWp/btAkGT5yckq?=
 =?us-ascii?Q?msTLbpATEweBhfUUInaW6QRUacR63Z+Tb7+gPu+WZnDZKbNdx4kOc0cS8X6F?=
 =?us-ascii?Q?c+ErnTplBGVDKUXAGD+mS7VbfJshd0pmsNIUD8Hzjg+CBuOAXxjMeDCJ+oPI?=
 =?us-ascii?Q?BKAqj3GK2ecV3weLKL4Epht/05e9pbf4KAW1gR4Qijgr/sfHrYeGJuRs1/Yy?=
 =?us-ascii?Q?AjFl7+ML+fDl8aNMcHGf5LKkG6Jj/AchOQHh8qBLrKVNzYUuhVwnftORJfZS?=
 =?us-ascii?Q?9ov7uTWEHbC/S0kfYf2uAxw8shZ2Mz6nySJL+wMJ06MZuK93ILh7RNW5m25J?=
 =?us-ascii?Q?wYzpV8uUUB9hOjseU6LfHmqYYKJTcaWLDpftLhmDus0RYu2Vd2O4vpHpqThT?=
 =?us-ascii?Q?+CU7MO8gCVmo43kUZi4/hlJiE0TTg8YnRQkV1mIIr8aUdi69Tl3lVl+rdERo?=
 =?us-ascii?Q?b81VFBKgbxfk6eoYdSEWcUqgS0gDFs/0yK3AXzsCsOTF50SNZduq/x46QZkT?=
 =?us-ascii?Q?CjQDDMuwvWPR3iqwnmx5/LNnF9LlbMDEiNVEgTpoxojAoAko0Hjwfq0Dw0lZ?=
 =?us-ascii?Q?dzR+8iy643J2PZocu8+UDacBf+Lud7n5oSHlewXbbXSBNzwtTguZUUuwS4l+?=
 =?us-ascii?Q?Ehs1b85kB9EsC1nuJ3XV8lscSjuFqh2UijZBSy93suNnYM34GBIkT9qwTgt6?=
 =?us-ascii?Q?aRLpGz/66VTTCXyprKkalFmjyUs3n7lWkiT8WcC7sHugG+FE/y7B9DovnO4B?=
 =?us-ascii?Q?OYwM6OFcMNgBXFCCdDcRpYZEZ5D1EkZHKmL3bJG96QqeqGfDFMhj6pRvCYhX?=
 =?us-ascii?Q?bCQTCEL+YSzb7lkZmlPk5FtMpheb5UkbcFdzmGQI8cRbQDJjkH8vAsmsXAT6?=
 =?us-ascii?Q?iQtlu2IT8VxD/nb3vFDkhDnmi3YdwafkJL1wOX/aAbcbSPBj1MOjUI21mtZT?=
 =?us-ascii?Q?Pn8vyDJhySc8aBNoy13hE/DflnGVwP6QRTEnkfklvrjB2ARrqttS5RbYf3nw?=
 =?us-ascii?Q?OnOJzOZF3xJgqepsHNkD1ukxkdpMj1bGAq0/u2d9yRj4Q4I3NddJF/Eirm5h?=
 =?us-ascii?Q?tMltGfjnO65FuFyUIFyLn1xnjaWlJ8I=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB2315.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c13a33f-417f-433a-2cc0-08da11339774
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2022 03:24:10.7074
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U6ZozYCjPEvTZLFUiwUxRYV5wcGWO4lDKIPEdHHC3NlXcKzdV1iOgFSw/avU60NcBUPwUcnlilm8hUPubA7h7vMb0FstwWHD59t7aLd69es=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB4106
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable Aspeed VHub for HID emulation

Signed-off-by: Howard Chiu <howard_chiu@aspeedtech.com>
---
 arch/arm/boot/dts/aspeed-ast2600-evb.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-ast2600-evb.dts b/arch/arm/boot/dts/a=
speed-ast2600-evb.dts
index 158b88f38d2c..b98cdad86e90 100644
--- a/arch/arm/boot/dts/aspeed-ast2600-evb.dts
+++ b/arch/arm/boot/dts/aspeed-ast2600-evb.dts
@@ -314,6 +314,11 @@ &sdhci1 {
 	clk-phase-sd-hs =3D <7>, <200>;
 };
=20
+&vhub {
+	status =3D "okay";
+	pinctrl-names =3D "default";
+};
+
 &video {
 	status =3D "okay";
 	memory-region =3D <&video_engine_memory>;
--=20
2.25.1

