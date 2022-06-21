Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D9BE553BDE
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 22:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354426AbiFUUr4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 16:47:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354349AbiFUUrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 16:47:23 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83F042BB34
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 13:47:22 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25LJLc3I012614;
        Tue, 21 Jun 2022 20:47:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=8qSwZqhBIWhZHlB/jtQYgAjV9gr6B2wgy8S7KNEw1bU=;
 b=kgHvpw7pYHo3Z1GVDZBD+Zgf0x2hKnYQhlu6EX8grT6XRdVUItHbEQI0YhHxpBrSPP3W
 eVSSz+olSAbKfKDz8ta0k/bFTqcVmfSm5976LWYannmjp35nFFlMKo0PbUel3OeaD8wh
 FRPkn1f8cuBu7kztbvY9iohhd2xxxZ4bKvFVAbFf8l+4je5WIpYP1fSC34xoVWmBRMrK
 74D+HajIIJzPtIsRZLIibaWhxPwZYEwaLaSNhRrXCemzX4RDXYuPtaWEpT2464k7Ig4i
 a0JH3O3IDtLdATwPyL63Zt2gNgYyCVwG2+LRIwjFlJpYu/lF+bBTc+rMkeJeWQVubUU0 Nw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gs6kf6kge-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jun 2022 20:47:09 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25LKembn037937;
        Tue, 21 Jun 2022 20:47:07 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gtg5us8n9-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jun 2022 20:47:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RoScslAQgJyqkmkB3kmZlV3O6altdKQjOYxDBd+MCmnKNJWmkNaEsV6LgJVZTtUvlEOYjt1k372FPyq+r95AfJ3TKikz2CnrndM4DKCCfsautl0SDOGEk2Ofaps0HCzi454wnBpEwKwLhipCQ5ZbMpr/1sOc1m4URvJ6cWyAy43He+oWdMS5vbBeurGMZ5by9qRwvswvW53LAU/3PZUSJcwTAd8KuY2XEjNMOVSSaegNKUF8FktLJyYGWh2ttuk96HNu/6l9vz/K3nW3tTIYuHayQMwQYm3HvQzg8GxhFba802u7PYJXArLRlgo1PKTNhUeuo2Myt2RxpVlkdz1JJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8qSwZqhBIWhZHlB/jtQYgAjV9gr6B2wgy8S7KNEw1bU=;
 b=CirwmxDCBaZgHk1tM9bED0oqPzpV9s8pX0IPjY1u03jkLYD8GRd2tFI8y4S4cJxdylIYQhvCj5cvrODpVBwZDGhfALhUqZoMvTCYGIbRsN+jWV2gwhZ6+BNUDDJ6yprD56hWSZctDz1ERVT9r88o9fMKXMmP7duCvNs5fjQGcg9RlrIu4rJ6hf5nGpGWO0xbUETl5GmhEECU8z5esN6e4X3LPvxKD5g//h/VP8RdTJcvUG2UtgbOkidE4bd9RZeJH900XZyN0hztXMZdWTny08HDcuFYNB4A9res+ms5deiSAPKfy3yirPzSBmFXVeGwwyG6748LcaFNeWrA8ZDSGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8qSwZqhBIWhZHlB/jtQYgAjV9gr6B2wgy8S7KNEw1bU=;
 b=dJ0tI7FMLOoGR/Ml6ClLrZDuu6DTAeX290/HW7CI8hvv2nAYAGfvY8pxXtt67xxZblddixLB/C9I4+yCRQfDZVP1sKKk6D+4CFzy81IecN0rjdlMW1/5DMiGc1nSnCPNwHx/b8kZa9cNyB1OTeEsVraz5kC3w7UCGP9wW38VMp8=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SN6PR10MB3085.namprd10.prod.outlook.com (2603:10b6:805:da::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Tue, 21 Jun
 2022 20:47:04 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f59a:175d:d24:949c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f59a:175d:d24:949c%7]) with mapi id 15.20.5353.022; Tue, 21 Jun 2022
 20:47:04 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "damon @ lists . linux . dev" <damon@lists.linux.dev>,
        SeongJae Park <sj@kernel.org>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH v10 15/69] damon: convert __damon_va_three_regions to use the
 VMA iterator
Thread-Topic: [PATCH v10 15/69] damon: convert __damon_va_three_regions to use
 the VMA iterator
Thread-Index: AQHYhbALnOB98sBhzE+ymFEScAPgZA==
Date:   Tue, 21 Jun 2022 20:46:56 +0000
Message-ID: <20220621204632.3370049-16-Liam.Howlett@oracle.com>
References: <20220621204632.3370049-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220621204632.3370049-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f9c8e348-b673-4368-8d9b-08da53c732b2
x-ms-traffictypediagnostic: SN6PR10MB3085:EE_
x-microsoft-antispam-prvs: <SN6PR10MB3085F85B1A4B9F29DD900143FDB39@SN6PR10MB3085.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wBYxQUle231B3XMyaGnKAqtiDqPOKKw0yPtBqM3GwySyUXf6kBXIlqEymhZN0oc7Q0IbYNMeXFY3paTkb4bX8l6VdFdrqRzMxrjV4RLtffz/JY8k5n00yBacu0SFUkvPJ/OTcrYx1X0MnZeU2SRP3ErGVYwVUHUcl4ZltlZN5RnXppdsnco6E9Ndo5jXesLQf20cNrwex9ppGP7Csr0I1FKvqJNhAH2PH1vHL5TXCioQwrAbnDNrMS3j6h4h0/JMbSlodPlKbHQ1JfEzzV3iO3dhKHCNwBY+FQJ5ZhqnZPcumXWTUHK8tVsfVwhLkmypHKarpFoIma74vEqqj5PV0OJ7c/9QOFhEv3Cgb4qo7j4lotIeCCCKfpWVABGObxG+UFSzji6JN1zv2Jn7Q4GHQJCbFui96Uf3B1rhpF73VyZXiub0PZDrPNywwS88Sr0CHxkyGO6ILdmLk2jZ5bvjwo4alFxC2LVb9dqScr8z/9kCSyNhwr5QeXgSs5uRQgCCBHYt+HY1ml5c58mY58fS8FhnEMeZQrwjJfVxynHRCLNJ1Sp5Un8KfJowFrbgQ8yr2D+b7oGLNTiA12lGQ8jJzkhmx4V8Kar68vXlaBiy3onPf0cePiCvhgILy+LFVs5SrW8l4f40qwS5TYRf8IOSs4KmCd0lHa7swcVf0AU5C7sZKtJ7cFN90WqemVWwwC/y5A0YKByAoydWxtIWKL1j+pFcuKtZ6ReWR3gWXTsFiS6JVTPEOi9P2acYFTh/Fei5tkVRr4WR6YQebKyMvsKigvoWwkMAC2JG1ysOS/BLd8Q=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(366004)(376002)(39860400002)(346002)(136003)(2616005)(66446008)(6486002)(76116006)(66556008)(966005)(36756003)(64756008)(83380400001)(478600001)(66476007)(1076003)(71200400001)(316002)(186003)(44832011)(5660300002)(8676002)(66946007)(6506007)(2906002)(41300700001)(26005)(6666004)(86362001)(91956017)(6512007)(38070700005)(38100700002)(122000001)(110136005)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?mdeKhMUUIG6mqsB3OCtlo9eli/+A9r7byjmgfIaE7uQQycRXFd/ITVwcD2?=
 =?iso-8859-1?Q?E1/DePoVdNsESTm4/J5C6eIb72lL5PdwBVNonnqnlqxVZBnmEKAR41gT+R?=
 =?iso-8859-1?Q?OVE4i3SWCKjY+aWQg+6V7pY+3ytOOb2I/o+M0nLJMvhjkYV/LRnZt9zvyW?=
 =?iso-8859-1?Q?vy0PcOev3gOVHi92wukwhLCA1RexooHCgTBlRqqQlT3sTr/mruGpQJjVFr?=
 =?iso-8859-1?Q?juVvzd0VlNJjuAoG/4JNF+cQ+ypPSE+wgrTswn0u+F3p8NGDGFtx0yy1QP?=
 =?iso-8859-1?Q?tngV1IrMUD/3S2Sqs3hwPoZWS4FBW/B5EwuW0CDdjprSjhp2VFUkHmPx+N?=
 =?iso-8859-1?Q?UCh54zfxT6OLLoBQidqX1Om44RqEQsqdxsbD7YMsKOESCzPMgUsvrTv1W9?=
 =?iso-8859-1?Q?D7RKDtSvtjexnsXJ9Ap51SCqXBh14tYUYpmKZq5XVrZuKfRuzKVQ5qPqWN?=
 =?iso-8859-1?Q?51p3vh5c1+MVtp34tv4iKf7i4I+4uEOBEITcjEbnT8bqYn1z/YhGYADzqc?=
 =?iso-8859-1?Q?tihPmyCsl7OjhyQ8y0xw0Fh7WqeBr+RWtF1x1sh/XP55VD9Za2iWnZtjvF?=
 =?iso-8859-1?Q?JNX0P/We6scVF53zFl79uHZtJ2M2J9EaI7QGo1PE4HXONVGTQ2Wu35tv1W?=
 =?iso-8859-1?Q?Aq7RUg7It5/co/N7fKJ54aNpb34kR1vxvg5kHgofbNO67LS+H2+i/La+2Q?=
 =?iso-8859-1?Q?dkQmrgo4Ss4VJ3HG6NCdFjnsIo3lZdr7mDXuY35+Z1x2wfT/Kae+noNDFD?=
 =?iso-8859-1?Q?e5lfT05BvYpN9/BGdgzbZxUPda8wRUV5ph0ELExQuolGXt7NJ2pRryIar9?=
 =?iso-8859-1?Q?qDHfX0sjPI/qnsUxaRCDFQMxN0xSpnZ/TZuprn0KEvwCuV+wzYm6XERO6z?=
 =?iso-8859-1?Q?8QWxXIqgu3c7QkVEMX465FnmEbs25N7JdO6Fb1TQuQ4i0g0dz7xaw+jNUO?=
 =?iso-8859-1?Q?ed99KT+edx3SaCbcAhHt2LBtcxfUWW6LJRanndX3mXM3x8LN6xFwI84Glq?=
 =?iso-8859-1?Q?PkaZnyJ027SjhasR/kvw0kz1fAJNAEkcDzZB2ZzJzjEnfrbdDTXWP3pslK?=
 =?iso-8859-1?Q?Bol141Lw8X3WMLfTwqVJeg5fL2ERH/vMbbxO9BfakJCg36/gxT2NuNXZY/?=
 =?iso-8859-1?Q?XOhR/cNt7Z8HTKEg0rEyjr/5fdChRzkdwS4hN8NJK0czPcaHqCTgteJjSj?=
 =?iso-8859-1?Q?84nT8YyckUsw1wmXW7x09JCjaO7/mPFNIGxbgMzn0SrBopAs2gu4SIWh7K?=
 =?iso-8859-1?Q?YC8bXs0g2YOe4w4UrkueBdTpMk4pOLwIV8Nvq9OIMh141nUxphgIGfdNyT?=
 =?iso-8859-1?Q?k2BrwoypU7rhqDMrY3pF88RHCo61h3JDUtw2/caHhfVTQZ1FggJ6bjsXjI?=
 =?iso-8859-1?Q?rOsvIqrb7caXknWKXpwavNCJ77IK9lIw1hqhl89L6xLmnTx9NA4yngTXDc?=
 =?iso-8859-1?Q?wG1HEXMs/mh6yL9XePV8bWlLnLC1OMeCUsv9ZN88JZNwOK4bhZAYlu8SgW?=
 =?iso-8859-1?Q?mqKiQZ/Uo5ZpL+8RE/AwK6tIrZ1ViLKPjBfYoO0p03NJ/DUC4t4vtYftBE?=
 =?iso-8859-1?Q?QRrsgwbrnVfOdZUwuG274B6+a9dbleAPyrLVEfBbBAVRo69E8yL+wPfRMw?=
 =?iso-8859-1?Q?lqDA7CnC4cCNUReSFPP9S/29pc+HCZ27AIr1iWvxKnTDS5R4QpqzyLzWd2?=
 =?iso-8859-1?Q?N3xhes07EEGYZXaLQhA+Dfu1O/z6xkjLQnolVdU2HjDW/0IrQwkZ8TJFY4?=
 =?iso-8859-1?Q?+YFNr5UVGq126ED5IhigKzxwi1l58GLCuR340HrXGbbCQBAF3M/ya4x7gI?=
 =?iso-8859-1?Q?Gc4Ia+mV0QWsDaaF6mlW18W2Kgb1QPU=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9c8e348-b673-4368-8d9b-08da53c732b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2022 20:46:56.1761
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q5IlWR6mGJUbe7S3tmCd2UkNKJaKpw0w7MTc8mlZkX+YaL4QRp/l1R9qTPnKAc4LjPTIRWPlnknxQ6aq5dLDOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB3085
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-21_09:2022-06-21,2022-06-21 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 mlxlogscore=830 bulkscore=0 phishscore=0 suspectscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206210087
X-Proofpoint-ORIG-GUID: PXb89__T42OGcxLy04-j-WDpF0yMT6or
X-Proofpoint-GUID: PXb89__T42OGcxLy04-j-WDpF0yMT6or
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

This rather specialised walk can use the VMA iterator.  If this proves to
be too slow, we can write a custom routine to find the two largest gaps,
but it will be somewhat complicated, so let's see if we need it first.

Update the kunit test case to use the maple tree.  This also fixes an
issue with the kunit testcase not adding the last VMA to the list.

Link: https://lkml.kernel.org/r/20220504011215.661968-1-Liam.Howlett@oracle=
.com
Fixes: 17ccae8bb5c9 (mm/damon: add kunit tests)
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: SeongJae Park <sj@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Will Deacon <will@kernel.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 mm/damon/vaddr-test.h | 36 ++++++++++-------------------
 mm/damon/vaddr.c      | 53 ++++++++++++++++++++++---------------------
 2 files changed, 39 insertions(+), 50 deletions(-)

diff --git a/mm/damon/vaddr-test.h b/mm/damon/vaddr-test.h
index d4f55f349100..bce37c487540 100644
--- a/mm/damon/vaddr-test.h
+++ b/mm/damon/vaddr-test.h
@@ -14,33 +14,19 @@
=20
 #include <kunit/test.h>
=20
-static void __link_vmas(struct vm_area_struct *vmas, ssize_t nr_vmas)
+static void __link_vmas(struct maple_tree *mt, struct vm_area_struct *vmas=
,
+			ssize_t nr_vmas)
 {
-	int i, j;
-	unsigned long largest_gap, gap;
+	int i;
+	MA_STATE(mas, mt, 0, 0);
=20
 	if (!nr_vmas)
 		return;
=20
-	for (i =3D 0; i < nr_vmas - 1; i++) {
-		vmas[i].vm_next =3D &vmas[i + 1];
-
-		vmas[i].vm_rb.rb_left =3D NULL;
-		vmas[i].vm_rb.rb_right =3D &vmas[i + 1].vm_rb;
-
-		largest_gap =3D 0;
-		for (j =3D i; j < nr_vmas; j++) {
-			if (j =3D=3D 0)
-				continue;
-			gap =3D vmas[j].vm_start - vmas[j - 1].vm_end;
-			if (gap > largest_gap)
-				largest_gap =3D gap;
-		}
-		vmas[i].rb_subtree_gap =3D largest_gap;
-	}
-	vmas[i].vm_next =3D NULL;
-	vmas[i].vm_rb.rb_right =3D NULL;
-	vmas[i].rb_subtree_gap =3D 0;
+	mas_lock(&mas);
+	for (i =3D 0; i < nr_vmas; i++)
+		vma_mas_store(&vmas[i], &mas);
+	mas_unlock(&mas);
 }
=20
 /*
@@ -72,6 +58,7 @@ static void __link_vmas(struct vm_area_struct *vmas, ssiz=
e_t nr_vmas)
  */
 static void damon_test_three_regions_in_vmas(struct kunit *test)
 {
+	static struct mm_struct mm;
 	struct damon_addr_range regions[3] =3D {0,};
 	/* 10-20-25, 200-210-220, 300-305, 307-330 */
 	struct vm_area_struct vmas[] =3D {
@@ -83,9 +70,10 @@ static void damon_test_three_regions_in_vmas(struct kuni=
t *test)
 		(struct vm_area_struct) {.vm_start =3D 307, .vm_end =3D 330},
 	};
=20
-	__link_vmas(vmas, 6);
+	mt_init_flags(&mm.mm_mt, MM_MT_FLAGS);
+	__link_vmas(&mm.mm_mt, vmas, ARRAY_SIZE(vmas));
=20
-	__damon_va_three_regions(&vmas[0], regions);
+	__damon_va_three_regions(&mm, regions);
=20
 	KUNIT_EXPECT_EQ(test, 10ul, regions[0].start);
 	KUNIT_EXPECT_EQ(test, 25ul, regions[0].end);
diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index 59e1653799f8..5767be72c181 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -113,37 +113,38 @@ static unsigned long sz_range(struct damon_addr_range=
 *r)
  *
  * Returns 0 if success, or negative error code otherwise.
  */
-static int __damon_va_three_regions(struct vm_area_struct *vma,
+static int __damon_va_three_regions(struct mm_struct *mm,
 				       struct damon_addr_range regions[3])
 {
-	struct damon_addr_range gap =3D {0}, first_gap =3D {0}, second_gap =3D {0=
};
-	struct vm_area_struct *last_vma =3D NULL;
-	unsigned long start =3D 0;
-	struct rb_root rbroot;
-
-	/* Find two biggest gaps so that first_gap > second_gap > others */
-	for (; vma; vma =3D vma->vm_next) {
-		if (!last_vma) {
-			start =3D vma->vm_start;
-			goto next;
-		}
+	struct damon_addr_range first_gap =3D {0}, second_gap =3D {0};
+	VMA_ITERATOR(vmi, mm, 0);
+	struct vm_area_struct *vma, *prev =3D NULL;
+	unsigned long start;
=20
-		if (vma->rb_subtree_gap <=3D sz_range(&second_gap)) {
-			rbroot.rb_node =3D &vma->vm_rb;
-			vma =3D rb_entry(rb_last(&rbroot),
-					struct vm_area_struct, vm_rb);
+	/*
+	 * Find the two biggest gaps so that first_gap > second_gap > others.
+	 * If this is too slow, it can be optimised to examine the maple
+	 * tree gaps.
+	 */
+	for_each_vma(vmi, vma) {
+		unsigned long gap;
+
+		if (!prev) {
+			start =3D vma->vm_start;
 			goto next;
 		}
-
-		gap.start =3D last_vma->vm_end;
-		gap.end =3D vma->vm_start;
-		if (sz_range(&gap) > sz_range(&second_gap)) {
-			swap(gap, second_gap);
-			if (sz_range(&second_gap) > sz_range(&first_gap))
-				swap(second_gap, first_gap);
+		gap =3D vma->vm_start - prev->vm_end;
+
+		if (gap > sz_range(&first_gap)) {
+			second_gap =3D first_gap;
+			first_gap.start =3D prev->vm_end;
+			first_gap.end =3D vma->vm_start;
+		} else if (gap > sz_range(&second_gap)) {
+			second_gap.start =3D prev->vm_end;
+			second_gap.end =3D vma->vm_start;
 		}
 next:
-		last_vma =3D vma;
+		prev =3D vma;
 	}
=20
 	if (!sz_range(&second_gap) || !sz_range(&first_gap))
@@ -159,7 +160,7 @@ static int __damon_va_three_regions(struct vm_area_stru=
ct *vma,
 	regions[1].start =3D ALIGN(first_gap.end, DAMON_MIN_REGION);
 	regions[1].end =3D ALIGN(second_gap.start, DAMON_MIN_REGION);
 	regions[2].start =3D ALIGN(second_gap.end, DAMON_MIN_REGION);
-	regions[2].end =3D ALIGN(last_vma->vm_end, DAMON_MIN_REGION);
+	regions[2].end =3D ALIGN(prev->vm_end, DAMON_MIN_REGION);
=20
 	return 0;
 }
@@ -180,7 +181,7 @@ static int damon_va_three_regions(struct damon_target *=
t,
 		return -EINVAL;
=20
 	mmap_read_lock(mm);
-	rc =3D __damon_va_three_regions(mm->mmap, regions);
+	rc =3D __damon_va_three_regions(mm, regions);
 	mmap_read_unlock(mm);
=20
 	mmput(mm);
--=20
2.35.1
