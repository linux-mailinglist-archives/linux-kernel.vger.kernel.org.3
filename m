Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1CB74C039E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 22:15:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235733AbiBVVQJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 16:16:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235700AbiBVVQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 16:16:08 -0500
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB65B106605;
        Tue, 22 Feb 2022 13:15:42 -0800 (PST)
Received: by mail-oo1-f43.google.com with SMTP id p206-20020a4a2fd7000000b0031bfec11983so19424429oop.13;
        Tue, 22 Feb 2022 13:15:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LxgusODP2GOfUh+GrU/i/NsPSEgZvwaQGFPVZgBGVG0=;
        b=AT3ouWFNn74ONhDYiPT5L2XbAfJ9d55I8+ipNLvhHRcRVwHfou8ps/jDMQKMtP/B9t
         gjlKfTA2nR7XgJGZlXPH2NYoVcim5BFhb2ZA1bRDT/yaADS+rOSTnqt3VS32q3E8cTu1
         IcIMp7DzSkw5aJNqUia5GH44Bmm1p4dRJclkvz9MYhXkmm6e/8V197D1+M/YovBxFRj2
         L8Z3moihtUvLf426a1kHDHxzDHKoIrgGw4SVc02dDsAPseiDiqowYbfm8Dg43ScuXzKn
         QgjqBISX2t6JxwnEN1Vp/Q+1XxO2lvy33XBnD2THnXl4b2Klj/AcFTkZz14iYBjU8E6T
         f/SQ==
X-Gm-Message-State: AOAM533NDYqSS6g8u+6JtnD6Uy7VqSF2TWbY2Joaom493QI7CL+1iJJ4
        X//b26rVlujtVas1bUXN+w==
X-Google-Smtp-Source: ABdhPJweZeM8YTKjHsA/asTQIGx8MLwhI9nfrImLfLJ2q3s2S6hi4sAwCA3bD7eX2mY/mlV4k5EL+Q==
X-Received: by 2002:a05:6870:961a:b0:d2:858c:ea4 with SMTP id d26-20020a056870961a00b000d2858c0ea4mr2549999oaq.186.1645564542158;
        Tue, 22 Feb 2022 13:15:42 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id f1sm3477355oov.45.2022.02.22.13.15.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 13:15:41 -0800 (PST)
Received: (nullmailer pid 3600555 invoked by uid 1000);
        Tue, 22 Feb 2022 21:15:40 -0000
Date:   Tue, 22 Feb 2022 15:15:40 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Sagar Kadam <sagar.kadam@sifive.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Albert Ou <aou@eecs.berkeley.edu>, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, linux-pwm@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: sifive: drop Yash Shah
Message-ID: <YhVSfKZbnGcGJGFH@robh.at.kernel.org>
References: <20220214082349.162973-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220214082349.162973-1-krzysztof.kozlowski@canonical.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Feb 2022 09:23:49 +0100, Krzysztof Kozlowski wrote:
> Emails to Yash Shah bounce with "The email account that you tried to
> reach does not exist.", so drop him from all maintainer entries.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  Documentation/devicetree/bindings/gpio/sifive,gpio.yaml     | 1 -
>  Documentation/devicetree/bindings/pwm/pwm-sifive.yaml       | 1 -
>  .../devicetree/bindings/riscv/sifive-l2-cache.yaml          | 1 -
>  MAINTAINERS                                                 | 6 ------
>  4 files changed, 9 deletions(-)
> 

Applied, thanks!
