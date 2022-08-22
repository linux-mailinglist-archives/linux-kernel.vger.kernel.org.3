Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7883159C248
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 17:14:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236236AbiHVPNL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 11:13:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235966AbiHVPJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 11:09:24 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3102F3ECE7
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 08:07:19 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27MEkVKr022015;
        Mon, 22 Aug 2022 15:06:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=r1giLiqobVgWalpGRtsW4+6ZGSEoKPLOFx/DDBog4ec=;
 b=X3IX5Ef0dSG2F1KTHXWZeKhw+jci4UcVaoZAS161mXBf72iQuPs3JkuZeu5ZGqAc7DIO
 NpVhrnLDZfgLLpPAl81Q9gpG5U6lb3IZ8/y/5Em1Qb8VOHlsWGHTVkM/RZk3smbtG/Sx
 TOJnMv4bV9VssvhQZADO4e3uua+QRrbHZN/pLSUeb95UPxRCUeQ8sWIYTMGSCFdLJEBI
 Ea2lmXLyV8p9av/lKHCmfGqKGPTRRCN3bWE1KP3YZa49t0rKJCEmv5okxUuMxAd6so7q
 g0ERif+4cQZfmTnmknCmKH1gfhb9b9w2sWpXgCf7ywZ8wVoIxAXaXDVKdgX7PR1r4ONt Fw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j4btmg2xe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Aug 2022 15:06:38 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27ME4Nmo037786;
        Mon, 22 Aug 2022 15:06:37 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3j3mkg3e04-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Aug 2022 15:06:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HkUnwEAE3RLl9hJFZtN6EaxEFaZQDyBGEactHDM3PQnzJ1G4Lnn+8TN68VvxxoDiRSNAASCQOXoJ5dIA7yQW2EMIrawzWvmToc/2TUy7BQ8mNjGH6KMN5MrV536PYYAFm2n2HezkTUyk1SNDJk2YSeFeGyTBDH8c/afdMD9dz49MqtiUVnIIc/bUtdp3sa+q/oOYGnIRWvFN/r7jKYYkdaFiA7bhvk7B6ojfN97EspJTs/XOmUtGz0Mg0skDbQw3Mpj6JJHih5KC7kM8U60SJTq2Fxk4CqzFEraGVngc0wwVFmlJ5slz8hIfcGq0MSa4gBwhTXKIQJt6XhuoBVYHTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r1giLiqobVgWalpGRtsW4+6ZGSEoKPLOFx/DDBog4ec=;
 b=cA0uWmkPjil/vfy4r4b3v/u5PgFB2z4O97SNL9BNF8rJfU7p8fjw1uXsqZIcaFk1FpfAjVkvmfL7/50qo9dS7BXMfO5tmPG9Q+9qWzEC9VvJM0e8X7mgnscLHuWU+8R99myJWKeaG1pLaD6MJAOA/Xw1ZDnUrTR7scfPCeaH6Ae5F3SDsjKicGitjBIQTWs+OmDWTp373t0FQ3NRLA3HqVmHOE3bQNxmgp2wcBD+rIZJCZ8uokkmwtFdXx/JBiNxMniMUJ6BjNpJMDpWVz4qOXrLxNFhGIAKlXsWqHUxz1QjCsLNisRmnGZ4KlkGMeby3tLAhmne+CydvJbtXvXHIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r1giLiqobVgWalpGRtsW4+6ZGSEoKPLOFx/DDBog4ec=;
 b=oyssShVutIAekq38KVQ/tiCUZIZmyKiRj//zjTzhgEp0xg9KN5R83Ev1uqpc8zHOxg7PVSeCHwmXsYBrYH5/hy8gDUcRzRVII/DFzQc8BOO5gG6OPEjZ6nobmVh719LvTMC7JE+6Pe2pGmgdJK03v06axCy2b5G3W4zkyuN0mJ8=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM5PR10MB1433.namprd10.prod.outlook.com (2603:10b6:3:e::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5546.21; Mon, 22 Aug 2022 15:06:34 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3d34:ebb5:d9df:98b3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3d34:ebb5:d9df:98b3%5]) with mapi id 15.20.5546.023; Mon, 22 Aug 2022
 15:06:34 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH v13 57/70] mm/mlock: use vma iterator and maple state instead
 of vma linked list
Thread-Topic: [PATCH v13 57/70] mm/mlock: use vma iterator and maple state
 instead of vma linked list
Thread-Index: AQHYtjjC5w5a5sxoDUK1UuyGlVOoOQ==
Date:   Mon, 22 Aug 2022 15:06:30 +0000
Message-ID: <20220822150128.1562046-58-Liam.Howlett@oracle.com>
References: <20220822150128.1562046-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220822150128.1562046-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 021eac90-162c-4c88-3b69-08da844fe70d
x-ms-traffictypediagnostic: DM5PR10MB1433:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BxrJPa0MGuRbucQF0UcAK3joD5nFdEVd5bXk2cjatyMb667t9rUe9GsD83R8Q64qPMz0JhRCJTCeGdDQOQh33iepQTqIKbGIu0c5U+D+ekkoPu7ykiteNmogCMCWu0O75BST3vpOc04ZyFCYQLdhMhtS8EZfQVrVFK2KpztmXoH5iYMluXWRAFTD7EUo9S7sHT18v4WCkmUKqlscwKlM2/rt2dHZFhn618UkFNSXPgOMzFToWloHR7Cli1H5zY4wmd0HOI1LKruLF4X+WMB5s6lztc4bHVOs7gXhjkEKVlCwlo/2u7cqszyMaHdQQ0F4Y/C316cPQuGncRDNk51Lgxnov4GcGOf7mmeYa99QaS0Rm7dLL+V4oHBhQxoeGrg91vjF3y9ceN6b9i3UM0uplULMdJk/xTEenvrhSQ4NAl7TbjZKS7kq8rE7ljksd92kMxmTOSJOoyEY+4LROUY4NuWQENmc4OL2p2U+T7bj8FSPexY17/U7xt9vj0CWgDan5MdZCLOxONIbyrsG9tmvRJvYj3y6Y7VUVqZtICzf9ojNezZJc4xiSvSUydiKxfUTa7iUHZoapzEnlkABgm/nQwgPq1Zbcs7qkU3CHVIuJD284XV0/1qtNmTnVf71Yh6cGxjO0OgCa7AldIFR/fxvvE13QaOJLyu6TvwSfdKKRs1oj9+V0e72UYpb64ah4NdapS4yJR73ISvmrCXJh3TARQsW9Jr762am5MyTe/zLcwVqDdEQHcE+wUXXYcX6VWGttL2v1irmq2X22hA1ICkBcg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(376002)(396003)(136003)(39860400002)(366004)(5660300002)(8936002)(38100700002)(122000001)(36756003)(41300700001)(44832011)(6486002)(6666004)(316002)(71200400001)(76116006)(91956017)(110136005)(8676002)(4326008)(64756008)(66446008)(66476007)(66556008)(66946007)(54906003)(478600001)(186003)(1076003)(107886003)(6512007)(26005)(83380400001)(2616005)(6506007)(2906002)(38070700005)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?4hAnbCDQnBhaWla0wgES43pVC3MpHI86DtnQGyJBckca+ZfBOdcz7g7754?=
 =?iso-8859-1?Q?TsMzdwMZgwFyZiYZEZorZ3WWDXOS7dYjgNnJ09FOn2kgmJt2EE842fGF2J?=
 =?iso-8859-1?Q?+fQQipCIkdYysPfG3J45XZjZUlbbpDjHijC1b9+Yz50Jmj+q6u1YXPmKwE?=
 =?iso-8859-1?Q?HyrKxTorBFgTVDwoVvQVUpnfVjCGzwB/LTIL8Rc4ZXpyNDlM3Wxi+bbl1L?=
 =?iso-8859-1?Q?OGpvLIE62mDkxkDKiL6p+J/AaRtkaRw/MK2/NVaSG6+1UipslOiAzgTzXN?=
 =?iso-8859-1?Q?WgjTYDDItbv5wOnvrOCnmom0LW7UaEsWkcSAWQCbKUPxndDet6rmhKRkDc?=
 =?iso-8859-1?Q?T07iNxRz+33oVfFWoIU8Agsp6KDLYNytgy+nk6HmZrRgQZ5KXbxgiFmWP2?=
 =?iso-8859-1?Q?FtXHCkwb9SLVh3tsP+Vd/eXfcPuwDmEGJODSUph++4uFDaE+kjVutskFaF?=
 =?iso-8859-1?Q?R8U+hGLKa4hinMypW512nXXhjtpjleiRc4UPSLcCL3bX16NSDCsmAsACD6?=
 =?iso-8859-1?Q?Gdu0z+Rl5dmHjZ4yF9lJopCY2XBYxtrau/Eeh2tOfhjQNBj3ytfQLc4dIn?=
 =?iso-8859-1?Q?Zc0Iow0Gfx+zy78zLDArFm6qMWmP4pZclQmXq+blfuFhIvfjN35egNDY0D?=
 =?iso-8859-1?Q?5M2Y0pJG7xYoGzomEJ3Np0riRatOh0HjLyGMOcmeujxObnh7bf5OSZA/fo?=
 =?iso-8859-1?Q?HMxRyRWJHRS4RsXKHvKwpiKyQaWUNyxDm3kOma8L68zfptxQq5p7to1aYO?=
 =?iso-8859-1?Q?W1H36ltOW7cWstSPpDade9r4y42pztfjM6QvkpGMFpXWDh8fOT8KsHLEGD?=
 =?iso-8859-1?Q?+Oy2y/SmoT/g2mAAZOZcXgp5MgFD4zhhYdxdVsymkiw+Ju7f5dWyYnWCix?=
 =?iso-8859-1?Q?49T07M3IMsn1nPGUzOgAvQgFwqlmAqohLoMLpJfhFLCCHw1xdppcM3bwB1?=
 =?iso-8859-1?Q?Kl4YMjvQ/DDm1y7z2qySCWiX31szqQSYX/4tZL37Q/ZfnMld3/BrFczoj9?=
 =?iso-8859-1?Q?Q25l2JKa+vVMTxPyQe3TbC/G94oOwXBPRMvY54YBrq62Dy0PrRkG+JoMeE?=
 =?iso-8859-1?Q?JGTf/6mCRHBkYibv7I1nnbtv9Ul3gO11Wu/aSKwBUSn4OGgS5S9O0Cc4vD?=
 =?iso-8859-1?Q?lBP0SbKsSSReLlCWt67Q+ChkXGx9sYfiow6LxYOlQThf1SZ0iKQdYYR1ki?=
 =?iso-8859-1?Q?LTTo7jlH8Mh9aiUGPFDkQrYmdd5sG1JJgFXifOK4sWNR81H4yDaR/fsN58?=
 =?iso-8859-1?Q?uYBftRQVNtXCROnMfxHss7v02ArcN1yOi16EjnNESEumX+t2sqF2+rIInT?=
 =?iso-8859-1?Q?nq62R55mG2bQYRrh7diVM87tC5Vep5ng4FHumh5Pd93KGfhCsT5nTU+vRG?=
 =?iso-8859-1?Q?wO6s4BjbffbFfHFoc215KOkfgIfKEJPbfttf8+e5GGb5hy8VdBwBxRkj7b?=
 =?iso-8859-1?Q?Alb+Z3lmXXl42bVLaNRvXuvxI6MmRF51Zs968GGpHnvvsj1m3Xte2DDohb?=
 =?iso-8859-1?Q?llvVgf0kqKbasm3EikMiTU/GfgVOOQ1KWwZK1zSE2mLzKVP9B4O3cBS9Zt?=
 =?iso-8859-1?Q?5vc3+v1vkSxVvcFokQihqPQuxapRp+cs28jUgd1s8+Gile9hzE5hw4iYdb?=
 =?iso-8859-1?Q?Fw1my9Q14NP1Cxw3wVTAjb5K8tDQe6cA8/4r0oNolQdF+Tnvt4x7LEJA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 021eac90-162c-4c88-3b69-08da844fe70d
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2022 15:06:30.5191
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MRrZL0J3F/7tyh4uH9c+sqU9Xf1AhKvsXH6+dP6n+4y4zW7hvambQeBpFu/W+xFDlxJJpcqTId2Bho9hEkpuXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1433
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-22_09,2022-08-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208220065
X-Proofpoint-GUID: GqCQwBlBYahoPc8aJmHvClssyVd-rmBB
X-Proofpoint-ORIG-GUID: GqCQwBlBYahoPc8aJmHvClssyVd-rmBB
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Handle overflow checking in count_mm_mlocked_page_nr() differently.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/mlock.c | 35 +++++++++++++++++++----------------
 1 file changed, 19 insertions(+), 16 deletions(-)

diff --git a/mm/mlock.c b/mm/mlock.c
index b14e929084cc..43d19a1f28eb 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -471,6 +471,7 @@ static int apply_vma_lock_flags(unsigned long start, si=
ze_t len,
 	unsigned long nstart, end, tmp;
 	struct vm_area_struct *vma, *prev;
 	int error;
+	MA_STATE(mas, &current->mm->mm_mt, start, start);
=20
 	VM_BUG_ON(offset_in_page(start));
 	VM_BUG_ON(len !=3D PAGE_ALIGN(len));
@@ -479,13 +480,14 @@ static int apply_vma_lock_flags(unsigned long start, =
size_t len,
 		return -EINVAL;
 	if (end =3D=3D start)
 		return 0;
-	vma =3D find_vma(current->mm, start);
-	if (!vma || vma->vm_start > start)
+	vma =3D mas_walk(&mas);
+	if (!vma)
 		return -ENOMEM;
=20
-	prev =3D vma->vm_prev;
 	if (start > vma->vm_start)
 		prev =3D vma;
+	else
+		prev =3D mas_prev(&mas, 0);
=20
 	for (nstart =3D start ; ; ) {
 		vm_flags_t newflags =3D vma->vm_flags & VM_LOCKED_CLEAR_MASK;
@@ -505,7 +507,7 @@ static int apply_vma_lock_flags(unsigned long start, si=
ze_t len,
 		if (nstart >=3D end)
 			break;
=20
-		vma =3D prev->vm_next;
+		vma =3D find_vma(prev->vm_mm, prev->vm_end);
 		if (!vma || vma->vm_start !=3D nstart) {
 			error =3D -ENOMEM;
 			break;
@@ -526,24 +528,23 @@ static unsigned long count_mm_mlocked_page_nr(struct =
mm_struct *mm,
 {
 	struct vm_area_struct *vma;
 	unsigned long count =3D 0;
+	unsigned long end;
+	VMA_ITERATOR(vmi, mm, start);
=20
 	if (mm =3D=3D NULL)
 		mm =3D current->mm;
=20
-	vma =3D find_vma(mm, start);
-	if (vma =3D=3D NULL)
-		return 0;
-
-	for (; vma ; vma =3D vma->vm_next) {
-		if (start >=3D vma->vm_end)
-			continue;
-		if (start + len <=3D  vma->vm_start)
-			break;
+	/* Don't overflow past ULONG_MAX */
+	if (unlikely(ULONG_MAX - len < start))
+		end =3D ULONG_MAX;
+	else
+		end =3D start + len;
+	for_each_vma_range(vmi, vma, end) {
 		if (vma->vm_flags & VM_LOCKED) {
 			if (start > vma->vm_start)
 				count -=3D (start - vma->vm_start);
-			if (start + len < vma->vm_end) {
-				count +=3D start + len - vma->vm_start;
+			if (end < vma->vm_end) {
+				count +=3D end - vma->vm_start;
 				break;
 			}
 			count +=3D vma->vm_end - vma->vm_start;
@@ -659,6 +660,7 @@ SYSCALL_DEFINE2(munlock, unsigned long, start, size_t, =
len)
  */
 static int apply_mlockall_flags(int flags)
 {
+	MA_STATE(mas, &current->mm->mm_mt, 0, 0);
 	struct vm_area_struct *vma, *prev =3D NULL;
 	vm_flags_t to_add =3D 0;
=20
@@ -679,7 +681,7 @@ static int apply_mlockall_flags(int flags)
 			to_add |=3D VM_LOCKONFAULT;
 	}
=20
-	for (vma =3D current->mm->mmap; vma ; vma =3D prev->vm_next) {
+	mas_for_each(&mas, vma, ULONG_MAX) {
 		vm_flags_t newflags;
=20
 		newflags =3D vma->vm_flags & VM_LOCKED_CLEAR_MASK;
@@ -687,6 +689,7 @@ static int apply_mlockall_flags(int flags)
=20
 		/* Ignore errors */
 		mlock_fixup(vma, &prev, vma->vm_start, vma->vm_end, newflags);
+		mas_pause(&mas);
 		cond_resched();
 	}
 out:
--=20
2.35.1
