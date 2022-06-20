Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2583D55134E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 10:51:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240052AbiFTIur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 04:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239375AbiFTIuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 04:50:44 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6BA312D1D
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 01:50:42 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25K6NdjA013171;
        Mon, 20 Jun 2022 08:50:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=JrBfPbX9rEcyHKhZ9PcSbuuCt1egGYhBWgM8xQNyktQ=;
 b=PAbbmEqpbwhfJHf/SJ4S2k21tDV/tHYaXapAIjz9tmXoG0AxT9a9476UFGAV5mBr6dhI
 72GzvYJa+RhdFshbfB4m9+i6UIfeYJa/LyIDJzz5aBIeIsW7/JIbVWRLJbt3oJ94YoD8
 OIHOCK7LW4IIqqZPqCH/6/9H2tQ/Gae6JpJNeaQTAK+SdA6coIEmSVuo6J1pkd+t1mjk
 KpG8zdP6iWtHlebSS2aOYAY/pyy+4yZA3wZrOYClec51MVV5RWKno2aeDgK+ZEGMK3pE
 eLVdD8a1Cy6JJ59Vf9nekkfvTWNBzE9iAWXsJ9/cIoyXq4Lkt3alN79XoOiGJESyxejg Gw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gs54cjs5g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Jun 2022 08:50:13 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25K8jpdI002821;
        Mon, 20 Jun 2022 08:50:13 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gtkftbsrp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Jun 2022 08:50:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XZW9olU2f+y6AsAsvWdqtiPGknd8rDe+ZXOdSJ3Q1q7E4Qaas3qQ7iQDDSuhI8V9cH6vkWJ5wrVsv74OfKVjU0NRVvMyj0/1IJu0gzi3YYkyzqGmue2Tq8t+5VJkNr2uCkHjgcFUbupHhQUx1ISNkKdipxNSpztfsXaaSjl0tkZ/CDkSYTNEtKqUQ1PUIvRidVPINoZOH9+u1ZtGbedzcWMwX/RqqEl4uK/Mo9zYUn/i/5qQeDp4TABWlAEjklm52/jUjrAAJIwBpjpQ8PJPtW3gj4FmVpH92ATr+PhzAji28bra2KuJxLEIakL6rHK/eSBIrAQExQszOVu2XlapxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JrBfPbX9rEcyHKhZ9PcSbuuCt1egGYhBWgM8xQNyktQ=;
 b=mMB/MYZ7jlIqIO7pdAxZYk4dqlBfJTDcYMQjaLIR/XRdAMgQvWeI+UaH1Vz8JNVRQ7L4WJcwpr3aN2BW9vylgvaQ9m9IRYYYKxD/vSIyjIN/C3BPXg3/Fv0GQqEmBEdcDqohswTg9QEDXKZf1h1+qvAGjfDMiDz2SQMCxjBQvzPXjGCEeGHqB9Rgl8ohCfQIj9uyWA9jsPqapUP/b2xVRKSy3Ih+A1VqvD2rE+KowM2/96Ml4mVqX1+pk913nihq7kG5/b9QICMfr4iIAgH4P9CGu6X0ruI3HYWZGVciWYJKRHK7GlAH3IkxxsbULl8GG1GJLg0MUDhQZ2k1PgGJrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JrBfPbX9rEcyHKhZ9PcSbuuCt1egGYhBWgM8xQNyktQ=;
 b=IZNlyiBh6UKxNdaWurnsbJVavGbRylaB7CzDS63viaNqeO9Nas5nb/I7V1PLhqtoE7KSs4rT1MifVcRCGI94aF2F6j2vEsb3ui8jQ10NtMonGnqlzzmMvmRhMarXCWvc1bx1dyIAV7VnK4MEIshY9hrBcEguaU2RfokuQU9qAJY=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BYAPR10MB2710.namprd10.prod.outlook.com
 (2603:10b6:a02:b5::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.19; Mon, 20 Jun
 2022 08:50:11 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b%6]) with mapi id 15.20.5353.018; Mon, 20 Jun 2022
 08:50:11 +0000
Date:   Mon, 20 Jun 2022 11:49:49 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     martyn@welchs.me.uk, manohar.vanga@gmail.com,
        gregkh@linuxfoundation.org, alexandre.belloni@bootlin.com,
        rafael@kernel.org, mathieu.poirier@linaro.org,
        u.kleine-koenig@pengutronix.de, arnd@arndb.de,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        Kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] vme: Added NULL check for bridge
Message-ID: <20220620084949.GG16517@kadam>
References: <20220619070645.100947-1-jrdr.linux@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220619070645.100947-1-jrdr.linux@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0035.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::19)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e0ce2b1b-2fce-494d-5760-08da5299e25f
X-MS-TrafficTypeDiagnostic: BYAPR10MB2710:EE_
X-Microsoft-Antispam-PRVS: <BYAPR10MB2710AA880011FB973F6833178EB09@BYAPR10MB2710.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zIW18ZCqvJzHkbLqr2c/xwAahch5ev/M0virZ1F6e5WWhxtyjpn3SFAKsR5pap4NgbuxbYIxYDoB8mrc06FChiZ6AYVsbnKODYhnDq/+YWL0XlLWdIVpiQgMhIEUm04gquVreh+0yakpwguMwxXhc/Eb4vM0VceB9YMLmW0IkFkvMQdgPPZ/ufTKJ8C78gFdqN5vGzhE50kvoSFXhAuhHVwmaQSbyMI0BBJJSkBQBGJreykMrpWxgKm7k0dy3MsaY0HZS3de84sYts13gKZbPrmY1K/6d3NCWZzHstklaYUc8oZzZU+LULVvqix2triyYSGthcckNmv6ZsyRy+Q4SqZkcxLmtS7gZVJzRhRupQDJYam4BGD5MvakqjAfBDA9jW8T7avSSmA3vdaU6HJ0yAa42nCsoTwagczU16ab5f5z93Zrp5qIpoXfJYBPExvkj3DolGCPrpTASS1h/Pa4vwHozLlSX+IbAwlp7n2TxwU9G0zntzvjK3F9oqE9kMswbVBhVlVZEMsrKEU6n8jio9yD8QJxDC7md7YZuZrJcgLocGXzEGNUjbMZros00Mw65gUTaPeVyoWor/QBKqos3pVfApcpDo9GTi3ysKzg6nAwBpd0Kei96mL40L1uEHVgHyRIUCDyJB9FXtaj5AD3uOkB8SzmK0QUiPu3OOzbxIxB0TFxg+iiQ76eE91Z9HHDoKP9NYjFyg2BHuIL1mTcwA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(136003)(366004)(376002)(346002)(39860400002)(396003)(52116002)(4326008)(44832011)(86362001)(8676002)(6916009)(6506007)(6486002)(9686003)(66556008)(38350700002)(2906002)(6512007)(66476007)(66946007)(26005)(7416002)(8936002)(186003)(478600001)(38100700002)(6666004)(83380400001)(5660300002)(316002)(33656002)(41300700001)(1076003)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hvoRPbaCmmcAqLciS09xgSnJp6DV5UcS8CwY55mEoFRd76Mc8O6AL22cE3PC?=
 =?us-ascii?Q?Hb6iZ2KzDK1vwOb7A+p0OG/LdtBE3vNg1PzEDB62PIpv30CnruoiiHKQExxG?=
 =?us-ascii?Q?KRn7ajG8AY9Wz/wo+TUICFeR3YG5BpW+pSoT182Y2suMwLFJPd2wjS/E37Hs?=
 =?us-ascii?Q?UcsVKxMh8EgOkQq6/JapQSoEBH2gR6aWVIW0EToaUtz/JencwRtWSeuxRShN?=
 =?us-ascii?Q?Daff8Lyiae7PlZa6x9Yu9fnJhXsBlvT0emzdLWd2lDdWbAadoTZPz97K0d1W?=
 =?us-ascii?Q?5RqZQ02Y+LlGxT+P/zvqigb41TZWSL1S4EiqWrwF7HoQ7lMvvm7+B1eqLUEp?=
 =?us-ascii?Q?37VzXR2AsdFkx4DcpnlyytK05mtdZ91V9i6xJaY8SISy/1nRty7a2ywiM/6d?=
 =?us-ascii?Q?Ly+v50wTWS1Y5iVtkCXNDqmQ47jVc8smGeCMZ2nGLBvLUHUU64GRCP8MiQuI?=
 =?us-ascii?Q?8uCthOIIMYcmpAX08KBLgHmpmXAGp/ZW1pAzWaAnJ9aXrTK/UKT4wZ1sdAHO?=
 =?us-ascii?Q?1MZI6eEIkFixEX8vyUAYbS3J5VjW5h4fKdL4zkh41aVUWeEZW7bzpce5Il4O?=
 =?us-ascii?Q?KOR2J2vF4uSjUdnShNzsPGCn2Lh7tYxKIppLrnZdlT7+vCdkFRfLPYy8O7UY?=
 =?us-ascii?Q?GAZM+Vog56tYieyobdN9GA6Tw1OHSzMRveBC0K0MDMvH/uWtXekUeiAp0+cP?=
 =?us-ascii?Q?HNZhOoB2l6BWVwohrVfgnuzg/MV3jF4F/tN/y8gz0cUXrr9vktjyiBtrIAqs?=
 =?us-ascii?Q?hbR4VboNDPgPy5MDJ8JV73D1+E1Ar3cmKgwPs1vmupFmC6G0Pv9yC6Tx51yu?=
 =?us-ascii?Q?IJht7Q2v1A2rqP1a4HCcU8KLHIcra5r/CUersDSQhNLh/HjrGa9ML1AziFGq?=
 =?us-ascii?Q?5rAzNOGdbYKFqCZJZiNpsp28/s2rNJVLONNHxV5sdsQ/mtLFXowoUJPplimw?=
 =?us-ascii?Q?fbijqS4FZ8Q4OYJxobgFSK7iDsZJBmakNmiWsh+/3+m3w84+REpHB6y5j9xx?=
 =?us-ascii?Q?8VXA85v+x7VTOAwmikYuULEIrzEKX5cyLNgdkFspiP9iOT//U104T2Zw0Tob?=
 =?us-ascii?Q?0Zk61LMQf58VkD8xRCVgfuXOK+2p02o+bH4Nr6skEhi68VDVMA4dCLbTvhuQ?=
 =?us-ascii?Q?xFpn8HddZIvQgXh2xDHelJ64/31trVr8qj6z6TF0b1/dDDK3fGlmdfn/s+5J?=
 =?us-ascii?Q?IYxCqAhG2T+MNV+U/Oi0Z9iqGcOCnIGfYQzz5s1otVR5h9uG9mgRqpFualpe?=
 =?us-ascii?Q?txwg4CJE774ehMHqlVoYqFqj4wq+ic5B/lEI9KL0MrvumL4KzPDaYsnDlB1t?=
 =?us-ascii?Q?6M0wSazx0XY7kvibHmuW6rglMT3RkCZ6ZtPfjwkB+KSA2jd7SlOGLd1BQOA6?=
 =?us-ascii?Q?6Jnu1XnNtKUJa4qRJnHr23SKekgSmRokYpBV/VV3o7zKV/eOrpGyM9mfTDnL?=
 =?us-ascii?Q?IF2cBYEgixLnW6F8HOb4Yv+cPeiWwh8co7n/B9jkfxOOkCWEXxJvfjsjyBXk?=
 =?us-ascii?Q?5YKAnsVyV+McbwMmvreKKOVA1TV9AxEMBrqz/wscjzMFrRYukAe5Ixd0jfjV?=
 =?us-ascii?Q?2K7FKOqfM4qORSf9DDGJsSCjZEWd5YiluIxBtX7Ob3dwVC6Y2FIXJSl7t+93?=
 =?us-ascii?Q?NlSjW32I2b/Vr0WMC7zqz86fTa1/xGoLdaxmMKKOtlHvbdm5eEtACZGpp3SI?=
 =?us-ascii?Q?rbkBTtcEKdicrDL9dzO0f043pw7FxC5+i4GoEnIuuEy2PXQs36UHGE2Rsgh8?=
 =?us-ascii?Q?r8wsVo3fDdu3BpuRWbCGNGzNsJTEaos=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0ce2b1b-2fce-494d-5760-08da5299e25f
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2022 08:50:11.3187
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QnAv1WjpkbJavfYKv4qyynePLE8kquKeodImfR+duZqU6dm+MQNyyKEpQvDXaa3MbyciYKaNBP2MfQL6ouIuWKkRm6gSwKHYi7E6Mqffsow=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2710
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-20_04:2022-06-17,2022-06-20 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 phishscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206200041
X-Proofpoint-GUID: 21V1oU1jxoLQS2XaqJQ7eD4DDMHUMi-L
X-Proofpoint-ORIG-GUID: 21V1oU1jxoLQS2XaqJQ7eD4DDMHUMi-L
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 19, 2022 at 12:36:45PM +0530, Souptick Joarder wrote:
> From: "Souptick Joarder (HPE)" <jrdr.linux@gmail.com>
> 
> Kernel test robot throws below warning ->
> drivers/staging/vme_user/vme.c:662:20: warning: dereference
> of NULL 'bridge' [CWE-476] [-Wanalyzer-null-dereference]
> 
> Added a NULL check.
> 
> Reported-by: Kernel test robot <lkp@intel.com>
> Signed-off-by: Souptick Joarder (HPE) <jrdr.linux@gmail.com>
> ---
>  drivers/staging/vme_user/vme.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/vme_user/vme.c b/drivers/staging/vme_user/vme.c
> index b5555683a069..ede774f2fe5a 100644
> --- a/drivers/staging/vme_user/vme.c
> +++ b/drivers/staging/vme_user/vme.c
> @@ -659,7 +659,7 @@ ssize_t vme_master_read(struct vme_resource *resource, void *buf, size_t count,
>  	struct vme_master_resource *image;
>  	size_t length;
>  
> -	if (!bridge->master_read) {
> +	if (bridge && !bridge->master_read) {

This patch does not help anything.  If "bridge" is NULL here then the
kernel will just crash later in the function.  Smatch complains about it
now:

drivers/staging/vme_user/vme.c:688 vme_master_read() error: we previously assumed 'bridge' could be null (see line 666)

However, I don't believe that bridge can actually be NULL here.  We do
not write code just to silence that static checker false positives.  Fix
the checker instead.

regards,
dan carpenter

