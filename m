Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 158EC4ED402
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 08:38:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbiCaGjy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 02:39:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231229AbiCaGjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 02:39:53 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C351103DBC
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 23:38:07 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22V4e0BO030419;
        Thu, 31 Mar 2022 06:37:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=9FJaXwRwObErwwNiGShR5rqX19wW56894vqRiiuqiC4=;
 b=LRmvKWvvyIZbDGViB5JalsFCCzmFALmoDAPfPVy09RfCq1vX4v6fZtbR/GipzAZNtv3m
 p50MiuS1U8qq6PBcV/okSyiVVg+Mg8OslDonyz/7iOpUdHafQD8QKnlh9cQivTyizBTf
 cgnSA5kAcYTzYWygG8ZuCBbYKL+XizKd0ZBxsw1mALfHSZtwHvpuhoIJPkgvtjpJjstD
 pZ1gAPwh8cKBB/j8Q4ZBq6BH2Vj9t/p8CtF0DIusYEqN20vjKkqwFTiaTLkH66y9BXMT
 zyvNHknZQDR8eXvZzVcRuTYfWzPDJ22SnLGhL6FBAagY97pJcq3BYKv4vRSA1eqbofZ8 Mw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f1se0ke3j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Mar 2022 06:37:56 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 22V6UYAJ033132;
        Thu, 31 Mar 2022 06:37:54 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3f1s947hdh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Mar 2022 06:37:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JgLG7PViIw3XeeOwxaYYBHPa8fkA47TUbYqeSWeFva/kY6D2uFHadkYVnyDqx6IIngWGeQEBGU8VmiqD9ncnCSU/NBFazuymfbHZyRNy+fmem9iRkPBSyaYIhuNDsa3tZtg7OYvBHRrPveoEjOzP6PDlucUALPXnQLOC31DGuBvztAEWxh8DxxC4VM8srG9p+pkbBl/4F2yafcB+MQVjtuCfWeXQyxtqZbj3PprggglMj9Do12QKWJmnzAb6DAvHg3JUUKNWIMXgD9kQdqIl2MR9vMTSV6CFfBP+mJHxUleWkJR0VYgrQ5Ej1zpRaZiasGM56N5INcsstouoMaKhbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9FJaXwRwObErwwNiGShR5rqX19wW56894vqRiiuqiC4=;
 b=AfTlO+VKW33PIcj5Xn+/FgCzVL+ZmGGynckKDsCU0xyhYfCYi79wMmuqlU/2EEKB4dKoY7owGm6lgfBnp/tnFqaOIQxZXH4H4l+2fbkaWMwJFOO1eFsVg70xRxZAnFwQlsHfsb6gQD4wRKtSWBpGFB8p4W9fgOFzba/P8HpYkb8bvjEtYQXgbXSoP6JBDBWX7sKhR44tlsYIEfaaTsc0gIss/y0a3LJMeaI1KAZs44Po1rujKeIUrm+xolRFpGcifiRq1xKgCeATqRGx2kVFtHe1aFD4NsF1bIatJKSnG2Y1ZNDsYB514DdOESDbAIKpMZWqnnEjcAvjSOeXc71fPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9FJaXwRwObErwwNiGShR5rqX19wW56894vqRiiuqiC4=;
 b=sN5d+Top0F3IqZcehUDytvWTvqDJ+3jYp7GMGaegjrdVrD+xgeOLTg4gDX3UXDQhGx86aLzlHkIlf1duJKOvTK3h6BqpwZz4MIdy0T2B+9n4bmvUmiQ8FD0KhH7S68teiFKQmL17Uz73d3GoWN068J5tR8VY5btWM8K0O1COGeo=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by PH0PR10MB4502.namprd10.prod.outlook.com
 (2603:10b6:510:31::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.21; Thu, 31 Mar
 2022 06:37:52 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d4e7:ee60:f060:e20c]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d4e7:ee60:f060:e20c%7]) with mapi id 15.20.5081.025; Thu, 31 Mar 2022
 06:37:52 +0000
Date:   Thu, 31 Mar 2022 09:37:33 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     xkernel.wang@foxmail.com
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] staging: r8188eu: properly handle the kzalloc()
Message-ID: <20220331063733.GJ3293@kadam>
References: <tencent_12789CD2DEBF33C818B3542E170737854506@qq.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_12789CD2DEBF33C818B3542E170737854506@qq.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0036.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::6)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 14ee74e4-7579-48a3-bde4-08da12e0fabc
X-MS-TrafficTypeDiagnostic: PH0PR10MB4502:EE_
X-Microsoft-Antispam-PRVS: <PH0PR10MB4502903C225CBA31F94249498EE19@PH0PR10MB4502.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OJtLMfPeOs2Z6kiTjgnAfhcR9iz0L7Oa+5HYZhibAqIh1ewVOefg36riq7zUjUojv1DLnTJHwSJwwdrp6dchl0y/2NX51l8pzCG4s27XzSgl+lDZYool6kNw3sCkQxXyyTZefaV59nAQZnEqTEUoWhUlClNPrlNJRHLH4KX3IK//abYuH3JLhKFcMBlcJyxrSD9xnF+RHWL65EedXinctTOio8ZT+pRvZnwDVZe2fuADvjSUZuvLiEJ1VUlvZpGhiAgVIq2UKCWsbXu+tlCXBXhmsw2m6VUYunucIlK6wOgX603WRszOb5WpP1Aop/Sks6zpy6wF1kOtn76D6YqWRJJ1TlmaVBj/4+rD75w6UrkLAIDxHhY7LLtp/1463xySFoGRg1I40OCRdt//Ii0u0IaGhs9J7E+XXeP6shfulb3rI276xQR/toa93i2KEbG/YZ76KEeahHuanHgks4+Mr7JOWnB2iep/KFBOK1RFbeKW9HWjrowlp7G03GU5AxQlHBOaW8TSzSX0zTl1tTPYbf6VtiY/YTDiG68s+5kInrUo6LEStU5ahLU8SrxGwyqRnKrsHH+QyvmGnxu6Y+v/avJMZC/TRbUY1t7Y8kOb5iz2+WcnDgUgumruS7w2NcpXTUOcC6WgDkbrlnq06MUDg9cMI1t/zasPGKXqNdtcODZhEV5fMinZVDJl72fakibs0cSnoAe6vnhhcGEzZgdC02ZUaO4SjmJQWsBpyl0N2Pqjog84QFEzOHCes56Yuz7m
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(508600001)(5660300002)(33656002)(6486002)(44832011)(8936002)(6512007)(9686003)(38350700002)(38100700002)(316002)(1076003)(6916009)(4326008)(8676002)(86362001)(66476007)(66556008)(66946007)(6666004)(2906002)(186003)(33716001)(26005)(6506007)(52116002)(48020200001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Mk1KrxtIvWECwBeB8H0NvbYbnirIyXk76vMwCHMLvETdSr7H2zNFwt4a+BVH?=
 =?us-ascii?Q?KkA4kCrsbf8d74RN+qMZurtA1o6Uv+qZcbl6PSYpGlewWEuFc98i7I4kwZPh?=
 =?us-ascii?Q?8WJlAS7odaqXjNbztvGUXRjrxM0qlM7pAFWVJQ7f1ovukPAGgaJPQT3UIlR9?=
 =?us-ascii?Q?xcTqNIXgl/K8AIWIy8XWThdxmjMlk2yB+8oHlclXLL8pXFMoJRqkkH1OQujJ?=
 =?us-ascii?Q?CBkWyTc5grTAyUo/g5W8vRvRTpnSkptz/lDU6ADH0pEHzxLNH13sHUfbfaf6?=
 =?us-ascii?Q?4sIbtwBb82mF8VGCJ8LisefyKLDyZhFB0SqcN/WjxlKIfX7rHqmHMG9eeqmy?=
 =?us-ascii?Q?+M6gmgNFKQAjD9YYEMIlmo++lIdsrJBuuKQAZTVv5y6MPIsn3DSh/LvFusZ8?=
 =?us-ascii?Q?zNBfthoTu7Cy0GHrj5dVe6SwGPDHtnIs1tRZIHEKEEDJjYk89F+WApArQefl?=
 =?us-ascii?Q?pKm5h/6TVoKRFVTC9t5GKf5eEaKJU2CPLwYeA+TJP/vzUh9n/zT8LCikxt/f?=
 =?us-ascii?Q?quimeoSK6mm7zRZ1s+Zlub60hxQNunUqWr/W3wDc9jPN/5+554a5EzyB5eaJ?=
 =?us-ascii?Q?JyJwoiPlTnOfT183QhgAGey31u36CHUi9t3Ter16hcIrjhLai2515EWs7YFA?=
 =?us-ascii?Q?uSHU9XZDXI2sWBAjWLAcrsgNn0ncW4a0EHKm65TIFJCO6oTLHzfaVrAGKwhB?=
 =?us-ascii?Q?pMSHEPhgaFlOPwnJ3ENIsYOFnUW7FxTSSDbWzREgpSCN+SQEKphjCAqTtzv7?=
 =?us-ascii?Q?9jFLMgxy+ZJAb52Eg9Wf8/GGi9THTUHYPpJnhEJEe/iNk7DjhBKSn+68Wkxi?=
 =?us-ascii?Q?nJI2XxzHfyYyhPkSf/KD36f3lVYFkM7TjW2jL+uj9HGznC9s9Xel5HfMi2wn?=
 =?us-ascii?Q?aKdfFooKXNysgwgymkglQMuTXderHHLZazzf5CxVbqbJ7u3WupdYfEpUk7ri?=
 =?us-ascii?Q?ME6vYnJHXXZqOLp6BGV817iMxLE7UB+srOrLk2a0Zv4tusO0fHW+hlE0kZ0b?=
 =?us-ascii?Q?0cF+e1llxjilEDechjLgfApeJfyFPwSy+Qqa3kxqryk42bTzYwfP4tXEnZq0?=
 =?us-ascii?Q?+zIZUJEvZeT9LTqWb5aW7Or/QZdnRteqBWLET6SJ2JQhFu89MN5NmxbR8L+f?=
 =?us-ascii?Q?cDnOgdGlTludpuZ3gkLHawYoYSSeHjY5tbma13/MThFMjcaLFVYhlaQWehR3?=
 =?us-ascii?Q?V7zCdezBVgeZGsq/lYjKrLxk7DDcmPMPJ4zKS3GItbqM81e3nPkBQAz8IT0c?=
 =?us-ascii?Q?flhfcxGN95P4jMQLSCj62puqzwSAamGfBb/8vPML5gGqwRiNpJoPnPGj5ykV?=
 =?us-ascii?Q?ucD9sP8YlwruwQx/2CcFfSCJMYaYcaKFd3dexx/CRveyi9zy4G725V5vZQmT?=
 =?us-ascii?Q?0QIHYbrEf07UCwo9wYzY58td/8TYW1cPoKiRJgeE5ITpstDNajFg28QsGq87?=
 =?us-ascii?Q?eKofY8oxy6RivjqC/BJntZPl4RK5tBqTZC9G86ZCuuuUS5fxyZq8sIXfTkd5?=
 =?us-ascii?Q?9rkkHJimsBEIf8apTMRu3WBdJXM9aYK8f6B+e6cyaalmMZtuk9hwxoQj78a7?=
 =?us-ascii?Q?gTsdbJIX1VOWvW3fsOnAbjdHAuhexHDPWI1NU6ozy19rgWUh7phRJgXs+qF2?=
 =?us-ascii?Q?Zndq8hpNbcgxi253+50a3CYPm7AXEaiDobfJ1BWu5FLfrqJfys3a26gRdjMf?=
 =?us-ascii?Q?odJUGws+8kkRpymsSOGeofj2uPB6O2VKzV6n3stK5CEdMvXAkN3GHPhDwywi?=
 =?us-ascii?Q?oClCR3nBndZpcYS9BMLL6Vsbea7fh/k=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14ee74e4-7579-48a3-bde4-08da12e0fabc
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2022 06:37:52.2024
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a2MQQmGSpUIo0yocVoorATjcJBcLnJbHMTv5qJB8boCzux8gpyq8tW/3dq8G9KO88yde1Hg2u7JdNVktWU8a4s5Ezqn4N3wOM/hQeL7Ax0U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4502
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-03-31_02:2022-03-29,2022-03-31 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 spamscore=0 mlxscore=0 phishscore=0 malwarescore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203310037
X-Proofpoint-ORIG-GUID: 7Hd8dYAn8HNsLIUBFGFC1nvS47PxvRE3
X-Proofpoint-GUID: 7Hd8dYAn8HNsLIUBFGFC1nvS47PxvRE3
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 30, 2022 at 11:16:07PM +0800, xkernel.wang@foxmail.com wrote:
> diff --git a/drivers/staging/r8188eu/core/rtw_p2p.c b/drivers/staging/r8188eu/core/rtw_p2p.c
> index e2b6cf2..f1a5df8 100644
> --- a/drivers/staging/r8188eu/core/rtw_p2p.c
> +++ b/drivers/staging/r8188eu/core/rtw_p2p.c
> @@ -27,15 +27,14 @@ static u32 go_add_group_info_attr(struct wifidirect_info *pwdinfo, u8 *pbuf)
>  	struct list_head *phead, *plist;
>  	u32 len = 0;
>  	u16 attr_len = 0;
> -	u8 tmplen, *pdata_attr, *pstart, *pcur;
> +	u8 pdata_attr[MAX_P2P_IE_LEN] = { 0x00 };
> +	u8 tmplen, *pstart, *pcur;
>  	struct sta_info *psta = NULL;
>  	struct adapter *padapter = pwdinfo->padapter;
>  	struct sta_priv *pstapriv = &padapter->stapriv;
>  
>  	DBG_88E("%s\n", __func__);
>  
> -	pdata_attr = kzalloc(MAX_P2P_IE_LEN, GFP_KERNEL);
> -
>  	pstart = pdata_attr;
>  	pcur = pdata_attr;
>  
> @@ -106,7 +105,6 @@ static u32 go_add_group_info_attr(struct wifidirect_info *pwdinfo, u8 *pbuf)
>  	if (attr_len > 0)
>  		len = rtw_set_p2p_attr_content(pbuf, P2P_ATTR_GROUP_INFO, attr_len, pdata_attr);
>  
> -	kfree(pdata_attr);
>  	return len;
>  }
>  

This part is fine.  This change is can be pulled into a separate patch
and reviewed by itself.

> diff --git a/drivers/staging/r8188eu/core/rtw_xmit.c b/drivers/staging/r8188eu/core/rtw_xmit.c
> index 46fe62c..5888979 100644
> --- a/drivers/staging/r8188eu/core/rtw_xmit.c
> +++ b/drivers/staging/r8188eu/core/rtw_xmit.c
> @@ -179,7 +179,9 @@ s32	_rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)
>  
>  	pxmitpriv->free_xmit_extbuf_cnt = num_xmit_extbuf;
>  
> -	rtw_alloc_hwxmits(padapter);
> +	res = rtw_alloc_hwxmits(padapter);
> +	if (res == _FAIL)
> +		goto exit;

There needs to be some cleanup if rtw_alloc_hwxmits() fails.

>  	rtw_init_hwxmits(pxmitpriv->hwxmits, pxmitpriv->hwxmit_entry);
>  
>  	for (i = 0; i < 4; i++)
> @@ -202,7 +204,6 @@ s32	_rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)
>  	rtw_hal_init_xmit_priv(padapter);
>  
>  exit:
> -
>  	return res;

This whitespace change has nothing to do with allocating memory.  Leave
it out.

>  }
>  
> @@ -1516,7 +1517,7 @@ s32 rtw_xmit_classifier(struct adapter *padapter, struct xmit_frame *pxmitframe)
>  	return res;
>  }
>  
> -void rtw_alloc_hwxmits(struct adapter *padapter)
> +s32 rtw_alloc_hwxmits(struct adapter *padapter)
>  {
>  	struct hw_xmit *hwxmits;
>  	struct xmit_priv *pxmitpriv = &padapter->xmitpriv;
> @@ -1525,6 +1526,9 @@ void rtw_alloc_hwxmits(struct adapter *padapter)
>  
>  	pxmitpriv->hwxmits = kzalloc(sizeof(struct hw_xmit) * pxmitpriv->hwxmit_entry, GFP_KERNEL);
>  
> +	if (!pxmitpriv->hwxmits)

Don't leave a blank line between the allocation and the check.

> +		return _FAIL;
> +
>  	hwxmits = pxmitpriv->hwxmits;
>  
>  	if (pxmitpriv->hwxmit_entry == 5) {

regards,
dan carpenter
