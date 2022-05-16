Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B242528058
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 11:05:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235845AbiEPJEu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 05:04:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235673AbiEPJEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 05:04:38 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DE9922502
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 02:04:36 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id u3so19589615wrg.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 02:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Vtzqm9B8bIGVDc2Gs5s7ZVHW/0MNvC7Tzsb123QyUqo=;
        b=VGKh+vv793HBfYp2CuBJLdl5N7dKGA8ueo88ggzNYWvvDTQoCkjv6mNnf+XJnU2sGV
         +ukFJ69Qx9xGxlTcdbndwnHe38BHoWA+0lsA33NLH1FIVQ52dfqm7K7yR7/CJORr7R4O
         kWv9hH6IZE3Tg/EkXXFSFNP2zM9acahsDB4wTp2Bugtd6bYg8tQVReh6iXJPsNpg3Ffv
         9qb1DLMeQKBR7VApdXQPn0Tg+0IYdzYgpW7rA6eqoJ9cOUXFDTCP3w1JRw8TaGn/mDz8
         KBAfsX5lWOfjZZSm2ub5a2pDPf4oK54gB4I6QdiMy41SPwgSvkazNnYHBxCF/RTU4INS
         jWZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Vtzqm9B8bIGVDc2Gs5s7ZVHW/0MNvC7Tzsb123QyUqo=;
        b=uWEHpp0lS4cSFcmRmWvRri7kgpVUzAwOaeUSImzijgdOyZmorT2HDw+kycc8Zf3DN5
         dG4WDP1SQtJFQcRiQPy7Cpckf1SLdn9nt3BvH0PONRqqa5wl5bQHba0axVa3VU7V7OXa
         jAqUGVqb7Gwv7+9TZutgBSWDnBKx0wp4XPZl+wKSwPZoH/2csC/T6mUx7jav8g+ddZ1I
         EN3NcsnfWkQX43m0mPa2gcjs7WeWaAF9T2RdU+WcQ1WRY1MQh6cVx5cne2Iu2JCDTsL7
         Um5sVuZBl8XlQ4Ox5lKfTknbsGWRpOAuIezpFJuHq+uwbPutsx2MOrpSqsIoJh4yBBLA
         OgIA==
X-Gm-Message-State: AOAM531EsF5d04bywxrIuwuB97WhaIAbr7THP9Hboi2DFoWqc5oyB5mi
        +gR1PeipyidngIIRoeZi/jjC3g==
X-Google-Smtp-Source: ABdhPJwt5GZZN0Q4ywqJAvu6HESjz9V/AiGRTPf9cEMEqYWh8XOu6dgR4nvHpoKBrDMQwGJFVr96+A==
X-Received: by 2002:a5d:4312:0:b0:20c:af5f:bdcf with SMTP id h18-20020a5d4312000000b0020caf5fbdcfmr13528931wrq.498.1652691874862;
        Mon, 16 May 2022 02:04:34 -0700 (PDT)
Received: from [10.0.9.156] ([193.117.214.243])
        by smtp.googlemail.com with ESMTPSA id y11-20020adfc7cb000000b0020cf41017b4sm8260935wrg.19.2022.05.16.02.04.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 May 2022 02:04:34 -0700 (PDT)
Message-ID: <e5ce41c3-da97-e311-f57a-935a97633f0c@linaro.org>
Date:   Mon, 16 May 2022 11:04:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] clocksource/drivers/ixp4xx: Drop boardfile probe path
Content-Language: en-US
To:     Linus Walleij <linus.walleij@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org
References: <20220406205505.2332821-1-linus.walleij@linaro.org>
 <CACRpkdZ7oe+A_+9H7OWXNPvRXsVFUWjE++zWeXJtZcnWDUyDqA@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CACRpkdZ7oe+A_+9H7OWXNPvRXsVFUWjE++zWeXJtZcnWDUyDqA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/05/2022 08:54, Linus Walleij wrote:
> On Wed, Apr 6, 2022 at 10:57 PM Linus Walleij <linus.walleij@linaro.org> wrote:
> 
>> The boardfiles for IXP4xx have been deleted. Delete all the
>> quirks and code dealing with that boot path and rely solely on
>> device tree boot.
>>
>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> 
> Daniel/Thomas: can you pick up this patch for v5.19?

Yes

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
