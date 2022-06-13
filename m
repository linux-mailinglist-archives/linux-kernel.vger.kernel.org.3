Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F176D54A0E5
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 23:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351887AbiFMVJ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 17:09:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351873AbiFMVJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 17:09:32 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E24C63E8
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 13:47:04 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25DJdrbl014678;
        Mon, 13 Jun 2022 20:46:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=z/JuprzKcTYNvwaTPIUGAJtKXNVk+NxJd7grs2YMkVI=;
 b=BFiGYwIBnTpkzIZ9TFS0F0/ToSzjVVPXGJ43Pt9g2hV3kt2nO++FJp2IxFnOXyEqt5md
 mXEmrH3Twgzl1CD/idCEO1t0TYh/TQ1Pc+J4Nlasw0GuCCjfLGxxc7kH85KW7OPHl6jA
 KfuWB5WjCGDs30iCn0zhkL6fohmZU2oMo+HZq8419UbpkUt24o4Ssswcy3nRucyaOOe6
 OIHDclE7jbNDvZHz9Syh6ix8MrgA1P4L+ijK3/wJdHIn2dplNiLh0eX3GkImqhTrn7a2
 W/O6yPd14N0Hlh65by89yWtSSe56wEnUiVzeco3A44lmF56lUhAgMfMEPDQJaBKU02NE Gw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gmkktc4wc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Jun 2022 20:46:49 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25DKg760021606;
        Mon, 13 Jun 2022 20:46:48 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gpbv8s8cx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Jun 2022 20:46:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B8kDVsyhKcCZrrAz6O1QYwpg54BKg47w9Nl3a1/kaFqlZID7DIinpeE6z+XoGZgnpBGJ7g+MNxpPwJPKlTHsGE9JH/GpqzfoTLZLyZ8wMCXW+hxK1pvOCInFj+SKjv9Nywyo9GWh4Q4wbWRWzCGALEO3VstP1gSPQGzM8UBs+gtpCs//bNACoep1RSlscExEqLY/Rk1QDoAB6mxcrxmsHmaYD1UFd6/NJEg7SayF1QNktJU3quc948F7tQdbRRNoGD833/M2iiMLxz4o0/Q3tWToqcQiQDgAxIySNrCZK1VJ7yShE5H0hlPLk+f8P7nETD2DYuprFLCX24RCKI0vUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z/JuprzKcTYNvwaTPIUGAJtKXNVk+NxJd7grs2YMkVI=;
 b=mXQ46U2faFcJRdJMRWtXOVjl9076lCfBCtwPkJX/KTRcPdvnEbm+8hl/3r70CHw0ScavQ/Pg8DT3rkM57vQ3nO9ahdaQ6LRWBnVST/4MXm9iUHq3OQsKue2Xpqxl2FW52F13zT3A7GA2WzKRz6YyHC4VJn5K8ymuqvyG/2pZEDav31h48MS9f2dXoev5tzo3ksehKct8hTQ832QfVN4mkLCbao5+/2KfVOKEMDE25ovxk8trNbhtlLwOtuDTRrCWmsp8DWeUMZymLzjScFv/VXeQnvF092Lch2x9mjHKLRw8mcQm086UTZvAdYxTlcnDl/YTmbfvOvUdOZzKW/28sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z/JuprzKcTYNvwaTPIUGAJtKXNVk+NxJd7grs2YMkVI=;
 b=yf8BWCHo1zq1VJqu52UNVkqM6ixSjNEJpYdWNKRz7FwYFMG1oiQJnlqxIS2vl4/oVrd8Z+6g3f/Xof1D4w2gKsQkp2M20VI+2wfKRh4fzFHlOw6cttLfdENhxKdNJ0PgTZ7hAdA8mmn2W+HX5Hm1mhRKKMo8j0y2AKTJvYtEbKY=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BN7PR10MB2516.namprd10.prod.outlook.com (2603:10b6:406:c1::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.15; Mon, 13 Jun
 2022 20:46:45 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::2125:9bb7:bfeb:81f9]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::2125:9bb7:bfeb:81f9%8]) with mapi id 15.20.5332.022; Mon, 13 Jun 2022
 20:46:45 +0000
Date:   Mon, 13 Jun 2022 13:46:42 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     David Hildenbrand <david@redhat.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] hugetlbfs: zero partial pages during fallocate hole punch
Message-ID: <YqeiMlZDKI1Kabfe@monkey>
References: <20220613180858.15933-1-mike.kravetz@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220613180858.15933-1-mike.kravetz@oracle.com>
X-ClientProxiedBy: CO2PR05CA0003.namprd05.prod.outlook.com
 (2603:10b6:102:2::13) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a868c7ad-19fb-4ef9-575d-08da4d7dd44b
X-MS-TrafficTypeDiagnostic: BN7PR10MB2516:EE_
X-Microsoft-Antispam-PRVS: <BN7PR10MB2516A2A467C7F202A3D4B9B7E2AB9@BN7PR10MB2516.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cCFR7X5aeJSjCubEFG5fIolVTQk9raWowx8ncR3lAjTYXlCXPEnP1jVyiP/kvAk7AyyqkoUyDGePD3sQER7AXWYXoyh8PZmP76MHwN+mA2NdqGtKLZMHn69s/uL5vodWAvZ7XLQnlTgpsn0zHWvgMgF1KNO2+YMTxEaLFGI9fN5DbhxoidISTPjh95wtCuRGN/OgO7Fc8syEsiVp8e0C1s5AUPcNZHuxCpSL1m3TPBgrpk+1dzewnACDPYkjSFqLJ/fkqbt4YQ8xWJOH2qlnDaiPAFB3ZqCWzgOwS2uiJs06ISQDjpw+MoDdb1Yn9a6HfvZw3HPGUO1GidPIyNc7P0t5wSPIQ7ur9r3vAxeM2UufuxDyNKY9juA3gYCntCqV2h7QAxnnaUNbMpWt0gAuMuhtLIMIVzuwqxE6Y6WjJ8Vunrvy6tK5hVP3+ZzYGqZVuELRticzwRC28DKpSE7JQdHNq6RGqUM99so7ON52xz8cZ/0G/3wYD1f0bDF46ZbI09JxZqiRD8krmVTJmZBJdAKCphbqSi6NHVI88ZNB+pI1JK+rDYx7KywSjFu6mSbStK9K34GDDOXzaG4n5//iNGJFOofqPxzhAzYv4hlb/iMcLrfFOT/qiX9SxJO4rs35TarrJcyLmULANkEd3FYWdo79UzJOTWxrmMYsiao+92qbfNiqj8muYMHB8VfGWMc1AFcv7drUCFiR9byeEmP1Si9TtafFs7kU8PQN71DRQSGo7pdxquWxis7RKDNEZq332RsVpHaAoDAYA9a9Pa/RYA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(366004)(38100700002)(6506007)(6666004)(53546011)(33716001)(44832011)(5660300002)(83380400001)(86362001)(9686003)(508600001)(8676002)(2906002)(66946007)(8936002)(6486002)(966005)(186003)(66556008)(66476007)(6512007)(26005)(54906003)(4326008)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?beh7yrW3aLWRsNdFzzCL9m5s6PvsouXa/18pMKkAqBAxSNRZsXU/saYpzKny?=
 =?us-ascii?Q?cckDIhTuty3zAj5QISd4JyA7GZQuAcfLXwrkK2GHKlSdAuqrNm5kFqG0t7cV?=
 =?us-ascii?Q?R7uYPlfWgN/YcsD21GKDD1mPNcLupi8fV2CqMIkR6mlRBFZmwwGKf6T3W6/g?=
 =?us-ascii?Q?3dhtyMS5ijnB+/hRRNNT8DKfpu3mqBwhEuMEZuqDAQeRLjCNLL7vsUYzy9To?=
 =?us-ascii?Q?UAbOFaaIG3HZTR43AVKbW1RMIgQBlwUPJUyc67IUDzmcaaxsfNZYsoUI+MTC?=
 =?us-ascii?Q?MRkaSWaR1cjwfvRhdvK/rEK0YRS30kwspu/szvUkweVAbcY3pvgm1wl57LCi?=
 =?us-ascii?Q?1PB+OnNHu5A3N/LWZ3MuWVRu0QgcKFCMrb0WMRQQhU5x5DZi+ubbZ7TWeRPr?=
 =?us-ascii?Q?KSUn0xmO1ZolpsCwj9iUIsaawbHrRW3Ywmek/OcQpHL6BZU7JUk106R1Df1Y?=
 =?us-ascii?Q?rOuBm5h0y+MQELR5rpeahPlb28xAoNhB6+EZth9ypqvXTZ6ydDtjuyl5hRc1?=
 =?us-ascii?Q?w21FOiK96fYI/MbuD/aKG9s82oUAu/oy3YR6Qtzk+uPOnbsuwC/3wn+KWp5n?=
 =?us-ascii?Q?e1WcTSPrpWCniNSnQnn0x/M8ZKkd0XFsrfzwzC6JNEkEog7+eYLPQhqcwQDq?=
 =?us-ascii?Q?rq27sSrWB9T6m9rAJP8hFS+UCxWO2JT7cgXPjn5ulRogCcfmFr3FBzmosCGK?=
 =?us-ascii?Q?PbMp4DrMxJk9+mSybLSgsDJD3hSeRhjJlX/XTzzOME8ijd/GVmYcP4vuXcvx?=
 =?us-ascii?Q?IJp6QYV/fu93cKdTIWuQ/boF/wdEofMMVAcAt52wEAYRWpT+YLEz2GFVwqnV?=
 =?us-ascii?Q?8BvQjIowtxMXSlulOcZSbWF+XxQG3u+tRGQu0eVKmyY/mUgPt6cA58NK9zSQ?=
 =?us-ascii?Q?OIM196lWVY7/vQOQWmnj4hyFb97J3B3Cc6EtC3PduJnk0E5bD/uHe5Hbjblu?=
 =?us-ascii?Q?ZHCeYb/mgtWayeC1MBjnGhcJmxvmMq7DO6P8duaMxpJSNegTBuM2QskZwGgU?=
 =?us-ascii?Q?IFv4CS1AqvaYDbpDlTpQ9yjkgMUDf3uV26+CX/TeTexxhNYBJyneRp6NVgBD?=
 =?us-ascii?Q?JktwAXZpZDhaD3MZjDZXkg+cWiw6A4LPf0NPQAh6fG1mFU2qpzFJwSC8Dxw3?=
 =?us-ascii?Q?Yqeko3dWYwC5EVGVRg5diQr/jFINzWaRYrYp8r7+eUJ4npp32NoIG0DefzJl?=
 =?us-ascii?Q?4PUK2jglitpEZ41LJOH8G3Qutui2Gp+klSSwSoZ6mxMGa3UmbkGG5kr8Mahp?=
 =?us-ascii?Q?FSe6+BuIriWBWJA1VxbVgyYZQNz5yxB/1RADhAjW1HhhpURQoTVb9lSsvBLS?=
 =?us-ascii?Q?od0AxeX24VgL6jZZ1TEQxpD4AKCkRJ4u+AVP7CClvsuu181nm70j5loBJbJA?=
 =?us-ascii?Q?tlJOWMePyp1auzvANfCcx825sKkCmrpjBS8F4zaTqRBcE0Z5NlRkeKzs+op1?=
 =?us-ascii?Q?/2GuIlAh/s0f4gMrLkGZya4Y0YM50wYBmcwCTeEtLD3Mp75dGb7/dN85IhO0?=
 =?us-ascii?Q?ufEwsaoDOxssMm88Pd0OzzkOAiRi/vjRBzM8/ixQ2mCahyoWXGzlATDCu2Mp?=
 =?us-ascii?Q?bbzaxKGqDKKwlS/YViNdiyFevBiwyPk1C3Wxe8k1cOWfwhNMQoA4OPwTrKql?=
 =?us-ascii?Q?FRGPV+uuS480BZ02q9a8WbmC2HnTZy45cvTSwvJ4mTv/ZyZC2bJtxbDP6q/W?=
 =?us-ascii?Q?YncjSkJMkaKP/i0QLOqy0oo8U9KUy1Mr0VHfbgtRHuHXGGytv7gjftlzhLzf?=
 =?us-ascii?Q?tO56N0Q+iZwvTij0uVecyLt/EskzaD4=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a868c7ad-19fb-4ef9-575d-08da4d7dd44b
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2022 20:46:45.6335
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EnbIiAmRHoAswlOUxr2zcq+nqRkizYm9kn/3vFgaD/aLfkJjZJPutPS1cqgMpaTQGbheRdtH4SX7PqFnhRyqnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR10MB2516
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-13_08:2022-06-13,2022-06-13 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 adultscore=0
 phishscore=0 spamscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206130083
X-Proofpoint-GUID: d9n9DXpeWB2b71TYL2xlCj4hpVBzx5Wh
X-Proofpoint-ORIG-GUID: d9n9DXpeWB2b71TYL2xlCj4hpVBzx5Wh
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Below is v2 of the patch.  I was just going to change the type of start/end
hugetlbfs_zero_partial_page arguments.  However, Matthew also convinced me
to do the simple folio conversion.  Tested with new libhugetlbfs code.


From 36a18e0b07c2e189092cc2d516e8cfedcb57d191 Mon Sep 17 00:00:00 2001
From: Mike Kravetz <mike.kravetz@oracle.com>
Date: Mon, 13 Jun 2022 13:36:48 -0700
Subject: [Patch v2] hugetlbfs: zero partial pages during fallocate hole punch

hugetlbfs fallocate support was originally added with commit 70c3547e36f5
("hugetlbfs: add hugetlbfs_fallocate()").  Initial support only operated
on whole hugetlb pages.  This makes sense for populating files as other
interfaces such as mmap and truncate require hugetlb page size alignment.
Only operating on whole hugetlb pages for the hole punch case was a
simplification and there was no compelling use case to zero partial pages.

In a recent discussion[1] it was assumed that hugetlbfs hole punch would
zero partial hugetlb pages as that is in line with the man page
description saying 'partial filesystem  blocks  are  zeroed'.  However,
the hugetlbfs hole punch code actually does this:

        hole_start = round_up(offset, hpage_size);
        hole_end = round_down(offset + len, hpage_size);

Modify code to zero partial hugetlb pages in hole punch range.  It is
possible that application code could note a change in behavior.  However,
that would imply the code is passing in an unaligned range and expecting
only whole pages be removed.  This is unlikely as the fallocate
documentation states the opposite.

The current hugetlbfs fallocate hole punch behavior is tested with the
libhugetlbfs test fallocate_align[2].  This test will be updated to
validate partial page zeroing.

[1] https://lore.kernel.org/linux-mm/20571829-9d3d-0b48-817c-b6b15565f651@redhat.com/
[2] https://github.com/libhugetlbfs/libhugetlbfs/blob/master/tests/fallocate_align.c

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
v1->v2:	Change type of hugetlbfs_zero_partial_page start/end args to
	loff_t and convert function to use folio.  (Matthew)
 fs/hugetlbfs/inode.c | 68 ++++++++++++++++++++++++++++++++++----------
 1 file changed, 53 insertions(+), 15 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index eca1d0fabd7e..20336cb3c040 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -584,41 +584,79 @@ static void hugetlb_vmtruncate(struct inode *inode, loff_t offset)
 	remove_inode_hugepages(inode, offset, LLONG_MAX);
 }
 
+static void hugetlbfs_zero_partial_page(struct hstate *h,
+					struct address_space *mapping,
+					loff_t start,
+					loff_t end)
+{
+	pgoff_t idx = start >> huge_page_shift(h);
+	struct folio *folio;
+
+	folio = filemap_lock_folio(mapping, idx);
+	if (!folio)
+		return;
+
+	start = start & ~huge_page_mask(h);
+	end = end & ~huge_page_mask(h);
+	if (!end)
+		end = huge_page_size(h);
+
+	folio_zero_segment(folio, (size_t)start, (size_t)end);
+
+	folio_unlock(folio);
+	folio_put(folio);
+}
+
 static long hugetlbfs_punch_hole(struct inode *inode, loff_t offset, loff_t len)
 {
+	struct hugetlbfs_inode_info *info = HUGETLBFS_I(inode);
+	struct address_space *mapping = inode->i_mapping;
 	struct hstate *h = hstate_inode(inode);
 	loff_t hpage_size = huge_page_size(h);
 	loff_t hole_start, hole_end;
 
 	/*
-	 * For hole punch round up the beginning offset of the hole and
-	 * round down the end.
+	 * hole_start and hole_end indicate the full pages within the hole.
 	 */
 	hole_start = round_up(offset, hpage_size);
 	hole_end = round_down(offset + len, hpage_size);
 
-	if (hole_end > hole_start) {
-		struct address_space *mapping = inode->i_mapping;
-		struct hugetlbfs_inode_info *info = HUGETLBFS_I(inode);
+	inode_lock(inode);
 
-		inode_lock(inode);
+	/* protected by i_rwsem */
+	if (info->seals & (F_SEAL_WRITE | F_SEAL_FUTURE_WRITE)) {
+		inode_unlock(inode);
+		return -EPERM;
+	}
 
-		/* protected by i_rwsem */
-		if (info->seals & (F_SEAL_WRITE | F_SEAL_FUTURE_WRITE)) {
-			inode_unlock(inode);
-			return -EPERM;
-		}
+	i_mmap_lock_write(mapping);
+
+	/* If range starts before first full page, zero partial page. */
+	if (offset < hole_start)
+		hugetlbfs_zero_partial_page(h, mapping,
+				offset, min(offset + len, hole_start));
 
-		i_mmap_lock_write(mapping);
+	/* Unmap users of full pages in the hole. */
+	if (hole_end > hole_start) {
 		if (!RB_EMPTY_ROOT(&mapping->i_mmap.rb_root))
 			hugetlb_vmdelete_list(&mapping->i_mmap,
 					      hole_start >> PAGE_SHIFT,
 					      hole_end >> PAGE_SHIFT, 0);
-		i_mmap_unlock_write(mapping);
-		remove_inode_hugepages(inode, hole_start, hole_end);
-		inode_unlock(inode);
 	}
 
+	/* If range extends beyond last full page, zero partial page. */
+	if ((offset + len) > hole_end && (offset + len) > hole_start)
+		hugetlbfs_zero_partial_page(h, mapping,
+				hole_end, offset + len);
+
+	i_mmap_unlock_write(mapping);
+
+	/* Remove full pages from the file. */
+	if (hole_end > hole_start)
+		remove_inode_hugepages(inode, hole_start, hole_end);
+
+	inode_unlock(inode);
+
 	return 0;
 }
 
-- 
2.35.3

