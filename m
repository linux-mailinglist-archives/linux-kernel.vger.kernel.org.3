Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E7A04F172B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 16:37:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241887AbiDDOjL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 10:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377918AbiDDOhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 10:37:52 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 118EC3F88E
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 07:35:55 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 234DkEss004895;
        Mon, 4 Apr 2022 14:35:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=GIxmXifR04GCV+zaBUx2G7nGgwvDD/NWsVy7yLTOto4=;
 b=vt9+sZPw41Lr/fBvgr2HbXJVRRCGXhIDolurZyq5o55EMrqoW21/KIPrxMhP3H05os20
 9wGJX39l93GbfMEVfEwR3SnWEWm9ezHluAMSkN+8U/1UjCuvw/zRQ6HqYA/8Jt9by2/M
 6Z+Et1gRijVNuKIYa4UkKhteiKU8I+Q2aN+DNTIw6WgydXD7OFmbnIa79zy4dGWHgt1F
 8FHrJjwGLvGDpSUKtNo4Hn5NzE5eJsFrjr8QmErwjbeZiVHe5QfCafcTV3vepYJRBn0Q
 vQCX1PY74DswRr0gEXdzxyq8jAAGm9gsMgnKrvO/wt5Muu2IUSg1roGF19mWnra9FMRl xA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6d92ud19-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Apr 2022 14:35:49 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 234EGQE5028988;
        Mon, 4 Apr 2022 14:35:48 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3f6cx2c8h2-9
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Apr 2022 14:35:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AyQB4tS0JMH0cIsoGv9MpUFMlRGP3cbXWunGtxDIilh1FVSGPLLy9XOJQ208KKA02NO0cekoP+t4cXKanrXUoTcS3t2btLynLu/UkDg85jEz3Wm6OQHoBmqFgKm4CYwpYq2xz9kXDq15paBzpVOQdwB/edzgdgb45gKWYPy97RSLugCpywcsado2dMkmmdwyaoGqwIrF/YgU01Y77UYWZlXIDph+PH/r/xBGWV9E/HRC2sUdERfhnfSgjhKo2tBJr0R9ZhTZb2x0OEA0PVzkYbgavNcTXfF4jCPVfh1zf3cVuuy9ntDmKdnefkLC22LVvs3esZAr0P0CQyoIOMmYOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GIxmXifR04GCV+zaBUx2G7nGgwvDD/NWsVy7yLTOto4=;
 b=Y/3+//AxKS97o3okePlFO2tCGUrYeeJQ4zZAzoTbP5fVYbdfcBq9PlllBlQMe/XjeemhaLgFnFqVWB2SzT3N4prt/4uwEXWDXcuWUTf79ZXvRogv67BVWvI9T5Ecm8LmQ6FPbkq9mq7YsSRPi3/0vcjGUS8sPt66eNxQWxEUBKS3OBXHZKnoeQAzFybv+t2HRU4hbwif2AHKorDzqVjZkzZid+z2wB6DqN+aSOwjJtYwBhVkehWbpmvaDkEuHvX80vQUNj0cK7vC1NAU3HU/QyJsc16dS0rt/DmiPlLEiSgrXx0CtEJBruJd/fcmeL9MUw6cbOMDLEBMzbikSdqKwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GIxmXifR04GCV+zaBUx2G7nGgwvDD/NWsVy7yLTOto4=;
 b=nEm9SbtmbnojP5TagrphU2gMwV8VOnIc7A6F0w2amDhDfAPTPm4AFb8OVexJcH3aIdJmv4WyGGv18slTHqDPKo8v2l8wR97HIZWdeJFj2JRkBKishZeknXNzW68QvGauhrwPpzUiwaohzQ9DjjMl1n6AdXxXhxaGdHgrr9TzFRs=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by MW4PR10MB5812.namprd10.prod.outlook.com (2603:10b6:303:18e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.30; Mon, 4 Apr
 2022 14:35:46 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::74fd:df41:4c93:24a5]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::74fd:df41:4c93:24a5%6]) with mapi id 15.20.5123.031; Mon, 4 Apr 2022
 14:35:46 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v7 25/70] mm: Use maple tree operations for
 find_vma_intersection()
Thread-Topic: [PATCH v7 25/70] mm: Use maple tree operations for
 find_vma_intersection()
Thread-Index: AQHYSDFDPbW6Tl9umUa8A0ANw86seQ==
Date:   Mon, 4 Apr 2022 14:35:43 +0000
Message-ID: <20220404143501.2016403-26-Liam.Howlett@oracle.com>
References: <20220404143501.2016403-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220404143501.2016403-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: efdc47c7-e6ce-433a-66c9-08da16486808
x-ms-traffictypediagnostic: MW4PR10MB5812:EE_
x-microsoft-antispam-prvs: <MW4PR10MB5812A22B713BA607A1F7C833FDE59@MW4PR10MB5812.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +RIVMJitIZfyPzaW+CH1D0BHDTUOC6EImYKyJn7gGKl28xItKa6EyTOzfO2guJKOjmbPYBejj5sS6vpeORXcDovM5kDvLM76k61C4l+bYILf8wGlQ96E3YDzdZJdRd+W5dFIWQiM3E5owvdufWDwoGl4iDPD92qi0ktwwIMnDieQ7riKNNJla2Y2Z3XkGNHsK2vmN2GVgMjCr/HTl8S8eSovdKU5ppQ+/QUqB4WxeMsq5pzv7PFjbw2Pv2/9UKz7trCYYnybsi7/MXpktnvSPnDjmw0NquMho3x1XYI0sRfJyhSXhLKulFJnqvSJvQnB71gTMGmAW8SHWl0aPauxBRtiJkdxk9nXMkR6j8Ba86x4gWS4J5ApaOdBzYm91NwJ/KblvPnp3QKuQSk72w08fyaSqZA0Ctdz93K0wFQwYdB0KNujP+zKEcaKAY7EgByixpR2QFQ89Uztl7A5JhJtIs52PY89jY2UxyS5xd4e4JjCBmzPm1Lx0e/ObI0+gR01RBhD1iAg5XKrvxHiEzZx1MUudOOVG+/Gr40ClAgykTjy+EHLK/2kSIyEoGuyxWSNpVEsrzppGRK6GN8XOTncfSejqyCIYSQYKY6Igim9KniHVsuP6ltFCuV96ZCnV06gKvKTTlVPxzQMDiIESsgI7OOUS+V+efh5JoL1hrSeRmhhfr7S5VDJBJinSysXoFCCKtmPjhYZ6bTr7IXfWYmKTA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(26005)(6486002)(8936002)(1076003)(44832011)(83380400001)(6666004)(508600001)(5660300002)(6506007)(36756003)(71200400001)(2616005)(2906002)(186003)(91956017)(64756008)(66556008)(66476007)(66446008)(76116006)(66946007)(6512007)(38070700005)(86362001)(38100700002)(8676002)(316002)(122000001)(110136005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?BZVUoqlObm1uTIJ/n0+y+X5oDx2teFUKZRvfYr3p6fEcCk5o+vXbytIFFC?=
 =?iso-8859-1?Q?NAn0q54CP3aeaT0mng5aWklvi2l+aArCUlOpGdge34MIKE73iAr5ASDpBb?=
 =?iso-8859-1?Q?UWQu7qFTV4/w7Z3n+xyfMgUp2PcXdEDf43Ox/o3Y6J2o+zMYwa9cglkN/c?=
 =?iso-8859-1?Q?ODtcYYX6f8pitIfcEUWUl97pbOzb/m59b4HVBwIXQQGGqkAxzkvOJod3xa?=
 =?iso-8859-1?Q?0N+s3465XtLOflMxbkzppM/r83NifLCAfFWwmejFJLlvJzCR45Jyev1k+h?=
 =?iso-8859-1?Q?4jTYfhBtTe1c7w2kIKn9jqYfge9Z7AmfvEdXq/0GANRv28oGHxWtF7jyk7?=
 =?iso-8859-1?Q?Nb9SdFCakY9nijITID+qqghM+j/BnZ7E2x9HL4w0CMgAmPISPj8laXdSX1?=
 =?iso-8859-1?Q?+8qa8rrfah1k5f0dCzEe5lK2V/Kt43lQ/Uqch7gl7zhBITgN4FfFic+QzJ?=
 =?iso-8859-1?Q?O9GP+U6xv0VWoYl9rG2OU2qPqbuzryiemwlxN+J9cpHve+q/LvMs5v90fz?=
 =?iso-8859-1?Q?7ipeucyNvjXZIUEDoCip1qbAfT6P0ZrZR2rQcKDIJLJRUJVFNrH2FisCwo?=
 =?iso-8859-1?Q?ib7exwOJL6w/ZiQXlAahbDHfgTi1WeHRsG1aIE5G6DOC1z4ygOB11pEVTI?=
 =?iso-8859-1?Q?f4Wfj6SG2jMDBkstXhmEvKIJVm4uKeEISmINUuGeDOhA4h6C/87PTAIBZz?=
 =?iso-8859-1?Q?MAtpAVhFENK+OrwCmgPrpxngwxStZRYLxq10yS5Q3RmafHe7T2y4hvpmDu?=
 =?iso-8859-1?Q?bRAzrFLdhtlm4T6klwRAiTD7/V3F5kHXQyt2kfSYT2KUqFvWg7cba7b05f?=
 =?iso-8859-1?Q?NN8CaDCDkRlj5OPRAxkD0d4iCh5yDJIdxHwIXzqj1KdZcwbxxAvT0/TK/5?=
 =?iso-8859-1?Q?XYXz9boq1bs39m7Xdo0XLRbewG+zS4WoTQhHDDMIOQln0MM2WUZtbdx28h?=
 =?iso-8859-1?Q?6kWT8P0+FjYXL1Bi89OFIwLS6DRiVgS+K0bxG923+2Em2yzV3xYgxm0XZP?=
 =?iso-8859-1?Q?a6hT1D9L+VCX11cwWsKLMt3YikBphiJ+v8MwJ24ny3NQ+i/Wggk1KsGAED?=
 =?iso-8859-1?Q?0LAS2cvR4rrhFCUxtKdJpydZ0Lb+FoKhNsuYqziFt0ZDh1zFWQAWVtTu2x?=
 =?iso-8859-1?Q?BfWg+eoDBHk92See6L7Sb7F8IYt472MJwTDNTe76szLFXyY44G7dnUaf8n?=
 =?iso-8859-1?Q?YydSh2nRviPjH6gu34wUUIOtwknR0GYqtqvvhah/O21yHtb/FcWD/rGSgp?=
 =?iso-8859-1?Q?AEvGZ9PpFMpzhI8VvZCHPAl6iDDrpz4WIxg2KfFAytMYdxF47YBCRSZI1u?=
 =?iso-8859-1?Q?qUaETJcChuk7S3tXpL0dcbsdeDt1BW6nih5gvLlozSgOG5/vKDeaWDij/F?=
 =?iso-8859-1?Q?Ief0s/yZSac/1EMuK2fBvY92aovQxCVPabY5x9EK+Mk37Kpc6W4GMXkCC5?=
 =?iso-8859-1?Q?9Lxflg58bV1tGORIbwSNVYmDU69oz6tMYI3pc8dKJI7KP0oyeGEOyGrGLJ?=
 =?iso-8859-1?Q?VfHWBZcZEkN3bo9YZNq1iHbLXuWrTtePwptVrMBAD98vOod0GtSkJxA1rB?=
 =?iso-8859-1?Q?lJ084pg6vD3U7NCxp857h3uIPwUlho+tZBjP0YTv0kDx9SleGej6HJIcQ0?=
 =?iso-8859-1?Q?LoT9/jAVAiA2fcecQzOnzO1pU6lhnVTKbMdaJ4WKzbG2l4aPK7QKWzkmr4?=
 =?iso-8859-1?Q?rSMT2xxvfng0RQgwKa8SjH2YGWZYQmQ41lGZpZW3KBEfbX2kIIoMZPhpno?=
 =?iso-8859-1?Q?OQtO85oa4yndIXylEZFXn0EqlgiKJhSzQm+WJ8LZd2a1EyAi2allYVFN7l?=
 =?iso-8859-1?Q?UUegrqX3R53f8081dpq4j9K+mIPK9M4=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efdc47c7-e6ce-433a-66c9-08da16486808
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2022 14:35:43.0342
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5Cl+KB81zRLO1Oati0oUp+rkv/xr9TOb2OghUzGG4DBb4w7X10DqzEAzUesTdmzF8KHMn+aEjdl/WiEt9MFAgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5812
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-04_06:2022-03-30,2022-04-04 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 bulkscore=0
 adultscore=0 mlxscore=0 phishscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204040082
X-Proofpoint-ORIG-GUID: nP97W0-T0WcB4NU3ESGsxIiUbUH-3ocI
X-Proofpoint-GUID: nP97W0-T0WcB4NU3ESGsxIiUbUH-3ocI
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

Move find_vma_intersection() to mmap.c and change implementation to
maple tree.

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
index 65aace45e770..c6dd177bbbe8 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2783,26 +2783,12 @@ extern struct vm_area_struct * find_vma(struct mm_s=
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
index e04614d7eaba..1e6a72147480 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2028,6 +2028,35 @@ get_unmapped_area(struct file *file, unsigned long a=
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
  * find_vma() - Find the VMA for a given address, or the next vma.
  * @mm: The mm_struct to check
diff --git a/mm/nommu.c b/mm/nommu.c
index 9b8c033ef997..7d8f756f13f3 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -627,6 +627,17 @@ static void delete_vma(struct mm_struct *mm, struct vm=
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
2.34.1
