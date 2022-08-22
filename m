Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85E6459C220
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 17:06:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235778AbiHVPGB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 11:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235932AbiHVPDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 11:03:50 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 198342B60E
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 08:03:40 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27MEkP0m022949;
        Mon, 22 Aug 2022 15:03:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=DlNKLbKaGZRxitRZ8jvB/TyOnLy5wqHutYr7wCgIIfA=;
 b=TAny8wnwEeiyDlawNja01uSCE9TjuB6d5vGsVcycufTbtJrpyrrhOQCySZJeVQfXtFL8
 HszwQxyEec7f5mpAmya8GnxlRWml7CkEB0VBxolTvWmluFIa50U+f6d1rYx/EE7Cd2gv
 KntAQlFEnFV3ck7pVaE2Ky792iljSXyA5GRVqUzJxPjp9dLc8cWO/oZ0XgIdxrLBE09I
 usLg/Y832EuMxV7SUHS3xR3eZRJhpxUYlaF8CmRK55q0ZOBCG6mLr/8xLVcUeqogHlBc
 HQb3UI67sVpzttmZVBlo936E3u8b0yB3a5ukK7GqOlDcrTUm98ndnL5nhRgQNHvpYc2E jA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j4ar8gbc6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Aug 2022 15:03:20 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27ME4Ok7035558;
        Mon, 22 Aug 2022 15:03:19 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2176.outbound.protection.outlook.com [104.47.73.176])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3j3mq1tv5j-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Aug 2022 15:03:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WtalwHH9Zf7pxque3gToEgDBQ2ifGr+bo90p9FiWtfPIAWCZc52cnj2U9C5S+g9rqZm2t14igexpnRd3fW0ZOHSfYb85cU+CUwv6eQE5TDv8hiHIZ9geoLAaq11/LFZE4zGi3pzZGNoJJqkPdjlRQxLh+livIs+7qiXvTnyn5zZet4Ub6WTNkRPXBjzrwRFAoK3jm/DZwon/7E49Ro8+J1G4D0bSYATFV44JSeaycg5m1cOiKis9+UEjSetMapCjywiudCbPSe2ZbFCLjCKftmP1uIKp+AvWkKgPDQY8qVqF/P/WFD6nrN0odArDB1OIy/Yp5YTjUATWn5gcycvuMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DlNKLbKaGZRxitRZ8jvB/TyOnLy5wqHutYr7wCgIIfA=;
 b=LvUPizVHSfrD7C+Om2MZYNRyzYR6YjnT/tGvZ17y/5B8AB20GBPVB/Dc+UmhJ0+Hcq7EHmIc1T3IccLBAQBGLXkWULcyaiMj0yqDu553ebfGyIVLpYizbmT4sgnpv/TvIVlTfvKQTeTwda2mFyTkOWX0akKWfgoV5llgH5kKmF63Kz+vZ0c1oOij9dT7U7s5cwS2XXHGdgnF+bfCl0+33hywgQki2E8pPiHS961wZrl3f/sAsh1Lm8mw2p6RpWMnQnX89XgBo9dGPJ1MIcm1gnn1GgVTA1K0iF4KOqvAKkqtuAsMxAKvOP7/xe5/0auiz/WC8+WJeVhDSqT+cvS3Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DlNKLbKaGZRxitRZ8jvB/TyOnLy5wqHutYr7wCgIIfA=;
 b=dkVL3cnpR7MaeeyLazElYlOIVWI59K1hj/t/ujjIziQh1+tT/RwrlHI4Wgr7VHkWP2APei0Ag2zkIh4rTvhMVMjjbIGg/0ekiQ7IdwUPihH/e2pL3v4zdPLBW/QJbnaK0WcU7Ih131EP91SSqwTaRP2fBtT78qyc9aXf8LiI31s=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BN8PR10MB3506.namprd10.prod.outlook.com (2603:10b6:408:ad::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.21; Mon, 22 Aug
 2022 15:03:17 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3d34:ebb5:d9df:98b3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3d34:ebb5:d9df:98b3%5]) with mapi id 15.20.5546.023; Mon, 22 Aug 2022
 15:03:17 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH v13 11/70] mm/mmap: use the maple tree in find_vma() instead
 of the rbtree.
Thread-Topic: [PATCH v13 11/70] mm/mmap: use the maple tree in find_vma()
 instead of the rbtree.
Thread-Index: AQHYtjhG5+ABmsB+OUe2EkZxbNrB/w==
Date:   Mon, 22 Aug 2022 15:03:02 +0000
Message-ID: <20220822150128.1562046-12-Liam.Howlett@oracle.com>
References: <20220822150128.1562046-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220822150128.1562046-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2ce44ffa-5d50-41ba-4670-08da844f71bb
x-ms-traffictypediagnostic: BN8PR10MB3506:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cl8zqCCPTnOM8FyR/DYEe5an3ZnkfEz/btsgaJBXVxnZwd9l/uFqmTBT6kfVnjqjpaMYea1RzJB0jLLQLboEItNgFuEu1x2AayKPr3jCKTM5K1soZgMrP7M9hWo44/BkBiMxFX79yQcrRTGgho73m8aoJg5iMjjImpe90pkyf+WFMwDq/qbXkoQBco35nSwOq8VPViHXnnfCRHqcOO01dTO1l7KABxo5XauKZLppwhxeHMBaTv6xywITO+lYB1QHcBEilHMlUWr/D3F4MOt1DwAMgU2szIx3O9sDmXlphVb+tZduyN7p953aUQ3RfFBcj6gZUCptEpjC8yDSaHbaYosIMegklgKMytytwxcnUrGYOlboTKw/8/FnbT2iS8AwasMK35Hxzy4Oe2RAe3UdrK/Mals2zPyQFJDh204xUjHlWO5uIXrop+CXavur/VZafkkubc+S10yEgw2Mw79jokgwsS2oeD3Kgh2EpjmVKKfn61x3rmIHXXJXsOM83b24VfQ5o8NJee+fMIK7sI1nArRIHS1CpFEjykMnPC1biiutSJBoc3XRtSXn6khnKpXdyjF/uo/QogRehV/mKBzqLGgso4MW9D6UUU0DUT8nj/xMYJCgBb9sHwFgcV9YFWLtbsTGqgCW9LZ4mR8MSinQe6o2R2CECd+zX5fvCrfJgDOwvgAy5yJmrUi+1JWwGj3Hy3KHLhcFoczYv4Q6DO4bKJvueyZQAow5kYluoPUnJB1EvSM2SlyGKkJYIwBFiHw6bpjN+hYvOUNMIr+Ahy2MJA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(346002)(39860400002)(396003)(366004)(136003)(38070700005)(83380400001)(38100700002)(66556008)(36756003)(66446008)(122000001)(66476007)(8676002)(4326008)(64756008)(66946007)(76116006)(71200400001)(91956017)(6666004)(8936002)(26005)(6512007)(5660300002)(44832011)(6506007)(478600001)(6486002)(316002)(54906003)(110136005)(41300700001)(86362001)(1076003)(186003)(2906002)(2616005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?MDSSgs/tEc7KQBBhQi24fH4tsRkWUPUx84Y4A4Tfw07jqpLjnuXQwOoxFa?=
 =?iso-8859-1?Q?tlluOfE1EbSx9n76XE99Kygnt5MCLG4xTAtqQ6aUuJXXiSAoA9bdJWECgy?=
 =?iso-8859-1?Q?/gw68dtqTooGB3yfKmu1T7/LkcWz4en24P90DXcMVwOYeDMr3eABmDhUON?=
 =?iso-8859-1?Q?nIoyZQ3gq3Hh71Qc2YSqcxfg4UwZlar6M4TvVz/UOxNZWXYJjle5ULWeKZ?=
 =?iso-8859-1?Q?QeDLoj9H6/y+kXR5c0tbD/f3yI5uVRcME9D6V8v4joKVPHXwlGmAMit4Le?=
 =?iso-8859-1?Q?ewpz+15655SJQcgDNwlLO0ssTuvHypDBOJsi25MptAeNlFByupBa4CbMIZ?=
 =?iso-8859-1?Q?wq30/2PDgBz+KeduM8Q1Z+9oSuKYN1KTphZRZJFuucU/49XT5s4KgjBNwo?=
 =?iso-8859-1?Q?rl5wHD2ecD2l7qwLcrMIpUQnyhtI1IjupG1WR8Eya7nzq/j7bW9FQdMHii?=
 =?iso-8859-1?Q?HWQvsghamhNqCmKZKHuZbRUFhKuWPWVyiYEzphbP9CJ4RlS6ZbHqcUm8g3?=
 =?iso-8859-1?Q?ycnGFET7Rff9xutVsSuQsLLLrOy2+2QBXKLAwgnQNqNrG/khl6W3C1QaC0?=
 =?iso-8859-1?Q?5h+coqJP5pBEGcBFUxtlj6vQe4SPTkE39b+Bt/JwqKK4xIaBD7a1esCaTR?=
 =?iso-8859-1?Q?JRRj3qD7eogGwjwf6952xFv3ccmONy6sENtioG//6sWpUr7ORAW8yUp4Ux?=
 =?iso-8859-1?Q?dq8zNpAJeqcT3LSTp+sEIoTwQFRbflfVhTPSchuSkAs/Ip+LYn+y7XA3zc?=
 =?iso-8859-1?Q?Yc8XUrL2yhwkqAoDLwhz+EvRHwj3M5T7J9EZzaOWAHM4NMfJzrbnU82vnc?=
 =?iso-8859-1?Q?eMbdnsWisZOiegN1Jt2tbay1GHNoklyeFoXudv/y3Yn1SQetz7aWrs4hyE?=
 =?iso-8859-1?Q?DrhriThh9QepoKQZnvmi8/J+n7IHoM/hzy6cgEpg/vZI7zH0oOkGbCoKdy?=
 =?iso-8859-1?Q?AFu04osy516DXMSVpr9BH5bJJ/8Z0A73ADGkqtBgB9XtVEBHK5u2ygCA+6?=
 =?iso-8859-1?Q?WzY7RdRgumsfQTFhDmXWYj9KTsefLj0OI/c2yGVh3qef430EiE+3qjEnG5?=
 =?iso-8859-1?Q?lD6sMy4HyDZ40hQpwjzsv82yKrgerJowpl3Crh8x+hyyXLz4MnnWRlveuv?=
 =?iso-8859-1?Q?zgnNSmJwhZfw9dwwk9ZtYMFtl4o/J7kWIBKTDb5whd8y/+vrLmYRyfZ256?=
 =?iso-8859-1?Q?pH2hVwNdkkzhLnoxlnYuEbq+27682EC5BsM2aGPOVgawgjLHtxJQDvII5Y?=
 =?iso-8859-1?Q?NNTI1Rkw5MZCNzc2maeIkjKTy6DHjIjug0UEHxqFSEz3krxA/zucDudByH?=
 =?iso-8859-1?Q?9VJanvf9wImujRxQdQQCKlFDRnyi0Gh2buJUEG2dz8HjUDxuAn2XJFVIk3?=
 =?iso-8859-1?Q?RhZGunkThah98SC/NCnN/xkT3RqndquUe3PdIitvp/B2nJY3qYbPy3m8kl?=
 =?iso-8859-1?Q?eu37ZytJ2jaVtUlcNrMcHuBzcrEjCvI8xzmNQPstwtChLXGH2Kyj3DKfr+?=
 =?iso-8859-1?Q?iwcYKsVl9Euk186Cv4cRUDqfpSrrZj30PBsckbaZ2Y0f8+mebGGPlT5jbD?=
 =?iso-8859-1?Q?lIWqB0z0Fh9bs6S5/K38Hmqg4IO9Tvn4DYODVxwEOPdt013BMdx3sRM6G5?=
 =?iso-8859-1?Q?pcG+zViwg2A0yenSfjc9wkID/PuV+U9bpj0hmmYvdheOIytz/dzBnesQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ce44ffa-5d50-41ba-4670-08da844f71bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2022 15:03:02.0957
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EYTBQUjsoWLEAzZGmBOy0MQ4LTEXv/9h3KdBuGIzmSjkzslyXNo3eL1CVlzffkUcbGjwFP8owarjdELr06vO5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR10MB3506
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-22_09,2022-08-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 bulkscore=0
 mlxlogscore=825 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208220064
X-Proofpoint-ORIG-GUID: Gu8q9-rdf7N-av8aY_GK9b7X9eLA26bg
X-Proofpoint-GUID: Gu8q9-rdf7N-av8aY_GK9b7X9eLA26bg
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

Using the maple tree interface mt_find() will handle the RCU locking and
will start searching at the address up to the limit, ULONG_MAX in this
case.

Add kernel documentation to this API.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: David Hildenbrand <david@redhat.com>
---
 mm/mmap.c | 28 ++++++++++------------------
 1 file changed, 10 insertions(+), 18 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index f1b07751a1e4..dbbf8ee12f60 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2449,11 +2449,18 @@ get_unmapped_area(struct file *file, unsigned long =
addr, unsigned long len,
=20
 EXPORT_SYMBOL(get_unmapped_area);
=20
-/* Look up the first VMA which satisfies  addr < vm_end,  NULL if none. */
+/**
+ * find_vma() - Find the VMA for a given address, or the next VMA.
+ * @mm: The mm_struct to check
+ * @addr: The address
+ *
+ * Returns: The VMA associated with addr, or the next VMA.
+ * May return %NULL in the case of no VMA at addr or above.
+ */
 struct vm_area_struct *find_vma(struct mm_struct *mm, unsigned long addr)
 {
-	struct rb_node *rb_node;
 	struct vm_area_struct *vma;
+	unsigned long index =3D addr;
=20
 	mmap_assert_locked(mm);
 	/* Check the cache first. */
@@ -2461,22 +2468,7 @@ struct vm_area_struct *find_vma(struct mm_struct *mm=
, unsigned long addr)
 	if (likely(vma))
 		return vma;
=20
-	rb_node =3D mm->mm_rb.rb_node;
-
-	while (rb_node) {
-		struct vm_area_struct *tmp;
-
-		tmp =3D rb_entry(rb_node, struct vm_area_struct, vm_rb);
-
-		if (tmp->vm_end > addr) {
-			vma =3D tmp;
-			if (tmp->vm_start <=3D addr)
-				break;
-			rb_node =3D rb_node->rb_left;
-		} else
-			rb_node =3D rb_node->rb_right;
-	}
-
+	vma =3D mt_find(&mm->mm_mt, &index, ULONG_MAX);
 	if (vma)
 		vmacache_update(addr, vma);
 	return vma;
--=20
2.35.1
