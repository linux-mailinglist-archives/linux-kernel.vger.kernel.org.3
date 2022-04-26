Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22164510B14
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 23:17:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355317AbiDZVUK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 17:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355225AbiDZVUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 17:20:08 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C445C1CB5
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 14:16:59 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id e189so22117253oia.8
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 14:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Z4Mcj3qE3FABBr3ceQyAVJGsIOmy0ODTXxNYrqMyZWI=;
        b=BD4ZBHSw7m9GKQfPqpRuEXNNFQfNYd+y+Ll8Ansi71HgMJzE+lebfpk48h8pDRw8Ru
         lyff8qa2ShUoLeuM/5XVP8PiYFkPcWVIuZlswE1z3MFqVrKKkpUS+ZUEVv+WPvmbHWUU
         zanJcTJltehcTI3Uf5T22s2aeGHTQfrC6yOvQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=Z4Mcj3qE3FABBr3ceQyAVJGsIOmy0ODTXxNYrqMyZWI=;
        b=X8hhXbII7zJvNKpzpnHpWWZv837OeVbNTtlDx2c9tnydc/rZZud858F0OdQBHKKPwr
         eveohZU9/7V/nOtKLsUg5BEKzDJYsgZlYsWe2ibSyCsgRSnjpt3oedgAV4rO185WZry9
         BJdkKradZh0tMftwQEWUaFcL7xu+Up7pbVhv95TU0PyjQGjWDrW0VA4nsXnWNGxwMMTL
         XWtAADG6u2sXengIYBOGJJSSfanufgXICc9yrgy5VsA2nAa/q7KFtVXSYnEBTg6qe2rT
         Bz23bTKudUD40gZJL/Xqyb1J3uGM6MLPz5dquBzORfK21VCgUgpBUU49yQwLmSJZW4+K
         8d3A==
X-Gm-Message-State: AOAM530ptD81R21ksMe6SkaarNHQHxs4dt64CHhZPFoTM7E3Vxe6YkP2
        8L4aIj0jLC+QSawuNRiT6ItLNg==
X-Google-Smtp-Source: ABdhPJxv3SiRXLZffAGNHrKHgjqZol9p0iZc/GOVD7mILmdRVlOvGch854cRHTcU0QOyV5BWSqVuFw==
X-Received: by 2002:a05:6808:1911:b0:322:c4ec:85e5 with SMTP id bf17-20020a056808191100b00322c4ec85e5mr15933810oib.12.1651007818338;
        Tue, 26 Apr 2022 14:16:58 -0700 (PDT)
Received: from fedora64.linuxtx.org (104-189-158-32.lightspeed.rcsntx.sbcglobal.net. [104.189.158.32])
        by smtp.gmail.com with ESMTPSA id n21-20020a9d4d15000000b00603fb46ddcbsm5247384otf.65.2022.04.26.14.16.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 14:16:56 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date:   Tue, 26 Apr 2022 16:16:55 -0500
From:   Justin Forbes <jforbes@fedoraproject.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        slade@sladewatkins.com
Subject: Re: [PATCH 5.17 000/146] 5.17.5-rc1 review
Message-ID: <YmhhR213tAjEn+ij@fedora64.linuxtx.org>
References: <20220426081750.051179617@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220426081750.051179617@linuxfoundation.org>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 10:19:55AM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.17.5 release.
> There are 146 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 28 Apr 2022 08:17:22 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.17.5-rc1.gz
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
