Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C6C25A575D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 01:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbiH2XBV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 19:01:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbiH2XBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 19:01:11 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28DA972FFB
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 16:01:07 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27TMDm2w013302;
        Mon, 29 Aug 2022 23:00:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=PcELQcEJ97DLVJYlsp1uCVAxLscIZ7YH5A97B+6O20I=;
 b=krGhVutIoVlX2hQJxG09NjXRxIVoAiXx/IRolDbrvF0lh1IYHK3knG4mfC1uTzEj1SSy
 zemlVMAGHuXg6IA7BTKse5bE9zxgCITl/ShlOkaLPZ/bWGsvgriZR5QQ72ngBfCUP3Q1
 XouuRIt3Fz5LVye1jzAcv3KRl0SoazqNm485W9wMulssHmmcpEpUwZDh27QQajH2eI81
 QixMvJDTMFr5IgtTvYQQ8blbK0LelheiyLkrywxDz+WfPUlqfJZYDtJzZ1/mps6XyOrg
 f1pjV9+Zs1NKAtNpghJWgOhB42hUt2nTkiuP1EigQ9K3nnt/IYQSnahqT4z189idhr7x wA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j7btt4s32-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Aug 2022 23:00:54 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27TKr2hP021257;
        Mon, 29 Aug 2022 23:00:53 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3j79q33mwp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Aug 2022 23:00:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WLoovgi/RglZV7gEGhr5erPMbawyZ4oRqTsIPSsFXFjWVP5RJI9+YmfIu2P0PLAt7DYclNh9UikpMdy2RpUhtzXDPbMCRU4x42DJT6flaJjwHM4Njg47qmosRNOLUBIcmOkD3dm14F3Lwwt6TgYAzrqW66WW1MUUBnevYxxJ63Fg+qZhTf0y+d9Wyv4D72nqmCw8Id2bS7irSNGZJD2ctid7SwFpTHFqtPGdrrJzTmdqoWga/ZFIqorCnwIcJVeLy5Qp9uKFucaoxboiagaI8sy7zmRss4tLL8Px/avQj78E1uZ0rjzq7pgbeW/MD7VbbeP73gErV1SvgDitA/RZBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PcELQcEJ97DLVJYlsp1uCVAxLscIZ7YH5A97B+6O20I=;
 b=MjnV+kfAThN0GWgNslwRVh4UR498f2+fddKA+aihai6cjB3ybgSya5Sz+ap7Q8B0A5Z/Ys7aOW+Tho5TqVrXampWKOrNGHd2CqjtXkrXdR7fnZwoQOtYWUSnzgE3RM1Ft3icx/5JNYSL9QJi1EcuQVnbO0+XS0L8lEEF8VFDAds7qFXpUKbPafT78pZifCxImKLkODFUySNDldwFT+jnpS7+WNiDhdWzTxdcUkCNz56O6qtwL6Nicf9LdFmALq9lRZwhBcgOwo3QAGrduk2AImhHnXWL+ve7XmIBZWNg84hXTxzZi3tE5aEQKAjjFZdMnKP2iBlAs20mzGTQvshY0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PcELQcEJ97DLVJYlsp1uCVAxLscIZ7YH5A97B+6O20I=;
 b=QGEctu17KSoB8t/v43JBMHYc89VG00iPs9WRdmFo3qK/EhhxrSroK9HV3g5GKbS0hRMf3FP4gI3LuRfWwQASxzrUiInyEwfZyzVipGGAls4qhqXKUfwHjoJhjHhE5tNinGwQKftQCTdAdc+p7bs7XbiP056AIjYqdj/KaUupQxU=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by BYAPR10MB3736.namprd10.prod.outlook.com (2603:10b6:a03:121::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.21; Mon, 29 Aug
 2022 23:00:48 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::e026:dd88:fe66:6ed3]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::e026:dd88:fe66:6ed3%4]) with mapi id 15.20.5566.021; Mon, 29 Aug 2022
 23:00:48 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, willy@infradead.org, vbabka@suse.cz,
        william.kucharski@oracle.com, dhowells@redhat.com,
        peterx@redhat.com, arnd@arndb.de, ccross@google.com,
        hughd@google.com, ebiederm@xmission.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH 2/7] mm: add private field of first tail to struct page and struct folio
Date:   Mon, 29 Aug 2022 16:00:09 -0700
Message-Id: <20220829230014.384722-3-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220829230014.384722-1-sidhartha.kumar@oracle.com>
References: <20220829230014.384722-1-sidhartha.kumar@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR01CA0049.prod.exchangelabs.com (2603:10b6:a03:94::26)
 To CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a154b1e6-e4f0-4604-a2f5-08da8a124fea
X-MS-TrafficTypeDiagnostic: BYAPR10MB3736:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9VRYWp36kdMLurGv78Z1h1fza8LouFfbXxBHklBzKYSLYk73bc8olUFMaLJxkhwOe6Ikqxxt1/GsUeA7pA2/KdnDfpQqgeuGzQuBYkuqf+6ZxDgFAxcHQaBKSlvSSgdGmeSZz4/kMO/JMLiH40WhC9P9Bujd1PDfNmW9NGXrnZ/hbwXscqFvXxKrrbR9PqnAqEYQK/gFXeruOnEZE1CUELMU2lBjcM6dOMpaTO9v+2f1LCYtD2dwSKOKN+h4AYvLQAjpoqBNtsnN1klM6lMp304MeJgdcgTi5mF4fRgwuo3/4Owtik8wl2hCtzEw2/EbwCh4cxXhpu/a5Gp/oA/tzmofhwxPQAslCzDeoXG7ZV4t0uD0yjs2+pOj8PQOl27iX9IkV+yTmrVhyAGZZ7KSc3zeeC6GUeAG0/+ksaWc7DrQSzwQ58EVWZVKaVzMewyg1Ja2llX/6UxrLzzslae1iatlAPCDiXcLTzOKN0ugcNEQKEEyt3b4lQvmkosEQo4qYNAJmzZcIxnopHDPMuK6r7clCwuDafmyMHo6tJqIGiE4FO7gWuFgjyet6X4bAMNrtEGrcvEOcrUzJWou/HpuTNomaFPhHhCFjTAlcoLRoROljfoWXDi7zbasOYn0uXu0iQLBpnjP3CFLYScgtDtZ2h6lmXF46YYtieUp3BZ4OfhpIwvfp/1cxvV72YIIJTGZmrUcHnUP85fQpaRkr4Rq0w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(366004)(346002)(136003)(376002)(39860400002)(83380400001)(5660300002)(86362001)(1076003)(2616005)(186003)(38100700002)(44832011)(36756003)(7416002)(66946007)(4326008)(8676002)(66556008)(66476007)(2906002)(6486002)(41300700001)(107886003)(8936002)(478600001)(6512007)(6666004)(6506007)(26005)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7naYemPqoh8GqbNLMgR9vTFESOQQahzbOtFeP4wA+a9T8HLTeQAfUgqJdij7?=
 =?us-ascii?Q?mumUZld7NQQe5WXD4UThqECdPUtsqYXliCCeTQb43nb+18SzWvh8zlVbceCF?=
 =?us-ascii?Q?zofoVyYQxhAzqiyxQ/FyHv3zkI64eSW1SK/1G5f+FPT09lKXZYT7+rP4j0Qf?=
 =?us-ascii?Q?SLdLgzsi5aHfSsg2m6XALeljOY9WNrHQXyx4Zmm6fn372mHVgnh4DD/ZptkC?=
 =?us-ascii?Q?5dgMOjNQLezDFiVL5xecTlHQKtc4DVv9PvT5/oJguXq79FstgOCeXX4dvBli?=
 =?us-ascii?Q?ldMT7zo/RgyRvf+CYQRtBC0jeJKAbhsYZBbHidsN6+dJSXsy3bvpi31LLoha?=
 =?us-ascii?Q?x0BZK/6t6HKlJ6iuKgfKLum+Sd+LbbYMergUD/dFIWFI3S9DsoLn6Qfr40CS?=
 =?us-ascii?Q?J1J0EkvBgL1IS4d+0z74uYkHS716sovUg3M9xi1FNDfjNTw/V7JCL1nG+oQn?=
 =?us-ascii?Q?SPnea2o/2bw/Gmg/9yuuSiCJlHx6b0k5WQo6dnEFtoJrMxsNHZ7/DfrLzDPW?=
 =?us-ascii?Q?NUxRTKQNsvKSybDGxIZDDNpsZICDGaBvJyK3gQDHcB+u66raWQYv6JgGLZv0?=
 =?us-ascii?Q?xHXrxb51qpfM8Hkpg/KYlw4MxsHAFPt8jLcsjE5cXdvTZKy1kzXlUmjhMGWe?=
 =?us-ascii?Q?IIgUZdcxYOsudP4pQgpaXIiG/IxGPIYkoKvL5PxuNlo1arWhDOVdHxBWfU87?=
 =?us-ascii?Q?oBfugu+iYDAEvC1fTivwnA+hcxcv0/NkNSJc/3KjgsKpdrxlIjpV8WT+pLwd?=
 =?us-ascii?Q?VWgQOdw0+NkCWcj440VTSyqPsdyq070xOXU2q2JZqgb5VZhdwSY5ALhb087o?=
 =?us-ascii?Q?XVIny7ouVsdcb5sSRcs5aKwXg522ODGndI57PyJPi5YoeX4pybA2R6yQRFL8?=
 =?us-ascii?Q?NFOKdvxPkkp5V4H/mYWk0p0GD+qocBKGa6FDftltrjMeFNHmopJ0iieOUnLd?=
 =?us-ascii?Q?KJbsDklxDx67auPeFwz1F6WIx4d0I6KeKkckkrD4PkfXOkZvDV+Pn+lE7K2T?=
 =?us-ascii?Q?yj03+40X7OPwkOktF55lipuiwv4s0df0APQCKAoPTHTuzYorkmJT3NeXL49K?=
 =?us-ascii?Q?IliuT7vVmOIxfmCttQMUzrOo3emYInWq8mWIc2Ju3UXloAlFSutl7hhIIH83?=
 =?us-ascii?Q?gg3vk4TCOSFfAaBUaPEDzDJ0lwaOwqxHxshdfOXoo7L7dvO64ohPf8pt8H2o?=
 =?us-ascii?Q?+pKlspx7E11COrfkF8HOL5iSI36pwxakKft+UuaZiBDSsBt8IN6m0KsNnxsw?=
 =?us-ascii?Q?I2xFurl8EdbHJUM9WTwJ26TN7KaZsrHJNrhd7r23lNT5ozsTfXIHOIua/jej?=
 =?us-ascii?Q?YjAmnGDEijmH2PO0ILmoDeDx0Jgl3qf12nEXHKsTbxE49Rdz5iAkHLyrl9qR?=
 =?us-ascii?Q?dsF9zK2S3a4jAjmKssIWtAp0X7DPTpYMpfRUJ42eQk+TlTtDbfZsCu1IucVY?=
 =?us-ascii?Q?zdLnSjehTX9ixNT3FUBHFnr3kORsf7FXZuBrV6djz7K0nEZTECCu8eYuEGrN?=
 =?us-ascii?Q?jiD3eclzAR6E/G09CZ7WbB14Rw9T5G0qLRi+QxrlEvqsBxJKuGH+3lfzs9Rr?=
 =?us-ascii?Q?uq5SQP3hl/JgE03Y94RuIkCnaH2+0laXqMuALvRQ1CB6qUxOPA+PWMPSAy8y?=
 =?us-ascii?Q?qg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a154b1e6-e4f0-4604-a2f5-08da8a124fea
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2022 23:00:48.2417
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WWGNNWuJZgxUakLkc6QdS725Y1dAiPbwuZqm0YuPYPsFeQ/knLjVBBsQ/RnU67vPHWnBx5E0fK2JZgubTw9QoYlQpqG/uE0NMvTubqBk9W8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3736
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-29_11,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 malwarescore=0
 suspectscore=0 spamscore=0 adultscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208290101
X-Proofpoint-ORIG-GUID: KQJrvUl2luR0B9OAojGzTamAzui-Qp5w
X-Proofpoint-GUID: KQJrvUl2luR0B9OAojGzTamAzui-Qp5w
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allows struct folio to store hugetlb metadata that is contained in the
private field of the first tail page.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 include/linux/mm_types.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 8a9ee9d24973..726c5304172c 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -144,6 +144,7 @@ struct page {
 #ifdef CONFIG_64BIT
 			unsigned int compound_nr; /* 1 << compound_order */
 #endif
+			unsigned long _private_1;
 		};
 		struct {	/* Second tail page of compound page */
 			unsigned long _compound_pad_1;	/* compound_head */
@@ -251,6 +252,7 @@ struct page {
  * @_total_mapcount: Do not use directly, call folio_entire_mapcount().
  * @_pincount: Do not use directly, call folio_maybe_dma_pinned().
  * @_folio_nr_pages: Do not use directly, call folio_nr_pages().
+ * @_private_1: Do not use directly, call folio_get_private_1().
  *
  * A folio is a physically, virtually and logically contiguous set
  * of bytes.  It is a power-of-two in size, and it is aligned to that
@@ -298,6 +300,8 @@ struct folio {
 #ifdef CONFIG_64BIT
 	unsigned int _folio_nr_pages;
 #endif
+	unsigned long _private_1;
+
 };
 
 #define FOLIO_MATCH(pg, fl)						\
@@ -325,6 +329,7 @@ FOLIO_MATCH(compound_mapcount, _total_mapcount);
 FOLIO_MATCH(compound_pincount, _pincount);
 #ifdef CONFIG_64BIT
 FOLIO_MATCH(compound_nr, _folio_nr_pages);
+FOLIO_MATCH(_private_1, _private_1);
 #endif
 #undef FOLIO_MATCH
 
@@ -370,6 +375,16 @@ static inline void *folio_get_private(struct folio *folio)
 	return folio->private;
 }
 
+static inline void folio_set_private_1(struct folio *folio, unsigned long private)
+{
+	folio->_private_1 = private;
+}
+
+static inline unsigned long folio_get_private_1(struct folio *folio)
+{
+	return folio->_private_1;
+}
+
 struct page_frag_cache {
 	void * va;
 #if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
-- 
2.31.1

