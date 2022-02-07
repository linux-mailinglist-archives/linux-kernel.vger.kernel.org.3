Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 578B14ACB54
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 22:29:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240168AbiBGV31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 16:29:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231607AbiBGV3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 16:29:24 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BEA9C0612A4
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 13:29:24 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id z4so12278450ilz.4
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 13:29:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jOgA3pSSAKNdGgRKEE4AjEam+tqusyVtFE0cVMEfM10=;
        b=Nva5TpWxQ5v79ciD7l3O1KNjet0TxpPDuMeNxWEt+nkWapiWoQCkOm6mYiiB7BoWG3
         +vIpaY9l3OueN4Aq0dPAUlkDgrU9KZTRwGshMITWX8nuNy79aRfChyr+HaASdCGMb0Y3
         iMsygt6b+LgwDJql8RZQ7rwVa/nur3nvYMvII=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jOgA3pSSAKNdGgRKEE4AjEam+tqusyVtFE0cVMEfM10=;
        b=MlCslSa2qxfgkP9dJXeAMzPfD4IYieS4bKpBm1of0vNMG+IZfYGOPOmRI9DsQuSRJA
         XVImMYPDQYJCKr4rQn8ie8UO6DSaO5JF7d+dyU0vYdOJmPhzQK5qytCmsWjCWGFjHmOA
         RQv64s6UiuwjyMJv+eWuwsN/VZ5CkgChS0nsHCls0WxomHhsQ4FCluyL/SpKg1vRAhkT
         xoDGYHk8ZYtFiE1SMXj12xcJYMYUSlbAcGmgPxD97U6EJdBuH6Dhss6vKYQgdSM7MXdn
         7r9o3wG0cr1LwxS+oUgWl89crDZJzQZuxAluLtOwOXaqiRAyEtuzwRVBy4Pdmradqp5y
         ai7Q==
X-Gm-Message-State: AOAM533e04b8ZSO6uXAvIzl4XCakSIPnspwiTMchNa236E28g8ncI4jg
        d8+l4GV+OXzuYf6M37ZRa6ndOA==
X-Google-Smtp-Source: ABdhPJwbWx7WJrn+PczkXfnSNrY216m0joVsgirUQj52qH9YUX4vBM/r9ao4+kBGtJq1/K3aPcjmXw==
X-Received: by 2002:a05:6e02:1489:: with SMTP id n9mr685956ilk.313.1644269363703;
        Mon, 07 Feb 2022 13:29:23 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id c12sm5020450ilo.70.2022.02.07.13.29.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Feb 2022 13:29:23 -0800 (PST)
Subject: Re: [PATCH 5.4 00/44] 5.4.178-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, slade@sladewatkins.com,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220207103753.155627314@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <f8e14a61-42d3-972e-0511-4457c7273b41@linuxfoundation.org>
Date:   Mon, 7 Feb 2022 14:29:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220207103753.155627314@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/7/22 4:06 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.178 release.
> There are 44 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 09 Feb 2022 10:37:42 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.178-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
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
