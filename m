Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EE7E56ACCE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 22:36:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236393AbiGGUgf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 16:36:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235850AbiGGUgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 16:36:32 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E41A248DF;
        Thu,  7 Jul 2022 13:36:29 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 267KCWWG026734;
        Thu, 7 Jul 2022 20:35:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=JEwTLRQwPwbx/HnD6Itcy6locqmh/Uv7uewcx2vF1kM=;
 b=GbvmAVZcmtXQzQuNuvlmNiaplgH5lfZh+8veqHYHFTObXvQpFfLlFIefJ1d5/MV+6qCX
 yfoI1qR+MvgcCTebyyuiVhmQ1oowm8dY28GERtKbu3n+4IfkfiedFmMpveJUXns481I5
 Q3XDBTcN/a8PC6uuplimDalCjLaRQJmiH3bWNBPSy0JUtJBOQMQZL+10hu4GPNLu9ZKK
 5hp9+kwfOLSeQnNvY4BOs2ewYiZQKenrv7uz1mGvlGCmRcWpb4d4eX/dz61UC7HetZZc
 2grN/ufjWnKHPOavJDGQp/A+wQ9B0z2NYatO16gw76E8ZxSJWFQXS/4q9+VDbKSlCEUt GQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h4ubypdnh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Jul 2022 20:35:51 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 267KVYxV012781;
        Thu, 7 Jul 2022 20:35:50 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3h4ud70qbk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Jul 2022 20:35:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hjZ7rFbnjbEVNeaCawSQD00xm7H7/9mBXkQnzarMBC8TdihPbRdDsninMBY7KXUZ3EpJziHr8+NlKqroOGN7fOZyS0vvUvaGWmXaY3YX/FC35In/ksckgLV8KucSF8fIyWmnlPAjNMvkEkHjfVFzw427yqIePIoq71bAb3M1V4mXZK+mH6SB+KKGTrguDNvydxNtMFxvR+PEYR2G4ck0j0p2+tZGQhEalKESNjO/fwxERNPrHCld5oUZ9NXDIJ8sN6NZJ3n98ZpdKENBHxSV/iAEcjDyGow1ls9VYy3VzrGGyeMiP7PulpKYZvODtBNpFMZLNI+IIgZ7M54aEHERcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JEwTLRQwPwbx/HnD6Itcy6locqmh/Uv7uewcx2vF1kM=;
 b=GlHn+AqbiMGZw8frfgsP9EFomAJxS05DJH5JavrUo3BOn++++swhusHZJyKjzRuwtmOF0bz/6L3qPYPY1j/hZcEVgHCNB9Z/OEeFl/Ej7FNcq2e3PTd92VT1sYjV5SnvFclN23AqYyKD839BvNmYOtwfaKF4IJs6UxbwumJ7EjI8j+pRZ77P6fmzPKVAa0ANMvnZTSlqqF/Uls+gwj2/G2q/Oem8YMRH7MRsl7qvAtJeMaD2EeOa0eVXWt05X+ZLHv5xxaP6ChLT1uWOuij+1kbDEJYjvG8JMfrJh762YWrFRFMzl10Uoe0Gq36WbJO107XdGNWvQldpDmeTHflYHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JEwTLRQwPwbx/HnD6Itcy6locqmh/Uv7uewcx2vF1kM=;
 b=tMwsc1WJp4wf89lWF0+qsa0ZkhtEXO+nFOZLhQx0qMr/PfBOr0ApNQCEgDUW7tzWwUeApLnvbda2GI5SO1/Jsa+4zjdUlIC9UJ+mjx4wnvK1RGyRK3nGEFxwU+QfWHma4T8TXOgRwpo+Eh7Frf1FS3SzkegWuJ8ZhhAp0XZMKyo=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by BL3PR10MB6259.namprd10.prod.outlook.com (2603:10b6:208:38e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.22; Thu, 7 Jul
 2022 20:35:48 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::6516:e908:d2bd:ca45]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::6516:e908:d2bd:ca45%6]) with mapi id 15.20.5395.022; Thu, 7 Jul 2022
 20:35:48 +0000
To:     Christoph Hellwig <hch@lst.de>
Cc:     John Garry <john.garry@huawei.com>,
        damien.lemoal@opensource.wdc.com, joro@8bytes.org, will@kernel.org,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        m.szyprowski@samsung.com, robin.murphy@arm.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ide@vger.kernel.org, iommu@lists.linux-foundation.org,
        iommu@lists.linux.dev, linux-scsi@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH v5 0/5] DMA mapping changes for SCSI core
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1y1x47jgn.fsf@ca-mkp.ca.oracle.com>
References: <1656590892-42307-1-git-send-email-john.garry@huawei.com>
        <b5f80062-e8ef-9597-1b0c-393140950dfb@huawei.com>
        <20220706134447.GA23753@lst.de>
Date:   Thu, 07 Jul 2022 16:35:41 -0400
In-Reply-To: <20220706134447.GA23753@lst.de> (Christoph Hellwig's message of
        "Wed, 6 Jul 2022 15:44:47 +0200")
Content-Type: text/plain
X-ClientProxiedBy: MN2PR19CA0029.namprd19.prod.outlook.com
 (2603:10b6:208:178::42) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7714e85e-4f4f-4b53-62c2-08da605845ac
X-MS-TrafficTypeDiagnostic: BL3PR10MB6259:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zbOJVTOL/khiyq20oecW+g96an0x8U3uZSEtjim5ID0YW9TRcfeRL6Jva8TB3Qqa8pqqNhV0hx5bkdebR6LyfdDI3YWY/YJ7U/gB7jpi7E3owZFhKOHOFSD3aU99pn0NiU7eAC3q0AtxDhvZZQutnZRqywDmsQeQCRNhx1/57HOoDd4rnMRqDhNZcK2/QxzTc3WLIN2rBQgWbp/Ejo+tHNwjbSiy058CL/WvguY8buI1DMHQLxzu1nmL7uT2KJDLB16J3hXqb4mydCTfEmWFSF87ALWXvBv23RNU7jm7uo2M3adx7J0ZJqYG+vdkQv53s962n4l1WItORray/zz5U1goX0sewzdubV+MelTbMMkkXzTaK8B16toxRuApRuIGQ6JzpIuLpCAAmvJKCCW9zur+CfuaxSKW+aURE28+9QYgDdAOCfVr/V1FkRkGVvLaVDo3qR54J+UvAdXgEUEeHZHbXNNSEPvcGYXwJySNBze0Uk7fw3Hg6s067+7150k8McL79kDlZEx8+3tiVmHkYJlyfXPayvPIgin9wUP2rK+fY+QlTxq5L3C7Bhg+zaPkDQrthHHqi+7yLpG5phhK9xiYvuc95+ACQ3Mqbp+sRaeH5DkLHwv47oACmP87mXbOnJ22iQxNQc2X2RviYzGFTfalvXqxmsZTXiLfpIxx0xRMBbgyRrStPRbUb5/M2q/Be8DZ98tJqeTXBzoS7fzDYIwOe2/oFtmsGDRkBtpWBo5t5uq2cl4OVFIdET0fFQBBrFBc7RuEnVoBcFn449OLQ5wUVCkxywfaWoJvgDVnET6y/66RjQAiXU5CVR8XA3R7
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(346002)(39860400002)(376002)(366004)(136003)(186003)(26005)(83380400001)(8676002)(4326008)(66476007)(66946007)(478600001)(4744005)(66556008)(5660300002)(7416002)(6486002)(86362001)(8936002)(316002)(38350700002)(38100700002)(2906002)(41300700001)(6666004)(52116002)(36916002)(6916009)(6512007)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UE9E9ilSzkCIB3ArhYSZw7NERCywP6yEU+vpNtD9nkeTxyzz0kynr0oE1AyB?=
 =?us-ascii?Q?OGpkhtHvOJcrih7IMn2yqPnKVCGT5OprLTYYTfCzshX4b1eJxSLBOPi55vTA?=
 =?us-ascii?Q?vn75kVCNj9p8T+1NznOjEOOnzSv4M5vUl6QKvkZ0hIktRqNeYM3ywY02SnKp?=
 =?us-ascii?Q?31c7JT64dugtSemxIx75zo0SMpIQEGKzopzchV8KfPpAicl1u5llstY4+gza?=
 =?us-ascii?Q?M3EJs3jllGN2UgoSmXx7xy2zbj9YoUAnI1Ke+9ieYqhHjHGGpnr7pTTxAYt2?=
 =?us-ascii?Q?h37vitSUd36ctdGMVDgSFD/4W4UWxwiqcuJ77HaMUe04KYSK81TNFhnThgbl?=
 =?us-ascii?Q?HVZxbMSzseC4xItS+MfNVOTTXfPjUfRmKZpz125HEcj77r+tfZyLOBxzPFsb?=
 =?us-ascii?Q?Z3+8zXBMtjXnkKu8INrzP9oxHJ0g2V7V9WKeMQ860FTcFNQtjjQtCuoE0LOL?=
 =?us-ascii?Q?EPo1z2FxdPNW+W9rMZbp000S8OC+e+mkAqVppgCnUA1waRaCBosC2zuL8YFd?=
 =?us-ascii?Q?D9ocDgMPe4dJj/lhZUixLMiAFmRhv86DFqOW8LWYtmgIkAZCCm2EjzjbKDjV?=
 =?us-ascii?Q?cAfbrvnXu2XNKeq5DwrK8jUHQLhWI3qnNyFRwJfQ2b5b4Jq1f4RJRiId9osZ?=
 =?us-ascii?Q?RGGDNdyXEkj7JhFMsNRClH1Af0tZyGd8WUDptXQ3Zaqs7jzXp80BzWBBqOTr?=
 =?us-ascii?Q?iROvDczfBfVBCsuYLWU36OPXTrZMj4m+9FJth2a2ZooKLAahzeNN2nL1z1BT?=
 =?us-ascii?Q?kySir7rjucLd23qMgDEV9JQodcWaLY2VNGf8cgrd4XY6s0WOdSp1gi8Oe7OM?=
 =?us-ascii?Q?4Fl2Q1HXl6AxymIsReozMka/sYuK2eRsHn0sJ+ncvVASjEmD+RVdacGr/5mA?=
 =?us-ascii?Q?XUAtlSgKy4TNrNKv7p9fJEiwQaeKpN16RHnhZF/ltdtfl48zVMrBe7LDfz63?=
 =?us-ascii?Q?6MDenEhwWX8Vs9ZRc9DSlkRjffH7wNxerveajONJbhOy2RUFb0id8yJKb92n?=
 =?us-ascii?Q?+Ipeo4mCHS3aoC2JkXnJW78yPCa9gVTSIS5JgkjS7C/7I+ByVTwJU9LiXRYY?=
 =?us-ascii?Q?VY6Y1mqhYcxGsH9RJqsrBams0Y4c77p6p3ZyV+0val91BFTUAgK+GbuCs3Uz?=
 =?us-ascii?Q?/vxizdq7ePCTOKqnBDsdFbByjNXy6ioW27Vss3DnP5E0Ktkc9Sn/Sc/HjHjs?=
 =?us-ascii?Q?SnqJBOK+qXAtvAMinsMi02ixOtZbK905DcLuTvysKFJbhmH+w3Lz7CjjhfxW?=
 =?us-ascii?Q?yiG8YzV+1NAOmewBZF6Gu13MUMLuQrcffO2jwrCDVrWeDNLo2EgwYOfjyunV?=
 =?us-ascii?Q?7wYWgDwuFuk/jB/CtWmwVQ13+JJdRheQ9w8/QyfWaMl0UgayjBrI4VuhLqjr?=
 =?us-ascii?Q?zyc79HmcuTs3F+9baJ4/JDcVTFQJ9yIO8mCreWKORtLqUkjHxxM9LrXOiguK?=
 =?us-ascii?Q?4rsWN8F9kFkAZr3jQa4oXkkb91lumQWX3WbQJMO8ReKgyfOaJ7ZJO1EJXB7Q?=
 =?us-ascii?Q?jRLpi0o8qORFOUZxwJ9GZfjDfjZIK99HgBTKFskTv0jZq9kmy/8uctwH9Thg?=
 =?us-ascii?Q?LbYk7SrXvsKDFmWT3kuHoo2/dsjkaDAv4uEW+I235pKCg6xmpMFY4u3F3XkV?=
 =?us-ascii?Q?ww=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7714e85e-4f4f-4b53-62c2-08da605845ac
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2022 20:35:48.0140
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UHlMYzNsmTTNyb7n73w1YpS1LMF5NHdWsuog1X1gOzDfULUFactXTfOx3dnYyiUH8NttPTgtmAqk/q31Cc5559EMfpimEQkEIa7M6QKVRLU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6259
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-07_17:2022-06-28,2022-07-07 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 adultscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207070082
X-Proofpoint-GUID: oJxmQg2oyJBFOvKz88mlYtDLBrkZQiMp
X-Proofpoint-ORIG-GUID: oJxmQg2oyJBFOvKz88mlYtDLBrkZQiMp
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Christoph,

> Yes, I've mostly been waiting for an ACK from Martin.

Sorry, I'm on vacation this week. The series looks OK to me although I
do agree that it would be great if the max was reflected in the queue's
hard limit and opt in the soft limit.

Acked-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
