Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB431545C76
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 08:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346533AbiFJGnF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 02:43:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346537AbiFJGme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 02:42:34 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ECC853C7D;
        Thu,  9 Jun 2022 23:42:32 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25A1D2pf031703;
        Fri, 10 Jun 2022 06:41:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : in-reply-to : mime-version;
 s=corp-2021-07-09; bh=wYrN412p2v0VVl8om2Y+KTmV4sCguZHvIJzW0G0jlOw=;
 b=hdRXadAW2muifKKyOnrZ9SVYIMfCLZ1SJkicMBFO/ZCYcHeY4rN1nsQwFemXVT09Yu3M
 FS/cAvEUZ6OrRRbY7MwumdiHJ9XD3ZmeUxT0mAr3eojyiD4HBKiUtJ8DzBlEpfbkbMGm
 pWjl/mLJa4YroOYPRQInt2RsoSoyHC55ol8jphQmWBeBSLldfiuBYpeI3YcT/kciTcTG
 MG2js2uWZYez6QycsHBFNNebaaHufsjnCnNZ5Rc1EhD+ehypMbJD1uvGoMs8qDeg9JmW
 Qxu/Qf8lK46aPw9uCRkXpe0bXWJDOehf76xrHEk2siL0PCQTfzjx5HQeKIxWVmDsKbFX Xw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ghexejcpe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Jun 2022 06:41:59 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25A6PWHG003517;
        Fri, 10 Jun 2022 06:41:58 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gfwucmyrw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Jun 2022 06:41:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T62DnZdaOKHddfuEZDNcci0M/fQADSWVji22a8wQO9PubeqhoXwWv7RyhRhRZ3S09JBafrHCBix0r8vshzgtWijDlBabAaOeBVSTSmxXRAMBRJFhQXzKXvVfI+RI9yIjXprM4M/e+W239W0n1RSulQOeY2fxjQ5DCtAi9Y3bMx4K6qWZAgGvOeL60qHIkGSw0ohkl7LRBFfU7hXfUnnD9jKIaJVyW5Qp4qfShRt9Z0EEMwvD12+3/+PREis86lJufEMHLq+yNBt9+tBT/gh7ck8NNeDu9CH3WmJ8TdKfdqZv1gjcx1Ky0x3OtB5qTQzzsI8IgmMNr3Gq8v/3wrZE+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wYrN412p2v0VVl8om2Y+KTmV4sCguZHvIJzW0G0jlOw=;
 b=eJphIEvJqJiDpL0plXsmQr9h1Bh0QFtJb/0UAvkGhFl3PEctfdQN33U+uciBfOyZ/zTEusQ4RBjnk17aLYh3+piQ1wBdsEbBDfFbHIRzsTy5QRrrSkfQf/axee8NkuYn2SU7WN0945SR6coUEXqe4wG4ytM/Va4fVTbGbqjk4+blGG/4Sil+KDbcx/C0bJLvupIiMfKB4zXw1CksJ2yub5yYH41pE/arnxVTEe9BwnP6EUqbCipvrenb5y9WhXFuZwjF5hgte3eAcnAPihmb0dDRwsrniFDf5BfystY8k/tYYrzsu4f5UU5vPZXnem0BpsiAFZvxyJ361JUaGu3Y+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wYrN412p2v0VVl8om2Y+KTmV4sCguZHvIJzW0G0jlOw=;
 b=vuRKE/xCdt/ZDo6PrGcvKgBVr0/pHCRpUglTBRazDwOtFtBCrUte9U4B4nsiBKsqxK9hdA11Kt/3ibZtt3qT/xdEFD2p0fBJ+M6f5uiL4Mag/WoYVDD161/2oqklI8rfSeH6erohu0c2WwcGAtWHLiwtfNMd5IFYWopKx562/dg=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1998.namprd10.prod.outlook.com
 (2603:10b6:300:10c::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Fri, 10 Jun
 2022 06:41:56 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b%6]) with mapi id 15.20.5332.013; Fri, 10 Jun 2022
 06:41:56 +0000
Date:   Fri, 10 Jun 2022 09:41:43 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org,
        Christian 'Ansuel' Marangi <ansuelsmth@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Saravana Kannan <skannan@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        Christian 'Ansuel' Marangi <ansuelsmth@gmail.com>
Subject: Re: [PATCH 1/5] PM / devfreq: Fix cpufreq passive unregister
 erroring on PROBE_DEFER
Message-ID: <202206101102.4JCYtCjM-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220606111104.14534-2-ansuelsmth@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MR2P264CA0180.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501::19)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 65121890-53f3-40df-3c9b-08da4aac4f71
X-MS-TrafficTypeDiagnostic: MWHPR10MB1998:EE_
X-Microsoft-Antispam-PRVS: <MWHPR10MB1998F1928153CE70A63EAD098EA69@MWHPR10MB1998.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4QYFtkT3Q7Rvss2nL12b9aDDzJK1s5xhE0MD9TUW58GDjzbRtxQGuPcQZlP97WOxw1+XoMQ7p1Z/RwY+5VKz3xlrqJY3HfNz8hurqsi1wOoejqq/xDHPfi8nETCoKi7cQy3cEGRiX0uzi+Lihn/ttmfPUKubPPS33mrp62nJCdLWfhvKoXLXSzDI48pd82dhnEn8t/9/ELPLo8tcMCY686WicumO0W1mTFHO7S3Z/0b1yQtLfwRbgdYwI+XM3y2DTSIaDvlbqJhn2n2HE8qTEExnYaEmzraUwhFnbdIpD55n/ERxHS635WFB0gSyxIcQawDuN9SNwdrRDz5GcX6johRuHURQbSizfNSitp0vx9NHQVAJcL+8J4OEoN/VQmsQiXuPHCnJFs0dFyj6G73Cmi8DxDvDcmD/0YDOIYQ2sffOcm5vBGMTOl5bbAmSrakeLPqaEBe3YFus3KqFYERruNtF8rghyAX+pnFl77P3yIvw+TOM36J0R7uKNI1HuC5Z3me4zq6QH5uFouEkDrU9+zkBYpg4RFp2alQ0RkBCwUdjNHfes0HBQERkA+FU8FIUG5jzQbBtJEufcT7LsRXYfvxO5Ay0XkqURHiX+S6U3w4F4h8wQw6+UfJ2OcNZi5sfQM8vfBPEWU4XsEyYXhbJIUCFzX7L2w1/GMsM9oeQfEHCdjiu3msCVA1kVZT90S8oWgxA+3Nz3qh13avbtHzgK1hICp+phKcabms81imgAavt/dwwr5/eBQInC1aqmf0ux/hIlZ88pIkuNtOlCBoJ74MFTfUqy2s22dCwrEAL0PdfEoTLTWu/kfcNClygHEnJbFpgf7Pv1djRKZ/+6v9C8A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(52116002)(86362001)(66476007)(2906002)(508600001)(66556008)(966005)(9686003)(4326008)(44832011)(26005)(8936002)(6486002)(38350700002)(38100700002)(83380400001)(5660300002)(316002)(66946007)(8676002)(36756003)(1076003)(110136005)(6666004)(7416002)(6506007)(186003)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fFlP0esdMaRYfZpD4R73scy5W+iUsZeXRV+ew7sf5UKP2t3sHQZlvQy0mU+4?=
 =?us-ascii?Q?9Z0j04NHe1GB8SydY+8UbfTHv4AI2tPAc1TOW90Qq+r6MKAllareWh6sNTnw?=
 =?us-ascii?Q?ayZ7P27rKSdvz7y9FJTtdkYKswet8ReMZTaRgTgrXwM9OSudtMbjdwgrnA0h?=
 =?us-ascii?Q?5kOspzMUoKXaAwIRbOfc2wdOXDSyJzxjX7u82pv5j4eIjpUElsj7UEbf1ILT?=
 =?us-ascii?Q?OeSra0aBE3a3IU4NV1Vv8hzbs/VtZKKGwC3g18U2Sr3Z3EXjMNvNwTowNHrC?=
 =?us-ascii?Q?PA2jJw/y9qTC637m7xuWoboMhl7+wCsUm6wDY3FPLQMSmrS3k6rJe2S+lclk?=
 =?us-ascii?Q?tickWbL7V0YUb1Wnd34r/HPnrl+Vq/QYCXODsx+lzSwjFgd7sQjCgh/KyshG?=
 =?us-ascii?Q?z2vgpT9+8Lk+0M9nJ8lYl24BeQcfdD7K/kjax/8yVx4IAOQ6P0bm3bgOMJ+L?=
 =?us-ascii?Q?xui25vdBV46RNG32tVtfj73QNudSud7hBTnjBZ32BDoqG91RBq43mHtvzXXU?=
 =?us-ascii?Q?plrUyHFHn8N0gAf+gcqxl68OXfyXg/Qcqip/jU/qZ3YL3DjUOV0ZBzpfVEMH?=
 =?us-ascii?Q?a2uTIXsqLTT2EsdTgopRjXgVamRcQgBi65oqMvyBDLpUsIdsGzkvBSvvJXTv?=
 =?us-ascii?Q?0e3kGO6NftfmFKpdzulKDpVbzZZb1La4EuVecKDFWkHj2o97ot4Ltxm8/bci?=
 =?us-ascii?Q?K0NEFOdfdJMgg64Swixc/dPD9Clg8RPr8+KGLJuHeGHioAL8wBsnPUTd9Q03?=
 =?us-ascii?Q?/uF5YfjrHAlHEjGyrHapd5DvxSDXI9rAF4Yqbn6qU3Rja6MuB62mtgJtMEML?=
 =?us-ascii?Q?LeNhU7kOtWTuUKQPWFXvUivOKKiYDPDSO9doEI0/mvUqtFgcpJA4qUbdRM37?=
 =?us-ascii?Q?mrJmnE6bnFuHLRE5bU2K7QyU1WwnENDMdSn2AqGW+8oTVEo6nmiuEHjfDqI+?=
 =?us-ascii?Q?iuiyAkHVPGK14tXU4vHzLAXju235agFN6/lz7HpBc/CadOSxccsMayAW9JYt?=
 =?us-ascii?Q?ZeIuBwazf9f1Pk+RL6Y12DGItUVUwqzYld0ET3XItCnaHudhZBQfjJXmkK8r?=
 =?us-ascii?Q?4mbYhMkC2e4yevXzAwHkAIEjbXdwOGGlPoq+Gc51hE3BjS9vBP8TxJj5KHdw?=
 =?us-ascii?Q?gqJK+RJ1YshgKPH1H6azMDeGituYOf6Uvp8wiF/r5/+v71CqMeCdcrfre+Lo?=
 =?us-ascii?Q?WPKooxqrMfU2db3aCXUiDnJqiOGld0nvcF3HXtmOdUSzu95iu6ZiSM6wEIA+?=
 =?us-ascii?Q?XDZh7IitZ7juTv06Z22JjJQapCZhs9MnJ5MiGYJPeP345a1camZYED7WkLQY?=
 =?us-ascii?Q?phuMe6K6CDEdHFXobdVTaRjdW1lMXGgNKoU14whApsyCZwmF4ry2xiLWYB3E?=
 =?us-ascii?Q?RbLbHPkUuhEhc774YVZ7oRlUCMooh6c1Je45Pg9Zs0cZwFCvHVKaSvJYqz0z?=
 =?us-ascii?Q?cvX5MkXST4dRBuB/896sVfuQuUmWRdz/r0AMIt9lgPJnQ+5FPfn3KD7RNhWY?=
 =?us-ascii?Q?Ks+6XgjSpRhQnZ2Qy3/zFDk3nIHdGHUe7FBp6TWGsj/f450ROidhJ1n8unS+?=
 =?us-ascii?Q?I1bixk2DT2Wc7XooWZUO01M0l0fWrp0BvDOkrQEZskE9eLoU5nna8NsGa2H/?=
 =?us-ascii?Q?Ys5c1MUoPnoe7C+kQigKaDQQ2YDcV2YNhnjasx+n2Y9tS2AA1vgQwDW25A21?=
 =?us-ascii?Q?8WzbDllRg7DgjgM//R59eYQ9MrfKxR3NMfDTVc0gauR5BUaBST5huqNo9bkQ?=
 =?us-ascii?Q?V0P81R2Z9H/VUtPRXphJuoaWiabaQ0M=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65121890-53f3-40df-3c9b-08da4aac4f71
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2022 06:41:56.1653
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L4JM6FeK1SYj7a7rbEo0RjzNyO6PR4emd1tLFFMZGx4ZsPxIJ6wsIxGjCYGZwUWdVKCz31uk1PvvomWz++bUqpQ/NAN4TkgiV/JMVTkpwGA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1998
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-10_02:2022-06-09,2022-06-10 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 mlxscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206100022
X-Proofpoint-GUID: LR11TbDONRNYWZrB_4MTub2tIlHtYYIF
X-Proofpoint-ORIG-GUID: LR11TbDONRNYWZrB_4MTub2tIlHtYYIF
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FAKE_REPLY_C,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christian,

url:    https://github.com/intel-lab-lkp/linux/commits/Christian-Ansuel-Marangi/PM-devfreq-Various-Fixes-to-cpufreq-based-passive-governor/20220606-191335
base:   https://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git devfreq-testing
config: i386-randconfig-m021 (https://download.01.org/0day-ci/archive/20220610/202206101102.4JCYtCjM-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-1) 11.3.0

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/devfreq/governor_passive.c:235 cpufreq_passive_unregister_notifier() error: dereferencing freed memory 'parent_cpu_data'

vim +/parent_cpu_data +235 drivers/devfreq/governor_passive.c

a03dacb0316f74 Saravana Kannan            2021-03-02  221  static int cpufreq_passive_unregister_notifier(struct devfreq *devfreq)
a03dacb0316f74 Saravana Kannan            2021-03-02  222  {
a03dacb0316f74 Saravana Kannan            2021-03-02  223  	struct devfreq_passive_data *p_data
a03dacb0316f74 Saravana Kannan            2021-03-02  224  			= (struct devfreq_passive_data *)devfreq->data;
a03dacb0316f74 Saravana Kannan            2021-03-02  225  	struct devfreq_cpu_data *parent_cpu_data;
2d59e1f0c418bf Christian 'Ansuel' Marangi 2022-06-06  226  	int ret;
a03dacb0316f74 Saravana Kannan            2021-03-02  227  
a03dacb0316f74 Saravana Kannan            2021-03-02  228  	if (p_data->nb.notifier_call) {
a03dacb0316f74 Saravana Kannan            2021-03-02  229  		ret = cpufreq_unregister_notifier(&p_data->nb,
a03dacb0316f74 Saravana Kannan            2021-03-02  230  					CPUFREQ_TRANSITION_NOTIFIER);
a03dacb0316f74 Saravana Kannan            2021-03-02  231  		if (ret < 0)
a03dacb0316f74 Saravana Kannan            2021-03-02  232  			return ret;
a03dacb0316f74 Saravana Kannan            2021-03-02  233  	}
a03dacb0316f74 Saravana Kannan            2021-03-02  234  
2d59e1f0c418bf Christian 'Ansuel' Marangi 2022-06-06 @235  	list_for_each_entry(parent_cpu_data, &p_data->cpu_data_list, node) {

This needs to be list_for_each_entry_safe()

26984d9d581e50 Chanwoo Choi               2022-04-27  236  		list_del(&parent_cpu_data->node);

Otherwise it will only iterate one time

2d59e1f0c418bf Christian 'Ansuel' Marangi 2022-06-06  237  
a03dacb0316f74 Saravana Kannan            2021-03-02  238  		if (parent_cpu_data->opp_table)
a03dacb0316f74 Saravana Kannan            2021-03-02  239  			dev_pm_opp_put_opp_table(parent_cpu_data->opp_table);
2d59e1f0c418bf Christian 'Ansuel' Marangi 2022-06-06  240  
a03dacb0316f74 Saravana Kannan            2021-03-02  241  		kfree(parent_cpu_data);

And it will dereference a freed pointer

a03dacb0316f74 Saravana Kannan            2021-03-02  242  	}
a03dacb0316f74 Saravana Kannan            2021-03-02  243  
2d59e1f0c418bf Christian 'Ansuel' Marangi 2022-06-06  244  	return 0;
a03dacb0316f74 Saravana Kannan            2021-03-02  245  }

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

