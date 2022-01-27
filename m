Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 054AF49EE6B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 00:05:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244228AbiA0XFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 18:05:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233578AbiA0XFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 18:05:12 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D3FEC061714
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 15:05:12 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id w5so3911096ilo.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 15:05:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ugCItrwo0ss9dgcN2szPgJWeHIoouXMe0YCZuFZEEls=;
        b=hVOxI6iaC0UXRSa4Agb/xb8+zr1UYkCtukbKgm3KDuTmjbt0n6gpYZQtERrygrd1Oj
         8Nxg7JRTT4eyyLHdpklR9qQRGhcSzbsS0yHkOF4XgnfJ7VBFpj/SqV9cCE08l0yGr4FC
         o8F7kFDGNx9+76Ut7YZ7syKkMgBhgo6xVX8vo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ugCItrwo0ss9dgcN2szPgJWeHIoouXMe0YCZuFZEEls=;
        b=qwR8hDMmmaLfJTKq+Dt7hDUOVp2BJ31SWJ3xhO9Ve4PYThtHYkeNxtUkPzrx4IWkWD
         EQe4dLZU5zbeleXiZDmQv0L+8ZfHi+DOr59Qi4TkqHrOxWbqzOug6TTsXj9VSyW5bSWZ
         WPzO1BNQ9ztDXxn5Rng3hEJgk66jxE3n066D47LUeeJHhz0XUgV+UWext68CY9qvwj8J
         E5F/6eRA1XCW/JK/GWX1mD5yp2vLG0Bz7zQASIEagMksRUOhv9qCOP9rzv5UuC3dIvSo
         I3EcNrdO44201/+JRzt+cMVzBFQQA1txAGea1jwXNmtwT37qZjs3e1/DVHH7TXEHoapk
         7N5A==
X-Gm-Message-State: AOAM531wZsx7HQxhavCjTfilrQDWJ4xxj+5sPFtzdVuR3uq7SaG7jvo5
        rf25vna/Fu6hh73GzS44wYMv5A==
X-Google-Smtp-Source: ABdhPJwXXflCmQ1hgAwQMVYFF87lzBNcgzjATV8WsguEvEG/lZKhX+UaXgPLmONHhstvkocPNa7nVQ==
X-Received: by 2002:a92:a00e:: with SMTP id e14mr4276144ili.192.1643324711809;
        Thu, 27 Jan 2022 15:05:11 -0800 (PST)
Received: from ?IPv6:2601:282:8200:4c:fcdb:3423:ed25:a583? ([2601:282:8200:4c:fcdb:3423:ed25:a583])
        by smtp.gmail.com with ESMTPSA id f13sm11830560ion.18.2022.01.27.15.05.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jan 2022 15:05:11 -0800 (PST)
Subject: Re: [PATCH 0/5] Miscellaneous trivial fixes
To:     Cristian Marussi <cristian.marussi@arm.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     shuah@kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20220126102723.23300-1-cristian.marussi@arm.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <2b60f8fa-ac54-c2b1-209b-a8db0da7dc72@linuxfoundation.org>
Date:   Thu, 27 Jan 2022 16:05:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220126102723.23300-1-cristian.marussi@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/26/22 3:27 AM, Cristian Marussi wrote:
> Hi Shuah,
> 
> a small series collecting a few trivial fixes that I have already sent
> previously (~Dec2021) as distinct patches.
> 
> They are mostly trivial patches addressing failures that seemed more
> sensible to be marked as skips instead. (at least to me ...).
> Original developers are in Cc. (but not heard back from anyone :D)
> 
> Thanks,
> Cristian
> 
> Cristian Marussi (5):
>    selftests: skip mincore.check_file_mmap when fs lacks needed support
>    kselftest: Fix vdso_test_time to pass on skips
>    selftests: openat2: Print also errno in failure messages
>    selftests: openat2: Add missing dependency in Makefile
>    selftests: openat2: Skip testcases that fail with EOPNOTSUPP
> 
>   .../selftests/mincore/mincore_selftest.c      | 20 +++++++++++++------
>   tools/testing/selftests/openat2/Makefile      |  2 +-
>   tools/testing/selftests/openat2/helpers.h     | 12 ++++++-----
>   .../testing/selftests/openat2/openat2_test.c  | 12 ++++++++++-
>   tools/testing/selftests/vDSO/vdso_test_abi.c  |  3 ++-
>   5 files changed, 35 insertions(+), 14 deletions(-)
> 

Thank you Cristian. Please see responses for individual patches.

thanks,
-- Shuah


