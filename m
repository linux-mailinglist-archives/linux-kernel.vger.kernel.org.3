Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7FAC4F175C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 16:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378214AbiDDOmW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 10:42:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378064AbiDDOkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 10:40:09 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AAD03FD9A
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 07:36:38 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 234DlFTP024455;
        Mon, 4 Apr 2022 14:36:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=VCmwu5V5pRY8UR9a6ZUOMfw+WCnEcnLW55u5lIcP7pY=;
 b=Wx0lbBwecNDabHovLkdU6/17/lWi3eua72dTgbjSIMPhI8ZrvxSJ3vKXoNLgVswuAabp
 Da7lP7Ls6aheSkXxSH7pGVeTSTV2UqvOUNLP/o2pcLtNpfE2Yb0LDX5pTNBfgrECh4wk
 F+ocnb1NObG9pceBBGniXMzP12TQflLxywQjOTtPKb1CCZOv45OKyUF1m3jyGZMgG+J3
 qkICclau9en2r+waQsiAVcPKzLspnExSuI2GoyzcxBu9XXFQfDBs2/2WD29OvGJUVrPR
 CcfO9MJziwbiBVJ2EO7BfoRi4emy1O7KxF7cebfaJfp6se67E8km41zbjQKm+J0j1h+S 3w== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6f1t3cw1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Apr 2022 14:36:32 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 234EZaZ5034331;
        Mon, 4 Apr 2022 14:36:31 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3f6cx2mj48-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Apr 2022 14:36:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aMLsTr2AIOTIZ7DPx8eQb9TRFInS0JN/IH6jldHNPmSLfh6T0d1dXNvZL76d9b3IxmQvC5lOxscqXPKN+8qjgTA3ejlky5mvg4k1OSmsjouCnavOuBOOOhaR1/lTcRb1a3lNOsAf03BkICMzhxG1BXyywKF8PW6IWnhLgJIbPxS+sXduSFXlQPo6umPgmZ0MF1fp+4sk/HWsyUxZRE7YnuclttZoliwvghdOMKdmBAG8crOqtBYLEkDWbJOO1QOgcn8sYin9r6Ar+tNrHNn9dwZs12TcLOrfEfw2nVRLqQyYXH9BGDSSCXvKeU1oIw+EFpl3ob9fIn1YvGGtzO364g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VCmwu5V5pRY8UR9a6ZUOMfw+WCnEcnLW55u5lIcP7pY=;
 b=H4o86Klccph90O0Hra+h68QuGQQ1yeuGINxJubdHiXfQccKf54r3jb/TpU4qCrBISMBoyegyQHGbgxo6QDCvmu/gWutsF3zsBiXvSzq3fgAqi4EUR6gieKgKgn9Pshwwb5+FR42pMBM+HmBoSEXOu4Xw2G4bR/gkz2gh1KpL2W+6MnG2rY1HXrqNvkbxdA+7UBbB3E+k5rpi8Duh/mXLJarSyCyqC5wyMC/vLMOGrCH2j3PWVwZ491y6BkelmwCGq8HZOSfvsXne4eyJEzRiKTKseBCI8z+ouJmeJxdB63lKDrW18HCeM9cOwNuBSlyszDIRoTysXRC129XpyMQ7pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VCmwu5V5pRY8UR9a6ZUOMfw+WCnEcnLW55u5lIcP7pY=;
 b=W5cgmPA6xhn3Hvbj8uyfKhyzB7Xm4AEekx9utwnom6M1tBGIZgofAQfyHL0/e4cGgucZDKAL+KSrRpRYXO6zQTmRrdNfUQDMbG2aeedoqktwiHRmyNxNNO4XOhLbaYhgvPJ+YLk/mNZerPyIZpEwnlilz4US0/Gx0gBMfU27XE0=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BLAPR10MB5329.namprd10.prod.outlook.com (2603:10b6:208:307::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 14:36:30 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::74fd:df41:4c93:24a5]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::74fd:df41:4c93:24a5%6]) with mapi id 15.20.5123.031; Mon, 4 Apr 2022
 14:36:29 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v7 54/70] mm/ksm: Use vma iterators instead of vma linked list
Thread-Topic: [PATCH v7 54/70] mm/ksm: Use vma iterators instead of vma linked
 list
Thread-Index: AQHYSDFJZWd9QCG/skaRv/RMmrDyKg==
Date:   Mon, 4 Apr 2022 14:35:53 +0000
Message-ID: <20220404143501.2016403-55-Liam.Howlett@oracle.com>
References: <20220404143501.2016403-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220404143501.2016403-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 135b4709-9907-4685-c1f7-08da164881f0
x-ms-traffictypediagnostic: BLAPR10MB5329:EE_
x-microsoft-antispam-prvs: <BLAPR10MB5329AB8BE8D0C620BC104862FDE59@BLAPR10MB5329.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JTdVWiVJl3AdDu55zF5oxFhfTZ19H/Qqp71X8Gjm96nWgNzz6E6nzNcGlzz1u/mZ6Fa5FEy06fOEHZJrVDE7ugKDZCFWgEv5jIDRR1nLEFJvGZqw9J7ZokHXg8gUIf4zoBO1Ivq8j6Kx9O4EpYXPCVMHbRKp1s+7ZkF5ZvA7BOSsHSU0YP65csgWYaDjAhP1cWIqavrvOJHTQtbut5VjLqdQWxKmCLtZc/8f3SUDAsdA7Og/xUgGv23pHGFVUxmIzWRL0cBWGFzPtk8tIuhK0ekhix9AJhg28zybRNekyPfJZsbBPLD3x5yCuYGqtPZyv0RLDEDuou1oKbTU0oBohTX9EPUYwKym3STmU0DaSVJEsK4S1UpSyO8owT7deHOghRoilvXaVWSEuYmQ3KsgfvyNP5JHaK+8aXhq4Vyu1GrM0X/lX534tfdSN1eLV2Nft9cYLeokicISvan4KvU/fFs2kwEkpOgKUPKJEfzE7K+ZVbYxqgLsw0XFDPRTdS40Lpcenzk9RDXOOIkrnPz3eFFdlZKzWBL18Xl828VZl4On3z8hq9L2ClmOScXA6cRXQWn3cqhZDicmlYCq0Ae5VuFDv6OImNsFfkFpRisc2DLjzmIpfE/IpWLt5Dbv8tmFXOyJAnJI7DTjGFP5vUrFP0S2ZNXfMM9xB4bVGA1SZIVea92BiJnjGhXvhMnoOrgHIC7LOPL/ejdonyjZOQ1bQw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(6506007)(64756008)(76116006)(66946007)(66476007)(66446008)(91956017)(316002)(83380400001)(38100700002)(66556008)(6486002)(110136005)(38070700005)(86362001)(71200400001)(6666004)(6512007)(122000001)(44832011)(26005)(2616005)(1076003)(186003)(8676002)(8936002)(36756003)(5660300002)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?82d290078A5Lav6LtMoSMQwZ8aL4fROOJklaxlL+03omoZDA5VNCiKhpyN?=
 =?iso-8859-1?Q?OHDF+FgBw9TRUtp2aGyLqqsro90fiNgE9k8R69OpuVojZsgC//5HU9DJxz?=
 =?iso-8859-1?Q?FlFqKHx7B90T78e6uAWr4JtMQPF7zkatGcFQGcoi7pnwHqJz+xdzkkR/x2?=
 =?iso-8859-1?Q?KPx9sGihp7Ctw9FtLCPn854llukhzJWXDLaGbToXAy/TsQZCKtx1cM47rd?=
 =?iso-8859-1?Q?Ae3P0fJvyO30bs9I4JbS/Vz+in4UKMxwLknUJkf1q2MBdiqVTPoF1M/0m0?=
 =?iso-8859-1?Q?yDJWtFhGWI79PgprJ16tJx0UnEL9Nt46t9EJ2wjK6032wRiR+uY6MleQX3?=
 =?iso-8859-1?Q?cw1BXZS+aspTfLkf6RsydsndxGk+bTJPcVWlwJSd6HZP+Sxm8YQ2dw43Rd?=
 =?iso-8859-1?Q?qMQm8tFEDU/C3nzrXVgiCj8J40NC8AUtDyqDURB+FQzfRwejMW08XzL73v?=
 =?iso-8859-1?Q?AlByKx55H3Y+hJAUeN8kxES3fBqPithfjg1jb+OQHTFcG8Sdgle1nHf2/8?=
 =?iso-8859-1?Q?KIdRvSgAEagQZXT68CTdwBW4fxOuHht6caUWxGKYJaWEbhNRt/I1hH778e?=
 =?iso-8859-1?Q?/nM5PbfScsW1cQqEufzuc3Rq4djdFRMB2blFDr+6bKQYjCCfj5OEqaxEBA?=
 =?iso-8859-1?Q?R4MrkC9eQPpoVd6IHvCRFg5vL6mJn1dQsJq7yYMgJuTHNrN+MBHGXoank5?=
 =?iso-8859-1?Q?ArDLKIu4jbJWvtTl9lm3EIDnT6srC+mV5YvHJNleVDWpnJGTElH6CgCaCA?=
 =?iso-8859-1?Q?/lA4rimhv7xHPm/qFUZLwqkpATy50nAloac0DneJKRmSAptqDGlzYPlpQf?=
 =?iso-8859-1?Q?SeU5qQpFfy2J2bdlYgVBq+dAYVmErVhNTFfRihuvl/zUlgnsbJUOIWRvf/?=
 =?iso-8859-1?Q?NgI0Ks8I3vzeiCOsltzqmOq5Rv2gMdLHrs6VjfN07QUCGzTDvyuHQsf1ip?=
 =?iso-8859-1?Q?kI3/J7x+kk2AtLqvfWzYyRfkNMjGgc7gh3uBpbM0ndWv41L3s6qN2cSPrl?=
 =?iso-8859-1?Q?LHjqtKw0FNqQiP8G4W67cpazu4CbVTO2LmLUBw70DRh26Co52LhyfdBOz+?=
 =?iso-8859-1?Q?KapH4Nxdu7Y8wt7Z1omDCFK2ClrDZgi+QGqf963sBDf12wfSVB6QTI6oJj?=
 =?iso-8859-1?Q?ZieAHsOvxNO747xO/RHypY6ZYLTTk/xTcMAWdhWWkg/toZWhicE13p2grm?=
 =?iso-8859-1?Q?FWgUQ1NXnvIeUARKwclxOuzGVqnmSbJGzD1wwPElWlQPHchAzOVTA9Fr4v?=
 =?iso-8859-1?Q?cOH5zBupcRhMEgNXGHHSnKDFVr2+fKEPWEzjvtJORClU4hWnJov3fAHNrM?=
 =?iso-8859-1?Q?RYnCHij9EMML4fTeGPmrHRvLVY6jzn2GEDr2nAIAUo1MuU1AxJ7BKwToqx?=
 =?iso-8859-1?Q?Leinsog/tBHiezuw8VT+uEBA108xiBL6nNtiZbqNfp/wTu1++nPZJ8HO40?=
 =?iso-8859-1?Q?iMMZpt1ZkKnoEF73mL97sd/8I9JAkT+W+Nyp8oXWKqPJxIEMh6tDjc3986?=
 =?iso-8859-1?Q?sCt1+B3a/2ayYXJVpahXKrbr1Eu9doxxsbweLiD+0tJ4oZNNfgoJu133by?=
 =?iso-8859-1?Q?QKMOnYFFYvh74smLuzwnvdWtm7Y7RMsGP6kN3hd84/RtfLLV2QZRxSPHuU?=
 =?iso-8859-1?Q?JwDX9leVjIhRYVZ6kad/ieRGGVL2/GCyIMzZunmqHvGj6Z32kL74ix6mkO?=
 =?iso-8859-1?Q?FkpJ79zQ4uUsTwyThMYm+6BJ3h2SQ1Zx/WZXdfta1Wwj3b9EfiSEnny/p1?=
 =?iso-8859-1?Q?6w8bjAnH0VkcSc3Kjupgaxlwjim/KRIh+QebeEyKOQrG3zhSzyOIH+uyTb?=
 =?iso-8859-1?Q?Yi5qJpw4wjaG6/uVjtsqm+RiBOxIOhg=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 135b4709-9907-4685-c1f7-08da164881f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2022 14:35:53.8928
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t5RLBkMxjcEgIkJjQxLNQSXkZK+ebmKWbRQpAOgTjzgmTjw4kATRzrDzi+bFEwoCJXW0RSyCVr8iaf6oGFEgGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5329
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-04_06:2022-03-30,2022-04-04 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 spamscore=0 adultscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204040083
X-Proofpoint-ORIG-GUID: cm9kXOtZdMv4CQo0Sh3z_Dz2bSh932MJ
X-Proofpoint-GUID: cm9kXOtZdMv4CQo0Sh3z_Dz2bSh932MJ
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

Remove the use of the linked list for eventual removal.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/ksm.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index 063a48eeb5ee..c60c313d6052 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -974,11 +974,13 @@ static int unmerge_and_remove_all_rmap_items(void)
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
@@ -2213,6 +2215,7 @@ static struct rmap_item *scan_get_next_rmap_item(stru=
ct page **page)
 	struct mm_slot *slot;
 	struct vm_area_struct *vma;
 	struct rmap_item *rmap_item;
+	struct vma_iterator vmi;
 	int nid;
=20
 	if (list_empty(&ksm_mm_head.mm_list))
@@ -2271,13 +2274,13 @@ static struct rmap_item *scan_get_next_rmap_item(st=
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
@@ -2315,6 +2318,7 @@ static struct rmap_item *scan_get_next_rmap_item(stru=
ct page **page)
 	}
=20
 	if (ksm_test_exit(mm)) {
+no_vmas:
 		ksm_scan.address =3D 0;
 		ksm_scan.rmap_list =3D &slot->rmap_list;
 	}
--=20
2.34.1
