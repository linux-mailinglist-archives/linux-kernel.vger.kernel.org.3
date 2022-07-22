Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFFF257E8F0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 23:38:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234547AbiGVVio (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 17:38:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbiGVVim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 17:38:42 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B418CB8512
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 14:38:40 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26MLTOGS028243;
        Fri, 22 Jul 2022 21:38:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=k2chtgrzhPyDCMZ1raeLT65k8t11jg/f34hC7x5qQaM=;
 b=Dr6Bt8GoaVv+1YNQXOTdYHgb+m8lihkGjVvifiUo6yLSijKz9g/V2BiB4QYVMBzuEMHY
 vcJA542IZdSMIeZX42H34v+5ume2OW8Zg3KFn87amhaN9s4hCbvOdABuDiDMWuY0QzDo
 lGDA7Gc1M9VLD8LtfjtsVpLFMPP8PP8H8fqA5+Fz16b/BUqysVbDhILjPeYLRMUnu4LK
 tcnCKLQImuO4uUiZR8mFXah+XZf8mOqD7OfhU1+PvNrHqxHMvxsfBYxbnQMIJwWisiuE
 6teGz9dYayEpTfx+F9yTbH+upo5ojo4ZlFtjkkvz8sL46JiR5g6lyTfd11NpW1ykoGnI cQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbnvtrmrr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Jul 2022 21:38:32 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26MIvmqq009829;
        Fri, 22 Jul 2022 21:38:32 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1gm77k7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Jul 2022 21:38:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GSypJN370LO4eF1EOshOL0+LJA2ExWrPuSLJQzD2zl1746WmFq3ijkCbRSXHqhxmEtksgSi2R8wBvkwPe7Rls/102Ldh45aDLSypYz2JuN53ARPwB7wDY1qT+79xL77/ggn5V/rGj5ll+VUBxg4Di/ZL6rNifzawlwbadr84k/oqUOJyeYkn1uGEL4xXccm6HywVm9yQQYStVWJKkMt5uq3nA3L/JonvxRdwhvH5s2kW4/dzQ5NXPULFPZ0UmUqHKydoTwVaJjPbVecZ39Pyr/u7VsqwICOwsooU9ERy+uTGtHHFFD4v8mG66USvjbSC7LukXHaCC/83m3NN/KnJAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k2chtgrzhPyDCMZ1raeLT65k8t11jg/f34hC7x5qQaM=;
 b=TPqcFF+WwmDdO2ngK6A16hbyAcvv5vnEf6HcNyBQm9G4MsDlk2X+fdslkWG673cujxYQSYANEnIeVeXKSIeAvfl8Bw6wTDQiTAWGRERNNkTmgsEIwP3HBsztOqpbcE8wf8GqDdPN6p5bpqaKPA+r7BYRzFcTnwTp8duYeC/DzaqXFkcSPvmTLoFZEoL3LKCUabqEUYg2/hqOAsKbFmCy5Wxq3GxTuMzeZWzeZhVQVK8vrl5Zgyl8UgSuLSlmEVCr9/rSLk75RXDbOwd/amADU16Bbo8Uih5Q3SyNNNifrT7oPap2wAwtD/SsCdsu5RTlwnEO7RQ5LG+I+4NaBd3NSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k2chtgrzhPyDCMZ1raeLT65k8t11jg/f34hC7x5qQaM=;
 b=hMvHsCTr2wPeHZzgnHFRwuLI+XzjC6jNhjbSBU2gCtVBg0SIl3oJRxZaGQinG53nb+yuDw8V8wlMnae1oJAiZDfo26q64qKfE6WBHRF4ELEfV7+TaVZoReVIrFopJZm1BnMOviaJQUjl6+eSm1PYadk4jObNqsG8broyAdLmi7I=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SJ0PR10MB5804.namprd10.prod.outlook.com (2603:10b6:a03:428::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Fri, 22 Jul
 2022 21:38:30 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c1ba:c197:f81f:ec0]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c1ba:c197:f81f:ec0%4]) with mapi id 15.20.5458.019; Fri, 22 Jul 2022
 21:38:30 +0000
Date:   Fri, 22 Jul 2022 14:38:27 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] hugetlbfs: cleanup some comments in inode.c
Message-ID: <YtsY0/PQydnngDG3@monkey>
References: <20220721131637.6306-1-linmiaohe@huawei.com>
 <20220721131637.6306-5-linmiaohe@huawei.com>
 <YtngA886kRoFslmS@monkey>
 <c2ad2512-5cf9-b2df-0d71-89bca364afe5@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c2ad2512-5cf9-b2df-0d71-89bca364afe5@huawei.com>
X-ClientProxiedBy: MW3PR05CA0017.namprd05.prod.outlook.com
 (2603:10b6:303:2b::22) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 74ab63b1-6e6f-40de-9473-08da6c2a84ec
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5804:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R+tpPlWIkygllu2ie2yOVsvlfUKrXKDZpDhyO59TzbVs9QFlJLlKMDIS9WPGId7RmzNm9dtlWw842yb10zA3Zs5+8Quc5Nj1g51zI3MYRmX4ZskhxZgtlNEpeZ66lLnjkjZ1Cn+0jT8/B8IgVa8YZpfBuLPPp/bsaUV6dIMn9tOVLFxARydSlh4AuOgOYl3yiRuxtbGqRfkA/bVermjReB8PZiIBFzrfd59NIhHcR8x+z3ErygtiZEFYzJh7V+Pw/IQQw9KZBhKwHhPABscwUBKU1FNK+OC0I69cdkedDQ7GtjMbdlxuy/YEK1bAHesLGeYBEdGhxcYJxo7MVhmCUiAKLqHpfEGrwNR/TReFZCaRHyUuGJfDsmbr1RZXtmc0WRCP4JJIOV0p3yLj1WsAPw2G5d7Kv3J/OfEPm3FEd5U4AWuM6w89OhBVC5JkcEHaAcUDSjEGXKrAMs7E9s1+RCRKbQeTSFtMrZ3YEfqRaNJtWXhX1SDMFsqotxQ3BPoO/hmO3Gs1K9W4IcMhzUoT4klYEUvmQAcJqiee7Kpsm8FdP1lcDQ9MKgzVNrHgUAPR6NNYWuQHpxDEhW9nVmnUIVkN08EJ6u1+RlOyxMseDZAHjP2Q2Qr7yGdClyMLSPVQBkl30qyLyF4b26D5NhXtfwtPuRJQYzaVhap+zp5n2r+b+h6Bw7vYV18QBkiCj01LqlGjNkVF8oi8jO4JaMKhn3hls5Fqb/9t1zigQkMbpFvoI3Puyg7jzzChgWM2gGfo
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(376002)(346002)(366004)(396003)(136003)(39860400002)(83380400001)(66946007)(186003)(66476007)(66556008)(6506007)(6666004)(6512007)(6916009)(86362001)(8676002)(478600001)(4326008)(33716001)(2906002)(44832011)(8936002)(5660300002)(38100700002)(9686003)(26005)(41300700001)(6486002)(316002)(53546011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?E98GyyCQalsagIIyN8Rt96nvmqIzysi0zT1a7DFdrdnTc8oYGFLPHc3zSRsU?=
 =?us-ascii?Q?Sf9bj2hIfaD/oxSTwtCeU/qjnwPEQqaVDrvzlgewxYm3TlFtsloR439gcccd?=
 =?us-ascii?Q?vJ01p0fzuFRUpkvGyf5PQIap1lejRkS6eMttjeswLzS/KFw1an7qgVmf/Eii?=
 =?us-ascii?Q?BumU3x/AxhJC9fbaTEGvj11O34WeSQb9y8x8QHLYFcq8Sj+dF0Qd2IjFjdax?=
 =?us-ascii?Q?F0IOCgpeiCu8zWQg3Tt2SiAk4+CW2FhGDrXPHqgpkFej+ptib6klynVilCQu?=
 =?us-ascii?Q?2nAWl1zYVjlQkcH8ZgClyOvUjD5xFkfGfgYXSR6OxudwySPiuQIHo7e6IF+x?=
 =?us-ascii?Q?kMj2SZs+VBMhG6E57c0iOwcedWNtvLi9tGsM+RCeZLaNem17uP3K2X/PiBqs?=
 =?us-ascii?Q?QncYLoz5hz/XDKwF7QLJf4LCCKXONwOj3EURHr4CSIDzLn/wPmByk8j8C0eP?=
 =?us-ascii?Q?y5Y4YIOwd0WgCrd/mzF9HthS90ujUeR2J/MnJ41J683lIJfhUN43Ap4joQYi?=
 =?us-ascii?Q?zbvT2i7GolIQUOubQwMlNpRESY5wbKwxl/Rfmto7dzkMXvmCbuxBey0fCi+f?=
 =?us-ascii?Q?xc6N0W/fKGmLJ7+dv++ea3IpNpj92MJF88FjHDrCS6jFOJnFGFSUVXywhZKB?=
 =?us-ascii?Q?pvKOKyvrFdG5Et9NLVpHLzV7r8arO8Bx9kTDFwiBlogN34PTgpuKTPkin8wR?=
 =?us-ascii?Q?1OLMskVxHCDesGxWhl5XidmGWbBc9g2W47QdJR4GONw9IixvvW5p9E1+Dn5j?=
 =?us-ascii?Q?HomZ3UeXNH6LW759ct4fonCfgMswsHbQGKqKxQRBRcxTaJrQIx7hu0RxIdts?=
 =?us-ascii?Q?J2lXCA9/98YuAipKx29ovNiFYzfiGfwpvwgxmizfQEBSfK+X3KwAO2gCONJQ?=
 =?us-ascii?Q?L2hYcpOaXUT/0BM2fmVow6ILgn9SS1iIroqVtaElgb12e92D3XCf1QU5qv6i?=
 =?us-ascii?Q?zsSkhBvc728qOXtR02LV7eSAXcIX+bzWhznSuB5H/kEQzs35qcCDcWKk0drx?=
 =?us-ascii?Q?CNvmZGNUBabI/5DalMLJe2d17k3WR2vbukh+gi64e7ZNQDyz6vP5uVZ8Mj8r?=
 =?us-ascii?Q?IkPdJxlt3RqzuSmUZzMVjStWunP7qjTJYKNEC1EkLxXHp2MyOQZn7NUoaEPZ?=
 =?us-ascii?Q?1KwQPMHgXOntvI16Fe1GEPi4NyeXtgE4QzcYG5PZx/vK4RoM94SZtPExQo4r?=
 =?us-ascii?Q?Ere4D7yVFaokEJCJXAqy8CKjMVKPg6PqTWAATh7sbin/FyPVOLRvmuJCVdWM?=
 =?us-ascii?Q?MvBdb6oTwbOwI+8zRJmPI/gp7aNdVsOq6mBAUihmd45PrJDt1HfqCG3s/LZK?=
 =?us-ascii?Q?gRIAzSXv2aJhSHxRDY1n4ODoD1ZFCT1ATosNp1G5F+QPknO18+aozzzcsz2e?=
 =?us-ascii?Q?NTaFenwwlG3pzZ4aXdHygj9L2Ypee9uMYzZfGkdxN10+bKcqVdAf43dsCFSf?=
 =?us-ascii?Q?wTv79VQiecDS1mHXinJ4Mvf7pfms6mF4aSkLQ9cqF4Y48eJT1+6onAWwRRZs?=
 =?us-ascii?Q?LUsk3Tb/t+MUW8VH++i+ejEz3dN52lXwJJALgVGJ7QMBO2H43L9SDFmX7/LK?=
 =?us-ascii?Q?rEqSA55MAn5zPgvjaCsGCuhvkE9gJETM7qn2pe0SHf4G8I/VXzxDMl8QSZ/7?=
 =?us-ascii?Q?gQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74ab63b1-6e6f-40de-9473-08da6c2a84ec
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2022 21:38:30.3213
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BEo5yByd4x4ZPFagULHqa0ElN1g0ZxDaMWB/MMhk7ZJ4q72D8vSOydwkx7t/0OCr/cTv/Nn60sueO79bLZFY5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5804
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-22_06,2022-07-21_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 bulkscore=0
 malwarescore=0 adultscore=0 mlxscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207220088
X-Proofpoint-GUID: wtxBScqvFq-U07hHG_WXH5PkG6AfRaCP
X-Proofpoint-ORIG-GUID: wtxBScqvFq-U07hHG_WXH5PkG6AfRaCP
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/22/22 14:19, Miaohe Lin wrote:
> On 2022/7/22 7:23, Mike Kravetz wrote:
> > On 07/21/22 21:16, Miaohe Lin wrote:
> >> The function generic_file_buffered_read has been renamed to filemap_read
> >> since commit 87fa0f3eb267 ("mm/filemap: rename generic_file_buffered_read
> >> to filemap_read"). Update the corresponding comment. And duplicated taken
> >> in hugetlbfs_fill_super is removed.
> >>
> >> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> >> ---
> >>  fs/hugetlbfs/inode.c | 6 +++---
> >>  1 file changed, 3 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
> >> index aa7a5b8fc724..19fc62a9c2fe 100644
> >> --- a/fs/hugetlbfs/inode.c
> >> +++ b/fs/hugetlbfs/inode.c
> >> @@ -313,8 +313,8 @@ hugetlbfs_read_actor(struct page *page, unsigned long offset,
> >>  
> >>  /*
> >>   * Support for read() - Find the page attached to f_mapping and copy out the
> >> - * data. Its *very* similar to generic_file_buffered_read(), we can't use that
> >> - * since it has PAGE_SIZE assumptions.
> >> + * data. Its *very* similar to filemap_read(), we can't use that since it has
> >> + * PAGE_SIZE assumptions.
> > 
> > Since you are changing the comment, I would just say this provides
> > functionality similar to filemap_read().  filemap_read is now operating
> > on folios which may remove any PAGE_SIZE assumptions.  One day when
> > hugetlb is converted to folios it may end up using filemap_read instead
> > of hugetlbfs_read_actor.
> 
> Sounds reasonable.
> 
> > 
> 
> Do you mean changing the comment of hugetlbfs_read_iter like below ?
> 
> /*
>  * Support for read() - Find the page attached to f_mapping and copy out the
>  * data. This provides functionality similar to filemap_read().
>  */
> static ssize_t hugetlbfs_read_iter(struct kiocb *iocb, struct iov_iter *to)
> 

Exactly!

With such a change, you can add:

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

-- 
Mike Kravetz
