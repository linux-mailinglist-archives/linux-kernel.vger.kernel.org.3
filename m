Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62D024A5E63
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 15:36:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239384AbiBAOgK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 09:36:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:38724 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239320AbiBAOgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 09:36:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643726169;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c1qqBdKQoPCwA2ePd7jBkicuBscZF3IvkLQTjtTxA/c=;
        b=a7eUnWPrmga2Ef1jvyEh5tApsmsNQau8UJgN5MSkVmy1zwkTBbrBQVQvPWbL8xdY75qW1O
        VdJha6Ou0d7DIpw6JJMp/Ug627tJJPqxDM8e1gach61p//QccvK3JMTVXkLzbUg49pbvCR
        7EgVn5nb2LNVH87+dhEMaNwYn++iaIg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-463-MVfuuQoRPzaP8B0Aqrfy6w-1; Tue, 01 Feb 2022 09:36:08 -0500
X-MC-Unique: MVfuuQoRPzaP8B0Aqrfy6w-1
Received: by mail-wm1-f71.google.com with SMTP id w5-20020a1cf605000000b00354d2d83490so106907wmc.4
        for <linux-kernel@vger.kernel.org>; Tue, 01 Feb 2022 06:36:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=c1qqBdKQoPCwA2ePd7jBkicuBscZF3IvkLQTjtTxA/c=;
        b=sLzIqMUC3JhQ3ZhbuuB4c3FXQTUAg4KYpDTk5uUhlu3g+vNwLS0M1hXq/FDupCWRcU
         NfcEh21OALuJQw6kfmrevZd4mfhJsEF+Qj93RYGiZVfc/ejre3cqEIlmadnXC6oHcsFx
         vEluaXKedUDi9wNxIzFswOihrSgpdnj9lrsYlfnk22EqE9u8xwXYRSIa16pzchj+JjeY
         r4BkVXhCkk2i2HQufKrCWDZor7mIvFstJVSSuUBborPPPLNgJRroJC1qCX0+JeInNoni
         0hEyzZHwvfKYvVplotViEJATaIv1T0tRdgNJbCg/rFPkB9Jn7HeKTv2dJbr6ZXKbqe3G
         b70g==
X-Gm-Message-State: AOAM532QDYOew/xcb9cg3zbkbN5uT+6jYYV7/zw8z3or2zPR2yVk6E/N
        lLU5I1wGCzGWnE1247LaSRz24i6WDSJ2WgK+Kagk5strruMQjMRFOhM5TSM+pCTOguGDmWBC76O
        vwk5YvfkVNv09REtRpYIZiKcn
X-Received: by 2002:a7b:c003:: with SMTP id c3mr2022318wmb.80.1643726166848;
        Tue, 01 Feb 2022 06:36:06 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyWEsVQ1UNLWnla5O+uQQySFc68PN6z96VL15rWk5+1TFXROa0fVwYLO5ACOVmJk7fJj5i8fA==
X-Received: by 2002:a7b:c003:: with SMTP id c3mr2022299wmb.80.1643726166675;
        Tue, 01 Feb 2022 06:36:06 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id h18sm17864523wro.9.2022.02.01.06.36.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Feb 2022 06:36:06 -0800 (PST)
Message-ID: <3df2add7-6034-0527-825a-74e62e76dace@redhat.com>
Date:   Tue, 1 Feb 2022 15:36:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 3/4] drm/tiny: Add driver for Solomon SSD1307 OLED
 displays
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <20220131202916.2374502-1-javierm@redhat.com>
 <cc093cd5-fba1-5d84-5894-81a6e1d039ff@suse.de>
 <73dbc5c7-b9e2-a260-49a6-0b96f342391e@redhat.com>
 <CAMuHMdUJpoG=XChpqNotfEDrWCxFUqyhjW2JW1ckAyKcWXvAUw@mail.gmail.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <CAMuHMdUJpoG=XChpqNotfEDrWCxFUqyhjW2JW1ckAyKcWXvAUw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/1/22 15:05, Geert Uytterhoeven wrote:
> Hi Javier,
> 
> On Tue, Feb 1, 2022 at 2:02 PM Javier Martinez Canillas
> <javierm@redhat.com> wrote:
>> On 2/1/22 10:33, Thomas Zimmermann wrote:
>>>> +{
>>>> +    u8 col_end = col_start + cols - 1;
>>>> +    int ret;
>>>> +
>>>> +    if (col_start == ssd1307->col_start && col_end == ssd1307->col_end)
>>>> +            return 0;
>>>> +
>>>> +    ret = ssd1307_write_cmd(ssd1307->client, SSD1307_SET_COL_RANGE);
>>>> +    if (ret < 0)
>>>> +            return ret;
>>>> +
>>>> +    ret = ssd1307_write_cmd(ssd1307->client, col_start);
>>>> +    if (ret < 0)
>>>> +            return ret;
>>>> +
>>>> +    ret = ssd1307_write_cmd(ssd1307->client, col_end);
>>>> +    if (ret < 0)
>>>> +            return ret;
>>>
>>> Can you write these cmds in one step, such as setting up an array and
>>> sending it with ssd1307_write_array?
>>
>> I don't think so because the commands are different. But I'll check the
>> ssd1306 datasheet again to confirma that's the case.
> 
> IIRC, I tried that while working on the optimizations for ssd1307fb,
> and it didn't work.
>

That's what I would had expected by reading the datasheet. Thanks a
lot for confirming my assumption.
 

Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat

