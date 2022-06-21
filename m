Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1646553520
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 17:02:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352128AbiFUPCi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 11:02:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231460AbiFUPCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 11:02:37 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E427275F4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 08:02:36 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25LEIt3v010520;
        Tue, 21 Jun 2022 15:02:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=ur3r0wBPfk5TyMPFKEW8mOvzGvWBKxVo8MvkSmn2nIc=;
 b=YdiDlaO8XE7SA+nfVBFKFHXlUCMRwveSViKkKCRDf5T+YFDnpIPpkDC3wc792lmGgvj/
 +clZp2BSxkfbTC2QCkUVryVpvAIlmufHMCzkLiOgd43S+jLliklznKJkNIuVvMDIP234
 7EEeVMZTSVw+95r24Sgd3jC/Q6x9qvQWjQL3XYWKfScHhIqdUM4V2rOlD2NLYKFehdmy
 Aq+WeiSl+FOjjKhAXCSHfvDiV+EjKjkJCZ5obhACjrNvvDWKWKgfs05wUA0hGxcu88xt
 2HAXhNuOBcDkNPHMvYDACA4q2S4/6ykLkY5f0GCi1zFrtgdSnjp9ou7tlCSaBBtt4g4h qg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gs78twuea-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jun 2022 15:02:28 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25LEkgGV011508;
        Tue, 21 Jun 2022 15:02:27 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gtg5ufc07-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jun 2022 15:02:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z9mI6Hd8ssvYUa2YXRdHt3BrnKbRoYxoFievenupyvofJoN3/lAJQ8oOU9W7u4dl8afBMx/RZRZRmoaQu6y2ysTwi8k7HmF6jsGgPpF/71Ycexw6pDCGYdEzC9yNBnfpmtRPuxH+6mTEDPZYMQG5JAxrRcfV1aLXVUKvvcvU1e6Gw4Eh1SfsHhjavq1CtTyC5OZlNqZtI8ViJ9F+o1rkDe3wKkExCmQX7ZTAJwfComf3ysJRYDKuNjwFo6h51lz7+IE0kYtTcVtdunHw8C5r25hI7XO9hfOVAb3vm9/fnZZiLQjv1foJOHak+l9oRnvYkGoMd19s707AK+gysR8G4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ur3r0wBPfk5TyMPFKEW8mOvzGvWBKxVo8MvkSmn2nIc=;
 b=abFIoEseSvKQlh/s8bBjoFpYumyRCf1TTehewkoP1chE4nG9epsMLELKNG6VVaMro2HyL2fMYRemHOu+09XRRucJdzNEv4wHqwJrKEdWaxlLcxK8rVxIi1Rt8gdNo+/UEM5zgRC3+Y5yM3SNSsFOYMYIcAf6dn7xod+unc/5mGa8jwtUupCqns3w1lvirNjFExy0YlCGLm4EMxxz4SmsXvuVfF1SYJHRHF8pAImJRjOHk30SA6F+zi91boZNARek+Ia/NSaS4DegHonR2CSlbuViZzU1R9S+vRByo/d7PbiIaV/yv2NKI9vkyJM7OJvWk6EfoMNp92iJI9gVe4pOUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ur3r0wBPfk5TyMPFKEW8mOvzGvWBKxVo8MvkSmn2nIc=;
 b=CcQyhxdxW6/3Gvkv9rEcAewtcqwISo0ZC1Nu6nw4Ph3F7Z7HQf8TER5MWOwWz0T26wXiHmNzbTXGbcTBF76tAQkOLKuGY0mQyZ4aUv3QQwBgtcni3O5PwaGI9O2udsI991Hz5wnxCpN7gqrKcelOU3LzJgyZbgCvcclUqEQMNPQ=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BN8PR10MB3234.namprd10.prod.outlook.com
 (2603:10b6:408:ca::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.18; Tue, 21 Jun
 2022 15:02:23 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b%6]) with mapi id 15.20.5373.015; Tue, 21 Jun 2022
 15:02:23 +0000
Date:   Tue, 21 Jun 2022 18:02:05 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Felix Schlepper <f3sch.git@outlook.com>
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Staging: rtl8192e: make sizeof type-independent
Message-ID: <20220621150205.GK16517@kadam>
References: <AM9P190MB1299D518C86D495B168954B2A5B39@AM9P190MB1299.EURP190.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM9P190MB1299D518C86D495B168954B2A5B39@AM9P190MB1299.EURP190.PROD.OUTLOOK.COM>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0005.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4c::10)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: feca769e-b5ec-42c8-cf31-08da53970b89
X-MS-TrafficTypeDiagnostic: BN8PR10MB3234:EE_
X-Microsoft-Antispam-PRVS: <BN8PR10MB3234F54EC67C6EE3889C8D6F8EB39@BN8PR10MB3234.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UxZQozXLxb+YvTg9y1C2AC/ifbw1r1hUXuS4s3ogA8RdSRUETd6Y+bgLWmIMwn5G6J+6BEV+Mdiv+C0sVKUWtDJIZ12/nAQUofTnjPfSbfOLv2OkNeAIYkuuFMkCa+zqvclt0O9NfiiAXpu1NgvpBDle540jCDZO+qWpOvBzl/6ariyk1WK7gfX6pJPXOzYRzUpFrW2LlJRNop2xSce0ATDCj0Zn3pDHCIqv92Ob2g4k2+Rp+wQBb1+7vm/IOEpr18dBQCVyCDYHuO1hhbCZ6KX/dwwZjh03uGUOCJHEuoQ3T6hqP4PGaxO6et+/zHUFlmW6Ogzq972IM05PIhk8z3lTpYEC3co0h0ss+4t4LBgcRIJy/XL/oy2vZ+kKx9BqbcObnet6S5r/UoS0QZhVv3+UTVBKyoWmKOh+OSH6kGYwiq2qwu4wReSxzJxsb33dFBnu001xGv23Z4PjBDgpHqHRMV4nAfEfXCaKS/fSOxi1dRI6gQifkYNFfNW7k1vHL4mL62YIYEY45ELCXd7smJ82byoMcMYo/ojrWg2RDl2nvbBK7YSb2OUQXHu4ohRneTp5EpiJ0HLrukI2Yvdm9o4ERPCCd5v72deTrUu23s6BH+ECspK2CLD4QYmIpmreLYKAuEPaPQxnCXDwR1cc34JEpJHCyTeR2a4cKh5b0vVPONRQHMR22Ha74Vlxh0xfJy8jtPrdJOihiRgwOxfqGw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(376002)(366004)(346002)(39860400002)(396003)(136003)(5660300002)(4326008)(316002)(6512007)(66476007)(6486002)(9686003)(66946007)(478600001)(6916009)(52116002)(6666004)(33656002)(8676002)(45080400002)(66556008)(41300700001)(6506007)(8936002)(83380400001)(2906002)(86362001)(1076003)(186003)(33716001)(38100700002)(38350700002)(26005)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vQ7OdvX1x3t15821T6OUE2vDyJWOt1Am4ipTq89DSmsOYpvBuJ+PcaPzuJos?=
 =?us-ascii?Q?sK3V6WrzVgXJoSTikpFNaf9FNi2FSAT/4OT3e9JAs6xn2tJ1X7tSAMQuLZ5K?=
 =?us-ascii?Q?GZY8TnnT+MvGiIxU0PYGtENVdqDEX8nWeGJ06zOPrWEAgJEV/Wc5lSL7Ly/i?=
 =?us-ascii?Q?LjZg+f9ZjCIsmmeo5Vok4hzo/4Bit23WVIn0mWTx/bwq97sdg1/TFfFIF9Ju?=
 =?us-ascii?Q?fKPTmTWgU62f3wEAJR6yoy8/20ePNxg8WSLShJWqucfRMz+Nnbd8IVrzCyEN?=
 =?us-ascii?Q?guIMDTFRhcNRcw7xQIeTqc9lpfyiTyHpPTcRUuh1L3zqR9zkKa84jw/xUs6L?=
 =?us-ascii?Q?N2n6gdCGWDAUJ7WfX0M3Cd3M75oapuUlp3Y1eTbPK3adansBqzJnRF7FUiQz?=
 =?us-ascii?Q?9wTVeFLoagEpVWw1wMZiPS8PyO3qiE+ahtj2dSZF5FcXMb7YnQbSt/zw732n?=
 =?us-ascii?Q?IjXPTzD8w5EjJtoec8NWBTe0nMQCP0pZODgXxYFcANLPFttTgpB1NcOGBNx5?=
 =?us-ascii?Q?Tf8avhk6nAbEIbYIqBJwBF0HFlizHEuV5x+g+jiOAPOXRJchezJ8gSF9Bs7P?=
 =?us-ascii?Q?otIVDHRGciv+wfanXNV/uscr54TRW0qD7GERzKKpDLXqPwSgl0qgVMym/5ry?=
 =?us-ascii?Q?QLs6VUhXtuj9V258L+uaO3sO+Tc3V7Qyswz1FAoVnARRb/skE410ap/u2sZK?=
 =?us-ascii?Q?HtULdm9/gZhfs6Nn2olutY06B/WD9DwmecB7NoqgDKhUoiixJJMmJwdx57vR?=
 =?us-ascii?Q?M6B9YfvHU8gefyZJu+5oXDj9lKR1wxa5OsvA+kytZihIF0VtYLvnAtUMXEwj?=
 =?us-ascii?Q?Y5ayJh2cF4tNJscqJ3uHEjUpR4kygHlR5r9GvMZlB327emzihhbppH8C4fl0?=
 =?us-ascii?Q?QsW8E2pTCJoVpD/3KUZhKu1LleI6/LACIW1Yu9khWQS+pU66b/+Cvc1fgOHN?=
 =?us-ascii?Q?hBlIyve1mlCuJ4Fy7oNDFRYhzvO9k1X5Oh2WAKiORpatOhAOaiQh1piAX8pE?=
 =?us-ascii?Q?QJNFpn3Suf7PRqWKjKGMQBinNtYfbagX9O0iWt0dHdrhZY7oFJEYLvzH1+38?=
 =?us-ascii?Q?7xO0Wy+8Ih8B0vl3sqmEFUFE8TiEB8v9fkQ6ES9xOnVmtk45kurDm4Dtt0MS?=
 =?us-ascii?Q?+mhlrse8ZcGgcIV5HkTlUs7sbAGdueeNM8ZeAuQjdR3/pIjHHOQaM/UtTO97?=
 =?us-ascii?Q?X2YonMN0Hw7pkwPdY7jXsG2MoZgwZsrZEKpDjlzdM5UPmj0DemyxerMz3ut+?=
 =?us-ascii?Q?qozxVbqzHAGStpT5L8JeTB7PtsKpa0ABqqS4A28/iIzVzUDxckipX/0IZMfe?=
 =?us-ascii?Q?2NKL2sC5leN+GyWkOtHj4yxL29Q/N9Oa0kWtrDUBBQRBeIl352Xvow/PgMdI?=
 =?us-ascii?Q?7V3g05e7R10bfg+Nmr/WN/pCJ2oKgmtJVthyveRFCYK9HnN489jxkIbMG2jm?=
 =?us-ascii?Q?sLiILfbTvmD2tx6XdkrnqVXs2pp8tIBfvx5hTyFBePDZOepAEnLC+su7U8Cv?=
 =?us-ascii?Q?XWYLwT/wv0x8N5ov8f/0J4lGXjdF0zhJx+gG7caRRpgX6T5KmWkBumG3AqJj?=
 =?us-ascii?Q?IFCEshJX6OVtTwtHjxaUV8G1dRWOVfq1JfALO5tMgo5qofLMjqFWMbjkjR/V?=
 =?us-ascii?Q?kEVaHaKbmgVkhs9ZOiJpzSfFQYTdo6RCUkjUvedYan7Wm0F9duM/kl8+GQZy?=
 =?us-ascii?Q?AwksNlIWTGpGoS28X3yCcJ2xiS24I5rl5I05su8Woqx6ZuMj6JQSbpuddbUs?=
 =?us-ascii?Q?UTRFq1nlpXWoC/zW+tfz0LOUkIbqRZA=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: feca769e-b5ec-42c8-cf31-08da53970b89
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2022 15:02:23.1656
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4b0w+bUdQCaO14Ce31SBxW8IDL6Wn8cNCk+XFxmuq7yK3gnwCjm6un5Iv2+wlXgdW7CzHZ+Qu6Pr4PerAW6kzAjT9JN3OM2KlPHzl1ca2Qw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR10MB3234
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-21_07:2022-06-21,2022-06-21 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 suspectscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206210064
X-Proofpoint-GUID: khvvc4Bj7Jgd1RbdrUTbDuzO7ZjpanSd
X-Proofpoint-ORIG-GUID: khvvc4Bj7Jgd1RbdrUTbDuzO7ZjpanSd
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 21, 2022 at 04:58:45PM +0200, Felix Schlepper wrote:
> Making sizeof operator type-independent.
> 
> Reported by checkpatch:
> 
> CHECK: Prefer kmalloc(sizeof(*txb)...) over
>         kmalloc(sizeof(struct rtllib_txb)...)
> 
> ---
> Note: First patch, trying to follow kernelnewbies tutorial.
> 
> Signed-off-by: Felix Schlepper <f3sch.git@outlook.com>
> ---
>  drivers/staging/rtl8192e/rtllib_tx.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/rtl8192e/rtllib_tx.c b/drivers/staging/rtl8192e/rtllib_tx.c
> index 37715afb0210..01e163e61f0e 100644
> --- a/drivers/staging/rtl8192e/rtllib_tx.c
> +++ b/drivers/staging/rtl8192e/rtllib_tx.c
> @@ -205,8 +205,7 @@ static struct rtllib_txb *rtllib_alloc_txb(int nr_frags, int txb_size,
>  	struct rtllib_txb *txb;
>  	int i;
>  
> -	txb = kmalloc(sizeof(struct rtllib_txb) + (sizeof(u8 *) * nr_frags),
> -		      gfp_mask);
> +	txb = kmalloc(sizeof(*txb) + (sizeof(u8 *) * nr_frags), gfp_mask);

Use the struct_size() macro instead.

regards,
dan carpenter

