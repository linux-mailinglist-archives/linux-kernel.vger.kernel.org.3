Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 379775172B5
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 17:34:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385856AbiEBPhJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 11:37:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351821AbiEBPhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 11:37:05 -0400
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 654EFBC1C;
        Mon,  2 May 2022 08:33:35 -0700 (PDT)
Received: by mail-oi1-f177.google.com with SMTP id l16so8291644oil.6;
        Mon, 02 May 2022 08:33:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=JTr8vcwPekKNxgaP35/VIOaNAgxzoIKDrhPTZqxgCxU=;
        b=7OwkSe5n9Zzsp7Qcx3IA0J518knboVSaMgvoua/YexsWTPcXDKhLFcuTW9b1uP9b0i
         VEteYfAsWple6fwx0lzULoDfcHlaL+uyGP+CxTiOsXhJBo+vIjlbutoCe8uUBEMpdeMQ
         qzTWGeIROdM4NaC6VUY7ldWmZvVLkESJ3y1QiZ4NSU7mkbKmG5cxSHyZDjdtEzNObj4z
         2lF7xO8fUeRDKdCtfmiSHfCM6zOI4bMK69RrnP6ojkkhfwfKsQZcVCqNxgKJMYAt6mJ6
         JKPn3cmnvoHZvZPTwrHg8SSOZ9ZWKQ0DWiFnHAipHG6JPXeE5OSvlcUcd6PXo/74KYlH
         Mzqw==
X-Gm-Message-State: AOAM532oUqSa4W/ibfQ5dSGQ2/RkDYkghwzut01U8F4MFOGPBhGytaJW
        qW1bQ7v1UrOxxipIlo1zGcrQQxEELg==
X-Google-Smtp-Source: ABdhPJxa6lKGhgt8BCT4MFbjaP/pVYGPXQU98T1b6xKT0Rz+NpKi1Ij5LNe546qeMFfARWCfjo9rDg==
X-Received: by 2002:a05:6808:ecc:b0:2fa:7d95:8dec with SMTP id q12-20020a0568080ecc00b002fa7d958decmr7581969oiv.34.1651505613227;
        Mon, 02 May 2022 08:33:33 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id m9-20020a4ad509000000b0035eb4e5a6dasm3916737oos.48.2022.05.02.08.33.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 08:33:32 -0700 (PDT)
Received: (nullmailer pid 1161777 invoked by uid 1000);
        Mon, 02 May 2022 15:33:29 -0000
From:   Rob Herring <robh@kernel.org>
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
In-Reply-To: <20220430060125.9124-4-ansuelsmth@gmail.com>
References: <20220430060125.9124-1-ansuelsmth@gmail.com> <20220430060125.9124-4-ansuelsmth@gmail.com>
Subject: Re: [PATCH v2 3/3] dt-bindings: arm: msm: Convert kpss-gcc driver Documentation to yaml
Date:   Mon, 02 May 2022 10:33:29 -0500
Message-Id: <1651505609.498439.1161776.nullmailer@robh.at.kernel.org>
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

On Sat, 30 Apr 2022 08:01:25 +0200, Ansuel Smith wrote:
> Convert kpss-gcc driver Documentation to yaml.
> Add #clock-cells additional binding to required bindings and example
> as it's a required binding for clock-output-names.
> 
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> ---
>  .../bindings/arm/msm/qcom,kpss-gcc.txt        | 44 ------------
>  .../bindings/arm/msm/qcom,kpss-gcc.yaml       | 68 +++++++++++++++++++
>  2 files changed, 68 insertions(+), 44 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc.yaml
> 

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/patch/


clock-controller@2011000: '#clock-cells' is a required property
	arch/arm/boot/dts/qcom-apq8064-asus-nexus7-flo.dtb
	arch/arm/boot/dts/qcom-apq8064-cm-qs600.dtb
	arch/arm/boot/dts/qcom-apq8064-ifc6410.dtb
	arch/arm/boot/dts/qcom-apq8064-sony-xperia-yuga.dtb
	arch/arm/boot/dts/qcom-ipq8064-ap148.dtb
	arch/arm/boot/dts/qcom-ipq8064-rb3011.dtb
	arch/arm/boot/dts/qcom-mdm9615-wp8548-mangoh-green.dtb
	arch/arm/boot/dts/qcom-msm8960-cdp.dtb

clock-controller@2011000: 'clock-names' is a required property
	arch/arm/boot/dts/qcom-apq8064-asus-nexus7-flo.dtb
	arch/arm/boot/dts/qcom-apq8064-cm-qs600.dtb
	arch/arm/boot/dts/qcom-apq8064-ifc6410.dtb
	arch/arm/boot/dts/qcom-apq8064-sony-xperia-yuga.dtb
	arch/arm/boot/dts/qcom-mdm9615-wp8548-mangoh-green.dtb
	arch/arm/boot/dts/qcom-msm8960-cdp.dtb

clock-controller@2011000: 'clock-output-names' is a required property
	arch/arm/boot/dts/qcom-apq8064-asus-nexus7-flo.dtb
	arch/arm/boot/dts/qcom-apq8064-cm-qs600.dtb
	arch/arm/boot/dts/qcom-apq8064-ifc6410.dtb
	arch/arm/boot/dts/qcom-apq8064-sony-xperia-yuga.dtb
	arch/arm/boot/dts/qcom-mdm9615-wp8548-mangoh-green.dtb
	arch/arm/boot/dts/qcom-msm8960-cdp.dtb

clock-controller@2011000: 'clocks' is a required property
	arch/arm/boot/dts/qcom-apq8064-asus-nexus7-flo.dtb
	arch/arm/boot/dts/qcom-apq8064-cm-qs600.dtb
	arch/arm/boot/dts/qcom-apq8064-ifc6410.dtb
	arch/arm/boot/dts/qcom-apq8064-sony-xperia-yuga.dtb
	arch/arm/boot/dts/qcom-mdm9615-wp8548-mangoh-green.dtb
	arch/arm/boot/dts/qcom-msm8960-cdp.dtb

clock-controller@2011000: compatible:0: 'qcom,kpss-gcc' is not one of ['qcom,kpss-gcc-ipq8064', 'qcom,kpss-gcc-apq8064', 'qcom,kpss-gcc-msm8974', 'qcom,kpss-gcc-msm8960']
	arch/arm/boot/dts/qcom-apq8064-asus-nexus7-flo.dtb
	arch/arm/boot/dts/qcom-apq8064-cm-qs600.dtb
	arch/arm/boot/dts/qcom-apq8064-ifc6410.dtb
	arch/arm/boot/dts/qcom-apq8064-sony-xperia-yuga.dtb
	arch/arm/boot/dts/qcom-ipq8064-ap148.dtb
	arch/arm/boot/dts/qcom-ipq8064-rb3011.dtb
	arch/arm/boot/dts/qcom-mdm9615-wp8548-mangoh-green.dtb
	arch/arm/boot/dts/qcom-msm8960-cdp.dtb

clock-controller@2011000: compatible:1: 'qcom,kpss-gcc' was expected
	arch/arm/boot/dts/qcom-apq8064-asus-nexus7-flo.dtb
	arch/arm/boot/dts/qcom-apq8064-cm-qs600.dtb
	arch/arm/boot/dts/qcom-apq8064-ifc6410.dtb
	arch/arm/boot/dts/qcom-apq8064-sony-xperia-yuga.dtb
	arch/arm/boot/dts/qcom-ipq8064-ap148.dtb
	arch/arm/boot/dts/qcom-ipq8064-rb3011.dtb
	arch/arm/boot/dts/qcom-mdm9615-wp8548-mangoh-green.dtb
	arch/arm/boot/dts/qcom-msm8960-cdp.dtb

clock-controller@2082000: '#clock-cells' is a required property
	arch/arm/boot/dts/qcom-apq8060-dragonboard.dtb
	arch/arm/boot/dts/qcom-msm8660-surf.dtb

clock-controller@2082000: 'clock-names' is a required property
	arch/arm/boot/dts/qcom-apq8060-dragonboard.dtb
	arch/arm/boot/dts/qcom-msm8660-surf.dtb

clock-controller@2082000: 'clock-output-names' is a required property
	arch/arm/boot/dts/qcom-apq8060-dragonboard.dtb
	arch/arm/boot/dts/qcom-msm8660-surf.dtb

clock-controller@2082000: 'clocks' is a required property
	arch/arm/boot/dts/qcom-apq8060-dragonboard.dtb
	arch/arm/boot/dts/qcom-msm8660-surf.dtb

clock-controller@2082000: compatible:0: 'qcom,kpss-gcc' is not one of ['qcom,kpss-gcc-ipq8064', 'qcom,kpss-gcc-apq8064', 'qcom,kpss-gcc-msm8974', 'qcom,kpss-gcc-msm8960']
	arch/arm/boot/dts/qcom-apq8060-dragonboard.dtb
	arch/arm/boot/dts/qcom-msm8660-surf.dtb

clock-controller@2082000: compatible:1: 'qcom,kpss-gcc' was expected
	arch/arm/boot/dts/qcom-apq8060-dragonboard.dtb
	arch/arm/boot/dts/qcom-msm8660-surf.dtb

