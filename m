Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0647500E42
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 15:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243689AbiDNNDV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 09:03:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243063AbiDNNDS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 09:03:18 -0400
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC4E157144;
        Thu, 14 Apr 2022 06:00:51 -0700 (PDT)
Received: by mail-oi1-f170.google.com with SMTP id q129so5277128oif.4;
        Thu, 14 Apr 2022 06:00:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1jt0wr2Jj0rpKwBXfActCjc+WpJa+bt9YCx6ZomSA98=;
        b=aXXtMF2QhN2gUcMkGT1cB7bG567JLhJIAYyPJ+dxR7OcMGqdcdE8znORSdMd5nf5lK
         mBM2eLOBT4eXPqVCb8snZoFp6qdINmYCBifu6Kt8v93qAKxl8w7DAks8ftgbmpLomip8
         bBMxM/TGScbC/rLdBGjZGjC8EA/pb5NJf9MCRpISrGjzXS613tqjRQRrzfYLEVi2xnlZ
         y+4lcXy9EltkDmQ+XNQ4Z0qhm2/l3khnG+YPzIP/HSi5RsfEgpZzh1L5UlNUpAUZEnc5
         EsJmg4799a1PeBJQvMju8ekcJfZp4jWa+J/QL9CbwmTid9HUHKNWP8BRdGvIpEIeZyuD
         8iDA==
X-Gm-Message-State: AOAM532YaoFEf7Fb91XPlIAgBPIdKKQpgyf5yBkdFEJRi6KqlUtw1+zz
        VYnvjmHhKLL7Mqp0v21evA==
X-Google-Smtp-Source: ABdhPJzDoL3AtjsnkGtQrPML0IWDdiP+U1HX/0wjf3Z8mMWnd+R0AmVehr0xJQoKPXHCe70MpIVezg==
X-Received: by 2002:a05:6808:bd2:b0:2f7:59fd:2f1b with SMTP id o18-20020a0568080bd200b002f759fd2f1bmr1464140oik.217.1649941251138;
        Thu, 14 Apr 2022 06:00:51 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id eq37-20020a056870a92500b000c6699dad62sm642170oab.41.2022.04.14.06.00.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 06:00:50 -0700 (PDT)
Received: (nullmailer pid 1755668 invoked by uid 1000);
        Thu, 14 Apr 2022 13:00:50 -0000
Date:   Thu, 14 Apr 2022 08:00:50 -0500
From:   Rob Herring <robh@kernel.org>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        David Airlie <airlied@linux.ie>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Chen-Yu Tsai <wens@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Maxime Ripard <mripard@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/5] dt-bindings: display: ssd1307fb: Extend schema
 for SPI controllers
Message-ID: <YlgbAhXKUs1/Ct58@robh.at.kernel.org>
References: <20220413162359.325021-1-javierm@redhat.com>
 <20220413162359.325021-3-javierm@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220413162359.325021-3-javierm@redhat.com>
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

On Wed, 13 Apr 2022 18:23:55 +0200, Javier Martinez Canillas wrote:
> The Solomon SSD130x OLED displays can either have an I2C or SPI interface,
> add to the schema the properties and examples for OLED devices under SPI.
> 
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> Acked-by: Mark Brown <broonie@kernel.org>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> 
> Changes in v4:
> - Add a description for the dc-gpios property for SPI (Geert Uytterhoeven)
> 
> Changes in v3:
> - Add a comment to the properties required for SPI (Geert Uytterhoeven)
> 
> Changes in v2:
> - Don't add compatible strings with an "-spi" suffix (Geert Uytterhoeven)
> 
>  .../bindings/display/solomon,ssd1307fb.yaml   | 42 ++++++++++++++++++-
>  1 file changed, 40 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
