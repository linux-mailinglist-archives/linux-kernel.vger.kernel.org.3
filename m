Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3582D51EF51
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 21:11:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240171AbiEHTIL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 15:08:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231254AbiEHSjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 14:39:00 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8158DBCBF
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 11:35:08 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2489Rmbb024483;
        Sun, 8 May 2022 18:34:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=JGVJoAibBScpUerCS+RUO6uB5KGoYKDRMaMIzQvpCVA=;
 b=CfEhJlXV/T9zF9IpQhNKHPz+LcgkqmkxnlxPO8lLyxj2s/mFc/H5m8Rd9SDvPUv13OVy
 YOnQkeTf4aRwABStwOb+kSqNVDvicFCjjfqG7izbL2o+OMj29Ci/ZzVCxyCGrfvx+0UU
 y3RSgpbF7YKvHWo4pd5XS4MdiOyV/ARnOfKLj0RSDerTsx+U/9Al7XBy7ZDdL1a7Ytdm
 JLdFTTetqFWrliPRah0T60WAkiwhOPk/oT3cegy7FC9FZtg/yhHajrKU8mBTkpIDVk1a
 dabovf54Mp8/PqMvi8jWmwzoHjbN5vTxdGoftAsAT0NUaUM8lS6ppzwUwhAE+wO0gr7T +A== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fwfj29vsv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 08 May 2022 18:34:49 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 248IVXUb038267;
        Sun, 8 May 2022 18:34:48 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fwf70yrd7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 08 May 2022 18:34:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BSVxU+JBRiOYjhjJWeewDWZPZ8nZa+WhZum8+/GBy7/hUVvGO0ktvmkrBV/HyAoHrPh1LDpQ3rmzCopArCq1Y9ML/AvJ7KPKJGlGxpayZxQlwxEYb6+K1g7n/vROP7Uuv9l9iAnSIgjklyG3lEFj896hfpklRYl8T2LaU4T6GvYTKJMSWqW6dPEoOvzmykM/CfIX/sn2Y4ET9uAwssQ64Nz59S9K1uL6rtHNMo7UNgFBB3/JHjdemBF9gzyfVK0kek5aNNyf8IdvDiG5RImhzt10u2VPTMPS1keNTwXitC1sIn+Iww79BSUTgKxbjCY9Hrnl0NtmDdygpy9+inNbWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JGVJoAibBScpUerCS+RUO6uB5KGoYKDRMaMIzQvpCVA=;
 b=MH3dZ3D2j9v9QkbCPx2rTzWENy7vJRQwJ83vQLkopwjWAD911HRd1KRgdWmDtzniunzIUr0Fl8crhr+vRW6HphRs4n73HcKJU/qP4fUwgm8xhfUqB2JOHSYoe2WCPqr4MljrH26u2w8a4rPFF07vcKXdNFGTu1qQ4fXF08iTueC5em1mvp7A5Vcg/3HbzOSesJdx/jA+zstWnwmtQ0myReO9sJqdGNx6oZr9WCWh3Frhu1a+tze0iVNJH+xRx5gX0SL0RThtfOXU4gjpyQOkW4CcWHtRDFnmndEm4DxpSfg+L7a9lrADzviJMNEmxz6MSHu3RyCrMlzS5tPdquOlgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JGVJoAibBScpUerCS+RUO6uB5KGoYKDRMaMIzQvpCVA=;
 b=RcT7R6+vPEtSN/c+2jjwMEcWvZgVTuobELzqZoHsdzwcy0jmpc83rPtmjOye6Ch+Y/mdfHUf6Q7IMuKD5gLZbooWLpwLSYUVcW5osRZw96uFeZQT1wJ2kHwdVBLzm6xK97wKPkTVWZNSt7CCp4z7fwxnkbkTtEdyo6rzAV1/8Dk=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by MWHPR10MB1485.namprd10.prod.outlook.com (2603:10b6:300:25::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21; Sun, 8 May
 2022 18:34:45 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::9d76:7926:9b76:f461]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::9d76:7926:9b76:f461%9]) with mapi id 15.20.5227.023; Sun, 8 May 2022
 18:34:45 +0000
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
Subject: [RFC PATCH v3 8/8] hugetlb: use new vma_lock for pmd sharing synchronization
Date:   Sun,  8 May 2022 11:34:20 -0700
Message-Id: <20220508183420.18488-9-mike.kravetz@oracle.com>
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
X-MS-Office365-Filtering-Correlation-Id: eebbc5bc-5ee0-4568-e7f8-08da31216c82
X-MS-TrafficTypeDiagnostic: MWHPR10MB1485:EE_
X-Microsoft-Antispam-PRVS: <MWHPR10MB1485C6F41596DEE924A8E4FFE2C79@MWHPR10MB1485.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c3WycEEyaVsNWNXiMMekJPyGDHiaxjnU6xULEIORLURsxkHxaxchsIv20rjUlh9riZtaeamIhOzaQx4usxI03C73LqqKF0q4wR0EOR/tSBNVAKrU7xZjW2JQRc78j37st2U0ARIj7HRc8kbbPVpNuRlRMccTw1RQk+mJYCyI7CjR3nUinfMbbvQtOixAY1kcsv7tpIb/bIdC45QZjnpUUr9esxYDcnpPIEmdXKdE8JFlxPd/MAHRZYYKFSYmAhkLZgpijzPtSB5fvqb0m2JnbUXVaPudzwMZM8dbZbIoAGQOLFHEiXsSlUX4P3ZpSaZueM1LRD0oLVAvBBzrIl6RIBrLwLBn1zD5FNaTdVpZQbTIWwMU/yuj5FuT0i0URgEGPlXd6qizYk1htYn9R4QFQhGvBcmP0YxezjGUkFSbUTFZJxcfCrd6yONb1xn0Y/RdLO5e5POIPaLvn4h5fY8Oubu9nFZLQRURi+8fXsqLZFfQXM+f5XLg67tzTw8hJbG4533wCAzVajbsC00eHGbMyVBbSVVVVZ3k4apvKog9L6umsgbMqnDoHRHivGkWCSE7rlSJMKMNifz+x3Qyx2Vm9FDvRaslrTWxdGtXfDDfCXgUuqtzXEA+Ve5QKMvRTXKbwhJQ1XRT8eeoEAEypgWhPKoUhbd499hHiYOJf7LxT44q8xlkgHvdANv6hSLPvtoR
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66946007)(66556008)(66476007)(2616005)(86362001)(5660300002)(4326008)(30864003)(6506007)(7416002)(52116002)(6666004)(6512007)(26005)(8676002)(8936002)(36756003)(107886003)(186003)(2906002)(44832011)(83380400001)(1076003)(508600001)(6486002)(316002)(38350700002)(54906003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Vwrf8wAcZCudxFSJzF8JQwH3/KhiIfsczXdUvaF41motJ4AEgKVi2/woBwLY?=
 =?us-ascii?Q?QK3EY6LXyvtkWtP+JGTyn18IAypVQ50lCHMpNXPgqSZ+NI+xjIQoMixN6gew?=
 =?us-ascii?Q?fQpqSKO0guyApeJ0I90xurgxFwo4aD8keGMXt/e+jSvZkcOaoqc3Lko3UttI?=
 =?us-ascii?Q?68UeHQNReNISnULtXeHzmYVBVwUpL5aOOCIC0TDcKJKp75z6CAeFL5VzKrwq?=
 =?us-ascii?Q?YtJQOkTtzv/o1zn2BPR4tQDqQOW4/pbitrRSYe9v7UrIBbbCNS/VbjXI4oYI?=
 =?us-ascii?Q?EHDuNrNULd48LKnWhrv3ffgc/Iz08CeTXqVa+I34Se06nke0C9HQ+4Qp9o+e?=
 =?us-ascii?Q?CGDSPe2OEJVMNLvMPMHpZMAnGki2VPP3cqQblIwmcCGNmehRHoVhwQoWUK4c?=
 =?us-ascii?Q?r1VfjmqFWTb1eHlaqJY+xE3ADpaaGjYco4D3VLmlEheDsOujNssPnLe1h8k3?=
 =?us-ascii?Q?WEkw7gHxZe2L5d8HMiCWNJJhnOFtW5Gqu/TFT8MVCQON/kUofY5ota4Nvn2T?=
 =?us-ascii?Q?wNYj3CVe8/3UnJYaYsROm8fbc99Ke3Wru6IfK7QL7dLreKzujxtGQo6M/El5?=
 =?us-ascii?Q?Pl+3wI8DNdyVpk97t1ud2fgmE0ku56mhy3Vwx2v+0KL/7Tnzs3OTZnK2/TY5?=
 =?us-ascii?Q?FaVoxucg2K8xrtbG348yITg9v9/dagLom+P++Te39E35vIbqjRmoof4bdhFJ?=
 =?us-ascii?Q?+mTMdpr/T6Su0OI8Ik6h4KdAIDLU7kr4KVVVDSX5AEW+asRbq6AS0mgPdMpu?=
 =?us-ascii?Q?K/PBympNpIc69zvQ/CnNeHz1IBQKf3waEbE1+JEvhVLHkx2h+ACF33sKo7qF?=
 =?us-ascii?Q?va+CAfSSYPgg0BxxHrwXH4UVpRgb58OVyWz38jNb6aFW8tNToole4t9r6jTT?=
 =?us-ascii?Q?lQX6Mv87KKz3jrVaY0DuJ4I0TAan4Ki6M8PC/c3L9eKzZUMDAeuPpuT2l28o?=
 =?us-ascii?Q?ihfmIO8MEqJ5L2RNDM0owPorlYVwZTBaKCiCwRItYh/+Eil9z3faGAdFyt++?=
 =?us-ascii?Q?7EndwGWhIUEoSNaWnJkKBd9eQVIP3ahJzJ4y89tyeQkLYSycfe9/H2L2uPXO?=
 =?us-ascii?Q?TD1zzfmRER8cbDEB5jXh113oqwaiG7TmbCNST60XX4khRNiQJ4raWrstef6u?=
 =?us-ascii?Q?5UkmygftDZh6XcfaZSuwAWQjTaYA+42aAWUl0GWfM2/ok03tD1Qa2BWbHfPC?=
 =?us-ascii?Q?Wt8czim4unfZIcAtlka4fgJsnJhnfV4awb0oOr3RPwGlZdHropPrbMny8+o8?=
 =?us-ascii?Q?PJtUxBNfeaVBduUfFc0aJz5USoMOK/rNXOW/+XwZpRXSKzlS8JMEVVoT90hd?=
 =?us-ascii?Q?qZevLMVCfqgeRJbHSe46KxksYX1/WlRI7RaoExhr1TkNGhLm7UJnHxaVwK77?=
 =?us-ascii?Q?IvoWUL/EMA3XeM3W0AbEDAfXNucZwtZayJk8MbjESOkMjYS/q5gy0Yxwbfnx?=
 =?us-ascii?Q?p+if5NThulKvq7i9R/k8+b0lEX9+R2ScHx5g7LdhnxOCngqQPwNjMGYdFE2o?=
 =?us-ascii?Q?NMOXaUfPJZn38vd2wVqzJ8C7skhabFpCoBR/EsAT0qdcZw9JtKaR1P5JSuQk?=
 =?us-ascii?Q?0Edly0KRS92c6uwWVqt8LHb5684cFjFK+JeUveWRuQYOU41mojISrPWsnIo5?=
 =?us-ascii?Q?dmwytE9i500Wl1nMK7AjvG5+KkMAoTP06DwSQZVUaPpB+kCrhI/jLx+MWwrd?=
 =?us-ascii?Q?UXBXjW5PhKhONXgfTX8VJGHOw1Npz1SjkAN5Yz+IypXaTMIXjzIfZX5hBggx?=
 =?us-ascii?Q?GD0Ctx0hGoasppMTMkwoLQgm6EpQI04=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eebbc5bc-5ee0-4568-e7f8-08da31216c82
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2022 18:34:45.2577
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aM/Lg9D9eB5O8f0PUQqOgzJjGZ6Yg8nvqwg3aNxRZ0UArzrqJyuyaMcbNDUxNG2u37N9dfkktsny8pa+4BnwNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1485
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-08_07:2022-05-05,2022-05-08 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 phishscore=0 spamscore=0 bulkscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205080121
X-Proofpoint-ORIG-GUID: w-c2o7qvd5AtcwHWgyiMO7DMs_vq0x4V
X-Proofpoint-GUID: w-c2o7qvd5AtcwHWgyiMO7DMs_vq0x4V
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new hugetlb vma lock (rw semaphore) is used to address this race:

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
sharing process or worse                        i_mmap_unlock_write
...
ptl = huge_pte_lock(ptep)
get/update pte
set_pte_at(pte, ptep)

The vma_lock is used as follows:
- During fault processing. the lock is acquired in read mode before
  doing a page table lock and allocation (huge_pte_alloc).  The lock is
  held until code is finished with the page table entry (ptep).
- The lock must be held in write mode whenever huge_pmd_unshare is
  called.

Lock ordering issues come into play when unmapping a page from all
vmas mapping the page.  The i_mmap_rwsem must be held to search for the
vmas, and the vma lock must be held before calling unmap which will
call huge_pmd_unshare.  This is done today in:
- try_to_migrate_one and try_to_unmap_ for page migration and memory
  error handling.  In these routines we 'try' to obtain the vma lock and
  fail to unmap if unsuccessful.  Calling routines already deal with the
  failure of unmapping.
- hugetlb_vmdelete_list for truncation and hole punch.  This routine
  also tries to acquire the vma lock.  If it fails, it skips the
  unmapping.  However, we can not have file truncation or hole punch
  fail because of contention.  After hugetlb_vmdelete_list, truncation
  and hole punch call remove_inode_hugepages.  remove_inode_hugepages
  check for mapped pages and call hugetlb_unmap_file_page to unmap them.
  hugetlb_unmap_file_page is designed to drop locks and reacquire in the
  correct order to guarantee unmap success.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 fs/hugetlbfs/inode.c | 44 ++++++++++++++++++++++++++
 mm/hugetlb.c         | 74 ++++++++++++++++++++++++++++++++++++++------
 mm/memory.c          |  2 ++
 mm/rmap.c            | 24 ++++++++++++++
 mm/userfaultfd.c     |  9 +++++-
 5 files changed, 143 insertions(+), 10 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index d08520a87dcd..830ec81dd26d 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -460,6 +460,8 @@ static void hugetlb_unmap_file_page(struct hstate *h,
 					struct page *page, pgoff_t index)
 {
 	struct rb_root_cached *root = &mapping->i_mmap;
+	unsigned long skipped_vm_start;
+	struct mm_struct *skipped_mm;
 	struct vm_area_struct *vma;
 	unsigned long v_start;
 	unsigned long v_end;
@@ -469,6 +471,8 @@ static void hugetlb_unmap_file_page(struct hstate *h,
 	end = ((index + 1) * pages_per_huge_page(h));
 
 	i_mmap_lock_write(mapping);
+retry:
+	skipped_mm = NULL;
 
 	vma_interval_tree_foreach(vma, root, start, end - 1) {
 		v_start = vma_offset_start(vma, start);
@@ -477,11 +481,48 @@ static void hugetlb_unmap_file_page(struct hstate *h,
 		if (!hugetlb_vma_maps_page(vma, vma->vm_start + v_start, page))
 			continue;
 
+		if (!hugetlb_vma_trylock_write(vma)) {
+			/*
+			 * If we can not get vma lock, we need to drop
+			 * immap_sema and take locks in order.
+			 */
+			skipped_vm_start = vma->vm_start;
+			skipped_mm = vma->vm_mm;
+			/* grab mm-struct as we will be dropping i_mmap_sema */
+			mmgrab(skipped_mm);
+			break;
+		}
+
 		unmap_hugepage_range(vma, vma->vm_start + v_start, v_end,
 				NULL, ZAP_FLAG_DROP_MARKER);
+		hugetlb_vma_unlock_write(vma);
 	}
 
 	i_mmap_unlock_write(mapping);
+
+	if (skipped_mm) {
+		mmap_read_lock(skipped_mm);
+		mmdrop(skipped_mm);
+		vma = find_vma(skipped_mm, skipped_vm_start);
+		if (!vma || vma->vm_file->f_mapping != mapping ||
+					vma->vm_start != skipped_vm_start ||
+					!is_vm_hugetlb_page(vma)) {
+			mmap_read_unlock(skipped_mm);
+			goto retry;
+		}
+
+		hugetlb_vma_lock_write(vma);
+		i_mmap_lock_write(mapping);
+		mmap_read_unlock(skipped_mm);
+
+		v_start = vma_offset_start(vma, start);
+		v_end = vma_offset_end(vma, end);
+		unmap_hugepage_range(vma, vma->vm_start + v_start, v_end,
+				NULL, ZAP_FLAG_DROP_MARKER);
+		hugetlb_vma_unlock_write(vma);
+
+		goto retry;
+	}
 }
 
 static void
@@ -499,6 +540,9 @@ hugetlb_vmdelete_list(struct rb_root_cached *root, pgoff_t start, pgoff_t end,
 		unsigned long v_start;
 		unsigned long v_end;
 
+		if (!hugetlb_vma_trylock_write(vma))
+			continue;
+
 		v_start = vma_offset_start(vma, start);
 		v_end = vma_offset_end(vma, end);
 
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index e8861603b069..4a60acc89298 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4837,6 +4837,14 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 		mmu_notifier_invalidate_range_start(&range);
 		mmap_assert_write_locked(src);
 		raw_write_seqcount_begin(&src->write_protect_seq);
+	} else {
+		/*
+		 * For shared mappings the vma lock must be held before
+		 * calling huge_pte_offset in the src vma. Otherwise, the
+		 * returned ptep could go away if part of a shared pmd and
+		 * another thread calls huge_pmd_unshare.
+		 */
+		hugetlb_vma_lock_read(src_vma);
 	}
 
 	for (addr = src_vma->vm_start; addr < src_vma->vm_end; addr += sz) {
@@ -4979,6 +4987,8 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 	if (cow) {
 		raw_write_seqcount_end(&src->write_protect_seq);
 		mmu_notifier_invalidate_range_end(&range);
+	} else {
+		hugetlb_vma_unlock_read(src_vma);
 	}
 
 	return ret;
@@ -5036,6 +5046,7 @@ int move_hugetlb_page_tables(struct vm_area_struct *vma,
 
 	mmu_notifier_invalidate_range_start(&range);
 	/* Prevent race with file truncation */
+	hugetlb_vma_lock_write(vma);
 	i_mmap_lock_write(mapping);
 	for (; old_addr < old_end; old_addr += sz, new_addr += sz) {
 		src_pte = huge_pte_offset(mm, old_addr, sz);
@@ -5068,6 +5079,7 @@ int move_hugetlb_page_tables(struct vm_area_struct *vma,
 		flush_tlb_range(vma, old_end - len, old_end);
 	mmu_notifier_invalidate_range_end(&range);
 	i_mmap_unlock_write(mapping);
+	hugetlb_vma_unlock_write(vma);
 
 	return len + old_addr - old_end;
 }
@@ -5363,9 +5375,30 @@ static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
 		 * may get SIGKILLed if it later faults.
 		 */
 		if (outside_reserve) {
+			struct address_space *mapping = vma->vm_file->f_mapping;
+			pgoff_t idx;
+			u32 hash;
+
 			put_page(old_page);
 			BUG_ON(huge_pte_none(pte));
+			/*
+			 * Drop hugetlb_fault_mutex and vma_lock before
+			 * unmapping.  unmapping needs to hold vma_lock
+			 * in write mode.  Dropping vma_lock in read mode
+			 * here is OK as COW mappings do not interact with
+			 * PMD sharing.
+			 *
+			 * Reacquire both after unmap operation.
+			 */
+			idx = vma_hugecache_offset(h, vma, haddr);
+			hash = hugetlb_fault_mutex_hash(mapping, idx);
+			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
+			hugetlb_vma_unlock_read(vma);
+
 			unmap_ref_private(mm, vma, old_page, haddr);
+
+			hugetlb_vma_lock_read(vma);
+			mutex_lock(&hugetlb_fault_mutex_table[hash]);
 			spin_lock(ptl);
 			ptep = huge_pte_offset(mm, haddr, huge_page_size(h));
 			if (likely(ptep &&
@@ -5525,14 +5558,16 @@ static inline vm_fault_t hugetlb_handle_userfault(struct vm_area_struct *vma,
 	};
 
 	/*
-	 * hugetlb_fault_mutex and i_mmap_rwsem must be
+	 * vma_lock and hugetlb_fault_mutex must be
 	 * dropped before handling userfault.  Reacquire
 	 * after handling fault to make calling code simpler.
 	 */
+	hugetlb_vma_unlock_read(vma);
 	hash = hugetlb_fault_mutex_hash(mapping, idx);
 	mutex_unlock(&hugetlb_fault_mutex_table[hash]);
 	ret = handle_userfault(&vmf, reason);
 	mutex_lock(&hugetlb_fault_mutex_table[hash]);
+	hugetlb_vma_lock_read(vma);
 
 	return ret;
 }
@@ -5783,6 +5818,11 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 
 	ptep = huge_pte_offset(mm, haddr, huge_page_size(h));
 	if (ptep) {
+		/*
+		 * Since we hold no locks, ptep could be stale.  That is
+		 * OK as we are only making decisions based on content and
+		 * not actually modifying content here.
+		 */
 		entry = huge_ptep_get(ptep);
 		if (unlikely(is_hugetlb_entry_migration(entry))) {
 			migration_entry_wait_huge(vma, ptep);
@@ -5790,23 +5830,35 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 		} else if (unlikely(is_hugetlb_entry_hwpoisoned(entry)))
 			return VM_FAULT_HWPOISON_LARGE |
 				VM_FAULT_SET_HINDEX(hstate_index(h));
-	} else {
-		ptep = huge_pte_alloc(mm, vma, haddr, huge_page_size(h));
-		if (!ptep)
-			return VM_FAULT_OOM;
 	}
 
-	mapping = vma->vm_file->f_mapping;
-	idx = vma_hugecache_offset(h, vma, haddr);
-
 	/*
 	 * Serialize hugepage allocation and instantiation, so that we don't
 	 * get spurious allocation failures if two CPUs race to instantiate
 	 * the same page in the page cache.
 	 */
+	mapping = vma->vm_file->f_mapping;
+	idx = vma_hugecache_offset(h, vma, haddr);
 	hash = hugetlb_fault_mutex_hash(mapping, idx);
 	mutex_lock(&hugetlb_fault_mutex_table[hash]);
 
+	/*
+	 * Acquire vma lock before calling huge_pte_alloc and hold
+	 * until finished with ptep.  This prevents huge_pmd_unshare from
+	 * being called elsewhere and making the ptep no longer valid.
+	 *
+	 * ptep could have already be assigned via huge_pte_offset.  That
+	 * is OK, as huge_pte_alloc will return the same value unless
+	 * something has changed.
+	 */
+	hugetlb_vma_lock_read(vma);
+	ptep = huge_pte_alloc(mm, vma, haddr, huge_page_size(h));
+	if (!ptep) {
+		hugetlb_vma_unlock_read(vma);
+		mutex_unlock(&hugetlb_fault_mutex_table[hash]);
+		return VM_FAULT_OOM;
+	}
+
 	entry = huge_ptep_get(ptep);
 	/* PTE markers should be handled the same way as none pte */
 	if (huge_pte_none_mostly(entry)) {
@@ -5870,8 +5922,8 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 			unlock_page(pagecache_page);
 			put_page(pagecache_page);
 		}
+		hugetlb_vma_unlock_read(vma);
 		mutex_unlock(&hugetlb_fault_mutex_table[hash]);
-		i_mmap_unlock_read(mapping);
 		return handle_userfault(&vmf, VM_UFFD_WP);
 	}
 
@@ -5914,6 +5966,7 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 		put_page(pagecache_page);
 	}
 out_mutex:
+	hugetlb_vma_unlock_read(vma);
 	mutex_unlock(&hugetlb_fault_mutex_table[hash]);
 	/*
 	 * Generally it's safe to hold refcount during waiting page lock. But
@@ -6377,6 +6430,7 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
 	flush_cache_range(vma, range.start, range.end);
 
 	mmu_notifier_invalidate_range_start(&range);
+	hugetlb_vma_lock_write(vma);
 	i_mmap_lock_write(vma->vm_file->f_mapping);
 	for (; address < end; address += psize) {
 		spinlock_t *ptl;
@@ -6474,6 +6528,7 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
 	 * See Documentation/vm/mmu_notifier.rst
 	 */
 	i_mmap_unlock_write(vma->vm_file->f_mapping);
+	hugetlb_vma_lock_write(vma);
 	mmu_notifier_invalidate_range_end(&range);
 
 	return pages << h->order;
@@ -6847,6 +6902,7 @@ int huge_pmd_unshare(struct mm_struct *mm, struct vm_area_struct *vma,
 	pud_t *pud = pud_offset(p4d, *addr);
 
 	i_mmap_assert_write_locked(vma->vm_file->f_mapping);
+	hugetlb_vma_assert_locked(vma);
 	BUG_ON(page_count(virt_to_page(ptep)) == 0);
 	if (page_count(virt_to_page(ptep)) == 1)
 		return 0;
diff --git a/mm/memory.c b/mm/memory.c
index 9c3e7e6ac202..ebc118708661 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1677,10 +1677,12 @@ static void unmap_single_vma(struct mmu_gather *tlb,
 			if (vma->vm_file) {
 				zap_flags_t zap_flags = details ?
 				    details->zap_flags : 0;
+				hugetlb_vma_lock_write(vma);
 				i_mmap_lock_write(vma->vm_file->f_mapping);
 				__unmap_hugepage_range_final(tlb, vma, start, end,
 							     NULL, zap_flags);
 				i_mmap_unlock_write(vma->vm_file->f_mapping);
+				hugetlb_vma_unlock_write(vma);
 			}
 		} else
 			unmap_page_range(tlb, vma, start, end, details);
diff --git a/mm/rmap.c b/mm/rmap.c
index d0d87b9cf58b..e63ae5ca5fe3 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1541,10 +1541,21 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 				 * To call huge_pmd_unshare, i_mmap_rwsem must be
 				 * held in write mode.  Caller needs to explicitly
 				 * do this outside rmap routines.
+				 *
+				 * We also must hold hugetlb vma_lock in write
+				 * mode.  Lock order dictates acquiring vma_lock
+				 * BEFORE i_mmap_rwsem.  We can only try lock
+				 * here and fail if unsuccessful.
 				 */
 				VM_BUG_ON(!(flags & TTU_RMAP_LOCKED));
+				if (!hugetlb_vma_trylock_write(vma)) {
+					page_vma_mapped_walk_done(&pvmw);
+					ret = false;
+					break;
+				}
 
 				if (huge_pmd_unshare(mm, vma, &address, pvmw.pte)) {
+					hugetlb_vma_unlock_write(vma);
 					flush_tlb_range(vma, range.start, range.end);
 					mmu_notifier_invalidate_range(mm, range.start,
 								      range.end);
@@ -1561,6 +1572,7 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 					page_vma_mapped_walk_done(&pvmw);
 					break;
 				}
+				hugetlb_vma_unlock_write(vma);
 			}
 		} else {
 			flush_cache_page(vma, address, pte_pfn(*pvmw.pte));
@@ -1905,10 +1917,21 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
 				 * To call huge_pmd_unshare, i_mmap_rwsem must be
 				 * held in write mode.  Caller needs to explicitly
 				 * do this outside rmap routines.
+				 *
+				 * We also must hold hugetlb vma_lock in write
+				 * mode.  Lock order dictates acquiring vma_lock
+				 * BEFORE i_mmap_rwsem.  We can only try lock
+				 * here and fail if unsuccessful.
 				 */
 				VM_BUG_ON(!(flags & TTU_RMAP_LOCKED));
+				if (!hugetlb_vma_trylock_write(vma)) {
+					page_vma_mapped_walk_done(&pvmw);
+					ret = false;
+					break;
+				}
 
 				if (huge_pmd_unshare(mm, vma, &address, pvmw.pte)) {
+					hugetlb_vma_unlock_write(vma);
 					flush_tlb_range(vma, range.start, range.end);
 					mmu_notifier_invalidate_range(mm, range.start,
 								      range.end);
@@ -1925,6 +1948,7 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
 					page_vma_mapped_walk_done(&pvmw);
 					break;
 				}
+				hugetlb_vma_unlock_write(vma);
 			}
 		} else {
 			flush_cache_page(vma, address, pte_pfn(*pvmw.pte));
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 1a2cdac18ad7..85bfc9da4a25 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -374,16 +374,21 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
 		BUG_ON(dst_addr >= dst_start + len);
 
 		/*
-		 * Serialize via hugetlb_fault_mutex.
+		 * Serialize via vma_lock and hugetlb_fault_mutex.
+		 * vma_lock ensures the dst_pte remains valid even
+		 * in the case of shared pmds.  fault mutex prevents
+		 * races with other faulting threads.
 		 */
 		idx = linear_page_index(dst_vma, dst_addr);
 		mapping = dst_vma->vm_file->f_mapping;
 		hash = hugetlb_fault_mutex_hash(mapping, idx);
 		mutex_lock(&hugetlb_fault_mutex_table[hash]);
+		hugetlb_vma_lock_read(dst_vma);
 
 		err = -ENOMEM;
 		dst_pte = huge_pte_alloc(dst_mm, dst_vma, dst_addr, vma_hpagesize);
 		if (!dst_pte) {
+			hugetlb_vma_unlock_read(dst_vma);
 			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
 			goto out_unlock;
 		}
@@ -391,6 +396,7 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
 		if (mode != MCOPY_ATOMIC_CONTINUE &&
 		    !huge_pte_none_mostly(huge_ptep_get(dst_pte))) {
 			err = -EEXIST;
+			hugetlb_vma_unlock_read(dst_vma);
 			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
 			goto out_unlock;
 		}
@@ -399,6 +405,7 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
 					       dst_addr, src_addr, mode, &page,
 					       wp_copy);
 
+		hugetlb_vma_unlock_read(dst_vma);
 		mutex_unlock(&hugetlb_fault_mutex_table[hash]);
 
 		cond_resched();
-- 
2.35.3

