Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F196359EE67
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 23:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231494AbiHWVqJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 17:46:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbiHWVqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 17:46:06 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AF4D5B05C
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 14:46:05 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id v125so17608342oie.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 14:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc;
        bh=LewCaPyJI9P19qoX2T8Kq55PTU9SlmcYgInl9k2Dz6A=;
        b=FGaYaFonhdWRVSSWqOPCtTAEYXefho6W1zMIlqnYW/u4WvAU9QqXe/LPDw6q/MTaag
         tyqJ+IKQKx9gWxqL+kRDrQZ/FCNJc7A/7tB+IIlrLkXPCEhAwJZWsaO7uCE6g9vupHKs
         hPN/vD9Xyniq0n3xfn1lhgpvxbc2eRzorx1tA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc;
        bh=LewCaPyJI9P19qoX2T8Kq55PTU9SlmcYgInl9k2Dz6A=;
        b=t59hp0t/wvK4FdrgN6VA8N33rYXv06nvJ4+7GLXxbmwKJqBBqBm/CtH8dktH1F5Ehr
         snM+44nM3m98DIir3J3qcFtBr2qJIYj4QtIitFiIw77KB2m5vZoWhj71UNB4pG71qfi/
         to8vSbgiT28zy7cWzBImm+Nq2bTcvmLmDa5qYfKPWQNE4qX9w/IxS+8JJOP6KPTSUIkR
         kqDPWapaU9Vx8qdgOdhZ6y8W9fp9NwCl85IdN3KJJ5PYN2ge81LnLc02Pm5p4EdAMkLp
         I2yaMdKNMFt6NwgunoFt+vw8tpNuFG/8klgzfarNOBL98MAoVh1KOyYdaAoM6mFSpAYW
         9t6g==
X-Gm-Message-State: ACgBeo2/+J63KdGit0VTITfF9anMb1ubdJxCtjF9K53UmatvJ6jzaZbX
        4cIAfQ2f7jk1PtQUrJmk/B7Bpg==
X-Google-Smtp-Source: AA6agR4g/YuLrYSyqg8DTPckNgcDMaPWiVU+upi7EOPWjX5lrVS7EDCX114PWkjhfSW3Vv9lF/gQIw==
X-Received: by 2002:a05:6808:1b20:b0:343:678c:451b with SMTP id bx32-20020a0568081b2000b00343678c451bmr2112495oib.171.1661291164766;
        Tue, 23 Aug 2022 14:46:04 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id f36-20020a056871072400b0011382da43aesm4184347oap.16.2022.08.23.14.46.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Aug 2022 14:46:04 -0700 (PDT)
Subject: Re: [PATCH 5.15 000/244] 5.15.63-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, slade@sladewatkins.com,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220823080059.091088642@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <c663d37d-2005-7be5-fecf-ca71d640981f@linuxfoundation.org>
Date:   Tue, 23 Aug 2022 15:46:03 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220823080059.091088642@linuxfoundation.org>
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

On 8/23/22 2:22 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.63 release.
> There are 244 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 25 Aug 2022 08:00:15 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.63-rc1.gz
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
