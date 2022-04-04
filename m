Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E2974F1499
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 14:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241909AbiDDMTF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 08:19:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232296AbiDDMTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 08:19:00 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 626EE767F
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 05:17:04 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 234AU4NP005378;
        Mon, 4 Apr 2022 12:16:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=/Xi0zRIgByTsZv4dE6Pscb/9ozFahKI6B6mGEJy09d0=;
 b=EgzNjlzukUPuak0QPUD1aVOcM3UVo+BW/NHiRPpocgA2VG9PiqTX99GV6gPC2AwSGFUw
 ObNq73nPmj7LU9KMmGykctVqa3UEfWK1JSE9dqMyEXE7DaYvotu1CK0DSQlG0nk9fOj2
 NX/sWNUYtA5dNVOA06PCEIrCuTmQwmhX2ND2e1a1jqhz92/zxl11SPYUr4H29zZhrUjk
 a/INVRKZ/Pu48dsoot4MxKSun6AJZ3BeD5i9WnhBikNwN3HHpiv6e5U8fkWagwFodTA3
 4kHdRz26VBWi7sVctTWOH/imsC/L/oFR6buWxeWErEhFrT1piezqhJyti6CRMJVyrFkb ww== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6d92u0pd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Apr 2022 12:16:58 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 234CAc23017853;
        Mon, 4 Apr 2022 12:16:58 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3f6cx2bdv2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Apr 2022 12:16:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PbvVhYACjtGlnnc9BvRF7GqNY70Mpmw2GksgHSw1RreHwl8Ai93K6WGUxdIQulRERftYjxmTb7E9Ly1JNaGtTSh61FNQipXhGG8KMGjj7qF+bMT2/mUw4bgyIen4HkxAuueleJ6eCP9ugV5NYbXeh/rHVqEk9c0VWERRIL5r9zfWoP4jcaGEVrxG8jG9i89aEQzC+WhfwOaeACqGJbbzU113H32MgR0Q3Rv734paZuqPqMHgTl3SyBzBEjOwWO6hstZadqPrm79B6OXIQwG445U8SvVDepd67TKPuJCnzt1hG2LUzd/ypUr68ioqJbt4qC6cTUDMr8iXR4kaAz9S9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Xi0zRIgByTsZv4dE6Pscb/9ozFahKI6B6mGEJy09d0=;
 b=kKMkdHzPqZ2aGZuYi3wKzItiolarRBDihdG83sV27i38aWo1dV9IZgEqdztKXoMCtqxUVw86uB8LORAyU+Be13pFVlvD8UFG/e5JHHxwANy7lggYfG8ORKZ+mMzREjP24IUvOuvYaf61YccVayunptG7Afx9OelUcf+yNblRRk5UFJSPApn/Coz3SagO73uG/NQmymhHd4E0+ctBaQN1w3KcRnj+GEn3IvX7Uj8WZGmpfLVkpZ+pe6IsSx3gCJOt19eYPOav1jUYLjSdmmmFf2tXbQh8i6ZCeJNwVqQGvKB1IsR9whXrVFOqLkV53pJjNEiTMCs+IIIgzyV1j6iMYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Xi0zRIgByTsZv4dE6Pscb/9ozFahKI6B6mGEJy09d0=;
 b=C3HeFSX3Asna/6GRyGMB6Mvtvv60p1W95IL9jAs0ZFztUbHJVw1V77SSlssEB4qoLFR5QY2SLpPc/LnHh66dXFENR0yZTzc+D1oNqJ1/jMRcLsqqI9gBhklBMNyzB79VqEG9Pbzdd9o/LTQIHaPj30AkkhC6ZiaUaVEIr2Cxotc=
Received: from CY4PR1001MB2358.namprd10.prod.outlook.com
 (2603:10b6:910:4a::32) by SJ0PR10MB4767.namprd10.prod.outlook.com
 (2603:10b6:a03:2d1::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 12:16:56 +0000
Received: from CY4PR1001MB2358.namprd10.prod.outlook.com
 ([fe80::ddcf:9371:2380:d00f]) by CY4PR1001MB2358.namprd10.prod.outlook.com
 ([fe80::ddcf:9371:2380:d00f%7]) with mapi id 15.20.5123.030; Mon, 4 Apr 2022
 12:16:56 +0000
Date:   Mon, 4 Apr 2022 15:16:38 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Rebecca Mckeever <remckee0@gmail.com>
Cc:     outreachy@lists.linux.dev,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] staging: r8188eu: remove spaces before tabs
Message-ID: <20220404121638.GZ3293@kadam>
References: <cover.1648888461.git.remckee0@gmail.com>
 <2fd10f393e3bc7381a85d0bfc1ec04a80af4eabb.1648888462.git.remckee0@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2fd10f393e3bc7381a85d0bfc1ec04a80af4eabb.1648888462.git.remckee0@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0004.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4c::9)
 To CY4PR1001MB2358.namprd10.prod.outlook.com (2603:10b6:910:4a::32)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ac07b9af-d1e5-41ca-fc0f-08da1635023f
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4767:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR10MB47670B765A53C1611D2118CE8EE59@SJ0PR10MB4767.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +/JsIaNxIY6BUKDoRL7oQiRnn3OjE43MoPeASjPBrBNyTfapdnatRJrRZZ8GVmNIq5zJcQR0E5vqnoIDpzmIDnizsoCxI0j5NduOUsLBTSmLiJxJ5rpA9cISUsFU4EiVBrQaa+LGuXNwL+7RBaHqZPQLarxwbOOVhTeHegZBUvaDHtglr8kECKG/+1mv3S7YHZdQaZi8i3+ihUEet1nck08/56fYpEWp9bClh5Bp9Tt2DABM40ZxC2yydtcO2g0myrflFQV0CNey0UGtQE5tVFS5NjPfTpE2mOHreDHaoiJkoe1T9g4lud7b0WYI5NqKe8PzInCDsGyU+9Ummrzm9dLRLVQs8VocmT9R/5k1dJSZ0xCm1BDGC82jVLzpRhXiTC9jLvKLe5Iw0+eOscoSd/ZjueAA5xVb/OesmEOBoEJRWJ5mXGrY64RfGQx6PRiD0F5Y6y/5camQ/sdCSUMGQoyUK9KJ3mF9q6P6rzTl/MRPnm5IafgWlyhmSsVlkhaCl+AMJmlmIe7etIpv5+QuHJuGdGU4c9bpebk1SK3ft/G0lBLOV7wQKuzlWwMXTOn1g9Bj2FXQsj6FAYyUj06AiXSQksoJdm5ASsCfv1lGkna0gKQtE4MFBgQnasBiYhsbnGx/V1cnhJy/3VU13GArDyeUXBi4qv+im9rDquCZiJPHC+NgPOG8H+dU01QySQTPEaJvnQo8m1Qk/ym6pJjK9w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1001MB2358.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(38350700002)(38100700002)(66946007)(66556008)(66476007)(8676002)(8936002)(44832011)(83380400001)(5660300002)(6506007)(26005)(86362001)(316002)(6916009)(4326008)(6512007)(33656002)(186003)(52116002)(33716001)(6666004)(9686003)(2906002)(6486002)(1076003)(54906003)(508600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bB7Y2Vpnu6jb32xRm/mdzpeDpDPLuRExhltkqVEb0qaQU2p9LxRr7qs0sXUg?=
 =?us-ascii?Q?NQHwL6vmeDdO3uGW8tru7KqYVz8FG4tU+L2MUS1z0MEk2dcHgEmsy47HjX7Y?=
 =?us-ascii?Q?XnhybRoPY22+BP0GdWPEFZNm2S6f6NHvcT6+ZjsG7i2hxXIen1JmhllPGBfT?=
 =?us-ascii?Q?Am5v1ewYknxdTIk3tdQ+8I4mmxU7OowPnVOPO/MpJa730ky77vapKjucRB5q?=
 =?us-ascii?Q?dHSgKUeVxFLWdarREqEP4/BQTJQw5xe45sCrZkIlJbUZMigVQVcGNynFcpP3?=
 =?us-ascii?Q?62b6NgU8hJMGuLJPEPd+IhPv7jtLYXjo3NVS1X9QTrhtCoAibuf4UX99fYdW?=
 =?us-ascii?Q?sPSKVDlUxiQ/PXgpl88d6AYU5NbHaUfDKWOkpOXvkkcitGyFTinCE5Pr6wsG?=
 =?us-ascii?Q?Spl1hvL32hBeYQUPf888mKVQdzL//CTzTNWqrf4t4b6Ps8SsnFkAlzgXZMKt?=
 =?us-ascii?Q?VBT1IsRp29gndRPFHfbl5ELRhNmvUpzlvUgIj5HjcMVO+RKbSHvaxQs9w3xZ?=
 =?us-ascii?Q?Z5DezS3MaOYpmXUx5fzx7hmu+uy7UGtv8pT6PuQ/6QBiTNge1mlT8M1+Gi+t?=
 =?us-ascii?Q?mxiZxmZGyZS3D3mhRgw8N7Ux6zmUn+XzOtzMTBrxp5PRQtasujTrvjOq07En?=
 =?us-ascii?Q?ogzKakBA1jSxyH3jaDugUSuONqUO6G/GuP7Xfbni2ojxsMH0LucQzeV9px71?=
 =?us-ascii?Q?6wt3sEYNO+NlpVCzI9FhBmBCdRLNq48uj0ctGe6JPMlAxx+hLTKsUNYHChaT?=
 =?us-ascii?Q?9/AZACl/TtnhawabmTF9BUBgNN3EY+R2jDR80u3nlLHhLxzjmsbGt6njDfMv?=
 =?us-ascii?Q?sTbbhTCV3TQlIOLF/SD8zE25jWQlEYZr06UxAjrBxJuqezRv3XURDy7Vw4f4?=
 =?us-ascii?Q?+VjqvohXuqoYpsGKwYT0nynWDO7yCCPURaBdTS+Zty5KOdxNlidS1FI5sNhy?=
 =?us-ascii?Q?B5nbq8ANzdOFowmSfFP5JcODcRC1q7ytRsGKVb1dOAU3naswjBNDcVH8VIED?=
 =?us-ascii?Q?ufkU+JmXOmhMk1kxbAlJNmpqvXHklCLZYMw5VEjAJ4tCkc1i05rBpa+gIprk?=
 =?us-ascii?Q?IEu+iedY43Nhq9llilmjWGUa+H+KoB4/YUeEFmpcLLfAOx4QXq8xK9wF/ns5?=
 =?us-ascii?Q?9cYevmgS1BomhvwZixAOYFRztXnI+1tRvfO0pJLcaTM00vBz0fHl9knbzXd4?=
 =?us-ascii?Q?7d1dGwEHnziDj8+tnhHKn8DCzO1bAh27LW6wQLFpaGI7RwXIu8lSGa/4Tb3z?=
 =?us-ascii?Q?yKa1cVhE7KBhhq5n+E2t83MftpoCwId6VxehF0Ag2UV4UWfiDjTRqOmLPU54?=
 =?us-ascii?Q?CvPHtCvd2dUjpHTMIc6cunupU1rNQ7NjE5VKHvYkB7VAy7RAUCCHHEaLqSOY?=
 =?us-ascii?Q?MhlV7d1lzPKUfP1kosiDvkwm+Yn/1EGRXx7w8KkZDy8mQN9NceYho6I9kQLN?=
 =?us-ascii?Q?/hqOnNniXPDH9CWoB/eSdsS99wd+KjSkP6ZXXMriWg6G4FDbNxUGAZxiSUFO?=
 =?us-ascii?Q?I5cOlgJvVPIFsl9QQTuYAGOj0ERcPzwkteKoYBpZ9ZldpzbytvfsDESxsVFN?=
 =?us-ascii?Q?rHtqKf6PQwM/FKhxVhhB7mJr8Mg0KFLIrXP1/Ng0qg6FsBjXn3/Pgqu0Cm0M?=
 =?us-ascii?Q?1KD7sVM1eGmJ4RFn6KKRkXPA8vmLc4IBq8pUHtwA1s0RlpPV5COAUHfNYsKo?=
 =?us-ascii?Q?+3IVbg1vk7ss6hy8O5XswcrG5zIuy1gz/Er10HZ2wnxJACFBZfZULZyprFS6?=
 =?us-ascii?Q?8qM9OBxeARfC8aKElJcQ1Rvb8Z6EoCk=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac07b9af-d1e5-41ca-fc0f-08da1635023f
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1001MB2358.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2022 12:16:56.5671
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QmBIb84+R6nf3ZpccRLcSgnsOnxgB4GiVFJaiIDnlNO6v7nw6MbtK/LLmXIw187IIoeMl3fY7DAz+blBZSxOu6KOKOf/JT7/5PaE5LskRvg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4767
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-04_05:2022-03-30,2022-04-04 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 adultscore=0
 bulkscore=0 mlxlogscore=999 phishscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204040070
X-Proofpoint-ORIG-GUID: _Qm5hBddscKhnqd-RZBb6Uc23KTGR2kD
X-Proofpoint-GUID: _Qm5hBddscKhnqd-RZBb6Uc23KTGR2kD
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 02, 2022 at 03:50:48AM -0500, Rebecca Mckeever wrote:
> Conform to Linux kernel coding style.
> 
> Reported by checkpatch:
> 
> WARNING: please, no space before tabs
> 
> Signed-off-by: Rebecca Mckeever <remckee0@gmail.com>
> ---
>  drivers/staging/r8188eu/core/rtw_cmd.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/core/rtw_cmd.c b/drivers/staging/r8188eu/core/rtw_cmd.c
> index 832bf25b1a83..8ae25cb4246b 100644
> --- a/drivers/staging/r8188eu/core/rtw_cmd.c
> +++ b/drivers/staging/r8188eu/core/rtw_cmd.c
> @@ -548,9 +548,9 @@ u8 rtw_joinbss_cmd(struct adapter  *padapter, struct wlan_network *pnetwork)
>  
>  	phtpriv->ht_option = false;
>  	if (pregistrypriv->ht_enable) {
> -		/* 	Added by Albert 2010/06/23 */
> -		/* 	For the WEP mode, we will use the bg mode to do the connection to avoid some IOT issue. */
> -		/* 	Especially for Realtek 8192u SoftAP. */
> +		/*	Added by Albert 2010/06/23 */

In follow on patches you can delete these sorts of "Added by Albert 2010"
comments.

> +		/*	For the WEP mode, we will use the bg mode to do the connection to avoid some IOT issue. */
> +		/*	Especially for Realtek 8192u SoftAP. */
>  		if ((padapter->securitypriv.dot11PrivacyAlgrthm != _WEP40_) &&
>  		    (padapter->securitypriv.dot11PrivacyAlgrthm != _WEP104_) &&
>  		    (padapter->securitypriv.dot11PrivacyAlgrthm != _TKIP_)) {
> @@ -1010,7 +1010,7 @@ u8 rtw_lps_ctrl_wk_cmd(struct adapter *padapter, u8 lps_ctrl_type, u8 enqueue)
>  	u8	res = _SUCCESS;
>  
>  	/* if (!pwrctrlpriv->bLeisurePs) */
> -	/* 	return res; */
> +	/*	return res; */

And this commented out code.

>  
>  	if (enqueue) {
>  		ph2c = kzalloc(sizeof(struct cmd_obj), GFP_ATOMIC);
> @@ -1151,8 +1151,8 @@ u8 p2p_protocol_wk_cmd(struct adapter *padapter, int intCmdType)
>  	}
>  
>  	pdrvextra_cmd_parm->ec_id = P2P_PROTO_WK_CID;
> -	pdrvextra_cmd_parm->type_size = intCmdType;	/* 	As the command tppe. */
> -	pdrvextra_cmd_parm->pbuf = NULL;		/* 	Must be NULL here */
> +	pdrvextra_cmd_parm->type_size = intCmdType;	/*	As the command tppe. */
                                                                                ^
s/tppe/type/.  It's noting the "size = type".  (Which is an ugly hack).

regards,
dan carpenter

