Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BC344F1748
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 16:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378069AbiDDOlw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 10:41:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378059AbiDDOkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 10:40:09 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A61053FBF3
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 07:36:34 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 234DlFTK024455;
        Mon, 4 Apr 2022 14:36:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=3Ar/Z8yjF+gGc+n32D1/k4TGMfpKuhRfX5pIPpPTukk=;
 b=zN62cDO0PSjR3nnr9gbXx+GrIkdXMkiyyrB99BGL/gYH/rQbOVymaxhUvHvkQoPzdvlF
 vhpOj7PJJtdkB3zJ7deYCn1wp6xWr1nX/xDUJf+Pm51IE9QfZQ+FBgl5T+ue0dFij+9G
 oz0hLyjSsncnfFnOq4Zkt6NMHRcwOi6JAErLHKR01yC65HursttqEFn4a/+xwF0dXqQ6
 ysJT19WRBc+ICbIOrkAKBLZoetXlXvaQZ9jtmVS6O3uJ1C7gnPM7uCYePR1At72y29DI
 xrhQgklTruVJ+8HHDZbjnvS31zEXncPaY3vUolZFLHB2NbC9WsuSgpjbBxKsCuMdUMYO YA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6f1t3cva-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Apr 2022 14:36:28 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 234EGcGF027665;
        Mon, 4 Apr 2022 14:36:26 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3f6cx2gn5h-9
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Apr 2022 14:36:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LqrSryYuHfjh5KGRYgHUZ65vVi8u+DsRatXnzy1JTl5fIzQU80Et0BHeb/xuFQkjH/OOx8I084ovpVCbj6ICHhxJOjq/qY5YgX4yDp2vUOKP/tLcLpaxuG6BJVCYWQtemXsHmzEHlI24hvkwvoXfa5tDV81v3xMiqY5ixw+VEqxigV/RIoZRxv9fXrQcT+kiwNDF+tUbaOY0gIy3cI4SUUZEjiMpi7OKH9Tt0SzkyrdwOvsW+XjotCSJr+UaClzei/f+RrT7Kz4Rcww5IZuCbXYhKUazbkiC52oMCmOoE71sqDPp/iaNBAYcM5Z+ZB3qgEePw2ivmfbDSFwzRD1SDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Ar/Z8yjF+gGc+n32D1/k4TGMfpKuhRfX5pIPpPTukk=;
 b=IEJPreMwZlf/T+eVm8BVMDn3upbm3oSbgtwg2L2xp2YonAya0GjZaam1zrPRU7KZY+34vdUGN4Fqbn3kyrGDoYJZobZXh32JaJy7UYk/5ulS+ciagVwcGk9/BOgHt94YFKPBQ0WArHuvAHLcRWkFxdTo5JnZ3Fe4tiA+3VVD0wsXb7+AsdHhD6WkJTXKl1eJGOCyFutEBBNaJ2ZoSccEQFsDgIoUSSlidYZuN3x9RjXSpSi1VsrqBjr0TksrVlHTijOKRTZzTB4ss0i1PCFPSALwJN8jX4W9gIZBGDUJrI5jv4ioRXx+J7UH1hSEo9A0uH77yVbwuvTHakZFRUsNdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Ar/Z8yjF+gGc+n32D1/k4TGMfpKuhRfX5pIPpPTukk=;
 b=0LFD0UyYQAcgohAhFgQq/S2nLMY4nQgWVlkrdKCUog90THtQJ2mYYhLGHiCS4xoJOGGGXyfmzMU3R1f0CmCtcqlbk/z/Q+OG7B5Mkj3XWi3oL1yxUI2T6EQXXiNaxdb8GKBxkqv7KCp2qfw8W9tvxFu3pCnAez69D4CYfIAtzLA=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CY4PR10MB1381.namprd10.prod.outlook.com (2603:10b6:903:29::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 14:36:22 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::74fd:df41:4c93:24a5]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::74fd:df41:4c93:24a5%6]) with mapi id 15.20.5123.031; Mon, 4 Apr 2022
 14:36:22 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v7 38/70] cxl: Remove vma linked list walk
Thread-Topic: [PATCH v7 38/70] cxl: Remove vma linked list walk
Thread-Index: AQHYSDFGd//C4e4Agk+7zkc5kW3xoQ==
Date:   Mon, 4 Apr 2022 14:35:48 +0000
Message-ID: <20220404143501.2016403-39-Liam.Howlett@oracle.com>
References: <20220404143501.2016403-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220404143501.2016403-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0b2a35c7-fe67-424b-6af7-08da16487d97
x-ms-traffictypediagnostic: CY4PR10MB1381:EE_
x-microsoft-antispam-prvs: <CY4PR10MB13814E240F23844218723DEFFDE59@CY4PR10MB1381.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qTQG2519IPOIEszKT3DP8jWvvAC2K3letnv0LBh1CO6t8HykLJEJvIPEbUBWQYvNZ/0wJvg94a7pFx7JBCGIvuRUIC8RldIfwI94obHuQhG/NDiUUrSgeN/Xy6xeK9GEUxjguBdNCjWkaos42siCGLez5nXLSiWiAFGJ1YQFGr8SJj09e/kk3Y3WT8xNeB1HokmvlVtqtQXjlX3Uc+UY7SG1XTbkR1hYwg0ZOyjyF55FYXDerMiuAkoyakhq00E1UYv0st9LG2YeeRyNWQowhi77RHJkS4ED/wzUMPlZ3R9AziE9khDxp/aUUqORxt/u5hVOU01ZvSJCbLS+FldBcm3WN/29Lu2VW8MQVyhUF7N8pW980CGzAyJzDARMsJCQ+xdjbl1Ni5FcASjHiB0wxLD65I21tMjQHDfE+tnzORO0mX7TzbILRoTUM1duXRG/MOhoeLwvvi7MpSXD0aXDtbZvntnHmSYey0g/x+YC/Vw2isvN3q35Ek/3CBsbSh4c/LNWtsFy0FIYgm8XkCTV14DComaF8sSBS5SpoAvPWCB2fdbTRXM0Pzcs5R3omGinTihciBvqolJQbKOUpcsD1HYSBdqoqZFeh5KfMhjNxaJnClRQ2UOteMITb3G61Rd7rIH6VqrdVkx9YqJUiaAQEtVeBGZTQt+D4raaQmA8yUzRYNTVG3HS3lcoEzf/0fXQLMYSPbku2bUaNe3TfvFrdQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(122000001)(6506007)(6666004)(2906002)(66446008)(66946007)(110136005)(66556008)(66476007)(36756003)(8676002)(76116006)(91956017)(64756008)(6512007)(316002)(71200400001)(5660300002)(2616005)(38070700005)(38100700002)(1076003)(83380400001)(186003)(508600001)(26005)(8936002)(86362001)(6486002)(44832011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?wckevTBmTEWQynGkQLRgm1oamNIaYyTiNQ2tYrYdc8vndr5yzlnJkRgE+s?=
 =?iso-8859-1?Q?NKbvwJGq/JgI7W33dDH/6CZTxu6lre19gKSvnuZ/WvKat7rCb/2pT/Dx2P?=
 =?iso-8859-1?Q?/ALDg/C1F8koKbfSX3bQp8lknQ6KnY7KHsuhnBBdHrVg6OiTLFHOg+zXmN?=
 =?iso-8859-1?Q?mdthKONLqwMfq7r0QBLM/Xg7nnLxttTL2u6VKr3Qp5ruzAekpUfaYq33OB?=
 =?iso-8859-1?Q?+SGWza0+6x/9YI29teB1giU67oH74BfK+EcBaS7QvhybQxHZJ/segisXGi?=
 =?iso-8859-1?Q?oZHlRlrvH8pWwZdY2TJddXnJ/BYPEvH4TxZyAhfKEAwVaYDZ3Er85hHCn0?=
 =?iso-8859-1?Q?xsKHL2U8qRNzxfJjJ4Opc7NSSbwp092FBLiRbd79tHcaTEg3zY6v6JzeZv?=
 =?iso-8859-1?Q?rftTLKs1xt5b4ZJDBQ2tPEZAzpKKqnkrGAPByhxafUyLmovmyg6upJYlB2?=
 =?iso-8859-1?Q?4XR2tmbYBPR+iq996KzZ9RcvDN2aFalKf1XttKPhgqbAwY/lz6KpBkMpLK?=
 =?iso-8859-1?Q?t5retCeX+wUy8Jo7OaMDHUthizkjXtVq5c/Yh8yy0SroQjS14A6MJGobKo?=
 =?iso-8859-1?Q?zYlZliRqTGDJClNOf/YuaUxPIRyHyPv05H+r6vUt8jK3ffUMGc6C/OhX21?=
 =?iso-8859-1?Q?8HlYgYf5jDF5jb15DtY2W16vz9Gr96vTlkjTP5+/U8UpRQcIPelr6kL73J?=
 =?iso-8859-1?Q?gsZk1boszGXtAn6PtpPuRfNLSkJ0Ruk6jSXYvI1nH3UM/Yz9DcmvhwfpkU?=
 =?iso-8859-1?Q?mY6Bxh8Y8W9XIkNyYQxlBM4gWmSQXnuidRxnSWgFiRSL6c9HSJG3MpYC6A?=
 =?iso-8859-1?Q?FT8ocmxCsjR09oL5/an7AK4QdjmYTUA6SU+rfofU4W2TDxnhPOKoktxIK4?=
 =?iso-8859-1?Q?ejqLQ9QeogTHaz8/NbrOfpN7v+us2zLOj/zWri71AXzdDK20tnQdHtAVu+?=
 =?iso-8859-1?Q?R1JixqRGeT0q1gIDQNtcP3sdcNOZ/7lqa21TSsZx/N9e3RvCsOIyj/HQgZ?=
 =?iso-8859-1?Q?YOrEPOSTFli9lFFtzykxAw/unVpTPi53/bJtSug+wtQEmK3MqRSuGkdqr0?=
 =?iso-8859-1?Q?gep+rtULadh4ZLnfX1KN19RRpFXjn1Y5jc1j5o/BDpB26SmcHbAex5IyYM?=
 =?iso-8859-1?Q?etFAEwr4uWPYY41nxQiRKl2znWEsp0pc8vOUfmAcL1Wdewm5C9j0tQVtM1?=
 =?iso-8859-1?Q?RKBf6uPAo89eyWWQW5W8UfenrUlyMa77iz1MCPT5e+RXlI7e4+1plPbimI?=
 =?iso-8859-1?Q?Pk1XlJ+xNkoQ3uKXrPDzdJiWgQ/cLx5LXWZTmDHOLDi/toSoNxbjtgrD9g?=
 =?iso-8859-1?Q?cO6m/Iq0hOLGORe61p5sVhRrvm2XBcuKQxRrpcYp3iWeUaqVmGH0ggnHV5?=
 =?iso-8859-1?Q?pr13ifoZQQHxVd8/oKMzY43f3IuId9pit/MleNr1Z18fheixZmW5dbuW06?=
 =?iso-8859-1?Q?uok1GWWdVtMa0C+JtnfwM1mQ8iOjzc+F1S/9d/RIeMKdyfXqDFWm14MR2M?=
 =?iso-8859-1?Q?NnlxJSwMkEzDnaBqvn3tV+BJZQCE+Kkxx9O4Eo4wUEbU7ED9/6r/fJvtzh?=
 =?iso-8859-1?Q?SjhHor/z2zqh2PLVQWy+s4sTtPgbcEM070FRAuWcp9LSZgu37bqCExfxCe?=
 =?iso-8859-1?Q?oZhIlWG4EfbTY99GWCIesEjhtXllKdpWsCUHvoOSz9TTaHsj4RuLRDeQ0n?=
 =?iso-8859-1?Q?/w4ZBfn51i7Scrbo+8m++FfiN3uGF+iCaNUXzLnPKnRj2/K7smIFY3hMCD?=
 =?iso-8859-1?Q?AVhc1ex1VGru5Zv7tSlF8Sz9dxR13o3+Bd4BtTEHB25Ia2VCj+0n2zzT16?=
 =?iso-8859-1?Q?LL5oyEcBzE455wI4knMdfTkXanTLPuE=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b2a35c7-fe67-424b-6af7-08da16487d97
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2022 14:35:48.1432
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B3Z13rYGmvNw+PQrvZuCRjbTXWHdu6QoYO9KCR4Oqqjq8LGfseOJpVU5CylHsOQnrUw2S6XLgJ/fbzVTbPpY5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1381
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-04_05:2022-03-30,2022-04-04 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 adultscore=0
 bulkscore=0 mlxlogscore=999 phishscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204040082
X-Proofpoint-ORIG-GUID: UMq6KUOfp8TvtaMVeI0OYXwRzldwzpMs
X-Proofpoint-GUID: UMq6KUOfp8TvtaMVeI0OYXwRzldwzpMs
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

Use the VMA iterator instead.  This requires a little restructuring
of the surrounding code to hoist the mm to the caller.  That turns
cxl_prefault_one() into a trivial function, so call cxl_fault_segment()
directly.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 drivers/misc/cxl/fault.c | 45 ++++++++++++++--------------------------
 1 file changed, 15 insertions(+), 30 deletions(-)

diff --git a/drivers/misc/cxl/fault.c b/drivers/misc/cxl/fault.c
index 60c829113299..2c64f55cf01f 100644
--- a/drivers/misc/cxl/fault.c
+++ b/drivers/misc/cxl/fault.c
@@ -280,22 +280,6 @@ void cxl_handle_fault(struct work_struct *fault_work)
 		mmput(mm);
 }
=20
-static void cxl_prefault_one(struct cxl_context *ctx, u64 ea)
-{
-	struct mm_struct *mm;
-
-	mm =3D get_mem_context(ctx);
-	if (mm =3D=3D NULL) {
-		pr_devel("cxl_prefault_one unable to get mm %i\n",
-			 pid_nr(ctx->pid));
-		return;
-	}
-
-	cxl_fault_segment(ctx, mm, ea);
-
-	mmput(mm);
-}
-
 static u64 next_segment(u64 ea, u64 vsid)
 {
 	if (vsid & SLB_VSID_B_1T)
@@ -306,23 +290,16 @@ static u64 next_segment(u64 ea, u64 vsid)
 	return ea + 1;
 }
=20
-static void cxl_prefault_vma(struct cxl_context *ctx)
+static void cxl_prefault_vma(struct cxl_context *ctx, struct mm_struct *mm=
)
 {
 	u64 ea, last_esid =3D 0;
 	struct copro_slb slb;
+	VMA_ITERATOR(vmi, mm, 0);
 	struct vm_area_struct *vma;
 	int rc;
-	struct mm_struct *mm;
-
-	mm =3D get_mem_context(ctx);
-	if (mm =3D=3D NULL) {
-		pr_devel("cxl_prefault_vm unable to get mm %i\n",
-			 pid_nr(ctx->pid));
-		return;
-	}
=20
 	mmap_read_lock(mm);
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+	for_each_vma(vmi, vma) {
 		for (ea =3D vma->vm_start; ea < vma->vm_end;
 				ea =3D next_segment(ea, slb.vsid)) {
 			rc =3D copro_calculate_slb(mm, ea, &slb);
@@ -337,20 +314,28 @@ static void cxl_prefault_vma(struct cxl_context *ctx)
 		}
 	}
 	mmap_read_unlock(mm);
-
-	mmput(mm);
 }
=20
 void cxl_prefault(struct cxl_context *ctx, u64 wed)
 {
+	struct mm_struct *mm =3D get_mem_context(ctx);
+
+	if (mm =3D=3D NULL) {
+		pr_devel("cxl_prefault unable to get mm %i\n",
+			 pid_nr(ctx->pid));
+		return;
+	}
+
 	switch (ctx->afu->prefault_mode) {
 	case CXL_PREFAULT_WED:
-		cxl_prefault_one(ctx, wed);
+		cxl_fault_segment(ctx, mm, wed);
 		break;
 	case CXL_PREFAULT_ALL:
-		cxl_prefault_vma(ctx);
+		cxl_prefault_vma(ctx, mm);
 		break;
 	default:
 		break;
 	}
+
+	mmput(mm);
 }
--=20
2.34.1
