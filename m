Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 583444808BA
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 12:12:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236446AbhL1LMf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 06:12:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231721AbhL1LMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 06:12:34 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91C7AC06173E
        for <linux-kernel@vger.kernel.org>; Tue, 28 Dec 2021 03:12:33 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id u16so13330142plg.9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Dec 2021 03:12:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=heitbaum.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=D+dYd0M066OG9f10N/Buwp7BkXPVLlMKzg/PxUAMOmw=;
        b=kBMDKYBvakLXv6qTyhsqUwNZy7i+6hGbY5t3LUw1pSTvn+1LT26Q7y9FBOwkv2FWXw
         yPwpObRiN0BG4pqtsPTBcFIoJHX2LfxG89kLypxHRBR1emnHjyfuDEGj+WoMYVVK3Rf4
         n3vDzbuL4kfVuJUhZOrbJGRK5xoC1ScryYplQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=D+dYd0M066OG9f10N/Buwp7BkXPVLlMKzg/PxUAMOmw=;
        b=fun50bCnAkoNpJS+x98G/rELk6/ks3acFyuJ2yHeRSbKnv6pjdaNdFQwHJqllmnYFn
         Jjy23o/dN7MuytWk5Yq7LErE1zPEzv5spfLV9NBakbBR5/Nm/gIWniO6d/oV3uOKA289
         lCZPgZyqPq2MSWTUQYE1w70jOHaiAXmKwAx8VquhPAaz43Ony67IScbCMF3DWnDp0PZu
         ySOmJ3/RxWDctal/V62cu09BxLLPVujNQzYO3mMINoZU6jGx2WrDoZG7Ey9NEO0Rq31P
         ttpLV25YSXiaEN4/T5Bn7ScErQs1ebIJm4u2sIsOM3UWlIrMEd6+35YvAyn7aJiTukvq
         B1mQ==
X-Gm-Message-State: AOAM5306/Aw/seYiIwsjrQh3qvggRVU4lqewVNDqnCPMILYolqROewq8
        ZEsKqvsBYCeal3gvpCZKAH6sAOaqMm/OK4/W
X-Google-Smtp-Source: ABdhPJymnp/O4GHxG+dl3D6czNoZ1w0DP0gS+0aRIqbjeuvw47IuvKJwXMiK1ctvOT9F9/DOkFksSQ==
X-Received: by 2002:a17:90a:fa12:: with SMTP id cm18mr25695470pjb.141.1640689952821;
        Tue, 28 Dec 2021 03:12:32 -0800 (PST)
Received: from 32c720d4cfb4 ([203.221.136.13])
        by smtp.gmail.com with ESMTPSA id b21sm18798277pfv.74.2021.12.28.03.12.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Dec 2021 03:12:32 -0800 (PST)
Date:   Tue, 28 Dec 2021 11:12:22 +0000
From:   Rudi Heitbaum <rudi@heitbaum.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com, stable@vger.kernel.org
Subject: Re: [PATCH 5.15 000/128] 5.15.12-rc1 review
Message-ID: <20211228111222.GA653610@32c720d4cfb4>
References: <20211227151331.502501367@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211227151331.502501367@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 27, 2021 at 04:29:35PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.12 release.
> There are 128 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Hi Greg,

Looking good.

Run tested on:
- Intel Tiger Lake x86_64 (nuc11 i7-1165G7)

In addition: build tested on:
- Allwinner A64
- Allwinner H3
- Allwinner H5
- Allwinner H6
- NXP iMX6
- NXP iMX8
- Qualcomm Dragonboard
- Rockchip RK3288
- Rockchip RK3328
- Rockchip RK3399pro
- Samsung Exynos

Tested-by: Rudi Heitbaum <rudi@heitbaum.com>
--
Rudi
