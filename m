Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98C515A51A2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 18:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbiH2QZc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 12:25:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbiH2QZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 12:25:28 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AEB24D242;
        Mon, 29 Aug 2022 09:25:27 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id r69so8151976pgr.2;
        Mon, 29 Aug 2022 09:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc;
        bh=N7QVKkCoxmnLAtwrPlVqx/FgL+niCKLf5680NZMbdLA=;
        b=qrcT5w/1qiEJfEfGWDzW4K+tV91ZIy6hlVTKC3SG2TLJX0Flm0Kg07x7pLl1pugYSt
         rwlsmW4mMv7AYeFqNFFv0SwOS/3aMNQETQ0bbS6jZloErD0u/zDBAAAD7saFg4xBgQrS
         wQ/5oBpnhGn2CvH3R+fB7I9PC5VNiRVCxp4uYXZBV6JkQn7iCpByrFrgv6CokTvQsrgs
         FO7PTd2ZSZYeiIfaHcTyrk5q1Yvsxc6qKVrGEn+9R3AuA2O79X3zRQ8lVDhqVAsyibED
         21dGJDu3kvjTYSReDf5hC7rUF6qrJBGotQaz53Z7FVGpb++l1mdwDxuSXmu46h/w+YcU
         q7qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc;
        bh=N7QVKkCoxmnLAtwrPlVqx/FgL+niCKLf5680NZMbdLA=;
        b=NcxYcOOUCqZv1kfRsRmmJpgQYQNZth8jBBtQuEeOeNUtN2I8Eq1I4/oP/EGS5HYD6w
         19lndZc9I6tJF8dfrpJuFPr25YB1Zyy7qjefbweXduXyZYjpb1oS17Cj0lLX93JjqrMj
         HrNvUd4NDwvN+zlP68LtAkRi3/6OEA8mt/y9s+S5IwiFTg25fy5LnoO8sAe5iPU9IIqe
         4prIReAkNRDe7tXVnllha7xWvPrgLYYtU5Nxe9iRlsIeTZvind1bvG0Pp9bHbBCePqW2
         jh9GQ8rRWDpkbORGiS2zytzDE+9ZbAO0glTHNIj5Qcz8haODz9PDhf8jLG9HETcbxEV0
         H+5Q==
X-Gm-Message-State: ACgBeo0yuivSmOc+BcazU0HrXUk+4xUlWcAN/kN7C2xQKRzJkPrQBpHP
        jJGqzYsd87Mv/Rgms9gd+xxnsLzLvzCilA==
X-Google-Smtp-Source: AA6agR7zfby9gULboJrR9nPHz55kXyMMziuEa9ZvK5JD/u7hDHqvKElaE4pflbhAnf6lK1T9a08poA==
X-Received: by 2002:a05:6a00:2282:b0:536:72d0:d01 with SMTP id f2-20020a056a00228200b0053672d00d01mr17097465pfe.79.1661790326745;
        Mon, 29 Aug 2022 09:25:26 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k3-20020aa79d03000000b00537d4a3aec9sm6768579pfp.104.2022.08.29.09.25.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Aug 2022 09:25:25 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <6015717f-baea-7baf-e834-bb087f34819a@roeck-us.net>
Date:   Mon, 29 Aug 2022 09:25:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] hwmon: (nct6775) Add Asus PRIME Z390-A to WMI monitoring
 list
Content-Language: en-US
To:     Matti Kurkela <Matti.Kurkela@iki.fi>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <9f3cef03-6efd-138e-8552-e3078ed9b4f7@iki.fi>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <9f3cef03-6efd-138e-8552-e3078ed9b4f7@iki.fi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 8/28/22 07:43, Matti Kurkela wrote:
> Asus PRIME Z390-A (and presumably other Asus Z390 motherboard versions) also requires the nct6775 chip to be accessed by the WMI method. Add it to the asus_wmi_boards list.
> 
> Tested-by: Matti Kurkela <Matti.Kurkela@iki.fi>
> Signed-off-by: Matti Kurkela <Matti.Kurkela@iki.fi>

This is your patch. You should have tested it; that is implied in Signed-off-by:.
Tested-by: is not appropriate.

> ---
> Should apply to any kernel version that includes the commit c3963bc0a0cf9ecb205a9d4976eb92b6df2fa3fd
> (hwmon: (nct6775) Split core and platform driver).

This is irrelevant; it is a functional change and will be applied
to linux-next.
> 
> --- linux-5.19.4/drivers/hwmon/nct6775-platform.c.orig  2022-08-25 12:45:54.000000000 +0300
> +++ linux-5.19.4/drivers/hwmon/nct6775-platform.c       2022-08-28 16:28:09.531738685 +0300
> @@ -1054,6 +1054,7 @@ static const char * const asus_wmi_board
>          "PRIME H410M-R",
>          "PRIME X570-P",
>          "PRIME X570-PRO",
> +       "PRIME Z390-A",

checkpatch says:

WARNING: please, no spaces at the start of a line
#77: FILE: drivers/hwmon/nct6775-platform.c:1057:
+       "PRIME Z390-A",$


Please fix.

Thanks,
Guenter

>          "ROG CROSSHAIR VIII DARK HERO",
>          "ROG CROSSHAIR VIII FORMULA",
>          "ROG CROSSHAIR VIII HERO",
> 
> 

