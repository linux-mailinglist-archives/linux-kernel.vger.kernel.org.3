Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69D28569340
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 22:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234589AbiGFUZN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 16:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234045AbiGFUZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 16:25:05 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 597AB2558E
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 13:24:47 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 266Il2I4015771;
        Wed, 6 Jul 2022 20:24:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=seh+t+7lpYZ7uIk7rcl3V3IrvZ/ruQR66XXKFOeUdH8=;
 b=ygDehNYXji0B6MvzD7xwkXguSoTwbpoKfAnXt5IKZDzVvoBPZoIZ6rlvmLnmS4T1H2xL
 oYHy4ewKpSjxSoXafRIVdrjOElrw9NvMRIWExODajIda9zYhtTi31zN5WwQkZJWsTpQY
 nCTw4RaUs86wJ14hDVWmu8ozXfkIfLVnMU91cEUCLd54rl9m0hj4mxYB0kmeWo8qkp+P
 wylyaTtze8TDz02Xmk3PTOXf4z2+QHUF1Sihb2qlb1oMtpTlly+HcGNzQR4Mk7+QzlhP
 HcAZftNYxqjToJgyWgKgnHDOzmTXMj5FeVxqbLgQ+248Xxe92zozYnOHZLOsbqLrQSqw 7A== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h4ubyk99y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Jul 2022 20:24:13 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 266KLJcw016094;
        Wed, 6 Jul 2022 20:24:13 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2103.outbound.protection.outlook.com [104.47.55.103])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3h4ud56ee5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Jul 2022 20:24:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ILPuLCeexdPiWZYZDCgeHu+JohxpdbP2aYV872P1qKG92t1MbhRJ2XTEpFxJ1XFlXFhXX0I7qvCEjgeLQnTelxvkqSk7h53K5hd4Tmpz+tX5Fpy2HThj+5j86hRrb8HlP4+Vpz52BZHQeQ0/qZJdxasxWNE+7jUZTYozChnejCi7H0WMy2F/PQyxF/mB7EcA9bZyYMsdDrRY7TT5ixQ8siMR+NzHgPGKRCXA4ILVunU0aX/P68XMpIu6jG3Hne9Snsb0811wLavJ4DSEsxUmI1yAUKLynoyyOrItW6ppCo0Eqmecn79uv+i+04HdIi6WdPUKJ6Ihwzaw69rH2KYFqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=seh+t+7lpYZ7uIk7rcl3V3IrvZ/ruQR66XXKFOeUdH8=;
 b=IP3iVrCJLZYGXZWnU0rE5O0n60IsPBPmCyebi5ZpyfIfmTQKNj6RLCDVJ39joLm6b98h3BJ5eNUPERy7JbtY8OgUCDVhdz9s3WZYmx9v5IRZPPCQ5RX7FmHa8cdaozCISHUwIiG0DcEZxCtpOw4gSceSoa2e8sj+iK/YC1QOfmmygNzgC1ATdtCaMgoqcgssmdeyfxOBt4bFfWeb2nZNJD5f0itmFfZ+/LburMXcb5BlL06FCWJrLqd81/ceqv6js5ZgxtqQQ52MSYb2tV22VF9XBx5pKaSxD+iBlT0BuYnRqyWI5KJBSiZuVj6rbNo/GnQwGPsLqR5ixVTENcOp5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=seh+t+7lpYZ7uIk7rcl3V3IrvZ/ruQR66XXKFOeUdH8=;
 b=ADOH6yurmd0gBFGOJn2yZWC96KGZS8l6kGfC7Hd3Aq2edVU3CKpDihgRHGzdmx22CF/OLaagcSURZeF2b5gnyzT56NiH6KdqGYxJE0CnRsYeS1GeppyZzTS+1FfvSdolZDFR++2uA7lIboSX3aq4h6AYY6ZIvcoeGkI01eCYCO4=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SN6PR10MB2847.namprd10.prod.outlook.com (2603:10b6:805:cb::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.18; Wed, 6 Jul
 2022 20:24:10 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c1ba:c197:f81f:ec0]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c1ba:c197:f81f:ec0%6]) with mapi id 15.20.5417.016; Wed, 6 Jul 2022
 20:24:10 +0000
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
Subject: [RFC PATCH v4 7/8] hugetlb: create hugetlb_unmap_file_folio to unmap single file folio
Date:   Wed,  6 Jul 2022 13:23:46 -0700
Message-Id: <20220706202347.95150-8-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220706202347.95150-1-mike.kravetz@oracle.com>
References: <20220706202347.95150-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MWHPR18CA0052.namprd18.prod.outlook.com
 (2603:10b6:300:39::14) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3fd38465-a142-4385-3330-08da5f8d7c01
X-MS-TrafficTypeDiagnostic: SN6PR10MB2847:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i8z2meG5AczYSf5r2p/+80l1VemxsyAb7rfVPCgl2hc9mWgVC8G+KUQLbeLY5GHK/ru3IGT+hdbmvSIMJgJ8sGl6nOAAPZc4gNh+x7kF+Ow394sUa6pFLVQapHHS5btbz1xb600Pgf5LpK0pPYVR9IYDYu9tlGBP0X7EBYdJu6WNWQaHhcsMCbaaqchNp0u4Tnc/YvmfXoauYYBZrff8FoGmsUlcHSDQMvUpE7SbFijJFFgDSaqEIMxeUZURCz1FhgyD8KBvbF54jBFIFm/6yNljS4uDt7n9NYxVncnFyG4qnLu1BzeY2s9sKnmhYCY089quAIkD/Tt7iuaSCcXrF7pMvl9/S1C08A6Rm0BHD1H0py4GxTSy2WSXlK2JTbzj1mFDD7ZvotSkBciRKExChQS6hN9A/YBWM+L0rDo2RbGACTLiEcOqoxLui4Y32IiTF2yK9OVKlmPdAYGKVp1R2YSoqvVu9rjKaLEjt2h71c4G2MhvSgqaxgNfwVoXfQzaI7FBBVpz0/RHsxdyYDbEJWY7WsMD5W7S1DxVKsu4ChRuNhIZuf1HFmEFZEgBPgLPINR+CVaGZXvBG3Vsx+X3vHTe89V9LxClRWzxN5gP5dpPTXUYUbvw6Di6RT9KX2Gs7uh0IGYSrr9fD7qkD42MU9IPhHZim+FefmbwoHCeJnfdpvFHE3n4xUElu9nxABTJoPNZEM/snycxXZmA3lzR3nsti80dCh7jXmz6BaMK/swIH0KnN1K7Ev3aNKtqVx9x
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(366004)(396003)(39860400002)(346002)(136003)(7416002)(478600001)(8936002)(5660300002)(6506007)(2906002)(66476007)(41300700001)(6666004)(8676002)(4326008)(66556008)(38100700002)(54906003)(44832011)(36756003)(26005)(186003)(6486002)(6512007)(86362001)(1076003)(2616005)(107886003)(83380400001)(316002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kL5qx0M7/7YqH3pus5MhJ37MXHpANdZpJtUX4eXfJQ3JEA5MMKH+ecHWJMR1?=
 =?us-ascii?Q?pwMbUWXpGIRVMPl9tNVVKjNOcEE6vfCzR9E08AwCAywFlInjHejxMRxmHz/Y?=
 =?us-ascii?Q?G7MPZMnhWzGB4Y/HoUhK4JCShAGZCU6jzcFFyXhDx4pGBBJYd3S8oIEHKMlC?=
 =?us-ascii?Q?O/CBXCvsyq9pV998kWJPc4kAW1q0PRkNRC3HVt2ujhJLZb2eH/dc/s1TMOyy?=
 =?us-ascii?Q?OFolBSB6UWV/Asbrzu8QBOX+gMg74/7C29n53yZl/ia189FqjO7TBUH5IHEX?=
 =?us-ascii?Q?CboHNe/7X8z1oCByzYJ1Oc1sAD13g93PEMg5Iuak4dRIe6/qEziBvrSrIXiZ?=
 =?us-ascii?Q?OM/MB6Qfnetf3+gU82/J9qhZi3A0GokCqrzgF6NvfD8uV77Y3MAv/1gdToYB?=
 =?us-ascii?Q?tvxNmVPURojw2ZWKV5pDGBuECXv7eBfb2nmdb1H9ES3Q0lNwecLiB6vZdKWk?=
 =?us-ascii?Q?b4BKI9XjHICpWMWc6T+Qn0A9HRvuscYHzJZQlnwZZgKKBpfIMDeqFu+JRVPR?=
 =?us-ascii?Q?Z/sGzqcCJB4niyHtFKxMYOZ92rU4lG+he9O4VkBhIY4Kh7s8RR2tg/KvMSIp?=
 =?us-ascii?Q?S6HHQbDF5s3cHXglNmK3bfybCtKT9m5X34jmGOBqn/PN1hvzasBr2M2+pPjZ?=
 =?us-ascii?Q?x1qxcMTSJnmcIV6yskXozeVCNMGc7w9B+roQbIC57IalZwa1eAqNZMBOA2Lp?=
 =?us-ascii?Q?rm4/+dwx2h0pHH82ZP//V8pj+aOvps6N/CjwQR9eg+C8druGY1XfhFCpz3u7?=
 =?us-ascii?Q?3MmXFC4DhWJy5piGCbA1iPAe6I35xp5Lj7gCQvjZLThOPUqpJgpVRT9LQkn5?=
 =?us-ascii?Q?hjC/HK7CgPezu+ZJXcLuLj5YlMTqRdV1+H/D/IdXwOL6hTKxpnGl9fK+eSiR?=
 =?us-ascii?Q?xBZMZWjTXJLJ3J2MIOCsjoj3jvngkjsW4saNXmuJe5NgFKvlx0WlRBm71COT?=
 =?us-ascii?Q?WlGMS10Oof6+rZirSQnWoOSDjZToKt7OZ/U8fVaO77hhpK1qiXYjvCYCjQ+R?=
 =?us-ascii?Q?imEgwsCGxIJ6PESYfW20Ej53Nsi8jYKaulEqgRKCI/eJRZVHu6K24Vx/9Y1B?=
 =?us-ascii?Q?34NolSTnT7R59FWA2kj5MQnwzxgAXkubvQWEr3qKlaHpkYtozasr0g6GXUGe?=
 =?us-ascii?Q?GsVQwrByGvVPpFEsNcx8MRndtuxO8oK5GDt8l+j6gFt5GKTNgzqbB9KDRGyB?=
 =?us-ascii?Q?p5LEOepZBCBkCVrYhPUF0pvVpPtQZ45WEGJhL/+WpFclQPVDkQ8mBtv/OQgB?=
 =?us-ascii?Q?jifN8qqQQ3/BAFIrvXlmaiTkiA8oDUW5zB3iWsoAa5eYVZrBI9R/BbxQulR1?=
 =?us-ascii?Q?2k9VFQoiKnDGmU+hS5ZP/axsH1mUD5k/fyBIIdoJ4K0BzqVNoLl36z5KYx0T?=
 =?us-ascii?Q?Q2FUgkP1hpil4hZPV4NMuWVvRazRM8EICllf8s3Ueiu913wR7rqP+OHU3HMQ?=
 =?us-ascii?Q?WxVsst7Sx1Jh9wHpZk7c0DFOMDnkddxLQdhgrdG/Zdi8XrPg+pKk/U4HA+9g?=
 =?us-ascii?Q?RVVQkYCjjs50kL0qnXRzMUy7hNB8xXisnIsb/JOe1nMne3f4UzhtRs5rwUpA?=
 =?us-ascii?Q?zb6pZXhHswdevVxrSKMMBaQUJY53IFKBwq5KC/1SHkJyq98FNk3cyIaRS6gd?=
 =?us-ascii?Q?7g=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fd38465-a142-4385-3330-08da5f8d7c01
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2022 20:24:10.3701
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HcEviDu/TnYR2mkzD5GsXQmDtOiz2hWGvENvWuIGhN9YuAkor4q8O69/+3SAPJ68eScvXhCRPGCE7W6lC+oWjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2847
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-06_12:2022-06-28,2022-07-06 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207060078
X-Proofpoint-GUID: AlEAgMHsMK9UIBXJWx1DE4r5pC9zmHSv
X-Proofpoint-ORIG-GUID: AlEAgMHsMK9UIBXJWx1DE4r5pC9zmHSv
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create the new routine hugetlb_unmap_file_folio that will unmap a single
file folio.  This is refactored code from hugetlb_vmdelete_list.  It is
modified to do locking within the routine itself and check whether the
page is mapped within a specific vma before unmapping.

This refactoring will be put to use and expanded upon in a subsequent
patch adding vma specific locking.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 fs/hugetlbfs/inode.c | 124 +++++++++++++++++++++++++++++++++----------
 1 file changed, 95 insertions(+), 29 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 31bd4325fce5..0eac0ea2a245 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -396,6 +396,94 @@ static int hugetlbfs_write_end(struct file *file, struct address_space *mapping,
 	return -EINVAL;
 }
 
+/*
+ * Called with i_mmap_rwsem held for inode based vma maps.  This makes
+ * sure vma (and vm_mm) will not go away.  We also hold the hugetlb fault
+ * mutex for the page in the mapping.  So, we can not race with page being
+ * faulted into the vma.
+ */
+static bool hugetlb_vma_maps_page(struct vm_area_struct *vma,
+				unsigned long addr, struct page *page)
+{
+	pte_t *ptep, pte;
+
+	ptep = huge_pte_offset(vma->vm_mm, addr,
+			huge_page_size(hstate_vma(vma)));
+
+	if (!ptep)
+		return false;
+
+	pte = huge_ptep_get(ptep);
+	if (huge_pte_none(pte) || !pte_present(pte))
+		return false;
+
+	if (pte_page(pte) == page)
+		return true;
+
+	return false;	/* WTH??? */
+}
+
+/*
+ * Can vma_offset_start/vma_offset_end overflow on 32-bit arches?
+ * No, because the interval tree returns us only those vmas
+ * which overlap the truncated area starting at pgoff,
+ * and no vma on a 32-bit arch can span beyond the 4GB.
+ */
+static unsigned long vma_offset_start(struct vm_area_struct *vma, pgoff_t start)
+{
+	if (vma->vm_pgoff < start)
+		return (start - vma->vm_pgoff) << PAGE_SHIFT;
+	else
+		return 0;
+}
+
+static unsigned long vma_offset_end(struct vm_area_struct *vma, pgoff_t end)
+{
+	unsigned long t_end;
+
+	if (!end)
+		return vma->vm_end;
+
+	t_end = ((end - vma->vm_pgoff) << PAGE_SHIFT) + vma->vm_start;
+	if (t_end > vma->vm_end)
+		t_end = vma->vm_end;
+	return t_end;
+}
+
+/*
+ * Called with hugetlb fault mutex held.  Therefore, no more mappings to
+ * this folio can be created while executing the routine.
+ */
+static void hugetlb_unmap_file_folio(struct hstate *h,
+					struct address_space *mapping,
+					struct folio *folio, pgoff_t index)
+{
+	struct rb_root_cached *root = &mapping->i_mmap;
+	struct page *page = &folio->page;
+	struct vm_area_struct *vma;
+	unsigned long v_start;
+	unsigned long v_end;
+	pgoff_t start, end;
+
+	start = index * pages_per_huge_page(h);
+	end = ((index + 1) * pages_per_huge_page(h));
+
+	i_mmap_lock_write(mapping);
+
+	vma_interval_tree_foreach(vma, root, start, end - 1) {
+		v_start = vma_offset_start(vma, start);
+		v_end = vma_offset_end(vma, end);
+
+		if (!hugetlb_vma_maps_page(vma, vma->vm_start + v_start, page))
+			continue;
+
+		unmap_hugepage_range(vma, vma->vm_start + v_start, v_end,
+				NULL, ZAP_FLAG_DROP_MARKER);
+	}
+
+	i_mmap_unlock_write(mapping);
+}
+
 static void
 hugetlb_vmdelete_list(struct rb_root_cached *root, pgoff_t start, pgoff_t end,
 		      zap_flags_t zap_flags)
@@ -408,30 +496,13 @@ hugetlb_vmdelete_list(struct rb_root_cached *root, pgoff_t start, pgoff_t end,
 	 * an inclusive "last".
 	 */
 	vma_interval_tree_foreach(vma, root, start, end ? end - 1 : ULONG_MAX) {
-		unsigned long v_offset;
+		unsigned long v_start;
 		unsigned long v_end;
 
-		/*
-		 * Can the expression below overflow on 32-bit arches?
-		 * No, because the interval tree returns us only those vmas
-		 * which overlap the truncated area starting at pgoff,
-		 * and no vma on a 32-bit arch can span beyond the 4GB.
-		 */
-		if (vma->vm_pgoff < start)
-			v_offset = (start - vma->vm_pgoff) << PAGE_SHIFT;
-		else
-			v_offset = 0;
-
-		if (!end)
-			v_end = vma->vm_end;
-		else {
-			v_end = ((end - vma->vm_pgoff) << PAGE_SHIFT)
-							+ vma->vm_start;
-			if (v_end > vma->vm_end)
-				v_end = vma->vm_end;
-		}
+		v_start = vma_offset_start(vma, start);
+		v_end = vma_offset_end(vma, end);
 
-		unmap_hugepage_range(vma, vma->vm_start + v_offset, v_end,
+		unmap_hugepage_range(vma, vma->vm_start + v_start, v_end,
 				     NULL, zap_flags);
 	}
 }
@@ -504,14 +575,9 @@ static void remove_inode_hugepages(struct inode *inode, loff_t lstart,
 			 * the fault mutex.  The mutex will prevent faults
 			 * until we finish removing the folio.
 			 */
-			if (unlikely(folio_mapped(folio))) {
-				i_mmap_lock_write(mapping);
-				hugetlb_vmdelete_list(&mapping->i_mmap,
-					index * pages_per_huge_page(h),
-					(index + 1) * pages_per_huge_page(h),
-					ZAP_FLAG_DROP_MARKER);
-				i_mmap_unlock_write(mapping);
-			}
+			if (unlikely(folio_mapped(folio)))
+				hugetlb_unmap_file_folio(h, mapping, folio,
+							index);
 
 			folio_lock(folio);
 			/*
-- 
2.35.3

