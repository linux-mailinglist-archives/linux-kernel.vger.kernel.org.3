Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9959467D62
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 19:35:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382679AbhLCSia (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 13:38:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239825AbhLCSi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 13:38:29 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A92ABC061751
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 10:35:05 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id b187so4874437iof.11
        for <linux-kernel@vger.kernel.org>; Fri, 03 Dec 2021 10:35:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Dvb4sebfbgF5tG7jNm/fwyVvE8C324Y2j6ohBL2yz/g=;
        b=e4eV32esPJVMasZjHWwwKo1SrNWPcIfXXZB2nTOhb47i1AIYSO+F4BhmI8DMxNfhNp
         zieVZcDPs2FoqVu37wepru6WTLgg8kQ5VU3jKS8q2lom+rfYmZRy5QSTxZXHHuql+ylQ
         BEoQQMkYsD7OBczq+40JVnXYv9ELM/+tGpl6Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Dvb4sebfbgF5tG7jNm/fwyVvE8C324Y2j6ohBL2yz/g=;
        b=jNpwkFajKuz1RmiMpjB5Lx0fAISAj7WlT3onMk9JI+0ldPa/XErq0SU3fa7yoFlwk6
         AoNSaQ58V/mXE5sct+DIUx0Gw10cTFCjmViEx1lYtGugYcJrShxh86DS0qloR6zWE6UH
         f/zKBCrHkx96ckoou22j3dvO1jzB3Fb4HlwNj7IV+wGelaBusE2f8H6+i15PgNubaABq
         Fi8tEXpeEUQFVyCJ6+CF5MBHqS3ZXn3gvdpKDZkvO78wX0qAIEh1hY9REoClk4EjqqIt
         jNsmho1K7dpd8sHnkQ3WqTm04gW2x61NXRidmjGZevvYGpQAP9nu0jxcLmk0K+yLj3u2
         QXRQ==
X-Gm-Message-State: AOAM5331IcoBB6rQUb+NPOLp94pgq7+hWtl4MfYiFDX70CCwUS9m1g4Q
        vhQBmSK2cN9TobWI3xc06uQ/6w==
X-Google-Smtp-Source: ABdhPJz3Pg+8n2+rp3lqwQiUSXkIrBpuhyJUc3cFSjOCT8MenJj612dBl7sMBJUFEmsrEmq646DYKA==
X-Received: by 2002:a5d:9650:: with SMTP id d16mr22177930ios.15.1638556505083;
        Fri, 03 Dec 2021 10:35:05 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id j8sm2183345ilu.64.2021.12.03.10.35.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Dec 2021 10:35:04 -0800 (PST)
Subject: Re: [PATCH] tests: remove unneeded conversion to bool
To:     davidcomponentone@gmail.com, shuah@kernel.org
Cc:     christian.brauner@ubuntu.com, ptikhomirov@virtuozzo.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yang Guang <yang.guang5@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <f1fe5f6b00e62a6f70c47f1d8b4c41d5d7d03d7d.1637736469.git.yang.guang5@zte.com.cn>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <3fd7f268-9113-1ac0-dd41-bd2f3b7b9298@linuxfoundation.org>
Date:   Fri, 3 Dec 2021 11:35:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <f1fe5f6b00e62a6f70c47f1d8b4c41d5d7d03d7d.1637736469.git.yang.guang5@zte.com.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/24/21 5:58 PM, davidcomponentone@gmail.com wrote:
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
> ---
>   .../selftests/move_mount_set_group/move_mount_set_group_test.c  | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/move_mount_set_group/move_mount_set_group_test.c b/tools/testing/selftests/move_mount_set_group/move_mount_set_group_test.c
> index 860198f83a53..80ff0b692486 100644
> --- a/tools/testing/selftests/move_mount_set_group/move_mount_set_group_test.c
> +++ b/tools/testing/selftests/move_mount_set_group/move_mount_set_group_test.c
> @@ -222,7 +222,7 @@ static int move_mount_set_group_supported(void)
>   		      AT_FDCWD, SET_GROUP_TO, MOVE_MOUNT_SET_GROUP);
>   	umount2("/tmp", MNT_DETACH);
>   
> -	return ret < 0 ? false : true;
> +	return ret >= 0;
>   }
>   
>   FIXTURE(move_mount_set_group) {
> 

In this case it would be better to change the return type for
move_mount_set_group_supported() to bool

thanks,
-- Shuah
