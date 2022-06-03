Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16E1A53D3BF
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 01:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349547AbiFCXAm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 19:00:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244659AbiFCXAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 19:00:40 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 901455710A
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 16:00:39 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-f2a4c51c45so12445446fac.9
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jun 2022 16:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kBvfi1BxQjAKFqWT0+hwPhstcKDSCnM0PpUhSzvHoLA=;
        b=FjjniqyNCK+sFvyKNnSTDInkvEHv9NGw3G0mNg64FWZSGAKZw5u15DQ/htoYdIwqh/
         HPbDXR25iZZXfykZqVakUVqH9WAu8aBg2uDaf0xnHoxM/4iOwNIJgQSxeKzVqnmjBVek
         R6w7ujMX9+J5MpuDyNnwW6UkfdIZ8AJyqCKKk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=kBvfi1BxQjAKFqWT0+hwPhstcKDSCnM0PpUhSzvHoLA=;
        b=n6m5Zn1HmDdKUw2S320BknrzoRs5PmXSIGvFLnlDYfXZXJOkulFCDhy8GrIs3a3Gpd
         UW367b+Ssn7iHRZg/8ZXzojFXX1BA+s6Qg+gTAnv0GHwXpTEaRs9w8K9Zrtp00tdB8qC
         n5qpbgyJocxmx6yQb1Mj+ltX3DYWHBm0ZiK4/y6VEtoiGZgENftV3DaIDO5wcVarZns5
         mE+MPWlXPjy2XkiOgZiVGFcpBYxk6+6j31oYh6Kl/RAq+FyRctrMsmkzIZUOF6Fv4Ftd
         Amxs1tg8UKM8O1xpy++GCG96AU948bWGZtEhAklvTPHnNr9N1xQan7yMylCMbKVfz/LZ
         qPFw==
X-Gm-Message-State: AOAM530vp0I97XQct5ptRTVSjJBQKMjDsxOogX78aEGoRwzCrD2yy+qX
        i/XH/UkL+ZrKaht5RMGLqTvhsaifxBk92YZk
X-Google-Smtp-Source: ABdhPJwl3cGIGn2LcpZBAlX90trk1q7fB7R1to92m7vxyDEULHqWfn7EDOsXjLS4QIP/wcW2jhvX2A==
X-Received: by 2002:a05:6870:ea8b:b0:f1:f46f:515e with SMTP id s11-20020a056870ea8b00b000f1f46f515emr7183182oap.192.1654297238441;
        Fri, 03 Jun 2022 16:00:38 -0700 (PDT)
Received: from fedora64.linuxtx.org (99-47-93-78.lightspeed.rcsntx.sbcglobal.net. [99.47.93.78])
        by smtp.gmail.com with ESMTPSA id bq9-20020a05680823c900b003263cf0f282sm5262376oib.26.2022.06.03.16.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 16:00:37 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date:   Fri, 3 Jun 2022 18:00:36 -0500
From:   Justin Forbes <jforbes@fedoraproject.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        slade@sladewatkins.com
Subject: Re: [PATCH 5.18 00/67] 5.18.2-rc1 review
Message-ID: <YpqSlD0IHwKSo1Nq@fedora64.linuxtx.org>
References: <20220603173820.731531504@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220603173820.731531504@linuxfoundation.org>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 03, 2022 at 07:43:01PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.18.2 release.
> There are 67 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 05 Jun 2022 17:38:05 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.18.2-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.18.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Tested rc1 against the Fedora build system (aarch64, armv7, ppc64le,
s390x, x86_64), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>
