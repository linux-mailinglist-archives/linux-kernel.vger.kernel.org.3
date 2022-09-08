Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2793A5B26F0
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 21:38:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbiIHTiJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 15:38:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231193AbiIHThz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 15:37:55 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A0BB105D46
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 12:37:49 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 288HJKVt011859;
        Thu, 8 Sep 2022 19:37:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=c+0EVrzC6eJUNgr02xoi5K17R/S39pBDi0+vU7J0Rmk=;
 b=b8CRLbvac5NnXgohH/RSfQ5Q92SZ0bVNPFjqJCs4kxjGFDSS3Jn2ZkPf0H770G+p6ndP
 2gVGq3qCJGM06WVRn/AbEmNY/4UmBLW9QqWeTbtOKDAheUBO5J1rrvhK6jFXtzSSWFhh
 B3PdcuhVM6JqttPSdlqX0iWJtF8PMs0sAkFQqACb7tbcOn42P0JrU1T7Bce8r9ksLRr6
 WgJYh+FDJKXoSCOt8zOqDNbTPHUSf64bRPrXP5XfcPLgWKjLo0mFzUeqWGiOctyaTQsc
 zGDdmO1W3K4EsFR3D6aeW1vlg1oU06JOv/HaiaEJeh9H94WpJJW+LAX4ldZZy+UV4XV9 CA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jbwq2mw39-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Sep 2022 19:37:32 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 288IFDPt038812;
        Thu, 8 Sep 2022 19:37:31 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2048.outbound.protection.outlook.com [104.47.57.48])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jbwc63y72-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Sep 2022 19:37:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MZvwoBVjtTAMAfpxPj/UzcynJUH0gktP0J6EtN3ps/yHsM/yCW8xqvKiibqgloBnfCzNUs9GwPYxGkA5Pj9xEqjUFB3nLUh4UNZF9BNNWaBm+wa6iOQX2ZgMSW2KmNCqbP+uK2m9ryWQEda69DUFMWOz2c3UXSQtZNoTx/nEPIH+ZJKmMFaZNI7fwuEshu/lqCvkhF2+GbTVpBNtX7sG3cdhc4CWiSLXwmcCvpoZ/q0zXxcSxd4oxeQJklFLNY0gndbQCaCGOkIdE9ckoizFZnIXY4CA9XgUtBaw7D2+iJSvpPqap7fq089jrs7mgw0FsguwkrhW5qcpCts15N1Dsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c+0EVrzC6eJUNgr02xoi5K17R/S39pBDi0+vU7J0Rmk=;
 b=eDxPU+PUI3bD5hDIFBb6tiY/HILrFjwxWn1vO491gp5Ic+jYOwH8WIRq4hVguaOVKX+ECQ5cWCHt7CZ8ztcv2VS4/dEmveDBYIy5Xd0OalKITzuO2kGbYvpWZnyGMY7MZzXbgsVwzEt1X7B0j7f88VsIh6RqAGjSiIzEaLS2fFftziY4ULM/aV7AtSc4zfN5pL05X/F1W6eEbxWizGgsTxWjNTeNoQwfbGyfLruc9Y5kq9xlqARz/jiOdXjwtm07CPeABnr8EpMnc31iMBWKdalL+EqNlFHfyFVgngymchWX3SDKG4P7qacrl6y+8A1HxN3nFLPJv28cM+5yERKsRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c+0EVrzC6eJUNgr02xoi5K17R/S39pBDi0+vU7J0Rmk=;
 b=bMpi6K3LUuRMuX7zUq/siCFu9NXF9+bTjfpW9y2SQH/+iBg73m3SSgRumoXx4Z2frgKHWBNORa4pTAud9oLVWy0ZmVtDT41ksraAyf3YoDb0YkBuHepmKXbz4KHmEGRgVXm7KFSzKL8mtwkrF5WDCnOfiiI/cJTPvDRLMVhSV3Q=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by PH7PR10MB6532.namprd10.prod.outlook.com (2603:10b6:510:203::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.16; Thu, 8 Sep
 2022 19:37:29 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::ec55:981e:3693:b37]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::ec55:981e:3693:b37%4]) with mapi id 15.20.5612.016; Thu, 8 Sep 2022
 19:37:29 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, willy@infradead.org, vbabka@suse.cz,
        william.kucharski@oracle.com, dhowells@redhat.com,
        peterx@redhat.com, arnd@arndb.de, ccross@google.com,
        hughd@google.com, ebiederm@xmission.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH v3 1/6] mm/hugetlb: add folio support to hugetlb specific flag macros
Date:   Thu,  8 Sep 2022 12:37:01 -0700
Message-Id: <20220908193706.1716548-2-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220908193706.1716548-1-sidhartha.kumar@oracle.com>
References: <20220908193706.1716548-1-sidhartha.kumar@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR17CA0004.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::17) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|PH7PR10MB6532:EE_
X-MS-Office365-Filtering-Correlation-Id: 117f9fff-f2ea-4337-b7cb-08da91d1910c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Cvqp8HL7ilNxJs+dPP9LNxZhOUQCCbAj6P15RY0BTAS2FxgBt7wcOuVI66CdHs9h4yZ1zCyHjm3jCS8/0XPZmJqQrb2nRGAF/FZhGACmXLPdmhVddrtqoropK75XNGfjb/CJxj7cG9wp0SL2fnvxufwjJdHUdRnl6yZyUNAi/oeXHueF4HeLtkIcLvkDyu3P2+XS+n4ixOmDwTxXPpR4nnWUeogMaeuLFHPnl3aiPS8oJ5pXZiea8ksiwlmjPsIcrWbOq7KqNg+jVHsz9Dx8POtECEp9qsEpP9Dt74JZrjegFlqocBcgha6ISWPtsQTnjGh+ZSe60OasLjvZClwh213Wn3eZtgZY5AOwrfvf/XwbttCsCTzsrfVB+NyIUgGXJLMR9WXenZgEk3yYNBTKW0vLEREXd8If0JxnURtcri8vCWIjbziOGEKvvmVzC6KqPD7+IH8CCvAcVkbx+NYaMkdvqu8QZO1V5eN540xg+80yZLJvCJlS0UXPlszuJHDdZfN+zNhES8Cyl6NO0qFiUvVwtwWLkigfKDJwsJbn8jZqlbYe0Dxrm+cvk245dENDCXKgKSVlOiP+kyy1DWV8xvP2O7aPkEBJgDMQgGFSpcJcuDC4HMIs2IItxKvKAw0jS4PSpVCWAao8fnmV05Sc2kb0BaGiHDAv1qNNpJ+HvSWzxgP8Ta1gtV28S3CxW+Oulwf+Ez9yCPZC7m3rwpd3BA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(39860400002)(366004)(136003)(396003)(376002)(7416002)(38100700002)(83380400001)(186003)(1076003)(2616005)(5660300002)(36756003)(66556008)(2906002)(66476007)(316002)(66946007)(8676002)(4326008)(8936002)(44832011)(6666004)(107886003)(86362001)(6506007)(6512007)(26005)(478600001)(41300700001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?c7ut+Ug1ylZbCjt7vZvcpV8HOMiJt+0sTnuubb/z5YQdRPdl9iQEgx3AscB/?=
 =?us-ascii?Q?1DUyQMu95Yvv4CGBNRNyJr4tq2bPpAzS3ydgbMTqXvYOA/HDobS8MMa5+oV+?=
 =?us-ascii?Q?3o0wF68OL3CTVHCmZR13vcftYm93drGnHyEvLhSzRmHr4mcOdzZYgjSkJpcZ?=
 =?us-ascii?Q?9S/V5dcU0OyjEctH3k/+rF4tR7fk1UMx0jPXKOCHalFyWxGaFp4glThZC5PV?=
 =?us-ascii?Q?fzgYKGJoVaf/hMpWWUNqIjmJTc9YSuZTTqggeguWFFbBl6uv9aUjpqneyMzT?=
 =?us-ascii?Q?PuCOa41ZKrxi/zKK6+LZeMi5K5rnY3GQ+iY4DoT5oAXjE1CCWnX+fa/yPhGT?=
 =?us-ascii?Q?MrdO/eQGzkpzigmkLg+kCEvmzIXo6UA8Qta3KpyJwbnT30fdFkUatJ1AsTg6?=
 =?us-ascii?Q?Pd6+ADNd+0Ac+/y62+zBYkscPzTCwR5zZQYGW0qgy8iDaWcC8zjAe+fF6eJw?=
 =?us-ascii?Q?x3fQ/qgJ16oFssbn+Jl1PxBdDQQtq6/A1HeoBk4p6bfV5gS6FrF97Ho5U5K2?=
 =?us-ascii?Q?DXDdJUgvCjZFn00a3GFQqc6lRYYUqKVLSq90GAhKTMrw0J34yrWiudwA5ykc?=
 =?us-ascii?Q?ogqol+lLJJsGs0GHSK/PMY/iSTnfXQh45GyOc7/hz3Ba+3c5E3qdA3v8C7Y1?=
 =?us-ascii?Q?iwjJnJzugUZenOTAowxP2jvmHyrLZb3cKsYSrDCS8DZS4Uwy7/XK0pgBsKo/?=
 =?us-ascii?Q?IX/7nrXFUh/hTSAUSxkPCAJHi+M5OlHwy3kaE+ItKNtQufbqcKp+IP55IKVf?=
 =?us-ascii?Q?oICjGv561EkikBFU7LoyWfWlZ2wMkpNXwjwy8iIYO53ornOvd5QDhbGda0+R?=
 =?us-ascii?Q?OCSJUawRL2f9vmKb0I5VqEhgqWCNSso5cDOL2GZvbRV6mmU2zl6tj/zeNfBp?=
 =?us-ascii?Q?u+WOkTL4GmLv+t5rVj/F4AZyU60c51q2dnoBWJIBqbcIUjnAO31coO5FARo/?=
 =?us-ascii?Q?AXJpt6mAQ3gTNnWRubwp2HBOfJsWaYI6rrOg40niaUJeq+A2X8g713sMPRpf?=
 =?us-ascii?Q?9Io1VwbkT1DKPmp/XBTbpzqTRZEGt0LwVD9LvPu+2Qp3eDfX36g7D93nmq7w?=
 =?us-ascii?Q?W/lVOiFtEjhmMboYj/Ax/bON68Jk9fdkhxE7yjZdY9Xmm/mr8nKpbZBmu+gE?=
 =?us-ascii?Q?j4tPEIlgfzwflmUGPbCKnH8OAJnRmH6+OBqGfv2csUaQuRWsruQQxwi5SiyJ?=
 =?us-ascii?Q?3CARFD1YPHl7nrR+aX96SI9IA83o/4K10YMQp4PxZeyOwNGkeLQGJHtKjCUA?=
 =?us-ascii?Q?AGQ3131dwhQiU/zb7iRkHV5YDd5figTEJ79EimNkCJn0umOBMQIuwAlv7ueZ?=
 =?us-ascii?Q?kmVsFzteJ55nLx8bsOfkQthCd9RZ6bFfWmzf7Tjdcb5VzYEh6mDeLty93qqv?=
 =?us-ascii?Q?Nm2UrEkepgeeAKqAhGpK+C6QInP0wMktBKXkgyAV2hWMVVbmmIyg5zFRIH5h?=
 =?us-ascii?Q?eQ3LJ3A0Q8N5XKcWtpx2yDsUxmarObhgXv12Wk0xFuPc0M6bw8mbK6ayo5Z/?=
 =?us-ascii?Q?wZ6fue3ztUnWk0ILCmE4XffU6T/3YyejJsNLF7JiHFuAmZ3cmiz8N3GrIT6O?=
 =?us-ascii?Q?k6Lgq3byQCzEljHknJYYiKwQ9zhZM9k9IuXqs1S23r9bMrJ5gR38pPiJIbi3?=
 =?us-ascii?Q?+A=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 117f9fff-f2ea-4337-b7cb-08da91d1910c
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2022 19:37:29.5475
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JcAj3spnixROG+NSfoKq/m/vacGFKscgs32Be9x8+VSioiV0vfFZMWAohzHmzi7OqBjD3+GddRh2BObvlmAlOWf1BB+gzlr4hTM9AIQjc+E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6532
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-08_12,2022-09-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 adultscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209080069
X-Proofpoint-GUID: WL5BrnCY63mb4Sx7NivenuP5kZNUuYhp
X-Proofpoint-ORIG-GUID: WL5BrnCY63mb4Sx7NivenuP5kZNUuYhp
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allows the macros which test, set, and clear hugetlb specific page
flags to take a hugetlb folio as an input. The marcros are generated as
folio_{test, set, clear}_hugetlb_{restore_reserve, migratable,
temporary, freed, vmemmap_optimized, raw_hwp_unreliable}.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 include/linux/hugetlb.h | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 852f911d676e..0952ea50251d 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -615,26 +615,50 @@ enum hugetlb_page_flags {
  */
 #ifdef CONFIG_HUGETLB_PAGE
 #define TESTHPAGEFLAG(uname, flname)				\
+static __always_inline						\
+bool folio_test_hugetlb_##flname(struct folio *folio)		\
+	{	void *private = &folio->private;		\
+		return test_bit(HPG_##flname, private);		\
+	}							\
 static inline int HPage##uname(struct page *page)		\
 	{ return test_bit(HPG_##flname, &(page->private)); }
 
 #define SETHPAGEFLAG(uname, flname)				\
+static __always_inline						\
+void folio_set_hugetlb_##flname(struct folio *folio)		\
+	{	void *private = &folio->private;		\
+		set_bit(HPG_##flname, private);			\
+	}							\
 static inline void SetHPage##uname(struct page *page)		\
 	{ set_bit(HPG_##flname, &(page->private)); }
 
 #define CLEARHPAGEFLAG(uname, flname)				\
+static __always_inline						\
+void folio_clear_hugetlb_##flname(struct folio *folio)		\
+	{	void *private = &folio->private;		\
+		clear_bit(HPG_##flname, private);		\
+	}							\
 static inline void ClearHPage##uname(struct page *page)		\
 	{ clear_bit(HPG_##flname, &(page->private)); }
 #else
 #define TESTHPAGEFLAG(uname, flname)				\
+static inline bool						\
+folio_test_hugetlb_##flname(struct folio *folio)		\
+	{ return 0; }						\
 static inline int HPage##uname(struct page *page)		\
 	{ return 0; }
 
 #define SETHPAGEFLAG(uname, flname)				\
+static inline void						\
+folio_set_hugetlb_##flname(struct folio *folio) 		\
+	{ }							\
 static inline void SetHPage##uname(struct page *page)		\
 	{ }
 
 #define CLEARHPAGEFLAG(uname, flname)				\
+static inline void						\
+folio_clear_hugetlb_##flname(struct folio *folio)		\
+	{ }							\
 static inline void ClearHPage##uname(struct page *page)		\
 	{ }
 #endif
-- 
2.31.1

