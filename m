Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 555C753E8B3
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235390AbiFFLZj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 07:25:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235315AbiFFLZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 07:25:28 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E28F15FF5
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 04:25:26 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25688NR5012680;
        Mon, 6 Jun 2022 11:19:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=+pO9AiclDSDE9GOG152bcMuLqlJWLBhWePDhJJM2I1M=;
 b=yIxTKsYwwNgDbhSm7Y5JEmHPJxpYleAAlRZHaLd6mloTq5W0PayDm3tqEJ1y2rN8qZez
 YRsIUqnziB/NLaRQkREuX10dBbAj4ainVvS91geH1h0l971uh5cEWcMlOEXBtnx1J/k8
 16K4JXNz43MGqSlFxoRuicgCBVNZ+C7WMaGCVXV+5kZFx7uKqSqKTPxIQotkVf2c4/7O
 iOIQpn8YXiuvCPfgXSDo5MpLZkCO2Z45Dow/mCpnk7jTCkyMluFVvsW6cLH0ETe19Y/8
 JyQo+uyE5qUQ8BNq6dhNq8HV/K9+HsUJiRDTkhL8KePrt1WWEzni+phEwfsErcLDC/Nj 8A== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ggvxms9kf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Jun 2022 11:19:11 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 256BGp7g008565;
        Mon, 6 Jun 2022 11:19:11 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2109.outbound.protection.outlook.com [104.47.70.109])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gfwu1c42k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Jun 2022 11:19:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C9tZPz7skFbQf00sx/1y5Bi12A+09keRTPXUneEfO5qRIhVQL5DKTYNgeLECDr9b5/Msw2BroDqutkegPr16EaJHaelxSYl6Tl5W2JzgMpbMNYFFTKEWKYJizGmYpHbCVHTTfBf8qEZxRsSQKqidCUeZ/lJ3eLek3Z22F/hHXeS6zpenLgsKMbLT51e7US4niA2yEWdoJGTBSJZVrPjonp+PSVY6jAPvENdEtdqqSTHrNsjVkQeNwW7agjhqnNNnruhgn9F1oj89TXJcKNNS5YZUxMGH49vlE/OWWZysPl7d4RDbHhXrvuzVhXBUdU91T6wSPsiy6E8XJVcgcOQ1Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+pO9AiclDSDE9GOG152bcMuLqlJWLBhWePDhJJM2I1M=;
 b=AiTx+za8A+UZa0aDwVUtKrJZtFYg6wpftPc3b4Mgkj6zB0FVlA0YQXwVdqt/A9MGNS9ZRJ4OSEV+9v5ZlyGHooaZkaD9cdHMoHF8G6nsMoOkOp7zsenrWYX+o0ba3oO1dE8LpNj+Hvnr+Q4FGJ4Be9aFcA/hMwR3deQJP7RATEQsnZXKOSWEupwNzG9ZSyEkvgj4ypaTb1tfxhLTvZZTwd4TiQkN3PZobjqsDMCVi32BGhI8sm59I+v7jW7YW8pwmOv0eBqDBFWyIe/nrE1mfJHcXw1gxcH+nNEFKHzBPXLrZcmBXmIY+4fU3Uj5hEGYP6T2CSoBfZzsLolYx/GAIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+pO9AiclDSDE9GOG152bcMuLqlJWLBhWePDhJJM2I1M=;
 b=Ok7ruH16Pz8un4Cd5L1K/npvzOUReXJKuxg2qlhhkTP0BJWEG/uBBQlxEnkdKeqYr634emVWr0cfb6/IHWgXMsa/TAS3Nn03WQHQmgePmNCkBvZKKAqH3rBqCeG+j4ADDkJ/ef8V1JnI+JwE0HDgQFPFrajlWXlANw3YSwTNxUQ=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BYAPR10MB2872.namprd10.prod.outlook.com
 (2603:10b6:a03:89::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Mon, 6 Jun
 2022 11:19:08 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b%6]) with mapi id 15.20.5314.019; Mon, 6 Jun 2022
 11:19:08 +0000
Date:   Mon, 6 Jun 2022 14:18:46 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Hector Martin <marcan@marcan.st>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Marc Zyngier <maz@kernel.org>
Subject: drivers/irqchip/irq-apple-aic.c:980 aic_of_ic_init() error:
 uninitialized symbol 'start_off'.
Message-ID: <202206011052.du9opGWF-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0012.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:3::24)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f24fe23c-1587-4096-7794-08da47ae5f64
X-MS-TrafficTypeDiagnostic: BYAPR10MB2872:EE_
X-Microsoft-Antispam-PRVS: <BYAPR10MB2872FAA9EC199618613FC4838EA29@BYAPR10MB2872.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FMMwNq2uj033maHVhVtIBkUkAa+ptncXOpSpXQjxONC2T1LHSDh8Ogy7VEUB/26buIb3NAr7OFRpuJ5Ay3pt+t2GGfgs2AyG4jifVR6yIQwPZX/yNIfg0+H6xCXB5nEYQc9fWeSqG54+RFNX9fluGdmlkQl9OYFdcbWa/FKzj+jwEfMHRyCZdze8s3nb4EZf7kcevlXtdtO0MEMs0usYXnzmQDl+MfNcSLhUb8zGJZco+2XbgN52FDThItGyH9V70BHmDbiHaIgWMj/FRUJncUfQtGgrKa8+aC+jrmIUHvTtiWUcklHfLWx3mljp5eXBpi/2uqhWzPUHpHukl0A+Il+0V1TSGE8JoPPqXbSfjRZpagkpb1IkvgASffPX7XNtfV34kUNERite/cUkmxHMIsjeeAtRhqMJf9nTOkOvXlXEyYBgT7zxRaZqAhe4gpiX6BFO+bo+HIbEo8o3jSgvP4oyUUmvlRD2VBhO26wUaQ+l0g/tT/hxw7D/DtRokeEIkLFs5X8nYaM1S977EBnSiJFswFvpKK4Qg4WcRQ3XgsSqPPPOMy+QKQOD3w2ROQk4DsJN7y2ZBNW1v4LTBp2xX4SRv6OBdWx010fe+E3D3n561ZrrU/i0tEB5V33tpMxhC7n5nrfm01F9+JndaX87wzpDh1rsYlS65aOxcnWXYH3LNcXxBYi4IDDwyotAHsR6QjzJCxgUZlfT4KJa1BvrIfuNKcDNIN+QfYReqjPq04Q6ULwws47pPBO1KAln+X+l8l5G05yPZ08By9U/JbQX3qwMmCwn9ONaDQsqW9l2pd/44Y9bQdXo5jfr66+Alo24cU3TAXgsqqfUVfuoDAbqN44FOy6O4frA1wGczADYMIo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(47660400002)(6916009)(316002)(186003)(66476007)(8676002)(66556008)(1076003)(66946007)(2906002)(6512007)(6506007)(6666004)(9686003)(44832011)(83380400001)(36756003)(52116002)(508600001)(8936002)(5660300002)(26005)(4326008)(6486002)(966005)(38100700002)(38350700002)(86362001)(46800400005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ziqUxDjLfKTwwkLHqee0CU1RavkFgCzeEidei6XguPsiD8Y60NTagj3YQjGN?=
 =?us-ascii?Q?wJym6VGaKv3khSEGDqBmAFY9DsbqLNaP+qM829UomnWxRVjiRaynjzk8td7P?=
 =?us-ascii?Q?ovlO6tBNRpa8jGiIga7Ekh2jH4Gq/F8Emnawz50RCwm2b2bHiDtuoui0jdjw?=
 =?us-ascii?Q?7jPG57c0NySDSZEUzwZ+hxi8ECYBrfF8LNv5/Aubk5pimq0H+kPRNkfi9VZk?=
 =?us-ascii?Q?DNPoBo9w9yzraJfuNmkw+AkLpZifecfycaWZEdYerVX+ThsRFpceB+T5n49E?=
 =?us-ascii?Q?bwLnHwWxHWGW0LSdfbCviLVcpM0b8wC32vLFTLMAsdIglwm22x4wlulV2SUn?=
 =?us-ascii?Q?J3i4Y/GDhdUOb24fBN8e7dPFzj/gjNqtu0I+7FIiWrWXjZ+MSd2vCh15DmtH?=
 =?us-ascii?Q?MdLS4p6QnEBNPofbKSY0yh1BaH7+6RTnIKyp3kHgoqfrPRuXSD/5lb6ku2lQ?=
 =?us-ascii?Q?t2oTKhvxuBzAepqLDaPTOhCT9EDltDbk80kKRRrStAhRIMPJ2tWF1JVDZeAo?=
 =?us-ascii?Q?fm1NSI6GpXyjpfjkPLAznlzsS9vQ0LFoBR4T3/btyd+0LJU3jaVVA7PZTxkc?=
 =?us-ascii?Q?mJeuucz0Lmml8W5ItVdlYktK0qBetSCr/MPZxZ9VbZQ99ExR8llPu9ar97NQ?=
 =?us-ascii?Q?g3XntahDjqRrBJGatcup05TmOIzdLt3UBRore3FM5MJmj9vm7h6N9QYBmuEE?=
 =?us-ascii?Q?w0nuX3aQqsRQOK+jpGSRthBGp5JcAJMYt54ZEm2cGuYyu2FSWUC+MuHce6lt?=
 =?us-ascii?Q?USBExFgU7jsn2QHO9BzdXLn+/nUfx8wIDY0abmEw6vFjolUqqLPbX4BhTv+D?=
 =?us-ascii?Q?aqTv4MDs48paCyuv9WYw2PFFiR+2Z+e99eAKS6LUE43HvsZTOcw7vqbpCkbC?=
 =?us-ascii?Q?PqTUN3JAcQ8Q49vYKhC9SrWzu28R4ikGcRHpllLKF7oTrEaJEGxWzAtqkz8O?=
 =?us-ascii?Q?Dch8SlXHt2EoM249gj8mJ3k5R5bhLmOS3gmeLb50FETJMJZdKVsX3ysgfUli?=
 =?us-ascii?Q?BahRy/34dAs9uIt+cvbvkiUe0CbIOFOTgfKis2pPgjnedvhdA0dAYd81P9kj?=
 =?us-ascii?Q?tFhRmTUnZfLLZnW8p6xaBc4vUUXWzhHst/WB1CxmhnLWhrX5ES+vtvjDQebA?=
 =?us-ascii?Q?hGxt5TZm2lVgv59pUnRmw71tZLuhg4JYPDgxJJmbwzsqIoTGj+sprq4H+V2d?=
 =?us-ascii?Q?ve9611iFkCPz97Zk3iePoPo06pvS3vA2+Lw/06g8VVRDmap38Wvm/tiB29Ev?=
 =?us-ascii?Q?Lbg4vA+YqqxrkfkPzUEQvu0VKvWQPp/RwDtTb9fnhwgZiNpUVgGratuld6V+?=
 =?us-ascii?Q?Z217OmsGhZ2Nn264O22nJWKfzxk2IKlTnyL2hMQPL4vXr5eoup51OanhS+Xv?=
 =?us-ascii?Q?eFYUO53Nw4EDevO9oLQyfdZrzvxRtxdHic4z0sVRVJnA3YInjtiKvFZJoWL8?=
 =?us-ascii?Q?YW2BiDsfpEPaTuQas4nFs3maf8TUwvLMkgbdrUxhJRlNpAff+ulsuf7ZPd+x?=
 =?us-ascii?Q?dbTEbFs3y2jaE51wg7bH/zrFHjmTPwpumk0xJ5IilWmdJwwjboVTI/8ZkaYf?=
 =?us-ascii?Q?54VHJp2+cGOWRaB52fWixnrlfZXTl5Pyt9coVcOWL0NHqz+sYl/iTlLvMNM1?=
 =?us-ascii?Q?MHkBKINa2rhZg3jt5MKiYhzU48ZEbUVK+KhfFv+2hJTgtI3GBPjCfRD7lLKs?=
 =?us-ascii?Q?xBn/KSykO2O3xbkKEpiziFK1aeXRViPHozK7Ls81vZMNggtySFHEVscw15om?=
 =?us-ascii?Q?8DeikLDzwPJXt/kGN6Wnnfk79CkB2kE=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f24fe23c-1587-4096-7794-08da47ae5f64
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2022 11:19:08.2741
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fBL4BTGelKiUe2Bm+bf0Y2ch9QDRG/h9LbDEpOMOGRhxD0LfCynEiCTCkZYIjrnqbehuoXJTSB7dhgF7N6+FhlnSUbCy/Ibs05Ay365FM18=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2872
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-06_04:2022-06-02,2022-06-06 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 adultscore=0 suspectscore=0 malwarescore=0 phishscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206060052
X-Proofpoint-GUID: bAZ7rzJs4hHwiOG-AFxu94L1BIO-22Q8
X-Proofpoint-ORIG-GUID: bAZ7rzJs4hHwiOG-AFxu94L1BIO-22Q8
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
head:   700170bf6b4d773e328fa54ebb70ba444007c702
commit: a801f0ee563b8180caf186493806a145a75b4a3c irqchip/apple-aic: Support multiple dies
config: arm64-randconfig-m031-20220530 (https://download.01.org/0day-ci/archive/20220601/202206011052.du9opGWF-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.3.0

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

New smatch warnings:
drivers/irqchip/irq-apple-aic.c:980 aic_of_ic_init() error: uninitialized symbol 'start_off'.

Old smatch warnings:
drivers/irqchip/irq-apple-aic.c:943 aic_of_ic_init() warn: possible memory leak of 'irqc'
drivers/irqchip/irq-apple-aic.c:965 aic_of_ic_init() error: uninitialized symbol 'off'.
drivers/irqchip/irq-apple-aic.c:1029 aic_of_ic_init() warn: 'regs' from of_iomap() not released on lines: 937,943.

vim +/start_off +980 drivers/irqchip/irq-apple-aic.c

76cde26394114f Hector Martin 2021-01-21   923  static int __init aic_of_ic_init(struct device_node *node, struct device_node *parent)
76cde26394114f Hector Martin 2021-01-21   924  {
a801f0ee563b81 Hector Martin 2022-03-10   925  	int i, die;
a801f0ee563b81 Hector Martin 2022-03-10   926  	u32 off, start_off;
76cde26394114f Hector Martin 2021-01-21   927  	void __iomem *regs;
76cde26394114f Hector Martin 2021-01-21   928  	struct aic_irq_chip *irqc;
2cf68211664acd Hector Martin 2022-03-10   929  	const struct of_device_id *match;
76cde26394114f Hector Martin 2021-01-21   930  
76cde26394114f Hector Martin 2021-01-21   931  	regs = of_iomap(node, 0);
76cde26394114f Hector Martin 2021-01-21   932  	if (WARN_ON(!regs))
76cde26394114f Hector Martin 2021-01-21   933  		return -EIO;
76cde26394114f Hector Martin 2021-01-21   934  
76cde26394114f Hector Martin 2021-01-21   935  	irqc = kzalloc(sizeof(*irqc), GFP_KERNEL);
76cde26394114f Hector Martin 2021-01-21   936  	if (!irqc)
76cde26394114f Hector Martin 2021-01-21   937  		return -ENOMEM;
76cde26394114f Hector Martin 2021-01-21   938  
76cde26394114f Hector Martin 2021-01-21   939  	irqc->base = regs;
76cde26394114f Hector Martin 2021-01-21   940  
2cf68211664acd Hector Martin 2022-03-10   941  	match = of_match_node(aic_info_match, node);
2cf68211664acd Hector Martin 2022-03-10   942  	if (!match)
2cf68211664acd Hector Martin 2022-03-10   943  		return -ENODEV;

ret = -ENOMEM;
goto err_free_irqc;

2cf68211664acd Hector Martin 2022-03-10   944  
2cf68211664acd Hector Martin 2022-03-10   945  	irqc->info = *(struct aic_info *)match->data;
2cf68211664acd Hector Martin 2022-03-10   946  
2cf68211664acd Hector Martin 2022-03-10   947  	aic_irqc = irqc;
2cf68211664acd Hector Martin 2022-03-10   948  
dc97fd6fec0099 Hector Martin 2022-03-10   949  	switch (irqc->info.version) {
dc97fd6fec0099 Hector Martin 2022-03-10   950  	case 1: {
dc97fd6fec0099 Hector Martin 2022-03-10   951  		u32 info;
dc97fd6fec0099 Hector Martin 2022-03-10   952  
76cde26394114f Hector Martin 2021-01-21   953  		info = aic_ic_read(irqc, AIC_INFO);
7c841f5f6fa3f9 Hector Martin 2022-03-10   954  		irqc->nr_irq = FIELD_GET(AIC_INFO_NR_IRQ, info);
dc97fd6fec0099 Hector Martin 2022-03-10   955  		irqc->max_irq = AIC_MAX_IRQ;
a801f0ee563b81 Hector Martin 2022-03-10   956  		irqc->nr_die = irqc->max_die = 1;
dc97fd6fec0099 Hector Martin 2022-03-10   957  
a801f0ee563b81 Hector Martin 2022-03-10   958  		off = start_off = irqc->info.target_cpu;
dc97fd6fec0099 Hector Martin 2022-03-10   959  		off += sizeof(u32) * irqc->max_irq; /* TARGET_CPU */
dc97fd6fec0099 Hector Martin 2022-03-10   960  
dc97fd6fec0099 Hector Martin 2022-03-10   961  		break;
dc97fd6fec0099 Hector Martin 2022-03-10   962  	}
dc97fd6fec0099 Hector Martin 2022-03-10   963  	}
dc97fd6fec0099 Hector Martin 2022-03-10   964  
dc97fd6fec0099 Hector Martin 2022-03-10   965  	irqc->info.sw_set = off;
dc97fd6fec0099 Hector Martin 2022-03-10   966  	off += sizeof(u32) * (irqc->max_irq >> 5); /* SW_SET */
dc97fd6fec0099 Hector Martin 2022-03-10   967  	irqc->info.sw_clr = off;
dc97fd6fec0099 Hector Martin 2022-03-10   968  	off += sizeof(u32) * (irqc->max_irq >> 5); /* SW_CLR */
dc97fd6fec0099 Hector Martin 2022-03-10   969  	irqc->info.mask_set = off;
dc97fd6fec0099 Hector Martin 2022-03-10   970  	off += sizeof(u32) * (irqc->max_irq >> 5); /* MASK_SET */
dc97fd6fec0099 Hector Martin 2022-03-10   971  	irqc->info.mask_clr = off;
dc97fd6fec0099 Hector Martin 2022-03-10   972  	off += sizeof(u32) * (irqc->max_irq >> 5); /* MASK_CLR */
dc97fd6fec0099 Hector Martin 2022-03-10   973  	off += sizeof(u32) * (irqc->max_irq >> 5); /* HW_STATE */
76cde26394114f Hector Martin 2021-01-21   974  
2cf68211664acd Hector Martin 2022-03-10   975  	if (irqc->info.fast_ipi)
2cf68211664acd Hector Martin 2022-03-10   976  		static_branch_enable(&use_fast_ipi);
2cf68211664acd Hector Martin 2022-03-10   977  	else
2cf68211664acd Hector Martin 2022-03-10   978  		static_branch_disable(&use_fast_ipi);
2cf68211664acd Hector Martin 2022-03-10   979  
a801f0ee563b81 Hector Martin 2022-03-10  @980  	irqc->info.die_stride = off - start_off;
a801f0ee563b81 Hector Martin 2022-03-10   981  
7c841f5f6fa3f9 Hector Martin 2022-03-10   982  	irqc->hw_domain = irq_domain_create_tree(of_node_to_fwnode(node),
76cde26394114f Hector Martin 2021-01-21   983  						 &aic_irq_domain_ops, irqc);
76cde26394114f Hector Martin 2021-01-21   984  	if (WARN_ON(!irqc->hw_domain)) {
76cde26394114f Hector Martin 2021-01-21   985  		iounmap(irqc->base);
76cde26394114f Hector Martin 2021-01-21   986  		kfree(irqc);
76cde26394114f Hector Martin 2021-01-21   987  		return -ENODEV;

ret = -ENODEV;
goto err_unmap;

76cde26394114f Hector Martin 2021-01-21   988  	}
76cde26394114f Hector Martin 2021-01-21   989  
76cde26394114f Hector Martin 2021-01-21   990  	irq_domain_update_bus_token(irqc->hw_domain, DOMAIN_BUS_WIRED);
76cde26394114f Hector Martin 2021-01-21   991  
76cde26394114f Hector Martin 2021-01-21   992  	if (aic_init_smp(irqc, node)) {
76cde26394114f Hector Martin 2021-01-21   993  		irq_domain_remove(irqc->hw_domain);
76cde26394114f Hector Martin 2021-01-21   994  		iounmap(irqc->base);
76cde26394114f Hector Martin 2021-01-21   995  		kfree(irqc);
76cde26394114f Hector Martin 2021-01-21   996  		return -ENODEV;

ret = -ENODEV;
goto err_remove_domain;

76cde26394114f Hector Martin 2021-01-21   997  	}
76cde26394114f Hector Martin 2021-01-21   998  
76cde26394114f Hector Martin 2021-01-21   999  	set_handle_irq(aic_handle_irq);
76cde26394114f Hector Martin 2021-01-21  1000  	set_handle_fiq(aic_handle_fiq);
76cde26394114f Hector Martin 2021-01-21  1001  
a801f0ee563b81 Hector Martin 2022-03-10  1002  	off = 0;
a801f0ee563b81 Hector Martin 2022-03-10  1003  	for (die = 0; die < irqc->nr_die; die++) {
7c841f5f6fa3f9 Hector Martin 2022-03-10  1004  		for (i = 0; i < BITS_TO_U32(irqc->nr_irq); i++)
a801f0ee563b81 Hector Martin 2022-03-10  1005  			aic_ic_write(irqc, irqc->info.mask_set + off + i * 4, U32_MAX);
7c841f5f6fa3f9 Hector Martin 2022-03-10  1006  		for (i = 0; i < BITS_TO_U32(irqc->nr_irq); i++)
a801f0ee563b81 Hector Martin 2022-03-10  1007  			aic_ic_write(irqc, irqc->info.sw_clr + off + i * 4, U32_MAX);
a801f0ee563b81 Hector Martin 2022-03-10  1008  		if (irqc->info.target_cpu)
7c841f5f6fa3f9 Hector Martin 2022-03-10  1009  			for (i = 0; i < irqc->nr_irq; i++)
a801f0ee563b81 Hector Martin 2022-03-10  1010  				aic_ic_write(irqc, irqc->info.target_cpu + off + i * 4, 1);
a801f0ee563b81 Hector Martin 2022-03-10  1011  		off += irqc->info.die_stride;
a801f0ee563b81 Hector Martin 2022-03-10  1012  	}
76cde26394114f Hector Martin 2021-01-21  1013  
76cde26394114f Hector Martin 2021-01-21  1014  	if (!is_kernel_in_hyp_mode())
76cde26394114f Hector Martin 2021-01-21  1015  		pr_info("Kernel running in EL1, mapping interrupts");
76cde26394114f Hector Martin 2021-01-21  1016  
2cf68211664acd Hector Martin 2022-03-10  1017  	if (static_branch_likely(&use_fast_ipi))
2cf68211664acd Hector Martin 2022-03-10  1018  		pr_info("Using Fast IPIs");
2cf68211664acd Hector Martin 2022-03-10  1019  
76cde26394114f Hector Martin 2021-01-21  1020  	cpuhp_setup_state(CPUHP_AP_IRQ_APPLE_AIC_STARTING,
76cde26394114f Hector Martin 2021-01-21  1021  			  "irqchip/apple-aic/ipi:starting",
76cde26394114f Hector Martin 2021-01-21  1022  			  aic_init_cpu, NULL);
76cde26394114f Hector Martin 2021-01-21  1023  
b6ca556c352979 Marc Zyngier  2021-02-28  1024  	vgic_set_kvm_info(&vgic_info);
b6ca556c352979 Marc Zyngier  2021-02-28  1025  
a801f0ee563b81 Hector Martin 2022-03-10  1026  	pr_info("Initialized with %d/%d IRQs * %d/%d die(s), %d FIQs, %d vIPIs",
a801f0ee563b81 Hector Martin 2022-03-10  1027  		irqc->nr_irq, irqc->max_irq, irqc->nr_die, irqc->max_die, AIC_NR_FIQ, AIC_NR_SWIPI);
76cde26394114f Hector Martin 2021-01-21  1028  
76cde26394114f Hector Martin 2021-01-21  1029  	return 0;

	return 0;

err_remove_domain:
	irq_domain_remove(irqc->hw_domain);
err_unmap:
	iounmap(irqc->base);
err_free_irqc:
	kfree(irqc);

	return ret;

76cde26394114f Hector Martin 2021-01-21  1030  }
76cde26394114f Hector Martin 2021-01-21  1031  
-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

