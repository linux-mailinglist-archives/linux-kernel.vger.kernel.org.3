Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC380500E3F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 15:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243679AbiDNNDI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 09:03:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243732AbiDNNC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 09:02:57 -0400
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F7E856C3E;
        Thu, 14 Apr 2022 06:00:33 -0700 (PDT)
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-dacc470e03so5160280fac.5;
        Thu, 14 Apr 2022 06:00:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NBHcw6JeGXAP/4GusoH91XnOTRObIe9CkFkL3mCbYg8=;
        b=oUw+dQU6foqCS4EltUsjGYSQBEIPzCs/UHOiKM+KadIouedsQ0WOIOd0zJ1YkZ0zTC
         QjuMP5un5pWbFYJHHDId0hcyBd2vpVuPdRJkjaxf/lpUl95jTa2g1Teb+GrsM0hbK+/b
         4OarKLIsjblGg91+wrDi6/3WP8gPNupAw+vBU+3oV0yYyO+SPZQgFjN/svkIORupC84m
         cqB8sJ08H4QaQHPGX2vxepIvjB+jCvDpXjAMbUJsat2N6gHuLOE6R2paANHBBVCddWAO
         0PCPFh0qv2FYRRF9S4PLD3arfdcyPFbfpiqkhbJmy+viAVntVIDuqMBmya3Ls18P1cZM
         T3pQ==
X-Gm-Message-State: AOAM533ATy8+Pc5DpqX+r3XkqUvwDKyjlHiQZ8RmoX9lHnlukJ9JNhvm
        dZBwKymBrGnizyBIHA7f8w==
X-Google-Smtp-Source: ABdhPJxn5+pUNbFlHlXi8f4P1KZwuQKUmPXxTi5iN7R5Ln4s8z+F1mCA5m1OfUiIcMQt9zJfTe8JJg==
X-Received: by 2002:a05:6871:88d:b0:e2:9d93:730c with SMTP id r13-20020a056871088d00b000e29d93730cmr1211227oaq.216.1649941232558;
        Thu, 14 Apr 2022 06:00:32 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id a17-20020a4ae931000000b0032933be7230sm656536ooe.4.2022.04.14.06.00.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 06:00:31 -0700 (PDT)
Received: (nullmailer pid 1755133 invoked by uid 1000);
        Thu, 14 Apr 2022 13:00:30 -0000
Date:   Thu, 14 Apr 2022 08:00:30 -0500
From:   Rob Herring <robh@kernel.org>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Chen-Yu Tsai <wens@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Neil Armstrong <narmstrong@baylibre.com>,
        David Airlie <airlied@linux.ie>,
        Maxime Ripard <mripard@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v4 1/5] dt-bindings: display: ssd1307fb: Deprecate "-i2c"
 compatible strings
Message-ID: <Ylga7jYPaAav05gg@robh.at.kernel.org>
References: <20220413162359.325021-1-javierm@redhat.com>
 <20220413162359.325021-2-javierm@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220413162359.325021-2-javierm@redhat.com>
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

On Wed, 13 Apr 2022 18:23:54 +0200, Javier Martinez Canillas wrote:
> The current compatible strings for SSD130x I2C controllers contain both an
> "fb" and "-i2c" suffixes. It seems to indicate that are for a fbdev driver
> and also that are for devices that can be accessed over an I2C bus.
> 
> But a DT is supposed to describe the hardware and not Linux implementation
> details. So let's deprecate those compatible strings and add new ones that
> only contain the vendor and device name, without any of these suffixes.
> 
> These will just describe the device and can be matched by both I2C and SPI
> DRM drivers. The required properties should still be enforced for old ones.
> 
> While being there, just drop the "sinowealth,sh1106-i2c" compatible string
> since that was never present in a released Linux version.
> 
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> Acked-by: Mark Brown <broonie@kernel.org>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> 
> (no changes since v3)
> 
> Changes in v3:
> - Drop the "sinowealth,sh1106-i2c", wasn't in a released version (Chen-Yu Tsai)
> - Continue enforcing required properties for deprecated strings (Maxime Ripard)
> 
> Changes in v2:
> - Drop the -i2c suffixes from the compatible strings too (Geert Uytterhoeven)
> 
>  .../bindings/display/solomon,ssd1307fb.yaml   | 44 +++++++++++++------
>  1 file changed, 31 insertions(+), 13 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
