Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99E515A00E9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 20:00:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240182AbiHXR7F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 13:59:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240362AbiHXR6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 13:58:45 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7218761D81
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 10:58:41 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27OHkWXs030222;
        Wed, 24 Aug 2022 17:58:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=OGb2VYkTMafrtVeVL6G6hTUZMQp2A7MemO9VR1IxmHw=;
 b=FhssGk7GBh9uTcfloQpJNf7vlbSXTvMVkxqQZVHVevOrCRW9n+h39v+QCGtHQgH9rVyT
 DXaJSL77+rX6zwJJsbN7TCBr8ZgZPpLiCvBgsWiblVqly8/q6fwfcz2MY+6GBMBl+ZWX
 v4R7MjGI+1tbMT2unDsbJFN4PiT5ysa9snlci4AymKv40x8IauypyxLC8+19SUBeYMuq
 pWVvaxbvtz/SAkC/pNJJINlcPrzt6BhfIUktMpCmEV5ih4VHmqPKAYAbgOP//rxggZsv
 R0SylddmLkilwZKrq4Uu8ecPTrLPhcPeqEhwjf7wkGHq/hwEjfzWISh/CNDMheS58eqE DQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j55p22ms8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Aug 2022 17:58:19 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27OHABww028377;
        Wed, 24 Aug 2022 17:58:18 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3j5n4kbnw5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Aug 2022 17:58:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O9pfdS9pxsay7K1rjcEJrRUnZcqF8eGoisCRmd46xISggcNjPqiDQG9zmRNGtpAtMDYc74SSgh3wPnHtxy4ErTucOIBydQYADbNTf/mcY+11QJ/KDsc3vvtZt9icrhzYvegOdCLhUZXcYLWOYFpN0oAk73Sbd3OgtImaDRIMErvpkAdJnQvMdLPsfkM6BO3APLj+9aFLGFg2+Z3Ch/mgct4YvE0rjXEHAFETWOHgIqrfEREZAmAfrVjiIPQ/mdWkY6BO7pHzek986EQex9noRl6lUkL0rwqt4X5iDv7ji5LTrjJLCNUdN7W583R/dlXxb2OWIoZK4zSAF3NOXnzB6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OGb2VYkTMafrtVeVL6G6hTUZMQp2A7MemO9VR1IxmHw=;
 b=Pfl+TW82T2/pTIYR9DZylye7O/rbGlTPW/DLp5cBk2Wau4/EACxPjpIW1uDQ1bflXKG2H5xk/9xNY1u9kx9cut51GqCp/IUDqRyNrCC+GHmGXGwm/05Fvn1iFrf6eqv4AQXo455JAHnGnpLLl0zA+bFYnT0pDcfniBGezZcthjhqUX1Fr+Of58by1G0tk1vrDL088OpfXpZE4xOA67bvd6t79OsK2EzW8y13m+S3QdIGuWSPhXS4LIYXZcBkDa3/P39zxZI5zLcdI/7O/iSjGw6aq4IMQaN/K5IVdNv+W+OvPd7LeSXKnT/juf3zNzr0WiWhrjoiXSrkiRq6UxoUgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OGb2VYkTMafrtVeVL6G6hTUZMQp2A7MemO9VR1IxmHw=;
 b=YkKNUQbI7Cn57rfElarC8+kGPLVZYh5fB9szRuy1T55AfWKgVEn/7h7euwRoet53za5zHSrSCSfmeFUJo3bR8uMk8z+t9YeeXDMNAQJwM/tXskNAID75abO5/DDTSwO6WoM74HXFrW/3/a7Aq2NrNA9D9X8sGIa69M90D5Hzt0g=
Received: from DM6PR10MB4201.namprd10.prod.outlook.com (2603:10b6:5:216::10)
 by PH0PR10MB4520.namprd10.prod.outlook.com (2603:10b6:510:43::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.19; Wed, 24 Aug
 2022 17:58:15 +0000
Received: from DM6PR10MB4201.namprd10.prod.outlook.com
 ([fe80::11b6:7a8a:1432:bec]) by DM6PR10MB4201.namprd10.prod.outlook.com
 ([fe80::11b6:7a8a:1432:bec%6]) with mapi id 15.20.5546.022; Wed, 24 Aug 2022
 17:58:15 +0000
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
Subject: [PATCH 4/8] hugetlb: handle truncate racing with page faults
Date:   Wed, 24 Aug 2022 10:57:53 -0700
Message-Id: <20220824175757.20590-5-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220824175757.20590-1-mike.kravetz@oracle.com>
References: <20220824175757.20590-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW2PR2101CA0025.namprd21.prod.outlook.com
 (2603:10b6:302:1::38) To DM6PR10MB4201.namprd10.prod.outlook.com
 (2603:10b6:5:216::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 85d695c4-7d95-4b5d-414a-08da85fa381f
X-MS-TrafficTypeDiagnostic: PH0PR10MB4520:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XAT2TW1ahF8BIn0D/FZN1M8AT1x810+egDz+wtY7zcNsrnU2sZsopPmrhJ4CcOnuPvmfH6ihxi4J48BeCrAK02pcusPX/ZU8c2edwZWZO6mmuuDOX1FY8z0RRXGKZo4H5YZpJ/EIQNkMD/8cLVkn492uU/Ze/FPDpqT7hfoW8oDa3U9J2aNm6EdJlCDQHdJ4N+qXZG72cLkqDHduGqaLRZ3S9Fjd1DwHU1yT2wggMqHvbtm01RoqEbQuKbN1tQ6vQCahm6xBrncFExMUrqQ3KTVexwA6T2sSPyWEJavIdFET10MiGc/N140L28MpnNhUfcOl1ERCMQTfKgCtaIhN1YVDOveKv89PKYEv1AeRKHnxzyNha/eYVcfKfcBu2BQU/3qw6xm0znU9mU2RDlF8V5OIJFc3MfVWsnyHHVpYPishQP5wJnsnqhHCCjwWA6ydwrPGysvaf93tuXLBHmiSlu7r3l+sjWWkZPe3/XPDtgZV0qGor+gAxEXBmmmOrFBnquODNFuc4QUtZw5yNPLYNlhUx4bI3EcD40TBz6c9Q3yp1ODlksYu7YIirX520CsEL6orjL4gXCFRO/aehNa4YK3jEvvqGUqMxBKYzuC4brHwSaHOndFL1EAANkpSLbFPlK99Ri9A96NrHCc+pCnO9DAnqh3J7/YJtLwqz98gTWdbYcUxj8ouyYtNBwWF3ebSkrxIpmTz4MwKB7RGc/He+Afm3zgYxr5veO4DcRQ0RP13w9RdFWpx2LLKE37ZgiR/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4201.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(396003)(136003)(376002)(346002)(366004)(7416002)(1076003)(6512007)(6666004)(8936002)(26005)(186003)(30864003)(107886003)(2616005)(6506007)(44832011)(86362001)(36756003)(41300700001)(316002)(5660300002)(54906003)(478600001)(66556008)(8676002)(4326008)(6486002)(83380400001)(38100700002)(66946007)(2906002)(66476007)(76704002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3M9zxDnIso6a/CoA4xBkXQ1vaVHGpKxFnHl/EjgZ5wXswIzBrV400mQVpgd6?=
 =?us-ascii?Q?wjilsn69PeOx26dgaSCQZRGsM7g8lGzC9j7PJWjrVOcE5b0hMaL50xtGhfHu?=
 =?us-ascii?Q?nAHc5NN4806NIrsMuqtLkvBtEuDCfNCKOX4h1pPREDrpk7E4r3Xf2Rrxj3tn?=
 =?us-ascii?Q?LX2vcJSIXIlkhlYxyqb0y05MxSKOdJmPF7yjMbkWBZOPC2I1xrMuckS2X4Uo?=
 =?us-ascii?Q?hJDQifctH6cfix7a+jba0XZnsMwazt78reWoek5A9UCFgAuO0F5/6NdPb+TS?=
 =?us-ascii?Q?HfIiQHN9CxToguggfiXuQwHch39W5y+7UtGrkK45q8dJWpxHKxUFUlgE8WuM?=
 =?us-ascii?Q?x4wIC3AtU6N/H19iOTmtZSHYez3zT5XU7Lzcu8akoekhTIjF455Rhgb8rK9+?=
 =?us-ascii?Q?tkbsdxz1Tgiwqc1ymGikU5mFqGWqJfQpXBk6vF4N9fwbAl6H/u67BUfMwI6L?=
 =?us-ascii?Q?J2IhtiU+XT4RtFzXATGVLCowTzhH1q5FFIQ5GnU9lHUtPf/NrIupw8QVUNS7?=
 =?us-ascii?Q?fh1zzuwuHgILKg0g0mM3DuTk4oZu7dM5iLamsATdWpVHwfAFrN960p+wzha4?=
 =?us-ascii?Q?WYUehIH7a1WvEjHToryx7tkfNaV54WMX38OXlqVkfeszTYsAO+/UeVcppvyy?=
 =?us-ascii?Q?ahI9fIjWYgXQKu/y6IVVmxundnER/eA7tVKfoKGMIHfoReenkC93XiWZOoB4?=
 =?us-ascii?Q?dxfcHf75cDGKIOp3O/Yl3Tg4G1YqACcMInos+gBZa0BvK43mc9P/4PIgc7en?=
 =?us-ascii?Q?Z4qChaFFtfnFqWXlGGePrUhKfZesBWuHo2yotf1Fw4BP2UnFrjS2j3bSM8Dq?=
 =?us-ascii?Q?LJC+e2Wd7/O5smvU8EQXvrxYYVlGkcAvis3fBfBvzMaSQcgWmmsDawk/TdkC?=
 =?us-ascii?Q?0bYtLWAysnxTmWyA0CMGpT5nNFPxWJnXMjynWD48Wxsjy32BVrONap2/QrCs?=
 =?us-ascii?Q?amNPwMnCV0UOMZseVbNs35O72WP+OTAFKCvnc/tk5E70YPg0zikTbpEABtkA?=
 =?us-ascii?Q?1S4DwIFtI/fwxjWW3kdxg50kxIMrGYp6Q+JNmIQDaD0QZ8SWgCwgrtizvKen?=
 =?us-ascii?Q?jMQ2+Q9GOE21t0zd0WpCsr4VqZX5CUQ306DxizlrMIOaoMRgyA+z00Y2ol5d?=
 =?us-ascii?Q?nnFaUBRPU5y1SRiJQJu9KHFkuOQvkzhvByfmmn57kkuFe1fRCIeZXxqSoCdz?=
 =?us-ascii?Q?yjc48zQ676xUcosZU1MDcmg89clMI45jRZre4Of51FSWueHbzXFtSVSimrNj?=
 =?us-ascii?Q?P5KVh4PSgE3XjZrvz0s9TJDjOvVhfZjdfZGHZuNoe3oAX0u37XU2U49Wi2sT?=
 =?us-ascii?Q?ZpfvtEoLkkm4PT7G6KYb4Pz/zocsP+EnmUkoV+kqlbMfzEugWQIbpqJaKdwZ?=
 =?us-ascii?Q?+HJgOMZ0ZJxfoStHqhT/TRP0pZZGHabYuWz5lCLKcin9iggfxa2l9izWjg9S?=
 =?us-ascii?Q?UCUg6t6HTq182D84EoSNC1eZqsuIwPF6Fs1WlhKZSWZ1R0A86buMdKBzPaGj?=
 =?us-ascii?Q?MHY8QY1/kFZYz8heEDDUEG5ptkJmjs0Y7NB5zjx4WtDDzPiIUzDlLKWEgh77?=
 =?us-ascii?Q?oXn0rUDXUZjppLuhIm9gPr4sPpAUmHkN3o++zwZ2tlpFSM+ve442+Am/XQzj?=
 =?us-ascii?Q?Nw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85d695c4-7d95-4b5d-414a-08da85fa381f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4201.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2022 17:58:15.7030
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4guw0pCwG7hek5828um1z0A5Fj85iiDaW1Ycdg/bPjMCdnCiCxBaOCUq+TPWC+H1z5KL3FqayFvzUiJJ5AkgJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4520
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-24_11,2022-08-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 phishscore=0
 spamscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208240066
X-Proofpoint-ORIG-GUID: NakEOfmO8Ve__PEhObjpiCHLGe9hrduT
X-Proofpoint-GUID: NakEOfmO8Ve__PEhObjpiCHLGe9hrduT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When page fault code needs to allocate and instantiate a new hugetlb
page (huegtlb_no_page), it checks early to determine if the fault is
beyond i_size.  When discovered early, it is easy to abort the fault and
return an error.  However, it becomes much more difficult to handle when
discovered later after allocating the page and consuming reservations
and adding to the page cache.  Backing out changes in such instances
becomes difficult and error prone.

Instead of trying to catch and backout all such races, use the hugetlb
fault mutex to handle truncate racing with page faults.  The most
significant change is modification of the routine remove_inode_hugepages
such that it will take the fault mutex for EVERY index in the truncated
range (or hole in the case of hole punch).  Since remove_inode_hugepages
is called in the truncate path after updating i_size, we can experience
races as follows.
- truncate code updates i_size and takes fault mutex before a racing
  fault.  After fault code takes mutex, it will notice fault beyond
  i_size and abort early.
- fault code obtains mutex, and truncate updates i_size after early
  checks in fault code.  fault code will add page beyond i_size.
  When truncate code takes mutex for page/index, it will remove the
  page.
- truncate updates i_size, but fault code obtains mutex first.  If
  fault code sees updated i_size it will abort early.  If fault code
  does not see updated i_size, it will add page beyond i_size and
  truncate code will remove page when it obtains fault mutex.

Note, for performance reasons remove_inode_hugepages will still use
filemap_get_folios for bulk folio lookups.  For indicies not returned in
the bulk lookup, it will need to lookup individual folios to check for
races with page fault.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 fs/hugetlbfs/inode.c | 184 +++++++++++++++++++++++++++++++------------
 mm/hugetlb.c         |  41 +++++-----
 2 files changed, 152 insertions(+), 73 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index d98c6edbd1a4..e83fd31671b3 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -411,6 +411,95 @@ hugetlb_vmdelete_list(struct rb_root_cached *root, pgoff_t start, pgoff_t end,
 	}
 }
 
+/*
+ * Called with hugetlb fault mutex held.
+ * Returns true if page was actually removed, false otherwise.
+ */
+static bool remove_inode_single_folio(struct hstate *h, struct inode *inode,
+					struct address_space *mapping,
+					struct folio *folio, pgoff_t index,
+					bool truncate_op)
+{
+	bool ret = false;
+
+	/*
+	 * If folio is mapped, it was faulted in after being
+	 * unmapped in caller.  Unmap (again) while holding
+	 * the fault mutex.  The mutex will prevent faults
+	 * until we finish removing the folio.
+	 */
+	if (unlikely(folio_mapped(folio))) {
+		i_mmap_lock_write(mapping);
+		hugetlb_vmdelete_list(&mapping->i_mmap,
+					index * pages_per_huge_page(h),
+					(index + 1) * pages_per_huge_page(h),
+					ZAP_FLAG_DROP_MARKER);
+		i_mmap_unlock_write(mapping);
+	}
+
+	folio_lock(folio);
+	/*
+	 * After locking page, make sure mapping is the same.
+	 * We could have raced with page fault populate and
+	 * backout code.
+	 */
+	if (folio_mapping(folio) == mapping) {
+		/*
+		 * We must remove the folio from page cache before removing
+		 * the region/ reserve map (hugetlb_unreserve_pages).  In
+		 * rare out of memory conditions, removal of the region/reserve
+		 * map could fail.  Correspondingly, the subpool and global
+		 * reserve usage count can need to be adjusted.
+		 */
+		VM_BUG_ON(HPageRestoreReserve(&folio->page));
+		hugetlb_delete_from_page_cache(&folio->page);
+		ret = true;
+		if (!truncate_op) {
+			if (unlikely(hugetlb_unreserve_pages(inode, index,
+								index + 1, 1)))
+				hugetlb_fix_reserve_counts(inode);
+		}
+	}
+
+	folio_unlock(folio);
+	return ret;
+}
+
+/*
+ * Take hugetlb fault mutex for a set of inode indicies.
+ * Check for and remove any found folios.  Return the number of
+ * any removed folios.
+ *
+ */
+static long fault_lock_inode_indicies(struct hstate *h,
+					struct inode *inode,
+					struct address_space *mapping,
+					pgoff_t start, pgoff_t end,
+					bool truncate_op)
+{
+	struct folio *folio;
+	long freed = 0;
+	pgoff_t index;
+	u32 hash;
+
+	for (index = start; index < end; index++) {
+		hash = hugetlb_fault_mutex_hash(mapping, index);
+		mutex_lock(&hugetlb_fault_mutex_table[hash]);
+
+		folio = filemap_get_folio(mapping, index);
+		if (folio) {
+			if (remove_inode_single_folio(h, inode, mapping, folio,
+							index, truncate_op))
+				freed++;
+			folio_put(folio);
+		}
+
+		mutex_unlock(&hugetlb_fault_mutex_table[hash]);
+	}
+
+	return freed;
+}
+
 /*
  * remove_inode_hugepages handles two distinct cases: truncation and hole
  * punch.  There are subtle differences in operation for each case.
@@ -418,11 +507,10 @@ hugetlb_vmdelete_list(struct rb_root_cached *root, pgoff_t start, pgoff_t end,
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
@@ -431,75 +519,69 @@ hugetlb_vmdelete_list(struct rb_root_cached *root, pgoff_t start, pgoff_t end,
  *	This is indicated if we find a mapped page.
  * Note: If the passed end of range value is beyond the end of file, but
  * not LLONG_MAX this routine still performs a hole punch operation.
+ *
+ * Since page faults can race with this routine, care must be taken as both
+ * modify huge page reservation data.  To somewhat synchronize these operations
+ * the hugetlb fault mutex is taken for EVERY index in the range to be hole
+ * punched or truncated.  In this way, we KNOW either:
+ * - fault code has added a page beyond i_size, and we will remove here
+ * - fault code will see updated i_size and not add a page beyond
+ * The parameter 'lm__end' indicates the offset of the end of hole or file
+ * before truncation.  For hole punch lm_end == lend.
  */
 static void remove_inode_hugepages(struct inode *inode, loff_t lstart,
-				   loff_t lend)
+				   loff_t lend, loff_t lm_end)
 {
 	struct hstate *h = hstate_inode(inode);
 	struct address_space *mapping = &inode->i_data;
 	const pgoff_t start = lstart >> huge_page_shift(h);
 	const pgoff_t end = lend >> huge_page_shift(h);
+	pgoff_t m_end = lm_end >> huge_page_shift(h);
+	pgoff_t m_start, m_index;
 	struct folio_batch fbatch;
+	struct folio *folio;
 	pgoff_t next, index;
-	int i, freed = 0;
+	unsigned int i;
+	long freed = 0;
+	u32 hash;
 	bool truncate_op = (lend == LLONG_MAX);
 
 	folio_batch_init(&fbatch);
-	next = start;
+	next = m_start = start;
 	while (filemap_get_folios(mapping, &next, end - 1, &fbatch)) {
 		for (i = 0; i < folio_batch_count(&fbatch); ++i) {
-			struct folio *folio = fbatch.folios[i];
-			u32 hash = 0;
+			folio = fbatch.folios[i];
 
 			index = folio->index;
-			hash = hugetlb_fault_mutex_hash(mapping, index);
-			mutex_lock(&hugetlb_fault_mutex_table[hash]);
-
 			/*
-			 * If folio is mapped, it was faulted in after being
-			 * unmapped in caller.  Unmap (again) now after taking
-			 * the fault mutex.  The mutex will prevent faults
-			 * until we finish removing the folio.
-			 *
-			 * This race can only happen in the hole punch case.
-			 * Getting here in a truncate operation is a bug.
+			 * Take fault mutex for missing folios before index,
+			 * while checking folios that might have been added
+			 * due to a race with fault code.
 			 */
-			if (unlikely(folio_mapped(folio))) {
-				BUG_ON(truncate_op);
-
-				i_mmap_lock_write(mapping);
-				hugetlb_vmdelete_list(&mapping->i_mmap,
-					index * pages_per_huge_page(h),
-					(index + 1) * pages_per_huge_page(h),
-					ZAP_FLAG_DROP_MARKER);
-				i_mmap_unlock_write(mapping);
-			}
+			freed += fault_lock_inode_indicies(h, inode, mapping,
+						m_start, m_index, truncate_op);
 
-			folio_lock(folio);
 			/*
-			 * We must free the huge page and remove from page
-			 * cache BEFORE removing the * region/reserve map
-			 * (hugetlb_unreserve_pages).  In rare out of memory
-			 * conditions, removal of the region/reserve map could
-			 * fail. Correspondingly, the subpool and global
-			 * reserve usage count can need to be adjusted.
+			 * Remove folio that was part of folio_batch.
 			 */
-			VM_BUG_ON(HPageRestoreReserve(&folio->page));
-			hugetlb_delete_from_page_cache(&folio->page);
-			freed++;
-			if (!truncate_op) {
-				if (unlikely(hugetlb_unreserve_pages(inode,
-							index, index + 1, 1)))
-					hugetlb_fix_reserve_counts(inode);
-			}
-
-			folio_unlock(folio);
+			hash = hugetlb_fault_mutex_hash(mapping, index);
+			mutex_lock(&hugetlb_fault_mutex_table[hash]);
+			if (remove_inode_single_folio(h, inode, mapping, folio,
+							index, truncate_op))
+				freed++;
 			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
 		}
 		folio_batch_release(&fbatch);
 		cond_resched();
 	}
 
+	/*
+	 * Take fault mutex for missing folios at end of range while checking
+	 * for folios that might have been added due to a race with fault code.
+	 */
+	freed += fault_lock_inode_indicies(h, inode, mapping, m_start, m_end,
+						truncate_op);
+
 	if (truncate_op)
 		(void)hugetlb_unreserve_pages(inode, start, LONG_MAX, freed);
 }
@@ -507,8 +589,9 @@ static void remove_inode_hugepages(struct inode *inode, loff_t lstart,
 static void hugetlbfs_evict_inode(struct inode *inode)
 {
 	struct resv_map *resv_map;
+	loff_t prev_size = i_size_read(inode);
 
-	remove_inode_hugepages(inode, 0, LLONG_MAX);
+	remove_inode_hugepages(inode, 0, LLONG_MAX, prev_size);
 
 	/*
 	 * Get the resv_map from the address space embedded in the inode.
@@ -528,6 +611,7 @@ static void hugetlb_vmtruncate(struct inode *inode, loff_t offset)
 	pgoff_t pgoff;
 	struct address_space *mapping = inode->i_mapping;
 	struct hstate *h = hstate_inode(inode);
+	loff_t prev_size = i_size_read(inode);
 
 	BUG_ON(offset & ~huge_page_mask(h));
 	pgoff = offset >> PAGE_SHIFT;
@@ -538,7 +622,7 @@ static void hugetlb_vmtruncate(struct inode *inode, loff_t offset)
 		hugetlb_vmdelete_list(&mapping->i_mmap, pgoff, 0,
 				      ZAP_FLAG_DROP_MARKER);
 	i_mmap_unlock_write(mapping);
-	remove_inode_hugepages(inode, offset, LLONG_MAX);
+	remove_inode_hugepages(inode, offset, LLONG_MAX, prev_size);
 }
 
 static void hugetlbfs_zero_partial_page(struct hstate *h,
@@ -610,7 +694,7 @@ static long hugetlbfs_punch_hole(struct inode *inode, loff_t offset, loff_t len)
 
 	/* Remove full pages from the file. */
 	if (hole_end > hole_start)
-		remove_inode_hugepages(inode, hole_start, hole_end);
+		remove_inode_hugepages(inode, hole_start, hole_end, hole_end);
 
 	inode_unlock(inode);
 
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 11c02513588c..a6eb46c64baf 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5527,6 +5527,7 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 	spinlock_t *ptl;
 	unsigned long haddr = address & huge_page_mask(h);
 	bool new_page, new_pagecache_page = false;
+	bool reserve_alloc = false;
 
 	/*
 	 * Currently, we are forced to kill the process in the event the
@@ -5584,9 +5585,13 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 		clear_huge_page(page, address, pages_per_huge_page(h));
 		__SetPageUptodate(page);
 		new_page = true;
+		if (HPageRestoreReserve(page))
+			reserve_alloc = true;
 
 		if (vma->vm_flags & VM_MAYSHARE) {
-			int err = hugetlb_add_to_page_cache(page, mapping, idx);
+			int err;
+
+			err = hugetlb_add_to_page_cache(page, mapping, idx);
 			if (err) {
 				restore_reserve_on_error(h, vma, haddr, page);
 				put_page(page);
@@ -5642,10 +5647,6 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 	}
 
 	ptl = huge_pte_lock(h, mm, ptep);
-	size = i_size_read(mapping->host) >> huge_page_shift(h);
-	if (idx >= size)
-		goto backout;
-
 	ret = 0;
 	/* If pte changed from under us, retry */
 	if (!pte_same(huge_ptep_get(ptep), old_pte))
@@ -5689,10 +5690,18 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 backout:
 	spin_unlock(ptl);
 backout_unlocked:
-	unlock_page(page);
-	/* restore reserve for newly allocated pages not in page cache */
-	if (new_page && !new_pagecache_page)
+	if (new_page && !new_pagecache_page) {
+		/*
+		 * If reserve was consumed, make sure flag is set so that it
+		 * will be restored in free_huge_page().
+		 */
+		if (reserve_alloc)
+			SetHPageRestoreReserve(page);
+
 		restore_reserve_on_error(h, vma, haddr, page);
+	}
+
+	unlock_page(page);
 	put_page(page);
 	goto out;
 }
@@ -6006,26 +6015,12 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 	ptl = huge_pte_lockptr(h, dst_mm, dst_pte);
 	spin_lock(ptl);
 
-	/*
-	 * Recheck the i_size after holding PT lock to make sure not
-	 * to leave any page mapped (as page_mapped()) beyond the end
-	 * of the i_size (remove_inode_hugepages() is strict about
-	 * enforcing that). If we bail out here, we'll also leave a
-	 * page in the radix tree in the vm_shared case beyond the end
-	 * of the i_size, but remove_inode_hugepages() will take care
-	 * of it as soon as we drop the hugetlb_fault_mutex_table.
-	 */
-	size = i_size_read(mapping->host) >> huge_page_shift(h);
-	ret = -EFAULT;
-	if (idx >= size)
-		goto out_release_unlock;
-
-	ret = -EEXIST;
 	/*
 	 * We allow to overwrite a pte marker: consider when both MISSING|WP
 	 * registered, we firstly wr-protect a none pte which has no page cache
 	 * page backing it, then access the page.
 	 */
+	ret = -EEXIST;
 	if (!huge_pte_none_mostly(huge_ptep_get(dst_pte)))
 		goto out_release_unlock;
 
-- 
2.37.1

