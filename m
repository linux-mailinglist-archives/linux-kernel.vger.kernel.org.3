Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 187BF5874A0
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 02:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234902AbiHBABi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 20:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbiHBABg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 20:01:36 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F59D33A11;
        Mon,  1 Aug 2022 17:01:35 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 271NxEre005068;
        Tue, 2 Aug 2022 00:01:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=1WhHY8jsfXFhfBGA9LfLvDPuHQC91JuQeacrbIWhuxQ=;
 b=pOmYMg9zTe0s4bqgQJK2VWhmMut4X7YVsytXotX+Vi5AZh5PMsP3T6iivq2MGXHrHsLz
 UHPNofq/O6whYHaxBGPkXUuMBVz5og8brLk8j1zt6GHemqLEeq0jA/UDh3AyaAmJ0xmf
 50ZVc92Q6j8pWYagB1P+19G36HawCEJPHSHnqT2nkBlsUr6gLWoGix4lHSFs57onue/0
 WEqhvE+UPzYChkLI5dshfZZDitEZPZVG/FzdT+rFZfxuPjlqNa3rdxvdqshOf4gXeske
 bisYnLEjtAKxrmkwbOAwypN3EXfvzZJm1xani6oUKSxKVyAni1SuY7Ps8zFDSnvxzd8r 3w== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hmu80w8we-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Aug 2022 00:01:16 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 271Mu5Fj014185;
        Tue, 2 Aug 2022 00:01:14 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hmu31t7eq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Aug 2022 00:01:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NT7x8oRYyKqNxEHAXGNABsOaa6jMH8cVz9FO6IQMZCG69uoYEDMvv0RpfXiUAAVX4j2/UggDQlm+cVQPsy/ARkAOdWIiMS49coAFmKysk86Xp31i6mFWAvikvpT2xrLTFPfqM6WSXiygAXZtemKo8wrXoJAS5KzBIHfLLz/o9SexMX8cCTpt3SicbXIPAdc8P+9jF643xn+knPUai3BitdGB8cZdJfbw3XjO3Jo9NRwVe/eygNfxtE/pRVJTVqbEdWgsfSxZxQGPpyfYvAVpW6+Q+3zi6enRi/LBR/B7unyRqp7NuhMLV1KXmA7qDhwB+kmMrfituWvsPy4v4yIWQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1WhHY8jsfXFhfBGA9LfLvDPuHQC91JuQeacrbIWhuxQ=;
 b=jX0/vCBlGJAF3KWBK27JXNNACeFi3vm4gSw+aoVugap5VxKybnr54fkODRpAWMhavi4XyA2ggE7d9FIVgeLq0omEc5Enr0uizPQGNTpmGhy8Q8G7w7Q73HNiO5MYqkemqaNhQkbiHUyhWoCewCQ/Ib2UmeHnfdL4NBb99Gzn0XLq8bH/TgDbdO2Kkm7kJGb+OEb9Uwr3UEnVWb62Ptc3XnYhSq2PpoRdRIiOGkwZJBcydW3YRLyCVR9dUY6N1Y4YOElFjftx+1yc8Dp2S6kVKOwqWlB83DONWTosZY7q1iaJ04OorixnLHI6QWV6qtQeH5z3In+GmmFklARoA0iIPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1WhHY8jsfXFhfBGA9LfLvDPuHQC91JuQeacrbIWhuxQ=;
 b=psJ6DFMD/Cy0DmLrVZ1Z+BeHlMmKqAo62Q+YqYL3tmC79z8Cy1qfIwj7diougjDUB1NteERBpwohnBAyDJiIgungFHVn4C/Iabu8pJWGtyldK7IQ0d4is7FgI++CmlozmK3oq0N10TTteZiSfB59HWQYd7nmgu5Zs8cmQNf82kM=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by PH7PR10MB5815.namprd10.prod.outlook.com (2603:10b6:510:126::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.16; Tue, 2 Aug
 2022 00:01:12 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::6516:e908:d2bd:ca45]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::6516:e908:d2bd:ca45%5]) with mapi id 15.20.5482.016; Tue, 2 Aug 2022
 00:01:12 +0000
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, zhangwensheng5@huawei.com, yi.zhang@huawei.com
Subject: Re: [PATCH -next] [RFC] scsi: ses: fix slab-out-of-bounds in
 ses_enclosure_data_process
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1edxz349n.fsf@ca-mkp.ca.oracle.com>
References: <20220713094548.3958915-1-yukuai1@huaweicloud.com>
Date:   Mon, 01 Aug 2022 20:01:06 -0400
In-Reply-To: <20220713094548.3958915-1-yukuai1@huaweicloud.com> (Yu Kuai's
        message of "Wed, 13 Jul 2022 17:45:48 +0800")
Content-Type: text/plain
X-ClientProxiedBy: DS7PR07CA0018.namprd07.prod.outlook.com
 (2603:10b6:5:3af::27) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2e0ffce9-4c2f-4fb3-3e78-08da741a1c92
X-MS-TrafficTypeDiagnostic: PH7PR10MB5815:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /cyRV+fF8ruMqEz1/Fzo487Nu2Nn/vRfnfHXUaQybJMPzEo9srvHBW7KYOiz5R31yrbET/SS/ZaQkVaCVuJhtS0uaYL4Xgj74CcDZagwbvDW3u7yUYCgPsfblmpZR0mWteJ4QpVtbzyosE+fAF4XrNRhbdbAmiM+hX7Oca5Gtf//ubnV5TMCW2dxU9JRJnotZsrk7znSJ8aygIfT48WdA53f3afAXsuPGidBl4VjeY+FRZJ6Ocmqb+BROZzvwXrnlLKTXQyA4gtLNESLAIYdmV3d3Vva7AA5fcT+JNVGbkdHl2hTfgZ6pxKVHa9VvHigJxbZl/Jmt4NSlvtlovqMpdHH6oF0xCkhXKzvkBadJHcooa4UICprcQ62HJ6KMtyb57KJsptVzbeTJtFt//OEUvso4ousZIwxkx6/9VH/yBWPQW8QuYBnne+SDZpqHSM1ZUMVqZBaqGMAecxwSiEwL+SdMD0kzbiGtA9X+4JdGcbLgrGlu6boymnM9bg86kgQAW8FWyR0upLVypXew6yU60KqEno1eQFic2QCeh14wihcnSdDa/lvnS/3mqDeDxtTR1yEsqawmgLNi6suRoSNka2V8n5ec1tYRFmx0cxV5JFOIjtDmHQXWFDnygJlyhnxhOPL0HIl/sEOFRZbGDR7zCuHLhxJ26IQeCPgJfTfkPE8Lcv2OqrFzfPT/uQ9+0zxN4iG3Y/pvDLuNly/9UFPV7D+eBkpofBFp7PBdMzuK67TfwnzOmiZ1hj5YhtXnIdoZXc0KcS81YDt9IRW/5G7qZ86NQY3HUukXT2IDWbhXu0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(396003)(346002)(376002)(136003)(39860400002)(36916002)(38350700002)(38100700002)(4744005)(6512007)(6506007)(5660300002)(52116002)(8936002)(66556008)(66476007)(66946007)(316002)(41300700001)(6666004)(4326008)(8676002)(83380400001)(2906002)(6916009)(186003)(6486002)(26005)(478600001)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1Ki45UyVLJwwCJ9NX1Wlp9zva4+b/fDKZO/Va42oiojOwD0Lm8L23+lOVuXU?=
 =?us-ascii?Q?t2eYA0sLTV3AJOS+ckVB3Vqf4quzelpBeajCcb0DzYXRlK3UB987t0Br86oc?=
 =?us-ascii?Q?eqd+7AeHDE8lPIWYhpm5Iy8znTQSpBF5WXOAkAC7mvj7utF+GEPBydmDkMcV?=
 =?us-ascii?Q?G+O/0Af6pLz73X142J/v8ZyaBMZSUosbnPBKg3ywSkweckNGIbLJTH6s7Wc7?=
 =?us-ascii?Q?o85xfQjyQ4BFXtBaJ7a0opW5qCuDCYWCy1godzrkQpc32YBHrtgf8bNBVbLN?=
 =?us-ascii?Q?1FSKOT50DojI3b7/XiHoSoI/TKzFYj5CoUqO2Q0CBFYqJaS+O/zqiMglSB6j?=
 =?us-ascii?Q?XooEwXVhRhk6Ktz5eO/MQcFJOuY1snWvLus5vC9NHEuO8x4+WrG6b/eVT+UQ?=
 =?us-ascii?Q?VrF80LtSvjLyZIaihqLWqg+zzXyaaWe9vrvupK9VxtEp16B26k5jFQH9gU0h?=
 =?us-ascii?Q?+vVAJTLhNFWPBCnd/O2rd5VmdhmX5DcXwd9p7Yv9zKGRFURuTjtvzZ42/uLo?=
 =?us-ascii?Q?epGqAqsHTgjHeM9y9dDaf1yfelWH7l+9Wz62jFnU/igGrk5rwlXfxM/X7+Hq?=
 =?us-ascii?Q?Mk4SiB+ucwuCKSw+sATRwtlSFp8VhPBIi7pt4fejks763fYoBcgWAIrKX+j4?=
 =?us-ascii?Q?JG7IiRd02wPAuYoGpDTlHUrGnJZNuAeDLQj0nKQl6BNZMuQ2MJnUOYsv3K2U?=
 =?us-ascii?Q?G+TEdKvjJfUkRBiONpC+5V20Vc8VPoIfRZMYOmWJMRNVRmBrr224O2xerYTi?=
 =?us-ascii?Q?RoQ/ztweJzBvdTdNTu3vsugt1tMqtWKnTGuGICAuTuy5RHp5AJG+13Eh3II0?=
 =?us-ascii?Q?ly3JfnPO75ubG6OSVBz/amkt8qZrvN6/pLOr4S8W8g3oVnZItA3MAMyfifVO?=
 =?us-ascii?Q?9TDtGE8HQvwiGXgsPZD9Vzjn739iHb6nnQNnqp7ghcskGokX3EcNVJeTWnoB?=
 =?us-ascii?Q?nGbqgJgEfSQCqDigP5Upcx9nEiVIhWllh2PA4KSb7CLf5lVwEQqPUiCYdOMe?=
 =?us-ascii?Q?Eu9SxeWruTRsFmpH2ZS9RjwFl/PsF4htKHv0dnx6mvpYmNcjBUy+x/a6JU9N?=
 =?us-ascii?Q?bctcZ4q6NUr6nQOlU5Rjibx9V3oC1wdAELKVt/cUSMW2n9+C8gCXBH8IizX3?=
 =?us-ascii?Q?vKjBqeQ6iPA5YYr5cbjo/ZO5vqotdZG4ADcWrzrhU0rNJkPimUf7k/0IXAY/?=
 =?us-ascii?Q?2/pwIND4I/yx46BbzuWroRzJHuCWY4nA5q/C1KmgHGRzNLsrH+cMk5WvPM3b?=
 =?us-ascii?Q?gj7YHsYNKoY94CFYwRkg3KsCiumM7SjFOYt5UOREmVLMyM8THrYFrW5Qzw5j?=
 =?us-ascii?Q?uXdF6+1HNbWuRVlaF30GpHkhv6eekivlGglqjd5SZgPEFM0TA2YnovbL0ODd?=
 =?us-ascii?Q?TbfuCWUzDnFqSRccyTQY31KuaVStCocEpLIdtamnpEEWdi2xzEbCS6G61QIA?=
 =?us-ascii?Q?0pbTw1YwqaAg6HQIoBUbYkPztQKYwHwQ/VNA1cigxDpa4oUVXNKcmKpTQ43E?=
 =?us-ascii?Q?mFRYgQfuNl4zm+13dnj94ebamkqQ10CPzOH9gV26M87NM3SpT8whLVddKLkK?=
 =?us-ascii?Q?J6+NX8AZC2JobPOvZ/zxQMNBDjKbp0nLDUXT1pW/j/GaNfoeCI/0a5poXUjZ?=
 =?us-ascii?Q?mg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e0ffce9-4c2f-4fb3-3e78-08da741a1c92
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2022 00:01:12.4914
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AgadAiCnHZzlzyYRuM1qKOP7Tgf5KTRySlqYBB5GNhvYqBbtyKKuhrS3PEHO/lEv6jA2Nrua5CQLlCR6IjSK1/FuUKz7V8Y9ZkRR2pK3/Mw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5815
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-01_12,2022-08-01_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 phishscore=0
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2208010120
X-Proofpoint-ORIG-GUID: PMMcoG_3YlUJYSFTab4uDWaxP3K1xTPh
X-Proofpoint-GUID: PMMcoG_3YlUJYSFTab4uDWaxP3K1xTPh
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> After analysis on vmcore, it was found that the line "desc_ptr[len] =
> '\0';" has slab-out-of-bounds problem in ses_enclosure_data_process.
> In ses_enclosure_data_process, "desc_ptr" point to "buf", so it have
> to be limited in the memory of "buf", however. although there is
> "desc_ptr >= buf + page7_len" judgment, it does not work because
> "desc_ptr + 4 + len" may bigger than "buf + page7_len", which will
> lead to slab-out-of-bounds problem.
>
> Fix it by using judging desc_ptr cross the border or not after
> "desc_ptr += 4".

FWIW, I tested this change and I am still getting KASAN errors from ses.

-- 
Martin K. Petersen	Oracle Linux Engineering
