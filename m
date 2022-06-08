Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EC4D542337
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:51:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231854AbiFHE47 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 00:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231970AbiFHE4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 00:56:18 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EDB61053CB
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 18:28:15 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id a15so15517699ilq.12
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 18:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WPijXcOAJ6XYRcZ9ka9sQPzTk0BtKIqM1P1ASLgj9js=;
        b=NycSVoWJnqmcDVER30H6N68HhCf7F3zW3dbmLA5zlCuKMgs+Ke5AL6KamFUFCo5t6B
         0BI2xXdkAYKZxiZf1F2PcW4CAwzqmsfIatlOxQpx5nwSAbJNnsP71H5mE2Lyuc7OstaO
         Ur7psqSPUVZcxg6NPYypP9zoCE0Yo0kg0Sb0o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WPijXcOAJ6XYRcZ9ka9sQPzTk0BtKIqM1P1ASLgj9js=;
        b=U96yUoMyThjGlStCiRdH5RZ0d6e+L94qGtke+Wmkiap/h13Pqq5ahNRXZsCWv4hy3Z
         QCPNjGTo/vialUPlubHy9oI/CO7K6zyDtVWFqA/rj5BjxraxbRjAJHPEnJSQfp2Wn16L
         2OkUoh/qXYYYlyVnZPOMIR5dNF39SeLMUEQ1Zoi/z5EWVEn+PFhKmBRBbSmj9tahPKGK
         1vH+VZAn3QP14uxPV+UycLwBzkOxvF9hpDRf6uWqpaoR09TYuw9aPpXmCYgQSruBjZHM
         XeOiuShzPddGfEv5SfO/fL6g9YjtB7ODTIMTo19B8rc3YAenuW25Hcorrf9J3HXwnvbq
         54gA==
X-Gm-Message-State: AOAM533w4ZZNNFL0hOF0BfSZtvsrBEG2iML2HmACG7yCSFqE5CV564lK
        hdcx5xn6KpbWbM2U5ed67eRZ1A==
X-Google-Smtp-Source: ABdhPJyu8ZhzJOL7Nf0dJbd8DBUHgX6vRBd/wZg+VhAp+dX48qSeGtA6/DJ8wgy4CWcUQI9GSWDF4A==
X-Received: by 2002:a05:6e02:2147:b0:2d3:b134:7e5c with SMTP id d7-20020a056e02214700b002d3b1347e5cmr17338819ilv.17.1654651694637;
        Tue, 07 Jun 2022 18:28:14 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id q1-20020a056638344100b00331d764e5b5sm1107695jav.97.2022.06.07.18.28.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jun 2022 18:28:14 -0700 (PDT)
Subject: Re: [PATCH 5.17 000/772] 5.17.14-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, slade@sladewatkins.com,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220607164948.980838585@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <e75d88e8-cb08-a69a-87ce-0e93ac9f923f@linuxfoundation.org>
Date:   Tue, 7 Jun 2022 19:28:13 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220607164948.980838585@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/7/22 10:53 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.17.14 release.
> There are 772 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 09 Jun 2022 16:48:02 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.17.14-rc1.gz
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
