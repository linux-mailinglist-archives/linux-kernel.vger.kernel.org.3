Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C91953F06D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 22:46:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234254AbiFFUo4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 16:44:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234265AbiFFUoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 16:44:17 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B247012FEDC
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 13:39:23 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 256KJjq1030073;
        Mon, 6 Jun 2022 20:39:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=P0ccEylMYeesKNW22zmkv64iuKviZD4DB7kgxwKe7f0=;
 b=A0VOplnIDZcaAiDsGAaDKnPJ+tI9pjVoUxpiyPxVDI9vabpufutAq6n4S9dnVAPXzpa3
 S7PsiFMT5cN6jcFcr7xRSZ030LApIsjfrRnk2EKddGPzBQUpna3Iyj5jtyaW8wpjdosW
 HBUhjohxjL70vt8yTzBx8nvMiR/L0sHqKNpn0zDbzvgpjJI4TKRh/WE3xbZ7JQCELzH/
 cR3aPXEh6cFR0wlH3jWvEXcwXmEr7LjoTTSka/lrsIgYIBlRZ1NZF5258B00ts/Hkyet
 RfS41WVS61Ie2FQwcLm88+6w5Em8Kdd8lTEee/rDLkkXdiVEahqO2HZ//NpiZTjng1sl OA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ghqad85se-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Jun 2022 20:39:02 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 256KFlFf015993;
        Mon, 6 Jun 2022 20:39:01 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2106.outbound.protection.outlook.com [104.47.55.106])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gfwu80abu-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Jun 2022 20:39:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PwOmQ09qSRCdzkgXz/Xbya1/bRW/0qkN640dZykX6qvtn10UFuVPCzsalHvmYvIjb84V7sVU+GyFTlkBlVoBG4Xi24L70g6yzNQRox859lehBQMZ7StMewOr4gN+tWO5JWDxz/D5aC6b4i9dIa8pOiaQPTZ9kldlCioZjwnPT3vLZcO0ksVp9pziotZqc4WsRxZyPzIwIxJeEBdfKk4i+rSRZwgHLsZUB8hQfprJK3D5TVEgX+YFSgn2b/c+MKpC/eq+XCxrZHfUhgNUjV6hAM3+RdABECYH4HqOFZoVSqepOOLXwfN0K7g5/GR3/wpCIoeh5ePT9uocrM2OfKVeiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P0ccEylMYeesKNW22zmkv64iuKviZD4DB7kgxwKe7f0=;
 b=e0cjJDbMUoFf6O1TmcWHXN0uM66myszYV+d57QZmGxzHTMQk8lIh/VGYJgMLBBOrfc/rlvpi4/DwDWtlMg/mpuOzt/qAPTdcbnYM1U3NYRagcOVkrw9ZDXF1XcqzcRxvGICz8rRu49roTOQAAloGlFvQCMrb9cZ05kQbfWwJtjDYScGWQEBwESK9VhJvle6W3THklTk6J/Z6YnXyxiqzj2n0KQvws9+JlWlmRdOGGNC/hc0iNxY1I81YdJqqUAu6Fp89aBOhzHo/OPo19GhXf/VqejUcwVD2iLWtjw6eR5n0jbipLiN5/AblrkAZ/HLriISZYuERTBpO8T7WFS7fuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P0ccEylMYeesKNW22zmkv64iuKviZD4DB7kgxwKe7f0=;
 b=WRdnMF3vN4S459GfUb+YTggn3ASvGpXU9U9o5ERZiErZzdxQAgfkV7pQZQ6pbIAeIuNrJtQa1mQwUZDK2euwztdrdcjcoWhqEW+4R+go8R6oGu8yh9Qk52i+NoyDeipJYazVG4mIYrgrnFmdS4b7TrM3aF4Zwv/Kg1r9PCQ+Gmg=
Received: from DM8PR10MB5416.namprd10.prod.outlook.com (2603:10b6:8:3f::19) by
 SN6PR10MB2734.namprd10.prod.outlook.com (2603:10b6:805:41::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5314.12; Mon, 6 Jun 2022 20:38:59 +0000
Received: from DM8PR10MB5416.namprd10.prod.outlook.com
 ([fe80::49dc:6a95:a2d5:fc08]) by DM8PR10MB5416.namprd10.prod.outlook.com
 ([fe80::49dc:6a95:a2d5:fc08%5]) with mapi id 15.20.5314.018; Mon, 6 Jun 2022
 20:38:59 +0000
From:   Ankur Arora <ankur.a.arora@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        mike.kravetz@oracle.com, mingo@kernel.org, luto@kernel.org,
        tglx@linutronix.de, bp@alien8.de, peterz@infradead.org,
        ak@linux.intel.com, arnd@arndb.de, jgg@nvidia.com,
        jon.grimm@amd.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com, joao.m.martins@oracle.com,
        ankur.a.arora@oracle.com
Subject: [PATCH v3 18/21] gup: add FOLL_HINT_BULK, FAULT_FLAG_NON_CACHING
Date:   Mon,  6 Jun 2022 20:37:22 +0000
Message-Id: <20220606203725.1313715-14-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220606202109.1306034-1-ankur.a.arora@oracle.com>
References: <20220606202109.1306034-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA0PR11CA0141.namprd11.prod.outlook.com
 (2603:10b6:806:131::26) To DM8PR10MB5416.namprd10.prod.outlook.com
 (2603:10b6:8:3f::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ba9328a4-7a66-40ea-fa45-08da47fc959b
X-MS-TrafficTypeDiagnostic: SN6PR10MB2734:EE_
X-Microsoft-Antispam-PRVS: <SN6PR10MB2734D6178330930B5009F040CEA29@SN6PR10MB2734.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pMu3vvOQlB46mixzUtWPM60u+rNpjVxclunPIAiX2/V4fOjIusKZ8FMt8THOuqbSD2DekJM/QqkXvjcrkwPr2EkgU8LCLRt3cQeOWgA64oHVGJTKjZXx4VTzDs1R5XsPu/ZW5tLj78yjczUPakeqiHbyST2/VZPJ15o5oACQdiShf4p/AosfiPQV5dHWKB5LHXyKDRCsYF7eVuUvU4lkYzu0GS+PNZ8Aljch6sWXf7gD7gkI3tmxvsEhDioJ8G3cktKrV/H5To7Cv4wjzlibs2S11FKi15N06eXHfcGEo7eCl98R+hBYYqsyGEIKDKH/75iO0C/BwR8EUuPgaP0IrS4bYlxCblq116d20KSytdn7AHYrXgPauO0sarnFSSWdfxNyIO575PhgOLD8ANeqYubQgq4Twf27GnYgq1Eetwce9qFB74L72ENI8U03sLiNX+S8eVg3HYPla6GHJawmbSzJlu7XdEWUfJwzoglTHsCT0baimFXLDf2+wGfCJMSbxoXWPeqB+g/F1zDRZKjb57WC+8onwMwLBcokQxff5taGERnALogaBQ4YazuG0I6vMR0Ps8tksPfpIbRxksKVpJgC1/x/TipurbyzRO3KwbVKiijdyZZFhSUV8orIto7XCxYkN2ifB3120W87+8ePP7u1wvTeHX4fZ2LfX5rX29Q7LB08vYRwgEBMIPaUfvVLkpWySYqV7JEGdXWfGrYyng==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR10MB5416.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(83380400001)(52116002)(4326008)(2906002)(6506007)(1076003)(8676002)(186003)(508600001)(38100700002)(38350700002)(86362001)(6486002)(2616005)(103116003)(6666004)(66556008)(36756003)(107886003)(7416002)(6512007)(26005)(316002)(5660300002)(66946007)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sGs/jAxV3ojkVqAYaZtES/dfk/cL36qWEOBJy8yOtEM1H7Rx//y3MTK4nUEQ?=
 =?us-ascii?Q?gQJJzxx6xUefMa2BLDNo09w+WvWQWnMUuyhpWj1HkZewhvrCaDVO7SVQYj1b?=
 =?us-ascii?Q?AoJ2jjY30/szZGXFLbghUFUbZ5HdnCZR9LpP3331KdgioYNJdVCpar/9gTvG?=
 =?us-ascii?Q?DVlpPIkaiA2/OaRaX9kA8uyCyEwalr2rEah5JZGFm0M07ix0rrNBI0HI9g2m?=
 =?us-ascii?Q?g8PafJOtrHyP85KmTpo+s8iG9r9hLyb7PRtbmS5Lgh5WYbNE2KFJPR+mWswP?=
 =?us-ascii?Q?lHDnUKugJU0gs0DHj1ZeSwyXdJ1tctkLY9SrNqd4Hy85UcytPyNxHL3U+9b3?=
 =?us-ascii?Q?rqtovnbUbtDMY9BvJsjXB99Quk8Oj0/RjWUKx0lOR52kIU0opeK7CoifmwpL?=
 =?us-ascii?Q?wLiQZG9azMLLa9Tk7+Oyz8sLV0QIO3C7ZcEE2nkqDX3lCETO9dQ0CRgtJ+h9?=
 =?us-ascii?Q?f5B+uzXIOAMKZixoACPYhMzk7BmMZfM3kTC2d7Jc1u/ClX+Fr/mmoxcBscAg?=
 =?us-ascii?Q?/Qil0Xxzf0PvV7rWM5HOcFdFOIzxyTFKeUGUHS5rlp9Dj9ReN5B2PFmz4XW0?=
 =?us-ascii?Q?zwuUfT9FoPnTuaoewXa3v47ckUyYnkZjibww/qFS51/3kSCQRaBjOJO828ZK?=
 =?us-ascii?Q?ruPAXY+VM15xHHNvrS1u0tjUBzczUwdd7Edwcr9+hUuHl32Q2vd/FSpWi3iu?=
 =?us-ascii?Q?AodLVdotpTDjSfYDSstM0XJKtk3jS3W5RrJvFbZKfg7ouwE/JSITke8+TZNb?=
 =?us-ascii?Q?ebyc1rAph1wCovjB/jmb7bPMvVHHJrrH1v/thZKqQdRJ6MgYJYmSN2bHkoQA?=
 =?us-ascii?Q?0l9J7HSKaOa/8MhIwfh1DcLxC3RYDj9XqrVCXBQmRwKlzeqfNBNSp0vsjGIs?=
 =?us-ascii?Q?FOPqLHV0exj1CvPR4ocPcDc8JwY8skfohYzg9p4q2CLPTsfaK1paSOI7O/l9?=
 =?us-ascii?Q?Zr4RJ7vWLuKRe34QlTRep1VSOjCAVuM27gdIflMAWT6JISRGJKRTfL+2D1hB?=
 =?us-ascii?Q?GMQH/oZeQq1l7UWf7lyGD1p1L9qgIF9fW0ZvV2QVmhtibpVoh6h/z7xU77cf?=
 =?us-ascii?Q?jxiwYDh7/CdOzqApqc6z0oxtql81SUIsuzLpqp0KRvTNiibeiOLs5nzdfosb?=
 =?us-ascii?Q?BMeNsLitBdJpWTquJO9cCSoyJI/4jnjvUhbt8zK9iK7AkXfnejHAC4hvGOIG?=
 =?us-ascii?Q?KIRghXlL6WTUvEfJgU4fZx2l/OovMhmcrhSTelvPMjo1Ibx4CF1U7phVY7RZ?=
 =?us-ascii?Q?/bXanB5ezaBqzCditoy2PI3cAjdPYpfN5a1+u0YxxqBXKsx25Ahfn6E0/dya?=
 =?us-ascii?Q?G5qmoVQCBcjA5Fkg7N4Wt7lS1A7Rlj32e+dPvheK2BGLcXNCp5ArQpaihknP?=
 =?us-ascii?Q?eQfKtpdlq8Tv21nneiVvswHtj+9wvwcputxssZDdh8/1kBXpd/JjLy2iYqMl?=
 =?us-ascii?Q?lCg5F0XtjG/hCYoZFkQqbrxXUgf9AejhqiiyljGWsL2UBXxN4y8VxeOz+5AF?=
 =?us-ascii?Q?1r6KPURnVWmrQe/8QWtcsmJj1mAW9HYsJhbNMgkA1TJTYSsvDbm3j1iNTD05?=
 =?us-ascii?Q?JO73Ek0SwcPYfVb7Cynd7yhkiHjotx9uqMsgxQMf1MG6GTlmqVvIvPUffyde?=
 =?us-ascii?Q?Yf5GZaduYVhD92/5fT86cOb56u5Mjmq/sNMg1PwefqOF7dElvxJxSwqpQ0gI?=
 =?us-ascii?Q?y6HXJarZdegZqJ9Gj331NWxWd7thit6XBEwnvCeou22QLwctJfqfovXUD5QW?=
 =?us-ascii?Q?T6cKUgFtWGxFJ31uxvkI95+4BRsjSb0=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba9328a4-7a66-40ea-fa45-08da47fc959b
X-MS-Exchange-CrossTenant-AuthSource: DM8PR10MB5416.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2022 20:38:59.4641
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JTkTZWdsZjdi7WP0GZbdkyhnfc/dGm4+J2+1utK8o5QXGRirzaSpIC2DSSRxTwz0D1cy97iy42sD5THZ5d/IwDVhGbQZWJlPkkwZx09Tr/I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2734
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-06_06:2022-06-02,2022-06-06 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 adultscore=0 bulkscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206060081
X-Proofpoint-ORIG-GUID: rqMvZUQdfD8H74o1BQKPC9mDUMqsqEkV
X-Proofpoint-GUID: rqMvZUQdfD8H74o1BQKPC9mDUMqsqEkV
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add FOLL_HINT_BULK, which callers of get_user_pages(), pin_user_pages()
can use to signal that this call is one of many, allowing
get_user_pages() to optimize accordingly.

Additionally, add FAULT_FLAG_NON_CACHING, which in the fault handling
path signals that the underlying logic can use non-caching primitives.
This is a possible optimization for FOLL_HINT_BULK calls.

Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 include/linux/mm.h       | 1 +
 include/linux/mm_types.h | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index a9b0c1889348..dbd8b7344dfc 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2941,6 +2941,7 @@ struct page *follow_page(struct vm_area_struct *vma, unsigned long address,
 #define FOLL_SPLIT_PMD	0x20000	/* split huge pmd before returning */
 #define FOLL_PIN	0x40000	/* pages must be released via unpin_user_page */
 #define FOLL_FAST_ONLY	0x80000	/* gup_fast: prevent fall-back to slow gup */
+#define FOLL_HINT_BULK	0x100000 /* part of a larger extent being gup'd */
 
 /*
  * FOLL_PIN and FOLL_LONGTERM may be used in various combinations with each
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index b34ff2cdbc4f..287b3018c14d 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -824,6 +824,7 @@ typedef struct {
  *                      mapped R/O.
  * @FAULT_FLAG_ORIG_PTE_VALID: whether the fault has vmf->orig_pte cached.
  *                        We should only access orig_pte if this flag set.
+ * @FAULT_FLAG_NON_CACHING: Avoid polluting the cache if possible.
  *
  * About @FAULT_FLAG_ALLOW_RETRY and @FAULT_FLAG_TRIED: we can specify
  * whether we would allow page faults to retry by specifying these two
@@ -861,6 +862,7 @@ enum fault_flag {
 	FAULT_FLAG_INTERRUPTIBLE =	1 << 9,
 	FAULT_FLAG_UNSHARE =		1 << 10,
 	FAULT_FLAG_ORIG_PTE_VALID =	1 << 11,
+	FAULT_FLAG_NON_CACHING =	1 << 12,
 };
 
 typedef unsigned int __bitwise zap_flags_t;
-- 
2.31.1

