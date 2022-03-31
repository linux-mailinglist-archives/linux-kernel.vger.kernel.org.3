Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96E674ED862
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 13:24:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235108AbiCaLZr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 07:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235097AbiCaLZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 07:25:34 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4828D6247
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 04:23:43 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22V8WVCv027875;
        Thu, 31 Mar 2022 11:23:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=HzWsSg7sJTNwNdc+KlM6nj9YusPMFNBTJCJ+O9chRYA=;
 b=FMHlsfG7ZZSpemMmZasRwxse3Swa9HgUwo8Ofg3ieurIaEPGvMeA/uFeoScwumH3b6Bw
 5Hs5iz1bFYGrKQL0C2b4murg1s5Rl5bY1XRMqLTutkakCAaTT1uweGMPWvxG0hYcZmfU
 w3XDPbsICd8lJ6ptXIgKFQ6HpvMdjJeAv/yqtyZU6uvqu5wJvrBq7NKhkO3+AsfxefC8
 56tU9089NgwVlDugBV8TqT5g5kOelNrkOixnlU+zZXjcy2ofLlm+iiQkL2twSRbIpjb0
 O/Q/6yKhSCGlWxzhugHxq6dUltfHIJK7ilk1M5LAvWFsCDH9aG3HAJixWEsSBCNuzEBe qA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f1sm2m3tt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Mar 2022 11:23:33 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 22VBAZD2023595;
        Thu, 31 Mar 2022 11:23:33 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3f1s94g02p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Mar 2022 11:23:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IJLJjBXoq/9TRYKxbnUEiI0LwhQTEOfnEaGepRvXzuR2JxXdbAfCA9nndRBynob/VItgMHZ5PrFbWHKN2scFT2BRaqVE9eP6ef6lPGvdF2rDQqvUW0mjGLFdCnk91Pjd7h7x/1X17rlv3T2kZRP3cXVrS4PIzmL184gruDam4WC+SFLNqNCjzB4gtt7WIpJX8RFGV6lZv+F6+17D8FedkXNU7ZoHrU6y6x4lcYvH7XrCoSGdxc0f3P5joiK+CWc+adMTNqR/U39Md6UYhn4WtlcMKh2MWPT9eqgT3bKhqwnCtPPiOUTseHbK5so8yUjD8D4Mn+23j/GF0oQtCx3ObQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HzWsSg7sJTNwNdc+KlM6nj9YusPMFNBTJCJ+O9chRYA=;
 b=PDx3UsvZ5N6tPttcOnH/97Jl1uhKXptB0y/74LE2xrmR8EFcBVVnUZ2hRTBBpvSLNKINaFDGUgNaIaI+gSNNjBfiH+3e3JhjiJJodOREga6eNBGuaABZ1UR3WrYI3IVK7TEfZhzeJWRUz312n2/Ei8rn4SvTpt0MHCLqhhtelbq2BxkxuVYED9ShsQIuGty4p2/YWv7R4uBfX7dKuiOpH2P5Qwi8d69X78dm4i5BR4ljvw7p3wm7xfweKpFRwbNBgvtde7JGWmNDpvlmtrlHqEHRI/6Iiq22K40CAig6KFgsijfaDnqAaBxvPb/zDd0a1rGzQ0sKZA+Mwz/fpTpqnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HzWsSg7sJTNwNdc+KlM6nj9YusPMFNBTJCJ+O9chRYA=;
 b=cLYvG2GEJhtLhYZliA/0evq9BXJ/ihpYOWjIR3XUWDzBtC2nySH9DAg3A702wJBq3nUrjYz+uNr3W1uvfRTt3ii/zIN6xRsqdGg8RmhX94FMq7hXykSbgXUyDkAjhqWIJVaKa6BLH1qCKf7/NxoUIWayOix9J8udTXSqjb5hDqs=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4580.namprd10.prod.outlook.com
 (2603:10b6:303:98::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.21; Thu, 31 Mar
 2022 11:23:31 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d4e7:ee60:f060:e20c]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d4e7:ee60:f060:e20c%7]) with mapi id 15.20.5081.025; Thu, 31 Mar 2022
 11:23:31 +0000
Date:   Thu, 31 Mar 2022 14:23:12 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     xkernel.wang@foxmail.com
Cc:     gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] staging: r8188eu: fix potential memory leak in
 _rtw_init_xmit_priv()
Message-ID: <20220331112312.GO3293@kadam>
References: <tencent_254AD0FF06201BCCF5B9911C6E142CE1F208@qq.com>
 <tencent_A5280DFCCB827030EBE73673F0510084970A@qq.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_A5280DFCCB827030EBE73673F0510084970A@qq.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0025.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:2::13)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 662fd7e8-481c-477f-6e76-08da1308e2ca
X-MS-TrafficTypeDiagnostic: CO1PR10MB4580:EE_
X-Microsoft-Antispam-PRVS: <CO1PR10MB4580970F58A40C1D271B8ABF8EE19@CO1PR10MB4580.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tNUtDTc2KYOI6UbNZhnVUPhl38gn0yDPuoyh8B0rxpFL32oUMT1AGiSb/LBpYiySBxBzIwsmUFUb6Ospr2Qex60elaYlcPM/pRXmS9cjQLyivcdBJEe+dwepvPwsqU3CYD98r0QXi8aGA8ZGo8xCqPRthoFGctXaDD5sd7/tiLDoB8QdPoTrcWM01FBE70HBH70Kqf+QAsp/cnvN229HIO1kmGQpe4UDOnZ9vLnxYnTTGtIdq2eZk43gKjFsT1zJWbE7hnRtd3CUUQ6byX602b7pH/AJeqKMUhPzTrCsg/QYBpyRFJpRIHaRBfRwmtcDGrJ2Jwjdu5ZB9jZScE+h4EEbDOYhT1Efbhhc+w3/EuvpkvfYxS2xLPP7sy/nyh9/V7nn2vutiCUSlwZqlbnda4fVkHLBeDtNLRq7olF0f3gU+gx66dgzrUBqnepgRmjIp91tjBkxAmczBi64Ao+z1pWwAnYbs7REhdybN2G+rX8eZQtqzG08BX3Cad0vZmtlkLYB0fhx0cxhSYbb83ecTK7dU3IMUtV+u6upqJNorqK3JCJIb1gxvN5bh/rSvvLzcGyobepfmG7w6qyo3aNM/iR9RW7LiyMsDD5vZD6i2Y1W1Qfkvn2KdU2E+CndcfRRC85SkSfgk/qz+03EZ/aCng8ko5//zob+Gr2czX8cynYRg157NH1nBV2bt15vn+X0Bmckjm8m6LzfCDOLLhQYTGCVGPgnye22S/Q/b5huwrPY0HdV/DTOvNJhZqqcUHsw
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(4326008)(26005)(66946007)(66476007)(86362001)(6486002)(186003)(8676002)(1076003)(508600001)(66556008)(33716001)(6916009)(6506007)(9686003)(38100700002)(38350700002)(6666004)(6512007)(52116002)(316002)(33656002)(2906002)(5660300002)(8936002)(44832011)(48020200001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uBd8hnt73WjP+RJVJ5BlA9qH/CuVx/zJEeRK7+5eRTLznIvJwiJlQlGpmoVR?=
 =?us-ascii?Q?pZuPkLtpcQ+sMFh98TJX0+cMCETapK8rr63tsu9oUi95UqVC74L6vMw5DMLy?=
 =?us-ascii?Q?p/mpsrA7vQyWMf+RNfL4dSnFzeOpFak7YCYCLXdsa7U0jVR8D0nAOOhSj5Tt?=
 =?us-ascii?Q?V2EqXwL2z/t2olPF7g7AuNfu5MflNHnsoN78lX1WPX5KA6nnmZT2Xb8U0uxD?=
 =?us-ascii?Q?IF/sqUWkbfmStDD+sPmtIGis4HF/J5TGSdKkBnnI9pLsNBExp/jisKajBDQO?=
 =?us-ascii?Q?Qqh1k6ipRnWebJVZtr+5xJh3PB1rSglcaTK9uiM+FEwLC3cgEIPR/t3mfl5e?=
 =?us-ascii?Q?eCaIn6JSweuIPrB4thx6FiZSThO+ZdK/KtQ04IP33PqE+o1p3thUBIVGcgio?=
 =?us-ascii?Q?6Lxx7M/Rx3KUDF+Ki9tAnvdfWijez+J+H8ARLqI5ebTXSv0mflEKEYTXB+h5?=
 =?us-ascii?Q?QwNfS4Ced07JBhvCBGFDtj/+m1GpBecVZrfD3t359m+Dc8Y8izL/80oMqAP3?=
 =?us-ascii?Q?WJFYlTLS3BBR/855zFgbrmvHrSfpFlvptd48EhFxJkecQRlGOQGbSMKVLt59?=
 =?us-ascii?Q?uBU2BsNuInpwMbEDTML71rjpIf3MNg5YGR3L2UEDGeGBTFKrAIe/TSz5BREi?=
 =?us-ascii?Q?UGU5pxpQkOC2bz3YAPJeoKdImz8UiBey3R56xcpl9Moh9umObdG+rsHyL9GF?=
 =?us-ascii?Q?eX2y3qqaaKL9NIpX5HZbYku3zvEDsVHT/tFtMEDB1UnDsUuRYF9KCgTqQqTo?=
 =?us-ascii?Q?Bg4i9AUJTwsnBv+VHx+fPMRaVshadE4lEvT/11ft0/fbENrk4gq1Wg2SZcRL?=
 =?us-ascii?Q?kSbqhMhJSFCgF22K1ptFrQqOzmgBSawoX7pW6JmfT3CCYB6tZmCaC4c0RTxO?=
 =?us-ascii?Q?AK5vM1MKqcAlB6FCvv8ob8Ir8Hr34mJmpmY+uaSAkIo05p7XzvghYEtwF99B?=
 =?us-ascii?Q?HvYT2KGuHNXS86I8Ncu9nAr8AZ4DQjFWGbiUHCCAwVN7GFejlk2A091eUd95?=
 =?us-ascii?Q?NItfsi3gzUdrshUGG5Xx8Dvvt5WrVJkwZNP5rirmEd3DRjpmUqJVYImvU/ps?=
 =?us-ascii?Q?5mLU4BoDkIayWx3+Z1nRMz+Qvf1WpBn/J6ThVw5n28cI35tPQ+3NS35hn0wF?=
 =?us-ascii?Q?/TzKO8vE2VumhuALLmeyxb2M7NnuHN7SQRbYlkRy2lRVKofuNsvkzZfwERZZ?=
 =?us-ascii?Q?xKOchJpitGMz874cwPD5BHAKEieZqYCcLAdJWI1ABX2ng1M3MYlsVgYO9zgZ?=
 =?us-ascii?Q?jDcFqcylE7NYHxTni3ccygYpJz8sKW4KMAFjVXqg0rsc3NmReT/twhH0jNsO?=
 =?us-ascii?Q?5bZLoyIUUUS/6XSwcqO4xANe8Ii68m/eFpR6hZhskkqz8J6EEp7al0lIHt8P?=
 =?us-ascii?Q?1FcykwsNcekh+FK8g4xlypX6+VB4+nz3vUfTj2Ykf3ROU8IQz1JoruuLnYr8?=
 =?us-ascii?Q?foxf9wWpH32cIbrSaGU0XxL0yHLE/Ctxpqb2uMEI5Uk9dD5rZMH2+9NkxTlX?=
 =?us-ascii?Q?YZm3XO39E4dhaoioMxTMGMrnyNHvW5R6BI58h0Nx/M9YsU6TZQUfK4feodya?=
 =?us-ascii?Q?pfMKEYdSEt9nIyVamj9J2+o8S0Y/h4xqO9ERSMzd6y5U/MyEdFrLCEa9J1RZ?=
 =?us-ascii?Q?YxmbPonqWLoNrSeBTpJamZE41P/cuYLllcvgZYR8XvfEkFj5gOqLqR4toiNo?=
 =?us-ascii?Q?Nbm2ASr8zoXccPOapb3iPSE6v/3AuBMsw25Ea6Nys0+FBn/WFcyWxwLPdyPw?=
 =?us-ascii?Q?UEG4pyup/hioXgvgpwT3xDH8SIJIm3I=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 662fd7e8-481c-477f-6e76-08da1308e2ca
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2022 11:23:31.3648
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wNJQAQsnZbCEcqFTsNJVkbhhitAm3kY3JLvb5InJ82rkAkrC/aPAVoSF5Q33YCkP/kD0PCp4VqF7xBC8S0Ogxb0e4v3wsV17q7PUVarN+GQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4580
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-03-31_04:2022-03-30,2022-03-31 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 spamscore=0 mlxscore=0 phishscore=0 malwarescore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203310063
X-Proofpoint-ORIG-GUID: kOJQO7ylW5Uj6OueJc6UWgaoC475B9BZ
X-Proofpoint-GUID: kOJQO7ylW5Uj6OueJc6UWgaoC475B9BZ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 31, 2022 at 06:58:16PM +0800, xkernel.wang@foxmail.com wrote:
> +free_xmit_extbuf:
> +	pxmitbuf = (struct xmit_buf *)pxmitpriv->pxmit_extbuf;
> +	while (i-- > 0) {
> +		rtw_os_xmit_resource_free(padapter, pxmitbuf, (max_xmit_extbuf_size + XMITBUF_ALIGN_SZ));
> +		pxmitbuf++;
> +	}
> +	vfree(pxmitpriv->pallocated_xmit_extbuf);
> +	i = NR_XMITBUFF;
> +free_xmitbuf:
> +	pxmitbuf = (struct xmit_buf *)pxmitpriv->pxmitbuf;
> +	while (i-- > 0) {
> +		rtw_os_xmit_resource_free(padapter, pxmitbuf, (MAX_XMITBUF_SZ + XMITBUF_ALIGN_SZ));
> +		pxmitbuf++;
> +	}

This works...  Presumably, it applies to staging-next even though it
doesn't apply to linux-next.  So:

Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>

In an ideal world, pxmitpriv->pxmitbuf would be declared as an array of
struct instead of an array of u8.  That would make it much simpler
because we could do

free_xmit_extbuf:
	while (--i >= 0)
		rtw_os_xmit_resource_free(pxmitpriv->pxmit_extbuf[i]);
	vfree(pxmitpriv->pxmit_extbuf);
	i = NR_XMITBUFF;
free_xmitbuf:
	while (--i >= 0)
		rtw_os_xmit_resource_free(pxmitpriv->pxmitbuf[i]);

regards,
dan carpenter

