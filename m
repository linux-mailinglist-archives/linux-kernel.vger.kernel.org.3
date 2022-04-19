Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66D07506C15
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 14:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352093AbiDSMQ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 08:16:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352199AbiDSMP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 08:15:56 -0400
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CB6B20BFF;
        Tue, 19 Apr 2022 05:12:53 -0700 (PDT)
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-e5bdd14b59so7703532fac.11;
        Tue, 19 Apr 2022 05:12:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=j1rFkwOvIXBO+3tCwlNTqd0pjl7npLIdFzpaL7V+7n0=;
        b=1/WEyvX7aOy9r0Qwh/1wevCsdA3PXUh9kizXIkiMq4gWQPuP8kj2YZI/NeFax19TYj
         hUbrjfIeBUxBmWtEbowlqCrEcXbp+v8NeL/AbOk5XCQNxasAFsDzoM26jhjnwUIeOu4D
         13aFHWWK/exuOwKmgvMixSgNumHTaj1JHYiqmpXE+XpfqB4F6CJkzPPVstAWTKgvZ6Z2
         ua0DU95YKw4aSaZKJMd+Yz5MXXhP2lIINHdit1s9pcJ8VUEEY8Ag6JKplSxT4MucMqMi
         ZTW+19dTLX7t3ltot3hF2pCaBS4NC98+evKzO7rzxXD7aBjNCF6H2o4G0YUPtfWo8XOo
         JfTg==
X-Gm-Message-State: AOAM531DhQRcroqGrjQ3lU54fJE35e7sBXAM0+4+h/fHn61HssmTjOfC
        rsfSnFzhcvn5dJU8SZaZTQ==
X-Google-Smtp-Source: ABdhPJw8+O8iy7OvXQDZqJ9fQ+HdQxBCCcLs+j8+1ctB3j5c9rN8Bw97hQrBsEse2DgYT7wYOAAbyQ==
X-Received: by 2002:a05:6870:2310:b0:da:b3f:2b76 with SMTP id w16-20020a056870231000b000da0b3f2b76mr8021407oao.277.1650370369925;
        Tue, 19 Apr 2022 05:12:49 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id ay9-20020a056808300900b0032272231c25sm2994238oib.40.2022.04.19.05.12.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 05:12:49 -0700 (PDT)
Received: (nullmailer pid 1977874 invoked by uid 1000);
        Tue, 19 Apr 2022 12:12:43 -0000
From:   Rob Herring <robh@kernel.org>
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, vkoul@kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        bhupesh.linux@gmail.com, bjorn.andersson@linaro.org,
        agross@kernel.org
In-Reply-To: <20220418205509.1102109-2-bhupesh.sharma@linaro.org>
References: <20220418205509.1102109-1-bhupesh.sharma@linaro.org> <20220418205509.1102109-2-bhupesh.sharma@linaro.org>
Subject: Re: [PATCH v3 1/4] dt-bindings: phy: qcom,qmp: Mark '#clock-cells' as a 'optional' property
Date:   Tue, 19 Apr 2022 07:12:43 -0500
Message-Id: <1650370363.629686.1977873.nullmailer@robh.at.kernel.org>
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

On Tue, 19 Apr 2022 02:25:06 +0530, Bhupesh Sharma wrote:
> '#clock-cells' is not a required property for qmp-phy(s) in the
> '/' node, but it should be is used in 'phy@' subnode (where it is
> actually a 'required' property). Fix the same.
> 
> This also fixes the following 'make dtbs_check' warning(s):
> 
> sm8350-microsoft-surface-duo2.dt.yaml: phy@1d87000:
>   '#clock-cells' is a required property
> 
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Vinod Koul <vkoul@kernel.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> ---
>  Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/patch/


phy@1c07000: 'lanes@1c06000' does not match any of the regexes: '^phy@[0-9a-f]+$', 'pinctrl-[0-9]+'
	arch/arm/boot/dts/qcom-sdx55-mtp.dtb
	arch/arm/boot/dts/qcom-sdx55-t55.dtb
	arch/arm/boot/dts/qcom-sdx55-telit-fn980-tlb.dtb

phy@1c0e000: 'lanes@1c0e200' does not match any of the regexes: '^phy@[0-9a-f]+$', 'pinctrl-[0-9]+'
	arch/arm64/boot/dts/qcom/sc7280-crd.dtb
	arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r0.dtb
	arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r1.dtb
	arch/arm64/boot/dts/qcom/sc7280-idp2.dtb
	arch/arm64/boot/dts/qcom/sc7280-idp.dtb

phy@1d87000: 'lanes@1d87400', 'vdda-max-microamp', 'vdda-pll-max-microamp' do not match any of the regexes: '^phy@[0-9a-f]+$', 'pinctrl-[0-9]+'
	arch/arm64/boot/dts/qcom/sm8450-hdk.dtb
	arch/arm64/boot/dts/qcom/sm8450-qrd.dtb

phy@1d87000: 'vdda-max-microamp', 'vdda-pll-max-microamp' do not match any of the regexes: '^phy@[0-9a-f]+$', 'pinctrl-[0-9]+'
	arch/arm64/boot/dts/qcom/sm8350-microsoft-surface-duo2.dtb

phy@627000: 'vdda-phy-max-microamp', 'vdda-pll-max-microamp', 'vddp-ref-clk-always-on', 'vddp-ref-clk-max-microamp' do not match any of the regexes: '^phy@[0-9a-f]+$', 'pinctrl-[0-9]+'
	arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dtb
	arch/arm64/boot/dts/qcom/msm8996-xiaomi-scorpio.dtb

phy-wrapper@88e9000: 'vdda-phy-supply' is a required property
	arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami-pdx214.dtb
	arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami-pdx215.dtb

phy-wrapper@88e9000: 'vdda-pll-supply' is a required property
	arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami-pdx214.dtb
	arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami-pdx215.dtb

ssphy@78000: '#clock-cells', 'lane@78200' do not match any of the regexes: '^phy@[0-9a-f]+$', 'pinctrl-[0-9]+'
	arch/arm64/boot/dts/qcom/ipq6018-cp01-c1.dtb

