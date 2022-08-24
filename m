Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF46B5A00E7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 20:00:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240475AbiHXR70 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 13:59:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240366AbiHXR6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 13:58:54 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AAE57C333
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 10:58:49 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27OHkI9D019882;
        Wed, 24 Aug 2022 17:58:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=QCwZ/N85rjWntb6nEsKPXaX94vxWecueaucD/Orm1TI=;
 b=Dcb2agzjjRh2Z6LeRqmcL/twI0xbEEPtw9lrlQkftutXdrZcNnlmesJ91Nt8C4pvaSu8
 qsAht7t7h3tg87foOO/n1tnuFK+APkT6FFXd13WCQ0F/zLHr2RTjDs2f9XVBAknjRhki
 QKT0ccvwdGF/LkfArFkZ6PA4DmoNNRhozbXsitV89RguPbW7muE3Y9MNLSse98UaRFGV
 V+OxXRwbGD2BSISY7MbWUR1WUxy06RaGuCxhtTFgK8Pk05aeZUQw4pQYbJXKyGpwkOnt
 WB+JzXVwF3ZIpUpXGY/oGOgcEqEwCHc4BBsiQt0xhR2NJOqCMUwdpfAgMwkfzOhD+SDj RQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j4w23vbvf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Aug 2022 17:58:25 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27OHEEu5011231;
        Wed, 24 Aug 2022 17:58:23 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2047.outbound.protection.outlook.com [104.47.57.47])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3j5n6kujd3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Aug 2022 17:58:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OFdTP6/HlyVAfyjAow1wDP614Ti15uR1vP6F/BXuUxPz8Qugll/yd6dJQOcQqSnuioovGE3UZyBxTk8JswKt9Qk1cZct46rJiwWYCpJenUyVzDfn5q03WY2anhIfXUx4AR62QO1nlTegJkdF8QaKcdaXzONx56gDXkkkGyqeMTdGvjT29rk440WIFtqrXJtV2LuqTqhTlPelDMgNFz808vuXevJPdYaucWMHdRQkXdMDISwGux60v2ZslINCjasw/vNZeWtPI3gba4cLsPTKAsn2PidYAPJ0di6Q6DxetsSryX1+JUnSNQ1IHY9IxRIZKGEMTDUp7P6BMFzBE/cH/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QCwZ/N85rjWntb6nEsKPXaX94vxWecueaucD/Orm1TI=;
 b=hKfJmAOfwoZ2U/sMWiUGEYLgmT8O/261Tkzm+R1qh+ZQBRMdqaenQYR2Gebxzh0FWL+9vqVVlcVcpcXlOkSOWzwQTV8m/Bn/PN7FeIkxk9P7kT+Fb6zMwfWTgZK7nTC2ABL593CAic19mzpkg2Fo9AuYtgXK7F+jBgOcpgSnAfRIqHB4bAfFLEhGxX0vNVmZ6+1hxAuNevVtwT2q1AYt/uvEu43HutGPSmgnUVi+IWju5bTuwkf/aSuaRrtYxDPDGQZEMRWvvvoUNmv6JxvgAZJmIoEc0jwOPgo+f8IxII3jEGC5Mg2Ovxwzzw8PNEIXIXdh//3Vp0pY29NjiKJlBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QCwZ/N85rjWntb6nEsKPXaX94vxWecueaucD/Orm1TI=;
 b=ptuQvbMiwfulU2zyc7VdHg3XlrewUy0+uSLWq9IlnjO2de+8Kk7irvwwxxIoPv1NQ1BTnY6gRhxgPNJsB319U91Fhgp8xuZJxXhZeS3r1hhCVhbGddDpW1ZjbROmg3ce6oJ3Y+KvlmY36ukKAh2VsymSQmsEwL8QFGbExmDJ5X8=
Received: from DM6PR10MB4201.namprd10.prod.outlook.com (2603:10b6:5:216::10)
 by PH0PR10MB4520.namprd10.prod.outlook.com (2603:10b6:510:43::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.19; Wed, 24 Aug
 2022 17:58:21 +0000
Received: from DM6PR10MB4201.namprd10.prod.outlook.com
 ([fe80::11b6:7a8a:1432:bec]) by DM6PR10MB4201.namprd10.prod.outlook.com
 ([fe80::11b6:7a8a:1432:bec%6]) with mapi id 15.20.5546.022; Wed, 24 Aug 2022
 17:58:21 +0000
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
Subject: [PATCH 6/8] hugetlb: add vma based lock for pmd sharing
Date:   Wed, 24 Aug 2022 10:57:55 -0700
Message-Id: <20220824175757.20590-7-mike.kravetz@oracle.com>
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
X-MS-Office365-Filtering-Correlation-Id: 34f7e533-a436-4aa5-b8e6-08da85fa3b32
X-MS-TrafficTypeDiagnostic: PH0PR10MB4520:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bfEyzMoIKp/ZW2BRh8JCq85oC2PZlIxAXOnCbm6bekuR/b/tKbfZwlMJGRviEUGTORzWs666QkTubUmhGRvIO2dDuP0I366dCyc03haRaqcvv/GcIX5DJXYmIXaIX8RKkO2jVpUOC7IvxQKCRluQ+wnKQOUyJNLfA85K6gXM5hUmCYng5qKeshVU9EuBE7V1rc5Qtxu6J7tVZTaaZfYt0v6IG9TKiW/KAKWOqHx80IPqp+xQaqRagMaPkFjk5reAjGLqylQmyk8Bt5e5rGWcGrwPiEECIHsTTu43ZLlBCaJ4QvBLLi3tHbbjwA88YhGW/r2NBIMeZPUbCIzTk57OGTers7YLhiGt0oXPK6oU8dolKfHFlUlo+aOX2FNlM2W6sgGg9dKF/dKhadzHlo/kGnZddn5s5npLc4l239hwjCJkMTAuzreND4Gl598rLkENuSlcaEiSqE+zOhpS1XlRN9UTQl8zgDqwoAf7FBChHYtVjvm1CG00EQDAIv0KmPcfqYOgmL97eBjwrvg7+VmYEd8cPAxDMfd3sFPpaKmWglpYo0K64ZNjpR+IrdvYF8kfpW8cwoJOFzOqQfzwy8Lig3031krOG4RiT/ls0KHYz6jtheORwZgRhhkXfbUMbmIkJ8aYDC8qZ3cK+JvIFZKQcV44xWY7modoNvXaDSvBxpWwgbVgUfzC+pmJ4fmKe/0p04TULZ81vm/M8P14ayU36A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4201.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(396003)(136003)(376002)(346002)(366004)(7416002)(1076003)(6512007)(6666004)(8936002)(26005)(186003)(30864003)(107886003)(2616005)(6506007)(44832011)(86362001)(36756003)(41300700001)(316002)(5660300002)(54906003)(478600001)(66556008)(8676002)(4326008)(6486002)(83380400001)(38100700002)(66946007)(2906002)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?misgXEFnBILQN/ZpHZMbTR9Tri11KarO/459c7WYAMSnTdKuIL24jb3m3XTj?=
 =?us-ascii?Q?lhRnejdpxmSOmgTzVJ1xHtSn6dt7F29GlS7QKcOBUvCXEzDZ1E1qCGaOzku0?=
 =?us-ascii?Q?YDl/aEjr/Gn2W04FtZnhf6B1pgQSPE4HvAu1WoB9rBINVIBUErIosVW5rrEx?=
 =?us-ascii?Q?8qNwyXYDo2fgDlLqB6xCEfjNMvMwzIFLLjG+BQWsqib4KLCp3NPoc+U0L6Dj?=
 =?us-ascii?Q?mok5ZKKaTI/wt7pOS595e0kJKDK1SXmymVYDE3/G3AtxN6q3pw+2P4vOG963?=
 =?us-ascii?Q?1HlScaDwRGtrJJ3ZwqaCVQrn5Ov1pCalHydbKctCLomjQRMdJnz8wuIKCG3Q?=
 =?us-ascii?Q?hDWh66JBni1fKq5OTw/KabzvXGqSm54nY+DQIX3f04AcBU9T8QB4iBB6v+cY?=
 =?us-ascii?Q?nKefwWkmtwB6yJY5b9gy9fX0NnggqjFLdVa3EEOsb9uG1SfuDcwTxffU8xv4?=
 =?us-ascii?Q?fIdCner6B6KeJepbQx9j/ku/fvecMeqAQjF7jEDikqP6EMqnCMSI4hVydP6Y?=
 =?us-ascii?Q?ld+eKfoWb/FVmbnB59tMbJDKb3QGEGYSgwZ1B63QKCilztxjdjwKjs9ZpRJ7?=
 =?us-ascii?Q?n6Cq+6J3T8K+g8xnA/BhwzfFxmQPBixzkPifzpZP/BF17t1BV1YwbSVnMGnV?=
 =?us-ascii?Q?qbuEndgKgstN1NTBf95xOd4b04T7+XT+LEx3pdYT5PWrrNGrBY5RO8sjnN+B?=
 =?us-ascii?Q?iavn/PtzFlSHPReBpIXOfNf+rCC27cSxc1GsMpwx/0rj9DpWVY+icAj0m0Pp?=
 =?us-ascii?Q?svN5ArETXWlFC1iDugPVw6w5KyQD5ACrMMfPkq2qMyUU2D15+xgDxinLrgAE?=
 =?us-ascii?Q?0DYJiUq605mz5QBwqS++dALGl14ebohMUwpQrPbwsn2W267biW2b+4yTJj/k?=
 =?us-ascii?Q?uXLsefTFvNNqMAF1kiNyxiGanrCqFniuc/bjKwFW/ES9yXCBWqJ17EohYlvS?=
 =?us-ascii?Q?VZxmtjFMcr3d6Hf9XHw6uPFq0yIaKKETY2s1lV6se5mfa6/RAsTY4hLhRmFn?=
 =?us-ascii?Q?hw8pEIs16YzzfreJn67squK3Pbty6sTkLuGwEkXVZ9ilZNWQ6ffhOjCFG2Lw?=
 =?us-ascii?Q?a3C8s4Z5tX06yKfx46KI1fJLhtvVruX74sbddAORUXU9pAKpWAmk36fQZ/zz?=
 =?us-ascii?Q?p9ZWIToTShzbAcmaZMWaEcEtNjhUFKbDYU4ZZXPf1KpA4ZGkPli3A3yrKa/Q?=
 =?us-ascii?Q?6O1TFEkFl9M2fvk68Z5OXMA2TLSpiS/YovwLsXCEI2lcILRz9qa8oYDgAHNs?=
 =?us-ascii?Q?8iD3MvF9cr+eqoNb0GVw9+shySUmP2j7wfyCZccP7Zb98Rbtgnu6Kv+9vPVV?=
 =?us-ascii?Q?3BN/L5NqiVfUB4wFoqVEc6exMe9MnFNW1LS3n7/Eex3ar0irqgCzSSIuUMWY?=
 =?us-ascii?Q?B+bmSQA0yG7ZyGwA4TyHadnzVg8QpShG15pvQLeY3TVnkNsJi3mLpBfdGLN6?=
 =?us-ascii?Q?6M+zvo1qQK4Opt9WdGGIkPoR3iwkbiNNHW5XEAzi0LS9+LohiowWkeJOs0eF?=
 =?us-ascii?Q?nylZx+DgAFxrj5VwAGFcXEfJiWn6vPnf7Brc0f7Hbche9zIXDBWZpdR+XD3U?=
 =?us-ascii?Q?2ycFycTjZxBUGAkxSySKpFtUcoNHgDw1JrS6WGv5PKfDT+EqzX7Rkyrfoeyt?=
 =?us-ascii?Q?nQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34f7e533-a436-4aa5-b8e6-08da85fa3b32
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4201.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2022 17:58:21.0031
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HS7IX+kdeqSwDlG0DEmpYg4AwwP0E5IVrhJCXzjLP+bMfNMRbF4PT+pq4Cj/MhL7e0WUjUI7uoDVsR9CWTo/jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4520
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-24_11,2022-08-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208240066
X-Proofpoint-ORIG-GUID: 5qdOHb4hRfaM1-gW9d87htonKZ8w7sr4
X-Proofpoint-GUID: 5qdOHb4hRfaM1-gW9d87htonKZ8w7sr4
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allocate a rw semaphore and hang off vm_private_data for
synchronization use by vmas that could be involved in pmd sharing.  Only
add infrastructure for the new lock here.  Actual use will be added in
subsequent patch.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 include/linux/hugetlb.h |  36 ++++++++-
 kernel/fork.c           |   6 +-
 mm/hugetlb.c            | 170 ++++++++++++++++++++++++++++++++++++----
 mm/rmap.c               |   8 +-
 4 files changed, 197 insertions(+), 23 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index acace1a25226..852f911d676e 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -126,7 +126,7 @@ struct hugepage_subpool *hugepage_new_subpool(struct hstate *h, long max_hpages,
 						long min_hpages);
 void hugepage_put_subpool(struct hugepage_subpool *spool);
 
-void reset_vma_resv_huge_pages(struct vm_area_struct *vma);
+void hugetlb_dup_vma_private(struct vm_area_struct *vma);
 void clear_vma_resv_huge_pages(struct vm_area_struct *vma);
 int hugetlb_sysctl_handler(struct ctl_table *, int, void *, size_t *, loff_t *);
 int hugetlb_overcommit_handler(struct ctl_table *, int, void *, size_t *,
@@ -214,6 +214,13 @@ struct page *follow_huge_pud(struct mm_struct *mm, unsigned long address,
 struct page *follow_huge_pgd(struct mm_struct *mm, unsigned long address,
 			     pgd_t *pgd, int flags);
 
+void hugetlb_vma_lock_read(struct vm_area_struct *vma);
+void hugetlb_vma_unlock_read(struct vm_area_struct *vma);
+void hugetlb_vma_lock_write(struct vm_area_struct *vma);
+void hugetlb_vma_unlock_write(struct vm_area_struct *vma);
+int hugetlb_vma_trylock_write(struct vm_area_struct *vma);
+void hugetlb_vma_assert_locked(struct vm_area_struct *vma);
+
 int pmd_huge(pmd_t pmd);
 int pud_huge(pud_t pud);
 unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
@@ -225,7 +232,7 @@ void hugetlb_unshare_all_pmds(struct vm_area_struct *vma);
 
 #else /* !CONFIG_HUGETLB_PAGE */
 
-static inline void reset_vma_resv_huge_pages(struct vm_area_struct *vma)
+static inline void hugetlb_dup_vma_private(struct vm_area_struct *vma)
 {
 }
 
@@ -336,6 +343,31 @@ static inline int prepare_hugepage_range(struct file *file,
 	return -EINVAL;
 }
 
+static inline void hugetlb_vma_lock_read(struct vm_area_struct *vma)
+{
+}
+
+static inline void hugetlb_vma_unlock_read(struct vm_area_struct *vma)
+{
+}
+
+static inline void hugetlb_vma_lock_write(struct vm_area_struct *vma)
+{
+}
+
+static inline void hugetlb_vma_unlock_write(struct vm_area_struct *vma)
+{
+}
+
+static inline int hugetlb_vma_trylock_write(struct vm_area_struct *vma)
+{
+	return 1;
+}
+
+static inline void hugetlb_vma_assert_locked(struct vm_area_struct *vma)
+{
+}
+
 static inline int pmd_huge(pmd_t pmd)
 {
 	return 0;
diff --git a/kernel/fork.c b/kernel/fork.c
index 9470220e8f43..421c143286d2 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -675,12 +675,10 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
 		}
 
 		/*
-		 * Clear hugetlb-related page reserves for children. This only
-		 * affects MAP_PRIVATE mappings. Faults generated by the child
-		 * are not guaranteed to succeed, even if read-only
+		 * Copy/update hugetlb private vma information.
 		 */
 		if (is_vm_hugetlb_page(tmp))
-			reset_vma_resv_huge_pages(tmp);
+			hugetlb_dup_vma_private(tmp);
 
 		/*
 		 * Link in the new vma and copy the page table entries.
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 758b6844d566..6fb0bff2c7ee 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -91,6 +91,8 @@ struct mutex *hugetlb_fault_mutex_table ____cacheline_aligned_in_smp;
 
 /* Forward declaration */
 static int hugetlb_acct_memory(struct hstate *h, long delta);
+static void hugetlb_vma_lock_free(struct vm_area_struct *vma);
+static void hugetlb_vma_lock_alloc(struct vm_area_struct *vma);
 
 static inline bool subpool_is_free(struct hugepage_subpool *spool)
 {
@@ -1008,12 +1010,25 @@ static int is_vma_resv_set(struct vm_area_struct *vma, unsigned long flag)
 	return (get_vma_private_data(vma) & flag) != 0;
 }
 
-/* Reset counters to 0 and clear all HPAGE_RESV_* flags */
-void reset_vma_resv_huge_pages(struct vm_area_struct *vma)
+void hugetlb_dup_vma_private(struct vm_area_struct *vma)
 {
 	VM_BUG_ON_VMA(!is_vm_hugetlb_page(vma), vma);
+	/*
+	 * Clear vm_private_data
+	 * - For MAP_PRIVATE mappings, this is the reserve map which does
+	 *   not apply to children.  Faults generated by the children are
+	 *   not guaranteed to succeed, even if read-only.
+	 * - For shared mappings this is a per-vma semaphore that may be
+	 *   allocated below.
+	 */
+	vma->vm_private_data = (void *)0;
 	if (!(vma->vm_flags & VM_MAYSHARE))
-		vma->vm_private_data = (void *)0;
+		return;
+
+	/*
+	 * Allocate semaphore if pmd sharing is possible.
+	 */
+	hugetlb_vma_lock_alloc(vma);
 }
 
 /*
@@ -1044,7 +1059,7 @@ void clear_vma_resv_huge_pages(struct vm_area_struct *vma)
 		kref_put(&reservations->refs, resv_map_release);
 	}
 
-	reset_vma_resv_huge_pages(vma);
+	hugetlb_dup_vma_private(vma);
 }
 
 /* Returns true if the VMA has associated reserve pages */
@@ -4623,16 +4638,21 @@ static void hugetlb_vm_op_open(struct vm_area_struct *vma)
 		resv_map_dup_hugetlb_cgroup_uncharge_info(resv);
 		kref_get(&resv->refs);
 	}
+
+	hugetlb_vma_lock_alloc(vma);
 }
 
 static void hugetlb_vm_op_close(struct vm_area_struct *vma)
 {
 	struct hstate *h = hstate_vma(vma);
-	struct resv_map *resv = vma_resv_map(vma);
+	struct resv_map *resv;
 	struct hugepage_subpool *spool = subpool_vma(vma);
 	unsigned long reserve, start, end;
 	long gbl_reserve;
 
+	hugetlb_vma_lock_free(vma);
+
+	resv = vma_resv_map(vma);
 	if (!resv || !is_vma_resv_set(vma, HPAGE_RESV_OWNER))
 		return;
 
@@ -6447,6 +6467,11 @@ bool hugetlb_reserve_pages(struct inode *inode,
 		return false;
 	}
 
+	/*
+	 * vma specific semaphore used for pmd sharing synchronization
+	 */
+	hugetlb_vma_lock_alloc(vma);
+
 	/*
 	 * Only apply hugepage reservation if asked. At fault time, an
 	 * attempt will be made for VM_NORESERVE to allocate a page
@@ -6470,12 +6495,11 @@ bool hugetlb_reserve_pages(struct inode *inode,
 		resv_map = inode_resv_map(inode);
 
 		chg = region_chg(resv_map, from, to, &regions_needed);
-
 	} else {
 		/* Private mapping. */
 		resv_map = resv_map_alloc();
 		if (!resv_map)
-			return false;
+			goto out_err;
 
 		chg = to - from;
 
@@ -6570,6 +6594,7 @@ bool hugetlb_reserve_pages(struct inode *inode,
 	hugetlb_cgroup_uncharge_cgroup_rsvd(hstate_index(h),
 					    chg * pages_per_huge_page(h), h_cg);
 out_err:
+	hugetlb_vma_lock_free(vma);
 	if (!vma || vma->vm_flags & VM_MAYSHARE)
 		/* Only call region_abort if the region_chg succeeded but the
 		 * region_add failed or didn't run.
@@ -6649,14 +6674,34 @@ static unsigned long page_table_shareable(struct vm_area_struct *svma,
 }
 
 static bool __vma_aligned_range_pmd_shareable(struct vm_area_struct *vma,
-				unsigned long start, unsigned long end)
+				unsigned long start, unsigned long end,
+				bool check_vma_lock)
 {
+#ifdef CONFIG_USERFAULTFD
+	if (uffd_disable_huge_pmd_share(vma))
+		return false;
+#endif
 	/*
 	 * check on proper vm_flags and page table alignment
 	 */
-	if (vma->vm_flags & VM_MAYSHARE && range_in_vma(vma, start, end))
-		return true;
-	return false;
+	if (!(vma->vm_flags & VM_MAYSHARE))
+		return false;
+	if (check_vma_lock && !vma->vm_private_data)
+		return false;
+	if (!range_in_vma(vma, start, end))
+		return false;
+	return true;
+}
+
+static bool vma_pmd_shareable(struct vm_area_struct *vma)
+{
+	unsigned long start = ALIGN(vma->vm_start, PUD_SIZE),
+		      end = ALIGN_DOWN(vma->vm_end, PUD_SIZE);
+
+	if (start >= end)
+		return false;
+
+	return __vma_aligned_range_pmd_shareable(vma, start, end, false);
 }
 
 static bool vma_addr_pmd_shareable(struct vm_area_struct *vma,
@@ -6665,15 +6710,11 @@ static bool vma_addr_pmd_shareable(struct vm_area_struct *vma,
 	unsigned long start = addr & PUD_MASK;
 	unsigned long end = start + PUD_SIZE;
 
-	return __vma_aligned_range_pmd_shareable(vma, start, end);
+	return __vma_aligned_range_pmd_shareable(vma, start, end, true);
 }
 
 bool want_pmd_share(struct vm_area_struct *vma, unsigned long addr)
 {
-#ifdef CONFIG_USERFAULTFD
-	if (uffd_disable_huge_pmd_share(vma))
-		return false;
-#endif
 	return vma_addr_pmd_shareable(vma, addr);
 }
 
@@ -6704,6 +6745,95 @@ void adjust_range_if_pmd_sharing_possible(struct vm_area_struct *vma,
 		*end = ALIGN(*end, PUD_SIZE);
 }
 
+static bool __vma_shareable_flags_pmd(struct vm_area_struct *vma)
+{
+	return vma->vm_flags & (VM_MAYSHARE | VM_SHARED) &&
+		vma->vm_private_data;
+}
+
+void hugetlb_vma_lock_read(struct vm_area_struct *vma)
+{
+	if (__vma_shareable_flags_pmd(vma))
+		down_read((struct rw_semaphore *)vma->vm_private_data);
+}
+
+void hugetlb_vma_unlock_read(struct vm_area_struct *vma)
+{
+	if (__vma_shareable_flags_pmd(vma))
+		up_read((struct rw_semaphore *)vma->vm_private_data);
+}
+
+void hugetlb_vma_lock_write(struct vm_area_struct *vma)
+{
+	if (__vma_shareable_flags_pmd(vma))
+		down_write((struct rw_semaphore *)vma->vm_private_data);
+}
+
+void hugetlb_vma_unlock_write(struct vm_area_struct *vma)
+{
+	if (__vma_shareable_flags_pmd(vma))
+		up_write((struct rw_semaphore *)vma->vm_private_data);
+}
+
+int hugetlb_vma_trylock_write(struct vm_area_struct *vma)
+{
+	if (!__vma_shareable_flags_pmd(vma))
+		return 1;
+
+	return down_write_trylock((struct rw_semaphore *)vma->vm_private_data);
+}
+
+void hugetlb_vma_assert_locked(struct vm_area_struct *vma)
+{
+	if (__vma_shareable_flags_pmd(vma))
+		lockdep_assert_held((struct rw_semaphore *)
+				vma->vm_private_data);
+}
+
+static void hugetlb_vma_lock_free(struct vm_area_struct *vma)
+{
+	/*
+	 * Only present in sharable vmas.  See comment in
+	 * __unmap_hugepage_range_final about the neeed to check both
+	 * VM_SHARED and VM_MAYSHARE in free path
+	 */
+	if (!vma || !(vma->vm_flags & (VM_MAYSHARE | VM_SHARED)))
+		return;
+
+	if (vma->vm_private_data) {
+		kfree(vma->vm_private_data);
+		vma->vm_private_data = NULL;
+	}
+}
+
+static void hugetlb_vma_lock_alloc(struct vm_area_struct *vma)
+{
+	struct rw_semaphore *vma_sema;
+
+	/* Only establish in (flags) sharable vmas */
+	if (!vma || !(vma->vm_flags & VM_MAYSHARE))
+		return;
+
+	/* Should never get here with non-NULL vm_private_data */
+	if (vma->vm_private_data)
+		return;
+
+	/* Check size/alignment for pmd sharing possible */
+	if (!vma_pmd_shareable(vma))
+		return;
+
+	vma_sema = kmalloc(sizeof(*vma_sema), GFP_KERNEL);
+	if (!vma_sema)
+		/*
+		 * If we can not allocate semaphore, then vma can not
+		 * participate in pmd sharing.
+		 */
+		return;
+
+	init_rwsem(vma_sema);
+	vma->vm_private_data = vma_sema;
+}
+
 /*
  * Search for a shareable pmd page for hugetlb. In any case calls pmd_alloc()
  * and returns the corresponding pte. While this is not necessary for the
@@ -6790,6 +6920,14 @@ int huge_pmd_unshare(struct mm_struct *mm, struct vm_area_struct *vma,
 }
 
 #else /* !CONFIG_ARCH_WANT_HUGE_PMD_SHARE */
+static void hugetlb_vma_lock_free(struct vm_area_struct *vma)
+{
+}
+
+static void hugetlb_vma_lock_alloc(struct vm_area_struct *vma)
+{
+}
+
 pte_t *huge_pmd_share(struct mm_struct *mm, struct vm_area_struct *vma,
 		      unsigned long addr, pud_t *pud)
 {
diff --git a/mm/rmap.c b/mm/rmap.c
index ad9c97c6445c..55209e029847 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -24,7 +24,7 @@
  *   mm->mmap_lock
  *     mapping->invalidate_lock (in filemap_fault)
  *       page->flags PG_locked (lock_page)
- *         hugetlbfs_i_mmap_rwsem_key (in huge_pmd_share)
+ *         hugetlbfs_i_mmap_rwsem_key (in huge_pmd_share, see hugetlbfs below)
  *           mapping->i_mmap_rwsem
  *             anon_vma->rwsem
  *               mm->page_table_lock or pte_lock
@@ -44,6 +44,12 @@
  * anon_vma->rwsem,mapping->i_mmap_rwsem   (memory_failure, collect_procs_anon)
  *   ->tasklist_lock
  *     pte map lock
+ *
+ * hugetlbfs PageHuge() take locks in this order:
+ *   hugetlb_fault_mutex (hugetlbfs specific page fault mutex)
+ *     vma_lock (hugetlb specific lock for pmd_sharing)
+ *       mapping->i_mmap_rwsem (also used for hugetlb pmd sharing)
+ *         page->flags PG_locked (lock_page)
  */
 
 #include <linux/mm.h>
-- 
2.37.1

