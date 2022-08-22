Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9DEE59C24C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 17:14:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236023AbiHVPLm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 11:11:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236194AbiHVPKA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 11:10:00 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BFD53F1DD
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 08:07:29 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27MEirpp017910;
        Mon, 22 Aug 2022 15:06:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=lPfj8czy0zK5NqO2OA7BZrMagrrH6ItxZtzKCl/IexE=;
 b=Ry8vW3MyPA1oDqfbNi7gcGJQQBaNGoyWrl3n2dlbK/LG0/PesUtlTFNYrJ3/IeHsDrHc
 NehEYxV4+uqSIQAqkQukbneDQkssIWS3auwT85Zd8nTgcvOlzSdtYzmEO2jOWMtJXgRY
 VgH3q32dYKnMcg2YBvy3PglSNlZzGhzSXWOisBiMa7MD3+76iKjPE9j3zj+hTiPKNhok
 bXu7u9nGQYHBzsS6K+6WTQtyAt1vCE9yBTrGeo+yLiUFJE8b7hdp22kSHMZf0Lghmobu
 O8HNCyfXm6ty9FD6BE05Nmn0szAdP+K6boiZZg81ofdty0VP9MKtbo+LQSMSMfloxyNT TA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j4bkt04a2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Aug 2022 15:06:34 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27ME4Nal031868;
        Mon, 22 Aug 2022 15:06:34 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3j3mjd3986-10
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Aug 2022 15:06:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W5HCWuFwCorVAZswg82SOjj5ZzlPB65XIGc8Q6mdpW1SV8+EnOzBLTsp/lnVFw+w5f6j0pxLrkDuC4COoGlvsVpeWuC6D6Wj4LYFHwNQd+Ce7hdE/qmHSgZ8xfbsPhdjnyKqUmzP+/HABMkc/thunQbE3CUQadyE6/F/KM4ABOJtLwaUlZcxE6R5jziJRAVamfWUrQcQF7x4htCXp1UaKLxJX+AGl9YnPHV59RwrVtECEez2dTX3uVKb/SWVIyvccJCiv9KJqWAWmXtVjdfR4DP5FmZTH0KE2GxiLcQ9hGHKIzms4E2lSWkj+qBenjP49cet5bfdKjrWGbTGEPMN5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lPfj8czy0zK5NqO2OA7BZrMagrrH6ItxZtzKCl/IexE=;
 b=cbiUb9jv46eIcjAMBXUm+fIO0RQzQsrPbJiFCmTj0vpP3LaRYvKo4JiNbUwvfdXSCrMMSIEybiIwKXKqipvReGx71NBQ3Xf/wTN26DGdqjMnE6DIAyshZH3YSofd32N3QQ0HirNcnV05U4Y1kb84iPBSiY/ZEECRZcLgI0aDVW53U/IHYFHh2uZXBiS9mq60i8/YSdNndGjCBovDuEQIaD7uyK3h27gBGFSSWg1lieI716UjDVmomOJGI3PBqfNFyqT4YSkptHMysY4ZpaY8eQwEtA9gjUYppUvhGtdRQOUczDKlK4TJqoLBkMf0r3/BmkW83XPrjWz6Ax1j9o3Uwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lPfj8czy0zK5NqO2OA7BZrMagrrH6ItxZtzKCl/IexE=;
 b=pBAOn26BC25cHYCze4SQRTLQMHx8fZpiI/QCc8lHf+DDrsTzXdJumH9SJcR1qDevL8nPpR1nhy76uE26jlUEDA+VfFkmUFnFLixnOWwjZ8Isvuk9B/luIT9as21midu5Trk0RNZZR0KLX3uY2cR3pUqeax60cvwQv0xwzvNoeXI=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM5PR10MB1433.namprd10.prod.outlook.com (2603:10b6:3:e::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5546.21; Mon, 22 Aug 2022 15:06:31 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3d34:ebb5:d9df:98b3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3d34:ebb5:d9df:98b3%5]) with mapi id 15.20.5546.023; Mon, 22 Aug 2022
 15:06:31 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH v13 52/70] mm/khugepaged: stop using vma linked list
Thread-Topic: [PATCH v13 52/70] mm/khugepaged: stop using vma linked list
Thread-Index: AQHYtjjBVdRgPpv0Gk+hCiycdumzJg==
Date:   Mon, 22 Aug 2022 15:06:28 +0000
Message-ID: <20220822150128.1562046-53-Liam.Howlett@oracle.com>
References: <20220822150128.1562046-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220822150128.1562046-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bbc497a1-c7a5-4888-00f8-08da844fe5c9
x-ms-traffictypediagnostic: DM5PR10MB1433:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uq6wDMqmFcW+IITSLEWieBmxeJBZq02vRY6C0Iy69+w8Jt0JqXC5LsKHs01p7MWj4gueRtJb8Wg+VABQWZflLIvAoL+6KJL+ylAJaTeyZ8MbKb4P8ntLm8tQNP+dMcQb07+LD2FEdGoEgHuTqGIlc6k/uorTAS64vtDYr6dameNopMSyvFDKUY7DJIwJQ+Z4VNDX9UuLyydF/PNUF5pkLJLsyVvqIkPhkJrJX6d72P1790rETt6W5UKlUbutKU3KN6RjUjCqEyQ8cL/Z1djVrg4Ro3VEoPQEYqB8wBxTovZytYYwlyFljSojYx2z8X1XAIwKdI2C2F1Hw7A7suwmFhoTvU3mWD+FzPgIzBb8t0vk7Qh6o9ibdGVIHWUEfU6nzYTpmVAFSDWIAZ07CYy13W7g3H+4X+15jfMQzsAisUX9eMZmFGFqAmtNANppvBJWgCyqIsARIaztkgc4IN+FervjKAC3f4rW0BmSJKMQMgtJ/ENbWBUfEFbZAUE6MHwVtEkIqxyWvRK5GN3W9igvQKp/mZ1g9nTLwDdNuyfb3WzQiJsVJtZ8nP9f+yQ5sHiErcVeU9j5UFHzA4KNOlHh+fZZ80kFal3UC5fc55YoBgQgu8FRPVmDe6E82KN/cLr7Q/hGKhTq3I9sUR9s+HqDiMMe0BUx8mB8ppdvcnmOfA1ls64NtBi9yjIV54yygsIcM7D7JWyv0keRJKQ9S4vauLiKVtXNYhKhN/KSN/2LDxgAOy+VrBUiwuzDSqfXZ4SKqEM+bS8EC/QQwJIcWxYGRg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(376002)(396003)(136003)(39860400002)(366004)(5660300002)(8936002)(38100700002)(122000001)(36756003)(41300700001)(44832011)(6486002)(6666004)(316002)(71200400001)(76116006)(91956017)(110136005)(8676002)(4326008)(64756008)(66446008)(66476007)(66556008)(66946007)(54906003)(478600001)(186003)(1076003)(107886003)(6512007)(26005)(83380400001)(2616005)(6506007)(2906002)(38070700005)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?9O6Zs9ZM4w7WOlXAy1IynPNXe1s2RibKzOV40n9BNOGOovsAHYM6Mj6TJ3?=
 =?iso-8859-1?Q?7DUBRmBjs3BcfioChPRCK0ck7OnD0bhzx4rQy7EdoM+buuYRSPV9Uj2UW3?=
 =?iso-8859-1?Q?IfkgGBp8mWUhbs0dY+2yLUKJTSodEAZjTkvBHr1BIx28LKbNEQ76KJZhJk?=
 =?iso-8859-1?Q?abGnXCMe0fN44DHzSe0gEGOHWXVdbo/o9CZ+9DWfSY3P7xB5v0RsM+OVlA?=
 =?iso-8859-1?Q?Kf7Dj9aWCfpF8QRztTyWx1x4QjWWiaJRZ0I/fHHNnWEya6PoR4FQnE7TTA?=
 =?iso-8859-1?Q?1aNzOBoKrGfc14xQ9p1/1KsT6RA75IUwGnor01bu4gChtYQ2gkKC1YpjX5?=
 =?iso-8859-1?Q?An4livWpIZTZtiGGJ2Qx/lrP/XxAVVlDKWrECD6XIbBbwfifsfM0+Iosse?=
 =?iso-8859-1?Q?Pxdg7UGO2nTry/tIEx/2DhI92smaMAFDGMVD7XS7vPBOq/iL1ptndr492v?=
 =?iso-8859-1?Q?qy1p4jUJoi7VrmrWJUYIP3+3jepGhiffTovGYS0AtHkvVZoiwphH1BQwzJ?=
 =?iso-8859-1?Q?sZ/kg/dSPY/XdGXsYAs9AtpiKitDzfl7rZYccmB/TbdSi8kHMQPQxZvtIz?=
 =?iso-8859-1?Q?5GZI13EXnrjqHkCRTRbOJqoiZdfP48TNMFS+KD+VovJ9Fl0pZZd9VL1hbX?=
 =?iso-8859-1?Q?E8v/cy/p8VbGQ15M2Cx+HSMbKvEnXJ+GpHmjJDMEqrt6PXekFdncKF5zai?=
 =?iso-8859-1?Q?I18GY75k7Mmu1UTNeWFiWpCvmbfeYhIcdZmudqc7uGA/ghc4eYZ0oNnodR?=
 =?iso-8859-1?Q?CIjyPz48rovffokVoa88gM/dkpDDtsBlOerdaiUw4pjpgBFblc/YG9C0U2?=
 =?iso-8859-1?Q?qe06NeIrib2tjdTZ+xHvRDEZ6Ql7M0UmyJAlLDpujfwOvdJ5J5HE7X8miD?=
 =?iso-8859-1?Q?JQEQmH2Ahb6BmBN7bxeo36IKqG/W0UXjeLwxTY9ArlZMQU3MzlkT36atW7?=
 =?iso-8859-1?Q?oW+E01j+sy0P0Gz3d7kj6M/Zx/g6+NBlLdU1rZq3pcnAiVODEMqneZS8+R?=
 =?iso-8859-1?Q?wRQdIOzn1pRZYE/ZnwEZkpb2mCU5pLNQaig7iFu42OvMSwtOJwnT8bCFkw?=
 =?iso-8859-1?Q?Gmuy2wntPdUelPIZ+DzHfRF3HF90yotssA9WEU5/pLKAYrdGFdDrFX46SR?=
 =?iso-8859-1?Q?+k1q+yGoJdiqLeZbPf/kkmpm+S+pUc7UO40Gom5C2QHbb6Dkk/cnocprZw?=
 =?iso-8859-1?Q?bgcOgrPeTHgkCBaNAXVevA5WszODKi7n30nLJaddCj3KK4eDz7RcSskgaX?=
 =?iso-8859-1?Q?7A4+9oRO6aUUDS/sCa+mDTXCiE9/VBNNeCMPkbX0cn7qRECR3yjrggM7Kt?=
 =?iso-8859-1?Q?V8Ok34HE/HDJh4FYFIZLSrZj73xQhwCkr4oPRbzBK6HhN5C6uRKJkAg5Xk?=
 =?iso-8859-1?Q?8KjbwpFlfrxq1j85xMtvzM88oQPnbNDoQagTUQhbd0TjcGIlmF8gEVQiq5?=
 =?iso-8859-1?Q?7iyz8NEmh9rATM0MkcNvYp2AQxVfZ1PpRGNeK3saekzkVdsaHQk9v98HlI?=
 =?iso-8859-1?Q?alVi/hnKra+sZQzG4NY/4yrvvNqFV1P4UdbYMDhQ3qI4t0NQJt2EPW5gOU?=
 =?iso-8859-1?Q?9WJF+0S/XlcyGleUwJ9YzV6968C4DWUNkIAa/EL9FEYqQ38gkzMB01GDtd?=
 =?iso-8859-1?Q?G+nHfhBz6t9kyi1GkFEVs+Bn1DvsijFOHAW8+64WsTjWCYWPlDvhPM+Q?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbc497a1-c7a5-4888-00f8-08da844fe5c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2022 15:06:28.7380
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kC9iTM7cHR+YziiNgl/GHLWBcXhczEJvWZL6gqvux+zgVGYPQXLNDy8r++/gvPSaRzSinmjasjGLB6e9cdKFPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1433
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-22_09,2022-08-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 adultscore=0
 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208220065
X-Proofpoint-ORIG-GUID: QxUGEPAW03HrnsHKXlm79L1IdqqcnQ1B
X-Proofpoint-GUID: QxUGEPAW03HrnsHKXlm79L1IdqqcnQ1B
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

Use vma iterator & find_vma() instead of vma linked list.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/huge_memory.c |  4 ++--
 mm/khugepaged.c  | 11 ++++++++---
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 83c47a989260..6c5c23ef658a 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2339,11 +2339,11 @@ void vma_adjust_trans_huge(struct vm_area_struct *v=
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
index d3313b7a8fe5..d8e388106322 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -2053,10 +2053,12 @@ static unsigned int khugepaged_scan_mm_slot(unsigne=
d int pages, int *result,
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
@@ -2081,11 +2083,14 @@ static unsigned int khugepaged_scan_mm_slot(unsigne=
d int pages, int *result,
 	vma =3D NULL;
 	if (unlikely(!mmap_read_trylock(mm)))
 		goto breakouterloop_mmap_lock;
-	if (likely(!hpage_collapse_test_exit(mm)))
-		vma =3D find_vma(mm, khugepaged_scan.address);
=20
 	progress++;
-	for (; vma; vma =3D vma->vm_next) {
+	if (unlikely(hpage_collapse_test_exit(mm)))
+		goto breakouterloop;
+
+	address =3D khugepaged_scan.address;
+	vma_iter_init(&vmi, mm, address);
+	for_each_vma(vmi, vma) {
 		unsigned long hstart, hend;
=20
 		cond_resched();
--=20
2.35.1
