Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E3E756565A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 15:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234577AbiGDNBv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 09:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231741AbiGDNBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 09:01:50 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B0C963E1
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 06:01:49 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 264D1k4q006890;
        Mon, 4 Jul 2022 13:01:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=/phIKQcYEzIG1h+HnjpboTsKx5+gWLLfW61NvkXAZ5Q=;
 b=eM3tjnJBsJ630CbnwddHKw9sW4dMIB3FqGaleIsGr9zsVD/gexbjKYzvNHWr+Y3KYfHY
 BX7T1mo8gVgAWJOSKvhd3SQiY04dbCX32uIiObQUizztgtq4y6zv+2BFdo7i+vPXMf+5
 2A2PhZ85Z9P1nuhw4DkAeDgt8F5w7+shKFGimrle/H5WWvNjifEZEpf+fyPfbashic4N
 m6Y5+5rqjJInns3DRVOuWccUgjui53P+TCHMolu2g+UYtzngcnG3zTSBsIE3PqFcGgi+
 bgcBRppDH/xU8dMXeyH7Msm3gE+RYclB3M3gnKL9Bk6EjBn+cyGHhbrmpwD/UyzY2Puf tw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h2ct2bfkx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Jul 2022 13:01:45 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 264CtjqU004501;
        Mon, 4 Jul 2022 13:01:44 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3h2cf1jts2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Jul 2022 13:01:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j6wt3o9dpfuqKmp2eGXjfWdOqLYlrZhH8eV2R3uFaKJ3qy1YsTutHPFPiLbw36k1YAKVtYV4d0cjaemdlRhQcnXdwtwe7z+YdzRKaCls1yoxOm2w78wmsVT6gBeTLaU6mq4j3P+px6CIc+cBkl182sfzJANegDZYkgyRQHxFquId/IBdwyDx/OSVqpLSyT4KVOkf3cAlXlvdYHj+7wMCDr9a+ttGnmGaJszG0rgbIEqHc2sfGmZWwyzeU2CjS5g5iJ5wSB4lDUveZmIte4zIeokrwDwESS234VPghu/hH4jLF4ySl5ViNo5T847ZHyPS14d3c6KbuXIiqoOZ2FQ2OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/phIKQcYEzIG1h+HnjpboTsKx5+gWLLfW61NvkXAZ5Q=;
 b=V24P2dIm825qi7pVgC9BElMSRnTB/uBHvA1z4RUpYBi8TRghlanacUnvRzAU/8euRDN2Q1RnK7oXNLiQ7b+zxyvgImVQWzNzSxIt+CZMVbQ9UvGeJyhsEFkO6lNGZb02N4Z2Gb62HArDAi3oNSLIAnzvmbwwkWyOBm2mc2kRdGQPSuWOUviHuFJKQsJnzZVJlYfjz7G+PgLCQ3WTuH6UHQs1OYkr6KAW7hQDV39BwHH0T3jhTpzFOugyzHBDHLwyoScTbCzVwEaPCd+nZUvvqnBVDoUjf6xZAZSLHme2GH5wWHRIk2MTNpwXwcE0r2mvbgaJUKV1uN7gnWeZUAglUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/phIKQcYEzIG1h+HnjpboTsKx5+gWLLfW61NvkXAZ5Q=;
 b=BzpD/AcNm9M8wrad5vvFl5TU4LwRNkoUOYz+3WUIxWmuzxB/JgOhNScYoILAVlsYsoecZltG8vLeOknncEQxeoVBjB0YvaaLhhsTL2P4dt6f1PSCGgLy10IfReAdzIK9wZb4Kf7of+lUuEIouvkwSQ6fPYQ43e4sI7KQwgqN9OY=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MN2PR10MB4077.namprd10.prod.outlook.com
 (2603:10b6:208:182::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Mon, 4 Jul
 2022 13:01:41 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b%6]) with mapi id 15.20.5395.021; Mon, 4 Jul 2022
 13:01:41 +0000
Date:   Mon, 4 Jul 2022 16:01:24 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Pavel Begunkov <asml.silence@gmail.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [isilence:zc_v3 18/28] io_uring/notif.c:54
 io_uring_tx_zerocopy_callback() warn: if statement not indented
Message-ID: <202207030820.61aWmZmk-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0046.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4e::23)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6a82a4d0-7ba2-466c-549f-08da5dbd56e6
X-MS-TrafficTypeDiagnostic: MN2PR10MB4077:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DtnJ7/w5yYCgXAPEbe3pDUrf2jGu5uvQ+cLA4ub3cYslxRoHuYpR6zRGqVBRD1b7Sp3yln4j2zDKgbXLGtuowDt/qjM1ipmq0IfGRfljctVpCcGKiH9SVBDM6MppqegPlCd9Z0xYSh5qhAl59/hYhmL0MV6SXYccELoWdTdEPcM4evD5aSQTFCGcTrFejQVXUJrtFZ99CDh7dMPqpDjjtXQXKb8NODiJkve+C/72QSVNWFlE4CZS6OmwpdOVx72f7qdmi3Lm/i2MRpx1wKFfTX2qxqEg+ni/z85lUx9t+FII8YaAIMFfHtFzgiSwXcmaWAxY9UxbGBOnzF+gzdpVpxK0guUkCbmtml+m3h9rCJpXBUQ0W+b2Ax0lBOm8CHyXvTEW7unJzpinjedDpAVgrCAdUQoryrKnSHoVcDgkfDCjtCiWb+W2nHdDoybK/5wgw6KZPw9OKJURvFpcUOlmo/42n694qS4ZEWa4qQWuIoiiliWE69oJux3nhfS8qQRz2yJppLnmxHDqCSwwcz4LVD6lipzrv4KLn1ftT8dM08g5AVAT39nZKQHzEcu/SkixKT5N3ikcNZDAZl9x7Q0Nq1IsCzydTdjAn7QdXCGfhwwc489WBzzQ1OwKgS3hJCSKyfr24m8sRa9HAyO7HThzHWskH4ghBrzdjU0vEUmoBjz44gfjCeuXLHsuUDvMJ9oIwUVoDoGUGWvRXEv+KCNzowhtppcc5mQth8X8TC5bsZ1SSYWxqNJqp/Yuzaezak3rVoPTzb1lI/EOW0KZgbfM+M/5Ho/98gaTkm8EHXT0Ee2k/H0p7B4znflGfpJCO55A4ONIOEnQz4aHf3kjMENp74G8BzRmZmFzq0sVQ56xc99qM67A5MrJS5IrL4KGWLzd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(39860400002)(346002)(136003)(366004)(396003)(186003)(83380400001)(1076003)(38100700002)(38350700002)(5660300002)(44832011)(8936002)(36756003)(6916009)(478600001)(6512007)(2906002)(966005)(6486002)(26005)(52116002)(9686003)(41300700001)(8676002)(4326008)(86362001)(316002)(6506007)(66476007)(66946007)(6666004)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hPElxVuHidXdk4Gx9d5Nw+7Y7YK9CcbfjXoQ3z33YtaR1eqHBZY4Kdhip8IH?=
 =?us-ascii?Q?MtsjxtE9/GM6bNiT7LbJftgQp7ftue+vPnjlUarXLoSuaWOplOhAEmppzXb6?=
 =?us-ascii?Q?g8PVx8EgNEJeKAjslKdDWgdez9DGvlMbl3U/QCR5mkKYTs4LUP18ZzNBWJJk?=
 =?us-ascii?Q?uXe0DuKRGQKJHjEK9Vq/9hxjVNbuuolQDrjoPmC3K+MwSItZhGDlpXLUNApa?=
 =?us-ascii?Q?UoL5NUkaKK7J2V8/PAsxx+fTI993fJZQ+F3teLAHdogtTdx/noduRwlSrQlL?=
 =?us-ascii?Q?fvItboCwZsugIhovLlCIJcqRx7RpXP7bve7N/VN3EW5vif/VzkbKAcAFeSoC?=
 =?us-ascii?Q?67U5XLcQRutp60Q6yqbwPakzrxGKvvb/Rb3nx6lrs2ogC/qlVzigP+hfu6sq?=
 =?us-ascii?Q?NEkL7784Jql2LNNKfXaXxl0C3DCdT8lNelbmOsdjU8xon0UWQ1ztFKcNC+hl?=
 =?us-ascii?Q?F35Js3nGP1yfpOSFhsWcNyHV/na/9jNhU4iq331gDwXX4KU+vy43e8doUVxa?=
 =?us-ascii?Q?KDviUMmkEwTC5hl4BnleGMdY71o/kBvqYdnk2nOEE2vy5KzNpFKXDpSLPm1A?=
 =?us-ascii?Q?FSW34BQcemW6Hmi9ThP3ejBErAkNuHsIiez4AN/v4p67bBnSSC83VcjmWT6m?=
 =?us-ascii?Q?D+8suR8JxMlz/THxa5Qhao+pS8fJTHT43gViyyb2JTYXfTeXEIN0c/Nd7s99?=
 =?us-ascii?Q?xP8vhJL0wNBQKf9idS/vQlggTue8Ukxhbong1ci5Er+seVvUafWlngOLHzQ3?=
 =?us-ascii?Q?DWZC0j6mSELQlYOZYbU78Giwxh+wCoZ9ovT6DoUfI68KgmaGUW3f9whIMn1D?=
 =?us-ascii?Q?P5eJ9LoWwJXUjL0lqrpS/zZ5nXycg85JxRmRlGgj81laI0MgU+4tVHBf2aoc?=
 =?us-ascii?Q?gic6N2ik0KPg5cZSUU+/w/awN1GrxnGvEOc2mWTSVKZ31kO/NHHo4UljLoGG?=
 =?us-ascii?Q?VtFobrgei19XrHGJLYtX3uKa5YKnJD/IwocejhOhBBuFYoBqVTu3FMPU8f5C?=
 =?us-ascii?Q?CG8Yw8OpTwH46kC2q18AJWtLB0pgiyXXZO66mkCFM5LKpoMiO4qMOH6Mxky2?=
 =?us-ascii?Q?MXvjTzZqx9bUPJPDhvUGn2vqRZI/9HuwtolJf2W6kPel11dGWxkfIDE31hbK?=
 =?us-ascii?Q?jjTv5/MZsz46dIHFV/cMsUZbjWUWi/rHs33/5Q5JaAE1tLqKuyG65/swkM3C?=
 =?us-ascii?Q?7VEji4+1tRNoOOGrXZpUHDP1rfb4VT1Q9UunGHpGi4jbK+kQzuFL8V/4HgDY?=
 =?us-ascii?Q?ogkBL0HM+ani3GdPRVel/KqVOK1jT6WjJU0Mvtd14RbzaTD63UPfDsm5dLsX?=
 =?us-ascii?Q?yFg3X2tIEOClZICXMN81Kvo34DYDAPqx57wZQ3DzV7PKcRYUdJpTiTR9MX30?=
 =?us-ascii?Q?5bgW4FuQrXoH9c79woHvJtGsxo52dHy08m3LKVfA5kFV7jIzAIQZI4ZGP2h0?=
 =?us-ascii?Q?MB8xH6pnH+gOZCJUF81Z8bV/LxK3/QM7mj95J6poeN9l6PXbgyBp6FLbvQWh?=
 =?us-ascii?Q?5ajAXFgYNn+kDY10qZRvNzWAaeO+WsYKMrbTFKP1ULKjDfTmJMQOP7d4q3fL?=
 =?us-ascii?Q?GsFLE3fPdsXu22uahG3IIWGl1npp6TFq1jvyzRaRdBsJfXP9ULDNurBdv/TG?=
 =?us-ascii?Q?eg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a82a4d0-7ba2-466c-549f-08da5dbd56e6
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2022 13:01:41.7608
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 81rtmWUb7rFnw9YzJOhqymp4x3nhKHvhJelw0DHgsNuGeoNrbrO9yuYVteX/jxAUTyKV5gDa5N/8LOfO5p+jVfEwbgmzJoJ+5v7S1Y7n8FA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4077
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-04_11:2022-06-28,2022-07-04 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 spamscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2207040056
X-Proofpoint-GUID: -qUdCYQSC1Zx752E9oregM2aeTJvlpcE
X-Proofpoint-ORIG-GUID: -qUdCYQSC1Zx752E9oregM2aeTJvlpcE
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/isilence/linux zc_v3
head:   cd0bc816ae8dbc546df5c09cee92459ad759c4d1
commit: 591b24351034d95bc4f39a3d1cbbb7132109218d [18/28] io_uring: complete notifiers in tw
config: x86_64-randconfig-m001 (https://download.01.org/0day-ci/archive/20220703/202207030820.61aWmZmk-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
io_uring/notif.c:54 io_uring_tx_zerocopy_callback() warn: if statement not indented

vim +54 io_uring/notif.c

2239fd796a3a31 Pavel Begunkov 2022-05-05  43  static void io_uring_tx_zerocopy_callback(struct sk_buff *skb,
2239fd796a3a31 Pavel Begunkov 2022-05-05  44  					  struct ubuf_info *uarg,
2239fd796a3a31 Pavel Begunkov 2022-05-05  45  					  bool success)
2239fd796a3a31 Pavel Begunkov 2022-05-05  46  {
2239fd796a3a31 Pavel Begunkov 2022-05-05  47  	struct io_notif *notif = container_of(uarg, struct io_notif, uarg);
2239fd796a3a31 Pavel Begunkov 2022-05-05  48  
2239fd796a3a31 Pavel Begunkov 2022-05-05  49  	if (!refcount_dec_and_test(&uarg->refcnt))
2239fd796a3a31 Pavel Begunkov 2022-05-05  50  		return;
591b24351034d9 Pavel Begunkov 2022-05-05  51  
591b24351034d9 Pavel Begunkov 2022-05-05  52  	if (likely(notif->task)) {
591b24351034d9 Pavel Begunkov 2022-05-05  53  		init_task_work(&notif->task_work, __io_notif_complete_tw);
591b24351034d9 Pavel Begunkov 2022-05-05 @54  		if (likely(!task_work_add(notif->task, &notif->task_work,
591b24351034d9 Pavel Begunkov 2022-05-05  55  					  TWA_SIGNAL)))
591b24351034d9 Pavel Begunkov 2022-05-05  56  		return;

missing tab.

591b24351034d9 Pavel Begunkov 2022-05-05  57  	}
591b24351034d9 Pavel Begunkov 2022-05-05  58  
2239fd796a3a31 Pavel Begunkov 2022-05-05  59  	INIT_WORK(&notif->commit_work, io_notif_complete_wq);
2239fd796a3a31 Pavel Begunkov 2022-05-05  60  	queue_work(system_unbound_wq, &notif->commit_work);
2239fd796a3a31 Pavel Begunkov 2022-05-05  61  }

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

