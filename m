Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AE0D4EDB88
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 16:15:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237413AbiCaORU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 10:17:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231631AbiCaORS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 10:17:18 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71F7B5EDEB
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 07:15:31 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22VBnTKn032372;
        Thu, 31 Mar 2022 14:15:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=HXLXh54fSvTIYl7qBfdLpF7yrKKCtpBckT48TxfYaZk=;
 b=cYSlZL2OlYiUnuSrO/CCnjazDWrD9zgB0bDceHudUOJQFze4SAXZJCClCe/BboB2ZIQU
 qT6jDBTCyc48+SxHUgY/ijr4qd9t7FyFmPYPENkkXW/Lv2ygzTSvwKKcncrMytCsqHIE
 ay3JJYriWFkx2jjzNb9VzPQuQPh5sy8cRdnvTLKewskCkOYvt98QsjdBS7cq263pRp8j
 2niNjAQ39ekWQfHpmC0NUMKbfkhKtNZ5z/8PgPkysYkPWaet/BX435GTO1YwnPboqkiM
 6tK3PRgc0+w7gHvRqSxbjtjmnDHbMOPuCuI95XrPWYDCJHkDVtEE+fF+R1XblgMXzru/ hw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f1uctvpga-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Mar 2022 14:15:26 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 22VE67dY005726;
        Thu, 31 Mar 2022 14:15:17 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3f1tg84k45-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Mar 2022 14:15:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mVqYNQeojEeE8qUjnT1SDQ/XCNS/C7RXnoyeg0w0LFN0HwWj+F4isGa9WhOoEsQAcEuFKdW+kdWXg6Xfu2fMaY90d2lwXgVpN66wFFFWFMeDeDcoQmbXRQBsZxJLeqO8A07czry6K6LhnynRlioRbJWSEFyh0//0YzxxX9YfXcRa+vFeXq/Uoaa8MNYRvl0kGpuMy1Zf6aLFe1B4YswOOTN8i5eJ1QELTHFuloL74Gtfoawl6IeQSCpm7HtTkwVzKNMH9xd8Vx9kG3TccWtwcwDw/BLT26niwK2/7Zpl3GK0W3NA9uWzUEXRhCFZJHTBaa37W5YfSHYlZlytgk2UDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HXLXh54fSvTIYl7qBfdLpF7yrKKCtpBckT48TxfYaZk=;
 b=MMgL/dEJ5Xe5f3YYtVjgewgyuMpdTFO/i68wMfuZDYmFevNnWuFsOrWZFrbNW4Sb2FJFpdzzqMqfi4mzEOqpUAiks70XKF4mqKDs54qMMVcPTSN6weY51HJerfMEFGjs15pXgMXf0IW/kXL7QYwF1rArrdlKkYzXfwsGmtr419LSNEibgc4q8D0XZMlXolfktgtpfg6QjAuw48BQj548MjNWHneWqbxHZz84a2NChngYsVpWkVS8hcNf4RXNpN0PZYqQPQk4YkhtzGwOL0eP+pRK1MyOA+D6QjF5Om3oq5OqDEbRRCo/PZNxRVS7DtY6JYsF/gnh8w+rSpsmaiw1XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HXLXh54fSvTIYl7qBfdLpF7yrKKCtpBckT48TxfYaZk=;
 b=dRlzy2G0n0OC1rQM3j0uBpPo9InB/BMb9rA3lxR6atOO5rs2dq91SG9oBl9YvPJtqP4PM5QPmNgVgOnChGkRObamB06Pfp6SfNadztHC0O/A9hHort+d/u4/qlhdwzbshmUHaWrwUiVba+0MHIEwpfMR8nrbUkyCniny08ZABu0=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BN0PR10MB4888.namprd10.prod.outlook.com
 (2603:10b6:408:115::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.21; Thu, 31 Mar
 2022 14:15:13 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d4e7:ee60:f060:e20c]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d4e7:ee60:f060:e20c%7]) with mapi id 15.20.5081.025; Thu, 31 Mar 2022
 14:15:13 +0000
Date:   Thu, 31 Mar 2022 17:14:56 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Sevinj Aghayeva <sevinj.aghayeva@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev
Subject: Re: [PATCH v2] staging: rtl8723bs: place constants on the right side
 of tests
Message-ID: <20220331141456.GP3293@kadam>
References: <20220331122618.GA434796@euclid>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220331122618.GA434796@euclid>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MR2P264CA0019.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:1::31) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 66c69951-2366-4f87-d53c-08da1320df1c
X-MS-TrafficTypeDiagnostic: BN0PR10MB4888:EE_
X-Microsoft-Antispam-PRVS: <BN0PR10MB488875640E7F28258AB3F8C08EE19@BN0PR10MB4888.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vu4aafY2wfJm23PAiCdqgYJOhdA4bBZ3hFnj2TajL7P5cGK+wle/QjAJ/suoiRHkM749PwIPPAnIPrtZrePlMK1lWiDYWHrJaTvSsS8zpYfU3EOpllWL+kn/QSRVP+mcO3TZBF1UHUt1JQCSP6KOxpV15rQOkKhb9e95hvD8TeDIBpolkGnXqqdfhr7VLBCwBMNICsUQvX/th4GdgTInSm59uF6pK0ZckyPR5hRl//diV39hFB8EcDwM8ZqL8BzNGrR6PUUg2wSWU21zhs7JrvOQklZSgDA1zp5nSVFrODyD1+T+mN5o8ooC6iAx6zMoQn2xiAoxEsDadGe9/hsluahXw/S55jjm+XW9h9AZT6P70g0CRq/PB5szTvkCaK0+cf1zJ7/TiUsAkSMLxns1+m3Q8bVVlIzE3SiuV+YsH5Z8GasPoAlsM/+xF1NYVsIAUoqSVcTRW9ubZdWeY1CE81V8lvEDskiDH+LYT5JH2talicHWmakGMdhNUcfONqFg/wfKpPmpa13I76c6Qdlqddemc6N6Dyk+Qr05YBigLcUOB0QTvsf6P8m7WuzlHu9Lg8X8Lt5u6xsCloCHfAJ8SIH971yWVzKlgvqA3gvv2o0xYcK8AYdzB7AqYNrWdWZVx32iqP7SlEJeYX/vP++FxaPu5ymkpbFTH69vwNb2hw4acMpN+LVb2XVOEdaPg7qGm/ZicbncenVR2V4mMSz/mw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(6512007)(6506007)(6666004)(52116002)(9686003)(5660300002)(508600001)(8936002)(4744005)(6486002)(2906002)(6916009)(33656002)(1076003)(66556008)(66476007)(38100700002)(33716001)(4326008)(8676002)(86362001)(26005)(186003)(316002)(44832011)(38350700002)(66946007)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?R8huqIizzsRs7Ryx/Im3fkUD1GIP8nyHK9xBVu9zOKHANvjaBgb+0HJWV5Ev?=
 =?us-ascii?Q?zew8cOEo482stc17CZ3bBEea/WEfeERZnIvZ9hMGxJMuq221HdLM45uvrbgv?=
 =?us-ascii?Q?ktNGtRctsMwmXha76wU/j/Ty4QFuRTRY/w+OznXnVFSD2ZjifseEYfIRe6Xx?=
 =?us-ascii?Q?yc0IqW93cZBDrMEoo9mnE4laRa99zPai5aOnyt4KGofdsH8AFrN4oXDR1osX?=
 =?us-ascii?Q?zCw8Mkx7OFt/5YfZ2OCyCd7WMQxsKvwq5XRzS3uOHd7Sn67RdBmn36vtEZS6?=
 =?us-ascii?Q?Wkw++TDj8AYqHTMTQYDJAYm2hntoaxM7pgFflqmmBMSHr1nc7eniL/xiNUEn?=
 =?us-ascii?Q?fzUMuBQN4q3tQslg873WAYhIgfUt9VaHq3kQFWLmzjrFZ82IsN/BmIEVxiwb?=
 =?us-ascii?Q?zgrqa+072abRY2OaRWfYfH6AgMZhoi6jxETRHTpfIiHqGCCh/bsl1aFzNXnd?=
 =?us-ascii?Q?MZh9RH5UO3k5BJOSfMsqLdFfUIOppBAqrPadD5OLRDeKWTD8YRWwM9zaWhQQ?=
 =?us-ascii?Q?DRBI3PLY7D82eFwbZ1Pb7boIEQk1OZ6ZTx8MdjfMoZPzpsy8Woqsq58r4XIa?=
 =?us-ascii?Q?Y+zN3I096djfjBjpTEGyfC0mPVc5e6hg1hMrroFueD/lZzqRjAtgMN4NZI8m?=
 =?us-ascii?Q?1o8IcqV55IGHrco7oAjZknKzhYj4dVM35cmASq1FdG6BbiHLj0j+bPIGcrMv?=
 =?us-ascii?Q?CrdkjDbMqJYCaAcwkBcRQSVGJo1ckvPn1UV2M6bT9HMfEEpGC9wPFAHSpTZC?=
 =?us-ascii?Q?HLIgHaENliu8eIs/iKtDEdc7m0WGY1GT1EIufyQKvAzjcnKga+43v1hqlCWn?=
 =?us-ascii?Q?9PTgyTfLmMUktrRhPkfoekAcNq697vDBdivRi1pZdJB0gdKnWA+Nd4oTvHuX?=
 =?us-ascii?Q?PYXz9ZhTnrAFAIIgiyypY8hiLeo4lNcPdz8T0CZfRW/sgpJBFWQSrk6adCQN?=
 =?us-ascii?Q?qMHCXGQNgEl0/IEWq7QKv9jGboWuPs7WWHVerOpFuNgbo1NQsnF1nN/aMDZu?=
 =?us-ascii?Q?fONeWXy09fxh2/rC4PLwwaQdUVJGrYGJ7f0/HrkyhXbK7JwpnvA4B3sw+Viw?=
 =?us-ascii?Q?RpJZL8+mXpbSe5KMWCFvtlVyz2uXu+kUEvhfiqnFIj5HGi023YMSIKciojbN?=
 =?us-ascii?Q?A063w4VCITb0wOnHpnc3ubhU2BEE1C3joSjiz+9MWPTiSB1+EjtYpCHcGZlG?=
 =?us-ascii?Q?/gI/tMYSZedPMF4QI0wzRBq+cm92AoMxPugeqkh7K/3LcN8cZ7nF+t29ujf7?=
 =?us-ascii?Q?kHcTjBysOs7+HJGRCA60nRXejzxFxVyWmSaFuDSU4guB0znJC8PsuRLp2dkM?=
 =?us-ascii?Q?6megDXGbrUZXnkQCpU9QTyCFjPXMeuzuxHxExK2EaVRXFu7G/28/TxZSthqZ?=
 =?us-ascii?Q?Wy56VcK8lCR2w0F3sN4KJV3nO2UGbh9r7G4s6SEVBQrMQ8Bcxz3z/eNWvcij?=
 =?us-ascii?Q?2eOCQ9LsRSbiQjKQLFBH9AMWNtsqL9t5nHg4y36MFHutwsIKEuymebFSl81A?=
 =?us-ascii?Q?yzVzBgVHU99lHGYq8tRLwGx32LUq/akQ20i4whc7rUesfNUgwzAn67C5akNd?=
 =?us-ascii?Q?PcBmRa2+yVFzxULBkUEw2RvR4V0dZm76v2460xP86rtCX8strpep7txDkYAi?=
 =?us-ascii?Q?DIonEHz+CcJUoX/HrcmidXoPWdftoHPA+v71DiC1+ej0q7zjo1GaF6wlukpQ?=
 =?us-ascii?Q?dJ8p9pnKXvsdeWLFrOsHjwa5N9c/YWwrrBz82OZuXMc0OCoQ1R9/MZhLrtTa?=
 =?us-ascii?Q?piyvFFpUvruzl+mazzAWpPFYpZQb7Jo=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66c69951-2366-4f87-d53c-08da1320df1c
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2022 14:15:13.3498
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xm3wzKqCOkmIA466HKCRc121JRSypje7QbXiQatIwl8QFH85MFzl4/x5zWKbY06eYCgFaD9400Uixlg3Q+Y7FLZ5DDqHxkcHhnaC/5tiXVs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4888
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-03-31_05:2022-03-30,2022-03-31 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 mlxscore=0
 phishscore=0 spamscore=0 suspectscore=0 bulkscore=0 mlxlogscore=882
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203310079
X-Proofpoint-ORIG-GUID: BCl_bt7AzMHJT5qteGfKH6yTsaDNOFeq
X-Proofpoint-GUID: BCl_bt7AzMHJT5qteGfKH6yTsaDNOFeq
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 31, 2022 at 08:26:18AM -0400, Sevinj Aghayeva wrote:
> Adhere to Linux kernel coding style.
> 
> Reported by checkpatch:
> 
> WARNING: Comparisons should place the constant on the right side of the test
> 
> Signed-off-by: Sevinj Aghayeva <sevinj.aghayeva@gmail.com>
> ---
> 
> v1 -> v2: Missed one case of constant being placed on the left. Now
> checkpath reports no such warnings for this file.

You need to send a reply to the original email "Hi, please ignore this
one, I spotted another line I want to clean up" so that Greg does not
apply it first before reading this one.

regards,
dan carpenter

