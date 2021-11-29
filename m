Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B494246161E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 14:20:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377789AbhK2NXP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 08:23:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbhK2NVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 08:21:07 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D147C07E5F5
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 04:02:55 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id s13so36303778wrb.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 04:02:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Mzuzdt862XtduWs6io8LETGBPfeA1y8iFr1ItmbZvOY=;
        b=yOPpqT8FyMWk66ETTMI1ixUS/Bp8AF42M1pZrYSBRt3rx9r2AaZqvBP/jtAGLTxICp
         p6oghWPlZVb+0n8MTnuFVpdsAPVVAiVb3abBvJWEb9SeFYlYF/rwvcCIQbsDKLP4vb7/
         JMSZuM3G6ahsEXhFQZ5Ie9uSUA4SgT13NsVcojaQRfqy4SVgly8X8hnCcYZOoJjzL0Fm
         ugVgmL73IYbCoxyEjWR+KaJN0vkYforW3VZsS4TiAVfIhyjPPpzq/heUDum63d1XY3Fw
         hf2hEwM1uFSzGNhlwjcgH1DnZq7OlfHksGYYXLHHIERt09BVn8CaerVXcvYL5ioESOd8
         DpeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Mzuzdt862XtduWs6io8LETGBPfeA1y8iFr1ItmbZvOY=;
        b=mDMl4jxDi1FOg05iy7r4hKeVT9COxnW618sxUPYE/sJ8gcmgtVzythYTFAeqZmyzWq
         iIhPOWdsJPn3Oux6QeQcGc0BBG55zVPLoEZC32D2QfQK6GVaitT1zBxxZWciX2apuA4P
         xZ6Dvc4s7ePKM+B39gfwAFvJ+ZKdDUA1bckqyvQSw1cQVHbla4KhBse7BcaPma74DfOw
         vYPMDYLLZFJsG89sMgg0It43oXrwvpcqecHkLO0Zk4gKc4oduJ01S7yp6TM7B2gSs5Hr
         N6An9UylQ24HVF9E4ey+gXiM2cG8D7OJIfrchz/aoHXPlMYFN5mDo/Dt8JUvIVw1uW8I
         Xfvw==
X-Gm-Message-State: AOAM5336P/0/pFW/3/WxRqaZdPdtGa/NR6qyKTUeY19FLks98sw7nTTL
        qOOyJOzEIlzbBH3E9sBvLEtXPQ==
X-Google-Smtp-Source: ABdhPJzZ2jDcntSnu48WN7FcjWPJqDhglRwCHAL5EpuZUcY8GyVrSU1DbbFPbdXOTxTzZvWce0y9sw==
X-Received: by 2002:adf:fd90:: with SMTP id d16mr32786108wrr.385.1638187374100;
        Mon, 29 Nov 2021 04:02:54 -0800 (PST)
Received: from google.com ([2.31.167.18])
        by smtp.gmail.com with ESMTPSA id m20sm22380070wmq.11.2021.11.29.04.02.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 04:02:53 -0800 (PST)
Date:   Mon, 29 Nov 2021 12:02:51 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>,
        lukas.bulwahn@gmail.com, Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-power@fi.rohmeurope.com
Subject: Re: [PATCH RESEND 2/4] gpio: bd70528 Drop BD70528 support
Message-ID: <YaTBa5Nucx/i4mnc@google.com>
References: <cover.1637066805.git.matti.vaittinen@fi.rohmeurope.com>
 <4eff6bd5eff8afc137dd8c1697cb5c6b2e3aacd2.1637066805.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4eff6bd5eff8afc137dd8c1697cb5c6b2e3aacd2.1637066805.git.matti.vaittinen@fi.rohmeurope.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Nov 2021, Matti Vaittinen wrote:

> The only known BD70528 use-cases are such that the PMIC is controlled
> from separate MCU which is not running Linux. I am not aware of
> any Linux driver users. Furthermore, it seems there is no demand for
> this IC. Let's ease the maintenance burden and drop the driver. We can
> always add it back if there is sudden need for it.
> 
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> Acked-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  drivers/gpio/Kconfig        |  11 --
>  drivers/gpio/Makefile       |   1 -
>  drivers/gpio/gpio-bd70528.c | 230 ------------------------------------
>  3 files changed, 242 deletions(-)
>  delete mode 100644 drivers/gpio/gpio-bd70528.c

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
