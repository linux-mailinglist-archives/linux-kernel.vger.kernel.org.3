Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AB1C54A76A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 05:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354491AbiFNDHv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 23:07:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355020AbiFNDGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 23:06:55 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8707E2CCAC
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 20:06:54 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id y16-20020a9d5190000000b0060c1292a5b9so5710196otg.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 20:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1WBoyMKdJK/DjIuY3tLTL+8oqQnOCNy38h5HKNxDm0U=;
        b=b1W0BR9JVTB00K5DVW07P2QpAQORYpxGHahkC1B/hpGq8Qmgzs803dXNI/moxxkLpN
         EZpmaDREDZynnCEhx9Y6N+Lud5YE9o11z5tK9tCmxu6ghUITc59NwOZquRBPS4VEe0Qc
         rtfLVAPjBqrNcyyWsHZ89i8fGaHwnnFJfThYY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1WBoyMKdJK/DjIuY3tLTL+8oqQnOCNy38h5HKNxDm0U=;
        b=Gc7Gkj7rYNUvN3Li/5iVR2bpp4xvqerkT7rrnOxuiKwW1abigGq8xy6IsaK9JnuwQN
         BY7YskFWJ3U7ANKsyRunTxV2pBcDQQ1AcceY+dhOgJyu+wVHVPNbl3J+fCHBIGdpLfmi
         RBli6lkEi7gQ9c85VJ+8lHcv+BsqHuDxOYdDqJGh8OC/l7SGqDuuc2MAibLASvh70kDv
         zJPZLHNMwZxeS72XpeTgWn2xMnNlznT9WqkRZ1XCb+fcX352VtH4IHjeFmyOCXp77sZ0
         5qWDTPoyW68DN6wW5gjtroSo6lHRlA0gR6NduiiqS7JUpxHOpdI0+/Dt5z7H7j2ju+oV
         yUwA==
X-Gm-Message-State: AOAM5319BdgTGLlSJfXmCNDcW2fEXWXdYY0pvQnBKlySR4M7tlVrAFOv
        qFfUHGTQPAyWzs/jOqvHjuefKw==
X-Google-Smtp-Source: ABdhPJwg/XEIBfwb/VGufwY+jCoa8y3R4TrgQN8xmJQT5dfxrA23mwoahpKKWJ/i6A9nPzgHo/uyGw==
X-Received: by 2002:a05:6830:200e:b0:60c:2cbb:2fb5 with SMTP id e14-20020a056830200e00b0060c2cbb2fb5mr1212361otp.377.1655176013720;
        Mon, 13 Jun 2022 20:06:53 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id fz14-20020a056870ed8e00b000e90544b79fsm4747625oab.41.2022.06.13.20.06.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jun 2022 20:06:53 -0700 (PDT)
Subject: Re: [PATCH 5.15 000/251] 5.15.47-rc2 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, slade@sladewatkins.com,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220613181847.216528857@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <606682e9-0fdf-0eab-4a14-2331bee211e1@linuxfoundation.org>
Date:   Mon, 13 Jun 2022 21:06:52 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220613181847.216528857@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/13/22 12:19 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.47 release.
> There are 251 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 15 Jun 2022 18:18:03 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.47-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
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
