Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC55C522959
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 04:04:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237756AbiEKCDm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 22:03:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236853AbiEKCDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 22:03:35 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B68A4EA33
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 19:03:34 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id w130so1170019oig.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 19:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BPuZwTRAcK1aVkTrzfu5XlgmJIljuYkBZ8h1rOImJvY=;
        b=UqMFCT5RvQf1Ng0SBW7GbCqkvjEcnBHcUPPh2jyDahwpGHF6kEG8px8vXRGDtvG0TC
         vaRhA5ZM6aOuiZQKll9lXCL6lIYykyU8tgnnZveUi9Ptl0lgJva0rVjY+ehjgDWl1+CU
         8zYKmlebtYYpIWNfTewoyQNIxADTvAFxS6Tx0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BPuZwTRAcK1aVkTrzfu5XlgmJIljuYkBZ8h1rOImJvY=;
        b=pNYKqP4BzUUnTCn1wIcVXV1RYEsZI+gwWmL+Su07Jw5Pxk2clevSIdWlqpe1gvTyZl
         GPIJmeyMiFHJyIqSaL3bKzMX6PNNTY4ctdiAUbUrqFUbxOolA+Ru4yOsorm5R8wtM+8W
         QYOVEL3Z0tn0SGXcMOxGY/ExLnpJDQ5Kz4dhlrgANjWmXdKetKgqi5bX2RQ9qjAahupd
         JON1o9xHxqwcVGC8Pwxi8dDCHSh+uR+uyQaQi+TNtZeMMqrUimfmbuRZHuP/lhnoiE95
         T0ro98jg/8G16ZOw99fSTlKmrh1OM4A34pv+BpVViir+IGQlnBFbhbnklpTAj+/s4eYQ
         flbA==
X-Gm-Message-State: AOAM530bqM0/de8cZfkZWSS7Sn0WqJX7uK8AgF5Nax2x0NJ4LEquJdO5
        DTEqhaL5e4kWWWRaPQ2pwUz70A==
X-Google-Smtp-Source: ABdhPJx11vYt13wso0aL0+8rQRAQBpnD7dhPwcTNssJVCfB1F9Y69OIi7K9vDKnBhgSpPUE5HFXa5g==
X-Received: by 2002:aca:62c5:0:b0:326:b067:ac89 with SMTP id w188-20020aca62c5000000b00326b067ac89mr1355127oib.281.1652234613444;
        Tue, 10 May 2022 19:03:33 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id 63-20020a9d0c45000000b00606ad72bdcbsm333502otr.38.2022.05.10.19.03.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 May 2022 19:03:32 -0700 (PDT)
Subject: Re: [PATCH 5.17 000/140] 5.17.7-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, slade@sladewatkins.com,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220510130741.600270947@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <7cd5c77b-5ee4-e2ca-0cb7-0f25646b50a5@linuxfoundation.org>
Date:   Tue, 10 May 2022 20:03:31 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220510130741.600270947@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/10/22 7:06 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.17.7 release.
> There are 140 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 12 May 2022 13:07:16 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.17.7-rc1.gz
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

