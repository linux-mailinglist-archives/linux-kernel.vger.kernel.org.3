Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4F455AF4BC
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 21:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbiIFTuT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 15:50:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbiIFTth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 15:49:37 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19D77A2D85
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 12:49:18 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 286Id9Dm024651;
        Tue, 6 Sep 2022 19:49:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=FqnMiXGEtYZT+SVYEUkIzJyICOS/0hh0touUBBJ9Iq8=;
 b=DwVLJpjACLEHyvI58/9kal8GHpDG4gx2hbXYgjGjEPYz7pCg5geekiRllZ6QS5WbR0HN
 mXQTVocTRiR1xMPFAQWkP6BOQs9SAG/vrjHezl501oX1Sw8z+O0Y5JfKPNRVk+Wvt3aT
 z403zoJ00ZV2weA/yp+4C7wyJooTd0YL48IBtTlPatOdEHGR50ZB3HyMqWp8a3xmt5Ol
 0ho4Vq+IhwqAVE2SXWmwW/QVQX/42SvbMde25gV/uJIXvPgrofb8Sq2KYhQQwrtjHlRV
 /EinL/kXdw8CbO7bi+5cgcgNOOCJHxWKPm1VBX96gMPoQctMf/QSAtRaKNCB3CVRmZ0R SA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jbxtaet62-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Sep 2022 19:49:04 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 286JN9wl027549;
        Tue, 6 Sep 2022 19:49:03 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jbwc9kvwt-13
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Sep 2022 19:49:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j1lS7Ij1weP3GtX4p+3l2PFJ9bourbl76n9QosH2Gqrt20ssRlj4QMMAd0d11/veLhqActYvu8thPvf9ATpXTYJlJxtK/vfoZhuv+GmcFUEeo4BXMsthGfVGmGXMg27Fapezx+M3hA+OnQtMuLSxiLe3rwoNS42km+O9v74DoYKgsQhbprqHohZ/jFM08YYoZ65emEeg3ojhXFU30UrzxtiTP6tlL1E6reMK3dUVZpArURsmYJhKqF40fblHpl1o2sE14LnzhEgrBqy09fPjcrrvf9/Og8kIsnGy2RAihZg7HwR3OiwXqDQ5TwXLyVx11CrYUbx6drt1wW7mcdhyuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FqnMiXGEtYZT+SVYEUkIzJyICOS/0hh0touUBBJ9Iq8=;
 b=SJJ2j3yW7GmjQGIRRrcWFWvLZeq6aV3hx/gZN1S6AuFhdKWCIhyf50vRTSPZnDhuHxOIwGTn7PEyiNQvAxi1GJ/I9zU65JD8/c5Po2gNJEMsavltwhJX/GlYAqAD6KLy6GeGgeYveq5Pu9MLpBroFYS141BM9A7SqtP3bscSvpJjO7/Qi5iD1Od4xkrfdO6KdO+rNcKg0ZX0+Rml74DSwa8r4q9MIgZnkrXMDpIK0RYgq+6et4RvW2IdLJhjUqAIfM5a883xKdxKSjn/X6p6BzOXY47szono3+2nvQe2eFPVebFLkhYHSNW+GxUOnYWOyhIMjEK56744J0fwyw+mQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FqnMiXGEtYZT+SVYEUkIzJyICOS/0hh0touUBBJ9Iq8=;
 b=N42oT4WEPLsGOm5laVbhWHagqbAHN000DOBo3RaDBaQsPxayW7/tBIojtiF3DseJFRix8upwiinP4ve2V71Iab3oObPt0o3kQqemzybobGRe/t6EUMT9ZDz9+E0rKT/sW3ku9geEVwv2tKN+z4rihblOuulfUkjxl96LBUpvho8=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SJ0PR10MB4670.namprd10.prod.outlook.com (2603:10b6:a03:2dc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Tue, 6 Sep
 2022 19:49:01 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a420:3107:436d:d223]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a420:3107:436d:d223%5]) with mapi id 15.20.5588.018; Tue, 6 Sep 2022
 19:49:01 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH v14 28/70] mm/mmap: reorganize munmap to use maple states
Thread-Topic: [PATCH v14 28/70] mm/mmap: reorganize munmap to use maple states
Thread-Index: AQHYwimwTbVVJbpFhkeJ+pLQ9x4m3A==
Date:   Tue, 6 Sep 2022 19:48:52 +0000
Message-ID: <20220906194824.2110408-29-Liam.Howlett@oracle.com>
References: <20220906194824.2110408-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220906194824.2110408-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 457fa06e-56ca-4052-a119-08da9040d896
x-ms-traffictypediagnostic: SJ0PR10MB4670:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KnxGhBscuvY43C2PuOruKNr806Qm+kmkMedAiHHPV6jDawDISR996knUT/3jPRhN1W1YWw2VwPZQZnHGf1+BYmon2Cygnfk9EfqsobJ4uuysjCul1OT6fGCd/DLMTE0tgmnzQupTHji+htoyu5qQT+4oupbHqUgrCz5Kq9GSpSV3YuxzM+JN9tCFB1LymsjysvIYHSQIhnwGADgbfdLJgUJEHCqi+C7jimmWwaOC4/J2+fwGfb8cj6f6wkygUH2zI5ogB3akIwN29UfAKpuFotKY9bQYsG1QmPquOufRhTVLN91+7gXBjGzrEBI4yMSt7MffTlapvYUHvpDHOe0ZHo5CyDYN4L+XeOEFHgmxWmIAFEpZiDvByLdQfT9Nw+FHKGsdkpe7sux4W4NGR9CJoGQeP2YIdfqrmszKZpFVlrAEWJS0eyRStKVJtD+pWuPfGgIedZps4LwkQGv0u7ewncVPxHvZn0WRIghkfvjr8+FlSsnjFDNCTkEnsPXEBG1Vv+nrunQqJKS/yhV60UxDUbJ4s/Dts5pllXRliPfyKswXI6fhgFeIQvyi6hzyZdNTQqzbLFQJPPVQBlRAbbw9P7oD+Hd3+yGCoaHP7aNcYyKgF27Ge9mwtjowiqZwDiVnFHonu1salmrG+85x6uz9o2pwmarHQVDJPMPnD+nEwIwaZC13ruys3omgzZv81GY1aETvHL5t4fwCNCq24H0rfGIoBoSewJAj/4Ay9Vr74RjyNzWMGu8guWi27wA5z9Lv/vHCL+nn/sXLoiDRL3rDAQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(39860400002)(376002)(346002)(396003)(136003)(6486002)(83380400001)(107886003)(6512007)(2906002)(26005)(6506007)(66446008)(186003)(122000001)(1076003)(4326008)(66556008)(66476007)(2616005)(76116006)(64756008)(66946007)(8676002)(91956017)(478600001)(36756003)(44832011)(8936002)(316002)(86362001)(41300700001)(5660300002)(38070700005)(110136005)(30864003)(71200400001)(6666004)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?D5iIa4NwMDYq6GzBDhlhgVX6MfTPRFBkNs4Mn2h6frZyfJ7gIlrJjARaHa?=
 =?iso-8859-1?Q?wX3NVOvQqW6OISWo0UheU2kN+Ali2zX7xDmuTklAB/FNABbWgws9+Jzr0T?=
 =?iso-8859-1?Q?FgGO5lCAPya836qsEsCtVdB9fBtz6RzBVgYP1jbph/mpaVcEyXXTZ5m/2l?=
 =?iso-8859-1?Q?KD3pLiNyRfRCGJAM3grcYr4SMcv9FT86djORP0CX1FJoAoXx4SGNgA3Nyw?=
 =?iso-8859-1?Q?nWPL/f74bwrMNS8bgCd5b0wUp5tuu3GX8uomFKQIQR3p+bywOBzwlyCzqx?=
 =?iso-8859-1?Q?Vm8Jor3rW9hYWxIh15xFqFDB07PnrqmWraM9ADXwDZ/ZkQDwJjtcxU1lR+?=
 =?iso-8859-1?Q?HdpmvDmaNuJ6NAG3IWrwgmXMlKkICK1NjyENzGH6+aflnslTKZZF8qGCpl?=
 =?iso-8859-1?Q?MKEGj/l4fVCQHgr19lR1Tc7t+tX1ByPzfMxXL0iBkgolzQe5j9r6TnLUjD?=
 =?iso-8859-1?Q?FM2JKZQvteVpt1UthVn4IKp22vM2tTFXEqvbeoz/cmtS5ayb3pZhl7vNsp?=
 =?iso-8859-1?Q?BRTrftdRq+HUr/JdRMIiQgw3vPZSQ8eWl3pVRmf26coZ8gfd5EBFa1NU5N?=
 =?iso-8859-1?Q?MlZbhVGgzZp4PFos24/cXsarG8143aYDKA4R21LOckjSGDwUo+O/KrpQ/C?=
 =?iso-8859-1?Q?ZyCDkqP7L+RvecK/AHN2cOwznShVsdvzC64Rojjd1z4Tpl8C9+KaH8YVPa?=
 =?iso-8859-1?Q?gBSFwagKMml/wUmvIackP4HWwpK6ErTP4gXD8FngjKnCpB2Lj84pJAglhd?=
 =?iso-8859-1?Q?clGnxWlCJADjdtEI1v+35Qk6amsj/pmlK9BUHt7FIkrHRhBbFGgCu9B3XZ?=
 =?iso-8859-1?Q?fWWrboI4RudzHzYSDza0LTsrqoszHTEhP6hps6Ec2o2jKT2RrqbnIgBkld?=
 =?iso-8859-1?Q?fhSDF2ByH8SvtHydWXGXeIAJ82vdY9HLF9Ktz7vvArfyX7k1Gdfh54Xfua?=
 =?iso-8859-1?Q?t1hcJ2SgvbvO/atzbVBpYb2iq6Vpdolo9yx1efl9OVv43KizUw0HDlhwMu?=
 =?iso-8859-1?Q?jmyIVNpbp5GINIX9JbpxKeH73PaWTJYBg9CXl/ZlfdkbSSzCzrh/LhTyp0?=
 =?iso-8859-1?Q?+vCZvEUFpsooJalZOdtV8JOuOhmgyahRyol3P6msj9hXo8oEtj04d6F0QU?=
 =?iso-8859-1?Q?9KkACXgcMbMsQVfTr3KAxrUsmLxIPN8+cOq9YO+xrksuvJNy8/A+lJ2O8U?=
 =?iso-8859-1?Q?XFCQq1nCcrZcfhOR8QZKxgcQ4WXPHTDfbC2bbHTgPaPyA9GgsYMRO7PQ2Q?=
 =?iso-8859-1?Q?WfCJQW1qLF5ZwB+b4eRnvTRFx+2ITe12KJa/1ofWgL+1NVM4jelUXFauvW?=
 =?iso-8859-1?Q?vpbovco8fA4qgpUVo0UqVUGg/cXpB2FTr4MKKDB+MnfezbyC7TpmMqhA3v?=
 =?iso-8859-1?Q?BG4JeDPpxmsNWNBB0akr95X8I0EtP9TfOKBJGFYWOYTa/4LfMbyo8Ozl96?=
 =?iso-8859-1?Q?8z6cd9ljYBHxqfxkuFEbBYWSbm4ol5wHv+141KrcqZiyyUOc3mOTKyYwPa?=
 =?iso-8859-1?Q?Xv9v2J1kvtBSkUoDa2FF6IHiUvRr0XFGIjLeHINVcDGP1fZPmcVvd2++zD?=
 =?iso-8859-1?Q?4SPEBtQPWyUxqqSSN+CaY5b3dQB0E1ZVI3spAdN62ng8nVJT0Osgbhj9D1?=
 =?iso-8859-1?Q?0xFqL4S8vYX0fwm9Z3vi2bIu73UZOoDA238yWehcfjXgoF1nKcfNbflQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 457fa06e-56ca-4052-a119-08da9040d896
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2022 19:48:52.4284
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ajac4Uefkl//4uuC3OM/fW7bzwqYW4rpXR0xDNoMCjA2pqKybxT+kUSvhh2n4G2ypJG+w5MLgbDNov6qLU8nnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4670
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-06_09,2022-09-06_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209060091
X-Proofpoint-ORIG-GUID: -ygJhMkGNFoSRkcefWE42Vj40dllIcry
X-Proofpoint-GUID: -ygJhMkGNFoSRkcefWE42Vj40dllIcry
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

Remove __do_munmap() in favour of do_munmap(), do_mas_munmap(), and
do_mas_align_munmap().

do_munmap() is a wrapper to create a maple state for any callers that have
not been converted to the maple tree.

do_mas_munmap() takes a maple state to mumap a range.  This is just a
small function which checks for error conditions and aligns the end of the
range.

do_mas_align_munmap() uses the aligned range to mumap a range.
do_mas_align_munmap() starts with the first VMA in the range, then finds
the last VMA in the range.  Both start and end are split if necessary.
Then the VMAs are removed from the linked list and the mm mlock count is
updated at the same time.  Followed by a single tree operation of
overwriting the area in with a NULL.  Finally, the detached list is
unmapped and freed.

By reorganizing the munmap calls as outlined, it is now possible to avoid
extra work of aligning pre-aligned callers which are known to be safe,
avoid extra VMA lookups or tree walks for modifications.

detach_vmas_to_be_unmapped() is no longer used, so drop this code.

vm_brk_flags() can just call the do_mas_munmap() as it checks for
intersecting VMAs directly.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 include/linux/mm.h |   5 +-
 mm/mmap.c          | 228 ++++++++++++++++++++++++++++-----------------
 mm/mremap.c        |  17 ++--
 3 files changed, 158 insertions(+), 92 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 36d28090e8c7..1ac21754e5a4 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2714,8 +2714,9 @@ extern unsigned long mmap_region(struct file *file, u=
nsigned long addr,
 extern unsigned long do_mmap(struct file *file, unsigned long addr,
 	unsigned long len, unsigned long prot, unsigned long flags,
 	unsigned long pgoff, unsigned long *populate, struct list_head *uf);
-extern int __do_munmap(struct mm_struct *, unsigned long, size_t,
-		       struct list_head *uf, bool downgrade);
+extern int do_mas_munmap(struct ma_state *mas, struct mm_struct *mm,
+			 unsigned long start, size_t len, struct list_head *uf,
+			 bool downgrade);
 extern int do_munmap(struct mm_struct *, unsigned long, size_t,
 		     struct list_head *uf);
 extern int do_madvise(struct mm_struct *mm, unsigned long start, size_t le=
n_in, int behavior);
diff --git a/mm/mmap.c b/mm/mmap.c
index 8c9e526994be..6e587f4e3a7d 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2362,47 +2362,6 @@ static void unmap_region(struct mm_struct *mm,
 	tlb_finish_mmu(&tlb);
 }
=20
-/*
- * Create a list of vma's touched by the unmap, removing them from the mm'=
s
- * vma list as we go..
- */
-static bool
-detach_vmas_to_be_unmapped(struct mm_struct *mm, struct ma_state *mas,
-	struct vm_area_struct *vma, struct vm_area_struct *prev,
-	unsigned long end)
-{
-	struct vm_area_struct **insertion_point;
-	struct vm_area_struct *tail_vma =3D NULL;
-
-	insertion_point =3D (prev ? &prev->vm_next : &mm->mmap);
-	vma->vm_prev =3D NULL;
-	vma_mas_szero(mas, vma->vm_start, end);
-	do {
-		if (vma->vm_flags & VM_LOCKED)
-			mm->locked_vm -=3D vma_pages(vma);
-		mm->map_count--;
-		tail_vma =3D vma;
-		vma =3D vma->vm_next;
-	} while (vma && vma->vm_start < end);
-	*insertion_point =3D vma;
-	if (vma)
-		vma->vm_prev =3D prev;
-	else
-		mm->highest_vm_end =3D prev ? vm_end_gap(prev) : 0;
-	tail_vma->vm_next =3D NULL;
-
-	/*
-	 * Do not downgrade mmap_lock if we are next to VM_GROWSDOWN or
-	 * VM_GROWSUP VMA. Such VMAs can change their size under
-	 * down_read(mmap_lock) and collide with the VMA we are about to unmap.
-	 */
-	if (vma && (vma->vm_flags & VM_GROWSDOWN))
-		return false;
-	if (prev && (prev->vm_flags & VM_GROWSUP))
-		return false;
-	return true;
-}
-
 /*
  * __split_vma() bypasses sysctl_max_map_count checking.  We use this wher=
e it
  * has already been checked or doesn't make sense to fail.
@@ -2485,40 +2444,51 @@ int split_vma(struct mm_struct *mm, struct vm_area_=
struct *vma,
 	return __split_vma(mm, vma, addr, new_below);
 }
=20
-/* Munmap is split into 2 main parts -- this part which finds
- * what needs doing, and the areas themselves, which do the
- * work.  This now handles partial unmappings.
- * Jeremy Fitzhardinge <jeremy@goop.org>
- */
-int __do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
-		struct list_head *uf, bool downgrade)
+static inline int
+unlock_range(struct vm_area_struct *start, struct vm_area_struct **tail,
+	     unsigned long limit)
 {
-	unsigned long end;
-	struct vm_area_struct *vma, *prev, *last;
-	int error =3D -ENOMEM;
-	MA_STATE(mas, &mm->mm_mt, 0, 0);
+	struct mm_struct *mm =3D start->vm_mm;
+	struct vm_area_struct *tmp =3D start;
+	int count =3D 0;
=20
-	if ((offset_in_page(start)) || start > TASK_SIZE || len > TASK_SIZE-start=
)
-		return -EINVAL;
+	while (tmp && tmp->vm_start < limit) {
+		*tail =3D tmp;
+		count++;
+		if (tmp->vm_flags & VM_LOCKED)
+			mm->locked_vm -=3D vma_pages(tmp);
=20
-	len =3D PAGE_ALIGN(len);
-	end =3D start + len;
-	if (len =3D=3D 0)
-		return -EINVAL;
+		tmp =3D tmp->vm_next;
+	}
=20
-	 /* arch_unmap() might do unmaps itself.  */
-	arch_unmap(mm, start, end);
+	return count;
+}
=20
-	/* Find the first overlapping VMA where start < vma->vm_end */
-	vma =3D find_vma_intersection(mm, start, end);
-	if (!vma)
-		return 0;
+/*
+ * do_mas_align_munmap() - munmap the aligned region from @start to @end.
+ * @mas: The maple_state, ideally set up to alter the correct tree locatio=
n.
+ * @vma: The starting vm_area_struct
+ * @mm: The mm_struct
+ * @start: The aligned start address to munmap.
+ * @end: The aligned end address to munmap.
+ * @uf: The userfaultfd list_head
+ * @downgrade: Set to true to attempt a write downgrade of the mmap_sem
+ *
+ * If @downgrade is true, check return code for potential release of the l=
ock.
+ */
+static int
+do_mas_align_munmap(struct ma_state *mas, struct vm_area_struct *vma,
+		    struct mm_struct *mm, unsigned long start,
+		    unsigned long end, struct list_head *uf, bool downgrade)
+{
+	struct vm_area_struct *prev, *last;
+	int error =3D -ENOMEM;
+	/* we have start < vma->vm_end  */
=20
-	if (mas_preallocate(&mas, vma, GFP_KERNEL))
+	if (mas_preallocate(mas, vma, GFP_KERNEL))
 		return -ENOMEM;
-	prev =3D vma->vm_prev;
-	/* we have start < vma->vm_end  */
=20
+	mas->last =3D end - 1;
 	/*
 	 * If we need to split any vma, do it now to save pain later.
 	 *
@@ -2539,17 +2509,31 @@ int __do_munmap(struct mm_struct *mm, unsigned long=
 start, size_t len,
 		error =3D __split_vma(mm, vma, start, 0);
 		if (error)
 			goto split_failed;
+
 		prev =3D vma;
+		vma =3D __vma_next(mm, prev);
+		mas->index =3D start;
+		mas_reset(mas);
+	} else {
+		prev =3D vma->vm_prev;
 	}
=20
+	if (vma->vm_end >=3D end)
+		last =3D vma;
+	else
+		last =3D find_vma_intersection(mm, end - 1, end);
+
 	/* Does it split the last one? */
-	last =3D find_vma(mm, end);
-	if (last && end > last->vm_start) {
+	if (last && end < last->vm_end) {
 		error =3D __split_vma(mm, last, end, 1);
+
 		if (error)
 			goto split_failed;
+
+		if (vma =3D=3D last)
+			vma =3D __vma_next(mm, prev);
+		mas_reset(mas);
 	}
-	vma =3D __vma_next(mm, prev);
=20
 	if (unlikely(uf)) {
 		/*
@@ -2562,16 +2546,46 @@ int __do_munmap(struct mm_struct *mm, unsigned long=
 start, size_t len,
 		 * failure that it's not worth optimizing it for.
 		 */
 		error =3D userfaultfd_unmap_prep(vma, start, end, uf);
+
 		if (error)
 			goto userfaultfd_error;
 	}
=20
-	/* Detach vmas from rbtree */
-	if (!detach_vmas_to_be_unmapped(mm, &mas, vma, prev, end))
-		downgrade =3D false;
+	/*
+	 * unlock any mlock()ed ranges before detaching vmas, count the number
+	 * of VMAs to be dropped, and return the tail entry of the affected
+	 * area.
+	 */
+	mm->map_count -=3D unlock_range(vma, &last, end);
+	/* Drop removed area from the tree */
+	mas_store_prealloc(mas, NULL);
=20
-	if (downgrade)
-		mmap_write_downgrade(mm);
+	/* Detach vmas from the MM linked list */
+	vma->vm_prev =3D NULL;
+	if (prev)
+		prev->vm_next =3D last->vm_next;
+	else
+		mm->mmap =3D last->vm_next;
+
+	if (last->vm_next) {
+		last->vm_next->vm_prev =3D prev;
+		last->vm_next =3D NULL;
+	} else
+		mm->highest_vm_end =3D prev ? vm_end_gap(prev) : 0;
+
+	/*
+	 * Do not downgrade mmap_lock if we are next to VM_GROWSDOWN or
+	 * VM_GROWSUP VMA. Such VMAs can change their size under
+	 * down_read(mmap_lock) and collide with the VMA we are about to unmap.
+	 */
+	if (downgrade) {
+		if (last && (last->vm_flags & VM_GROWSDOWN))
+			downgrade =3D false;
+		else if (prev && (prev->vm_flags & VM_GROWSUP))
+			downgrade =3D false;
+		else
+			mmap_write_downgrade(mm);
+	}
=20
 	unmap_region(mm, vma, prev, start, end);
=20
@@ -2585,14 +2599,63 @@ int __do_munmap(struct mm_struct *mm, unsigned long=
 start, size_t len,
 map_count_exceeded:
 split_failed:
 userfaultfd_error:
-	mas_destroy(&mas);
+	mas_destroy(mas);
 	return error;
 }
=20
+/*
+ * do_mas_munmap() - munmap a given range.
+ * @mas: The maple state
+ * @mm: The mm_struct
+ * @start: The start address to munmap
+ * @len: The length of the range to munmap
+ * @uf: The userfaultfd list_head
+ * @downgrade: set to true if the user wants to attempt to write_downgrade=
 the
+ * mmap_sem
+ *
+ * This function takes a @mas that is either pointing to the previous VMA =
or set
+ * to MA_START and sets it up to remove the mapping(s).  The @len will be
+ * aligned and any arch_unmap work will be preformed.
+ *
+ * Returns: -EINVAL on failure, 1 on success and unlock, 0 otherwise.
+ */
+int do_mas_munmap(struct ma_state *mas, struct mm_struct *mm,
+		  unsigned long start, size_t len, struct list_head *uf,
+		  bool downgrade)
+{
+	unsigned long end;
+	struct vm_area_struct *vma;
+
+	if ((offset_in_page(start)) || start > TASK_SIZE || len > TASK_SIZE-start=
)
+		return -EINVAL;
+
+	end =3D start + PAGE_ALIGN(len);
+	if (end =3D=3D start)
+		return -EINVAL;
+
+	 /* arch_unmap() might do unmaps itself.  */
+	arch_unmap(mm, start, end);
+
+	/* Find the first overlapping VMA */
+	vma =3D mas_find(mas, end - 1);
+	if (!vma)
+		return 0;
+
+	return do_mas_align_munmap(mas, vma, mm, start, end, uf, downgrade);
+}
+
+/* do_munmap() - Wrapper function for non-maple tree aware do_munmap() cal=
ls.
+ * @mm: The mm_struct
+ * @start: The start address to munmap
+ * @len: The length to be munmapped.
+ * @uf: The userfaultfd list_head
+ */
 int do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
 	      struct list_head *uf)
 {
-	return __do_munmap(mm, start, len, uf, false);
+	MA_STATE(mas, &mm->mm_mt, start, start);
+
+	return do_mas_munmap(&mas, mm, start, len, uf, false);
 }
=20
 unsigned long mmap_region(struct file *file, unsigned long addr,
@@ -2626,7 +2689,7 @@ unsigned long mmap_region(struct file *file, unsigned=
 long addr,
 	}
=20
 	/* Unmap any existing mapping in the area */
-	if (do_munmap(mm, addr, len, uf))
+	if (do_mas_munmap(&mas, mm, addr, len, uf, false))
 		return -ENOMEM;
=20
 	/*
@@ -2845,11 +2908,12 @@ static int __vm_munmap(unsigned long start, size_t =
len, bool downgrade)
 	int ret;
 	struct mm_struct *mm =3D current->mm;
 	LIST_HEAD(uf);
+	MA_STATE(mas, &mm->mm_mt, start, start);
=20
 	if (mmap_write_lock_killable(mm))
 		return -EINTR;
=20
-	ret =3D __do_munmap(mm, start, len, &uf, downgrade);
+	ret =3D do_mas_munmap(&mas, mm, start, len, &uf, downgrade);
 	/*
 	 * Returning 1 indicates mmap_lock is downgraded.
 	 * But 1 is not legal return value of vm_munmap() and munmap(), reset
@@ -2978,7 +3042,7 @@ static int do_brk_munmap(struct ma_state *mas, struct=
 vm_area_struct *vma,
 	int ret;
=20
 	arch_unmap(mm, newbrk, oldbrk);
-	ret =3D __do_munmap(mm, newbrk, oldbrk - newbrk, uf, true);
+	ret =3D do_mas_munmap(mas, mm, newbrk, oldbrk-newbrk, uf, true);
 	validate_mm_mt(mm);
 	return ret;
 }
@@ -3116,9 +3180,7 @@ int vm_brk_flags(unsigned long addr, unsigned long re=
quest, unsigned long flags)
 	if (ret)
 		goto limits_failed;
=20
-	if (find_vma_intersection(mm, addr, addr + len))
-		ret =3D do_munmap(mm, addr, len, &uf);
-
+	ret =3D do_mas_munmap(&mas, mm, addr, len, &uf, 0);
 	if (ret)
 		goto munmap_failed;
=20
diff --git a/mm/mremap.c b/mm/mremap.c
index b522cd0259a0..e0fba9004246 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -975,20 +975,23 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned=
 long, old_len,
 	/*
 	 * Always allow a shrinking remap: that just unmaps
 	 * the unnecessary pages..
-	 * __do_munmap does all the needed commit accounting, and
+	 * do_mas_munmap does all the needed commit accounting, and
 	 * downgrades mmap_lock to read if so directed.
 	 */
 	if (old_len >=3D new_len) {
 		int retval;
+		MA_STATE(mas, &mm->mm_mt, addr + new_len, addr + new_len);
=20
-		retval =3D __do_munmap(mm, addr+new_len, old_len - new_len,
-				  &uf_unmap, true);
-		if (retval < 0 && old_len !=3D new_len) {
-			ret =3D retval;
-			goto out;
+		retval =3D do_mas_munmap(&mas, mm, addr + new_len,
+				       old_len - new_len, &uf_unmap, true);
 		/* Returning 1 indicates mmap_lock is downgraded to read. */
-		} else if (retval =3D=3D 1)
+		if (retval =3D=3D 1) {
 			downgraded =3D true;
+		} else if (retval < 0 && old_len !=3D new_len) {
+			ret =3D retval;
+			goto out;
+		}
+
 		ret =3D addr;
 		goto out;
 	}
--=20
2.35.1
