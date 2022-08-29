Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83C275A5557
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 22:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbiH2ULJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 16:11:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiH2ULG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 16:11:06 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 906F76B17E;
        Mon, 29 Aug 2022 13:11:03 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id bh13so8689933pgb.4;
        Mon, 29 Aug 2022 13:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=HRDolUsTNvb2lmoRCB55mIDNp5qf4uPKsLhS/bfXvmo=;
        b=PX09F8oZv5Z+2cpqSgn/UWSq4NIsbSKdZWB9NDa7XVe8ddr/Ytipf3qoKOoZZPnfsw
         rGbHJuB/FN/V+jYxC6fL4oOlbSyykzLdph6BR8cQpKGG7e8Xqy//98fFwU6vtNnwQygk
         4e7aj1k8NO4VQekZBND7L7AnCsjtRwL7TTtRg1zxuR+IHPWTft8TeGAF1XtceaIh+fBI
         cGmzMm7U8ZeBe3dZ/3EpDjHhyj2m1bUKMm84pSPhY5sCM9uqs9RBYPd2dQ83IqBrWF5u
         pH2pvyGKP7SX1EP8+ylUZ5e9gVwARdC2gfVLaLHmtZ8/TkWN2hIHGm4CgLIVt5lnAru+
         Qw4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=HRDolUsTNvb2lmoRCB55mIDNp5qf4uPKsLhS/bfXvmo=;
        b=USiWZ7X8WcZ7NxW1pHMBlbdwvvvT6MN1YdkntR1OMYejqxtYwVVYpO8o8Syh7YhjSv
         01nsqJDuk9QU6mI6dyC2ZyCu8rH9anxx3VBLqJjZWBeDmeVxc9PtBYHI+xCQwpWzd6Vi
         SUl1TSRWkKIqsc/GltoXkdNeATv2DpA+jqLi/hA3QB3+SNC9NIui7hLlkrcLrhtf8V2V
         vmfe7BrCip7J7frtI01BW08/gpRrQFE8rJdPXsjTM64MQBSVUzvCqgw9w0b4VO59kZIG
         KuO54DT7TaiA+uxeRIED+W6sOkOXWM25h2Rw5QCiL6MKX4GQZribd7drxPQkb1HUWHO/
         yclg==
X-Gm-Message-State: ACgBeo1NYQHa22muHsGYgUXpl5yXSNpTsmyXgo93YVvDFYDjHEHpJdNa
        ZK5p0Wd1sYH65359+7NNAFI=
X-Google-Smtp-Source: AA6agR75eieQMi5+X8ep+VYEr22hq2d6B9AjxM2u3eiN5KC8nBwsGnl02Irn48HaYE/ywHIPLVsulA==
X-Received: by 2002:a63:ad02:0:b0:41a:910f:5195 with SMTP id g2-20020a63ad02000000b0041a910f5195mr15414205pgf.472.1661803863122;
        Mon, 29 Aug 2022 13:11:03 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 68-20020a620647000000b00537d7cc774bsm6579770pfg.139.2022.08.29.13.11.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 13:11:02 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 29 Aug 2022 13:11:00 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Justin Ledford <justinledford@google.com>
Cc:     Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
        linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] hwmon: (max31790) add fanN_enable
Message-ID: <20220829201100.GA3638256@roeck-us.net>
References: <20220829195930.2521755-1-justinledford@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220829195930.2521755-1-justinledford@google.com>
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

On Mon, Aug 29, 2022 at 07:59:30PM +0000, Justin Ledford wrote:
> The MAX31790 has a tach input enable bit in each fan's configuration
> register. This is only enabled by the driver if RPM mode is selected,
> but the driver doesn't provide a way to independently enable tachometer
> input regardless of the regulator mode.
> 
> By adding the fanN_enable sysfs files, we can decouple the tach input
> from the regulator mode. Also update the documentation.
> 
> Signed-off-by: Justin Ledford <justinledford@google.com>

Applied to hwmon-next.

Thanks,
Guenter

> ---
> Changes in v2:
> - Removed updating fan_config during max31790_update_device
> ---
>  Documentation/hwmon/max31790.rst |  1 +
>  drivers/hwmon/max31790.c         | 38 ++++++++++++++++++++++++++------
>  2 files changed, 32 insertions(+), 7 deletions(-)
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
> index 7e9362f6dc29..20bf5ffadefe 100644
> --- a/drivers/hwmon/max31790.c
> +++ b/drivers/hwmon/max31790.c
> @@ -202,6 +202,9 @@ static int max31790_read_fan(struct device *dev, u32 attr, int channel,
>  		}
>  		mutex_unlock(&data->update_lock);
>  		return 0;
> +	case hwmon_fan_enable:
> +		*val = !!(data->fan_config[channel] & MAX31790_FAN_CFG_TACH_INPUT_EN);
> +		return 0;
>  	default:
>  		return -EOPNOTSUPP;
>  	}
> @@ -214,7 +217,7 @@ static int max31790_write_fan(struct device *dev, u32 attr, int channel,
>  	struct i2c_client *client = data->client;
>  	int target_count;
>  	int err = 0;
> -	u8 bits;
> +	u8 bits, fan_config;
>  	int sr;
>  
>  	mutex_lock(&data->update_lock);
> @@ -243,6 +246,23 @@ static int max31790_write_fan(struct device *dev, u32 attr, int channel,
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
> @@ -270,6 +290,10 @@ static umode_t max31790_fan_is_visible(const void *_data, u32 attr, int channel)
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
> @@ -423,12 +447,12 @@ static umode_t max31790_is_visible(const void *data,
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
