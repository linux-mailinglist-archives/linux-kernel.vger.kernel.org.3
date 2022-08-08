Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D34858CF6E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 22:54:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244448AbiHHUy2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 16:54:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237173AbiHHUyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 16:54:25 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D719A15FDD
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 13:54:24 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 278ItcIK011419;
        Mon, 8 Aug 2022 20:54:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2022-7-12;
 bh=OEuH7AkvgRg5NA2C474pXeMZe8vPSNXvQGge+tYejyg=;
 b=pJfbzyvdR1KiiqJIZQ05tDgGyMCFukr7H7AZ8eePHT76P6pjrjYOMIWrgJSki3hh3rXC
 2OLCWHiJAh53avgV1J8Xrf47vfXjEwDYF7U9w5+0dz7ZDRIVJmGfvHvCmpYHez63pV3E
 Q9peq9waetOi/zXQax6oxK4rrRAFWjAHICUQaJaYX5D1JwGtxRroEFQF8IsG8gFPgEif
 Rk1HM21HY+uGb/0rf1u5EdxxEOO1uwjII7vEVHnKHzBDBizxIoUcQ0GoKZIOBU9TE1sQ
 j8fsWgTBHDQs4wR2/I1b1b/iJeBAgcWjbO7qteMVOZZ9KMZbtJkkHbRQIEz2xP7CO0RK TQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hsfwsms8m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 Aug 2022 20:54:14 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 278KTTFK023132;
        Mon, 8 Aug 2022 20:54:13 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hser29wmr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 Aug 2022 20:54:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KRmBtZOvjl7GLgHs3tf95BdLiKjKu0EL3jGhSrmxVCDhdoLnPhcD65qYUahUIaChcy8hNhteXV0TMuzvVhM6EwqxxFt6Svv9FbkMJzW/LFHbisC9RpLJGP79IUXvCg94cBVjlIsxaD5uC7vVOtWLdS8k/KL/XOAAgwII6oSjsbJpBUr/cdkvMeRp8b68zvddRfb5Lp4ZBN1srf9FXJO8rW8vl1fh16XY4RTRdeQ1wDj9MmgkalZbBIX9wmrpJ7WqPQWRJzI1ZDKNHeSi3Cytrn+vAQQ4POu+/leNEXvggKmLNR9q5N1zk+cqMOFNdup0q92ZD9QDLeci3NNt5xMh3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OEuH7AkvgRg5NA2C474pXeMZe8vPSNXvQGge+tYejyg=;
 b=PrRDesVtmKdRsSkHkF43TOlXM4DLZwY7hngl36JNVz4kzWk6OelR0ZwrcXSNGGlx7C9KLWTuOhsawv1/WWq0FQHquIoomg9vC2SWmwHa/SAA8ckdVWjELpRqV/Cfnh110BAFBsTD+9VYpvlL9Q82bENwc2qtUDIy7ziek88oNkGkL1IiSs5ze9JxrM1DiltQ3L8Vkpks7GelCjL0K5JtA140YZT/VkP/vsCOwP/xPuAxowfWIz9GdXoecIqaHwWGYIwVou87YKouDLUcMZGJR3wVnqg9Juvh9xfLEyYSiv0qLUA14Fk/ndVWZImqO2mLthZDBbKHSoiNozSO7jIPmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OEuH7AkvgRg5NA2C474pXeMZe8vPSNXvQGge+tYejyg=;
 b=TnNef2USQhYCkyHv+TL79oWtAJFQoEfwRtMHzaBw1+oRJQjWafuDE4qUDYIiMEmRGGnAbTlXKZn6HoodAQx4Z3JiU5c695mzcvEHbEQJHRTD17Pzvm50c+LOPmxZJ0NZeSYNloXJvtepUjpxZJQgCfHgDIHR+AaSxV8pH8wLYds=
Received: from CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20)
 by DS0PR10MB6248.namprd10.prod.outlook.com (2603:10b6:8:d0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.20; Mon, 8 Aug
 2022 20:54:12 +0000
Received: from CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::44ed:9862:9a69:6da5]) by CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::44ed:9862:9a69:6da5%5]) with mapi id 15.20.5504.020; Mon, 8 Aug 2022
 20:54:12 +0000
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
To:     Baoquan He <bhe@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Dave Young <dyoung@redhat.com>, linux-kernel@vger.kernel.org,
        Stephen Brennan <stephen.s.brennan@oracle.com>,
        Vivek Goyal <vgoyal@redhat.com>, kexec@lists.infradead.org
Subject: [PATCH] vmcoreinfo: add kallsyms_num_syms symbol
Date:   Mon,  8 Aug 2022 13:54:10 -0700
Message-Id: <20220808205410.18590-1-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA1P222CA0070.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2c1::26) To CH2PR10MB4166.namprd10.prod.outlook.com
 (2603:10b6:610:78::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 88ffa492-8a06-4ffd-33f9-08da79802599
X-MS-TrafficTypeDiagnostic: DS0PR10MB6248:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NkSHu7OSivast05/wbMsnAZX7/29ZJ1/nFeGlBhhmf760LXiDLiJ+x4Ai1lzMlKcMVXxwhJ0sG/M1NyJ3RG6GictsrwOWlSjtsOBk/guexNo/NJT5rPjASg6SOI7atxSELkhFOUvsIWpGdLH/LFiyXBVdr/k8b0+n0LzoBOuOaqUcvHP8b80sA0DRXZ6amXD0UJGcWYUZwk9t0MhWl1mQEuHgWus5Xvs47GMo9zUVcoSX61Z7688j5hmhLtM+n35iuW8mlH1dVt/dgyegTcPVZ9Pq27+uV4hsHHCfOtaXu8bO6X1AsDBXJ3/TYLhCU6gHm3FhfIHvbxBhFZa20qElTuk+ee7KAIWafxhr/sIs+lfkvoLPydHMQEWK8NI/w0TbQn/h0mxmTqkuawATPVgBPsvLCp71Pz1truA2l7vkJWcQKIWQh4vSVApAmcr5dRaydzm+dkdN64MPgAizftlHGyiVJpINujn/+aBTSUL09MuMn9wWnN6K55FZiIkObTxzdhBMXotxd1JoOkHMQifeHWGk0k46z+kZbkrYvY88sbyZqgpI/g37fFGU1m2wJfz5/gYcgdyHls4o/unfdAgXC7l0pcxkz76mgM9PYQg6tcsrrjcqu/A0OCkjbIIVZa3kmTEP7r85kGREh4lRMXY5FSM+XQFJMcVyg1nksUUw1vg5ml8hopnAU6KWPCndg+P0dc/iG55Bsnk/Qs3eeApbPywgLgswKyEamOOycpsf4CpBnReoCwuQdRr8ACKwJlB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4166.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(136003)(39860400002)(366004)(396003)(376002)(4326008)(66946007)(36756003)(5660300002)(8676002)(103116003)(54906003)(66476007)(110136005)(316002)(26005)(41300700001)(2906002)(66556008)(8936002)(478600001)(6486002)(83380400001)(6512007)(86362001)(2616005)(186003)(1076003)(6506007)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?r7wZ0EIu2orZQ/RX5IXzc0wbTQN0L9AolcL54PFfwODUxHGUQMCQABfhEUx4?=
 =?us-ascii?Q?Ohqby4ND9s8lyTQcP1cTrYQ2l38AQ1RbdkbZmTdeFB5zG/tZSIW21cdGVFkY?=
 =?us-ascii?Q?o5qVNglWZAzkNKkhjUb7wNhAN5ernJwcWxbGnT4Mya/mp5n30hI1wbmptXHp?=
 =?us-ascii?Q?g/YG8MVk+zbqK+iFf9ZuAS2pI7iWXKCK/c5gORiQYbegUG59dSVdkkSaTKYM?=
 =?us-ascii?Q?QxvmiLiNAVAlRcZVF+k942LhRwmUCKEl6baYYlbdD4zGUDuezC4awvUYj//f?=
 =?us-ascii?Q?tGc3eNDAiohnMzXeAWwpgT/yem4AE57/8cohQklaXkVwqtgn2cFrvz3CULeA?=
 =?us-ascii?Q?Bw8prfVnethzJUe41RWGryFJI8Iy1mZ6oS0FyYoJaV6GABbXLXMop3yRKLew?=
 =?us-ascii?Q?ZoIgJyD/Z5RQkxO/ra/MYxDRi9/vZOcriYWMrirQCjbXCjcHm3ZDUym9bcsR?=
 =?us-ascii?Q?Xr2x7vsLMVSSdT/CVSnEAbbW+bFYcsdCm1k5dqAdACVU4FIJNor8N36bBlOP?=
 =?us-ascii?Q?+gdDuF394SQw95XaNK7aYMDVWPS+j+gpkbYza8gA1R+OOcVsLgntKde9kWli?=
 =?us-ascii?Q?gYT2WvT+lvmnpuY/5ztP4cGA3jpEYJ70kyBm3BIbR6Xd8+uwONZifsLRWZ1F?=
 =?us-ascii?Q?JAGMe9nW54++520vT2F2fpcUTGx0oQujqw4UQKD7/O091cDt+knMXIa3uTzm?=
 =?us-ascii?Q?BO9T9kccCfLpYvFJOo4EIj4Z78QDldTQLi+NNswXtosQ5tmEc98wfBYWG70B?=
 =?us-ascii?Q?nbb+POFH6V5H7CxfgD/Kg8ybo+hJ3saCliiInR8wN0PQLz/Mxz+Ua6pO8uRK?=
 =?us-ascii?Q?wcAxDfr3so5Z61kk/n0eeDGUtJr6fxuIZqAD8AmEHgYu1Mzu35yepNPNbgaX?=
 =?us-ascii?Q?qFTu10ymJw0SHJc97ztUq5BneHjKGfE3/xz04iGZ6JDAwg5+WVMsNehNhFRR?=
 =?us-ascii?Q?i/9/L9GZZX/AP0pAjMBcnHTWLFGEwpwNDujvpsz+GhjZjlab9fFUbbWElQG5?=
 =?us-ascii?Q?s/Hl5hj32AlOYs8uK4xQtJVTfK1sidzKtV8oKlC85bYyR5zVZk9wmWIpP72K?=
 =?us-ascii?Q?Hk4iwsHP5D3xzrIgU1vzFx/LPiNWNcpAHDTy7bIifT6YyzHyQAbuVfjhqZuB?=
 =?us-ascii?Q?QJvMm225by+Xyx4TK1iOBwRPXxUFJM/vJPFigAYuHOozdI/LmA9BZ9xz/B0I?=
 =?us-ascii?Q?pXcPxS244P/zNpk4702us54S61oRHek7ALb14AmDXYdIniA5kowK0qkY2mYh?=
 =?us-ascii?Q?RyxR0gpnWeE4nYqaef+molvX1CW8/EYj23M7emGCOHRimz/yovcmXaDu99Bo?=
 =?us-ascii?Q?PYMSWJQGN91v7y+PgHvR6BSH0d1Oo2HsA5NP0XX9B5lb3iqLexjF9AxuhNj2?=
 =?us-ascii?Q?I7C9ZeUME/w6mw0ImwePdHepm2otAJ2YTAwPULOD7zP7gflsba8rVK3lEP9c?=
 =?us-ascii?Q?lB/nvxe9ZBB3vUsHW8GbUY4U1fMn6RRUIxn0NA4olYspgLYzsUPLLHjaieNf?=
 =?us-ascii?Q?+CEoWthxBnGg7S/RAwXFYPdzqVeHLe9DvbiXJ8oIj6WU8Xr0+OQ7v0hg6xA8?=
 =?us-ascii?Q?Er+C7n2hLLilC6g131ThnefjoHY7DovtLW4QFhj0YMXVKFVrgVKPjo6xsgJ9?=
 =?us-ascii?Q?Pg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88ffa492-8a06-4ffd-33f9-08da79802599
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4166.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2022 20:54:12.1157
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1q+2CTFLTrYXi366YDvFneDkQhh4D9AcD1pUJosvqV6YS9vS0c3eUhFShqEyQI0OXrkbCOmihOVXbSU3A/oPs9x5/UD13CBM6dVrFqRKxdE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6248
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-08_13,2022-08-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 adultscore=0
 bulkscore=0 phishscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2208080091
X-Proofpoint-ORIG-GUID: WGVH38OtDlyXo3kOIysKENdSMvkgzm28
X-Proofpoint-GUID: WGVH38OtDlyXo3kOIysKENdSMvkgzm28
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rest of the kallsyms symbols are useless without knowing the number
of symbols in the table. In an earlier patch, I somehow dropped the
kallsyms_num_syms symbol, so add it back in.

Fixes: 5fd8fea935a1 ("vmcoreinfo: include kallsyms symbols")

Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
---
Hi Baoquan & Andrew,

I made a silly omission in the above mentioned commit, which just got merged
via Andrew's non-mm pull request yesterday. I must have dropped it as I
cherry-picked between versions. Would you be able to queue this up with whatever
fixes you'll send for the 6.0 rc's?

Thanks, and sorry!
Stephen

 kernel/crash_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 07b26df453a9..a0eb4d5cf557 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -494,6 +494,7 @@ static int __init crash_save_vmcoreinfo_init(void)
 
 #ifdef CONFIG_KALLSYMS
 	VMCOREINFO_SYMBOL(kallsyms_names);
+	VMCOREINFO_SYMBOL(kallsyms_num_syms);
 	VMCOREINFO_SYMBOL(kallsyms_token_table);
 	VMCOREINFO_SYMBOL(kallsyms_token_index);
 #ifdef CONFIG_KALLSYMS_BASE_RELATIVE
-- 
2.34.1

