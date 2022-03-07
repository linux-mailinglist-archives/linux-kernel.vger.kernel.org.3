Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 276564D0C36
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 00:47:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343933AbiCGXsO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 18:48:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237518AbiCGXsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 18:48:12 -0500
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41790307
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 15:47:17 -0800 (PST)
Received: by mail-il1-x136.google.com with SMTP id i14so12850480ilv.4
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 15:47:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wFI4DZsbiFLf2t6++MBx1IBuCREEkX/q6J/ztKUGRdI=;
        b=HhqkIChgQpNGmcVBzHkWtI2K/7fL83X3uu6Uf4i0sfmSOuhxx630YepyB6TkORM1LJ
         3+8CtL+v5wdP/X11j5LMHqkmawm45k3vW2BjYBy/IzK0cj9nm1iSgQ5J2ZcZ26pef7lF
         fGfd1Qqw38MQ/jimyS84q7VfpqyheqPpRqsFs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wFI4DZsbiFLf2t6++MBx1IBuCREEkX/q6J/ztKUGRdI=;
        b=v7JDIYjWHxqwbq8ztDJ1kk2S+42C8NSuLqZR8kIRyjhnAZuQ85EeBI5fDkGbOzf9yK
         BYnkiBKljh2HqwYAJypCRXrnTVArnqIWybqanOoza9DT+5jrRm0sSZmSW6A8TtB0Yx9W
         Qql+2THV3Mw1rtQXm8DIQQkMyDqpYF7Fwx7d6wRxtuPfU+7BP+2liYxEVsKiDVFzgvvo
         j8+rtI3gEs4wBnwq61Upbtz6al3CVRyC747sgkeNi7td1weRSBKI6oW9RheooAqiC8ga
         EFDijIfalqSeNvqpX2bIBU+ndrfkWurjnFAa+iP7iBy+/tVaanW0q1cJ/Hdq/7MYkzeg
         LPWQ==
X-Gm-Message-State: AOAM531RlJ19hpneBXQ4xOv24780xl3wBtHiMndX+Xx89RDWK9zJq3tb
        Cc02dz3Icbb9XzknZl33T9ksPw==
X-Google-Smtp-Source: ABdhPJwwolXGb75vS9X70gUsgWoCStgI7Pu7MWGNLGYoxLPKoX5Zi0zeas8E45KotCBpO5eJW6LrpA==
X-Received: by 2002:a92:c268:0:b0:2c2:8f59:1cb1 with SMTP id h8-20020a92c268000000b002c28f591cb1mr13287386ild.241.1646696836563;
        Mon, 07 Mar 2022 15:47:16 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id p10-20020a92c10a000000b002c64b46cd94sm1588709ile.52.2022.03.07.15.47.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Mar 2022 15:47:16 -0800 (PST)
Subject: Re: [PATCH 4.19 00/51] 4.19.233-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, slade@sladewatkins.com,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220307091636.988950823@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <065e085e-2761-a39c-1b37-cb3f9f62ef2c@linuxfoundation.org>
Date:   Mon, 7 Mar 2022 16:47:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220307091636.988950823@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/7/22 2:18 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.233 release.
> There are 51 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 09 Mar 2022 09:16:25 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.233-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
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
