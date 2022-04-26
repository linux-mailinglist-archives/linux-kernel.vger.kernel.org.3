Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61F2351002E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 16:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351506AbiDZOSH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 10:18:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238550AbiDZOSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 10:18:05 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 869F718E3A
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 07:14:58 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id j15so12427319wrb.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 07:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=YH+GE7ibZOz8nvgUaj8COsFNcJ+TqdF6V4nk1yzCsxw=;
        b=ZL5cLQCqZYNS4CQLi0TWfPze2PRkgMiFgpQCIR5G7x9xisLoTRW1a8c7Ku9DjlEzsX
         Tk/uuczf6Ky8A/j1sLSr8QiBp/JjZS3Kiq/cg0Ehk9VT3lxZXfxtyIzB/+qNMOnxjaaZ
         ORPWowT9HtlBzS6XU2VHjzLWUsICQDB0huvZ1pYb6Wr2/S+ga5/cl00avyGqyxadrslA
         0nHb1PT1zIA82mD2JEx/lLwmLeicLCkZPK0bay1jqK9lYAnXSs5KNCqZr+ejYhsUIX/6
         GeRmf4PXE/gaIJYVLk0VNgvLfmCVYY6M+MOKlA2Sw+WMOPsjkPQGvGniSEsp2oFL1i1D
         cnUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=YH+GE7ibZOz8nvgUaj8COsFNcJ+TqdF6V4nk1yzCsxw=;
        b=aB+ekS7DpUvKgxjaX57DutlTW2AhnjnCltYaO8loUKdPTiElOWc59vG9NmnFB3ZgeB
         ZFZhCoPm2Odwyf2JO50Vk8SEZi2nGaRIoJcOoxP/fQrtRvVHND0sjbNu2urWNvnnlpH1
         TCmtdtYZOz5xM/rvZ2Z+Prg8HqOHFQ/lqOK4wE/uPmZ7lg2cnwUT9+QLU4XZW3q8Izy3
         zJLPRazgRpP3McXxbdwnZ+Br5TJh3M9LkbTCrxVDZajhQtf8tyGD3Xya/1A7Mkc2wnyh
         L9ypBgJaHOLHSDZV+P8DLXVgYAHD0aJQZdzpWYXMCT9/6QXgZxW4Hgfg6FIy2I+WPev7
         SdYw==
X-Gm-Message-State: AOAM5312haCcuovLdt/sRAF5EpAtfEQpDFk5eRuEbPGLe00W59jQKiqA
        lzy8/4KoH7PIOcV02/NIKwQJNg==
X-Google-Smtp-Source: ABdhPJx7hmR/kuTWZnYQXz7AudGSpe6GTBSsqt6Wp5WE7bP0xS0edDJhbuesOs65Rcdrp4zXq78k3w==
X-Received: by 2002:adf:f946:0:b0:1f0:62c3:ea2e with SMTP id q6-20020adff946000000b001f062c3ea2emr18309739wrr.348.1650982496973;
        Tue, 26 Apr 2022 07:14:56 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id d17-20020adfa351000000b0020adbfb586fsm6086115wrb.117.2022.04.26.07.14.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 07:14:56 -0700 (PDT)
Date:   Tue, 26 Apr 2022 15:14:54 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Fabien Parent <fparent@baylibre.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/7] mfd: mt6397-core: add resources for PMIC keys for
 MT6359
Message-ID: <Ymf+XudxaqucHdAB@google.com>
References: <20220415153629.1817202-1-fparent@baylibre.com>
 <20220415153629.1817202-4-fparent@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220415153629.1817202-4-fparent@baylibre.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Apr 2022, Fabien Parent wrote:

> Add the MFD resources in order to be able to probe and use the keyboard
> driver for the MT6359 PMIC.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> ---
>  drivers/mfd/mt6397-core.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
