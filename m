Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B26F53EF8C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 22:25:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233810AbiFFUZh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 16:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233488AbiFFUZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 16:25:12 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB130131F08
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 13:24:29 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 256KJjoC030086;
        Mon, 6 Jun 2022 20:22:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=6BJ963cSHLwoWXx+Sn1JXEa7kfrO5qnc4QbhLDXzJfM=;
 b=XSThaI5efd5j+aWpu4xuZcVqnFgJClYUuiZswgGeBPUfdrF/YofPWTV4RNIiJSSy7cSG
 zpK7LZCFmPjxl+CpnmH0sBqCSZGEzCR9/KUsEDv7BN09bOW/DnKxFuf7CAJ3h3rkgKn2
 /+f8aDK8vBnrxywjjo3XyZGLxmZrvliOBsun3xid3nAwh9zaAeSxYOirOS1fOJKQ6Udz
 UeX0VEdyk1TPm8WR8zSQCbFW38zQrsBJQqBQMUocgAp0QSO5mBOpPz7eZsrhcx7lnXle
 4JlxJ86umZkiuBJwfz2W4sWnGgmVH3AvlwKOrh7fhcYMqP1WJAbq6mV3wav7x/jc8q2z WA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ghqad84qy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Jun 2022 20:22:08 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 256KGEXr003280;
        Mon, 6 Jun 2022 20:22:08 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2175.outbound.protection.outlook.com [104.47.58.175])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gfwu2bt3r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Jun 2022 20:22:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=md3YSVD2WL410xId5KsVGrrgBh97VuNC4dmOa2zf9YTTxREVkajpdWa5ZHze3j87NVldkEbxTYzVRkvgYcW4KpLvZua2weH5E5h+BsjsSgg8uZeaxmZagdN62FEygA46+7K4yYnsjX9xVmAvHINThEI6oyCFkO/MYWZt08PtS989fGNX0WoQIaNPGdcefVMnyskVVt34YgyR/vIxVJd8rfvdYQ+OnH4paxkZgoemW3kai5XjIaN8HQnC3tDQYHq87fW/q5LsFccLt9F4qOaX6qXREfHVKqEbLbPHc7GNzTBX/RRiuwjk66TgU14uOXX7DKXqeEYMBudaeyuzr6eR2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6BJ963cSHLwoWXx+Sn1JXEa7kfrO5qnc4QbhLDXzJfM=;
 b=Pw5xFKv53wTk0iYxs1/f0XOgTWpgQzIN+MAGLPQl2TM2DfdDL+GC1qeatZaRO/JQtme1X+XAEFSLYCNU/iVV+wgR2HUx2EMZ1EtekYk0rAK0H68xfTmN3OpCJ3poF61dzLKVH6qvLGi2MUtAqDBu2mb93O2tMul6X01GEV8ho0V6yIHCa1VUs/6opGiOYPzhhYFmvazCXAw/7dPclcnTwgJZOA5JvEOx9N0dMRyOiRjHK4wkMyufWKX4dpFZy5aFtOcciDOcmrUU43vMLw6bxwVMYgeKA1f3ibJ8/8RIg3d4OUCgWF40N8+Vdb0ktGV4MQCW1Vbt1TPWJeWQuA9IWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6BJ963cSHLwoWXx+Sn1JXEa7kfrO5qnc4QbhLDXzJfM=;
 b=NWdT/+Y2K4pGMYi7xbHKmQSeTL8tkQm2A6pnou0u4mKZ/XUzr0egvjkNt/oACen0CpUF0vZZ4js+1d5YmW+hqbcyKKyxSYUO2kIeTYtn85v8pICBC+3TOORE1Z2fz1Z6ijq8UJNiB3m2hT9+kRPZebINKfKIK1fIaku+g94xysg=
Received: from DM8PR10MB5416.namprd10.prod.outlook.com (2603:10b6:8:3f::19) by
 DM5PR10MB1772.namprd10.prod.outlook.com (2603:10b6:4:11::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5314.13; Mon, 6 Jun 2022 20:22:05 +0000
Received: from DM8PR10MB5416.namprd10.prod.outlook.com
 ([fe80::49dc:6a95:a2d5:fc08]) by DM8PR10MB5416.namprd10.prod.outlook.com
 ([fe80::49dc:6a95:a2d5:fc08%5]) with mapi id 15.20.5314.018; Mon, 6 Jun 2022
 20:22:05 +0000
From:   Ankur Arora <ankur.a.arora@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        mike.kravetz@oracle.com, mingo@kernel.org, luto@kernel.org,
        tglx@linutronix.de, bp@alien8.de, peterz@infradead.org,
        ak@linux.intel.com, arnd@arndb.de, jgg@nvidia.com,
        jon.grimm@amd.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com, joao.martins@oracle.com,
        ankur.a.arora@oracle.com
Subject: [PATCH v3 04/21] mm, clear_huge_page: support clear_user_pages()
Date:   Mon,  6 Jun 2022 20:20:52 +0000
Message-Id: <20220606202109.1306034-5-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220606202109.1306034-1-ankur.a.arora@oracle.com>
References: <20220606202109.1306034-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR01CA0034.prod.exchangelabs.com (2603:10b6:a02:80::47)
 To DM8PR10MB5416.namprd10.prod.outlook.com (2603:10b6:8:3f::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e76cfaf1-db89-4c79-6177-08da47fa3948
X-MS-TrafficTypeDiagnostic: DM5PR10MB1772:EE_
X-Microsoft-Antispam-PRVS: <DM5PR10MB17720A4F2C3742A53B95B5FBCEA29@DM5PR10MB1772.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YK6dU+WVvxawlCO6baPU3XgPpQMrOkN04BqU6vXolYAQoDtuGld7NzufJDLr5yhvjszGJzxhWeeWPFbb/yUl4OKB9VY9hX1NVcGfm+/R/3okMufB9H/jV03dStNZ8QIDmnXLyjctOKIzRwc/EbT4Y8TToBdYDAZuf7T4F5v/e2A7EgQ36UbKct0QPgHmV9+ikmRO31qMIwD7DlhYKOlJI5fF1iGM1WilcKPO8kSp6JWJ4B53oHEEFOWWUcS3QFz+//SUUD3s48d7EZnocmyXjE8iSJZKpiHO7r7/Zfg8zflIKMblPms8YrE/SABwiXz51HlBNdfnfvsxsxwof7E3NK27VDsv/4vgGGgcgSQuHZj1tbDqvCAgB0jL1K3LBlreVPRsIpn1glAyLNOaoU4F0rKayT9K2R6mZnBND6fKqBfNBcKT9pS9RuBUs8Pp4k+XSHUEuRQioGyDXlA+Y5VHkUsK4VGro8o/L2ZPBessZv1bxePs75ZwXfD3rr/wHa07lF2fsBRSBg7ce/2unWtYu2V84bDppElzPvQ1hDmZFf6bKWapEiHV3nYt2N8D84VfwqD4AEASHufUPYO32MhRDp8ZeXPxCpEpoq/xuseKhOzKoLa3yTZ4+ks4RjDZfEK361dtbcrP75GKWCFKXFvW8kiS1A1qcnEynyVzNiYkvPXHXN1bXR6bLeUY2XKSVBX/8Nx9/aptu9904jGluI73zSVJWJSp7snF1g1Z00NRcRw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR10MB5416.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(7416002)(6506007)(83380400001)(107886003)(66556008)(36756003)(1076003)(38100700002)(186003)(6666004)(66946007)(508600001)(6512007)(26005)(2616005)(5660300002)(38350700002)(4326008)(8676002)(316002)(103116003)(2906002)(66476007)(86362001)(52116002)(6486002)(14583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eIGiphxJVBJHg/dOZ2mWIy7aJflRUe16uqgUYp2oRx1+OguaDfVQb5Gpbijp?=
 =?us-ascii?Q?SyOn9K8kE32kRVPdYm6P0MQUUYIbPDi+ptKgi2EKjzd2rcsxvRYMwCnBNslv?=
 =?us-ascii?Q?rf0CrxTW1gRat3cLw3jJxpLt+JhfIZEsCeciLK4zN4uE77KEQxI1KUy8bESL?=
 =?us-ascii?Q?GxSWbuaFW1ynsZIrOtGysd6Egd0svED8CjrliSXq9ibLv44n3g43jxclm3Lk?=
 =?us-ascii?Q?R6BeVer3XM5olK0AEBZBOEo/mvx1BBIq5zBZgxU6tOmGxMQtMuYeCrMlaf+K?=
 =?us-ascii?Q?fYe1Xc5fDgyWwaQC6otl30HTUPTtCdOHJyGmpMNhMW25Ol2s/dPD1mnPEzwV?=
 =?us-ascii?Q?T3HIs/ARaIB849XjMH779UiLjPy6T1QD/9bY/bRtUtAC8UzxjXIp8LTY3+al?=
 =?us-ascii?Q?iAb5rGqpv9ydkLOvwdKbeDZK0pPW67nAlaYwh/9KLhx9umSPO76KG8Po9NTP?=
 =?us-ascii?Q?SLGr6dRiqR6xQr7qUa9ZBwUuK+JSGOWeY+vyOcZDpApbuN9DmQo+SO6rgRZ+?=
 =?us-ascii?Q?bm5ez4mplu41VTJHYmcUss0CnZA5EeBf6dMtNf8knP/KFCh/AAcZfNuQeZah?=
 =?us-ascii?Q?gXE3tsQTqvyf0J+FUMk7X9Tvjbp+RePisQGTj/f/C6NwCkqoJU/AYB1nWead?=
 =?us-ascii?Q?JogEDmAJ/aPjRFifkWfabdu7O9JZ8+K3Ur+oBr0pW6UUHx+30rdG+3KMTXXS?=
 =?us-ascii?Q?237WXk6KZHmGt0bsc8YV4jRB+IMeJCBIcioFlYVxQcChLiDophEu62tFNhW5?=
 =?us-ascii?Q?J8xo6j/wbfa9GqPB6v3dxWd2TDKimKvwL7us/0L2DsXlD33T2DX/r+E2Vie7?=
 =?us-ascii?Q?r+Eg1sW7JV3c6JipahUEDkJ9vXxS3G4X3bvFCQkN4EYFO6MFBNb/ckgLRu6Q?=
 =?us-ascii?Q?gLnDfzZZrqQIn4bO4mPR4IRAEAGIf/MaKeEbyjavilcXtKvqXIyKRud1C+lR?=
 =?us-ascii?Q?gte3FmHHswbXr+mUTWWqloCFtQ3tQH8zIA87W8b6QlKAGzyWPIBOTb9tkFKU?=
 =?us-ascii?Q?ihng1hnWBNqCx+UqHzznEqIGCDVL8LrKSgz+AZZ2oxXpx9ilx5LBJr5wPbIs?=
 =?us-ascii?Q?CJMmq1oWqeyOXVnHPr7SFpZ1PKmdeSDRjybuKdtFXbUS+ai417OUofCU65dR?=
 =?us-ascii?Q?ELG19Vgxx56cLu0HmTmauB8B7kKpo6s7QyW7eXBdsJjZ+VjJIA6KnofR+lBB?=
 =?us-ascii?Q?iP2MX4OV9gbVzGMKmf0SdQPowjn5ae8lziBZblPAMlDFUJtk/Vjy9TXUoTh8?=
 =?us-ascii?Q?9U06VxYopXPR4r88OcFWSv3aDFYt1tTZtwYGJLHbHw4NArB63AKQ3IE454jD?=
 =?us-ascii?Q?91QKmXdqDvw8AZNfdolXMLX02TiiKrOAOfcdkb5aMArRzMmdmXOcfdNWGSj6?=
 =?us-ascii?Q?AKs8hFASQrlKlNijYDHI3cebl81/scN59fba1/p4lUDtHC7B/CiqVd4mT8Nx?=
 =?us-ascii?Q?0RwSa5w/KLAgA8+E1J8lwkmWcMDLMJ+pTaSnZWqiNowQGinjiSBK5+eiLGmc?=
 =?us-ascii?Q?BZj3E2WCawc/dHg+mUJKWXW8EJcuc6ci2C+jI5c7QBMEtEuswfS4CtVceBEA?=
 =?us-ascii?Q?sRse0oIwolO28OMg9/MMj1MY9VVsI/HP0Lf3J5g5MH7xXD+w3OCadQD17uJ3?=
 =?us-ascii?Q?RMpJ9bKqyHtIvesUnwhQh3+Hy+5gnndSN/3SDPuQtzQMx9a9FLn2tavfHIPl?=
 =?us-ascii?Q?uvVPiGpuRaW54yiGqyih6oV2CL8ja4yHDJbGPQrh3ITIZZr/Xhg+J348H4WJ?=
 =?us-ascii?Q?AQqmCV/xe7DoGZLM+Y5HEN/IGx5vq8U=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e76cfaf1-db89-4c79-6177-08da47fa3948
X-MS-Exchange-CrossTenant-AuthSource: DM8PR10MB5416.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2022 20:22:05.6818
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t8vkoxPS9odXsOp5gm7LcQuVAP+g6fvtqh/MEbErxdXyO88H9Ob/o7DtsghT3horY+0fKfZNgQE6GQIc9QcHQ16PsGb6gaWZaT9tnSiJMPI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1772
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-06_06:2022-06-02,2022-06-06 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 phishscore=0 adultscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206060081
X-Proofpoint-ORIG-GUID: qqGtsA2CUbLUkubRmSxzRBXAEcra_0nE
X-Proofpoint-GUID: qqGtsA2CUbLUkubRmSxzRBXAEcra_0nE
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

process_huge_page() now handles page extents with process_subpages()
handling the individual page level operation.

process_subpages() workers, clear_subpages() and copy_subpages()
chunk the clearing in units of clear_page_unit, or continue to copy
using a single page operation.

Relatedly, define clear_user_extent() which uses clear_user_highpages()
to funnel through to clear_user_pages() or falls back to page-at-a-time
clearing via clear_user_highpage().

clear_page_unit, the clearing unit size, is defined to be:
   1 << min(MAX_ORDER - 1, ARCH_MAX_CLEAR_PAGES_ORDER).

Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 mm/memory.c | 95 ++++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 69 insertions(+), 26 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 2c86d79c9d98..fbc7bc70dc3d 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5563,6 +5563,31 @@ EXPORT_SYMBOL(__might_fault);
 
 #if defined(CONFIG_TRANSPARENT_HUGEPAGE) || defined(CONFIG_HUGETLBFS)
 
+static unsigned int __ro_after_init clear_page_unit = 1;
+static int __init setup_clear_page_params(void)
+{
+	clear_page_unit = 1 << min(MAX_ORDER - 1, ARCH_MAX_CLEAR_PAGES_ORDER);
+	return 0;
+}
+
+/*
+ * cacheinfo is setup via device_initcall and we want to get set after
+ * that. Use the default value until then.
+ */
+late_initcall(setup_clear_page_params);
+
+/*
+ * Clear a page extent.
+ *
+ * With ARCH_MAX_CLEAR_PAGES == 1, clear_user_highpages() drops down
+ * to page-at-a-time mode. Or, funnels through to clear_user_pages().
+ */
+static void clear_user_extent(struct page *start_page, unsigned long vaddr,
+			      unsigned int npages)
+{
+	clear_user_highpages(start_page, vaddr, npages);
+}
+
 struct subpage_arg {
 	struct page *dst;
 	struct page *src;
@@ -5576,34 +5601,29 @@ struct subpage_arg {
  */
 static inline void process_huge_page(struct subpage_arg *sa,
 	unsigned long addr_hint, unsigned int pages_per_huge_page,
-	void (*process_subpage)(struct subpage_arg *sa,
-				unsigned long base_addr, int idx))
+	void (*process_subpages)(struct subpage_arg *sa,
+				 unsigned long base_addr, int lidx, int ridx))
 {
 	int i, n, base, l;
 	unsigned long addr = addr_hint &
 		~(((unsigned long)pages_per_huge_page << PAGE_SHIFT) - 1);
 
 	/* Process target subpage last to keep its cache lines hot */
-	might_sleep();
 	n = (addr_hint - addr) / PAGE_SIZE;
+
 	if (2 * n <= pages_per_huge_page) {
 		/* If target subpage in first half of huge page */
 		base = 0;
 		l = n;
 		/* Process subpages at the end of huge page */
-		for (i = pages_per_huge_page - 1; i >= 2 * n; i--) {
-			cond_resched();
-			process_subpage(sa, addr, i);
-		}
+		process_subpages(sa, addr, 2*n, pages_per_huge_page-1);
 	} else {
 		/* If target subpage in second half of huge page */
 		base = pages_per_huge_page - 2 * (pages_per_huge_page - n);
 		l = pages_per_huge_page - n;
+
 		/* Process subpages at the begin of huge page */
-		for (i = 0; i < base; i++) {
-			cond_resched();
-			process_subpage(sa, addr, i);
-		}
+		process_subpages(sa, addr, 0, base);
 	}
 	/*
 	 * Process remaining subpages in left-right-left-right pattern
@@ -5613,15 +5633,13 @@ static inline void process_huge_page(struct subpage_arg *sa,
 		int left_idx = base + i;
 		int right_idx = base + 2 * l - 1 - i;
 
-		cond_resched();
-		process_subpage(sa, addr, left_idx);
-		cond_resched();
-		process_subpage(sa, addr, right_idx);
+		process_subpages(sa, addr, left_idx, left_idx);
+		process_subpages(sa, addr, right_idx, right_idx);
 	}
 }
 
 static void clear_gigantic_page(struct page *page,
-				unsigned long addr,
+				unsigned long base_addr,
 				unsigned int pages_per_huge_page)
 {
 	int i;
@@ -5629,18 +5647,35 @@ static void clear_gigantic_page(struct page *page,
 
 	might_sleep();
 	for (i = 0; i < pages_per_huge_page;
-	     i++, p = mem_map_next(p, page, i)) {
+	     i += clear_page_unit, p = mem_map_offset(page, i)) {
+		/*
+		 * clear_page_unit is a factor of 1<<MAX_ORDER which
+		 * guarantees that p[0] and p[clear_page_unit-1]
+		 * never straddle a mem_map discontiguity.
+		 */
+		clear_user_extent(p, base_addr + i * PAGE_SIZE, clear_page_unit);
 		cond_resched();
-		clear_user_highpage(p, addr + i * PAGE_SIZE);
 	}
 }
 
-static void clear_subpage(struct subpage_arg *sa,
-			  unsigned long base_addr, int idx)
+static void clear_subpages(struct subpage_arg *sa,
+			   unsigned long base_addr, int lidx, int ridx)
 {
 	struct page *page = sa->dst;
+	int i, n;
 
-	clear_user_highpage(page + idx, base_addr + idx * PAGE_SIZE);
+	might_sleep();
+
+	for (i = lidx; i <= ridx; ) {
+		unsigned int remaining = (unsigned int) ridx - i + 1;
+
+		n = min(clear_page_unit, remaining);
+
+		clear_user_extent(page + i, base_addr + i * PAGE_SIZE, n);
+		i += n;
+
+		cond_resched();
+	}
 }
 
 void clear_huge_page(struct page *page,
@@ -5659,7 +5694,7 @@ void clear_huge_page(struct page *page,
 		return;
 	}
 
-	process_huge_page(&sa, addr_hint, pages_per_huge_page, clear_subpage);
+	process_huge_page(&sa, addr_hint, pages_per_huge_page, clear_subpages);
 }
 
 static void copy_user_gigantic_page(struct page *dst, struct page *src,
@@ -5681,11 +5716,19 @@ static void copy_user_gigantic_page(struct page *dst, struct page *src,
 	}
 }
 
-static void copy_subpage(struct subpage_arg *copy_arg,
-			 unsigned long base_addr, int idx)
+static void copy_subpages(struct subpage_arg *copy_arg,
+			  unsigned long base_addr, int lidx, int ridx)
 {
-	copy_user_highpage(copy_arg->dst + idx, copy_arg->src + idx,
+	int idx;
+
+	might_sleep();
+
+	for (idx = lidx; idx <= ridx; idx++) {
+		copy_user_highpage(copy_arg->dst + idx, copy_arg->src + idx,
 			   base_addr + idx * PAGE_SIZE, copy_arg->vma);
+
+		cond_resched();
+	}
 }
 
 void copy_user_huge_page(struct page *dst, struct page *src,
@@ -5706,7 +5749,7 @@ void copy_user_huge_page(struct page *dst, struct page *src,
 		return;
 	}
 
-	process_huge_page(&sa, addr_hint, pages_per_huge_page, copy_subpage);
+	process_huge_page(&sa, addr_hint, pages_per_huge_page, copy_subpages);
 }
 
 long copy_huge_page_from_user(struct page *dst_page,
-- 
2.31.1

