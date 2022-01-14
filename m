Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A84FC48E87C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 11:45:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240508AbiANKp2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 05:45:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234097AbiANKp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 05:45:26 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF9A7C06161C
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 02:45:24 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id n11so10991880plf.4
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 02:45:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=heitbaum.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eLYK/fqPsTtNo1x+VH6V4xL3BQQ8ZZx56PR+lTM+6bA=;
        b=j9LnnOlfQa941sP6li3wo5Ubve4QaX/hNHt+g0JU2owv2UcQf1KjSPzEy2MCKaTC89
         GYn3laLRvrtv/QfRu451bgishWLLH5S8zCiLGH936z12tChkA2KStH5bxoSuQMPnwobs
         gbe/8vgddqEa1mk5WNnvcfGUpDuQzA0wWOLaw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eLYK/fqPsTtNo1x+VH6V4xL3BQQ8ZZx56PR+lTM+6bA=;
        b=DCPoIfWsTmahLiytlfM6JW4/KAKv/cpD+efsTYQZWFzu3oiwDx4ZLkMudr6r5uZGlp
         1j6V70394UKuRic6v8RuHakV0nzWJ46+F6o+nPp6QdY27YS8oVJPNcXNpn61R07I59zD
         BQeckZIKGOGzINurs8EpfyiJQQU/AymANhcfQaLGsoY2jvp5+wkUorJEPTSrptfJJrk8
         Mr334/vWvOoBBc0aL8gb623HhTYiMx++yL54yC/hmMFN8aVB77yJuab4bUmxug092zPZ
         7pga9wX46QojnOxkFowlcmHN/IY/b5MenuCl3zqNoJr8HNECecuV2/biO5MasulyqnLe
         AGCA==
X-Gm-Message-State: AOAM530ue1rJCpXY+p6usB021dU9Pk4medUV26bwGs8JadlFlLpWjPH9
        1Qasv/gbCYk+TzANk4wtPlYwEg==
X-Google-Smtp-Source: ABdhPJxXxc3j6prJt2mVVTYxoAWRXoDC/1+bTUHbpnlDxRW4rx4bIE9W36XBrBrcoLHi+6+3WvlqXA==
X-Received: by 2002:a17:90a:688d:: with SMTP id a13mr9900822pjd.164.1642157124148;
        Fri, 14 Jan 2022 02:45:24 -0800 (PST)
Received: from ebfb30208ad6 ([203.221.136.13])
        by smtp.gmail.com with ESMTPSA id ga4sm2125985pjb.35.2022.01.14.02.45.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jan 2022 02:45:23 -0800 (PST)
Date:   Fri, 14 Jan 2022 10:45:14 +0000
From:   Rudi Heitbaum <rudi@heitbaum.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com, stable@vger.kernel.org
Subject: Re: [PATCH 5.16 00/37] 5.16.1-rc1 review
Message-ID: <20220114104514.GA8@ebfb30208ad6>
References: <20220114081544.849748488@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220114081544.849748488@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 14, 2022 at 09:16:14AM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.16.1 release.
> There are 37 patches in this series, all will be posted as a response
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
