Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA894B6CE1
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 14:00:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238033AbiBONA3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 08:00:29 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232620AbiBONA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 08:00:27 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAC5B80207
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 05:00:17 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id p9so11451876wra.12
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 05:00:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=pBp3oKG8pCHUKlcDYmMwt8MRLOpXbLmBhbx74llU4C0=;
        b=C1g8J5zhjDBLk7c8lAnsZUkzOSK2CtoZVS3xjPZsGDJ1hOhsMGGgpXuCkkgx8mCC+d
         FtlsgSY8KP7v3ZvVnGjBDQAj2xagIUTk8JnELqPjL2vp0FRr3hJ7vZQvqIJWoRXVENci
         M7pnyPrEAkPkT+dd7wQS7P9eZ4n0yksoO5aibx+OV7hKGApf5V2AjOuHsf+TMHJX6lae
         GtoQy5pizzDOS3DOVkwo+zabDZIXT1d5fDllxDo9OwTCm0BdfYjJdYdB6SlxCQYBCSSz
         HS97yY0WozCZoyfb0TMjYweRBvsdDRX3j4sVeNx+hUMLNmABctBMyvXBZb61aHknq+3a
         FRBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=pBp3oKG8pCHUKlcDYmMwt8MRLOpXbLmBhbx74llU4C0=;
        b=UxmgEkw8hbdSgVJ7bdwHlOOZwYjuBKc+Bfj4zdeht31jJ1C+xwfoDzskM9CLvHXaIV
         27P+pYaQJT83sxy4fxdQ1SIKXy+f6eFwNv97tZEU64Nb1/rTKjGuTkGRwob0k/IK54aU
         eq6N8og5fgIKEU3ApeMiG/0T7i0ImSMfc3P9FIpcKlP8l0+I4xQ/r782hBVM7uDssNW3
         zghlJLlmLwQZJDCltl2Mt44YbuyOEHNeD4z/XAqWd0Ld+SmuGWo9ROsWMV6p7IrS+YlB
         0IHhPb5xFoB7zaCrGIZrCylpjPQ0qUzQ8mbRzbiBseUUpvSAKnUQG+XwjGstcNVlb09K
         eL8g==
X-Gm-Message-State: AOAM532dJuDLZ/tDha6oV4/+jdjb05OpxVG0l5bDDZm3193/gFlqwlA6
        lOby2xVp5N8lwCng0XyKqUqemg==
X-Google-Smtp-Source: ABdhPJwUH4PEVe6TdYCTZM5n0Io19ensIlovEMMklptc8/eaoMhEstr+rW5yHMNc0uKcrta3Cqivxw==
X-Received: by 2002:adf:d1c5:: with SMTP id b5mr3256370wrd.21.1644930016334;
        Tue, 15 Feb 2022 05:00:16 -0800 (PST)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id n20sm5346772wmq.42.2022.02.15.05.00.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 05:00:15 -0800 (PST)
Date:   Tue, 15 Feb 2022 13:00:14 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH] mfd: ab8500: Rewrite bindings in YAML
Message-ID: <Yguj3rmCeGVEiI6M@google.com>
References: <20220115002649.1526163-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220115002649.1526163-1-linus.walleij@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 Jan 2022, Linus Walleij wrote:

> This rewrites the former text based AB8500 bindings in YAML.
> 
> When the AB8500 bindings were first written (in 2012) we
> were not strict on some things and node names were definitely
> not standardized.
> 
> This patch uses standard node names to most of the subnodes
> on the AB8500 and is accompanied by another patch fixing
> all the DTS files to conform to this.
> 
> The bindings are not as perfect as newly written bindings
> would be, it is a best effort to deal with the legacy.
> 
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  .../devicetree/bindings/mfd/ab8500.txt        | 282 ----------
>  .../bindings/mfd/stericsson,ab8500.yaml       | 500 ++++++++++++++++++
>  .../bindings/mfd/stericsson,db8500-prcmu.yaml |   1 +
>  3 files changed, 501 insertions(+), 282 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/mfd/ab8500.txt
>  create mode 100644 Documentation/devicetree/bindings/mfd/stericsson,ab8500.yaml

Applied, thanks.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
