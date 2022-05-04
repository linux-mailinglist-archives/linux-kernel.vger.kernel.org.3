Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E76C51936D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 03:23:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245430AbiEDBVs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 21:21:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245357AbiEDBTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 21:19:02 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AA3F443FC
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 18:14:56 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 243KnJSF013484;
        Wed, 4 May 2022 01:14:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=7Yn9V/1cTpY9CxoJnkNHIjhQ3Gvdb8BYbJIaBvjK20U=;
 b=MX/Mt+aiksR8+9b7Hip7Jwjz2b18U8gugyioNPt4kEkIfrPaUbDKInsmDR1lw9XSr2EM
 L+SYZOH88QxmThlXdDe+BQ5Gr/YAtrnPW+v9SG1D+PISpy51ttMcK2xg+GrsO1hIGisr
 FiG++u8XkMWGssz4hKxa4ALucA73WZ+PcZQGeULiM3g4mUQtRwmja/58nomJUWxFPPL4
 Jck1/TOkHypn6pZqddnwxypT6svpq81f97OoIYEWt78KsxdYpz2vnKyFOfqIjcEuO9Lq
 FiAVNqj8vY5Hvvbl5YLiKvRqmWJq5ibYJZ+v+U/477C633/jUmNJ5IUk1RHCKoQ8taO/ hg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3frvqsf6fd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 May 2022 01:14:40 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 2441BXQv013207;
        Wed, 4 May 2022 01:14:40 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fsvbmv41r-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 May 2022 01:14:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EdhKywSsE1S9J0G3chjP9X6iylUBIIGO2TFBNWIyuN/cQyGTrA3SYn+Qub1xFKOxxx40Czff6IEqfj3BdpuAysoQOmEMJm+FVehLUhMViKfYvX2i+MlQeAp8WcIBEtOwr/NCeprtJO3CKEYPgxO+2T0zGfGuaNd4MBFDuPfjzvLRLYdJDpKyaRJ2gU6UNwHAxrinmcgc4sjma+nyMuc8zi+bj5wuuSVt0JMt2NQ3xXE+4OGRHoNm0bizfIV1EurKIifxbM7P64+bHVXqPo02oWDECA0CwOK/ZSkabwScQGCW1C3QvZtUz6e5WXxtmUkWXgH+Q3aTBmEjKMdIqgQZgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Yn9V/1cTpY9CxoJnkNHIjhQ3Gvdb8BYbJIaBvjK20U=;
 b=aYuabL9SlIpafQxDp3y8st1ApaMR1/P9ySAoKWhjSKFn+D3D9u3fzPXPL23BedkKk48XV7XBy8nMg39kP7ACYK13O28/YLiO8EXFpN9Me9A7eDLP6mhUdTi5NpUmaj6IOF31UE1tpDo5NLt3P1twfLNzNUFxtotGeQoGyZNU57QmAMbbkXqI0gZMedFkBWVI8AT8E2twwkZYFdQFjvZqKnkPnykb9y8r1U8sBGOTEAuSHjRoab+tLrCugCenJ1Vxm945HoDv8P+G+zBh9hgevgrwi5pzftFHuyPfkxHzqSmAUoaWoUx09eYifmeCusqJ06AJ2oGcuGwKZa5QHzn2OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Yn9V/1cTpY9CxoJnkNHIjhQ3Gvdb8BYbJIaBvjK20U=;
 b=DGAnHZlSvTVuZMrK1j/GXIo8bqWK9pVBx6hmchplR5uZqBISqEjCY+1NL3A1kIyLbkfhqnESALv0h9sBhnWETOr9YD61IMk/KEpFN3B8Vj+IT4vBkWlQD8iSGlqqIK0GAlNNihgF+KEEwcvXQWjhnAgTarjVKDcjgyUbfCE8lJU=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SN6PR10MB2688.namprd10.prod.outlook.com (2603:10b6:805:4e::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Wed, 4 May
 2022 01:14:37 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5206.024; Wed, 4 May 2022
 01:14:37 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v9 52/69] mm/khugepaged: stop using vma linked list
Thread-Topic: [PATCH v9 52/69] mm/khugepaged: stop using vma linked list
Thread-Index: AQHYX1Q9bf9C/gs9X0Wx+jxWdBRhTg==
Date:   Wed, 4 May 2022 01:14:02 +0000
Message-ID: <20220504011345.662299-37-Liam.Howlett@oracle.com>
References: <20220504002554.654642-1-Liam.Howlett@oracle.com>
 <20220504011345.662299-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220504011345.662299-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7c0442e6-7800-412c-631c-08da2d6b7532
x-ms-traffictypediagnostic: SN6PR10MB2688:EE_
x-microsoft-antispam-prvs: <SN6PR10MB2688811E05DF01CC3A032D12FDC39@SN6PR10MB2688.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YJGZ4YI5jZi35va+SHehdzGKCWYnPLoqx81JcYJuaxFq6USxs9QzY4XeoOH+Wa1Rscv5v50xsBlX9qURl1ryOpskGnM+rFbutM9Fwn4uCtRrXhsnn2ELias4tS9mY73lzbbaXUpVvCsthAZkpzl0AuyplMDUadRSD1PbdvDcPM9NYp/AvaWo88+St0hTKO4KR0ipQB0iwZP7SdM1o5xFdTMdXC3AcdEWLOU4geAcezJhQA4e26aYhuZs+FnDLL7PY6IEk7Y1FnDzrbrF+dzgu33NLBh1kGJv4OAHF1VV+YDXJ0AblUe5ughlPqrHJjUl0PHU3QXXNZbfAJkNEe1T784deSEFFnyyW9Vm39tTvmjESRuoi2dIwvkTDieop8csM7mZ090dpHat4wOt3H+zqgFkpGQBBi9yKueYCBEE3iVSZSQUKJO1J3AKvSqoHhaRAAAOFLS3VosH2Cry7owZyjoiw8aEfVrv4uWpsh6L38t3OTh9uD1XbYl8gTKbEYUL/GNEawF6/k1LvTYarGFSvnBa8AA7Wl4lpe3Cy75FjjvCco8S1e2acYBtcV2TX3xL9JqcbgAW/WPm7xrw1HNW0n7sBCoi+BvUpwcGHmQcWuIqo8P5YP3E3gJ4ezBxxtfHJTjPyGY6Cl2e2qMiXqLC7TR+OEfDOitxzqip2RF+SE8Px+BYmu72wIcoVF39UOkXll2XRuO/CYfoIfLt99VbuQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(122000001)(1076003)(2616005)(66476007)(8676002)(66446008)(64756008)(38070700005)(36756003)(316002)(38100700002)(66556008)(66946007)(76116006)(91956017)(110136005)(26005)(6512007)(71200400001)(8936002)(6666004)(6506007)(2906002)(86362001)(5660300002)(6486002)(508600001)(83380400001)(44832011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?yJe9CcPCywcl5ycNLyCj8gT6YjiaUBvPXoJyczCAOrArHOyWI20HLxmhiY?=
 =?iso-8859-1?Q?HCqaKDewYBciF4HxpB2kRA137ZgcN+PX7iTjg2TctOLjWyS85n7H3FrLE4?=
 =?iso-8859-1?Q?XbLKAIZ304gajb6H1VyXf6/uL64qF/N5PIGm4eON+Bc3RCAkJwfYfYMLnY?=
 =?iso-8859-1?Q?iHSDY1mrpdASnbBAXIVTE/cqjtj7ir1Rfcyr1uwZD/tX9HDcql3Y7zXBiq?=
 =?iso-8859-1?Q?XchMJ4h4SaeSSM7/c5YPnqGut6L5YjXHCDOnkxuBlNzyl185LRrhijdKxT?=
 =?iso-8859-1?Q?HEqCr701BPJpxLFpjTKUWvZG3lOgZGQGXSzhB4OCYES5bCc/z9z60PJ+ot?=
 =?iso-8859-1?Q?Iya8kYBH6GPBWd+XzVWnURkh0ca6CxNgUe3fIE4rhSIlUPyGR5xiCNCazo?=
 =?iso-8859-1?Q?20wILpPfIvWPe68h43ZMxK274wH3xICRxz9XW5i1t7/dlzi2WazPQt1ApY?=
 =?iso-8859-1?Q?4oWbB9ECigKd6xEvkylhmgCxvOq2OmuHyAhJ5HVRuNupf6xdhOiZFG7zIs?=
 =?iso-8859-1?Q?7/A27rB9u2qUgSycVT240DLKRKhmnZMzZ1tTDf7tTMbbqBTb5s6QMdkB5t?=
 =?iso-8859-1?Q?zHoAypXwcS6g0Wk9hcmFLr14bjA02dFL+jNGYh+KAfsctDuvpoTA08XyPf?=
 =?iso-8859-1?Q?u4evLTv9APCX7xXE9xoSTw0nTtWfPKb8Lppc48Y1TKOie9CoY3pv1kcDMC?=
 =?iso-8859-1?Q?cBIFbdDX5rQnVGnWzTrUnz33rJb7VL6XXiEF0adtOukj0zPEr2d6UAl8Vd?=
 =?iso-8859-1?Q?pvmBQQsP9Y8gKNV5KOQHFc8i4K4XkLhaFWPNV/C8pyDh5t5JwfReqT0tjt?=
 =?iso-8859-1?Q?FqOzTmcb7sOtY+zNUPQ+DOjgowQrm/Zwx/UUP2JvlyQz00H/+qZzhe7dJu?=
 =?iso-8859-1?Q?Tq82BJSnPoIrlWYwKI6ucOz2jdQp2GZnznNhk3nq7eL4t7FUQ9l07zKLuQ?=
 =?iso-8859-1?Q?QSLtsKqqa+MplFzbxr0UgW5G/6p2aAiyHVNO7AkQud8yUMmC4Eo2SoM9VT?=
 =?iso-8859-1?Q?sMVGT/yFKj11cAZ+YusYXFsjBvJr0EXcokoRJpQ2iq5ZxOKzeAkj1wvfcN?=
 =?iso-8859-1?Q?uR6AeE7R5zLjGRCq23jTEJ/CuiQgP9lCMBf+vSMUeodMYf+whEyEso3Qx8?=
 =?iso-8859-1?Q?a/fs0YTC48Kvs+uf1IU2V8fb1VlvnK6RoYvvsdupv9jkVaUBIMAmrrpn9y?=
 =?iso-8859-1?Q?zd0J7ltLzd3QavprcOICBjKs4QfQw1hHTudZFbB2ooPO7izXJXWlAtszro?=
 =?iso-8859-1?Q?bm9GYjKYKlvb2rXU7NNKcpxCbBWsU9Vx4v/9nNdZphgD7jFfbf6MUhPUJ7?=
 =?iso-8859-1?Q?o7ujd0zlxbNmPw1cuX+P3z087bAF0xQpGBoUXevFqMRHSVyHZNap/kejyu?=
 =?iso-8859-1?Q?1S8KHIcEoXBI0CeRGvQuEPiLXX6vDMzMHmh/lc7LxvN24bW+iX64jQc/6Q?=
 =?iso-8859-1?Q?qbMACwVoRm7sHrKsc+NTbeinUAs5CZPNxm69yOQfjEL4KTK4C7zP1FcZmb?=
 =?iso-8859-1?Q?R++9LNmQa0Cethx2lcuPb3wRCLoBJ3HYKyjciH1gLLEgrjHBn+ctJ8PpJf?=
 =?iso-8859-1?Q?GgKLzYyKnV8YkQcA2rGrVYJeARd1JRHoLla0Za2fpi974qLBd51zbwmMQt?=
 =?iso-8859-1?Q?O6rAaWd3Oq4jwllp7Ic41ydbYBmyGbA2uhes9hJLgHaLysoJZzgnyjPX2E?=
 =?iso-8859-1?Q?4DI/E5DalZTKjCHy2hPNoyXxjl9evopmsNhkCPs1tFrsbXsrYWlC12tBCI?=
 =?iso-8859-1?Q?zCIzBKYA3SkatwvqI9iQt0yATcCALgtmfjc4DYNFijVxbZcnmOV646bXh0?=
 =?iso-8859-1?Q?f9le8xrtQqnxkb7Dhp1IBqg6DW/zpPY=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c0442e6-7800-412c-631c-08da2d6b7532
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2022 01:14:02.5013
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vPJBG2lz+lG9QbCHqciMYk6WKuTGokjlAzKclcIyb3rqPNzWApY5zeTDqpFyjZXKHvfOPXqYVXzKJb+A3Mm0Dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2688
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-03_10:2022-05-02,2022-05-03 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 spamscore=0
 malwarescore=0 adultscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205040006
X-Proofpoint-GUID: 09lkM9QnYoqPZ40tU-qhDICuYAKoCUCJ
X-Proofpoint-ORIG-GUID: 09lkM9QnYoqPZ40tU-qhDICuYAKoCUCJ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Use vma iterator & find_vma() instead of vma linked list.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/huge_memory.c |  4 ++--
 mm/khugepaged.c  | 11 ++++++++---
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index c468fee595ff..c72827d9cf04 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2221,11 +2221,11 @@ void vma_adjust_trans_huge(struct vm_area_struct *v=
ma,
 	split_huge_pmd_if_needed(vma, end);
=20
 	/*
-	 * If we're also updating the vma->vm_next->vm_start,
+	 * If we're also updating the next vma vm_start,
 	 * check if we need to split it.
 	 */
 	if (adjust_next > 0) {
-		struct vm_area_struct *next =3D vma->vm_next;
+		struct vm_area_struct *next =3D find_vma(vma->vm_mm, vma->vm_end);
 		unsigned long nstart =3D next->vm_start;
 		nstart +=3D adjust_next;
 		split_huge_pmd_if_needed(next, nstart);
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 03fda93ade3e..208fc0e19eb1 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -2089,10 +2089,12 @@ static unsigned int khugepaged_scan_mm_slot(unsigne=
d int pages,
 	__releases(&khugepaged_mm_lock)
 	__acquires(&khugepaged_mm_lock)
 {
+	struct vma_iterator vmi;
 	struct mm_slot *mm_slot;
 	struct mm_struct *mm;
 	struct vm_area_struct *vma;
 	int progress =3D 0;
+	unsigned long address;
=20
 	VM_BUG_ON(!pages);
 	lockdep_assert_held(&khugepaged_mm_lock);
@@ -2116,11 +2118,14 @@ static unsigned int khugepaged_scan_mm_slot(unsigne=
d int pages,
 	vma =3D NULL;
 	if (unlikely(!mmap_read_trylock(mm)))
 		goto breakouterloop_mmap_lock;
-	if (likely(!khugepaged_test_exit(mm)))
-		vma =3D find_vma(mm, khugepaged_scan.address);
=20
 	progress++;
-	for (; vma; vma =3D vma->vm_next) {
+	if (unlikely(khugepaged_test_exit(mm)))
+		goto breakouterloop;
+
+	address =3D khugepaged_scan.address;
+	vma_iter_init(&vmi, mm, address);
+	for_each_vma(vmi, vma) {
 		unsigned long hstart, hend;
=20
 		cond_resched();
--=20
2.35.1
