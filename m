Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CD8053108B
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 15:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234782AbiEWL34 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 07:29:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234892AbiEWL2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 07:28:50 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC05A49CBF
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 04:28:49 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24NA0Xgq030965;
        Mon, 23 May 2022 11:28:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : in-reply-to : mime-version;
 s=corp-2021-07-09; bh=34CUxrdV5RWhLWNi1cyypnddgMPPOsrnof6BSx9aXNo=;
 b=z1LBuoIJdin5BSq1wf98dM0pRD8yt4KkKhZASlot89oImQGYFkHDoeXAeTXguoxl+Bn2
 fS74VE9/Hvs8wPnO9W8S/Sob+QKF0qhtK1IW8sGgwaeIDeuXznG9Icy+FjB5T6jlSnEQ
 9fp854Qa+lR04O7xmKiFuT4LPkjgKJju661w60GsjIEb0CbZcKaRopyNTkbS/AOLIUoA
 LcZpaKsMASjKdX/6sHFGjB7TPnjkpY32IsuLXFQGu6qzlI1bPfobMes/LE7kqSWhXYVC
 /ezbAudhTXYAwtNWa02amTVgM7LxIqsEcHBSG0KYhVZuRfI7iXmXn5/Rq1FJLoJOyP0V /g== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g6rmtu0dr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 May 2022 11:28:15 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24NB9xq0016155;
        Mon, 23 May 2022 11:28:15 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3g6ph18ddt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 May 2022 11:28:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iBw1eiAH5OJpwX/pTYwTcpDjhK4UFJ94O7FmS4Xi8H9c1Xu+gnVJ3VGV5tH4YxkKc2JF4PvIP6Nw/H1ozksHWjh6UtCofSrtZb1XeHZ34E6WUmR2RkrO2X/xDMDL7H/cKz4PQDND2dkouR20rrogbPHn+YCK42y47IQGHui3mU/VKi7NpJifODRXqD1gaRO4gMVXjM1U8PBMLoaFAplp+7aInIqLUuzbgQD7p/3QQT5dysoNlneWwEkO01buF/rNauYxLiW9J/HclmvOgKqETf7cYG0RNnZ+O/53niGs9Ore/k0Va0DFYoF5x3sDNI8HoiIO/wxf2fOFtVOl7Ztm+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=34CUxrdV5RWhLWNi1cyypnddgMPPOsrnof6BSx9aXNo=;
 b=NCJhdtm5qRHY4A72ARmA4kGSSYC1Vsq5OpUCmJq1cd058ZDnKyST+IPmj/Ptf44qamhHtCjydVYPzZ8n0GeIPPRIc3Dsi/4D+ERGkxnaH8V2vRmAN2tEziJRphR1tKtnCzVnpUJnGF0svv8QIZyfYpuFFSuBi+Gq5VnKoP1AemPpJcRGrlpoB1jZ2VqNqNBYfy227Z0nIZay3mHT6k/5sw7TP8DwtG5E4q9j+2f+eLS5G1hCjrySayZuZwDg6Yw/+1bgX9S9VQjJxXEJOpVJJI3f6cNWIfBYr7FaCR3lGkRcRhkTHsX4MecaCxUyfOLzwCoET39NJkYgat2WlirjHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=34CUxrdV5RWhLWNi1cyypnddgMPPOsrnof6BSx9aXNo=;
 b=cDXfERngMszXh10kaVwjqMQe5+/UOpV5aOmzfoReQWmkcBsvM/VUH+jSYfLz017BnlbP4mC3X/Sp7ZD5uHoOs+XAjWklqGIi38T7X0zij/EY/rCCwQh5hgq+t+YwIt7pMledhE72Pq/gzjEteVg49CXei/dUnSjZg/1KvGaF24Q=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BN7PR10MB2434.namprd10.prod.outlook.com
 (2603:10b6:406:c8::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.16; Mon, 23 May
 2022 11:28:12 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::86f:81ba:9951:5a7e]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::86f:81ba:9951:5a7e%2]) with mapi id 15.20.5273.023; Mon, 23 May 2022
 11:28:12 +0000
Date:   Mon, 23 May 2022 14:27:48 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Josh Don <joshdon@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Tejun Heo <tj@kernel.org>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org,
        Cruz Zhao <CruzZhao@linux.alibaba.com>,
        Josh Don <joshdon@google.com>
Subject: Re: [PATCH v2] sched/core: add forced idle accounting for cgroups
Message-ID: <202205211525.XlF6P8dM-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220520235138.3140590-1-joshdon@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0043.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4e::19)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6443bb33-3c02-47f3-b76a-08da3caf51ef
X-MS-TrafficTypeDiagnostic: BN7PR10MB2434:EE_
X-Microsoft-Antispam-PRVS: <BN7PR10MB2434C45542E6551A92BA568D8ED49@BN7PR10MB2434.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RDxEkELOQ9I8aJs6dGho8dsKTUu+11gbdBObaqRG/h6EdGLweua6hBzCNqz0a8R4ZxBrXVSQVurGHVk/yIBBmFjdBYNNmDfSz3zKdoiYP85bQQAvpKNXdMWq8QgFo0wn5oh0LxjasxpEGChnmapU3dd80AQkdj6Q92vt6Z8LfqGjYubPmJv4KVm3ecvQ9SJTfPQlvcGe0fYZAI9qhfumINDWkWpk6fycBs0IvFC9Z8lYF/R69fw7aCeQyb8M8zM8O1kxLF75bsINmxyVHvmorFMsW4VIqHxU4MQHFKUgzYDb8l7LN+z3n55msqfDaknssCGu1pVg4H1v4ys880uL0k6TJl+maFzqqfE3ZbtnkYT0loBFjtMUYXdr499wiWACjbwdNCBMIoOhnOWO39dYNxg1MqSkw0iBxUuCP1wzWqk4aw5thuN+aPMxRduyO8sK9y0v+06XVHtQ3veuk59WcgerCqqGCc/uKKHda6Zk6qJumSgqsgYCz/84La/2kO7EV2YNz74TIruye7aTvzL79h/owgrP6QkCqkCT9h7HdW7hkT8AXr7Ed/QocfXU7y9vkizIPt4y8u8ddHcUoRR5QgXR3+ZnIMPdJ0FICUTJo1OLvjjmWY52KEx4U1afgna+y4ti3uizGxdqYl7djt42rIvKaz6b/pyKuyTYSNHFfyG3uKLODu+JXrdyNxaP2mad8hggIFF6s8V6jLkLWjRtuVUg/6Ny+FU2Ax1FraG61QL3SujDlgjUcuaXxgPfOzTRr56r/VnBP46FXclXFwJxvNsKPWkmITHI6KOCdeD8lj5zZeWoL6Ucr4PbMENgVriXbbAlJunO2mtxRCXHrwxWKA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(110136005)(54906003)(4326008)(66476007)(8676002)(86362001)(66946007)(66556008)(6666004)(38350700002)(38100700002)(52116002)(6506007)(6512007)(508600001)(36756003)(966005)(9686003)(6486002)(4001150100001)(2906002)(15650500001)(26005)(186003)(44832011)(83380400001)(8936002)(5660300002)(7416002)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DSu8JcXn9cl8vcI18h/KZoaYgcC88MFXkB+F0VNluOgFbLqdwD6iPoUQcHx5?=
 =?us-ascii?Q?vVKokOqF99RPRS7kDwnUGHUjFr5p6BdwHul71oR5+28Lf0o3qISNkfc8FKlC?=
 =?us-ascii?Q?ghy6kQmTQLZ87QWqVgFUsBn4JLLy+fVWhWJJvxJpCQZuZ5n+I6uAXjWxibpn?=
 =?us-ascii?Q?drnYPRd/g1IlTWOVHZ1emssbFBPvKHMMcysSHdBYOJ8Fbm3CWYs+6OSjWnCm?=
 =?us-ascii?Q?fUaJqJynvZkDsjRdV5s3ZLnWcAIIHQIdzuo1IWpoCc9YXmnGlA56MpRdLDBf?=
 =?us-ascii?Q?FjLJI10VUinKwy4v4K4FbufS+FMiXxmWmVzFz58QZTqpwpYU0txuCXKTGEeF?=
 =?us-ascii?Q?luLJWib9NYINp7fz78KSY0A49RIdIU11Px+hThluUz92ipaR1wiBV2DP7eMC?=
 =?us-ascii?Q?6T0MXbnbX5sRj8gTiS4sPGHBpY6w0A7lBZsdQtadlWXFa4U8sxbLx44jX2n+?=
 =?us-ascii?Q?im6BWH+ZRoQ/XF3rO580OvFLqy+oTSWV2nGidBs0pJW2zsoQ2VOR1kRI7aMF?=
 =?us-ascii?Q?AYU9wpEJVLPZNQ4OXtzqnVRlYsxJPF6vVPNLLYOsQ817wvyDhaoZBu/tpF80?=
 =?us-ascii?Q?F8vcGaQoJNPqCXxdXTGXFkb1GP6xS7Oo2Z2zwkHlyUy9atMlzNv3wvwO5Afk?=
 =?us-ascii?Q?rVgkltasHSqRujfM1uWyarT1S/EHyyFMtz//ZG+4O1GNi5UmNs83pgQg4CLx?=
 =?us-ascii?Q?ebblteXFrIPM/6e//73Z17RGI1sdRxz22fL90+gSUxsnFGAFqh+I39JTSE66?=
 =?us-ascii?Q?psGPHNPENztYAWRKQkugJVb5bt456YWmm5sa6h9dOTAyhlIO08C/4YewRwiN?=
 =?us-ascii?Q?EQX5b/LIUEAXLUKmsDpCtAUWzsoT5mMO2ddEzrBpWd8rDCzb6OpF3jEXiRRa?=
 =?us-ascii?Q?A404ft7QJZTzxsV0f8LMAMdLoIxyR9UG+zbbe8Q6hqyGNkrUOmCUqlQX+C/J?=
 =?us-ascii?Q?rUe8/WlXBKGbhf7bclhsu/I3twXhiAvkIfwRtoyjZ63DNQSjpCrSZ4pttYX8?=
 =?us-ascii?Q?aafCvm1PgoztDzpUY0wKdJlI1uDVHouPLTG1gmTxO63+3JSnc+7P0jy7Vo1k?=
 =?us-ascii?Q?8DenLEWEGlD/BdmIjwqaYcwGSgPQDpP1qmSxzbbfjOLNxQl/Ylj1xb5Rr2Lc?=
 =?us-ascii?Q?6J+3cknKcI62/fX1nKvSx7IlV90s23j95xUDReXD+Aog8jOGTNFCOojtTdcX?=
 =?us-ascii?Q?vfHTpiJtUHOjC9zC3MjGtQKbux87n/I81yEokFS7+J0yn9Ps+lR3yDGFCGwV?=
 =?us-ascii?Q?ZngIIx0gYOXHXZa+my1IJ0DhLyArweEJmcg9xMUN73cmtLL+XncpKY6P3Grd?=
 =?us-ascii?Q?tRZREN209nopSDO5kRGsR8xWR6d9IxwOmbqaRS3FP5/M0bG+BRrTXHARNhC6?=
 =?us-ascii?Q?22cO8h5R0leUe3EnEMQZ9716kGrWNfkHFU1g/arRtpp56lmkR9E2oAfpJX3d?=
 =?us-ascii?Q?LS5t8dS7/NgQcxxs9/QglXH+HXkHRhiJqPuZ10Cy+8bCT00Fd00gANeQNor4?=
 =?us-ascii?Q?SjcxDdIDirevtl4R6GsULQbVl39XFukKKCsnJXs2GEW3TWZ/9Ys5kUY0AfFf?=
 =?us-ascii?Q?tly1CszwBGecZlNXcHvpQArcctjK9H81ZoY2q9n5GYKT6JfqxQ2rYJVAGTEB?=
 =?us-ascii?Q?0G0UsE2Rh961OjrIcyRTUKmR7xFpcjV72WEVrMTYdNTl/XmiLvt2czOD8Wfe?=
 =?us-ascii?Q?JKL7mtcChdrY3NmhBZ5ZGruWU45MvWBEAoUz0o3FgLwbrKHUFvKfQKqEMtwX?=
 =?us-ascii?Q?MbdwFKH/qjlKfWBT6uoNJ4RC9eF8eJ8=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6443bb33-3c02-47f3-b76a-08da3caf51ef
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2022 11:28:12.0141
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lSxmjpylgOKJpTn7LGIPj7Kc/qBA7Yb6eU2TmQzgk3FpSEqwokA2mn6XlZs+TH0rP1A5L+tDaSDWiMgly0TqrdZK9WuNPQm+RoROqm6yUgY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR10MB2434
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.874
 definitions=2022-05-23_04:2022-05-23,2022-05-23 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 mlxscore=0 mlxlogscore=999 suspectscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205230062
X-Proofpoint-GUID: Jvmae3U4vlC1qtdq_HAdLM9LxY6s8lOt
X-Proofpoint-ORIG-GUID: Jvmae3U4vlC1qtdq_HAdLM9LxY6s8lOt
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FAKE_REPLY_C,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Josh,

url:    https://github.com/intel-lab-lkp/linux/commits/Josh-Don/sched-core-add-forced-idle-accounting-for-cgroups/20220521-075311
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-next
config: x86_64-randconfig-m001 (https://download.01.org/0day-ci/archive/20220521/202205211525.XlF6P8dM-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-1) 11.3.0

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
kernel/cgroup/rstat.c:489 cgroup_base_stat_cputime_show() error: uninitialized symbol 'forceidle_time'.

vim +/forceidle_time +489 kernel/cgroup/rstat.c

d4ff749b5e0f1e kernel/cgroup/rstat.c Tejun Heo    2018-04-26  460  void cgroup_base_stat_cputime_show(struct seq_file *seq)
041cd640b2f3c5 kernel/cgroup/stat.c  Tejun Heo    2017-09-25  461  {
041cd640b2f3c5 kernel/cgroup/stat.c  Tejun Heo    2017-09-25  462  	struct cgroup *cgrp = seq_css(seq)->cgroup;
041cd640b2f3c5 kernel/cgroup/stat.c  Tejun Heo    2017-09-25  463  	u64 usage, utime, stime;
0575a42c9f10cd kernel/cgroup/rstat.c Josh Don     2022-05-20  464  	struct cgroup_base_stat bstat;
0575a42c9f10cd kernel/cgroup/rstat.c Josh Don     2022-05-20  465  	u64 __maybe_unused forceidle_time;
041cd640b2f3c5 kernel/cgroup/stat.c  Tejun Heo    2017-09-25  466  
936f2a70f2077f kernel/cgroup/rstat.c Boris Burkov 2020-05-27  467  	if (cgroup_parent(cgrp)) {
6162cef0f741c7 kernel/cgroup/rstat.c Tejun Heo    2018-04-26  468  		cgroup_rstat_flush_hold(cgrp);
d4ff749b5e0f1e kernel/cgroup/rstat.c Tejun Heo    2018-04-26  469  		usage = cgrp->bstat.cputime.sum_exec_runtime;
936f2a70f2077f kernel/cgroup/rstat.c Boris Burkov 2020-05-27  470  		cputime_adjust(&cgrp->bstat.cputime, &cgrp->prev_cputime,
936f2a70f2077f kernel/cgroup/rstat.c Boris Burkov 2020-05-27  471  			       &utime, &stime);
0575a42c9f10cd kernel/cgroup/rstat.c Josh Don     2022-05-20  472  #ifdef CONFIG_SCHED_CORE
0575a42c9f10cd kernel/cgroup/rstat.c Josh Don     2022-05-20  473  		forceidle_time = cgrp->bstat.forceidle_sum;
0575a42c9f10cd kernel/cgroup/rstat.c Josh Don     2022-05-20  474  #endif
6162cef0f741c7 kernel/cgroup/rstat.c Tejun Heo    2018-04-26  475  		cgroup_rstat_flush_release();
936f2a70f2077f kernel/cgroup/rstat.c Boris Burkov 2020-05-27  476  	} else {
0575a42c9f10cd kernel/cgroup/rstat.c Josh Don     2022-05-20  477  		root_cgroup_cputime(&bstat);
0575a42c9f10cd kernel/cgroup/rstat.c Josh Don     2022-05-20  478  		usage = bstat.cputime.sum_exec_runtime;
0575a42c9f10cd kernel/cgroup/rstat.c Josh Don     2022-05-20  479  		utime = bstat.cputime.utime;
0575a42c9f10cd kernel/cgroup/rstat.c Josh Don     2022-05-20  480  		stime = bstat.cputime.stime;
0575a42c9f10cd kernel/cgroup/rstat.c Josh Don     2022-05-20  481  #ifdef CONFIG_SCHED_CORE
0575a42c9f10cd kernel/cgroup/rstat.c Josh Don     2022-05-20  482  		forceidle_time = bstat.forceidle_sum;
0575a42c9f10cd kernel/cgroup/rstat.c Josh Don     2022-05-20  483  #endif
936f2a70f2077f kernel/cgroup/rstat.c Boris Burkov 2020-05-27  484  	}
041cd640b2f3c5 kernel/cgroup/stat.c  Tejun Heo    2017-09-25  485  
041cd640b2f3c5 kernel/cgroup/stat.c  Tejun Heo    2017-09-25  486  	do_div(usage, NSEC_PER_USEC);
041cd640b2f3c5 kernel/cgroup/stat.c  Tejun Heo    2017-09-25  487  	do_div(utime, NSEC_PER_USEC);
041cd640b2f3c5 kernel/cgroup/stat.c  Tejun Heo    2017-09-25  488  	do_div(stime, NSEC_PER_USEC);
0575a42c9f10cd kernel/cgroup/rstat.c Josh Don     2022-05-20 @489  	do_div(forceidle_time, NSEC_PER_USEC);

I think this will cause MEMSan warnings at run time.

041cd640b2f3c5 kernel/cgroup/stat.c  Tejun Heo    2017-09-25  490  
d41bf8c9deaed1 kernel/cgroup/stat.c  Tejun Heo    2017-10-23  491  	seq_printf(seq, "usage_usec %llu\n"
d41bf8c9deaed1 kernel/cgroup/stat.c  Tejun Heo    2017-10-23  492  		   "user_usec %llu\n"
d41bf8c9deaed1 kernel/cgroup/stat.c  Tejun Heo    2017-10-23  493  		   "system_usec %llu\n",
d41bf8c9deaed1 kernel/cgroup/stat.c  Tejun Heo    2017-10-23  494  		   usage, utime, stime);
0575a42c9f10cd kernel/cgroup/rstat.c Josh Don     2022-05-20  495  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

