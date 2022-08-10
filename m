Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65F0B58EE6F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 16:35:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231779AbiHJOfN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 10:35:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232001AbiHJOe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 10:34:58 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 679AB2AE01
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 07:34:57 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id h138so12261970iof.12
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 07:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc;
        bh=zOpFSGb2VJQXNmtIaTiRcV9CKzkjJSm7+ANpt+73aIk=;
        b=ZCv+A/c3FbAETOJui9SLA1d91bZbxLWN+W146M9wCkanQie8OahBPp6mSQecPJalb7
         ce/+pPKSADVm8VqoqtluClC4DyAOI8BkJTfjAIe0A+avwUXlHXULXhF3Y/B1z+aP+f69
         Y74wzaRykIZaeoWyCIPoDV4/+VTn7jCeWPYJM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc;
        bh=zOpFSGb2VJQXNmtIaTiRcV9CKzkjJSm7+ANpt+73aIk=;
        b=2XPMvv3j5HVmZKeoc/uzc4jnlK3q4BdrAcRs6EgWwcTEfYM3XgdrWAj6xrDUvocyE7
         HY/t1mThpRTQYhlhrPI1+R/tX7t0SGYml8IDs6QgSlwsc/MCPInnBldB3wCHM7yvw/gq
         bGzgBO1r0U7ntMG3gqBGr0zKz94PshZJYattmuXi/eQCDuDle1ydz50Pyybgqw6TVm+D
         yUxbNBMMioPDHAeTVsCmA4ABGORhI10umT0NUkSc34DQU+33Uy1ujhIuCAtZMn2kHy/P
         GsIUy1yizbjb0bnlyMgq/Ty1XZLX1MIDTowN4YM6IBOCacG+udCIynkc66FPazfaQmuJ
         OL4g==
X-Gm-Message-State: ACgBeo0S6JeHs4sPXAL2cA2A6unUiFmsEn8d7RkZD44QlP/8goh1ryhl
        yE2oJo4ZjSPYZ8+XojXKnyW29GqkSg9a+Q==
X-Google-Smtp-Source: AA6agR5llW6FcQMaVHqSDbPohi4M9+jjDZz0dt22qqN9xL4PCVT381d8l4dU5KINBrh97Q/WFWzGeg==
X-Received: by 2002:a05:6638:349f:b0:342:fed4:1423 with SMTP id t31-20020a056638349f00b00342fed41423mr7048541jal.318.1660142096831;
        Wed, 10 Aug 2022 07:34:56 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id w11-20020a056638030b00b0033f1fb23d9asm7492040jap.137.2022.08.10.07.34.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Aug 2022 07:34:55 -0700 (PDT)
Subject: Re: [PATCH 5.15 00/30] 5.15.60-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, slade@sladewatkins.com,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220809175514.276643253@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <e583ee1a-5f72-4c85-384c-027c4340ef56@linuxfoundation.org>
Date:   Wed, 10 Aug 2022 08:34:54 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220809175514.276643253@linuxfoundation.org>
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

On 8/9/22 12:00 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.60 release.
> There are 30 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 11 Aug 2022 17:55:02 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.60-rc1.gz
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
