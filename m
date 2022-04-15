Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEC065030AF
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 01:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356133AbiDOVrQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 17:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356139AbiDOVq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 17:46:59 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1359E12091
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 14:44:30 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id s14so8002495plk.8
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 14:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=Gk+7fgGBPOWKPaXdAN9G57GRLaAX6Nk2DK6Zn7gSK5k=;
        b=tIGkFJJuPZDSGI4it8k7JxuUjCNwZAbl/3s9Hgz3l1DMc0D59fzyeNgGgyKdivVctr
         M9Hjj+77f01PG5h6DIsywnwVXxQWkjtn0PkLMozT/xR0PZMkdLzFoBMN9TnmMvzVyD4O
         qBWsk+oYXwhaG7/asWuHpGUBwjrBNNKZoWT+Msxzs7slq8829FUh4FCXZDTG4yx1SZSI
         6SFhM4pY3ynCQBIwGLR5KSvinvTtvbPKptteJQcYFCX6aITkybSGgOQfAnRuRs5LNVde
         /e1Gr7+0c5echJqyynG9oifs646cTpxqAXreGSFDVcjwiYdxFrb49wGUjR1OHp4bFY1U
         F6Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=Gk+7fgGBPOWKPaXdAN9G57GRLaAX6Nk2DK6Zn7gSK5k=;
        b=KWnu1rrX8kS+u1WJdKnfyJrbvjzy8dR2xKparG2/YhgPAPB4zcLl9+215OgHb5pUr2
         UYNI7l+eSY0DZkAoCS/8VEr1Fw8CDHKKW989YLG7NY3e0T4XfM/jH/Oc87TB/mK+L/ri
         bjDPv6ru8mOQN8wgwzoBIr9pyUNJqA0LWoO/OL6Icmq9xEMt7zO536XnJTYnzL4mpHvb
         p7XY6TplifXATR8R51CoYpRPD583N7ZL7+EquPpRHRrtzDHGXBfUpRvhHaeArjjtsuhv
         gngcmP8OuI4AJ9WykcMxTL0Nrxm+FuwDSzU6nPFxrCN1lFCvqVBRVoZsKIfxVW9FFMpL
         Ke1g==
X-Gm-Message-State: AOAM533P4qNsV7Yrs3V5cUtIJk3bum+bpDJf8AUTX2sZUT1OLhP2xeOV
        0Q198N+QSWdMqFnDr+swBP9eiA==
X-Google-Smtp-Source: ABdhPJyWM5pz48kb/gf6V0OQcpljp6SwfU3pPBli48/v5anhU19PFACJaNco1IfCGjtuixSSvMEtKg==
X-Received: by 2002:a17:90a:6c64:b0:1cb:93b2:b6a9 with SMTP id x91-20020a17090a6c6400b001cb93b2b6a9mr6322512pjj.144.1650059069323;
        Fri, 15 Apr 2022 14:44:29 -0700 (PDT)
Received: from ?IPV6:2620:15c:2d:3:51d5:33b1:431b:be0? ([2620:15c:2d:3:51d5:33b1:431b:be0])
        by smtp.gmail.com with ESMTPSA id d8-20020a056a00198800b004fab740dbe6sm4003287pfl.15.2022.04.15.14.44.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Apr 2022 14:44:28 -0700 (PDT)
Message-ID: <f496b0c6-ad94-1837-1edd-3f6f9c00b927@google.com>
Date:   Fri, 15 Apr 2022 14:44:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [RFC PATCH 0/2] kunit: Support redirecting function calls
Content-Language: en-US
From:   Steve Muckle <smuckle@google.com>
To:     Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>
Cc:     Daniel Latypov <dlatypov@google.com>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Joe Fradley <joefradley@google.com>
References: <20220318021314.3225240-1-davidgow@google.com>
 <20220318092159.6f275782@gandalf.local.home>
 <CAFd5g461Poh37o=3m6EXppdX7oS0D5vZxvFAEtzJMwtBD1VJEw@mail.gmail.com>
 <f65c2381-1e9c-5945-7672-848d1826532d@google.com>
In-Reply-To: <f65c2381-1e9c-5945-7672-848d1826532d@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-21.5 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Joe Fradley who is also looking at KUnit with Android.

On 4/15/22 14:43, Steve Muckle wrote:
> On 4/4/22 13:13, Brendan Higgins wrote:
>> On Fri, Mar 18, 2022 at 9:22 AM Steven Rostedt <rostedt@goodmis.org> 
>> wrote:
>>>
>>> On Fri, 18 Mar 2022 10:13:12 +0800
>>> David Gow <davidgow@google.com> wrote:
>>>
>>>> Does either (or both) of these features sound useful, and is this
>>>> sort-of API the right model? (Personally, I think there's a reasonable
>>>> scope for both.) Is anything obviously missing or wrong? Do the names,
>>>> descriptions etc. make any sense?
>>>
>>> Obviously I'm biased toward the ftrace solution ;-)
>>
>> Personally, I like providing both - as long as we can keep the
>> interface the same.
>>
>> Ftrace is less visually invasive, but it is also less flexible in
>> capabilities, and requires substantial work to support on new
>> architectures.
> 
> The general feature looks useful to me. I'm not sure the ftrace based 
> API is worth it given it is only offering a visual improvement and has 
> some drawbacks compared to the other implementation (won't work with 
> inline functions, dependencies on other features). Livepatch is absent 
> on arm64 which mostly rules it out for my purposes (Android Generic 
> Kernel Image testing).
> 
> cheers,
> Steve
