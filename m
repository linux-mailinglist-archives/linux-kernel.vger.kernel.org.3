Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC1AB526BB5
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 22:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384487AbiEMUj4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 16:39:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384397AbiEMUjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 16:39:53 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FB151B775C
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 13:39:52 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id s6so1738649ilp.9
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 13:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AgneOWNLNaDtGXKOaYtAUw+5LQ9MQcrbEn39kRsvLbE=;
        b=ZuykElIEJYI+JQT72JM81djwF7ZE/e13oi+35zGC4JcXbkUH4crZRYYTPW1ZnUjoV6
         t+WInmtMQ/R9Wm6idPbAXnOshJmZguVfcThvWXLDpw+i3pPAOH+5L/C3umcL+qYH3Jwo
         +XuokYsPb7Qg/+s7oigVZ8LOaB/VVZ1CHTQak=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AgneOWNLNaDtGXKOaYtAUw+5LQ9MQcrbEn39kRsvLbE=;
        b=nORNCEwfjH1y1Mspy5xKJyV2Znr0JdQ6D1WFoBxKJhh3yVcBRIQFs78/TOWCaAZeeK
         aA4JP/iSvF4MiiqZjipew/J1iF46YWd+UyYSHoQkP6x+bYCUS9MjtZpkPCNZvimfF4bD
         6Cw1a8QtT17SCzFm0BkHvfutwfE0VApqoVaw4wczS+i+yM+gpzeQymJAUgyW8fihXQ+s
         HkcQJaPYQ+BAxktMVnc8s7YDKh7WFT7DcE/utgi0RuWCpH43qRpNL99h9WrqYwpENkGn
         t7hN00wIoUdeAWaC8VzUSscOGlDCaL2XzIecTjEZ0Vq9LahfFnwzUF7VJb881147oevg
         2wlw==
X-Gm-Message-State: AOAM531skgT69tHQeYS/iDZI0VfU2ffPpNU96D56cMn3vP1fDJ7lYfLr
        oQ3I1hQREfaH5oDFMF8P8AS80Q==
X-Google-Smtp-Source: ABdhPJxGgWVbz+lqrCbqtE50vSWt0/z44lc11y5ayxWpykAO+GVqNyj73+S9FbvyLiPNCrPltjWmSw==
X-Received: by 2002:a92:c54a:0:b0:2cf:41d6:52ee with SMTP id a10-20020a92c54a000000b002cf41d652eemr3431513ilj.257.1652474391945;
        Fri, 13 May 2022 13:39:51 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id t18-20020a026412000000b0032b3a781766sm926820jac.42.2022.05.13.13.39.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 May 2022 13:39:51 -0700 (PDT)
Subject: Re: [PATCH 4.19 00/15] 4.19.243-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, slade@sladewatkins.com,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220513142227.897535454@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <583edb6a-0785-2ea2-cc3e-bd7194149551@linuxfoundation.org>
Date:   Fri, 13 May 2022 14:39:50 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220513142227.897535454@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/13/22 8:23 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.243 release.
> There are 15 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 15 May 2022 14:22:19 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.243-rc1.gz
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
