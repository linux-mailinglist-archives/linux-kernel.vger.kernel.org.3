Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EEF9536911
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 00:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355098AbiE0W7e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 18:59:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346349AbiE0W72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 18:59:28 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ECBA13327D
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 15:59:27 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24RKYxNt001972;
        Fri, 27 May 2022 22:59:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=WklxNc8i9CPt8PvCnvXar2TGFKBokVagIFoHNTNhGKo=;
 b=vWfGeNexUz/QaM91XNIvfPAXg+NfTqmd+5BlCpKINKH30S89xXAfOmgXrEfoL0NQQLtA
 3FYII0jqGETdlNCoIKvt87Wz9dm4WWI+tlTM0ch2BKQAe6TwtpNisJ5KOBAHBZzBiQbM
 7JAS0N49NDsoQC1+Xm0RGjaizEuWdeKCs5Mjp51EyC8hlfDngMN+SurVX+kGk+TcsO88
 nRojxZaK13BFmycAdVYzFYLitsO7fobnzFawg5bLJh4FPc3z5+IJ0ZJ8wHUTTp0a+25a
 DcBJQa041kGD9wHnwUQMtibO2NaXjTXO5Qacj5vYO2AyYRvxQkX7HVPIcWlWC0h5aJmQ Bg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g93ta0ane-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 May 2022 22:59:10 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24RMoF9m005421;
        Fri, 27 May 2022 22:59:09 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3g93wxq4m8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 May 2022 22:59:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZgxzuAPXsLaz+swesbL4pGqZDfivS8TCOh/LZBGePAHqXZvTBbqv+9jw8NFmvsZK5ojvQDo/6CoUTIV9hpmtjn9ncX6dMpiUSAe/lVHqpw6r4LNBE8nV0jNsZz4UrTgijPA8Hm5QTtYH8zgpFnjyGQraQ3tFnF2dqgYFG6LUhDGrcB1Apcv2yciwNtr3yBzgXqS5I0RCQKpDdDKDuah0xFAxo/IMSIX5r1TZx/u7Qx2B6gGwQT4W7RDmsE1KsW6sjWGmsiMUUqTIWaPUPMb8Zwh3lNkY2Bf5S2rr3nNZBIcuzk0TIfFTtklnfK172+cW3AuqHNLOICFQUVx5IBe8Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WklxNc8i9CPt8PvCnvXar2TGFKBokVagIFoHNTNhGKo=;
 b=AnAkDNz/vZsFiGprJuQdYtuaNijkaMQEymHzzVG5V6zHSyLV7aYiYobZ5FVN+sUWDvu07YYRvGVidZSwkduWAhM5VgHksBSJ9a9YjTxbJdWlGiChM+jSn51VJvjJSWbLExIzFZ/UnTHY/f2rHCVrFtU4xi1HA+10ulOtuu5mRx9VNw8BJSV0HOj1cXvpjKVDaTvcWovY6DiiEM4tCDYfMK+opheuXH0Qgm424fpvVze2fgezecYWBh3DRjhY5jMGrqXqKsI7cgM0PVCHd9M0tuVQo/Ajgh7SHY3fLLt4FMOaMV0hrr9BsaJM1A/j9IUqdAl4rPBLDaKYkibX19H5Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WklxNc8i9CPt8PvCnvXar2TGFKBokVagIFoHNTNhGKo=;
 b=M7yb6RZC0JrFz7YRGsX4HN85sAma4q91tEtlvwGlHWhsDFjmPuqp7SNQVhzk32IOtSjNAVws3cFAyyV+xdEawP7vis/e/vhcV+mAYFDdpFG1O3Hbx5NgrXprqHEfmv0JYhtCJHGrXSUfM7IwKd5WlVN9jKD+Mx28dO66l3U0W4s=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by MWHPR10MB1472.namprd10.prod.outlook.com (2603:10b6:300:22::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Fri, 27 May
 2022 22:59:06 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::2125:9bb7:bfeb:81f9]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::2125:9bb7:bfeb:81f9%9]) with mapi id 15.20.5293.016; Fri, 27 May 2022
 22:59:06 +0000
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Michal Hocko <mhocko@suse.com>, Peter Xu <peterx@redhat.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        James Houghton <jthoughton@google.com>,
        Mina Almasry <almasrymina@google.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [RFC PATCH 3/3] hugetlb: Lazy page table copies in fork()
Date:   Fri, 27 May 2022 15:58:49 -0700
Message-Id: <20220527225849.284839-4-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220527225849.284839-1-mike.kravetz@oracle.com>
References: <20220527225849.284839-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MWHPR17CA0091.namprd17.prod.outlook.com
 (2603:10b6:300:c2::29) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 38b1ad82-696d-4096-e333-08da40348050
X-MS-TrafficTypeDiagnostic: MWHPR10MB1472:EE_
X-Microsoft-Antispam-PRVS: <MWHPR10MB1472A15E6564FD4539E17756E2D89@MWHPR10MB1472.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZJSVGhB49zG4p2niBOSFXZEvmFyDpAhVIvrgPt0iNS798Qg27wYo1eDbyukAWEPbU0J3l95Naw/kRBT5rwWhTF5VwIsuvbvyNMAA6QwQt3bP41I2uHCkSqy0hMPCIgQkCZK2GtCQ1SgQzISJ1iEohK2tfT/5CCKKaEYHIDaQvmM3yUOSrprfMwLxMqp4yiP0Tm12JOuRzgJ9aszow16w6vASD17yhOehcPWN0Tla6G0THmNKhntTm31kEjGJxvNVwD1Ec/vaV/H71ild90JtxDAelrOjeXpKX/2dsbS+8lPrkkVa9ESBdj90SidF0lJG+ITlvCiGBlsxyoZZfts1sAKJ9v/4189C8rsv5c4p7Fn01aLve2QstvXx7lg2KuedGsFRBZwNWdvT5tLMzU8tO+Y92FuJ9rtsMlNaJ+LI8+Kcxh8jlBA/5wpUJmEBkqvN4PEq9B5OWjImVP5RlmQ+RRVe6MWuZ8MiHLofyQ6a+KPK/b663gterapU1yZyF8aN2o6vMEfICHKYCy3Grd0ga1DahS/JhxBAKTRZ+ByLFTwOnyic5NtjOWravF3APrmEqq6di5A0JPCLSqDgo/0y+/3n8stYfrGHrbjc9XNuOjrc+lBn2lIVHVtyYxWMPcS7BZcK4857MTe0QqbfQ1H6J+YW6XK9ceky0ZN17fWi6AXUARq6ppGKyg1sQfWGZhHutYYtdKjPRvIzJ0ogDUFTkw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(508600001)(6486002)(38100700002)(38350700002)(66476007)(8676002)(4326008)(86362001)(66946007)(66556008)(6666004)(8936002)(2616005)(54906003)(44832011)(186003)(6506007)(5660300002)(316002)(107886003)(1076003)(83380400001)(26005)(36756003)(52116002)(7416002)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pWoDRWnGQaHX7j/LNAxxTQVP/tgUkoSMlVwVsGtZvk2Uc+4V/kwERBfuwvyB?=
 =?us-ascii?Q?eLB9WAV9SbtZcC/WhW0X+2TDJWfE8Md0H35t+RV7ThbbJLTQ946HVb2u9QhV?=
 =?us-ascii?Q?euLnG46HcCb/o9WGsXRGV7xcfv+R82IyxUZz9T4polLWVEhJVKGyrSY9DSV0?=
 =?us-ascii?Q?BYltASTcAvKtZNRPXlGxJzZHFmkkoclyz0NPMUMd1kjZ65nqujTuE8XLKi67?=
 =?us-ascii?Q?76ptDRWLikW0srHyk2KXUxWaBWt45L8r9Uq1YlK2kh5p4DwTVB2UhOjwpypD?=
 =?us-ascii?Q?7siFSywGcWP6GBLFNlqjB05FWbfHcTSb68Tv//hts3RBPK6oPh8zwXqS2F9F?=
 =?us-ascii?Q?SPnaUuaycHM/ldcasCblfCVnZe9beKu6sfV+D4J9KRAYPoQwudOVqiv2DpEQ?=
 =?us-ascii?Q?4wZqqE7dDFYipxVHqR0Unf/VASoCMFbOef6Uk5HpGR9CcAJ2oitJ8tsYoo7g?=
 =?us-ascii?Q?r2SIPzyLdd+tD8e00qKg8YDduSXhsMVg5TiOp9nQpeUC3Vc3+FtCBM8J4NZX?=
 =?us-ascii?Q?7iVt56uQEeuUz4G02e1y1GWPB2/sVZZ0gqp2zUy73Kk9vim9zrnsaA4JHSAN?=
 =?us-ascii?Q?CnLC2TxgT8ED7ahFooGo5yE78s83yKTeZsjTGs9xKT7JE9Dnf5SHZCddRgYC?=
 =?us-ascii?Q?zqQMyA76CAyngaAFweZvqTFsaLZII5GApU2RwePRAx0lNm6H3h6ThRyA1XBM?=
 =?us-ascii?Q?X3j7lxRzg2XJ6jDMPQUigL1njjW4e+hzsPA8NfVmLJR+HHu2qtt7xze5WfNg?=
 =?us-ascii?Q?w3pCQ/gtSmHmbv85EltNDZhnFK1m8byXZu+RhBLpOyRmjee3Ht1sK/IUzu7Q?=
 =?us-ascii?Q?KhZNpjv4Uku08L0/V9BZmWl4TqkKevjy1ELGq2dyq+P6Rze2We5eqzRDjQcc?=
 =?us-ascii?Q?E1tJEBJJIabmTZd8b0GZw5fphgA9ISCDYWHpq9B0WGCyqwJjwmTx2WgiLKtO?=
 =?us-ascii?Q?lFQIDa58dPZBFRsTL083E9VY8ID5rIDI7EnBYYxUsGUMCz75XTb/K+q2hUQm?=
 =?us-ascii?Q?c1/Kdp2pa5FreYvNy0sP37Ovp2l9Wsx7YBkXPmgktsvzZkZkCGJMOpY/xko1?=
 =?us-ascii?Q?EqXbqdjfNpZ8kJnzyhtHykP8sdYWRasXN4Vl0+AsvHOG4cRHG9fYDI17Pxa8?=
 =?us-ascii?Q?c/PeRSzRT1Xk4D2TIGWGc1NYsfsDtAG4Z5An2xD7T07f3Odyh43DXKyBcF4X?=
 =?us-ascii?Q?9sn/guwMCKqH7z9J/edD19X7pDXrzbjvU5WKD7sev+7RYhY2fdskXTOQyXbA?=
 =?us-ascii?Q?MnuB0GFmygWymxoFEvVHqm14NtD8b57rLA8lgyXEMCbBoNn1lYNpLm9r85zD?=
 =?us-ascii?Q?8BUo5TVt41xBJljwPcn3lAZd5kocWrZK7byi/isqojgo0NmwX6ehdSAKYTrW?=
 =?us-ascii?Q?PjaMe7+7mRB8b5W34ZHsNHL4RofiBZWnefc4pYAwEaqEdFBGCi89M0Pr9vGx?=
 =?us-ascii?Q?Gxgh7kqDcg20du3kWljwBB09Au9N4Yz/G4s27sPGGoSr8FevHxmQbMbpllJf?=
 =?us-ascii?Q?5wb8+0+KqU5aMlzP5JAykeVab7l5REP1Xr6FkRdMY2f7co6qJGlbb3yWWjc/?=
 =?us-ascii?Q?aasbNiZ7zFEjdQMDQMzLOk9mpIID2fWuMPDqh1iS9Xv6n/PORfJ4CAHl6oEa?=
 =?us-ascii?Q?rsNn8a8r0cVtDIRCYY7acA966iYPAq+7wx9xt+Jg1J5dy1lPfHXCDat4Jk16?=
 =?us-ascii?Q?88SGrBuhbDOcG9BFQD3p53da55QlQcDjq/+cOcfDXUWTd60dgbEV1suQyFeG?=
 =?us-ascii?Q?aRJd1SA32nS2tbtOQqronDJfbL1hAZc=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38b1ad82-696d-4096-e333-08da40348050
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2022 22:59:06.3482
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q3QPVXQo9Srv3oFBg3RAMwoIYp7oPwTS5rOcqmG95OrbI7J93O2NcfQMEBAA+p/1OxbEwpJdon9/WZogvLcnXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1472
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.874
 definitions=2022-05-27_07:2022-05-27,2022-05-27 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=984 malwarescore=0
 adultscore=0 bulkscore=0 suspectscore=0 phishscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2205270111
X-Proofpoint-ORIG-GUID: TFrEPee4ZyygY5vXV5rQUurJbLpg7WSk
X-Proofpoint-GUID: TFrEPee4ZyygY5vXV5rQUurJbLpg7WSk
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lazy page table copying at fork time was introduced with commit
d992895ba2b2 ("Lazy page table copies in fork()").  At the time,
hugetlb was very new and did not support page faulting.  As a result,
it was excluded.  When full page fault support was added for hugetlb,
the exclusion was not removed.

Simply remove the check that prevents lazy copying of hugetlb page
tables at fork.  Of course, like other mappings this only applies to
shared mappings.

Lazy page table copying at fork will be less advantageous for hugetlb
mappings because:
- There are fewer page table entries with hugetlb
- hugetlb pmds can be shared instead of copied

In any case, completely eliminating the copy at fork time shold speed
things up.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 mm/memory.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memory.c b/mm/memory.c
index 21dadf03f089..f390cc11886d 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1245,7 +1245,7 @@ vma_needs_copy(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma)
 	if (userfaultfd_wp(dst_vma))
 		return true;
 
-	if (src_vma->vm_flags & (VM_HUGETLB | VM_PFNMAP | VM_MIXEDMAP))
+	if (src_vma->vm_flags & (VM_PFNMAP | VM_MIXEDMAP))
 		return true;
 
 	if (src_vma->anon_vma)
-- 
2.35.3

