Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBFD456058B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 18:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233951AbiF2QNk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 12:13:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232753AbiF2QNh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 12:13:37 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2799DF587
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 09:13:37 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25TFE9sB029496;
        Wed, 29 Jun 2022 16:13:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=6MFsu4ydZJr4aO65yBwOQMeLKqiH1pJU+jOuv9mkEyQ=;
 b=BF+ZqX8UjWqOr16DsZ1aHFPHVRjlSMOKMcxiuS/ZwUmrjJsnSK0At0h1ei4IyOMvV11s
 yBeIEJFc+vyV8lhn/Nf/ATTWmu/NKF2+CJhtOAd2CXa7HiI4/0ZU39HxCYk88ihzj3bo
 +ANOIsZBbpd9oCnkTc/MHu8xGOEVNL99W526eeAfp1QKNwfIUL9OT2O6ENMSFSM8snn2
 Rr45iPCY6DKgHjuQxA9aFUmvde+aUV6754cWqRCGJ2T49+71KTV2vharMUciqnZNLe4F
 NGByHq4rouLJEGH5yXt+6iv1Znv3oSNS/kvBvhb5Ujr47N1QP9Xy3pdT9ZE/RE/oz38f cQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gwrschm0t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Jun 2022 16:13:24 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25TG6xTi039190;
        Wed, 29 Jun 2022 16:13:23 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gwrt3npgx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Jun 2022 16:13:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lpbn4ecuC8xJ2TiTHc2VTWFZqBziha4eAJ6UXGgudFoqB6yE1YofcyUIQi6DFCYddHiMUgt9DT1QMw5jW1TcC0AN9DcqfAGCqp9JCCrZ8Nk3sdkU6MhV3BG6NXufBdffIxi1KdvVFLZAnm/Svvqe1DPS7zFoiXbtpDsYxgUfPo6BFtTKa4QDxKCrOIH6oQHggvSJkIvK66/JNi2CUPAoAXo3QxTrJ1t9Mng/z5fsZ5MBMBwxFK1r5+e5R/LI6pb1UlHLoz5cm8w2we+sHrYgeClb+rh7mqhX6kNjMf7ICSO60bUmqSmpPpeWz1HFGCrqX/SjcxZlMw1jYIiaQLXteQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6MFsu4ydZJr4aO65yBwOQMeLKqiH1pJU+jOuv9mkEyQ=;
 b=QAEJVrNchW6RTuTfHl0W9/Ih/oTvrhtg16XXQhV4TXbTYpwhMVO80L/1KCHmYWFWG3/w2guKjHeQBlsMDr51oH03A0WAt6/cfUXbZ3ImVJvyTF4TAWKrmxbJXqNXhzZNXM1/lMmo8q0FLtEbhlmRUFYl4xb8G6q8MeQSYmQvaeE77Fsfv2Tyh4WpiMdLOaacE1FgPyFvFyEEYdVA+sokCRLhD996zIDnTOok372Dq23Y8dSPel/lI+9AXZ/pjtLDls4n6tM3Ih3s2ZiBxACoMxNR/5XIXuJIqvF26vfuVnx21BozS3me3BLqAWn2FqFt7QSA455pIRrcZ1FmravJqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6MFsu4ydZJr4aO65yBwOQMeLKqiH1pJU+jOuv9mkEyQ=;
 b=QPsK5OhkH7Ope3T6BmCkVU4F9kO5uk0RFHZDBIzJnyYrwFBc1WClOL6vfgz6M+cm/nQBFdGz0qwe8VTRnjzrJDr1HRMTn/9P1l5/TCWNwUrkkcoECkUoZRz1/5w1URYk43gVhLyO62VycXRVC68YL+zzUR1kIfV3wt0wo79jpS0=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1342.namprd10.prod.outlook.com
 (2603:10b6:300:1f::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.17; Wed, 29 Jun
 2022 16:13:21 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b%6]) with mapi id 15.20.5395.014; Wed, 29 Jun 2022
 16:13:21 +0000
Date:   Wed, 29 Jun 2022 19:13:06 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Felix Schlepper <f3sch.git@outlook.com>
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, wjsota@gmail.com
Subject: Re: [PATCH 3/7] Staging: rtl8192e: Avoid multiple assignments
Message-ID: <20220629071241.GW16517@kadam>
References: <cover.1656402464.git.f3sch.git@outlook.com>
 <046bce9ab52db0c5a37430fbb138870c05a48f61.1656402464.git.f3sch.git@outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <046bce9ab52db0c5a37430fbb138870c05a48f61.1656402464.git.f3sch.git@outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: CTXP275CA0002.ZAFP275.PROD.OUTLOOK.COM (2603:1086:100::14)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 19c128f4-c858-4359-41d0-08da59ea48ed
X-MS-TrafficTypeDiagnostic: MWHPR10MB1342:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HcM4XLiqQbXTxV2NNF31tRRzwqb5E+D4jBUogHjXcqfv7gbjvBXnCILbuJCGWDVvb47sXlclwjbgiHp35056HtI2bjC0FhY5mHcMg0AKKk7MjJlnrN6nlmky/H9f5oROSH0n2KEMJdLswT3G1nY5nKtQE0ZG/VotilxL/Ca3xXvQpAv/Bkfw02dRA4vz2fFqIQYStuL2AwkSCdxx2X/P5J+JKM7KJl4HVZGBdqfCHEmosA+JaY5V8Vn8FPcvhmw0gBnifuRNWti9VkJvg6ZCXxcSUjkuTXRRbFtM+ENf3KU3rHjL28kXMR3C5f8Wdc1GhAYCMyg3Gu/ivX49V2hGfUaEVwhM1rSlv3SWyMx8GDH77uepnhE2Ds89YNWufyBLvzslPmk2aJ3uvYRlmH61GKsTXMA6tWt56p3BoU5aq5B/9kndGHIL5/flCaspGjtsXJlM2V7X6njIWV4fdbck7jWedyfgM17yNvCG/+VG6giOXx/A0KSYSLd0iA3PUYX+CUZgnNYLN3TpSUnd8wKL0MlavLMRrmiTk8aLYwxM5KEqafmsj77AFWKGxD10P0RcUFytR6IarY2KDkDSvt/+PuhbqbjNnQNqnUmczpE8tg9KfITpIy+0QkuDn2mGr6F864xp7EqGjM0y8KXFedSmudM5PV2bIv9Yxxy33MS1ohi0J9pfGNnCZwqNS4T8nvi6tpXwhD61GKvdeHR7Ou5wt35SxByMj+XYy/BlTu/CTs3LL9YHi75zVoG991QmyUqyhp3LUfFq90te5E/0VB1Rc5jncHbhFUewL/s0y5Az/lAtoXccnqyLyOcA9mb7BBhN51GlEuP+wkzS8JJNenUAkw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(136003)(39860400002)(346002)(366004)(376002)(396003)(8936002)(2906002)(44832011)(45080400002)(6916009)(52116002)(1076003)(33716001)(6486002)(478600001)(38100700002)(83380400001)(38350700002)(66476007)(5660300002)(6506007)(4326008)(8676002)(41300700001)(316002)(6512007)(66946007)(6666004)(86362001)(66556008)(9686003)(186003)(26005)(33656002)(5716014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MP514HCnLGAC5BlduWebF3sEbCF/qpGIN9fW/sVGstaH5BOfJ+Cwnm8zWBq8?=
 =?us-ascii?Q?1JyGoohMPkrcIXhUQWnoD7rLdpJa/4PCT8Qwa2tvFSG8fb91CwTYBsgT2e4u?=
 =?us-ascii?Q?DL2Jjg+uhp0mpUOqpmj9ZKc5MwVx0voYtYE2GBzz7vXESYnR3XVhYwEeWlHe?=
 =?us-ascii?Q?Y8d17XxtITOqdtsGeKQOzkFAczo7oBZxKn4AQONL2YbfUFWEiszU0omPIpAj?=
 =?us-ascii?Q?zp1byf3z4HUKDRLXg6TVDGZGZnMksqVIpNp5pN+JhOaWIl6XYTromAbMoTL8?=
 =?us-ascii?Q?TPmmg9tALXsdW8U3ZlccHzi2kuR2BI4K75h4nSJRtvw4Wd/VT4YYpUipn3MZ?=
 =?us-ascii?Q?iW6CthIw+MnlLIK6rqs0/p9dB0hc6C6NErX27s5J9vjpfN/TfkxjZweDZtDm?=
 =?us-ascii?Q?BTCZUgdoHCdaw1WQHGCDwr8DErOYxYWbn+zQZ0JXFFXBUd6BnXfnWSLxURHk?=
 =?us-ascii?Q?xWh22B4Mmz63Qu7awrFBEC1x5rdoX2bFQ1w6aZbR0yL0rhxiGq6XUDRlo8wB?=
 =?us-ascii?Q?SGLUntfRoK2S4yY7ngOpnLOnfOD3ITZUiuJ+g2rik4qWshPuz75gjZm7njGF?=
 =?us-ascii?Q?iGcfCmK77JER6vgK1kWRlVsq3uAvRRP5bobpYOZe0maF8/pfyJhWJtT7rX8h?=
 =?us-ascii?Q?5B4ujScCkN/n+mRpTOMG3JgYNsezZyRn01QYmTk7F8bV6s5t0wYYtWYFqehr?=
 =?us-ascii?Q?A8GBOarjVjMI9sxFJ59/vpC4Pd/L+cL6w+N5X89HKC+j8MHktut+T8j6Jzvq?=
 =?us-ascii?Q?m9gd68Y1M7kaIQ8W8VO+7RByDlLl/lVr0vIw9wUZ7wcF7zn+umYbi1stCyyG?=
 =?us-ascii?Q?CDBUTlN8xj6KU1V80/FJdn34EOFqMMzlFKrJpTjkcdXOriKHWmQhWVKIElJ4?=
 =?us-ascii?Q?7EpOPxepY5DQJs+BGR79B5IVDcYz2iXto+NrjTrjSYFjIqq4J0ZCZzvndN3P?=
 =?us-ascii?Q?wmMchRwzu1oopogydGayOfsP4HuUpRr31zIjppus4FhO0Ryqir5md/zaMw9f?=
 =?us-ascii?Q?piu8OzeJhgtWrJOvNPX1dEglQht7s595tOQdwqjXZQwF6YdC6KgYWm+IMHpJ?=
 =?us-ascii?Q?4MMdUStSkwmbj+XS8fp6oOWbKSBBwgUhzgpMDaR0krvkgdYKK/MpdKwza4aF?=
 =?us-ascii?Q?CpCMzdMjl0YBTvh43jPLwOlSX6P15+lWHyZlekbpN1PZF5WfdoNaAu+dRCAO?=
 =?us-ascii?Q?DJQbxJure5nflskRqoqJCsI9vqaHNW6NMdM2nUiuxXDEC2aGIEHFzG01mOm8?=
 =?us-ascii?Q?6cNB02m2SGzhmTy6wv1fJRecFN+Fxhj6R4Mkvldr7WArC9Z3ZOrdEaJV8HyP?=
 =?us-ascii?Q?O9Ol795GzNyfmdRbU7Y9HYWXjufcm3U18TcQmS1fAsIArSKMgfk3KuTCTfVt?=
 =?us-ascii?Q?o47RaQ+N1S/5fBM++GGKpFk8gNxw66RYY1tu95IrRDyE8GvlA/7QzQrax7NU?=
 =?us-ascii?Q?VURTFb/XmWnax9xd85HXcuUEFsxpdxbspUjnmKoh0owTUzsOnMQFlDAYKL1T?=
 =?us-ascii?Q?NSX6o60yaH+sWf2H2VBrMqjCrj0OKgAKr0WqdutZrkr/vgYkWfRiThpkIe1M?=
 =?us-ascii?Q?6Qb13AUVr1kV7shEQaYZ+C84vdG+xJAPNoRTlmmH6VJNNt6LGoAhD73y9L+k?=
 =?us-ascii?Q?zA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19c128f4-c858-4359-41d0-08da59ea48ed
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2022 16:13:21.2698
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BaHWBbnhDJcZp/eTL6UxS+Cd7qgTJN1MCBITnhi1ZQqIGEaZygmg6wfEB7tn8lSfM+CuFOSgS17urVy5r1dS1FFmQz2ajwvv6vfdj8Hjaqw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1342
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-29_17:2022-06-28,2022-06-29 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=955 suspectscore=0
 phishscore=0 adultscore=0 malwarescore=0 bulkscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206290058
X-Proofpoint-ORIG-GUID: QOIpCblMvgGQBfx927nB61z7ZNr3uc-V
X-Proofpoint-GUID: QOIpCblMvgGQBfx927nB61z7ZNr3uc-V
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2022 at 10:30:52AM +0200, Felix Schlepper wrote:
> This addresses an issue raised by checkpatch.pl:
> 
>      $ ./scripts/checkpatch.pl --terse -f drivers/staging/rtl8192e/rtllib_wx.c
>      CHECK: multiple assignments should be avoided
> 
> This patch does not change the logical of the assignments.
> 
> Signed-off-by: Felix Schlepper <f3sch.git@outlook.com>
> ---
>  drivers/staging/rtl8192e/rtllib_wx.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/rtl8192e/rtllib_wx.c b/drivers/staging/rtl8192e/rtllib_wx.c
> index 7bd1e829ff7e..c8fc66113b41 100644
> --- a/drivers/staging/rtl8192e/rtllib_wx.c
> +++ b/drivers/staging/rtl8192e/rtllib_wx.c
> @@ -160,7 +160,8 @@ static inline char *rtl819x_translate_scan(struct rtllib_device *ieee,
>  			max_rate = rate;
>  	}
>  	iwe.cmd = SIOCGIWRATE;
> -	iwe.u.bitrate.fixed = iwe.u.bitrate.disabled = 0;
> +	iwe.u.bitrate.disabled = 0;
> +	iwe.u.bitrate.fixed = iwe.u.bitrate.disabled;
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
This assignment makes no sense.  Why are we setting fixed = disabled?
If you're going to split it apart do:

	iwe.u.bitrate.disabled = 0;
	iwe.u.bitrate.fixed = 0;

regards,
dan carpenter
