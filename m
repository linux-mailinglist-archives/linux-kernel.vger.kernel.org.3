Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9034949E8DA
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 18:23:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238694AbiA0RXX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 12:23:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233679AbiA0RXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 12:23:20 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 035E1C061714
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 09:23:20 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id e79so4368200iof.13
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 09:23:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=aSG6wKr0v3ubZC/yTzhG0VRBiAKrGFtCqsPwiK/7Zlw=;
        b=ciSTkyveZepfHPpJzY9+3WZpFGiUPVCctm7Hm9k7hvlPEGuZ6tZnYcn6wUabTAy53g
         eDe/SAl+bJYjU883tOyfq1vjtCz3QYmup5PcbRPOfM6qR7pMJPSU5iKZ8rTMEqSMV7xE
         oe5PjG09l+JoR74v7iVDYGGqaMKtj4G1hMr0c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aSG6wKr0v3ubZC/yTzhG0VRBiAKrGFtCqsPwiK/7Zlw=;
        b=Qprb3HzKLsvxLzR+db6sm6RQ1ydSONjjZUbf4rDl5VHCaqiDOgxGdnF4MValtXgeJ6
         9MQjZR+qd8VvkhtlpglEKmFvj9Oj3wtJVSrRxQkibNxsXztKulGlLHMyZRL/qELre+81
         gY0huSWuBBbOOjiebyO/xmlAYrYZb3c9SzFUmXTOGWXTcB/uv120ExF3qYd3JM3c6vQY
         J4iz9wIHcnI78r4Cb+dkyhx1DdVzvHQM5etftGIQFylKyaCFoMBAhAY/QV3L5uRp3mx1
         C0kdVaRpA5BYDcjbVFhr7mqcz8eUcGfQTAgvJAnbYKcYdNz8WbS2+AMrhnrQNPlWLw72
         L82A==
X-Gm-Message-State: AOAM531g5+j9Q6adEx1pCDnmIcPahPFXtaWEhv4CHgK5mOrqQKaByNXp
        lfDTTNWtpJlWKsyR71JKtadArw==
X-Google-Smtp-Source: ABdhPJxQcee80gMTTtjof5GIUBbB9Eoi07zExK3kPJo2V4lrgGxjckOC8IERNNIymE1ux3gyXwMlJQ==
X-Received: by 2002:a05:6638:192:: with SMTP id a18mr2408066jaq.27.1643304199356;
        Thu, 27 Jan 2022 09:23:19 -0800 (PST)
Received: from ?IPv6:2601:282:8200:4c:fcdb:3423:ed25:a583? ([2601:282:8200:4c:fcdb:3423:ed25:a583])
        by smtp.gmail.com with ESMTPSA id b12sm6973918ilv.68.2022.01.27.09.23.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jan 2022 09:23:19 -0800 (PST)
Subject: Re: [PATCH] selftests/exec: Remove pipe from TEST_GEN_FILES
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Kees Cook <keescook@chromium.org>
Cc:     Eric Biederman <ebiederm@xmission.com>,
        Shuah Khan <shuah@kernel.org>, kernel@collabora.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220127163346.653546-1-usama.anjum@collabora.com>
 <202201270844.660E5394C@keescook>
 <329a935a-1c12-c5f8-1467-e6a6e98c9c24@collabora.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <6b5c55fa-955c-0771-eb9b-43c7d0606764@linuxfoundation.org>
Date:   Thu, 27 Jan 2022 10:23:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <329a935a-1c12-c5f8-1467-e6a6e98c9c24@collabora.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/27/22 9:55 AM, Muhammad Usama Anjum wrote:
> 
> 
> On 1/27/22 9:45 PM, Kees Cook wrote:
>> On Thu, Jan 27, 2022 at 09:33:45PM +0500, Muhammad Usama Anjum wrote:
>>> pipe named FIFO special file is being created in execveat.c to perform
>>> some tests. Makefile doesn't need to do anything with the pipe. When it
>>> isn't found, Makefile generates the following build error:
>>>
>>> make: *** No rule to make target '/linux_mainline/tools/testing/selftests/exec/pipe', needed by 'all'.  Stop.
>>
>> Ah, good catch. However, I think this should be moved to EXTRA_CLEAN instead of
>> only removed from TEST_GEN_FILES. (i.e. "pipe" is created by
>> tools/testing/selftests/exec/execveat.c and should be removed.
> Hi,
> 
> Thank you. tools/testing/selftests/exec/execveat.c creates pipe file and
> removes it after performing the test on it. I've looked at the code path
> between creation and deletion of this file. It'll always be removed
> automatically. So we shouldn't add it to EXTRA_CLEAN.
> 

Thank you for finding and fixing the problem.

I see that pipe is created in prerequisites() and removed from run_tests()
after executing non-regular file test. The change looks fine and I ran a
quick test and it looks good.

On a separate note the test use its own Makefile for running a test and
copies it over in TEST_FILES - Just a bit strange, all seems to work well.

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

I can pull this in for rc3.

thanks,
-- Shuah

