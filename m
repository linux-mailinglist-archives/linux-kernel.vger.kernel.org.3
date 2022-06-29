Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DEC4560C61
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 00:39:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbiF2WjR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 18:39:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbiF2WhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 18:37:09 -0400
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CE221DA45;
        Wed, 29 Jun 2022 15:37:07 -0700 (PDT)
Received: by mail-io1-f48.google.com with SMTP id z191so17439763iof.6;
        Wed, 29 Jun 2022 15:37:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=sLQ/4d3QFAtHYu+uCD8QMISazPHvyTrVmvteNeKvuaQ=;
        b=oJ65tYdYb/RqGjj1/azJ7QR/N1GMOeY2BwxT6UkOFg4x3SUCu2BO8vbDq2giqMuGp+
         9fiVEyocdz61rmgkJnUQL0Dp1hV0Y8I9i9VZ9ivonz5+cmkou+4rUXYH2QJUwbY3RpRD
         yuZ3dW6Qy9PZKCS1uUN919x4KtFBZBXM/NY1tRQIQzc4Z5WwZXKoesVpx7BfRqOfprNK
         WZwO30Ilqis9RGZkQmLEf7T1LsxWMTeWN076LuT2OTpR9+CnpBaivNArGgUmP1rhUNQX
         BQ90tGTfBZIJAJeS3YpVdll/VzZ0YImzRzR332Jqjb7wUlTg5pGGL3xeM4j4iGX2eal2
         rzhQ==
X-Gm-Message-State: AJIora+u8/ZCiIF2O/NYWRwAqBKXKiR+TYYw38/U0qt21JFQxcCDjA1P
        PxCxhmOEi2kcdoletJDsAA==
X-Google-Smtp-Source: AGRyM1sghOTGd6KQzVVMS0L07/3dc/2oKvsyva/HwzKPzivIp90kjrJpUzWax9hkpqTcOZ7IJSoZtA==
X-Received: by 2002:a05:6638:2385:b0:332:236c:3b98 with SMTP id q5-20020a056638238500b00332236c3b98mr3326022jat.160.1656542226764;
        Wed, 29 Jun 2022 15:37:06 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id m47-20020a026a6f000000b00339d0617be1sm7750609jaf.35.2022.06.29.15.37.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 15:37:06 -0700 (PDT)
Received: (nullmailer pid 1042494 invoked by uid 1000);
        Wed, 29 Jun 2022 22:36:59 -0000
From:   Rob Herring <robh@kernel.org>
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     devicetree@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jens Axboe <axboe@kernel.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220629121441.6552-4-ansuelsmth@gmail.com>
References: <20220629121441.6552-1-ansuelsmth@gmail.com> <20220629121441.6552-4-ansuelsmth@gmail.com>
Subject: Re: [PATCH v4 3/5] dt-bindings: arm: msm: Rework kpss-gcc driver Documentation to yaml
Date:   Wed, 29 Jun 2022 16:36:59 -0600
Message-Id: <1656542219.667164.1042488.nullmailer@robh.at.kernel.org>
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

On Wed, 29 Jun 2022 14:14:39 +0200, Christian Marangi wrote:
> Rework kpss-gcc driver Documentation to yaml Documentation.
> The current kpss-gcc Documentation have major problems and can't be
> converted directly. Introduce various changes to the original
> Documentation.
> 
> Add #clock-cells additional binding as this clock outputs a static clk
> named acpu_l2_aux with supported compatible.
> Only some compatible require and outputs a clock, for the others, set
> only the reg as a required binding to correctly export the kpss-gcc
> registers. As the reg is shared also add the required syscon compatible.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  .../bindings/arm/msm/qcom,kpss-gcc.txt        | 44 ---------
>  .../bindings/arm/msm/qcom,kpss-gcc.yaml       | 90 +++++++++++++++++++
>  2 files changed, 90 insertions(+), 44 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc.yaml
> 

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/patch/


clock-controller@2011000: clock-names: False schema does not allow ['pll8_vote', 'pxo']
	arch/arm/boot/dts/qcom-ipq8064-ap148.dtb
	arch/arm/boot/dts/qcom-ipq8064-rb3011.dtb

clock-controller@2011000: 'clock-output-names' does not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm/boot/dts/qcom-ipq8064-ap148.dtb
	arch/arm/boot/dts/qcom-ipq8064-rb3011.dtb

clock-controller@2011000: compatible:0: 'qcom,kpss-gcc' is not one of ['qcom,kpss-gcc-ipq8064', 'qcom,kpss-gcc-apq8064', 'qcom,kpss-gcc-msm8974', 'qcom,kpss-gcc-msm8960', 'qcom,kpss-gcc-msm8660', 'qcom,kpss-gcc-mdm9615']
	arch/arm/boot/dts/qcom-apq8064-asus-nexus7-flo.dtb
	arch/arm/boot/dts/qcom-apq8064-cm-qs600.dtb
	arch/arm/boot/dts/qcom-apq8064-ifc6410.dtb
	arch/arm/boot/dts/qcom-apq8064-sony-xperia-lagan-yuga.dtb
	arch/arm/boot/dts/qcom-ipq8064-ap148.dtb
	arch/arm/boot/dts/qcom-ipq8064-rb3011.dtb
	arch/arm/boot/dts/qcom-mdm9615-wp8548-mangoh-green.dtb
	arch/arm/boot/dts/qcom-msm8960-cdp.dtb

clock-controller@2011000: compatible:1: 'qcom,kpss-gcc' was expected
	arch/arm/boot/dts/qcom-apq8064-asus-nexus7-flo.dtb
	arch/arm/boot/dts/qcom-apq8064-cm-qs600.dtb
	arch/arm/boot/dts/qcom-apq8064-ifc6410.dtb
	arch/arm/boot/dts/qcom-apq8064-sony-xperia-lagan-yuga.dtb
	arch/arm/boot/dts/qcom-ipq8064-ap148.dtb
	arch/arm/boot/dts/qcom-ipq8064-rb3011.dtb
	arch/arm/boot/dts/qcom-mdm9615-wp8548-mangoh-green.dtb
	arch/arm/boot/dts/qcom-msm8960-cdp.dtb

clock-controller@2011000: compatible: ['qcom,kpss-gcc', 'syscon'] is too short
	arch/arm/boot/dts/qcom-apq8064-asus-nexus7-flo.dtb
	arch/arm/boot/dts/qcom-apq8064-cm-qs600.dtb
	arch/arm/boot/dts/qcom-apq8064-ifc6410.dtb
	arch/arm/boot/dts/qcom-apq8064-sony-xperia-lagan-yuga.dtb
	arch/arm/boot/dts/qcom-ipq8064-ap148.dtb
	arch/arm/boot/dts/qcom-ipq8064-rb3011.dtb
	arch/arm/boot/dts/qcom-mdm9615-wp8548-mangoh-green.dtb
	arch/arm/boot/dts/qcom-msm8960-cdp.dtb

clock-controller@2082000: compatible:0: 'qcom,kpss-gcc' is not one of ['qcom,kpss-gcc-ipq8064', 'qcom,kpss-gcc-apq8064', 'qcom,kpss-gcc-msm8974', 'qcom,kpss-gcc-msm8960', 'qcom,kpss-gcc-msm8660', 'qcom,kpss-gcc-mdm9615']
	arch/arm/boot/dts/qcom-apq8060-dragonboard.dtb
	arch/arm/boot/dts/qcom-msm8660-surf.dtb

clock-controller@2082000: compatible:1: 'qcom,kpss-gcc' was expected
	arch/arm/boot/dts/qcom-apq8060-dragonboard.dtb
	arch/arm/boot/dts/qcom-msm8660-surf.dtb

clock-controller@2082000: compatible: ['qcom,kpss-gcc', 'syscon'] is too short
	arch/arm/boot/dts/qcom-apq8060-dragonboard.dtb
	arch/arm/boot/dts/qcom-msm8660-surf.dtb

