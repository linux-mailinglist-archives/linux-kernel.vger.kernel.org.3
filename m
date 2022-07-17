Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C88E1577363
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 04:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233650AbiGQCwo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 22:52:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233574AbiGQCwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 22:52:24 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF5D525C71
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 19:48:29 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26GJ8mWW009468;
        Sun, 17 Jul 2022 02:48:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=bge0UkiY5ulmvJBFY9pWuznM/Ac/DHX80l5tJfV8ZYY=;
 b=2NTskV/twSmr5uGsWzRQXXOpodx39Kx56poqBCagkw1fKoPW9CJbZFEcbInh1ocRenU6
 htt4Ydc8CYb3oaBxfrm/7rD3ee5nqOiHOwuMRBSU6icGx4PBu8MYAFG0+PQ/9I+vCp4x
 bLWhZWq9w+04msoim4KKORYEi6mjGCToqdeptoh+YvDqE+i9UPmYSEKvssEt46BkF/jd
 UBLi4cBjcmbCaDi7JTA633EyMn2lvF3qCR28i4LJ95tKKIwFVMCzBU1JiY03xA7rRxpO
 noAqtsr6LJt1T5iqJ2+7fQoPNcCLoeSpMiZaQJLCuVbmLR6Ygv3AjBx0DBFprh+kMz0R CA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbkx0s0uy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 17 Jul 2022 02:48:18 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26GMY3Kb005908;
        Sun, 17 Jul 2022 02:48:16 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2169.outbound.protection.outlook.com [104.47.73.169])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1m9d8cg-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 17 Jul 2022 02:48:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ezCHj2iQDGrt3h4s8w18LzXxGj3XgbdY643eivAD2Ht9LOsDZSLqbEe7MM/gvfZbx+spzylcEMwq32ofbkfR7aycr2mpBZGeCLGkHQOHrWWJNJ2djbau4PVmQ2hZ4xCyLmsR0iODjP3MaCenBwD0RiHDW18DErbX/ZAw/A32rwSvYuOhf8bwDsg7hQT2ZTIExWsqSkOBl4iMOgoi6+g0fykT9X4D03aIcZ+K0+Gacs5aYeawNtNnZzpQJ5q525o0D4i6Qn4HsLB+8hSKWvqyaj4FEE1ZX1At2j7SiPIFBN8KiJLPcedzafICmp1NNV+9jNOfHnAc+8wn++9KD98GVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bge0UkiY5ulmvJBFY9pWuznM/Ac/DHX80l5tJfV8ZYY=;
 b=T1YZLJYw+c0MXlVfWFPyRiZpB0GBDkbwNQpFsFZEdqphHX1zEyAa2X6kSmO7Ct4yLQkaEaWrxTf+WTMEs49wXNMAy9lDIQJp1vA4pscgfgAqFmXV8c0sWzasBRSECachujuRSu+G4e1m4JgwlfMLMcaiAfRpBaC1XsaxZDN6xXPSz+nTMxElhPZvRygMwt3kt+DG7AoZ0l2yCgGmXN6J5TdDHKhjUNeLg0zIvYhY7dXYKV7Kpg8HC222QUctI0bjwOQuhPYE8Ku1ZwdVwyL+fvLLcPOoaPlozkUFk/rldBuauFuX5iEbRxY96rRFFy6CsBZegMItvekhJksSmE5qHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bge0UkiY5ulmvJBFY9pWuznM/Ac/DHX80l5tJfV8ZYY=;
 b=X6dOyS5+YZ43dNJB4pHF4knXBxIraGDz5lsdjUPoNw6esn8eDdU4FMbmtklsuk8P8baJk1N9TXrX557+skrNGDD92BAlllCoP0cIsAieB6BhACzXkjtimxNQ+NhxHcsOutF3kZquWlZ2Bu28yLtV1GhPhKw1A07g7O7jzbVE+9Q=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH0PR10MB4504.namprd10.prod.outlook.com (2603:10b6:510:42::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14; Sun, 17 Jul
 2022 02:48:06 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68%6]) with mapi id 15.20.5438.020; Sun, 17 Jul 2022
 02:48:06 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>, Hugh Dickins <hughd@google.com>
Subject: [PATCH v11 68/69] mm/mmap: drop range_has_overlap() function
Thread-Topic: [PATCH v11 68/69] mm/mmap: drop range_has_overlap() function
Thread-Index: AQHYmYd8ld+czVMa2UKo6R2mOVmwMg==
Date:   Sun, 17 Jul 2022 02:46:59 +0000
Message-ID: <20220717024615.2106835-69-Liam.Howlett@oracle.com>
References: <20220717024615.2106835-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220717024615.2106835-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0cefb445-683b-4a37-9a17-08da679ec71c
x-ms-traffictypediagnostic: PH0PR10MB4504:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AZkjmAHZO5Lo/VetUM3EC+zSS4Yf0gaQUTgQxaJysDaBpwMn74LOuoOSybWtROTQVbGRmGF7wwiVjNRhgGh2Q1BEwnTYGgHYO/r6lQfJmlHsog0JfQLFEs8yUstIwwl2DNEOIVF+/wMRxlH9K5XXcvhNkU1OZ+TvM41DgxbuMMBXSXM+iD5Nj36/m9yYDyZ8YZkVsLv+N+g3wpglHVf7dkAcMmtjQBohnCQEihcJ/Cur+IVnPxNU0LAeHr561aqngbfRz3QygX/eOQIqCPeGiQVCSi0vAzonSXdq5eEYJCQNgTgPu59xRbvuKIUcDwsvPolYJ0D+e92XRH3OwTBz7lQyvbXUGmB+VVDtewM5CxpCf/0G6ZDnG0gTHbIoSsyr+I3gOcSY84Om/Y6Zc2gwZTCbS2E5GLwotzV3TYq2aIjgfQCSy/lfkwD51q/dFdKeJ+hvuHeNRE1EWxQJgVnpDRKcdnHf+mTJQID2u0JfzNtiXAX8G/9krGL56e+GHhcSMH4amWnouYVrKwQgQmTTXDAQtrgc/kiSvan4eouzHEDPsryR/MoDAb3tVfWNBfLvUjykz0mTwDkwvZl0Ib9lhw38iuCEzkzAyCzc482HrGfV99tQZ0Qpq/ctmA0EAxjCW0uJ5jak7qDYRFvFVJmUG3o3oBW6+8z5mDKz+OBpKTjMgRySLFrud5hA0uK1bWooOlAWH1LlaMdT0j1UwpTh0dJ2qveRnj4to74v7O23wjTU8vgPD8sPtpIEmi/1MP2pmOlN9JZomLXoxOdSt8PthYYExaxZqlLD4Y8jEqYyKI6PfNogmW3xvt/uYrJRFMfRS13O9P08y8JteMsIoaA39JwN00srdKIh4ItohRFGmecNLytl0z7hEs6/KyCKPr+p
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(39860400002)(366004)(346002)(396003)(136003)(966005)(6486002)(83380400001)(1076003)(41300700001)(2906002)(38070700005)(44832011)(8936002)(6666004)(478600001)(5660300002)(110136005)(86362001)(2616005)(122000001)(6506007)(36756003)(26005)(6512007)(38100700002)(186003)(8676002)(316002)(64756008)(71200400001)(66446008)(91956017)(76116006)(66476007)(66946007)(66556008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?pR6U6EcOAIVNwI+66Vyo9mKgNjpOPXT+0xu4ImSqdH26M4qJ2OAZQ9LCOO?=
 =?iso-8859-1?Q?jF3Pp3ON/5hdlXUNLCjPR/Vi963B8j7+1mHVhGvx1BxEG7gpOvXWO09L+P?=
 =?iso-8859-1?Q?UlYy/rvas0wbKoh5SdLDBb2LLaPdzHbylrPV9LQ0mbUcuNgGYwQXpuvyDV?=
 =?iso-8859-1?Q?BbWwwBl0ue4OPjLDMT7NxT4C92tjtCC6aWAe0dcdO0D7KaycRmykRO/wQX?=
 =?iso-8859-1?Q?Ranb5V8fQACyH1J3nPyjMRZleA615lcagrKdTPp8eScHSltAPyhlrXRo7o?=
 =?iso-8859-1?Q?+FHL2TIZUNEoBijvUqJjKSDIC6jDi3yMuYLXm4lwQy2WuGxNWMVbuJpOYQ?=
 =?iso-8859-1?Q?3waOCfVxj2S1URzKxLhyh+7M8htVE0KdPJBnJzgH0nMSQdSa1NMHb18MYR?=
 =?iso-8859-1?Q?ID004jz+l4KPZEpFuAOTYSz/QzE8fOQwXmp6/h2QoTX291zw6Fx2/2hGk/?=
 =?iso-8859-1?Q?cQfa0auEPK71pjbEYg5mxeeRaPpqv1ZQci61/GKX89qCg+64TbzYEgXmLJ?=
 =?iso-8859-1?Q?AAqJwuPPjTlvcsj/1dPAB9NU1wJ0jZfyPqsDk9kYObNzhJYMR3Gs0v5Bab?=
 =?iso-8859-1?Q?+HSMeKRlrtYgtwR6fU/E9aitFt8l6HTnPdp24v6YuD9wyf6QRZ484jT1qX?=
 =?iso-8859-1?Q?sUzN4Shfp+abFb9DqBTQHOeqcm4j4/vUYwZWb+ik2x8JCxqMP4vZClQB6p?=
 =?iso-8859-1?Q?8Rtl9oEfBOcNud3ldTjGdycRpH4Uca4UjUEVWz0ht0xnaCUGcFi5Bi01Bb?=
 =?iso-8859-1?Q?m2LhveFajMyNVjOEd9Q8C0H+qVdpiOKj1HpIs+St9EmaLq8C7G5PdHa3vX?=
 =?iso-8859-1?Q?jcmdiEJ7jr7HsGVRggChJMZCePBygUEMge8MRLlNG79bpljxy0G9h4UtT2?=
 =?iso-8859-1?Q?8IYYbj13A1BdiwS+hkD2DTh/40eAephV7BrFBFfXyZW6LicdaYvQv0oMJK?=
 =?iso-8859-1?Q?wUYe31BNcSaSuR3ZO0rSQKR/FB4e+gko+ZWxBeztsFXd+T1+bZwMRprkKr?=
 =?iso-8859-1?Q?YAEP5vxwb1oSnPxNY4pvYz0Xmjs+73ItISqgycbmMXhTiXQoVmucpqwx6A?=
 =?iso-8859-1?Q?2OVOnXJY4Y+8JpGI5s6KmTJjnJMF156WW1pPL/+a3Px6mNKBS1sozTZdPH?=
 =?iso-8859-1?Q?BjBlpZj9n+qCEcSgp0ViOxD64DKLpmzkr4rYgj84l5bzQ3SAmyqoy3gO6x?=
 =?iso-8859-1?Q?oIEwlC2lf7eGqPyhe100sAv7cyeHvd6zLyWSezgmmGYR2gmsB9LIMfSDt/?=
 =?iso-8859-1?Q?GZ9fWUEgDWbBMjHS+0H18APwGyUDiRRVp7wVQ3MHEN0cyrloQ0MUweKSV9?=
 =?iso-8859-1?Q?vgWRS07ek2SWxVR7Ah3VpbzdwxGzhaMRYuX9fvI8v1zzNLgtpElQ4ncGee?=
 =?iso-8859-1?Q?PTv66gy4PBa29iE+oQJckWDtat/LEUpbszGV/R+fHgZvwkIkYv/Gg1PXfO?=
 =?iso-8859-1?Q?ykV38n3DNbKjF3aINmkhHDVJ9DpN7/FaWVp2LjK5unKWM8BWQTghErP9cO?=
 =?iso-8859-1?Q?Kv41iNs8NxhFz/WAg9rwcClFLt3JrPpYjihcuTyRjLgHwB2qpIfUQki85d?=
 =?iso-8859-1?Q?UIVbAFl+q4MoS1Fm6FbH1TKseR5Prwhjn6jC6FY3Gllu7PPpqwxGdj5skP?=
 =?iso-8859-1?Q?X+TphTMcWixfhR0vfjlSTHC9t0q4yEEc1+TInO8ZmSrCve8AsUbeXPsA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cefb445-683b-4a37-9a17-08da679ec71c
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2022 02:46:59.2551
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KMTX5SM5NeKMsfg/GoV2DPzRaLZ9L0eYgfZtrSJsV7tawoPAGNYGftEfUovPdPPeAwkDsa9vG8DylSBfppDgug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4504
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-17_01,2022-07-15_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207170011
X-Proofpoint-GUID: EkCJeMo4f95M8N0ziDU3IryKzQHOXlG8
X-Proofpoint-ORIG-GUID: EkCJeMo4f95M8N0ziDU3IryKzQHOXlG8
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

Since there is no longer a linked list, the range_has_overlap() function
is identical to the find_vma_intersection() function.

Link: https://lkml.kernel.org/r/20220504011345.662299-53-Liam.Howlett@oracl=
e.com
Link: https://lkml.kernel.org/r/20220621204632.3370049-69-Liam.Howlett@orac=
le.com
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: David Howells <dhowells@redhat.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: SeongJae Park <sj@kernel.org>
Cc: Will Deacon <will@kernel.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 mm/mmap.c | 28 +---------------------------
 1 file changed, 1 insertion(+), 27 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index b494c7e3dcb0..1c35cd0ec4c7 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -437,30 +437,6 @@ anon_vma_interval_tree_post_update_vma(struct vm_area_=
struct *vma)
 		anon_vma_interval_tree_insert(avc, &avc->anon_vma->rb_root);
 }
=20
-/*
- * range_has_overlap() - Check the @start - @end range for overlapping VMA=
s and
- * sets up a pointer to the previous VMA
- * @mm: the mm struct
- * @start: the start address of the range
- * @end: the end address of the range
- * @pprev: the pointer to the pointer of the previous VMA
- *
- * Returns: True if there is an overlapping VMA, false otherwise
- */
-static inline
-bool range_has_overlap(struct mm_struct *mm, unsigned long start,
-		       unsigned long end, struct vm_area_struct **pprev)
-{
-	struct vm_area_struct *existing;
-
-	MA_STATE(mas, &mm->mm_mt, start, start);
-	rcu_read_lock();
-	existing =3D mas_find(&mas, end - 1);
-	*pprev =3D mas_prev(&mas, 0);
-	rcu_read_unlock();
-	return existing ? true : false;
-}
-
 static unsigned long count_vma_pages_range(struct mm_struct *mm,
 		unsigned long addr, unsigned long end)
 {
@@ -3282,9 +3258,7 @@ void exit_mmap(struct mm_struct *mm)
  */
 int insert_vm_struct(struct mm_struct *mm, struct vm_area_struct *vma)
 {
-	struct vm_area_struct *prev;
-
-	if (range_has_overlap(mm, vma->vm_start, vma->vm_end, &prev))
+	if (find_vma_intersection(mm, vma->vm_start, vma->vm_end))
 		return -ENOMEM;
=20
 	if ((vma->vm_flags & VM_ACCOUNT) &&
--=20
2.35.1
