Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3899F587A90
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 12:18:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236590AbiHBKSk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 06:18:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236378AbiHBKSb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 06:18:31 -0400
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12BA64D4C0
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 03:18:28 -0700 (PDT)
Received: by mail-oo1-xc2c.google.com with SMTP id v5-20020a4aa505000000b00435b0bb4227so2442136ook.12
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 03:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=K78j/0pCoXek0gCXozytinTReCWKf8fiaumZW6V/S3Y=;
        b=UI7GC5Y0wlmxOJc/XTFLhFzb53e/ijR9sNJ0Ad/IJZyJpGDTaMem4K5GUrZ/Pwke9Y
         B/DP6X+Q8R2dUAf2UfoOOO0g9Q6ZwA7tuzbQfoZLiFWVQC0qXnusOqEcJ+nrDvKRoYQo
         U+4T7BIB7kmC/GBtC69luqimiiSJcxMfF4YX0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=K78j/0pCoXek0gCXozytinTReCWKf8fiaumZW6V/S3Y=;
        b=uesrFHMJ8kp0uIvPeuAslUg5Bk1T5rj/3DQucj42WgKyyfh3NbYyfRqQ+dIoJKl/Q4
         pE+SW7khQ5zfLRGxdavYVynyytdoDQT4AevwT2r5N3kCri8g056jnp9Xok4tIOiuSin1
         YgW5/PnqmlJc10HG2rdHXH6Dq2RZyxfBTMv6GELQRQ3z1XcuMZ8CYzgWuU9PU6iVhcNg
         d0yTWeORyz7ZlV4bc9k/g+etMSqnElO2DffuS/IHap6QZ6dyfaCaMzSwK9UXz/C3uHhk
         thpC7omVDO1iMzyfvHYCqpnOH2vmjSgivVWc0aHGSwvG4gWJwU8tKt8sP5/MFV+/Z9Yg
         b7yg==
X-Gm-Message-State: AJIora8jMqC7hD7N6H35ZWUHKmrMactnxS1afOKCkdyjpFi62cgo2PvU
        5DiSDlJ1Gw0YhJM2RONFagMpyNSBBSqbsWzV
X-Google-Smtp-Source: AGRyM1u4K6w9NQE4kyilfQ4NWaq8ASniinqgzR39/BX65pfwAv6dG+XBTPf2nHTAkIgbf2Twvd2yrw==
X-Received: by 2002:a4a:6550:0:b0:435:f3e8:8d3e with SMTP id z16-20020a4a6550000000b00435f3e88d3emr6428808oog.13.1659435507346;
        Tue, 02 Aug 2022 03:18:27 -0700 (PDT)
Received: from fedora64.linuxtx.org (99-47-93-78.lightspeed.rcsntx.sbcglobal.net. [99.47.93.78])
        by smtp.gmail.com with ESMTPSA id o23-20020a4ae597000000b00435a68593ebsm3253820oov.27.2022.08.02.03.18.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 03:18:26 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date:   Tue, 2 Aug 2022 05:18:25 -0500
From:   Justin Forbes <jforbes@fedoraproject.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        slade@sladewatkins.com
Subject: Re: [PATCH 5.18 00/88] 5.18.16-rc1 review
Message-ID: <Yuj58TxHH1IH+uka@fedora64.linuxtx.org>
References: <20220801114138.041018499@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220801114138.041018499@linuxfoundation.org>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 01, 2022 at 01:46:14PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.18.16 release.
> There are 88 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 03 Aug 2022 11:41:16 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.18.16-rc1.gz
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
