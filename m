Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 917AE59C20B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 17:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235764AbiHVPDg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 11:03:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235863AbiHVPDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 11:03:14 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59DF63AE42
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 08:03:12 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27MEkObK022935;
        Mon, 22 Aug 2022 15:03:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=Bk/NQTe80ctz+CIzie1mLHIq7xE/egasLlc8YSDwCjo=;
 b=i1i6yD8rmOzoJXhU/rtLUzwskg9bmt/xdqlWki0OwPQ+nWCpmYLXsEHOFD8Uv5nzBbAJ
 mqTTGprNASOjOVXEw5dbblclQl4qJqcZrUSg/nJd7BKVyT0sxtm5nv2zPKNQvc5c1MHq
 vV2ULGQqsu4UTRMRF9yYLLKhjwP0Id0A5H3Ak9DHGfm6WMJm9+XRD77UCVTlNM+sLiqj
 /Zh1pmGVt0nikRamRELR3o5oFC9Oy3EG6eHjBYJe5lKoNwYUh836jfe4j6MlNfW3u4nN
 FWqcfJ55mJhiVHVqmeh1PNrwywwvyH7PLD3mlQiSzLNXLsRgyzGZdqLesOgQFuOGTYbG tg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j4ar8gbb2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Aug 2022 15:03:06 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27ME4OfZ005191;
        Mon, 22 Aug 2022 15:03:05 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2171.outbound.protection.outlook.com [104.47.73.171])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3j3mn3tuaf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Aug 2022 15:03:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BfvLV1ujbyCBiHfJ7RMovOm/cvAht45VuH+x+3jO1r7f82R+GzxTw9pvaB8f1D6Ve2jW+glykwYr4w0LdKzf5M5XKQiSl4FTKKZpiVoUJovrM/LicdgUbNpZIvp/LwD1Q3eILxvSp3xfo7eg5E1poqxfF9rh3CzhXQo3mO8Q1qBDw5TPho6GNo2YsuBNkdrRfPV463yjKF1UOpBD6tJS5asoqcIuCmXFOhUuoreHEIaen/mrUSypUwHLdKl09yyWhKU3uvFdwgAjMT1KxBr6X/Jwuz9Vw43XXUBwdNa7XJroRAbI/LH9iiMQBUJUP14tueluFXb6W/n3pDd6SkXD1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bk/NQTe80ctz+CIzie1mLHIq7xE/egasLlc8YSDwCjo=;
 b=hYzhlFAXz8H1WhD9WqyBb8GKFHi7NRqzvntKhd7kkeVcmuG383FZq9e8jQxDBAkIDG/mDI/SMWnNiv1raIAspaC0u2kAje2+JODKUgzsPoeYDK/y6ZY6irEWzje4pPeId2WLrQ1cOfQSXLHsFOEDRnoiQDfQGeXV1fd59n/xbKAZDyMxOZDkHXpIIlWoZSz9D1EOa5tebaT2J3YDBTW4yISwh+e5ryVetr8JMGdxJVSazUPT4RwM7kMYWlinLzdjtHmyGCxxjw3/+VC3nSoxbuuGU5NwIAPhfC3eJSJd/KBAeACWQp0OKjbOsFpmQzPTRySNMS9eLjkQ4LmJ9Vs5Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bk/NQTe80ctz+CIzie1mLHIq7xE/egasLlc8YSDwCjo=;
 b=0PLhQUgwI+3lqxa27ToWEr3dLwvfv3f8wQwU04QPQjBmLau4Dr8KO5t3gj+n0ueRZ2Cmbugfu1xYIVmstbG3CaV/WiMeAv0FS0VInoEgDdTa8G9cBw9geAceLvxk63+aT5IZglM35AMkXC2CZ3pBNZegqFJu+/lhoE6ET+C/nn8=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BN8PR10MB3506.namprd10.prod.outlook.com (2603:10b6:408:ad::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.21; Mon, 22 Aug
 2022 15:02:52 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3d34:ebb5:d9df:98b3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3d34:ebb5:d9df:98b3%5]) with mapi id 15.20.5546.023; Mon, 22 Aug 2022
 15:02:52 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH v13 05/70] radix tree test suite: add support for slab bulk
 APIs
Thread-Topic: [PATCH v13 05/70] radix tree test suite: add support for slab
 bulk APIs
Thread-Index: AQHYtjgyIxzWV71aGk2i7KSYM5RorQ==
Date:   Mon, 22 Aug 2022 15:02:29 +0000
Message-ID: <20220822150128.1562046-6-Liam.Howlett@oracle.com>
References: <20220822150128.1562046-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220822150128.1562046-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2bbbce85-be89-489c-c456-08da844f62c1
x-ms-traffictypediagnostic: BN8PR10MB3506:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LxkY8E5v8pwufKzshT4FE+7NT5IzrtIgJtgRLXIAoydyLlInQG5G78IDVoxdfLDkmg7R6+VOdFPdLnvndvFF+vVJQs+SpQpuVZl4W5HChQMMAkTbI2X7W+/aNMkfPOggEC6yuHXy/WJ6XR67bAizgJhqbvfmGy4j4Y3ILbh+OZ13xMWODNbnOpfhhoLXnO21Q7889KIzdAOH6u94wGbbEKZKZ6gkF2IpJNwlCU/AP3eOVIXVsjAaZnfYyVg0rHSO439EuYC29SN/kR8qQvsZbU2iQ6WbWTwCLHpNfkARzzTGmoQlo9IgZnVgKtBIoJUK5F31nZyPkCNCjNCnu0/IfFoeRV4pSbPqFkjL4xu210/2t6JOJNvjL54QY5+GCClhL/sn83SVmv2FIDZbHNyQO6YIpxKbp/6D1mdQk4wqlJv8aFZAoY7Jn7YAcv2sRa1PSWqy67PTJhg6I+iV0kF6x1EIB1nS1pbAg3nSc8NXFlodaTPWZJ/AKZ5LUSwxGTAKLqfIkHHQgLzRrBpvNcSYQDicZKq1GfYsu4UV7TtRh6wkFmziLTzy+WZDi+Lqv6gwlj2VFZp3XotahEdbYM+/UGNfrRV/sWgkjwLf/RoGkN6juq9bTgAAhxHOSYqCB/q0UMF47N9eoH5c8yVBPIcWwAiCcDYG7inT9MSB4p7uRVqcUxUacvHg+o4PUAoXwsZJ3gF6cZE/pGdQC3TY5p4oarf2P8mQtR+lmggdbqfkNuagF5ONoU93fqXtgbR268CXcRPPcG0SwtUwJ9ydcRodfA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(346002)(39860400002)(396003)(366004)(136003)(38070700005)(83380400001)(38100700002)(66556008)(36756003)(66446008)(122000001)(66476007)(8676002)(4326008)(64756008)(66946007)(76116006)(71200400001)(91956017)(6666004)(8936002)(26005)(6512007)(5660300002)(44832011)(6506007)(478600001)(6486002)(316002)(110136005)(41300700001)(86362001)(1076003)(186003)(2906002)(2616005)(107886003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?qIsSMTFsdveYNKv9k6JFuR98iI6HIkVd8wkTH8iJOwO3Gns7reIGy/404L?=
 =?iso-8859-1?Q?SgMFkGNlwJg+ym54ebWmPo+TUdMpOqynr22/qA9bfymw3+KUuAB9tEG7Sx?=
 =?iso-8859-1?Q?8YwkS/aJfpQBe03SygYceAFArxh1wX1OflF4W4d4tguQsxpkfSBftOP8lF?=
 =?iso-8859-1?Q?9QYXEwvBy+aOmg5/oAWkCCQj3sjJ3+NB8p00BrnRBrdBjEMSAvjABVvG0K?=
 =?iso-8859-1?Q?mBq9BNOCjdH6VKT6JUosKHqQiAciiW9PkX4u6NtmOVSTEwChcFA8KMfMec?=
 =?iso-8859-1?Q?JH4Lm1sHozR08z7LB7Q6kIZrCc6t4muddTJrmuO2W5D4oynh1zaU7TaXiG?=
 =?iso-8859-1?Q?MzN4kjclCQlrt1kBrZRIfm5thDlU7corA5sDaqx7MakHjc48gsAt5gmxRF?=
 =?iso-8859-1?Q?y7zl4LKnnaICVouA27Dd/iTtV+lt4RZHrcT2ooKsChnYcDNLhfWm3Goqjx?=
 =?iso-8859-1?Q?JUwu9HyfDIXu8H0Kqdl2RqRwQdy6ItmjkfnSouj6uYkxeqwa2OE6WM9KpO?=
 =?iso-8859-1?Q?FGnkf97bFl5qI8DT9CO0fuj3eOjkbwYitQYBlLlu14zB3sfowzadNKTstu?=
 =?iso-8859-1?Q?aEtQNEu/KjOEkPrkkPpYf3LL+lxB6eed+B48US1fyO0ISJoPvhZRbYnAQS?=
 =?iso-8859-1?Q?Fq8VpgJtJmUQSSU4xePrqjp9lwQU8vw/9t7JvlDba3U0kuxCrrA8qwbn8t?=
 =?iso-8859-1?Q?Vdudqk/AkLfXct1AnK43wfpkLNwbaRz51VHlcRnGzFZKCPs2UFYfruKnSN?=
 =?iso-8859-1?Q?/OXsKe8whiHcx5fDy+ptweKUUZDgj0dRWDgOh9XmtdpVbz5hGGJdHxnBcn?=
 =?iso-8859-1?Q?EzPNhIaIMJIVuo8Ge2/K8z/ztfNAzrBGIVGwdBIY54OoQWwbwyhRouP5mT?=
 =?iso-8859-1?Q?58PUuyM/tW9g3Cz0i7IWop0qkVPyN4zeQpUCAsAkKDUvwDvMpkJXai18Bo?=
 =?iso-8859-1?Q?qan/Bavq/3jfQ93EkAahIvQyLUlJICjQyVUvnVyu/OAbjL0pEUWJpGGpCi?=
 =?iso-8859-1?Q?apRDTKTkeEtyBaSbD4HfR/6BpK0NJmYP4WHCFTaYxPxmbW6uKbc1Moe7/4?=
 =?iso-8859-1?Q?7xiWpCtke9wvPEIAPIwom0XU5uGwSLjBTEB1aksTg3Plix88q+sRRWumsz?=
 =?iso-8859-1?Q?6BZyCTt0WMhiWZjYywAuLixkV/RpdNlmZYXcN3i+04Af9ilp2Xy4phHqKl?=
 =?iso-8859-1?Q?jo6a62vXDiuB/4xUGcUWT43gUhKKhXd6iG0Nfw6a9FasjAUnRTsXvpmaJb?=
 =?iso-8859-1?Q?RSoMzVZ2EuTkGveU+5VSPjGrvRmSL2KECOtp+CMZtPtm8TjHT4F7dcuMIp?=
 =?iso-8859-1?Q?9pycjgej/3snTC0YJoh0gJmMQyrxrSBZzlPATh6fNEll38ZOHTKUr+cm71?=
 =?iso-8859-1?Q?b+a+QWxcuHmqVekioAbag+F+galxGiukzvd2jD20G6/asXr+0HKTezSoC6?=
 =?iso-8859-1?Q?HoP+AnNViWkStLor3kzrDxBkk3fpeN3f+vLtgfcHnx08vp0fI+TAxWvSTf?=
 =?iso-8859-1?Q?bqEh91bKHGhXIDjGrZpFp+XZC9fcZkM57RaIUZjX2RyRDTU+id3JwmoVet?=
 =?iso-8859-1?Q?i/LkMDlsUxo7oExFxBPLYzvvX6omOJTIPeDvBll9dRvW1fvy2sPBwIKzEt?=
 =?iso-8859-1?Q?HZl09GcqwijshR3WHCr7CI5sGk68H0gYlmtxBWSfT3mmQ5JH5BNQfpEg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bbbce85-be89-489c-c456-08da844f62c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2022 15:02:29.5823
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u6VcmMUUF8Jj8S/j7Pr+BvxFDtuUOwVPmazsURxSHcJYj1AMCPMrrzlXXy5l+zjj75/aVM2BnyTRMiGLtXe8Ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR10MB3506
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-22_09,2022-08-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 phishscore=0 mlxscore=0 adultscore=0 spamscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208220064
X-Proofpoint-ORIG-GUID: 0xxbaT76MpJNtG3wG7IQ9IMNdqb60QMA
X-Proofpoint-GUID: 0xxbaT76MpJNtG3wG7IQ9IMNdqb60QMA
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Add support for kmem_cache_free_bulk() and kmem_cache_alloc_bulk() to the
radix tree test suite.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 tools/include/linux/slab.h       |   4 ++
 tools/testing/radix-tree/linux.c | 118 ++++++++++++++++++++++++++++++-
 2 files changed, 120 insertions(+), 2 deletions(-)

diff --git a/tools/include/linux/slab.h b/tools/include/linux/slab.h
index 0616409513eb..311759ea25e9 100644
--- a/tools/include/linux/slab.h
+++ b/tools/include/linux/slab.h
@@ -41,4 +41,8 @@ struct kmem_cache *kmem_cache_create(const char *name, un=
signed int size,
 			unsigned int align, unsigned int flags,
 			void (*ctor)(void *));
=20
+void kmem_cache_free_bulk(struct kmem_cache *cachep, size_t size, void **l=
ist);
+int kmem_cache_alloc_bulk(struct kmem_cache *cachep, gfp_t gfp, size_t siz=
e,
+			  void **list);
+
 #endif		/* _TOOLS_SLAB_H */
diff --git a/tools/testing/radix-tree/linux.c b/tools/testing/radix-tree/li=
nux.c
index f20529ae4dbe..2048d12c31df 100644
--- a/tools/testing/radix-tree/linux.c
+++ b/tools/testing/radix-tree/linux.c
@@ -93,14 +93,13 @@ void *kmem_cache_alloc_lru(struct kmem_cache *cachep, s=
truct list_lru *lru,
 	return p;
 }
=20
-void kmem_cache_free(struct kmem_cache *cachep, void *objp)
+void kmem_cache_free_locked(struct kmem_cache *cachep, void *objp)
 {
 	assert(objp);
 	uatomic_dec(&nr_allocated);
 	uatomic_dec(&cachep->nr_allocated);
 	if (kmalloc_verbose)
 		printf("Freeing %p to slab\n", objp);
-	pthread_mutex_lock(&cachep->lock);
 	if (cachep->nr_objs > 10 || cachep->align) {
 		memset(objp, POISON_FREE, cachep->size);
 		free(objp);
@@ -110,9 +109,80 @@ void kmem_cache_free(struct kmem_cache *cachep, void *=
objp)
 		node->parent =3D cachep->objs;
 		cachep->objs =3D node;
 	}
+}
+
+void kmem_cache_free(struct kmem_cache *cachep, void *objp)
+{
+	pthread_mutex_lock(&cachep->lock);
+	kmem_cache_free_locked(cachep, objp);
 	pthread_mutex_unlock(&cachep->lock);
 }
=20
+void kmem_cache_free_bulk(struct kmem_cache *cachep, size_t size, void **l=
ist)
+{
+	if (kmalloc_verbose)
+		pr_debug("Bulk free %p[0-%lu]\n", list, size - 1);
+
+	pthread_mutex_lock(&cachep->lock);
+	for (int i =3D 0; i < size; i++)
+		kmem_cache_free_locked(cachep, list[i]);
+	pthread_mutex_unlock(&cachep->lock);
+}
+
+int kmem_cache_alloc_bulk(struct kmem_cache *cachep, gfp_t gfp, size_t siz=
e,
+			  void **p)
+{
+	size_t i;
+
+	if (kmalloc_verbose)
+		pr_debug("Bulk alloc %lu\n", size);
+
+	if (!(gfp & __GFP_DIRECT_RECLAIM)) {
+		if (cachep->non_kernel < size)
+			return 0;
+
+		cachep->non_kernel -=3D size;
+	}
+
+	pthread_mutex_lock(&cachep->lock);
+	if (cachep->nr_objs >=3D size) {
+		struct radix_tree_node *node;
+
+		for (i =3D 0; i < size; i++) {
+			node =3D cachep->objs;
+			cachep->nr_objs--;
+			cachep->objs =3D node->parent;
+			p[i] =3D node;
+			node->parent =3D NULL;
+		}
+		pthread_mutex_unlock(&cachep->lock);
+	} else {
+		pthread_mutex_unlock(&cachep->lock);
+		for (i =3D 0; i < size; i++) {
+			if (cachep->align) {
+				posix_memalign(&p[i], cachep->align,
+					       cachep->size * size);
+			} else {
+				p[i] =3D malloc(cachep->size * size);
+			}
+			if (cachep->ctor)
+				cachep->ctor(p[i]);
+			else if (gfp & __GFP_ZERO)
+				memset(p[i], 0, cachep->size);
+		}
+	}
+
+	for (i =3D 0; i < size; i++) {
+		uatomic_inc(&nr_allocated);
+		uatomic_inc(&cachep->nr_allocated);
+		uatomic_inc(&cachep->nr_tallocated);
+		if (kmalloc_verbose)
+			printf("Allocating %p from slab\n", p[i]);
+	}
+
+	return size;
+}
+
 struct kmem_cache *
 kmem_cache_create(const char *name, unsigned int size, unsigned int align,
 		unsigned int flags, void (*ctor)(void *))
@@ -130,3 +200,47 @@ kmem_cache_create(const char *name, unsigned int size,=
 unsigned int align,
 	ret->non_kernel =3D 0;
 	return ret;
 }
+
+/*
+ * Test the test infrastructure for kem_cache_alloc/free and bulk counterp=
arts.
+ */
+void test_kmem_cache_bulk(void)
+{
+	int i;
+	void *list[12];
+	static struct kmem_cache *test_cache, *test_cache2;
+
+	/*
+	 * Testing the bulk allocators without aligned kmem_cache to force the
+	 * bulk alloc/free to reuse
+	 */
+	test_cache =3D kmem_cache_create("test_cache", 256, 0, SLAB_PANIC, NULL);
+
+	for (i =3D 0; i < 5; i++)
+		list[i] =3D kmem_cache_alloc(test_cache, __GFP_DIRECT_RECLAIM);
+
+	for (i =3D 0; i < 5; i++)
+		kmem_cache_free(test_cache, list[i]);
+	assert(test_cache->nr_objs =3D=3D 5);
+
+	kmem_cache_alloc_bulk(test_cache, __GFP_DIRECT_RECLAIM, 5, list);
+	kmem_cache_free_bulk(test_cache, 5, list);
+
+	for (i =3D 0; i < 12 ; i++)
+		list[i] =3D kmem_cache_alloc(test_cache, __GFP_DIRECT_RECLAIM);
+
+	for (i =3D 0; i < 12; i++)
+		kmem_cache_free(test_cache, list[i]);
+
+	/* The last free will not be kept around */
+	assert(test_cache->nr_objs =3D=3D 11);
+
+	/* Aligned caches will immediately free */
+	test_cache2 =3D kmem_cache_create("test_cache2", 128, 128, SLAB_PANIC, NU=
LL);
+
+	kmem_cache_alloc_bulk(test_cache2, __GFP_DIRECT_RECLAIM, 10, list);
+	kmem_cache_free_bulk(test_cache2, 10, list);
+	assert(!test_cache2->nr_objs);
+
+
+}
--=20
2.35.1
