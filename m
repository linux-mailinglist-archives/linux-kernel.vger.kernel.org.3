Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 217BA59EEE3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 00:18:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbiHWWSN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 18:18:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232605AbiHWWSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 18:18:08 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA8E375FD4
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 15:18:07 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id b142so12044690iof.10
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 15:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc;
        bh=wQ3fmzwyWGZmB8Si4qOAM7o7zHBGMl4gnMNNm9SiWLs=;
        b=HOgB3+msLGGbln7GTTIKOTyIhRnr0gCaXxI3xQ4jzTZQVlqxDsnUi27HsXtY0YQF/z
         zAs7ulTGaMbPyncSV6uTcL+w8Ov3zgVBRD0247pDeHaD4b82ToG04LvYQuO/efrvq6MS
         s8sG0oERomR4rDZlsEwjFufjjMzNvF8n9Vv3o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc;
        bh=wQ3fmzwyWGZmB8Si4qOAM7o7zHBGMl4gnMNNm9SiWLs=;
        b=6yV9VoxT9EtGJxcOxJy14saopgCb8Zm3L3RrzRAbEEzQwUz+V26zsKOnxE/4KtpLup
         2YlR6DIby4HyNBZiUWdys3o/YmV0oNWluJEpYYfZfBaYZryLGVbxPLGgKcaL6mrhHdex
         Z63XLnYUXCwXuzISeejLG0utzFdaaCPt8AGnH7QBxxKTaVZQSuRK5jcve3ByLxNq0CTX
         4K/bCBzO+7Bo/IT9TSRVkhsvKNTLeWOr4JcWjPuwovXTLCibiNaRAxyjEkaNucj89xAS
         tFtzauoh3is3giPyS8JGj1kWBNPSZdwe7Z4jHEkDUq8OmzJGpaLZ8SYhj8hPAznHqBFP
         ZouA==
X-Gm-Message-State: ACgBeo2xUo97mJcCxpiMdc6Jv16tiHt3AqMUtC0crGIf6tXRQIifmWPL
        qPyJXNANNkgcR7DRthgot243ew==
X-Google-Smtp-Source: AA6agR5Hz/B7iH+ruknl/ZFgSW36AJ5HASuS2hr1esQmXljIFk9pGkoXZb8LIxSlihVpYuviyYhXug==
X-Received: by 2002:a05:6638:31c2:b0:32e:167a:d887 with SMTP id n2-20020a05663831c200b0032e167ad887mr12637848jav.197.1661293087223;
        Tue, 23 Aug 2022 15:18:07 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id i16-20020a056e021d1000b002df73ca05b0sm334457ila.34.2022.08.23.15.18.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Aug 2022 15:18:06 -0700 (PDT)
Subject: Re: [PATCH 4.9 000/101] 4.9.326-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, slade@sladewatkins.com,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220823080034.579196046@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <884d8d64-5945-d902-b7ea-159ae5f42c3c@linuxfoundation.org>
Date:   Tue, 23 Aug 2022 16:18:05 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220823080034.579196046@linuxfoundation.org>
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

On 8/23/22 2:02 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.326 release.
> There are 101 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 25 Aug 2022 08:00:15 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.326-rc1.gz
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
