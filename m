Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D119C57D757
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 01:24:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231652AbiGUXYC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 19:24:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232768AbiGUXYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 19:24:00 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0B611D30F
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 16:23:58 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26LNEAa1000524;
        Thu, 21 Jul 2022 23:23:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=h2TrZNmErSwVGuzwAXJkSZPQUIqTQpGkdve3aOdmGlE=;
 b=heorPRG5VdKNbqB9KqDh+AM42oAgqVrJK9YOrTQhf+bfvzHLZRVdQMvCW1XwYv8Cg+Zq
 NEhkB7gCCxfQwJOWRDhZN0qsdPKL+bzVDErs4s0RqFMs06Kb0bPPWDc2vomUNQGZ3qLJ
 4piwZtcSrj53LAYfpoPLgU8MKSTFiNvsLns+3V2eU8R4TfCuNKhEqvkG1Ezl3523lUSe
 MBvDDknXm0IRmYKLxCanaHCj20mxTlgIrkRmCdsy1SW8Z2jCdJkpVfTgvvt7oo/Q0rmd
 ycftHwg5DDhji0TUPzq5ke/Sprlkn1GO2f0BrA0P/58k5tDfJN+d3FiuLvUqIRa8tTGe 5w== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbm42p17j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Jul 2022 23:23:51 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26LN91Xn022239;
        Thu, 21 Jul 2022 23:23:51 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1hugk9m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Jul 2022 23:23:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gVABM+gHr+geBqtUsG4GfYc8aQ4E455SevIftK5Owl71g2HjZYLYZNd4C4ISzPL3yBbnE+pPFjXKEXatqbDHneSxkkFvnLSIUSLuntJkSs/H3pKDc1S5mgAmAc553NhdyWZ50b9phx6nvl7EPs4InMBgWB5xj0L7f/dl2lBgfZf9ffydNAp1M6Q4AafBOLgk1f36kkd5r+ymbNBsUWZcOnk5GtyWgBgkT9cEzAteCUyVmkH49MDGhbX1XWvINVKaIehdJ88uULrmKgk3VipufJksUKJE0XhJLJIjY5j7m0286i1IJZTy++hFeDTGD6qnz0ZFvv6JqPMPasAtZwdKhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h2TrZNmErSwVGuzwAXJkSZPQUIqTQpGkdve3aOdmGlE=;
 b=YbKNKBrI//O53FBq8M9uJt4rtoBEClE0DWIgg7OkJMtqm4qP60EWUjDsBnwmqxbvUtHczxPU8/NAI30igsQdLnWXbdCA/+dXfNJgNyPmNnEGjyWAhNPjjhU5zXmF/MpDXPHw1a8tUPSSnT//SqJjJCe87KPipO7s64eQonE4yFYY6MbkxrsnDMj3KGreKWeycKCmnLkcV4vcwfrOmYSY8OZLnEh3rLhpDEgBtBGiEMQTEneRyrDR0TOMgIq1j0QhX3vEVkky7Xs8udZ/E7dSWtKrNfvh/0h6Bw5H9osdF1IKVzH/6bPKYBYIiyNx9Ff+4RkIXaHbVGphtcw/kwuJ1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h2TrZNmErSwVGuzwAXJkSZPQUIqTQpGkdve3aOdmGlE=;
 b=hf7iB6DN4FZLO8scXz8w2koQm+GXBsPs3v4oA1ZFAztLP12YxOIka6lwWIsXAI28J1jKnEDxolMNGQ+7eNWceo9Fcmm2CkS/dpylfg4IE8DesoIOMFIv0jXtQ6x46avxhWvjUmQwRU8c/GxtqwngGMBoryNhWnwDclpe7/KqSqo=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SJ0PR10MB5583.namprd10.prod.outlook.com (2603:10b6:a03:3df::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.23; Thu, 21 Jul
 2022 23:23:50 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c1ba:c197:f81f:ec0]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c1ba:c197:f81f:ec0%4]) with mapi id 15.20.5458.019; Thu, 21 Jul 2022
 23:23:49 +0000
Date:   Thu, 21 Jul 2022 16:23:47 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] hugetlbfs: cleanup some comments in inode.c
Message-ID: <YtngA886kRoFslmS@monkey>
References: <20220721131637.6306-1-linmiaohe@huawei.com>
 <20220721131637.6306-5-linmiaohe@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220721131637.6306-5-linmiaohe@huawei.com>
X-ClientProxiedBy: SJ0PR03CA0160.namprd03.prod.outlook.com
 (2603:10b6:a03:338::15) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a69c8891-3a06-49af-5b42-08da6b70115c
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5583:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v/tcsgdtjVpmCF7HibsPr7I89PSsM9AKC9bpilUE0FT7lyDKuGyQOQdE0pyx7LirmPE/iiBqJYqcpdykpRaY5bsoatXSdOHpbKBK+5YUSK4wCO3appRJEzOUfDPgfmv3/ZkZGViCKIpIdP1bn8uhmyoqrdxUknvPUm8//tz+WIhM9MJDv3O59obTkvgzV5MrXFAKd21DT0i3UrDUtUwI1/vF+xGbdxSeHDKFtb81xoT6hHC4/RyOOwi/hCEly3Xtav8ogSjiWzakpoAAV8a2+1fndP4HXIidxS1zNwpcrz/Sun4N2SWxUHMxMtlPtB+F3ebx+WLfpmYo2CPeC59fqzM2MgGHgbeeQayE06cSyCEPuUzZEE6b3Cng0zr66ZekX/xNY7Kvvh+tLCMFYNcznoNKY0o/ALOa7DaWOxvRTX9eNM6NmFr2l41yO+GpJj5wabvEJv1vfTh3aQAvTBgE2ez8vsuLLytx9NgrbMHOulDOco5+5M0ubFsJDPxXmtL0nFF00CI8B3Nd2FbWiagyB/ihmYLWox+dhnrl3QQcy/KtiKQpOMsqDmCkfSvllXk60v08w0drpm1bww33kVGJkGS5lVXjUaVDTTCsnxqv035onIux5zR3pcDKvst0RQV06nfP+zLyjxac9bFifnyHC2m+1gJZ/QSMPFbTbkMUVBEp//YHPXt2lFbptark2avvCK3hk+/sZfwVtdDXP/sWPEuRYX5Cilx/mZINAGaa/mzfJRz7mG9aMfN+Lfb3DIQ5
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(396003)(376002)(346002)(136003)(39860400002)(366004)(9686003)(66476007)(86362001)(26005)(66946007)(53546011)(478600001)(4326008)(66556008)(8676002)(6486002)(186003)(5660300002)(33716001)(6916009)(6506007)(6512007)(38100700002)(41300700001)(8936002)(83380400001)(316002)(44832011)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?x0BILDHTI5+pcbZa/NbiA48UXt59ootvq3u/+847jKozKBFnsNN8akYAgQTJ?=
 =?us-ascii?Q?j2YedvnwRC8GwsVGh5mtZL6sqpc3w0vCTcTQVXjafJEqMovyhXvjwwlxeru4?=
 =?us-ascii?Q?m2L/OcinVMX2YuDi5MragX2nNY0v8xPjV9Dg1VvpX4iqobMfnE3G5qS4bZCc?=
 =?us-ascii?Q?4nqQCzMrsheiFTHz7U3SZJksMUFylHQ2DPcYdwRUbPQDMwnTKyILQbvnITML?=
 =?us-ascii?Q?ryAO9huFV7wMTmPhw3R9E0HCp3cIUSuhd85WBhHHLD3KCaa9ATM3lVeMfoTY?=
 =?us-ascii?Q?k8Ecb6Ay/QqHZzZ1ETpX3AGV6jMsXuFedXqKin/rVwFi54eEd8qeVr8ptnUw?=
 =?us-ascii?Q?/RfahZIaXkwwVoIY3JOJWBBIuX0WSo0QaIwTEYYDnhV0JSeKAigrZ0Nw1bbR?=
 =?us-ascii?Q?0Ztedj7L4dJ/MHUyz6oFLyr+c1Fgban54N+j6eMQ0Eh3ajRXaP2H9JVYTMF9?=
 =?us-ascii?Q?XLLqCeqlPWWaXp1kUDtHHHIYIY3OyoD3d1OTaruigp/4W8TMdln8Y6cnTCJi?=
 =?us-ascii?Q?Bw2o2h6yah8JDjfu67wpQatP/N/77TISJAn2GGPdfGPkeEI346Y9P9quMrrm?=
 =?us-ascii?Q?/jfg+d9LRgKyVaz9DWWN27meUijWBsZEFMUxeIIl5hNZXfTT7OHeiJQg3Kv9?=
 =?us-ascii?Q?Fa6RBDWkG7dl54agCDaUO1NZjbIOyKRlLlh2+Nu71gN8QcRsNzORwECvuTjM?=
 =?us-ascii?Q?wkmnhfw0BWM+OL9Hf0WvGjzoHsYOy7ELdZlnld5rTLcLdPb5qBaFjNih0VjJ?=
 =?us-ascii?Q?is1kQSC4p0wXWYn57gHzUOzNid/uZHWWiG9MJErBmB8tiNUTLI+dJ35vCAFA?=
 =?us-ascii?Q?64+Oj3JtQq441Or+2191iDofw1ss3ap62y6U6qQGtQZu6IiRi7kWmGaaW2iu?=
 =?us-ascii?Q?TQo6B4zRPuX3adzbM378y9pTBO5ktdrPoSwSe42Pho2ik6WbjrXWJGwtyeC9?=
 =?us-ascii?Q?9CrG5rb9G1Ocw75gtbEPSbwBffHg4mI7umPXwDR4qEmMI9rRjZT7OyFqAUux?=
 =?us-ascii?Q?TMQ61szBpRnBlWKxFeAxvQ4OQ9DcKkbSUtucA9PPtPz2RHAfwLC6mk9VS/u0?=
 =?us-ascii?Q?lqyOtzEVFsXRnigH751tzTCShYth+blj86UX4qDxPVukexzD1cs7ZLeuV/lD?=
 =?us-ascii?Q?rKoimD1zGq+8uXRDX9z20gdesxQM1KXslgBBxYaYKpVQbeH8eXxncDxU67s+?=
 =?us-ascii?Q?9iHEK6vX2W5G5LBnFtlQOuCgWSF4ffsUgq+t842SWXHAStSa8jYFTMgeIYMa?=
 =?us-ascii?Q?HXgs+EvgEiihQL9k/KZJaXPsJS9HJBCVFteAt82YudRz9++py5iqM+84vUr8?=
 =?us-ascii?Q?EUam7cR25jtzJHGu8NJ/5RRQYyk7P9+T/wSmm68BEi0iJNF1j+EZRq+o+Fg4?=
 =?us-ascii?Q?cohNGuQjicJy4htmEGVrl458m33gYecNQicD0WNPj5O03uiPLA/YFTJM1Dvh?=
 =?us-ascii?Q?KKCe9JwdqcGEBBiZKBSjV5soLsajzA6M4QwhHIpwn9/2IpyzkzJA1aDOd8AM?=
 =?us-ascii?Q?2RybtiKbrf77QjqkByzyGZZG+i/jbS9DQgDEa+1abfB9Ro1COTQEReb/tRF2?=
 =?us-ascii?Q?wdLlpd8CKk6ME3N0bg1GEhHcaGulAB5RQmMjPIWXS4wzSW3aBpAFF3V9hE1S?=
 =?us-ascii?Q?SA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a69c8891-3a06-49af-5b42-08da6b70115c
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2022 23:23:49.9215
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rY2FTgdSfcOFDlWQCk6si4gQN4+E6AT/HB/bNSs9BaK/i2LcS/o1UY0/wKAYT5jFVdYMYUxu/IFWtcblrJfNLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5583
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-21_28,2022-07-21_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 phishscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207210096
X-Proofpoint-ORIG-GUID: xLENc6VrNSj6HKyzCNnQQdvFIhanOL_o
X-Proofpoint-GUID: xLENc6VrNSj6HKyzCNnQQdvFIhanOL_o
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/21/22 21:16, Miaohe Lin wrote:
> The function generic_file_buffered_read has been renamed to filemap_read
> since commit 87fa0f3eb267 ("mm/filemap: rename generic_file_buffered_read
> to filemap_read"). Update the corresponding comment. And duplicated taken
> in hugetlbfs_fill_super is removed.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  fs/hugetlbfs/inode.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
> index aa7a5b8fc724..19fc62a9c2fe 100644
> --- a/fs/hugetlbfs/inode.c
> +++ b/fs/hugetlbfs/inode.c
> @@ -313,8 +313,8 @@ hugetlbfs_read_actor(struct page *page, unsigned long offset,
>  
>  /*
>   * Support for read() - Find the page attached to f_mapping and copy out the
> - * data. Its *very* similar to generic_file_buffered_read(), we can't use that
> - * since it has PAGE_SIZE assumptions.
> + * data. Its *very* similar to filemap_read(), we can't use that since it has
> + * PAGE_SIZE assumptions.

Since you are changing the comment, I would just say this provides
functionality similar to filemap_read().  filemap_read is now operating
on folios which may remove any PAGE_SIZE assumptions.  One day when
hugetlb is converted to folios it may end up using filemap_read instead
of hugetlbfs_read_actor.

-- 
Mike Kravetz

>   */
>  static ssize_t hugetlbfs_read_iter(struct kiocb *iocb, struct iov_iter *to)
>  {
> @@ -1383,7 +1383,7 @@ hugetlbfs_fill_super(struct super_block *sb, struct fs_context *fc)
>  	/*
>  	 * Allocate and initialize subpool if maximum or minimum size is
>  	 * specified.  Any needed reservations (for minimum size) are taken
> -	 * taken when the subpool is created.
> +	 * when the subpool is created.
>  	 */
>  	if (ctx->max_hpages != -1 || ctx->min_hpages != -1) {
>  		sbinfo->spool = hugepage_new_subpool(ctx->hstate,
> -- 
> 2.23.0
> 
