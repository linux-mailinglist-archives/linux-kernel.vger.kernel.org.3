Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7EF55112A4
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 09:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358937AbiD0HkR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 03:40:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358917AbiD0HkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 03:40:14 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E484B42D7
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 00:37:03 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id d5so1228725wrb.6
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 00:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=mZfdSBS5y4Rd+9lmJZ8ioIg+rdXI0dbRJJuRv/YMkM8=;
        b=narrBJyCAB3/b6WSQwSVZC73+9V9ChoJt43reBAga257AD0hWwVtC5ZbLKL9r6gX15
         2WxOpQvPX1p3dxWfiHoiwddh7WSUO8FU/J+9ycGIFba2rIpXSTif4UBKbpBoqLrZuwfG
         NzQqUPn0j0Pw8KB9+1Xecmam15sn/KyqaYYmlvC1KylXeCJxu0Mmg5H/IlEj3iW+ZdHG
         KvtMVLrNUXa1A9igfviWjQg5ODbUFy00WpoL8h0s9dJaMbEMtmt2pDJ4X86zQ2kdFitB
         c6dLgIQ57fC4P9IX+HabHNSnQ83+tF6WTukhnJ9TE8O5KNG2MdcNdEcNa/3WgWAkjJzH
         1W5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=mZfdSBS5y4Rd+9lmJZ8ioIg+rdXI0dbRJJuRv/YMkM8=;
        b=pjLrqzV+FcokUdliIdD4FQrn7EaT3fz9pnLddWHH1ERPWCDW7Iid3SbcK4DZDn39nZ
         O06rm+RvRv0h2D7JCYoEUkZfSSE9xfntUfsApsRGSqLQbfrAZz8hMY+X4URz24LJrh4A
         dFQN7RSGuFvdU91rwLKrHaiz9CjWmQq+IiAeKn9lSbLll12CYv+sLbm2CqAttIVjxLeJ
         /dzMyA5/02/rgQRM7NNAnBhvlZkEV9RniUXOQLqjnMx34N7sUzgaU4cNXvKfCLrCP2Bo
         Gfv+sy7RYIbAOSbJrzlbkm8vpNFUyhS7gLcb8Jpb/8U/ggwLVDomOKqQuhNBxWV4sHmI
         97AQ==
X-Gm-Message-State: AOAM531zpUmtAvuwE4sdCvjN0SQS/sBjm0wHOi0Rci7NMCdeYZe2BMa3
        euQy3nOcVOw/M070SLvQDRbJyw==
X-Google-Smtp-Source: ABdhPJwLCDIcuRhobkJvaKdehCnH4H4F8YxZLNWgH4HjTZb+2mKiLq7XOLkn6zKMEOvLwlDCBMhRRA==
X-Received: by 2002:a5d:6545:0:b0:20a:d761:bf0a with SMTP id z5-20020a5d6545000000b0020ad761bf0amr13367149wrv.180.1651045021850;
        Wed, 27 Apr 2022 00:37:01 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id d17-20020adfa351000000b0020adbfb586fsm7853296wrb.117.2022.04.27.00.37.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 00:37:01 -0700 (PDT)
Date:   Wed, 27 Apr 2022 08:36:59 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Cixi Geng <gengcixi@gmail.com>
Cc:     orsonzhai@gmail.com, baolin.wang7@gmail.com, zhang.lyra@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: sprd: Add SC2730 PMIC to SPI device ID table
Message-ID: <YmjymxFi6Z1s6LLV@google.com>
References: <20220425132410.2708304-1-gengcixi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220425132410.2708304-1-gengcixi@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Apr 2022, Cixi Geng wrote:

> From: Cixi Geng <cixi.geng1@unisoc.com>
> 
> Add the SC2730 PMIC support for module autoloading
> through SPI modalises.
> 
> Signed-off-by: Cixi Geng <cixi.geng1@unisoc.com>
> ---
>  drivers/mfd/sprd-sc27xx-spi.c | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
