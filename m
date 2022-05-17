Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01ADD52A1C7
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 14:41:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346051AbiEQMlZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 08:41:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346219AbiEQMlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 08:41:04 -0400
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED16C15724;
        Tue, 17 May 2022 05:41:01 -0700 (PDT)
Received: by mail-oi1-f182.google.com with SMTP id v65so22041308oig.10;
        Tue, 17 May 2022 05:41:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=tU6K7uetAiw+rSP5T9+Sc20G5SXNExj5PkXgukoIQpY=;
        b=WoOztYx/XHDkFLmzQgiX5NVA5acRpqNk2LOdGBMiQ0WPUob9msphTQ9b5/L+L11j5N
         tgU4b4xaYtvgmBIGMVO7e/wd41apzro+ZyVL3NOIT0buGVv28Zi0A+wBcuiiCv6RGWXm
         fpX3iDd10qympp97Ay1jn30aKp7bPX9YiRKlErcTbxaAg68QX3Io6XzwEYmsEk3ylSvc
         o6ObbNyXLbkSAlO9ic0twr2Hk21e/tXxDHj40ipNg4Es+4kVKU39V23pQrNL9Fnk/kRz
         2uhAyQBzFnHiTNdsV01dMRTNUxLcI5H/ns32KYflyTaNEgs8MSyuZRZ2lAxJEQWYT4OW
         +s9Q==
X-Gm-Message-State: AOAM533nTLjyMklk4wJYjauL3KEWKt504EMjaKrKH3hCm0L2g6Rldsza
        zlhaUqcZ1URpLFxDR3l1bg==
X-Google-Smtp-Source: ABdhPJxnbOAePBrL+7Vj6jx6SHaZRvhNaYbZt0r4+5WYZOCl4zrCDiMenp0OWItuwFOIpyqmNZ74CQ==
X-Received: by 2002:a05:6808:2c8:b0:325:ad24:a002 with SMTP id a8-20020a05680802c800b00325ad24a002mr16074643oid.82.1652791261252;
        Tue, 17 May 2022 05:41:01 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id m1-20020a05680806c100b003266e656d39sm4722981oih.4.2022.05.17.05.40.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 05:41:00 -0700 (PDT)
Received: (nullmailer pid 785390 invoked by uid 1000);
        Tue, 17 May 2022 12:40:59 -0000
From:   Rob Herring <robh@kernel.org>
To:     Max Krummenacher <max.oss.09@gmail.com>
Cc:     Francesco Dolcini <francesco.dolcini@toradex.com>,
        Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        Maxime Ripard <mripard@kernel.org>,
        Marek Vasut <marex@denx.de>, Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Daniel Vetter <daniel@ffwll.ch>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        max.krummenacher@toradex.com,
        Dave Stevenson <dave.stevenson@raspberrypi.com>
In-Reply-To: <20220516162826.23025-2-max.oss.09@gmail.com>
References: <20220516162826.23025-1-max.oss.09@gmail.com> <20220516162826.23025-2-max.oss.09@gmail.com>
Subject: Re: [PATCH v1 1/2] dt-bindings: display: add new bus-format property for panel-dpi
Date:   Tue, 17 May 2022 07:40:59 -0500
Message-Id: <1652791259.418473.785387.nullmailer@robh.at.kernel.org>
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

On Mon, 16 May 2022 18:28:25 +0200, Max Krummenacher wrote:
> From: Max Krummenacher <max.krummenacher@toradex.com>
> 
> The property is used to set the enum bus_format and infer the bpc
> for a panel defined by 'panel-dpi'.
> This specifies how the panel is connected to the display interface.
> 
> Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>
> ---
> 
>  .../bindings/display/panel/panel-dpi.yaml     | 11 +++++++++
>  .../dt-bindings/display/dt-media-bus-format.h | 23 +++++++++++++++++++
>  2 files changed, 34 insertions(+)
>  create mode 100644 include/dt-bindings/display/dt-media-bus-format.h
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Error: Documentation/devicetree/bindings/display/panel/panel-dpi.example.dts:20.9-10 syntax error
FATAL ERROR: Unable to parse input tree
make[1]: *** [scripts/Makefile.lib:364: Documentation/devicetree/bindings/display/panel/panel-dpi.example.dtb] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1401: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

