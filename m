Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D59E4CC5E0
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 20:18:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235979AbiCCTSs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 14:18:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235952AbiCCTSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 14:18:47 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0635DE0A18
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 11:17:57 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id d62so6893209iog.13
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 11:17:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dIqDQiM7oZs/BeAm16FgrVYsBf41PpL+82PUANl2efE=;
        b=VbzBMgxs6WZwlXJklAwiZKFWJ7clZ8uemIEDrZ9a+Slc24NctIzp0Lteo0SRTC/tNX
         kcbTfgilNPTu4GHlOJ1LPLRwpH8ZcgqZrUx3VS7TAhnOVPnmmuGIzwjJzuQcM1XuoxWM
         C9BN+I+ykFsAVp0Dz3uT6jaOtaC34e614vFaE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dIqDQiM7oZs/BeAm16FgrVYsBf41PpL+82PUANl2efE=;
        b=1tze/okCaaTs1GleOUxs5krGfcGcWQ0hVKev7hmJ+XaE8RZjXyKSb58ypb8lSDDTo9
         CujrYFXh1VKhmTnHScRc1UVFEXFq+cvhSPw4mOJT+oSo2ArEYB9diiLBd67hGNO9jL56
         qaJUH92K9V0nS/emBXOnP8lgLKGQEm6MyO4sWhtDfge04EtcDHY4kBlXI3Ma5biKHeWK
         x4FoFp7IjTYSG78ccnkdQnRjphs5fFhLibs/8xgEYSipnCKHh7YlEAvcCASRI2B5dGr3
         oWICgzDtEfv6bHkNjCm0lJqTZm7THgqiQhVVqumOa/eciD4p+LNaiWRMVYpuHBm7VTcb
         0aFQ==
X-Gm-Message-State: AOAM5305pM2lfLTmoyMCMg0Aa5QzFCh+0gdrR7Dx5AEL7swSTXTJNQ0/
        GKL+pIHLcQgpNxb3iB8BG6p9SA==
X-Google-Smtp-Source: ABdhPJyMxq8kWRS3HIgVEN7K3EBss+x8+kqb5QDi+m7C3uCeZV0PLiOO9dFYs+bilk+WfhkIhG/MNQ==
X-Received: by 2002:a05:6638:2688:b0:314:e214:d996 with SMTP id o8-20020a056638268800b00314e214d996mr29676711jat.167.1646335077364;
        Thu, 03 Mar 2022 11:17:57 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id g13-20020a5e8b0d000000b00641a04fc91esm2458362iok.19.2022.03.03.11.17.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Mar 2022 11:17:57 -0800 (PST)
Subject: Re: [PATCH 1/2] kselftest/vm: override TARGETS from arguments
To:     Chengming Zhou <zhouchengming@bytedance.com>,
        akpm@linux-foundation.org, shuah@kernel.org
Cc:     linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220227055330.43087-1-zhouchengming@bytedance.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <b29de093-72dd-1dc5-b591-2a75f49cdb2a@linuxfoundation.org>
Date:   Thu, 3 Mar 2022 12:17:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220227055330.43087-1-zhouchengming@bytedance.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/26/22 10:53 PM, Chengming Zhou wrote:
> We can specify which testcases to build using TARGETS argument,
> for example: make -C tools/testing/selftests TARGETS=vm, cause
> the ordinary assignment of TARGETS in Makefile will be ignored.
> So we need to use override directive to change that.
> 
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> ---
>   tools/testing/selftests/vm/Makefile | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/vm/Makefile b/tools/testing/selftests/vm/Makefile
> index 1607322a112c..0b330a5b1840 100644
> --- a/tools/testing/selftests/vm/Makefile
> +++ b/tools/testing/selftests/vm/Makefile
> @@ -53,7 +53,7 @@ CAN_BUILD_I386 := $(shell ./../x86/check_cc.sh $(CC) ../x86/trivial_32bit_progra
>   CAN_BUILD_X86_64 := $(shell ./../x86/check_cc.sh $(CC) ../x86/trivial_64bit_program.c)
>   CAN_BUILD_WITH_NOPIE := $(shell ./../x86/check_cc.sh $(CC) ../x86/trivial_program.c -no-pie)
>   
> -TARGETS := protection_keys
> +override TARGETS := protection_keys
>   BINARIES_32 := $(TARGETS:%=%_32)
>   BINARIES_64 := $(TARGETS:%=%_64)
>   
> 

Let's not override TARGETS - rename TARGETS in this file.
VM_TARGETS?

thanks,
-- Shuah
