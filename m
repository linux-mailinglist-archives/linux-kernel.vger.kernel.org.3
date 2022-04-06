Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E78674F6CD9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 23:34:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236118AbiDFVgE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 17:36:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235407AbiDFVe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 17:34:28 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1E7B29836
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 13:49:03 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 236JxC8o014737;
        Wed, 6 Apr 2022 20:48:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=lKX/aPmypYgym8OdZUeou9vQU/ZbAXm+0KAbPMTL2RQ=;
 b=ug0mqfQhBRgEYo04/l23hH9i/5108xphHxo+UK7y6/TPd2fDHDGX83cpI2SLydg0hQqa
 26llocvvFtikp7RRFu8mK6wqD5bkA5QADI1tcoy8ZTtm3Hx63uZ0iuFcFE62Qe/ZLuqI
 iLqTvQEJjTGhINqM6fcqSyeZ5NT03wF4t0XKaS0g5XPG90V27N4dMnILKE954Z2/zA9x
 ++HjD1jEaVv6NYoPj0Jxu//QcyCZFOLV5Eq5oAa5Iq5p4hjpuLbiBSQz5oJqPqf9X0p7
 JKLnMyQGkjk905j+h9zQZLKvgaFerStan85Y7Asti3tSGqw2S2+1yv/7GzdznghTp+Sy Kg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6ec9swex-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Apr 2022 20:48:45 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 236KlLPP001934;
        Wed, 6 Apr 2022 20:48:44 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3f97uw2k83-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Apr 2022 20:48:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oZNOauI/VwpiXvZrV0lR95K+OatZzbjVuLkZQYpbtE0ms78X7xSfV4LbeXe7VOat5ooZDOdTTw/7h6cik5I1gwOKRWvBqCHTWXhJJ+6dufgQIbWrxDj5H6cBattm9lRoQS9MEZY2E0oSUgEfkzKtmSQ5DFyKNyUILOk7whcYmHUQkThHafuhCpL1rdYjWmDE0DcRoTRazOeLgqeYgBFA0sQ6tyXDiasTLRJ+BNV/ZFUfUBg57SJ2R+J1JoZrvw+K4qbf3yvRIpM12j35GoXKVUbAJs9+w4eymUBTOeZ3YpQnd8MX0iXNTqCXxmUAlK0Nk5kwkrXQTLBsVjTmBjIu+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lKX/aPmypYgym8OdZUeou9vQU/ZbAXm+0KAbPMTL2RQ=;
 b=nS/wMYEtgRNJ30CbVDb39PIQe3laEjnRohQZuVzjIna2Z1fbVlnGzZvHwFXUPmKcWYl8X/1v6TN+W47R0aDR5iExiTSq//nPXsOJcdEXsVBVczV/yBm8MG3FQR52JJSznwV/tCTE9ZNrqm5f+trR8Ko8LydS47Sm7fQ8ILLHRnEx7UUIEU1YUrsFiP+gowCW0o38xV6yyGrLRhnGSSmiZghSmjBvTVEnlQIvkBXkRy0pLCDU4oRluVOxsxx+b0KOtY8q9ht1hkPSJSnlI2z0h0Pqf8468svUSQfd8uXrEowRZhCT9JrKHwbpBe9NgNf5y20nUImZure0L1p4KEQVkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lKX/aPmypYgym8OdZUeou9vQU/ZbAXm+0KAbPMTL2RQ=;
 b=lLA2GVXw2snf1biQzVT6u/1jY/2gYIU5BOsWJgWkKY9GhFQKeqW9bq6C8HvAWrxY1h1+6lJXDQCcQ35VTk3ZpOcfhRVu4tfplLj3+3fSkmq/v4ZMer6F+Yn+DF9eyyLwGgu4835dm6bnw3VU7aFGcONcSwvLOweJy7GkROlq6T4=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BN8PR10MB3362.namprd10.prod.outlook.com (2603:10b6:408:cf::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Wed, 6 Apr
 2022 20:48:42 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::245f:e3b1:35fd:43c5]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::245f:e3b1:35fd:43c5%8]) with mapi id 15.20.5144.019; Wed, 6 Apr 2022
 20:48:42 +0000
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Michal Hocko <mhocko@suse.com>, Peter Xu <peterx@redhat.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Prakash Sangappa <prakash.sangappa@oracle.com>,
        James Houghton <jthoughton@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Ray Fucillo <Ray.Fucillo@intersystems.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [RFC PATCH 3/5] hugetlbfs: move routine remove_huge_page to hugetlb.c
Date:   Wed,  6 Apr 2022 13:48:21 -0700
Message-Id: <20220406204823.46548-4-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220406204823.46548-1-mike.kravetz@oracle.com>
References: <20220406204823.46548-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0012.namprd03.prod.outlook.com
 (2603:10b6:303:8f::17) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c7c78e6e-656c-4717-63b8-08da180ed5ec
X-MS-TrafficTypeDiagnostic: BN8PR10MB3362:EE_
X-Microsoft-Antispam-PRVS: <BN8PR10MB3362B3CDB551BAB14BB963E5E2E79@BN8PR10MB3362.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jT0y/lWJYcX09kNnpFR44dVGo1ig4Ahm19G1mOAGwBK1RqleIrM5/thyM4X/H/zZf7v0703U++DU41MoC4t8sfeVretmZLtcpylJnh6o/sJXjFJYDrxRveYI3xka+6MvTneifv0bbSFVX7lCU9FuHsI0cSeWWC83H9ZIIji2ONqID5ZumldMfWv2hzGjTmwvnhLTMzuseYR0GIK9soZYV0qPVIm7CV5m5fmYph2dnFnRB4YwJcpo/swzrG0paPJsDbtc6EOdjNx3nAHlAEqwZDv/5DfxKOXTeGrMbZ3P6bb2pgNVVaCsVuzs6gWfxvXBeKkx5c5bVrIBhcG+91ZIb+OGrq03F8LSCz2m7Cpy8lPE9310ygAslBELE5B1CAEsSutbZsnjC4JjkoPfvQCnc25QaOjD4R+f6gagcKl7PTbNJW2Ru20ncj2IqKIPB6dyhVX9EvOdL42im3g5pc5yKN1GMZOYGKZaDCES2xG+uztcOn5T56HnKF7qIuNb3InLu+WLruW1oDRC/WCf/UkhEe/+u8mFcxRWxnzssbAlpmCOdGhGMzoeMRm8C1re9K2sARtD4SpkbdK//LT63KPcYLGda2PaDeACzDElOtuTWo1cbGLYIi/bBcvqP5Uygj/Kg2stcwMrn6WjxXtoQh1EEHylOUuO0EjPO5rDbBiTVBLLdGigoED0oVgzqjW20csWXA7O5s8MG3kqFEKboLLAXQBLJEdDVXiWPG6hedoPc/U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6666004)(38100700002)(66476007)(86362001)(66556008)(66946007)(83380400001)(8676002)(6486002)(38350700002)(508600001)(186003)(26005)(4326008)(6506007)(54906003)(316002)(1076003)(6512007)(44832011)(2616005)(107886003)(5660300002)(36756003)(8936002)(7416002)(2906002)(52116002)(14583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7KOEeYFXwaGbpHwO1Iry7rL0MqNEbigdqtQLKRPJQu/eVhTTTVkq/k2xrbB4?=
 =?us-ascii?Q?B7oQVNCqKzgs91CzWySzwqkD01s+ne7kvVqqDfeN6oPUnHiJ5c24jaxb6EiG?=
 =?us-ascii?Q?/17kXXeVyjDRbUgWwgwMBN3hBUW3+UnTPsT3EcC2yuEsc5Ql1KsIugxILFs1?=
 =?us-ascii?Q?cNbpLdWiFXyt2KHxkDD2BZ0cjBKlAkK/2rj3KTSWmBh0Cqzdr24BY83BHppu?=
 =?us-ascii?Q?6ZTr0AfXIlStgl8HRoEG72GmTs0AgX6X5//hKI1p0+2uZvCeRYyANpFTpW31?=
 =?us-ascii?Q?Wn1MwLSXdLn2ygOZ7mMHbMNZTt8Sk/Fzj67zCXaWr0Uv7QZqRKZUts7i+xoG?=
 =?us-ascii?Q?W2bLL/TOjOkRPpXSabkxJU0VQ6a5HVLxmmfEBd3LeSY0mJ2jFDDg9NHeBjHe?=
 =?us-ascii?Q?GtT+PwM0S2K3IjyF1w65dintsiHyo0z1f4Pd1FC2lERzaoyweSYIcvj1lsIm?=
 =?us-ascii?Q?T9HV9hnM/bWhJIJj6XXcK8WIYf+2NDtPMrPW07uEcIfO9ga2LlYRthfxd6/I?=
 =?us-ascii?Q?gY7cQ9M6TS0xglApYMxlIwXXLCb73TJttWfLWR3WU7ROE6AdJcX5KCLJR92a?=
 =?us-ascii?Q?9L+FTxH37GjSSP+7IHFFyquYmZWek1N8KJ+6MRHZmBs2cqESTALRmpXGJpVX?=
 =?us-ascii?Q?QAD7FGUg2kr0YQSXQLyKix8lD6JkMP17Kwa6r3AxQhN1nmYZVTVBhTw1ZM9r?=
 =?us-ascii?Q?rXBjnFw+x0T3WU5ty6KZlvK68du3UkD9R4Mpp3EEHXDkMh0CvnpD8kazDtv8?=
 =?us-ascii?Q?ATTjtf7rEBt0lE4tB3iYrFb2jB5Xa0ZtYxbt5CEQTHbbIeLTEsC1GRP2vNik?=
 =?us-ascii?Q?HZ7fFp1Mcpqk8LSuAWubWKrzonDC6cesvLFNXW/uxkv618jJA3RWKzI6eyKA?=
 =?us-ascii?Q?w/GK+fZyGiabGvGkrGCjlwACAVTUVTchXXxt+R5OiOIxyUt/1KKVjibl/9aM?=
 =?us-ascii?Q?b9CloJk/gfbxPgfh2yvWP+to9mgGOrAEbddJguNprPK/TOfUW99RKGvEbuNr?=
 =?us-ascii?Q?vZJqX42VOf0hIMzO38SGOY/GPP4tf/7dsia1WtIHNn6rL8QogDNLEaLtIboH?=
 =?us-ascii?Q?fV86VeqeDTef2+yqqGk+Mt69iPZKw8bE0phCVLuv+mv78tNW1q1mzeMRDibP?=
 =?us-ascii?Q?E3FCXVqVVN7qTjXSY1V4G2dxcOYuyFhUYTHp846mXZ1Hei5guixaiR/RrROr?=
 =?us-ascii?Q?HfpksrWJEgNwiFogWkARhFz4/dluAQwmH1XsLzpasSIhTHAX9JN/Chrd+UZs?=
 =?us-ascii?Q?PpbCiUCY9X42+05vEbUL5zPPzpqR6FqhO21CGM9hN3tnuq7Eemos8PTPYwwn?=
 =?us-ascii?Q?6RFiK116EW2R0l12543SJ5SNIW7MLbKW7xPlIRsvLYtBXKlq14eEmP2OWN1W?=
 =?us-ascii?Q?YxR024P/afKthewitXtv6tBKuqf4eGdjElsZJvGns8kyW2lAFjojTHZ8q46I?=
 =?us-ascii?Q?901AoejdxC7quJzXuQe5fF/7tJbNZRV+a4yvf1id7EcbvPd60/ouua8ZTKVx?=
 =?us-ascii?Q?JUCxvt+QGrjUBaKWA+KAmlmmXvt3GCHr+xpV04ci5mXKe3bvRHvUOHwd4pME?=
 =?us-ascii?Q?Kzs7WRndHGNTdW98LoUzvn9asBPkHN/67OftLz3ZI+Uou4SZFzjjzsYEdgp6?=
 =?us-ascii?Q?BmnglnPhqaJGk2Fxg3YjvN57AuzU4h0pX9ICVUyjO8xSH9WvWn9c77HhABy7?=
 =?us-ascii?Q?CPJYfNLu+Exoj2oAkqFo5GUXdwn4OYcCujOQBNYsK8eohEkWUwIN6trQaFzX?=
 =?us-ascii?Q?6CZj71NMYGw/t7/TIkqIrubetrp8Z5Y=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7c78e6e-656c-4717-63b8-08da180ed5ec
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2022 20:48:42.6033
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ic6GCQR4fNGAUO1K5TeeFGSmhvnoZa8WC5SF4Zr+1OvlswIogm1ZdoiRns2sM8X2ryzqAJVdi5raAqE5NnFBKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR10MB3362
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-06_12:2022-04-06,2022-04-06 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=923 malwarescore=0
 bulkscore=0 mlxscore=0 adultscore=0 phishscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204060103
X-Proofpoint-GUID: Edp9TS8sBswfDGly0-fVjK_xe7sveL42
X-Proofpoint-ORIG-GUID: Edp9TS8sBswfDGly0-fVjK_xe7sveL42
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
index 56cd75b6cfc0..0cf352555354 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -396,13 +396,6 @@ static int hugetlbfs_write_end(struct file *file, struct address_space *mapping,
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
 hugetlb_vmdelete_list(struct rb_root_cached *root, pgoff_t start, pgoff_t end)
 {
@@ -514,15 +507,14 @@ static void remove_inode_hugepages(struct inode *inode, loff_t lstart,
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
@@ -720,7 +712,7 @@ static long hugetlbfs_fallocate(struct file *file, int mode, loff_t offset,
 		}
 		clear_huge_page(page, addr, pages_per_huge_page(h));
 		__SetPageUptodate(page);
-		error = huge_add_to_page_cache(page, mapping, index);
+		error = hugetlb_add_to_page_cache(page, mapping, index);
 		if (unlikely(error)) {
 			restore_reserve_on_error(h, &pseudo_vma, addr, page);
 			put_page(page);
@@ -972,7 +964,7 @@ static int hugetlbfs_error_remove_page(struct address_space *mapping,
 	struct inode *inode = mapping->host;
 	pgoff_t index = page->index;
 
-	remove_huge_page(page);
+	hugetlb_delete_from_page_cache(page);
 	if (unlikely(hugetlb_unreserve_pages(inode, index, index + 1, 1)))
 		hugetlb_fix_reserve_counts(inode);
 
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index d1897a69c540..2cf99d769f61 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -640,8 +640,9 @@ struct page *alloc_huge_page_nodemask(struct hstate *h, int preferred_nid,
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
index 8fa2386bf7c0..c6d76f61de98 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5281,7 +5281,7 @@ static bool hugetlbfs_pagecache_present(struct hstate *h,
 	return page != NULL;
 }
 
-int huge_add_to_page_cache(struct page *page, struct address_space *mapping,
+int hugetlb_add_to_page_cache(struct page *page, struct address_space *mapping,
 			   pgoff_t idx)
 {
 	struct inode *inode = mapping->host;
@@ -5304,6 +5304,13 @@ int huge_add_to_page_cache(struct page *page, struct address_space *mapping,
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
@@ -5412,7 +5419,7 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 		new_page = true;
 
 		if (vma->vm_flags & VM_MAYSHARE) {
-			int err = huge_add_to_page_cache(page, mapping, idx);
+			int err = hugetlb_add_to_page_cache(page, mapping, idx);
 			if (err) {
 				put_page(page);
 				if (err == -EEXIST)
@@ -5788,11 +5795,11 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 
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
2.35.1

