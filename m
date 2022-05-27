Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56D04536914
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 01:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353333AbiE0W7p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 18:59:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355078AbiE0W73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 18:59:29 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB5EF13327A
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 15:59:28 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24RKmdHX024170;
        Fri, 27 May 2022 22:59:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=Kg2wNYIJEkQndu7x1BiocycJELO1I9KZm0qOzqkH0XU=;
 b=YGXP9G+iS5HfdIaszJDKWKA5MVJuhBji8zD9uzUxOoKG/4YbODGebL6kJWP8u6K7Ae1k
 l5gzIv5LQl4nf+RHGOy+xzSJLbBpKAXPdH/3hEvQIn+UisNTLAjXxhGac+vxvA9+gQ5K
 +pG/jRXRs7+F9SdTaqyGKmYhVkmaDDq1dx9ZnabRrvgIJ/NOWfLBSaQzUOmEKXR4Tyy+
 mK/PWHuvvNcpmP1dr/9MtPgL8PYE8scHFv1IzytOY1/HtTpsJSWFedlCtFbuRyPRBBEG
 16chjfNbl/i13Oga5BJJtLYllileP1uACE+Ie34x2kGV3ahEuEN9fraZHoRIkdAS7sml TA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g93tb0cbp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 May 2022 22:59:08 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24RMpXnH031770;
        Fri, 27 May 2022 22:59:07 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3g93wsts0f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 May 2022 22:59:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cirKwvHnACku+qjS3vCc0KFIxKlFTENSse2El9tDJlOiV5ZuxWemxFppl6bvybaJ6nGmintLgOklFFWA5I+oVm98BgzS1pJaWzTrFWPhpdO2dhFUBp1eGKOm8AKUsMRSPNrot9asjM/0FdZWF0LSze1r0NR8iPDrD1vMFLs+GPzXlb22LpFSa2ztBTOBMugNqLE+VD+/fc3Bys4UuqzmT0dt7O5JiWHSE7bXxmak58wCtD0LD4bpig7YS1MTzIu79cpKnPy8YBBUTeMA8ctzEfqBcwWH0LcqHrsEHV6/v5rExVHix+xA9gZnceMgRdA+oP4Fgf/Dla3Dd7RnFG6WRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kg2wNYIJEkQndu7x1BiocycJELO1I9KZm0qOzqkH0XU=;
 b=bCDm6TJzGNHhL+eWqyvgznbE4Q8Kth9LsBdj6TyMJ0O1VB60dyL82psdMGYAtSzdESv4RnIIfki7m0htcUYsP1nbrFkO5OmTGU699TWe9gkhvP7LFkOGNPYJXNpKX/Szh+WrkZRLQW1fI6rmAaC6RLiNwJ4N5WnPw7j9ikTpDUvG2FdAol4On640WPtU1td1ofoLI8YKuthJ9BGWZ30Nc9CgpG8MYmd0pusyTgLzWHFU9ZvBcMql0xWevFMbYICOszIuqPGlMR2fzjmZYLOCjCAShxX8mFJO+AZNWPANaxhm2O7xQA4Ye/K50Ose6TeBJBvuXeh7jnasCK7jEQ8bwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kg2wNYIJEkQndu7x1BiocycJELO1I9KZm0qOzqkH0XU=;
 b=alfQuvlss2Tj6pUSqac5vXY6fL9B6RvBzIGH+wZ4yIJY8mdeJ9hkaoGPIaSUAJc4LBAV6a5F8225ltOB53gfshsT4s+kcVY+d+GZyXU4x5NJBD36c53CeyF1hJXQ6+CQG7958Yq63ga7W7BlGMiQh3NWTDLmydl/7GkHmEXX5d4=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by CH0PR10MB5068.namprd10.prod.outlook.com (2603:10b6:610:c7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Fri, 27 May
 2022 22:59:04 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::2125:9bb7:bfeb:81f9]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::2125:9bb7:bfeb:81f9%9]) with mapi id 15.20.5293.016; Fri, 27 May 2022
 22:59:04 +0000
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Michal Hocko <mhocko@suse.com>, Peter Xu <peterx@redhat.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        James Houghton <jthoughton@google.com>,
        Mina Almasry <almasrymina@google.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [RFC PATCH 2/3] hugetlb: do not update address in huge_pmd_unshare
Date:   Fri, 27 May 2022 15:58:48 -0700
Message-Id: <20220527225849.284839-3-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220527225849.284839-1-mike.kravetz@oracle.com>
References: <20220527225849.284839-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MWHPR17CA0091.namprd17.prod.outlook.com
 (2603:10b6:300:c2::29) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 673bd517-9cf6-44da-b946-08da40347f64
X-MS-TrafficTypeDiagnostic: CH0PR10MB5068:EE_
X-Microsoft-Antispam-PRVS: <CH0PR10MB5068F143AC465BDA849DC2E8E2D89@CH0PR10MB5068.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2NxYY/Rpe6iyp3IIpw8ixSAdkqos5Ftptyc4uo6WLSfpGW2xix6rz+0m8cgsivx/t3PALnhEYIDccShrDrEYt0hDlCk1WS0xcbYqt4t+9BAqAeqc4I5cLQ9TYzblOZmctAx/VpXbaNy6soJW0/WlCTw7QmdlMgU9zQRQPwMCz9+0jTnAgaD3zDe4WH70PcuJ3Yj/aMMjYCg6zxKWtFrhedNhAOHDLDiXO2aEGSBML7rQNUaxc4kjJp4NyXe5Abp4R5KW2alOsr4wCG+P6KXR6oWn46ZpTKqjNsyJHTFEUQd6fPh/efGlxT1oqdwm5fEUnMPnkzN7e1Y3xsUprEsWLAd4Wy3kJpjmrD+d9ZQ8X8ABRAcJaFvA259NTLhJP2u/JUgfMyS5tvgRwwrQ8io4KNFNJIYkvjNFsnAQdNUkCv9FOK3mqyKyleTdrZ1FKSmrVlURcQwyuDyNKOdrOxb7USHp0tnf9K1W6cNLz0fU79jnt16P/Ow8ckMrCuVu5RR5WfUX7pivhkRTEOWq2Oehp70POMIhBBsSTMw5IJahE7pNlXXyEXc9Hgomzn6UqoHNM2mAAXa6fh3jtWg1oXfC85BK6kwOjAIUEVdlCNY/4e2BLSArkkxm+6Sg6j+AIuZxsi/h6GZjZNaWZIehzQJ0sdUNl8kaeZg0kF6hP6CjzS2tAm90vFeGeLmYJvcHS+koBsVP4wJG8r0m7j6MUWvJb5NTUQDFaj6DrI5FhYzrUoQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6486002)(8676002)(36756003)(107886003)(54906003)(86362001)(4326008)(316002)(66946007)(66556008)(7416002)(52116002)(8936002)(508600001)(44832011)(66476007)(26005)(15650500001)(6506007)(2906002)(83380400001)(6666004)(186003)(2616005)(38350700002)(6512007)(38100700002)(1076003)(5660300002)(14583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vk1bUjEFIz+LdaSqiBOJajAqpl9sb+zg2w0mjtEwmKbVlZ9eI+2vVW0jQXN5?=
 =?us-ascii?Q?0+r2ephpO3AMAFhFl5m39XVjtnK20eoI0bU+JQw96AKrFrrZnAJp7YInuxqO?=
 =?us-ascii?Q?EQZeo8cUIpoFs8Z5YZVBepjHpYqosnsYG7UyutoxJUkJBj/Iwmf2gsLnNF8y?=
 =?us-ascii?Q?RYIr9XY0AuHLSjOwqIJG/aNj0EEYwcEChwH3JNTtjeFldBXa18ogq9v3tMMI?=
 =?us-ascii?Q?3Fl9R7vITSXNU6ixDr3eeh36a5c5mzEnqOtNIbEJBsoqdZj/6uE56dRkKXU0?=
 =?us-ascii?Q?N9H/iUw+KbjJ1cOCLxkOpYJPnRLe054oVN3OvF6qG6xXKerFWQxOAh+lk/ae?=
 =?us-ascii?Q?XumowqhyNqidQxO69J8vI/XROhcp1UsaGlH3bKNulAwImKSfBcwk0MfeySSh?=
 =?us-ascii?Q?N+yEHm+0x4FOhmdir7b6FqEBG3Gn6SV/OV48z6+Y8KDqUkbu0xu3OlQWM3s9?=
 =?us-ascii?Q?klviMoS6nQGjXrO/gcR9KEHnBIK+ChyZ/URDh1Oa8hmCEylAw9nnBctuUVWc?=
 =?us-ascii?Q?8QoQc1hIpuqF8fE+PKQ+HF84pd1byylzky1kjynBZsaEtqazl+6WufY6p3RU?=
 =?us-ascii?Q?fbCewjzm6TLssgI9Mx4/F1gtVPSKQhK/rhpWExV/xeR3XdWW/Javp6nJ3j7s?=
 =?us-ascii?Q?YJaSdBRzx/SqlpbMFCHMet3BuLVthmzN9twfWgC3Icq6BAvcqXPp2vReUchb?=
 =?us-ascii?Q?JX6YPuBKMHOQgUsuE8Up4JIXhoXuzTcVmtxwGj7l/mhkjZCT0rVjMID5chjE?=
 =?us-ascii?Q?9bt1J+WWqVO2J08SzarpXJGs/Ff2tblTEfVyS6d7GwGkr5H7/icSKQrOdbcw?=
 =?us-ascii?Q?lfrOt+V6AcSUaVcmMscZ2IsDgXCdL6kolxXoSyKDyqKuLMzMNL46PMKFjGYw?=
 =?us-ascii?Q?Er/C/+jMCbUHmc5wn+pjhQKLhTU1ZrYV9dQp+dnpzHak5Io0pqxBdx5T1nrZ?=
 =?us-ascii?Q?Fa1J3kVqpbpvIIpm7oIcvS42lu2uOaWIacQmf76xx5Ox/jqhZgd1JxoOXU4O?=
 =?us-ascii?Q?R9+2PJbqPeYzB7Li7DCWl/u1VnlkiHVQl37CuLsAr4wWDHU3c4BT34QX9k/W?=
 =?us-ascii?Q?T0PbcUgf234FZ2rEQRyLafEPOIhCfPQ8IymYpOeVNgEjn8wzW66OPlZjFb4E?=
 =?us-ascii?Q?y1+5kEX/MsP+NkALANpr56YzE3C89d2gLpcTYWVUDLJQ6O0Nk/4PGfrvGFFb?=
 =?us-ascii?Q?e4U1RDARoPd1juqjP0J+kBPmm1SMIfSRoMNRvLOqeqmGo+NxSyxKE4pN349W?=
 =?us-ascii?Q?sm47276n0Qq4eNPeE/oZNfrF6iHAlvOpQaoe/3TsCIFvv6TZISLudTDFP02y?=
 =?us-ascii?Q?13OeW51CH7ctu+Ab376BFEd4ee3nKJ7W+cxUMYTBZV7PNnMdSwvTMVefkDXk?=
 =?us-ascii?Q?p70t48rZbCBiUC+69HparD/nGtvf7o/Mtga24dDjHwrxVS9ltqkHOYcROQM+?=
 =?us-ascii?Q?BThYCRPc1Q+m7TMzBNYMawmWbZNKhpU+w/u7vlum4WSO/sVsL2INCei2pB5u?=
 =?us-ascii?Q?FQ9FOfqPo9SFKTNT693UUahEGt0JbUIC4uqPC2rKSrX8E6J51HAJN/ICsh3j?=
 =?us-ascii?Q?AEKp3zGGXc81IoX9CIki1NGu4QNv4QLsagA8vyljpfN60M6jd8UqCwhh0Iur?=
 =?us-ascii?Q?yEFG8Jla66gClvdH7NULlFSKjan47qM9dDhtxFLrGWX+3yljgVihdg9KpzTa?=
 =?us-ascii?Q?dixvamRr6JxbpwEbuBuCC7O7+Vi96xgWdwOmDkxqsCKU95T5FHTbLjlD3nVS?=
 =?us-ascii?Q?mKNVGmnVMOyLAziZ/eSZ+QeY+vDYn+U=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 673bd517-9cf6-44da-b946-08da40347f64
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2022 22:59:04.8474
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bgB9tGkDMie7KxZrrHHo84Gg7pwqqqAITR8rg1tLN3uv0r+o7sWYHHOy4xo5JU2+3TcVvk7uzvh+hLQaaVPwYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5068
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.874
 definitions=2022-05-27_07:2022-05-27,2022-05-27 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 adultscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2205270111
X-Proofpoint-GUID: ak9l4zlU8484jy7Y2cVramGWqttby6aF
X-Proofpoint-ORIG-GUID: ak9l4zlU8484jy7Y2cVramGWqttby6aF
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As an optimization for loops sequentially processing hugetlb address
ranges, huge_pmd_unshare would update a passed address if it unshared a
pmd.  Updating a loop control variable outside the loop like this is
generally a bad idea.  These loops are now using hugetlb_mask_last_hp
to optimize scanning when non-present ptes are discovered.  The same
can be done when huge_pmd_unshare returns 1 indicating a pmd was
unshared.

Remove address update from huge_pmd_unshare.  Change the passed argument
type and update all callers.  In loops sequentially processing addresses
use hugetlb_mask_last_hp to update address if pmd is unshared.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 include/linux/hugetlb.h |  4 ++--
 mm/hugetlb.c            | 46 ++++++++++++++++++-----------------------
 mm/rmap.c               |  4 ++--
 3 files changed, 24 insertions(+), 30 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 25078a0ea1d8..307c8f6e6752 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -196,7 +196,7 @@ pte_t *huge_pte_offset(struct mm_struct *mm,
 		       unsigned long addr, unsigned long sz);
 unsigned long hugetlb_mask_last_hp(struct hstate *h);
 int huge_pmd_unshare(struct mm_struct *mm, struct vm_area_struct *vma,
-				unsigned long *addr, pte_t *ptep);
+				unsigned long addr, pte_t *ptep);
 void adjust_range_if_pmd_sharing_possible(struct vm_area_struct *vma,
 				unsigned long *start, unsigned long *end);
 struct page *follow_huge_addr(struct mm_struct *mm, unsigned long address,
@@ -243,7 +243,7 @@ static inline struct address_space *hugetlb_page_mapping_lock_write(
 
 static inline int huge_pmd_unshare(struct mm_struct *mm,
 					struct vm_area_struct *vma,
-					unsigned long *addr, pte_t *ptep)
+					unsigned long addr, pte_t *ptep)
 {
 	return 0;
 }
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index a2db878b2255..c7d3fbf3ec05 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4940,7 +4940,6 @@ int move_hugetlb_page_tables(struct vm_area_struct *vma,
 	struct mm_struct *mm = vma->vm_mm;
 	unsigned long old_end = old_addr + len;
 	unsigned long last_addr_mask;
-	unsigned long old_addr_copy;
 	pte_t *src_pte, *dst_pte;
 	struct mmu_notifier_range range;
 	bool shared_pmd = false;
@@ -4968,14 +4967,10 @@ int move_hugetlb_page_tables(struct vm_area_struct *vma,
 		if (huge_pte_none(huge_ptep_get(src_pte)))
 			continue;
 
-		/* old_addr arg to huge_pmd_unshare() is a pointer and so the
-		 * arg may be modified. Pass a copy instead to preserve the
-		 * value in old_addr.
-		 */
-		old_addr_copy = old_addr;
-
-		if (huge_pmd_unshare(mm, vma, &old_addr_copy, src_pte)) {
+		if (huge_pmd_unshare(mm, vma, old_addr, src_pte)) {
 			shared_pmd = true;
+			old_addr |= last_addr_mask;
+			new_addr |= last_addr_mask;
 			continue;
 		}
 
@@ -5040,10 +5035,11 @@ static void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct
 		}
 
 		ptl = huge_pte_lock(h, mm, ptep);
-		if (huge_pmd_unshare(mm, vma, &address, ptep)) {
+		if (huge_pmd_unshare(mm, vma, address, ptep)) {
 			spin_unlock(ptl);
 			tlb_flush_pmd_range(tlb, address & PUD_MASK, PUD_SIZE);
 			force_flush = true;
+			address |= last_addr_mask;
 			continue;
 		}
 
@@ -6327,7 +6323,7 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
 			continue;
 		}
 		ptl = huge_pte_lock(h, mm, ptep);
-		if (huge_pmd_unshare(mm, vma, &address, ptep)) {
+		if (huge_pmd_unshare(mm, vma, address, ptep)) {
 			/*
 			 * When uffd-wp is enabled on the vma, unshare
 			 * shouldn't happen at all.  Warn about it if it
@@ -6337,6 +6333,7 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
 			pages++;
 			spin_unlock(ptl);
 			shared_pmd = true;
+			address |= last_addr_mask;
 			continue;
 		}
 		pte = huge_ptep_get(ptep);
@@ -6760,11 +6757,11 @@ pte_t *huge_pmd_share(struct mm_struct *mm, struct vm_area_struct *vma,
  *	    0 the underlying pte page is not shared, or it is the last user
  */
 int huge_pmd_unshare(struct mm_struct *mm, struct vm_area_struct *vma,
-					unsigned long *addr, pte_t *ptep)
+					unsigned long addr, pte_t *ptep)
 {
-	pgd_t *pgd = pgd_offset(mm, *addr);
-	p4d_t *p4d = p4d_offset(pgd, *addr);
-	pud_t *pud = pud_offset(p4d, *addr);
+	pgd_t *pgd = pgd_offset(mm, addr);
+	p4d_t *p4d = p4d_offset(pgd, addr);
+	pud_t *pud = pud_offset(p4d, addr);
 
 	i_mmap_assert_write_locked(vma->vm_file->f_mapping);
 	BUG_ON(page_count(virt_to_page(ptep)) == 0);
@@ -6774,14 +6771,6 @@ int huge_pmd_unshare(struct mm_struct *mm, struct vm_area_struct *vma,
 	pud_clear(pud);
 	put_page(virt_to_page(ptep));
 	mm_dec_nr_pmds(mm);
-	/*
-	 * This update of passed address optimizes loops sequentially
-	 * processing addresses in increments of huge page size (PMD_SIZE
-	 * in this case).  By clearing the pud, a PUD_SIZE area is unmapped.
-	 * Update address to the 'last page' in the cleared area so that
-	 * calling loop can move to first page past this area.
-	 */
-	*addr |= PUD_SIZE - PMD_SIZE;
 	return 1;
 }
 
@@ -6793,7 +6782,7 @@ pte_t *huge_pmd_share(struct mm_struct *mm, struct vm_area_struct *vma,
 }
 
 int huge_pmd_unshare(struct mm_struct *mm, struct vm_area_struct *vma,
-				unsigned long *addr, pte_t *ptep)
+				unsigned long addr, pte_t *ptep)
 {
 	return 0;
 }
@@ -6902,6 +6891,13 @@ unsigned long hugetlb_mask_last_hp(struct hstate *h)
 /* See description above.  Architectures can provide their own version. */
 __weak unsigned long hugetlb_mask_last_hp(struct hstate *h)
 {
+	unsigned long hp_size = huge_page_size(h);
+
+#ifdef CONFIG_ARCH_WANT_HUGE_PMD_SHARE
+	if (hp_size == PMD_SIZE)	/* required for pmd sharing */
+		return PUD_SIZE - PMD_SIZE;
+#endif
+
 	return ~(0);
 }
 
@@ -7128,14 +7124,12 @@ void hugetlb_unshare_all_pmds(struct vm_area_struct *vma)
 	mmu_notifier_invalidate_range_start(&range);
 	i_mmap_lock_write(vma->vm_file->f_mapping);
 	for (address = start; address < end; address += PUD_SIZE) {
-		unsigned long tmp = address;
-
 		ptep = huge_pte_offset(mm, address, sz);
 		if (!ptep)
 			continue;
 		ptl = huge_pte_lock(h, mm, ptep);
 		/* We don't want 'address' to be changed */
-		huge_pmd_unshare(mm, vma, &tmp, ptep);
+		huge_pmd_unshare(mm, vma, address, ptep);
 		spin_unlock(ptl);
 	}
 	flush_hugetlb_tlb_range(vma, start, end);
diff --git a/mm/rmap.c b/mm/rmap.c
index 5bcb334cd6f2..45b04e2e83ab 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1559,7 +1559,7 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 				 */
 				VM_BUG_ON(!(flags & TTU_RMAP_LOCKED));
 
-				if (huge_pmd_unshare(mm, vma, &address, pvmw.pte)) {
+				if (huge_pmd_unshare(mm, vma, address, pvmw.pte)) {
 					flush_tlb_range(vma, range.start, range.end);
 					mmu_notifier_invalidate_range(mm, range.start,
 								      range.end);
@@ -1923,7 +1923,7 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
 				 */
 				VM_BUG_ON(!(flags & TTU_RMAP_LOCKED));
 
-				if (huge_pmd_unshare(mm, vma, &address, pvmw.pte)) {
+				if (huge_pmd_unshare(mm, vma, address, pvmw.pte)) {
 					flush_tlb_range(vma, range.start, range.end);
 					mmu_notifier_invalidate_range(mm, range.start,
 								      range.end);
-- 
2.35.3

