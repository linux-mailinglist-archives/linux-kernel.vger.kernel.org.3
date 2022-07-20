Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90B5B57ADAE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 04:18:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237896AbiGTCSn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 22:18:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241111AbiGTCSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 22:18:05 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9A225A891
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 19:18:01 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26K0YB9A031774;
        Wed, 20 Jul 2022 02:17:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=yAfaJO8l1leCklXOeKTJrrj7V0UQ9LpW4jkyjoVvjpc=;
 b=egr4ljVPnIqBs3kpkh0NQXqovVRXB//0qK0ggXNbklJE4la9vd9/9Cp/RECeG8xnLENu
 J8SPdONPJRcrb37UEygSJ5u14RxY0weFpkOzy8RrnD8uahZrnO8VWcWmYUKYDTZR1nyq
 GwAwJBr/dQcjknUlrn/F2WAc9QMo0Ignuod6DT+QWmC/JqtHwMnAQOrNhXx8yKEDS7Im
 uegq5dHlVbvc6cZyA5Ajgep1JL5oQPYhAuoNXHYdF7DIl3cyXikv7ZjUoUbZc/eFtLvt
 We6N5ekpeW6r5plTMpxR5TuB6wu6TUWCtZQoOXTezqmVlDZvbg6QRcoNMVsKSrszKE8M 0A== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbnvtg6ad-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jul 2022 02:17:52 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26JNHLKv022321;
        Wed, 20 Jul 2022 02:17:51 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2109.outbound.protection.outlook.com [104.47.55.109])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1hseann-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jul 2022 02:17:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fYyzrcMjWrUIJBo0YI/btPwKUyRw1le5JnZBXZxAVrdZz4pDHGFUS9tMmRj6WQQYP+XB8H4HbR/412xr9yQujq2Jj6vOg7Xn9HJeNHGfj9PKn6rHYAOYR2q9mYUxzlg20xmACKVgtAaepCyYamsYBtqIdl9E22YLyrQYbiM0tgR6wGr18S9P6ZBWm55KZmju5DXlqNPR0/4sfWpS8Mrg26mTRDER9s0oSXbAifLlAfhVVvM3ZjEIFAasI99ByrRafqAvjQLmuA7hcFjC8agtdG13SLIpIwI3EplaqwEhZHYrNpx/G28CQgOZ58wC5ZVoUPZNYd4uUFkYjL+hZeOVOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yAfaJO8l1leCklXOeKTJrrj7V0UQ9LpW4jkyjoVvjpc=;
 b=kQ7Sx06b26xd3eSErLp8Xvy71JmxBTMFVKWTToO9ih7WBuBFZvawL/H5zMajfHbSD55Tjc+Mwtn4+D0J529UkzmHq0N28F46UrqlKW5RJRSdxrLgn7Bp2ZTk65tOtJ+sMFo+AkDksRqdmdlJRy70scm6ycw5cbqUppKk+66yoH5WJO62tw34XPz6l9HHH4Lc8mst1GGuCGSxJWhG+nG81Jz/mvOdvaUloiZZevYDnvlfTQWdun+0i/6ovvGfeeeXfpYjnDJLLYH74xRoA22etwM+8Pep6Jr5/SJCO3fMxymorg3+9dbVas/8k2+ctVaU/bVl1PosBWl5rWGhqL80zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yAfaJO8l1leCklXOeKTJrrj7V0UQ9LpW4jkyjoVvjpc=;
 b=APtDwPQG1XjhMJ3yrFULBmHR1axyu4I3rc7qOck7FcbsqFlAg/oobAnIK5kWVQWVGHqICEshFB7kvDICvPRV9sNQorLF9sdrzZUZQuiHxTn4ETyHjsFWddmd9gLXAzD8lJWcd4TVhi3jFJtGV7wW9Ke7oiBHGXttAlCg4p860XA=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by IA1PR10MB6243.namprd10.prod.outlook.com (2603:10b6:208:3a1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26; Wed, 20 Jul
 2022 02:17:48 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68%6]) with mapi id 15.20.5438.024; Wed, 20 Jul 2022
 02:17:48 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>
CC:     Yu Zhao <yuzhao@google.com>
Subject: [PATCH v12 10/69] mmap: use the VMA iterator in
 count_vma_pages_range()
Thread-Topic: [PATCH v12 10/69] mmap: use the VMA iterator in
 count_vma_pages_range()
Thread-Index: AQHYm97magwbQUK8Vk+hz9mX8bBJBQ==
Date:   Wed, 20 Jul 2022 02:17:46 +0000
Message-ID: <20220720021727.17018-11-Liam.Howlett@oracle.com>
References: <20220720021727.17018-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220720021727.17018-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8b233ce8-16eb-4993-d122-08da69f60a63
x-ms-traffictypediagnostic: IA1PR10MB6243:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3CekGUbLvha533Fg/e9MVnqzaby5RN6nAi6Bi60CMZqX6/M6+uO7a/JO24Z/uOk08GAdnkxNxBXxv4PzSR05mz61GAf89q5hcgkeguvYhf25i9nVTHRBVM0M2I8nyj1heV4OAIZ9VHNijdhomgvZ4FofbhWVV9P00Qk2j5Bw8omYVBZPhGekv0quM2dqq+0o93DM5ZDyOj6KUNwn4se8yZfMFRM8ymHEE915xuSvKyaC4M9XWP9CbejnnSQlZ+gvR5sE+7L+xcq7Ppi/GZqVCUtd46wm6TgOIPMCPScbVxMaA7+CAQZqmU2Il6rQGs4BVHIjOZaRb8KoioKjGLuyHQhy80eTY2ryhl8cG+vGfzGVOJQWj9HNnK+Ead0kSkHqCHwC2TZ7iQ7hCQ61hZk+NVpH5NcF1I9ctpaNAcfTFpty9aZHLt7aCHQj2mi23AMyTkYSYXb0456U1uhH2XyzDUUeb0jdwiX1oC72pc03QC/mM1Ln5WOl8ecbu4TH7RnoJEKmFm52/z9UJOf3N0faBOpQCDtF4w1zBpdURqOosjWNWLXX5eCRODQuYM8WBtnAzp1wtU1rJJ1RDXvSJYvBGnF+IQuGJ7ILapjn2qNpTqHPMlqNh7mLNnW9KgHMQ2s/H8yJUwx9XgoVdotWg4YNJeQGXU91ZYtnLQDO0zfBBxpVYhf85Fdtk2rBEgVur8yVbTkanIWoKBYl4W50AoNU9XCzrVxLo/qGupwtkoEPyfCG7WAJQ8eN8dT1OhWLWE4BPRYxJaMKz3VhHpJMoLM9Ye1LDl7vsD/2bRnd4yyG5I9Ic6X+V9vDHHTQDnXjiiVE6bE+VdI5i6KwAS0DT7mQGKrHpDezGRY+D9gqLECfi4wtlxJ2XlLjakOp0N9EKam4
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(376002)(39860400002)(366004)(136003)(346002)(2906002)(26005)(1076003)(6486002)(91956017)(8676002)(71200400001)(86362001)(8936002)(5660300002)(38100700002)(83380400001)(66476007)(6512007)(36756003)(122000001)(966005)(38070700005)(316002)(478600001)(44832011)(4326008)(64756008)(66946007)(76116006)(186003)(66556008)(110136005)(66446008)(6506007)(41300700001)(2616005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?teVNXIoGEoi/O6zJAknkzWqC8iZi59UzelE4bHlP5RizgWmgpDVJ8SFLy8?=
 =?iso-8859-1?Q?JbyOd7gNIGwvh3nzcwRw6HVP3NdNzy0pCB8HNPL0tViQyQQOQwMRcMtdXU?=
 =?iso-8859-1?Q?SfPp8n+CKUefSJkBD0Z6ZyDsZiXZc/RlHSKlq+Dql6PXBkHPw5FyNSrElS?=
 =?iso-8859-1?Q?R6hIZctkfiqdN4vdP1UTXKo3jrRfEH1R2TakddI5bzqFYYqw52O2P6ExSN?=
 =?iso-8859-1?Q?Be0e3fpZMmx3NgZId0S8uL5GXzBBWQH5MQARK2f1tVNw5emgrpGeZa1Zcm?=
 =?iso-8859-1?Q?H11t3dPr8h494iF193xnaMn7iA3Ctr4VGOvMCBvf7Pqfd4HbFI/Muz/JTK?=
 =?iso-8859-1?Q?ok91YyZvq8VqPxo0cozZZsophQsBYwi61HwiH+KrmgO/cUXrGbQ0+m5XaZ?=
 =?iso-8859-1?Q?TEkN8UgOVAvOBE9491YyC3uZ4f9kmx4MPtzb0IF6vlygS3q4L5JhWaUb06?=
 =?iso-8859-1?Q?cCOuVqsmqJCycFe2QDfZ564Hpw+DKDFEmUG0+Ux75SM5QT/1D064Y4+1BU?=
 =?iso-8859-1?Q?7s6Rle9w9VvnHOGQFP2a0RaY2+30+gsxavGR7Rj17Btb57MH9PXFuMeiH0?=
 =?iso-8859-1?Q?9MomTU+3jJV2ltAblVX70Il0XufMpruO88DdFnukjaLyGUvZ22j9y17iW8?=
 =?iso-8859-1?Q?DUM3uN1KMfGzzGxdRb72vsls2b0i1HR6rLfCdvtFTGzbtZ+zKle5kkBvcG?=
 =?iso-8859-1?Q?qV+6OXQuEvPo+hpjIMun77YEcDdzs7YR8KsMJNWqL0uuQs9gNx0GfH8Z3M?=
 =?iso-8859-1?Q?vmFlT+xB967ZnIpRv7WATfqLlV37wDsawhVMBqu5HrNTNizn77+qjkWOIF?=
 =?iso-8859-1?Q?mhpP0Qhjh+COQgdYW7MSJYNlM7etccuVJoHzyYuoOVXfDP4NgZ+kvbby7U?=
 =?iso-8859-1?Q?Cf34Q3B8xQNhQ7BdP5TdNKoXsmv3cppUmBJ2qPh0jamdQWcWkuiK2n63XR?=
 =?iso-8859-1?Q?xi5kRttctEIgePOD2uRq5+j228ZLNLCA/JH2f4kwNMliwFe1rcgTdfe0+L?=
 =?iso-8859-1?Q?kKylKMdL4EwYTimpSp62U4KF4Wv+j/OESqBOD6rTIV24vdjD9rQYIF9eK1?=
 =?iso-8859-1?Q?+VY79j2ws09iliIhSJtRepZZsSvvmKIgRMKU4e/iBlwvNxyZ3wbJlzPCPM?=
 =?iso-8859-1?Q?h2xYwH7cJwpVtph0cXY4aAjST404/t3xO78FvhC7G2li36s7rT2KJUBNXA?=
 =?iso-8859-1?Q?ncJDALo/hPUcZk9y1WffX1KjnZ/yLxU2w7+GoMi5rG4Cw711NvPR61GEx8?=
 =?iso-8859-1?Q?BbbFY1Tmb8L+FONn0VbnkKZU2dPbyy0rjeshEIQ3bbGjMmhQJ3HMSkpsZ3?=
 =?iso-8859-1?Q?9OygolwL/d2I0ETBPCDtK7T8EwfVOYv4CL+q/SSsbPqY2hOsUglbI6Mv1M?=
 =?iso-8859-1?Q?ZkRcxWNUSrR98qgVwO6TLKOCwpf1RCbFQtRbfaonk/E+lnWm7a6uO4bgD7?=
 =?iso-8859-1?Q?MjYV9azgLKMsvmSyxQghsYT9k/wxWNGXOnL/R+IxnZltA813vi5J5VcTj6?=
 =?iso-8859-1?Q?tTfFJSARKEs2JOAIoC1Y3WdoXtnRYC11q2LOHU3K0TBsJbeD7M6h3RDzbx?=
 =?iso-8859-1?Q?ulUZnszra/yDcaxV+ryfEGP8fBHPTMaG2RldJ1C4jL8g3uEbFwJgxrNFKt?=
 =?iso-8859-1?Q?KJ1CGbT0Hs1jLRaLaDX7IHymkSvFuhbc9DzeSALnkeOL6IN+KpBDuRVw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b233ce8-16eb-4993-d122-08da69f60a63
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2022 02:17:46.7908
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XCvQvkHCWpJ+mhjXP8djGeFXc23/xpinoQ0MYO7v6w+39UgNhmoWDNoeB8tgBA8Vd4Q8nGMY7gg+Vb+KEQ0j7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6243
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-19_10,2022-07-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 phishscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207200008
X-Proofpoint-GUID: ptcJsO_4QBtVskj2IBt9BxYO1THRsa3m
X-Proofpoint-ORIG-GUID: ptcJsO_4QBtVskj2IBt9BxYO1THRsa3m
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

This simplifies the implementation and is faster than using the linked
list.

Link: https://lkml.kernel.org/r/20220504010716.661115-12-Liam.Howlett@oracl=
e.com
Link: https://lkml.kernel.org/r/20220621204632.3370049-11-Liam.Howlett@orac=
le.com
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: David Hildenbrand <david@redhat.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: David Howells <dhowells@redhat.com>
Cc: SeongJae Park <sj@kernel.org>
Cc: Will Deacon <will@kernel.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 mm/mmap.c | 24 +++++++-----------------
 1 file changed, 7 insertions(+), 17 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index ba754a3cfbd8..1a209b61896f 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -676,29 +676,19 @@ munmap_vma_range(struct mm_struct *mm, unsigned long =
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
+		nr_pages +=3D PHYS_PFN(vm_end - vm_start);
 	}
=20
 	return nr_pages;
--=20
2.35.1
