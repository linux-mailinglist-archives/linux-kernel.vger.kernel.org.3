Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73A314ACB5C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 22:31:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240693AbiBGVbt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 16:31:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230521AbiBGVbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 16:31:48 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8F93C06173B
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 13:31:47 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id d3so12254034ilr.10
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 13:31:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GR4yvSt4uQ+YFhNbD4fRaCObmP7kL/x3g2s6EkaKb2E=;
        b=SSy4G3WCV/9s4w/RXrOrMxQoCQGmDZ0pNskFdbfUIJ3hsbqGR0KaoM5ZGVoyJ22TrH
         ljbtBpk7HETNzk4/H0Z1eP5iPRujAVhmA5IbWkERnfjYyjLXmHrKndjdLFSbXrHbxfSa
         791oRBtIVlLEE2+/CgRJAAkG4KZlXyBEsitFs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GR4yvSt4uQ+YFhNbD4fRaCObmP7kL/x3g2s6EkaKb2E=;
        b=m4hVGGd6R2saAx7qwOg/ZhJseFhRy5dBlkYeU1BCZ0J2ZBvJNJ7TXJpcMKvTvZgBiX
         LJbxxkW7R0SVOwlcDnzY1x/VQYoy/y4h1jvxZ95wc7uIaUog4PRLZ9XkFjS2U4svkAs1
         NyogFQfjSRsFyi4SZ6t/38Wq5HKS1H4ZKHxAHj7P8UwRFf3nJDeI652bu8GVf8R5PIb+
         DKyq7sFbIeoExPx97iKguUweOhsf/0AkbgkvrjunhfhB2v36eQrRF3sCmMclX9YafOlL
         UfjKBaLUuznu4JP5mPKcx2ulOdYsie8xmgcKbUvoN0LRAEr1+hgO+O3zLDcvGa+THUrP
         40rg==
X-Gm-Message-State: AOAM533wTUu3rdAuvWMT6VYYuko7JUKHBAgU6gjJV0XC6qlj1BZtmb/8
        CRQBLASKUkCno+cPcgGDgI/nFg==
X-Google-Smtp-Source: ABdhPJwC34jQpOsfU+Uw9SdOgjKwsoFFNrIxvuFGF2xDqQXAiiA0oD6ysVJ9QpEGvaT4UciZENQang==
X-Received: by 2002:a05:6e02:1545:: with SMTP id j5mr713020ilu.318.1644269507088;
        Mon, 07 Feb 2022 13:31:47 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id g11sm6438631iom.45.2022.02.07.13.31.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Feb 2022 13:31:46 -0800 (PST)
Subject: Re: [PATCH] selftests: futex: set DEFAULT_INSTALL_HDR_PATH
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@collabora.com>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     kernel@collabora.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
References: <20220119103332.2887370-1-usama.anjum@collabora.com>
 <3a4878b9-f175-f16f-a901-efc33b2bf89f@linuxfoundation.org>
 <24d02704-e590-63d0-4d8a-c76578249bea@collabora.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <1464f5e1-d79b-b440-9a15-c0ed61599e1b@linuxfoundation.org>
Date:   Mon, 7 Feb 2022 14:31:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <24d02704-e590-63d0-4d8a-c76578249bea@collabora.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/7/22 1:50 PM, Muhammad Usama Anjum wrote:
> On 2/7/22 11:40 PM, Shuah Khan wrote:
>> On 1/19/22 3:33 AM, Muhammad Usama Anjum wrote:
>>> If only futex selftest is compiled, uapi header files are copied to the
>>> selftests/futex/functional directory. This copy isn't needed. Set the
>>> DEFAULT_INSTALL_HDR_PATH variable to 1 to use the default header install
>>> path only. This removes extra copy of header file.
>>>
>>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>>> ---
>>>    tools/testing/selftests/futex/functional/Makefile | 1 +
>>>    1 file changed, 1 insertion(+)
>>>
>>> diff --git a/tools/testing/selftests/futex/functional/Makefile
>>> b/tools/testing/selftests/futex/functional/Makefile
>>> index 5cc38de9d8ea..9a8c3700d773 100644
>>> --- a/tools/testing/selftests/futex/functional/Makefile
>>> +++ b/tools/testing/selftests/futex/functional/Makefile
>>> @@ -24,6 +24,7 @@ TEST_PROGS := run.sh
>>>      top_srcdir = ../../../../..
>>>    KSFT_KHDR_INSTALL := 1
>>> +DEFAULT_INSTALL_HDR_PATH := 1
>>>    include ../../lib.mk
>>>      $(TEST_GEN_FILES): $(HEADERS)
>>>
>>
>> This will be a good cleanup. However, please make there is no dependencies
>> in the futex test sub-dirs on being able to find the headers under futex
>>
> I've tried the following variations. The build is fine.
> 
> cd tools/testing/selftests/futex/functional
> make
> 
> cd tools/testing/selftests/futex/
> make
> 
> make -C tools/testing/selftests/
> 
>> I vaguely remember leaving this in place for reason.
>>
> This must have been fixed in previous changes made to the build system.
> 

Thanks for checking. I will apply this in for Linux 5.18-rc1

thanks,
-- Shuah
