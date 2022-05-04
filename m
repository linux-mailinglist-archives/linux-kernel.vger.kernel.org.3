Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18B1051934D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 03:18:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245649AbiEDBTb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 21:19:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245093AbiEDBRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 21:17:54 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EE36434B1
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 18:14:09 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 243Li9UZ025194;
        Wed, 4 May 2022 01:14:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=2aBPMD8xyQDIcseUFq99nGOFIefULKFLFSEoKwAb2iw=;
 b=Y5q4bYW4b6+MtbroB0a2divG6c01MJ+LkYUc0DsKTjXI7yuDzbCpT1iZMxj273EAeMMz
 5HTGAnSMmTbZzdIxNkZf+upRAgH9Zj/TRugToGuWJIXKBQAnHz2oAIdMzpQUw9EGAbkf
 yCJWXZ90YA/1B8KiOtsOdQqu4alP8VcXGTEVm+nPkf2h2nlDsu6TJ7ZTlFFZj7jZhmjb
 j+fZN3mpZwmX9KJncyNLkm5A47p7ZQxTdNiVRQm4hohjv+d39YGOaywgYpK32WPq8aFe
 C5/xRnky320eMPJqMFfhpXT9IJDdWJepDKZDOOgBx3yqs889PriwSYGA/m52qJMtA0uh Mw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fruw2f6bm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 May 2022 01:14:05 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 2441ArPw020035;
        Wed, 4 May 2022 01:14:05 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fruj922jf-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 May 2022 01:14:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jihK/vJdHI0zYFUJ5lSunjw0/xiIY5jesyumlBfIG/cYJXfa9vegwQ9tzRgWI6E1BOzuqtbxRZMYIL9aL0xxovxhHjtaWnC3cUgjsfKqJY6GhdMovHevCGZH1HbJ+OChCK5RUlhiFK6gqeIIbzK5ZNYiWICaxobEeS+ZcOxZVilXKlXs4t4AAcn5irvjgh23pLsrkuSmNLPw42M4Shz8ya6Du4nS7I2as7VBZr2m7RgZjcKglM6jBe+QNeY55TFvSdniDYniCDxETnv8t5TS9LPlcvKVlnLBEwwNVJqCRCri1mG0bkit/6OmHNeDzux15NmA5A52XjhiR4CLJpn5wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2aBPMD8xyQDIcseUFq99nGOFIefULKFLFSEoKwAb2iw=;
 b=VHaHBUTlc714Mt3CQIHHROARQYO2BGln3sQMz/3y7mso25ymoW5dddGHoou+EfTc/AcCWfbjGWC2o3lmF+h9naQ9Px/WnOQirHbGHYGXF4l6ovVH0Tt+Z7Ls0TEzmMsDA01BiKz8WNnPaz6fR6TMlXRJ6+Nlj3a1pByB/zCFRTi/eiAFdVLufk0SMsiB290r1JYEmmc78/urEHZhyeqeUmUDDYvMZVr8YUkoYWFGYA+hWP17w3P9ol1LcHr0KiV4oIe7nQFxZQMJ59k16t52w3wBR45cPQr+NvMmmljzMypGz7La/KO67yVUewbL/7ag8aEX+P1GUDZh0mTizvga0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2aBPMD8xyQDIcseUFq99nGOFIefULKFLFSEoKwAb2iw=;
 b=o0ITxx9xcb/LNHHuljZRe4fR+ZKEKxXF3cLbWyMeHbcZzQFy7hDrii7gRF1DWDEqv4h26ExXOm0Zb1updjNd+Lk5QcG8J9Nqf+Hf51lSmrc+cch14hsKeq7ZjfJLwkctB+ZmVDn3aaeNAsIwWX1KT5SUmA6TFBxBmo8Njon2AyE=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by MN2PR10MB3728.namprd10.prod.outlook.com (2603:10b6:208:115::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.21; Wed, 4 May
 2022 01:14:01 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5206.024; Wed, 4 May 2022
 01:14:01 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v9 41/69] exec: use VMA iterator instead of linked list
Thread-Topic: [PATCH v9 41/69] exec: use VMA iterator instead of linked list
Thread-Index: AQHYX1Q7LXfSeb614U2YVdRUL4gOFA==
Date:   Wed, 4 May 2022 01:13:58 +0000
Message-ID: <20220504011345.662299-26-Liam.Howlett@oracle.com>
References: <20220504002554.654642-1-Liam.Howlett@oracle.com>
 <20220504011345.662299-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220504011345.662299-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4771184a-cca3-4f98-d409-08da2d6b5f99
x-ms-traffictypediagnostic: MN2PR10MB3728:EE_
x-microsoft-antispam-prvs: <MN2PR10MB3728ECFDED84D1E0A6D93FD7FDC39@MN2PR10MB3728.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EzX7NzeNqr5E1rgV2khCZxLS41KMv8OZzb7EkUKEmhQTq+yl2FYQ5GpohbOCsb1MoPiFhUMEVwXMnB7F2YCrUAPFpEcxvZqxzZAnwp5vKSZN1zDWHG2MFmi2CwmtKYoeszRaVl5vfO3SjjTnwiNzEzPWc+VEiVcgiA0Pbsy29HEQYoi78ufCNlttIZJXhSSuob73v7Qb1RDIx2Kx0CFk0RNJdPyuy8Z/2QWynRDUGzGYJ8zhpUwl9+fi+v5PomvoCr0MN4yeNq4/2q/KUUyKm8gn5+Wp1rHmIUaANmenu4e69mAfMSjcFWCYPrguLxuSjYJ5PkI9iMJIu5TgkaM1PYCOu3IKEIaTm2c+s6guDq5io/+hcvsvt8aH4WSlO/ERk0v73ZaxSOIHgH+OtzSCp2Oq31YfkKWenD4nZcZRL3hlK77OCBE3aJH9Gk8KU7fQt6Jwk/SQqnXe0oGl/jBKdqqnU7p8jR7Y2I94gdJpPtg1qlZ5sZB9bpndSeFfCiDBYN4V/Nx63nBC5qLxQGQbQ+tDrOHbv35dhdeNdOZMuxt2Iq5kl7N6MFhURckVwSXxcJrqDrGoYF24pGZGpX8HZOzbnTnIlSCmE+0lnOBMkMqRlNAXLSy6PDOlR18w3yJ7i6UWsFqvovCO1BSaUGOItlLfleakQD/761Ujhu29XG8SSUGO6wR0Hopsr+P/JlFp+RZOeVRqQNy+DeCB5/Suqg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(71200400001)(508600001)(5660300002)(8936002)(6486002)(86362001)(26005)(6506007)(2616005)(6512007)(2906002)(83380400001)(44832011)(186003)(6666004)(66946007)(91956017)(76116006)(110136005)(38100700002)(38070700005)(36756003)(316002)(8676002)(66446008)(66556008)(64756008)(66476007)(122000001)(1076003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?SSTYTQuFcoWy9iEh8aAXwCcGR/XdpY1K17K0FvFQVByPP+x3sM0D3C+Jy2?=
 =?iso-8859-1?Q?nCkWUFzTatWAoNEPh1rVESU7MPf386tVfeDIV734UUMsjmCn/z4Jve45Ae?=
 =?iso-8859-1?Q?jNHVl/gB+tSl78RTzmRte/pn7vr3dsnY2ss2viKSJ/KMtER9YHrgES4TsF?=
 =?iso-8859-1?Q?MgAqU3eIEmrVp7jDm5GTDkwphiwtZLi7K8HTppKo8wuiom0diINjPAU8+A?=
 =?iso-8859-1?Q?gGgvrUp/6XHtHLNsL/X35KXdGskt0lJKegil/xyeX3QEiqjA3Uf+GZ/Wqw?=
 =?iso-8859-1?Q?1VsHYZv8Viy6TzuWu0ZAWvg/Hslbck0bWilVGjwHHFn8lC+4RAT9joclQf?=
 =?iso-8859-1?Q?xW8H2/5Gw9wxtKxwEscnLAvqTtcYOyo8GEXX52LFthULDDyK2bsoSkkkEp?=
 =?iso-8859-1?Q?IwPZ+nk91cD80ZeM07X4/ce9pObLDNRVnwTxBrHtyXhvGmJkXY76bgdSNi?=
 =?iso-8859-1?Q?cswnZ8vJFGAQScTiH7rYHO4q7rSqk+YbFwHhdmDEeGGFMEg4ZNIyhuMSl2?=
 =?iso-8859-1?Q?a/LLu6GAYnWvYDL2SVh9F27VuYXXZXszjfiu/ubjuGbaY90sUkJvd/udjm?=
 =?iso-8859-1?Q?lMPw5VO2vDbD3OP/7nuUsyuL6djZKTFSNwn04k80agNeiL8rAuypRBd4gy?=
 =?iso-8859-1?Q?HuAWJX+DqSzK/LExPOkfkMMmZy+WfPHw2qSfNQROGwrYXjI0VGImftaqdw?=
 =?iso-8859-1?Q?Ui6VrfSdk6nB0TfU2PlkNI8dk92sXenjde3Ihx2iOnInuQxk8O1l3ONfzA?=
 =?iso-8859-1?Q?Ih3kH7XNHk+9onuAtRwubzFDKT7glxs8+Xy+M5OnMNVMp7CS7GGZ0zxB+n?=
 =?iso-8859-1?Q?XmyHhYJdTWlmYjVWRc4qiqbdXWkMXHcdiTXC4yDTdPJ+f129DVjHsB2oyk?=
 =?iso-8859-1?Q?Bu0+SMsVcvlvMy24vaKgY3tEv6i0xWSmgdCBCatNy7mF5xtr9vrI27hknV?=
 =?iso-8859-1?Q?q/AOJLvNPNJXcvzVo6Twvt/ictepr6tDCClVWDdWFevMfgscLlw+Q6cPvx?=
 =?iso-8859-1?Q?e/h7O4z08nri5bYof9JWB1XV3DuAnxiF88EsZ97O3QCvUicViaYQDYyohU?=
 =?iso-8859-1?Q?hlaMAESBI6l+R6uLDThIhaLpUX1js27pcPgfsavh88rZqITNSI4jv6H06C?=
 =?iso-8859-1?Q?nomowtdKCT336AH+I/RwX8u/kp+EzYUNV38gPJjasTvubcf/LSNXJFBVQZ?=
 =?iso-8859-1?Q?MK2qTXwWuETtiudSIgHsjIks+RP9O1KWQrBOkBzmXAefEqLpB86niEI24R?=
 =?iso-8859-1?Q?ZgcfUJZ6jHNrK/uqCrQ0YG/imfWXOrMfkTyiZRWzNJoKHu5292b/+s1v7g?=
 =?iso-8859-1?Q?GZB5vvJMyrFqL6/ptNBUuo0Lre1FKyyoDJlt3GYgVZkWEcg9ZC0YoDhzBi?=
 =?iso-8859-1?Q?O9uHDYis6/VfJLQOb/R6cd12bULjEQTPgh5Qvg15IwrCYaW7xUgSFC9YFC?=
 =?iso-8859-1?Q?QfTSpPfIaZ7+kSo7ihK3DC0RHjsm8elkRuez0gAU3m1wpKepTDUVhZcOkC?=
 =?iso-8859-1?Q?eo3dvFxhtQGG6RAxNbdhq1IH3FIL/vJSCQ3zsEYeZ9OkxVTROY7KYDC6jg?=
 =?iso-8859-1?Q?Hp/L34a6OX4XRyjH8FAslLHIbRjwiC2SZuHHBFbU/OGiiC17ccdzut6gJT?=
 =?iso-8859-1?Q?sHgLPddw0GL+Iz6PxbC6kVuklCgC+s+eMg8SsorP2EDUSJoIaiglAAV8gT?=
 =?iso-8859-1?Q?hnVAPD8+7WrqmUqgVaKSYnnEepaeCxigm1N5tTOVl1sox+aGZWVDTw4P1R?=
 =?iso-8859-1?Q?5Pi8zNgyh2+sxITc+zlKjbYu5eqfCLr8UTCHfoNzrdm5seSYSnxCrof+dm?=
 =?iso-8859-1?Q?QyTBj5Wil5g+wIJ/D8nSeVs0sCrlF2w=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4771184a-cca3-4f98-d409-08da2d6b5f99
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2022 01:13:58.5797
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yx9pxNhgY0Sb50PwXqcWDQU8gOofgto4larBW7hfE/VB1NNj+rVV71DNGV6cxQMSDW41rJWNe+47SQXkJ9j/XA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3728
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-03_10:2022-05-02,2022-05-03 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 adultscore=0
 bulkscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205040006
X-Proofpoint-GUID: k1f0wEe3Y73DI9pHBr5zN7Oftk4GSbH1
X-Proofpoint-ORIG-GUID: k1f0wEe3Y73DI9pHBr5zN7Oftk4GSbH1
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

Remove a use of the vm_next list by doing the initial lookup with the VMA
iterator and then using it to find the next entry.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 fs/exec.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 14e7278a1ab8..b5e3bfd52b53 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -686,6 +686,8 @@ static int shift_arg_pages(struct vm_area_struct *vma, =
unsigned long shift)
 	unsigned long length =3D old_end - old_start;
 	unsigned long new_start =3D old_start - shift;
 	unsigned long new_end =3D old_end - shift;
+	VMA_ITERATOR(vmi, mm, new_start);
+	struct vm_area_struct *next;
 	struct mmu_gather tlb;
=20
 	BUG_ON(new_start > new_end);
@@ -694,7 +696,7 @@ static int shift_arg_pages(struct vm_area_struct *vma, =
unsigned long shift)
 	 * ensure there are no vmas between where we want to go
 	 * and where we are
 	 */
-	if (vma !=3D find_vma(mm, new_start))
+	if (vma !=3D vma_next(&vmi))
 		return -EFAULT;
=20
 	/*
@@ -713,12 +715,13 @@ static int shift_arg_pages(struct vm_area_struct *vma=
, unsigned long shift)
=20
 	lru_add_drain();
 	tlb_gather_mmu(&tlb, mm);
+	next =3D vma_next(&vmi);
 	if (new_end > old_start) {
 		/*
 		 * when the old and new regions overlap clear from new_end.
 		 */
 		free_pgd_range(&tlb, new_end, old_end, new_end,
-			vma->vm_next ? vma->vm_next->vm_start : USER_PGTABLES_CEILING);
+			next ? next->vm_start : USER_PGTABLES_CEILING);
 	} else {
 		/*
 		 * otherwise, clean from old_start; this is done to not touch
@@ -727,7 +730,7 @@ static int shift_arg_pages(struct vm_area_struct *vma, =
unsigned long shift)
 		 * for the others its just a little faster.
 		 */
 		free_pgd_range(&tlb, old_start, old_end, new_end,
-			vma->vm_next ? vma->vm_next->vm_start : USER_PGTABLES_CEILING);
+			next ? next->vm_start : USER_PGTABLES_CEILING);
 	}
 	tlb_finish_mmu(&tlb);
=20
--=20
2.35.1
