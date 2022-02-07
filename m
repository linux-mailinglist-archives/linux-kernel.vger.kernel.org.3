Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00CE94AC8CB
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 19:45:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbiBGSmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 13:42:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235270AbiBGSkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 13:40:35 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D073FC0401D9
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 10:40:33 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id 9so18096208iou.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 10:40:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xRXlDhviuTEfdiTDsXUwY6dPo1OySinAm73Hd1uXh0o=;
        b=Z2iPrLZxMkV6EX9FGWFjy12J8QyHDDnMWexBVUyyLGBjvifSntAvR9UFEWloZvVbx4
         XBpuX/Q7vnhyXtARRTf0xh6R9qg7yQN4Hq5xyGkI9X+siyhInl6CpNXPnTXFJwzGWa+C
         pgyJuMhbelZdR0uBKZeGA/5TgwRpYVYzSwLRg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xRXlDhviuTEfdiTDsXUwY6dPo1OySinAm73Hd1uXh0o=;
        b=gXMqGQEGDKbr1CO6XK9ZdWxgjrRQKYzW3KYYDxu/KbBRsmksVFYO2WzlRg3c7pMo00
         fYtM7tf+HAp7VbXE643wIT6rZFQZBVNfSTxAjyi63MBat19vZ8XBZmeusV29uD709E92
         V0DUyrIWSIt4UhEZVQ8H+AoYqtpWlkgNj1jfBUC31uoaCJFPqHSxdGF/b25X6mx4lMVU
         Axv6q+WlXwVD99jQKFFRqRD7cfIB2AA0O2/ldll0/P36dxxjMgK+2lkBrCnW2vNI7Gm+
         kjcFbsoJNOlRgkk/UPPNLJKD9g8+RdtY69c61rwR2+vBDyCjMj6jYp8nS8EMKpdP8i0h
         0dQg==
X-Gm-Message-State: AOAM530mPg/hZOAxDtUa5AEjq8njtrmEpXRzk6pwLhM1dSGWhHuIcutN
        wa0RQk4Ilq5RrbdHl3HGyohjsw==
X-Google-Smtp-Source: ABdhPJyt5a1vQSm9soeSqTDRgviqmpdpbmVCsEG5JXRmV6Lxn2JECxePfGKPW1h52SyQ/iUKCIWxwA==
X-Received: by 2002:a02:8188:: with SMTP id n8mr513343jag.126.1644259232913;
        Mon, 07 Feb 2022 10:40:32 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id o11sm5919815ilm.20.2022.02.07.10.40.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Feb 2022 10:40:32 -0800 (PST)
Subject: Re: [PATCH] selftests: futex: set DEFAULT_INSTALL_HDR_PATH
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@collabora.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     kernel@collabora.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220119103332.2887370-1-usama.anjum@collabora.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <3a4878b9-f175-f16f-a901-efc33b2bf89f@linuxfoundation.org>
Date:   Mon, 7 Feb 2022 11:40:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220119103332.2887370-1-usama.anjum@collabora.com>
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

On 1/19/22 3:33 AM, Muhammad Usama Anjum wrote:
> If only futex selftest is compiled, uapi header files are copied to the
> selftests/futex/functional directory. This copy isn't needed. Set the
> DEFAULT_INSTALL_HDR_PATH variable to 1 to use the default header install
> path only. This removes extra copy of header file.
> 
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
>   tools/testing/selftests/futex/functional/Makefile | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/selftests/futex/functional/Makefile b/tools/testing/selftests/futex/functional/Makefile
> index 5cc38de9d8ea..9a8c3700d773 100644
> --- a/tools/testing/selftests/futex/functional/Makefile
> +++ b/tools/testing/selftests/futex/functional/Makefile
> @@ -24,6 +24,7 @@ TEST_PROGS := run.sh
>   
>   top_srcdir = ../../../../..
>   KSFT_KHDR_INSTALL := 1
> +DEFAULT_INSTALL_HDR_PATH := 1
>   include ../../lib.mk
>   
>   $(TEST_GEN_FILES): $(HEADERS)
> 

This will be a good cleanup. However, please make there is no dependencies
in the futex test sub-dirs on being able to find the headers under futex

I vaguely remember leaving this in place for reason.

thanks,
-- Shuah

