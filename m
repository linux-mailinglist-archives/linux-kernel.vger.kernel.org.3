Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F033958A193
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 21:51:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239229AbiHDTvb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 15:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235293AbiHDTvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 15:51:10 -0400
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D3CC6BD58;
        Thu,  4 Aug 2022 12:50:42 -0700 (PDT)
Received: by mail-il1-f180.google.com with SMTP id j20so435135ila.6;
        Thu, 04 Aug 2022 12:50:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:references:in-reply-to:cc:to:from
         :x-gm-message-state:from:to:cc;
        bh=c+lfeYbmQzrdXFvP7lcfdDn539L06Iv7kKvWbZznc3s=;
        b=ePves74XTd89EhEIL8U7p/Xd9mqHNsuLBRNWj9HguQtdgV6rqsQhz10QtVA4jAyciY
         BxMrAC+iAY6Y0D7DKhhcck37jKLHLg5qyRIvzUWxWyaaqqdJWCFAPub++RVLi6PeC0Ru
         T3nR8iN4HO4gLqKQW/jMhkLKRM7ywYH0wNC3d4Wp+qHDJ8hBRNpkv1gofaCSrzrf7XyC
         ktn80jhA+UuCPmGRV3S+AayTS0yqQMoFDj+ppu77umWxrMrhpoBiLvt0zMya91MJygbB
         jqVwdgEUqQaWk5FrRrG6nT5AzP/YmW3n2JLKYu8CivcrhPEpHizm2QKnkK6wDgIjXHIn
         CJ0g==
X-Gm-Message-State: ACgBeo1Xr0yg6G5e5ifZQZ+ADix7FUtOr84Pbym0qUz90qm6WaD25Qc3
        uRmWn8kz4g+7FS70zPlxzg==
X-Google-Smtp-Source: AA6agR7u0l38e/FffftiZmTXKP1m1dVqkPyS9dEXiBCiG5YDG9cwa+SHcna4Er/WhU6rDTuFL4nhSg==
X-Received: by 2002:a05:6e02:1c0a:b0:2de:87ff:18f2 with SMTP id l10-20020a056e021c0a00b002de87ff18f2mr1554084ilh.133.1659642641182;
        Thu, 04 Aug 2022 12:50:41 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id e11-20020a056e020b2b00b002dd0a586cbasm755840ilu.58.2022.08.04.12.50.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 12:50:40 -0700 (PDT)
Received: (nullmailer pid 259295 invoked by uid 1000);
        Thu, 04 Aug 2022 19:50:38 -0000
From:   Rob Herring <robh@kernel.org>
To:     bchihi@baylibre.com
Cc:     louis.yu@mediatek.com, james.lo@mediatek.com, khilman@baylibre.com,
        p.zabel@pengutronix.de, amitk@kernel.org,
        linux-kernel@vger.kernel.org, mka@chromium.org,
        abailon@baylibre.com, devicetree@vger.kernel.org,
        rafael@kernel.org, linux-mediatek@lists.infradead.org,
        daniel.lezcano@linaro.org, rui.zhang@intel.com,
        linux-pm@vger.kernel.org, krzk+dt@kernel.org,
        fan.chen@mediatek.com, matthias.bgg@gmail.com,
        linux-arm-kernel@lists.infradead.org, rex-bc.chen@mediatek.com,
        robh+dt@kernel.org
In-Reply-To: <20220804130912.676043-3-bchihi@baylibre.com>
References: <20220804130912.676043-1-bchihi@baylibre.com> <20220804130912.676043-3-bchihi@baylibre.com>
Subject: Re: [PATCH v8.1, 2/7] dt-bindings: thermal: Add binding document for LVTS thermal controllers
Date:   Thu, 04 Aug 2022 13:50:38 -0600
Message-Id: <1659642638.738608.259294.nullmailer@robh.at.kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 04 Aug 2022 15:09:07 +0200, bchihi@baylibre.com wrote:
> From: Alexandre Bailon <abailon@baylibre.com>
> 
> This patch adds dt-binding documents for mt8192 and mt8195 thermal controllers.
> 
> Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
> Signed-off-by: Balsam CHIHI <bchihi@baylibre.com>
> ---
>  .../thermal/mediatek,lvts-thermal.yaml        | 77 +++++++++++++++++++
>  1 file changed, 77 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/thermal/mediatek,lvts-thermal.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Error: Documentation/devicetree/bindings/thermal/mediatek,lvts-thermal.example.dts:32.36-37 syntax error
FATAL ERROR: Unable to parse input tree
make[1]: *** [scripts/Makefile.lib:383: Documentation/devicetree/bindings/thermal/mediatek,lvts-thermal.example.dtb] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1404: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

