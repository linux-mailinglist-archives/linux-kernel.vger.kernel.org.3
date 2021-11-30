Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C385463B9F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 17:21:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243679AbhK3QYn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 11:24:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243034AbhK3QYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 11:24:39 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15F70C061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 08:21:20 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id be32so42216620oib.11
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 08:21:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KRBxZpidTkO2QxopshQT/A40mDseNm0ZVbQJ6N2Yh3A=;
        b=ZBxLlB0F309xy+jBUyF4Rw8n+ilMsxWltcs4sU9sIUV2cjGlbKe/AY38ScPqdkPFF1
         Ss5a+y2yYQNL+362Fw7o70CN4WuLkhW5xIqNfTr5TuHgOYjpWp8QmbvMnJnCvHMdaT9X
         zLIa5GbRyCt/QXJA5agYzjDoHfRYE4pHUXZxc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KRBxZpidTkO2QxopshQT/A40mDseNm0ZVbQJ6N2Yh3A=;
        b=CDn3JL5AAtFLdjZkrJt+DixVCnHkocCpfY/bF//fGU4zar8523lpSIFRI4YO7XC2OI
         hvR++JPqUhaI5f2I5eDtQGeNNPOAkFZxsVhBD+WwvRddsWtBInfKAb+ZcyGzcLkHiLzt
         zkUI6vTaiOIb/NHDQ2AswWVHIQkj2wa03COvs1OW/bn2KVNLWe9AARpziqrYUwtMR0AV
         pDp+s8D/jAYTqx5VhRuhvHHqCujFi2gf1O116AAJUlY32aEb7TUrlf10B+CvA8FvMMwB
         lHr7qO1ntqj5+3ifrTDca1Ki4Yb5RubsdxJ4uV2kMsUVAMv2Ru9c+Z1hjSFrlHP5Dfty
         2mYw==
X-Gm-Message-State: AOAM530XtyqzFvJxRz/mATMMTISAOI/lySmHuD7FNsrD1vDlKf+9TCVg
        SmMQjFKdRNi1/1+KX/80sd4DaRfLV47Mow==
X-Google-Smtp-Source: ABdhPJxM+LpAlzV2ojwlpiF1PEnx14fOvj6LBUjk+kewnHavN6SbB6by5PCBrNzpy8bRX+BEAo4vKw==
X-Received: by 2002:a05:6808:643:: with SMTP id z3mr57791oih.110.1638289268920;
        Tue, 30 Nov 2021 08:21:08 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id v10sm2880397oor.33.2021.11.30.08.21.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Nov 2021 08:21:08 -0800 (PST)
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
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <0fc3e982-456f-628d-17a3-f9c631108f6f@linuxfoundation.org>
Date:   Tue, 30 Nov 2021 09:21:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20211130110102.7ee120f2@gandalf.local.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/30/21 9:01 AM, Steven Rostedt wrote:
> On Tue, 30 Nov 2021 23:11:30 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
>> On Tue, 30 Nov 2021 13:25:46 +0100
>> Heiko Carstens <hca@linux.ibm.com> wrote:
>>
>>> Commit 32f6e5da83c7 ("selftests/ftrace: Add kprobe profile testcase")
>>> added a new kprobes testcase, but has a description which does not
>>> describe what the test case is doing and is duplicating the desription

Typo - I can fix it when I apply. checkpatch.pl does it for you btw.

>>> of another test case.
>>> Therefore change the test case description, so it is unique and then
>>> allows easily to tell which test case actually passed or failed.
>>
>> Good catch!
>>
>> This looks good to me.
>>
>> Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
>>
> 
> Shuah,
> 
> Care to take this through your tree?
> 

Yes. I can queue this up.

thanks,
-- Shuah
