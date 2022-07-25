Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9033A57FDB2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 12:40:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234551AbiGYKkz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 06:40:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbiGYKkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 06:40:53 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3307A616A
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 03:40:51 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26P9XgAc004813;
        Mon, 25 Jul 2022 10:40:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=xEGMB8Z8lFuOZOZ3T8+lOzd/JaotWgSAF+SdtbZ9ebY=;
 b=fr4ZvNNsKTrgJ3nTZCG75sujCynhtqfAkEUIOFZPRyRNV7LhPFrhuu1JdmyMwevdKtCw
 Csitrbw1Uz6gUfChcayichw9IFY2WrHVFh6QrxXzu1NWcubjekLGt6a+pG1SrkKzqbJZ
 Smh4nMurWdMUmmqtVB6VaGmIndRMgZqvjZqBO/P2uwNL/dsAKerqbtc+N4UdkxhH5YTl
 F/f/ENnahmwt2ytw/EX2xp6jsW1Sh7qiIDNNM4v4MseqYuo0CQSjPQWgLERTRSJMFTQC
 ftumwr1EnbykfagW2Oz/LAyaNb+i2odVFOvikMdY5/pnaNc5gfrUkhBFv2qbp3wRivxD 7w== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hg9a9axd1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Jul 2022 10:40:42 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26P8m4sW031493;
        Mon, 25 Jul 2022 10:40:41 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hh64qa9b9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Jul 2022 10:40:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z3kQ8XyHoTZ526z3K+18F9SMibaXaDPwB+ML0AgxoAcMI02rJPeapxCAdG8bgsXdh5/8s9A8o2DQse7BBbbYkl20NO1z/i5m5mohCuuQTDy7Qxoh81imFJeD/RERxxfvBbkVuH5sRxqt4ln+6zfZ/QTE226e6J1OfYK+AajrB/VHu2S2cYHXoePhapgeWfqxvCzPwRvPjAOJUfAJSn98yqCo3QC9pl3aojCTZo3Jv1fwNq8snUdMWGjY4n0KHBYye765ICoRdKHOTEO9+oW+lL8aOLehaKvzb/LAWguGOaQf5lehjNixYRnfTYzla+n76xvLnZ89DnHdZPlnv4YwGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xEGMB8Z8lFuOZOZ3T8+lOzd/JaotWgSAF+SdtbZ9ebY=;
 b=Vh0DSTKUcAONSLlBDrGfeOz9GpMF/a+bGBXW8j2cKtwNH+mMQn8fr96KUT6hfElJ+l6dGeAiDUSDheH7kpHqcXm8zWQkvxiMcJ3zD/zVp065OQwlBENmUTIVeyFgFzEqtWU0carB88dQlb6RY03EmQ5Vt702BXwoWIUaAR1l8UVaNQX79xVeLPyEoBcMmPACv8XsFJ0qTCxMpFdfHz/8UIjk74eJ8GUeagQQ8zATN44PcvId7f0xK47NvaOMUq1OdQ5Kz4Q84EQx1bLOJwQEq4y7YR2FAOiggAaRGgkvq92+3cbXfo51iD/fpVoElIT77yeP5E5OBXJvQLZtyKyTDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xEGMB8Z8lFuOZOZ3T8+lOzd/JaotWgSAF+SdtbZ9ebY=;
 b=a5lHpakJKUneMaowOn+ss/9RjixeYF8ie+dwU9Eq8nghJIlczAIClmIOaXBoLebosNGKzf430AVDq1jzhjtI97mG2QJ4OKXb1jmc5ms6YvqdQxggVtzPD+QXsxHKbqQvJ/WakRiPNEVakqxpkuRRtzuvJLR84TSN7bQpfUonTLQ=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DS7PR10MB5101.namprd10.prod.outlook.com
 (2603:10b6:5:3b0::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Mon, 25 Jul
 2022 10:40:39 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::24dc:9f9a:c139:5c97]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::24dc:9f9a:c139:5c97%4]) with mapi id 15.20.5458.024; Mon, 25 Jul 2022
 10:40:38 +0000
Date:   Mon, 25 Jul 2022 13:40:27 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Phillip Potter <phil@philpotter.co.uk>
Cc:     gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net,
        paskripkin@gmail.com, straube.linux@gmail.com, martin@kaiser.cx,
        abdun.nihaal@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: r8188eu: convert rtw_pwr_wakeup to correct
 error code semantics
Message-ID: <20220725104027.GO2338@kadam>
References: <20220724163055.961-1-phil@philpotter.co.uk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220724163055.961-1-phil@philpotter.co.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MR1P264CA0203.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:57::18) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1153808f-d57f-4ff0-c56f-08da6e2a1d47
X-MS-TrafficTypeDiagnostic: DS7PR10MB5101:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gGGtM+3f9JKR663n57Wp6XNJBZcjTQK3vjJ/hKk/XSNzYhBecyP4UKZcZbSPtp/F4w8X73a+RL+VNGjl+HfB9qAfEmDSOT2IkCOUUPk7XcUiDxKEQPvc5VtQevQPPGtbZswvyFrhYhraxSzWW1h77DEfQ0r1I60cECH3NZ3skZsiJyApXDJqLSwGYRke54Xisy2XAowDWHcH8NFw+KAWD6soDo8XTHyfdO7Et4eCj6aVDdX7uV5w2C0KmhYzyXuzaveTTpAeVfAKQlkyP0NtrSUiXXxnJLN5+UlRiPWEYUAN3uTculI900GAK3zvIHRBUGOShN0sKjhyd0tEMN0UYQzvX+4osapB0+Exv7qEu6onAzS1oCgV+ZLdASrMDyOLaTDWl0/AJ+6Da96j7TOBFjjHxrXdYrszn13eH8yPB2ekUhnXBchQu/6JHltHb3I62EYS8uZF89bj5WkW3jK/7yE7ni8BLgH/d+9vBBPgR7gvS7ttosTCY7LI2HJmXwutL2OuyE1vxWN9uPZ5rXCDReAJuNdUqgdeafAvkV/dQ1FRICHFv4MNcpfP3ikbQwmqJ58ljH5D3iKyXT7J9FSUmw1KUSfhOvkp16QDFnPhLrt0/AW1LfKwFhNs/Kffy1zEr6dCKZV1mx3WNA9B12IrtS+/A7XGD1Ke7FOTFITUkxhUKPWyRFysbVO0BTOW+FePgXIGO04wdCz85OMdrtAGO7Z7paObyHr7uMK6e9X+zN2KLti3nqsPa6EhkhDMfxWdPUB5+x5lmbFykFTIbOd5m5b16DtkJbPxxyLQ38g/dpo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(396003)(346002)(376002)(39860400002)(136003)(366004)(86362001)(33656002)(26005)(6506007)(83380400001)(6512007)(33716001)(38350700002)(38100700002)(9686003)(186003)(1076003)(478600001)(316002)(6666004)(6916009)(6486002)(44832011)(66556008)(5660300002)(4326008)(66946007)(52116002)(8676002)(66476007)(8936002)(2906002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0vR1TJR8Pe0tUDI49do4JL3871Qx2GBFgtIXZ/3AgmFwODZxom4jl3eMfjGq?=
 =?us-ascii?Q?PTNfhtqI0mWTpfAjYXbLxYeSQ/Oqd2fd2AbxMnrkbuDo9Dxf6lFxEF5yC2ob?=
 =?us-ascii?Q?5clXunxIgvXt+Nwmt2aGLhlz6boDxg6jsBeEYmfvwOmAKQuGPbSs8CF3qMJI?=
 =?us-ascii?Q?di6BEaKHpTiXt9YhjXjxiIAUR7fOE/sV2SLSktHxBapfu5DxB3flUTJbYaAH?=
 =?us-ascii?Q?VXgNP6jQlMXqrAtg/Mhwe4Lgo4UyoDSY5mGk8zBzRcPFB1+03IpvbRPHOJVx?=
 =?us-ascii?Q?GKEZYTJycYlc5YUXe+qN5IAoU5avSvVZZMOgKGM4g5YWvakqCaWFkHQqH3Co?=
 =?us-ascii?Q?9Z6J2H8JVRScfEeNvZKHsR/rmwYYHL0GXV7MBHthMpj8taYD1Qw5yWZ3ywW+?=
 =?us-ascii?Q?0uazQqsgJ4lJADxCGMd/g9lS2FC7jLrRZv5yRjJ8uFn2+v8Xwki37DVeNjoC?=
 =?us-ascii?Q?3eWxl02Z7h19cG1ZwEDdee1KiZSZtQc45EOmBDIwC2mOSAdgwbUODp1Y0/oD?=
 =?us-ascii?Q?lmIi5ungwv9mi/WQcyhEWdpsk7JLHhsj0aH8XfLFKQuk3CMluhdORsm5B64N?=
 =?us-ascii?Q?C1Y6Dn/D0xRLL632h3eX0e2TXdWr+sOoVnaXqLMOJFTNmibjefNdAY0K/Aih?=
 =?us-ascii?Q?ROTfseobyFDFSScNz2q9L02ocJB7lJdGH37iiBlbtVLc2u08byGk1noYqNC2?=
 =?us-ascii?Q?TFumuxP3UjbtxbUynnu2OZ5TaLAYlGKqfkN3nO3+9viA3gpLsyp+jH6G7UBK?=
 =?us-ascii?Q?gkqfRuzflnFw56EEWYpWQJMNIJA5Ibiy0D+fjj4IYX2j8Qb/Tt07iTs+8sF/?=
 =?us-ascii?Q?fyolgjs2Rd4G1oBtH0H/qzeO8f9iGSa3X27k1b12hkd0Nmwr+eUBDNn15Suu?=
 =?us-ascii?Q?1y/3NNiksZEjflADb2PVKHNe2COqDwfC1sdop5P3v70FoNXUojxhGf/xLoVt?=
 =?us-ascii?Q?N4zGOTqxHtStj9hlRBlAg++1niw6wJSeqsHl17VMIO3/C2Eb64s7svObh4JF?=
 =?us-ascii?Q?nn1gDCKldzSVDpKSKI+goQAL2WEBIR9UkhWPsCoHtPpbsZt0HraLXTDZUrjI?=
 =?us-ascii?Q?JFcqbg7eNaUlFrugkXtKMHRkUBOTHzyE40u2c6RvFnCn/iJubdF/Z653Hx4b?=
 =?us-ascii?Q?mvGmiFBfwVQwM2dA8KjEga1m8BoRMV5zU/EmBXb6dspwoY4g0iSJtOgimPi/?=
 =?us-ascii?Q?qwipeE9DT5cXTqfoBedRA7hqIe9nBgX+Zj3yTxGZPJPIxg5aqGbBc8hBXVXn?=
 =?us-ascii?Q?4Mai1PTTyhtWL7gNPiGhLIuaarhNRLDr91rogbuLjfMIXo/ZRdHbaP5Q/DEY?=
 =?us-ascii?Q?hhe8SPkdW636KK0YJWOx+Hi6DjvGpyh3BeiNc8wk3Ei5plLGPvDfI4o+t0zZ?=
 =?us-ascii?Q?lIIpPrPC36zaM8nho2RYXl+vahyTbv6+A5onJal108VfNJ6/g+JBCi1YFNCz?=
 =?us-ascii?Q?KspvJ036DMFByUCn7Kl8d6jhn8i88ij9fzWo43WWoovCA5PmrR7gs9JMkvCl?=
 =?us-ascii?Q?JrmJXnp/WEoxQK4HSM1w8ANglOv88A9pX9gfSp3/eLz/HnWZOsFo9aSCdDax?=
 =?us-ascii?Q?06Cnjk/NJgt+s6tTMCf9cpLP5TDkyUquNYn4QkI4?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1153808f-d57f-4ff0-c56f-08da6e2a1d47
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2022 10:40:38.8552
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LLEepUD4o3pHmnxfqr8RJ4O3N+otPfswNEQlW//xjNeF6BBLTUI7/4n7JA3qL4YhyMz2ST5Pya//gnyuAT+Duo8dCjdDp1aJKCE08myX0qQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5101
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-25_07,2022-07-25_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0 bulkscore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207250044
X-Proofpoint-GUID: 327FtwRuqs2UUDDJ3thptrfrTnSzSsYi
X-Proofpoint-ORIG-GUID: 327FtwRuqs2UUDDJ3thptrfrTnSzSsYi
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 24, 2022 at 05:30:55PM +0100, Phillip Potter wrote:
> Convert the rtw_pwr_wakeup function to use 0 on success and -EPERM on
> error - in all places where we handle this response, we use either -1 or
> -EPERM currently anyway, which are equivalent. Also, for other places
> along the same call chain where we are using -1, use -EPERM.
> 

I can't get behind a change to -EPERM.  Try to pick an appropriate
error code.  I'm not going to be very strict on it, but we have to at
least *try*.

Probably, leave the return -1; lines alone.  Fixing that seems like an
unrelated change.  We need to do this kind of change but I got bitten by
it before so I want to avoid that next time.  My reviews will hopefully
be more careful now.

> This gets the driver closer to removal of the non-standard _SUCCESS and
> _FAIL definitions, which are inverted compared to the standard in-kernel
> error code mechanism.
> 
> Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
> ---
>  drivers/staging/r8188eu/core/rtw_p2p.c       |  4 +--
>  drivers/staging/r8188eu/core/rtw_pwrctrl.c   | 10 +++---
>  drivers/staging/r8188eu/os_dep/ioctl_linux.c | 32 ++++++++++----------
>  3 files changed, 23 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/core/rtw_p2p.c b/drivers/staging/r8188eu/core/rtw_p2p.c
> index c306aafa183b..bd654d4ff8b4 100644
> --- a/drivers/staging/r8188eu/core/rtw_p2p.c
> +++ b/drivers/staging/r8188eu/core/rtw_p2p.c
> @@ -1888,7 +1888,7 @@ int rtw_p2p_enable(struct adapter *padapter, enum P2P_ROLE role)
>  
>  	if (role == P2P_ROLE_DEVICE || role == P2P_ROLE_CLIENT || role == P2P_ROLE_GO) {
>  		/* leave IPS/Autosuspend */
> -		if (rtw_pwr_wakeup(padapter) == _FAIL) {
> +		if (rtw_pwr_wakeup(padapter)) {
>  			ret = _FAIL;
>  			goto exit;
>  		}

Fine.  The caller now changes from negative error codes to _SUCCESS/_FAIL.
Later we will transition this to normal error codes so we'll update it
to preserve the error code from rtw_pwr_wakeup() at that point.

> diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
> index 930bb4aea435..e0ae0c3c51f8 100644
> --- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
> +++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
> @@ -689,7 +689,7 @@ static int rtw_wx_set_mode(struct net_device *dev, struct iw_request_info *a,
>  
>  
>  
> -	if (_FAIL == rtw_pwr_wakeup(padapter)) {
> +	if (rtw_pwr_wakeup(padapter)) {
>  		ret = -EPERM;
>  		goto exit;
>  	}

This code is returning negative error codes so it should preserve the
code from rtw_pwr_wakeup().

	ret = rtw_pwr_wakeup(padapter);
	if (ret)
		goto exit;

> @@ -933,13 +933,13 @@ static int rtw_wx_set_wap(struct net_device *dev,
>  
>  
>  
> -	if (_FAIL == rtw_pwr_wakeup(padapter)) {
> -		ret = -1;
> +	if (rtw_pwr_wakeup(padapter)) {
> +		ret = -EPERM;

Same.

>  		goto exit;
>  	}
>  
>  	if (!padapter->bup) {
> -		ret = -1;
> +		ret = -EPERM;

Unrelated.

>  		goto exit;
>  	}
>  

[ snip ]

> @@ -1252,13 +1252,13 @@ static int rtw_wx_set_essid(struct net_device *dev,
>  
>  	uint ret = 0, len;
>  
> -	if (_FAIL == rtw_pwr_wakeup(padapter)) {
> -		ret = -1;
> +	if (rtw_pwr_wakeup(padapter)) {
> +		ret = -EPERM;

Preserve the error code.

>  		goto exit;
>  	}

regards,
dan carpenter
