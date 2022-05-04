Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0C3C51937A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 03:23:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245197AbiEDBWE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 21:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245361AbiEDBTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 21:19:02 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42BA9443F5
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 18:14:56 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 243MOe0L026132;
        Wed, 4 May 2022 01:14:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=cna+z335HREyNba3815J12xrCgSfiJjUcCNSDn+yPww=;
 b=cpWmD3kDx1qauAEHIV64orR5GDsdl6p4XUCKHYoeU4HNjA9mTT3lN14JMqWV6qrTr9Hq
 LlMEjta3r/vGm7Jf2LaetnYvPqgiXJixQGZsh+Sa2pdThOFv/rEWmkBKzsvvsPB21brX
 Yo73juB6M8eHjwhwq4vJUYZdT7oafRYIRbBva58U7dKSkoMsbR2o6DW31xwOz1Bjb9um
 h3N2tKQE8wO0ntphgH6U80+F//afRAmXtn/xichotZc8PCDzJo7DDR66urTvHOyJkhyo
 JrhRLkxXHfUe6/iQSsYeMnxcLgwdGAL3SyB0URpqa3E+ip6mCtFhxwLK/e8jszzt8N+n aA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fruhc72q9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 May 2022 01:14:41 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 2441BXQw013207;
        Wed, 4 May 2022 01:14:40 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fsvbmv41r-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 May 2022 01:14:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TgFxhQstEa/GOTrV1AGfgYFMDz8oRAQWpXZFDV0qCQUOszMJ+rqYy/foEqBKhD8hGCoed+d9XCk/DfB+SIa1+fw08TmDC0yZSLxS5cB5jQpgGpcCVXXOLzcQpiWtQSxuCj3k1TNFo+Ru0+ycUcoVn50YxZdqfY4De+e7hE5K8yP0kNgA/+aN1p0gYPc2DlI/BhGRv0UmVt/RK4VxMtLy8Bzl/dzybFUYrvK9pAcriyi1YwDPi9sH9GeQkqKevfeZjXlfvaDY2m/d4Wk31GF2FUUxXCILHMzo2g0OtibTezzHQV+0wLQ/YGEb/DwbVY9EN96LddKT3vgMqICaY3t15g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cna+z335HREyNba3815J12xrCgSfiJjUcCNSDn+yPww=;
 b=D5g9crIL5JFZaq6Obq5VTHbVbrbsgqGFh5HAwDvr/0zJw8XwzhFD0oFSbdTspR0qsqMjA4Nv2fo70Z2Prp5UBdt1TTyAVrbr/7uGyRP3C2Kw/tiGIOLSY3vjhFGRNvCfkvI42m+onTvnnO3iwujfKpPWuIvOUVhxVLynPvlYlvM1mQhnNHQtS2Q6XnXrUza12lObTJriJRAqpvLeqzqFRvZV4FKFB09zg010PpCvpD0fwGkDlrMubDy7eRqwFCWIgqkzybhoP9VvQpupj3zy4muWqFfn7u2MDN9zBQierVHVsi7+VEQY0sX+a2X4CmssqaiLvFEUye6mq1N5Z6ih6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cna+z335HREyNba3815J12xrCgSfiJjUcCNSDn+yPww=;
 b=S8O89t6p1Z6pn0LNggc2R2kLLbGzHJ9jzYLpQekx4Lt7g/LrFgsQQQmeek+pdOTFWKvuaX+ZCRg1l8nNxAvPMxUFB4lrquCs3deHAodgRNvL1FrcXiNPpukRQi/MW1FVS0WxQ+29uNzJc/szl+4qF6trI1Wc6I8txuoZVaqlqSc=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SN6PR10MB2688.namprd10.prod.outlook.com (2603:10b6:805:4e::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Wed, 4 May
 2022 01:14:38 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5206.024; Wed, 4 May 2022
 01:14:38 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v9 53/69] mm/ksm: use vma iterators instead of vma linked list
Thread-Topic: [PATCH v9 53/69] mm/ksm: use vma iterators instead of vma linked
 list
Thread-Index: AQHYX1Q9YpsrMxTf+ki/Ga0LGkvURQ==
Date:   Wed, 4 May 2022 01:14:02 +0000
Message-ID: <20220504011345.662299-38-Liam.Howlett@oracle.com>
References: <20220504002554.654642-1-Liam.Howlett@oracle.com>
 <20220504011345.662299-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220504011345.662299-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c0ea5bca-7f90-464f-d5f4-08da2d6b7566
x-ms-traffictypediagnostic: SN6PR10MB2688:EE_
x-microsoft-antispam-prvs: <SN6PR10MB26881851B61B34D2ADCC1170FDC39@SN6PR10MB2688.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0FEEZRr7OoPEeP7uXyyhXyDUukXwbO7U3OEWdQ4O2aPD9p4MfsV+pvuW2VEGwyG0uT69zuzWqKqA0SK1z/MBmT2U+kD39etkdnfsgb1mzMURosZcirNdoQETY2VfN1QEc/wzspUtA+GciQK/0am25DK6NdIOCWEz7eb9RnNKdjLgEfHPDtYIxeScV8H/xGK8L2x4QlR5zvQD05e94l7YFl2iSiOKDN+UljNuT8ROZ7xoHZumz8bmZIr2az5s3Cds1+vP7ykHjNI1JNUJoKzcXFqS4qciNWvJC9IzHArXnLRyRBQg0bhTLoFWiVMOBuhdASRPXJrFnnugX79bNdsNlGJ1MNEECvtoBlmglpdsGVaKcJxarYZRSAHvDGYFKp9cRwJ9VgjPisQlWQXJw050iHeqDSgvIlmdghCFvi/b3s88sq6xEWEtqNrzaThi8S7assg6k4rfSL97Fikx3KDWiEEby11M9lBSBzg7qmOdH/mfoLNGq5YohpdypHqfQyxi+aaYdvgfENWqqJw/TwbxZtCdj1pK2Weax994kwvg6P5bTspJt+2ppUbETVyMbTrmS8mj6XR5Rx276Tyah2ht8vHbzrQL753RPWTW09/TD5+JyZLGaXj/ueaHITMl0+asIPZGVtf1JCscbNsrAFtcxFpI1k7ZOecD6Tc8AGwwbr5P11tVCDDfJJWYONhzvpayWNOcYYqogrcAejvbPOhigg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(122000001)(1076003)(2616005)(66476007)(8676002)(66446008)(64756008)(38070700005)(36756003)(316002)(38100700002)(66556008)(66946007)(76116006)(91956017)(110136005)(26005)(6512007)(71200400001)(8936002)(6666004)(6506007)(2906002)(86362001)(5660300002)(6486002)(508600001)(83380400001)(44832011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?uewftpyH1pOba/vXat1rsyefDYnMOLE6sPcLiPv4a6bvAWGYJ1slrm3nJn?=
 =?iso-8859-1?Q?wXNAVBT9nRpuqYPTks4gT26ahyfrTyNeRBEIIcqJRJME+0Bt6Ktkl9iCQM?=
 =?iso-8859-1?Q?opkEq8hiLFnz8X/m3LqTU8Yzv+FlbWN2dXk4OKvbwas9yGrNBsUghKsY90?=
 =?iso-8859-1?Q?ED+9Xtzt12++g1UoZbCzjXCv1THgY88uPgEG3ucwo45h2WIatvO9QBZP/7?=
 =?iso-8859-1?Q?pagOGJYosHVMIX2D7BrYGzwFiySnyjUhD6ZaVITOtYflxlEugwiFxytl/k?=
 =?iso-8859-1?Q?NMV1DiOsAyePWU5AhwVytCz4vuYCt6j/5Cyo7/rbP5Tq1D5vW4pQZ30YUP?=
 =?iso-8859-1?Q?/pXl/dVpjes13H/la+QMwy+mV6/TjQO8VplyMFfPXcEh/HTmF0xVULq6Xt?=
 =?iso-8859-1?Q?s+IxAQxQCdYpCd2f8DJrCZhzNts9LTdt2P0NR7hYlfJ3hcHwlXzV3jdWGc?=
 =?iso-8859-1?Q?lQ9xlZ4sE6ZndS9oK9WQPBZ0edmZKrYO30fhjkoNzonrbTuQ3CO6VHMU+B?=
 =?iso-8859-1?Q?8x7iLHQxkokPmpH49H81/0n7Dic+neRFjJmrJPdJmxEeLDfzU4Ts+e9vXU?=
 =?iso-8859-1?Q?ZD11FCuPdPJXwglu0voW+vdgu9b14Z60Qeedu30b0btnp8CTuu0hsUJus+?=
 =?iso-8859-1?Q?EZpM/vf3ByObfuFVzK6wMJLtAKQrJo64dYAwqJQuDDSYuke6xgyNP9yh2B?=
 =?iso-8859-1?Q?NlEm1wYZTs7HXFXAycYrkUaFwyMb60Yd1SvHiuU2gujyf54/ZIHACfY6jN?=
 =?iso-8859-1?Q?GtUyGs4cWIA3kY9zyWh6u0wEZtupMEXdGG4yDlMUlZuIo7wOwJKTn432Pt?=
 =?iso-8859-1?Q?s9Td8MHBQ6l2AW2PIerxb4e+NBvBy72B5ONnuPBmACFdjujDEhxxGwFwdw?=
 =?iso-8859-1?Q?3nZ4YmBXfnq/40QsR2gZ0fIgeRrDedf03ZXrfzm++it/iX5xpT3JDU+5O2?=
 =?iso-8859-1?Q?Ecz7rIywQNWS7a+bZpKb0BxJxz/uCL97SFsDIV3lvdQVUO/6qHwVaiMA9v?=
 =?iso-8859-1?Q?owAz44NGCMdvZ52hnRgOkYY4S2ILTKwSMkscVm3HiwRmbGMEvGsNxYhQNJ?=
 =?iso-8859-1?Q?GvaBHahz6KHc7yiHg3mux1ChIf2MVC42bZjOpoe4qezCtpK9OC2Xp+rdLj?=
 =?iso-8859-1?Q?l2nTgKYE81W8tqF+9r1KA1qFT66jQpnpodhctqgg+X/4s/WXUVUXV9QpA2?=
 =?iso-8859-1?Q?PPhJW6L2kim4NZHPUZXve8DZryPYSvGXzfDSanv/YHGbx/C96Jj33Uf4bY?=
 =?iso-8859-1?Q?CgZ3hX44m7Q7Q7VhAB6dyhv7irNddy26pOMAIZk7twSuEHVeq61q6z61NP?=
 =?iso-8859-1?Q?XMC+ykR/FYozoIoXqaT6xY9rWn/gRg/RClxrBJxlywGo0nhqfe8ywZkYZK?=
 =?iso-8859-1?Q?l1G8yK1oaYUB1Xqk0s98Zf/3YYqVsQndkayUi8b6/8EYsbLvZgUsn9UAna?=
 =?iso-8859-1?Q?Ui6BBJ4l2fretlO0PrP00QLcvD9wf47hxVShhcrJOnSNMPzeWp8tBuc91s?=
 =?iso-8859-1?Q?SpZ6pjFEFvpHMrTIQpO9Y+TjszrJ71mEUM0JcAKLdczvouF4UDDzQ/7wIF?=
 =?iso-8859-1?Q?LZWMLzFBFjL9rfSwFahGN+j1NJQUnTSY7CpgnkqRnJ5d7NylJKUcjzvlFj?=
 =?iso-8859-1?Q?ZTzS8uhHsajb5sogIgv/aoPF5RgI5jza5Va7TYpxQFilccJHuvFCpRPjOr?=
 =?iso-8859-1?Q?u18MwntDW7/uYOAeNK7nM8sznfZsqmyfRG5AESqH9zeraE/CYwx1Ihb5qM?=
 =?iso-8859-1?Q?9qTIWWKexv4CnAVc/kmpcPo5TuuVFlVz3gVyh9kzQrjeYDkz1k/8VAXfLT?=
 =?iso-8859-1?Q?LYCryNJRMMrThOe7dx1LXq08/iV6nTo=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0ea5bca-7f90-464f-d5f4-08da2d6b7566
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2022 01:14:02.8294
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N/K4YP5GlCf35kdN+Ohaw6KtrrWDmnvjgN6+dEHztiHPzjfDX73l+OhfPXG55eceq2R0cpswqvdmfb5C1E7hFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2688
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-03_10:2022-05-02,2022-05-03 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 spamscore=0
 malwarescore=0 adultscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205040006
X-Proofpoint-GUID: WzvC-zMalKx58LdACodnVoI0VCvVLQZI
X-Proofpoint-ORIG-GUID: WzvC-zMalKx58LdACodnVoI0VCvVLQZI
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

Remove the use of the linked list for eventual removal.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/ksm.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index 94bb0f049806..ea3e66241976 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -980,11 +980,13 @@ static int unmerge_and_remove_all_rmap_items(void)
 						struct mm_slot, mm_list);
 	spin_unlock(&ksm_mmlist_lock);
=20
-	for (mm_slot =3D ksm_scan.mm_slot;
-			mm_slot !=3D &ksm_mm_head; mm_slot =3D ksm_scan.mm_slot) {
+	for (mm_slot =3D ksm_scan.mm_slot; mm_slot !=3D &ksm_mm_head;
+	     mm_slot =3D ksm_scan.mm_slot) {
+		VMA_ITERATOR(vmi, mm_slot->mm, 0);
+
 		mm =3D mm_slot->mm;
 		mmap_read_lock(mm);
-		for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+		for_each_vma(vmi, vma) {
 			if (ksm_test_exit(mm))
 				break;
 			if (!(vma->vm_flags & VM_MERGEABLE) || !vma->anon_vma)
@@ -2221,6 +2223,7 @@ static struct rmap_item *scan_get_next_rmap_item(stru=
ct page **page)
 	struct mm_slot *slot;
 	struct vm_area_struct *vma;
 	struct rmap_item *rmap_item;
+	struct vma_iterator vmi;
 	int nid;
=20
 	if (list_empty(&ksm_mm_head.mm_list))
@@ -2279,13 +2282,13 @@ static struct rmap_item *scan_get_next_rmap_item(st=
ruct page **page)
 	}
=20
 	mm =3D slot->mm;
+	vma_iter_init(&vmi, mm, ksm_scan.address);
+
 	mmap_read_lock(mm);
 	if (ksm_test_exit(mm))
-		vma =3D NULL;
-	else
-		vma =3D find_vma(mm, ksm_scan.address);
+		goto no_vmas;
=20
-	for (; vma; vma =3D vma->vm_next) {
+	for_each_vma(vmi, vma) {
 		if (!(vma->vm_flags & VM_MERGEABLE))
 			continue;
 		if (ksm_scan.address < vma->vm_start)
@@ -2323,6 +2326,7 @@ static struct rmap_item *scan_get_next_rmap_item(stru=
ct page **page)
 	}
=20
 	if (ksm_test_exit(mm)) {
+no_vmas:
 		ksm_scan.address =3D 0;
 		ksm_scan.rmap_list =3D &slot->rmap_list;
 	}
--=20
2.35.1
