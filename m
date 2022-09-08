Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01DC75B26C6
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 21:34:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbiIHTet (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 15:34:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230482AbiIHTeq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 15:34:46 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7072520BF1
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 12:34:45 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 288HJYS8013955;
        Thu, 8 Sep 2022 19:34:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2022-7-12;
 bh=fKhg03Nk2RnajJL1v/ZMLyGIvgJyZepFEO3jvsaU7fg=;
 b=GSC7aXW2Y5VEvhmKzEjWZjBviy7Yc+DvFeyOZMP9pLJ0TbaoMtwUDL5O3yYWJv0dsV63
 uyaIsbVgWtlBRQ7vGYVtMCkGA1+JfqSv/aJGqJ1Hmf1QBnj4N6kl6RHML8v05ewrskhd
 LbhAiuVQo7j5WXfzvZi7aT03tsW0+7pe3X9lb/R8S3q3u1lQDU+5zsydIKB1UWkn+gOv
 pdA6esqAfTk2imOpX38eqdi9W3Hnz7MpmvQJsS6+qbnVcSqKU8D5TuTuGBQebToccy/p
 rMdDoO/wnX6rvhhLvVPqQStEvUunBuosJa6/X7DfsjPdffrnnXflnLVtlv7g6Oy1S2gK /g== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jbyftvxs1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Sep 2022 19:34:17 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 288IEAA4031691;
        Thu, 8 Sep 2022 19:34:16 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jbwc6a2bh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Sep 2022 19:34:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k9yDa4xrZ7wax0JRvAwtAksKuHPvD8N6Qwhz5dp+CqN38kwT83jRZL+qMOjBr8YeA2fccR9q8U4DIGWc5zOyQLAw/7TyVipl4qCvu4NtEHIHCV6/lD8RbcpebxS1XjUUIRmRCUYPPCCkBVSrpHMU02qgsqA/9KYDKOu3ZZ1FSF3CgTZQcZ3t6MqOjDCIGVLwcFZ5BJ+DuTMLrgr1UqTSBxgJEcknmx/I7xR/1FeKYPK8mwRoi7dggP6b3jhAVxZSzud4iUVlXv/QzN7DBdXxsivtxOAO1WoZjXGkCznt0J55XDbJZC3HHvQTWs7pqPVNIbxbiCr97Msgs7eobWAylw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fKhg03Nk2RnajJL1v/ZMLyGIvgJyZepFEO3jvsaU7fg=;
 b=TiLLRSuBhXdKPsnl4QObRblYpnSjSKbTlwQqDs4pO06OkIn07DXdn8EU2tfQFBCas9/GVpeWNGfPdnbVv++EVcZ/9KOgnI5GVPukQDwntOKJp1wZyQQOwzyyyQZZOSUdszzBASZa4th0ltFpld3HSS0jFqutiu3Yyfd0OVsx9qlhwIb9CGBWfhe73njUjOcMRYSGJqaRGT76WVImRwgJ5bP/b8/LLBze7C5iVtQpgs7IiTkdaff9YroLb88Rr6q9fOCGHVe1WIKi3RDTkgV19tpELaUspDLtXaYGOnsn6zygB3j8t8maIdIDJ5aXcfMlteNM08bMsCHnvluMucMruQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fKhg03Nk2RnajJL1v/ZMLyGIvgJyZepFEO3jvsaU7fg=;
 b=vm5/IWvs3MMHeMgkl+zmjzX5yPgj6EUAlBICN5SgqqISVOAITXyyIBhdJyw0+nbQp1JJvGQVKLxUoY43DRwWhwtPA8AF9PPho+A+MxbOX5IeUQRtFKvEHKHx/Rz2JMTMDuvPf5T7wJtq3J3zxH/Koo9GFdq5sHung8rXozKEuZ4=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by BLAPR10MB5106.namprd10.prod.outlook.com (2603:10b6:208:30c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12; Thu, 8 Sep
 2022 19:34:14 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::ec55:981e:3693:b37]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::ec55:981e:3693:b37%4]) with mapi id 15.20.5612.016; Thu, 8 Sep 2022
 19:34:14 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, willy@infradead.org, vbabka@suse.cz,
        william.kucharski@oracle.com, dhowells@redhat.com,
        peterx@redhat.com, arnd@arndb.de, ccross@google.com,
        hughd@google.com, ebiederm@xmission.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH v3 0/6] begin converting hugetlb code to folios
Date:   Thu,  8 Sep 2022 12:33:47 -0700
Message-Id: <20220908193353.1712201-1-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR17CA0004.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::17) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|BLAPR10MB5106:EE_
X-MS-Office365-Filtering-Correlation-Id: e8beef9d-193e-428e-9cb1-08da91d11cb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PhPFr55rvQqjTt68QwOFkpPSARiVckeH7JpeBPKH2ovgJM3LXwN9STcbreB8GGXyBg3w9DZNoAlw9jI0cuqK2w+GLIAx3/NvkXZWMHakY6KV4ezD8gpTMqKdWj8/PF0ZoRm4mJ1txOEzOdnEilhYxZcbIdpRu/oE/0acN3XlmhJCVl4Q0xsnCwH7bkBLcQmk93WKYfdsVdv1n7ddQ6r60KudJukdHLY7uDZ8XIUlIBc4+o8HpH6b5tG1lKWVP/Xg0gIZeq+yw6WyTzVAoptz5kdxjZsZgfgTaaaW36NT5fK9eaopPw4zVgVVvT7NAkvQNbaG5K8tejjICWkkJ3m4f8+ApFvw7tLJ9RE6yu6W+XUV4Yghh5g8SkOE/x6TB8Szh6ry/xhRdwNCxed9tGRW9/U9Pu3GvGB1BP037NanqOWMhWPoF1DDbag1RfEQgwZcwMGzgmiCotLywLA0qA1w1Sl3LpUQ6OEaRPpa5+8mWgI+NISYxMc6baWePGH7AjDJ5Od90HVI3N3cCvq4J1kQ1qP5CH+6X2JDI4O2s+OE3Zb0DCW3xTR+jdrNP8vwtfW+WxBKF1fDEZX5dR7je9IvWpz5xyGSVTIn7jdynSVw6LMsSdA8yOrQrbl7DXIeg8GsQy6FM3mrOowBwvN0oIaCRLtZKFLCRFW4Z2mxwii0mKCpWVaHRsnsbDwuUvJ9qX7N6E+WduJ5jsSpz5VgYlLQbvF9FyBUsyrH4zYusvN5BPxpch0qo5jesIJwTv9fmwXtec5L8xJc6NLgqmrBflpfBA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(376002)(39860400002)(346002)(396003)(366004)(8936002)(66556008)(41300700001)(38100700002)(36756003)(186003)(4326008)(66476007)(2616005)(66946007)(1076003)(478600001)(83380400001)(86362001)(7416002)(107886003)(8676002)(6512007)(6506007)(2906002)(316002)(26005)(6486002)(44832011)(5660300002)(6666004)(966005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yrONKcvwkUNaE/1BzF7vFKcQj8r1P+VI49f+vsjCMkvU9/csBVDT6Fq2dAm/?=
 =?us-ascii?Q?xC7fwgLapt4eklSauAtysWaBLCBZsAiwYbbcAr91OQjQaJj9XJ9djBWwIk7n?=
 =?us-ascii?Q?+BINCQ5vhBuJHwGZ60ZAKj824DiMF53Xs8Wa09rvu2jKonxiZKFlC6x4YR6m?=
 =?us-ascii?Q?x0C4ibDGB2R9IArbojcjeIVmpWeWqOxzfbxAUUOVBHp5l0kmRIp5F4V5CWil?=
 =?us-ascii?Q?wczugQG6kVPhlY70coSjNj36+9tMsNtH+boeIgSyyvT5HNGvHqKbkbxBLIhU?=
 =?us-ascii?Q?XL4SqfVMs832mOJh79L3qFPjoS37XjESjUHeBifvxGgDRxaX1J2WJGQl9rZt?=
 =?us-ascii?Q?qCUSMLEG8K4/ZVpj3fZoDFCD1j21n/5je4H/fXZEz9QRjmVooHLUR7mbOdqz?=
 =?us-ascii?Q?e6OGU00DmumzfAPKKe4BZ1nO64ifAd1bZD/4F1ldR/91L5oAG2T5SOf2h+eZ?=
 =?us-ascii?Q?Kc4kx+/4KAa4QvB20j8RmCZoVeYV5KIAq1dsAoepCL9y+5hRpaWZVD95TUOQ?=
 =?us-ascii?Q?dt8ciHhiS9xP3/nYsQdYaHQdZsAmStaduwpa+BqEEER15zNxuIirEJo5DUWA?=
 =?us-ascii?Q?ZmwZ/ThkyRyHNJMSRgFmDwr/O1ZR95DwGI4axc59cZpejouzVq0Q1F4GKduO?=
 =?us-ascii?Q?vakDAwL2b3DeAeH8+hHNdKI0S/2TpDXn9RA24+wEQGUKcVQexi8uaxTWx2wv?=
 =?us-ascii?Q?YYmar/JbkpCEm5NyyvhW1Rw0RG+mWNPZEBkWBxIAb2OdUaZt0ID9mQ/3/lwn?=
 =?us-ascii?Q?h0klsZfc1rvU7VEUREEML/PjM/LxOm7yNMqNJZXAkVe/Je7G/niFo9XnxEG3?=
 =?us-ascii?Q?cvnv56pPqJvft3oWz1Eeh/D65IDnzVjuofXHQbNfv2U9ponvom8frxYzFrcD?=
 =?us-ascii?Q?s9k4sx2xtBdEvEfYejyiwALt/FQfOHCVSP1N3Fno4meQFcg7zRKM98PJqfyZ?=
 =?us-ascii?Q?c1y3GGksyYehV8StM3KrchyNH4rhmlvneaTuwC51jYKkPVIMnrMDtYu1FhFt?=
 =?us-ascii?Q?J1/UVxD8OtcHn326WZCkczOplv4YZK431Q5qm2VsjagnCeJNzGY8daajOEUl?=
 =?us-ascii?Q?rutCSTvJae5ghPQAgTBnWnBxrhZZwbudhQRWiRfA8sdR9hgNCE5dgphLlqG2?=
 =?us-ascii?Q?VW/pBcKuT6L44e/KEWyUC8MeVhYpefIvjAPntiGA5vdggu4aiHiIzRsvFyVu?=
 =?us-ascii?Q?FpvlMji7K9RPBtBvFFKFEaL4/YNKfCkg4W7yPMLYauVYz8U1Hfcm8yVF5wiG?=
 =?us-ascii?Q?ru+t0ZABuWK8XgAAArEWB8jDFDDiW7HkVZht0PytWGSieyVML7KKiRbsOFmT?=
 =?us-ascii?Q?PrkSz5AhMBx5L+BV8nov3hVPz+EUXnW2197H2c/6L9V2aFu5GqU/TfPqzW41?=
 =?us-ascii?Q?3vQ2hioloiECZVsgF5l4nlPLnszlyWmp9FYzvqERUzwy02SGZeoSiFZ2ygOm?=
 =?us-ascii?Q?7b6r6O1VKekFZdjOyN8sJIndiPUZHnf5YWYySwwayo6pdaOtqUAuxFkQqUfV?=
 =?us-ascii?Q?cLelipuxQ3ttjTzGRIGSgjIbfhzUyKe38iEmaFN2hYHPUTDSDr/wOV16fCWE?=
 =?us-ascii?Q?LbYjLPtgK2vfwi4Ftw++j69nWid+sy7lUe9FqIf2S1JKBpjxcjSIw/1FSi+w?=
 =?us-ascii?Q?wQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8beef9d-193e-428e-9cb1-08da91d11cb4
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2022 19:34:14.5119
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XnBdo2S4jfThxjlFlGu4liL8dzU7m8pu9g7Om43nOtbzt1stqnblQWmWycZ5q6RWLcnQEUBIVa3RwILWiaPzYFStR95QdixOOUXRWvNdf7E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5106
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-08_12,2022-09-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 mlxlogscore=745 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209080069
X-Proofpoint-ORIG-GUID: 9Bo9B7ivlSbUDGJ2BknSYa5NaSSnEKeH
X-Proofpoint-GUID: 9Bo9B7ivlSbUDGJ2BknSYa5NaSSnEKeH
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

