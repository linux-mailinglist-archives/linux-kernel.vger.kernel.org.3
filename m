Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCE50516A14
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 06:36:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359010AbiEBEj7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 00:39:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356680AbiEBEj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 00:39:56 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 036C83EAA4;
        Sun,  1 May 2022 21:36:28 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id 12so14217646oix.12;
        Sun, 01 May 2022 21:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2ramQowP2v1/1bs6v3KxUsUq9XHzvwYl9Fqc9aiXryQ=;
        b=A3pGLjtCv8Me7gv4kLSd8L11kCp64YhIsgP+1IvKrKrPixSkRs7PcUi6jbyNFEfadL
         9WG/GAaOdHYsLk1Pg7SgRgyWdav+VKYRZpgLgLJzcqwRbEKYHVRqPJ/JsLcTn3L/8Qd9
         73lsZTgvEMqq6HIXFb53Xa3i+8nf9HyVnwaRrXqxdVpfTNyrbd8ysq2OyTVCOBEFInUF
         2IkaLVq8gDhe2IWUvrbh3lE8O0gsazovr0Hv7LYernVc3fClgceKGQd9IRgakyTHR7Rd
         CGz7uYqWk35hZdZpW1/BmOJpnv3ATGHJfcXG3rKEGoR+0JCJn2CHyzhrfSaaG4hhX9zG
         iXEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=2ramQowP2v1/1bs6v3KxUsUq9XHzvwYl9Fqc9aiXryQ=;
        b=qjpdSUz+//Y3O/sVB7N4dP24wAwANwuslvFq0XX7wVOTxKPATJtRMGBLlM82oAEPgx
         3U+o0xF0bLFechgTc7g9m2lz1Jb4FAigNiLvVId+bullmihAD8m0Tent4fCo6yNawvaP
         DkYnhE56TA/XTb8PeN5YNMpbIgPZU0uDsUpr6rohswB4MHR7FJuJz8FnBMOJNbsKYrW0
         z+KmrcWMGuN32/GrFQGXV058EPepOD7p15OKJBC1fQChpsnJSFeWTUIH/yl7U29yGWk+
         R2qfl5oFss/1yaPxuzKy/D3s5JqyQK0ygGRN5T0L4jcKaJXmHNjyFEMK4DTLptFP01Wk
         H1bA==
X-Gm-Message-State: AOAM5329YR64tBLdyJhnEVI0T7c5ExEFswKsm4AetTXFjo0cJbZDiZkU
        JOf8+3jUGQ9unyAHU34DYd8=
X-Google-Smtp-Source: ABdhPJzJWBZSODlvZsghlPyKl2q8HtpfRtvXNB4hLUfmblEuF/SgRr6Ao86BkkpGgxosynuKbaqRww==
X-Received: by 2002:a05:6808:bc2:b0:325:9646:43a0 with SMTP id o2-20020a0568080bc200b00325964643a0mr4825319oik.152.1651466187356;
        Sun, 01 May 2022 21:36:27 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l2-20020a4ad9c2000000b0035eb4e5a6b7sm3507006oou.13.2022.05.01.21.36.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 May 2022 21:36:26 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 1 May 2022 21:36:25 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     jdelvare@suse.com, robh+dt@kernel.org, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] hwmon: (adt7475) Add support for pin configuration
Message-ID: <20220502043625.GA1719328@roeck-us.net>
References: <20220323034056.260455-1-chris.packham@alliedtelesis.co.nz>
 <20220323034056.260455-3-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220323034056.260455-3-chris.packham@alliedtelesis.co.nz>
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

On Wed, Mar 23, 2022 at 04:40:55PM +1300, Chris Packham wrote:
> The adt7473, adt7475, adt7476 and adt7490 have pins that can be used for
> different functions. On the adt7473 and  adt7475 this is pins 5 and 9.
> On the adt7476 and adt7490 this is pins 10 and 14.
> 
> The first pin can either be PWM2(default) or SMBALERT#. The second pin
> can be TACH4(default), THERM#, SMBALERT# or GPIO.
> 
> The adt7475 driver has always been able to detect the configuration if
> it had been done by an earlier boot stage. Add support for configuring
> the pins based on the hardware description in the device tree.
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Applied to hwmon-next.

Thanks,
Guenter

> ---
> 
> Notes:
>     Changes in v3:
>     - None
>     Changes in v2:
>     - Use load_config{3,4} instead of load_pin{10,14}_config
>     - Handle errors from adt7475_read()
>     - Remove obsolete check on chip type
>     - Use enum chips instead of int
>     - Update error messages
> 
>  drivers/hwmon/adt7475.c | 96 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 96 insertions(+)
> 
> diff --git a/drivers/hwmon/adt7475.c b/drivers/hwmon/adt7475.c
> index 9d5b019651f2..6de501de41b2 100644
> --- a/drivers/hwmon/adt7475.c
> +++ b/drivers/hwmon/adt7475.c
> @@ -112,6 +112,8 @@
>  #define CONFIG3_THERM		0x02
>  
>  #define CONFIG4_PINFUNC		0x03
> +#define CONFIG4_THERM		0x01
> +#define CONFIG4_SMBALERT	0x02
>  #define CONFIG4_MAXDUTY		0x08
>  #define CONFIG4_ATTN_IN10	0x30
>  #define CONFIG4_ATTN_IN43	0xC0
> @@ -1460,6 +1462,96 @@ static int adt7475_update_limits(struct i2c_client *client)
>  	return 0;
>  }
>  
> +static int load_config3(const struct i2c_client *client, const char *propname)
> +{
> +	const char *function;
> +	u8 config3;
> +	int ret;
> +
> +	ret = of_property_read_string(client->dev.of_node, propname, &function);
> +	if (!ret) {
> +		ret = adt7475_read(REG_CONFIG3);
> +		if (ret < 0)
> +			return ret;
> +
> +		config3 = ret & ~CONFIG3_SMBALERT;
> +		if (!strcmp("pwm2", function))
> +			;
> +		else if (!strcmp("smbalert#", function))
> +			config3 |= CONFIG3_SMBALERT;
> +		else
> +			return -EINVAL;
> +
> +		return i2c_smbus_write_byte_data(client, REG_CONFIG3, config3);
> +	}
> +
> +	return 0;
> +}
> +
> +static int load_config4(const struct i2c_client *client, const char *propname)
> +{
> +	const char *function;
> +	u8 config4;
> +	int ret;
> +
> +	ret = of_property_read_string(client->dev.of_node, propname, &function);
> +	if (!ret) {
> +		ret = adt7475_read(REG_CONFIG4);
> +		if (ret < 0)
> +			return ret;
> +
> +		config4 = ret & ~CONFIG4_PINFUNC;
> +
> +		if (!strcmp("tach4", function))
> +			;
> +		else if (!strcmp("therm#", function))
> +			config4 |= CONFIG4_THERM;
> +		else if (!strcmp("smbalert#", function))
> +			config4 |= CONFIG4_SMBALERT;
> +		else if (!strcmp("gpio", function))
> +			config4 |= CONFIG4_PINFUNC;
> +		else
> +			return -EINVAL;
> +
> +		return i2c_smbus_write_byte_data(client, REG_CONFIG4, config4);
> +	}
> +
> +	return 0;
> +}
> +
> +static int load_config(const struct i2c_client *client, enum chips chip)
> +{
> +	int err;
> +	const char *prop1, *prop2;
> +
> +	switch (chip) {
> +	case adt7473:
> +	case adt7475:
> +		prop1 = "adi,pin5-function";
> +		prop2 = "adi,pin9-function";
> +		break;
> +	case adt7476:
> +	case adt7490:
> +		prop1 = "adi,pin10-function";
> +		prop2 = "adi,pin14-function";
> +		break;
> +	}
> +
> +	err = load_config3(client, prop1);
> +	if (err) {
> +		dev_err(&client->dev, "failed to configure %s\n", prop1);
> +		return err;
> +	}
> +
> +	err = load_config4(client, prop2);
> +	if (err) {
> +		dev_err(&client->dev, "failed to configure %s\n", prop2);
> +		return err;
> +	}
> +
> +	return 0;
> +}
> +
>  static int set_property_bit(const struct i2c_client *client, char *property,
>  			    u8 *config, u8 bit_index)
>  {
> @@ -1585,6 +1677,10 @@ static int adt7475_probe(struct i2c_client *client)
>  		revision = adt7475_read(REG_DEVID2) & 0x07;
>  	}
>  
> +	ret = load_config(client, chip);
> +	if (ret)
> +		return ret;
> +
>  	config3 = adt7475_read(REG_CONFIG3);
>  	/* Pin PWM2 may alternatively be used for ALERT output */
>  	if (!(config3 & CONFIG3_SMBALERT))
