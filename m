Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6E54558C7A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 02:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbiFXAwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 20:52:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbiFXAwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 20:52:33 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97CF648326
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 17:52:31 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id s17so1206643iob.7
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 17:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RKBDo53UiaJ/MQCGh8BHGjdG6U5tnHcv4dsXdrGaAOI=;
        b=T8qtZW9/xAJaOmu2/ZvLauRYUk1ropg91mIdMjuLaLEF2P3gAx2q6ctyDssxsw0hQr
         20V4WIqFDAjHNWI1aO8v+jnkhsr3RgX5YmcTQSmK/JiPuDFCSLOU8rKccOVBn/Qb7CBE
         z0tXLK5PNOALJ4maaJ6zIESShvBHWAhQeINm0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RKBDo53UiaJ/MQCGh8BHGjdG6U5tnHcv4dsXdrGaAOI=;
        b=EhJdAOgJ+ConpiAN5dfFcXh55DGUc+D7DpIC5YA6/TwqK0nALunAdx37o/qw7ghKnn
         jN/MVocUIuhrVl2L294ft1FJRTIfRgXLBSRW8aqA6n//e2Ak/EnzWHog5dg9zhkDdMQf
         ec7LhMPOgQi7j10cUUhiFE37YoBayzzAmtiecEf0PBQGCd3p/zAhKYC5q+fRTyup6I38
         HrG876utKRLax46TWGMC3rY/mCum9donCZacPAOe7FB+6rkZlnNK+mPkHrxY0zx6DClp
         MVYa8ulbRt/yef81lE6Sf+3Uf4ZGhkD51wnfyT8xI9QxImRMGkWMAYlOGPekJzXptwT9
         j3Hw==
X-Gm-Message-State: AJIora8kEBgJVZep4WG1XzKM9DD4ISDSPI39e9ejwSHzVIoqxvmRzuq+
        FQUOAEqsyOSJkw0NIzgwRXmQng==
X-Google-Smtp-Source: AGRyM1vUCpGwnVEFDHesd3QJRv9pGs65K+AN85opz/yo8lhoL8TFFU+sOCV8+OYbEW9ia8mF7xx3WQ==
X-Received: by 2002:a5d:8485:0:b0:672:76d6:3848 with SMTP id t5-20020a5d8485000000b0067276d63848mr4786181iom.18.1656031951008;
        Thu, 23 Jun 2022 17:52:31 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id a16-20020a027350000000b0033192b7fd35sm404018jae.128.2022.06.23.17.52.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jun 2022 17:52:30 -0700 (PDT)
Subject: Re: [PATCH 5.10 00/11] 5.10.125-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, slade@sladewatkins.com,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220623164322.296526800@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <8fd5e6a7-e81c-393b-7907-258ae46439e0@linuxfoundation.org>
Date:   Thu, 23 Jun 2022 18:52:29 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220623164322.296526800@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/23/22 10:44 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.125 release.
> There are 11 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 25 Jun 2022 16:43:11 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.125-rc1.gz
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
