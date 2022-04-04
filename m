Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A30D4F1263
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 11:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355176AbiDDJz7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 05:55:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355064AbiDDJz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 05:55:57 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61D84E09
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 02:54:01 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23479L8f018751;
        Mon, 4 Apr 2022 09:53:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=CgxQcO0hjFoXye075R1ySgzx/BfF+eni5ej7fNNhHXs=;
 b=tlcBu0RpHkC+5muMJ3FVcdxiVuXRhH/YMRK9nxl5q800Cz5bWabVaqAHN4n2MXy+uZLS
 hQy+MqTT9e5whpz49hvPQk7X8mQmTsfkxzsDnAL5W1brTS1jYqX0PzWFlWGORPLRn5vr
 /ECDrtXliaUy7ivGCDMcLI04RmfqjwObtkieBbTBtY7nkLNzRKFtyWVH27WWucl2MN/T
 f29KUow6EBetcU70dM5cxBfXLv4eE3NhCi4ydF04hkzQ8jRpTKNjBR33HMPzady0yRWK
 08XWzpZe11RAhg5tdXJ9zi+/2M6kEJwaMoXOvskokSt18qr180ouMuUlT7+Lvi/DQ0f7 9A== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6e3sjn87-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Apr 2022 09:53:38 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 2349okd6020359;
        Mon, 4 Apr 2022 09:53:38 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3f6cx26x0p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Apr 2022 09:53:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gLirbK6V3xGlHwA/fOXEMxgJO8ThzRMgCGn9pkN1HblwCr/5BAC2GsDwRO2cCpTIxcjpf8y48JJXyBZreM7faliV3TRljlEKiQMmUn5RwRFdOaWEzs3rbi2Rnt1sfa7/U8s3dQP3WKiXN4tu8QHjsqlh3fsnpGA5LEeo8A9mx+bukN3VGkFNyKtklOQ7N2W0xOxCtTX2sEzrAiHdFcltC5MKtO4iomkxEt4IV0+wiDsV1ll316249aRuj4xX/NJ4Svqf+Dp2Pq5LtMkeou3tG/7HWAJshPzc6szKeaBjk7vTsOwgPT0dDNXSiPYxs7ArRatOgI5ec745gEXAB+nz9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CgxQcO0hjFoXye075R1ySgzx/BfF+eni5ej7fNNhHXs=;
 b=g4sWKVxj+dVX+vehWCpBhpetLxBtldeM3JNh5pvnEk8S3wcJtTX5LkS7ZIaVyGnWZJUsDSsFyw52VR6uIdFA3ajNDePeTIdIUw+4gBBOd66XMXzb9UVW6ckTZOom7Sia4QPg1Ywb1RRy8e1jHuWAeYD6fyuqs2HnmL8FMZ9iIUEaorXFNquq3xPctA7o5dK4IID9YoJmDi9WKAcm2GMd7O9R8t9YdQrAalqNDlkGtAEQL4HP6BEZi3pVUZu7YOke9iYQOokihHHijmHobOTalJw7bmzApBVAYGH7LgcNZ3UbQzSNt1dQcAzyxyNi6JT2KU5H03WdWqc6UUBbHG0krQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CgxQcO0hjFoXye075R1ySgzx/BfF+eni5ej7fNNhHXs=;
 b=Y14W9NLuCR3GxOPY9rSYzf6POhCl1CfU5beWohYprTxbno+OgoXfQBjaYsNgQvSzJYfFY0Q3DJ4cs9Ro2LYGt5TdcvO4SEH1GpUPs/BHCXlPf1dbJHqtsslsqm7a0jrdRR8Q1w1v7cH/SOAw17dhNbj+WYSNPnaeVbRunsxhoW0=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MN2PR10MB3806.namprd10.prod.outlook.com
 (2603:10b6:208:1b7::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 09:53:36 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d4e7:ee60:f060:e20c]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d4e7:ee60:f060:e20c%7]) with mapi id 15.20.5081.025; Mon, 4 Apr 2022
 09:53:35 +0000
Date:   Mon, 4 Apr 2022 12:53:12 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: r8188eu: Fix PPPoE tag insertion on big endian
 systems
Message-ID: <20220404095312.GV3293@kadam>
References: <20220401151257.3414576-1-linux@roeck-us.net>
 <782f0115-e45f-1aff-a152-5d403c990b31@lwfinger.net>
 <dcba377b-1fce-92e6-680a-77c5567cd06c@roeck-us.net>
 <8e68501c-24fd-cfbc-60f2-ec3e277159ab@lwfinger.net>
 <0c646d80-3198-06c1-e8aa-442b245ffb3e@roeck-us.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c646d80-3198-06c1-e8aa-442b245ffb3e@roeck-us.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0025.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:18::13)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2294739f-a776-4c3e-941c-08da1620fbd3
X-MS-TrafficTypeDiagnostic: MN2PR10MB3806:EE_
X-Microsoft-Antispam-PRVS: <MN2PR10MB38067A703E893C852959D84E8EE59@MN2PR10MB3806.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6iulcn76C8ZvPNjl652zyrFw/dIL+8KuPu0ioz1l1UDKxPcef+PBXc0Y8rddhIXkBmoEMVfpUy7DoWcDD6BjAy4FEu1JaucsxtRoG/d04pCmLiVtjh1zhU1o4tVwsY24oiXLuwyL+oVpWLXOoTiWMsVy3rt1VPVA0ShQAvM8c5SSvTzDw2NRHTmv5/kMGqO1LAUFrZO39KLiBPGDg/ArUr6+A8ixCIjx5AI5oHKEHqvh5SPT6yng5RnWZGzxzPI/aeZa2JmLEthFM1hFZ+dkaCmzZULrJZPMJ6QMBC2kZv+LhNexzrdONhL4yhCjByhAoAWql0iEOf9Lbp/+/duztk0bx3vkGUDwpZmwtd9mdCHkW5VufKs1/0RGJsCNgDLFCKuCHzb4mFFRAl1ujPrXVsNQlmP4bDawj4d9te1AV+3xdlS+2N3oivkuplWtXldRwfBer9iGzqacL9OuItorIp12vmxet2KeYGf4/x2O3MqCJdw3MKdLq2fpDXnX6wv5fHBtCDqGqQ0oHBMexCQ+QUD1wGcpjjFGvgNYT3F5FqRCFpINRjs8kX9ku62IZ/YuPvW914yYm0x/Ca2RMTBRTWz4mhv2BV1FGByVQAFKePxsuIb6hpCnkMYP3hMY+0X+3qu21bevVthhgWxGm3tfFwSS7ExXXWvZ1VetT9rEGtrzFA88bIlIFrQ0sJjhdtIgA9LtZYJUaLAgQl3d8xCTYMA2k/K0zw7oN+XR9WUyiC+/1MdJe+zh5Tloa7rKBTaL2zYcX2sJ5qZq4q/RjCzlBp3JaYSljmXkIKX5VvyuK8U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(66556008)(4326008)(66476007)(66946007)(8676002)(83380400001)(86362001)(44832011)(5660300002)(2906002)(38100700002)(38350700002)(8936002)(6666004)(316002)(6506007)(9686003)(186003)(26005)(33716001)(1076003)(6512007)(53546011)(52116002)(54906003)(6486002)(966005)(6916009)(508600001)(33656002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CmfdSf8qgwJxZ/Q0gN/9UMcBwoZHdoWTKrWNRREWlkGvmw+p/W6Kc76baxB0?=
 =?us-ascii?Q?HGZVkM65tMvWgc7yHtYdHhdi0g6c5nhgHNP/HU+kyqf0Lz09P+mCgUSWdAH0?=
 =?us-ascii?Q?6YXoen18RPGQGn2aAQ6gIKxm0bN8FK85nUWWqbu9phvOz860H1a6lgHPrLsn?=
 =?us-ascii?Q?rVQr3nkNA+P3iYBrNXcc4sGmo52ZL7EzbJaYMz0wZlAabiRzxOXFA8FsGOr/?=
 =?us-ascii?Q?+4NEaWGskY7CNGQMqzHN9zya4pU0++isVI4A5W1a27Q6mxhip/OoJOXvt9eu?=
 =?us-ascii?Q?2QBwKopJhYQEZahmEIE1ggPPzaUnc4bYusjPPmohydWE+cXo5DC6/yYKCV2K?=
 =?us-ascii?Q?TdDXu9W3ykO5hqGTt92jpPkDYky3qNM+ciu/eE3bsOEoLv0IkVSY6UJogLgm?=
 =?us-ascii?Q?bS8qatCyv1qSbokVuSuUQCWcS1ECTSA73pjQIYF+1bth/NAxLZYNDuotMrPR?=
 =?us-ascii?Q?WK2En6Juz9C2pGHNNqBCe+QpYI0Z8g3O7dLOvP8RxYFg1Lf6pFfL202plon6?=
 =?us-ascii?Q?OJAc0QXjiEoFwGkFpykBRyveXcZAygjkVJQhIAH04xLve0wnQe5doLYNtXfh?=
 =?us-ascii?Q?PC6oN523WVNGjsRmJY0b7P/EYjigTNToLNc/1bGIFSWGwhdMq8ez2ChB9FJh?=
 =?us-ascii?Q?PVujjsMZEZ2TlGLw4TK+y9vWyrPbamETBij1P8Ms/PXjnYDjFRetxuMkwuUA?=
 =?us-ascii?Q?8ygyqWYA5YkYwSruvC+Qcdyxyi4OadqVvwE4oHHeITMmBxPpTT+xp1HZJo7N?=
 =?us-ascii?Q?4SSuJrMNkj1fJsO1HpWu0CBAb1N1TyqRpfg4fr4glN51Vz2/9nzK/x5D1Ju0?=
 =?us-ascii?Q?Q8v7HsVPljtFclmB4K56fTU3gZprkAsV+WXncBWdwp4r+U8ySbiuGBOW993M?=
 =?us-ascii?Q?orkEEQep8zKSQh2gtFQCAk3y8wUGchTnFjekn2nZvW9/ZI5jqFuCzJ6RG+AV?=
 =?us-ascii?Q?PClkRkqzp+R/eC/5DHPIXZWOGgCNmBUuXBsnW20aJPMcHuHP6VjiQlQeKjtG?=
 =?us-ascii?Q?9ghVEhhNQwOSOCUqP5v2o8ELIHfgNiEozwe4vStiYqljZZQDTEVysw0GT9QW?=
 =?us-ascii?Q?UKT2oK0CtekDBIQ6IVmjfcNCkJZgUlQjDjLqwVjcaxXV2zA9hbYWsEC0GWUl?=
 =?us-ascii?Q?tXFtTxcW0paGVaRoZU/mW1yR/PDw+uvE4439Pf0W4lAlQU6dCDwzDQTIgz5f?=
 =?us-ascii?Q?+OxP//a0SHqfbQyX7xTOIQTDDo+rKKB+4p783JA+JWheW4l/EwZ0S6N/dcJC?=
 =?us-ascii?Q?un1FX5/Efn+PnxlK9jBayDs58FTIT9fe1gQY9cKWsyWRLeH3TArY12tkVhwa?=
 =?us-ascii?Q?cCnrgrJjR9CpQT9FihaZ2av2CivpAvXspVXwc+qi705FJPwnevQdQngigrG6?=
 =?us-ascii?Q?ejLhcvAxqQds1NPP1Ijlym0SIkI5zwl1YI6t1K10FAocUR9JtpLcH03bwjHm?=
 =?us-ascii?Q?+nn7A17k9jXX2tbqwd4eS34htUf0oug3kp7hAWzGAQghY+X/3iJ8OZUik6SX?=
 =?us-ascii?Q?Toa4joBiUgcqlcNd7mu7eXepbAf7JAliCM5O8fBSp0KEKlYP1n3FfT4KmlyZ?=
 =?us-ascii?Q?MCcIR9EqSEFH3zGlMFLyvJeYgODSg838ny+P6bxnGv3jTCuzFUPr2ggDwdvg?=
 =?us-ascii?Q?0Lw9NFAmOqTCW2stMWCm0pvL6jZnaq/3tASLv/hXo6+MMj1hjqYiKPm5mGPH?=
 =?us-ascii?Q?0uLFT1lILUKT8EfTrlfXBFH5Gup31VwJALqCaYX5gKAvjVC/Lm45ZlG8x8N0?=
 =?us-ascii?Q?8LybN0JAMWn9Jv6/W742IHDgEFuvFtQ=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2294739f-a776-4c3e-941c-08da1620fbd3
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2022 09:53:35.1839
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XFvEPzPNA0Iy9NkjzfJHrmQugVTJaqaK5incMkRqmQm5gs2MXzW7EJFxJKjuOSrxGeJOnANrnSMQqrMgmBEWwRbRCscueBuSYoJXrDTis7c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3806
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-04_03:2022-03-30,2022-04-04 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 phishscore=0 mlxscore=0 mlxlogscore=889 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204040055
X-Proofpoint-ORIG-GUID: dRxsdTXTRpa9C1iowko5XqCGyOGv5y7J
X-Proofpoint-GUID: dRxsdTXTRpa9C1iowko5XqCGyOGv5y7J
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 02, 2022 at 02:18:22PM -0700, Guenter Roeck wrote:
> On 4/1/22 13:25, Larry Finger wrote:
> > On 4/1/22 14:25, Guenter Roeck wrote:
> > > The rest of the code uses htons/ntohs, so I prefer to follow that lead.
> > 
> > You just proved my point. It is hard to get be16_to_cpu() wrong. Sparse will flag the error when you use cpu_to_be16() instead. I expect that your htons/ntohs problem would also have shown up with Sparse.
> > 
> 
> Ok, you made your point. I'll use be16_to_cpu() - the driver
> already uses it elsewhere anyway. As for the other problems,
> I am not sure if the driver ever worked. The function we are
> looking at can't really have worked on a little endian system
> because of the missing conversion, and the same is true for the
> other code flagged by sparse. I think I'll just add a note
> to this patch and let the driver authors decide what to do
> about those problems.
> 
> Guenter

This is already fixed along with a couple related bugs in commit
2d959a842a8f ("staging: r8188eu: Fix sparse endianness warnings.").

https://lore.kernel.org/r/YkPK/QmLAp3BkygY@sckzor-linux.localdomain

It's in staging-next but hasn't hit linux-next yet.

regards,
dan carpenter
