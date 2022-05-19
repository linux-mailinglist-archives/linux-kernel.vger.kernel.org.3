Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF4C052CB91
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 07:44:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234085AbiESFoh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 01:44:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230504AbiESFod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 01:44:33 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3C22BA56E
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 22:44:32 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24IMJ6iP009158;
        Thu, 19 May 2022 05:44:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=OiD2wId4LUlyufxOrwwBe6mpHi0qusuJ/s2LUQ34kcY=;
 b=r+/AZ9ixK+WcyHIeAxaG0uptHOvJjPl20iB4AR2gN4OH7CG/zXVygstWGLoSpIZqK9hC
 FfBFMJ2fg9qpwxcHT8spDEcRw1dR3m8MfOaM/ZNjW3IqmcSrcAwjAas6uJuG8d7T4dMa
 v64kCVAqkaDPEty5tYhT+RPh8ZvjImGrLHtVZEYrrsPur/1T0wZnkNHXXkBSdwYkTDa1
 tw9E0eM+igHMeMfLRuOFjfI2V/gAfCILWHAAUbcfjB5IzanVMn5laeSi0D401MQhCJhG
 Dk9PysCP91BcqVBiGt5QO2ZQ0dldUZE8LrSPSM9bwbUcUDUUeqyf1ZxJZ4AV/6a+5YjQ rw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g2310u6vm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 May 2022 05:44:20 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24J5Ppfp033619;
        Thu, 19 May 2022 05:44:19 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3g22v523fn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 May 2022 05:44:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zcv8xCndJDNB/JlQ5sutINAh4dZm0uGioV76+bgnNTZ1B4q7bZnb6/n1KgcRl6XC+ETs1iTVIoRNJgfm7vIMMKsStspwb/cIyi8bTpWoxM4fyo/jilc1VCQ/1/3QcaLwXQCz6MC3eAZ+DzMiZMITuF6uz1E6jFTZNr9JEvMSH1KpePdJlUAjVWwd7Tp4rf1zpm6TshiPbkKRVZpLhYTIxJz1Jg83BKnsn0+4bKu0lYoFN0Bi6B+h4PlbpO7OEGModnK6NsX45ri3EtGUCIj45sYnLiRbn2W06WUz+um9aIp2HC9KK1IevY+DxwkaQKjxB5t2OPk+jz2s7rrYo4IpWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OiD2wId4LUlyufxOrwwBe6mpHi0qusuJ/s2LUQ34kcY=;
 b=Aivd+7DlMbcSzWKARG/wYsF2bqP4OWTNbTFKsYIxreg13CzHWKboDivbpYRK3LoRKrioy/suCssN+SuT+pP+coaGwXrzarLg1pYiqRe4AEHyGzwhbXsVVtcT+WpUhuDe1SlUoaYCJcwKgSnFKoYRFGnLCvyV4SETfKNfBVvZcOFBju+ACSyGjkN3lMGN/Hf+7SvirF1eCJ8Z+3wdkOPlUbgjQKf8A/EIQ5n+PJg67uZG0v5xB+1bDpRSkxm0sj/lrA1FTwvUbWdTknZFM1z4qp1JQLd3YoWGD3ni3WHNPFAY0yZti8vXN5C28Cz/58SI/Sv43g1lHybgzoUKCLUJ/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OiD2wId4LUlyufxOrwwBe6mpHi0qusuJ/s2LUQ34kcY=;
 b=yaJMYK47rEnoBAkx7H2M6iUjerd3+ZTiK3bWsyE53Z7F/lUR9o0jJMiQRrLIM1aiNTwL7vmSfpk+4CmPd7UzCiPvVsrDNqPaQyn3LX6lsxhJp4SAiOrr+WmQTByjFHhh1RU6gUagO2NGyWaTKhstYN5X4Lu+BRYsDKW0QG2LpGA=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CY4PR10MB1543.namprd10.prod.outlook.com
 (2603:10b6:903:2e::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Thu, 19 May
 2022 05:44:17 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::86f:81ba:9951:5a7e]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::86f:81ba:9951:5a7e%2]) with mapi id 15.20.5273.014; Thu, 19 May 2022
 05:44:17 +0000
Date:   Thu, 19 May 2022 08:43:56 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Pavel Skripkin <paskripkin@gmail.com>
Cc:     gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, straube.linux@gmail.com,
        fmdefrancesco@gmail.com, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: Re: [PATCH 3/4] staging: r8188eu: add error handling of rtw_read32
Message-ID: <20220519054356.GU4009@kadam>
References: <cover.1652911343.git.paskripkin@gmail.com>
 <5cab10528fed7d440ee57f93183d18c9de998adb.1652911343.git.paskripkin@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5cab10528fed7d440ee57f93183d18c9de998adb.1652911343.git.paskripkin@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0066.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::10)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 07fb2c96-b64f-4296-27d3-08da395a9ccf
X-MS-TrafficTypeDiagnostic: CY4PR10MB1543:EE_
X-Microsoft-Antispam-PRVS: <CY4PR10MB1543823FF602F4868DF3C4118ED09@CY4PR10MB1543.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rgl8Tybrgtnm3md02oupF5gmtfvhfy1dUy6tnV/FuAWJCNCMeEmPO/BALjGaQxFgvZH14TmKdg2E+3wbRHSsoMyQ3cZzi+YN+dRbvHxYeVkEZoUUFHWKTv37LAEe0HkVTxyAPqTeTPBo2I2n2Uik02A5JpwY+UZUNmXVIWZTbw0nI3Qs+9SKi3hnihrpj4+wx3iJ+Jd7ZM1WhsaLpfpfXAOd76UTE2F67hu6a2HSifHbBpYPEKuuB3/XFBHPQycgBJSFexXQ8RNwiuOc/AlL5+7wRa8IPOl+fiYMOlZFQNjWc+UeWdxm4VNaB2s0uMuADoRpqGciboZUNXL7IwuSjRZ41YatIAWIXqac8DuVqWMlXuUVbW+V9kuZCqM+WNdCJv5NAROQnU/E3pFAtMgs5JmHXstMPXePTGSWv0fGLy4p43iDfpntJ8od8iiUBEt3zBBj7Za2Y/Lm44YazL8UnyOudSfwAZ8Cx4XxdjPjGB4ljYJNXKkJZ/qul+Mia4RxuxmCf7KkvUw3rmTGdbvghYjt6BapQiu5sDz6shxQF9fBI0d2eqD6pILFKIWXFsBpH+CSKutu9S55HWNNgVPpxjLe1bRPZcDgSdP7Bq/CO0q4+I76tQzdSCFpNLSzDjCWJNN6EO95SygMyu1qYEUHliommb5kFoTPUtMvijJYV67Gc2y12rGcLfjpn/XgkCYYGgW2DJBFqW2yXnNToPGy1Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(6486002)(316002)(186003)(6512007)(52116002)(8936002)(33716001)(66476007)(8676002)(66556008)(4326008)(86362001)(83380400001)(33656002)(1076003)(26005)(6916009)(6666004)(9686003)(508600001)(38100700002)(38350700002)(6506007)(5660300002)(2906002)(44832011)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1SajeVg5BcpxBG40uvkxgXy6JCyAeFXMRe/P29HYzamJuGpEf7OtnTQhM1D+?=
 =?us-ascii?Q?eKiKrQ/Dadfd5f5TxCT2Kl2e2/LZ27n0Mr9yitUFguebNMEwuuKQFZ9IwuTx?=
 =?us-ascii?Q?I/6lgi4HT3UJSIiDvd4IvnOqPbWP38DrlCpVQ4GrxmUoku/Zd98x3fnrv0mN?=
 =?us-ascii?Q?7/z9WzIIWNoIRM8kgHcZaNg7ckw/YVGJKn6x1dq1chr85gFh2L2Nl+FzuouS?=
 =?us-ascii?Q?cYo5fy/GR6N2rMPauVWnN0TGsjOT/oZbjVgMfuaB0Yuucj2NG30rhf4Nkh/k?=
 =?us-ascii?Q?FOlI+loSyDFNcz30VQ6cK9vPW29R5qrH+U9ILWgOpoSNYk9S22uov2QNA4nx?=
 =?us-ascii?Q?2omln+h3+rGVpDaUKhmnwo0eMXESiyXGszWvUj0l4RgoMH/RIuwRIG+KDnMm?=
 =?us-ascii?Q?vQ0NB+2LSW12FMCd5SUyTO8gFwQppkCsvT+MgToi+lUEEw64gspmi6lzVlUu?=
 =?us-ascii?Q?MqRv39DaQ3QXljLaj73Cb+qDRHG+jc7KLDPtrV+HPatVEbvKlGde7q9CGTBc?=
 =?us-ascii?Q?ezNbpz8WCIAc/0KLZgOJ0BujtLrPFCqpPSjio9ywdw+7ph6O+FM9W9p+thPc?=
 =?us-ascii?Q?Z4LtMcSKV4GwJ3SMyMxdSVI7icrTWPZ99LoxtTt0Z4zRU+1+cQamrOux034T?=
 =?us-ascii?Q?Cn9rJdXTsVXEn/3P6ba3SUdvVr4ajB6UvNQWnjOBeQf/sDX9ryYWbaAD9bPi?=
 =?us-ascii?Q?MWDC+XPmnCv27G8KCSa3jL692eH4uz6LYblQ1mcO9gceJU8KQxv8OX4dNkZX?=
 =?us-ascii?Q?Q8FBuZv4AYsxdj0IFcWw50QpVJfgvLxQXnNZ5SxOaB40ADBkfj8ZBKjZRidJ?=
 =?us-ascii?Q?AXySDHnBH0EZ7xXSKZmvH9++piU3GzSNa6+bSZO5RxtQmjFD7XnXDRIkAAy3?=
 =?us-ascii?Q?1cdzlufHvrDiVQfLEVgdZ3iabjDcnJHsoUmj73sb1HMJxknX4zUekZw3yZnA?=
 =?us-ascii?Q?q8rwvd+3zlaf6at+Q0/WEPh9nENfxTNmnpOhpskCFHZq/jXmePjtcQLW85fE?=
 =?us-ascii?Q?fC/p7m4q+G6UB6VL4kgZDnoHTx+q8JhkCoR/BTtrpuLpS1go3lttlhu1qKXJ?=
 =?us-ascii?Q?OgYyyzjhblJgTv9XHD9wRIHs0zELZxwhB89zooD3k0iO4mTQM7XYHxE2xbXo?=
 =?us-ascii?Q?9NbAOFcPrQ3Xw0EFPzMjG7PzKsKC+ktmIwK8YN6XmqUNGZeMkD+VmvxTUM34?=
 =?us-ascii?Q?onMdE44zoD3p+P9rsl1l/TwAVUU0OVK36tZk/quU6bdxU6ImFGWCM7Obc1Ua?=
 =?us-ascii?Q?a4lXd5uJKMEz2FSbrllD7WY5GwpMbnDZTxgs1PQxhMAwSh2J5IVu6xpPuXh5?=
 =?us-ascii?Q?oP8cmkBF6V/XYXgClsFKoc2czYVZ2cvPz2Tn3lTKZed37O8ggItovx8ABwS6?=
 =?us-ascii?Q?dFr05i+kKmemZ1FKTRKaUKpiSVNUigbOe1Vz3vLJ/QH/48HZAA70SSCoWTHj?=
 =?us-ascii?Q?7kkY4brZL7x/Br3+DwReG6/7m3X9IxmR1QlDkDE56CHUCuALlacZSIOIhmOO?=
 =?us-ascii?Q?fSZmk7OnBauAkCeEHYRHV2RBqYFu6gqiVlFV+drLy4koSLCG4IbeoqT7sA0K?=
 =?us-ascii?Q?bi4+eqpRa0o0L3CO6qs8CT3TQXtKCkxqR9x2l2ugZBaC8XLQtlv/uBOqvXuc?=
 =?us-ascii?Q?Ke5+czFryyeU0Bok4EF6xmDEx/v4HFcePY3mtTnDoNjV8pJ/M0+MdSpyD3ok?=
 =?us-ascii?Q?yJ+Drd2Q7HV28p2+TPNSulaZ3btQdrLaz1hh7aKLDjqI0dCXoFNo4xYBGZzU?=
 =?us-ascii?Q?DQmYvgLEmaVRQ10qv2dAFhS8c4y7mtU=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07fb2c96-b64f-4296-27d3-08da395a9ccf
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2022 05:44:17.0757
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z636Ao5OlQIIfbXbVPTRYolRE9gZF3+GfazPnYw0fsoVXPcgpyjI+eSjkgXcPYeXWeTa7zBSA0AeyCcBR+QAuBMGmk0CyvYDk8xOsk/YbFY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1543
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.874
 definitions=2022-05-18_09:2022-05-17,2022-05-18 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205190035
X-Proofpoint-ORIG-GUID: kHS8r3SHf3dqPylbHzNthho8so1YVbqO
X-Proofpoint-GUID: kHS8r3SHf3dqPylbHzNthho8so1YVbqO
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 19, 2022 at 01:12:01AM +0300, Pavel Skripkin wrote:
> diff --git a/drivers/staging/r8188eu/core/rtw_efuse.c b/drivers/staging/r8188eu/core/rtw_efuse.c
> index a2691c7f96f6..7105122c2ba0 100644
> --- a/drivers/staging/r8188eu/core/rtw_efuse.c
> +++ b/drivers/staging/r8188eu/core/rtw_efuse.c
> @@ -47,9 +47,18 @@ ReadEFuseByte(
>  
>  	/* Check bit 32 read-ready */
>  	retry = 0;
> -	value32 = rtw_read32(Adapter, EFUSE_CTRL);
> -	while (!(((value32 >> 24) & 0xff) & 0x80)  && (retry < 10000)) {
> -		value32 = rtw_read32(Adapter, EFUSE_CTRL);
> +	res = rtw_read32(Adapter, EFUSE_CTRL, &value32);
> +	if (res)
> +		return;
> +
> +	while (retry < 10000) {
> +		res = rtw_read32(Adapter, EFUSE_CTRL, &value32);
> +		if (res)
> +			continue;

Forever loop.  Always put the ++ in side the while ().  Apparently,
Smatch does not catch this.  #Idea #Oppurtunity

> +
> +		if (((value32 >> 24) & 0xff) & 0x80)
> +			break;
> +
>  		retry++;
>  	}

[ snip ]

> @@ -215,7 +222,10 @@ static int fw_free_to_go(struct adapter *padapter)
>  	/*  polling for FW ready */
>  	counter = 0;
>  	do {
> -		value32 = rtw_read32(padapter, REG_MCUFWDL);
> +		res = rtw_read32(padapter, REG_MCUFWDL, &value32);
> +		if (res)
> +			continue;
> +
>  		if (value32 & WINTINI_RDY)
>  			return _SUCCESS;
>  		udelay(5);

You really want to do this delay on each iteration.  So write it like
so:

		res = rtw_read32(padapter, REG_MCUFWDL, &value32);
		if (!res && value32 & WINTINI_RDY)
			return _SUCCESS;
		udelay(5);


> diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
> index d4e59fab367c..e54d4139466d 100644
> --- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
> +++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
> @@ -6023,6 +6023,7 @@ static void mlme_join(struct adapter *adapter, int type)
>  	struct mlme_priv *mlmepriv = &adapter->mlmepriv;
>  	u8 retry_limit = 0x30, reg;
>  	int res;
> +	u32 reg32;


The reg32 should got before the res so it's in reverse Christmas tree
order.

[ snip ]

> @@ -245,8 +246,18 @@ static void efuse_read_phymap_from_txpktbuf(
>  		} while (time_before(jiffies, timeout));
>  
>  		/* data from EEPROM needs to be in LE */
> -		lo32 = cpu_to_le32(rtw_read32(adapter, REG_PKTBUF_DBG_DATA_L));
> -		hi32 = cpu_to_le32(rtw_read32(adapter, REG_PKTBUF_DBG_DATA_H));
> +		res = rtw_read32(adapter, REG_PKTBUF_DBG_DATA_L, &reg32);
> +		if (res)
> +			return;
> +
> +		lo32 = cpu_to_le32(reg32);
> +
> +

Double blank line.  Checkpatch?

> @@ -596,12 +611,16 @@ static s32 _LLTWrite(struct adapter *padapter, u32 address, u32 data)
>  	s32	count = 0;
>  	u32	value = _LLT_INIT_ADDR(address) | _LLT_INIT_DATA(data) | _LLT_OP(_LLT_WRITE_ACCESS);
>  	u16	LLTReg = REG_LLT_INIT;
> +	int res;
>  
>  	rtw_write32(padapter, LLTReg, value);
>  
>  	/* polling */
>  	do {
> -		value = rtw_read32(padapter, LLTReg);
> +		res = rtw_read32(padapter, LLTReg, &value);
> +		if (res)
> +			continue;

This continue has the potential to lead to a forever loop.  The limit
check needs to be a part of the do while() condition.  Probably send
that patch first, by itself as a clean up before adding this continue.

> +
>  		if (_LLT_NO_ACTIVE == _LLT_OP_VALUE(value))
>  			break;
>  

regards,
dan carpenter

