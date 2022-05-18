Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3167552B1B5
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 07:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbiEREzR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 00:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbiEREzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 00:55:10 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C7D62BB26
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 21:55:08 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24I25c5R031641;
        Wed, 18 May 2022 04:54:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=ofI7i+OPHoLaIYhgT6QtwDh7ltAo7BW2cVWysxSixLY=;
 b=IK0Vn/rJEYR4TOBLQg7LyR21u+rqtrJ3MVsPMrXHF8hYr0Z0hFtY8bofFWxvWiPZE8W5
 lbpv76pHL0u27yPw5saTWDUYsDS881dIQ6Vux6k1L+QrZl9zwsW70tXxXTDaaNZLKNsO
 PsyMdEy0UAnh+nl9VwgceUHYuzv/84tqg9Ide+sSQl19lcnhBeZsOTib1EwJKVP6Uf/W
 gCRLaYt2+0PuxLuvDnyztz5Ofb0J0XlXMMkV0ZN1hQW1Mr+ljePOPZoGMwahHxNWzOwc
 DNT2CxDsuisBEUZOrUd0E6LbvS33M9tfRZH/2qOJy2JfK/VHTohjAS/dEP93fKD55sfF VA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g24aag0vk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 May 2022 04:54:32 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24I4nxBb002507;
        Wed, 18 May 2022 04:54:31 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2175.outbound.protection.outlook.com [104.47.73.175])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3g22v9cdpd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 May 2022 04:54:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kVDjrpKe8D0AYy3p8kOVzhTeR6hTAnssm8eMmQRo7LdLBZmVReTuKrSR+jKdaieCBcC2oms6nTDU5fFY3Va/uMDN4gRs/lBm0WgFwjnRoxJ0yXHeq0IKBUGIRyhXJMrgze9yPIfBsNRnFryrCoxW1J1eSrqscqDFXqUakADUuaK1c9oLx4M/7v+OAwDSk68yPlEKzSTmwE9DWEltJCuDUUxXM0I7pnW7AJrqW1b6owICQRWODqvwQYn1oaQIrmuR6NsDfpfCElGJ2yqCgKfnDe8gewqTteqmYrQBrHqewDTBTZzDAHim2dqEAx6PutQWePBIQDUo1gAt91Jw8SfsmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ofI7i+OPHoLaIYhgT6QtwDh7ltAo7BW2cVWysxSixLY=;
 b=g4YZlpiCUv8deqqVqZpFWvFu4wWUoKt3euRmTDCOdTizZPc2lgzfGbIevaEhpBp/tNaZZuLOmvDqTSkvtwiBLxvFafD2apIT4lOKYqVjLYC8eVRVGx4ZBsD3AVgjLXchUdPzQlmgGhuvJfIW+3uj1x9Mq1vNzrLU+/rjJSJqDpiZzeULFYo+kR8Yz+LDuZXN2fFN1dNl2As/bf9QGj3S8oEgVQiDPKGexTt07PgBwM9ZzRigKJWFuiJ0vvO2ZTsZTOaMlOR+zp/gvlNMjDiUse2jRK5CJjUic9eKsYKqn7bWo4e76Aby0ldDQU1TnxD1TBG60Rp2ySaNt1Z7b6CDUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ofI7i+OPHoLaIYhgT6QtwDh7ltAo7BW2cVWysxSixLY=;
 b=VwDeW7EQkr65pjjXLav90kaZ7I/FTFRWan1MOxn6qeV5xKi6wxNcZyHDFP6Gjczk8WmxmhOcl80U2DLBkauObHYtJYpBCkUrt/zR3Yp5uIOVg9Po7KUBB4mOKMlxwr6dGX2NQB6DoJVAOLXLC8pqHbZpKWJ30gBFconiA6JNHQA=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1661.namprd10.prod.outlook.com
 (2603:10b6:301:8::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.13; Wed, 18 May
 2022 04:54:28 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::86f:81ba:9951:5a7e]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::86f:81ba:9951:5a7e%2]) with mapi id 15.20.5273.014; Wed, 18 May 2022
 04:54:28 +0000
Date:   Wed, 18 May 2022 07:54:07 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org, straube.linux@gmail.com,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: r8188eu: add check for kzalloc
Message-ID: <20220518045406.GO29930@kadam>
References: <20220518030957.464413-1-jiasheng@iscas.ac.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220518030957.464413-1-jiasheng@iscas.ac.cn>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0041.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4e::16)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d1cff347-572c-4095-7586-08da388a7cb8
X-MS-TrafficTypeDiagnostic: MWHPR10MB1661:EE_
X-Microsoft-Antispam-PRVS: <MWHPR10MB166181B7B825CE7AB4F774F78ED19@MWHPR10MB1661.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lb9I6N3pvTHyaJGxyBZ5Y2mAWBT6O8aE4VCutAeiVEzkA8snsWZpdXd40/rcWkpD4VPgBTZr8ZioO9rXCVmBBp9XhXPAU5JX5pAAh448QhUOVKIQ2mSUZiJkiwXPCv2P7xf/rmWI8yiPVY76IVBkLAlwdHMD3K6HGDc2eqhm1UAGMwH1OUIlSj9y+unrdVd3EqbGHz8P0yt4gtI4xr5jbcbrE6laoNbvsNLLK/dukUdAyMSN5z8Sy/gQrZXs8/wn1YE6W1fv2Hz1P+j/0wj5EEwBWFZi4qSt1k30ZCCRcFit6O0Biy/Mg6OEokkL8DIjE6337at1DRXXeThbRVMNbC/qzzDrXGG7vxk0Dn2N3t588TVgOqo5kGHLENv8ZRcI3I+VkF1pHEtlqYJzUCdCd2YGiK7oh0KTyvjtJ8A+IcRtAdiOTj84BjFzoPXVBY0Qp7vgz8MNY2hkPlGnHiWHlDuHwMESwH9xC9vkUUMVTpALEZvX3xgd2m68Dul3cUPK1u2fvTDOmMeqlxKP/4xpEiJO064kWc7zf8uF/pN2J33JDFepcsDc53yEmrepRlPHQtFT7LTTX/0yxEJSHKCacIimDEfsgrydc5PPglQNFXHz59YBsp6252gqTs0hVRzNVS+cMkVizqxq9Mxpgh8Ob2U9t0AV1dnmq6Bk6lgbdzDdTcvCSBunA2+6JEsMm5yDkTFYiHiGSwJ8HfID5+cezg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(6486002)(316002)(33656002)(508600001)(2906002)(4326008)(66476007)(6916009)(86362001)(6666004)(66556008)(8676002)(38100700002)(38350700002)(5660300002)(186003)(9686003)(44832011)(6512007)(1076003)(66946007)(8936002)(83380400001)(6506007)(52116002)(33716001)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HjNkTJKoh3FMsGxXM0j2Il6pj5FUA+ydQeF+j/tnUMp5UAVpUfie9kPLPYmG?=
 =?us-ascii?Q?UQDqiaIatsn9nK2BKsJg7oSz1XvXAofyu1H6AKvAR8MOFGdc56BtkYB8DV8j?=
 =?us-ascii?Q?XS2ZjTFRH/wXscI50Kmaye/Fcajo308BQ7KO3EX6FlQd1WVp6v0ho+qux9st?=
 =?us-ascii?Q?rj4jZBSqtTFydvMQ/5rsSiI3tdDSbitLvtIYzMdDrkJYlm+EyW0qatUe0jg3?=
 =?us-ascii?Q?LfTGwR06OSSdMVV/ITe3WAQ9X2O5Ry7rWVXpqxP2LcnAyRPf1WLxIA4JJtFm?=
 =?us-ascii?Q?OwHhXSeOi6wG73ia8nVerdGnxD+IGcPfpePdTSxHhEqh5UsL5aOpFH3Ta9EI?=
 =?us-ascii?Q?pWc3V1XdX5Nl0h8Bw4SwfcprCgTa9vBD5Z8oG2jM66mUc+VQCltHDhos0Vla?=
 =?us-ascii?Q?H7lCIWTRrkfmXi2hZyTydiwwssb5r4N88RcEGPBfLWYOv/YxiYvdZflPt5ZS?=
 =?us-ascii?Q?asTxNSpRArtcC56+sE7fl+AKJcz+L1Uiu7bkvpENyUL8Myz7I72oZeQtbrkz?=
 =?us-ascii?Q?Im96N0JvmkitjmYgkSEi3FV868vqph5qeIxlrzuxZ79REta90m2VquwAGhFw?=
 =?us-ascii?Q?spM67SSmh2cJZP4xyQcN0twDRAMex6SSHX0eccnngkcuLnoZ3H24bmOCUGyB?=
 =?us-ascii?Q?xKsOcnRAhqfG4+b15wIoKYtIQv8E5Vl5ZhGxLewXHtxL25Ne8nWdvK8aIarv?=
 =?us-ascii?Q?VeIADdhS1SVIxji9Num2A6/u64Ts6eZe4N9PZ3fuPzZkF8Dj5tEr340IFxvU?=
 =?us-ascii?Q?47xrnYo76a0Syoi213upDDgNrV7EIt2yIhZZFaNpAxxKFXXXbtFUNYNpgZya?=
 =?us-ascii?Q?tZltTbhE8N/kyfS3mL6A5949VHgH11Zv7fTZ4D8o4fRxjfCe6k3n/FqAwLDR?=
 =?us-ascii?Q?8ocllbVVvaCKNpEXF6nW5B2WNpaVcDdwwJOO6/5QhIHPueVs3tHG1VqIpIDD?=
 =?us-ascii?Q?hOPnSgWIoXOhY1Mt1WSnjBfKMS3WTLxHJmWnbClyORii6ORXKObkgnU5AK70?=
 =?us-ascii?Q?rRVVA4vMavtMT6oqlTtx5HoOXEPoREETq7nEuS4va1h7TH35V1LhPgX1/rC6?=
 =?us-ascii?Q?vbLv6cOwIEJWSG3vuUzyNE9mZW2CLhdXLh2b+298h/ztxX/LGQp3BfCczcF8?=
 =?us-ascii?Q?GV4Di7tkYsG+vDvSvRcwvsONtM/u2lvTGiZC9qSLClDG+t98/IzFcK2Z5Zmz?=
 =?us-ascii?Q?PraEcayVBq/dO46y/HKddd657v2LRSYzP44lTdWBcxlnrLjf5CqWofuS/yPe?=
 =?us-ascii?Q?qBEIcEdGE44VJclPGT6nWI4UvKcoN+Jl2AoTRqCkvTRsCizqDzMUBO/WfEAG?=
 =?us-ascii?Q?YtZJv2lDkGmr7zZFy0Rpqb3mo/GwinugqDYYSGQCHeqARIL+FBy1JtTrT/H4?=
 =?us-ascii?Q?6flg0GiXkvhqMD9XHVssJ4UW+SsDps/R+/8iTzdXd0E7ye9IPPUGmLNR3xDT?=
 =?us-ascii?Q?xuIS4YfJypFIF+mYdNuUBSJlAFhqTAqFjTsQm/7BauBRVsPIUh9vUYz2gSUM?=
 =?us-ascii?Q?Bo/Wh1H8ME12c7VOAVYZ4/vjTv0bypkki9rtfV8KvQvfw6OtHvwZEhXqN8Yg?=
 =?us-ascii?Q?Nhk4+qUVZQ5dE/26IWmX+CYz0eB+e7jpOz29JxQEC6S1Q/PzPkrlSFUHFYSy?=
 =?us-ascii?Q?gXiQrX+2gu/En5SbnYy9uk4g8bNqBhyFyigAtM6dZ8Sd5ABP4r8Vp5qjfLg5?=
 =?us-ascii?Q?OzjG6mkop2MLUyuFV42+k2MgLjfJH0FBNaV/qtskS99RYeN+bRHzBHkWKjKH?=
 =?us-ascii?Q?suLM76Gx09BhF+1e9H4Lt0bGw7GDN0c=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1cff347-572c-4095-7586-08da388a7cb8
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2022 04:54:28.4045
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gDzu8v2KEg08DGKJ35sl5xPWfE5mKC0zvMbIjQA3j/zGbb8hbgU2apY2+xA33JygRhz1oirmoU6Aa2TVgcPEaEtieaiP68g2XE/PmSvMt10=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1661
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.874
 definitions=2022-05-18_01:2022-05-17,2022-05-18 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 mlxscore=0
 phishscore=0 suspectscore=0 mlxlogscore=925 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205180028
X-Proofpoint-ORIG-GUID: 0nnK8PYcF3ONbBCLnHXU2v2r6FxJ6zsx
X-Proofpoint-GUID: 0nnK8PYcF3ONbBCLnHXU2v2r6FxJ6zsx
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2022 at 11:09:57AM +0800, Jiasheng Jiang wrote:
> As kzalloc may return null pointer, it should be better to
> check the return value in order to avoid dereference of
> null pointer.
> Moreover, the "padapter->xmitpriv.hwxmits" should also be
> checked and return _FAIL if it is null.
> 
> Fixes: 15865124feed ("staging: r8188eu: introduce new core dir for RTL8188eu driver")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> ---
>  drivers/staging/r8188eu/core/rtw_xmit.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/staging/r8188eu/core/rtw_xmit.c b/drivers/staging/r8188eu/core/rtw_xmit.c
> index c2a550e7250e..f47d2bf71a45 100644
> --- a/drivers/staging/r8188eu/core/rtw_xmit.c
> +++ b/drivers/staging/r8188eu/core/rtw_xmit.c
> @@ -179,6 +179,11 @@ s32	_rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)
>  	pxmitpriv->free_xmit_extbuf_cnt = num_xmit_extbuf;
>  
>  	rtw_alloc_hwxmits(padapter);
> +	if (!padapter->xmitpriv.hwxmits) {
> +		res = _FAIL;
> +		goto exit;
> +	}

Please make rtw_alloc_hwxmits() return -ENOMEM on failure and zero on
success.

regards,
dan carpenter

