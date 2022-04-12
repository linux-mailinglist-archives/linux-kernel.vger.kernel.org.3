Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE7FF4FD3FC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 12:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386993AbiDLJFL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 05:05:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376984AbiDLHou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 03:44:50 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30CE847AFD
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 00:29:26 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23C7HFRx018804;
        Tue, 12 Apr 2022 07:29:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=V7On0wEx16cyskDe/lOYjJO6lFiVq558cd1Z3Y/AHQo=;
 b=LeU3EyJXB6gYbENx39B3dn9+Dct3j5y6Dt+8c6fXnprfjZXhZuU9ky3qgA5/DMy7f9OO
 0oUbV1JKHQcy2qPi0XJFblCTjCg25a5yCYXl/rAWts2Fv6LVojmdpXhk4/ZJGl5pSWRR
 pcBeFjyh51nNyb2vHRrtixrPYaWc6lImQikZY7t33WIpI0ppJs8xsCR+1bsQcXD3qZve
 n1g/6Q2ZKyUhX2C8+Y2UwE4fhDQZPUzw2LxJbkENfPZR7K3+FiYQ0RJR/3iiQ2uXzD+8
 SwioOGIDYSV1YXZIveo0mt6FQ+lyP2l+Rwh4Bqnm7D0Ruz8DMkGYVVBMCIotLDRx+zlq aQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com with ESMTP id 3fb0r1dvr7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Apr 2022 07:29:08 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23C7RWHi037960;
        Tue, 12 Apr 2022 07:29:07 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2049.outbound.protection.outlook.com [104.47.57.49])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fb0k2fk9w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Apr 2022 07:29:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n/wVsSPfM1i64v/v9YL1f/p5x3x9FoSmQJBvGpQRPd1J5cbfqs46pUgQbQ3ddj+/HdOh8/Lejhp1U8rNIkJj18wrSoMSjvj83E/Bjt6FDDAC1Uk1KhpvdFdKT71W9HRQPKVDmSpn8X7Ph22dWJpKmVZzqowk+4/63DcCXbCKf8mlCPJB9vTccFNKc9kEb7RvDbxGyahUwswk022TzXSZEiKaJqDzVTCf7V/goP50v4JErX3MDXTBynhr5xBLHOWukvoeWRVN9XjovESPqw8TKh1NMJ4KTyB13a6bkfuLvLj/2jT8f/muabGz2j/nbre7xis9CF5bbULidHYwU3WwXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V7On0wEx16cyskDe/lOYjJO6lFiVq558cd1Z3Y/AHQo=;
 b=PcjSNSqytbnTZnnDXDxfTbXlIodJhfbufU/ddIl3w+nxdIWQnZkAgKRcw1qJUDR1GFJpwNgnPxEbHsY4dck0LCO2kEada35BH/3yghnV1Hv9SrB/jiyAb3tE8t5KToHEWM8u91lt2n0k+bytAYRUxlWzbT6VoRHbtAdv00Bz0jj72gzFKE8WyoREf2KPppSgb4vz8ktaqYpNQPflYfHHj5vu//aFbIlK2Sopn6aZVhevpVLDFDFltwnNxsKTzRqUI5hStCdpqzyV5G+9tmZWE5jpBEmpbIstdFP7TR1gRB3p9IpxDKlmNcQ8pauBvpfsXkd9VL0IFNed8+9KSbKrvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V7On0wEx16cyskDe/lOYjJO6lFiVq558cd1Z3Y/AHQo=;
 b=QXotXTqpxQ94pIBtA5sg9oKvI2qpk1+g8sSZl9moFihR8ZF2WdMJmfR2oap5GxoTbbujiGth2juzfqe2EEZfNIaffMparorjmU9avDriBQ1cDNmjAfszIT9yvsRcaMtcSwS/B8H+ZEJ+VIe8MePYcSI4NNXapKcX/9u5nRVZxSY=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by SN6PR10MB2813.namprd10.prod.outlook.com
 (2603:10b6:805:cc::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Tue, 12 Apr
 2022 07:29:05 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87%5]) with mapi id 15.20.5144.022; Tue, 12 Apr 2022
 07:29:05 +0000
Date:   Tue, 12 Apr 2022 10:28:43 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Jaehee Park <jhpark1013@gmail.com>
Cc:     johan@kernel.org, elder@kernel.org, gregkh@linuxfoundation.org,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, outreachy@lists.linux.dev
Subject: Re: [PATCH 2/2] staging: greybus: remove return in an empty void
 function
Message-ID: <20220412072843.GD3293@kadam>
References: <cover.1649712572.git.jhpark1013@gmail.com>
 <eaf51ac31d264179298cb24c91f05a14e3651bda.1649712572.git.jhpark1013@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eaf51ac31d264179298cb24c91f05a14e3651bda.1649712572.git.jhpark1013@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0047.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4e::8)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a50ec1ce-ef88-43df-bfc9-08da1c561f90
X-MS-TrafficTypeDiagnostic: SN6PR10MB2813:EE_
X-Microsoft-Antispam-PRVS: <SN6PR10MB28137D27DC91F5E5803C7FAC8EED9@SN6PR10MB2813.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: syscs1q2j6V0I1YSLszLgbYC09oSsuC6cHzuSUGPcXkimGxyHq+jQI8a80Qb6j/uHqxw/o4n+ISyu1eGK30Im7NjcUYHViGQX+MmtyBYv1mRgoDgjhSUsB2eXh7YpV7EyK5Mr1eF4kUFbpMhRPMIYKwUFf5RNzIgUosIzgWVYajnsZ5xIBDunDsRkF/DKeDp2Gt+1t9BmC2LQ7OsM2DFOS+OucGbqAtpcon1+WyZoPlTgH2tyn/Yv5nogsr2usbly/toxhQeGX9rZNwSuWqCZ+nhTJ1qk8IajYfhPbPKCKITfCwiZpbaQmMbL+n3MCfv7vnimumqaJNImmpgOyHI7MSQePJVYDicsJT4V2IFPnLyu2iCBJozJhdFewtZVDoJ3wNnsjrj/2MxrS4UHCdqvtqsy/Y+28TovMF0nO1k0LhvXitJHl9yw1la+a6M0ICjlMAHH56+8T2VWu5JLY8n4ivVznIejvq0YqTMXZTckR5DZ3ZMcE2fBx3yfcjOaDvSYc5SyP5q/QIA+63iKF0DoJxpuOi18t3So0slH0g26sjSSlwkRBS/Cn69/wv0NzNKm45RP+A+RlCIz3+S9j5TVbnnv+SYEB4WAhACVZ5UA8CcKh+FSx3ylFVFab2dS++r+vv79cLd8vqVa1haINamCzjSFI9OfvYD+zaUDExf3JiDHHvsj7JsCumK0oNK8mppobxMUKAUi7BdSfX8dx28Vg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(33716001)(5660300002)(33656002)(6486002)(1076003)(66556008)(508600001)(8676002)(6916009)(4326008)(4744005)(66946007)(66476007)(38100700002)(44832011)(38350700002)(316002)(83380400001)(2906002)(86362001)(26005)(186003)(6666004)(6512007)(6506007)(9686003)(52116002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?t1+bBNZGqgZotuQohVZWosSHZxLgFsacThHyyJPbaNVPdsgYNPO0gBzbua2v?=
 =?us-ascii?Q?Bfg4OVWbA9d0reSrKVn85VTO73kibArBNE8JR6laSlnlvE6qwHZiSl2tugbf?=
 =?us-ascii?Q?0osdXs0IJM3OxhZ4jK/Iep+5X1C2fhfnec0d6VbbCDAteDTGAdLVmsAwVLr3?=
 =?us-ascii?Q?znQHtQUMtubXhnn1ChZLmo87rWpGz645thWkz+utr0O7+Q8wOe6QjwW1KDd7?=
 =?us-ascii?Q?d0XZN/J7vSk9N3yRGPFw91A8yICejS8bsiLrfm1QvHC4Guj4FjKjcjJ+yP05?=
 =?us-ascii?Q?L9ja0/as7AhdJRs3qVOwf0ch6Kaklt2vZSbrQOlzFo4rMx6XqSroket4DzbD?=
 =?us-ascii?Q?gFzYeDMP3VSOVkkPQuVciuzW/uDiuUUl1ciLc+Dzjr1A+eE0uHwF1EhVU2t/?=
 =?us-ascii?Q?hikXYG52UYTSrQqpDfmZRSjRkDwSugeVSGODcD2TW+Muqj7CUQNC9Hhvp/34?=
 =?us-ascii?Q?ocbKm1Wg2ORuT4oim4kMIf0cuzOFkI51+uqQeJBYtX84c4nCr3ADEFVO0MZO?=
 =?us-ascii?Q?8S1F2z5Wgcd9u4C0TX/QEKH9Cyyy+mukNBKqWF7PCDtE5IglTN/nCkv4gdyR?=
 =?us-ascii?Q?fYalMnIR5rE31Bd0dXcZWoHDTt8fP5sxnjWM6kor2b7QOPdutGqFG9xdfNQ5?=
 =?us-ascii?Q?9WSFGzu3L7sF27NvKajKhrSVW91iVymQGe06zNNh+W3j0EBaFFr4UjZ3BzbP?=
 =?us-ascii?Q?oOX7B2H7Hmz9Pf/HmhNdK1mmQZFZ11bkPRCMKlqgrjckJnIzYrv/vLpbeOsY?=
 =?us-ascii?Q?5oJqxHh0u74dxjTTA7jyAOUpdstrgA92BAk4tHwRKwLjwcLhyPbOPhO0DUeH?=
 =?us-ascii?Q?EysPM/pvKvdDtbPnZHAEsy8xsB89x15is83AIQrZp1jX2kFPynmkU2PbLCIY?=
 =?us-ascii?Q?01X/QM9I1cTfjUdvgBytAUPRgbooaSUnFw1YGYumBkMDtF8u95/sOskY0lU1?=
 =?us-ascii?Q?M6fo73FWKi0UkfKyNazGBppm3nnkzDz8FY1bWJA8X8Cm+l8s14gbnOYUU7Ij?=
 =?us-ascii?Q?oOy6sQ1bceXb1vLUnBNxXgBbDrkdUCQh6DxmW/nVCdJ8tZwcrEZKvl5+QhN9?=
 =?us-ascii?Q?nxEPcY20FISs8YabT8kLCJ55pj+K9iSpaPxIwlnodx8sFgLZBXBEjiMgcUMO?=
 =?us-ascii?Q?Hfq0Mb6llLL+Cdl6+yXRjbPw8/P7KLky16K0BskJYajjOCTbPXXXZb5pLd8R?=
 =?us-ascii?Q?Je3F6aKOVFzO+DuFJ2c+JIVh5fIL9FOSmma5qLvkzAkPHmZc1ElbLYT8VNmh?=
 =?us-ascii?Q?Dt03Y0OTMfG2i01XoYCvR1TKlxIr86pcXCBMGZ+7Y8D6izoWpJv53H+QVvHh?=
 =?us-ascii?Q?qkD0azJyojKj1F8kGKzqFAw9kiXOsvjiixO17M70dbzAg7eXasKGeow/1Alh?=
 =?us-ascii?Q?oxltLyumMj9kdhCWv//+WROLB583WhHJ6KgLOz7j5nB8U+I8S3R2IEgY2WXJ?=
 =?us-ascii?Q?AfJRsrg8J/Cf7pihkIZFlc0khADLrwsJU8UnkImIzBNG1SXWBPt+pcKQejtL?=
 =?us-ascii?Q?Wdo+oWtxz4WuBeRERHgKsnnrLoA9Tv22YeM0twg59U5fxTicOTuXjGx1TZaE?=
 =?us-ascii?Q?63w6vV5+x0LFsMIVvYPm4b6kggMQ5eGsG1kCaojOWQvdsqMIshirIcDQacdS?=
 =?us-ascii?Q?uvxH51iirOCjJfYXh5VvmgGrag/Wc+c3TpNNJSCR6enqEUY2WThalKmHGq7u?=
 =?us-ascii?Q?vraPDSMNFifekgdkVBpN72qJiC43ACK0Tqj/Ny981IdOP6EmfbnE8i8pD6XY?=
 =?us-ascii?Q?4DJ7/kaqT9OxSrhOrsDrAm1SvPZc3Vw=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a50ec1ce-ef88-43df-bfc9-08da1c561f90
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2022 07:29:05.3222
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7nLTNq9XF6Sd49RctmkLGhCGdVvtz7rAMJGMu+q5l6oCFUTq5YLWabLsZ0RIgxUEF5L9cK1q72q2shCem2kt/Vmu1j5Ll0f+c3KOXxp08ZQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2813
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.858
 definitions=2022-04-12_02:2022-04-11,2022-04-12 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 mlxscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204120035
X-Proofpoint-GUID: JdD3anpQKnbib8P5-6RcIf7scQ7U-wgC
X-Proofpoint-ORIG-GUID: JdD3anpQKnbib8P5-6RcIf7scQ7U-wgC
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 11, 2022 at 09:50:22PM -0400, Jaehee Park wrote:
> Issue found by checkpatch:
> WARNING: void function return statements are not generally useful
> 
> Signed-off-by: Jaehee Park <jhpark1013@gmail.com>
> ---
>  drivers/staging/greybus/audio_codec.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/staging/greybus/audio_codec.c b/drivers/staging/greybus/audio_codec.c
> index 0f50d1e51e2c..3e3a16568def 100644
> --- a/drivers/staging/greybus/audio_codec.c
> +++ b/drivers/staging/greybus/audio_codec.c
> @@ -1032,7 +1032,6 @@ static int gbcodec_probe(struct snd_soc_component *comp)
>  static void gbcodec_remove(struct snd_soc_component *comp)
>  {
>  	/* Empty function for now */
> -	return;
>  }

This function is called from snd_soc_component_remove().  You can safely
remove the whole function.  We do not like empty stub functions.

regards,
dan carpenter

