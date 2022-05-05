Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B77D051C028
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 15:03:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378689AbiEENHD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 09:07:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346531AbiEENG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 09:06:57 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4178253E0D;
        Thu,  5 May 2022 06:03:17 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 245ACOiP030616;
        Thu, 5 May 2022 13:03:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=zcHc5F0vNTrZJsWyNIrGbaOpUEreIEFn13PBkW4GZ94=;
 b=Rv23BV85Wb+ovltylTUWaienE1Da+bmpwiU7mb7GGewckQNVP4r8747c7OYct18vU/s4
 wcHlxlAPlyngfmPQSS7baxoXCc/0hou+xwe7gGil6KQlwRlK7Hd+um9Cf/FgEsHFzlk4
 E5EymtV6KPiJb1cMX7jhuBOpcSXVcZOi+Xm+ZgWaDYEKQYkPIiNN+zan6+WTgj35Crx2
 G8Rdi/qBn5a+u3HNdCBopQUX3n35nj5JMuPYO3NV+B1JT2onbKiI/a7UwO6naJXt0SjE
 qO29Me3Pn0af4snL1+0P7ggBgQpJvI+VfPw0rDSVOo1e3z6/8z2D38rfpwFPskRM50cw ug== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fruq0kbag-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 May 2022 13:03:07 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 245CtVJ0006600;
        Thu, 5 May 2022 13:03:06 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2040.outbound.protection.outlook.com [104.47.73.40])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3frujapk2k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 May 2022 13:03:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VF/QWvBEQscx2AFlep7u3+TKEf5qZxLaPCRwqEcDUlzNnSbKv6AL4XQr1iFSiyi3MF1cCgDbi93Rxs+nWeZ+UbDyBjQsQDeqxs/rlhm4dcq4sOpmB0zmozEwLjTKjQi1xmljP9B4mhOc9oLWRfNwg0j4WKDA6BcKczDXd9wvzFtf+uSW8qLv5nXUO4LQot/XTE+gNMJ0bgJOpQzce/PHIBHtnafmKBuozol0mqLlJIcwHY8f6vdJfloDBVsRqlOKKVcfc7J1O6Fxp8onbX9Id5bo/oOFnzEyPo2k0DcuO/2gaZcCVqTAvJSQQT/UXcjCbIV5OaBF6vA9Zd1YV5RHEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zcHc5F0vNTrZJsWyNIrGbaOpUEreIEFn13PBkW4GZ94=;
 b=Ov2nt00KA5jrngWnrWbTpJfCt/lx4ewSDSdTj8JXs9fSbPgZ9C7omylvizfk/KbaTKl+ZKMYq2wSv89lCElhor4cjGD2GtsHtBCuv1xjwmYin1NA51tCsljIdzHEEwTMyMOKUTeWYPZIFpmL8ZL0K9d9wFt12yNkUh7ly3Dh5flTX3Y+/TrenQnV5J0PnL/WBXNVifcO03f1z9g2B8DFCiUYm4yN8ieH62EyplNwCt6M8+/m4ncg7Gzmn+rY/TO+CPTKqH3ZCWQXd8+2S1bhFyWKwdRwDaElWKI6BxlXEurskV1k1mKP+urzhhsmZJgeYmDCJAR9rBB+GHLUoPCOUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zcHc5F0vNTrZJsWyNIrGbaOpUEreIEFn13PBkW4GZ94=;
 b=oWcH7KOFB6o7u/8lxpcHSS5F3hBBuAfha2RqitLOZMlgR6RNlPaWmSuVFTIkUqwEuiAqim+18VGNRpKTzFon18M0r4pW41MC8MPYHZ/ZEKOzZIvGDSyFeorZD/6i9zWbgzRRBEzHobTbmpdTrvPhM0wZF54soxU4H9o0YY3Pq7c=
Received: from CY4PR1001MB2358.namprd10.prod.outlook.com
 (2603:10b6:910:4a::32) by BN8PR10MB3394.namprd10.prod.outlook.com
 (2603:10b6:408:d1::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Thu, 5 May
 2022 13:03:03 +0000
Received: from CY4PR1001MB2358.namprd10.prod.outlook.com
 ([fe80::e929:b74c:f47c:4b6e]) by CY4PR1001MB2358.namprd10.prod.outlook.com
 ([fe80::e929:b74c:f47c:4b6e%4]) with mapi id 15.20.5206.024; Thu, 5 May 2022
 13:03:03 +0000
Date:   Thu, 5 May 2022 16:02:51 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Russ Weight <russell.h.weight@intel.com>,
        Tianfei zhang <tianfei.zhang@intel.com>,
        Lee Jones <lee.jones@linaro.org>,
        Shawn Guo <shawn.guo@linaro.org>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] test_firmware: fix end of loop test in upload_read_show()
Message-ID: <20220505130251.GV4031@kadam>
References: <YnOm+9tEN+xerpov@kili>
 <YnPFh6ULhhPloue2@bombadil.infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YnPFh6ULhhPloue2@bombadil.infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MR1P264CA0003.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:2e::8) To CY4PR1001MB2358.namprd10.prod.outlook.com
 (2603:10b6:910:4a::32)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1a71fae9-7d82-4f0c-e976-08da2e9796d0
X-MS-TrafficTypeDiagnostic: BN8PR10MB3394:EE_
X-Microsoft-Antispam-PRVS: <BN8PR10MB339405F97D7B70521F77FC778EC29@BN8PR10MB3394.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DIlqY+JT5NkcSUmH0Bz8S363pWBBET9CCWHgIpsPfT6yA0Xk3pBi/IqP3ZJKZT/WjVaXo5kkNeMHdN+DGiATOVFGM0AzjYZhH3H/yJSKsdEvTz9Z8nq1Ldp0/qQDCtKtGhHFZSTw5vKC9O8bLRoVY5Gd+HghQ98+rD+aBXCJcTm7Hl7fs0Cts/WVaCDQIfoOJYTuNUOh0ZuyxbxIcEdAiIfN4HDjSWBVCL3QSntn26mMqNMalZFRnXVx32xKDSTtGwElvwH73KcW1V0qUerzeYtjmNgRnedQau1yuJv0fyi6+7enzpBlvK+6Iy7Z79B1R5FRFRd7nAOaxA2bbwilgdOFGeGsDeBHf4yPgU/MVSmCF8XQ5c15NtBvdIDo57HRSk3Vgs8mER2CBpG/nkmC1bDLanOfbaSokSLcAGGisANrLepXHU7xXJjqOTPgIUsex8B9NSTmVAjpmeyFeu5P+q1yslTHRNk569R7L1AYOfeJZw9GRFGVBSBGLqq466ZNPi7kDMQ7/4s1UDu/8+OINTIBbaeA/K8YhGXdzzT/7ke3oYuknByzb89f6F35AXnXo1ke+boHVmj5tW/MpGMwWmQ8vebzzpSPjNtMCehidB6VZs+qsoywqZiYp5XH/9HyAq0kwu0jkHazegjgwmDiYGWQ1f/0rM4bVa4Cy1ehbQrx3jTl02SsUfVr+zs92Zda
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1001MB2358.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(2906002)(6666004)(86362001)(38350700002)(6486002)(316002)(52116002)(186003)(38100700002)(8936002)(33716001)(83380400001)(508600001)(6506007)(5660300002)(9686003)(26005)(6512007)(44832011)(4326008)(8676002)(66556008)(66476007)(66946007)(33656002)(6916009)(54906003)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vfZhIxGkAnKxiCd9VBv4NQIUjYGT0VcO29F8Wm1WWYoqH/Ode3UrxvLn/l9W?=
 =?us-ascii?Q?Ys4p/BR/YeCKeIj2NbsxopNCFja5atmNz28/CJcsnsiZz7KqN45/7gC288P6?=
 =?us-ascii?Q?qAO7gM62Ip+Ujk9S8nWgyJMKakN9GPzY6gXb/r7/dRNPl6w+FseJh3++ccOz?=
 =?us-ascii?Q?EXjqTAE4TivC7N8/a7SjMrWAWZ/7gqwY0G8N/r39dck1Dcs1XLxE6GgvUDYP?=
 =?us-ascii?Q?CSsqW3imllbTe8GivzGWcaewARsLl2vvfyg5eR3uKiVXfWGRLL0aBkJd9CCK?=
 =?us-ascii?Q?1ewPQ6XO+8+/395l1b/6VOX9nvUbNwem0Vu80iGl3WTDMLjmyYc/s0xj9dX0?=
 =?us-ascii?Q?f4BKjHnXsTn53htfYTpZBxpBmq2ukN+EzJ8YuDxqTVUrX+3tdeBMt1yq5ogq?=
 =?us-ascii?Q?0kR7iGUMSskUINJUGL7V3xf1uxFW3wWJ4h6wZIuxVfL5nWEunKiz/6bHNn4d?=
 =?us-ascii?Q?NgOAX6TFTYIlAJIeWXPJSx0uTpVId1SQa1kL35zePUmXlUOo5RN3XXdV0wG/?=
 =?us-ascii?Q?FG8hGbYWWNEfPbS4wkLZn3sTct4cVVN5LQ+th6twJNyp3PKbrPgjeb3qHHua?=
 =?us-ascii?Q?5Xof0ypZ9vnYjAhr89ifntGCSqDeK9W+CIBj+OSNmHQRi2o7ByV6yiGwS21y?=
 =?us-ascii?Q?KSQJPSCOdc23PHRC70jUztVnFpPaWUIZv3B+1ms4XAZA+xUZzXXXdvNXW704?=
 =?us-ascii?Q?FxNfh7FAP5+qStnOBOPi1F3hlypiAEpeOWMgglxO65PuBh/nJzj4POVIwwLD?=
 =?us-ascii?Q?tdony5NUhyleB4wu5urGQ7Gqvqd2HMP3APH5PiV/vugfjXFdVK7Bpcz5f471?=
 =?us-ascii?Q?xJylfigjleAMjNFTT3wyZVmw69uMuyQ96BSp/ySeMy2RuhJHhilY/elIMnLC?=
 =?us-ascii?Q?ZeghmYGeSgzJUqtu0rXjvKTkf9lS4NZT4PKrnLuqRdtSVt8E5vrcIIUTEcuF?=
 =?us-ascii?Q?7jKIgySc/AL69SrMrMqpFs0HdtYOGYRTuqnm1jeA0X2v+k7BWryvJof4hSXm?=
 =?us-ascii?Q?hhX8gK8eV0YMxODmEKYXf6rid/8HIm5ZSR3p+g2c30YP697Aw8d8sC7vjMQI?=
 =?us-ascii?Q?oo+4pKk1/Il6INqjsVs9pUri4so22zgTBZUGW3WNMFuUZMp+xItO1esN3a8n?=
 =?us-ascii?Q?jaDplmUjdDxjq5oRjoGeQCDeJXXuefuqn5ZSviOyLiGwzBAjwPez6bJW1Pba?=
 =?us-ascii?Q?29Nufib3crHClTZlx+OryJKzrNA317pPWfkEqCoa5+Gkak5w0MpesIRNUQxQ?=
 =?us-ascii?Q?2ENOdmRZMprUhJs1fkZN08LCodBuU9zZMivlHsyyGxuR+sbp1EUzp3t9+UDm?=
 =?us-ascii?Q?a0IdVNqRWP3YRGZ/Sp3ZRSc74ltJxpG+Pwi93DAGqvQXIlyBLJwhshZnGfDS?=
 =?us-ascii?Q?EeB+H76ddGVPTQ7RL6xaswF04hD2WbiCfD336yZVVKvgyuFxhLkgMZaJQqq1?=
 =?us-ascii?Q?25/Fo6/5GEGec2OuD55SEcPWlEpyC9Po1DAKQZF87skFyw+moOw50rBxTjfS?=
 =?us-ascii?Q?3/MsldRHmxLFl9ESWAo/+H4F4t6rjHLUe6W61hq1J8sTfGtF3G3uDQGEuQ2d?=
 =?us-ascii?Q?8coL6+kTrgl5sAZ2dCSEdK2pG/uF9d3sKbNPT1JkI5Onat5aFIUx+lT1OzPW?=
 =?us-ascii?Q?ONzpwwEaNCDRrdPC9RNDeX+dFWHBF/NMl8aMmz2FuIt/NKLatBSt4VQDvVxV?=
 =?us-ascii?Q?OaOxaVlbMZn1axtRQI9XTfC+xQW7sfcMNN36JoogeeFOl2OQI3H2+PWS1JQJ?=
 =?us-ascii?Q?4TGNYTmiNLqHVKFupB/RYLc6ma4JBQY=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a71fae9-7d82-4f0c-e976-08da2e9796d0
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1001MB2358.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2022 13:03:03.7340
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tEAlbD9tk0t6YpA84RoZkL04KVa/SrgyjjG/p39Shgj4N9U+7UchHBXM+5fDx4/k6budm4TKearG10reI+j0WSqRCGCJc+r5cwP/7cJ9gmw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR10MB3394
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-05_05:2022-05-05,2022-05-05 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 adultscore=0
 bulkscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205050094
X-Proofpoint-ORIG-GUID: 1mVfJR433p-FaKO95TqkPuOW8bNnEQZU
X-Proofpoint-GUID: 1mVfJR433p-FaKO95TqkPuOW8bNnEQZU
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch applies to today's, May 5, linux-next just fine but I think
I need to re-write the commit message to make the bug more clear.

On Thu, May 05, 2022 at 05:39:35AM -0700, Luis Chamberlain wrote:
> On Thu, May 05, 2022 at 01:29:15PM +0300, Dan Carpenter wrote:
> > If we iterate through a loop using list_for_each_entry() without
> > hitting a break, then the iterator points to bogus memory.  The
> > if (tst->name != test_fw_config->upload_name) { will likely still work
> > but technically it's an out of bounds read.
> > 
> > Fixes: a31ad463b72d ("test_firmware: Add test support for firmware upload")
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > ---
> >  lib/test_firmware.c | 11 +++++++----
> >  1 file changed, 7 insertions(+), 4 deletions(-)
> > 
> > diff --git a/lib/test_firmware.c b/lib/test_firmware.c
> > index 76115c1a2629..c82b65947ce6 100644
> > --- a/lib/test_firmware.c
> > +++ b/lib/test_firmware.c
> > @@ -1392,7 +1392,8 @@ static ssize_t upload_read_show(struct device *dev,
> >  				struct device_attribute *attr,
> >  				char *buf)
> >  {
> > -	struct test_firmware_upload *tst;
> > +	struct test_firmware_upload *tst = NULL;
> > +	struct test_firmware_upload *tst_iter;
> >  	int ret = -EINVAL;
> >  
> >  	if (!test_fw_config->upload_name) {
> > @@ -1401,11 +1402,13 @@ static ssize_t upload_read_show(struct device *dev,
> >  	}
> >  
> >  	mutex_lock(&test_fw_mutex);
> 
> Note the mutex lock.
> 

This lock is fine.

> > -	list_for_each_entry(tst, &test_upload_list, node)
> > -		if (tst->name == test_fw_config->upload_name)
> > +	list_for_each_entry(tst_iter, &test_upload_list, node)
> 
> If a lock is held I can't see how the premise of this patch is
> correct and we ensure we don't remove entries while holdingg
> the lock.
> 
> Generalizing this problem seems like a bigger issue, no?
> 

It has nothing to do with the look.  The problem is using the list
iterator outside of the loop.


> Additionally this patch doesn't apply at all on linux-next.
> 
>   Luis
> 
> > +		if (tst_iter->name == test_fw_config->upload_name) {
> > +			tst = tst_iter;
> >  			break;
> > +		}
> >  
> > -	if (tst->name != test_fw_config->upload_name) {
> > +	if (!tst) {

This test is reading out of bounds.  Another fix would be to write it
as:

	if (list_entry_is_head(tst, &test_upload_list, node)) {

But there is a desire to make it impossible to access the list iterator
outside the loop.  Linus was drafting alternative list macros but I
don't know the status of that.

regards,
dan carpenter

