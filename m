Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53CD4553BE1
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 22:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354376AbiFUUrd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 16:47:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354322AbiFUUrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 16:47:19 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42D342A26F
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 13:47:18 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25LJ1TDs009747;
        Tue, 21 Jun 2022 20:47:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=llWcPA+DKhYp4o7YZO4kcC9Wj93i7Ctm1xeD+7zqiiA=;
 b=xwt4IJUjnTGwUXBzZDTMHjxwVVqgyB8cj07UZO2IhkgvVf7RnkoJKRnXyjLPhhgieLFT
 BOhBg44u4opODd6zAHZgTA0IwtVWyjPjfd9bcMDZIFmOYX6KcYUfvoRRerMlLWZVYZu5
 cesaQA4df/6jOA+K9JjDgjpyweUzP4hD2w0lOJ4kejFCBeYLBsrSuXbMzkOIaVjPY6Hn
 rzU0uD4yGempyVL11jQ7NoJ0cNz6B5tyMtcqMWAhIFbsFkyApremcBAX4UGD7TJH0zvM
 kRQfLMcTjOFfZHkRoMbC0mxsv1PfdUCe/BnnjOoJS1z4Z4b7xnv6WTUj/q+Sm3aUSTDF ZA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gs78txpca-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jun 2022 20:47:07 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25LKembl037937;
        Tue, 21 Jun 2022 20:47:05 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gtg5us8n9-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jun 2022 20:47:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LhNBTvhCqWlAwVPl/uEmeFi2qX7qoxP8X7IwAVugfG3lAFZEpRRI1390dWbYDCDwAvK5rkzediUeeLuK29bHQKhY5Dkk6TD5APrb5CZ/EcgYUf5f1RANAubxR7OEiRA5tFjWJBFMUAP/o/08RMlCGXjL4iikjjf62uDGyF7kV9+Fo4PWebNdctNNeQ3gENZij/th/X0oaQuoYkS2EKJOVv6Bsd8zb7brD7EmrJgCPpHjP1AtQHIW+70QWgMSljrpXG4BBteITp2w4CnyNDV84mTbvxATPLA+bTiY72b88Od9utvwxVfyaJk7G22bbSDNQHHuCcpQZb+UjGn3Dtxasg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=llWcPA+DKhYp4o7YZO4kcC9Wj93i7Ctm1xeD+7zqiiA=;
 b=Hybz4a+Fx10aoy+tk1TC0c6mZH++Swubxz6uO4Arl6g9BJUa+ZxKi1CS5dFobCvzAZutl1V4gTKKYLD/DlrmC6FhwTORkeKQnteIwkAey8wLHmdTaXCI9d1QzQcRUi2y8z8CAN4DJaBDEg6ZmDQjSxBlOOi+JRlrcAD52RQiJPn42rqyx4T4ikXZxtLgFLSr7VMVY+Fp7N8AuRe0wSvjBlLla//ueendtxjUio+FbxfapsptK4gGGjRz/r6bJzRSH4fTOYWy2Iz8xRKaL5apzppO6THAXTuIUgIWYtEaaCeAEEG1duQ+rST3C+dNGfvbjolPRnKXHBSjLkjbpdBWlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=llWcPA+DKhYp4o7YZO4kcC9Wj93i7Ctm1xeD+7zqiiA=;
 b=OLatWL+UBeATbvN95y0/Tpcsr31LZe88MzBBA0tbCjfs6LZLl5k9ckqeOrpizItT5EE3hnUcWxXnK2PNR0ciYPt1+x+PFHKhnMNTQiRnAj91o8AFTKyZPbJNSFKg86Yxs9YIqrJAqpBDiEjg5HoIzl3jQkK7Vjwg4C5AuCULczs=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SN6PR10MB3085.namprd10.prod.outlook.com (2603:10b6:805:da::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Tue, 21 Jun
 2022 20:47:02 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f59a:175d:d24:949c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f59a:175d:d24:949c%7]) with mapi id 15.20.5353.022; Tue, 21 Jun 2022
 20:47:02 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "damon @ lists . linux . dev" <damon@lists.linux.dev>,
        SeongJae Park <sj@kernel.org>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH v10 11/69] mm/mmap: use the maple tree in find_vma() instead
 of the rbtree.
Thread-Topic: [PATCH v10 11/69] mm/mmap: use the maple tree in find_vma()
 instead of the rbtree.
Thread-Index: AQHYhbAKYtUZH3yiyEOkqYpCzl27TA==
Date:   Tue, 21 Jun 2022 20:46:54 +0000
Message-ID: <20220621204632.3370049-12-Liam.Howlett@oracle.com>
References: <20220621204632.3370049-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220621204632.3370049-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 14590137-f82a-4844-dca9-08da53c73177
x-ms-traffictypediagnostic: SN6PR10MB3085:EE_
x-microsoft-antispam-prvs: <SN6PR10MB30852E4F2D5324BEE838D6FEFDB39@SN6PR10MB3085.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lTuQC6Y8g16YpEuYkz+JTAF9gwOOLmWgQadPP6vZ4Bl8ZOC/vkrFYcGWSJWtQngSvmHovX1CrZzZq70/4ByzsDypu6q93WXt0bxJxcoVAbzxKKfJjIvXVnmEUo5IYzzaK+yZboKsGz7ynOnjSO7+p1dlybQHKVqkYKq1eEzvnfzM8TfZyIA6giGP+kVRY8XeOx0FSEzVWgB1CqqaYzrOXs3FGLyiXE7IBaNV1OgnYbWrXBCtPFsnA+bRdFBiMUNUcnRK27pWzOj5RPydirqQP3ynfInxbnNrvMd0ovInv24iV5XiOHQbhwZOK0w72tPrT22V+vNsoOUcqNzxN9xGdo8kyQ1cexuhg0xEnA2zOIQUrqU/NSBOoGDSsK9eN1DIF2xm2JfudIAUoTjWbtcYfgAYeUUaJ7EAl5Yq1EHiqund7pUgnPeUgxhzw/9b/j07IZzvZMuut13g5Q31jb3C7twe12YvRa9pVsDAYL/1DTMCFH4kxvLFMZP2Lnng2MKK1eb0d1gTk1T5vgYpLM/FH6JayqlYRJZLCeKZmbyDgpxlXT/iGY5UO2K5nDnaU2sDhBFimICGduobn4pSTGgpcZNT+JenM6y1WkbNJY8MExzxNGaGP8dSBe+RCTD9feHM/+od+8p3aXLA6MNX57zTtOMOVNU0cKC7bf/IcY2Ly9A2stMNhqc9j/9OKAF76RPLtbr5r6IhbYvEkjUJVt6w2JrIuCCS3SQcS9kIjTes0NSr4h0lykQmQ9Bq4eiejaI20HHP8qnskFQApshLjCRdcxJH38Xui4I0t6X3ZqpgMDw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(366004)(376002)(39860400002)(346002)(136003)(2616005)(66446008)(6486002)(76116006)(66556008)(966005)(36756003)(64756008)(83380400001)(478600001)(66476007)(1076003)(71200400001)(316002)(186003)(44832011)(5660300002)(8676002)(66946007)(6506007)(2906002)(41300700001)(26005)(6666004)(86362001)(91956017)(6512007)(38070700005)(38100700002)(122000001)(110136005)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?8FLBCOjeFIoxCotFBdKJoFp49FkdQU4mJR8aQwhhmtPznglo62QKcdNhLw?=
 =?iso-8859-1?Q?CUmfbdTRywrZCxY1RalYCsoFXHt78/QeJlsTcOvYu1aBYkMRI9qKOBwEfV?=
 =?iso-8859-1?Q?KOVzGdqnxU2XckoukrK6gVS6h2Kbl0LrHnWvz/yvOeidQ6EACImgs7a2Dc?=
 =?iso-8859-1?Q?ONkz+xpJCqCNiYo4ZFyY897decAsmKStFKFsbK8cNX1lMMU5pSqkMhcriK?=
 =?iso-8859-1?Q?rtMOCx2aeF/sziQrvHfkyDvbMH2MpamvJamgfqUWCRV0CVkx5l7bXT8Zjx?=
 =?iso-8859-1?Q?ZTjMHTmj4iuDZRnv41BeU5FnLKMNMIP1v20oR/nGVSrN/N5ZN/d2qVovf/?=
 =?iso-8859-1?Q?TKzTxE4ojtmGLlqUeD0ftKMG1kWTMfNf6jIYYphw+Ju/NgCOKEQwZvOGi2?=
 =?iso-8859-1?Q?faAeGK1o2RuOSndJpQ4nvcCmHpCu8geNyWlb7YzQ6T6M67uCVkQO1MtNuN?=
 =?iso-8859-1?Q?50LGwyr5RfQ31f9nWhFW3vu0et0KU/lnTZfDa7F5+C6VrOgqxKHYycyAAc?=
 =?iso-8859-1?Q?EQK2zp0C/oPVetgnFIJAxaxDAcBDWCY7u13TMoUQiPOCjXITknMvi47sLR?=
 =?iso-8859-1?Q?ShOEzwTg+2O02cEgfYP0XGS5+xNjpC8mtuLPHeB+sX8MuQr39jweh60r+J?=
 =?iso-8859-1?Q?m7xijdKY4TCM2GXQzXY0QnHOteVNSJSA2Z6fuFaCVa5kMA21x3OaXIWS1N?=
 =?iso-8859-1?Q?3zZYOisspm3ZTVMIc4WzS25ZXjSzGBPnqaFEobjRPk39REZ6YHHy/yOa9d?=
 =?iso-8859-1?Q?sA5hq/6mcvaU2PtbMmA1hoTM+4iOp2Oek5xg5KSI9WhA1Qr2kt7qluUCk7?=
 =?iso-8859-1?Q?7xb/thG4CtUTx6Wj5N+jr6tEkIKWvcZzCDYuPIqSfb1IpI1Kk941OGlE+f?=
 =?iso-8859-1?Q?Qf3GdXPuvKtSC/QqPgQ2VwkNZtb4HIY9/MQfQ/GDC6YFL/hBF/2qy3p+UM?=
 =?iso-8859-1?Q?YJqFv9rN7AQPf2scasVjezWVId6/wNv2wOgHHD1qr7ReksTLCiDSrol6VV?=
 =?iso-8859-1?Q?WE6tyksXegNyHZ5VMDmLUCcbl2BkocEZmOU6bQwOxaJ3WP2o0OxlIkM6NW?=
 =?iso-8859-1?Q?hpe6VQY3kyxct4hvA/LeMkV4/kdCcWtaK3DC8lmkL1X1dwBUUad1AJxgks?=
 =?iso-8859-1?Q?fT/iFdq7wqM3UKY4Gbv63z19/pmKfJSDY2K2Bnw21QA6CK1GSn8zhZu04z?=
 =?iso-8859-1?Q?Suqu7KfG+YNdkaVEupzEyFL3zbPYNJ/vm6WlEiMH91rpp3UuWvDGsDALzv?=
 =?iso-8859-1?Q?sDW8Vdckm+qV+XQcm5wkWYvp+/+RiL52f5HPKnjeaDFDMfxqpTa4vwXx9g?=
 =?iso-8859-1?Q?+BWsnTuBqysGJh7v8kwmh3CXHKOLzOJZdtwE2zUnvPc9B4G+G/FUewsf/M?=
 =?iso-8859-1?Q?QBdQuRs85ODvi2C8kURaXxzT+Sea3kLRg62dQLU/USFnJ4lUqfT2yl9AFT?=
 =?iso-8859-1?Q?dNbTsaegiwP17IjQgCb7Trq7je2ln+QAn28YQU1rFtZfdBXG1wBC26HZrh?=
 =?iso-8859-1?Q?CWDERTS49EeT6ox5Gfh+00EMz5qhKr31bFu66EqqNm2GKHDQS7hVBxHAMU?=
 =?iso-8859-1?Q?6t/1HPkNKeKwAlrdYRd0nyp6LJXPZaHEMn/+vYRHMO/fGgWbey6YCM3kVH?=
 =?iso-8859-1?Q?nYG/5Bn1KaxpBr8wwiIf6KnNreBFgqwxAlFkzOsbFQjw0Ssofvh8hHNVEq?=
 =?iso-8859-1?Q?3FF+7xi7r+OIsir9TMxQBj7WZiPkmY8m3CtN3tuVH+fshMxCWNyW/vS3Db?=
 =?iso-8859-1?Q?lMaKtIfjIjQFYPXxpL0cZT0WW/GZORH2BHRD8ZUxXOVkeenaxozjWbMNPf?=
 =?iso-8859-1?Q?EC+XCtQz0+kuK0wHjxEwKUGwtuY7R8s=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14590137-f82a-4844-dca9-08da53c73177
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2022 20:46:54.9418
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dT0He2L+UZTxdr5wVcb663VikEhhb5OannsByfN6i30xDqCV5osEU6kLgohsKFHwm8Wrn8iwWtcM/hMf8bMq/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB3085
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-21_09:2022-06-21,2022-06-21 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 mlxlogscore=837 bulkscore=0 phishscore=0 suspectscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206210087
X-Proofpoint-GUID: 5-mts_SIQf-xhDsqfCYdJnQtKQ73X3x_
X-Proofpoint-ORIG-GUID: 5-mts_SIQf-xhDsqfCYdJnQtKQ73X3x_
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

Using the maple tree interface mt_find() will handle the RCU locking and
will start searching at the address up to the limit, ULONG_MAX in this
case.

Add kernel documentation to this API.

Link: https://lkml.kernel.org/r/20220504010716.661115-13-Liam.Howlett@oracl=
e.com
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
 mm/mmap.c | 28 ++++++++++------------------
 1 file changed, 10 insertions(+), 18 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index d7e6baa2f40f..fdb61252448f 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2486,11 +2486,18 @@ get_unmapped_area(struct file *file, unsigned long =
addr, unsigned long len,
=20
 EXPORT_SYMBOL(get_unmapped_area);
=20
-/* Look up the first VMA which satisfies  addr < vm_end,  NULL if none. */
+/**
+ * find_vma() - Find the VMA for a given address, or the next vma.
+ * @mm: The mm_struct to check
+ * @addr: The address
+ *
+ * Returns: The VMA associated with addr, or the next vma.
+ * May return %NULL in the case of no vma at addr or above.
+ */
 struct vm_area_struct *find_vma(struct mm_struct *mm, unsigned long addr)
 {
-	struct rb_node *rb_node;
 	struct vm_area_struct *vma;
+	unsigned long index =3D addr;
=20
 	mmap_assert_locked(mm);
 	/* Check the cache first. */
@@ -2498,22 +2505,7 @@ struct vm_area_struct *find_vma(struct mm_struct *mm=
, unsigned long addr)
 	if (likely(vma))
 		return vma;
=20
-	rb_node =3D mm->mm_rb.rb_node;
-
-	while (rb_node) {
-		struct vm_area_struct *tmp;
-
-		tmp =3D rb_entry(rb_node, struct vm_area_struct, vm_rb);
-
-		if (tmp->vm_end > addr) {
-			vma =3D tmp;
-			if (tmp->vm_start <=3D addr)
-				break;
-			rb_node =3D rb_node->rb_left;
-		} else
-			rb_node =3D rb_node->rb_right;
-	}
-
+	vma =3D mt_find(&mm->mm_mt, &index, ULONG_MAX);
 	if (vma)
 		vmacache_update(addr, vma);
 	return vma;
--=20
2.35.1
