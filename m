Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FA424E90E7
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 11:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235184AbiC1JQe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 05:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239729AbiC1JQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 05:16:26 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F226A53E06
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 02:14:44 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22S8AHp9030601;
        Mon, 28 Mar 2022 04:14:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=PODMain02222019;
 bh=9MeTAIQrZLpAgh/ZQgdtdWZY70IfagMUFdBkUapJ9us=;
 b=N9cKguDMexYHdUW36Jy06Q8o/S4FWpvuGDg+yfqSYyWoZwtQz0lMcWZFlS/bFa+1SiLq
 MDrys3gDhKTsE3QJJMqVJKWvWRgfh+qfH8ZIs1l6HzfoXcIgBDkq+JocsuAjMGipxEB0
 AdNF/QpYDCVM0KRXTxpnagEpNEQeD9mgvChCocjJFUGYUNF4M8v26qsaPcjFg0Bxsqyz
 VxNwMCFkUCOwJcZvlPFN00Mrrj3USInaYbFgz++xsxahKEn+n24bhS8ALlAxf4Z+FXow
 kpYpmwP6ROXRWdg3pAvgcFXqBfON99lp11JZ+Yq9SYJpZrv792bx60I4to3hOgKjykja 5A== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3f2081af9m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 28 Mar 2022 04:14:33 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 28 Mar
 2022 10:14:31 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.24 via Frontend
 Transport; Mon, 28 Mar 2022 10:14:31 +0100
Received: from [198.61.64.146] (EDINB751011.ad.cirrus.com [198.61.64.146])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 20CCBB16;
        Mon, 28 Mar 2022 09:14:31 +0000 (UTC)
Message-ID: <b6e2eb33-7f3c-2b04-210f-81a9996cba79@opensource.cirrus.com>
Date:   Mon, 28 Mar 2022 10:14:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] ASoC: cs*: use simple i2c probe function
Content-Language: en-US
To:     Stephen Kitt <steve@sk2.org>,
        James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
CC:     <patches@opensource.cirrus.com>, Wolfram Sang <wsa@kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20220325170734.1216018-1-steve@sk2.org>
From:   Lucas tanure <tanureal@opensource.cirrus.com>
In-Reply-To: <20220325170734.1216018-1-steve@sk2.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: uHcsKInvU0GnvffWbM42gAb_xWaoXNtf
X-Proofpoint-GUID: uHcsKInvU0GnvffWbM42gAb_xWaoXNtf
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/25/22 17:07, Stephen Kitt wrote:
> The i2c probe functions here don't use the id information provided in
> their second argument, so the single-parameter i2c probe function
> ("probe_new") can be used instead.
> 
> This avoids scanning the identifier tables during probes.
> 
> Signed-off-by: Stephen Kitt <steve@sk2.org>
Reviewed-by: Lucas Tanure <tanureal@opensource.cirrus.com>
> ---
>   sound/soc/codecs/cs35l32.c     | 5 ++---
>   sound/soc/codecs/cs35l33.c     | 5 ++---
>   sound/soc/codecs/cs35l34.c     | 5 ++---
>   sound/soc/codecs/cs35l35.c     | 5 ++---
>   sound/soc/codecs/cs35l36.c     | 5 ++---
>   sound/soc/codecs/cs35l41-i2c.c | 5 ++---
>   sound/soc/codecs/cs4234.c      | 4 ++--
>   sound/soc/codecs/cs4265.c      | 5 ++---
>   sound/soc/codecs/cs4270.c      | 5 ++---
>   sound/soc/codecs/cs4271-i2c.c  | 5 ++---
>   sound/soc/codecs/cs42l42.c     | 5 ++---
>   sound/soc/codecs/cs42l51-i2c.c | 5 ++---
>   sound/soc/codecs/cs42l52.c     | 5 ++---
>   sound/soc/codecs/cs42l56.c     | 5 ++---
>   sound/soc/codecs/cs42l73.c     | 5 ++---
>   sound/soc/codecs/cs42xx8-i2c.c | 5 ++---
>   sound/soc/codecs/cs43130.c     | 5 ++---
>   sound/soc/codecs/cs4341.c      | 5 ++---
>   sound/soc/codecs/cs4349.c      | 5 ++---
>   sound/soc/codecs/cs53l30.c     | 5 ++---
>   20 files changed, 40 insertions(+), 59 deletions(-)
> 
> diff --git a/sound/soc/codecs/cs35l32.c b/sound/soc/codecs/cs35l32.c
> index 933e3d627e5f..badfc55bc5fa 100644
> --- a/sound/soc/codecs/cs35l32.c
> +++ b/sound/soc/codecs/cs35l32.c
> @@ -346,8 +346,7 @@ static int cs35l32_handle_of_data(struct i2c_client *i2c_client,
>   	return 0;
>   }
>   
> -static int cs35l32_i2c_probe(struct i2c_client *i2c_client,
> -				       const struct i2c_device_id *id)
> +static int cs35l32_i2c_probe(struct i2c_client *i2c_client)
>   {
>   	struct cs35l32_private *cs35l32;
>   	struct cs35l32_platform_data *pdata =
> @@ -576,7 +575,7 @@ static struct i2c_driver cs35l32_i2c_driver = {
>   		   .of_match_table = cs35l32_of_match,
>   		   },
>   	.id_table = cs35l32_id,
> -	.probe = cs35l32_i2c_probe,
> +	.probe_new = cs35l32_i2c_probe,
>   	.remove = cs35l32_i2c_remove,
>   };
>   
> diff --git a/sound/soc/codecs/cs35l33.c b/sound/soc/codecs/cs35l33.c
> index 2a6f5e46d031..47dc0f6d90a2 100644
> --- a/sound/soc/codecs/cs35l33.c
> +++ b/sound/soc/codecs/cs35l33.c
> @@ -1116,8 +1116,7 @@ static int cs35l33_of_get_pdata(struct device *dev,
>   	return 0;
>   }
>   
> -static int cs35l33_i2c_probe(struct i2c_client *i2c_client,
> -				       const struct i2c_device_id *id)
> +static int cs35l33_i2c_probe(struct i2c_client *i2c_client)
>   {
>   	struct cs35l33_private *cs35l33;
>   	struct cs35l33_pdata *pdata = dev_get_platdata(&i2c_client->dev);
> @@ -1286,7 +1285,7 @@ static struct i2c_driver cs35l33_i2c_driver = {
>   
>   		},
>   	.id_table = cs35l33_id,
> -	.probe = cs35l33_i2c_probe,
> +	.probe_new = cs35l33_i2c_probe,
>   	.remove = cs35l33_i2c_remove,
>   
>   };
> diff --git a/sound/soc/codecs/cs35l34.c b/sound/soc/codecs/cs35l34.c
> index ed678241c22b..50d509a06071 100644
> --- a/sound/soc/codecs/cs35l34.c
> +++ b/sound/soc/codecs/cs35l34.c
> @@ -994,8 +994,7 @@ static const char * const cs35l34_core_supplies[] = {
>   	"VP",
>   };
>   
> -static int cs35l34_i2c_probe(struct i2c_client *i2c_client,
> -			      const struct i2c_device_id *id)
> +static int cs35l34_i2c_probe(struct i2c_client *i2c_client)
>   {
>   	struct cs35l34_private *cs35l34;
>   	struct cs35l34_platform_data *pdata =
> @@ -1217,7 +1216,7 @@ static struct i2c_driver cs35l34_i2c_driver = {
>   
>   		},
>   	.id_table = cs35l34_id,
> -	.probe = cs35l34_i2c_probe,
> +	.probe_new = cs35l34_i2c_probe,
>   	.remove = cs35l34_i2c_remove,
>   
>   };
> diff --git a/sound/soc/codecs/cs35l35.c b/sound/soc/codecs/cs35l35.c
> index 961a3e07e70f..6b70afb70a67 100644
> --- a/sound/soc/codecs/cs35l35.c
> +++ b/sound/soc/codecs/cs35l35.c
> @@ -1466,8 +1466,7 @@ static const struct reg_sequence cs35l35_errata_patch[] = {
>   	{ 0x7F, 0x00 },
>   };
>   
> -static int cs35l35_i2c_probe(struct i2c_client *i2c_client,
> -			      const struct i2c_device_id *id)
> +static int cs35l35_i2c_probe(struct i2c_client *i2c_client)
>   {
>   	struct cs35l35_private *cs35l35;
>   	struct device *dev = &i2c_client->dev;
> @@ -1658,7 +1657,7 @@ static struct i2c_driver cs35l35_i2c_driver = {
>   		.of_match_table = cs35l35_of_match,
>   	},
>   	.id_table = cs35l35_id,
> -	.probe = cs35l35_i2c_probe,
> +	.probe_new = cs35l35_i2c_probe,
>   	.remove = cs35l35_i2c_remove,
>   };
>   
> diff --git a/sound/soc/codecs/cs35l36.c b/sound/soc/codecs/cs35l36.c
> index d83c1b318c1c..cc5e80222916 100644
> --- a/sound/soc/codecs/cs35l36.c
> +++ b/sound/soc/codecs/cs35l36.c
> @@ -1700,8 +1700,7 @@ static const struct reg_sequence cs35l36_revb0_errata_patch[] = {
>   	{ CS35L36_TESTKEY_CTRL, CS35L36_TEST_LOCK2 },
>   };
>   
> -static int cs35l36_i2c_probe(struct i2c_client *i2c_client,
> -			      const struct i2c_device_id *id)
> +static int cs35l36_i2c_probe(struct i2c_client *i2c_client)
>   {
>   	struct cs35l36_private *cs35l36;
>   	struct device *dev = &i2c_client->dev;
> @@ -1947,7 +1946,7 @@ static struct i2c_driver cs35l36_i2c_driver = {
>   		.of_match_table = cs35l36_of_match,
>   	},
>   	.id_table = cs35l36_id,
> -	.probe = cs35l36_i2c_probe,
> +	.probe_new = cs35l36_i2c_probe,
>   	.remove = cs35l36_i2c_remove,
>   };
>   module_i2c_driver(cs35l36_i2c_driver);
> diff --git a/sound/soc/codecs/cs35l41-i2c.c b/sound/soc/codecs/cs35l41-i2c.c
> index faad5c638cb8..86d866aeb680 100644
> --- a/sound/soc/codecs/cs35l41-i2c.c
> +++ b/sound/soc/codecs/cs35l41-i2c.c
> @@ -29,8 +29,7 @@ static const struct i2c_device_id cs35l41_id_i2c[] = {
>   
>   MODULE_DEVICE_TABLE(i2c, cs35l41_id_i2c);
>   
> -static int cs35l41_i2c_probe(struct i2c_client *client,
> -			     const struct i2c_device_id *id)
> +static int cs35l41_i2c_probe(struct i2c_client *client)
>   {
>   	struct cs35l41_private *cs35l41;
>   	struct device *dev = &client->dev;
> @@ -91,7 +90,7 @@ static struct i2c_driver cs35l41_i2c_driver = {
>   		.acpi_match_table = ACPI_PTR(cs35l41_acpi_match),
>   	},
>   	.id_table	= cs35l41_id_i2c,
> -	.probe		= cs35l41_i2c_probe,
> +	.probe_new	= cs35l41_i2c_probe,
>   	.remove		= cs35l41_i2c_remove,
>   };
>   
> diff --git a/sound/soc/codecs/cs4234.c b/sound/soc/codecs/cs4234.c
> index 20126cc675b1..b44939166e5d 100644
> --- a/sound/soc/codecs/cs4234.c
> +++ b/sound/soc/codecs/cs4234.c
> @@ -731,7 +731,7 @@ static int cs4234_powerup(struct cs4234 *cs4234)
>   	return 0;
>   }
>   
> -static int cs4234_i2c_probe(struct i2c_client *i2c_client, const struct i2c_device_id *id)
> +static int cs4234_i2c_probe(struct i2c_client *i2c_client)
>   {
>   	struct cs4234 *cs4234;
>   	struct device *dev = &i2c_client->dev;
> @@ -908,7 +908,7 @@ static struct i2c_driver cs4234_i2c_driver = {
>   		.pm = &cs4234_pm,
>   		.of_match_table = cs4234_of_match,
>   	},
> -	.probe =	cs4234_i2c_probe,
> +	.probe_new =	cs4234_i2c_probe,
>   	.remove =	cs4234_i2c_remove,
>   };
>   module_i2c_driver(cs4234_i2c_driver);
> diff --git a/sound/soc/codecs/cs4265.c b/sound/soc/codecs/cs4265.c
> index 4415fb364d4d..86bfa8d5ec78 100644
> --- a/sound/soc/codecs/cs4265.c
> +++ b/sound/soc/codecs/cs4265.c
> @@ -568,8 +568,7 @@ static const struct regmap_config cs4265_regmap = {
>   	.cache_type = REGCACHE_RBTREE,
>   };
>   
> -static int cs4265_i2c_probe(struct i2c_client *i2c_client,
> -			     const struct i2c_device_id *id)
> +static int cs4265_i2c_probe(struct i2c_client *i2c_client)
>   {
>   	struct cs4265_private *cs4265;
>   	int ret;
> @@ -653,7 +652,7 @@ static struct i2c_driver cs4265_i2c_driver = {
>   		.of_match_table = cs4265_of_match,
>   	},
>   	.id_table = cs4265_id,
> -	.probe =    cs4265_i2c_probe,
> +	.probe_new = cs4265_i2c_probe,
>   	.remove =   cs4265_i2c_remove,
>   };
>   
> diff --git a/sound/soc/codecs/cs4270.c b/sound/soc/codecs/cs4270.c
> index 2d239e983a83..07cac01f87bd 100644
> --- a/sound/soc/codecs/cs4270.c
> +++ b/sound/soc/codecs/cs4270.c
> @@ -677,8 +677,7 @@ static int cs4270_i2c_remove(struct i2c_client *i2c_client)
>    * This function is called whenever the I2C subsystem finds a device that
>    * matches the device ID given via a prior call to i2c_add_driver().
>    */
> -static int cs4270_i2c_probe(struct i2c_client *i2c_client,
> -	const struct i2c_device_id *id)
> +static int cs4270_i2c_probe(struct i2c_client *i2c_client)
>   {
>   	struct cs4270_private *cs4270;
>   	unsigned int val;
> @@ -765,7 +764,7 @@ static struct i2c_driver cs4270_i2c_driver = {
>   		.of_match_table = cs4270_of_match,
>   	},
>   	.id_table = cs4270_id,
> -	.probe = cs4270_i2c_probe,
> +	.probe_new = cs4270_i2c_probe,
>   	.remove = cs4270_i2c_remove,
>   };
>   
> diff --git a/sound/soc/codecs/cs4271-i2c.c b/sound/soc/codecs/cs4271-i2c.c
> index 0a174236f573..0e8a7cf0da50 100644
> --- a/sound/soc/codecs/cs4271-i2c.c
> +++ b/sound/soc/codecs/cs4271-i2c.c
> @@ -11,8 +11,7 @@
>   #include <sound/soc.h>
>   #include "cs4271.h"
>   
> -static int cs4271_i2c_probe(struct i2c_client *client,
> -			     const struct i2c_device_id *id)
> +static int cs4271_i2c_probe(struct i2c_client *client)
>   {
>   	struct regmap_config config;
>   
> @@ -35,7 +34,7 @@ static struct i2c_driver cs4271_i2c_driver = {
>   		.name = "cs4271",
>   		.of_match_table = of_match_ptr(cs4271_dt_ids),
>   	},
> -	.probe = cs4271_i2c_probe,
> +	.probe_new = cs4271_i2c_probe,
>   	.id_table = cs4271_i2c_id,
>   };
>   module_i2c_driver(cs4271_i2c_driver);
> diff --git a/sound/soc/codecs/cs42l42.c b/sound/soc/codecs/cs42l42.c
> index 43d98bdb5b5b..8019921f9cca 100644
> --- a/sound/soc/codecs/cs42l42.c
> +++ b/sound/soc/codecs/cs42l42.c
> @@ -2040,8 +2040,7 @@ static int cs42l42_handle_device_data(struct device *dev,
>   	return 0;
>   }
>   
> -static int cs42l42_i2c_probe(struct i2c_client *i2c_client,
> -				       const struct i2c_device_id *id)
> +static int cs42l42_i2c_probe(struct i2c_client *i2c_client)
>   {
>   	struct cs42l42_private *cs42l42;
>   	int ret, i, devid;
> @@ -2240,7 +2239,7 @@ static struct i2c_driver cs42l42_i2c_driver = {
>   		.acpi_match_table = ACPI_PTR(cs42l42_acpi_match),
>   		},
>   	.id_table = cs42l42_id,
> -	.probe = cs42l42_i2c_probe,
> +	.probe_new = cs42l42_i2c_probe,
>   	.remove = cs42l42_i2c_remove,
>   };
>   
> diff --git a/sound/soc/codecs/cs42l51-i2c.c b/sound/soc/codecs/cs42l51-i2c.c
> index 70260e0a8f09..2dec18ae2918 100644
> --- a/sound/soc/codecs/cs42l51-i2c.c
> +++ b/sound/soc/codecs/cs42l51-i2c.c
> @@ -19,8 +19,7 @@ static struct i2c_device_id cs42l51_i2c_id[] = {
>   };
>   MODULE_DEVICE_TABLE(i2c, cs42l51_i2c_id);
>   
> -static int cs42l51_i2c_probe(struct i2c_client *i2c,
> -			     const struct i2c_device_id *id)
> +static int cs42l51_i2c_probe(struct i2c_client *i2c)
>   {
>   	struct regmap_config config;
>   
> @@ -44,7 +43,7 @@ static struct i2c_driver cs42l51_i2c_driver = {
>   		.of_match_table = cs42l51_of_match,
>   		.pm = &cs42l51_pm_ops,
>   	},
> -	.probe = cs42l51_i2c_probe,
> +	.probe_new = cs42l51_i2c_probe,
>   	.remove = cs42l51_i2c_remove,
>   	.id_table = cs42l51_i2c_id,
>   };
> diff --git a/sound/soc/codecs/cs42l52.c b/sound/soc/codecs/cs42l52.c
> index 80161151b3f2..9b182b585be4 100644
> --- a/sound/soc/codecs/cs42l52.c
> +++ b/sound/soc/codecs/cs42l52.c
> @@ -1086,8 +1086,7 @@ static const struct regmap_config cs42l52_regmap = {
>   	.cache_type = REGCACHE_RBTREE,
>   };
>   
> -static int cs42l52_i2c_probe(struct i2c_client *i2c_client,
> -			     const struct i2c_device_id *id)
> +static int cs42l52_i2c_probe(struct i2c_client *i2c_client)
>   {
>   	struct cs42l52_private *cs42l52;
>   	struct cs42l52_platform_data *pdata = dev_get_platdata(&i2c_client->dev);
> @@ -1226,7 +1225,7 @@ static struct i2c_driver cs42l52_i2c_driver = {
>   		.of_match_table = cs42l52_of_match,
>   	},
>   	.id_table = cs42l52_id,
> -	.probe =    cs42l52_i2c_probe,
> +	.probe_new = cs42l52_i2c_probe,
>   };
>   
>   module_i2c_driver(cs42l52_i2c_driver);
> diff --git a/sound/soc/codecs/cs42l56.c b/sound/soc/codecs/cs42l56.c
> index 3cf8a0b4478c..2c4e09b43199 100644
> --- a/sound/soc/codecs/cs42l56.c
> +++ b/sound/soc/codecs/cs42l56.c
> @@ -1167,8 +1167,7 @@ static int cs42l56_handle_of_data(struct i2c_client *i2c_client,
>   	return 0;
>   }
>   
> -static int cs42l56_i2c_probe(struct i2c_client *i2c_client,
> -			     const struct i2c_device_id *id)
> +static int cs42l56_i2c_probe(struct i2c_client *i2c_client)
>   {
>   	struct cs42l56_private *cs42l56;
>   	struct cs42l56_platform_data *pdata =
> @@ -1350,7 +1349,7 @@ static struct i2c_driver cs42l56_i2c_driver = {
>   		.of_match_table = cs42l56_of_match,
>   	},
>   	.id_table = cs42l56_id,
> -	.probe =    cs42l56_i2c_probe,
> +	.probe_new = cs42l56_i2c_probe,
>   	.remove =   cs42l56_i2c_remove,
>   };
>   
> diff --git a/sound/soc/codecs/cs42l73.c b/sound/soc/codecs/cs42l73.c
> index 018463f34e12..5a9166289f36 100644
> --- a/sound/soc/codecs/cs42l73.c
> +++ b/sound/soc/codecs/cs42l73.c
> @@ -1274,8 +1274,7 @@ static const struct regmap_config cs42l73_regmap = {
>   	.use_single_write = true,
>   };
>   
> -static int cs42l73_i2c_probe(struct i2c_client *i2c_client,
> -			     const struct i2c_device_id *id)
> +static int cs42l73_i2c_probe(struct i2c_client *i2c_client)
>   {
>   	struct cs42l73_private *cs42l73;
>   	struct cs42l73_platform_data *pdata = dev_get_platdata(&i2c_client->dev);
> @@ -1386,7 +1385,7 @@ static struct i2c_driver cs42l73_i2c_driver = {
>   		   .of_match_table = cs42l73_of_match,
>   		   },
>   	.id_table = cs42l73_id,
> -	.probe = cs42l73_i2c_probe,
> +	.probe_new = cs42l73_i2c_probe,
>   
>   };
>   
> diff --git a/sound/soc/codecs/cs42xx8-i2c.c b/sound/soc/codecs/cs42xx8-i2c.c
> index 0214e3ab9da0..cb06a06d48b0 100644
> --- a/sound/soc/codecs/cs42xx8-i2c.c
> +++ b/sound/soc/codecs/cs42xx8-i2c.c
> @@ -17,8 +17,7 @@
>   
>   #include "cs42xx8.h"
>   
> -static int cs42xx8_i2c_probe(struct i2c_client *i2c,
> -			     const struct i2c_device_id *id)
> +static int cs42xx8_i2c_probe(struct i2c_client *i2c)
>   {
>   	int ret = cs42xx8_probe(&i2c->dev,
>   			devm_regmap_init_i2c(i2c, &cs42xx8_regmap_config));
> @@ -51,7 +50,7 @@ static struct i2c_driver cs42xx8_i2c_driver = {
>   		.pm = &cs42xx8_pm,
>   		.of_match_table = cs42xx8_of_match,
>   	},
> -	.probe = cs42xx8_i2c_probe,
> +	.probe_new = cs42xx8_i2c_probe,
>   	.remove = cs42xx8_i2c_remove,
>   	.id_table = cs42xx8_i2c_id,
>   };
> diff --git a/sound/soc/codecs/cs43130.c b/sound/soc/codecs/cs43130.c
> index 44b20c1ef851..e38552a961ef 100644
> --- a/sound/soc/codecs/cs43130.c
> +++ b/sound/soc/codecs/cs43130.c
> @@ -2418,8 +2418,7 @@ static int cs43130_handle_device_data(struct i2c_client *i2c_client,
>   	return 0;
>   }
>   
> -static int cs43130_i2c_probe(struct i2c_client *client,
> -			     const struct i2c_device_id *id)
> +static int cs43130_i2c_probe(struct i2c_client *client)
>   {
>   	struct cs43130_private *cs43130;
>   	int ret;
> @@ -2702,7 +2701,7 @@ static struct i2c_driver cs43130_i2c_driver = {
>   		.pm             = &cs43130_runtime_pm,
>   	},
>   	.id_table	= cs43130_i2c_id,
> -	.probe		= cs43130_i2c_probe,
> +	.probe_new	= cs43130_i2c_probe,
>   	.remove		= cs43130_i2c_remove,
>   };
>   
> diff --git a/sound/soc/codecs/cs4341.c b/sound/soc/codecs/cs4341.c
> index 29d05e32d341..8ac043f1aae0 100644
> --- a/sound/soc/codecs/cs4341.c
> +++ b/sound/soc/codecs/cs4341.c
> @@ -225,8 +225,7 @@ static int cs4341_probe(struct device *dev)
>   }
>   
>   #if IS_ENABLED(CONFIG_I2C)
> -static int cs4341_i2c_probe(struct i2c_client *i2c,
> -			    const struct i2c_device_id *id)
> +static int cs4341_i2c_probe(struct i2c_client *i2c)
>   {
>   	struct cs4341_priv *cs4341;
>   
> @@ -260,7 +259,7 @@ static struct i2c_driver cs4341_i2c_driver = {
>   		.name = "cs4341-i2c",
>   		.of_match_table = of_match_ptr(cs4341_dt_ids),
>   	},
> -	.probe = cs4341_i2c_probe,
> +	.probe_new = cs4341_i2c_probe,
>   	.id_table = cs4341_i2c_id,
>   };
>   #endif
> diff --git a/sound/soc/codecs/cs4349.c b/sound/soc/codecs/cs4349.c
> index 786c69a8ec4a..4ec4bed9ee08 100644
> --- a/sound/soc/codecs/cs4349.c
> +++ b/sound/soc/codecs/cs4349.c
> @@ -278,8 +278,7 @@ static const struct regmap_config cs4349_regmap = {
>   	.cache_type		= REGCACHE_RBTREE,
>   };
>   
> -static int cs4349_i2c_probe(struct i2c_client *client,
> -				      const struct i2c_device_id *id)
> +static int cs4349_i2c_probe(struct i2c_client *client)
>   {
>   	struct cs4349_private *cs4349;
>   	int ret;
> @@ -382,7 +381,7 @@ static struct i2c_driver cs4349_i2c_driver = {
>   		.pm = &cs4349_runtime_pm,
>   	},
>   	.id_table	= cs4349_i2c_id,
> -	.probe		= cs4349_i2c_probe,
> +	.probe_new	= cs4349_i2c_probe,
>   	.remove		= cs4349_i2c_remove,
>   };
>   
> diff --git a/sound/soc/codecs/cs53l30.c b/sound/soc/codecs/cs53l30.c
> index f2087bd38dbc..703545273900 100644
> --- a/sound/soc/codecs/cs53l30.c
> +++ b/sound/soc/codecs/cs53l30.c
> @@ -918,8 +918,7 @@ static struct regmap_config cs53l30_regmap = {
>   	.use_single_write = true,
>   };
>   
> -static int cs53l30_i2c_probe(struct i2c_client *client,
> -			     const struct i2c_device_id *id)
> +static int cs53l30_i2c_probe(struct i2c_client *client)
>   {
>   	const struct device_node *np = client->dev.of_node;
>   	struct device *dev = &client->dev;
> @@ -1125,7 +1124,7 @@ static struct i2c_driver cs53l30_i2c_driver = {
>   		.pm = &cs53l30_runtime_pm,
>   	},
>   	.id_table = cs53l30_id,
> -	.probe = cs53l30_i2c_probe,
> +	.probe_new = cs53l30_i2c_probe,
>   	.remove = cs53l30_i2c_remove,
>   };
>   

