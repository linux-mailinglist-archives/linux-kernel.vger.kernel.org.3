Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BDFE50D220
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 15:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237638AbiDXNvB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 09:51:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237329AbiDXNu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 09:50:57 -0400
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F138716C17A;
        Sun, 24 Apr 2022 06:47:56 -0700 (PDT)
Received: by mail-oi1-f174.google.com with SMTP id b188so14351171oia.13;
        Sun, 24 Apr 2022 06:47:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=lz7aR3qijJWfEsk/FEbvct24DCiHf1gpQWffH3gtcJA=;
        b=4a5yRjdSwYgQufLjzXkuftuWXrljEO5ghzs9p4pQfdTCEiap1D9p9KQg66qwu6gGZ8
         p/8EygnF8trcII5IT3IQbtO97xLYBUGmrvUjn8RzQff3f8Sv/UFOymRxhCJHaoZKNo3T
         iCD3jWAoxV7RJyzRLXKfOMYOFgkJyf/c5vnBfrHMoe8pymTyDYdYkUv1FKy4t+MI2w91
         TyOv3iZ8+RcGGqgRy6ZoZAMtsjRGysUb+IcBMAGmhGELkTXVx2lDS/0fnu4HpxpusEzf
         LhYlx+NzsCBAVCtP2SCGXbxoOD3N5v4HfugLSTsnRl1XbPeYKw0tMzLRd1gNJT3JFCtH
         puyw==
X-Gm-Message-State: AOAM530Muw8PlbWEx6oq+j/zYp1qRBgEZt1k1lmW+q8riORrAh5WyZFE
        Ts4RvpHQek/XjAEQmT7fJA==
X-Google-Smtp-Source: ABdhPJzyt6kp1IR8r+OMydE06Kaez+s+D/dYk5oyPl1aDOdVPJ5c1uSFohqWES4OQshWK10yN198Og==
X-Received: by 2002:a05:6808:1201:b0:2f9:ef08:1a4f with SMTP id a1-20020a056808120100b002f9ef081a4fmr6266747oil.192.1650808076227;
        Sun, 24 Apr 2022 06:47:56 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id u20-20020a4a9e94000000b003291f6ac4b2sm3159217ook.28.2022.04.24.06.47.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Apr 2022 06:47:55 -0700 (PDT)
Received: (nullmailer pid 1284018 invoked by uid 1000);
        Sun, 24 Apr 2022 13:47:53 -0000
From:   Rob Herring <robh@kernel.org>
To:     David Heidelberg <david@ixit.cz>
Cc:     Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        devicetree@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20220424101637.20721-1-david@ixit.cz>
References: <20220424101637.20721-1-david@ixit.cz>
Subject: Re: [PATCH] dt-bindings: soc: qcom: convert GLINK binding to yaml
Date:   Sun, 24 Apr 2022 08:47:53 -0500
Message-Id: <1650808073.421000.1284017.nullmailer@robh.at.kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Apr 2022 12:16:37 +0200, David Heidelberg wrote:
> Convert Qualcomm GLINK binding to the yaml format.
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
> v1:
>  - remove quotes around qcom,intent
>  - use additionalProperties
> 
>  .../bindings/soc/qcom/qcom,glink.txt          |  94 ----------------
>  .../bindings/soc/qcom/qcom,glink.yaml         | 103 ++++++++++++++++++
>  2 files changed, 103 insertions(+), 94 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,glink.txt
>  create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,glink.yaml
> 

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/patch/


rpm-glink: glink-channel: Additional properties are not allowed ('compatible', 'pms405-regulators', 'power-controller', 'clock-controller' were unexpected)
	arch/arm64/boot/dts/qcom/qcs404-evb-4000.dtb

rpm-glink: glink-channel: Additional properties are not allowed ('compatible', 'regulators' were unexpected)
	arch/arm64/boot/dts/qcom/ipq6018-cp01-c1.dtb

rpm-glink: glink-channel: Additional properties are not allowed ('pms405-regulators', 'clock-controller', 'power-controller', 'compatible' were unexpected)
	arch/arm64/boot/dts/qcom/qcs404-evb-1000.dtb

rpm-glink: 'qcom,local-pid' is a required property
	arch/arm64/boot/dts/qcom/apq8096-db820c.dtb
	arch/arm64/boot/dts/qcom/apq8096-ifc6640.dtb
	arch/arm64/boot/dts/qcom/ipq6018-cp01-c1.dtb
	arch/arm64/boot/dts/qcom/msm8996-mtp.dtb
	arch/arm64/boot/dts/qcom/msm8996-pmi8996-sony-xperia-tone-dora.dtb
	arch/arm64/boot/dts/qcom/msm8996-pmi8996-sony-xperia-tone-kagura.dtb
	arch/arm64/boot/dts/qcom/msm8996-pmi8996-sony-xperia-tone-keyaki.dtb
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-dora.dtb
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-kagura.dtb
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-keyaki.dtb
	arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dtb
	arch/arm64/boot/dts/qcom/msm8996-xiaomi-scorpio.dtb
	arch/arm64/boot/dts/qcom/msm8998-asus-novago-tp370ql.dtb
	arch/arm64/boot/dts/qcom/msm8998-fxtec-pro1.dtb
	arch/arm64/boot/dts/qcom/msm8998-hp-envy-x2.dtb
	arch/arm64/boot/dts/qcom/msm8998-lenovo-miix-630.dtb
	arch/arm64/boot/dts/qcom/msm8998-mtp.dtb
	arch/arm64/boot/dts/qcom/msm8998-oneplus-cheeseburger.dtb
	arch/arm64/boot/dts/qcom/msm8998-oneplus-dumpling.dtb
	arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino-lilac.dtb
	arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino-maple.dtb
	arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino-poplar.dtb
	arch/arm64/boot/dts/qcom/qcs404-evb-1000.dtb
	arch/arm64/boot/dts/qcom/qcs404-evb-4000.dtb
	arch/arm64/boot/dts/qcom/sdm630-sony-xperia-ganges-kirin.dtb
	arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile-discovery.dtb
	arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile-pioneer.dtb
	arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile-voyager.dtb
	arch/arm64/boot/dts/qcom/sdm636-sony-xperia-ganges-mermaid.dtb
	arch/arm64/boot/dts/qcom/sdm660-xiaomi-lavender.dtb
	arch/arm64/boot/dts/qcom/sm6125-sony-xperia-seine-pdx201.dtb

rpm-glink: 'qcom,remote-pid' is a required property
	arch/arm64/boot/dts/qcom/apq8096-db820c.dtb
	arch/arm64/boot/dts/qcom/apq8096-ifc6640.dtb
	arch/arm64/boot/dts/qcom/ipq6018-cp01-c1.dtb
	arch/arm64/boot/dts/qcom/msm8996-mtp.dtb
	arch/arm64/boot/dts/qcom/msm8996-pmi8996-sony-xperia-tone-dora.dtb
	arch/arm64/boot/dts/qcom/msm8996-pmi8996-sony-xperia-tone-kagura.dtb
	arch/arm64/boot/dts/qcom/msm8996-pmi8996-sony-xperia-tone-keyaki.dtb
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-dora.dtb
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-kagura.dtb
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-keyaki.dtb
	arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dtb
	arch/arm64/boot/dts/qcom/msm8996-xiaomi-scorpio.dtb
	arch/arm64/boot/dts/qcom/msm8998-asus-novago-tp370ql.dtb
	arch/arm64/boot/dts/qcom/msm8998-fxtec-pro1.dtb
	arch/arm64/boot/dts/qcom/msm8998-hp-envy-x2.dtb
	arch/arm64/boot/dts/qcom/msm8998-lenovo-miix-630.dtb
	arch/arm64/boot/dts/qcom/msm8998-mtp.dtb
	arch/arm64/boot/dts/qcom/msm8998-oneplus-cheeseburger.dtb
	arch/arm64/boot/dts/qcom/msm8998-oneplus-dumpling.dtb
	arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino-lilac.dtb
	arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino-maple.dtb
	arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino-poplar.dtb
	arch/arm64/boot/dts/qcom/qcs404-evb-1000.dtb
	arch/arm64/boot/dts/qcom/qcs404-evb-4000.dtb
	arch/arm64/boot/dts/qcom/sdm630-sony-xperia-ganges-kirin.dtb
	arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile-discovery.dtb
	arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile-pioneer.dtb
	arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile-voyager.dtb
	arch/arm64/boot/dts/qcom/sdm636-sony-xperia-ganges-mermaid.dtb
	arch/arm64/boot/dts/qcom/sdm660-xiaomi-lavender.dtb
	arch/arm64/boot/dts/qcom/sm6125-sony-xperia-seine-pdx201.dtb

rpm-glink: 'qcom,smem' is a required property
	arch/arm64/boot/dts/qcom/apq8096-db820c.dtb
	arch/arm64/boot/dts/qcom/apq8096-ifc6640.dtb
	arch/arm64/boot/dts/qcom/ipq6018-cp01-c1.dtb
	arch/arm64/boot/dts/qcom/msm8996-mtp.dtb
	arch/arm64/boot/dts/qcom/msm8996-pmi8996-sony-xperia-tone-dora.dtb
	arch/arm64/boot/dts/qcom/msm8996-pmi8996-sony-xperia-tone-kagura.dtb
	arch/arm64/boot/dts/qcom/msm8996-pmi8996-sony-xperia-tone-keyaki.dtb
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-dora.dtb
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-kagura.dtb
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-keyaki.dtb
	arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dtb
	arch/arm64/boot/dts/qcom/msm8996-xiaomi-scorpio.dtb
	arch/arm64/boot/dts/qcom/msm8998-asus-novago-tp370ql.dtb
	arch/arm64/boot/dts/qcom/msm8998-fxtec-pro1.dtb
	arch/arm64/boot/dts/qcom/msm8998-hp-envy-x2.dtb
	arch/arm64/boot/dts/qcom/msm8998-lenovo-miix-630.dtb
	arch/arm64/boot/dts/qcom/msm8998-mtp.dtb
	arch/arm64/boot/dts/qcom/msm8998-oneplus-cheeseburger.dtb
	arch/arm64/boot/dts/qcom/msm8998-oneplus-dumpling.dtb
	arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino-lilac.dtb
	arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino-maple.dtb
	arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino-poplar.dtb
	arch/arm64/boot/dts/qcom/qcs404-evb-1000.dtb
	arch/arm64/boot/dts/qcom/qcs404-evb-4000.dtb
	arch/arm64/boot/dts/qcom/sdm630-sony-xperia-ganges-kirin.dtb
	arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile-discovery.dtb
	arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile-pioneer.dtb
	arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile-voyager.dtb
	arch/arm64/boot/dts/qcom/sdm636-sony-xperia-ganges-mermaid.dtb
	arch/arm64/boot/dts/qcom/sdm660-xiaomi-lavender.dtb
	arch/arm64/boot/dts/qcom/sm6125-sony-xperia-seine-pdx201.dtb

rpm-glink: rpm-requests: Additional properties are not allowed ('clock-controller', 'compatible', 'pmi8998-regulators', 'pm8998-regulators', 'power-controller' were unexpected)
	arch/arm64/boot/dts/qcom/msm8998-fxtec-pro1.dtb

rpm-glink: rpm-requests: Additional properties are not allowed ('clock-controller', 'compatible', 'power-controller' were unexpected)
	arch/arm64/boot/dts/qcom/sm6125-sony-xperia-seine-pdx201.dtb

rpm-glink: rpm-requests: Additional properties are not allowed ('clock-controller', 'pm660l-regulators', 'pm660-regulators', 'compatible', 'power-controller' were unexpected)
	arch/arm64/boot/dts/qcom/sdm660-xiaomi-lavender.dtb

rpm-glink: rpm-requests: Additional properties are not allowed ('clock-controller', 'power-controller', 'pmi8998-regulators', 'pm8998-regulators', 'compatible' were unexpected)
	arch/arm64/boot/dts/qcom/msm8998-oneplus-dumpling.dtb
	arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino-maple.dtb

rpm-glink: rpm-requests: Additional properties are not allowed ('compatible', 'clock-controller', 'pm8998-regulators', 'power-controller', 'pmi8998-regulators' were unexpected)
	arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino-poplar.dtb

rpm-glink: rpm-requests: Additional properties are not allowed ('compatible', 'clock-controller', 'pmi8998-regulators', 'power-controller', 'pm8998-regulators' were unexpected)
	arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino-lilac.dtb

rpm-glink: rpm-requests: Additional properties are not allowed ('compatible', 'clock-controller', 'power-controller', 'pm660l-regulators', 'pm660-regulators' were unexpected)
	arch/arm64/boot/dts/qcom/sdm630-sony-xperia-ganges-kirin.dtb

rpm-glink: rpm-requests: Additional properties are not allowed ('compatible', 'pm660-regulators', 'clock-controller', 'pm660l-regulators', 'power-controller' were unexpected)
	arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile-discovery.dtb

rpm-glink: rpm-requests: Additional properties are not allowed ('compatible', 'pm660-regulators', 'pm660l-regulators', 'power-controller', 'clock-controller' were unexpected)
	arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile-voyager.dtb

rpm-glink: rpm-requests: Additional properties are not allowed ('compatible', 'power-controller', 'qcom,rpmcc', 'pm8994-regulators' were unexpected)
	arch/arm64/boot/dts/qcom/msm8996-pmi8996-sony-xperia-tone-dora.dtb

rpm-glink: rpm-requests: Additional properties are not allowed ('compatible', 'power-controller', 'qcom,rpmcc' were unexpected)
	arch/arm64/boot/dts/qcom/msm8996-mtp.dtb

rpm-glink: rpm-requests: Additional properties are not allowed ('compatible', 'qcom,rpmcc', 'pm8994-regulators', 'power-controller' were unexpected)
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-kagura.dtb

rpm-glink: rpm-requests: Additional properties are not allowed ('compatible', 'qcom,rpmcc', 'power-controller', 'pm8994-regulators' were unexpected)
	arch/arm64/boot/dts/qcom/apq8096-ifc6640.dtb

rpm-glink: rpm-requests: Additional properties are not allowed ('pm660-regulators', 'pm660l-regulators', 'power-controller', 'compatible', 'clock-controller' were unexpected)
	arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile-pioneer.dtb

rpm-glink: rpm-requests: Additional properties are not allowed ('pm8994-regulators', 'compatible', 'qcom,rpmcc', 'power-controller' were unexpected)
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-dora.dtb

rpm-glink: rpm-requests: Additional properties are not allowed ('pm8994-regulators', 'qcom,rpmcc', 'compatible', 'pmi8994-regulators', 'power-controller' were unexpected)
	arch/arm64/boot/dts/qcom/apq8096-db820c.dtb

rpm-glink: rpm-requests: Additional properties are not allowed ('pm8998-regulators', 'compatible', 'clock-controller', 'power-controller' were unexpected)
	arch/arm64/boot/dts/qcom/msm8998-lenovo-miix-630.dtb

rpm-glink: rpm-requests: Additional properties are not allowed ('pmi8994-regulators', 'compatible', 'pm8994-regulators', 'power-controller', 'qcom,rpmcc' were unexpected)
	arch/arm64/boot/dts/qcom/msm8996-xiaomi-scorpio.dtb

rpm-glink: rpm-requests: Additional properties are not allowed ('pmi8994-regulators', 'compatible', 'power-controller', 'qcom,rpmcc', 'pm8994-regulators' were unexpected)
	arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dtb

rpm-glink: rpm-requests: Additional properties are not allowed ('power-controller', 'compatible', 'clock-controller', 'pm660l-regulators', 'pm660-regulators' were unexpected)
	arch/arm64/boot/dts/qcom/sdm636-sony-xperia-ganges-mermaid.dtb

rpm-glink: rpm-requests: Additional properties are not allowed ('power-controller', 'compatible', 'clock-controller', 'pm8998-regulators', 'pmi8998-regulators' were unexpected)
	arch/arm64/boot/dts/qcom/msm8998-mtp.dtb

rpm-glink: rpm-requests: Additional properties are not allowed ('power-controller', 'compatible', 'pm8994-regulators', 'qcom,rpmcc' were unexpected)
	arch/arm64/boot/dts/qcom/msm8996-pmi8996-sony-xperia-tone-kagura.dtb
	arch/arm64/boot/dts/qcom/msm8996-pmi8996-sony-xperia-tone-keyaki.dtb

rpm-glink: rpm-requests: Additional properties are not allowed ('power-controller', 'pm8998-regulators', 'clock-controller', 'compatible' were unexpected)
	arch/arm64/boot/dts/qcom/msm8998-asus-novago-tp370ql.dtb

rpm-glink: rpm-requests: Additional properties are not allowed ('power-controller', 'pm8998-regulators', 'compatible', 'clock-controller' were unexpected)
	arch/arm64/boot/dts/qcom/msm8998-hp-envy-x2.dtb

rpm-glink: rpm-requests: Additional properties are not allowed ('power-controller', 'pm8998-regulators', 'pmi8998-regulators', 'compatible', 'clock-controller' were unexpected)
	arch/arm64/boot/dts/qcom/msm8998-oneplus-cheeseburger.dtb

rpm-glink: rpm-requests: Additional properties are not allowed ('qcom,rpmcc', 'pm8994-regulators', 'power-controller', 'compatible' were unexpected)
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-keyaki.dtb

