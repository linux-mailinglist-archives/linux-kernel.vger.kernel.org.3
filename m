Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66611563858
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 18:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232398AbiGAQ7R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 12:59:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232197AbiGAQ7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 12:59:14 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A52A11A3E
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 09:59:14 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id a16so1781457ilr.6
        for <linux-kernel@vger.kernel.org>; Fri, 01 Jul 2022 09:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VEszNyKVwtIDou70xdE4vCFc6o5wY4jfOpRp+w8sJVo=;
        b=hRmd+YPSjVJD7PL/0wX/gFt/D4QwwFRpsNxXvl7D3Kyr71gJKK0BHzCEZJNnWPX54S
         QZUlxFJ2Xh8ALTedXvGzDtpNm72pB76hrwv4tN2Uh0m7HctzeTBxpGJhtuWfdwpw3mRa
         Of1HtTxs9FgEIfUMt28m4sMfHtVHUdEtNVGXE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VEszNyKVwtIDou70xdE4vCFc6o5wY4jfOpRp+w8sJVo=;
        b=2HPY1v5Mj/dqzBjE6QjBwaFgUkUy24sNarw5g2/Trm+L8YX0+IuEPuRvaKoG6H6xOI
         Jecoz7N3L0GuxI30iZlg2+y2/O8sGGpmQdDmEE+wqcUlUVJot8rzeSOVqlVjK9KnT+/K
         zvmYBT82yh7F8f6Sy0l4Gy7pNB4ZfgCfII4GGVl2p+NUnimim/8nyeuedMesqSaSdpvV
         zwf3wcI8ClSJENJAIV4/c5bf3e3et8vPvXBFlBCxpndcy6uhmW29JVQagIbf/JE0nATw
         o1YgGV9BIifkMVxoS3B1Irc10DAMgs2FQ6V2WUXjLF5tMvUuWvkxIrzmJDypcGtI/FbN
         zGiA==
X-Gm-Message-State: AJIora8fEQiqzGX6S3U+U9VhJJnDIEFF72p7gkSRretZH76cSmQ9mD70
        vjSr2UZObj2mGJt1SqbDv46qhQ==
X-Google-Smtp-Source: AGRyM1tZ1o3WYbngjSls4BbtWnjSAncI4ln2sXFWSZOddCGq4foxHqD2cVBPDm380WYaZH5HmXHGxQ==
X-Received: by 2002:a05:6e02:1e05:b0:2da:e2da:5509 with SMTP id g5-20020a056e021e0500b002dae2da5509mr3695626ila.266.1656694753373;
        Fri, 01 Jul 2022 09:59:13 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id bg13-20020a0566383c4d00b00339edc9d877sm5670646jab.120.2022.07.01.09.59.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Jul 2022 09:59:13 -0700 (PDT)
Subject: Re: [char-misc:char-misc-linus 3/3]
 drivers/misc/cardreader/rtsx_usb.c:639:6: warning: variable 'ret' is used
 uninitialized whenever 'if' condition is true
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel test robot <lkp@intel.com>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <202207011658.rHJFVLWA-lkp@intel.com> <Yr63Zyvj49o8U/ti@kroah.com>
 <67a09516-ec1f-d0b6-c027-fd52159318ed@linuxfoundation.org>
 <Yr8VIT2vjvGYrbmR@dev-arch.thelio-3990X>
 <1c13496a-9e45-38b6-1563-c09d412cf576@linuxfoundation.org>
 <6e148c41-4a31-f173-f5ea-d52e115c268c@linuxfoundation.org>
 <Yr8giNcxMQyxx+KZ@dev-arch.thelio-3990X>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <909a0c61-d151-2d60-1f3c-a2c22d590b33@linuxfoundation.org>
Date:   Fri, 1 Jul 2022 10:59:11 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <Yr8giNcxMQyxx+KZ@dev-arch.thelio-3990X>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/1/22 10:27 AM, Nathan Chancellor wrote:
> On Fri, Jul 01, 2022 at 10:09:45AM -0600, Shuah Khan wrote:
>> On 7/1/22 9:52 AM, Shuah Khan wrote:
>>> On 7/1/22 9:39 AM, Nathan Chancellor wrote:
>>>> On Fri, Jul 01, 2022 at 08:48:11AM -0600, Shuah Khan wrote:
>>>>> On 7/1/22 2:59 AM, Greg Kroah-Hartman wrote:
>>
>>>>>>> All warnings (new ones prefixed by >>):
>>>>>>>
>>>>>>>>> drivers/misc/cardreader/rtsx_usb.c:639:6: warning: variable 'ret' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
>>>>>>>               if (!ucr->rsp_buf)
>>>>>>>                   ^~~~~~~~~~~~~
>>>>>>>       drivers/misc/cardreader/rtsx_usb.c:678:9: note: uninitialized use occurs here
>>>>>>>               return ret;
>>>>>>>                      ^~~
>>>>>>>       drivers/misc/cardreader/rtsx_usb.c:639:2: note: remove the 'if' if its condition is always false
>>>>>>>               if (!ucr->rsp_buf)
>>>>>>>               ^~~~~~~~~~~~~~~~~~
>>>>>>>       drivers/misc/cardreader/rtsx_usb.c:622:9: note: initialize the variable 'ret' to silence this warning
>>>>>>>               int ret;
>>>>>>>                      ^
>>>>>>>                       = 0
>>>>>>>       1 warning generated.
>>>>>>
>>>>>> Odd, gcc doesn't show this for me.  Shuah, can you send a follow-on
>>>>>> patch to fix this?  The warning does look correct.
>>>>>>
>>>>>
>>>>> gcc didn't complain when I compiled either. I will send a follow-on patch.
>>>>
>>>> Unfortunately, GCC won't warn for most uninitialized variables by
>>>> default after 5.7, which included commit 78a5255ffb6a ("Stop the ad-hoc
>>>> games with -Wno-maybe-initialized"). They will potentially show up at
>>>> W=2 or with an explicit KCFLAGS=-Wmaybe-uninitialized (it does in this
>>>> case):
>>>>
>>>
>>> Thank you.
>>>
>>>> | drivers/misc/cardreader/rtsx_usb.c: In function ‘rtsx_usb_probe’:
>>>> | drivers/misc/cardreader/rtsx_usb.c:678:16: error: ‘ret’ may be used uninitialized [-Werror=maybe-uninitialized]
>>>> |   678 |         return ret;
>>>> |       |                ^~~
>>>> | drivers/misc/cardreader/rtsx_usb.c:622:13: note: ‘ret’ was declared here
>>>> |   622 |         int ret;
>>>> |       |             ^~~
>>>> | cc1: all warnings being treated as errors
>>>>
>>>
>>> This is a bug and a good find. ret should have been set
>>> in the if (!ucr->rsp_buf) before going to error handling.
>>>
>>> I wonder if it would have been flagged if ret were to be
>>> initialized to 0. Something to experiment.
>>>
>>
>> I had to try. As I suspected initializing ret will mask this bug.
>>
>> KCFLAGS=-Wmaybe-uninitialized will not flag it even though
>> the bug still exists. It will return 0 w hen memory allocation
>> fails.
> 
> Right, if the variable is unconditonally initialized at the top of the
> function, it can never be flagged as uninitialized but that doesn't mean
> the value is correct for every branch within the function.
> 

+1

>> Initializing isn't always the right answer for these kinds of
>> warnings.
> 
> I would say "unconditional initialization", as ret has to be initialized
> somewhere to fix this warning, right? If you are referring to clang's
> 'ret = 0' suggestion, I agree that it can be misleading (especially in
> the case of suggesting initializing dereferenced pointers to NULL...,
> see [1]) but at the end of the day, it is still on the programmer to
> analyze their code fully in light of the warning before implementing a
> fix. Clang cannot know that the return code should be set in the if
> statement rather than at the top of the function.
> 

+1 on "programmer to analyze their code fully in light of the warning"

I am not necessarily referring to the clang warning. I agree that it could
be misleading and suggest or send us towards a wrong fix. It is on us to
be careful - this would be when fixing the problem and reviewing the fix.

thanks,
-- Shuah


