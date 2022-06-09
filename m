Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8F8F544CAD
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 14:54:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238817AbiFIMy3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 08:54:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiFIMyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 08:54:21 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F72712B037;
        Thu,  9 Jun 2022 05:54:20 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id h187so18634703oif.4;
        Thu, 09 Jun 2022 05:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=1qmlkIQGWWghNqPvcjQHEoq54ltBSdpD6XTRbIpAXQc=;
        b=m+4ICiMwzrvFQekFk7vR1Ff9y061YztrPdeG1cXCQCmAlrzziA/h6dtqVv+1J4o6j/
         lJeNAxz1HSUUVmBnudeiVl4ILCKmfHaufS9vrcBh4l35xjyX7EJHSy1Xou/jgp3i6bvK
         x0dfo9TMAuNRnBXINpgAwYetfN+aUWe7wruX5pw4NPWBTh1HmrdJFk/pmgZwRWd7wY4t
         hA/SADx8k1w1lBhQmVkQ7v1HN4fKF3tAHO1uO3PRh1SLIsUPVYBlnW2JTM0CIpiwUP5g
         BRuEzb8jDfql9AHzVIBemEsLItpxbY5gYp0/iDJdCUWeHv/Rx4lZ0hKLnSKnw/Z6naql
         Aokg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=1qmlkIQGWWghNqPvcjQHEoq54ltBSdpD6XTRbIpAXQc=;
        b=HZIGvtlpLE/ViAiEQzOfQHbe6u+pDKijby9nE1Ws/MBwX2J8/mdt/r8doDNUc2n6zJ
         ME7QG/5Ul5iz2jJfERskX02cxY+cYe2ivWheN3DhY5j9S1vLBrG2UFoLNnMkvugdITNX
         JeOlf/lfztqe8nty2+jwzA+GUzxlGoegGicdE7Wz1A4YxX6X6YddOOPvSqTaSbQjLMQe
         fSOt85o3Xo9d3NG4Cvnw0V7nla3oXNCnwmWA44qr9WmZTmM2OYYtH8I4rXDBDgYAQiQx
         ChFS7WSYetxXNdqm/8mKPXq4PjOXY9hvquoqQAs8MOd21/giOyYetZu90vQDZJR497YT
         MJLA==
X-Gm-Message-State: AOAM532E+v3+bPas31b7lf3qbNKnuHtDNjAuX7KLvGxm6zYvLmYJ5/gq
        /pYfPjTZ6dYg2iF8M9qkJKJWgv/xzNQ=
X-Google-Smtp-Source: ABdhPJwOMwq4COCWH4Zzsr4EMI3ankGeS2uaFE+jIgcs7LJkXrzKZXHnYY1QND9sbY24AVRCJJbEDQ==
X-Received: by 2002:aca:b786:0:b0:32b:8df1:919b with SMTP id h128-20020acab786000000b0032b8df1919bmr1664699oif.190.1654779259676;
        Thu, 09 Jun 2022 05:54:19 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v10-20020a056870424a00b000f317901b29sm11041648oac.4.2022.06.09.05.54.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 05:54:19 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 9 Jun 2022 05:54:17 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Ren Zhijie <renzhijie2@huawei.com>
Cc:     jdelvare@suse.com, dev_public@wujek.eu,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 -next] hwmon: (pmbus) fix build error unused-function
Message-ID: <20220609125417.GA1681487@roeck-us.net>
References: <20220609120448.139907-1-renzhijie2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220609120448.139907-1-renzhijie2@huawei.com>
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

On Thu, Jun 09, 2022 at 08:04:48PM +0800, Ren Zhijie wrote:
> If CONFIG_PMBUS is y and CONFIG_DEBUG_FS is not set.
> 
> make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu-, will be failed, like this:
> drivers/hwmon/pmbus/pmbus_core.c:593:13: error: ‘pmbus_check_block_register’ defined but not used [-Werror=unused-function]
>  static bool pmbus_check_block_register(struct i2c_client *client, int page,
>              ^~~~~~~~~~~~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors
> make[3]: *** [drivers/hwmon/pmbus/pmbus_core.o] Error 1
> make[2]: *** [drivers/hwmon/pmbus] Error 2
> make[2]: *** Waiting for unfinished jobs....
> make[1]: *** [drivers/hwmon] Error 2
> make[1]: *** Waiting for unfinished jobs....
> make: *** [drivers] Error 2
> 
> To fix building warning, use __maybe_unused to attach this func.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Fixes: c3ffc3a1ff83("hwmon: (pmbus) add a function to check the presence of a block register")
> Signed-off-by: Ren Zhijie <renzhijie2@huawei.com>

Applied.

Thanks,
Guenter

> ---
> v2: use __maybe_unused to attach this function, which Guenter suggested.
> ---
>  drivers/hwmon/pmbus/pmbus_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
> index 809e666cb52b..e6d3a1118453 100644
> --- a/drivers/hwmon/pmbus/pmbus_core.c
> +++ b/drivers/hwmon/pmbus/pmbus_core.c
> @@ -590,7 +590,7 @@ bool pmbus_check_word_register(struct i2c_client *client, int page, int reg)
>  }
>  EXPORT_SYMBOL_NS_GPL(pmbus_check_word_register, PMBUS);
>  
> -static bool pmbus_check_block_register(struct i2c_client *client, int page,
> +static bool __maybe_unused pmbus_check_block_register(struct i2c_client *client, int page,
>  				       int reg)
>  {
>  	int rv;
