Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE8456269C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 01:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232398AbiF3XPl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 19:15:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232328AbiF3XPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 19:15:39 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4681723C
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 16:15:35 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id k7so361490ils.8
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 16:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UZIQOA2zru4TOJh6Rd1jEMj2rbMLZO4hPzwYYym7zfc=;
        b=UKEX7PJwv3X336CoBm7Js/k0kC0bdwYtMCnwQR6hUWsNtK5r1+n1PGfpNRQNAZt76R
         8aOotBOE0VMv7MHcLk+hdT3F2pY+BiGNBvFJPjwYi5xYxiHF/4AUHzLLr4fagI8o4j6e
         nW6BMvXY+FKEbek6pBsKsx40kXXXkFqMQJduE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UZIQOA2zru4TOJh6Rd1jEMj2rbMLZO4hPzwYYym7zfc=;
        b=GaTHfooYzYcuIP/GuOK/hDaRmqZcsOsu6mGOtoZxW19wekHgDehFValBxTL9AlbqHo
         ZZwlS2whcgF26dy2o4hcCXJWaGY4yDmepYAdW4Ijnzd1pzcqGN/Kl5CStC0vai0M31Z/
         msa3mRC3BE8jQgSOrH513k+W5L1fvedN81apXbVMC4TcdNIX65Y8bJTYfWmY6a53Wns4
         F4jz0u08DbepTaqCvQBHGSosrXlz2RanAMu+/AAtsAssj/1DsG6iwBBZSZ38/pqc+6uu
         3KshAhN36YKhRL6uhU6xlqeSBR1N9l0y8w/ppeTrZ7tLM9S8WdDEx8Y1jHczFmgCrsJ6
         weMA==
X-Gm-Message-State: AJIora9+zAHtryUE5YSpUmLZaCSaVovRCD5WfihkHKgEm0glC6AuwM4g
        Ra1rTiqm4FKHChKJ4OQwZXVTJg==
X-Google-Smtp-Source: AGRyM1uxFHbzxPJY55IVREIVB+Zd32U+Zby5T/7n5HTKGJtCI/eeNqzyg1QzQuIvdOIs3gRjOx3bUw==
X-Received: by 2002:a05:6e02:13d0:b0:2d9:4396:66ff with SMTP id v16-20020a056e0213d000b002d9439666ffmr6325418ilj.224.1656630934679;
        Thu, 30 Jun 2022 16:15:34 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id s9-20020a92cc09000000b002d1c94b7143sm8352507ilp.39.2022.06.30.16.15.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jun 2022 16:15:34 -0700 (PDT)
Subject: Re: [PATCH 5.10 00/12] 5.10.128-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, slade@sladewatkins.com,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220630133230.676254336@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <623356e9-f636-583c-b42b-9dc8f02322c6@linuxfoundation.org>
Date:   Thu, 30 Jun 2022 17:15:33 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220630133230.676254336@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/30/22 7:47 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.128 release.
> There are 12 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 02 Jul 2022 13:32:22 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.128-rc1.gz
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
