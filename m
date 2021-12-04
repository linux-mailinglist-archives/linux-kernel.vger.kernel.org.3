Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50A42468139
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 01:24:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354411AbhLDA17 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 19:27:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236734AbhLDA16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 19:27:58 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBB6DC061751
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 16:24:33 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id z18so5903886iof.5
        for <linux-kernel@vger.kernel.org>; Fri, 03 Dec 2021 16:24:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=a1pLRvmy/fAvkWzuzDb9pBSfVT4A0bn5puxatHFXDoQ=;
        b=InhScPobGRXwrp/oFbqIA/V67FIHedQF5Zw8o1cFhECd+ScGVxhSFBp6SR9M7iDDsI
         vc/oJG9D3DgJaIaeyuxQ4BITSII/tHEOw+HohWY3GIpaOgk4M74OGmfrMHDB8jGikb7z
         tQhFgHx7cEXIAWHBzzutM1I32XUmEEZ4x4RRQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=a1pLRvmy/fAvkWzuzDb9pBSfVT4A0bn5puxatHFXDoQ=;
        b=hesG11+h3jLG8puMqatCPepC3SngfIrlOGnv+gvncXtxMgT71ScJOn6pcSzjrJbr5C
         W+xO/C1aY+FDE3BEQ32lorKrR1MxnbqBvnC+wlLpXh2mxbWYA2I1TjM59MqPXE1IakxF
         0spSH5wLg3clI0acINvY2RTLwUb8l8FiW+zSQDSdqWq+OJm8s9v2K29jbwnV80UxSmSV
         VmL5BZla67CO7sJgap7TowJktdgEzDXtH8JLEUCv4CflCUsn80kip/pYdXnDU4jIMLJ2
         cxLvlKjzq1Fc8k+IGVkMTPyGWLK1+cnYE7zR0aATGQNKmhTBhLzyHv4/PJSmStYaq8f0
         gcbw==
X-Gm-Message-State: AOAM5310sckxsHBj0+bvSwfxHgLheH5AShgkaYAu0ZxSUMe3+NWuop8a
        PQGJriXjgbaUZ4hCuSF9xxjEhA==
X-Google-Smtp-Source: ABdhPJzvXTMGmtkj+/kwy7OvJb+QApx/oQeK+djC2i2VgWQLMMPYgmF/YFg+m7MMVruunGUdBwp1ug==
X-Received: by 2002:a5d:940c:: with SMTP id v12mr23413671ion.157.1638577472721;
        Fri, 03 Dec 2021 16:24:32 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id d16sm2264665ila.51.2021.12.03.16.24.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Dec 2021 16:24:32 -0800 (PST)
Subject: Re: [PATCH] mnt: remove unneeded conversion to bool
To:     Joe Perches <joe@perches.com>, davidcomponentone@gmail.com,
        shuah@kernel.org
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yang Guang <yang.guang5@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <3a7435c9e7e7aa8f24d22fd576ce912eb0540272.1637737086.git.yang.guang5@zte.com.cn>
 <07f4ba23-cf4c-6817-f7a4-5428f35d966c@linuxfoundation.org>
 <983ee57718a6e5838f79be96b7f7efc638177f76.camel@perches.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <eef8e264-7cf7-8747-867e-b40c9f180d0d@linuxfoundation.org>
Date:   Fri, 3 Dec 2021 17:24:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <983ee57718a6e5838f79be96b7f7efc638177f76.camel@perches.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/3/21 12:50 PM, Joe Perches wrote:
> On Fri, 2021-12-03 at 11:26 -0700, Shuah Khan wrote:
>> On 11/24/21 5:56 PM, davidcomponentone@gmail.com wrote:
>>> From: Yang Guang <yang.guang5@zte.com.cn>
>>>
>>> The coccinelle report
>>> ./tools/testing/selftests/mount/unprivileged-remount-test.c:285:54-59:
>>> WARNING: conversion to bool not needed here
>>> ./tools/testing/selftests/mount/unprivileged-remount-test.c:207:54-59:
>>> WARNING: conversion to bool not needed here
>>> Relational and logical operators evaluate to bool,
>>> explicit conversion is overly verbose and unneeded.
>>>
>>> Reported-by: Zeal Robot <zealci@zte.com.cn>
>>> Signed-off-by: Yang Guang <yang.guang5@zte.com.cn>
>>> ---
>>>    tools/testing/selftests/mount/unprivileged-remount-test.c | 4 ++--
>>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/tools/testing/selftests/mount/unprivileged-remount-test.c b/tools/testing/selftests/mount/unprivileged-remount-test.c
>>> index 584dc6bc3b06..d2917054fe3a 100644
>>> --- a/tools/testing/selftests/mount/unprivileged-remount-test.c
>>> +++ b/tools/testing/selftests/mount/unprivileged-remount-test.c
>>> @@ -204,7 +204,7 @@ bool test_unpriv_remount(const char *fstype, const char *mount_options,
>>>    		if (!WIFEXITED(status)) {
>>>    			die("child did not terminate cleanly\n");
>>>    		}
>>> -		return WEXITSTATUS(status) == EXIT_SUCCESS ? true : false;
>>> +		return WEXITSTATUS(status) == EXIT_SUCCESS;
>>>    	}
>>>    
>>>    	create_and_enter_userns();
>>> @@ -282,7 +282,7 @@ static bool test_priv_mount_unpriv_remount(void)
>>>    		if (!WIFEXITED(status)) {
>>>    			die("child did not terminate cleanly\n");
>>>    		}
>>> -		return WEXITSTATUS(status) == EXIT_SUCCESS ? true : false;
>>> +		return WEXITSTATUS(status) == EXIT_SUCCESS;
>>>    	}
>>>    
>>>    	orig_mnt_flags = read_mnt_flags(orig_path);
>>>
>>
>> This change doesn't look right. WEXITSTATUS(status) return could be
>>> 1 or 0 or negative.
> 
> The change is at least logically correct.
> 
> And isn't WEXITSTATUS range limited from 0->255 ?
> 
> https://www.gnu.org/software/libc/manual/html_node/Exit-Status.html
> 

You are right. In any case, I don't see any value in changing the current
logic. The way it is coded is cryptic enough :)

thanks,
-- Shuah
