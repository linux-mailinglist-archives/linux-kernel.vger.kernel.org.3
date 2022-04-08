Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11CFE4F9E8D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 23:03:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239602AbiDHVFU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 17:05:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbiDHVFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 17:05:17 -0400
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B7F9109A58;
        Fri,  8 Apr 2022 14:03:13 -0700 (PDT)
Received: by mail-oi1-f176.google.com with SMTP id j83so10077228oih.6;
        Fri, 08 Apr 2022 14:03:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/yIsNSUc8qGAbaMnYX8cxLVaWd5OnscpW0Cx4j0421g=;
        b=mHuqj3z2up4HbrBjshGcdAM+Aj0amOSPvaX3wrjx6XKPvDRv0l7uTkV4myjIqQKrmX
         fYhZoJ+X/bPrESxoXJmgcSyDff62kiSHLu/XACCMYuGhNuqXygU/HReDyow1fnVh9sed
         vaC2RxV2rtXNHYIeGHmCyvzofMU3612zrN7ISoR31f8b9gZWNBT+xQsXLBx89IL589rP
         jsFVBze/OE20UUP3V4zA8JKh4Da5wGtVEn2yIIyng0XXgx6ffGcF5f7sPDnRGptpbEIi
         pNS1OkoqVbRFWIgb+ClmYjc67T8K54zpQOgws5oYIoq7VpFegJmSHETYRIavnzLFxDsA
         JFsA==
X-Gm-Message-State: AOAM531HynSEgvb1ApYRE/JSVwKkY6/XnNLa0LEfRFmA7ZIT/t7CU+dD
        3zxzfJU72qRmrD/1e7ZK6w==
X-Google-Smtp-Source: ABdhPJzHJJglqCz7IrBXWl75C79VK8BDZdirWTXRHQ/BvIN/fJ0PI4XSx76ZHA4FFpG/CsI3x3NtCg==
X-Received: by 2002:aca:6548:0:b0:2d9:ce64:bead with SMTP id j8-20020aca6548000000b002d9ce64beadmr770226oiw.109.1649451792804;
        Fri, 08 Apr 2022 14:03:12 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id y3-20020a056870e50300b000d9be6436f1sm9101097oag.29.2022.04.08.14.03.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Apr 2022 14:03:12 -0700 (PDT)
Received: (nullmailer pid 4061106 invoked by uid 1000);
        Fri, 08 Apr 2022 21:03:11 -0000
Date:   Fri, 8 Apr 2022 16:03:11 -0500
From:   Rob Herring <robh@kernel.org>
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 01/14] dt-bindings: reset: amlogic,meson-axg-audio-arb:
 Convert to yaml
Message-ID: <YlCjDzZdOsHuzvuH@robh.at.kernel.org>
References: <20220407154338.4190674-1-p.zabel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220407154338.4190674-1-p.zabel@pengutronix.de>
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

On Thu, 07 Apr 2022 17:43:25 +0200, Philipp Zabel wrote:
> Convert the device tree bindings for the Amlogic audio memory arbiter
> controller to YAML schema to allow participating in DT validation.
> 
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> Cc: Kevin Hilman <khilman@baylibre.com>
> Cc: Jerome Brunet <jbrunet@baylibre.com>
> Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>  .../reset/amlogic,meson-axg-audio-arb.txt     | 22 --------
>  .../reset/amlogic,meson-axg-audio-arb.yaml    | 56 +++++++++++++++++++
>  2 files changed, 56 insertions(+), 22 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/reset/amlogic,meson-axg-audio-arb.txt
>  create mode 100644 Documentation/devicetree/bindings/reset/amlogic,meson-axg-audio-arb.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
