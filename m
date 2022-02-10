Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95EDA4B144D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 18:34:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243220AbiBJReW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 12:34:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233508AbiBJReU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 12:34:20 -0500
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A41E1F03
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 09:34:21 -0800 (PST)
Received: by mail-il1-x12f.google.com with SMTP id i10so4948371ilm.4
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 09:34:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/tW1HGdJGuZOMZnaP+IuCrurMw3sZjUR555ryvHuly8=;
        b=cwG4FzstvfQXqw15EB/NDvc1w0xZNKAkaDZS4ZQMnQ2HL2JpBNj8Z5Y5wYiQ2ujVeO
         WLcCdBgmAdSZEm30ZxlPTXcOizaaAWmBJLxIQpnvX4M/KTtKJtAe7V8N9ViEeCzhAZDz
         oufKRZaOGyXRdJZvCDWh2OlLwSlyOJ8/drnRM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/tW1HGdJGuZOMZnaP+IuCrurMw3sZjUR555ryvHuly8=;
        b=oJgNLEYiW/Y8YvutNhCZJSa5rfc238rPW6mH3RVBAgSOhJxUNTvW9y8wOAlTIP+bNI
         d+JGJgorRouMP6KqsMPxZkXtIz37TS98gvkXQifv+PqSKtNqC7XpkyXzyoWVhk0lL24h
         nSSv8SIGv35OU7vehG6REW+hAOSldSJf32+DZnOGntbpqk/JlsVYnQK+X8F0Ch/+RTeE
         mGm+lrz3m5w2UJnlReUDceAPuN91XujC+y8irLUAJCiJtxzgv2zqb4CmwPn+8rdP1oX0
         8BlTED/B8kXkT+cgVwWkkqCS/BV4LxOmNKIF4v5IfaABePp4wNRjV0RkH40pf0q7Duvh
         p9MQ==
X-Gm-Message-State: AOAM533eIbfMtcVNaNK4z3rg6D8EfLDDobchK4W25GiE6S3DGw2HjHsN
        EexdNRz/A/FQbnIvGqZXx8KOUA==
X-Google-Smtp-Source: ABdhPJwEKbE1y3rDTWjXLP59cL/Fr4JzYYmPkaFynHTcU6lUNsbLWMniGmzTYo1ikTPYP11+UXInww==
X-Received: by 2002:a05:6e02:18c9:: with SMTP id s9mr4053986ilu.94.1644514461028;
        Thu, 10 Feb 2022 09:34:21 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id s16sm380928iow.10.2022.02.10.09.34.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Feb 2022 09:34:20 -0800 (PST)
Subject: Re: [PATCH] selftests/exec: Add non-regular to TEST_GEN_PROGS
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     kernel@collabora.com, kernelci@groups.io,
        "kernelci.org bot" <bot@kernelci.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220210171323.1304501-1-usama.anjum@collabora.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <e8397c75-32df-b1d2-c3c3-21c5c0943ef6@linuxfoundation.org>
Date:   Thu, 10 Feb 2022 10:34:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220210171323.1304501-1-usama.anjum@collabora.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/10/22 10:13 AM, Muhammad Usama Anjum wrote:
> non-regular file needs to be compiled and then copied to the output
> directory. Remove it from TEST_PROGS and add it to TEST_GEN_PROGS. This
> removes error thrown by rsync when non-regular object isn't found:
> 
> rsync: [sender] link_stat "/linux/tools/testing/selftests/exec/non-regular" failed: No such file or directory (2)
> rsync error: some files/attrs were not transferred (see previous errors) (code 23) at main.c(1333) [sender=3.2.3]
> 
> Fixes: 0f71241a8e32 ("selftests/exec: add file type errno tests")
> Reported-by: "kernelci.org bot" <bot@kernelci.org>
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
>   tools/testing/selftests/exec/Makefile | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/exec/Makefile b/tools/testing/selftests/exec/Makefile
> index 551affb437fe1..a89ba6de79870 100644
> --- a/tools/testing/selftests/exec/Makefile
> +++ b/tools/testing/selftests/exec/Makefile
> @@ -3,8 +3,8 @@ CFLAGS = -Wall
>   CFLAGS += -Wno-nonnull
>   CFLAGS += -D_GNU_SOURCE
>   
> -TEST_PROGS := binfmt_script non-regular
> -TEST_GEN_PROGS := execveat load_address_4096 load_address_2097152 load_address_16777216
> +TEST_PROGS := binfmt_script
> +TEST_GEN_PROGS := execveat load_address_4096 load_address_2097152 load_address_16777216 non-regular
>   TEST_GEN_FILES := execveat.symlink execveat.denatured script subdir
>   # Makefile is a run-time dependency, since it's accessed by the execveat test
>   TEST_FILES := Makefile
> 

This change looks good to me. regular is a binary and TEST_GEN_PROGS is
where it belongs.

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

Also binfmt_script could be renamed to clearly identify that it is python
script. This can be done in a separate patch.

thanks,
-- Shuah
