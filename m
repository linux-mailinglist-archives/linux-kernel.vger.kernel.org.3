Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26F6051EF99
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 21:13:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236615AbiEHTHD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 15:07:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377143AbiEHSir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 14:38:47 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B699BF56
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 11:34:56 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 248D6VvY023694;
        Sun, 8 May 2022 18:34:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=1edBkXrPYSIeWQvKJh3hL3dqDZLp494b2AwpeIg02dk=;
 b=Ebyl4kndwn/9atry46MW0G2uldYlgcVxDMn0XQSV0VpefEzpERN4ad2yL1CU3SjADjVS
 j88m3KzbbjdiDy2KShTKc4abfTKarZZDdMYeuW0XnKgK0ByC3C0a4v3lDeOTWcx+2z2V
 BhJF0v3+E2j31JF+PWG0T3AZPBTCk1tvS/O2XPqCkdkHG7uzQbiokcenuNJdI+BNMa/Z
 SURpJMqBtcEfsPLkUUkqC0nPyHfFLAei/3psOfdgDJ8CbzRwZ+CnxbKHqPo6KwkPvrOd
 P4wAT8Q9Go+CqkwO/to58IZ9/5qQMYVIuruwpOJIyTdTz+jLCQ5qSuGhwKiVmdPkRPuk cA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fwhat9qrs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 08 May 2022 18:34:40 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 248IU5pa005107;
        Sun, 8 May 2022 18:34:38 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fwf70vjkg-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 08 May 2022 18:34:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hRiaIlbngmTTZ86rq/frmi1FDh2d4SXAL8OSBKD9ZtA/kThZ5gQM2Jp5VQBUJ+Kf1EBESXsk3OLkSmqWNjLJ41ZsE6jxRPdMxrfEhIMQaS6XKLzfnTrOGwFR4Ll9UHi9ejBg1wVaH9XSrhckrGoOMmjUN48LhGL/TqX/I3LCT8j5YvjajikoZ64IhhXhIsbKnVl2G30j2Xy1BQ68WNzu2VOZAwEf7B1Vw47+smW10oDWOcJPOBYq7oF5g1BDSRKWDlRxD0G1IaivOAauxFa9zh1DRebOZr9XXC4STNQ8L8mlcqpoVFn6jPbfSDWtfPt57bd48r2v/tV7G7E/KzyKxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1edBkXrPYSIeWQvKJh3hL3dqDZLp494b2AwpeIg02dk=;
 b=UKusrdDIxz5vUZ1BtTZxtEGo3uuRxnSZj5cbK/oEqXFO5vFC+z9CcmARZFCdMatVtZFyctd8lKsQcjJ9XZkFg63BkrdkZetoisF51NvPn1mCL01tBFpzHJdrgaz3jHcZ16KUOobPMoM2B5COAPt89GcatPgobVgJLEHftYpb7qvhaeEqPWiRMjc+7CNtcrPPmRmt/qFo0xw863MLtobrhGMFDyq5XWSvThN05iq9HWECwkcQSht4zk5p2An7AYOb+WOtQ7YCUKAEx2VYH40mXxeZETJbLjYO4v6LiNucGd2yT6dnuS/Hd/v2W/GEb1S3g9Vq0YqozZjqFFprTIYPaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1edBkXrPYSIeWQvKJh3hL3dqDZLp494b2AwpeIg02dk=;
 b=APeQ/ZaTg171e6vl3QXhsVcRWLepPU+8aAGWbEiCKCj+o7ri0wa7FB26wCqqSBLL2WiO9a7kF8HWydTbrLs8qZOXt7K5mPQK77M7p7pBbyKBn98+SPvpAC2SlMr4voGMN/U5R20jVOKI6l/1Gbedt96lHWwYS/z8AyYVJFidhPE=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by MWHPR10MB1485.namprd10.prod.outlook.com (2603:10b6:300:25::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21; Sun, 8 May
 2022 18:34:36 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::9d76:7926:9b76:f461]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::9d76:7926:9b76:f461%9]) with mapi id 15.20.5227.023; Sun, 8 May 2022
 18:34:36 +0000
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
Subject: [RFC PATCH v3 3/8] hugetlbfs: move routine remove_huge_page to hugetlb.c
Date:   Sun,  8 May 2022 11:34:15 -0700
Message-Id: <20220508183420.18488-4-mike.kravetz@oracle.com>
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
X-MS-Office365-Filtering-Correlation-Id: 22d97d0e-238a-41e9-ba3a-08da31216788
X-MS-TrafficTypeDiagnostic: MWHPR10MB1485:EE_
X-Microsoft-Antispam-PRVS: <MWHPR10MB14859FEABB2640930E61F8B9E2C79@MWHPR10MB1485.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 95zf2ZN6Fay0vL8iIEd3aK3QmZZ4crDj6KmGDiZX0BlqJp+8G+FcggYYKLL0s4nkctiBfViIqJqbUyGdyNmtSCJ8ROb2J7jlsbYs8nogoJfEzg9Sqki43aVuMbGdGyKmUn3XP1C+TKHvwFZ2WSyVIPtxqh/JsfJ24etioEv88XMgZqbKDtb82yB3teB2MIbqqFO9/4MaqWXcZXD8AhMf7e5bEnbfbwOLSGwyHBVgKi4svhl+I2R9Rxcp8A5f8CULubs91BFC9aMEtnlDXcRWQEl8lYdhCCB9j7IPUTo17/3fSUg7XrG67rB+Di2lfP4Adt46qJGOekiJ6bN104Q0u21RDOQYgGn/mqOJ7oa3ZVCrYQALltD3Pa+WujnW7Dl5KiJZi8h8RbyLctkQYIFuLdTkX0kzaO7Oqsyn1nxklVrqEjMt0aCHjRhPKfHRp3T7PjhIWLcWK9Ya0xmVAm422RbLM6FahqnaB2CBhWwfQPHH5lyfzOC2/QAU99GS6KMK+gSi1EdTnDe2ZEqkVVIPP3RoK43ktgcaFupeA9CoXAy/f8gxwThkX1HNjPa63HpBtHBm8sjnTyGZ5hnJfuJK9KPI9I9iW2C7U+9CuOS9UF7m49gMiTrZsl//0Pau4GAv1dsR4jw/kiFNNm6zHZkpxgg9lQ7NS5UyeSm9mAgB4M6gkunVkJHJg0j0t/oPGljIaGsTUd+B3a6kJ4UlYJ/mN33tLDXGfde5sMf5ZcsolHc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66946007)(66556008)(66476007)(2616005)(86362001)(5660300002)(4326008)(6506007)(7416002)(52116002)(6666004)(6512007)(26005)(8676002)(8936002)(36756003)(107886003)(186003)(2906002)(44832011)(83380400001)(1076003)(508600001)(6486002)(316002)(38350700002)(54906003)(38100700002)(14583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wYqE6004OiBM764pJ0UeCCAshsSuEOBEJZgAKVRuR+llk+4FcwqGoxm+ogU4?=
 =?us-ascii?Q?dozUqIuTLjEcaqp6Vnz5KPz4jnfKRktdQ86G2t5oplAdfENGNPeomjf5oHD+?=
 =?us-ascii?Q?MmW8cRpgtKwN9scZo1ksN7SqrrX1C421UAEHVu/pQVbmVi6UiVK6JoyrFTq3?=
 =?us-ascii?Q?qPV8hNp/et8e6sP5wP8O1aVtg7MoVNTVfCCX1I5OvuBvUElLL6lC2o6qcWWA?=
 =?us-ascii?Q?T/C8tTwWCOQ2H+5s84Uj02RpCZo1KRhr96/xCxTOgaatLcvqKfv6KBbcR7jR?=
 =?us-ascii?Q?/WTdHsbylGSaYG+WIZNgCx+MEuTmqM0egXtUsz8WXSb/LjG9TfWUcrzuQjpH?=
 =?us-ascii?Q?R/JOuVK8uisCfrH3B1F/2pb3Rmcg8t2fWTUn5IUo7oNOJ3UKgVYDeFS9Q/9Z?=
 =?us-ascii?Q?UyyW4x4pwYr7kxDC7cYYPKy1foFSzEgAI1HS2fhSovO6Ay4EcHuRHWyB0i4y?=
 =?us-ascii?Q?q9LeTX+ONPLeL3ZV+TQJ22B1N9WkrHN9lQSgRiMMdzOzg6Rr8Gt5tWgDeu+3?=
 =?us-ascii?Q?AEtWQGD8cTgD2gbT4drHUeW2mVHE5lIxlJdd3I9GVv3bdYDLMXQ2RHrzr81T?=
 =?us-ascii?Q?irDt01duuQbZzo63TOrQtId3c6JocqcVw6wxpffQ2EhEDzOkSPWwisE32jgA?=
 =?us-ascii?Q?fXxZcBL+mLVa9j7qwWLNF+5v9XVObFvqVz9FD6I3pR4U/WJntSZriB5ihADg?=
 =?us-ascii?Q?a6ojrhZuZgOmVIAyIJHrUj68FuuBP835GL96jtm345PvxonGS6ZhUA301Jos?=
 =?us-ascii?Q?ojAERpcvVBLZZUwEStsuc5aOt34mqt0vCRjvO1JDte+DnLFGi+YT0KDK2Akt?=
 =?us-ascii?Q?d7CBpk733r43yGJoTG1yb6IbIFY1zhZ6+C3UQRMHFykt7+Ex2RraPsKP59u2?=
 =?us-ascii?Q?ssyjmMflqmaOjkKm+H+xsT+GFRtBKp4pUaB+KB1JkLTm8IK2vpaHZFDrBnfN?=
 =?us-ascii?Q?/1P/5y2MrbJtJtK5q2rBTdi/r0qt+VsEz1oByF41EXOxWIgnPoR2MDVsE7NW?=
 =?us-ascii?Q?XtYTlcPd94TP1pfkM057qT1yblDAk1ra5U5ubrOIRiE1ikxkGrzn1zYUuG7N?=
 =?us-ascii?Q?JvZzP7NX/5bceQbAD+e/9u+RAxoQaa4R/666fEZ/sNx/eOESY4rl4eUzDTKJ?=
 =?us-ascii?Q?xgViktct2WEFOwvPmbfkrcWMn/WP6eXP98+jhpXlJP0BVIb4Rr2aagU49xUb?=
 =?us-ascii?Q?Yo89Q/M8zleEXlyyP0uoD7a5IlPDBExTh9lDaL5YKac3cYZhkmyK1MplYtp4?=
 =?us-ascii?Q?IUBNh18tNTRbN1/F1NL21+iVNE88oZPb8/2qsOK3xJQtPxbqDhnkKuTdYaCp?=
 =?us-ascii?Q?FUADpkMwO/FMFg7Kot06KRW89wnUYNZJx47pkwh+oPLd0tkslmiEm6KuCW3Y?=
 =?us-ascii?Q?3krUAghp/Arijx6R2oS6yfz1egjDCmqHobYiXen2SmfMdoE4JGpJbGTMffmU?=
 =?us-ascii?Q?SW8/BaFoOOB9OZPVdMF+mc6d9UN7hQY/13bu7x0tRHWIWgip3e9z8AtpMHQ9?=
 =?us-ascii?Q?72XB5pPG8oCSalpawBQkFMz58v99ugFl+4VRW209qy9jqDyRmTmubx1Py6QZ?=
 =?us-ascii?Q?GaQ/+LMZjaGQloOYAFO4PgGg3cUoxBGn72ijPLcBmojjNRbTOj7YhDW+8Vmc?=
 =?us-ascii?Q?JNXXrrpL2DlSiECSGYpNp9vKT+L4x4ieZ/et1XKIjlAGAbLVktaSP3s+ibto?=
 =?us-ascii?Q?zF4XCe/UXa0LYmYm6jKCA04bQK10o6OA+YFOc0kGbGMXlqhOYJIycn/+m/1J?=
 =?us-ascii?Q?E7toKS0GYqkeGTvNzeEOih5Xig9bfgk=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22d97d0e-238a-41e9-ba3a-08da31216788
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2022 18:34:36.8603
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iLnQNqKpoOXwu9L6BTNDjj/XOM65ZZTNyMg2AYmuwwPcXhlNET/tE2Yssi07WUMTtkvax6hRA0QF8Tlu5QhS/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1485
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-08_07:2022-05-05,2022-05-08 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=916 adultscore=0
 spamscore=0 phishscore=0 suspectscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205080121
X-Proofpoint-GUID: cG7dilfZey0VVJO1p2kQLfTqfYVojD8v
X-Proofpoint-ORIG-GUID: cG7dilfZey0VVJO1p2kQLfTqfYVojD8v
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for code in hugetlb.c removing pages from the page
cache, move remove_huge_page to hugetlb.c.  For a more descriptive
global name, rename to hugetlb_delete_from_page_cache.  Also,
rename huge_add_to_page_cache to be consistent.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 fs/hugetlbfs/inode.c    | 24 ++++++++----------------
 include/linux/hugetlb.h |  3 ++-
 mm/hugetlb.c            | 15 +++++++++++----
 3 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 0979eebacaea..96ff9ba2b4ba 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -397,13 +397,6 @@ static int hugetlbfs_write_end(struct file *file, struct address_space *mapping,
 	return -EINVAL;
 }
 
-static void remove_huge_page(struct page *page)
-{
-	ClearPageDirty(page);
-	ClearPageUptodate(page);
-	delete_from_page_cache(page);
-}
-
 static void
 hugetlb_vmdelete_list(struct rb_root_cached *root, pgoff_t start, pgoff_t end,
 		      zap_flags_t zap_flags)
@@ -517,15 +510,14 @@ static void remove_inode_hugepages(struct inode *inode, loff_t lstart,
 			lock_page(page);
 			/*
 			 * We must free the huge page and remove from page
-			 * cache (remove_huge_page) BEFORE removing the
-			 * region/reserve map (hugetlb_unreserve_pages).  In
-			 * rare out of memory conditions, removal of the
-			 * region/reserve map could fail. Correspondingly,
-			 * the subpool and global reserve usage count can need
-			 * to be adjusted.
+			 * cache BEFORE removing the region/reserve map
+			 * (hugetlb_unreserve_pages).  In rare out of memory
+			 * conditions, removal of the region/reserve map could
+			 * fail. Correspondingly, the subpool and global
+			 * reserve usage count can need to be adjusted.
 			 */
 			VM_BUG_ON(HPageRestoreReserve(page));
-			remove_huge_page(page);
+			hugetlb_delete_from_page_cache(page);
 			freed++;
 			if (!truncate_op) {
 				if (unlikely(hugetlb_unreserve_pages(inode,
@@ -724,7 +716,7 @@ static long hugetlbfs_fallocate(struct file *file, int mode, loff_t offset,
 		}
 		clear_huge_page(page, addr, pages_per_huge_page(h));
 		__SetPageUptodate(page);
-		error = huge_add_to_page_cache(page, mapping, index);
+		error = hugetlb_add_to_page_cache(page, mapping, index);
 		if (unlikely(error)) {
 			restore_reserve_on_error(h, &pseudo_vma, addr, page);
 			put_page(page);
@@ -976,7 +968,7 @@ static int hugetlbfs_error_remove_page(struct address_space *mapping,
 	struct inode *inode = mapping->host;
 	pgoff_t index = page->index;
 
-	remove_huge_page(page);
+	hugetlb_delete_from_page_cache(page);
 	if (unlikely(hugetlb_unreserve_pages(inode, index, index + 1, 1)))
 		hugetlb_fix_reserve_counts(inode);
 
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 306d6ef3fa22..e8e837c15eb9 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -655,8 +655,9 @@ struct page *alloc_huge_page_nodemask(struct hstate *h, int preferred_nid,
 				nodemask_t *nmask, gfp_t gfp_mask);
 struct page *alloc_huge_page_vma(struct hstate *h, struct vm_area_struct *vma,
 				unsigned long address);
-int huge_add_to_page_cache(struct page *page, struct address_space *mapping,
+int hugetlb_add_to_page_cache(struct page *page, struct address_space *mapping,
 			pgoff_t idx);
+void hugetlb_delete_from_page_cache(struct page *page);
 void restore_reserve_on_error(struct hstate *h, struct vm_area_struct *vma,
 				unsigned long address, struct page *page);
 
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index c9eed786df00..003df6cc13eb 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5370,7 +5370,7 @@ static bool hugetlbfs_pagecache_present(struct hstate *h,
 	return page != NULL;
 }
 
-int huge_add_to_page_cache(struct page *page, struct address_space *mapping,
+int hugetlb_add_to_page_cache(struct page *page, struct address_space *mapping,
 			   pgoff_t idx)
 {
 	struct inode *inode = mapping->host;
@@ -5393,6 +5393,13 @@ int huge_add_to_page_cache(struct page *page, struct address_space *mapping,
 	return 0;
 }
 
+void hugetlb_delete_from_page_cache(struct page *page)
+{
+	ClearPageDirty(page);
+	ClearPageUptodate(page);
+	delete_from_page_cache(page);
+}
+
 static inline vm_fault_t hugetlb_handle_userfault(struct vm_area_struct *vma,
 						  struct address_space *mapping,
 						  pgoff_t idx,
@@ -5505,7 +5512,7 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 		new_page = true;
 
 		if (vma->vm_flags & VM_MAYSHARE) {
-			int err = huge_add_to_page_cache(page, mapping, idx);
+			int err = hugetlb_add_to_page_cache(page, mapping, idx);
 			if (err) {
 				put_page(page);
 				if (err == -EEXIST)
@@ -5914,11 +5921,11 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 
 		/*
 		 * Serialization between remove_inode_hugepages() and
-		 * huge_add_to_page_cache() below happens through the
+		 * hugetlb_add_to_page_cache() below happens through the
 		 * hugetlb_fault_mutex_table that here must be hold by
 		 * the caller.
 		 */
-		ret = huge_add_to_page_cache(page, mapping, idx);
+		ret = hugetlb_add_to_page_cache(page, mapping, idx);
 		if (ret)
 			goto out_release_nounlock;
 		page_in_pagecache = true;
-- 
2.35.3

