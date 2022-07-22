Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEEB257DA54
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 08:33:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234244AbiGVGd0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 02:33:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiGVGdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 02:33:24 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B5D23FA36;
        Thu, 21 Jul 2022 23:33:23 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26M6Si8Z009479;
        Fri, 22 Jul 2022 06:32:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=wOpy05CNrqp09x2QeKPQ+Du97ApUmTq6vNSB8r8tQM0=;
 b=tr0u50GFRPt2cpv7b0yWIufd6cic6+M/1w7v4DRv7Zr0J9LV3m/h5EOP3/8wP5+ZMzEE
 ttehQw9U1rWYCvq7RCPTc6KG5jq7UpGyNJPD2L4/esM66xMk8rm0nDDstV83hmfqtXXw
 0DW0S0Fx7ctSI8sg2xzFPZTkWAes/JZSHL3gNeCN+l17Jr92xM9ybuzEQt2ABSmr7WeP
 zf1qe0g3xyLvrEa2Tg0qjIv1QCwfh3werCfc/aKZPvfJ/8wD9XtSVE3748BLn1hD3bSI
 50Rb2wjxQntayChlVzFIMcWIcIA8r00zpDHQyIuIJLlAa1K6e5Pb2d4cZBMAeJNqo7OF pQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbmxseg7w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Jul 2022 06:32:31 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26M2og6m007868;
        Fri, 22 Jul 2022 06:32:30 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1k65yva-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Jul 2022 06:32:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oEfqLeGMIQDKfXJqVjIebkAf0v4YEHe2MlHbD8r6d+SGJEoi25wLCmZCa1X6aKiCPaVxlQd6+zDuuif2a/JkPrYjeJccvVjFYxFds4Mij6BGU8RuJR8fVGOOu20XszVh2+nlDwtU830CiRR2e8Q86f3d95HRtasQFnS6nFCGiucxi2ZeQ1yCmcxo1J2kf6dSr+8kG+ONMp1KF+s8xGlUQtdkzZnGx6PT3dd378TBaAZhlrOmnZ23ztM//vYjCXovlO4iE1/CmGD9wEfw4tBBJocfXCLLOTKvcT/r1eF7HWYN2OkxkLiw4YbmJfkCfu4vzl4KHnx8jue+R4pGCB4rqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wOpy05CNrqp09x2QeKPQ+Du97ApUmTq6vNSB8r8tQM0=;
 b=erW5Cb2G1f6uTwSE6A74srdMLb07LmEppgqHzwEYWNzfmK2QDgAeTWVUaUmXAE6bbRXQGRNHEjw01zS++CTTJN3tJxrgqSehcNZn2w7AkpLm64wUEPBz3GkwTz1ReEh9qjdHT1kEPA5Zn7027kBZljmBTHkvH0yDvdrfMuGWFqnxt4vzHatrVl344qPL7WLq36+25R4voTIvR6TN2sy9eRNQjWLxDFiApzovSfKjqSgtC1kymcv2OVgkBTi7A8aQ2owl2WD8+tmqe/zna/xEE06tNQVJKDfzv8EmgAJnwf2sxihkTVqa1qvN4Awy1by8bVFKNB++NSn+CrPnYiZYgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wOpy05CNrqp09x2QeKPQ+Du97ApUmTq6vNSB8r8tQM0=;
 b=ohF6SVfbK+wot9mNUJSLy5fncOB0T0cTbvKiPCPK+9YKLOfUrG+wr7NRGFdxFk0LkCatNDWDLdtBn3HMUywsVtV6FsefVTYW5RhxpU4byWjXe41zSjYPLdk8Ur+vypLyAsUPITzld1D0MyoSV1rD+ecR7v/jr3yFpsqWLMGL/w4=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by SJ0PR10MB5744.namprd10.prod.outlook.com
 (2603:10b6:a03:3ef::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Fri, 22 Jul
 2022 06:32:28 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::24dc:9f9a:c139:5c97]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::24dc:9f9a:c139:5c97%4]) with mapi id 15.20.5458.018; Fri, 22 Jul 2022
 06:32:27 +0000
Date:   Fri, 22 Jul 2022 09:32:08 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Abhijeet Srivastava <abhijeet.srivastava2308@gmail.com>
Cc:     Corentin Labbe <clabbe@baylibre.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        mjpeg-users@lists.sourceforge.net, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: staging: media: zoran: Fixed Block comments
Message-ID: <20220722063208.GN2338@kadam>
References: <20220721173729.63844-1-abhijeet.srivastava2308@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220721173729.63844-1-abhijeet.srivastava2308@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0013.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:3::25)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 66abe3af-506e-4744-ec29-08da6babf24d
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5744:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CKynmWZAhu+yfoimmajyaRirDZ1alPIzAoYUilPLjbEF2JvKhekcr1tl2Ll0KsmkWQ0zjsmzRYDh25aMSAnh+OScWOyyelNWtHUk9Jlsz/txdvnYrLzusRvT0U9bbbgnt4pnELfdaklykxzjn0zvSSxAedJfeMlCSBBDJduP0E0c3IQECysw97wz8f+E0n2MkduxJ6ErzYQGxBcK3jeMYBVx+3/CxgtZpSAQYFQdf/mmdDkv+6fiFeIXK6soiFyWAs7l7MJIPkOYMuTzWoK/24JewnmxtzhmNolk3CH4ZpX3LyKf+vO4L1thV23doaXW9d5APCVKOr8rSwVtQGMJ6Jc9tEQwc5WsI+eJ08CJi1NRaAiiPLQWGy7GmEqpc+AuRG+ZnpHNuAC4WnOLjMdonqnfGGTzy0+3FGS4MvmiQUEQjNL2kZqMxtYNMEjPEqheS8FNX4znqhLJjM4194jxE6ZmbhBsXW9U9NzdmtoAzo320B5PZEsXXSsXcuJOsd0RFddsNpULiQ1gZe1nobKx2K50A6xy+CdzmdVCqToNQY367w7oa9fypBduIvomhLiL7YI1yIH4R7LGBQ4XwN2GjQX9MY7wXZcHYRkd5JuNJCFejs6nRTvLYljNLWOe4qFP/YYVNibv7S03KNspGd04KgmFVPKxc05LlBmUR4Qq8YZzPpznPEsxxrMpTe9vVzZOs9XK/WfInDjNlSfV4Hz3/g2dSx6cCZKg4KLFi9Ow4uwKj9/eDflBNCsoD9WcJfgg3GnW7VYKUxQDovpZ/ks5wMrfn+Vyt+LJqcpkqphpxFyj2a4LQ5kJE8mS78gMKO61
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(136003)(366004)(396003)(39860400002)(376002)(346002)(33656002)(33716001)(86362001)(38350700002)(478600001)(6486002)(38100700002)(44832011)(8936002)(316002)(5660300002)(66556008)(4326008)(8676002)(83380400001)(1076003)(186003)(66476007)(6506007)(6666004)(41300700001)(2906002)(26005)(6916009)(6512007)(52116002)(54906003)(9686003)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?M0XDarvqPez/LiWBqGGD6DxA0ARINiqCqhzmLslyynerRkXOAnPyklnwGPZ0?=
 =?us-ascii?Q?4CumX7hdcGmtjTX6c/jlWNGt0VV9tqkTh2xCMjKpOmsvI+eXOIfWCnQpmJkS?=
 =?us-ascii?Q?PvZfV0yX0DWdK78j2OCnq0cGJ9sPbpfPgUnIReC0b9xcJZ3sJSItZ6UvMn4H?=
 =?us-ascii?Q?mINjKxsE36tH85LZkY3Six6rUskYQErxDWuryaEkZaOpEVDMyjjenfOOwzAk?=
 =?us-ascii?Q?XtaGgnJjk9aTj8BFHpiPRiawXr0Ve5bYwLySkb2eCnIMgoObSDQ7SY48eQpA?=
 =?us-ascii?Q?jOJEmWikK4xShZE311Gx+td/K0wpN1GRZJEhEiGVEQLO2HC30d3kyHdexFP6?=
 =?us-ascii?Q?oeDGAwlwkxV1TKTZPoJEKNMfL8yeUrdu3nv9qKfdiYjmbEguq8T6Qjc4ZNbI?=
 =?us-ascii?Q?+Y83S6sgvaFAh8Hzj8E/Fm3cUibhLT+Q+R28Pomu0HqFAkEg+ca4KWPcBbKN?=
 =?us-ascii?Q?il6jH6km/KSFnbamYSRTzg0NjqfpIgN2i6Z14SzfTpGSxLC1m/kg18CXJXCa?=
 =?us-ascii?Q?N5X2Dj+WOTbV+t4oQH5xSnySgn860buZSDR4sUeCe/FsTTvykVbiFkLH12+i?=
 =?us-ascii?Q?Fr4MAASEVUSmnkW8CZQlzzpRLdbCLwilcM+tOEiPIZLtLq2+/CIKG0qCua+r?=
 =?us-ascii?Q?PeuVVMfcHdqpsYYcyTGFJmG/BU2Ps3bCPeFkDkCorwOdFevtbHneVd88jLz4?=
 =?us-ascii?Q?ZDC5J6Z7SVEjuusH55udQPIgn5f1HzhzoscMPoXt0sheEdXDapgW+4kmFo+j?=
 =?us-ascii?Q?YnM/vKQpLEPP4Wv0O/skE38sE3r7nPBQPAADOEGm7AiZRayDpxObEeinzIHx?=
 =?us-ascii?Q?kQ1fWAILHnmH1hLrkpopO9TulvPy6RaCzt5b7nGX5e6KM7Pz628wzpVWU6R8?=
 =?us-ascii?Q?uo3qcCt5RzT7PJ2QeeEepdLL0MN6nKX8j4TmliluG8dywNxr5KoNP57JzL/0?=
 =?us-ascii?Q?SWilHbUcKoUAZa+8r5u8EaU7m54mIEz8jMhPsMkkAdGhi/PqcdZsyHS7GAQF?=
 =?us-ascii?Q?dPROy6Ie6cNAbIQzFb32RQBHXVAcH3lCekKgFe+cTHXfVzRZICpu01fcQA7u?=
 =?us-ascii?Q?wVFo0+4gzHPfu5MNXRhaUYBYimHsjqLDrzx9cPoBoKkVfK5IMYCa74YtisCG?=
 =?us-ascii?Q?NmR95TJrYM5HxXq4xn4a+wqDBEV4NuitldUQhmiYFA6dpXgaPkBmzRd6950V?=
 =?us-ascii?Q?x7zLSFVvgCOMUR8YGIG8FhlJeUDufjudB4Yo/awNMC72Y+p/zFk+MSl5Ripz?=
 =?us-ascii?Q?zUjHr+Ny5M3FgdVf+IUgg8Ui9rVncAn0DOa2Faz3nYZrr5ZAk0YktzCOlXmJ?=
 =?us-ascii?Q?87xizxcMrGesf/ZyLdTnvCmF2H8OAAqPsBxlbEoBiOUELQSUHIV2+FgTxCKo?=
 =?us-ascii?Q?8SqbS4fCB44QACRfMvSD/K9GgI6AEX79vYv4B2KReUVT81TKEH24Ve4O0kIl?=
 =?us-ascii?Q?1m5ddpv9jx/wlBInuZ7K8pIz1+OTukhtlhUVVfIXwFivIaexITiakXGWlGkA?=
 =?us-ascii?Q?lWqacfzEbdLj0/7SdgMscv/O7+qkZM7K6jQ+fz0eAtec3WZx0KCBbDymGkD1?=
 =?us-ascii?Q?Pkkkf8PHgUqL7gWnZDD7/R6YQeviZB9IVo0i1vT72J0vwzx9FHT8GwD9w2W1?=
 =?us-ascii?Q?5w=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66abe3af-506e-4744-ec29-08da6babf24d
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2022 06:32:27.8400
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hnHh+OfPQd18jymt5XQHxBnm1in8Uf4RHCex8pZUv7b+ClcufnhoZKUhXRqhXE8qPoDyu1ZRyXK7x21L9IDLyXARS4Tg5/FlaoCy72d94XE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5744
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-21_28,2022-07-21_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207220026
X-Proofpoint-GUID: jiv_jnxbt3C2z4Fb_uXYT8ZBqYE5u1Fe
X-Proofpoint-ORIG-GUID: jiv_jnxbt3C2z4Fb_uXYT8ZBqYE5u1Fe
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 21, 2022 at 11:07:22PM +0530, Abhijeet Srivastava wrote:
> Warning found by checkpatch.pl script.
> 
> Signed-off-by: Abhijeet Srivastava <abhijeet.srivastava2308@gmail.com>
> ---
>  drivers/staging/media/zoran/zoran_driver.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/media/zoran/zoran_driver.c b/drivers/staging/media/zoran/zoran_driver.c
> index 4304b7e21709..b408c1d4e0a7 100644
> --- a/drivers/staging/media/zoran/zoran_driver.c
> +++ b/drivers/staging/media/zoran/zoran_driver.c
> @@ -746,9 +746,11 @@ static const struct v4l2_ioctl_ops zoran_ioctl_ops = {
>  	.vidioc_enum_input		    = zoran_enum_input,
>  	.vidioc_g_input			    = zoran_g_input,
>  	.vidioc_s_input			    = zoran_s_input,
> +
>  /*	.vidioc_enum_output		    = zoran_enum_output,
> -	.vidioc_g_output		    = zoran_g_output,
> -	.vidioc_s_output		    = zoran_s_output,*/
> + *	.vidioc_g_output		    = zoran_g_output,
> + *	.vidioc_s_output		    = zoran_s_output,
> + */

Always, just delete dead code.

regards,
dan carpenter

