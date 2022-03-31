Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2366B4ED4E3
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 09:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232292AbiCaHi3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 03:38:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232154AbiCaHiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 03:38:23 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F80C36683
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 00:36:36 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22V5tZ8Z027080;
        Thu, 31 Mar 2022 07:36:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=wY55EZ4Jb7o/Thohxt+p69ZNseUrO6KKbi1OHR42bnc=;
 b=fuBUwMiwXfcxi0i7+3A4NowRFWN45fxslQP5f5jdAoNOEPPfAzFA5ccoMzk/73QeZ/nB
 P9ymZURABXUdix7ejbVSJG07qIvvojNtk72Wrvba+YSBU4zKJ09cAQ7dLRi1Exvw01pX
 WdTwKrJ/bdbYl1GVGPZizkpVxPnDs4ws9WTvzL0WyKYpeeacM/fyGsHkpaxcXv/ajQF2
 wBRtwXKtS+WZ4UjI48dn1p9XeW/ggYFn3NM7zR/bsiaMFiuyUvdZAJH13R6AAiVvPh/d
 fapViQrczOuXrdmobuVhBbmDV6KwjYUlsym1QkSr0PBw+oCxLKmpn5JmSUY9mp4U+Pju pQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f1s8cu8dv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Mar 2022 07:36:20 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 22V7WJON006117;
        Thu, 31 Mar 2022 07:36:19 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2177.outbound.protection.outlook.com [104.47.73.177])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3f1tg7qkc0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Mar 2022 07:36:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MIr/UMPR4vYCedZq1j3xu7+pvi2+n6zpQLir5SA1dB5HyX3iww3FXtWv+LPlWNhu468F0BNQscJ5K2arPLBZjRdzM1s8GgeFHQfjcSjBfvPYdlR/Tn81VRlHuJRWryPH+eQt5m0sCA8NwnGoJ6+CfPSDprdZP4S1mi/es25M1bljQEHncsUYj8ydU4yDj/CTyNjgODtblEbbsDSN5dz3DQoZuEzg7OgOuHMudJtgHCeam3MMSq2C+/4iLjMGGB5ZWldGt5ysFpmtx5nZdLa4nOQIjxuCCHWr2qgYGbg04TTEjK4aTpTYcn5AKxnT/ArZRPYQbMz7SbZJA/JGro06dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wY55EZ4Jb7o/Thohxt+p69ZNseUrO6KKbi1OHR42bnc=;
 b=kf5p5jGDwVAPPMwYxMib4t2uSytqpJjzwXXAGWXHYBFAajYQGfhUrHiQqVKApRM7tCY6JuA3zbHiVwnwol4s3hB+jhhErnIoV8eP6kKG+XnW31QdCW6XBmpnZ4Kgx36Yqa0/Nma+7uszNjJK0e7SinsAnvTAqhdO9Cnbl2hWJZz389OVIfKO7QPxg3jrnFME4s+rFXGCdhtIokp6Xty0nAnZ+vZD2sDhcHnucxofb+FQRWDann1uzS+DymADpn7uCchG3HsnOtH6HVs5Yj9aBova3uSD9aHEbf7yt9wbDBrIV0+Ha9gmQUMz7bNCyHA1OunYemGJHBJiXECdfh0Qpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wY55EZ4Jb7o/Thohxt+p69ZNseUrO6KKbi1OHR42bnc=;
 b=xF/Dr7SJVudabG6RQRoVPOoAIgaROzcc5AEDmXMWw99TuDTVrFxPidnXfV2GeYcL6zAg2bXHE+F/X/RcsXU2DsDpXxGntim6ZEQh2RfLyk7catCEP828/XXarCc7IOmNZQNVQXeLWfp4k4v8r/SBussopcyAKQ4qVO0rileAOw4=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BN8PR10MB3140.namprd10.prod.outlook.com
 (2603:10b6:408:cc::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.21; Thu, 31 Mar
 2022 07:36:17 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d4e7:ee60:f060:e20c]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d4e7:ee60:f060:e20c%7]) with mapi id 15.20.5081.025; Thu, 31 Mar 2022
 07:36:16 +0000
Date:   Thu, 31 Mar 2022 10:35:55 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     xkernel.wang@foxmail.com
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] staging: r8188eu: fix potential memory leak in
 _rtw_init_xmit_priv()
Message-ID: <20220331073555.GK3293@kadam>
References: <tencent_12789CD2DEBF33C818B3542E170737854506@qq.com>
 <tencent_2F72CC5068850B2BEDFC2B8058303FE6520A@qq.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_2F72CC5068850B2BEDFC2B8058303FE6520A@qq.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0063.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::21)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 929f57c7-f845-4c4c-1782-08da12e923a4
X-MS-TrafficTypeDiagnostic: BN8PR10MB3140:EE_
X-Microsoft-Antispam-PRVS: <BN8PR10MB3140BE64C31728364B2FC0FE8EE19@BN8PR10MB3140.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 01s4MG57enShHJM7R/Pi55I0uioJZza1Sq+sA1hUzhI0iaKy6wDblRt3Nya2N/vW2E7wl5i7lDNALT8S+GRDsy8Pxal+QQ+9AhrR/FyLvoVA0dAuei+F0MqiNRoqV71WPxAuoTZQ6qMGYy9rgv+aOCt/6VniZuLT8o8FkPEfz1NCln1Ib2974ZyTZAbGUvbzky+Pi2t+1g9CJd6Q+WsPf1DJuO54B1rPe1ks9CVkdmZNKeMMeoOP/WWkcIYTkawRPQLWp+HqxNDHfHGEvfIe2K+V/PiRfRA+Ee+evj1ZmsI8w+3PTNU8F89GVUc2ypEOVVTguymlBwUqaJd0VWiy0nSlQSdFAUW7I7Eid/E+xJqsxKozO/EZPX8NjzrCc0NzyARLjpmfoALLXCZ1f+4xNT8is4UA0nI1q4gv6RaMgjVPgBiruig3uau22WqtTh9E+NgTS1Qub5KJjICm0lLXEyb5y2WRBuGTT11vgFt+V0irVlmpUaCnR+if+j4Uu6Qdh8eT0df0hnO6QlffF2wxlo3X0CgYuZX1qBTBIVReQZ08Bz/DvE86vYMFEF08HyENHJvsFaZGlM0Amw82i2Q0NZDC+hQoQ7+/SwJvEj/lDBTjBV3rhoHL92NKUnxtyNxcekesOOWuS2aZck5jitFh2+cDuR++qxq8V3Oa8IqpUnlYlbhfR6o+De2YYF1U3ilTTmFIVVoWbRnM1TrtZyzZMCjmTc9gB4gls02zBTgYLykhHnLUHbbUMiM/L6botWnu
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(4326008)(8676002)(33716001)(86362001)(26005)(1076003)(316002)(66556008)(186003)(66476007)(66946007)(44832011)(38350700002)(38100700002)(5660300002)(6486002)(9686003)(508600001)(52116002)(6666004)(6512007)(6506007)(2906002)(33656002)(6916009)(8936002)(48020200001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?p4rLswlWvJBuG1rLtuqLmq1oV0TXMf1EwaIymD8VpN5uZqbFwWjbLh5iOqas?=
 =?us-ascii?Q?WwOZ7vtvubzZwUU674b38Mbw6efjRo2epcDTxHHoHNxqRvXumyZZOjuN+gjj?=
 =?us-ascii?Q?1J2X9EtMmdzIE7S8B9z31ERPiaxidpNFtiwFOHOIY7hPvappgA3Vfn6kLUBX?=
 =?us-ascii?Q?lx/PQsoNMovJ7GXJ3OBPOpoX0UGs8FzAPUE+9wXawXWGHa39UAJMCsYqkHY6?=
 =?us-ascii?Q?9dekKhMWW3aME0zgCyCvlje3FpRDSTrRVLgLhX2XTA02Te71i021iKcaUPZ8?=
 =?us-ascii?Q?6YLRJ7IK+6zI4Q/kJHf6MMAs4zzFkXA/Ko+DREXWP7H/Jqmp3wiL5C5t3Fng?=
 =?us-ascii?Q?czAZtMCZ4poC9Eff/jkJw3y4Rv2cXBStzRr9CiNfmYav2n7QoPXlU+JpiLrR?=
 =?us-ascii?Q?wLz6RGZNLUKEQXHdlBjhTs+F4ctwkfNI/wCYsw7A2h0XYsB9r6rDvUoh8T/6?=
 =?us-ascii?Q?qeCyr9/W4oUWfOzQcj30MRWfzGK/TUIrJ2AZg2WrxRvvyu1om0flcNjM4+MY?=
 =?us-ascii?Q?gVM8CEG2PxGLIyFWhmCSO7iv8Lm6fo9Z8hSuzErtLyNv7O5NNi4YigoJ2RrI?=
 =?us-ascii?Q?r4iXnHy7FtrkXMuGPJV55kH60YDBjBWr4YCd2deL6cFzqVsUWmI+rBfjVcka?=
 =?us-ascii?Q?jvDNddo3BLVIiZ8jSWm6omTIqG2KYoxoHNTseAPsoZ8efKfz5KQR727lUkVg?=
 =?us-ascii?Q?l7x4zMHE+OsNNds0+AMmDMhI3P82nLVX3Rj/KDaVfmwoMfVT0q5Kbw0lV2nk?=
 =?us-ascii?Q?s3OPdduwwRoqN5QgUxmSLWgobb7xWcSDBBLwOAdzf6LGr6zdu3p2Pe6H6XXY?=
 =?us-ascii?Q?hxn4CtIZL7lpcn/6i0OiR+05ocxteWGIUc5RtWSCAh8S04qfjY36jrjRMdwy?=
 =?us-ascii?Q?tArYqIMpWYGtqdyEa4f60PXm08J66Uh9FneTtFWucIKvAOuqgUWMlYlC2fyg?=
 =?us-ascii?Q?RXswkMKwXO7UQKcC5M/YMlNoS7e0/u9igbuX/AIY2FPlvtQWjXvXvIU6rckP?=
 =?us-ascii?Q?BVwlBOuahlnEGcmFvOXbazPgfsEHgm4iVlTUb8ELjzq1ix6R2ZdOVbzQEUcM?=
 =?us-ascii?Q?YLm7KVETVMXkM2E6xgaqYdCLG1BP3hsodNQ1jg17pmSY/Jd0sJpC4T7HRUbn?=
 =?us-ascii?Q?7X1qjbWdlaHZAWa5hM4BW2vgA5dF2P246yo9Jz5nvelbdiv9X23D7mFVJMEg?=
 =?us-ascii?Q?U7CqnttyLwwcWfjKt2SxIgkfxssQUfpOEhBrICuNJVNk6JFfGwyqHiB44S2T?=
 =?us-ascii?Q?2z86v5CpqWd2r3+GZ3WaKL0jBFjWa9vPHWE78yH7ZSJPjq530qsFoV2VNV/E?=
 =?us-ascii?Q?dRkTka+shz7KAsbtcghlfOR9C/82eU7y2slIaCtAfyHiDu/Am3vrvBwrpG15?=
 =?us-ascii?Q?NT7CpzFnD1sDsRyyZbr68wDWqHel5Rv+Q/WxIuivFzlFtGXLzvu06LoJfXxv?=
 =?us-ascii?Q?ZHv0nObZSQ3vvft1E0ON8tPgk999XKXNAkwFeC5m2SCBo3W8WZy3PvO+Ain7?=
 =?us-ascii?Q?/sJYYPy4HFqmp8jZZWcA9x+tcwNkl5g/KkgiSTma3dfBTT3e4s+BbxYSeRzf?=
 =?us-ascii?Q?5txDF5/ixP2pwbKNEOBf9HPHVwAAeGqm0yAOCXPTJ9X31DmFwdDJBMeRFpeo?=
 =?us-ascii?Q?sWtNM4EsKgJW7eNec4vL1T0moWPWTSEDRJC2R4fNQn7c6GeeXc3+NbkA1hrP?=
 =?us-ascii?Q?wSn4bzoXHyGbLY2OIqUk9AeElWAWyUsZ6UiqXykCfD6B7dm9vbsK7FaQF8Ds?=
 =?us-ascii?Q?tjqPJ+KCmvE5+BncAiZbdtX+qE2sRS4=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 929f57c7-f845-4c4c-1782-08da12e923a4
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2022 07:36:16.5201
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wFOjjzJMxn8tUrYFRswDgtZVXyI2tduvTYJM+sK94+lx/yxl6MId7C3U2yYuIy91fvN9NOFQbTn2ZekS0s1BkLesqCbqKFJbDvV2kjOvez4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR10MB3140
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-03-31_02:2022-03-29,2022-03-31 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 mlxscore=0
 phishscore=0 spamscore=0 suspectscore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203310043
X-Proofpoint-GUID: gkQOrRTuMQXSvVIg00BfthHnvz4cKjCN
X-Proofpoint-ORIG-GUID: gkQOrRTuMQXSvVIg00BfthHnvz4cKjCN
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 30, 2022 at 11:29:22PM +0800, xkernel.wang@foxmail.com wrote:
> @@ -134,7 +134,12 @@ s32	_rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)
>  			msleep(10);
>  			res = rtw_os_xmit_resource_alloc(padapter, pxmitbuf, (MAX_XMITBUF_SZ + XMITBUF_ALIGN_SZ));
>  			if (res == _FAIL) {
> -				goto exit;
> +				pxmitbuf = (struct xmit_buf *)pxmitpriv->pxmitbuf;
> +				for (; i >= 0; i--) {

This frees one more element than you intended.  It should be:

	while (--i >= 0) {

> +					rtw_os_xmit_resource_free(padapter, pxmitbuf, (MAX_XMITBUF_SZ + XMITBUF_ALIGN_SZ));
> +					pxmitbuf++;
> +				}
> +				goto free_xmitbuf;
>  			}
>  		}
>  
> @@ -153,7 +158,7 @@ s32	_rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)
>  
>  	if (!pxmitpriv->pallocated_xmit_extbuf) {
>  		res = _FAIL;
> -		goto exit;
> +		goto free_pxmitbuf;
>  	}
>  
>  	pxmitpriv->pxmit_extbuf = (u8 *)N_BYTE_ALIGMENT((size_t)(pxmitpriv->pallocated_xmit_extbuf), 4);
> @@ -169,8 +174,12 @@ s32	_rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)
>  
>  		res = rtw_os_xmit_resource_alloc(padapter, pxmitbuf, max_xmit_extbuf_size + XMITBUF_ALIGN_SZ);
>  		if (res == _FAIL) {
> -			res = _FAIL;
> -			goto exit;
> +			pxmitbuf = (struct xmit_buf *)pxmitpriv->pxmit_extbuf;
> +			for (; i >= 0; i--) {

Same thing here.

> +				rtw_os_xmit_resource_free(padapter, pxmitbuf, (max_xmit_extbuf_size + XMITBUF_ALIGN_SZ));
> +				pxmitbuf++;
> +			}
> +			goto free_xmit_extbuf;
>  		}
>  
>  		list_add_tail(&pxmitbuf->list, &pxmitpriv->free_xmit_extbuf_queue.queue);

[ snip ]

> diff --git a/drivers/staging/r8188eu/os_dep/xmit_linux.c b/drivers/staging/r8188eu/os_dep/xmit_linux.c
> index 565ac5b..7aa39b5 100644
> --- a/drivers/staging/r8188eu/os_dep/xmit_linux.c
> +++ b/drivers/staging/r8188eu/os_dep/xmit_linux.c
> @@ -95,8 +95,14 @@ void rtw_os_xmit_resource_free(struct adapter *padapter,
>  {
>  	int i;
>  
> -	for (i = 0; i < 8; i++)
> +	if (!pxmitbuf->pallocated_buf)
> +		return;
> +
> +	for (i = 0; i < 8; i++) {
> +		if (!pxmitbuf->pxmit_urb[i])
> +			break;
>  		usb_free_urb(pxmitbuf->pxmit_urb[i]);
> +	}
>  
>  	kfree(pxmitbuf->pallocated_buf);

No need to modify rtw_os_xmit_resource_free().  Passing a NULL to
usb_free_urb() or kfree() is a no op.

regards,
dan carpenter

