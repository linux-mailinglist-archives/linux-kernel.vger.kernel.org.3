Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B92D059AA38
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 02:48:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245532AbiHTAkD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 20:40:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245130AbiHTAkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 20:40:00 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56BA0113DF6
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 17:39:59 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id d6so1436419ilg.4
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 17:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc;
        bh=iBopgMnmoUJvc7cVDH8fqn3f/dhwKkQ8lfdEKBMoa04=;
        b=cLroeU3Ru7UQVtCk9D9W6zQ1lTLBKb+Ud+93k79Yhf+67A5RlOw79Q4+Wy1suVlHvu
         v0U1NKAce3VfxwjRXOHCVSVrdjKpOSYgm+ZiZw8TyPY7gCWv0uGirTlEIq7TPOW5YFTv
         Xrg1uIpWB8pjpVYAG54P7L7KzeLZoPW9YZAxI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc;
        bh=iBopgMnmoUJvc7cVDH8fqn3f/dhwKkQ8lfdEKBMoa04=;
        b=ne41zYzZ88g/OssFWYQdel2HJ5rCEGEensKFnoLSECBVH+rW75MDuMsC3oKkIbN0Fa
         u2XhGS2GLwGLdZQlO/Yx4diTIJnQa6Zr+BxJsZJ640ws9OAxh7a55/nfwTknE+3QHPwl
         nvgBD2qJEY+jSKK7vmppP6ERHH3VCWb5ub6LlmVUT3vgf+I05MZRehkVV1PxXkCQoygL
         bIHfBpf6Oc1Lks7aFGR/bnsASMt2OFlnpcaL9y74CJami77vCjRZLxo547QYIqkZxZ9Z
         E/0kTVevqhrn9xA8CVAk9wtHizrnZuY4Lcj7EwdW97Odrq10bbmrTctHJxXonnzzgSzy
         rHyA==
X-Gm-Message-State: ACgBeo1ZW04HJMnIJZ5LmkMTUAZIdVq7xL6bGu1pkLmFxlb2P9Sr86Ui
        R4V2z3qTSjomPMnqVDqXQGoyuw==
X-Google-Smtp-Source: AA6agR44VAlVKGhzUVWtLo63G30iCyCXxVgQSvLlhP9reqy7ykNJPCUkb8YUgpDvqaY/KAsXWIZm9Q==
X-Received: by 2002:a92:d942:0:b0:2e8:fb76:c647 with SMTP id l2-20020a92d942000000b002e8fb76c647mr4745528ilq.86.1660955998731;
        Fri, 19 Aug 2022 17:39:58 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id u17-20020a92da91000000b002e90d810961sm2157771iln.6.2022.08.19.17.39.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Aug 2022 17:39:58 -0700 (PDT)
Subject: Re: [PATCH 5.19 0/7] 5.19.3-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, slade@sladewatkins.com,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220819153711.552247994@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <dbeec116-a78a-3aa5-0cc7-75d653ad2519@linuxfoundation.org>
Date:   Fri, 19 Aug 2022 18:39:57 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220819153711.552247994@linuxfoundation.org>
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

On 8/19/22 9:39 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.19.3 release.
> There are 7 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 21 Aug 2022 15:36:59 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.19.3-rc1.gz
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
