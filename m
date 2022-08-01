Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2D83586577
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 09:02:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbiHAHCF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 03:02:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbiHAHBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 03:01:47 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C39EE2A956
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 00:01:40 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2716xQTE003541;
        Mon, 1 Aug 2022 07:01:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=x/Q03Umyno/2hBnd0Ky44SNczZNB9psDAQCrdY1t1NA=;
 b=NlX/yDvmxG++EmkkuhY1qHgpX2h61mWEDqikfZUQO8e7kXbQaJOQ98479BE6ORKW+G9A
 GN7UOOa50vMrKNnxGEPiQ1fCuah9Eop3mbIXkcJc+eD6ZyMjhX+7Bqw8lfUOMtqzMuUG
 vFPoUt0kOsDs19ZBaxxsvJfz60sKfw57q3aan8dgUVCg9hnR1kdo7jxLSWDuYzyCQxE6
 DHAAvoe+TXt0cg8CVAVmC8v2+BprOEBHmpr2dDVzLttEPAIewTElIULz+y+2Qv3LnDo7
 L4Qc6Rz2UtK7F6/V02RXk2/0q/D2uzHLTSaS7kghI78m+ssVg17K2fSSb+8WfDy1jGm2 5w== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hmu80tpuh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Aug 2022 07:01:23 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2712akJ9003283;
        Mon, 1 Aug 2022 07:01:13 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hmu30yve1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Aug 2022 07:01:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oMG7X32/OHWl3utINc5CM+raak4kempAwS0wc+dy5uIX3XDbx7FSygMegHzkpdeyHQHsfyb5l2REKnH5XzWl/Uo1kwLBYm2SBL4+WXgKyjZ0AQUHALafXfA2NIU/wjgiCfaIALJemz+wL/2QqgKX3czlQlMktpyk2Ryn0kwcTPRFH6W3TCjsM9lsG0qbAK8uca3LgYn7SFXPkOhbUs0SooAoW98IMGUj5tDMJ2eIV5D5sp1E7UV505eyc83LGMGesg/lDEvQpl7jDys+g5qtET3vTjz5nniKf3KtHxwEgBrGhMkI5WmCRypWrDKb5kzeVrA5lcXFF5aT0Kt/HVe5Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x/Q03Umyno/2hBnd0Ky44SNczZNB9psDAQCrdY1t1NA=;
 b=Moo+iiz2EC3+QpzAFya2SZ8lmaeufR1yB+JGS4wnS8zk1l8WGLxhyqQvD6s2d3hBw9XLAKnPaxO6PCYy4xkrIfQGsihTKGyvV4A/AfXnvXYn12sznv2CuzT7X+PZN/yUbX/KJgzcw8MHMls2OQhsoFsJ0LHHt7WSH2K1dfEBJp8xij8YRRnL/9sJuu4AEpMc4n+uH+2JF0ZL/7sWyQ3hnPA+4+76ticO7mgyjWRGNhD7bAfZQIw9Na9tqRgiAmRtww/IxsQawejmYVTw4zHmisHX2PtlmHQvUoUwtYq/vODECRcw+5aV93b2HGPfDSIaFi3WSM/t7nzMOTl6E6ul1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x/Q03Umyno/2hBnd0Ky44SNczZNB9psDAQCrdY1t1NA=;
 b=ODBCbV67gd0GxQF6qdLSPEUfIOoDqxgvqQnIWfFUChnVj6u4JjgJFTzvW3onajvE94bPPeNORLbbUNwQ4RfCzr+NhXjPQ+UjA9D5Di/jCjBDYECFZos/w+C5fy1KZPbet4WKq3KfOkvQl9GADCEwW4rQFeOuhV+r7UlT88c6aGw=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DS7PR10MB5200.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.6; Mon, 1 Aug
 2022 07:01:11 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026%3]) with mapi id 15.20.5482.016; Mon, 1 Aug 2022
 07:01:11 +0000
Date:   Mon, 1 Aug 2022 10:00:59 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Phillip Potter <phil@philpotter.co.uk>
Cc:     gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net,
        paskripkin@gmail.com, martin@kaiser.cx, straube.linux@gmail.com,
        fmdefrancesco@gmail.com, abdun.nihaal@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] staging: r8188eu: convert rtw_set_802_11_add_wep
 error code semantics
Message-ID: <20220801070059.GA3460@kadam>
References: <20220728231150.972-1-phil@philpotter.co.uk>
 <20220728231150.972-3-phil@philpotter.co.uk>
 <20220729064803.GT2338@kadam>
 <YuV452xuR1S0WyJi@OEMBP14.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YuV452xuR1S0WyJi@OEMBP14.local>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MR2P264CA0112.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:33::28) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a933e809-ee9d-4089-e69d-08da738b9d95
X-MS-TrafficTypeDiagnostic: DS7PR10MB5200:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DwcroXnlNTG3JCHnYAlrsempA7pF66ZGIdbYonkYY+EqqWutyuLckDa8C6rF2WHip3YWgR1pQ+aLxLmkHkGuH5gbVMfCqZuRoa8nUZVrYsCFjwWqDXJNdtZj+PaKrXoHxMSeliqifMuyqNVpC1I2vgZGP06FEUfe+O16/jqvTtE7Jl5Ztt7pNcKhY70u27Rmxz0vnrgXhjLAVKD8swk1rwvSvgLAd4clcQl+9MJ+pBDJmb9wc2kBypGkPSoEN/tgWIUjqMIXrSgNEsyWZHCiKqgMJxbIg4KCqCSZ9TjoxGKyW8yMUz5aDDqgYjWrChVFPezDqRahqPDybEVAYbmeo3nrU/+9ILD70HadDli6Ud+56JPGg8j8mipj8BUA0K4OcYC31idOuVEWvTiFIrPqahPYvTw7eZMc+WvCyLs/GVRy9LBUgMg6rLbez53F0O6YHHJMMLETunOmHwj76nMrppv4+EqJRwXFpIt6rMi+yRxu1a9z8F2oT155pds2zRDLd3xrm53AcOZcN+yofR3cGI4bfIgR3tmVh+RcSzPGnLolm29gVdiNxMSfqBgIwCiTLV/xYlzojXNVL2fv/gw3R5TiVesZWXRxM4FvwsDVyIKty30pkeADZSEn/ydxm61N3D9qcS9405tqBiG3nB6H70kDhODsMchultkbagoBZ1EfTJQ9PzQCYg+lU3gJ0m9hcj6DVKyI+1ebwrff4eGyasgkYO74WDsHhWK0dSq/sPl3C0Xkp2vWhGODxxGzw73/zKZuYy4es2Nnijf50xVSLdYYZ9Yqp94WTMOkIH/vsmQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(346002)(376002)(366004)(396003)(39860400002)(136003)(1076003)(186003)(6506007)(2906002)(6666004)(52116002)(7416002)(41300700001)(44832011)(33656002)(9686003)(6512007)(26005)(38100700002)(38350700002)(83380400001)(86362001)(33716001)(6486002)(6916009)(478600001)(8936002)(316002)(4326008)(66476007)(5660300002)(8676002)(66946007)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XBGWuZXK3s2Zdl1DRWNJhtN02YvgCwiEhIHLXG90nmprO2xKjqDVHsSHSnSu?=
 =?us-ascii?Q?v1VEdtdy5QWqJWZ+din8pU4aHzlG2ipwSDV4Ux+9tTwGsSYxyjRs0rFE9zjQ?=
 =?us-ascii?Q?UNB4bKNqCQRdFrcYu+KQ1PZWhfY9gg2OgyHUDAjQm/Rsmz3uxRUKLtRqsYbT?=
 =?us-ascii?Q?TbWCbyCyjNXbNU/wlZdnh5yM2C25uX3OcMxYnhgcJBJaeAWS45k10dujaQhh?=
 =?us-ascii?Q?ojBnUB9VsH2XpGJWNcK5GpU/QP6jySRD8+JntMwwNZPEbMfUDzN/wK8WIpg9?=
 =?us-ascii?Q?2YcIpFvFJN1xPpumsRlRoM/XAs3hwYo/aN93+3LlQuDdTk1ruAHmIt4KJLCg?=
 =?us-ascii?Q?rO8SV5OZ4gJwMxUQ+idyZNO84aL0kQGMHYBKrnxnSagZN3+1SqhYeMuOdkCC?=
 =?us-ascii?Q?Ox0fxvSWTdthY5QDycUyrXA63B0EsM0w/a0uDHWU2r6VHr09m9euMugPdx0+?=
 =?us-ascii?Q?S5GCcRvmAS0Ejj6ytoLBwkNKfTG9lyicfwEsbzWIIm+A474IPehrxMtaHMa7?=
 =?us-ascii?Q?E2TKCDXOn94UGL3hf6bQwQmU8XgdxDmszsjbD23Vg4k+gzrwcumpufwTJQhe?=
 =?us-ascii?Q?PKzf1ZtXbkgx2RB7+D1JDvXiOJem+U8Gu4xNTc9TeOa6iaaH5Sa178g/zLcT?=
 =?us-ascii?Q?NjK9CVG6TeInCpQBZgY2IUDbdQozmTvr4IOSWmcLCXuDjNyKsO/jvOLL4USu?=
 =?us-ascii?Q?9DS9+hM3HXF6XIWwmKgxKldguwfLiYbEEXYFYOdbyiHypmEj7I8Y/OmV5uqV?=
 =?us-ascii?Q?NDivMjZPVKwUq9GYCXvbDm2iF2VKWCrV0fVe60B/b8Jtx5ISAuefUKiLWIuc?=
 =?us-ascii?Q?fVtCijxefIPlx34ro85jR0LYXEGgGMkXFcIcOrJc2QpShzX0Rz6aMRBm6zZn?=
 =?us-ascii?Q?9BlpbIuNiq672R8I/nuiyZ+xoeNPeSp8l6hUPLcBTjIeoQOmbw5hENeTgV5w?=
 =?us-ascii?Q?/FCYz8eVy/Eec0/oZ4JA3tHXAuZ8npxoSnB3Ff3veIm8ghzDf0QNX3RFsGft?=
 =?us-ascii?Q?6/73Nd4G2g4lTEgaV9AQcIdDn6NmyGy/wW20iaB5bUJXPHVqR3SrR2pmKdKu?=
 =?us-ascii?Q?N26JyuWZt4sgy/0E6EktisIJ7fJkw3lS8uZ395rO43M+G6plUxo2Dk74G/s3?=
 =?us-ascii?Q?Sw8LtfKEwcnzADw5pDeZ6eiv/eZHdvtyvwsdNzb5bq3qZqzWi533H0vTjj7I?=
 =?us-ascii?Q?Ti1rPybR8Ini+iGSqOCgMV5DIf/F2StD5VtrXkwNkS0VpD5XWPk3MHbXNoC4?=
 =?us-ascii?Q?zXgGX2Hga7tnmis28cA9LM9UVeA2qof3/t764Q7K7EXKMr9IP2mOH5mXyWPb?=
 =?us-ascii?Q?Z6rdGlEpmGr5IE+i3QqSiyUNgw+ufZQCiV9fi0DaA7qLJy3UtmSX3fjSHrsF?=
 =?us-ascii?Q?ad3M9behg2D3dMSwy/3ko1uCDRPAPr15iDI5bSedJQQEeuenCa6rH2035xiU?=
 =?us-ascii?Q?C/BAErHxV4hcAGgx1CIEUGSR7vWcCUS7e6OJMF1+UJPLR2GGwBp+OKcR4y4k?=
 =?us-ascii?Q?Kf5B4leQzRS1An4uI6VsMFFORDChGd24mqUlHaCSvRPfcaKCEeUlpCUQdg7B?=
 =?us-ascii?Q?ZeWXjjvWHWvQ3x8TMebSF5PUoq5ApKn27ydhYdJZ?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a933e809-ee9d-4089-e69d-08da738b9d95
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2022 07:01:11.1122
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yYxsWc1mesGlmv8TCwr/9MAUGJDcJtHY0nEMLcT1jnlAUxXkiqGLCGzM4VO9bWPlCDVxaR1lp3wsvhhdV6rQQK27gT4w//XNqxIyp3OSwDQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5200
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-01_02,2022-07-28_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 phishscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2208010033
X-Proofpoint-ORIG-GUID: FMTGsynb4UZOEq6eWJ5HWYScMq6i7Tfy
X-Proofpoint-GUID: FMTGsynb4UZOEq6eWJ5HWYScMq6i7Tfy
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 30, 2022 at 07:36:57PM +0100, Phillip Potter wrote:
> On Fri, Jul 29, 2022 at 09:48:03AM +0300, Dan Carpenter wrote:
> > On Fri, Jul 29, 2022 at 12:11:50AM +0100, Phillip Potter wrote:
> > > -u8 rtw_set_802_11_add_wep(struct adapter *padapter, struct ndis_802_11_wep *wep)
> > > +int rtw_set_802_11_add_wep(struct adapter *padapter, struct ndis_802_11_wep *wep)
> > >  {
> > >  	int		keyid, res;
> > >  	struct security_priv *psecuritypriv = &padapter->securitypriv;
> > > -	u8		ret = _SUCCESS;
> > > +	int		ret = 0;
> > >  
> > >  	keyid = wep->KeyIndex & 0x3fffffff;
> > >  
> > >  	if (keyid >= 4) {
> > > -		ret = false;
> > > +		ret = -EOPNOTSUPP;
> > >  		goto exit;
> > >  	}
> > >  
> > > @@ -424,7 +424,7 @@ u8 rtw_set_802_11_add_wep(struct adapter *padapter, struct ndis_802_11_wep *wep)
> > >  	res = rtw_set_key(padapter, psecuritypriv, keyid, 1);
> > >  
> > >  	if (res == _FAIL)
> > > -		ret = false;
> > > +		ret = -ENOMEM;
> > >  exit:
> > >  
> > >  	return ret;
> > 
> > No, this isn't right.  This now returns 1 on success and negative
> > error codes on error.
> > 
> > There are a couple anti-patterns here:
> > 
> > 1) Do nothing gotos
> > 2) Mixing error paths and success paths.
> > 
> > If you avoid mixing error paths and success paths then you get a pattern
> > called: "Solid return zero."  This is where the end of the function has
> > a very chunky "return 0;" to mark that it is successful.  You want that.
> > Some people do a "if (ret == 0) return ret;".  Nope.  "return ret;" is
> > not chunky.
> > 
> > regards,
> > dan carpenter
> > 
> 
> Hi Dan,
> 
> Thank you for the review firstly, much appreciated.
> 
> I'm happy of course to rewrite this to address any concerns, but
> I was hoping I could clarify what you've said though? Apologies if I've
> missed it, but how is this function now returning 1 on success? It sets
> ret to 0 (success) at the start and then sets it to one of two negative
> error codes depending on what happens. Am I missing something here?
> (Perfectly possible that I am).

You're right.  I misread "res" as "ret".  It's another anti-pattern to
have two "ret" variables.  The code is fine but so ugly for no reason.

regards,
dan carpenter

