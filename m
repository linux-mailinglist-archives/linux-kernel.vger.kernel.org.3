Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D3284D0C3A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 00:48:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343961AbiCGXs4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 18:48:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343947AbiCGXsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 18:48:52 -0500
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78034193D3
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 15:47:57 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id o12so3446364ilg.5
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 15:47:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IopVmLbgsBx+U3bO5WgLGYHgN3jazsf3R/frvDuEvH4=;
        b=J6RDuaf03elhF2pngDWfoDt08Yr0IHdvWHLJtY8lpTcY81aQtr5ZGEL4E7b7jF/WKB
         MTfmy4JOJRxUAkJUgb7qoGdKHkXlWu1UjiqPfyNNhyNekDiPAv/yhgoxg6y6MzN3UIFl
         dgcrW3o64gAHEwyl70inLIGY1ItQnHBjDA2Jg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IopVmLbgsBx+U3bO5WgLGYHgN3jazsf3R/frvDuEvH4=;
        b=ncOr489QrGpp2Y4e2LAG2IvTuWlk+ujHttQeTYIgGU0RykKMnf1VM67Y/Tz3Z43LYu
         n+FQizjZLdChnbcyt8dyhnvdhz2Lc5YG+xAhakjqRfZVNieI5xOwLCcVv5jRLZeGK05w
         z2z3QAZhV0DBoj+2iAqRJSwB34t7Y/7Mw9Ceze6/hdFJpgQqnQWBnE/c7zaY6KuXSvTo
         b9z5HMTUFK+I9W+RiMa1E1Svsiw6FqJYkpG6QZP5mW+FPECRz66IJZ2Ivdps36tpHmXU
         JKygh0SPrtQnFN8ZoelQmgn02amFEI4kYgse0SRCFhe67TjYXfIPET9yOPkLP34A8fud
         pLmQ==
X-Gm-Message-State: AOAM533SQ5xHf3HPq6yzAZ71Ar2XR3wdn5bAgICbf+qYwFkPjfdUt5+a
        34vnTXURZmiYtdgjyu8DBRwULw==
X-Google-Smtp-Source: ABdhPJwH8md1kdozONddjGTGxcpmyBXVUSAx2Xo2Ha2WREv1Q8zbriYWX2doWNvkzuRAXnRjriRRUw==
X-Received: by 2002:a05:6e02:1d08:b0:2c6:49d5:4c39 with SMTP id i8-20020a056e021d0800b002c649d54c39mr4533667ila.168.1646696876850;
        Mon, 07 Mar 2022 15:47:56 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id 14-20020a92180e000000b002c1bfa2a5e6sm11092979ily.65.2022.03.07.15.47.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Mar 2022 15:47:56 -0800 (PST)
Subject: Re: [PATCH 5.4 00/64] 5.4.183-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, slade@sladewatkins.com,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220307091639.136830784@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <605f0706-ee6a-cd3f-7bef-77293096c112@linuxfoundation.org>
Date:   Mon, 7 Mar 2022 16:47:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220307091639.136830784@linuxfoundation.org>
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
> This is the start of the stable review cycle for the 5.4.183 release.
> There are 64 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 09 Mar 2022 09:16:25 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.183-rc1.gz
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
