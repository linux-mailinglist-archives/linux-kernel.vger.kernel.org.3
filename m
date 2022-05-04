Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CDE0519340
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 03:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245146AbiEDBSg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 21:18:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245021AbiEDBRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 21:17:39 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4357741311
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 18:14:04 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 243LFfwt018740;
        Wed, 4 May 2022 01:13:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=X6qGeI2TKZ8tGbYX+Q741pAHhwxnP4fVxkRtKIu3QGQ=;
 b=NZWV6E8hd4yqwq1AQGwO6qN63JC1ZAglUJRMuN0SS88iw2UAHQHmqv6qACn8wdB/bsTa
 2ervmh/zpGX/T5JFlmeLuMW1HPTrUQUkMzmEXbs8yoSllXue+6iEIFNMihYpXUa067ru
 lL/cWhk17KTlmGwOSAhe7RLvbWMRzdbAM0z6Qtf0L8vqy+eySNEvNfwjbqJhsw7KTGpr
 gicNMaTub+mwAtpXWNAkTBTA7nFgCCnPWwsLx1aURb+bSq0eQwj2dIm3rhfLQF8j3Q+k
 QGA3uqwLCp+4j5mrs4IFHim2vS/fn+L1KuKq7Ph7P7XvNHKTnzEB6GJumdF/UAStpVS2 hg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3frwnt74gh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 May 2022 01:13:56 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 2441BRJX013094;
        Wed, 4 May 2022 01:13:54 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fsvbmv3ke-9
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 May 2022 01:13:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F0yY2wmPUnOafdneFwmCwsIcJrm5FoCCF3KWOAu+HQZWkWAn6+Qk4tsOgw7VTzjTl7WUIJ4dKvIU5uEie2pU9fHQeYEePJd9pds66h5TesKcx17McaCFaZ/yOJVKA2UsQA0Kj1jTwYrLOGuKkUdse6xqi6Ax1ffOS5wYR7Ovcq8yzimUWmxbBqOTzwwPqzSXIR4NvIv/1fW+Ofhpej4ZaQPwORepzep3iGyAl8qacCJyQJ0OFxs6Np11eJvJQX9KwVJeHsQ7TbZLHewgcaTn3BafT/uv/9TvMZxXXB55aj+HQSu/Lo5M3jYfPsJgx0Kb9RPwVt5rIt8hjNK4mLgcKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X6qGeI2TKZ8tGbYX+Q741pAHhwxnP4fVxkRtKIu3QGQ=;
 b=lqinb4JdgwKM+Ro9PlZxVjEO1gjlY8KpvKIBMHmaXBmReFCVUNoXm82CbiRZsf/GKYRVJpTmL8l0MkI56xLrdIxQZNOZDKH7kH8ins/pduHQsC/WzVXpBabWK6puQlVaqIcOQp15DCtcd6u6WyFlJmRUcJF8yZ6NegAb2OhAo2b2y7EwYJQ2R6fMSXU8+mma5qDscA2l6Hm8vYt+fHO2I6Qzy9MvM1tTJGLUGtn0LM3k844eKi4PLeQ7x6uJ9Y6+MnoorIRMQa7eVnlQAxjdM2gw/8s5LY3hmlTAscCk6VUI+dIwwXxQjPmgbtdDdv2soRTiMOO5UlSJk996hm/gDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X6qGeI2TKZ8tGbYX+Q741pAHhwxnP4fVxkRtKIu3QGQ=;
 b=p4lOs5N5UDBiJcc+cI2S47m8gokZfGDr1fZlMihR6Di8NZ5PzGZtNA26Yw4oES7W4wcNCZHGmdtfjKqqnQg5MWyvuGDPPmT4/2x7hZyTE/T0JCmPiPVqFnC2VtBq29e5nDkSpcYTc2JJJshEkxtPxa8dt70URv/Z9f/mMntq2Jg=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH7PR10MB5830.namprd10.prod.outlook.com (2603:10b6:510:127::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Wed, 4 May
 2022 01:13:52 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5206.024; Wed, 4 May 2022
 01:13:52 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v9 24/69] mm/mmap: use advanced maple tree API for
 mmap_region()
Thread-Topic: [PATCH v9 24/69] mm/mmap: use advanced maple tree API for
 mmap_region()
Thread-Index: AQHYX1Q3aD9uSrK4x0WsZnSWu9xT+A==
Date:   Wed, 4 May 2022 01:13:52 +0000
Message-ID: <20220504011345.662299-9-Liam.Howlett@oracle.com>
References: <20220504002554.654642-1-Liam.Howlett@oracle.com>
 <20220504011345.662299-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220504011345.662299-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 11c42c2b-aa93-46ff-15b2-08da2d6b5a52
x-ms-traffictypediagnostic: PH7PR10MB5830:EE_
x-microsoft-antispam-prvs: <PH7PR10MB58303FE60C86197E70F377C3FDC39@PH7PR10MB5830.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RYwlCstj18rF8zIwVLQl6VBBNAATtM2D1/pnsmgF0F1g5EfFatWls0q8OMSgrixRV/a4KCLQ2iF30XdjgThTLfldtWAM5xT+ztAbp2nQfxg58e4MI7+ofDyy2jF3mDaXkpo8TrO30C2xN5HIikCgbGEse48LW1Nnv+FwcmF1b8NDwgqGTd5Nqr/XT0s8kxIm5XNi5xLE3GXG0ByAWyDUxEx5iT9P4MVeavnInik/8sA/VTz2brrLZ3HeZSoApQn1Zyl5b/syLY8yW7hZrwQvuKGkTsar33tCL3yH3WZG31l7lryL4DG7ZgK64Cw4+bX78WLx/Mci0o9gqYglTJJ0bo7HS2NWui1xJUzGBILo1n2xHOguMk903Eox/dXeZAiOHTTNDMi5jbE0xxODLv2nLNbQTXuBt8jt7dyFASMyuqnVnB1ZU1le6AgNFRPimrawyZhZ1mTiThmtzkD622OCBI6OqyDg0ZVvQqU+dY9ELmuDORdqjwQoSFXwjFx918yQ4xvqbIzXmF6FqQllGSWlPiuv0mDuxizN7yGtJBrr4luwlZDhFm7JmcassL9V9DuncCJVy2peFDEjP88aO+/vq2mS1bF20CZ+QYYqRCMrsCotW5fKzQd7mfgy99P8gINmJeiri0m4BVpQU2v5hzviNnGooBJ8iZw1V3YtSIqXlhdC2jQcovz/eNqEr6fKfEpilobCJYRoIeW912sSQRgQNQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(86362001)(71200400001)(83380400001)(38100700002)(38070700005)(122000001)(316002)(110136005)(44832011)(2906002)(8676002)(5660300002)(64756008)(66476007)(36756003)(8936002)(91956017)(30864003)(66556008)(2616005)(66446008)(66946007)(76116006)(1076003)(186003)(6512007)(6486002)(508600001)(26005)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?v4+I4d0XUBbAy3yU3jbCkFYSw2JOPyK1lSglKPJv+vNVKPK8ELpVIVvhfb?=
 =?iso-8859-1?Q?OFMPtrlqh7po91AbsQxF4GJhfT+yWxl1Qpj/MYBHYzAb2JL9W7kvSO/QSf?=
 =?iso-8859-1?Q?XBJkaRHJao4KpkfkjWpciLc0b1b5NQRVuClpnytG86Nz4IoStqeu2iwzAj?=
 =?iso-8859-1?Q?XAGiPHovYRzw5peRBC0Nt3MuUCrjZjZZk6j/CW3VFv41C2gM7n+hx3vlvK?=
 =?iso-8859-1?Q?ZIzgOgUSZYFGftDVZPtXvBYQB0zHEvRfAAWVuLID4wmt4TP01+u/w7LBct?=
 =?iso-8859-1?Q?vDM3eaB7oKudKJaLMmHBa7J7CkKMIcoL5mMIEL3feKdcJaxaF720a5Pfan?=
 =?iso-8859-1?Q?lHskPPFcvt6wnRxuhgktF/m9SQd82YsGm+XJtlrUYDReQtLn/FKMM1qJg9?=
 =?iso-8859-1?Q?wkutsUXWwJlRLUHHMHQYvI8iMcuZ7JgkcMDjJm7AGoT/0C5Ojf65f9U1Hv?=
 =?iso-8859-1?Q?LRKD3NLtmO8+55uR6B+PaEXcuBuxi8HwTyn9SIf+bU8gakY/SV4I3QL9Cn?=
 =?iso-8859-1?Q?ZuypepZcXos2I+rqcyNclMfTPZRUJfuB1jb72yyHCRIDnl341HP0NZCM6Y?=
 =?iso-8859-1?Q?0E6fOS4DbM9pmGLek4+R438pSIwTll6B1D2Zzck49SS+Y6mZkPTAUSpnDk?=
 =?iso-8859-1?Q?9kY2BySv6vH9tOV+KMkveof2ccRk794Ws/ND7mF3XSIinC4I0y844YDqAh?=
 =?iso-8859-1?Q?zEsyBVFABTresbT02K9SOAoean+x+ru9fFl3dUwHB2EuAVF/uJYy2za77m?=
 =?iso-8859-1?Q?5VaHlfTHA152dghdEw2oPY7/JroJTEW+TTL+amuPw1RQ8eESc3Hqc45N3z?=
 =?iso-8859-1?Q?xhtz3BmDE3gOIzd63TUrW3CduTcgaiSD0leke+akkeH5/Mm4wFsoOACI5Q?=
 =?iso-8859-1?Q?BT8p8IztoqH4nM4thZUV/U1RdwZIn+nKJRNfi7iBs5sLZh+15EGn+daz2o?=
 =?iso-8859-1?Q?zAQyrkBAYpyG/lbo+g1d/qNEnXdRvpR0kzfFxsA6Ule9UZS82/Bcar0vsb?=
 =?iso-8859-1?Q?fLIsIdioKk25Iho40yAF1O67QMCo/YwAnQZqbGz9cFVhz7lGkL1hDYr92Y?=
 =?iso-8859-1?Q?MHwN5Dp9CgC/La130pSkThLZOBMeKMO4G3+jyVlXyYx2aWRlwZj/ewB/L+?=
 =?iso-8859-1?Q?f1wdkdE7idu9F66DkukG5xekYNs/81puwXSxm6ihwK8vkDF2dW/hjH2+Fq?=
 =?iso-8859-1?Q?gJceukUVuVu2pGZdRm1DFaLtDOBJ4Nr2/Q0cH0qH4ksxgKML+LYlvIB+s0?=
 =?iso-8859-1?Q?kA3bLPBr8dbh+K5HJ+79+6Sis6yG5547JuXoCuiSDJG8nyCgOshOYtBon3?=
 =?iso-8859-1?Q?lJcU0ey52BGoAm8Y+A5zhw7qKm8vr2gg01WGmH/Iy0Q3q0YVr86kxhJ+T7?=
 =?iso-8859-1?Q?heNLJmvUPr+X4zTPKofhZQX4sdwRZGeGzljrXNiEqooOxsby6kg2EYo6ZS?=
 =?iso-8859-1?Q?CoN/Zx3S0rVFodr2i7ACkOVUKnbq0LIRWGLZa/uG2dEdGkXMgZ4cuBAE/B?=
 =?iso-8859-1?Q?pWvGviiQ36wl09IJ1sOuUCzRIXfXdT8QGpPudBRMBR56ITKvDHHs10iZXv?=
 =?iso-8859-1?Q?o2HbDU0TPmM3s3f6YsIgCGvpd1eLRvQwvTOjw/aS25Zchk+tNBCZZssNh4?=
 =?iso-8859-1?Q?cFKJe+2yMfRD3M/nVRosT75yt6AH2zpI0CIVka2HHii9zlC3D5ivOjrXMk?=
 =?iso-8859-1?Q?9cVAqD7IElwUfvUCNiKM9om7f+eUs2AIuaGNvwyouCIIF+Hb+wFKB1pH1j?=
 =?iso-8859-1?Q?THZyYCuOhxOJ5FFdoX5JTFnMpP5QIucmMQV4bkyZpKuyUbTU2IpquTCPiF?=
 =?iso-8859-1?Q?4rKLGYNA0fZbcFVxgg9u+vRfNQElKac=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11c42c2b-aa93-46ff-15b2-08da2d6b5a52
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2022 01:13:52.3769
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nBNW17e7rnvXmK5kQMpUamzGIOM14jIZRUcm95sM0OPUisaEie0BjNP0zgUfX2nc6KO03TtD2RuGuXe32a0QbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5830
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-03_10:2022-05-02,2022-05-03 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 spamscore=0
 malwarescore=0 adultscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205040006
X-Proofpoint-ORIG-GUID: tVAB3G9LE3btbBiyaVGYcq9zetMIHrVT
X-Proofpoint-GUID: tVAB3G9LE3btbBiyaVGYcq9zetMIHrVT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Changing mmap_region() to use the maple tree state and the advanced maple
tree interface allows for a lot less tree walking.

This change removes the last caller of munmap_vma_range(), so drop this
unused function.

Add vma_expand() to expand a VMA if possible by doing the necessary
hugepage check, uprobe_munmap of files, dcache flush, modifications then
undoing the detaches, etc.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/mmap.c | 245 +++++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 198 insertions(+), 47 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 5f948f353376..baf608975f99 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -516,28 +516,6 @@ static inline struct vm_area_struct *__vma_next(struct=
 mm_struct *mm,
 	return vma->vm_next;
 }
=20
-/*
- * munmap_vma_range() - munmap VMAs that overlap a range.
- * @mm: The mm struct
- * @start: The start of the range.
- * @len: The length of the range.
- * @pprev: pointer to the pointer that will be set to previous vm_area_str=
uct
- *
- * Find all the vm_area_struct that overlap from @start to
- * @end and munmap them.  Set @pprev to the previous vm_area_struct.
- *
- * Returns: -ENOMEM on munmap failure or 0 on success.
- */
-static inline int
-munmap_vma_range(struct mm_struct *mm, unsigned long start, unsigned long =
len,
-		 struct vm_area_struct **pprev, struct list_head *uf)
-{
-	while (range_has_overlap(mm, start, start + len, pprev))
-		if (do_munmap(mm, start, len, uf))
-			return -ENOMEM;
-	return 0;
-}
-
 static unsigned long count_vma_pages_range(struct mm_struct *mm,
 		unsigned long addr, unsigned long end)
 {
@@ -664,6 +642,127 @@ static void __insert_vm_struct(struct mm_struct *mm, =
struct ma_state *mas,
 	mm->map_count++;
 }
=20
+/*
+ * vma_expand - Expand an existing VMA
+ *
+ * @mas: The maple state
+ * @vma: The vma to expand
+ * @start: The start of the vma
+ * @end: The exclusive end of the vma
+ * @pgoff: The page offset of vma
+ * @next: The current of next vma.
+ *
+ * Expand @vma to @start and @end.  Can expand off the start and end.  Wil=
l
+ * expand over @next if it's different from @vma and @end =3D=3D @next->vm=
_end.
+ * Checking if the @vma can expand and merge with @next needs to be handle=
d by
+ * the caller.
+ *
+ * Returns: 0 on success
+ */
+inline int vma_expand(struct ma_state *mas, struct vm_area_struct *vma,
+		      unsigned long start, unsigned long end, pgoff_t pgoff,
+		      struct vm_area_struct *next)
+{
+	struct mm_struct *mm =3D vma->vm_mm;
+	struct address_space *mapping =3D NULL;
+	struct rb_root_cached *root =3D NULL;
+	struct anon_vma *anon_vma =3D vma->anon_vma;
+	struct file *file =3D vma->vm_file;
+	bool remove_next =3D false;
+	bool anon_cloned =3D false;
+
+	if (next && (vma !=3D next) && (end =3D=3D next->vm_end)) {
+		remove_next =3D true;
+		if (next->anon_vma && !vma->anon_vma) {
+			int error;
+
+			vma->anon_vma =3D next->anon_vma;
+			error =3D anon_vma_clone(vma, next);
+			if (error)
+				return error;
+			anon_cloned =3D true;
+		}
+	}
+
+	/* Not merging but overwriting any part of next is not handled. */
+	VM_BUG_ON(!remove_next && next !=3D vma && end > next->vm_start);
+	/* Only handles expanding */
+	VM_BUG_ON(vma->vm_start < start || vma->vm_end > end);
+
+	if (mas_preallocate(mas, vma, GFP_KERNEL))
+		goto nomem;
+
+	vma_adjust_trans_huge(vma, start, end, 0);
+
+	if (file) {
+		mapping =3D file->f_mapping;
+		root =3D &mapping->i_mmap;
+		uprobe_munmap(vma, vma->vm_start, vma->vm_end);
+		i_mmap_lock_write(mapping);
+		flush_dcache_mmap_lock(mapping);
+		vma_interval_tree_remove(vma, root);
+	} else if (anon_vma) {
+		anon_vma_lock_write(anon_vma);
+		anon_vma_interval_tree_pre_update_vma(vma);
+	}
+
+	vma->vm_start =3D start;
+	vma->vm_end =3D end;
+	vma->vm_pgoff =3D pgoff;
+	/* Note: mas must be pointing to the expanding VMA */
+	vma_mas_store(vma, mas);
+
+	if (file) {
+		vma_interval_tree_insert(vma, root);
+		flush_dcache_mmap_unlock(mapping);
+	}
+
+	/* Expanding over the next vma */
+	if (remove_next) {
+		/* Remove from mm linked list - also updates highest_vm_end */
+		__vma_unlink_list(mm, next);
+
+		/* Kill the cache */
+		vmacache_invalidate(mm);
+
+		if (file)
+			__remove_shared_vm_struct(next, file, mapping);
+
+	} else if (!next) {
+		mm->highest_vm_end =3D vm_end_gap(vma);
+	}
+
+	if (anon_vma) {
+		anon_vma_interval_tree_post_update_vma(vma);
+		anon_vma_unlock_write(anon_vma);
+	}
+
+	if (file) {
+		i_mmap_unlock_write(mapping);
+		uprobe_mmap(vma);
+	}
+
+	if (remove_next) {
+		if (file) {
+			uprobe_munmap(next, next->vm_start, next->vm_end);
+			fput(file);
+		}
+		if (next->anon_vma)
+			anon_vma_merge(vma, next);
+		mm->map_count--;
+		mpol_put(vma_policy(next));
+		vm_area_free(next);
+	}
+
+	validate_mm(mm);
+	return 0;
+
+nomem:
+	if (anon_cloned)
+		unlink_anon_vmas(vma);
+	return -ENOMEM;
+}
+
 /*
  * We cannot adjust vm_start, vm_end, vm_pgoff fields of a vma that
  * is already present in an i_mmap tree without adjusting the tree.
@@ -1665,9 +1764,15 @@ unsigned long mmap_region(struct file *file, unsigne=
d long addr,
 		struct list_head *uf)
 {
 	struct mm_struct *mm =3D current->mm;
-	struct vm_area_struct *vma, *prev, *merge;
-	int error;
+	struct vm_area_struct *vma =3D NULL;
+	struct vm_area_struct *prev, *next;
+	pgoff_t pglen =3D len >> PAGE_SHIFT;
 	unsigned long charged =3D 0;
+	unsigned long end =3D addr + len;
+	unsigned long merge_start =3D addr, merge_end =3D end;
+	pgoff_t vm_pgoff;
+	int error;
+	MA_STATE(mas, &mm->mm_mt, addr, end - 1);
=20
 	/* Check against address space limit. */
 	if (!may_expand_vm(mm, vm_flags, len >> PAGE_SHIFT)) {
@@ -1677,16 +1782,17 @@ unsigned long mmap_region(struct file *file, unsign=
ed long addr,
 		 * MAP_FIXED may remove pages of mappings that intersects with
 		 * requested mapping. Account for the pages it would unmap.
 		 */
-		nr_pages =3D count_vma_pages_range(mm, addr, addr + len);
+		nr_pages =3D count_vma_pages_range(mm, addr, end);
=20
 		if (!may_expand_vm(mm, vm_flags,
 					(len >> PAGE_SHIFT) - nr_pages))
 			return -ENOMEM;
 	}
=20
-	/* Clear old maps, set up prev and uf */
-	if (munmap_vma_range(mm, addr, len, &prev, uf))
+	/* Unmap any existing mapping in the area */
+	if (do_munmap(mm, addr, len, uf))
 		return -ENOMEM;
+
 	/*
 	 * Private writable mapping: check memory availability
 	 */
@@ -1697,14 +1803,43 @@ unsigned long mmap_region(struct file *file, unsign=
ed long addr,
 		vm_flags |=3D VM_ACCOUNT;
 	}
=20
-	/*
-	 * Can we just expand an old mapping?
-	 */
-	vma =3D vma_merge(mm, prev, addr, addr + len, vm_flags,
-			NULL, file, pgoff, NULL, NULL_VM_UFFD_CTX, NULL);
-	if (vma)
-		goto out;
+	next =3D mas_next(&mas, ULONG_MAX);
+	prev =3D mas_prev(&mas, 0);
+	if (vm_flags & VM_SPECIAL)
+		goto cannot_expand;
+
+	/* Attempt to expand an old mapping */
+	/* Check next */
+	if (next && next->vm_start =3D=3D end && !vma_policy(next) &&
+	    can_vma_merge_before(next, vm_flags, NULL, file, pgoff+pglen,
+				 NULL_VM_UFFD_CTX, NULL)) {
+		merge_end =3D next->vm_end;
+		vma =3D next;
+		vm_pgoff =3D next->vm_pgoff - pglen;
+	}
+
+	/* Check prev */
+	if (prev && prev->vm_end =3D=3D addr && !vma_policy(prev) &&
+	    (vma ? can_vma_merge_after(prev, vm_flags, vma->anon_vma, file,
+				       pgoff, vma->vm_userfaultfd_ctx, NULL) :
+		   can_vma_merge_after(prev, vm_flags, NULL, file, pgoff,
+				       NULL_VM_UFFD_CTX , NULL))) {
+		merge_start =3D prev->vm_start;
+		vma =3D prev;
+		vm_pgoff =3D prev->vm_pgoff;
+	}
+
+
+	/* Actually expand, if possible */
+	if (vma &&
+	    !vma_expand(&mas, vma, merge_start, merge_end, vm_pgoff, next)) {
+		khugepaged_enter_vma_merge(vma, vm_flags);
+		goto expanded;
+	}
=20
+	mas.index =3D addr;
+	mas.last =3D end - 1;
+cannot_expand:
 	/*
 	 * Determine the object being mapped and call the appropriate
 	 * specific mapper. the address has already been validated, but
@@ -1717,7 +1852,7 @@ unsigned long mmap_region(struct file *file, unsigned=
 long addr,
 	}
=20
 	vma->vm_start =3D addr;
-	vma->vm_end =3D addr + len;
+	vma->vm_end =3D end;
 	vma->vm_flags =3D vm_flags;
 	vma->vm_page_prot =3D vm_get_page_prot(vm_flags);
 	vma->vm_pgoff =3D pgoff;
@@ -1738,28 +1873,30 @@ unsigned long mmap_region(struct file *file, unsign=
ed long addr,
 		 *
 		 * Answer: Yes, several device drivers can do it in their
 		 *         f_op->mmap method. -DaveM
-		 * Bug: If addr is changed, prev, rb_link, rb_parent should
-		 *      be updated for vma_link()
 		 */
 		WARN_ON_ONCE(addr !=3D vma->vm_start);
=20
 		addr =3D vma->vm_start;
+		mas_reset(&mas);
=20
 		/* If vm_flags changed after call_mmap(), we should try merge vma again
 		 * as we may succeed this time.
 		 */
 		if (unlikely(vm_flags !=3D vma->vm_flags && prev)) {
-			merge =3D vma_merge(mm, prev, vma->vm_start, vma->vm_end, vma->vm_flags=
,
+			next =3D vma_merge(mm, prev, vma->vm_start, vma->vm_end, vma->vm_flags,
 				NULL, vma->vm_file, vma->vm_pgoff, NULL, NULL_VM_UFFD_CTX, NULL);
-			if (merge) {
+			if (next) {
 				/* ->mmap() can change vma->vm_file and fput the original file. So
 				 * fput the vma->vm_file here or we would add an extra fput for file
 				 * and cause general protection fault ultimately.
 				 */
 				fput(vma->vm_file);
 				vm_area_free(vma);
-				vma =3D merge;
-				/* Update vm_flags to pick up the change. */
+				vma =3D prev;
+				/* Update vm_flags and possible addr to pick up the change. We don't
+				 * warn here if addr changed as the vma is not linked by vma_link().
+				 */
+				addr =3D vma->vm_start;
 				vm_flags =3D vma->vm_flags;
 				goto unmap_writable;
 			}
@@ -1783,7 +1920,7 @@ unsigned long mmap_region(struct file *file, unsigned=
 long addr,
 			goto free_vma;
 	}
=20
-	if (vma_link(mm, vma, prev)) {
+	if (mas_preallocate(&mas, vma, GFP_KERNEL)) {
 		error =3D -ENOMEM;
 		if (file)
 			goto unmap_and_free_vma;
@@ -1791,12 +1928,28 @@ unsigned long mmap_region(struct file *file, unsign=
ed long addr,
 			goto free_vma;
 	}
=20
+	if (vma->vm_file)
+		i_mmap_lock_write(vma->vm_file->f_mapping);
+
+	vma_mas_store(vma, &mas);
+	__vma_link_list(mm, vma, prev);
+	mm->map_count++;
+	if (vma->vm_file) {
+		if (vma->vm_flags & VM_SHARED)
+			mapping_allow_writable(vma->vm_file->f_mapping);
+
+		flush_dcache_mmap_lock(vma->vm_file->f_mapping);
+		vma_interval_tree_insert(vma, &vma->vm_file->f_mapping->i_mmap);
+		flush_dcache_mmap_unlock(vma->vm_file->f_mapping);
+		i_mmap_unlock_write(vma->vm_file->f_mapping);
+	}
+
 	/* Once vma denies write, undo our temporary denial count */
 unmap_writable:
 	if (file && vm_flags & VM_SHARED)
 		mapping_unmap_writable(file->f_mapping);
 	file =3D vma->vm_file;
-out:
+expanded:
 	perf_event_mmap(vma);
=20
 	vm_stat_account(mm, vm_flags, len >> PAGE_SHIFT);
@@ -1823,6 +1976,7 @@ unsigned long mmap_region(struct file *file, unsigned=
 long addr,
=20
 	vma_set_page_prot(vma);
=20
+	validate_mm(mm);
 	return addr;
=20
 unmap_and_free_vma:
@@ -1839,6 +1993,7 @@ unsigned long mmap_region(struct file *file, unsigned=
 long addr,
 unacct_error:
 	if (charged)
 		vm_unacct_memory(charged);
+	validate_mm(mm);
 	return error;
 }
=20
@@ -2636,10 +2791,6 @@ int __do_munmap(struct mm_struct *mm, unsigned long =
start, size_t len,
 	prev =3D vma->vm_prev;
 	/* we have start < vma->vm_end  */
=20
-	/* if it doesn't overlap, we have nothing.. */
-	if (vma->vm_start >=3D end)
-		return 0;
-
 	/*
 	 * If we need to split any vma, do it now to save pain later.
 	 *
--=20
2.35.1
