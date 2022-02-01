Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27C6A4A6035
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 16:33:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240443AbiBAPdc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 10:33:32 -0500
Received: from mail-oi1-f179.google.com ([209.85.167.179]:33329 "EHLO
        mail-oi1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233563AbiBAPdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 10:33:31 -0500
Received: by mail-oi1-f179.google.com with SMTP id x193so34119614oix.0;
        Tue, 01 Feb 2022 07:33:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=RBv916bhbwda/mdy1J5NLjHIfprvqK6hoiVcvish1zk=;
        b=MU4Z3S0iC9I0yqiiaNG1HePIXaWV/qdcyXCBhxvwARiOr/0Uf2Un1XFkSEyakyDVfT
         Qkgll2iPcZ2YvGDKoQ+J9PbWBA2nXEr+NQSRV/GBVwBlJwjZTwQFsmtgZsSU5Iw8T11U
         IWVQWRi/mJm5M9Y8LK+AfGIFhBHhDw2+Tgf/tQ7TbueGXQj9qLR9hNF9MpV1N00YeWCg
         /7pDiyoVFFlxeEJCg3x9JtWRhSc2liPJn4h8jMZvfczl2t8suxV28ZsM7NR69zxZT6mM
         jk67Q1amEWptrdhIjMlaPyHZPma9P5E7HWE2+oV0biz1Uk0SYZlAA5fnikEoQMJpIwrC
         qGiA==
X-Gm-Message-State: AOAM533E4Jw0uVDTX9hoB7EYoG+nNsGzhXa9UcwQxd3nOYY5D2USVPZw
        p1uBW75NRDY4QZozB6rTkA==
X-Google-Smtp-Source: ABdhPJwfzApKaWn6A21tIZcepUtOjObbh0dmAtMm4DMCgnLKkXZRnK5u9lzeNghcLMZYGm/eHX6URw==
X-Received: by 2002:a05:6808:23c6:: with SMTP id bq6mr1588773oib.54.1643729610472;
        Tue, 01 Feb 2022 07:33:30 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id k10sm15791798oou.26.2022.02.01.07.33.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 07:33:29 -0800 (PST)
Received: (nullmailer pid 62692 invoked by uid 1000);
        Tue, 01 Feb 2022 15:33:28 -0000
From:   Rob Herring <robh@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        David Dai <daidavid1@codeaurora.org>,
        David Collins <quic_collinsd@quicinc.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
In-Reply-To: <20220131172450.2528065-2-vkoul@kernel.org>
References: <20220131172450.2528065-1-vkoul@kernel.org> <20220131172450.2528065-2-vkoul@kernel.org>
Subject: Re: [PATCH 1/3] dt-bindings: spmi: convert Qualcomm SPMI PMIC ARB to dtschema
Date:   Tue, 01 Feb 2022 09:33:28 -0600
Message-Id: <1643729608.810939.62691.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Jan 2022 22:54:48 +0530, Vinod Koul wrote:
> Convert Qualcomm SPMI PMIC  arb binding to dtschema format.
> 
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> ---
>  .../bindings/spmi/qcom,spmi-pmic-arb.txt      |  65 ----------
>  .../bindings/spmi/qcom,spmi-pmic-arb.yaml     | 114 ++++++++++++++++++
>  2 files changed, 114 insertions(+), 65 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb.txt
>  create mode 100644 Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb.yaml
> 

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/patch/1586902


qcom,spmi@400f000: $nodename:0: 'qcom,spmi@400f000' does not match '^spmi@.*'
	arch/arm64/boot/dts/qcom/apq8096-db820c.dt.yaml
	arch/arm64/boot/dts/qcom/apq8096-ifc6640.dt.yaml
	arch/arm64/boot/dts/qcom/msm8996-mtp.dt.yaml
	arch/arm64/boot/dts/qcom/msm8996-pmi8996-sony-xperia-tone-dora.dt.yaml
	arch/arm64/boot/dts/qcom/msm8996-pmi8996-sony-xperia-tone-kagura.dt.yaml
	arch/arm64/boot/dts/qcom/msm8996-pmi8996-sony-xperia-tone-keyaki.dt.yaml
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-dora.dt.yaml
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-kagura.dt.yaml
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-keyaki.dt.yaml
	arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dt.yaml
	arch/arm64/boot/dts/qcom/msm8996-xiaomi-scorpio.dt.yaml

qcom,spmi@400f000: reg-names:1: 'intr' was expected
	arch/arm64/boot/dts/qcom/apq8096-db820c.dt.yaml
	arch/arm64/boot/dts/qcom/apq8096-ifc6640.dt.yaml
	arch/arm64/boot/dts/qcom/msm8996-mtp.dt.yaml
	arch/arm64/boot/dts/qcom/msm8996-pmi8996-sony-xperia-tone-dora.dt.yaml
	arch/arm64/boot/dts/qcom/msm8996-pmi8996-sony-xperia-tone-kagura.dt.yaml
	arch/arm64/boot/dts/qcom/msm8996-pmi8996-sony-xperia-tone-keyaki.dt.yaml
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-dora.dt.yaml
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-kagura.dt.yaml
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-keyaki.dt.yaml
	arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dt.yaml
	arch/arm64/boot/dts/qcom/msm8996-xiaomi-scorpio.dt.yaml

qcom,spmi@400f000: reg-names:2: 'cnfg' was expected
	arch/arm64/boot/dts/qcom/apq8096-db820c.dt.yaml
	arch/arm64/boot/dts/qcom/apq8096-ifc6640.dt.yaml
	arch/arm64/boot/dts/qcom/msm8996-mtp.dt.yaml
	arch/arm64/boot/dts/qcom/msm8996-pmi8996-sony-xperia-tone-dora.dt.yaml
	arch/arm64/boot/dts/qcom/msm8996-pmi8996-sony-xperia-tone-kagura.dt.yaml
	arch/arm64/boot/dts/qcom/msm8996-pmi8996-sony-xperia-tone-keyaki.dt.yaml
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-dora.dt.yaml
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-kagura.dt.yaml
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-keyaki.dt.yaml
	arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dt.yaml
	arch/arm64/boot/dts/qcom/msm8996-xiaomi-scorpio.dt.yaml

qcom,spmi@400f000: reg-names:3: 'chnls' was expected
	arch/arm64/boot/dts/qcom/apq8096-db820c.dt.yaml
	arch/arm64/boot/dts/qcom/apq8096-ifc6640.dt.yaml
	arch/arm64/boot/dts/qcom/msm8996-mtp.dt.yaml
	arch/arm64/boot/dts/qcom/msm8996-pmi8996-sony-xperia-tone-dora.dt.yaml
	arch/arm64/boot/dts/qcom/msm8996-pmi8996-sony-xperia-tone-kagura.dt.yaml
	arch/arm64/boot/dts/qcom/msm8996-pmi8996-sony-xperia-tone-keyaki.dt.yaml
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-dora.dt.yaml
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-kagura.dt.yaml
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-keyaki.dt.yaml
	arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dt.yaml
	arch/arm64/boot/dts/qcom/msm8996-xiaomi-scorpio.dt.yaml

qcom,spmi@400f000: reg-names:4: 'obsrvr' was expected
	arch/arm64/boot/dts/qcom/apq8096-db820c.dt.yaml
	arch/arm64/boot/dts/qcom/apq8096-ifc6640.dt.yaml
	arch/arm64/boot/dts/qcom/msm8996-mtp.dt.yaml
	arch/arm64/boot/dts/qcom/msm8996-pmi8996-sony-xperia-tone-dora.dt.yaml
	arch/arm64/boot/dts/qcom/msm8996-pmi8996-sony-xperia-tone-kagura.dt.yaml
	arch/arm64/boot/dts/qcom/msm8996-pmi8996-sony-xperia-tone-keyaki.dt.yaml
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-dora.dt.yaml
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-kagura.dt.yaml
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-keyaki.dt.yaml
	arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dt.yaml
	arch/arm64/boot/dts/qcom/msm8996-xiaomi-scorpio.dt.yaml

qcom,spmi@400f000: Unevaluated properties are not allowed ('reg-names', '#address-cells', '#size-cells', 'interrupt-controller', '#interrupt-cells' were unexpected)
	arch/arm64/boot/dts/qcom/apq8096-db820c.dt.yaml
	arch/arm64/boot/dts/qcom/apq8096-ifc6640.dt.yaml
	arch/arm64/boot/dts/qcom/msm8996-mtp.dt.yaml
	arch/arm64/boot/dts/qcom/msm8996-pmi8996-sony-xperia-tone-dora.dt.yaml
	arch/arm64/boot/dts/qcom/msm8996-pmi8996-sony-xperia-tone-kagura.dt.yaml
	arch/arm64/boot/dts/qcom/msm8996-pmi8996-sony-xperia-tone-keyaki.dt.yaml
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-dora.dt.yaml
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-kagura.dt.yaml
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-keyaki.dt.yaml
	arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dt.yaml
	arch/arm64/boot/dts/qcom/msm8996-xiaomi-scorpio.dt.yaml

qcom,spmi@c440000: $nodename:0: 'qcom,spmi@c440000' does not match '^spmi@.*'
	arch/arm/boot/dts/qcom-sdx55-mtp.dt.yaml
	arch/arm/boot/dts/qcom-sdx55-t55.dt.yaml
	arch/arm/boot/dts/qcom-sdx55-telit-fn980-tlb.dt.yaml

qcom,spmi@c440000: reg-names:1: 'intr' was expected
	arch/arm/boot/dts/qcom-sdx55-mtp.dt.yaml
	arch/arm/boot/dts/qcom-sdx55-t55.dt.yaml
	arch/arm/boot/dts/qcom-sdx55-telit-fn980-tlb.dt.yaml

qcom,spmi@c440000: reg-names:2: 'cnfg' was expected
	arch/arm/boot/dts/qcom-sdx55-mtp.dt.yaml
	arch/arm/boot/dts/qcom-sdx55-t55.dt.yaml
	arch/arm/boot/dts/qcom-sdx55-telit-fn980-tlb.dt.yaml

qcom,spmi@c440000: reg-names:3: 'chnls' was expected
	arch/arm/boot/dts/qcom-sdx55-mtp.dt.yaml
	arch/arm/boot/dts/qcom-sdx55-t55.dt.yaml
	arch/arm/boot/dts/qcom-sdx55-telit-fn980-tlb.dt.yaml

qcom,spmi@c440000: reg-names:4: 'obsrvr' was expected
	arch/arm/boot/dts/qcom-sdx55-mtp.dt.yaml
	arch/arm/boot/dts/qcom-sdx55-t55.dt.yaml
	arch/arm/boot/dts/qcom-sdx55-telit-fn980-tlb.dt.yaml

qcom,spmi@c440000: Unevaluated properties are not allowed ('reg-names', '#address-cells', '#size-cells', 'interrupt-controller', '#interrupt-cells', 'cell-index' were unexpected)
	arch/arm/boot/dts/qcom-sdx55-mtp.dt.yaml
	arch/arm/boot/dts/qcom-sdx55-t55.dt.yaml
	arch/arm/boot/dts/qcom-sdx55-telit-fn980-tlb.dt.yaml

spmi@1c40000: reg-names:1: 'intr' was expected
	arch/arm64/boot/dts/qcom/sm6125-sony-xperia-seine-pdx201.dt.yaml

spmi@1c40000: reg-names:2: 'cnfg' was expected
	arch/arm64/boot/dts/qcom/sm6125-sony-xperia-seine-pdx201.dt.yaml

spmi@1c40000: reg-names:3: 'chnls' was expected
	arch/arm64/boot/dts/qcom/sm6125-sony-xperia-seine-pdx201.dt.yaml

spmi@1c40000: reg-names:4: 'obsrvr' was expected
	arch/arm64/boot/dts/qcom/sm6125-sony-xperia-seine-pdx201.dt.yaml

spmi@200f000: reg-names:1: 'intr' was expected
	arch/arm64/boot/dts/qcom/apq8016-sbc.dt.yaml
	arch/arm64/boot/dts/qcom/ipq8074-hk01.dt.yaml
	arch/arm64/boot/dts/qcom/ipq8074-hk10-c1.dt.yaml
	arch/arm64/boot/dts/qcom/ipq8074-hk10-c2.dt.yaml
	arch/arm64/boot/dts/qcom/msm8916-alcatel-idol347.dt.yaml
	arch/arm64/boot/dts/qcom/msm8916-asus-z00l.dt.yaml
	arch/arm64/boot/dts/qcom/msm8916-huawei-g7.dt.yaml
	arch/arm64/boot/dts/qcom/msm8916-longcheer-l8150.dt.yaml
	arch/arm64/boot/dts/qcom/msm8916-longcheer-l8910.dt.yaml
	arch/arm64/boot/dts/qcom/msm8916-mtp.dt.yaml
	arch/arm64/boot/dts/qcom/msm8916-samsung-a3u-eur.dt.yaml
	arch/arm64/boot/dts/qcom/msm8916-samsung-a5u-eur.dt.yaml
	arch/arm64/boot/dts/qcom/msm8916-samsung-j5.dt.yaml
	arch/arm64/boot/dts/qcom/msm8916-samsung-serranove.dt.yaml
	arch/arm64/boot/dts/qcom/msm8916-wingtech-wt88047.dt.yaml
	arch/arm64/boot/dts/qcom/qcs404-evb-1000.dt.yaml
	arch/arm64/boot/dts/qcom/qcs404-evb-4000.dt.yaml
	arch/arm/boot/dts/qcom-apq8016-sbc.dt.yaml
	arch/arm/boot/dts/qcom-msm8916-samsung-serranove.dt.yaml

spmi@200f000: reg-names:2: 'cnfg' was expected
	arch/arm64/boot/dts/qcom/apq8016-sbc.dt.yaml
	arch/arm64/boot/dts/qcom/ipq8074-hk01.dt.yaml
	arch/arm64/boot/dts/qcom/ipq8074-hk10-c1.dt.yaml
	arch/arm64/boot/dts/qcom/ipq8074-hk10-c2.dt.yaml
	arch/arm64/boot/dts/qcom/msm8916-alcatel-idol347.dt.yaml
	arch/arm64/boot/dts/qcom/msm8916-asus-z00l.dt.yaml
	arch/arm64/boot/dts/qcom/msm8916-huawei-g7.dt.yaml
	arch/arm64/boot/dts/qcom/msm8916-longcheer-l8150.dt.yaml
	arch/arm64/boot/dts/qcom/msm8916-longcheer-l8910.dt.yaml
	arch/arm64/boot/dts/qcom/msm8916-mtp.dt.yaml
	arch/arm64/boot/dts/qcom/msm8916-samsung-a3u-eur.dt.yaml
	arch/arm64/boot/dts/qcom/msm8916-samsung-a5u-eur.dt.yaml
	arch/arm64/boot/dts/qcom/msm8916-samsung-j5.dt.yaml
	arch/arm64/boot/dts/qcom/msm8916-samsung-serranove.dt.yaml
	arch/arm64/boot/dts/qcom/msm8916-wingtech-wt88047.dt.yaml
	arch/arm64/boot/dts/qcom/qcs404-evb-1000.dt.yaml
	arch/arm64/boot/dts/qcom/qcs404-evb-4000.dt.yaml
	arch/arm/boot/dts/qcom-apq8016-sbc.dt.yaml
	arch/arm/boot/dts/qcom-msm8916-samsung-serranove.dt.yaml

spmi@200f000: reg-names:3: 'chnls' was expected
	arch/arm64/boot/dts/qcom/apq8016-sbc.dt.yaml
	arch/arm64/boot/dts/qcom/ipq8074-hk01.dt.yaml
	arch/arm64/boot/dts/qcom/ipq8074-hk10-c1.dt.yaml
	arch/arm64/boot/dts/qcom/ipq8074-hk10-c2.dt.yaml
	arch/arm64/boot/dts/qcom/msm8916-alcatel-idol347.dt.yaml
	arch/arm64/boot/dts/qcom/msm8916-asus-z00l.dt.yaml
	arch/arm64/boot/dts/qcom/msm8916-huawei-g7.dt.yaml
	arch/arm64/boot/dts/qcom/msm8916-longcheer-l8150.dt.yaml
	arch/arm64/boot/dts/qcom/msm8916-longcheer-l8910.dt.yaml
	arch/arm64/boot/dts/qcom/msm8916-mtp.dt.yaml
	arch/arm64/boot/dts/qcom/msm8916-samsung-a3u-eur.dt.yaml
	arch/arm64/boot/dts/qcom/msm8916-samsung-a5u-eur.dt.yaml
	arch/arm64/boot/dts/qcom/msm8916-samsung-j5.dt.yaml
	arch/arm64/boot/dts/qcom/msm8916-samsung-serranove.dt.yaml
	arch/arm64/boot/dts/qcom/msm8916-wingtech-wt88047.dt.yaml
	arch/arm64/boot/dts/qcom/qcs404-evb-1000.dt.yaml
	arch/arm64/boot/dts/qcom/qcs404-evb-4000.dt.yaml
	arch/arm/boot/dts/qcom-apq8016-sbc.dt.yaml
	arch/arm/boot/dts/qcom-msm8916-samsung-serranove.dt.yaml

spmi@200f000: reg-names:4: 'obsrvr' was expected
	arch/arm64/boot/dts/qcom/apq8016-sbc.dt.yaml
	arch/arm64/boot/dts/qcom/ipq8074-hk01.dt.yaml
	arch/arm64/boot/dts/qcom/ipq8074-hk10-c1.dt.yaml
	arch/arm64/boot/dts/qcom/ipq8074-hk10-c2.dt.yaml
	arch/arm64/boot/dts/qcom/msm8916-alcatel-idol347.dt.yaml
	arch/arm64/boot/dts/qcom/msm8916-asus-z00l.dt.yaml
	arch/arm64/boot/dts/qcom/msm8916-huawei-g7.dt.yaml
	arch/arm64/boot/dts/qcom/msm8916-longcheer-l8150.dt.yaml
	arch/arm64/boot/dts/qcom/msm8916-longcheer-l8910.dt.yaml
	arch/arm64/boot/dts/qcom/msm8916-mtp.dt.yaml
	arch/arm64/boot/dts/qcom/msm8916-samsung-a3u-eur.dt.yaml
	arch/arm64/boot/dts/qcom/msm8916-samsung-a5u-eur.dt.yaml
	arch/arm64/boot/dts/qcom/msm8916-samsung-j5.dt.yaml
	arch/arm64/boot/dts/qcom/msm8916-samsung-serranove.dt.yaml
	arch/arm64/boot/dts/qcom/msm8916-wingtech-wt88047.dt.yaml
	arch/arm64/boot/dts/qcom/qcs404-evb-1000.dt.yaml
	arch/arm64/boot/dts/qcom/qcs404-evb-4000.dt.yaml
	arch/arm/boot/dts/qcom-apq8016-sbc.dt.yaml
	arch/arm/boot/dts/qcom-msm8916-samsung-serranove.dt.yaml

spmi@800f000: reg-names:1: 'intr' was expected
	arch/arm64/boot/dts/qcom/msm8998-asus-novago-tp370ql.dt.yaml
	arch/arm64/boot/dts/qcom/msm8998-fxtec-pro1.dt.yaml
	arch/arm64/boot/dts/qcom/msm8998-hp-envy-x2.dt.yaml
	arch/arm64/boot/dts/qcom/msm8998-lenovo-miix-630.dt.yaml
	arch/arm64/boot/dts/qcom/msm8998-mtp.dt.yaml
	arch/arm64/boot/dts/qcom/msm8998-oneplus-cheeseburger.dt.yaml
	arch/arm64/boot/dts/qcom/msm8998-oneplus-dumpling.dt.yaml
	arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino-lilac.dt.yaml
	arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino-maple.dt.yaml
	arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino-poplar.dt.yaml
	arch/arm64/boot/dts/qcom/sdm630-sony-xperia-ganges-kirin.dt.yaml
	arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile-discovery.dt.yaml
	arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile-pioneer.dt.yaml
	arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile-voyager.dt.yaml
	arch/arm64/boot/dts/qcom/sdm636-sony-xperia-ganges-mermaid.dt.yaml
	arch/arm64/boot/dts/qcom/sdm660-xiaomi-lavender.dt.yaml

spmi@800f000: reg-names:2: 'cnfg' was expected
	arch/arm64/boot/dts/qcom/msm8998-asus-novago-tp370ql.dt.yaml
	arch/arm64/boot/dts/qcom/msm8998-fxtec-pro1.dt.yaml
	arch/arm64/boot/dts/qcom/msm8998-hp-envy-x2.dt.yaml
	arch/arm64/boot/dts/qcom/msm8998-lenovo-miix-630.dt.yaml
	arch/arm64/boot/dts/qcom/msm8998-mtp.dt.yaml
	arch/arm64/boot/dts/qcom/msm8998-oneplus-cheeseburger.dt.yaml
	arch/arm64/boot/dts/qcom/msm8998-oneplus-dumpling.dt.yaml
	arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino-lilac.dt.yaml
	arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino-maple.dt.yaml
	arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino-poplar.dt.yaml
	arch/arm64/boot/dts/qcom/sdm630-sony-xperia-ganges-kirin.dt.yaml
	arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile-discovery.dt.yaml
	arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile-pioneer.dt.yaml
	arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile-voyager.dt.yaml
	arch/arm64/boot/dts/qcom/sdm636-sony-xperia-ganges-mermaid.dt.yaml
	arch/arm64/boot/dts/qcom/sdm660-xiaomi-lavender.dt.yaml

spmi@800f000: reg-names:3: 'chnls' was expected
	arch/arm64/boot/dts/qcom/msm8998-asus-novago-tp370ql.dt.yaml
	arch/arm64/boot/dts/qcom/msm8998-fxtec-pro1.dt.yaml
	arch/arm64/boot/dts/qcom/msm8998-hp-envy-x2.dt.yaml
	arch/arm64/boot/dts/qcom/msm8998-lenovo-miix-630.dt.yaml
	arch/arm64/boot/dts/qcom/msm8998-mtp.dt.yaml
	arch/arm64/boot/dts/qcom/msm8998-oneplus-cheeseburger.dt.yaml
	arch/arm64/boot/dts/qcom/msm8998-oneplus-dumpling.dt.yaml
	arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino-lilac.dt.yaml
	arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino-maple.dt.yaml
	arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino-poplar.dt.yaml
	arch/arm64/boot/dts/qcom/sdm630-sony-xperia-ganges-kirin.dt.yaml
	arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile-discovery.dt.yaml
	arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile-pioneer.dt.yaml
	arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile-voyager.dt.yaml
	arch/arm64/boot/dts/qcom/sdm636-sony-xperia-ganges-mermaid.dt.yaml
	arch/arm64/boot/dts/qcom/sdm660-xiaomi-lavender.dt.yaml

spmi@800f000: reg-names:4: 'obsrvr' was expected
	arch/arm64/boot/dts/qcom/msm8998-asus-novago-tp370ql.dt.yaml
	arch/arm64/boot/dts/qcom/msm8998-fxtec-pro1.dt.yaml
	arch/arm64/boot/dts/qcom/msm8998-hp-envy-x2.dt.yaml
	arch/arm64/boot/dts/qcom/msm8998-lenovo-miix-630.dt.yaml
	arch/arm64/boot/dts/qcom/msm8998-mtp.dt.yaml
	arch/arm64/boot/dts/qcom/msm8998-oneplus-cheeseburger.dt.yaml
	arch/arm64/boot/dts/qcom/msm8998-oneplus-dumpling.dt.yaml
	arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino-lilac.dt.yaml
	arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino-maple.dt.yaml
	arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino-poplar.dt.yaml
	arch/arm64/boot/dts/qcom/sdm630-sony-xperia-ganges-kirin.dt.yaml
	arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile-discovery.dt.yaml
	arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile-pioneer.dt.yaml
	arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile-voyager.dt.yaml
	arch/arm64/boot/dts/qcom/sdm636-sony-xperia-ganges-mermaid.dt.yaml
	arch/arm64/boot/dts/qcom/sdm660-xiaomi-lavender.dt.yaml

spmi@c440000: #address-cells:0:0: 2 was expected
	arch/arm64/boot/dts/qcom/sc7180-idp.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r1.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r1-lte.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r3.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r3-lte.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar-r2.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar-r3.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar-r4.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots-r4.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots-r5.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots-r9.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-r4.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-r9.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r0.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1-kb.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1-lte.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3-kb.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3-lte.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r9.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r9-kb.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r9-lte.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r1.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r1-lte.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r2.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r2-lte.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r3.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r3-lte.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-r1.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-r1-lte.dt.yaml
	arch/arm64/boot/dts/qcom/sc7280-crd.dt.yaml
	arch/arm64/boot/dts/qcom/sc7280-herobrine.dt.yaml
	arch/arm64/boot/dts/qcom/sc7280-idp2.dt.yaml
	arch/arm64/boot/dts/qcom/sc7280-idp.dt.yaml

spmi@c440000: reg-names:1: 'intr' was expected
	arch/arm64/boot/dts/qcom/qrb5165-rb5.dt.yaml
	arch/arm64/boot/dts/qcom/sa8155p-adp.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-idp.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r1.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r1-lte.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r3.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r3-lte.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar-r2.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar-r3.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar-r4.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots-r4.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots-r5.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots-r9.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-r4.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-r9.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r0.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1-kb.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1-lte.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3-kb.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3-lte.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r9.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r9-kb.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r9-lte.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r1.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r1-lte.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r2.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r2-lte.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r3.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r3-lte.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-r1.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-r1-lte.dt.yaml
	arch/arm64/boot/dts/qcom/sc7280-crd.dt.yaml
	arch/arm64/boot/dts/qcom/sc7280-herobrine.dt.yaml
	arch/arm64/boot/dts/qcom/sc7280-idp2.dt.yaml
	arch/arm64/boot/dts/qcom/sc7280-idp.dt.yaml
	arch/arm64/boot/dts/qcom/sdm845-cheza-r1.dt.yaml
	arch/arm64/boot/dts/qcom/sdm845-cheza-r2.dt.yaml
	arch/arm64/boot/dts/qcom/sdm845-cheza-r3.dt.yaml
	arch/arm64/boot/dts/qcom/sdm845-db845c.dt.yaml
	arch/arm64/boot/dts/qcom/sdm845-mtp.dt.yaml
	arch/arm64/boot/dts/qcom/sdm845-oneplus-enchilada.dt.yaml
	arch/arm64/boot/dts/qcom/sdm845-oneplus-fajita.dt.yaml
	arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama-akari.dt.yaml
	arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama-akatsuki.dt.yaml
	arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama-apollo.dt.yaml
	arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dt.yaml
	arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dt.yaml
	arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dt.yaml
	arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dt.yaml
	arch/arm64/boot/dts/qcom/sm8150-hdk.dt.yaml
	arch/arm64/boot/dts/qcom/sm8150-microsoft-surface-duo.dt.yaml
	arch/arm64/boot/dts/qcom/sm8150-mtp.dt.yaml
	arch/arm64/boot/dts/qcom/sm8150-sony-xperia-kumano-bahamut.dt.yaml
	arch/arm64/boot/dts/qcom/sm8150-sony-xperia-kumano-griffin.dt.yaml
	arch/arm64/boot/dts/qcom/sm8250-hdk.dt.yaml
	arch/arm64/boot/dts/qcom/sm8250-mtp.dt.yaml
	arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo-pdx203.dt.yaml
	arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo-pdx206.dt.yaml
	arch/arm64/boot/dts/qcom/sm8350-hdk.dt.yaml
	arch/arm64/boot/dts/qcom/sm8350-microsoft-surface-duo2.dt.yaml
	arch/arm64/boot/dts/qcom/sm8350-mtp.dt.yaml
	arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami-pdx214.dt.yaml
	arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami-pdx215.dt.yaml

spmi@c440000: reg-names:2: 'cnfg' was expected
	arch/arm64/boot/dts/qcom/qrb5165-rb5.dt.yaml
	arch/arm64/boot/dts/qcom/sa8155p-adp.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-idp.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r1.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r1-lte.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r3.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r3-lte.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar-r2.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar-r3.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar-r4.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots-r4.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots-r5.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots-r9.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-r4.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-r9.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r0.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1-kb.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1-lte.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3-kb.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3-lte.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r9.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r9-kb.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r9-lte.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r1.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r1-lte.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r2.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r2-lte.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r3.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r3-lte.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-r1.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-r1-lte.dt.yaml
	arch/arm64/boot/dts/qcom/sc7280-crd.dt.yaml
	arch/arm64/boot/dts/qcom/sc7280-herobrine.dt.yaml
	arch/arm64/boot/dts/qcom/sc7280-idp2.dt.yaml
	arch/arm64/boot/dts/qcom/sc7280-idp.dt.yaml
	arch/arm64/boot/dts/qcom/sdm845-cheza-r1.dt.yaml
	arch/arm64/boot/dts/qcom/sdm845-cheza-r2.dt.yaml
	arch/arm64/boot/dts/qcom/sdm845-cheza-r3.dt.yaml
	arch/arm64/boot/dts/qcom/sdm845-db845c.dt.yaml
	arch/arm64/boot/dts/qcom/sdm845-mtp.dt.yaml
	arch/arm64/boot/dts/qcom/sdm845-oneplus-enchilada.dt.yaml
	arch/arm64/boot/dts/qcom/sdm845-oneplus-fajita.dt.yaml
	arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama-akari.dt.yaml
	arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama-akatsuki.dt.yaml
	arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama-apollo.dt.yaml
	arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dt.yaml
	arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dt.yaml
	arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dt.yaml
	arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dt.yaml
	arch/arm64/boot/dts/qcom/sm8150-hdk.dt.yaml
	arch/arm64/boot/dts/qcom/sm8150-microsoft-surface-duo.dt.yaml
	arch/arm64/boot/dts/qcom/sm8150-mtp.dt.yaml
	arch/arm64/boot/dts/qcom/sm8150-sony-xperia-kumano-bahamut.dt.yaml
	arch/arm64/boot/dts/qcom/sm8150-sony-xperia-kumano-griffin.dt.yaml
	arch/arm64/boot/dts/qcom/sm8250-hdk.dt.yaml
	arch/arm64/boot/dts/qcom/sm8250-mtp.dt.yaml
	arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo-pdx203.dt.yaml
	arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo-pdx206.dt.yaml
	arch/arm64/boot/dts/qcom/sm8350-hdk.dt.yaml
	arch/arm64/boot/dts/qcom/sm8350-microsoft-surface-duo2.dt.yaml
	arch/arm64/boot/dts/qcom/sm8350-mtp.dt.yaml
	arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami-pdx214.dt.yaml
	arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami-pdx215.dt.yaml

spmi@c440000: reg-names:3: 'chnls' was expected
	arch/arm64/boot/dts/qcom/qrb5165-rb5.dt.yaml
	arch/arm64/boot/dts/qcom/sa8155p-adp.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-idp.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r1.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r1-lte.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r3.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r3-lte.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar-r2.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar-r3.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar-r4.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots-r4.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots-r5.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots-r9.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-r4.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-r9.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r0.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1-kb.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1-lte.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3-kb.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3-lte.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r9.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r9-kb.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r9-lte.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r1.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r1-lte.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r2.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r2-lte.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r3.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r3-lte.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-r1.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-r1-lte.dt.yaml
	arch/arm64/boot/dts/qcom/sc7280-crd.dt.yaml
	arch/arm64/boot/dts/qcom/sc7280-herobrine.dt.yaml
	arch/arm64/boot/dts/qcom/sc7280-idp2.dt.yaml
	arch/arm64/boot/dts/qcom/sc7280-idp.dt.yaml
	arch/arm64/boot/dts/qcom/sdm845-cheza-r1.dt.yaml
	arch/arm64/boot/dts/qcom/sdm845-cheza-r2.dt.yaml
	arch/arm64/boot/dts/qcom/sdm845-cheza-r3.dt.yaml
	arch/arm64/boot/dts/qcom/sdm845-db845c.dt.yaml
	arch/arm64/boot/dts/qcom/sdm845-mtp.dt.yaml
	arch/arm64/boot/dts/qcom/sdm845-oneplus-enchilada.dt.yaml
	arch/arm64/boot/dts/qcom/sdm845-oneplus-fajita.dt.yaml
	arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama-akari.dt.yaml
	arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama-akatsuki.dt.yaml
	arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama-apollo.dt.yaml
	arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dt.yaml
	arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dt.yaml
	arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dt.yaml
	arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dt.yaml
	arch/arm64/boot/dts/qcom/sm8150-hdk.dt.yaml
	arch/arm64/boot/dts/qcom/sm8150-microsoft-surface-duo.dt.yaml
	arch/arm64/boot/dts/qcom/sm8150-mtp.dt.yaml
	arch/arm64/boot/dts/qcom/sm8150-sony-xperia-kumano-bahamut.dt.yaml
	arch/arm64/boot/dts/qcom/sm8150-sony-xperia-kumano-griffin.dt.yaml
	arch/arm64/boot/dts/qcom/sm8250-hdk.dt.yaml
	arch/arm64/boot/dts/qcom/sm8250-mtp.dt.yaml
	arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo-pdx203.dt.yaml
	arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo-pdx206.dt.yaml
	arch/arm64/boot/dts/qcom/sm8350-hdk.dt.yaml
	arch/arm64/boot/dts/qcom/sm8350-microsoft-surface-duo2.dt.yaml
	arch/arm64/boot/dts/qcom/sm8350-mtp.dt.yaml
	arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami-pdx214.dt.yaml
	arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami-pdx215.dt.yaml

spmi@c440000: reg-names:4: 'obsrvr' was expected
	arch/arm64/boot/dts/qcom/qrb5165-rb5.dt.yaml
	arch/arm64/boot/dts/qcom/sa8155p-adp.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-idp.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r1.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r1-lte.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r3.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r3-lte.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar-r2.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar-r3.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar-r4.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots-r4.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots-r5.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots-r9.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-r4.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-r9.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r0.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1-kb.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1-lte.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3-kb.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3-lte.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r9.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r9-kb.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r9-lte.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r1.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r1-lte.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r2.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r2-lte.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r3.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r3-lte.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-r1.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-r1-lte.dt.yaml
	arch/arm64/boot/dts/qcom/sc7280-crd.dt.yaml
	arch/arm64/boot/dts/qcom/sc7280-herobrine.dt.yaml
	arch/arm64/boot/dts/qcom/sc7280-idp2.dt.yaml
	arch/arm64/boot/dts/qcom/sc7280-idp.dt.yaml
	arch/arm64/boot/dts/qcom/sdm845-cheza-r1.dt.yaml
	arch/arm64/boot/dts/qcom/sdm845-cheza-r2.dt.yaml
	arch/arm64/boot/dts/qcom/sdm845-cheza-r3.dt.yaml
	arch/arm64/boot/dts/qcom/sdm845-db845c.dt.yaml
	arch/arm64/boot/dts/qcom/sdm845-mtp.dt.yaml
	arch/arm64/boot/dts/qcom/sdm845-oneplus-enchilada.dt.yaml
	arch/arm64/boot/dts/qcom/sdm845-oneplus-fajita.dt.yaml
	arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama-akari.dt.yaml
	arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama-akatsuki.dt.yaml
	arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama-apollo.dt.yaml
	arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dt.yaml
	arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dt.yaml
	arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dt.yaml
	arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dt.yaml
	arch/arm64/boot/dts/qcom/sm8150-hdk.dt.yaml
	arch/arm64/boot/dts/qcom/sm8150-microsoft-surface-duo.dt.yaml
	arch/arm64/boot/dts/qcom/sm8150-mtp.dt.yaml
	arch/arm64/boot/dts/qcom/sm8150-sony-xperia-kumano-bahamut.dt.yaml
	arch/arm64/boot/dts/qcom/sm8150-sony-xperia-kumano-griffin.dt.yaml
	arch/arm64/boot/dts/qcom/sm8250-hdk.dt.yaml
	arch/arm64/boot/dts/qcom/sm8250-mtp.dt.yaml
	arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo-pdx203.dt.yaml
	arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo-pdx206.dt.yaml
	arch/arm64/boot/dts/qcom/sm8350-hdk.dt.yaml
	arch/arm64/boot/dts/qcom/sm8350-microsoft-surface-duo2.dt.yaml
	arch/arm64/boot/dts/qcom/sm8350-mtp.dt.yaml
	arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami-pdx214.dt.yaml
	arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami-pdx215.dt.yaml

spmi@c440000: #size-cells:0:0: 0 was expected
	arch/arm64/boot/dts/qcom/sc7180-idp.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r1.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r1-lte.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r3.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r3-lte.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar-r2.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar-r3.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar-r4.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots-r4.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots-r5.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots-r9.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-r4.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-r9.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r0.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1-kb.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1-lte.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3-kb.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3-lte.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r9.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r9-kb.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r9-lte.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r1.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r1-lte.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r2.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r2-lte.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r3.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r3-lte.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-r1.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-r1-lte.dt.yaml
	arch/arm64/boot/dts/qcom/sc7280-crd.dt.yaml
	arch/arm64/boot/dts/qcom/sc7280-herobrine.dt.yaml
	arch/arm64/boot/dts/qcom/sc7280-idp2.dt.yaml
	arch/arm64/boot/dts/qcom/sc7280-idp.dt.yaml

spmi@c440000: Unevaluated properties are not allowed ('reg-names', '#address-cells', '#size-cells', 'interrupt-controller', '#interrupt-cells', 'cell-index' were unexpected)
	arch/arm64/boot/dts/qcom/sc7180-idp.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r1.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r1-lte.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r3.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r3-lte.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar-r2.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar-r3.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar-r4.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots-r4.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots-r5.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots-r9.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-r4.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-r9.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r0.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1-kb.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1-lte.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3-kb.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3-lte.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r9.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r9-kb.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r9-lte.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r1.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r1-lte.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r2.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r2-lte.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r3.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r3-lte.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-r1.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-r1-lte.dt.yaml

spmi@c440000: Unevaluated properties are not allowed ('reg-names', '#address-cells', '#size-cells', 'interrupt-controller', '#interrupt-cells' were unexpected)
	arch/arm64/boot/dts/qcom/sc7280-crd.dt.yaml
	arch/arm64/boot/dts/qcom/sc7280-herobrine.dt.yaml
	arch/arm64/boot/dts/qcom/sc7280-idp2.dt.yaml
	arch/arm64/boot/dts/qcom/sc7280-idp.dt.yaml

