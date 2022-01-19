Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E24749392B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 12:03:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353979AbiASLDB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 06:03:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353967AbiASLCz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 06:02:55 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CDFAC061574
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 03:02:54 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id q9-20020a7bce89000000b00349e697f2fbso13681703wmj.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 03:02:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=y3GaD+SwN8APMQh031bGmSeVhkIovJ6kmTWH0X4e1qs=;
        b=a6dQ+O363irHUe/2uR6WdKPelWnbsGOe88aYXZJWYu3+R/9z0BBECAZLkfcQyAIb7K
         BuOGMmgyUuAsXMLD7g/PBRldy0iYCslevoNDB9GKInXvWMHAp9ZpbtfoWkVgiRq8np+a
         ES/7nyOiJGW1FiUwq2GKq3n87Nw1OyOCNaLqzWUa6al8gXCelS4Stk4LNgzahgmTLHCP
         tYsEFbjLqH5RqCAkUCl37Y/xgoU7XN4N1rgBXThWeRkntCS8B+51Fjil534FR2DQbH7Y
         3Oukbh2d5EilpYtLc4uiRsX7txttv8BHU5O4v9HhcdNmd5bP4hg5nDZ8sBD5ykU9e1Vz
         dUCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=y3GaD+SwN8APMQh031bGmSeVhkIovJ6kmTWH0X4e1qs=;
        b=dDS8ao8R/Wo0I1C2mQaA4RiFMrPjbAAYjQNOq2SrVoyMZKBcDshK1UPOvPiXH2As7J
         P256pOP/eSCGixr0Bb8kc3LQuc12+lebZ0U8IVl1KAFR79QwJ2AlZnaSo+czVeqF35My
         tLnDBuXBnKibvyJHo2Ko0HWQJ/QBf9MpbUlaPzjArfTtbEiUgr7ZNcxwbZoXWB3beCQB
         2OafqWzamFzDkwsfvfn3FRMq/DViOEFTt2MQcH94jtzZxk1b/cL5HxHZETrmXEWgHPca
         rcS63CSJ/LoScnXbj5/2qGR3lAFuHeIEqZUVpt3HSPsMhd/KKWAJxpk1u7HKysM862w0
         GDuA==
X-Gm-Message-State: AOAM53322Ac0kJAOoK9unso4mbTVb2ju0ziZpqXBHlqwlR/h85/xme3e
        3Oi5i9Tw/td8MyU12GGSak17aQ==
X-Google-Smtp-Source: ABdhPJxX7fgAprwygcmLbv/bWso8tv6+jbaJ2Y6smRT4U6jn90jPf3xZUhJtuZxCXWHTGChun0sZpw==
X-Received: by 2002:a1c:a102:: with SMTP id k2mr2688174wme.78.1642590173201;
        Wed, 19 Jan 2022 03:02:53 -0800 (PST)
Received: from google.com (cpc106310-bagu17-2-0-cust853.1-3.cable.virginm.net. [86.15.223.86])
        by smtp.gmail.com with ESMTPSA id bj6sm313517wrb.48.2022.01.19.03.02.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jan 2022 03:02:52 -0800 (PST)
Date:   Wed, 19 Jan 2022 11:02:50 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Zong Li <zong.li@sifive.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] clk: sifive: Move all stuff into SoCs header files
 from C files
Message-ID: <Yefv2uFYme4+GDdL@google.com>
References: <cover.1642582832.git.zong.li@sifive.com>
 <70c9317814b06c7ce37688b158178b188d3fd604.1642582832.git.zong.li@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <70c9317814b06c7ce37688b158178b188d3fd604.1642582832.git.zong.li@sifive.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Jan 2022, Zong Li wrote:

> Improve PRCI driver to reduce the complexity, we remove the SoCs C files
> by putting all stuff in each SoCs header files, and include these
> SoCs-specific header files in core of PRCI. It can also avoid the W=1
> kernel build warnings about variable defined but not used
> [-Wunused-const-variable=], like commit 487dc7bb6a0c ("clk: sifive:
> fu540-prci: Declare static const variable 'prci_clk_fu540' where it's
> used") does.
> 
> Signed-off-by: Zong Li <zong.li@sifive.com>
> Suggested-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/clk/sifive/Makefile      |   2 +-
>  drivers/clk/sifive/fu540-prci.c  |  89 --------------------
>  drivers/clk/sifive/fu540-prci.h  |  91 ++++++++++++++++++++-
>  drivers/clk/sifive/fu740-prci.c  | 134 -------------------------------
>  drivers/clk/sifive/fu740-prci.h  | 130 +++++++++++++++++++++++++++++-
>  drivers/clk/sifive/sifive-prci.c |   5 --
>  6 files changed, 214 insertions(+), 237 deletions(-)
>  delete mode 100644 drivers/clk/sifive/fu540-prci.c
>  delete mode 100644 drivers/clk/sifive/fu740-prci.c

This is the sort of thing I was after.

This patch at least LGTM.

Reviewed-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
