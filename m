Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8499F51EF8E
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 21:13:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234267AbiEHTIz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 15:08:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377243AbiEHSiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 14:38:54 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 100B2BF56
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 11:35:03 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 248AR09C024475;
        Sun, 8 May 2022 18:34:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=vemg51QHslh7TwxBGsfuoG2pBUZWms7zsN8usT0UWIo=;
 b=kdScpjG3MVlSKk5chvkeSo2YxQoHwv1lpxP+UM1l3YIE/TRUhah9NZmHDHJxfn4lxPE/
 PQq5lWui1cpu5HwNdcP2aXjS6Co53emtWmosKwQLC6sqTQJwbfyFcRU5KmsOag8aPG+6
 dJCG0g7SMZw6AYe4tHDqG4gZ8+opSyNMmRPqXkRdcun4txOl33DY2z/4TgvgviFhrTsP
 HkERr9a59xygx0iElaeIaEFHXX88DbrcD/9ytOpdUQKwHqa7lM7OpYcNhhUBZ1tqp+dV
 V5NXpYnnWpttFNia56UxmNZz8vLmewNPuNmVT30GMP3INdFu6b6v+eGftmnAQvQ8LI9E cA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fwfc0htvj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 08 May 2022 18:34:41 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 248IVFiq025089;
        Sun, 8 May 2022 18:34:41 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fwf708b51-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 08 May 2022 18:34:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JMLQy2PjxnnJvAZBVdob6QrndX2JKE4fEsAWw8lDTGbjRaZrNMG8lM1ssbSn0rtnsCKtHPl0BdmFxbPwFsToJ4sO0p6uXBz1DjmFr0qPeLokTN/XFCJYWuSSZkMum4+Q1BZWHs7iGMbpmJhmprbK2yBgDvum+AQCAoVCPqFQcdNIGf5CI4CibWi1tmHEn8dWs2o0Lns5wAvD2vOF8bQ/mIg2Sf/09LhYuHsCCuvMyjfXB+QP5oZkpQ7hoS4SBBp+ORhhkxOUTyhTG082O+O3LeL+5/tU4/f9T4k0MWkcuPOsf9b9T8JgxC4Q0KcS/PWGcXsjibG2vNgtwDxW3qxG5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vemg51QHslh7TwxBGsfuoG2pBUZWms7zsN8usT0UWIo=;
 b=XTGIOUgXyBVb6c+WU54ZT0eq+QpmyM5ZFHrKH38ZVNprZuClKXRVj2Z23fjQPkivvOSWUeTfAzkzeCzwki15BqPDk4a+1R/AIphMehCXDYnQeTewpU3xlgmUL8f9au3M9lx7nRS4q4QT5JsrHjtWZn2oTAk3NA+djskYVe9G+AWGsLV0tOt7mbEEtpI2t51RbBOHzGaEO4W0dx9eyd6frODQEdmHnRh70AhXnyuNdOn02MyEZDiOpV5TgdQ55nnKcoi1oy4BIrSD+QbPcmWXqmqLNqbxaKwTjbwdsH1cHLaknz763uZ8hFlLMmM9+840ieCdkpFBCYNDJJpB6tn37A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vemg51QHslh7TwxBGsfuoG2pBUZWms7zsN8usT0UWIo=;
 b=UX8Og9RekHLUWZTYSgRduB4H4Pj7ohqsi9+MBgFwQRPauRFrAZzaKQivt6Li7KYcdJRl5m2k3TmCBVO0LfJOn/GFuLnNDU9LzJIIGSM1eJAFtRWUAmWE7LMWPbit6p4Pjgit5xDjjG1lGfLt1k2VecEG6IYB66alX3FhpPLut+I=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by MWHPR10MB1485.namprd10.prod.outlook.com (2603:10b6:300:25::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21; Sun, 8 May
 2022 18:34:38 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::9d76:7926:9b76:f461]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::9d76:7926:9b76:f461%9]) with mapi id 15.20.5227.023; Sun, 8 May 2022
 18:34:38 +0000
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
Subject: [RFC PATCH v3 4/8] hugetlbfs: catch and handle truncate racing with page faults
Date:   Sun,  8 May 2022 11:34:16 -0700
Message-Id: <20220508183420.18488-5-mike.kravetz@oracle.com>
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
X-MS-Office365-Filtering-Correlation-Id: 685d2e23-bca4-40b3-e061-08da31216879
X-MS-TrafficTypeDiagnostic: MWHPR10MB1485:EE_
X-Microsoft-Antispam-PRVS: <MWHPR10MB148507AA7C653D31283B8414E2C79@MWHPR10MB1485.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ISbAkj0vLNKDIHklIASo3iGb0C+us/ogGxBqzpHOE+bjIOE0Cwlqgckv2GZ4L/dc1nwie6zaGxEy+wipidGXrfR0Cti6Lj/9Bj+r8DS6sBN2MM+Co1xRDlg9h9r60tGW4A2Jsamx1hItO7HeulLArjI1rW2S1ZXTBBAr0DEXmz9xYwnGhVWNppeHfSqurBdlK/DSH1fDoUt+wewiICiRrSLOpcHbHflZcnvAlsbW8jzG9ZRT26mYib9f7lFDaw4JYSDh3l2TZHH8TgSFPuZMZEqXON4ZwhPUuoRVzYfQtDWqDxhc02k/82NCHLBSFUPCQS6W8rD+J6ou/RwQZKlpXJAwUxe/9D1Fs4D8pGDa1OJPydCZoBKfU+K740+Xlb+Ztfr8NXdzVNtVQRtTHAkKQM7ovlPCMJCZWKDt0U8pC+vMItucTqPRrfIrmHAgN9AUHDoTk8h9IzIRBwpaFdoDmwW8fZiApy2ROsT1nA0gyy241fkp+ca3f43VLinxTQF6bjCz6S2uqAq3WUW9r9QYA1Z9L8/oHxYd9+8W58wmzb7FX4saeg3/7YaggdIbZXtXHq5u5EAxDs0orPAZoXEndCsfGwbXTL2SS/Zo4G19IiMPetcZwTYE9o+SXnE++6WHPv40Ho6I7uy+ZUbRSq4TLz/Iydm9c9txJ1ypfvcZ7cGoGrPjd1kpnfI3BgKzxUGcALt8cdVeKFZ23ac4XKzo9Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66946007)(66556008)(66476007)(2616005)(86362001)(5660300002)(4326008)(30864003)(6506007)(7416002)(52116002)(6666004)(6512007)(26005)(8676002)(8936002)(36756003)(107886003)(186003)(2906002)(44832011)(83380400001)(1076003)(508600001)(6486002)(316002)(38350700002)(54906003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?J13355Iqm+pxYn4zxMYS7WlLnZHkkHMaK6GmJdEjr/AkVgt76WsUoIjsvKHE?=
 =?us-ascii?Q?/AT7V1M7jCQmqOMQWI6bun+ddO96XSUTIgHa2LHvx0pL20IQ4w8Yw0hO4U9s?=
 =?us-ascii?Q?k2IKPZBVukBVznX1FRhAhp/21U6MmUMCwd4AwiX1SRxUzZKeB/Kz6idkkpvn?=
 =?us-ascii?Q?1SDmJ/ruZjyebgaOyDsU5n7wr7uk8x9Huo0f8QZ2i2mC3qtiWyGuSraerjet?=
 =?us-ascii?Q?9rGKoFynwvRwkmdDpHUKFqE0444U/rNWCzDv2xGE+FIwmxhFppeSahbaav9q?=
 =?us-ascii?Q?MeaLU8I9qIQw7Di2KPcytf5TGfIHXByV7fW+YwVTRKC8wQIs5z/a09z6R7QO?=
 =?us-ascii?Q?hTobIfZQEDaHXKPPeMZhlvjL/OcHRQZ8837bDaBOASdumNPjuhtZRfCU0tdf?=
 =?us-ascii?Q?JeJm97GnnQ7mBMXfohgXjqLQIcWE9R9Lyqce8JgU+VF02ejulzhEKPBxweVN?=
 =?us-ascii?Q?tJcao4Ke7Eqv3ANf8WbjdMyBm57LPlxQtIGLadztGcqCdN8kuE5YxYZcVmBf?=
 =?us-ascii?Q?ddu5uaaV3HlFJenGxLT7mmVn8BJTZ+Q05/nwnYF5CTS2PphbW9lxLd+d6SKd?=
 =?us-ascii?Q?fkCCY9U4Avyl6CCFA8NepmHnkwY9tjC5z2MJHpIug/J19+1jtl3bHAl6pHYf?=
 =?us-ascii?Q?jpdJBX+2AF9YGcsercidCqFjVEQUU6uQDjSYjUpAM4NTFhhPWGN/ibImzxWH?=
 =?us-ascii?Q?pAws7hD5XMLRowUoML2pPngCQgr+02UsUYxJrCvPF9/COZDsDQ3rreAfY00Q?=
 =?us-ascii?Q?YwlSvv9/yY8JuvSpXIMHF12P3Ccv6BIqFJNsLv1aOqAkOTKQMtcTFTG31ZpQ?=
 =?us-ascii?Q?+4geK5hVbUMWM4O6wiFMs/a+cwbBaWEpO6JzE8LLLzXlulhEukJIIZt09uHH?=
 =?us-ascii?Q?9PpJB+q+PJw9oGPyMVNTA1CqWX3HB1vKfdO9EVeHQO8M9TesgdeEvIkRfE+A?=
 =?us-ascii?Q?Xql6oh89+XLlUNzkkKHmya93nAQAK7fp3O62ys2emytPlwriswCivUzkfwwI?=
 =?us-ascii?Q?49Eh6Io2P6hw9Ws0Y0ecwh2bSATs2eTvxyc3RpWIbMql7VrX+0PZTEwa6MML?=
 =?us-ascii?Q?vXyn8gJo/tzAzOInezJMQSn0R+csHisUfI6zhlvRBrNo5nWcvIU9TQGz2Akl?=
 =?us-ascii?Q?tDScVaAKpXcj73MMxfcd3uZ7B82KRTxfXbnkoHnF620MV81PdO00hfYYg5p/?=
 =?us-ascii?Q?J9LHngUjBhkRCx3Rei2x7ewcX7tR+TpPG+kTioNULLeTWCEOQZPLPCBwVPhi?=
 =?us-ascii?Q?00ZTPNQphqxswAKQnGeUtpukJvnweIslflAGhSSceOV3+6amBbMfLooByL1K?=
 =?us-ascii?Q?19tcDf6Vm9STXMel6xG6wUBjhTS7A7w5Q7xOQ6P5ynverO9QkpnFWB3yS2F2?=
 =?us-ascii?Q?xX9PTZxWndcfBJ1MHe/5jXO2yn6N5Yzs0/uFoCoNFqRyO07iWtjdhUu24TvN?=
 =?us-ascii?Q?RP16ToftreyGSnSt50Hn+al8GYtrb1mU1wgTUHM0hnuA4l5lM4Wn9y/YlYee?=
 =?us-ascii?Q?D/xiJ+A03ILQ6eHN/sp4baktBMIXqHuhQhMN5X9hy9E1q3LM1rsSgOFGxQu/?=
 =?us-ascii?Q?7f117+4ZCHeY3bPQ9+h+FQsodWbkaT6WKm4f6gdbSzoX3xbSJdGM76V/jOHl?=
 =?us-ascii?Q?bIza/z326K1Ax0+EF1vr0hzgZ6RlhbJPKFMwYIJAVFiqPyXC04Z+vyg/xLRI?=
 =?us-ascii?Q?jO0Oo1+veNn8tL52dnClqldmyjMCVtlNjI1+KQolBG2u/fcUl4FZjHxeAqdA?=
 =?us-ascii?Q?hXs8I7pmhduuK4BvsXJCTlNvTKdHwbQ=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 685d2e23-bca4-40b3-e061-08da31216879
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2022 18:34:38.4891
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ERhdZXCXAkaYpEetG6mVsDEpswl+PLSkVIeD36kTGczfr7MuBEfacHsYIE6w/DtFri6/eN6LyhqjsfTrWJwbiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1485
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-08_07:2022-05-05,2022-05-08 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 adultscore=0 bulkscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205080121
X-Proofpoint-ORIG-GUID: 5SNIjDvgvEbIW1QODxk9REEfols3wrsj
X-Proofpoint-GUID: 5SNIjDvgvEbIW1QODxk9REEfols3wrsj
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most hugetlb fault handling code checks for faults beyond i_size.
While there are early checks in the code paths, the most difficult
to handle are those discovered after taking the page table lock.
At this point, we have possibly allocated a page and consumed
associated reservations and possibly added the page to the page cache.

When discovering a fault beyond i_size, be sure to:
- Remove the page from page cache, else it will sit there until the
  file is removed.
- Do not restore any reservation for the page consumed.  Otherwise
  there will be an outstanding reservation for an offset beyond the
  end of file.

The 'truncation' code in remove_inode_hugepages must deal with fault
code potentially removing a page from the cache after the page was
returned by pagevec_lookup and before locking the page.  This can be
discovered by a change in page_mapping() after taking page lock.  In
addition, this code must deal with fault code potentially consuming
and returning reservations.  To synchronize this, remove_inode_hugepages
will now take the fault mutex for ALL indicies in the hole or truncated
range.  In this way, it KNOWS fault code has finished with the page/index
OR fault code will see the updated file size.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 fs/hugetlbfs/inode.c | 104 +++++++++++++++++++++++++++++++------------
 mm/hugetlb.c         |  39 ++++++++++++----
 2 files changed, 105 insertions(+), 38 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 96ff9ba2b4ba..5645353a9744 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -444,11 +444,10 @@ hugetlb_vmdelete_list(struct rb_root_cached *root, pgoff_t start, pgoff_t end,
  * truncation is indicated by end of range being LLONG_MAX
  *	In this case, we first scan the range and release found pages.
  *	After releasing pages, hugetlb_unreserve_pages cleans up region/reserve
- *	maps and global counts.  Page faults can not race with truncation
- *	in this routine.  hugetlb_no_page() prevents page faults in the
- *	truncated range.  It checks i_size before allocation, and again after
- *	with the page table lock for the page held.  The same lock must be
- *	acquired to unmap a page.
+ *	maps and global counts.  Page faults can race with truncation.
+ *	During faults, hugetlb_no_page() checks i_size before page allocation,
+ *	and again after	obtaining page table lock.  It will 'back out'
+ *	allocations in the truncated range.
  * hole punch is indicated if end is not LLONG_MAX
  *	In the hole punch case we scan the range and release found pages.
  *	Only when releasing a page is the associated region/reserve map
@@ -457,14 +456,26 @@ hugetlb_vmdelete_list(struct rb_root_cached *root, pgoff_t start, pgoff_t end,
  *	This is indicated if we find a mapped page.
  * Note: If the passed end of range value is beyond the end of file, but
  * not LLONG_MAX this routine still performs a hole punch operation.
+ *
+ * Since page faults can race with this routine, care must be taken as both
+ * modify huge page reservation data.  To somewhat synchronize these operations
+ * the hugetlb fault mutex is taken for EVERY index in the range to be hole
+ * punched or truncated.  In this way, we KNOW fault code will either have
+ * completed backout operations under the mutex, or fault code will see the
+ * updated file size and not allocate a page for offsets beyond truncated size.
+ * The parameter 'lm__end' indicates the offset of the end of hole or file
+ * before truncation.  For hole punch lm_end == lend.
  */
 static void remove_inode_hugepages(struct inode *inode, loff_t lstart,
-				   loff_t lend)
+				   loff_t lend, loff_t lm_end)
 {
+	u32 hash;
 	struct hstate *h = hstate_inode(inode);
 	struct address_space *mapping = &inode->i_data;
 	const pgoff_t start = lstart >> huge_page_shift(h);
 	const pgoff_t end = lend >> huge_page_shift(h);
+	pgoff_t m_end = lm_end >> huge_page_shift(h);
+	pgoff_t m_start, m_index;
 	struct pagevec pvec;
 	pgoff_t next, index;
 	int i, freed = 0;
@@ -476,14 +487,33 @@ static void remove_inode_hugepages(struct inode *inode, loff_t lstart,
 		/*
 		 * When no more pages are found, we are done.
 		 */
-		if (!pagevec_lookup_range(&pvec, mapping, &next, end - 1))
+		m_start = next;
+		if (!pagevec_lookup_range(&pvec, mapping, &next, end - 1)) {
+			/*
+			 * To synchronize with faults, take fault mutex for
+			 * each index in range.
+			 */
+			for (m_index = m_start; m_index < m_end; m_index++) {
+				hash = hugetlb_fault_mutex_hash(mapping,
+						m_index);
+				mutex_lock(&hugetlb_fault_mutex_table[hash]);
+				mutex_unlock(&hugetlb_fault_mutex_table[hash]);
+			}
 			break;
+		}
 
 		for (i = 0; i < pagevec_count(&pvec); ++i) {
 			struct page *page = pvec.pages[i];
-			u32 hash = 0;
 
 			index = page->index;
+			/* Take fault mutex for missing pages before index */
+			for (m_index = m_start; m_index < index; m_index++) {
+				hash = hugetlb_fault_mutex_hash(mapping,
+						m_index);
+				mutex_lock(&hugetlb_fault_mutex_table[hash]);
+				mutex_unlock(&hugetlb_fault_mutex_table[hash]);
+			}
+			m_start = index + 1;
 			hash = hugetlb_fault_mutex_hash(mapping, index);
 			mutex_lock(&hugetlb_fault_mutex_table[hash]);
 
@@ -492,13 +522,8 @@ static void remove_inode_hugepages(struct inode *inode, loff_t lstart,
 			 * unmapped in caller.  Unmap (again) now after taking
 			 * the fault mutex.  The mutex will prevent faults
 			 * until we finish removing the page.
-			 *
-			 * This race can only happen in the hole punch case.
-			 * Getting here in a truncate operation is a bug.
 			 */
 			if (unlikely(page_mapped(page))) {
-				BUG_ON(truncate_op);
-
 				i_mmap_lock_write(mapping);
 				hugetlb_vmdelete_list(&mapping->i_mmap,
 					index * pages_per_huge_page(h),
@@ -509,27 +534,46 @@ static void remove_inode_hugepages(struct inode *inode, loff_t lstart,
 
 			lock_page(page);
 			/*
-			 * We must free the huge page and remove from page
-			 * cache BEFORE removing the region/reserve map
-			 * (hugetlb_unreserve_pages).  In rare out of memory
-			 * conditions, removal of the region/reserve map could
-			 * fail. Correspondingly, the subpool and global
-			 * reserve usage count can need to be adjusted.
+			 * After locking page, make sure mapping is the same.
+			 * We could have raced with page fault populate and
+			 * backout code.
 			 */
-			VM_BUG_ON(HPageRestoreReserve(page));
-			hugetlb_delete_from_page_cache(page);
-			freed++;
-			if (!truncate_op) {
-				if (unlikely(hugetlb_unreserve_pages(inode,
+			if (page_mapping(page) == mapping) {
+				/*
+				 * We must free the huge page and remove from
+				 * page cache BEFORE removing the region/
+				 * reserve map (hugetlb_unreserve_pages).  In
+				 * rare out of memory conditions, removal of
+				 * the region/reserve map could fail.
+				 * Correspondingly, the subpool and global
+				 * reserve usage count can need to be adjusted.
+				 */
+				VM_BUG_ON(HPageRestoreReserve(page));
+				hugetlb_delete_from_page_cache(page);
+				freed++;
+				if (!truncate_op) {
+					if (unlikely(
+					    hugetlb_unreserve_pages(inode,
 							index, index + 1, 1)))
-					hugetlb_fix_reserve_counts(inode);
+						hugetlb_fix_reserve_counts(
+								inode);
+				}
 			}
-
 			unlock_page(page);
 			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
 		}
 		huge_pagevec_release(&pvec);
 		cond_resched();
+
+		if (!(next < end)) {
+			/* Will exit loop, take mutex for indicies up to end */
+			for (m_index = m_start; m_index < m_end; m_index++) {
+				hash = hugetlb_fault_mutex_hash(mapping,
+								m_index);
+				mutex_lock(&hugetlb_fault_mutex_table[hash]);
+				mutex_unlock(&hugetlb_fault_mutex_table[hash]);
+			}
+		}
 	}
 
 	if (truncate_op)
@@ -539,8 +583,9 @@ static void remove_inode_hugepages(struct inode *inode, loff_t lstart,
 static void hugetlbfs_evict_inode(struct inode *inode)
 {
 	struct resv_map *resv_map;
+	loff_t prev_size = i_size_read(inode);
 
-	remove_inode_hugepages(inode, 0, LLONG_MAX);
+	remove_inode_hugepages(inode, 0, LLONG_MAX, prev_size);
 
 	/*
 	 * Get the resv_map from the address space embedded in the inode.
@@ -560,6 +605,7 @@ static void hugetlb_vmtruncate(struct inode *inode, loff_t offset)
 	pgoff_t pgoff;
 	struct address_space *mapping = inode->i_mapping;
 	struct hstate *h = hstate_inode(inode);
+	loff_t prev_size = i_size_read(inode);
 
 	BUG_ON(offset & ~huge_page_mask(h));
 	pgoff = offset >> PAGE_SHIFT;
@@ -570,7 +616,7 @@ static void hugetlb_vmtruncate(struct inode *inode, loff_t offset)
 		hugetlb_vmdelete_list(&mapping->i_mmap, pgoff, 0,
 				      ZAP_FLAG_DROP_MARKER);
 	i_mmap_unlock_write(mapping);
-	remove_inode_hugepages(inode, offset, LLONG_MAX);
+	remove_inode_hugepages(inode, offset, LLONG_MAX, prev_size);
 }
 
 static long hugetlbfs_punch_hole(struct inode *inode, loff_t offset, loff_t len)
@@ -604,7 +650,7 @@ static long hugetlbfs_punch_hole(struct inode *inode, loff_t offset, loff_t len)
 					      hole_start >> PAGE_SHIFT,
 					      hole_end >> PAGE_SHIFT, 0);
 		i_mmap_unlock_write(mapping);
-		remove_inode_hugepages(inode, hole_start, hole_end);
+		remove_inode_hugepages(inode, hole_start, hole_end, hole_end);
 		inode_unlock(inode);
 	}
 
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 003df6cc13eb..007b39450f71 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5453,6 +5453,8 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 	spinlock_t *ptl;
 	unsigned long haddr = address & huge_page_mask(h);
 	bool new_page, new_pagecache_page = false;
+	bool beyond_i_size = false;
+	bool reserve_alloc = false;
 
 	/*
 	 * Currently, we are forced to kill the process in the event the
@@ -5510,6 +5512,8 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 		clear_huge_page(page, address, pages_per_huge_page(h));
 		__SetPageUptodate(page);
 		new_page = true;
+		if (HPageRestoreReserve(page))
+			reserve_alloc = true;
 
 		if (vma->vm_flags & VM_MAYSHARE) {
 			int err = hugetlb_add_to_page_cache(page, mapping, idx);
@@ -5568,8 +5572,10 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 
 	ptl = huge_pte_lock(h, mm, ptep);
 	size = i_size_read(mapping->host) >> huge_page_shift(h);
-	if (idx >= size)
+	if (idx >= size) {
+		beyond_i_size = true;
 		goto backout;
+	}
 
 	ret = 0;
 	/* If pte changed from under us, retry */
@@ -5614,10 +5620,25 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 backout:
 	spin_unlock(ptl);
 backout_unlocked:
+	if (new_page) {
+		if (new_pagecache_page)
+			hugetlb_delete_from_page_cache(page);
+
+		/*
+		 * If reserve was consumed, make sure flag is set so that it
+		 * will be restored in free_huge_page().
+		 */
+		if (reserve_alloc)
+			SetHPageRestoreReserve(page);
+
+		/*
+		 * Do not restore reserve map entries beyond i_size.
+		 * Otherwise, there will be leaks when the file is removed.
+		 */
+		if (!beyond_i_size)
+			restore_reserve_on_error(h, vma, haddr, page);
+	}
 	unlock_page(page);
-	/* restore reserve for newly allocated pages not in page cache */
-	if (new_page && !new_pagecache_page)
-		restore_reserve_on_error(h, vma, haddr, page);
 	put_page(page);
 	goto out;
 }
@@ -5938,15 +5959,15 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 	 * Recheck the i_size after holding PT lock to make sure not
 	 * to leave any page mapped (as page_mapped()) beyond the end
 	 * of the i_size (remove_inode_hugepages() is strict about
-	 * enforcing that). If we bail out here, we'll also leave a
-	 * page in the radix tree in the vm_shared case beyond the end
-	 * of the i_size, but remove_inode_hugepages() will take care
-	 * of it as soon as we drop the hugetlb_fault_mutex_table.
+	 * enforcing that). If we bail out here, remove the page
+	 * added to the radix tree.
 	 */
 	size = i_size_read(mapping->host) >> huge_page_shift(h);
 	ret = -EFAULT;
-	if (idx >= size)
+	if (idx >= size) {
+		hugetlb_delete_from_page_cache(page);
 		goto out_release_unlock;
+	}
 
 	ret = -EEXIST;
 	/*
-- 
2.35.3

