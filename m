Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29DF0511723
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 14:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233094AbiD0LwA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 07:52:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232970AbiD0Lv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 07:51:57 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80059.outbound.protection.outlook.com [40.107.8.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A579366A7;
        Wed, 27 Apr 2022 04:48:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iKC04nZ5cF3OP1JS8RSfNPz3cz/6TOM27YrgAMbDO9sIWdIVMQ7jiOzjBOLRa25CGwiMB1t0A6+P5yD1uhTBkzQwGJmr5QZtzQ6xiRgwxKZvLqsWLpc8ooCiWtzMAXI7MxLzkBKeKcD5FSi3cxNXhU61KpNVp9qoP5yEqJufkQLVExoE94WEPVagFPhS7iss4Hl0PltEEVb5+1+1Pm8Wr2hcZ6HAXURV+2ZHR1r0wBhdJ6Z6sfdwHEUm06NcpcQUO9oxNWOrxel24ywfFRq065hYlzbyKUc9rYWPNhHwchAkONRAL3ytdeMC1UcMCHrfHsL2t20ekfVZSqY84e2rRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mp/47kbsaBPL1mgy4TNM5XQzWOzvsy0dzU+HAdN+QRE=;
 b=kFHcsujSreSc4UZl/N2XLl6QlEo0phrJnQQHbaCgJZEfpC9Um/slz6YRXz8hgjyw72NmF/x7oXmXXxU4KdS7Rcyh8DzVS/KrFbkpT2QDZFGqTOzAErajAV2QbghjCnGASQY9lX9Ya4RigCgf55fLeehGyaPJpX3uDfi58SzmRLUIeGAY3a2mOn81gFB2ihrPoM8D0KRqzw2AOBO10N/Kq9wI8DdHOHFdLQcb5XD3tou1+uWaFHmenHGmi2ms7l/NXxFI//Lmx6MBklof1DtZA57CtkHHNb/e6BnTeHvcEwXarxSIUxxbCcoR9ogeKqh9hEu8ogxh8TPCIv0AHB3pag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mp/47kbsaBPL1mgy4TNM5XQzWOzvsy0dzU+HAdN+QRE=;
 b=Hxx2pCiOCB7PjPws88J6oQmXpWYZwyta8TsewGsLu+btqn7e6+B2Y+0DO7NzeHGec0XzwivKW4OJhv9LVZ2LejYSKrj9Q44tN8Zw8rji6zHj5TnG5malawRnNyuYKJHx80PtotteU8oK94wQ4YkSakx+esLhEWGEac3htRt37gQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9517.eurprd04.prod.outlook.com (2603:10a6:102:229::20)
 by DB3PR0402MB3836.eurprd04.prod.outlook.com (2603:10a6:8:f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.21; Wed, 27 Apr
 2022 11:48:43 +0000
Received: from PAXPR04MB9517.eurprd04.prod.outlook.com
 ([fe80::ecbc:8286:8006:fb5f]) by PAXPR04MB9517.eurprd04.prod.outlook.com
 ([fe80::ecbc:8286:8006:fb5f%6]) with mapi id 15.20.5164.025; Wed, 27 Apr 2022
 11:48:43 +0000
Message-ID: <f67acb13-a48e-763b-dce6-d3867b0e4965@nxp.com>
Date:   Wed, 27 Apr 2022 14:48:39 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v3 1/1] crypto: caam/rng: Add support for PRNG
Content-Language: en-US
To:     Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
        Pankaj Gupta <pankaj.gupta@nxp.com>,
        Gaurav Jain <gaurav.jain@nxp.com>,
        Varun Sethi <V.Sethi@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>
Cc:     "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
References: <20220304114123.3762649-1-meenakshi.aggarwal@nxp.com>
 <20220420063808.1089283-1-meenakshi.aggarwal@nxp.com>
 <20220420063808.1089283-2-meenakshi.aggarwal@nxp.com>
From:   =?UTF-8?Q?Horia_Geant=c4=83?= <horia.geanta@nxp.com>
In-Reply-To: <20220420063808.1089283-2-meenakshi.aggarwal@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM4PR0302CA0036.eurprd03.prod.outlook.com
 (2603:10a6:205:2::49) To PAXPR04MB9517.eurprd04.prod.outlook.com
 (2603:10a6:102:229::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a9037b32-ae06-4c82-3f4b-08da2843e149
X-MS-TrafficTypeDiagnostic: DB3PR0402MB3836:EE_
X-Microsoft-Antispam-PRVS: <DB3PR0402MB3836FA0464EB7B8E366C7E5F98FA9@DB3PR0402MB3836.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WuKA7qlW7hTbAu4H2J8goBBexG1dOjGxMMs8cSlqr73FFkqRovA3VpZxh3BKDjww124cMWbzWTYs2i4KfcpWFobBkhRLFya78HBBdyEuDFdloK4M3LhmrbFIYWoWHQUMA5ny5FLogSRgxnASBV4rMOT9LmVYx2PZso66iIZ9jyhxj5xCHJjYWGp/CaFTLctPF8jfjjZzXDvkXfypnEAZKHAjd0KAaKGuMwO1bNO8PPtcvRfNWRLRrNobYa++QGw+5QZ1QSR1ossiPO+Q1FSi8UciPTTIqpXI3CpbBtGfWab+n2LLfuJ3u7XG0KorsJC+PC/ghOuVLVAiQxylHOs6HFWi83DISiDjUjck2ZpyTSJv13FUpXbNiesTHJrWPV1y3iJZCzIyhBMLmsVFCsqmaFgQdXPZhD5pj2x4ndulm13N4a7dMDsB/FU41MVak1xUszLb33sW4TmoTUr4fwVxXS23UXP4iMNuVhmZh/Ksm5uoO5jWbCHkbCIkdSwM9QnQ9wNmubcC1BG5CoGyh53/jF22MJK3ptQvKtH3M0XCdGWPlMcybDYSR05gqevWaUQO8+AHetgKunGB0gGe40aMVd35sRWAz2pj1v3VLfIVdkvivjUM93cNznFwqaTL33+aWR/PHNjOhTIqiKUdLmjkeZ/YWkaUptF7fEyt8rwZ7gCzoGjm+bVtaH0XJTWyHHbZ98+8AyIXyTAozErPu2APJYNHvC9ahArtKrwI8PXtIxHbh9WKVknxgr9b2tP/QRxWCkj2i7/BHiHocixpB8pk0w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9517.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(26005)(6512007)(6506007)(6666004)(86362001)(55236004)(31686004)(83380400001)(2616005)(186003)(31696002)(8936002)(4326008)(66476007)(66556008)(8676002)(2906002)(38350700002)(53546011)(52116002)(5660300002)(38100700002)(66946007)(36756003)(110136005)(6486002)(508600001)(316002)(54906003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N1BiTHVaaGZLOU1IRWRsZkNhcnQrZDNkWndzRkQ2UitELzliSHlqNWhBdnpt?=
 =?utf-8?B?Q0FxWXV0N3dURWtsbWFLclo1VU1vQzZnRmplYkQ1ZmtQUlhtYnpCcGgxRFlE?=
 =?utf-8?B?UU0xYVF5ZWE0Sk1xaUgyOVhCRVU0SStHS1lRNHFpbzhXK25oaWlOWjFabk4w?=
 =?utf-8?B?a05rQlVScmdCM08vQUNJM1JqcGRHb2tKQW9lMnlLbVI1NjExRXVxN3Zxb3dl?=
 =?utf-8?B?cHozOWNhb0hLY0x3WnpSa2pDbXhRTjgrVjYrRUFSZjFaaG01UEFTVENUeXpJ?=
 =?utf-8?B?Q0F5OXpMZTZubUo2ZndtUWVHYW9hd2VRZUh5MDh6TWxsb1B0M1FPcjBTYkVW?=
 =?utf-8?B?T2kzZ1JidEV6OUVVaTE2VHpUeGxtYlBuYndDNnpMRTJVblFwZEcrOEwrbkd4?=
 =?utf-8?B?aWVUSG1pNVhGd3hIVW9jYmZYYlVzZ3lCYTRZZzd6cjl6TkhkeURBVDNGUXdj?=
 =?utf-8?B?a28zQmI2TFplWitFZ1hmSDVpbmRXcGdTR2dVWlBCVVRWVElHcTgvOU1wOTRn?=
 =?utf-8?B?TVNQVDBrTERzeW9rYlNtVXYxNTQrY25weGt5Y3JGQnpPd0I5RHNmQkJuWmdD?=
 =?utf-8?B?dVVyNlZpem9rVWF4VXRER0grakwvTGNnalpEV1V3TjNmU1FMOEVqVVZrN3JT?=
 =?utf-8?B?ZlBWbU5FNnVmNWo5M2JQb1laRkN6UHREL1ByWW1UUlk0aFhLMVF4UXc2RWdN?=
 =?utf-8?B?RXkzSWVZN2FLT1Jsb25CeWp3elVlL0ZDdFFseUdBekFkRTUyNXpWYnErN2U1?=
 =?utf-8?B?ZnNkbzdNaXNVS2o2SStEdXlvWlJJQXNkSGxUTTczWk1heWhEV3hURFpFaXBV?=
 =?utf-8?B?d2YvcldIUWpnQWpESHZFVFVpSzhrTVpNSUpRN21KRHQzbFg1UlIxNDQ0ZFZs?=
 =?utf-8?B?Q2RncmJiMUlJaW1LYmxvSURlUGUvSVpIZTdYTmtLSkRJVkZVcm5ybGluY2lm?=
 =?utf-8?B?WW9SZEVEMlhhRTh6a3IxTmNQSkhJRHlXTE84NDI3LzB1elB0Y004OGEwTTZQ?=
 =?utf-8?B?SmwyMUtwSEVZaHFFa3puVmRPSGU4OG9CZW5sZXdmWWZKUXpTOGtaVjR3U3Qz?=
 =?utf-8?B?Z2oxQythc29TWGE3aXNnY25nRVJWOVNISWhxMzVrckl0aGduN2tIOEdZRFlV?=
 =?utf-8?B?aUNJYzFuUDhRSEhMaFJUY1Rnc2ZQVlVGZUcvY2RBUFhMMzJLcFh5QkVVR1h0?=
 =?utf-8?B?dXQ3R2NpbFVjMEJtcXB1RWVNMStGOWsxSDY0eU93Wk5GZGVhNC81UGlFNHNL?=
 =?utf-8?B?a0VYQjNCQ0k0NE5YNVhYc3ZnNEN4QzNoTUNwQ0tzUzN1aFBITU54NE1LY0VP?=
 =?utf-8?B?dEZITFhKbVdJM3dVTHZXSldsUm9GeWErQTc3b09pM3gxanduZ2t6Wng3VGtB?=
 =?utf-8?B?Y05aM0VzSm1EVFhsLzVuakdDTEtYZEduR1hZMnRPcFF6VmVlUzZUaFZpa3NK?=
 =?utf-8?B?MXQ2bTZHbG4zR0E0aFp4TEsvVjhjbWQ5TDhyQmwyVTNtQVh1VWZZYVVSdlQ3?=
 =?utf-8?B?aUdjQ0g0RDk5NGVVVHBMZmYzcUE0clFBL0l4bWthd0g1NnMzOEVyeURxOU9j?=
 =?utf-8?B?ZmZrNVhyMkZxalpONTJldENsRVNxQlluVHJ0dWtmdS9MS3NCU3MwTmh3aUNk?=
 =?utf-8?B?WThaSFpmU1dIUHRyRDVPc3RoWHd1WlBVUXVaTjVKczgvbG85cjNiS1VIazdV?=
 =?utf-8?B?TEJXanlOV2oraFQrQ2JJQ2R4OGdVUkt1TmZjNm16ak1WblJyMWRvT3JyODF3?=
 =?utf-8?B?ajlSbUl4TlFwaDhsWVFRbnkzZ25mcXh3TzBOSDZvUmZVQmdneDRCSjJsRE1k?=
 =?utf-8?B?djFoS3JYTmZ6WUtxdmd0WnN1N0Ywejh6L1ZBSkZSTmpKL1BndkREM29rNllD?=
 =?utf-8?B?dnZ3dkFTM29zSUFUbkUxZW96QTUzRFNiZG5aUElLNmhja3RIcmdmWlYvYkRn?=
 =?utf-8?B?YVAxSFNOYjJOQmNHSGlHMWpnZ01UV3NoSWxMTTJEK0NYclhzZlk0NFFCZGIy?=
 =?utf-8?B?WE52VmFhZVNSVSt2ZWJZUGZIT0VpYnhOaEExN1ZiM1gzR1g5MW9KS1ZKalRk?=
 =?utf-8?B?eEhDZWhrZkZaRGVWVkt0TGdXc2NkU3BNTytwR0xwdVFiem8wQXg0RDBSQXN3?=
 =?utf-8?B?ekxCT3NuNFVQeDQ2VGVtMW5CQnVaSVpWUkx0dHRGOHY1VzlVUndyMytQL3pT?=
 =?utf-8?B?ZzYvSGNxa1BBU0FzbW9LY0M3ekNxbTgreUhoL0pOOGhHd0p1RjEyVEJ5ZWlj?=
 =?utf-8?B?K242NUJlcXJYVm5WajN3TkhJQmRUYUFUaDA3Njc3ZmYxWDRBOEh0V2FrTDJ2?=
 =?utf-8?B?aDJwcGh3Tk90Ry8weXJuNEp5dG8rbFdyMWZKQlZGOVRPVzhHRk5RSWVvdStq?=
 =?utf-8?Q?BZ7Aw9l/lH9UoKys=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9037b32-ae06-4c82-3f4b-08da2843e149
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9517.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2022 11:48:43.8405
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hrA/BSA8HIWOqqtJvMQW6NyxFAzxe7BuQkjPIcx0YHUJN6bi0gWLszqmHrwTJ42XQxGEYPCkBDVCdr+D+iloUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3836
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/20/2022 9:38 AM, Meenakshi Aggarwal wrote:
> +static void caam_prng_done(struct device *jrdev, u32 *desc, u32 err,
> +			  void *context)
> +{
> +	struct caam_prng_ctx *jctx = context;
> +
> +	if (err >> JRSTA_SSRC_SHIFT)
> +		jctx->err = caam_jr_strstatus(jrdev, err);
The details of error handling are in error.c, let's keep this abstraction.

> +	else
> +		jctx->err = 0;
> +
> +	complete(&jctx->done);
> +}
> +
[...]
> +static int caam_prng_seed(struct crypto_rng *tfm,
> +			 const u8 *seed, unsigned int slen)
> +{
> +	struct caam_prng_ctx ctx;
> +	struct device *jrdev;
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
> +	jrdev = caam_jr_alloc();
> +	ret = PTR_ERR_OR_ZERO(jrdev);
> +	if (ret) {
> +		pr_err("Job Ring Device allocation failed\n");
> +		kfree(buf);
> +		return ret;
> +	}
> +
> +	desc = kzalloc(CAAM_PRNG_DESC_LEN, GFP_KERNEL | GFP_DMA);
> +	if (!desc) {
> +		ret = -ENOMEM;
> +		goto out1;
> +	}
> +
> +	memcpy(buf, seed, slen);
> +
> +	seed_dma = dma_map_single(jrdev, buf, slen, DMA_FROM_DEVICE);
Now that seedsize is 0, the .seed callback is called with slen = 0.
Reseed descriptor should be updated too.

Horia
