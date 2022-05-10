Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1964520B62
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 04:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234875AbiEJCnE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 22:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231723AbiEJCnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 22:43:02 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CF5126FA75;
        Mon,  9 May 2022 19:39:06 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id q10so2043490oia.9;
        Mon, 09 May 2022 19:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0TJE3soHGSdE4vXRalpTFyRINoVkfWSDyUf+84IPxcA=;
        b=j1bjjKPyf9bI/7ZWrEwZGQ4/btT480+G1mnQIekw2/bTxIorN8YGN0f5TPFBmjYkIu
         hghPkwH+WGhYd46jPY4O9nnItELx4MAPrFbf55A+m9SyHUZ85A0dJDeOWlX4t0Ey1QFM
         cHWS5LqY+TW7jGW7Vws42a7yORMYQ5UN8JcaGdxVlr+WIizlwChcM1/EcjRZhEgS1gGD
         UScOxG+g71aCD+suUf450a0p3zmVPiSKw19hxxrRWNojx0QrcCl8jQ9VKJ+ZxRPUjNF1
         a2DhL6/LjGYq4PeRvFNxApx8lR9ZKb4s/aK3Pb/V+b3TrPXWksE0FM+ewWqr3hIMSBCY
         iXuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=0TJE3soHGSdE4vXRalpTFyRINoVkfWSDyUf+84IPxcA=;
        b=rJ3GDENH3a5DY0F++C8fri/+aWq0SU7Ko0agontbdRHhPZd40raM73AXvmsK+U+PaA
         ybxm2ssdpzqZ/rLWIscb3Xf+glmbl/gzU13Edaj8IKXPSNGfO0E9KgEqYiZNxmTwU53/
         YCcmlnBX7SiLM3rMpNKhYWbYC2Xb+O5T7O2idmCXKoTxCOKYfMtrOwGBasfXtnCQrQt0
         ZY8XwnIFDIMVowknV408oeXCm0i0hYyERCu95ChMh91He5l8zhZRqVbBccrNLWwC+6a6
         OC9kvUMk27JnIqeWwAWvwPQlMjeefznhhjRx+nOcR11yWNbZrQ7usXgDiLAUMnA+Qg1/
         AdXA==
X-Gm-Message-State: AOAM5308KJX4Re5L8b1x4N4exFGsmNwRrMiY0mUGKFdCqNpQWIyzcmG7
        oklq/Hb2Rlco9dZSWkAetAc=
X-Google-Smtp-Source: ABdhPJxHyAfggEAnG6BCXmnjSIm/DK8GKp/ispG/khJMmxwwer6e5otQ8/MOGWAvi3w0y6aA1YmT/Q==
X-Received: by 2002:a54:4198:0:b0:326:5a5f:8ff7 with SMTP id 24-20020a544198000000b003265a5f8ff7mr12454819oiy.268.1652150345941;
        Mon, 09 May 2022 19:39:05 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t35-20020a05680815a300b0032617532120sm4907984oiw.48.2022.05.09.19.39.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 May 2022 19:39:04 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 9 May 2022 19:39:03 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] hwmon: acpi_power_meter: fix style issue
Message-ID: <20220510023903.GA1567190@roeck-us.net>
References: <20220509063010.3878134-1-clabbe@baylibre.com>
 <20220509063010.3878134-2-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220509063010.3878134-2-clabbe@baylibre.com>
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

On Mon, May 09, 2022 at 06:30:09AM +0000, Corentin Labbe wrote:
> Fix style issues found by checkpatch.
> 
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>

Applied to hwmon-next.

Thanks,
Guenter

> ---
>  drivers/hwmon/acpi_power_meter.c | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/hwmon/acpi_power_meter.c b/drivers/hwmon/acpi_power_meter.c
> index c405a5869581..d2545a1be9fc 100644
> --- a/drivers/hwmon/acpi_power_meter.c
> +++ b/drivers/hwmon/acpi_power_meter.c
> @@ -481,7 +481,7 @@ static struct sensor_template meter_attrs[] = {
>  	RO_SENSOR_TEMPLATE("power1_average_interval_max", show_val, 1),
>  	RO_SENSOR_TEMPLATE("power1_is_battery", show_val, 5),
>  	RW_SENSOR_TEMPLATE(POWER_AVG_INTERVAL_NAME, show_avg_interval,
> -		set_avg_interval, 0),
> +			   set_avg_interval, 0),
>  	{},
>  };
>  
> @@ -530,6 +530,7 @@ static void remove_domain_devices(struct acpi_power_meter_resource *resource)
>  
>  	for (i = 0; i < resource->num_domain_devices; i++) {
>  		struct acpi_device *obj = resource->domain_devices[i];
> +
>  		if (!obj)
>  			continue;
>  
> @@ -580,7 +581,7 @@ static int read_domain_devices(struct acpi_power_meter_resource *resource)
>  	}
>  
>  	resource->holders_dir = kobject_create_and_add("measures",
> -					&resource->acpi_dev->dev.kobj);
> +						       &resource->acpi_dev->dev.kobj);
>  	if (!resource->holders_dir) {
>  		res = -ENOMEM;
>  		goto exit_free;
> @@ -590,7 +591,7 @@ static int read_domain_devices(struct acpi_power_meter_resource *resource)
>  
>  	for (i = 0; i < pss->package.count; i++) {
>  		struct acpi_device *obj;
> -		union acpi_object *element = &(pss->package.elements[i]);
> +		union acpi_object *element = &pss->package.elements[i];
>  
>  		/* Refuse non-references */
>  		if (element->type != ACPI_TYPE_LOCAL_REFERENCE)
> @@ -603,7 +604,7 @@ static int read_domain_devices(struct acpi_power_meter_resource *resource)
>  			continue;
>  
>  		res = sysfs_create_link(resource->holders_dir, &obj->dev.kobj,
> -				      kobject_name(&obj->dev.kobj));
> +					kobject_name(&obj->dev.kobj));
>  		if (res) {
>  			acpi_dev_put(obj);
>  			resource->domain_devices[i] = NULL;
> @@ -788,7 +789,7 @@ static int read_capabilities(struct acpi_power_meter_resource *resource)
>  	str = &resource->model_number;
>  
>  	for (i = 11; i < 14; i++) {
> -		union acpi_object *element = &(pss->package.elements[i]);
> +		union acpi_object *element = &pss->package.elements[i];
>  
>  		if (element->type != ACPI_TYPE_STRING) {
>  			res = -EINVAL;
> @@ -868,8 +869,7 @@ static int acpi_power_meter_add(struct acpi_device *device)
>  	if (!device)
>  		return -EINVAL;
>  
> -	resource = kzalloc(sizeof(struct acpi_power_meter_resource),
> -			   GFP_KERNEL);
> +	resource = kzalloc(sizeof(*resource), GFP_KERNEL);
>  	if (!resource)
>  		return -ENOMEM;
>  
> @@ -884,7 +884,8 @@ static int acpi_power_meter_add(struct acpi_device *device)
>  	if (res)
>  		goto exit_free;
>  
> -	resource->trip[0] = resource->trip[1] = -1;
> +	resource->trip[0] = -1;
> +	resource->trip[1] = -1;
>  
>  	res = setup_attrs(resource);
>  	if (res)
