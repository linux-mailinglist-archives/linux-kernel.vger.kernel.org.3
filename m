Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16A0D48A87B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 08:35:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348531AbiAKHfz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 02:35:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235399AbiAKHfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 02:35:52 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 924AFC061748
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 23:35:52 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id y16-20020a17090a6c9000b001b13ffaa625so3544522pjj.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 23:35:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=heitbaum.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WED0yu26NfzAITwrK5q7mRh85CySkD485NpgNOjFL7A=;
        b=krq9KgRukOQ8DWLwT9UV4bJK6hamx+h4P6lv7szSNyZ3TlNIr37G+faa+ibrI0Sziq
         LfgS8SkqbwBNhKoGmGWX7QzqB5II2BA9OBOTyay72e7zYBWpuJh39cglfYMjgKAd8jn7
         9xuxhM7rGidJL3cezCa7JLhn0FuwODrpPflEs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WED0yu26NfzAITwrK5q7mRh85CySkD485NpgNOjFL7A=;
        b=V/7Zvbtfj0Hj402sb8nWG+ud8VlOOEcJyfT9XYp3vaFEqBvlP1e+8UN+3B/RwWwHEa
         jKEVHt+6PGbuiX7AtZ8SO0U0Xxv65iXO+gVWeR59rkkk6WATxoCToGt2dVQjlUo0jTHH
         rrVRMr/TGqOG/N+nzk4e8x8a6B1mQMD5YXNzO3uc3DGHTfRJXo3TLzw9YDPiqSgjjRpW
         1L7NY0UAk3mOckC9RJpkESu8Nic2MZqt4jlNJb8oj6IrKqKD12zs8Ke+P/P/B0//41Uz
         Cf0h+cXCRrFoNfrrbBtO9PUr29x5eGvrTPy/fpkzLGcwylo/ZHSP/Ho9OFAynR8nd97t
         uaqw==
X-Gm-Message-State: AOAM531g6UXqq4t5xbABOQT5Cvb8EGhlDF/p5mHzPVLz6GkXvK2x+6PM
        Q0hmjk3PuOf2JjtDkWLVzHZzcw==
X-Google-Smtp-Source: ABdhPJy1rQ7hgUL62Q/4xnlnmrV2D8unZIQzL+55j4gpviax4ynOt+cmJkw7TKB/tj6LpZEm2p3lTg==
X-Received: by 2002:a17:902:820f:b0:149:8d21:3e42 with SMTP id x15-20020a170902820f00b001498d213e42mr3142069pln.111.1641886552060;
        Mon, 10 Jan 2022 23:35:52 -0800 (PST)
Received: from c7e15a8b922d ([203.221.136.13])
        by smtp.gmail.com with ESMTPSA id x25sm8982924pfu.8.2022.01.10.23.35.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jan 2022 23:35:51 -0800 (PST)
Date:   Tue, 11 Jan 2022 07:35:43 +0000
From:   Rudi Heitbaum <rudi@heitbaum.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com, stable@vger.kernel.org
Subject: Re: [PATCH 5.15 00/72] 5.15.14-rc1 review
Message-ID: <20220111073543.GA2799383@c7e15a8b922d>
References: <20220110071821.500480371@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220110071821.500480371@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2022 at 08:22:37AM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.14 release.
> There are 72 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 12 Jan 2022 07:18:05 +0000.
> Anything received after that time might be too late.

Hi Greg,

Corrected email - 5.15.14-rc1

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
