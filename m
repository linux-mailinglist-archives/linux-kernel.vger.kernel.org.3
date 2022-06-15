Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AEAF54D48A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 00:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349490AbiFOWZR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 18:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236639AbiFOWZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 18:25:13 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FD7F31DF5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 15:25:12 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id f8so11561796plo.9
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 15:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=ZPjP9p/uVKjgescd2V0zdX2+EdmJKxQJvyV74R1o4jk=;
        b=jdoU6/kwxsiyhuP27wcopcyJgsLTdAyVDdJin0zRGKDDVlI0xRyt+YxX0js4J1BqLN
         dNj+dY7znGpUHqeMyYFyH53XWuQBGg4rgvZ8yWVJ+5FCCnBr6kcoQMCV3ogLgrYkeBzV
         xL6+27q/oYPdd11Js6mxp9nQk1KxdI0xYWNKPzLOWJEol5NahaU4l9eLRb7J9oyBL5ej
         l0h0Maj35qZdfbE40NmPvf2kkmy7SeahUU1w5bL2czOY8qESszurIrHcWXXqlHzAcf3r
         HTOatDEXJXftalCP9F4BVj7cenhGtebJLg/HFJKsz1tqC1+O4qsHSpXUdWgo9tJXxQuZ
         /8EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ZPjP9p/uVKjgescd2V0zdX2+EdmJKxQJvyV74R1o4jk=;
        b=eEYXRYILUzyc9y0Wap/HMDSrG+MZEsyJFlbeVMXt5xwiy/2HWGewPimI4BLLAjZ7Mv
         6qnn2S0RiHFwVkB7f48wUPXpgTDMGZJBxQNMSBDEL5Q28nKiZsyjcpftEYHT/FTJfq3D
         m2j0PPQc7YRvklIecJhUXO0Rm48Qu3/q3gIkGefnZDSBWxqerviQfay3kRL5r7xAYJhK
         zBGSMywfY+IdfmmcA2IPhVToWGr9yGwT/8sPYK5fFdecXj2F/3T75IBBLs06yNu+0qRf
         T70M5/ObOrJC5r47ri+efzls/kin/P0HwalsEIyRAdkMzGq+rDDjbF1/U/nshp3nWcge
         aTRg==
X-Gm-Message-State: AJIora8vslsS0lqZpebbXffZcE7/pHGCzxFBFS6DQOaRALB3Fxot2QCm
        CQXqYfBGwRGG/XjyXHsleQXStw==
X-Google-Smtp-Source: AGRyM1v7iepztO3D37M5/039LZHAq3jQ9KgC7Ky8PJSj47BCCc/5TtWJHzrR6q+A/NVvbhWIdeTTNA==
X-Received: by 2002:a17:902:8f8f:b0:167:7fa1:60e2 with SMTP id z15-20020a1709028f8f00b001677fa160e2mr1434948plo.121.1655331910615;
        Wed, 15 Jun 2022 15:25:10 -0700 (PDT)
Received: from google.com ([192.77.111.2])
        by smtp.gmail.com with ESMTPSA id ji5-20020a170903324500b0016390e0db7asm135292plb.121.2022.06.15.15.25.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 15:25:10 -0700 (PDT)
Date:   Wed, 15 Jun 2022 23:25:08 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Fabien Parent <fparent@baylibre.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 4/7] mfd: mt6397-core: add MT6357 PMIC support
Message-ID: <YqpcRAihWIba6jmr@google.com>
References: <20220531124959.202787-1-fparent@baylibre.com>
 <20220531124959.202787-5-fparent@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220531124959.202787-5-fparent@baylibre.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 May 2022, Fabien Parent wrote:

> Adds support for PMIC keys, regulator, and RTC for the MT6357 PMIC.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> ---
>  drivers/mfd/mt6397-core.c            |   44 +
>  include/linux/mfd/mt6357/core.h      |  119 ++
>  include/linux/mfd/mt6357/registers.h | 1574 ++++++++++++++++++++++++++
>  3 files changed, 1737 insertions(+)
>  create mode 100644 include/linux/mfd/mt6357/core.h
>  create mode 100644 include/linux/mfd/mt6357/registers.h

Fixed the subject line for you.

Applied, thanks.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
