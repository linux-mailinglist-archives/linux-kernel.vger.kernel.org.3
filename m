Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 914B2553E1F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 23:49:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351703AbiFUVth (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 17:49:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355944AbiFUVtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 17:49:25 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D064E237F6
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 14:49:23 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id u133so525464oie.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 14:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AciGOMHSo91l/zULa32RoyGu1yMCXURr99BEX1ZS+sM=;
        b=dPXrT3ZKojAszoujc7NafFBfBOa/VjzbPoKS5UvHzsEYh00FMQK0QVuef3SWC8Rhk4
         jzdJesbno2GqYu3shYIRVuzo7LCfV2IRXCEtYiKPFueNSKGi/WLbhBAegiFis3yDPUsG
         z9jpS/OnOzzlzMJ3o+2lXe7AcoJQg7rVpGAAw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AciGOMHSo91l/zULa32RoyGu1yMCXURr99BEX1ZS+sM=;
        b=eYQzvaBO2XKaTayCSStLuFnZGh1Xf18cEKD8kkMF8mb/NQ7uYe7MLSazlC+nPkPKrl
         T5RC9b1SW+KwXz5ey/wA27LfzRkfKS1Zzow39vF2dqUiIKlWQGcFMr1snaqU778K4En1
         qDit/lFO4UuyjLX6acTIGj/BBbHDiVen1e2H3Bk0o6JPvX8mNpBt5OIZGUlkiFVPWptc
         S4GaGDsvFeVR9+IYcUhiLk/PtyDGKjlUwX/zDAtHLc4HA4Y7bjGdyjRdr2Tna+iAAJI5
         meRP6qLhM9PA7M8ZWEb9TSmj6VtYfQCDtZHB/+0HdwSVfCRJxckFRvAdYzlTqsvpwRBM
         msbw==
X-Gm-Message-State: AOAM53174qNLRwFCstffL/w+gVFwznukeXnE2zi4eb2Q5E/H1rKW02BD
        hgGF9C7MCgEr1bytpc8NG51xcA==
X-Google-Smtp-Source: ABdhPJwF5cOKO8iIZcA/os0vQYnZRwVFwxFG35Y9JZtOCbBHHdgd6Zmx7EdD256fFH4z9TQ2Z1+3TA==
X-Received: by 2002:a05:6808:2d6:b0:32f:7da:60b9 with SMTP id a22-20020a05680802d600b0032f07da60b9mr20789175oid.249.1655848162762;
        Tue, 21 Jun 2022 14:49:22 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id q9-20020a0568080ec900b0032f7605d1a3sm10181915oiv.31.2022.06.21.14.49.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jun 2022 14:49:22 -0700 (PDT)
Subject: Re: [PATCH 5.4 000/240] 5.4.200-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, slade@sladewatkins.com,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220620124737.799371052@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <63d8620d-04f2-82a5-622c-57f007902319@linuxfoundation.org>
Date:   Tue, 21 Jun 2022 15:49:21 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220620124737.799371052@linuxfoundation.org>
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

On 6/20/22 6:48 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.200 release.
> There are 240 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 22 Jun 2022 12:47:02 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.200-rc1.gz
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
