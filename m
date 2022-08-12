Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C2F9590A26
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 04:09:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236688AbiHLCJE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 22:09:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235684AbiHLCJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 22:09:02 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D7F7A2203;
        Thu, 11 Aug 2022 19:09:01 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27BN6hLV023129;
        Fri, 12 Aug 2022 02:08:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=s2LDErmebp4ZDspyNlgMFqIAGao6srNyRv6AcBXp/Pc=;
 b=Vs8jMkTSMM5P8IDje11u3HO90y5FsohbshVS1U/ZsNybhbenCvWXmk5B137xXdI5Mjk9
 ptvsX6uZ2t1Nj5omxNLIGacV7XIRAgkFgfcbFGful4LgqTdk33BlhpjjQH0/mRdq3my+
 c6mDDXiTp81vdeGgCURENtl1Lt3qZSzgchVNHEz4CWnfOsN0Fe2wFwxjvA/5Y7svt0Wr
 0fooVdS/zq05XZ0Rccs45OjB9m3zZxX3RF4/6FWxJf+yHQqMHXtpE2ifw+IxBlIatyyc
 olJTYHXjEYwKFt8QPcqyPMHMSfDIIuybeYd4qXjKaoN6aUUXdtq18fLxSk5OneTk8Y17 dA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3huwqj67m7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Aug 2022 02:08:54 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27C0bO6g023770;
        Fri, 12 Aug 2022 02:08:53 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3huwqhqam4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Aug 2022 02:08:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KlNbRTvDgVVqXPK6spZNpAbijIreU0ZZF5oyQfdvOYEC+4booPSULsxVDfrsEQJclqcIdeeORTGLMCZ+GDF5LrezT2Ye386mAj5DPcwNhF3/uq7nymTwubxPtEw5Xcpb/dHFMRnqEsI3uFYxXTsqE4WxyHpoRy3AwtyVAB2ExfpMDevXtm0DsxYicg70FqIWV5xxOwiFfThGjang03oWR8ls3sd3B9yLqRlaVT5U8bBnz9zi346O54HX012GEwqN4wwqSAD3gkUde797B3o9LwukNtUegVFtu1gKcWpDGCoYCmV+vj7s68aVdY8RWxtwXMhZ5qfvxM3mH4JvMv0VWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s2LDErmebp4ZDspyNlgMFqIAGao6srNyRv6AcBXp/Pc=;
 b=ls24EuoeaaJZ+d575zvPrZzoohE6lfrBT/HYYU7Ap22KvhR9DUmCStyH4IkwVdyzp9yf0HaVB+oaJMCtODnP2vM80qDJzK++Wu3lwND9SxWOuNsOh7GKUFsHhukavzgFrO44gIhGKjaY6FK4Cw2IgoPplhuTYuj8FdvD2qGlT+kxVH7IT4Hv9eX0z9k4M1f1XnqR/majdFlsIxhzVXquC55V/HMi1A/XhDsmWq20VWn32rszjYgeBRDsIiYtEH1DekNA0wzrIaGVv1HMuXKsLX342auUhXW/2l1h4KeS5wiAMMG8wJz7stOvaOgTw5toza7BM2W1tS9YqyMKK+mn6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s2LDErmebp4ZDspyNlgMFqIAGao6srNyRv6AcBXp/Pc=;
 b=SPHEg+FPSlh4uNEUPd52jp60lxW/ZVT/tsJmEZj3xASRuTGfdxs7mLUQ0adJSZzQ3ztFSUNiASn8Nv2xnJEo+ZdBi0i9Xa0QhajEFUMv+bKNBXU8iop/5CThWd3zQBm0GGu7WcjMTNfmXnYa+T/7zDynK/0Cps91TVrtLVfyxfc=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by CY4PR1001MB2327.namprd10.prod.outlook.com (2603:10b6:910:43::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Fri, 12 Aug
 2022 02:08:51 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::89a7:ad8f:3077:f3c0]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::89a7:ad8f:3077:f3c0%8]) with mapi id 15.20.5525.010; Fri, 12 Aug 2022
 02:08:50 +0000
To:     Kiwoong Kim <kwmad.kim@samsung.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        alim.akhtar@samsung.com, avri.altman@wdc.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, beanhuo@micron.com,
        adrian.hunter@intel.com, sc.suh@samsung.com, hy50.seo@samsung.com,
        sh425.lee@samsung.com, bhoon95.kim@samsung.com
Subject: Re: [PATCH v2] scsi: ufs: enable link lost interrupt
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq18rnumd2w.fsf@ca-mkp.ca.oracle.com>
References: <CGME20220802014552epcas2p236519c03464ab32d9a877887710b1c10@epcas2p2.samsung.com>
        <1659404551-160958-1-git-send-email-kwmad.kim@samsung.com>
Date:   Thu, 11 Aug 2022 22:08:46 -0400
In-Reply-To: <1659404551-160958-1-git-send-email-kwmad.kim@samsung.com>
        (Kiwoong Kim's message of "Tue, 2 Aug 2022 10:42:31 +0900")
Content-Type: text/plain
X-ClientProxiedBy: DM6PR18CA0013.namprd18.prod.outlook.com
 (2603:10b6:5:15b::26) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7bcdb1c9-5caf-4541-a8fb-08da7c07995c
X-MS-TrafficTypeDiagnostic: CY4PR1001MB2327:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tNDuBfw3oCBBmTYryONyRgeBe8ynYnhnYiiXRe/xSaWElUQ9CmDN61y36wt7m4OIWZUm7m2dpWMuCiFPsa4s+LOOw6X9p5LZ1RooHCCrPh6S/spr86kOfnJIChdq4As0tDcStBzHvSsWtcZHgbJTb8wVvt6TVapbLByShcwAbPlcP8EOb6jPnHnAPD4fDBjU2bqzrGCZdVJMizUonMbKN3LhkEAY6NpLhPJ5Rvue1L5A789S2DmxJlwU+/BC+7sZzgKUnYwFpQbRu+GMG33fJPpAaw2T2A7Su5YIlU+y9jc9evgLrsNfX3Pl6Dbg/d9L8auS3vHTxazHN7AKboKIQ9tPaZwTnjZDKRFhXFzH2LHk8ZOPNVeXYET1n5baHu3irmCWLObSo0ODrRiExkEaWT7YPf8XvQmE7yJq/G/xVWr8zeykn4/5+iLaYyyaWYLCukxlb2fHOt5Axz7g2Du9scszfmEKsxkl+V0MUH1AJ1GatOq68kvxBeBcARPvSgE3pqEk+f3WgxYvexkU2FMK0IpnM5wKev9VkcGPpR5MBcDBSrKJsAymNWp2FDHcEGsSXAZBx4DrSAIxWT73DieNGVkRiPx/RYz5LaY9YS2jCFesakIKMSRM/iDCGBXms1KhA69ulYO/6MmJARAw9z399MleQfs4TvuloVbiX4Ul4n9OpPUTpxN6rfJD+kCkuzftoTQ5q1L3u8P5lNVn6v76BQvqohuV2DGLM/hkSy7iULRhDCD2PtlaXMa8kxSAAEELDivTMay0GMVljmeRp6ApzXjalY61olWW51XcvuFXd3DW/u5cLLdNuoEYlflg4N1S
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(136003)(346002)(39860400002)(366004)(396003)(41300700001)(86362001)(478600001)(6512007)(6506007)(26005)(6666004)(52116002)(36916002)(6486002)(186003)(5660300002)(4326008)(66556008)(66476007)(316002)(66946007)(8676002)(6916009)(38350700002)(38100700002)(2906002)(4744005)(7416002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XREEkwntYpIgS2IrDy4x9Xq3t8mmreuq4OiH9Q3MDcqusspTJPhddPyJrG9R?=
 =?us-ascii?Q?sz+5E7+OuElkIxxDCkNK8Fqp7EkhRXlndU8pLP6GkPr3SxAL9YB7SJtEvgq/?=
 =?us-ascii?Q?uUC+Yl+CI9IfKh3FcV76OYMe9iR8wYacjhkLbqj5znlxcMQp+MYCmbOdYhQr?=
 =?us-ascii?Q?ilUL/d4EbW25uBBQb6NU2wcrI3M0jM/+I5DgSmDpoXGap75isLfnWtGd9+Yp?=
 =?us-ascii?Q?b7ntLbeQZjP2qpmcvJhME03iNhDI2EeKpirZN9AqJXWND5b7Z/uUzM1Kpo65?=
 =?us-ascii?Q?DNdxFXqmPqiTJfi/iAljPeRNGKrIHkUzgBvM3/m/hIcTxE0WZ7/boMrwXRcT?=
 =?us-ascii?Q?hUXPOves/fZAAbJH9EoWWr0sf2oZMEjVbteh78ZPj9dkYOaiX96qjKiH3zr4?=
 =?us-ascii?Q?tS2UvJB8Rb5n9VXAiTvlIh4hPvGai9L1ByoShmyhhv71vBnj1xLG2VHPZ5Q7?=
 =?us-ascii?Q?469gM5S8HdfIHMtZh9TEkT2OiQR18CBG9pyhXE9Bu5ppy1KDJnUy4WCO4Hc4?=
 =?us-ascii?Q?uv1rF+kALv8FVE+W2cTP9QtkfKysNd89frPmHrwnLBQalsCApxjxWTsomDfr?=
 =?us-ascii?Q?FXn9B32az2YfuYgY5WEmnpwyCmIqizl9zBlN2nGtanFuyQgmttEyokMOisCP?=
 =?us-ascii?Q?pl6wprzoM4QT/T1xJ7rf+b7dw1zIEWrewQiFIP28yDR5PBXf2RlB1+ViN0X4?=
 =?us-ascii?Q?Vja6dwdgYQbW2uimM1JUisug9kI/il97vr6tYnAE1iM35PK5hqvMIAgX797z?=
 =?us-ascii?Q?IkM8HpGJ319TVsnGFcvBQsOqDLXXslGfRod5RnowVxLOzXYtoW0GNzkEJUzG?=
 =?us-ascii?Q?o5QHya6r4khQVWSf3ErNipQlyWhRAnqNS/SGAaav2ZivU3HaMCMVLjg9S7GN?=
 =?us-ascii?Q?zpkz38sQBKvIaaF10TG7L3yiPsFZlHVV2Ws84dTgj199DxrNPRx1fKJxQDr/?=
 =?us-ascii?Q?EvIw/OpiRhsn/bvCT9x3iUKKUbcFG5NshojThyHFzRQFBU1h9F+NuZfHnmCA?=
 =?us-ascii?Q?sdEhqP8g3xCJ7w6BBgaEoGCnjJCyA36IGI3wGVSsPgSdVNJSG3RL36BQ19I0?=
 =?us-ascii?Q?LaK4Or9qIJNfRo0SetlM1zhq35wsT2811m+6RKhI22MvZyWg5VvzYSo/2Aoj?=
 =?us-ascii?Q?vOhyapbRvTynSQ04YKsSqb4k6nkd9+YiP0BAO2+MDpYczEn8DXbUmKrRgkW0?=
 =?us-ascii?Q?wen9auxrarVoVTNFp9Nv6fcxiljtOOUBNavVRiXL0tZPVTP+WQjK8hRFM3tr?=
 =?us-ascii?Q?qR04UStBWKIX6X8gbbjVZQ50lTq6syAo5+HY51ni4C9CUfv4GvGqYn45mE+O?=
 =?us-ascii?Q?b3dH7mjxcFPGgTK9Ykb2ptBMpljXFKp1eb0psgydtYlhyC4vIynQuoHuaJOE?=
 =?us-ascii?Q?c7X0b5V6K40WKoukKH3u+OCxY4eq1/K3a591P8BSnym5/pgvImHOVUOOxRe9?=
 =?us-ascii?Q?/1AMwWjgbTBzFq+2W9JhR3PIwCyrJAz7xn4WpODu11I7NUOYEqwyaNfBzb/0?=
 =?us-ascii?Q?7xA2zipRpKvoo3wW3O+M9b1f+GXbFselhBtLPDp+l0ZIhd+4ReGReeIOnEX4?=
 =?us-ascii?Q?4BVk9xcIFMs0WCBvKTLMVhLNr+jBkxpeM7O48tW1z4eOxVTMWnuFywrlVPaL?=
 =?us-ascii?Q?ng=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bcdb1c9-5caf-4541-a8fb-08da7c07995c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2022 02:08:50.7822
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sZzC5t2udahODnvCKtpKwIORT0IkiU7SnCW8NHbBHx4U3M1TDN8G4Dz5BxhmsJQzQIxUY4Y4V2H60NRsxKH0psxEv2oEuCoUC6E2oXCMqAY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1001MB2327
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-12_02,2022-08-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 suspectscore=0 adultscore=0 phishscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208120005
X-Proofpoint-ORIG-GUID: LOPQN6VKTnqUQuHHL4FY11PzvxT0Wnc7
X-Proofpoint-GUID: LOPQN6VKTnqUQuHHL4FY11PzvxT0Wnc7
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Kiwoong,

> v1 -> v2: add a fixes tag

Version commentary needs to go after the patch description separated by
a triple dash.

> Link lost is treated as fatal error with the patch c99b9b2

Commit hashes need to be 12 characters long.

I fixed these up and applied to 5.20/scsi-staging.

-- 
Martin K. Petersen	Oracle Linux Engineering
