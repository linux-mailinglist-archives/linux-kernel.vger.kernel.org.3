Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A37FB4ACB52
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 22:29:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239463AbiBGV2h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 16:28:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239402AbiBGV2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 16:28:36 -0500
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF5D6C0612A4
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 13:28:35 -0800 (PST)
Received: by mail-il1-x135.google.com with SMTP id d3so12246435ilr.10
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 13:28:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZoPNcURKuiyBsfuMCsxFRvD+FdDOMPSZh378YCQdWew=;
        b=OGfUdsmUKUncc+L/NCjGB4tMLmfOP9i+lOscyLtUhOqDdfLLcMemwr53vTTK+aPxYs
         AntX75ynFwE3yp/HRU8o8arCFYuGRyQHC7E7nkmwWXNrVTMzwE+5pyJI1dJioNCRyVFV
         x5EUP0G8YNsOOmpwQsqQjybQo8Bj95Gy4y0aA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZoPNcURKuiyBsfuMCsxFRvD+FdDOMPSZh378YCQdWew=;
        b=g9n8S9uYwKgXtpAQO40BKe8i2r1gaBhAypFQB2u+V5QZjF49vSqHzxz7sUr6ehhw1q
         iDtkrTeyHxGTCpHFbkYvog2vubEEfVKILIGz59N0v1Ly8lw6r4kFM29NJCzry2R3PXw8
         M5HvAVrUvS5CHbpdXbidDQZ1H8Zw/et1TjdRf0H77GPfNZa8nwRJt98olYR+pZsBMgbg
         13dLU/XVpB8oyU4tx/nPB5N3oMUYYE3ZbVbiliEfB2E1ceyaCznWXSzLpYFuWeqYLmi7
         ftjwjKAER1z3moK89Ucxkyh1m6Q3rgNZeIkZ0pt9jSk30kn1aDHvYfQ6xY4OLG3vQTHr
         vXTg==
X-Gm-Message-State: AOAM531RATWGjzVCRI+gev1Lk/PqAYvXjUwsS8xIuTXmA9bzEZDH3R2x
        gLn+x88lspnqRXznsYfFRt7RYA==
X-Google-Smtp-Source: ABdhPJxK3aX2uHbIcGdwR8aV4AP7VMok1KtzstLPRL0Es6DC2dkHg2OW5pgEDMrhE8UOPQc9CA9SQw==
X-Received: by 2002:a05:6e02:2145:: with SMTP id d5mr687033ilv.57.1644269315305;
        Mon, 07 Feb 2022 13:28:35 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id l1sm6430838iln.29.2022.02.07.13.28.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Feb 2022 13:28:35 -0800 (PST)
Subject: Re: [PATCH 4.9 00/48] 4.9.300-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, slade@sladewatkins.com,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220207103752.341184175@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <70b389dd-a26d-d09b-9028-f20d44630e18@linuxfoundation.org>
Date:   Mon, 7 Feb 2022 14:28:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220207103752.341184175@linuxfoundation.org>
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

On 2/7/22 4:05 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.300 release.
> There are 48 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 09 Feb 2022 10:37:42 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.300-rc1.gz
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
