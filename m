Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B1C94F6CD8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 23:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234379AbiDFVgA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 17:36:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233361AbiDFVe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 17:34:28 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0F5B16BCED
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 13:49:02 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 236I6kqQ006378;
        Wed, 6 Apr 2022 20:48:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=iHXQx76nOltcSEbcuNujPBA+R8M14NFeVFqYrZtPfqA=;
 b=FP+52k1L9RWzhNIm2sd1PGC4Z9T/9E/WzBGr/2UDnaesurWwkOhmzGSi2M3an9fWA0sb
 QPAVYHfcTmon1H/L3n5BZLNthXPaaweGJl/z/GE7bTZsLGWA8UBdkRb/jft6pPLY7Bue
 x2l4mjP9/POCHnq4KRpY3GYhNmI1+HlK4r+vsocKrL8Nkef/iLP8sjnsoJ5fdbf9jmXp
 W80DUKZIThvZ+y3vg4PSYPkdUMrUHBBeCfihPiVB2oWyHNcDH7qJfFBvdsp2cog2w38b
 eerxtsIa+J8nOfOVCHupOvYLjYfc9QR3eXKY5H0jHC3m4EouozjsjfdPA4wHwC0EA417 yA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6d31j6u2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Apr 2022 20:48:46 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 236KkcVx007568;
        Wed, 6 Apr 2022 20:48:46 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3f97y6tera-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Apr 2022 20:48:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S/YBoGaT4/euv0o5MA9mpBnfptUaalzAxFqEuyL8NcKc9FdXXga4U3BKQQa2OqY3nZcrW/O+4Z/CGAWvT10i7BPQO6PXYMjsF1UW4zQ4lFJJu6N9TSZC9iDKtQco0f+6Xat2EIHr0y2FnbeQ5R+SyJ6/VjFdjl+GKcDu0AG6q2GQF0+E4JWoMYsXxfv+iyaXY9Tt4xx4QT4SYCMeDJWyjNhs4smTgIWYCvJZsFCyhpCvI0/lqBCgqP+nTL7Q0yYO6uk41uu6h32ling38oi5eV4KBzQRi+zH33/h2cun0EtsXtQG5ZU2DnfXeFUKLAzT4MHwlRnbMey7XfBCoekcXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iHXQx76nOltcSEbcuNujPBA+R8M14NFeVFqYrZtPfqA=;
 b=TI/aGD/G+YnwDrrKaJ4+aDkWOwSPhVcZUqmuhOfB22ZygUuII3Olp8sJ/LNP/O1H3BKP0yDmv1rBOmRkbqudihnwxrpmXzSmbL21HcbvHPhz0X1qAYdSqv4AwndjWYIp9Au3L5OA6+R1AKuOchv7H237Z+n0FkvHFO15z/a+IkBUt25eGyNWpzype1SRTj+0Rwsn/bmh2hU3nRIHIKQkW0mIW+2JKOlmqUv/k1YJ1Pb4n2THxG97x7LL8vzLSr2Le0TRYDycquy6EDbFfApY1DuPGsEPdJTTk4F+78U7nl4quYRIbStqEqOnuWFsQMTzv3UgXrN4RvAPI6npR4HaVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iHXQx76nOltcSEbcuNujPBA+R8M14NFeVFqYrZtPfqA=;
 b=lpTDUrKAM/gW69m+B8GzsLrSY5/pKXKRfXifWKIO1i8+MJSpBFWjBjLYEKZieQPqpOmDQuSJmMx24ATsrGXKrBR3d6tZIyTrsB2suY/9HYnyUHbp8xPTcZ34EwFzDHcqP7uVtThDDAXxO1D9kmrXVF+0v1W3djwMwXKW8bJ5gYE=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by CY4PR10MB1909.namprd10.prod.outlook.com (2603:10b6:903:11f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Wed, 6 Apr
 2022 20:48:44 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::245f:e3b1:35fd:43c5]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::245f:e3b1:35fd:43c5%8]) with mapi id 15.20.5144.019; Wed, 6 Apr 2022
 20:48:44 +0000
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
Subject: [RFC PATCH 4/5] hugetlbfs: catch and handle truncate racing with page faults
Date:   Wed,  6 Apr 2022 13:48:22 -0700
Message-Id: <20220406204823.46548-5-mike.kravetz@oracle.com>
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
X-MS-Office365-Filtering-Correlation-Id: 61a96100-507d-4952-cbf3-08da180ed6d1
X-MS-TrafficTypeDiagnostic: CY4PR10MB1909:EE_
X-Microsoft-Antispam-PRVS: <CY4PR10MB19093D22C555F68302143004E2E79@CY4PR10MB1909.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ow2hMhYoRedYKahwckKqxSOI1YTsxlO1qagTMpMKaX/eW0CIIAUUxzYjMlFcJfDzZsz7UR0/4+QahQ7tI51JU/H8pYOIXKA1G/gZcs5wTZlDxPOrjW/4cE/q7FsJambsTA53EfZGo02g3b4U21wkX6TAZ55zlkE6NcqmqziWnc2XQgi2BJeQAIHARi4q+Z5sfxEU7hTP6FQr7qJ3ntbC18SrX3gRDzYvjTFoaFfgaMIfUBwGFLriC19SyycG9g9mJTRjLgOYcSjjuk0IGnhXkDoxJItaLwDW7a/SpWwqg8jQL53qjT5fiVY6ERUFwEySGaoh879NYXe2DRNxROfH0aptkJLVPE5syoPM57X3r1GkDtxrmjkWb2aSFEJvKfUQiaFFsqSUJPy6P89xkZt1GpddivpyYQZRdwt7EsTgKkGDhEs3LRAXdrZtM6PCGTZy92VWV3INdhqY+Way6iLXeiVI0gZoghaFrY1SBJstSBU9pFnprt58DsOw9pCBvXKDUhUGxBuz9OGs6svdxAoipmF9uOtPHHvNngPEzP5LZZY+Moy09tZNADALO0gir9e4dKyo/oYWAOlw36eC+mjhOzsaFUv72jcxNK8EUxKMw7iP7+mHuNGPeH7cy7ltbibm0xJ505KGKA6TGotWX/5maPbguO+Cm4AWDpkF7vvaIgemo/CU0/q/NmNXo+RDDWqTjgRKm+HZkWhYLekl+FXGQg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38100700002)(54906003)(2906002)(26005)(6512007)(52116002)(66476007)(66946007)(4326008)(66556008)(83380400001)(316002)(186003)(6666004)(8676002)(38350700002)(8936002)(86362001)(508600001)(1076003)(6506007)(7416002)(44832011)(36756003)(6486002)(5660300002)(107886003)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KdGXH4++lCgEcTBLLIAEIFECuNqLsF+WG8O0g/ftvnDOAcw6Cz6NU/RTAT4B?=
 =?us-ascii?Q?iPTKCNThEf+w3pyS+R9QbUjm3cpAHTRWmKP7t2zRDB8rihSJAGd154SZnpu6?=
 =?us-ascii?Q?GIqHkke6OaorFhvM4gnodTF80/vxblTguX751HdWWLF/fbxBxK0ZTh2rvE4t?=
 =?us-ascii?Q?dtCCbOgD5PRXnjAzjHq03d/BUBTmkUdUdlkyQy4L9PYQ6LfCL8Jf+SdAi3xd?=
 =?us-ascii?Q?E/sFZCnNyZ23DmtnJ8ogpb4qypXiWkhbbR+ToB+ft8X8Ds22+vbLqvePouG1?=
 =?us-ascii?Q?6CB1vU3DnUv2jxaJN1LAyse6/WLbGprMIxlueP16AeSMiq4JrCYe+Q2gz1BP?=
 =?us-ascii?Q?Uaz2xzyP0rqB0M5VmOFFmqgORgYmdrOWY7thh/ODhnf88cXNQ7xLXZrQxPy3?=
 =?us-ascii?Q?JKY4gX6PAiaqq/x5T/kQ7mtL8uXqN8tdlapxtBxfxy8LCGuw26TVMEoYYKTR?=
 =?us-ascii?Q?OECK01dCfh+D4DdmvmRDcFksQ0BcmDoNhEzUN3YcON/ZO3jptExBl7JZXJ0U?=
 =?us-ascii?Q?pcE9AzwylXOu+E8AsOJtLkc5uegviIlDND+zzTiJ2BZO2VDnJ6WRFBXlMjZG?=
 =?us-ascii?Q?JzhDlOaD1zg32jg3rdQVcMIN66xooQwMxuHYHHrY4T7HkbapncW1gsC6I2xa?=
 =?us-ascii?Q?qUuvUx6+D/eUqFmeXsibYSR/UmplJxQDIyLYN5DwrU7H8VRhVwfXlbDzhqC/?=
 =?us-ascii?Q?66mtDA3InFVvX46dcnzjlu61zQDmHbxXWz2ZPIwHETli4TpjRM8rryvTJmFO?=
 =?us-ascii?Q?DSNcj18M67gIZvHOvzae2iGOJ34cMRUP/LVJcpPCXvHVeGh2O92s+SZLlTkF?=
 =?us-ascii?Q?gEfMDDNu1IuEl1vrFeuy1STfZIisiDWpTAGVH/nsl61ab9caWF61tLNv6qph?=
 =?us-ascii?Q?ZwMbilE6LQ/rNS4NXhmQv3KKBAwcPHn6YT0gAVjQP1dDkYPqcYDwD97eej1u?=
 =?us-ascii?Q?l2cy/ujJFu73zh0HhAE8aae+p4W0ICZxWzWi/jUtU+PBMbApAjPjAnn1mnZT?=
 =?us-ascii?Q?U6btWX4GWd/rdGV9Xzwdn/DbzA0UsdHuDtD496H8p2+xoEGI3nwQ66vxt/iy?=
 =?us-ascii?Q?qZG8aDWfJ31OMIpFAvlHLQm3CUtKU46dAoBsGfHZh2LBzpH5qrcxox8Sax1p?=
 =?us-ascii?Q?FxN053H3Vs0RAev3Uw75gERpEloBniZBfqj2C5XfaLlC+VDG+GbPjSOR113v?=
 =?us-ascii?Q?BFr1CAWbzNBM6rwYT6tVqlF3YAKSS3Bv+N5cK7SnC/0ggEopNOL3BRMHzw3K?=
 =?us-ascii?Q?Xx4RLmZ4ijk0FyAWQp1wWrKStjnMffEc2aGXImltfT9uwk/MVlB6jTOQvMQD?=
 =?us-ascii?Q?Y+lKovDk+6zCNoq3y3TBzZIyzvzjSHZOhbKHpxsSTutAPi575dS9L6WQHXIf?=
 =?us-ascii?Q?f50a/yXvXWEvkm6GMWKdLV56frQEGcKr90e9H1AScwy4G4kqP/WYKncONYKl?=
 =?us-ascii?Q?zhU4kEzzUYKTfMEfU4mEX5OjYalDRMIl7NGgNP5l9v4l+a4DlvToLQaHN/A/?=
 =?us-ascii?Q?DPHKi6XXGpr4AhifdGNWuwV07N/hNqfaqq1AA3NLxape4U1hHlolYGlCM4Y4?=
 =?us-ascii?Q?dRmKxjXy+wB3/RyxpyQxKJa51L24wzyEo3DdCW1vMGoG6A9F5XdNyTStpV13?=
 =?us-ascii?Q?GwJDR7R3vhe12KKXfBgu4VseziG+yxbvXpYMmPRiRS2s58qSt30XhVO2RxHZ?=
 =?us-ascii?Q?W4le67YLRofIN8dPEX35rnvYF330u9ZzI9ncQbu9KAhEwUyFCbbMe43IYvma?=
 =?us-ascii?Q?2vkd6qdK/1nWzHhNrFHpyUhLoDL4WNw=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61a96100-507d-4952-cbf3-08da180ed6d1
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2022 20:48:44.0903
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rdlEr64zpASTk9lICXffyTK69IMM53pXrWIn0kbjwFBmVIkVepoxnOy1oevuhd4myDcpPhXOjnZAiUrOJ1rq3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1909
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-06_12:2022-04-06,2022-04-06 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=896 spamscore=0
 suspectscore=0 malwarescore=0 phishscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204060103
X-Proofpoint-GUID: WVqzha9uuDMeBNOtyT4_LWU-1_AApKPd
X-Proofpoint-ORIG-GUID: WVqzha9uuDMeBNOtyT4_LWU-1_AApKPd
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
discovered by a change in page_mapping().

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 fs/hugetlbfs/inode.c | 40 ++++++++++++++++++++++------------------
 mm/hugetlb.c         | 28 ++++++++++++++++++++--------
 2 files changed, 42 insertions(+), 26 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 0cf352555354..341156c2a7d0 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -490,13 +490,8 @@ static void remove_inode_hugepages(struct inode *inode, loff_t lstart,
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
@@ -506,22 +501,31 @@ static void remove_inode_hugepages(struct inode *inode, loff_t lstart,
 
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
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index c6d76f61de98..b8f994961a68 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5361,6 +5361,8 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 	spinlock_t *ptl;
 	unsigned long haddr = address & huge_page_mask(h);
 	bool new_page, new_pagecache_page = false;
+	bool beyond_i_size = false;
+	bool reserve_alloc = false;
 
 	/*
 	 * Currently, we are forced to kill the process in the event the
@@ -5417,6 +5419,8 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 		clear_huge_page(page, address, pages_per_huge_page(h));
 		__SetPageUptodate(page);
 		new_page = true;
+		if (HPageRestoreReserve(page))
+			reserve_alloc = true;
 
 		if (vma->vm_flags & VM_MAYSHARE) {
 			int err = hugetlb_add_to_page_cache(page, mapping, idx);
@@ -5475,8 +5479,10 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 
 	ptl = huge_pte_lock(h, mm, ptep);
 	size = i_size_read(mapping->host) >> huge_page_shift(h);
-	if (idx >= size)
+	if (idx >= size) {
+		beyond_i_size = true;
 		goto backout;
+	}
 
 	ret = 0;
 	if (!huge_pte_none(huge_ptep_get(ptep)))
@@ -5514,10 +5520,16 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 backout:
 	spin_unlock(ptl);
 backout_unlocked:
+	if (new_pagecache_page && beyond_i_size)
+		hugetlb_delete_from_page_cache(page);
 	unlock_page(page);
 	/* restore reserve for newly allocated pages not in page cache */
-	if (new_page && !new_pagecache_page)
-		restore_reserve_on_error(h, vma, haddr, page);
+	if (!new_pagecache_page) {
+		if (reserve_alloc)
+			SetHPageRestoreReserve(page);
+		if (new_page)
+			restore_reserve_on_error(h, vma, haddr, page);
+	}
 	put_page(page);
 	goto out;
 }
@@ -5812,15 +5824,15 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
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
 	if (!huge_pte_none(huge_ptep_get(dst_pte)))
-- 
2.35.1

