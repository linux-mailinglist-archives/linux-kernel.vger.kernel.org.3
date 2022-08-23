Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 248BD59EE44
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 23:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231366AbiHWVdk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 17:33:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbiHWVdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 17:33:37 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5E9428E1C
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 14:33:36 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id 62so11966574iov.5
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 14:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc;
        bh=R6TsXaMTO4DJ/Xfoyooc+Twnt1v216EBvqAKqT4U61k=;
        b=VI4DtEtoIO2A0moQTASUBYqZ4kF10YrwwglSzvjVHHkyoKPoCnBxmZjGRqGYVqctfi
         ViK2Sv/zBcE4o78B7zORPr1wVYbHhGEY/uHWQKIXEwzuYbGQYLIrO4xAumJ1FU/otS9S
         33inElQ/RcwvXZXfjfdbpZVMmsQ1SkWgdr2NQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc;
        bh=R6TsXaMTO4DJ/Xfoyooc+Twnt1v216EBvqAKqT4U61k=;
        b=DGUmgKohZc0In/QUAQlk9/hpwzt2Cozw4DBCivji1LqcPdrgZAz0CpPbpSn7ZffPyu
         PXDa8AA041MDQz0Ayz8VzKxYJNot9NwKtW3DQSq4UsPjTxy4UqcELVrEXjVX8mSa6DUy
         N2lRqg+2AFeV7W3+P8l0d4f7uc2nBmQ5Aei4qsWwtRIhWDrVAv37iKosFgSlYpxIsHSn
         ClMYzeJ0Ll17L4sRO9h595/e8f6nKY8OJeZ/PnfkVqh0vxY/jjzGHLI3C2XNIKRaWTXX
         qSW8o4/5LTngGJOg17reGjzH5i7D8d9Ga9pGK7262trxyHaXV8meYyPA33zvO62p6bKB
         SdjQ==
X-Gm-Message-State: ACgBeo1zW8d7lIecxtl6rxD200Hwj53APTHXK4bWQulUzuiGHyznBs2m
        RsXAnjZUtQ3XcjYf/DIk4EKrJw==
X-Google-Smtp-Source: AA6agR5FcOVRzM+xppGAFQu940G8xmdl4E3SmZX4kKyQu7xIHfEWpCxM04twI3KsKbbmyKi66SJWtQ==
X-Received: by 2002:a05:6638:31c2:b0:32e:167a:d887 with SMTP id n2-20020a05663831c200b0032e167ad887mr12574201jav.197.1661290416118;
        Tue, 23 Aug 2022 14:33:36 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id f3-20020a02a803000000b0034a0475fb33sm152132jaj.154.2022.08.23.14.33.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Aug 2022 14:33:35 -0700 (PDT)
Subject: Re: [PATCH 5.19 000/365] 5.19.4-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, slade@sladewatkins.com,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220823080118.128342613@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <aefd4879-78a5-e142-362d-f2b8ebb9e29d@linuxfoundation.org>
Date:   Tue, 23 Aug 2022 15:33:34 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220823080118.128342613@linuxfoundation.org>
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

On 8/23/22 1:58 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.19.4 release.
> There are 365 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 25 Aug 2022 08:00:15 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.19.4-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.19.y
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
