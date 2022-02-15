Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2EE44B712E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 17:40:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238496AbiBOQeq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 11:34:46 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239737AbiBOQeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 11:34:44 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26E0A986EC
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 08:34:34 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id j26so22234954wrb.7
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 08:34:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=LZgd/AqERBom0OWGTCdx0WB2/xdVXWSLUjyprhPBU4k=;
        b=yt4ucE+RVNy0uHftnbJe6F3/A4QQJ2J2/TrIdECY9yDobNJDc3MigQP9naXHDqUA+F
         xkOvDMC0YS7q8hbf2uV5EfCGL+C4evkJN9xNXTdtbO70gC4HhppT2IhRQGvvJy7mU1ys
         +pU45nPdezJwK2ostvxRQoH0Yp6KIHYTkmMNaThi37FnrBFwzbCQKozcL0h2fnfXYMGQ
         HRBypto44il1Vtz18KDmM7wSKk3t2QWlG/pb0lq5KHH/+gs1KPeRXEqcjF4T02Bn6/W6
         UmxaCYtZLhidC4RVzacgCW/j/BqncatDOj+ZpQY5s6S1jhAWD8nYwds8isDpVFWJMfeX
         zQug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=LZgd/AqERBom0OWGTCdx0WB2/xdVXWSLUjyprhPBU4k=;
        b=4YaRUwddToEB9L2HpslZ301WBf1QtnRRtcSLRBIYJTDmcyRwRZ7UuH0uoiyVha/zLO
         D4BJe4xpA69gOVejgMosB8xOn3sdZ4hZwQ1GRuAWes4NRUeGVGkS4htu6brudY4rVoXs
         +IKlj+iPdg9X1HpbYnUkouKkI4ac/9InZIVvYSGbd0MAwXb8sN1ib2wrgnuNavwzaS/j
         3xxLhHxba/rLeGy5KT6vnJB5pXHI5Y3Q57IJacCCniBgy+tEJg/uwMylVRJ6ZEkapwY1
         Zb3H6uD9R8hZYOSMszIyMpIWg5eivCR1urvmkxqjx9mgHGEVbA5Lb1a5VkpJ5KJQmp83
         2CXA==
X-Gm-Message-State: AOAM530J0mhovKC5ok/rEI9VqexRtvYtFgh1duk8x5eYyEs46A51/bbi
        VgkCSWolHcKimWQCfsTt/4swM6MY75ni+A==
X-Google-Smtp-Source: ABdhPJzqT/gVLs6odXvxcvVxivWd0e3NXWQoD7Ize5Qdp5ZHwTNcjY4kACRCe0AflBnPNgva5UPRhg==
X-Received: by 2002:a5d:584d:: with SMTP id i13mr3381323wrf.533.1644942872616;
        Tue, 15 Feb 2022 08:34:32 -0800 (PST)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id y6sm8829220wrd.30.2022.02.15.08.34.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 08:34:32 -0800 (PST)
Date:   Tue, 15 Feb 2022 16:34:30 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] mfd: intel-lpss: Add Intel Raptor Lake PCH-S PCI IDs
Message-ID: <YgvWFhK3qpGJJpRn@google.com>
References: <20220211145055.992179-1-jarkko.nikula@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220211145055.992179-1-jarkko.nikula@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Feb 2022, Jarkko Nikula wrote:

> Add Intel Raptor Lake PCH-S LPSS PCI IDs.
> 
> Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> ---
>  drivers/mfd/intel-lpss-pci.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
