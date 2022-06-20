Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 127BE551378
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 10:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240377AbiFTI40 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 04:56:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239675AbiFTI4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 04:56:23 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A60A7A1B0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 01:56:22 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25K6gAD0018708;
        Mon, 20 Jun 2022 08:56:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=VeTEGMTP0WSFqIg1kGkIEjgy98rAlJe8xCowjbENCBo=;
 b=gpK/KTgMIsKsUuWlSUlBgLR4VQ0cuwDv1Gd6Di18nAOlPXbuYxUEgYcgb9yfDD5xyBUk
 zWxTEsYCZLWNK0V6EmxGlJ+5Plj1+DfmJrRbUfS8W1pGNA6IPOhzDz6Cfz0ZjZ8qPZRD
 Zo03S5gpikIW7MLOPhLcavD5oR7YABCxOl0HRn2IjZCfJM0OmILaWfr3M+m3/7tBBtkq
 Gqb1CBGrC8zi+j6jNEJJHa/UbYpOqDfFxjFSXe2Mu0EnwOmdjm4ELJ/hLofcp7L6mwEh
 +tqVbZ3yAHWinKbNjnzViA0Nm1/TXKUJ+pOWkYKmbnEXQYxXx97h6EXaQdyFNWgn1bQO QQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gs5a0ar4v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Jun 2022 08:56:00 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25K8kTYW020691;
        Mon, 20 Jun 2022 08:55:59 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2048.outbound.protection.outlook.com [104.47.73.48])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gth8v6asp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Jun 2022 08:55:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hmorq6GekLwxSAttO1jce8ZAH6BN4Jlcsdu3IVM40omWnttoejTLagOWA2KlvsvchzSApxsoyc9fJo58eZhy9jtPyhkmIfHtZcCmnmz4Zfj8QGJTCKX//ON+6SuKd/Pfd4fffbs5/nhr7cpNA09d2tN67K6s25ctrZH0gzck0pcU6vHHIuwstTof+jCA02a7rPjLM7bVM1VCJP/Ii7tZsSQtoH1OqjndRg4OwAYNxdkEHoCc75szeWvbCmLZAQLQHFxqtJvQ4aUXB3OSbGBtZyz/0flYyNaKwY30vC1DyuJHzTmzfap9d2QoGJoGc8Zi3ZO3faqs9yEbLW566GaFVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VeTEGMTP0WSFqIg1kGkIEjgy98rAlJe8xCowjbENCBo=;
 b=WQqV6jUUOij9V1w+7YxyT1V6+evJ5QmJThB0KcmbvJmTj++293e4vdMRcV9162thB6WIqZXuqNpQ+CykO145sw7FSCFDe2PjJcg4ZqVObZbLdzm0Z6XVU0hzti29gMZlImm7vXX9vtsKyOYlQHsyqyCiXfTYPAFCZw8EMvFA5y/Ns6x5Ftbym4h4TorRYH0RIaaJMi7OlgjeunEyZbXYnC+lktvkt8zrZjneryyHxtBOFjhXFqEmqS4e+B9Nn5rEg5dStqYugar7o1N/XfaUoQfF9GYyp43xy48psM1xjADBwjl76T7ERhDSPgUWRdShB5+VHcDznqx0mjewI7LT6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VeTEGMTP0WSFqIg1kGkIEjgy98rAlJe8xCowjbENCBo=;
 b=LOqtyH4F0eowS3prJoVDQLGw+qcVo3EshF2twCRKVN+Wv1W9Gtn+E1ysENMwIbZZbE3dOPo776CX1w/a9vCLL5PsdFTUvj46MXjUcABTDUYE9ix5XWfTibNXp39os5u314NNyxlrlqtEzLjkPKzamA0vV1ZLID/UbFAtHWfwh6U=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BYAPR10MB2792.namprd10.prod.outlook.com
 (2603:10b6:a03:87::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.17; Mon, 20 Jun
 2022 08:55:56 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b%6]) with mapi id 15.20.5353.018; Mon, 20 Jun 2022
 08:55:56 +0000
Date:   Mon, 20 Jun 2022 11:55:37 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Sung Joon Kim <Sungjoon.Kim@amd.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Melissa Wen <mwen@igalia.com>
Subject: drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:5412
 fill_blending_from_plane_state() warn: variable dereferenced before check
 'per_pixel_alpha' (see line 5387)
Message-ID: <202206191752.JhkxXCi7-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0030.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:18::18)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 72ceb189-4fc4-4187-828a-08da529ab045
X-MS-TrafficTypeDiagnostic: BYAPR10MB2792:EE_
X-Microsoft-Antispam-PRVS: <BYAPR10MB27929169360297BFBCE4C7718EB09@BYAPR10MB2792.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SUt+pOh4PM/NzrwzVkmfhAaHLVeQMxoMcyxWl0KSkSO7EQ8pcgYeOG08slUk17nlKyp9bTW2XoiDB98+L078v9WD8xoixkR9JMMSntx59Sldl2jYSt7HER4U5KqEpW3thld+1OlJKDCuU4OVWegKSy1HbiwWrlHF6V99aHvTgIMsrnpIwND81Ahv1UUKoTqCirtVVQX1fJzaeZy4B6q1PRsyNbq569mg/xrAYU/yPnvA2LNC7zALDL7mTeSHw4NrYP0PVWXfFGU+5vRYmcwwZ2yzBOVBde0Lh4WJnpjkqcl+UGkH/YLsSlpUi+HZv5ZJl7P2mCtJyUsW+GRZZ92Wz1n8iZeZ6Dp7oVlSSYrztQ7fJGNUwoLxZXUCar7EVbOOFafxLpk1A+IJI8QfP08es7nlpNvTQfHbs3HNcVf/cmpubskFW0U5KqEXr/Kb5XQhG4oIxEP+FIb8q38oudhEQ0XhkNP7NZDROUjuRLPJ3qVgq38zvqsVL22jLNcW5X4p83huFnAOBcVJnQjP50nilcREj56O4GIXWJaP+zylMZ4l5VNGWzWYCvxTG+BOU8a9t5yWWbLN8szG4izHhEIF8GlR5Bp35nCBnjzre0TQaMLhs/iLraAEoc9pEjXsfWvogG2ea1Kq1Gkn/YddM+az2lNMp++gXZaGDqmJ3iISqv40xDovkb08mXQd0sVHjxCGoy4on1gXPV7v5nKLWmWkEdwU1DVhwtZSnULyIW31fIKkdKXkktk7EgbmhaLzYYlGf0JwYZWJ9mzcgdb7jumrC8iSAYqcP2XXJmqdZf0EpkKISogSCoOfritTICwh8wnVWR2Xs0wbWuzTu8TNLaqq2w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(1076003)(66946007)(86362001)(5660300002)(66476007)(38100700002)(66556008)(6666004)(2906002)(4326008)(966005)(316002)(6486002)(8936002)(52116002)(54906003)(8676002)(9686003)(38350700002)(6512007)(6506007)(498600001)(6916009)(83380400001)(36756003)(44832011)(26005)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mbwZG1fPu1WFtYsgDM37poA2wzCpU7WiEC7KyJOnAOIxkA1RvZ3dL/kbhYws?=
 =?us-ascii?Q?kRYNQJgk0bEGS6SQIS16+C0RB7QoN3mmy3I2UQ0p93NtMT6xh/Q5VtvjlGwA?=
 =?us-ascii?Q?Aob106gpzMM8I34hZBjvDlDLEaCXLhtcPeNWHZvObvnRku3JVuWmRcjtVznq?=
 =?us-ascii?Q?AfbdFY4F1UYIUOZItcx3SPkS9CU3JmMT+JSLeXW4CEW1T/v5OPA+rCWMZX7w?=
 =?us-ascii?Q?7J88s+CPYxNRIMU7HGc/ZjzH+gi3CQ8DSYL/hoh4kjCkt3AeQvzXcZixXBpo?=
 =?us-ascii?Q?KI0CMRbFyRSvmBZKHbruki5/YsgXpGf3awlYHOM34pzsty2Z350rqxjWc8Ga?=
 =?us-ascii?Q?/6ZLcaZPJtzCnwmiRM03WyRD6b6EYIFWih1amavfvpM63CQP0b0LQ/GtCVjF?=
 =?us-ascii?Q?OqPSEYlFjpZtUZPpks4qJ++Hf1sYAPA8TL5pRKKGapgtwsyQkQ86Onek8aLe?=
 =?us-ascii?Q?PGtKKkKD4rnxeHJm1ZbdyHsDa78GoTOgIGE5HLKMV40vlgaBxXnwxvgABwyF?=
 =?us-ascii?Q?srF/a7W3eJ2hBEZjnl6E/JTbm4uxL8k6SSdjySymVbFjBLEMhtt540XZhlIK?=
 =?us-ascii?Q?W0s9djNtfr+IeEcagjtgmDFLKo8H2DnGEyPjh+mduVHjyEB0/1yNwTYa2BR4?=
 =?us-ascii?Q?YRD6vr8yTSNdr0mjaP9ydeU2bAnJrLzQzPXiLj/Xm6q229RW15VurbNlQIFf?=
 =?us-ascii?Q?MfhJ2ybAaRTYsSRN1WY/vT/xd+nEAJ2tYusX/+gErfYyKXzuapwwPg6A0U2m?=
 =?us-ascii?Q?CHyyIxLT9YpyV+uKzZQfNlkh/UVAbFLYTT0psP4MFRA2egylrjprWIINJBg+?=
 =?us-ascii?Q?awavpEPBv6BDkyB3a0SS5w17JrEczVLXTQlVzhbnejn+lExLNubEdG7FDswZ?=
 =?us-ascii?Q?LzhaZWw0vbMm7d/db5KeOPikuVViQjxNfKM3EOBA9U3wmeeUMarQ/raSyhwr?=
 =?us-ascii?Q?5UffcniWBk6PuRe+VdKjJVWHkwrCjcyR7bphj4ehamAOk1H56hBTGvTsuqbU?=
 =?us-ascii?Q?XQbNQ6Fo8VJgltI+EegdlxvPP89yL4I078F6dbjI5oRD732VRKF0X6mOX3l+?=
 =?us-ascii?Q?LvizVtcCP5XetmUHRHbAeiIOL42wEs3Ty7+4O5n7oOu7IXLngrKItbvyJZMC?=
 =?us-ascii?Q?t7eHsIBx+oN0dOt0TRs6Ahx+XyueBbD/GPwUtmOJMYSjU8xgzx/tLqa/3kOZ?=
 =?us-ascii?Q?v+/t+7mGO4R86fWCx6kfRO4uFh1ZmhCT4VpG8onwzzrfRr+wyb6VftlvoHHU?=
 =?us-ascii?Q?0W+Zy213IrYlDxP6BJ3ENLuKRnMo/ZHCHSDdQUQ0GdHUyXIR+sflxb2kSj5r?=
 =?us-ascii?Q?YTziBQlVHuOg2WiZF9GsYoG7+AYyCINKETuGEfU0QwPKR3iaemEVYEAVmlSX?=
 =?us-ascii?Q?suWyYIK3tW2x0SYxcUstcX+Nyt2rexRiJXaKFbxCCk/VvTf73UL469NwkG5k?=
 =?us-ascii?Q?rf6sBSxrzT1xMOzH8IBoVb49/067fpjVs5QytWXSAOo6QIQfw9WfUOoEYj48?=
 =?us-ascii?Q?9JkOV6qQvDYghI4b2Zl6gO56aAqnn7OJOgZVL0lrZMei44kJBEUpsClBsPkl?=
 =?us-ascii?Q?kv9OV7Ga62naCpf9WYi8fhcnUeQJCSz5nxiydK3+6fHxAk6qu2I+WeiULAiY?=
 =?us-ascii?Q?aNSTFvzV9dSmjxrs9DfRfNoYFyOF1OgygW/iqr2iZAvBPiRbOYCfRbPsS/Md?=
 =?us-ascii?Q?xgCq1EeWQMI36ev/4aH3W/nGvGUkC3ySNUPxJSPOhgeWrjVJP/wvlFja0dFh?=
 =?us-ascii?Q?X+IBjfk1B3bTnDHtKlpf2+kJeknAE8k=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72ceb189-4fc4-4187-828a-08da529ab045
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2022 08:55:56.6351
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: srkNAEPXPPIXCuUBljhKknoGJItHXgEwlptucLWBWZle5kuT8fqdU2QuFsV+rymIa9WIzD7WAqMDBOxBVpo+0Wne/KvgkHRabmoYtIsRVHA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2792
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-20_04:2022-06-17,2022-06-20 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 phishscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206200041
X-Proofpoint-ORIG-GUID: w6W5tQfeeI8ZM7v8lVG20RRPrxAZZ9RH
X-Proofpoint-GUID: w6W5tQfeeI8ZM7v8lVG20RRPrxAZZ9RH
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   4b35035bcf80ddb47c0112c4fbd84a63a2836a18
commit: 76818cdd11a25ac6cb1d98875719935d8d0e2e51 drm/amd/display: add Coverage blend mode for overlay plane
config: ia64-randconfig-m031-20220616 (https://download.01.org/0day-ci/archive/20220619/202206191752.JhkxXCi7-lkp@intel.com/config)
compiler: ia64-linux-gcc (GCC) 11.3.0

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

New smatch warnings:
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:5412 fill_blending_from_plane_state() warn: variable dereferenced before check 'per_pixel_alpha' (see line 5387)

Old smatch warnings:
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:1726 amdgpu_dm_fini() warn: variable dereferenced before check 'adev->dm.dc' (see line 1699)
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:2707 dm_resume() error: we previously assumed 'aconnector->dc_link' could be null (see line 2694)
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:3995 amdgpu_dm_backlight_update_status() error: testing array offset 'i' after use.
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:4037 amdgpu_dm_backlight_get_brightness() error: testing array offset 'i' after use.
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:6507 create_stream_for_sink() error: we previously assumed 'aconnector->dc_sink' could be null (see line 6406)
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:8894 handle_cursor_update() error: we previously assumed 'afb' could be null (see line 8853)

vim +/per_pixel_alpha +5412 drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c

d74004b694ea88 Nicholas Kazlauskas 2019-02-21  5382  static void
695af5f9a51914 Nicholas Kazlauskas 2019-03-28  5383  fill_blending_from_plane_state(const struct drm_plane_state *plane_state,
76818cdd11a25a Sung Joon Kim       2022-05-19  5384  			       bool *per_pixel_alpha, bool *pre_multiplied_alpha,
76818cdd11a25a Sung Joon Kim       2022-05-19  5385  			       bool *global_alpha, int *global_alpha_value)
d74004b694ea88 Nicholas Kazlauskas 2019-02-21  5386  {
d74004b694ea88 Nicholas Kazlauskas 2019-02-21 @5387  	*per_pixel_alpha = false;

Dereference

76818cdd11a25a Sung Joon Kim       2022-05-19  5388  	*pre_multiplied_alpha = true;
d74004b694ea88 Nicholas Kazlauskas 2019-02-21  5389  	*global_alpha = false;
d74004b694ea88 Nicholas Kazlauskas 2019-02-21  5390  	*global_alpha_value = 0xff;
d74004b694ea88 Nicholas Kazlauskas 2019-02-21  5391  
d74004b694ea88 Nicholas Kazlauskas 2019-02-21  5392  	if (plane_state->plane->type != DRM_PLANE_TYPE_OVERLAY)
d74004b694ea88 Nicholas Kazlauskas 2019-02-21  5393  		return;
d74004b694ea88 Nicholas Kazlauskas 2019-02-21  5394  
76818cdd11a25a Sung Joon Kim       2022-05-19  5395  	if (plane_state->pixel_blend_mode == DRM_MODE_BLEND_PREMULTI ||
76818cdd11a25a Sung Joon Kim       2022-05-19  5396  		plane_state->pixel_blend_mode == DRM_MODE_BLEND_COVERAGE) {
d74004b694ea88 Nicholas Kazlauskas 2019-02-21  5397  		static const uint32_t alpha_formats[] = {
d74004b694ea88 Nicholas Kazlauskas 2019-02-21  5398  			DRM_FORMAT_ARGB8888,
d74004b694ea88 Nicholas Kazlauskas 2019-02-21  5399  			DRM_FORMAT_RGBA8888,
d74004b694ea88 Nicholas Kazlauskas 2019-02-21  5400  			DRM_FORMAT_ABGR8888,
d74004b694ea88 Nicholas Kazlauskas 2019-02-21  5401  		};
d74004b694ea88 Nicholas Kazlauskas 2019-02-21  5402  		uint32_t format = plane_state->fb->format->format;
d74004b694ea88 Nicholas Kazlauskas 2019-02-21  5403  		unsigned int i;
d74004b694ea88 Nicholas Kazlauskas 2019-02-21  5404  
d74004b694ea88 Nicholas Kazlauskas 2019-02-21  5405  		for (i = 0; i < ARRAY_SIZE(alpha_formats); ++i) {
d74004b694ea88 Nicholas Kazlauskas 2019-02-21  5406  			if (format == alpha_formats[i]) {
d74004b694ea88 Nicholas Kazlauskas 2019-02-21  5407  				*per_pixel_alpha = true;
d74004b694ea88 Nicholas Kazlauskas 2019-02-21  5408  				break;
d74004b694ea88 Nicholas Kazlauskas 2019-02-21  5409  			}
d74004b694ea88 Nicholas Kazlauskas 2019-02-21  5410  		}
76818cdd11a25a Sung Joon Kim       2022-05-19  5411  
76818cdd11a25a Sung Joon Kim       2022-05-19 @5412  		if (per_pixel_alpha && plane_state->pixel_blend_mode == DRM_MODE_BLEND_COVERAGE)

No point in checking "per_pixel_alpha".  I think it's supposed to be
checking asterisks "*per_pixel_alpha" instead.

76818cdd11a25a Sung Joon Kim       2022-05-19  5413  			*pre_multiplied_alpha = false;
d74004b694ea88 Nicholas Kazlauskas 2019-02-21  5414  	}
d74004b694ea88 Nicholas Kazlauskas 2019-02-21  5415  
d74004b694ea88 Nicholas Kazlauskas 2019-02-21  5416  	if (plane_state->alpha < 0xffff) {
d74004b694ea88 Nicholas Kazlauskas 2019-02-21  5417  		*global_alpha = true;
d74004b694ea88 Nicholas Kazlauskas 2019-02-21  5418  		*global_alpha_value = plane_state->alpha >> 8;
d74004b694ea88 Nicholas Kazlauskas 2019-02-21  5419  	}
d74004b694ea88 Nicholas Kazlauskas 2019-02-21  5420  }

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

