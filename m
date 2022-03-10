Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 585C04D51FC
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 20:43:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343632AbiCJTfC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 14:35:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343630AbiCJTfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 14:35:00 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7223414F2AF
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 11:33:59 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id e22so7686096ioe.11
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 11:33:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nXm/nE/YMI/NAjMX3gPi0lN+FNjqkd+Pu3WVT9wyz1c=;
        b=JLbdaOl9J1cQ7ir1hXzFhm5gIIzdVZ3HkGy5/69s9V0YAgUkpbtMq6+xeSls5qgVnq
         WARm6xvzO153pfbizzhr2QDkaDiMMuJlWMR9JtVpqvhuv7Bu6rtjHq4yZ4QF1ogL13v7
         WAb8PUqPlUFxi3NHPcZj4JhfsVE7gqPvAID34=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nXm/nE/YMI/NAjMX3gPi0lN+FNjqkd+Pu3WVT9wyz1c=;
        b=rgoY+Xv0FvS4jkThAbajR67/J/+QFChXG5JpFZ7dCtpM8a4q6e/qdcwa9YyJpMH9SV
         uAfJ0+FRR0Q/nVAhJ+4O0CQ3tZMQrESPRGJCH+zJFTsMa1Lzc0iOX2SgVW1qSKiinC/5
         T+27jXNvwyOmx3ELLN+aLWR1Qqm+wmGs3uvR3AEc5MExrA+MtU8al66ToVkKjkEegJdB
         tgF4HUxmzUkGPm12Q6Zx9pefrNvh3/Qhh+2E6/WKLsblwB8Z6HbhOCG/RvIuDI4rzO5x
         Glb7b5ukvPGozErOVzboPO144U9Gg1Nw1+vkrUS1PuECoIW2H+8FLiKdHoIuHG8Iy2Q+
         zX9g==
X-Gm-Message-State: AOAM5335S8IEjXsJ3dpmYcDNlAHrvln3X0cmitkImmQSQIaa/YwXJje7
        +grXFPJ8B3u21dAyQM8XKjTmBQ==
X-Google-Smtp-Source: ABdhPJxBJ0IxCOx3EfWOWZvLJfD3weRVU9D+Y6Mr1oTctaLenTURO3kTlif7LpJ5+yoFMrOEZVNJUA==
X-Received: by 2002:a5e:d809:0:b0:645:eb2b:d173 with SMTP id l9-20020a5ed809000000b00645eb2bd173mr5002507iok.54.1646940838833;
        Thu, 10 Mar 2022 11:33:58 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id w10-20020a056e02190a00b002c6637e1a1asm3248778ilu.47.2022.03.10.11.33.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Mar 2022 11:33:58 -0800 (PST)
Subject: Re: [PATCH 5.4 00/33] 5.4.184-rc2 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, slade@sladewatkins.com,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220310140808.741682643@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <a9fba17a-ff22-f55e-198c-d697fdbaa577@linuxfoundation.org>
Date:   Thu, 10 Mar 2022 12:33:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220310140808.741682643@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/10/22 7:19 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.184 release.
> There are 33 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 12 Mar 2022 14:07:58 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.184-rc2.gz
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
