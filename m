Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50F235A00E8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 20:00:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240521AbiHXR7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 13:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240404AbiHXR6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 13:58:55 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8F60760F8
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 10:58:51 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27OHkbaX009154;
        Wed, 24 Aug 2022 17:58:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=7CDRJVazPQPG9DiPh65pmT4kKeEC7OVNZLRGCF/gHE8=;
 b=vJM8yYPPQGCyj64o8femZipqrgtc6qlpUwPDLu5NjAfEWy96feLGqWRwCxFIbGXyiRLq
 h2g3KW49l4l/t7QxVs31JED9kc+cULwFiPB4vUlJH1m0RFEhOB8rXEJxnyw18brBxmWc
 EJD7F3k8AW3Ha9MHesk7bCRTkGcTEb+y4jW7imcEKA27r7whx6ZDLk5D5C33MK/jL/Rf
 XDiKYF3Yfihu1HrNX0S1nYaiEQpWd7vHiSw1B8GFHhyKsTf2H2I+BIIvzN/kNo+vB6JO
 0Ni7EfY4DEE7I524DbPOK+LnxJvX7YXtJgM71AeVOVEH6n7CF1hxCiOU8sD7PMyZ97HJ kQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j5aww21nq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Aug 2022 17:58:31 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27OHF19X011111;
        Wed, 24 Aug 2022 17:58:30 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2047.outbound.protection.outlook.com [104.47.57.47])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3j5n6kujgb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Aug 2022 17:58:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S6FDtcIw9VoFlZTyCIx8SQNtwZBPuzLo4zT4ymzXPb3G5dM1zWGX4+8Htj/TDKeT9NkbKVUjECjA6WEzdejl3bCXr2UmhrGNb1NPweEEMdb7hZCpbQyqUnsxqugKd2BLzo9Osx+GWqYJ6X9O/fX0beY3wOV3aZ66vSmbjvT5J9bFu6wLkS7747cCvuEygjJNuH/N9QxJx/oLMwpKOwN5c2hhFuCirzn6p1zmi40JdUMg0Ed9prnaBKN4uYw12FGAPxe4vSFt7dhNH0TVJUmMbQrFIqfER4fr2e+BiuLvrStDQC/0DzSZP2SQhpmQ45wgVuiFG12Xt2yFCgTNSm92gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7CDRJVazPQPG9DiPh65pmT4kKeEC7OVNZLRGCF/gHE8=;
 b=PaggHaEXiBI3ExlzvOwIsvGqLTugGo9gl6kRlQBmq2hjCqTtWH5gXPJz5Hzc9HnXSzZoqwZ/oXxuwHXYo0Pa7kyFk8Fz1OXpxWKGEcxmoje7gl4hSFmyduTBtpbi/jXx099gBS4U3SSdpJOt016BlCpfskszZT98KHZAZ4EVQAiPki1UeLZeBaNNzxKhyaKJbw0bG6SXmjfYh9XltLejKqUzejFvEfqsCFDnoexhPDp6hvW1isQmgkOg6RN3F1VzbgkkpSUvcaqNK9yYtopuyrtiGVhHqzXxys9DuwokF7wZ9VX+vx1PHGWMllQCtGg5qYL0Jijpj4vq9Ae8jO1I9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7CDRJVazPQPG9DiPh65pmT4kKeEC7OVNZLRGCF/gHE8=;
 b=jQ2JxYFtqN7UcfuFw32385gbRYMKsfOEDD4sfzpY8s4bf4Z5+zirFa5Gt3NA32Sms2D7VLvJUiZJYhbUnBYOuuvGbdtE+LyMVcmOAB24hnqNqGx8bVVrmsXC+NZqtsSHmSijUFrM7B+WscpoDEefqbV7D/SpqomMaeoJDOyxLUI=
Received: from DM6PR10MB4201.namprd10.prod.outlook.com (2603:10b6:5:216::10)
 by PH0PR10MB4520.namprd10.prod.outlook.com (2603:10b6:510:43::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.19; Wed, 24 Aug
 2022 17:58:28 +0000
Received: from DM6PR10MB4201.namprd10.prod.outlook.com
 ([fe80::11b6:7a8a:1432:bec]) by DM6PR10MB4201.namprd10.prod.outlook.com
 ([fe80::11b6:7a8a:1432:bec%6]) with mapi id 15.20.5546.022; Wed, 24 Aug 2022
 17:58:28 +0000
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
Subject: [PATCH 8/8] hugetlb: use new vma_lock for pmd sharing synchronization
Date:   Wed, 24 Aug 2022 10:57:57 -0700
Message-Id: <20220824175757.20590-9-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220824175757.20590-1-mike.kravetz@oracle.com>
References: <20220824175757.20590-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0139.namprd03.prod.outlook.com
 (2603:10b6:303:8c::24) To DM6PR10MB4201.namprd10.prod.outlook.com
 (2603:10b6:5:216::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 45b9958e-2bb9-40ea-52a0-08da85fa3f7b
X-MS-TrafficTypeDiagnostic: PH0PR10MB4520:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bVEfA9zpxQ5Ikecekc2LbsKlQFIah6YvH4rU0b/7HNomVRhoO30kXFbS7Dome4Sbio4EYdY0mxyMRlo9YZ/g3ikfog3QzgtX+b52xHoebzQavW7qym2VSpgQcEPInZknLIqO6MAZbiqcE1fiRcXS/6rRrlh92pIu7Jpyws74nrSIq1pOk4OgKw/LsLNKA42+8OpSzejLdhsZfNQe1o/HrQrSdkrAzlcf5ONWj5CFJnReb50DIRFqmtysGQLpngQC5taTlEGBAQiLEiy8ITm3A3ZoLab9n1EJMSenDu1S7Vq5nHug/wC+S65RkmvWSQPAXChzSZyNZTMMHhz6c5YDT7YlAreZh3xCxGO4mRHPmYBY6q28WdrINngwDMxfJC60iHG4O/UC9/ihcGZshtOrS/mUoCL1AeuAiuNKIeWfJxI9IjqkzA5hulwakzsSAO9M3K8tV837IlH41XqljNUdkTEXQmLdpensGqG1YGA1DyxKYmbH7EgVYNLnTSTNMJzWbB5f/YNLYBYGLAi7jDapqmh3dTO3cJvqyz646W8bWULcieseQ9wFe94qRS8AZW1I/LLv0M0GVwR5eoRzts905ZWbVeUauVCTqT0O6XMutpDzJleeWTgGwa3atZ8TZIIVvQaay41EAQEDPCPJs00EIAcQDRuZHqBr3YHjkl0XDtirTV3OdmobmbBzraSF2OX0J+FaRjhxk6BEcAkql32sbA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4201.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(396003)(136003)(376002)(346002)(366004)(7416002)(1076003)(6512007)(6666004)(8936002)(26005)(186003)(30864003)(107886003)(2616005)(6506007)(44832011)(86362001)(36756003)(41300700001)(316002)(5660300002)(54906003)(478600001)(66556008)(8676002)(4326008)(6486002)(83380400001)(38100700002)(66946007)(2906002)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ew9aplPEbgmMpy7m33wAoDM+BQXMlNhkh64JifgOIdMy1ALYUPPKX6UztMWb?=
 =?us-ascii?Q?v/BCLXuIv1Z23U761C86BN1LBWAeuTVjZHaaXuni4Fyd77VltlByia8xJKFx?=
 =?us-ascii?Q?xyKuE15rK0uk52XrBQF7e04eu8S1FK7GpcMX8CYqtmpg/qD2xs3tFVqKTMa+?=
 =?us-ascii?Q?Z9UVHLwcOPyDg9tgSsMxk7iYJDurLZStAWKgPu+0TNaWmnZ8bmYqvWF81/U5?=
 =?us-ascii?Q?u/ZBVoqfe6ZT9pjTmX7ztof965Xc+bmaVak1A09ycKdl/+9y2eG+ToiTjRIY?=
 =?us-ascii?Q?WSOoofko7pRC21Ge2tTLpWTftLAs6zqNZnqzTylCXILqHvRBYiCcaqD1GFnk?=
 =?us-ascii?Q?8PsEkH6NckYh28M1qYxPJWRWL2OKcRNrbYPNJE8v7/tHnnfxwL7Gk00+ex85?=
 =?us-ascii?Q?nITT4rPnGIWt8oQBII0vNyCAOUFfYetAsInKy5IibTZf/xN8MKUlL+WUZ5qH?=
 =?us-ascii?Q?LRnliorVHhzey3tCP9rQd5xesBrXNye97qio/Sj/YQFSBze1X51ItpRPjxg7?=
 =?us-ascii?Q?iVI9BjdvqTyOYC5pE3ktoWhdYHqxxBU9PZgQT3Y+/7uOcOFrnJoRPgNI95Nj?=
 =?us-ascii?Q?14cs0ifRFQEG1bp7K7130zo73ge20GYGG0wUmPZcQfGyTNDhLRzj+7xoZtz4?=
 =?us-ascii?Q?xJMStIrV19X1U37ZeOMj37bgigjeRKzFYsWZ/zry0zdtl8jR1M3s1UfZIpLc?=
 =?us-ascii?Q?WBcW8kIDOEbAKsawH8hUVXSPHqN5GaGyUwxneX35On08Mx51Q/Mv6KWtWAmX?=
 =?us-ascii?Q?AS0ljlLeEm7qPJfxdgJulShaRwIZZBBw96y9Jw/BKCdNoD61p34+UK1n0Qtl?=
 =?us-ascii?Q?3zPYEl3P4Wlg1Bhz8zItzp+jJ5mjP87fA3bmyPWLC0KP4Z3Kr0nF8xmmXZKO?=
 =?us-ascii?Q?uRmmTaD2dM+Q8Tne4060RsyRSvv198V30dnG0fJ3jUY/8Xmvk8GjVAdoQuzC?=
 =?us-ascii?Q?qbtB49nzAoJCi44e6mYBKpdeZZIlaKbtwCVp0xpRrQaLG71ObbfiyUGoKv02?=
 =?us-ascii?Q?sfrgbLwjsJlwduBx/qLTcLGMgGqxO1pz+V//dGKj6/HbSRNV1aZEyPvN6Z53?=
 =?us-ascii?Q?zgynZ+dAljG4SC0x595Ov4QIbVHQi3444r1wUUgyAdHYWABdTmedXrqq+dpk?=
 =?us-ascii?Q?2b8pGpQBoMqUhk2byDiLnwFlG8nYeBwUHT2mUcHhnksVqghd4LaHEh8g0aqq?=
 =?us-ascii?Q?v3uljJB1gw0U7N/G5cMOuBLkZj2SwjmNjAKsOJWm3Y+S5uAACyetcJ1v17Eb?=
 =?us-ascii?Q?rF3NmIBD0I6/Jpx2YjMEOmJevlf+4IZWX80c1fD0/NJTMwacQgaq01jxYg67?=
 =?us-ascii?Q?TBWbmeE08aJDr+tAmelenoaiVhqm9fOZ8EdabIhwlSnRQjSTHLY2hqz0teV6?=
 =?us-ascii?Q?SARKADPsjKlbhf/bkq46F2xG42yIFbLenfTZOPPYGCoSKxFbiXUUf9jRoaxD?=
 =?us-ascii?Q?C91QvXMDhMqvJVUc2GfzjX+5d253AHJtigYYTmsb/BsT16stseG62+h5wR55?=
 =?us-ascii?Q?iBkuRcmS/P46JO2uI9ubdg2jYmx62jXF+F33TlkeOmueY9mJhQjVn7wCOoE7?=
 =?us-ascii?Q?EUWHbaJTD6o80F0/1ORuzA2K6kLbKpOndxQ714dbHhsZqB/JeJuc6AIPqI4D?=
 =?us-ascii?Q?OA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45b9958e-2bb9-40ea-52a0-08da85fa3f7b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4201.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2022 17:58:28.1898
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sTSMlEJwZ3gSe5U0AKc/oXAk52QrpgOYxI9fl1/mTPVJ/38nv6oBB9WN0vToSb6Wd5N/zFzuedqwaYGsWgEHtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4520
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-24_11,2022-08-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208240066
X-Proofpoint-GUID: e8Ypa2Hh_XG989LNZYfwgmGaQyCjRPhX
X-Proofpoint-ORIG-GUID: e8Ypa2Hh_XG989LNZYfwgmGaQyCjRPhX
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new hugetlb vma lock (rw semaphore) is used to address this race:

Faulting thread                                 Unsharing thread
...                                                  ...
ptep = huge_pte_offset()
      or
ptep = huge_pte_alloc()
...
                                                i_mmap_lock_write
                                                lock page table
ptep invalid   <------------------------        huge_pmd_unshare()
Could be in a previously                        unlock_page_table
sharing process or worse                        i_mmap_unlock_write
...

The vma_lock is used as follows:
- During fault processing. the lock is acquired in read mode before
  doing a page table lock and allocation (huge_pte_alloc).  The lock is
  held until code is finished with the page table entry (ptep).
- The lock must be held in write mode whenever huge_pmd_unshare is
  called.

Lock ordering issues come into play when unmapping a page from all
vmas mapping the page.  The i_mmap_rwsem must be held to search for the
vmas, and the vma lock must be held before calling unmap which will
call huge_pmd_unshare.  This is done today in:
- try_to_migrate_one and try_to_unmap_ for page migration and memory
  error handling.  In these routines we 'try' to obtain the vma lock and
  fail to unmap if unsuccessful.  Calling routines already deal with the
  failure of unmapping.
- hugetlb_vmdelete_list for truncation and hole punch.  This routine
  also tries to acquire the vma lock.  If it fails, it skips the
  unmapping.  However, we can not have file truncation or hole punch
  fail because of contention.  After hugetlb_vmdelete_list, truncation
  and hole punch call remove_inode_hugepages.  remove_inode_hugepages
  check for mapped pages and call hugetlb_unmap_file_page to unmap them.
  hugetlb_unmap_file_page is designed to drop locks and reacquire in the
  correct order to guarantee unmap success.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 fs/hugetlbfs/inode.c |  46 +++++++++++++++++++
 mm/hugetlb.c         | 102 +++++++++++++++++++++++++++++++++++++++----
 mm/memory.c          |   2 +
 mm/rmap.c            | 100 +++++++++++++++++++++++++++---------------
 mm/userfaultfd.c     |   9 +++-
 5 files changed, 214 insertions(+), 45 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index b93d131b0cb5..52d9b390389b 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -434,6 +434,8 @@ static void hugetlb_unmap_file_folio(struct hstate *h,
 					struct folio *folio, pgoff_t index)
 {
 	struct rb_root_cached *root = &mapping->i_mmap;
+	unsigned long skipped_vm_start;
+	struct mm_struct *skipped_mm;
 	struct page *page = &folio->page;
 	struct vm_area_struct *vma;
 	unsigned long v_start;
@@ -444,6 +446,8 @@ static void hugetlb_unmap_file_folio(struct hstate *h,
 	end = ((index + 1) * pages_per_huge_page(h));
 
 	i_mmap_lock_write(mapping);
+retry:
+	skipped_mm = NULL;
 
 	vma_interval_tree_foreach(vma, root, start, end - 1) {
 		v_start = vma_offset_start(vma, start);
@@ -452,11 +456,49 @@ static void hugetlb_unmap_file_folio(struct hstate *h,
 		if (!hugetlb_vma_maps_page(vma, vma->vm_start + v_start, page))
 			continue;
 
+		if (!hugetlb_vma_trylock_write(vma)) {
+			/*
+			 * If we can not get vma lock, we need to drop
+			 * immap_sema and take locks in order.
+			 */
+			skipped_vm_start = vma->vm_start;
+			skipped_mm = vma->vm_mm;
+			/* grab mm-struct as we will be dropping i_mmap_sema */
+			mmgrab(skipped_mm);
+			break;
+		}
+
 		unmap_hugepage_range(vma, vma->vm_start + v_start, v_end,
 				NULL, ZAP_FLAG_DROP_MARKER);
+		hugetlb_vma_unlock_write(vma);
 	}
 
 	i_mmap_unlock_write(mapping);
+
+	if (skipped_mm) {
+		mmap_read_lock(skipped_mm);
+		vma = find_vma(skipped_mm, skipped_vm_start);
+		if (!vma || !is_vm_hugetlb_page(vma) ||
+					vma->vm_file->f_mapping != mapping ||
+					vma->vm_start != skipped_vm_start) {
+			mmap_read_unlock(skipped_mm);
+			mmdrop(skipped_mm);
+			goto retry;
+		}
+
+		hugetlb_vma_lock_write(vma);
+		i_mmap_lock_write(mapping);
+		mmap_read_unlock(skipped_mm);
+		mmdrop(skipped_mm);
+
+		v_start = vma_offset_start(vma, start);
+		v_end = vma_offset_end(vma, end);
+		unmap_hugepage_range(vma, vma->vm_start + v_start, v_end,
+				NULL, ZAP_FLAG_DROP_MARKER);
+		hugetlb_vma_unlock_write(vma);
+
+		goto retry;
+	}
 }
 
 static void
@@ -474,11 +516,15 @@ hugetlb_vmdelete_list(struct rb_root_cached *root, pgoff_t start, pgoff_t end,
 		unsigned long v_start;
 		unsigned long v_end;
 
+		if (!hugetlb_vma_trylock_write(vma))
+			continue;
+
 		v_start = vma_offset_start(vma, start);
 		v_end = vma_offset_end(vma, end);
 
 		unmap_hugepage_range(vma, vma->vm_start + v_start, v_end,
 				     NULL, zap_flags);
+		hugetlb_vma_unlock_write(vma);
 	}
 }
 
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 6fb0bff2c7ee..5912c2b97ddf 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4801,6 +4801,14 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 		mmu_notifier_invalidate_range_start(&range);
 		mmap_assert_write_locked(src);
 		raw_write_seqcount_begin(&src->write_protect_seq);
+	} else {
+		/*
+		 * For shared mappings the vma lock must be held before
+		 * calling huge_pte_offset in the src vma. Otherwise, the
+		 * returned ptep could go away if part of a shared pmd and
+		 * another thread calls huge_pmd_unshare.
+		 */
+		hugetlb_vma_lock_read(src_vma);
 	}
 
 	last_addr_mask = hugetlb_mask_last_page(h);
@@ -4948,6 +4956,8 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 	if (cow) {
 		raw_write_seqcount_end(&src->write_protect_seq);
 		mmu_notifier_invalidate_range_end(&range);
+	} else {
+		hugetlb_vma_unlock_read(src_vma);
 	}
 
 	return ret;
@@ -5006,6 +5016,7 @@ int move_hugetlb_page_tables(struct vm_area_struct *vma,
 	mmu_notifier_invalidate_range_start(&range);
 	last_addr_mask = hugetlb_mask_last_page(h);
 	/* Prevent race with file truncation */
+	hugetlb_vma_lock_write(vma);
 	i_mmap_lock_write(mapping);
 	for (; old_addr < old_end; old_addr += sz, new_addr += sz) {
 		src_pte = huge_pte_offset(mm, old_addr, sz);
@@ -5037,6 +5048,7 @@ int move_hugetlb_page_tables(struct vm_area_struct *vma,
 		flush_tlb_range(vma, old_end - len, old_end);
 	mmu_notifier_invalidate_range_end(&range);
 	i_mmap_unlock_write(mapping);
+	hugetlb_vma_unlock_write(vma);
 
 	return len + old_addr - old_end;
 }
@@ -5356,9 +5368,30 @@ static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
 		 * may get SIGKILLed if it later faults.
 		 */
 		if (outside_reserve) {
+			struct address_space *mapping = vma->vm_file->f_mapping;
+			pgoff_t idx;
+			u32 hash;
+
 			put_page(old_page);
 			BUG_ON(huge_pte_none(pte));
+			/*
+			 * Drop hugetlb_fault_mutex and vma_lock before
+			 * unmapping.  unmapping needs to hold vma_lock
+			 * in write mode.  Dropping vma_lock in read mode
+			 * here is OK as COW mappings do not interact with
+			 * PMD sharing.
+			 *
+			 * Reacquire both after unmap operation.
+			 */
+			idx = vma_hugecache_offset(h, vma, haddr);
+			hash = hugetlb_fault_mutex_hash(mapping, idx);
+			hugetlb_vma_unlock_read(vma);
+			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
+
 			unmap_ref_private(mm, vma, old_page, haddr);
+
+			mutex_lock(&hugetlb_fault_mutex_table[hash]);
+			hugetlb_vma_lock_read(vma);
 			spin_lock(ptl);
 			ptep = huge_pte_offset(mm, haddr, huge_page_size(h));
 			if (likely(ptep &&
@@ -5520,14 +5553,16 @@ static inline vm_fault_t hugetlb_handle_userfault(struct vm_area_struct *vma,
 	};
 
 	/*
-	 * hugetlb_fault_mutex and i_mmap_rwsem must be
+	 * vma_lock and hugetlb_fault_mutex must be
 	 * dropped before handling userfault.  Reacquire
 	 * after handling fault to make calling code simpler.
 	 */
+	hugetlb_vma_unlock_read(vma);
 	hash = hugetlb_fault_mutex_hash(mapping, idx);
 	mutex_unlock(&hugetlb_fault_mutex_table[hash]);
 	ret = handle_userfault(&vmf, reason);
 	mutex_lock(&hugetlb_fault_mutex_table[hash]);
+	hugetlb_vma_lock_read(vma);
 
 	return ret;
 }
@@ -5767,6 +5802,11 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 
 	ptep = huge_pte_offset(mm, haddr, huge_page_size(h));
 	if (ptep) {
+		/*
+		 * Since we hold no locks, ptep could be stale.  That is
+		 * OK as we are only making decisions based on content and
+		 * not actually modifying content here.
+		 */
 		entry = huge_ptep_get(ptep);
 		if (unlikely(is_hugetlb_entry_migration(entry))) {
 			migration_entry_wait_huge(vma, ptep);
@@ -5774,23 +5814,35 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 		} else if (unlikely(is_hugetlb_entry_hwpoisoned(entry)))
 			return VM_FAULT_HWPOISON_LARGE |
 				VM_FAULT_SET_HINDEX(hstate_index(h));
-	} else {
-		ptep = huge_pte_alloc(mm, vma, haddr, huge_page_size(h));
-		if (!ptep)
-			return VM_FAULT_OOM;
 	}
 
-	mapping = vma->vm_file->f_mapping;
-	idx = vma_hugecache_offset(h, vma, haddr);
-
 	/*
 	 * Serialize hugepage allocation and instantiation, so that we don't
 	 * get spurious allocation failures if two CPUs race to instantiate
 	 * the same page in the page cache.
 	 */
+	mapping = vma->vm_file->f_mapping;
+	idx = vma_hugecache_offset(h, vma, haddr);
 	hash = hugetlb_fault_mutex_hash(mapping, idx);
 	mutex_lock(&hugetlb_fault_mutex_table[hash]);
 
+	/*
+	 * Acquire vma lock before calling huge_pte_alloc and hold
+	 * until finished with ptep.  This prevents huge_pmd_unshare from
+	 * being called elsewhere and making the ptep no longer valid.
+	 *
+	 * ptep could have already be assigned via huge_pte_offset.  That
+	 * is OK, as huge_pte_alloc will return the same value unless
+	 * something has changed.
+	 */
+	hugetlb_vma_lock_read(vma);
+	ptep = huge_pte_alloc(mm, vma, haddr, huge_page_size(h));
+	if (!ptep) {
+		hugetlb_vma_unlock_read(vma);
+		mutex_unlock(&hugetlb_fault_mutex_table[hash]);
+		return VM_FAULT_OOM;
+	}
+
 	entry = huge_ptep_get(ptep);
 	/* PTE markers should be handled the same way as none pte */
 	if (huge_pte_none_mostly(entry)) {
@@ -5851,6 +5903,7 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 			unlock_page(pagecache_page);
 			put_page(pagecache_page);
 		}
+		hugetlb_vma_unlock_read(vma);
 		mutex_unlock(&hugetlb_fault_mutex_table[hash]);
 		return handle_userfault(&vmf, VM_UFFD_WP);
 	}
@@ -5894,6 +5947,7 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 		put_page(pagecache_page);
 	}
 out_mutex:
+	hugetlb_vma_unlock_read(vma);
 	mutex_unlock(&hugetlb_fault_mutex_table[hash]);
 	/*
 	 * Generally it's safe to hold refcount during waiting page lock. But
@@ -6343,8 +6397,9 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
 	flush_cache_range(vma, range.start, range.end);
 
 	mmu_notifier_invalidate_range_start(&range);
-	last_addr_mask = hugetlb_mask_last_page(h);
+	hugetlb_vma_lock_write(vma);
 	i_mmap_lock_write(vma->vm_file->f_mapping);
+	last_addr_mask = hugetlb_mask_last_page(h);
 	for (; address < end; address += psize) {
 		spinlock_t *ptl;
 		ptep = huge_pte_offset(mm, address, psize);
@@ -6443,6 +6498,7 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
 	 * See Documentation/mm/mmu_notifier.rst
 	 */
 	i_mmap_unlock_write(vma->vm_file->f_mapping);
+	hugetlb_vma_unlock_write(vma);
 	mmu_notifier_invalidate_range_end(&range);
 
 	return pages << h->order;
@@ -6909,6 +6965,7 @@ int huge_pmd_unshare(struct mm_struct *mm, struct vm_area_struct *vma,
 	pud_t *pud = pud_offset(p4d, addr);
 
 	i_mmap_assert_write_locked(vma->vm_file->f_mapping);
+	hugetlb_vma_assert_locked(vma);
 	BUG_ON(page_count(virt_to_page(ptep)) == 0);
 	if (page_count(virt_to_page(ptep)) == 1)
 		return 0;
@@ -6920,6 +6977,31 @@ int huge_pmd_unshare(struct mm_struct *mm, struct vm_area_struct *vma,
 }
 
 #else /* !CONFIG_ARCH_WANT_HUGE_PMD_SHARE */
+void hugetlb_vma_lock_read(struct vm_area_struct *vma)
+{
+}
+
+void hugetlb_vma_unlock_read(struct vm_area_struct *vma)
+{
+}
+
+void hugetlb_vma_lock_write(struct vm_area_struct *vma)
+{
+}
+
+void hugetlb_vma_unlock_write(struct vm_area_struct *vma)
+{
+}
+
+int hugetlb_vma_trylock_write(struct vm_area_struct *vma)
+{
+	return 1;
+}
+
+void hugetlb_vma_assert_locked(struct vm_area_struct *vma)
+{
+}
+
 static void hugetlb_vma_lock_free(struct vm_area_struct *vma)
 {
 }
@@ -7298,6 +7380,7 @@ void hugetlb_unshare_all_pmds(struct vm_area_struct *vma)
 	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, vma, mm,
 				start, end);
 	mmu_notifier_invalidate_range_start(&range);
+	hugetlb_vma_lock_write(vma);
 	i_mmap_lock_write(vma->vm_file->f_mapping);
 	for (address = start; address < end; address += PUD_SIZE) {
 		ptep = huge_pte_offset(mm, address, sz);
@@ -7309,6 +7392,7 @@ void hugetlb_unshare_all_pmds(struct vm_area_struct *vma)
 	}
 	flush_hugetlb_tlb_range(vma, start, end);
 	i_mmap_unlock_write(vma->vm_file->f_mapping);
+	hugetlb_vma_unlock_write(vma);
 	/*
 	 * No need to call mmu_notifier_invalidate_range(), see
 	 * Documentation/mm/mmu_notifier.rst.
diff --git a/mm/memory.c b/mm/memory.c
index 2f3cc57a5a11..55166045ab55 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1675,10 +1675,12 @@ static void unmap_single_vma(struct mmu_gather *tlb,
 			if (vma->vm_file) {
 				zap_flags_t zap_flags = details ?
 				    details->zap_flags : 0;
+				hugetlb_vma_lock_write(vma);
 				i_mmap_lock_write(vma->vm_file->f_mapping);
 				__unmap_hugepage_range_final(tlb, vma, start, end,
 							     NULL, zap_flags);
 				i_mmap_unlock_write(vma->vm_file->f_mapping);
+				hugetlb_vma_unlock_write(vma);
 			}
 		} else
 			unmap_page_range(tlb, vma, start, end, details);
diff --git a/mm/rmap.c b/mm/rmap.c
index 55209e029847..60d7db60428e 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1558,24 +1558,39 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 			 * To call huge_pmd_unshare, i_mmap_rwsem must be
 			 * held in write mode.  Caller needs to explicitly
 			 * do this outside rmap routines.
+			 *
+			 * We also must hold hugetlb vma_lock in write mode.
+			 * Lock order dictates acquiring vma_lock BEFORE
+			 * i_mmap_rwsem.  We can only try lock here and fail
+			 * if unsuccessful.
 			 */
-			VM_BUG_ON(!anon && !(flags & TTU_RMAP_LOCKED));
-			if (!anon && huge_pmd_unshare(mm, vma, address, pvmw.pte)) {
-				flush_tlb_range(vma, range.start, range.end);
-				mmu_notifier_invalidate_range(mm, range.start,
-							      range.end);
-
-				/*
-				 * The ref count of the PMD page was dropped
-				 * which is part of the way map counting
-				 * is done for shared PMDs.  Return 'true'
-				 * here.  When there is no other sharing,
-				 * huge_pmd_unshare returns false and we will
-				 * unmap the actual page and drop map count
-				 * to zero.
-				 */
-				page_vma_mapped_walk_done(&pvmw);
-				break;
+			if (!anon) {
+				VM_BUG_ON(!(flags & TTU_RMAP_LOCKED));
+				if (!hugetlb_vma_trylock_write(vma)) {
+					page_vma_mapped_walk_done(&pvmw);
+					ret = false;
+					break;
+				}
+				if (huge_pmd_unshare(mm, vma, address, pvmw.pte)) {
+					hugetlb_vma_unlock_write(vma);
+					flush_tlb_range(vma,
+						range.start, range.end);
+					mmu_notifier_invalidate_range(mm,
+						range.start, range.end);
+					/*
+					 * The ref count of the PMD page was
+					 * dropped which is part of the way map
+					 * counting is done for shared PMDs.
+					 * Return 'true' here.  When there is
+					 * no other sharing, huge_pmd_unshare
+					 * returns false and we will unmap the
+					 * actual page and drop map count
+					 * to zero.
+					 */
+					page_vma_mapped_walk_done(&pvmw);
+					break;
+				}
+				hugetlb_vma_unlock_write(vma);
 			}
 			pteval = huge_ptep_clear_flush(vma, address, pvmw.pte);
 		} else {
@@ -1934,26 +1949,41 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
 			 * To call huge_pmd_unshare, i_mmap_rwsem must be
 			 * held in write mode.  Caller needs to explicitly
 			 * do this outside rmap routines.
+			 *
+			 * We also must hold hugetlb vma_lock in write mode.
+			 * Lock order dictates acquiring vma_lock BEFORE
+			 * i_mmap_rwsem.  We can only try lock here and
+			 * fail if unsuccessful.
 			 */
-			VM_BUG_ON(!anon && !(flags & TTU_RMAP_LOCKED));
-			if (!anon && huge_pmd_unshare(mm, vma, address, pvmw.pte)) {
-				flush_tlb_range(vma, range.start, range.end);
-				mmu_notifier_invalidate_range(mm, range.start,
-							      range.end);
-
-				/*
-				 * The ref count of the PMD page was dropped
-				 * which is part of the way map counting
-				 * is done for shared PMDs.  Return 'true'
-				 * here.  When there is no other sharing,
-				 * huge_pmd_unshare returns false and we will
-				 * unmap the actual page and drop map count
-				 * to zero.
-				 */
-				page_vma_mapped_walk_done(&pvmw);
-				break;
+			if (!anon) {
+				VM_BUG_ON(!(flags & TTU_RMAP_LOCKED));
+				if (!hugetlb_vma_trylock_write(vma)) {
+					page_vma_mapped_walk_done(&pvmw);
+					ret = false;
+					break;
+				}
+				if (huge_pmd_unshare(mm, vma, address, pvmw.pte)) {
+					hugetlb_vma_unlock_write(vma);
+					flush_tlb_range(vma,
+						range.start, range.end);
+					mmu_notifier_invalidate_range(mm,
+						range.start, range.end);
+
+					/*
+					 * The ref count of the PMD page was
+					 * dropped which is part of the way map
+					 * counting is done for shared PMDs.
+					 * Return 'true' here.  When there is
+					 * no other sharing, huge_pmd_unshare
+					 * returns false and we will unmap the
+					 * actual page and drop map count
+					 * to zero.
+					 */
+					page_vma_mapped_walk_done(&pvmw);
+					break;
+				}
+				hugetlb_vma_unlock_write(vma);
 			}
-
 			/* Nuke the hugetlb page table entry */
 			pteval = huge_ptep_clear_flush(vma, address, pvmw.pte);
 		} else {
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 7707f2664adb..2b0502710ea1 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -377,16 +377,21 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
 		BUG_ON(dst_addr >= dst_start + len);
 
 		/*
-		 * Serialize via hugetlb_fault_mutex.
+		 * Serialize via vma_lock and hugetlb_fault_mutex.
+		 * vma_lock ensures the dst_pte remains valid even
+		 * in the case of shared pmds.  fault mutex prevents
+		 * races with other faulting threads.
 		 */
 		idx = linear_page_index(dst_vma, dst_addr);
 		mapping = dst_vma->vm_file->f_mapping;
 		hash = hugetlb_fault_mutex_hash(mapping, idx);
 		mutex_lock(&hugetlb_fault_mutex_table[hash]);
+		hugetlb_vma_lock_read(dst_vma);
 
 		err = -ENOMEM;
 		dst_pte = huge_pte_alloc(dst_mm, dst_vma, dst_addr, vma_hpagesize);
 		if (!dst_pte) {
+			hugetlb_vma_unlock_read(dst_vma);
 			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
 			goto out_unlock;
 		}
@@ -394,6 +399,7 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
 		if (mode != MCOPY_ATOMIC_CONTINUE &&
 		    !huge_pte_none_mostly(huge_ptep_get(dst_pte))) {
 			err = -EEXIST;
+			hugetlb_vma_unlock_read(dst_vma);
 			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
 			goto out_unlock;
 		}
@@ -402,6 +408,7 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
 					       dst_addr, src_addr, mode, &page,
 					       wp_copy);
 
+		hugetlb_vma_unlock_read(dst_vma);
 		mutex_unlock(&hugetlb_fault_mutex_table[hash]);
 
 		cond_resched();
-- 
2.37.1

