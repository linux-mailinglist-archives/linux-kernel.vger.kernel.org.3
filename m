Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8F805118F7
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 16:54:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237672AbiD0O0z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 10:26:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237633AbiD0O0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 10:26:54 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D96141BCAE;
        Wed, 27 Apr 2022 07:23:39 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23RDVx2i003699;
        Wed, 27 Apr 2022 14:23:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=4AikxkVGQ7l/pqhPpmdmvnr6cDmOnp4fU+PzrPlEtC4=;
 b=EodMx1ODbbTK7Xb/8cyjeejOIj3Eyru1xre4Ekromb0xwjPynjB1XUa3K3if5hkGKa15
 dY0EeP3dECdllmMWoFGldpZEOS1NahDVBYqnDyIJH5JZ6AGgh549iO/9sgV3DfULpg3V
 74HzQ5GfwODd2JFRo3SHsFZmI/6knEI4vf43TsvsYrq5+kBUwOlOPCQOUlFLmJvHFGkX
 A2fTCmHnwFJvruClPYo/i+paoQEvH6ELmEuelxvdm44nGvGsTR5oLR5itvgGfhmNrY7a
 9dT5NrSGFSvZaVpTOZbevF24sAdDBeQOHRvRKZ8gOhBiqZVt6i/Rl4k8gZoNV61wWhF1 bw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmbb4rv3b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Apr 2022 14:23:05 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23REB99l019834;
        Wed, 27 Apr 2022 14:23:04 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2103.outbound.protection.outlook.com [104.47.55.103])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fm7w4uj68-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Apr 2022 14:23:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gVTyOTSGoSIzbH/ndSOZevgPyGq+EPoW8WWx1uMAGMhG2UJhy4e2VnY+2B/CedrCHYxvbz5Y6EyjOnDuj+tg8UGasKTsG2UulYSzGcNq5QHPA36yJc3L3TIMRuH59H+CjGPzPhJ1OkK/DcSB2jfjZngKQW1DUGLwrdV51Zmikqyz2YQkefhN4/11QwbuXB2Ugk89EbQJzmQ+km19urc58lzksD2fu5BHn/sxIyPHg2G1pogPU+Ex6lpuTnP9s5UNWowrQgwwTlmhcZUaH84FwQPNGikA5Svyldqe5UoSQJDo5LLrw+t86YvAZM1GNo69XcJXhJJckbIgfb8/1GuzzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4AikxkVGQ7l/pqhPpmdmvnr6cDmOnp4fU+PzrPlEtC4=;
 b=e8nAgv4a15aDAfVtCvCYnx8xXn7BM9rF+hGRbT6aSKQSacbUcPpF/SVJFHtV2sn2PtymgL9+p5ONB+W0HbvdJDS1gCYXG8hJ7MTzrH3vtTFuhOjdhQGneSO8tmRjL6mamZe8vIbuMyFpxTdkZPDC+1B4TUQgzZ4zXKdJXsd8QjOPR5ibLldXEcEkmmg0jp4Wr0Y0BItGHtQY1ebX7jrG998XKAKbyJURh+XTYs13qmgDS+5G4cmOAClbwz1Qr9UBhs62EYRtvhJPFsr/rDyNGpITVAbHFW98YmgokjPzzEMrrl+3YnRkB3iZCP/VvAN3+XG3JVfy3Wmlqa6DQbxWNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4AikxkVGQ7l/pqhPpmdmvnr6cDmOnp4fU+PzrPlEtC4=;
 b=DVNDnWQHY6Emg74PqujzwNXFOJlL9gYtmSNqjjYUkgTYVR9BNnqv37YDv7x8CvELPvY5qVx8FF7agzoI6GUxAsZ9qVh8RZ/bNMkhH9Mgct3QKVi6NuRmndCXJQ5aJAk2XBUAiFhPDKtfEbkZWuMNt//Qjae1+o1YB27t3LYw7HA=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CH2PR10MB4261.namprd10.prod.outlook.com
 (2603:10b6:610:7d::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Wed, 27 Apr
 2022 14:23:02 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87%5]) with mapi id 15.20.5164.025; Wed, 27 Apr 2022
 14:23:01 +0000
Date:   Wed, 27 Apr 2022 17:22:33 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc:     ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de,
        mchehab@kernel.org, gregkh@linuxfoundation.org,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        jon@nanocrew.net, aford173@gmail.com, kernel@collabora.com
Subject: Re: [PATCH] media: hantro: HEVC: Fix tile info buffer value
 computation
Message-ID: <20220427142233.GS2462@kadam>
References: <20220427135517.381959-1-benjamin.gaignard@collabora.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220427135517.381959-1-benjamin.gaignard@collabora.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0001.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4c::6)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c9d5161c-ebfd-4a49-95e0-08da28596f7a
X-MS-TrafficTypeDiagnostic: CH2PR10MB4261:EE_
X-Microsoft-Antispam-PRVS: <CH2PR10MB4261876497FAF9A4DEB115B68EFA9@CH2PR10MB4261.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9qh8xfG/R8Ykq0PiZVZO7cpbpKHK1x9nyMuUSJ5ULWoCUZeoJj+U8fE494P65ZC/aw5QRtNg9wOwLbwpElPTEmYXwlP2ImOkrPU87D4B/93WWlOzci6YPsTos1BuCOonrFk2PJC9IWKXheLHM3Bu3NsNd6I3zUkiRDof0gN+2gyHah6tYyW+o5GjmL9YzKy9q7hYbmYPmuItf/yz2wCdDKJVzAX+Al364DAp4JAzf7smVrq9FiQB5VYKfP3qbLUtZZq+fSeaquYq0oH5zLlxH5OfkVgwZvJnhNg+q7U0LRbHzfduoVTqaR1rYv6wnsBO0HyAsqBZfpmvU51Uovzbi57/dw60cwSBAZqALjq/i9d9nTOAvivpZiKQnNO7goZ2hUysOHaT7uAeUTHcPplqTTzFMEaq5/nHso27sUuMeNNp6wYn1ufjADIs1GUeeh9cRB2yRh56DCRX6QzjNDwSmzsW1UtmYBHRakMVDwz0FkJw40X1iCmCR/JfFDsK3FqDfC00qW8Er9K4oD2sXwD5qsKF8HXuSptUsBz6X+Ev8kgS74eEgMCKkZ8I59YUOYcagTA9QCU+G9xCyc8hWJWB43KE6dMqaYFEEfrA5FvUKfP1FF/4PEnbx/BPhZjyAroxf66o2U5yTZ47nqthgZhPLyfsbAQ8BOIg79zx22IxUgTuqHadHs1mviAPOhNN31u7w8y/QyiPJiasa5ZgJ3d2Sg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(33656002)(9686003)(6666004)(5660300002)(508600001)(2906002)(44832011)(8936002)(7416002)(8676002)(52116002)(6486002)(4326008)(6512007)(66946007)(26005)(66556008)(66476007)(6506007)(86362001)(316002)(33716001)(38100700002)(38350700002)(6916009)(1076003)(186003)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?K5O3G8xebOW+ZAhYkttIZLegeN3/a1tzvOyl3V7jt99SCPVDB7zxJvAYs/7H?=
 =?us-ascii?Q?1KkMizWKx3fGyB2BHubD5Jr5pGenWgRx1qXwHzsVq1OuPW3H55oXWFADpdLp?=
 =?us-ascii?Q?SsPJR8zNedWR7PnHAJv3/1iMjDVFi4clqyojNaNE1NBjMNQE6AeH0mU03lmV?=
 =?us-ascii?Q?ESjfEAgFHgtIZnHMm0PR003/a1kLxs3NWJzJmc0lmwddcLaqKZbocsAdVUZe?=
 =?us-ascii?Q?ba6GwhOwqC9PMmvOAZMwZaqyPa3WH2gvn2s4i5EKsKdw7GovlukGERX0WfEL?=
 =?us-ascii?Q?JRIXPBEDGfp9luQrviP26m0/c47YmSF+QcOyNZOzQ9gc7pkuI0WY+gIrYNZQ?=
 =?us-ascii?Q?S/7168wUWMQZthUevMq+KYyB/IKbT5jp1mBr9G/BhzlfHku1c7yg9kndRAA5?=
 =?us-ascii?Q?nU5fROLeEfiaaS5jWhaB06TvFIHinfMUOIGJfe0Pa9VUMe8OKjDgrxisAqfn?=
 =?us-ascii?Q?Jg1l6tt99X6RFNAtUL6LNJcyxx3Xuwq+x8z5ZFUkRbe8Ij3peOeitC8in9M3?=
 =?us-ascii?Q?6uwmiET6lRFxi7asOJatENsqcWsT6LDZ9rvi2thVvo8GnxgQWTS78BKG8A4q?=
 =?us-ascii?Q?dtZwbYoP7dHLwifqe81dmxDnwu+TdG71gJkl/YiNVEgjz8R5U1HgR4yWdKnu?=
 =?us-ascii?Q?p5jq6EgOtY2Eqq1lSa27lA/8gEcXmwXww6NxKgeinarrlljDoEXoSDwXAR2+?=
 =?us-ascii?Q?mUMz0fKiMLJFS9rOhUUmMMbGsMGMZB5NtSsBnezBqE6S6X0aorGRm9G1id2u?=
 =?us-ascii?Q?3I3J3AqGvhfXgKurfTGdb09mNqjyBPUzX9ugmS7pr+caPEzM418UprKsuw4G?=
 =?us-ascii?Q?x4kATBJf1WSDmnKHsEM+CMHK4DPECcTpHdkxerPWBdZKLjY9YVvWjABE2iGu?=
 =?us-ascii?Q?m21GQlc4IFuc1AHh4l3pJvZMUzZVMCUxSH/SnKaQGGx0+UoQ3nRdaDyRVd6l?=
 =?us-ascii?Q?yBzs+AbLDXPjbISFGYKDMr0JERJneL7dkQwMMCtT2BRUZbRR8+/3lLUXz5hO?=
 =?us-ascii?Q?byrFM0U65ekGchTxw4pnYq0dEMPUJkz/FieXbcqYixd+GJgTPqIUYVjeUY8G?=
 =?us-ascii?Q?EdN+GciX2OyP15pQKeXPlAjMK9J3+rSA6ggsbaT0AW2Fn/Kr2+YXaXbsJNM5?=
 =?us-ascii?Q?493Enu0mUCaBM3Cs75ZLmM4M/JAR7k4mmq5hMjImkOu5D9GkRDU4OrfPecE/?=
 =?us-ascii?Q?LHeJhJ6YR/ttTIh9Dq98T9c2cEppB+oYdCQQLmCI+sWqFYeIJ6Wt1AT2DbxD?=
 =?us-ascii?Q?Rjqx2DEsLkhtdU5fJ5ut16u6BkJx5Q+Erq0n/Ex0yuFaofKhoIF06sdWjpxH?=
 =?us-ascii?Q?X46NkwOoUpMvGDnza8cvCYT8magLEZ7QwNEMoA5ewsci+xAe1pUYRajY1yHj?=
 =?us-ascii?Q?g74TMoC6Idj9RQicZXBrLYxWSxrnLSWd98J6CJL+Bnh+fkZiXJceVnKKmyCC?=
 =?us-ascii?Q?DzPw1eYcCW6F3/k1mzVeOQnLXkmyFAKQqki8ci9g3SI4OFswiUymkA+jwRaH?=
 =?us-ascii?Q?bPJTyicCERMVyZjl4HoTzgEC5ZAH/VX1AD6eYdv/bf0iIepBwoYfTrd+M0+U?=
 =?us-ascii?Q?r0pwlr4fEwO6i6WBQwY6ZFAhDeoSWq2Kmz2V5xSZQAgmKe4W5vYwiTvtnKOQ?=
 =?us-ascii?Q?ylQKp8cmSCCgldRi7SF0QP6jFsg9aOzEJP+EpuVa9QAQRNiV8ZxhBoS9IVOR?=
 =?us-ascii?Q?1MM+UD1ujZiCbc9iGslr3fj0UcIq0dE3ZvpdLMZax+pDa7mtF88nQ7fReRU2?=
 =?us-ascii?Q?kv2ng+j21D/ZuFreUi4WjvhNgyvyfqk=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9d5161c-ebfd-4a49-95e0-08da28596f7a
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2022 14:23:01.8070
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 54JWItqz+UJ3Qk1IxuOzS8C/kvJqx0a3V6qD1diI+mrf6QiysKj6EKCbfhUFvTRlQPIPspveBXS/m2fNpWis2xMFDkzobS2Lpd+JdKLaIUQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4261
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-27_04:2022-04-27,2022-04-27 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 mlxscore=0 bulkscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204270091
X-Proofpoint-ORIG-GUID: U502A2r24-nDw4OiNrAophMYVsUBcRHH
X-Proofpoint-GUID: U502A2r24-nDw4OiNrAophMYVsUBcRHH
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 27, 2022 at 03:55:17PM +0200, Benjamin Gaignard wrote:
> Use pps->column_width_minus1[j] + 1 as value for the tile info buffer
> instead of pps->column_width_minus1[j + 1].
> The patch fix DBLK_E_VIXS_2, DBLK_F_VIXS_2, DBLK_G_VIXS_2,
> SAO_B_MediaTek_5, TILES_A_Cisco_2 and TILES_B_Cisco_1 tests in fluster.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>

Fixes: cb5dd5a0fa51 ("media: hantro: Introduce G2/HEVC decoder")

> ---
>  drivers/staging/media/hantro/hantro_g2_hevc_dec.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/media/hantro/hantro_g2_hevc_dec.c b/drivers/staging/media/hantro/hantro_g2_hevc_dec.c
> index bb512389c1a5..ffeb2fbeefd2 100644
> --- a/drivers/staging/media/hantro/hantro_g2_hevc_dec.c
> +++ b/drivers/staging/media/hantro/hantro_g2_hevc_dec.c
> @@ -74,7 +74,7 @@ static void prepare_tile_info_buffer(struct hantro_ctx *ctx)
>  					no_chroma = 1;
>  				for (j = 0, tmp_w = 0; j < num_tile_cols - 1; j++) {
                                                                        ^^^^
Is this "- 1" still required?  I would have assumed the "- 1" here was
connected with the [j + 1].  What is stored in the last element of the
->column_width_minus1 array?

>  					tmp_w += pps->column_width_minus1[j] + 1;
> -					*p++ = pps->column_width_minus1[j + 1];
                                                                        ^^^^^

> +					*p++ = pps->column_width_minus1[j] + 1;
>  					*p++ = h;
>  					if (i == 0 && h == 1 && ctb_size == 16)
>  						no_chroma = 1;

regards,
dan carpenter
