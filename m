Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95D8A5679ED
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 00:07:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232214AbiGEWHG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 18:07:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232039AbiGEWHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 18:07:04 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 743A119C18
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 15:07:03 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 265Kx1Jj028599;
        Tue, 5 Jul 2022 22:06:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=6bIx7k69ypP388KyUhWPJgw4e9Hfykl8Db7BWtsnv7k=;
 b=DFz9U8G7JubnJGef8B2N3BDkQ/6Y4HyxNw38sLZTnhxP1KrE0M8FhZeGQDLCUt4BnrTD
 BJZ8MjZtqiTCyxKLUJOIxcUkoqPQF4lvrn/vsmPzR9ewIRCPVPF/js/sZkvlFIbJV2qN
 b9hkaKtX/iwtqSBIHJju58q0255uDXhkYKYqbWdEZhDwls7QrG9t8ELlXz4SZlmEH3se
 VWSn5eCmyoWU3MvgZYk0dNw+c2WN1sbkP3vqoCAUqSfYK4wSx6O3RASXqHglTah3KBPo
 pVNMK3AzMxOpqb++0wmCEiWijJYeYT3TpiF+t6BWJJZtbdv1mrVLGl+GHLI9Yu7EQEwW Sg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h4ubygbxe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Jul 2022 22:06:57 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 265M5HQN038236;
        Tue, 5 Jul 2022 22:06:56 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2106.outbound.protection.outlook.com [104.47.58.106])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3h4ud5js3q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Jul 2022 22:06:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R1jikqS6y6Dknlh9o8uXQATJLPjj4YHB77MLf8s3nc5BpEp/8d74ghK+OCQ6XRDhc/t+pinwVIhYTgUeN5l9FUUle2CTiKjXEI0+U49r+CS7cH0LiosQcsiXzj8gkZL2H24+zZtPu126h+mS8p/U34xwCyad/2VXsIKpuOO3qcsFIghx6aHPt+B7I3LWJIVLX4tZhoqtM1NoTM3KjeW/bE2iEpMBapT/3w52KlkTMXJutq/oehfbgPMaDROC+m0Mz+txLrZYrGhMRyjGcCvsNmr7JyBluGiiEn72rSVQMiUoDP1PoUPfirWlU7w5GlKVnt76/MhHw8B1WMGkyj8B8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6bIx7k69ypP388KyUhWPJgw4e9Hfykl8Db7BWtsnv7k=;
 b=U3/B4YlIGGLmqonB2d58bxmd6A6hE3qi8GcoSEtTPy6mjNkB4Cbn/bNf1t8LWIv2RXpiics626dHt7OIxWeOk2d47AwdF10S6mjog7iiw2QPqzRjDXR67+kVc8TMM6PgjOHnBl1tKQw1D5Xk3AuZDnC4/vUxLTRPHcbutRDvsVvmuYNkgboeeXwjrsGcGvOBWPuMQNUCLwbZUulK8lzTErkpYCvhwcP2gYBTjmMg4VKwNk4EhVoHN7ar0JH8+QcokucncOQiLarjWrNbvKMY6BczPidP+t+kQx7rL/+ORpT41MNoW1+8WDxialeATGrIJVkyzG2iR4x6Ph0zTc5xXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6bIx7k69ypP388KyUhWPJgw4e9Hfykl8Db7BWtsnv7k=;
 b=G8HAzFdUnrYBNT4y3Qwu7k9I00QhGqxgcSVKZdL0s3cFD4Eaa2JZlJgcgxUlDK2oPeAkjbBZ4CfdpMYUTit7Q0oXEc0RU2/mXWE3onPtj1M90XOEm8jmUgiRIISI3bCOAWZQwcm2HpcPu0+o4Bf0l4VNYs0Heqq8yJ5yuK8Pyd0=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SN4PR10MB5799.namprd10.prod.outlook.com (2603:10b6:806:208::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Tue, 5 Jul
 2022 22:06:54 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c1ba:c197:f81f:ec0]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c1ba:c197:f81f:ec0%4]) with mapi id 15.20.5395.022; Tue, 5 Jul 2022
 22:06:54 +0000
Date:   Tue, 5 Jul 2022 15:06:51 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Gang Li <ligang.bdlg@bytedance.com>,
        Muchun Song <songmuchun@bytedance.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] mm, hugetlb: skip irrelevant nodes in
 show_free_areas()
Message-ID: <YsS1+w/zWEEwFbOq@monkey>
References: <20220705092120.2158-1-ligang.bdlg@bytedance.com>
 <20220705142547.da3ea5a7383a7eeec3a93665@linux-foundation.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220705142547.da3ea5a7383a7eeec3a93665@linux-foundation.org>
X-ClientProxiedBy: MWHPR22CA0058.namprd22.prod.outlook.com
 (2603:10b6:300:12a::20) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5db749ea-54a8-4796-5b84-08da5ed2abd0
X-MS-TrafficTypeDiagnostic: SN4PR10MB5799:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UHgpYwlkUboF3PAvZLuNqyGEpfZ9ZzoYV9gT7/y9Qd/cl8uQy9CokqzSdUod48ITWIA25418pL2ySMGKwe8JigxrWodlmf2rtG+Gzh6ZK9MF2YQGHHnsIj4M2X2RzI08iMZMSJt2NldWzswLYnQ44HkJxF0HxuIgYkTgrzkIFiYGTfboJ2QJk/ELyD+8eCJwn1h7mFWwTF49Eka+qm/+jT/8kvoS8yM6rrW/Czy4TLTtNYxLGiN6cCD3zmWxo5gDihS4kD92E+Bh7xzYRe/q7JHUX+V/OpqF3m5BqDSEAWFCYCHiJoNwouC4fPrKHE6pXAYxeLBdK/ynofQGYz3k5oefq/X4dx7uKWaH+ek1QFQcQLAYqaQQ6Qjk7t7RGllDzhxWrUwSV7As9ZtOqiW7SPpkaQZOjNQFChb4rLLEJeg9AyfqGNA9WXAM//unynQogILQXw0aTTiiwHN0UzO1nw22qz4CnR6g1ad3vzvkyMuBRktzBeQ3+SMCkePk98/uiwjO9Ajuv04KkYJYOZ5atpqr/ZhbIu+LZbRW07kMtIQ5YgHOGVHQj8XSpcA1SdrQtY794PZgTyU95igV6792T9mP3ANNXclldhT6UaF4FdXPoK/SsIJ9qoCuWu02ZgVeDJW7Gl6mP6AhgMEZxUhI7yL/Quck8nqgXmbgADP2/POgo5fjNvYoSvHgEX72u1ePdPxY7I8jXC5RBNhSQ9SUdiy5jTXYqh+tZgzvp9sXbKdT1zY5CM7WIcFvHalwSVDX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(366004)(136003)(376002)(39860400002)(396003)(346002)(44832011)(478600001)(5660300002)(54906003)(6916009)(8936002)(316002)(66946007)(86362001)(66556008)(8676002)(6486002)(4326008)(66476007)(33716001)(83380400001)(9686003)(6512007)(53546011)(26005)(186003)(41300700001)(38100700002)(6506007)(2906002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ojb/nxm4zZqQbm3x2SD21hKRfuFW2Meptvd/UUfkWaCxAEgHKPXxJmMA1gp0?=
 =?us-ascii?Q?zSncmHXStSoMantghC74LzG/n+nNZ8kZrZMuEltTMYDJPWXCcGhUf5k1vLXp?=
 =?us-ascii?Q?2NnQiMpoMjlIeEGYuaOEke3Ss1TM2P6JsQPXWGAKb/e/6gaKfwN1P8UlKpEO?=
 =?us-ascii?Q?St3oNOrh3bG/Gv39vkp6HURk1HKPgJtlIdUdhjVvfnAacfm8O4gkKU9iaveR?=
 =?us-ascii?Q?0OzY+/Yx22VQ/mVt2cCh02V93ZdaoWqcVuTUmPquevOsRT385zq7t1FPW3tN?=
 =?us-ascii?Q?yEQTxKVWQQY3ZSVvkNNybhr3mB6Uq7Uq5dEzXIZSpQaUAIGpFVPnul5ZLlYA?=
 =?us-ascii?Q?K825siL0FgzRYkAIVyP5cMNDRULWHjekAD8ZdFQetux2IM2ZWQs86gOdkL5v?=
 =?us-ascii?Q?ZkZ1isGLONqyp9wBjuLlfwg/w5CIl9yRXo/vLPySIdjqv8TTGadSaCWpn59D?=
 =?us-ascii?Q?69cZrtxOIQ/c/Ce5I0jfOgdlMIWEa6QM6FKEW4cUJD2k+J05dqJBpnIHowhQ?=
 =?us-ascii?Q?EPNf2FY52oW2z1s1wUHm+eEIcAlqoDYxv6Sufpo97ICkYvsUrWTrKM8ckHnL?=
 =?us-ascii?Q?HFdiTr9+zDko0m6q9egTQrhZSUEEbspnI5u1ola49s3sVwUFKTdPmzOXMqkz?=
 =?us-ascii?Q?ZKq3cWfydwiSOa3dRemGeYj8SJDovtbQi4Q5lkM149gd42cwUEEDV6IEWkQ5?=
 =?us-ascii?Q?UaQEUNKCi6xbyuo/830Rd3W+MG4zd2TtEqYBYycjveURcTab32wXeBlVk83F?=
 =?us-ascii?Q?tOyDAnMLRdz6sHAeurI1KDtjc09FuI2mjQu09AGcCeb6SrdKSagGH4ZMi4sd?=
 =?us-ascii?Q?LCrKFK99cC2cxxkAgq3y8lByyeXyUByhUMuHyOzS5GslnXOKn4GuK5uDgXqb?=
 =?us-ascii?Q?cVV25gJYzlMjPW+9Z/WMnHFFwN/fROC5HnaS6uMoGf+og2lKcgRWxbPWWQFL?=
 =?us-ascii?Q?GiUS4B2xUv8/yC14ondvCmAPDJmziPWuenDFWbcNixM3dLH5c1RpH4P/hkb/?=
 =?us-ascii?Q?7Xlg5wuQ5GbYUAQG7A66WdaD7Tn41ho9cjdi4SRErHF8deKUbmiABkv4agYE?=
 =?us-ascii?Q?aT8O58YXkgDRYysm38MoUo6wxnd58WKnBFjloQcK32qLSHhFBiHpXV0uPOoF?=
 =?us-ascii?Q?BN7konR4IKi1DRBZk4M0mp7lh2AZ4+ou2KFb3EBZReaiANVO83xq9rmwI4Z5?=
 =?us-ascii?Q?AafYduI9x+zOux376UciaRc0rs9JZk+hnw8u+wqTrhOW6X/wrXZsQMFw97Ck?=
 =?us-ascii?Q?2A88I3ebwHkqHa7smRyCaa8pDLdKkeclebUhVvWsFlSEeJSa+BhyEaKuCh5e?=
 =?us-ascii?Q?cMhiHNDx9G8psPc2frLGskKSdLCcBfm0dHKv+eUcnjoLSr81JZQSwChAhUEw?=
 =?us-ascii?Q?ruKN7t6hO19KQgnYqyQMCK+NyPJNF03diMSUB4N1L8qUHdIvqtxYl9jJyrml?=
 =?us-ascii?Q?cG8t2Dmk8UemCsCy9W3V/i+grs4GCfOCwgoJX/LSDq2CbxZ+kJYMq+WfqKFc?=
 =?us-ascii?Q?w+819/umyqjmNai2Iy231XY4Ys6B9vicd5LPW/fpEzCTuZFoJIsLmWPT7NwA?=
 =?us-ascii?Q?ICqKxKYvWbf5+341hxqskoe2aE0l++heSXN3VV7seFDfne154ZZGvAhQxQj8?=
 =?us-ascii?Q?4g=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5db749ea-54a8-4796-5b84-08da5ed2abd0
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2022 22:06:54.7860
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GmTLd8GkOLSjHOG2FVEoN10y/zSzugEiqE0heF3YOFQMaTc7EHjYY1SEDjEEUdZ5zj4c131SZrvm005Zh2jEIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5799
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-05_18:2022-06-28,2022-07-05 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 phishscore=0
 adultscore=0 malwarescore=0 mlxscore=0 spamscore=0 mlxlogscore=838
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207050096
X-Proofpoint-GUID: UAMRjOoowIdhtss1gytk7RC8HLb3rCVo
X-Proofpoint-ORIG-GUID: UAMRjOoowIdhtss1gytk7RC8HLb3rCVo
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/05/22 14:25, Andrew Morton wrote:
> On Tue,  5 Jul 2022 17:21:19 +0800 Gang Li <ligang.bdlg@bytedance.com> wrote:
> 
> > show_free_areas() allows to filter out node specific data which is
> > irrelevant to the allocation request. But hugetlb_show_meminfo() still
> > shows hugetlb on all nodes, which is redundant and unnecessary.
> > 
> > Use show_mem_node_skip() to skip irrelevant nodes. And replace
> > hugetlb_show_meminfo() with hugetlb_show_meminfo_node(nid).
> 
> It would be helpful to include before-and-after sample output text in
> the changelog to help others assess the proposed change.
> 
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -6202,7 +6202,11 @@ void show_free_areas(unsigned int filter, nodemask_t *nodemask)
> >  		printk(KERN_CONT "= %lukB\n", K(total));
> >  	}
> >  
> > -	hugetlb_show_meminfo();
> > +	for_each_online_node(nid) {
> > +		if (show_mem_node_skip(filter, nid, nodemask))
> > +			continue;
> > +		hugetlb_show_meminfo_node(nid);
> > +	}
> >  
> 
> Does this mean that potentially useful info about presently-offline
> nodes will no longer be available?
> 

I do not believe that is possible.

IIUC, all memory blocks of a node must be offline for the node to be
marked offline.  To offline a memory block, all hugetlb pages must be
removed from the memory block.  So, an offline node should have no
hugetlb pages.  And, if there are no hugetlb pages it makes no sense to
call hugetlb_show_meminfo_node.

Also, previous code in show_free_areas skips offline nodes.  So, this
new code would be consistent with existing code.
-- 
Mike Kravetz
