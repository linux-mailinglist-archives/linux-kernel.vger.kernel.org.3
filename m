Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E66BD58085C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 01:41:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237177AbiGYXlG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 19:41:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbiGYXlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 19:41:03 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80B266411
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 16:41:01 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26PLnBbv016719;
        Mon, 25 Jul 2022 23:40:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=rPLSN7rTJvUthDZScvH+GxV6QKR1V0Avbh9mTw+xncU=;
 b=SRziTWfKKfBYs0A03hjziOqcfpdSQQi5g5oC6AlmLM1awOzOkivDb3ChPrRTm3rXOH+4
 FkBIUX6nfF7Xz/O9op/kQUSqWaTQ66VbijXSoXZQcZwGY6oyjTe0cFdip0sGjhfrkjIK
 XlAb4keZtu7TBR+TwnIUwYiosjkCjnIxGjqmxjfQXrnzgj2iUw2kCRUV4GbWby75mJuM
 a5LJm041/kRv4XqzXoEpjyNxsRIsRMmOT/2XGNEk8ijkZ7e7MJWl41LHwj3HjK+KbxwZ
 jDlePpmpgznMi5nPLxOF4dGmbLInoFBacaNJz0ISccq7l3uR7lyPsZbGeN0uLO1Ku1ru 5w== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hg94gcuay-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Jul 2022 23:40:50 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26PNanTS034432;
        Mon, 25 Jul 2022 23:40:48 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2170.outbound.protection.outlook.com [104.47.73.170])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hh632540f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Jul 2022 23:40:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mR0nLl3ICt4e9H+Bb7/QLjNKO9ZGJO5Rfmgbf+uTkeLo+DEyBr81aqFOhRwMfsZXk7OMB1Gv3itBRqDEmmvRA+ZgHdUF0bqqWmvDZOEpNj5qW2VJAjL9d1OdIlZfy9FQzeR3wI/rleJJPJspwc44Wiis07Z6S2BTg135V5zYU1y/3vVM13rfeJ77HAbN2CovXtS+ek6BpCMnpY629urFp1OWw9TY/dU435xnZ67dzuGUdZGMWeFu8Aq+K3oAXKcWTVSSr8Ieum4Dema4isODbmPl3if59KSHPVYAJqk+FBMcRoh8YUzf3bEW7Wu3hiuCKO8tuAPl8zXzyR/cUjt6Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rPLSN7rTJvUthDZScvH+GxV6QKR1V0Avbh9mTw+xncU=;
 b=fofFNgucy6Xf/z+ma8OKsWl9A5813G+cgeyY05Io6mldPxvdWj9mASoglj8L0EJuNF9bbGAicr0FZm3Hj7Kq8NV5lmn+Glij+zYyou16ENA97VualFtlw+KLMujlMDi68DxyfLsqWmYa1ltbcPihFLs047BkSr/Vb86dG22vXdFGyPXQHRsy+npqnKiPKA8Q70mvwGN+15/8mGth1xDNiBeHia2oN5vXu0HUSAW9bJPwZfbhiQnE9OXVuDWjwpfKM63zVaOKkYWvoFfkjP3RvZufE/BIOy5SuS03f85GMxXdaZtFA/eC3nfo/jMawcbI52GWCiMQVFSS0hVPbqXw+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rPLSN7rTJvUthDZScvH+GxV6QKR1V0Avbh9mTw+xncU=;
 b=Mt7ZGwU9iEU39Uk5+6GOch0Q9cSjProG4wDdCDAN51Lp5ZZfkvM1bQiXR+GbhYe4qth5DNhUZrN5K7SXQWp1SUL1nNTMD7jNuVBH4be5az80sTx7Tzz4P2LIQ3f585XkSA6NbsEhI28DNxX8VQdf3P3fD2v4CQfMQ0dJ23sVOVc=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BN8PR10MB4097.namprd10.prod.outlook.com (2603:10b6:408:b0::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Mon, 25 Jul
 2022 23:40:46 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c1ba:c197:f81f:ec0]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c1ba:c197:f81f:ec0%4]) with mapi id 15.20.5458.025; Mon, 25 Jul 2022
 23:40:46 +0000
Date:   Mon, 25 Jul 2022 16:40:43 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] hugetlbfs: fix confusing hugetlbfs stat
Message-ID: <Yt8p+5FrU3XpFlxv@monkey>
References: <20220721131637.6306-1-linmiaohe@huawei.com>
 <20220721131637.6306-6-linmiaohe@huawei.com>
 <YtnvFBn8tSm7y/mV@monkey>
 <f277d8ac-8091-78b4-e168-5dfd87314889@huawei.com>
 <Ytsq6TEsXzyedpH+@monkey>
 <e6e2de0d-ee72-4572-75c5-02cb27e7ae95@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e6e2de0d-ee72-4572-75c5-02cb27e7ae95@huawei.com>
X-ClientProxiedBy: SJ0PR05CA0024.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::29) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 00971559-d6e8-4e50-c1af-08da6e971889
X-MS-TrafficTypeDiagnostic: BN8PR10MB4097:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jSQUd7WDFCvn/IHYuOkYGXGajaYiERQ/rKaJhT48ant5C8ZiPlJ0NSHSAbXMpylofOpofyqrc2ou7f4DJ0miNciqteDYbignvwmwkgOmJy+3e1J8CLrt+GdBSnRfovlYO4uoBOkX3rrO1iAYQKz4IT5/ruQJl0MRE/2bjfLnTsKggYAe/BZoHkzTsrybqWbOleCc5vh0zS9rCqDjbRDxCyqUBdmO1cXG6h3iLsaFsQu0+CXOnvQhSZw13ddL/HhB5xKT/XIoVkiY2JQWkdvxNT8nFkp8qMeI+zAutdhREkjQMDQmb6QA4/wPJy8jehSFY4iknXDnXTF8JDqSfDJAV6gNLkjRJ7KZp0/KsQpTqOpgZXmYtPQ/aY7D+UNzuEDrj5Dddngx4f2mXv0lcF4RU/uIlgYYltIzYEt1I/LwnSHlkWyo8D8j709xSfyn+PdlHqLu1mZFbYSAbQXur6NYF9gwiwtwhVla+nIcOeMjnjNZ4/48NmK1ejyzIL1AC01v21FPsSmW8dnsTevLT7TmrCbkM69EEjqYaA8FWxFECxX7bhs3B561rRLliQN/ZWbUs1G/njwS4y9JfDnrPyyaDj40TcIa7O7/eJvfYS2EEozkSyMtcLCsc1TXLHmXJwwWqnmuZeG9hr6oCB9OpXQdQKW+Rwpa7fukvTQxTXYrDtLgDJm/oELMsa0D87Yn7kyfuX+ViP58dWJwkPL7wsOiFnhNGa0mYt+w9w5ot1Ag/C7MO76wzmGZ9AQHlEvb4UW/5a96Bui2jp3obUX1EMXqHZIX+1LuwP0gsZCE3bycCY0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(376002)(346002)(136003)(366004)(39860400002)(396003)(6486002)(44832011)(478600001)(5660300002)(26005)(66476007)(66556008)(6666004)(53546011)(83380400001)(8936002)(6512007)(6506007)(4326008)(8676002)(66946007)(9686003)(86362001)(41300700001)(33716001)(2906002)(6916009)(38100700002)(186003)(316002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WcfFWK7gnMpj71bKRJiJMC9vyF8AClvmqUGYM9MmQrVClZV1hgGQUFvAgcWe?=
 =?us-ascii?Q?AJLMwNdwlB1LRL0UujPeO7ZWP+Ozdo374Oel60dnq5pzW/maMiOCg5FMvsA7?=
 =?us-ascii?Q?RANiwbxiaEZrvTCT7697fIw/uG1/gDWZ4LHOkx4+xxX1bPcMQQTfB4lonHir?=
 =?us-ascii?Q?WwCzpTaiaafisVYh9tKo+4Iun+cLEdJ6VbWStUB4uRJX3CwhwI7vigR3esV9?=
 =?us-ascii?Q?CduYxokdhrmrrzXUfrWdlAhZ2wbeBIIkTtlVDGCX+g43gs8PbrPgPuX664xV?=
 =?us-ascii?Q?TdNxxMprAlLqOFp0fSGSd0v0MihEy8lv9jxhUk1aI8g2GlluwgM7T3moyTpb?=
 =?us-ascii?Q?rwg2xlI09eiUa11lFPk5n28GIhpNrwNVLD7Yxk5l5krWxB/TmDpj++ZRnvH3?=
 =?us-ascii?Q?SqEWli+nsowkNPEQuv3XJhkXrdCeJnB/wIvyopAyy1si6Y3rl19D84WSuwma?=
 =?us-ascii?Q?ne3DZv8qJrBVccB7kOvgYWKSyk1RbsLjzxUBEE8Uc7Qs9G1WwDvl80s2fUbD?=
 =?us-ascii?Q?z2tTMpQcf0HGRxJhYcfkIhn1W2nUVyhylynarGueFcxwf0iaRYbRdagbS3vU?=
 =?us-ascii?Q?xc2Cb8HnHdGNcAA0aU0F/92H8RAOQ0RTmGPheBfmWrFOxxNuQEPwDutRIEFm?=
 =?us-ascii?Q?0S8TQUkaT2Htuff5u8+5gz4rKl3J0+ndQAZR9NKr7I8LZlQP7wwge8CrjC00?=
 =?us-ascii?Q?/E65WlvK3oDPTi/TrxSmemOylt487dUnwboV3wCXbq85vtvh8hd+bcAUCy4h?=
 =?us-ascii?Q?hO/uqrGzWj6FAoN06Z3K/8xIbA2UcQYadi8a1ZSABgms+r4LrHV2RzFqrS+a?=
 =?us-ascii?Q?n86URpCUkPzMUVeVPJSERtVWeIWQ5bW2gCxk/U2bo9Cd8LTGbae3pDfK5V0A?=
 =?us-ascii?Q?aBEtui0BaQbiOZLK6wR6sfP4G0chFaq9cInM6sgitzn2lPez8vTbIxNdoX39?=
 =?us-ascii?Q?yBupWX1z6W0RPbnnsBb2iYdoVFZriTofHm8hyodtWU0xEst9TsOCV1SqFxDw?=
 =?us-ascii?Q?QcrmdU50tWpeWfx/mAscsa8bff4knopRJrmWxL0Td0UqP363fvhlLX/qWP+5?=
 =?us-ascii?Q?737cgkxIKaz3J9zgpxK3dSaSQSB4OfgRdCajYz86dCU9AfYbBzsVwQLOB0W/?=
 =?us-ascii?Q?8IH44ZGYoLm69IzkLTBlz55t74CmepSdUCJQOIIYWIp3afynGtrYDZgOKCw7?=
 =?us-ascii?Q?9CdJCvHg6DEGSS9ZvpCm4HnaPxffjAKTu1I3mqFk343pJ8JbqfKYe8VgrRCc?=
 =?us-ascii?Q?pYwSNFxC2mv3e1uKRvWF84IfczFI8azV8mRsaI1coj2ONawbIEL7Ae+C7wef?=
 =?us-ascii?Q?dtZSjB3d7RxQc+cHCcgDXZWkwOQA1fLujSquk6c5bNR7Vv+BMIg0qeNxxZtu?=
 =?us-ascii?Q?xyedWmk7ZBbpX4Yi9iS9J/tQKQHlMKYjshKT/zKNV0wPUx0GsGSLosfKsAdy?=
 =?us-ascii?Q?MsQ4KPfHwmdawWIcBxajCxgWAQ1dgUNW7I7siNkEFLVPJz/k2Kd8LvwhmqGc?=
 =?us-ascii?Q?FeC7y1TrdNDTjkej40ijZ3pKJwOY+XD7UL8AfrzsYx4ng2DLwpM1N/p1SFN1?=
 =?us-ascii?Q?s5CIaQHZZbq3TiADs4QcgZRsEoH57oiqgQs1llqJjLE0ttUZv9zufc4Ih3mj?=
 =?us-ascii?Q?pQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00971559-d6e8-4e50-c1af-08da6e971889
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2022 23:40:46.1050
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cRBgMXra/l1CdFLxYvQdfCEnOzuvlTylaDpmji4EV+t+5ayBbCctQQbq5LFElcAlNCPPOooz5rynut7VFj9iUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR10MB4097
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-25_13,2022-07-25_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207250096
X-Proofpoint-GUID: YcAMVDMKvV-ekIWRtKVdZpl1UoE62X4M
X-Proofpoint-ORIG-GUID: YcAMVDMKvV-ekIWRtKVdZpl1UoE62X4M
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/23/22 10:56, Miaohe Lin wrote:
> On 2022/7/23 6:55, Mike Kravetz wrote:
> > On 07/22/22 14:38, Miaohe Lin wrote:
> >> On 2022/7/22 8:28, Mike Kravetz wrote:
> >>> On 07/21/22 21:16, Miaohe Lin wrote:
> >>>> When size option is not specified, f_blocks, f_bavail and f_bfree will be
> >>>> set to -1 instead of 0. Likewise, when nr_inodes is not specified, f_files
> >>>> and f_ffree will be set to -1 too. Check max_hpages and max_inodes against
> >>>> -1 first to make sure 0 is reported for max/free/used when no limit is set
> >>>> as the comment states.
> >>>
> >>> Just curious, where are you seeing values reported as -1?  The check
> >>
> >> From the standard statvfs() function.
> >>
> >>> for sbinfo->spool was supposed to handle these cases.  Seems like it
> >>
> >> sbinfo->spool could be created when ctx->max_hpages == -1 while
> >> ctx->min_hpages != -1 in hugetlbfs_fill_super.
> >>
> >>> should handle the max_hpages == -1 case.  But, it doesn't look like it
> >>> considers the max_inodes == -1 case.
> >>>
> >>> If I create/mount a hugetlb filesystem without specifying size or nr_inodes,
> >>> df seems to report zero instead of -1.
> >>>
> >>> Just want to understand the reasoning behind the change.
> > 
> > Thanks for the additional information (and test program)!
> > 
> >>From the hugetlbfs documentation:
> > "If the ``size``, ``min_size`` or ``nr_inodes`` option is not provided on
> >  command line then no limits are set."
> > 
> > So, having those values set to -1 indicates there is no limit set.
> > 
> > With this change, 0 is reported for the case where there is no limit set as
> > well as the case where the max value is 0.
> 
> IMHO, 0 should not be a valid max value otherwise there will be no hugetlb pages
> to use. It should mean there's no limit. But maybe I'm wrong.

I agree that 0 as a max value makes little sense.  However, it is allowed
today and from what I can tell it is file system specific.  So, there is no
defined behavior.

> 
> > 
> > There may be some value in reporting -1 as is done today.
> 
> There still be a inconsistency:
> 
> If the ``size`` and ``min_size`` isn't specified, then reported max value is 0.
> But if ``min_size`` is specified while ``size`` isn't specified, the reported
> max value is -1.
> 

Agree that this is inconsistent and confusing.

In the case where min_size and size is not specified, -1 for size still may
make sense.  min_size specifies how many pages are reserved for use by the
filesystem.  The only required relation between min_size and size is that if
size is specified, then min_size must be smaller.  Otherwise, it makes no
sense to reserve pages (min_size) that can not be used.

> > To be honest, I am not sure what is the correct behavior here.  Unless
> > there is a user visible issue/problem, I am hesitant to change.  Other
> > opinions are welcome.
> 
> Yes, it might be better to keep it as is. Maybe we could change the comment to
> reflect what the current behavior is like below?
> 
> diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
> index 44da9828e171..f03b1a019cc0 100644
> --- a/fs/hugetlbfs/inode.c
> +++ b/fs/hugetlbfs/inode.c
> @@ -1080,7 +1080,7 @@ static int hugetlbfs_statfs(struct dentry *dentry, struct kstatfs *buf)
>         buf->f_bsize = huge_page_size(h);
>         if (sbinfo) {
>                 spin_lock(&sbinfo->stat_lock);
> -               /* If no limits set, just report 0 for max/free/used
> +               /* If no limits set, just report 0 or -1 for max/free/used
>                  * blocks, like simple_statfs() */
>                 if (sbinfo->spool) {
>                         spin_lock_irq(&sbinfo->spool->lock);
> 
> > 
> 
> No strong opinion to keep this patch or above change. Many thanks for your comment and reply. :)
> 

I am fine with the comment change.  Thanks for reading through the code and
trying to make sense of it!
-- 
Mike Kravetz
