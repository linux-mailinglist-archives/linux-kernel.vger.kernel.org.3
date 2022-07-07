Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52A4E5696BB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 02:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234711AbiGGAGV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 20:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234127AbiGGAGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 20:06:19 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F4D72DA87
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 17:06:19 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id v185so15431662ioe.11
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 17:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RGizXG/uxdoJz8U4c3W7MH/XgehlwnClhkyqDDUQKKs=;
        b=GMRPjL02HfiZEay0Ow0wEZIRQM8YqK19JjQ6wHkRag7IZnuEcaG1e3d4UyX7n9Z8vP
         8R18RNEMpqXoIay+/HrrBFm0tcxRneMmyF2PGEzDTrvbLqCwyRAJ1T+aTKwLeNmQqvB1
         kuk5gwxBDFQMkVAjNjPIabx4ujXIS0nk5Eei0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RGizXG/uxdoJz8U4c3W7MH/XgehlwnClhkyqDDUQKKs=;
        b=vgkiyPQcc1OX9eSsLMqfcSFVpEae/FrsPlQBnTz0v56EWitC50onS8uqzGf2UUVnZe
         y1Zc56UQlkd2w49YKjCml7kBKev15w8Qa0iCwx+ncpEwAqHrBlz+t/NGSxsR8DVCNCxQ
         Gqsm2l+yUE8NnqAIE9Uu9pr9sVKCu9Q26tPjU0Y6huCiFNzMFKEOjBo+0O6s3h9WZ6C6
         MhxxTCHB5Iru9zdhOcqL6N3Lo7z8902Ry/GlSS8aML7BHyFnh/PRDKIFzNtrHlzbyqb0
         T0iRXYSRt25sqyKs1JZf8VpcRQfB6GQV04lM85Xnm/IxmdlKKpccuSs4/pKeTW+rkv76
         VypQ==
X-Gm-Message-State: AJIora8Cu57JIs4z7jenx9oH5OvzrczYLG3CphKLZx7DjlU9OXhqwDge
        NQbs4Wz1dfzyQL3uB4WcNfTL8Q==
X-Google-Smtp-Source: AGRyM1syZJEzhDl+xsvXgcQ0K9lWqKkWF7yQ0c7GCkiDbsU9+XqgQ+H6+RPvtXjsDc97K3zzVOyH7g==
X-Received: by 2002:a05:6638:2708:b0:33c:975e:707a with SMTP id m8-20020a056638270800b0033c975e707amr25820072jav.284.1657152378545;
        Wed, 06 Jul 2022 17:06:18 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id g193-20020a025bca000000b0033f17259e8bsm326612jab.54.2022.07.06.17.06.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Jul 2022 17:06:18 -0700 (PDT)
Subject: Re: [PATCH 4.9 00/29] 4.9.322-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, slade@sladewatkins.com,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220705115605.742248854@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <60201c30-c755-3cb1-a771-dbcf0e7ad8b9@linuxfoundation.org>
Date:   Wed, 6 Jul 2022 18:06:17 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220705115605.742248854@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/5/22 5:57 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.322 release.
> There are 29 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 07 Jul 2022 11:55:56 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.322-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

Tested-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
