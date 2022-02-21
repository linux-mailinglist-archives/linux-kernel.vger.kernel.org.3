Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 967BF4BECAC
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 22:38:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234922AbiBUVia (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 16:38:30 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbiBUVi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 16:38:28 -0500
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08131220C8
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 13:38:04 -0800 (PST)
Received: by mail-oo1-xc2a.google.com with SMTP id d134-20020a4a528c000000b00319244f4b04so14867561oob.8
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 13:38:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rSMekkNgV07OeG1Q4zV//P+VvrW2ICKvEfaT3G2N8Og=;
        b=TVVAwqYlvY1nux/0Oz6D3GPWpsP1trEmYENm5c7O6ymXXvMRQktY8hIysEYU6XIYmO
         jGQIQL8ZRJ+nauQMjsngWoe8DaDqn3r6ZGu5mGtZR8OIsXDMwmniMUUBEV6tmKM0pO/z
         ywh1koL/MYygLzjmKVZ1Q19KlkFgVwFKqWi9Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rSMekkNgV07OeG1Q4zV//P+VvrW2ICKvEfaT3G2N8Og=;
        b=P+bAUvcRn9UGUX2FxW0wDbGDs/C0Ga+zF8PDkdHa1XteeN21gJMDtBvzzPSbZDW4gb
         UzLQtO+GdUKH/9vhg+q6meEZr3HK5zixhxG0K8jQHBTZMQlpd/sge4gKUvX/IsO4dmmW
         +rtJLGlYw7opcHotUDwEaBcxP+3Z42U8xe2mvuLRYsEt0q+M/uQCIp9I8fiYid32r3L0
         vZLQwJoR9bJjQGK0hGe78kSftuVk41WYpXeAU49K06812PcmvdhWudYr1M1pBMnjDgmh
         z1NpX7rOh2yF0V8vyjP9jI9L0aY/yT+LEA/M4gDhqVeACLapUvDS9dmJJH1rMFl2O+2V
         myJA==
X-Gm-Message-State: AOAM5331ygnG8d1heBqEAdBo4iqlA21FWPf9dZm1Vyypim4P4ozLn3ar
        LAVxLGBG3RmVCQ5lKrvMBWbSXw==
X-Google-Smtp-Source: ABdhPJwZAhN+/Ok76e+Taodwc7SO/2pwnchYRO+UDuEBTsUyD+9vsXmRTuL+PKlEF615OOD4kEQFEA==
X-Received: by 2002:a05:6870:1b06:b0:d3:d1c2:8420 with SMTP id hl6-20020a0568701b0600b000d3d1c28420mr335255oab.305.1645479483294;
        Mon, 21 Feb 2022 13:38:03 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id q9sm7343270oif.9.2022.02.21.13.38.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Feb 2022 13:38:02 -0800 (PST)
Subject: Re: [PATCH 4.9 00/33] 4.9.303-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, slade@sladewatkins.com,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220221084908.568970525@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <43ebbc71-c249-7d93-7b11-e69eaf2c5554@linuxfoundation.org>
Date:   Mon, 21 Feb 2022 14:38:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220221084908.568970525@linuxfoundation.org>
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

On 2/21/22 1:48 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.303 release.
> There are 33 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 23 Feb 2022 08:48:58 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.303-rc1.gz
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
