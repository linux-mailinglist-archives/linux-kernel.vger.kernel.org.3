Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DF09508278
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 09:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376333AbiDTHqj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 03:46:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241235AbiDTHqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 03:46:35 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14ED23B56E;
        Wed, 20 Apr 2022 00:43:47 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23K7BGHm020195;
        Wed, 20 Apr 2022 07:43:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=V881nHE3wVDfSlwsu3udt4vHtCxiq0CKu1ojNSyOA8g=;
 b=ItJdfI2IpLY21MwFYDiCjhGf40zEGYvPBkoLh1bAZggV2karY4cmuCELfjZsY575ow3K
 lEu08mtbFSseKAsBayRozgy1rE1AjgNsevQDyjETaN6QX5Vl551YaUQkXozlemyHTNue
 ysPlipARfRa0KIMymG4duL6aFaT1qDfjK1Nk0o0YFzfk4C4TCDjkV0oeGAoBv05woO4P
 pwKcWEQXvScdAWVCcEOxiCKFnmJfSC5eKx8NQd4qHWObf1rUAYNaS5qthhwu5XCDTmEf
 fFMHD14LeD0cg005xCt8oRnu3DJUWG1O9fEoqlybj77pBImBBz5llfPumbRP5SYfmOYF dQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ffmd189gb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Apr 2022 07:43:23 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23K7g6HI001377;
        Wed, 20 Apr 2022 07:43:22 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3ffm890ay4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Apr 2022 07:43:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T8KDrVX5o/qhBulz40uObw2fNx56qhOXsIHO04qDzEB3t7Th3SzmSQpcT8NjQBa9SpuhTxGJUnZ3Q0tXvxxxqo5u3TIbqyKKROcQik5BIwRCVxdR/Tas2msKlpIQR0CH9f4jroJpjz7trwsUmgndePXTHIuJwsCZj5ooTFeM2B409+R2c43MQHL1E49ZYEJNtL4KFbt9N1Dwr3TmWrLvHiSHFsF8/61f0DAiD7rvv/Qj5l7QeZMSj2oW1DExeV94kelPH38mjFRX0AbWn4zQ/Rk6hLnWwD/xPZVK3YfKshuoFfFCDqQcUrskqUDW3cHycOa3ui4oegrAyy6d/WUU9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V881nHE3wVDfSlwsu3udt4vHtCxiq0CKu1ojNSyOA8g=;
 b=bifUwUokjkRmOQV7jED3yOK6H7I5n09cSzKanwuFh2rH2GKfKxLZ5Nz1plXauXNDPOi/7V8a+DXm12fBpbGsKRKPwAcYkHPj0KV6RV4uE0+J9aQHdhaO6IsXo57uZcX1BukCCmNISvtVF3ljkI+ZCAQbnOFJbSSQWimn0pruMgvN35QscKjcsGGB8xQm88mOd5HxTj9ZZvdPauuMCk5cmIF7MdOnsG1fSXLoNbljWgIAes7jV6+jxG6bYbwq+pfYhWsG5CBu9+WwpW8u04gCjsgsFzqNHUZMCodluU5WcoXwqDFKD1GblVMjdpG2Hhp9ty1rF4el47uV1rRyS+hKhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V881nHE3wVDfSlwsu3udt4vHtCxiq0CKu1ojNSyOA8g=;
 b=mDOvOZ0lI1YxCCR5sOdvyRUTJgbDXVK+30nZDNzNeE/CiTJbMrBMDR0elSm9Rgk08BPP1nfUXcoEDoMq4kNktjiK2MBHOiJoZt2VJw6kjQ9uDHGFfiAIoQvJxNJfOaD4ksYxW3ZiLPzTVwe1iyU7zOoeg3GB8wCw9UFwAI6vQjQ=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CY4PR10MB1975.namprd10.prod.outlook.com
 (2603:10b6:903:124::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Wed, 20 Apr
 2022 07:43:20 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87%5]) with mapi id 15.20.5164.025; Wed, 20 Apr 2022
 07:43:19 +0000
Date:   Wed, 20 Apr 2022 10:42:49 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v3 3/4] staging: media: Add support for the Allwinner A31
 ISP
Message-ID: <20220420074249.GB2951@kadam>
References: <20220415153708.637804-1-paul.kocialkowski@bootlin.com>
 <20220415153708.637804-4-paul.kocialkowski@bootlin.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220415153708.637804-4-paul.kocialkowski@bootlin.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0036.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::6)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 42d91fe1-f19d-4009-5dbb-08da22a17040
X-MS-TrafficTypeDiagnostic: CY4PR10MB1975:EE_
X-Microsoft-Antispam-PRVS: <CY4PR10MB19754CBE43021A322D17FF298EF59@CY4PR10MB1975.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lKDiFZfZ59bvCqvFuLRHCy39Bg/5iUmQQjAoO0aWLJSycT9+w8Ch221LV/QLel0Ke7abiOm6y8+koc201adcKIeVMtJD3blsDaz7fqIi07vrKZIhMAoKxwjYSQSKWXyJjuk+VtLiZR8phQDskG8Ubwy3K+eOdUJTfL2pYajPyw94Mf2hczOwiAJNOvfkFuatgKvvG7ilQrn49EdVQiZzdAGrhD3K/IS/MedAg0OTAj8kyJQuDGGpEsyEAtKDxKYlyNbkiQknZ8q0ft+BjCWbU0Zn6m6ICrXpr+gy7iEynWnjYmHuL7vGKaGcTInOQmi9rah9enEh5I9fyToL6hIsSL8WUgT4zqAULDWmQoDzZm2Hy0AccCByeqroIyGVgbyCqowH7yfEN3zVbDQ7E35xQFtL1ZGihKCfEX2Lz8kRCbYTLHvS9hwBorJHWAdwpc344PXx60GF/YTlX16Yaq5RKA0QSCW7y+tOZJiKoSGCnaKibv8LG4iNP+hlsj0gwvKDCkKcUzv9hGO2obkQkhPRKe7mVIQwi23WPEt9JEKX7yzOIIN7nHJdp4nRlyDNiFaNCF7LP0A41aZoGS5z6Yv0r87AvA2C33sjOckmO55TQ36O0Qd+ZOqMEV2VkbZ4FNeQiivdwH7JOlWpNH5vyJ5qn09D61twM7tNoXt7xO7u6w2I4SfyZypMGFn0mE28cuaBJ0Z64PjPI4JqaMgyauV2eQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(86362001)(4326008)(7416002)(186003)(2906002)(6486002)(44832011)(508600001)(6506007)(83380400001)(6666004)(9686003)(26005)(6512007)(52116002)(66476007)(66946007)(66556008)(1076003)(8936002)(316002)(5660300002)(8676002)(38350700002)(38100700002)(33716001)(54906003)(33656002)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+zcdLF4yOoPQGv8/qHAcnirnWOK40lKVf7RqqjGg2xyV7KOjQGLAwtVNs6bQ?=
 =?us-ascii?Q?cAmtIbx0+Rz5eJMIzLDn6ydvBfl4pM41ELACVzanpbzr0skbDNduC71iLkaV?=
 =?us-ascii?Q?To4Z+puZWlkve6OGQkWFKdQF/N2Q2z6P/bIG5TelV4+RlhiWH5XKPWltq9VR?=
 =?us-ascii?Q?aNPQpNY7Lgq1sbaxV2014OGgDuObqrH7RJs3iigigH5G8xAP1FDBwhpzLK6E?=
 =?us-ascii?Q?zZygBKaXidLnhKmiUq5ps4H6CKDl3AGwX0JzlGPdDf12ODBPDT+jS+w/JLn0?=
 =?us-ascii?Q?EV90B09ZAB/evS9zdXJ5s0DVBqPw7i6dMvB8utvQZq2MsI2fgyc10ljAdVxi?=
 =?us-ascii?Q?yYsZ4YUwQdj2pYj6/HAg+PPuJKYbSWtIvU+sbRdqfktT5dtcNnOwCshiuOb8?=
 =?us-ascii?Q?61HYr6H4lW+rLE28emwleC8neM0KB5kQTrYCK9dUjaCbjhP5N+fPkMdrkpUL?=
 =?us-ascii?Q?/8g+oi0UMGVhkVlFxAapJP7GNqCXlFlfFQaYS4yviJBP/4naOqTqkJ3j2O5s?=
 =?us-ascii?Q?TIF7jJ8QBQQTFLpMRn4u25GBN69iOeVI0Ck7w7f+qa7tI2myUiTrrLtV/qnZ?=
 =?us-ascii?Q?v85nsmLae6nDTMs0bw7escp7zFW2Z9cKGUoboWSxtWciIFI4Debn2u32O0lu?=
 =?us-ascii?Q?Hb2rU7s6nyVDokxpozDuuNdxv48hWu7SG3U1D0eot/XE3rJWrJcruM/d/Jwl?=
 =?us-ascii?Q?6V1P1EBf2Z7vfeBKIyZ86mP9SgFw0sRAdJem1jcy4t3xwda7oacr5OqhDGyX?=
 =?us-ascii?Q?PIcBhwcBhpK4fK8Um9+28ed9KP4LQMWQWregDRk1aW4tstrapMecVJXAqiJG?=
 =?us-ascii?Q?XYU/aJ+xCeb16pJqOXsqmdv6qIoaFZllZyScP0s/h6bpuUpozlQ7T3vqmduP?=
 =?us-ascii?Q?nLKuYlgeVMDeQvoS37X6NvRtWZom7bcFFC8kvn+phHxg97PbKQK6KJid1m4O?=
 =?us-ascii?Q?E8mkQaqcqopxjd45WwGnVnqVSzv3ZSfWTKV5fvP73brkVL6Pc67f6NFgpKD0?=
 =?us-ascii?Q?84Q9PNcQuXjZ3a2l+WW8nazhw5W8MxzRC6gTg5GGoDq5v0DxDbczrYWXsbcO?=
 =?us-ascii?Q?O921OKUNusxzENfdNwtudg1z/eXDEIYQYLvduXoUpnMBQ90zsdALTjVGHI5B?=
 =?us-ascii?Q?IlgVp3G3GhskPebJMfXsWwot4MMouEDWiy8SF6+giNKNz3WRV98I9aPmiNe5?=
 =?us-ascii?Q?s1BgV/mZHFY57zqI2YMoBSpS2lncK44up5PdYzpYEhoGhoYyLYYOslOGOdsV?=
 =?us-ascii?Q?TU89qtI1ubL6a9Qot8unOx5vnnekhWl9tVYf0oujchqu/IIqPGohVFm2QkLU?=
 =?us-ascii?Q?3q82oDgbDvGTRLz1Mzc2Jn/sYgw05E9RMWzQ54WGX2LJoUrOO+a7kQTW5GXs?=
 =?us-ascii?Q?AsDDwdMreVcp+/JTU/PCjhRpvPXndsEK+N6ROScs0q6ffZ8t7ajO4snGkTcI?=
 =?us-ascii?Q?4+ENm/yUntJZ7VtbsloiaYiZ+sQngam0GlF0hVFb7YAy7N+AmbZhdhYnjp2r?=
 =?us-ascii?Q?ckYNgAsicZ5mykfS3UKJFyL8+G7os/bnerYBmm3z14JVCcQ3wcCXnNb6pTt+?=
 =?us-ascii?Q?GqW9zBseEuMUdjI0bN5bh8hlx7YSxZXPjJiwdbNbPCQ1sOeIPmlLvz89SzQU?=
 =?us-ascii?Q?f7mPvNuslj5jWE2lUl+mPYBrXJrjy7UJdjZtxKrxH62ZyZwnSwwcnbh2j8IS?=
 =?us-ascii?Q?4OwVYoul7APW9bXWzM+NcZtJhtRBErHVrpd1Tl//VsRv+3qomRxMAyM8B4e5?=
 =?us-ascii?Q?8j1Z3WMUNnfdDLzEjJibLwCvCGBcAbo=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42d91fe1-f19d-4009-5dbb-08da22a17040
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2022 07:43:19.7035
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cSjBW7UCHsdaC8U6pJYeIgb8zHMncWP1kZVbZ9gOVvLxbBJGb92eO7nUcdk285d46qZHflYiOM1Hk1c4npqWbI6BQzWtM22cLgYrsQO9JSU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1975
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-19_08:2022-04-15,2022-04-19 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 mlxscore=0
 adultscore=0 mlxlogscore=999 suspectscore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204200046
X-Proofpoint-ORIG-GUID: vzQMH6nk699W_YeTFs1gGyYZTXd2VxQ2
X-Proofpoint-GUID: vzQMH6nk699W_YeTFs1gGyYZTXd2VxQ2
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I ran Smatch on this patch.

On Fri, Apr 15, 2022 at 05:37:07PM +0200, Paul Kocialkowski wrote:
> +void sun6i_isp_capture_configure(struct sun6i_isp_device *isp_dev)
> +{
> +	unsigned int width, height;
> +	unsigned int stride_luma, stride_chroma = 0;
> +	unsigned int stride_luma_div4, stride_chroma_div4;
> +	const struct sun6i_isp_capture_format *format;
> +	const struct v4l2_format_info *info;
> +	u32 pixelformat;
> +
> +	sun6i_isp_capture_dimensions(isp_dev, &width, &height);
> +	sun6i_isp_capture_format(isp_dev, &pixelformat);
> +
> +	format = sun6i_isp_capture_format_find(pixelformat);
> +	if (WARN_ON(!format))
> +		return;
> +
> +	sun6i_isp_load_write(isp_dev, SUN6I_ISP_MCH_SIZE_CFG_REG,
> +			     SUN6I_ISP_MCH_SIZE_CFG_WIDTH(width) |
> +			     SUN6I_ISP_MCH_SIZE_CFG_HEIGHT(height));
> +
> +	info = v4l2_format_info(pixelformat);
> +	if (WARN_ON(!info))
> +		return;
> +
> +	stride_luma = width * info->bpp[0];
> +	stride_luma_div4 = DIV_ROUND_UP(stride_luma, 4);
> +
> +	if (info->comp_planes > 1) {
> +		stride_chroma = width * info->bpp[1] / info->hdiv;
> +		stride_chroma_div4 = DIV_ROUND_UP(stride_chroma, 4);

stride_chroma_div4 is not intialized on the else path.

> +	}
> +
> +	sun6i_isp_load_write(isp_dev, SUN6I_ISP_MCH_CFG_REG,
> +			     SUN6I_ISP_MCH_CFG_EN |
> +			     SUN6I_ISP_MCH_CFG_OUTPUT_FMT(format->output_format) |
> +			     SUN6I_ISP_MCH_CFG_STRIDE_Y_DIV4(stride_luma_div4) |
> +			     SUN6I_ISP_MCH_CFG_STRIDE_UV_DIV4(stride_chroma_div4));
> +}

[ snip ]

> +void sun6i_isp_params_configure(struct sun6i_isp_device *isp_dev)
> +{
> +	struct sun6i_isp_params_state *state = &isp_dev->params.state;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&state->lock, flags);
> +
> +	sun6i_isp_params_configure_base(isp_dev);
> +
> +	/* Default config is only applied at the very first stream start. */
> +	if (state->configured)
> +		goto complete;
> +
> +	 sun6i_isp_params_configure_modules(isp_dev,
        ^
There is an extra space character here.

> +					    &sun6i_isp_params_config_default);
> +
> +	state->configured = true;
> +
> +complete:
> +	spin_unlock_irqrestore(&state->lock, flags);
> +}

regards,
dan carpenter
