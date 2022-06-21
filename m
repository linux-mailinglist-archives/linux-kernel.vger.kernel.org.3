Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34CCB553E21
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 23:49:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355311AbiFUVtQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 17:49:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354793AbiFUVtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 17:49:00 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 924121EC5E
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 14:48:59 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id i25so18789529oii.7
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 14:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CmYrR18Vbp+hD5lpoJpqjoKVHvWQ6PR78xsIP2vimpg=;
        b=fvDEuDGmIFhHVq01RSHI0aGdl+N7i+wZMFP6PKEbbHbsaTC3oUJpBnqTMTR7WEYQHq
         PoDvr9gApZcgFvOtvHGRXELneP1Q1MYKuepR6Jwj264Z+ULGmq6ON76IJ0FNaJStUInS
         mUGvpaa5aFoGk2N2VTiGZfOMJy5oC/cRsFxek=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CmYrR18Vbp+hD5lpoJpqjoKVHvWQ6PR78xsIP2vimpg=;
        b=dROGrK+c5Q08oDby/JbaTE1mkQCL+HaNpTGH6csc7WpZc7jDGzK30+CG/3NbI/9ZHJ
         PoOS2h3OV8Eq/EUgkSoKz/38v1/Tv6R8IFsCxhK9+5KU3IkexWcGIxDKDpT7QaY9qoaF
         4ZUE4wLlPMWOlsJkDad5Cs90fsCVnYdwxnuiNW7usMyOmZEfynlv5UokHx9EeRGp8asM
         7hZjFrFUlcBKpek6TAK9toVXN9hlsdQIP245RlNsc5fcXzxEpV3SRCCTKOtcqg7G+Wfj
         pmCZnIpl81dkSSzRbM1Wh5Y2h+Xx7vsfeonSv9YU6AaRAi/FGWBl0+4tGAmFRIOXncvq
         W6PA==
X-Gm-Message-State: AOAM532zHOSoRVM2fI4L/pjjnNYtT4P1Pm37DM8hvX2I0S0bxqOlEo3V
        /E/GnPSt8MeU4KTGARV5vXyJcA==
X-Google-Smtp-Source: ABdhPJzQWcN7ZV60EmWgqoltsZAXpAOfXfpbuA9jdjvZaD0mGVuGcQCrw0o4C0gG0/Ib428QEvTIeg==
X-Received: by 2002:a05:6808:158e:b0:32f:471a:ca7d with SMTP id t14-20020a056808158e00b0032f471aca7dmr20524569oiw.236.1655848138923;
        Tue, 21 Jun 2022 14:48:58 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id p6-20020a4a8e86000000b0041bdf977c6dsm10455363ook.31.2022.06.21.14.48.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jun 2022 14:48:58 -0700 (PDT)
Subject: Re: [PATCH 5.10 00/84] 5.10.124-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, slade@sladewatkins.com,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220620124720.882450983@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <ee785f78-df43-ebd0-ae3c-9b1f742d1988@linuxfoundation.org>
Date:   Tue, 21 Jun 2022 15:48:56 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220620124720.882450983@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/20/22 6:50 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.124 release.
> There are 84 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 22 Jun 2022 12:47:02 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.124-rc1.gz
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
