Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E7464B51AD
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 14:33:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354170AbiBNNdG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 08:33:06 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242090AbiBNNdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 08:33:04 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9591549264
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 05:32:56 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id s10so13353003wrb.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 05:32:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=I9JiPLxl5rUxI3PgRFUPaRwr5y2I4XVH1+w9QXqoIDk=;
        b=EdRemXb4WctxqcQjKGQRRUSwUR68w6z1tUu6jFPVCYSu2qJwFHx9DomI+tUYurYm6Z
         4FYQefakDrTyQdRXSKSVlx1Cgl4mbomdlAfppE9yyuQd6V0K/Rrt7R4MBjoGqIt7BzOE
         P31fpg8nTQv34sBYZm/RkPibPtRuF7Hy6PUpKiA5GScsugNgb09nS5vJMlBGhYKfsYD3
         btPtEAARFN7AQjRfEQ60MQjFGyW8zlcNflmZXxyaM9OZLIRxGwmKAawIZ63gQD/QTZ0O
         6q3W7Nat0nQ1Fd0GCSrqsI9Ln9w+DfMDC+sU4dDnYFPYiDtVQMdR9TWnP552AlknLTy2
         oXeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=I9JiPLxl5rUxI3PgRFUPaRwr5y2I4XVH1+w9QXqoIDk=;
        b=6fW5x0YCY1/YSV2wEfJcCoIsYZCPIRWU7vcjyyuoVWqkZ/20WfFsXKugAfVMR7ENpc
         9T9ubwlP9k8Eys+wwBj6BCFgmjhUHqIVUiYl4a0ZESWk9ftlRFdwMvaRtvnzstyH0Svd
         LCEcsGQChqhPwA1caaPEd4Z5hl4nOW8k7bT1uN3QChiBRt8rt+GT2haxPCFbPXqTBgM4
         kpOI3KcL/9qM4QRI2Qd4l1PFFEkS356SzypXh5YvNTPJz+dtn4xpq7Mtv5cjnMyPrraB
         +e+jx7wiclTrHGyQOHo207gvSWtftPQ70HEuyBm+rWKYm4p2XRq4A+K03tvBMy+jKJ02
         BtXQ==
X-Gm-Message-State: AOAM532E6hTVRv+nvanvlPddWRhZ0Hlzxz+cBPsKmwSK9esqLNJymg1j
        3oLsKCgHBHxnL50isyX7bWLZ5w==
X-Google-Smtp-Source: ABdhPJzBj32BlcfgaBSh3pAhx+ojoha2NOJ3vhdEpsjUZ2ODBzIOh5kM+gS7tXi+u7oJJq5Sc+2Gtg==
X-Received: by 2002:adf:e10e:: with SMTP id t14mr11233637wrz.299.1644845575128;
        Mon, 14 Feb 2022 05:32:55 -0800 (PST)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id z7sm8492737wml.40.2022.02.14.05.32.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 05:32:54 -0800 (PST)
Date:   Mon, 14 Feb 2022 13:32:53 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Subject: Re: [PATCH] mfd: sprd: Add SPI device ID table
Message-ID: <YgpaBWGMa26tnM2R@google.com>
References: <20220202144336.16514-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220202144336.16514-1-broonie@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 02 Feb 2022, Mark Brown wrote:

> Currently autoloading for SPI devices does not use the DT ID table, it uses
> SPI modalises. Supporting OF modalises is going to be difficult if not
> impractical, an attempt was made but has been reverted, so ensure that
> module autoloading works for this driver by adding a SPI device ID table.
> 
> Fixes: 96c8395e2166 ("spi: Revert modalias changes")
> Signed-off-by: Mark Brown <broonie@kernel.org>
> Cc: Orson Zhai <orsonzhai@gmail.com>
> Cc: Baolin Wang <baolin.wang7@gmail.com>
> Cc: Chunyan Zhang <zhang.lyra@gmail.com>
> ---
> 
> Rebased onto v5.17-rc1.
> 
>  drivers/mfd/sprd-sc27xx-spi.c | 6 ++++++
>  1 file changed, 6 insertions(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
