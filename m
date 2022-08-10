Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5504058F46E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 00:33:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233541AbiHJWdt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 18:33:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233535AbiHJWdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 18:33:47 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6734F584
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 15:33:45 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27AKi5br012878;
        Wed, 10 Aug 2022 22:33:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2022-7-12;
 bh=vULAT2tyfXmnWJiiJXR/PQ3CE3XgIMlmsyttxawghzM=;
 b=2sgyu4KeriAhVa9bhUaV5eBy/Q/labep/Tr9WLRVFq21jnPYuK4KP+G1RQzfzXH6mMnz
 3QmkocqL+y1dBfF1De9afBoFv9jiDuH+s2hd9WdKi+fCcJLZdp2rwoS0UjArFhf2F8ag
 l0aDDLKEnuN6lnF2dTkFobdte2CsZ+C7nAmHmUYDEwRZAhKuQZt1LzipWEaiHY8XfKki
 m27Zju+xaNnuRsvdbpxN844rM0UlvcALgolBOi46LsDsD3Vedu2G9sfni6D/nKLEGfYb
 UKadUt3kauymKkM/OsZn5/2UZPDtrBTNJi4bWCLJYzkMCuHcKqmjKlHGotgeso7sz+jm xA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3huwq93cyp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Aug 2022 22:33:25 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27AJkMCC015464;
        Wed, 10 Aug 2022 22:33:24 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2104.outbound.protection.outlook.com [104.47.70.104])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3huwqjjm1m-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Aug 2022 22:33:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PctCrh448ODNxaYCzgf8XW9P0vgnax2vI/uYJnWlqqnZKZaMTIklmurMZDYFkPKM6sAgVF2cjfb6i9jWLBos3rMqeULgK5u8AzN0RmUX9maljchP9j8uW6Z7oJbrijETQ2epgOJfmMJZwn19IYDkRy9IFvvNj1szHfHQcLPyCheTyUFk5yqTU4+3lZ1yefbK3qHklf1E2UpIgzNSAigiW3nRIh+fv9vwu9b3PUCnUcTAP7OgyW5t8QBQEpjqfM01RDx+rijHBxX3zJBfhIDFnblIyj9CaDPjdbhVguCfJ/RMe+8dAJtSqxOywc8M+mMBztwkEWbgAldEdqG26rW5Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vULAT2tyfXmnWJiiJXR/PQ3CE3XgIMlmsyttxawghzM=;
 b=OWcPXYx2YXMSmGb1BsAZIuLj/N0AEEQn4ZSwIYb9Ei+bOMXkUZLkPzTXbcje3NknLqLWtvm7PU+jfT0IfsdkTgxdgife0Qh3ctZqM6AlCwPkMG7COt64m9o7YZ8rhuzOCGEby75m9sIEgeUj3KZj2XRLSYu98dN0j/pjigWsFMOXed2u0YLh3qW6j4kpG9Qjnuok2/L4ZTbbjMGVTX5DFsVhN0FUHI5rby9LgRbIhJqX/KvgCHper+VtUVaut1UKn2biUs9y83H1pcvFdWTKVpBaM/lyIMa2Jxs9iqhoyyaJSesrOCaUix5stBr/SOSosqWxs8DAfeMNFCk4Z/JpFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vULAT2tyfXmnWJiiJXR/PQ3CE3XgIMlmsyttxawghzM=;
 b=B+LXXQA2GTFltGe6q7Rzgtg9GN2CL73nBZVu71dWPHR24oEmJi5CKlde/YRBHCZUlUxorpjVfM2d/WQqTq7v19OzDv3EBPnJHRRgvnHtRY8q4eOiCj2/FIaQH8ZqcHtDq5QzwlQPxu/3Ixw4eyi2mBBpK17NAp3tBCM0Y7AoXBQ=
Received: from SJ0PR10MB4576.namprd10.prod.outlook.com (2603:10b6:a03:2ae::5)
 by MN2PR10MB3248.namprd10.prod.outlook.com (2603:10b6:208:129::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16; Wed, 10 Aug
 2022 22:33:21 +0000
Received: from SJ0PR10MB4576.namprd10.prod.outlook.com
 ([fe80::ec9c:8101:99b8:9d57]) by SJ0PR10MB4576.namprd10.prod.outlook.com
 ([fe80::ec9c:8101:99b8:9d57%6]) with mapi id 15.20.5525.010; Wed, 10 Aug 2022
 22:33:21 +0000
From:   Libo Chen <libo.chen@oracle.com>
To:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        juri.lelli@redhat.com, dietmar.eggemann@arm.com, mgorman@suse.de
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] sched/fair: Fix inaccurate tally of ttwu_move_affine
Date:   Wed, 10 Aug 2022 15:33:13 -0700
Message-Id: <20220810223313.386614-1-libo.chen@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR01CA0062.prod.exchangelabs.com (2603:10b6:208:23f::31)
 To SJ0PR10MB4576.namprd10.prod.outlook.com (2603:10b6:a03:2ae::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 399ac6aa-9423-478c-4eec-08da7b205479
X-MS-TrafficTypeDiagnostic: MN2PR10MB3248:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +nScWOGxXDemCq/D9VvPsbIfeTc1CEu6ZjvH4fnQMw1hzptdvMi68KkiwMr9EoEAhE/Pp+Fppj7IafQiLxosVT7bB6/IvT27szqg67htjv4q6WEcqn5J0lUv79Q8LKfhqdGgp1eSbDKVW9yOH5RXmykPZ9tyenrUnwQ93Xd/ouGWrbBqN4X9KoKfrKN1AW4BUtCt1v0S05ShdOwgwnvfYLW3QO+4/2sUoBo1zLPCV8lAuqBA8ZkkbyW24SisGh9T4jKNqkITMKBDp/KrYhC+FOOSt8JMMgZZGmzh63fqueAGXjdo9rHzEbHTkMVU7oT9mXJlecnG9TA0XTg4nXBUtwXFbAs9QlrjepCLj5zbmqwCWZt/Gn0SvV2zJQyinAifh82VpH7uKGXRUNTZGQ1XRTdsL8dn55cwDrMm2He4HKukw6h/HVrJydXqtYQtCgYbZ7t7Mc1oyqYcwZAIvF2RYbZg+xip35AYGnUntvIJZqO8Ify7WIlmBXAMjw9GNPe+cdZEZa2o+2x6+EKGx5pdip3PNzbuu+hx3DOJRJEKC7OYEBT2ZFCwuAhdJFm2NVbyC+rD6enUx4kMk+y0jNUK+GcvYwadKKsYR8j3otTAJwPh4DQVq+qKZBDdvVBGs1jlvcwW4Nt7CfUGsWenOsyhq4lRKasQiGGcrAZ3gViblH4JqBYnE0k81VVTyf5/N0dopE0kaTc4gw4vAq4Bev7kPLIwhF8NuJivzO/VYmLoSPECvgtoAfZo5OdqXu1bL1pworUUx35sBKgNvQl1phW4aEp26oPd1MdPjc71ckdnBpQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4576.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(376002)(396003)(136003)(39860400002)(366004)(8676002)(4326008)(316002)(66946007)(5660300002)(66476007)(66556008)(44832011)(2906002)(8936002)(38350700002)(38100700002)(86362001)(41300700001)(6512007)(36756003)(478600001)(6486002)(26005)(52116002)(6666004)(6506007)(2616005)(83380400001)(1076003)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aIuYZwnUjNyd8Dm4fpchAs++M/fuFbtxH1cWv3FjesOsGWwMtMlk3/1aEd5c?=
 =?us-ascii?Q?9IJ3mT5goX/lgVmfcgmwaTZOh3nKc3qB/uqpnvaLsOlEyk3RFvrag0tQ+66Q?=
 =?us-ascii?Q?0NsrSkprMxISnSHuFvyXAo/S+vi7VFN82QrmMq4WkH/0H9+I9gCAbjvH8TFW?=
 =?us-ascii?Q?PJrkJ/Sy2aHTm9NVl7Zoke6YgdMcC7K7jTaKuYcLb0fA6Rc5+8trEFFZWrd6?=
 =?us-ascii?Q?1qj8A2RHZJQwcA2CsQ4AU02xk/+WbhHvzwtmpDp0z3n2w5P0ovCGjpaKYEGx?=
 =?us-ascii?Q?0BmcCaDhtet32pJVdzD2NuM93fK7DNOGSqR0Zdjz+8IxtqE/v+b6BF4ztcxH?=
 =?us-ascii?Q?vNQ+f66atoef3hGv1SayGiK/oLb/IGWDwW+Y51GRZH/gGU8DUDAHbKSXcmXv?=
 =?us-ascii?Q?UwOH/7h+dFo0L3JqLP7jQMTIYOcwlJb8Pqc1D0kXaJiNz3lVNlRHTAuXDSkL?=
 =?us-ascii?Q?yWxafyf5UPtLaj3S4u33ILjzCeqwps72SPV++Wd9Yql5xi5WLJ3iS35fQvS+?=
 =?us-ascii?Q?QcmlLadv3JT+eQAyXcnAk2LMjEsYRW5HUDEDp4ufgG/sKhrKKZJM5wRnjhEz?=
 =?us-ascii?Q?uZKrlQV8XqG5nBMIpxHSCYFW9saqC9Y/Ud25tIPRXpOO89UVsxcCFGROUzfY?=
 =?us-ascii?Q?2YD74QLhypT9MTst6wszucizn+ZqnNVvjWSueYEcqds//20ssthHvGJt6CRn?=
 =?us-ascii?Q?Cr3gwBVfpDRJy69acxNz7O8R/ktOxc9Pj7X/IdqmjcejS6C+9YkE0Q/o1FHj?=
 =?us-ascii?Q?N8Wf6TwBs1HGS26TZpgS2OUHEcyTyK2nuhV1JiFARTWWdT9jTM3iTEc3hMk1?=
 =?us-ascii?Q?1+ff5HWCTanT2qHTL3T8MH/QdxQU5csL+Ywi0c4QTx0dHOOAFm739MUnpHWF?=
 =?us-ascii?Q?/quov3f2zPEJ7+h/4e7pU8P6mLg3vANa5ejc1WbiDbBfUjrTp5/jeSHlSxEx?=
 =?us-ascii?Q?bJBHgNdw0GJabrDpKsOc+izyUvWyAqBlvdkATfwsUtJujmtEixoKPmjCGRM8?=
 =?us-ascii?Q?QjIFdvijsvW9R0zoyqJ36i3vVLgdqEUOXOypmVVIUV5WjpG8WKjCn/9OgQqa?=
 =?us-ascii?Q?cMB48MFxgWgxRV0D4X2uBekd4Y5FIq1MghoVyOCAL4xc2oo0lS1LjjLPU5po?=
 =?us-ascii?Q?Dw7Bvhy6WfWzjcGlnLzFiop3bUcqCnBQeLDon1cTEzjb4Z7A0HCNbEpoyGNT?=
 =?us-ascii?Q?0neJLFZ+xWwGfOE7iMNweBAqvTarJYidpCYOlkfz8/GzLCz2jtIPaouJpS2s?=
 =?us-ascii?Q?i8B0tPDXj+3cFMdi40u+xin9CZIw2tmN8lampaDRyfQVCibat5Y25Ts+XULd?=
 =?us-ascii?Q?rJ51VPO7QSd74fm4dS/E83wdhuO7RQaZqligtEcARAZE7OCmiDravz5niVGx?=
 =?us-ascii?Q?vbmuJLHTzHnbolci/YGSWdvBUBCil4L0BDXeb9Gjmm/4vpidTwaiUq1vywJE?=
 =?us-ascii?Q?tu1X5Dl/HAkFLrM6RKzLG3/hyffrXwY9nbf9Y1WFqdH/bEmUHbK10oMslX/z?=
 =?us-ascii?Q?kwH0UrLXC9CmdwF9FMHTveKvL+kKGBtC8axGNoOnPte24ak5GFqEUx8rxTCZ?=
 =?us-ascii?Q?WcxU9o0LgFyLwDPOIqfw0U9XANwV6E8rWGcfQQv6?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 399ac6aa-9423-478c-4eec-08da7b205479
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4576.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2022 22:33:21.4626
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZJ6tpYKo0/YK0P4u255m7HGzk5c2/N12FLYTAgtoAYnev5mT3e5y8fmjlEAhJ/0x/qoNYVn0oyVVqE+0y5c5rA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3248
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-10_14,2022-08-10_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 spamscore=0 phishscore=0 adultscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208100068
X-Proofpoint-GUID: t4ABHZ8n-78yT4UlMlz2tvhCUix6U2BB
X-Proofpoint-ORIG-GUID: t4ABHZ8n-78yT4UlMlz2tvhCUix6U2BB
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are scenarios where non-affine wakeups are incorrectly counted as
affine wakeups by schedstats.

When wake_affine_idle() returns prev_cpu which doesn't equal to
nr_cpumask_bits, it will slip through the check: target == nr_cpumask_bits
in wake_affine() and be counted as if target == this_cpu in schedstats.

Replace target == nr_cpumask_bits with target != this_cpu to make sure
affine wakeups are accurately tallied.

Fixes: 806486c377e33 (sched/fair: Do not migrate if the prev_cpu is idle)
Suggested-by: Daniel Jordan <daniel.m.jordan@oracle.com>
Signed-off-by: Libo Chen <libo.chen@oracle.com>
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index da388657d5ac..b179da4f8105 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6114,7 +6114,7 @@ static int wake_affine(struct sched_domain *sd, struct task_struct *p,
 		target = wake_affine_weight(sd, p, this_cpu, prev_cpu, sync);
 
 	schedstat_inc(p->stats.nr_wakeups_affine_attempts);
-	if (target == nr_cpumask_bits)
+	if (target != this_cpu)
 		return prev_cpu;
 
 	schedstat_inc(sd->ttwu_move_affine);
-- 
2.31.1

