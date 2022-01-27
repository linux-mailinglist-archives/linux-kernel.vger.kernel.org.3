Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDE4749EE47
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 23:52:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234377AbiA0Wwk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 17:52:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbiA0Wwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 17:52:39 -0500
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0A46C06173B
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 14:52:38 -0800 (PST)
Received: by mail-il1-x12f.google.com with SMTP id 15so3849993ilg.8
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 14:52:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=s4m0SuB5V0XSaTQ7c/s3zbcks9iRovaFLAZKKzHJ6sA=;
        b=PvzFJ1kh7JMWTPx40W7TtP9h89jsbeJHVz3JjOkCI8WC/xdjDeZpd5OSFCtYRA2T5b
         fp/lrIwwGzYFl9xWj5HtUCN0Db9Aclio5MA0bPk68P8LFqSpZL3D8+pIRgPED1CvrYkj
         PaueJkVBaHxQ3rbH2a8xNvbu0F8C1JzbObGrU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=s4m0SuB5V0XSaTQ7c/s3zbcks9iRovaFLAZKKzHJ6sA=;
        b=hh+TzZN1e1aCyP73B7Yg53fggJ79PzLL535Sj8DYl3HlDqne7Sj1zT5Mo6lCHtyAco
         uShPicSMdpb4vI88Mjykgq7GD52WNnbEQomMfg3vfozMiuMBufroiZJIO7taF/xTgPm/
         E8f4sOaYY807j8ZwtVNmzEJG3QDZGDywE9FcQ/cCP2u4sgz+4e4UwWnh5mByKOHPMWEM
         xQfiRYSn2N6WFyRawQPmENW5IZAR0C4boZ7nCtfUqm0aGYqkCJBQqB8+3/wpnCqPy214
         +YmeGBYMvRsK9qi3JfzMYqBRx9a7nNmAQ/U+FSExsEM7RNcWM116TJrzjW9ZR4bw7Vpc
         a3sw==
X-Gm-Message-State: AOAM5333S8LsscJ9ovl/hLwjDFqFL48P8h9SH0444Eo/n+4bqKvnB3uc
        IuXPENQxg7RD2wSaMX4fvd/5LQ==
X-Google-Smtp-Source: ABdhPJwTEO2adHqgnDAv0UCrrD/gmOsue8B+UNLBfkQjtNM4/AFGK/mQ0ET4LOGwVDJrRnz958OeKw==
X-Received: by 2002:a92:d84f:: with SMTP id h15mr4204137ilq.96.1643323958193;
        Thu, 27 Jan 2022 14:52:38 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id n23sm7022315ioo.55.2022.01.27.14.52.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jan 2022 14:52:37 -0800 (PST)
Subject: Re: [PATCH] selftests: futex: Use variable MAKE instead of make
To:     =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@collabora.com>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     kernel@collabora.com, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Darren Hart <dvhart@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Bamvor Jian Zhang <bamvor.zhangjian@linaro.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220127174447.754605-1-usama.anjum@collabora.com>
 <65054310-e925-4072-7df2-e1550d8a9a4f@collabora.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <b5b90951-f528-cd47-e6a1-e38c0de58070@linuxfoundation.org>
Date:   Thu, 27 Jan 2022 15:52:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <65054310-e925-4072-7df2-e1550d8a9a4f@collabora.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/27/22 11:09 AM, André Almeida wrote:
> Hi Usama,
> 
> Às 14:44 de 27/01/22, Muhammad Usama Anjum escreveu:
>> Recursive make commands should always use the variable MAKE, not the
>> explicit command name ‘make’. This has benefits and removes the
>> following warning when multiple jobs are used for the build:
>>
>> make[2]: warning: jobserver unavailable: using -j1.  Add '+' to parent make rule.
>>
>> Fixes: a8ba798bc8ec ("selftests: enable O and KBUILD_OUTPUT")
>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> 
> Thanks for the patch!
> 
> Reviewed-by: André Almeida <andrealmeid@collabora.com>
> 

Thank you for the patch. Applied to linux-kselftest fixes for rc3

thanks,
-- Shuah
