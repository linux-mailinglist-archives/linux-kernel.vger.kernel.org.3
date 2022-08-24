Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E45B25A00EA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 20:00:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240399AbiHXR7V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 13:59:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240390AbiHXR6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 13:58:54 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FD8E7393D
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 10:58:48 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27OHkmI5023702;
        Wed, 24 Aug 2022 17:58:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=uEL2h/a8wus2bTuGqexO7huRxlaSkSg+XS0O4TCJXZc=;
 b=xxBUvbCzE/V0Biru3SqsLKqbs6CQxkgZj5U5ZAepqkb4HcSHr6a0pFELSDNAp4rjm0R6
 TGw7HJMwh7iXLqbNyU6IYFwu+CfCXwo4pdxk44LHnAMrqAWi86QtBC+7rLYqXMyc3MN1
 93R/23i7gIHPhyNQn+v/cWWPXkI1DgAcPSB2sQlrUV2dq3IUlrJkeCXPnRF7Vt9AMJEX
 sxxtKp6s2frxigvT0ACU8l9qLX0j1PAvGdcjsFEhJVF2TKeNCAO2sWTrcFGwE5mqa6d4
 ghV5E/a81a2fJHFmEZ4UWPH7xwLxGnGDcHqcbGpMmIO+eB2d2vlj0d2Z4tleGhWgSgsI ZQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j4w25m8ss-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Aug 2022 17:58:27 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27OHBoq1021835;
        Wed, 24 Aug 2022 17:58:26 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2049.outbound.protection.outlook.com [104.47.57.49])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3j5n5nbghb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Aug 2022 17:58:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IkZdSKLjB9+oet9wSAd1SiXTc48w4Lc6m4mS8QX7M1zV7OCxPQ1jLUWj4E1F4WJyJ83jdAg+sjERGFfBQ/7w2D1Vwsshzf49GayQiYbRLVvJrfDHzwNci7pIA3SeriiI2kFOs1jLXbaDsjRcidwGuNQPhS1avxUApD5WmyWONCSVTsNODR3h8EGpPmIDxyG6dJGmJKF6oSzM1T9DISc2qX+FNPxkIUkFNqZ/ObR58lSVa32orM7TzmjxfAldPa7quluSZeKtyaWHl8/FBEosU19LbpfgxXlAhse7GuG9aJ9OAXZ/C8jPeWiabjWGPu+7tglotZpXECnxjwybqmk/vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uEL2h/a8wus2bTuGqexO7huRxlaSkSg+XS0O4TCJXZc=;
 b=UIFaABeYOjR0nt1ZJfZl5z1pow67mg3et28JTh0H5aumGfagiszppuScC90HyC2U1zdbXSMhrLs7xX/gnNkDLzgCs0i1SdR9vScgswA4MUHxLzJD+AkB1WEKWA2uTeJFLUl7GLv8SVZnFfVcYrFeQioYB+szeWqz8KywPIYhwVGZAh8HEjLs3G1C7RV7cuhf72D99+xETfvgKW6f0UKktXMn/NmNS0UGoy/9nj/c6Pk9sVyCmjQ4x2ZKQwMdcFETWTgtEZMthv+pyH5kJ0RB6X7yEoqG3tstms6V1lsPdPhNHXQHUcaSmvuTtWtAlgmvSqtnmTjnbZpak94NU8SbeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uEL2h/a8wus2bTuGqexO7huRxlaSkSg+XS0O4TCJXZc=;
 b=BqxUz5q3koufSGsjbYQ2UAZGeh0EVwW6O/YJadcxof7nmABDTA9j5mZc3BXl3cKpMEOgRTWxjTDU0iy4zYNzPmhuovyCFQqfEi02KaeZ8xhhz5XtxA0ZQ18xcDO6rNIOvB78Cjy/9JVMzJ8yZGT8KxVLP55MJbDsj6HnSjCVXy4=
Received: from DM6PR10MB4201.namprd10.prod.outlook.com (2603:10b6:5:216::10)
 by PH0PR10MB4520.namprd10.prod.outlook.com (2603:10b6:510:43::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.19; Wed, 24 Aug
 2022 17:58:24 +0000
Received: from DM6PR10MB4201.namprd10.prod.outlook.com
 ([fe80::11b6:7a8a:1432:bec]) by DM6PR10MB4201.namprd10.prod.outlook.com
 ([fe80::11b6:7a8a:1432:bec%6]) with mapi id 15.20.5546.022; Wed, 24 Aug 2022
 17:58:24 +0000
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
Subject: [PATCH 7/8] hugetlb: create hugetlb_unmap_file_folio to unmap single file folio
Date:   Wed, 24 Aug 2022 10:57:56 -0700
Message-Id: <20220824175757.20590-8-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220824175757.20590-1-mike.kravetz@oracle.com>
References: <20220824175757.20590-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW3PR06CA0030.namprd06.prod.outlook.com
 (2603:10b6:303:2a::35) To DM6PR10MB4201.namprd10.prod.outlook.com
 (2603:10b6:5:216::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 167982a6-dc4a-40f1-1052-08da85fa3d31
X-MS-TrafficTypeDiagnostic: PH0PR10MB4520:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZN+AFYmnDgECMpNSpmdHUQHo2naLL5ZtXAcXWI6gJa3NEoi2PzwIHiQzByVQgdHobiusO8Y692AEdRCaNq0asWTj2Knp0UHPeVTY31SpR1rlbJDiXMG5pFi4fEAaOqXNBDg/LC2Svo+A7S23dugrc6w+RvrFpxrUIYCAK00plnP/22I25qKQ1z74JOkvVloJGs3pdh4+jp8qIUVulGFo3OrMnW76s15CsQ76pjM5aFt5nosh9T/M5+Rj6s6YwM2BwU8IKfJd4twrwOqNmSjc7AaXcKAR6gZo2kyaHlFpERrtHadSKQs9XB4wQ5dXPdZNWbmrcp8O2Pl1Z0OUhcI1jeWsahTaT8JqkMW0/Xwfq+GDA5SoJLyrtO5j0uak323sQssVPtAw5+f15wJr+hAT6FJtlo4rBkjkvSy9+7tGZDKz5/9UQpVsfdCXpfhNArCfBqnlS0Wf394mreG11d9xk8epuJS5VkNq92TFlIl4SyNTZsNByMZfgs2oxgMSq1vAxe0UqFiKXOSsNp+GUOksuTR1Lhh9J6NyYD1vakEhM89WEnf7hn+Cu3TaLBuVw4vcESIFZmq9CW4kT79qbQYzk7KlIO1r/CCq3u6dg7AQgqHTno+RKjScudFU4iVp7yxS3P4FlVdRYg7cZ221tRJ7ji+YBz+3m2fEP8jYSZWQTNV4UxukFs4hJ2Xe0lT908L5Gu+FwmyQhGtDqTj/jsEMkA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4201.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(396003)(136003)(376002)(346002)(366004)(7416002)(1076003)(6512007)(6666004)(8936002)(26005)(186003)(107886003)(2616005)(6506007)(44832011)(86362001)(36756003)(41300700001)(316002)(5660300002)(54906003)(478600001)(66556008)(8676002)(4326008)(6486002)(83380400001)(38100700002)(66946007)(2906002)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CCzlgZ2skqvy4/ccAi/uUqGszAEfUSPEVSeVvNsUOht3UTZu3FrZkDsaA2GU?=
 =?us-ascii?Q?2Vyt2DjaW9j4XUtMsz2C3Lt1/BCcltiNoLfT/+RBFdNFcqNkk/2+AvXOprhU?=
 =?us-ascii?Q?J6b5Ugz1peM7iNygI7aq1aBe2s/oOi8QocWer1NIPKT4ZPXaFRdQ8QFs9ajs?=
 =?us-ascii?Q?DKaptTy1+THJFW6w3VJl8iPg2g/9N1Qh2rrtdCVNPhiw1k3KJJvURfUpb8Lm?=
 =?us-ascii?Q?iX++HkUNE1wfa0yUwcBBKTvOLc9o309owl7aQb31A+d+1O7zcjF3LXCHaeSG?=
 =?us-ascii?Q?sNPTXLYVX1Ohp/vA22xTg3XVsZI3vYH9/+dGxrt5dtedA32WDNdpkce79oWd?=
 =?us-ascii?Q?u9JxLnSIrCHlEndPKu19QQvVG6Z1tZQyQURdhEigU/WdixvNKKxaQD8ZARmZ?=
 =?us-ascii?Q?3m0jjlFpXJyr5uEuuAq581orY4QQoQi1Lf+JLWYyvLfxyJntRXPz+ie4typh?=
 =?us-ascii?Q?o9Sbn625Vvxj5yIYT6TuJB7gsoP7KvWRx6aX+Ys88z0Mj8YtkEQ9oQzVU711?=
 =?us-ascii?Q?soWkwaU8duBq8vgr24Bz3hzOoiBKGglIIHDFppQIznd656J4Y9MzN1wx2iic?=
 =?us-ascii?Q?cSZpCd1g4MEHHr5RYWDos3/Blq4+84Rcp+ZYad/I/JnsOV2dFLESO8tNSbxn?=
 =?us-ascii?Q?/mRA32UxyPMB/Ff05KBCpSHR3FUryuQzdbbU3/pinFcwCtA1V66l3gdo2Jjj?=
 =?us-ascii?Q?3geEvxf8vU9yDpniJZgqda8hlibu3809GeAzVbggm5EMbmKoSOV8gZQLvPI+?=
 =?us-ascii?Q?zB+pSA+WzJRX48ycedT0FXTIKUNepKa6HSzqC821OZ3uJm0hM83bCD9hJQ/h?=
 =?us-ascii?Q?hJcHbZvL5NZKeNQO5UPMMLzH+OVLlg5QpbqiKl0ktGjbFd9T9r6PCAHZYHHE?=
 =?us-ascii?Q?VJq6/+X+e67F4S6bxBJsKBmSoNoF7sWI7oHJOy8ITZIDvwh77VKFaOf6Y5DQ?=
 =?us-ascii?Q?/twhnZzWVLZfVeFU2TmwmomNsqhMsE3hrZFSA6OLGysPUkrm+cRN6UTafTp3?=
 =?us-ascii?Q?A44QgsVplXVz34Mhwgj9pJR2G7iJFMrl3fJhnzziGC659CtxbfJNDOquytZK?=
 =?us-ascii?Q?Z+QIaRy35xBbgeVSgArt+2giFcPbLqquIOHn3tJh2TvQor74p9tPoMIHWyzB?=
 =?us-ascii?Q?JqTaUUuNQLNr+JBM5lnB932Wr8eWRerjsrfubh86sKdyIv3TkMoOMBepRH8k?=
 =?us-ascii?Q?XA26yZ+7NSl+HZ/FAWzGJ61YEbNz//HFSTSL19HWJYjFciYY80wKxyg+/yjI?=
 =?us-ascii?Q?V2g79F24EMf71GSdmNqrzp69oMiu2+khWOp3pl0KblOB/e4CVTQwYzjCSRIJ?=
 =?us-ascii?Q?yIrU6/K0zR6TpriwNIrI1ZYLhoMUPdJrBLPufYju8YEUQ2/eyIlCtzNtC1ae?=
 =?us-ascii?Q?alVUhwJJUk3C8gUkbKbGS+SYyzBQHKh9TQt//HtTnE3qiP6BhQLmlMzT04Hm?=
 =?us-ascii?Q?Qqq5XN70+pAx7Ne3TVrLCMF9M6+VxVkLDEeXByfqM+5mCVlCkeTLBtghkDHE?=
 =?us-ascii?Q?1BkRnuQl6wQWcWxP2Ik1II/el52jH/mIFA9/Zyy7nKjIi/ltIowdw0cFr8tY?=
 =?us-ascii?Q?bGDcmd0MeWeXeC6U6tIH4kaXPSd6JAiJPrZsoXqnC7q7JCzi3e5iHs9soECi?=
 =?us-ascii?Q?iQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 167982a6-dc4a-40f1-1052-08da85fa3d31
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4201.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2022 17:58:24.2540
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FuWYq/ol0P47WTRVMhVfKAe9/GEHC7zco1EVPf6S/dqh1DUfqyB0AjanH0mAVVdz6sttibfqt6s5bgGcwEZFrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4520
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-24_11,2022-08-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 adultscore=0 mlxscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208240066
X-Proofpoint-ORIG-GUID: RzgMuu7MSrWp9QnOusznSr8mUVlJw97R
X-Proofpoint-GUID: RzgMuu7MSrWp9QnOusznSr8mUVlJw97R
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
 fs/hugetlbfs/inode.c | 123 +++++++++++++++++++++++++++++++++----------
 1 file changed, 94 insertions(+), 29 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index e83fd31671b3..b93d131b0cb5 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -371,6 +371,94 @@ static void hugetlb_delete_from_page_cache(struct page *page)
 	delete_from_page_cache(page);
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
+	return false;
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
@@ -383,30 +471,13 @@ hugetlb_vmdelete_list(struct rb_root_cached *root, pgoff_t start, pgoff_t end,
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
@@ -428,14 +499,8 @@ static bool remove_inode_single_folio(struct hstate *h, struct inode *inode,
 	 * the fault mutex.  The mutex will prevent faults
 	 * until we finish removing the folio.
 	 */
-	if (unlikely(folio_mapped(folio))) {
-		i_mmap_lock_write(mapping);
-		hugetlb_vmdelete_list(&mapping->i_mmap,
-					index * pages_per_huge_page(h),
-					(index + 1) * pages_per_huge_page(h),
-					ZAP_FLAG_DROP_MARKER);
-		i_mmap_unlock_write(mapping);
-	}
+	if (unlikely(folio_mapped(folio)))
+		hugetlb_unmap_file_folio(h, mapping, folio, index);
 
 	folio_lock(folio);
 	/*
-- 
2.37.1

