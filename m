Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A60FD4F1732
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 16:38:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377952AbiDDOjy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 10:39:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377764AbiDDOhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 10:37:52 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FCA93F320
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 07:35:48 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 234DncRv012575;
        Mon, 4 Apr 2022 14:35:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=lTVCdKEgwJl1+7KNHIRRkB4KopPrMm/m9phnlp2jz60=;
 b=LCCMmTqmdVcLWLbrcnUE/n5k4fH4mggcUbHENntRyUBHFw3k/Q6ND0bBpKNgNZs16PDw
 Y58dLSDFQ1JIlJ1slsi6iZnYw0H29RvJJ3tsGQC/yT+h4wbH7WrkFHsnrsXgfAx+M6tO
 99CPp/w1Y57aPKzuWOH6WG1W+CtbOhH37KLDnxOAYAg+C7HHRNdBKpmGn92p9MQznAo2
 VaGPKGIbPKY7qRwqaEIkfjNwXKgqJtEoaOms0TuecEHJPYqqIEtM383MfGsUR1h7p6uo
 BjBKN+8JyUeADr86LkMiPaE3cdJGe3A34+Uz4SJtl4mqv2tTBvqRxq38arjLRRsQv+sr Jw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6cwcbbnb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Apr 2022 14:35:42 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 234EZaSV034390;
        Mon, 4 Apr 2022 14:35:41 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2108.outbound.protection.outlook.com [104.47.70.108])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3f6cx2mh4q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Apr 2022 14:35:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jXTpZtYXZ8y6hIUR4o16BwWPFvCuS9BXGSo25WhVpjDrIOShwkd+nyZcqwZ1vc96RYXJiAKn8eXCocrzVt0RKLoKYFYFHy5rwEnWkS+nxID2YnFgG7S0Fk67egH7c2n7elafxEq5D3ruYnWTlCzSQMrf4Q/f2KWA+IRUxoHIqYRCWgvRRSjYRwYLs3UsI7S4VUcBISCt1J3sBkm6Jhcib5CTr7TFXSZ+mxWJtAHnBsvFdie1Hj6nCk1ojSvWSXSAY9YcJ6BytvSSAGS3n0KGN/IcRa/D5KGe6w5PMzdpiOBLjjTYn0MH9dZ0RK7OjjS4O7QvXlgqE60HuXFo9Qw2kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lTVCdKEgwJl1+7KNHIRRkB4KopPrMm/m9phnlp2jz60=;
 b=DawFMS6MKsRdW6vMFep3eXgf6RZs1c3voaOkNXeZCMb3WW95SxqFUFhnzJuwfnzQGvaY3iiAByeXdDFMMpL2MznUwatPXzBde8R66ERRoU9wj1czRIJfioLZSU0n7yjlIwaQHXSouuvqlGiekedP/SR1tQwqXk/z9KLerNvmUdFSCs1TGRC7AjyB3QCJND3xRGktECGAxVhOEuXP4OgWclXiSv3o1/0XiQo+wLCSQVlpBEh7djiwilwUyJ/xLIDVoRrmdGPolBeAYMnAOx4abH8rip5DqKMr3Dr7e+7BUt5a9p63OnG8BQk02cwXT2WWv5s3toXhhTyMyT9T64OA4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lTVCdKEgwJl1+7KNHIRRkB4KopPrMm/m9phnlp2jz60=;
 b=PrEVeLb6Cik34rf28G8w4TRr8XGU8It5yOMu9rPeSVNuPyIcmLOZKEEL8TeYDzCTQCvDEA5lTIRsxV6E2eI92IY0ozrGeLtBkxip+s5pZapo0A0B48pwybA/pBS2yvoYKQFS5xHAtuiymcVINHRovRGNjNzW1sxkWvCNqaKF+5M=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by MW4PR10MB5812.namprd10.prod.outlook.com (2603:10b6:303:18e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.30; Mon, 4 Apr
 2022 14:35:39 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::74fd:df41:4c93:24a5]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::74fd:df41:4c93:24a5%6]) with mapi id 15.20.5123.031; Mon, 4 Apr 2022
 14:35:39 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v7 12/70] mmap: Use the VMA iterator in
 count_vma_pages_range()
Thread-Topic: [PATCH v7 12/70] mmap: Use the VMA iterator in
 count_vma_pages_range()
Thread-Index: AQHYSDFA6cztlMqiIU+Ai19Fj3W7ng==
Date:   Mon, 4 Apr 2022 14:35:37 +0000
Message-ID: <20220404143501.2016403-13-Liam.Howlett@oracle.com>
References: <20220404143501.2016403-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220404143501.2016403-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 50f4ab81-70ee-4075-c215-08da164863a0
x-ms-traffictypediagnostic: MW4PR10MB5812:EE_
x-microsoft-antispam-prvs: <MW4PR10MB5812AAB7565411F63D642BB5FDE59@MW4PR10MB5812.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rnYe7EgbVWRJ4ShFf+aHG0/IMsU6q+vpvZwIuGAE8/YJijvvda9bUEKMZvzS2BpEEdF0Pu/d4FEXO/sUS5UhSSdr1TgkkQTKAxS1rFzbnjAqliB+cIx27nyeqwH0tYC77xSZe8GCQFNxaTilLa7x/jYLOx/gB+pSNVsqrkboveTjBW9xgK2BQfZCHCuk/TB1wQ2Z6Sg0evW+3ydQQmeCOBGc1d5qsfDb4xGFATRSXZSErGoROj1Apv43DxwX6gHquFu19b6lYVWKMX0DCNbxOu7UH3PAFuwdpmo0E0GIp6MrAQVL3quLbHO+BQj8/B/99j5Fak4ccGzf8vE7AEN+iWpMLFLiewR1Jt4v7EZCRBP0rsJdj9fS/NeXSzNOeFu1fQOVJZr0MjsVCXnHDBbajmQ3b2PcQKet5e56fuM+6P50v+2uOQXA4cSpy//i8tTQ9d1JmsxI36eh/xS1+e0l4gBWbMjJPX/uWk30UzgmaHM1Qlnp76dFErudhpLqpaH5yzIabCWwtohWvMCJywX0GOBKZVMjt98X1SWD5tOARjbHYbvmZleLgyDn8FSEtWGBsD2EGbTJKCZ8M2Nn/DX9V2EMHt00i/hJ79woblWGhzdUdjmGWnEWeIkyxyKLLEUSnIWYDouURan/cJiSWn4nIMXzHaAjhrJurC1kwhs/izoTytqITMEJ07idt9OsWtSQ76EuNK4i3Y6OW+zMgiVC1Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(26005)(6486002)(8936002)(1076003)(44832011)(83380400001)(508600001)(5660300002)(6506007)(36756003)(71200400001)(2616005)(2906002)(186003)(91956017)(64756008)(66556008)(66476007)(66446008)(76116006)(66946007)(6512007)(38070700005)(86362001)(38100700002)(8676002)(316002)(122000001)(110136005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?kwv0vvcRnyJyRWZRUlBRI7q/jQoOn3GEXlOvGAaEeGaqDypM3BgPzZOmrr?=
 =?iso-8859-1?Q?MWF2MNuaHX4hvNPHihfFOshe3WovtKNlAGBKthe4pAZ6sTk8wim9SixPEg?=
 =?iso-8859-1?Q?SAW3ymLOM2Kxyzm5YUqzQHCTaprInmUKFbqPdfP02brl+cMHaB5+kcKNuV?=
 =?iso-8859-1?Q?vMGTwdSDyojPOYqetlw1GahO00ij0YF0y550e6+gUny3XE5A0cpgx//qC7?=
 =?iso-8859-1?Q?RGRwtaXpjI1VudXqd7qVSPCDpNxdbhXtns6mkzHaWoE87c2oO0L7iSRqrq?=
 =?iso-8859-1?Q?eg5A73hRH94KQuJggfO6gWkQddlpOCLWZ8xiHH9oslKHLHczt9LEfJwJz1?=
 =?iso-8859-1?Q?KDFcHF7oIhbF87FjEtkxXDGqHXqaQH36/iy4qsKoaLD28L6JaS/pYp+KOD?=
 =?iso-8859-1?Q?WZ89q9GK558t/gddnuLOa6RmUM9JSjwr4EDFQKkBo71ox8Ra06Vm2qStCx?=
 =?iso-8859-1?Q?+0q1FTbziW8sZLqG9NEOxD30RnFtjzPcib0U6v3XOW8591jGXfE7fLyD1b?=
 =?iso-8859-1?Q?phpAapVudSBzmxZm9jD5Tj7N2jG+Bv3NE/ORqD+lUG5jj9G7q7PF/SYrxC?=
 =?iso-8859-1?Q?5t7SzFVqKSceMfeiEblAh6Fs+U76eSu1e6/L+488zZOQv+aHWG5G07uEuU?=
 =?iso-8859-1?Q?gN7A0CZarTNVlBos/mj+cSpn6l7CBGr1DaR0lNvuwWpvMevOodytqSKlOz?=
 =?iso-8859-1?Q?FP4d1sbdiNHjzK7GFEEtROa5rcuhc1351AfbIERwFH9digeCrHeRIh+4k3?=
 =?iso-8859-1?Q?d1mz5agYFojm4/GZx/gQ14Qu0r/+KRrsvoS7qCAQ7lUudZzh8AMtqhrE/R?=
 =?iso-8859-1?Q?JXk0XefpaghiSzAqt5f5QCdRRcbpbVuW/Uu1a0GVtk88N4uaXrgrHTA6FG?=
 =?iso-8859-1?Q?nT+dAuDtJdPKTPBKVUDjrAQYXDJqrWco2ZrpLrMJepjd7tbuippSQgviZn?=
 =?iso-8859-1?Q?gzeQfeqaUVSWoV2nIhZM7Ysx6zjEWn/bropjSXhp3bDBcsZUcfj1vS7Uv0?=
 =?iso-8859-1?Q?bGfQkgFE6NVQPVaj3TlwqvOasLraeB7DAimLrqg9SydvVM1MxKaxQFWMjj?=
 =?iso-8859-1?Q?tIgBSx1yuZlTkBzrxq4wlfEbtb0SuMtLr8pcbfO/Ekyqw/cBCRv+3Z44Ey?=
 =?iso-8859-1?Q?7GWFboNsbLQI7XBl78aSz23fMJhXMywwkDwI1WtRjuGLPRDdT+PIn5FXpQ?=
 =?iso-8859-1?Q?DPB4Kw4Br6bqaiDw3RmFY3Npe2Cr1LGtybj5qzhcQTwMsThvrbkfd0XhAA?=
 =?iso-8859-1?Q?WvmdsLhryzWvz42fXjRGWLJPUbcdT+11kaiwMVpx4QTVAe9n8mn0SNQLuK?=
 =?iso-8859-1?Q?OID0lgFP8s+7SpfkTbA0uRogW0ZrXYHIAUrIS3fPTdzeNU3Rdm+GtrUrR0?=
 =?iso-8859-1?Q?bXZ+K1zCaQ8yMcpF8K14e6xt64k4nEfYZ1SAstDv8noxkaW5gB3hPsYatn?=
 =?iso-8859-1?Q?MI5fidajnxyEjg9JFtqcr3SZy9Te6S1sLjtaSd6aD3goNZ38Gcy4fBoOhs?=
 =?iso-8859-1?Q?kknwjoq8iVtjW3rJKJs2UqwV3oyxOKQt/PDWVVIYS3awpNojWSbGFdjAWE?=
 =?iso-8859-1?Q?EJ/PVfY2TNohpJPc6jR4PQm823eYVSK0UzzBYYQJeEGxoKY9b/nJw6lFVZ?=
 =?iso-8859-1?Q?B/gF3j8MIjj2de+4Is5ZwjM3vuKonLUoK58Q2bshwXf/8hp+RWJhZeCXav?=
 =?iso-8859-1?Q?po0XIbeNEmBEasyxd8M5EgO+COoQcczf4TvghJ2OHixq1xMXYJo8Ne3tTU?=
 =?iso-8859-1?Q?7ck6A325gVRFvQottKduqm5qgr3A0wedSPMzSwzkelekb/MhA61niBdqzw?=
 =?iso-8859-1?Q?tbxjwe7DK6kgUJMjFsGBsbbaaLLnFL8=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50f4ab81-70ee-4075-c215-08da164863a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2022 14:35:37.4252
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XeFrCPuF9iwF/FfPgOxbivHxHnBBynX+bzlA7ExV2NMwZ2/cdbLSKRUOT+mSqn7Ncpo1rDKGem9nijk75FxMDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5812
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-04_06:2022-03-30,2022-04-04 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 spamscore=0 adultscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204040083
X-Proofpoint-ORIG-GUID: DezWE8JNw7sBudBKgwet2ngGkthGANGp
X-Proofpoint-GUID: DezWE8JNw7sBudBKgwet2ngGkthGANGp
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

This simplifies the implementation and is faster than using the linked
list.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/mmap.c | 24 +++++++-----------------
 1 file changed, 7 insertions(+), 17 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 82365f9427eb..3b4351f384b5 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -670,29 +670,19 @@ munmap_vma_range(struct mm_struct *mm, unsigned long =
start, unsigned long len,
=20
 	return 0;
 }
+
 static unsigned long count_vma_pages_range(struct mm_struct *mm,
 		unsigned long addr, unsigned long end)
 {
-	unsigned long nr_pages =3D 0;
+	VMA_ITERATOR(vmi, mm, addr);
 	struct vm_area_struct *vma;
+	unsigned long nr_pages =3D 0;
=20
-	/* Find first overlapping mapping */
-	vma =3D find_vma_intersection(mm, addr, end);
-	if (!vma)
-		return 0;
-
-	nr_pages =3D (min(end, vma->vm_end) -
-		max(addr, vma->vm_start)) >> PAGE_SHIFT;
-
-	/* Iterate over the rest of the overlaps */
-	for (vma =3D vma->vm_next; vma; vma =3D vma->vm_next) {
-		unsigned long overlap_len;
-
-		if (vma->vm_start > end)
-			break;
+	for_each_vma_range(vmi, vma, end) {
+		unsigned long vm_start =3D max(addr, vma->vm_start);
+		unsigned long vm_end =3D min(end, vma->vm_end);
=20
-		overlap_len =3D min(end, vma->vm_end) - vma->vm_start;
-		nr_pages +=3D overlap_len >> PAGE_SHIFT;
+		nr_pages +=3D (vm_end - vm_start) / PAGE_SIZE;
 	}
=20
 	return nr_pages;
--=20
2.34.1
