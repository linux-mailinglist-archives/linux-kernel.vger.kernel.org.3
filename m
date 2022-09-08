Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B18895B26EF
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 21:38:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbiIHTiF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 15:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230330AbiIHThv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 15:37:51 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA5601023D1
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 12:37:42 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 288HJI5N029439;
        Thu, 8 Sep 2022 19:37:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2022-7-12;
 bh=fKhg03Nk2RnajJL1v/ZMLyGIvgJyZepFEO3jvsaU7fg=;
 b=t4px5A1N0zCeh9iVc71Up5zdpONsNWuaC5/oKEZZ6Bdw/aWc73ge090N3/GotyoKHjx+
 uz+Wh5Z802q8H9D/tc2428b/eFsQnk3PRlueyrFjOuYHfA3OqrRKmMb4znCsNn+cbyrJ
 ZKXRhFWEIC+fdsuhrTwDEEo9HIL8Sal8wkdDcd8+B2aH0CMFs+wmoMzBBUf1Uzo/r1qL
 vyfmWvn+YMABmlN355LWULxZVhhL2bgoNjC420I0akmj+kc6ZfcFcdC7qygrKeP2nI7S
 Jb9Lzek604w4ErCkdaOMytwKH1quIe+/Uo4rADO+p5mxCH0toN2t+cBpRQNDRYcK2MYz vg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jbxhsvuyp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Sep 2022 19:37:21 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 288IIACL031787;
        Thu, 8 Sep 2022 19:37:20 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jbwc6aasg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Sep 2022 19:37:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K16vVtozHL6AIlJn5YsO/+g5YSFUBDjy8lSByRudtiU0zNEERzKOIKHUEFbdQNAlsqjo8BVKeSJs5Vr0LfXXwBz1CuoulQ3wgFD3QsNPiHl25wv+FKuAxHS+1MMKTSNWHt+xDcMG88Tf10RcFmUW1hOzUs0id2Dohl2yELB7IQUCgWdhQQWRoQbKKe9/1x/1CVExKbq4pDFvRxZBIV+HVH6/GEoTht+WiJh4YzLf4CN0DtRDAhmbjO7bDpRBmUa0Trq9/FWugh7N8uA8OpSffH4qexdU8OplzU4nyrLom2O1woTeLjtuAX1SqrijfoZanOBBgxPQ4O9mom+w0iJdpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fKhg03Nk2RnajJL1v/ZMLyGIvgJyZepFEO3jvsaU7fg=;
 b=O8impU2IE833j07i4TSoHtnPWjc/6eBfGMUJBxiyOwcFuYuYIJSzeVm20T5KNYVD0ETIV9M31mKjDo1K5p3wZdVJF+hsLnNsRXw/M546sd0rqGLg7hnhpl7plTgXjryK6sIM2J3jxkhyTZcabaGDuleArI16y8fGvdTgHunK0Sw+qGbrCmRcbgm/fNLgqyQendpMgoZEXy3JSsAtqrtcKMmV2Jg7L0uscsn6I1TpfgqHpTZxpG2nqrsk4waJ9lyCb5G5JPCsyrHkD28v0zpf/5P5vRxEKStEeJnUU6HTm63haco54NaCofHBIYUuaYKwhXbK4XmaGD8IZ5f3ZUQ/GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fKhg03Nk2RnajJL1v/ZMLyGIvgJyZepFEO3jvsaU7fg=;
 b=SxKIZKrii2l5YQLVLIottZQckA8IwqLGNL7+afRp2guJHDjFXWhli74iJyAqE7mfEyC/9XZ133VO6dsLIfdcYzhKFOjS/SSJV/2HkIVhtCV9jNaHqDUisKDY4UKkgXtjN+CbX9M9vujNmPboEOmAG7zSCyb8p8S6HxdBxC4O5mg=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by PH7PR10MB6532.namprd10.prod.outlook.com (2603:10b6:510:203::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.16; Thu, 8 Sep
 2022 19:37:18 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::ec55:981e:3693:b37]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::ec55:981e:3693:b37%4]) with mapi id 15.20.5612.016; Thu, 8 Sep 2022
 19:37:18 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, willy@infradead.org, vbabka@suse.cz,
        william.kucharski@oracle.com, dhowells@redhat.com,
        peterx@redhat.com, arnd@arndb.de, ccross@google.com,
        hughd@google.com, ebiederm@xmission.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH v3 0/6] begin converting hugetlb code to folios
Date:   Thu,  8 Sep 2022 12:37:00 -0700
Message-Id: <20220908193706.1716548-1-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0P220CA0027.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::18) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|PH7PR10MB6532:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d65be93-869e-4746-884d-08da91d18a2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OR8l3/UHxO/btC1QFVd1XymD+yB4FNr0xX1dBC0uDRSkKAmeUDEs8N8NABbIYdbOUa32/78c8VcXa49xWVNy12HZ6ljcO+pWNcJ57cGwMeYwmZGCatEZYfJa8n/RRd5aIUKJZ2P/Rcgqb/JxkVujTGI95oZ3YbJgl4tkUOcfLwHfM9HZn6MeUnPp2mUf1cKd5GCn3gGYifYGt9Hv2grq5FKstRHVJyGYW/5dq+CgZckK9WI978zpuPSEIHM76Ojijlm2yrKFEUZIiYM50LKPz7Fawov2VwLn57JjWuV5b3OJeaueUdwSsVp8EFVyY9vXYFN9vi1pOkZDg4ZRr7s+zHkXy2tymJlYvNpScw92kA+6qgeMi7zvPzEOCSQbYzVM2LbGHlYYWbflkQ3AvM3wUmA4UNpPIp0QceI5x2iNcOTvSJt58So5o/XCGEB/0SfSJb9AkvqTMCha6VwJUcPnCwGu9xR/2aE9mzkD0BxayKuWZPBw4uoJGy/vw4ttsxHzW822ch+cHHQQLYTvulQdWXH0+dQrQGoPkWBaSYMHPS9uNTJtgFDJbpbvtBK1mV+09gDm5a+rS6C/PmY79gOboh2NfHlIv3geYsK32Dm+VDEemNdlCznSlaolQES3DFtj7ZPSrQIul24X7nGPOqBHHjtST7mRYk+xhEyU/uyonN6NlLspg0ZOewf37U+6VwmQxiB+w4BrXfG1gKsLwZaKR3euode0MkLgvfMxzICLelgg7VHaVbIVfi1STfRAoN+U+dLHilo6y8seIgJr1yhbWg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(39860400002)(366004)(136003)(396003)(376002)(7416002)(38100700002)(83380400001)(186003)(1076003)(2616005)(5660300002)(36756003)(66556008)(2906002)(66476007)(316002)(66946007)(8676002)(4326008)(8936002)(44832011)(6666004)(107886003)(86362001)(6506007)(6512007)(26005)(478600001)(41300700001)(6486002)(966005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9kOWCZoFgzoFlfWTLnTSjxS0BCS0mcjlUKj5vhPTDxqqo58u8e0fmUwBKfps?=
 =?us-ascii?Q?ixlzsPbeqRJsRzVTU6j7iUVKcc0QJ+DKHQ8LF8uMQzSyZrS9T2O3b8oCrQpy?=
 =?us-ascii?Q?tx5VBMu6+nZJ/izCJPHyZfcQriWcxPBsqFFgLfqTaK0W1lBfo/eQq6PWAAYu?=
 =?us-ascii?Q?WmTOQx6jG24wJ7Nudyu7vCN8GXFfpYmj5PZAzbeYr3BOU/N+bHew80pDDVZQ?=
 =?us-ascii?Q?Y8DFruJF1Qk+TTMPbCBfG66DyQiOa7aCY2GwpuYTnhBLrQPMH1azqXVbCVS1?=
 =?us-ascii?Q?mvFNfFigPkTiNV2HPNwhWr60VXUNICiziNzGEWhXYSHHMi+9gqHTQz/F11U/?=
 =?us-ascii?Q?vzRHjNT/p01MR4/zG4ZIPRm5N7d6af94OCZJyyNzWxiw0Tb5g+z7yV2p0OMw?=
 =?us-ascii?Q?AF+dUM3auDrKKe2NE5PTtDZwkhpCHO5ulOR7TLv2zlrwj1oGOkXrnkZUZxm/?=
 =?us-ascii?Q?PjPHl1ehg2jxJrEs9WQHE583GsKhqrVQpojc6QcDmPgd7WwV9NBDus/Ny9sr?=
 =?us-ascii?Q?TO8TnlDuIAq29a0ZT569rH3t/cpry/NRvfABM2hCNpycibIvZp2ikwdSkQkA?=
 =?us-ascii?Q?Fl6pDmiizCykM+vHks8+Dkva0PwHM67xi8gbbCoIhNjO4rXB/DRTyHEkV95d?=
 =?us-ascii?Q?VOv9OaZuvz2nkMedrnK37tVH0kZ8gBpJqARH0UNu3Dgys/cCZpqOhotha3so?=
 =?us-ascii?Q?Eaa/bqQKZV4YtFC9U/F+0Zga7rilzunrMh5D2i9RjWUBoRJRVy8cu8a2biWa?=
 =?us-ascii?Q?o4LTAymykLdGFrJMY7lIEvbCD2xPnlAZW+bpfGObAiB3FSx0MebnqIGxYgtp?=
 =?us-ascii?Q?n0JbBMICNKg9JjDCdU/rdnueSd6rX3Uv1yPGdMLuxl6WrfaKWtLxMGsfI+HN?=
 =?us-ascii?Q?ST8J/BetxXWIyIdQwOGXAYLqHtqMscFhoPxFoPBFSuJbkdmamJTx/y96ujL6?=
 =?us-ascii?Q?rb8gk/b6aQhulpMxeyDOWKQnkfOAhIqHYp1x0VoCxx9Np//1ZmxTsogZc9wX?=
 =?us-ascii?Q?X3UkMCjn3QuUdNSO2ERKnu5nqPUrF3V0Oh3ThNVnJ+kUWrVc1N2CSUDpyELM?=
 =?us-ascii?Q?gmSM8i7hfesWvlvs2lnkE/xmR9yP5xr4WQjvbT7xHlmsOwlc2vHuembMLLKb?=
 =?us-ascii?Q?MRuZ6uNgmfpLRiXU26kFZvAjotbXcr+5qaiqOhANpjGNsg9GnbJKLn/2qBZ4?=
 =?us-ascii?Q?nEKdd1Eo5gu+f0cOQbnmYh/SVYHMLcxCQS5nOlUEPo7uQLpvYJFb8wiIl6yc?=
 =?us-ascii?Q?Nwi1hEO1/Y4FTfjDEMnILEQYNOEVs6dEzeLWbV6tpYGV7MPJv/Mj6xGcMTOL?=
 =?us-ascii?Q?70FPEkx5wiR8CXKBFZV/PLMaNe5lrYT4Xe+qHP3/ATgVQ1MdV5qxvt5+BEtw?=
 =?us-ascii?Q?1hBmKIhgkqHz2k3H7pumy2GdvICCg3NoHkc/HPs6Mo0OxyLUQ1A6uspiWWUF?=
 =?us-ascii?Q?yjGF7MkezYn08gqf270od7kygf6sqV5L/zToFxwNeHE8MXeHoXahtTED0edV?=
 =?us-ascii?Q?B9QzENC++tyB31D5kTP63SVzNd4VQE7qjQdJ7r6ie9rQ3UEIx/wtB6gNt34x?=
 =?us-ascii?Q?8K+VZq+6Z5lMbMV0r3trPlVl3tsXzWSJLn7+fOWEkLEuWXVCsZRlup8u9DM1?=
 =?us-ascii?Q?/Q=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d65be93-869e-4746-884d-08da91d18a2c
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2022 19:37:18.0119
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +rJ09HgHasYBsBj1nElo815+L4EGnpYULzNF6xUgNsPPSn3gEBgCe8LwrNGylwbAYtKeGsf9fe1HMFNnwDp0CcUTSNh4Kzrpc4uOelhIMDY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6532
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-08_12,2022-09-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 mlxlogscore=745 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209080069
X-Proofpoint-GUID: 4CK7ZuabavUHfUbM3PQ2NVSfNIV86MXI
X-Proofpoint-ORIG-GUID: 4CK7ZuabavUHfUbM3PQ2NVSfNIV86MXI
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series starts the conversion of the hugetlb code to operate
on struct folios rather than struct pages. This removes the ambiguitiy
of whether functions are operating on head pages, tail pages of compound
pages, or base pages. 

This series passes the linux test project hugetlb test cases.

Patch 1 adds hugeltb specific page macros that can operate on folios.

Patch 2 adds the private field of the first tail page to struct page.
For 32-bit, _private_1 alinging with page[1].private was confirmed by
using pahole. This patch depends on Matthew Wilcox's patch mm: Add the first tail
page to struct folio[1]:

Patchs 3-4 introduce hugetlb subpool helper functions which operate on
struct folios. These patches were tested using the hugepage-mmap.c
selftest along with the migratepages command.

Patch 5 converts hugetlb_delete_from_page_cache() to use folios. This
patch depends on Mike Kravetz's patch: hugetlb: rename remove_huge_page
to hugetlb_delete_from_page_cache[2].

Patch 6 adds a folio_hstate() function to get hstate information from a
folio and adds a user of folio_hstate().

Bpftrace was used to track time spent in the free_huge_pages function
during the ltp test cases as it is a caller of the hugetlb subpool
functions. From the histogram, the performance is similar before and
after the patch series. 

Time spent in 'free_huge_page'

6.0.0-rc2.master.20220823
@nsecs:
[256, 512)         14770 |@@@@@@@@@@@@@@@@@@@@@@@@@@@
			 |@@@@@@@@@@@@@@@@@@@@@@@@@			      |
[512, 1K)            155 |                                                    |
[1K, 2K)             169 |                                                    |
[2K, 4K)              50 |                                                    |
[4K, 8K)              14 |                                                    |
[8K, 16K)              3 |                                                    |
[16K, 32K)             3 |                                                    |


6.0.0-rc2.master.20220823 + patch series
@nsecs:
[256, 512)         13678 |@@@@@@@@@@@@@@@@@@@@@@@@@@@			      |
			 |@@@@@@@@@@@@@@@@@@@@@@@@@			      |
[512, 1K)            142 |                                                    |
[1K, 2K)             199 |                                                    |
[2K, 4K)              44 |                                                    |
[4K, 8K)              13 |                                                    |
[8K, 16K)              4 |                                                    |
[16K, 32K)             1 |                                                    |

[1] https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next/+/f0a284d27efbfcc1a46c2a6075a259e628ad29c0
[2] https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next/+/e829be3202116d9aeb94cc1ff64e89dcbf7c47d3

v2 -> v3:
- fix build error by defining folio_hsate() when CONFIG_HUGETLB_PAGE=n
v1 --> v2:
- test compiling on i386.
- change return type from int to bool in patch 1
- move _private_1 field in struct page to within a CONFIG_64BIT block in patch 2
- squash patch 7 from v1 into patch 6

Sidhartha Kumar (6):
  mm/hugetlb: add folio support to hugetlb specific flag macros
  mm: add private field of first tail to struct page and struct folio
  mm/hugetlb: add hugetlb_folio_subpool() helper
  mm/hugetlb: add hugetlb_set_folio_subpool() helper
  hugetlbfs: convert hugetlb_delete_from_page_cache() to use folios
  mm/hugetlb: add folio_hstate()

 fs/hugetlbfs/inode.c     | 22 ++++++++---------
 include/linux/hugetlb.h  | 53 +++++++++++++++++++++++++++++++++++++---
 include/linux/mm_types.h | 14 +++++++++++
 mm/migrate.c             |  2 +-
 4 files changed, 75 insertions(+), 16 deletions(-)

-- 
2.31.1

