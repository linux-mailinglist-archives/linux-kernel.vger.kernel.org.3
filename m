Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C93F649C743
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 11:15:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239737AbiAZKPP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 05:15:15 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:60964 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239772AbiAZKPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 05:15:13 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20Q9gmQU007713;
        Wed, 26 Jan 2022 10:14:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=4V7RpQYVOpXILmFvojfWWqy/ToNywTk372mU6xr+z90=;
 b=AR+pc3iCdmPFZw2RpmUEFlAVW6+c6azJE3I14qgSl8VShZjDTrYtu6bavpsxI10pwQ99
 6+t3iSi2djCP3DKfJSdH/Phq5OC0cxJxykyqcJTgsIzDCOkmV/HPqnrO40TkPcOIrB85
 D0XUWxQBV91E+bj9KAUAfAXaM0N/lrdHUQPs7eiPdX/N0qEvJrL0FH20Hdv0YjJnmEPQ
 vNfJGcndnWVnQDAOuRew2Wx313OJ2jqKmzathz/IM1FuyALjNN6eqGgvX9WtjJ6KodMq
 ynvvf4kr8rtytLdBXqfAAtYiYRizopwrF1iqUU4i1Ol7Gen7riGFCiQi8XU9fm9AwhCE sg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dsy9s5q8w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jan 2022 10:14:47 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20QAAUV8018738;
        Wed, 26 Jan 2022 10:14:46 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
        by userp3020.oracle.com with ESMTP id 3drbcqrj7p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jan 2022 10:14:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=McsoZXeFFfFsWEYRGAns//AmLosF7hjQ8XLICdzGUa27U60/m71IZot2EJI3J7tDZuT4n6CnghtydA7+chqFjnuy2jAHcpsFE7XdqkzQKiQ3yfeebH2Wgwpk+vmdApGailcxgSl2ZJ6+z5MveJyWAmnFGREm1AUueIQg1yiCkb6LizKrJlf3Jt9OjYZC4JTpM8W8ldbM5jfupxWcib49t3bAIULKoh8Zq5N1d3jDSpw71QfuNgwIMMoTvQ0fGLgvsIAEaICNNq0IVkRilAn5NYtV84O6FFdqyJG9gE+0JGnyScSIDDCWYHsCRLnbcF+gSY9UiDvPUARclz1V3nWaxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4V7RpQYVOpXILmFvojfWWqy/ToNywTk372mU6xr+z90=;
 b=H/LYipgvf7zmTWukjh/g9YCxfyULXz8/m1Q7FolQdsTrnKvBfb4+8R5ZwCuy8/nUVmX6CKBQ8XbKQU1wf6ly2zp24LIMxNeuC1GV4bDWI3eiafCRMO4L0tsqAnZNgvnyXLuyc2XcOhusR17RPyuWomxZ3aXJKpTl/0UqA2c2U1lld+RxyA2+aD5SpecrgzizpQYn8ieghDyFj4GB1JUE9mcPQ/mk8gBNS359Skn+ftqdkVXAxuah/9cSw3Z2ezfblpQoDuwUx77ZW0c81rlJ/7BzdaiSXviClfWB+EPoGx/DWALjB/MLyNgNzwtHktxSpKWT+Ufql8EGjJRVTc2RYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4V7RpQYVOpXILmFvojfWWqy/ToNywTk372mU6xr+z90=;
 b=MfqCu4LYCj4C61tS22Lk1IfSpjsw8Q/q3GNrmWAofP/4FA8JrseL8UeDVE9jazr7wqGEUh98h9in3uu//Z4dY7DxzBLGm+GRKxgny3rj4N+0XCz5H9FEmhHL8V8WNqe6tayH8Ct2FnY6qwXMoC8B4Hyt/o5Ufqdg4mZmUOijRKI=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BYAPR10MB2488.namprd10.prod.outlook.com
 (2603:10b6:a02:b9::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.13; Wed, 26 Jan
 2022 10:14:44 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c13b:5812:a403:6d96]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c13b:5812:a403:6d96%6]) with mapi id 15.20.4909.019; Wed, 26 Jan 2022
 10:14:43 +0000
Date:   Wed, 26 Jan 2022 13:14:22 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Tom Zanussi <zanussi@kernel.org>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Subject: kernel/trace/trace_events_hist.c:6174 event_hist_trigger_parse()
 error: we previously assumed 'glob' could be null (see line 6166)
Message-ID: <202201250054.975KVd1O-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0014.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4c::19)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d389ae7c-ffae-4fb2-bffb-08d9e0b4ac37
X-MS-TrafficTypeDiagnostic: BYAPR10MB2488:EE_
X-Microsoft-Antispam-PRVS: <BYAPR10MB2488B7D6E54570C691759EAB8E209@BYAPR10MB2488.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:356;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: evm2gEUM3F/iZkLl+khRZcQySPvJmmPHHxdDxpXhL79qIVD/3VI+SLBis9t5/4/GOV7fomvMw4AqQM8lGZLQX23oz2XN8bqvcVfKnPKQHgnEdTznsJtNCUJtBjAYNhA7GY3Os17iOyjw9sial2B1rDGUeHxf8asnWYhTptmISJcYKw/dfqDyXxI+ncMoFTZ3/11gJqjH/+kWWppkL0YxtOsGqnIEJSYUhu2QpoN4/Da8YtYzvcKr82qu3zLa1rU8i5A9Umo2ep329NtYVGh0/pVhjL4ZSyE7vOsw5K33pPDT/qQeevn7Xp0eQOgfpiMBEkev7nXGW0gh1Rn/rq0HGF7SWv+dvnsub7VodBMUNz9+4caeH46I7Ypo9Gp5sbnXYXhYj1pS1ufGnbmVoFI4gTcn1RmuR+c7MDG+q6hb3twbzLEn4uMQXVAgwljcYX9mk6DTVrdKGQSMELwlzHeaBQP4cYb7b7nwu+LfkkXzK1h+OHZUg8NjXPJlw/WuGs0bbjGjYEorI2CUn8LlECQbHxtOE+G5kvp+LsM6P2sso/VxOOs/NYdFe03W7YdqWaZCWgGbwzDdkRIWu0dEQQpcLjMllxntLhDUIaPt7F49QtiTXAUqn8w0kTKEUnDY45vXHKAuhmeOcGz1d51LM+YEz4ExFtWqnBzFSoABVu0TlUAbfuORduwgPJQk4ee67LShDMhS0tRk2NtZu+zURE+kuJfHWaJOzFtd32TQOkPdnONnh+C7bB/ytJdFs/H9Z37TqCMcV+560+uiVgZLLzVTZ0HAPeNaMXuA12eMeS8Kw/JwkMmMfmrj9WOB8wIYpyE/pUBWuyr4Vsxy15bgcQC+Gg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(2906002)(6486002)(66946007)(66476007)(6666004)(6916009)(66556008)(26005)(4326008)(86362001)(36756003)(6512007)(9686003)(38350700002)(5660300002)(38100700002)(83380400001)(4001150100001)(186003)(1076003)(44832011)(508600001)(52116002)(8676002)(316002)(6506007)(8936002)(966005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KHNK4KyjTMk8CKQNDMPzitAPu35Fmv6sMnme6saEdNMD3WJfoURJZFA9+0Gt?=
 =?us-ascii?Q?gqUtSvcoKUm6DkAcrp7DNhWHyNu8F/70ZF5YMws/0gpmDOHFaOtyGh4a2y1C?=
 =?us-ascii?Q?P7TcS7bsuxJFVZGAjryB2lpLQdF2c3HukIUdm8H6kRY5xy5ZxPABRoqKs9Qp?=
 =?us-ascii?Q?Db2ZEpSeMn2rNHFaGim792KxxWG7bb3SV5TOnn/sNKeqDuRmdnnUoUXw+opS?=
 =?us-ascii?Q?mnEDC2PVqT+TO1hAoElQT7AtGbpz5Sba5N8k67KCPpCHgvsdSuEZajBsPdgE?=
 =?us-ascii?Q?rBwTegjYSFlm6CPH2cQHT3OxiylDMwjTdni0N302Q6EQoQdpYWIXg91C62Lf?=
 =?us-ascii?Q?IzsEoZuhRTyPexBWzQ5gDq17dgZxzLkXN+BfYopKLDfca+NAGdiq7JVe9c6a?=
 =?us-ascii?Q?SCZ7jFU72MYAc3G694ghFjV5wAzlRCL8g/G+p4nMhRoxfRSCVy1EmmYL3Jfp?=
 =?us-ascii?Q?ISmddGMzikpNH96JOaFIu5mFUSv2bRjfC8MYdMjIx5TTX/AlfxfyC6D4tN9D?=
 =?us-ascii?Q?13RLpaZM7ITT4YcyzokXIU69BOqiO0W8h63YZuiNtVrcTBCHfdl1Upeicm7k?=
 =?us-ascii?Q?qjioS7H3TFTAgdtXh8+GdY8E0uh3egJ0lwA4ZlKqg8h7T/BhpjtOBfzJBjVu?=
 =?us-ascii?Q?mYCMNd4aACBFwOQl/Zl3RWibcW5mB6Wtpmxk9Qn42WM7x8lCfaUms/US3rBX?=
 =?us-ascii?Q?DyH1dOU5Z0EJ0gNyQ1JGGtJnezk3FDCzRJjjvZLFlv8Sl0Q1hxw+vd5tL6+c?=
 =?us-ascii?Q?7MUGt+lzwMud1n9XxTQdHEBGJNmzF+tK/BkUjt1AP8J7BT7fOGyyT+53447t?=
 =?us-ascii?Q?eBHIkbECbaGuyp0mpUySGW3FM0uP+mFSLIqVMgZeSWzM7vpjWJjbf3Yb23IV?=
 =?us-ascii?Q?4B92ktRQrs6G3ipbOHhIlYQAZFmFZzvGN50W1fyoKnkqmGmDJRifBK4HMVwJ?=
 =?us-ascii?Q?fG/lLnBCzRBo94EbBlxESq9o15pmqMHtWIK3S+mVZ9FaHr36u/3561szOdB6?=
 =?us-ascii?Q?m8bchAmNvevNiRQB3gIgOBMo99y9fwiTwlbVnl51pUS7MyUqwgakZ4+ZdovS?=
 =?us-ascii?Q?eDE+fFRhgug5bmqcLLGc6voqmQ3kMGrs34fEsB8uuOT/lI8LKimUwSGwYuTH?=
 =?us-ascii?Q?6q3UzoAQxlSqoyqMMjdE5Cde3vGSUQXKAVsEUF56IGpZNJwopsWig67KJDJO?=
 =?us-ascii?Q?Axq81aiqwQuy9aeUeeR3IbhEC18cvFixD0ShUOMpMZiDkI0xP05v6zreAbmz?=
 =?us-ascii?Q?nzk0W8kmbXwFmq1+3+szabpfijcg1fJKkgIh2kidT3kx6ONQnqs9i87R6kLx?=
 =?us-ascii?Q?vKsfqADo923k1GEY6gZ7ylCuJq7Uq2IMxWHwBqNkVFxybwY9I3BPOG1TVv2H?=
 =?us-ascii?Q?iwaADCdyWNvEkinuWUoPJo4s9nz0xE56JyWHvnkDcdKd6bK/P6LMzO4qyA77?=
 =?us-ascii?Q?FWHM9rMErDkHDTHqkOfwUfnusliLUM0WwvgPGpFtUc/49qugejUbeQ+1hhIy?=
 =?us-ascii?Q?3YZuEB3SXQ/bptALi+TTFj2zKEaw1JAQ7/j4mgH45bvxxUkF1jGUy52GTrWx?=
 =?us-ascii?Q?1BOzvx+617gSNAt9nJ4QnC3rOGK9Lj/jb9vmrCZ51Opp7Z4JILozLSwpBlw8?=
 =?us-ascii?Q?xI4Sv9AdS4jlZcxqvzqHS+zJwJmFGQj9vRaaPd9fzz/q+M4iKZSd4SLrjGJH?=
 =?us-ascii?Q?ueNd9AnrZbgw9T/5WXnq47iDmho=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d389ae7c-ffae-4fb2-bffb-08d9e0b4ac37
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2022 10:14:43.8799
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OoGuJWrWkWTP49MIuvF2z03/+VewAytoh5Wkd1DYZktIoH4v0ssa5gbjvOfI46JzcTbrLeackQdpA0nsWZRiDDx/ZKYM16zxmibi2t8FhSE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2488
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10238 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 malwarescore=0
 spamscore=0 phishscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2201260060
X-Proofpoint-GUID: 7VLBX83WhnMPYJ--b00ZjVkmb5TGFQCB
X-Proofpoint-ORIG-GUID: 7VLBX83WhnMPYJ--b00ZjVkmb5TGFQCB
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   dd81e1c7d5fb126e5fbc5c9e334d7b3ec29a16a0
commit: 9ec5a7d16899ed9062cc4c3dd3a13e1771411ab3 tracing: Change event_command func() to parse()
config: x86_64-randconfig-m001-20220124 (https://download.01.org/0day-ci/archive/20220125/202201250054.975KVd1O-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
kernel/trace/trace_events_hist.c:6174 event_hist_trigger_parse() error: we previously assumed 'glob' could be null (see line 6166)

vim +/glob +6174 kernel/trace/trace_events_hist.c

9ec5a7d16899ed Tom Zanussi             2022-01-10  6149  static int event_hist_trigger_parse(struct event_command *cmd_ops,
7ef224d1d0e3a1 Tom Zanussi             2016-03-03  6150  				    struct trace_event_file *file,
7ef224d1d0e3a1 Tom Zanussi             2016-03-03  6151  				    char *glob, char *cmd, char *param)
7ef224d1d0e3a1 Tom Zanussi             2016-03-03  6152  {
7ef224d1d0e3a1 Tom Zanussi             2016-03-03  6153  	unsigned int hist_trigger_bits = TRACING_MAP_BITS_DEFAULT;
7ef224d1d0e3a1 Tom Zanussi             2016-03-03  6154  	struct event_trigger_data *trigger_data;
7ef224d1d0e3a1 Tom Zanussi             2016-03-03  6155  	struct hist_trigger_attrs *attrs;
7ef224d1d0e3a1 Tom Zanussi             2016-03-03  6156  	struct event_trigger_ops *trigger_ops;
7ef224d1d0e3a1 Tom Zanussi             2016-03-03  6157  	struct hist_trigger_data *hist_data;
4b147936fa5096 Tom Zanussi             2018-01-15  6158  	struct synth_event *se;
4b147936fa5096 Tom Zanussi             2018-01-15  6159  	const char *se_name;
30350d65ac5676 Tom Zanussi             2018-01-15  6160  	bool remove = false;
c5eac6ee8bc5d3 Kalesh Singh            2021-10-25  6161  	char *trigger, *p, *start;
7ef224d1d0e3a1 Tom Zanussi             2016-03-03  6162  	int ret = 0;
7ef224d1d0e3a1 Tom Zanussi             2016-03-03  6163  
0e2b81f7b52a1c Masami Hiramatsu        2018-11-05  6164  	lockdep_assert_held(&event_mutex);
0e2b81f7b52a1c Masami Hiramatsu        2018-11-05  6165  
f404da6e1d46ce Tom Zanussi             2018-01-15 @6166  	if (glob && strlen(glob)) {

Check for NULL

f404da6e1d46ce Tom Zanussi             2018-01-15  6167  		hist_err_clear();
a1a05bb40e229d Tom Zanussi             2019-03-31  6168  		last_cmd_set(file, param);
f404da6e1d46ce Tom Zanussi             2018-01-15  6169  	}
f404da6e1d46ce Tom Zanussi             2018-01-15  6170  
7ef224d1d0e3a1 Tom Zanussi             2016-03-03  6171  	if (!param)
7ef224d1d0e3a1 Tom Zanussi             2016-03-03  6172  		return -EINVAL;
7ef224d1d0e3a1 Tom Zanussi             2016-03-03  6173  
30350d65ac5676 Tom Zanussi             2018-01-15 @6174  	if (glob[0] == '!')

Unchecked dereference

30350d65ac5676 Tom Zanussi             2018-01-15  6175  		remove = true;
30350d65ac5676 Tom Zanussi             2018-01-15  6176  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

