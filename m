Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BD974C2DBB
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 15:00:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235170AbiBXN7z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 08:59:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235103AbiBXN7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 08:59:53 -0500
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B9A71D8AA7;
        Thu, 24 Feb 2022 05:59:21 -0800 (PST)
Received: by mail-oi1-f176.google.com with SMTP id y7so2568116oih.5;
        Thu, 24 Feb 2022 05:59:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=IRGawcaWb3HAdRKUCLswxk7TuJAtTeTMggo9Sf2B36g=;
        b=53egHW/nTBJiV2lJuu4GhDNX1zww/JB1WE35ntTQmiCQk8Rzfs1bVck0OMcmU2sFpF
         UquJcfGFGKXk91bFNtWx3Qc3Uq5MhjKRf6J0kiO9eZiSFex+K16w/6OTiun+FBc0+AxQ
         UtoEmuAnJttEeDS/VB1N2zTWR4HUIiY7fPrEE2IbuDLaWa4hedzprBumskjXuf/MF5da
         hN9AV2ukysldUeai6jHaLMKCqyLgo8UNSf+DhZeatISi1lDj3o+IsR6hAQMja4ZvC+lN
         IALXJhqNzuI6ZMcbBve/XHwkCdBwI6YhRmXSOAE4/vVxLO5rtjbycJWntrp/n/lv0ojS
         Dj+Q==
X-Gm-Message-State: AOAM532R9fE7Kmp6ONU8UlmxkMrWmBUaELJsdtAMfxj2C9/PcuOxvKli
        Q/pqRY7E2Rr1J88RYJhx8A==
X-Google-Smtp-Source: ABdhPJxwUBdfub1XrfEXqlhfEm0hBC0rX1ftJRWiQjrbMw8v19MhBVkkdZwf6W/zs7MeVz6KdORuOQ==
X-Received: by 2002:a05:6808:238a:b0:2d7:1878:9623 with SMTP id bp10-20020a056808238a00b002d718789623mr1267173oib.1.1645711160906;
        Thu, 24 Feb 2022 05:59:20 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id d7sm1206734otl.44.2022.02.24.05.59.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 05:59:20 -0800 (PST)
Received: (nullmailer pid 2923125 invoked by uid 1000);
        Thu, 24 Feb 2022 13:59:19 -0000
From:   Rob Herring <robh@kernel.org>
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     agross@kernel.org, bhupesh.linux@gmail.com,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        robh+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        devicetree@vger.kernel.org, linux-phy@lists.infradead.org
In-Reply-To: <20220224123248.67073-2-bhupesh.sharma@linaro.org>
References: <20220224123248.67073-1-bhupesh.sharma@linaro.org> <20220224123248.67073-2-bhupesh.sharma@linaro.org>
Subject: Re: [PATCH 2/2] dt-bindings: phy: qcom,qmp: Describe 'vdda-max-microamp' & 'vdda-pll-max-microamp' properties
Date:   Thu, 24 Feb 2022 07:59:19 -0600
Message-Id: <1645711159.080022.2923124.nullmailer@robh.at.kernel.org>
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

On Thu, 24 Feb 2022 18:02:48 +0530, Bhupesh Sharma wrote:
> Since a few boards based on QCoM qmp phy use the
> 'vdda-max-microamp' & 'vdda-pll-max-microamp' properties to
> describe the ufs phy nodes, add them to the dt-bindings doc as well.
> 
> This fixes the following '$ make dtbs_check' warning(s):
> 
> sm8350-microsoft-surface-duo2.dt.yaml: phy@1d87000:
>   'vdda-max-microamp', 'vdda-pll-max-microamp' do not match any of
>    the regexes: '^phy@[0-9a-f]+$', 'pinctrl-[0-9]+'
> 
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Vinod Koul <vkoul@kernel.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> ---
>  Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/patch/1597137


phy@1c07000: 'lanes@1c06000' does not match any of the regexes: '^phy@[0-9a-f]+$', 'pinctrl-[0-9]+'
	arch/arm/boot/dts/qcom-sdx55-mtp.dt.yaml
	arch/arm/boot/dts/qcom-sdx55-t55.dt.yaml
	arch/arm/boot/dts/qcom-sdx55-telit-fn980-tlb.dt.yaml

phy@1c0e000: 'lanes@1c0e200' does not match any of the regexes: '^phy@[0-9a-f]+$', 'pinctrl-[0-9]+'
	arch/arm64/boot/dts/qcom/sc7280-crd.dt.yaml
	arch/arm64/boot/dts/qcom/sc7280-herobrine.dt.yaml
	arch/arm64/boot/dts/qcom/sc7280-idp2.dt.yaml
	arch/arm64/boot/dts/qcom/sc7280-idp.dt.yaml

phy@1d87000: 'lanes@1d87400' does not match any of the regexes: '^phy@[0-9a-f]+$', 'pinctrl-[0-9]+'
	arch/arm64/boot/dts/qcom/sm8450-qrd.dt.yaml

phy@627000: 'vdda-phy-max-microamp', 'vddp-ref-clk-always-on', 'vddp-ref-clk-max-microamp' do not match any of the regexes: '^phy@[0-9a-f]+$', 'pinctrl-[0-9]+'
	arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dt.yaml
	arch/arm64/boot/dts/qcom/msm8996-xiaomi-scorpio.dt.yaml

phy-wrapper@88e9000: 'vdda-phy-supply' is a required property
	arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami-pdx214.dt.yaml
	arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami-pdx215.dt.yaml

phy-wrapper@88e9000: 'vdda-pll-supply' is a required property
	arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami-pdx214.dt.yaml
	arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami-pdx215.dt.yaml

ssphy@78000: 'lane@78200' does not match any of the regexes: '^phy@[0-9a-f]+$', 'pinctrl-[0-9]+'
	arch/arm64/boot/dts/qcom/ipq6018-cp01-c1.dt.yaml

