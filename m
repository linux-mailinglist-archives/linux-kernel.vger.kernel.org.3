Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 960F457300E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 10:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234450AbiGMIGW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 04:06:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230364AbiGMIGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 04:06:20 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F004E1900
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 01:06:19 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id r14so14380643wrg.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 01:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=TIuaU3v50n7bUWKXly5YPZTHcqli65zdWTasiUb17Ro=;
        b=hNrPkbBaIwtvTfB5o8iVawtfDe4PZtFl8q4aucxnFP2YA/d4Jhlz2kWeEehvpOJA8U
         gtRpOVmxBMZ69rhnKcO8qJdSOi5QIA6NdwhBhFuzYDgBMtV6KlB0Iwj990wb4I0hStE/
         AYiPL8Nyew16SEze9sHV34IsbSpvuw/G3DpfMUA+tawm4lgNIWWFA0WAPcTkRoJuWLZO
         9qYcrZwgzQBtydkW5mWwpzDfrUkdyenNF5tSIAhS/Ko7G6Vz4uujQvQK6FblzG8AlzlI
         umJCV/WtRmJEHWxFKY8kbHEPRgYOa5htHqJIpPtI6TdwpOpVbKMkS10I2++64YDjPgh8
         KuAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=TIuaU3v50n7bUWKXly5YPZTHcqli65zdWTasiUb17Ro=;
        b=1JPAMG0O5AgUGbLsazZWW/0iCztSEY1h67Go/c8HXoI1FguGjPsGLxokqCUzDidx1t
         XmfPcXaOP+NKLb8lahK1ihbP3sXtzx1IiW8gBk66i+l8/9lZatRsf8f3+A6y1DeIqMp/
         WQ40+K+/9/hgv9jw+rTaTAqvBKHyLC6nw3ckrZqzZ1TQJTHesg9e1Vf0Xu6P8OvbwQZF
         OTLqv2BAS0O2kitnJE6J95Xz8n+qWcPdQ1dqNAdAQTR2fO6RZM+O8fFqrAKM2D+lz7Ys
         EVSJK6mfBeo5qf3/TYZdpiIDpql6bL0yuFCK+icLkI9hYSE1owMyWf5TLkHxqXHtISr1
         D/pA==
X-Gm-Message-State: AJIora+OZpabFMwzUnAwHNU2Y2/TNiYoh3MfIA8OgZ6vIH2juw2bn5UN
        jDdCCn/mx/VNw6xeT3bXbvdVvQ==
X-Google-Smtp-Source: AGRyM1uYd8s8Q17nqho/hNGXHSmtG7AshwsRk3tvmpwY/HVGw9Tpxj5Qk00Si2JmE0HOAt5dAYpZ8Q==
X-Received: by 2002:a5d:6e8d:0:b0:21d:7adc:7102 with SMTP id k13-20020a5d6e8d000000b0021d7adc7102mr1859002wrz.9.1657699577792;
        Wed, 13 Jul 2022 01:06:17 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id c15-20020a05600c0a4f00b003a02cbf862esm1376496wmq.13.2022.07.13.01.06.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 01:06:17 -0700 (PDT)
Date:   Wed, 13 Jul 2022 09:06:15 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Chen-Yu Tsai <wens@csie.org>, linux-sunxi@lists.linux.dev,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: sun6i-prcm: Update Kconfig description
Message-ID: <Ys589/sLwmKYiKkV@google.com>
References: <20220702184044.51144-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220702184044.51144-1-samuel@sholland.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 02 Jul 2022, Samuel Holland wrote:

> This driver is used by a specific range of SoCs between when the PRCM
> hardware was introduced (A31) and when the PRCM CCU driver was added
> (A83T). It is unlikely to be extended to additional hardware. Update
> the description to include the full list of applicable SoCs.
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
> 
>  drivers/mfd/Kconfig | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
