Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F36351493B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 14:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359080AbiD2MaC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 08:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345891AbiD2MaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 08:30:00 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7555C852FA
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 05:26:42 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23TA3xwt003733;
        Fri, 29 Apr 2022 12:26:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=9lIz3y1ThEQEej1uwEmM8TLzx71n6+0a+rHf7Qgzp80=;
 b=rFYeMsMZ+WtoXMuN/vt6rxLEPF/3IRsLK2VLDgw5w3EiENi4fzT2+f58Qxbc05R1szez
 02k+M6HxiIxy/av4DF/JE/3u2Hms2/pZYqLfPT84ykJ0iVNZhjKJRtLldKDcbrDVV4hR
 aGDKmwt30GzzsNWBkN4FMLqROrq040k12YT+ZtR31RhNlxoe/jFDBQu0KJoc8QWn9H1A
 lNm2gSOivg250sKc4PKZgI32CWB+EUZ30c0NDWO0iq4NVvaGPkF5UV1gFi4hzeyyineA
 4TuqZSXcyFxvm4TZBIWnhNUg1wjA3HZNb6ciB8zl9YkwRMDzrbyBqGNn8Y/0fI4iu/AO Cg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmbb4x52g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Apr 2022 12:26:37 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23TCBDOT034199;
        Fri, 29 Apr 2022 12:26:37 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fm7w80nbc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Apr 2022 12:26:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JTGyoMVOVWsGozuiSbWniZbpXuFh6zlJX6M2t8ec0v5qVlLDbSqz//QdYD91sp2KIOK5QxCkT/6/djplpDh8lrE5RmQAalRMFIwRCU6kr4p93bB8AVi6WlduQEUf5XwfET3v1W1xJOikUaBD4DrDI3vyPQoVqU+3hBR0Z9TzSRQDFsWSsTVHHpADUpfVImhBAtH4YL+o4fRGHRh5PUBAQaNc1mNh+PyG7HLlJnUmJENoZ1ai7NTLFDw/M2eDv7ZBAfXeCBNkBgfmVjiz29gRGkVnVRt1YBe7pNwwkrDd1EB4KrBpPtAdFc3I3n3YVwLPzJEthi7afv4fFgg2PYcZcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9lIz3y1ThEQEej1uwEmM8TLzx71n6+0a+rHf7Qgzp80=;
 b=hrgIpZ5pumh9BwVo4Qe17RjIjuNOJdriloZ34KxnoM5+dCS8sDoEoFNruFf5ZEqnja/qlUpPOhEDGsIx2RrdIHbGgX6TOsl+F/2ij50SjcdQd1TFd3PrkmrYee/6R7lxoIaw5x1BoQ6d0IoMBnOuqk2yrwwIe6zNaq2qNcBVTE9pC8d5nERK9Ap0GACVf49Ra2DBth+uzQOCNM3OYh0BY9j6gHaLQ2DVP3Bn0XER3ggp+vArzT/85K5U1RHiHIiyDZ48v/dyrQFTjlBkrJTdvUSPXhajjCYXJGf40BnDpNR9NjWIYKpF9I1z/BWJn2sVWJcw7N0FzBVUSCW6J0iPwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9lIz3y1ThEQEej1uwEmM8TLzx71n6+0a+rHf7Qgzp80=;
 b=gAZZL2EBrzh3u7L1FPzhDHWUOjeOm6dm9vEdBrrDe3Y0t9fMhbF9C8VK89u+DGY9oQrT4l5QjpcuIa7zyvXZHy1CHMrA9HToIFLRldnY4WyiHonIRiuiJl7aTWuCrfh0/WLfCJbRLavjifHCuED3pXyLOdHlwBq29G7BYcRlwXg=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CY4PR10MB1959.namprd10.prod.outlook.com
 (2603:10b6:903:126::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Fri, 29 Apr
 2022 12:26:34 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87%5]) with mapi id 15.20.5164.025; Fri, 29 Apr 2022
 12:26:34 +0000
Date:   Fri, 29 Apr 2022 15:26:24 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [trondmy-nfs-2.6:testing 4/10] net/sunrpc/xprtsock.c:1436
 xs_local_state_change() error: uninitialized symbol 'transport'.
Message-ID: <202204291840.vXJc8xQ6-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MRXP264CA0010.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:15::22) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 45926802-32bc-4cac-a08b-08da29db7fa5
X-MS-TrafficTypeDiagnostic: CY4PR10MB1959:EE_
X-Microsoft-Antispam-PRVS: <CY4PR10MB1959B3C2ABAF046D78B35ED08EFC9@CY4PR10MB1959.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sqqOEgx0a0ExTkuOC+jwpgfgaqz1Rch/BQq/D2uoI1n5p8DtE8hACZJQ+m3N2cqBvrkTcT6mimRjctZWfcBe9hanbTl8AuW4OJ0B3SUAq9UgomlkQ2A9JuDJM2LhGw/flIyaaByWPswEKRwRiB3frC8UozvaxvbQNlfHMKrJ0lrx9o7QXXDemKxRwO7LuD/3Ksu3ct0DVgBW6kgcTpDWb8zwXvpZFRFKDIX/9kBWUsaahPQ8QioiPdLd7u3x4Tgxwc0G65FIRBUVB88fVeN+EaICUmYNsG03ZLFx2iBXkuPf087BNZr4GSHzUs+KcMVadL76wyHfUKOzHzMlyRQtkP3dSafm/6UmNnIYYs0vphr++cMwnaNV1/MJpElP7E3FvNhbhIWZMbQ4udGPFNTVfQjv34P5/Wg49Sz6CIcel82WV9wbTIVnS6ONnTIgd0cza/Evbu30RTtF41Cb13O7Ep2lc+0BijhSk/sv/agpeIk1NUa9GkuFszCDxMESmm8tIjlmxZxlEkT4VeGYnTxJwdrt6fqInb024FAjSAEf0fN9332dIfx4h+W1KMGZiD5oIZ9ziMLBBTXkabelB79wqoS0dWrH/uyFx6ApjOpH1ME0SnHfUgajESEQRT7xVAIhLPbr5Y26gDpdeLBkMlfH4xNvukE4eMbRTc/PgjUM8ItM555ccFmFIlpxSMWi54kZ7orsU/XNTzYAo9v0M8MUMFzIgYWaoGjtZ+EkQX3Lunbp7xL7cLop/QLaETeGaQOIegeZyexBJ5gEo+l9FkMPbu1FoUSRMSLtFzlEVNrrp5nu4dsvdooXLpeUURAT7wBBB9qu2m561ev0rNK8//01+Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8676002)(66476007)(66556008)(44832011)(4326008)(8936002)(66946007)(508600001)(83380400001)(6486002)(966005)(6506007)(52116002)(86362001)(2906002)(9686003)(6512007)(5660300002)(26005)(6666004)(186003)(38350700002)(38100700002)(1076003)(6916009)(36756003)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hxVxozlt5zGQ/Vyv5ZHbgwUfJbPtwqgZFrVnnjp+7y1vOSq5HyksTepj1wsd?=
 =?us-ascii?Q?2FU7u7a2pHzLxMH8dSUSCl8to8+2vwwLmYLDet6I4dFP0PNW0qv+eEHM6OJC?=
 =?us-ascii?Q?vHsO7muD562OY3W+HffaR+5ywwCT+kucxyvCCB1ZEoO1s/d8Ry9w1gbGOwur?=
 =?us-ascii?Q?ToTmoy6BK2uwPdKhq+YFUCr78Se8JgyN8wBWlkdeFjA9r3ZQ7F/a6TA+zEzO?=
 =?us-ascii?Q?ftZsoXeAbhd13WNtzPfVkqNfq8xn05i/q+dpaJYXGjvFFvLwO0ZrBoM5w9ou?=
 =?us-ascii?Q?2/Rm3Z4R6t7Q40qLgg4WOb8/0jhLliBY1/Xa276TObT7edvi4RVBUhqXy4vZ?=
 =?us-ascii?Q?yO0n8DDgtnFZHNcxwYvT4ZcGid4veU6fSb5nLusIhIyEJIHhQiStdCB7fSOV?=
 =?us-ascii?Q?cL5qYqcRwnGBNPOZnlCBnklpw/Uvw1d48gsoGB8f5As6uaUSfn9vQ8Cqlc8b?=
 =?us-ascii?Q?Q3IgMdllzwRACYfX2ezS4pgWyTp5Y24hk1s0fYvWVF2EZyYVkxEyhVV0hzRO?=
 =?us-ascii?Q?Ohhl4dwDqAW1IdPjg2c+HEI1qZqF1wBjSxdLv7d4lfVK9RTjNTk9RGG5uYK6?=
 =?us-ascii?Q?3Tqy/B2CUyqG6D9hEBXteauCzdW+zUpht0T6FPqNmTocAuxn2ZbrAGgtEmOv?=
 =?us-ascii?Q?DMTwys5TXXS4dqslpfRm5STtYCgE005lkfz5QYNhs5ZZQAvDEH7140ezr4eQ?=
 =?us-ascii?Q?pd3BuDF2KXh+WYgpD5qihL/zIZzkR+Q6LOjXPw5pcerGn9Trv1AF3eX/N05s?=
 =?us-ascii?Q?g8/ac9z47S1FMTTFq8NVQattiBMlnrmpsI/VP8qp8tCYJwDjTr49IwLZ88Hw?=
 =?us-ascii?Q?iKdRxP3UjK3s/+Kjom53K0QTLhFDCYlQ27mYZWHhde+X6y+WYUdajM3kXNFd?=
 =?us-ascii?Q?019L13StseD5sPEfGEGTvXKLd9M/N04zV866ZLBW0A+L0YvqXAWS+UOTyPAn?=
 =?us-ascii?Q?fWfIdIEVtq1BOhwPTdu9dmw0bKx0smMR9kcMH9VWx9z8ThV1sxRAVt0xpIGm?=
 =?us-ascii?Q?5NCjCJbEEl4X8NiRw+K6GCvUXdckfsvFZldpUlpzOnzYZqfV+qcwur6w1HNx?=
 =?us-ascii?Q?hO+O//i1DWWX/S2vGpKYRJAH8nTmkLMwPqf2MtUkCYd7UbSMl9oy9aE+8M3C?=
 =?us-ascii?Q?qzymuZnPuLxEF/FaMz76zNYkZ0mwoNo5RjwNZ5/vLrvVMmpj8RbVEou0jHol?=
 =?us-ascii?Q?VrXjBu/AzdRcn4dKw2HmUkKsAd7afrjKyXXd25hdyzDZ1rFmrS0FDms42Mcl?=
 =?us-ascii?Q?s56oBi+SCVE/o9QpXZHet2Tsw0MJmq+ZiBFOcFN87B/QOmn2K9Fly//qna4v?=
 =?us-ascii?Q?x5pvbAZOHj5KJwZWvQQNy9GYhOnrxDcGE8X4mj+n4l1PsWDrsf+k46Yltr7v?=
 =?us-ascii?Q?b/viXf6+N/u34ULZQKarWplkoqGnX85cQ4LT//lIuOhw+9L3ZLIN5XCNtx9L?=
 =?us-ascii?Q?UWeNmhTgWBJh7F3ZFZqT394xBinoLM4EI1sEgiluzok+iOKxVX8FYhceOEye?=
 =?us-ascii?Q?r9FvM40X9s4bMQDdRkw16KUCSSAhesxa0Qzy1ACg9aTprksyGKqC3jpLS37i?=
 =?us-ascii?Q?zSE4ArmPyDxQJAcAR7Tml8TBJxFds8GbE2pj/Lclksn1B4EHeGwyASqvfVox?=
 =?us-ascii?Q?HtJAh8SljkXEiGFUGi5xUb24x8c7m2f4WanCloYAukKz/w2SXAw0batFnM3P?=
 =?us-ascii?Q?NFZdxZ7K+lNRgsArwOS7Ky6WC+78tVDLnS0ZO0zx62UR05bkXH4T4Ko/KAQd?=
 =?us-ascii?Q?4Ifr96DogECh5oJZpGjpvvQM+5J1lUw=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45926802-32bc-4cac-a08b-08da29db7fa5
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 12:26:34.7639
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4QHv1SD1SreaoJfRf++ISymoUSgR+wurVQCAihBie8X/h/DBmfaPOKJYRCD/M8UZSCQatIYms/YDN5DFVjp+3YaGPqkvO5i1OA0lC6dHR8U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1959
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-29_04:2022-04-28,2022-04-29 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 mlxscore=0 bulkscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204290071
X-Proofpoint-ORIG-GUID: 47q9z8jGdeQOMLUK8RHy0kGYspc33M3Z
X-Proofpoint-GUID: 47q9z8jGdeQOMLUK8RHy0kGYspc33M3Z
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.linux-nfs.org/projects/trondmy/nfs-2.6.git testing
head:   b44c0c653b27127aba20075ef53b0d641a36a3ae
commit: 8869b563cd42a4cb725604322454ed4fb29a0c18 [4/10] SUNRPC: Ensure timely close of disconnected AF_LOCAL sockets
config: x86_64-randconfig-m001 (https://download.01.org/0day-ci/archive/20220429/202204291840.vXJc8xQ6-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
net/sunrpc/xprtsock.c:1436 xs_local_state_change() error: uninitialized symbol 'transport'.

vim +/transport +1436 net/sunrpc/xprtsock.c

8869b563cd42a4 Trond Myklebust 2022-04-28  1426  static void xs_local_state_change(struct sock *sk)
8869b563cd42a4 Trond Myklebust 2022-04-28  1427  {
8869b563cd42a4 Trond Myklebust 2022-04-28  1428  	struct rpc_xprt *xprt;
8869b563cd42a4 Trond Myklebust 2022-04-28  1429  	struct sock_xprt *transport;
8869b563cd42a4 Trond Myklebust 2022-04-28  1430  
8869b563cd42a4 Trond Myklebust 2022-04-28  1431  	if (!(xprt = xprt_from_sock(sk)))
8869b563cd42a4 Trond Myklebust 2022-04-28  1432  		return;
8869b563cd42a4 Trond Myklebust 2022-04-28  1433  	if (sk->sk_shutdown & SHUTDOWN_MASK) {
8869b563cd42a4 Trond Myklebust 2022-04-28  1434  		clear_bit(XPRT_CONNECTED, &xprt->state);
8869b563cd42a4 Trond Myklebust 2022-04-28  1435  		/* Trigger the socket release */
8869b563cd42a4 Trond Myklebust 2022-04-28 @1436  		xs_run_error_worker(transport, XPRT_SOCK_WAKE_DISCONNECT);
                                                                                    ^^^^^^^^^
Never initialized.

8869b563cd42a4 Trond Myklebust 2022-04-28  1437  	}
8869b563cd42a4 Trond Myklebust 2022-04-28  1438  }

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

