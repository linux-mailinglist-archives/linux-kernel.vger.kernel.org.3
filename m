Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A599151383A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 17:24:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349061AbiD1P0R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 11:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348902AbiD1P0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 11:26:15 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53AE1B6E5A;
        Thu, 28 Apr 2022 08:23:00 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23SD0IdO003699;
        Thu, 28 Apr 2022 15:22:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=YdPsw1cJCxmfS5V5GeRV15j2hSEpEK3i5187nKj959E=;
 b=FCZ8lGOGsZlVaQazvr6xrndw1jawCQzRMFxrkgjb06gMpOOd65QeAEqhEyypKgMfvc2G
 MOaLLM+aj/paO9ol0FTLSuZ7BMHjqp4W+eYa5FQdDFyd2nzR/2XiaMdhfMT/YEC1onF/
 Cm2BJ5wX2GONke4cL1J/QQ/nGfAAzwtbzKZhW20WCl0uQ2eteftWLUN/aGjh6NHqM8qr
 Xf2ovZ87j7cUnt2Itv2+FoYyBKerjxmLqmkMPDKFbDsaGtZQi2RjxUStN1KvaA+MhMfP
 p/X0NBtsRtKGGXkTlD7IGt8pJFlWN2Kt92GsgCG4embkS3DOqJomrgKe9PjJ9CVC32YR 8A== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmbb4uxv2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Apr 2022 15:22:36 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23SFAgoJ017052;
        Thu, 28 Apr 2022 15:22:36 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fp5ynyskt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Apr 2022 15:22:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oLcbPUdF8XOrcK6bisPFjZVxwiCe/6BfH8ZvAtlDzHwZSEuY5CLLaBdXgz5wdykJtBwmMVG2plsneQaH911F/usRBulnXsSCESPZsKnMN5zv2Qvb4aTIy149qHTCC4DYwwGgWRs1yuXow2kynLQBfmIfL6A0k7L6rmd663bhlyUeqH7wXH0ucs/bLpoO6HMX8L+VJDFdSdtTMlGhzc9Y5uNEGmAve5hxmlhFNTI2hHzrZ97H6Q8VFKjbKVignqx+42Im7oIov/KA7/feESNf5geWYRq5IadoVOqJqWgK2cotgTEtjtxIPdMRoOcyW4xp8aplIrz3uwQChzzAKnC/tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YdPsw1cJCxmfS5V5GeRV15j2hSEpEK3i5187nKj959E=;
 b=X7bmmu/70X19BtUnf3GbELCLtbWUqYPQncNlQLtcPUKhTC8uIKZRu5dI6Br0uUx2MzU5sLbVIKB2nT8QiDKeONBLFcbvmSDJ0co6jQkft9PwSDDq00TaRv/vbULQe0SHC2g7luYYftXPEAMHDUwmLhgoAh1n81bPgAHTLBTOA9BwWmVaGIkRcR7bhbQf3lwGvXdGB66t+2WHLQ+RmoIyFaCXF1kaShFfr3RPLcln3WSEqP1yI3Nt9e8++wkpEwNteVBh8kCjZD6L6BzZ5QrbxV3VOdduEzHVpBKRxoz17fZ9f+45bMYt1W1ZPxyS7i/lPxDjoMA97J6mNs1veYFw9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YdPsw1cJCxmfS5V5GeRV15j2hSEpEK3i5187nKj959E=;
 b=GyHyML8hCrwDS1yoYHLcEindRmjGBbGpB8CLj8KPMr4crk8QUDTuO0UYFh3aIhoB1Nr6uDqZQQSSdy71Uzx1ILzogi53IQr3s1htYXYpZxaDT6Xf7l9REf5+Fb5k+D9+ZdoOG+nCRj2XU3sjugy94lWDIIKHjyj53xqnQJL/VBk=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by SN6PR10MB2477.namprd10.prod.outlook.com (2603:10b6:805:47::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Thu, 28 Apr
 2022 15:22:34 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::d1db:de4e:9b71:3192]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::d1db:de4e:9b71:3192%9]) with mapi id 15.20.5186.023; Thu, 28 Apr 2022
 15:22:34 +0000
To:     Xuezhi Zhang <zhangxuezhi1@coolpad.com>
Cc:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: pmcraid: convert sysfs snprintf to sysfs_emit
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq14k2djkrt.fsf@ca-mkp.ca.oracle.com>
References: <20220428070245.255827-1-zhangxuezhi1@coolpad.com>
Date:   Thu, 28 Apr 2022 11:22:31 -0400
In-Reply-To: <20220428070245.255827-1-zhangxuezhi1@coolpad.com> (Xuezhi
        Zhang's message of "Thu, 28 Apr 2022 07:02:45 +0000")
Content-Type: text/plain
X-ClientProxiedBy: DM6PR01CA0002.prod.exchangelabs.com (2603:10b6:5:296::7) To
 PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 31828ef7-fca8-49cd-a3e7-08da292aeb58
X-MS-TrafficTypeDiagnostic: SN6PR10MB2477:EE_
X-Microsoft-Antispam-PRVS: <SN6PR10MB2477B8FBDD63A1E7006EB58E8EFD9@SN6PR10MB2477.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fU3xm5pXiF8i7LqXPU8TjcBPDsCzy0J3bd+2CS6fe1svzBysPNpyU9lOFEmZYWQWFu5v+P3Z4BgSo33NXQeCSDCyJ5GC1HflhWSyvj1W3UFSVxZpomo5ENMvOQIN01gO4vqBjK1zB6XdhRK6UUZ9115ECsPkBaBGwXbVZGET6nlBV/FjYazBGElRVC/KSanupH4txlNBNoXVYGlN09NyZhI1GihQXgt5z1KV5RfU2coFZWYBY1MzmwRFG+M9+rAoK3Ms0ym22kiaMSut8D6OqIG/0SSNiWJ+0QOv8RVaMkcjRNeBQqOgLvIoHEZkvmo5oq556T+Eti/70wGm7O5lpAokJoolBNxSMSIZdAqzUmB95jX+oDYGDG7azpTrxfhrm0bDTvqX7BHpKDk3d03QakDIpBRXNJU4DgMeUrXnU9TNgCmeF+HgyJcIYMDTi5m2i8uCnyncJbFmtD6REBBMufNUJfUATHLmWZRNmDvOpbDrU7lwLf+YdejOevlzXExG3Ei9VhcFBN8aNGw8gWtZ4YpuRVFokjHG5Juv8AKI1fHzYMM1t1G/3kgBtn5S3nICN7h9/2K9+gbbNpQfiqkGPP2bGZkaq8uD6DCePlYi6lcEp22NtY0c4KckeBwNju2HKcMsP7B5jlnj7CbdHl0Vu6JctJsNdQjMsCwoY3G1/rhUYcGFKOHJdTc0yRd4jGrkh678GNa5Gbl+qpm4umSnZw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66946007)(8676002)(8936002)(4326008)(6916009)(6486002)(86362001)(2906002)(508600001)(38100700002)(38350700002)(558084003)(316002)(5660300002)(186003)(66476007)(66556008)(26005)(52116002)(36916002)(6506007)(6512007)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?O5NPhTtXWzESsmDm/dVzRL4pxjrr530PHEhna/SxNu4gfS69TiCeQQoR0PRc?=
 =?us-ascii?Q?qedgC3HE5EFb5EoJmZ8SpclbvZPug9ZFZxkNwSjsIjhEC+CZKqBEDrAjXxnA?=
 =?us-ascii?Q?vA/hNQixxtsLCuzI7B6b7UorWBWrNDpcMb+nPMlYNqE2DRHlarM3G67jIqkf?=
 =?us-ascii?Q?WXrKJ4tqPUHopfAausmSqVNw2BnWM/g6fHgHa+rAAEC8DzV4GKbYBZSJqo90?=
 =?us-ascii?Q?L0Icw0HIPQOexRvCwRbnWss6Nv9rVob20ZwSFUwjleW2EMqpKBR8g3JeWwNm?=
 =?us-ascii?Q?uiY99Yu4Kgd9IkkV0S6ftp2mtrF/UejtU3ggyTj4qsbmPUNIAW2+klAD1K+h?=
 =?us-ascii?Q?ipgcC9M/7pRkDHKhMTHH6/ImqbvavuP6X2gD0eAAGZ2r2237860hDvDTClox?=
 =?us-ascii?Q?sL5anLfXh7Kp95OIWM3zB/Q6WsBcSadZcglC4KohHw8K4C4P/aDpE6U3eyw2?=
 =?us-ascii?Q?ydWgNELorOtuMsLsPCZmIK0V/9Lz2fqg6m1wfLlyBc6F7cVV/a48IGem+vL3?=
 =?us-ascii?Q?GvkcfXBcm1iKSQrt/tgS62k0V2uBy4eOqsXe+n+PkbLv7fqvWIbu5xwtQHKi?=
 =?us-ascii?Q?xKZfDFACt15A9aZzbCESyT5knHdD6VYyO3DclAKqZy8HpJELyuX8oYc3jQ0P?=
 =?us-ascii?Q?nFYJOAkIBx0oxdCbh7Y2cxlzT67aE6KYRJQOcab9QE6HB78IHRRDgPtrSKJ8?=
 =?us-ascii?Q?VZMO2SmyC9vzXaIw9gLGunF7nM0qovzJ97OJEw2+Tyvnc6RZ8LtdbISFkpoD?=
 =?us-ascii?Q?UPj5CpsZgcXp7Rhj4EazSuMlug8rvPYiwMtD17wfsl67KipIKNRBG46mOGn6?=
 =?us-ascii?Q?wu5TeTv22yCvrYV/3llE4m3oOy/3Pgorqkrg+s5g0LnsGkgqqgGXY7TpVlx6?=
 =?us-ascii?Q?vHL8vk8ce0JmL2SffSVTQCclR5bcC98ht0BkMWH06mqK6uVnZEDmmQiYUn47?=
 =?us-ascii?Q?hrFd3oUTg3m2nnzVJcpYS4Hna5DrIYE+0zm/uxWdExCmARmHU0Zp/gcK1DfM?=
 =?us-ascii?Q?8BY6dkZbIh4n8WFQEXPRUAlO1QtLcW/ynN5F07DgeTxbOwdZjDjzLd6w+qwu?=
 =?us-ascii?Q?nbMNKpOY465o3bbjltZ4la+SLWw7FTAJgjD8tKC2p+i+vJ7P7XPkmj6jEpGi?=
 =?us-ascii?Q?2pOIVWQrSlL+pyOE69K44FdbJ+XBfS1gdrO4jYoUMAzlasp3PwDHtsXFl9QK?=
 =?us-ascii?Q?2jszVATI6zjtXkgtdvkKi3z7ZevMubMyeuhJ0iwF3k99DW+jMx4p2k6Db4z0?=
 =?us-ascii?Q?hHbb3pNwM4CXAFaulnTaVwAxx914SLcKHKZl4WxA9s89l+H2H8YRu5xdvByW?=
 =?us-ascii?Q?pZ7rUSAIf+ZbWv4qxyeRPPu84qWgddG1vUvUtojlbUrzuk0V4KYKp/bPyGRw?=
 =?us-ascii?Q?DDggM5BDvMGEjTjY4CtNNIFVDyAWdiGzNmz4AAukKA6lMe+RszbEPL2lfmrS?=
 =?us-ascii?Q?Wwv+MshEl0a0GZD7eYC0K3XxGYGSr37JiDYgZeDWU50d3x3LC8fhxBG2fmUJ?=
 =?us-ascii?Q?FRcyAioDGO4z0gbY6h6EaWNS4GnLkacKcWy1F+NW5IrS6gCVUjsBI0goftYX?=
 =?us-ascii?Q?CvbiCPDJw6AEfbFAw9QLHfHh3gig/SfpakF5PfwXQKMCWzN5eyJgqtAgcKqf?=
 =?us-ascii?Q?Et1pI8O41B07XhZdqLGgpKYvadn92Kj9ikVQzZiSzCWqJX52bm237EO7tGJy?=
 =?us-ascii?Q?NmpmElpVUeYlkUHLqY1lqCbNJFeORbAsYuT6zt/7T1XyNovtnsIPbhIj0RQt?=
 =?us-ascii?Q?GTfeQ6y5OWpUMf/5DSJui2fk97nWPA4=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31828ef7-fca8-49cd-a3e7-08da292aeb58
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2022 15:22:34.5634
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +tnzXj/7HQ2dn5RmjUiU2OlKY4Gzqd4RUc50/B1mmTZCYbEpNqfDKtSgJwRqqY5+eJjPcodqf++S6EKEpeFKfTM6jUxa2Oa9gLNP48rDy7I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2477
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-28_02:2022-04-28,2022-04-28 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=851 mlxscore=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204280092
X-Proofpoint-ORIG-GUID: hxfnDKEhrT3htF5tGhrgMZoQw6w9AfiE
X-Proofpoint-GUID: hxfnDKEhrT3htF5tGhrgMZoQw6w9AfiE
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Xuezhi,

> @@ -3554,8 +3554,7 @@ static ssize_t pmcraid_show_drv_version(
>  	char *buf
>  )
>  {
> -	return snprintf(buf, PAGE_SIZE, "version: %s\n",
> -			PMCRAID_DRIVER_VERSION);
> +	return sysfs_emt(buf, "version: %s\n", PMCRAID_DRIVER_VERSION);
               ^^^^^^^^^

-- 
Martin K. Petersen	Oracle Linux Engineering
