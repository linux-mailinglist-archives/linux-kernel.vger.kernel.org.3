Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAD0C54D48D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 00:27:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350215AbiFOW0D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 18:26:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242770AbiFOW0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 18:26:01 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3BDA51306
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 15:26:00 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id i64so12667589pfc.8
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 15:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=PhsSixX/qIegggQ5xjphGxZRHvJ/OEH0jIlsRPAAQm0=;
        b=jECmfGSYstnqaxcRrTgZP5JAycoHs5xHRilb4VyHR0fHpBMbaXfFOeO3n6Jbbh5beA
         fR6s7KbigWwSGO/IkBQmncbFf0e5pg1gzOq7k0XxWjSzggZvZUH/Bmd953k52Tsy6GR1
         PyWLuf7heFRun0WTH/TniVecnEBlyLSOzBYG/HObB8A3zzLYc/oBitEkoF4arIpQtBDm
         8OZfJQ8snzRxwFThCUV9khBGxoAV/CH6P3jYjSmzTYx0EFzpTn8sjREmWRLz4Z4FwFIs
         9WlxEeGNNEJ8OA7vE/7trRewubuZI2ft2YiX56n6G1UKocriqe+oLjyTo1yALvrEM/34
         f6ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=PhsSixX/qIegggQ5xjphGxZRHvJ/OEH0jIlsRPAAQm0=;
        b=lVex2O/tQ5piOCDIAd0JEuuXAwK7p5froP+uRoDSDqfpv2mbWYpftQEu0LBDh45C+R
         hwU77M1eOle5ZvEUT5qFHzRCs2jyl8gPIGtPY1/EFYG/ZcEBG2Kopphd94XauXkQke9C
         hiIZ4J2XdghEF4mm9SfNYmG1cgK/Kx7g9qa/nvaMUdDZ2Z9I0jq+CVK04Kr1TzrT6qp7
         6DerwARwTaLZJ7TdhTtmty0LD/UEuHYa5Bpr8P1wWHRNMDctixdyqASR/7lftldpu+mM
         S1pWFYas+fVCh8yDz6yd3hQZ5O3OrwwRNfdkCDuLvBuo85dRtm+ndOhepzcDmauTYTQH
         0QqA==
X-Gm-Message-State: AJIora+xTQ5eUSz8IaeLD6bdj1Vsjrns/D54UajL6+sVvzVtPJmDBBQL
        p56DuPXL4i57Hwpo0P3RRrwZeQ==
X-Google-Smtp-Source: AGRyM1t5Z+CeN6seTkZECmQqflRZfLTXrCI+sKYnhHustZ3Jap6ITSkAmhQieyoPoyDyS7fwC5ngsw==
X-Received: by 2002:a63:6f8a:0:b0:408:bd01:ef4 with SMTP id k132-20020a636f8a000000b00408bd010ef4mr1763774pgc.216.1655331960155;
        Wed, 15 Jun 2022 15:26:00 -0700 (PDT)
Received: from google.com ([192.77.111.2])
        by smtp.gmail.com with ESMTPSA id x5-20020a170902a38500b00168d9630b49sm100605pla.307.2022.06.15.15.25.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 15:25:59 -0700 (PDT)
Date:   Wed, 15 Jun 2022 23:25:57 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Fabien Parent <fparent@baylibre.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/7] mfd: mt6358-irq: add MT6357 PMIC support
Message-ID: <Yqpcdb6sznziWMDo@google.com>
References: <20220531124959.202787-1-fparent@baylibre.com>
 <20220531124959.202787-6-fparent@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220531124959.202787-6-fparent@baylibre.com>
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

> Add MT6357 PMIC IRQ support.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> ---
>  drivers/mfd/mt6358-irq.c        | 24 ++++++++++++++++++++++++
>  include/linux/mfd/mt6397/core.h |  1 +
>  2 files changed, 25 insertions(+)

Fixed the subject line.

Applied, thanks.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
