Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 898B55826DD
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 14:44:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232810AbiG0MoR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 08:44:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232340AbiG0MoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 08:44:12 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CF523C151
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 05:44:11 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26RADNpx010349;
        Wed, 27 Jul 2022 12:43:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=0Yq26H4ehgckzp8xDuSrl/Thp2Qz+4F4pC7WQUuO1fQ=;
 b=Oo3+ZPYGeQIL9+DDYlG19YNNV1/rr5Uz9KWuWTLCY7CNsovDyQC3poK1Gc5UU2ZdTKGm
 AIrw6CNzY/ujecMkEuL1gdoWRv7gmPkwJYOYuuDpA/4/Gp4I78MWp4HGwDJ2o9B5KzQa
 jrSG8uBdHCHWjpCZ0WEdvH8QSANVwebLRNGczwGvNNhmIhn3m/zgdhnZIGpHxfSITm7l
 R1x3l0B25r+4uZ9/WL/Piv5ExZtgf+QQzDdpeK4qEA29xYxaWGdpnzuoUawsoQmbyyXG
 N5VJcQ6syqRwJwLfo931Unkk3esLU1OmV/jFLxNGqq7KfQ+3e6qKl3H+Fv2iNXyME9Pl eg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hg9a9hf96-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Jul 2022 12:43:56 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26RAG2ag023052;
        Wed, 27 Jul 2022 12:43:55 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hh5yw59rw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Jul 2022 12:43:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ADefVXx9yOHZP64KrXfyOcTrKF+WM4rFsN63gc+eQUr09VRBENBaytPLIH1aE1LdMt2qGvQEgQRQu6kMz5yXnueE1epeR4p8+EvB1g8HiGXL9+dQnjlMxiT3/bHqWeQc7XRCXznqq+xEE8HfHmb/TC4UwcTJyJnvCXbZbRp1PLSUPgDGBNjzgrHGJY8rjLB2LJnl9FjbqyP4hE2n+MFywDyBFjCaUXE6sC6cJem5fHruac0w/XA1AMFHWd/IMRHlTgvovOrCvPvA9VJjut1qNUUHYaxiwN0cXP4OG4iMrtO+XtxwlX4fBP93qbEawxLnN23F9n3wyEirco1FK5Y7qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Yq26H4ehgckzp8xDuSrl/Thp2Qz+4F4pC7WQUuO1fQ=;
 b=CxW7Ji0nOmtF0xOQDt0LuHailIxhOcgNjsGIBsya099IDoJ9Pfser7GV8j+SIzLHBf+OIpNzPL/6ZjkY/obolqhQaCxjpVT4eAe10oCNOiUWpR4lG35fwh4lecemDoz6UwNS/gL4f4e2neg4N+o9KCMHHj4FaOZicQlAHMkPg/9jDEp7SWNsF0pv7FutScYdu6rtRl1+JtteJI27bG2U+/umRPFAfR25GOpG5ku9PRpFwCFq5a7A5gWISqhtEeFsuamqhp4edCx3syaWeQ/3nqFAZvryadKVP2TMbYOmJLldvRF0pN2MpPAnXsIY5x0lKMhBJ7Kxke11UIQP/1OgkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Yq26H4ehgckzp8xDuSrl/Thp2Qz+4F4pC7WQUuO1fQ=;
 b=zy1xvTcrjRJKmqpcGzIySTPCnYPj2HXkaaQJ1quAh6dTVI9mMKdlx1OjI02Xio+KiNrvvC/nsdtqoB478qFuZaOHcc4YDvleb6zjT0EcRCCNeguZDt7hE59Iw3VHcCNTW2HNdh5pEsmn16fzuzkNpdaZ7d6SyFCkqPPm1NTGRpU=
Received: from CY4PR1001MB2358.namprd10.prod.outlook.com
 (2603:10b6:910:4a::32) by DS7PR10MB5389.namprd10.prod.outlook.com
 (2603:10b6:5:3a7::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Wed, 27 Jul
 2022 12:43:53 +0000
Received: from CY4PR1001MB2358.namprd10.prod.outlook.com
 ([fe80::eccc:6ecd:41f7:ed02]) by CY4PR1001MB2358.namprd10.prod.outlook.com
 ([fe80::eccc:6ecd:41f7:ed02%5]) with mapi id 15.20.5458.024; Wed, 27 Jul 2022
 12:43:53 +0000
Date:   Wed, 27 Jul 2022 15:43:42 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Phillip Potter <phil@philpotter.co.uk>, Larry.Finger@lwfinger.net,
        paskripkin@gmail.com, straube.linux@gmail.com, martin@kaiser.cx,
        abdun.nihaal@gmail.com, philipp.g.hortmann@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: r8188eu: convert rtw_pwr_wakeup to correct
 error code semantics
Message-ID: <20220727124342.GR2316@kadam>
References: <20220725220745.12739-1-phil@philpotter.co.uk>
 <YuDcKoSibAo93a6P@kroah.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YuDcKoSibAo93a6P@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MR1P264CA0141.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:51::15) To CY4PR1001MB2358.namprd10.prod.outlook.com
 (2603:10b6:910:4a::32)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6b19404e-c20f-4c58-d5ea-08da6fcda927
X-MS-TrafficTypeDiagnostic: DS7PR10MB5389:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6IYxI9Wzb39eSdsN5rl7/YB096vVguTTX69NQil6bCokwAdzrVm41eCIaiNoBf0aZU/O5MWmDxnAbwbiR9mnkbBZSZiJM3nIO5d0pvuwc1i64I2IU8aRaa+XiPq9q53TYzeIMSKT2eJLaJBNcgAr2wL2GxP8o6fAhbUfGqwXUkfXw5nhZPLinpE8Mhp2GXBwy455BIPbBmJ2Nw4LqJfrGAN0pTZ5Q7JJQ+kZfQ7zCp4Hq6MjnNhT2wkDPRpzSAe/k1gKY6hClmdUXVTapkydnQymv4/Ws43S+csttDR1h6achaYPhx6QDwRn1DU/gMrotxdE5QGHgbLVawAUvTfGFHVtfJ8INqCLAs5JRqPmLD0saWAexB9gzcliR0/8VGXu/BH0ZBDExhIZMYDkRlCDr7vp6kIU3R/B5wmF2tTipID+DrtgET/xU86+ORNnQBfFJ7iMrkx3Z1T2xBeQD398yE450yr/WOrxuWhOxCSSPNB5OUKBIjqDX1c8B/5F/OL/nCSQWkl3GS08bh7nuKvJcfcWZZqM8HRMzuGmHowZdvxDDV/0zIHT80sYFbmHyR2hVrAajQyraw9cOU6OD+HdaYOaMjIJ1ijoV9iIzyt5EjZZJwgzfl7+c6AgjMPL+YwGEaRGUX9wGFm6RB9YohGlxBY/N/YOEnn3nLVZBiJRTPzdau65OXtozI4g9155Tz7Esb0omSC+IVVHMJRbU2encbsj/CCVS8fqWn7epJ40nv1lisBSJaqeEBbcVHGpn2kmRogkd4w9+pmzH7VukV/uR7gfP9jUfXpTfQf088VdY9z5mu3ZF2UsEKKCQa5/6rPt
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1001MB2358.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(366004)(396003)(136003)(346002)(376002)(39860400002)(38100700002)(6916009)(38350700002)(6506007)(316002)(66556008)(8676002)(33716001)(66946007)(66476007)(4326008)(6666004)(44832011)(6486002)(9686003)(6512007)(1076003)(478600001)(5660300002)(8936002)(2906002)(83380400001)(52116002)(186003)(86362001)(33656002)(41300700001)(26005)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1Mmj8s1VJshobKA2T0Gv4FBQ7nZqNFn5wWpCu5kYFgHfYWMZtAW9ATdVUGKH?=
 =?us-ascii?Q?X2ZMhs4Pv1IAWgeo6EjtA6Z1h70oLZOckGlQCELmed8kATxsco6cupxQcadA?=
 =?us-ascii?Q?5bY/q/wMxUgecROqNPS1DrI03i4xnKjauc5JFDZG+3RrcdCGz6a7hjjJhfSZ?=
 =?us-ascii?Q?mIlSe42qXadD1PzpA1njAucHSaW7X+gNAxahxhO7z//Z8HXYAp1Ws5XlZw+f?=
 =?us-ascii?Q?5+lQX+9CfmHPSLVYaVkpvq1GrWE+6MUrTkUlaefYOS9f8bA8dSWGrNFmCN+t?=
 =?us-ascii?Q?XL5wx1lAdvFnJjUvgqwbElENKrom0GBwiDBsKlUCE3p6Y70uODx/hhFng/H2?=
 =?us-ascii?Q?/bk0TRfVJaeyAmMaNtnKWqck9Lk/P8R7RKtrYKdounxgLG2krErc4Z+gH7c7?=
 =?us-ascii?Q?FppQCfX1aZscRBA+sbYLHNnouaru/+NaD5VbkJd5LqeSexB7ncu/v/QxWXrR?=
 =?us-ascii?Q?98LJTRA4DSfd6i4X0mfGrj14hP57MWmO9NDrJ0Lg3Pc9gJWgV5jxwZ6OMmPQ?=
 =?us-ascii?Q?bWxYYVllez1o+5pHrVhCeY9fdjLvm+TOTKWYGJnOKBoquiDNikInC4jshYTP?=
 =?us-ascii?Q?2cI4MdU6/c4YRsVIXnVB2nmXnvqQ2iyce8UXwVwbfo9oAk9Arh8q+iIc4bkH?=
 =?us-ascii?Q?eg1HzHjEOFnMUIif1HGUSRGMwIj7Yz0E0+KysbqRJeCSClt3iTo9DBM2zxlQ?=
 =?us-ascii?Q?QT1sfMFfHRRZGgJCvuYxlPdBPFp6mh0FX8YTWsmWmv1OG6l35g9KZPaiIJHH?=
 =?us-ascii?Q?oQ/pzCcwew8NbIppqnd51wYsh2PEgnzulPzZ7OBWkMIVCyJlJRGG8ItYgkrv?=
 =?us-ascii?Q?0Z3BpohGs3OYzu/c0y+Zcq/xsgOkykXs1F32ZjLz6EjwWLQmHj8rt+Sku34h?=
 =?us-ascii?Q?WZdfkzU4qERG77HMXmJ7I1p3SegQQx+MqzP317idDr7jzhEVG8ESu5u9QidJ?=
 =?us-ascii?Q?b8xG55JzSUdL7c0Lvf/1bWohWP3im6Ma10usU5j4wSsyEk16ohjeh9FnA3DZ?=
 =?us-ascii?Q?UfcxrnuLGObMp43p8+l3aDBdB42xgz5tdftVXCN0aALLyaxACMVRB8ulJ9yQ?=
 =?us-ascii?Q?4wlGWq/mnLTwJG02fnlHJkLEYQHLYAbZOgQQ72eRP3YOCU1ei0IjPJSbGV7Q?=
 =?us-ascii?Q?uXiNTt6Y6TQSbPkNnu6in/AG0/6wscZhqp3vmy/o1zK3H4WgMFh8GGN1Oibk?=
 =?us-ascii?Q?mDvICPV5CebXEiJJA3OIOqKS4WaDk8C38A4kV9CuZPVg5dwV+lg/8JgjE6Rl?=
 =?us-ascii?Q?oF7B6G1uioyaq0RSoMoX2YS+PAZ/iscfRM61glqAlF6qDufqdp6bu3dlBq2C?=
 =?us-ascii?Q?hHC49pP0aLOK7niHCa/xvbC0RZnPJ/Ukeyesx3OsbJZU0rBxFzxabEOVUbkl?=
 =?us-ascii?Q?JUUTQHYn8MWjwKqjmFsix/BV2ATVIdsC+T2lQ002vLLeorEy22yOQqSb/cdG?=
 =?us-ascii?Q?KXKBHkaPqSvHG/izhruLgyOtLZh4itPSa/haKRT6Oq2MMqtkKLL721aDPRNW?=
 =?us-ascii?Q?4bwVnNlxUo401yVSMeGBh9rkiEHNHLoi3Mgsde58gTA/FW8kEG3mRLP2zfFg?=
 =?us-ascii?Q?8MlYhUNh+GL1iWJoG3vM+c7nR18YEJ6lx08ldxYAg/aBDAj7USl2cWOPH70w?=
 =?us-ascii?Q?VA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b19404e-c20f-4c58-d5ea-08da6fcda927
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1001MB2358.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2022 12:43:53.3128
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3OoilCHQ2xLKMAZMB4eloDzctv5mrmnBqdWvmVZYn1OseoDiYClcXmQ9PCoAQADI74QdPWg2sBwGJw2k9JUla8fq5VO7EGVS7dyukt0xWGk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5389
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-27_04,2022-07-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 mlxscore=0 suspectscore=0 adultscore=0 bulkscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207270053
X-Proofpoint-GUID: rsXDJSyLpkYLGSj7GdEWtq_k5fYnRqcx
X-Proofpoint-ORIG-GUID: rsXDJSyLpkYLGSj7GdEWtq_k5fYnRqcx
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 27, 2022 at 08:33:14AM +0200, Greg KH wrote:
> > diff --git a/drivers/staging/r8188eu/core/rtw_pwrctrl.c b/drivers/staging/r8188eu/core/rtw_pwrctrl.c
> > index cf9020a73933..8b1c50668dfe 100644
> > --- a/drivers/staging/r8188eu/core/rtw_pwrctrl.c
> > +++ b/drivers/staging/r8188eu/core/rtw_pwrctrl.c
> > @@ -381,24 +381,24 @@ int rtw_pwr_wakeup(struct adapter *padapter)
> >  	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
> >  	unsigned long timeout = jiffies + msecs_to_jiffies(3000);
> >  	unsigned long deny_time;
> > -	int ret = _SUCCESS;
> > +	int ret = 0;
> >  
> >  	while (pwrpriv->ps_processing && time_before(jiffies, timeout))
> >  		msleep(10);
> >  
> >  	/* I think this should be check in IPS, LPS, autosuspend functions... */
> >  	if (check_fwstate(pmlmepriv, _FW_LINKED)) {
> > -		ret = _SUCCESS;
> > +		ret = 0;
> 
> Nit, you don't need to set this again, as you already set it above to 0.
> 

I would sort of prefer to drop the initialization and keep this one.

Otherwise it causes a Smatch warning about missing error codes.  It
*looks* buggy too, like it should be an error path.  Sometimes people
add a comment explaining why those are success paths and not error paths
which also works.

The Smatch check will no warn if there is a "ret = 0;" within 4(?) lines
of the goto because that's probably intentional.

regards,
dan carpenter

