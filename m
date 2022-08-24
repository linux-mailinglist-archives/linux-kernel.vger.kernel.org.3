Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A5945A00EB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 20:00:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240448AbiHXR7R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 13:59:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240388AbiHXR6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 13:58:54 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3689B7C305
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 10:58:49 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27OHkFOH019876;
        Wed, 24 Aug 2022 17:58:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=3E9Q+FnEp5d1pm/OmIFD4QRcfBrQQhhBz51RIJ0xty4=;
 b=MUQujRCmVzUDFm4HNgHw3Stx6RoeZQKwBS82xe5ggBXUvZ0DZ6HhCDMHYy2IRTxGcvkL
 WYKQ8GYgW+jHhkfDoEcZbIgi9CFfw8pjyfFFN3H/U2xfCpkVcTxBOWR0fCu9tcvL/Xaa
 aj4lCs01lsPNiTSSVhtnkNq5dfknp3V07sNBRMBq/W0crs1wuesTtY/7MAih+iEUxLEg
 YRVq9cMa1s9ziMhYzK8UBwXxs4mrVUhBlBqlZuxyByY4yCcFvIChIG1wusNosldOuMBf
 oryavEYrdC7RvwdJUYIUXSZ+ZiYxKZ5HBEnASMWBTGLXTdY1xm+lCOB9ZycT3jAH341T cw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j4w23vbux-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Aug 2022 17:58:16 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27OHCX1a008968;
        Wed, 24 Aug 2022 17:58:15 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3j5n6nbqbn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Aug 2022 17:58:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y2d6nDDVsmOqqe1yRH7y1y1HrR3V621yzDsopUpsKVKRyeBMe8D0OqdFqDa2CMGY4ZhO0Mj+Wj6m3b4quZXTP1Ps7XBnquBOhlVUrKomgDLEpaevQzjhj7vuxhKxP/CgW6xD3/JT0Qxx9itAkdYvPWe4AD8z9oAIirBBP3Oo045QRRCK/mw7Qt1oOo+RXSBZ+9gQ466TpN7ny6aDj8PY6MHfZo/7g8UEG6iSEjPPAv4TpE2stjh/3OCSczRImmyyIsO44lnJvSKPL57z3NKfv4L+u+dYMIjh/9GuS26pK1KfXwuPLrZlwc/+YJZEKiTYjbw2fmD1qtxrJheVXkIDFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3E9Q+FnEp5d1pm/OmIFD4QRcfBrQQhhBz51RIJ0xty4=;
 b=QqSQcBZxMGiTObC2bKkbMuerNOnJs9qNgd5VZxm6+4TPw4EYo92nYNCcaNqi/fTYl6hCQ+R3ZFpMJTm/1MCjNDYfxSX2bPr5EqfNXmAd+NpyK9xssV/c3l7JaocefX+VGR++IJvmAts1kmUAPGUw+PyxZGhLY2MAYBsSMqTNYNNZ0f74lzSp8qJsOnn1OIEv3XALqA6duydwuxIwbtmgMXOxFpgupFkdRU90zpOuCk67jeiNpcoel49zwsND8LHStDnLJXIEpQ6Kqu0j1cJGhlLbr2WPdfnBaf/S/x+L21Zy/7iqRyDGkpo75AhFQbDvui3wN93gc4EMPpTbC3qEMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3E9Q+FnEp5d1pm/OmIFD4QRcfBrQQhhBz51RIJ0xty4=;
 b=gMzQ3qTEzS5NhaAHprh1NYnOLvSjtBXieOf+6nkmqZo97EYws9ilTou5jS6UnmYYTDv631FmpM8zdrhZkOf+IwCLA/ZfFhrNG4U2tfM2/BpjO/XKPOdGlRee8qWloYPB6VkuWuDElXrQtS3fQLr0jVqRE5QBGVWYEzmrWubWmLo=
Received: from DM6PR10MB4201.namprd10.prod.outlook.com (2603:10b6:5:216::10)
 by PH0PR10MB4520.namprd10.prod.outlook.com (2603:10b6:510:43::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.19; Wed, 24 Aug
 2022 17:58:13 +0000
Received: from DM6PR10MB4201.namprd10.prod.outlook.com
 ([fe80::11b6:7a8a:1432:bec]) by DM6PR10MB4201.namprd10.prod.outlook.com
 ([fe80::11b6:7a8a:1432:bec%6]) with mapi id 15.20.5546.022; Wed, 24 Aug 2022
 17:58:13 +0000
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
Subject: [PATCH 3/8] hugetlb: rename remove_huge_page to hugetlb_delete_from_page_cache
Date:   Wed, 24 Aug 2022 10:57:52 -0700
Message-Id: <20220824175757.20590-4-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220824175757.20590-1-mike.kravetz@oracle.com>
References: <20220824175757.20590-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0226.namprd03.prod.outlook.com
 (2603:10b6:303:b9::21) To DM6PR10MB4201.namprd10.prod.outlook.com
 (2603:10b6:5:216::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8395f486-276b-4294-d321-08da85fa36a8
X-MS-TrafficTypeDiagnostic: PH0PR10MB4520:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yBYpRofnoswpxOGiJ/0KswKblymS5d1yMog6Wuo0ae3/Hhwah/je4k59h6CReWJiT+/AuiSJhObZCaAQaGv+Gb0jjEa/1yEmDWNm6KZWXCbs78JYKz6vWRbm/LxfsXWpPzTDR5axpW4/6KJ6RVl8DXkZUude1nrOc+jyNtEusEc4RiV7BIgNcC+tmYj2wZ3PZPQDNXhxfBKCCH+MRRJPF96W21FrTpCn6fv2tONNz4yWebIMR+li4b+W56UrnVi+TghkhuU/3zMvoWUYJg1T6ISlVkJuXP3BaI0zzlPEXaOWgE7ntgn8nC6AwG6z0DUNi8Ix238RFyWd8FfCGm+ZNCVXqB3JU57OjvbpPGP9pqu67A0IptPv27t6VBFqdN1MfPf9QwodnD8RdSgMJQuxAP0+dD3iMXhhlvYdPG4T4aV0JrIcMjgKUJhvvqAotzMsCQ7P7T55l4rjjY3Tz/aZKxDNyN8tOCxWwB6h4rAWzeQ/KIfLT6ZqzQHwX2n82hMmqK/klCB2SRMItv0HNcLI9VyednmENRooaT3AH4IQArJ4axKBVBayYZeK6OHlqfyeKOx9J1KyA3kGCLCNLHNnlgxXAYecWuv+Gq17cDpH2oncz/uFcQh0uGeSAbzNb4u7vKznVIgOZHnSeD6WzUretwT93REHkaa16TINKVh0PukDifxHNQXSIItN7MwM2PEJzvB5PpRSxM0krGyx/PTjvi+kzLVPBORRCM0JvIyrkJxEEHKYYm4irOfneBmSJizW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4201.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(396003)(136003)(376002)(346002)(366004)(7416002)(1076003)(6512007)(6666004)(8936002)(26005)(186003)(107886003)(2616005)(6506007)(44832011)(86362001)(36756003)(41300700001)(316002)(5660300002)(54906003)(478600001)(66556008)(8676002)(4326008)(6486002)(83380400001)(38100700002)(66946007)(2906002)(66476007)(14583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9VRwgO6jAwnUtzLD7AG/bu8IohRIbHDqw0aPTkvluxAM74621NBKVmF4ETs8?=
 =?us-ascii?Q?7XJoy5C9Q/RuLlQcQLWRjDenBL65laOxN0TnsVAOGLWr+mfWZgXl3aCzISdu?=
 =?us-ascii?Q?fYRJF5H0vPUcqmGJumWy1lFdxK6EfMcWxO0Vcr/pFEa5q9vMCjjeTDVEnD6D?=
 =?us-ascii?Q?Fqewye2znbEzkepS6J7wx4SQ+OEdoiEZCGfRZ7Oy2TJR0raQZdveYbGJxfT/?=
 =?us-ascii?Q?SvdPJ6BtJIDVMCNwNk7AoyiZ9H5OaMlDFdoR5HXuzCwyPcpUYjExhS3tNvNQ?=
 =?us-ascii?Q?1hFsFnqYEnsyhXznuzi4ZAVx8Wq4IKOfbOCKt9umsdUdjNS86SXmG52kh2Fv?=
 =?us-ascii?Q?Kw6mH9CgPj0lMMWdbomqfO9w8Lvrj/Vgh+kjY6msPs3wiYYSzcK9Zb35ZI2W?=
 =?us-ascii?Q?M/tbt/8x5PAOGcJlIAWEuz/YyjhhOFwqCkPUnvl/CYKNL7r3JNAGxkzmkoNi?=
 =?us-ascii?Q?KP4pHWFmQJp+AR4eZQ1c3yJG1E159wD79AA8OSxPoC4v1Axg3Siu8JeaJ8Yo?=
 =?us-ascii?Q?zR2v5dqXgKX9mqfnQY6pEjEcdXt3IXsCA420eqBjnv+eACXiVH9ZIJ+gFeVf?=
 =?us-ascii?Q?rcZbfTpTrKbImCjXu3VzIl5SYaYQwj2nJnqJoyHJy/2gsyMSxOGl9axuh9mR?=
 =?us-ascii?Q?IIpyapKy3m2AtSBC1otDcXBlR0C0YJOGTcR4UZ+AFMVRumc8JkLX36Xnfkwn?=
 =?us-ascii?Q?L/KEby/G280GSMGLRUA572VTxx7TcRxsCt03YB+qMJl2xZxGcwIMtsxbohXL?=
 =?us-ascii?Q?0n4EAuACSNR0Xd3rct4/u0udEqvNDDpqSUxBnpVABtfXgANLwS9srW2TkLXM?=
 =?us-ascii?Q?ytKJZCBrjHqKNAV4TF92I+1ZgsxhAPk05PEaYYr7QdPSU2mE0lyUv99kdcvO?=
 =?us-ascii?Q?8c1IAKThRBNAVS8RHVO1HHlVw8wA7+5q+CRAPNONyfC6JD/bM/OKj8FRKBG2?=
 =?us-ascii?Q?dRSn4fcCEgSxfMMcdMnkVQng2X87pIz/NXKlpvjoYU4GJt4rv2iys07ODNPl?=
 =?us-ascii?Q?b5devfH9JrPMhjl75hwxFR+n+5dSwndHnXYk/LP+oKZ34oUHP1Mj2mKYXYRv?=
 =?us-ascii?Q?ivQYI84VpE+m4dwrijqpkxhT03xpnWBC8yPhK6FdOec/yX9FjFmH2WuCmjRP?=
 =?us-ascii?Q?D8Iuvu7zYtqv2vW2HRLiqdajHTgJLg1j2we817xVpEyiZx2w9XdO8bxtTK/z?=
 =?us-ascii?Q?BgTvf4csJ+mskX8Ph2LwA2+H0HKN5Xj+wL8H78lRixV6jVq/n33hbLMklqcs?=
 =?us-ascii?Q?+c3Hmzffj4nGNfeaXcjJvR6fn8sCRRJdCIED+fRA06K4OHP6LsF4/mXVXIQP?=
 =?us-ascii?Q?L2Lk72ORMx/C3gAosIVhseCDaD0GipGwtWGrIzdL4Mx0gNxUXEckikO4NJn1?=
 =?us-ascii?Q?EyTD8RIQ8J5s0SfvVYDCys0xO9LAI+yXt7F77BKIc6xU85biSSYf5rpDw/td?=
 =?us-ascii?Q?HQAl6uhl1c+kQ40BqwRwTufP0Xknebxi0b9meABv1+5EhiUm4j4cw2moDru7?=
 =?us-ascii?Q?pGexXgDfISx990baKNLRucSJUgwXIEv92RJU00MI9msmy9jeQy5EhciJ3OtK?=
 =?us-ascii?Q?sd38lIYDIV4VK+CYgnhiqXdJyH1R5aWyerfywbj5N8mnv8EBIK2O3Ou6X2xw?=
 =?us-ascii?Q?Dw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8395f486-276b-4294-d321-08da85fa36a8
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4201.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2022 17:58:13.2791
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wqSq6vaFzGtAfGF9d2f1fE5esREjys3nO8FoPb52h4rVQbOBE9IC+uhbXQTC55prSNxqQEvj3rXgYLs2DZocGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4520
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-24_11,2022-08-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 spamscore=0
 bulkscore=0 adultscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208240066
X-Proofpoint-ORIG-GUID: 6r7In_beGn3aI3qpcm5jGYeqCOOe8vU8
X-Proofpoint-GUID: 6r7In_beGn3aI3qpcm5jGYeqCOOe8vU8
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove_huge_page removes a hugetlb page from the page cache.  Change
to hugetlb_delete_from_page_cache as it is a more descriptive name.
huge_add_to_page_cache is global in scope, but only deals with hugetlb
pages.  For consistency and clarity, rename to hugetlb_add_to_page_cache.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 fs/hugetlbfs/inode.c    | 21 ++++++++++-----------
 include/linux/hugetlb.h |  2 +-
 mm/hugetlb.c            |  8 ++++----
 3 files changed, 15 insertions(+), 16 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index dfb735a91bbb..d98c6edbd1a4 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -364,7 +364,7 @@ static int hugetlbfs_write_end(struct file *file, struct address_space *mapping,
 	return -EINVAL;
 }
 
-static void remove_huge_page(struct page *page)
+static void hugetlb_delete_from_page_cache(struct page *page)
 {
 	ClearPageDirty(page);
 	ClearPageUptodate(page);
@@ -478,15 +478,14 @@ static void remove_inode_hugepages(struct inode *inode, loff_t lstart,
 			folio_lock(folio);
 			/*
 			 * We must free the huge page and remove from page
-			 * cache (remove_huge_page) BEFORE removing the
-			 * region/reserve map (hugetlb_unreserve_pages).  In
-			 * rare out of memory conditions, removal of the
-			 * region/reserve map could fail. Correspondingly,
-			 * the subpool and global reserve usage count can need
-			 * to be adjusted.
+			 * cache BEFORE removing the * region/reserve map
+			 * (hugetlb_unreserve_pages).  In rare out of memory
+			 * conditions, removal of the region/reserve map could
+			 * fail. Correspondingly, the subpool and global
+			 * reserve usage count can need to be adjusted.
 			 */
 			VM_BUG_ON(HPageRestoreReserve(&folio->page));
-			remove_huge_page(&folio->page);
+			hugetlb_delete_from_page_cache(&folio->page);
 			freed++;
 			if (!truncate_op) {
 				if (unlikely(hugetlb_unreserve_pages(inode,
@@ -723,7 +722,7 @@ static long hugetlbfs_fallocate(struct file *file, int mode, loff_t offset,
 		}
 		clear_huge_page(page, addr, pages_per_huge_page(h));
 		__SetPageUptodate(page);
-		error = huge_add_to_page_cache(page, mapping, index);
+		error = hugetlb_add_to_page_cache(page, mapping, index);
 		if (unlikely(error)) {
 			restore_reserve_on_error(h, &pseudo_vma, addr, page);
 			put_page(page);
@@ -735,7 +734,7 @@ static long hugetlbfs_fallocate(struct file *file, int mode, loff_t offset,
 
 		SetHPageMigratable(page);
 		/*
-		 * unlock_page because locked by huge_add_to_page_cache()
+		 * unlock_page because locked by hugetlb_add_to_page_cache()
 		 * put_page() due to reference from alloc_huge_page()
 		 */
 		unlock_page(page);
@@ -980,7 +979,7 @@ static int hugetlbfs_error_remove_page(struct address_space *mapping,
 	struct inode *inode = mapping->host;
 	pgoff_t index = page->index;
 
-	remove_huge_page(page);
+	hugetlb_delete_from_page_cache(page);
 	if (unlikely(hugetlb_unreserve_pages(inode, index, index + 1, 1)))
 		hugetlb_fix_reserve_counts(inode);
 
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 3ec981a0d8b3..acace1a25226 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -665,7 +665,7 @@ struct page *alloc_huge_page_nodemask(struct hstate *h, int preferred_nid,
 				nodemask_t *nmask, gfp_t gfp_mask);
 struct page *alloc_huge_page_vma(struct hstate *h, struct vm_area_struct *vma,
 				unsigned long address);
-int huge_add_to_page_cache(struct page *page, struct address_space *mapping,
+int hugetlb_add_to_page_cache(struct page *page, struct address_space *mapping,
 			pgoff_t idx);
 void restore_reserve_on_error(struct hstate *h, struct vm_area_struct *vma,
 				unsigned long address, struct page *page);
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 95c6f9a5bbf0..11c02513588c 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5445,7 +5445,7 @@ static bool hugetlbfs_pagecache_present(struct hstate *h,
 	return page != NULL;
 }
 
-int huge_add_to_page_cache(struct page *page, struct address_space *mapping,
+int hugetlb_add_to_page_cache(struct page *page, struct address_space *mapping,
 			   pgoff_t idx)
 {
 	struct folio *folio = page_folio(page);
@@ -5586,7 +5586,7 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 		new_page = true;
 
 		if (vma->vm_flags & VM_MAYSHARE) {
-			int err = huge_add_to_page_cache(page, mapping, idx);
+			int err = hugetlb_add_to_page_cache(page, mapping, idx);
 			if (err) {
 				restore_reserve_on_error(h, vma, haddr, page);
 				put_page(page);
@@ -5993,11 +5993,11 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 
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
2.37.1

