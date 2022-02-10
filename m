Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 133134B1819
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 23:26:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbiBJWZr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 17:25:47 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242123AbiBJWZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 17:25:45 -0500
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EEE425CC;
        Thu, 10 Feb 2022 14:25:46 -0800 (PST)
Received: by mail-oo1-f43.google.com with SMTP id f11-20020a4abb0b000000b002e9abf6bcbcso8207151oop.0;
        Thu, 10 Feb 2022 14:25:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=bi0xxaYvyCZbPDNk/x9kYcmKT4Bfk4GrdJcxp5giOSA=;
        b=gDyO324ndxNpJS24Z8dPOds+eZQBpw+aGssRr1TyPu8sUpXE1qho4UIh35WWTNbMM2
         v89YyTvfvhA0WxwtQt7OIo4rP/C9SX7H6hiMEdJHCf74q/nuzfKLsbY60y1FPMKog370
         k8tg+1x+zSZVJ/kOnyYi20eQbw1KF+Jkwg8miJBXEUSxZUydYwxikio2GWRsCCII/6oX
         j1IlDwl084cUlzP+pwOpesmN3IjTmJ6rrhioPDgB+irGG27Qmqt0r6oHw4jR6jTK67SL
         rqISzr/FZw0+BC/WP0DCqFNx7XrTI+0qC/h1Izc1WjdUhkCwK6kVDe/SEyLvt+9IU6hq
         nbjA==
X-Gm-Message-State: AOAM5339kLi/432fLs74yo77SHd0JFOJMEXVLCTiRvtW7zxrRfsffTHH
        JHgtDgVBnRcUKAH4/7D9HYiIHNGvRg==
X-Google-Smtp-Source: ABdhPJwrVekJrzjgQ/9yYiHIMcwIFxnZL/6zvQzwUNx14/DTrV495dnI67C+qdTQ88ZtqEUt9JYtXQ==
X-Received: by 2002:a05:6820:353:: with SMTP id m19mr3483384ooe.36.1644531945357;
        Thu, 10 Feb 2022 14:25:45 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id 71sm8556446otn.43.2022.02.10.14.25.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 14:25:44 -0800 (PST)
Received: (nullmailer pid 3262538 invoked by uid 1000);
        Thu, 10 Feb 2022 22:25:43 -0000
From:   Rob Herring <robh@kernel.org>
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     krzysztof.kozlowski@canonical.com, wim@linux-watchdog.org,
        robh+dt@kernel.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, linux@roeck-us.net,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220210155450.2939129-1-clabbe@baylibre.com>
References: <20220210155450.2939129-1-clabbe@baylibre.com>
Subject: Re: [PATCH v3] dt-bindings: watchdog: convert faraday,ftwdt010 to yaml
Date:   Thu, 10 Feb 2022 16:25:43 -0600
Message-Id: <1644531943.376766.3262537.nullmailer@robh.at.kernel.org>
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

On Thu, 10 Feb 2022 15:54:50 +0000, Corentin Labbe wrote:
> Converts watchdog/faraday,ftwdt010.txt to yaml.
> This permits to detect missing properties like clocks and resets or
> compatible like moxa,moxart-watchdog.
> 
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> ---
> Changes since v1:
> - Added myself as maintainer as requested by Linus
> - Added $ref to watchdog.yaml
> - Removed useless quotes
> - Added blank lines between properties
> - Removed timeout-sec as already provided by watchdog.yaml
> 
> Change since v2:
> - rewrite compatible section
> 
>  .../bindings/watchdog/faraday,ftwdt010.txt    | 22 -------
>  .../bindings/watchdog/faraday,ftwdt010.yaml   | 66 +++++++++++++++++++
>  2 files changed, 66 insertions(+), 22 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/watchdog/faraday,ftwdt010.txt
>  create mode 100644 Documentation/devicetree/bindings/watchdog/faraday,ftwdt010.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/watchdog/faraday,ftwdt010.yaml:25:9: [warning] wrong indentation: expected 10 but found 8 (indentation)
./Documentation/devicetree/bindings/watchdog/faraday,ftwdt010.yaml:26:11: [warning] wrong indentation: expected 12 but found 10 (indentation)

dtschema/dtc warnings/errors:

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1591202

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

