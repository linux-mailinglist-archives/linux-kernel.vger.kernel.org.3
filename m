Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8CFB553C22
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 22:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354691AbiFUUuH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 16:50:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354569AbiFUUsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 16:48:23 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 524CE60DF
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 13:48:01 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25LJ3wID009733;
        Tue, 21 Jun 2022 20:47:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=u+k3TELJU6vrFGinHqw2bL/XhJtqmEuLXB68nnzReO4=;
 b=ImiYZamEqAlXO8MUlI7wALvmCLcIXMSK3fJCj1CIbKk4vG/5XK9LCdcVBVzfdNgVJHmJ
 +8MIxh+3hnmHrIUAZgTdhgtLsU+WeCh9zYOHkx50LZiQVp1gteROB6717TCHxr7ERrEI
 22fH3p9l82aMzsIjM2Chib2PIm9dG1dhjHK0zu5vNhy7mqF+R9/iVPAehzjyctzQSoHG
 5RjLT39s8Lg2Karaer6/ifAdvMQFNAvzviTTU4UqZk60QEcwSJ0/5SM1pZJcuuQlYroB
 EFvZMz1ArIb73rgFbv6VsmCGHkwbyk3pc7qyspJDXMJwRbTKH8gIrROWln/DdUrWhpPO nw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gs78txpdk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jun 2022 20:47:50 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25LKeUhx027847;
        Tue, 21 Jun 2022 20:47:49 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gth8wspfd-9
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jun 2022 20:47:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nc0irztj9UQFORQIeMusLCXP3LZGrJaNfqyIww6r897oLOce3gg6f4gp6XDWRSdXQ+QnyOCPxwweWJ/fDStY2v+3KteF2SSMdfrMwvPBTwo3S42efvtsL6VF2LgpHqcXgxR7PUXPMX5JvP1UJ34GGNqHRPOR/dmykRqFTKz2eVSG5hyOFrc6W2++595PVd3iXVBR16rqy+Y61xwem2X4NCpoCE0MQG6alwThtPlmd0z6fEl7+ARBx58sdZpdqee6emVodNykyRXOarTou/PHKdMH9ggwa7W1yObMS6RZoTcv/UxAhSWeA80WQlWClSnX5Ggf/s07UO/ISHgE/KxHDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u+k3TELJU6vrFGinHqw2bL/XhJtqmEuLXB68nnzReO4=;
 b=GeBgfAdPxAoX2JwoIEEfiVYkeQejPCmt3zXjntviWQdY1H9cs7PRrWeqDpHqmOrlTMAv44GHTyUu/kwGiRsnfXdmaAZOBFTaz+VCMB6iBG3Qivq9bydThDgh6UENsByZRZr/KIM9z+RjBCuRaO7cdztzrqKQdOLBakW4nR+vcp4a7TtF/wjSo4FPJUk0PETq5o/N3VM34wU/qy/P2p46im76lnke+DftwQtIbMW4wAZ/EQqIXqS3AiHqrfdbrjR70kG8B0uZfywOMkQWowyRla7pH5OZ0Gs9rY5FaVWSDbOdJiL/ptUKMN1cE/tQd23YS9BcbZZSiUw0YQF96C6R3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u+k3TELJU6vrFGinHqw2bL/XhJtqmEuLXB68nnzReO4=;
 b=sHwEFKFKECIyDnP0MUTapvEqPoFKwz9HK3u4brHTv1HyLKqOUkzjM6hqqfU0vBRfo57wFRffZ5Mxr0VTR9lEHVa24pXCws1SMsvTvAJVgU0KfQ0gJTcV4ntMOIOGwhg7opHkb/Ne+B0PmMdsYIfaN5DWbGD5ALrFmwdpm97t9Vw=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM6PR10MB4025.namprd10.prod.outlook.com (2603:10b6:5:1fe::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Tue, 21 Jun
 2022 20:47:47 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f59a:175d:d24:949c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f59a:175d:d24:949c%7]) with mapi id 15.20.5353.022; Tue, 21 Jun 2022
 20:47:47 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "damon @ lists . linux . dev" <damon@lists.linux.dev>,
        SeongJae Park <sj@kernel.org>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH v10 38/69] optee: remove vma linked list walk
Thread-Topic: [PATCH v10 38/69] optee: remove vma linked list walk
Thread-Index: AQHYhbARjyqwn+AMdkGtxp79JkwcQw==
Date:   Tue, 21 Jun 2022 20:47:05 +0000
Message-ID: <20220621204632.3370049-39-Liam.Howlett@oracle.com>
References: <20220621204632.3370049-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220621204632.3370049-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bc4c96fe-1fae-4c96-0048-08da53c74c70
x-ms-traffictypediagnostic: DM6PR10MB4025:EE_
x-microsoft-antispam-prvs: <DM6PR10MB4025469631E3BE38B3205BBAFDB39@DM6PR10MB4025.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YRoz2vkWT0jGQBLZwQfQc6mbGd28qS+cfld34YjeWUYK3mb5xfLCUDckJUHgo7PyHb0tVJjiyGUn4y/UbvQ4EC/uxNRLJv4+zek4IaOvNZAQJaG7Mh1rvn1SYyyjruJN9Z3zcZBQGAONSHqYHm1JUk/gbHaT2LAqJ+XOLyQInQ60ArpKhdjccc0GDIlmjCQfawA6iF+684DsR6MJkw/K1OD7evSrKKXjn/gIk1y046lM54S35RXAVwDQavm4cl/zjSqTIYxLr2JPQkZb2+PKKChQToRvJ/Vc1g9f/o4gMro80KQtLO/AQXJfJBDeJv+Fo6K+2AGz3caRjz1mfq1iolvoMKmNaW/wXJClfDH5MgBzPRlOyhJ5HqZwP9MH1XiLLNt95mvNsLhLxbeApwNjD1/kNqirjGXOggp7R9XgA+nXyixwzJ0pFKTfc4siWfVjTSqBGGie6nlpsX9MICh9Azkab6dI/c7O9jcYkY+fXAVbuby81jNPlW2fmSweLa9o4kykGQp9zZED9xS19dzCCqYz5B4huiRpnmJr5LmMF0hnbnNho2glfUlnFyggKQ2gRRfSdFHIgS4QFq9VS6zx+Ez+Go5PxlS9EwGMf6IhyJ7nARGMdpFkA3B8k/d1GfvQ5LaMJDrZfC9lqcaTMgNuMDB+srUhQFmnC6S3A7Hmhg+tydE5mnfyXKJvhRKJuJ5NB3czcMac4ySOEOgidfG+WGx3roPI0d9doQ6hQQt8GMQXYWJez10gvIJxd3j3XNVT20YYCSouNHiGQSTAu6WdgV6LwV4XrhAIoDJmgeFj0uM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(136003)(346002)(366004)(376002)(396003)(6512007)(41300700001)(478600001)(122000001)(6486002)(966005)(110136005)(36756003)(8936002)(71200400001)(8676002)(26005)(6666004)(6506007)(83380400001)(2906002)(66446008)(316002)(86362001)(2616005)(91956017)(1076003)(66476007)(66556008)(5660300002)(38070700005)(64756008)(66946007)(44832011)(76116006)(186003)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?E9KZzLlN+eSyHGlfbenSIwbaXYIw3MKqElS9k+iUNpyBO5YwmJuvt43+sH?=
 =?iso-8859-1?Q?dkf97+adEAkcxEd/RxzZnPvRk6CBsLHhF+X4lFiC5pvRaYzlXzuXNdNQ5O?=
 =?iso-8859-1?Q?fM26TlFqD+RuDacfNIMK2ztUnksidFlhgJUdoVrpJBj96Gg1MCyatCkOR4?=
 =?iso-8859-1?Q?QHEKnFbRqgQ6CBqfc63feB++ELOGvFYc5ophN7+nuGoxvQAqHz5hjg2nql?=
 =?iso-8859-1?Q?JhWlgYd01BoD2GiT8hT4ohGv/PRH6f7Ldo55vqJpqG2op+ILeqmhO4lE2T?=
 =?iso-8859-1?Q?BUuRH0NKiA5S4JPfYkmuvVSaRJYm9Y6qjXn2FAqlMWDZuwhhN+NUoPQeJ/?=
 =?iso-8859-1?Q?hKUkCVNSRXgcb5Xa92XiXxnqYhzgRNdLMOO5dtyWlRl4w4yfEQMlpnRAEV?=
 =?iso-8859-1?Q?RJOaZ2SKx5iAWebYf9+Nqn1ZBeXuAqazQNHgSLyuB97bJyLYWYP8ZFXDqq?=
 =?iso-8859-1?Q?ZYEhaUqZVPjCqyQmfzYQv5Mh/imGnHGdQvvh3OKyMrp+2fqTVqlJKmTVnb?=
 =?iso-8859-1?Q?bZ6UHBtpz3p10vu56ns6ziU0DVPzS7O9uDP3R5ypIgkCccGm7R+gOLkv33?=
 =?iso-8859-1?Q?mVNZzw38zdqSx5AEpkf3tYvhoIL6O79S4MEgOr1mhAIdb2mL+Lss2p9gdw?=
 =?iso-8859-1?Q?p9/kDX+up+WW98CuttisYZjmcmF9pEp3KhoPzfdfVo6t+tOEfGtzXE1tgz?=
 =?iso-8859-1?Q?NOER1LEKS/yqZMOFdHGxNte9hm+8ZEOc844ihvyObWuZ2k2lsi394yl3cq?=
 =?iso-8859-1?Q?4vuhjeGNpPM/arK0luBjz8w1ojXzx96hPXTksS7r79vt5doT9H7jrbVyXP?=
 =?iso-8859-1?Q?VB6RcthO7gaokaGm8Tsn06kUcUp9DtGJgSYdhbD9c7UEVSs9g1Roxu5PQ9?=
 =?iso-8859-1?Q?0um7PVFV2ynPgOxs81+nJT7JVTnjwhJ9jMsdqRgCANCUhFQ40hJr09lxgR?=
 =?iso-8859-1?Q?oDcVeBEP46LQFEFXNI8FjqzGDDbIBznXXzl+JswDDdi55p0ik0im+OIlCG?=
 =?iso-8859-1?Q?txCCOh4iXuJehFNtbzFg81sAfQ2BcLwuhvfAGxj/U3D3wgQB9G6qhK/hqd?=
 =?iso-8859-1?Q?gJY7DhcvNQLbFFqlqv6ZBEgjQMy0l58ZYnTJPLkgchLCnRkqOgAJkbG88X?=
 =?iso-8859-1?Q?RL0HNF1FfZV8X67v7KVKRcV9QDNXU/115lDD0FV5x4+wOQJU6rX2bD5DQe?=
 =?iso-8859-1?Q?aIYcHf/+IU12FHgdfRnyslLoLhjibGByieGRYeGX6JhG9jaWrl0B+E397s?=
 =?iso-8859-1?Q?o2zTPXLg2uXPqZZJT9TVqLpyLpz6tJIrUfibTffvk7JW/7pKBZTEINaEkz?=
 =?iso-8859-1?Q?5s1Kv46a7veSCkpsiElhqlX33dcZipCAvZwH7AIt8gaGyVS5sqcxeSDqnb?=
 =?iso-8859-1?Q?ifh8JQj6rcI2XSBpbr0YBDn1tU+G/9Co0tPTZLHjncznsE8zYQl+5bR8BZ?=
 =?iso-8859-1?Q?FeDdoJoOFSJ7om8XGWpdzDGVxDE+FSQgGlwKm95XzvGxkS4gwI7DEa1Dx+?=
 =?iso-8859-1?Q?JnZrFBrw5+184OWhIi6eGLFTIuVNfD+hokazNFjL/hdoEPps6ekN5nTmHA?=
 =?iso-8859-1?Q?kHFiD/SLD1v1ogj+BqSMUnuG7KL1F/mSqYbNJg+nSUp43HNgxGqar52cqo?=
 =?iso-8859-1?Q?bm9lTnEwss46bo24rZ9/w5qF4CRKmr3iyMWNAe46dq1eYh6dTnP/fv2y0d?=
 =?iso-8859-1?Q?5D3FBRud1FyLYex3zwKvc23BYtYNIxAwNZmYM7/+9QFfiWOFyhoOXSTKs5?=
 =?iso-8859-1?Q?dI/CQytiJZIcJF8naKrLEFN83hifu9rEK0rHVX50JyQFlvucuHPgYpkaBg?=
 =?iso-8859-1?Q?AwEivBZJdfEdiuS4TcIxrpbN3GdFUXs=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc4c96fe-1fae-4c96-0048-08da53c74c70
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2022 20:47:05.6755
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z3GPYKJ71lwREnDLL+F9XEDPUL2sOkSWBWa4pLveS7nW4wOLCVCwzWMQH7L0/XgPWua0JADRxVjVG6coBwC23Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4025
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-21_09:2022-06-21,2022-06-21 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 phishscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206210087
X-Proofpoint-GUID: 4eTw7VwHJhGCwPa38Z6jw2SPBZkl7YzF
X-Proofpoint-ORIG-GUID: 4eTw7VwHJhGCwPa38Z6jw2SPBZkl7YzF
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Use the VMA iterator instead.  Change the calling convention of
__check_mem_type() to pass in the mm instead of the first vma in the
range.

Link: https://lkml.kernel.org/r/20220504011345.662299-23-Liam.Howlett@oracl=
e.com
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: David Howells <dhowells@redhat.com>
Cc: SeongJae Park <sj@kernel.org>
Cc: Will Deacon <will@kernel.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 drivers/tee/optee/call.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/tee/optee/call.c b/drivers/tee/optee/call.c
index 28f87cd8b3ed..290b1bb0e9cd 100644
--- a/drivers/tee/optee/call.c
+++ b/drivers/tee/optee/call.c
@@ -492,15 +492,18 @@ static bool is_normal_memory(pgprot_t p)
 #endif
 }
=20
-static int __check_mem_type(struct vm_area_struct *vma, unsigned long end)
+static int __check_mem_type(struct mm_struct *mm, unsigned long start,
+				unsigned long end)
 {
-	while (vma && is_normal_memory(vma->vm_page_prot)) {
-		if (vma->vm_end >=3D end)
-			return 0;
-		vma =3D vma->vm_next;
+	struct vm_area_struct *vma;
+	VMA_ITERATOR(vmi, mm, start);
+
+	for_each_vma_range(vmi, vma, end) {
+		if (!is_normal_memory(vma->vm_page_prot))
+			return -EINVAL;
 	}
=20
-	return -EINVAL;
+	return 0;
 }
=20
 int optee_check_mem_type(unsigned long start, size_t num_pages)
@@ -516,8 +519,7 @@ int optee_check_mem_type(unsigned long start, size_t nu=
m_pages)
 		return 0;
=20
 	mmap_read_lock(mm);
-	rc =3D __check_mem_type(find_vma(mm, start),
-			      start + num_pages * PAGE_SIZE);
+	rc =3D __check_mem_type(mm, start, start + num_pages * PAGE_SIZE);
 	mmap_read_unlock(mm);
=20
 	return rc;
--=20
2.35.1
