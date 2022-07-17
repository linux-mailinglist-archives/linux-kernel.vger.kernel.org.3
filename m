Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F25A577364
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 04:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232915AbiGQCwy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 22:52:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233435AbiGQCwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 22:52:24 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3648025E85
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 19:48:31 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26GMPmK7031700;
        Sun, 17 Jul 2022 02:48:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=cRHM7LAbUQF8LpUGN2Mq4N9xhcxtJ6Od5N5PFWLMigM=;
 b=KQ3vcufsFtVmFYxx4L3jdvKZ6m7DzVIBZm/gHESKFT4JK2e+UpmUTxCEmMBXx87jU2XQ
 S8rcEK687W4d6PyLbCwX/A0MuEHgH4se6bzNfE7Z01KY2E2tYxcmEPFkr8PanH7s/0Ye
 eYhDml3drN8VUFwrhvDPokB7BF5IhO7/8Cq0PR08CCBzJ7dFOIPsQbGATs2701JAy92b
 PO06/VWdrnMOHw6xmDvgihe0qpgvCgEmEVPe+rF5dXgNAxHkwd4PXqZodr5C5rgxMfNq
 KllbLCJiOtjpZQmNy+AiDgjRttKxhDaHOwLdhG6bO9TupaKE5+QDnM7ATtOkVYyojGkB zw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbkx0s0uw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 17 Jul 2022 02:48:17 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26GMY3KZ005908;
        Sun, 17 Jul 2022 02:48:15 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2169.outbound.protection.outlook.com [104.47.73.169])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1m9d8cg-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 17 Jul 2022 02:48:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hOQGw1XlryXzws9tgT8xcfnPUtl2/gbWjG2VUyvqszNSTzxot51G+ir2bKfQXX8kvI+9fl1UvV57+3eqpRFqqqSAV4sCrwzyAXjcqXB91HUAF0wcu+dA/eAC2RlNwvzCk3DQwP3EyCJmlRb1dWy3WT3QOMQfUy1HW6JjVFY5FXRMhl1WFiu4EHrOhEk7K2m3vBW/mpiYDRi0BtZt2AY8bGXE2Y/89ZDLoq4VFUClya190lNG8g0iI+nD7hLPfxa2XxMeckA8kjejBYBTCEHZGZ0KN47ogUq+ZLycjHU1VImM53M1KfhCV+3vXaE8xYz0IFbJGvjAP5GznoAFFqAd+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cRHM7LAbUQF8LpUGN2Mq4N9xhcxtJ6Od5N5PFWLMigM=;
 b=l9fLm2e3h19IMaMB0OERwVnCakSG2rOQPUh61jNfppFIYkfkgDx6tIt5Xcy5eV5oKxPHAPUaghErgW2q4WS2j/cq6E7K909YZwKRU/C5va89KGApxJcASRhizgdiFvftpShm7nsqmswVl88k67SA9kF2W0/rZ/IRAs1cBsqqsGM/vF5L98f/V4lilrWZmynQkN3ipiQdy5eDpigmkeVbBBROh+zzVwQE6neHZ847BkRh7WxWo7HhFhXJB0YQry4dcUooxj6uzAa2eMMBMPsf9TQUdjgiXkDgqoFof5noxPBH+j4TMiWMeWffd4m+RqH3nJVOaLdpxneQiTj0XA4bow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cRHM7LAbUQF8LpUGN2Mq4N9xhcxtJ6Od5N5PFWLMigM=;
 b=bbndSUr876vX7iVBJMfybCdtaP7eemuR8DwrBkfJAVMKT1iKWSIgkzhzDWGpjqfJU1S5nxKEADh8byibtdvBuldp3juWYiAZqc/kqICpWO1uaVBLqOMWhMCTKnnqzbtmntqb3hM7lTGmERvya0gahgPJGLhu02qVXgH6ZeLVyHA=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH0PR10MB4504.namprd10.prod.outlook.com (2603:10b6:510:42::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14; Sun, 17 Jul
 2022 02:48:05 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68%6]) with mapi id 15.20.5438.020; Sun, 17 Jul 2022
 02:48:05 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>, Hugh Dickins <hughd@google.com>
Subject: [PATCH v11 63/69] mm/swapfile: use vma iterator instead of vma linked
 list
Thread-Topic: [PATCH v11 63/69] mm/swapfile: use vma iterator instead of vma
 linked list
Thread-Index: AQHYmYd7XR2/Iz3e1EeJBv+/anWoRw==
Date:   Sun, 17 Jul 2022 02:46:57 +0000
Message-ID: <20220717024615.2106835-64-Liam.Howlett@oracle.com>
References: <20220717024615.2106835-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220717024615.2106835-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: eeebeaa1-1c10-433f-0dfd-08da679ec608
x-ms-traffictypediagnostic: PH0PR10MB4504:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sWQHSx3A8/nBMCkKKM2oIs2ZlWN8VU5b5AeTRAwpCeVNrgtzkJM30x/2qAZUpr9iv5wQ6UMVGbGAPjcTH4xLqvQlmjYoq+HyVCnZmOhRMX+WKTBPFTENSyliX/lNQeBON4TnLhzWTczJYOCCUvBGBNFVq5u/38Ivt5b7zsVhivGy7EeEs8m/zCABfR/ju6l0V6AWEnla5RXCa7OwcJupBQ1Xe+aH8i5D9459pr6+wGavLl+cxAibSUG+6bn/XYYAXQnqu/EkF4rESzNfTMTHRlXuiV1NYEMadvv2+3dKEvjnJJDF+QT9lT0m8reC79hUVtq23At8GShzLyw5k7DWHEzG1i6AgIgwRgxNJ4lLY7svNoh6S7yVZZ7b8UY08im6onbL9rUchQdVWM0IuKkS87EVqjy3dBxiHfHCq9m1q23EIguVqWwfxpGBYqxJHiRi43ZfL3b0KsHKO/jJRJnr2aK26v0/eON/eV8sB+fhv9UVoOIU98TrT541qkx/0vNQgcNHo6rtRDLQQNkjM3nOAomY7WxOz1jXjjo1ooooQH6Jd44QGUn3FZdO81ZqYkPgjzntF5rBrvmMo/K1o32jOmriPWNCaQvud2gSml94ck1U1MConuElRmt1CohunrYD/Et712jFmku4lf99VjVgUEMOJc0pe5ly+4oq8ksIhNS1GfzwAuLJaW2A93a+h8Eo/ArSJKbEFGWgZ8ojSsZYCXJirk1+L8IVsU61DC+vcJmZInItvadPnh6obfcaqVfg/hW3ORfhpm4YzkCpYmIcxaaTzaNQivNU+KoSwgTMYGd/DHfOhYSehQc+uVLYAwy/orQ0N+U7UPpKObF9eD7+jTBW6L9MUAKPBF/seJGbP3OmPejHDzqKIzDYWufiBF1m
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(39860400002)(366004)(346002)(396003)(136003)(966005)(6486002)(83380400001)(1076003)(41300700001)(2906002)(38070700005)(44832011)(8936002)(6666004)(478600001)(5660300002)(110136005)(86362001)(2616005)(122000001)(6506007)(36756003)(26005)(6512007)(38100700002)(186003)(8676002)(316002)(64756008)(71200400001)(66446008)(91956017)(76116006)(66476007)(66946007)(66556008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?5mbFk7PqOCHhaEknUwEJb7VoAV/pyl9UAc1/ycwS3igS9DUUqNT0cJzvff?=
 =?iso-8859-1?Q?8HQ07i3b8vJjnWQ3pKboUUp4Exq+FkvWVVLxtp+c4UzqXFUAGF63Cy/GNH?=
 =?iso-8859-1?Q?amdKf3WAg6KBkWNn71FQjfIJAAMw+V4BP5u4AzRVGBk3+vB/n7Lk5VYZBI?=
 =?iso-8859-1?Q?EyHBhKkwWogrCsgu8nGSQL1juo+ZfPqp/ujV4Yu98AJKf3ZfJRdoHFLK5G?=
 =?iso-8859-1?Q?a+zsDNDWNlf2o7A2bq93lPwdHYX/lB/5gc+OgjLWq3Vl6sJFm+h92i/ahr?=
 =?iso-8859-1?Q?2qF6X2hY7Ls1wCfXQ/HCEml9F657d0UagCF/XKX5+bhgL15zOl1lG+ajj9?=
 =?iso-8859-1?Q?GJe636YuR0IIapLZCkrNRIudoFZyq0FSCaLlSHttAr50Q8afM1T4dB01Wn?=
 =?iso-8859-1?Q?BG9zHKR1XOphXpe1ScoV3hO0p9Z32fPFqRZ/B3bQKsHP5qJ7Eu3Vgmek3p?=
 =?iso-8859-1?Q?+k2oSjLLFRMHD1Ch1QBT1mOXcpVQLAEMtEFd7ZSUxlVtz2mHIV7Zhhwika?=
 =?iso-8859-1?Q?VmLD7mDcQ1XbbWy4v8cZY0l1sMD2pqwbQELDIPhBrtdcAPxV40sAFRQOtR?=
 =?iso-8859-1?Q?gLV0wB+i4keohdeMF/Nutp+PP7iqi/2+vS1FF27wgchBS8la6qHgn80PNJ?=
 =?iso-8859-1?Q?NL0Rprl+pLXNI/CWR5jsCxtXXS7CjWLhVbXWKvvuiRR1TqgTg1T8vmK32p?=
 =?iso-8859-1?Q?6UXF7xQDvzfG2nhlD9hEwBOwa+VIuBYCZr5DiRe8z7tZ5PPa8URA/nxFO7?=
 =?iso-8859-1?Q?ZpfpSZbXDgu0XLDXMWgO52arpaUIYk0MHQ4zMxEbwJaqiNyV6VxRq+2VL1?=
 =?iso-8859-1?Q?Agr2jy70X8bk/Dh5xYeWkJuT6B9M5VJh/YM4OJEtaMSisz1z+GmJ9rgYPX?=
 =?iso-8859-1?Q?/48XFC/XliqWGo+AI55v2vz1/sM84Uk74kr/ip7nhD0SV2pIizdQesFmjI?=
 =?iso-8859-1?Q?cKWcIwNZ6NjdZ/L55zLl8biRkd1mG8R6YxtpNWHFVtawtgLHOXn5NeQj6t?=
 =?iso-8859-1?Q?zndqSB1EvYYWgWZwY6UTCH+AaWJWLgTWOZDVna3ERzoEiNK2ofbLGI0vS/?=
 =?iso-8859-1?Q?xJMz6KsT4W4SBaKsdxg1+7I8RhmEvy7CmaoH4b/aY4jYteZOspBPsL8dlt?=
 =?iso-8859-1?Q?69QhxC2f8NscGDkJrwMdVEobfo+p8TuuwUl8NeUCRJJdtsTH4Y/IDU+Chc?=
 =?iso-8859-1?Q?JBpfFiqdoiMc/TiaqlYFsz5T2WSKCILHCHXMX71JqhWR6bkaTyrmBbEbIz?=
 =?iso-8859-1?Q?vDzOi2qh5k2shYijaRTP5QgVVXcMdsw62UmMtdIyjVFt/s87sIJG7pTCHm?=
 =?iso-8859-1?Q?78xwZylI3Q8/TotKeV3prpZ46WqsHNwltyeVkDfd1iWUSqEjI7r7YfNoDE?=
 =?iso-8859-1?Q?vU8UK69uEi5gh4Rj4JcRAegDjgSjPrBZfII5zu6HG6h/ljpz7DCsCOjOYu?=
 =?iso-8859-1?Q?IWwHXYj5SFFjgQUKvVfmgZXtsghk/jT1en8vHrNDZrfwwMA40vk3eRna9P?=
 =?iso-8859-1?Q?SvTvxClTiYWiX/18fP9VkyjCTkdCraFcpDFCYsZmxuFp0gmDyspHqdIChD?=
 =?iso-8859-1?Q?ZGmeL1ENIkz5Fmd5u/0+vtZYpND7nk6mCGfnLF6ejqmyLAZC9ELmY53/9c?=
 =?iso-8859-1?Q?+aqhP3pE0kgb9Z5ry3bPtTofP7URmpfPyawCg2zdLaZvKatdFBeg/jYw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eeebeaa1-1c10-433f-0dfd-08da679ec608
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2022 02:46:57.5989
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9NNechV0QTlp/jQMmFWCFQFAhWWzNHkI56rBITL9mWJmvLECBUi44wK4G+WbU1hwhRg87OvqkRZLhFetaSp7tQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4504
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-17_01,2022-07-15_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207170011
X-Proofpoint-GUID: om519_BnirdD5e4YHUU5heZmGxTnOjyu
X-Proofpoint-ORIG-GUID: om519_BnirdD5e4YHUU5heZmGxTnOjyu
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

unuse_mm() no longer needs to reference the linked list.

Link: https://lkml.kernel.org/r/20220504011345.662299-48-Liam.Howlett@oracl=
e.com
Link: https://lkml.kernel.org/r/20220621204632.3370049-64-Liam.Howlett@orac=
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
 mm/swapfile.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index a2e66d855b19..ec4c1b276691 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1991,14 +1991,16 @@ static int unuse_mm(struct mm_struct *mm, unsigned =
int type)
 {
 	struct vm_area_struct *vma;
 	int ret =3D 0;
+	VMA_ITERATOR(vmi, mm, 0);
=20
 	mmap_read_lock(mm);
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+	for_each_vma(vmi, vma) {
 		if (vma->anon_vma) {
 			ret =3D unuse_vma(vma, type);
 			if (ret)
 				break;
 		}
+
 		cond_resched();
 	}
 	mmap_read_unlock(mm);
--=20
2.35.1
