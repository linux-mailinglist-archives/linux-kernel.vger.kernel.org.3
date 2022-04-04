Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 232BB4F1758
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 16:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378174AbiDDOmi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 10:42:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378002AbiDDOkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 10:40:09 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 869C03FD9E
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 07:36:39 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 234DoQmD006381;
        Mon, 4 Apr 2022 14:36:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=zlw9qRD2MOzXB2bZqb5JsUnrnVqT92O7Ofe5TOqYXqg=;
 b=prJ2NpaazwKvdPzGaCQlMD5wyA7BcHY9iZ9E2mzYdERk5fhxGAjviDsHBBy3Qw59TfJd
 6VHqzOQSkfaJbjESG8Mhzk8I5uxE0f7aTw2Y7N0Wtt/xPq47iWYOYyaidG/yCEwfyXcU
 rpldWl1yhuRsPi0HhY9xP/50zvS/0PHSYqriWBPoFm8fH+t6J4lU9DzFSwHi6IsU9bKI
 HE+hXbIRZNrD+SvxaXeo4G0nY+x3vqPQHLyJLvzy0aB9/3yDsHa1TJzJbTEHweZSe8I/
 fHktNzwLreWHjiqGIRon1ABu2HvIg6xYrQjV8CZMdoeT1dBUkZZvGWwAq0TNOfkusXom 6g== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6d31bf53-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Apr 2022 14:36:33 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 234EZaZ4034331;
        Mon, 4 Apr 2022 14:36:31 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3f6cx2mj48-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Apr 2022 14:36:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vino0Kryr9SdaBik4RlYDwLAZEjsUj59UQLfNGUNygQIMtZa+5aYxtsQmT2dlw0D5k0LVg/DCeQqLJlIuNygK/iareqTIfe9E43h9zc0vz+hKY1Y2ykgCurMLwtXNS9uWtPXPGDSBIyUppdSkILILsicRcOZ93aHFovEKm82QZwa+0mgRjJgMErBYO6x4ofcN1jMK6U+wyjspvnenNwiv1JQ4OslckXalHA5rxRY71rPYP5J7hFV812WMOahUgGVqUDsxms7a7ITZK+cjsZWLz34jQh+/OIfDkb5SgiIinHIZFBNLyOBcPrwQWm5EDPaZ6X+ocZdXbaDrq/nW6wQGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zlw9qRD2MOzXB2bZqb5JsUnrnVqT92O7Ofe5TOqYXqg=;
 b=BxEoiE2AGT6OIFD4GjFzgjiJEwGmoTtpAipU5mFHma7pMlRGPjYDHm46OKmPPiaONeqShpFIzvhsxI1kXhlnpROhr5cUbNzJxzyVwBhDrFfgWOxqDeO2US1LCqNiq3pRkcx/RF0cgS8ouyTXHtgJZTTOn16W2Uh/RhzP0oMFDwV6lE7fFOH1Ge80IAYfBvtyuMEtdEpDKCsyeEiroROlfWK76pJHHkvzSX6bMauRYwBKJDj0NL+vs+7I23m2X05arzEqITHkwjObj+gzNrb4P1vpJ6+iKz+jxpmXO9F4ihdKU+F3COLGiNVJ5xTZlSSMQIY4xzBX+0/rj8BVAI8XkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zlw9qRD2MOzXB2bZqb5JsUnrnVqT92O7Ofe5TOqYXqg=;
 b=UI8wOOPacxxh1RxwGa590am9nBfQ/YCHsD4gnYhUBrhRGvEoAqU9Bg/1p6U/r3nPBiFOz+V7opOh/lE0jVct0hjW54/X/1VIa+RmSCViShDEc8V4xLAg1pLJX6ndWooXZkZN65EYDk+HNhWnsmuyByD0At3XRQF+V5aFbPWq0WM=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BLAPR10MB5329.namprd10.prod.outlook.com (2603:10b6:208:307::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 14:36:29 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::74fd:df41:4c93:24a5]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::74fd:df41:4c93:24a5%6]) with mapi id 15.20.5123.031; Mon, 4 Apr 2022
 14:36:29 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v7 53/70] mm/khugepaged: Stop using vma linked list
Thread-Topic: [PATCH v7 53/70] mm/khugepaged: Stop using vma linked list
Thread-Index: AQHYSDFJRSx/UHBkvEmv5jASWpJPQA==
Date:   Mon, 4 Apr 2022 14:35:53 +0000
Message-ID: <20220404143501.2016403-54-Liam.Howlett@oracle.com>
References: <20220404143501.2016403-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220404143501.2016403-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8b940767-4e42-43a6-da4a-08da164881a6
x-ms-traffictypediagnostic: BLAPR10MB5329:EE_
x-microsoft-antispam-prvs: <BLAPR10MB5329127B9A38BC848C758F39FDE59@BLAPR10MB5329.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MKw2ptfNA726kf+MfbprXGM3mLUCCw8eexpK7NLEFiTLSJpvMaZuOvkTeGSYpBS9ySoAL85ewYM2LW1DbfMwk8lbqG5KcTuRUg0aCzK9jjQ8yXmgX7sTrcZ8my+bdveiPBglDABPbItsuoYjuco4pIvGOUVCxIpXXaxGWHZs7UOGJVNG8tX6lVuNunlSGFbvaOwUYawrcAzKpYzazuSUsv5+MBXWjsbJffPyaViRHiJRbactmi9Dv9bWmSeIROPpyUxrtjcuVq7yYmrZR+E6UmlnmysG1qngcnwFfL3R+SH6NWDbLvsu3S4srtD59DUgzJD3Rta+jXb1w/KBm1yuXqnKAT8qruKCs+zuJoqavLBozxkbN6qvu9UBalR8AnAeXCcT7guBaK+RV708t/vheR/NlwFm7AaK1ABAoY3fdwxKSl0lWsvQw9zla3IHIIdi0cADTC3n9QQmPRkmoMsGsWq60e6vUilVWJVlBi93/LKWQKwitotudWNTkjESLI75YnEz/Hs/Xw8BDI6M8SCg9Q74lJYbWumlzqlQMkeYcUFXmcdxNSUDAwIyy87IgHmIXCTgWexnHs7QAbmPfbp5vg3sBnjov+Y/9XN+edZzw1Cq0rcgfr2v1b3Qpzyx+goFAMZKPCKNqjNNsrTMIuAB86chvcIHYI4t0Ckh3iVd2qrSdro8vrDHQ2EPW0J4TCzbH4Hxfc2nLX+/zXw8KDIs7g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(6506007)(64756008)(76116006)(66946007)(66476007)(66446008)(91956017)(316002)(83380400001)(38100700002)(66556008)(6486002)(110136005)(38070700005)(86362001)(71200400001)(6666004)(6512007)(122000001)(44832011)(26005)(2616005)(1076003)(186003)(8676002)(8936002)(36756003)(5660300002)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?lQ2No0zUD7O6stqN6mRCDCx8m/nWM8z/IGGTRrg3HK7e3N2T5IZLGznr9e?=
 =?iso-8859-1?Q?FuxZfGSDn0W6BopWKGJlSMuq1mEYTsIy4LH7zfhXq3G0blOLtyA5WO9Y1b?=
 =?iso-8859-1?Q?1wggUtkeZkvjC3s0ecOqMRIIaFr26N5OT5IO+iPyWBXTHYVxg7nlDvXPt5?=
 =?iso-8859-1?Q?Iu2wUI1WWXgLRsY3g2M5rd6RG7McyF98yk+V/qrz4X8DBbKfvavjiQiNJK?=
 =?iso-8859-1?Q?lAyHlB6niyq5qnNdIVYmQjm7Xx2gXoH+ilAQHKShinEh1i6fvBjYOdbG3U?=
 =?iso-8859-1?Q?UlsfNt8wAbfbwLox994IDN3n7jKyi1EOGg6Mb+H2vPiDR4A/DASNs2rAoE?=
 =?iso-8859-1?Q?zgWUZ3d4n+BqJXsopdTFI9400FXrS801QWVpNbrmf9n7pwG6qTCRgfP5hC?=
 =?iso-8859-1?Q?Buysz/qtCP0wiT1ESBdSIk8CQayuY45voY+Fc07TpymNulPTzd6IPZyzhf?=
 =?iso-8859-1?Q?UD7d52ZfAAO6EIBYTkRqwa+AFL2/EkKP4F553XdtPJ4dw4JzNow89P81l0?=
 =?iso-8859-1?Q?3hGxR4qUsEDj+p0HnudeS1eS5gAxbvyR1+62SITfxZUPyzE9PKXaGv958Q?=
 =?iso-8859-1?Q?KYCvrhDxdThIZOkd+41g9gZDVyAtYbhLJmxYm3z8EuOYdD5soed2x22rNk?=
 =?iso-8859-1?Q?FFR6pBeapZJZ41lHJxUAB2LL3KYrr4yAM7LdyIBl7uB8yiSYttRGkbcFKQ?=
 =?iso-8859-1?Q?GWjd5eyO52moX8FLwvHEcKp61s9heaQsRkz2wR1mODwaeZjFr6UIXxkHjZ?=
 =?iso-8859-1?Q?OFAC0n8QI0UGgNmKtN9wZ0b9q2lqugza2xpewAYqO5hkoVUcDGOL3YNxK+?=
 =?iso-8859-1?Q?fJ5G2xFuQW3B9GQDfMGgPLH9wXeaCcXl8mYisIrXxR3ZgV2n5a1SMy8DeP?=
 =?iso-8859-1?Q?zglysIANj1jFVgPO30RNjrITEA2MYAUMzM8RHkP+WksjGMLjot2Q/iMuUv?=
 =?iso-8859-1?Q?7usuBjN+rFMBgV9R34NC2gV7iPVWU9hkMJc4OSd4p4su9tDtxatOsB4F6d?=
 =?iso-8859-1?Q?cTEupgf6vvEILOJI2FMJrvCueiRsZB0QFsYBjv5+2ExRGdVY8+/uYy7hNo?=
 =?iso-8859-1?Q?PHkcWYYk1dUBzzW8BrymZp93qweEVpjpwEi2kKcvFjlpRLZK4cwRynVoqe?=
 =?iso-8859-1?Q?VTIi6Da1uLZ7szfFAtNFuv0tzC2v3TyDAPA+tEiTn3qMGTlWbNPUFqs2yt?=
 =?iso-8859-1?Q?U38EPIIebCTqEKaN3ofkodPAXoYmveerdmLC7xZxmIcmt3L4DInm4/KKMK?=
 =?iso-8859-1?Q?9L7KN1H8B+YEjI5hWvj3gWHfRe8YkKf+ONZBlK6pZPveCLXzXDKz3KIXXm?=
 =?iso-8859-1?Q?eKEJzoR+j001v5p50Yg4T0ifDrsGbl2SXge3eRf+QZ+VK9naNBKxVo2qRe?=
 =?iso-8859-1?Q?aoTNMwblPOTo0PB8Bl3GKqmZDpK00pLt36w0qn2ITLTPf4RLfRvjvIsIgC?=
 =?iso-8859-1?Q?EdClSiZwK+44N6A2gHG6MQduMPosn4GHPjY9MNfIktB+W+GXt0Zsc57iW0?=
 =?iso-8859-1?Q?XIDN46ZlVYzk96fmBXrjrY5gMtJjxQ5eKCXXfeLENGVasgYA7rsc6xyuQ4?=
 =?iso-8859-1?Q?FzeDBP6la839T0O+HzKvVPslFtvRJadijFXjvOzVD6CI7jNT5JkUReaBEG?=
 =?iso-8859-1?Q?G6wLNAA1jad138ns0W4DdumQw8tkRiIQjBWQibX1pAAnSJCgnJYUe0eNfh?=
 =?iso-8859-1?Q?leRUYy8qNJugNJA1qBfxSzxMio04SRO3F4iar7vEI6hy86XLmR7JNYPpBq?=
 =?iso-8859-1?Q?45s+ocRewjIjwVYMhgjqEt1U1Crf0xM1lAPWoGjHS98Kp7pQdIVTdJfLWs?=
 =?iso-8859-1?Q?z2fUcjo057y3o5JDvwalX22Gl1iAqKU=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b940767-4e42-43a6-da4a-08da164881a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2022 14:35:53.5647
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sROgmIqtFmN6XkBBt7wbj8Wk/WTuNcpai14KFnUJXX9AHqXpJHpwCMWBiPPvtnqCZxen5FpboqKSIo8EcCHnrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5329
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-04_06:2022-03-30,2022-04-04 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 spamscore=0 adultscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204040083
X-Proofpoint-GUID: hqudOX5LE2dKWVWkfjmRDBKrYpfcvCFr
X-Proofpoint-ORIG-GUID: hqudOX5LE2dKWVWkfjmRDBKrYpfcvCFr
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

Use vma iterator & find_vma() instead of vma linked list.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/huge_memory.c |  4 ++--
 mm/khugepaged.c  | 11 ++++++++---
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 2fe38212e07c..2d309163852a 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2222,11 +2222,11 @@ void vma_adjust_trans_huge(struct vm_area_struct *v=
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
index d0c39b4a78fd..dc9bbb5fac53 100644
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
2.34.1
