Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 879BC58E60C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 06:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbiHJELF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 00:11:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230500AbiHJEKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 00:10:38 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DC9248EA9
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 21:10:36 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id g15so4743791iob.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 21:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc;
        bh=tOJs2UbYWM7GWS5yjBuwhxBXjxYGcm0p2oYEK23R+6w=;
        b=Z+ZVxkq92VkT4KkfjSyztM41Bgwg8ukhjy1MeGfKwlcCsMuMUDI8nBxILcviOSf9KR
         U43CECulePnmyRBt8wsY10zDyV45hwTGE17+vkGFr24qTckOz0itsErLyRQ8FdS3Vjy5
         JJaKWYXBqQW6rgSTBQmpD2QuDuV1b0Gxgv9Ao=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc;
        bh=tOJs2UbYWM7GWS5yjBuwhxBXjxYGcm0p2oYEK23R+6w=;
        b=fuj23A0qwBnSgDxH7bxaiJXr7/FAny4BFIgg3aVk0bU40zCHgON1NDbetF9CsQjFsz
         3co5zqzj/M00yy5BEBsAZUDVWwRzJQEoOx3WfqutAAOJsNVwBk+TAa7i/OXajYrgYSg8
         HPQ34yxRkIF1J1tfOjCJe+5e8xUSE6dcMOOYwrv7vBJALJ6hQIma/rGGlgM4l7nEOdut
         SpI8bM/Ui7eNBBahZHQT6/ToSeQIKyoVKeVI/0t0dYBmNqwqkCr5orKHOj9VJxlHoz7b
         grKx0mfsrRqQO9n1Hvk+XF7+55P6/XsazjUNW2xzmBJgj0M29gEZuFTvV/OPECZz7jVR
         YX3A==
X-Gm-Message-State: ACgBeo0JX97tFOzOa9XQkE3FDTBi2PjNYlE8nxZVia3u5CZjD+bpmQ03
        d9dtzfMMiRKtbRJ323XnhkwIzQ==
X-Google-Smtp-Source: AA6agR6PPkZRmbohs15PJgtqhvNQTH3QlctL2Y7Cceg7hiwKWCJcRwBd6LMnQDtGz1MPqSQf2qh3Cw==
X-Received: by 2002:a05:6638:3822:b0:342:a65d:ade3 with SMTP id i34-20020a056638382200b00342a65dade3mr12224386jav.206.1660104635858;
        Tue, 09 Aug 2022 21:10:35 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id g9-20020a05660226c900b0067b75781af9sm1943739ioo.37.2022.08.09.21.10.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Aug 2022 21:10:35 -0700 (PDT)
Subject: Re: [PATCH 5.19 00/21] 5.19.1-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, slade@sladewatkins.com,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220809175513.345597655@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <b6d8be10-4d1f-0a0d-d6e3-52bd489f7a19@linuxfoundation.org>
Date:   Tue, 9 Aug 2022 22:10:34 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220809175513.345597655@linuxfoundation.org>
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

On 8/9/22 12:00 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.19.1 release.
> There are 21 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 11 Aug 2022 17:55:02 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.19.1-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.19.y
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
