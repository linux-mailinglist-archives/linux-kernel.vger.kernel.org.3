Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26173528864
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 17:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245142AbiEPPUX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 11:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238130AbiEPPUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 11:20:21 -0400
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 744313BBFA;
        Mon, 16 May 2022 08:20:20 -0700 (PDT)
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-e656032735so20581744fac.0;
        Mon, 16 May 2022 08:20:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=W9tLM70Tw8Uss/GVBVK6u77pI6LLmHXNFXi2ajwOZKg=;
        b=a6Mp1P5YyfqmNPbmao2cxA11zkBNSASCZAdyKiT1y+MU9VNq14kUjmqf04UYyj2vXM
         IikCm8gTm4RIboNJEKXdmo070IFUrqR4IkiWy0iEEEOs/7YL5V1IjBuH1f7vS6xuEi8f
         rHI3n6maHToQ0LwEM/dbhIZFsxXKgWsox+JpaEARIlqMzrf5pu2hiudQcN+2o0eSUQ9C
         D1tx/j4JBbfZ6mI4RgCgPY2O6wG40xVizDjUyuX5XcVjiVxhw+i8OpBAOrQLYSP/A1XM
         szi3a80vet5alyjFJveRtL4dRK8WJa7pPw9hQEkUVqJqhPfiWY241WEBpoLTwa7UaXtw
         fQdg==
X-Gm-Message-State: AOAM532S4Y/wt9xyPDMdx3bCiAOu3xu6JAxaumjFfE2V9NgNYudlF5oI
        PZm0P5ZJOHhXa+nYvdPkrrgjFhHsLQ==
X-Google-Smtp-Source: ABdhPJwWZu/rR2p0J2pBoKL+4f8o2cPL9O9K6Q6XK2gBUPSYwyTDQrNXhiS2kWe+LpFOkwSgldwWJQ==
X-Received: by 2002:a05:6870:9a2a:b0:e6:2cdd:6124 with SMTP id fo42-20020a0568709a2a00b000e62cdd6124mr15314808oab.3.1652714419789;
        Mon, 16 May 2022 08:20:19 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id l9-20020a4a8409000000b0035eb4e5a6b8sm4149620oog.14.2022.05.16.08.20.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 08:20:19 -0700 (PDT)
Received: (nullmailer pid 2666522 invoked by uid 1000);
        Mon, 16 May 2022 15:20:18 -0000
Date:   Mon, 16 May 2022 10:20:18 -0500
From:   Rob Herring <robh@kernel.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Guenter Roeck <groeck@chromium.org>, devicetree@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Tom Hughes <tomhughes@chromium.org>,
        Alexandru M Stan <amstan@chromium.org>,
        patches@lists.linux.dev, Tzung-Bi Shih <tzungbi@kernel.org>,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Craig Hesling <hesling@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        chrome-platform@lists.linux.dev,
        Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [PATCH v5 2/3] dt-bindings: cros-ec: Reorganize property
 availability
Message-ID: <20220516152018.GA2666468-robh@kernel.org>
References: <20220512013921.164637-1-swboyd@chromium.org>
 <20220512013921.164637-3-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220512013921.164637-3-swboyd@chromium.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 May 2022 18:39:20 -0700, Stephen Boyd wrote:
> Various properties in the cros-ec binding only apply to different
> compatible strings. For example, the interrupts and reg property are
> required for all cros-ec devices except for the rpmsg version. Add some
> conditions to update the availability of properties so that they can't
> be used with compatibles that don't support them.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> Cc: <devicetree@vger.kernel.org>
> Cc: <chrome-platform@lists.linux.dev>
> Cc: Guenter Roeck <groeck@chromium.org>
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: Craig Hesling <hesling@chromium.org>
> Cc: Tom Hughes <tomhughes@chromium.org>
> Cc: Alexandru M Stan <amstan@chromium.org>
> Cc: Tzung-Bi Shih <tzungbi@kernel.org>
> Cc: Matthias Kaehlcke <mka@chromium.org>
> Cc: Benson Leung <bleung@chromium.org>
> Cc: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  .../bindings/mfd/google,cros-ec.yaml          | 39 +++++++++++++------
>  1 file changed, 27 insertions(+), 12 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
