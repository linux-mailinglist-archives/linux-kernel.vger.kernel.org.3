Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 382F4558C78
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 02:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230405AbiFXAv6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 20:51:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbiFXAv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 20:51:57 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFFA84FC6F
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 17:51:55 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id p14so521808ile.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 17:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=g4pOoymBhHyhIDt9FGb0OS6Qy+GhATekwTtxqRdhVrw=;
        b=J9T+rSDzageM2w494blPtwwxt5djSB4b3P3w8OTjcLBmF05hU6yTnYW6kGy4vJRkVk
         52Ef+DlNHgAA4dUXCF/DwtDRmsRF/cy6hy6zMrVZbetuFOFutXNoxN0DTnuofOwBYiHH
         9bBm6+S69DsNCnL1WOOAKRQyH00RHkZGiunqg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=g4pOoymBhHyhIDt9FGb0OS6Qy+GhATekwTtxqRdhVrw=;
        b=Gen1roegJQ8UYFCVT/SSbJMBPOA4QEcG3s56MwdoDvBnWKk7wQ05+jPl7uslKju0vL
         qsguMUcf32GoyoyNStctFGY3gMtujMjy5w0QjOGzjxx86p2hYWETHJkyZPfCYxMmuW3D
         2JTjqvHYc0OPF8L9mq+YOorqgeCTLZJxtrOLAkWHVaDheZqPIOYzBByKHS2TRsSPLrQx
         DDHqbyaI/6ngJgl3VA2P973OtD7GFhlD4Ff2eZZ+vPSDj8WbHCJvxMCVSvH1Sse0x+Xg
         lywDKt1rKSCMW8TYElRAE74XxQfU77EhQ6WVDPlGnUKE0G2OIImFTn4C3igr04zb87tI
         6/uQ==
X-Gm-Message-State: AJIora/AdYOAZQYNEfX2Jzwor44SG/5qlzyHA8KXBZQ2gR0RQGMNxjQW
        u/ORL0ho9/ServCfoAphLQHtFg==
X-Google-Smtp-Source: AGRyM1u6mKw8CFRfGe/uohz/Nd7hESlhmYZ/nC0RLLrXs5uITs8MApyEBE/HsniUek3l+Jh7yWIWXg==
X-Received: by 2002:a05:6e02:154b:b0:2d3:d112:5a0a with SMTP id j11-20020a056e02154b00b002d3d1125a0amr6944325ilu.131.1656031915263;
        Thu, 23 Jun 2022 17:51:55 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id g6-20020a05663810e600b00331f32a48fdsm432591jae.11.2022.06.23.17.51.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jun 2022 17:51:54 -0700 (PDT)
Subject: Re: [PATCH 5.15 0/9] 5.15.50-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, slade@sladewatkins.com,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220623164322.288837280@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <aa09e18c-3272-299b-f2e5-7b0b848ce1c8@linuxfoundation.org>
Date:   Thu, 23 Jun 2022 18:51:54 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220623164322.288837280@linuxfoundation.org>
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
> This is the start of the stable review cycle for the 5.15.50 release.
> There are 9 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 25 Jun 2022 16:43:11 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.50-rc1.gz
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
