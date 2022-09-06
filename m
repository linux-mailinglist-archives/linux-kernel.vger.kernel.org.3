Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFAF05AF1F6
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 19:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238783AbiIFRKS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 13:10:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239466AbiIFRIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 13:08:41 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2403583040
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 09:55:57 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 286GO3Mm004368;
        Tue, 6 Sep 2022 16:55:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=EhGjc5qCbFauFwUbBBY8TrIp5s7UpdADI09DseIRucQ=;
 b=y9sqWMDBfBaIwhTjoHb6mleJHeoyJeQu5uiVFRbdf362a0onEcdRkVSaq/SAZG2GLVCf
 HCZ9wzeasKxC/ec8HHA9Ec7OyE2zQoIud49qvuYskdH1oRnJ42frFnC0VMGgwb2JKLy6
 okoKDYmTe7zeWIBvolXmNV4+lfloTIJz0GHN2/kWWsMvfIKQtQ5VbrnDnqH4S0UcS5Xj
 M9LblRTo/FmW+sP2s0s5gQap+G0u2Q/bhDnbJkGhu7xrC3Bk+LKyWhicaazusRnhTTYR
 HYbmTc2uAGPMujbAZoSrEYXez8yLCW66b5NP192s/vzz0sz02tg6AFdc6X0+PcUQ+KmS JA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jbwbc6dyr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Sep 2022 16:55:44 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 286G7Dar027523;
        Tue, 6 Sep 2022 16:55:43 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2041.outbound.protection.outlook.com [104.47.57.41])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jbwc9e3tj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Sep 2022 16:55:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ECW3h0AHMtaHhcy0x0RB3UtSEP/oeC1GFLCBxx0NPnJqALKUyu7DdEQQ1dFPBQ4vNyOOplJ//rOt8u22e3/qU3hkDmD7H6+9Yaok4UI/2unFZgKR04TFFr2tLSQ7DCDxImlwPNgt0SbapaasQNkEYqaaWqnxySGKISIlXbcA1K9Qxb2/V5EidW+D1lPwqoZYwrYKc5GEa/3fns4dbqEGT+sT1Q2U76KGwLkPFWbVWW1jktgyxlxpMA8kkwMceP4W3lsPYb5ZJehKyfXE34FIiIgwAO2domdAGipLnYw5AETfU2jKeR88QBQsHQK2bKT0KhbFrRoH2qiVf6cveSerkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EhGjc5qCbFauFwUbBBY8TrIp5s7UpdADI09DseIRucQ=;
 b=iwNhh0a55hTTi2otW5aBv8+uOgn1euXAQS2DjCfT6ZYCQZTUEa0OKuWEPsiSuo0jov37Cl/+/8wq9THBhaN+LVOrLu84jxJpB42iBD0ur2uKAzMcSEwD24zDzfI8WCBUN5u/3sVJn3RYyKkT+3rts7tCZoCXoaHViBNLu745hDyEkhEo8jRb+vsv3u4fglmdOTBrrW0nRYjWnKxNdi/UxE+ybPoTB9RmGDk0WuAwCVeIWg/X5SZf8/v/eZ3VZFSGcJU9ZKOTI0P+t24ofMdQpe7TacFYMqNT3zRuxjuwzbEEn1k4CIu++fA3fx3NolcBNnZyqhkKUFjqLBQw9vzUNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EhGjc5qCbFauFwUbBBY8TrIp5s7UpdADI09DseIRucQ=;
 b=vL5oWzt7Ta1BcYUhMsc8EHqM9ctLPOixH7dTP+fjdvGFzOXIYRNvPqlR4tCwL/evslX+WCuNH118pg10nZ+J0j1sTexaXkmrfelI15fbCyK384tOsyJ8T+PzNcwSXdxuWQuWEUnPWeBK9ni3gXLcmfM9qTu7qbPFhEbmHyN8Ml0=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by BN0PR10MB5078.namprd10.prod.outlook.com (2603:10b6:408:129::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12; Tue, 6 Sep
 2022 16:55:41 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::ec55:981e:3693:b37]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::ec55:981e:3693:b37%4]) with mapi id 15.20.5588.018; Tue, 6 Sep 2022
 16:55:41 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, willy@infradead.org, vbabka@suse.cz,
        william.kucharski@oracle.com, dhowells@redhat.com,
        peterx@redhat.com, arnd@arndb.de, ccross@google.com,
        hughd@google.com, ebiederm@xmission.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH v2 6/6] mm/hugetlb add folio_hstate()
Date:   Tue,  6 Sep 2022 09:54:45 -0700
Message-Id: <20220906165445.146913-7-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220906165445.146913-1-sidhartha.kumar@oracle.com>
References: <20220906165445.146913-1-sidhartha.kumar@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0088.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::29) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5764f144-5c9f-4841-282b-08da9028a1de
X-MS-TrafficTypeDiagnostic: BN0PR10MB5078:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wBdSqVZxOVVjTyYtjUdDP5PSBI0txioZQPYMxzOHLnOHP3OYIK/srFPXGRbib4lvc1cBljzsB3/bcxgVt/i7Z9OOmB+CSJPuh2OyXNHVqOI8R0UGoBol3qn/nu7N5fCTJ6nURMS52oRjnsSSWrlgF5r04RZnlADiftAdpO6dafMAbbmCw76/ODWxEDi1HoApOwNP2ahIB3q7pbyr2+vCAUQgZ0gAuG7nXdwwo7T23GJzm4CuDFwJ2OZGlcPLco5nGvoCCwl2S5jCOR6bZ3A6410gsN5XXjFNyhvZzdGzWSKsxPZHQK8SjKOZg0QB92Fx+0D1ls2hYLg5QAXwUTvw7aUx0mgT/q1IBbN8uT/J4VBEfFcCE/u81JihUjw/BqJXcjoA3gqCc8CAJdMhTBXaOfst95V5jJf5yyuHrx+5UZhgmIjWCUS8Bbf46HeYwj/7eMPx3tuOgglYniUaeqmelIP05SBtXkrF3PSVVGoCyJ+QeURReJwEZhlEnptUfbqvhZkvTIGqatphhH9h5f3CCdKRWrlAt98z2pEnu3Z9rYpe1hxRNP+cm+WCBLstx7Ddd6QZp9Y+NqqZX0qqQ1yDnLVoMpVi/472aq+ze6fKWfiC0NcapCuxGfsfAn8fUyc5qOJjdhB1gTg4xnHPjEVx4m/E0F8b9RIX5mqD7c2B9WKrcseeaZeSEIjQUNdENXbcVTph5WwZJLia+IHnwyghxw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(376002)(136003)(39860400002)(366004)(396003)(186003)(1076003)(7416002)(8936002)(83380400001)(2616005)(44832011)(5660300002)(2906002)(26005)(41300700001)(107886003)(6512007)(36756003)(6506007)(86362001)(6486002)(478600001)(38100700002)(4326008)(8676002)(66476007)(66556008)(66946007)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HFgcpSEdrEv6PVx3Di1OibRE+haFHjRAK5x5K5oW0Yx9XMWx67+OiWoVX7/8?=
 =?us-ascii?Q?WAjxK40+ySmN7/Y82q2OxWBhXsK52eFTewFtZlBegDkyjZov/3scm1V4IPSJ?=
 =?us-ascii?Q?BNVUWZlJuu6UVXgqaj04TKt9y5Qmw4HUOgrtrJIbxZBQGGeO+etXJv0U9jrU?=
 =?us-ascii?Q?3W7AdPWTMWzEjMtL1vbs7DZwbT683dpQHQ3iYzuYwd9oXSfhogIpNsYXMlCQ?=
 =?us-ascii?Q?GVYbu9hxlWptBYGJkCBD6RKMXfkOBT/fFFMtXhYruwTMsr9L80RzBvScDmBf?=
 =?us-ascii?Q?phF7TyLY8s4AjFew9Zwf+g8jobhc74qUzSG2Aq1vKFH3I3nLEhwKTZSN97EL?=
 =?us-ascii?Q?ijHsatWROncoxpDPCSnfHceuteJAJpoUX/6p+yAK90825QYQ+rx/MsuRm2Pb?=
 =?us-ascii?Q?fxb8BW6sFLtJcevryB4WNHU2ZGVLeMbCYuJQHi0EazRWhgrcCzto2RkiDps0?=
 =?us-ascii?Q?hqBdA04sThZBgqlIlHwbzeuVcLEXxPocmMZvTlIihmYG0+/ad3eDwK5N32Ro?=
 =?us-ascii?Q?WljjJXh5Jw62/GXksf8o19m3kl9VMqse3m4jqpLKWAYr0B6U7KrMXI8NK8KO?=
 =?us-ascii?Q?UGAIixfFpRq32IvwH102TJlYNXLlwvDF4gDn2a8oRkcDlAHgc26HVqyK8JQE?=
 =?us-ascii?Q?S4G8K7uW7FArQ3edSwrGk9KhdKLXAaKkrNB1EsnBEo4jUgqhqRDbUobOoYwh?=
 =?us-ascii?Q?sYLni6ZzpJRvK/MPPaXVKMmeUh61fwGr1asCRHPYvjGNi+f91JAGFN2DSwGn?=
 =?us-ascii?Q?fSMcEzgP8dMJ330ToJtCmnhalsAL6+e8lpp7Wp8w50I/0mQ+ObCO8ziId7EK?=
 =?us-ascii?Q?YC/C1b1NQwYWeUbtWD9uVgvmGJbPCLhg/0uqZAEwwrz85w81xzllJwWaxtZ7?=
 =?us-ascii?Q?4VWt1Acg0KeQLGlga8FCRFX7O/zIYQN+Kv20dBqoM/GFr17xngCGRS+Tr4N+?=
 =?us-ascii?Q?zAJaqSOAqcDSma7njq9SVky55/xpB6K8slFx3r63aJTlMz4Tp3BKJiUFnl9+?=
 =?us-ascii?Q?bVADetVgiFiHqs3oEAKlSKoVQ2uAxiZCVcnIo6nQ9pz9YtoTFUWGpixb2O3g?=
 =?us-ascii?Q?KBcOL0PB2oAXJh8xlvbBLoZONcDZOcqNPR44sNde+3V6y/aJXnjhGKxAQBl/?=
 =?us-ascii?Q?kFloD9BC47lus1CK+WU/+I5JZLE5ZBHYzUSYRd5Lvw6KsjC7S7RaViQgl1ay?=
 =?us-ascii?Q?Gi+bj916M5CYZXRwsz26ky5wpEkn8kc9+AQeMCYUGEmFwCWc2EJGC96qKmsq?=
 =?us-ascii?Q?9vQJC0kLkCfgRSVeRhhgcB/YKPXJ4JlVX/8+ypZwF3nxNmhb2VgBlEt6gPtU?=
 =?us-ascii?Q?LlehTSGM32UDtnJjoKRcK5J2ZfvLP721Ns76c33XK5Wi8SKQR2nszF0wCV9n?=
 =?us-ascii?Q?D1JNUVrAqU5k+fbW++47LhJ6P56bI64tdsQGfDUY23X9dwmYK1UJCwuw2ed1?=
 =?us-ascii?Q?pqvLLpYXarvSTwXUGKEKeToWLsB0XDc2Y1Ey3DEu2hqYXTz9GVBQOWtJhuar?=
 =?us-ascii?Q?igLOgsE/jvAOCqy/ZDoh4leSqJ5SJbk1PuABvsMUFlfLG+AIMFF7wgJQopFW?=
 =?us-ascii?Q?r8pddyQG99nK4poPrJsEkyftTPlQcP1s7V9oydtHxx8QPfeHqci40hDqUqsM?=
 =?us-ascii?Q?7A=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5764f144-5c9f-4841-282b-08da9028a1de
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2022 16:55:41.7003
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tGWQ9j4qbGzTZ0GBwOYrFA1zLu/4rAaARK9Z6M8ua5dHhM3OxIJ57xFp3RFAnhqeun8gbCrHuQ86PNCFxyDLxMoLLMRAUVBF9/ZwUHpVYRI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5078
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-06_09,2022-09-06_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209060078
X-Proofpoint-ORIG-GUID: MbAHUHoxDvfKdVyn4wFJ1bp98S_Px39z
X-Proofpoint-GUID: MbAHUHoxDvfKdVyn4wFJ1bp98S_Px39z
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
---
 include/linux/hugetlb.h | 9 +++++++--
 mm/migrate.c            | 2 +-
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 68177725a897..a218d33e518c 100644
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

