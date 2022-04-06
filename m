Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 684114F6CDB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 23:34:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236152AbiDFVg0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 17:36:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236021AbiDFVe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 17:34:28 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B8B439162
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 13:49:05 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 236KXxDb024447;
        Wed, 6 Apr 2022 20:48:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=CbB8HYoTtQrkgpUR1SAECZ5vTD+acpv+582ig97c9e8=;
 b=ZlbV0oXjsniRk7/ZCh5tJT4PS15tSHsI3ksRHGj66kS+2ya3r2ciKu0kkyMBQ+gpinc4
 zKrzAgflUL/d4LVMf8ykVIC060byAJhzVLYw/hcKG6OA6vHxAL1tioxDaPnQxvdSvsqY
 Xj532z0rc1LTpZAqyAbMtF9j3CCyU5+FwLTQJl1kJHcNKIjiFrxvKnwQ0e1jyqF7vyyR
 M8zAKBm0Dtf8iUeoCClfJU6kTTS+p5FMYDM1lz5KYDiGVDxzO2jX74amgEGhiFVo9oXF
 b3WeWnWMSQ5km+5Y4c4utfl9PsbHfMZ8a7suAQzx1NXW1kYvIp0fUWmSYTaQBTs+2eZF Ww== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6f1ta8ty-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Apr 2022 20:48:50 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 236KkxEl025441;
        Wed, 6 Apr 2022 20:48:48 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3f974dbg4j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Apr 2022 20:48:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cRnPVY6bqQMpIlt8y1YANZEmXMja21KCeY4hqd+QMv0xDo0yg8aeEC8SWPOuJJT/9RtPWULezKg8PbEAe+g7WDAlonbEjhMqDPsQ7Gp9I/BQTkQ5h7wKhdSIMD0K7FqGpvy0/HsOqVyJChSsdC8GpZlOl6hpTfWy6p56O5C9PEb+Bvn6TV/3qN4NFIiL6g93dUcyAxvyhEVdLCooqVt64cqRrEUtzbj9oHRi8CEW45PGuk6ZMFouIh+p9HCpU8I4f5brwxu/+19b+PxeIeLOUuTHgqQDtzJCbaSQYEuDuK/wDkuo106MDCHiPHtrfOcEVqdvT124a3S2iWaeE7vbAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CbB8HYoTtQrkgpUR1SAECZ5vTD+acpv+582ig97c9e8=;
 b=dau7AFnpNVuDKDqeFtsAmFkVDI6f8g61hbwLME7i/jnL9Z6NzVVcTPxvYlkY3B63Mhw0yNN1LP8zjeAFCOFYMco5B/onJnVfoLEdaJ1+7I1cIDR3nCK9qpRJXxcgX++WXaSo+Z8zebr8RI24a9qaWD7QNLpVIcf8yVOxVgaawepEtTdWJ4ZmPyuxOIaFlDLSUu8NMBWCsZa+8hA6cXLNFCnJB0iw+qTriQ97TwPjC5IJSxBq9K8REdskS/fL7S//fFMGrSE5Pt2OvUDErCqdPxFJVTWfk/D2vwCupYnYfwv26VurMV32wmveNFoJxtUjHwBxuDXuCVSKobJRuTED+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CbB8HYoTtQrkgpUR1SAECZ5vTD+acpv+582ig97c9e8=;
 b=Zbp/GEdXjPGTrYK8y2iqyc673CB6WLFMrgpr1s0ljy/RhmVROXtp1rarTjN0ODNdXRTYnBcLUUvn3HaCWlQqTnOtB6GnxgmPtU4pMO7EdQ+mRZp7zLtsoPtRVWvNEnmJ0M8Zvuq1Gg7oDM0kS6XmzCjkzLv5a9TzvDV4+bzqeEc=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BN8PR10MB3362.namprd10.prod.outlook.com (2603:10b6:408:cf::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Wed, 6 Apr
 2022 20:48:45 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::245f:e3b1:35fd:43c5]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::245f:e3b1:35fd:43c5%8]) with mapi id 15.20.5144.019; Wed, 6 Apr 2022
 20:48:45 +0000
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
Subject: [RFC PATCH 5/5] hugetlb: Check for pmd unshare and fault/lookup races
Date:   Wed,  6 Apr 2022 13:48:23 -0700
Message-Id: <20220406204823.46548-6-mike.kravetz@oracle.com>
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
X-MS-Office365-Filtering-Correlation-Id: a5a9d5f0-4c18-4cfe-7860-08da180ed7b4
X-MS-TrafficTypeDiagnostic: BN8PR10MB3362:EE_
X-Microsoft-Antispam-PRVS: <BN8PR10MB336223B4BA2E8B0AAEE9258EE2E79@BN8PR10MB3362.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k1IjBBjmZsaFjrcwHuxWintP10fmGp1MCB4747kd9OYze8+N3dMB1OXF2UE3IXaS9ga7wu8NaOWMQcgEjLkXe/zBnUwo070gzKLsBR5y55WgITk1eSPVz2vpmKY+Z4YIrmSF72p34jF4SLFKa6aRSqi57HSHe5Pxs50Or3HtuqZOvgRYxi+qdmbHGfT5z9lv56+dQ+t+CVtsYPXUwrzea9IXQLEAhCwicQYYMZwLEVisTiCMx4mKj4Dapw+MLptwHymu038DhAakABV3JNvYoLcorfwZVgcla2vXISQ+iAACj+s2OHLKs+1QH0VVQyecfOJdAch44NSe0d1wKD7xoZhAhbwRJI5EaOqvbwiMOh072F4+QqWAqJnR/OB7hZNiJdBC0508sj3vHDQ+ar4QToTiQHD64FTnIZM7CZyYa5sZg1IluwL+E7qC57iwZW9I/Pi/lGpM8I2b19Aw8UK/QVSqCllFVhRBZ1V1S/XNW+OY5FnntRdMxQK0h9p7Pl4eAvhpNyhPHltW/ZNMGgZEF413yk3ADQxdmbhtUHMbeHQ3b1NzxF1nfGP1eBh8OC0lfXan9mqQON7zT4nwtG4nrV7m6897D5Sl5g3qxgKVPpw1+26iNBkHccieC/rsFqTA2WA+TV3+J7WZHZK0xuQIKh4kfmFScXHkc/ZZ4QClNnelwwuQ0PO62WijAQSSTeHGXSqapKKSdBA0ZR58jjAd5w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6666004)(38100700002)(66476007)(86362001)(66556008)(66946007)(83380400001)(8676002)(6486002)(38350700002)(508600001)(186003)(26005)(4326008)(6506007)(54906003)(316002)(1076003)(6512007)(44832011)(2616005)(107886003)(5660300002)(36756003)(8936002)(7416002)(2906002)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AoaUxBLevg1/bWL20/wgc6zPa8S9VjGBg8ylupUVwdKBYq9FD/ypWB+DXmco?=
 =?us-ascii?Q?lcgNTjC4/1xxc8wcYTblfFshBgJfnp4pyZADxQIDw16CdQ/OiTGSXiuQ4AZB?=
 =?us-ascii?Q?mRxmFBEykcN7SRfPxzV3AQhQL/mw/s7jfDGrftiPrMb6sppsK6HBsoOlu2gz?=
 =?us-ascii?Q?8V1bBbUqcHkBi092TjIRA9jbOKaLNZ7Dl+sBn0ZY1nCPmM1JLcVa/gJD3rDo?=
 =?us-ascii?Q?NohGppe4o//c+HC3oOrYRUA0VUKeiY3Zb/cTOCS2X5WA/fgZsPl+QiuX3JRB?=
 =?us-ascii?Q?d9U0D0aCqK8YwK/LOKkiu8+DNMDEuLRp7wJ4H/RvaQW8vXSOy6pfl9QqG1hl?=
 =?us-ascii?Q?EPMAwJFH+8SlSt/0hZ27JprmFMvnznm6Kw8JosL8yTaR+UERdW2LgHKA/GBx?=
 =?us-ascii?Q?V89SbD6b8uFg+Jsgrqqk4bDRmxlK3hB63NDl6tP6BFTbUMAEaMwbb+WKONtY?=
 =?us-ascii?Q?FHv2SYUqdYWLV/EPJtxj/5HpD1SAZaMGKodunFVAKcMaRYvaxdc/z4tg/z0o?=
 =?us-ascii?Q?st4v3F7/eVHYAFT3RHxYWHbuYPWxXMjnp2dRews/JgDENBYTwNBLqmyrvJzl?=
 =?us-ascii?Q?kLHvdG5vauinVXOKW8KKKs1yiLX0JYImz6qiqCRMr+qGyP9YRFYZ1nv2hi4t?=
 =?us-ascii?Q?5f/pF+c5jWFTNit843+HhI4hS0rhCjXiuoE5Fdd3Jk4lMhjERiV9LFIxUy5u?=
 =?us-ascii?Q?vS+f/539ETWbKu3pP09kpC+YrLVgIzrxnfMw8C2vxht5f5odR8ZAzT0Kd2gE?=
 =?us-ascii?Q?Z2Pty8B2aLIGUEOC3Z8XVbl7tHzg3qX0+BJNHF/IhVuJ5AC/P9KxpUhEO5mk?=
 =?us-ascii?Q?emYWrdSW10XmF0kS/cSjpifEMmqeXWFFsX1UXKSP9Dtd63+4d6IC24L6qAdI?=
 =?us-ascii?Q?jOdOYRlm3eii5ZuxyMIneebKBYC+HQlWajxG1Az50VohpQzIIGXic14C2zNn?=
 =?us-ascii?Q?8WBQ5oiGNqhDA1b4Fv7t3sZBjebkH0fL/IHCZiVIXIOIxqTvlK3AO8jbkG0k?=
 =?us-ascii?Q?6u9i6Xepp+pXziIh3ujmxTUvu5cIdQp4HZQC1FveHfsUhbwdomS0v4wDKkvk?=
 =?us-ascii?Q?I1KIaQtYbB8WDkh4uEuoJ+OyH6N/B+OfburoYywIyzQW7F6wPeqV1b+QEeF0?=
 =?us-ascii?Q?TR25uv9P0iOGslGEhobJzx/kf1FlVSVNwaDU3oBEMJjD6PzYhsrkfo75YCcg?=
 =?us-ascii?Q?BDuGg7DIoa+MSm9+yzM+52xx0x+PsdpjSesVx5HRUSSTXLSiLY5zwUI88U9E?=
 =?us-ascii?Q?Yovegu07rA6q3/WeCuZnoZu8RJCCCYsUUEruY5ibtlh10hNdbrHmDeNxD6q/?=
 =?us-ascii?Q?LoXgyBIOzCRR/cdfHHcKe9F53IIuveDD8HwYXmb4/Ovfgb/HVRp4hmHindPa?=
 =?us-ascii?Q?MLJp2WBFs3dPvi2q4WiscZaoyVQdElsgvvuZloP+zSjbh3CG7rg2NXKOyWGJ?=
 =?us-ascii?Q?ni4KPkeAX/xah2Gr7SYYZ8t6cdtIchtqjz9qGmojpnTXw+/KNEwt1UOyumaz?=
 =?us-ascii?Q?T4mnYOl/dZhuhFQiIKMf5Kg3T5uVJL2z418ywZ5Bn/NQ4kS8Ec8dIBu46sIS?=
 =?us-ascii?Q?290GjsZskrH6WspHqR4HoLPzJKaKJTeX8EEYkzHCxOtYgvHBk1lnvNlmLxoW?=
 =?us-ascii?Q?3VTXLs8BcZBIwSzj5khYQwyss5ZWOxzp/421fBw9hSBE4pEYhzOSeqJ/t+Go?=
 =?us-ascii?Q?kpZQezmhFwpGHfwgycpXn5/1pRG+GC9PHbNr1zrbcnm6uA7gyzmpCVHhyx86?=
 =?us-ascii?Q?RO1KhQS3EHB8mWrp8rk3de3CmV0rIaU=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5a9d5f0-4c18-4cfe-7860-08da180ed7b4
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2022 20:48:45.6071
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R/Nw4MaczzTjfOX3/bmUXeDdzo0BSaPFsbyx8QYQq+nPlY0+3oGgGqpuxY5PJMab1dzbjISA0sHv5le3kEvRNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR10MB3362
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-06_12:2022-04-06,2022-04-06 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 bulkscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204060103
X-Proofpoint-ORIG-GUID: ZEYI-vJqnT0ULAbMIX8ko_MaygG70-EO
X-Proofpoint-GUID: ZEYI-vJqnT0ULAbMIX8ko_MaygG70-EO
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a pmd is 'unshared' it effectivelly deletes part of a processes
page tables.  The routine huge_pmd_unshare must be called with
i_mmap_rwsem held in write mode and the page table locked.  However,
consider a page fault happening within that same process.  We could
have the following race:

Faulting thread					Unsharing thread
...						     ...
ptep = huge_pte_offset()
      or
ptep = huge_pte_alloc()
...
						i_mmap_unlock_write
						lock_page table
ptep invalid   <------------------------	huge_pmd_unshare
Could be in a previously			unlock_page_table
sharing process or worse
...
ptl = huge_pte_lock(ptep)
get/update pte
set_pte_at(pte, ptep)

If the above race happens, we can update the pte of another process.

Catch this situation by doing another huge_pte_offset/page table
walk after obtaining the page table lock and compare pointers.  If
the pointers are different, then we know a race happened and we can
bail and cleanup.

In fault code, make sure to check for this race AFTER checking for
faults beyond i_size so page cache can be cleaned up properly.

Do note that even this is not perfect.  The page table lock is in the
page struct of the pmd page.  We need the pmd pointer (ptep) to get the
page table lock.  As shown above, we can not even be certain ptep is
still valid when getting/locking the page table.  The other option is
to always use 'mm->page_table_lock' for hugetlb page table.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 mm/hugetlb.c | 33 ++++++++++++++++++++++++++++-----
 1 file changed, 28 insertions(+), 5 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index b8f994961a68..e5196f0fa09c 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4695,6 +4695,7 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 			    struct vm_area_struct *vma)
 {
 	pte_t *src_pte, *dst_pte, entry, dst_entry;
+	pte_t *src_pte2;
 	struct page *ptepage;
 	unsigned long addr;
 	bool cow = is_cow_mapping(vma->vm_flags);
@@ -4741,7 +4742,15 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 		entry = huge_ptep_get(src_pte);
 		dst_entry = huge_ptep_get(dst_pte);
 again:
-		if (huge_pte_none(entry) || !huge_pte_none(dst_entry)) {
+
+		src_pte2 = huge_pte_offset(src, addr, sz);
+		if (unlikely(src_pte2 != src_pte)) {
+			/*
+			 * Another thread could have unshared src_pte.
+			 * Just skip.
+			 */
+			;
+		} else if (huge_pte_none(entry) || !huge_pte_none(dst_entry)) {
 			/*
 			 * Skip if src entry none.  Also, skip in the
 			 * unlikely case dst entry !none as this implies
@@ -5363,6 +5372,7 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 	bool new_page, new_pagecache_page = false;
 	bool beyond_i_size = false;
 	bool reserve_alloc = false;
+	pte_t *ptep2;
 
 	/*
 	 * Currently, we are forced to kill the process in the event the
@@ -5410,8 +5420,10 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 			 * sure there really is no pte entry.
 			 */
 			ptl = huge_pte_lock(h, mm, ptep);
+			/* ptep2 checks for racing unshare page tables */
+			ptep2 = huge_pte_offset(mm, haddr, huge_page_size(h));
 			ret = 0;
-			if (huge_pte_none(huge_ptep_get(ptep)))
+			if (ptep2 == ptep && huge_pte_none(huge_ptep_get(ptep)))
 				ret = vmf_error(PTR_ERR(page));
 			spin_unlock(ptl);
 			goto out;
@@ -5484,6 +5496,11 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 		goto backout;
 	}
 
+	/* Check for racing unshare page tables */
+	ptep2 = huge_pte_offset(mm, haddr, huge_page_size(h));
+	if (ptep2 != ptep)
+		goto backout;
+
 	ret = 0;
 	if (!huge_pte_none(huge_ptep_get(ptep)))
 		goto backout;
@@ -5561,7 +5578,7 @@ u32 hugetlb_fault_mutex_hash(struct address_space *mapping, pgoff_t idx)
 vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 			unsigned long address, unsigned int flags)
 {
-	pte_t *ptep, entry;
+	pte_t *ptep, *ptep2, entry;
 	spinlock_t *ptl;
 	vm_fault_t ret;
 	u32 hash;
@@ -5640,8 +5657,8 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 
 	ptl = huge_pte_lock(h, mm, ptep);
 
-	/* Check for a racing update before calling hugetlb_cow */
-	if (unlikely(!pte_same(entry, huge_ptep_get(ptep))))
+	/* Check for a racing update or unshare before calling hugetlb_cow */
+	if (unlikely(ptep2 != ptep || !pte_same(entry, huge_ptep_get(ptep))))
 		goto out_ptl;
 
 	/*
@@ -5720,6 +5737,7 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 	struct page *page;
 	int writable;
 	bool page_in_pagecache = false;
+	pte_t *ptep2;
 
 	if (is_continue) {
 		ret = -EFAULT;
@@ -5834,6 +5852,11 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 		goto out_release_unlock;
 	}
 
+	/* Check for racing unshare page tables */
+	ptep2 = huge_pte_offset(dst_mm, dst_addr, huge_page_size(h));
+	if (unlikely(ptep2 != dst_pte))
+		goto out_release_unlock;
+
 	ret = -EEXIST;
 	if (!huge_pte_none(huge_ptep_get(dst_pte)))
 		goto out_release_unlock;
-- 
2.35.1

