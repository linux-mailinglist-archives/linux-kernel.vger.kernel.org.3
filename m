Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 117B453F071
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 22:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234265AbiFFUqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 16:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233257AbiFFUo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 16:44:26 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B4F6FC4C3
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 13:39:26 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 256IwlxY031341;
        Mon, 6 Jun 2022 20:38:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=eL5qcsZiSIZ5J1kWSXblYsbuTU2Y1/hUPdYwh+A3GPQ=;
 b=yevygIVZZj/MEFsAC58tEZpjvCxoFM9rJbdQNDb2IuoAtcR2n2Njn9O0+RekXLzynZtW
 qwsVbvky+vFZfhEp3tHIj+eaNd8iheVGoaSRGVfuC9xR740VtPjOXlEF5vbEdghgNymP
 OFXGUHPGxoBqLD+1HqRVQ/IpMce+ynHQBo2NHzJKz3uQxY9w3ffyAdIK7scLH/ljT+98
 Tjrvk8RcSaQKhGnsqt9/lnHZsxD6Me+gZY2hKIF8WrCeNCzFh7p8oHFT6B2nzeSHzvCL
 dzjm6IJD10rzLt1YcOBA/uulSQXGTeRrPUzl/3oXjgMx9QdG7b7eoVyLnpYYhAu1cMRj RQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gfyxsc6j0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Jun 2022 20:38:05 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 256KFtm5001319;
        Mon, 6 Jun 2022 20:38:03 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2102.outbound.protection.outlook.com [104.47.70.102])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gfwu20r2u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Jun 2022 20:38:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WUS+UxHoZSp9h0kOscwe56f8fHC21FeYELu6BkqsDCZTIQZ5lm/pzqrmiKCuJwTveB+yTzPet9syNUta5Rabzk5r4zmby8raNn8+LjRSyM9K/ICwIB+MrfVRKEheqPENE1ZY1Jn1Q7BNVKofmq6mbfynojn7ktfDiFmwbqTHDPM3vrYSnMxBh/jCWG33W5i/YQwKG1ggkmGDc4AGcM+jSgyHNzhkN6ILrnc+HKPFGiVDzs+mQjgR7oqxenTMQ4gCdJRu9Q8Ywd0BlHbIEjwasIgKitvk2Ao4vwI0WA8YnvUJLKI+NY46i9hz1eMCN1TeK/OPVwgTboLgSG27oKd2kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eL5qcsZiSIZ5J1kWSXblYsbuTU2Y1/hUPdYwh+A3GPQ=;
 b=FDlPhzGNaRRcoZeMi0mI2HDg9p1ZknZBNA7WdvsMp0M7eMiROtk3qWYCmY6T0btYt++t8wF8wI/QAOCHiwAH1Fu0bgZqmZSUmmX8Ji/lN8oEn8m4cngP6TA4deaine8FspcODm8cr3IFzUkKMTfUhtc4xOzbiAvLTv7yqUjf1ugwElptc9N+An2uXatZmoIv+MzNTwaWYqVzqg2oXLuSC/9nZulyhAZWR0zZXwD2eCmsFdZEXgfqPX5US0sCisL5V19NPcbvSi2GuzWiZ0OxksBQc4mKYk2h2Zom3lVQbUabWoUtFDGp/XVqLNcY8uiLICxEQfe8wyeAIOOjbeQeTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eL5qcsZiSIZ5J1kWSXblYsbuTU2Y1/hUPdYwh+A3GPQ=;
 b=mWzbcMX6y14+OF0ZV+wmhQb3wU+5DuT580QltXT9n3WyTDapv0TQN7LKdZRm0XeHJryN9gQmtecPGtLTXpC0b6QZi/Hv5nFmWTpnxXyRBMNMcJEpvM32iRCCti4B1ecuu80lJZy8ppzVD70HEi2Ubn7vyO43PoAc4s2JAGHN898=
Received: from DM8PR10MB5416.namprd10.prod.outlook.com (2603:10b6:8:3f::19) by
 BN7PR10MB2596.namprd10.prod.outlook.com (2603:10b6:406:ca::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5314.12; Mon, 6 Jun 2022 20:38:02 +0000
Received: from DM8PR10MB5416.namprd10.prod.outlook.com
 ([fe80::49dc:6a95:a2d5:fc08]) by DM8PR10MB5416.namprd10.prod.outlook.com
 ([fe80::49dc:6a95:a2d5:fc08%5]) with mapi id 15.20.5314.018; Mon, 6 Jun 2022
 20:38:02 +0000
From:   Ankur Arora <ankur.a.arora@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        mike.kravetz@oracle.com, mingo@kernel.org, luto@kernel.org,
        tglx@linutronix.de, bp@alien8.de, peterz@infradead.org,
        ak@linux.intel.com, arnd@arndb.de, jgg@nvidia.com,
        jon.grimm@amd.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com, joao.m.martins@oracle.com,
        ankur.a.arora@oracle.com
Subject: [PATCH v3 09/21] x86/asm: add clear_pages_movnt()
Date:   Mon,  6 Jun 2022 20:37:13 +0000
Message-Id: <20220606203725.1313715-5-ankur.a.arora@oracle.com>
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
X-MS-Office365-Filtering-Correlation-Id: 64c30f3d-a8c2-46cf-5107-08da47fc735f
X-MS-TrafficTypeDiagnostic: BN7PR10MB2596:EE_
X-Microsoft-Antispam-PRVS: <BN7PR10MB2596B0DDE4185314CD04119ACEA29@BN7PR10MB2596.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XSH8WRZJ2kak/iLHg3MfNXvBR4DWMZ0tNBac0GQ85xhKN1M2SpW2VD7FApM/qmxBiF5pYNgDVEqYyQ6/Yyjcplu1DkRCkYrJ1mkzqPOsUAf56k1P3N3QyUCnODGZ4r8WxmCpf5bNBc62Y8RpyGy1Mb3cASBxUlQoR+lauRMUzvHCPgvDyfRaJMJP76wv3FdM4+ghfkRgGBgaDp35g5PoZB7bLpPxJKd0r12kCIyhbk3WNdyr8ASKMRkB77cR6PfSFWY0pWc+Kx7kMdVE8t7mA0FlhK8jRs1WZQoH+gMWjJDm+cpd/Z7SToxSGtk1/nFNFwwXVjVSNLf2hqI0aeSO3gCdhqOIwL8IwsQvlfgg/C3qYOaieH0pQYgGN0JnZuwNzqlXHNlWLBIAdjRIbWx3U4TzDh0fn1bOoETR89m3w64F+oqi8ParHO/7AVw46UJjyUAqAm0n76w5MDtPeqAXUc/FGGNeja8QZ4R28gIMpPA0WufATmV/vgkUULsLHvwO4msHAp9mztwh4yOYeXQw0EnEU2ix1BbR9RDlxoIuG/yqqPJl90wknjiVJbsMU3VNAxWf0t4TENP9A3mXkFesXmG5Q4wF/5at3adQnCZACBCchNIO/TM6JfLhZJy6HMbByW3lOiOStATnPpQcYmUwcs22aIsLpm9MtzzQSRPkGSBun8y+CAX6k0/5Rde9e3PRIFzEjw2W5pxMrZI0/GhSGQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR10MB5416.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(83380400001)(66476007)(86362001)(4326008)(52116002)(66946007)(66556008)(8676002)(103116003)(26005)(6512007)(6506007)(508600001)(8936002)(6486002)(5660300002)(1076003)(107886003)(36756003)(2616005)(7416002)(316002)(38100700002)(6666004)(38350700002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PYHJgaeRKuns1B3PpeFt/3ZAk9cmcBMG/pVs6jNm7E0xXH+S+4lOmq0izUwz?=
 =?us-ascii?Q?vzzfwGg+OC1lyXJLRgF3e4tLzvzwOcBqmxVyKzrNQga9lpQEimSfarMOPx95?=
 =?us-ascii?Q?zFPn5NDW8IZpy51825jkHeYxR4ZoFnX7gyaFqiFpeFzoubE6c+4PSNnhtjoJ?=
 =?us-ascii?Q?crfTx6V9xD+eBxn/5lEunVJRLyaz03+JbKBf1EwI7tcvkoaMFPlIExNtnwvl?=
 =?us-ascii?Q?U6h4o4sSQI0KvcPzDeAukQOn3vnKnh5OaNSN3DZPOzYloQwYZT0hejDS32TH?=
 =?us-ascii?Q?kvxzf9u++thjEypvyppZ26t0KNUvMyfgXI+HVCV16QiK+kDBtztnRPNdzZ35?=
 =?us-ascii?Q?oRasz6xSKOsQ7FBo9D7VMgKFBpyeXWeAOIJsgU8OOs+liMdpugqqSrxzBH3o?=
 =?us-ascii?Q?55d7L+VfeZPAjZ3QTwBT/3uFrYBJYgq6cV5HX5iDv2frRmSLk2nw+oV1tlda?=
 =?us-ascii?Q?tf7zG+lQEwXO+2LWY6paK4C0UHltOTBmefLnqUJKjpyF2AqqYWuHQa4BDZTA?=
 =?us-ascii?Q?rpk1jBsKd3PcJsWC1u0rhPCv1EHXK4HtqI3gFE5Dz/1VoPCr8IHOMZTdHJej?=
 =?us-ascii?Q?Gwpx0LkH+gN4I2iajXy1v0X/odV4y2gBmVKEfqVlLavOkBQ0qQXM6hXmUevM?=
 =?us-ascii?Q?h1YH6vdDLkNd34L8grGzTfp0ynM5A+CjmeW4H6U9gxAxflz1EBbgqDYU5IeR?=
 =?us-ascii?Q?ewFrpksTW+FyU8ma6BZ9xzrg/lyEi7Gx2n1l8da6haNsy2jOf1qTkuTq6Tlp?=
 =?us-ascii?Q?6ZUMdC+XpwxB37vPXmuRDDp0iJwX4RndCeA2GTvgwqwG6KUxXUMWRdqx4jSU?=
 =?us-ascii?Q?AwyQfS4fTzrXkEZqCuU2a/Jgl3SP63XM8MfQDp3yBH+szsq/FMxlyWl668Y8?=
 =?us-ascii?Q?J2ZWxCJnEbDUByFwoPUQFa9D24BY6293gm2QHFsFk0Vx+7Z3tbMKmC+P3THW?=
 =?us-ascii?Q?7eJWp8+63RWQIUwfFOquNsizf60ZOstBx6+E7e3V6k6OVFGWxHSrkZrRvqDY?=
 =?us-ascii?Q?RNgDI4ODszpWxwFMpV5tSKl/cCgySeYaC6Ost6ehMDHc39qYr1jddpP1BJXk?=
 =?us-ascii?Q?zAfgM7Hkofh+zifmld4bzEi3UZbaU3b0FIJb/vyPNReSzIV2WhimyaftCsTI?=
 =?us-ascii?Q?E3KIqWIq7zSLouWOGiDdj/u3kCxZ3ASsm5YHzCzNs7Mci3T8+MyrPJVuqt+u?=
 =?us-ascii?Q?ULIEKa3fB/cVLhq8dmIe4SxY7YGrKTdbHvbyhEM+1kCH7YVVSNF8j69H9pzQ?=
 =?us-ascii?Q?KyO1mq31mZnnf3CDueNNW4pWLDlXpBjbvtuDT04l0ah1+JNMnbAzsCG0n3F7?=
 =?us-ascii?Q?EJkKn5anbE57mayE5jDQjy8PGRUIpDuChkOiPj9eUPj22ipaySTniKjH4Byh?=
 =?us-ascii?Q?1b57d24FaUwAoyewFTeYlNv5hiUVskUfgwOSDhIkewSj6Y9eU0eLZmLpfkWT?=
 =?us-ascii?Q?xvovhpS2Ifotm2CFluh55oLUjn2Vg/T+sZyUXGvRYLJ9+B82zJxcyhrz4QWi?=
 =?us-ascii?Q?nF9J5xAQIyI6t/+5d0PVf4F9u4oZQprroQDKrZKlkZ7U+HMs1xNcvXwJv8SG?=
 =?us-ascii?Q?gi2s4RNXiPkUZfZzZ5RKg12qYtenJVBZyENiU+qWiryXZS6PSSSHoEIfEEbj?=
 =?us-ascii?Q?oDO/VUkgO0kNUff7YrIi51sxYI6F8ptan9rovH7+jNnZDLm64Czim8HPomQV?=
 =?us-ascii?Q?zgAuTYSTaHWG3MweT6t0J10b89vy94vSrqPciAIs6jhngFWtr/3AjFDK+fQV?=
 =?us-ascii?Q?KqX5a8ed2S9hy7/mMz18o3XcAKSYQBE=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64c30f3d-a8c2-46cf-5107-08da47fc735f
X-MS-Exchange-CrossTenant-AuthSource: DM8PR10MB5416.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2022 20:38:02.1178
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GJf0u9W4+IQ9gbojQpnXOy6HjyDIo3nvSoONtZEmjfFpncg8VrnZEMbrD+DVgNu9H6Q5uJeedGoQ7SLwYf2BeOzD5zziymbXfTKap6SHISQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR10MB2596
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-06_06:2022-06-02,2022-06-06 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 adultscore=0
 spamscore=0 suspectscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206060081
X-Proofpoint-ORIG-GUID: PzDcp0hrTT5fkCfnLjFQGqmyc9VxQ1SN
X-Proofpoint-GUID: PzDcp0hrTT5fkCfnLjFQGqmyc9VxQ1SN
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add clear_pages_movnt(), which uses MOVNTI as the underlying primitive.
With this, page-clearing can skip the memory hierarchy, thus providing
a non cache-polluting implementation of clear_pages().

MOVNTI, from the Intel SDM, Volume 2B, 4-101:
 "The non-temporal hint is implemented by using a write combining (WC)
  memory type protocol when writing the data to memory. Using this
  protocol, the processor does not write the data into the cache
  hierarchy, nor does it fetch the corresponding cache line from memory
  into the cache hierarchy."

The AMD Arch Manual has something similar to say as well.

One use-case is to zero large extents without bringing in never-to-be-
accessed cachelines. Also, often clear_pages_movnt() based clearing is
faster once extent sizes are O(LLC-size).

As the excerpt notes, MOVNTI is weakly ordered with respect to other
instructions operating on the memory hierarchy. This needs to be
handled by the caller by executing an SFENCE when done.

The implementation is straight-forward: unroll the inner loop to keep
the code similar to memset_movnti(), so that we can gauge
clear_pages_movnt() performance via perf bench mem memset.

 # Intel Icelakex
 # Performance comparison of 'perf bench mem memset -l 1' for x86-64-stosb
 # (X86_FEATURE_ERMS) and x86-64-movnt:

 System:      Oracle X9-2 (2 nodes * 32 cores * 2 threads)
 Processor:   Intel Xeon(R) Platinum 8358 CPU @ 2.60GHz (Icelakex, 6:106:6)
 Memory:      512 GB evenly split between nodes
 LLC-size:    48MB for each node (32-cores * 2-threads)
 no_turbo: 1, Microcode: 0xd0001e0, scaling-governor: performance

              x86-64-stosb (5 runs)     x86-64-movnt (5 runs)    Delta(%)
              ----------------------    ---------------------    --------
     size            BW   (   stdev)          BW    (   stdev)

      2MB      14.37 GB/s ( +- 1.55)     12.59 GB/s ( +- 1.20)   -12.38%
     16MB      16.93 GB/s ( +- 2.61)     15.91 GB/s ( +- 2.74)    -6.02%
    128MB      12.12 GB/s ( +- 1.06)     22.33 GB/s ( +- 1.84)   +84.24%
   1024MB      12.12 GB/s ( +- 0.02)     23.92 GB/s ( +- 0.14)   +97.35%
   4096MB      12.08 GB/s ( +- 0.02)     23.98 GB/s ( +- 0.18)   +98.50%

Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 arch/x86/include/asm/page_64.h |  1 +
 arch/x86/lib/clear_page_64.S   | 21 +++++++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/arch/x86/include/asm/page_64.h b/arch/x86/include/asm/page_64.h
index a88a3508888a..3affc4ecb8da 100644
--- a/arch/x86/include/asm/page_64.h
+++ b/arch/x86/include/asm/page_64.h
@@ -55,6 +55,7 @@ extern unsigned long __phys_addr_symbol(unsigned long);
 void clear_pages_orig(void *page, unsigned long npages);
 void clear_pages_rep(void *page, unsigned long npages);
 void clear_pages_erms(void *page, unsigned long npages);
+void clear_pages_movnt(void *page, unsigned long npages);
 
 #define __HAVE_ARCH_CLEAR_USER_PAGES
 static inline void clear_pages(void *page, unsigned int npages)
diff --git a/arch/x86/lib/clear_page_64.S b/arch/x86/lib/clear_page_64.S
index 2cc3b681734a..83d14f1c9f57 100644
--- a/arch/x86/lib/clear_page_64.S
+++ b/arch/x86/lib/clear_page_64.S
@@ -58,3 +58,24 @@ SYM_FUNC_START(clear_pages_erms)
 	RET
 SYM_FUNC_END(clear_pages_erms)
 EXPORT_SYMBOL_GPL(clear_pages_erms)
+
+SYM_FUNC_START(clear_pages_movnt)
+	xorl	%eax,%eax
+	movq	%rsi,%rcx
+	shlq    $PAGE_SHIFT, %rcx
+
+	.p2align 4
+.Lstart:
+	movnti  %rax, 0x00(%rdi)
+	movnti  %rax, 0x08(%rdi)
+	movnti  %rax, 0x10(%rdi)
+	movnti  %rax, 0x18(%rdi)
+	movnti  %rax, 0x20(%rdi)
+	movnti  %rax, 0x28(%rdi)
+	movnti  %rax, 0x30(%rdi)
+	movnti  %rax, 0x38(%rdi)
+	addq    $0x40, %rdi
+	subl    $0x40, %ecx
+	ja      .Lstart
+	RET
+SYM_FUNC_END(clear_pages_movnt)
-- 
2.31.1

