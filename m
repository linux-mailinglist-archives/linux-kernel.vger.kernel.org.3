Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EBAE5AF4BA
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 21:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbiIFTtQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 15:49:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbiIFTtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 15:49:02 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7731C93200
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 12:49:01 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 286Id90X024660;
        Tue, 6 Sep 2022 19:48:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=Bk/NQTe80ctz+CIzie1mLHIq7xE/egasLlc8YSDwCjo=;
 b=CuNY+qOWA026HtAEuBTj7DFaWTFqOGvcZ5fMOGK1KNJe+0NUu7MZnwXgg52LBNxfmLqY
 WXzwpO8WJ6KXnnHsQWSYjljaxnJLrjFSrQeqTrNATQvONulxUi9s1P0nWUWZV6K5zl+D
 LiVWLSZVEpVLtnqImj33rJR2zKbHMnGWrlHVjD1INCiS4hvpFwG7/4fiXLHADDwaaUqJ
 tAF5USBM5zxAF0CHP12/yu3Qt2+BQTPS31e83kHgKR+4WOKBzjM/wUkAxnldWwOd1SW1
 5+Q3y0JHWCJdQUxrNb5n13pJayzcwgs1wSQNzw2SvW2wT7hFr9QFrHKMPA8ay0+qKJXv aA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jbxtaet4r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Sep 2022 19:48:45 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 286HHdKL037489;
        Tue, 6 Sep 2022 19:48:45 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jbwc32vns-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Sep 2022 19:48:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W8r3tj6oc0u+gbLWqqDyWfJl5V54Byo4GcrW6zgLM88VXCVxoOUgqAPYHzCENJKZUQPP5Ezuz3PRVR21sONiILbqdMT0AeA9BwaYqJK6KP2PB/1asvDZKO9W4O+h73OUx2dbCVZ57aVnHVpFcuZPAnZNNyjHrwmuFodwIdoyMGAs2YNqmd7sBngj3nwXVRUJ6LVVTpnyQEMtd+qTzDL+XoL+/txbYoE6muqtv0u68qAT+oJzjqpMLqOMG+1P1QdV8k1wCHtu7EC4hYiW+WpLakw/7E7mHG1KvAnqGHrirfIAtUBsrnKoPGJM85DFl0DW2RSxF+2dwtzdBY/8kZSglA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bk/NQTe80ctz+CIzie1mLHIq7xE/egasLlc8YSDwCjo=;
 b=K0j8Uv29OasCVV6qrYAOdqnlJnu8EFjnoOFNWMyqlNsPmhL6v6W0qRwSi1B6v3zE2/QtCQ0sE5qmDuvGKQRyaqdsZDHqyL/NwhORP8BGTkUoAmHKtB5kbQ3mr0bx1RNTSAZOnlFJC4lnXpjvZC04+SX8TNykPtvin+D18PcsseQ3yvN8S+UkN9rpsbUBTE61WfDwyXLkVyqVTjoz7uXTFYZHq1EOPED5bhOnQbLbto9RDBgRHa7VQC9mdow+XXNJP2ZG4Zb+/zp6+Tv7vYlDrA8x94gSNBn5HbRqzqa/eXyKTJsoYgpamcwBzx4WlvDEUpmjPnIg9chKJWgTJfmivw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bk/NQTe80ctz+CIzie1mLHIq7xE/egasLlc8YSDwCjo=;
 b=Gj74NUhT90crLtUONKxHPYBvEXR+N0GMi2UWMMFeslKPu300inw1I6Urk+9E5zrtgt5U533ToGYZgDd89C0CSyEaXZttL31g3SfQCoKKsYg4LDfQAaE38WirZCHgeZsqwm+5vYUI6c7uEvqzx2x8fCl10g61Bf6Sw3AciYp0cUY=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM4PR10MB6183.namprd10.prod.outlook.com (2603:10b6:8:8b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Tue, 6 Sep
 2022 19:48:41 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a420:3107:436d:d223]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a420:3107:436d:d223%5]) with mapi id 15.20.5588.018; Tue, 6 Sep 2022
 19:48:41 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH v14 05/70] radix tree test suite: add support for slab bulk
 APIs
Thread-Topic: [PATCH v14 05/70] radix tree test suite: add support for slab
 bulk APIs
Thread-Index: AQHYwimqU+mNk0mlYEG11dNuoqcT8w==
Date:   Tue, 6 Sep 2022 19:48:41 +0000
Message-ID: <20220906194824.2110408-6-Liam.Howlett@oracle.com>
References: <20220906194824.2110408-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220906194824.2110408-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 918627c2-253b-48fa-88d9-08da9040ccc0
x-ms-traffictypediagnostic: DM4PR10MB6183:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oMfaGzyy3TDH6jK6UdpB60z+aqHSjYur/FB3PxQg9pgTZ28bwHSs7xuV5d3m+92QyYyC2DKE9xErr5J0yIUUnj0GORemEvqeFWVMf69K4vV/DFe5klBjHbtYnQGNXnGsXduYvEkk5q2AfBcoTqf/7QCtvodBeeEcnatNrnjs5MV3ZaHtkphkJPzgM6IzPGNDAylSBDnhCbO0skRSuNZK314lCjm7omNt2yoYIOFUUCKsIW6UO+7abrdjdd8QJAeF5P2qe+16NtHygOszsWoNqla4M9G2KI24by4RdcHkb6ZoSLlASQxZVez/dfs6GdDlgfGSIGj0IOBk1cKKX5cFqt8sVsGFDyVyaJec/0JEu6bzW1bSAz7Y28EUGFNd2nSo0IV35Frqa2KXtjr7F4p+K/HlZIlPwggPldoun8wYGmnNNkphEpmPKdQPCtm7aHUCv0k9ebD8Exv9gOtSzX3655NjcNhJav8k35ek390V3vwh6KuuKj2KpVg+nidvLfDtVrAsQrwNAB09XMIAHA58stbKatnN2shKLEuMwm/VwOx9uxRp34A5xSBl74gGuicWrWHxQCo1p31aE9zRBFzAPrf5rtnbe0wKbpAr1mRfsKy4hYHIyfx8l0Zfr/Ww/Ux358nC92XsNU9oiDHeJvAz6Wir6o0p1hKCAXH8h8obRh/q6yQw0XoR+hfwLIg7Y4qx6bWFmDrW4cnJ+3hkrk4jh6L+cIhV6O4iDhcO/bbIx0Sux+uCIo58uGslBNyAoRmNrZqgFnLI/P20Rc+ta3MunQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(366004)(376002)(396003)(346002)(136003)(66556008)(38100700002)(122000001)(8936002)(5660300002)(76116006)(66946007)(66446008)(66476007)(2906002)(83380400001)(8676002)(91956017)(36756003)(2616005)(186003)(107886003)(86362001)(1076003)(110136005)(44832011)(71200400001)(38070700005)(26005)(64756008)(41300700001)(6506007)(6512007)(6486002)(316002)(478600001)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?2NldmIYE+yDIwdMfeau5V2qF1wu0f3duL6mB5hLdg5plRwDGHaJ/HCsBr3?=
 =?iso-8859-1?Q?bs8+LGut8xCO8ueKZ+qdi1mLceuyUiIrUVT0C3EZBvBbv+eviLE1uvzZNq?=
 =?iso-8859-1?Q?soQg2EFjlB/B3OkpAB653rf4rJoQBJMm/uaQdIQUyxD0klu3p24jpJt9e8?=
 =?iso-8859-1?Q?ucd9HHx6kKZWZGjSdcNIrbAhY6yknffwxSI3FRlfuxzF5NBIndVjbQa9kU?=
 =?iso-8859-1?Q?xY+0bwMQgebz9GYYDfa5rehFi4T/UYEkFmf14tD41WuTbcwQ8/201PBAqg?=
 =?iso-8859-1?Q?XYGw8uoovxwT1LoBIsEp3onCOdEkHCnfgUd1cLG01gUL9+Y+2xNRfQqtHw?=
 =?iso-8859-1?Q?v1TybGBLy8iy1P5NXxKg7rfJRyxdEI5ixwOBk/Kfh8QfFba7TvQ2zRCXFi?=
 =?iso-8859-1?Q?/28Xrn0l497K0gRMufLZq0LtpnDyA/p9olLrAxaupuafLHKDo3MfX1JhA/?=
 =?iso-8859-1?Q?yC1Qfmv4Ww0DeL3iDIqQQ5ZpBImoMze0+Tcv9ht3A+6nlj8INmDqOcaHft?=
 =?iso-8859-1?Q?lLlXQhbRRxL5ipOnFQ4w6omrH+s9rRvjW+4msVlwbiFGXcWp4m1Z6FuxLX?=
 =?iso-8859-1?Q?XfwspiBQtuuKFzsTtL9U6EetDz9tAePFaXrxJuzZ+8SFXtwyhcTbm66tBD?=
 =?iso-8859-1?Q?zyA7Pqjua3tZ1FNEc2Vm/hyiAqU8TVIuQIUgp3byLRemlKhBytP5j5GURO?=
 =?iso-8859-1?Q?9+w0qG8jgsOwRJ1RpK2i8/VZ8+dfBt5+taI0MlsJnyAOJu3TVTORRGu90v?=
 =?iso-8859-1?Q?BhMzojSAKuLQwkggXAhWJNeywbrjUC07OrER903s5OBgL8R+P2qNtFqhXU?=
 =?iso-8859-1?Q?8WuqdxpsN0egNKfvScRmlRR0nDxzp7w5b3PuImMny7lVJJYfhUH/RuCivK?=
 =?iso-8859-1?Q?x3AoUUfF5jKKlWq7lTFWrgAEpBYVdOg6LpERh3GS9r6YAsm4Qas1IuK9ho?=
 =?iso-8859-1?Q?TwPjdJjtBpPUloJCmb+a0Qn+aQi4gCWfR3cG7j86gUzmjM8hKa8MBxZquz?=
 =?iso-8859-1?Q?ux/2Y/OmLJB8mcHyjwgvwGy/6jfXBte+igDwSYvvtIasQcktp2IAx1qpnh?=
 =?iso-8859-1?Q?wnJx1mbj+XvGkFD+eTrMeZQhgfIqXrPER6N6Ce/5bKBWSCH+oTOvNaLAep?=
 =?iso-8859-1?Q?GjG7QOgphHY7O6vxp2meDeJl4ZZ7qCj18F6dddJJaeXFdqC0GGXZOIbceq?=
 =?iso-8859-1?Q?Fry7kT2Fg4b42X+RXgdz7S8zATlcbJGLS5WJurOoN7IgDLGmfFbEPb8y2t?=
 =?iso-8859-1?Q?Dzv7m9o47Dpx7yKChX+XM1X7KRq1l90r5SrAZOX/dt5dwlmBiTjeTJuboy?=
 =?iso-8859-1?Q?3DeGHoTTwhlV5DaAMD4UmY81r7d43CfHsAxJbcXVyWGKs4KZxGsZFq8pqb?=
 =?iso-8859-1?Q?Q/EC2AXeax8hwXEujf1aHLZ2XJCvMZskLZI2NM5QwoFHCUsiim101mIqSN?=
 =?iso-8859-1?Q?/3H2aGYJy05V6YYgZJ/xRj+W1WDx9xjWz3DMC3Nu1KfG42A+njXpD/LMcB?=
 =?iso-8859-1?Q?Xb2A4hYb+RaDEf6ESsG4b+jo1OeGE0N8F6lMFafoyLA8q7DKjwLVqb5Sz5?=
 =?iso-8859-1?Q?0Ceh0OpneE23xsXwyBxVVJWlFJJChU1f3mp8FAdIgRPqcA0oo61Rc1FC1J?=
 =?iso-8859-1?Q?XuISQmnQtRCgoImBMkfdknaSyEwI2/D0lauNRKULZz/1XUWzQKFBwb/w?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 918627c2-253b-48fa-88d9-08da9040ccc0
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2022 19:48:41.2417
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EwukgLMQ49IK3E9GNdyuBrNS6yzbKR0TOWqGIpCV0theXyAYec3UBK6V/hl9Ob0yFQ/BY+tw+CT+HPCTcLDdFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6183
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-06_09,2022-09-06_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 adultscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209060091
X-Proofpoint-ORIG-GUID: T1Vmwl9qEZycjV9Qn2LgB3G1lNOlEiZm
X-Proofpoint-GUID: T1Vmwl9qEZycjV9Qn2LgB3G1lNOlEiZm
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
