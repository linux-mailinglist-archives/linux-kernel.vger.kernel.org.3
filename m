Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D3F958CBEB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 18:13:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243923AbiHHQNe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 12:13:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243415AbiHHQNb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 12:13:31 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67DDCFE4
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 09:13:30 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id z12so11432407wrs.9
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 09:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=e2k9+csC2s9E3w26N33toJ1//qjvjqrNHy08urbha/g=;
        b=CkyJF3d7E71SXMCKJRZGqw69Q+ZIZAvqhu0nU3sz0a5TH4xUIzYcNW7WIF7ohVOxj1
         0j2pKtzdy0/yKtak3FULjUKcIEuH51Y4wus6KYZod26LrCXWsm4XLL5/PARPuKKB4Egs
         EKY5ZvJO8R9u6Q9VYGdPU/suxvT/hbPw3P6/b8tTlmOD+IGczb3fv+N/GoTzye5Isumi
         4KHW+ttKTMrJPTTtdkHBQ/S2DLZpNv80CZ8/MENyijKEKYKePCEqB9auF3uJ0KLDO88m
         UJ1zm761MYRwgZZuAsZNI0n28rL2KZpNVon8CO8EBNUz2RU8U/E7b3lIW3ezPh0XAe64
         iMLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=e2k9+csC2s9E3w26N33toJ1//qjvjqrNHy08urbha/g=;
        b=SqzDrUg+qalVPKuUKtK7lyLk8BqtBHF7id1smaFEeZo6k7rM/QWsqhbyqqo9vuz3kX
         hLZBbrpo1kA/l+C2r00kIdLMIJxdrUo4+R+fzbXRCXKfOj3MMeuXrplSv7pD3q9YAG17
         Z29ntc3zIO+cZKX0ksJucQFONaFxaw/yygHKdGgS/1lcl0cBBAQ99/itCrwZx+Y91VWo
         8dKkpkQ1XMLpIVpwViLZTcjUkB4vESaFn/6MpI4dG4sFX/0zNYq70goE9/zrEy7l1j8A
         Dyi58OAkGUXm4JbyHlPD9J4oHHTEI64+jL3FK47UUxfjAqtLc6+yXCCHCXu7k+LA/b4r
         I3gw==
X-Gm-Message-State: ACgBeo1ZoJho+b6S6dePx2oRLQu3hulAOfbqr9yWw1qTRls/RTRhgddG
        GeMUdJXPs2UvXkAMaMnMV0ps6+sw19w+Og==
X-Google-Smtp-Source: AA6agR4t26LyRQ4Z47o/xW5Uop606M9KgBpQe8HaaB5R05j7wbsrTP1D4IMJ55FPKINTyhvMsq+fBw==
X-Received: by 2002:adf:f1d0:0:b0:21e:c8e1:e82f with SMTP id z16-20020adff1d0000000b0021ec8e1e82fmr11809330wro.635.1659975209012;
        Mon, 08 Aug 2022 09:13:29 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id bg21-20020a05600c3c9500b003a4efb794d7sm16424743wmb.36.2022.08.08.09.13.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 09:13:28 -0700 (PDT)
Date:   Mon, 8 Aug 2022 17:13:26 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-kernel@vger.kernel.org,
        Lee Jones <lee@kernel.org>, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v3 07/10] mfd: intel_soc_pmic_crc: Drop redundant
 ACPI_PTR() and ifdeffery
Message-ID: <YvE2JkKdVA7cpE07@google.com>
References: <20220801114211.36267-1-andriy.shevchenko@linux.intel.com>
 <20220801114211.36267-7-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220801114211.36267-7-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=1.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 01 Aug 2022, Andy Shevchenko wrote:

> The driver depends on ACPI, ACPI_PTR() resolution is always the same.
> Otherwise a compiler may produce a warning.
> 
> That said, the rule of thumb either ugly ifdeffery with ACPI_PTR or
> none should be used in a driver.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Tested-by: Hans de Goede <hdegoede@redhat.com>
> Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
> ---
> 
> v3: no changes
> v2: added tags and rebased on top of new patch 1
> 
>  drivers/mfd/Kconfig              | 4 ++--
>  drivers/mfd/intel_soc_pmic_crc.c | 6 ++----
>  2 files changed, 4 insertions(+), 6 deletions(-)

Applied, thanks.

-- 
DEPRECATED: Please use lee@kernel.org
