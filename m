Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8B1850DB12
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 10:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237059AbiDYI1K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 04:27:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235451AbiDYI0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 04:26:38 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7779313E24
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 01:23:19 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23P6KjUv031587;
        Mon, 25 Apr 2022 08:23:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=Lqf7UWw8YXkf6BlRMq39+2hDq2yB22O1MHQLbe/Sqxc=;
 b=UCHRxgUSVaa+WiMNGcg5y63itURIDuNXnCmNrgQzKZj78gQYn2jJGjYiI4c9G/C75yLS
 ncGjo8dJqA8CL+cxM414OnHsCzKdXaIIe3HQ1UWp3aTbWDeqApVNnf4MjLotj/KO63Kx
 C/WWlY/RBI9zyqGio7GXuiJcqP4AVV0yzG3glz86BxNXxG4EqLRk8lTcmAMOyq1epH7j
 YYDKIIft28y6oqtyhvEHIa3TUK88ixj5ElIpsUu4k6MtDkLbivGXUnwZkOrTytdhTMgb
 0NrjkBEKcU4ET4p1Fr7Lkzybs+tnxjLK9ACRCKafs6UdyU6VLUeF2cd8GAB0Lje5ZhPh 8Q== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmb5jtgqv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Apr 2022 08:23:07 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23P8Avse010161;
        Mon, 25 Apr 2022 08:23:06 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fm7w1wgph-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Apr 2022 08:23:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZizYH0ARyvIT7o8VoqRBAIHmSv+79AyNY5VcD9SXXsNCC1jLzMaW5eCIxs/7XzexJ3eXezhZO+dzUrPZ47vkIwcyUsmCHClEI18O3MSDhA6ATr+WMUd0oN3i4G6Ivuxdt5IK3cTp08/yN+EIy4ajutXO02EuUZQbRT0wTH2PE/TpRlXVkmDbw9XnPqm3l09wzK1nn9LUtMtTRvHvTjzXvySQgyCGF2KtyLgv6RxjvA1wCsdJiBPLYA39B48TanJulnhoHjpDnVuHTDUtkxGyDjLhJGQfUfyWgZ0bNmgDAolwwjf1QHoFceHgkYSST2JMLywn5eChhdmdd1z4w780eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lqf7UWw8YXkf6BlRMq39+2hDq2yB22O1MHQLbe/Sqxc=;
 b=mxRQiPzs6e23FctCuJVvJl+sA7fqmUzuWq4BKDhZ+hX3IuSg0M95w7gxKVR4TkeGrIYeV5vFJ6G1bHNE88rd1NgNQQNKOO+wH4P4QK87h4REbQhomeFXtCpgIbZDRAnUZ15jqZl0b2s9u3kQz8i1FgY2RXTeFscQg+kf3Ch9wsTLtCb/wY3Vk5+hzzmCPhtXMXc2CX+VDlTLn0ugxJq99yxH8SQpk6/mzOJD1FouIRDF0PcOo9c4dX2b76RsbmmO5SdqIY/jBsoQECvImUKCInvdXM5nnIbgvHmX+jcwEs9Yx7O8EPfK+9v/UcAunT9ZPftJMy66MAIZQdIUbrksvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lqf7UWw8YXkf6BlRMq39+2hDq2yB22O1MHQLbe/Sqxc=;
 b=qPPmkeYNEeksCN/JCeRRF9iONzb404c5BqQyZwojkpg/YnhR/jXVKwxGSy418t8AlDSYrPmJJal+meooXn/U4LucnUkuEGKZorReUXR1MCCFd5mxwNGL5/6hVc0ipxfaXKdnhlR4v1fNkQ/38UTPpiPZDPr+LdQpsNirQ+rhXm4=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DM6PR10MB3434.namprd10.prod.outlook.com
 (2603:10b6:5:6a::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Mon, 25 Apr
 2022 08:23:04 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87%5]) with mapi id 15.20.5164.025; Mon, 25 Apr 2022
 08:23:04 +0000
Date:   Mon, 25 Apr 2022 11:22:44 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Vihas Makwana <makvihas@gmail.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Pavel Skripkin <paskripkin@gmail.com>
Subject: Re: [PATCH] staging: r8188eu: fix a potential NULL pointer
 dereference
Message-ID: <20220425082244.GK2462@kadam>
References: <20220423184745.21134-1-makvihas@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220423184745.21134-1-makvihas@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: CT2P275CA0039.ZAFP275.PROD.OUTLOOK.COM
 (2603:1086:100:a::27) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 24f848bd-1476-4514-a17f-08da2694d17e
X-MS-TrafficTypeDiagnostic: DM6PR10MB3434:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB34344BBE83705AD212F213838EF89@DM6PR10MB3434.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mEzg3gI9SxT8RCtMZ8pW/kM1sSYBU7jjYHnNnmLhtyuuosT+5YGRJn1LHF54LQcOYyuLPJKnCemajB0bKXzzA8J3qVOmJ3Y3EFGHgc9DuEK0IJDNpBY9NMl1+TiP1PJFSZyHgF0sTgpX64/kb9/f8ueo/IF5sFYjEMTgrPVMGvoutM+aw3VbIgesvHT2pDL452FSiDNfduLLd/DlGyFYPyD9UkCWTaTeGu/P1k0yQyAwCTfOTGNcljnDwx2oQEOc4+hbOAVTTmNTerA9dchTVM6dtG/OZGNtEFHsJVrvnZEw+H2PQuMJn0gkWxPW2iXk6oF1PBY+puTiAqCXiJ3gTYCKzrVqY0i2lWMEwlls/vLfFNvXXmtJ/e2phHd5a7iGOivKq3lQcNe4w8NmHuJ78lUA7greFzcuMo3eeQ3l1nipsQKFGlyUGFYaxNZRTcNUdcCSN/4ObBhALzdhVMPd1hoXNFy0NNewt0waRjqglYcg+j6T24xtNS1n87hwPXcF07xEuIx4qeJ3wujwX24ine7puhG7nTp+yJ7x14mBCNQI7Kx9SGtFRP9/Aup3p+QNgt0BFmMFJwOfxFoeD3p2uEN3wTSPCri4XcLGZlwZ2naUd3B+trSRo/cXQaOVihEiN4kEa/IKAZH2uEVzkk0TlymwpNB+WN95LSXcTW+Y8JLHoQXQAzv2gCot9abomAe1xzphpwZVMzLwa4pkry1ssw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(5660300002)(8936002)(1076003)(508600001)(2906002)(186003)(33656002)(6506007)(26005)(54906003)(52116002)(86362001)(83380400001)(44832011)(38350700002)(66946007)(4326008)(38100700002)(33716001)(6666004)(6512007)(6916009)(9686003)(66476007)(66556008)(8676002)(316002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PKT6mVdXIaSajd6udgejb595bHxALkXC9K0UbVt32sSWUUnCPa/0Uu1x1z4o?=
 =?us-ascii?Q?MNSZb5gc7z+ZVgLK2xAVovgPYxDVEYuhJ5ZMInWL4M6AKoY9xfbNAfbHURj+?=
 =?us-ascii?Q?Dfpe2NyuHJ2Vurb+A4ccf8QLY/wzvuxdJ6Lc3nm/OYNcIzB45OTGxvJZ7Ygo?=
 =?us-ascii?Q?Fhl7blrqsl/J8aHrg0f4BSV+/UMaJH4SzKLApiHzY9kSmpF5PZWhRb61PUJ0?=
 =?us-ascii?Q?UT7a+OB1b50ZwLIbR/lAmIAtdfrpW8YM3m3FkyKCD9hGWbqTXvKO7hG6QOXb?=
 =?us-ascii?Q?jumIEUoqlSEOgE5S1BKtcCPhhswO5ofW9hNoBeJGFxyethvzv254VvGLCHjH?=
 =?us-ascii?Q?4yFAtv8LV3GB9VIFmdWozeh14rL0ePoTdGhVKDpDZcEeorihAxtwGXZy9CI9?=
 =?us-ascii?Q?UvDHxEKkjqbKkr0jg5+0RJwhtVkkQa6Ku973Dc3CBObamDXjbvuyGGkKKToI?=
 =?us-ascii?Q?rs5LOHf2PNtobZ0zaLRZsPzVkFGfySa5BQpjbNGtXN7FZRCim/MCKoSMR1Q8?=
 =?us-ascii?Q?36fmUtxDJW6E1dVwQGsqsqcF36IljjCDsFmtS1cwoMQDq3eDR7ZusSWe7f2s?=
 =?us-ascii?Q?tPdFNyet5GAvtFh5xtQKCcQbxpOAOhZ8X9TQ5ZcDgn0trQ1wrqSoM0InqZ3Y?=
 =?us-ascii?Q?EAnLQFQCZYX2VU6crUXX47L+200Ww2p4MslBuyZK6g67eO+fhjsqmCfAX9Xa?=
 =?us-ascii?Q?sBv6N1x0GFsbgD5OETq2T0mJ76FoR9msj6aNk5amuhOCL/ubIcIF4jYZlXvl?=
 =?us-ascii?Q?QkcTTGJQVzL1kR9FRYHBjmnhYF4WSRMAlywe8GnbFJArZtadbKT2b+gi9SLq?=
 =?us-ascii?Q?2zzVBJ2mMaqvp8MY4tJYXQVcx+3koYYJAky00LlrLESYFvmLEysmzMmwJJMC?=
 =?us-ascii?Q?eyu5u8xygAobLXRVSVziZHb8BWb8RgeSpTKoJs5l2i7YkQino/TOjiX1lokP?=
 =?us-ascii?Q?w4Ry35IbA/4tluDqbtyaxG9RdeMPlzLniTnAl7lNYFFGKEwM/JPs5qPX/ddQ?=
 =?us-ascii?Q?3Xx1B3mnLuhIWryn3DgYW3HZKk1rf+CQjdGGctyu26MtcQhTzV2MtemPARb9?=
 =?us-ascii?Q?DFVURREU8BR8mxioRGRgPDozSzAnDqWM1La6nmPIAmmXK1aIrrgqFoVX6NYA?=
 =?us-ascii?Q?sd1eQrqKZ2Q9pZUFoSCq/TlRWn29DN7DtI+Cl7vn3HisqK1+nOmFHwgyBFSN?=
 =?us-ascii?Q?VparvNJ5w6vnvZq/KkCdqyoOzkPPtTfkbX9A1JxNPdtuv0u6uGBxo/GIYLl/?=
 =?us-ascii?Q?K9SD8oBNVMWOHN1bQG86YK7B//MjamXsLa/kQVMkERMV0LT6SBFoSe2UyFHH?=
 =?us-ascii?Q?L0MwMxJtQUl9kct1mgKZpJh0+VftFzB1y8FEddU/5ahOMNheI/nuN5Krvadd?=
 =?us-ascii?Q?/6m0fMI+Ryw4NB3WgTCtCNb5G//ggEE8q1meGal48CavB/tc6j6JffExXubN?=
 =?us-ascii?Q?Ov0knnh7W/gYHByQTdHh/T/CKNvaAK2poS1wvZeWqfsQy9FTfDWL7IUISzWO?=
 =?us-ascii?Q?lMcwji0KNuRVJFX8Ua4PGq0BQCGRDu0s1wp4Yj9KWw+b4SpcNcL8+kwnqfbi?=
 =?us-ascii?Q?OlMRj+ziXQHnUkqd6Hc0TA5FNO6MG3r8ghY5xAnaOwpCDGKN9kbAw+Sfb7rv?=
 =?us-ascii?Q?MWQAQ4ITO6KX8IA7z2OTFzYWdx5fiLiaBfFkwIOuRFoVsoNcG/prJQAv1IUD?=
 =?us-ascii?Q?do+mVVMUWDDKbPYJoWxSsHgr9JlLY5Bag+qDyirA46CNb2a0H9gxLKpgMAUC?=
 =?us-ascii?Q?sSO8Tc1MNH3Y+K2XiD/ahSSsLAqSpP0=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24f848bd-1476-4514-a17f-08da2694d17e
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2022 08:23:04.2629
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qw6Bumt7NRpGUIe/p0ORhrGHSV9y8Snc7J7W0P2dZs608EtggN9lbi7XmLL7xdGRvo/t2f9wuL4ipl71+z3BJ3FCgcUX/13/ymdSzttLWF0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3434
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-25_02:2022-04-22,2022-04-25 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=868 phishscore=0 mlxscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204250037
X-Proofpoint-GUID: fCxgCs2N2YYCbs4khA9DOj3xAaZC3uj1
X-Proofpoint-ORIG-GUID: fCxgCs2N2YYCbs4khA9DOj3xAaZC3uj1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 24, 2022 at 12:17:48AM +0530, Vihas Makwana wrote:
> recvframe_chk_defrag() performs a NULL check on psta, but if that check
> fails then it dereferences it, which it shouldn't do as psta is NULL.
> 
> Set pdefrag_q to NULL if above check fails and let the code after it handle
> that case.
> 
> Fixes: 1cc18a22b96b ("staging: r8188eu: Add files for new driver - part 5")
> Signed-off-by: Vihas Makwana <makvihas@gmail.com>
> ---
>  drivers/staging/r8188eu/core/rtw_recv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/r8188eu/core/rtw_recv.c b/drivers/staging/r8188eu/core/rtw_recv.c
> index c1005ddaa..db54bceff 100644
> --- a/drivers/staging/r8188eu/core/rtw_recv.c
> +++ b/drivers/staging/r8188eu/core/rtw_recv.c
> @@ -1244,7 +1244,7 @@ struct recv_frame *recvframe_chk_defrag(struct adapter *padapter, struct recv_fr
>  			pdefrag_q = NULL;
>  		}
>  	} else {
> -		pdefrag_q = &psta->sta_recvpriv.defrag_q;
> +		pdefrag_q = NULL;

What?  "psta" is valid pointer on the else path.

(Also this isn't really a dereference, this is just pointer math.  It's
taking the address.  The Oops would happen later if psta were NULL.)

regards,
dan carpenter

