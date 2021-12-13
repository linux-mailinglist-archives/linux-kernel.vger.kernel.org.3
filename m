Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89D614735D7
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 21:25:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242862AbhLMUZQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 15:25:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235878AbhLMUZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 15:25:15 -0500
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBF64C06173F
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 12:25:14 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id a23-20020a9d4717000000b0056c15d6d0caso18664377otf.12
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 12:25:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vamzT5fQdqt7FXkOPVNfycHCO0oUwMx3NFBhiXymTbo=;
        b=Yy8z48ZUQDadYiOtc+DH/ezqZ4HSC6GhjeoaShEsy7O6N79ttnu9zwag86rvco1+h9
         8FKY2x+rX3Yf71W8j1qhzAyxWoDvDSb/iiTE1F3E2zdKW5sz3L+flK+FOHDvtJpbtkPm
         AiNXcqxMSxQdzXqVROuKqg7ozcD1NMq1EDx30=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vamzT5fQdqt7FXkOPVNfycHCO0oUwMx3NFBhiXymTbo=;
        b=VHxNfUUV20UlPEOfqsG/fmGrBrqG8JgyejM1/zKR4oj/br+TGkleg/vp0w514y/Iav
         YTuf5PYLydW8cJB3AkpFNGY0St6tVes9K4G3CDtKhHhSMW8HPSPt9TjbZxPX9ev/VKi3
         d7AwEzgU/vuF+n7FlVwwYKzNTcphDHRTl0wXxBxRZMFg0a+yyX4FeodJ33jdbUeCMa64
         wTT0vvwfkLHYJKhrS/mbenTP+NbuG3s6GL3hn6NqUxHBVF+NlbEYnEc2go8yV6iUD0rN
         ab7ExKmpj+KbkEujnrmn4qmldxO55EFHYhLysUBv9cF0ogUHHcgsYk8CGNX6AwvPcvMJ
         4/FQ==
X-Gm-Message-State: AOAM533aNdyRKOhCnAuqn6FLygR7ZZDgySE/3K1pzCk+m+WPyYpHAiaw
        HeRxjHyt2rJc1qpIFm1tsnsOsw==
X-Google-Smtp-Source: ABdhPJz6CrRRDQ4mMYL9Knmcd5JPan3qm0CwshYpHvKjWL3QrV78VwVQ4DHo7vTGaI9s16Gam3VW7w==
X-Received: by 2002:a05:6830:2707:: with SMTP id j7mr658092otu.354.1639427114188;
        Mon, 13 Dec 2021 12:25:14 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id m12sm3048709oiw.23.2021.12.13.12.25.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Dec 2021 12:25:13 -0800 (PST)
Subject: Re: [PATCH 5.10 000/132] 5.10.85-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20211213092939.074326017@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <4d974e1d-17b6-abba-9cfe-9e0496ccdf2d@linuxfoundation.org>
Date:   Mon, 13 Dec 2021 13:25:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20211213092939.074326017@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/13/21 2:29 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.85 release.
> There are 132 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 15 Dec 2021 09:29:16 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.85-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

Tested-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
