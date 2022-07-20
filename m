Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70DF957ADB3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 04:28:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241527AbiGTCXL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 22:23:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241248AbiGTCWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 22:22:09 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4272E599ED
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 19:19:07 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26K1FXIv003865;
        Wed, 20 Jul 2022 02:18:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=wdrE/nUwbQ3B/eUPWBXX8jHi9gWVAa/HGKSZN/xnxPE=;
 b=1txbJIb9xIVZwbpnR42BW4mNz3zaC94K5XJKD3T2tcEPGQzGZD5941ixItF0fm8et7LG
 mSAh2p4q9OHu17K7Hx7UTCL8qOXpvn2bZXLrlNzOvu6B+PCJQhv6suKCzCsHcLANbaoL
 n8MCd8oOZ/b07r+QrW1Un5NJOEeK5n0PqzViUe1/g85ShUhC5Ty5+WutFzaFyHShmytD
 o11pSMDA2d1sOvKN97yD/OmhKmtXNKKr2t2q99Omc+bn2wxdiXZnHBsvBbx4ZKODrLjF
 0rHMzCFVvJKWF5lpYHXEswd8Zrc2A+ro96apiw9q85BKuqmxpMUUWEdc9hq3acCqVFgb ig== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbmxs83kv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jul 2022 02:18:46 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26JNHEnb007944;
        Wed, 20 Jul 2022 02:18:45 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1k3w3kw-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jul 2022 02:18:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GUkb+UJVcd8XdN6efIZhuVsnqjYwbemxy2gNfFERJ+BnBcWRxM+x5id6KQ3yaVaP+PyWxDctCaX8y8nnsINq2Z0mtXBL8VStr1Gl1OO/YT22ZMwnsCitpRu/mfDjMVMr/aWuha530tK9jyzV/f/2YdeNz6HJZCCgD9POKFfpbqddnXSxWbsDFm36qEh4yyl4r6BPnEaKJM/zaD/Bf3EVjfjQKOvGtO1dZYWPh/3VvlZcbt4fsQoWz9LQeI5U+bL1+vaS0f9ViOkSNNCWNSsDuvL8ti/5PdlH+6YZGx5+mB9O2Y3GubXw7HBoYprP5gvbe/Z37HOO9ptr5YZSnuQlkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wdrE/nUwbQ3B/eUPWBXX8jHi9gWVAa/HGKSZN/xnxPE=;
 b=B0oTlAnbBxeKd9jHI75vxbqMadRUxenaia9x2FDGHWyfD7K/9Vyyd+W5UQwgx3NMmVUGCDQkQtXbB4T/amnt5gZkUG2a0AOPA9U8rysy25ct1aj+kr96v9GEhdz+p+9StftX1PHzZllLYyQb9i7NXxxPUw9xTeBpeeY+Wx5UdLgRYUyBb7t/1Qd+mU+oDfbPlUCt7kwiuCI826wnP64Hez1q2QuKsoZjHOv2X0E8NdIdEAP6ZIhdRIGOITu1CvRWOALJFjM8Czsp5Zgcwh1g7BBHx3XYUDYCfkEWfwbamIc2L9GLfTHFpElzuEtTf7XJr+/CDyMCKy7ITItMjP47XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wdrE/nUwbQ3B/eUPWBXX8jHi9gWVAa/HGKSZN/xnxPE=;
 b=AXEH5oOlsPyc6t/SZ3KSf0cYSaYfD+l6X/jwCsqe9/Wdrg8xJJQKOZTC71wHkJFzDpM8zhFsYlUFcbDvMJbFeM6qGKNzWtxyGc8txYp6TmbrVi8HxP8HbvDhTQ3gzoKeOn/qO8hpkq+lQWPDLKD8zIxjwEZ0oRqXJFhl5d60r+A=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BL3PR10MB6233.namprd10.prod.outlook.com (2603:10b6:208:38c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.12; Wed, 20 Jul
 2022 02:18:43 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68%6]) with mapi id 15.20.5438.024; Wed, 20 Jul 2022
 02:18:43 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>
CC:     Yu Zhao <yuzhao@google.com>
Subject: [PATCH v12 58/69] mm/mprotect: use maple tree navigation instead of
 vma linked list
Thread-Topic: [PATCH v12 58/69] mm/mprotect: use maple tree navigation instead
 of vma linked list
Thread-Index: AQHYm97vcKMT3LMXdUqRjBMnEXHULQ==
Date:   Wed, 20 Jul 2022 02:18:01 +0000
Message-ID: <20220720021727.17018-59-Liam.Howlett@oracle.com>
References: <20220720021727.17018-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220720021727.17018-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 13eb9195-3f62-49af-abb4-08da69f62b77
x-ms-traffictypediagnostic: BL3PR10MB6233:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sLlrQ002cfjcKDUrLGN0WhLVwTd6TlOWpqRb1o9EAd9FPOZFH8NwSBHl4y1F2L3BugwNNtw4DATXoY3qVA0Z6Bl1wV0CB2e3cAhkbTUDSuUuXL7CfQVDHE4Y/gR9ciUzef0ySjsYg/XmtPzqtneCnjXej4TD6nmVTyVMp2fJRFlMj+FU79x7t0c6jVCQbtvJrD3SFeZXe6qld42K39JAuHbit9ZSohtga9pawSUj+00PWN9aawGDz1xoitK6MjyVeCLjvRgqlIHtnBqmwJnHkN5BoCQBRknbNJpHsXeRUd8WEwEsCGoYcz4Fx9n9p+yrcLyOdPP/tID36NfOtnCLEs87AEsaahnN9PjJZ3hMKNslbC1gK2WKcAeTtqa2Fq37/sHkgOq9vfLAJCSK0OrrENb24wwkp1IM3twwrUwhjEAg+KtVe6e0TEcpKEvFU/RYDBu6eBXvw8xsj9ipO5i9hwKA0wT+vEHjC0OYVe6BBmJNCnibgvDZvhBH6KAlJGXGPp+EalJo6DwlQTTJd6JAYrHTiYoWQjxNhKiQ4JSeFnntWTUwPr1L22lRFA+VzDzdAfCj8+THiuTbSl+OEGjFNd6UBCPPlJZoBjbmwZ5CpDir5CXze+8o2925wg4kWJ2v0/RzZdSlBVSQY2lDDQZSAak70Y8b6yVO1pVpzfoTnT2I3VEErFPySqWdW8L3d6puJpOS8qX5iliIwIdwiUL92x7J3PNgLTSMu9WLPFHDvc7WPaqD3cURmtI82nB3xcrbtk/ia5QALYTqtggbNB/i0bwtkPJL0kXtsGo7aGB+tROWtGIiFZp/f/X92OfGNku8Cg3Fm4lH6f6mJz/OTPAeJ4tT2UYvGgGuA795NlGE8mLZV/3fwJyO9fMjjESy0vry
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(346002)(396003)(136003)(39860400002)(366004)(186003)(6666004)(2906002)(41300700001)(6512007)(1076003)(38100700002)(6506007)(26005)(2616005)(38070700005)(86362001)(83380400001)(122000001)(478600001)(316002)(44832011)(8676002)(4326008)(64756008)(36756003)(66946007)(5660300002)(8936002)(110136005)(66476007)(91956017)(66446008)(66556008)(76116006)(6486002)(71200400001)(966005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?fXHlQQwyZ1x97xYmvrQ3XF2nEsNfsRwXlulVmKuzdiciXa2NvkyJBXmGhe?=
 =?iso-8859-1?Q?tpGavb6cVV8pA1lHHMc9uZoUcDbyiBlfTas1iBSRD8EvgSmqgnW+U17/4P?=
 =?iso-8859-1?Q?cgKn23yonsHO0aDfpQFipbxTtumnF4ymXEHxABu1P3tuRpnKP4kO4fbVSa?=
 =?iso-8859-1?Q?a1g5U+bcxWwpTRUf1dE9ikFZxl+1Z5RVHX69EwnhcTEP2rMJzeoOg+mOIz?=
 =?iso-8859-1?Q?Z2HFkFE2TPc9xifWfBty08nHajbDoDI1amFCgKMCelbMY4M1Wx6PW8eMhb?=
 =?iso-8859-1?Q?jdFs/KajSIApyXqz+15qh1HJPWzFqb/Dj7ojpLkwg3LQ4uZu6gyeXYw6sk?=
 =?iso-8859-1?Q?rrghKE2kDikubKOlgrLwQQGGfv0kQQVTFvqJqAUiyHOBNmfUPbaGwCuKop?=
 =?iso-8859-1?Q?tMo4BNYTXweLymq0I5Z38sQy2PjLPpDFyuuauTy5Hkc1s/71R1bOVuwpp1?=
 =?iso-8859-1?Q?I0Ged64zxZfDkp/M1pP5TDPtlPrE4vxs5p30lFkx79dxAN/92U2RTaC+CT?=
 =?iso-8859-1?Q?tItfUeGa6iTq4FKxPgatJE1bym6DbMl3wuEbopLqpe+lI9uuBxIOBCQJtX?=
 =?iso-8859-1?Q?C5o14F2MwW+ak30Fmch+f/YEXns7g7IVHTLT2mGwa2KQajvzFKETY9i9GO?=
 =?iso-8859-1?Q?HZuP3BnqZhCUUgTziUg3SF4rljC6kZhGfa/X4RSzuoyf32qbOuOgH3IL/3?=
 =?iso-8859-1?Q?wnB+04YcDi/J9/tRSp048xMvkqF2B2gyLnrpa98CDrbVdVQEybm+2QGqhd?=
 =?iso-8859-1?Q?X8s27kofhgDI4u5ssXwn4rLGMHdxhbvjnZ0NaHWujDc57I+apjM89hto4t?=
 =?iso-8859-1?Q?lT+JlalauEpvtq+12wh/xiEeaE3DM3c+3UfxVlJKOmCo6rVW0EOpGtGqhx?=
 =?iso-8859-1?Q?eJPuTmZmczScOCNkeF0mPwIXe5QCM2QbuHDV/6jwxdfwFAp1O1rZH1vf2L?=
 =?iso-8859-1?Q?WKzHLVWwM3Jd9VNciGyzWvHSsvD09JO9jsuJvHCWojfBSAJrXsIENBIoSZ?=
 =?iso-8859-1?Q?yf4RCwvdFMRYmuMOtFHmBWpCY8iPNFE8zQ3x6tGYizPoPV2T9TXYh6aevR?=
 =?iso-8859-1?Q?RmdIHHAe+FfRwnuKxMjmfNr0WAuozNJ2d0kpv/268hlOaRUu5H/UXHpBrj?=
 =?iso-8859-1?Q?Fg7x/6nbNJYfPBq0lp475FKxpF6Kq4IN2yPNsjNtGl9MXE+yqxaHRMeR33?=
 =?iso-8859-1?Q?OiOjTo33xN8P9QvQ+tgxHzu+rsbGLf6twsiZ6PdTvnH4GILFvY1x1j5Lz3?=
 =?iso-8859-1?Q?apRva5Sj/2cF6zKmKPWwNSLZQuhTgs9GNsjM98MwTiRK90905sev1S5ooR?=
 =?iso-8859-1?Q?frZEECghYRaCzI3hv0bFyJOC9ICeeMATa/v/tQDi2M3ZSm80AJxLl6Bnaq?=
 =?iso-8859-1?Q?WWV1jMIcvd8AAOOUBGSPx4ESzD6c+UYRCgRR8JrENK1mxVYgrbMFitJwQS?=
 =?iso-8859-1?Q?K52Fj3Y2+3466YvDNip1GxbTSw5lUrEOAw1QG2BrXVlrKxCmWIii3+lqOg?=
 =?iso-8859-1?Q?MV/LwyLmqlvymSPnKj79q8sZJOc/N5poqoGiC2jM8zenLAyejAVUoXHvio?=
 =?iso-8859-1?Q?eJ9peZ7yHonpgQAtdnKYfUuqi5LcljCqAzj59TPS6CGDRyWmgGWaUAUL9Y?=
 =?iso-8859-1?Q?tQZyMQZ8K0JF2ydExnZ+h6TCQPRQMj3/85uVEKk11R3tOnyj8K6Zh6lg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13eb9195-3f62-49af-abb4-08da69f62b77
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2022 02:18:01.8518
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OVNT6suH6xkyXRf4O7iF0MvQVfMUpIEORXLTr+kuoXiifzVsBxbVWySCWvW9CVcZJQYbnTQqB2uZ3RwdvnNe0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6233
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-19_10,2022-07-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207200008
X-Proofpoint-GUID: Z1HI7NOZRm-hD5gH3vHE021wT-ptT0Ir
X-Proofpoint-ORIG-GUID: Z1HI7NOZRm-hD5gH3vHE021wT-ptT0Ir
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

Link: https://lkml.kernel.org/r/20220504011345.662299-43-Liam.Howlett@oracl=
e.com
Link: https://lkml.kernel.org/r/20220621204632.3370049-59-Liam.Howlett@orac=
le.com
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: David Howells <dhowells@redhat.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: SeongJae Park <sj@kernel.org>
Cc: Will Deacon <will@kernel.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 mm/mprotect.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/mm/mprotect.c b/mm/mprotect.c
index ba5592655ee3..27fb652151e4 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -621,6 +621,7 @@ static int do_mprotect_pkey(unsigned long start, size_t=
 len,
 	const bool rier =3D (current->personality & READ_IMPLIES_EXEC) &&
 				(prot & PROT_READ);
 	struct mmu_gather tlb;
+	MA_STATE(mas, &current->mm->mm_mt, start, start);
=20
 	start =3D untagged_addr(start);
=20
@@ -652,7 +653,7 @@ static int do_mprotect_pkey(unsigned long start, size_t=
 len,
 	if ((pkey !=3D -1) && !mm_pkey_is_allocated(current->mm, pkey))
 		goto out;
=20
-	vma =3D find_vma(current->mm, start);
+	vma =3D mas_find(&mas, ULONG_MAX);
 	error =3D -ENOMEM;
 	if (!vma)
 		goto out;
@@ -678,7 +679,7 @@ static int do_mprotect_pkey(unsigned long start, size_t=
 len,
 	if (start > vma->vm_start)
 		prev =3D vma;
 	else
-		prev =3D vma->vm_prev;
+		prev =3D mas_prev(&mas, 0);
=20
 	tlb_gather_mmu(&tlb, current->mm);
 	for (nstart =3D start ; ; ) {
@@ -741,7 +742,7 @@ static int do_mprotect_pkey(unsigned long start, size_t=
 len,
 		if (nstart >=3D end)
 			break;
=20
-		vma =3D prev->vm_next;
+		vma =3D find_vma(current->mm, prev->vm_end);
 		if (!vma || vma->vm_start !=3D nstart) {
 			error =3D -ENOMEM;
 			break;
--=20
2.35.1
