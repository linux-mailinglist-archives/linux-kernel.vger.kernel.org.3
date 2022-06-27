Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ACED55CBDC
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232260AbiF0NKi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 09:10:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235390AbiF0NKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 09:10:20 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E43FDFB7
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 06:08:50 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id l68so348304wml.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 06:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=nlg57mv70v9AVNuZPlQ0cGMYh7L5NWWC/fflq1ZXv00=;
        b=hbgx+lmq8YHYqHsMCoF4o8kVvhhHZ2XJSclU56lrtbsBwTF/fMHh/dZvo1aP9SoX6Q
         +CeRqXZEjIItdpPAqnKRrM9r09HtVRV/uXMlz7JhnewFrgSn0sE4c3teGI/5AoAAH1GE
         3Y+55cadce6lbc2LkWHYWVnDGEz8a2KN8p+TidtAyIlJ1i73zjhYek3qTyNTlg5u1zl+
         fNUyuVKMS/J8qISswL7cSWFLQ+BBcscmKYTomPNAQYmF3WJduMRJJkSNPlcyXzyXzqHR
         VCdKgPGEpJVY/2DsqKhJycI8U1Jp7YuSuApyosNAMm9RyYlC9vUslcAvhmSD4ldg2Qr6
         5E9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=nlg57mv70v9AVNuZPlQ0cGMYh7L5NWWC/fflq1ZXv00=;
        b=WQrcykoachC5LSVVFFdLkQ0mCPqvNvg1lBc7GoNtaLp/JGgPOcpKd4c3k9rjQcXuhX
         T2lQOjLBw+1Wq+yY44JC8L4mCS/N6kAa2Sy5lT0DOVhiuKjXDOHi7T3TWZyOSlXSLIqE
         HiSDaIogEtHkEXsuGBRCxu4nkx41qOl1cgoOlvT9q5+FgdUOd/K1kfYDfIRJmb6a72Me
         piK+AufOsuK4obOn8tvaBTMsTgpDFLnimZwYkg2s0jesuRlnGJ+USQfaRpprCLs/cgP/
         1BgExGNRCwqPpNVrJat3GqGS5PnNick9OoA5FwdaGON6J0qknnkZtb23ECy8d2S8HL5k
         vVVQ==
X-Gm-Message-State: AJIora83itwfbeMA6ctIOP+bJuso061k2IqgeHtxOk7kO8UrX7wiy0ty
        gHtzp2hDIEAmg1ScQYH2xFiijA==
X-Google-Smtp-Source: AGRyM1twygvIqZHJgXHRzRVSUtf/NqFb6Fjq1cgtQZdh6qmWhfRxJR6sALiuXscoiGhRdfj+2SqCuA==
X-Received: by 2002:a05:600c:3d99:b0:39c:55ba:ecc3 with SMTP id bi25-20020a05600c3d9900b0039c55baecc3mr20574840wmb.42.1656335321904;
        Mon, 27 Jun 2022 06:08:41 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id n2-20020a05600c3b8200b0039c4ba160absm5998973wms.2.2022.06.27.06.08.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 06:08:41 -0700 (PDT)
Date:   Mon, 27 Jun 2022 14:08:39 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v1 1/9] mfd: intel_soc_pmic_crc: Merge Intel PMIC core to
 crc
Message-ID: <Yrmr175fsQi6ToEY@google.com>
References: <20220616182524.7956-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220616182524.7956-1-andriy.shevchenko@linux.intel.com>
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

> The core part is misleading since its only purpose to serve Crystal Cove PMIC,
> although for couple of different platforms. Merge core part into crc one.
> 
> Advantages among others are:
> - speed up a compilation and build
> - decreasing the code base
> - reducing noise in the namespace by making some data static and const
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/mfd/Makefile              |   3 +-
>  drivers/mfd/intel_soc_pmic_core.c | 160 -----------------------------
>  drivers/mfd/intel_soc_pmic_core.h |  25 -----
>  drivers/mfd/intel_soc_pmic_crc.c  | 162 ++++++++++++++++++++++++++++--
>  4 files changed, 157 insertions(+), 193 deletions(-)
>  delete mode 100644 drivers/mfd/intel_soc_pmic_core.c
>  delete mode 100644 drivers/mfd/intel_soc_pmic_core.h

Can you submit this again with the -M flag please.

Trying to figure out what exactly changed is proving challenging.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
