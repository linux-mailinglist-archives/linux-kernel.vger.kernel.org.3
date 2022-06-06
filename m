Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 616CF53E778
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235149AbiFFLQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 07:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235139AbiFFLP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 07:15:58 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D0851036
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 04:15:57 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2569QamD011681;
        Mon, 6 Jun 2022 11:13:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=1hb7qXxwCU5lUzNZFQVOpvn5DkAgVJiJlsiSIF3RUTo=;
 b=p2p6KkzCvzADBK+GzQrBaDBLT1yyvKaVTwthDLztP7ivDW4n0VF+brcCYIFYYmJamtHT
 RmvDzGldg7i44RtOJkHkFa9M400mOABRUtpa+CH85KZhmTSMpCJsBplVKLGIZdtBnOyL
 pnc/o6I84cnQCs365VkbrHTe1Kh+Z4eAVdHTKu+7TT5AHOAXuLQEJwifMw8s+3qqV1kc
 DNmSfORBnRHQLmfUdXTN8nqGG9/927YedprRPnxvHx1mhocoU1gljor1sUV9ahV0mX6e
 MshdQslnmoBvbiJ7+uHGQX2f7YGq7zfJDKjz1IuFQ+9fO9DuFT8/3wqS30R806Ro992t OQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ghahr8qsd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Jun 2022 11:13:55 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 256BAOtn023581;
        Mon, 6 Jun 2022 11:13:54 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gfwu1bf78-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Jun 2022 11:13:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SqFVEE9mwJZC+bdi5etuKbMFOzyUteVRKSuSYoWxNAqFXRH8ebjESrgut9rSJcEWN3Bas3mKxYoQAXIxj9pb5jgY7ek55ukzDfO/gDW9geoLfAYf4Y/59gSSamYhQWc9Jb9sectOI+4d/q1id//x2ZS2aL+jnVYNZsgdQCKCnRgbxEa3DUY4xfGw5uSqmmygdpACgha9mvGKgxXyd68rFWtqe+PBqAe2D1rmTONDmww8EEnjAQe0QbB+26rxH7/iCQI1QlFs8zB7u/FPtZiNZ69KFGCbHl3lNv2WQ/6XFcZz2rMJNfvOLnIYERQgaPF1kP1cZ9hPljiDxjBIT3bEKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1hb7qXxwCU5lUzNZFQVOpvn5DkAgVJiJlsiSIF3RUTo=;
 b=Y6c320Oihqy9O2VBvSfXnLAEWBXc1XzFjooI3b6cLWWVfMU3PfwTS9wuXGewG3Bc3fmW7FW9RVCpOrsnm/7Aa3CH9DQoZEuSOx+t47t0yH8mchG/ueuml/kPyyxgk5I8KVf3BQwkS3EfsVpo0PrD885zo6UaUV05pnGNChgwxK8UsslKVOcw6nnwHNZeKYwM2yOMdEaShwuOXEeFu5C9tA5xXGsCVivhD/8JUQ/y4XNHDOISFRBdJxEM3YhktaXJrt/DRmbF9zTHZum/pu2dJcbUx7Uw0GOI/7IwVurlEznCXsAao3fHC9T40sEM7LIt1yL/vqVtU7NLqd9B0PNhcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1hb7qXxwCU5lUzNZFQVOpvn5DkAgVJiJlsiSIF3RUTo=;
 b=Dgzyje0bK7CuPf4UgI80iXN6nyJGAvO8IsH+h6kVpQISK5ZaZBSDVxFvUCMfkBt2tvXdo4/DbbZNiOuD0JgQWvEnRaBKIoY7FjjARTnxTVCcHWGF+Chbqi1jPRZbaZwrCoEkf0DmRB2kY9asKXfxfJvgLwLGOOBH9usdCmQbJBc=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DS7PR10MB5295.namprd10.prod.outlook.com
 (2603:10b6:5:3a9::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Mon, 6 Jun
 2022 11:13:52 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b%6]) with mapi id 15.20.5314.019; Mon, 6 Jun 2022
 11:13:52 +0000
Date:   Mon, 6 Jun 2022 14:13:32 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: drivers/cpufreq/qcom-cpufreq-hw.c:333 qcom_lmh_dcvs_notify() error:
 uninitialized symbol 'throttled_freq'.
Message-ID: <202206010736.NcY0Y2fK-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0038.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4e::9)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 59b4584c-fc85-42ec-7741-08da47ada36b
X-MS-TrafficTypeDiagnostic: DS7PR10MB5295:EE_
X-Microsoft-Antispam-PRVS: <DS7PR10MB5295659112D656FD5C6005F38EA29@DS7PR10MB5295.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ay5z4kxRdYDc2FhSM2nzLvDK97jprRd59sR5WDk1c8DLXCwHAbtc7t9NWbt7t/d0zIva+he1mXSvtC/berQ+kkyxyY+6N5HjATn3bo/3eoDW7o+/ypKKU5nY7ihVoZpGg5I1DbE0+WutI9ZMfV1hQ5wdYCqb8Lr5NSXBjK4wL9LJ0BKSmqFHcC6chasGVmxUiI4ud2YO1EU7kynJO7tMarWLZU6aBu/qXdHeCDauQiah2EBWNe3hNlpGpOuG+NwAbPMTZQvw9y7Z43W2Elzge9ON8/8z1NxjJlHjck4B6XdXwMVMqn689riaKZ2rsd36lpkAdz6vMONwYEeQ0/f5NJQN/0ZVbrNbtP/QtRAUIs2s+H/ypnD4wUjLbjUhwkRvzIy+G9Ylj7qx51vsmWwKZbBm1fCUpqL8fUiSgL/DmL3mlID4386aEwbsoGE51KrHoTyAKxyGq5kVbesFYT5OWJUqnopayJnDh5IrBMZs7GJfQIB9vwqeYX3MZUdaAIcvt6A7uF87oFiQlvEoCULvxfd+tzC25n/tQf0jvYFyzQhil+K3hayQi5LCwT1BoPvbbWGnIor5G9gbt1iPjncCBv8jB/i2z7l0pk8k9ZWppx+1f1gP5qh+oGMcKL+klwx9Thq/O3i5linSKfDk5sCzavsTleEN65wJbUAsPtOBUuk0vmOwr9Iq+cvcftkVpGZ72HDgHQZjNSqKFw2GhIZLkDx48nXgCvtNOa7YI9emSZ6pNja1vcnkafNllHNaprQGsGSmnBmmRnWODzPySKvvDc6FoRwYd+P2Pq8eKUYHcV6exv/GC4ZEAuzEjADqVv1Q++sr5Zz5FBS1YbpNgUM6xg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(1076003)(4326008)(66476007)(66556008)(66946007)(8676002)(26005)(44832011)(9686003)(52116002)(6506007)(6512007)(38350700002)(38100700002)(508600001)(966005)(6486002)(5660300002)(2906002)(86362001)(8936002)(54906003)(6916009)(316002)(36756003)(186003)(83380400001)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?p5WMXfMT6I7OckQMdVuPpsAOiKqPCNjQ64et+cFpxgXtTHlsG6qW9azqZ8jf?=
 =?us-ascii?Q?5aO2pM0qF38mjqO+ly+6Rj1rfl8jxG1l9zJJV/OUSSKz4kCSgG/QKiGxNwXx?=
 =?us-ascii?Q?7t1AWbDt2fDCjLmw0QrCnVEmn1yF9Dqxuib1sACdUzTfyohNTsyErcpbEwKg?=
 =?us-ascii?Q?c97z+hIzQmmhgrbV8zkmCfrO1YxS78MazVf2X42hIZjR10TH1jnyoCf77EDT?=
 =?us-ascii?Q?I1EBWikhEO9gE/2/n32Zchj70gDrQHFgiVtNdM4G56U8TM3Me6F84DXtpBJH?=
 =?us-ascii?Q?aromQ81SOTmZgKvrXJMPgJTj/s7ALB4eEFpgtcC7PdZXywfo7Yx7Mjfka6VP?=
 =?us-ascii?Q?xIzPEf3/fVecaplBLUexv4nanhg5H/JMKd58eJw7Q4uf3Za90B/E8zYVWiGV?=
 =?us-ascii?Q?ymUSCyRQGFrqwZVEJx68CrrVNhu5UsAbDCdHtSCFXZlwPF4ve6SMkk94UuuC?=
 =?us-ascii?Q?a3y5cYcW22PQng9lchkFpBVui3nVoupXiXPDGUprz4C29U9N1EpyUaBAftDZ?=
 =?us-ascii?Q?NJ0PcMA/KVTBa2hES0gC+YEubH09/NkSlMMuiPgQEzpMBEhiVDnLc3zoq0Ug?=
 =?us-ascii?Q?XGg4clGu3q3tYto+6BQE9Rvs4ZdLS8L1Q4GICvoCrxUAXQn/aWzbt495k80L?=
 =?us-ascii?Q?s+mIRFFdc6traBF9fr0VuPpSgJrcYhM5YiRkpnt8Y+ttFtEfL27+HMpEUVjw?=
 =?us-ascii?Q?zJfEzjLTUG/OjfkwNlh4uBBRScUCqcSIh8WMMMk23xyLt68iGu+6ZzOOVY6c?=
 =?us-ascii?Q?Gp95Zd3BENuT9yPQFOeYYN/2nKLBs4oWVLvlIzyC/EV+HBs0X+USMuajM2iL?=
 =?us-ascii?Q?cIG762rVHimFOQU/29/tSw5Gb0s+y3/sUDWgCN5/ZWd8PPxTo8BXENlYycci?=
 =?us-ascii?Q?2Mt5nsBXByHLlwIOLkCVRF0u1skE/JPRhvkS26UW1pKKrqnQZVQrgoLwAbdN?=
 =?us-ascii?Q?il8BcmctDEhoKYt4fUxMAqLU1ALK4nfc8wChW1Fnkt/iuKzXyt+BKOEymvHQ?=
 =?us-ascii?Q?hHMov8Y0/PhMumIk6VvcsHt70Rxt3KU0vGU1gpNTDLGnXR+uge0XpGReV7WA?=
 =?us-ascii?Q?4h0dpxDA31TWhUj3bTg0VfMurnc4hS6wL0cny71x9dDyR43xrIaP5fzm+TQ2?=
 =?us-ascii?Q?taUDFABZxVoigrEdV0BXb8ovqF6ZNLfLSfu1iqdXAHZgJ33ZkoTeFsIBCiOP?=
 =?us-ascii?Q?rjokqs7ydXbOsEkxWRbkeH/aZ0exlE8EXEKJHrUJLsu7AfqsPgzGXfeD+uKN?=
 =?us-ascii?Q?XRVPjkaleLMkE49P9SU4wiUImp4q7U3yxW3liMhD1gEKRYncZ8Bf8xcBnWUm?=
 =?us-ascii?Q?fm41LZSWtcO2Iv8VHYeimnUgDLEBp3yXZNyfkFY3OHfRD2lfsqj05TOAuinu?=
 =?us-ascii?Q?dF50oOz4PCvQf9nHdKU4JOaOyW3HeIqRun9RTSLwjyeTeJmjUaUtXI63/glv?=
 =?us-ascii?Q?i9TXE+OzlOHY3sOakTDd01zst0I+djNLp8xm/XBt6APMXzcn1ZgukK3hZhlC?=
 =?us-ascii?Q?uTUiTIh2eqOAg0Oeh+zjel+9ArMavjg7M79vEuhHuDGIi/Av9T6vhdVeBrGX?=
 =?us-ascii?Q?wcVSy1NVgg63PjKkE+rcQdXTFn0bj6zau36mF1rl+jtycWfjfK6EW2makMkN?=
 =?us-ascii?Q?DnCq3mCrnt7k7qq2WKHoy3UZuTYFX/hLbnWBWCKGjAuOC728zbozOX8q6bml?=
 =?us-ascii?Q?kklgu3t3I5ACbH/KS1IPJ/trmTkhcxivE4yLqVcHHfW2cHM+/H7H3qVpCG0G?=
 =?us-ascii?Q?60QcXMtr5pTB1ddCKWnciSBFAltXMC8=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59b4584c-fc85-42ec-7741-08da47ada36b
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2022 11:13:52.4552
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qiruElkXbDRF/nX+TaVlAU1ll0Rs2qrHaRm3RkLrEawpbamsSEftLv5AE/CCTsdW2gC0LS7AtgurtQ/mtqV1/2Y3worl6tumV8ieVWzTocc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5295
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-06_03:2022-06-02,2022-06-06 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 spamscore=0
 phishscore=0 mlxscore=0 adultscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206060052
X-Proofpoint-GUID: cqWeu7GR1XJnOHTn6DeR3FCIXty_ARyg
X-Proofpoint-ORIG-GUID: cqWeu7GR1XJnOHTn6DeR3FCIXty_ARyg
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   2a5699b0de4ee623d77f183c8e8e62691bd60a70
commit: 6240aaad75e1a623872a830d13393d7aabf1052c cpufreq: qcom-hw: fix the opp entries refcounting
config: arm64-randconfig-m031-20220531 (https://download.01.org/0day-ci/archive/20220601/202206010736.NcY0Y2fK-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.3.0

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/cpufreq/qcom-cpufreq-hw.c:333 qcom_lmh_dcvs_notify() error: uninitialized symbol 'throttled_freq'.

vim +/throttled_freq +333 drivers/cpufreq/qcom-cpufreq-hw.c

275157b367f479 Thara Gopinath   2021-08-09  290  static void qcom_lmh_dcvs_notify(struct qcom_cpufreq_data *data)
275157b367f479 Thara Gopinath   2021-08-09  291  {
275157b367f479 Thara Gopinath   2021-08-09  292  	struct cpufreq_policy *policy = data->policy;
5e4f009da6be56 Dmitry Baryshkov 2022-03-26  293  	int cpu = cpumask_first(policy->related_cpus);
275157b367f479 Thara Gopinath   2021-08-09  294  	struct device *dev = get_cpu_device(cpu);
0258cb19c77deb Lukasz Luba      2021-11-09  295  	unsigned long freq_hz, throttled_freq;
275157b367f479 Thara Gopinath   2021-08-09  296  	struct dev_pm_opp *opp;
275157b367f479 Thara Gopinath   2021-08-09  297  	unsigned int freq;
275157b367f479 Thara Gopinath   2021-08-09  298  
275157b367f479 Thara Gopinath   2021-08-09  299  	/*
275157b367f479 Thara Gopinath   2021-08-09  300  	 * Get the h/w throttled frequency, normalize it using the
275157b367f479 Thara Gopinath   2021-08-09  301  	 * registered opp table and use it to calculate thermal pressure.
275157b367f479 Thara Gopinath   2021-08-09  302  	 */
275157b367f479 Thara Gopinath   2021-08-09  303  	freq = qcom_lmh_get_throttle_freq(data);
275157b367f479 Thara Gopinath   2021-08-09  304  	freq_hz = freq * HZ_PER_KHZ;
275157b367f479 Thara Gopinath   2021-08-09  305  
275157b367f479 Thara Gopinath   2021-08-09  306  	opp = dev_pm_opp_find_freq_floor(dev, &freq_hz);
275157b367f479 Thara Gopinath   2021-08-09  307  	if (IS_ERR(opp) && PTR_ERR(opp) == -ERANGE)
6240aaad75e1a6 Dmitry Baryshkov 2022-03-26  308  		opp = dev_pm_opp_find_freq_ceil(dev, &freq_hz);
275157b367f479 Thara Gopinath   2021-08-09  309  
6240aaad75e1a6 Dmitry Baryshkov 2022-03-26  310  	if (IS_ERR(opp)) {
6240aaad75e1a6 Dmitry Baryshkov 2022-03-26  311  		dev_warn(dev, "Can't find the OPP for throttling: %pe!\n", opp);

throttled_freq not initialized on this path

6240aaad75e1a6 Dmitry Baryshkov 2022-03-26  312  	} else {
275157b367f479 Thara Gopinath   2021-08-09  313  		throttled_freq = freq_hz / HZ_PER_KHZ;
275157b367f479 Thara Gopinath   2021-08-09  314  
0258cb19c77deb Lukasz Luba      2021-11-09  315  		/* Update thermal pressure (the boost frequencies are accepted) */
0258cb19c77deb Lukasz Luba      2021-11-09  316  		arch_update_thermal_pressure(policy->related_cpus, throttled_freq);
275157b367f479 Thara Gopinath   2021-08-09  317  
6240aaad75e1a6 Dmitry Baryshkov 2022-03-26  318  		dev_pm_opp_put(opp);
6240aaad75e1a6 Dmitry Baryshkov 2022-03-26  319  	}
6240aaad75e1a6 Dmitry Baryshkov 2022-03-26  320  
275157b367f479 Thara Gopinath   2021-08-09  321  	/*
275157b367f479 Thara Gopinath   2021-08-09  322  	 * In the unlikely case policy is unregistered do not enable
275157b367f479 Thara Gopinath   2021-08-09  323  	 * polling or h/w interrupt
275157b367f479 Thara Gopinath   2021-08-09  324  	 */
275157b367f479 Thara Gopinath   2021-08-09  325  	mutex_lock(&data->throttle_lock);
275157b367f479 Thara Gopinath   2021-08-09  326  	if (data->cancel_throttle)
275157b367f479 Thara Gopinath   2021-08-09  327  		goto out;
275157b367f479 Thara Gopinath   2021-08-09  328  
275157b367f479 Thara Gopinath   2021-08-09  329  	/*
275157b367f479 Thara Gopinath   2021-08-09  330  	 * If h/w throttled frequency is higher than what cpufreq has requested
275157b367f479 Thara Gopinath   2021-08-09  331  	 * for, then stop polling and switch back to interrupt mechanism.
275157b367f479 Thara Gopinath   2021-08-09  332  	 */
275157b367f479 Thara Gopinath   2021-08-09 @333  	if (throttled_freq >= qcom_cpufreq_hw_get(cpu))
                                                            ^^^^^^^^^^^^^^

275157b367f479 Thara Gopinath   2021-08-09  334  		enable_irq(data->throttle_irq);
275157b367f479 Thara Gopinath   2021-08-09  335  	else
275157b367f479 Thara Gopinath   2021-08-09  336  		mod_delayed_work(system_highpri_wq, &data->throttle_work,
275157b367f479 Thara Gopinath   2021-08-09  337  				 msecs_to_jiffies(10));
275157b367f479 Thara Gopinath   2021-08-09  338  
275157b367f479 Thara Gopinath   2021-08-09  339  out:
275157b367f479 Thara Gopinath   2021-08-09  340  	mutex_unlock(&data->throttle_lock);
275157b367f479 Thara Gopinath   2021-08-09  341  }

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

