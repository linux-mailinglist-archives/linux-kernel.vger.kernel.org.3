Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69D3D502582
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 08:20:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350415AbiDOGXD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 02:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350486AbiDOGWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 02:22:48 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3E8F2A2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 23:20:20 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23F4WABO014133;
        Fri, 15 Apr 2022 06:20:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=7ZQhDaIR3R0YZZaHHHecl913ppyOcCHzvdGJIvGMMY0=;
 b=xtDwhYcfjSz4FcUn+DYiZWLib8fX05VlgaGyaOVrJbkmRqyWpSSWJw9fKzZ+WL51pX0E
 nPqcJNmiW8Gp2qRtJP18k+MH7aSGJvW6Gf51fx+Tvu8NMmaQQjqKBLBDOYXZ6EHt90l7
 MLCHG5XfmrhYw73/H/6aENuq/KA1kl1/VE2bflq2lR+ie3GG6tnP0v29SqNr4xwy3TyR
 ExyOvUqy/cRljUfIGv3wUENYfNLNdLus+LU5LO2fy8qVO5p63QnPhn0NdurtyKunSbAp
 Xrv2GgXCpgXEwFttn++YHz3UKDayB1myjnXzCzgVuMtOyMUH2bHNELso1XyXp501rUGC kQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com with ESMTP id 3fb2pu6tnh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Apr 2022 06:20:14 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23F6BWfu030084;
        Fri, 15 Apr 2022 06:20:13 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fb0k64smq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Apr 2022 06:20:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bEpPvvNWO9NjobHBIH/kDCqj4it7KXNy8mL96+4Kh6pF7OQMjL2Xb8+qJWGiMPsBm0AInhl/1IVcpLQbAclssEeTBwvWn7uKpdjkp6thMhdbZe6obRE2cSPvgqQ08x6Zxh3ddETyQ1UGgWh0YYsLz+riE97LO9yJqm74Hb5o6PEFPoccBSUL5wGgMWVc3JahsQeAy2iJGRm0S43ObGAMUYX5jefmKgXQZcJqY4k8M9xlbP/j96u3ybU4LzJ4T4kTnpbqvmg6LwW9eUV0cIVivXC3Tg6zMjAYdjFNC6rHNjzeqkO9cJpHcmgZjHMofHJHSOmtI/gaRXHker6gYyOQdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7ZQhDaIR3R0YZZaHHHecl913ppyOcCHzvdGJIvGMMY0=;
 b=N+sjPxL2wNermn/7OcFbqB++gZwvqqMJu8QvFSMIuGQC39LhkNQl2i48UPckUpycPSxznvogIieBTuCIAlUoG5pk+Ekg3JNIZJd0Pewx+BwwjwoMHMEI0ygAYnWlQhMe0JXL2FN5EBVW8pL2vhPwABFQaJmqladQmUD9IyAJczyHLh8r2AnQrvfQD9Z0oQdViFNawIidbXKwZ2XI7ExJoh7N5IbDK6yjL1gRKrsaiXBrO2VKDQEd2oo124DdZQCSk900eCJzvdXkzArw4NtgMlscG5VAYyUxWmpiblBoWf61edlraTRRe01jQwhlNc3yXyZVw9fPVx/fdNV+u4ikaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ZQhDaIR3R0YZZaHHHecl913ppyOcCHzvdGJIvGMMY0=;
 b=gBzKMBwZA4Qa0RNZO3aQB4gxGWKzBhh4UrQjNhoeqDicl4H4iXs5h+YlAJVPKdpuXeLxS6juOlZo6QpWohMdX6wPlkUMu/xEtBTPnWE3CdBzIVGqjzUvQzLiqNKzdjXnBS32dvnCOyC/CpEUKvKbkYKdKR5l6lM7dLhEebRm5dg=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DS7PR10MB4896.namprd10.prod.outlook.com
 (2603:10b6:5:3a0::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Fri, 15 Apr
 2022 06:20:11 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87%5]) with mapi id 15.20.5144.022; Fri, 15 Apr 2022
 06:20:11 +0000
Date:   Fri, 15 Apr 2022 09:20:01 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Haowen Bai <baihaowen@meizu.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4] staging: rtl8192e: Fix signedness bug in
 rtllib_rx_assoc_resp()
Message-ID: <20220415062000.GP3293@kadam>
References: <4370787.8F6SAcFxjW@leap>
 <1650003325-26568-1-git-send-email-baihaowen@meizu.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1650003325-26568-1-git-send-email-baihaowen@meizu.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MR2P264CA0150.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:1::13) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6fb031ac-3721-48c5-440f-08da1ea7fef4
X-MS-TrafficTypeDiagnostic: DS7PR10MB4896:EE_
X-Microsoft-Antispam-PRVS: <DS7PR10MB4896F3517866A66C0A4E10128EEE9@DS7PR10MB4896.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6Zack5/cUt6Hn3ExWm4JHYB3GasUuDtqThpZ6a/+RH5ed7fZa50Y5QxXJhpt+TNKt9lnNdQxFTIUZ436mUR9DVDifYdMWZXbhfZGo+Axr7AKRis20GH+VNBmnPAQm9KxFCq8jnoA1Dpj56r+KsKkvAl5BEONdGQCoDqQAHDpKPj4Zg+07ha+zGMmBygIRvNYEyg/w8/TRZ4Pm/kGCHCblDXP4SQ8fJzy+HXzBJEslSe36J4DK3giJ0hwheVSI7/RDR8R3PWgZGCHnhCpALOwr4E9jxzYXza/yxI0Qrkx3crvcsLC0Uo+Ky1fw3syhIgAuDsQsQRxlxpXX/3xVNo7a1R9jgbUHgrg9g5TxeMgTkrowDJsQWR7iSuoIe5Nem8N+7SX3z5eq986gOIogY8WWXJ6FxeWgkLrO5fNSneR4+bJ3GXsIFngh4F/98a6ESn742LmBs3oCqv798WWw4sXgPeNo4/Dda4NeKRVcgjDjK4kzW6zDF920d3l5jm9jr9FMELRyV8AbkMEV7CsvUXdEib9G0YoMiVB1+N2kKkzlcqLt+HWzKvAn2fXaV4gwix1Qk7E3FHORpyC4TWm/53cSwCbVUhe8OHSNv8sh0wnSp64NSgGmKF7x/EJ9rhto8NcQeVmtvKSbJkZMT5sLsio8mtM9ixvhxKfosRlfBzM8P/zhtozOGPIaOtLoQn1Pw84K/c1pPfvRrzWD3TjeSRacg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(2906002)(52116002)(1076003)(6666004)(186003)(44832011)(8676002)(4326008)(66946007)(66476007)(66556008)(9686003)(26005)(6486002)(86362001)(5660300002)(508600001)(6512007)(6506007)(33656002)(8936002)(33716001)(38100700002)(6916009)(316002)(83380400001)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jjfbv8s9jmsirQNxO5wHwRrjwGccq8ns13juOF6BBBydFkHTUYWq4kAAMvus?=
 =?us-ascii?Q?F5Ga/DEEPZZGjqlWliE1BdLLKK7eYmIXdH68bPHI2aMWgwB3jLxF761TYOAo?=
 =?us-ascii?Q?+xTVQHoOYqMYD5xWP2hdLk1UuBFJV5kbwyx8RDuWQgXhjHuYATEAozog439y?=
 =?us-ascii?Q?c/fyEnQS0d5bhZ8VRgV75jvEUEZZFkiGHNXGiw8htdMqlbEpfQ/XmWkdenAi?=
 =?us-ascii?Q?FoTjLV07uj6HWHgrqt+niv6coF+Q1aUTeCEDgixQ84yr6QhXlZppNz6+dWMb?=
 =?us-ascii?Q?Rx8f8XjiPG7bT5wTGRvGdZ3by5pV+riCRM+/PB8Gq0je+lT7yH/qW+sWBybo?=
 =?us-ascii?Q?Kz88zlvJPOtY7PqvMzH4Mz0c9S7JXdXku2mxUrVizPt1rwJt4xLCyba9IoF/?=
 =?us-ascii?Q?CtNoTEE9vfM9aq8VXfyGkTqAppV9HYzJ65pOkwwbEDxMOBkymd/iQzdRbzS6?=
 =?us-ascii?Q?Pc4PT2wdpQL362wqVk6Nl/WNSxWd8BizLDPJOyX820FZxUM5WQzkv2o+FDVz?=
 =?us-ascii?Q?Z9QzCCjna6Xbi3G1F5EPv9Y2ObctGop0BhedMiV30VEVjTg0k0n5OnfZLQ+t?=
 =?us-ascii?Q?fmIh0TS+aZlEfOi5OgyI1OvIj2aGdW+PQCEgf3eyYNl0hBCtmySqZTfQ6/9S?=
 =?us-ascii?Q?Y8H7rRi3pr3XCDfpbTB/Jwl/j+/MFBVHmv2ePWRcVove6ZJj3PIitQpsgfm8?=
 =?us-ascii?Q?jeoS9XFPGOPIJ6+9JyXo1dULrYy4WvUx9z0+5zs/D157uDmge6Fv1QglAjtq?=
 =?us-ascii?Q?IGKVSC51R67FqvIBEN8OVi6GsYnBFbE7d0wjUe+jLHQTp/OBRoWOarsSPhoG?=
 =?us-ascii?Q?xd9jx0I9tC6gTitvHYswutT19auBMWeqYvRt/ex+SR6QciLdyDdAZp98coQs?=
 =?us-ascii?Q?QFMWDUbQxBi3loR7tOQh9Ko1Rz8xMjGCYziEz5CLCqiZ15DBVxTJ3jTjDq23?=
 =?us-ascii?Q?zq0SjgEpnysjbsoMEaXPKXs/bjzlEfqDMF69JPmXFMyuUYafV9SeEQdFXLlA?=
 =?us-ascii?Q?yQ7I7a3AIlpYvMF7ayVupYF4JK8xOGQwhHMvGIMjQvebepexdAhbnCX89ch1?=
 =?us-ascii?Q?K+383EWyejbU2xc4EhOp8X/1OEJ7cNk3CtAD9PD77/n/6VE5+KAerjk8NHNM?=
 =?us-ascii?Q?E4j7NrbdoeXRRPlWjsDlhaws0BhPaZD0GWbb+Ke2gu4RK6V63nuoqgx91WvZ?=
 =?us-ascii?Q?BvXHTcHnBUg1eH70Lr5pvwEdERBVY4PCUSw8hB1lazEZ1TG5aKzuXibUOsDH?=
 =?us-ascii?Q?I5UvB6AkDV9YDbjOQ8Msn/I/nEIgi4DWhAPGCo1VHME6QpGCerZM4Jp3SCIn?=
 =?us-ascii?Q?81Q9i7CowyZy5A122z8P4X9izeku5o5lTtGaXAaJR5KRQop2X5EofO1Sx6LG?=
 =?us-ascii?Q?lH+BO3bSNhziO8Hq7F3xTHzTtBcx8AxfraPwqnXqy8WrUycg5kkYuXzmlGrO?=
 =?us-ascii?Q?dZtOiPQKPhZE7uEtfA6FDswBlVkzIJHRPpkbdW2HNhNNuliB4e5yNEgoub4P?=
 =?us-ascii?Q?AmOALRAjyTmjUXg8Qqk32S8eiY/d63UfyTaMGTuuNXq1SLp7gFlHrQf1yQWN?=
 =?us-ascii?Q?pLrylfA2DkfZPNSK0i1ASNG0jST3CBN03ko85rCNlUOBNyty0Dq+F7jp/xMf?=
 =?us-ascii?Q?BTmpBVdz5OMu8fyuww1vVnFDzMwVM2vL9CMhYPF1oWWvWMLcBgw9QSnMhSg5?=
 =?us-ascii?Q?8cblKxAaz7aXaEWGkK+RWuCcqsAIJ7Mh3WTDJBGVHO4Xhv2CHllKDygPYjOr?=
 =?us-ascii?Q?byxa8wfMz8tTuJ9X5gedky/nXNwtGcs=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fb031ac-3721-48c5-440f-08da1ea7fef4
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2022 06:20:11.6357
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HwyKXnQMSUXuVfnlYB4gQZVPVnhbgx3zUGGTj2Qzdd3yv4DZBWQNqRhPsJjz1tPsji73DKLBS/iE0LGu1qmfF+Auqsk8QxzeldIZhcHPIQs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4896
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-15_01:2022-04-14,2022-04-15 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 spamscore=0 adultscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204150038
X-Proofpoint-ORIG-GUID: 7I8NavlYDlK5bb58BjEAqaK_8MaVVWAc
X-Proofpoint-GUID: 7I8NavlYDlK5bb58BjEAqaK_8MaVVWAc
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 15, 2022 at 02:15:25PM +0800, Haowen Bai wrote:
> This commit message suggested by Dan Carpenter as below:
> 
> The rtllib_rx_assoc_resp() function has a signedness bug because it's
> a declared as a u16 but it return -ENOMEM.  When you look at it more
> closely it returns a mix of error codes including 0xcafe, -ENOMEM, and
> a->status which is WLAN_STATUS_NOT_SUPPORTED_AUTH_ALG.  This is a mess.
> 
> Clean it up to just return standard kernel error codes.  We can print
> out the a->status before returning a regular error code.  The printks
> in the caller need to be adjusted as well.
> 
> Signed-off-by: Haowen Bai <baihaowen@meizu.com>
> ---
> V1->V2: reduce return random value; print its own error message.
> V2->V3: change commit message; change s16 -> int.
> V3->V4: add message suggested by in title.
> 
>  drivers/staging/rtl8192e/rtllib_softmac.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
> index 82bf05eb1cbf..4a1b9a94930f 100644
> --- a/drivers/staging/rtl8192e/rtllib_softmac.c
> +++ b/drivers/staging/rtl8192e/rtllib_softmac.c
> @@ -1764,7 +1764,7 @@ static void rtllib_softmac_check_all_nets(struct rtllib_device *ieee)
>  	spin_unlock_irqrestore(&ieee->lock, flags);
>  }
>  
> -static inline u16 auth_parse(struct net_device *dev, struct sk_buff *skb,
> +static inline int auth_parse(struct net_device *dev, struct sk_buff *skb,
>  			     u8 **challenge, int *chlen)
>  {
>  	struct rtllib_authentication *a;
> @@ -1773,7 +1773,7 @@ static inline u16 auth_parse(struct net_device *dev, struct sk_buff *skb,
>  	if (skb->len <  (sizeof(struct rtllib_authentication) -
>  	    sizeof(struct rtllib_info_element))) {
>  		netdev_dbg(dev, "invalid len in auth resp: %d\n", skb->len);
> -		return 0xcafe;
> +		return -EINVAL;
>  	}
>  	*challenge = NULL;
>  	a = (struct rtllib_authentication *) skb->data;
> @@ -1787,7 +1787,7 @@ static inline u16 auth_parse(struct net_device *dev, struct sk_buff *skb,
>  				return -ENOMEM;
>  		}
>  	}
> -	return le16_to_cpu(a->status);
> +	return a->status;

See previous responses.

regards,
dan carpenter

