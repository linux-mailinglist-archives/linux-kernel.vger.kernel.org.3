Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5507E4FEB3E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 01:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbiDLX1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 19:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbiDLX0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 19:26:25 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F64C76645
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 15:12:30 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id i20so504620ybj.7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 15:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xmRmkkroX/ZukAgPQbgu7GtPsckYSYxEzxmb7aKkIko=;
        b=ZR7DAm07c+QEkfiyPHmQCfDS7timLcGfYeugikAQaMwU5Vit90FIFszf5HT8IqDTN6
         MlDYXRrRhfYEJ4DRsY1nVyh5QoVxbY43AJ2//P+ZernsR/FLHrckT1w6XF1e9+YlnHK9
         7gN820jcbxY2GEZcn5feLjjKV0aY9lY2dtVyU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=xmRmkkroX/ZukAgPQbgu7GtPsckYSYxEzxmb7aKkIko=;
        b=lIlroZV6WBMN27ySPXtfNK8uZgMgkncwucGBPPT4BReV6nLHROUtlMdY5JvN5oSi9I
         5HOzovE6bhVWGVtYp2jGD9oB/DM+wtZi5KhqVqQaNC8r7f8pWmni5jywQ7BJO7aT48dy
         wx5sz83al8dzgI8b8zZujEoSAsUYZj/jpVKXKpbr8xOWiLZsd5gaN/dYjSJw3b6AYo5w
         hmMNMj69zZPBE9FqEceyeUCyS7GtxUA88DiNSqFO5Ft5n3e/JkIzdAumiwFeCW0BtO+F
         AF1RFyjFKKFhjZtMUwSIWLr6zASpMHXSKQ+8LRvBjdGCo7Y2E27y6bj6CfTz9S1/56uL
         C7/g==
X-Gm-Message-State: AOAM5328IznxBHtRbBbV/p/P4v8+Kj9mATNuzmFHNxhyfkJaB622Pdyp
        spp2rrzpazkmLAQ/6S2726A1M3YmAHB3mFRB
X-Google-Smtp-Source: ABdhPJzbwC3w2M+vc7pyB5lM/HW6D/4TCKadUkygTIT+t7hZVldVzOyZ115iTy8XP73vsW0amgCbkA==
X-Received: by 2002:a4a:d109:0:b0:321:28d0:b7fa with SMTP id k9-20020a4ad109000000b0032128d0b7famr12254834oor.17.1649794132285;
        Tue, 12 Apr 2022 13:08:52 -0700 (PDT)
Received: from fedora64.linuxtx.org (104-189-158-32.lightspeed.rcsntx.sbcglobal.net. [104.189.158.32])
        by smtp.gmail.com with ESMTPSA id b188-20020aca34c5000000b002da579c994dsm12690706oia.31.2022.04.12.13.08.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 13:08:51 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date:   Tue, 12 Apr 2022 15:08:49 -0500
From:   Justin Forbes <jforbes@fedoraproject.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        slade@sladewatkins.com
Subject: Re: [PATCH 5.17 000/343] 5.17.3-rc1 review
Message-ID: <YlXcUXUjSumMUipj@fedora64.linuxtx.org>
References: <20220412062951.095765152@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220412062951.095765152@linuxfoundation.org>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 12, 2022 at 08:26:58AM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.17.3 release.
> There are 343 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 14 Apr 2022 06:28:59 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.17.3-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.17.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Tested rc1 against the Fedora build system (aarch64, armv7, ppc64le,
s390x, x86_64), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>
