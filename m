Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 561A254EC04
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 23:06:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379034AbiFPVGZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 17:06:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378949AbiFPVGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 17:06:10 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7080560A87;
        Thu, 16 Jun 2022 14:06:06 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25GIdgGI009844;
        Thu, 16 Jun 2022 21:05:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=BfKSG0usVJqxG0ol28aIEYVmg+YEzrDIzL+kXD4E9wg=;
 b=o+e4cy7evmuGzoHea8BiIpW4hw9XzJqk6IOX0uWGNTUsTmjWc58Wm/BFyunqf2onpY7B
 Vuhl4KvbM+5elwvB0c8CGpMELNfAS1pp3m6YpaihTbgVhy0QJbR0Tro9VUFFi8OeQHhL
 A4PaDpbs1nfFjcXwqEi8T9mQEEEYlJ0YwaGGb1rZtkukugOcdWKuHkd7eMwVyFjqqW6/
 FvFnz93pBUOC3wlIYuJhB9QBDK6NF2VJBHEFNOZ/tOrv4xJnehbtlfixRo21QWDfVnis
 Qc94eSSDiBypCNwruWvy+QLvw8agFENtQd0BcRwzLu6au0Ywugcpf+5F8Q8evXRqNdiv Mg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gmkktmd42-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Jun 2022 21:05:40 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25GL0GHv015694;
        Thu, 16 Jun 2022 21:05:40 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2045.outbound.protection.outlook.com [104.47.56.45])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gpqq2tujq-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Jun 2022 21:05:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FKTFXw7iXw01dGjBElm4aANH6RFuX3uwODZx1FP/i2de7d3AxuGA8VcGSeChUI+dSeqHwpbsg+9OB69Rp5a70abSbU7kBoQXWOuSU3sLLBYY0rdKQUq9YgtrtuEt/iPPvJkHydYLc6F2NCNAQeqeyD9p/6mmi4SYleKL9nUikVSOzRAmkQNJdkHYIfmhJ889jXsPp7mnxRTEM37KDKTv2STKL58Bjzvlcjr8Z73FTRFVeU+XaWnmCqWSv36RgLqC9ujXUSChomUppQzZw7wwOZOheOwXvrtP4pmdRnDV/nMwa5HO4/MYjTKR92nDWkzzP4f+1F+y8WqJA/KQU1LcKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BfKSG0usVJqxG0ol28aIEYVmg+YEzrDIzL+kXD4E9wg=;
 b=F3Mv/fPtqwu5kdIRuFqrnW6yFuasr6zMJ2jGzsiFMxuSQgCZeH4NMxLf/dcfbX27IO67d3exk1SbL83H6Yrr7eEyyl4M7CMUyADBbx2qJLfSPNoZTLDDeVvviINHx8NRRO42GcYL6YknnMGS0tvmS/qMdfaIlEIr02V+0dy+FgvHYTbVacIm3ruAUJrIOyjrThmUQ6x6CusAl8/ouwmyGzCbFiv7urB6zqT5QF8qCHG59cl7QIrLyPBKoHu/L4pwipMUslWRIB/Zpk2kZhD6vCYDCQl4gGllNMvfvISLJ2vbjzYiohhF+jSKdNFdYmi1jyKRMT899YeNa0rZZoteQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BfKSG0usVJqxG0ol28aIEYVmg+YEzrDIzL+kXD4E9wg=;
 b=F3kP2LWAXHtwZqfJ5yO2ae5dDscOnIFBbcTc82nICI/kslP9/FEncXRCFgiLRHBdWCeCHf1gLbgfwEicd/u1pgTNQKyqJ10jeJPWrPiYysvbhYRsrUQsd3E1fovWAAX/g/Gj04N80mjnbYY7Y60c+r+L4j8gTaiHVDe4RqfBxWo=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by DS0PR10MB6197.namprd10.prod.outlook.com (2603:10b6:8:c3::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5332.22; Thu, 16 Jun 2022 21:05:35 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::2125:9bb7:bfeb:81f9]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::2125:9bb7:bfeb:81f9%8]) with mapi id 15.20.5353.015; Thu, 16 Jun 2022
 21:05:35 +0000
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Michal Hocko <mhocko@suse.com>, Peter Xu <peterx@redhat.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        James Houghton <jthoughton@google.com>,
        Mina Almasry <almasrymina@google.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        catalin.marinas@arm.com, will@kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH 4/4] hugetlb: Lazy page table copies in fork()
Date:   Thu, 16 Jun 2022 14:05:18 -0700
Message-Id: <20220616210518.125287-5-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220616210518.125287-1-mike.kravetz@oracle.com>
References: <20220616210518.125287-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0109.namprd04.prod.outlook.com
 (2603:10b6:303:83::24) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: def82adf-ef2e-490c-63f2-08da4fdbf4ac
X-MS-TrafficTypeDiagnostic: DS0PR10MB6197:EE_
X-Microsoft-Antispam-PRVS: <DS0PR10MB61970ED5603EF481B7D9C94FE2AC9@DS0PR10MB6197.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u5Uo7dTWBxc2qtpx7rKB5IVITFajHc6Hgu0DY62jC9p9uZ4pe0AYe8b9hLoienWriDpEf0O7UWDBcpgI4uc0K9/AlslnSFuUaO6R/ptA+1ObNhBDaqIOUPIR74N2Es5/AqccVjEvUw2TZG2uyiheYXFs1Tfh6mUkvlpK3zkFH6RtVGWkS1+Ij7I6+OYdpdLObqre2wnBDpWgxolV9XdqabX3IMdWcdHtG6uvmrrqb8wsvDmjtCHEX48063m7RMmEBYm7ZkvPeLrfbhc+qHe/SK9KQODAChXOyOnOnuewXGs/PZ4ZF4k7myr+r7XrTYqBk7zGEO8Fogng59mS2TVgCDnlHZUJoOTJuCtjc7b2bFTsTapaj9M7I8lweHDn5AAJGgHYIwSk7tEhMtkl7R5ZdapiAY73AVvzYYAlk5E+rtJnlefAJXaojRSGR5VgVdlN0mqs0zlIMov/ctKMDopDWVKm2fFESaUi5fDaj59KPyImfVw25klbRcdNfQf1U7f68AmcKhHOQg4+fI0+VDRuzCrIqYlWIZFbKe7KoK+QsqRis8uX7MP15DDcFQtDtRAfxpxMZtoHjb7WP2Ljy4Qo2UXheNRcQiliYinCtLn25dqsTG9vn3tS9zXeRCfto9lAt5dIHwB5SBr+m+J3sx0aU9tf/LfKSWigb2RKJdBcKg12H8a+49R/McQGi22bm/uJ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(6486002)(38100700002)(6666004)(66946007)(7416002)(83380400001)(316002)(2906002)(66476007)(6506007)(4326008)(8676002)(54906003)(1076003)(498600001)(5660300002)(66556008)(86362001)(26005)(44832011)(36756003)(6512007)(2616005)(186003)(921005)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5oEVS7A04wOfzSwQdYAZAORfCOAPLfcal+VGyb50K6y0NcpCG8tI5U7kL7yi?=
 =?us-ascii?Q?D6tNv2dCx1deRhaxnvWipU4VAW/UiLaONNh1WH9BZikpbfcHp2ykXse25T5V?=
 =?us-ascii?Q?clordR5RKyvlTLnk1HCz/u0kX3rOAv7e7VYKCHzDyjFlQHYe8Hd1ewP9y/6r?=
 =?us-ascii?Q?juP1tbUNjm3H91u5aqZNgm0aNByvBEEtGqTicJTwj2WM78QiDC+dM46QY3Px?=
 =?us-ascii?Q?vYxMfrdZV2TX1uLCLGpcCiGJYwBTqnG4nh6z8oIhCsEesaZdwlTdk9Q0Qom1?=
 =?us-ascii?Q?isUUdKDhK6S/JGXM8/8EjdazVy0XLx5K2dm6sByTXBJZcSOKjOF2TNCJWcXV?=
 =?us-ascii?Q?Maq7Zz2FyjaDJPcPlJy/X/G0eaUnfRqd7vvu2huSEn0GcJR7w/vFT3MJte3w?=
 =?us-ascii?Q?w6HZezfIiYqyv+dLDfzcmfhAV2J7YjRirr+eiZKre5iwUnztVeVMltksFZnh?=
 =?us-ascii?Q?0/xP/27YV85vEaKh7LsqdYcfjrwLbml5EuPTYdrKXn6ctndhXbTfHZgQE7iN?=
 =?us-ascii?Q?WcWYdWn27FaOk3ErB53fAkh0v3hYP6QwyUoubZEbirJ00kgtvJhoeayp7x7O?=
 =?us-ascii?Q?+oRSgcLwMCsZIGyolzon3JplOq6bRp31CBUtAWbKhmmdAmd6r/dj+iCf5Ifj?=
 =?us-ascii?Q?jGtytBgXM3NxvSB/Epreku3GxlIB9LaHbMg1VXfAsVWzmJw+5F2kJJ+hcVLv?=
 =?us-ascii?Q?PTS76h18J9TQOwZUDl4mUCkkzPryOYgNhirFO2NdDEAB9RfAjDroOGFMCJCl?=
 =?us-ascii?Q?oN1OPm8xB7NRfhhtRl0uoGg4yLhl9QagJw/sSXqSng+ZTI07grteuuDfEIFc?=
 =?us-ascii?Q?REm5ldfqjfYjCvw+IrS0RBd+hf4n1iE5xvnmUF2moEMatHns8elIE0J+XUEi?=
 =?us-ascii?Q?MU1rS+gFNfAzkLm03cbAEcX18LNUTG7begwed9LNOKbXz7QCu+Xv2405Rb4v?=
 =?us-ascii?Q?ihYe36AOzN/tsNf7g5XlA1WcPeQOFNjY0MiyxZUQjgRiEhH4yMERrHz9FgTu?=
 =?us-ascii?Q?7dFhauP4wPxBkBEaEzYSEMpmJtWmvPOWHFAALFM8bR+qVaA60rb5HLsTHD/E?=
 =?us-ascii?Q?k+4sA4j+ej/A+kntPLACqb0A2JzV4Hfi+xHuLXRk1oEvByzGL2uZ0C7SeA1j?=
 =?us-ascii?Q?390/2JNieQ7dk1zwvos2CAYwfdmuGAX2dd4iVpFl1rXfZuMJUYYje1RWOac2?=
 =?us-ascii?Q?u7BhKS6RqQS2/ik2EtuVVr1UFpRm8hNCF/eEK6aXHhNb8M1WkBOEJ6RW71wD?=
 =?us-ascii?Q?5VL5G5RkaUqCNiDXOgDxG9CHjNztKWVThEwpbD7Sw/hjKQPEYZb+ZMSzXr77?=
 =?us-ascii?Q?GCmyjoZLOmAPUtcvOxyQZYWrn//NQakWwsH80CT+kMErCrFIhD1M4UCuU7Xb?=
 =?us-ascii?Q?+maKEys1qlalLxJsF/3RSsCcS++jOzQzP2xZTaKy5wYldOvRUrmyzLimxQ1l?=
 =?us-ascii?Q?1IhvVYfmhvYs+zd4dyRlIRUlO6BLeV+d7+B7ngoJM6G7J0mP8Ve5FT93lxhy?=
 =?us-ascii?Q?ZFh18sIrv7NJgRmDLhb53LjNRprkPhEtrrVdlO2D9wzusIMi/ch9SqMEcQn1?=
 =?us-ascii?Q?aMNKBOf03PuuvIrowpV6q3qEgy1hIl/1Vr2o8v0K/E29HQaoGuJ2E/lpSMJu?=
 =?us-ascii?Q?SGxgTG2g9/2Z4ThETXyMXpkPWyNOgG0JOJayiF/Fn5OaEvlXIH/5dg8V0XfA?=
 =?us-ascii?Q?vGM/YxK71mz9vVqu2ZyvY1FYt82yafJOlxaihVPQNY5xzMYqLDR+0rQCE46+?=
 =?us-ascii?Q?M9s3HOrREQk5uQHUoDmg8XAlMjKU/jI=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: def82adf-ef2e-490c-63f2-08da4fdbf4ac
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2022 21:05:34.9591
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yTuK49dGr1vktt9noofs7FvAhg4HMrm1GbucXyY+F617FjbRjFVPuGfPokCKcJNFkmbb8ELnU5x2TndlbzdXHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6197
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-16_16:2022-06-16,2022-06-16 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 bulkscore=0 spamscore=0 phishscore=0 adultscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206160084
X-Proofpoint-GUID: SUcO1w6rXXGWAt8ZQo27JFglZq9zzZfl
X-Proofpoint-ORIG-GUID: SUcO1w6rXXGWAt8ZQo27JFglZq9zzZfl
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lazy page table copying at fork time was introduced with commit
commit d992895ba2b2 ("[PATCH] Lazy page table copies in fork()").
At the time, hugetlb was very new and did not support page faulting.
As a result, it was excluded.  When full page fault support was added
for hugetlb, the exclusion was not removed.

Simply remove the check that prevents lazy copying of hugetlb page
tables at fork.  Of course, like other mappings this only applies to
shared mappings.

Lazy page table copying at fork will be less advantageous for hugetlb
mappings because:
- There are fewer page table entries with hugetlb
- hugetlb pmds can be shared instead of copied

In any case, completely eliminating the copy at fork time should speed
things up.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
Acked-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: David Hildenbrand <david@redhat.com>
---
 mm/memory.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memory.c b/mm/memory.c
index fee2884481f2..90d2a614b2de 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1262,7 +1262,7 @@ vma_needs_copy(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma)
 	if (userfaultfd_wp(dst_vma))
 		return true;
 
-	if (src_vma->vm_flags & (VM_HUGETLB | VM_PFNMAP | VM_MIXEDMAP))
+	if (src_vma->vm_flags & (VM_PFNMAP | VM_MIXEDMAP))
 		return true;
 
 	if (src_vma->anon_vma)
-- 
2.35.3

