Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99F7D590A40
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 04:23:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236785AbiHLCXC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 22:23:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233914AbiHLCW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 22:22:58 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6710CA261F;
        Thu, 11 Aug 2022 19:22:58 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27BN6ERL011065;
        Fri, 12 Aug 2022 02:22:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=Sqh3sfdTDZweUflOtL8Xymg+fgNu/wgI7VGcSSwiScg=;
 b=wGcPApQffrd8ZK1KFBd7Lf+njP4U+FJys6z+cda/iJvHZekV/hIFPDL7WJZZmnfNOsU/
 g6IZm88StTEDuoq+jS96F+11u6onqEIZgPVEWknEQ9n6EvtVMOEYmxqiinQVQjRFdbar
 4lRX9wZrfHUmq2TFDh98LfPecQv8cFj/OSeqyNYU0C8lUFpaNpdYLagzpCFCVBR5Awz2
 yxsbZNjE4kKyekEfE0DNqK9+9DwuspFLBMyvyAjhw0XJtL9ovLGfVPvxBqzW/U8csUyF
 wX9Lia05IrIqdIFQWBiqN/jYeMBNhxkcAIhg66fxnhlLDRpFHONS4ZJo4ZuoO8HpY1Hj 0Q== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3huwqgp4ge-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Aug 2022 02:22:47 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27C0Evkw023783;
        Fri, 12 Aug 2022 02:22:47 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2046.outbound.protection.outlook.com [104.47.56.46])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3huwqhqnf0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Aug 2022 02:22:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oBwaydjHCMXOIHdVWqflPV0NvZOk9FvDKCkRXKighwTKDWLWyTT6dLRK0maYJC+VWgFp05T1ADc/7fa6dSE7PBTs7NpDO6gSX7f95kCaOtECn6OfOz+raqNu/i8NREX/bJ+5kdCqrYEkdNROh+4UBEOdX8fU7rmh/KmBbXQZS+UuTbqqdHx45iI0a4R6l7UxrlWn7vTALFzVlhr2TQlmHTiw1tKW44bM5BD+rj/JwJrY59LDovem6rnoS28alyGHMCo+l52xb2kg87ftEnj8jWu6QtnXbzeEw/g4tYKhZFP3bqJWNA81h7bA5nABVzTUKgbjpmq8T5ABDSXllruqAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sqh3sfdTDZweUflOtL8Xymg+fgNu/wgI7VGcSSwiScg=;
 b=HFammIBjxbvgWFLAd3YqkOwmhKN127XVhPBeQB/6LQ8R387JZY8SWveeDtxxCIRErTt1DBoW/+wIgI/OZ41M/bietoRzZbMosW1zttMlfKutb6Rwru1KVFouZ79ka3nLeVOg1703LxlDRhPS77zDVgEj8PIBpA41fqBIa7SDUyPjOZaVpOhW7RuSvwopGcXFWJD0Z8YXUaeMprUU6GgNw3bOeNWZtvljHH6CoP3tcqDFCUiZlpozfA45QRsqCJsuBmCdxeK8ru3A6WarNjR2uICKMZegdx704adcogCCzxwX5INtwhokry02UE5x9D4NSht0dupFcddclp1cQKan6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sqh3sfdTDZweUflOtL8Xymg+fgNu/wgI7VGcSSwiScg=;
 b=LYMnPDhmZiTKQQs+AaamfQkoGQV9bBBLQP/7I/np+zM+VIpO9YssqMd4l0NQ2o//V4jBHkHO34z6zKfYqa2bQGRhDtwzUZVsO6K2ItVraCmvnRYTPAZgHZ3+6f1WDMexYN4VXdzd/qYsEeVMxupE04mc5fl/CUuUEfUk5vYsXpI=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by DS7PR10MB5214.namprd10.prod.outlook.com (2603:10b6:5:3a0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16; Fri, 12 Aug
 2022 02:22:45 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::89a7:ad8f:3077:f3c0]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::89a7:ad8f:3077:f3c0%8]) with mapi id 15.20.5525.010; Fri, 12 Aug 2022
 02:22:45 +0000
To:     Alim Akhtar <alim.akhtar@samsung.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        avri.altman@wdc.com, bvanassche@acm.org,
        martin.petersen@oracle.com, chanho61.park@samsung.com,
        linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH v2] scsi: ufs: host: ufs-exynos: staticize fsd_ufs_drvs
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1r11mkxp2.fsf@ca-mkp.ca.oracle.com>
References: <CGME20220811162118epcas5p2f452b3b425953d47e60e4b29868c03c9@epcas5p2.samsung.com>
        <20220811161053.54081-1-alim.akhtar@samsung.com>
Date:   Thu, 11 Aug 2022 22:22:42 -0400
In-Reply-To: <20220811161053.54081-1-alim.akhtar@samsung.com> (Alim Akhtar's
        message of "Thu, 11 Aug 2022 21:40:53 +0530")
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0189.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::14) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 73dce431-2826-423e-6dd2-08da7c098aaa
X-MS-TrafficTypeDiagnostic: DS7PR10MB5214:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7KbZLH/XnzO93wZcYf2hexWvpuB9jj//EEh8PrDP41geDUQIKsutFYDVxFZpsmcrqpnldpzvGgL6gG4GZedQsHbgGyKkFEekop/JXqIKbFkSsAuo0hIkwYM3uYcdZF1FThfXu54Tb7Ng0XEOpqvY0oXuWscsgwTBEJWqXXoSPQkIQbVhMHzvz5FisnqACOc27pSzX1dUqTytnXRj39wwssggyAOpt9/2dJwG5UnWQcd6sjCgX51oxEx3uUC1J5L2PLsiO2/4bShWxuB9w68wQgBFv+Xg2OU//dwcVLwtgoEW63E9b8oIzx+zL5qcopSg//AAlTgHG9h3PmQ/m02IMQ9arpa2/748SUqIJ5MbK6Ez1qh1Nnb62tlX97SWhymld4bJcjlQMEVLd3YNuhV1AvxwLpzNyIMJ5BVul7z+FV2GnwfNvPJePar/uPhLCtKZ1dA5xQ/MwgRSJwuK3XDk7HnMhSXV1hjXzLxT9O410Y7IgqGAQBByvAAqW2OUfpMGNnbW0oytVRn5WpOlhF3fR6kvSeOTkMxgxXDfF5lv4Dl+3Fch2/msmJwPz/efG4EV89aQT/YzUSy2HP4SuM5HAOqQdn+KyKh8T1UV3Ilzd8THVkoRFGTYGpwFbcFX7B1kuv/qFH3uqJ8XlpALTiM1vGCacnZNgBQyQrviCZVZ2qKlbk8DETFzIZk0iLr7JNkOhqTUOmxkTqHEZzYhQ678wzzv7mTZ8IWRo0qY2b3GGDwtziwXMV2le+xLWOROWYHzmdwYM8n1K80c9KF2Y9KKSmQzXCuQQAvVDI1dXIZ8iFQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(39860400002)(376002)(396003)(346002)(136003)(83380400001)(8676002)(4744005)(6916009)(66556008)(36916002)(66946007)(8936002)(66476007)(38100700002)(316002)(186003)(86362001)(4326008)(41300700001)(38350700002)(5660300002)(6512007)(26005)(52116002)(6486002)(6666004)(478600001)(6506007)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bNYMF2MngCyA4ZS2gEBFKZLoHqYi83RTdwe79Ors7tBLxb/DR8e7MBHVWms5?=
 =?us-ascii?Q?aJ5RaVZII7pcfh5Fy5GUq762+ZoyogAlWYiQ99UB8x4HB/Vl18cpBSbYDyX3?=
 =?us-ascii?Q?7ju9Ed9Z5YfCGfznDkeU+8BP6HRrJwIk9QEURpjdJHKVL4LFbByiB/HD9iDk?=
 =?us-ascii?Q?EymJO0hVAjICvzS1EKdh0zhTUBpuffCxZgusKEvo8UF4vasQ4J1C2tSsbrVL?=
 =?us-ascii?Q?bPH7iq1xT1C8dVINsDU2KTAIr6OC/nRdqsWS2NGkhsPNLVrAHO4t9yLhTvl0?=
 =?us-ascii?Q?QqiiEBl0iRdv7OzDQvg+TPaZj6fCdbCo0fArg0bXd4G/uFSXviN9sNKXyi1Q?=
 =?us-ascii?Q?E6VX6Phcj787GGQ8Jn6Xg0D5/A5+jhraq0p+Iw8629p7vCu0w0PZ70hE3VI7?=
 =?us-ascii?Q?bg7Ot5/p5BOsAJMiml8+rFkYw4XJKQ3pMX6jPG2BWJVjJ8nKB4+K9IESKuB6?=
 =?us-ascii?Q?lTDedw85jnZPQCCCijjrEWYs0LAiytVDukwgjT3/T3dOdfsrp9R9VX1ujmfL?=
 =?us-ascii?Q?nbKXWVYiQgbGlYkxWWbVUOLQ6yvRYGUWu13+OUplxus5ZggORk+/yGrYf+Zf?=
 =?us-ascii?Q?yn9h22VBfRRtB7322UgkAZK23iRH/sylfkDXBs9ZY7Kg+zV56/DTSafe61uN?=
 =?us-ascii?Q?6mbjzMIsCiijpz3t/xgDL3A6fYJJ/37mSa+9+tk+N8xI5GoZWpqS8eCgwKBJ?=
 =?us-ascii?Q?NKvxTt0ArN6qC3HemvHGdKeuF/VCfzV2p72gB/u9dZMKEZTQLEQo2Fkzl3mJ?=
 =?us-ascii?Q?vqElCuwi1MDPMxprqg3EHD4IDIlnyEgVocKTgK8v1zC4Tac8FD2prxjJnz+O?=
 =?us-ascii?Q?K8uheeFtyr/Mog0ynp1RA3qlpMNvX7PPcgvWPmKYMux/d4439UFrF09SQYBY?=
 =?us-ascii?Q?ZNBddA2WvY5aVByepmto+Bk01VMT0iuud7aJwLnuB5p6sUcDuEYspWbOSIOi?=
 =?us-ascii?Q?l7JV7fkamyVaT1w26LNoncM+TusAjpnHQ14GLzjA7dYRACQHxXPHWDLSnAxD?=
 =?us-ascii?Q?yWkkGQJi/pa1JX88iFZx1dGe76R4+AE2FUPbHNAXxlZ/ioBaHuzKzoQocbQW?=
 =?us-ascii?Q?h0l7WYbKpJMiJH+BDNmIZK/Pr+NAPbLtdfgURazMR1IszZC0XQfOIulnti8s?=
 =?us-ascii?Q?uqH5BbKfWHogTe/x00idZ/oLk5r5FknPHEkrmalkA4e47PIODJTmbmVdXRiq?=
 =?us-ascii?Q?KJwqVFWebHBTmDdcaVr+B+lU2L6ep1PpXdyGK4zSgqc3Ed5OPk4YUrUKoqkC?=
 =?us-ascii?Q?HsdLPBYPytbRLOtMYL3VqfsU6vjwTTkrr6yRM27mVdTE160DaCJOirgD0WfJ?=
 =?us-ascii?Q?z7bawz2w1PJtzlgd8vtO7Cn4CmVBTh8hORKzuJIFony0SWJ5WpCFnZqetgpi?=
 =?us-ascii?Q?s0JKKPNN79yXIa34qaql6+3U+Cw6GwiYeNtgaJOpmenKbftoHFO6dhjRqjXd?=
 =?us-ascii?Q?8B3kFvjPgDObbcVWhWcskx6DAd3bZOaf3jJQN0Y0JMIGqBxZxSQ6eG++uUJ+?=
 =?us-ascii?Q?p+MKuq2LzXEQmT9glTMW+thiSUrVnPPm6BT+7pMzaTh8AtMzsWrYL7wv0OT3?=
 =?us-ascii?Q?mYij8wq74hZXXb7MQ4Sn+g7j0oYhtnaKm2NZDxE5rP+7csy53FpnwE+iaO4z?=
 =?us-ascii?Q?Tg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73dce431-2826-423e-6dd2-08da7c098aaa
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2022 02:22:45.1196
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SZH1fj1FvZWzSIQq1tGC2ge2/X113jMUEm27irGp9K1lSJplhZd0V6d4+/5LTrDK5g7eB7VCn8LUqf1GopFgxhlM4ZktT3QlnF/nR49mvYs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5214
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-12_02,2022-08-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=989 spamscore=0
 suspectscore=0 adultscore=0 phishscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208120006
X-Proofpoint-GUID: PPW9nbPx3Pl_t1w54i7k5JvMgWdkG8SS
X-Proofpoint-ORIG-GUID: PPW9nbPx3Pl_t1w54i7k5JvMgWdkG8SS
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Alim,

> struct fsd_ufs_drvs is not used outside this file, so made it static.
> This fixes sparse warning:
>
> drivers/ufs/host/ufs-exynos.c:1721:28: sparse: sparse:
> symbol 'fsd_ufs_drvs' was not declared. Should it be static?

Applied to 5.20/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
