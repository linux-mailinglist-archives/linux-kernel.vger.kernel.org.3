Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A720049EEAA
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 00:12:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236526AbiA0XMq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 18:12:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241222AbiA0XMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 18:12:42 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 769AEC06173B
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 15:12:42 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id q204so5628509iod.8
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 15:12:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=918jrcgUxCmMB4m6j6zD1BiHXUVRw1xmSUCNvAW/T6A=;
        b=ORVUIOQy3M2i5QGsBDch0ugfsE1XTZsriSxre3J0UdyjrRcoBD67K/aSAzmtDoGQXT
         WLBvCYiG2NOWITuRevQbI47fyuwUY0xjlicb8pWRejT42XM90FPodc7JzMD1HVbIShkK
         tgk/g+0uUmIBFP4+sbPXm9ixdhakSm7ZO68sE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=918jrcgUxCmMB4m6j6zD1BiHXUVRw1xmSUCNvAW/T6A=;
        b=treM+fZKnAJBW/haV/FCU8YtqhacH8UpNI0UTwo8danR5hgVyRiGkLI39+pzmJW3AM
         Ln7OnGmh8B700WQjcytbilrguDjhlcv6x3IC8YS/vAX2NFMkqkadEWHKorDiGqXLfi3j
         rn0keHMgvecsWZbmTebx0yXx9GJqa0i1j5epBKbqQ+YlD3NbtZ0j2McvHE/o/zXxqRsI
         H0mHrB98xs5yVfYPYxYvDKL9d0YT7TSzOE64+K9BmX5QRGObAKRIk0z7Xcyos8PeBc72
         B1Jkqv3+sJEVVQ9oRVv1XjMvgFncy3tdLqAM+RxSIvKdl++TVeiYUgRHgtv3vC7VqoSG
         eI/A==
X-Gm-Message-State: AOAM533YBkRfB90c2FdQ6hSxi2zKRePP2M4tnMmF+qfFSwRcX3cd5F0c
        /2aGwtWyeQYZKVyG5nWPuJJ9hw==
X-Google-Smtp-Source: ABdhPJz0I8NyrzM/8XTUjRuHFl5a8Tn4Gq5A/jq2aVn+65DCpXVYK7QEYWrS9Lt98EFDhTL9CSln1g==
X-Received: by 2002:a05:6638:e90:: with SMTP id p16mr3305459jas.234.1643325161827;
        Thu, 27 Jan 2022 15:12:41 -0800 (PST)
Received: from ?IPv6:2601:282:8200:4c:fcdb:3423:ed25:a583? ([2601:282:8200:4c:fcdb:3423:ed25:a583])
        by smtp.gmail.com with ESMTPSA id p5sm12109346iof.50.2022.01.27.15.12.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jan 2022 15:12:41 -0800 (PST)
Subject: Re: [PATCH 4/5] selftests: openat2: Add missing dependency in
 Makefile
To:     Cristian Marussi <cristian.marussi@arm.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     shuah@kernel.org, Aleksa Sarai <cyphar@cyphar.com>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220126102723.23300-1-cristian.marussi@arm.com>
 <20220126102723.23300-5-cristian.marussi@arm.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <c5d165af-6f89-f94b-f6da-d0b231c72929@linuxfoundation.org>
Date:   Thu, 27 Jan 2022 16:12:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220126102723.23300-5-cristian.marussi@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/26/22 3:27 AM, Cristian Marussi wrote:
> Add a dependency on header helpers.h to the main target; while at that add
> to helpers.h also a missing include for bool types.
> 
> Cc: Aleksa Sarai <cyphar@cyphar.com>
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> ---
>   tools/testing/selftests/openat2/Makefile  | 2 +-
>   tools/testing/selftests/openat2/helpers.h | 1 +
>   2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/openat2/Makefile b/tools/testing/selftests/openat2/Makefile
> index 4b93b1417b86..843ba56d8e49 100644
> --- a/tools/testing/selftests/openat2/Makefile
> +++ b/tools/testing/selftests/openat2/Makefile
> @@ -5,4 +5,4 @@ TEST_GEN_PROGS := openat2_test resolve_test rename_attack_test
>   
>   include ../lib.mk
>   
> -$(TEST_GEN_PROGS): helpers.c
> +$(TEST_GEN_PROGS): helpers.c helpers.h
> diff --git a/tools/testing/selftests/openat2/helpers.h b/tools/testing/selftests/openat2/helpers.h
> index ad5d0ba5b6ce..7056340b9339 100644
> --- a/tools/testing/selftests/openat2/helpers.h
> +++ b/tools/testing/selftests/openat2/helpers.h
> @@ -9,6 +9,7 @@
>   
>   #define _GNU_SOURCE
>   #include <stdint.h>
> +#include <stdbool.h>
>   #include <errno.h>
>   #include <linux/types.h>
>   #include "../kselftest.h"
> 

Thanks for the patch. Will apply for linux-kselftest fixes branch for rc3

thanks,
-- Shuah
