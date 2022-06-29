Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D71AF55F27A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 02:39:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbiF2Ajc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 20:39:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiF2Ajb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 20:39:31 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B284111166;
        Tue, 28 Jun 2022 17:39:30 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25SMYRZn019856;
        Wed, 29 Jun 2022 00:39:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=Sx9e191KWx371OLGYvJqE/YU7mAauMdkIioDIydZCJU=;
 b=B/bHFSTfGud0BG0aAEBqS1P5EtwaQVe/k/rUQHV5rDkW34DFoI+DYR4Vqla/miN5y5jj
 4RUcp9oq7m2/DF4mSMkagds08Q8g02muRl3gDrO07qlv3c6tNCXoL9DIQGIavknRCs2E
 mSnj+eSN9z/irwEvJa/7UDMIO5lX/77ebIhLIMzqow7VpnSw1r8voKsCKqoIzhmmQDjb
 Wquf2gFZtO1ZY1yO4tU3TCY7c5paWUrrhc5kZldgQ/PBnegRVPatQOh0obmVZapO/tNa
 EP+UR8Rc/vMgipUff0lylhbCuxgpj/8yitaRtvQvrjv7t/0cY3Px8L0T9paRIGqyl1wW OQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gwry0ftp6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Jun 2022 00:39:25 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25T0aLvs007831;
        Wed, 29 Jun 2022 00:39:24 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2041.outbound.protection.outlook.com [104.47.57.41])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gwrt2nn18-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Jun 2022 00:39:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lwG+X/71BYzD0huitQ/3X67O8qunYZ48J/4mMHrELx6qeSVXrT1VAj44eOJlZcYFz4r6J0h0ml2R4Ey/XCMYK5uBAs2IpUG7KPvsTZMbIDE5Zbbp7vS8iifAeiTfKNZQsT3xGGVZhQ8NUwVUm/ib16qEuhVHEwDyATq0OCvN2kKnre8o8P5siTHdxEIhog29oqulIGBEoDlLb52PeGUl3PwfIBwBY0pgwWuXzrRIy1Sbvi/YJkxA87Xdiux4CHKaf1QhUSKYJRMnl+DnWA5npSRlYH6hPBI52sDxawsbxYoRTX58HmSqTmYKZ/AJFD5Ofglq84zGyYx/sp36rdFhQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sx9e191KWx371OLGYvJqE/YU7mAauMdkIioDIydZCJU=;
 b=i2/pIul7aK3PicwKu942umM5HYBvXNgZOSnAVzi4VM4vWS6iaXhIDnZul2cKHPkFxry4lkdSgJTzxR9DaY6aLyUXWq2HZ+iMYj84ponNBkDGDfOGPD/LbmRSkZFmpRSUWqoTJqn0MfvooeUwaRQ3PpuCcxlUBKnOkes0W2JshuUUHvLrXxwTW42LXdsRiwAsELGrPWrxAE6i+bZYipX47PYJuzxGzUIuNUx3OaIXYMESgl+e2OjkHNJeRXTmkvJ9DfvZnRBB3rOkKZ1oO/nPy0r6HZ9WVkcrt5SlLRf32mCkEdb++H+8whsyCwKdDuMPiOiISF4JFDQEWBQhIxq1kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sx9e191KWx371OLGYvJqE/YU7mAauMdkIioDIydZCJU=;
 b=oHbjkd8bVuraGXEr18SzYwkMGmCbmcJ+QBZlcDSRvoDDh1yfB9v3ZsDkmOZDnKW+rfzNVvZNbOFJWf34agFjrzKpeLI6bL9QOu3ENI/w1dvReAc0kBJAiMWApxu7tZFpQRMaPQoNz7XaegxpHu1WXt3nRVV7rbfC4lRG8Ub1Dnk=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SN6PR10MB2815.namprd10.prod.outlook.com (2603:10b6:805:d1::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.16; Wed, 29 Jun
 2022 00:39:22 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c1ba:c197:f81f:ec0]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c1ba:c197:f81f:ec0%4]) with mapi id 15.20.5373.022; Wed, 29 Jun 2022
 00:39:22 +0000
Date:   Tue, 28 Jun 2022 17:39:19 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     david@redhat.com, akpm@linux-foundation.org, corbet@lwn.net,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, duanxiongchun@bytedance.com
Subject: Re: [PATCH v2 8/8] mm: hugetlb_vmemmap: use PTRS_PER_PTE instead of
 PMD_SIZE / PAGE_SIZE
Message-ID: <YrufN8Zp8J20Qat3@monkey>
References: <20220628092235.91270-1-songmuchun@bytedance.com>
 <20220628092235.91270-9-songmuchun@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220628092235.91270-9-songmuchun@bytedance.com>
X-ClientProxiedBy: MW4PR04CA0117.namprd04.prod.outlook.com
 (2603:10b6:303:83::32) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f55fceef-455f-4639-30db-08da5967cf36
X-MS-TrafficTypeDiagnostic: SN6PR10MB2815:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wqwLceY+92kP19XoO+K3Fgkml3pdrMn3DsJ98M6MdjT8kk95Pr5W8gqrKkENs22wEXwfpDXZbqiLnIgveWIE7XJa7vyhfbGdkBYgSb0hWPWblCTZ58JgzflEZMS4kX0vnRuADRHqCCKOPRsLh4mm439cBMlC4L+BaqLRqkoKfbO2YGVyLO5i5zLjTi6mLfelJjYgfa+/jyAwrxzcZ46+5z2CD3LyzF9upKpWTcEgKFMg/YAQosxAkw6f6w0GAZpPH4WC/vKfnWib5zk3fqgpfF4mTWOPs6pehx6RXuyYBpTW+jgSJLzVzXSC2rkYIjCf50KwKfQE+cCTUeGJrv3IwULJ4u74c4dnOQ4tmlSh7tsWCYr/ucgzy+PY5cqtNZZGOOqccM/r3plJ+Qpqc4YTSHtJUfSXSl1tizBZ7vLKCahymh3vBdDDlVnpqUhihQx83TBXPwWEoTiu9y1Kxwx36zl6VnxeOTMzsgvUK0d6WJj8Fl07KzQF+n+1VghjZUVsa2Gt6rf/ObpN8Rx756L+w1jhG0r1rNpRbvkcg6XXwYcZXWuZt85MhPPrynSWgEEGepsbfMG4W8oApNQ1V2VeTJeM0bMNBtwCKV+4glk+PWbacm8Pg1fdQCd5+PjhOsMsgcXif0e/Zy83cQfV3kz5Gnz5+WtrpKQRpQmYgMJSwJptjab0lFZ/FUBqKkrE8A/fklibAy0HQUmx4Pni+z8GN9jQVyQ7in12ubv0fy6wP6c=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(346002)(136003)(39860400002)(376002)(396003)(366004)(6916009)(66946007)(86362001)(53546011)(2906002)(316002)(33716001)(66556008)(9686003)(8936002)(4744005)(6506007)(38100700002)(4326008)(5660300002)(6512007)(26005)(8676002)(44832011)(83380400001)(6486002)(478600001)(6666004)(41300700001)(186003)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aHZw5Yg0WB6pVa8hUKwk76tHsXXIOQm9tFQ6y9pULu1AqzCK9VW9OU+bqg4W?=
 =?us-ascii?Q?kep3xpwr03zAjDPij5eFc0mmfwd50ekiR7O/l0qbXZX6TvLJvQSwbHmNNYWX?=
 =?us-ascii?Q?5NFa2Y1fndIiN3MGyXb3ST0v9WYsJPo+3bnZO4uvX+I3hMVDUF7/qem25+lD?=
 =?us-ascii?Q?zl1jEEpSF9/EFi+KRo3uKYLrWOvsOL8NQRXLcvaZoei9EajNYdsilVXtALXD?=
 =?us-ascii?Q?mb/VyFOVXVqKSqmIaT3275QwU8CEbZO9XIEY0tyfmXeefPOTNcTG/5EMfLSP?=
 =?us-ascii?Q?9NixnvGivtG1K+MFbHCn7++mr3PlPtLBCYpzOyoRHhZUBBL+2xnQ7DuwPb5k?=
 =?us-ascii?Q?yOyZQ2Mp5gD/7I5Mlbshg600245grKfoq1ObFoRCD3LSpPwYkQNK97jKL97P?=
 =?us-ascii?Q?5bw1T4XJsF/2nMWkeAsWpw1F8iNtPN36LFZRkscLD9W4KrIzhVJWQSMVwhjA?=
 =?us-ascii?Q?UztRywc/StXKPkOtjU9grcoJf2diua1vXf/3XnQRPbQgiPfddeNpkJ3dlkw3?=
 =?us-ascii?Q?f4OJC7AM8LFwlQaI2SHvzD37lb5mp/Xa0TcjX7PLpdoe8cFpCw/DXEq9wvkO?=
 =?us-ascii?Q?imB2jZZqdoxmyuOh1BRoatjAF6IIns99qTM86Ej/HqTuJj2zWVxRUoQdwOlP?=
 =?us-ascii?Q?iAn1Mg139wyHo7PUAD5dJ+LzaK+897yy/f0zkCSSlUFgNg9fnML6+832K0ON?=
 =?us-ascii?Q?+JtMYJmUGKVKHl6VS+6UdOnNl9WvZwygBZmfXANeLpP1vOiDp8FhlU9dvfMW?=
 =?us-ascii?Q?onA0KaBgYnt3UWwBjkVDf7uempXnqblFFKsXbvRcKweZBcRIs5LnKHX7HgXM?=
 =?us-ascii?Q?zEKcsC+LMUQPuf5Ztx1N0KchZy2fYqB5hdt2SMENkUNa/t+C9CYg4EFvSX+f?=
 =?us-ascii?Q?Mtpp22AZq9IUROx80N4BYFfYYTB5r6OuVClzucw3vxcoo5QuLU1jqvZXJ+mT?=
 =?us-ascii?Q?1rgXnMcZm+2EIMfFK6DhrLubBn7sgdPLHMf7r/9aCTDpoJpqhprh7EYxJvGu?=
 =?us-ascii?Q?OIJlq0hCF8BqYEOEe2ntiPGQqW79Pt0Ci0WHtYp4glsBvMgPvyQsAfD8B4n/?=
 =?us-ascii?Q?UAuZgYIZ1Nn9/qzcaqUUcOinWdLMoYmlnC/cdRfcMiwDfpVhRsK4xiT+TThT?=
 =?us-ascii?Q?wOiOxXsqfO6mvHEYzklgRDnARheSi1aG+BOpno+nbetGZkkmkx+iLChoeXKQ?=
 =?us-ascii?Q?p5I+TdoGdiy6P1UauuSU5Zoaa3onnncVaPUq8IfS4jcPy+Nsl3hMAEXimGKE?=
 =?us-ascii?Q?c7FYUQbFQHKBJGRuA8dlstoJeV0EPyGORf1AmGPlNjHmUTJjqpbpbH/SyxlB?=
 =?us-ascii?Q?kSexH9EwC3XlOSAkngh9CXDoVlKn81W80AYnl3vlafI9tjXtj5lCrWXmVJ+U?=
 =?us-ascii?Q?jmxvmO4EuS5kW5LOyYZz9BB9m3FUTwcSMFr72h7LRgdTmbm8y/6eqGJOaD+e?=
 =?us-ascii?Q?H3gvMS6gCuieXC4s30QFGsABWJVB7l1MqYVcFinW0Vz19gjUtHGzePoUSDN6?=
 =?us-ascii?Q?NR9nGQjga6pfB0dMRqzCqIYMmKOZ8B9ZNB45tCXCsx2LcOusHbcBJgtr/uHU?=
 =?us-ascii?Q?zgek7MaiaK/000+9BG9lyhwf2Ee4gXIouNQFoXOI7BgrDsyNC3iHRcxfQ0qJ?=
 =?us-ascii?Q?LA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f55fceef-455f-4639-30db-08da5967cf36
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2022 00:39:22.0847
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yLYauAkqyqqHMvoKAVTsJ3pFeeImmu0e/c7xsbD89zsrIr+/s82QKWVI8X9vh/f7Q/oLf0HujjrlPZFzksn+nA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2815
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-28_11:2022-06-28,2022-06-28 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 phishscore=0
 malwarescore=0 mlxlogscore=999 spamscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206290000
X-Proofpoint-GUID: Q0_VEo5FiQh_hzd1z8KhbgzFCFJ8jK_6
X-Proofpoint-ORIG-GUID: Q0_VEo5FiQh_hzd1z8KhbgzFCFJ8jK_6
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/28/22 17:22, Muchun Song wrote:
> There is already a macro PTRS_PER_PTE to represent the number of page table
> entries, just use it.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  mm/hugetlb_vmemmap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
> index 6bbc445b1a66..65b527e1799c 100644
> --- a/mm/hugetlb_vmemmap.c
> +++ b/mm/hugetlb_vmemmap.c
> @@ -48,7 +48,7 @@ static int __split_vmemmap_huge_pmd(pmd_t *pmd, unsigned long start)
>  
>  	pmd_populate_kernel(&init_mm, &__pmd, pgtable);
>  
> -	for (i = 0; i < PMD_SIZE / PAGE_SIZE; i++, addr += PAGE_SIZE) {
> +	for (i = 0; i < PTRS_PER_PTE; i++, addr += PAGE_SIZE) {
>  		pte_t entry, *pte;
>  		pgprot_t pgprot = PAGE_KERNEL;
>  
> -- 
> 2.11.0
> 

That certainly seems like right macro/value to use.

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

-- 
Mike Kravetz
