Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 259675AF4B9
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 21:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbiIFTtL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 15:49:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbiIFTtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 15:49:02 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50ABB9081B
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 12:49:01 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 286Id9gW019965;
        Tue, 6 Sep 2022 19:48:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=Zdg9+sWoGZkw0EzPgXiv4utF7MHRTxU2EsKAJH1H/3U=;
 b=g6rrLQJy59zH5VR3QLecsrfFToKhy4medNpWpc5HJD8ITsmLRKoVxdjiof+hVwIx0Hwm
 oFPP6YqQJSSR9VHd3ezKa4SHRKCPXr1xOH93KVOedEcsIQJKB4+KSznIbkbcoOMiIe7U
 oSVRTGQ9sVxfkmtBXr1ko6A2AmVfXx7Qw0M8Hj6rEkWHc9ay9bNAFJq+Vy7YcOO53n3u
 iQ7T35yf5mmBIjVRrH3XbBZXEXaA/cLECWxv0HQ3CblVz5K5AQk2+qTSyWCo0oZsFgKg
 HCRMgJLNnmF32+0yZwNvu5FpBrncYzUdRLoZzokgbGhcxw96ZOIEGXKIKT5OGuHDkDi4 FQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jbwh1exjd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Sep 2022 19:48:45 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 286HHdKK037489;
        Tue, 6 Sep 2022 19:48:44 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jbwc32vns-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Sep 2022 19:48:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kra4APJbDeSvBBsRDiacwU2tVCbaWNcrM1RAHdurf+ckeT8EObaRphZPQQGOlinEO3k6GPUOI+PHkJZyX5j9RqGPITw17zgbXzGtdoO5DrhygA5wTBLmJVe/0QgTtrIJIbqT/nD0ne/BGZwije7dvC2v6PyUUExMaVbRUJKrb1ECIavnZJsXKYSYr3XVCx2W3yKaaYh6V2QJuiug73QyTv0OIAtgPIANccQpK+opCSsZbQ77FSmEE2SjBqxzooj9xmvSyYQ4nyx2aNwpgDb+6cpKHEIgkAAaCD1mnjYnGbuSNE+1C9RhNO0LF1sf2n5dKHvS8cHt2QBn8ZJByhnvGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zdg9+sWoGZkw0EzPgXiv4utF7MHRTxU2EsKAJH1H/3U=;
 b=O5ILpzmxu8/WaafU2rD5M/UdG0GO8zN0NaHF1djdV2Jhf4Gu4z2dGwu/UHmfE3ORAcY77Soip8Bv7tpizlZqznRZpF9OwRbz5C6DfBbecs1LbcEDSZDLznTesgKWmrAK0aon0mOJo4rnlBBxiq46asyU8sLOydDXzviLcAXBeLi5fJx6KA0RK/Jm4TYLWX7gLDmOzRlXrBXSkbBIYy9qM8zaU3L/DCgsV4hQpJSNuLXooGNat7FZTUCBSPLIMIgZaVc3PU8AQKdn0gAZmnSzNh2rztJnGHYaX+PAbhMw0k7IDqIk1xg/8JBkv/i5QUCA1T41vL7NCLGZwNzi+cZz1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zdg9+sWoGZkw0EzPgXiv4utF7MHRTxU2EsKAJH1H/3U=;
 b=QY/dc+TDiSd+UhtbUO1I1K6G+qmNfoHmgDW+2bSxjD8olsGbhaWN2Axb2EVloupDj+rfSH4rGbvObteWvwrtArAmfgmJpSmcQgW1svotJfQfS9TU5yucfhmY/rJ48R73jxfe3bvmST/gQqko9OrQ6Iinr7cFfYk03edaC7TPsGw=
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
Subject: [PATCH v14 04/70] radix tree test suite: add allocation counts and
 size to kmem_cache
Thread-Topic: [PATCH v14 04/70] radix tree test suite: add allocation counts
 and size to kmem_cache
Thread-Index: AQHYwimp+JXGj600Tk26HX1jLSk2dQ==
Date:   Tue, 6 Sep 2022 19:48:40 +0000
Message-ID: <20220906194824.2110408-5-Liam.Howlett@oracle.com>
References: <20220906194824.2110408-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220906194824.2110408-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9fc11454-900f-49b6-b3c4-08da9040cc89
x-ms-traffictypediagnostic: DM4PR10MB6183:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: exsDKxi3cQOMOvuIjF5pg/mcZbJNdW7t4i4RfAspzKoTYQGObtiPQEorRWdu/4QOXKZwKzpq8kfR64zNENziXWT66cN2pplsVvAIIfIhPbM2r7pD0P4D422ZIgAf/DFSzmmRqciGelEvUsibt4tv7e9tvNl1fB5Y31TIGnLvFL+P151m6UyrLSBTOm1SSuODghPd79ylAFoeDAJjsTF78fCW5oYUqWP9x590LSJhZLhpWAnBR3328rlJYVOyCbOCgk4ik0VtnyKIALkp1kRBxQYVxF8UZ6xlfEkf/F4B9XCiIBYxQYngxBYgBwA2fuU1aKxeIWX2TxMgijMX6O+EAlVMBb0YTk6oHTZfQ1koqbU4fNfeiZUNgChXB443MNLygl9tJeaYyn/iGAEbhk3zrgFpu0DqICxtxLNWAuQnEYodWUdr8TfQdSNuh0Vm1xn1hlND2GTfYbueZEXIx7d4NNDHIp31ClvcS27hm7XgKWI9wvZL+LC9boKg4SLEJxw6rBU6H9iGwGjIQRyrvLXofUig28bL4Nv1QUZIllqW8h275BGg/OlEl//mVSIXgbVsXIrCSIx2lt76wTGQPryXVwiU1uHGAUi3Np5L23B9asrJO2Vrb4GeMPPImSfUch1Is56KTxQXBqvTkQ3aAhgvQwdGno2hr0yJ+DHdc14MWddJA0NDRKvkgDkLi96C96uHJ6SktsEsZJvJ+Y+ewKfunQzz605G/Fk77px6DVcQtzo/C5AoGjfu1TajrgAX1nEz
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(366004)(376002)(396003)(346002)(136003)(66556008)(38100700002)(122000001)(8936002)(5660300002)(76116006)(66946007)(66446008)(66476007)(2906002)(83380400001)(8676002)(91956017)(36756003)(2616005)(186003)(107886003)(86362001)(1076003)(110136005)(44832011)(71200400001)(38070700005)(26005)(64756008)(41300700001)(6506007)(6512007)(6486002)(316002)(478600001)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?M7S7P5xKFJAnVrPG6++dYB16bqxq1EhWBV6mgA4L5iIGqmRyMcqd7lXLed?=
 =?iso-8859-1?Q?uo1HQMNIY74cxKKRPkFMrYhhndzSjcwcoomQR511x2LnSKGlqj4lg7mUGl?=
 =?iso-8859-1?Q?L7ijjyfhZD1XcFtH0Nzyn4v2L9P7AQX7UthFpInan80FXtDU5PYXFwWiOe?=
 =?iso-8859-1?Q?Fvzxse+Jfswps6Ewaeu/iLXSHqiB0MVkaO3TV5ZgdQqXkapMEUjYzTozaU?=
 =?iso-8859-1?Q?fLtgh9jRMUNPmzlqZQaPhUfy2MR/i6pfsEGKHRMea6flJmhrX7upQWWIaM?=
 =?iso-8859-1?Q?DzlojazuDlNSWtuDn1CGTCDCRu7mjorGJp7mcm7Ey4lkQDfEE0xpLlkyWa?=
 =?iso-8859-1?Q?No8CKBD64li2LzzRIO5V+wuhYIdvQJnsidab7KDPic4paYzYff6SmY1+Ne?=
 =?iso-8859-1?Q?e+2/MBpjkjsIOCJE4/Rd7p8y5w3W3raciNB/UJgP/JL6KcSU2/YhQuYvBL?=
 =?iso-8859-1?Q?Yr9gsSNNz1axP3othYIDvDE83dnb+rh6vgfIE78teUFvtfzQTwfxBUbMGw?=
 =?iso-8859-1?Q?OYip/Ym/Oyyb2WCCRul+f9rctMq2QRNE2TGaOzJD8GnXynaMGlO6wARbEB?=
 =?iso-8859-1?Q?Zm7M8fW/0w0axgAyEuYkJLqdFJNruxhWnzxdhTLd/zCSBbgdZNXTagfuZ2?=
 =?iso-8859-1?Q?ScjhIaKUEEHF6m9FZZ3x/OaPmSCJ77VLKzFZVhXc03mjK5srVIyY/mV6Pb?=
 =?iso-8859-1?Q?ujhGbKsCbD2Omg4lJZzJTkDdr1i9IhmVr+0nZWzxJ+JnnmtTRCskcLE8sY?=
 =?iso-8859-1?Q?lGvYp9+jMkVvTBCT1LnpG4PP97QU9V76y1QaRCNk5D2K+ghpOE5hEG/Gos?=
 =?iso-8859-1?Q?D5aA/jCx2Y4IXHFLFAI5y6rLZGIXJN5nnZWv7f3Uz7m+sG/QQ2qJlLVX5T?=
 =?iso-8859-1?Q?YNkpUaxQpiZIPqz0n9rmVTwxLppXtBtDRqhm9Di1XUSjC5VEEgUlL/geRr?=
 =?iso-8859-1?Q?U33dQ7dgz3+ChhGO58uGBdzwyGcQkNUnsoS+iq460haujuadEo+DzdQ/UX?=
 =?iso-8859-1?Q?Ss12IoW5vfYfW2nyzzi85inZnU1i1/j4CcU0CjXSgKg+EWMifKfIE4tWtx?=
 =?iso-8859-1?Q?j+4VeOKAHQLJsjcD7AIcwjFD+RtWKraA/zDUlAeCp60sydDHWMobf9lqkw?=
 =?iso-8859-1?Q?ioqhX2FEDv98/ZvMb/s2fz7LzJQqZL2G1gpkM7Dc4Bq6AyiZIk5JL27fEe?=
 =?iso-8859-1?Q?DPFxBgnixLVz0Echio6W+txx+hEjA2vjrZhuDIz9qp86zUd5iA100rrH/S?=
 =?iso-8859-1?Q?LqdJ1MMucUKF8EP+dDcWlaOhOSKNgrOmJg9vVnkBkJ8HRxRY9RY6pWPfAG?=
 =?iso-8859-1?Q?MPVFeaSn987k/EsdhGuOqg47YFjoqAMKktgAiUuE2ajEL6kTn611VXlWOO?=
 =?iso-8859-1?Q?LM+L9E+pIjsRUWu1G/eqlvFWd28dDRNzf6QV15HHBqlASn8bQtI15LjDiv?=
 =?iso-8859-1?Q?1VBbv7L+PZm52Ns+ZG6MEeCecRTxkuJ1KfAjP62LQZHs6aHwGFc6c0VDo5?=
 =?iso-8859-1?Q?WcKAx/mGowgcojupUMHvqfAw1dCphc6RDdPJHhEIkXbTo/rKcwly5UsuAx?=
 =?iso-8859-1?Q?khN7oqsEVebSFokf62Vf7I3H/UxkasXwIVZ9bCojA44Md2vF2b0+4EJJu4?=
 =?iso-8859-1?Q?F0rTNOTnA0kxDOfYdJRkGkAhlxx+smoQ1KsaD8GbsUUNiR/t3D5RCM2A?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fc11454-900f-49b6-b3c4-08da9040cc89
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2022 19:48:40.6323
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3qEut9hPjZNKnGaRr0g4Yf8tIXlFhb49ZO8bzEqb3XWgzvnQbEfhaB1YIJa2FkLXeD5YOdylxeC26ghicZvfEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6183
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-06_09,2022-09-06_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 adultscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209060091
X-Proofpoint-GUID: KPSP3DyzuUzscUPuUnLXL9vPUH17JV0f
X-Proofpoint-ORIG-GUID: KPSP3DyzuUzscUPuUnLXL9vPUH17JV0f
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

Add functions to get the number of allocations, and total allocations from
a kmem_cache.  Also add a function to get the allocated size and a way to
zero the total allocations.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 tools/testing/radix-tree/linux.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/tools/testing/radix-tree/linux.c b/tools/testing/radix-tree/li=
nux.c
index 277aa8b70abc..f20529ae4dbe 100644
--- a/tools/testing/radix-tree/linux.c
+++ b/tools/testing/radix-tree/linux.c
@@ -24,6 +24,8 @@ struct kmem_cache {
 	void *objs;
 	void (*ctor)(void *);
 	unsigned int non_kernel;
+	unsigned long nr_allocated;
+	unsigned long nr_tallocated;
 };
=20
 void kmem_cache_set_non_kernel(struct kmem_cache *cachep, unsigned int val=
)
@@ -31,9 +33,28 @@ void kmem_cache_set_non_kernel(struct kmem_cache *cachep=
, unsigned int val)
 	cachep->non_kernel =3D val;
 }
=20
+unsigned long kmem_cache_get_alloc(struct kmem_cache *cachep)
+{
+	return cachep->size * cachep->nr_allocated;
+}
+
+unsigned long kmem_cache_nr_allocated(struct kmem_cache *cachep)
+{
+	return cachep->nr_allocated;
+}
+
+unsigned long kmem_cache_nr_tallocated(struct kmem_cache *cachep)
+{
+	return cachep->nr_tallocated;
+}
+
+void kmem_cache_zero_nr_tallocated(struct kmem_cache *cachep)
+{
+	cachep->nr_tallocated =3D 0;
+}
+
 void *kmem_cache_alloc_lru(struct kmem_cache *cachep, struct list_lru *lru=
,
 		int gfp)
-
 {
 	void *p;
=20
@@ -64,7 +85,9 @@ void *kmem_cache_alloc_lru(struct kmem_cache *cachep, str=
uct list_lru *lru,
 			memset(p, 0, cachep->size);
 	}
=20
+	uatomic_inc(&cachep->nr_allocated);
 	uatomic_inc(&nr_allocated);
+	uatomic_inc(&cachep->nr_tallocated);
 	if (kmalloc_verbose)
 		printf("Allocating %p from slab\n", p);
 	return p;
@@ -74,6 +97,7 @@ void kmem_cache_free(struct kmem_cache *cachep, void *obj=
p)
 {
 	assert(objp);
 	uatomic_dec(&nr_allocated);
+	uatomic_dec(&cachep->nr_allocated);
 	if (kmalloc_verbose)
 		printf("Freeing %p to slab\n", objp);
 	pthread_mutex_lock(&cachep->lock);
@@ -99,6 +123,8 @@ kmem_cache_create(const char *name, unsigned int size, u=
nsigned int align,
 	ret->size =3D size;
 	ret->align =3D align;
 	ret->nr_objs =3D 0;
+	ret->nr_allocated =3D 0;
+	ret->nr_tallocated =3D 0;
 	ret->objs =3D NULL;
 	ret->ctor =3D ctor;
 	ret->non_kernel =3D 0;
--=20
2.35.1
