Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A08E559AA41
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 02:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343715AbiHTAlJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 20:41:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245636AbiHTAlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 20:41:06 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75EC4113DFD
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 17:41:05 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id k3so3070420ilv.11
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 17:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc;
        bh=89UxtBEv+PhhoumjisXfK/1f+Vl1bRyW6NMktPfVdbI=;
        b=gvfCiK64WTAq6dCA7AgFQEAYYtTojisLZFwDVvymx+92txksgGa+Z5PzuTH7FkGUwh
         El/SIDAmPaWQmwWUK/bQ6HAbk+mF+wIvNvOPi9CeKLYSUN5qEPzTa0TFmrcwZTWLUZ36
         Kr7OI5pJY3P2gV7j7DNhSkBSIqpv8+NZRmkYo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc;
        bh=89UxtBEv+PhhoumjisXfK/1f+Vl1bRyW6NMktPfVdbI=;
        b=hA+dYWOX1P310yV3gI+CneUdNXiYJLC6MDIt8S928xN8MdWwjZ9dXxSiqn9fhlL7Pf
         7ANoujtjtuyci2mAmsRwzbDfaLki1CJUGHwx7XbRgiFA9J6qxEfYdgipxJwXz5SnZeHA
         pjGPbdS8ia8syUxbbywAG4Y9e6jctQQG6YEXAdgxIurGdhEmB+MCpQKmZZqobri1ffWm
         lWmedjnNiwOqqMzUdnZefJgR5TwCWlGIQk3h5FjcWFN4JoK+nacLjWHQDzBeEfPZ+9kc
         RwhLvpwB2qRPMgRIzK78ylGV7DvYRI6gtKJpmEWePaCvSe66dxq5FPXlS7vUMbyND4Fw
         sSHg==
X-Gm-Message-State: ACgBeo2Pdbv5JLmPF5KK0CdGCmEbn1KqVBU/HC9apy9rVUBvOppUI1ga
        kK7D2oOCcU+RUpIQcfkw64zMTw==
X-Google-Smtp-Source: AA6agR5+Mr/BT0d0FTkil/2xJZ+c6gchDUvIHYS2oTtGHqiPch2I1u1DqLstrRcJ5s2VXOMwxqA/mw==
X-Received: by 2002:a05:6e02:1d16:b0:2e5:813b:d172 with SMTP id i22-20020a056e021d1600b002e5813bd172mr4848627ila.164.1660956064856;
        Fri, 19 Aug 2022 17:41:04 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id m2-20020a02a142000000b00349bfd5a61bsm43346jah.78.2022.08.19.17.41.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Aug 2022 17:41:04 -0700 (PDT)
Subject: Re: [PATCH 5.18 0/6] 5.18.19-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, slade@sladewatkins.com,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220819153710.430046927@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <6d98fb3d-385f-bb2f-5eb7-fc52cfad112a@linuxfoundation.org>
Date:   Fri, 19 Aug 2022 18:41:03 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220819153710.430046927@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/19/22 9:40 AM, Greg Kroah-Hartman wrote:
> -------------------
> NOTE, this is the LAST 5.18.y stable release.  This tree will be
> end-of-life after this one.  Please move to 5.19.y at this point in time
> or let us know why that is not possible.
> -------------------
> 
> This is the start of the stable review cycle for the 5.18.19 release.
> There are 6 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 21 Aug 2022 15:36:59 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.18.19-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.18.y
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
