Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BA554C7C39
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 22:39:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbiB1VkL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 16:40:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230409AbiB1VkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 16:40:05 -0500
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F56914ACAD
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 13:39:26 -0800 (PST)
Received: by mail-il1-x136.google.com with SMTP id x14so5969705ill.12
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 13:39:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=u2hcEqvS2ri+hj4wK7m5j+GZD1iFdgFVUYMsbbdH0yE=;
        b=HUC0n2UL0b+y5nV9QzUZ90OfyXBhB2RuiHDwa6a0oTGcYr5Rw0G+CefK7/GD0nVuF/
         eC18PhCDLqTWy/u8mhpcQGREO3jAdbgFK0qE/opyhhokBC8pKTOo68tJaarQq7vMhryr
         jqSIKo4pxzOnejaZDchXkDRQFSfsxV74Y3Jyg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=u2hcEqvS2ri+hj4wK7m5j+GZD1iFdgFVUYMsbbdH0yE=;
        b=NR2R2cUb+lfBvf51JLbRP+1hJAfsivvWZLmaeeIV4n51RdRtLNsbXCbd9bvAHjOmaH
         omvPz1/ipKg+mxWh3FHi/uqpw4rsBK6dvlamILcvA+h62Ck6DOt3j5j6+m0m9NAbnwtr
         vnDWZnf2Q917LETZZDwhea8NNZDVuSRXLTrglwWJUxdEdz7nuyPT5Zh/er/vW5Nlq8y6
         kUQPy3A+kM/KmeQd9Kg/oYFrqLLBMjYsEwEgqPBwSfGzLG4/uyCSVFVf0Bj09BBghY2U
         lTltiKMwljbe+eYIOVTL5ng7TKQuWjfxf7DZL4dPZlTaOi+I4rLFCY2aoM8Tgk4d9mgS
         3lEw==
X-Gm-Message-State: AOAM530q6ZfwSM7L/q2c0ZWZFVIHYtGe0mSuQrYxoAqHnj7R1OQXVZPl
        GZb3Am5fwkZdW6Mi31VcYfEXbg==
X-Google-Smtp-Source: ABdhPJxXd2/BJhlqzN76Nb3i5AVuos3AwMYKydTAzn7+QwcDqgRmH1E0b+e0BMW745Dw5/gHXPuFjQ==
X-Received: by 2002:a92:cb44:0:b0:2be:33b0:2a52 with SMTP id f4-20020a92cb44000000b002be33b02a52mr19063851ilq.142.1646084365861;
        Mon, 28 Feb 2022 13:39:25 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id n198-20020a6b8bcf000000b006416384c857sm6222912iod.7.2022.02.28.13.39.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Feb 2022 13:39:25 -0800 (PST)
Subject: Re: [PATCH 5.10 00/80] 5.10.103-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, slade@sladewatkins.com,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220228172311.789892158@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <d031440f-ac5b-f934-4342-fb37e8f6d653@linuxfoundation.org>
Date:   Mon, 28 Feb 2022 14:39:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220228172311.789892158@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/28/22 10:23 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.103 release.
> There are 80 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 02 Mar 2022 17:20:16 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.103-rc1.gz
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
