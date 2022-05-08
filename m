Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89ACE51EF7E
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 21:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239792AbiEHTHt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 15:07:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377781AbiEHSjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 14:39:53 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D7ADDF40
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 11:36:02 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 248Cqh4U013766;
        Sun, 8 May 2022 18:34:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=MnZ8xYIbnWTcvFQu6FcWB/zUlw6GtNFzEsbfuht6/PQ=;
 b=QexmCySAZV6Y+1RGwxCyDiwZDSToUCeWu4UzbBEBzO2EKptYX6+PKH+ucSoDd34v0eOw
 n7S9UogLjRXFNWh3D71zRH7wLqWUAmMWlRuqaChWz/vgA8BN6tUme/t2yHs+ZZdM/rMr
 iXi+aH7avqK9O9f2DxVOC1wn6K+Q7U1DMr1IfhDURyKWyzHuSs5QUKQH93LNp1tO4nGH
 nTLuk3zixhJzsiCqF/8sJq1nKUbLFZFJwdsSecSrIXMIh4aQgzAiLmyhN6ihFXPMajSu
 n3CCsc2xyYqxmJNU7xQyOrEOMAZgb1k6E1qCHnJnFXoe978NjbjuF+quqWx52EX9KY1Z XA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fwgn9hrgb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 08 May 2022 18:34:46 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 248IVVqA038203;
        Sun, 8 May 2022 18:34:45 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fwf70yrd5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 08 May 2022 18:34:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P+hEjP1FCZb7Mv05hmz3mLGMNREZ7kaJYrALB0VeSHyAUKqSWbnZq8gE8b9NtTuVGXhboiWBTyWDa8ZX1e507ruvauXSF79bL5mfffhRz9Sc0OUa/vMNkSZwCq6KEzjt9AnZ/1Rq+IlmB3rkp+IZsMRB3uq2bJjlJsSXKPpwBK5DiufKP99//tmAhf0qt6c0IaHSoe6E+NtNkMldlwKKL9QcWUhxoje5y1iCP9UbW6YVA5IVpIdAIYWAHm7h/M2EZfsE543v51A1C8A5/W4xbiiIx0PC2dTm1sXEhGhm5CN2HpWXvmz3IbpSW0H1NSUFo/hDzr4KE6NFyNxglgQP6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MnZ8xYIbnWTcvFQu6FcWB/zUlw6GtNFzEsbfuht6/PQ=;
 b=Qi2NIWS/S1r2s8Y+rgWmWOH4U9XSTbOAlf6CTU4rKJvmyLmBBFB8dCzmWufsOo28BLxmaX31GqJjszk8caS/KTahLZeL2CAqeIECrhnuLWjfN4g6c2M5hiNSdK/U3ix4KcxITP1UluplpoX3NQgPv/eiaIvLJH84VrZJoRIK++LW6YSzP8BenN7lotqQQzr3iAcwiwY9T38J4AqGKcVcnIU4SiZ1bl7XyrGtXaFwRDU5FYJ6VBUInBIg9GfrFeFWs+a5B3pTkEX6FySW26Y+U7CxwJXT1Rh/0WGzQUE1pu2KdD2JEY9QKdy0mE0Ll93/LSJCZHhajYTzmR/zYoaPeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MnZ8xYIbnWTcvFQu6FcWB/zUlw6GtNFzEsbfuht6/PQ=;
 b=Y5OTvIPl87OkEWL1C6+6iUT4wAteAwF6apdxhkwzT8Z9pjq2Rd1Cve0ixWmKnPPwHpoLHA+gVTA+shLDNodxvYad+o4wL+Ch2CLWGxSjKZFc3Pp3O/a4+BZfm3XEXTfRBLxIzJQ++6DLwCHhZY+xOSAwpg5lQI8M2yQox4LejZQ=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by MWHPR10MB1485.namprd10.prod.outlook.com (2603:10b6:300:25::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21; Sun, 8 May
 2022 18:34:43 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::9d76:7926:9b76:f461]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::9d76:7926:9b76:f461%9]) with mapi id 15.20.5227.023; Sun, 8 May 2022
 18:34:43 +0000
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
Subject: [RFC PATCH v3 7/8] hugetlb: create hugetlb_unmap_file_page to unmap single file page
Date:   Sun,  8 May 2022 11:34:19 -0700
Message-Id: <20220508183420.18488-8-mike.kravetz@oracle.com>
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
X-MS-Office365-Filtering-Correlation-Id: 18496745-5620-453d-e295-08da31216b5f
X-MS-TrafficTypeDiagnostic: MWHPR10MB1485:EE_
X-Microsoft-Antispam-PRVS: <MWHPR10MB148503B333C639E7CFC56D27E2C79@MWHPR10MB1485.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qacJRhwdabm/EgFOqDm5Tz0+KSCC3gtbxlXohDrCbfOVgvQAvAoghHbgrbgIOu4Lh6ED+rt4Fd2JmqfoWjobIUcV5K1pTFyGWAyChiIVhGu+wVMNtB9LAyA0TX76XEj7klUha7LwRDV+gZSxCk5q420MwpuZe6ilHXC+X8Is5a8sUdGcIsfp2QfXhmgIPdNkzlBhbP7LKnblnh2okfUboLj8XH4kirqp5Cq4roYKFNaINzT/UNzVxt5xp44uKnNHdW0YF3gRFDF7sgoMo1aSfeRsi8c5HAqfVFQl1GtSyNVlIH9MNtzRM53N2GzhdxZa1km8LMAHoT+gfTmX4lBCZN+CBVzaqMxGZ2SeG2zd1jLtMZH0EY8qa+d6gj0sBHcuyn1qSQq5nOB658bxpJknpfGOo7AIbX4DtfTtwE/2F0grRMMD7WYcdOhqD2s3p2x8qrkWcbbhlBDsI0ZnCTjGWUIeQAlp6nTQdsSYVdQB5UqDHAZLXIGCB3I0PrlI9siIT1CZ1dSvMih5A8xtMCsz0G43T9tGJG+HRqaYYEEe6dmqmtAgEenoXpZjeqVLw7qSTU+9XhErR/E2YsZstWg4lAxeksSudgnhCvvlkcEPAf8o3tRuy46wIRKTDJfztZqjzpCLo/jSZ62KD3dEefGxJakqaVlMODs2IBMEplfNd9Xj+DTS7dtbZ72ZjHHDHmJ0DOsmK9DmGezOr5JC/GBLnw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66946007)(66556008)(66476007)(2616005)(86362001)(5660300002)(4326008)(6506007)(7416002)(52116002)(6666004)(6512007)(26005)(8676002)(8936002)(36756003)(107886003)(186003)(2906002)(44832011)(83380400001)(1076003)(508600001)(6486002)(316002)(38350700002)(54906003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?I4fVJB/rIyNGMTaZB0MG41LC/6Du5rwT55MUwQSVzv5DPiggjttrgrF+98XC?=
 =?us-ascii?Q?OD9zevwsDzV2fueUOmjwKpbN2XsCwI2T9NTeTXPagbXCTEoTXQQCf1qQgbCL?=
 =?us-ascii?Q?kGQisRerhMVa5EQU5lN/VSfd8cH/C447bfYgSitzoK3RrSN7wBW2ADtwQsNV?=
 =?us-ascii?Q?7joJU3vRVgzah4QYG/G7AFGjXDeHDNZlss7Btn6BLrXZg0A+9DuelU8WK2oG?=
 =?us-ascii?Q?1R0/VWLUrheUVTKb0S7hICfyXeIV5/gp9YG5zgtqdM+VFBdVwM94iJOvN6CE?=
 =?us-ascii?Q?aviJgWgN+PvLluteqPaXl5beT1OBLjhT8XVlGXqJLGRXwAbLuepKPeN4tNlx?=
 =?us-ascii?Q?aiA6Hdxy0tAcIFeWRx017uCzHGFTzjKEKUFcYh1R8Lx8TCraQ8mwlUbRb2mL?=
 =?us-ascii?Q?n8ocESgVRPXJFRZF+bHHH/XMKlzdKoAbezCNqfxNr+629X7ZUr+l/3w/ootT?=
 =?us-ascii?Q?ThQCO9m1Chsr5C3LW9Ke/NEGB5Shln4WLWZhm2Wf3ZKBHFt69l5JtjEH4X49?=
 =?us-ascii?Q?qigcNFREczj6kK4efrwv95/Flo89ucFrdZPgO3ZhW8g3NTpVvyR9JAHvDVob?=
 =?us-ascii?Q?ez5OTPuypZLg25HxiFNAKG4/lhUyoQLnZtxk0XozQFIHqPzzyPjF812OrNqX?=
 =?us-ascii?Q?INWRXcfqmMFtUTKQog8e6vKTjOUXIKtfiKaOIvxSG+dttWmImq6hWCXSijZa?=
 =?us-ascii?Q?gdZroqo9Lzi8CXHo1g07Wv+GyIwmtLGeEL0MROZV0MV5OMB5n0uHwqp4+90S?=
 =?us-ascii?Q?rpZ70gn62cI3S5UwFLPbMVrDiWbTe60bMqIcXJ/nRTAIZIlEfKxJklMqNrua?=
 =?us-ascii?Q?SvRUxV1WLUemUHU5CoF5SSjE9CBT/RQJNg3k1y0lGSLRkvhDnuYFJzJmMg3F?=
 =?us-ascii?Q?jeCa6EjogZifJdJKATcAyfflkbgPpvDD3Pzr1CXTJzDT9JbmGs8Jxhr5NGGO?=
 =?us-ascii?Q?vQvwUUykUvpAlnJ8qq9WK+a6F4x0rE+K8afELnS0wgcDlBdwSucMhHjSMPQI?=
 =?us-ascii?Q?jN+dqhIQGGZTT9lOObpa33bKggvDG8TyxZjx0KjKazaAn+LaJ13G5CgD/V+X?=
 =?us-ascii?Q?5MqTfz5rm8rBAN0dhqKirNiWf61W1jhyY1yxpNIgXi4NUuQKPRzKfDqAqid9?=
 =?us-ascii?Q?ouLAfV+/zM4Keog4h+TvZvEjJkuCwk0j9TlB9Uht+3tXD7/0HanIR0jYbDM/?=
 =?us-ascii?Q?qINzuNtVs5BVsYx6OoHRh6mFwWwo235vZxujOOI3aW/gaGMOtdhbdt03FfXs?=
 =?us-ascii?Q?GawWazoNrNZkplejarkGabKTolStntJKcZPSTgkx0Qd500ZsNVBR27ha0mgE?=
 =?us-ascii?Q?bfwn5iFJLeeTxcPZqwi+e5yxCEREoyN9/71bDWNytCx26rmbinhPj0vlaynI?=
 =?us-ascii?Q?qEfGYR5S3uoidUr/dtUG1O+3kcRzHV/zpZZASmDNDsh0jorhwdj14Dz43suz?=
 =?us-ascii?Q?ouB+DCVThIakfbQZHwHU+aqPwBbuFtNoT1h1/WV6f1LWGxlXfVavN5s2iGFy?=
 =?us-ascii?Q?b++q3e4kv1ARADQfFpxJ8Oqf1XLtAWQpFIJesqdQ7rP+qd/Z+TQecfqVTG40?=
 =?us-ascii?Q?mgfkzFNUOkSjpXpb+RTLA2cGWdE9R2JVZubS2SKvjlHimAoikyzWwNKjneGN?=
 =?us-ascii?Q?O70EfxCc+M6Y+SVu41FlDKi0lCEZoVM22Nko178Pw+HFYcXnNZU7dwzCMmc/?=
 =?us-ascii?Q?Gnxt3M+5TMihnQQRqdUxHmH+MBErNEhPNHNDTk4MH3Kt9LXWGOio0OVcXKqt?=
 =?us-ascii?Q?e0gAy9imW+YT7+k971INgBBHBl22XeU=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18496745-5620-453d-e295-08da31216b5f
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2022 18:34:43.3348
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mg1+C63xkv9NbKUYi+BVxeVR9FoJWm+eL/xB1BRFv5lGOUnYw06y3QErQIy1wKPSNU+aAKOdY3k6WvWDtzBwYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1485
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-08_07:2022-05-05,2022-05-08 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 phishscore=0 spamscore=0 bulkscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205080121
X-Proofpoint-GUID: sv3jMHwyWmCzLOnqvwp3WgvibT2dM0tw
X-Proofpoint-ORIG-GUID: sv3jMHwyWmCzLOnqvwp3WgvibT2dM0tw
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create the new routine hugetlb_unmap_file_page that will unmap a single
file page.  This is refactored code from hugetlb_vmdelete_list.  It is
modified to do locking within the routine itself and check whether the
page is mapped within a specific vma before unmapping.

This refactoring will be put to use and expanded upon in subsequent
patches adding vma specific locking.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 fs/hugetlbfs/inode.c | 123 +++++++++++++++++++++++++++++++++----------
 1 file changed, 94 insertions(+), 29 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 5645353a9744..d08520a87dcd 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -397,6 +397,93 @@ static int hugetlbfs_write_end(struct file *file, struct address_space *mapping,
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
+ * this page can be created while executing the routine.
+ */
+static void hugetlb_unmap_file_page(struct hstate *h,
+					struct address_space *mapping,
+					struct page *page, pgoff_t index)
+{
+	struct rb_root_cached *root = &mapping->i_mmap;
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
@@ -409,30 +496,13 @@ hugetlb_vmdelete_list(struct rb_root_cached *root, pgoff_t start, pgoff_t end,
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
@@ -523,14 +593,9 @@ static void remove_inode_hugepages(struct inode *inode, loff_t lstart,
 			 * the fault mutex.  The mutex will prevent faults
 			 * until we finish removing the page.
 			 */
-			if (unlikely(page_mapped(page))) {
-				i_mmap_lock_write(mapping);
-				hugetlb_vmdelete_list(&mapping->i_mmap,
-					index * pages_per_huge_page(h),
-					(index + 1) * pages_per_huge_page(h),
-					ZAP_FLAG_DROP_MARKER);
-				i_mmap_unlock_write(mapping);
-			}
+			if (unlikely(page_mapped(page)))
+				hugetlb_unmap_file_page(h, mapping, page,
+							index);
 
 			lock_page(page);
 			/*
-- 
2.35.3

