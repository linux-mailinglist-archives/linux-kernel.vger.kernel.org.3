Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C89B146A6BC
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 21:18:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349635AbhLFUVa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 15:21:30 -0500
Received: from mail-db8eur05on2079.outbound.protection.outlook.com ([40.107.20.79]:5857
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238795AbhLFUV3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 15:21:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lNpXs+zjyzawjtDZ3Zt4uBgWR02Xdo1rWd9pz5ZoalKcCuMhHhyvSUwinvM3M2hwjn8orryQU24sZtT+nfn7M5dVEYxp80eQDGZJx9tMIxuJMrOe6hMN5rjvojZOFvCuiPdP82YBkYT1mSxa7Inocx9AFx1NQFOU71/sqt6ulm3SHWQ8mEIckhWvnGhmnod5n/0IEPYRuYS9/yzRu7r4+U2OkzfqE4iZt9wG94gJOLf6VOm4fCMjUvvJW20eDMtwmqyZICxotY+olQk+xIagSeh5tsElU3G9Cftqmzz8Z/9Tjz9CbErgDdm8IhqC4F1f/nJYfMZDpexwjIiRLs8afw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UQReCCYYzlRi1YBSU1TkvgUY8STxb3nYABJc952rGjc=;
 b=UkXD8iLMQdVfjItcWNb5br6C7YRQgRAoruj7LzWXq6yMLDS82SkOYdqSqOcskHE9DMbYav4fQfuWMDq2KCoDOR56o6co44Bg5l3ymASUQ7tt/R23MZdeET4/HeQGo0yVnJD37uOhIUq5pysKHj0W/1cx/u4x7aepVc+H2k25kNieNp+smqf4Vy7cAzm6SXAmt3ASQQQ2/2MegzGwLRhdLPv0t9XqMj5c2czSI9rvdkIraSkV4WNmhkf2QbuklpLKMBFeiQGFF+GUsZT/TkAsMwpqM0T8WrAKz8ZWOTFtQDF3G+DZTzqFPYyUg3rPv/77jFPbdWKsUT9bpjbh7oZbsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=diasemi.com; dmarc=pass action=none header.from=diasemi.com;
 dkim=pass header.d=diasemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UQReCCYYzlRi1YBSU1TkvgUY8STxb3nYABJc952rGjc=;
 b=XRam6y2uLG1p1HLv7VVkMB0N2vH+3H34Cp1cJOckolkaiVB+Nc792KNvT3bnLQjWiV7QWTEYpbwxD6Sj5+1peVQVAfvU7Flvj0Z+2/NGzTeZ5erpybqWLaFOdbf6ZrtYV6kWzYrRo4vUeBVYYJlr0JX1k7gVyAOQqmfKA20znW0=
Received: from DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:255::23)
 by DB8PR10MB2988.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:ee::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.19; Mon, 6 Dec
 2021 20:17:58 +0000
Received: from DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::852d:c54f:8414:3276]) by DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::852d:c54f:8414:3276%4]) with mapi id 15.20.4755.021; Mon, 6 Dec 2021
 20:17:58 +0000
From:   Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
To:     Andrej Picej <andrej.picej@norik.com>,
        Support Opensource <Support.Opensource@diasemi.com>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>
CC:     "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "cniedermaier@dh-electronics.com" <cniedermaier@dh-electronics.com>
Subject: RE: [PATCH v5 5/5] ARM: dts: imx6: phycore-som: set watchdog timeout
 mode to shutdown
Thread-Topic: [PATCH v5 5/5] ARM: dts: imx6: phycore-som: set watchdog timeout
 mode to shutdown
Thread-Index: AQHX6m0s4H29VGZAdUSVhQg4H4ymOqwl55uA
Date:   Mon, 6 Dec 2021 20:17:58 +0000
Message-ID: <DB9PR10MB46523529053A18633680852A806D9@DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM>
References: <20211206064732.280375-1-andrej.picej@norik.com>
 <20211206064732.280375-5-andrej.picej@norik.com>
In-Reply-To: <20211206064732.280375-5-andrej.picej@norik.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=diasemi.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e0a0665e-ef59-4363-8bb9-08d9b8f57eeb
x-ms-traffictypediagnostic: DB8PR10MB2988:EE_
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-microsoft-antispam-prvs: <DB8PR10MB29884946826BBBF96ABA80B5A76D9@DB8PR10MB2988.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:747;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pkVLTx/O3Qupcw4DPO7hb1H2SAOiQ9FxdqG4kt+Uu2p3LYifD57eMdj4PTDWGPt2U3S/AL/3DHzqdkBgFgR0U/lzRxcx6igXb83bngrx5CvLJHJbywBgZmRdf4VyvjYtim9EhBzL+F0VfTeqK9ZOdd+glvqzWukJYOIldfskssMTGK6ZVYf0r2TYC66eAAeCmBzyyIuBur5gGJ+8LEmMRre1Gz3VFAT03JYV4DshUaLOqwZcDlG0cCg5YzO1YlG7uR8Lo24O65EkRh2byF0yW7gisjEcptf/C/99nojMTxJU8pwd/fPikIwV54qQRcxsEK/8RT2IWb37FGRR4ev3jlOz1eA0wCfLE1tUj5UKtBQ6DOkvVeLQZF2FuvJcb8Qz6Z1dL5PayzFYdWkyXbPITCwuNLlDQZeixUwrrkdJecdM2JDmbVCXpYjSzglJybjqNwwYIUweBA5VJFqPrgdJ3ujFFkSsGnTpbeStErQLkZp0g2HGio4tqR6kh9RTkN5n4OVsZfkFw3/Z1LxXycVbWbGpABvT+zyWi7t3Ft1KG+XYkg0qyocUA7uSp0XcJukQvNkHPQv9BSbXKmRO7lYFVJi86hLWteGgYH+kTlBiaOM0FPj6HaHnuukd6OALTUbK37SYauP/REeELWiejsMbxh7tgmtYD23dPXfdcBRHl8DBck0qEiWVBkVQSRpjavNwklOKBlnsHJmPClGYHUfG5w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(7696005)(38070700005)(86362001)(55016003)(71200400001)(7416002)(33656002)(4326008)(66946007)(9686003)(8676002)(53546011)(316002)(66446008)(6506007)(5660300002)(52536014)(508600001)(558084003)(55236004)(66556008)(26005)(54906003)(2906002)(64756008)(110136005)(66476007)(8936002)(76116006)(186003)(122000001)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Hz1rYzV6XzeR038Wi7JBfI8oVhpkpAgaxeK0mRImmBjo2wiRhQcKXcSiLwjs?=
 =?us-ascii?Q?8JSsPW4o37wbgoX01k88C4cY8b1pjzkwspwgkfiHTggE9txciWTMt2CXT9uZ?=
 =?us-ascii?Q?V6hpCUx+650nNr83AMFVHoJLxBPtth1YgEoXrSrqi/GacSuwQ95y3qlFdksM?=
 =?us-ascii?Q?Nd+gf5LD2ttOLXr8HUkJd3Hr7/5Dxt4cj8GD3pIJ1ow62IGYop+pk1mcPF8Y?=
 =?us-ascii?Q?Mz5Jkt2IX4z1Kwvx3twzXODNTgmu9gvXK99BM1wa/Iz488GT9vmekdLnKptP?=
 =?us-ascii?Q?yPscx8LdOlMLOjVt0w5R2OrmspVf9De/naP6YgiCXKj6JkYhqD0T7ZxMIqfS?=
 =?us-ascii?Q?+bngeVuyOeYET7IRtC5+mSbGsRc+dKdaouqUhweS8XW0YNO/C4zDo3eNGuvt?=
 =?us-ascii?Q?f0oL98SXdl+r/y5w7mHTANio7goBmJfs7XqQVBMEMh7/glUTWW7SGdeb53qG?=
 =?us-ascii?Q?XWQlWOsvuDC6MCIIA9ix48Z+IhrE1utrv9pLcK7x12TT+skkpysucV6aCId5?=
 =?us-ascii?Q?3m1gTJmnVWBSLwKRzRbHagVexaF7loxoPyUzR3v/uWKoOwFlfZzkxLHsvL5D?=
 =?us-ascii?Q?Brvo5YfjoT4yZtiC2I5MwIBskZ3yqZR+DvOTrlpRbqnoGEH8Y7pizv4d8CLL?=
 =?us-ascii?Q?KadpvY8UpAGI7Ev9R+LLub8WWI0nIGnIY/wBJtFg6fhHvc+hZewX4tYOBIlX?=
 =?us-ascii?Q?sharIwGe7mRvScUMGazsMVmHio6WTJ+nupbbq0pPQJwHKzjJGij2Wx5K2hmH?=
 =?us-ascii?Q?ojuinYZtv7lBuljVoCK/7zFE+B9zcqXlAXE4P15mWQKkDmW7bSRLaoFQmGUm?=
 =?us-ascii?Q?xOxyPfPnnL8NULz8bI80IwQ/4kWCY7LjGwxeqMGKoZKLQoDjhzOQyJXzoWvg?=
 =?us-ascii?Q?rJ/+IjxLkgq3odn27yFNokHUYh5XMoZj5CAjpB/yLffJQwpL2EspxnYUzlW1?=
 =?us-ascii?Q?+FlN1UUqnFTrDC3Cfs6qkokES4qgZrWiYkSAJUHlXoeqoYAwvstPMXb5Ddrc?=
 =?us-ascii?Q?NlTLEzXhN6TLxYuNDDcvbE5k1lWW++3OqU9edT4R8a9iZIpmPfw8MlO15If9?=
 =?us-ascii?Q?nPN2m9Q6nVtA9zhvXQFeYM0EhrDUGKhgbqLpoR6D/hlLdP9X6bORpD58gKGY?=
 =?us-ascii?Q?ZanN48eLCaswHGr9SxwqpTQnrhrNHxhihKUa0zBQhX4L2ovkwRHmOThorGsG?=
 =?us-ascii?Q?mhuK/HjHRd1hMAMzAZxAEdaId/L0XtAQiMAaKYctPuhpK8P1OhHo/c6pItgz?=
 =?us-ascii?Q?QdPZxWwJH6qiELY/3KdFsMz+Vd7u39C5LTGZCZ8k4Vvt3uOyP1Hq9aAKRhvn?=
 =?us-ascii?Q?PNMTCTXnEKW5UZGn1sZVBfwqxDsUWCluSV5y1LRyWylA0tmGnDkgD/uKMrMq?=
 =?us-ascii?Q?dxZ8o534BlSeM3jN1u+Gd6Jg8tPtv0PKkerNmYy9zxNh+XWjbPDK6/NwLJDe?=
 =?us-ascii?Q?JON3r/vg7TeLtrLmVPOdI2yVTCkixo6iAK+hD2eQJiSQGL3vnivxsfVs+O5C?=
 =?us-ascii?Q?yzJ1cmjqjYCHe2/0DYvrSm61qRZqBX/Be4NJmPrt8UkioJcLRzBVj6V9FwSe?=
 =?us-ascii?Q?3PFic8SnAP61JjUh19BFqBnPhavOf0tzwgx/bTZWYHfTUzGoVGalM1EQmNju?=
 =?us-ascii?Q?DGfFpBp12SyiWYuCoWGLAxDj600rZeFwCA4y2KmaT28RB8phRfI8aIckoL+1?=
 =?us-ascii?Q?zPhACw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: e0a0665e-ef59-4363-8bb9-08d9b8f57eeb
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2021 20:17:58.4484
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D1aoWcWYzsaHJvrp/OWXycX6lou3+eUJpeK0i4bVy+AhVhd1oDNF4RqrRIihsNobktdvcq2yAQB3I4ScGVroSJyB1+LEMehSaOiHIQRb6yg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB2988
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06 December 2021 06:48, Andrej Picej wrote:

> Enable system restart when the watchdog timeout occurs.
>=20
> Signed-off-by: Andrej Picej <andrej.picej@norik.com>
> ---

Reviewed-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
