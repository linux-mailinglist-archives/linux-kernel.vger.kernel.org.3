Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AF9859EB3D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 20:40:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233592AbiHWSkQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 14:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233274AbiHWSjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 14:39:42 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C0238A1E4
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 10:03:04 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-11d7a859b3aso6316042fac.4
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 10:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=pfd0C35RkQpyUtj4YjrtP/Q1PJsPUtf4jxykVR2NvGg=;
        b=hu56OGpHMvZgj2LQv7ccNQdMdWe90SB7g1Cgvl12xcq3KZxyN5chRUxd5KoH4UP5Kp
         /L2mNB3p+H0LEENPUZLCzCjZnNNwvStUpGXKakejl7LfYGkygGoCghvALI8HGVotJtzU
         4oM6TU7hX5iJjt51D8eo3YJgPi4VWERlRTxPE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=pfd0C35RkQpyUtj4YjrtP/Q1PJsPUtf4jxykVR2NvGg=;
        b=uXxUtqtqBhpPznTil7rehVK969hBP+F4gX/NdXHCxIEiJkK7jIcku6RdRKmlzodosl
         kOEqF+76ggxTX6X0FIGEyhrX3PkaL9mKW0Og8ZcOaoqyZ9YVhs+tHGbE7rayoyb3Q6Ct
         82zHVDRRAnkeUNuXQbPU/b81SzZZGAgD78A6r6lRTxpNGDcYE3epErX+kDC4AsmJz6AY
         RR26FlU4Sh9gZj+N+hfSV1EAQSo0V6Hld4PP23NdOtGotDHxGaLeneax9PyBpbdLPXgi
         3/Tl58uU2bvwcgDreTeZ6f/xUuqgvwZfYzo15QTmdgfNXtFk7pjAwATBumzUCPVmvxl/
         tEvQ==
X-Gm-Message-State: ACgBeo3oAbpmWhvx04Pfz/pTe7c7ps43RK3GeVaR4VrcJWF32cZfc1+R
        npGboHet670JKft76KgWmcXh7A==
X-Google-Smtp-Source: AA6agR6Usunoac8rX4W9gd9nSrE2gKokur83l8SvY4yHHUFiEcDgtKMZyS0PgDv5Wpj6pfJU43CZHg==
X-Received: by 2002:a05:6870:d69d:b0:11b:b658:2352 with SMTP id z29-20020a056870d69d00b0011bb6582352mr1819275oap.268.1661274182303;
        Tue, 23 Aug 2022 10:03:02 -0700 (PDT)
Received: from fedora64.linuxtx.org (99-47-93-78.lightspeed.rcsntx.sbcglobal.net. [99.47.93.78])
        by smtp.gmail.com with ESMTPSA id u7-20020a056870304700b0010200e2828fsm3854828oau.30.2022.08.23.10.03.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 10:03:01 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date:   Tue, 23 Aug 2022 12:02:59 -0500
From:   Justin Forbes <jforbes@fedoraproject.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        slade@sladewatkins.com
Subject: Re: [PATCH 5.19 000/365] 5.19.4-rc1 review
Message-ID: <YwUIQ+Carf1zPWGm@fedora64.linuxtx.org>
References: <20220823080118.128342613@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220823080118.128342613@linuxfoundation.org>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 23, 2022 at 09:58:21AM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.19.4 release.
> There are 365 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 25 Aug 2022 08:00:15 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.19.4-rc1.gz
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
