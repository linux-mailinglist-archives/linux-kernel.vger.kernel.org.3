Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13AD559C22D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 17:09:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235274AbiHVPGM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 11:06:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235936AbiHVPDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 11:03:51 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3A442C672
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 08:03:42 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27MEkP0n022949;
        Mon, 22 Aug 2022 15:03:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=efBLv26BpwwIiO6F/t7XlORIPGbNcMdf8TaLeG4G/pA=;
 b=WP41Ye3xyPP2wxNuBuf1MCjVDyPAmkwJgiL5HFakapwxFwfZiMqaecMjjGGML1fe8QdH
 yb9MXNUv+C8bxwTDnylxPuS12A/Zu1HD8xbamrMt+k97juKIKDbi7Zjii69CPIihJkrb
 bhP9fZeG9Ylhp+Uq5nfjQtW7Tq1M2t49ZzJM3c2vmF+alnILaB+Bk622zNSp7TSwj8Ob
 DL02tXNH7k8vDQxtfdPwblv6kc9usTFJd8+xl5m7H9Yr1D6fNWIt04UK2SlU4XeL0LFZ
 fJvETZndsZGoRM/g5x8EnSGRymAmGjNaSm6o3Hkhd6zL3dBIPlfmwcePorS9P9fPpGII +A== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j4ar8gbc8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Aug 2022 15:03:22 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27ME4OkB035558;
        Mon, 22 Aug 2022 15:03:21 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2176.outbound.protection.outlook.com [104.47.73.176])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3j3mq1tv5j-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Aug 2022 15:03:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CNGpUw3mW0i0gayVu4yIXWsL+dSYwP3WoatAX/262peVVikQ8Q8mnKd7EBOrzzZ7lx3k6if4ZESnsLgUNoxLyFMthP2NvMa499OxrE0ncZYr4a8c04t9gSQsvuqqyszY13HHO/SV9z8P7IY9WtCuTGe9QvUxmvx2QrYYFkC3YFVHJasnVO0AugL2az5TUynM9J0NTYEzu6zv/twl7D8VX7Zlza3AM2cnTP6zbxr819WeVNgSjnOU3jiJGjSsx+bkY53rlw5w+Pi4RIBbZed1M4DpdTWgRgX5HudsNfunhgDkREq9DkGXpeIuvIASW/anzx3/F/iCC8zQC9MWFUWI8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=efBLv26BpwwIiO6F/t7XlORIPGbNcMdf8TaLeG4G/pA=;
 b=nsphgH8ySQzy9F6mhFAPCxs/ZOYaNeowdmefB5aVCTJDldGrDeHXUGui1vDZEjTzi9JrpU7MdVxDkiiwktN3xQns4FCNuL4uGLZeV32mvTrXL0NfMbNzWM5WKDdRYKT2skJP8ZR19W29aADwUDAtXnHA4HosOmdVYFab5adbJaHoEVFBIJCjUlIBZOOubz9ALRWC7sY0cG0mmHsDeYVBzWEXttb8w2HOPbTI382CcUBbuxMV9cBFEnsOrzmQa2Q1hC7xGt3K84WJI9t2wJn5uERzI0x9a7eMqiXXmlzEwYcJveLaB//TwrK+IF7E+vcdSAzyjQDuFc8oW0CslYB0/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=efBLv26BpwwIiO6F/t7XlORIPGbNcMdf8TaLeG4G/pA=;
 b=D8y7Ja4jNZO3oXL3OrHX+DZdvrS0NCr0MAdyPWAPf1bkVRVI5Bfopv1iwftg4BbN3GgsNY6mPBTIeqVVGoXmYEPedqquxEb7mcHmWnLH/h7aIL3381NHQuwtByzWpyyzfJi4gD/eYm4A4xp5MFgNWlSbC6zXi5E+5ggC2FtzVaE=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BN8PR10MB3506.namprd10.prod.outlook.com (2603:10b6:408:ad::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.21; Mon, 22 Aug
 2022 15:03:19 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3d34:ebb5:d9df:98b3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3d34:ebb5:d9df:98b3%5]) with mapi id 15.20.5546.023; Mon, 22 Aug 2022
 15:03:18 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH v13 14/70] kernel/fork: use maple tree for dup_mmap() during
 forking
Thread-Topic: [PATCH v13 14/70] kernel/fork: use maple tree for dup_mmap()
 during forking
Thread-Index: AQHYtjhLdONeQ16+bUSBaq4CHltCkw==
Date:   Mon, 22 Aug 2022 15:03:11 +0000
Message-ID: <20220822150128.1562046-15-Liam.Howlett@oracle.com>
References: <20220822150128.1562046-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220822150128.1562046-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c40e2e59-7ebe-47cf-4925-08da844f72c6
x-ms-traffictypediagnostic: BN8PR10MB3506:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: a13ca19t9r8jDa6bv6O+lJ/6vbhlZi00H4l2UOeMQCQOQ9PwkIrsynWQ9flI9bZiIdfSwH7bBUbt2+m/LjNFpkmMJE2NvGPjhQ/hl86U3EDi93SwFfn70+4F0EI0+1K0qjE+DFNi7rC6mRY+KiXlDlx9B7OPcjLE1uC4E/q4kTuOWYHnx7pSAJesP4o10RNIQdg8/Cc+h0nJM/sr2urw/KXAFFyF+7huqiMOiE7NifuhgYTrMWFRALwXgwU7tZF8tLuZqzJA/iGbM1DHc7TuT3UzXF8sCti1ITPB0kSJuliteRkn5xSHXtn9S1YLFAqQ+ahCg5kxmB3wCFqgfGxLZpnxMAJg035NGrMExjB/3i3DFrV7JbhKwiXtCq7rqYWYYH1Ay7okFF1XfwYhrQy3P5XyQWZu6LzyM4BHWKYxlKfinapuB3sQw/OLQsHLTZD95zApYY1h+eGxIGgkAFDMahTlV/PUudjU4qDMdhGPSJ0yZJ4HHx5kj/qPZyR+35t957a/M+eAyIdcKUh+S/12bunkXs0jREE5cZpSGXx58JIvA7U6ArkZtqkbFv4jCqNIfM5ZRvyc9ipA10kAFe3JXpJKC3iOxi+9PItpKBt8L4fn/Z8nVz8cMOt7idlkcgPtVu1sIQxqjmr3yKK8Q+7rIc1ElWKA0m1eZUt161Iz6HbpQ1LhZ+cn6DeJfzfPogF7KwjIguKgNdll1wVsqnmAnk0XQrOOeSVlT1JSVHnOm83+dZVMq51JJ/+yxOI+rZQNieukiXvjW/i5ugzwPgrzgg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(346002)(39860400002)(396003)(366004)(136003)(38070700005)(83380400001)(38100700002)(66556008)(36756003)(66446008)(122000001)(66476007)(8676002)(4326008)(64756008)(66946007)(76116006)(71200400001)(91956017)(6666004)(8936002)(26005)(6512007)(5660300002)(44832011)(6506007)(478600001)(6486002)(316002)(54906003)(110136005)(41300700001)(86362001)(1076003)(186003)(2906002)(2616005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?dIqbh9q2Hl5OFAYw2UWtMTyt0fAkTDn5lvRO2jqqpsm84bciGoBSxW875v?=
 =?iso-8859-1?Q?Shht8G4inBqyDfZp3Vv8S/dA2ts0hw0LZu39fxxNQiiHbdpQjUtwqA7DNF?=
 =?iso-8859-1?Q?3/j3t7ot0bqNA+hOJCgPnY7LQ7vZLD8Ua0452D0DygiWZ4m/LlAFjwbv+3?=
 =?iso-8859-1?Q?iQ/hl3IxQTRLfKOlWCNQ57Hkqb+u9Jocm9Vn3MD5gvl0K4PBxE1oCoifOG?=
 =?iso-8859-1?Q?YTTB5kNRnRueZWeQ24gpPdpqiUV1mhnuzykCEoJX3l+2IVpraJN7PBLhhB?=
 =?iso-8859-1?Q?Nw+eopXbGDtgfS6h1Q0MXANJJrQiPTF+r/UMMeD/BcKd4c4qIvTV375+Kh?=
 =?iso-8859-1?Q?6P1rkg4B/7xbLM3ZVPPRu64rt4ew6LDkNiD/87WmpF43Ru01ZJob5foa2E?=
 =?iso-8859-1?Q?yQFz1dYhm9Qt4cLaM1lyo+eyPMpcnCBOM7wjZUzkBSmDMY2TtHiwQsyG5I?=
 =?iso-8859-1?Q?r+opf+AA46X9Hj8Ci9uZG4UoaM98RH0JK9uy3kx8SUuGo5382O+obXn566?=
 =?iso-8859-1?Q?BqpXZtUkt2+M4X08vLh4SIBdCKCi9PHHUcu0rqztKW57BafyyzQYdJT4zW?=
 =?iso-8859-1?Q?KeIbIda/4CtapMGV8t+2YDZXpWF9DG9M/hmPIv4WIFeqTKdtebew988iQV?=
 =?iso-8859-1?Q?LgDR754vSKY66c+i2G3aBm2XMCK5Y6S7HfXZ7Tw2YhegQZuQ4ExFDaVXkL?=
 =?iso-8859-1?Q?nlo5Zgo9y52HyxCheZeyuTl4IgyiY15OITBfxJQg2VWrFtPUdvpnvmJRFH?=
 =?iso-8859-1?Q?VZihHFoHeHwuioCPSgUP6Q9SWWFeC1IlQl7dSdGZ6hWlDrXoctvw2VhHvD?=
 =?iso-8859-1?Q?qIhGKrmH5xxUpwfRIt8OZAy0/jH4NrShBcZ7XE8p6DeYUgIrNLiQo1IOn5?=
 =?iso-8859-1?Q?+oizQ1C66GpCTMonZcxtw/qT43+/IOjTdlz2+OJxZfRion72pcq5RlbVRF?=
 =?iso-8859-1?Q?9wQcHywePsNkrfAPud9rq3v5dQlE9rRoYRqO8SwBrEvE1lB18/UK3ybyP9?=
 =?iso-8859-1?Q?L2a2/9cxloMV8jri5svc93xE+bYNzMiWsbuCqNhCtGb9D+SNIlur+XPpY5?=
 =?iso-8859-1?Q?hMGxfN9SeKgje1vodFkke5S7N4EpWiO2e50e2IB08hoPH05ji6ggV2S+rX?=
 =?iso-8859-1?Q?310lyK+QV69+GfsbolU8oWPMJs9nZsKvT9IN4bS7HhRmh3aRP4pw6LmyzB?=
 =?iso-8859-1?Q?6Iyccfru9G7NkUtoNm+X78KZIYugswJxMBe58Vq/+7VEhCUo1tlFqaDc/L?=
 =?iso-8859-1?Q?yb+7RTt6XYEhWHzFF8kUXNjNgpa9vxSki67uYdlqDSXDQAe2FCA7Gar0Xe?=
 =?iso-8859-1?Q?YBTxuFeac+Rte/JKUZ8QyTycDXAYfrCGy6rE7QrKQt1Hqh3QPjw6JcQPVT?=
 =?iso-8859-1?Q?lcDOeo0JSnLPz+9HsJDoU6BL+D+4+/LScWQuO8/evWjI+iB9q4a2vUQtWg?=
 =?iso-8859-1?Q?xrPWRbI2WrQEKQhQnxMsUY/gda4FFnYFwAx+NFlvCAfqN5JUWwWKjw6Rqu?=
 =?iso-8859-1?Q?sgHbfFhdISsVYx+1CP1ErJWjjdxbOm7UjaGn+0KZ6AYFxJ9KwogOH6yhfu?=
 =?iso-8859-1?Q?QWE9iRhnG59SBpBLVtmGe09yhCPaTISFQjhDm5e/6SC66MPiH5UmxGPUcm?=
 =?iso-8859-1?Q?SkcWitjizC280TXDS9qJ72286vlfsBjz0UhTzPaBlFR5GdFZ/EQk9MrA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c40e2e59-7ebe-47cf-4925-08da844f72c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2022 15:03:11.6106
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u2hc59L5GUxaqeUkZOKfqCj0ZlYB//e+jo3on25p8pXmjOL7GJCC75POYHi/+q1omPMvLCXvo39jw2ICK5dbgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR10MB3506
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-22_09,2022-08-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208220064
X-Proofpoint-ORIG-GUID: i4g-ZAg77FA63PEvnBbHneDvt6f8BJ9W
X-Proofpoint-GUID: i4g-ZAg77FA63PEvnBbHneDvt6f8BJ9W
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

The maple tree was already tracking VMAs in this function by an earlier
commit, but the rbtree iterator was being used to iterate the list.
Change the iterator to use a maple tree native iterator and switch to the
maple tree advanced API to avoid multiple walks of the tree during insert
operations.  Unexport the now-unused vma_store() function.

For performance reasons we bulk allocate the maple tree nodes.  The node
calculations are done internally to the tree and use the VMA count and
assume the worst-case node requirements.  The VM_DONT_COPY flag does not
allow for the most efficient copy method of the tree and so a bulk loading
algorithm is used.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 include/linux/mm.h |  2 --
 kernel/fork.c      | 15 +++++++++++++--
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 352f5d9f212c..d8230a8740a1 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2591,8 +2591,6 @@ extern bool arch_has_descending_max_zone_pfns(void);
 /* nommu.c */
 extern atomic_long_t mmap_pages_allocated;
 extern int nommu_shrink_inode_mappings(struct inode *, size_t, size_t);
-/* mmap.c */
-void vma_mas_store(struct vm_area_struct *vma, struct ma_state *mas);
=20
 /* interval_tree.c */
 void vma_interval_tree_insert(struct vm_area_struct *node,
diff --git a/kernel/fork.c b/kernel/fork.c
index 273364207f17..16970c346b5b 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -583,8 +583,9 @@ static __latent_entropy int dup_mmap(struct mm_struct *=
mm,
 	struct vm_area_struct *mpnt, *tmp, *prev, **pprev;
 	struct rb_node **rb_link, *rb_parent;
 	int retval;
-	unsigned long charge;
+	unsigned long charge =3D 0;
 	LIST_HEAD(uf);
+	MA_STATE(old_mas, &oldmm->mm_mt, 0, 0);
 	MA_STATE(mas, &mm->mm_mt, 0, 0);
=20
 	uprobe_start_dup_mmap();
@@ -620,7 +621,12 @@ static __latent_entropy int dup_mmap(struct mm_struct =
*mm,
 		goto out;
=20
 	prev =3D NULL;
-	for (mpnt =3D oldmm->mmap; mpnt; mpnt =3D mpnt->vm_next) {
+
+	retval =3D mas_expected_entries(&mas, oldmm->map_count);
+	if (retval)
+		goto out;
+
+	mas_for_each(&old_mas, mpnt, ULONG_MAX) {
 		struct file *file;
=20
 		if (mpnt->vm_flags & VM_DONTCOPY) {
@@ -703,6 +709,8 @@ static __latent_entropy int dup_mmap(struct mm_struct *=
mm,
 		mas.index =3D tmp->vm_start;
 		mas.last =3D tmp->vm_end - 1;
 		mas_store(&mas, tmp);
+		if (mas_is_err(&mas))
+			goto fail_nomem_mas_store;
=20
 		mm->map_count++;
 		if (!(tmp->vm_flags & VM_WIPEONFORK))
@@ -726,6 +734,9 @@ static __latent_entropy int dup_mmap(struct mm_struct *=
mm,
 fail_uprobe_end:
 	uprobe_end_dup_mmap();
 	return retval;
+
+fail_nomem_mas_store:
+	unlink_anon_vmas(tmp);
 fail_nomem_anon_vma_fork:
 	mpol_put(vma_policy(tmp));
 fail_nomem_policy:
--=20
2.35.1
