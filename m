Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33DE1519345
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 03:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343539AbiEDBTn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 21:19:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245081AbiEDBRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 21:17:54 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 998AD434A1
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 18:14:08 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 243Kx7fk030616;
        Wed, 4 May 2022 01:14:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Ukqb2QQQRBNcHyQVxqkE6N3xK8UmeIbkvheRC3rRcP0=;
 b=EbIewnU3krNC+Mhpc6u3X2tr0QKFEEE2SIt2StkSTYukTA/TxVEw3XbJ8OBfrQ/M92dg
 6OmctvNXLfq8dUzrVnvTqxg5W/pukC7TZwZxdHthapIKDqswOsTv5nB+X08HlFD+Kib1
 DQ/3Zf20TRXTPC1Yp0T0m8DTpa6gLLMNdoBgTfdHkE/G9EHbYCRdZxIqEDWi2SyvZSTj
 3yNptoEf/OgGGdZqVRdw+SbV5c0K0dtEtVpg2aWm5oaMH5VnSKtGU4pjfCiFlGBa/eKr
 hG0jQejGMoFIBSxxHbHR69dUCW5F4o/VxZENlYRYdSjo6Vfl3w7oGwS0zFaBwL9ugPAq Ww== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fruq0f61g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 May 2022 01:14:03 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 2441AtoC020100;
        Wed, 4 May 2022 01:14:01 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fruj922he-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 May 2022 01:14:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JtcSQHOmuEWH1GIm7O3zZC9u4V4q9IfS3YUPU04Vj39T/TU/mOUhC53aoqeuCf63WqXXcucCgIXaA/KRGQVpfpV1fFdYd1W5YVFx10l/IVu0/BUho9J/1zVNfBzAuODRwODLDMIE1xbxKTnE+XHpFsw2fdq4txPbeaHmoFnvRYHPhuob4XcM7EtmUcHOOX0lyvDAMoK5AY6eqqBf4MMCMs2vVMCT5MftpWKauEVo7+yh/ucqfGeu0k7mIgJBCLtpN+c9VSJ49bqgWd+8/lrVFLwsDHsQeKyyUOdgN0hhXC7kEHk24Tn/vfcZmhHirGg/HA9qs/xwTDegXogZntRa8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ukqb2QQQRBNcHyQVxqkE6N3xK8UmeIbkvheRC3rRcP0=;
 b=Fzj/0n12LZOlvC8qyGYr9w8nHMKDKrHTOBhnGLt8PhP+LqowiyKryaxyjAARUpMhCJ3E86lVv/sXGDhlTYjL9wXWbsKH91Ik6/V3sts63zN29ALpqibbRqpADD4sd0+yKkgughLYEnHFar0zoscIXux+34e/a+OzCWvci7WxNx3RxtnAkueCZR13Nx1H/CTrxGdrEdLprHRGBjxGfDhhSkDNA1v4HXeyLWfrPiJ/VRwK///zLH4YhOSJlfK9pQ3f6qMpXwR2ufzHrWOg+Ym2SqRyFa6Vd6VknxPxeFtiyiQoQu2qDX8nDpJgRRcuua1sVMBw/5zelzs47Fdoji0AjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ukqb2QQQRBNcHyQVxqkE6N3xK8UmeIbkvheRC3rRcP0=;
 b=P4ag5Hw25vcG/coYUOOqs68RyTWZ2rmPVpbPTnZEJKoHlVQA5TnfYR0rMmbKaQw1XaB+K3HRptB1WYsizYJ6EinRVcMCkUAQUlgeDTIzJpBQSfvi6Ky1CqRhVUMzc5D6CAp28UV6yo42OsAcN5SBbRvwfLy8JbZo1DxN0riAlGU=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by MN2PR10MB3728.namprd10.prod.outlook.com (2603:10b6:208:115::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.21; Wed, 4 May
 2022 01:14:00 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5206.024; Wed, 4 May 2022
 01:14:00 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v9 39/69] um: remove vma linked list walk
Thread-Topic: [PATCH v9 39/69] um: remove vma linked list walk
Thread-Index: AQHYX1Q6toeHZ2VVK0yguuIeRMA1YA==
Date:   Wed, 4 May 2022 01:13:57 +0000
Message-ID: <20220504011345.662299-24-Liam.Howlett@oracle.com>
References: <20220504002554.654642-1-Liam.Howlett@oracle.com>
 <20220504011345.662299-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220504011345.662299-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 25ddcb86-b8a5-4804-b6fa-08da2d6b5ef7
x-ms-traffictypediagnostic: MN2PR10MB3728:EE_
x-microsoft-antispam-prvs: <MN2PR10MB37289042C2E8911A29322115FDC39@MN2PR10MB3728.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kurrRLUyv5lf95gHJnGtN+CJI5scg09TBeBaWiSytLzmtmV2TcLdp9BL7qCyXz8R+/VGIakeoVRzw5KVYgluauUg/oTitGbU7Pie/9j6vET1CkqtA8aPQ/dpU3TpbCAZEbvLGiE+o67bqFOWiw161BX9PhUb5Uy4xonMZg/Nm5aD5/Jn99x3yJe1ywrYdc2XzKZR0OhKyG3sAFbqz2IFIv0j1LFsAGQFdct0tIEL4VjCpSrnN9ppJp5EdzlUWUCn3t6Kdqy+ExNph19c1Yo88eEEzG6wemKX1qljYCI+Wy/LzyqRkPddTdq9FQR/kzXK7BY2NrNafJXAbd1QXo4ET0iH3ouGRdn8N5O65M5LLJLdl00OJkPAp16D6C3SRdSbPADWhKNXAP9480uVd0qm9rIPhbGs4yN/snM6E2mxUAt/7vDKLzekAT3412uMEEbqiaBuBKQudzPKkXqBKuJEmKWDIEnrwBlvZ9uvyfRVm0TKCBrBu9n9gPV5lkVQG9LREAWUAf2lj1+RqZ2npOiei26jGqH2dp8P75Zhk0FJUXY6u6kH+iv8TRSr10QL7A34lKdgm8NE1fhXSPYznMzFjatVX1VTPMgoxsHzmGAg5+DKuOgvdVKQIYl5tCvoKC9ywF67SO0aKyA8lCYqj6WljxxSFHaRRhjgqIH5lDYzj1EMSJFf6Q0UMUYMvyWSTi/dKl0zExq8n9VGYzg2KJrhBQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(71200400001)(508600001)(5660300002)(8936002)(6486002)(86362001)(26005)(6506007)(2616005)(6512007)(2906002)(83380400001)(44832011)(186003)(6666004)(66946007)(91956017)(76116006)(110136005)(38100700002)(38070700005)(36756003)(316002)(8676002)(66446008)(66556008)(64756008)(66476007)(122000001)(1076003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?dTz69PvASaM3AZFBLmPLVG0PGmoQkDwom3upCkoEOn7TmBNajfxZTMhO/x?=
 =?iso-8859-1?Q?wCvCOdWl5iDgQejpQGj6zyXoN0b70TYS2MVBE8vyOq30hXkVUfK6oZCDVR?=
 =?iso-8859-1?Q?8GLUkG+qvl4/Eku7CJnPDz1AHbVMuO3/yAXdilPBJ/sVYS2IlfVocR37bP?=
 =?iso-8859-1?Q?8EvncgW9ixNO3bUHQG8iHsQO0vxepeloSUgaWRxfrjrlEE4YQlyK5w9eex?=
 =?iso-8859-1?Q?BruY1vivy2TT/AR1YhP2YeXjvRpoO8LjST92BuCCSbNxTJYbjDY8Swds6X?=
 =?iso-8859-1?Q?lzqGOW9a7aVwguAa7QiYeMSJoMUytw+IstBLd5WY22SwWCKX7sLfYq174K?=
 =?iso-8859-1?Q?nJuGTVbiYHLCx9sGEVei2dSI8MutLk1fCIBJd2dE5RaCz+sC+YK6HfiP+c?=
 =?iso-8859-1?Q?lUrsFfYZ5ddMIBfxodBSz0i9yhBcDjrUmVqNVTm6t+nRPVCNynvaVla7I8?=
 =?iso-8859-1?Q?Qw8PYyIEWUmXmPi4dPjCmQ63qA+/uJRda5Dh5dnozA9YOymnyob8VpIwaB?=
 =?iso-8859-1?Q?5v+XMDWrqb6FAJ7n2NiG6zqb5zKB+xzoyC85nQQCvsPI/Fvw8f7qE23+hH?=
 =?iso-8859-1?Q?5dmasjbiCjj9azx3uAsq/x8YrF1hcsX8NFkRryf/LblFF7CVtIiUYgR+/P?=
 =?iso-8859-1?Q?8hrd7A39Y9oGfNcA+mJnFNinhzcprLTt8ctz6/AukkpuZ2DzjqQYfMGHs/?=
 =?iso-8859-1?Q?cMcf/i0tp2Wr9Hqg8eaUXInuT6vpBeJtqE+bF4MZUtAiMKLEFHE32kj6pQ?=
 =?iso-8859-1?Q?egQz3PNjLRgVRLS3HruFCKamps/A1q7go3iiTKRQjFpPMzox4cH/wQM9mV?=
 =?iso-8859-1?Q?+nYm/rK459PldZ1RlhoO9t9YeYS9qBbtiKhxVId83ivEffi+7hJWj5PvYC?=
 =?iso-8859-1?Q?43VQ82IIABkbE8dY2whQ9IoOXiF1JqbjJ4hNaiG8U5i1OthV5BldAheoU6?=
 =?iso-8859-1?Q?Ciknvf8sbLNlKw7T1XPE5aRJB1AoHkcicTHVnc221eoPzYTSpntyZ4FREJ?=
 =?iso-8859-1?Q?yhBsPt5QcrHflpUyM6QybzOHYaNGfR0z2WK0yBPYtQ2DVmy4YQwKKlYSA4?=
 =?iso-8859-1?Q?v4/T1N2H02R9GYFQ6LrMFRCyJpah4UqewAO5Wzcf7h6UO5Ib5DkFi2X/T8?=
 =?iso-8859-1?Q?mobEmJVgi27u9eJ696d2/T30rGeDHpUh6vVMKFQpoZeTZZ1Ve7w6uxepVk?=
 =?iso-8859-1?Q?F+V4aSwSDish9yyctMprvxZGuXoTFdr7XXxM3oIqN6tyruRLTqpQGqVAIj?=
 =?iso-8859-1?Q?bKJ6DOIavQy+O5xm54pMmlXj/BmFjSMdQb4Km8qDEdLWdgcBPbOTtq36ib?=
 =?iso-8859-1?Q?BPWabJuNlVuLzeVdwneVm9i0TiI0i7d53wmzSeXRGxE3r6h2I4XWQntT9v?=
 =?iso-8859-1?Q?HKrVYKmUnWjn5vq/Ovz+lptpHluuM8B4Mzz/SBEk4QxNg4iiem0Eg+QEob?=
 =?iso-8859-1?Q?mmI5jtcwRr34NAVa2dMQ23e/zEzUh6s9yqzGFjcXqjTpGXtt1c0ZDReWYk?=
 =?iso-8859-1?Q?0dSEKA8pHT6HYrnFtzEl809ajVIoHt/3tpRciLwBhIyYZkNHIHGTjhDQ1+?=
 =?iso-8859-1?Q?KlrDZT2yio5oqAgF8e1Xn4M4wgngLar6MwJM/OikmNzMIbIccVpXDF6V0s?=
 =?iso-8859-1?Q?QkPGgfWkVwd6G8mROW9ezZw4FreXDFfiC0RcikjrjqbeG1vMxuXS/P+igo?=
 =?iso-8859-1?Q?C6lfB0Zc+Sb6VTutB66ArnVaO5TDUrD/kVR45DwuHoRvl5HEHEdDKBWKh6?=
 =?iso-8859-1?Q?1hzUmbR81Y125Tdc0bcXcfYBxGSps9b4aaaN8/fj9AZpWpJztcHX9+B0WZ?=
 =?iso-8859-1?Q?+yd7EtIkrrEGhnMcxRWxRKH9t592T38=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25ddcb86-b8a5-4804-b6fa-08da2d6b5ef7
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2022 01:13:57.9235
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D8nxM0o2SsUn01KTOAUuHI7UP7wgr1F8ikzsfAkOL/gJgG8KNoNQY1nLiwsjSUc1GeJVec34v/DPNijIHuzXmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3728
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-03_10:2022-05-02,2022-05-03 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 adultscore=0
 bulkscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205040006
X-Proofpoint-ORIG-GUID: QTfzMvGFZ5P9v75dLTIptlXYkdmaz8sC
X-Proofpoint-GUID: QTfzMvGFZ5P9v75dLTIptlXYkdmaz8sC
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
2.35.1
