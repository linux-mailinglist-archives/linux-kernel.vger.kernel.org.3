Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 993E75A14C7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 16:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242094AbiHYOrR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 10:47:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241414AbiHYOrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 10:47:11 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9460B14F7
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 07:47:10 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27PD92Ae029971;
        Thu, 25 Aug 2022 14:47:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2022-7-12;
 bh=/E2GLFK/dWycb7J6Nw8kFryoS/nTe9fFuXpV0iJ50Ms=;
 b=nm740iSJkNzENDGvTUmFrvTHFeGmPnLL70dAwL10fiHi3Fcf3t1BXVmJPyZAcZVubjk6
 kCsc4n5J1cHhPw27rpzgAftzGz1S80rLorjKI+L04gRDJgHaJdLHhGKLv0MciSL9odXI
 yp2qv+8csQXGNObXQ9WU98dSaJn8vuMOVYhS7MX0Wnt3LaoQxpeFHzo9BEp9jtk1LioK
 bjzoiIO5BYMcIoNVVdiYUr0e/O2tJbwOBQP19+YSi+exB4LUMqbJrHVS9enMjYK2+9RI
 1X0obyZZaiXI8OMO5RNam23OgUPd3zwDdV9UFoU+dLx/TbE0QDk52+16qjoXGbs3tKYn hw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j4w23xrns-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Aug 2022 14:47:07 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27PEec2D011132;
        Thu, 25 Aug 2022 14:47:05 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3j5n6mxq11-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Aug 2022 14:47:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b/bpQGoBJm26Eg/LTZjErOWt893wxmmrykFGZBKnhQ6oQStY0Vd4iIytSyRe8LUPicDINIQ5oDRZxQUfdO5y33tDxa0jCMqADmYe2GOA6ZpId6oxA2dvFMwpQehNQW7BPOrlL4Co+ZE70DVm0+FRUKgnC2KxzTHtLWwjGIu8hRCGjbLJdWUVg2wnlp8aNO6dJVZ6oljyYiPW+VqisMCoI/4k3VYnctjxoeFI1Xr26riwNXaVSDuq0h7dCmQ6iXSOIfePY/DB6Sg6RBv6qAqwD2aXP2mgEOt0XMnpYmpR0Jk2zbw5La/6kDeSiZsRm7e6iXX+n3WwVXZdbu1Up4/YqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/E2GLFK/dWycb7J6Nw8kFryoS/nTe9fFuXpV0iJ50Ms=;
 b=NgzuT2FCs70YB/qHdYYoyhBHjRhHP80Rerg+vXv40OTixduaMRCeY2HSZI8ZsHGlsdqDqm8RVzKdRrmLuKpap7RC9X8k/C86pfkUYfmfvfFpKtmJ61KQsZqMAct0OO22R7MeGeU82lvadiSulpSWFZU4UFJlLmwwAgY8excyTQOlyc1IPNWOg258l005D/Jo7/cU76tuiyibcs2RhDVyHV+N7KKSJj/uSXOIfKG2MPAWIraKLltOZw/JYbKfrwkReBFFl1gJYzJBy93+BBcYWzhfG+ijR6JUZ14whs4EFh5XQSjp7yBfLGYM/5NPuY3Dpsrb680cv2g9twttKPH9Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/E2GLFK/dWycb7J6Nw8kFryoS/nTe9fFuXpV0iJ50Ms=;
 b=HDSbM7EcOpGo44JUbmTGDh4LQhozl6iKPgxI+ecZMj7SdtUSMbtksRNMDbZtsZklP4FUrPgxYhMhc/MM8oVuPa+Rg3BR1fF16DFU3aEFHlk+rdh06+mHpM1wTzy4rm6B8QjAErBCzNkXIEs9g7jX3+PlSAhuLgtl0Q4T/p88buY=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by SN6PR10MB3439.namprd10.prod.outlook.com
 (2603:10b6:805:ce::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.19; Thu, 25 Aug
 2022 14:47:02 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026%3]) with mapi id 15.20.5546.024; Thu, 25 Aug 2022
 14:47:02 +0000
Date:   Thu, 25 Aug 2022 17:46:42 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>
Subject: drivers/gpu/drm/amd/amdgpu/../display/dc/dc_dmub_srv.c:311
 dc_dmub_srv_p_state_delegate() warn: variable dereferenced before check 'dc'
 (see line 309)
Message-ID: <202208252240.i49DVUes-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0063.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::21)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 31445962-ecb2-4b21-a1f6-08da86a8abca
X-MS-TrafficTypeDiagnostic: SN6PR10MB3439:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Epfkq7e+rJFFZB80ZSPxa5xvYX554zy9iq/FU317QdgAxT91h47Z6+m5v4yvl5zx5vK86NpIulel6ObdVanSt21HbMnOAKZJbFI6cSv8k5osCi8kum1P6qVCNMZ5R/qu6XcinZRaxLpk5qTxEEtZ9aQ5cm6gIAgcoQUZkeC/kSROvvpp+EeruJTC2/pUaJ86LrnlmMohjmZv02al/B6uY2bMxsluwzmk+fDeegN92akz9TfvcbjdzLjQJC3fExs4jB3CxVcE9CQYQJ3H29dKhXpraL10d8DAwWuEzy6My1Zbn8SritDQRVonBpElBvJFcQ0ZIK3H9gVNvxD+T1nsmbmeZYmc2NG6uh+N6f1C4r7zVJPOPoTC9TUfQDDtT2fKCq5Yvktp6ds1joDn5e2Qn2roj5sE8gSFV9cpNNoRNPk7limDigScBW6mezJkGUJuhVcRnWVHiR4paWkyCIuWfr7Xb2eYs+T6JNcc0W4X/MsAR2hpjfLZg1c3MgEMsxX8WFg9bjWSDMMglpHHpyjBfD0nbldevFCEoyNKkzjbWzEYZW4aQU2qK5XzDQmg/a+3ipAmFZQcqIc4INoxHJYdgdtET1C1sZsi/COUbOFBRIwNoQxHS1qg+xSBQBdiyJPR76VeWJShUAwV5V9vlS1n2uVQN+OrYgRZbdvEiALU7WQWItvOB4Bi/GkPzfOVGzdf5Pf3PuKd9kYbHbK7GcSpv56pkVdN6TLXdvWXmZPFywM+L4F8f28Nkfb8vAx58fMA410qDvDOckb9MeSX9V9eX7mvw90fY67B4r4ThvdrqdVXGrz8S9x7zrcydwg39YcHnGB4dIrxLE7/27t2PP/oWA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(39860400002)(366004)(346002)(376002)(396003)(44832011)(1076003)(186003)(6512007)(8676002)(4326008)(5660300002)(83380400001)(6486002)(6666004)(52116002)(41300700001)(6506007)(478600001)(26005)(36756003)(9686003)(966005)(86362001)(316002)(6916009)(66476007)(8936002)(2906002)(66946007)(38350700002)(66556008)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TatnYZ2FY1dOxZsMbvCUgUPiZC1GBWMaRxICATsCMQj2WoXfmpCEw5K3K213?=
 =?us-ascii?Q?EODjN3LvADHqqfx2OsgqOvC4/KrOuGA9CxTzcSnPG2RYexY0apUVzTwlkDc9?=
 =?us-ascii?Q?tk06HiwnoIarS+uOCyc02FH7ZBenrWAQCloSitA7mh9nDby6rRYuUmLVqep6?=
 =?us-ascii?Q?I40+3y3p5CqXyFyLi7kHbi3q5K5ZOylh71c39uWZ0sXkFEt/rXtSaiQkvgki?=
 =?us-ascii?Q?YgqnafLR1VDeFYFpRjO5R7f9WzVsisOUIDBQKj5BdmgaEsuj12dISIhk9n/i?=
 =?us-ascii?Q?BPrKTHD+FPkm2CnoM/EeKobGmqc7zu3pfQ04RDPHkfX/2Ovo0UUosK3YZMU6?=
 =?us-ascii?Q?LqN8V7QjZShLVpuL0mjNiPSzSU2UCSjfXFfWwPaSDoFZzKCQCCB54Y1XQMFD?=
 =?us-ascii?Q?UaS+SoZGmIyXBe03V4bfT8NUyv0XhD+b1bAwS76EHTR7lT37QR975J6nZxZn?=
 =?us-ascii?Q?WgCeOrG8wFw6hq+eZ+2ylV8tP509t+d1OY4XRQcUMRG/RflDyM8l2Qvxgg7Z?=
 =?us-ascii?Q?5niKz0wT3NM151ThcWMIBCsg80+ifrVhm79CvhPjEzrrKc0LKYuMAcOexvLA?=
 =?us-ascii?Q?rrxuYjuncchJh0uw/D1h9Qz5KZB5XwX2Bajebn/POLICYvIXftcw5UKaBJf5?=
 =?us-ascii?Q?ZH0O5FnXuTqObja71PQu6ogpUa5Rffh4I0wOsAaH87UqKiZFtr5dX6lxkgRJ?=
 =?us-ascii?Q?Es9DrxC/QShH/h4U8mfOHQxqLb+re+Ehi6TaT3WJFuKYAmTPDzgGWvG5skrz?=
 =?us-ascii?Q?1L38buwaUdbcgH1ayQ7YIPY/mBAodQN924PaY36zKuPw8o6IwXI+LCy8uiZf?=
 =?us-ascii?Q?nCU6b96M7h9XaGXQ3n0XkV8r720sb64FcqDQg+KbczpLnOVGq2qVHDdfvwQN?=
 =?us-ascii?Q?5P97phFDqFSYBjOyvzIHZwKnxdmk6PAAGXmJKRrDfh+/A3JXjCg4CitnX90P?=
 =?us-ascii?Q?m+pTJDA5/ktSq/kgeqUVQhSgnlkbA1OFwG5bqNdDwLgsEoaURNnLdE43+N/x?=
 =?us-ascii?Q?OWvegahSZjIukHrrhRpbfX9NPtpWTrdlGjpP9ly3neWkqlK9qiEagGekW02N?=
 =?us-ascii?Q?cL0dtArI3/+UQMEaVIsLRpOxan7kNucOiCI/afBf5NV02oz3qhP1pezLf1wl?=
 =?us-ascii?Q?XfvcBzfBQzhyb1ENtpVzRSMzRwD6PRQkD4sUIU2w2+Myqb71DRXyg1XDJYjM?=
 =?us-ascii?Q?fNcGOAQDUqn2nMg89RxqEn1LNFv8h5MXqNiedzmRenuHaVN0Qzg/2gCVfWAq?=
 =?us-ascii?Q?qwFSpcKCZ32mGB6JAyCgtzzNxj4bf2o/8m6iwxVudbHVdXAxX4jz/E6LPhOU?=
 =?us-ascii?Q?NIGoQ6EoRFj8QkzvsfR6uV86RQOkGiBUsdiVuZwi8RamAM9S6oaLFXeIL7pu?=
 =?us-ascii?Q?IVPO7BGSM031TabKOQ5LLDSaSY96vOagKt9IDDeMqCWXLPmn+hP+pGA5l7V7?=
 =?us-ascii?Q?m6kNyMs7c1cayMh33w04mWPgfN00eZ/vONPjW7pYuxd8Wo9m2bD+CFBX4Ykv?=
 =?us-ascii?Q?6fPl14HpLz7U3jNaa52wHtbrQwnnwjdJoTKZwSJOGj6WBQ5myIwMzIJCFrfC?=
 =?us-ascii?Q?lPZIYkUNXtmc7PlcFzKuzVAV303hQjnOtKKpVPKMXOYJ7zzY66YP8jyFDDk7?=
 =?us-ascii?Q?0w=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31445962-ecb2-4b21-a1f6-08da86a8abca
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2022 14:47:02.5845
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vfo53eF+yUsoD5ODbW+Ib43jomuWfu1BSqANBqlLV46dBaZIP3z9yi2m5stCrILuAbJ8IRwzxx716IQE6WF4v3j5dUckkNi+9aXTmWdXfk8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB3439
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-25_06,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208250055
X-Proofpoint-ORIG-GUID: bNh7q226iwfdKSBXF-SuQ2CJfg9VEkHz
X-Proofpoint-GUID: bNh7q226iwfdKSBXF-SuQ2CJfg9VEkHz
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   c40e8341e3b3bb27e3a65b06b5b454626234c4f0
commit: 00fa7f031dd4b885175da390e24cb02f6a45977e drm/amd/display: Add basic infrastructure for enabling FAMS
config: microblaze-randconfig-m041-20220824 (https://download.01.org/0day-ci/archive/20220825/202208252240.i49DVUes-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/gpu/drm/amd/amdgpu/../display/dc/dc_dmub_srv.c:311 dc_dmub_srv_p_state_delegate() warn: variable dereferenced before check 'dc' (see line 309)

vim +/dc +311 drivers/gpu/drm/amd/amdgpu/../display/dc/dc_dmub_srv.c

00fa7f031dd4b88 Rodrigo Siqueira 2022-06-16  303  bool dc_dmub_srv_p_state_delegate(struct dc *dc, bool should_manage_pstate, struct dc_state *context)
00fa7f031dd4b88 Rodrigo Siqueira 2022-06-16  304  {
00fa7f031dd4b88 Rodrigo Siqueira 2022-06-16  305  	union dmub_rb_cmd cmd = { 0 };
00fa7f031dd4b88 Rodrigo Siqueira 2022-06-16  306  	struct dmub_cmd_fw_assisted_mclk_switch_config *config_data = &cmd.fw_assisted_mclk_switch.config_data;
00fa7f031dd4b88 Rodrigo Siqueira 2022-06-16  307  	int i = 0;
00fa7f031dd4b88 Rodrigo Siqueira 2022-06-16  308  	int ramp_up_num_steps = 1; // TODO: Ramp is currently disabled. Reenable it.
00fa7f031dd4b88 Rodrigo Siqueira 2022-06-16 @309  	uint8_t visual_confirm_enabled = dc->debug.visual_confirm == VISUAL_CONFIRM_FAMS;
                                                                                         ^^^^^^^^^^^^^^^^^^^^^^^^
Dereference

00fa7f031dd4b88 Rodrigo Siqueira 2022-06-16  310  
00fa7f031dd4b88 Rodrigo Siqueira 2022-06-16 @311  	if (dc == NULL)
                                                            ^^^^^^^^^^
Too late

00fa7f031dd4b88 Rodrigo Siqueira 2022-06-16  312  		return false;
00fa7f031dd4b88 Rodrigo Siqueira 2022-06-16  313  
00fa7f031dd4b88 Rodrigo Siqueira 2022-06-16  314  	// Format command.
00fa7f031dd4b88 Rodrigo Siqueira 2022-06-16  315  	cmd.fw_assisted_mclk_switch.header.type = DMUB_CMD__FW_ASSISTED_MCLK_SWITCH;
00fa7f031dd4b88 Rodrigo Siqueira 2022-06-16  316  	cmd.fw_assisted_mclk_switch.header.sub_type = DMUB_CMD__FAMS_SETUP_FW_CTRL;

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

