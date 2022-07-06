Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27AB1569342
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 22:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234283AbiGFUYl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 16:24:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233833AbiGFUY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 16:24:26 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C38A183BA
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 13:24:26 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 266IXbpn009655;
        Wed, 6 Jul 2022 20:24:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=XjmblYtiNvjlDsjHALrZ+jjlDpAI9GhABzU9BOLgMpQ=;
 b=HtHlW7cyfgeCEQfzF1ZPA8KOh9mYKK7zrVsJtCLmzmwYgioLJ0Gq8ZEbulHpcKeI3LGI
 5fKUukFHJfDPy1iFnCMfpwvprJoM0YfHV/ZotBhrln0D/bIznrVtdPOQHgYUvnOlzZDH
 pEHX+4g+kwL+WObvmqbH6jvf7EdfEu4l+RNsDxn4KYg+CzicF/FYF8YlwdPcEB9IBmbP
 +sj8SLP7/HOGZr81evJIRYlTmp4mhxuWC9H5R+nsXZWiL0vkWzPhUPaIJC1Hkb5YwG1e
 CZdyzMLHCBR71a0xNEYQr+UpABv0RZhDaKobwEwYpEb6GsUp/08RbqWQJ/SIEc8JQI6m WA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h4ubyb9x6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Jul 2022 20:24:09 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 266KLKn1035231;
        Wed, 6 Jul 2022 20:24:08 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3h4ud6cu5w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Jul 2022 20:24:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SwZk/nk9trQj6q/uBTqaSfx31SVuUuxIq6Kd71AQv578+tJtFaiyb9AqpfmYPh00uFaBB0Fvnu8jhB3mtSSGs4S6HUHTgONokjfiH5+ks6jEnaV97G/zV37p1hZwJBslZPghO6pciC/XUvAI8lEJNUAEu3M3gtNjYal2J5aWBJ3dn9FKHilplk4fthSgOnJjhHdNsCxsKwogzOyknTKtNIcWForR/8wf0p4yMzfBz0T0bMtj/gpveWXI39kCQ/3W4JehPzQdkNE6+FahE0u8TRdFRYJjNSj5v0PbzDdCQ+UHI2ktoGG4yPoOkPStC0hOlGeB4DC9qaN2BZJeq+4osA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XjmblYtiNvjlDsjHALrZ+jjlDpAI9GhABzU9BOLgMpQ=;
 b=MfHMnxSfUfLNdK3927xFeL4qFbwG4qaxOPxyj6c2IQfm9ehsgkayG+4aGW08sfRwJBxUD2K3RSDS3s2rW3XaW9Vx1743f3czq7ELomW+6niLDyFT5UBhNSBmLJzPDvoCpyUzqJMFw/VjrGhWHN6vAl13kfluI19sDFypsiDmv0n+OeYyAYPFJ0A4EOs2AIojDfQ+jN14Ie5W30ohPH7ymoPrlA3wt6CuwFf4CJp984jK7wqihCLWNCi4jZpfXUWOl34vYu59H0g1+p2n1utIz89b8Y51D0j2/18kyc01FoxbKgPiGR5bZs4U9ruy2darsz2quomaBrnEz+GKFBhGfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XjmblYtiNvjlDsjHALrZ+jjlDpAI9GhABzU9BOLgMpQ=;
 b=TCTua6lfBECNfZLwAxRpLCbnf7QSoVtKDycEXyFL0RB4EcZcBqdaY4LPTkCP/oOkihad+xJDD0ow2h7OAiwbm5AzJWWa8eFTuZd6Avq35DAzJzfWnciCjhY6koPZAoldwHRPMY7a1dtdUA9fxFqroSPuXlbGLTdyabESvumnxwU=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by MN2PR10MB4032.namprd10.prod.outlook.com (2603:10b6:208:181::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.15; Wed, 6 Jul
 2022 20:24:05 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c1ba:c197:f81f:ec0]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c1ba:c197:f81f:ec0%6]) with mapi id 15.20.5417.016; Wed, 6 Jul 2022
 20:24:05 +0000
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Michal Hocko <mhocko@suse.com>, Peter Xu <peterx@redhat.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        David Hildenbrand <david@redhat.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Prakash Sangappa <prakash.sangappa@oracle.com>,
        James Houghton <jthoughton@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Ray Fucillo <Ray.Fucillo@intersystems.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [RFC PATCH v4 5/8] hugetlb: rename vma_shareable() and refactor code
Date:   Wed,  6 Jul 2022 13:23:44 -0700
Message-Id: <20220706202347.95150-6-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220706202347.95150-1-mike.kravetz@oracle.com>
References: <20220706202347.95150-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW3PR05CA0006.namprd05.prod.outlook.com
 (2603:10b6:303:2b::11) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e4515aef-f2fe-42c9-e86a-08da5f8d7911
X-MS-TrafficTypeDiagnostic: MN2PR10MB4032:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DbOLOSC6OH6Wk+9LGTJVyaCPe+uL2Zgj76/wULF84SGPhRKkse9T/lE8ZN0AohRPaNLvrlo5cED9TBzKzlLKcdgobXdLKl2w4xnQWau5eUgz2QfEptOa/VM+t33QiefTqy7JrXXu3hQA6Wol9GGUyaH5ld1cwK9jkC4DPbbtIVST+HeA2Nbx9EUVAlptlTD0nbPrw9mP+EhnfUvzEF7+vK0UM3SHzl0KdynNSyR9Zi7DGMCz8VLQvAaBVAyosn8wGlgGkDyvt8gcSSqGfSCMJVQ3xZz+EewRy73QZBLjX0UpeffojNJqQpbPW/3HeIDBNkmZFwNyh0lOiwNKzIsAN5aUddPZFV2y8JmkwTgdZ6PUVk6AJpkVF9f7sQQw3vwvr0IXefGU2TLk0vewy+ybst3+ZzAY+aYzQbTZ2R0Y6TUBfHLDL4fP9/YU8NHITHJtCRH25sdKd6PdtBLyzJTy/btrYaQjY/GZjUM9vQrUNrM5VxYyRjow0gsNXXHJppj+PywJQP+FzCkO1sWrUPynSRhqW0bVHu+421eoqsumyYR9kSl4wVDBMnhX9bLNWpniDY2/z2O4VZoMt3nVXJaDj2H14+uXcBRpm1TOdwQkjnOCAlFv1aGUfsOSfsAaeoqKSeXGwMQ/oj/5mAP3tNqSyTKG0F9CNhiyBWPT+SoSLYFYrmoQ0IaamfUhpxlDY6wS5rOZiDZtV6+ybZ6FiG5w6+RdIEKqBBDGhqk3fFmYe2qeBULMy+64645N8R1WVBNI
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(366004)(136003)(396003)(346002)(376002)(44832011)(8936002)(54906003)(5660300002)(7416002)(316002)(478600001)(6486002)(36756003)(66556008)(66476007)(8676002)(6506007)(41300700001)(6512007)(6666004)(4326008)(66946007)(2906002)(26005)(2616005)(107886003)(186003)(1076003)(83380400001)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?J0hL9i8FM5dw1vm4+38q7B0G7r3WHnSWJIMaE2B9rWXmztBcRcEMn/R3vEOS?=
 =?us-ascii?Q?afQ5EtR9qUPsd+AJ9MQURAiTLAZjsRouiHMB+bHprKVD7DD4D7Te789mPanB?=
 =?us-ascii?Q?16/SyC+cgs8zyYBwn8vyAXp1AaZrvmRxeuZ5evIVZmCL4n0t45Vz26MjR1FG?=
 =?us-ascii?Q?YA/ZxS4SAgi12wUtcp0mgzKR0GTvsqN25+Geyzhep40E3S5MJ2rGlN+/0jrb?=
 =?us-ascii?Q?LHwTtf8fD8VIEnJ95yem9Hhx0p4VZL5QPr15wnrcTRAdlaDokilgLSA+IJkT?=
 =?us-ascii?Q?OwgUOSkyRnaYymNHi3A9k6U6+kvAcEJ+YlcZzHXUcmu+oxfuIvBFP92O6Vma?=
 =?us-ascii?Q?v8KDL2fPKxegk+IJsqZFvBEQfuXnoD1zqgr+VDbe9qLX6qv1mLmmatfrc8X/?=
 =?us-ascii?Q?Hg1Ov3N2pNcg1FUgsJ1t0j2vsUmjBr7R0MXLGb7uou/cazZVz0h+nB3hMAET?=
 =?us-ascii?Q?h+NvNjL/+FanNEkP7+yThQ55hHY2PP6ua0xlgIQUXtwipTMfYVdwJbk0Nkgb?=
 =?us-ascii?Q?TDndnSm79TSKe0m5T+ikWA9KXgg5clf2Xl9S/RYi9Hro1rpwaoX+31bCaLgi?=
 =?us-ascii?Q?49XPvLlQBt2WOMqekog75ElrFqbHz+AOT3FommA/tXtb0f24t01JJ2uSXXdV?=
 =?us-ascii?Q?ejSHqM8hnL1HHaOggoLR84DpL1IoHFF9UL3kfGTQBZ0BemRUBWiXlXbf7HFY?=
 =?us-ascii?Q?8RdJ41YIy3/9yzzI6GESusSrfdXu2lp+b8zVvmEw7xj/AXuEkv9leBG1AbKc?=
 =?us-ascii?Q?HEfdLY1W9kaMn5ADWUi1MKPe/fHEEVx9U08JpV8HScQmVuI1EWDgPJbNgdGZ?=
 =?us-ascii?Q?pFki/JxpGgc+sqctALgnzZDB2hLG7G0NsozBj5NdPodppKmW2HWNGxnEg0Nt?=
 =?us-ascii?Q?TuZBktngQvixKg2QhpgvGt4n4u1ApPI/xODDpaEkZZz240uj2103ua8Wa9mH?=
 =?us-ascii?Q?nDwcB6A9WErOSDkG4BiA/y5iLirboIM9vxuuOxVHF7v6R+6AwCILuodvy2ar?=
 =?us-ascii?Q?YpmjUKUeW/1ly05Is4Aw0tJ9Psa/ut8aPjyy+uOmNE9ocJJ1+qjqg7/Rb9nM?=
 =?us-ascii?Q?wl6oCYWywV0bDJ0ShVmlX/pXh93+rPC4iU/pl7Uc6kHDbyukV7nfHobrS9+B?=
 =?us-ascii?Q?BaFEfqsyQ2qilEF+eSp+9PhbcEPD9nFksJr4SlS2qZWvPHrUvnlIkEYpaYjK?=
 =?us-ascii?Q?SGDdon5Clnu3bUmejM43x0IYtr2Lr9fb8Egf1qSjMxySChzyPCcmiSMFf7n6?=
 =?us-ascii?Q?3AHpJTrw4dQn5qxZHoRTKcBRX93xAOomsTG5XpYXUmnHoHtm1TBR1jpCVFJ/?=
 =?us-ascii?Q?sIPjj5VKgB/IslCAx+XawS/ijbmYWc5PYn86Yc7xcUHCmlJ5qI7FwJGOv07l?=
 =?us-ascii?Q?m7McWe8XSwilE2VsPREbgX4TXNyXxWvKtfT8riePAokUDisVlHR8yLLRfMnk?=
 =?us-ascii?Q?vyJveA412KSsWEPb28XZ08RfphGipgs0t7CsaBPc7ghp9ZjqTRzBWFmAjYSM?=
 =?us-ascii?Q?VTLUw7Y80kTjXyusx5is0kzGlQBaHUYizcT/0FrQMJzrweUZufTXJd3RqnaW?=
 =?us-ascii?Q?dmurH1fYVBUogvurft0AgogfuebRBhb1UJ69RtvcNVXgJLJwTTWKgGxc2HBE?=
 =?us-ascii?Q?zg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4515aef-f2fe-42c9-e86a-08da5f8d7911
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2022 20:24:05.4309
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jl/W//LXPsegmOVd0AEewaXrNY8pMPyx04/P7XglEentO0Lb4ucCpef/52vpgKM+mDU4KefHMTKud6zz3QgTrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4032
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-06_12:2022-06-28,2022-07-06 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 phishscore=0
 adultscore=0 malwarescore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207060078
X-Proofpoint-ORIG-GUID: SPUdiZNZXjU_T3bplexlJVegEH02KK8H
X-Proofpoint-GUID: SPUdiZNZXjU_T3bplexlJVegEH02KK8H
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the routine vma_shareable to vma_addr_pmd_shareable as it is
checking a specific address within the vma.  Refactor code to check if
an aligned range is shareable as this will be needed in a subsequent
patch.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 mm/hugetlb.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 25f644a3a981..3d5f3c103927 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6639,26 +6639,33 @@ static unsigned long page_table_shareable(struct vm_area_struct *svma,
 	return saddr;
 }
 
-static bool vma_shareable(struct vm_area_struct *vma, unsigned long addr)
+static bool __vma_aligned_range_pmd_shareable(struct vm_area_struct *vma,
+				unsigned long start, unsigned long end)
 {
-	unsigned long base = addr & PUD_MASK;
-	unsigned long end = base + PUD_SIZE;
-
 	/*
 	 * check on proper vm_flags and page table alignment
 	 */
-	if (vma->vm_flags & VM_MAYSHARE && range_in_vma(vma, base, end))
+	if (vma->vm_flags & VM_MAYSHARE && range_in_vma(vma, start, end))
 		return true;
 	return false;
 }
 
+static bool vma_addr_pmd_shareable(struct vm_area_struct *vma,
+						unsigned long addr)
+{
+	unsigned long start = addr & PUD_MASK;
+	unsigned long end = start + PUD_SIZE;
+
+	return __vma_aligned_range_pmd_shareable(vma, start, end);
+}
+
 bool want_pmd_share(struct vm_area_struct *vma, unsigned long addr)
 {
 #ifdef CONFIG_USERFAULTFD
 	if (uffd_disable_huge_pmd_share(vma))
 		return false;
 #endif
-	return vma_shareable(vma, addr);
+	return vma_addr_pmd_shareable(vma, addr);
 }
 
 /*
-- 
2.35.3

