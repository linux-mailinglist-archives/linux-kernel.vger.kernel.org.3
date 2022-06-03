Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 741CA53D1A3
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 20:37:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346212AbiFCSgp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 14:36:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347393AbiFCSgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 14:36:18 -0400
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E53613D0A;
        Fri,  3 Jun 2022 11:30:08 -0700 (PDT)
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-e93bbb54f9so11599020fac.12;
        Fri, 03 Jun 2022 11:30:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=NoZueTqBTFHqoW2V0oKAZcuh2rQllUCwjTZ5cTCnpPA=;
        b=P8Tt68jNY9lgUUgRocZq/lFKKQR0KF5P35buLAr2trQsuA9617PIMEwSOn4ApXW71E
         IEzf+UXOS5JNj/tpH/EucM9c61AJZMFtKXvx7xMY6VaUCk4C/5lnxOdl4M1sMR5E3dOo
         UtSlBn5wLhYyL2ucTPfX39dpLNpsyJDXDUlQCfJBEYwj8C6K4xN5GZJLyRWHriOUUoLN
         amte2CFdBsf+2eRsJ9zjysNjLKCfpl0UnyC5UkR/VoOH+C6E0ZNoMXAklfUnkbW3y+E3
         o6qegYP+OwKlIe525VOSjeLjBsjKu93G+WyoC1//ftNStC8jQ5DCi/+yBOxv1nUUI+8W
         dJfw==
X-Gm-Message-State: AOAM530Sv8E5tqmmsH9X/zsYeCHCNqjXvZXrNLCfgAfjNmZuklaiXc5C
        WXq/oNuPAaZ4FyJcdDsxdg==
X-Google-Smtp-Source: ABdhPJyzH+OIZZaKi/EAizHvUAcXwuItDmuL104JF7zjaiYOtTl+1hwMuY6KNywnYr0mjVYyEYv0hA==
X-Received: by 2002:a05:6870:2382:b0:f2:b9e7:ee32 with SMTP id e2-20020a056870238200b000f2b9e7ee32mr23599867oap.279.1654281007871;
        Fri, 03 Jun 2022 11:30:07 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id d130-20020aca3688000000b0032ae3d9bf6asm4140333oia.16.2022.06.03.11.30.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 11:30:07 -0700 (PDT)
Received: (nullmailer pid 680141 invoked by uid 1000);
        Fri, 03 Jun 2022 18:30:04 -0000
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     devicetree@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Stefan Hansson <newbie13xd@gmail.com>,
        linux-input@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Andreas Kemnade <andreas@kemnade.info>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220603101601.542054-2-krzysztof.kozlowski@linaro.org>
References: <20220603101601.542054-1-krzysztof.kozlowski@linaro.org> <20220603101601.542054-2-krzysztof.kozlowski@linaro.org>
Subject: Re: [RFC PATCH 1/2] dt-bindings: input: gpio-keys: enforce node names to match all properties
Date:   Fri, 03 Jun 2022 13:30:04 -0500
Message-Id: <1654281004.026927.680140.nullmailer@robh.at.kernel.org>
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

On Fri, 03 Jun 2022 12:16:00 +0200, Krzysztof Kozlowski wrote:
> The gpio-keys DT schema matches all properties with a wide pattern and
> applies specific schema to children.  This has drawback - all regular
> properties are also matched and are silently ignored, even if they are
> not described in schema.  Basically this allows any non-object property
> to be present.
> 
> Enforce specific naming pattern for children (keys) to narrow the
> pattern thus do not match other properties.  This will require all
> children to be named with 'key-' prefix or '-key' suffix.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/input/gpio-keys.yaml  | 169 +++++++++---------
>  1 file changed, 83 insertions(+), 86 deletions(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pinctrl/nuvoton,wpcm450-pinctrl.example.dtb: gpio-keys: 'uid' does not match any of the regexes: '^(key|key-[a-z0-9-]+|[a-z0-9-]+-key)$', 'pinctrl-[0-9]+'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/input/gpio-keys.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/input/gpio-keys.example.dtb: gpio-keys: 'autorepeat', 'down', 'up' do not match any of the regexes: '^(key|key-[a-z0-9-]+|[a-z0-9-]+-key)$', 'pinctrl-[0-9]+'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/input/gpio-keys.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

