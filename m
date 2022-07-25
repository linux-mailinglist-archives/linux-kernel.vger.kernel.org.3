Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D846958080A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 01:14:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbiGYXOP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 19:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231604AbiGYXOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 19:14:09 -0400
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 834FB12ADC;
        Mon, 25 Jul 2022 16:14:08 -0700 (PDT)
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-10cf9f5b500so16719214fac.2;
        Mon, 25 Jul 2022 16:14:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IT9a0wSsGnU4XfNa0zlbA+WkW9Dbub1UMbz6KfLI6MY=;
        b=pj9o3XWsClJo3/4Wppy2MdfichiXBaaaTyk2IebGc+8yQjxtS9pu47MRr0Hp/d9kDt
         mAl9WyvUnD/jfqDFHEj6uOskHHjXGNm1rbKUdtHi0DY9Rp2q6g6LHbRqzNh6PYwY81mS
         4+rVG7ZUIgpRJeVeXHwpCrA0Y6tD3rGJ0jIJ+prVHCym53emCzT08JXSvfoMfa89LFhs
         Asy/Kt1xJfFiwYSwESc4nKH1jHGrnlQHlEX5XPzn4BhVhZvg8zwJ/ZIytfk4Dk3etv7W
         f/3ylCCmcM64bJgC6vvQV+LGqe6ha6v0m+mGidxtTw3EtdffVanvTNVaaSsk/4MM+ME4
         5jRQ==
X-Gm-Message-State: AJIora9eDKyMIR3rZrAljGzTUmNdKUtI8RrD+WtrRmCX9v5/mAS2IUz+
        DbHxv55Tlavg1aMxkKxwNg==
X-Google-Smtp-Source: AGRyM1sOEaENPiaKZi6zm2YQdCZcWqFgTUzFmo56Scl3zxQjWiAN/UML1fly4p3EtWEnkVWhfcKP5g==
X-Received: by 2002:a05:6870:9a1d:b0:10d:c9c5:e16a with SMTP id fo29-20020a0568709a1d00b0010dc9c5e16amr7700750oab.135.1658790847779;
        Mon, 25 Jul 2022 16:14:07 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id 62-20020a4a1541000000b0041b49c19a00sm5359166oon.18.2022.07.25.16.14.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 16:14:07 -0700 (PDT)
Received: (nullmailer pid 2932291 invoked by uid 1000);
        Mon, 25 Jul 2022 23:14:05 -0000
Date:   Mon, 25 Jul 2022 17:14:05 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marek Belisko <marek@goldelico.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maxime Ripard <mripard@kernel.org>,
        Pratyush Yadav <p.yadav@ti.com>, devicetree@vger.kernel.org,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        linux-spi@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        David Airlie <airlied@linux.ie>,
        Thierry Reding <thierry.reding@gmail.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mark Brown <broonie@kernel.org>,
        dri-devel@lists.freedesktop.org,
        "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH v2 1/1] spi/panel: dt-bindings: drop CPHA and CPOL from
 common properties
Message-ID: <20220725231405.GA2931469-robh@kernel.org>
References: <20220722191539.90641-1-krzysztof.kozlowski@linaro.org>
 <20220722191539.90641-2-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220722191539.90641-2-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Jul 2022 21:15:39 +0200, Krzysztof Kozlowski wrote:
> The spi-cpha and spi-cpol properties are device specific and should be
> accepted only if device really needs them.  Drop them from common
> spi-peripheral-props.yaml schema, mention in few panel drivers which use
> them and include instead in the SPI controller bindings.  The controller
> bindings will provide CPHA/CPOL type validation and one place for
> description.  Each device schema must list the properties if they are
> applicable.
> 
> Suggested-by: Jonathan Cameron <jic23@kernel.org>
> Suggested-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/display/panel/lgphilips,lb035q02.yaml    |  3 +++
>  .../bindings/display/panel/samsung,ld9040.yaml        |  3 +++
>  .../bindings/display/panel/sitronix,st7789v.yaml      |  3 +++
>  .../devicetree/bindings/display/panel/tpo,td.yaml     |  3 +++
>  .../devicetree/bindings/spi/spi-controller.yaml       | 11 +++++++++++
>  .../devicetree/bindings/spi/spi-peripheral-props.yaml | 10 ----------
>  6 files changed, 23 insertions(+), 10 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

Unless Mark doesn't want to pick this up.
