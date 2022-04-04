Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 459874F1718
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 16:36:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377769AbiDDOiA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 10:38:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235560AbiDDOhi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 10:37:38 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 846D33ED39
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 07:35:41 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 234DncRr012575;
        Mon, 4 Apr 2022 14:35:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=FUYZ8DE62byvbFgTgRXWM/csXXURIVYnqylKkpAqLW0=;
 b=oRoDE6PYNpUCx89k5FhvNk0v/PKzpHitEA4sx8AVm+3TmjhpyhWpsx1PmOiY64FzIwWS
 V49Jz0/QaHAEQ5u0URCO0nKKWNOBtRUWS3QmboO2kZGpe+5drWGUcnA2137MI1pjibfY
 br462RCosSXBIYD0zkmQmy1dxNRoCItTP8l3Hh+bCY8VBiW1l6E+54h6V711ll12xbGC
 IVLvCzNwjby75B2+/5XHPe18eN3iVnh5PnEPnmw5DFBNSTDnDpQ0wUJpJElPvYlEBW3x
 AvCRHJA6j3FWVb/hs61RFX1cNEaJrTkUInSbpNO2ipcg8bcXgEijucG11DnFRUXu4+Pf rQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6cwcbbmq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Apr 2022 14:35:31 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 234EGdij027742;
        Mon, 4 Apr 2022 14:35:31 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3f6cx2gm6e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Apr 2022 14:35:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lWk9FAeZ4Wg9UjM1zn7PFqjaNbMKwsfktsjuXkIOlONd7pMtJxdqBnFThOLivAmzmwxKdrB5/RhoKkKYz61g9br+3/ZWZ6IBD/kcnbK0Cx/KOiSNULX/YVaVUGYUGSgb56RjZ3+EoFRc4XoX0iJAuM+rm9E0PrNNA26kQRaGlokeeYvAxgZdUFRA3xyFtfICRI6MwG6GTuDtyhUEm9wTyie2UQor/mpAFGNRgyqtBJ19s+Zt8iUicUbcHMi7BzikLCcIdZrFhR26uqgPujxJj26WRsBP2OdSzZyKSRL+LlnKiiQOi8kHgbaQXYRa4wIb1L/9LF7lFPfncLXKMOh7vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FUYZ8DE62byvbFgTgRXWM/csXXURIVYnqylKkpAqLW0=;
 b=TiblaA02uMLPV8r7QPY+JabegtxjcfCosNFyxrugbWEmxEltl7Sc2dSn/kcptMMAEXb44bqZqARFsylHRdu+U82fz0Xkn3DjkuQXprT6zp9D7+9Smjcz/RVZSAWhFrlYngVA4sGgHWtafU/KcKeYNG4zkhz1zmSMTX/nXxKKSdXiG1J3pu8TgQHDtBMadBLNzU1VSnGnVkbrVK3J0VZUEPrKum7cnv4UIYenUmC7KC8TTQ6ctMdgw+9fn4G1fyeTYY2Cz1R9yNuDkoWK3gZV+w5ervd97er9ELBuw7PZbhPZBYUQN/eJE8yGnjtSLUBxQxl+EU9jJXNkCGY4ixnXaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FUYZ8DE62byvbFgTgRXWM/csXXURIVYnqylKkpAqLW0=;
 b=aZBm/HJvKLigWXubk28VlotftlJjMc+M6v0M8NvZeny7RVzJsXHtI2opGKST6sUPsSP9+xCw4MeJPqSiMLElrpIcBPYa0qZbOQwsv8+o+ry420xvpc8wvVrcOqOPaB6Wk1q4ZByFiKUD6hD8KCbMGDdUncMyLVJnsb13dwMmXZI=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BLAPR10MB5329.namprd10.prod.outlook.com (2603:10b6:208:307::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 14:35:29 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::74fd:df41:4c93:24a5]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::74fd:df41:4c93:24a5%6]) with mapi id 15.20.5123.031; Mon, 4 Apr 2022
 14:35:29 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v7 04/70] radix tree test suite: Add support for slab bulk
 APIs
Thread-Topic: [PATCH v7 04/70] radix tree test suite: Add support for slab
 bulk APIs
Thread-Index: AQHYSDE7dnQDQ7y0jEC2VaE5JbopoQ==
Date:   Mon, 4 Apr 2022 14:35:29 +0000
Message-ID: <20220404143501.2016403-5-Liam.Howlett@oracle.com>
References: <20220404143501.2016403-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220404143501.2016403-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 21a6b0e8-2474-4ff2-3507-08da16485dc5
x-ms-traffictypediagnostic: BLAPR10MB5329:EE_
x-microsoft-antispam-prvs: <BLAPR10MB5329EF98F1FC78713969D624FDE59@BLAPR10MB5329.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iGl4NvwVHu4WNM3/sFi+SiI9bGzduugSmr4gvedKkP/qX0af1jhiFRYMJuKHsGcI2yN7yru2rkNKwFMkb3UEoAdFHBB94JCjQu4TfBMyHiz80zpmw9pBaHBackEGYIN+b+Mo0jpkxWZSHTQ+VD8bkwge4yj4mF8sPIjD61+/SikbJ0WFch+Z7gX1N+tYI2KRzKRkgkpjSnDkNbWMZWthgd7D60yiB7AFqbe9YSEanxAMZYRgzOCcShe9Gx6rDLfBTqOhB1yE6VhReWAZiVrZMe+yEOKxaB/JVcO4RyNj9Htlzrh60oRgx5rG1SRrlOtj6v0bXu+XaLJ1cCZbTWzCDILws6qc+2TlNIlHxVuhSPvC8LrtAzskMc0mzGOilqOmJf300zFoSeV4i8KK5HhViJiv73eHToCZu0wU91af5X1H4mSC8Nxm8PROpcNfJz8Rm8x/DIpGhNZA570dC9LsFFus4Dkneu8EELv9uvxLuQWO8nr9dnavabllWUzsO/upz4s/iQD7dupB1WgAW5Kfckt52XT9etNF5Mz5ZgyJAhbvWYdqWtai7CpmhRnZ//hUTMcUqMVIFo6BahXWYQFbl6kwuFqlMqO0vpAUUh5tfxPmtVLMvJN1656eomeIOa8vTNs2e2Iu3JFfhB09AsCq9D2Phca+EhN1pgYPDJl6HUjUAGUW93TK+MvLk+kRWoiKMvpRAdNo/nIF2BWn2qA/wQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(6506007)(64756008)(76116006)(66946007)(66476007)(66446008)(91956017)(316002)(83380400001)(38100700002)(66556008)(6486002)(110136005)(38070700005)(86362001)(71200400001)(6512007)(122000001)(44832011)(26005)(2616005)(1076003)(186003)(8676002)(8936002)(36756003)(5660300002)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?igAvV8lp5AnweDU+GCR+0Y6MrrJvEtnuBM8Oh8g7mWwJPTh87Z8WCe5Xnx?=
 =?iso-8859-1?Q?3uft/tS4BuXlPmUCv7NbA4GcG4XsAM04C67IJyHGitSbaj+4hGKAsG7i4M?=
 =?iso-8859-1?Q?d24BB7cdb7EnZa5c6ZikhaA0kop8ELltLlq1RlorUq9VGPpOvM40vGWTmU?=
 =?iso-8859-1?Q?XsqDc4uMHvXRhXEYr7aIvmJpTXqj1bFbbX2F9J48ZJt1oXFdVpRXJNpsRx?=
 =?iso-8859-1?Q?JPcvaTD2+K1ggf0ihv58tliCurFWkAJ39X64KRBIUmOAe7W9qQrMzq92Je?=
 =?iso-8859-1?Q?bZhHieWh6vjPMb11AMuj0PU4aZcIMYWXGGtbZ0nJ+Yy9tgBjEyKrdFQo0K?=
 =?iso-8859-1?Q?wNNprcFOiRgB0GNnmbXBa+D6rw0Y00i48rgG+oDc/0EGnRBCsBtcrsMmNb?=
 =?iso-8859-1?Q?QmlydzDkVlKJzOVtkN3SEnG+fFrzDv9pXWSCaFpXwHcNCTXT+HJPn86JJk?=
 =?iso-8859-1?Q?zT4izHL8Xkt6uVx4JgVZCwQLIIh+JK15jJHGmtAVV6/xOGrw4LUKAx3FOT?=
 =?iso-8859-1?Q?ZkNOKG7mDMwjI8S0M53RWAp6Ib9jpcqyaDoh/096tsz9CGtnfoQ34K/LFq?=
 =?iso-8859-1?Q?eO4uRQNFHERxF48B6dxJNDirUGY7YrO/nVh25m/rbVf4OOcc/msVGJYi9l?=
 =?iso-8859-1?Q?mGOnwU0gG/iNYqWm7PeFAgyq0y7bSLbYGkceGXbOwFC7EM5msLcqPKk1yI?=
 =?iso-8859-1?Q?aKjkg3kxU4czqYPFs+He8XgDHXuD3X2wwonfzvJIIxgJFZt8V1YQsneosj?=
 =?iso-8859-1?Q?AOCPGQQ8PRTaommPnV3AvTl1I1hSMH5t9zRrOCg16GRFjjjGx6JiGwIWAN?=
 =?iso-8859-1?Q?lwJoXlukzX0iv9BCTxH9Jt+mTtpXa2KvV4KYm8x98FaYRPHu1zq9c8sjBc?=
 =?iso-8859-1?Q?/ds+6mfjLbXYAMGn4V2jouRKU2oHOENVm4GZdn2jtoiQv/tD3LbROtJbok?=
 =?iso-8859-1?Q?zuiooAmtM4Z+wvyvyfYNk06sUwnO3i5UXr8H/u3X39VTLcP4XwurThTJuJ?=
 =?iso-8859-1?Q?j36qOr8YAmfhsutcK620fjNjlypnI30OjbNrLqEJ0C8B6LU+yk3JJ03Ayh?=
 =?iso-8859-1?Q?DplJ34iz0VVwfiNRElNV5SFYS3NKVyCwNRkY7cO2SDeFiiQTvYkoTKCsQy?=
 =?iso-8859-1?Q?ybLg4mPJ+ZxikSECF30HVVhvRQTDRIp00+7kzS+eInL4MhNCxzSWUQzDax?=
 =?iso-8859-1?Q?/GPs4wEuNxv+9MRtB2ZsHG2H3vNsNQt1yuC1xWcbrExpbk+gp56nJTlYDQ?=
 =?iso-8859-1?Q?+KLsPaLPLoNzPDKyhOSk3S6QNUo2rUWQvDsndB1Z37YMMqxkPCGzNp0Jjt?=
 =?iso-8859-1?Q?4oJox2soFir1wcKjVoNRHbToi3C67MhXTurfXGG18HvaQH1ZxIyDbG7nvy?=
 =?iso-8859-1?Q?CNU48R7FW7T6srtB/Vu0+vMP9TmXZMkpSjoV5snGz4Znai3bpWfEQkHM8L?=
 =?iso-8859-1?Q?9v1nyvsXCcAI0Q+cdljNAQR3TUYuj0+iZt1hmNzXNWJxLnPG0WRUmiFZrE?=
 =?iso-8859-1?Q?aEEd5Aozvq+/UvSCOMF/NuA7Ywx0jpzlauo0GOaWLS/iqO5Xt7AdT5fxmO?=
 =?iso-8859-1?Q?l+v/hip2yP7nn10lzDZG6T9W1Zshq1/4+ZxEESZdhInZtk7FBrsuHueB1A?=
 =?iso-8859-1?Q?JSM4186NDKbyvSFi6nO0pfvFRdeTGnbEZ88jH50YQA0//0nwYN4+tvmjWS?=
 =?iso-8859-1?Q?LVfrPmDkm1XshN/DiqOxeJuvJNN7sBhyV3QjKJK5eo2qFhiXjfkNw0d2d6?=
 =?iso-8859-1?Q?5QeD++qbMBQc02qlFCKakR9v5dEP4cdxZiDxM/2R46lwdaNyvVTQo3sPbg?=
 =?iso-8859-1?Q?SIN7wckGS2zj0Y0hyqiB3xxfAx81Xn0=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21a6b0e8-2474-4ff2-3507-08da16485dc5
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2022 14:35:29.0352
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sBxIwHbTvC4m3adtvC76b5EpPhNZRnjD9J4C24g6SWRmRISnvmS7XU+85J/M8d81zm8S1MhpoaVZ1XX5mbyigg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5329
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-04_05:2022-03-30,2022-04-04 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 adultscore=0
 bulkscore=0 mlxlogscore=999 phishscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204040082
X-Proofpoint-ORIG-GUID: uPTn8NxugfFDxv4MYSYW48_dX5veG22v
X-Proofpoint-GUID: uPTn8NxugfFDxv4MYSYW48_dX5veG22v
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Add support for kmem_cache_free_bulk() and kmem_cache_alloc_bulk() to
the radix tree test suite.

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
2.34.1
