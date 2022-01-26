Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 539C149D0AC
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 18:26:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243691AbiAZRZ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 12:25:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237164AbiAZRZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 12:25:56 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A8A8C061747
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 09:25:55 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id l35-20020a05600c1d2300b0034d477271c1so273097wms.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 09:25:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=f9guB0sh0Lurj0RNnTyzS57ErgkX/og0Be/WymIsHIU=;
        b=Vd6XBkJ2xBnOY4rllJwDqCtX4iFdHLeUoHVxdYK44CHjLa6/1qbYoPPlWQcYat9zVh
         cHxJt+bUdPn6g2G1beKoRj/Mt7MAhCCRQurRmi5l4LUXeaCdyrrNqmLXNL4XoIXCzjo5
         Y4lx3f68pUYiBnmVCOyg6qkRMDyO0549bVYFZv4AfH6244p8ouwS+2jXf8SzSKh9mnm+
         Kd2aJy6zWHAmt+wOvfU8CGyQvOuD+0wlyAhsH+k0VZ+RlXIbcAssfSm7U50dsCFkbBds
         y8XZnmlsCJcSSYPyRkTdHF+dZ3mlsZPEvF4jsOTx/UTz2azYg2bB93x8386UJEVs3YA/
         bv6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=f9guB0sh0Lurj0RNnTyzS57ErgkX/og0Be/WymIsHIU=;
        b=LqlxcPbyDiOBBDLQ3LcNHo/FzQe+NkzMK7iOaKhrZddCniv+JnUBUaNnf1+38OYgG0
         QCZ20FY8uzH+4rqtzIs76/oJCb1jFtsRljj2Hvja73TJvsO2FeFc0qGfyV9FLCnVGPc1
         2be9plPOZcBgIgbXcMDOedaCJ6WSP/sWx+vpZlYdWvMexLWFI2P8aEmlcFcTPPf4UjqP
         Wp6mn9fJPHnzjbhCdLjPRT6Jnfsibyt1ighgcXwDtEImAHfTuPpNN6XAfdVm24XgqExq
         pv/q1QiMHNIZkKXg8KtHslr3oLCeH3s2wPOT8fkPK+OOoDg7yzjVE8ixgjQMBau3GNIk
         UtIQ==
X-Gm-Message-State: AOAM531EvjZqQOmU+AsDG4fzT9wg+G17P18y/Ibmx7/oRnpm0jbHBz5m
        PmV1YzhJ6hRtB6xBiwnK5yX7AA==
X-Google-Smtp-Source: ABdhPJzSJ02J7ErW+HrQMpYIV6UUT670RliLEK4anwQ99Ei3XZgr3e8nTi4aWuWI4MpjshjqGnwCjA==
X-Received: by 2002:a05:600c:1e15:: with SMTP id ay21mr8352061wmb.111.1643217954348;
        Wed, 26 Jan 2022 09:25:54 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:e5b7:c642:b8ef:60cb? ([2a01:e34:ed2f:f020:e5b7:c642:b8ef:60cb])
        by smtp.googlemail.com with ESMTPSA id t17sm20458505wrs.10.2022.01.26.09.25.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jan 2022 09:25:49 -0800 (PST)
Subject: Re: [PATCH v12 4/5] clocksource/drivers: Add a goldfish-timer
 clocksource
To:     Laurent Vivier <laurent@vivier.eu>, linux-kernel@vger.kernel.org
Cc:     linux-rtc@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org, Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        John Stultz <john.stultz@linaro.org>
References: <20220121200738.2577697-1-laurent@vivier.eu>
 <20220121200738.2577697-5-laurent@vivier.eu>
 <2dc495b0-b9a1-e493-ddeb-d966afd624c0@linaro.org>
 <1bc0bf2d-49c6-3f68-bc35-919b2a1e4cfc@vivier.eu>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <f9119e2f-51e7-e87c-10d9-bc76d6108676@linaro.org>
Date:   Wed, 26 Jan 2022 18:25:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <1bc0bf2d-49c6-3f68-bc35-919b2a1e4cfc@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/01/2022 18:14, Laurent Vivier wrote:
> Le 26/01/2022 à 12:55, Daniel Lezcano a écrit :
>>
>> Hi Laurent,
>>
> 
> Hi Daniel,
> 
>> On 21/01/2022 21:07, Laurent Vivier wrote:
>>> Add a clocksource based on the goldfish-rtc device.
>>
>> As a first submission, please provide a more detailed description of the
>> timer.
> 
> ok.
> 
> The timer uses in fact the goldifsh RTC clock so I supposed refering to
> drivers/rtc/rtc-goldfish.c could give the missing pieces of information

[ ... ]

> I agree for irq, but res is passed to request_resource() and I think it
> is added to a linked tree, so I'm not sure it can be local to the function.
> 
> Do you mean a "static" declaration in the function?

I missed request_resource() was adding the resource in a list, thus the
parameter must not be freed. So discard the comment for 'res'.

[ ... ]



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
