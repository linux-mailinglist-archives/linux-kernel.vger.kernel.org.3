Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE23049AB26
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 05:45:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388101AbiAYEiz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 23:38:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S3418555AbiAYDY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 22:24:59 -0500
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4430EC058CA8
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 14:50:49 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id l64-20020a9d1b46000000b005983a0a8aaaso24375340otl.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 14:50:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=PtqrHf0yIm4rhTcrPnNb9htroYp3oCFjuET72eP4bEg=;
        b=MtvSDul2MqyVPeBjE/g5ny8qv43GKzh5Zzh1OBD7sqUE4HHpCl4yTos8VBDSJ5F1cM
         4mX9P94pIJF3VgNu3QRBLbXx7LdLnK7o66sU3mpnbGIhNb04zj8/Qol7lWIaq0WBcChW
         RZtNwXLHjDfF27vr54Sb3dJdT4caoZXCtnD66VvsbDlK5AnW6KFTbECe23JM/4tVug0Y
         vb242iMbx1GfSKRpaWt2KGWuR2YSd+zN6WsV8As81HaL82vA/BLAZWK1Us6AMRFlXrDr
         3TQd2rfm9idHMpN5f5VJ0TvjLbK5QjD7aYFqbUSi4W0DCWsvaNj9Fk9md7jPBblikum4
         xbYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=PtqrHf0yIm4rhTcrPnNb9htroYp3oCFjuET72eP4bEg=;
        b=lnPC97HkmncQLT3wlWYBizI9tAiXyYcs5cO2mBacrsh0v549KEdzizawDPFPpxZ7Z3
         OQC8Sa63Y4JWakL6Vzl9a/4e/Bxl9xuS+fWw0wjvzjCVHyDMhQpTrINWZxpveWCfrb+2
         g9H2iY7kaq+QkBXahHdAl0Ia0I3tioDXOMcomweGKKb5bywwMGkKPqthaKYaHYTBU4JA
         OZsU618DmzHdrtUPcUetBlJFtF4j9yZpRzX/ChWHVr1JsJRClmaHgR5mW1hnP4X3O9B4
         p3av6odCRPfUKn6O87ew+JRWx/Z+TYJxg/c1o6hxWnmgqIXzI/Sb8+7JI6JB2PL6N3gu
         Gajg==
X-Gm-Message-State: AOAM530EFS+AN0xufmE315YcZzF74jCcM5BBpXhZM98ruvn5Ux/71ywj
        5yi5cwN1ZbSJY09Phx7Kxd9+qg==
X-Google-Smtp-Source: ABdhPJyB45kVnFKre7voatLM55kjnn1OciVJYBGVaOn1d1Lxqn8m8Dji3FWoSZx6BMhl4jrU5VsvqA==
X-Received: by 2002:a05:6830:4110:: with SMTP id w16mr13104510ott.66.1643064648609;
        Mon, 24 Jan 2022 14:50:48 -0800 (PST)
Received: from [192.168.17.16] ([189.219.72.83])
        by smtp.gmail.com with ESMTPSA id t2sm6003500otp.71.2022.01.24.14.50.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jan 2022 14:50:48 -0800 (PST)
Message-ID: <374e9357-35eb-3555-3fe5-7b72c3a77a39@linaro.org>
Date:   Mon, 24 Jan 2022 16:50:45 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 5.15 000/846] 5.15.17-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        stable@vger.kernel.org
References: <20220124184100.867127425@linuxfoundation.org>
From:   =?UTF-8?Q?Daniel_D=c3=adaz?= <daniel.diaz@linaro.org>
In-Reply-To: <20220124184100.867127425@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 1/24/22 12:31, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.17 release.
> There are 846 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 26 Jan 2022 18:39:11 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.17-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Regressions detected on arm, arm64, i386, x86.

This is one from arm64:
   /builds/linux/arch/arm64/mm/extable.c: In function 'fixup_exception':
   /builds/linux/arch/arm64/mm/extable.c:17:13: error: implicit declaration of function 'in_bpf_jit' [-Werror=implicit-function-declaration]
      17 |         if (in_bpf_jit(regs))
         |             ^~~~~~~~~~
   cc1: some warnings being treated as errors
   make[3]: *** [/builds/linux/scripts/Makefile.build:277: arch/arm64/mm/extable.o] Error 1

This is another one, in Perf (arm, arm64, i386, x86):
   libbpf.c: In function 'bpf_object__elf_collect':
   libbpf.c:3038:31: error: invalid type argument of '->' (have 'GElf_Shdr' {aka 'Elf64_Shdr'})
    3038 |                         if (sh->sh_type != SHT_PROGBITS)
         |                               ^~
   libbpf.c:3042:31: error: invalid type argument of '->' (have 'GElf_Shdr' {aka 'Elf64_Shdr'})
    3042 |                         if (sh->sh_type != SHT_PROGBITS)
         |                               ^~
   make[4]: *** [/builds/linux/tools/build/Makefile.build:97: /home/tuxbuild/.cache/tuxmake/builds/current/staticobjs/libbpf.o] Error 1

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Greetings!

Daniel Díaz
daniel.diaz@linaro.org
