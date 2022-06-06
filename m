Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A16F053F057
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 22:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234088AbiFFUme (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 16:42:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234389AbiFFUmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 16:42:10 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43629E15FA
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 13:38:24 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 256KJjkU030080;
        Mon, 6 Jun 2022 20:38:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=xs1FcMyh1+cEu2F4KtfsVd2nLcKLmWoODKCscmnpE4Y=;
 b=vw1/ZGM2qjIcmbBDh+V3x40NuWLEfWFCiIKr+VtqLd31me8HBf52u0Ysb3WiTLhgATZb
 i6O1xnfZnkEVlBHje157sMPbV7rggkg0fUhfi4a9UTO2AOYafzcFUZqzgl/n0CJmTUPM
 5pBT+a3Zb+H6+PyRcWpP6XypNJvTbovaDGFzmcbj9hR+XA7GBVKvez0jB21kWo7pVO3/
 wDY2sIUECuKkrAE0CH0nWKKxF2kpRK5mFzlq3mqtF5i1mQCmymfsZMYnUoz7iL1TsAZU
 3AaUYBF1uxig6le8XI2wRbovVFbdmvJUZJvgpNh6umiKGAbEmFqNEFANax0TWBQruN6+ dQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ghqad85qp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Jun 2022 20:38:02 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 256KGEiq003232;
        Mon, 6 Jun 2022 20:38:01 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2107.outbound.protection.outlook.com [104.47.70.107])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gfwu2c3xp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Jun 2022 20:38:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JOOXYVyLTz1/semgq+DTfXluDjUuSH9Avv0SUJM2HYqpcy5NRn4esBT+Ab6CVHDh12EcOAA6/XfK1c/mkNcg+8PfbkHi33raNd15WuwpBQ+f/FbeKPi22Xv5XF32XyfrOkcnc3Ux+BMyS335plWAaFGqRBkU0ERdHISQuR47yyQYkvKUZnFu1vavj+VeUndMPah9QgsMW7TQMXIwwslnUkkhl2GZIVAaaZtiNZc4XkjO3zW7E8RIqh2t+EBFNhtBd7NgASdTz+NegHKg3S7IX43ssQdzZX5wePzHJkPVe2U0FImYmdWnlFfNvPappoM3wcZ5p0PpYJ7gFGgRfNmvtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xs1FcMyh1+cEu2F4KtfsVd2nLcKLmWoODKCscmnpE4Y=;
 b=EjngPIg1IwCU2WolRv5TKgDe7dYTiOu0MYIOl4yqvHAeDJYgysg8FLJmSO/X5+4h4BB4zRXgeYBrgKMEw1If3onRteyaLBgEuyXjCGrlaUjs5moQyQQnSuEbuM1Otu4xrmRLDZqthnhpuUYka8GXk5AEfBgDPMfd8D0eFW3dKykdW6+Rjy2Y8/DMXOLPd1PPckNdzQlF26JWgensFZmIhjy1bo3a6hltpr8VH8TFcYb0q6NWuFvRh4PmpMshGaNG7nU/yoC3tDuX0nq1f7kYLGB8WprCiPfgDPcxZtkQeEpdyXIOjfJJkdsC5LRYtPoHTlpg1yx2/zGyMFcTXTbikw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xs1FcMyh1+cEu2F4KtfsVd2nLcKLmWoODKCscmnpE4Y=;
 b=frEqrL4xdqBFzqzF2eG5VNtDfAYbpqM1pGIxGsOg4FjPuJGVPhOTMYwA2xC9Me97H4lE3JRHvYlY9kyAE0MpIoovPh93LXs473DSDOfy+cZ2soPPUu8gDLh7eBMgRlOHbmbqrDeWNyL2GSqJw60Wnvm2fwZ0Y6v7nSr6EPAE22I=
Received: from DM8PR10MB5416.namprd10.prod.outlook.com (2603:10b6:8:3f::19) by
 BN7PR10MB2596.namprd10.prod.outlook.com (2603:10b6:406:ca::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5314.12; Mon, 6 Jun 2022 20:37:59 +0000
Received: from DM8PR10MB5416.namprd10.prod.outlook.com
 ([fe80::49dc:6a95:a2d5:fc08]) by DM8PR10MB5416.namprd10.prod.outlook.com
 ([fe80::49dc:6a95:a2d5:fc08%5]) with mapi id 15.20.5314.018; Mon, 6 Jun 2022
 20:37:59 +0000
From:   Ankur Arora <ankur.a.arora@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        mike.kravetz@oracle.com, mingo@kernel.org, luto@kernel.org,
        tglx@linutronix.de, bp@alien8.de, peterz@infradead.org,
        ak@linux.intel.com, arnd@arndb.de, jgg@nvidia.com,
        jon.grimm@amd.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com, joao.m.martins@oracle.com,
        ankur.a.arora@oracle.com
Subject: [PATCH v3 08/21] perf bench: add memset_movnti()
Date:   Mon,  6 Jun 2022 20:37:12 +0000
Message-Id: <20220606203725.1313715-4-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220606202109.1306034-1-ankur.a.arora@oracle.com>
References: <20220606202109.1306034-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR03CA0010.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::20) To DM8PR10MB5416.namprd10.prod.outlook.com
 (2603:10b6:8:3f::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4ad4c885-5b78-43be-7f2b-08da47fc7189
X-MS-TrafficTypeDiagnostic: BN7PR10MB2596:EE_
X-Microsoft-Antispam-PRVS: <BN7PR10MB25967F5E24232CE8F4C109D6CEA29@BN7PR10MB2596.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MnyJaBJb31Bjh/Cq5C9hbYebwZcZz8T3s82k1eB2KKdX5TuGY9OlcAvo+O0yxdPGtjMssitNJaqsHJUc/MsY+bsG2lz4zfUVXhzhODZ1ZN67qiALVC18OMrvORq6RVfN5pCVSPV7RArt0KIQ/0jJ2cPWJUw2DRygES194SOEETrfX7R/9tx4PKndaTU3bDq/s669Yf31XQL0cTHE2m5MwQAd2HAecXxu2ih4Enc3YUBh2l3hyc6EDiw4IWC1SHf0uoNRo1bAe6NFGH039V37+A/H7E+pyT//1GgOs7x/hHqsmKIBF6Fnjjr76WAK42XdhBkA3Izm14Yji0qM/uV6ytqifAVU1rvxQV49+Spxvx/F0FcY81y4cQOBrX2Vhpddogjdeyfb8P2i8NCV2DLYwVYyM2m5IXKzguuwl4u2s56cphBSODMP7nOJwKzA+/cKcAODaLUKGfBTXNR6HOqeVAnwK2dJWlP+lJ3JFTZFNzt1T2l1/RiAAD300Zpv54Qfci8Z2mmqQQ6Xyiq+vTBxzCnJLIEiLh1fgq5Ov0Rz6q9TnpuuL7hVGvwiN9qBXs8lNzbj/qsV2l2yDNa6HJmsHGo1W7CaNGUBxl5Zce3d3r3rkzfXnVF2bzVbWJZct3p0rr+scqHL1dDnv0nKvqAPBkAVhI1FNcUCXWt0wJPMeVp7jLvVbOObb0ML9lxKLfLiPx5Jm4AEk6JJi3++KsUwqw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR10MB5416.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(83380400001)(66476007)(86362001)(4326008)(52116002)(66946007)(66556008)(8676002)(103116003)(26005)(6512007)(6506007)(508600001)(8936002)(6486002)(5660300002)(1076003)(107886003)(36756003)(2616005)(7416002)(316002)(38100700002)(6666004)(38350700002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+csAo9DkQOd7CHL7ByfpLE2uvEmjzIY/eHavsgcYpeHIesvxtL8htaQEVpAd?=
 =?us-ascii?Q?FOXBdG2Hn69y+OJR23aaiOcUj25/qfposfrqdCECKMU1KZjGjNvclLBNrJNw?=
 =?us-ascii?Q?OVNQYOzR7iwswQinzFMXpzJFNPu8J1N53rn1/dmqNJglhtfh0gV/5Fmo9W8m?=
 =?us-ascii?Q?LP3+/H3ii0QlAL1uBoVROTBhJiS0Gt1afL7o3a8JwHGVBwfI5xRnLRuYv1Wx?=
 =?us-ascii?Q?qz60US2MPf1MgIsSlTFZl8Vwvu7oyO6FDUWgXMW2rB+4IzuhChTSKe+oDtJo?=
 =?us-ascii?Q?4HXP37x9vFGjWQH8ttlhwpuCNhjR3MWAg8lggWmeRXohtpitTLu3T22w638J?=
 =?us-ascii?Q?DxyZxwSU4e/56ael5m09aNjDdPbOhK7w076jvfwtcqFdbudnqDZMylvxHLXR?=
 =?us-ascii?Q?6+hbtcdsEYVRkTIHc+o9Zy8SaTFRw8MlXhOfOwCUfdKKMJiUv3LQXyOEqZwo?=
 =?us-ascii?Q?TIl+JzLO46NLh8qnB8rYvCt5+seAcO4V4mxee4tfRUxTwKG/tnajld9xnsC8?=
 =?us-ascii?Q?CgI1iIxq2gVZ3i8KHscDtvq0kWORX25pYQ4uHgE2pHSRv9oNQwwqZkHxQdth?=
 =?us-ascii?Q?kEsi3/xhTtPlVSqM49BKISq2IW6iSOVfm367snhTcR9jhia3hjekCKEBeDZb?=
 =?us-ascii?Q?Ig/PtDg18KJm/BEUFCUnrHvyQ3qUVUPHlXcwO3xqQMEbZxK0GmuILzuwrlUh?=
 =?us-ascii?Q?V6KITecTwxj6frQePx1IUZ3MtesWCIlKSwr8r/nF1koZ0O9hdyeSvJEsGD/b?=
 =?us-ascii?Q?2JMFHkm/Mszsl/Nd0RZqPdDWhIWk5z+dY8LZ7fW0rImt6Fpwun+2j8wZrTF7?=
 =?us-ascii?Q?oFvG33bBnaPsSOBi51TUkbjbdo71xrG5wyGU9AnxnUM3wxH6+j/HG2CB4pwK?=
 =?us-ascii?Q?cOHHHTNRZ/RiIWc+AexfRk7LVjge8IQDB4Dtxee8kIdXPoauBXUkuZNHEeom?=
 =?us-ascii?Q?GqL2YVIB9odhupefsBvF94Sm/YaOwnowZwaEEXX1Ohnazn0VSx2t0Wd7IvFI?=
 =?us-ascii?Q?8AndfNttdjm9z2BOMtkl1WFL8M6JDloyWLqrUcbvBw65A4lCWHZuvwTfagwb?=
 =?us-ascii?Q?W3A+ikXMxuXDvQeG8P/Ve325XexKRtr4AtHpnHV3pWOeZRCHdykns2wDG+V/?=
 =?us-ascii?Q?o5ExE2D7jbL1QO71WPv6dICOmyaAdYDcsSto+DRFnvd35EsXQt3g+7SENx0k?=
 =?us-ascii?Q?75smeLcIdhDBYRxKoOE89XmsOVdLN0+t79QNLQ81IBalvnLkf420SdamIhSb?=
 =?us-ascii?Q?cwE4mycSnMAiBJMvDb+pTMVHirM33hGrLJrcuK0m2zNnDPnwKkyX812SgZg0?=
 =?us-ascii?Q?K8Soy+rta/QZqgzER5lPcdlJo2oH+5sjEzUIM/exbc3JqlvRqGBiXo6ENZlL?=
 =?us-ascii?Q?jAcYhG/hCCa9CPlyJdcFhAIX3RJIgSuQKfdINGcavcPmRgGUb1HJiCQehk3k?=
 =?us-ascii?Q?vDNoJRlALkI/ix+Kvir5K06Aw+TWfveEBUY4BZ8nHpsgYecColE0Wng+2tt4?=
 =?us-ascii?Q?jOXWoTBx5MJYbwnGeEyzXEgWzrf0Iggbu9C487nYG6lyT2W9JPBnWOqjZlmc?=
 =?us-ascii?Q?X5CC726l0fHeOV/qZ2d8+LPV9cIkw8CJEIbiD9Buam/IC0u7vo98sR9GvVLY?=
 =?us-ascii?Q?dWyHv3m2Qaby6UbIecMnzfjRvz8dH9jxze0iYNNV7zsDJZk5X/16pFC2lNfr?=
 =?us-ascii?Q?abJwvjUdrjOv8w1K6zdVHkTy+a/VjH//wJoAFOStnCVHE8GAKdtqWhQHn4xI?=
 =?us-ascii?Q?29nMTAOaIJjrazWh94x7nBiWIBxaQrQ=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ad4c885-5b78-43be-7f2b-08da47fc7189
X-MS-Exchange-CrossTenant-AuthSource: DM8PR10MB5416.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2022 20:37:58.9607
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WU946s7Jv3ycaAKcjqPqM6Wv14iO4/ZuDqjIPBx+l64fMRdX3ZxkLexQ/Wit0PC6I4yLfcj6MkpaKwWKj9OMYJmII9SiPEOse3uxzh/b7jU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR10MB2596
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-06_06:2022-06-02,2022-06-06 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 phishscore=0 adultscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206060081
X-Proofpoint-ORIG-GUID: SQc2V6tU3oHxamsZOwoXebM7oJbWV7Q1
X-Proofpoint-GUID: SQc2V6tU3oHxamsZOwoXebM7oJbWV7Q1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clone memset_movnti() from arch/x86/lib/memset_64.S.

perf bench mem memset -f x86-64-movnt on Intel Icelakex, AMD Milan:

  # Intel Icelakex

  $ for i in 8 32 128 512; do
         perf bench mem memset -f x86-64-movnt -s ${i}MB -l 5
     done

  # Output pruned.
  # Running 'mem/memset' benchmark:
  # function 'x86-64-movnt' (movnt-based memset() in arch/x86/lib/memset_64.S)
  # Copying 8MB bytes ...
      12.896170 GB/sec
  # Copying 32MB bytes ...
      15.879065 GB/sec
  # Copying 128MB bytes ...
      20.813214 GB/sec
  # Copying 512MB bytes ...
      24.190817 GB/sec

  # AMD Milan

  $ for i in 8 32 128 512; do
         perf bench mem memset -f x86-64-movnt -s ${i}MB -l 5
     done

  # Output pruned.
  # Running 'mem/memset' benchmark:
  # function 'x86-64-movnt' (movnt-based memset() in arch/x86/lib/memset_64.S)
  # Copying 8MB bytes ...
        22.372566 GB/sec
  # Copying 32MB bytes ...
        22.507923 GB/sec
  # Copying 128MB bytes ...
        22.492532 GB/sec
  # Copying 512MB bytes ...
        22.434603 GB/sec

Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 tools/arch/x86/lib/memset_64.S               | 68 +++++++++++---------
 tools/perf/bench/mem-memset-x86-64-asm-def.h |  6 +-
 2 files changed, 43 insertions(+), 31 deletions(-)

diff --git a/tools/arch/x86/lib/memset_64.S b/tools/arch/x86/lib/memset_64.S
index fc9ffd3ff3b2..307b753ca03a 100644
--- a/tools/arch/x86/lib/memset_64.S
+++ b/tools/arch/x86/lib/memset_64.S
@@ -24,7 +24,7 @@ SYM_FUNC_START(__memset)
 	 *
 	 * Otherwise, use original memset function.
 	 */
-	ALTERNATIVE_2 "jmp memset_orig", "", X86_FEATURE_REP_GOOD, \
+	ALTERNATIVE_2 "jmp memset_movq", "", X86_FEATURE_REP_GOOD, \
 		      "jmp memset_erms", X86_FEATURE_ERMS
 
 	movq %rdi,%r9
@@ -66,7 +66,8 @@ SYM_FUNC_START_LOCAL(memset_erms)
 	RET
 SYM_FUNC_END(memset_erms)
 
-SYM_FUNC_START_LOCAL(memset_orig)
+.macro MEMSET_MOV OP fence
+SYM_FUNC_START_LOCAL(memset_\OP)
 	movq %rdi,%r10
 
 	/* expand byte value  */
@@ -77,64 +78,71 @@ SYM_FUNC_START_LOCAL(memset_orig)
 	/* align dst */
 	movl  %edi,%r9d
 	andl  $7,%r9d
-	jnz  .Lbad_alignment
-.Lafter_bad_alignment:
+	jnz  .Lbad_alignment_\@
+.Lafter_bad_alignment_\@:
 
 	movq  %rdx,%rcx
 	shrq  $6,%rcx
-	jz	 .Lhandle_tail
+	jz	 .Lhandle_tail_\@
 
 	.p2align 4
-.Lloop_64:
+.Lloop_64_\@:
 	decq  %rcx
-	movq  %rax,(%rdi)
-	movq  %rax,8(%rdi)
-	movq  %rax,16(%rdi)
-	movq  %rax,24(%rdi)
-	movq  %rax,32(%rdi)
-	movq  %rax,40(%rdi)
-	movq  %rax,48(%rdi)
-	movq  %rax,56(%rdi)
+	\OP  %rax,(%rdi)
+	\OP  %rax,8(%rdi)
+	\OP  %rax,16(%rdi)
+	\OP  %rax,24(%rdi)
+	\OP  %rax,32(%rdi)
+	\OP  %rax,40(%rdi)
+	\OP  %rax,48(%rdi)
+	\OP  %rax,56(%rdi)
 	leaq  64(%rdi),%rdi
-	jnz    .Lloop_64
+	jnz    .Lloop_64_\@
 
 	/* Handle tail in loops. The loops should be faster than hard
 	   to predict jump tables. */
 	.p2align 4
-.Lhandle_tail:
+.Lhandle_tail_\@:
 	movl	%edx,%ecx
 	andl    $63&(~7),%ecx
-	jz 		.Lhandle_7
+	jz 	.Lhandle_7_\@
 	shrl	$3,%ecx
 	.p2align 4
-.Lloop_8:
+.Lloop_8_\@:
 	decl   %ecx
-	movq  %rax,(%rdi)
+	\OP  %rax,(%rdi)
 	leaq  8(%rdi),%rdi
-	jnz    .Lloop_8
+	jnz    .Lloop_8_\@
 
-.Lhandle_7:
+.Lhandle_7_\@:
 	andl	$7,%edx
-	jz      .Lende
+	jz      .Lende_\@
 	.p2align 4
-.Lloop_1:
+.Lloop_1_\@:
 	decl    %edx
 	movb 	%al,(%rdi)
 	leaq	1(%rdi),%rdi
-	jnz     .Lloop_1
+	jnz     .Lloop_1_\@
 
-.Lende:
+.Lende_\@:
+	.if \fence
+	sfence
+	.endif
 	movq	%r10,%rax
 	RET
 
-.Lbad_alignment:
+.Lbad_alignment_\@:
 	cmpq $7,%rdx
-	jbe	.Lhandle_7
+	jbe	.Lhandle_7_\@
 	movq %rax,(%rdi)	/* unaligned store */
 	movq $8,%r8
 	subq %r9,%r8
 	addq %r8,%rdi
 	subq %r8,%rdx
-	jmp .Lafter_bad_alignment
-.Lfinal:
-SYM_FUNC_END(memset_orig)
+	jmp .Lafter_bad_alignment_\@
+.Lfinal_\@:
+SYM_FUNC_END(memset_\OP)
+.endm
+
+MEMSET_MOV OP=movq fence=0
+MEMSET_MOV OP=movnti fence=1
diff --git a/tools/perf/bench/mem-memset-x86-64-asm-def.h b/tools/perf/bench/mem-memset-x86-64-asm-def.h
index dac6d2b7c39b..53ead7f91313 100644
--- a/tools/perf/bench/mem-memset-x86-64-asm-def.h
+++ b/tools/perf/bench/mem-memset-x86-64-asm-def.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 
-MEMSET_FN(memset_orig,
+MEMSET_FN(memset_movq,
 	"x86-64-unrolled",
 	"unrolled memset() in arch/x86/lib/memset_64.S")
 
@@ -11,3 +11,7 @@ MEMSET_FN(__memset,
 MEMSET_FN(memset_erms,
 	"x86-64-stosb",
 	"movsb-based memset() in arch/x86/lib/memset_64.S")
+
+MEMSET_FN(memset_movnti,
+	"x86-64-movnt",
+	"movnt-based memset() in arch/x86/lib/memset_64.S")
-- 
2.31.1

