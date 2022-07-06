Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15A6A569695
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 01:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234737AbiGFXwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 19:52:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234794AbiGFXwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 19:52:06 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFE4D2D1C7
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 16:52:05 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id p128so15443640iof.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 16:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Iyluj2dtd58+hkHx6sNP9yekyC/Ah4724InV/sfcAHg=;
        b=G0YuQcXeDg5AEz7YmkdmeCk+M72+kANZO5KayL+kD3BB1r2IQZZ29798CFbb8qxeY3
         lUTOEZQHIhCbD5iGr1k2fm1w53M0JXHbF2O+O1joElXzhuJpFjfnM4H3lP1NBv9IuXCa
         xngUbGyrNZOs+ZYR9xd+AAikisrh8PZivpQBM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Iyluj2dtd58+hkHx6sNP9yekyC/Ah4724InV/sfcAHg=;
        b=6GMXbZp70OJACHgbw9SuPoKCCcXuAUISre8UjUAEP8vtWHvA4WUwCRIjVlLE2MUIhm
         8ARbLxUBfSTx0kZ/xQ4k2bd2CfLlsNI8Qr2CEMH2vwhWriJw1sz0Z7alAkRi2dUx8Qqf
         FQtH7O/wOlbGbvaUJUpM4DhhB0qEDzl7To6dB07oug/sQvYxmF7SstyU0AWrDAPgBqPI
         I6fTYrU8wslgRfJRDk8DArrZ9uT/eR2Ap2nfm+RgtufUfPWAy69enHekmmgt6Ap8W5Wy
         waYZmy2OPA8WovvX1SQsDHooqYWzQA6kzaHImm6D8saUj7Y2v5L8rzV7kmjMNpPKib6p
         utkA==
X-Gm-Message-State: AJIora9ZbmtgetyTT9zPKK57cukcFq7HAeiRBO9lQyM5dyWp7vC4os/2
        Z9Geustofi2fm2XiShUvWaTTlg==
X-Google-Smtp-Source: AGRyM1sVYWaLaK2hckfKaEh7XCtU6FcHj1sJiOqPs9PfkiWKLrJMuWhia35fSWp49sJblxjEPInwPA==
X-Received: by 2002:a02:cb47:0:b0:339:e7aa:2f8d with SMTP id k7-20020a02cb47000000b00339e7aa2f8dmr27575169jap.234.1657151525280;
        Wed, 06 Jul 2022 16:52:05 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id p3-20020a92da43000000b002daa3e1fe85sm10534845ilq.58.2022.07.06.16.52.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Jul 2022 16:52:05 -0700 (PDT)
Subject: Re: [PATCH 5.18 000/102] 5.18.10-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, slade@sladewatkins.com,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220705115618.410217782@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <969e2541-f7eb-1be0-6aa4-a41312ac7106@linuxfoundation.org>
Date:   Wed, 6 Jul 2022 17:52:03 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220705115618.410217782@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/5/22 5:57 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.18.10 release.
> There are 102 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 07 Jul 2022 11:55:56 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.18.10-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.18.y
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
