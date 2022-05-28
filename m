Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD5255369EC
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 03:54:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351815AbiE1Bxh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 21:53:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245216AbiE1Bxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 21:53:32 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F05A014014
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 18:53:30 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id t144so7669792oie.7
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 18:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FtI25lp7z4LZIoDWgGyoVrLCNBjX3mKlwnGfkQ7hiXg=;
        b=S0abEByizXkvjju3NZf4tXR3OvTpg5QydyKjKnWgPRTcG91ZB0wyHLea9pkTO4K3i5
         FGp1BNNsDNnJ8PmSUEdkf+hWax43dxqPPXWa0fPDwxxOOz0p495QqywLiGnjS5ep2hga
         Z7otyinDIEHZYYA/E8L2pe2PiMQgYWQoDIYEc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=FtI25lp7z4LZIoDWgGyoVrLCNBjX3mKlwnGfkQ7hiXg=;
        b=CaJV+hsG3V094xBHGyPG/VYhsOWoeiONwKcQ0LTrVVwyH8OWOZQjJFyteTWB/hXljZ
         gz1zG5NbgVNNpesWn4dGVrevhZw9kEDtEopXhlZ+oUzCzPhEOwTt9GFVamnnwOvbvw21
         6ZSvmXGB8nwAjEQrqtQLHwe3C6hPyZq91XNFTT6lWDRF202HNttQ7BKC1Hc++bMx+mql
         J5wCW5ckwSknSodv5FtFf25wW9/LurTnhnjZIW6tu5DaWbSUPFtVdQMpw6Pxv7F7C0Zl
         sOtqcfygikSntqOu2y5ESctMNj/r+ZdZvCDsjEcu9gY/jkl9/xGTY4m7IKHB5QZIRM4z
         /F4g==
X-Gm-Message-State: AOAM5303nTi43Vfkr1Z+IFpa5s36a9NY6KnLsl6nbFMx2zk1NCNFF0ZV
        2J1SJCWU2C6DuJLHiaKJdigx2Q==
X-Google-Smtp-Source: ABdhPJxHqRn/G7EkUc5FjYjFt7CzQ46NrTCodQCc1OsQ/iro3GEHyOFs/ZTilzitj67zo8Xre1gERg==
X-Received: by 2002:a05:6808:f8c:b0:32a:e67f:d20e with SMTP id o12-20020a0568080f8c00b0032ae67fd20emr5049500oiw.88.1653702810215;
        Fri, 27 May 2022 18:53:30 -0700 (PDT)
Received: from fedora64.linuxtx.org (104-189-158-32.lightspeed.rcsntx.sbcglobal.net. [104.189.158.32])
        by smtp.gmail.com with ESMTPSA id lg11-20020a0568700b8b00b000f193e656c5sm1241788oab.15.2022.05.27.18.53.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 May 2022 18:53:29 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date:   Fri, 27 May 2022 20:53:27 -0500
From:   Justin Forbes <jforbes@fedoraproject.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        slade@sladewatkins.com
Subject: Re: [PATCH 5.18 00/47] 5.18.1-rc1 review
Message-ID: <YpGAl1lh9vQSxsFV@fedora64.linuxtx.org>
References: <20220527084801.223648383@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220527084801.223648383@linuxfoundation.org>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 27, 2022 at 10:49:40AM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.18.1 release.
> There are 47 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 29 May 2022 08:46:45 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.18.1-rc1.gz
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
