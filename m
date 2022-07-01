Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 860BC563BA3
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 23:15:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231794AbiGAU5J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 16:57:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231255AbiGAU5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 16:57:06 -0400
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05642675A2;
        Fri,  1 Jul 2022 13:57:06 -0700 (PDT)
Received: by mail-io1-f54.google.com with SMTP id s17so3374572iob.7;
        Fri, 01 Jul 2022 13:57:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xgE/JcMImFsLHC9kd8+2fcNfM7vDxsP6gVBtPDttJ1Y=;
        b=dFKDsu4xiB4THbJE4DQTaPzcYZikHV3oqwkwNhrdlG+xYwZq5pjhOUYvVr4Bqcijah
         BHe7uBDzFyGRan5JuIeC/KCxF/2OghrZG9VdgMAkTJlhyDJrgN97KYn6kCal6cW0jMNl
         tk6Iwphp9Bv8aQhurDrnfHQLxhIV/qcVcPLmmpDbdFPC/kZnElfh2T9JsT8cEBg+5eox
         wBRT2aiB7gCp6PmfNnT9CEanEGWJjak2ivKK4CJIk1ftRGjnwu7nYWzZw6QnzJvSLN/A
         sacJZR2rgbEgux4PlUcJQLknLW6u/qNp0S7MA0y/Brm7ccUj+A+LTs+fG3SkjkT3CawU
         SoBw==
X-Gm-Message-State: AJIora+UJ0WOtSLXECFgSUZRCFhgH8cW87nEe/MDtrMVwW6j2VD4LfOA
        7Hb2eTXKDghCM5fBPZL1LQ==
X-Google-Smtp-Source: AGRyM1vBsdqcy5YkIu5jY2aKYkyMTBVIaMSTTEbsoJvFJCBb92KYANiqzH2w4D61p9EBRSIzvZZHOQ==
X-Received: by 2002:a5d:8485:0:b0:672:76d6:3848 with SMTP id t5-20020a5d8485000000b0067276d63848mr8209832iom.18.1656709025310;
        Fri, 01 Jul 2022 13:57:05 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id j12-20020a6b794c000000b0067275a52928sm10681358iop.9.2022.07.01.13.57.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 13:57:04 -0700 (PDT)
Received: (nullmailer pid 1515827 invoked by uid 1000);
        Fri, 01 Jul 2022 20:57:03 -0000
Date:   Fri, 1 Jul 2022 14:57:03 -0600
From:   Rob Herring <robh@kernel.org>
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v12 2/7] dt-bindings: pinctrl: sunxi: Make interrupts
 optional
Message-ID: <20220701205703.GA1515763-robh@kernel.org>
References: <20220701112453.2310722-1-andre.przywara@arm.com>
 <20220701112453.2310722-3-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220701112453.2310722-3-andre.przywara@arm.com>
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

On Fri, 01 Jul 2022 12:24:48 +0100, Andre Przywara wrote:
> The R_PIO pinctrl device on the Allwinner H616 SoC does not have an
> interrupt (it features only two pins).
> However the binding requires at least naming one upstream interrupt,
> plus the #interrupt-cells and interrupt-controller properties.
> 
> Drop the unconditional requirement for the interrupt properties, and
> make them dependent on being not this particular pinctrl device.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  .../pinctrl/allwinner,sun4i-a10-pinctrl.yaml      | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
