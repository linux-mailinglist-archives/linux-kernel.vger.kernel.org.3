Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D424E569341
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 22:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234391AbiGFUYi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 16:24:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234230AbiGFUYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 16:24:36 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A92DF1A079
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 13:24:29 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 266Iutv8010478;
        Wed, 6 Jul 2022 20:24:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=woIq4osnSBp8gNWba+juRZH6czD+qLIXHmmBC+ZTdaU=;
 b=bIRsL1LWud9h8hlvAA4fkoOo/z+fr3xuwUm754jCBPdzKrF7XyERxmc9Zz/s98GyNVFq
 Vpoq9PaukkmPlOAUg20Gm51fp3DGvhmp8tnHw6jRzEmH8WT/h8w2BwLtH27e4aEU2mI3
 SWbDmtSoDaT8oxNowaEq99YGKE5d/XkadKv/oJ+sarofF9unPHR1ef/47WReh/ZtYzB0
 MlFUU8OYrfr7I1nik+RJrFURztaQAR+pp2ghu9gEzU3NdNX/zXnElc88z+BrekPMbwP7
 TiYZ+kQgSbpAFgpjtkPwUfj3LqLlLRME24sOfwdOxSb3aPcMqOlYCB6H5zwWWZ564yWD hg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h4ubyb3ur-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Jul 2022 20:24:10 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 266KLKn2035231;
        Wed, 6 Jul 2022 20:24:09 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3h4ud6cu5w-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Jul 2022 20:24:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g3Y+IN3aDwYXCyxXrlT3W0wWu/1aeaCRzj4UYyQnkLt6pQ6W1zR5LQ1Nx6qbTaOmbkS/IkYTZ85ps4bDRSwB2AlHqX4rxiajhvDfrfdBUsgQmzroI/OfxLJ8X+8Aa+1PAQMUHLTazAVMO/JknvpAK6dGGesQUyBAjpCBu4Y58yKnA1q5apMNjMoIMBfmOfVOTtSU6JJIJFpRtqehQ0EA71593Og9zZ4kHZwcyPHpSCeT1u2ODRUZlTCjhzIRIy/VNogsSen9Nj+/xA67W1Y47/QXISDyrJBlk/5vUxcJwzoF0iKbbQqhPjVdllmuMW4M0Ee8Z+byY/7Po6Pi22u8qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=woIq4osnSBp8gNWba+juRZH6czD+qLIXHmmBC+ZTdaU=;
 b=mIZWIDqkFxaij99e2E1V6euqdnOrAkkMsOx7mqKaAZbKVR5z8m+RBQOMFBMxxb1kiFoo0NpnsqG3u8HfoYvDuCRapG/iIEMn+Ee0vaa72jqsvuqdrcOU5+XXfs1yUuIzRC52MrInJswYZVA+n6oyI0kRG/vFOYWzXCxEJaGG8vvqk5lfk1xuuIx0ZaSkvX2fSXgLR/RxulOI1ji+EjhiShfLKGpvyQtPBDiMngbr93zWRjmCXc7Z+eRU656iyZuXjyoN3YPkhyLv0y2wAheSyrDg5WJhJqUqic+YVNPcXFMmGITEk8ZBnsF6AV2uQt/2f4qEO0E9axnOq2DCK7tQvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=woIq4osnSBp8gNWba+juRZH6czD+qLIXHmmBC+ZTdaU=;
 b=NSV4ghAzzrMQArfku7Ptd+083xO8VUbeNFavQ+tsEgE3PQRqVE4LovqmFFHkuemPIT0D//uZ+dIuc2h6BpUAL/RL8xW3YGRBGTwHZz+A5xWyK4Z+62UVYPURbSWPh/ujdnRpbwOKxsD+ATPgT2fMko+Msbh7oJ+LsDU5sF1ryjU=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by MN2PR10MB4032.namprd10.prod.outlook.com (2603:10b6:208:181::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.15; Wed, 6 Jul
 2022 20:24:07 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c1ba:c197:f81f:ec0]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c1ba:c197:f81f:ec0%6]) with mapi id 15.20.5417.016; Wed, 6 Jul 2022
 20:24:07 +0000
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
Subject: [RFC PATCH v4 6/8] hugetlb: add vma based lock for pmd sharing synchronization
Date:   Wed,  6 Jul 2022 13:23:45 -0700
Message-Id: <20220706202347.95150-7-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220706202347.95150-1-mike.kravetz@oracle.com>
References: <20220706202347.95150-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0041.namprd03.prod.outlook.com
 (2603:10b6:303:8e::16) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 29728986-247c-4a13-6f19-08da5f8d7a5d
X-MS-TrafficTypeDiagnostic: MN2PR10MB4032:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o63xuuAausOwm0WPErDLzSf4SZj6OilP1Gd3lQ9wdK6hjjoq0QADaktSXGvaFUvVVziI5DW+4isj4v5/11AQ2FyypaI9LA37EkUZsJToE9zgn4wlSCMKhYJex65QxJqnd7m/7tpmbx9fTYpg4SFQLCvo5CdGB0ibJIMLQWIzyklWInO2HA333EFHnG/DkOAZ+bS30PqFdNHLZr9/W0CPEnp7f/b8hjmsXkrcYUkfmJe8pRMKzZPUybefNjazSj3oqyLUHdZGLXO9qOuBnlmFFd7RgBJ8utNuDXv4pupiAeBBbzpw4OIYyLbqWZV8tT8Av5eL6O38Yj6dAhU5Qdosu6SuAG4D2qLBnqtRljPzbbRd9IFbdYBWeRfJU/0pRDalHOErOqTc8ERw79NgsBnZUfGvY2Glw0KnxhZ29bJXNSiL2Ryr34gTSmBxMhmz48Yk8uCL7D3Q85xBqBzcAt30HbDL+wslcxkGgoH0TMZ85MMH50UZfbgOQBb7VX2kAhKYtwr+WIg4lCA48fo411c7oGcpmZr++xfUyFY0JtOn4OoFfXJGB0HVqwSUcC44kVDpU3UISBA4smMBfylZ0cO6dl0ADO+odkXKipfYQb7GY3IsdZNzXZIp/TL1XwDNFLuOS9keVMsuZR2mdP6a60aScF2yvJ8qO6BwhapPMKkflzooOieFKFxcjppOFKvv69PiTr5KRe5RMHxhsfsvN+bxl9e26OmwiCpxboY6emWPS53vFav4ALkxO4Chs6O4lii+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(366004)(136003)(396003)(346002)(376002)(44832011)(8936002)(54906003)(5660300002)(30864003)(7416002)(316002)(478600001)(6486002)(36756003)(66556008)(66476007)(8676002)(6506007)(41300700001)(6512007)(6666004)(4326008)(66946007)(2906002)(26005)(2616005)(107886003)(186003)(1076003)(83380400001)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3BzSu6o00gwz4qws4ENJVvqfqBiBqrQ5tvz6vDEq3r2xVRrCW6LRh01YKs9M?=
 =?us-ascii?Q?8M2hLXLDEQISIkBAoFK0WPDWxPq6YnmUnoo907Bf0jYWQVhkA+vdzNKBxYOp?=
 =?us-ascii?Q?x2UAMpYokX7LfnmAfM83+7W+VzQk5YoYLqEBxzitZ7LjCnOpxzGKnG3EB4r+?=
 =?us-ascii?Q?txoaD/4645FnYeAz7WBtWVDcpKKTRIfcjDYEfeHVjwknbII2ZpcnL761wCER?=
 =?us-ascii?Q?6cSFATT5y1SaoScv3zrqwUcvyq6YVyqRA5n1sP0SdbQoc4ae25imzX3VIcUP?=
 =?us-ascii?Q?u5w9/Y2yjaqJRt0NKbLrZav4uSNKSTlRll4GF51GkIbs1254Dksluz3GqfJ9?=
 =?us-ascii?Q?9GIX2xqSo8HLnL8mTHS/H9LYxGr1jrYr36PVwxglme7x6pP70TNQKzfZJpNj?=
 =?us-ascii?Q?c/LUT+bcEG7bMMg1ArREih4DxPwYjqkEn26KD60au+IzHtMlfEOkp9xirkHf?=
 =?us-ascii?Q?/G1f1rdSmtgmFFCd2oe58BttI/iU1MLVZ3t3o++nH358CObYt4Skx3g9q/vD?=
 =?us-ascii?Q?LyHyaGebyv+2yqRsivNOb8EjnyQR2pnEjTGTNGuhsOnOqFgyAImR+FTl3HZt?=
 =?us-ascii?Q?DMDf5VSqlIp+wGrSM8WD0SvKQ6jhKBCIfsAaJUrnIW/GSnD6o6CblcuMTkPP?=
 =?us-ascii?Q?RNNz64ekqxNaSWJjaiR6Fao6zFtHY28LLB+UaZLlZ1tIxuh4JTPHwwJYqoKy?=
 =?us-ascii?Q?6Rki0N8q7kbLo6YtgpRybqZ5kD2vjvv5fHu505Bzjo213XdvPfpYKM6kYLbk?=
 =?us-ascii?Q?7oc+QURWlcyXDBtghz0OvNQjp/3qfWJJtToKGyeAjxrR5hAe+6igE1B5uyqr?=
 =?us-ascii?Q?LDU+tdoZe2MAxPXj6fc7tdC1Wr2oqzXYNJNRP5U2HBisEM7DkzGPXJTRxSmN?=
 =?us-ascii?Q?cDPL77VTTs2/PzedIlEusvfN1o9uq+STjdUpRGcHNv8/n++G46wmHTTTJbDO?=
 =?us-ascii?Q?k9kYCcOjTBc1sUXTMXL/YzAZk7Lfv+waAkU80MDB1qN6SNV8cYc9NYfL/aEJ?=
 =?us-ascii?Q?VkAPNp+BtZi3L6KRGnK4xfhHIJbKOVZ7sDiEHP9zp14X4pFZvwbuDjlNgltU?=
 =?us-ascii?Q?BrQs3FjdLEF2DfdFyVc21i3YlFjYa+EAmxeo6u4K30hSvL8Jupnh6sHFlsXp?=
 =?us-ascii?Q?K/54Wt2P7Dbfe2QGmNoUXSFkO/5aOuM9dwQtOsxXp3YrK6iB735OoRDfK+3V?=
 =?us-ascii?Q?3E8PhKAoM01LB7YgO72jTTNqj3pq4ezVfVK1qcNLbH6Vq8GzIINfYKDbebdD?=
 =?us-ascii?Q?gl72VAtyCObIIEhiSp2+uCsULXzAT1Eslsk5QcGACiIQpypUAD5iCw21rdLY?=
 =?us-ascii?Q?TzMkQBnRZuz+4XsFtljZbPPLjOgTNV1L/MzZSmQPA5QErNXarto5LKB/FlF1?=
 =?us-ascii?Q?AeKdIzAVkhC61aXhVNbNRHUrXoLIsdOK5pZz8KGwSON/73lUcQj3XGzjY5Zo?=
 =?us-ascii?Q?ih35pS8CPtoX3qBdZ7KfPpDZXUgIn9GIb5aYEl8iegm0b5RH68IEUOg1pWQC?=
 =?us-ascii?Q?q/mimGj2Oeq4BJiP+0LHw+9S6aiKTGSxoin+Of41YL47a/n7IoFd5UNJoSZz?=
 =?us-ascii?Q?GGwDjtj04T1gdbhDqOmU7A9i+ofROacvTFTbiszBlQWnV/tfA4xRWZfYRrKq?=
 =?us-ascii?Q?1g=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29728986-247c-4a13-6f19-08da5f8d7a5d
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2022 20:24:07.6348
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: agGZUhLAszs6ER7PhPLX2jxAzf3MYGn3WLvAQS9ZgEMp+0DqDanZUAH05BOzyX0vIcolpOCTovAiGDqWQJzZUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4032
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-06_12:2022-06-28,2022-07-06 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 phishscore=0
 adultscore=0 malwarescore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207060078
X-Proofpoint-GUID: ebqyYBoO9jBRc6USB6ZXkr7-KPBI6vAM
X-Proofpoint-ORIG-GUID: ebqyYBoO9jBRc6USB6ZXkr7-KPBI6vAM
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
 include/linux/hugetlb.h |  36 +++++++++-
 kernel/fork.c           |   6 +-
 mm/hugetlb.c            | 150 ++++++++++++++++++++++++++++++++++++----
 mm/rmap.c               |   8 ++-
 4 files changed, 178 insertions(+), 22 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 05c3a293dab2..248331c0f140 100644
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
index 23f0ba3affe5..ec6e7ddaae12 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -674,12 +674,10 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
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
 
 		/* Link the vma into the MT */
 		mas.index = tmp->vm_start;
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 3d5f3c103927..2eca89bb08ab 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -90,6 +90,7 @@ struct mutex *hugetlb_fault_mutex_table ____cacheline_aligned_in_smp;
 
 /* Forward declaration */
 static int hugetlb_acct_memory(struct hstate *h, long delta);
+static bool vma_pmd_shareable(struct vm_area_struct *vma);
 
 static inline bool subpool_is_free(struct hugepage_subpool *spool)
 {
@@ -904,6 +905,89 @@ resv_map_set_hugetlb_cgroup_uncharge_info(struct resv_map *resv_map,
 #endif
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
+static void hugetlb_free_vma_lock(struct vm_area_struct *vma)
+{
+	/* Only present in sharable vmas */
+	if (!vma || !(vma->vm_flags & (VM_MAYSHARE | VM_SHARED)))
+		return;
+
+	if (vma->vm_private_data) {
+		kfree(vma->vm_private_data);
+		vma->vm_private_data = NULL;
+	}
+}
+
+static void hugetlb_alloc_vma_lock(struct vm_area_struct *vma)
+{
+	struct rw_semaphore *vma_sema;
+
+	/* Only establish in (flags) sharable vmas */
+	if (!vma || !(vma->vm_flags & (VM_MAYSHARE | VM_SHARED)))
+		return;
+
+	if (!vma_pmd_shareable(vma)) {
+		vma->vm_private_data = NULL;
+		return;
+	}
+
+	vma_sema = kmalloc(sizeof(*vma_sema), GFP_KERNEL);
+	if (!vma_sema) {
+		/*
+		 * If we can not allocate semaphore, then vma can not
+		 * participate in pmd sharing.
+		 */
+		vma->vm_private_data = NULL;
+	} else {
+		init_rwsem(vma_sema);
+		vma->vm_private_data = vma_sema;
+	}
+}
+
 struct resv_map *resv_map_alloc(void)
 {
 	struct resv_map *resv_map = kmalloc(sizeof(*resv_map), GFP_KERNEL);
@@ -1007,12 +1091,22 @@ static int is_vma_resv_set(struct vm_area_struct *vma, unsigned long flag)
 	return (get_vma_private_data(vma) & flag) != 0;
 }
 
-/* Reset counters to 0 and clear all HPAGE_RESV_* flags */
-void reset_vma_resv_huge_pages(struct vm_area_struct *vma)
+void hugetlb_dup_vma_private(struct vm_area_struct *vma)
 {
+	/*
+	 * Clear hugetlb-related page reserves for children. This only
+	 * affects MAP_PRIVATE mappings. Faults generated by the child
+	 * are not guaranteed to succeed, even if read-only
+	 */
 	VM_BUG_ON_VMA(!is_vm_hugetlb_page(vma), vma);
 	if (!(vma->vm_flags & VM_MAYSHARE))
 		vma->vm_private_data = (void *)0;
+
+	/*
+	 * Allocate semaphore if pmd sharing is possible.  Private mappings
+	 * are ignored.
+	 */
+	hugetlb_alloc_vma_lock(vma);
 }
 
 /*
@@ -1043,7 +1137,7 @@ void clear_vma_resv_huge_pages(struct vm_area_struct *vma)
 		kref_put(&reservations->refs, resv_map_release);
 	}
 
-	reset_vma_resv_huge_pages(vma);
+	hugetlb_dup_vma_private(vma);
 }
 
 /* Returns true if the VMA has associated reserve pages */
@@ -4591,16 +4685,21 @@ static void hugetlb_vm_op_open(struct vm_area_struct *vma)
 		resv_map_dup_hugetlb_cgroup_uncharge_info(resv);
 		kref_get(&resv->refs);
 	}
+
+	hugetlb_alloc_vma_lock(vma);
 }
 
 static void hugetlb_vm_op_close(struct vm_area_struct *vma)
 {
 	struct hstate *h = hstate_vma(vma);
-	struct resv_map *resv = vma_resv_map(vma);
+	struct resv_map *resv;
 	struct hugepage_subpool *spool = subpool_vma(vma);
 	unsigned long reserve, start, end;
 	long gbl_reserve;
 
+	hugetlb_free_vma_lock(vma);
+
+	resv = vma_resv_map(vma);
 	if (!resv || !is_vma_resv_set(vma, HPAGE_RESV_OWNER))
 		return;
 
@@ -6438,6 +6537,11 @@ bool hugetlb_reserve_pages(struct inode *inode,
 		return false;
 	}
 
+	/*
+	 * vma specific semaphore used for pmd sharing synchronization
+	 */
+	hugetlb_alloc_vma_lock(vma);
+
 	/*
 	 * Only apply hugepage reservation if asked. At fault time, an
 	 * attempt will be made for VM_NORESERVE to allocate a page
@@ -6461,12 +6565,11 @@ bool hugetlb_reserve_pages(struct inode *inode,
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
 
@@ -6561,6 +6664,7 @@ bool hugetlb_reserve_pages(struct inode *inode,
 	hugetlb_cgroup_uncharge_cgroup_rsvd(hstate_index(h),
 					    chg * pages_per_huge_page(h), h_cg);
 out_err:
+	hugetlb_free_vma_lock(vma);
 	if (!vma || vma->vm_flags & VM_MAYSHARE)
 		/* Only call region_abort if the region_chg succeeded but the
 		 * region_add failed or didn't run.
@@ -6640,14 +6744,34 @@ static unsigned long page_table_shareable(struct vm_area_struct *svma,
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
@@ -6656,15 +6780,11 @@ static bool vma_addr_pmd_shareable(struct vm_area_struct *vma,
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
 
diff --git a/mm/rmap.c b/mm/rmap.c
index 6593299d3b18..64076c2a49c1 100644
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
2.35.3

