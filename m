Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDAB346A551
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 20:03:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348195AbhLFTGi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 14:06:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232972AbhLFTGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 14:06:36 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEB8FC061746
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 11:03:07 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id m6so23242512oim.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 11:03:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fKh92gBQ/JlyboOIrCcxM8mFCnyTXSVFZXGlgmH5yVA=;
        b=B0yZBZwlFtSOZ4ruhEcIXf2BhctcDeaksMo2201atOcJyFxBNX2Z/1LEMWNrlrATA3
         syazv+QP4pxR6Ep0r2Yk/TCKWHYQgCUZOtDmj1DAjR0GUvxMSRzkGW125FB0bBGs4tAj
         CurNAWmxuIJ1ufN3lDBOF39PjFvjHqtCQ+dB0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fKh92gBQ/JlyboOIrCcxM8mFCnyTXSVFZXGlgmH5yVA=;
        b=U9ljAaB7aDdjkmUtybimMyma7M2igERlhs8RI7GlIaN62XszsYBXad1GWjs8O8vtDC
         pd0dU2uvmEswGD4Jtc5Yo6W5WTJdS874Qf6SCXrCK2ilD6kCfUnYRiaCmrk9L17iBAr3
         IW1TMgr2thXlsyA0Z8PtrNirGcQYT7iZ9DZD7gtEo7loABobkYiGLzr85IPx69NSHApb
         4f4p49Gwmu6sn4fst3hQfkZVgMqnqcFxMkA6g5kaS28z2EbTuHQEFAyXkNVVH/FZyUpr
         RxSyKTMTl/1Sle2b5aMqcrvHXwekqkyjQwu16h3sFDne2JUMPSQZvBbu90YzUMtWxpv0
         4MLQ==
X-Gm-Message-State: AOAM533DMM0csVRn1m2rAIatyFMbcltXYTYuSp0TrYrxh4JbKrllA6/L
        hY3SvYYdAKZYyaj5gamqW/CzGBoWUheyzg==
X-Google-Smtp-Source: ABdhPJzOXSK3bacduRdgn7xIdMLmwFsU5jPIN1OyImfnzY7ewCwb3mTE0To7zAm0tG0BDKB6wDJYcw==
X-Received: by 2002:aca:1001:: with SMTP id 1mr417971oiq.55.1638817387079;
        Mon, 06 Dec 2021 11:03:07 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id t13sm2800562oiw.30.2021.12.06.11.03.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Dec 2021 11:03:06 -0800 (PST)
Subject: Re: [PATCH v2] tests: remove unneeded conversion to bool
To:     davidcomponentone@gmail.com, shuah@kernel.org
Cc:     ptikhomirov@virtuozzo.com, christian.brauner@ubuntu.com,
        yang.guang5@zte.com.cn, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zeal Robot <zealci@zte.com.cn>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <9bca1d9eb8ccacf4a64a8813f9eefe7f7272b3d6.1638581673.git.yang.guang5@zte.com.cn>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <da6c119c-993b-dae5-25ff-e6cce97b55e3@linuxfoundation.org>
Date:   Mon, 6 Dec 2021 12:03:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <9bca1d9eb8ccacf4a64a8813f9eefe7f7272b3d6.1638581673.git.yang.guang5@zte.com.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/5/21 5:07 PM, davidcomponentone@gmail.com wrote:
> From: Yang Guang <yang.guang5@zte.com.cn>
> 
> The coccinelle report
> ./tools/testing/selftests/move_mount_set_group/move_mount_set_group_test.c:225:18-23:
> WARNING: conversion to bool not needed here
> Relational and logical operators evaluate to bool,
> explicit conversion is overly verbose and unneeded.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Yang Guang <yang.guang5@zte.com.cn>
> 
> ---
> 
> Changes in v2:
> - Change the return type to bool.
> ---
>   .../move_mount_set_group/move_mount_set_group_test.c   | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/testing/selftests/move_mount_set_group/move_mount_set_group_test.c b/tools/testing/selftests/move_mount_set_group/move_mount_set_group_test.c
> index 860198f83a53..50ed5d475dd1 100644
> --- a/tools/testing/selftests/move_mount_set_group/move_mount_set_group_test.c
> +++ b/tools/testing/selftests/move_mount_set_group/move_mount_set_group_test.c
> @@ -191,7 +191,7 @@ static bool is_shared_mount(const char *path)
>   #define SET_GROUP_FROM	"/tmp/move_mount_set_group_supported_from"
>   #define SET_GROUP_TO	"/tmp/move_mount_set_group_supported_to"
>   
> -static int move_mount_set_group_supported(void)
> +static bool move_mount_set_group_supported(void)
>   {
>   	int ret;
>   
> @@ -222,7 +222,7 @@ static int move_mount_set_group_supported(void)
>   		      AT_FDCWD, SET_GROUP_TO, MOVE_MOUNT_SET_GROUP);
>   	umount2("/tmp", MNT_DETACH);
>   
> -	return ret < 0 ? false : true;
> +	return ret >= 0;
>   }
>   
>   FIXTURE(move_mount_set_group) {
> @@ -232,7 +232,7 @@ FIXTURE(move_mount_set_group) {
>   
>   FIXTURE_SETUP(move_mount_set_group)
>   {
> -	int ret;
> +	bool ret;
>   
>   	ASSERT_EQ(prepare_unpriv_mountns(), 0);
>   
> @@ -254,7 +254,7 @@ FIXTURE_SETUP(move_mount_set_group)
>   
>   FIXTURE_TEARDOWN(move_mount_set_group)
>   {
> -	int ret;
> +	bool ret;
>   
>   	ret = move_mount_set_group_supported();
>   	ASSERT_GE(ret, 0);
> @@ -348,7 +348,7 @@ TEST_F(move_mount_set_group, complex_sharing_copying)
>   		.shared = false,
>   	};
>   	pid_t pid;
> -	int ret;
> +	bool ret;
>   
>   	ret = move_mount_set_group_supported();
>   	ASSERT_GE(ret, 0);
> 

Applied. In the future use selftests/<test>: .... convention for
patch summary. Review "git log <filename>" history for how to
write summaries and change logs.

I fixed this one for now.

thanks,
-- Shuah
