Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB9A25431C3
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 15:46:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240751AbiFHNpX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 09:45:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240706AbiFHNpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 09:45:18 -0400
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0BD0270F04;
        Wed,  8 Jun 2022 06:45:15 -0700 (PDT)
Received: by mail-il1-f181.google.com with SMTP id r3so16579809ilt.8;
        Wed, 08 Jun 2022 06:45:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=nxt4zB3NiDLvrfrp1r/mGAmD2xuuHerTwRdciW5oJ38=;
        b=z+R6eqdf7XVHc4nbEpE8C7bPKNKboWpA+5z9FdQTor/5ssklxc8/ALyU89J+nn02zU
         IQn/2LAKrNuzHfEg43ZLeUYRJjGXtLndP325AVgnJ7B6p4ZnkT/bzsETbRNU3/8YLz+p
         SCYA6lzsRnSPOJKFSYS4DA6pFXpnoPqzvQsuALDsHjNiXVMAFa/9i8uVTbjPPqmhuk7W
         BxkNBgw/2ysbWTSEmbD/VkIl1jvulW4c3QzPg6/AM7scpkWIz4smqXaZifNFMXeuZ+5Z
         RtFM/8BUqbn5VgK8fcoXnk8I/2FReB3IDzIny3RZS5/QywZQNuQ8h0+vl7vIkRFhpnd+
         aq9Q==
X-Gm-Message-State: AOAM5322G6q8X22XBTfU2RkgCvuxgTrm+rRBQb2PDYZnICn5q80MOX2r
        xHksPRkpdSKfhX+V60AtOw==
X-Google-Smtp-Source: ABdhPJzsgg41nY4HIETpdP5gTS2iptitF26o+NqLxOyvONx5rzCV4DuniTOJCbxZxNkm8/k0z0qA+w==
X-Received: by 2002:a05:6e02:1d18:b0:2d3:bd9f:1a5f with SMTP id i24-20020a056e021d1800b002d3bd9f1a5fmr20404838ila.35.1654695914878;
        Wed, 08 Jun 2022 06:45:14 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id p3-20020a0566380e8300b0032b74686763sm8079460jas.76.2022.06.08.06.45.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 06:45:14 -0700 (PDT)
Received: (nullmailer pid 1272094 invoked by uid 1000);
        Wed, 08 Jun 2022 13:45:07 -0000
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Ivan T. Ivanov" <ivan.ivanov@linaro.org>,
        linux-kernel@vger.kernel.org, Kumar Gala <galak@codeaurora.org>,
        Andy Gross <agross@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org
In-Reply-To: <20220608112702.80873-1-krzysztof.kozlowski@linaro.org>
References: <20220608112702.80873-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH 1/2] dt-bindings: thermal: qcom,spmi-temp-alarm: convert to dtschema
Date:   Wed, 08 Jun 2022 07:45:07 -0600
Message-Id: <1654695907.406371.1272093.nullmailer@robh.at.kernel.org>
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

On Wed, 08 Jun 2022 13:27:01 +0200, Krzysztof Kozlowski wrote:
> Convert the Qualcomm QPNP PMIC Temperature Alarm to DT Schema.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../thermal/qcom,spmi-temp-alarm.yaml         | 85 +++++++++++++++++++
>  .../bindings/thermal/qcom-spmi-temp-alarm.txt | 51 -----------
>  2 files changed, 85 insertions(+), 51 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/thermal/qcom,spmi-temp-alarm.yaml
>  delete mode 100644 Documentation/devicetree/bindings/thermal/qcom-spmi-temp-alarm.txt
> 

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/patch/


temp-alarm@2400: '#thermal-sensor-cells' is a required property
	arch/arm/boot/dts/qcom-apq8074-dragonboard.dtb
	arch/arm/boot/dts/qcom-apq8074-dragonboard.dtb
	arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dtb
	arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dtb
	arch/arm/boot/dts/qcom-msm8974pro-fairphone-fp2.dtb
	arch/arm/boot/dts/qcom-msm8974pro-fairphone-fp2.dtb
	arch/arm/boot/dts/qcom-msm8974pro-sony-xperia-shinano-castor.dtb
	arch/arm/boot/dts/qcom-msm8974pro-sony-xperia-shinano-castor.dtb
	arch/arm/boot/dts/qcom-msm8974-sony-xperia-rhine-amami.dtb
	arch/arm/boot/dts/qcom-msm8974-sony-xperia-rhine-amami.dtb
	arch/arm/boot/dts/qcom-msm8974-sony-xperia-rhine-honami.dtb
	arch/arm/boot/dts/qcom-msm8974-sony-xperia-rhine-honami.dtb

