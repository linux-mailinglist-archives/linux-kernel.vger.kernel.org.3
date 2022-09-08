Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD705B26F5
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 21:39:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231693AbiIHTi5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 15:38:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231638AbiIHTim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 15:38:42 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 243A71079F4
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 12:38:41 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 288HJKWG011859;
        Thu, 8 Sep 2022 19:38:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=rZY4W+LUFG4rI4d5PRLMZFloBvamyZxC3qJG1jaDVZw=;
 b=AavCC8+bTjqGH55YMY0UKLsvJBadRwn2B3DDNhcx47uKUAlriwDuzQLFV4M+8dK+CQj4
 hH9AfUHtoPskd75rYhIww3e9qDNEwf4DicbO6J18J2xVLLf/+T1fB19SL28N2X97hKW8
 Ngzy2hKUL1mbCcf7laYbMGbs7ZGn2wCwnRIM+TIsE7rEC506EnWLMdK7voZESfIr7dQA
 DhJI2W6JFnqmidTjVVUDSDu6bW7Hd+BzyAzCXuoHsHHloyTt9r7GZsFhqmmea1hrbEo4
 6/oTf3cC2TVedmxzNPfF0QmJpYDzo/QkI/XOnji1WfTZrN51GejheCEdBeHEtmD6+Qbm Uw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jbwq2mw5e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Sep 2022 19:38:28 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 288IE630028151;
        Thu, 8 Sep 2022 19:38:27 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jbwccq4p2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Sep 2022 19:38:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gsppA2Btx+yW0hIN1ATZOG9L2h2jViZr8V1Z2vgx9U4E2f92OR1IC0xKVuo0YEle1mVuiODrun3JxI7KwuaUS06ODe844nZk2BtNW0y98nZMljj9qEPlQXgX9SX9GDMtvl6MP/YwUMMQROct15qoZGkmAvvYjOhiPW8oXH4lpJ1AwQjicTLG2A46WUXj1n/UcDWI/Czpz5d3CCOLlizQIh5991Ne7VWEGNLAJJYeaqTL3tMUqSMkQJwaGt4tqLWu49fR5WAaguI3w7pCrYubbU+7UwpFNt27XyI5LdQ4bYQC7KHl5+6RxYm+qQv4PonvPkMGJN+/muj8hk6TnxQrHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rZY4W+LUFG4rI4d5PRLMZFloBvamyZxC3qJG1jaDVZw=;
 b=mPxkSxffst4t60uOFdKamWxyEQsMbk4okRONGu0z1Hn36dpqJ6WlcNuqrY/bKg5pXyLg+/d1H8RlyR9b3JitaxXCcof8uQ6wfs8Nn8uRjSxHlUs3VZqNPRc1itcjkHDYMBerTehdzaZURfuwERZvrmmJPrrevn78EHMcOuILeWOIhNna05mViQmvX7nuHLg3mwdWiP7InJ2WZZ9A18GmKkXhngjAHcG6JRMqgAwTtjsajBXwb7i9pA7dpncuKCEvh60rDTXv9oNVkzmnGgrhW2ViFDtPxSaMBKovTBGn1gO2I7NqtVuV0hPnbTmsHdgzy6OeBinMZBEMqYgB00phkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rZY4W+LUFG4rI4d5PRLMZFloBvamyZxC3qJG1jaDVZw=;
 b=cTIXXaPVwF1JNmnfvWftzd4kbXPwIPVh37YciqN8fyIyhXfVCpPLXx8uUs/0cgQ1oINzOs/JIJaz7rZT6I+sf3dh7ddDW2ArmXXEHv0sxz803jiTNww/NR+QFLO/MOkhJbfCcichwaWmtHoYD6ns8izO4XM3UOb+wzoXrh1VQPY=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by DM6PR10MB4249.namprd10.prod.outlook.com (2603:10b6:5:221::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.18; Thu, 8 Sep
 2022 19:38:25 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::ec55:981e:3693:b37]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::ec55:981e:3693:b37%4]) with mapi id 15.20.5612.016; Thu, 8 Sep 2022
 19:38:25 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, willy@infradead.org, vbabka@suse.cz,
        william.kucharski@oracle.com, dhowells@redhat.com,
        peterx@redhat.com, arnd@arndb.de, ccross@google.com,
        hughd@google.com, ebiederm@xmission.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v3 6/6] mm/hugetlb: add folio_hstate()
Date:   Thu,  8 Sep 2022 12:37:06 -0700
Message-Id: <20220908193706.1716548-7-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220908193706.1716548-1-sidhartha.kumar@oracle.com>
References: <20220908193706.1716548-1-sidhartha.kumar@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0096.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::37) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|DM6PR10MB4249:EE_
X-MS-Office365-Filtering-Correlation-Id: fb55dfae-a4c7-442d-aa55-08da91d1b241
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3Xp+3Y9FILNg7y0jJshlyQRZTgxHq2wTApzYHoiqHGUNL5zDqZPXsxIHq4CIVUlhwM2jSgfo7ipYAqV1evl0ZinA+LMwttLmMX9NZZbJk9Fzxkgko09A8JrnjSLkdW/0ysVkTAxIZcqr1o8gNpX5wVb2i7X/Tv6rDixgE3cUpwPJhzPC04F3rGEnG08RZVauTlh/zWrO7Cz9P1zMcGJs9txlzbf+fCHH2jbQM8ICOMOmYLSWQf69zLIY8tgOQpShC3cw4sFCppmTxczxEFyp/b7/siUfwq3izqc9iZs2d/8RFuJ2zR3J+nRuTrX2p6My7dYWDiLUXkE60NOBFeZRkcoO1LgXZstJ8W4NF3sqUDGwmKAAeKKdIimHborTxcRJYpcl7/tH2LbWQTmbQFfdpMghS+e4UyvTJgyxhVdGk/dQNog7JusY9A7OLmqWrnKg31a22p5GpqJpLlmQvBLacLt6GkIhMH/odmpy8vKZRdDPNjO/5VoFqFnMAJKxfWKkEf/tOiWKFM4kMNIrz3fhj3Kbd9/5i/N8BVjmAXwodu4ipDQo3UL+faOBp8A+H8UDNv3fYZ1SwoKae/Z8eCeoaw1pyYbxjagiBJ2zgDMpgIGPJJ5xP0hw0iqhLKW4Y4hQXzWpfw3fCRLWZguNSO9b3nchYhcKhcubU8viUDu8nEcU1Io+d8qNKrddtPPASC+Bp/hq5U9uGRbpNcMAIm9HvQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(376002)(346002)(366004)(39860400002)(396003)(6512007)(6666004)(6506007)(26005)(41300700001)(6486002)(5660300002)(316002)(66556008)(66476007)(8676002)(66946007)(54906003)(36756003)(86362001)(8936002)(7416002)(478600001)(2906002)(1076003)(2616005)(83380400001)(4326008)(186003)(44832011)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bQUFne8mhErBDOJ5JmINLS/jNq/l0UwyThtORygZaftDfIkoYISSzP1peoy7?=
 =?us-ascii?Q?6FuIqNx4Nlye7wWSsX77FpDWoJyFXCHCXpFW4wfnvP2eAPciCVyW+OM1931J?=
 =?us-ascii?Q?Y1WR3GrXoXHO2Fbo4IUQ9qXE4XFJ+q3tBusIcc9s10XVcQykLzrFbdXVhBOk?=
 =?us-ascii?Q?0VgjHmVzi5p5FRYize8cEn3zIEdudqa1/tTfTYs9OOgp726molN0A0OThX3P?=
 =?us-ascii?Q?PHp7ISllfTdeUZtjSgSSnwRBF3dNUg6Dn+Jqshy4qB2ExZHJ6uFSAuwmoavi?=
 =?us-ascii?Q?qeeapdyoI6KUGt7rAL7NBoh9S1Pzz5U3m7kJBO2QL2goPzTl333r2i0KYKuk?=
 =?us-ascii?Q?e+6zvpfIlyHpEietM087ZQIIh0JKLXu86BF2kjgZHBjqVyKP0/2sQoOB3QVs?=
 =?us-ascii?Q?uVjaTGK1zYQDzpsov6mijpmrY8GKGPb99eWG2cmlG9Yoo/MZtzgadl/ZNYRE?=
 =?us-ascii?Q?t72ee+fGkdRjeTPZC1j6IsNR0kCZM2jJq/uQDOHtHG0Dedvmk8Ufye42KEKK?=
 =?us-ascii?Q?ZzN0tHnQADxiMB2fdrqV76UDGoAOVX7MWLBPGjBi/dfcMAzRe1BOuOisGMia?=
 =?us-ascii?Q?F87ChvCIDYc7hwAYd/EeA5IDUEJjA0LBlPyLp3DzPqP/SnBzeJOe7/TYsIT3?=
 =?us-ascii?Q?zm6+3up1UT/77k1yT+qm/KxRb9su8kh9LQE4moutrwFuFI4JN6J7apBmg4z7?=
 =?us-ascii?Q?OardQ58E2TeXEVxY6YKXV7niJAOB73wuj7aJtsLLXDdBJeo5oNNpvUsr0enR?=
 =?us-ascii?Q?v1LM9KxxAzPlNK5RKkO9CtJnkuoMFwY22REpRvQbdI2ocKdvMzAKyBefC03K?=
 =?us-ascii?Q?3hCgAM4nMkQUbtnaPV9KHOEJZUItJVd5KRTcTrR0S8c1iz+Tbth1mzBLU14H?=
 =?us-ascii?Q?RGh5Qyj1KJJyiv+ePwnP5MeQFwnBgluOvLgFPDI5RiYCczE/Dcadey8+nlBM?=
 =?us-ascii?Q?0Ih7eHNsHF7+7Jvs0Z5T08MApofSQZRHcUCKRmV6Bkd8Xe6PcWxkgw4ajURc?=
 =?us-ascii?Q?JDGXpLFKEFSAjl9SRZFpAy91hiWQYFm2EA4C5HVzOPLMBW0GBQNRza1OcZR2?=
 =?us-ascii?Q?z7v0UVsBXA0yVWChta2S+1dLe0ZMf3SX3v8+CSMioQUZu22t8fru7O1dtP+M?=
 =?us-ascii?Q?3hT1qUqIS0mXglD3l3TKdcvq6WLZ6TZdXDstdKC2uiEico47js/eQyRmRma5?=
 =?us-ascii?Q?SiS8ZYBrfZXr/X05FRn2HeLsKgb+D24ojpTTS1dCf3lDgue4MCNWtG7Lw5G4?=
 =?us-ascii?Q?RwvEjDBkfDM5WST04S/YVeWXWtMO3GqspnkUe6lliovyLXZNZkqrp1GtXQc1?=
 =?us-ascii?Q?zf8Fy8M4YY8Z+jdbzhy0zy78wkvm3lnL/t4FIYFpULsYPw5kpKJm8fJMzASr?=
 =?us-ascii?Q?+Th7+x6rNuks1TSlZDg85KC/tmWmm+eNm2kTOnnwwqV5Gsvmc2GcBdKLDe/X?=
 =?us-ascii?Q?5xm17GBpyc7th9A75VzmtvokQgSq6E8QD6Lz16g46u6yFZwVEAcWvb519G51?=
 =?us-ascii?Q?2xbGPYXNT3ooh3Qmmt10v11J9jCVLzYJAdedcEnabG0DnjuWCTxGXvCiYrUH?=
 =?us-ascii?Q?FbrPqAcdjsTGDgFfLdsz+lPguD3EmH7AkbZYmyQSlqeignzqFB5IVApMKWve?=
 =?us-ascii?Q?Hg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb55dfae-a4c7-442d-aa55-08da91d1b241
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2022 19:38:25.2124
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VxMt7mqTsOONKGAXhrHgskOLYzt+rav/haWEAquixKfPim4uDqvxS8VwwcivX33kYS6InqoA+JjY4o6PXOZbqKt1/Mb4Zh4OKZISyq5h5B8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4249
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-08_12,2022-09-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209080069
X-Proofpoint-GUID: Bq-jauHqR4W4KjDC-ZTY86P2bZBXQiDY
X-Proofpoint-ORIG-GUID: Bq-jauHqR4W4KjDC-ZTY86P2bZBXQiDY
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Helper function to retrieve hstate information from a hugetlb folio.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
Reported-by: kernel test robot <lkp@intel.com>
---
 include/linux/hugetlb.h | 14 ++++++++++++--
 mm/migrate.c            |  2 +-
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 0bcaca694ab7..f59e8fb3f937 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -850,10 +850,15 @@ static inline pte_t arch_make_huge_pte(pte_t entry, unsigned int shift,
 }
 #endif
 
+static inline struct hstate *folio_hstate(struct folio *folio)
+{
+	VM_BUG_ON_FOLIO(!folio_test_hugetlb(folio), folio);
+	return size_to_hstate(folio_size(folio));
+}
+
 static inline struct hstate *page_hstate(struct page *page)
 {
-	VM_BUG_ON_PAGE(!PageHuge(page), page);
-	return size_to_hstate(page_size(page));
+	return folio_hstate(page_folio(page));
 }
 
 static inline unsigned hstate_index_to_shift(unsigned index)
@@ -1057,6 +1062,11 @@ static inline struct hstate *hstate_vma(struct vm_area_struct *vma)
 	return NULL;
 }
 
+static inline struct hstate *folio_hstate(struct folio *folio)
+{
+	return NULL;
+}
+
 static inline struct hstate *page_hstate(struct page *page)
 {
 	return NULL;
diff --git a/mm/migrate.c b/mm/migrate.c
index 6a1597c92261..55392a706493 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1589,7 +1589,7 @@ struct page *alloc_migration_target(struct page *page, unsigned long private)
 		nid = folio_nid(folio);
 
 	if (folio_test_hugetlb(folio)) {
-		struct hstate *h = page_hstate(&folio->page);
+		struct hstate *h = folio_hstate(folio);
 
 		gfp_mask = htlb_modify_alloc_mask(h, gfp_mask);
 		return alloc_huge_page_nodemask(h, nid, mtc->nmask, gfp_mask);
-- 
2.31.1

