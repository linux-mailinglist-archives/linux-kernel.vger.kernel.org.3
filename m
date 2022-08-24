Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EA245A00E6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 20:00:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239245AbiHXR7L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 13:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240375AbiHXR6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 13:58:52 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE91F57E2F
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 10:58:45 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27OHkK8W019890;
        Wed, 24 Aug 2022 17:58:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=Glb9IFLJyvvc/v2Fwk4BwqIMnxr1gMo/DaP60kaegfQ=;
 b=bmVaLAVsW/TsvUOm3KdbOpYIT0F/gYzMrOruoLDqg/oiw4sKgJULugoDzltDwJ9et3qV
 U3C7iuNjBP0qPOOGboRqBHG7Ve1x7WtyEeXLGc5jw46W3Qqi0KmdN0iRuzcxcqTTu2fP
 iEO2zDfRCuTyt/8lDz33nsBod/wwHmHaDXTu83bISJFTp9feuSbRwHGANqqOBaLgyEVi
 8dozkY51wqX1gwtgwRwKRe+M6RQ4vYi7OfPV9IpHaMecRlBFcwwrn1tDU7j/u0L6zvzK
 UAFPd3y1lqXV72CBvC5806EzYhRWlWkpNUz+YAVd6b/XAkdea6JFZR7xmwwP1zD7yzEk Ug== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j4w23vbvb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Aug 2022 17:58:21 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27OHCw6v021777;
        Wed, 24 Aug 2022 17:58:20 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2041.outbound.protection.outlook.com [104.47.57.41])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3j5n5nbgf4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Aug 2022 17:58:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MxXRYhDCvuU4quXzMs2VY1fFAOE+Cxu0Eu2mBH8ZNbOaURpA3LvaBTK/3glckdrZ7mUYjpuHNsmkOTctRFBVssnlnA3326uE7AM1CnTLz5Y5OcDpDGpbNId1y0n25VsbScRFhrRREpHZdIaJSkpZbgI3pZCHrQ+3btjsqA7s54Oh3UwkumW6MkyB+RQiQnjrq6+krzG6Utebo+Wrrw/ZxNxRCbrTmAZwWwYhNQcNnHUAJYcuoJQgIy9goaRZoYZV1F3aOjmhCb3a+bZEeM/oEnyqebpD5GZzFNbcX087qqzF33pAs7FygKkqp4tqeUqCvRfVtKtWZWkcPhaV156c6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Glb9IFLJyvvc/v2Fwk4BwqIMnxr1gMo/DaP60kaegfQ=;
 b=YR5M4iS9/qU15OF1gw0NkNfMDhqejH87L7ZpqL/sNcdOkdmFsVRop2oHZO6RwiCG9bS7V282fCQHGBSVWb9joazcC4PsjtoE6qrKatssMsG4R5XOcYMklEohqvskrf+7LGak/CDJVNFPltWIiuXjZeplVz+EJ1xtS2nDeuVMfvF0f/xdt4uNe3fQXo5pojhLfQv3ULIAtRWo54aigpRwNf2cY1omJzbtiiTyjY39ROTLxBS0XUS6i6IWVUA9Nq7rLDqbU+BneQGaXap2eX2t099sYr2QYHVjjO0KJ2n/QEACidO1Bk7d5exE+5cKgZSebNzEpq5CTNhQHMu2iWBh8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Glb9IFLJyvvc/v2Fwk4BwqIMnxr1gMo/DaP60kaegfQ=;
 b=UKMRsviVb/VUlxhzeHESG7aqCQ2ec7SOoZj1zP9Ua/U3EGyPYkN14nxR8UgkMxgeFU++L4w2cyFlkx+PtMgk94H07GX6E4mifuzQ8MAWCGkY4ls6W3mY+b9W+efIJ1pfvgbpPsklvC+2yqf0i4KCovsJqY5tNL9BVh8A8yMo1i4=
Received: from DM6PR10MB4201.namprd10.prod.outlook.com (2603:10b6:5:216::10)
 by PH0PR10MB4520.namprd10.prod.outlook.com (2603:10b6:510:43::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.19; Wed, 24 Aug
 2022 17:58:18 +0000
Received: from DM6PR10MB4201.namprd10.prod.outlook.com
 ([fe80::11b6:7a8a:1432:bec]) by DM6PR10MB4201.namprd10.prod.outlook.com
 ([fe80::11b6:7a8a:1432:bec%6]) with mapi id 15.20.5546.022; Wed, 24 Aug 2022
 17:58:18 +0000
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>, Peter Xu <peterx@redhat.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
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
Subject: [PATCH 5/8] hugetlb: rename vma_shareable() and refactor code
Date:   Wed, 24 Aug 2022 10:57:54 -0700
Message-Id: <20220824175757.20590-6-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220824175757.20590-1-mike.kravetz@oracle.com>
References: <20220824175757.20590-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW2PR16CA0063.namprd16.prod.outlook.com
 (2603:10b6:907:1::40) To DM6PR10MB4201.namprd10.prod.outlook.com
 (2603:10b6:5:216::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f22e230a-f671-41ab-5e8d-08da85fa39cf
X-MS-TrafficTypeDiagnostic: PH0PR10MB4520:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 40g0J68DKbepl0hxQDrS3oxXeVge9wCg0+e25UkkgR+ylGkW1zljHV5Bzk1mZp5brUbzMaln7EGCn7geF3dwNJ2gllBSAR/ouW9Hgo3e1jcibP0qPo1M+nBDbv0hWCrxmb09HZb8LFAhd6wNGioo9QHfzhNRH3LvCsso3tepYK2+siDGEZ8QwvXJx6vun0PX0hqDhRJy3W/9yce6KU8mxFU1Wsa/s39T1u4ZfTdzd5KQryOsnjI73Oxh28ZP4OelTSdLJ1cJtw6zE9ZBz/WC6CPRcCh0qaZqF7M6OAnLB2YTj0B/kt9Ldf/GYdZaTBJZMGgYsqYCt9eUB4uj97LqbAJyZe+bA/Er/lF8CgxqUf9eTPv5R3BrMBsAgF+enNcLIqDQEjK4yB/ppWEFmTnkZNTuAaT6YWJV0yuh/Fxe12yqfILKx4o0L6OHR2Tb/l2hCyREsnY2JEF7p4u81lOkkl6dLxDlkVhttppKGZH7jMgb9vLP8E2qFh3UfvgDFTNyM3/CaFiJVP4ferlDAjacdo/0BkdS6uKFTxAle5N+/SBZnZnbFO8Uy7eAFFo5Hy8sXcq2Mdtq8Ga4wgN5y4DriHqRx0W8U+AE3kbCr6pRlfhpvIa0XCbMynkUsJ5AbwK8Eh5gKUK4QCmr/q4JupLpu6yR3gfKCONUTBlt2cF7oj4OBwg7JMGf/zUqhsPhCb8vGSfbit6xA6Ma+ucs94B1TA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4201.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(396003)(136003)(376002)(346002)(366004)(7416002)(1076003)(6512007)(6666004)(8936002)(26005)(186003)(107886003)(2616005)(6506007)(44832011)(86362001)(36756003)(41300700001)(316002)(5660300002)(54906003)(478600001)(66556008)(8676002)(4326008)(6486002)(83380400001)(38100700002)(66946007)(2906002)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sJiBa6wsm6KJ5zBz66XkDs1Rve96iA3fq1XW9wm15QKkUhOt0TTzi6oyvVaW?=
 =?us-ascii?Q?qRQzZNrv4e4E1BQGOYLEUwhrgHcYdXD/2a9KugqLRylFTZ7dulHRDoBjKMkd?=
 =?us-ascii?Q?jR/S8qos5wfrvNhoSJlceLxOYgqBQGKsNWtJHwwf7AihrsxKUq7yHTVLZ6/s?=
 =?us-ascii?Q?m3TCi60YXV3oywlRa6KTmW/qr3frA3tMOmt0QRoEtXPutCgadAYF7b28S2Tu?=
 =?us-ascii?Q?qepNAFcwDp+3bhiCxoEH/jdC3hY2CMe7k1wxPlG7D15XoGd7ZpM/OMAd4dTr?=
 =?us-ascii?Q?hSkqzevEwtXRb7K9/ckQa5sDN5chyCmMq3q9/ayRAUxx+cdyY3MfIzzHlPpC?=
 =?us-ascii?Q?DJHQ6l6vJfYre/HsWmhAulO13gKG7hcxkt8OKl+dTdxjx5+mgOm9Pj555Atz?=
 =?us-ascii?Q?hOZfrNnxejZhiWgRI3QDArT2T7PcnBNjnbaeewla+VYezxvAHRb7z798iSII?=
 =?us-ascii?Q?HxWH8Xgbh5qYKuIh/xGSbJRYmQw6A2V3Ywmq2BKiD76ikzgCOy2dJPNSPbh9?=
 =?us-ascii?Q?KwNCSaBPNBErB0Mfe9y492/6SlY6+/fkEPl/7pm4pDI+75rT5UqKve9IIfFB?=
 =?us-ascii?Q?PGXOXivf6GnY0sR4ioHQCzgogjupBJN1Ud0H3Gzigd9+DJFB8u+JemB8RMss?=
 =?us-ascii?Q?nYz5jmIYRCiZas+uSa6spkNNUUwbdA4YQ2Mg26Spv3MUm2nouuLehEohzgJd?=
 =?us-ascii?Q?EhA8J/JBeZF7ZoWgid0kKx6Dgn4qOHpiK4L9aTzqeoFyb9YWjDmgPQY4Zrbd?=
 =?us-ascii?Q?rf/G/SzrD2FDWB6fvZb1jQpMY6VLpjSZKv1UZtxbDk72kwEvtTf1Ozg02EiI?=
 =?us-ascii?Q?fIxPQk1GggyJKmI5f90Nmw66w1nOUBE3FFMBs0KDuULxoF7+QVE4cIc0Yfap?=
 =?us-ascii?Q?44Of5fAV3IS3pT3yCsuWlREW6on0rnnUL5Ji+/tjiQ8vCKqT8xJ/22/22OgA?=
 =?us-ascii?Q?R1XuxFKljiJ1qSyrYsiNZgsOlnpwnGQrdE3/gXKqx61V8eqjdGUsJDq/fd4J?=
 =?us-ascii?Q?BKRKQxYbY4LD+RmBtNMzWzUZx1WweXh+6+TF9EBdY9EJD3YSgputO3lzZDEU?=
 =?us-ascii?Q?XNs/A4d8Ro7mO9lAaO8GurfSRvjMZhOW467K4Baeh3UTc1p0mr60BaCHo7pf?=
 =?us-ascii?Q?9M4vE3Z9XQwTAYnbDgKrfmtPQXl5xELLzO3WxK7Q/uqeLRGo9RFYXV8CclVw?=
 =?us-ascii?Q?1mgb76okHOuJuIvzebFrzGTZCIk68ikAlbfVKlG7T3yl8mfs3ETLHvtkIL/Z?=
 =?us-ascii?Q?mz+Q5CauzT1iXX/NhB7gQwDrumBP/uMnXHFSUM3cndjrXhPLio205Hxwv5aC?=
 =?us-ascii?Q?8p+rVveBDzhHGg+m8q4Xclrco22gmVx4ya4B32Z2kWFHBWHkpIT0yCJOv0c7?=
 =?us-ascii?Q?IAA4lttd4vsd1QKZwTDKgt0ptf1hLFRrmNTLgn10uukSx2TiVogUGim2Gqkh?=
 =?us-ascii?Q?D+Y5Vww8qDZlsB+gd2tSL82x9ZG6OFE38gycWQzAR8SVzY2OxuowdkY9IJ15?=
 =?us-ascii?Q?M3jBq5cNFCmiKpKNxAqV7P+fVSLRIQLpdwnyf/9wfYlcuaAazCUu3crlRCVz?=
 =?us-ascii?Q?gzFHRy2BM14X9G0jliHFG9UB10pkyMvZL5Ol7khyGgMmvq7Y5ILHbXwqJsvi?=
 =?us-ascii?Q?Aw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f22e230a-f671-41ab-5e8d-08da85fa39cf
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4201.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2022 17:58:18.5337
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tB2OYvFd2x1ZpbFcBLkqPUBVSGgcjG6EjQwuXpXeMFJPYqM2mFpvsw1LTGLC+nUJHsHoJDUEfpH5BCLzxuY4mA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4520
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-24_11,2022-08-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 adultscore=0 mlxscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208240066
X-Proofpoint-ORIG-GUID: qzDGbdXMLe7l5D7Nxr2hAGVfcXHJslbp
X-Proofpoint-GUID: qzDGbdXMLe7l5D7Nxr2hAGVfcXHJslbp
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
index a6eb46c64baf..758b6844d566 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6648,26 +6648,33 @@ static unsigned long page_table_shareable(struct vm_area_struct *svma,
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
2.37.1

