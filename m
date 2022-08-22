Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 148C959B9B3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 08:43:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbiHVGnj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 02:43:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiHVGng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 02:43:36 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7B5C9587
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 23:43:33 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27M3nU06020472;
        Mon, 22 Aug 2022 06:43:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2022-7-12;
 bh=o29w6h3b4WY4routxme5K803L0C1taDpeFil+kURRbQ=;
 b=sh/mEpeOL9q2s5SoKoy8eyzzoHS84K6jf7dAU1+pCnB+FsypNjswd0HNikuS8uX8L5QO
 Ix/4t4yoHuiAEjSotkdSrcw5NdRpwneKLI7RfeJdwFBK8P4lBk96Fb6gBpY9wXJYEMLT
 DEmPhR+Yw+/U4UvttpCqybOfKRikJslPmen5Aesp9eUTlbNc1nOAVDBsYurHPmQww/C0
 LHVJZ9JkpHlb15cYn5snQAHhW5yPW7qbC1MkrAoSo+A27hE+UYDIPdjFMg03MSNigFyk
 PLMHFofIR6m1k2HPeVi8DlOuCKkJCPjn1dP8VHkvU6aMIk7hAwVrVP7mcMiw9LrlJU8e Yw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j4280r8p0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Aug 2022 06:43:09 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27M58Vxg038305;
        Mon, 22 Aug 2022 06:43:08 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2104.outbound.protection.outlook.com [104.47.55.104])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3j3mkfnv7h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Aug 2022 06:43:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PcdX91kXh4HTpyZMOpo3erePcU/G9lhpifXlUa54u46KfZzeVcKFwUmOjdmFEW/Zs6hioeusau/7+dC7940B8+BRjKoOiNkrHATJTdNLOFc1lougus1HXF1IoNEw+gWhld1+GDL4D0et6yh+EYJ3mNsRttZN7Z0wovMGeabR+sF/vJu+iSJRscYo745fh9yS3hysZSiQywaZS9oge1lRCzNV970pSeixuAOCDRJdmbLdlbH2ScraNWdAV++90oI5AXqx9bAtM3Umfyu34fztCnLdZTRtkNvjtt05ke+aGyI89a9cwx56MkUHdrIbvlghEhkesQ1AEl8ONyshWD1izg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o29w6h3b4WY4routxme5K803L0C1taDpeFil+kURRbQ=;
 b=IT6xS8EtEMNJv6RXuUzhQgUdr2qAumuM3rm60Iix207Oo+M3eaF9dh4D26K4yZdv1yd8W0YDROhf6MHqwduN9zo3kFLN2MKVvXwXoSFEVoSwE5u9Aanu6ddnEafDUFUDRCA6fCWy+ui77p7w4Ju6h+Z1Do3BkkjgxQzUf0BWIrq4ouO8WC2EKLjVnjxaVzbgBRK5+fXijJRPqdQckcREnun4Zx+2+iJcFQN/E/2h6MS18P+ezXFNsBZJVp79VdR8CQhCR6iB+Y3zhKfQBibazOs1EmLsFcQeFlPaiAgCYql59Oo86InKx7O5Gi+rCrKP3Yxw9fuUwINn0m0sA92TsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o29w6h3b4WY4routxme5K803L0C1taDpeFil+kURRbQ=;
 b=RMzqA8KYZNWPaCzrfNSFJCmjbxLFYyH97qs8yyLIAAkSkjfBBjAtzgZukZ5Z1quaYtpqpkqugQV3H8Yv8VhJCUtUQ114KxylW+cz1ihVLwqOfZrckfv8Pp3Gjn8IlracrlS5JH/LXYpiDCgzKMqEefbj7y7o0lIs9e5MXNdOOwE=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BYAPR10MB3110.namprd10.prod.outlook.com
 (2603:10b6:a03:152::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.18; Mon, 22 Aug
 2022 06:43:06 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026%3]) with mapi id 15.20.5546.022; Mon, 22 Aug 2022
 06:43:06 +0000
Date:   Mon, 22 Aug 2022 09:42:53 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Huang Rui <ray.huang@amd.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Tim Huang <Tim.Huang@amd.com>
Subject: drivers/gpu/drm/amd/amdgpu/../pm/swsmu/amdgpu_smu.c:139
 smu_set_gfx_power_up_by_imu() error: we previously assumed 'smu->ppt_funcs'
 could be null (see line 139)
Message-ID: <202208190418.1Y3QCIis-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MR1P264CA0167.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:55::8) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d22557a6-9daa-4d02-07b4-08da84099192
X-MS-TrafficTypeDiagnostic: BYAPR10MB3110:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LeQ0SDtnkrgxvKew+eyvmTT2kuM2FJutfhVCvHw2/YyHp9FBQ+TfkMz6oXYMY6aLr+Ju081QAcIfsdLGEvevsZHg2WP3fx755sbiz2+YEKae2a+017QkFQV3yqBPc6IKH6JnnWk5KNn7YWMOkv/CKFnI6HfK72+e6bi18b4OQ7nTiXo0XHozqfFZGsiGsDVt7PgfocpSAqjGtYfJk1gxBKKAIuXVgEDDUtcasTw27NyT0BmHdoPIjaaz4zykFk5gEeZ3iktMpwJSi/gqW/AJShtxOB8htFQEUKaBIiMe82Q1ZYoeDMOIZNiRfVKBX6Dww/Yd50zz/Stco2Ztuk7CMVs9nqrzZ4FXRp1xsmw+8m8isFcctdyanaTOJ8u1egoTZVLMDo2+6D6SccXuTRhLcfpHDQb/d7ebOCE0G3ceeFno8220EUn/9mSEjM5LmZwF9khFw6bMuJC5LA6ClJWV4leZ7wu8Q3AXvldtIXAfoccwEZL0y1rp+8+jPoDGpeSPDM69x9zSS7k8rYcPqBdh92cWzGxv00uDOSiO4NmnZx1xfMpQ+j84v21zGLNrBQpqAM6Vd9NAUz6/Ovib1dyLzySdynW3FmRfPRRyI9nDxk+hbC1d5paV+oPjbhtsylvMjS1pYnUHm2wS4s+ZLLBAnQEFaxwYcTVFTQOulrk568Gkn+qht+Xum4vQtEUlHBvIxTWsCsc3puuzycucSxCuQuA1ziUP4/vh5MTs7mUPnwEJw4D54yebpFJP293dsDunc1h+KHmgV6VoqOnLrU/ci1euzQHfS544fFq8m58PeMwdiqmvfVaf1LbpRvfugo1UlqgVqDf5ttWbTqrra+xkwA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(366004)(346002)(376002)(39860400002)(396003)(478600001)(6666004)(52116002)(6506007)(86362001)(36756003)(6512007)(26005)(9686003)(83380400001)(41300700001)(6486002)(1076003)(186003)(966005)(66476007)(66556008)(66946007)(316002)(4326008)(54906003)(8676002)(6916009)(38350700002)(38100700002)(5660300002)(44832011)(8936002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EKLUFLxmxr98k4ZCSfAforhNHByDWFzrHeqt06tijkGzTP+YVh1qzmG00ovn?=
 =?us-ascii?Q?wpA6NWZzftaoBpzyEmyocV6v34IMPUjG8NkGKGfpTlAm7H4AFv2A84IEOo/N?=
 =?us-ascii?Q?t9qEfRenLHOsi2jUNhHVzMynZ9WPfYwf/v4jqQhBcIhwUW2Je7aKOJVtXpwN?=
 =?us-ascii?Q?Wko99j5Cc6mTlO/ivlgmFiuFOFqem73TjMA/H0gvCm6mCwPo3gB//7e60f8e?=
 =?us-ascii?Q?yE3w9Z/RxpRct4APoSr5zH6zb6T+lfQIfXaCK/1Maf5oPkQOj78LJCfEbuZc?=
 =?us-ascii?Q?BXvl/kUGJPmLjMVf3Y8cBPFbcEDwx3okb7sNPsDPmmraF0LN7CGCBTCdOTQ9?=
 =?us-ascii?Q?S9D35kLv9/k+qnWn3EOpZuR/LnWo+f9UV2rGnnGOzDlRm2L0TurXiIs8Al44?=
 =?us-ascii?Q?PBRfY5bTNdNVGHsSCpDWvrwxvSoW+jTcrpUDcNIhvVo51qXHPOHzP9jrr85E?=
 =?us-ascii?Q?7pzwgyK3kj5ji+/4CrxBKP52d3sVvm+7lx0Ra5RyWXBAul3Fln7Q1OQq0Is+?=
 =?us-ascii?Q?YxdhGxVV1vzYSAPiKVYxg4qfVse6r8Nj/Wzm+FRLNlfIYYzk2fqhbxMhKTQB?=
 =?us-ascii?Q?mLPKDL3TZDtBYHSNdyrJJKz9vsAw577NYYMAyTeE55FELRtQYaxSc0RUykkx?=
 =?us-ascii?Q?/OT7MNzk9aF3g9mX3wQ6mqE6I2ALPyB6+A3KRdKGUrXd9HbY7tlGTcEXHIB+?=
 =?us-ascii?Q?tQZPNOY0ycz5trBgU16Z34t7Rrish6PaBubgPPytoCXu2Fy7EP4q5WfbJRim?=
 =?us-ascii?Q?uF3CNuR9hXVclPx11Zx8FQ+mDPBvFMtl5xAARg1PICeOSqIrUngV5lz6dP8K?=
 =?us-ascii?Q?0du/NBh2Qm637D+t+R3GzJSm1V8TnxDt4yYk1EpCBn9EQsCMoUBORlow1s+N?=
 =?us-ascii?Q?N7nK1lzzHK/FQhlqbP5R+CMZZ7gD3j924e+gLZd2tdtHUxC3iixPTGs6PsNQ?=
 =?us-ascii?Q?lhi9iLreEGYvkC5UjGveEY4fshFz++FeIkBTpzOK6dzizkOSuQvLfM4JnoVr?=
 =?us-ascii?Q?EC0uze9k8tJELWwc0Qm2DtC4Y5nt/JLBmLFu8m0n/RJA7WHTVTXc44lH6gPr?=
 =?us-ascii?Q?Zte2LowZKssxY6ogXh7n6i5sk2/ejgg4zLWmT0noV7R5CpgqLjy/z0U+RXw4?=
 =?us-ascii?Q?39UM6FIm41hdFt7ZPNut3BQOwzZ1gZEcUHkg2zNYKEFmPM1S7rAZQHHDghw9?=
 =?us-ascii?Q?mNLuG0o3UgWR9Ad/1MTPh6zeczNmETzIVW98ITF7k7LSg4MYvJMzQWVdM2xM?=
 =?us-ascii?Q?P/w2l0sVtLvEtzAcaNXJw66obnH8/Vkpuz0NZ+1+1C4sBWt6azaJmARIC4Na?=
 =?us-ascii?Q?vuO9gJPoH7OTlfFwK6Wt7ubF16gCQPY8kkIZCjXWtBHMLc9Z0/QpbHlh1E6x?=
 =?us-ascii?Q?S0FFniRB/Rb+s8fosrbHrdtfSc8N+/7r1ofs2/TpkjFMsyhLhqxKAosSzbw9?=
 =?us-ascii?Q?TPvXsyOB3QBqGRMW4s6MeyGt09rRAzxW/XfcMBPLsdCBqzUQOk/eewK28DU5?=
 =?us-ascii?Q?vvYMNa7S++IfnorKUF7oeN6tJIRayTyZtpBarG8wzzxThjBuSsC7rhpSq8bl?=
 =?us-ascii?Q?egTqFTXsAb8uSGZc9bjdNpJS3G7tMqq4au21DIa0?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d22557a6-9daa-4d02-07b4-08da84099192
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2022 06:43:06.2091
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kaRBWQjkjjbAKIMfCjEnRqVeT+im8Y8GLACl8YAkLW9K7qcFZ4JoqGKnfOSWo2DXr6w4MwTL6VtHX9fPYdZ33Ul7T43x/FvEoO76KWe3p/8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3110
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-22_02,2022-08-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208220029
X-Proofpoint-ORIG-GUID: PqQXiczszyLI_fHLpGpwdlsSUkmy_F55
X-Proofpoint-GUID: PqQXiczszyLI_fHLpGpwdlsSUkmy_F55
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   573ae4f13f630d6660008f1974c0a8a29c30e18a
commit: 7101ab97e3b00ec1c68d09826bb0521d17783673 drm/amdgpu/pm: implement the SMU_MSG_EnableGfxImu function
config: ia64-randconfig-m031-20220814 (https://download.01.org/0day-ci/archive/20220819/202208190418.1Y3QCIis-lkp@intel.com/config)
compiler: ia64-linux-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/gpu/drm/amd/amdgpu/../pm/swsmu/amdgpu_smu.c:139 smu_set_gfx_power_up_by_imu() error: we previously assumed 'smu->ppt_funcs' could be null (see line 139)

vim +139 drivers/gpu/drm/amd/amdgpu/../pm/swsmu/amdgpu_smu.c

7101ab97e3b00ec drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c  Huang Rui  2022-05-18  137  int smu_set_gfx_power_up_by_imu(struct smu_context *smu)
7101ab97e3b00ec drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c  Huang Rui  2022-05-18  138  {
7101ab97e3b00ec drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c  Huang Rui  2022-05-18 @139  	if (!smu->ppt_funcs && !smu->ppt_funcs->set_gfx_power_up_by_imu)
                                                                                             ^^^^^^^^^^^^^^     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
This should be ||.  If smu->ppt_funcs is NULL the code will crash.

7101ab97e3b00ec drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c  Huang Rui  2022-05-18  140  		return -EOPNOTSUPP;
7101ab97e3b00ec drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c  Huang Rui  2022-05-18  141  
7101ab97e3b00ec drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c  Huang Rui  2022-05-18  142  	return smu->ppt_funcs->set_gfx_power_up_by_imu(smu);
7101ab97e3b00ec drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c  Huang Rui  2022-05-18  143  }

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

