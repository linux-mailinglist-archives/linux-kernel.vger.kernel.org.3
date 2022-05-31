Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4BF25399BA
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 00:47:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348513AbiEaWrD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 18:47:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348515AbiEaWq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 18:46:58 -0400
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0163360C6;
        Tue, 31 May 2022 15:46:57 -0700 (PDT)
Received: by mail-oi1-f180.google.com with SMTP id k11so318948oia.12;
        Tue, 31 May 2022 15:46:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=2Z7nZCZCrp6yDZohpwqv7FuEhmrYv7mpBJYl13nUGZE=;
        b=h8pyHggECMQnN4+tn4AA32NaL0V4jwHXPi71wtPsA82kGKaeXmBIdXHXGDYpSjNNOp
         gJGApLqj8turIq2loAj3eYlglK39G5aJLAX8E8tkmPtaY+dvYG27pGedkSiB8JFf2esI
         aDRbAoU3wkAAX8yoh4p1aJ1UdUz6HRTptidqElTGfrgZOlMtQc1dU/Rq53hYsmPkF88C
         IRUrzJu1Se2v2LWIBjlndv4W1h1RFiOLRDsvp0TVgEAspE4zKIF5KQcOgIt8DtiEnbnm
         pvQqdDZKMa9eT4ZFtKw1KXYixHcC4f1jFeO3wn9qRNlDetAahOD/SdCm4PUMj8c3cPGY
         T9PQ==
X-Gm-Message-State: AOAM532+Z27LPAhaZYyBLOyLqsTeKlRVTTCwUec5qS8bv6RAwLhNiTHb
        TJEFPaIy6bYFy/e92KD9KA==
X-Google-Smtp-Source: ABdhPJyCt/w64P3Qhbl9BTehgfuVFmuXiRTTi5iJf9VTUqZA4lc6Tq78gjAB18eUT2wVhb7SnkTfDA==
X-Received: by 2002:a05:6808:1454:b0:328:82a9:cb08 with SMTP id x20-20020a056808145400b0032882a9cb08mr13482779oiv.106.1654037216107;
        Tue, 31 May 2022 15:46:56 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id m19-20020a056820051300b0035eb4e5a6b0sm128663ooj.6.2022.05.31.15.46.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 15:46:55 -0700 (PDT)
Received: (nullmailer pid 2476551 invoked by uid 1000);
        Tue, 31 May 2022 22:46:54 -0000
From:   Rob Herring <robh@kernel.org>
To:     ChiaEn Wu <peterwu.pub@gmail.com>
Cc:     lee.jones@linaro.org, linux-fbdev@vger.kernel.org,
        linux-mediatek@lists.infradead.org, sre@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-leds@vger.kernel.org,
        gregkh@linuxfoundation.org, lgirdwood@gmail.com,
        chiaen_wu@richtek.com, dri-devel@lists.freedesktop.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        heikki.krogerus@linux.intel.com, alice_chen@richtek.com,
        broonie@kernel.org, linux-usb@vger.kernel.org, pavel@ucw.cz,
        robh+dt@kernel.org, linux@roeck-us.net, matthias.bgg@gmail.com,
        deller@gmx.de, linux-arm-kernel@lists.infradead.org,
        chunfeng.yun@mediatek.com, jingoohan1@gmail.com,
        daniel.thompson@linaro.org, jic23@kernel.org, cy_huang@richtek.com,
        lars@metafoo.de
In-Reply-To: <20220531111900.19422-4-peterwu.pub@gmail.com>
References: <20220531111900.19422-1-peterwu.pub@gmail.com> <20220531111900.19422-4-peterwu.pub@gmail.com>
Subject: Re: [RESEND 03/14] dt-bindings: leds: mt6370: Add Mediatek mt6370 indicator
Date:   Tue, 31 May 2022 17:46:54 -0500
Message-Id: <1654037214.458913.2476550.nullmailer@robh.at.kernel.org>
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

On Tue, 31 May 2022 19:18:49 +0800, ChiaEn Wu wrote:
> From: ChiYuan Huang <cy_huang@richtek.com>
> 
> Add Mediatek mt6370 indicator documentation.
> 
> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> ---
>  .../leds/mediatek,mt6370-indicator.yaml       | 57 +++++++++++++++++++
>  1 file changed, 57 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/leds/mediatek,mt6370-indicator.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:


doc reference errors (make refcheckdocs):
Warning: Documentation/devicetree/bindings/leds/mediatek,mt6370-indicator.yaml references a file that doesn't exist: Documentation/devicetree/bindings/mfd/mediatek,mt6370.yaml
Documentation/devicetree/bindings/leds/mediatek,mt6370-indicator.yaml: Documentation/devicetree/bindings/mfd/mediatek,mt6370.yaml

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

