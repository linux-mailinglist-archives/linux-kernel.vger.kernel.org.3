Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C34853F4AE
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 05:43:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236376AbiFGDnv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 23:43:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235977AbiFGDnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 23:43:46 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2126.outbound.protection.outlook.com [40.107.215.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 787A0DF6D;
        Mon,  6 Jun 2022 20:43:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n7RFBc0zihoOMpyX9YAdTfcOHoNLSlyDoDaRBXaOCIwsSv+vVBrVOx2GbBsQhM8ACntKAtNjE3r4Gz2UvRBj7bRa6cx8kIHdQjJjCzYoR6MWIKp1C4obrHpY0Ulm/crbeuF6S9CDg4HfN5McLIHNQj4aVVWogLgudzi7Qo0WhW/XTSrEaIOWlfXoQweb/8RoMOJMpsdYQ6n8qiM6LMsgV28zx8KoKXbaDR1j25EIvsysJ2NmvPr2ijYaTlIzog764UBnI9nAdhj3/7+jOygJFcVcPldH3lT6AgxZxVyY3I8dnCfB1GgWKDGjHRa2wWU3OYjjhy5NzZNjAn/I0dRmlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bNHcdVfTHm0L2u/xwkXTcWYkDFxIWoI1NL0pCsV4WU8=;
 b=EunqYHs1Qt5PabGIs/88pElglycztDbZfshBaTH8/6+Ao1AMaXJ2+xnna//WE/yaklsjeXsWGljuBM9ApcGFICgVHAQxBWp40v6C9pjujeG0+liTsCTyxR4YKH5u0GCeq64883jc2YcOR9NS0VYrP2cD0uJIYMtYArjWwiYGxal2TBls0p6oSaDXelKDTP7dV4DVwQ8AxsgR1G/mSKGq4AlGKWkV+j9WFx1VfJbY19nNabR4SlSfqHeHMk8b64/6Yjcnj9+toq8ke+EulCWCwJIaFJDzO6uRq4xp4D7KtyqqfMZglxRh62hS8WaV5fN3ZQWBCjISwEdaFvTdEgp2+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bNHcdVfTHm0L2u/xwkXTcWYkDFxIWoI1NL0pCsV4WU8=;
 b=XAm/K9j9zIdbnG6dbzDnHp3iB3BpkBtDu4lNClN8eYsgq/WwtGTIrwnA3OB3HoOPJG+6aluJ8Ydj0qz/VkoNasNjoFvOOyQl+UQ1ZRe3RqAJcTWkR7nZsZCqOj6uLeL9r56xI697hvXEMxGIA/uXj+HhMSc3fGWiBQ9EDtZEtE+IwysGpwJJK/bVdV4PBAhPO8J0R8rwocZDAcjmVxirnjTNMJac35nkwGhYti7GKHIqmoolEOFlP2RGj1p+ksj+6LraX1zWYFQwhb7khc0nvD1LoY8ipb79n3AiBPw5VpRGb3kXS8vqVKHfEVHopFdVzQoZX4Vmpu7vVovDi17+8g==
Received: from HK0PR06MB3202.apcprd06.prod.outlook.com (2603:1096:203:87::17)
 by TY2PR06MB3039.apcprd06.prod.outlook.com (2603:1096:404:a2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.16; Tue, 7 Jun
 2022 03:43:34 +0000
Received: from HK0PR06MB3202.apcprd06.prod.outlook.com
 ([fe80::7c42:9783:92c9:f237]) by HK0PR06MB3202.apcprd06.prod.outlook.com
 ([fe80::7c42:9783:92c9:f237%7]) with mapi id 15.20.5314.019; Tue, 7 Jun 2022
 03:43:34 +0000
From:   Neal Liu <neal_liu@aspeedtech.com>
To:     Corentin Labbe <clabbe.montjoie@gmail.com>
CC:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Johnny Huang <johnny_huang@aspeedtech.com>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        BMC-SW <BMC-SW@aspeedtech.com>
Subject: RE: [PATCH v2 1/5] crypto: aspeed: Add HACE hash driver
Thread-Topic: [PATCH v2 1/5] crypto: aspeed: Add HACE hash driver
Thread-Index: AQHYeXGeSzQOPdHyakaer71NgsLgsa1CyHyAgAB/O2A=
Date:   Tue, 7 Jun 2022 03:43:34 +0000
Message-ID: <HK0PR06MB3202FEC488851225569DD0AE80A59@HK0PR06MB3202.apcprd06.prod.outlook.com>
References: <20220606064935.1458903-1-neal_liu@aspeedtech.com>
 <20220606064935.1458903-2-neal_liu@aspeedtech.com> <Yp5Y3WKhGklwgMTp@Red>
In-Reply-To: <Yp5Y3WKhGklwgMTp@Red>
Accept-Language: en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cf18c96f-599d-45b8-9d50-08da4837e5fd
x-ms-traffictypediagnostic: TY2PR06MB3039:EE_
x-microsoft-antispam-prvs: <TY2PR06MB303951D64AC4D77C3159CFE980A59@TY2PR06MB3039.apcprd06.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CA5dxAi9pJCw9rIV2kqM/N970DwXpzwM3hBVZkZOXPv1nMvG7gc/LI8kFsTja/4SnoxQ8d8mMbiPmNmEksWSSdgN7RbkQYOFX0Wv86wxaKWXpuAfyMsTGnCzCOdpM3eESMw6fNHeNWvgAhjJzbK1fogNX1KukjaOZxZscJNLHrhiKJLFykb/5wWmu7HmbJHyPHWH8+R3Z8F0+3E6l3k3WTH50V8yfXUeNcNlm09HEHNuB52UFrSGzOP6ktqaBg35vCmdmhP9E2HSXpRlQvU4t/l7/zvVSVFANez/QG134YWFIZ1U7WkEkXB706ncQo+/AhELTac+Pv5Mm+YvmPNwp3r/qCNW8Mem/lpH85hpjk+i/Zu647AzhbfGb5+4SuS4VMJSc638N2hEoJom8mENXVw4CrvkUfeld+3sLIdIEp/Y5mId/JgzFbXFO24j1Ilkv5Wq9K7Bg9sruizJ9nRsHv5y7MRiqs1V5GsX4OA4t5Gs1CpZevmA0eWZZHx9KRzJmhJ84lUasD4oVnrJL+1PYoJkmxQmtE51F8La/WGmiR5UWGFRlyR3qVpJu0fvm2+5zEJzFbShClpKAr3tSTnDVvVSF920s7YQQDDZZJvqTqZvUOAGKOq0offUHXQl+rs+BS1oUnUx/+NbaX33nluu41lU1Oj2J8zkwjTkE5XSxfHjINGNwGluC0T1XSMf4TjOs1puaPsPA/1kxqHa5CWMTA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR06MB3202.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66446008)(8936002)(66556008)(66946007)(7416002)(38070700005)(316002)(38100700002)(76116006)(122000001)(5660300002)(33656002)(4326008)(55016003)(8676002)(64756008)(66476007)(54906003)(6916009)(508600001)(186003)(66574015)(107886003)(83380400001)(52536014)(9686003)(71200400001)(6506007)(26005)(7696005)(2906002)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Z9MgTagEcCCFsPjMhy7iSemWmQZ5nQaOtrXXTj0nS8KaQLgjYbBuhLXmqP?=
 =?iso-8859-1?Q?irUM1kJ+2JR0YdEq/5adRrjbHbRPgV0imv71YZdFAUzfX0yJnjJsFdoqKX?=
 =?iso-8859-1?Q?tVaWYIB6ROekhQMOt0hCkbj1ngddhL5DuFMiKSc060m6OaO9O/H/P5/vAW?=
 =?iso-8859-1?Q?fKAs4eSVigU4xlNycjULFkDXzYGh9uKYFIisJKdq65cSlDmowPhwDpp0d4?=
 =?iso-8859-1?Q?0/r3UwWVIWRbItVUsYq42PE7c3isjcnbVKEJw7YljcpwskZuEN9eStC6bp?=
 =?iso-8859-1?Q?YGUvXK8WaQouQ4ItNBeShbfmuK3sD++F0izsShtgFdfI6oDykfM1LPO/ts?=
 =?iso-8859-1?Q?zocCxat5tlYfFQsT45a9WRxpXzLsinFIPrvlegz+OjThTZeKkST93oD3qg?=
 =?iso-8859-1?Q?ljuJiKUZNFZXfor2K6UqlIG7+URyxLQLNhkM0mCJ4xFwH6YG+96Ycr+zmZ?=
 =?iso-8859-1?Q?nxUj8NduSnciWJib4JY3socxbbCHpxQiC8Hg6nD1Nop05iDu3zzuT7aSt3?=
 =?iso-8859-1?Q?bYDhyxM18JLxWBM8yG/mOjFrtE487iF6iERPlgU6NdP3vMLmZsa6+jwIcE?=
 =?iso-8859-1?Q?uoKeQUSKx3ojV8IfySQLOrt0NB+HqyZckAmbc6ZbuQreKJPRAZXbNzcLPf?=
 =?iso-8859-1?Q?KmbjdWHv+dD4EtJiD+XOiOTzPGxegEweSq+Y/gjxbj1Whmgz/Xqlu8WPIf?=
 =?iso-8859-1?Q?JplZZRAd5PfPam5//mRekr+JwZJsHcMjpj1wCbx2YuvHZsHTdeWQVx9Ncu?=
 =?iso-8859-1?Q?C/Zw6Q1/AwNnLtKOMxRqT2mJbwPxymKutw7RdhAfQXeI6ZGdyhpq4F9XE3?=
 =?iso-8859-1?Q?nvNT0bvp9vYZlvjsqYs5sBDpAb3tHVrR87q8rghfYRjl3oDdt4LXwahM8t?=
 =?iso-8859-1?Q?JIvhvgnLWtlZWU4xLSSUN9mWN65KTKZU1IaX41yeINO9AUoJjLFT5AOa/Y?=
 =?iso-8859-1?Q?Xes5qmLlhWquQUunwMzaZkW3lDc8fgVeBO2PSkmCX1d9Vm+aCQJ//6ylUp?=
 =?iso-8859-1?Q?+2fVc3wEtZThRncELZUo8PQCCA0xvlNOiiwj6YrHvQKUAiPGFqACyTM9DR?=
 =?iso-8859-1?Q?0VLY5hJxqy+aX2zMCBulk3VFCa8l4cgaqTb1Q2R2pNdMh4vmAZWkunMtHy?=
 =?iso-8859-1?Q?/WiL7Fou0idWpDDdwChrne/nDQFBpqBc8SjAWARRaQgm8F28fxooP+Zbn6?=
 =?iso-8859-1?Q?Da7QPyKr3hYJHgKbuCOEphN+vAvbfreLtf36uOqyvEfl8GRJjiQDgBD/7B?=
 =?iso-8859-1?Q?rlX9YFfK/tUjvbUM2ecoHyrrn12RXRHZ/UWqmKfCrDaSiKSgCsfaEp8vLz?=
 =?iso-8859-1?Q?tsd0quSkq5YXXE94CqukxP5UkBL/jgzjzHFU9fQY2/lGI1ugNnNCubv/9M?=
 =?iso-8859-1?Q?+qRuOpQ/LYbgtUHemOHPOnzJuoJ9QiAi0/tHbwwhElIizjIZ83UlVndsaX?=
 =?iso-8859-1?Q?l9+3ceqljYoU5lthuaPAaO//k89yBq239B79ZlCg1GfUGC/riyFlw9AgkI?=
 =?iso-8859-1?Q?kUJZVD5auoeiAzMaMa2p4NApcCPjNu6kuf4T9y6FWzoztB04ncjkVCEOHg?=
 =?iso-8859-1?Q?wkAocnKBbTqBVKpdUKC7IlfDl/cZKJKT8zjfauD4g0yPtuG+npnltF7dGh?=
 =?iso-8859-1?Q?njQzLKctKXgqzhYNWj1GaOkPb8uRG84D5e8C6IcOWCHQ67toasitEcBdUF?=
 =?iso-8859-1?Q?Au0UWdl5WSKkjEMCktb6X/wsP3lAFPsntODJS42FdDUKCqTUxBu1vksncY?=
 =?iso-8859-1?Q?oNyRA7DhxrJ2VgNduwcMh3Hb5JuV5gBzjRjWaz5ISxG5Uz4bJjgeQ2wqkX?=
 =?iso-8859-1?Q?6Dg5SAzOTw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK0PR06MB3202.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf18c96f-599d-45b8-9d50-08da4837e5fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2022 03:43:34.5038
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e2Vf1tJNV08Y3FT5gfFSFu91JV4u/iApZyMk1dFX6iU4zr8pVmoiqhyARX69mPl/p+kyiGVMnuzRIBPtOUg1CQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR06MB3039
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Le Mon, Jun 06, 2022 at 02:49:31PM +0800, Neal Liu a =E9crit :
> > Hash and Crypto Engine (HACE) is designed to accelerate the throughput
> > of hash data digest, encryption, and decryption.
> >
> > Basically, HACE can be divided into two independently engines
> > - Hash Engine and Crypto Engine. This patch aims to add HACE hash
> > engine driver for hash accelerator.
> >
> > Signed-off-by: Neal Liu <neal_liu@aspeedtech.com>
> > Signed-off-by: Johnny Huang <johnny_huang@aspeedtech.com>
> > ---
> >  MAINTAINERS                              |    7 +
> >  drivers/crypto/Kconfig                   |    1 +
> >  drivers/crypto/Makefile                  |    1 +
> >  drivers/crypto/aspeed/Kconfig            |   22 +
> >  drivers/crypto/aspeed/Makefile           |    6 +
> >  drivers/crypto/aspeed/aspeed-hace-hash.c | 1409
> ++++++++++++++++++++++
> >  drivers/crypto/aspeed/aspeed-hace.c      |  221 ++++
> >  drivers/crypto/aspeed/aspeed-hace.h      |  182 +++
> >  8 files changed, 1849 insertions(+)
> >  create mode 100644 drivers/crypto/aspeed/Kconfig  create mode 100644
> > drivers/crypto/aspeed/Makefile  create mode 100644
> > drivers/crypto/aspeed/aspeed-hace-hash.c
> >  create mode 100644 drivers/crypto/aspeed/aspeed-hace.c
> >  create mode 100644 drivers/crypto/aspeed/aspeed-hace.h
>=20
> Hello please see my comments below.
>=20
> [...]
>=20
> > diff --git a/drivers/crypto/aspeed/aspeed-hace-hash.c
> > b/drivers/crypto/aspeed/aspeed-hace-hash.c
> > new file mode 100644
> > index 000000000000..9b003e12b2c8
> > --- /dev/null
> > +++ b/drivers/crypto/aspeed/aspeed-hace-hash.c
> > @@ -0,0 +1,1409 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * Copyright (c) 2021 Aspeed Technology Inc.
> > + */
> > +
> > +#include "aspeed-hace.h"
> > +
> > +//#define ASPEED_AHASH_DEBUG
>=20
> Please remove this

Sure !

>=20
> [...]
>=20
> > +
> > +#ifdef ASPEED_AHASH_DEBUG
> > +#define AHASH_DBG(h, fmt, ...)	\
> > +	dev_info((h)->dev, "%s() " fmt, __func__, ##__VA_ARGS__) #else
> > +#define AHASH_DBG(h, fmt, ...)	\
> > +	((void)(h))
> > +#endif
>=20
> Why not using dev_dbg() ?

dev_dbg() would be nice. I'll revise it.

>=20
> [...]
> > +	sg_len =3D dma_map_sg(hace_dev->dev, rctx->src_sg, rctx->src_nents,
> > +			    DMA_TO_DEVICE);
> > +	if (!sg_len) {
> > +		dev_warn(hace_dev->dev, "dma_map_sg() src error\n");
> > +		rc =3D -ENOMEM;
> > +		goto end;
> > +	}
>=20
> This test does handle the possible negative return of dma_map_sg()

Zero is returned for any error of dma_map_sg().

>=20
> [...]
> > +	memset(bctx->ipad + keylen, 0, bs - keylen);
> > +	memcpy(bctx->opad, bctx->ipad, bs);
> > +
> > +	for (i =3D 0; i < bs; i++) {
> > +		bctx->ipad[i] ^=3D 0x36;
> > +		bctx->opad[i] ^=3D 0x5c;
>=20
> Please use HMAC_OPAD_VALUE and HMAC_IPAD_VALUE from
> include/crypto/hmac.h
>=20

Thanks for the notice. I'll revise it in next patch, thanks.

> [...]
> > +int aspeed_register_hace_hash_algs(struct aspeed_hace_dev *hace_dev)
> > +{
> > +	int rc, i;
> > +
> > +	AHASH_DBG(hace_dev, "\n");
> > +
> > +	for (i =3D 0; i < ARRAY_SIZE(aspeed_ahash_algs); i++) {
> > +		aspeed_ahash_algs[i].hace_dev =3D hace_dev;
> > +		rc =3D crypto_register_ahash(&aspeed_ahash_algs[i].alg.ahash);
> > +		if (rc)
> > +			return rc;
> > +	}
>=20
> If any hash fail to register, the function exits but you will still unreg=
ister all
> hashes (even ones not registered) on aspeed_unregister_hace_hash_algs().

Yes. crypto/algapi.c would handle this part even if algo is not registered.
But of course we could use a variable to store which algo is registered, wh=
ich is not.

>=20
> [...]
> > +static int aspeed_hace_probe(struct platform_device *pdev) {
> > +	const struct of_device_id *hace_dev_id;
> > +	struct aspeed_engine_hash *hash_engine;
> > +	struct aspeed_hace_dev *hace_dev;
> > +	struct resource *res;
> > +	int rc;
> > +
> > +	hace_dev =3D devm_kzalloc(&pdev->dev, sizeof(struct aspeed_hace_dev),
> > +				GFP_KERNEL);
> > +	if (!hace_dev)
> > +		return -ENOMEM;
> > +
> > +	hace_dev_id =3D of_match_device(aspeed_hace_of_matches, &pdev->dev);
> > +	if (!hace_dev_id) {
> > +		dev_err(&pdev->dev, "Failed to match hace dev id\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	hace_dev->dev =3D &pdev->dev;
> > +	hace_dev->version =3D (unsigned long)hace_dev_id->data;
> > +	hash_engine =3D &hace_dev->hash_engine;
> > +
> > +	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +
> > +	platform_set_drvdata(pdev, hace_dev);
> > +
> > +	spin_lock_init(&hash_engine->lock);
> > +	tasklet_init(&hash_engine->done_task, aspeed_hace_hash_done_task,
> > +		     (unsigned long)hace_dev);
> > +	tasklet_init(&hash_engine->queue_task, aspeed_hace_hash_queue_task,
> > +		     (unsigned long)hace_dev);
> > +	crypto_init_queue(&hash_engine->queue,
> ASPEED_HASH_QUEUE_LENGTH);
> > +
> > +	hace_dev->regs =3D devm_ioremap_resource(&pdev->dev, res);
> > +	if (!hace_dev->regs) {
> > +		dev_err(&pdev->dev, "Failed to map resources\n");
> > +		return -ENOMEM;
> > +	}
> > +
> > +	hace_dev->irq =3D platform_get_irq(pdev, 0);
> > +	if (!hace_dev->irq) {
> > +		dev_err(&pdev->dev, "Failed to get interrupt\n");
> > +		return -ENXIO;
> > +	}
> > +
> > +	rc =3D devm_request_irq(&pdev->dev, hace_dev->irq, aspeed_hace_irq, 0=
,
> > +			      dev_name(&pdev->dev), hace_dev);
> > +	if (rc) {
> > +		dev_err(&pdev->dev, "Failed to request interrupt\n");
> > +		return rc;
> > +	}
> > +
> > +	hace_dev->clk =3D devm_clk_get(&pdev->dev, NULL);
> > +	if (IS_ERR(hace_dev->clk)) {
> > +		dev_err(&pdev->dev, "Failed to get clk\n");
> > +		return -ENODEV;
> > +	}
> > +
> > +	rc =3D clk_prepare_enable(hace_dev->clk);
> > +	if (rc) {
> > +		dev_err(&pdev->dev, "Failed to enable clock 0x%x\n", rc);
> > +		return rc;
> > +	}
> > +
> > +	hash_engine->ahash_src_addr =3D
> > +		dma_alloc_coherent(&pdev->dev,
> > +				   ASPEED_HASH_SRC_DMA_BUF_LEN,
> > +				   &hash_engine->ahash_src_dma_addr,
> > +				   GFP_KERNEL);
> > +	if (!hash_engine->ahash_src_addr) {
> > +		dev_err(&pdev->dev, "Failed to allocate dma buffer\n");
> > +		rc =3D -ENOMEM;
> > +		goto end;
> > +	}
> > +
> > +	rc =3D aspeed_hace_register(hace_dev);
> > +	if (rc) {
> > +		dev_err(&pdev->dev, "Failed to register algs, rc:0x%x\n", rc);
> > +		rc =3D 0;
> > +	}
>=20
> So you print an error but you keep the driver loaded even if no hashes (o=
r a
> limited number of them) are registered, for which interest ?
>=20

Take PATCH 5/5 as consideration, aspeed_hace_register() would register both=
 hashes & skciphers.
So even one of them failed, the driver still can be loaded.

> [...]
> > +struct aspeed_sham_ctx {
> > +	struct aspeed_hace_dev		*hace_dev;
> > +	unsigned long			flags;	/* hmac flag */
> > +
> > +	/* fallback stuff */
> > +	struct aspeed_sha_hmac_ctx	base[0];
>=20
> I am not sure to understand the [0] purpose, and the comment said somethi=
ng
> about fallback, but your driver dont do any real fallback.

[0] is a convenience to reference it as a pointer.
The comment should be removed, thanks.

>=20
> [...]
> > +struct aspeed_hace_dev {
> > +	void __iomem			*regs;
> > +	void __iomem			*sec_regs;
>=20
> sec_regs is unused.

I miss this part, I'll revise it in next patch, thanks.

>=20
> > +	struct device			*dev;
> > +	int				irq;
> > +	struct clk			*clk;
> > +	unsigned long			version;
> > +	struct aspeed_engine_hash	hash_engine;
> > +};
> > +
> > +struct aspeed_hace_alg {
> > +	struct aspeed_hace_dev		*hace_dev;
> > +	union {
> > +		struct skcipher_alg	skcipher;
> > +		struct aead_alg		aead;
> > +		struct ahash_alg	ahash;
> > +		struct kpp_alg		kpp;
> > +		struct akcipher_alg	akcipher;
>=20
> Your patch dont do any kpp or akcipher (and aead/skcipher also).
> Please drop this.

I miss this part, I'll revise it in next patch, thanks.

>=20
> Regards
