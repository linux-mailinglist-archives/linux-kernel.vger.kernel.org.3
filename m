Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B247B58FB2B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 13:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234727AbiHKLRn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 07:17:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234712AbiHKLRk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 07:17:40 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F7AD9410F
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 04:17:40 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27B94ppF032381;
        Thu, 11 Aug 2022 11:11:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2022-7-12;
 bh=yZBVvmBZXyZRMHn0D66W2dy174DEHnZK/qYSxSM2F6Y=;
 b=tz4RRZZ6l9RXJ2sOCjGFsOeapthN4eIMjflCuLWDINqKJOW6zxtXIIRssqWVbteVZql5
 665nS9930X1GA7Fg/Pf1ogG+4ZLTMhOs3miYaFoGcXBsm5EQwDE/CfqqVwByEWQHjOQb
 PqSK6csdFkjH/9aw048WGVLnY1geuHPSBKW/cpE0YZTu/vLSdhqJl0eNEkxOJW7SBu0p
 OuT+i1YzNFcE8CE8oRu3tlQPLEHXU2/hM/CyKaVXfeVAt/EqXyH7IkoH6ky9/v2L2tST
 3rnZt/I5c1QNyGbFREjAfIHQW8l7jACTbQe2dPyqy42Z/mnFd3s3P1herM6epuezU683 jQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3huwq9mbcw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Aug 2022 11:11:34 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27B9OXWK035324;
        Thu, 11 Aug 2022 11:11:33 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3huwqk18y8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Aug 2022 11:11:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SkORSvSvDOcCampa8NBneUqTlRqwqe7cawyeC79lytpZnrhl4tFyjLnOfZnoS2Hch2DMtrTRb+D+CePFJtebG+5t82o/GrJ+nFCtbrJzv3unWbyY9/cu7lY4o/g4v824IBUluv5/Il49Y8mZ5sQ6TyA7OiQR28oi0rSTcLeGKQ/7e4AoV37MWCsHmKJvueUGRnLKDTxh8t3Cp9j0/QtiBHnijRN6ugnIbtUMiRY2tkfq6u7PpO5PgA0CabducIdBLdBRgO2PDxfnPHYPRXwQ2K7nLEb47gop369NWH3yEV16oGal5F3eUYLLmgztWlTwlmrg1AxOZojyYHcLX3aPGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yZBVvmBZXyZRMHn0D66W2dy174DEHnZK/qYSxSM2F6Y=;
 b=TMUPtUKjP0bBHfWD23m93PYxnBKK7m70cQMkAynHGDPircmu0b/+sI9GWCGoc/61vcWnSN3OMxVn5x20q+b1iIGotp2c+YQa85xsWRLKh24y6ChvHfWGEASfDmYtiVGtKwdTZhKdnNV4PJqcoTEElxAWlLSstx4kdV72TDWKW9kpZ7GA3BOFmZKXVg+YISKqjKh+34F7XgscPBPoEMjh93bnabw/TD9QGbOXBjB7KEvzYAlR8xgHryxK/+OJGFTEjqfMi0987vja2wVtrazT9YDMx1VLgLlppL7Rb+qodA7k3I/UjVCR7ardOO5avM8R0A/6QaHjKrCXgj8m3Bbgjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yZBVvmBZXyZRMHn0D66W2dy174DEHnZK/qYSxSM2F6Y=;
 b=oUabo2mBjltFPjgfU4AhvE7gpdV3ooRhUI/hPSxsvtVcWckgvLqhrlGjd0TKYC+xxD1NKEcWZ2IUE0f171CWGKkipMP9bKab/jRyeT88/XxVSJNLv/9ohAQjgprOtCSOIfjPUzAPEyuqt/l0+zOy9P8nMhEy4IHMjEYaauO+13c=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR1001MB2238.namprd10.prod.outlook.com
 (2603:10b6:301:2d::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.19; Thu, 11 Aug
 2022 11:11:32 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026%3]) with mapi id 15.20.5504.024; Thu, 11 Aug 2022
 11:11:32 +0000
Date:   Thu, 11 Aug 2022 14:11:20 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Subject: sound/soc/sof/ipc4-topology.c:1143 sof_ipc4_prepare_copier_module()
 error: Calling ida_alloc_max() with a 'max' argument which is a power of 2.
 -1 missing?
Message-ID: <202208110633.vYSBRTKf-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MR2P264CA0098.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:33::14) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 53aed262-5a1a-4c80-a9ff-08da7b8a3ef0
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2238:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OGtPagcCru+NMCdyi6kIhG2hNH3iHtWKyz65HMgr+DuZK1MZeGFI1QjO8b25V1LASIJhHvmwcwX5gAyHIEt3757ccIMS736smzCupruJMokdVZ+bC9uwUTfYUEfxeLwQfDThdAKHfoNKl0Rl1c35DUjqTka8ZKcZkgUdnd92QW89d1dRHpbwVhoqXjmHbwcv0XfFDMOrYgNcSjIJN71zrjp6CDvxhTmcoLT8+E8AKEsRDdC2mEjnx9TcYJ/q/fys7EC7nTY82XKLsMx2U0h+6N55+gNtJQA7QVHeVlmgJxef4rGTHUr0gUQiPO84/I4jtJDbwIwlTiHifvOsQguwArKa/GsEeBtCpDwI4nr9lNNIn7nTOCUi2Tqx9wqQqgv2S0OBAVqptER1CeYo7tTakgL2pL1h5MkVys1wG2RzMFS+Os5DciFARdaCL+Pq97hop1Mt1V4Z3GpkkIzbXv6LUxEhc3o4Ji62FGtlHOHZU7oN5Bmmdt8FklPsIJ9P1gEvlZoze/j3VRSYySrU+a5X9cvZ6o0eVVZ1GTnMpJJ1NDS0Eqls0ACDH+N+glu7sV8z0V1xrgKjbQmH6ep/NjM0lW6BO68U7E3A3F/JWVLpezCfGiX50V7SdZipXgpGQXJEofpWagudWm0CZLVCsQPTDlHuhm7gvD9nSyDeDxkRMeMrYOqKtEnJDUAUvTfJYGR6bUMpGYtfK4xlEYERjQjLNtOz/v2HSILLj5NIZMV0zAX4Hjy9tiDH/kSrqn0FjWZqyY+bZXlKIKVs6EDz9H2xswtufUUNcyL9wpCj3DWFy7e46PIbNWyX16z2/o71WlawdftuwSfLIwqSuFykB+mghP1vRUR2pCCfKb/PYFsM0HbUNL06PLvG6po3jEzBqTSH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(376002)(39860400002)(136003)(346002)(396003)(36756003)(38100700002)(86362001)(38350700002)(52116002)(6506007)(83380400001)(9686003)(6512007)(26005)(6666004)(186003)(1076003)(8676002)(478600001)(966005)(316002)(54906003)(6916009)(41300700001)(6486002)(66556008)(4326008)(5660300002)(8936002)(66476007)(66946007)(44832011)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?x+skS+Q6sDwMH4vGm/STGH7ownP+QsqTUH3SN1xpOCc4XQwglthsnL7iZw01?=
 =?us-ascii?Q?DU1Hu+gMG2oabD1hcOkltw/r/Jl0i9P4wmyW2vFnl4vn3r5M788v7D8Iwnwj?=
 =?us-ascii?Q?RwTajdqOnS8HphizDCt1Z7hEZbRmfETDR9jb1HA6MdhJ1coxTbMZD0b9ep/L?=
 =?us-ascii?Q?JEp6lM90KJ20/J1XsQd1qiTlbfBftV6Z7fwvHnhnnQAIyfCl1GFrbJGg48fb?=
 =?us-ascii?Q?usx591kLKMz7HWeyeaQli74TuDGwXTGQpNkjZMcJ+zGkXAzHOgAfaYkB/BVV?=
 =?us-ascii?Q?vYtqge1PiLJPsVPfmNvQJB0qWrgVSoHFW3fqxLbmLy4BjJLKtCKw4Zv+5+Rz?=
 =?us-ascii?Q?8euJpLOA0HEFjRxoITZ8FAdkYiyB7riL2p+KdP28gNrRtjD3l6TkcIHDpiEK?=
 =?us-ascii?Q?6/G9Hw7M1jpv6+YV7u+9/6vjwJdr4biIhYLoIzeUBwJhvXjpS2eZdYTohuZq?=
 =?us-ascii?Q?HTBMD3pc9WioYyZOpwaYEZAa7lETDFnPnwlkTzXH1JLVcoj5UiQ1ypwDDtpm?=
 =?us-ascii?Q?mxcLfswYs2rPGRSz0wmyq4qF6TJyaxkVQJ2imGLJryf9Mcj+ixiMSAcjLteQ?=
 =?us-ascii?Q?d7HpcBIaQekEO1VSxrTSSs90aTmOxLgBQrFrtY9wiSLprsNvjL1sGGmJU1K4?=
 =?us-ascii?Q?bm3EFtTqCIs6juO8QsMSDsnPCTcsytaddRI8+BcCABotHFdUwyyHB8myZ7sK?=
 =?us-ascii?Q?uBDORRu0R2H0UuNIVNPZVUXHZedM0+2BR7D3+WdpPtXiNGjsESB2dhu9QzbZ?=
 =?us-ascii?Q?6Ob7R3oA/Hqm5HMrEbEPVlvo0DTW6e1HSA1BIk89zCn8yQXJXFuUMPvZJszn?=
 =?us-ascii?Q?/oH9DEGF+BU6zRY77HNyLz2Cm+mcqLiup+9JCX83CNwhcKWXMm5E4d6G2sT1?=
 =?us-ascii?Q?WrP7CIUbV2fOb8bQ/xTefltxU1DU4z/GT6N3Wog2GGxvn+4QGJipC55Xda2P?=
 =?us-ascii?Q?6HBot/Dc6H3aPYlrVD6mS/wa87UHm/WMdRiLU3yIxCv8ovqJnLttxSInRMI3?=
 =?us-ascii?Q?cX7KBoOswAdMQkrI2J2TdKODkGdSmdUiIs4bX3HSlN3wK85WekZVLfVrYrkT?=
 =?us-ascii?Q?WLNj8XyJxaoHCJo7PxDuEyqXBKNoDyjyRaHWhwd+y3mSrEDBPodyKV0awwiQ?=
 =?us-ascii?Q?de29gWYM61q7AzHxp+5GiAg5D2E2+ueetrARv7QIvV15+kwSv11fP1MII9PM?=
 =?us-ascii?Q?nUY+uhlprt8bfv0ukplniH/Jh4ojRq94Ni8j7ABopwLfmtsq+9jkNbH7PCTG?=
 =?us-ascii?Q?/PhSLwqBLFR5OAc8F4MFeYfzUFj2VF4Qa/YCFdIOHVzyRGE/ppRQxolEC+UD?=
 =?us-ascii?Q?r446BL7i3/C6Cng0kbK9/QPSs1oMDx6Vr0A+iUDNlhIHBATuXMt8F6P22IZ7?=
 =?us-ascii?Q?VH3+gA0c8LI4mA1VB5339gO3nMecocpTxSqoL7CRdVZizRdLMBXS8eQsKYDY?=
 =?us-ascii?Q?Q7RKxqMWfPO31YiHAf+KRbn1Rf8E6G/prHKT1nP47Yn1O+mAnYarUtr26ARf?=
 =?us-ascii?Q?v2PucUWYz/ad+Yn779f8mz7UjKTqFigk1APhplkLm97OZyieVsrNTHz7JqYz?=
 =?us-ascii?Q?D9wVD6gE7odZpFihliyYcoVyeBXB+HR665eegkDtUj44cgDB76rup37dqTAu?=
 =?us-ascii?Q?QA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53aed262-5a1a-4c80-a9ff-08da7b8a3ef0
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2022 11:11:31.9259
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nsj/Uj1Fc7TYkxryoQrGw25wQT7TuxutX2AZEaYLWYedOiIk85mXiGHJzuy1buKNFwKb3OPDpFF9aap5fg+R9Xe6wjHFAzHNPptkFAMjf7o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2238
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-11_05,2022-08-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 mlxscore=0
 adultscore=0 bulkscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208110033
X-Proofpoint-ORIG-GUID: qeg1SSq-S0jeYZGWt3LbaA-ZrXq0hFr7
X-Proofpoint-GUID: qeg1SSq-S0jeYZGWt3LbaA-ZrXq0hFr7
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
head:   f41445645ab5d172e6090d00c332c335d8dba337
commit: a150345aa758492e05d2934f318ce7c2566b1cfe ASoC: SOF: ipc4-topology: add SoundWire/ALH aggregation support
config: i386-randconfig-m021-20220808 (https://download.01.org/0day-ci/archive/20220811/202208110633.vYSBRTKf-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
sound/soc/sof/ipc4-topology.c:1143 sof_ipc4_prepare_copier_module() error: Calling ida_alloc_max() with a 'max' argument which is a power of 2. -1 missing?

vim +/max +1143 sound/soc/sof/ipc4-topology.c

a150345aa75849 Bard Liao         2022-06-14  1140  			if (blob->alh_cfg.count > 1) {
a150345aa75849 Bard Liao         2022-06-14  1141  				int group_id;
a150345aa75849 Bard Liao         2022-06-14  1142  
a150345aa75849 Bard Liao         2022-06-14 @1143  				group_id = ida_alloc_max(&alh_group_ida, ALH_MULTI_GTW_COUNT,

I didn't write this Smatch check.  I guess the theory is that normally
we would want group_id to be 0-7 instead of 0-8.  But when I look at
the surrounding code I'm sort of curious why it's not 0-255?

a150345aa75849 Bard Liao         2022-06-14  1144  							 GFP_KERNEL);
a150345aa75849 Bard Liao         2022-06-14  1145  
a150345aa75849 Bard Liao         2022-06-14  1146  				if (group_id < 0)
a150345aa75849 Bard Liao         2022-06-14  1147  					return group_id;
a150345aa75849 Bard Liao         2022-06-14  1148  
a150345aa75849 Bard Liao         2022-06-14  1149  				/* add multi-gateway base */
a150345aa75849 Bard Liao         2022-06-14  1150  				group_id += ALH_MULTI_GTW_BASE;
a150345aa75849 Bard Liao         2022-06-14  1151  				copier_data->gtw_cfg.node_id &= ~SOF_IPC4_NODE_INDEX_MASK;
a150345aa75849 Bard Liao         2022-06-14  1152  				copier_data->gtw_cfg.node_id |= SOF_IPC4_NODE_INDEX(group_id);
a150345aa75849 Bard Liao         2022-06-14  1153  			}
a45a4d4390b7a5 Bard Liao         2022-06-08  1154  		}
a45a4d4390b7a5 Bard Liao         2022-06-08  1155  	}
a45a4d4390b7a5 Bard Liao         2022-06-08  1156  	}

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

