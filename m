Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 601E7461FAA
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 19:53:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235786AbhK2S5C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 13:57:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379777AbhK2Syz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 13:54:55 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E1A8C0613B4;
        Mon, 29 Nov 2021 07:14:00 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id v15-20020a9d604f000000b0056cdb373b82so25927454otj.7;
        Mon, 29 Nov 2021 07:14:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0LDYpaC1o8xhrXzJKdF3sDv2C843tw6YvVGF0VGCbZM=;
        b=bcF85LpNFw0MsgEHtmp/Y6p8zwZjTr8H7G6F5FEDhT4dTaXWscORwZypSBmpvDZaL1
         Bps/23UNJROqP23ubTP4XcFgEJzRWQ2fzGHuVvTdMBTA5iKtDlmGUy67b9Wp3p3dDAhy
         Rc6qR2iQUtsnzS3mAeCFejz0RvRomqMeqpBVUxVwec2dr01mtypw1OwXP79F++VH9Jwv
         SaOBM3XjFPlIzxbc398+LIoeZvYIAKdVTN0bWPFUX64tt3ARjAlb0eyw07T01wJOsVz+
         tP5O4N5R845Celuv6v4mny3i4/kiPbM+kroKb4QlMR/QY8RQw6eaafz3sw5AKSIUeaaK
         yi6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0LDYpaC1o8xhrXzJKdF3sDv2C843tw6YvVGF0VGCbZM=;
        b=NhJQIIsuwXc+IhwgzeHfVDJPvd76WT2my8K4x+bOMUtlKKwE+Fgk7tcdlpST/d+Let
         yu2jNRxqWtxUZVfr/xz7fXlrDgHglMNEvxbmUc5bN8AIt6+tRpVCYJD5UQGXUIzm8x4Q
         Hu3mksugkJAlbtLjFkTW9lku2Q172VwTkdUesu1dmEkMBOd5hG/4h0XkyuMpNmjGicIN
         PSYGZJa0ybOOP1eWuzAuJZvCWotFz2E7PUR0DuuuoNM1jgOOe09BYaAC42Bcfp9ZeSUE
         Z1VJJbK4JDcYxYyO0B3XK/FCfANSXCLBR/cuaiHLtLL6JRSEOtVIg3fALRA0ok10Ytjn
         PCvg==
X-Gm-Message-State: AOAM533Dhq6QT91dfbAR9T3dl9D2SRHrw4RHB+PZ4/MMGPIWOn1wp1Rn
        r94QM8I0QtaiUtp7R8jjAlCXbuNlJfs=
X-Google-Smtp-Source: ABdhPJxsDSEMIOjXkRRil9aOGp+LsVtS97a3s1w4ZtAwhn9GDG4WispsZRiqeUQj2osS9nu3NxJo3g==
X-Received: by 2002:a05:6830:1092:: with SMTP id y18mr43935908oto.119.1638198839353;
        Mon, 29 Nov 2021 07:13:59 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t18sm2679510ott.2.2021.11.29.07.13.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Nov 2021 07:13:58 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH] watchdog: da9063: Add hard dependency on I2C
To:     Andrej Picej <andrej.picej@norik.com>, wim@linux-watchdog.org,
        linux-watchdog@vger.kernel.org
Cc:     y.bas@phytec.de, linux-kernel@vger.kernel.org
References: <20211129134938.3273289-1-andrej.picej@norik.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <bf64b71b-41c1-7a44-9583-c29887bea70b@roeck-us.net>
Date:   Mon, 29 Nov 2021 07:13:56 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211129134938.3273289-1-andrej.picej@norik.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/29/21 5:49 AM, Andrej Picej wrote:
> Commit 5ea29919c294 ("watchdog: da9063: use atomic safe i2c transfer in
> reset handler") implements atomic save i2c transfer which uses i2c
> functions directly. Add I2C hard dependency which overrides COMPILE_TEST.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Fixes: 5ea29919c294 ("watchdog: da9063: use atomic safe i2c transfer in reset handler")
> Signed-off-by: Andrej Picej <andrej.picej@norik.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 9d222ba17ec6..3207085f799f 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -207,6 +207,7 @@ config DA9055_WATCHDOG
>   config DA9063_WATCHDOG
>   	tristate "Dialog DA9063 Watchdog"
>   	depends on MFD_DA9063 || COMPILE_TEST
> +	depends on I2C
>   	select WATCHDOG_CORE
>   	help
>   	  Support for the watchdog in the DA9063 PMIC.
> 

