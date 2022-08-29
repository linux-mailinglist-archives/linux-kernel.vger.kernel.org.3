Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8FC15A46C3
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 12:05:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbiH2KE5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 06:04:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiH2KEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 06:04:52 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2092.outbound.protection.outlook.com [40.107.215.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F0415F202;
        Mon, 29 Aug 2022 03:04:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dZJUcekNh3FSwmxbO1aMoUYNCiStcoDvfwERsUHxLJx9DpcEoSfHVk2z2E6QEHIMgUBS8Uz29vay9YIdE7Ja6U63UQSXn9jaWoR89LIb9Td+mOfA4i1LRKWyTQNGCV4uOwCxh/KzzzzU0zL4oML6Tngt+GWCy3NlFjOeRoHw+znu+NYyGtn82qCwG7g5mbwy6MddtP2RBHwidcrlEyn23BTI/RzP/IFr9egJMC6yFLFsZMujTgYkCq69tGiKeGC3B0zDdYDess+GpYyIbg0Y4w1d9NdE7Vy9P9tuYz2SlZ+kMFG08R5InTibESbikOJlgUIIHCFS6XGfcich17n5lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/MruPH35v+ZEFQY+FcgVuPIR1IjOkqydZysmM9Oa8po=;
 b=dMoMj89v3WEm7gEeMMI5zPnPm3LfHW8AV1y+nO9ungNEzwMNmuv28egCqBfvIySP06AI6tMZ7ezLaQoAN6ColdqwAl1n7vI0WsKreqARAkTx4mBKeZKAZ8IdimqcRNO63JRqn9DOwJFqOqT1d1dvbXkJuGpg3IQStHpj0hduGJr9vG4ypbYowKOjz6+ZmwN8Vka9/aTUpjm+vB9Kzn8OV4EeiJyKzmRhWneWSvaqa4N3//Ez09Kb/o9OJsUWnmZ6dEeyZ6f7MZUUse2A2E9OrZoJjrr8tnIywUKZNKcO5rh5UaAjNsZm3mn4bc0PNJEzDnZvx9M0mVr5s44iTbJ4xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/MruPH35v+ZEFQY+FcgVuPIR1IjOkqydZysmM9Oa8po=;
 b=g2SA/b1jydeQmR1xIpMl4Enzlkcvht4YsyBeSgnIZ5PgpbQLoK4rqKvaTerRu7WC7rj4PRCOmuubD3B+UI6S3ALfCP7up7+qhE65FYWKsFlZ7ztwqgLqHunIKkvck+KPS6zDx0AbKAQngMtDD/9OZSW7qBqMi/9HQ29fKy9p1tfTS/0C8xZVZMNUeUSzC60hXLW8ggKOItA++8l1T26tr/Bm8nPJJa7mqOb1mMVAFkhAyFwao+HuG57GjNaK1mZ38Ta28WI3GOnW6cY5LArmNKdm6R+GetnjKAIj4czdfQuBCy3IgfOTCdfcPAOL617DCu5JT51JqrQdTIDArkTB2w==
Received: from TY2PR06MB3213.apcprd06.prod.outlook.com (2603:1096:404:97::16)
 by SG2PR06MB2683.apcprd06.prod.outlook.com (2603:1096:4:21::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.14; Mon, 29 Aug
 2022 10:04:33 +0000
Received: from TY2PR06MB3213.apcprd06.prod.outlook.com
 ([fe80::8dbe:4d03:e911:5a4]) by TY2PR06MB3213.apcprd06.prod.outlook.com
 ([fe80::8dbe:4d03:e911:5a4%5]) with mapi id 15.20.5566.015; Mon, 29 Aug 2022
 10:04:33 +0000
From:   Neal Liu <neal_liu@aspeedtech.com>
To:     "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>,
        Johnny Huang <johnny_huang@aspeedtech.com>,
        Dhananjay Phadke <dphadke@linux.microsoft.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
CC:     "David S. Miller" <davem@davemloft.net>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>
Subject: RE: build failure of next-20220829 due to 108713a713c7 ("crypto:
 aspeed - Add HACE hash driver")
Thread-Topic: build failure of next-20220829 due to 108713a713c7 ("crypto:
 aspeed - Add HACE hash driver")
Thread-Index: AQHYu443cJFtTT5gb0mr18Wb5C2Sb63FphZg
Date:   Mon, 29 Aug 2022 10:04:32 +0000
Message-ID: <TY2PR06MB321356F6EB09D3D59D37B53F80769@TY2PR06MB3213.apcprd06.prod.outlook.com>
References: <YwyORp72cuDrVYdA@debian>
In-Reply-To: <YwyORp72cuDrVYdA@debian>
Accept-Language: en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1cff054c-4153-4d63-1190-08da89a5def7
x-ms-traffictypediagnostic: SG2PR06MB2683:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AsaSrL3kzOWSeqQ1FJLRwADhvz+e4MESFp5zwFG+A6Zw4VCHL7j7ytxibLfZJCYR4oJarwRdiJbcGJGYcYlSh3e2gpGUGVDb9Ua3pjKY7OZomGXYN3pG0SY/adfpjZfXvikd3FomKmic6xSN7xw40tcZMcAQ6OShThiMTx+LF4U2Xgi1cm1/wo6Y7i7CWV018FyDfkKtDfyh7U2GUDxBAlF3cSMEzmaiEkAcdaUIw818rjfOcWHDzTJ5z6k4YaEwNUYSRty6IJwWodUQx3IlxM83Cea6/Vkyl7gd34Imj9XvSZCdaCI6PQIXbclsAnnqD8YLivye213dSc5NZLZG57nnXYTrhuBN3zpKPH798zt6azjn3YF/hAuJsuCSUCYkKmSfr8bIQUzTxpRkLBanf9+eVkAzLJgZyL/sFhVPHNTk+hfJ+j8e6BVQ93eV+uzaGOrgzMS0tD0Gigifd1W0r3USb3vPLclO4z6aQQO02AgNeJ9Dl+dHBfT5WPKUuID5mvsvoPMex9V3MGV0K4+pT7WiqEDOVxANi38VYxb6xfaNx2LK4UomNIWjzXB0iBjq/WNH/UeCHDBVqt13T/etSlTAoGjjKMgsOjamIEdlpHLg+y8c0EvdOh2OvMi3EBVdJABRbb7IIzeb1RAPqSyQ/cl4NLR7mN6O99I/fYLuRia8LMHEk11QAZj4j3gYPWS3RAsTyxV/GsNaS22k9wwRUwd5WqvT6z4lHb0+FNZKb0SquAml/eK6a5zhcO45tcuKk5iXPDB8Cwnzqq+tBqZIfmVZoj6h0zwSf6xXVMKvN1U=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR06MB3213.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(39850400004)(396003)(366004)(136003)(376002)(38070700005)(110136005)(316002)(71200400001)(186003)(38100700002)(86362001)(54906003)(122000001)(66476007)(64756008)(83380400001)(2906002)(53546011)(478600001)(41300700001)(76116006)(66946007)(66556008)(8676002)(4326008)(66446008)(966005)(52536014)(7416002)(9686003)(55016003)(6506007)(7696005)(33656002)(8936002)(5660300002)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hNJjIZA/suADs25EFAcNCJswPtj13g1UYYOkK/WDn0pOpxw4SuPhEY60W0ks?=
 =?us-ascii?Q?jcg/KvTd5a7oixsgKRp3X0Z4sznqzc8U7H3eWd9wLS3aKZNxqgrsKX5IR6/A?=
 =?us-ascii?Q?rwdpa1kOjvO1LqiHNKZZl1FP97ovkwEjfxvuYkw01TLPq8fgVb8qgvTVoiHJ?=
 =?us-ascii?Q?Mze0985KkOefleVcWASK65kq4mrOUGBLbaPz6Hd6uFzZ1sfYxkKLWQCs/QWo?=
 =?us-ascii?Q?AUA2IwC4LgzmOslTEmoxIRIeJOzDzlyBQYAETZZ9TdlN+hnJN40gHCMuejNJ?=
 =?us-ascii?Q?I3UKUMFkfUpKKKG02Nb2v+FYBxv828LhAjMb3WS5dEZdx7pFtjsp0wjkA/js?=
 =?us-ascii?Q?d7MQnksZWlD9rbpQ8MA3nKIXllVIqeYw0qtBhOqNjFGbNH0LPKcU+x3iIyeO?=
 =?us-ascii?Q?gIIXcHqaQlU203eV3ZoNvCOBq4LfzECyWy8OdxIdn1Q8JIU12Hkz9kMeUJRT?=
 =?us-ascii?Q?/4ZW153n3Vhxr9uNiudBzEFRDfJnS7Y0JmbwTy2vmWIX/RRZ6gNRlx0iF1MP?=
 =?us-ascii?Q?m6OY4JkcH3MgmYejNgvs76EQknH5CrtctsDQvbhvokSC0nskoGDPUBVdHM1U?=
 =?us-ascii?Q?H7KAhFED55Y11I31NNRmnXEAlV56i/dFDmqwqn/jhSSHKc5gCuVUluj6ZDBe?=
 =?us-ascii?Q?59FF+FY6Xb9QzNnAyzRZP8cRAD6sB3/tjAUpQEppHJmjiL0GpUbCBb1cNGmK?=
 =?us-ascii?Q?1gmzWzIF+CpeKIQJQnqWgPQAC0XogNx+gkG7cnUjcYjmQTo5xfjhct75i08d?=
 =?us-ascii?Q?FAABo5PBKPEURGSLOTahLw3w8IuUzf+x3oxcrW45yuAc5KDmycZwnJOppMDI?=
 =?us-ascii?Q?JLHVcQBeBnBTlNKKN+jWUY95tT5BDuWmpAgDVaXcDBcHYBqKJQaUHufnY9vJ?=
 =?us-ascii?Q?gZuWgbliOBv/z7x8zC91lPcsopTHzf5QO+sj3ytCeWYPWxivB8GNCbyoDQpA?=
 =?us-ascii?Q?8fx/BUm1zCLIr03OcJGLFmg3hllhwEA/y154k+5XRq8fClh2v/6DphrOV0ba?=
 =?us-ascii?Q?l+tn0aWOdkemHAC1CHFHXbMx5blqnVoZe6fuIt1Fc5V0ST1GYcRtV7vhPgef?=
 =?us-ascii?Q?H78EZ8XfgoHh3IXMUlC3zGD7LM8RZxfCDTR/ANjuA33sjJ5HqwTKgGVhg2xk?=
 =?us-ascii?Q?S4wqfm9YAHcdXWkJVsxg9dLNLn6L5w1T9I9c/UUzEbM9/AtN48NKUGoYP8gP?=
 =?us-ascii?Q?/CNMrqcwsPhDmAYJmr06KsVgRsgzHKMzWB7kStVW9wSbPpfXi2SBxUxtJRNk?=
 =?us-ascii?Q?qu130w+4eYtGSeQApjYK01kgAiHPDmxifAtq6f4H/Be+ZWSL+EiuCp2MWvvV?=
 =?us-ascii?Q?cG+3uyrInW44lppgldJ4BiPJ72Csw+XvvZ7K2qv24zxE9tOC9P3Oz57qiPkW?=
 =?us-ascii?Q?+d81xHjVcB73CsKmbF3yxc+loBorKJO/DP64fH9xr2k8QxDDMbnybmtksLU0?=
 =?us-ascii?Q?mP6Lz/jK58ew1pyvEmZxVS0iti+dlQWiT5beDg5BYxXVWgbuxKC9TQhXioDw?=
 =?us-ascii?Q?YyfTMSDG5CwlcKKkXYxYpRWQA7qUtMXs3pDbJSGGO9XCffzXLijLjKYU7/ZB?=
 =?us-ascii?Q?J+jXoerBHespoGGtvrJG4MXSHb9Eonl521peOziI?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR06MB3213.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cff054c-4153-4d63-1190-08da89a5def7
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2022 10:04:32.9064
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NPl12fVdwsvzGZZyOp4FwnNYJer22L0ewHRRUbiPXol1iz/w6Q5G7WbnlYqxsupJElknnaBLUWyP43oXhlUJ7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB2683
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Sudip Mukherjee (Codethink) <sudipm.mukherjee@gmail.com>
> Sent: Monday, August 29, 2022 6:01 PM
> To: Neal Liu <neal_liu@aspeedtech.com>; Johnny Huang
> <johnny_huang@aspeedtech.com>; Dhananjay Phadke
> <dphadke@linux.microsoft.com>; Herbert Xu <herbert@gondor.apana.org.au>
> Cc: David S. Miller <davem@davemloft.net>; Joel Stanley <joel@jms.id.au>;
> Andrew Jeffery <andrew@aj.id.au>; linux-aspeed@lists.ozlabs.org;
> linux-crypto@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> linux-kernel@vger.kernel.org; linux-next@vger.kernel.org
> Subject: build failure of next-20220829 due to 108713a713c7 ("crypto: asp=
eed
> - Add HACE hash driver")
>=20
> Hi All,
>=20
> The builds of arm allmodconfig have failed to build next-20220829 with th=
e
> error:
>=20
> ERROR: modpost: "aspeed_register_hace_hash_algs"
> [drivers/crypto/aspeed/aspeed_crypto.ko] undefined!
> ERROR: modpost: "aspeed_unregister_hace_crypto_algs"
> [drivers/crypto/aspeed/aspeed_crypto.ko] undefined!
> ERROR: modpost: "aspeed_register_hace_crypto_algs"
> [drivers/crypto/aspeed/aspeed_crypto.ko] undefined!
> ERROR: modpost: "aspeed_unregister_hace_hash_algs"
> [drivers/crypto/aspeed/aspeed_crypto.ko] undefined!
>=20
>=20
> git bisect pointed to 108713a713c7 ("crypto: aspeed - Add HACE hash drive=
r")
>=20
> I will be happy to test any patch or provide any extra log if needed.
>=20
>=20
> --
> Regards
> Sudip

Hi Sudip,

I already sent another patch to fix this build error, could you give it a t=
ry?
https://lkml.org/lkml/2022/8/29/131
Thanks

Best Regards,
-Neal
