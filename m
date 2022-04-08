Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 863C24F9C79
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 20:22:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238552AbiDHSYQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 14:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbiDHSYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 14:24:13 -0400
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87DFD36DD9E;
        Fri,  8 Apr 2022 11:22:08 -0700 (PDT)
Received: by mail-ot1-f42.google.com with SMTP id i11-20020a9d4a8b000000b005cda3b9754aso6635164otf.12;
        Fri, 08 Apr 2022 11:22:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Lf2HIDOgcxd3N/SJmrm+i3BU0QKkjgIH52w0l9HZULg=;
        b=EqzXutcN6XQcvHV0Lyf70TjAnCMJVdNvbZpDJAk+l2d16apb+brgxkf91hYThQx1V8
         kxr+E+pysmSEpHCMTqjpBxvdhXruwdHZXPqln9EgMoNDWpmVYRzlpmxIdaP2I3Z6N6YC
         yUc/UaQ0fdjxK/NAebS9XLh3WjVmtf2aVtb6H3bkBI43SQ2t0EKrAbG/IO4J9EQBUsG1
         HJ4kDQji5gg8dc4VoqvMKArAlrfaZ9qtZEK14a7WHnCXbZWE/UpQiCcE5cpHblZ+WORP
         uulri5klj+DrPAbxSAy9YGASK37alaDRnXUQ+b8gw7gnAs4RbCVm2WaOBblPH12h/d0d
         IYbg==
X-Gm-Message-State: AOAM533M7hmHhZEsat/RmTqE+KKdVkjAR6fHw0iZbj/twx/GkMJMHYTV
        tConhtg14Xx3xmakarGzb9W/obrPOQ==
X-Google-Smtp-Source: ABdhPJy91m7vj0F/F1zyS9qB+nTfpd/raBdG+Fj65mRFlO9Vv/D+Ezuacy99dHSUu24EJa4eacDzpg==
X-Received: by 2002:a9d:4798:0:b0:5b2:3791:beb7 with SMTP id b24-20020a9d4798000000b005b23791beb7mr7026104otf.123.1649442127768;
        Fri, 08 Apr 2022 11:22:07 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id z3-20020a056870d68300b000e2a0a74f9fsm394717oap.37.2022.04.08.11.22.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Apr 2022 11:22:07 -0700 (PDT)
Received: (nullmailer pid 3810091 invoked by uid 1000);
        Fri, 08 Apr 2022 18:22:06 -0000
Date:   Fri, 8 Apr 2022 13:22:06 -0500
From:   Rob Herring <robh@kernel.org>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Chen-Yu Tsai <wens@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Mark Brown <broonie@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/5] dt-bindings: display: ssd1307fb: Deprecate fbdev
 compatible strings
Message-ID: <YlB9TsbhoQblo1H8@robh.at.kernel.org>
References: <20220407200205.28838-1-javierm@redhat.com>
 <20220407200205.28838-2-javierm@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220407200205.28838-2-javierm@redhat.com>
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

On Thu, Apr 07, 2022 at 10:02:00PM +0200, Javier Martinez Canillas wrote:
> The current compatible strings for SSD130x I2C controllers contain an -fb
> suffix, this seems to indicate that are for a fbdev driver. But the DT is
> supposed to describe the hardware and not Linux implementation details.

True, but compatible is just an identifier. There's no reason to 
deprecate unless the binding as a whole needs to be redone.

I imagine you also want 2 compatibles for 2 drivers. That's saying you 
should change your firmware to switch drivers. The fact that we have 2 
drivers for the same h/w is a kernel problem. Don't bring DT into it.

> Let's deprecate those compatible strings and add a new enum that contains
> compatible strings that don't have a -fb suffix. These will be matched by
> the ssd130x-i2c DRM driver.
> 
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> ---
> 
>  .../bindings/display/solomon,ssd1307fb.yaml   | 36 ++++++++++++-------
>  1 file changed, 24 insertions(+), 12 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/solomon,ssd1307fb.yaml b/Documentation/devicetree/bindings/display/solomon,ssd1307fb.yaml
> index ade61d502edd..46207f2c12b8 100644
> --- a/Documentation/devicetree/bindings/display/solomon,ssd1307fb.yaml
> +++ b/Documentation/devicetree/bindings/display/solomon,ssd1307fb.yaml
> @@ -12,12 +12,24 @@ maintainers:
>  
>  properties:
>    compatible:
> -    enum:
> -      - sinowealth,sh1106-i2c
> -      - solomon,ssd1305fb-i2c
> -      - solomon,ssd1306fb-i2c
> -      - solomon,ssd1307fb-i2c
> -      - solomon,ssd1309fb-i2c
> +    oneOf:
> +      # Deprecated compatible strings
> +      - items:
> +          - enum:
> +              - solomon,ssd1305fb-i2c
> +              - solomon,ssd1306fb-i2c
> +              - solomon,ssd1307fb-i2c
> +              - solomon,ssd1309fb-i2c
> +        deprecated: true
> +
> +      # SSD130x I2C controllers
> +      - items:
> +          - enum:
> +              - sinowealth,sh1106-i2c
> +              - solomon,ssd1305-i2c
> +              - solomon,ssd1306-i2c
> +              - solomon,ssd1307-i2c
> +              - solomon,ssd1309-i2c

There's also no reason to put the bus interface into the compatible as 
the same compatible will work on different buses. But since you want to 
add SPI, just using the 'i2c' one will confuse people. For that reason 
you could add 'solomon,ssd1305', etc. for both SPI support and I2C DRM. 
(You should also support the 'fb-i2c' variant in DRM IMO, but doubtful 
that I'll review that.)

Rob
