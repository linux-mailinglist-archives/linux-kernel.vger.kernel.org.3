Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D897251002C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 16:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351496AbiDZORq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 10:17:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351526AbiDZORm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 10:17:42 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05A641B79C
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 07:14:34 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id d5so10472895wrb.6
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 07:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=GwSgZwLnSWAbv/vQtx67c0Kb1Ry/IzNsMNgoWh4uXl8=;
        b=IARE7tZf/CAKvRS/bt45+YUtxGqCyjJjhWtw0Vbp6Vg5QPk2iv3VU9yjvc5SMIiD5K
         Nl0Tfd8Tb0GFQcpoTjdLjp/gqFaNwtBbH+pHf6B/xB3DVgcFnL4WqprDkvdwtD4ELuvx
         6cdmN4wCoe8sR/qk+ddpsMv1fncw7JuRs1NeSqHLjHfFwpHhIMo0gnxIxYSZB/eK0/0z
         dWCm1yK12E0p4ixIXMrVchwSC6ZBBO3CMlyFh/jOAxxbEqjRtKeovTSQdH5ZDYtas+BP
         C+22pagTmMagJeUfEhaRU4ouPvSyT46oRDmxceJj84b/4c0LBbwqa3akR5DpVv+ZIpSW
         M7gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=GwSgZwLnSWAbv/vQtx67c0Kb1Ry/IzNsMNgoWh4uXl8=;
        b=QmBIuQv2Pj8aXq2UX2x8pYK/OOcFPiH/k0AlVfU/nrjC8fc7297cxuJ4uTuphvaVtc
         lOYntbhwLKGapVJBbfmDm0tWOXPPIrQ9uxGungGqqbgsxAn1NRjRkH4qHiQEbIGylEx3
         xot/dSpgYBMcqPspcYf+inKDO3I/AWpo8nGUjev4TXawEw6YI7K49njSEDaVPGRkTI2L
         EdJ1BftqlVfuxVsnusDspdQG0uqKyqDYVkgrOKt0+8MPp2HXWdEoDgPSjvNg6FJ7Deu/
         Rd0yRCtApr9soOrTExofW/10IX5fpU0sSyd/bMxKPjKuf6khFEuNL2LaZZSf4+fbHim1
         7pSg==
X-Gm-Message-State: AOAM531bhxO3LBCRv9/yvebtse40BKIp9JU/4IW3uWvrqNrAhFO+M3Zq
        mvzYHr6hkBrq9ulkTg74sET9Tw==
X-Google-Smtp-Source: ABdhPJxBszac5Q9wXycZub3pRwL1M5/pzhYNR0BDWKWENX2tuqHVlvW1EsJG1wll4vQcTgMnYQ5onQ==
X-Received: by 2002:a5d:64cb:0:b0:20a:903f:5d70 with SMTP id f11-20020a5d64cb000000b0020a903f5d70mr18365199wri.138.1650982472624;
        Tue, 26 Apr 2022 07:14:32 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id r3-20020a5d6c63000000b0020a94e82a3dsm11962437wrz.64.2022.04.26.07.14.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 07:14:32 -0700 (PDT)
Date:   Tue, 26 Apr 2022 15:14:30 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Fabien Parent <fparent@baylibre.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/7] mfd: add missing defines necessary for mtk-pmic-keys
 support
Message-ID: <Ymf+RuFUqtyzHeQA@google.com>
References: <20220415153629.1817202-1-fparent@baylibre.com>
 <20220415153629.1817202-3-fparent@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220415153629.1817202-3-fparent@baylibre.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Apr 2022, Fabien Parent wrote:

> Add 2 missing MT6359 registers that are needed to implement
> the keyboard driver.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> ---
>  include/linux/mfd/mt6359/registers.h | 2 ++
>  1 file changed, 2 insertions(+)

I fixed the subject line for you and applied, thanks.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
