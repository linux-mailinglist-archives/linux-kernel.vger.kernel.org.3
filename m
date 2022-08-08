Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7019B58CFA4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 23:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244355AbiHHV3U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 17:29:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234943AbiHHV3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 17:29:16 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D06B193D4
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 14:29:15 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 278LHd3j004387;
        Mon, 8 Aug 2022 21:28:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2022-7-12;
 bh=xasOB2N2R/Ez4cV8u+YqMTVxj+8UmndA0NcsO5kf2w8=;
 b=q4y0vyoV/7ljUdnRffxo+yt4G0pINzFMGbGQ9xoEMG1Ubmn8mSdPz3WL3aF2l1j+47qb
 b3TuytVxG3dWYDoUUOrjh0vYhDjqiWRvLndmK/Bh9zU+EQ4adFQVazeoFYLSRQkOOSmq
 yTIiD0cgbcmBBCvitnCjdph8ZtOlfF6iMwad+uNlVW6I9Yp5MQcXAQ1x77ZYa/3qQ2ti
 lItRHsZqd4jljmsNTPSuNJ4MLU8upNFCZCggpEcPiE0n8N0ZoE/uAhRnCfLjBAA/bZPh
 dqn/MoBrAttyIQVrRQNB/6SGxoB3FctYNIdYQQkndXj0Ly4OSEVxSvEzqvhsrEkI+QZk Hg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hsgut4umf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 Aug 2022 21:28:48 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 278KfCDa027906;
        Mon, 8 Aug 2022 21:28:47 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2109.outbound.protection.outlook.com [104.47.70.109])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hu0q28mjd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 Aug 2022 21:28:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BaIHEkki85GUwF78dftxPTBhUEiIGV0EtOh9phI5M8MwoGHhn8GJQ1zQ0XrZoBecefY/fLl3pYT3jKfbGH2YmnFAiM0V6KqU2VKu+DonJvNsaMCCdRHOvj9XSiExY+dRuzXgqhvoY8fO1hEfR4L0xMK/y8TgNaoQY6FL+AL0bC2HCvVul+J+vhL846iYjkFD+evvHlg4oxL3xKrXTlGiNFRCWL1rE4Gp1vC9JpGVNfP6L7ysZaSPn9aSBIs6VjKiibOkMkaXzGNEtHzCCJziMShJLo7/KEnfSx+8Ns1B8E/5bDfqSOrzID/MflcuYHVWI7BULQTRphIXXrbEanrIOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xasOB2N2R/Ez4cV8u+YqMTVxj+8UmndA0NcsO5kf2w8=;
 b=F9j0/Zek2+Ex7hIfCs1N+F0WOpdSWVRC2NJuFynH+bfjAuutnnWJRJI5LiWxuI9QFsC7Tx8ARelvwQTUEe+fOS1kEOFtZOyXAOty5DoaERjdmPftKqHknoqAqHjNWMzeWj5nxjoKUM5N6WkHK5xf4c6Vnex75TzjlV+GXX8Fna5zjF2SoH+Eng5AMbih35x4wEDpfC0oS20oUXauQW9yWXQnhKRBk5Ex2ElDBODeody6wGxIh+xDYPmRbBHJWnSIRaTP7vPE/64+sjixg3vrGhr1MR6Zsf+snnOkPQXxGMUxZCgW4vpibKP8Dycd0DA0OXvJZc1Ynunv+IYsBALjyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xasOB2N2R/Ez4cV8u+YqMTVxj+8UmndA0NcsO5kf2w8=;
 b=Yv1GwvMsCg7bGzvGKTdrWsJpY8B1y2Ei+N1rkSMUBstiniqRZJ8QVn2i4OpO5LxKvYp1K7JDBoyPQWi9V9Zg2evWjV3xfMsT1tw/fhmEcvc5lvx1bxfe/tbZjHUH2T/EERYBw0MQiZx4IHUs9hq+30phzuXz+YNVxa6sjR+t2nI=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BN8PR10MB3300.namprd10.prod.outlook.com (2603:10b6:408:cc::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.15; Mon, 8 Aug
 2022 21:28:42 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c1ba:c197:f81f:ec0]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c1ba:c197:f81f:ec0%5]) with mapi id 15.20.5504.020; Mon, 8 Aug 2022
 21:28:41 +0000
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>, Peter Xu <peterx@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH] hugetlb: freeze allocated pages before creating hugetlb pages
Date:   Mon,  8 Aug 2022 14:28:36 -0700
Message-Id: <20220808212836.111749-1-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW2PR16CA0004.namprd16.prod.outlook.com (2603:10b6:907::17)
 To BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9c7117aa-3b4b-43b2-715b-08da7984f6fd
X-MS-TrafficTypeDiagnostic: BN8PR10MB3300:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I0Wc7IZIFZbYlrWQXh3DNkznzPEgzUhT8JNghJdzzuH6RuUUwEwxhbWZm+IOKOzeNJ9jXT9pPfkUajp9QhCtqcBKQLUykXl7HS3yUNPWn3QQdI7NaSJ316dtCGTUK9PbmQgh/Mnq0p+TFMaejEV75RLG3UJdjicY+ypUw8muEvAZfswvjSYCq61qrw54cRj2+9tBQfik6RQLnHas6gM0T1LanzzAzzul2/N2I9XdY6AxXFWi7bhaNj4LkiMc1XjtubIPX19YlDxYRAdfumownVDp5m6yaEUcrhJlDmUITgSE5eixzrEQ1y1z09fxv941uVD/VXtG5roTJyl6NZQa3zHs9TOnrtku0fYtJ995sVqXeqJRKfYHCHPUtsBmTSPczz80WzsgWs9AaRxs5jjkyIWiJN+2Rf4LFgA53ZRXPnCVwXT/ovUsrkgmmfQHcYT40gFm2H3s0KJF6heAF2yqtwTmvhQQWB99/nbHxfClAzAdTpOoPcOmfym440tKsJbxzopVlvbmmEGycUUMQHUK5CW64aEWWiUB/JyZG9DQq4Tt4rqoplF97xlQH+Gpjcbq2vjvxK1uN7PY2cCPEZ+HvMvnqpEv9qsrQ8PvEbEx9txMZDkPUgOpmP0mdU2tOdOv3Qe6kqlwkm7F8wfQbi88LQKswyqsHnF0YDNoOxiSV41dhIf2ZrHhf6HcKB0cdD0u5KLUmsastt2gYN9WrV/g+ygQSwdlkKVJMCygwm5RRqUYrNM58BgPE+iKS+NFrKBn0Fw+RgYYfksNg1nkJgz7yPhfVZPcUVvG4Ay30MtvLkboklV6sBdwldyk5vm5YagC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(39860400002)(376002)(346002)(396003)(136003)(186003)(5660300002)(2616005)(478600001)(107886003)(1076003)(966005)(6486002)(8676002)(26005)(66946007)(6512007)(6506007)(86362001)(36756003)(66476007)(6666004)(30864003)(66556008)(41300700001)(44832011)(83380400001)(2906002)(54906003)(4326008)(8936002)(316002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CCNXtdCbM+tezUjEtnxy3v1UU4Nw0LKCl3qfQW3aC8nNPITZBv+Ng9Ehi/ZN?=
 =?us-ascii?Q?VeHPJehwc55qO9mTY1FQyeisnCclPRFN7um2ovCSor0/COFcbfjE3E8UARrK?=
 =?us-ascii?Q?u6tR2VRnHwpQVKG1IYfj8nYLGJHxuWS3rOy2J5/2C8+uybiimDI1orxRtatd?=
 =?us-ascii?Q?eW81WCJ9Jj70k6WJwhR8aLbRhn9q11oWCEUhDJWeT76mYLQouHmRl0BZkAOR?=
 =?us-ascii?Q?dVZuKFxciGMIrbdxdyj1P7qKmRaJHhrSjmETgFqlYCbZLQli5deXQ3UwIuVT?=
 =?us-ascii?Q?A+b5bO29YRNQbf9+GR7VSaepDpcNTi/om90qxDSx0N0SGidY8fk9U3Oq3rkc?=
 =?us-ascii?Q?xyw+gKer5qeSNH2fPyT8NHkYRehljwMESjUN5ndfTOQCzrzTQICOaP/UHiwT?=
 =?us-ascii?Q?IzBuJfUQHKGhtYo8jm+TlBX4r+LSjLNxIsK+ibj/y0S+m+JhLMD5hF+ju2SX?=
 =?us-ascii?Q?rT+gzyiYlbndLaZFU3JK/iVeWrLj4JW1FzX9Pj+5KBBSF35sEoDq74twqwhf?=
 =?us-ascii?Q?GT8w7NemcyFUUUo819hVE3J35gE4T2dTPpAJf4UADhbKdgcDQKLVYg7slPWU?=
 =?us-ascii?Q?q1KIqKIfvBQcsvFMzEz4uBFb24pVUyKo7hj1DOEK2O+r6Ttor9UjTEzpjpkz?=
 =?us-ascii?Q?mzfVUOP8A3d/V5xU+zDawwfxfrmU+k3D4oclsSTJsGji2staV51uD+yis9aT?=
 =?us-ascii?Q?9HZDeo8/qBkNQNOF23gsd0BcAqEz3QuUP3kJB6nN69Mp/j576nR2FF03Rs2T?=
 =?us-ascii?Q?77uBug08Xgf4E7Saor+UXN3/aKO8TY9R2JZQ12FTcU/3tWuLRjNC2GMqa9nH?=
 =?us-ascii?Q?EDQE1CYYR266r3/hTKq9TCsvIHT1VP8AQdQJx7lnE9jh8xZ5E1lVcbPxXTjw?=
 =?us-ascii?Q?lfwsDO2Tw8g/cZEfG9bkhhYQtlH6ke8OhE08ZsqNX6yUrp7HEO6HPqMnEpdj?=
 =?us-ascii?Q?G8r4AWX4r4FAnGkG3g1soxULj2+6qDAaaYw9gLjlXi1hLZUEnFSTib9wYPV8?=
 =?us-ascii?Q?TTFQ1QrB5NjiGMqyJp/DugZs2czn2X7c0CzCmRubsLwbS82vcY96G4rqOael?=
 =?us-ascii?Q?ObcATDO1WU4d//5GEXJ2lvs+VRp/9r+EofR5etd6lS7k4eJRn3ceMW5n+2vk?=
 =?us-ascii?Q?iYPocm88YVYn41l4Zz8LJPCTOunz9rB6I/lq69C5ABaScW7E232YcZ3d6rUU?=
 =?us-ascii?Q?qOsYl+5XFSHbgD2CP7+W2nyhCxZCyzBpCt/wnH47Y3R4ku1GzL1ve6D6Nhca?=
 =?us-ascii?Q?vloPRfsNz1MqdU9IMKycoX5VBJoc6rU9AqLZc7U4Dr3d5qrXle1WtozegWGy?=
 =?us-ascii?Q?hZyagJ/oiZa2kYWQsUmQFGToneTjGMOtIiP8YclawSZUpciklSOgY6N6f2+R?=
 =?us-ascii?Q?/CfVDJe+SGmJL9pFs56L+zL/9GOMzrY4d9gSA6dwrW5m0XilpYjZTPUnbPnt?=
 =?us-ascii?Q?POYN5OOqeHzsZffa6Kvf5GBOrHKP384yluOs9PFPjdiTiiSzObqPgj2sRi/U?=
 =?us-ascii?Q?GGHn6AjlZY6JinyLJVQVmnuHhflFnbYHXJub08Gt2WqEGIWJ4C+rRHKRdWCA?=
 =?us-ascii?Q?+kwhgW8SNrrbs3UfB3MHK6d2Ix+9vl0pghkZxQapo3Vi9otTNmr0LbLKXLLL?=
 =?us-ascii?Q?pw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c7117aa-3b4b-43b2-715b-08da7984f6fd
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2022 21:28:41.4513
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iRN/rlOAQhTRnymB5LXCGEy+JdRYhcj4Vpa9oTnrDySq/GdH+Eq1K6SDnW4KL51TZ6WqxteoFoA7yy+Q+UwzrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR10MB3300
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-08_13,2022-08-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 spamscore=0
 phishscore=0 bulkscore=0 adultscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2208080092
X-Proofpoint-ORIG-GUID: eu6DOETUKWYPMCgD2k2XNV8eAjO1fOWu
X-Proofpoint-GUID: eu6DOETUKWYPMCgD2k2XNV8eAjO1fOWu
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When creating hugetlb pages, the hugetlb code must first allocate
contiguous pages from a low level allocator such as buddy, cma or
memblock.  The pages returned from these low level allocators are
ref counted.  This creates potential issues with other code taking
speculative references on these pages before they can be transformed to
a hugetlb page.  This issue has been addressed with methods and code
such as that provided in [1].

Recent discussions about vmemmap freeing [2] have indicated that it
would be beneficial to freeze all sub pages, including the head page
of pages returned from low level allocators before converting to a
hugetlb page.  This helps avoid races if want to replace the page
containing vmemmap for the head page.

There have been proposals to change at least the buddy allocator to
return frozen pages as described at [3].  If such a change is made, it
can be employed by the hugetlb code.  However, as mentioned above
hugetlb uses several low level allocators so each would need to be
modified to return frozen pages.  For now, we can manually freeze the
returned pages.  This is done in two places:
1) alloc_buddy_huge_page, only the returned head page is ref counted.
   We freeze the head page, retrying once in the VERY rare case where
   there may be an inflated ref count.
2) prep_compound_gigantic_page, for gigantic pages the current code
   freezes all pages except the head page.  New code will simply freeze
   the head page as well.

In a few other places, code checks for inflated ref counts on newly
allocated hugetlb pages.  With the modifications to freeze after
allocating, this code can be removed.

After hugetlb pages are freshly allocated, they are often added to the
hugetlb free lists.  Since these pages were previously ref counted, this
was done via put_page() which would end up calling the hugetlb
destructor: free_huge_page.  With changes to freeze pages, we simply
call free_huge_page directly to add the pages to the free list.

In a few other places, freshly allocated hugetlb pages were immediately
put into use, and the expectation was they were already ref counted.  In
these cases, we must manually ref count the page.

[1] https://lore.kernel.org/linux-mm/20210622021423.154662-3-mike.kravetz@oracle.com/
[2] https://lore.kernel.org/linux-mm/20220802180309.19340-1-joao.m.martins@oracle.com/
[3] https://lore.kernel.org/linux-mm/20220531150611.1303156-1-willy@infradead.org/

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 mm/hugetlb.c | 97 +++++++++++++++++++---------------------------------
 1 file changed, 35 insertions(+), 62 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 28516881a1b2..6b90d85d545b 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1769,13 +1769,12 @@ static bool __prep_compound_gigantic_page(struct page *page, unsigned int order,
 {
 	int i, j;
 	int nr_pages = 1 << order;
-	struct page *p = page + 1;
+	struct page *p = page;
 
 	/* we rely on prep_new_huge_page to set the destructor */
 	set_compound_order(page, order);
-	__ClearPageReserved(page);
 	__SetPageHead(page);
-	for (i = 1; i < nr_pages; i++, p = mem_map_next(p, page, i)) {
+	for (i = 0; i < nr_pages; i++, p = mem_map_next(p, page, i)) {
 		/*
 		 * For gigantic hugepages allocated through bootmem at
 		 * boot, it's safer to be consistent with the not-gigantic
@@ -1814,7 +1813,8 @@ static bool __prep_compound_gigantic_page(struct page *page, unsigned int order,
 		} else {
 			VM_BUG_ON_PAGE(page_count(p), p);
 		}
-		set_compound_head(p, page);
+		if (i != 0)
+			set_compound_head(p, page);
 	}
 	atomic_set(compound_mapcount_ptr(page), -1);
 	atomic_set(compound_pincount_ptr(page), 0);
@@ -1918,6 +1918,7 @@ static struct page *alloc_buddy_huge_page(struct hstate *h,
 	int order = huge_page_order(h);
 	struct page *page;
 	bool alloc_try_hard = true;
+	bool retry = true;
 
 	/*
 	 * By default we always try hard to allocate the page with
@@ -1933,7 +1934,21 @@ static struct page *alloc_buddy_huge_page(struct hstate *h,
 		gfp_mask |= __GFP_RETRY_MAYFAIL;
 	if (nid == NUMA_NO_NODE)
 		nid = numa_mem_id();
+retry:
 	page = __alloc_pages(gfp_mask, order, nid, nmask);
+
+	/* Freeze head page */
+	if (!page_ref_freeze(page, 1)) {
+		__free_pages(page, order);
+		if (retry) {	/* retry once */
+			retry = false;
+			goto retry;
+		}
+		/* WOW!  twice in a row. */
+		pr_warn("HugeTLB head page unexpected inflated ref count\n");
+		page = NULL;
+	}
+
 	if (page)
 		__count_vm_event(HTLB_BUDDY_PGALLOC);
 	else
@@ -1961,6 +1976,9 @@ static struct page *alloc_buddy_huge_page(struct hstate *h,
 /*
  * Common helper to allocate a fresh hugetlb page. All specific allocators
  * should use this function to get new hugetlb pages
+ *
+ * Note that returned page is 'frozen':  ref count of head page and all tail
+ * pages is zero.
  */
 static struct page *alloc_fresh_huge_page(struct hstate *h,
 		gfp_t gfp_mask, int nid, nodemask_t *nmask,
@@ -2018,7 +2036,7 @@ static int alloc_pool_huge_page(struct hstate *h, nodemask_t *nodes_allowed,
 	if (!page)
 		return 0;
 
-	put_page(page); /* free it into the hugepage allocator */
+	free_huge_page(page); /* free it into the hugepage allocator */
 
 	return 1;
 }
@@ -2175,10 +2193,9 @@ int dissolve_free_huge_pages(unsigned long start_pfn, unsigned long end_pfn)
  * Allocates a fresh surplus page from the page allocator.
  */
 static struct page *alloc_surplus_huge_page(struct hstate *h, gfp_t gfp_mask,
-		int nid, nodemask_t *nmask, bool zero_ref)
+						int nid, nodemask_t *nmask)
 {
 	struct page *page = NULL;
-	bool retry = false;
 
 	if (hstate_is_gigantic(h))
 		return NULL;
@@ -2188,7 +2205,6 @@ static struct page *alloc_surplus_huge_page(struct hstate *h, gfp_t gfp_mask,
 		goto out_unlock;
 	spin_unlock_irq(&hugetlb_lock);
 
-retry:
 	page = alloc_fresh_huge_page(h, gfp_mask, nid, nmask, NULL);
 	if (!page)
 		return NULL;
@@ -2204,34 +2220,10 @@ static struct page *alloc_surplus_huge_page(struct hstate *h, gfp_t gfp_mask,
 	if (h->surplus_huge_pages >= h->nr_overcommit_huge_pages) {
 		SetHPageTemporary(page);
 		spin_unlock_irq(&hugetlb_lock);
-		put_page(page);
+		free_huge_page(page);
 		return NULL;
 	}
 
-	if (zero_ref) {
-		/*
-		 * Caller requires a page with zero ref count.
-		 * We will drop ref count here.  If someone else is holding
-		 * a ref, the page will be freed when they drop it.  Abuse
-		 * temporary page flag to accomplish this.
-		 */
-		SetHPageTemporary(page);
-		if (!put_page_testzero(page)) {
-			/*
-			 * Unexpected inflated ref count on freshly allocated
-			 * huge.  Retry once.
-			 */
-			pr_info("HugeTLB unexpected inflated ref count on freshly allocated page\n");
-			spin_unlock_irq(&hugetlb_lock);
-			if (retry)
-				return NULL;
-
-			retry = true;
-			goto retry;
-		}
-		ClearHPageTemporary(page);
-	}
-
 	h->surplus_huge_pages++;
 	h->surplus_huge_pages_node[page_to_nid(page)]++;
 
@@ -2253,6 +2245,9 @@ static struct page *alloc_migrate_huge_page(struct hstate *h, gfp_t gfp_mask,
 	if (!page)
 		return NULL;
 
+	/* fresh huge pages are frozen */
+	set_page_refcounted(page);
+
 	/*
 	 * We do not account these pages as surplus because they are only
 	 * temporary and will be released properly on the last reference
@@ -2280,14 +2275,14 @@ struct page *alloc_buddy_huge_page_with_mpol(struct hstate *h,
 		gfp_t gfp = gfp_mask | __GFP_NOWARN;
 
 		gfp &=  ~(__GFP_DIRECT_RECLAIM | __GFP_NOFAIL);
-		page = alloc_surplus_huge_page(h, gfp, nid, nodemask, false);
+		page = alloc_surplus_huge_page(h, gfp, nid, nodemask);
 
 		/* Fallback to all nodes if page==NULL */
 		nodemask = NULL;
 	}
 
 	if (!page)
-		page = alloc_surplus_huge_page(h, gfp_mask, nid, nodemask, false);
+		page = alloc_surplus_huge_page(h, gfp_mask, nid, nodemask);
 	mpol_cond_put(mpol);
 	return page;
 }
@@ -2358,7 +2353,7 @@ static int gather_surplus_pages(struct hstate *h, long delta)
 	spin_unlock_irq(&hugetlb_lock);
 	for (i = 0; i < needed; i++) {
 		page = alloc_surplus_huge_page(h, htlb_alloc_mask(h),
-				NUMA_NO_NODE, NULL, true);
+				NUMA_NO_NODE, NULL);
 		if (!page) {
 			alloc_ok = false;
 			break;
@@ -2720,7 +2715,6 @@ static int alloc_and_dissolve_huge_page(struct hstate *h, struct page *old_page,
 {
 	gfp_t gfp_mask = htlb_alloc_mask(h) | __GFP_THISNODE;
 	int nid = page_to_nid(old_page);
-	bool alloc_retry = false;
 	struct page *new_page;
 	int ret = 0;
 
@@ -2731,30 +2725,9 @@ static int alloc_and_dissolve_huge_page(struct hstate *h, struct page *old_page,
 	 * the pool.  This simplifies and let us do most of the processing
 	 * under the lock.
 	 */
-alloc_retry:
 	new_page = alloc_buddy_huge_page(h, gfp_mask, nid, NULL, NULL);
 	if (!new_page)
 		return -ENOMEM;
-	/*
-	 * If all goes well, this page will be directly added to the free
-	 * list in the pool.  For this the ref count needs to be zero.
-	 * Attempt to drop now, and retry once if needed.  It is VERY
-	 * unlikely there is another ref on the page.
-	 *
-	 * If someone else has a reference to the page, it will be freed
-	 * when they drop their ref.  Abuse temporary page flag to accomplish
-	 * this.  Retry once if there is an inflated ref count.
-	 */
-	SetHPageTemporary(new_page);
-	if (!put_page_testzero(new_page)) {
-		if (alloc_retry)
-			return -EBUSY;
-
-		alloc_retry = true;
-		goto alloc_retry;
-	}
-	ClearHPageTemporary(new_page);
-
 	__prep_new_huge_page(h, new_page);
 
 retry:
@@ -2934,6 +2907,7 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
 		}
 		spin_lock_irq(&hugetlb_lock);
 		list_add(&page->lru, &h->hugepage_activelist);
+		set_page_refcounted(page);
 		/* Fall through */
 	}
 	hugetlb_cgroup_commit_charge(idx, pages_per_huge_page(h), h_cg, page);
@@ -3038,7 +3012,7 @@ static void __init gather_bootmem_prealloc(void)
 		if (prep_compound_gigantic_page(page, huge_page_order(h))) {
 			WARN_ON(PageReserved(page));
 			prep_new_huge_page(h, page, page_to_nid(page));
-			put_page(page); /* add to the hugepage allocator */
+			free_huge_page(page); /* add to the hugepage allocator */
 		} else {
 			/* VERY unlikely inflated ref count on a tail page */
 			free_gigantic_page(page, huge_page_order(h));
@@ -3070,7 +3044,7 @@ static void __init hugetlb_hstate_alloc_pages_onenode(struct hstate *h, int nid)
 					&node_states[N_MEMORY], NULL);
 			if (!page)
 				break;
-			put_page(page); /* free it into the hugepage allocator */
+			free_huge_page(page); /* free it into the hugepage allocator */
 		}
 		cond_resched();
 	}
@@ -3459,9 +3433,8 @@ static int demote_free_huge_page(struct hstate *h, struct page *page)
 		else
 			prep_compound_page(page + i, target_hstate->order);
 		set_page_private(page + i, 0);
-		set_page_refcounted(page + i);
 		prep_new_huge_page(target_hstate, page + i, nid);
-		put_page(page + i);
+		free_huge_page(page + i);
 	}
 	mutex_unlock(&target_hstate->resize_lock);
 
-- 
2.37.1

