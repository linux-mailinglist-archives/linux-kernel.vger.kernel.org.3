Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58B1449AB27
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 05:45:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389716AbiAYEjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 23:39:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1316820AbiAYDZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 22:25:37 -0500
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 460CEC03463F
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 15:00:49 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id v8-20020a9d6048000000b005960952c694so24320775otj.12
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 15:00:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=eTJQQ6MsX5Ff+bIQxYo4yiY9UnTvAPhZS922wxBLIWs=;
        b=h6BIQ1pcW7rPc8/weadr6vCqLFeRDLjdrhOUSLh7XrSPq/jMDafrMY/HirVc+W/RDZ
         MXF2olW97HltisTcta1a143cKvHiklq3Aj1LH5S3JxKFBDjwRV1ebgBBTbTvdfXV1abd
         GNMccz9OHR9pUgC9/fJc5a9vlP4RRRZ4ZBO1SOy3IUKoIvQ6f1WIzxljHEnrH5jkj0XY
         Y0c/iihEtQXqZA6tnnTIHm+VVsg2YV1EEoBrmmw/s/ve0YiSm6UU59wHip7acpwn5+aN
         t0T3YMTSclGHaU1r231pMnkqHXoGtF4khPMbmiIGjPMtayZLaRcTqr5psf8pRYj3GNJs
         klfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=eTJQQ6MsX5Ff+bIQxYo4yiY9UnTvAPhZS922wxBLIWs=;
        b=NaH7Xf+0IXmlDfXU/6BXhqUrfRdwf0ODedCYVJ+100arebk5Uu2sGydy2wLoyI7GNt
         oEmAiu1YKDl2UpNnTSHs0zas2M9ZgmeRtQCaGlJAqplH+pMQrJV/zTAwNq1D6BZRl0nM
         NEpFyV5HSACwHtXE3aL+Ez3Dl0RiE4ls5uk3F7oceX3Qgqhicjie64JsKa1GobPdf0UE
         UpG9AiIheMpmCBGbIWGIHwnuXvLLk3p4yJUZuVhUCc2MKxUN4Kup19DzMwE+IwxOdlsv
         kjOibjarrIqWYG8D8wnHP5HEmjIEVfv/8/myIfPjuER4leD9cqd4QaVJazH0d0l307AK
         PjVQ==
X-Gm-Message-State: AOAM531BHJjbXj9sVQLSs8hYX+AIXT+ywKcjJPYj8UtpRYG4ps+HTFb0
        CxcFnL9M98MUFrpjLjHjt9l+cA==
X-Google-Smtp-Source: ABdhPJxkcSpap1VhLGQAw/l13hEXVNq4heAfIa2fMfb+0SaQZSgk40Jcw0IUMg6wCQsfoHGmsdM/Wg==
X-Received: by 2002:a05:6830:1e99:: with SMTP id n25mr12847268otr.344.1643065248584;
        Mon, 24 Jan 2022 15:00:48 -0800 (PST)
Received: from [192.168.17.16] ([189.219.72.83])
        by smtp.gmail.com with ESMTPSA id n4sm2075103otr.76.2022.01.24.15.00.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jan 2022 15:00:48 -0800 (PST)
Message-ID: <12c8fd1e-431e-9a59-9e7a-e8d856c088b9@linaro.org>
Date:   Mon, 24 Jan 2022 17:00:46 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 5.10 000/563] 5.10.94-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        stable@vger.kernel.org
References: <20220124184024.407936072@linuxfoundation.org>
From:   =?UTF-8?Q?Daniel_D=c3=adaz?= <daniel.diaz@linaro.org>
In-Reply-To: <20220124184024.407936072@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 1/24/22 12:36, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.94 release.
> There are 563 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 26 Jan 2022 18:39:11 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.94-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Regressions detected on arm, arm64, i386, x86.

This is from arm64:
   /builds/linux/arch/arm64/mm/extable.c: In function 'fixup_exception':
   /builds/linux/arch/arm64/mm/extable.c:17:13: error: implicit declaration of function 'in_bpf_jit' [-Werror=implicit-function-declaration]
      17 |         if (in_bpf_jit(regs))
         |             ^~~~~~~~~~
   cc1: some warnings being treated as errors
   make[3]: *** [/builds/linux/scripts/Makefile.build:280: arch/arm64/mm/extable.o] Error 1

And from Perf on arm, arm64, i386, x86:
   libbpf.c: In function 'bpf_object__elf_collect':
   libbpf.c:2873:31: error: invalid type argument of '->' (have 'GElf_Shdr' {aka 'Elf64_Shdr'})
    2873 |                         if (sh->sh_type != SHT_PROGBITS)
         |                               ^~
   libbpf.c:2877:31: error: invalid type argument of '->' (have 'GElf_Shdr' {aka 'Elf64_Shdr'})
    2877 |                         if (sh->sh_type != SHT_PROGBITS)
         |                               ^~
   make[4]: *** [/builds/linux/tools/build/Makefile.build:97: /home/tuxbuild/.cache/tuxmake/builds/current/staticobjs/libbpf.o] Error 1

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Greetings!

Daniel Díaz
daniel.diaz@linaro.org
