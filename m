Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E1925A5762
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 01:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbiH2XBp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 19:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbiH2XBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 19:01:20 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB42E7CB49
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 16:01:16 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27TME8xH026015;
        Mon, 29 Aug 2022 23:01:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=8l6ZCaJpwxL/iTuk/4DYOvRgKzzt2D1N368/bYwnIto=;
 b=JYnZKWFoL6lp5JJ0V5gZkoctCP8pBSDy/RRboYUwKkaf0rV+GCTcVMeGsVHk8BiEc6fE
 314EWwQ8yTv9yE3A3VFjTL3ehwWqtMTnaZm5L9M8xtOkIZZbXQ8Xn1rqt0t07siNifNR
 cgveAHiYAZUlNRksjymxSjNRQfck8DS1fXqKrS9FIlX99/qcl1EaZTHERcJkI040B0DL
 5BJu0SevlSiXUEYO+jExd4n36TWakBuwdMPBEt/E5ji0+1YLpZkDKY4Ns3ySr9glu8qb
 hM0m1vgzH9EtUK2UI4VwCbmR1h9C0FZm5v6hpP1fdbd8KtDjesjzuqTR6DwI1evX+xXk 1w== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j7b59vqdm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Aug 2022 23:01:00 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27TKB2aY038170;
        Mon, 29 Aug 2022 23:00:58 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3j79q9c0te-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Aug 2022 23:00:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KxIgVQctv9Up1o1kR4VGDV37imAjZq1H2o/uTQGdHWnbd949ec6z1dA2kLFBeWp8sLYhGoNGQ52qoY/I1m7FbwELvFePR0yGw3PYG3ouVT7Tkw5tTBI2txbIrQW3ktDpWjBXNe1Xlc0VC0ldtRbYbXV5p8tHvMGv1XbjsC0jXMLREO5CYG2HrP0usViv7PLzP+u2c3YV/BWhmiL9/q0bogxKacpydDfsOjExdKwyVrzfEq9U5bPv8aW9E2NnoyqJ60pTNXGrenVCU1xsHDvGiOcpnW48roIk9ZHpgtK7he28IgnLtQkHTz6Ms29/YYbqCAhLgUpE7IL/tQ2w6isbow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8l6ZCaJpwxL/iTuk/4DYOvRgKzzt2D1N368/bYwnIto=;
 b=lezB0MXB9/l4YEWBtLYwQ6FTwAmu1ebFWyiAXyU2SARbGF+HMavfRPw69/yppDcscrjTbe5qGS+oE/8L+gxypwAWCpEGCEVblv/Ehr+RBOpMecuXNxZILjrkNqwAf08TCu8hjWJqXXS0NpAyZfSlzk+lwaarJFclPv5eS+lGOfZgkGcIXoR+CrFz1c2BvU/jgHe/zK1XptmjJrODchhfOPCLfzH+JVNuTpGbMf0ScVZTCGikSfjFu/0hExNxp/JiZW6LCBXLkYxljwj8FiVDDzAt4CAzDLZCUVd6ViSAeNQhayYlqgHqNaOrOUDJpRWCES+gnP8iBJPl76suMzuoig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8l6ZCaJpwxL/iTuk/4DYOvRgKzzt2D1N368/bYwnIto=;
 b=oQvEMc1px/TwLCL2kIEHbtMGHQX/9Bjh6HslJJEq9SEfd/hYSw+NNw3TTf544AqymCQxYxgWC+6xOiQHonOpuOSb8+/3DmYS3oh/PKh6JZeZ6UBsZFf41xju79cCetM7c7vCf12khSARL75yaGEKzmUsIzaGvENWscyiDxVOMGM=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by BYAPR10MB3736.namprd10.prod.outlook.com (2603:10b6:a03:121::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.21; Mon, 29 Aug
 2022 23:00:55 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::e026:dd88:fe66:6ed3]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::e026:dd88:fe66:6ed3%4]) with mapi id 15.20.5566.021; Mon, 29 Aug 2022
 23:00:55 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, willy@infradead.org, vbabka@suse.cz,
        william.kucharski@oracle.com, dhowells@redhat.com,
        peterx@redhat.com, arnd@arndb.de, ccross@google.com,
        hughd@google.com, ebiederm@xmission.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH 5/7] mm/hugetlb: convert hugetlb_delete_from_page_cache() to use folios
Date:   Mon, 29 Aug 2022 16:00:12 -0700
Message-Id: <20220829230014.384722-6-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220829230014.384722-1-sidhartha.kumar@oracle.com>
References: <20220829230014.384722-1-sidhartha.kumar@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR06CA0038.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::15) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1694ca92-c6f2-4779-c538-08da8a12545e
X-MS-TrafficTypeDiagnostic: BYAPR10MB3736:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qXAp4AdMLB8OqhlUZ1O/RZHCwCaqfv0kLkmPl0HcYffpHRMyiWWRp3HYsZ6T9h7y/boUjR0j8H8TrZJ+JF5yqgYmtHVYmSN52J0tvtZex35PClzJ/xHUpbMuLCsbYM4u2u5TY/w7A5vXQ+vhctUTpGlSTao0VuplkddiNdlTmHcGVQBGFEYFN6VLVkz6XfEnX8uPjJWMT1/bUDr+pK5X8wxLu+7IzmLzWzDPKvAkZe41S142QgetBSbBxJwOh8hWo2pSniKNIIbJ/jrgqJWe64tGBHi+212lnVoiYLudp/ky98E2h0GLust2q8QbQFLIQ8xiRGF1MfHfKW2FAy0r4C7nnx2E6dLbymEbP7M9ZwGk5L+D6XUYsFtTarvxrMP4Xo9l6beiKUcpb3c68UnNzHB7crV31roLSj9C+lBQWGLHu4AsZmuR3I4SkkgPkrt1fSU9gio6OGcj9/QUKVqS3RBUMp4WBDxbD50ZayCgL7TRAJhxg6tKuatr8QrYf+VbcC7/pXnMRCKUV365OD6t61H0xTcqh8q6FyP+hIGcP83Z8iYYZwjeEhBqjNGIq8/BcuGvo2Jyq0rN/kw434NejNkAQkZxwVXo8Jo2nB9y4KXUiEh8JPZGwJKsPPHBiXHt89DOLVdkhfdWVQ9heNLsCeRMNWK0c+usM42rD08TT7GXE6nHwAfSM9U709MBwCN8KkmzFSXLKUdU5zIiEqYtIg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(366004)(346002)(136003)(376002)(39860400002)(83380400001)(5660300002)(86362001)(1076003)(2616005)(186003)(38100700002)(44832011)(36756003)(7416002)(66946007)(4326008)(8676002)(66556008)(66476007)(2906002)(6486002)(41300700001)(107886003)(8936002)(478600001)(6512007)(6666004)(6506007)(26005)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TZsUnhXYmr3O3V4HMeaZcNN5/Ag6jJmqOFH4k38fj8SLgXB120zGA2Xd8Ufr?=
 =?us-ascii?Q?yH4WN8I6gFkMPHQXgWQQD7ex89fFrPfj8zvn5HAIOmm3B87VKeZOVbb7RCPg?=
 =?us-ascii?Q?LOaZzM9x8Knz6fP5b9BKZpaXkS0WZ85/da4U71twMriIHNdK8Wrb1kwNS5V8?=
 =?us-ascii?Q?x9qzuS7JJykhc+gNtHCHvW9KvcOhuXFFR7mHIybYt7jtBW+OtO4vGsWuebxP?=
 =?us-ascii?Q?M6Gh8C4saPN78gBtFKdUWGyu2EDjiBM6CEL28o4gn/CCoKa1CvvzEOA9AVRE?=
 =?us-ascii?Q?Ev47FtTBYH+QcACfM47OWdQMpt4omiBDV13FYsOkW+ZjGJcOviqrYvry/dtr?=
 =?us-ascii?Q?OCb+oZohEb4aPfZ+r64QBtHapJgPxtjVFmMbK+9jB5ZWutfDeaJl+3hC8+yl?=
 =?us-ascii?Q?tKyvPxQ1Fzw/9Mko0z9bPnbFA8oLVDZFCGEKafocMsXXcJNGzjh39PJTqqNC?=
 =?us-ascii?Q?49cwdwuzuEs2Ur4tX53bl509aP79c2ztD6EQ1ER8k8Ya6Mg+7BVChA9AKtvC?=
 =?us-ascii?Q?VrQNhgiRmWtEY/991xWD+ryhZ9acQexwcDTwFuXxjSlXrFCnpumpI0Q2DoId?=
 =?us-ascii?Q?1zrPAhgwO20pVeh93+QylbUffX+Dc8yZ3+sMe9MeaDIbvgOsAeffzyhvEU8R?=
 =?us-ascii?Q?lnOue1Zm4ddjIc3Kbos9uxwHQ9u64pJlGAuFwN8etvIRJqph1hUwDOgbRWPa?=
 =?us-ascii?Q?EOymezClMpn6iderPkuUfijUDTB/iPb8sTkAn8dfTe/vrtW8EmFdHYsOlt0t?=
 =?us-ascii?Q?MxGPvupL7pZU/mxxFN9bpQuuA2xwp8sX5r16qnqBN6zaYLPLMfYVCP8T9eN0?=
 =?us-ascii?Q?4FJNYxs4FVqJ3aclIYTE/Pkitep3JyZpCoss4IoZ2vGABNXksAf/KLGrO4wH?=
 =?us-ascii?Q?Hlk4rd8bPJnJ6h+MvjdZvW7IC68l7fzoP2ekb1DmhhpifLvZfZbWjzStCcnx?=
 =?us-ascii?Q?a81lhkRWLZD92XpNKiaj5vp9WnFqKd881c9hJ/OAaIxjYL44K5UYPd4iE2Sh?=
 =?us-ascii?Q?LIfnfaMYfPQT/MNn6496Yzf6QdukkWwRgfL1RpdiutSLsww9dZFLPC39oQfe?=
 =?us-ascii?Q?IyYhf+dkoekfrrXPmP5qVctsRlWX/HLSc8QrlYOHaq7vRqxaXr+/l85T6U2m?=
 =?us-ascii?Q?f7WcNYK8S59697mnOHLsEAvt6QicxH+9ZZy871E+81Sy/AKwmSCMZwdrKrC0?=
 =?us-ascii?Q?hUGsbsEcj7vQ0O8XzLEGUXo9cgc+BoGABrqCoFRQadBRIfqJ2TGBFmlWRsIR?=
 =?us-ascii?Q?IDza8fJzXdZecC6IRgSAUTgZLHyd6TZw12JkWRsO246IUVrZbrEoVIyInJLK?=
 =?us-ascii?Q?U6DakGHYovbrFqDQcTeGGWfqnMHMKisI4N7Pex5iX3bjCu9emBIn1A0ZXBvf?=
 =?us-ascii?Q?hK4MLyLB0syxeK2RGg0Bclx/TS/39H8fUxmMj7BYrJOoX0Ie/3aNmlKJXi9N?=
 =?us-ascii?Q?Nb1rvo6pAyQULYqnFXn7jPWC1/0qUMXfNL5eZ2qt0K00gZTB9VRt0PS0tzS+?=
 =?us-ascii?Q?B7+45y3Eyh82BA6IUIXYmwh6bWadXKXfECkZLHERD1n2M2TinFLmQlusdSns?=
 =?us-ascii?Q?CS058pgKlq9VE83zvWrxFS5rFbJ63xed7nxMAa+i9IN/aCMbcHqVFHE4mZ6p?=
 =?us-ascii?Q?cA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1694ca92-c6f2-4779-c538-08da8a12545e
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2022 23:00:55.7775
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8OvAeDhA3n1eALrCXtemUT0V2WHL1zl0FzrS9nm+cOanidM7pIm1MYS1mbUe8FO+rEJEMOYzxrCFYcGMDjQUZf0HUm3GR32x6Q9ZsYwcTuU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3736
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-29_11,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208290101
X-Proofpoint-ORIG-GUID: CzSqTwL8LsuHDyA4mSIO5pFcQxmGdSOd
X-Proofpoint-GUID: CzSqTwL8LsuHDyA4mSIO5pFcQxmGdSOd
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removes the last caller of remove_huge_page() by converting the code to its
folio equivalent.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 fs/hugetlbfs/inode.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 3b5c941e49a7..7ede356cc01e 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -366,9 +366,9 @@ static int hugetlbfs_write_end(struct file *file, struct address_space *mapping,
 
 static void hugetlb_delete_from_page_cache(struct page *page)
 {
-	ClearPageDirty(page);
-	ClearPageUptodate(page);
-	delete_from_page_cache(page);
+	folio_clear_dirty(folio);
+	folio_clear_uptodate(folio);
+	filemap_remove_folio(folio);
 }
 
 static void
@@ -486,15 +486,15 @@ static void remove_inode_hugepages(struct inode *inode, loff_t lstart,
 
 			folio_lock(folio);
 			/*
-			 * We must free the huge page and remove from page
+			 * We must free the hugetlb folio and remove from page
 			 * cache BEFORE removing the * region/reserve map
 			 * (hugetlb_unreserve_pages).  In rare out of memory
 			 * conditions, removal of the region/reserve map could
 			 * fail. Correspondingly, the subpool and global
 			 * reserve usage count can need to be adjusted.
 			 */
-			VM_BUG_ON(HPageRestoreReserve(&folio->page));
-			hugetlb_delete_from_page_cache(&folio->page);
+			VM_BUG_ON_FOLIO(folio_test_hugetlb_restore_reserve(folio), folio);
+			hugetlb_delete_from_page_cache(folio);
 			freed++;
 			if (!truncate_op) {
 				if (unlikely(hugetlb_unreserve_pages(inode,
@@ -993,7 +993,7 @@ static int hugetlbfs_error_remove_page(struct address_space *mapping,
 	struct inode *inode = mapping->host;
 	pgoff_t index = page->index;
 
-	hugetlb_delete_from_page_cache(page);
+	hugetlb_delete_from_page_cache(page_folio(page));
 	if (unlikely(hugetlb_unreserve_pages(inode, index, index + 1, 1)))
 		hugetlb_fix_reserve_counts(inode);
 
-- 
2.31.1

