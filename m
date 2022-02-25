Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A83754C3B75
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 03:11:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236695AbiBYCLM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 21:11:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236663AbiBYCLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 21:11:10 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 112621EC98A;
        Thu, 24 Feb 2022 18:10:40 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id 12so5858829oix.12;
        Thu, 24 Feb 2022 18:10:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=i+L8lnOZSA8pmywpv3S4jjt7n2Ef0gqDV24qQiOWShs=;
        b=V94ymVd2eobEOAb3mUMVoN0ua8PGdVGmMHg3x2g7g4iwQh/P0K1KSiVwoTiCbyScQu
         Pd+EEtbcVivlwHxkHzzU1Eqiia9jeenSP0fA/pWL7bJs+g3SIhTZm5DoFbbP+4x+mol5
         w0Jb9r7nu3VLlt0ofaPA/T1euQ9qliV8wr93pY/B1VOsprtYC9F6e+37tNweAa4MRyos
         nNYF8eWCCVa7PmXbOhHPJsH/viQGY2Ec3C8WM2qcog/G67jnaiaBzpO1D4/sT+pSd7TD
         Dpo4JkN6xN45rWNWdRigzFIoyTw/7tDp55w7wC2p/4eP69Mtiv7cDktum0YVSbFI0f/q
         YpFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=i+L8lnOZSA8pmywpv3S4jjt7n2Ef0gqDV24qQiOWShs=;
        b=ZBEn5lLht8z2XrNrUqPcws4EEC6AwiOGH2qhTTdheoB4sxOyDOH6/E2pVgfxI/ultQ
         anHw2r4FxBtwVXk4eWjrUFYGcmWi4JtpjpQImocdfDSgcZwn7JHbzWNLl3HFU8sV1Lmh
         gHOm0dnY/giS1EWuqX6mvyzNX9tOnh0cLeR2BGmml6RUutaHD8pyJDjj0RXkI+mwFzOe
         5bM4ttXxkSmouQonJg7XiiZtXB0HyagwKqppU+4sWL+Zf8hz5YbL4l4SkpyuU2QMl41W
         HnbFK0FKPdWgcqmH14iFFmWmW/HXhv2wbOY8tdBSsF0iebUj5WQQcIHM0TWHiDcOL/f5
         vsKg==
X-Gm-Message-State: AOAM53291nAKu9VpI/TGvIMlWM3cFvN9g56x1h3mHX+LyndncDKexov8
        ldrZdKCripOvgOrFXslJZZo=
X-Google-Smtp-Source: ABdhPJwk2lVSTqtSZF2hGn40lGoYAil5s1DUfTaimRcZ1DuyaVLDpABRFqjPw8WpSFRIPaEe4jzj2A==
X-Received: by 2002:a05:6808:1207:b0:2d3:3c51:2a43 with SMTP id a7-20020a056808120700b002d33c512a43mr489558oil.237.1645755039362;
        Thu, 24 Feb 2022 18:10:39 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 67-20020aca0546000000b002d46e151b9bsm579604oif.18.2022.02.24.18.10.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 18:10:38 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 24 Feb 2022 18:10:37 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Armin Wolf <W_Armin@gmx.de>
Cc:     hdegoede@redhat.com, jdelvare@suse.com,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] hwmon: (sch5627) Add pwmX_auto_channels_temp
 support
Message-ID: <20220225021037.GA1976317@roeck-us.net>
References: <20220224061210.16452-1-W_Armin@gmx.de>
 <20220224061210.16452-3-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220224061210.16452-3-W_Armin@gmx.de>
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

On Thu, Feb 24, 2022 at 07:12:10AM +0100, Armin Wolf wrote:
> After doing some research, it seems that Fujitsu's
> hardware monitoring solution exports data describing
> which temperature sensors affect which fans, similar
> to the data in fan_source of the ftsteutates driver.
> Writing 0 into these registers forces the fans to
> full speed.
> Export this data with standard attributes.
> 
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>

Applied to hwmon-next.

Thanks,
Guenter

> ---
>  Documentation/hwmon/sch5627.rst |  4 +++
>  drivers/hwmon/sch5627.c         | 61 +++++++++++++++++++++++++++++++++
>  2 files changed, 65 insertions(+)
> 
> --
> 2.30.2
> 
> diff --git a/Documentation/hwmon/sch5627.rst b/Documentation/hwmon/sch5627.rst
> index 187682e99114..ecb4fc84d045 100644
> --- a/Documentation/hwmon/sch5627.rst
> +++ b/Documentation/hwmon/sch5627.rst
> @@ -20,6 +20,10 @@ Description
>  SMSC SCH5627 Super I/O chips include complete hardware monitoring
>  capabilities. They can monitor up to 5 voltages, 4 fans and 8 temperatures.
> 
> +In addition, the SCH5627 exports data describing which temperature sensors
> +affect the speed of each fan. Setting pwmX_auto_channels_temp to 0 forces
> +the corresponding fan to full speed until another value is written.
> +
>  The SMSC SCH5627 hardware monitoring part also contains an integrated
>  watchdog. In order for this watchdog to function some motherboard specific
>  initialization most be done by the BIOS, so if the watchdog is not enabled
> diff --git a/drivers/hwmon/sch5627.c b/drivers/hwmon/sch5627.c
> index 72c3f6757e34..25fbbd4c9a2b 100644
> --- a/drivers/hwmon/sch5627.c
> +++ b/drivers/hwmon/sch5627.c
> @@ -52,6 +52,9 @@ static const u16 SCH5627_REG_FAN[SCH5627_NO_FANS] = {
>  static const u16 SCH5627_REG_FAN_MIN[SCH5627_NO_FANS] = {
>  	0x62, 0x64, 0x66, 0x68 };
> 
> +static const u16 SCH5627_REG_PWM_MAP[SCH5627_NO_FANS] = {
> +	0xA0, 0xA1, 0xA2, 0xA3 };
> +
>  static const u16 SCH5627_REG_IN_MSB[SCH5627_NO_IN] = {
>  	0x22, 0x23, 0x24, 0x25, 0x189 };
>  static const u16 SCH5627_REG_IN_LSN[SCH5627_NO_IN] = {
> @@ -223,6 +226,9 @@ static int reg_to_rpm(u16 reg)
>  static umode_t sch5627_is_visible(const void *drvdata, enum hwmon_sensor_types type, u32 attr,
>  				  int channel)
>  {
> +	if (type == hwmon_pwm && attr == hwmon_pwm_auto_channels_temp)
> +		return 0644;
> +
>  	return 0444;
>  }
> 
> @@ -278,6 +284,23 @@ static int sch5627_read(struct device *dev, enum hwmon_sensor_types type, u32 at
>  			break;
>  		}
>  		break;
> +	case hwmon_pwm:
> +		switch (attr) {
> +		case hwmon_pwm_auto_channels_temp:
> +			mutex_lock(&data->update_lock);
> +			ret = sch56xx_read_virtual_reg(data->addr, SCH5627_REG_PWM_MAP[channel]);
> +			mutex_unlock(&data->update_lock);
> +
> +			if (ret < 0)
> +				return ret;
> +
> +			*val = ret;
> +
> +			return 0;
> +		default:
> +			break;
> +		}
> +		break;
>  	case hwmon_in:
>  		ret = sch5627_update_in(data);
>  		if (ret < 0)
> @@ -318,10 +341,42 @@ static int sch5627_read_string(struct device *dev, enum hwmon_sensor_types type,
>  	return -EOPNOTSUPP;
>  }
> 
> +static int sch5627_write(struct device *dev, enum hwmon_sensor_types type, u32 attr, int channel,
> +			 long val)
> +{
> +	struct sch5627_data *data = dev_get_drvdata(dev);
> +	int ret;
> +
> +	switch (type) {
> +	case hwmon_pwm:
> +		switch (attr) {
> +		case hwmon_pwm_auto_channels_temp:
> +			/* registers are 8 bit wide */
> +			if (val > U8_MAX || val < 0)
> +				return -EINVAL;
> +
> +			mutex_lock(&data->update_lock);
> +			ret = sch56xx_write_virtual_reg(data->addr, SCH5627_REG_PWM_MAP[channel],
> +							val);
> +			mutex_unlock(&data->update_lock);
> +
> +			return ret;
> +		default:
> +			break;
> +		}
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	return -EOPNOTSUPP;
> +}
> +
>  static const struct hwmon_ops sch5627_ops = {
>  	.is_visible = sch5627_is_visible,
>  	.read = sch5627_read,
>  	.read_string = sch5627_read_string,
> +	.write = sch5627_write,
>  };
> 
>  static const struct hwmon_channel_info *sch5627_info[] = {
> @@ -342,6 +397,12 @@ static const struct hwmon_channel_info *sch5627_info[] = {
>  			   HWMON_F_INPUT | HWMON_F_MIN | HWMON_F_FAULT,
>  			   HWMON_F_INPUT | HWMON_F_MIN | HWMON_F_FAULT
>  			   ),
> +	HWMON_CHANNEL_INFO(pwm,
> +			   HWMON_PWM_AUTO_CHANNELS_TEMP,
> +			   HWMON_PWM_AUTO_CHANNELS_TEMP,
> +			   HWMON_PWM_AUTO_CHANNELS_TEMP,
> +			   HWMON_PWM_AUTO_CHANNELS_TEMP
> +			   ),
>  	HWMON_CHANNEL_INFO(in,
>  			   HWMON_I_INPUT | HWMON_I_LABEL,
>  			   HWMON_I_INPUT | HWMON_I_LABEL,
