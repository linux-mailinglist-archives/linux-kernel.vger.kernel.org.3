Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8179D55D8CF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:20:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235639AbiF0N1K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 09:27:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235554AbiF0N1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 09:27:09 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56A7D63FB
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 06:27:08 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id s1so13051522wra.9
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 06:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=T+pY+yP/H+gzjKcBU2a+UyBAKSlhvpHgjb+2kRJ+ebs=;
        b=xOG9SsHLzBKJLk0Q/byfn23vqyLt11wbYavKU42bnCILy9AQJJHUxhWBFRJS9Xe+IM
         OvW7kOOa4plmdopXXZOlu50qmTEuAtpH+2ouif3GgVC62truhpUlUJCObdMyRHHywmOd
         LpgHvMCTkOZq82moZLM9Riwk/P6ONAJncHVog7tmTViRAmoJHZDz4e36Pljs+A58XMov
         29x2s/EHISJ7y99O58hOaZSsSH5vQL0HeL3r0hXg2ltTKlSFT9WF3gzMKpfsEPtQlbVH
         0d+dTqburHiFqJPGM0Wib+DakFFx8NxSGiIJj/gUQvQCeNTzPd6aR1MlyreRSaNWQ58V
         xIbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=T+pY+yP/H+gzjKcBU2a+UyBAKSlhvpHgjb+2kRJ+ebs=;
        b=0YEhYaBNmLcEbrJnL1ilJ9XQXtIW5UwA8Bg63kkugmd7FxHJLFIqrKLfGfcVGyzcWf
         yV6Y0W6dUXrhZp/nOKyrw9JAbzao3XeuD5MCwFeZuC+5QNdEQ0JnnU16Kict3ns/21GB
         lX2VArBNzai9TSRjE45F1HqkTeiLhQowrrJEyO81tJZvesrYZfYGLbDwwtx5Qp8UmKJV
         IYkOAXcTgn19ITJLvwDkaThyXaDbJdnyjb80JGp7+ppJb3Oodn+7vWEnQcP/iylkjhO+
         0kq9rONBI0XTPldmINIAy+W9O4A4OjvXX1aaQw1KKLrWEVAlRPJrD/iUToETxx9mGlOU
         8mQQ==
X-Gm-Message-State: AJIora+ld//FNnnPe87CZozOk8ZwKHPTvfC1S4m4KOISCvVvZc5Cv3xj
        yuGPzo6E4xOoM6FAZ9waEyXpb+y00AF9Fg==
X-Google-Smtp-Source: AGRyM1t7QjD2wwcs1yIcEGPkJimlwgxVaxQvRky01LKhXaUHV3inu65I0ePAbVZ97jsWPyREBYu//Q==
X-Received: by 2002:adf:f84a:0:b0:21b:88b8:183 with SMTP id d10-20020adff84a000000b0021b88b80183mr12194935wrq.265.1656336426660;
        Mon, 27 Jun 2022 06:27:06 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id r21-20020a05600c35d500b003a02f957245sm17950845wmq.26.2022.06.27.06.27.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 06:27:06 -0700 (PDT)
Date:   Mon, 27 Jun 2022 14:27:04 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v1 6/9] mfd: intel_soc_pmic_crc: Drop redundant
 ACPI_PTR() and ifdeffery
Message-ID: <YrmwKCoSP8XsEa5g@google.com>
References: <20220616182524.7956-1-andriy.shevchenko@linux.intel.com>
 <20220616182524.7956-6-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220616182524.7956-6-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Jun 2022, Andy Shevchenko wrote:

> The driver depends on ACPI, ACPI_PTR() resolution is always the same.
> Otherwise a compiler may produce a warning.
> 
> That said, the rule of thumb either ugly ifdeffery with ACPI_PTR or
> none should be used in a driver.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/mfd/Kconfig              | 4 ++--
>  drivers/mfd/intel_soc_pmic_crc.c | 6 ++----
>  2 files changed, 4 insertions(+), 6 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
