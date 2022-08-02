Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 532EE588299
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 21:37:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233188AbiHBThC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 15:37:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbiHBTgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 15:36:52 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34B2052FCA
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 12:36:47 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 272JJUiw029881;
        Tue, 2 Aug 2022 19:36:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-type : content-transfer-encoding :
 mime-version; s=corp-2022-7-12;
 bh=XTZUY1ZURsvPtPltYJtKyQsYkFMaV9qii149zHxo7Jw=;
 b=A77+sUm2KjA8WStyYYmKOw835P7qmVJuNaeUqiOnDaFxKHUv5KLb1SkV50RqCqXFdhiE
 lELbbcXOC+3D1QtR0/TVqaZv5tYW8CaHMPgMqLEOJgQffeA7J2Tpy1ktYu27E7FuO9Gj
 jglw8tgVgUTXLG6DsNZpc5pph1axT4e0sewVKdkpAfJyDKgB21P3UfsGWEBG3l3xAWYC
 HGP8wXzwrj5fbnkYyyWeBfJUvGNryjVLM3BvBRh9DJHESSZdcPxsClRuzfGaUlX5UOF3
 eW9HudvVmAZcyuz1vXRh0k5aRy13CDRI0Reo2j/58H28qiencRXw9PwWa/E0c8oxffDD kw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hmvh9qsbs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Aug 2022 19:36:28 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 272HorJt014152;
        Tue, 2 Aug 2022 19:36:26 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hmu32nk6n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Aug 2022 19:36:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l2dny4rXztJXg/Lpltajgu4oVvHfQF1rR6zch1k+Yr3BUTCGdNIPugnd6Ip8XgwH2zZsMLyn7SAWwqpdpuO35omK2ifNf5CDgyxXSNxOMZwITQTWEDTM1uo4ZSxEOIIja0zBzkzKgYy5hk36JP+79TfLIXY5k3PU7Fe09qTqHAAk2soK0fjawIQGiSLtIz6tVKD4wHt5zxjW0ArG/aHB5YBOFCYwmRpFt7MxPPkapXzTW8SYMtQ5lHlL3+mm4ASd1vVrO2T59r7vCWXwBGBhz4WUk7Nyoc7yXi73trLkx9inPbGYblwGuTVD0UuOGDtQPYJ/pBfySu7N6EGMb5ZwwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XTZUY1ZURsvPtPltYJtKyQsYkFMaV9qii149zHxo7Jw=;
 b=HXhITeGeDnm3uUyOedHg/Q0t+bVbkcm9SDLydrPx8IGTWd24L1vd1vPP/RZGjoyU6+pqIUHcpDpyJlBNiH4Pnyzyq4/4b+OtPScQqy9czrlbPZsuM5snBa5bo439hcA0kUFFCOHBeZ455npHhrf7u0p4KL+rM1iUlfFfUcvEIFEng7JIG8+Kikx5kRUazBkO0jijiZPkhGUusRdIeEUHZhQ9itSwo7QBfCRol7HXRpL0szKUzg//u+GJEXVgx9d9qUGu1DMVmU/GYJpgo5IGcbSWRZD0DrUDAAdJGWVl7Z7Et46f4tWmM93abHHwKrFDi8PHrLx3hBxCipL9Ai3OQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XTZUY1ZURsvPtPltYJtKyQsYkFMaV9qii149zHxo7Jw=;
 b=q9QHkkLpytGfKdqBT3I1BcrOIhxCO/ITBr0PmT5IeBts7YFqNtAwl/uAP97+XZIZSh2W5F9jF4joGpPJLWmRXXS8Qvu4If5V/YYNNqyOQvIosIRJZ+oFywME0Ujvsn0mEtBR5+GBwVHmnHUCZIbBNGtgvAWQtSHOySCJKwETtEc=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM6PR10MB2985.namprd10.prod.outlook.com (2603:10b6:5:71::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.14; Tue, 2 Aug
 2022 19:36:24 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68%6]) with mapi id 15.20.5482.016; Tue, 2 Aug 2022
 19:36:24 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Osipenko <digetx@gmail.com>
Subject: [PATCH] maple_tree: Fix mas_alloc_nodes()
Thread-Topic: [PATCH] maple_tree: Fix mas_alloc_nodes()
Thread-Index: AQHYpqcmPt7CdAaAQ06YVNNnxmjt4w==
Date:   Tue, 2 Aug 2022 19:36:24 +0000
Message-ID: <20220802193612.2886170-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5a45c4ef-c631-451a-980f-08da74be494d
x-ms-traffictypediagnostic: DM6PR10MB2985:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MSPsRj5ufD3YlmujNLmduOc04Tcs1ZqbrInEELbxle5CClO1DhtD7hi3U7Itr+ZWZaWmZ+2by6jK4DR+7fEbboZbt8d3DqPo+Ky5bDJX75VcYPEhSQXxN1A+gzDpsCSWp+CtoukYeKye5s/ej5RguudtGahgPZ/6+QLnlfY5bbaJ25ojSBeh12AgbiSU+odfN8+7XUfDnHej0zU4CXmKUNyGHN2LrQMucPdfNQSUNxMTTIZYsoLp/OksJx0rJ+2gHICiFsHPT0R+BCp4J071FNzG1+MZPeaH+rYgy7Tc6XDsmvaflmBYU+seW2zWtxB61nKR9GBTYTToKgjUPPDQLln1xRE0guuxA/Oim14RgIGnZModPVSWRJuuzoBaB9neEubFJLyk41ZAmgIkawQW1vAirB3Q7IBDBdIElZGTbglDdTVinXGnPxJKKfEJwbL3Np5jkR99RjMoBUiB7+F16GwR1mItMFZfJhRjdTsNXGzqk0vQG1mJ5hNTho9pNb41+9VxZHRyAYbDzuLBy3XvshFXsyXiIVQ585zRhb7xSTZCZ4jPGWRK5nG0c6uQVuRuYAEswaqX4tE/v9P6VTfML2kidk3qgIZ/A49N755jUFNurTNGrw8GHtCMfczYNsrD87I0vrXi8oJkKRPfW37FUaVfrbcyBrX0orogZ2WK3m4qhx7sG1+y6HlKQzFJG5MeoHcGs1eGYCJUonU0Zqo0QGnIMTkDo6yGeWIq2dj84t+oTvPn9NsfZPLWzEFciVZuCnoVreW0fcdGgXweFgv9fc8BPAfQ1r77FuVdxZtOUr4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(346002)(136003)(39860400002)(366004)(376002)(316002)(26005)(478600001)(38100700002)(122000001)(83380400001)(71200400001)(6512007)(110136005)(6486002)(186003)(1076003)(2616005)(8936002)(6506007)(36756003)(41300700001)(4744005)(76116006)(8676002)(2906002)(66476007)(66446008)(64756008)(66556008)(86362001)(91956017)(66946007)(5660300002)(44832011)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?9ZDW431QX7/gigK0eWzeqQ62Ff402CZs+XA7b5h1FvWi52ke23k9sZkz9Q?=
 =?iso-8859-1?Q?XfqI1FjFQHfvaTVYmR7h+0W3OvRNRCP6um0TFOgETn1RmxzfAKYQGnFU7E?=
 =?iso-8859-1?Q?Hb+NlsoOZyZG2xyXsGXjPSVfWsUEac7Btmnv1EeZhRe5sDcdRWEDAtJHGj?=
 =?iso-8859-1?Q?RiiHM4TWxKKh2WCMH5I/4GePNFw/hrgsSh/BtFa0bMvM0FWtY9YUGjR7fk?=
 =?iso-8859-1?Q?NHwNmzM9Wpr8uDRlB4JT45S7P/7oKGc5swVc/NS2t0H/YyvmBOMGUGHeBH?=
 =?iso-8859-1?Q?NhDDlgCq9KzVa132XRmhWRDwgDKbsT3jotCfaCaoqyn1VY0yv6io1O1kG4?=
 =?iso-8859-1?Q?lWjfAn4Hebw2coaTvyCV9H2vEMC8u2vCmAblIhmGUbajxLxc+oHwlhURZY?=
 =?iso-8859-1?Q?4bHnFEwlbv+YbRm4bQhzPkcC3cRuHHn8CkeGynTI4C0pThZyNSbzhxhgoG?=
 =?iso-8859-1?Q?6gdDkjUwIb4LvPgBTCKXaZYJc9d5N1e86LBm8iC1NSYEJjURTwUDZ90rS5?=
 =?iso-8859-1?Q?scnQxdjFizu7bNCr0rzBuf2PEhz64yz4LLky46HvHQ28hqqEJb9ivhhwmu?=
 =?iso-8859-1?Q?UkPgVpg1CsVYwqXzD4+lQr6yOA1JOe1SyCN7z6qwHAyB1ntbaxMW17VXim?=
 =?iso-8859-1?Q?2586dwwzQ1k6lt12wb1rILmFDcwl2NTLx4s0xc4wWm7pttCbTG+kr6KNWV?=
 =?iso-8859-1?Q?ngqCOM6d/ywu0shC3O5z4KORem5+ImvrYw/BOeYLTHTKsQ+6mtIi1Gp3aj?=
 =?iso-8859-1?Q?2u0zB72SKRtD0fJZdplWJGdF/o8LDHb2kDQ8Vf3f+xj6/178SVQ+22M0oj?=
 =?iso-8859-1?Q?LG/XgtbsPexnp8iYgdKKW+eTqYoPMZaD8WIyNYRACO8aT5r0CX0ETcn/j8?=
 =?iso-8859-1?Q?SK8neab2nPZ6O7QaxH/DpwR6HwImDp3/QnSCUzMvezSuvH1cYbTfIGbqI/?=
 =?iso-8859-1?Q?3Cm8Fq0R3v2Vjw/WdubPG6FJYQu21n/3jSg9E+UQgFi6of7CEzvBGlLNlA?=
 =?iso-8859-1?Q?7OkiqEV4u+55gE1zdksq5DYOyWISte5Uqt1GNX3fcC7q1SwkN573o5JkI6?=
 =?iso-8859-1?Q?jg29W1BzsCqGA9n8mbnyw945L68lN6M2vdcy52FFEg3sAXUTSSID3ML3Ji?=
 =?iso-8859-1?Q?Hv5npV3F4WWbbP7iqXpE5IBvHs5XWyn6lKoURDBXNUn8cS/Ww9qt3OoR8R?=
 =?iso-8859-1?Q?8uiNU158qveDOdAI85L9CWIOlisQeuaQHFxl4T8iQ0xn0wisvjlkLmcZuO?=
 =?iso-8859-1?Q?3/WHii3I1/pVlaJfIjl1tfodtDw/40g2DlAvJwFiVHy9Xz9oUDKQYyCPK4?=
 =?iso-8859-1?Q?e5Z4v7zUIp9PutrRCah+DJYZTS6QvTBH2Uq5y8eOevWxLbXkNC+bmPWPwa?=
 =?iso-8859-1?Q?43A5N+hsR7a+92ZsfVZyxGzXxTIme8bMhYqvpskqmrQ+/2W9zs6rh7DxCp?=
 =?iso-8859-1?Q?sgxilnAHR6UlCi8xqeahntBvm2GSCH+5rtGqE6h+raSXpP/Pe9YrHZb6U2?=
 =?iso-8859-1?Q?uLfXdiEErMa40cWKw0V+b92VWIjlkLHzbtTHjYWkg0rnCQy13ecEJxjSFB?=
 =?iso-8859-1?Q?+RWmWnvExm+BzRo4c+LdyFDuv64wlJdR7KCMZHvx1Zbx+a7x8OQqfw5H96?=
 =?iso-8859-1?Q?kEgMxkHj9M1JNiuioxwHo33PI+j8ONKKN7XRlNDOL6YpG01m2B3Wl2Sw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a45c4ef-c631-451a-980f-08da74be494d
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2022 19:36:24.8464
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CTroW4Dd9r4wkH/MKikcYldIWuImNzh9CeUI2MCLfiaE8ihm+YkJf7NgTjRMI/VFUleUlDqVcuyQxpiS07V3YQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB2985
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-02_14,2022-08-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 phishscore=0
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2208020092
X-Proofpoint-ORIG-GUID: K83p2HAFPK9HS8k1i5nQVflDQAaaxntS
X-Proofpoint-GUID: K83p2HAFPK9HS8k1i5nQVflDQAaaxntS
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use MAPLE_ALLOC_SLOTS, which differs on 32bit.  This was causing an
out of bounds issue on 32bit bulk allocations

Fixes: 06b152b7980a (Maple Tree: add new data structure)
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/maple_tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 4e41f3394114..032e7bb0d44f 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -1242,7 +1242,7 @@ static inline void mas_alloc_nodes(struct ma_state *m=
as, gfp_t gfp)
=20
 	node =3D mas->alloc;
 	while (requested) {
-		max_req =3D MAPLE_NODE_SLOTS - 1;
+		max_req =3D MAPLE_ALLOC_SLOTS;
 		if (node->slot[0]) {
 			unsigned int offset =3D node->node_count + 1;
=20
--=20
2.35.1
