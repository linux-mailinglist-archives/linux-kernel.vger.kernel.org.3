Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45CB756376D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 18:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231442AbiGAQJt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 12:09:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbiGAQJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 12:09:48 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 740F51EAF3
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 09:09:47 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id u199so4189928oie.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Jul 2022 09:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ylzGgIW56JtJ+Phcp0uf+6gzrZ/i3VWAXHPNQQtzAWM=;
        b=DHAUe+A4qjTc41GJSiV+PjOxeQ9qzPJDfg7GO1jvNbqCxv8/NW8r5Ys0a3xrSL+s9/
         DOkvlR/v5wWKxkFhCxYtF1x5brKocWxKQHvWbtqr0IOhXaEuG1NGrGieL4B9QXf21nbz
         esuohjZoo//7UEeVW/sHk8ksax6rmKOJgKtfE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ylzGgIW56JtJ+Phcp0uf+6gzrZ/i3VWAXHPNQQtzAWM=;
        b=NZenUAnrty9qQXAg1/Nh+XNTZRqGSeFZsDMPO49JQ+enYOj4MjdKwCp0PgqYwzxr81
         pPipk2z65VXiiGjwr2hdvIPdyQh/2k0pZHghtSLtR4pkXVXCKNPJ3HkHeGXlbEawrx9l
         CtLoVzpFa37QlwkdyFg7CJhaFvw51/xhAHmMi2sSQq8odSydP5daZxNOFcJTluakpul8
         mXzEWV/TOjxaMDWM7BPpqAWODvzbo+dmV+RxO5MFyZITR8JEKhZqu6HgRAWzvOXvgo65
         vsXBCKgYEduWy5cvLTilJtVmlTKUn0oDl4RTKjNctpove7PGCvx3GDXxq/QFrYSK5faO
         fymQ==
X-Gm-Message-State: AJIora/5BJi6gncmbGRSpBf0M1VPr2pr2jpJ3G1bQokCG386HPXXCCNI
        ROlkIo70zvXIh5W+50srGbtnfVzf32R0vA==
X-Google-Smtp-Source: AGRyM1t/xiZvd8TroOht8NceIy5jewtQuGpG1HewViQhK528mcp3YhtGr1Xr7JCG6AKvE8+NJGcD/w==
X-Received: by 2002:a05:6808:ec7:b0:322:2bcc:42c2 with SMTP id q7-20020a0568080ec700b003222bcc42c2mr10555343oiv.168.1656691786667;
        Fri, 01 Jul 2022 09:09:46 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id x31-20020a4a97e2000000b00425beedad70sm5493918ooi.32.2022.07.01.09.09.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Jul 2022 09:09:46 -0700 (PDT)
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
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <6e148c41-4a31-f173-f5ea-d52e115c268c@linuxfoundation.org>
Date:   Fri, 1 Jul 2022 10:09:45 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <1c13496a-9e45-38b6-1563-c09d412cf576@linuxfoundation.org>
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

On 7/1/22 9:52 AM, Shuah Khan wrote:
> On 7/1/22 9:39 AM, Nathan Chancellor wrote:
>> On Fri, Jul 01, 2022 at 08:48:11AM -0600, Shuah Khan wrote:
>>> On 7/1/22 2:59 AM, Greg Kroah-Hartman wrote:

>>>>> All warnings (new ones prefixed by >>):
>>>>>
>>>>>>> drivers/misc/cardreader/rtsx_usb.c:639:6: warning: variable 'ret' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
>>>>>              if (!ucr->rsp_buf)
>>>>>                  ^~~~~~~~~~~~~
>>>>>      drivers/misc/cardreader/rtsx_usb.c:678:9: note: uninitialized use occurs here
>>>>>              return ret;
>>>>>                     ^~~
>>>>>      drivers/misc/cardreader/rtsx_usb.c:639:2: note: remove the 'if' if its condition is always false
>>>>>              if (!ucr->rsp_buf)
>>>>>              ^~~~~~~~~~~~~~~~~~
>>>>>      drivers/misc/cardreader/rtsx_usb.c:622:9: note: initialize the variable 'ret' to silence this warning
>>>>>              int ret;
>>>>>                     ^
>>>>>                      = 0
>>>>>      1 warning generated.
>>>>
>>>> Odd, gcc doesn't show this for me.  Shuah, can you send a follow-on
>>>> patch to fix this?  The warning does look correct.
>>>>
>>>
>>> gcc didn't complain when I compiled either. I will send a follow-on patch.
>>
>> Unfortunately, GCC won't warn for most uninitialized variables by
>> default after 5.7, which included commit 78a5255ffb6a ("Stop the ad-hoc
>> games with -Wno-maybe-initialized"). They will potentially show up at
>> W=2 or with an explicit KCFLAGS=-Wmaybe-uninitialized (it does in this
>> case):
>>
> 
> Thank you.
> 
>> | drivers/misc/cardreader/rtsx_usb.c: In function ‘rtsx_usb_probe’:
>> | drivers/misc/cardreader/rtsx_usb.c:678:16: error: ‘ret’ may be used uninitialized [-Werror=maybe-uninitialized]
>> |   678 |         return ret;
>> |       |                ^~~
>> | drivers/misc/cardreader/rtsx_usb.c:622:13: note: ‘ret’ was declared here
>> |   622 |         int ret;
>> |       |             ^~~
>> | cc1: all warnings being treated as errors
>>
> 
> This is a bug and a good find. ret should have been set
> in the if (!ucr->rsp_buf) before going to error handling.
> 
> I wonder if it would have been flagged if ret were to be
> initialized to 0. Something to experiment.
> 

I had to try. As I suspected initializing ret will mask this bug.

KCFLAGS=-Wmaybe-uninitialized will not flag it even though
the bug still exists. It will return 0 when memory allocation
fails.

Initializing isn't always the right answer for these kinds of
warnings.

thanks,
-- Shuah


