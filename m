Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DF9655B5E2
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jun 2022 05:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231527AbiF0DkF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 23:40:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbiF0DkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 23:40:02 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA3065595;
        Sun, 26 Jun 2022 20:40:01 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id go6so8047615pjb.0;
        Sun, 26 Jun 2022 20:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Fg0vJKdecn60sXmjkQ4pSGp+mVjO/rLwQWCMpTOb7y8=;
        b=pKe2G8yYR/PxRbRglc8TqMkd60YKYwtdNgU/PNdeRZztoOUiPrP9Q1AUE7jFvq391A
         OTs74z3AJk5DR4dY/YAXK70h94SMGIG1tfrWmAHo7/hEi6sEED2DFIT0xPLLFcD9kwI1
         lIV01iVFIMjITq3qFbPq0NTZ/zeuViSWXDRq4ETEpXXLHwsl2v17L2Aavbx8UNDvakjs
         6b+pntKnLw3N+FbaQIkyqT1OKUDY2RD1aNV8IxD04ZO/fv13toOEoKql2Ip5c3B3uu9o
         yDk7TRAzHAmkcehE56X3VaeoBHQYoRUfa+cKDX1oxsQs7sbCA8fs8/5jmOkJ3USXHkbx
         1oPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Fg0vJKdecn60sXmjkQ4pSGp+mVjO/rLwQWCMpTOb7y8=;
        b=cJbTqkSHI3luHyQqKnfChkF4jh+ZC+CE63OwDVFUGXK7rOvkG813m6R1nZNfMZU59x
         9Xg45ldoNivcyoezV7UIJUogbkCED7B9UZiw0YZgkiGs1cJ0mzRcWPzqG8GFf84E1Eyp
         uuO3296TsStNX9vI1BT3bzsceIvrxKfUA93y2YQ2Qbb7ow70ua6KO57I595zQ7bfWodb
         LFvFmgVTsAAnFPKFG0gKY81EJcVTdPodSoUGtgqgnbU7qZBjW+NMmDjjHGThPz45Qe0t
         M4KwA3NWWc5Y3tjyosWzfgI+Ak9nxqTBZ12GkOKAPA3OqJADPMw7WJel+DmRHXZcRz01
         LAAw==
X-Gm-Message-State: AJIora9xRF5w+2UAnH1NfokhVX796SirTVXAHfFH6q9uACUPoyoTqeVF
        MQaJPxiHtA/n0UpfHvDpnEL1OprUDMPBcw==
X-Google-Smtp-Source: AGRyM1vBeJQVM5cNqovRTTxfhfnv/0cadF7CBPhPzMWMSB08lWzIYBEcOOvXRWut35GgRjIgE4Dp9Q==
X-Received: by 2002:a17:902:f54e:b0:16a:75a9:9a39 with SMTP id h14-20020a170902f54e00b0016a75a99a39mr12366137plf.70.1656301201314;
        Sun, 26 Jun 2022 20:40:01 -0700 (PDT)
Received: from ?IPV6:2401:4900:1c0f:ec3f:8053:b39e:a633:cf03? ([2401:4900:1c0f:ec3f:8053:b39e:a633:cf03])
        by smtp.gmail.com with ESMTPSA id q21-20020aa79835000000b0051844a64d3dsm5941313pfl.25.2022.06.26.20.39.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Jun 2022 20:40:00 -0700 (PDT)
Message-ID: <924eb8a2-a040-0632-872b-e1951c71c169@gmail.com>
Date:   Mon, 27 Jun 2022 09:09:52 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.1
Subject: Re: [PATCH] platform: x86: Remove duplicated include in
 barco-p50-gpio.c
Content-Language: en-GB
To:     Peter Korsgaard <peter@korsgaard.com>
Cc:     santoshkumar.yadav@barco.com, peter.korsgaard@barco.com,
        hdegoede@redhat.com, markgross@kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        saurav.girepunje@hotmail.com
References: <YriUMDJoip0Mknh3@Sauravs-MacBook-Air.local>
 <8735fr1bqh.fsf@dell.be.48ers.dk>
From:   Saurav Girepunje <saurav.girepunje@gmail.com>
In-Reply-To: <8735fr1bqh.fsf@dell.be.48ers.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 27/06/22 12:41 am, Peter Korsgaard wrote:
>>>>>> "Saurav" == Saurav Girepunje <saurav.girepunje@gmail.com> writes:
> 
>  > Remove the duplicate include of linux/io.h in barco-p50-gpio.c
>  > file.
> 
>  > Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
> 
> What tree is this against? The io.h include in the line just above
> delay.h was already removed by:
> 

I am using git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git .
if it fix on another tree . Please ignore this patch.

> commit 011881b80ebe773914b59905bce0f5e0ef93e7ba
> Author: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> Date:   Thu May 26 17:03:45 2022 +0800
> 
>     platform/x86: barco-p50-gpio: Add check for platform_driver_register
> 
>     As platform_driver_register() could fail, it should be better
>     to deal with the return value in order to maintain the code
>     consisitency.
> 
>     Fixes: 86af1d02d458 ("platform/x86: Support for EC-connected GPIOs for identify LED/button on Barco P50 board")
>     Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
>     Acked-by: Peter Korsgaard <peter.korsgaard@barco.com>
>     Link: https://lore.kernel.org/r/20220526090345.1444172-1-jiasheng@iscas.ac.cn
>     Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> 
>> ---
>  >  drivers/platform/x86/barco-p50-gpio.c | 1 -
>  >  1 file changed, 1 deletion(-)
> 
>  > diff --git a/drivers/platform/x86/barco-p50-gpio.c b/drivers/platform/x86/barco-p50-gpio.c
>  > index f5c72e33f9ae..bb8ed8e95225 100644
>  > --- a/drivers/platform/x86/barco-p50-gpio.c
>  > +++ b/drivers/platform/x86/barco-p50-gpio.c
>  > @@ -14,7 +14,6 @@
>  >  #include <linux/delay.h>
>  >  #include <linux/dmi.h>
>  >  #include <linux/err.h>
>  > -#include <linux/io.h>
>  >  #include <linux/kernel.h>
>  >  #include <linux/leds.h>
>  >  #include <linux/module.h>
>  > --
>  > 2.33.0
> 
> 


