Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52BCA49C53C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 09:29:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238439AbiAZI26 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 03:28:58 -0500
Received: from mail-eopbgr140057.outbound.protection.outlook.com ([40.107.14.57]:19152
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238420AbiAZI25 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 03:28:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U/bE9IZHPUGawxyPQOLSs5MD/RWQzeP+R9wTA1G9UqFZyb9NzAth+sIjRkpx/NvVZbMZvbKmYY2BC46oILw/jf1itjMjLLVr2RM3Y/GyEj2GfKxtS/HjjqjMGCF/hHzrnJTPMN82hp0Xp/FTdODdB/YfEDGTjKV+jfO6VnAboreB8RukZN5ZDunThLjFrr2NH8yc3w2/hoV4pmhJqOgkPFFuY7zbQTvVLCdYfSnsUIfcALt3eKo6oNKnwDhESmvbVa0hZx8k/EOO1njXKWeKF/9ut7aKPFznUyi9OZhypI+oB7ZlOxmZoeOVggJET+SCJ7M023Exjp5EWjMUu3VMeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ce0FYjzsv7apk3rJAx+/DSMzHfFxXW16bcpUTFAeEVA=;
 b=hmfIdL/KxoZ8vwE4qJo59WvE2vIhvU9cx/PzZO74g3IkY79HWm96us3R+X+Yp6rUfsUCjwwyTUQQ8UhHYZ9h/nXQ/kR4w+2ZqIglUDdjbNV3rbA/bzdnd5R+2F94HLdjhhe3/De6ZW6PZIYjp4wJKjfBCh1q4wx2gcie9NJGsxXU5Pc1kOsb0wjMPEMyGlxS5pa5VaotMgccxlynW14zFBUryQ0v9UVZ4bvznZDFipoSOWy7o8hd4uA79wUMgQxum8R/cTs0RJ7dX8d/UhbnX+dktt8jrtQr621TWhmbTboZCR+EtTpna7Nds13lDCsGTBcfDihLXEocv59rm2h/dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ce0FYjzsv7apk3rJAx+/DSMzHfFxXW16bcpUTFAeEVA=;
 b=F5LfnEKfT3+7Nl+EUPQU+r+B40Vbog0I9yrxix6lA+BGG4s03b/AQvHACCPAmPew6PYs/Y5FvaV8Mikpo5h06Gcv2kLwcu2iWioTXi2jr2pdcT5sgz7EuxOKYAsG9PPEMoEEX6Zdd/mjN5BT/UrlL31v63vrYmX2qj1tCoyXQ4Q=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VI1PR04MB6029.eurprd04.prod.outlook.com (2603:10a6:803:101::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Wed, 26 Jan
 2022 08:28:54 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d4dc:8c9a:55d0:81d8]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d4dc:8c9a:55d0:81d8%3]) with mapi id 15.20.4930.015; Wed, 26 Jan 2022
 08:28:54 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
CC:     "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH 0/7] mailbox: imx: misc fix and SECO MU support
Thread-Topic: [PATCH 0/7] mailbox: imx: misc fix and SECO MU support
Thread-Index: AQHYATQIs7ZYZ2fIskCG97pRhjbKp6x1GigA
Date:   Wed, 26 Jan 2022 08:28:54 +0000
Message-ID: <DU0PR04MB941793A918C5E08C9A48BCAC88209@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20220104062547.2103016-1-peng.fan@oss.nxp.com>
In-Reply-To: <20220104062547.2103016-1-peng.fan@oss.nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 402377bb-6024-451a-8d2e-08d9e0a5e394
x-ms-traffictypediagnostic: VI1PR04MB6029:EE_
x-microsoft-antispam-prvs: <VI1PR04MB6029229C52D56D8A50B3A31E88209@VI1PR04MB6029.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: elzD6SlGxjn6GG2GFzxjCWN8dOtBCD2+XCPARQUGQ7/Ahs3eZs+ykBIs5++SUWqAFnP+BDFyASZSDwhrijXTA47YKyvmCQ9xuI4gcX/Gp29dXxlGm8/6mEzR8KSdUSaFz70YVXwksSI96ujpdhYGAIpLqzrerSDnQEnbsHBka8quEBtLteV4CUMWmBSehc+s08nbJX4xWpHPH6WBcobgfwpjkQs2PyFfCa6ip6N7B0S+D5LmZ9WJNtOBO/TZv2k218WAFdxN9hwBgVSMi6cVSHRQYEod4o7mrMu5FTWyJUfDfsARq+yiarcP28rcUOXGtgkB4w1ofRZt9+50NWPhbBAX8sjAEe0H9704DCNMD3OMHrfurDlVK0UID+fsvCuJ09+yDeDGloqA0pOvEUSv72dEMWmowIKBmmaoyKc47YuUg3d71DhhKApQ/76p5lVl1L2GXrv63x1LmBl9HXKWBYSjuqpRncuUpSoBSPbIees+8Zi2pOySdZzR1gimimmvhnM7s2r/vHE1GggQuXKbZccb6++gh5tFlNYolDAxlIgDwpBXsfrDVOW3sx8iSdajPBwDEAFfcDQKDKu0WNtfSEkqvjVbZQg4+5LXC/HXNmnzabDHmlEddJ5YKmejsrQP9u8PFqCvuf+0J9ca37BWbQDIaet8tetL9xj4/Qy7E54TblKvn3OnUUav/nsL/uKy1dCi5bP5tNCKH9fTGwFi1Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(122000001)(44832011)(4744005)(15650500001)(38100700002)(71200400001)(38070700005)(110136005)(8676002)(52536014)(5660300002)(66946007)(66556008)(66476007)(66446008)(316002)(64756008)(8936002)(76116006)(54906003)(6506007)(55016003)(7696005)(4326008)(508600001)(9686003)(83380400001)(33656002)(2906002)(186003)(86362001)(26005)(20210929001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?D/ao8TDtryKY+Ck6ymkX//ok+tVR3s5/mZZnmzqdvIg5TlaER14SbhrvfHUS?=
 =?us-ascii?Q?o+Osdo+xAUUT0fkpLhbO1y4O3qgMg5fPI4mYF0bRO3jVhbxi8e8+ZTj4AMdE?=
 =?us-ascii?Q?yaUW+XZRFlY3XtHLBW0BaKkkn2k4rnNjDkXvxTKuazWGyXxWlzn2N9otr/YA?=
 =?us-ascii?Q?Ero3h0GAaiqgaEgV+K/bDtFqVKluNwCyDEqi5zhUkFF5r1knEMPJp6909P1n?=
 =?us-ascii?Q?R+2MC3xMTf2rnbDiHLTPfDZB2sBFvQAOn7zdZucpugW8kwOBbXS8JvOH1JA7?=
 =?us-ascii?Q?bzZACdJh4i0JK311u5j+jGFrqOY+kfZjfeQ8l3Lmie/ozmE0vEMJcSa2bWj4?=
 =?us-ascii?Q?Nf6+ZILIL3Jg4bnkQCI1e0SB798wi8xVN6pemhKhf0tiJfG/PVnL5KklD9Xd?=
 =?us-ascii?Q?FKlKq+F8LH6kCaeJ7MPWCMHz9pEpNjshpdxIw3jYI5Wddw8tacn7UmiwqlnM?=
 =?us-ascii?Q?yYDlckrkL2MYhFLQDIBeeaczB99haV7zLFAYPmLBYf3ytADeo2HQACu1pZEw?=
 =?us-ascii?Q?kVLjK49EWiy3fLuhRBIS8yqe7w4l/pSW6OUispMltJeaG5EGzY3G2JMHxElm?=
 =?us-ascii?Q?dZSLETAhD3jACd2GflotmMi4jIHqsTqAoyVH6itmxPPUpEFNFFz78kq1ClSb?=
 =?us-ascii?Q?ZKkw5WAV+O5CdxxFgIvbx5RHQDmSe9s7ZdMhLtVIylp0mIQXZprtGGbFirGM?=
 =?us-ascii?Q?H7DeZTqRkeWNS0n7P9o3esj7JVbHzkNs5JEbkAEuFbFpE8IDf/6SLqUbMbvU?=
 =?us-ascii?Q?MrAXMmdvzM4qc9gNRp1k5ezXulg853wxW4OA4TQvVPcfrKBZHItRkgmp/jtJ?=
 =?us-ascii?Q?P48HYg7Co36CaoTegI7ENSniru3Ut0R/sjdWZ1aDYTR5m2MGGiNtMiSIIR3C?=
 =?us-ascii?Q?DPSwsYHgy9YTrjrdVVpt/QkfSn497C5581tFgI5oWt0pAfG2XGKlDYtgpch+?=
 =?us-ascii?Q?CYInvqfkG4lOZ8zVs96opX6CTRn4Syg+fODGLvZ2WBCyGoO7vu9omOFtIGk4?=
 =?us-ascii?Q?opDywb1Bgls2UQi5khXplY8R75WVklsp5ijSiNhh8wLRa0ne15iKJ9NGW4T8?=
 =?us-ascii?Q?zn8PV0AoR5k/Geroz79Dx4H3yeO33rGX7b9JkCQCHhuWCo3cLkmaq7c4g03h?=
 =?us-ascii?Q?yMnzJl9pcg5ZLGP+dpMcWYAS3jYy3tHFYgNo4KZIDF/YblNud+uwSVs5rL8Y?=
 =?us-ascii?Q?1VJCc8Z8xkI1sUP1DNMnXtZZQSUWxTyrhUaHwpFREV7wmA+oFvqMVkzMC9Nn?=
 =?us-ascii?Q?p3itChjG9RT0dQT66FqCY8Wzy5bOIgVicasAkOUY8+p+FxUMKyAZO+vF4R9V?=
 =?us-ascii?Q?bHdtf1q3Yhi6JWr8oSV529sqSrvfQp74JoPANKwRxGAAndiLqxZRqjJv3eKR?=
 =?us-ascii?Q?OMJT6BBxMaXxQu8ChAwpbgPSPhHBGdjBec1RRmnAMHwm/pQ9p788mSN3lESN?=
 =?us-ascii?Q?ltgVk6pCa9cbs0LNXKa8yrlQwLhz2UonD42F/kGGBBBzT3PKmqfzIOxxQDfM?=
 =?us-ascii?Q?r9jZdjjF3EPaa5PM9zzPtB4q95IJid5KVDQ2R39rFS6OovJVSwKiEnPCTw3i?=
 =?us-ascii?Q?mUHml8HHyVfYkk3FqV+Nn7uGUC4g4q0asYNp7VI4SrqVualcgy9YtaXc2o+h?=
 =?us-ascii?Q?4Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 402377bb-6024-451a-8d2e-08d9e0a5e394
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2022 08:28:54.0775
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MIl27qK7nJbY2dDEUwjh65VrnEfPNrk95nmc2PNb7mCtLFFRvuu8xvi2+yBO+LGft8WLLlXZnMRVR1Uf6HhXgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6029
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: [PATCH 0/7] mailbox: imx: misc fix and SECO MU support

Ping..

Thanks,
Peng.

>=20
> From: Peng Fan <peng.fan@nxp.com>
>=20
> This patchset includes a few fixes for low power and i.MX8 SECO MU suppor=
t
>=20
> Franck LENORMAND (1):
>   mailbox: imx: add i.MX8 SECO MU support
>=20
> Peng Fan (2):
>   dt-bindings: mailbox: imx-mu: add i.MX8 SECO MU support
>   mailbox: imx: introduce rxdb callback
>=20
> Ranjani Vaidyanathan (2):
>   mailbox: imx: Add support for identifying SCU wakeup source from sysfs
>   mailbox: imx: enlarge timeout while reading/writing messages to SCFW
>=20
> Robin Gong (2):
>   mailbox: imx: fix wakeup failure from freeze mode
>   mailbox: imx: fix crash in resume on i.mx8ulp
>=20
>  .../devicetree/bindings/mailbox/fsl,mu.yaml   |   1 +
>  drivers/mailbox/imx-mailbox.c                 | 249
> +++++++++++++++++-
>  2 files changed, 243 insertions(+), 7 deletions(-)
>=20
> --
> 2.25.1

