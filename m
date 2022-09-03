Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 007AE5ABF51
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 16:20:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbiICOUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 10:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbiICOUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 10:20:42 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B79C5C9C0
        for <linux-kernel@vger.kernel.org>; Sat,  3 Sep 2022 07:20:38 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-11eb44f520dso11585526fac.10
        for <linux-kernel@vger.kernel.org>; Sat, 03 Sep 2022 07:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date;
        bh=rpEmRJ1mNkHbfkRJnjyamGSfVQCR30g6KpgPEcvcyuM=;
        b=ZORo2E9awlrODtIhY4o0f7kedepDXVi3CtO0qcaIqcr9WRHxRmSz1vtXiLvZP6K91S
         5ygZlfqplvyL3o8RlNvlCps/mPwP18AzFKwNCaqVILMvOCGhciQKS91XpiYhzl87QLWO
         Vd78k+0U1Gq7wYlPTsRBc1ISlQx7PEh8QQabw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date;
        bh=rpEmRJ1mNkHbfkRJnjyamGSfVQCR30g6KpgPEcvcyuM=;
        b=bXIxSMb3RqIoGUMv2InJt7smCH57LjioSNzSsxUasHsXr4+8Iy/ii3zjb76dXze9CE
         j9IOPayN9BrJF+QQoZJRLaqu2w08iwtErXl2UF7G3mSS/YtR76o2/8lEi+MHWehcTI1h
         X1Cd0pLb1sez539NXojOBofGe0Jka7lmXyhAFye4V/V+ZuI4pW3t44Ko6+rgYLMjXWNx
         8YIGh2kRRdqP5Z9FbCPNk1R0TcMl7y2oF1ZAyGd1YsElQfTRCiidrEIRLAOGVL/F6dJx
         g4bjZxLDyYaFEUiUYJunOnwKgguO4Hg/bPHwQVXc4UwOSvYcAAfXbzw/47YKxLbmiG7i
         Lxjw==
X-Gm-Message-State: ACgBeo2Oy69BDedD5MiOULc5QAUC24kPVJdYgnw9RNREypYxtVi++jDu
        7f1PUGBJ6lY6N+mR0hlByT/wRQ==
X-Google-Smtp-Source: AA6agR6sv6e7lTJlwQk82+32kkL8yIevjQbilZS9V9OXWx4FIBJm7KPzzRXRJV9Veuf4B/vR7JrzSw==
X-Received: by 2002:a05:6870:2392:b0:125:7a80:879f with SMTP id e18-20020a056870239200b001257a80879fmr2002751oap.174.1662214837584;
        Sat, 03 Sep 2022 07:20:37 -0700 (PDT)
Received: from fedora64.linuxtx.org (99-47-93-78.lightspeed.rcsntx.sbcglobal.net. [99.47.93.78])
        by smtp.gmail.com with ESMTPSA id a7-20020a9d5c87000000b0063736db0ae9sm2381178oti.15.2022.09.03.07.20.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Sep 2022 07:20:36 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date:   Sat, 3 Sep 2022 09:20:34 -0500
From:   Justin Forbes <jforbes@fedoraproject.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        slade@sladewatkins.com
Subject: Re: [PATCH 5.19 00/72] 5.19.7-rc1 review
Message-ID: <YxNisrx2UIztutHK@fedora64.linuxtx.org>
References: <20220902121404.772492078@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220902121404.772492078@linuxfoundation.org>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 02, 2022 at 02:18:36PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.19.7 release.
> There are 72 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 04 Sep 2022 12:13:47 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.19.7-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.19.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Tested rc1 against the Fedora build system (aarch64, armv7, ppc64le,
s390x, x86_64), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>
