Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 424D4510BFF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 00:23:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355798AbiDZW02 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 18:26:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353420AbiDZW00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 18:26:26 -0400
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8EFA20180;
        Tue, 26 Apr 2022 15:23:16 -0700 (PDT)
Received: by mail-oi1-f179.google.com with SMTP id b188so136826oia.13;
        Tue, 26 Apr 2022 15:23:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5NBIzw780L3vUqEM4pQFrZWcHVkKtoPbWVyenZ2nQbk=;
        b=TQlVI8BPADBw+yw5LoGXk0bK87atg/N+qZmOYKtv/i55JttnPM4PFAvpbMwUMddELU
         eHSHyjXgUGmda3qqrtFYLuQPBJic3p6+p9XkoMjvhNOY9WPb/+3inP47LHZVa1++SBUl
         wLbaOJ/C8ycflnsH3B9XThA2N1CcG7t/z2DdQDgtXFk03CyFEOZ8+aA/k1qyBl4Hyp9B
         Q0CACDE43XxJbqvvMUHH0v/eaopc3y3sZPEE/3CkJqP5VbAlBfch5MxdbJgOAHnMPwP9
         eiLBqmKeUqy43aemnCXGKKzNaEXnZr+OQJf8wzrIf8w7r75m79YNjNIKGsGjuXb2njdu
         OGlA==
X-Gm-Message-State: AOAM530cnrMlefcgIzB2stvNsIqFsN02EKxzcXuL4phBLdWFk63vT3MP
        q+/GMRfvVlJLhVnCqB9E0g==
X-Google-Smtp-Source: ABdhPJy6l3JVh3JQGu3dTQPUhXiqD9wKPw9assowMxB1M0xhu00z0mTWayqrcUCVtpfs4SzhYXvzlQ==
X-Received: by 2002:a05:6808:14d6:b0:322:cbe9:8d31 with SMTP id f22-20020a05680814d600b00322cbe98d31mr11855618oiw.274.1651011796192;
        Tue, 26 Apr 2022 15:23:16 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id g16-20020a4a9250000000b0033a7783dda8sm6179754ooh.48.2022.04.26.15.23.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 15:23:15 -0700 (PDT)
Received: (nullmailer pid 2638642 invoked by uid 1000);
        Tue, 26 Apr 2022 22:23:15 -0000
Date:   Tue, 26 Apr 2022 17:23:15 -0500
From:   Rob Herring <robh@kernel.org>
To:     David Heidelberg <david@ixit.cz>
Cc:     Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        devicetree@vger.kernel.org, Andy Gross <agross@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: soc: qcom: convert GLINK binding to yaml
Message-ID: <Ymhw0wI0bq8Q80fB@robh.at.kernel.org>
References: <20220424101637.20721-1-david@ixit.cz>
 <1650808073.421000.1284017.nullmailer@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1650808073.421000.1284017.nullmailer@robh.at.kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 24, 2022 at 08:47:53AM -0500, Rob Herring wrote:
> On Sun, 24 Apr 2022 12:16:37 +0200, David Heidelberg wrote:
> > Convert Qualcomm GLINK binding to the yaml format.
> > 
> > Signed-off-by: David Heidelberg <david@ixit.cz>
> > ---
> > v1:
> >  - remove quotes around qcom,intent
> >  - use additionalProperties
> > 
> >  .../bindings/soc/qcom/qcom,glink.txt          |  94 ----------------
> >  .../bindings/soc/qcom/qcom,glink.yaml         | 103 ++++++++++++++++++
> >  2 files changed, 103 insertions(+), 94 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,glink.txt
> >  create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,glink.yaml
> > 
> 
> Running 'make dtbs_check' with the schema in this patch gives the
> following warnings. Consider if they are expected or the schema is
> incorrect. These may not be new warnings.
> 
> Note that it is not yet a requirement to have 0 warnings for dtbs_check.
> This will change in the future.
> 
> Full log is available here: https://patchwork.ozlabs.org/patch/
> 

Seems like a lot of warnings. That's fine if you deem they are 
all/mostly valid and need to be fixed.

> 
> rpm-glink: glink-channel: Additional properties are not allowed ('compatible', 'pms405-regulators', 'power-controller', 'clock-controller' were unexpected)
> 	arch/arm64/boot/dts/qcom/qcs404-evb-4000.dtb
> 
> rpm-glink: glink-channel: Additional properties are not allowed ('compatible', 'regulators' were unexpected)
> 	arch/arm64/boot/dts/qcom/ipq6018-cp01-c1.dtb
> 
> rpm-glink: glink-channel: Additional properties are not allowed ('pms405-regulators', 'clock-controller', 'power-controller', 'compatible' were unexpected)
> 	arch/arm64/boot/dts/qcom/qcs404-evb-1000.dtb
> 
> rpm-glink: 'qcom,local-pid' is a required property
> 	arch/arm64/boot/dts/qcom/apq8096-db820c.dtb
> 	arch/arm64/boot/dts/qcom/apq8096-ifc6640.dtb
> 	arch/arm64/boot/dts/qcom/ipq6018-cp01-c1.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-mtp.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-pmi8996-sony-xperia-tone-dora.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-pmi8996-sony-xperia-tone-kagura.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-pmi8996-sony-xperia-tone-keyaki.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-dora.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-kagura.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-keyaki.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-xiaomi-scorpio.dtb
> 	arch/arm64/boot/dts/qcom/msm8998-asus-novago-tp370ql.dtb
> 	arch/arm64/boot/dts/qcom/msm8998-fxtec-pro1.dtb
> 	arch/arm64/boot/dts/qcom/msm8998-hp-envy-x2.dtb
> 	arch/arm64/boot/dts/qcom/msm8998-lenovo-miix-630.dtb
> 	arch/arm64/boot/dts/qcom/msm8998-mtp.dtb
> 	arch/arm64/boot/dts/qcom/msm8998-oneplus-cheeseburger.dtb
> 	arch/arm64/boot/dts/qcom/msm8998-oneplus-dumpling.dtb
> 	arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino-lilac.dtb
> 	arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino-maple.dtb
> 	arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino-poplar.dtb
> 	arch/arm64/boot/dts/qcom/qcs404-evb-1000.dtb
> 	arch/arm64/boot/dts/qcom/qcs404-evb-4000.dtb
> 	arch/arm64/boot/dts/qcom/sdm630-sony-xperia-ganges-kirin.dtb
> 	arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile-discovery.dtb
> 	arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile-pioneer.dtb
> 	arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile-voyager.dtb
> 	arch/arm64/boot/dts/qcom/sdm636-sony-xperia-ganges-mermaid.dtb
> 	arch/arm64/boot/dts/qcom/sdm660-xiaomi-lavender.dtb
> 	arch/arm64/boot/dts/qcom/sm6125-sony-xperia-seine-pdx201.dtb
> 
> rpm-glink: 'qcom,remote-pid' is a required property
> 	arch/arm64/boot/dts/qcom/apq8096-db820c.dtb
> 	arch/arm64/boot/dts/qcom/apq8096-ifc6640.dtb
> 	arch/arm64/boot/dts/qcom/ipq6018-cp01-c1.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-mtp.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-pmi8996-sony-xperia-tone-dora.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-pmi8996-sony-xperia-tone-kagura.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-pmi8996-sony-xperia-tone-keyaki.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-dora.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-kagura.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-keyaki.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-xiaomi-scorpio.dtb
> 	arch/arm64/boot/dts/qcom/msm8998-asus-novago-tp370ql.dtb
> 	arch/arm64/boot/dts/qcom/msm8998-fxtec-pro1.dtb
> 	arch/arm64/boot/dts/qcom/msm8998-hp-envy-x2.dtb
> 	arch/arm64/boot/dts/qcom/msm8998-lenovo-miix-630.dtb
> 	arch/arm64/boot/dts/qcom/msm8998-mtp.dtb
> 	arch/arm64/boot/dts/qcom/msm8998-oneplus-cheeseburger.dtb
> 	arch/arm64/boot/dts/qcom/msm8998-oneplus-dumpling.dtb
> 	arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino-lilac.dtb
> 	arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino-maple.dtb
> 	arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino-poplar.dtb
> 	arch/arm64/boot/dts/qcom/qcs404-evb-1000.dtb
> 	arch/arm64/boot/dts/qcom/qcs404-evb-4000.dtb
> 	arch/arm64/boot/dts/qcom/sdm630-sony-xperia-ganges-kirin.dtb
> 	arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile-discovery.dtb
> 	arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile-pioneer.dtb
> 	arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile-voyager.dtb
> 	arch/arm64/boot/dts/qcom/sdm636-sony-xperia-ganges-mermaid.dtb
> 	arch/arm64/boot/dts/qcom/sdm660-xiaomi-lavender.dtb
> 	arch/arm64/boot/dts/qcom/sm6125-sony-xperia-seine-pdx201.dtb
> 
> rpm-glink: 'qcom,smem' is a required property
> 	arch/arm64/boot/dts/qcom/apq8096-db820c.dtb
> 	arch/arm64/boot/dts/qcom/apq8096-ifc6640.dtb
> 	arch/arm64/boot/dts/qcom/ipq6018-cp01-c1.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-mtp.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-pmi8996-sony-xperia-tone-dora.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-pmi8996-sony-xperia-tone-kagura.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-pmi8996-sony-xperia-tone-keyaki.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-dora.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-kagura.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-keyaki.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-xiaomi-scorpio.dtb
> 	arch/arm64/boot/dts/qcom/msm8998-asus-novago-tp370ql.dtb
> 	arch/arm64/boot/dts/qcom/msm8998-fxtec-pro1.dtb
> 	arch/arm64/boot/dts/qcom/msm8998-hp-envy-x2.dtb
> 	arch/arm64/boot/dts/qcom/msm8998-lenovo-miix-630.dtb
> 	arch/arm64/boot/dts/qcom/msm8998-mtp.dtb
> 	arch/arm64/boot/dts/qcom/msm8998-oneplus-cheeseburger.dtb
> 	arch/arm64/boot/dts/qcom/msm8998-oneplus-dumpling.dtb
> 	arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino-lilac.dtb
> 	arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino-maple.dtb
> 	arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino-poplar.dtb
> 	arch/arm64/boot/dts/qcom/qcs404-evb-1000.dtb
> 	arch/arm64/boot/dts/qcom/qcs404-evb-4000.dtb
> 	arch/arm64/boot/dts/qcom/sdm630-sony-xperia-ganges-kirin.dtb
> 	arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile-discovery.dtb
> 	arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile-pioneer.dtb
> 	arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile-voyager.dtb
> 	arch/arm64/boot/dts/qcom/sdm636-sony-xperia-ganges-mermaid.dtb
> 	arch/arm64/boot/dts/qcom/sdm660-xiaomi-lavender.dtb
> 	arch/arm64/boot/dts/qcom/sm6125-sony-xperia-seine-pdx201.dtb
> 
> rpm-glink: rpm-requests: Additional properties are not allowed ('clock-controller', 'compatible', 'pmi8998-regulators', 'pm8998-regulators', 'power-controller' were unexpected)
> 	arch/arm64/boot/dts/qcom/msm8998-fxtec-pro1.dtb
> 
> rpm-glink: rpm-requests: Additional properties are not allowed ('clock-controller', 'compatible', 'power-controller' were unexpected)
> 	arch/arm64/boot/dts/qcom/sm6125-sony-xperia-seine-pdx201.dtb
> 
> rpm-glink: rpm-requests: Additional properties are not allowed ('clock-controller', 'pm660l-regulators', 'pm660-regulators', 'compatible', 'power-controller' were unexpected)
> 	arch/arm64/boot/dts/qcom/sdm660-xiaomi-lavender.dtb
> 
> rpm-glink: rpm-requests: Additional properties are not allowed ('clock-controller', 'power-controller', 'pmi8998-regulators', 'pm8998-regulators', 'compatible' were unexpected)
> 	arch/arm64/boot/dts/qcom/msm8998-oneplus-dumpling.dtb
> 	arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino-maple.dtb
> 
> rpm-glink: rpm-requests: Additional properties are not allowed ('compatible', 'clock-controller', 'pm8998-regulators', 'power-controller', 'pmi8998-regulators' were unexpected)
> 	arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino-poplar.dtb
> 
> rpm-glink: rpm-requests: Additional properties are not allowed ('compatible', 'clock-controller', 'pmi8998-regulators', 'power-controller', 'pm8998-regulators' were unexpected)
> 	arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino-lilac.dtb
> 
> rpm-glink: rpm-requests: Additional properties are not allowed ('compatible', 'clock-controller', 'power-controller', 'pm660l-regulators', 'pm660-regulators' were unexpected)
> 	arch/arm64/boot/dts/qcom/sdm630-sony-xperia-ganges-kirin.dtb
> 
> rpm-glink: rpm-requests: Additional properties are not allowed ('compatible', 'pm660-regulators', 'clock-controller', 'pm660l-regulators', 'power-controller' were unexpected)
> 	arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile-discovery.dtb
> 
> rpm-glink: rpm-requests: Additional properties are not allowed ('compatible', 'pm660-regulators', 'pm660l-regulators', 'power-controller', 'clock-controller' were unexpected)
> 	arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile-voyager.dtb
> 
> rpm-glink: rpm-requests: Additional properties are not allowed ('compatible', 'power-controller', 'qcom,rpmcc', 'pm8994-regulators' were unexpected)
> 	arch/arm64/boot/dts/qcom/msm8996-pmi8996-sony-xperia-tone-dora.dtb
> 
> rpm-glink: rpm-requests: Additional properties are not allowed ('compatible', 'power-controller', 'qcom,rpmcc' were unexpected)
> 	arch/arm64/boot/dts/qcom/msm8996-mtp.dtb
> 
> rpm-glink: rpm-requests: Additional properties are not allowed ('compatible', 'qcom,rpmcc', 'pm8994-regulators', 'power-controller' were unexpected)
> 	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-kagura.dtb
> 
> rpm-glink: rpm-requests: Additional properties are not allowed ('compatible', 'qcom,rpmcc', 'power-controller', 'pm8994-regulators' were unexpected)
> 	arch/arm64/boot/dts/qcom/apq8096-ifc6640.dtb
> 
> rpm-glink: rpm-requests: Additional properties are not allowed ('pm660-regulators', 'pm660l-regulators', 'power-controller', 'compatible', 'clock-controller' were unexpected)
> 	arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile-pioneer.dtb
> 
> rpm-glink: rpm-requests: Additional properties are not allowed ('pm8994-regulators', 'compatible', 'qcom,rpmcc', 'power-controller' were unexpected)
> 	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-dora.dtb
> 
> rpm-glink: rpm-requests: Additional properties are not allowed ('pm8994-regulators', 'qcom,rpmcc', 'compatible', 'pmi8994-regulators', 'power-controller' were unexpected)
> 	arch/arm64/boot/dts/qcom/apq8096-db820c.dtb
> 
> rpm-glink: rpm-requests: Additional properties are not allowed ('pm8998-regulators', 'compatible', 'clock-controller', 'power-controller' were unexpected)
> 	arch/arm64/boot/dts/qcom/msm8998-lenovo-miix-630.dtb
> 
> rpm-glink: rpm-requests: Additional properties are not allowed ('pmi8994-regulators', 'compatible', 'pm8994-regulators', 'power-controller', 'qcom,rpmcc' were unexpected)
> 	arch/arm64/boot/dts/qcom/msm8996-xiaomi-scorpio.dtb
> 
> rpm-glink: rpm-requests: Additional properties are not allowed ('pmi8994-regulators', 'compatible', 'power-controller', 'qcom,rpmcc', 'pm8994-regulators' were unexpected)
> 	arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dtb
> 
> rpm-glink: rpm-requests: Additional properties are not allowed ('power-controller', 'compatible', 'clock-controller', 'pm660l-regulators', 'pm660-regulators' were unexpected)
> 	arch/arm64/boot/dts/qcom/sdm636-sony-xperia-ganges-mermaid.dtb
> 
> rpm-glink: rpm-requests: Additional properties are not allowed ('power-controller', 'compatible', 'clock-controller', 'pm8998-regulators', 'pmi8998-regulators' were unexpected)
> 	arch/arm64/boot/dts/qcom/msm8998-mtp.dtb
> 
> rpm-glink: rpm-requests: Additional properties are not allowed ('power-controller', 'compatible', 'pm8994-regulators', 'qcom,rpmcc' were unexpected)
> 	arch/arm64/boot/dts/qcom/msm8996-pmi8996-sony-xperia-tone-kagura.dtb
> 	arch/arm64/boot/dts/qcom/msm8996-pmi8996-sony-xperia-tone-keyaki.dtb
> 
> rpm-glink: rpm-requests: Additional properties are not allowed ('power-controller', 'pm8998-regulators', 'clock-controller', 'compatible' were unexpected)
> 	arch/arm64/boot/dts/qcom/msm8998-asus-novago-tp370ql.dtb
> 
> rpm-glink: rpm-requests: Additional properties are not allowed ('power-controller', 'pm8998-regulators', 'compatible', 'clock-controller' were unexpected)
> 	arch/arm64/boot/dts/qcom/msm8998-hp-envy-x2.dtb
> 
> rpm-glink: rpm-requests: Additional properties are not allowed ('power-controller', 'pm8998-regulators', 'pmi8998-regulators', 'compatible', 'clock-controller' were unexpected)
> 	arch/arm64/boot/dts/qcom/msm8998-oneplus-cheeseburger.dtb
> 
> rpm-glink: rpm-requests: Additional properties are not allowed ('qcom,rpmcc', 'pm8994-regulators', 'power-controller', 'compatible' were unexpected)
> 	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-keyaki.dtb
> 
