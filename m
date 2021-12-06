Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 572E2469048
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 06:59:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237524AbhLFGCd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 01:02:33 -0500
Received: from mail-eopbgr50058.outbound.protection.outlook.com ([40.107.5.58]:23520
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237447AbhLFGCd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 01:02:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DyWLk8g4+vn7JpaW5vmtU8aF4u6h2t4xmE3HwVkGjcoAcljYz1/YS4+LDtt8ljKPSpmeoET01zsceD/XWfoJqAUMmF8GudrxyojfTcNN5jywcKIbn16sjePez/boqJsajgU+mNk3SD/2e1aslQywpVUme+tRf/4aBdVH9TyDdD80AJb/cK0AdTQr+60u+Ha4e0wfnttgXs5TDzF3yIwmMGthR4DWkFA4f9bxVVuRJoqgDWrpgkM3avIXuBjgpW82ewNefsnnQdj6fcdKZ/cO7a+rmP8/U5JwetIDV6IoGBUmasXa5gRnggZvIpsW4lABF48NfaXWCgNCtGT8DBAg8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LLqT4ol7gIPUudxts/Z7U54BIDTamkOOwueghW0fkUM=;
 b=CEuVuhapzgzIq+ZAKA7t+EdhIWCnkM01b7bikNT+ZtchA9aMUwgmS/1dnsV1YFOHDMJia+3IDMZwg99aYQWUM5hT2fqQ4diiAR85efbiH66qNU9bBeqesOneMrtSgG8H6psxu6FSmfyNxt3Md3KxVD+5j2kcgBGzgLVdIl+orbIj9ziNf4LCC4xdluKuaI1Ielb1uT2LC/8Oq8bNUoulYL4o6ZrZe5y4rvMkdeg6HjHVHrUFNOn5fg14FeHtnxFPcHGlI0jvHeejmUAumSA/j1v9nuSEvXnrtCe3Sqgv9t059/qW3p+CZR3o+3hfkuut0kc9hY38BwP1kvRP0bljqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LLqT4ol7gIPUudxts/Z7U54BIDTamkOOwueghW0fkUM=;
 b=c3gCe2D09NKgocnxMs7LrDQ03TJkH9rgJhBRSkNpGFWG/wejZ7NgtkCkBLIM0UyZExT1woPb0/SaSBCC58STcIIC5BtpSLHv/5K3K5HDwfeNMwyMUhzLf1/VrhHPwfZ2kEeNNUVDjIRTnVluJVoe2x7RTQ5UDzySZm92cQW7Rdk=
Received: from AS8PR04MB8673.eurprd04.prod.outlook.com (2603:10a6:20b:428::9)
 by AS8PR04MB8658.eurprd04.prod.outlook.com (2603:10a6:20b:429::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.16; Mon, 6 Dec
 2021 05:58:59 +0000
Received: from AS8PR04MB8673.eurprd04.prod.outlook.com
 ([fe80::18fd:fb52:8077:a52]) by AS8PR04MB8673.eurprd04.prod.outlook.com
 ([fe80::18fd:fb52:8077:a52%5]) with mapi id 15.20.4755.022; Mon, 6 Dec 2021
 05:58:59 +0000
From:   Kuldeep Singh <kuldeep.singh@nxp.com>
To:     Leo Li <leoyang.li@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Leo Li <leoyang.li@nxp.com>, Shawn Guo <shawnguo@kernel.org>
Subject: RE: [PATCH v2 10/10] arm64: dts: lx2162a-qds: enable CAN nodes
Thread-Topic: [PATCH v2 10/10] arm64: dts: lx2162a-qds: enable CAN nodes
Thread-Index: AQHX6KEtJtjjo001/EOZHywGk/idnawk+l7A
Date:   Mon, 6 Dec 2021 05:58:58 +0000
Message-ID: <AS8PR04MB867314D9B214B6E4D05D29D9E06D9@AS8PR04MB8673.eurprd04.prod.outlook.com>
References: <20211203235446.8266-1-leoyang.li@nxp.com>
 <20211203235446.8266-11-leoyang.li@nxp.com>
In-Reply-To: <20211203235446.8266-11-leoyang.li@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dac7171d-f2bb-4371-6f1a-08d9b87d7ef4
x-ms-traffictypediagnostic: AS8PR04MB8658:
x-microsoft-antispam-prvs: <AS8PR04MB8658F6760603D9CA8BED3FE6E06D9@AS8PR04MB8658.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:243;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8cilQAiBEL7plSFaEAgHAHewxxWsyLoAyjVjdo2RjKNH/nd+5Hy1eoj6Su3RrHtdYKSHvgcLMBbS746Y/EOFfsh034F6BNtZtlJ0ejPqnN0022mhMAmOEGtJ3ttQBQ4rsmbtJR/IGqEyxoow2lwWTKzEKd+yqmaXAspsXbaSX8P/IjM9iCSsSw1rFUgacF22oKyKBvvLN7FPcJwMTjQCA6FrprzmlvEbHGNf/eBHJtfMhBGQEFlXCX3A0KmwI2fL7/If/bE4LZ614RDkWuEWkV7JPD0BLyykdUCKglnuz0v9sCY5Z5DlzLkNJLpWAN+rx/EV4Wjp08AKFaYT2ai/vDEspzPEdw5+2FMZUNOWd+uG4k1J3kkR/kuGp/UOIoiO0mGUILMq0nx7jrV/dOgY9n3nTx3/CRgQAmpjbrZq5T5pImyK+LyJBTp4CL5ZZwUnSARGvRODwf4oR2ATAc02Bcb8FeO2+b3tj1qfw9dLxuQLocA7c7tLUlsv2WRfiSs4FWA2hRtjChBmZsXZMBBEt1bNJEivTTxUKv0V5AncfQqDPh74CeFgcbxRmZ8S8aHs05e8SUpTUjeAJ+eOcBpPvTQy+AsnMmTRlvw5Ojsh1FWJoVHuWNIEmNm6PCa6G1tgoeImnf1TwqC+j6SbckUCnH2oHoe/kJfROAGXEUIb+UGEcHCN8gx8nbTc47K59crLoYzV+Y+SV/UyiuNlNqFzlwunMQakIkriu0lx3beflHbzVr5ZOzM9pdkKrbBXY+ek4DggAfeJWsJl9/U/pY/BUZAEPqHteAWViK9h33EraSg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8673.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2906002)(38070700005)(4326008)(110136005)(316002)(83380400001)(66446008)(26005)(38100700002)(9686003)(76116006)(66946007)(8676002)(71200400001)(86362001)(8936002)(66476007)(122000001)(66556008)(54906003)(64756008)(186003)(53546011)(55016003)(44832011)(966005)(55236004)(5660300002)(52536014)(6506007)(7696005)(4744005)(508600001)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Bfm7DIdI3XobQ73JTvaUFkjDNDnKWwBFTkCdb52MW2e0dlR1COVxPlr7Hlt2?=
 =?us-ascii?Q?gTlYhKvXmRGA0hVgzvtfaYO1YpmUgseh317R1/zaWov224VeMnphVf5AG2Ep?=
 =?us-ascii?Q?7BEhofc4UujXlm2euCXrthvLcCXfV2p0Uqpx4XUnjGPzPvHv33ibFxe+WJSp?=
 =?us-ascii?Q?zvHggr23KdwRe2XAo4S47zYW6crr8rMonekZrhZZ+x3JZYIlzN0i5NsWZYs5?=
 =?us-ascii?Q?1lzS2V28x1QQeZ2x9Bq+0k3T2BdrY0J3FzSZ2fYJgA+/m82IytNXCGtcT8gs?=
 =?us-ascii?Q?bwSNVzp7wNU0WLHbnft0iHdnjDNkspbqIH9EOVoI/hKfopi2xIgpLMaoVaka?=
 =?us-ascii?Q?7NzbdJwOs2nYPk/SgeXnXMr9dnd21TloLmr2eGBgqAEUVRP6ZGHQfxxBM0eG?=
 =?us-ascii?Q?jXqzzAOrkUSWTUiJawJA+dwD+xbffzi3jbZeRjhSxrGB+fo76Me6+35bm9IK?=
 =?us-ascii?Q?5zHfxI2MS6+EDL5kz1bnw27RgDvaBQJWqYGO+bfCQlRxV1E5g4RqejZtujAS?=
 =?us-ascii?Q?MJix3G9tcAfeo1yt5ks+agYG2kHKaPT5/I5x3rjpEBc05PYb4Ax9o4oGisWj?=
 =?us-ascii?Q?4+WvwvtT+qSf0+UxXI6jvWIXdM17j3Y44mIiLUb+Eqzt9vqeZqvg2z3uAt4O?=
 =?us-ascii?Q?qFJSrc41jMKDIeh+PyjKY/rJSx7fNPhTRp1e1tT/X0QIGIRjFGl/4kMU/hK5?=
 =?us-ascii?Q?hqlED4wFSztdri2lNUSihIDq2R4kcyfOY1Jok0EgU9WcrHLUsMFIrpCbP2hh?=
 =?us-ascii?Q?Q3ROzzghKT7Vt0Prp3uGOPGmITpDQmpwuK9SQPce8VkmqReVgta+u7LxSqIr?=
 =?us-ascii?Q?gctlxHq48KyxafPvrUfNTdPBaBpPUjV8hWLFNPk9MFTUggs0NCX/q5Oq5j6q?=
 =?us-ascii?Q?rquL7rMgp6h90ozuBAA3baE0BOKLO8idGoycc9o6BlgDwLG8ivfJPVIM30q7?=
 =?us-ascii?Q?rs/0nUZO79Iy9dm22vT3A+lFeB36m9juDzKwpwr/z4P68TAKMimIfk6EfGli?=
 =?us-ascii?Q?4Eot9tlXZqt1RY+WT9c3jvx4BFeiEST+Pdv3lr8GwBQCuZi5RYvSHVMrGJMP?=
 =?us-ascii?Q?V3/AXz+Pz3qPb8vHJEw2ZvRr5ObAEbEMkEDNvBjTljJ6Vx+rw77VbiANKJOK?=
 =?us-ascii?Q?ExyU7XI4ugIm8Q9FKV/vkGgO0AjAgBuk0Fs/IxukKoE+FBMJOVcnQvHUv0KX?=
 =?us-ascii?Q?Yy0m/aYSy8dbbj4sbUTwFZ0XE7Oq6VvFaCbUhp0Q7YBVs120HrpYAK9ANQOK?=
 =?us-ascii?Q?oXynWbUkgDOvZ4DhV7oxAI3sK+MFHThI5wfBLtdWa/CE9mKnl4aAJ9QmyTfM?=
 =?us-ascii?Q?ezqPXP/XhhK5qKPbY0IxlKEXgBfF7TtaDjKklAiUgJIO+AKu6HfSgMA+nuOU?=
 =?us-ascii?Q?oPK9bMmmlY44AstPnwlB9SZ9HJB+CzPaeKyK/I8AKtwFAC7jFcuWicVngNsB?=
 =?us-ascii?Q?71KTwuf/L4NPhbjzxrkHdCruzYD+/ZbljhMq3EQlh2BYH/eZgJfoadtOk1lO?=
 =?us-ascii?Q?3IVuqw5i6y4694wRAL6i6X6QFDOJMvsQkQrN7h4QbRj5lAFlHCfLT75zyUPp?=
 =?us-ascii?Q?W8AjkwEf4dhGqeYLeEkNCRUosAlRE2WieWq2KKOk0tqBIfrFLKzbBroqPeIb?=
 =?us-ascii?Q?dEm9Q/lGdbSqxv4BtfoB0Is=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8673.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dac7171d-f2bb-4371-6f1a-08d9b87d7ef4
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2021 05:58:58.8913
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p+UEqTh2FdV7Oq6r2+sK7v6j6BCcHAcrCIwHpcumcq4XB36SLTH58MXuuNxAH4UA9r6P3fHv5yTTrT9hH/yIeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8658
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Leo,

> -----Original Message-----
> From: Li Yang <leoyang.li@nxp.com>
> Sent: Saturday, December 4, 2021 5:25 AM
> To: Shawn Guo <shawnguo@kernel.org>; linux-arm-kernel@lists.infradead.org=
;
> linux-kernel@vger.kernel.org
> Cc: Kuldeep Singh <kuldeep.singh@nxp.com>; Leo Li <leoyang.li@nxp.com>
> Subject: [PATCH v2 10/10] arm64: dts: lx2162a-qds: enable CAN nodes
>=20
> From: Kuldeep Singh <kuldeep.singh@nxp.com>
>=20
> Enable CAN support for LX2162A-QDS in board dts.

This patch was sent to mailing list before and has been applied by Shawn. P=
lease see[1].

Regards
Kuldeep
[1] https://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git/comm=
it/?h=3Dfor-next&id=3D4172986a64dae744abe625075533ce38f6670019
