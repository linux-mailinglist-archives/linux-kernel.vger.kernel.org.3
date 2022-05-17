Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1E765295C8
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 02:07:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350591AbiEQAGS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 20:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236608AbiEQAFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 20:05:39 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC5B340E72
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 17:05:34 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24GKYMLv009889;
        Tue, 17 May 2022 00:05:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=uRpbEBZIV60lCtVKB/JGlQtUOB84/OYjiDQGJ/91v9A=;
 b=n9QMU4eJvecG4alSRmu0WflUmxXewn5D2yuJHW3Kxgep88m+1ZBbtQeJiVSqywE9wM6q
 hmAWFUw4evEqhsZ2RaU4hHKhsiKhaZGhPzBlmtG88EBFfLztfUwTwlYDK3JTphJF51MG
 L2TckVPwsk8qAnACRGeKvaN4h8F5gbpOitfd86FCGAkajtvKOtXZFEk1RZa3+DClNrDu
 iCb0UwOE+CvTTyOHHDd/BUol/A8OfxOPR7GZn45hpV1XVLHpbQyBgJuJw4shnp9KtjB+
 Whdh9a5dlWMNzELq3EZMz1A1sBbgRXStkSi2FFPGPXAPADQrKGSBfc/6aUjwP0QhJf2f 4g== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g2310mt9g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 May 2022 00:05:15 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24H01TS1016839;
        Tue, 17 May 2022 00:05:14 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2048.outbound.protection.outlook.com [104.47.51.48])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3g22v281au-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 May 2022 00:05:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n/BqmgM/qH1faNe/zO4TLFIrJWLhSllqNh8i5l8lwGOuyvowJsmLyyN69vBHgUdus8PISoU67bYFo2h6LsfI/SY2M1OgXuflUb5IIAN1hJOgtVdoFsK49vMLYT69UoZUSj3y7sqAcxAb0uHqn6pqc/UfjmxMTF04/4c4m8KayRPJAg4fi7pwrqLAGgTEedOACcvkTP7V4ZK8PalEvAxpF1hKRjJtkG3XwtWlKDui1CSURaHwTB/qRzVR7Xk1sMJXaazjwF6x0FGtmjnuGU9p2nHfhNau1OdQNKlKCk8xcuPLzXUyo0PwzhcrmSxh/yKYnk08eoEKCC9QjPInxcZ7uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uRpbEBZIV60lCtVKB/JGlQtUOB84/OYjiDQGJ/91v9A=;
 b=hlr8qeKtzZzwjzocrcDHK1YScPp5UALD1re5HSVzMNdPWBwYaJozeEUrIWgGalw9JetCS3A9Ft8uD1pZO6jdzHbUnUeyxDITV77uZG7oToswO8+dt+Zwxlbs9tjal/mTPRdFyXJCLU1gxx8wdD9fUrSqDZ5r+xeI4G9LQjFfFOtfs0Wtn/hF4U1XlFdk4kUGbNpjf4jISBJrkNPaS5q8WixEWXorZthSGtZWrEDgelIkSBDWHQDI1TmfSjx1r9hXOlOV866sz3Z0HbYGdYZe93DI6ZZbdUt9lhy6aTG5qqO2unbBKYS6kLNZWR2xEhB8RJunRCiTe+KoRnsKfrgZ3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uRpbEBZIV60lCtVKB/JGlQtUOB84/OYjiDQGJ/91v9A=;
 b=H1gXM1o5pkeUf88OHzYMQ+iZyrjW8NwggbTKN8vzNRqJ9+VdiVQXgv+BSa+Y4DH0SnoH+1EIhF9PQP9rsIrrYSHMVjJIG1o5fsU4OwKC0O4zfEXvGBkubmjm2jSPwV6LYrunzdtytjmxOfaj+xtrojeFJCkv+GRz4Vz09D/bzo4=
Received: from CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20)
 by CO6PR10MB5572.namprd10.prod.outlook.com (2603:10b6:303:147::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Tue, 17 May
 2022 00:05:12 +0000
Received: from CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::4421:897e:e867:679c]) by CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::4421:897e:e867:679c%7]) with mapi id 15.20.5250.018; Tue, 17 May 2022
 00:05:12 +0000
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
To:     Baoquan He <bhe@redhat.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        Dave Young <dyoung@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Stephen Brennan <stephen.s.brennan@oracle.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Bixuan Cui <cuibixuan@huawei.com>,
        David Vernet <void@manifault.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Sami Tolvanen <samitolvanen@google.com>
Subject: [PATCH 1/2] kallsyms: Move declarations to internal header
Date:   Mon, 16 May 2022 17:05:07 -0700
Message-Id: <20220517000508.777145-2-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220517000508.777145-1-stephen.s.brennan@oracle.com>
References: <20220517000508.777145-1-stephen.s.brennan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR03CA0022.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::32) To CH2PR10MB4166.namprd10.prod.outlook.com
 (2603:10b6:610:78::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1ea105ab-716d-4dfb-dc64-08da3798e9bc
X-MS-TrafficTypeDiagnostic: CO6PR10MB5572:EE_
X-Microsoft-Antispam-PRVS: <CO6PR10MB55729D3EB3A1855C6C5DEF68DBCE9@CO6PR10MB5572.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NO2AI1dba8Qmh6Ikbu+soTsIj+tzjc7GcAfBY8e6nPEEvyi1k2FRTIammE6GyxX/1tYK43L5fV1lmFknMNvrZVg5TSdz0RuDQfZgFg7qUXs8LNSSzdWO1AePfXVn40BOXkWA3watQir8K0+ECwg+WBTdjMLC2qDXIgDac1+5wXnlvmzGnynP0E/fZcSKWQpPHgUrbUoKo6tvyUItFeQ5ufRqC/y9kEm9CI33nDG3PFKdp8fnkylTm0EsW+LfP6z6bhSUNvd+4m91LcRwbOqPZZyQ6KR0x84+cGxFRXqJl/Uqkrsi62V9RGwZqTQ2auWTUNy+/GDmndMdsBhzyV9GifASPZNUHXyRzh2JblA74yvvDJMJWNEPf6NIUAxFJbafEHVXEF2OFZcsvwQCt8GNJPuUgD7fV0oEswdjIdaSc5fxBaK/PU+srCNGAoa8uDiH/CouMvkRKWFPjOr0cQ8tPOncxzdzFM0vGOZHlsi6bheNIdIbw0FwwkDyQJ0cN3HK7QeIAkxtDc31fiEA+SjxNuFBm5AK99PE8IocQFowjq/fFy6Q29GXWYjXOZYE+UfEWkbdEpcuDaQCrXWsPOkTW9VZHVeMkIbCZRigljwnvxjF48PaCarNmEAvIuhJHSGq1iKEnW06nGH7y5NeUacjiEpvD9ca91Ji2ymh231fg74/oH0tsT8lvCeDS403BAPCyPCOjvnXcj5wY5yTTf1Cmg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4166.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6512007)(66946007)(1076003)(2906002)(54906003)(186003)(6506007)(6916009)(26005)(103116003)(8936002)(508600001)(38350700002)(83380400001)(52116002)(7416002)(316002)(36756003)(5660300002)(2616005)(66476007)(6486002)(8676002)(4326008)(86362001)(6666004)(38100700002)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FtVwF8dKkzqqsFt9R5QBcYDizRHaDaHpwNfO1BLTT8tCYI1vMCWI7BQ1TbuO?=
 =?us-ascii?Q?7kZ1Eh4vtkNMzM0S5V9WFXmX9WS+yP6HRJsS5nm7bEGQqPCxp6cyTSjRC1n2?=
 =?us-ascii?Q?r3/ZDUHUjEUTum+e8pj0Kng3gBxPoE6XXZ3It7/6rITkV4F3qfhOG0qlOz0+?=
 =?us-ascii?Q?hAUn58I7u06b1jv9BWS9o3jVDwahpUoMQMFgXH9xmgZfauVIZL5bCdXFcNNr?=
 =?us-ascii?Q?eXlrG40RsUTGPWf9eLPXYEB7234ahQq6rifRgBLx/toY+hRtTrEi+zRKwr7L?=
 =?us-ascii?Q?yvs/MUuV22SqmNL4/Mp2NaPczDSRDl0xWO3qj4ibPyiqkRSKzf1dznGvbgaN?=
 =?us-ascii?Q?R7eMiz8fpcgF9WgOK2RDZUEJELv4v/jigrVpQDr8Z9iwKJrWO1+HpoHYjws6?=
 =?us-ascii?Q?xYCioAB74/sc5JLjJssUD7MStYxGanZFFF7pT6hLym/JfTtagSiKN5Uqmmyb?=
 =?us-ascii?Q?0Y5aJ+kY3DtiG7T8hJtcf7ml4SjERUpni/2rftaS7MTNL8cW9AoKKnk1342G?=
 =?us-ascii?Q?yVDfu1IGckzulD4H9xyzahTHQ3LKjBnhr5pLPHS7gZ8EfIlZeWw4kMy0HNnx?=
 =?us-ascii?Q?9kfH0rsAWoIQDaYg4pi+2zpFNN95CEPKwkya0iiVci11Gb4sR1GbjuuoK6VX?=
 =?us-ascii?Q?qK/iyHc18uARgVE0kBj+o/kSAIAwqRXdh2i+pEdI73UeL2NgiQ2gfUiJQTmP?=
 =?us-ascii?Q?Xh7u+thpY5MwO0yAdGdmB/2FboIOtEKLGgTyeTBv4hBmnd7ixNYQws+uPSYS?=
 =?us-ascii?Q?2sAKMF+98CRkg5Jbvz3AC0ABWErW/yVCh44mCGVRQCsMDwJPeH/luuBJvAHR?=
 =?us-ascii?Q?/KtGwyp6MxM93Xj6Xsb8d44DA09FXqrnLK2oPcMt6D2RhzJbPuk2YJu/RueF?=
 =?us-ascii?Q?qbMP8uTuzIudcEx5TrxCyjj01N0HDN1jhubQc5bm3vvcKZAhp2urIXs/Qunn?=
 =?us-ascii?Q?f9MG80a2XMIEQqFLBVqoZVF+/gKWo1ukRUK2dLZs7ZBPEuVZOxj6sg3Wf8eu?=
 =?us-ascii?Q?lbZ2vNpjqfQbtxtY+imWHKU9xfl05vzQHnybqGp6V6QiVPMR6Gndup360F9H?=
 =?us-ascii?Q?2ZqWb/z7UnX/eafMorqJRTnKoin23jDclpmMLvkczCTpKNW5tnVsSYKLuevb?=
 =?us-ascii?Q?yf69kQ09bRet2uONcGCZBItnfvTE9vJdzzP9cEj1POacBOYSDq8xiYLqP9P7?=
 =?us-ascii?Q?ohmPOAKvVNGcgnztSMGSQ1N614tpo9zv8qLQ/PJ3Y2iQJfyAIZ22NKRpVvBA?=
 =?us-ascii?Q?XonDqwyG9n1oNwJZFycm9ncBZIAPWd8TXhlOzg1y84Ax2Dse8AkIrxZ6Lj4X?=
 =?us-ascii?Q?OfUOR6oqTQOg3lnpdOCnRhuoXaDNEVCJw9X3q1fgbe3IQ85eYBq9U+8uIkPL?=
 =?us-ascii?Q?voW1GUPCswkLbmk8qk3LDVy3ZQajs3dinjlGIxOf5lFN6NMeltcijIF/9HXD?=
 =?us-ascii?Q?9ZqAy89zvAmuCswhpp0OsAtXrZASEua9EF0e9oph4arvd1G+NsZSyvLtxxeE?=
 =?us-ascii?Q?rCIkIuPYQFRZmMko9I106Y9FqBjHNw56njGo14YfWxILPNxuXKHOS8qszi7Z?=
 =?us-ascii?Q?kTJMJlLwT+uDNXqoArZOZZAUKcme9IVWxGWM6JhKhRfJhztzMdhe4gEkk+jw?=
 =?us-ascii?Q?ARvYV9VNcel4x8Wne6jhIKrBeIEtThZPJXLI/PLPh2tD9yBxClf+CNZniecY?=
 =?us-ascii?Q?zj6lbVATkc+zO+eGbyNcoFlm20IHRER7Sn3qwxxlbcDg9wGZ96x6hJJRZRqg?=
 =?us-ascii?Q?+zUgrfieA6PiPljPVlHSlM7byukwvrM=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ea105ab-716d-4dfb-dc64-08da3798e9bc
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4166.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2022 00:05:12.4246
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2iZKmM6LN2FaNQnwm612RUi3QTlp1chuAiQsi47MLkpkwnkonrlFzD2a+QySWmlaY8m9z42E3A3JUY4MlBuQYOwkpo6Mliv0occTVxVtStE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5572
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-16_16:2022-05-16,2022-05-16 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 suspectscore=0
 phishscore=0 bulkscore=0 adultscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205160132
X-Proofpoint-ORIG-GUID: -qJW2X2mFHIJFqAUFQZ55Iv02m1eOPgn
X-Proofpoint-GUID: -qJW2X2mFHIJFqAUFQZ55Iv02m1eOPgn
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To include kallsyms data in the vmcoreinfo note, we must make the symbol
declarations visible outside of kallsyms.c. Move these to a new internal
header file.

Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
---
 kernel/kallsyms.c          | 23 +----------------------
 kernel/kallsyms_internal.h | 30 ++++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+), 22 deletions(-)
 create mode 100644 kernel/kallsyms_internal.h

diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index 79f2eb617a62..42373ff69cac 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -30,28 +30,7 @@
 #include <linux/module.h>
 #include <linux/kernel.h>
 
-/*
- * These will be re-linked against their real values
- * during the second link stage.
- */
-extern const unsigned long kallsyms_addresses[] __weak;
-extern const int kallsyms_offsets[] __weak;
-extern const u8 kallsyms_names[] __weak;
-
-/*
- * Tell the compiler that the count isn't in the small data section if the arch
- * has one (eg: FRV).
- */
-extern const unsigned int kallsyms_num_syms
-__section(".rodata") __attribute__((weak));
-
-extern const unsigned long kallsyms_relative_base
-__section(".rodata") __attribute__((weak));
-
-extern const char kallsyms_token_table[] __weak;
-extern const u16 kallsyms_token_index[] __weak;
-
-extern const unsigned int kallsyms_markers[] __weak;
+#include "kallsyms_internal.h"
 
 /*
  * Expand a compressed symbol data into the resulting uncompressed string,
diff --git a/kernel/kallsyms_internal.h b/kernel/kallsyms_internal.h
new file mode 100644
index 000000000000..2d0c6f2f0243
--- /dev/null
+++ b/kernel/kallsyms_internal.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef LINUX_KALLSYMS_INTERNAL_H_
+#define LINUX_KALLSYMS_INTERNAL_H_
+
+#include <linux/types.h>
+
+/*
+ * These will be re-linked against their real values
+ * during the second link stage.
+ */
+extern const unsigned long kallsyms_addresses[] __weak;
+extern const int kallsyms_offsets[] __weak;
+extern const u8 kallsyms_names[] __weak;
+
+/*
+ * Tell the compiler that the count isn't in the small data section if the arch
+ * has one (eg: FRV).
+ */
+extern const unsigned int kallsyms_num_syms
+__section(".rodata") __attribute__((weak));
+
+extern const unsigned long kallsyms_relative_base
+__section(".rodata") __attribute__((weak));
+
+extern const char kallsyms_token_table[] __weak;
+extern const u16 kallsyms_token_index[] __weak;
+
+extern const unsigned int kallsyms_markers[] __weak;
+
+#endif // LINUX_KALLSYMS_INTERNAL_H_
-- 
2.30.2

