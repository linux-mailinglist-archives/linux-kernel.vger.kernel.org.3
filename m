Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 628F556D840
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 10:37:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbiGKIhi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 04:37:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230240AbiGKIhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 04:37:23 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA62D12AA5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 01:37:21 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id h14-20020a1ccc0e000000b0039eff745c53so2584424wmb.5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 01:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=94m8TF5uNBFXjkXvh+ACggXcrcKwic4qJ4j/3RHPNXI=;
        b=A5inJLmsx9iHAehJspCw7BdQNh+iDgVrd+wq0H/Vg4k8fO2ti4SYBhSj9/WR/Egm00
         LRoObReOI1QMjKo6los6Zsp3ugy7tjOB/Ym3rcnEuOifBli+fPNflnbxWAuRbkb3S8y4
         FivFF/UaLQANTbTmdTwKhDzmuTGpZhQMhtankBpE88dI5QofspotOfakxdSjcWEqKy93
         4ohPhqnJ5bSX4N8yGVsqBY0JPl5gqgawRpUEBeqahBzFkohmeLJW1B04Gz+sDwRrOoYm
         Cq35zm0q4pxbd08hXhoafzzSoFksHGNDGisB1cwBdn7sVTtoPsTtf3UGGETex6zTv7x4
         0u8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=94m8TF5uNBFXjkXvh+ACggXcrcKwic4qJ4j/3RHPNXI=;
        b=7l9jrDknhB7fF8BTApZrPfmkKARgJ6cusccokUYVwVEp/QiXP59P+R4MNt+V0aVuFo
         2PMliNvTVtuxBDdiNd4ppH1CtAhdxAUEZpDlWHGN59+0GTroL9cXgeMEMOJkfOAoOf65
         7ZYfXe9Eh3rYszMoCcv6amuH0McWujytJXCDMR/0Y+mSZm9cdd64ZM1f7tErLBOBl1PK
         VaSoYpRlCIabc+IPewtdjOPLRmEK/kMjYy1xiamtM8Ud2D0tCieFjfxEVN7yqHBtRkz6
         7IzgiqXOXdhkLQyrYD9AqwML5LB5wjVvhQjpQZoNDce288BKmoa8dZlkajOZCZrOE1cz
         JrnQ==
X-Gm-Message-State: AJIora8OvL65ETu2gKiS6tLspvHDZ1CpmIIeCt0o4nOhXSjhYkVzJeqH
        sCYeRc1FttaAx3k/eeAsUOdzQMcpKWjQoA==
X-Google-Smtp-Source: AGRyM1tapMCGO0RgY4KH3VWlA0us7vKVJLBhzzKt4QIh+LuOYoeXAb7FOKox/zrNOoB2f91cHcqb/A==
X-Received: by 2002:a05:600c:41c7:b0:3a2:e8fd:fe52 with SMTP id t7-20020a05600c41c700b003a2e8fdfe52mr2501028wmh.123.1657528640293;
        Mon, 11 Jul 2022 01:37:20 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id u3-20020a5d6da3000000b0021d66cf9547sm6504699wrs.0.2022.07.11.01.37.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 01:37:19 -0700 (PDT)
Date:   Mon, 11 Jul 2022 09:37:18 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v2 07/11] mfd: intel_soc_pmic_bxtwc: Drop redundant
 ACPI_PTR()
Message-ID: <YsvhPkclriH6MCur@google.com>
References: <20220628221747.33956-1-andriy.shevchenko@linux.intel.com>
 <20220628221747.33956-7-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220628221747.33956-7-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Jun 2022, Andy Shevchenko wrote:

> The driver depends on ACPI (via MFD_INTEL_PMC_BXT), ACPI_PTR() resolution
> is always the same. Otherwise a compiler may produce a warning.
> 
> That said, the rule of thumb either ugly ifdeffery with ACPI_PTR or
> none should be used in a driver.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
> ---
> v2: added tag (Lee)
> 
>  drivers/mfd/intel_soc_pmic_bxtwc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
