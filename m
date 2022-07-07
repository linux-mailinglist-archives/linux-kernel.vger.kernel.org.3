Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31FE45696AD
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 02:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234626AbiGGAAu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 20:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234577AbiGGAAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 20:00:46 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B7202DA91
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 17:00:45 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id y18so15434026iof.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 17:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vznw20ylo/oPgaF7mRf1/U3Zbr5N3zAqVrSkbulF/yc=;
        b=V9hDvwROCjPX+C6R5oEgtSGo0ouHydzzG4Bq6xVSk72kofRyZf/rsK4i8982guV6zg
         UP/eMqW5rYeyF9jJ1DHWFKmetqu6p1eWdZPpUv+Za8HwR619gCyxgN3ASHbtFMYi52TF
         Y3Qs0+lsaUrM1CEu0ZgFo3fu41GHtcTwsUX8w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vznw20ylo/oPgaF7mRf1/U3Zbr5N3zAqVrSkbulF/yc=;
        b=Xw3uUvQrNxw0Jaja/ol4/7YTrDbCtviJJoCoQb42xctFcSNnTy3Vf5bEWBsvYHthL6
         /wFjjWGq9btCETSDGghG3h6bYqqBVP0iWo9PkkGr6H0L70H1n5zPnjTxl6xkJTXo3jDS
         E6UNd5dOFsfTD2RswkKlSo+RLpJ5kept31UfysRg+fIHl7RZFhJ9Hy/R4b74ClArlj/q
         3blHeepK5nVNZu5hrCbLnoWDZCExKMUuSrA+UM7oxeQsuVvG7dRnxigLMsXtx5ay0iev
         E7gAo7azOgtE6pMUAdadx9nje1rdpCn0oHAJVPMSzclLC0VxWg6hI7YAweLdHQBNBzZR
         KI4g==
X-Gm-Message-State: AJIora98CEJqgEMNUKHvzc2ZMLOCr6lKOAJynxITQlI1jhZp5sVOamlI
        KEnfoVUjG4N+QLiGVOSyEVFtbw==
X-Google-Smtp-Source: AGRyM1t/vmMhUrDmc0Oy+awh49RenWwNh9LI2T7h3qj65fAqYwLGFqSB7Pv71oM2BWXnUafmXP33Ig==
X-Received: by 2002:a02:cf34:0:b0:339:e4de:6cb6 with SMTP id s20-20020a02cf34000000b00339e4de6cb6mr26020492jar.241.1657152044317;
        Wed, 06 Jul 2022 17:00:44 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id z22-20020a5e8616000000b00674f8979801sm17453822ioj.0.2022.07.06.17.00.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Jul 2022 17:00:43 -0700 (PDT)
Subject: Re: [PATCH 5.4 00/58] 5.4.204-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, slade@sladewatkins.com,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220705115610.236040773@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <a15b3a49-7ccc-4705-42c1-b181e6f5267b@linuxfoundation.org>
Date:   Wed, 6 Jul 2022 18:00:43 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220705115610.236040773@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/5/22 5:57 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.204 release.
> There are 58 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 07 Jul 2022 11:55:56 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.204-rc1.gz
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
