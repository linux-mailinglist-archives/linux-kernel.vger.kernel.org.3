Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEE774D00A0
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 15:02:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238372AbiCGODH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 09:03:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233099AbiCGODG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 09:03:06 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF7A78C7F3
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 06:02:11 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id r10so23465323wrp.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 06:02:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=xzFQ38OjB3LzRyTVYA5FQA1ysjpyn9F2y7UN86UHNqc=;
        b=SLhfXNkAmMw0K6tlxM9rWjx//XXT0HbeLq2ytEPVK/hOFi6hGM2s1KVlIRPJVBVaKM
         03pbS/UPTanwZLp4edjNXDM9ZjBCY8R0g5SZSEJNesnWJgMRx96cfQifWJxtJA51/MF+
         +ApMeu1IcHvEtHsYe8kfbs/5QPS+SKYWOfULER4kDJocquytg58kxzCN/tybQ9SpmIGv
         aSgXRBlIZBFngwrWmB8Uql56uG/HWRThrNbPMHqFNtIhGBIF9FWTCU1P60jnOY0eUXME
         pNAgI77SWMy0IeNxwDmfyXn34QqDXjHvohxmHZ71PahUJVAzIgfGdLQM8GQmRgLDn68R
         5etQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=xzFQ38OjB3LzRyTVYA5FQA1ysjpyn9F2y7UN86UHNqc=;
        b=12MK8GyRxMl1o3MOtRJIwhtDvYNbJvPP+0K8SfykHy/RL0MULeNHVMTC88be267Bng
         r3iACIPJohrckpFWUPlELveB3wRgB9DVt2jkdKsJMLfOpCs9N3NTRChKFV41C/M5hv4e
         EzA52EhGH5dP8dvTD495hzMQ2TmjhbPOk0AcKARkj9s7XOg1shp8nj7AQZmX2XXs6CLU
         Et13CsDB3No5pQuBe4J8U06WOtdxN4bO2PSeHle5ZqMHrmE5x8Lfw6nS4NN4JEseIWr4
         hb6NYm0OcepBRZPrt+oeSfiMMlPTo+39QrWA1AUCQWxkoR9MsjyISaS9VbhYTCd8a4GG
         uUYg==
X-Gm-Message-State: AOAM53014Cq49l6x89rtGjpdSWvCuKFbDdg5C0iZ7GnEF4jh265uzlVy
        0Vc4xN3+NTv4awLZVcr1idr8MpZwwvd4/g==
X-Google-Smtp-Source: ABdhPJyp1k5ZQN8Um1Ax2ClGD7NoPM8bN68UuG0PDo3FTHXriDP+L0P7MIuILbsL/JA4H8NnOdbJkA==
X-Received: by 2002:adf:eb44:0:b0:1f0:483c:f015 with SMTP id u4-20020adfeb44000000b001f0483cf015mr8072395wrn.397.1646661730269;
        Mon, 07 Mar 2022 06:02:10 -0800 (PST)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id g11-20020a5d554b000000b001f0326a23ddsm11667854wrw.70.2022.03.07.06.02.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 06:02:09 -0800 (PST)
Date:   Mon, 7 Mar 2022 14:02:07 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: mc13xxx: Add check for mc13xxx_irq_request
Message-ID: <YiYQX/kxPHHSEDyx@google.com>
References: <20220224022331.3208275-1-jiasheng@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220224022331.3208275-1-jiasheng@iscas.ac.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Feb 2022, Jiasheng Jiang wrote:

> As the potential failure of the devm_request_threaded_irq(),
> it should be better to check the return value of the
> mc13xxx_irq_request() and return error if fails.
> 
> Fixes: 8e00593557c3 ("mfd: Add mc13892 support to mc13xxx")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> ---
>  drivers/mfd/mc13xxx-core.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
