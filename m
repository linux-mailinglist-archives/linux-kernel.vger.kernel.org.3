Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CD7C53F076
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 22:47:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234426AbiFFUqi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 16:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234422AbiFFUoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 16:44:02 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B96912718C
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 13:39:08 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 256KC7oI032448;
        Mon, 6 Jun 2022 20:38:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=TEZNavbdfxj4wE2bNU4KqeGyaSH1Z903EFnUKJBx+B4=;
 b=sf8L2jPN0S+qcGllsHo55AVeANBqjQC5Q48G9fkQtbQI2IR9KyFH0GcYu654peq00Ctd
 mUMvzXYX25e7onDYvk2hIwfMMcFKYQXMaLkesHmuL6kNo88vPSO9qkhwVo4lEI0E2ZQi
 5RraKegRbBGwna20VjoKLGnO/yC+yNh8/LCkZg9PXcxmGO7KfeEHbgu4OIkZY4rncWYr
 Qu17QDVFGULEo73tYoC7gMdfy7Nx9ImzGzHSf1EnQdepiiWl5bIO7UiD8RIVRMnL7lgs
 1CdRqyh0cZIVKq64exhifKGWQxiucNQjJyu8XJf+2wUhNV6ReHCRZFwsBiRhEkoR5TbG nw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ghexe9gfq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Jun 2022 20:38:45 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 256KFBbL001327;
        Mon, 6 Jun 2022 20:38:44 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2104.outbound.protection.outlook.com [104.47.55.104])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gfwu91cv3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Jun 2022 20:38:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cD3IRHRoI4wKMmegAhx/yZE0QjkKLxSzGk7dUJ+5Ml8FgsboM5aW7SSPD6AO/AIndyVL4twTFOq5yGBv3nMNY5hIvSBSTYQrhMwgrQzCVfZupbEp+oIut0hClntgBkF9yq8ylihNBVs4vwY3SnjIiv+io/WDGV4hmn0M3jEzJQeFh3v6kJxfXMgfJ/ilF/1SRY+deeDlUoJUqxfI24swgOhwy9wVkofbx8Rxp13kT6vZp8ghlbV9pTMvBQEW4QCVH8OBxKD89Dt84agyQULF71rT3YUijgQ086WYIBQXA3RZlYgc3LDj4t8v/+NwoQtuHXBH5jxUPjlrsNXn0nDffw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TEZNavbdfxj4wE2bNU4KqeGyaSH1Z903EFnUKJBx+B4=;
 b=bEGY+LLjovOnM/8sIt/pas3QWdarhy/EyZ+K5unMz3ehaJrjoGA9TlSXIGPYeWS1441wBeut/5PrUBZ9awFri2vTxDUQb2/AfjEfOnUOh/LOadgNm8LjaffV3l4/FPqJrIWnWoHQ96CiIp/rwY4ZJa2Ek+1EgvzktyOsXPjBAW8Dff+3cjDPcgF+dhn10mQuOl2QyIiLJ2eeb9RqLzn87NWl2q9yQVkZHUqTCCgb6Dic2bHwgy+SnkuPcrCqz3Kgg5N+jXG0+AvyepLNQPL/aX7BY5ZePAlZeJCm0ESRdcA3EuwOiTh7oqedo/PEMGe5UW98Wj/whEEiUUPe1OuyqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TEZNavbdfxj4wE2bNU4KqeGyaSH1Z903EFnUKJBx+B4=;
 b=a45EdSDh0pZXgt5jaG5yKucGm2VLPTjFRWC1i6UZo+RdDZC8BUQIkvoVnkCsYEuWj2cq8n7tMddVweAi0gn5oouuTObPG2YEn9RAV02GlkhSZP10SSyh27SQ0G17tyeC7Sks167tGqFFvISV7+Wg1C1VaVwU264JOMe5bCk0IYc=
Received: from DM8PR10MB5416.namprd10.prod.outlook.com (2603:10b6:8:3f::19) by
 SN6PR10MB2734.namprd10.prod.outlook.com (2603:10b6:805:41::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5314.12; Mon, 6 Jun 2022 20:38:42 +0000
Received: from DM8PR10MB5416.namprd10.prod.outlook.com
 ([fe80::49dc:6a95:a2d5:fc08]) by DM8PR10MB5416.namprd10.prod.outlook.com
 ([fe80::49dc:6a95:a2d5:fc08%5]) with mapi id 15.20.5314.018; Mon, 6 Jun 2022
 20:38:42 +0000
From:   Ankur Arora <ankur.a.arora@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        mike.kravetz@oracle.com, mingo@kernel.org, luto@kernel.org,
        tglx@linutronix.de, bp@alien8.de, peterz@infradead.org,
        ak@linux.intel.com, arnd@arndb.de, jgg@nvidia.com,
        jon.grimm@amd.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com, joao.m.martins@oracle.com,
        ankur.a.arora@oracle.com
Subject: [PATCH v3 15/21] mm/clear_page: add clear_page_non_caching_threshold()
Date:   Mon,  6 Jun 2022 20:37:19 +0000
Message-Id: <20220606203725.1313715-11-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220606202109.1306034-1-ankur.a.arora@oracle.com>
References: <20220606202109.1306034-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR01CA0016.prod.exchangelabs.com (2603:10b6:a02:80::29)
 To DM8PR10MB5416.namprd10.prod.outlook.com (2603:10b6:8:3f::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4d5116e2-1d14-4430-1031-08da47fc8b80
X-MS-TrafficTypeDiagnostic: SN6PR10MB2734:EE_
X-Microsoft-Antispam-PRVS: <SN6PR10MB2734AEE4B8F758502A3E9C68CEA29@SN6PR10MB2734.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YzsBHFeVXkvQRRmznNMBorsNgAIPb6kSSJQGxZqUkmRXY26Dqni/YK+QLIxfZXc9sclvkEuMRdd9hX8/8ddVM3DnZLyQVl/NjCu6HMZmQ/gavPdpgtnXeN3ZF8vQq29nxn1X2eOIsiFdVaQm7VWArXv5BbiVf85++t4Q5MfT6sZev47z7BpBgjhcHLC7oqc09nIw5M5UJGvSuzNxvtVImbptyOS/BJOJzIk8vh/TF1t5S9IKL8ub8a9yaBwwCg51bOALsCecth9LHT/SuSEfow1XATz/rd7BGVv6qLFPeVqVG/WJRc8D75GSXvcIBSgYwnEF2FW318nbfNYRqU5NqPHhdF/LNR5DOuW+OnTJP/s2ahTmIbDAbtN4S09kF6iXNovV3DpBZkG6ILnU8eeqmgAw6Xa34wxY1PnRHn6SYkrXCetcacwAySwz77/uGUqUWqGa4/0tE/PIl+J1wCl4iS1GHCRw0WvH+dxQlAbaz2RAHhhte1k9DgZuSeLIRTyFooSH/UQoaNBp0XKIwjBZBXz7HfFgkRXwGRJ5gPgU5X0cUJr+T6f+gDm4/+x9p9XOm161TIMnSnnBCnrw9ZzdaFSTemPMBdj/wiVIaMb1yRFGPKMIG58uYZbTV/Hoig6Kap6pcpY4Jzwtkj9Zjh2hWu7F55Az2axJdyakXgvOJiGmry0byjdqK7GuT6wulw3mdPYJ7gTKXSxmaB26ThD2nw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR10MB5416.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(83380400001)(52116002)(4326008)(2906002)(6506007)(1076003)(8676002)(186003)(508600001)(38100700002)(38350700002)(86362001)(6486002)(2616005)(103116003)(6666004)(66556008)(36756003)(107886003)(7416002)(6512007)(26005)(316002)(5660300002)(66946007)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QoJeFBYdwr+6StVXjjP+05MLL/ah1YBFGVZtJ+d1l38tRYYCb4myENnmq/EQ?=
 =?us-ascii?Q?SlizsCs9m1ulgB/4ulAKKrHHgA40jTqZQXamdJC/LWEu7bKzhnAtH+cz5+8b?=
 =?us-ascii?Q?DqxwOinKqesde9jycwFgfIPE7q87WQpBbsHFP8U1RRHqbTjIXhvN1k08UEXd?=
 =?us-ascii?Q?QD7oY32YBqbgLiqGM4kwdB4LmCQaHqi2qRuvniM2govKNmSqYABHK9Y6Pqa9?=
 =?us-ascii?Q?baTut4oT8swe0Dt1+pOxwWIVP0MeXr5QXiQP1BhY6uqF5F3vzJbOKFa2PLYx?=
 =?us-ascii?Q?/QFsZc3E8+MCGuhUGhKRl66OP7Fh0sg+LRsPGsqLyobj7XO32XOoJ01xzCQF?=
 =?us-ascii?Q?1VFoKp5wOqDDKTf6uWAFG1VHN3Rj2dC1zF/1eoc3zTeqtWwD8ZLF6wyL9BKT?=
 =?us-ascii?Q?lFEkZbTyHmY6lJ7K5/vPtMND0dSRPtYTB8+etS+se2fiSKZNbcJSpHn9V/Se?=
 =?us-ascii?Q?pC1olRK6q9KZ8GC2PHDYC/h3dAAApUCjxH1HOYDvm9ZNSO4N4mlYKHdowI3S?=
 =?us-ascii?Q?1k6bUJpYmbDDeCzk8EwcVccqQ1iEbDI7yhqvUkagrWeb9q5KxftQraJbyrRb?=
 =?us-ascii?Q?MqGXZ+VuLV2PxdmVkphgrknVG6+8r2KF51nbaRj/iIaRrqJYsoJt/YdRoVYu?=
 =?us-ascii?Q?A8058oDTMg06R4VKFhuoTM2jPhBaP0Ma2iNtMoymBGM0pmAUzOTsZz5CW2+R?=
 =?us-ascii?Q?L9rt13U1R66p9ok94YIydeK839OIhX7o1ADaLodv/JuJ8lcoLW8mL39x7glJ?=
 =?us-ascii?Q?DlU9+925vBd3IBlljXfchpFs7fDA+9xaRdR2hPITjVFDiCtm/NX4vezXrSJL?=
 =?us-ascii?Q?ZdNm6mJiRsSy8kYsXa4A0W4mEgt1S1/XXDS9E4sAk5lDAF16eG0xbxKsjyJH?=
 =?us-ascii?Q?MkP7zPdfHS9CqLHCwY52pxfRfQl6C6JFZm7Vq21FvJx7/KAhcvRw7KNj4eE5?=
 =?us-ascii?Q?0xoFIvI+Gxr8kd2Pp9gAGsm2/3KSy2+1vIZe/m0o5EywWODaONMDUaA7bbfN?=
 =?us-ascii?Q?V89P/IpQXmloYAj8eR3+b1kvNcuvnK+VYK9TqFCkakqxqyMZVSX6N9UrnP9s?=
 =?us-ascii?Q?ta7boCaZQzD2D0wloDoB703Qw+Q0+Q7EgQcM+XnbUBfbyr/8ujVOFqxi/x1d?=
 =?us-ascii?Q?VnQTrPli3kp4eNvWjgrLo3yu80nANVsB9tO9mY1vOBxqF+b8uWix8F7mroIG?=
 =?us-ascii?Q?NBkTz/T4amoF0Dv155pXVn5YEfzg1+gMUu4Auedn4WVe+l5umbvqr0k+pcgv?=
 =?us-ascii?Q?DHWD7zic68MHnnRPH7EDQ7n7w7QtExZUrO/3tiY5TzR0TwhqOOYtBPxbEXus?=
 =?us-ascii?Q?3l1kYNYkoiyuHn8YRBwE43xArcQ2RE48TBZwTDEIAAuefeXWr/JaL1+r2nCK?=
 =?us-ascii?Q?suRQpncsmDarCm8I7T3CQCHiISE8ofqGCY4r5VANANxaLX9MdmvhqGLxiPeD?=
 =?us-ascii?Q?r/U3XRpOy/gRL68Scyu0bcSw1ccL5Y0MOWHK9jfvsRp6r+efRdikgOVehxav?=
 =?us-ascii?Q?KqFJ3skL0zfEHnBYnC/kyM/qWYGBiTFZUQie/ugtuzZI1ZgWSvALqslDitFP?=
 =?us-ascii?Q?KN/CiKhkX+uZD9aDRsurmJVe1TGiLlPOO5+TY8ukNGbf3oxBjc5gkqx7MJ+f?=
 =?us-ascii?Q?mtLOcQO/qiqLZ4QlEZA+hb/n/iuEjdrnl/9Uti3pMaLlITx1HWJHdVoAkUYg?=
 =?us-ascii?Q?lxJzdOQ40HccRJir8qtobqTNeDD29PEd63bytlWadYoZl9akSh93p98Tqiri?=
 =?us-ascii?Q?V4mYMOBb4R9m66G6wDqSZBNzwIyX5KA=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d5116e2-1d14-4430-1031-08da47fc8b80
X-MS-Exchange-CrossTenant-AuthSource: DM8PR10MB5416.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2022 20:38:42.5352
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FWb+RWeYbgDQnonL6o4cNdq8JO5cYxgxpyQpwNKHe+ezdEHMHGr0dakaDrBYU6iymu/wa/QD40YllAjPs5S5fzhQYmsdfU7l3/TSuiVeOu4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2734
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-06_06:2022-06-02,2022-06-06 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 mlxscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206060081
X-Proofpoint-GUID: KGXfBLqyjjy9W3PpTADtgg0MsBKYboGE
X-Proofpoint-ORIG-GUID: KGXfBLqyjjy9W3PpTADtgg0MsBKYboGE
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce clear_page_non_caching_threshold_pages which specifies the
threshold above which clear_page_incoherent() is used.

The ideal threshold value depends on the CPU uarch and where the
performance curves for cached and non-cached stores intersect.

Typically this would depend on microarchitectural details and
the LLC-size. Here, we arbitrarily choose a default value of
8MB (CLEAR_PAGE_NON_CACHING_THRESHOLD), a reasonably large LLC.

Also define clear_page_prefer_incoherent() which provides the
interface for querying this.

Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 include/asm-generic/clear_page.h |  4 ++++
 include/linux/mm.h               |  6 ++++++
 mm/memory.c                      | 25 +++++++++++++++++++++++++
 3 files changed, 35 insertions(+)

diff --git a/include/asm-generic/clear_page.h b/include/asm-generic/clear_page.h
index 0ebff70a60a9..b790000661ce 100644
--- a/include/asm-generic/clear_page.h
+++ b/include/asm-generic/clear_page.h
@@ -62,4 +62,8 @@ static inline void clear_page_make_coherent(void) { }
 #endif /* __ASSEMBLY__ */
 #endif /* __HAVE_ARCH_CLEAR_USER_PAGES_INCOHERENT */
 
+#ifndef __ASSEMBLY__
+extern unsigned long __init arch_clear_page_non_caching_threshold(void);
+#endif
+
 #endif /* __ASM_GENERIC_CLEAR_PAGE_H */
diff --git a/include/linux/mm.h b/include/linux/mm.h
index bc8f326be0ce..5084571b2fb6 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3328,6 +3328,12 @@ static inline bool vma_is_special_huge(const struct vm_area_struct *vma)
 				   (vma->vm_flags & (VM_PFNMAP | VM_MIXEDMAP)));
 }
 
+extern bool clear_page_prefer_non_caching(unsigned long extent);
+#else /* !(CONFIG_TRANSPARENT_HUGEPAGE || CONFIG_HUGETLBFS) */
+static inline bool clear_page_prefer_non_caching(unsigned long extent)
+{
+	return false;
+}
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE || CONFIG_HUGETLBFS */
 
 #ifdef CONFIG_DEBUG_PAGEALLOC
diff --git a/mm/memory.c b/mm/memory.c
index 04c6bb5d75f6..b78b32a3e915 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5563,10 +5563,28 @@ EXPORT_SYMBOL(__might_fault);
 
 #if defined(CONFIG_TRANSPARENT_HUGEPAGE) || defined(CONFIG_HUGETLBFS)
 
+/*
+ * Default size beyond which huge page clearing uses the non-caching
+ * path. Size it for a reasonable sized LLC.
+ */
+#define CLEAR_PAGE_NON_CACHING_THRESHOLD	(8 << 20)
 static unsigned int __ro_after_init clear_page_unit = 1;
+
+static unsigned long __read_mostly clear_page_non_caching_threshold_pages =
+				CLEAR_PAGE_NON_CACHING_THRESHOLD / PAGE_SIZE;
+
+/* Arch code can override for a machine specific value. */
+unsigned long __weak __init arch_clear_page_non_caching_threshold(void)
+{
+	return CLEAR_PAGE_NON_CACHING_THRESHOLD;
+}
+
 static int __init setup_clear_page_params(void)
 {
 	clear_page_unit = 1 << min(MAX_ORDER - 1, ARCH_MAX_CLEAR_PAGES_ORDER);
+
+	clear_page_non_caching_threshold_pages =
+		arch_clear_page_non_caching_threshold() / PAGE_SIZE;
 	return 0;
 }
 
@@ -5576,6 +5594,13 @@ static int __init setup_clear_page_params(void)
  */
 late_initcall(setup_clear_page_params);
 
+bool clear_page_prefer_non_caching(unsigned long extent)
+{
+	unsigned long pages = extent / PAGE_SIZE;
+
+	return pages >= clear_page_non_caching_threshold_pages;
+}
+
 /*
  * Clear a page extent.
  *
-- 
2.31.1

