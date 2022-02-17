Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2F534BA7E4
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 19:14:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241523AbiBQSL6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 13:11:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234842AbiBQSLx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 13:11:53 -0500
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 396928A32E;
        Thu, 17 Feb 2022 10:11:37 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id f19so9888140qvb.6;
        Thu, 17 Feb 2022 10:11:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:content-language:to
         :cc:references:from:subject:in-reply-to:content-transfer-encoding;
        bh=3t297Rve1SDESxxbDGkaeisi7qQ51HM6w5VO3bA4J1g=;
        b=IZjNG4hPlrHwMT/EWpsO8lqY9zm+3+5Tm9vgRFRSf35NJ+/gd3v1bIWzxNojEW6H4q
         BTnKQZADrGVhJZJWee1TQ5duZxae93aqpLa9aB3AsSjPac7wKu+m9n5ozeJeOB9lYzlg
         iFtQpCLu3vWnXl7t+nVqY1x1sZDI9/z2d1+8e5yU8mHjkeD4eYGazh+KCzlvRb+uAQop
         wGiyQIZ0wP7ubH1SI3Ze95u4KO7QXU11rgOwcNHHdTgikr2c6KxFKlBmF1d27Fik8rJ9
         QCJD7pN/0jOeS1uEYiaXt1S08lXMgTAhyDitEHaR2sX4jKxHolHwPbMlNs1mZLp/YIAq
         5LoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=3t297Rve1SDESxxbDGkaeisi7qQ51HM6w5VO3bA4J1g=;
        b=4ftAnYU/zMFYt6a8yNiYn01HlJ/dncC1wdcyY46iow9TPcM9fHOuKN0y3HHalQPX6v
         AgmOcha0n3l+4mIBJ/9lcqGBcB6y+SgguLfx8tB1araAp+9BeAfpjrIYOYwAYVEvVsEx
         OydpPTAqsgaQo/0W45IU/aBAsrJGzst0a1axtFwpwy/zYBTZsMNCwwcAzsxmrgcnaZyA
         NqkxVjDaHWnOuKBufCqhcGEu1QG1OzWF37GkIBhjZfwMcTw0xvb0AvrXg6POAToRYLTL
         CLkQr8Z9e79Fsq91Gr/NMIpV49s6rstRztgw0/1GGOhT6hCY/SQzV/xfRnx9WpSHBmuu
         48vQ==
X-Gm-Message-State: AOAM533dSB3oZKkjC1rzVfDIm/x6o38+E+vQQsWbeqjfOXGzJcsXX2zP
        3pko4CaSQgmW/an4RoHJ6mc=
X-Google-Smtp-Source: ABdhPJx+ebTDBhR5QvBJpvCX9RSFtsRiXT+CPPQevdr/8LGjuLuR2P8JmblxuxUzHNHYZJRPw62JIw==
X-Received: by 2002:a05:622a:1444:b0:2d5:b8f9:aa3c with SMTP id v4-20020a05622a144400b002d5b8f9aa3cmr3570975qtx.664.1645121496345;
        Thu, 17 Feb 2022 10:11:36 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p14sm2462019qtn.93.2022.02.17.10.11.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Feb 2022 10:11:35 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <b22ca322-c8f2-d17c-75ff-54ee26b0041b@roeck-us.net>
Date:   Thu, 17 Feb 2022 10:11:32 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Zev Weiss <zev@bewilderbeest.net>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org
Cc:     openbmc@lists.ozlabs.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
References: <20220217104444.7695-1-zev@bewilderbeest.net>
 <20220217104444.7695-2-zev@bewilderbeest.net>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 1/4] hwmon: (pmbus) Add get_error_flags support to
 regulator ops
In-Reply-To: <20220217104444.7695-2-zev@bewilderbeest.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/17/22 02:44, Zev Weiss wrote:
> The various PMBus status bits don't all map perfectly to the more
> limited set of REGULATOR_ERROR_* flags, but there's a reasonable
> number where they correspond well enough.
> 
> Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
> ---
>   drivers/hwmon/pmbus/pmbus_core.c | 97 ++++++++++++++++++++++++++++++++
>   1 file changed, 97 insertions(+)
> 
> diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
> index 776ee2237be2..a274e8e524a5 100644
> --- a/drivers/hwmon/pmbus/pmbus_core.c
> +++ b/drivers/hwmon/pmbus/pmbus_core.c
> @@ -2417,10 +2417,107 @@ static int pmbus_regulator_disable(struct regulator_dev *rdev)
>   	return _pmbus_regulator_on_off(rdev, 0);
>   }
>   
> +/* A PMBus status flag and the corresponding REGULATOR_ERROR_* flag */
> +struct pmbus_regulator_status_assoc {
> +	int pflag, rflag;
> +};
> +
> +/* PMBus->regulator bit mappings for a PMBus status register */
> +struct pmbus_regulator_status_category {
> +	int func;
> +	int reg;
> +	const struct pmbus_regulator_status_assoc *bits; /* zero-terminated */
> +};
> +
> +static const struct pmbus_regulator_status_category pmbus_regulator_flag_map[] = {
> +	{
> +		.func = PMBUS_HAVE_STATUS_VOUT,
> +		.reg = PMBUS_STATUS_VOUT,
> +		.bits = (const struct pmbus_regulator_status_assoc[]) {
> +			{ PB_VOLTAGE_UV_WARNING, REGULATOR_ERROR_UNDER_VOLTAGE_WARN },
> +			{ PB_VOLTAGE_UV_FAULT,   REGULATOR_ERROR_UNDER_VOLTAGE },
> +			{ PB_VOLTAGE_OV_WARNING, REGULATOR_ERROR_OVER_VOLTAGE_WARN },
> +			{ PB_VOLTAGE_OV_FAULT,   REGULATOR_ERROR_REGULATION_OUT },
> +			{ },
> +		},
> +	}, {
> +		.func = PMBUS_HAVE_STATUS_IOUT,
> +		.reg = PMBUS_STATUS_IOUT,
> +		.bits = (const struct pmbus_regulator_status_assoc[]) {
> +			{ PB_IOUT_OC_WARNING,    REGULATOR_ERROR_OVER_CURRENT_WARN },
> +			{ PB_IOUT_OC_FAULT,      REGULATOR_ERROR_OVER_CURRENT },
> +			{ PB_IOUT_OC_LV_FAULT,   REGULATOR_ERROR_OVER_CURRENT },
> +			{ },
> +		},
> +	}, {
> +		.func = PMBUS_HAVE_STATUS_TEMP,
> +		.reg = PMBUS_STATUS_TEMPERATURE,
> +		.bits = (const struct pmbus_regulator_status_assoc[]) {
> +			{ PB_TEMP_OT_WARNING,    REGULATOR_ERROR_OVER_TEMP_WARN },
> +			{ PB_TEMP_OT_FAULT,      REGULATOR_ERROR_OVER_TEMP },
> +			{ },
> +		},
> +	},
> +};
> +
> +static int pmbus_regulator_get_error_flags(struct regulator_dev *rdev, unsigned int *flags)
> +{
> +	int i, status, statusreg;
> +	const struct pmbus_regulator_status_category *cat;
> +	const struct pmbus_regulator_status_assoc *bit;
> +	struct device *dev = rdev_get_dev(rdev);
> +	struct i2c_client *client = to_i2c_client(dev->parent);
> +	struct pmbus_data *data = i2c_get_clientdata(client);
> +	u8 page = rdev_get_id(rdev);
> +	int func = data->info->func[page];
> +
> +	*flags = 0;
> +
> +	for (i = 0; i < ARRAY_SIZE(pmbus_regulator_flag_map); i++) {
> +		cat = &pmbus_regulator_flag_map[i];
> +		if (!(func & cat->func))
> +			continue;
> +
> +		status = pmbus_read_byte_data(client, page, cat->reg);
> +		if (status < 0)
> +			return status;
> +
> +		for (bit = cat->bits; bit->pflag; bit++) {
> +			if (status & bit->pflag)
> +				*flags |= bit->rflag;
> +		}
> +	}
> +
> +	/*
> +	 * Map what bits of STATUS_{WORD,BYTE} we can to REGULATOR_ERROR_*
> +	 * bits.  Some of the other bits are tempting (especially for cases
> +	 * where we don't have the relevant PMBUS_HAVE_STATUS_*
> +	 * functionality), but there's an unfortunate ambiguity in that
> +	 * they're defined as indicating a fault *or* a warning, so we can't
> +	 * easily determine whether to report REGULATOR_ERROR_<foo> or
> +	 * REGULATOR_ERROR_<foo>_WARN.
> +	 */
> +	statusreg = data->has_status_word ? PMBUS_STATUS_WORD : PMBUS_STATUS_BYTE;
> +	status = pmbus_get_status(client, page, statusreg);
> +

pmbus_get_status() calls data->read_status if PMBUS_STATUS_WORD is provided
as parameter, and data->read_status is set to pmbus_read_status_byte()
if reading the word status is not supported. Given that, why not just call
pmbus_get_status(client, page, PMBUS_STATUS_WORD) ?

> +	if (status < 0)
> +		return status;
> +
> +	if (pmbus_regulator_is_enabled(rdev) && (status & PB_STATUS_OFF))
> +		*flags |= REGULATOR_ERROR_FAIL;
> +	if (status & PB_STATUS_IOUT_OC)
> +		*flags |= REGULATOR_ERROR_OVER_CURRENT;

If the current status register is supported, this effectively means that
an overcurrent warning is always reported as both REGULATOR_ERROR_OVER_CURRENT
and REGULATOR_ERROR_OVER_CURRENT_WARN. Is that intentional ?


> +	if (status & PB_STATUS_VOUT_OV)
> +		*flags |= REGULATOR_ERROR_REGULATION_OUT;

Same for voltage. On the other side, temperature limit violations are not
reported at all unless the temperature status register exists.
That seems to be a bit inconsistent to me.

> +
> +	return 0;
> +}
> +
>   const struct regulator_ops pmbus_regulator_ops = {
>   	.enable = pmbus_regulator_enable,
>   	.disable = pmbus_regulator_disable,
>   	.is_enabled = pmbus_regulator_is_enabled,
> +	.get_error_flags = pmbus_regulator_get_error_flags,
>   };
>   EXPORT_SYMBOL_NS_GPL(pmbus_regulator_ops, PMBUS);
>   

