Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A930581ABA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 22:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239859AbiGZUJM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 16:09:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239833AbiGZUJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 16:09:07 -0400
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34C4F357FD;
        Tue, 26 Jul 2022 13:09:06 -0700 (PDT)
Received: by mail-il1-f170.google.com with SMTP id e12so1040712ilu.7;
        Tue, 26 Jul 2022 13:09:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=nrDG32o/nF0+drBL5HQUQubPYkcsSpm90fWevm2EMus=;
        b=Ma24HiauyBbRCkblMqVysmo6QVrvXjvH2TuS1ys5daUeGrGEgwFt5djgiaI1Kem8I0
         UR3WQBNz1YFDWmDrpS88fmP5kv1fH5Y1OicnX/gaouuMdjf3QeHHR3RIu3gL2j13UwOz
         g69UtxIqv5jfjdy7Fp7E1vxtLHFzmtGyih8PrbQnNWmu9SUkYMhKUhiAW5I+0fBMYTrG
         rK84yXT2aj45rSMEnLIPO+7EaIO/kMcJKnPiC5x0VF2if6D0mKJMVAqbv1GjGKeiLT4h
         TVFnspCFNZeNzI3uLGzT9kA01iNQmndANak4xuuu93Vt4OvNqD4zUpRUXS7XOEnuipWF
         ELZA==
X-Gm-Message-State: AJIora95cQRCMMM5VlFYOc/Ndwkp9O9z+3SL6xbr0O5j6iUFyk+YkYro
        ndxUWs1uqxe5aYMzWvx+Wg==
X-Google-Smtp-Source: AGRyM1uhqlxORuUmIgfm9uGaklPD+6R+WsuRI46aW6jH891vImtrJFDsBDRJwFUBPN+Qa2GUfxDIYA==
X-Received: by 2002:a05:6e02:180d:b0:2dd:6150:58b0 with SMTP id a13-20020a056e02180d00b002dd615058b0mr3659262ilv.265.1658866145360;
        Tue, 26 Jul 2022 13:09:05 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id k4-20020a0566022d8400b0067be568081fsm7588026iow.43.2022.07.26.13.09.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 13:09:05 -0700 (PDT)
Received: (nullmailer pid 782233 invoked by uid 1000);
        Tue, 26 Jul 2022 20:09:02 -0000
From:   Rob Herring <robh@kernel.org>
To:     Balsam CHIHI <bchihi@baylibre.com>
Cc:     rui.zhang@intel.com, rex-bc.chen@mediatek.com,
        daniel.lezcano@linaro.org, amitk@kernel.org, mka@chromium.org,
        linux-kernel@vger.kernel.org, abailon@baylibre.com,
        robh+dt@kernel.org, p.zabel@pengutronix.de, matthias.bgg@gmail.com,
        linux-pm@vger.kernel.org, rafael@kernel.org, khilman@baylibre.com,
        fan.chen@mediatek.com, linux-arm-kernel@lists.infradead.org,
        krzk+dt@kernel.org, devicetree@vger.kernel.org,
        linux-mediatek@lists.infradead.org, louis.yu@mediatek.com,
        james.lo@mediatek.com
In-Reply-To: <20220726135506.485108-3-bchihi@baylibre.com>
References: <20220726135506.485108-1-bchihi@baylibre.com> <20220726135506.485108-3-bchihi@baylibre.com>
Subject: Re: [PATCH v8 2/6] dt-bindings: thermal: Add binding document for LVTS thermal controllers
Date:   Tue, 26 Jul 2022 14:09:02 -0600
Message-Id: <1658866142.328871.782232.nullmailer@robh.at.kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Jul 2022 15:55:02 +0200, Balsam CHIHI wrote:
> This patch adds dt-binding documents for mt8192 and mt8195 thermal controllers.
> 
> Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
> Signed-off-by: Balsam CHIHI <bchihi@baylibre.com>
> ---
>  .../thermal/mediatek,mt8192-lvts.yaml         | 73 ++++++++++++++++++
>  .../thermal/mediatek,mt8195-lvts.yaml         | 75 +++++++++++++++++++
>  2 files changed, 148 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/thermal/mediatek,mt8192-lvts.yaml
>  create mode 100644 Documentation/devicetree/bindings/thermal/mediatek,mt8195-lvts.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Error: Documentation/devicetree/bindings/thermal/mediatek,mt8195-lvts.example.dts:32.36-37 syntax error
FATAL ERROR: Unable to parse input tree
make[1]: *** [scripts/Makefile.lib:383: Documentation/devicetree/bindings/thermal/mediatek,mt8195-lvts.example.dtb] Error 1
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

