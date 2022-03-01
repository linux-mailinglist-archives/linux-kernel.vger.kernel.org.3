Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C8034C9425
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 20:20:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234273AbiCATVV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 14:21:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231880AbiCATVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 14:21:20 -0500
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACFEF52E20;
        Tue,  1 Mar 2022 11:20:39 -0800 (PST)
Received: by mail-oo1-xc31.google.com with SMTP id d134-20020a4a528c000000b00319244f4b04so23589567oob.8;
        Tue, 01 Mar 2022 11:20:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=dWNa4jnkJUdD4zmrmu2TXP/cBbtNwd4vnJSmx1wcNdA=;
        b=oC/ECoqRSEzXbasodKpaq4YzMPznsADCPrKuK2tWPn1puyjt6vZxjk+yxZ37GE6mbT
         SI8eN1PqqD2q9yWbXgrUSi9l8UfYtim92QhzqMBU09OfrL0ASI8P/GgyVGFSpmCYsNLX
         00i4DuoKJSJoTYJu6afS4lc/ceAALxkq/w6eGNCZOVTi7AydpO67ZV/LBskxtw66aBxN
         lt5snF3TGxH470nH2e+IrE2AWEEcgITohwGbTX+8NQ7zuHNSV/oNqSrL7MCc++4nu8ld
         u1A3VagiazlX88BbdEd2vYuZ5ztvfFe2ALFYRWReWHgiQ98N370ssEWT5fVucx4Mb57y
         yj1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=dWNa4jnkJUdD4zmrmu2TXP/cBbtNwd4vnJSmx1wcNdA=;
        b=yeD4197lYduFDg0kxmC6jiMdv9bn7i129x0eqeMJKsveeUjRGEviZwdGeMh5tsy79U
         OE69ESv6bL469MJ71jFVl3DWnH0Ywyp+daSfHjm/diIi7djB8C6icSbg5xct4udVhwWV
         8akHDhNRgZKx7v+vQjEaJILw6hiKcKI9mqPYhYy+cMjy7VEmXNb7Qg6HIP+7iSD3k9Q/
         qCiSF3kWfad4jADqTkju95bobVaDr/JeA0xM0J8nZDPQLFcKKPe4NYQyfTEv7XoumerD
         QrY+gBcq/HRWQuKQJA1woLT4iAPPGxoxsmAOilrl0qhFM6FQs8MDAyKzumL5eIXAb9J0
         9BIg==
X-Gm-Message-State: AOAM5308J6ISUIQlify7Wbpsia9ao/+GLev1FvHoiYs8WCzCnuljzx4d
        XO+JNTooJUpLFQyMEldpNXUa4DMNgqs=
X-Google-Smtp-Source: ABdhPJz6TKAi8o7S/ijB/g3kZZVCZKlC5i0rdkD6wYrU7My3EccH19Fs2cJQD0r8qdloLCw7PFNW3Q==
X-Received: by 2002:a4a:d295:0:b0:2da:7b0b:281 with SMTP id h21-20020a4ad295000000b002da7b0b0281mr12909720oos.56.1646162438718;
        Tue, 01 Mar 2022 11:20:38 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g16-20020a544f90000000b002d3c88c9ec2sm8625035oiy.16.2022.03.01.11.20.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Mar 2022 11:20:38 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <67be7041-6489-54ba-f595-f179b4056af5@roeck-us.net>
Date:   Tue, 1 Mar 2022 11:20:36 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 2/3] hwmon (xdpe12284): Add support for xdpe11280
Content-Language: en-US
To:     Marcello Sylvester Bauer <sylv@sylv.io>,
        Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-doc@vger.kernel.org
References: <cover.1646157237.git.sylv@sylv.io>
 <c9c0bcd8106c370243ba061dc4298d58b4e2f64b.1646157237.git.sylv@sylv.io>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <c9c0bcd8106c370243ba061dc4298d58b4e2f64b.1646157237.git.sylv@sylv.io>
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

On 3/1/22 10:01, Marcello Sylvester Bauer wrote:
> Add support for another Infineon Multi-phase controller chip. The
> xdpe11280 uses linear instead of vid data format for VOUT. Detect
> VOUT_MODE format during probing and set the xdpe122 related pointers
> in case it uses vid.
> 
> Signed-off-by: Marcello Sylvester Bauer <sylv@sylv.io>
> ---
>   Documentation/hwmon/xdpe12284.rst | 12 ++++++++----
>   drivers/hwmon/pmbus/xdpe12284.c   | 22 +++++++++++++++++++---
>   2 files changed, 27 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/hwmon/xdpe12284.rst b/Documentation/hwmon/xdpe12284.rst
> index 67d1f87808e5..a224dc74ad35 100644
> --- a/Documentation/hwmon/xdpe12284.rst
> +++ b/Documentation/hwmon/xdpe12284.rst
> @@ -5,6 +5,10 @@ Kernel driver xdpe122
>   
>   Supported chips:
>   
> +  * Infineon XDPE11280
> +
> +    Prefix: 'xdpe11280'
> +
>     * Infineon XDPE12254
>   
>       Prefix: 'xdpe12254'
> @@ -20,10 +24,10 @@ Authors:
>   Description
>   -----------
>   
> -This driver implements support for Infineon Multi-phase XDPE122 family
> -dual loop voltage regulators.
> -The family includes XDPE12284 and XDPE12254 devices.
> -The devices from this family complaint with:
> +This driver implements support for Infineon Multi-phase XDPE112 and XDPE122
> +family dual loop voltage regulators.
> +These families include XDPE11280, XDPE12284 and XDPE12254 devices.
> +The devices from this family compliant with:
>   
>   - Intel VR13 and VR13HC rev 1.3, IMVP8 rev 1.2 and IMPVP9 rev 1.3 DC-DC
>     converter specification.
> diff --git a/drivers/hwmon/pmbus/xdpe12284.c b/drivers/hwmon/pmbus/xdpe12284.c
> index b07da06a40c9..3413aba9d5be 100644
> --- a/drivers/hwmon/pmbus/xdpe12284.c
> +++ b/drivers/hwmon/pmbus/xdpe12284.c
> @@ -110,7 +110,6 @@ static int xdpe122_identify(struct i2c_client *client,
>   static struct pmbus_driver_info xdpe122_info = {
>   	.pages = XDPE122_PAGE_NUM,
>   	.format[PSC_VOLTAGE_IN] = linear,
> -	.format[PSC_VOLTAGE_OUT] = vid,
>   	.format[PSC_TEMPERATURE] = linear,
>   	.format[PSC_CURRENT_IN] = linear,
>   	.format[PSC_CURRENT_OUT] = linear,
> @@ -123,23 +122,39 @@ static struct pmbus_driver_info xdpe122_info = {
>   		PMBUS_HAVE_IIN | PMBUS_HAVE_IOUT | PMBUS_HAVE_STATUS_IOUT |
>   		PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP |
>   		PMBUS_HAVE_POUT | PMBUS_HAVE_PIN | PMBUS_HAVE_STATUS_INPUT,
> -	.identify = xdpe122_identify,
> -	.read_word_data = xdpe122_read_word_data,
>   };
>   
>   static int xdpe122_probe(struct i2c_client *client)
>   {
>   	struct pmbus_driver_info *info;
> +	int vout_mode;
>   
>   	info = devm_kmemdup(&client->dev, &xdpe122_info, sizeof(*info),
>   			    GFP_KERNEL);
>   	if (!info)
>   		return -ENOMEM;
>   
> +	vout_mode = pmbus_read_byte_data(client, 0, PMBUS_VOUT_MODE);
> +	if (vout_mode >= 0 && vout_mode != 0xff) {
> +		switch (vout_mode >> 5) {
> +		case 0:
> +			info->format[PSC_VOLTAGE_OUT] = linear;
> +			break;
> +		case 1:
> +			info->format[PSC_VOLTAGE_OUT] = vid;
> +			info->identify = xdpe122_identify;
> +			info->read_word_data = xdpe122_read_word_data;
> +			break;
> +		default:
> +			return -ENODEV;
> +		}
> +	}

I am not entirely happy with this. Why not detect the mode (linear vs. vid)
in the identify function ?

Thanks,
Guenter

> +
>   	return pmbus_do_probe(client, info);
>   }
>   
>   static const struct i2c_device_id xdpe122_id[] = {
> +	{"xdpe11280", 0},
>   	{"xdpe12254", 0},
>   	{"xdpe12284", 0},
>   	{}
> @@ -148,6 +163,7 @@ static const struct i2c_device_id xdpe122_id[] = {
>   MODULE_DEVICE_TABLE(i2c, xdpe122_id);
>   
>   static const struct of_device_id __maybe_unused xdpe122_of_match[] = {
> +	{.compatible = "infineon,xdpe11280"},
>   	{.compatible = "infineon,xdpe12254"},
>   	{.compatible = "infineon,xdpe12284"},
>   	{}

