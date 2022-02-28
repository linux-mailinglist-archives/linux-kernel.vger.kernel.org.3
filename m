Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 205064C7C4D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 22:43:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231159AbiB1Vnu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 16:43:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231148AbiB1Vns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 16:43:48 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40F11B7DA
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 13:43:09 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id r7so16360014iot.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 13:43:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=N3bTi7StPD9Z37LUF0dbiA5Am6aahum+WGOyEHxiu/8=;
        b=Bw4yjnPMN/d8dlR+nAiSxg+L2/KlP1pGlm631hBkgg0wU27V7zgbARvh9WG+Nw5NV6
         kiyFkz/Uh/cBXdECB5mrx6XH6riDOcSvvvfh7lB4/nfGkqNnH2ucCbIBz2TzWSiN82GP
         XTeSJpaUErVZY42tH04WhcARf9OVjVBpqcU3o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=N3bTi7StPD9Z37LUF0dbiA5Am6aahum+WGOyEHxiu/8=;
        b=LUCqnfxjcjVDHuKLSI4gidE20q4NH51hFk6/ZL4OViyG8XAwMvutTLLwOnr9T43sWb
         6YTq+fdXkF1vA/42HfnAuGYDYhqw21kI973bxAJu8MRwFGsK+ojFQ25vJ/b9g1xgnyPX
         VQBMTYd74NpbT4Z+0QQXtv/EoJj2Q5qlU/rMrEMG36cGlawVISnDZbqqn3Ag4lV7YszB
         TeVPP9PmgFnP6FMhUFWURDNVh/JTOduhoWEr1gcxu+6QPRf5N9GaWxMDNAAR8rz9t8z4
         r78Z9SGmTCD3wb2TMIyJr07J9YJ/FZhOUp5eJ0ZkLzX2TVhTYF9phyKIQUWCn+XJ7Aes
         hyAA==
X-Gm-Message-State: AOAM5338FgdhXwPPHsHHY87AgIFaZFi+TSX5Va7t0r1JLyx4jTv3H98R
        SpY1gwOxeNEpsriPtLgIUhnFYg==
X-Google-Smtp-Source: ABdhPJx6ZF2mMMohNfcIGk7oBik5z3Ylafjr8wOvsWChDJHa3ix1GlOUOLfne+tx6KX5nuWzIvwK/A==
X-Received: by 2002:a5e:9817:0:b0:641:5b49:b8c5 with SMTP id s23-20020a5e9817000000b006415b49b8c5mr17317961ioj.179.1646084588629;
        Mon, 28 Feb 2022 13:43:08 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id e21-20020a5d9255000000b0064160848e5dsm6253056iol.52.2022.02.28.13.43.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Feb 2022 13:43:08 -0800 (PST)
Subject: Re: [PATCH 4.9 00/29] 4.9.304-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, slade@sladewatkins.com,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220228172141.744228435@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <e6aaea09-4316-3389-909d-5b606f67f2e1@linuxfoundation.org>
Date:   Mon, 28 Feb 2022 14:43:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220228172141.744228435@linuxfoundation.org>
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

On 2/28/22 10:23 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.304 release.
> There are 29 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 02 Mar 2022 17:20:16 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.304-rc1.gz
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
