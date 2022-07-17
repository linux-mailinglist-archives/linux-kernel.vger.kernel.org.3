Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 845DF577355
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 04:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233106AbiGQCrx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 22:47:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232878AbiGQCrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 22:47:04 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B56E61A3B3
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 19:47:00 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26GJ8e8u009340;
        Sun, 17 Jul 2022 02:46:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=8Z8CZk/rdDvSbZMmU5C8Kl1Fe1rywftG93NbzvVnga8=;
 b=i7309TwvLcdpBAPrr83bpoBq0Bz5Fgp4y4vM/wlfEIWG4EWFqHFuUcqegaALHnkGc1EG
 ii23ChLVUv0ZqhK4z6wXOE+roRa0fdgjenU+eu/WdizS3jHYdlNNf7R7S2A1zFVLyXE+
 fpmAUL51F9AQ21Unpnaey5sDV+zWjCUTHoEHt5Xd1uyKy3dfiYAeSt1FgXqsdL5oQO+p
 lXeUwjPBkcahL8a83zwnE/Be2wC81ZcZrhkcfVSm68v8hYFMj9/+Vi5T8LCnzn7eK6xv
 pROaata7AL+s1J4P+4k0EVxOKyHH2WGz62Mv7D1lwl7FswyFlqUP9zOs+1chMYAaV4Ml Rw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbkx0s0u5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 17 Jul 2022 02:46:51 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26GMXfia012225;
        Sun, 17 Jul 2022 02:46:50 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2107.outbound.protection.outlook.com [104.47.58.107])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1hq5hum-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 17 Jul 2022 02:46:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h5WQXHY9JrDsPakQ2OBtUqHM+CCJhfJWB6uVeuf46knAd1NpO19navHydL1zx6Bcqg2M7KDyMUhX2BiIbaceB9tRjzOyH37eI95KB8E68PVmDrH6MzoMuWmeukJ9AXTX0FzurEN7ib+clgV9uI4ChFWo8S66hjKdexr7/jNcESo5o0FYlwGq2/rQvgglKUqF0VYneMmEmLQm/i4FLLSlSFIoZKrVKWcziFr/3i6YfAt668uMM556DU+Xz1gvCVfNJySWZ0B5fYxnxzcM91JGhX0nZTNyZZ6sQFFq0CeZzOPgpIJZuHnkc3DB1JHP85GtPpqjR5fVJ6PVFvBAgvmxig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Z8CZk/rdDvSbZMmU5C8Kl1Fe1rywftG93NbzvVnga8=;
 b=hgVprnK1/7SmI8rGClHWL6YW1TNoRJGGkSKG2TyWGeT45zcrGDNp9eKtO6B2NoX2H7MS2LDbEYPGIzc3jDGFh6agyIe/AF+c1deuDoG9ZzANPzNGhpmAkjiZbAvq4uzFZYh50KwH8dJ156MyY5zi29/vfVbxrQz8z9mHMh+Zp2JXiGYn00B7fSJJwIodgQ8vWLC8AJbTLv3frWkcNn1agRaq0oSoI342S6/Qy8m2236quVkDsilhw+m27GG55HkVvb8wIR5bV37pYUzzg/bnqiTLz720SBk7f/Gux2dsQfHdTgv5Hd0VP/pRZrcaZkm1sKu9zV07DHBJ4WN7knW/Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Z8CZk/rdDvSbZMmU5C8Kl1Fe1rywftG93NbzvVnga8=;
 b=vg1KyztLNbBw8vm4T1ot8cvXUA0YxughaQhEav+KMy4WhKGgy82dHmwl0SALZJh/482i1LNGhjUaDE7K3CO6/xzYQZG4raVv/uoA7hNjzzis0WJW8eSksEKxmKICYZyUnRVhrwlVQPmvd1vOnBS+hivq7WCHmlBihVWqC4TqY6s=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM6PR10MB2908.namprd10.prod.outlook.com (2603:10b6:5:6e::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.17; Sun, 17 Jul
 2022 02:46:47 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68%6]) with mapi id 15.20.5438.020; Sun, 17 Jul 2022
 02:46:47 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>, Hugh Dickins <hughd@google.com>
Subject: [PATCH v11 22/69] mm/mmap: change do_brk_flags() to expand existing
 VMA and add do_brk_munmap()
Thread-Topic: [PATCH v11 22/69] mm/mmap: change do_brk_flags() to expand
 existing VMA and add do_brk_munmap()
Thread-Index: AQHYmYdzoB4+dxxY5EaehmpjI854Vw==
Date:   Sun, 17 Jul 2022 02:46:43 +0000
Message-ID: <20220717024615.2106835-23-Liam.Howlett@oracle.com>
References: <20220717024615.2106835-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220717024615.2106835-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0357cd23-137e-468d-bed0-08da679e97ec
x-ms-traffictypediagnostic: DM6PR10MB2908:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: U6X6rpx/YzQROXfWQ7iuRnI0pB3RnC/3HPoltuxk+giW0OmHPJovwUDGMZZEYzJOsbDZrsWNxbmvmgj7wOv1xtclCe/HlF5mMQ4ZsolbwrplDxngFkbGKZq+3R5WJ3Bs/hHwqv+4GXJUDQWVeg2YLZESLiyqqcsRHy2NoNyzrDgz4G9xl2Y/mfVgMze8hVv0rK3XcEOtySIcYyquk11V+ttkywyttNxd9vNz5DQ5lZY00MFyri2j5nXlzJxTBURMsJ1udeRUmSd15882+I9HfaWI3wtA0ljky3ggzlJkxvZhXUq85vUTIwoNNA/Hheon79h623Yw1UJKdSSr/ZJ+PZ8WLZmyMRAGSNiJCaQVyr/kwbAkvbER83ZZv8/p09/KfaGJw8LKDu0SP5GjcjdlXwWUW1m6anaHVYMabqVPJ1rNjR8xwpQDWfh7SSs5IPSUt0hpsd0Dw4G1MGkk8uzUZLvUy99KC0NlRSIGEdOVwDGVVFcpVLmJFlwYqGDlv2cMfRo1m5mXBnoyoJGGpuB+VNrlDq8HM3HDiep15IRSXexRiNw8BstYlWwhOhKJiaItGsSGN2fSaIkXM2/dFhWXr8Y6CjBeWHvlCeIVVlyAs5bErMUgsujKBC3yu7XQoGkFzBf6Hy+oTw0SlIUP+BqA61L5AZTgTLXAxO+XE/GSaJa2bAzAHXQqTuz062u1ItL4zIRgWneimja9Y+rQzgh94+UczsdilFEWEaOrDtyTIQLAdNu5g+P3cu/GomUxg2Nlr0GQd9X0vptT2OzWSaBxYL9+zEqXLCV9mDx/DpVNVgSuKjY8TkV0PndVoXzOgQH99twx9dsMw4SO0s0H1/flKVuRYH5qNl2JU00bY3usjzHZJPrbBdhrwxpK/H8aDC3iIkV8tRtMBEdaFvZ6l3Lt5g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(39860400002)(376002)(396003)(136003)(366004)(5660300002)(122000001)(86362001)(38100700002)(38070700005)(6512007)(83380400001)(186003)(36756003)(1076003)(2616005)(6506007)(71200400001)(8676002)(110136005)(316002)(41300700001)(966005)(478600001)(26005)(6666004)(91956017)(6486002)(66446008)(64756008)(66556008)(30864003)(76116006)(66946007)(2906002)(44832011)(8936002)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?4PytIkKQyDH8YD3MvbH1H4xMimKyRwaJ0Weu+cB77707VQPLfEmbUgKP6s?=
 =?iso-8859-1?Q?fcCyYd4kewQZC9M4buu5+QyrEWWTonUcPeMJGnxfIkBH3DaYcuHnKAXbuo?=
 =?iso-8859-1?Q?zSSUig16j3PoW5mvJdsmLFQAO9fMbxqZdSsKN8PboDhTeLq5mJWsRTM2hh?=
 =?iso-8859-1?Q?yczVbMnjYyWsi2FXt4FdNue50nkSPeKUMsg35RDAPtZ/umlglRCWRlOKoh?=
 =?iso-8859-1?Q?k8kpD/ULNjSYjAp42APHqWFRJmKlsmAxmQYCyQRO6u9rM3DX3WGh1SXH5c?=
 =?iso-8859-1?Q?PG40kCicyvsnL1mNS6TsZF09vn4nX7F6vYwsTrns0Yh2gXZAeC4BOZ3oXk?=
 =?iso-8859-1?Q?WI40fQR+8u0rFc+REVBgYc7JtTbSEow8RNae4+ZdZk50Wf+o9yzKqfjz4K?=
 =?iso-8859-1?Q?RgZHLWU9O4GG7eN5brK1GDMREPVwMnQuEtN6bLSGEXGE0uAAAEfjepb2/v?=
 =?iso-8859-1?Q?E7kzm25KtToZQDMH+AMOXP6GBKRjQPBDa7SVOCSldQwpVlP+o5A5bv2py7?=
 =?iso-8859-1?Q?PKrA19GLbgCIN7e9G4vGTC0xnN//XAS4l7KNAi5b8o8N1pLgunhOW5OhKg?=
 =?iso-8859-1?Q?LnzBE/CrnYFx0GeG4bNbcBaM8q2Cu2IwLZn6CKEfMJDpHeMDyljCxwga6U?=
 =?iso-8859-1?Q?CAG8ifWOpu4bzOfau6W4TXAi3cQ3Ny5o4vU89JvOGFngcguyRtDlPVxNBo?=
 =?iso-8859-1?Q?qfBGEne/rGCWgGPTvc5WS0+XRu2uWRk9ktKnqX3Ku9ThPtobxztHimUFcD?=
 =?iso-8859-1?Q?crZ9eBglbvOTllfu5ThgJ6LtnccGE5ggol8w6F5KnWQFNPCErgLp9Av/AE?=
 =?iso-8859-1?Q?0XjtaPb6bam9z/eZgpNIUy0yJttsbNBocpb2+b1bTaunWdt14Mzpy2ju8a?=
 =?iso-8859-1?Q?Myxjjvn0uXsw3n4R28rVYjWDWr3hUr2E9Yfwt6P4rw+AOXgreHzvotru29?=
 =?iso-8859-1?Q?DlzC7YP7bEQSJ9/czUsrFku+AOulj0c8u2DfixarroF9RWcV07VOBiMgcR?=
 =?iso-8859-1?Q?qi5QDN/yu5e2LPnVqyeFYInN3USRrtaTaAqTAlDacO8LyfZnKUH/jeVZ2/?=
 =?iso-8859-1?Q?ouCAZtVv9Hy1hk2iOWLtJ9xkVkJUjXiDoE5+Pfi5snWMbQ/oCqGXFtYh3H?=
 =?iso-8859-1?Q?TJxGYyCRdJTJHkaH83FJxD97+HVGqbN+w+Ak9a1x7duTSDIk8qdaOmLmWr?=
 =?iso-8859-1?Q?6/zY3eltZUMTsS/WXa4xYziDYyW6edroOGsGStgpSr3gXw32MzKRj/miVC?=
 =?iso-8859-1?Q?zhr0egGfa+IJ9NAHvMr4NOwjV3jEI81J0BuHtPgtWBW3h/ckhYSjZ/lsLz?=
 =?iso-8859-1?Q?mzuL3mtozo+rHP1xEhPVt3UdJeApzyJYyVvJ67tUmo91mLJif5/Ws756gN?=
 =?iso-8859-1?Q?SsBPvAUsWQfN65aSjnU6R6iFUEvu0UkQr3enSZBxLL7z694pE30daE42A6?=
 =?iso-8859-1?Q?o1AszCc2kkls304Vh02wMpUR7ITsVHKHNoX8JCbagtEKR/Gxr8P72200Au?=
 =?iso-8859-1?Q?BHUBkOiyVR5vCJDXSehasXilJQbVKFxZqrXC9RbPwbvX7X6IWzGYLFto9q?=
 =?iso-8859-1?Q?RQOtf7mc6GVfdnAZ4lCanvtVZXcHGgaNnlJe41FvfAsjrx7FamFOpMbQew?=
 =?iso-8859-1?Q?139v6529mNrKfGWysbWKbOU06Y4GO0rw2LlEbYpxLZVhWWvOpXA/dA5w?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0357cd23-137e-468d-bed0-08da679e97ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2022 02:46:43.9436
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TKgI7O71Op0iHzGYAY3zvBydtrd6YbJSFRacsnWV9MTfF22z2MphZp+RcCBnHZoAutiFjWMmF6GNYTDlNH9Lfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB2908
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-17_01,2022-07-15_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 phishscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207170010
X-Proofpoint-GUID: LTvdJ83hmjTNrLNugOTBJTFKyuKGx5hp
X-Proofpoint-ORIG-GUID: LTvdJ83hmjTNrLNugOTBJTFKyuKGx5hp
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

Avoid allocating a new VMA when it a vma modification can occur.  When a
brk() can expand or contract a VMA, then the single store operation will
only modify one index of the maple tree instead of causing a node to split
or coalesce.  This avoids unnecessary allocations/frees of maple tree
nodes and VMAs.

Move some limit & flag verifications out of the do_brk_flags() function to
use only relevant checks in the code path of bkr() and vm_brk_flags().

Set the vma to check if it can expand in vm_brk_flags() if extra criteria
are met.

Drop userfaultfd from do_brk_flags() path and only use it in
vm_brk_flags() path since that is the only place a munmap will happen.

Link: https://lkml.kernel.org/r/20220504011345.662299-7-Liam.Howlett@oracle=
.com
Link: https://lkml.kernel.org/r/20220621204632.3370049-23-Liam.Howlett@orac=
le.com
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: David Howells <dhowells@redhat.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: SeongJae Park <sj@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Will Deacon <will@kernel.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 mm/mmap.c | 292 +++++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 234 insertions(+), 58 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 973512b14d55..7570e008ef52 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -194,17 +194,40 @@ static struct vm_area_struct *remove_vma(struct vm_ar=
ea_struct *vma)
 	return next;
 }
=20
-static int do_brk_flags(unsigned long addr, unsigned long request, unsigne=
d long flags,
-		struct list_head *uf);
+/*
+ * check_brk_limits() - Use platform specific check of range & verify mloc=
k
+ * limits.
+ * @addr: The address to check
+ * @len: The size of increase.
+ *
+ * Return: 0 on success.
+ */
+static int check_brk_limits(unsigned long addr, unsigned long len)
+{
+	unsigned long mapped_addr;
+
+	mapped_addr =3D get_unmapped_area(NULL, addr, len, 0, MAP_FIXED);
+	if (IS_ERR_VALUE(mapped_addr))
+		return mapped_addr;
+
+	return mlock_future_check(current->mm, current->mm->def_flags, len);
+}
+static int do_brk_munmap(struct ma_state *mas, struct vm_area_struct *vma,
+			 unsigned long newbrk, unsigned long oldbrk,
+			 struct list_head *uf);
+static int do_brk_flags(struct ma_state *mas, struct vm_area_struct *brkvm=
a,
+			unsigned long addr, unsigned long request,
+			unsigned long flags);
 SYSCALL_DEFINE1(brk, unsigned long, brk)
 {
 	unsigned long newbrk, oldbrk, origbrk;
 	struct mm_struct *mm =3D current->mm;
-	struct vm_area_struct *next;
+	struct vm_area_struct *brkvma, *next =3D NULL;
 	unsigned long min_brk;
 	bool populate;
 	bool downgraded =3D false;
 	LIST_HEAD(uf);
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
=20
 	if (mmap_write_lock_killable(mm))
 		return -EINTR;
@@ -246,35 +269,52 @@ SYSCALL_DEFINE1(brk, unsigned long, brk)
=20
 	/*
 	 * Always allow shrinking brk.
-	 * __do_munmap() may downgrade mmap_lock to read.
+	 * do_brk_munmap() may downgrade mmap_lock to read.
 	 */
 	if (brk <=3D mm->brk) {
 		int ret;
=20
+		/* Search one past newbrk */
+		mas_set(&mas, newbrk);
+		brkvma =3D mas_find(&mas, oldbrk);
+		BUG_ON(brkvma =3D=3D NULL);
+		if (brkvma->vm_start >=3D oldbrk)
+			goto out; /* mapping intersects with an existing non-brk vma. */
 		/*
-		 * mm->brk must to be protected by write mmap_lock so update it
-		 * before downgrading mmap_lock. When __do_munmap() fails,
-		 * mm->brk will be restored from origbrk.
+		 * mm->brk must be protected by write mmap_lock.
+		 * do_brk_munmap() may downgrade the lock,  so update it
+		 * before calling do_brk_munmap().
 		 */
 		mm->brk =3D brk;
-		ret =3D __do_munmap(mm, newbrk, oldbrk-newbrk, &uf, true);
-		if (ret < 0) {
-			mm->brk =3D origbrk;
-			goto out;
-		} else if (ret =3D=3D 1) {
+		mas.last =3D oldbrk - 1;
+		ret =3D do_brk_munmap(&mas, brkvma, newbrk, oldbrk, &uf);
+		if (ret =3D=3D 1)  {
 			downgraded =3D true;
-		}
-		goto success;
+			goto success;
+		} else if (!ret)
+			goto success;
+
+		mm->brk =3D origbrk;
+		goto out;
 	}
=20
-	/* Check against existing mmap mappings. */
-	next =3D find_vma(mm, oldbrk);
+	if (check_brk_limits(oldbrk, newbrk - oldbrk))
+		goto out;
+
+	/*
+	 * Only check if the next VMA is within the stack_guard_gap of the
+	 * expansion area
+	 */
+	mas_set(&mas, oldbrk);
+	next =3D mas_find(&mas, newbrk - 1 + PAGE_SIZE + stack_guard_gap);
 	if (next && newbrk + PAGE_SIZE > vm_start_gap(next))
 		goto out;
=20
+	brkvma =3D mas_prev(&mas, mm->start_brk);
 	/* Ok, looks good - let it rip. */
-	if (do_brk_flags(oldbrk, newbrk-oldbrk, 0, &uf) < 0)
+	if (do_brk_flags(&mas, brkvma, oldbrk, newbrk - oldbrk, 0) < 0)
 		goto out;
+
 	mm->brk =3D brk;
=20
 success:
@@ -2809,38 +2849,112 @@ SYSCALL_DEFINE5(remap_file_pages, unsigned long, s=
tart, unsigned long, size,
 }
=20
 /*
- *  this is really a simplified "do_mmap".  it only handles
- *  anonymous maps.  eventually we may be able to do some
- *  brk-specific accounting here.
+ * brk_munmap() - Unmap a parital vma.
+ * @mas: The maple tree state.
+ * @vma: The vma to be modified
+ * @newbrk: the start of the address to unmap
+ * @oldbrk: The end of the address to unmap
+ * @uf: The userfaultfd list_head
+ *
+ * Returns: 1 on success.
+ * unmaps a partial VMA mapping.  Does not handle alignment, downgrades lo=
ck if
+ * possible.
  */
-static int do_brk_flags(unsigned long addr, unsigned long len,
-			unsigned long flags, struct list_head *uf)
+static int do_brk_munmap(struct ma_state *mas, struct vm_area_struct *vma,
+			 unsigned long newbrk, unsigned long oldbrk,
+			 struct list_head *uf)
 {
-	struct mm_struct *mm =3D current->mm;
-	struct vm_area_struct *vma, *prev;
-	pgoff_t pgoff =3D addr >> PAGE_SHIFT;
-	int error;
-	unsigned long mapped_addr;
-	validate_mm_mt(mm);
+	struct mm_struct *mm =3D vma->vm_mm;
+	struct vm_area_struct unmap;
+	unsigned long unmap_pages;
+	int ret =3D 1;
+
+	arch_unmap(mm, newbrk, oldbrk);
+
+	if (likely((vma->vm_end < oldbrk) ||
+		   ((vma->vm_start =3D=3D newbrk) && (vma->vm_end =3D=3D oldbrk)))) {
+		/* remove entire mapping(s) */
+		mas_set(mas, newbrk);
+		if (vma->vm_start !=3D newbrk)
+			mas_reset(mas); /* cause a re-walk for the first overlap. */
+		ret =3D __do_munmap(mm, newbrk, oldbrk - newbrk, uf, true);
+		goto munmap_full_vma;
+	}
+
+	vma_init(&unmap, mm);
+	unmap.vm_start =3D newbrk;
+	unmap.vm_end =3D oldbrk;
+	ret =3D userfaultfd_unmap_prep(&unmap, newbrk, oldbrk, uf);
+	if (ret)
+		return ret;
+	ret =3D 1;
=20
-	/* Until we need other flags, refuse anything except VM_EXEC. */
-	if ((flags & (~VM_EXEC)) !=3D 0)
-		return -EINVAL;
-	flags |=3D VM_DATA_DEFAULT_FLAGS | VM_ACCOUNT | mm->def_flags;
+	/* Change the oldbrk of vma to the newbrk of the munmap area */
+	vma_adjust_trans_huge(vma, vma->vm_start, newbrk, 0);
+	if (mas_preallocate(mas, vma, GFP_KERNEL))
+		return -ENOMEM;
=20
-	mapped_addr =3D get_unmapped_area(NULL, addr, len, 0, MAP_FIXED);
-	if (IS_ERR_VALUE(mapped_addr))
-		return mapped_addr;
+	if (vma->anon_vma) {
+		anon_vma_lock_write(vma->anon_vma);
+		anon_vma_interval_tree_pre_update_vma(vma);
+	}
=20
-	error =3D mlock_future_check(mm, mm->def_flags, len);
-	if (error)
-		return error;
+	vma->vm_end =3D newbrk;
+	vma_init(&unmap, mm);
+	unmap.vm_start =3D newbrk;
+	unmap.vm_end =3D oldbrk;
+	if (vma->anon_vma)
+		vma_set_anonymous(&unmap);
=20
-	/* Clear old maps, set up prev and uf */
-	if (munmap_vma_range(mm, addr, len, &prev, uf))
-		return -ENOMEM;
+	vma_mas_remove(&unmap, mas);
+
+	vmacache_invalidate(vma->vm_mm);
+	if (vma->anon_vma) {
+		anon_vma_interval_tree_post_update_vma(vma);
+		anon_vma_unlock_write(vma->anon_vma);
+	}
+
+	unmap_pages =3D vma_pages(&unmap);
+	if (vma->vm_flags & VM_LOCKED)
+		mm->locked_vm -=3D unmap_pages;
=20
-	/* Check against address space limits *after* clearing old maps... */
+	mmap_write_downgrade(mm);
+	unmap_region(mm, &unmap, vma, newbrk, oldbrk);
+	/* Statistics */
+	vm_stat_account(mm, vma->vm_flags, -unmap_pages);
+	if (vma->vm_flags & VM_ACCOUNT)
+		vm_unacct_memory(unmap_pages);
+
+munmap_full_vma:
+	validate_mm_mt(mm);
+	return ret;
+}
+
+/*
+ * do_brk_flags() - Increase the brk vma if the flags match.
+ * @mas: The maple tree state.
+ * @addr: The start address
+ * @len: The length of the increase
+ * @vma: The vma,
+ * @flags: The VMA Flags
+ *
+ * Extend the brk VMA from addr to addr + len.  If the VMA is NULL or the =
flags
+ * do not match then create a new anonymous VMA.  Eventually we may be abl=
e to
+ * do some brk-specific accounting here.
+ */
+static int do_brk_flags(struct ma_state *mas, struct vm_area_struct *vma,
+			unsigned long addr, unsigned long len,
+			unsigned long flags)
+{
+	struct mm_struct *mm =3D current->mm;
+	struct vm_area_struct *prev =3D NULL;
+
+	validate_mm_mt(mm);
+	/*
+	 * Check against address space limits by the changed size
+	 * Note: This happens *after* clearing old mappings in some code paths.
+	 */
+	flags |=3D VM_DATA_DEFAULT_FLAGS | VM_ACCOUNT | mm->def_flags;
 	if (!may_expand_vm(mm, flags, len >> PAGE_SHIFT))
 		return -ENOMEM;
=20
@@ -2850,30 +2964,56 @@ static int do_brk_flags(unsigned long addr, unsigne=
d long len,
 	if (security_vm_enough_memory_mm(mm, len >> PAGE_SHIFT))
 		return -ENOMEM;
=20
-	/* Can we just expand an old private anonymous mapping? */
-	vma =3D vma_merge(mm, prev, addr, addr + len, flags,
-			NULL, NULL, pgoff, NULL, NULL_VM_UFFD_CTX, NULL);
-	if (vma)
-		goto out;
-
 	/*
-	 * create a vma struct for an anonymous mapping
+	 * Expand the existing vma if possible; Note that singular lists do not
+	 * occur after forking, so the expand will only happen on new VMAs.
 	 */
-	vma =3D vm_area_alloc(mm);
-	if (!vma) {
-		vm_unacct_memory(len >> PAGE_SHIFT);
-		return -ENOMEM;
+	if (vma &&
+	    (!vma->anon_vma || list_is_singular(&vma->anon_vma_chain)) &&
+	    ((vma->vm_flags & ~VM_SOFTDIRTY) =3D=3D flags)) {
+		mas->index =3D vma->vm_start;
+		mas->last =3D addr + len - 1;
+		vma_adjust_trans_huge(vma, addr, addr + len, 0);
+		if (vma->anon_vma) {
+			anon_vma_lock_write(vma->anon_vma);
+			anon_vma_interval_tree_pre_update_vma(vma);
+		}
+		vma->vm_end =3D addr + len;
+		vma->vm_flags |=3D VM_SOFTDIRTY;
+		if (mas_store_gfp(mas, vma, GFP_KERNEL))
+			goto mas_expand_failed;
+
+		if (vma->anon_vma) {
+			anon_vma_interval_tree_post_update_vma(vma);
+			anon_vma_unlock_write(vma->anon_vma);
+		}
+		khugepaged_enter_vma(vma, flags);
+		goto out;
 	}
+	prev =3D vma;
+
+	/* create a vma struct for an anonymous mapping */
+	vma =3D vm_area_alloc(mm);
+	if (!vma)
+		goto vma_alloc_fail;
=20
 	vma_set_anonymous(vma);
 	vma->vm_start =3D addr;
 	vma->vm_end =3D addr + len;
-	vma->vm_pgoff =3D pgoff;
+	vma->vm_pgoff =3D addr >> PAGE_SHIFT;
 	vma->vm_flags =3D flags;
 	vma->vm_page_prot =3D vm_get_page_prot(flags);
-	if (vma_link(mm, vma, prev))
-		goto no_vma_link;
+	mas_set_range(mas, vma->vm_start, addr + len - 1);
+	if (mas_store_gfp(mas, vma, GFP_KERNEL))
+		goto mas_store_fail;
=20
+	mm->map_count++;
+
+	if (!prev)
+		prev =3D mas_prev(mas, 0);
+
+	__vma_link_list(mm, vma, prev);
+	mm->map_count++;
 out:
 	perf_event_mmap(vma);
 	mm->total_vm +=3D len >> PAGE_SHIFT;
@@ -2884,18 +3024,29 @@ static int do_brk_flags(unsigned long addr, unsigne=
d long len,
 	validate_mm_mt(mm);
 	return 0;
=20
-no_vma_link:
+mas_store_fail:
 	vm_area_free(vma);
+vma_alloc_fail:
+	vm_unacct_memory(len >> PAGE_SHIFT);
+	return -ENOMEM;
+
+mas_expand_failed:
+	if (vma->anon_vma) {
+		anon_vma_interval_tree_post_update_vma(vma);
+		anon_vma_unlock_write(vma->anon_vma);
+	}
 	return -ENOMEM;
 }
=20
 int vm_brk_flags(unsigned long addr, unsigned long request, unsigned long =
flags)
 {
 	struct mm_struct *mm =3D current->mm;
+	struct vm_area_struct *vma =3D NULL;
 	unsigned long len;
 	int ret;
 	bool populate;
 	LIST_HEAD(uf);
+	MA_STATE(mas, &mm->mm_mt, addr, addr);
=20
 	len =3D PAGE_ALIGN(request);
 	if (len < request)
@@ -2906,13 +3057,38 @@ int vm_brk_flags(unsigned long addr, unsigned long =
request, unsigned long flags)
 	if (mmap_write_lock_killable(mm))
 		return -EINTR;
=20
-	ret =3D do_brk_flags(addr, len, flags, &uf);
+	/* Until we need other flags, refuse anything except VM_EXEC. */
+	if ((flags & (~VM_EXEC)) !=3D 0)
+		return -EINVAL;
+
+	ret =3D check_brk_limits(addr, len);
+	if (ret)
+		goto limits_failed;
+
+	if (find_vma_intersection(mm, addr, addr + len))
+		ret =3D do_munmap(mm, addr, len, &uf);
+
+	if (ret)
+		goto munmap_failed;
+
+	vma =3D mas_prev(&mas, 0);
+	if (!vma || vma->vm_end !=3D addr || vma_policy(vma) ||
+	    !can_vma_merge_after(vma, flags, NULL, NULL,
+				 addr >> PAGE_SHIFT, NULL_VM_UFFD_CTX, NULL))
+		vma =3D NULL;
+
+	ret =3D do_brk_flags(&mas, vma, addr, len, flags);
 	populate =3D ((mm->def_flags & VM_LOCKED) !=3D 0);
 	mmap_write_unlock(mm);
 	userfaultfd_unmap_complete(mm, &uf);
 	if (populate && !ret)
 		mm_populate(addr, len);
 	return ret;
+
+munmap_failed:
+limits_failed:
+	mmap_write_unlock(mm);
+	return ret;
 }
 EXPORT_SYMBOL(vm_brk_flags);
=20
--=20
2.35.1
