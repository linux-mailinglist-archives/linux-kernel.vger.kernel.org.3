Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A87FE5A4DDB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 15:24:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbiH2NYT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 09:24:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231222AbiH2NXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 09:23:53 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84662910AB;
        Mon, 29 Aug 2022 06:21:05 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id x23so7959064pll.7;
        Mon, 29 Aug 2022 06:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=LgF/oNaf8LxpEpIqQcaXZqdbWnQJVUDcVOCF2bUqIdo=;
        b=aoPhGeJ1kCT2x9VhlhuMthu2wau1MqlvSKTX32ZoxwXfJa9w0n+fpuDP4qe5fr88aX
         NAwe5fxTht8YRxXXEiju0r5nu1E3Mx5wN8GwW+TwqwVpFi3KQGOPA8IIA1edLIr12lW/
         jok3jCOPDkDMsIo5DjUsrcWUPZXRX3wH+zCg3Ny3PduhTPGKsf8rXcLdd/QliznWAp3f
         V1TOZ94Qi2PCKqZJI+KeB7aPvzjpnq6z9goN0jipUIwGJAeZjoNNbZFx6x3Eyf0my+lz
         88BFxzjQzfKP4juHAzqsdOXVGDMjr11bzFosgwvZPOdrsz1bQuen5kuUg0VFyd5H3iE0
         qskw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=LgF/oNaf8LxpEpIqQcaXZqdbWnQJVUDcVOCF2bUqIdo=;
        b=ML/c8M1PWgcWzuP9u83rscu87QHQly8NIgqNWsACRCNIgIIFAhmqIcXENh2IPjes7C
         +UrBcCnO8EBpL3uFZ1Mi2DAm5LmX71WBM6ldC83f+fFeZe6uM8gUM46RJGlJ80ERkVLl
         7X62xA/vBZS6ysVKkiBs8H7aqMdJLXiMQiOTmuEO3PdjyYzZMEdWTgcercSoLuIaklEa
         gxoA39N8mxqFtFI0v+GAwX2zUL3hdEnF9Z/CXOAk9gGU0z/XH40FxgzNS/U8vpM+v0Lh
         qRGEVc5+u3ApKhgEcGjEYfZYpXS/r/+Qjyuh9AjbnpOTlqRkMt/ugzH84zK12p3VhaTH
         ywgQ==
X-Gm-Message-State: ACgBeo29GwR7LgxdLmeSSgrNh0f3JQVp9xb0LhX/qyrAsyVtiXSkYwki
        EUAQ6MD63A2V99dzSTJ6SHs=
X-Google-Smtp-Source: AA6agR6gqOqyfyzd4jDRPi0Q91Y6O6BWH/vghpZqDMO9GiFhOBWYhqOFxQ8m5UQbuihzsdPNhe6tlw==
X-Received: by 2002:a17:90b:4d8e:b0:1fd:ce88:6920 with SMTP id oj14-20020a17090b4d8e00b001fdce886920mr5022660pjb.175.1661779220314;
        Mon, 29 Aug 2022 06:20:20 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j6-20020a170903024600b0016bffc59718sm7559003plh.58.2022.08.29.06.20.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 06:20:19 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 29 Aug 2022 06:20:17 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Justin Ledford <justinledford@google.com>
Cc:     Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
        linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (max31790) add fanN_enable
Message-ID: <20220829132017.GA3039965@roeck-us.net>
References: <20220829024351.2415147-1-justinledford@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220829024351.2415147-1-justinledford@google.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 29, 2022 at 02:43:51AM +0000, Justin Ledford wrote:
> The MAX31790 has a tach input enable bit in each fan's configuration
> register. This is only enabled by the driver if RPM mode is selected,
> but the driver doesn't provide a way to independently enable tachometer
> input regardless of the regulator mode.
> 
> By adding the fanN_enable sysfs files, we can decouple the tach input
> from the regulator mode. Also update the documentation.
> 
> Signed-off-by: Justin Ledford <justinledford@google.com>
> ---
>  Documentation/hwmon/max31790.rst |  1 +
>  drivers/hwmon/max31790.c         | 44 +++++++++++++++++++++++++++-----
>  2 files changed, 38 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/hwmon/max31790.rst b/Documentation/hwmon/max31790.rst
> index 7b097c3b9b90..33c5c7330efc 100644
> --- a/Documentation/hwmon/max31790.rst
> +++ b/Documentation/hwmon/max31790.rst
> @@ -38,6 +38,7 @@ Sysfs entries
>  fan[1-12]_input    RO  fan tachometer speed in RPM
>  fan[1-12]_fault    RO  fan experienced fault
>  fan[1-6]_target    RW  desired fan speed in RPM
> +fan[1-6]_enable    RW  enable or disable the tachometer input
>  pwm[1-6]_enable    RW  regulator mode, 0=disabled (duty cycle=0%), 1=manual mode, 2=rpm mode
>  pwm[1-6]           RW  read: current pwm duty cycle,
>                         write: target pwm duty cycle (0-255)
> diff --git a/drivers/hwmon/max31790.c b/drivers/hwmon/max31790.c
> index 7e9362f6dc29..3ae02be4b41e 100644
> --- a/drivers/hwmon/max31790.c
> +++ b/drivers/hwmon/max31790.c
> @@ -118,6 +118,12 @@ static struct max31790_data *max31790_update_device(struct device *dev)
>  					goto abort;
>  				data->target_count[i] = rv;
>  			}
> +
> +			rv = i2c_smbus_read_byte_data(client,
> +					MAX31790_REG_FAN_CONFIG(i));
> +			if (rv < 0)
> +				goto abort;
> +			data->fan_config[i] = rv;

Why is this needed ?

Guenter

>  		}
>  
>  		data->last_updated = jiffies;
> @@ -202,6 +208,9 @@ static int max31790_read_fan(struct device *dev, u32 attr, int channel,
>  		}
>  		mutex_unlock(&data->update_lock);
>  		return 0;
> +	case hwmon_fan_enable:
> +		*val = !!(data->fan_config[channel] & MAX31790_FAN_CFG_TACH_INPUT_EN);
> +		return 0;
>  	default:
>  		return -EOPNOTSUPP;
>  	}
> @@ -214,7 +223,7 @@ static int max31790_write_fan(struct device *dev, u32 attr, int channel,
>  	struct i2c_client *client = data->client;
>  	int target_count;
>  	int err = 0;
> -	u8 bits;
> +	u8 bits, fan_config;
>  	int sr;
>  
>  	mutex_lock(&data->update_lock);
> @@ -243,6 +252,23 @@ static int max31790_write_fan(struct device *dev, u32 attr, int channel,
>  					MAX31790_REG_TARGET_COUNT(channel),
>  					data->target_count[channel]);
>  		break;
> +	case hwmon_fan_enable:
> +		fan_config = data->fan_config[channel];
> +		if (val == 0) {
> +			fan_config &= ~MAX31790_FAN_CFG_TACH_INPUT_EN;
> +		} else if (val == 1) {
> +			fan_config |= MAX31790_FAN_CFG_TACH_INPUT_EN;
> +		} else {
> +			err = -EINVAL;
> +			break;
> +		}
> +		if (fan_config != data->fan_config[channel]) {
> +			err = i2c_smbus_write_byte_data(client, MAX31790_REG_FAN_CONFIG(channel),
> +							fan_config);
> +			if (!err)
> +				data->fan_config[channel] = fan_config;
> +		}
> +		break;
>  	default:
>  		err = -EOPNOTSUPP;
>  		break;
> @@ -270,6 +296,10 @@ static umode_t max31790_fan_is_visible(const void *_data, u32 attr, int channel)
>  		    !(fan_config & MAX31790_FAN_CFG_TACH_INPUT))
>  			return 0644;
>  		return 0;
> +	case hwmon_fan_enable:
> +		if (channel < NR_CHANNEL)
> +			return 0644;
> +		return 0;
>  	default:
>  		return 0;
>  	}
> @@ -423,12 +453,12 @@ static umode_t max31790_is_visible(const void *data,
>  
>  static const struct hwmon_channel_info *max31790_info[] = {
>  	HWMON_CHANNEL_INFO(fan,
> -			   HWMON_F_INPUT | HWMON_F_TARGET | HWMON_F_FAULT,
> -			   HWMON_F_INPUT | HWMON_F_TARGET | HWMON_F_FAULT,
> -			   HWMON_F_INPUT | HWMON_F_TARGET | HWMON_F_FAULT,
> -			   HWMON_F_INPUT | HWMON_F_TARGET | HWMON_F_FAULT,
> -			   HWMON_F_INPUT | HWMON_F_TARGET | HWMON_F_FAULT,
> -			   HWMON_F_INPUT | HWMON_F_TARGET | HWMON_F_FAULT,
> +			   HWMON_F_INPUT | HWMON_F_TARGET | HWMON_F_FAULT | HWMON_F_ENABLE,
> +			   HWMON_F_INPUT | HWMON_F_TARGET | HWMON_F_FAULT | HWMON_F_ENABLE,
> +			   HWMON_F_INPUT | HWMON_F_TARGET | HWMON_F_FAULT | HWMON_F_ENABLE,
> +			   HWMON_F_INPUT | HWMON_F_TARGET | HWMON_F_FAULT | HWMON_F_ENABLE,
> +			   HWMON_F_INPUT | HWMON_F_TARGET | HWMON_F_FAULT | HWMON_F_ENABLE,
> +			   HWMON_F_INPUT | HWMON_F_TARGET | HWMON_F_FAULT | HWMON_F_ENABLE,
>  			   HWMON_F_INPUT | HWMON_F_FAULT,
>  			   HWMON_F_INPUT | HWMON_F_FAULT,
>  			   HWMON_F_INPUT | HWMON_F_FAULT,
> -- 
> 2.37.2.672.g94769d06f0-goog
> 
