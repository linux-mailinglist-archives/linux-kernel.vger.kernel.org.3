Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD27F531EF6
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 00:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232020AbiEWW4a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 18:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230467AbiEWW4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 18:56:04 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04428D53
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 15:55:59 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id z16so4609010ilp.5
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 15:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=U9M4N4R4YmEK5KMBkskCB/oRWCV30tvdMAstZxSuIAQ=;
        b=hkKAhBd46OIGNX1hw8tLYF3Z0uiZ37sXkakDy0KuvtGjGNFhaD3W1cdcshGQJxnv+y
         0YGGOU6txAneyCwKfbA9S9gZDeaXk3tFKcjF4KWjn67agPD/X6LYRRByhX272y02dGQI
         pXDc6796pVhmYzcSSvdfF4Jj+tMl9wlxEl7Tk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=U9M4N4R4YmEK5KMBkskCB/oRWCV30tvdMAstZxSuIAQ=;
        b=keDlb4mDXEy7FTVsCMfEgBrw0USSVKm/+JXyTRUIgOBo0Vqa01NceqncpLrWepV5uF
         FQomuCz6AYjzfK2sUQDYRsReOCZl+7ULPka/uj89XRFjGg/yXRVWw1wzaxjWR+sLp7mo
         xcOqyaIBj2sH7hgJO6AJZ8JIY6XyCpJ2gCvyTWie/MlG00IG0Tm9Xdd4IX00SSfnq8YN
         SECROgTJSRJc6xbSr9AcppvBjs6Fa7XrVPsbGJdCRNF4b7MPoBOXg9e+a5pYn77qZAWn
         RY7089YVRr819mXz0LTXFyttFxLacuJDnviAsKktJJ+uZKtxUMbd76uCY74fnwe4uRCg
         FZig==
X-Gm-Message-State: AOAM533uZwaIHaGdNm9u8eFFECW9qJ4Zo/b+Afmeek7xkdGnUpY1a0Kp
        ziHm9UMk9ayiw4l142B9snbcAQ==
X-Google-Smtp-Source: ABdhPJwNE270ms+Sf0ebCfFq/Y8Hj9u92ywJ9OPIMT/NBdiwa0ZMuV8/m5P0bf+KTGFFyMapZ02mCQ==
X-Received: by 2002:a92:ca07:0:b0:2cf:95c4:9e9d with SMTP id j7-20020a92ca07000000b002cf95c49e9dmr12617339ils.99.1653346558375;
        Mon, 23 May 2022 15:55:58 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id p36-20020a056638192400b0032e30badd18sm3036862jal.178.2022.05.23.15.55.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 May 2022 15:55:57 -0700 (PDT)
Subject: Re: [PATCH 5.17 000/158] 5.17.10-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, slade@sladewatkins.com,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220523165830.581652127@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <3e120f45-2ec4-bf02-cf92-2d720143994f@linuxfoundation.org>
Date:   Mon, 23 May 2022 16:55:57 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220523165830.581652127@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/23/22 11:02 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.17.10 release.
> There are 158 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 25 May 2022 16:56:55 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.17.10-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.17.y
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

