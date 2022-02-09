Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BEDF4AFF05
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 22:13:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232937AbiBIVNL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 16:13:11 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:38622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230327AbiBIVNF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 16:13:05 -0500
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA30EC03BFF4;
        Wed,  9 Feb 2022 13:13:08 -0800 (PST)
Received: by mail-oo1-f49.google.com with SMTP id k13-20020a4a948d000000b003172f2f6bdfso3994250ooi.1;
        Wed, 09 Feb 2022 13:13:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2d9uknkMXF1hP9/kz6yWKEZgfCAsCNW/6xcg2yf69Ks=;
        b=Uj3e9hlTv2EWeprd/q/Phw0YGq5n4t/MzbEqatY7yrTwIO8CUQ9fQn3WAdKImEQaUy
         yKYolM4+JAf6VvURG9l2DpqMyGi/Ef8lpLFNBWJCgd2Mg8U9rGnlsl5+cRgGAL/Ki5vw
         1wCIJ0im60w5ONLCz/6tKe/sz0vHKgIzEENzxm194lcGLwaVcvUQK0x8lGtzs+VVBF3j
         UV4XPXhnpmFR+IgXo97B3PN+duOa6yEXZ7kbInZYRkh0CfGl7B3UXNOOjXUSCwbOv0m7
         Nx/KtcqSQybsNokDf3FOK0SCgfyozeCqX1TFoD9V5jWjsk2HKEd9ev46ZZ7A4V/pvLz8
         vZZQ==
X-Gm-Message-State: AOAM530ETfKNZJ9UNk2YxyQbTHbo1oYOdgXZIgfBkTsGldAXgHg6Rhua
        R60xE9AoK0dDG0VYfON9HQ==
X-Google-Smtp-Source: ABdhPJzaGPmfsdC4kTq9wcUQ8tghT7p5Au4l30tbl0kHd/2db1AL7QxTpJNzhEi3x80IVLemA2gNCA==
X-Received: by 2002:a05:6870:6288:: with SMTP id s8mr1403442oan.269.1644441188101;
        Wed, 09 Feb 2022 13:13:08 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id t21sm7066345otj.26.2022.02.09.13.13.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 13:13:07 -0800 (PST)
Received: (nullmailer pid 923087 invoked by uid 1000);
        Wed, 09 Feb 2022 21:13:06 -0000
Date:   Wed, 9 Feb 2022 15:13:06 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Bakker <xc-racer2@live.ca>,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH v2 6/6] ASoC: dt-bindings: samsung,tm2: convert to
 dtschema
Message-ID: <YgQuYoJai+fYuBtL@robh.at.kernel.org>
References: <20220129122357.45545-1-krzysztof.kozlowski@canonical.com>
 <20220129122430.45694-5-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220129122430.45694-5-krzysztof.kozlowski@canonical.com>
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

On Sat, 29 Jan 2022 13:24:30 +0100, Krzysztof Kozlowski wrote:
> Convert the audio complex on Samsung TM2 boards with Samsung Exynos SoC
> to DT schema format.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  .../bindings/sound/samsung,tm2-audio.txt      | 42 ----------
>  .../bindings/sound/samsung,tm2.yaml           | 80 +++++++++++++++++++
>  2 files changed, 80 insertions(+), 42 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/sound/samsung,tm2-audio.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/samsung,tm2.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
