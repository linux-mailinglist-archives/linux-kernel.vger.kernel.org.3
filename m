Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9F7155E219
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:34:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240134AbiF0Vvs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 17:51:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240041AbiF0Vvr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 17:51:47 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D3C95F45
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 14:51:46 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-1013ecaf7e0so14607278fac.13
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 14:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LZHuuxgfEbwv99ilanlRMuttuOMS0caQfooshPgsBHM=;
        b=DOySKO3RyH93mBOdjySRTEFCPq3VgDtkaK7mXW02kYdk/1/ywAnEci12LnVf2ERlnD
         eGZGeiRtyQ4e7JW80cer5n89l3ToJNqWIwRAxnQEuVTRgG0nX96tRQG5OloVikIsIKxJ
         RezA853vdnADHuuX89bn5puHOlza7sD8YBMKI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LZHuuxgfEbwv99ilanlRMuttuOMS0caQfooshPgsBHM=;
        b=bucfKBgo3bp9MGV1u8elYQLw+WUxuX21/luGtk4pVMNU8pr39i+wzB7SJUmy1r1q+V
         oX6lYZ3jVrJAabL4l13ULoIA12C4T8Oj1c3ic+U6RdbBycGo0vGo3ODSCHDVrHemO0hj
         oPOu18zTjnrYwjA4r2ZMxrAyXsL9jljGkYMwkcz4bdOg/lPec5uiyZN55nR7GGW1soLE
         QA56IpmcCX5h6AXR+xu384/V56JHJonp43QC0w4lQptpjHasJ6cYIwHabC9i3rzMlF+d
         ACkN8hXmKItO4LL0BEZDg/O84l/ZyEgMw5+qQtJy7CuDeu6ByQ1ow1Tel95W4WPh+ld4
         XXxg==
X-Gm-Message-State: AJIora+D50wZYUmmrApNXLrOvBKjKtHmRRRK7qlFE9hkTotL8NRB87dD
        fF0IRliMavO8XJsBsxhWtu5CdQ==
X-Google-Smtp-Source: AGRyM1tynDnW76FJ/XYPTpAY6tjSJ6sQP9QovPELP4T2kCUlXA9qOtxIpPXn8libGjikx1RPTmbJQg==
X-Received: by 2002:a05:6870:a926:b0:102:820:1277 with SMTP id eq38-20020a056870a92600b0010208201277mr8636008oab.77.1656366705490;
        Mon, 27 Jun 2022 14:51:45 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id 14-20020a9d080e000000b0061691239049sm6769501oty.60.2022.06.27.14.51.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jun 2022 14:51:45 -0700 (PDT)
Subject: Re: [PATCH 5.15 000/135] 5.15.51-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, slade@sladewatkins.com,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220627111938.151743692@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <1191a156-d9ea-1858-0588-c9395026eda6@linuxfoundation.org>
Date:   Mon, 27 Jun 2022 15:51:43 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220627111938.151743692@linuxfoundation.org>
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

On 6/27/22 5:20 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.51 release.
> There are 135 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 29 Jun 2022 11:19:09 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.51-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
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

