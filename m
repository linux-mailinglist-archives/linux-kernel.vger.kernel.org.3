Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8C6557734E
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 04:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233004AbiGQCrX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 22:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232796AbiGQCqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 22:46:54 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B1E519C0C
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 19:46:52 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26GJ8glT009607;
        Sun, 17 Jul 2022 02:46:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=30/6HYbdVygKHeya+QZ2iBH71+fXOfZzFlWpdKphHbA=;
 b=AxwHJNNwv0hCPNtuWs1jv8Wk/e/LD8aMt01h8gxkSBlZNTEfAgSmJQP89Uday0WRjby2
 2+8IeJELsAqs06gPQWLVgNCKc5YhG8mKi6EbfVuv147g6Z1Grqg7P5+qjPSe9Ax71Eqg
 33ZXUcFQ7FamhaxNckuQfVpkrCxruk3LkiYiBGR3pVgNCC6/JpU5I1XQPmSUky0Eqjrv
 u26wDdWguQYV5jwauVHMrWRLibQsYK2p0ige+ZI6qExQzfEgeyk01Q6J9Ivb8jQN1lSR
 jzpOE4NqQT7iDAXWarTHF+Q4ii87e+umCI1LpDGEupSA6CMIT3fxoMMyqzFXFXCn/mPn Ag== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbkrc0yn0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 17 Jul 2022 02:46:45 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26GMYImT036151;
        Sun, 17 Jul 2022 02:46:44 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1ejp63m-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 17 Jul 2022 02:46:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IQzuqPCnh7GuMEdgPz9ARbm7feKMxmLfNoD+yAS03X1PVtWujIDfhVuvYMekq0cX4i10WtX891UZ2gmk8roQcMEgwyJu/FsqvWPqSQFj/7h+ZefAwON3dau4s6pX/Gc8NZYDRn/XBMwlv0qoH67YME0trSU20eYV2WfSynzlNI8fpsPTYw6CAIxqUHYbrNS5YkGxmyHtBC4xiKsZJUqadRpQY0+nD7sQktz0Wx0Euzb9dDQYh3PD/CmVQEejiStrVCVdTZ0CvnTkMoja8OxEP25lUX/7oCIwsvGDv/XQKLpz8Vag7KD41MvZdbGXP3J9HFfB1GHuyptKCaLo6RfOBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=30/6HYbdVygKHeya+QZ2iBH71+fXOfZzFlWpdKphHbA=;
 b=i1L1+gDscUneG/DQHVaW7vI7KUQzIjx429b2AYZVDoHfEeCq2xXuO0gzQ+ES7D1j+7j4Ppi2FUzBbiWixAoWny/23ihDitYWCfFmgqtQhetYkMCVnB/GerHOjiUNZ20Hc0a6FCQ4XLLMx0Q6xOPvGKbcZ0Dx3w1j49HCXRZdx2LShhOhzpRIUAIpuPYda4tI/KwznPjAs5RdGL5hOy8oqfpX+n7wNK+zAiGWQl2E9PzQi0tS6jic7gl0lwYBrD/2W0QP7FpRi3JdooUiqE0QTquHLeWOAWXcIziUL++dgsLRjLaLtfK9gFelhqYK0ELNcwgFCq/4grUMzKKBnC++Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=30/6HYbdVygKHeya+QZ2iBH71+fXOfZzFlWpdKphHbA=;
 b=WjLhyi/PDlml1WEPdwGQUmjJ12D6EVFJjfwU+/4ehSPlt/eMByqEWOIoJ1HfHRJoQ7Xi7+dRrd0A2Wa7UbQ3vCmlTmwy7RNubW1crU/23E2PPdfrJv+5dx5UmVEe+xpeaaw4xxq2dEUQ3WEf4ENVniAqEX2MMVHPQo/+UunPAq4=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM6PR10MB2908.namprd10.prod.outlook.com (2603:10b6:5:6e::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.17; Sun, 17 Jul
 2022 02:46:42 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68%6]) with mapi id 15.20.5438.020; Sun, 17 Jul 2022
 02:46:42 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>, Hugh Dickins <hughd@google.com>
Subject: [PATCH v11 11/69] mm/mmap: use the maple tree in find_vma() instead
 of the rbtree.
Thread-Topic: [PATCH v11 11/69] mm/mmap: use the maple tree in find_vma()
 instead of the rbtree.
Thread-Index: AQHYmYdwvhT9MF1FsUWZ8qcH7jZeHw==
Date:   Sun, 17 Jul 2022 02:46:40 +0000
Message-ID: <20220717024615.2106835-12-Liam.Howlett@oracle.com>
References: <20220717024615.2106835-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220717024615.2106835-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5d951392-9c2d-493d-68af-08da679e94bd
x-ms-traffictypediagnostic: DM6PR10MB2908:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TLbH6DlwF0SVG6jvK4LZ5bvYTUONTxgejlVbwvQ3fpjRS+PdPcrzTmZjY1n/PanO00P55+cTtby5/uamwuGlfTtJWb3rkILRtKCU+Lb8VOZTo7d4VSR2I8tVDSMIy9FqN485jndhRdBUY364fpyd7YEphWXXxhJ8vKeqUc3M5P2UzQ7gItG8rd053fW+qBflQLcyjxESL5n5Q7+dmL1BX/tvTSvdKbY6rYbpwblsBetRHrAcoKO/hXWG4kXPP2QfzcC4rIhhfTst5ebegj2f6WJ5XlCgqxeJiUSzDacZP8F8nzOqgGIAacTn9zaDO0dUkaNP4CAOBxezfl7S6R9SPAI+sSFdGQyOvzggU45sOwJSlK9my4MgdDnGNT3bOSS7RSR+brHh/tvEeObD6azbTcJvdIwfs4qQkAost/gTkse2mCF7pTRGTBSOWZ+cFs8nkwH2QzCNu8sPKpRu0jZgT0RS5sEDpBFMlXTuMayefmrCHK2L5v/J+X7lh+EGQwTifAWdUChtkJauIATsC3pl739V9pWHAPcuEjBlfFTK18uuLw+xcDuRFwxSYNfIibcrssrlihJmBmRE8h+crDbcW3/BmevSt7e2mUCwYjKl0Sdtd2HwzOXQIKZQ/LpL0CjF15lSd0DHuKQvRImZpwy3eNDTyv24//mVAQRMoQl/0Dd8Kv0OSDitqzX6o3Y+K7i8fGqgid1oq9UB/e3OzNqOl2NiY9nfhwbIPlDwRqmWHCTnv8RGYM3LF/4c8jwfu+/junRbL0pajVuCEBmrlmxryXFR/A1dFdQHQZt0ufsW0dSyBGAdVzqsplWgH2i+rcURKgotdA3RJbo6+/tnhFEFsr8c2wWDoQtdt+SLEeKjEWMm8k2F5gZ4Jc/BPwygtRM2OOS84k13Ango3aWVNDvG3w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(39860400002)(376002)(396003)(136003)(366004)(5660300002)(122000001)(86362001)(38100700002)(38070700005)(6512007)(83380400001)(186003)(36756003)(1076003)(2616005)(6506007)(71200400001)(8676002)(110136005)(316002)(41300700001)(966005)(478600001)(26005)(91956017)(6486002)(66446008)(64756008)(66556008)(76116006)(66946007)(2906002)(44832011)(8936002)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?tWXq5TpsHKIpVZSzTWtVNvW2gnI43sGHCGTrXmPR2f2RMDNq6TNXytPJ7s?=
 =?iso-8859-1?Q?+zJo49GcE6R3k9Q9CWrLq3HwwAK/bq+HrZMuKmaMiMkivdHRJRh3buwOZ0?=
 =?iso-8859-1?Q?u8SJN5+KqkQc3RuubqSLi9HA5FN45Z4qz9umzVzKY/6jTev2XAlipDPGT0?=
 =?iso-8859-1?Q?0tPcc8U/q2MhXDb3k9LrddIpiX+9V7uxDoEUYXalRT3dakiA0BkopPv50n?=
 =?iso-8859-1?Q?gPIwQ8IxNAYJotPWJ9m91sn6U0x9r8eP0hET3sCJ3R2a2KnaOocY4UVTl4?=
 =?iso-8859-1?Q?AoAgrVl/TsN6OX39FmJYdIjulDlEfabMMpjOdueGpheFlroN2WxkZbTD5E?=
 =?iso-8859-1?Q?k+3c6xa6pnnrfgL57ftksncp7N0LtStZmcEGU3X8iuHlBob+oD/w3jyn1Q?=
 =?iso-8859-1?Q?cPr1HYueTQV1vz/QKT+8V0EllK60qp//o9hKfJWKtDkPqKtJeNbUe95Tml?=
 =?iso-8859-1?Q?JtUiuL0xHy95wn3jkJNoeeMqKxJ7So5rSCbv62HohQZ2E4x0VmY0anI56o?=
 =?iso-8859-1?Q?gO2QHDRRowyYiYX1uNZzf19tUwwIROUmlnvFzwvSroGtrhRwfisBfHPC3O?=
 =?iso-8859-1?Q?abkRpV7qTR/VA2fD79AIdmOql7fC8ULr0+7oIzuDAwL3VE+LNSp1wlzn44?=
 =?iso-8859-1?Q?JfxRXZeiims8PxL7TogLcrsakjmnt2shECtet15bFPdyiVrTxhWopKkwr7?=
 =?iso-8859-1?Q?Qtp6jE2TqBeFkcxAO2bOUabRLfiZNt8scGFehx0rUrv6uXHfGma6ptpHQ9?=
 =?iso-8859-1?Q?jLULB3lM8Y8Qqv/ycb/7DkDVsIUd8aj5XAKfbwCZ0c40munLI9qyzMmzeZ?=
 =?iso-8859-1?Q?F1b1IvVrfXFG2VisRhcKe7+BEyShYzGqi5B1/d4ZIck6i/XgNEct4hY/MD?=
 =?iso-8859-1?Q?ZKQDWfTRi/cMaMjgs+0VH/VgRvfY3tGiMd/dqdlAdVIgEtAwo6+GcEraQV?=
 =?iso-8859-1?Q?/ScTLxJEuTBg/WIBuS3gQiibwnQYljSRiypT+KJHL5doQ2F5pHkWz6ug+1?=
 =?iso-8859-1?Q?Y/fEswXL4uWRpRBIm1Ofb1GSChnqtIdF9vKEM+x8Ga7pkMlBx04IVIrdm0?=
 =?iso-8859-1?Q?owPaNDUQtZrDz/ZvnKy2g4WmfcNGmd/PtnQqcjgnWB7bGANUCoVEwE0O7f?=
 =?iso-8859-1?Q?eP+2tGwMOqibqRBsEqoCn1GOrQdWuBxqlUyuiddTzVlbySDjwmz8OthDq2?=
 =?iso-8859-1?Q?s0zmxauwh4/q1V0ZwTME+GlK00GFfRVCb8pnZybyn0Hdsam0tqar3wLDRM?=
 =?iso-8859-1?Q?GhQCqu3umZvFH3QnoFQUh9wASOtiR2pYwaw64chH3yCV2m6xwWJH7klZgT?=
 =?iso-8859-1?Q?hQfVNaODl7PO4xGfDKsz+H+A3LchVxiSdCyTXKvEgmx5ZU0w/8NWYox72N?=
 =?iso-8859-1?Q?2L8/oSPu+ufhznN4jd359eNOCHanP3CRP1fe6L5+D0cxQLnrcRmA3BNuNH?=
 =?iso-8859-1?Q?4pQ4ttRmFn+yPdIO0gQlRyTnsNph9NvM/7+U3J26u7e4OQ8a61eucr5SeY?=
 =?iso-8859-1?Q?06HdgZ/dhOTeBx36W6Y4wXR72ip8vbm3/E3V9hLF3YxEPSpNkYPu3iKxie?=
 =?iso-8859-1?Q?jCpO5whXK8IC8+dCzv2/1iXglZda/AC3VbT/ZnplfRKvq8mY4cTm5944wp?=
 =?iso-8859-1?Q?pXqc/k2ByZYpcVOuIhCosFN/inCst4hLrURgbCl5yKRS6KEXsn3BYQUw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d951392-9c2d-493d-68af-08da679e94bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2022 02:46:40.2720
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WoeFvqi8zKTP970W8eF7RrTAsTZxDDWL/qECUecSNr6cN13oomiPu7RCPU4Yy4P/cp17BChpE3j/znTtEOtaMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB2908
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-17_01,2022-07-15_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 mlxlogscore=876
 suspectscore=0 phishscore=0 adultscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207170010
X-Proofpoint-GUID: KH427pTFsIXuFq3FZb3T8oPylWgvmXQc
X-Proofpoint-ORIG-GUID: KH427pTFsIXuFq3FZb3T8oPylWgvmXQc
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

Using the maple tree interface mt_find() will handle the RCU locking and
will start searching at the address up to the limit, ULONG_MAX in this
case.

Add kernel documentation to this API.

Link: https://lkml.kernel.org/r/20220504010716.661115-13-Liam.Howlett@oracl=
e.com
Link: https://lkml.kernel.org/r/20220621204632.3370049-12-Liam.Howlett@orac=
le.com
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: David Hildenbrand <david@redhat.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: David Howells <dhowells@redhat.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: SeongJae Park <sj@kernel.org>
Cc: Will Deacon <will@kernel.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 mm/mmap.c | 28 ++++++++++------------------
 1 file changed, 10 insertions(+), 18 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 1ba4074c75cf..96ff32ff97cd 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2494,11 +2494,18 @@ get_unmapped_area(struct file *file, unsigned long =
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
@@ -2506,22 +2513,7 @@ struct vm_area_struct *find_vma(struct mm_struct *mm=
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
