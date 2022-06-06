Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5394153F055
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 22:42:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234258AbiFFUm2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 16:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233900AbiFFUmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 16:42:01 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE813E5294
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 13:38:07 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 256KJjsL030086;
        Mon, 6 Jun 2022 20:37:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=O1fUpa0v26fvWXiIeQnktX7swG7rLE95g+TWDuxMvA4=;
 b=f+pGRyCFHhMHM4+MidG2NoM8/6ysbJzyJq3EjVFLirlXTsa7xayogpKjXsIREmMojHZp
 cxT8VwhcdvbbRxFCrvhsJYF7XJ8fwC7wsNMSZy+5wIrAVCut0TFzY8YtdB5ephm8t8Av
 laNOZ/zmJ7WFxttu+WjbMwjZDPgqw6LG20A0s59XBrBav+EfY4Vx+9cOnx2pR4+grziG
 fj1N6WIGn+rtc54dqbtF2TjrXjcWvLr+W2nCZviYJwMY4G7bV8EuxHCv2gN9SOa0Fuat
 pOg2ovxKyW16NCEJV57u8r1oY7w8E/6anRHVi4DG5wowfOvJ+oHM+pdIi0uPjikXmRV/ EA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ghqad85nc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Jun 2022 20:37:44 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 256KFk2K015941;
        Mon, 6 Jun 2022 20:37:43 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2105.outbound.protection.outlook.com [104.47.70.105])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gfwu809rh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Jun 2022 20:37:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U/6GkZH6mjHh+Mvg7ZtddYtZYi7vAX7Yt69GiTP3a705bwLHg12QBNRnYkDMUpzr8pqDi2/DdphBOX4r9mIQp2D94dftaBz3cqSNWvfXBm7wKaQk3nS5RVyQ7RZphZ8RgDwa4cMfzhcARP+zuDNu/fnVGf+STU2Ptyp63cKYdtnocSoiQOPUEeo3Z14qEwABBnoOwzOO0Hi7zNdrWsKochugN8jNX9Cw0owcWaROfUSaJPOpFv99xgtN+We5Xq9T5j5S0aoD6MvTPeWffnxdEepEi/Wa+Ucd+GV+5hTIMko96J8uklVoBv+rykfdJfcPeU035QDESdRvWN90ls6Oqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O1fUpa0v26fvWXiIeQnktX7swG7rLE95g+TWDuxMvA4=;
 b=cKiXJIQnCHIJStur5a1i1WkKlwmfIZ4jmoDrsXRPZYiLojcnKg6Vo1I1Mu49SOnj12ON6MxsIzejprd+FjbVOD77G3cvpbK5p7hwjlAncGZ9OsDmK2xfSkdJfQAdRyU51flt2du+4YTsKRLF8rMQBRDuW0D+/CEahpUGWqSatfeOTqKuoyXPKXlU+PBwHdo1oyrNbfWZJIERNzf2okMpG8ECysfWAb9bjsxTNCGat+Bi6p8ISq7QxeaU2wZ4C7Tx5JkNsrOWahYjdht5BXvZrglA9QJv1Ge6Gds3e4lYScO7zl/vYCl4+RqcS/ynzZHUb56g5BatVmy8VhQukxxhwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O1fUpa0v26fvWXiIeQnktX7swG7rLE95g+TWDuxMvA4=;
 b=hMDkNjQ0FpubwqFY/gtzX4vdsBP3pikWj0j967H1chMmjETnSZ3Csjt10Xo/NknJdaikLqYKX7+X0GhNlrmsevjNqrIdjqHi3OVjDhU7qO+iUe+Bsnp9k1YZbt4UfVEWrJet5xrI3fILDsOrmh4/fkpXnDWQQPMOGakZOSQfhpo=
Received: from DM8PR10MB5416.namprd10.prod.outlook.com (2603:10b6:8:3f::19) by
 BN7PR10MB2596.namprd10.prod.outlook.com (2603:10b6:406:ca::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5314.12; Mon, 6 Jun 2022 20:37:41 +0000
Received: from DM8PR10MB5416.namprd10.prod.outlook.com
 ([fe80::49dc:6a95:a2d5:fc08]) by DM8PR10MB5416.namprd10.prod.outlook.com
 ([fe80::49dc:6a95:a2d5:fc08%5]) with mapi id 15.20.5314.018; Mon, 6 Jun 2022
 20:37:41 +0000
From:   Ankur Arora <ankur.a.arora@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        mike.kravetz@oracle.com, mingo@kernel.org, luto@kernel.org,
        tglx@linutronix.de, bp@alien8.de, peterz@infradead.org,
        ak@linux.intel.com, arnd@arndb.de, jgg@nvidia.com,
        jon.grimm@amd.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com, joao.m.martins@oracle.com,
        ankur.a.arora@oracle.com
Subject: [PATCH v3 06/21] x86/clear_page: add clear_pages()
Date:   Mon,  6 Jun 2022 20:37:10 +0000
Message-Id: <20220606203725.1313715-2-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220606202109.1306034-1-ankur.a.arora@oracle.com>
References: <20220606202109.1306034-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR04CA0008.namprd04.prod.outlook.com
 (2603:10b6:a03:40::21) To DM8PR10MB5416.namprd10.prod.outlook.com
 (2603:10b6:8:3f::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b8649870-19c8-4f89-96ee-08da47fc66de
X-MS-TrafficTypeDiagnostic: BN7PR10MB2596:EE_
X-Microsoft-Antispam-PRVS: <BN7PR10MB2596DBDD2699A2FD45E2D707CEA29@BN7PR10MB2596.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bzplH6Yfy9yxUlR5A4rX0NJVSzqDsUrRolH7XwA9QzihvHuYfDKcxrkKeZT6eTDyHBRKa6Zu5aYo9sjS6DFAtr8BdAIt0fU/qIWWGMpemQ+Wveny4E6FEJJGNiUcMvj7Ni5YUTMDPLrwUn+fZ4kXlAK/PpqJcvIUNiI2wWkWbDPSzF7+VQubJCtFwc6o0eEvrV2+vCOQqNZ4uDpCqiyErTM/HcRILy8IzZiEbXTm8furer8cLkan/Rwst+sym9KI2n7Z/Y/YGE2m8esr26I6r66Npn3YkbNrHpHtIGN0EZ2gxyRZseqAe9VnVg8QxvE1CZJCfUvFNiL1oisQI34inoCWD4lGzBWJcow91Di6M6yyWG1okT6cjqJeJIMWUW/uJ0VMT5D0HYIXO9TrlOa5FkbANs3T9Lo/aE32Q29x5VsuCtPE0MIMQxbUa+nXWsJBywp53W9UM64gmBT+/J2IK69aqJXXXDhGoDgNiVH7GSjGccs9VHWEYhOLZnDpjlFQz/LWdaShsWgSkcm2gJHX6t99cDux+cV/rJDnmtAZOW/Akprcn4f7o9i/FS4MFnjJbaAwu6UXZG2nbHHWc88sm9+nScJANPxjJFVfi6ycXds48fxjP2eDccGo7G7AE3zGv5xEjUvi2BwKjroN5L5Gy1p9sB91EwX00IToEG0PLb1TfTdWBFWDVkbezWY5YlIvfKXHl5jnKXrwgFk0Vazx/A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR10MB5416.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(83380400001)(66476007)(86362001)(4326008)(52116002)(66946007)(66556008)(8676002)(103116003)(26005)(6512007)(6506007)(508600001)(8936002)(6486002)(5660300002)(1076003)(107886003)(36756003)(2616005)(30864003)(7416002)(316002)(38100700002)(6666004)(38350700002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uITih3FbBUkzmBRzKtPbzcHvSX4l4tZzvM5zLLuEhJqx01L1CmVLff1dZhTM?=
 =?us-ascii?Q?Vv+Wi7gNPWrmelg+5K9NMW2pkVMl0uX7rOMTz110XyzltK8nz6xptXXgDPX1?=
 =?us-ascii?Q?ZNdim7sLoKKH4xC7FSedJTdBoRDKurrpVn5BfR1PSTxgzVNPBRgvYrVV3Xtw?=
 =?us-ascii?Q?V33GSQf14T0VFN61t2pEL29RcU4grRfFx4BW9leURYFtM83YhVHTbPTbvjNd?=
 =?us-ascii?Q?E9ym0p8O1RyP3FLgp0vlGFb8SRrqu5LeUYApGF8rXnYgcHavjkPkwMTrporR?=
 =?us-ascii?Q?2tWuA+xVuLX2ipmwjpn8WT//S1z5zwJofMwZF57Wnj/JD5qx3vb46vKlWKTh?=
 =?us-ascii?Q?MTgjGyQfhTP0sr8PD95ZK1LYqk90KebRJHk9Uw/f3e6af65BXtPOcFFZ1T75?=
 =?us-ascii?Q?fk6Ju7vX2LDZHruGZX19UJzOLrqL17O1D5u32YvM37IUSjtoNcqzHQ3n203i?=
 =?us-ascii?Q?WtToqjliUjqwHquqP7xAp7ZoxGD4b4YQRLz/OsPi6r7agG0uIMWgivrNaMHq?=
 =?us-ascii?Q?dzdNIRiQavbXvnxoikDVvGe5yGSdX0PSRc9hqIPQo8LxodkbysVWUBz5i7cW?=
 =?us-ascii?Q?tCN4B6Tn4jvj5/mr1AiG2JgavrjANfem8oceiCmEuARxGy7C8NDgMhFyh44V?=
 =?us-ascii?Q?LDN74vfFxtl4AA7tQYoshtUcGvoHotf/8beCSwDZzLzpW8P8xudLo3CHfrZT?=
 =?us-ascii?Q?OgvsvbAGTDRT3tpy3igJr+9rGduid3VJQA5H3vPDUh3Zqb5f9084Ht3DO7+9?=
 =?us-ascii?Q?eBhZgyo7uzI6jmZsdWBIKaC1jaIiHR+Aq+cqZlBSlxDPxAjkt1PPnr+Ey2mU?=
 =?us-ascii?Q?uPKFpeE7Dfm28u1oU4O4F1az0qrXFEuWGrjTokdTLq5rEcZg1uC9bBlIPfqo?=
 =?us-ascii?Q?dx7sDLysTWeYT0zBGYRwHk0tN3thQVOL95Mm/deFBRUtix1en+oBoAP17qLO?=
 =?us-ascii?Q?ZVmoGu55sD5B+yW+TAKACFOeEj2dGrsvlEtLjE+RDhIIpV2iRNI334BNiaXU?=
 =?us-ascii?Q?/6AhYBTwn80pQ+15PtEphRRQqhU1aLLo0L/U81khf5AnxEp/bZuHRJuHqIJZ?=
 =?us-ascii?Q?rn3qauzJYO20RxVsHsmiGMhRsIoPl+CmCTE2k+kSV5lERV0OD1ZeesxCDuLe?=
 =?us-ascii?Q?LFvY9Ly1HGQWAm1FABa0iJRzNRnrZloxetYvFto8fPxkoCqrcCLbANCMda4+?=
 =?us-ascii?Q?cs3m80PSbkrWbbfuiXHYdGTOOyNTMfygOF/YDoXCxrTQpUqTelabsxd2wv6P?=
 =?us-ascii?Q?HIuSYGoO7t0cjR5O99X4iWMefsA1wa+LqhSzC9YZsbZ3i6sRNSzA77qm60H9?=
 =?us-ascii?Q?CW6LrALXbOEK9R/XGZPzLs/Ntj4lPXK+pggzIBaR/G7dYgfDXhNxRBM7TDf5?=
 =?us-ascii?Q?g4N9zcS5FY4lWp2ND8VW6ugjRZx+95MAwl8etPx8oY341ivF4yPSq0TGbfqB?=
 =?us-ascii?Q?+jAfR1d07VHxGWNow5dsEMIWaYRGh/UUYflw9q1U5UKuyiz7fH0KOckRnhZe?=
 =?us-ascii?Q?IQVn6vVh21et18iCkTOkrNU3F0cKIv0+BZ/TmJNgHTXr1O5bI35Lle74Dkf1?=
 =?us-ascii?Q?1yzT+WhMt+lN0/JQSX3FhjvvW8nxa4SBlDUPFxkrMvy1gEl2HUm5/DTaYRTp?=
 =?us-ascii?Q?FiShqtVHeDZ7RibKDOVh/KTzEvQawhpJXUOuXLnPkH8nqqO6BDi4feKALh+a?=
 =?us-ascii?Q?yVIBORzbOMXhHraLplx0BgzOl8PJvBdxiBSGio338eVx68GlrY4WFr9oAmKU?=
 =?us-ascii?Q?7vMgVQQ1JoFdyxpfjEdJZAVSbYbjZCE=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8649870-19c8-4f89-96ee-08da47fc66de
X-MS-Exchange-CrossTenant-AuthSource: DM8PR10MB5416.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2022 20:37:41.0946
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s0zXKWVMmhCv3+9YzMl8/5jR5msHvKMWsOop2Na5gW359AlkDYX7mvnsKx7Mwea252TNsV0QzO06M9eqauzBuTzOiDGneqp6SkWz7/PS86s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR10MB2596
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-06_06:2022-06-02,2022-06-06 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 adultscore=0 bulkscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206060081
X-Proofpoint-ORIG-GUID: SP5jMbWF8uYU6N0qBfVUDpoHi2DzUqi0
X-Proofpoint-GUID: SP5jMbWF8uYU6N0qBfVUDpoHi2DzUqi0
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add clear_pages(), with ARCH_MAX_CLEAR_PAGES_ORDER=8, so we can clear
in chunks of upto 1024KB.

The case for doing this is to expose huge or gigantic page clearing
as a few long strings of zeroes instead of many PAGE_SIZE'd operations.
Processors could take advantage of this hint by foregoing cacheline
allocation.
Unfortunately current generation CPUs generally do not do this
optimization: among CPUs tested, Intel Skylake, Icelakex don't at
all; AMD Milan does for extents > ~LLC-size.
(Note, however, numbers below do show a ~25% increase in clearing
BW -- just that they aren't due to foregoing cacheline allocation.)

One hope for this change is that it might provide enough of a
hint that future uarchs could optimize for.

A minor negative with this change is that calls to clear_page()
(which now calls clear_pages()) clobber an additional register.

Performance
===

System:    Oracle X9-2c (2 nodes * 32 cores * 2 threads)
Processor: Intel Xeon(R) Platinum 8358 CPU @ 2.60GHz (Icelakex, 6:106:6)
Memory:    1024 GB evenly split between nodes
LLC-size:  48MB for each node (32-cores * 2-threads)
no_turbo: 1, Microcode: 0xd0002c1, scaling-governor: performance

System:    Oracle E4-2c (2 nodes * 8 CCXs * 8 cores * 2 threads)
Processor: AMD EPYC 7J13 64-Core Processor (Milan, 25:1:1)
Memory:    512 GB evenly split between nodes
LLC-size:  32MB for each CCX (8-cores * 2-threads)
boost: 1, Microcode: 0xa00115d, scaling-governor: performance

Workload: create a 192GB qemu-VM (backed by preallocated 2MB
pages on the local node)
==

Icelakex
--
                          Time (s)        Delta (%)
 clear_page_erms()     22.37 ( +- 0.14s )           #  9.21 bytes/ns
 clear_pages_erms()    16.49 ( +- 0.06s )  -26.28%  # 12.50 bytes/ns

Looking at the perf stats [1] [2], it's not obvious where the
improvement is coming from. For clear_pages_erms(), we do execute
fewer instructions and branches (multiple pages per call to
clear_pages_erms(), and fewer cond_resched() calls) but since this
code isn't frontend bound (though there is a marginal improvement in
topdown-fe-bound), not clear if that's the cause for the ~25%
improvement.
The topdown-be-bound numbers are significantly better but they are
in a similar proportion to the total slots in both cases.

Milan
--
                          Time (s)        Delta (%)
 clear_page_erms()     16.49 ( +- 0.06s )           # 12.50 bytes/ns
 clear_pages_erms()    11.82 ( +- 0.06s )  -28.32%  # 17.44 bytes/ns

Similar to the Icelakex case above, from the perf stats [3], [4] it's
unclear where the improvement is coming from. We do somewhat better
for L1-dcache-loads and marginally better for stalled-cycles-backend
but nothing obvious stands out.

Workload: vm-scalability hugetlb tests (on Icelakex)
==

For case-anon-w-seq-hugetlb, there is a ~19.49% improvement in
cpu-cycles expended. As above, from perf stats there isn't a clear
reason why. No significant differences in user/kernel cache misses.

case-anon-w-seq-hugetlb:
  -   2,632,688,342,385      cpu-cycles                #    2.301 GHz                      ( +-  6.76% )  (33.29%)
  +   2,119,058,504,338      cpu-cycles                #    1.654 GHz                      ( +-  4.63% )  (33.37%)

Other hugetlb tests are flat.

case-anon-w-rand-hugetlb:
  -  14,423,774,217,911      cpu-cycles                #    2.452 GHz                      ( +-  0.55% )  (33.30%)
  +  14,009,785,056,082      cpu-cycles                #    2.428 GHz                      ( +-  3.11% )  (33.32%)

case-anon-cow-seq-hugetlb:
  -   2,689,994,027,601      cpu-cycles                #    2.220 GHz                      ( +-  1.91% )  (33.27%)
  +   2,735,414,889,894      cpu-cycles                #    2.262 GHz                      ( +-  1.82% )  (27.73%)

case-anon-cow-rand-hugetlb:
  -  16,130,147,328,192      cpu-cycles                #    2.482 GHz                      ( +-  1.07% )  (33.30%)
  +  15,815,163,909,204      cpu-cycles                #    2.432 GHz                      ( +-  0.64% )  (33.32%)

cache-references, cache-misses are within margin of error across all
the tests.

[1] Icelakex, create 192GB qemu-VM, clear_page_erms()
 # perf stat -r 5 --all-kernel -ddd ./qemu.sh

 Performance counter stats for './qemu.sh' (5 runs):

         22,378.31 msec task-clock                #    1.000 CPUs utilized            ( +-  0.67% )
               153      context-switches          #    6.844 /sec                     ( +-  0.57% )
                 8      cpu-migrations            #    0.358 /sec                     ( +- 16.49% )
               116      page-faults               #    5.189 /sec                     ( +-  0.17% )
    57,290,131,280      cycles                    #    2.563 GHz                      ( +-  0.66% )  (38.46%)
     3,077,416,348      instructions              #    0.05  insn per cycle           ( +-  0.30% )  (46.14%)
       631,473,780      branches                  #   28.246 M/sec                    ( +-  0.18% )  (53.83%)
         1,167,792      branch-misses             #    0.19% of all branches          ( +-  0.79% )  (61.52%)
   286,600,215,705      slots                     #   12.820 G/sec                    ( +-  0.66% )  (69.20%)
    11,435,999,662      topdown-retiring          #      3.9% retiring                ( +-  1.56% )  (69.20%)
    19,428,489,213      topdown-bad-spec          #      6.2% bad speculation         ( +-  3.23% )  (69.20%)
     3,504,763,769      topdown-fe-bound          #      1.2% frontend bound          ( +-  0.67% )  (69.20%)
   258,517,960,428      topdown-be-bound          #     88.7% backend bound           ( +-  0.58% )  (69.20%)
       749,211,322      L1-dcache-loads           #   33.513 M/sec                    ( +-  0.13% )  (69.18%)
     3,244,380,956      L1-dcache-load-misses     #  433.32% of all L1-dcache accesses  ( +-  0.00% )  (69.20%)
        11,441,841      LLC-loads                 #  511.805 K/sec                    ( +-  0.30% )  (69.23%)
           839,878      LLC-load-misses           #    7.32% of all LL-cache accesses  ( +-  1.28% )  (69.24%)
   <not supported>      L1-icache-loads
        23,091,397      L1-icache-load-misses                                         ( +-  0.72% )  (30.82%)
       772,619,434      dTLB-loads                #   34.560 M/sec                    ( +-  0.31% )  (30.82%)
            49,750      dTLB-load-misses          #    0.01% of all dTLB cache accesses  ( +-  3.21% )  (30.80%)
   <not supported>      iTLB-loads
           503,570      iTLB-load-misses                                              ( +-  0.44% )  (30.78%)
   <not supported>      L1-dcache-prefetches
   <not supported>      L1-dcache-prefetch-misses

            22.374 +- 0.149 seconds time elapsed  ( +-  0.66% )

[2] Icelakex, create 192GB qemu-VM, clear_pages_erms()
 # perf stat -r 5 --all-kernel -ddd ./qemu.sh

 Performance counter stats for './qemu.sh' (5 runs):

         16,329.41 msec task-clock                #    0.990 CPUs utilized            ( +-  0.42% )
               143      context-switches          #    8.681 /sec                     ( +-  0.93% )
                 1      cpu-migrations            #    0.061 /sec                     ( +- 63.25% )
               118      page-faults               #    7.164 /sec                     ( +-  0.27% )
    41,735,523,673      cycles                    #    2.534 GHz                      ( +-  0.42% )  (38.46%)
     1,454,116,543      instructions              #    0.03  insn per cycle           ( +-  0.49% )  (46.16%)
       266,749,920      branches                  #   16.194 M/sec                    ( +-  0.41% )  (53.86%)
           928,726      branch-misses             #    0.35% of all branches          ( +-  0.38% )  (61.54%)
   208,805,754,709      slots                     #   12.676 G/sec                    ( +-  0.41% )  (69.23%)
     5,355,889,366      topdown-retiring          #      2.5% retiring                ( +-  0.50% )  (69.23%)
    12,720,749,784      topdown-bad-spec          #      6.1% bad speculation         ( +-  1.38% )  (69.23%)
       998,710,552      topdown-fe-bound          #      0.5% frontend bound          ( +-  0.85% )  (69.23%)
   192,653,197,875      topdown-be-bound          #     90.9% backend bound           ( +-  0.38% )  (69.23%)
       407,619,058      L1-dcache-loads           #   24.746 M/sec                    ( +-  0.17% )  (69.20%)
     3,245,399,461      L1-dcache-load-misses     #  801.49% of all L1-dcache accesses  ( +-  0.01% )  (69.22%)
        10,805,747      LLC-loads                 #  656.009 K/sec                    ( +-  0.37% )  (69.25%)
           804,475      LLC-load-misses           #    7.44% of all LL-cache accesses  ( +-  2.73% )  (69.26%)
   <not supported>      L1-icache-loads
        18,134,527      L1-icache-load-misses                                         ( +-  1.24% )  (30.80%)
       435,474,462      dTLB-loads                #   26.437 M/sec                    ( +-  0.28% )  (30.80%)
            41,187      dTLB-load-misses          #    0.01% of all dTLB cache accesses  ( +-  4.06% )  (30.79%)
   <not supported>      iTLB-loads
           440,135      iTLB-load-misses                                              ( +-  1.07% )  (30.78%)
   <not supported>      L1-dcache-prefetches
   <not supported>      L1-dcache-prefetch-misses

           16.4906 +- 0.0676 seconds time elapsed  ( +-  0.41% )

[3] Milan, create 192GB qemu-VM, clear_page_erms()
 # perf stat -r 5 --all-kernel -ddd ./qemu.sh

 Performance counter stats for './qemu.sh' (5 runs):

         16,321.98 msec task-clock                #    0.989 CPUs utilized            ( +-  0.42% )
               104      context-switches          #    6.312 /sec                     ( +-  0.47% )
                 0      cpu-migrations            #    0.000 /sec
               109      page-faults               #    6.616 /sec                     ( +-  0.41% )
    39,430,057,963      cycles                    #    2.393 GHz                      ( +-  0.42% )  (33.33%)
       252,874,009      stalled-cycles-frontend   #    0.64% frontend cycles idle     ( +- 17.81% )  (33.34%)
         7,240,041      stalled-cycles-backend    #    0.02% backend cycles idle      ( +-245.73% )  (33.34%)
     3,031,754,124      instructions              #    0.08  insn per cycle
                                                  #    0.11  stalled cycles per insn  ( +-  0.41% )  (33.35%)
       711,675,976      branches                  #   43.197 M/sec                    ( +-  0.15% )  (33.34%)
        52,470,018      branch-misses             #    7.38% of all branches          ( +-  0.21% )  (33.36%)
     7,744,057,748      L1-dcache-loads           #  470.041 M/sec                    ( +-  0.05% )  (33.36%)
     3,241,880,079      L1-dcache-load-misses     #   41.92% of all L1-dcache accesses  ( +-  0.01% )  (33.35%)
   <not supported>      LLC-loads
   <not supported>      LLC-load-misses
       155,312,115      L1-icache-loads           #    9.427 M/sec                    ( +-  0.23% )  (33.34%)
         1,573,793      L1-icache-load-misses     #    1.01% of all L1-icache accesses  ( +-  3.74% )  (33.36%)
         3,521,392      dTLB-loads                #  213.738 K/sec                    ( +-  4.97% )  (33.35%)
           346,337      dTLB-load-misses          #    9.31% of all dTLB cache accesses  ( +-  5.54% )  (33.35%)
               725      iTLB-loads                #   44.005 /sec                     ( +-  8.75% )  (33.34%)
           115,723      iTLB-load-misses          # 19261.48% of all iTLB cache accesses  ( +-  1.20% )  (33.34%)
       139,229,403      L1-dcache-prefetches      #    8.451 M/sec                    ( +- 10.97% )  (33.34%)
   <not supported>      L1-dcache-prefetch-misses

           16.4962 +- 0.0665 seconds time elapsed  ( +-  0.40% )

[4] Milan, create 192GB qemu-VM, clear_pages_erms()
 # perf stat -r 5 --all-kernel -ddd ./qemu.sh

 Performance counter stats for './qemu.sh' (5 runs):

         11,676.79 msec task-clock                #    0.987 CPUs utilized            ( +-  0.68% )
                96      context-switches          #    8.131 /sec                     ( +-  0.78% )
                 2      cpu-migrations            #    0.169 /sec                     ( +- 18.71% )
               106      page-faults               #    8.978 /sec                     ( +-  0.23% )
    28,161,726,414      cycles                    #    2.385 GHz                      ( +-  0.69% )  (33.33%)
       141,032,827      stalled-cycles-frontend   #    0.50% frontend cycles idle     ( +- 52.44% )  (33.35%)
       796,792,139      stalled-cycles-backend    #    2.80% backend cycles idle      ( +- 23.73% )  (33.35%)
     1,140,172,646      instructions              #    0.04  insn per cycle
                                                  #    0.50  stalled cycles per insn  ( +-  0.89% )  (33.35%)
       219,864,061      branches                  #   18.622 M/sec                    ( +-  1.06% )  (33.36%)
         1,407,446      branch-misses             #    0.63% of all branches          ( +- 10.66% )  (33.40%)
     6,882,968,897      L1-dcache-loads           #  582.960 M/sec                    ( +-  0.03% )  (33.38%)
     3,267,546,914      L1-dcache-load-misses     #   47.45% of all L1-dcache accesses  ( +-  0.02% )  (33.37%)
   <not supported>      LLC-loads
   <not supported>      LLC-load-misses
       146,901,513      L1-icache-loads           #   12.442 M/sec                    ( +-  0.78% )  (33.36%)
         1,462,155      L1-icache-load-misses     #    0.99% of all L1-icache accesses  ( +-  0.83% )  (33.34%)
         2,055,805      dTLB-loads                #  174.118 K/sec                    ( +- 22.56% )  (33.33%)
           136,260      dTLB-load-misses          #    4.69% of all dTLB cache accesses  ( +- 23.13% )  (33.35%)
               941      iTLB-loads                #   79.699 /sec                     ( +-  5.54% )  (33.35%)
           115,444      iTLB-load-misses          # 14051.12% of all iTLB cache accesses  ( +- 21.17% )  (33.34%)
        95,438,373      L1-dcache-prefetches      #    8.083 M/sec                    ( +- 19.99% )  (33.34%)
   <not supported>      L1-dcache-prefetch-misses

           11.8296 +- 0.0805 seconds time elapsed  ( +-  0.68% )

Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 arch/x86/include/asm/page.h    | 12 +++++++++++
 arch/x86/include/asm/page_64.h | 28 ++++++++++++++++++-------
 arch/x86/lib/clear_page_64.S   | 38 ++++++++++++++++++++--------------
 3 files changed, 55 insertions(+), 23 deletions(-)

diff --git a/arch/x86/include/asm/page.h b/arch/x86/include/asm/page.h
index 5a246a2a66aa..045eaab08f43 100644
--- a/arch/x86/include/asm/page.h
+++ b/arch/x86/include/asm/page.h
@@ -22,6 +22,18 @@ struct page;
 extern struct range pfn_mapped[];
 extern int nr_pfn_mapped;
 
+#ifdef __HAVE_ARCH_CLEAR_USER_PAGES	/* x86_64 */
+
+#define clear_page(page) clear_pages(page, 1)
+
+static inline void clear_user_pages(void *page, unsigned long vaddr,
+				    struct page *pg, unsigned int npages)
+{
+	clear_pages(page, npages);
+}
+
+#endif /* __HAVE_ARCH_CLEAR_USER_PAGES */
+
 static inline void clear_user_page(void *page, unsigned long vaddr,
 				   struct page *pg)
 {
diff --git a/arch/x86/include/asm/page_64.h b/arch/x86/include/asm/page_64.h
index baa70451b8df..a88a3508888a 100644
--- a/arch/x86/include/asm/page_64.h
+++ b/arch/x86/include/asm/page_64.h
@@ -41,16 +41,28 @@ extern unsigned long __phys_addr_symbol(unsigned long);
 #define pfn_valid(pfn)          ((pfn) < max_pfn)
 #endif
 
-void clear_page_orig(void *page);
-void clear_page_rep(void *page);
-void clear_page_erms(void *page);
+/*
+ * Clear in chunks of 256 pages/1024KB.
+ *
+ * Assuming a clearing BW of 3b/cyc (recent generation processors have
+ * more), this amounts to around 400K cycles for each chunk.
+ *
+ * With a cpufreq of ~2.5GHz, this amounts to ~160us for each chunk
+ * (which would also be the interval between calls to cond_resched().)
+ */
+#define ARCH_MAX_CLEAR_PAGES_ORDER	8
 
-static inline void clear_page(void *page)
+void clear_pages_orig(void *page, unsigned long npages);
+void clear_pages_rep(void *page, unsigned long npages);
+void clear_pages_erms(void *page, unsigned long npages);
+
+#define __HAVE_ARCH_CLEAR_USER_PAGES
+static inline void clear_pages(void *page, unsigned int npages)
 {
-	alternative_call_2(clear_page_orig,
-			   clear_page_rep, X86_FEATURE_REP_GOOD,
-			   clear_page_erms, X86_FEATURE_ERMS,
-			   "=D" (page),
+	alternative_call_2(clear_pages_orig,
+			   clear_pages_rep, X86_FEATURE_REP_GOOD,
+			   clear_pages_erms, X86_FEATURE_ERMS,
+			   "=D" (page), "S" ((unsigned long) npages),
 			   "0" (page)
 			   : "cc", "memory", "rax", "rcx");
 }
diff --git a/arch/x86/lib/clear_page_64.S b/arch/x86/lib/clear_page_64.S
index fe59b8ac4fcc..2cc3b681734a 100644
--- a/arch/x86/lib/clear_page_64.S
+++ b/arch/x86/lib/clear_page_64.S
@@ -1,6 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 #include <linux/linkage.h>
 #include <asm/export.h>
+#include <asm/page_types.h>
 
 /*
  * Most CPUs support enhanced REP MOVSB/STOSB instructions. It is
@@ -10,23 +11,29 @@
  */
 
 /*
- * Zero a page.
- * %rdi	- page
+ * Zero pages.
+ * %rdi	- base page
+ * %rsi	- number of pages
+ *
+ * Note: clear_pages_*() have differing alignments restrictions
+ * but callers are always expected to page align.
  */
-SYM_FUNC_START(clear_page_rep)
-	movl $4096/8,%ecx
+SYM_FUNC_START(clear_pages_rep)
+	movq %rsi,%rcx
+	shlq $(PAGE_SHIFT - 3),%rcx
 	xorl %eax,%eax
 	rep stosq
 	RET
-SYM_FUNC_END(clear_page_rep)
-EXPORT_SYMBOL_GPL(clear_page_rep)
+SYM_FUNC_END(clear_pages_rep)
+EXPORT_SYMBOL_GPL(clear_pages_rep)
 
-SYM_FUNC_START(clear_page_orig)
+SYM_FUNC_START(clear_pages_orig)
 	xorl   %eax,%eax
-	movl   $4096/64,%ecx
+	movq   %rsi,%rcx
+	shlq   $(PAGE_SHIFT - 6),%rcx
 	.p2align 4
 .Lloop:
-	decl	%ecx
+	decq	%rcx
 #define PUT(x) movq %rax,x*8(%rdi)
 	movq %rax,(%rdi)
 	PUT(1)
@@ -40,13 +47,14 @@ SYM_FUNC_START(clear_page_orig)
 	jnz	.Lloop
 	nop
 	RET
-SYM_FUNC_END(clear_page_orig)
-EXPORT_SYMBOL_GPL(clear_page_orig)
+SYM_FUNC_END(clear_pages_orig)
+EXPORT_SYMBOL_GPL(clear_pages_orig)
 
-SYM_FUNC_START(clear_page_erms)
-	movl $4096,%ecx
+SYM_FUNC_START(clear_pages_erms)
+	movq %rsi,%rcx
+	shlq $PAGE_SHIFT, %rcx
 	xorl %eax,%eax
 	rep stosb
 	RET
-SYM_FUNC_END(clear_page_erms)
-EXPORT_SYMBOL_GPL(clear_page_erms)
+SYM_FUNC_END(clear_pages_erms)
+EXPORT_SYMBOL_GPL(clear_pages_erms)
-- 
2.31.1

