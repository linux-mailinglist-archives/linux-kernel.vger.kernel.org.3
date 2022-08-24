Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E6A25A00DE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 19:59:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240070AbiHXR64 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 13:58:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240354AbiHXR6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 13:58:44 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CE0B4D827
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 10:58:41 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27OHkK8Q019890;
        Wed, 24 Aug 2022 17:58:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=zx9J43R47QH1zrykkR9tfPv7uSBXWgGXVu8WR9/YCuM=;
 b=EYRpbRa3z9C46CC+oN76I4dDQGuqYRCGx7pLG45LUFCdYLWRlRdxABYQL43JKPoU4bMu
 +LelB8XT+ONQ7CNuQl+/LhncFXCyT/Y4c09CLOScAY+aPSJC3tkaIVbMGmW1luntpYzx
 67LJU6zAzDxO9FybbWmxofoXFIbMwPnpdsE9gBicfSlqLnYG46AhHzGPaRXDz9beIdAL
 +wAn7tYTIVP6RcdBWboLfqOMS1Kb4p3O0tPn/OpGxcYp/FtmxebRNBbi4fgnvcJEf80m
 VKBlMB8Ylg763BX61u9buQMvTgncnb1EJtDDaY1qIa2DamwYWO+rbuGMGvrotFgWH0+N zg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j4w23vbum-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Aug 2022 17:58:11 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27OGujfG008185;
        Wed, 24 Aug 2022 17:58:10 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2044.outbound.protection.outlook.com [104.47.56.44])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3j5n7akm44-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Aug 2022 17:58:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KswQyKbGwQvLJZh7JOZb+CjRVsTQH5Oq6RLuwDa+LJwE8C5aaHLSJycV6ugzNfy73L1ROoJbsN4Zg4e+oUwM9gqkS+v/RfWitePUOXmfKp3q/oHErmR3QuNwq5AnGYrLEVNIeD9oGlNqNHbTwS05V8ksDnrg/SOT24WkR9LqwArt3XBPhiXeaOxYQvH0xsN7za/qhkSkISl7wAV+G5q0ArY3RSGJep4JX8VmRxjG7/BTSVo1U0PaH3tsfRuMeOLKSDaKB+GiCtFD+wKWaMwwG4OvFfUkdH8tahjSX5SCEOtPLhLeVPhtYkGHjE4a9yH+7nwg/G+I1r/FTIs8qy37GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zx9J43R47QH1zrykkR9tfPv7uSBXWgGXVu8WR9/YCuM=;
 b=PXfOx+TNgmQGT/EKleW7sPi9FoSK/nMCZ65Hzm5kz1mONCs5A7jMfk5QFE138HX/7g07Cs1JF4EEqZt41azxgi4+lbI0cqcYzqv22fTVpTgLTpxs7HHsKjiz6hjZL3/vMh/T5UjRVRn4wEK/Q8wyqQfTKgsa8QrTgmWQCBStHX6tA0WQxIOBcMVp5r5wEtKd9VViNhokwpyWEoXBCK9qr+J9Ltzoi1neZqJ9rL232LXnaQJfSexuDSh5JiTTJaj5IgTAoVefAyscSWrMQNFK7ufnK0LaIOZW+1uuatxQTfJS6m/IkN3WdhBsqZ7dZb84KWM7F6kz2uLF4ftgugs0sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zx9J43R47QH1zrykkR9tfPv7uSBXWgGXVu8WR9/YCuM=;
 b=OB0MMIr7sujqQLVA9NuWJC8kh42gsjgzmY5yA7f7kTYLEIQGb0zGwBUR1NohDs6ZvyrN0jSUW1ImhJC55fQD/wM7fVTrHkwFsHkBCvxlxA+Zs5Z5U/Mk/LF/w0jhKAvJ6ss81lIPA4waiWtuhDC2syCZpO6rl4fSBCHmdq9F6V4=
Received: from DM6PR10MB4201.namprd10.prod.outlook.com (2603:10b6:5:216::10)
 by DM5PR1001MB2251.namprd10.prod.outlook.com (2603:10b6:4:2e::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.22; Wed, 24 Aug
 2022 17:58:07 +0000
Received: from DM6PR10MB4201.namprd10.prod.outlook.com
 ([fe80::11b6:7a8a:1432:bec]) by DM6PR10MB4201.namprd10.prod.outlook.com
 ([fe80::11b6:7a8a:1432:bec%6]) with mapi id 15.20.5546.022; Wed, 24 Aug 2022
 17:58:07 +0000
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
Subject: [PATCH 1/8] hugetlbfs: revert use i_mmap_rwsem to address page fault/truncate race
Date:   Wed, 24 Aug 2022 10:57:50 -0700
Message-Id: <20220824175757.20590-2-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220824175757.20590-1-mike.kravetz@oracle.com>
References: <20220824175757.20590-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0362.namprd04.prod.outlook.com
 (2603:10b6:303:81::7) To DM6PR10MB4201.namprd10.prod.outlook.com
 (2603:10b6:5:216::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 381512ad-1c9a-4526-1742-08da85fa3355
X-MS-TrafficTypeDiagnostic: DM5PR1001MB2251:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pX6p7Jg3WQGDRyeEAaDvrSxnVKY36hzV+Dq0HdXF9hMheHyr5hSnr6tSbwWPKBYZ/lr8e7UDXt55svpV0o68DbiCzvW0M/+qnGd4YWYfJtOqX9v5Q2qWj+dJuVQpvvrBMItOKOu/DTSoYE2jEw6zkUUhtc6jcw25p97CSd7912Ifl6Fp/U8MzMu8o1onTY7LJU6WhmlTUbx8R83fNBdWa3k0AcXzH45evVnqQmSrvYRWdz3Xie7yk47oHzokQp3ZaN7N0iQv7tmH2cC6MNVG4dK9Slxp+GusKOLURuhKC10yLnuVlM1TjANUfwKOeaY2sRr7rbohtJUnL5rYvch6+rXpfMT196o5IZwX2aB9vu6HJYB9uWhvOkePgGXVsbgUFwZ2I9BY0QGEkexXhindDW0f0Klm0wd9ehoNp4o+JFrJaioWvR4Ys8KmhQW4yD2g1J3etgyLIMyWg9Hdbmr0Cpbcll0frlll/ybcThz3pt6bOOqmsaEmGZui0Tv1gOrCo/KCxQJ1gyMTSLQl+4MO1qwJTqSja/zeMVnX+HYCw1Qraa272s/X0LMwxlb0IEmIA9HKn+ZjKhhhQ0ozLSv/stw5cF1t6gzmmUYWl0iPXxTSP7L5QFk9myLjd2g1TgoCS2owwRdnJXScUq/fOUiV6uTN7KfPWtpg6PWn9azhaxxMXOXX0n2EL/eQVhIJbDlHaMlRv1CcaNh5rqcJgAS/Mg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4201.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(396003)(376002)(366004)(39860400002)(346002)(44832011)(2616005)(186003)(38100700002)(54906003)(83380400001)(1076003)(66946007)(86362001)(8676002)(66476007)(66556008)(316002)(478600001)(4326008)(41300700001)(6486002)(36756003)(7416002)(8936002)(5660300002)(6666004)(6506007)(6512007)(26005)(2906002)(107886003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?L9b3H2bGyVYD8eVvDdQfOpF3Fww8E8IAdX1RZ9qNkd6BzBHrODncM51xYXYF?=
 =?us-ascii?Q?6+/TP3eTO2QwGDlrZYoY6p0ZSSYqPsLJklh+ARomiWXWlN2jfmUeck5u3b3A?=
 =?us-ascii?Q?A7vOmtI7sTyuKRAx/IQvyPAcCcYfJtJCLA3bQjnTvilpK7F30RCId+sDu0+R?=
 =?us-ascii?Q?lvhdMGyDp0Au5c062P/H04pdqen7YJnZUZpPCGcb/NSHEwcquiDo4Dl207+v?=
 =?us-ascii?Q?Wa9/aGR0hxoW94r2WxwUNoLnuF1xx8FAFeYYcVk36CDHcru0BgIPkVxW/7bR?=
 =?us-ascii?Q?2bCB9Mz5iCGutNyt2P0xsWSvd0/IkdtQGu9Uvvptgk7qJnXB/ndMcX6OqoYt?=
 =?us-ascii?Q?3nDaAbuHODiAtvcESn10l2hpDPLHIoT+bAMfOFLRug5Lgw9N+Xt+cDWkKW4m?=
 =?us-ascii?Q?i+fHWrTz+QA4J0ET0CYCxhHMl3ALDo85GZVWvwb2vlIxL6LKQjIqBXWSHNM6?=
 =?us-ascii?Q?CQtOLVPZb3EDCheX0iM1o+RHUUu/LuOFaoesCP3NculCQOB8qm5O6PJS7Rvx?=
 =?us-ascii?Q?OdzqZ77JTtiX4dCrZMfb5u19uecr0vTCfYyvl7y/gcqCMCzTCckoC/TGwGzZ?=
 =?us-ascii?Q?R5BKZMKW4dXdIm79KxwhIJrfC+sxBUJImFESCKoUOJ9rEs+QXawETvo2Qb9J?=
 =?us-ascii?Q?LwLn9560+XMytLqxrL3fQHLhQ2pudIFqHtrNu+qBIBWNFRM9gDEE/itet/2Y?=
 =?us-ascii?Q?BRj44GtZC/hEUTCDCyqjYDpKok3IFoMWxiEuhZxmBgL5ksPcs17kIQZ2iJq2?=
 =?us-ascii?Q?gzGmaSFz82prHyC2s/4qJNg5TgHg0SSeVVGVLKuA+p9UZbZWNfJC6ajZeGTW?=
 =?us-ascii?Q?2UAVI60+YLa91kDGS263J/IoWLqfLTPkkXxLctwv6GCWdy8nhzI9HDhCvnM7?=
 =?us-ascii?Q?UQNxcA+zgRwcynKnAW5uBAsUWLWXX6uGpzclBNQmMtLXKuZ/7ktdwZgMGKUA?=
 =?us-ascii?Q?4BJRyLE8QI4xnm5boKfUiHQpAcLN0HK8cjQeq5EwcuFkbde8NkepaSY/GlvP?=
 =?us-ascii?Q?kwzNYp3RxZ9y2h8/KLGtivGe09X+vCUfJqPTW15UfF3apwOruplAxImhs6iQ?=
 =?us-ascii?Q?1WBTvJU1MIEwMTBzHGn+PU6UCkQNJI69h9Xw/BfsUz1fXpCDLsfqP3j3R+70?=
 =?us-ascii?Q?KNAZ71YoCnq8e9KH+//srRM3mtkIdW9oi3JYJCB1ZTgIXatLIHpsZtJAnzWP?=
 =?us-ascii?Q?dV4Fnssvn63fmjAKg4Rz5o8aMiWRses0sEvb5J8cqfsICcDSl+xzJJne2hRi?=
 =?us-ascii?Q?kT2STilLTfMNmpG+3vXBRZFNWW/+x5l+a6FqrfkVGVisK/teFp+kUsStB8cw?=
 =?us-ascii?Q?VhYhUt8QJf/4i7fKBPSG4PkMt5mnnEE00ZRe7yB86JxSOB4MsCIM+y8NJQKL?=
 =?us-ascii?Q?k5jhSUE7xtLgVaeWTj9QnPTokPENVUc4hUWS1yENyDBgm/W252VKdxG9lGCj?=
 =?us-ascii?Q?7hd+3Zjd2GksgNlT9yTChZaCfbOTrKWxJJYXaQ17KDaCn4XVYJvpW4ur7Gi3?=
 =?us-ascii?Q?U+O0SqxEnXCn2St/XCyUnOazrCO172cBdzsX2wJuMwC0sqvJlEnDiLr18Ard?=
 =?us-ascii?Q?SrEddQtMQ+nOIN5w9p09T+wxb/4jEuLKCaVGvU8J8luf/6bQhFagtMUcaHo4?=
 =?us-ascii?Q?Kw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 381512ad-1c9a-4526-1742-08da85fa3355
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4201.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2022 17:58:07.6504
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t7+HNqcezM0cGkV1hBpk5h7rJrXs9E5wmDDvLpgerts4XZcfR3hfvYdYsj+HZAI749+rUfq7ZARo7xMFhG1DeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1001MB2251
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-24_11,2022-08-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 mlxscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208240066
X-Proofpoint-ORIG-GUID: J7FDiQgmc6_cczxmbC4jycd0woQ4ctum
X-Proofpoint-GUID: J7FDiQgmc6_cczxmbC4jycd0woQ4ctum
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit c0d0381ade79 ("hugetlbfs: use i_mmap_rwsem for more pmd sharing
synchronization") added code to take i_mmap_rwsem in read mode for the
duration of fault processing.  The use of i_mmap_rwsem to prevent
fault/truncate races depends on this.  However, this has been shown to
cause performance/scaling issues.  As a result, that code will be
reverted.  Since the use i_mmap_rwsem to address page fault/truncate races
depends on this, it must also be reverted.

In a subsequent patch, code will be added to detect the fault/truncate
race and back out operations as required.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 fs/hugetlbfs/inode.c | 30 +++++++++---------------------
 mm/hugetlb.c         | 23 ++++++++++++-----------
 2 files changed, 21 insertions(+), 32 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index f7a5b5124d8a..a32031e751d1 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -419,9 +419,10 @@ hugetlb_vmdelete_list(struct rb_root_cached *root, pgoff_t start, pgoff_t end,
  *	In this case, we first scan the range and release found pages.
  *	After releasing pages, hugetlb_unreserve_pages cleans up region/reserve
  *	maps and global counts.  Page faults can not race with truncation
- *	in this routine.  hugetlb_no_page() holds i_mmap_rwsem and prevents
- *	page faults in the truncated range by checking i_size.  i_size is
- *	modified while holding i_mmap_rwsem.
+ *	in this routine.  hugetlb_no_page() prevents page faults in the
+ *	truncated range.  It checks i_size before allocation, and again after
+ *	with the page table lock for the page held.  The same lock must be
+ *	acquired to unmap a page.
  * hole punch is indicated if end is not LLONG_MAX
  *	In the hole punch case we scan the range and release found pages.
  *	Only when releasing a page is the associated region/reserve map
@@ -451,16 +452,8 @@ static void remove_inode_hugepages(struct inode *inode, loff_t lstart,
 			u32 hash = 0;
 
 			index = folio->index;
-			if (!truncate_op) {
-				/*
-				 * Only need to hold the fault mutex in the
-				 * hole punch case.  This prevents races with
-				 * page faults.  Races are not possible in the
-				 * case of truncation.
-				 */
-				hash = hugetlb_fault_mutex_hash(mapping, index);
-				mutex_lock(&hugetlb_fault_mutex_table[hash]);
-			}
+			hash = hugetlb_fault_mutex_hash(mapping, index);
+			mutex_lock(&hugetlb_fault_mutex_table[hash]);
 
 			/*
 			 * If folio is mapped, it was faulted in after being
@@ -504,8 +497,7 @@ static void remove_inode_hugepages(struct inode *inode, loff_t lstart,
 			}
 
 			folio_unlock(folio);
-			if (!truncate_op)
-				mutex_unlock(&hugetlb_fault_mutex_table[hash]);
+			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
 		}
 		folio_batch_release(&fbatch);
 		cond_resched();
@@ -543,8 +535,8 @@ static void hugetlb_vmtruncate(struct inode *inode, loff_t offset)
 	BUG_ON(offset & ~huge_page_mask(h));
 	pgoff = offset >> PAGE_SHIFT;
 
-	i_mmap_lock_write(mapping);
 	i_size_write(inode, offset);
+	i_mmap_lock_write(mapping);
 	if (!RB_EMPTY_ROOT(&mapping->i_mmap.rb_root))
 		hugetlb_vmdelete_list(&mapping->i_mmap, pgoff, 0,
 				      ZAP_FLAG_DROP_MARKER);
@@ -703,11 +695,7 @@ static long hugetlbfs_fallocate(struct file *file, int mode, loff_t offset,
 		/* addr is the offset within the file (zero based) */
 		addr = index * hpage_size;
 
-		/*
-		 * fault mutex taken here, protects against fault path
-		 * and hole punch.  inode_lock previously taken protects
-		 * against truncation.
-		 */
+		/* mutex taken here, fault path and hole punch */
 		hash = hugetlb_fault_mutex_hash(mapping, index);
 		mutex_lock(&hugetlb_fault_mutex_table[hash]);
 
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 9a72499486c1..70bc7f867bc0 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5575,18 +5575,17 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 	}
 
 	/*
-	 * We can not race with truncation due to holding i_mmap_rwsem.
-	 * i_size is modified when holding i_mmap_rwsem, so check here
-	 * once for faults beyond end of file.
+	 * Use page lock to guard against racing truncation
+	 * before we get page_table_lock.
 	 */
-	size = i_size_read(mapping->host) >> huge_page_shift(h);
-	if (idx >= size)
-		goto out;
-
 retry:
 	new_page = false;
 	page = find_lock_page(mapping, idx);
 	if (!page) {
+		size = i_size_read(mapping->host) >> huge_page_shift(h);
+		if (idx >= size)
+			goto out;
+
 		/* Check for page in userfault range */
 		if (userfaultfd_missing(vma)) {
 			ret = hugetlb_handle_userfault(vma, mapping, idx,
@@ -5677,6 +5676,10 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 	}
 
 	ptl = huge_pte_lock(h, mm, ptep);
+	size = i_size_read(mapping->host) >> huge_page_shift(h);
+	if (idx >= size)
+		goto backout;
+
 	ret = 0;
 	/* If pte changed from under us, retry */
 	if (!pte_same(huge_ptep_get(ptep), old_pte))
@@ -5785,10 +5788,8 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 
 	/*
 	 * Acquire i_mmap_rwsem before calling huge_pte_alloc and hold
-	 * until finished with ptep.  This serves two purposes:
-	 * 1) It prevents huge_pmd_unshare from being called elsewhere
-	 *    and making the ptep no longer valid.
-	 * 2) It synchronizes us with i_size modifications during truncation.
+	 * until finished with ptep.  This prevents huge_pmd_unshare from
+	 * being called elsewhere and making the ptep no longer valid.
 	 *
 	 * ptep could have already be assigned via huge_pte_offset.  That
 	 * is OK, as huge_pte_alloc will return the same value unless
-- 
2.37.1

