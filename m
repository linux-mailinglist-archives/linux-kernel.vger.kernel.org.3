Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE0074FB9BC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 12:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345602AbiDKKgF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 06:36:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345594AbiDKKf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 06:35:58 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F26643AE8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 03:33:44 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23BALcLm029741;
        Mon, 11 Apr 2022 10:33:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=YJ+NMoAsACj4ZBGPS7UOoC+Fe17JfZozpZfZu6Ywe8g=;
 b=MMJOJi5eYp7CBbZMQdWWuemTNcHL3zvra2e53b7GAe5cMVX9OCQzHpAJrHU/TAxw8ozs
 VOesvoscvYROE9mpwFpLuijSPz8ieHKLNUJNaGaNtHZkNoMJKout71r8+sKAbNva8W8V
 B39V+cpczsMj/fF1VxaRnn5Zj8LjONeuX5DypK5eRzi/mkroSU9feJEgGNaZb5GpslCs
 wukeUDmVt96TndW3TjMZY5l9vv4jH0/LHjk9oNvbpSC7a0Il7bYvGctfv0BvaNkek7oe
 sPXKL357Ol58dJ0dfIBXR7U7eF6Uo41g1L6CLZdO8dxJQeoLosNqtELfgtOdZUQiXyD0 9Q== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com with ESMTP id 3fb0jd36gf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Apr 2022 10:33:38 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23BAVI5h002577;
        Mon, 11 Apr 2022 10:33:37 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fb0k1k0ta-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Apr 2022 10:33:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IjRjx0dPfmo+fhFNY5vBqaZDzWqxc5j69HLhF+BP1B2nQZe5T0sYIjkOKtI1HaDfN3MJY/DuMlBqkcd8snd1Ty5VA8k0lPYoZqDC1xwi2+tyP1NExfxJJNcIecvKghqhVyBPOg0Cb/qRP0M1F1qXANCQExMCBQ2a3k1Hyg+/H2jy1AZsapz2IMSi01gaeMbexfL97lChJtgkmW4og6udoFSM1zX7c5RpcxowrurgiJ3ucQMz2x7LBZAbw6p71yEZmMWFBKiVY95uDqczw/c3m+7IYBwIrFtuIqP85K35FIxSmbcUkIzjTkHTxueQxn5xrXeRPcxzHmCVnYGW0JKD4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YJ+NMoAsACj4ZBGPS7UOoC+Fe17JfZozpZfZu6Ywe8g=;
 b=D11jrdflDrxMHJcJrvB3llGKs8cahXk1wF8vmFZSWiSvnWYzJ8petOgtuwW/Z5z/lOy0AYkB3J1InfFjvm1igOr9dgblmw02C0o+fX32VGr38gppDyY5DZEZ+NFgray7t6tqZCZLBgIqTr1GbcWziPR+B6A/BOtX/MDglK+AHZcNZLn88Z35VqrlnDwZgZdOZoar/TptxOkX5SCgc9hZnzCv8IR2AqTlpitXDfhd7sSBCCKSK51sZoEMBQbVe9KcVsAzYpbRaJTPiRFuT+AMrerbynCNe4eXCXDQ3lhj9VdwKeM5zOGc/98pBnkbSN7qEYFDJJP3+DNz3rFWHM7JgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YJ+NMoAsACj4ZBGPS7UOoC+Fe17JfZozpZfZu6Ywe8g=;
 b=VbNplOF8l8SyuNjDQXM9QW/bv0XqMTdR+0v3D8VCgUAsWOUjthrDlopbWsPLF3nEi+Bkv1uuzEN74x30Hpb66HmyVgyenOFFfA3koCcRUUQ/LMVwieoXkNMl8yzKDkWprXZCh7KVR8Lu17iZ5PU14kt1nb22mkEyk4hKggx2o58=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DM6PR10MB2588.namprd10.prod.outlook.com
 (2603:10b6:5:ba::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Mon, 11 Apr
 2022 10:33:36 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87%5]) with mapi id 15.20.5144.022; Mon, 11 Apr 2022
 10:33:35 +0000
Date:   Mon, 11 Apr 2022 13:33:12 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Vihas Makwana <makvihas@gmail.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Pavel Skripkin <paskripkin@gmail.com>
Subject: Re: [PATCH v2 5/7] staging: r8188eu: drop unnecessary wrapper
 _rtw_free_mlme_priv
Message-ID: <20220411103312.GX3293@kadam>
References: <20220411102136.14937-1-makvihas@gmail.com>
 <20220411102136.14937-6-makvihas@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220411102136.14937-6-makvihas@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0020.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:19::32)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 78a26fdc-2cec-4e1f-9e60-08da1ba6bbac
X-MS-TrafficTypeDiagnostic: DM6PR10MB2588:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB25887505B45B4A515BF3C6AA8EEA9@DM6PR10MB2588.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bavWfMkZZE21JrWZgNTWOST4tvPU3/jLmSVQk0XyU7+A1uaqg1mbwr/piEkZrCLVwgoy7Laf85fHVKFuE0Yrtip+Gq6EBx9mFLxj+kkcSKB/7ZgDetlQX5z/nGkwcGGC0gH4Xc8AHtKeg9Fs2HZkP9NWK/QUtVf3iPVRCu3rwXLZik2a+CNfcpXNYZJtRBX3uNMmErPuNzqWcqd1OlkTdldtIjWa/QhSS7kEd+B+L4EGraA7kju39IqHZfyQ8jdunfT2fHTQ7aFO/dlkdgJCQKqg+Oz65zdcioMv9vcKG1QaN/uql72gXg6QiLFeimPj6/eOZjovWyNeHZFaHZI7l1kQyKXUbggVjg4vLoIPPrWIqMLF3g1PLwwWpoy0ANzc40CTPRYhmw30zhi5zXqebK0qHw5+qncImkM/aSKarakvP3AiVuMmNtMCeAhtoNwjxMsx9GKyTOjFhbgJTpQ/iRslDT0lIHKNvnCpWxND8zwyTxXwiJmo/rh+rMlFoPS9Z2JkSFfBKex1O2WiGjn5X01he0IzR1AKgajeFuQVO9/TNTJBksE+MYNgqg2jzXxDHoz9/yUGTCD0TL6oVYU+pgMughj52qDFdREo+zlcznl6DfI6pP/rKJHyU9B04Ujxw/q+X2Bdke+bUljFGw3Y6BYTbGdYo9Fkr6d8PaUC6BfJkoAEYIqx1daweqT2xrnzQBqOO0IAS1Z8iIWO+jR7SA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(6916009)(6666004)(9686003)(6506007)(6512007)(86362001)(33716001)(52116002)(54906003)(6486002)(316002)(508600001)(38100700002)(38350700002)(186003)(26005)(1076003)(66556008)(33656002)(66946007)(66476007)(5660300002)(8676002)(4326008)(8936002)(44832011)(4744005)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wLfQdSLld3sU+OOAqpPhaRl/A+45Ic7JhqjxTmDbV/W6oDND3WMetKOv7QSC?=
 =?us-ascii?Q?2UWB88yMyMBJlV6EdCNjMEOcngYcroYiKdOb9+H3QSESws3hp4E1Zp5JNz7w?=
 =?us-ascii?Q?vBsclDkkXZNmcArAmIp92wzlgkRTITQiClEjU8SiHhYjlgIk53yukiFOSeoJ?=
 =?us-ascii?Q?Ez3U/HLjcOSgkRHsrzoJiwH2bMIIvzEr+sptkDFCqxgGsSlVP6AOjecxsdxv?=
 =?us-ascii?Q?cER2EqiiNTlKZjFYwLlVZBoYq2whY5kR9cqt2cmU2FWauxnpCYSig6JtFs0S?=
 =?us-ascii?Q?XzWM2RyHCpTj/E1TbP9/FrW+N9jF6ENiyWQcXZOH7yG9Cwn06DxHnmGVGtxp?=
 =?us-ascii?Q?8KzfrJwiRyC15c4Vj/pjMy8mpmr3dEfPg4m26qSY1C0oaHSnf1hlIFu9rbL3?=
 =?us-ascii?Q?t/R90qH2LiVPeBYsnzHjt+G2DNcIfpTg56lQr9ooRQhDTa6EMFSAQEHltS5d?=
 =?us-ascii?Q?VfFxPd1pKgMeYPOZOQIlLG741aa9hnDwyG8LN5Yf1lioqrukSt00FlMBpof+?=
 =?us-ascii?Q?jie+JNjHMKxGqWzcKhqLWyToCS41t+7PFb6nMuftHK8j55jPUtLpj1VZUSqc?=
 =?us-ascii?Q?xhDdt7BT14ISIXGBC1PMTOOO/wOah95aUdfMq0OxYVsCTMG3onRqOs599bi+?=
 =?us-ascii?Q?t9aogzkHTWFPkJVYvt2cVylA8ojtHCeNO4ATe8HhSD5bS/y+bWqnm8+Mvzor?=
 =?us-ascii?Q?vnnpRbDsULtuFHNUySL1b2ssUDke8u7xuxRSYYvPVh3hNfdLsoT7DaX4pHSD?=
 =?us-ascii?Q?+X0q/lfHy6dJMc4biZmxX3FQ9oOzvdxXOWNddTV1nCk45BsJNusdttEfdesk?=
 =?us-ascii?Q?T4uxv+Qppj5MEp1L1wlY/3g9Fz1UVid8YEieu9Bydadbux1zOsrcGcC0iv8B?=
 =?us-ascii?Q?XYH7o1nm1K5hny7+trYVmQxiV6ayMznZWhroYXgh/nA+m9WVIwGRAlUCAB5A?=
 =?us-ascii?Q?Ujcpxg3/gauJyKtL8G3XjnHo6tUWw7L8MhhYdf6DnmddaEJgPsOhS2UXKXED?=
 =?us-ascii?Q?wu8SVfB/ZDytbdg+czI+ABpCzCZtEWf0g9qadkxiXM+K9vyBVskjb8RQYhUw?=
 =?us-ascii?Q?estF8gmjzSnoiW6knDfDJ0g58NmBKQoOf0g5BxQ52NloOUXFu+09EzLRWrBq?=
 =?us-ascii?Q?k+mC5tOR2iglOY40tG5HN904YyAHznehkG1TSzOk+QlJxl50s6Dj5ZstEpPa?=
 =?us-ascii?Q?iR9U+Z9Et5VyzIx3fuXORLwN6QtAfXvznWYDEhah43/eSV0+J9xgtUTN7gA2?=
 =?us-ascii?Q?sJ7tmo9oG58EQB+0WT7Y+pTwCtrF+y7+DIoersK7SL8cw6cInfDX47pNyZw3?=
 =?us-ascii?Q?MWKHLQ0Uqb5qUWe+XTxXR/ElmatBiCrW+Naq8AnlzkmbfcMAB9pyRpNOhWKF?=
 =?us-ascii?Q?5SM0DAKaafhiekLfnLh6japNm9zJ79FZ1wXEJLOasvWqWurV/wcj8RAZjFHv?=
 =?us-ascii?Q?EoY04q+fyM8dR4Vjed0XVd+xbT1k0LY30ucl5WF5KGEjKIWWTUbZ/i0FQHxQ?=
 =?us-ascii?Q?v3UeRJftDYI19XgOeWk9A4d3RYiOTMGpl0CBBsCIrJ+ZuguK1ckHBL/YQ9xi?=
 =?us-ascii?Q?niFLCoB/A2MWk8PXGsHZg0uumXrDW2cINsMslff8iyXhROUXqQdKwfJZ5vOk?=
 =?us-ascii?Q?m0HoghAhl8G2aDirL0Ebag96ujEgMaNQ57rvmzmRs86dNPcelBDGxKczgQcO?=
 =?us-ascii?Q?uqoTyDIc7r6ddLTkAKAVExWM1tHv+0a1FycABktixAFrV74GD6zivnaVGpW+?=
 =?us-ascii?Q?qW3wOHJXGuPI1M+Qa/fmUBMcjiVVQSQ=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78a26fdc-2cec-4e1f-9e60-08da1ba6bbac
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2022 10:33:35.7894
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h3ZfI+tupXaCKWFZPoaRmu9JYr6SWdIg7/vdkUIoNa0r/hPWlBvfPuOcYaPOW/T3N9Tazud2poxjYBTP39/+ZtN8sDupvrj5piCmG9mhn+g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB2588
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.858
 definitions=2022-04-11_03:2022-04-11,2022-04-11 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 mlxlogscore=788 mlxscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204110059
X-Proofpoint-ORIG-GUID: vx2bpMpS36kmaY6ifqdJrGkximZtmYdx
X-Proofpoint-GUID: vx2bpMpS36kmaY6ifqdJrGkximZtmYdx
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 11, 2022 at 03:51:34PM +0530, Vihas Makwana wrote:
> -void _rtw_free_mlme_priv(struct mlme_priv *pmlmepriv)
> -{
> -
> -	rtw_free_mlme_priv_ie_data(pmlmepriv);
> -
> -	if (pmlmepriv) {
> -		vfree(pmlmepriv->free_bss_buf);
> -	}
> -
> -}
> -
>  struct	wlan_network *_rtw_alloc_network(struct	mlme_priv *pmlmepriv)/* _queue *free_queue) */
>  {
>  	struct	wlan_network	*pnetwork;
> @@ -290,7 +279,11 @@ int rtw_init_mlme_priv(struct adapter *padapter)/* struct	mlme_priv *pmlmepriv)
>  
>  void rtw_free_mlme_priv(struct mlme_priv *pmlmepriv)
>  {
> -	_rtw_free_mlme_priv(pmlmepriv);
> +	rtw_free_mlme_priv_ie_data(pmlmepriv);
> +
> +	if (pmlmepriv) {

Not related to your patch, but this check makes no sense.  The
rtw_free_mlme_priv_ie_data() function dereference pmlmepriv
unconditionally so it would have already crashed.


> +		vfree(pmlmepriv->free_bss_buf);
> +	}
>  }

regards,
dan carpenter

