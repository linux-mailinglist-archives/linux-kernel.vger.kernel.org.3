Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDF50531EF3
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 00:57:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230431AbiEWW50 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 18:57:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230289AbiEWW5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 18:57:22 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2632B9CF35
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 15:57:20 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id n145so7224502iod.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 15:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JO9RXZ5r7JJ72k/OlBzJTwI9CjOnwgPfl1Ze9DhDT/A=;
        b=HBLLEtl0wpLma5BSt/ZWnuIqFMX49PFLEoN28D1oZn6FRuFJv1mDVB6BbPkICFr7s0
         u5W8JsGjYLKPfPXTigDwg3ZOEPCXuJeKdfUGJYWsxdrMfOQ5kcVZVb5wSzqY7QxESC1e
         +czHuv2HLV0V2To0ZqFpvfbt/9wLCfuaYaDZI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JO9RXZ5r7JJ72k/OlBzJTwI9CjOnwgPfl1Ze9DhDT/A=;
        b=l9agCz9XBNsPG5dc+Fb25xWy1Uru/GAw1NDpZnJ/+acbRUitsywnsMmxvbTCDBdgmS
         RoAoZq9V9FixlEBE5BMVfYXZb4WKTqm8CrJP2CczKamEVXSVrW7HEpsyl8M49jBT/uas
         r9UqKzxi8/0az59GH2HEYvKbOGzVVraHM6GBvUT8fsv3FkWN31dy6uCZYNS3X6ZN+JxZ
         Nl4isccbqFT+VBjMeJbhlG2Aha3xnWoSQ0FiZz4/Lp8JvXVSA1J13OzhX0UBQuD1Udkw
         oJsw9+zsiSN75s/Y/zsTxu4emKR0k0RLJZ4jIGix5hTTvENtG/QqxeHBm71aNPe4l2/B
         AnUQ==
X-Gm-Message-State: AOAM532kcEDOwqz4zEp0Ea8vdW1Arh347Ag6IPKZvkfBOb+tnRHdhN6D
        T88q0LY8VlCXXHCTQMIJMvgncQ==
X-Google-Smtp-Source: ABdhPJwcVT7uZVAPeYu/QGSpUcd4Jav2o+T29wuakeeuHPwl59F3Km6qPAU1gYeG7KDLlU+SFBeR0g==
X-Received: by 2002:a05:6638:140d:b0:32e:bbb4:a1c with SMTP id k13-20020a056638140d00b0032ebbb40a1cmr4989797jad.57.1653346639571;
        Mon, 23 May 2022 15:57:19 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id y14-20020a92950e000000b002cde6e352c1sm4127379ilh.11.2022.05.23.15.57.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 May 2022 15:57:19 -0700 (PDT)
Subject: Re: [PATCH 5.4 00/68] 5.4.196-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, slade@sladewatkins.com,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220523165802.500642349@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <9df377d6-3272-4791-01c7-f62e752cca04@linuxfoundation.org>
Date:   Mon, 23 May 2022 16:57:18 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220523165802.500642349@linuxfoundation.org>
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

On 5/23/22 11:04 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.196 release.
> There are 68 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 25 May 2022 16:56:55 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.196-rc1.gz
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
