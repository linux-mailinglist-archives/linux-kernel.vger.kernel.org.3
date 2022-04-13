Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4CE34FEEAD
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 07:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232544AbiDMFsL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 01:48:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232739AbiDMFry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 01:47:54 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B46B941605
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 22:45:32 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23D1Q9vh012649;
        Wed, 13 Apr 2022 05:45:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=NuyhElnuEi3sB0vdKk9mbqa/FKV+1u9gceGNVp6xXNA=;
 b=UIrgv3ZqdgMTv5cEtr1oSNTw1UptBkmfp2nfHei5eS2ujW6WDL/LF0S8Mv4Fc1SJEVkJ
 k6rS/VsKOucOZ7EgZ4xeaxJZkdQmybzBDbr/ByyBgUDK+v6EIA4HRjW8cSnrr+l/hJYa
 fTCw9paISN7Kfz/ph+GE9Lox3xZh/+3gpHaG7Ak7I0m6yKeWcAcDL8NsKgzUUkuhwEWG
 f7fl+3e93pMwEHfFF/3zp+9eH5RnoEAYhRzRK7LQD/UGv0aeGtAYB1Bz3UWTaGnMHjLk
 hlQ3c1xKxlh7pFLPzdKgDILTKO7p8VZZTMlvyq1MZMiRVNYAVmkR5MVVkNIewevWAOFa oA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com with ESMTP id 3fb2pu101t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Apr 2022 05:45:19 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23D5gPwm001890;
        Wed, 13 Apr 2022 05:45:17 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fck13j8gc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Apr 2022 05:45:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=chOR7EZRMLn5edc2cbuL2apf906tGvOLkB3ZiZE8zUhdqeCs1t2MKge3agNJuGhOS3slPoW/8hwQ2Fh/DlxFWhFrvK31etOBwOYAG2gNDzQyjJ1Pj63sqoo+50YmMoU74t+EUcx1w10apKqdTz5fociXVedG5KFL/y55pQXQGE/E7YfBDIGrbJewhRgI3CuOc8+1VAKTcfBVsS30qBZe7jQDbIWxItOVBBbtTyCJ0KZQRDb90oWw80ajDXR87KWvKhpxaF9ALH4VM2b2kVG0VkV2lY0apyptCtWUREG/UZpFbt5K3iZ+Fi2yJs0l00HfdhpbuS65OBph0E85+KHrRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NuyhElnuEi3sB0vdKk9mbqa/FKV+1u9gceGNVp6xXNA=;
 b=ekx0UtcNNF5vaZm+CWs97TH1LxzrAtjBrZ5vwktmZMS60x9URl3FnHbrVPmyiSNT0ik/jH1YpTBqBRKFXwazERv3nU1hdEsWPMkhBxCejIAVZf9vAhhv7o+Qx6sYIRcPJ11GQzBmfKbGu/O9eRkd00nQN/8JQBmCrYyRChlwLhZXbTn0reQeShySiNHSnhFLtzPUMbvSy/aWuGDfAejZqoLT8i+hpyqwSF+bPWEaMutY+nWRRA81Zm/FLiWh7iDixN85luh3ednIpIR5Pi6SE6MpXXHcwB2GbQA9IvrAjIK8Sbg6CPvJ8r9+ESCEJveYQb708MoTPiNVZdnwFlcYJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NuyhElnuEi3sB0vdKk9mbqa/FKV+1u9gceGNVp6xXNA=;
 b=L4cQFLL7zDHgITWjSf/By5EEKj7RbuLp1cpK/2DLy+DEglgsEmQTBVbk8uDo7msvS9V+ZbJ2iVLnAxSGeoeR5JhyeeS55hqGvkpW7C/a1IIPSQOLDMqADI+I1M1zeBWPdLizuMd8OuOzOfSRa+aSnGHRoIK/V7w+GZV6EEDYJCY=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BLAPR10MB5345.namprd10.prod.outlook.com
 (2603:10b6:208:331::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.18; Wed, 13 Apr
 2022 05:45:09 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87%5]) with mapi id 15.20.5144.022; Wed, 13 Apr 2022
 05:45:08 +0000
Date:   Wed, 13 Apr 2022 08:44:58 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Jaehee Park <jhpark1013@gmail.com>
Cc:     johan@kernel.org, elder@kernel.org, gregkh@linuxfoundation.org,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, outreachy@lists.linux.dev
Subject: Re: [PATCH v3 2/2] staging: greybus: remove empty callback function
Message-ID: <20220413054458.GS12805@kadam>
References: <cover.1649824370.git.jhpark1013@gmail.com>
 <12037ae2502ad7d0311bcdf2178c3d2156293236.1649824370.git.jhpark1013@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12037ae2502ad7d0311bcdf2178c3d2156293236.1649824370.git.jhpark1013@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MR1P264CA0028.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:2f::15) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ca823467-8175-4756-1931-08da1d10c4d7
X-MS-TrafficTypeDiagnostic: BLAPR10MB5345:EE_
X-Microsoft-Antispam-PRVS: <BLAPR10MB53450AFF28C85F13DE34EE8D8EEC9@BLAPR10MB5345.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YzvLeqGZyXQ1gwCUNc8ECVmuzcXRphd6w27CU/YUiSDxkGJwDet+I+b6h5dYIkgGRCLblqs308by1hYQbPuhbdPsUWNpx543ViNQPYM8qETtesD2SSqPEtqTvlJR9ScAtQhydXAWhyGYZSOyfDkFg7pN3NPpNS258wwNhppCrpDgCwR1WpiBpbM1g3HsleA7boBd02Gh7C98h1mEYuFlyDQqLXJZbcd/zlGg3G9ypDY5UXPA/7T4RGyyJziiWt6sXF14TGjpSt7fghjGO/aqk5i4L4/Gr9DaMaU3ixTIiuEiIlJznRV9Emq8lG5n3VWaRkjKOzk9O2haCpIV0CQ0tGq+BtpMrl8CFXHJwDM/q9BOP44BlTZ/wLDvMuPpYJ+zBtO+4hmogtfBZv7sQfVYZmvSPVThEtUKDECusq2p+aREmWCfCUc5biyNFPtohxQ7SLeFDYZ8JVbzS/Xo0mGmSuPItrVLuLrax47ndhitC2GPRfFPV990FU6b0cjPiAdFKsqmcEv8KUQvUN2DLE7A3+NX+sqnV8qq0cLschQqIcxPb+z1a9rfPAn75BnAdLimUngIQmxrLaVfTabmWPx2uSOLLOp6Q3o4uriaSq+QrfA7BXWnAprNhd1OyON4kYsRyWtXof1LzyHKZDVcBN6hkEA4wpZXeApxHqqsmeRNn3Ms6GB+r0c9K2gNHQ05LCNYGPh4PCHPcUFVzjFW+g6XJw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(33656002)(508600001)(5660300002)(8936002)(44832011)(4744005)(38100700002)(38350700002)(6486002)(186003)(26005)(2906002)(52116002)(1076003)(6666004)(86362001)(9686003)(6512007)(316002)(6916009)(66476007)(4326008)(66556008)(8676002)(66946007)(33716001)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6d2aLllDU5jXH2NhK/1ArHCVlZJIZfiGNdXsLpC7GhnJxh9rGYyN8YdxtzgY?=
 =?us-ascii?Q?3KIDi0Nrxutf9CA/37IedfXzroD5jdAPw3/jLDUH12zDnSxC51oS83+jLaxC?=
 =?us-ascii?Q?3LI2zsClu4qwNpIon9Kxkc7kS0gahSbrm858rJVqoSh7Oaqyf6X4mOGvP/nj?=
 =?us-ascii?Q?wUE5Vbvq/SsKqcEI9kD3jWK6EV/CAzqUKlaBf9SQmTSIF+y29clTLiiEtl5B?=
 =?us-ascii?Q?arGfOELkUhvqF1qwmPAWgEDH30EiEyxjRoBem6RLzcJVZs8npUYr2tlGhXBu?=
 =?us-ascii?Q?7Js437u9v7pMokHUNPbW6b0DGhOP4EOqdScKGuR67G0FcKm8R9v0puC55emZ?=
 =?us-ascii?Q?Ru09wFORA5ujFd9AsoXy2jxZ39RlCV1HqHtnzkKvYfW9n5pa/EgBAhA4nHNF?=
 =?us-ascii?Q?exxCa+gfUCIJ8jvBQJIdOZlNxDDjlBexm/cDQJXrYMw6WvVtI6EWEi11XjKq?=
 =?us-ascii?Q?Dq9JYeqMzv9sjHqYBaK36IERa0U/9PfYZp91r9YBw7YvzZg6ZmODIY/fT5Oy?=
 =?us-ascii?Q?PHgWBTz/yXJ3vULkUiVU4e2xMVPukLReie+VJno3aa0fKSfPvH5YhyNHj1cs?=
 =?us-ascii?Q?V/qHfJIA7IMOAjZGMYx5E5Hy5p8qcQH3s7J6epsmRtOPkGP0KDCJQGLSe3xB?=
 =?us-ascii?Q?uGQTTITZxFXH6cS6+eet76Gyfl/EiLyRlOPEnRoFNCZ++JVJW8GAFASuqqLy?=
 =?us-ascii?Q?NHEDFVB7QAjtF+0GdEHXw+xvJSdKSBR2RAANuVrR7DmtxAZim+DgAr8uJPa5?=
 =?us-ascii?Q?RO+JfhUKDvknJl6iP2oc1jeTD+DtHuD8MqpDxYkuV8NO0upDRXtor+ZTDYNR?=
 =?us-ascii?Q?f4UN3Y2o1qE9MBZIOWceyrg/VoaXVyOch8M6S+3lXqFihLDwVRLqHEvJ3r4a?=
 =?us-ascii?Q?gXAbWuoXtRrRovy+JO4vMd5+3YUJLaFNkgkMaaTCv4biXLU6FyxijORXYHSN?=
 =?us-ascii?Q?6E6MlraOrh0+nSNSTLx83IDNAVK/lHLKGsGBW8aAZgkrRsiRCUkTvpSMmMwJ?=
 =?us-ascii?Q?9OZG0fN9p17cLOCpPRq2jt50iEN6+XtT2voFZugUxC5K36yYpA9KfAF8uuQ+?=
 =?us-ascii?Q?gjISOKlk7ne25XqqMZVa54EtFIce9/nP1m5rInvexXtI2j2af5uO51l7pbWM?=
 =?us-ascii?Q?AYlk+sj+XWUi/geO1qZmgCXjCLdnVJgILrJSFONg81ailBsyJS49JvihlEhz?=
 =?us-ascii?Q?qb1UCTnUEZamuX0k1mmjmoVS4sSH3A2MM0XAjvvs30QK1vlJfTBUC+pdY84t?=
 =?us-ascii?Q?j8m+4a9QAERPIW48zBCizv1VH0Fx+yCNXJMkKk4j5UIDWquv1SQFQlrSmYVY?=
 =?us-ascii?Q?cejmxE8R+/H7olLOhwkxRMBdvELWTPSIuWU2GbKljieaInPr3RumtbQvT3Qq?=
 =?us-ascii?Q?uzGE64eHPXRKpl6rXTTWPG0lFJgV43RbqBh07ObKSo5kXBpjmqUy7B79IGiE?=
 =?us-ascii?Q?IMErhB/E8n0LuEhvo2tC7I2TNVwRK/Bui0VvFUFoVery5RJPPclMIsGZfxr3?=
 =?us-ascii?Q?CEFkD/D4vpDSIR8V9t/qZOQUl88b2+OZGnrW7uFCVnYEMcM8MXbUtx+qicg6?=
 =?us-ascii?Q?W0qYdhzGHE5Q+WS8cYDMHfhsyMZkXzBca6djrzxrVHi9Tze13cSR86jv80nq?=
 =?us-ascii?Q?ZKna4QZ76+ZqyJ7tx9skIsrdoX8bSO8YjvaNwIASQLrT1uSImkwLzhr3cApz?=
 =?us-ascii?Q?2DJFb8Knr2Bpx10b15j6NOWToZssHSTlqSWJvAzh/xJ3W4XZY/FRrZhpuk9B?=
 =?us-ascii?Q?N7C+dB1OqD/Zu479grBdMMnWDmXmKGg=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca823467-8175-4756-1931-08da1d10c4d7
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2022 05:45:08.6865
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JVC8QQ2GuQpW2r2Ld/3IbOeqIIuj7yGpIa9XIQs+M7AduMA9yrzfRp38YmkXDf3hyZLfwjV0ZQI3bOQCawsWbplQHzd8kM2ajpyHgp0SsbQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5345
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-12_06:2022-04-11,2022-04-12 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 phishscore=0 mlxscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204130033
X-Proofpoint-ORIG-GUID: us1Xd9VyUtw0qvAT_JicBpduaTzF93UU
X-Proofpoint-GUID: us1Xd9VyUtw0qvAT_JicBpduaTzF93UU
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 13, 2022 at 12:38:52AM -0400, Jaehee Park wrote:
> Remove the optional remove callback for the soc_codec_dev_gbaudio
> structure. The only place it is referenced is
> snd_soc_component_remove() which is only called if the sound_component
> pointer is non-null. The null function pointers here can be optionally
> ommitted. When a sound component is registered this way, the remove
> callback is optional. We can safely remove the whole gbcodec_remove
> function, which used to be an empty function with a void return type.
> 
> Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Jaehee Park <jhpark1013@gmail.com>

Thanks!

regards,
dan carpenter

