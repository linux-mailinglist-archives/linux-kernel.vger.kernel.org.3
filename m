Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 659FA55D65E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:16:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232877AbiF1Hf4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 03:35:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230321AbiF1Hfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 03:35:50 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7339A2CE15
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 00:35:47 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25S2HwIF031758;
        Tue, 28 Jun 2022 07:35:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=XlL/f5lyNL+/HDl0t0zzSYp1ZwukRAxtag8IFOzQpOM=;
 b=IlsoH1R2DE2k5Pj9/mT2f61uqPmwZXV7OuY2SkzC24GXiPm128pVeO6HLSI6lj4ODiz7
 xqRajdKvuj4LLf32/X+1O6dHG32NENIjgPZostWyi8ZGNZmQzAYvU76wdi/K+bg00Zoc
 t7a7oGEyhXO6G8ExWCdt/hzHJ0u7NX9asg40GbWVoJcMavUVzfKeb2ktoRBqcqZ8nQmV
 29A5MuRTFAs7i83ahg1oUKGLskMWP2KHlL2YsuMqaWk1sKUaBsFHWEbR9XJSzWyM3Q6t
 eqyZP+ZdN1h0XMBpJk4Q3X4U9vXbQg62xlNJrtNT8vP8rtfkfekXaXuh1d91l9FhulZz rw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gwrscd7v9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Jun 2022 07:35:17 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25S7Ks2F030944;
        Tue, 28 Jun 2022 07:35:16 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2105.outbound.protection.outlook.com [104.47.70.105])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gwrt2aq0k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Jun 2022 07:35:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HDi+bPqbkxJzAZCnhec91yovPriP3J72WAzlBvJVYB85pWvPXdwwlNqE9lTOGskVJNJWeflNmBW3ESnpHe9HCKw8py3jdfoNKWZ0R5Fw23+d+OaSIV+k05YZ6abc4hEi6qRGJLVGs69aoE1Qp2Dl0U5BrRdaKJlDd+iJsuFcGzKTMTpbggLELO5aVo0HucTzjUESir+VCbhIqdwQ6WbLyz9QswGYhxrgCLdLENNDuRFxeQvOrDoABw8W7g3+hNEHXbG04YVkHG2WTtdsFQU4zKYrtwCHQPvJyT8AXQRH1EdUXheQLmeir/QD9YKx5TgzE+dGnRu9YZMeNWwv/5JdTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XlL/f5lyNL+/HDl0t0zzSYp1ZwukRAxtag8IFOzQpOM=;
 b=F1SK47wDf3rpynzpDdzg9uLHp3emb6HM2ZOjcqtGpZXGYS7nVeez/0+/b3QP4gcqcEJ6GWuXu0hZY8l/GapAGsaooTHn92eXgS1E5tC1j7Qbw9PP1jFYx+/LKSn6pPvnOhJo8xNU8hTtnt0/rYt8QYxZ6PW7JP+Tji0vV1MytJy5u1S6jHOavJffMfJ7ijAU2WK4dkz9IvlV013vYmajUYPGrFBE1SjOagNo9LKsdN+2x+k+srzbN9I0LmrmUtI4udle76L72W/zmOfeLZjB0aB1YhxrHmC/J600LudpTwl7K6IMoJHJ+TmA/XE5aOXO1sIN+FTtiTExHt+fU1hy3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XlL/f5lyNL+/HDl0t0zzSYp1ZwukRAxtag8IFOzQpOM=;
 b=FHmcBJSnHau0iopQY6787mIiHLAlMpj1MQq3OoNVEv5LWxtluxhukAdlwEIWpXWKF1ssWeHQgktfRcE8oq3XGte9G3M4sRNwr6uzZCNOVoC1/G+JqL6kK3JgWx7FvadDk7FZJg2SS/xRcoWdYjWRustx2jFmqlpNyptNs0+O3Bs=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR1001MB2350.namprd10.prod.outlook.com
 (2603:10b6:301:2f::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.17; Tue, 28 Jun
 2022 07:35:13 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b%6]) with mapi id 15.20.5373.015; Tue, 28 Jun 2022
 07:35:13 +0000
Date:   Tue, 28 Jun 2022 10:34:49 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Paolo Bonzini <pbonzini@redhat.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Isaku Yamahata <isaku.yamahata@intel.com>,
        Like Xu <likexu@tencent.com>
Subject: [intel-tdx:kvm-upstream 121/267] arch/x86/events/core.c:2114
 init_hw_perf_events() warn: missing error code 'err'
Message-ID: <202206280900.c8PW41Dn-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0026.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::10)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e39f3af9-8a3e-4c01-d443-08da58d8bcba
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2350:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bAO9umHiO0TeChEOMaVj/vAQFz+AURePb3nkQnO7tOHJ65ao6bXcEZ6oqWiiO2wzap12tzi74264SLwkCJfA5p+7QDwO0PmUjNHsFWIDGyF62o7afE7KsOWUGyI1uYsgI5Yz82q5m/A7iIp8A8jVZVZ5ye3ew/Y3UJTiuY0tmKFIXZVvBRYu2rB1QpwDNJts9uTI1tOjv37N+T2yaeu+kh3kpoCEOzL7+HgvYeqQk3af3GUteF/XolxDHX179U6DAw5cjOp84b/75CIn2Ry+c8izbfGyMNmU75bvQQCCjSwnc68zoRZychXmMeiFgy8lIauy4Klfynu0hQ2imPUKaGuQHRNr6y7JeLgEvrwboyT79E9kL1z++IDzPDsldqahFiRhTPy4XBdSfgR0UVNkpGiUErk1Ci8TIVsa3I00MwnWKMNIE59S3EhGQYagUIet2xb0lYGxdqnP3t3g4+0dhMP8mfJDp5RQKWc+NbKJLaEuIhRqMOXrEzEgqQJ713s6Qqn/mutxcUvjQPyw29lzGeVna45gcxRcp71QtMgyOyVpgpbY8e6mGXMjrt8Ja+7N0RQ8LFyeTyBS2xSdQnriefSw7U8Wtj0xADiTCdMhqc6b7p0gZY02AMWg1MCqFMwC2KdXDtVOH6yT83mFnDBO94l/mtLF7914SMy9UmIHdFtePSypimWFB3uLGIF/UgIN1PlJhesc14LTOE+hvOMWAeN1p59ba2KS6m08F6m1IQYLuxHO18mUVttxLd3uF6kGX2EKd0yCTf3L0CuNPdCsJPRmKu/rgy3LFJ/b0PBAU82lUPffZ1Mm6X7DCiWNo4eO9rV2TybsmLdXWCESV2fySyPN//4x5ZVWCONSPpVNcqw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(39860400002)(376002)(346002)(136003)(366004)(86362001)(36756003)(38350700002)(316002)(2906002)(52116002)(4001150100001)(9686003)(54906003)(30864003)(6512007)(6506007)(1076003)(6916009)(26005)(6666004)(66946007)(83380400001)(5660300002)(4326008)(966005)(8676002)(66556008)(38100700002)(6486002)(66476007)(41300700001)(186003)(8936002)(44832011)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ErYYQr/rA/H+yFMKau0gE7pGy3JT//C0xc8IWdxCV+Ymwh3MNNgNmd+qtrvT?=
 =?us-ascii?Q?JKcns3AsaDmjNQl6P8a3p3fvVupxY0Gnxjild8cXBJqwMTOAmYOMtED46mu4?=
 =?us-ascii?Q?VfQyR1tzyC9BqS6jHfN8/KOd61QnB5Ymm4fDwLIaI41w6TN15HbOWBkRAHU+?=
 =?us-ascii?Q?Nd3/TNJbWkeRBuPqv6Lzj3YJ///v2Jihacy/21pctTqV3bX98NNpG9oKUGEW?=
 =?us-ascii?Q?kxeIS8IuxoJNPOFS2tdUiR6rDQ2DTgtYeltkYT8+WykKcp4wP4qjiYdjvMHY?=
 =?us-ascii?Q?ZOTjELENcuku2C5DSdT0QdttEWtuaF5L0GdZC1Yi5xc5JvPyMxRRqpzaIheg?=
 =?us-ascii?Q?gtxnwzVWXUQBETShDopXICImL8UOSQ279vwxA2Y2sYqD5WbwtpdJfUsK113L?=
 =?us-ascii?Q?eF3xLPkg1IgV1NeWJMEZ20KmGYTKYvDlrGdVxUzbBYtDutt3M3dSYSdTLuTb?=
 =?us-ascii?Q?ggQzQME6d0po8XRb5Z61aqqgxscaGmhcGSbcwpqg9j+ZrVF6OuFdZv6NjGPb?=
 =?us-ascii?Q?xK3nf0ASfkUvdGyHzjg5ErVmB0WgTlNOElew8tzupZoYkUtQ5EoPGdBioi3G?=
 =?us-ascii?Q?gwufYx2OiO1tXRK7thH8TBFYukfxHpMqIuqxG7eu1mS4NHtyzc4eN0+3T+lf?=
 =?us-ascii?Q?olzA02xQ1Cp4I9ftMjOfM0i4YUE41gk0aFCAkbS8azh+6/yh2OE2UX4/3UXM?=
 =?us-ascii?Q?fTZ9ibEfa5mnVQGHfL58dirWgOOoJfak5VyqMxaau/r7iW5lc8EJaDrz+CLE?=
 =?us-ascii?Q?KsqUyb/wRqwWdbyd7Z0nnLXyT+NsaIsaypMuEOEiuWNaNeuOtMPb15br6fG9?=
 =?us-ascii?Q?FnKjrnMMiQGneuJcIJMkNjG+rqaZSVKJ9egi+1SB8xxyX3oRnO1PkuiqHquj?=
 =?us-ascii?Q?+3+kcn1WxRK8cjOevqIz0rlFWFpzrHxP0Isz4wW2gNd2P6fbiuvdzG6ns2fA?=
 =?us-ascii?Q?ZmLP5FNCTr6NB2LKdEmsIb9kdEKM34IG3XZYcQ5qsv+QscfLipJsPHS053sM?=
 =?us-ascii?Q?SrxVrNKfxC32T2YDNJlPDpn495E6K8IuCEJWrjtfIU6/9+lECHHpuDrUzJL8?=
 =?us-ascii?Q?pQPa1tFfEfXPH5UcnSSe8Va7aGJCf7eYJvziIzZndiXnI4+DAr7rD6k4PVLs?=
 =?us-ascii?Q?HdaC7tSmyA//jIbgox0o4EZtoc4y+Nro5G0mqyQQSbh6AnBiuL4CdqfMYlS7?=
 =?us-ascii?Q?8uA+wE2lQTzYgdBuLKxvcyyuRfxCxy8uMW/J58rdp/1lafZqgqSPil80M3cV?=
 =?us-ascii?Q?dG0nAleeXQvGi0aAQEF0YggpnNiEH9RGJCphAucSymNBBnDLXNUXAigAoT76?=
 =?us-ascii?Q?WY3Q97TQ45+iGhlYvoz9GdUjjl6pk6YnmCTlG8ZEytYLDvzm1neI+1OdvJv+?=
 =?us-ascii?Q?wY8n1/nPmeYx4zDvESNhlNS+QumZ+HtNAakAwYR9Qb2W+XtLhkZIx4ttOL+1?=
 =?us-ascii?Q?c6uTU78PyUSJFHfnMQps6+hpApUr4alWnx9N2FyGNx2jP4x/tbYUHqd7bFzB?=
 =?us-ascii?Q?CeVX//O6klkRcKLNkrLUhGcDrjdhaOUpICak5iBpxwxbUjptYh0sRRzT7quy?=
 =?us-ascii?Q?DVrJKrlwe+/rSshFoYLgjeqqNfol5gHkYuy1h1sE?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e39f3af9-8a3e-4c01-d443-08da58d8bcba
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2022 07:35:13.0762
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k2zV3K3qgdHRBfeTcVFT6MZ5cadr/QAln5vDNH/DwozcANwDw7U13KmkHNbnbH5xBUX4Zu5xNuEt4LFs/48TYMPybgtWoih3sHoq0pbAr1U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2350
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-27_09:2022-06-24,2022-06-27 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 phishscore=0 adultscore=0 malwarescore=0 bulkscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206280030
X-Proofpoint-ORIG-GUID: 2ksUk1tUw2P1T7MLRB55Wo8dZzjL54oX
X-Proofpoint-GUID: 2ksUk1tUw2P1T7MLRB55Wo8dZzjL54oX
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel/tdx.git kvm-upstream
head:   7af4efe32638544aecb58ed7365d0ef2ea6f85ea
commit: ac0739f7f73f45210f810e6e389416b5b62bf9d3 [121/267] x86: events: Do not return bogus capabilities if PMU is broken
config: x86_64-randconfig-m001-20220627 (https://download.01.org/0day-ci/archive/20220628/202206280900.c8PW41Dn-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
arch/x86/events/core.c:2114 init_hw_perf_events() warn: missing error code 'err'

vim +/err +2114 arch/x86/events/core.c

dda99116969142c arch/x86/kernel/cpu/perf_event.c   Yinghai Lu             2011-01-21  2079  static int __init init_hw_perf_events(void)
b56a3802dc6df29 arch/x86/kernel/cpu/perf_counter.c Jaswinder Singh Rajput 2009-02-27  2080  {
c1d6f42f1a42c72 arch/x86/kernel/cpu/perf_event.c   Peter Zijlstra         2011-12-06  2081  	struct x86_pmu_quirk *quirk;
72eae04d3a3075c arch/x86/kernel/cpu/perf_counter.c Robert Richter         2009-04-29  2082  	int err;
72eae04d3a3075c arch/x86/kernel/cpu/perf_counter.c Robert Richter         2009-04-29  2083  
cdd6c482c9ff9c5 arch/x86/kernel/cpu/perf_event.c   Ingo Molnar            2009-09-21  2084  	pr_info("Performance Events: ");
1123e3ad73697d6 arch/x86/kernel/cpu/perf_counter.c Ingo Molnar            2009-05-29  2085  
b56a3802dc6df29 arch/x86/kernel/cpu/perf_counter.c Jaswinder Singh Rajput 2009-02-27  2086  	switch (boot_cpu_data.x86_vendor) {
b56a3802dc6df29 arch/x86/kernel/cpu/perf_counter.c Jaswinder Singh Rajput 2009-02-27  2087  	case X86_VENDOR_INTEL:
72eae04d3a3075c arch/x86/kernel/cpu/perf_counter.c Robert Richter         2009-04-29  2088  		err = intel_pmu_init();
b56a3802dc6df29 arch/x86/kernel/cpu/perf_counter.c Jaswinder Singh Rajput 2009-02-27  2089  		break;
f87ad35d37fa543 arch/x86/kernel/cpu/perf_counter.c Jaswinder Singh Rajput 2009-02-27  2090  	case X86_VENDOR_AMD:
72eae04d3a3075c arch/x86/kernel/cpu/perf_counter.c Robert Richter         2009-04-29  2091  		err = amd_pmu_init();
f87ad35d37fa543 arch/x86/kernel/cpu/perf_counter.c Jaswinder Singh Rajput 2009-02-27  2092  		break;
6d0ef316b9f8ea0 arch/x86/events/core.c             Pu Wen                 2018-09-23  2093  	case X86_VENDOR_HYGON:
6d0ef316b9f8ea0 arch/x86/events/core.c             Pu Wen                 2018-09-23  2094  		err = amd_pmu_init();
6d0ef316b9f8ea0 arch/x86/events/core.c             Pu Wen                 2018-09-23  2095  		x86_pmu.name = "HYGON";
6d0ef316b9f8ea0 arch/x86/events/core.c             Pu Wen                 2018-09-23  2096  		break;
3a4ac121c2cacbf arch/x86/events/core.c             CodyYao-oc             2020-04-13  2097  	case X86_VENDOR_ZHAOXIN:
3a4ac121c2cacbf arch/x86/events/core.c             CodyYao-oc             2020-04-13  2098  	case X86_VENDOR_CENTAUR:
3a4ac121c2cacbf arch/x86/events/core.c             CodyYao-oc             2020-04-13  2099  		err = zhaoxin_pmu_init();
3a4ac121c2cacbf arch/x86/events/core.c             CodyYao-oc             2020-04-13  2100  		break;
4138960a9251a26 arch/x86/kernel/cpu/perf_counter.c Robert Richter         2009-04-29  2101  	default:
8a3da6c7d0031fc arch/x86/kernel/cpu/perf_event.c   Ingo Molnar            2013-09-28  2102  		err = -ENOTSUPP;
b56a3802dc6df29 arch/x86/kernel/cpu/perf_counter.c Jaswinder Singh Rajput 2009-02-27  2103  	}
1123e3ad73697d6 arch/x86/kernel/cpu/perf_counter.c Ingo Molnar            2009-05-29  2104  	if (err != 0) {
cdd6c482c9ff9c5 arch/x86/kernel/cpu/perf_event.c   Ingo Molnar            2009-09-21  2105  		pr_cont("no PMU driver, software events only.\n");
ac0739f7f73f452 arch/x86/events/core.c             Paolo Bonzini          2022-06-01  2106  		err = 0;
ac0739f7f73f452 arch/x86/events/core.c             Paolo Bonzini          2022-06-01  2107  		goto out_bad_pmu;
1123e3ad73697d6 arch/x86/kernel/cpu/perf_counter.c Ingo Molnar            2009-05-29  2108  	}
b56a3802dc6df29 arch/x86/kernel/cpu/perf_counter.c Jaswinder Singh Rajput 2009-02-27  2109  
125580380f41800 arch/x86/kernel/cpu/perf_event.c   Cyrill Gorcunov        2009-12-10  2110  	pmu_check_apic();
125580380f41800 arch/x86/kernel/cpu/perf_event.c   Cyrill Gorcunov        2009-12-10  2111  
33c6d6a7ad0ffab arch/x86/kernel/cpu/perf_event.c   Don Zickus             2010-11-22  2112  	/* sanity check that the hardware exists or is emulated */
fc4b8fca2d8fc8a arch/x86/events/core.c             Kan Liang              2021-04-12  2113  	if (!check_hw_exists(&pmu, x86_pmu.num_counters, x86_pmu.num_counters_fixed))
ac0739f7f73f452 arch/x86/events/core.c             Paolo Bonzini          2022-06-01 @2114  		goto out_bad_pmu;

Does this need an error code?  It's unclear why this needs a goto
out_bad_pmu when

33c6d6a7ad0ffab arch/x86/kernel/cpu/perf_event.c   Don Zickus             2010-11-22  2115  
1123e3ad73697d6 arch/x86/kernel/cpu/perf_counter.c Ingo Molnar            2009-05-29  2116  	pr_cont("%s PMU driver.\n", x86_pmu.name);
faa28ae018ed004 arch/x86/kernel/cpu/perf_counter.c Robert Richter         2009-04-29  2117  
e97df76377b8b3b arch/x86/kernel/cpu/perf_event.c   Peter Zijlstra         2014-02-05  2118  	x86_pmu.attr_rdpmc = 1; /* enable userspace RDPMC usage by default */
e97df76377b8b3b arch/x86/kernel/cpu/perf_event.c   Peter Zijlstra         2014-02-05  2119  
c1d6f42f1a42c72 arch/x86/kernel/cpu/perf_event.c   Peter Zijlstra         2011-12-06  2120  	for (quirk = x86_pmu.quirks; quirk; quirk = quirk->next)
c1d6f42f1a42c72 arch/x86/kernel/cpu/perf_event.c   Peter Zijlstra         2011-12-06  2121  		quirk->func();
3c44780b220e876 arch/x86/kernel/cpu/perf_event.c   Peter Zijlstra         2010-03-04  2122  
a1eac7ac903ea9a arch/x86/kernel/cpu/perf_event.c   Robert Richter         2012-06-20  2123  	if (!x86_pmu.intel_ctrl)
948b1bb89a44561 arch/x86/kernel/cpu/perf_event.c   Robert Richter         2010-03-29  2124  		x86_pmu.intel_ctrl = (1 << x86_pmu.num_counters) - 1;
241771ef016b5c0 arch/x86/kernel/cpu/perf_counter.c Ingo Molnar            2008-12-03  2125  
cdd6c482c9ff9c5 arch/x86/kernel/cpu/perf_event.c   Ingo Molnar            2009-09-21  2126  	perf_events_lapic_init();
9c48f1c629ecfa1 arch/x86/kernel/cpu/perf_event.c   Don Zickus             2011-09-30  2127  	register_nmi_handler(NMI_LOCAL, perf_event_nmi_handler, 0, "PMI");
1123e3ad73697d6 arch/x86/kernel/cpu/perf_counter.c Ingo Molnar            2009-05-29  2128  
63b146490befc02 arch/x86/kernel/cpu/perf_event.c   Peter Zijlstra         2010-01-22  2129  	unconstrained = (struct event_constraint)
948b1bb89a44561 arch/x86/kernel/cpu/perf_event.c   Robert Richter         2010-03-29  2130  		__EVENT_CONSTRAINT(0, (1ULL << x86_pmu.num_counters) - 1,
9fac2cf316b070a arch/x86/kernel/cpu/perf_event.c   Stephane Eranian       2013-01-24  2131  				   0, x86_pmu.num_counters, 0, 0);
63b146490befc02 arch/x86/kernel/cpu/perf_event.c   Peter Zijlstra         2010-01-22  2132  
641cc938815dfd0 arch/x86/kernel/cpu/perf_event.c   Jiri Olsa              2012-03-15  2133  	x86_pmu_format_group.attrs = x86_pmu.format_attrs;
0c9d42ed4cee2aa arch/x86/kernel/cpu/perf_event.c   Peter Zijlstra         2011-11-20  2134  
a47473939db20e3 arch/x86/kernel/cpu/perf_event.c   Jiri Olsa              2012-10-10  2135  	if (!x86_pmu.events_sysfs_show)
a47473939db20e3 arch/x86/kernel/cpu/perf_event.c   Jiri Olsa              2012-10-10  2136  		x86_pmu_events_group.attrs = &empty_attrs;
a47473939db20e3 arch/x86/kernel/cpu/perf_event.c   Jiri Olsa              2012-10-10  2137  
baa0c83363c7aaf arch/x86/events/core.c             Jiri Olsa              2019-05-12  2138  	pmu.attr_update = x86_pmu.attr_update;
6089327f5424f22 arch/x86/events/core.c             Kan Liang              2017-05-12  2139  
d9977c43bff895e arch/x86/events/core.c             Kan Liang              2021-04-12  2140  	if (!is_hybrid()) {
d9977c43bff895e arch/x86/events/core.c             Kan Liang              2021-04-12  2141  		x86_pmu_show_pmu_cap(x86_pmu.num_counters,
d9977c43bff895e arch/x86/events/core.c             Kan Liang              2021-04-12  2142  				     x86_pmu.num_counters_fixed,
e11c1a7eb302ac8 arch/x86/events/core.c             Kan Liang              2021-04-12  2143  				     x86_pmu.intel_ctrl);
d9977c43bff895e arch/x86/events/core.c             Kan Liang              2021-04-12  2144  	}
3f6da3905398826 arch/x86/kernel/cpu/perf_event.c   Peter Zijlstra         2010-03-05  2145  
7c9903c9bf716d8 arch/x86/events/core.c             Peter Zijlstra         2020-08-18  2146  	if (!x86_pmu.read)
7c9903c9bf716d8 arch/x86/events/core.c             Peter Zijlstra         2020-08-18  2147  		x86_pmu.read = _x86_pmu_read;
7c9903c9bf716d8 arch/x86/events/core.c             Peter Zijlstra         2020-08-18  2148  
abd562df94d19d0 arch/x86/events/core.c             Like Xu                2021-01-25  2149  	if (!x86_pmu.guest_get_msrs)
c8e2fe13d1d1f3a arch/x86/events/core.c             Sean Christopherson    2021-03-09  2150  		x86_pmu.guest_get_msrs = (void *)&__static_call_return0;
abd562df94d19d0 arch/x86/events/core.c             Like Xu                2021-01-25  2151  
7c9903c9bf716d8 arch/x86/events/core.c             Peter Zijlstra         2020-08-18  2152  	x86_pmu_static_call_update();
7c9903c9bf716d8 arch/x86/events/core.c             Peter Zijlstra         2020-08-18  2153  
95ca792c7582fde arch/x86/events/core.c             Thomas Gleixner        2016-07-13  2154  	/*
95ca792c7582fde arch/x86/events/core.c             Thomas Gleixner        2016-07-13  2155  	 * Install callbacks. Core will call them for each online
95ca792c7582fde arch/x86/events/core.c             Thomas Gleixner        2016-07-13  2156  	 * cpu.
95ca792c7582fde arch/x86/events/core.c             Thomas Gleixner        2016-07-13  2157  	 */
73c1b41e63f040e arch/x86/events/core.c             Thomas Gleixner        2016-12-21  2158  	err = cpuhp_setup_state(CPUHP_PERF_X86_PREPARE, "perf/x86:prepare",
95ca792c7582fde arch/x86/events/core.c             Thomas Gleixner        2016-07-13  2159  				x86_pmu_prepare_cpu, x86_pmu_dead_cpu);
95ca792c7582fde arch/x86/events/core.c             Thomas Gleixner        2016-07-13  2160  	if (err)
95ca792c7582fde arch/x86/events/core.c             Thomas Gleixner        2016-07-13  2161  		return err;

This error path does a direct return

95ca792c7582fde arch/x86/events/core.c             Thomas Gleixner        2016-07-13  2162  
95ca792c7582fde arch/x86/events/core.c             Thomas Gleixner        2016-07-13  2163  	err = cpuhp_setup_state(CPUHP_AP_PERF_X86_STARTING,
73c1b41e63f040e arch/x86/events/core.c             Thomas Gleixner        2016-12-21  2164  				"perf/x86:starting", x86_pmu_starting_cpu,
95ca792c7582fde arch/x86/events/core.c             Thomas Gleixner        2016-07-13  2165  				x86_pmu_dying_cpu);
95ca792c7582fde arch/x86/events/core.c             Thomas Gleixner        2016-07-13  2166  	if (err)
95ca792c7582fde arch/x86/events/core.c             Thomas Gleixner        2016-07-13  2167  		goto out;
95ca792c7582fde arch/x86/events/core.c             Thomas Gleixner        2016-07-13  2168  
73c1b41e63f040e arch/x86/events/core.c             Thomas Gleixner        2016-12-21  2169  	err = cpuhp_setup_state(CPUHP_AP_PERF_X86_ONLINE, "perf/x86:online",
95ca792c7582fde arch/x86/events/core.c             Thomas Gleixner        2016-07-13  2170  				x86_pmu_online_cpu, NULL);
95ca792c7582fde arch/x86/events/core.c             Thomas Gleixner        2016-07-13  2171  	if (err)
95ca792c7582fde arch/x86/events/core.c             Thomas Gleixner        2016-07-13  2172  		goto out1;
95ca792c7582fde arch/x86/events/core.c             Thomas Gleixner        2016-07-13  2173  
d9977c43bff895e arch/x86/events/core.c             Kan Liang              2021-04-12  2174  	if (!is_hybrid()) {
95ca792c7582fde arch/x86/events/core.c             Thomas Gleixner        2016-07-13  2175  		err = perf_pmu_register(&pmu, "cpu", PERF_TYPE_RAW);
95ca792c7582fde arch/x86/events/core.c             Thomas Gleixner        2016-07-13  2176  		if (err)
95ca792c7582fde arch/x86/events/core.c             Thomas Gleixner        2016-07-13  2177  			goto out2;
d9977c43bff895e arch/x86/events/core.c             Kan Liang              2021-04-12  2178  	} else {
d9977c43bff895e arch/x86/events/core.c             Kan Liang              2021-04-12  2179  		u8 cpu_type = get_this_hybrid_cpu_type();
d9977c43bff895e arch/x86/events/core.c             Kan Liang              2021-04-12  2180  		struct x86_hybrid_pmu *hybrid_pmu;
d9977c43bff895e arch/x86/events/core.c             Kan Liang              2021-04-12  2181  		int i, j;
d9977c43bff895e arch/x86/events/core.c             Kan Liang              2021-04-12  2182  
d9977c43bff895e arch/x86/events/core.c             Kan Liang              2021-04-12  2183  		if (!cpu_type && x86_pmu.get_hybrid_cpu_type)
d9977c43bff895e arch/x86/events/core.c             Kan Liang              2021-04-12  2184  			cpu_type = x86_pmu.get_hybrid_cpu_type();
d9977c43bff895e arch/x86/events/core.c             Kan Liang              2021-04-12  2185  
d9977c43bff895e arch/x86/events/core.c             Kan Liang              2021-04-12  2186  		for (i = 0; i < x86_pmu.num_hybrid_pmus; i++) {
d9977c43bff895e arch/x86/events/core.c             Kan Liang              2021-04-12  2187  			hybrid_pmu = &x86_pmu.hybrid_pmu[i];
d9977c43bff895e arch/x86/events/core.c             Kan Liang              2021-04-12  2188  
d9977c43bff895e arch/x86/events/core.c             Kan Liang              2021-04-12  2189  			hybrid_pmu->pmu = pmu;
d9977c43bff895e arch/x86/events/core.c             Kan Liang              2021-04-12  2190  			hybrid_pmu->pmu.type = -1;
d9977c43bff895e arch/x86/events/core.c             Kan Liang              2021-04-12  2191  			hybrid_pmu->pmu.attr_update = x86_pmu.attr_update;
d9977c43bff895e arch/x86/events/core.c             Kan Liang              2021-04-12  2192  			hybrid_pmu->pmu.capabilities |= PERF_PMU_CAP_HETEROGENEOUS_CPUS;
55bcf6ef314ae8b arch/x86/events/core.c             Kan Liang              2021-04-12  2193  			hybrid_pmu->pmu.capabilities |= PERF_PMU_CAP_EXTENDED_HW_TYPE;
d9977c43bff895e arch/x86/events/core.c             Kan Liang              2021-04-12  2194  
d9977c43bff895e arch/x86/events/core.c             Kan Liang              2021-04-12  2195  			err = perf_pmu_register(&hybrid_pmu->pmu, hybrid_pmu->name,
d9977c43bff895e arch/x86/events/core.c             Kan Liang              2021-04-12  2196  						(hybrid_pmu->cpu_type == hybrid_big) ? PERF_TYPE_RAW : -1);
d9977c43bff895e arch/x86/events/core.c             Kan Liang              2021-04-12  2197  			if (err)
d9977c43bff895e arch/x86/events/core.c             Kan Liang              2021-04-12  2198  				break;
d9977c43bff895e arch/x86/events/core.c             Kan Liang              2021-04-12  2199  
d9977c43bff895e arch/x86/events/core.c             Kan Liang              2021-04-12  2200  			if (cpu_type == hybrid_pmu->cpu_type)
d9977c43bff895e arch/x86/events/core.c             Kan Liang              2021-04-12  2201  				x86_pmu_update_cpu_context(&hybrid_pmu->pmu, raw_smp_processor_id());
d9977c43bff895e arch/x86/events/core.c             Kan Liang              2021-04-12  2202  		}
d9977c43bff895e arch/x86/events/core.c             Kan Liang              2021-04-12  2203  
d9977c43bff895e arch/x86/events/core.c             Kan Liang              2021-04-12  2204  		if (i < x86_pmu.num_hybrid_pmus) {
d9977c43bff895e arch/x86/events/core.c             Kan Liang              2021-04-12  2205  			for (j = 0; j < i; j++)
d9977c43bff895e arch/x86/events/core.c             Kan Liang              2021-04-12  2206  				perf_pmu_unregister(&x86_pmu.hybrid_pmu[j].pmu);
d9977c43bff895e arch/x86/events/core.c             Kan Liang              2021-04-12  2207  			pr_warn("Failed to register hybrid PMUs\n");
d9977c43bff895e arch/x86/events/core.c             Kan Liang              2021-04-12  2208  			kfree(x86_pmu.hybrid_pmu);
d9977c43bff895e arch/x86/events/core.c             Kan Liang              2021-04-12  2209  			x86_pmu.hybrid_pmu = NULL;
d9977c43bff895e arch/x86/events/core.c             Kan Liang              2021-04-12  2210  			x86_pmu.num_hybrid_pmus = 0;
d9977c43bff895e arch/x86/events/core.c             Kan Liang              2021-04-12  2211  			goto out2;
d9977c43bff895e arch/x86/events/core.c             Kan Liang              2021-04-12  2212  		}
d9977c43bff895e arch/x86/events/core.c             Kan Liang              2021-04-12  2213  	}
004417a6d468e24 arch/x86/kernel/cpu/perf_event.c   Peter Zijlstra         2010-11-25  2214  
004417a6d468e24 arch/x86/kernel/cpu/perf_event.c   Peter Zijlstra         2010-11-25  2215  	return 0;
95ca792c7582fde arch/x86/events/core.c             Thomas Gleixner        2016-07-13  2216  
95ca792c7582fde arch/x86/events/core.c             Thomas Gleixner        2016-07-13  2217  out2:
95ca792c7582fde arch/x86/events/core.c             Thomas Gleixner        2016-07-13  2218  	cpuhp_remove_state(CPUHP_AP_PERF_X86_ONLINE);
95ca792c7582fde arch/x86/events/core.c             Thomas Gleixner        2016-07-13  2219  out1:
95ca792c7582fde arch/x86/events/core.c             Thomas Gleixner        2016-07-13  2220  	cpuhp_remove_state(CPUHP_AP_PERF_X86_STARTING);
95ca792c7582fde arch/x86/events/core.c             Thomas Gleixner        2016-07-13  2221  out:
95ca792c7582fde arch/x86/events/core.c             Thomas Gleixner        2016-07-13  2222  	cpuhp_remove_state(CPUHP_PERF_X86_PREPARE);
ac0739f7f73f452 arch/x86/events/core.c             Paolo Bonzini          2022-06-01  2223  out_bad_pmu:
ac0739f7f73f452 arch/x86/events/core.c             Paolo Bonzini          2022-06-01  2224  	memset(&x86_pmu, 0, sizeof(x86_pmu));
95ca792c7582fde arch/x86/events/core.c             Thomas Gleixner        2016-07-13  2225  	return err;
241771ef016b5c0 arch/x86/kernel/cpu/perf_counter.c Ingo Molnar            2008-12-03  2226  }

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

