Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF8FD50BB5B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 17:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1449231AbiDVPNe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 11:13:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1449221AbiDVPMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 11:12:49 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F17FCB2D
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 08:09:53 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23MCQMZc019753;
        Fri, 22 Apr 2022 15:09:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=ZjiUI5bOex1uVyk1kpsNtMf1Uvz46AOWe5qtcDceiT0=;
 b=KBb4cc+pb0sqVSOCRJL/k3NBoZlb8fbjm7W9vM1Ub8fsDbqYCaRTrgBHeJVZvjXtPgBB
 aLclGqZYY8UDkT2wkmV/DkTzLs7gaUDXh2BQUvf1b4wOS869vujcYBnaO/6ufyFj71nC
 NrDGSVekueBWF5CY1nNgDoAwvp4+gNaHD9TUs+dQ0Q4hrSr2sG55uUEuq5R+v35FmCek
 YqPj0u6KvVAKboygx+Btaw3O9vsANgSb6ul7iKfkiFgNmoV/A3OYSvmo/MEbYXrVrPi7
 gRuMH88fecWEN7+2q6cYI/jtC5gD6txC5NFuv3eX+/MGhuhF2bjg6HNP0uAaRQy8Mo/1 EA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ffmd1f2md-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Apr 2022 15:09:39 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23MF51v0037195;
        Fri, 22 Apr 2022 15:09:38 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2175.outbound.protection.outlook.com [104.47.73.175])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3ffm8b28w9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Apr 2022 15:09:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eLEh4jb9mDJWmi/aHTsXHc6MpWvM7AOJuGVSryh9uHbEk/nudclvqs8CUw9bgvb+ym/NVuaBbRslpxFDiIEq0RF5T8xnLBpEEuds/T1RnzZcvDoEUdnlCNpOG56wiW5KrKHxF/YqAWeTXCC4eP8fzjU9YMPoK/M9hUR/hqyilUBScCLWb3Ltx8WlGs9Eoo51zN8m3OAoxA/PDWP11NCphGGBl0+sELLL34dE58ekpYtEj5J17xQbn3nIIjvkch70gfxMwW+JhScco0L6ELJVX6NYLUQar0eIhomGWicSowpXfLp8DbT7l2aQfgr4t+svpaQtEUEnA9nbzwTLDnLx4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZjiUI5bOex1uVyk1kpsNtMf1Uvz46AOWe5qtcDceiT0=;
 b=jPCG4OX9BefzIsl8jrs6LMSpKNlsY0fP7HjdoYuYRVL3RqEyUkHARDrqLOeEvkudI46H2UH16/tidJriOxQ47LGAz30fw/MKdq4rLYrytK402MmCU5vrLWgzGps6bV6hTKKEg/3H/yCTY2Z54YP7BlMGcsxV9V5QLAkwZd+iEALWYKYhidWjXxgdMJsUBjFoT2Ejw3afpA1h2PoOxAabL/ciMttIN7Zhy9jqPeNytq/perG2hwjEua1wS8tLIR8s7OdhndlU8T0Lron/fW/iyJQphCu2duScAGvpUixnmnI+igyoAQ7d3793y3E1c4D8OGVO4zRKRqLhmc+RcXqxDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZjiUI5bOex1uVyk1kpsNtMf1Uvz46AOWe5qtcDceiT0=;
 b=PytmDqG6f2Bymd6QS8taR+t1jZa9txx2CQzWTrfzHW5E9V9NOWV5L9FPmxhApFsXeBuyxrQ5VglDIi63jjTA078fQKlcTyRBdLbKFTk4gujUVFEbpjQpvlexxJCmUQdP30g/5H80PDJysZl8OZHfkP87QjzN5nV24nLkP/P1DSI=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DM5PR10MB1417.namprd10.prod.outlook.com
 (2603:10b6:3:f::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Fri, 22 Apr
 2022 15:09:36 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87%5]) with mapi id 15.20.5164.025; Fri, 22 Apr 2022
 15:09:35 +0000
Date:   Fri, 22 Apr 2022 18:09:12 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Solomon Tan <wjsota@gmail.com>
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8192e: Remove space after cast
Message-ID: <20220422150912.GJ2462@kadam>
References: <20220419124318.8028-1-wjsota@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220419124318.8028-1-wjsota@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MR2P264CA0005.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:1::17) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f080b1a5-80f7-4e4f-caf4-08da24721c20
X-MS-TrafficTypeDiagnostic: DM5PR10MB1417:EE_
X-Microsoft-Antispam-PRVS: <DM5PR10MB141738B735C9DF87D37909C08EF79@DM5PR10MB1417.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aTOL0ITIbJF6eD+wX0b9Aynuf56X+zdLqFpFFaiL4PVGJaMQ8jX/P1smkdIyTJ5IpblkxAUtjjT2CKqQjgG4jjb53ANPk0xUTiKAcDWOQYrBLTdgnLrcKV64t2t1T7wpukqNyHs+XA1bApqFInFNxhFzDYkwAdYKotsf3y/UbgaHVwAK8vMJFrXjQHfJFUU/hEgMVSLOlrKDWO49oaoHY9lCDvdZZdL8DCIAJZhDQyrYeDEMH0JHXIQuAw6r97kndNvMSmqKDuN033wKYzD697BFNdDfT7OoF+k5rcQK+h/IVEg52ctvZwofQjY8HncdG3zIB+WP3XOHu9OGKFCpNL6qknuaeMDnyrpArgvrEJJG6Aj01si6luydZEb533oKRnNFjpQgvSajhiBE0+jFWLGmDr4rWYprGg1/KBKvJK0UycdvgWyMDG83TBRgLHHNmxxMU9iLQlh2iIDejGJF18ccsuVeGB1Hou0iu8J3BNBtyCPU3seYHmeWN9/ppHFU1bjBfip7w9jiGJiHpzNi7VHUMTZwvPcTPNq14gc6h3diIrDq04UvzS63sqwJxc1Rw1GicWSRdJhA+k/V7AMrAUXL4p0PqWa+Yn4coICLaHGTbL/n1y5tpah9adHMcPN9a3UFPhOpntZxQ9vi2HW0d/OfHE9QxvrkW0R91S3Pnon9ExHPKWF+5nq6rDyVzPrCiXB6+Udb2cvkkgPLEXuqgQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(6916009)(316002)(2906002)(33656002)(6666004)(4326008)(8676002)(6486002)(44832011)(186003)(508600001)(8936002)(83380400001)(38350700002)(38100700002)(9686003)(6512007)(26005)(5660300002)(6506007)(1076003)(33716001)(86362001)(66946007)(66556008)(66476007)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7+T9AoDoNPQsq4Ja5Y/yGtnpOlMHe4T8uVl+b78CPaEECi2FJgTLbhT6NPrd?=
 =?us-ascii?Q?lRsjMChfLNv5d4zq5sy2/vcmdg5U/INwAt4ORtN113uioXdY2OxPL5uxvSFL?=
 =?us-ascii?Q?s93XL+rDOA62n0Won2R/w7O2KgCrXrVjYgo54iYB0zCgnWGs+9gPfcV0Prib?=
 =?us-ascii?Q?rrSwSCOXFM9lsXMYC33ircYCt6An4xVAirkBXJkpzU0ufXhRF//yNoGjrJkf?=
 =?us-ascii?Q?Y1ca4wZzOi147xsJ72T9haQXEuzO2QoE+SYOgEkZP2aFlh5wSzzJRGYnU4bS?=
 =?us-ascii?Q?o3JEG2mLS1jKUgGQgdeuNs2RZCtP4TVlNFpHk5zFUDsQa1XeEi6E4WizfX12?=
 =?us-ascii?Q?B9f6tOlltBioY3SteFfnmPF7KwLfhOvOkx6re2dhYMCcDn+ZqkFay9+GW7K8?=
 =?us-ascii?Q?HwnC3aMCntGxleE5t4FdHXnRhm+JN/iq9g2IAOTjRzzpH4sIPf0HI9Ix2FY8?=
 =?us-ascii?Q?fOSUqJNQgmJ65331DrPfGOjv5aMifauRorLD/lPl+/F1vVyGSUudfbgYDvYm?=
 =?us-ascii?Q?EMY1W/wPpk83n/r4Xt7i911/qZScB/7xBoFjgjprhKopsf+4aSANF4bSqDgZ?=
 =?us-ascii?Q?w2afW3qiCwR0LpoxwqJLU2U7OLZNNrvEQh84XnZTPErCblbP7sTwQC3/HAPA?=
 =?us-ascii?Q?PCreB5gC34t9f+qXg9Refm/Fx5C0A5aF9QtlXbaNtejM2Hi4T1KPrHx7h750?=
 =?us-ascii?Q?43k0Vd0AdUi6ahp3Z/Ad+PEzDI+c25OfVEdYbpVQxdqQI5gzmmNvtrBrzK8m?=
 =?us-ascii?Q?by5gizNtDBHYiYBwUVKQwBN3YhvWfhqPEme5iIuyJUK5D9P9bOjV7WEC0JrT?=
 =?us-ascii?Q?X5/3yCQmx0JjSLj5tz41x0Kx6nfsVQTRhW75qkRcrXtsvHykqWAz2DWhdENU?=
 =?us-ascii?Q?htMYup/GB2o15P6cp/5BC42+8fD50hLh5fdCy2iGhqS8GP/JIWGlQGDGiRNR?=
 =?us-ascii?Q?wbk00s25ZHou4y68dJwpIj3ADF/vVvUG9Ipa6mJ65DkTAYIxrDZDJxAIpsj6?=
 =?us-ascii?Q?kb5AQ0zMCEM0vZgLHynjLfuOK9y3ptwpDE9Mffh4CCtcY5J2HoOc+0/4RNiq?=
 =?us-ascii?Q?Luppk7CHK32Se9MmdsU0PKfM74hV8eTFi1t43gauCc0PMhxj2LXdcJChSQS/?=
 =?us-ascii?Q?pM20dRXv3RT2Fh65u9h8XZ1vuIEvPhHVIkwJYoXJNY1/7a03ZWeghpvTLKzF?=
 =?us-ascii?Q?53cOUqsnRpGYQu0hSDCa90nVjHpgv/6zlU0LOxlcRuQ8NqYgcHEAVaX4xQjK?=
 =?us-ascii?Q?JzUF1BM1f6r0HK6QCkQ+XeNDnHrZDM1gt75CZcOeYKBu7Q8ILAgarlZHgadj?=
 =?us-ascii?Q?tgV5B5pBEzW3Jkke3N1h2RN+wdgIvCS7svparEt41NtPmiJcMFutrUM+kDso?=
 =?us-ascii?Q?bdgKoR94Iq5loS/IEWpaV020Lko+zpyg5DKDAmWVQAVGmCAuaUfhUe3bmf1b?=
 =?us-ascii?Q?Y+VLWq8h0jVWGNTJtplWgVba24OAd7k/BSiwdyiytonVTM0xyM1vMaE6+63A?=
 =?us-ascii?Q?4/UTFVd3dGu22y5HblkAuBv68bdQaupqGZOdZl2v7Kk11Qv/F9bzIlYFrwBc?=
 =?us-ascii?Q?OXhGDzH4wlLZhG6b0u5NzqiUHQUX63q3YgSNNlVE8JotxwHxnhD/bjIXo5Vm?=
 =?us-ascii?Q?FDdnBWBIBYVhWWipOere4qkTzCCePMY68RqjBIMtQu7LDE9EejhEtbJJQZDq?=
 =?us-ascii?Q?xEjCs6V1j6/43NMP1kcL1qjYQZFTtTQD9mu5llfr97m6uiS0mf4Z155P75S5?=
 =?us-ascii?Q?dTMu/OrUJLorpBDBqiXrTfK2+FDx9F8=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f080b1a5-80f7-4e4f-caf4-08da24721c20
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2022 15:09:35.5003
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XxGJbRscDnVTvhsgbE9jAZkuOR/C3/aRkSmrjgaC66UAcRWsxwp7SaTXCTbIzkaz31zyJjo+ovFHpoNkC5iHBkGBgzp+u6k/ghM1nN1hzNs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1417
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-22_04:2022-04-22,2022-04-22 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0
 suspectscore=0 mlxscore=0 spamscore=0 mlxlogscore=999 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204220067
X-Proofpoint-ORIG-GUID: NXh-vVcfYSzkBxPnVLfTgv__H2ph8Xzg
X-Proofpoint-GUID: NXh-vVcfYSzkBxPnVLfTgv__H2ph8Xzg
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 19, 2022 at 08:43:19PM +0800, Solomon Tan wrote:
> This patch addresses the checkpatch.pl flag that there should not be a
> space after a cast.
> 
> Signed-off-by: Solomon Tan <wjsota@gmail.com>
> ---
>  .../staging/rtl8192e/rtl8192e/r8192E_dev.c    |  8 ++--
>  drivers/staging/rtl8192e/rtl8192e/rtl_dm.c    |  2 +-
>  drivers/staging/rtl8192e/rtl819x_BAProc.c     |  2 +-
>  drivers/staging/rtl8192e/rtllib_crypt_ccmp.c  | 10 ++---
>  drivers/staging/rtl8192e/rtllib_crypt_tkip.c  | 38 +++++++++----------
>  drivers/staging/rtl8192e/rtllib_rx.c          | 20 +++++-----
>  drivers/staging/rtl8192e/rtllib_softmac.c     | 34 ++++++++---------
>  drivers/staging/rtl8192e/rtllib_softmac_wx.c  |  4 +-
>  drivers/staging/rtl8192e/rtllib_wx.c          |  2 +-
>  9 files changed, 60 insertions(+), 60 deletions(-)
> 
> diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
> index 7f9dee42a04d..a45ee95a8e6b 100644
> --- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
> +++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
> @@ -221,7 +221,7 @@ void rtl92e_set_reg(struct net_device *dev, u8 variable, u8 *val)
>  			 &priv->rtllib->current_network.qos_data.parameters;
>  		u8 pAcParam = *val;
>  		u32 eACI = pAcParam;
> -		union aci_aifsn *pAciAifsn = (union aci_aifsn *) &
> +		union aci_aifsn *pAciAifsn = (union aci_aifsn *)&
>  					      (qos_parameters->aifs[0]);

The & should go on the other line actually.

	union aci_aifsn *pAciAifsn = (union aci_aifsn *)
					&qos_parameters->aifs[0];


>  		u8 acm = pAciAifsn->f.acm;
>  		u8 AcmCtrl = rtl92e_readb(dev, AcmHwCtrl);
> @@ -811,7 +811,7 @@ bool rtl92e_start_adapter(struct net_device *dev)
>  
>  	rtl92e_config_mac(dev);
>  
> -	if (priv->card_8192_version > (u8) VERSION_8190_BD) {
> +	if (priv->card_8192_version > (u8)VERSION_8190_BD) {

This cast is unnecessary.  Just delete it.  In a separate patch.

>  		rtl92e_get_tx_power(dev);
>  		rtl92e_set_tx_power(dev, priv->chan);
>  	}
> @@ -1613,9 +1613,9 @@ static void _rtl92e_query_rxphystatus(
>  				total_rssi += RSSI;
>  
>  			if (bpacket_match_bssid) {
> -				pstats->RxMIMOSignalStrength[i] = (u8) RSSI;
> +				pstats->RxMIMOSignalStrength[i] = (u8)RSSI;
>  				precord_stats->RxMIMOSignalStrength[i] =
> -								(u8) RSSI;
> +								(u8)RSSI;

Same thing delete.

>  			}
>  		}
>  
> diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
> index 756d8db51937..aa942d915992 100644
> --- a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
> +++ b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
> @@ -844,7 +844,7 @@ static void _rtl92e_dm_tx_power_tracking_cb_thermal(struct net_device *dev)
>  		TempCCk = rtl92e_get_bb_reg(dev, rCCK0_TxFilter1, bMaskByte2);
>  		for (i = 0; i < CCK_Table_length; i++) {
>  			if (TempCCk == (u32)CCKSwingTable_Ch1_Ch13[i][0]) {
> -				priv->CCK_index = (u8) i;
> +				priv->CCK_index = (u8)i;

Same thing.

>  				RT_TRACE(COMP_POWER_TRACKING,
>  					 "Initial reg0x%x = 0x%x, CCK_index = 0x%x\n",
>  					 rCCK0_TxFilter1, TempCCk,
> diff --git a/drivers/staging/rtl8192e/rtl819x_BAProc.c b/drivers/staging/rtl8192e/rtl819x_BAProc.c
> index 97afea4c3511..4616ea8266b3 100644
> --- a/drivers/staging/rtl8192e/rtl819x_BAProc.c
> +++ b/drivers/staging/rtl8192e/rtl819x_BAProc.c
> @@ -238,7 +238,7 @@ int rtllib_rx_ADDBAReq(struct rtllib_device *ieee, struct sk_buff *skb)
>  			     skb->data, skb->len);
>  #endif
>  
> -	req = (struct rtllib_hdr_3addr *) skb->data;
> +	req = (struct rtllib_hdr_3addr *)skb->data;
>  	tag = (u8 *)req;
>  	dst = (u8 *)(&req->addr2[0]);
>  	tag += sizeof(struct rtllib_hdr_3addr);
> diff --git a/drivers/staging/rtl8192e/rtllib_crypt_ccmp.c b/drivers/staging/rtl8192e/rtllib_crypt_ccmp.c
> index ed968c01c7ff..a8d22da8bc9a 100644
> --- a/drivers/staging/rtl8192e/rtllib_crypt_ccmp.c
> +++ b/drivers/staging/rtl8192e/rtllib_crypt_ccmp.c
> @@ -103,7 +103,7 @@ static int ccmp_init_iv_and_aad(struct rtllib_hdr_4addr *hdr,
>  	if (a4_included)
>  		aad_len += 6;
>  	if (qc_included) {
> -		pos = (u8 *) &hdr->addr4;
> +		pos = (u8 *)&hdr->addr4;
>  		if (a4_included)
>  			pos += 6;
>  		qc = *pos & 0x0f;
> @@ -130,13 +130,13 @@ static int ccmp_init_iv_and_aad(struct rtllib_hdr_4addr *hdr,
>  	 * A4 (if present)
>  	 * QC (if present)
>  	 */
> -	pos = (u8 *) hdr;
> +	pos = (u8 *)hdr;
>  	aad[0] = pos[0] & 0x8f;
>  	aad[1] = pos[1] & 0xc7;
>  	memcpy(&aad[2], &hdr->addr1, ETH_ALEN);
>  	memcpy(&aad[8], &hdr->addr2, ETH_ALEN);
>  	memcpy(&aad[14], &hdr->addr3, ETH_ALEN);
> -	pos = (u8 *) &hdr->seq_ctl;
> +	pos = (u8 *)&hdr->seq_ctl;
>  	aad[20] = pos[0] & 0x0f;
>  	aad[21] = 0; /* all bits masked */
>  	memset(aad + 22, 0, 8);
> @@ -186,7 +186,7 @@ static int rtllib_ccmp_encrypt(struct sk_buff *skb, int hdr_len, void *priv)
>  	*pos++ = key->tx_pn[1];
>  	*pos++ = key->tx_pn[0];
>  
> -	hdr = (struct rtllib_hdr_4addr *) skb->data;
> +	hdr = (struct rtllib_hdr_4addr *)skb->data;
>  	if (!tcb_desc->bHwSec) {
>  		struct aead_request *req;
>  		struct scatterlist sg[2];
> @@ -235,7 +235,7 @@ static int rtllib_ccmp_decrypt(struct sk_buff *skb, int hdr_len, void *priv)
>  		return -1;
>  	}
>  
> -	hdr = (struct rtllib_hdr_4addr *) skb->data;
> +	hdr = (struct rtllib_hdr_4addr *)skb->data;
>  	pos = skb->data + hdr_len;
>  	keyidx = pos[3];
>  	if (!(keyidx & (1 << 5))) {
> diff --git a/drivers/staging/rtl8192e/rtllib_crypt_tkip.c b/drivers/staging/rtl8192e/rtllib_crypt_tkip.c
> index 4a760ecbc31e..a305b79c53e7 100644
> --- a/drivers/staging/rtl8192e/rtllib_crypt_tkip.c
> +++ b/drivers/staging/rtl8192e/rtllib_crypt_tkip.c
> @@ -136,7 +136,7 @@ static inline u16 Hi16(u32 val)
>  
>  static inline u16 Mk16(u8 hi, u8 lo)
>  {
> -	return lo | (((u16) hi) << 8);
> +	return lo | (((u16)hi) << 8);

Delete this cast.

>  }

regards,
dan carpenter

