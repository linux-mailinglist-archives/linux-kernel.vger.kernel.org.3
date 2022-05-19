Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7531552CB22
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 06:33:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233673AbiESEdt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 00:33:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbiESEdo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 00:33:44 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6924554698
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 21:33:40 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24IMJ4AR009140;
        Thu, 19 May 2022 04:33:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=tcRxtryA2ktvfVJymG73efUJGBj9XRQIj50Hmk+3EU4=;
 b=N9b9IefP+YPSTpCtV7WGshajwhbsZyps0v1kDJFqomV73ocfKCobnJPaG3QvvknHA46u
 +kz/65ukOahR3LnBK9ut8wOulpcy6kFYcRAYBP/MjgCuKsNvBVjRjdyZ/un0MiDPRzeu
 70fRxywURL/HMzzYCm4MHRxd9C2g5yjlNCR44Kf4PxOQLSmgJ1ZaNmEBbZNGxfopqazl
 /ystbJ3n14EysS5gjLPdx0tAzxwG8M62VP/0dcerni1kLZP/ayDezqWvtEpOkBDgWNpH
 II+0WX9wtMPie3MaC4wVQZx86yDLd7CHN5vJ0Hju7VUOuT+QmzDspzPJ9+FfiDyB7B8q 3Q== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g2310u41j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 May 2022 04:33:32 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24J4V5Sm026534;
        Thu, 19 May 2022 04:33:31 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2045.outbound.protection.outlook.com [104.47.57.45])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3g22v4vqns-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 May 2022 04:33:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bHC+JSwJ/SE9QGa7UupaRrDEWLSDnyCTjjKIzEor9auk4GctRQ88wA4O9Vneu+m2BBncgWj6IETUhXJGIsKbnODI7CM67npc35ek7qVzOGO6trEZnjAQJkOQTed6Vu+QSeVXipQDDqjp91T/xrwA4tyJCz3nKoVPMrz9DpstnJ81jUqZmNmdbirOC0jblE5Cit2+1g2stX1QGHMzyQzrLkt2zlJYdOIUZfGoEszZrPOlMBwNOOsRDQj5b/MY2lEw5rgLqC2iRriNTc7vDcsYY6mtmZvxMzQZyKogbiVLqZAJe6yAZdqg+XeUQwYgNp/gzc2Y29LSRjCsGET+2Uk2pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tcRxtryA2ktvfVJymG73efUJGBj9XRQIj50Hmk+3EU4=;
 b=Ai1EqSTJrZnAg6jcFQgoOKq0O3fvNip1+ctLuUeFBD6zKl4HZuQEK/qVDpY1wbsRe6xRLhSdXWiMbqIAbO+/QHjMTjOkuECC6KhCfKaPqAareV0TaC4Hu7zrY9l2mp7/iJje3sQKw4l6kqGnb/bb8UB0YOF4MAsqfyelN9Lp4FrDOlZV0aKDGot3EKWjzqXd0uHK4cUQZR55n779Cuxv91zIJLyUSXwN/jlg/G6jLPb5ysrAXEpA9Sk2wNOdbK6gqFIS9xe6Vcsz405LTa5T6XhvP78Z1r5eZ6gEb2ZAZPrQGwDjojtHa1EBrUJ8G94DCN9S44V/S22BjI1JoWjZSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tcRxtryA2ktvfVJymG73efUJGBj9XRQIj50Hmk+3EU4=;
 b=bnUYtTCOSzNKH2wV9hGu+CVRHi6xrjvLm/2fEPChyuzpsmuvaHZfDCLAiCMqyF6iNdToltnwaIpyyYzlgmpIc4c0qYLkzxHSNQIm+m4zQDXNYuvJQ7GW54DxHza8NUrnY7ebdhTOp/DBpwfbPu3MMSPehAtjK6ZzBs8x2RT18eU=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by SJ0PR10MB4464.namprd10.prod.outlook.com
 (2603:10b6:a03:2d0::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.13; Thu, 19 May
 2022 04:33:29 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::86f:81ba:9951:5a7e]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::86f:81ba:9951:5a7e%2]) with mapi id 15.20.5273.014; Thu, 19 May 2022
 04:33:28 +0000
Date:   Thu, 19 May 2022 07:33:06 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Pavel Skripkin <paskripkin@gmail.com>
Cc:     gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, straube.linux@gmail.com,
        fmdefrancesco@gmail.com, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: Re: [PATCH 1/4] staging: r8188eu: add error handling of rtw_read8
Message-ID: <20220519043306.GS4009@kadam>
References: <cover.1652911343.git.paskripkin@gmail.com>
 <1a9834b705054dcd0b0be0d929084c44a224abaa.1652911343.git.paskripkin@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a9834b705054dcd0b0be0d929084c44a224abaa.1652911343.git.paskripkin@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0027.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:2::15)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a997ca93-31da-48e2-5f25-08da3950b887
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4464:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR10MB44649DAA39F34718B53F57E18ED09@SJ0PR10MB4464.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pk4KJLvy7pcbk397PX0donNodQbX2ywMFasuVSyn5EGDcu3/61+0TAzY4/vJ/xKZfx7+gcuTwIUTv1WvslQAStjlsp6RQZvDpHqpXsePNbTqrT+qTutQaLPPcHPmYsjUcoWEe3J52HSuL8a9kv7jbCSHW723EzMEZM6gVV7Vuhz6nyxA0Zb9mwgqZXdER390vATEvjQlrJSx24DVg6GTLhP58j0Zn0GGyAcpH4Ncui6rHmtpFMkMgw7EqYzhwNw6aw8hD4KAZh8PdDT3YG56/vE7V0TRYQH2aDxJ3j4CO+KOufoVFOY9bA8PfwGDlnzFUEj8kR7iTDT5rrrHaQnbT2FQG5OpkWQEQV8yHUkdaSXIIYcUbh4dNjUB1BUSUPRf5ktWaVoZ0n6L2aFJCK/4SMe+xN1g8LJu5hEjDHyRK2Cj9YaDVYsqLO1s+T20PBGaD3cKX4woa7xfNHgY9LJlXNk+CEQwPxF+j/V7+Qp+NEGDEoqYtBrZzJD2DOxKjb7MGH/TqfkNtutFIgTRXHpN9GXnMU80YCCjIXuogIjbkHPXq5PS9Cbis8hax8WU286gp/yol+0uI1pWcdL/TRrqhj7OzoWh0wfnNUw6Kf3u6ct8Zz+b7gXixnr4z0zVqCkIriXwbYmh1SYbRAnPpP9CuqpO6U+gqxxTINA/8DGEqgRwXzIuVzdecINaRGfqbOUen+uj9Tk8BhRE+vTD5tOkLA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(44832011)(8676002)(38100700002)(38350700002)(33656002)(4326008)(6512007)(9686003)(26005)(33716001)(186003)(66556008)(66946007)(66476007)(1076003)(83380400001)(8936002)(508600001)(6486002)(6506007)(52116002)(86362001)(316002)(5660300002)(6666004)(2906002)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3g7nbmcTI53yjDLJYadOvuypydCNP2oSUdYkneRcC1aGq1VYawRFDvmcQX02?=
 =?us-ascii?Q?7LbkbJi7zDV8wj42MfeYgXhBocKqlB7JS59k8n8WS6uPEbrjjY72Gzr0cCXy?=
 =?us-ascii?Q?lya7VmJUF6D4sWWDACh89Fe3NoSObdl4XvOL4rJupQCEMfg7/CsT1VayVQai?=
 =?us-ascii?Q?KWX5XILXfA0kp2ZEnOGEQ1Oos8pxyC4XgRKOlk4xkRs+xe4N0zFCXMfU7qTb?=
 =?us-ascii?Q?Wb0mlcAlpmTzYsS84AdaG3FA2gNADns46DSrPxTNWCwW45FeycqP1wp9G4l3?=
 =?us-ascii?Q?zOjQCjx2vUkIfiFUyIqg7QXQhU7KOTuUd4eiK/DPnbdR+SDWu92cPqrVwcxC?=
 =?us-ascii?Q?jIp6Woeawm8kihHlFlBaq4xhCqx83otpL5l9MabKthGjHHMNcgHtzApXvS+c?=
 =?us-ascii?Q?3FT46NQYlJH/8CeGUzo+05ZPeV0OFNujpzN7ArF7Uk2RhmQRmgd4RKCr6KEM?=
 =?us-ascii?Q?T1a+t4oQURHGQHktXroX3C9AEC5+6PRaJ6N7A4Z3Bi5k0V2LYP38OMPuQYH2?=
 =?us-ascii?Q?vS8BBz4nyoWxl9/UFaQWEm78y2wedDoSNCfsUf+byiXlY42JQlXDdMl6R26J?=
 =?us-ascii?Q?7/nnO9nNYmJ8EyMP8MpWrm8x0O7cuXgZTLTs8AVOBGD6BZMyIIkY6MemYQwx?=
 =?us-ascii?Q?7V2XRRTeJ9i8Q8hZTFSI4WOs98BxlBtNRzJ7N06BBI7cELtQ2A/tEBbpLBgN?=
 =?us-ascii?Q?CT5LrNyFkH6oHR/xfY5LDfbmj1g1GpdZ2U2dX5u5HkZD0UVmHtOTjEs3+QzQ?=
 =?us-ascii?Q?fPxyvHAxFrmwLwVJnEvvc7x2q4//9yZV6uHj6NLpp2KAjHDmHI77hypXPHGY?=
 =?us-ascii?Q?egdaDX5yQTTfsYzK/kOOCHFx+uqa5v3Z83Rj6JPZvxCdzCMwYCb8YJIHb9I3?=
 =?us-ascii?Q?cbwZFsdakQmlNNn0mUDHV50BLozGnrCy38YbRCTd5IG6XRV0l0Lc/gvW4oUN?=
 =?us-ascii?Q?c6tCezGMH2PQZjrtD5OdAI0O4ZSlnLXAXMN5Vr3mSqzjNdZNXGEWwbaQF1OV?=
 =?us-ascii?Q?7elQ/Q6K5iOkXMwnPgW/GPH2pbNCfbZ2iH51PQbxSxM9XLcU4qjzBScStWCw?=
 =?us-ascii?Q?LhIXkXNR0zSvksw85EbzZRZE+54rz5V9jo2X9MO7W4sIQxzYt07grSuqGIaJ?=
 =?us-ascii?Q?p/vg3D1pSeJddIkRoZ7hsTcjJ2sSw378xHR8z9cfKoOSm7RW7Z7zUeNWtpXs?=
 =?us-ascii?Q?nQvqaKpwva8BHN+bmKWobsQvlzeA+bS5BbY1tmK6f1U0BfhrktvSumAM/oM/?=
 =?us-ascii?Q?UQqkxBeoD3maSSVf0HWpoZzucxzHr3To5QYRVULbiqenHN/3fsBzcBxdfXUl?=
 =?us-ascii?Q?R32tT78loUsPyddX+5kRVnzWnn/b+vjWctHtuALj6PevhPwfmw2CKULmpuiy?=
 =?us-ascii?Q?dnBWTf4lgPSoeezM6IczGJn7yP2sGa37BTM9vXlWJ7FQVMp83HfKuMohdDUx?=
 =?us-ascii?Q?JIK51rx5yf9U2TPnIxxGf0KSNkFgbscRdpEriDpigJN04SEvlY8t0v3NSbYF?=
 =?us-ascii?Q?7jYa3nB+3VB4vynmM51hPQb5qZnZNdZ/yWhN+Qe5QYXUlWQRLiOtulOuQ6ww?=
 =?us-ascii?Q?F5Y8Id57Jfti+24VmFPjW966lz7CNRtGIt8Bp6LAepF+dnr5+bvg7d5/TCC4?=
 =?us-ascii?Q?AU1q3cxaAzBtmeDctwUIkiwdg53CH3COnFGJfWhyxqOToy+Ys4CELxMf5YPe?=
 =?us-ascii?Q?kKeDSPvGe47h4n7zHHhKqSGgYwHUYnd+NVgKfmcuHZaEssRO7g6axL8KFWcb?=
 =?us-ascii?Q?MTHIIyKdZXfh+MyuajoC4m8D+7hPEWw=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a997ca93-31da-48e2-5f25-08da3950b887
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2022 04:33:28.5673
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RWI/rPrlmUFVbI/MDmDrm3RAV1/chvcnSHzPPsMPHAhlIHNQw4YfRXeyMBzrMo54RDD0xW9r31hVNqIDFouw0nFLqZqJc0puc6pueoHx198=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4464
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.874
 definitions=2022-05-18_09:2022-05-17,2022-05-18 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205190028
X-Proofpoint-ORIG-GUID: 6BxcT479mcHjc-rqANcwtGwZkqOleSc1
X-Proofpoint-GUID: 6BxcT479mcHjc-rqANcwtGwZkqOleSc1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 19, 2022 at 01:11:51AM +0300, Pavel Skripkin wrote:
> @@ -240,12 +259,14 @@ int rtl8188e_firmware_download(struct adapter *padapter)
>  {
>  	int ret = _SUCCESS;
>  	u8 write_fw_retry = 0;
> +	u8 reg;
>  	unsigned long fwdl_timeout;
>  	struct dvobj_priv *dvobj = adapter_to_dvobj(padapter);
>  	struct device *device = dvobj_to_dev(dvobj);
>  	struct rt_firmware_hdr *fwhdr = NULL;
>  	u8 *fw_data;
>  	u32 fw_size;
> +	int res;
>  
>  	if (!dvobj->firmware.data)
>  		ret = load_firmware(&dvobj->firmware, device);
> @@ -269,7 +290,11 @@ int rtl8188e_firmware_download(struct adapter *padapter)
>  
>  	/*  Suggested by Filen. If 8051 is running in RAM code, driver should inform Fw to reset by itself, */
>  	/*  or it will cause download Fw fail. 2010.02.01. by tynli. */
> -	if (rtw_read8(padapter, REG_MCUFWDL) & RAM_DL_SEL) { /* 8051 RAM code */
> +	res = rtw_read8(padapter, REG_MCUFWDL, &reg);
> +	if (res)
> +		goto exit;

You didn't introduce this bug, but this path needs to have an error code
set.  Also we really need to get rid of the _FAIL garbage.  When I saw
this, I got "ret" and "res" mixed up so I thought we were returning
negative error codes instead of _FAIL.  That would   But then I saw we
are returning success.

> +
> +	if (reg & RAM_DL_SEL) { /* 8051 RAM code */
>  		rtw_write8(padapter, REG_MCUFWDL, 0x00);
>  		rtw_reset_8051(padapter);
>  	}
> @@ -278,7 +303,14 @@ int rtl8188e_firmware_download(struct adapter *padapter)
>  	fwdl_timeout = jiffies + msecs_to_jiffies(500);
>  	while (1) {
>  		/* reset the FWDL chksum */
> -		rtw_write8(padapter, REG_MCUFWDL, rtw_read8(padapter, REG_MCUFWDL) | FWDL_CHKSUM_RPT);
> +		res = rtw_read8(padapter, REG_MCUFWDL, &reg);
> +		if (res == -ENODEV)
> +			break;
> +
> +		if (res)
> +			continue;

This continue is wrong.  If res = -EPERM then it's a forever loop.
Let's just break for every error.

> +
> +		rtw_write8(padapter, REG_MCUFWDL, reg | FWDL_CHKSUM_RPT);
>  
>  		ret = write_fw(padapter, fw_data, fw_size);
>  
> diff --git a/drivers/staging/r8188eu/core/rtw_led.c b/drivers/staging/r8188eu/core/rtw_led.c
> index 2f3000428af7..b532e614c5b6 100644
> --- a/drivers/staging/r8188eu/core/rtw_led.c
> +++ b/drivers/staging/r8188eu/core/rtw_led.c
> @@ -34,28 +34,38 @@ static void ResetLedStatus(struct LED_871x *pLed)
>  
>  static void SwLedOn(struct adapter *padapter, struct LED_871x *pLed)
>  {
> -	u8	LedCfg;
> +	u8 LedCfg;

Please don't make unrelated changes.

regards,
dan carpenter

