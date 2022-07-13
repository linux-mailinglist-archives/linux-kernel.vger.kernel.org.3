Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F134573F57
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 00:03:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237254AbiGMWDO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 18:03:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236974AbiGMWDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 18:03:11 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0816F31218;
        Wed, 13 Jul 2022 15:03:10 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id e16so161869pfm.11;
        Wed, 13 Jul 2022 15:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2Nit9dg2fUOCAwhmRb3tYR/tqHtTiU+bduaXCgGuCVQ=;
        b=TSNaU643bQ3VzBuxBfOvj895y403PdM2R8/cL24/oJdWe2suvLzsr35Tjwhnp3BA1T
         BXOEc6NePxmbnjhWIHA7jiQqK6pSni5cW/yksqRiJjCUSng6IhW8nWmMZp6IQV5ubCw/
         RZ4hhdcjsxnbzb9ZvJB9JCtYybqjiblb5B/89f5aS8jYY9ZNjjEhELFBY8A6BLLX/MOE
         KfwEYVhmqRdi8AGxiDOc/ks7TgqdiwwCh7yfb9QRM9LrlQM4ODOto0iX7APoRRqjY1N3
         MV6J/XeC6RvOR4+lY2u2G/x080uKOMzfkqWjD84dty1xT7CXw8noZSWwXE8l0KEJLx3g
         VMCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=2Nit9dg2fUOCAwhmRb3tYR/tqHtTiU+bduaXCgGuCVQ=;
        b=iIL3FfQv6KNqHsScaU9ZQM3soU+emV2ibFIgWwaD0VQ/+IEo+c2J4PLgTtVZJ/hZcG
         2l2j5H/+Mh06dK/AiXoFiXgCC9YMYrmdkPp05VwtRTtXS1PamdnInacA1vFcHZCHY41x
         4Rpk9tY2hRc499uvLA2L/sIQ3iEGLj9r9M1miXypPk0DFFG+igVnLUG/xQMqn/8MMt/U
         fo4zqFR2/B8q70MwkYqA6xKSiMNZK20vc5+PuYEe4+0+ES4ITxEby4g8pqEkL710sS0K
         A48/HRq3ykzt13rG/4afh/UEgB5iUU0hmihcD7NqCgLNP23l7I8aqfYyrlfg204GJd49
         FC6g==
X-Gm-Message-State: AJIora9P8TWZLBi2p+YGI7LR7ovNbVhw4imHcrwZHamWtnBDjjtH3Oxu
        Bf9MNEddGjvbSECsh2RkAPY=
X-Google-Smtp-Source: AGRyM1uBnZWlRfFdUjJ1bSSphxX4jqeWZTqtJdX2wjdedKPp6DU2LtWBORPm5srUmWrWmkayJ16E1w==
X-Received: by 2002:a63:61d3:0:b0:416:15eb:dc43 with SMTP id v202-20020a6361d3000000b0041615ebdc43mr4586346pgb.241.1657749790484;
        Wed, 13 Jul 2022 15:03:10 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id rv21-20020a17090b2c1500b001efb8804720sm25738pjb.46.2022.07.13.15.03.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 15:03:08 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 13 Jul 2022 15:03:06 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Luo Xueqin <luoxueqin66@gmail.com>
Cc:     wim@linux-watchdog.org, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org, Luo Xueqin <luoxueqin@kylinos.cn>
Subject: Re: [RESEND PATCH v2] watchdog:Fix typo in comment
Message-ID: <20220713220306.GA32544@roeck-us.net>
References: <20220705153138.29657-1-luoxueqin66@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220705153138.29657-1-luoxueqin66@gmail.com>
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

On Tue, Jul 05, 2022 at 11:31:38PM +0800, Luo Xueqin wrote:
> From: Luo Xueqin <luoxueqin@kylinos.cn>
> 
> Spelling mistake in comment.
> 
> Reported-by: k2ci <kernel-bot@kylinos.cn>
> Signed-off-by: Luo Xueqin <luoxueqin@kylinos.cn>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> 
> v2: add discoverers
> 
>  drivers/watchdog/pc87413_wdt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/pc87413_wdt.c b/drivers/watchdog/pc87413_wdt.c
> index 9f9a340427fc..c7f745caf203 100644
> --- a/drivers/watchdog/pc87413_wdt.c
> +++ b/drivers/watchdog/pc87413_wdt.c
> @@ -442,7 +442,7 @@ static long pc87413_ioctl(struct file *file, unsigned int cmd,
>  	}
>  }
>  
> -/* -- Notifier funtions -----------------------------------------*/
> +/* -- Notifier functions -----------------------------------------*/
>  
>  /**
>   *	pc87413_notify_sys:
> -- 
> 2.25.1
> 
