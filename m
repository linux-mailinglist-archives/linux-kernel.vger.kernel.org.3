Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF76B520810
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 00:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232082AbiEIXA0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 19:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232070AbiEIW77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 18:59:59 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B828D238852;
        Mon,  9 May 2022 15:55:58 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id z15-20020a9d65cf000000b00605f064482cso11114772oth.6;
        Mon, 09 May 2022 15:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:content-language:to
         :cc:references:from:subject:in-reply-to:content-transfer-encoding;
        bh=WPEqwpSkDhH17QgMuD3O8fQNAiG+FXjmq1yi2Qup3Eg=;
        b=BpdxNyLK1nxpO+t9BXCOt1evEZHcelr80/RAFtEcTY2J2t3otnYFRhZcHd+lv+T8y/
         /CU495fkncbkXJFeFGPH+m9JxMvyUhbZtCxwLlpbOx/Q9KNOfT3L1BfrLPs7O4ERoa2x
         pqXWtxw0Xvzb5hcyOhWvMMD5w6gpWeJhabjInirjFEPOh5Fnz9rwPz6KlNGfjcEYCkUX
         hGsd3HAmJyZk0LiNv+i8UWL6sNQ5Zib8tnteCR/q1B/+b6fAdmcoqDOnBf6Eb5wfF2n5
         Dfp9epBdmv3JVrxiY18JXYv95LYXMrd3XWy45b1XHB6WWgnL1in6OxcHsvxCJSS1O6Mk
         JQUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=WPEqwpSkDhH17QgMuD3O8fQNAiG+FXjmq1yi2Qup3Eg=;
        b=ReYQiPupNLqwbeXfmjhENlBPH4ERlM8QxCldMJyRhVsnx5u2mecmkPN08AvacJDAD6
         0Jn0NLgdFzoy7IelNF8haA+GyqAEFs+/cPWNsXe2hdD2FKY73+dk9rBp1WtwQcZplP9k
         +Ui1VzttOHASwsyxMSJUyemNb9TVJ3bVsS/j44/2OMF9pUJpV+GimeiKxMsyy/857lM2
         4JKxMKJrqAFNJN/mYnMXt+6Ghr200OAflxrSavLnJhaS3Q2I6JJMlUALpNd1UiU91IsX
         8WP1FMH3iJV6aQv8Z1AbB97UnFSSlPJ8Chm+8pc2eEBwRuRxRPsc0k+O5zJsqheARSEo
         MMrQ==
X-Gm-Message-State: AOAM530UmJMWPZlcKCinDey5f8RaBJa/SXDnRT9GqhPcuB81/JogIq/Z
        /NjhUYKlrNn50aukqQIONlM=
X-Google-Smtp-Source: ABdhPJyUUxShSfi177wqgEYgqdqpxgK76tQmYQAmJrC89+pZUaoW0qGaSj+eCXEPq492PM2sakkkEw==
X-Received: by 2002:a9d:480e:0:b0:606:59b:2b2 with SMTP id c14-20020a9d480e000000b00606059b02b2mr6763556otf.277.1652136957988;
        Mon, 09 May 2022 15:55:57 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p20-20020a056830319400b006060322124csm5210182ots.28.2022.05.09.15.55.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 May 2022 15:55:57 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <b394bfcf-9f0d-b27c-5bc0-3d628de98755@roeck-us.net>
Date:   Mon, 9 May 2022 15:55:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Content-Language: en-US
To:     Mario Limonciello <mario.limonciello@amd.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        "open list:WATCHDOG DEVICE DRIVERS" <linux-watchdog@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Cc:     ionut_n2001@yahoo.com
References: <20220509163304.86-1-mario.limonciello@amd.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] Watchdog: sp5100_tco: Lower verbosity of disabled
 watchdog hardware
In-Reply-To: <20220509163304.86-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/9/22 09:33, Mario Limonciello wrote:
> If watchdog hardware has been disabled, currently the kernel driver
> will show at err level during probe:
> 
> "Watchdog hardware is disabled"
> 
> This is unnecessarily verbose as there is already a -ENODEV returned.
> Lower the level to debug.

Is it ? Without this message, a user may try to load the driver,
get an error message, and have no idea why the driver was not
enabled even though the hardware exists. If anything , -ENODEV
is less than perfect. Unfortunately there does not seem to be
a better error code, or at least I don't see one.

Guenter

> 
> Reported-by: ionut_n2001@yahoo.com
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=215762
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   drivers/watchdog/sp5100_tco.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/sp5100_tco.c b/drivers/watchdog/sp5100_tco.c
> index 86ffb58fbc85..e51ecbd5c8b7 100644
> --- a/drivers/watchdog/sp5100_tco.c
> +++ b/drivers/watchdog/sp5100_tco.c
> @@ -286,7 +286,7 @@ static int sp5100_tco_timer_init(struct sp5100_tco *tco)
>   
>   	val = readl(SP5100_WDT_CONTROL(tco->tcobase));
>   	if (val & SP5100_WDT_DISABLED) {
> -		dev_err(dev, "Watchdog hardware is disabled\n");
> +		dev_dbg(dev, "Watchdog hardware is disabled\n");
>   		return -ENODEV;
>   	}
>   
