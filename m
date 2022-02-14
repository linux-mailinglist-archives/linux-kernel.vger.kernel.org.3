Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACC994B5D91
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 23:25:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231814AbiBNWYy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 17:24:54 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbiBNWYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 17:24:52 -0500
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E88ED13DE24
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 14:24:43 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id m8so13472025ilg.7
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 14:24:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ogRV7ZSL7SDSAR5mn+RUaB80LZYIK0RrJJ+hPOyIuRg=;
        b=ZIXxLgwBvDXHQWUbbXHQ81y/5BVhla341Wp8m87N2iubaQJ9OBrtnUmcx1J7BSE8ZU
         Pt6jUDt+lZpMz3y/hn26U+yUT9OzjQ3cWK45K1Q4QjK5EEWW3pWBEXHV52JMxgeOLrqw
         yFfhgvtOqfkq3il7yX3JW7jEp8kIAEEHXPtcQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ogRV7ZSL7SDSAR5mn+RUaB80LZYIK0RrJJ+hPOyIuRg=;
        b=jPCFWrTiKEoIcZuM5P0k1ZMIwmp7/Sz3muPJ0z+7yy4QlRdo9WjmZulqw+iw8LJ7/R
         VKjiPSGlmQWl+zkZDelcp0PEqzMIurr0A3zn9puqrsWd3svbg6nDVcJT2kAuO3VreDsk
         4XLHRZK5I/rk21qEVSAAhvWDwyHRWBnydkos4xt1wpieIotnpRzOG4khd8woEZcIVmES
         +daKhiH3jm+YyCD+UB1IidTbwFRI1ddzAvpB2O7yck+vBRPFnFp9dIkSP8oH3fIimfp3
         PSNoTguIdbon3WD7B4tOAhI/KjLxYoH7jI1yTa7Sx1GKZcxfk7vt30Yrdq9DfrIZcyzd
         d2xg==
X-Gm-Message-State: AOAM532SJPPt36aoZVygw4OjTnS+qwsYrqxAINpvL7t7r/6CNbAlawq5
        uRasZy6n5njhxkIb6Kgh+VkRBg==
X-Google-Smtp-Source: ABdhPJy+yRcezzlrG8jzeQ1xoMVYfeFa537j9WWCm8trI6pdLHHT6CAwujU3eZ2roCW+V8HcyuXxZQ==
X-Received: by 2002:a05:6e02:1524:: with SMTP id i4mr661086ilu.150.1644877483326;
        Mon, 14 Feb 2022 14:24:43 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id r7sm14197766ilm.14.2022.02.14.14.24.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Feb 2022 14:24:43 -0800 (PST)
Subject: Re: [PATCH 5.16 000/203] 5.16.10-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, slade@sladewatkins.com,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220214092510.221474733@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <80bf4bea-02b0-5823-2089-cac242950366@linuxfoundation.org>
Date:   Mon, 14 Feb 2022 15:24:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220214092510.221474733@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/14/22 2:24 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.16.10 release.
> There are 203 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 16 Feb 2022 09:24:36 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.16.10-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.16.y
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
