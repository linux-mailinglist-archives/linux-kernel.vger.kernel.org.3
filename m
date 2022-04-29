Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A6505147B7
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 13:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358066AbiD2LFA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 07:05:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358032AbiD2LE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 07:04:57 -0400
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-eopbgr20073.outbound.protection.outlook.com [40.107.2.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5BE2E39;
        Fri, 29 Apr 2022 04:01:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=INwuR0fL2SwieOLKLhSW7075ti3CfU0WlDtjWLBfHlpkKuWFQoPpC/5UBm1fNjETBYYZfpq+r7b8jh2KfL7s1tzXEWH3RXIxhHFiF7BjhediL4ZW3jV8TarPnqaNcK7mPWIae5XS4xao4VBwByIvM7qG5ztr7BCicnPskWDikPWG/7mia2c5HMzu5VzI4lTi9v06QfzIHSKfEOIvF+xrOYVI2l66nkgHHCIKPdbrPLVAixzYs6l700k0wlx2pGMPCjxJSu2ZqB2Oqjth04Eizndfqgx4FY5eveQKBit7tKPFWV5OiQkg0S+w+ctCE6xkfw0e1qC4dCsJijyfVW3CVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UwjikB9rE9DLU2eUUu5tBdsjAjQN1dpbNE6ggMOLmSw=;
 b=FKsRpUca6EZdyHO/d6KHm0NagnEUwXz3HuxkEJ09NxUl5ORy6L6t/ltDih2kTx9rH1K+Al0MN/S6bcnlWadBJEzf1SOwwK8DUoi+zV361vApep6UV5eGa/Mdn9gEU6DBBYjpMugmJWxeraEnFbMPzJ12WRni9NwFiJAWi9yePWUpEVqVG2O95uDR/5bkCgb0xYitXYIok6netaQF5olX0gbvX7ppKk0XT8fy3Is7o0FEkafHuiz+VzyUKASe2x1BoRlfRpp37b62PVfFOue0CKXaaashiQmISL8Q4YIJh4r3kH96QVWYgF1G4O+zEmryRvfBAe/X1R/DnvsuX5HWXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UwjikB9rE9DLU2eUUu5tBdsjAjQN1dpbNE6ggMOLmSw=;
 b=KSVjv+u5hA2Il4GE6989KSKAsXNYfF/v1EdnTRSGxAhupgbVpqALhEisxwErZI3CY8dt/3W49oy4c8AcqvsqY85s8AQtDrmRa2T0Ye2TXIzbiT8Uck4/ziQX5nC5hWriLRQUnfgDIu2RrGaEWPqw1bKyPSReBuOUh3uNziuoGyc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9517.eurprd04.prod.outlook.com (2603:10a6:102:229::20)
 by VI1PR04MB4912.eurprd04.prod.outlook.com (2603:10a6:803:5b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.14; Fri, 29 Apr
 2022 11:01:36 +0000
Received: from PAXPR04MB9517.eurprd04.prod.outlook.com
 ([fe80::ecbc:8286:8006:fb5f]) by PAXPR04MB9517.eurprd04.prod.outlook.com
 ([fe80::ecbc:8286:8006:fb5f%6]) with mapi id 15.20.5164.025; Fri, 29 Apr 2022
 11:01:36 +0000
Message-ID: <8878ca42-6660-2d02-5bcd-2b4be4373914@nxp.com>
Date:   Fri, 29 Apr 2022 14:01:33 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v4 1/1] crypto: caam/rng: Add support for PRNG
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
References: <20220420063808.1089283-1-meenakshi.aggarwal@nxp.com>
 <20220429084527.2069402-1-meenakshi.aggarwal@nxp.com>
 <20220429084527.2069402-2-meenakshi.aggarwal@nxp.com>
From:   =?UTF-8?Q?Horia_Geant=c4=83?= <horia.geanta@nxp.com>
In-Reply-To: <20220429084527.2069402-2-meenakshi.aggarwal@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM8P189CA0004.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:218::9) To PAXPR04MB9517.eurprd04.prod.outlook.com
 (2603:10a6:102:229::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 36f03009-d214-48cc-b124-08da29cfa095
X-MS-TrafficTypeDiagnostic: VI1PR04MB4912:EE_
X-Microsoft-Antispam-PRVS: <VI1PR04MB491287D3A5AC99553CD4B44898FC9@VI1PR04MB4912.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7UaX4ZcRaEOeet/ORa589fcJwjRE/UPpzAB3Y2l4pykByMHgAVxkWdvfZ0p6vgX9gIfVEmqQPj9PqnD3YZxVINLqgQVlfuNgsPaoPOrTHSfetLqvtD27w2jE5VQOK5/qeesDL3PDidRrq+grvIu3v1CfAy+/HIYtQ1Ho5/KcJF+B1kHA7ggodV2uIFydIoYdr5i4UTR6LPNoT+5xDST5Bu/OCSTWPRQwF9+0EZ2UkENjK0jm6kzf1L8d5S1/FNRHK0eRZMVS90GSE8CGoqduOr3ZEC82ckoXmav9+XFnT7/hsc+BoMbfTzkpJl47eSMQha4T8pljaL2OLfqg8mqIbaC0YLzC+TInamhamfopzaMRb2i+Rlj4FsRaeqSkRYK4Yca5Ag8/LxMTQR9zsVG6zyZiQ54ca3D/cfhTnr4jTssvGctvBi9mu7c/dqvg2fNF1Ujd3nefO4eN6cQpmUjRkc3uPus9rqb9PfeCcEKhiwpVJ4n4eMUvsWEHU0wwVc0bujtex0JNVQijEjCzl54h2Tsz4dEaORAbxPKO5x64s4kcP9hpihqNXvlNmIOON4eHCOrOIG+kUkcD7FzrVkX+Z+eU80kDWGu0WynnZM4fDDtzOghLxJH7RStu3IPJqMz1JuJPtynde03Ys0Why3+F+3s3EUEg0pXit7Aml+e+rlzjhwnMLieIoDmu4wjj3RI+ueQzRIGxesrdCWaxfWR2O4KxgmYrz9+3oaYJCe39rkCMBWJMiPiUD54kYKcQ21G5hP7c5AaCQeU0O0rP73bfew==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9517.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6666004)(31696002)(5660300002)(8936002)(6486002)(2906002)(36756003)(508600001)(38350700002)(38100700002)(66946007)(66476007)(66556008)(4326008)(8676002)(316002)(186003)(52116002)(6506007)(53546011)(55236004)(54906003)(2616005)(110136005)(6512007)(26005)(31686004)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b29TSzRQbkZuekdVSXppN2Y3ZVRKWjdreVRXcGhQKy80a0hSejN3emlZZVEv?=
 =?utf-8?B?MTJMZ1g2eU91NEYvQ2xJQ2F3Y3UxcmdnZnlXczJBTjdQMmZUYWpxblZwdlA4?=
 =?utf-8?B?cG10eHAzbis4Um5zNVNjcVBpSWdZQmxYZ3JVdmRqcTkzU0duTWY1Y0dvTTNr?=
 =?utf-8?B?cThJR3J4QkowSDlQZ0hOOW96QVNmcm0wWDJFOG93c3NDV1l1RjZEbm54bEh3?=
 =?utf-8?B?ZThQQ3B1QzFDUk1rM3RlaFVkeVhJdVA5djNBMGZCemh4bEF0RjA5VGFjZDJp?=
 =?utf-8?B?N3Y5Q01ZWC93Q2NzMUhUL0twdm1SUjA0dGZWT2JiL0xNUm1Fa1FHNElxZGVa?=
 =?utf-8?B?cVhDUDNtQmt2RXYrMnRjdGh5T21QdHJzQmMyL3FrRE41SnlVeHZIMHJNMzli?=
 =?utf-8?B?U3pUbUpxWDhPc3lVaWxBTlpPNW1LNWRvNC9EWVhDM1cwTkFlUEZjck9yeWFQ?=
 =?utf-8?B?WGR6L2MybnV0WlRTNkloMkZSaHo0U0pDbjB3dHFzd00yZi84bkJvWFpOWEdm?=
 =?utf-8?B?TExjWXZXdi9UYTdqZ1pDK2ZqcnRKeldsMnQ5UFROMmUzb1FKQ0FKRThmWFA5?=
 =?utf-8?B?UVdRdXlsazM0QzNpTUNsZjZMQUVKNVNjd0R1RnRkcmM5b28xanpCaWhCRVVp?=
 =?utf-8?B?UmdwMmxPTUpha3J2Z3F2SVdOb3dXbzkxNnBGcHZqcy8zeE9VZnQ5QnpRcENw?=
 =?utf-8?B?ZUJkTzNHM25CSlc3TWNnUFN6eHpxRytUQWxyVTRxOFEwUkxlZkk0SFdxNjg4?=
 =?utf-8?B?TFpWTWVhT3BjRStpSDNGVTBGd2ExS2JmcE1JbXBrM0krMXZHdUNUanhFUFBX?=
 =?utf-8?B?aFV5cG9lRllDTTQrMHdFdENJNVlwaDlTMUZIVktmUHJncXl1bms5UHpPVnZj?=
 =?utf-8?B?Mk1wZDdtVUtvOUY4dFlkS0RYTFR1WWtVelY1c1ErWE9RRkwzY2x6R1NRU3Nk?=
 =?utf-8?B?Wmt6Q3BSVUxwTGErQzRZWmFaaUU2d2RDcE13VE1pQ3h3a2czZXBHRDVGRFdp?=
 =?utf-8?B?RU9WNk96UGNvcnRRSVZjYVdlOEhBZkR4dEtlVXRtN1VldnpmbnNUdThrZVZp?=
 =?utf-8?B?V0hxd3lQSEZpR3IrMnRKbDh5YXpDeDdncGRLQkNjVDBTSGh4VmZNUmZDZytN?=
 =?utf-8?B?MG1jRWlzQitET3B4SlNaUUtodEt6RzFXdVNoUzB0eWh5WkJxd3Z1YXo4NnNn?=
 =?utf-8?B?QXc3cGlLMmZQZ2FiRFcrOVh5ckhlK1hDZEY1cWNHdGxzWm5oeS9qT1greFNl?=
 =?utf-8?B?ZFEwQ2RRVTNieHFTdjNMMHVtSmFkK0pEdjFwdXU3dzRxQmlHQThUNjdMYXRj?=
 =?utf-8?B?Q1N5VGk5NTJaQzh1dFJsMytYOXBId2xwOVBoR0tUUE1FQ3dzWXdQUk9sbnhG?=
 =?utf-8?B?a0pLWEt1cEJjb2NrUUVId2U4RG9Sc2F1MmJmNFRFemtNRmpaZHlYZUYzbTFP?=
 =?utf-8?B?UjZ5VGNGRkhiVlhXVjdEMkRvVmdzbjVpaC83VHdOeHA3dXhGTExwWStuMWZN?=
 =?utf-8?B?RDdCY2xUOVRCVkphZTFmc2JLUm00cWhzSkJIci9ocG9hcUhqa3FkbTRnS1Vh?=
 =?utf-8?B?WGQ3K2hpVjlVZThwaHM4OEpVN0ZFbFRmeDhUWmJOUTVJUW0rWHlJNnc4SmdC?=
 =?utf-8?B?REMyN3FIVElvTE55MzREaFdyRm1rUTIrZG14QlpmN3BCc09LNHlpcEIxbGR2?=
 =?utf-8?B?Y3EwanVIUFhNZjJyeXRremNaQ08ydDJVbGlmUlFEREl3cllyNlN5MkZZTUtp?=
 =?utf-8?B?a05ES0Y4c3V0alUvK1pCT1Y0NCtuR0gxZ2FYOHlKcVJBY2V5aWVKMHJ3YUx0?=
 =?utf-8?B?RWRKMWlzNTJOaWpJLzNqcXFVVnVOZzcxSmJvNWs4Zml6NzNrMWw1Q2dWblVQ?=
 =?utf-8?B?UFJNaThGYkdBSXM4S2VZbUFIMElGR2k1aWQ4VTAwQUVvNDBiYWNSMnovSmJQ?=
 =?utf-8?B?N3F4TENmKzZ0dmgxVlF4N00yejNWNmw5cEhrQTJFUHlxK3FFOEVIWjVCWjN4?=
 =?utf-8?B?bDRQelhTWXkzZ1E5ZFBPYzZxRCsvbm9CVUtsV3kxaE5zSExJa2NhdFZLNUFI?=
 =?utf-8?B?MTVXWlpDZ2hJcEVZZU01NXRqVGZyeDh1V2llSndhSUNGeFVtMGZLaUlUdGdM?=
 =?utf-8?B?QzU0WmhsazhVMWk5cThNaFZ4T01WdFExRU05VDdKME03cER5TWlEbzJadG44?=
 =?utf-8?B?b09WUjR5UkEzMzhDWVU0SnlNZGM5cEpkcnI0dkRDb1U5NlNtMWh0RU56MDJ4?=
 =?utf-8?B?ZVFQaHFZczVHY2J1QU41REZ5TVN3dzZ1N01JU0VSZHVIbVRESWdLTTd2cFR5?=
 =?utf-8?B?M0NCUHBWRVU0R2tzSGVaditVMHpHamRpek5GdWdpUDhVd3ZSaGN0TzRjZ2h5?=
 =?utf-8?Q?JM72p9z1RIngT07U=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36f03009-d214-48cc-b124-08da29cfa095
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9517.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 11:01:35.9698
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e2zQIZRMMETOboZ+H0zSkOd+AC9Sf3h++pjKVv3fh5nd5Y1AP5RFMJ0afb1YacbNh8c9SYQ4vslQbxNTGH4aDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4912
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/29/2022 11:45 AM, Meenakshi Aggarwal wrote:
> From: Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
> 
> Add support for random number generation using PRNG
> mode of CAAM and expose the interface through crypto API.
> 
> According to the RM, the HW implementation of the DRBG follows
> NIST SP 800-90A specification for DRBG_Hash SHA-256 function
> 
> Signed-off-by: Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>

There are a few nitpicks below, if you can address them great,
either way here's my
Reviewed-by: Horia Geantă <horia.geanta@nxp.com>

> + * Length of used descriptors, see caam_init_desc()
caam_init_desc() does not exist in this file.

> + */
> +#define CAAM_PRNG_DESC_LEN (CAAM_CMD_SZ +				\
> +			    CAAM_CMD_SZ +				\
> +			    CAAM_CMD_SZ + CAAM_PTR_SZ_MAX)
The reseed descriptor length is now smaller.
Memmory allocated by kmalloc() will probably be the same,
but code would be more readable.
If you want to use the same length for both descriptors,
I suggest renaming the define to CAAM_PRNG_MAX_DESC_LEN.

> +static u32 *caam_init_reseed_desc(u32 *desc)
> +{
> +	init_job_desc(desc, 0);	/* + 1 cmd_sz */
> +	/* Generate random bytes: + 1 cmd_sz */
This is a "reseed" operation, not "generate".

> +	append_operation(desc, OP_TYPE_CLASS1_ALG | OP_ALG_ALGSEL_RNG |
> +			OP_ALG_AS_FINALIZE);
> +
[...]
> +static int caam_prng_generate(struct crypto_rng *tfm,
> +			     const u8 *src, unsigned int slen,
> +			     u8 *dst, unsigned int dlen)
> +{
[...]
> +	ret = caam_jr_enqueue(jrdev,
> +			      caam_init_prng_desc(desc, dst_dma, dlen),
> +			      caam_prng_done, &ctx);
> +
> +	if (ret == -EINPROGRESS) {
> +		wait_for_completion(&ctx.done);
> +		ret = ctx.err;
> +	}
> +
> +	dma_unmap_single(jrdev, dst_dma, dlen, DMA_FROM_DEVICE);
> +
> +	memcpy(dst, buf, dlen);
memcpy() should be performed only when the HW executed the operation
successfully.

Thanks,
Horia
