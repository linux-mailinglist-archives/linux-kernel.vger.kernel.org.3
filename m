Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F9334B6F09
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 15:46:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbiBOOhz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 09:37:55 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238686AbiBOOhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 09:37:54 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D78F810240A
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 06:37:43 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id e3so32563697wra.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 06:37:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=RJDHQuAlVt8eFVQ5pnBtKr+Cwgoxeg0P8YA0uBIrH2o=;
        b=QBQI/HQJLNR7C3W9VI2NPAlm2c4x9YE3mh/CuUGdUk/WrQw2sgl+huZPFUuJTdq3ho
         tAU0kQ3rCPiM/Mlg7quSfxD93k32nHKDSfXWbv3QdoK04XBxIWn6P7WnKrtqb+Et6MpX
         g4ejz1cDYxHdT6xbI487ChBG22963jhOkirYCMXEPpPGU43yC465ET72j8CijrlxCliG
         Z1d8L8Gu4mrN+YmsSdIdbYhpZCKc7xTdZ2TZvwCmSm2qkkjkTGRE7L0QMzihVjDSsuMu
         ZCSLc3GNu/rio8mcIM1WksY01dZTbKRprehYUSkTybBigZeXSNw3InoGRL71bhNvFimK
         zrSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=RJDHQuAlVt8eFVQ5pnBtKr+Cwgoxeg0P8YA0uBIrH2o=;
        b=zel9ECJHiz2yuv/NDw7i9T1FFFMKdnhISAglPdoFh4uqtP5BeRp6qbiqh6N38OMD5P
         Nkhi/E50D72yfsY9/Hz3tiF4UdCttK71l4xSQvhHBGhYuNHOGJvZDX373cZunTichg3B
         Y9Fr+soWUYPXO/o5LnvuyAm5uN5nBVePrD6r8ynzfkQNRQlvqnPUuN8+/zR98kWg0bIJ
         gqzoGJFoU52jsyqqEPVCdQ25vhp8QmYSJOIAIXB5DHwUWmCsEzhbjihhdupbnSBIsVKJ
         XnvDBVNRhQJz1CRnixS1pd0WKAUnqm2jl+0OewE+RUq1hhT33t1tYAvFNPKYXPnDVtzE
         wRZg==
X-Gm-Message-State: AOAM5302+OObRjeMzHofQFwh4CFHhT2yuYNc5i+dXOo79Nb6GHGDtyu5
        NEKC2iyO7m64fhTDpO+U9S7ohrjTEUaOkQ==
X-Google-Smtp-Source: ABdhPJwKDu5qOwwN3vnGMutQrMQsg/++cnsCG9rF96F7POzZv/8S33Qe9KG/LLdvyVrTboYYtk2b9w==
X-Received: by 2002:adf:fb0f:: with SMTP id c15mr3644035wrr.42.1644935862480;
        Tue, 15 Feb 2022 06:37:42 -0800 (PST)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id r20sm3678211wrr.69.2022.02.15.06.37.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 06:37:41 -0800 (PST)
Date:   Tue, 15 Feb 2022 14:37:40 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: ab8500: Drop debugfs module
Message-ID: <Ygu6tKTrakvjgIqC@google.com>
References: <20220212214724.681530-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220212214724.681530-1-linus.walleij@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 12 Feb 2022, Linus Walleij wrote:

> This debugfs isn't used by anyone, if we want to dump the contents
> of registers we should just convert the driver to regmap instead.
> I'm also excluding this from the device tree bindings when converting
> to YAML because it is not a real device, and device trees should
> only contain real physical devices.
> 
> Delete it.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/mfd/Kconfig          |    8 -
>  drivers/mfd/Makefile         |    1 -
>  drivers/mfd/ab8500-core.c    |   20 -
>  drivers/mfd/ab8500-debugfs.c | 2096 ----------------------------------
>  4 files changed, 2125 deletions(-)
>  delete mode 100644 drivers/mfd/ab8500-debugfs.c

Gone!

Applied, thanks.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
