Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0DAE58EE20
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 16:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbiHJOUX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 10:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231374AbiHJOUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 10:20:20 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05B881D1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 07:20:17 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id w196so12792572oiw.10
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 07:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=fbsCPwDIsqvHdw3PixeBRvE6sDRP6FXam4RiixwuYhI=;
        b=R2GixWKsStK1UTQ+x/mmz2wIp/f+VLV3UflgU3jHW711CERJmQCZn6fku7bA06zC/N
         LBKcEnD2y4GZikX0YtG1STdAkqSDIssuOK5pDiB+oWvNdyHkWf+CKvQ9EpHgN5jSfAgK
         YfsCJVrld8gK8sKCSpcf/6VueKTIfwQLu0iiU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=fbsCPwDIsqvHdw3PixeBRvE6sDRP6FXam4RiixwuYhI=;
        b=cF0Iqb1jWl/QLVKN/mE23Q/YcTZyhqLLN0xXzT3BmdXJiXKz0KerbM8I+9fhhCpC3N
         q5Pu+cBsi08W+rVW+3YCVD/fuuxIYUCd03R2QJWjHutbJkPL42B2kD8QFtOn7+ud4wiO
         ymdoZtvwqJ+UQISgkR3rxVBXmrzdXi/tXzxPAMOc6NMLW1dOxVTG6cajROggIKS1KXhr
         pjoijG2bImHapchoyry6XLDcnjhViey1gNKQyPjRxr9U/DSx4N5oFRxf0GmiqRBOHaOg
         wWEGoPB2lCRJFF3UA4gq9gBblBw2Y3OALJAekFyU7R2ACz/A2Z1k7M5TwrPp5YknyvIK
         Bt8w==
X-Gm-Message-State: ACgBeo1oDsWSPpIOY7cPfv6glI48et1O5dhDfXldzTNjzEHKedqrYQ5M
        Q9lNtVmyDzfb7yYO6wNt2KFh8A==
X-Google-Smtp-Source: AA6agR4vdaAdiMCW7puKRptbw7RVZ0WrS4D+3CbLxSfqQ6g1N2nANTfct8bclt2ckuMkMIB4PKuB8Q==
X-Received: by 2002:aca:1701:0:b0:343:e09:c847 with SMTP id j1-20020aca1701000000b003430e09c847mr1488319oii.30.1660141217010;
        Wed, 10 Aug 2022 07:20:17 -0700 (PDT)
Received: from fedora64.linuxtx.org (99-47-93-78.lightspeed.rcsntx.sbcglobal.net. [99.47.93.78])
        by smtp.gmail.com with ESMTPSA id c25-20020a9d75d9000000b0061c1a0b4677sm700170otl.12.2022.08.10.07.20.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 07:20:16 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date:   Wed, 10 Aug 2022 09:20:14 -0500
From:   Justin Forbes <jforbes@fedoraproject.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        slade@sladewatkins.com
Subject: Re: [PATCH 5.19 00/21] 5.19.1-rc1 review
Message-ID: <YvO+nonO3DHclC2K@fedora64.linuxtx.org>
References: <20220809175513.345597655@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220809175513.345597655@linuxfoundation.org>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 09, 2022 at 08:00:52PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.19.1 release.
> There are 21 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 11 Aug 2022 17:55:02 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.19.1-rc1.gz
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
