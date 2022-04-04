Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFE034F175A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 16:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378221AbiDDOm2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 10:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378004AbiDDOkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 10:40:09 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79F6B3FD84
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 07:36:36 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 234DlFTO024455;
        Mon, 4 Apr 2022 14:36:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=+14j/V8X7Kh0Du6pTjr/WG129+iLTCW1GphVnUtIV6k=;
 b=kVJw5A2DWN7ivNtKj16EsHubeJcXlfQu/e18rDeDjLYRe5Om/8P6XDXgCeYIynT5Nexn
 zVHkMXqUbsZHXHYjkPFEDCYf7zTq0PlnIAIMu2cTQ0GngsGsxnp3PAIZZicn2nZYzk+3
 JTFB7Mf+VwSXWmoxUVOYNGLRABnWoYPHE+gm0ZlyeSzV6N2kH6RbsUqa6gEpZnWnkRXK
 KkifG3OEd/ee10DhG/3rNiPdtvcg8gVqBq4GcUx2s4Ue+25qDsxSq0QvuGdU2gFH4srH
 cu2e1dIjITYbmiJnjAyJbSXZYAilosSl295u4gL9Bou0VIDlIeFmpf3a3cTrj++MUlby MA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6f1t3cvf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Apr 2022 14:36:30 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 234EGcGH027665;
        Mon, 4 Apr 2022 14:36:27 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3f6cx2gn5h-11
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Apr 2022 14:36:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bv9nUA85JFsRY4BQOV3B6N0EkpdwOTqwKrw2A4/9ESrRU3cqKYl5grofXZcUI3bFH4SY3mueyZTwLtPaLW/9uV7CIWw2RoNsVObgjn+dj+QcXkhG/6HIJzgS1tA0NKp9JJ3+NxOq2Ea0oWj++8BZ3zlm2NyrIguzX37WiJfMDJKw2V0oDYAmrOk61J8hCuyzM0HX6dPWD/8wT5t9wVfVmzzTHr+HKehPUO6QB90D52TLyiY2DuCDfnnQ4prtCTZoqOl4OOpbQ7E1la7Srz5YMtCK+e+Xt7J44wonkhPvKhkF2YoBujH7+/oOFh2MbElIZ7ayga1MNu5VST/bNf6FdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+14j/V8X7Kh0Du6pTjr/WG129+iLTCW1GphVnUtIV6k=;
 b=BIQOyP3ybaVp+iVleWFwjD9I9U21gSTWP6fAobXNNuJfGRg2m4ndIdt2jJOCKRjCTwJLL22ds4EG1L2m3o10FuQ8MU+oHw6xinWcoesJ5EulmfyxAggLWMRA1KpFHaepUYcwBrmhbc0HiHEJv0ZD2SHRGdWai5EXkcu3Dd056iBraVOTg79HOqZ2bInrp6qJ1Xk0DblSd9QhgxaksXIORadlRpx4zyv+UXr+M42tePaZy7xpW5mjwLReUCtYU2ATdUhRHSJY8X1+VG9w+rQxdSUG6zRk+e754BKEj5reXG0Fuqde9gIM/+//AHzGCmCa7TqhJc0hRggFTQwJa5+2zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+14j/V8X7Kh0Du6pTjr/WG129+iLTCW1GphVnUtIV6k=;
 b=IzE28LEF0vHUXUimN6lsx9caW0YeQ+Fq0JSw13Baq4r14vEtRyZnFYPFdEvs5JLGuupF8wTZ1TnXkdlblkWYy5lp0SorVEvs7qUbRpCzWCEzavozBzt4vXbjZH9dSPwLkIKUK5VrFCl5Vt18wi+Or5Z3O4/8rk7KSM/VozCnDPk=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CY4PR10MB1381.namprd10.prod.outlook.com (2603:10b6:903:29::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 14:36:23 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::74fd:df41:4c93:24a5]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::74fd:df41:4c93:24a5%6]) with mapi id 15.20.5123.031; Mon, 4 Apr 2022
 14:36:23 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v7 40/70] um: Remove vma linked list walk
Thread-Topic: [PATCH v7 40/70] um: Remove vma linked list walk
Thread-Index: AQHYSDFGYmv04vI0J0eBUtL/ppo2xA==
Date:   Mon, 4 Apr 2022 14:35:48 +0000
Message-ID: <20220404143501.2016403-41-Liam.Howlett@oracle.com>
References: <20220404143501.2016403-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220404143501.2016403-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: abbfbf28-cc7f-416f-c58d-08da16487e15
x-ms-traffictypediagnostic: CY4PR10MB1381:EE_
x-microsoft-antispam-prvs: <CY4PR10MB1381A03CDC220429ED13F686FDE59@CY4PR10MB1381.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lhQKGm+PkGvu2+fN3IeWMiG1QCl+vmIDstqt0Tzv7Jbi/S4V9MkLiIIT30yavWJ5Az2dPXj3sVhTNuq8u2432P2FuqEEipHLB7gy1b7QrrHsIUkrW40CvmxTE8z0t8MNZG0Xu/70tNL10d9OX63mcAA9OLpoCTLa8HXU3me2+rAugNXUatngvucTN/SAZ7wkLkFT+SYKZ+4TU3+SC7TNfyIwLg6ZM3oCl5rIZQ1ozYwOBuGlCvkoWMFkTD32qgbmYhass6zyts6Pow6sE13FdKWFwB+vLDSS4n78ItOLhOfGsu+5Bic+Ke+M6NbW5f9YuRWq2kzO0ugNhHyQOOd64yIjpSroHa5RHtg3ArRATF8/t/fJR0JK1TTI12w932LkLoU2gNKgbWa6ZIeZcj7KFGsCn08sQhLHvFNg/weXWNmv7YTzjS7viwd7pOaErUuWRQExyd8ocpZxcvjiBgPEJLD9WCT2CGCXFCp5BlWE03upWtO3AYRW22YDEHHNfZeDW6uvSqLitH2kJxWXbSpTghJ/7X4Xkl04OuFpHwSubwlFb4RRpCM8li8KfkesgS1/rqs166G9vfKh4RU7Zkafat6+ijjfL1fg6Z9fo8LNKwp4Cp/J1ie0SS2rlSarGmGZ6j8QpQoEM+kX4MW5M58acgG/8ftDTMSOGopRXRJck15aBKYtoAZj5JpKLgzkPujrwDn9J//pYUKgf3uAZT0nZA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(122000001)(6506007)(6666004)(2906002)(66446008)(66946007)(110136005)(66556008)(66476007)(36756003)(8676002)(76116006)(91956017)(64756008)(6512007)(316002)(71200400001)(5660300002)(2616005)(38070700005)(38100700002)(1076003)(83380400001)(186003)(508600001)(26005)(8936002)(86362001)(6486002)(44832011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?nJEPtdHVFGZQNVHOxAzqhrSlkfp7fJgh02uY1IZ+KRrh1gkh8R2BmeU0cz?=
 =?iso-8859-1?Q?5H3BkaXi/HJ/b276DwVbKEzAxOlmDNJBpwpmutvp56FjdKBf2SmVODYgwu?=
 =?iso-8859-1?Q?G+C+NKKd571e9KamEz92Wq9Co6wgG7OKjJK5zM0j0UaEPpGI/2/jUw3abg?=
 =?iso-8859-1?Q?n7MjBD7z736IayR6tqGiK2NQSbscwOxt2y2kPzTFxcsZ4ZUAd+utFypbdE?=
 =?iso-8859-1?Q?Ca8+TP02qQjI/wdJEznUDWQTDGOEYtIkDC1A0vjJhQKEdHISjr028j5kOV?=
 =?iso-8859-1?Q?q3ypVGwN3StSMKCGsEuSWbKSCR1JVFnntHWixHFpwn/MlybHvWeiDbLXFm?=
 =?iso-8859-1?Q?C71hEIV/l4d4AJpZKZOzsGZPA/Gtlgag73HS0rC/JQ93z5SJobusV+pW+p?=
 =?iso-8859-1?Q?m2a/XsIGKtcfqB5hyHQTdWiVz/hLv/kCL6iO5L/aEwO+r/bb7HCO+Zt+FA?=
 =?iso-8859-1?Q?mx7jCDzBjv9EKzDVUKGl9s0dcmG55P/a7xO4jRQdAcAUTqnaBHjqZwk7dd?=
 =?iso-8859-1?Q?wFWYyVzBkRYhbacwmOY640rJzu4/pmWeKp5l7EaqSjkZlDULSdY/nyzGMe?=
 =?iso-8859-1?Q?/cQvm1YuhOwe38tU2+1MxBHbJ8Gm/D0MteD9SHTteeCWvuy/bn9Asw3Kzh?=
 =?iso-8859-1?Q?qAZlJdBENbsNvbWBUQi+sLw1EKZbKOdacePKcLNOextP9UhzhlVV/WGp3l?=
 =?iso-8859-1?Q?7ouqThOrCUzRbF2VkEdjcLLdTDuiN+Pll94/9vObn3Y7Ah3GuJZ7qYZJ6A?=
 =?iso-8859-1?Q?VbyFGTRZ23n8AuCrgVPM8T+YzWvbwKKxCqFgjk9nrpr1LUeVDtlcISJygQ?=
 =?iso-8859-1?Q?FsHB112DNTMqotJZYje7HGhWoJDdoFS/3uuArMT6emHeqrh63k17YrnKTm?=
 =?iso-8859-1?Q?s3r5DhcXDzEkNb316CE0hsOX/T8/0YSdffxn8+yshyH6TqaDOUb0w5q2zW?=
 =?iso-8859-1?Q?Nk8MPFBOG0LesVJKV+3t2TiubDeQxFRHeLeIkzTvA9f/KKI2KyhSZSuBYK?=
 =?iso-8859-1?Q?hMpYSGfF8a4tfcV971j5hAmO4cBkHzWEKj9/Q0n3qoVgmP2lqt6yRsNMFS?=
 =?iso-8859-1?Q?bPB4OOphzgWUzYZTXd9thl8Yz4z0fF5GhVvCJFR31dSMr7WXOnIDpRGN1W?=
 =?iso-8859-1?Q?hAXqquSvjnin8jJihuBpCbmx5uO9xtvrAIaDu9lHXWwbchFi1LWYLSRQZC?=
 =?iso-8859-1?Q?EP5AzPtfyqqZ1QuL4LdIkzYF4tXMUjsLwxSze+jmNMPvly63YTjwcRvnX7?=
 =?iso-8859-1?Q?Nq546U6r2MQngKeefS/DchnrMx0N2Lk9Gs1bwQB1fm+5NgnLX5DadJMk8A?=
 =?iso-8859-1?Q?P9syaW5N6mrn9IqkU2eUVhjmLraOHERqHLs1goqvHDN1M0OthmoDLsoHmy?=
 =?iso-8859-1?Q?FW7BC25Uqa7yztdCecXJSd/JgkZgGPbF7eM8ByCyjnQSHjFAG4y61dELqk?=
 =?iso-8859-1?Q?aJmnhW6yFNBDObI/t9HbdZpjDsQKXZVCvoUsMIFjj1HDukjKAULqevr20S?=
 =?iso-8859-1?Q?yQSXzLgOitd5h46dhN7mDzE4UZsGSBMSPY8kT9OSi9Hpug4BeNfcHw0iKJ?=
 =?iso-8859-1?Q?PjesIBaaE0jaigcw5HRuoM5GT2/1gE9Gm0bU9RijhET/UcuoNIkTl7rpkX?=
 =?iso-8859-1?Q?55PN7ylbs/TJnvPEOg0cdquRcd+yIHhybajfxD6xnnD9ZhQ5YAUzUou3++?=
 =?iso-8859-1?Q?XpT+v8Z44VIvyt5Bh65EKKcz7IaHrbF1peRBa3uDiBM3ObrGTpybGK4fqi?=
 =?iso-8859-1?Q?fn0rrrFj+AWFhyzTue00PtbQL/IlqI6R8RC+JsDNYz/Rsz19DLwlHCDCUr?=
 =?iso-8859-1?Q?xb8JD32KGvERs+4ozZF3p7fGxziB0KY=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abbfbf28-cc7f-416f-c58d-08da16487e15
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2022 14:35:48.8463
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4it1/I+oIUPRPv4RbQYY+7nkrzsWilSP5jpfg1qANH6Ytx2pKL4vQLI0QiyDFo3kkQ2Qhwu4p0FGeSsLFsqp6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1381
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-04_05:2022-03-30,2022-04-04 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 adultscore=0
 bulkscore=0 mlxlogscore=999 phishscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204040082
X-Proofpoint-ORIG-GUID: 05vbjpiOOkzphE7HLAgATEaDUdq8qDEY
X-Proofpoint-GUID: 05vbjpiOOkzphE7HLAgATEaDUdq8qDEY
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

Use the VMA iterator instead.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 arch/um/kernel/tlb.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/arch/um/kernel/tlb.c b/arch/um/kernel/tlb.c
index bc38f79ca3a3..ad449173a1a1 100644
--- a/arch/um/kernel/tlb.c
+++ b/arch/um/kernel/tlb.c
@@ -584,21 +584,19 @@ void flush_tlb_mm_range(struct mm_struct *mm, unsigne=
d long start,
=20
 void flush_tlb_mm(struct mm_struct *mm)
 {
-	struct vm_area_struct *vma =3D mm->mmap;
+	struct vm_area_struct *vma;
+	VMA_ITERATOR(vmi, mm, 0);
=20
-	while (vma !=3D NULL) {
+	for_each_vma(vmi, vma)
 		fix_range(mm, vma->vm_start, vma->vm_end, 0);
-		vma =3D vma->vm_next;
-	}
 }
=20
 void force_flush_all(void)
 {
 	struct mm_struct *mm =3D current->mm;
-	struct vm_area_struct *vma =3D mm->mmap;
+	struct vm_area_struct *vma;
+	VMA_ITERATOR(vmi, mm, 0);
=20
-	while (vma !=3D NULL) {
+	for_each_vma(vmi, vma)
 		fix_range(mm, vma->vm_start, vma->vm_end, 1);
-		vma =3D vma->vm_next;
-	}
 }
--=20
2.34.1
