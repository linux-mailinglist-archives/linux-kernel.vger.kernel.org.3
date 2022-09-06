Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75F335AF1F5
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 19:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237809AbiIFRKO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 13:10:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239508AbiIFRIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 13:08:43 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48B0C83069
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 09:56:00 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 286GO19Y016876;
        Tue, 6 Sep 2022 16:55:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=2ZwJE9Txg9PnDua1OpfpI2XWocK+C9Mzt8dlocRPfIc=;
 b=BK/rCAui9oD/Xl1GFckyqJkzQLW7BFZX0eCI9FWz+AOtBFei1q+nPyPZ5r/GiEM9LVb5
 AOvoaTcOzVNjEplx9wR9Q1b4ZUDEWJfVxh1lN63TMpg1LgBY7+6x8CZ9SHBKvlVNSGrN
 bhZiTfOoKoegHG7RMwIbkn+e8TJ3on2jPQXzpSFfoobRTALI3Iw/I+2A1GvDBFcWqMhq
 I8Cqt+HXrSaC/+RFBIjXLabMa2WpmfTBvx7UPqALCI0C8yR7lYdueMaABg2BV7pze7JR
 hZ//Ommxx5ECO2+fSekvXMJ4IlQHAxhcj2Lnim6AMUEQ2Hdt6/Nq/VYHmQd+Ok3eWX5v Qw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jbxhspg8k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Sep 2022 16:55:41 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 286EwPed037499;
        Tue, 6 Sep 2022 16:55:40 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2048.outbound.protection.outlook.com [104.47.57.48])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jbwc2w59e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Sep 2022 16:55:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gAmcfoNW8NdcJVvRENdkSd8uTgvzLyY9JLhxQ7JAPifvbXTDiGWkV7yILu2PMBCP5Oi5+1RCRv5RPfSBH1bStgz+OLDX4cAXI2BEO9aV0ivUIqK8cb+PBPbnuzY1tR9zD0wrBCDMSqMtbT+84p9KHzmsug+IYNtMdVM3e+X+sgxrzQE72pl5M0suXihWXsF3lXRTUL9q4o0Ev0uACeEXCz4SsiJmNI8WDfqaTxVM0GXW7qvnnflrn5WH/nVL/RdySkim+vPJ5UgtercbQdW/qLzpxmjFkmCv5qQwW46cAGI15xndI2y/l3G9k9jsk9baFbvSIyGesyvZNeiQud5iEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2ZwJE9Txg9PnDua1OpfpI2XWocK+C9Mzt8dlocRPfIc=;
 b=ivdTRMEEsYfIeUZDfnb/zegKCiM6Hkjvo3MDEjhQUqoJzbFzjBny0+6CldDlQF1i4M9289Nw4/2NdfR6RHNoqpRpbxZlJPNV7RV8m8PtHXL8i5h1bPJd3F7x5ZGXZoSlmMe27Gg8w5qFtLuNaak9cpVvPH+EWy1DtA82Wk78X+IUKJicTwGoDi+j8dIW4E3+GKpRrZ0XjT9woESUQkxw4ntERljdncpLp/Twnnd68zjo/MtZ9+lucldfoRIEh5wPV+BNaUM5limH9ROFojyJVo2U6ijG86gYztPu3r3HkjrW8abuitRO+RvthEr++dNe+yHSRHQZgwNAxAR/s1n7sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ZwJE9Txg9PnDua1OpfpI2XWocK+C9Mzt8dlocRPfIc=;
 b=Th2AdoqysLMpP1uJCj7mdkaU1RU7gSrsEAivP2Gi2Y7y4Zz79MCPGc9oM2CO2zWWz4jDBYtZ7XpknxpZI3kJl/gHeAAvpaplwoh/E79Y1CKLppkwmrygMPkwTc2ZEwI6pavCoLppx4SfwrY8RHW8erGVvGCzFQL+O21qxCPAd7Y=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by BN0PR10MB5078.namprd10.prod.outlook.com (2603:10b6:408:129::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12; Tue, 6 Sep
 2022 16:55:38 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::ec55:981e:3693:b37]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::ec55:981e:3693:b37%4]) with mapi id 15.20.5588.018; Tue, 6 Sep 2022
 16:55:38 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, willy@infradead.org, vbabka@suse.cz,
        william.kucharski@oracle.com, dhowells@redhat.com,
        peterx@redhat.com, arnd@arndb.de, ccross@google.com,
        hughd@google.com, ebiederm@xmission.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH v2 5/6] hugetlbfs: convert hugetlb_delete_from_page_cache() to use folios
Date:   Tue,  6 Sep 2022 09:54:44 -0700
Message-Id: <20220906165445.146913-6-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220906165445.146913-1-sidhartha.kumar@oracle.com>
References: <20220906165445.146913-1-sidhartha.kumar@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0105.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::46) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 726a9731-bc31-4f6f-121e-08da90289fee
X-MS-TrafficTypeDiagnostic: BN0PR10MB5078:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g75iLYjvvIUTRlQNdNznjb+5wvbUWLbRYgkjtvzX/0zaHGKKxyfx1IuRPALHZeEkp1kQQgvU32i9asVFqhHezAcC0UGBv4t6AWVTnPae82OOx+bZXadmEYKZbzZlKn6S6BxeXlV1CAHPSwmib4ThNh86hhoEbEE1tlHjtEJmTtNZQvN3D9VXCODJXd5jDS4Vdxq8kE2Dt8+UqRbF/RuEWc2QAcKvcoTttl5HFLenaOviEYLEoWAQGHRj+5rwCBsAGztOXmyX9exmofEuDrM/Hl26jrQxpirpg8nVzxqDK8nRwrUUzcUS4cfl18wRNN6ZH2s2vqO4u8tOM48koonxugl84BuyDpCdWUmXmdoM475wezRcMm2XlqhkQWwzAMKOhoWGD2bmXdv3ASRgOcIqYZ/f2CyJR7nfK3lL27ZMQ1MycE28uakiiopxFAHefJ1LWi5MUsMhYou2K4/7IltGVC7r/GBRRluSTK8Gjz0D4x+/pjH96nRA299E9BRQAzTpuD9bOTeSxcP674VkXB6zydm34wFgaHR6/5uWoZh/aRoRM4efe8gIDranRD+PCqkEepcCI9LW7rv9DausUHaZdjAytvQKQVA6oCg1ApGxOrej7+H3sVP955NegN8e20Kjy+PSuz36CNfQFeFxP53vdOnGDjvTQCa4JVT0qHeuY3mmL5fsyir/Ju/BQN8d5ObswbJru1GHXmoiKIVdm53vgQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(376002)(136003)(39860400002)(366004)(396003)(186003)(1076003)(7416002)(8936002)(83380400001)(2616005)(44832011)(5660300002)(2906002)(26005)(41300700001)(6666004)(107886003)(6512007)(36756003)(6506007)(86362001)(6486002)(478600001)(38100700002)(4326008)(8676002)(66476007)(66556008)(66946007)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?te8KJtzEKZV8e2OAMtcC0VY4iyM6TIjva7RmhxypdpDaa51/OpjCIPhsAsOY?=
 =?us-ascii?Q?W6S/IlYukU++i/74ctg9CU1VQdlrymkXRt6xb62hjaP5k4tmKTrp1c9bwWa5?=
 =?us-ascii?Q?ljUdJ66Mvc+DKTRAppszfCW8ajT34ORRHrXOItogSu/AiZdryTtGyVJXli4l?=
 =?us-ascii?Q?afj3VQPCFprA/UTebxe4A4Y3rct+zhCK7y+55pBEf0fDQmxM53KDXJH3cCzd?=
 =?us-ascii?Q?F2OyrtGQsN2lV7C2moVlAVO1LqLUMyNZh1YYQG2XNPy8Dd6D0XwOR0Oewchz?=
 =?us-ascii?Q?Jp+SbllL0McWjSF3lzTOYatoXK5x40B9iQKvAeHhnf2IhJd3Jdmu2InDfGDh?=
 =?us-ascii?Q?R0iarsvaX/GqaMwkYKlc9Ls0HauQJ55OgIxT8A8rxEH6Z+uG8W+UMBG5cVUe?=
 =?us-ascii?Q?BtSLskfEEUQZe6YUNHWb9PiUG1ZZSqlXnwX96piUQUpZPLSuBP9ZGMNcz3io?=
 =?us-ascii?Q?zMu1iM5GjNqVjpKmpZU/wnYRX6cjXjqZ//Xk1cpNQYhxudOrxUjJ0JdBK39I?=
 =?us-ascii?Q?Cj6NmBDoWfsLhPfsaVYWYFzSkZiX2xKQ/iv4MJ1L5LXnaMrIVwNHFyqzXSgq?=
 =?us-ascii?Q?F7LF3VqXu3mWDOEvc7p2P71wA22cyWRFnYPRO17RP5AkcvTCUUm8eQ7Ap7H3?=
 =?us-ascii?Q?Ue8vwFpCj8O8RMykRPw8lOYtLENDBQv//tz5L2Vd4/5Xzs3Yex0ZGWezwTkF?=
 =?us-ascii?Q?8XirmqQn4FTAAvMcxORhxbU7WPWE6vHw79y/4/ZJ1JCDGjr66wJ2tKVzyqAl?=
 =?us-ascii?Q?MzQ1IE+pVMzhFWjak11hCI9gxoP74SbfVeNKi1YO43eS2BOeawxvxyG5J4Ug?=
 =?us-ascii?Q?SUmclOzcaoDTIl6AJPnQn5PEuovp3MBCu/g0vH61ebRTOCQ2O7Osrd1bRkkx?=
 =?us-ascii?Q?v/zcCuq326wF69xWTb05WMejKvROS3BQzcG8gnLDYj3SY7Q9Q/ck7O1aH4Gf?=
 =?us-ascii?Q?92937nneNTMCCt1sc+RmnXouz2iboOZmNHfB+Cvet3Fx2UnZFBtzyyaJq5v4?=
 =?us-ascii?Q?RrSjt3Xo3dyoSr+VSEH//hw1mTdZ9krcu1PgLdsFAp8puhBq/V1Ffhlr27fl?=
 =?us-ascii?Q?MGOkteCdD5Wb+8EdxiISTc4tZ09rSRZi3j0ckzZYXel2m5n0Qb3aKwb87uIt?=
 =?us-ascii?Q?QEVZUGdRYewW7napfCH9NVfzhQEVYHys+NQBU1SUT21eLF+yPW1bJmnWGNub?=
 =?us-ascii?Q?aJpLhwwdUowO0u8rwuwwRUOB+Y9FmHpo2BVEv1BV5tpBAT0+Zj/DO5gzucLN?=
 =?us-ascii?Q?USkeuZTxbK0kN1QzJLsx/TRT9inpNpvMawKWyS7xtMCNg80j7id4WrtXbj7e?=
 =?us-ascii?Q?IWqiUtoaLkk7pK1D+YF/HuxGTGIXsl7jEnofOJ5+z6ya4HXEYpaeg4Oar0NJ?=
 =?us-ascii?Q?GFTyHHSqBfe71DnZsu+f/9BhgD8tmqse78q8zF3QJzP/Q9k0CghW6I7Sr1KF?=
 =?us-ascii?Q?X73H0VWI2VQFPMG7q4QO6QixdxZJBXSTeEjNAL+KZDKtmnqNoTVG8ZKB38GW?=
 =?us-ascii?Q?vPxhBh80NPD1FCTUbxqBo2r4PQGDfGKRhoEQxbaT5GbWEDgXDQw9iOKxBX4+?=
 =?us-ascii?Q?kBiKGHBT2HZvFzzLjqmEA5dpsY7m0OW5uS1av+cst46xhn3f4G4CGP/p64YS?=
 =?us-ascii?Q?+w=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 726a9731-bc31-4f6f-121e-08da90289fee
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2022 16:55:38.4648
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vnKPcRHVQ46KkLttFLO3TaPB6pPL2EIkrvSoja/6ZMWNftN6R36h91sJl9brJnKpfShiZibQjUutiBXsw1vsJpw6dFngyI03cb6BXvtFFOM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5078
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-06_09,2022-09-06_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 adultscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209060078
X-Proofpoint-GUID: hW3y4Pe25TwbP5cjQUYodJlw6Wo2JRTc
X-Proofpoint-ORIG-GUID: hW3y4Pe25TwbP5cjQUYodJlw6Wo2JRTc
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removes the last caller of delete_from_page_cache() by converting the
code to its folio equivalent.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 fs/hugetlbfs/inode.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index d9e08c445e2f..38920702765e 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -364,11 +364,11 @@ static int hugetlbfs_write_end(struct file *file, struct address_space *mapping,
 	return -EINVAL;
 }
 
-static void hugetlb_delete_from_page_cache(struct page *page)
+static void hugetlb_delete_from_page_cache(struct folio *folio)
 {
-	ClearPageDirty(page);
-	ClearPageUptodate(page);
-	delete_from_page_cache(page);
+	folio_clear_dirty(folio);
+	folio_clear_uptodate(folio);
+	filemap_remove_folio(folio);
 }
 
 /*
@@ -562,8 +562,8 @@ static bool remove_inode_single_folio(struct hstate *h, struct inode *inode,
 		 * map could fail.  Correspondingly, the subpool and global
 		 * reserve usage count can need to be adjusted.
 		 */
-		VM_BUG_ON(HPageRestoreReserve(&folio->page));
-		hugetlb_delete_from_page_cache(&folio->page);
+		VM_BUG_ON_FOLIO(folio_test_hugetlb_restore_reserve(folio), folio);
+		hugetlb_delete_from_page_cache(folio);
 		ret = true;
 		if (!truncate_op) {
 			if (unlikely(hugetlb_unreserve_pages(inode, index,
@@ -1174,7 +1174,7 @@ static int hugetlbfs_error_remove_page(struct address_space *mapping,
 	struct inode *inode = mapping->host;
 	pgoff_t index = page->index;
 
-	hugetlb_delete_from_page_cache(page);
+	hugetlb_delete_from_page_cache(page_folio(page));
 	if (unlikely(hugetlb_unreserve_pages(inode, index, index + 1, 1)))
 		hugetlb_fix_reserve_counts(inode);
 
-- 
2.31.1

