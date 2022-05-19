Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9203E52CB48
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 06:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233825AbiESEsO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 00:48:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233797AbiESEsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 00:48:08 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40F58692A0
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 21:48:07 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24IMIqPu007842;
        Thu, 19 May 2022 04:48:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=jp/rUsdUlWu0+huSJGY6EcYYr6duPLOYr/hP2Eb7YYw=;
 b=wBkLHIkePfWXOWa13tnw4rOozJGfa/ox6sP9IfOq2pjJdjapMVxUWoueXLssgU8VlT04
 dAWc6DzJufXq4MgVy2ArpOGuTg4SBuzJ8eYDmcY/qhUHlA70g05HRzhxOix4GxZa5pqM
 chu6x3KuaAuP+I4FpSXbcQ+Yl7mLlqvGinR2NFhKkB9B8xHWo2hddJphzadK5O/kaO5B
 W8tRzun+ohdTsTfh4Ag4Aao7hKznIcyOJrtgB2uV+2QBHJkL4/xV1BzYTcop/iqtRLeB
 ks1d15IKHEHgi8CyzVuMLudU8YoFpUm78e/v2gTY7EgcAgHpZdWmb+sdb5HCjLgPy3tN Ug== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g22ucatxw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 May 2022 04:48:00 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24J4e1L3012367;
        Thu, 19 May 2022 04:47:59 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2106.outbound.protection.outlook.com [104.47.70.106])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3g22vadp8x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 May 2022 04:47:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hX01ToFE/YryKr6f4XGN09vcGT2ZK08zLo1jblS3PYkjPzW6kTYGTYWAalwYcLs+t6dMwpL/dtNxJD/lGxzXVpx0VCQOeKFZyLQ9U7qcgJkija5LvfNBPcGXXLgrbfZ/HwYzrg60IYcheTIe9Flwi5VD1YDPv/CinooCIpGu/rXhI5c5eKBy8G4csEF7jCl8Zw2mpA6lsputFYgB5kXMazhqqtWtnrF3QKc7U+hGn00DH2Y/9iOFaxQe9TAJcXqWQa8UmLraS3m1S6HEhFwMoGFnz4UrTGHdQtg1ndqMQrKMPGxGYxrHDR2cxYVhY+YWTPGT13OkvkH7wXiAk23lwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jp/rUsdUlWu0+huSJGY6EcYYr6duPLOYr/hP2Eb7YYw=;
 b=Ij91Ico67xPzDlKDNoLXhM56zGMQoTLU81VS6XyCq/gFsl8mTrkEeTaVb8+Vk7T1jluYj1OgqTc+bx5R9EfL3fTbvsoQYJE0jNzwU61ivCB2VwrU4j19PbQXfnMLNbybOm8PZRsuHA408xIrDTIZl1m7KS13HvOg4qz5t3L9JOXQNbkK9xEuAGRNGWlgQED6DGWksUrJOiu6ZQP2OB7JsP8VTlUa4kymygPkdtEEs6J0f591n0KoQ7Yx+KgAux78vpTRxxlFOmZqj73j3UwLnbUO3NKhgJufvRJlDdogdS8LGLMmd6WXetg/A9/Q/MzFielj9uLQIrxbaRyt7vh4Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jp/rUsdUlWu0+huSJGY6EcYYr6duPLOYr/hP2Eb7YYw=;
 b=wdzvP6+IQKK6PPUzmFz3150fdla4QH+505hdCirCdVaKKneXn0OdMjTOqanFEvenUTGRhD0k1G0ukLqULrnUP6DzNNnY1y0l/UkCulW4xeUD+x/EKPjXOKNZMJCx4hFzfs4SCn3y2hUxEsvTtQoC8JsZMoVoiDoLa11YkdNvrsU=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CY4PR1001MB2149.namprd10.prod.outlook.com
 (2603:10b6:910:41::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14; Thu, 19 May
 2022 04:47:57 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::86f:81ba:9951:5a7e]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::86f:81ba:9951:5a7e%2]) with mapi id 15.20.5273.014; Thu, 19 May 2022
 04:47:57 +0000
Date:   Thu, 19 May 2022 07:47:43 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Pavel Skripkin <paskripkin@gmail.com>
Cc:     gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, straube.linux@gmail.com,
        fmdefrancesco@gmail.com, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: Re: [PATCH 2/4] staging: r8188eu: add error handling of rtw_read16
Message-ID: <20220519044743.GT4009@kadam>
References: <cover.1652911343.git.paskripkin@gmail.com>
 <fae229ad24be682407c85fb25ea1ce4d79d83fcd.1652911343.git.paskripkin@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fae229ad24be682407c85fb25ea1ce4d79d83fcd.1652911343.git.paskripkin@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MR2P264CA0109.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:33::25) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b2a0a129-94ca-402e-9cfc-08da3952be97
X-MS-TrafficTypeDiagnostic: CY4PR1001MB2149:EE_
X-Microsoft-Antispam-PRVS: <CY4PR1001MB2149EB3027103FB6732F30678ED09@CY4PR1001MB2149.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mOQmNCft7oojuzD3KX24mbA23yd3oA5piQbdTC5q2Qa7v1W87wz4WMwx7wTEsVwY4uFFOBNEcQAfyi03nuLFtWir07VovY44kRJCnSr6Gre67b8J9Nra0rnTh2SheWnwZqi7NiP5CDBPdxEhtrotodvPlHjfT7VNj8qQhP/XotCQz7EGP/sdJU5rGQEsiRhKKKb46TaGLD+zRmA39ONBfJj/yFwz03kFvkAS6Pel+lyjTqVyoqnne91FDqw2fdW1+1weq80MP9dLV6bdi16wFyhx1GG/JDw7aeKPCW5q6/fQTgMfkBvG6f4iQ6Iov25vkC5xsASyiVnVI27FKtENjaO6eSo1GhBkatwINAhWb2xjTuRY5NOpmbXKb29pdTDvCXiMFg+3avXwiNDE9K3o+c2veP37x6L8xoLvoRVLphauy+2wTL6M/nNO8J+n6hK8SHkRiU/8fMvp8yvBAoZA8M182nzj3TcStOg+h9VW3C2bOwL3FSybM7kpRHJazATPvV+q68hNMq2+Q7jg4SdytnlI6RWR9xAoBHmTgzRbQw5SJ5581tfz4y8qPuediGBKYuasN3Ygf3U/KX3i4SGNXBWZfzq+MpvyaniX/E8QLXjWYUvisruO82xt3+BV095sV+KQh5woTD0YSwzk/LuShIa2E2lU4P/lQz0JPiFHB+OlYtWeRhLRAZeuo6uEBiKxqZnHvs8AfDn3LtA6PTsUtQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(33716001)(66556008)(4326008)(66476007)(6506007)(6666004)(6916009)(5660300002)(8676002)(26005)(186003)(38100700002)(9686003)(66946007)(1076003)(38350700002)(86362001)(6512007)(508600001)(2906002)(6486002)(44832011)(8936002)(83380400001)(52116002)(316002)(33656002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PuJf5rimg5s8S959C9dmeasVrlUCJQPNFI/WwwQlO7KuRdYsySMrZnFgCnI6?=
 =?us-ascii?Q?z/5ikm6x0OoQXZiV0az1sc639duXofF7Te9zQOcHuqcT78+qIuiZymw0QXmb?=
 =?us-ascii?Q?iMk4RqlPLRb1NQzOrZ9mdN6kLPEW60yJlyjSi007T3NKQaL5/b33mAyhpS2N?=
 =?us-ascii?Q?yTn8sY8El0kHC7VqZRl/AxrF/IvAQJeg6LQd7iuRS/MNnUf2f4VpzJ2oYr/G?=
 =?us-ascii?Q?UqJfiwkfxA7WBvOPSJf56j7QQYz2/eTpQWBAgg3TL9MoS8DSoAJ84T6iACO7?=
 =?us-ascii?Q?nUYwwqaftJ5b0xYullfUXFyiD6Z2piSHov+vV5DrJqG1uGofIzXuSuM6QSAe?=
 =?us-ascii?Q?Ueo5T9Nzp12T3eygT++VNMmoO/Vm2tIEs/v1H1WkE7dUXgTGEXfIxg6z1dZR?=
 =?us-ascii?Q?p5sjLeWKiWFdp20g6I0iWZK+WmWM5DtJCq8hQCWDRKbjFWXPwvHchPMPEgil?=
 =?us-ascii?Q?OKXZPLPY+jpOOcKgJ2G/CP+qsR3zIaHBGXWETck+jFnGCDfcP9wzgp9kb6u8?=
 =?us-ascii?Q?3sUOmYjHRowYUtwvIQGEq0QgyzqQ+4T789o2NfraEqJm495cW625bObm6bHf?=
 =?us-ascii?Q?J6+9GVa4yYTd/GzTd4OmrKzDFbpgcWszWOUoQ3dNx/D+hHt1VkIApQzUa9FF?=
 =?us-ascii?Q?a7ocfsir86+oD9yBznvclhiHu4IAqzw7+Gum2EX/K/5za69zVyAveW2Q5q0b?=
 =?us-ascii?Q?dZlgPWWzPf4iHNLIbZ3jO8/KGLgBAmtc47yUZ6W4jKtVJQy0Kz/eAVi2DGf4?=
 =?us-ascii?Q?Dv9l0WtDInqrgpmLMorZehQSQ1y2kmwR+V5vXpAmcOf+4O/+3UFwbg8FdWcU?=
 =?us-ascii?Q?mbtanbcW8AQ3j6Ww7mL3s95gXAS+uvFjbs2UTpo3solVhvXSqL6lKDZ5P/ia?=
 =?us-ascii?Q?HG5CIrKvyH7ZgmYhw1h2YzfjeiJ/UOH6PDVznj0S+WeL1sD07xnviwidW5te?=
 =?us-ascii?Q?HeRf4+6E4issdmBUwqoEsR7uurYLa8JlLSVMR+ws+XxSLV4qoce4DccINbNN?=
 =?us-ascii?Q?dtw8QnSK7cwe4dgUWAStM0vjDc//Fmz3D8st63y8yTnXaruaI6PiTp2L9aEj?=
 =?us-ascii?Q?Xdg7GVI4gORwF1BfHU6j/bgXitVLRJQeEZvsGYrcJExMUbM8CWYsMgXfD2hv?=
 =?us-ascii?Q?7Ai4XWkbe4DKNSayG44BnzmPaH8nEMpkFawO1hzKBIwUnVJRRaxWUOsLQizb?=
 =?us-ascii?Q?q8hOgDSgG8+1d/MnpTOl04BffzHRhhJrau1JoCZsk58AY5xVNiD10U37e261?=
 =?us-ascii?Q?clAVwyh4X0l8chgW00xspnnYKdWNRSAGhwvuyIvaUqCh9VB08RAAOb1bj1jv?=
 =?us-ascii?Q?M1T1VdnSzEXTKOCj2EswSPXLM5ORMorTzBcLwkVGtXI0wr0C5EU8qpZ73yGo?=
 =?us-ascii?Q?9IYD58vH4vi6d8WijvPZ2FaU8wSMnCyMHzRCjG+UYNm1r6zvz4zsTSu7wUF2?=
 =?us-ascii?Q?ZqyE0mQgQLTo52tjSVDejLOnuJE/H++4L4LqWUclo43l3XG0pbbiLYWKPXlg?=
 =?us-ascii?Q?wY7DB4aC6bbkkq2HkcF3WhYt0zDjRs1BuKywekzxrMyoiDb0grwMk5WIKo0W?=
 =?us-ascii?Q?MhWDmgirOtsdPJbl0pYvwD7rNZaXsERXkkaA4R8kXz6TyLBRsww79zySua0/?=
 =?us-ascii?Q?5c6kLGkUkC6G7xRxL/fALd6I/H5u8U3G8EK5s103dcFoMx+cmhLIOvOxLxvk?=
 =?us-ascii?Q?CjyQPdzacKY8R2TK0UWJjDmgBS8GF2GsEDnhvFVQ6xbmyTU2mdwq7/GkVUFC?=
 =?us-ascii?Q?o0SM+3dmYyds3+N4vEn2KC7+wKQTpxo=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2a0a129-94ca-402e-9cfc-08da3952be97
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2022 04:47:57.5930
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QdmQe571GQtXRSHc+uqR0BWiGG89UPp/Za0h4/YuRI+WP4dX5sl5iVdd8I8Dy+/DucwBWLRHYs9BTOGWv/nRmA1f1Vkg1mwIWmNGdPrFsu4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1001MB2149
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.874
 definitions=2022-05-18_09:2022-05-17,2022-05-18 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 mlxscore=0
 phishscore=0 suspectscore=0 mlxlogscore=851 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205190029
X-Proofpoint-GUID: Kfs1dEu2uuhuEdHQ-SQ8jdGkwX66lfah
X-Proofpoint-ORIG-GUID: Kfs1dEu2uuhuEdHQ-SQ8jdGkwX66lfah
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 19, 2022 at 01:11:56AM +0300, Pavel Skripkin wrote:
> diff --git a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
> index e67ecbd1ba79..22661c66cc18 100644
> --- a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
> +++ b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
> @@ -249,11 +249,14 @@ static void efuse_read_phymap_from_txpktbuf(
>  		hi32 = cpu_to_le32(rtw_read32(adapter, REG_PKTBUF_DBG_DATA_H));
>  
>  		if (i == 0) {
> +			int res;
> +			u16 reg;
>  			/* Although lenc is only used in a debug statement,

Blank line after declarations.

I think it's better to put "int res" declarations at the start of the
function.  That's where people will expect to see it.

>  			 * do not remove it as the rtw_read16() call consumes
>  			 * 2 bytes from the EEPROM source.
>  			 */
> -			rtw_read16(adapter, REG_PKTBUF_DBG_DATA_L);
> +			res = rtw_read16(adapter, REG_PKTBUF_DBG_DATA_L, &reg);
> +			(void) res;
>  
>  			len = le32_to_cpu(lo32) & 0x0000ffff;
>  

[ snip ]

> diff --git a/drivers/staging/r8188eu/include/rtw_io.h b/drivers/staging/r8188eu/include/rtw_io.h
> index 1198d3850a6d..ce3369e33d66 100644
> --- a/drivers/staging/r8188eu/include/rtw_io.h
> +++ b/drivers/staging/r8188eu/include/rtw_io.h
> @@ -221,7 +221,7 @@ void _rtw_attrib_read(struct adapter *adapter, u32 addr, u32 cnt, u8 *pmem);
>  void _rtw_attrib_write(struct adapter *adapter, u32 addr, u32 cnt, u8 *pmem);
>  
>  int __must_check rtw_read8(struct adapter *adapter, u32 addr, u8 *data);
> -u16 rtw_read16(struct adapter *adapter, u32 addr);
> +int __must_check rtw_read16(struct adapter *adapter, u32 addr, u16 *data);
>  u32 rtw_read32(struct adapter *adapter, u32 addr);
>  void _rtw_read_mem(struct adapter *adapter, u32 addr, u32 cnt, u8 *pmem);
>  u32 rtw_read_port(struct adapter *adapter, u8 *pmem);
> diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
> index 66aac2cbe3a9..1b35951a53cb 100644
> --- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
> +++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
> @@ -1919,7 +1919,10 @@ static int rtw_wx_read32(struct net_device *dev,
>  		sprintf(extra, "0x%02X", data32 & 0xff);
>  		break;
>  	case 2:
> -		data32 = rtw_read16(padapter, addr);
> +		ret = rtw_read16(padapter, addr, (u16 *) &data32);

Checkpatch.

I have an unpublished Smatch warning for casts like this.  You can't
pass a data32 pointer to something which is takes a u16 pointer and
expect it to work.  The last two bytes are uninitialized.

And even if you zero out the bytes, it is a bug on big endian systems.

> +		if (ret)
> +			goto err_free_ptmp;
> +
>  		sprintf(extra, "0x%04X", data32);
>  		break;
>  	case 4:

regards,
dan carpenter
