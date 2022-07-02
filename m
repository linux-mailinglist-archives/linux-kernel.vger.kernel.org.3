Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C70BA56426D
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 21:13:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232242AbiGBTN2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 15:13:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiGBTNZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 15:13:25 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9099E2701;
        Sat,  2 Jul 2022 12:13:20 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id t21so5463126pfq.1;
        Sat, 02 Jul 2022 12:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bNbs1WSuB65484dd7qrhb9iZC6Pp1XxllCs2PT2eL2g=;
        b=JEVH5slh/Ly8dUngVAk/c9UdoOlwYEayDEzUpCLCi3nxr6mGsGFkH6OkeyMosyf4EA
         AlFhWXI/M1jwPflkMkD1B26J794H6y1Z4piTdLaMDNsrKs3b8WnS+1N1+bsiwk+JfgYT
         n7bhqTUjrprQhXwRnIjw4LJa25rQLIFeuiOemELrqsnmDGX7dhNmAoOKjiQgokbOtR9K
         MnfLb8EJkMaI9UcrPifQRIk+cXqyxth8xYf/JGTunkheJPLzicYL9PJd4VReVTHSQA1v
         ym6r6kX/Ax+3cqrmau5myiDGwfDm2UF1RxJRgHSvq8WDLLg+a3HvCPXTZ1Gq3E8X8FMn
         pHBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=bNbs1WSuB65484dd7qrhb9iZC6Pp1XxllCs2PT2eL2g=;
        b=dI/31xeqI4VCklbfBI5o2uZxcjF+4CZyL+Q2IJ7QgBM1JRRUIb0YrT3EGZKkBkRX99
         gHZDERN6b0BUZT5Cf2QqSk4/iyJJzJzcbPn3g+VAvJJIReJSNWYWD/CKQPQJlrbtsCnk
         RkKJdl8vZuV+vjyhdtTKbHBdnIn1ncsCk9cZSo09/ZRq15dwIHhSb0e66c5HX83i9EUB
         AAFBg/VNgA9PODzOD9xTBdpBYw+UWMQ3wNK49/vz1kLsW4MEoRagInl1wZeEtmwA9fhU
         sciJ0rkG15hCHk0OOAawqZx/5/5q0LqFLktbzgRyD50pQkfbUkoRez64pypSPjsb2BbT
         vZkw==
X-Gm-Message-State: AJIora9H3yHutWUpkAHv9h+jFYsGRLn0t2jmatLdmRdF2ftISKAPBDOi
        onX8lVczppMYqRmIbHvc6kAjHlBMkNU=
X-Google-Smtp-Source: AGRyM1vGBunOmWhcC4HG4ED/gjzh8urYHFdeNqUa4ITfA7z5h+7yfkSLAzfFEQoh/9K1q1FiAz64Ow==
X-Received: by 2002:a62:7b95:0:b0:525:8304:2f16 with SMTP id w143-20020a627b95000000b0052583042f16mr25998748pfc.33.1656789200025;
        Sat, 02 Jul 2022 12:13:20 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h18-20020a170902f7d200b001624cd63bbbsm17765796plw.133.2022.07.02.12.13.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Jul 2022 12:13:17 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sat, 2 Jul 2022 12:13:16 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Ed Brindley <kernel@maidavale.org>,
        Denis Pauk <pauk.denis@gmail.com>,
        Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH v2] hwmon: (asus_wmi_sensors) Save a few bytes of memory
Message-ID: <20220702191316.GA3131040@roeck-us.net>
References: <e23cea6c489fabb109a61e8a33d146a6b74c0529.1656741926.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e23cea6c489fabb109a61e8a33d146a6b74c0529.1656741926.git.christophe.jaillet@wanadoo.fr>
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

On Sat, Jul 02, 2022 at 08:05:54AM +0200, Christophe JAILLET wrote:
> The first 'for' loop of asus_wmi_configure_sensor_setup() only computes
> the number and type of sensors that exist in the system.
> 
> Here, the 'temp_sensor' structure is only used to store the data collected
> by asus_wmi_sensor_info(). There is no point in using a devm_ variant for
> this allocation. This wastes some memory for no good reason.
> 
> Use the stack instead.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Applied to hwmon-next.

Thanks,
Guenter

> ---
> v1 -> v2: Use the stack instead of kmalloc/kfree to simplify even more the
>           code (Guenter Roeck)
> ---
>  drivers/hwmon/asus_wmi_sensors.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/hwmon/asus_wmi_sensors.c b/drivers/hwmon/asus_wmi_sensors.c
> index 9e935e34c998..6e8a908171f0 100644
> --- a/drivers/hwmon/asus_wmi_sensors.c
> +++ b/drivers/hwmon/asus_wmi_sensors.c
> @@ -514,22 +514,20 @@ static int asus_wmi_configure_sensor_setup(struct device *dev,
>  	int i, idx;
>  	int err;
>  
> -	temp_sensor = devm_kcalloc(dev, 1, sizeof(*temp_sensor), GFP_KERNEL);
> -	if (!temp_sensor)
> -		return -ENOMEM;
> -
>  	for (i = 0; i < sensor_data->wmi.sensor_count; i++) {
> -		err = asus_wmi_sensor_info(i, temp_sensor);
> +		struct asus_wmi_sensor_info sensor;
> +
> +		err = asus_wmi_sensor_info(i, &sensor);
>  		if (err)
>  			return err;
>  
> -		switch (temp_sensor->data_type) {
> +		switch (sensor.data_type) {
>  		case TEMPERATURE_C:
>  		case VOLTAGE:
>  		case CURRENT:
>  		case FAN_RPM:
>  		case WATER_FLOW:
> -			type = asus_data_types[temp_sensor->data_type];
> +			type = asus_data_types[sensor.data_type];
>  			if (!nr_count[type])
>  				nr_types++;
>  			nr_count[type]++;
