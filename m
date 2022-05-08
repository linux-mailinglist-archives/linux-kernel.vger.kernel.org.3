Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8F6E51EF45
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 21:11:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236427AbiEHTGT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 15:06:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbiEHSiq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 14:38:46 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40F55BCBF
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 11:34:55 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24892WvP011683;
        Sun, 8 May 2022 18:34:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=WUAnh94DuLhOlezuXXkcDPiZCQL1R8Az9XLltuZiMSA=;
 b=DRdx8Z89cThERPOyen8egdCBKLplcfgIXNomt1dPBowzEGHTlYWEEe0zOQF6Ni+iYNaM
 gbRv170jlycvk1MkGBG3+g6adev1+1UA0v/dJgpd4pWTtNFgsdjV6tryNXMrTKRb/odA
 bxCgJ5BmbhZ3TkWMf1FAAVM0nNReDIjLvQb0beK2RRWtYrkCSjVuoZoIeWIxoNE2acuM
 POAEfJaq1q4T6shAyaRrgGIrP3h3JDaBAPsXdR9fASnqmQdBls9K08+WSchsdLkzVMTb
 zNbwQJfkGscBhRq0ZiwPPiZTVXyuEcxtbh8WLy8VXyy1v1gNIe9kGs1IhfGjnaN99xi7 Og== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fwgcshukt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 08 May 2022 18:34:38 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 248IU5pZ005107;
        Sun, 8 May 2022 18:34:38 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fwf70vjkg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 08 May 2022 18:34:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cLN9L6be2zU5pcPs1H/IXEPMJ2Tw9N3C3g+pipaFkKRTbczjjKgbTEUZqgXEPC3LBYX75Q4f0UNhhMpDMcnlzxivSMQ/bpFnt6+R4JxmKOVhjQQz7oZWxKkGTYxFS+hT8/Huwd25j0Ur3VrzCh4iIjsvcLqXeWayQtgjt2p4j5MMQZ6Ne1AvMULYdGBz88BC6r9ieFY6Kt804KKMrVqCMCjpQ67EKr7gIeeGJAd93sZ5YueXu/fFDzoXS+vDB+I/yVk//Itf6jneFxkHSjqKesERMI2G5ugvcpfaiY7RdV2+x5mH1/0kIIQbSPQ+fevvwg5axLwC6x85MU2yGZtRNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WUAnh94DuLhOlezuXXkcDPiZCQL1R8Az9XLltuZiMSA=;
 b=fK6hecuKd2ZJCD/zDa9bnknf3pMv5oVFlI6sPRPFQRBcwnpOCrHxFyLEviMFBeWRyrpE51pmC9D9Q8o7/MiZAWYFZrAUOZo91hajaX+q1IwPzSN62EG0oCDorXr8QAVsFwQbJaS+P1msbU7E74VN14mMvgzKpo5W3ORjxmzIZcb/oqshQhJ9FdbkJq6lqXcd6Igq6E+gySIOvLnd3UlRxfCYiOybOwJlbuqruM8PqjUY2gEHpCnJDmMmAXmDO5hQVzzisSo1wcZJ5humoEPNYJ03QFh0S8D6QbmdKoTySrfCp/nSDAIkzVtkBArmjjXe0g5b8fgMwuCOGnpaJxcpnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WUAnh94DuLhOlezuXXkcDPiZCQL1R8Az9XLltuZiMSA=;
 b=olp2xQKb7kump/usMPZSkqL7gXNBvkI7B0stsMdddEHDs0o0Zs5GHFaXIczF+DopFG0iTv/domTWQWqpYPZ81tKPAxXCd6J8Bc52/9rVN4Md0/zdko/f7Py+VMRqCGORhiKqjgb7v5NOZoztFdalUo04r0zwndQWpq/RDHhLMPM=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by MWHPR10MB1485.namprd10.prod.outlook.com (2603:10b6:300:25::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21; Sun, 8 May
 2022 18:34:35 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::9d76:7926:9b76:f461]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::9d76:7926:9b76:f461%9]) with mapi id 15.20.5227.023; Sun, 8 May 2022
 18:34:35 +0000
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Michal Hocko <mhocko@suse.com>, Peter Xu <peterx@redhat.com>,
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
Subject: [RFC PATCH v3 2/8] hugetlbfs: revert use i_mmap_rwsem for more pmd sharing synchronization
Date:   Sun,  8 May 2022 11:34:14 -0700
Message-Id: <20220508183420.18488-3-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220508183420.18488-1-mike.kravetz@oracle.com>
References: <20220508183420.18488-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0258.namprd03.prod.outlook.com
 (2603:10b6:303:b4::23) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3ddce134-775b-46da-7c0f-08da31216689
X-MS-TrafficTypeDiagnostic: MWHPR10MB1485:EE_
X-Microsoft-Antispam-PRVS: <MWHPR10MB1485D0AA0B5DDF592E442825E2C79@MWHPR10MB1485.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1buM4b6vWgmAcecpobrEtyzzp8KLIcV1ZooLAn+9HdJCjME9JeiFNuKgJA0zROJX3/pkoXfjZj1jWgV+NHgxknuYplCDSiakIIkvOh9/X7DRcUHkmrIh2rHU0lY8ravSgCwdSquxydku57vfrJxEdtAFxhIbpTIw6E20Ks/j7P40hkmVaUJEnwav4wQjfQlYMm9KQfeezS37WheGtn9VQGnm5Yva29/gAGUfKpZp/Y86fqRD0wZ+BzfXtxEgNf9SSwqXDzqB7SnABJnJxGmC5H8bhjQpc+JpRh/TNo0UmcW1wSfFQQRffgYalojMXBNzQQxCJPN0NGsRN7AIYqgxfmeS9Sl5znHISpOd/bcfSGVYGQqboqLq5ZaCDi6AAdaYS+H6L8Bc3Vzb/c60A4ow5/Kh4Ol65SgvO7FFF0Ky7u9XlsJy+5vJe/9X5ulercQdvOZp9bnSU/jbq5L3Jv0tQyfE9aCUAO1rNp6tUR4zGud3OuWB71S4K5rXWTV5YmaHs2FJKDbULlYkdPHeHe+doWQwh8+GolaXRGpXzXtzkVpcna8VrsPW+ZFwmsMIyktUOCv/1aRzTBV0lycqBfWrChUGkw+l896Y2mn7h3AkbLfIQOwBfr3H6dR3GleHOS2/2YI2OF3QdTBKb+ogXHFXKNhEs6o5hv5IsVcOuwILLtVbJFG3u6q0kAsh71zka7DnWpt6FKZlpvSaXKiIdpyU2g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66946007)(66556008)(66476007)(2616005)(86362001)(5660300002)(4326008)(30864003)(6506007)(7416002)(52116002)(6666004)(6512007)(26005)(8676002)(8936002)(36756003)(107886003)(186003)(2906002)(44832011)(83380400001)(1076003)(508600001)(6486002)(316002)(38350700002)(54906003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?T5h7/y6odKUy+msuB116XyZ5tH+3Q63HDcPkQSrC+mpjE71B5HZaFEeJ225J?=
 =?us-ascii?Q?82emwkPMw31+yAdVBoYwhZHawkqZcG/92IYeU7VxdsD8uSle8eQgdV3ElkYn?=
 =?us-ascii?Q?cglWN1/uvP43Y4px/ynl3qTcWdcSFLoUCBkO5rxlVFETl3rBev21J4QBvszt?=
 =?us-ascii?Q?e7SL0T5TiBLghCFRszP1ByDjQf1+WtDfGBYxCE9zruzjHYGke4IFnydCf58W?=
 =?us-ascii?Q?4s5FaSs0Er8LXNv/Dz8/WD8LWbm1pZag/HPVxU6yQFD+kAmPqRala+xZbOPe?=
 =?us-ascii?Q?pnDujQ09Ej7PiMaoP/1e/SjFdF9+NQ0YeCQk7ve3k+gkH/uDLl15wqHoHm2o?=
 =?us-ascii?Q?AC5ugUupwqAO5v6wFY/OBorVV6DUsM9/gHJug5KgqPQ8sjI+H5hfUSWbzgVP?=
 =?us-ascii?Q?/FQlVDzQeJs1xqKGRY1bPvuBHsTibdUXTeLkel8FTTOqY/gtr8zEAFSycrc9?=
 =?us-ascii?Q?n6zk/E+XoTDf2YExCtSGrPVrLlEEBdYQ4YSevZ1LhgFykCBNI132gP2SI3Xl?=
 =?us-ascii?Q?YECREm6rE2PqY/zCFXNASLTazaGwEcF/CTCAGfK8DxPxt2w3GEUDwcFvbAu9?=
 =?us-ascii?Q?epajVDSh69VReQW1AWQ36RGDBPedRRk09lmAAenrVVnHJB6uViyJl96pS55g?=
 =?us-ascii?Q?vicWuWYdsQLOAjMF/VN2rfZ78IbHOkZKi+ZPaj8ZIEOXHtAiP7YjzqZ0foMt?=
 =?us-ascii?Q?xHFyLCf6+VlNp0pivSDOsqGTj1uQEvyrpJMCmjNeza0ituLwOyaGjKylIs0P?=
 =?us-ascii?Q?Ezcw5i9I5OYDNpxOsrr4vfvUtZl2II2t/RkKBV5sS5DtZr1BmvW3PCJOFC4q?=
 =?us-ascii?Q?AW84S+QH12nBzrTt8bWx/ylT2SezLSszH7J6k2NdcDYL1YflMVaj+6x21axE?=
 =?us-ascii?Q?nrGnimniVvWjPx287j/FULOPPlEz2WH5m/NpSbqU0vNjAPdlzPjmHzRL7oaU?=
 =?us-ascii?Q?OX/osTWirJzsQ1TkKY/eD78A8XM5YycYVsQL7MQ64cgYBVVvKx3ujCt6gzCB?=
 =?us-ascii?Q?/Dde7tOQKKBUI3Cq1is5Q+BdyNRB63Wxh3j+Wl2+5Pp4+Nt6Sr3gR2iLvBBz?=
 =?us-ascii?Q?FtV2bAIzICaitJHbbUzjEDQ+8aCts/6NoYYmneOfm2wECyl42/MU81dm+IM4?=
 =?us-ascii?Q?Q1kENBaZ2jsnpr5Jn7SZRtBFULChlcchdJGnIrkSSYuulNel1BzhhNsapVLI?=
 =?us-ascii?Q?60cbCODlrsdyg+RDZbz+TUAJtpLpXR4r0pl6n8/2RlnL3lFrgTWDEq8l9QDh?=
 =?us-ascii?Q?RdjqIsKWcHOPTt/nAX4wAhHYoJZq87ilfBwv71o6899A9A1gIgPaPCsu4EvG?=
 =?us-ascii?Q?U7sHpx+J9L3c3oiA+e+uNFMWOiNEsRZmfETq8cdLGEwuhjSS4xDxJU+Hs3zE?=
 =?us-ascii?Q?yfHHTCtzwX3NijrxYyIygsOR/5R2e/qEqn+fH2lMGbvwh1cnfGG34l483vqg?=
 =?us-ascii?Q?BR0IIb3D7QMQSFOiiMQQN5Q5yUJVsJQU5tSfBUyYIvwOBxNvkBbZR0brj4Ec?=
 =?us-ascii?Q?ABw+s1NOI8qAfUJM7leLH0PY6kDpBOcw2nRfYbmizLvfcsBlwAOQJG1cYEPY?=
 =?us-ascii?Q?8Zkzi2mrPbcDS45uUHYBli8nWClrYypn7Ubg5Cs9AnD3w8+chPnSn+V2jjm+?=
 =?us-ascii?Q?pDM5+tzwVJJZC1O0zxeOGNSt/uH7ILR4f/qo4kMOlwOzdJAoHJ+JCyYsvIcv?=
 =?us-ascii?Q?qBCfSwomNrlodyV5QUwLz6WbM74kA4bmmjQnoy6Q3IrX5iSuzmRKj+8TjeSD?=
 =?us-ascii?Q?hhP4MjaxgYAN98Z9/zeLlZmeIbRw1BU=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ddce134-775b-46da-7c0f-08da31216689
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2022 18:34:35.2189
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nRUo/s4LRqipR0neM6kO5Tk115tWm7cVrbfAqqcFCH4L3ewp9qgRG4QL/eJwiZJcTJTlqxYcPr6/4+K6+QGE2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1485
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-08_07:2022-05-05,2022-05-08 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 spamscore=0 phishscore=0 suspectscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205080121
X-Proofpoint-GUID: pCJNhwnrKyJ24M8CmDOzjrPTGKI6JJKt
X-Proofpoint-ORIG-GUID: pCJNhwnrKyJ24M8CmDOzjrPTGKI6JJKt
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit c0d0381ade79 ("hugetlbfs: use i_mmap_rwsem for more pmd sharing
synchronization") added code to take i_mmap_rwsem in read mode for the
duration of fault processing.  However, this has been shown to cause
performance/scaling issues.  Revert the code and go back to only taking
the semaphore in huge_pmd_share during the fault path.

Keep the code that takes i_mmap_rwsem in write mode before calling
try_to_unmap as this is required if huge_pmd_unshare is called.

NOTE: Reverting this code does expose the following race condition.

Faulting thread                                 Unsharing thread
...                                                  ...
ptep = huge_pte_offset()
      or
ptep = huge_pte_alloc()
...
                                                i_mmap_lock_write
                                                lock page table
ptep invalid   <------------------------        huge_pmd_unshare()
Could be in a previously                        unlock_page_table
sharing process or worse			i_mmap_unlock_write
...
ptl = huge_pte_lock(ptep)
get/update pte
set_pte_at(pte, ptep)

It is unknown if the above race was ever experienced by a user.  It was
discovered via code inspectian when initially addressed.

In subsequent patches, a new synchronization mechanism will be added to
coordinate pmd sharing and eliminate this race.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 fs/hugetlbfs/inode.c |  2 --
 mm/hugetlb.c         | 76 +++++++-------------------------------------
 mm/rmap.c            |  8 +----
 mm/userfaultfd.c     | 11 ++-----
 4 files changed, 15 insertions(+), 82 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 6954660869a7..0979eebacaea 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -506,9 +506,7 @@ static void remove_inode_hugepages(struct inode *inode, loff_t lstart,
 			if (unlikely(page_mapped(page))) {
 				BUG_ON(truncate_op);
 
-				mutex_unlock(&hugetlb_fault_mutex_table[hash]);
 				i_mmap_lock_write(mapping);
-				mutex_lock(&hugetlb_fault_mutex_table[hash]);
 				hugetlb_vmdelete_list(&mapping->i_mmap,
 					index * pages_per_huge_page(h),
 					(index + 1) * pages_per_huge_page(h),
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 09a0ee4121d1..c9eed786df00 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4728,7 +4728,6 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 	struct hstate *h = hstate_vma(src_vma);
 	unsigned long sz = huge_page_size(h);
 	unsigned long npages = pages_per_huge_page(h);
-	struct address_space *mapping = src_vma->vm_file->f_mapping;
 	struct mmu_notifier_range range;
 	int ret = 0;
 
@@ -4739,14 +4738,6 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 		mmu_notifier_invalidate_range_start(&range);
 		mmap_assert_write_locked(src);
 		raw_write_seqcount_begin(&src->write_protect_seq);
-	} else {
-		/*
-		 * For shared mappings i_mmap_rwsem must be held to call
-		 * huge_pte_alloc, otherwise the returned ptep could go
-		 * away if part of a shared pmd and another thread calls
-		 * huge_pmd_unshare.
-		 */
-		i_mmap_lock_read(mapping);
 	}
 
 	for (addr = src_vma->vm_start; addr < src_vma->vm_end; addr += sz) {
@@ -4889,8 +4880,6 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 	if (cow) {
 		raw_write_seqcount_end(&src->write_protect_seq);
 		mmu_notifier_invalidate_range_end(&range);
-	} else {
-		i_mmap_unlock_read(mapping);
 	}
 
 	return ret;
@@ -5275,30 +5264,9 @@ static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
 		 * may get SIGKILLed if it later faults.
 		 */
 		if (outside_reserve) {
-			struct address_space *mapping = vma->vm_file->f_mapping;
-			pgoff_t idx;
-			u32 hash;
-
 			put_page(old_page);
 			BUG_ON(huge_pte_none(pte));
-			/*
-			 * Drop hugetlb_fault_mutex and i_mmap_rwsem before
-			 * unmapping.  unmapping needs to hold i_mmap_rwsem
-			 * in write mode.  Dropping i_mmap_rwsem in read mode
-			 * here is OK as COW mappings do not interact with
-			 * PMD sharing.
-			 *
-			 * Reacquire both after unmap operation.
-			 */
-			idx = vma_hugecache_offset(h, vma, haddr);
-			hash = hugetlb_fault_mutex_hash(mapping, idx);
-			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
-			i_mmap_unlock_read(mapping);
-
 			unmap_ref_private(mm, vma, old_page, haddr);
-
-			i_mmap_lock_read(mapping);
-			mutex_lock(&hugetlb_fault_mutex_table[hash]);
 			spin_lock(ptl);
 			ptep = huge_pte_offset(mm, haddr, huge_page_size(h));
 			if (likely(ptep &&
@@ -5457,9 +5425,7 @@ static inline vm_fault_t hugetlb_handle_userfault(struct vm_area_struct *vma,
 	 */
 	hash = hugetlb_fault_mutex_hash(mapping, idx);
 	mutex_unlock(&hugetlb_fault_mutex_table[hash]);
-	i_mmap_unlock_read(mapping);
 	ret = handle_userfault(&vmf, reason);
-	i_mmap_lock_read(mapping);
 	mutex_lock(&hugetlb_fault_mutex_table[hash]);
 
 	return ret;
@@ -5690,11 +5656,6 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 
 	ptep = huge_pte_offset(mm, haddr, huge_page_size(h));
 	if (ptep) {
-		/*
-		 * Since we hold no locks, ptep could be stale.  That is
-		 * OK as we are only making decisions based on content and
-		 * not actually modifying content here.
-		 */
 		entry = huge_ptep_get(ptep);
 		if (unlikely(is_hugetlb_entry_migration(entry))) {
 			migration_entry_wait_huge(vma, ptep);
@@ -5702,31 +5663,20 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 		} else if (unlikely(is_hugetlb_entry_hwpoisoned(entry)))
 			return VM_FAULT_HWPOISON_LARGE |
 				VM_FAULT_SET_HINDEX(hstate_index(h));
+	} else {
+		ptep = huge_pte_alloc(mm, vma, haddr, huge_page_size(h));
+		if (!ptep)
+			return VM_FAULT_OOM;
 	}
 
-	/*
-	 * Acquire i_mmap_rwsem before calling huge_pte_alloc and hold
-	 * until finished with ptep.  This prevents huge_pmd_unshare from
-	 * being called elsewhere and making the ptep no longer valid.
-	 *
-	 * ptep could have already be assigned via huge_pte_offset.  That
-	 * is OK, as huge_pte_alloc will return the same value unless
-	 * something has changed.
-	 */
 	mapping = vma->vm_file->f_mapping;
-	i_mmap_lock_read(mapping);
-	ptep = huge_pte_alloc(mm, vma, haddr, huge_page_size(h));
-	if (!ptep) {
-		i_mmap_unlock_read(mapping);
-		return VM_FAULT_OOM;
-	}
+	idx = vma_hugecache_offset(h, vma, haddr);
 
 	/*
 	 * Serialize hugepage allocation and instantiation, so that we don't
 	 * get spurious allocation failures if two CPUs race to instantiate
 	 * the same page in the page cache.
 	 */
-	idx = vma_hugecache_offset(h, vma, haddr);
 	hash = hugetlb_fault_mutex_hash(mapping, idx);
 	mutex_lock(&hugetlb_fault_mutex_table[hash]);
 
@@ -5838,7 +5788,6 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 	}
 out_mutex:
 	mutex_unlock(&hugetlb_fault_mutex_table[hash]);
-	i_mmap_unlock_read(mapping);
 	/*
 	 * Generally it's safe to hold refcount during waiting page lock. But
 	 * here we just wait to defer the next page fault to avoid busy loop and
@@ -6676,12 +6625,10 @@ void adjust_range_if_pmd_sharing_possible(struct vm_area_struct *vma,
  * Search for a shareable pmd page for hugetlb. In any case calls pmd_alloc()
  * and returns the corresponding pte. While this is not necessary for the
  * !shared pmd case because we can allocate the pmd later as well, it makes the
- * code much cleaner.
- *
- * This routine must be called with i_mmap_rwsem held in at least read mode if
- * sharing is possible.  For hugetlbfs, this prevents removal of any page
- * table entries associated with the address space.  This is important as we
- * are setting up sharing based on existing page table entries (mappings).
+ * code much cleaner. pmd allocation is essential for the shared case because
+ * pud has to be populated inside the same i_mmap_rwsem section - otherwise
+ * racing tasks could either miss the sharing (see huge_pte_offset) or select a
+ * bad pmd for sharing.
  */
 pte_t *huge_pmd_share(struct mm_struct *mm, struct vm_area_struct *vma,
 		      unsigned long addr, pud_t *pud)
@@ -6695,7 +6642,7 @@ pte_t *huge_pmd_share(struct mm_struct *mm, struct vm_area_struct *vma,
 	pte_t *pte;
 	spinlock_t *ptl;
 
-	i_mmap_assert_locked(mapping);
+	i_mmap_lock_read(mapping);
 	vma_interval_tree_foreach(svma, &mapping->i_mmap, idx, idx) {
 		if (svma == vma)
 			continue;
@@ -6725,6 +6672,7 @@ pte_t *huge_pmd_share(struct mm_struct *mm, struct vm_area_struct *vma,
 	spin_unlock(ptl);
 out:
 	pte = (pte_t *)pmd_alloc(mm, pud, addr);
+	i_mmap_unlock_read(mapping);
 	return pte;
 }
 
@@ -6735,7 +6683,7 @@ pte_t *huge_pmd_share(struct mm_struct *mm, struct vm_area_struct *vma,
  * indicated by page_count > 1, unmap is achieved by clearing pud and
  * decrementing the ref count. If count == 1, the pte page is not shared.
  *
- * Called with page table lock held and i_mmap_rwsem held in write mode.
+ * Called with page table lock held.
  *
  * returns: 1 successfully unmapped a shared pte page
  *	    0 the underlying pte page is not shared, or it is the last user
diff --git a/mm/rmap.c b/mm/rmap.c
index 94d6b24a1ac2..e0ede92830a9 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -23,10 +23,9 @@
  * inode->i_rwsem	(while writing or truncating, not reading or faulting)
  *   mm->mmap_lock
  *     mapping->invalidate_lock (in filemap_fault)
- *       page->flags PG_locked (lock_page)   * (see hugetlbfs below)
+ *       page->flags PG_locked (lock_page)
  *         hugetlbfs_i_mmap_rwsem_key (in huge_pmd_share)
  *           mapping->i_mmap_rwsem
- *             hugetlb_fault_mutex (hugetlbfs specific page fault mutex)
  *             anon_vma->rwsem
  *               mm->page_table_lock or pte_lock
  *                 swap_lock (in swap_duplicate, swap_info_get)
@@ -45,11 +44,6 @@
  * anon_vma->rwsem,mapping->i_mmap_rwsem   (memory_failure, collect_procs_anon)
  *   ->tasklist_lock
  *     pte map lock
- *
- * * hugetlbfs PageHuge() pages take locks in this order:
- *         mapping->i_mmap_rwsem
- *           hugetlb_fault_mutex (hugetlbfs specific page fault mutex)
- *             page->flags PG_locked (lock_page)
  */
 
 #include <linux/mm.h>
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 4f4892a5f767..1a2cdac18ad7 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -374,14 +374,10 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
 		BUG_ON(dst_addr >= dst_start + len);
 
 		/*
-		 * Serialize via i_mmap_rwsem and hugetlb_fault_mutex.
-		 * i_mmap_rwsem ensures the dst_pte remains valid even
-		 * in the case of shared pmds.  fault mutex prevents
-		 * races with other faulting threads.
+		 * Serialize via hugetlb_fault_mutex.
 		 */
-		mapping = dst_vma->vm_file->f_mapping;
-		i_mmap_lock_read(mapping);
 		idx = linear_page_index(dst_vma, dst_addr);
+		mapping = dst_vma->vm_file->f_mapping;
 		hash = hugetlb_fault_mutex_hash(mapping, idx);
 		mutex_lock(&hugetlb_fault_mutex_table[hash]);
 
@@ -389,7 +385,6 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
 		dst_pte = huge_pte_alloc(dst_mm, dst_vma, dst_addr, vma_hpagesize);
 		if (!dst_pte) {
 			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
-			i_mmap_unlock_read(mapping);
 			goto out_unlock;
 		}
 
@@ -397,7 +392,6 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
 		    !huge_pte_none_mostly(huge_ptep_get(dst_pte))) {
 			err = -EEXIST;
 			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
-			i_mmap_unlock_read(mapping);
 			goto out_unlock;
 		}
 
@@ -406,7 +400,6 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
 					       wp_copy);
 
 		mutex_unlock(&hugetlb_fault_mutex_table[hash]);
-		i_mmap_unlock_read(mapping);
 
 		cond_resched();
 
-- 
2.35.3

