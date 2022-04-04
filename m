Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 873EA4F158D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 15:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349714AbiDDNLa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 09:11:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349446AbiDDNL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 09:11:26 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 372A89FCE
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 06:09:29 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 234ATxeu012558;
        Mon, 4 Apr 2022 13:09:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=loHCxqXH0ogFmuV50HpyOA9Xsq4B9sLAD0/EptvEz+U=;
 b=AW8WJ9T98wCTVYuye0/uRw7mI9a4NSK8/XBkSVCz+DaXVBjVWBivusk6n8pNoHx43UQX
 jiSXzxLpjgtumP8C4q8692y4HasjodEyXyhdDU1Ir1h1Wdrr8fKNUT6/wQWu3JsIsiwI
 zdqiz1OYKjV6BLmih2qkbztyK+FmO0ymgklt5HIy5pAZrDnHvu27CW11RPWokBgH/h9a
 CnlDucNROkGu9QbAtzeyBBOJIfBXpvnOveoE5pbxgYe/tucgN0A+IK58YB8pPz5J61Ie
 f+SePa+c9NdR9se8FCAtTj3ci2vi0zjVOHAOp7M4uyT227yZjYQD6+T0nzdA8BCSXY/Y Ug== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6cwcb3qw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Apr 2022 13:09:20 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 234D6cn9002327;
        Mon, 4 Apr 2022 13:09:19 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2047.outbound.protection.outlook.com [104.47.56.47])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3f6cx2d8d5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Apr 2022 13:09:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZuwIuKBQYwyw4aBYbmUl6kirH1sbBHCS3BJs05y5w60vA7tPUYaJhJhLLppNQXn1o9HSh3/D3ptdACp7tzw9B7UCxXVj3sO3Q82ZXgZZJ5bYEkxX3F21r5K6cu52QgYpb+zUXFzWrB7inAgF6oN6qtuIwwciE51M3S4yt9fnIikHmF38f2wIgX1RJlFlGSkt2ZZxj/HLCfskNbGo9zuDPOURfF9gL4QGQamqxy99jFX8F/WCVIgU95ckmF99tGX+QtLrE+sdPkPyt5szXm/Rxf5zhKcTr8IraagP+uuigs7sMI5K2ktLiDtThKZSwTT2oyE8DCZbJAnUIPvnGExfmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=loHCxqXH0ogFmuV50HpyOA9Xsq4B9sLAD0/EptvEz+U=;
 b=dDcw9/gGn/sFRaBaMYaMiySQxHdTf3mttKM4g2BihSrM8piMeTKYT90u3I3FVncEC/UvfneOxbklVngxEa+bZCmNNry+MUW9JwUOsNTC3b2FevO8E9vkqyBNlzRdcEXe8hUadqKNSICE7jgkq70b0kL2GwRdOMdHlX21LSSLgRFwL3yz4FSkwhtDRExOsVopZiKBwrlvX0OIA7rDIPzT3px5pjaYdtur26miY35uZQi47Z2bvO5N3m+xKqONX33QVuZa1vNJD6fOu64jL2gc/mRAYXZI/FPbzUMbQKqIWpO2U+Ji3ipwPJ8ip2gfyiUuKw4miIn2TCL5kup/KLQZwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=loHCxqXH0ogFmuV50HpyOA9Xsq4B9sLAD0/EptvEz+U=;
 b=q7wtwfE+UKWQzZU8YRX3An3t904SFqmQx8eIUx+M4p/uIQis0u/Iuzv5zMQw/WPYUe3sf91H+RN7kJ9IhMZVG/7Z3m7VpYM+Atp11bfJzkXWUPB2fXIkfUzCZv4TGesxkDqcLyG1WSEB85My5aBH4wDKldbUNCNVJzZPQRMcScg=
Received: from CY4PR1001MB2358.namprd10.prod.outlook.com
 (2603:10b6:910:4a::32) by SA2PR10MB4665.namprd10.prod.outlook.com
 (2603:10b6:806:fb::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 13:09:17 +0000
Received: from CY4PR1001MB2358.namprd10.prod.outlook.com
 ([fe80::ddcf:9371:2380:d00f]) by CY4PR1001MB2358.namprd10.prod.outlook.com
 ([fe80::ddcf:9371:2380:d00f%7]) with mapi id 15.20.5123.030; Mon, 4 Apr 2022
 13:09:17 +0000
Date:   Mon, 4 Apr 2022 16:08:54 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Michael Straube <straube.linux@gmail.com>
Cc:     gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: r8188eu: remove unncessary ternary operator
Message-ID: <20220404130854.GB3293@kadam>
References: <20220402173835.7560-1-straube.linux@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220402173835.7560-1-straube.linux@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0050.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4e::10)
 To CY4PR1001MB2358.namprd10.prod.outlook.com (2603:10b6:910:4a::32)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3309f857-2ab9-4ea5-f546-08da163c52b8
X-MS-TrafficTypeDiagnostic: SA2PR10MB4665:EE_
X-Microsoft-Antispam-PRVS: <SA2PR10MB46652A79EF3BCE216E3C33B18EE59@SA2PR10MB4665.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MhB7av/Bj9rLcKRvozH9SmsKKVub+jfhVKwTtS4ZR9R4IjqMozaUK9TIZx6S/Rlv5edppi2cF/GaEmagX7PhS6TLqYbkNoOxI8PgouhvJCMwkQpRGkABUX575pOTAKjFR+4yZyEOse4GbVErvfyDbFBTGMOR9XfKGr8uGg6uMrbBnsgdGiupJWdzPnLPFS7ulsD9bndMbBPHPeEiutGlK+62W2VaWRP883jFQctCvETwjlMxJhRoSVn7P3pGfMIQAzc6mzFsYEb3uqInsZ6FarhT0lpgicPx6LLMt1Xbh10FgufSdnAR1oo4uIPJ9Dg/E8tO/JLpu3KmRFmZdOpBNLA+WgUFuk/FxcwL+uUVwtsEdn+dp3TPW5f1ow2BoaVU0c7m0PP+dldV3KDv3MMyfl2NloiwW0WQTzFY5z9UZqfSL41qUStZI3xpmbf94XoaLg9IkaVsDe7aWxk5oOjyROvaBZ89Js1ZEnBmtiFnY2ZWnhr3z3Wtj23evekf/IYln0+KDfOtIz7Skb1GXjBEzJw9ElNgnGBhENJjX2Ih4VwrFyj/CXnY0sPk1i99Y+dpNoNjtUr+zVfypeBRZp5j7FBLnKQA6TdGbAZ/8wk99D2HpP6TIk5Ri2b2PZ/Udzt1tMZ7YP3X3ZP55mo6n1otnJeHHqk9vkBGwcvWkRzGNDrYnq2799n9i7ZUCDZ+DsAo1RyJaZrt5TLGeqHSYWyD3g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1001MB2358.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(8936002)(508600001)(2906002)(6486002)(86362001)(33656002)(9686003)(52116002)(6506007)(6666004)(6512007)(44832011)(5660300002)(38100700002)(38350700002)(1076003)(26005)(186003)(33716001)(316002)(66556008)(8676002)(66946007)(66476007)(6916009)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZcmBWQTstDQJy/vul17b2cWUCzs0AP6RGYt1rE20zNn5fvh3lT3Y9sHDENKw?=
 =?us-ascii?Q?nzqS4VKTcZfTUPn068sD9YAJ9YHRhP+iYrhkgyvNy7d94lOeHuzgE4rynW6c?=
 =?us-ascii?Q?FGbgAZaEHoEFnjj582dlfF2hZUhpSpoP1Ei/OPLcOG6FyY64mlhv7vYEGdAB?=
 =?us-ascii?Q?5oSjg3fWQlDnZFs7VT24Lx57YzpxbKBFNtBiA8mmZ2QqJkjeKZZj13FUUUoc?=
 =?us-ascii?Q?/Fp8vqvMRurrCVaWIy3aFipk8u036vmz4JZCfzne29Cvb+1Qscpw2irgarI0?=
 =?us-ascii?Q?yvjub79YmyDgeiX68r9CmYqk1jDQCLwLibdnEsBNLjtyktuD4caCU/6JlRhs?=
 =?us-ascii?Q?67r/WKJJ2EPrpSjfYn0QiR3w2URRpzagngnVPFY8a00NUVX++FsNatXiYaXF?=
 =?us-ascii?Q?rD/BInl96+0QGdi2xYlbn4SQglYIVbVUBMOZ7ewT7v7FSNGvIBa2E5f0UKoV?=
 =?us-ascii?Q?9MzjfRisxRBAizm03nJbCXe63DFHJYkSO9qzpZFhmiDHc6RXA5cuQpCuRBhE?=
 =?us-ascii?Q?OAdTMSSu9qB7PcVcYvcTz+JGN/OGmiE0skxzCvjGlK+5JbDbt8EwG+W6JxXo?=
 =?us-ascii?Q?UzJtFNPfK/HweZ8q4yTlmJqiCLg55cJfQPJ+uN2WhvaLEzQ/FFBvXNXY1DGG?=
 =?us-ascii?Q?orLLhKsqbdv4Nz6z7V+0O+DKIgV3U6SqOPKeUq9xiqsTRmswOkXk0XwXstTG?=
 =?us-ascii?Q?OooO9WKlheBpWNc1ETODIGlbfKvU24uhXkKKFJJxsxb5waHplX2BV/q41sVO?=
 =?us-ascii?Q?Rm+tg1e9p3GsGDXek0HejAxhQOQ5nEHTZfOr9J6osD1Vjanj0zI0F8Xtvk+t?=
 =?us-ascii?Q?wmgWepGAteicwpoO/fTMRnbEE/JlCF1H6e9EDM5Rkdbt0j8SStYsBFOr73oA?=
 =?us-ascii?Q?+iL7gHeXyDA47McFQurK+B3f+POe2W+qD40meIWFX3kPUbs+4zgsmXpcv9hp?=
 =?us-ascii?Q?kc5ujZY6sZmPE09CCjHmflreaV69btXKlStndum3OYOlqQJWndCfbfGOqexh?=
 =?us-ascii?Q?zLXtA9N4zpR3J015D2AxkjV7DdGf9y/nokLT/vHp71epM8z/zewjQYilOVlm?=
 =?us-ascii?Q?sxaJgQq/FKDJSDavslIaiyrslXzLGRTVnnKQm/wS03KCuEGFfkQ5Zs55tXV0?=
 =?us-ascii?Q?0WSxvYlNKvOsQbncOuxjvKGsIe/AT3jWbuA/XD53FiMw934LmmFCFJqsVlKT?=
 =?us-ascii?Q?4qs8cHOM1955aQslyjNhWTL2yUoFzrArXpPMnTRpSuc5jYLX51CrKonCNzx/?=
 =?us-ascii?Q?oWgAmRbU2py9cNhQpWXBKW1ibBMZyuSHngWASHj6XdMfLC8FeFSJlp/RuGE1?=
 =?us-ascii?Q?drWNuNdIYOpIObbc88K7E8cWFHBWfZrRqMpMqgB3VPjKG0cvAV9LLQJMIzm4?=
 =?us-ascii?Q?YGLKMuwkxWBKT63DD4RwLmr1ZvNSejzE7v6n838FAIoX2b9f2SzA1vgVi44d?=
 =?us-ascii?Q?Fxxm4QLfZOiWRsfs7xvguNPPC/2hx55dsmvf8tMGv5tJTkniXHuD0mXJ5NHK?=
 =?us-ascii?Q?jgaZTU4uKRf2w7dKYBHmxKkv4hQaOJG7UNmsyDXSUDyMz1ael6eIVtNdqhGq?=
 =?us-ascii?Q?momfwDyK6VMJnUJ9Xg+HN8U9sRfNBj2SxfWPccANt9zfoJGTGVziHfa+CKnH?=
 =?us-ascii?Q?ZW9Lm+pft1VxgQMlp5o4ma8n++I32aj2Bt6kfARQVSbKifTNHj4TOeHd7RAV?=
 =?us-ascii?Q?86K8S5LGMe7QHL6MXy+QJDIL07x4zYv58cf8M/nzS+k4LPG5ftkZZxJbf4Dr?=
 =?us-ascii?Q?mOFWn1DnmCaCvATOAg26Uq0PyUjGRCE=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3309f857-2ab9-4ea5-f546-08da163c52b8
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1001MB2358.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2022 13:09:17.3985
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fLhH9XnjfNE0fWkBTJEKgahWl8m0qREw+kP0aRypmW6GixPdh7+tRjDcniHRITUj2SVy3RP7TRcOAeJi3xL+UROKaDKGy9T2fCaE48C1Qn4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4665
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-04_05:2022-03-30,2022-04-04 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 adultscore=0
 bulkscore=0 mlxlogscore=999 phishscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204040075
X-Proofpoint-ORIG-GUID: ZG3rVk71ChNakfHKx9mCYw_cK_Z-EUwS
X-Proofpoint-GUID: ZG3rVk71ChNakfHKx9mCYw_cK_Z-EUwS
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 02, 2022 at 07:38:35PM +0200, Michael Straube wrote:
> diff --git a/drivers/staging/r8188eu/hal/rtl8188e_cmd.c b/drivers/staging/r8188eu/hal/rtl8188e_cmd.c
> index 45b788212628..18650cd96f09 100644
> --- a/drivers/staging/r8188eu/hal/rtl8188e_cmd.c
> +++ b/drivers/staging/r8188eu/hal/rtl8188e_cmd.c
> @@ -137,7 +137,7 @@ void rtl8188e_Add_RateATid(struct adapter *pAdapter, u32 bitmap, u8 arg, u8 rssi
>  
>  	bitmap |= ((raid << 28) & 0xf0000000);
>  
> -	short_gi_rate = (arg & BIT(5)) ? true : false;
> +	short_gi_rate = arg & BIT(5);
>  

This is a bug.  Valid values of short_gi_rate are 0 and 1 but this sets
it to BIT(5) so it will break odm_RateUp_8188E() which tests for:

	else if ((pRaInfo->SGIEnable) != 1)

>  	raid = (bitmap >> 28) & 0x0f;
>  
> diff --git a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
> index 6811be95da9a..ffc82d17ddbe 100644
> --- a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
> +++ b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
> @@ -747,7 +747,7 @@ void Hal_ReadPowerSavingMode88E(struct adapter *padapter, u8 *hwinfo, bool AutoL
>  
>  		/*  decide hw if support remote wakeup function */
>  		/*  if hw supported, 8051 (SIE) will generate WeakUP signal(D+/D- toggle) when autoresume */
> -		padapter->pwrctrlpriv.bSupportRemoteWakeup = (hwinfo[EEPROM_USB_OPTIONAL_FUNCTION0] & BIT(1)) ? true : false;
> +		padapter->pwrctrlpriv.bSupportRemoteWakeup = hwinfo[EEPROM_USB_OPTIONAL_FUNCTION0] & BIT(1);

I have not looked at this one to see if has a similar issue...  I don't
necessarily want to audit all of these.  I guess I will, but could you
do it first and then I will check?

> diff --git a/drivers/staging/r8188eu/include/ieee80211.h b/drivers/staging/r8188eu/include/ieee80211.h
> index 8c20363cdd31..03d63257797a 100644
> --- a/drivers/staging/r8188eu/include/ieee80211.h
> +++ b/drivers/staging/r8188eu/include/ieee80211.h
> @@ -127,7 +127,7 @@ enum NETWORK_TYPE {
>  	 (WIRELESS_11B | WIRELESS_11G | WIRELESS_11_24N)
>  
>  #define IsSupported24G(NetType)					\
> -	((NetType) & SUPPORTED_24G_NETTYPE_MSK ? true : false)
> +	((NetType) & SUPPORTED_24G_NETTYPE_MSK)

This too.

>  
>  #define IsEnableHWCCK(NetType)					\
>  	IsSupported24G(NetType)
> @@ -135,11 +135,11 @@ enum NETWORK_TYPE {
>  #define IsSupportedRxCCK(NetType) IsEnableHWCCK(NetType)
>  
>  #define IsSupportedTxCCK(NetType)				\
> -	((NetType) & (WIRELESS_11B) ? true : false)
> +	((NetType) & WIRELESS_11B)
>  #define IsSupportedTxOFDM(NetType)				\
> -	((NetType) & (WIRELESS_11G) ? true : false)
> +	((NetType) & WIRELESS_11G)
>  #define IsSupportedTxMCS(NetType)				\
> -	((NetType) & (WIRELESS_11_24N) ? true : false)
> +	((NetType) & WIRELESS_11_24N)
>  

And this.

regards,
dan carpenter

