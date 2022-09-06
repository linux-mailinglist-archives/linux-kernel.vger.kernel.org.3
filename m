Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C8465AF4BD
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 21:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbiIFTud (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 15:50:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbiIFTth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 15:49:37 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E4DCCA
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 12:49:21 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 286IcraQ007592;
        Tue, 6 Sep 2022 19:49:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=0GSLii26ZNPdUUHjSJacIsekeeXXTvxUbZO6CEIRwss=;
 b=3VkIHC/gnyqCp8GMiHKrp0NlqI6f1tmky4zzKRGSU3LaaM8fnV0BHXkWYTsTLG5Mpe90
 m+DcwGDYMRbe5bd8D5FcM7v7Edo6R7VaWmLGX1pWXh7RLwmB0DTVI+DEsxlQB2KCJ89b
 GlGuIzxzQkVIOCaW6i/2kuwSj37j7UVUVm8z9oZlcvWGOSr9u7TXcaAy6XSdlNoSZnuV
 fi3GzPoDhP/Z/7n0aTlUWjY6wg+FW3wdexc7ibu2h+CF8QLl6OvwFABvfdo9p0awOS3I
 5UTWMJwH3R6fVBN0Utrj2/EV++LXuhvoHyvS01BJjwXb4W2M/EgBpak6LDz3RKkSNsjT IA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jbwbc6un2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Sep 2022 19:49:01 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 286JN9wg027549;
        Tue, 6 Sep 2022 19:49:00 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jbwc9kvwt-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Sep 2022 19:49:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bMhh1ykZgy72qXFqg9xMggfY4xmEIO4m7q/3AdAfezqdbsQOOEbEHhqwSgVduf0WIpdofhA4N5Z9new+70HoZI5mveCcDkrD6mL2dqXAWXBUGfvknfxu2oagszKcOCoXesGv2bcNO/P/ey8jkcp9KiX7URdPq8iJ1YJP6XqXBtJ3EQYXEZwAtdxIK7Tc63SULUr8aedgQVdVTQQGya79+ZPwUTaa7+VpA+unI2f7M1UrCFHuJ8RiPUx3ztBpkSjv950HCYhnizEOeFFSko1WjjdeTcmm6KScLY0NlUGomVOuKWUmp+KEhbnPjyRkucqDdF05hGQtFL6jyS1W72bbMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0GSLii26ZNPdUUHjSJacIsekeeXXTvxUbZO6CEIRwss=;
 b=b7OAig3bZ289/2XMhBdfipQLgQ4eUzldm6w3FkJnmSCAoiBTMIupQ3aUaYZmtMV9nq+0tzHAPrP7SKwDEcmTN1/BAiDvBh0PwsidA3KqkvjG2Ra9SqUHocdqnSF4zQdJEjjPvulYZK4D9auzS+RAgio7PbyP40Ib1BkBMJxsZ2QI6jGMf/3hYnuYG9sKbsaZQhlM5o8/JhJeRiEzWNEeKt6P7lzD7cvLxSckBvpCm1NMisiXcM9WK2bQ84U1gaTgP/R48QvsXgDBrZR5nwZg6/ffRZxgmiwSWKqF2dmMtzxWIDmalJ6hRJBA5dtxKkHlDILE2NP3X06/WWnXc2/oEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0GSLii26ZNPdUUHjSJacIsekeeXXTvxUbZO6CEIRwss=;
 b=m0Ya3JAW21G91qeLn2pcIgsQXhYQ6JRpKVG+pxxvoVXjw+noD4MyRhFloXSy7Q07NgiJxOD4RTt/vDxjQtZqLv+5jNRfmrjN2A7KrVjXshe1kihw7VhTUlFD+8gJJIRAR4U9dR6tOyg8XcXDR71EyeCbDvG6w3h2xvB2yOiVX24=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SJ0PR10MB4670.namprd10.prod.outlook.com (2603:10b6:a03:2dc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Tue, 6 Sep
 2022 19:48:58 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a420:3107:436d:d223]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a420:3107:436d:d223%5]) with mapi id 15.20.5588.018; Tue, 6 Sep 2022
 19:48:58 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH v14 23/70] mm: use maple tree operations for
 find_vma_intersection()
Thread-Topic: [PATCH v14 23/70] mm: use maple tree operations for
 find_vma_intersection()
Thread-Index: AQHYwimvfv54/bUK4kiItSGrHcCBeQ==
Date:   Tue, 6 Sep 2022 19:48:50 +0000
Message-ID: <20220906194824.2110408-24-Liam.Howlett@oracle.com>
References: <20220906194824.2110408-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220906194824.2110408-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 637a0fae-41dd-4c72-1cf2-08da9040d706
x-ms-traffictypediagnostic: SJ0PR10MB4670:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fN+WY2MtRjQi9VsSabGj1Hd0QwV2H0corgZ8+YxkMVYTAFqharcyndezo8lhFxQnt6/ibRYZuJS08zaAOLW6RU/VrJoTDqJQGURBIcv0tTFqVmSKbK0R89muGqlG+lur+VLJFG5GznPFOU1j2P8bXoGL44xDXwu4cmbVI6JUD2UFHmeVCqcD5kdUKASoaOCLkn3l0mCHe38Neq/xDWVqSlwr/4Y8OFSfvhUrPLX9rhGxT5F39Ym+LVTW30WKK/2lxoEEhZFuZLEjzvpKcHiTn/TjMk36nNafBPL50A9HuDBiZFM3eCyVICi714cu+TatxpFWTMEK2RuKuYAGFrbfLX56EX521mdb/ijcxV3lXgPFanSbtKmPalv39MPJq+CH2IgfEd0KBLR4T/qoC478JYsfi/X/SzCJVQv+ckZOCGIBqNVPEvvDVsz0U2PYUSZy3ZYJYWzcwqjQxNsqhtfog6G6rsmyNaZelRXa+aHmF8+FEoLD5x8sq0tExx/gM856Ksp0RFoYjsWxFQbxx5jNor3yrwqr1DwP4kjfiw+2IdKTinonlSKRixE7zuUuWoX7PE7QEKfjzsBN/cLCTneokutrdKtdu3/X97c7WDTNnIK64Fa+IM+yngxqSbRqWwQZTqdQQfkR3cLsKYFTiTRrvMrgnVncS2opoplYZZOWS3MxLkoZZmYUOXGLxKV7pzClcsNL7oPeMozLRTVtYmzRKqlvj/4mT9jG0y4oGGKYK+K33io3P3zDJcd+0Y+nD/I+MpotgbFpHzPceR72d0JMDQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(39860400002)(376002)(346002)(396003)(136003)(6486002)(83380400001)(107886003)(6512007)(2906002)(26005)(6506007)(66446008)(186003)(122000001)(1076003)(4326008)(66556008)(66476007)(2616005)(76116006)(64756008)(66946007)(8676002)(91956017)(478600001)(36756003)(44832011)(8936002)(316002)(86362001)(41300700001)(5660300002)(38070700005)(110136005)(71200400001)(6666004)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Q4ZEOwYe2CRNOrE/1cLOEljbuFvnboWZ4ZLKB4IbqzxHVrWMdZdEIX1ql9?=
 =?iso-8859-1?Q?JT0rChN7/rCsVX6uSxVPn+43iKmjndvup++PC8S+kAH/pHQg2SHznThjED?=
 =?iso-8859-1?Q?1nio9hzfn/P0ZcxfFi2t7UQ1gfMcXw3W+zs91VRkc69T1ifz+Iyf0TjXJV?=
 =?iso-8859-1?Q?4KchuVMww3L3Iu6XlDC4VgDwZdyAPDY52qWdl+k2m37RF4gU34iBOrtKHT?=
 =?iso-8859-1?Q?P3Lk+HIhO18LjZzSCwlfK7l3a/TEUnpYHRUPNXFT/kkGvSZwy93GK6dy5K?=
 =?iso-8859-1?Q?oK698ZTjwV8yP1htyfSoVmWWHd+LL+MJrwDPtCSRlafPRcUyfSVYrSJNky?=
 =?iso-8859-1?Q?KI0O3hXIqfu8TOiaj929RDzQ03LYSmiaR4nCWIv6bWJYLm2aYqb4DKwmP5?=
 =?iso-8859-1?Q?Iqfb77eD8vjyVRwV04ec193SVuYrNKYoWJXbFQUUTx0/wBhzbV+L7+TKIg?=
 =?iso-8859-1?Q?xqgu8jG9WhwAczV1O5xszMoZCSm8lySwSZ5qhVFyagqgUWJjlQEAgiAy02?=
 =?iso-8859-1?Q?IJghvZyoLb8VXFBvLyqSdgLF2XZJZeBWUyd8pVuOuELDSXTTFZKgPbSL3q?=
 =?iso-8859-1?Q?0JnRj6M6JBxhVNDgegUmH39AIL5UEuuyE8DlfyTu81eBFFh0P3z2waQepa?=
 =?iso-8859-1?Q?5BePwDLstAcfopVeCSIc6aOAGNErNANv9hQ4dWRMFdctD8/tx0khM6V9Rl?=
 =?iso-8859-1?Q?e20zdtNuTbSGk2rhS8w0wlW5nseXPpUcNgJbjnya3+1PO9KElYDRinM/Kl?=
 =?iso-8859-1?Q?RxXrjqq2YMCIDO3yUyBQtE+w8nu4o88JkdAmWApY5nGEPAF/Mw/maxCqRY?=
 =?iso-8859-1?Q?Ewu0V1St2Ei9IMZAcY9uig+EQmNw2PHRlKM1zFsa91vw45m5S+X3rJHxO5?=
 =?iso-8859-1?Q?Eo0I2KJRlwknm4kNpz/IOEjmsPTSdynotnLKtWsoUfxeol2PI/0QXgLNRH?=
 =?iso-8859-1?Q?rETnVqMeOwOWPnGbwiaa2iSOANS9tYv1KJ4vtnkogP89yFdIEyxXW8k5gq?=
 =?iso-8859-1?Q?GaxHz4jp3NJZFTi5qmAfsXTye300GnCFqxCQIG351Le7TkKU8EYTiMkEMu?=
 =?iso-8859-1?Q?PDc3NGZ/7e+xtJ4yRHbAAT78qt4qzbIvHGiyEXXhbVE5/6yZ9Stl2u0eYU?=
 =?iso-8859-1?Q?Q6XSqsroBP9WX6jbQeIshRhuG+O3BqzUPgUT6R6fEnfFjgbOv5WKwD62Q8?=
 =?iso-8859-1?Q?DcfPX+yDRwUpR2RbylRuPPYp3YRD2N6dc1lPwZXDMC1oGdQeGV25pBg4y7?=
 =?iso-8859-1?Q?cLbbCGVNaKpLdf8iE63YOJ3OOr61mjO3WaR8VUsVLTzAhr8ljxYoKamXH8?=
 =?iso-8859-1?Q?dtXac9VsNt9cbCjUaVfwx6zG7hFTEtJkDpT/1ykTYTJ/eOAYDE/TK8TI3N?=
 =?iso-8859-1?Q?taFogZ9Ny7M4j5SofxSj1tYsEjtJmH5F6VCtXFWfDQ0VxoCV7tBg2UCnh+?=
 =?iso-8859-1?Q?HmQ5qd7fNetJpV/cbAkKZIFOb6sa2cl2XJNAWz374Y4RQ7MHnIQgUqmlAy?=
 =?iso-8859-1?Q?c8VPlecaxut2YG28RIT1KOEGsnC4FIZBOQR1BltyDAIXIU+6iokragXBq6?=
 =?iso-8859-1?Q?CPyEVhrZCff1JQwYfFNsku6ZFTn+VTiL5jsuxx1RaSLUg76jLko+nX0yJJ?=
 =?iso-8859-1?Q?+HoAh3sUJnMZhKspm6C+bRkV3XprfdypmNEpD9NojcHaZS6JDa80aLQg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 637a0fae-41dd-4c72-1cf2-08da9040d706
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2022 19:48:50.8191
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fSUNQmZxgfyTftNpO4ffpmGQkd4y5aRv8ncDnEhCbvzbB/aqqoMtmj18i4SzG1GwXsTavI+I2VJ+E3mIE3M4vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4670
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-06_09,2022-09-06_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209060091
X-Proofpoint-ORIG-GUID: CZ4xO5QX-GDVkYq1C109-UcH3ABdBswg
X-Proofpoint-GUID: CZ4xO5QX-GDVkYq1C109-UcH3ABdBswg
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

Move find_vma_intersection() to mmap.c and change implementation to maple
tree.

When searching for a vma within a range, it is easier to use the maple
tree interface.

Exported find_vma_intersection() for kvm module.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 include/linux/mm.h | 22 ++++------------------
 mm/mmap.c          | 29 +++++++++++++++++++++++++++++
 mm/nommu.c         | 11 +++++++++++
 3 files changed, 44 insertions(+), 18 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 3f9cf513e046..9ed579168f87 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2782,26 +2782,12 @@ extern struct vm_area_struct * find_vma(struct mm_s=
truct * mm, unsigned long add
 extern struct vm_area_struct * find_vma_prev(struct mm_struct * mm, unsign=
ed long addr,
 					     struct vm_area_struct **pprev);
=20
-/**
- * find_vma_intersection() - Look up the first VMA which intersects the in=
terval
- * @mm: The process address space.
- * @start_addr: The inclusive start user address.
- * @end_addr: The exclusive end user address.
- *
- * Returns: The first VMA within the provided range, %NULL otherwise.  Ass=
umes
- * start_addr < end_addr.
+/*
+ * Look up the first VMA which intersects the interval [start_addr, end_ad=
dr)
+ * NULL if none.  Assume start_addr < end_addr.
  */
-static inline
 struct vm_area_struct *find_vma_intersection(struct mm_struct *mm,
-					     unsigned long start_addr,
-					     unsigned long end_addr)
-{
-	struct vm_area_struct *vma =3D find_vma(mm, start_addr);
-
-	if (vma && end_addr <=3D vma->vm_start)
-		vma =3D NULL;
-	return vma;
-}
+			unsigned long start_addr, unsigned long end_addr);
=20
 /**
  * vma_lookup() - Find a VMA at a specific address
diff --git a/mm/mmap.c b/mm/mmap.c
index 0baa2ca5b0bf..699af34c3573 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2061,6 +2061,35 @@ get_unmapped_area(struct file *file, unsigned long a=
ddr, unsigned long len,
=20
 EXPORT_SYMBOL(get_unmapped_area);
=20
+/**
+ * find_vma_intersection() - Look up the first VMA which intersects the in=
terval
+ * @mm: The process address space.
+ * @start_addr: The inclusive start user address.
+ * @end_addr: The exclusive end user address.
+ *
+ * Returns: The first VMA within the provided range, %NULL otherwise.  Ass=
umes
+ * start_addr < end_addr.
+ */
+struct vm_area_struct *find_vma_intersection(struct mm_struct *mm,
+					     unsigned long start_addr,
+					     unsigned long end_addr)
+{
+	struct vm_area_struct *vma;
+	unsigned long index =3D start_addr;
+
+	mmap_assert_locked(mm);
+	/* Check the cache first. */
+	vma =3D vmacache_find(mm, start_addr);
+	if (likely(vma))
+		return vma;
+
+	vma =3D mt_find(&mm->mm_mt, &index, end_addr - 1);
+	if (vma)
+		vmacache_update(start_addr, vma);
+	return vma;
+}
+EXPORT_SYMBOL(find_vma_intersection);
+
 /**
  * find_vma() - Find the VMA for a given address, or the next VMA.
  * @mm: The mm_struct to check
diff --git a/mm/nommu.c b/mm/nommu.c
index 321c7e6718a8..2702790d05d3 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -642,6 +642,17 @@ static void delete_vma(struct mm_struct *mm, struct vm=
_area_struct *vma)
 	vm_area_free(vma);
 }
=20
+struct vm_area_struct *find_vma_intersection(struct mm_struct *mm,
+					     unsigned long start_addr,
+					     unsigned long end_addr)
+{
+	unsigned long index =3D start_addr;
+
+	mmap_assert_locked(mm);
+	return mt_find(&mm->mm_mt, &index, end_addr - 1);
+}
+EXPORT_SYMBOL(find_vma_intersection);
+
 /*
  * look up the first VMA in which addr resides, NULL if none
  * - should be called with mm->mmap_lock at least held readlocked
--=20
2.35.1
