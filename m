Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E91DA520A27
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 02:30:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233442AbiEJAdr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 20:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiEJAdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 20:33:43 -0400
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67097293B5B;
        Mon,  9 May 2022 17:29:48 -0700 (PDT)
Received: by mail-oo1-xc35.google.com with SMTP id c22-20020a4ad216000000b0035f13ae7646so2850932oos.9;
        Mon, 09 May 2022 17:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4ddPp9Dw0rrReN3EdBdVfQvB4Og0pQB+7ad9oZ0jVbA=;
        b=A+HBDOOz9txlLtPj92ABOIlK0v2/aXLWA4dGOmd+611VVgQxLq2J7VOmUosdkH2gwB
         VIbDuzgRAZSlaF7Lo2bmD5oE0tojsORUUBvPv+AMqOe8MnVi2nZONPN37pBVJpMyfBI8
         umDBLZjq7Ik1wKp2f3BTe2PKkzEqEr35OT7Ni6XFu1kspCpmMGz3XSShiUKXc+Y4sb0H
         unTac6WToYGzGPbJT9hcuK/MaH9XkMzHqqo8cuwuTlzP/geAdN4W1dOHq6jR9M48Nh7A
         Mdx7L21nBBzLtFMU2MRzMJZwmi/ADxGal6kFo7nw9rB65tipBt1kD4lQX33yeY5921jM
         be8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=4ddPp9Dw0rrReN3EdBdVfQvB4Og0pQB+7ad9oZ0jVbA=;
        b=V26iakT5z6omehXw6vkQvBHbEWwHjMhi5GOcMvgoE7fxy728wpLfdwKKM69GJsOoR9
         YC+rK55ZwX/D/4+Uoak9ju42b+Bu7AH2sjyyG7gKj6XpocKID/8E9U7ah4znFYtg0PLN
         L5+PuQ1wsZ/voopMGH6Och1q6lICd3+ICf72UH9hZXEtKerinFM405PPitITSGEjKlhz
         TqahfVV42TEEa77WCNjZa5GUXw4Kr/c0dpso7izwucNm1MYNPpu5+mVzoDIUE05c0OVY
         GOrOE3SI1yIzlQfGNflVgQ4wdGNpDJj6S0pp5ARr/0tcCMKi15wT8PkQwpk5BHk/TGZY
         CT6Q==
X-Gm-Message-State: AOAM532noTly0S9xZjPyT2PHL6pEP8yFRU9BcOg23nl6PYiScH9cRqAq
        NGinW7FjrpRzuvyatp2o1GxZgvPwbPqRRg==
X-Google-Smtp-Source: ABdhPJz0kzg0BfFO6HMjs4vhI0dHOGiPjFjpsAhhoynSRPzQOSfqd2p8gX2o9wBEOHMB6d6eNmRdTw==
X-Received: by 2002:a4a:645:0:b0:35f:82e0:beab with SMTP id 66-20020a4a0645000000b0035f82e0beabmr2094974ooj.73.1652142587735;
        Mon, 09 May 2022 17:29:47 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a204-20020acab1d5000000b00325643bce40sm5009358oif.0.2022.05.09.17.29.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 May 2022 17:29:46 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 9 May 2022 17:29:45 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Karl Mehltretter <kmehltretter@gmail.com>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (lm83) Remove unused include directives
Message-ID: <20220510002945.GA1561373@roeck-us.net>
References: <20220508144601.22796-1-kmehltretter@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220508144601.22796-1-kmehltretter@gmail.com>
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

On Sun, May 08, 2022 at 04:46:01PM +0200, Karl Mehltretter wrote:
> Some include directives are no longer necessary due to previous driver
> changes. Remove them now to further improve driver code clarity.
> 
> Mutex usage has ceased since commit 719af4f1a40b ("hwmon: (lm83) Use
> regmap").
> 
> Ever since commit a0ac840d99fa ("hwmon: (lm83) Convert to use
> devm_hwmon_device_register_with_groups") functions sysfs_create_group
> and sysfs_remove_group are no longer used by the driver.
> 
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>

Applied. Thanks!

Guenter

> ---
>  drivers/hwmon/lm83.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/hwmon/lm83.c b/drivers/hwmon/lm83.c
> index 12370dcef..905f5689f 100644
> --- a/drivers/hwmon/lm83.c
> +++ b/drivers/hwmon/lm83.c
> @@ -24,10 +24,8 @@
>  #include <linux/init.h>
>  #include <linux/hwmon.h>
>  #include <linux/module.h>
> -#include <linux/mutex.h>
>  #include <linux/regmap.h>
>  #include <linux/slab.h>
> -#include <linux/sysfs.h>
>  
>  /*
>   * Addresses to scan
