Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D20CA5B26F4
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 21:38:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbiIHTig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 15:38:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231339AbiIHTi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 15:38:29 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2520B1079CE
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 12:38:28 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 288HJKOO011851;
        Thu, 8 Sep 2022 19:38:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=2ZwJE9Txg9PnDua1OpfpI2XWocK+C9Mzt8dlocRPfIc=;
 b=RSvEunFIjqUOEAOJorf0S9G44xY2OBua3Djh2qmnScOAqr3AzwFAlZ/LGM3+SxdnFlTA
 4XJDBrH7ygJhiNXU3Gptba2QOWYOOy5gYmat7dsvO9Q9Ee7QB0fPKGKgpxI5oqEqGjKM
 WUkkMHMrd6mN2L0KTZjhODahYxDdUYu6AJH9RDMmCZjkXFFeHTLtJnmrJ1CmKHWXGA8a
 Tc22Rq0m9ZqlWZBxn80LMizq7TVTrfL2DIU2D8z1y2VwaF3ryxmWXaddYrZgXgHC1Dcu
 OvpINlmsgypGab0ceqRgFGA4OlUa2OLjKrfaP11n910/7w8anLUfM9L3xKgOnul+hHuc MQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jbwq2mw4v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Sep 2022 19:38:16 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 288IN4jb006861;
        Thu, 8 Sep 2022 19:38:15 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jbwc6esb1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Sep 2022 19:38:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MolTK7cK1b/t/8FizHM+qXG43OOf2e8tQ2u5cf4H2Dc7Z2QJ9tFgVXzvQNHTOThbEZiBY0xE/dELqqfsyvQ3QAAoblUgc9IQZtGp/4QIbze5KxdKzrfPbQpVFGiEi4P7HcHxtMYIOC60hwer70VAsKzbBHtvFtwpkibQjrtweBU8MOq2le5x3B6tJnKAVoQK6A4nbhNSY1txnLTEy3e3QlgNblPAXvEo08gY+phkySVEh8hHl53mXpcY5lIMRbnH4wM4+I4FL99s/7NJMwywnQAoWv0EiF+i8kp9UtIrWynzbwB8IciVvIq6aoEzGCWL1wPZiVTs6HEa0//z7vRH0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2ZwJE9Txg9PnDua1OpfpI2XWocK+C9Mzt8dlocRPfIc=;
 b=Igvqa++ARQN+P6agIO6Vmi3fsl0+Rj6wlKnj2vnmF58J1RSgnQmLOZxkwXavVh4J0qhvrvLVbX6zarykB46BXSKbQhGM7AbLaTeGa/OVTsHUe2RighJXYRT93o0DzQZiYnQGuGA0ui5A39fFAbFr9rnYZ+5WcgyPP33EizjtniTmI85Ths/6h5tF21OGFGf//2PrLNpyVjDcb4CHNYyhgP4S+JraS8W8bh8+3RhB0Y268dGgyxKzYfPvv6mKqnF58tioSlR4nhgWCeiWv2KNtApB+jBOljdeophWHCMMouu1CsRYJLV3/WWrIr9B3q7fdElSgbVb6uFIy2ssK4GYXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ZwJE9Txg9PnDua1OpfpI2XWocK+C9Mzt8dlocRPfIc=;
 b=lOybOjQ1fn2sD8L148J/bpSHdSD+zmWE3umZEg1590jfJiFNr0XrJfWhIwASkyCrI7lBXuHCuwxhc0h7ZV3jFfbhKdQS2351d/lkPnkOXIjgcxO7fkFkYfBNxHlA+rhNIs90R/Gb2NY/ln1qyxerOEXOFIp8JnDtCx72mToYGU4=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by DM6PR10MB4249.namprd10.prod.outlook.com (2603:10b6:5:221::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.18; Thu, 8 Sep
 2022 19:38:13 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::ec55:981e:3693:b37]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::ec55:981e:3693:b37%4]) with mapi id 15.20.5612.016; Thu, 8 Sep 2022
 19:38:13 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, willy@infradead.org, vbabka@suse.cz,
        william.kucharski@oracle.com, dhowells@redhat.com,
        peterx@redhat.com, arnd@arndb.de, ccross@google.com,
        hughd@google.com, ebiederm@xmission.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH v3 5/6] hugetlbfs: convert hugetlb_delete_from_page_cache() to use folios
Date:   Thu,  8 Sep 2022 12:37:05 -0700
Message-Id: <20220908193706.1716548-6-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220908193706.1716548-1-sidhartha.kumar@oracle.com>
References: <20220908193706.1716548-1-sidhartha.kumar@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0107.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::22) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|DM6PR10MB4249:EE_
X-MS-Office365-Filtering-Correlation-Id: 458498ce-b85a-4f44-eeb6-08da91d1ab33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pSWE5lVHBFMPcW+gOv0AE71QnZECc9aTVGiuI+ICBt8HJ3jR0mOVuYn1xrzvMS7ktEOoSzSUheJlcQb5Q8H0IZe7SLvARmc6EiRttzLZrCxUysZum4RIFeTpT/+Qg/eERQTkGSCLWtfUsPKFcz/9oh+WnwIMJY49kw+mPIjVdEiYFDwGK5S6rybCL5c+hnFKw+SgAyqvSqrlXTy5bYjq2BJwmD/jN3fqFhYsFI9WyAMMW0IBlTNTfRy5oviFFz8fgVZ2aQNP66qKaR0pRjn2rqgpWdkuRZ1qgRXfpg/6EFXHVM60GYB7Dk7IAZdhmb2/jgWgo4ZA2rqULpsWP630J8RloFcoudf2R+G0Ry1sYB8SdaQvpL0exse5r+19dELSJabV3LczE75/Bos9Zxe6u6Xcdx8PqBpVeVb2j8H4wQFfMOVghPNVHzTNcbomqhjjdFX23zpQazymxDN4AmXrVFgBCtlOHono6vUP43LmkofNz6JtLQFTuo2A5txM7sKayJWQK8UYBOa9RJIgPmI/INCxTUnUYsJniGVOR9tQ21zIERafgFpjs74WvP+71O+kx+DvYPIe7wyBlmwo7w8QqQhlxC3982FzTlo/wzNEoiVJuK4qVTom/kbpxqpILK9fErTAFgqZMAbu8dCDWPfKTq1751PVuLdnDqeEN4ReY0cTe6FUWFequPaCJWJzG8+5Q/d2fyEJNpFPPwxqisS/KQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(376002)(346002)(366004)(39860400002)(396003)(6512007)(6666004)(6506007)(26005)(107886003)(41300700001)(6486002)(5660300002)(316002)(66556008)(66476007)(8676002)(66946007)(36756003)(86362001)(8936002)(7416002)(478600001)(2906002)(1076003)(2616005)(83380400001)(4326008)(186003)(44832011)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NZS//tqCVvd6gs1M3TLwXA9E6ZvH45feEHwgeQ6rzxRXX+7mcNbWMj/gYfQN?=
 =?us-ascii?Q?f49nFK5uUwbwoKmVbkJLMmVB/YuspOD1ezxH4Fw5mRCCYQLjspjhai1yvdZ6?=
 =?us-ascii?Q?RoFuG1ZG+lAvZXA3jBG11w1sBVYSUyGPblKqKXd7dAex9WIIUmh+hrCUD2vS?=
 =?us-ascii?Q?kj9nrl265voKiOHIwp080bN3ABCIV2JkRhcZzsO0f0C2fui+cjkheV01YI1P?=
 =?us-ascii?Q?xe6lrETBUZoVYJaYM048plvtnzDhzZvGtKTRv6CtT/Brl1F+mfGIBtbKVAog?=
 =?us-ascii?Q?kZ9+zkEM3AqAvi1jv4x/D1wY0fMgIvpAwl99zvWONq5k8bietuWhvAAvoyfJ?=
 =?us-ascii?Q?1xPeUTQaBjOqcBkc5FaduLBMgeI/w7we+YJHNPY/NQukCxiY4IwaEQUoeZdk?=
 =?us-ascii?Q?FiVjcDZMO5NgjnGnLs5378Da+uwU0Dsct0UBCSLbym1n49MuvAXEYmVXXrw8?=
 =?us-ascii?Q?89lrbUmeG7hHW2o/qAZcuWcZn3bTdGAHTBX2uK1PuyCfkAPTm+4ietpSzfmL?=
 =?us-ascii?Q?qQFxWHh5CdjPjzLnMTNP6aV4Zm+dxLLW12qDJqAopnDxsaYNdRGc3bmWz075?=
 =?us-ascii?Q?C0exNq8Hr4bQKD65YPu2Rv30Qq4O7Vz2Lwp7c+L960WFmWkUCjegJaw4fqVn?=
 =?us-ascii?Q?sjJlKiVeowwhILywYmiEjXulOwZPIOkH1zaACfWx3xuV2EZbpQc9lBbS28CV?=
 =?us-ascii?Q?4HVxeT7LDX6Ue1mfTuUdCd/L1rmww5Lp0KUmPnE4zQ5Otg5EHpE5CTFm/qAz?=
 =?us-ascii?Q?zjPlwwrU/61MceUkzVtE8IwQG+4/Xvcg7fBr4LTA8qifC7wawGjvMWuTodUl?=
 =?us-ascii?Q?0UksQig8KhVflrM14EzGXuCjQdvRt8AMfnKFWtSynMAG0/p47jPQSvD09EKW?=
 =?us-ascii?Q?bb5YPaf6lc6tdd/KyiTsB4wYw0ey/EgkGFAz/nYrM58NlybZyya9j1wCzyFk?=
 =?us-ascii?Q?xa/TdHkVwKLaeF30YZaUeUNpV9x13RrN29Fb0+NnXQnQ2nudYwjIqrYgnHHl?=
 =?us-ascii?Q?aq1l+izIiTZc7r0cs5zeNQEKS/2xHvKoEmFg+Gr3e9A5S2t6QMvOReLAINjq?=
 =?us-ascii?Q?pwLsuNXyDnhYdS0WkZCAEMxMW+DR1pozY8pui3kROu6e5dsFFV3zkd/tIzuG?=
 =?us-ascii?Q?+NfUy6cymKiuM4Un7U4tlZjh0l1rBZm1SKww49UnuAlF82Psg8k4/g8tF/eO?=
 =?us-ascii?Q?5DT49QAeJfSFQTetorMuYdBhDZaODG3GN6vEshOdUCO6tV4+2sd22M6CmSHF?=
 =?us-ascii?Q?+AQEhPlHlhpQCQh4Zql9h95CwAWNqauj/7Yo0zqHxYMIVetWRjtXtdQOQU6A?=
 =?us-ascii?Q?k2DLlZMNqUOiYki7RkQ6dtc18HprL+zPdRr3u1oNcueE+fHkWrSSbuRhMvTF?=
 =?us-ascii?Q?TMFMTGv3ofSkAJPnfUz8CHj3zVHFNTJ+KYzn62M/ByWK7ITJj3jKCXdkN27Y?=
 =?us-ascii?Q?Cyw1pxjqfeVs0Yv9aMjFWgG5nEXJYLL8PY5N7mfU0pBV0APYLGCxW/odufmj?=
 =?us-ascii?Q?llfueJEiqk4wgksmDV/y+w+6cQwZHK655CJbgMAwBC+/vusYpu++nAz6WADh?=
 =?us-ascii?Q?mLPNetUeCcUdlpqcQyBORTV+E4iPgFNhuR23Y4820dhezOVb2+pmyngQPnzH?=
 =?us-ascii?Q?Wg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 458498ce-b85a-4f44-eeb6-08da91d1ab33
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2022 19:38:13.4555
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qorhc0UATATP9RaEf7TCF5R2sVVJs+TsBKXV9wDFJdKi5q0EASlCN1hO00ME0RSeJDhkadiaxs06QPfMrSQyn4u/75POKDtO1vOqd1MD/Ks=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4249
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-08_12,2022-09-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 malwarescore=0
 mlxscore=0 phishscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209080069
X-Proofpoint-GUID: NhwwImztZ-L9EpgPmq6qkUhrhSUpmP1r
X-Proofpoint-ORIG-GUID: NhwwImztZ-L9EpgPmq6qkUhrhSUpmP1r
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removes the last caller of delete_from_page_cache() by converting the
code to its folio equivalent.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 fs/hugetlbfs/inode.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index d9e08c445e2f..38920702765e 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -364,11 +364,11 @@ static int hugetlbfs_write_end(struct file *file, struct address_space *mapping,
 	return -EINVAL;
 }
 
-static void hugetlb_delete_from_page_cache(struct page *page)
+static void hugetlb_delete_from_page_cache(struct folio *folio)
 {
-	ClearPageDirty(page);
-	ClearPageUptodate(page);
-	delete_from_page_cache(page);
+	folio_clear_dirty(folio);
+	folio_clear_uptodate(folio);
+	filemap_remove_folio(folio);
 }
 
 /*
@@ -562,8 +562,8 @@ static bool remove_inode_single_folio(struct hstate *h, struct inode *inode,
 		 * map could fail.  Correspondingly, the subpool and global
 		 * reserve usage count can need to be adjusted.
 		 */
-		VM_BUG_ON(HPageRestoreReserve(&folio->page));
-		hugetlb_delete_from_page_cache(&folio->page);
+		VM_BUG_ON_FOLIO(folio_test_hugetlb_restore_reserve(folio), folio);
+		hugetlb_delete_from_page_cache(folio);
 		ret = true;
 		if (!truncate_op) {
 			if (unlikely(hugetlb_unreserve_pages(inode, index,
@@ -1174,7 +1174,7 @@ static int hugetlbfs_error_remove_page(struct address_space *mapping,
 	struct inode *inode = mapping->host;
 	pgoff_t index = page->index;
 
-	hugetlb_delete_from_page_cache(page);
+	hugetlb_delete_from_page_cache(page_folio(page));
 	if (unlikely(hugetlb_unreserve_pages(inode, index, index + 1, 1)))
 		hugetlb_fix_reserve_counts(inode);
 
-- 
2.31.1

