Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6AC8463BF8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 17:39:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244063AbhK3Qmp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 11:42:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbhK3Qmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 11:42:44 -0500
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 192E2C061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 08:39:25 -0800 (PST)
Received: by mail-il1-x136.google.com with SMTP id j7so21872191ilk.13
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 08:39:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rVbzJZAER7QfTyzK1T5QAFXDNOIsJOe26LVGoyaw3RQ=;
        b=ebcHhHwSixp9Uz89h8cWyk5y5LS0t4KnC/zPzheZEGdEbbYmFHikmBnQxRJt+BcNSJ
         fxRSm2Ixt8Xk9Ome2CzBdK8nJEo5nvmYxAm/fCTO0Pt2HMQkXcyZgEj2OH/z6dD51Gt9
         AP6BjqiQTBB/zN6Vh6JWn9JEjcSuhCYVKw+Wo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rVbzJZAER7QfTyzK1T5QAFXDNOIsJOe26LVGoyaw3RQ=;
        b=i0obmIrbc2JyKafI4SNXmqfq18ZdqdfEnoAAIfZkr933g5qdFqPRCPw8SyqB8ieix4
         +cq0EH0yMiNPmzvX92rlCdFkwKWHJGYuj+ro8LKN3yPvHOF2S6I96a9oWbDfmpHZGcoj
         04cNM3NpYmAMCjAEvBUQpD/OSY7p5LPO4l1JA4t/rZpL/japKhCplBVZNJC2bsKvHO/T
         U2tHaTYSfCJakUO+ixcqwIxXhwV7ocr2lzYi+iYoRZIMCz0PBnp8XTw+cVB1MWvriV9n
         tKsOAuPlSQ5gGYizJ1HZ5jKiKyGPhbinf0XACSyXGnViKHG/+27eIXAUcDw4LvCQiwwm
         FvgQ==
X-Gm-Message-State: AOAM5311tWgHr08UQ0YafawnjSnToMbkI1SFS3tinvjni8TIje6mwbqo
        FXIRwg6iaZFgh3P+iv9FTcfirE/whYelQg==
X-Google-Smtp-Source: ABdhPJxZIE+zYgCmbGksVmvDgeFPlTn5W6lb1q5M1upidhvoMPJ7oUCQ84c9FD6RoBqVT3Izy+Es8A==
X-Received: by 2002:a05:6e02:1d1b:: with SMTP id i27mr138058ila.248.1638290364494;
        Tue, 30 Nov 2021 08:39:24 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id c19sm10935012ioa.30.2021.11.30.08.39.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Nov 2021 08:39:24 -0800 (PST)
Subject: Re: [PATCH] selftests/ftrace: make kprobe profile testcase
 description unique
To:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Egorenkov <egorenar@linux.ibm.com>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20211130122546.3622291-1-hca@linux.ibm.com>
 <20211130231130.41f9bfcc35ceda68471bbb0b@kernel.org>
 <20211130110102.7ee120f2@gandalf.local.home>
 <0fc3e982-456f-628d-17a3-f9c631108f6f@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <33704769-6819-0db8-b005-c68d7b747aea@linuxfoundation.org>
Date:   Tue, 30 Nov 2021 09:39:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <0fc3e982-456f-628d-17a3-f9c631108f6f@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/30/21 9:21 AM, Shuah Khan wrote:
> On 11/30/21 9:01 AM, Steven Rostedt wrote:
>> On Tue, 30 Nov 2021 23:11:30 +0900
>> Masami Hiramatsu <mhiramat@kernel.org> wrote:
>>
>>> On Tue, 30 Nov 2021 13:25:46 +0100
>>> Heiko Carstens <hca@linux.ibm.com> wrote:
>>>
>>>> Commit 32f6e5da83c7 ("selftests/ftrace: Add kprobe profile testcase")
>>>> added a new kprobes testcase, but has a description which does not
>>>> describe what the test case is doing and is duplicating the desription
> 
> Typo - I can fix it when I apply. checkpatch.pl does it for you btw.
> 
>>>> of another test case.
>>>> Therefore change the test case description, so it is unique and then
>>>> allows easily to tell which test case actually passed or failed.
>>>
>>> Good catch!
>>>
>>> This looks good to me.
>>>
>>> Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
>>>
>>
>> Shuah,
>>
>> Care to take this through your tree?
>>
> 
> Yes. I can queue this up.
> 

Heiko,

Applied now to linux-kselftest next. Run get_maintainers.pl and include
linux-kselftest on your future patches.

thanks,
-- Shuah
