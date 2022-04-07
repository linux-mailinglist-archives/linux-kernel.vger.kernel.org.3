Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7E5F4F777B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 09:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236232AbiDGHat (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 03:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231267AbiDGHap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 03:30:45 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0D24117CB5
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 00:28:45 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2375hrNo006371;
        Thu, 7 Apr 2022 07:28:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=3FLtkMsIRGUNpH17Y0+/PE5x12YvMTh6BSoAiMqpGJU=;
 b=FAvU10ZlLycgoHlrtbQFcvmbrv9yLkQbwqt/DOB2DmNsSTdtYZLbGUkPv03WdQ4GYafi
 MobtGY9CMKURCDTH4tFA8aYMA57zDu5zXIxKRkmjUyEZQQBrXm5Q7//vDy9m9i1Y1qTP
 MpFNLcoy8qYApFm8nw+ZZRWmFVmkNWje08f8JM679EhOveeSM9mfqB2DaHlGY8DWL1Iz
 vycjzNomt0GurulOpKJjHWeBi2Y8wu7MuYq2LUPQWJRVklvOyjcML37uvw98FtSygMYq
 uU8CICZRy4FKzEwXayS3gOgJ4pJ/3oottSpkOkScgiyEJygTZDhRtiOIfh1z9YAiar7W OA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6d31k44b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Apr 2022 07:28:38 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 2377AmY5040305;
        Thu, 7 Apr 2022 07:28:37 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3f97y77ktk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Apr 2022 07:28:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U6onBPDbnkMSokCfjztFoLkd2cF2unCJ81jVwCak9IsZbRtqUV7Ag9YUcCIhYBf8ZEPVvVGvYgVV2f+eWoUtNyQlgF+CfVp5JWpE1noCWTlLxucY4reQfd/cMA3/EbrNyu0paHdP4DGYFbv3GWGY1bncqFRoItXbDAilPmDPCJiB8v+a+NcJEkasCzNVODW1JsLqtc4JTWG29FWx7aqoUP/yH1vgiK33tI1u5h6Jard1VCNhuybbXuupf12Awd+0yqFALEoMr1x2UIV9oT/so2iOIaIVsEMbZwpnLQ6gwxPqb11P7jmrZY2eL4pot1Yxx8sUR8hAFSDXal49BtmPig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3FLtkMsIRGUNpH17Y0+/PE5x12YvMTh6BSoAiMqpGJU=;
 b=YenXRHXMwBMtYPCkuq1SAxpFPm0bu5rvvY3tZDUbHLEBmmCVxmaI5YKuw9N11f9BqNUgJFEbZtQBHqdO6L53b5XhO32RM3bJY1U5sFKUFfSlLwQOqWdRsV5T+P/+22E0uGr1wA1VNEFWHDAAPwHNEYfuclWfecTQT5PK2N4B/Bl1hH14jbUpyHYQszA3aNtTcbppdNEW42v0OzeBGk+q3+0OiwSKM6hYzH9ZpJas8I13iZlmjZXjs+L+Frm1T4LelMMuVrtNYYKqm3aTN2wXvJ5QfNmrcVlVVvTir6C2J+QBiXLs/JQKDnbFy9gyZBsR5CfB/f2yWKlrNuN6jgtcGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3FLtkMsIRGUNpH17Y0+/PE5x12YvMTh6BSoAiMqpGJU=;
 b=Fyt2EleRSUPxi0bFCI5uXWAKTBctRsreuPwZcxgMuCAAiJFDPLGx5Gq8rO4ZGM9aWnCYWcyK2mLCtwPOxuyKGw9xHgGhb+nwjKWoovBPt8fxYhUNmwEeRMqEwyCDzrf495C+hWoTXFouZ/CcJMOgeBRk7zDzWeCzvuH/mNdhrCQ=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MN2PR10MB3679.namprd10.prod.outlook.com
 (2603:10b6:208:11d::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.22; Thu, 7 Apr
 2022 07:28:35 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87%5]) with mapi id 15.20.5144.022; Thu, 7 Apr 2022
 07:28:35 +0000
Date:   Thu, 7 Apr 2022 10:28:03 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Rebecca Mckeever <remckee0@gmail.com>
Cc:     outreachy@lists.linux.dev,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] staging: rtl8192u: use max macro instead of ternary
 operator
Message-ID: <20220407072803.GI3293@kadam>
References: <cover.1649288226.git.remckee0@gmail.com>
 <2513b1520d533c9f487903fc2c97f4637fe5f6da.1649288226.git.remckee0@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2513b1520d533c9f487903fc2c97f4637fe5f6da.1649288226.git.remckee0@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0001.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:19::13)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 10420e4c-1a54-4a67-4f9d-08da18683989
X-MS-TrafficTypeDiagnostic: MN2PR10MB3679:EE_
X-Microsoft-Antispam-PRVS: <MN2PR10MB3679F1BF5BD25F34D08C1AD08EE69@MN2PR10MB3679.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BNYhrP10Bt+ujqhjFxxRjOqpPq+wiMbVKGvYsYMRrb4C8tkQKvk7IKv36Cna2jmo/ojU6i5QK9tNNClaUQKszgXwO5G54H5Ftfz11qMVQhjss1ApscQ+vsrEoA1BUzofPkGWSin4c6tEHfAU5tB21Y71XBFVrqK5ZQZUMgl7UBP9/3X9EK0/wtglTv3pQZiV3FSV7uz0kUDkJ2nHaSae1mGTc+3l1MqmV1aqStg70dwHHmNZXN1nHD+2t14FyL5NcUHo/wufNjTmZL8m4B6mpDrh/aFBToiPlnCviH7UgrPLfhmtYnSSlKuQWp7adLgbPHXbxkIqPVRAhENzNtN3C00d5ROHbFCy2VcUDjG3Rt2xAs2mhGuaykoBiCAoV6t1bU3/I4DPqgPKysJCzkk9drXmNN3oY+GCRt5aH2Fx41K543R6uGLTZJxnHu/MrWPZKqxJvIoguhh/TSsOLSOF2qQZwdTdzZDBSG6tfOyCOVoSJbvpRB/LwAnLsEeXebOCMpKkqH1IP1WqdOtMIKSwgBGT/QrSSvKwLNjcm/EujAesBSXJ5kM6m0go7H2iMK90g9uPVZp8XWpiSjRFLzoEEna809Zswn/hflW6G/ZEH+I93/cLFB4bkjX8zfS2NVKSPTKR42++44yza2T0ureaCp9N7ke8bHSODfHfg9A7Rewyd8xX74MEwKuowmp4DIo53Em2/tDInoIKD+3sqFrS2g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(6512007)(52116002)(9686003)(6486002)(66556008)(66476007)(66946007)(6506007)(508600001)(5660300002)(8936002)(86362001)(6916009)(316002)(44832011)(33656002)(2906002)(6666004)(33716001)(83380400001)(38350700002)(38100700002)(8676002)(1076003)(4326008)(26005)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TlnNchVP+PSyzap0LZif1pP7KgCZuBPjBdLzoijDsF6jN2QxcUu19HggopDc?=
 =?us-ascii?Q?MzX5dbp9w5LPHw5d1OjYN4Qn0Qc+h679tFVSp44XdJE97EOyCrwArXlR1K2J?=
 =?us-ascii?Q?HaALxAgxtG/QoVRWdOLNQuDrCeUTvJX7hyud3fhWKLZo3Dsf82U7VpZsbIFa?=
 =?us-ascii?Q?G5fNCdMG3ZcVqfWzdtID3mXB7H6M7OgWPQaMKd63kdpa26VRDISY2JxCpy3Y?=
 =?us-ascii?Q?cS7Lx29uTxJWrlgJv6MMZsoh6dOdQ6dqN/KPkCOug8fAh9TNEo1GXu76+g+2?=
 =?us-ascii?Q?2jclvLNOHisTk/anu9Lrah7K14sYQuhHxaOdlvG3cuISGA6o18jJgEnW5BNb?=
 =?us-ascii?Q?2vUK+hkyeh4LnSZvLIHTIgK7RgqdjhlYijZ0fyrHRl8hykML/C6e+3cnhTwT?=
 =?us-ascii?Q?onmSsk0XM1H3yghiptC8nBMj1e5MwSFMX5mnMg6tXgTBvoNH0482CYAdkFPe?=
 =?us-ascii?Q?DN4wTlscbsKmJev61m5ZpurUqY9KOr1tiFF2gtpADXbx9wO4lhO/Ys30Xq9K?=
 =?us-ascii?Q?n16a72Qfg4igTgzmuVs9hgVDTqoG8BjibLnwx3KxdshisMSoXZCfFT9/TC8Y?=
 =?us-ascii?Q?a+clJHbRf9QtFBDs7xjwtJbfwb9qz+VvOZPC0PboaopvqzNV5jGJ5ZfZiWZ5?=
 =?us-ascii?Q?+CM7RhjNd9EBJ4wxWl2mxpGAkx4xy7BNnUCgWm1jZdU5Q+PrQmcuZcNoUmRh?=
 =?us-ascii?Q?u0aRidLwXMSXyI9J0xP1a6i+Xboq5h8X18AsjakRRdC6WkEEt1gi8l4wBqej?=
 =?us-ascii?Q?1Eaieh3Ve2Ng648T1pVb2XzBgS75erGZmKjKifSjC4nXKqF3tgAv1JgPeh2B?=
 =?us-ascii?Q?h7+vRiHVm22a8tRZT7E10davxbOzpeog5EaK99eYwVEgzFVnOyI8f/tz+3Lt?=
 =?us-ascii?Q?ENkw4PxLosjqeqs/QuFud9QMbuTHltmeEpKt1sk7irlRSH55QfpzH1n2I6H+?=
 =?us-ascii?Q?aZtgryJRTU9AUD3R2m0oJice1BkmeWOeSErU8Ths7IC00U6JMIhDAKHqACBg?=
 =?us-ascii?Q?ktW75mo5D0qQNE8ucdLtjQZwZFSeHNrAE6m6hDH3754WkABnS3dAZ1KE0a+g?=
 =?us-ascii?Q?IAgZxMYF+e3IlOGdLYNpbzU5yZ/zumIT/cobPPpbl1CkaUSsutSUlcBXJ8Mb?=
 =?us-ascii?Q?sdGgKgm6/4sjB9qm+0VPvuqwTU81uavSdcsRQ/YncyK+Y5c8MfbqfUM4ujLP?=
 =?us-ascii?Q?va2glQYo7182Biq9IN9Ao66hFbUBAfJtYURmiH/cJ8QwNTAn6dP4eEe+x4iH?=
 =?us-ascii?Q?ta5dFP/pWngVEGwWo1enWIzqx6zYOCZmsBQCNAkECkFUevmleXF6rxXQmtEG?=
 =?us-ascii?Q?yIo9Am3DaDvi4YjPv5LpsEPBJ5dfPfIJcqOcFBlj0qA5pMlZ2U0ym2tRaI+Y?=
 =?us-ascii?Q?6Qc/QoW8RmgbJKT5fjmx3voSI7r9r/oWoXx4zQv02nlc/aAOAXNq0tAlZcoV?=
 =?us-ascii?Q?bkrE5OIReBbeYdppH/m+gRL8ZXVgRT9ZqGEkORTGxZr48teK3oQgEgI7PLVf?=
 =?us-ascii?Q?juzIC4W+LHGfOBQOBNKmiqPRRPUdz1UuGWXVpOpUaJh3O9uOC7VrM5nPpn7v?=
 =?us-ascii?Q?I/iUmh+4eqbpXCZygnLSBCQBSjBebCw8UYbXsqyjP/rRcbMEakpj9z0ykk2i?=
 =?us-ascii?Q?i7qEValp/HgqSjJGRxMCM25QlLg2XQXcTRCdTcCq9qu4Pp8QjqMco/PYO03p?=
 =?us-ascii?Q?DTxhGWOzuwPWR/lEKjIzyDYpf1lWJKhYj1PM5HrXu8mrFCWnVizHm/89PxMc?=
 =?us-ascii?Q?5vVFI9fv2sCZ4xski716r++8vcG42BE=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10420e4c-1a54-4a67-4f9d-08da18683989
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2022 07:28:35.5905
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6X1tv8fRS8OFA8zspmghziMcmje5LQjD23hzc4eo+pmRJzkSDAIvJBTQnuazdG/HRwQVa4bnemhZVETtzBTwVCgEs9zRJZXc48qTHUaGjVQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3679
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-06_13:2022-04-06,2022-04-06 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=837 spamscore=0
 suspectscore=0 malwarescore=0 phishscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204070036
X-Proofpoint-GUID: uTkNlFQDsvfJ20xJThkWFL8hfXOhJpRU
X-Proofpoint-ORIG-GUID: uTkNlFQDsvfJ20xJThkWFL8hfXOhJpRU
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 06, 2022 at 07:09:43PM -0500, Rebecca Mckeever wrote:
> Replace ternary operator with max macro to increase readability
> and conform to Linux kernel coding style.
> Found with minmax coccinelle script.
> 
> Signed-off-by: Rebecca Mckeever <remckee0@gmail.com>
> ---
>  drivers/staging/rtl8192u/ieee80211/ieee80211_wx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_wx.c b/drivers/staging/rtl8192u/ieee80211/ieee80211_wx.c
> index 78cc8f357bbc..a10c1303695b 100644
> --- a/drivers/staging/rtl8192u/ieee80211/ieee80211_wx.c
> +++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_wx.c
> @@ -470,7 +470,7 @@ int ieee80211_wx_get_encode(struct ieee80211_device *ieee,
>  		return 0;
>  	}
>  	len = crypt->ops->get_key(keybuf, SCM_KEY_LEN, NULL, crypt->priv);
> -	erq->length = (len >= 0 ? len : 0);
> +	erq->length = max(len, 0);

Neither before nor after is really readable.  It would be better to
write it as:

	len = crypt->ops->get_key(keybuf, SCM_KEY_LEN, NULL, crypt->priv);
	if (len < 0)
		len = 0;
	erq->length = len;

There are few rules/patterns that apply here:
1) Do error handling right away.
2) Do error handling not success handling.
3) Try to keep the error path and the success path separate.
4) Try to keep the success path indented one tab and the error path
   indented two tabs.  It looks like this to the reader:

	a = frob();
	if (fail)
		cleanup;
	b = frob();
	if (fail)
		cleanup;


	success
	check
		fail
	success
	check
		fail

So then if you want to understand what a function does at a high level
you can just skim the code which is indented one tab and ignore the
error handling code.

regards,
dan carpenter

