Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6AE148A875
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 08:33:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235278AbiAKHdh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 02:33:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348533AbiAKHdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 02:33:36 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 011E1C061748
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 23:33:34 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id oa15so16102609pjb.4
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 23:33:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=heitbaum.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oqXNJ2j7PHX7jdfHbj1OmcVM/6qrt9beU4Jr0UDdDBM=;
        b=fu/inaHcA4oJJjld9ycVK20LK7Fg2v5+qOARz8NMPHrxEgyq+HcERWwpzWxs8HX5HO
         Q+8MnCRDU/4gnwzlj2785YavsIE/rXNa7mIWqLgfiH5xtum0mYBHC2c3E8W04Zcxtziw
         ERlgXvH3/iM+wpUA0uWVzKSYzl5Bo+xM4dvvs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oqXNJ2j7PHX7jdfHbj1OmcVM/6qrt9beU4Jr0UDdDBM=;
        b=kkmp/SBrAvdMhumLKKzM5bpA1TtG/EwNcC/+SbIcuCZVQbhpiYEYdyABPjcdEqIk5z
         lx3gr0qZTsO6DiWh1Lw2Wdq5sS/tCbk9aB08psY1ENQrq3kZ4OMifkdO+BuBkrUOg31W
         wA1KXCIzfxZXu9mlCQwikBW2N+Gno/iQnyCIpoSUvRpGdmwTTRNgWI39E8y3DtQv6jKB
         QaA9R9ZhIKbxWOxucT6qPW8qMfpuhFu9V9XatF+9Y2YoJdjolO7xDpb784vuXvxJXyw0
         HEP3nbIiWlJskdf1aLQeRLXfUDAb2umbbeFXarccjr1gQDP6YirS+Kx5iLOH6XnUUgod
         bVBQ==
X-Gm-Message-State: AOAM531jP1QVy5pHwt8K8vbA0U9vJKu4P3ww1nahba0I5uk6EKaoJHVP
        O6fhMQcrXEBKos/hMl6v+bxRuQ==
X-Google-Smtp-Source: ABdhPJxQUzoSVu5Pe9hNadz6G9EwTi6SIfgszBUlDao6KSeiM4cUvomcNt/U+W4iDkqhItRBNmQlnQ==
X-Received: by 2002:a17:902:7485:b0:14a:26a7:81e9 with SMTP id h5-20020a170902748500b0014a26a781e9mr3216253pll.88.1641886413451;
        Mon, 10 Jan 2022 23:33:33 -0800 (PST)
Received: from c7e15a8b922d ([203.221.136.13])
        by smtp.gmail.com with ESMTPSA id w9sm7270137pge.18.2022.01.10.23.33.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jan 2022 23:33:32 -0800 (PST)
Date:   Tue, 11 Jan 2022 07:33:24 +0000
From:   Rudi Heitbaum <rudi@heitbaum.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com, stable@vger.kernel.org
Subject: Re: [PATCH 5.14 000/169] 5.14.15-rc1 review
Message-ID: <20220111073324.GA2799361@c7e15a8b922d>
References: <20211025191017.756020307@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211025191017.756020307@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 25, 2021 at 09:13:01PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.14.15 release.
> There are 169 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Hi Greg,

Looking good.

Run tested on:
- SolidRun Cubox-i Dual/Quad - NXP iMX6 (Cubox-i4Pro) 

In addition: build tested on:
- Allwinner A64
- Allwinner H3
- Allwinner H5
- Allwinner H6
- Intel x86_64
- NXP iMX8
- Qualcomm Dragonboard
- Rockchip RK3288
- Rockchip RK3328
- Rockchip RK3399pro
- Samsung Exynos

Tested-by: Rudi Heitbaum <rudi@heitbaum.com>
--
Rudi
