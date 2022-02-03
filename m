Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A04BE4A832B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 12:33:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350242AbiBCLdX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 06:33:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236227AbiBCLdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 06:33:21 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FB97C061714
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 03:33:20 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id g18so4079466wrb.6
        for <linux-kernel@vger.kernel.org>; Thu, 03 Feb 2022 03:33:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=ihC5hJaqvYSQGhRdPK0mq/Z76ynLvAUUCPiRBOw5uQg=;
        b=K0Nam3dJfnHj+3BDyNnPokPHpA4E6WH+f8vUMRLUBRA5Luaowlbirb7CtWEH1LlyhY
         qLL2maDnUpT9Wq93fEbrY5H3D0iGgq3LPvQfxJrZlVDLz1r2atkhkDswBx0EhOccyj1P
         Mf/M8SOJoWhq9T2tyOpHtw/WzBr4tHw8OBdexFm8BaCmrMlyaDtUD771e/N25ewknx//
         drV9ziL/KdaRiN6rwS9bI3GwmmB+jDId1xp3lm4MRbWfovvI5HUsy1ZAGOY0JSUtjwtS
         AWc+B0l0DytzEiOh/JM44qGoG/zvHXQdC/xJwhDjMZ7Y3gPrQNa4tHpde5XCvzJFU1Kd
         Gy9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ihC5hJaqvYSQGhRdPK0mq/Z76ynLvAUUCPiRBOw5uQg=;
        b=kEv8JLNdqzTNZZvpuMpqCSHxnWpMRF+gPZA0Z0J6cVgIZREpX3X3TtbsZ+M/15tk6K
         /x2tOiVW7o/PUvN0oMMJc6MdsVc8DOuh9YpByC4nwr5WAGrz+KERKTf2c6eh3gmJowcG
         hZPa0wVxAR1/HB3GMGJgSmwfnxH+GSeXYI/4o7mPNwWWi/hpcQ1SCyi00sE+0r6MODKj
         p/AHPA0BPB1d6OmzUZzfDB/dRolUwjotkUyuWERCu43hiJC5M2WZU8XcnXbsdkO0SwCk
         CuoiCEMTxg2LgZ8Vq9JZrd4LoHW3zVMbAVYOQPfiHhCs/75iDZdcU+2+3RXA1X1grwOy
         pmag==
X-Gm-Message-State: AOAM533eyS+XouYgIpBfxe6YIYvcD6SuitD/iw7SwR9AQedmL1svtLwW
        ElyS1hiXF7tlwfiYMuQz909iIsOb2pGAaUGE
X-Google-Smtp-Source: ABdhPJyEvYyyOR1OwmI6zAiFUXsf6iSdACxEm3v/Fiq2gPb5ThkPciCqvRSff9klEBEEjI8eh3gc9w==
X-Received: by 2002:a5d:59ae:: with SMTP id p14mr27899372wrr.643.1643887999249;
        Thu, 03 Feb 2022 03:33:19 -0800 (PST)
Received: from google.com (cpc106310-bagu17-2-0-cust853.1-3.cable.virginm.net. [86.15.223.86])
        by smtp.gmail.com with ESMTPSA id z17sm6929238wmf.47.2022.02.03.03.33.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 03:33:18 -0800 (PST)
Date:   Thu, 3 Feb 2022 11:33:16 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] mfd: ab8500: Rewrite bindings in YAML
Message-ID: <Yfu9fE16W/29z7Va@google.com>
References: <20220115002649.1526163-1-linus.walleij@linaro.org>
 <CACRpkdZPdg7koKf1RkRNzDgF_V-XsEod5C4JA10ps7G7fUwaXw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdZPdg7koKf1RkRNzDgF_V-XsEod5C4JA10ps7G7fUwaXw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 03 Feb 2022, Linus Walleij wrote:

> On Sat, Jan 15, 2022 at 1:28 AM Linus Walleij <linus.walleij@linaro.org> wrote:
> 
> > This rewrites the former text based AB8500 bindings in YAML.
> 
> Is this something we can merge?

I can't merge this without Rob's Ack.

> These MFD bindings become large and complex so I
> add Rob on the To-line so he can have a look if he has
> time.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
