Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D86D44F447A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 00:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348771AbiDEUOu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 16:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384098AbiDENcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 09:32:03 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-eopbgr150070.outbound.protection.outlook.com [40.107.15.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39A857EA29;
        Tue,  5 Apr 2022 05:31:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F1CrUrdOLTlxCmd9ZBC1yj3n1QZ739yI/yDoNaEWVFbngMJwTEuqXZ6Uj7kLg8YhDn/jRnkpZdY75bD94avqGAhhRdkWPmUjqq1NgIsEs9h4/jUKw5jJ42p+cEuO6z8tq5Jk5UE4H22vcL+ntUDw+JIjz1U56zqm4ZBzCOAsGzNiMDLWaoiQkcj4tZeS93v4Jq3fa17SQN93yOoPRaj7UwT0M5N4RBMkfIKfmljrSnLpG0fLoFImGa7kz/Gl+fK95/TqsSEOfw8XOfjo1jG87W2s9R8M7YlbEnlg9ZBhGhCJb4gwTu6tJD1DQdTFFQShqbSO6WBmAsjdtYaM+/F3vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4ukqUP8eoWk0zUK+7xZWGPWOYy1gJqYejOrUP5ccwOY=;
 b=SL5QzLZS23wqBQUQ3VKrusAOqPVwWAuwswGU7s4XDd6cuDqvjaP6AgmiemcHITnCA0hLbIN8Hrs2j45tkDX+qw1Stur6TRhpWXruvArksB+KMCfFCl71uGYDWPs/dKHyK5yFVoOEek9M4xpqnA7/ziqxKsvEfKpQwoZuAMHOrMAFfTBx+ALmqVtOf1Op64Rt/SN+TI18aYkWibiHZm3bMMLqFXB3Lx48wSrrKSW8cErbseVGvpWxDvNYzYwoYeCbTe+os5XBPDmQ7C7oZGQw74eJn7OVGvMzDyp23FoTWJOqTuphv62cxX1e/SZLcDCRygevsVacN/gMx2AaXDyjNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ukqUP8eoWk0zUK+7xZWGPWOYy1gJqYejOrUP5ccwOY=;
 b=d5i0Q+QHTISYWhXwya5HhHla/owe85asFRE215ctcoOtKl1DxlmMshV90sMa25yFOyh92k1oDngdOYaHjkkHbLbFZCcnjXewEhLE7P7/3gAOqRR4P8At37Up5TzUFtcsaW8+4Wgtv5Txzs0n+ehORMNYUx7qO+3yGjiZwZDbT04=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4046.eurprd04.prod.outlook.com (2603:10a6:803:4d::29)
 by AM6PR04MB5560.eurprd04.prod.outlook.com (2603:10a6:20b:9f::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Tue, 5 Apr
 2022 12:31:47 +0000
Received: from VI1PR04MB4046.eurprd04.prod.outlook.com
 ([fe80::3567:504c:6ba7:c099]) by VI1PR04MB4046.eurprd04.prod.outlook.com
 ([fe80::3567:504c:6ba7:c099%6]) with mapi id 15.20.5123.031; Tue, 5 Apr 2022
 12:31:46 +0000
Message-ID: <f91ef72b-dfd0-0e86-59e5-f0d0ff3a959c@nxp.com>
Date:   Tue, 5 Apr 2022 15:31:42 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v2 1/1] crypto: caam/rng: Add support for PRNG
Content-Language: en-US
To:     Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
        Pankaj Gupta <pankaj.gupta@nxp.com>,
        Gaurav Jain <gaurav.jain@nxp.com>,
        Varun Sethi <V.Sethi@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>
Cc:     "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        kernel test robot <lkp@intel.com>
References: <20220304114123.3762649-1-meenakshi.aggarwal@nxp.com>
 <20220316180149.4070622-1-meenakshi.aggarwal@nxp.com>
 <20220316180149.4070622-2-meenakshi.aggarwal@nxp.com>
From:   =?UTF-8?Q?Horia_Geant=c4=83?= <horia.geanta@nxp.com>
In-Reply-To: <20220316180149.4070622-2-meenakshi.aggarwal@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR01CA0078.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:10e::19) To VI1PR04MB4046.eurprd04.prod.outlook.com
 (2603:10a6:803:4d::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ec40e25d-1724-4dd6-eabd-08da17003fc6
X-MS-TrafficTypeDiagnostic: AM6PR04MB5560:EE_
X-Microsoft-Antispam-PRVS: <AM6PR04MB5560CA96D1A9927F354EB4E398E49@AM6PR04MB5560.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1mAUO0rOo5ZxZu55rGsf12fNP5Kqb975V120yKBy9fcYlzYWZXPCHtEaTTqHybMlujjJq6URjJk7SmPEw87dd5fWs4p5qxxmvm6z7a25Ovpiz57CWh2VKIUgr0+2Su1Ix3L1MGR1ePQXf69+B/ys9BN0vQX2VEhxKQl7nlK4owLO0pEIYJyZgLS0gfbfuVz5zmEvIHwOlm3t0OMncV2rQnUpo/CghxTx/5bTo0/pCOj/AdKRTBv6Lwj8k4INghXV+hEnvDCCBItbT3pKFefNT0P34w5CnZC7txmq8rzNUEczGaicbybqjdRA2GbMANw+kJjP4Pxofv/f9Kfv0JymiWScP8VOnJiYRsPHVWEZaQAFGRXC+AUKSnVwf5D0yM3UjvBhOuHW/TuZfurIUTiH0gFNDX570FzEmG4kBvcJ+fP2X/yxOBLVrjYSTRmR/SAycYaNaNjzre74hTFnH7EODxtZmg3yZOU16c/qBY4v++KaUnBV0uQL9Q8w3rEv+64UzUW81/Z4Oi2c+sZ5CTpaTDAduzNbBGdMjeSxZvhc0Vcc8mLfsab++fzEuT2Gs03ftgfr+foFY4vZqZRQJwnmckz1h2tt4Db4ceoBC5rxhBbTbjFPk0QHQa+RMVY/AeTTK54dGMXXQxpf4GFBpfi/IA8Mk6ia2sXq7r6d0JtxCY2CfdK2myR38xYgy/xueXT/RkB+LDPAPUJS7GoWAolzQRG51e0+Ob4gmx0/0cg4/DZ7LAJPKAR7c0q2d1UE82rX73f7sSwj1+b2HnMtHni9aXQWn+q1C/W/8IpFCaVQejaVVftq+eIgzwU/f2IsNHOA4II1Swlr0vTGa1Zp2y0Y5A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4046.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6506007)(6512007)(6666004)(2616005)(55236004)(31696002)(2906002)(508600001)(53546011)(26005)(186003)(83380400001)(86362001)(52116002)(6486002)(110136005)(5660300002)(31686004)(4326008)(316002)(66556008)(36756003)(8676002)(54906003)(66476007)(8936002)(66946007)(38100700002)(38350700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z0dIU0VOMmpEV3IvYStwU1lZT1lEMnpXS3BOa0FLNGxOeGxlbHVuT0ZXQldO?=
 =?utf-8?B?YUpyTDc4cC9lczNrL3oyc05SM1hHUjRuM1QxbU9XRXd2eFNlRlFmUUVSUWVY?=
 =?utf-8?B?SHhjNFNZNjdxdUF3WnZ0bmJQeTZ3aFhpOHpPdnFsVFQyMUpvaWYyWU53L2Vh?=
 =?utf-8?B?SmUzbmRwTUhWbGdDekJxalRpK3F0REptV0Q2WUpNUW1NakFGSDZwU0VaM2h3?=
 =?utf-8?B?UWZhQWRZamJaM1VhZHQ2cjVlMys5L01FUUFrbE8vSXY0TDhTQzg0dWFRQTRQ?=
 =?utf-8?B?NDJvNjg0Wm5Ub2JWNmZiNCsxcUVXN1ZtTmFaLzFxWklESytoVy8zSmN1cjU2?=
 =?utf-8?B?UFdFQi95ZWwvUzY1WFhQZ2s3NTI1T2NDcFRxL1pGRWJqTnN1NG9tSWlRYzZ4?=
 =?utf-8?B?TWJSOFQyWTdUanNyWmh3VFBTVDlzOEZvdzhidGVvRDNaWStONVZjWkZNU1Jl?=
 =?utf-8?B?eHowRlhRVndyeUJFZlh4VXM2MkEvd0lPMllIRzAxSjRZc2tUYThDQVNFVnRU?=
 =?utf-8?B?UnlWeDJ2d2NkN1dYUmFpb2NSVmFaUnZtM1N0Z2dLdkdSbWRtb1F2Q3VadHhp?=
 =?utf-8?B?azRMamU1U1hab3ZvNmVkL2tZaXRrK3NPTjd3OFhmRnZ0bWRHdVNYcWVkeXh6?=
 =?utf-8?B?MkpRbG55Slc5MGpEQ0ptZ01yNDJYZW1LMmIxNWhhZ2Z3Nit6VStmK2ZBYnJ5?=
 =?utf-8?B?YUoxRTNCM2prY0tkTXhVVmxUQzRDUXpISWVOVmxPVWhjdU10aFpmUjJ3UXhG?=
 =?utf-8?B?cTdlSGMrTm5taXFUcEFaWXU1MC9STW5paksrNm8zNUF3RHhBZ3dLYXF5Nzh5?=
 =?utf-8?B?MkNlcm42ZnVQMlo2eDd4NGFVSnpjeG1JQTlMMTVTSFA2dlhha1hQb3pLQVQv?=
 =?utf-8?B?blVGcGNLdlE2c3dEeFVFdnFQNDFsRjJieWtuZ3JDNUxSYkZIR2Q1SEs2aGpv?=
 =?utf-8?B?eU84dXZxSXN6Z2ZmaW9oRFlvU3Izd090NXNUU0tmb01DSG16YXVGZ0lEemdW?=
 =?utf-8?B?VEptUm5WbDNWazZVUEE4My9WYllNUWw2SHM1VGpWN0Y4NEpUSTFUSzVPTE5J?=
 =?utf-8?B?cmhJcDd4L1JMRm95ZWxvYWlwcWQyTVlLRmZrNW9aQ0llSm0rUjIyeHNvdFpV?=
 =?utf-8?B?Sys0N1BZR3Z2UmRya0N1ZWMxQlQwcktUdkZuM2QvQWNEakw5REZpaFVaakFn?=
 =?utf-8?B?bVJGQmp4K1pYQzYxalhWSVIrdzZwZXUwbVB6Z0xOdkZNU3BxcDdDTjU2OFBB?=
 =?utf-8?B?Tm9TU0tlWmJoRU42VXY3YVI2cGlXNGtwdjZZRmdRaERpbWJrZE52K3Z5S3Y5?=
 =?utf-8?B?TDZZOG9WR2pRTlgwWXJNZ01GRTBMZERzR2NTYnZoS21ieW53bXVxTllDelFM?=
 =?utf-8?B?SGZ0QnF3UWxHZmozcDJRT3haOHVNSVFpdEd4SXJSZnNWcU1xS1RwYUJUbkty?=
 =?utf-8?B?UnUxUERSb0lqeFVJL3hoMzRwVzh6OGpPUnhWS0g4dmtSTU9lU3Zzb3o4aGd2?=
 =?utf-8?B?eVRsbHh1bkk3SE1aZGQ5WmVDTUc3UHJYZUsxd0xwejVRaU1yd3FmOXkxM0Nn?=
 =?utf-8?B?a3pvWUJ4U05MS1pBWDRKZGttOVA0cjJuN3BrVmpCTDJEYWsxSGdCa3h0UktX?=
 =?utf-8?B?V3Z5eEw5Wmdrc21kNzlhSUdzcTM2b25NOVZ5Nk41TGFOcjhMRTBZZWppekhK?=
 =?utf-8?B?dlBhVVc3OVB0NjJ4VnV1Uzh3aGt6bHE4RWVYUE5FUEFZdjlUL3k1ZHNrbm8x?=
 =?utf-8?B?eXBsZTBXZ0h1OTdNejNheHV2azBia1B0cFRtN0RCbEppN0NJcHIwSjd6cXRZ?=
 =?utf-8?B?cTZSMmUvN1FRRXdMek4zWEJBUE9MN3FNckJ4Wll1UDgyakVSZGhQMDJzZ2Vn?=
 =?utf-8?B?ZHFQUjNGKzBnUFhLalNBSWVFb1JackJLKyt0ejdWQTd5NDdVaUpMc3MvbWVP?=
 =?utf-8?B?WlowQVZib1BMWlBTL1k4WjlBc3FSZXhVYUVDMWpOSFZtZ3d0bEpqemgxSFlp?=
 =?utf-8?B?N3RxcitCOUVMcEFoYklxK25TYWFUeGtzOVRyVXR4aGdRei94aWtiQmhPQzli?=
 =?utf-8?B?Nmt4M2RCVDRBdlJyVHRzQVRNTjV1SDcrd0R1Rlk2K0lzUFpST3Bpc0VQeXZ6?=
 =?utf-8?B?b1Qva0lONVRmUWFzZExNVGJDWVU2ZkVPb0xlUmF3Z2JjbnYxZWRJV3pYYm55?=
 =?utf-8?B?aVBIbU94Rjh1SHBISkhpbFR6bE5RTXlPNDhhdFNMeHNrM3BRSGcvenh4UmFG?=
 =?utf-8?B?L3p4a0JlYmYyTVJvM09iQ25YMWFRRVZTa1JrSmlnSFJCQzM1UTZMakpEYm16?=
 =?utf-8?B?Q1RmaE5JRkhyK2VrQ0RvZ05SMnFYenJ0MzEwd3p2VVc5K0RudDY3VDNsNHpz?=
 =?utf-8?Q?bzxsjZTB2dJJmua0=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec40e25d-1724-4dd6-eabd-08da17003fc6
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2022 12:31:46.7067
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9ZC0i+jZ9wxcPUBNmnGxPfQ+haYZe+bZ9vr6Gy862IQSBYKSl2hVi9qj5mjwsS6bijsyqp0Y17J9I12wIhA2Vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5560
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/16/2022 8:02 PM, Meenakshi Aggarwal wrote:
> From: Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
> 
> Add support for random number generation using PRNG
> mode of CAAM and expose the interface through crypto API.
> 
According to the RM, the HW implementation of the DRBG follows
NIST SP 800-90A specification for DRBG_Hash SHA-256 function
(https://nvlpubs.nist.gov/nistpubs/SpecialPublications/NIST.SP.800-90Ar1.pdf).
This should be mentioned in the commit message at minimum.

> Reported-by: kernel test robot <lkp@intel.com>
This isn't required and doesn't make sense once you've squashed the fix.

> +/* prng per-device context */
> +struct caam_prng_ctx {
> +	struct device *jrdev;
jrdev doesn't have to be saved in this struct, it's lifetime is very limited.

> +	struct completion done;
> +};
> +
> +struct caam_prng_alg {
> +	struct rng_alg rng;
> +	bool registered;
> +};
> +
> +static void caam_prng_done(struct device *jrdev, u32 *desc, u32 err,
> +			  void *context)
> +{
> +	struct caam_prng_ctx *jctx = context;
> +
> +	if (err)
> +		caam_jr_strstatus(jrdev, err);
The error returned by caam_jr_strstatus() should be propagated back to
who initially enqueued the corresponding.
For this purpose, struct caam_prng_ctx could be extended with an "err" member.

> +
> +	complete(&jctx->done);
> +}
> +

> +static int caam_prng_generate(struct crypto_rng *tfm,
> +			     const u8 *src, unsigned int slen,
> +			     u8 *dst, unsigned int dlen)
> +{
> +	struct caam_prng_ctx ctx;
> +	dma_addr_t dst_dma;
> +	u32 *desc;
> +	u8 *buf;
> +	int ret;
> +
> +	buf = kzalloc(dlen, GFP_KERNEL);
> +	if (!buf)
> +		return -ENOMEM;
> +
> +	ctx.jrdev = caam_jr_alloc();
> +	ret = PTR_ERR_OR_ZERO(ctx.jrdev);
> +	if (ret) {
> +		pr_err("Job Ring Device allocation failed\n");
> +		kfree(buf);
> +		return ret;
> +	}
> +
> +	desc = kzalloc(CAAM_PRNG_DESC_LEN, GFP_KERNEL | GFP_DMA);
> +	if (!desc) {
> +		caam_jr_free(ctx.jrdev);
> +		kfree(buf);
> +		return -ENOMEM;
Please fix the error handling to reuse the free code
at the end of the function.

> +	}
> +
> +	dst_dma = dma_map_single(ctx.jrdev, buf, dlen, DMA_FROM_DEVICE);
> +	if (dma_mapping_error(ctx.jrdev, dst_dma)) {
> +		dev_err(ctx.jrdev, "Failed to map destination buffer memory\n");
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +
> +	init_completion(&ctx.done);
> +	ret = caam_jr_enqueue(ctx.jrdev,
> +			      caam_init_prng_desc(desc, dst_dma, dlen),
> +			      caam_prng_done, &ctx);
> +
> +	if (ret == -EINPROGRESS) {
> +		wait_for_completion(&ctx.done);
> +		ret = 0;
> +	}
> +
> +	dma_unmap_single(ctx.jrdev, dst_dma, dlen, DMA_FROM_DEVICE);
> +
> +	memcpy(dst, buf, dlen);
I am a bit worried wrt. performance, considering the memory allocations
and the memcpy on the hotpath.

Previous version of CAAM PRNG driver was getting ~ 200 MB/s on LS
and 50 MB/s on i.MX8.

How does the current version compare?
Given that there's no prefetch buffer and there are memory allocation, copy
operations on the hotpath, I'd expect a hefty penalty.

> +out:
> +	caam_jr_free(ctx.jrdev);
> +	kfree(desc);
> +	kfree(buf);
> +	return ret;
> +}
> +
> +static void caam_prng_exit(struct crypto_tfm *tfm) {}
> +
> +static int caam_prng_init(struct crypto_tfm *tfm)
> +{
> +	return 0;
> +}
> +
> +static int caam_prng_seed(struct crypto_rng *tfm,
> +			 const u8 *seed, unsigned int slen)
> +{
> +	struct caam_prng_ctx ctx;
> +	dma_addr_t seed_dma;
> +	u32 *desc;
> +	u8 *buf;
> +	int ret = 0;
> +
> +	if (seed == NULL) {
> +		pr_err("Seed not provided\n");
> +		return ret;
> +	}
> +
> +	buf = kzalloc(slen, GFP_KERNEL);
> +	if (!buf)
> +		return -ENOMEM;
> +
> +	ctx.jrdev = caam_jr_alloc();
> +	ret = PTR_ERR_OR_ZERO(ctx.jrdev);
> +	if (ret) {
> +		pr_err("Job Ring Device allocation failed\n");
> +		kfree(buf);
> +		return ret;
> +	}
> +
> +	desc = kzalloc(CAAM_PRNG_DESC_LEN, GFP_KERNEL | GFP_DMA);
> +	if (!desc) {
> +		caam_jr_free(ctx.jrdev);
> +		kfree(buf);
> +		return -ENOMEM;
Same here, error handling at the end of the function should be reused.

> +	}
> +
> +	memcpy(buf, seed, slen);
> +
> +	seed_dma = dma_map_single(ctx.jrdev, buf, slen, DMA_FROM_DEVICE);
> +	if (dma_mapping_error(ctx.jrdev, seed_dma)) {
> +		dev_err(ctx.jrdev, "Failed to map seed buffer memory\n");
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +
> +	init_completion(&ctx.done);
> +	ret = caam_jr_enqueue(ctx.jrdev,
> +			      caam_init_reseed_desc(desc, seed_dma, slen),
> +			      caam_prng_done, &ctx);
> +
> +	if (ret == -EINPROGRESS) {
> +		wait_for_completion(&ctx.done);
> +		ret = 0;
> +	}
> +
> +	dma_unmap_single(ctx.jrdev, seed_dma, slen, DMA_FROM_DEVICE);
> +
> +out:
> +	caam_jr_free(ctx.jrdev);
> +	kfree(desc);
> +	kfree(buf);
> +	return ret;
> +}
> +
> +static struct caam_prng_alg caam_prng_alg = {
> +	.rng = {
> +		.generate = caam_prng_generate,
> +		.seed = caam_prng_seed,
> +		.seedsize = 32,
seedsize should be set to 0, HW does not need an externally-provided seed
since it fetches it internally from TRNG.

> +int caam_prng_register(struct device *ctrldev)
> +{
> +	struct caam_drv_private *priv = dev_get_drvdata(ctrldev);
> +	u32 rng_inst;
> +	int ret = 0;
> +
> +	/* Check for available RNG blocks before registration */
> +	if (priv->era < 10)
> +		rng_inst = (rd_reg32(&priv->jr[0]->perfmon.cha_num_ls) &
> +			    CHA_ID_LS_RNG_MASK) >> CHA_ID_LS_RNG_SHIFT;
> +	else
> +		rng_inst = rd_reg32(&priv->jr[0]->vreg.rng) & CHA_VER_NUM_MASK;
> +
> +	if (!rng_inst) {
> +		dev_dbg(ctrldev, "RNG block is not available... skipping registering algorithm\n");
> +		return ret;
> +	}
> +
> +	ret = crypto_register_rng(&caam_prng_alg.rng);
> +	if (ret) {
> +		dev_err(ctrldev,
> +			"couldn't register rng crypto alg: %d\n",
> +			ret);
> +		return ret;
> +	}
> +
> +	caam_prng_alg.registered = true;
> +
> +	dev_info(ctrldev,
> +		 "rng crypto API alg registered %s\n", caam_prng_alg.rng.base.cra_name);
driver_name should be printed, it's more specific / unique.

> diff --git a/drivers/crypto/caam/jr.c b/drivers/crypto/caam/jr.c
> index 7f2b1101f567..11849362f912 100644
> --- a/drivers/crypto/caam/jr.c
> +++ b/drivers/crypto/caam/jr.c
> @@ -39,6 +39,7 @@ static void register_algs(struct caam_drv_private_jr *jrpriv,
>  	caam_algapi_hash_init(dev);
>  	caam_pkc_init(dev);
>  	jrpriv->hwrng = !caam_rng_init(dev);
> +	caam_prng_register(dev);
>  	caam_qi_algapi_init(dev);
>  
>  algs_unlock:
> @@ -56,6 +57,7 @@ static void unregister_algs(void)
>  
>  	caam_pkc_exit();
>  	caam_algapi_hash_exit();
> +	caam_prng_unregister(NULL);
Unregistering order should be the reverse order of registering.

Horia
