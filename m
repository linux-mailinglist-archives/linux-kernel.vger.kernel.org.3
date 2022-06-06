Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D33253EF89
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 22:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233187AbiFFUYS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 16:24:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233479AbiFFUYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 16:24:05 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D03D81059DA
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 13:23:08 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 256Ivt3s017195;
        Mon, 6 Jun 2022 20:21:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=0nZQslULxAhoD/bW6aGIxZoSbrQ8Jnb10JGFAIP1T/A=;
 b=tNejYPCWFGBvEswK0jw1T7MNUM1DeU+E6u78lKNqwkafE/P0ituy1yBd9/j8bQLae93k
 HrD3lGy7uHeX+8S9NNbyMIRPLdnxnxhiZMwAW1b+/FDXaA5vq4qKx8JtqMp4dtC7MbPz
 Lg+xSNp7yJ4psiJZiy6qqBzyT8sMxoS4rWLcamHvWK8YYhsV0+lvbcPSqFTp0uutWALX
 6eN0oQIYAaMUTuoDuZWPqDBZq3Pq6q4RkcYB2NFHhe+7MBYiBYAVBoGZFlj8Iu6RXSPZ
 izpRi4XrewXLHxfHacanBLGz2BWZ1QwHsQJ0B2odptS1WhYn3e16VLHxhUycnSlfk7Uk 1w== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ggvxmteku-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Jun 2022 20:21:45 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 256KGOds037870;
        Mon, 6 Jun 2022 20:21:45 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gfwu1ua9d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Jun 2022 20:21:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hOYwNwh9PJ2iuLXYc2H4XkM8KrdJpsMlGxlJPVqB838capwPO/MNHOwJLkMYwQBHWgvxtdwvr3Iu5vK7UZ+HOiZsoMboZn5CmZp0cAnpS7/Mrl5dbflBEo/EbZ0T8Nnr/dOctsZJwKHJYrfAwgbbBShcx5uWIpz9OZSxmI+vksubODZKjS0H8pswlzurlG8kPtjvWCkSDYbDqFQS+MRwO1qPoxYquWcg0dGA4bRM74wXmwKSulmwX/gGM3NId6djK6fIbVA02eyoslC4k7iIvlk7FUZmrFF7bugr9JHC3eW79jg9poEgVJsobLFVcIrC6AIf7H4uL1qvPYYOAFwBTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0nZQslULxAhoD/bW6aGIxZoSbrQ8Jnb10JGFAIP1T/A=;
 b=klI4bZ7DGzT/5Ta+IXtNsefvSSkirQGQQAvqUs75z8CgXv9ASRV8COWns7suvBqhouzdZ62f2gEYhrNrGbDZ021qCpvuLKiYXmsd3OTrkX+b/lyLRBcRiNWyjPr+FI3ZPFWhr8Hiu916Y+hOwZ52gTbhIoYzKXgoOIGdfghFbWGoVjjcUwVamKkFrYKF4qTvqCH+5PM6sRhmga4Hv36q1X4UKFodp6Ou0B4a5bIkSpfw2IMw+lRkca7pnjU+3bdUVrisIQn+Z12oDR1FR1lHfFgWd4koeTkIF+WRpGDvph3xkJtoXar2tOS9amAjKbBkiQy1WFIe33XL6WRzA0qVvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0nZQslULxAhoD/bW6aGIxZoSbrQ8Jnb10JGFAIP1T/A=;
 b=BYCaTh+ZIlXrOg7SEsrkA5ebwX0pQ3NrPHpZ4X/fltBRiL4uaYVCqVirwSHEd/JlngbdumYR9XW23o5E1CFPsZ0gvsbIZePoJUit5p/q01Vg7Pl0ua2bTxfBI941oj8QwJbbWZsMt7MR/Q7cRf2S4XIrJekFotBAVU4iMJ6jzvk=
Received: from DM8PR10MB5416.namprd10.prod.outlook.com (2603:10b6:8:3f::19) by
 CY5PR10MB6046.namprd10.prod.outlook.com (2603:10b6:930:3d::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5314.19; Mon, 6 Jun 2022 20:21:42 +0000
Received: from DM8PR10MB5416.namprd10.prod.outlook.com
 ([fe80::49dc:6a95:a2d5:fc08]) by DM8PR10MB5416.namprd10.prod.outlook.com
 ([fe80::49dc:6a95:a2d5:fc08%5]) with mapi id 15.20.5314.018; Mon, 6 Jun 2022
 20:21:42 +0000
From:   Ankur Arora <ankur.a.arora@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        mike.kravetz@oracle.com, mingo@kernel.org, luto@kernel.org,
        tglx@linutronix.de, bp@alien8.de, peterz@infradead.org,
        ak@linux.intel.com, arnd@arndb.de, jgg@nvidia.com,
        jon.grimm@amd.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com, joao.martins@oracle.com,
        ankur.a.arora@oracle.com
Subject: [PATCH v3 02/21] mm, huge-page: refactor process_subpage()
Date:   Mon,  6 Jun 2022 20:20:50 +0000
Message-Id: <20220606202109.1306034-3-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220606202109.1306034-1-ankur.a.arora@oracle.com>
References: <20220606202109.1306034-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR06CA0036.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::49) To DM8PR10MB5416.namprd10.prod.outlook.com
 (2603:10b6:8:3f::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 670c3c40-e8ce-4b2f-b6c6-08da47fa2b9c
X-MS-TrafficTypeDiagnostic: CY5PR10MB6046:EE_
X-Microsoft-Antispam-PRVS: <CY5PR10MB60462F79B4A0DD4C8D026B1BCEA29@CY5PR10MB6046.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LVFb+q6EcTOoNFuGvg+j0xnEFSea6ZQWISdgVXVnCywlX//twnY6bQf+XldV8NT4netvHAJLhg+iwiFtKbErIQ5fR8J1pq+3dY0inyMedLKu6UTZFBs2exBk1oYEAmBuT4Q0EkRt1wN912FtemQHggqZBrE30ZLFg8CNBb2WW1wCeYN57p9N0WzXn5wWXCq2Gyb2pifu5ldP6zkSEIEnj/OMf7wh4FnBfm7EeInarcz8x7Gob6THHL9oaT57dWbkgc3T3PVLH88EuaV37E20szOGDe7tpkpcZP251P3IgFvfHED2SRRFML4BklM/iS5dHABMbQvakDBTuXmE4XJtE7f5nishGWDrT4fV0bBEd/o1Hzs23fPu2Ulwpui9Aha3Wq1Qo74vLIeh8GePd2Cwfa2bzljtZtrxdecFUOaFgXBfCluJkC4nuiYPy+ih+s8cOPHfgkFB2hj+QYKAdiPIpH3WFJpe65jWvnt4myvWPHPKGsz0VWo/+7+xU0vHICSwd41J7+VcfBnbLH/A+VP069n/cNnPaz1EWKm99UmATBC0Q2/VJU3SjOwXHDmHapHFjZVYb9D+dCYQ+9QX7KvRCAHDqVujVM8t4UnDXDKp1uozJOoixTV1ItDMhC00tVuxIOYY3uLvN9apyx+Ek3Q5LLdPS34ERfT4mTdzJuYGz7J1C5uKUwpxun7C1QYtuWyDfDFFhgFVHQ3HBd8qm4eDLcuz5M/AIpBr6WlkGAzHkI4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR10MB5416.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(86362001)(36756003)(103116003)(8936002)(38350700002)(38100700002)(508600001)(6486002)(6666004)(8676002)(4326008)(5660300002)(66946007)(66556008)(66476007)(7416002)(2906002)(316002)(26005)(6512007)(186003)(52116002)(2616005)(107886003)(1076003)(6506007)(14583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ym7dv3/nk0tK2cYAAvUU9neh7WOj2DVPXyUKJcn/jY0VAqjoJC4SUitkUNu+?=
 =?us-ascii?Q?Uv7cXDRhcKWtP7p5+QXe+opKjXzsmj4YFSIKEoDGJzYNFFFOKDV2L+IcA+9n?=
 =?us-ascii?Q?l0KygK3MxjLDNWtBxko5L5a7MW95BQbgzRUmlMuJMqyIxNGZGoUlmrMA2fdm?=
 =?us-ascii?Q?7YvuJGsBLBykCTzTIT2sDXSEgNm5aWyFxd9sKdMCqx9fUoT2/edN8rrIKo/5?=
 =?us-ascii?Q?r/tWCWfXH+95AvBILoUQTHS6TGd2GZdzmH3IwjJnEjVzxkcVsB4pHwMIhFZ8?=
 =?us-ascii?Q?5pIPb6UpxkbdnQxbAOosLP2kEINlQpFNf41vQmLRkkady7SQ9S+RThD28nHv?=
 =?us-ascii?Q?V9E+Q1U5PkDO8fxbMuyN6Ww3WMuicX3Kc8vmeMh4C1WnOoQrfYzewkRYJRqp?=
 =?us-ascii?Q?JSiZiY1m0ecZnu3kCl2UJxODYv4zRfrcyb0hTKKzRsyv2CIDFiYjAMlwadAp?=
 =?us-ascii?Q?lzVC+Wzbxky9Bf1xUAic0qy2TF8ZDInab4WGkp29Q45o6kc0e3CuczxpAkbN?=
 =?us-ascii?Q?5C/gzgaFFpLU6dFUWOo+LMfv9WqNPYU8qFlkbXLJBI5WW2KO+85+gLECWo5k?=
 =?us-ascii?Q?sltjRL/7xBvW2EaLkKBcPtb6+dpSeEp8S149LpDGfgqfS4I8JPQ8oHqBOACB?=
 =?us-ascii?Q?gM4paCduTvUA5wh7UijCGurPk0zL0LV8b+bVLVLjwf1S0axBSxB2IOpPF442?=
 =?us-ascii?Q?8pkkL0/J1FutryIvjSTE17iDRxKokDZ8MoYaXym1Hy1bFrtHfdHAebjoepdH?=
 =?us-ascii?Q?xp7j6pQwtoZ9jQYOkQh6dRVqPGS7V5R24794iinEqxru+9a0s31rYqa6QPB6?=
 =?us-ascii?Q?4Chy9tiRS01mEZHi4gUseWJn3+RRAZXmdSEZHdwJzSV1nq2cAokrvSFo/kZx?=
 =?us-ascii?Q?akbRTPP+7Zn32A9AYiupZ8tbLhY1WAX7CLLjHmxWB+BEcChrvtxQVK4maN0B?=
 =?us-ascii?Q?ZaGF4n/kiPqEXTvpE95svGl9jHVXPwCf12xubJHvrpQPCQ51iwoW4TPejaa8?=
 =?us-ascii?Q?+EXcXkx8WKhdvoVUrzcGb/WdRjkcGMBid5QPHSBvWMTnybgkKTBF0iGYvpSN?=
 =?us-ascii?Q?N7dBwn24EFIjBy8aOSK9Y0ei1SXPMCaQYuePAh9y9GHINM/OV6ufh9zNOhlE?=
 =?us-ascii?Q?LRVNiJArMaI7IOpZ9FEco28elmwe6oXLt9dp8mQn+3SLV83/w9c+OJ8XY+YV?=
 =?us-ascii?Q?zB9FJHrMtmZTG7Eq5L80n2d4EgIt4BtX79vSbhd08PktMCNRtIXTONRLzo0v?=
 =?us-ascii?Q?s+7nHTB+Gpx3ZVdPa79jws+cglRxEhJeCw+WdoJ6gu62NdAoc/jSywPF5K5x?=
 =?us-ascii?Q?MHyJujDrVs5ZGUW/8+xCEpIAVrhsBIS35agHs5Sndg1Ge3N7EdgfeBI/b18L?=
 =?us-ascii?Q?O43acE8bgVodVzatLPj2cWgdX00yz9crcU2xrhVMOk1bJ5EaYkeKqQMSWwug?=
 =?us-ascii?Q?fIZDMsbSs3G5VpeE5tpKCvj2wv3xDwFibsWVdWorJGGJN7MyikyTeQT/R2LM?=
 =?us-ascii?Q?gpHJv5I1qaBqkNJ2qXRWHg5pEEMVGI22ZPrfFMC1kSfNmkzch4zKLkGQH6Zp?=
 =?us-ascii?Q?14IDHhkA1A/gi+SV3yuyfm5zC4HjUL26lEr6TtTJ6cRNV+Lvm5+GzhQUYKXt?=
 =?us-ascii?Q?T8HigRj6YYfyuISC4zsfrHMGAOCb8PVo2tZE4SoCESnCO9D8kQtzpg2272UL?=
 =?us-ascii?Q?DIdxkv6Gky0oZTrcRdpG1BF0d15hf1xaIqEZp8Hro4lGUoCLFXbwP0iHukdv?=
 =?us-ascii?Q?eTQJ2KZCs6ICnaonxomBemtzgMVkumA=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 670c3c40-e8ce-4b2f-b6c6-08da47fa2b9c
X-MS-Exchange-CrossTenant-AuthSource: DM8PR10MB5416.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2022 20:21:42.6852
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sO4UK8aEDZaFr6xDKiB8/34ptkbPSNAoWptdylMs2O+YLNyii4yECzvl0rJaVvlxeaXNOfbQcDQS5PWeqsbodnu7E1q4eXp/kNKNySDxSII=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6046
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-06_06:2022-06-02,2022-06-06 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 spamscore=0
 phishscore=0 mlxscore=0 adultscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206060081
X-Proofpoint-GUID: LBOVjsWmQfqtDZ-N8b-Cdu1GatVx44mh
X-Proofpoint-ORIG-GUID: LBOVjsWmQfqtDZ-N8b-Cdu1GatVx44mh
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

process_subpage() takes an absolute address and an index, both
referencing the same region.

Change this so process_huge_page() deals only with the huge-page
region, offloading the indexing to process_subpage().

Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 mm/memory.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index c33aacdaaf11..2c86d79c9d98 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5577,7 +5577,7 @@ struct subpage_arg {
 static inline void process_huge_page(struct subpage_arg *sa,
 	unsigned long addr_hint, unsigned int pages_per_huge_page,
 	void (*process_subpage)(struct subpage_arg *sa,
-				unsigned long addr, int idx))
+				unsigned long base_addr, int idx))
 {
 	int i, n, base, l;
 	unsigned long addr = addr_hint &
@@ -5593,7 +5593,7 @@ static inline void process_huge_page(struct subpage_arg *sa,
 		/* Process subpages at the end of huge page */
 		for (i = pages_per_huge_page - 1; i >= 2 * n; i--) {
 			cond_resched();
-			process_subpage(sa, addr + i * PAGE_SIZE, i);
+			process_subpage(sa, addr, i);
 		}
 	} else {
 		/* If target subpage in second half of huge page */
@@ -5602,7 +5602,7 @@ static inline void process_huge_page(struct subpage_arg *sa,
 		/* Process subpages at the begin of huge page */
 		for (i = 0; i < base; i++) {
 			cond_resched();
-			process_subpage(sa, addr + i * PAGE_SIZE, i);
+			process_subpage(sa, addr, i);
 		}
 	}
 	/*
@@ -5614,9 +5614,9 @@ static inline void process_huge_page(struct subpage_arg *sa,
 		int right_idx = base + 2 * l - 1 - i;
 
 		cond_resched();
-		process_subpage(sa, addr + left_idx * PAGE_SIZE, left_idx);
+		process_subpage(sa, addr, left_idx);
 		cond_resched();
-		process_subpage(sa, addr + right_idx * PAGE_SIZE, right_idx);
+		process_subpage(sa, addr, right_idx);
 	}
 }
 
@@ -5635,11 +5635,12 @@ static void clear_gigantic_page(struct page *page,
 	}
 }
 
-static void clear_subpage(struct subpage_arg *sa, unsigned long addr, int idx)
+static void clear_subpage(struct subpage_arg *sa,
+			  unsigned long base_addr, int idx)
 {
 	struct page *page = sa->dst;
 
-	clear_user_highpage(page + idx, addr);
+	clear_user_highpage(page + idx, base_addr + idx * PAGE_SIZE);
 }
 
 void clear_huge_page(struct page *page,
@@ -5681,10 +5682,10 @@ static void copy_user_gigantic_page(struct page *dst, struct page *src,
 }
 
 static void copy_subpage(struct subpage_arg *copy_arg,
-			 unsigned long addr, int idx)
+			 unsigned long base_addr, int idx)
 {
 	copy_user_highpage(copy_arg->dst + idx, copy_arg->src + idx,
-			   addr, copy_arg->vma);
+			   base_addr + idx * PAGE_SIZE, copy_arg->vma);
 }
 
 void copy_user_huge_page(struct page *dst, struct page *src,
-- 
2.31.1

