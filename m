Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 974064BFF42
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 17:51:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234358AbiBVQvf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 11:51:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234344AbiBVQvd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 11:51:33 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3739516AA7C;
        Tue, 22 Feb 2022 08:51:07 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id x3so511919qvd.8;
        Tue, 22 Feb 2022 08:51:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7lwww6qytMHobo/IrTZR1dCVgaY8SomLUb6wdjfR/YU=;
        b=XEm4WkG0oOgN8AUZzTVDbHzgu0/VcD27pX2Zf07bKZN6JejHr9JLwlByKexE7+JKyb
         3OtNgcJb1jefCbzI4oG77LpcI5JOBxmAZ1nP95MrR7+NFJeP0u/UrVkxzHE+9QDcwvMW
         YAPsKvEn1ZArVMPvnDUTQCXlLkLtkPiLHjhydgHLK+fakg8veEo2B8R/Jv2JsGIw11Fg
         FvvzTdV0RMP8W0Gy3e6Gt1e2Y/Baf5RQ/BS5wElA26uzSd+NpzcRVfqCASIADP+th5XR
         wfHc8Z1mXHKeSdYq3X39YHXHLYqmZQRj50bIeVvrnRyfBLRRpaCmXMV/j+v8nD+3ne2M
         gPQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=7lwww6qytMHobo/IrTZR1dCVgaY8SomLUb6wdjfR/YU=;
        b=8LFfLp6TApoVzVuNWLoRZ17rXgMO0KLLauGMWiQneLWbJfTxfYRwKtntzX0LMQEyH9
         Hi0/IQ4bb4dT1E4QaIKCO4AtGqDjdQ0ciyCs7MMbnDOpJd3SnWrwlD5rBljcJIrd/3/V
         f0FMPQ714ly4UPlgK49oACxaJvfF12nY/h/wevws17vW48W1p2lzOSqH5kXcZWNby3lW
         NIcacefZ5/qJXmUA7O5wijV3vjjQq9/pgbLkY+5FXEN/SbqdAaucXVPlizhCFgMXSHkt
         jU7ciMXcS8uaeoQbfGuxeESKDrSo1+jLTF4sijOeCADsAAIVzgYZ2Wdi8Y7eE6vrgH7L
         mFGw==
X-Gm-Message-State: AOAM531DQePtmUp6e7trF7wMb1DeuACw4Y5agCFVDxFDDMQeA5UDwGLZ
        hGdNRBgnH1sbrzSDnjU7EFU=
X-Google-Smtp-Source: ABdhPJzZcvVD+NCKZ0vruo8lkGr1oAcRpmZERWxk29emUz6sQM6wb/kwUTfw9zfwMbcuR7DKh7bbLg==
X-Received: by 2002:a05:622a:153:b0:2de:4ddc:8a73 with SMTP id v19-20020a05622a015300b002de4ddc8a73mr3393641qtw.636.1645548666401;
        Tue, 22 Feb 2022 08:51:06 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id bs39sm80972qkb.24.2022.02.22.08.51.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 08:51:05 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 22 Feb 2022 08:51:04 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Marcello Sylvester Bauer <sylv@sylv.io>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>
Subject: Re: [PATCH v2 1/1] hwmon: (pmbus) Add regulator supply into macro
Message-ID: <20220222165104.GA255067@roeck-us.net>
References: <cover.1645437439.git.sylv@sylv.io>
 <58f2ff7b90233fad3d7ae2e9d66d5192e2c1ac01.1645437439.git.sylv@sylv.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58f2ff7b90233fad3d7ae2e9d66d5192e2c1ac01.1645437439.git.sylv@sylv.io>
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

On Mon, Feb 21, 2022 at 12:09:56PM +0100, Marcello Sylvester Bauer wrote:
> Add regulator supply into PWBUS_REGULATOR macro. This makes it optional
> to define a vin-supply in DT. Not defining a supply will add a dummy
> regulator supply instead and only cause the following debug output:
> 
> ```
> Looking up vin-supply property in node [...] failed
> ```
> 
> Signed-off-by: Marcello Sylvester Bauer <sylv@sylv.io>

Applied to hwmon-next. That should give it some time to mature,
and we can pull or modify it if it causes any problems.

Thanks,
Guenter

> ---
>  drivers/hwmon/pmbus/pmbus.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/hwmon/pmbus/pmbus.h b/drivers/hwmon/pmbus/pmbus.h
> index e0aa8aa46d8c..38f049d68d32 100644
> --- a/drivers/hwmon/pmbus/pmbus.h
> +++ b/drivers/hwmon/pmbus/pmbus.h
> @@ -464,6 +464,7 @@ extern const struct regulator_ops pmbus_regulator_ops;
>  #define PMBUS_REGULATOR(_name, _id)				\
>  	[_id] = {						\
>  		.name = (_name # _id),				\
> +		.supply_name = "vin",				\
>  		.id = (_id),					\
>  		.of_match = of_match_ptr(_name # _id),		\
>  		.regulators_node = of_match_ptr("regulators"),	\
