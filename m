Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 620C6591495
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 19:04:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237764AbiHLRDv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 13:03:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234501AbiHLRDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 13:03:48 -0400
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66F3EB14DC;
        Fri, 12 Aug 2022 10:03:47 -0700 (PDT)
Received: by mail-il1-f170.google.com with SMTP id j20so773391ila.6;
        Fri, 12 Aug 2022 10:03:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=CbsNiIytCv9TuWDoxy66NWQwnGNftXPPpewBJoHfDIA=;
        b=0Xarzv5J/J0SRECwpiCsW/xHv1QyAniPN7V1u6zQRGg6aLO65oVuJB0P1B2bw2V4aS
         TGTnSZ09aaUMLRwbB8+e4mTVlxiI66LbnbmanNUVmJJCTPzAh/JRTaUDgiyBw3fENahs
         7wfRGjJEg5wcWdTTT8Oj6LCCsj/+3G88UQO0/2cz3X2rpwHUd56xeV20hmM6ZXxrZJrC
         CRAynr2Ix/Z36f3qERUQckxQ+AI8kEeDgVD/xHrOmGHLWxQpxn5IZgFLP/4+fW8gO9jB
         WGtzknlXihP42SMJiqYJK6nhB4hAJLNgX62b5LwtUwBuGeHqzgGhzCAPFUTcbHScGjVq
         LnhQ==
X-Gm-Message-State: ACgBeo2u0FRW4K/22SpojVWM0eqXXuomfvYziclkqd/M2Bv2bUqDtmgw
        vfah4qtCTyQRNMp+ezq8nw==
X-Google-Smtp-Source: AA6agR5GGZj+HKLM7Mbb9Xw/65Zf53mj7vmnn/eflsC5QhVZLQwAoBMdhIHCeDPP16ImS8/8n8bnbQ==
X-Received: by 2002:a05:6e02:80a:b0:2e3:4975:bf8a with SMTP id u10-20020a056e02080a00b002e34975bf8amr2115319ilm.316.1660323826577;
        Fri, 12 Aug 2022 10:03:46 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id c17-20020a023311000000b003434ee85d38sm105274jae.4.2022.08.12.10.03.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Aug 2022 10:03:46 -0700 (PDT)
Received: (nullmailer pid 327993 invoked by uid 1000);
        Fri, 12 Aug 2022 17:03:43 -0000
Date:   Fri, 12 Aug 2022 11:03:43 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
        Christophe Branchereau <cbranchereau@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Bakker <xc-racer2@live.ca>, linux-spi@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Sam Ravnborg <sam@ravnborg.org>, devicetree@vger.kernel.org,
        Daniel Vetter <daniel@ffwll.ch>,
        Pratyush Yadav <p.yadav@ti.com>
Subject: Re: [PATCH] spi/panel: dt-bindings: drop 3-wire from common
 properties
Message-ID: <20220812170343.GA327951-robh@kernel.org>
References: <20220810131311.428645-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220810131311.428645-1-krzysztof.kozlowski@linaro.org>
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

On Wed, 10 Aug 2022 16:13:11 +0300, Krzysztof Kozlowski wrote:
> The spi-3wire property is device specific and should be accepted only if
> device really needs them.  Drop it from common spi-peripheral-props.yaml
> schema, mention in few panel drivers which use it and include instead in
> the SPI controller bindings.  The controller bindings will provide
> spi-3wire type validation and one place for description.  Each device
> schema must list the property if it is applicable.
> 
> The Samsung S6E63M0 panel uses also spi-cpha/cpol properties on at least
> one board (ste-ux500-samsung-janice/dts), so add also these to the
> panel's bindings.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/display/panel/kingdisplay,kd035g6-54nt.yaml     | 2 ++
>  .../bindings/display/panel/leadtek,ltk035c5444t.yaml         | 2 ++
>  .../devicetree/bindings/display/panel/samsung,s6e63m0.yaml   | 4 ++++
>  Documentation/devicetree/bindings/spi/spi-controller.yaml    | 5 +++++
>  .../devicetree/bindings/spi/spi-peripheral-props.yaml        | 5 -----
>  5 files changed, 13 insertions(+), 5 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
