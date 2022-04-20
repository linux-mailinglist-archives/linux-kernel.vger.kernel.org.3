Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E460F507EF9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 04:39:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359008AbiDTClA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 22:41:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346789AbiDTCk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 22:40:58 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED90737ABD
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 19:38:13 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id q129so629595oif.4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 19:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=rWgc+OLGgaqRanc4pUDKhoEVnq85GoX137OEPhM1wdc=;
        b=PAdiTR0AM6Sd4SX5/scSP3Ik6G6kqetRl8KoD/CFfJ0y+6iLJ5ny/s6g4W6Drhgmaf
         k/V3ra1qAzhrTlWrLuvPodvJGLvuuGjIn0l7cloTHZX6IA4zz39RtFAB08vxbmDix7CL
         0Bn5uk0xffWUylhVCSg4pYcxZ1EUfgnwjwzNNqxzWOXLbqykpdIFMeMo/iPDOSd1FRVE
         pkI5dEkjqTyEKSEA2WxNiD+LqmRZH3/mS+KVXwxY3xyIOuUt/sNe956cFuYxhkusaJV2
         xuoIkIbF66hf6V3o/1ywYeCdxM48esbVlesdh7KDrVFaBdTIesIFDmd9Y5fd7yYVaDiR
         A2Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=rWgc+OLGgaqRanc4pUDKhoEVnq85GoX137OEPhM1wdc=;
        b=3XTa9OXPXof72d48uZFz+g+F0IurZRmbTxjTv6i366innqaNAEMylxa6iSXUQvqXtu
         HX9tdc8yIlWiuYbzod6d0xL/l7cQNwNh73IfepdnIZ3aBbIp2LJ8n9RvUF8cqW5BTkRk
         fDSF0l+sgyefbfSOY7SfOP5hqxwP9N+SrLaR8QerzsKYWsQTxvJZHTl/mb2Rlxk/th/a
         oRAuBARG1EMRGxZ8QbHVqXNgX1YZjc3w5khNRlo+taluCfjxN2QrTpx+Ls72eLX6sFui
         ita6bH5M/JbakVGQCXXCDtQkX+dqCqLx2VPB3+9zRe7aD2oSfA8pe4D2P5GCbK+ReSN9
         RZYg==
X-Gm-Message-State: AOAM531LNl8aBn/2xJ6x8FP3OjXHOhMbyYjqBJgsAvCWJzfa4LIYLeH1
        dwy/a4ShGHqlV9pTVZMNIAzLXw==
X-Google-Smtp-Source: ABdhPJyGQmY8Xk+gHmh45e2p/D/SaaXT2n2jB4Ds+WJ1C7lIP85sqsfrbhQJBPnnjuf5yn7AGB9TNw==
X-Received: by 2002:a05:6808:1984:b0:322:7bbf:aae2 with SMTP id bj4-20020a056808198400b003227bbfaae2mr712685oib.125.1650422292841;
        Tue, 19 Apr 2022 19:38:12 -0700 (PDT)
Received: from [192.168.17.16] ([189.219.73.83])
        by smtp.gmail.com with ESMTPSA id z3-20020a056830290300b005b2316db9c9sm5941476otu.30.2022.04.19.19.38.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Apr 2022 19:38:12 -0700 (PDT)
Message-ID: <392ba1bf-3b2a-3be2-67fc-53745eab0914@linaro.org>
Date:   Tue, 19 Apr 2022 21:38:10 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 5.15 000/189] 5.15.35-rc2 review
Content-Language: en-US
From:   =?UTF-8?Q?Daniel_D=c3=adaz?= <daniel.diaz@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, slade@sladewatkins.com
References: <20220419073048.315594917@linuxfoundation.org>
 <bc25b6b5-d202-18c5-a485-217f858fc986@linaro.org>
In-Reply-To: <bc25b6b5-d202-18c5-a485-217f858fc986@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 19/04/22 18:25, Daniel Díaz wrote:
> On 19/04/22 02:32, Greg Kroah-Hartman wrote:
>> This is the start of the stable review cycle for the 5.15.35 release.
>> There are 189 patches in this series, all will be posted as a response
>> to this one.  If anyone has any issues with these being applied, please
>> let me know.
>>
>> Responses should be made by Thu, 21 Apr 2022 07:30:20 +0000.
>> Anything received after that time might be too late.
>>
>> The whole patch series can be found in one patch at:
>>     https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.35-rc2.gz
>> or in the git tree and branch at:
>>     git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
>> and the diffstat can be found below.
>>
>> thanks,
>>
>> greg k-h
> 
> Results from Linaro's test farm.
> No regressions on arm64, arm, x86_64, and i386.

Forgot to mention that it was

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

Greetings!

Daniel Díaz
daniel.diaz@linaro.org
