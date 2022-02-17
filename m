Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ABA14BA7FC
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 19:18:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244149AbiBQSSB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 13:18:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244143AbiBQSR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 13:17:59 -0500
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30706162018;
        Thu, 17 Feb 2022 10:17:45 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id v10so9912260qvk.7;
        Thu, 17 Feb 2022 10:17:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Kmo6BH5ygn5Md7FtjHkAF2H+na9yzAd1rgfQcTVl4JU=;
        b=Yiccb94OR/WsJxaffkc/ByvR29azGUTeOl1tDs/DdXjoKSWCwX7RLXKOScOr2rY166
         yFPl91/QlOwJt7+A/MzFE4G7sBJ11ug76nZdP9TGq6kblN8FS/JgNQ7n4migx6LgKc/u
         ybj/i6Bkw8REPlhhZQ2zTNt7kPB7VOPBl/IYY8PE/UsTFts+XJWJFP25A+E8ouyBUDR3
         W+qT59zNZjhFxAhmAx6x9RXCxYc63pH5fOdNK0WIgo3CUZSFfoMlLA+GpUUJoounRmmW
         Fg6420SyCNxzUbK81avDLGH27y+f7h61rCUg0BLXTvD7pEHHUUGozcezo0DPHVdekRlE
         VNTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Kmo6BH5ygn5Md7FtjHkAF2H+na9yzAd1rgfQcTVl4JU=;
        b=7quJGXjFYOepuYenKe+wKwbwvZIdNRyotg793q29oJ9ZajbKVtYeuk/ioQHdYeCBzo
         3ozQAe+5uNbJnDAdKUFH+SfpG1RJVG1mYpq/z9yNSDmVOZ94k7KulxFCsEKfSqioEkI9
         j4XkHi2Ci5KH+1BkOPFtgHcMTji1el2DGpnUE5vl7keh+kzUiQ61RydhEC2gw6JMgkKP
         xoxfWLj7Iz9X4c3mRbfsC1OpAE0d2UcyboRljOTdUwDCAXf22LoWbUfEDQHAJiRInOpA
         HrYXk220J+pXO6DGts85DHXvrVUSPdoMA8NDJ8hJJRGEpovgkNtatRWhralpzytkhMr/
         FhXA==
X-Gm-Message-State: AOAM533RLg3eODZL8niJMm7YnI2VyyH5HN9XZxATdMzy8Yf0z//XBG4k
        GOGDsRHqaECDgdPjqLwSQa1EPyMt+uzrmA==
X-Google-Smtp-Source: ABdhPJy+Gp9fjTaJUI638GLj65jPVwz8FpBZnZf25Y2Z3PTBA4jx+t2qwKhbrCOmT7qtrGpJHtibVw==
X-Received: by 2002:a05:622a:148d:b0:2cd:764a:f2c0 with SMTP id t13-20020a05622a148d00b002cd764af2c0mr3614805qtx.231.1645121864378;
        Thu, 17 Feb 2022 10:17:44 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s1sm23792811qta.0.2022.02.17.10.17.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Feb 2022 10:17:43 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <b59155c2-81c1-b2d8-c8d9-a97e3166cee3@roeck-us.net>
Date:   Thu, 17 Feb 2022 10:17:40 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [RFC V2 17/21] watchdog/dev: Add tracepoints
Content-Language: en-US
To:     Gabriele Paoloni <gpaoloni@redhat.com>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        "Peter.Enderborg@sony.com" <Peter.Enderborg@sony.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-trace-devel@vger.kernel.org" 
        <linux-trace-devel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
References: <cover.1644830251.git.bristot@kernel.org>
 <e67874c8b676ea8dfe38679efa25363889bb1e76.1644830251.git.bristot@kernel.org>
 <96f418b4-0ba8-01fe-ead0-2028bfc42560@sony.com>
 <ba924008-c0ab-4800-aac4-d9d9ae930c32@kernel.org>
 <ef1b1d99-6172-2b4d-9612-7ecbe8fc6c8b@roeck-us.net>
 <6c6fc4fa-6464-2dbf-40da-e3c61f322d95@redhat.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <6c6fc4fa-6464-2dbf-40da-e3c61f322d95@redhat.com>
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

On 2/17/22 09:49, Gabriele Paoloni wrote:
> 
> 
> On 17/02/2022 18:27, Guenter Roeck wrote:
>> On 2/17/22 08:27, Daniel Bristot de Oliveira wrote:
>>> Hi Peter
>>>
>>> On 2/16/22 17:01, Peter.Enderborg@sony.com wrote:
>>>> On 2/14/22 11:45, Daniel Bristot de Oliveira wrote:
>>>>> Add a set of tracepoints, enabling the observability of the watchdog
>>>>> device interactions with user-space.
>>>>>
>>>>> The events are:
>>>>>      watchdog:watchdog_open
>>>>>      watchdog:watchdog_close
>>>>>      watchdog:watchdog_start
>>>>>      watchdog:watchdog_stop
>>>>>      watchdog:watchdog_set_timeout
>>>>>      watchdog:watchdog_ping
>>>>>      watchdog:watchdog_nowayout
>>>>>      watchdog:watchdog_set_keep_alive
>>>>>      watchdog:watchdog_keep_alive
>>>>
>>>> Some watchdogs have a bark functionality, I think it should be event
>>>> for that too.
>>>>
>>>
>>> I understand. The problems is that I do not see the bark abstraction
>>> in the
>>> watchdog_dev layer.
>>>
>>
>> I don't even know what "bark functionality" means. A new term for
>> pretimeout ?
>> Something else ?
> 
>>From my understanding the bark timeout is actually the pretimeout
> whereas the bite timeout is the actual timeout.
> I think in the Kernel ftwdt010_wdt and qcom-wdt are bark/bite WTDs
> 

If that is the case, I would prefer if we could stick to existing
terminology to avoid issues like "I do not see the bark abstraction".

Thanks,
Guenter
