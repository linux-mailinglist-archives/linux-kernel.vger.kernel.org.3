Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C5EA57733B
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 04:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbiGQCrE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 22:47:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232660AbiGQCqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 22:46:49 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB56D1A043
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 19:46:48 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26GJ8rqs005737;
        Sun, 17 Jul 2022 02:46:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=wKhhnkwkM2GXAHBza4WWAtPG0tasxLWA0VDvgftdQYk=;
 b=VWHLv9V287ymVZza9XHm8geXH43LW+6WMsOWn9eyykG2BrbmnPvGKGQyBPcIzsin0CG5
 as2R7E2YcYUYADDkEPVpZAVFiqofSzthHpIOE9fkI+ht6Es8CuzHm2ZSO3DaLwms7M3Q
 aCvp8gnB2u8pT+nbsJxTcdOO/cZHkqkBnbzO9nRxOXpguPxfbCY3J3oCCMX4OSymM2zx
 oCHMTYvR5alLzgwW59Fm1DY36KITjNHdIY32GXuwgd0FtqEq6QhbVRuzVujMXA7G1RRb
 vQJdB+ajdTXBehdKozk5xtJT5a3kcMIjcdZF2Ozf2UgHf8je2f4v4GULq+kHoT5hV08E Nw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbn7a0y12-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 17 Jul 2022 02:46:37 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26GMY3ED005901;
        Sun, 17 Jul 2022 02:46:36 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1m9d7y0-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 17 Jul 2022 02:46:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=USGJ/mVOvgftjFDfdLzej2qZ8iIbJ0I5c9x4tgL+DXa/m1ocDEwEVlld0dkzNSTDqsXVJN6PHAo1ib3tmmpsi2WAg7wvMrJDwcEkF87VHVqvQlbd/T0iGxlVL1y48X22uDFEGHqm5qAcb30k/JAE2PCqxCMt7V/O3BGAThTD5gbMMLiYnshehMxuYht7t2jE14+NpHupfeMCZN9GgpeGJzl6vfpzdItVJlpSMEG9BDjpsJRg/ZdpxQ8thsKwl1RqYIjzdKLHXIqo5BDsGPc24/THOuTbgaGF6mVy5NyFJAhzZGTtwZF+XUYm50jzZ7Bas7bufgK8GpDi92zn39VtCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wKhhnkwkM2GXAHBza4WWAtPG0tasxLWA0VDvgftdQYk=;
 b=Jj2j+WKL29+vWG4uOPyWYmb16V4WZBwmNzgrFbpoDnMQcgFLr/A8u57XL5YBZwKuXkozPaG3YC641OsHUP2xyljKlO9KwrYylSVWg6S4x9rbzOWUk2glCbackJjMRl0+XbuLFfkBnzpGCY5LwaxE7AFgi6Oztm4GF10NmhE3/1fRsq9F0F0wvzA1KikTYrqC14D9MIGhoR1Kk70t9q3u9c06huFKFVkA6+W+kF1fpjY6/QWpMoWkyfU2OVB+fVXurcKbipBEpcwQ/Lctc92/A2wSivem/AH76Jr3gEBtpB/EoppMPoz1eGU+/dtTwIUd2jySLffcIZpAEohL82J0hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wKhhnkwkM2GXAHBza4WWAtPG0tasxLWA0VDvgftdQYk=;
 b=fl12w/x3mR48vHHV4ULHlUDEQmdN/hGzJz4Rq3wWFuAnXzaP975/AA0yo0pfzycfLTB/H6zgJ1ARRn62ek/KXSbM8395IEEL+8JoWPjlfRXSuk+MpfSiR8epVS3QY913PzcP19NUgvTCHNrDxFz8i3ywZDjdeXV9C5CjHLuOTcg=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BN6PR1001MB2369.namprd10.prod.outlook.com (2603:10b6:405:30::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.13; Sun, 17 Jul
 2022 02:46:34 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68%6]) with mapi id 15.20.5438.020; Sun, 17 Jul 2022
 02:46:34 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>, Hugh Dickins <hughd@google.com>
Subject: [PATCH v11 03/69] radix tree test suite: add
 kmem_cache_set_non_kernel()
Thread-Topic: [PATCH v11 03/69] radix tree test suite: add
 kmem_cache_set_non_kernel()
Thread-Index: AQHYmYdtEhbaUTvcm0SDUzUK1Ot0Wg==
Date:   Sun, 17 Jul 2022 02:46:33 +0000
Message-ID: <20220717024615.2106835-4-Liam.Howlett@oracle.com>
References: <20220717024615.2106835-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220717024615.2106835-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 45161ea6-436f-4177-051f-08da679e8ff4
x-ms-traffictypediagnostic: BN6PR1001MB2369:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iovh++Yka2kuQ9C+U7EcYK8xzvSP8mHip3Q9omeRJxpWP1fPO+AiCEPoeOXfwl3xO3GwrTyv9mjRWiPL82COhauZg8mzGAGXhYlwXR+ISQkZNfKQekYsLAlJGKBrkkAzCrP+jTo013eki7xVS/DbCsmoUZWwbnenNHcz9VUWLGFYWJtJVgTuw7pOeUEt22b+/Zr69YYSqSS5uoySvBa6znRMiHA7Pnv4zGnqUfsky+xffUDD7TxlNG6KDJvYKjPWkCnKY4QP452N9eyaCinkYEBPdqY4SOAKfLMJMSIkyPYIzGy/bQRXP+NF4S2SpPygW58SGBFAaw9E/r9o1WCt1an8F02CpFfSqFtZpJKwV9XoUVlVq+ujf0ofgZABztWDGTlEGofG8bJOg/ChdGETrdkiaj+ixfpmzWNnkHOOtKfI0cOfyrZrnufiv2tmj0Ph4ykDCiTFgvfCzWzeBU07KMl8hFtUKcBZ4/hvgffiDu+aSov1arV3DCYjMkQK6xyf2PGV4GVXkW0YwX0wTErlQDAaSzjXeD9YQsRCVlnHsGzy+wZPeNagUGNYhc29tnkbCznEMNAuaMJ1D+S4SpyH4Srya8evzc8QYaOFb9d68ROcC0UwiiNnvfyH7LeyFtrlBPVT3x7mipeR4AB3vB0K/hIEpd5j9kgQyzvfdvKzWWXw+ePJ+IC9p+kGpcyv1TxuPBLSJHpMaNVrwZjqfGOemne7U8PaDQEg23MCsOJ82FoufT7B2aju7SDS7r3dFodYZicvm9isfagFKfoDWD06JY7MRS3jfi1nHhdgclMM4UdwcVUBln/faSN9jLVMzFKg9RltFJ4w1Cmwn/i/YHW4ORZHFKxF+3ngs05SCCMQuTEJJbUQJKP3DkyXpkiBX4rT
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(136003)(396003)(376002)(39860400002)(346002)(1076003)(6486002)(966005)(71200400001)(186003)(478600001)(38070700005)(6512007)(76116006)(6506007)(2616005)(41300700001)(26005)(122000001)(38100700002)(83380400001)(66946007)(36756003)(8936002)(2906002)(5660300002)(44832011)(110136005)(316002)(86362001)(8676002)(66476007)(66556008)(66446008)(64756008)(91956017);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?dOd5bsap83lsZCMmvwkTFBLvraS9gmdtx5W+gKd3SZwPky2f1PDgx3ZnM0?=
 =?iso-8859-1?Q?5yyZjkfQ5HXUS0QCd8ab2VwG6hlPLbVgrQunto6pe9TGFFY+l54kWH3rRT?=
 =?iso-8859-1?Q?RKHF0FXJb5FIzux7pxBxLMaNodsuiDFqosZGvifOX+UKXZe8143AVk1HL6?=
 =?iso-8859-1?Q?d2iUOVXe91msjwm1km2gijfJQd8OUPac+uq095ivsDqHfFs6d/fUPEYn10?=
 =?iso-8859-1?Q?XPZkvdRdW6i4JiiAkL6XendTYI16UhhJG+6Mg1uaufoAjbJ7e4MLxuC14M?=
 =?iso-8859-1?Q?bpN9+J0vZ3wqWB16mAHU7B1Q/bgGGCWMC/QMtDFSwWD7AtgNdaEUaGvyk6?=
 =?iso-8859-1?Q?Q50MHWynC9tDWuIuBhO5a3VKd4LVdgUoEnADGBS3rM2yt3GX1p16H07xz9?=
 =?iso-8859-1?Q?PM8pLyP7y+TRBQN4MOM2udc9OnaI5oG5bxlTlcmMt7f3hK5sBR5DsjgmqR?=
 =?iso-8859-1?Q?BKw7cFzsYvmemCzvDhRy0CzYAnAcHh2mHcsIINgEVIPhclhO9iyM4r7fc6?=
 =?iso-8859-1?Q?aCboHJnk07AN9xztG2mSvg8nAI8/tV1RICxgD5ntxAuPKBhSqWGqSsi9cf?=
 =?iso-8859-1?Q?eU8W7VxlfidRUl9Iz+hd2kHgMrSMNxnZ+FkUjhIoRfV2Bg1fxfiVXn6KBD?=
 =?iso-8859-1?Q?LBLJAmTvgyVIuLHObTEfdrRzzQYd3iijl6YBt6+Bxmx9bQL0bJQcB4rTUm?=
 =?iso-8859-1?Q?QyT399UKX+TH4jCm8eV6f44+K4riQnYF1X+ebK2gjydM93GEPQZiNtTtzT?=
 =?iso-8859-1?Q?RbhT69rhiHRpWrq8ehYOH2nHq0gbFqRz1x++E+6994E1N5X/+qTtq39wdT?=
 =?iso-8859-1?Q?yU2v04khWaAy3XaukCEAo+kVZ6YUsq4E9PqCHSU8sg+9jhZyW/6dLRoCMj?=
 =?iso-8859-1?Q?yuDdZSEo+wtLlaapbhC6XUT1zsVyQRavUXrDlpYNFZ2tmq2V7JC4NPwKRK?=
 =?iso-8859-1?Q?rn7aGdBjckMRLGG7QMJcuDwXTN/V+liKwFk5dfnb69Qq55WYIoPUw/Xd8H?=
 =?iso-8859-1?Q?Eun3MOhOriOdKLiS6i8/T7A4TqGROgbAqHKJMW5veYzcbSmt3f8liwbctU?=
 =?iso-8859-1?Q?+wV68WM+KQK7RxLHkTsApsFFa4XVeYBy2mtOBDPgY60x4PtgzXzT2PgK2F?=
 =?iso-8859-1?Q?nApVugS8P+uwyjpBoWtDqEWlLbyNMojWqoDok+wKo1wtgRIMls7NDpbjCx?=
 =?iso-8859-1?Q?9Sswit4nyAZuDNREKRyzcgbN0JhosZ6xZUQTHQzAHsmQM6EzAULR8+/mD9?=
 =?iso-8859-1?Q?BkhxdSGmhkSlETmrDqguIKVv7V5gv6BA5e97bVTnwigBakwZrx7P86NET1?=
 =?iso-8859-1?Q?nak1shgDwrbmVTlQJh7vklyMSzYc0VlIza309pbtClM+Um0y8BOVzIb5CX?=
 =?iso-8859-1?Q?HNeLA7OCKmsriD/c+BwMRGcmjZ8oEH/2mLtCTRuciI5CcEjkKQHWWC4B2W?=
 =?iso-8859-1?Q?JudRd6syAeLQaZ4A4bKnNeMU1Wzu5cwtuGAuAyazqDbz0YWd8ZUMjoJu95?=
 =?iso-8859-1?Q?3xq/ia8A6vZoJHEwdhkIPxI/SSTeupk6gZw61N2jiFHf9au8m4eGmodOKk?=
 =?iso-8859-1?Q?KnK9280OPihWfCFF3nsrakTJKgn7wNURvJoVHrGX7LuGk1QVP2N8lvTA2v?=
 =?iso-8859-1?Q?F7ufLxaEB9ky5w9Z+1r5ulprxxDkO63Mklxg6nXipQ4/8Qwq1CJYlUug?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45161ea6-436f-4177-051f-08da679e8ff4
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2022 02:46:33.9755
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sbwBdBS7Ee7nV744/r/VpJneqYagCFZeu/L1as7zECrFMVim+vzB6gKXcnMlGw6FPw2vyyYAHmwv4wJZGzZR5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1001MB2369
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-17_01,2022-07-15_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 phishscore=0
 suspectscore=0 mlxlogscore=979 adultscore=0 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207170010
X-Proofpoint-ORIG-GUID: -_bqcTHFJmFhNmxE1l8c3y2BuZyou8GQ
X-Proofpoint-GUID: -_bqcTHFJmFhNmxE1l8c3y2BuZyou8GQ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

kmem_cache_set_non_kernel() is a mechanism to allow a certain number of
kmem_cache_alloc requests to succeed even when GFP_KERNEL is not set in
the flags.  This functionality allows for testing different paths though
the code.

Link: https://lkml.kernel.org/r/20220504010716.661115-5-Liam.Howlett@oracle=
.com
Link: https://lkml.kernel.org/r/20220621204632.3370049-4-Liam.Howlett@oracl=
e.com
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: David Howells <dhowells@redhat.com>
Cc: SeongJae Park <sj@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Will Deacon <will@kernel.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 tools/testing/radix-tree/linux.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/tools/testing/radix-tree/linux.c b/tools/testing/radix-tree/li=
nux.c
index d5c1bcba86fe..277aa8b70abc 100644
--- a/tools/testing/radix-tree/linux.c
+++ b/tools/testing/radix-tree/linux.c
@@ -23,15 +23,26 @@ struct kmem_cache {
 	int nr_objs;
 	void *objs;
 	void (*ctor)(void *);
+	unsigned int non_kernel;
 };
=20
+void kmem_cache_set_non_kernel(struct kmem_cache *cachep, unsigned int val=
)
+{
+	cachep->non_kernel =3D val;
+}
+
 void *kmem_cache_alloc_lru(struct kmem_cache *cachep, struct list_lru *lru=
,
 		int gfp)
+
 {
 	void *p;
=20
-	if (!(gfp & __GFP_DIRECT_RECLAIM))
-		return NULL;
+	if (!(gfp & __GFP_DIRECT_RECLAIM)) {
+		if (!cachep->non_kernel)
+			return NULL;
+
+		cachep->non_kernel--;
+	}
=20
 	pthread_mutex_lock(&cachep->lock);
 	if (cachep->nr_objs) {
@@ -90,5 +101,6 @@ kmem_cache_create(const char *name, unsigned int size, u=
nsigned int align,
 	ret->nr_objs =3D 0;
 	ret->objs =3D NULL;
 	ret->ctor =3D ctor;
+	ret->non_kernel =3D 0;
 	return ret;
 }
--=20
2.35.1
