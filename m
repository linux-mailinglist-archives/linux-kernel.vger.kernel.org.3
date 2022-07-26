Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C844358143D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 15:34:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238918AbiGZNeC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 09:34:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232851AbiGZNeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 09:34:00 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33D37F7D;
        Tue, 26 Jul 2022 06:34:00 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d10so13223319pfd.9;
        Tue, 26 Jul 2022 06:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=uuMXU1lDJffO172ozv7Pl9eKlYPygIsjkxztFlsUztI=;
        b=RqtjBGlez0CP5Avxh8zG7n+IzjsCbAqUT81bM0W60Cuooehm/vlgyo1RHuQsMSzLKD
         W2QGSN45AH50oWPTXUrByXJbbWGPjA2UhOeA5U7EEW6ITVd3Wik6U8yvZp+gIYTCRPs/
         RZNa/0LA5Yoku8MPD+O3eYFnl4Rn2LDXDJvv90c2t+Xy/iZ+tsIIU2qboHCuLU1zygmD
         pv9nOCzFX0E8oiIYjIqCR2CaSSLJ4FsO34sSZCbJNePkVmq/3Rz4o4kObheq5yxdRUSd
         mI7lvFmcTq+yJ9wluaYb0QZfHyB6/icGwpXNvsfGy7QcV4UMKf89gU5kNkCveuUyiVLy
         RtDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=uuMXU1lDJffO172ozv7Pl9eKlYPygIsjkxztFlsUztI=;
        b=7d5w/4iYfOw4VXUghm6DUblhuIdH5Paj8hPbnwt9FeHnWZv9tAH+P/wHSXmStbCpIs
         LZpxPazoORI7XhfgZGgRn14Qh1xmZAg8VVJccm4uTpewAizbeWE/07wAWAQwq80m4p04
         rAlDcx7qrkVlDc4l7pA3J4ezzcciF2R2bwebp8Kt1p1xSueOHNdIV0mPaJDHLKSZiCYw
         rT8M9abD+gX6Ez/Qfbw8gWiqTXgMU6uR13lrMw4Ku4GO4Ho8PGFtSDFeaK49Ddb83rrm
         5VSYcpOoikCrmIUDRn3tyMnZ9SmMXjuUTHznHHOxm+RTWYu8xRtcpcU12aFZGVkuiZ8+
         +bNA==
X-Gm-Message-State: AJIora/aut5j8DgLVU3ojrIkYlK6yEZtecHiJJJvx3aVJ4L2ncnqOvjl
        A4TifRRKD6krn16ryl6XLZ0=
X-Google-Smtp-Source: AGRyM1votdW7rOCBYduY30bsXrCsEIpsY6r67CdEzmFbjA6YWzEugNcB3XhCKlGYLSzWdobilCDcJw==
X-Received: by 2002:a05:6a00:228e:b0:52b:13d2:262b with SMTP id f14-20020a056a00228e00b0052b13d2262bmr17498749pfe.62.1658842439613;
        Tue, 26 Jul 2022 06:33:59 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z15-20020a1709027e8f00b0016d847a5f92sm3837514pla.82.2022.07.26.06.33.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Jul 2022 06:33:59 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <a3721fec-e035-39c9-ef30-7a9b71d9e02c@roeck-us.net>
Date:   Tue, 26 Jul 2022 06:33:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] watchdog: armada_37xx_wdt: Fix .set_timeout callback
Content-Language: en-US
To:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>,
        =?UTF-8?Q?Marek_Beh=c3=ban?= <kabel@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220726085612.10672-1-pali@kernel.org>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20220726085612.10672-1-pali@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/26/22 01:56, Pali Rohár wrote:
> ioctl(WDIOC_SETTIMEOUT) calls .set_timeout and .ping callbacks and it is
> expected that it changes current watchdog timeout.
> 
> armada_37xx_wdt's .ping callback just reping counter 0 and does not touch
> counter 1 used for timeout. So it is needed to set counter 1 to the new
> value in .set_timeout callback to ensure ioctl(WDIOC_SETTIMEOUT)
> functionality. Fix it.
> 
> Fixes: 54e3d9b518c8 ("watchdog: Add support for Armada 37xx CPU watchdog")
> Signed-off-by: Pali Rohár <pali@kernel.org>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/armada_37xx_wdt.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/watchdog/armada_37xx_wdt.c b/drivers/watchdog/armada_37xx_wdt.c
> index 1635f421ef2c..b84cba94b135 100644
> --- a/drivers/watchdog/armada_37xx_wdt.c
> +++ b/drivers/watchdog/armada_37xx_wdt.c
> @@ -179,6 +179,8 @@ static int armada_37xx_wdt_set_timeout(struct watchdog_device *wdt,
>   	dev->timeout = (u64)dev->clk_rate * timeout;
>   	do_div(dev->timeout, CNTR_CTRL_PRESCALE_MIN);
>   
> +	set_counter_value(dev, CNTR_ID_WDOG, dev->timeout);
> +
>   	return 0;
>   }
>   

