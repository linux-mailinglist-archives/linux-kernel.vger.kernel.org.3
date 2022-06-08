Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6437354238A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232132AbiFHFAP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 01:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231970AbiFHE6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 00:58:18 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCD982584C1
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 18:29:25 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id i201so11791699ioa.6
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 18:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=g/FyTJSdUmnIw8e0BMa6AuXeqzIW/H0uELplCSxIKYI=;
        b=WjwYVUwLrvT6SvyNkyxcsXhXmLjZb00LOh6ljURgUxzDG8Cn+yn9BkKr6OD6O6191X
         snwXgYG5mkDrpi2X+mhfp4ixpim4Shn5seCc2xe4eDEqQSRmuRa5Mgo2caG5/QzmReZK
         T6W9ebEu9jgkUG9AwDIQgK7Vf0H9l+xNgUBXg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=g/FyTJSdUmnIw8e0BMa6AuXeqzIW/H0uELplCSxIKYI=;
        b=nSb5U+/dQmqOKdO3NBwwHjxsP1oOA/gXgT7bEQgJTdLpa//i9LTWNv8Vl6laXQ7lId
         Tsip/k4+28qdz1NHISBAJnRdq24HkvWPDmI1yoOUKDKBUdo95a0gwk5tXA9MnNXP2hiU
         yik8WEuBSmvDlUvNDRswaxovGpGIgrcJTnNACF/hikU/QotNKcPiMltEquF7J+wZqsB0
         J0wUIc6GQuRBYjHpHlZn5uzBP18ZbrMjXPhvx86qOe+fwVDCbZWZe8j7P2PVeyAUPoBs
         lklGloa0KCyo0Yw1ycNZEJIBhkcB2B0YdJaXzTiIdZUcaZgyrP6czlTX+UmIxlTsXUaa
         EjtQ==
X-Gm-Message-State: AOAM533LUgD1FK3z5+/mSs2upXxsJae6obw7GZj+/mjn/tDIrRsg7Ccl
        1AhT7+7pNjMLFmlIYAcWdfVezQ==
X-Google-Smtp-Source: ABdhPJwgHgS9a+2m4fzbod5RRpMFPyIWrF465Y0yhQ+Cc2sf+vRXsDSx9fp3Xi+hOnYE64g4wqA/Xw==
X-Received: by 2002:a5d:8348:0:b0:668:9cc6:1a52 with SMTP id q8-20020a5d8348000000b006689cc61a52mr14694337ior.101.1654651763747;
        Tue, 07 Jun 2022 18:29:23 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id k2-20020a5d97c2000000b006656f9eefa3sm7358056ios.18.2022.06.07.18.29.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jun 2022 18:29:23 -0700 (PDT)
Subject: Re: [PATCH 5.10 000/452] 5.10.121-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, slade@sladewatkins.com,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220607164908.521895282@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <7f0e1a0e-a6c0-abaa-f390-4e1adc78d14c@linuxfoundation.org>
Date:   Tue, 7 Jun 2022 19:29:22 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220607164908.521895282@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/7/22 10:57 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.121 release.
> There are 452 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 09 Jun 2022 16:48:02 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.121-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
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


