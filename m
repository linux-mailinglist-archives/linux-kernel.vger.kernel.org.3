Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AAF855C1E5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:45:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239389AbiF0T6L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 15:58:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238751AbiF0T5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 15:57:49 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 020571AF20
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 12:57:49 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id r133so10733898iod.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 12:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lqwOAoba/ks14RAlOuCuq3KoOwqWCZzhrVHd00SRYuU=;
        b=EIi1+WIUXf3QH2AIHTiPlmrQhAjCiWwqMV/c4LV89ASzefFOIA7JDqpFHQ3unPykkr
         I3VNmPE2O7qeNSlRDakDrvJcfUqnFL+Bvt1bVCFcVYdruUYTODGwQl6TJDVEo2l3y0Sn
         pE9upRnscBoiyPkoLPi087ULasFmtuJW8BBgw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lqwOAoba/ks14RAlOuCuq3KoOwqWCZzhrVHd00SRYuU=;
        b=EmjxTwZtLvMAEObCRbQVrbek8srhJGZsGl9wLfOhsZAs161Dfe/p51u6iDKtzL6sI0
         IUIlEBED2U7Wm/Hn/6ymp8kmt1UtZKKN8MIBqc5p98PJ55nrHVkckL3l1mA72VXdCy0f
         atkKLDKR5OOQ0C4i9GWgVMXxKz8vJYRD8TkA8ctmOl+/TAHpy1OkYO6Vb7AV2VdMRTlD
         NVTP9Zx8Tl/lCFDUsJfTHxBNBOJG/6RswXWPy7mQvvmQ6BBcBkI/Mw34iSOfGiuqlDxo
         H+Ds1jnnSDi6mqc7v7hvChaGqc8A35V4ySDJqIeEsdl0m18t3og8ZJDr8fGoUC7GC6Xi
         dMhA==
X-Gm-Message-State: AJIora9H/Xff5mXc234vpc/JAl4ZaJy3z+G3KU+OCLltLSvDXrnk+1XL
        zhpnwBqwGZk3afRqQbXwRgstXA==
X-Google-Smtp-Source: AGRyM1vPUY5rBcsCKVKLXXe91Fex4P38D7+JHGrIjDVlAu1abFJfQoGRYq2ydMVgVtbhYTyQBUJapQ==
X-Received: by 2002:a5d:9c45:0:b0:675:1774:74a2 with SMTP id 5-20020a5d9c45000000b00675177474a2mr7127442iof.104.1656359868372;
        Mon, 27 Jun 2022 12:57:48 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id t16-20020a92dc10000000b002d94906dacfsm4889401iln.67.2022.06.27.12.57.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jun 2022 12:57:48 -0700 (PDT)
Subject: Re: [PATCH] tools: Strong conversion of void type pointer could be
 removed
To:     Li kunyu <kunyu@nfschina.com>, shuah@kernel.org
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220627085654.2902-1-kunyu@nfschina.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <9b587975-db5b-c7bf-eb8f-bd6e5c3d9f54@linuxfoundation.org>
Date:   Mon, 27 Jun 2022 13:57:47 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220627085654.2902-1-kunyu@nfschina.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/27/22 2:56 AM, Li kunyu wrote:
> The void pointer argument does not require a cast assignment because it
> is the address passed.
> 

Please include information on you found this problem with output
from the tool if any used. Send v2 with that information included
in the commit log.

> Signed-off-by: Li kunyu <kunyu@nfschina.com>
> ---
>   tools/testing/selftests/x86/fsgsbase.c      | 2 +-
>   tools/testing/selftests/x86/test_vsyscall.c | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/x86/fsgsbase.c b/tools/testing/selftests/x86/fsgsbase.c
> index 8c780cce941d..5d99261317e1 100644
> --- a/tools/testing/selftests/x86/fsgsbase.c
> +++ b/tools/testing/selftests/x86/fsgsbase.c
> @@ -63,7 +63,7 @@ static void clearhandler(int sig)
>   
>   static void sigsegv(int sig, siginfo_t *si, void *ctx_void)
>   {
> -	ucontext_t *ctx = (ucontext_t*)ctx_void;
> +	ucontext_t *ctx = ctx_void;
>   
>   	if (!want_segv) {
>   		clearhandler(SIGSEGV);
> diff --git a/tools/testing/selftests/x86/test_vsyscall.c b/tools/testing/selftests/x86/test_vsyscall.c
> index 5b45e6986aea..2416941a0952 100644
> --- a/tools/testing/selftests/x86/test_vsyscall.c
> +++ b/tools/testing/selftests/x86/test_vsyscall.c
> @@ -184,7 +184,7 @@ static volatile unsigned long segv_err;
>   
>   static void sigsegv(int sig, siginfo_t *info, void *ctx_void)
>   {
> -	ucontext_t *ctx = (ucontext_t *)ctx_void;
> +	ucontext_t *ctx = ctx_void;
>   
>   	segv_err =  ctx->uc_mcontext.gregs[REG_ERR];
>   	siglongjmp(jmpbuf, 1);
> 

thanks,
-- Shuah
