Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F96D4664DB
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 14:58:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358399AbhLBOBm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 09:01:42 -0500
Received: from mail-ot1-f48.google.com ([209.85.210.48]:38634 "EHLO
        mail-ot1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357990AbhLBOBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 09:01:38 -0500
Received: by mail-ot1-f48.google.com with SMTP id n104-20020a9d2071000000b005799790cf0bso40072227ota.5;
        Thu, 02 Dec 2021 05:58:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=OUovefyGyr/ld5Zl1Zb2s1x2kPrJsHHfs2hAWyfjCDs=;
        b=vcdj5mESRMGxOBCAkSptMMXzAfplAmSPsWeYXSuj/WnzLqfl7FKMLwXokl+TLGvzg0
         m6Xa5NlP3Nx5+sSrxMO+elVj9mUkMipC3Tz5VwW86fGyVogtLUgIGx/6EbHwUGzan+9+
         e5mcnimaUdf0pldlUh13pKZ7cbC1tO3uWiS0KstcXZSy28A0K0q1ptQ/cWW256l8+Rey
         wNPKBBgAzlbJLQ9SZ2wa4zW5KfBeAP8rQo2CM3hSYnKeb3qCJDKYi/w9g547U6mNn8yV
         wRkp5dEAb4HzDCsEezxZNJfx+6vKJlrjOXC4rDL46QXbCa3MR/swVfeisJebvLU6QsXq
         mZ5Q==
X-Gm-Message-State: AOAM531jdYBsy9viVnx31nH75pJvmoUCckBz5Zuu2A2BlG9n5avY6kl0
        enIuy4wbfrnD+4VHqNI3JA==
X-Google-Smtp-Source: ABdhPJxAgZTnrp6GBDxHEBz9M7W86DeyUxH0YF29p7pQUcJEKAGjuG5ST9AUOXwsjm9FE/Rm3yUrHg==
X-Received: by 2002:a05:6830:1445:: with SMTP id w5mr11624401otp.112.1638453495279;
        Thu, 02 Dec 2021 05:58:15 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id j20sm1055852ota.76.2021.12.02.05.58.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 05:58:14 -0800 (PST)
Received: (nullmailer pid 3736893 invoked by uid 1000);
        Thu, 02 Dec 2021 13:58:09 -0000
From:   Rob Herring <robh@kernel.org>
To:     Fenglin Wu <quic_fenglinw@quicinc.com>
Cc:     linux-kernel@vger.kernel.org,
        Subbaraman Narayanamurthy <quic_subbaram@quicinc.com>,
        collinsd@codeaurora.org, Andy Gross <agross@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        subbaram@codeaurora.org, tglx@linutronix.de, maz@kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>, sboyd@kernel.org
In-Reply-To: <1638403212-29265-11-git-send-email-quic_fenglinw@quicinc.com>
References: <1638403212-29265-1-git-send-email-quic_fenglinw@quicinc.com> <1638403212-29265-11-git-send-email-quic_fenglinw@quicinc.com>
Subject: Re: [RESEND PATCH v3 10/10] dt-bindings: convert qcom,spmi-pmic-arb binding to YAML format
Date:   Thu, 02 Dec 2021 07:58:09 -0600
Message-Id: <1638453489.532760.3736891.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 02 Dec 2021 08:00:12 +0800, Fenglin Wu wrote:
> Convert the SPMI PMIC arbiter documentation to JSON/yaml. While at it,
> update SPMI bus "reg" items constraint for SPMI PMIC arbiter to carry
> it and update it with a smaller range.
> 
> Signed-off-by: Fenglin Wu <quic_fenglinw@quicinc.com>
> ---
>  .../bindings/spmi/qcom,spmi-pmic-arb.txt           |  67 -----------
>  .../bindings/spmi/qcom,spmi-pmic-arb.yaml          | 128 +++++++++++++++++++++
>  Documentation/devicetree/bindings/spmi/spmi.yaml   |   3 +-
>  3 files changed, 130 insertions(+), 68 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb.txt
>  create mode 100644 Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb.yaml
> 

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/patch/1562483


qcom,spmi@400f000: $nodename:0: 'qcom,spmi@400f000' does not match '^spmi@.*'
	arch/arm64/boot/dts/qcom/apq8096-db820c.dt.yaml
	arch/arm64/boot/dts/qcom/apq8096-db820c.dt.yaml
	arch/arm64/boot/dts/qcom/apq8096-ifc6640.dt.yaml
	arch/arm64/boot/dts/qcom/apq8096-ifc6640.dt.yaml
	arch/arm64/boot/dts/qcom/msm8996-mtp.dt.yaml
	arch/arm64/boot/dts/qcom/msm8996-mtp.dt.yaml
	arch/arm64/boot/dts/qcom/msm8996-pmi8996-sony-xperia-tone-dora.dt.yaml
	arch/arm64/boot/dts/qcom/msm8996-pmi8996-sony-xperia-tone-dora.dt.yaml
	arch/arm64/boot/dts/qcom/msm8996-pmi8996-sony-xperia-tone-kagura.dt.yaml
	arch/arm64/boot/dts/qcom/msm8996-pmi8996-sony-xperia-tone-kagura.dt.yaml
	arch/arm64/boot/dts/qcom/msm8996-pmi8996-sony-xperia-tone-keyaki.dt.yaml
	arch/arm64/boot/dts/qcom/msm8996-pmi8996-sony-xperia-tone-keyaki.dt.yaml
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-dora.dt.yaml
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-dora.dt.yaml
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-kagura.dt.yaml
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-kagura.dt.yaml
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-keyaki.dt.yaml
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-keyaki.dt.yaml
	arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dt.yaml
	arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dt.yaml
	arch/arm64/boot/dts/qcom/msm8996-xiaomi-scorpio.dt.yaml
	arch/arm64/boot/dts/qcom/msm8996-xiaomi-scorpio.dt.yaml

qcom,spmi@400f000: 'pmic@0', 'pmic@1', 'pmic@2', 'pmic@3' do not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm64/boot/dts/qcom/apq8096-db820c.dt.yaml
	arch/arm64/boot/dts/qcom/apq8096-ifc6640.dt.yaml
	arch/arm64/boot/dts/qcom/msm8996-pmi8996-sony-xperia-tone-dora.dt.yaml
	arch/arm64/boot/dts/qcom/msm8996-pmi8996-sony-xperia-tone-kagura.dt.yaml
	arch/arm64/boot/dts/qcom/msm8996-pmi8996-sony-xperia-tone-keyaki.dt.yaml
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-dora.dt.yaml
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-kagura.dt.yaml
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-keyaki.dt.yaml
	arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dt.yaml
	arch/arm64/boot/dts/qcom/msm8996-xiaomi-scorpio.dt.yaml

qcom,spmi@400f000: reg-names: 'oneOf' conditional failed, one must be fixed:
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
	arch/arm/boot/dts/qcom-sdx55-mtp.dt.yaml
	arch/arm/boot/dts/qcom-sdx55-t55.dt.yaml
	arch/arm/boot/dts/qcom-sdx55-t55.dt.yaml
	arch/arm/boot/dts/qcom-sdx55-telit-fn980-tlb.dt.yaml
	arch/arm/boot/dts/qcom-sdx55-telit-fn980-tlb.dt.yaml

qcom,spmi@c440000: 'cell-index', 'pmic@2', 'pmic@3', 'pmic@8', 'pmic@9' do not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm/boot/dts/qcom-sdx55-mtp.dt.yaml

qcom,spmi@c440000: 'cell-index', 'pmic@8', 'pmic@9' do not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm/boot/dts/qcom-sdx55-t55.dt.yaml
	arch/arm/boot/dts/qcom-sdx55-telit-fn980-tlb.dt.yaml

qcom,spmi@c440000: reg-names: 'oneOf' conditional failed, one must be fixed:
	arch/arm/boot/dts/qcom-sdx55-mtp.dt.yaml
	arch/arm/boot/dts/qcom-sdx55-t55.dt.yaml
	arch/arm/boot/dts/qcom-sdx55-telit-fn980-tlb.dt.yaml

spmi@1c40000: 'cell-index' does not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm64/boot/dts/qcom/sm6125-sony-xperia-seine-pdx201.dt.yaml

spmi@1c40000: reg-names: 'oneOf' conditional failed, one must be fixed:
	arch/arm64/boot/dts/qcom/sm6125-sony-xperia-seine-pdx201.dt.yaml

spmi@200f000: 'cell-index' does not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm64/boot/dts/qcom/ipq8074-hk01.dt.yaml
	arch/arm64/boot/dts/qcom/ipq8074-hk10-c1.dt.yaml
	arch/arm64/boot/dts/qcom/ipq8074-hk10-c2.dt.yaml

spmi@200f000: 'pmic@0', 'pmic@1' do not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm64/boot/dts/qcom/apq8016-sbc.dt.yaml
	arch/arm64/boot/dts/qcom/msm8916-alcatel-idol347.dt.yaml
	arch/arm64/boot/dts/qcom/msm8916-asus-z00l.dt.yaml
	arch/arm64/boot/dts/qcom/msm8916-huawei-g7.dt.yaml
	arch/arm64/boot/dts/qcom/msm8916-longcheer-l8150.dt.yaml
	arch/arm64/boot/dts/qcom/msm8916-longcheer-l8910.dt.yaml
	arch/arm64/boot/dts/qcom/msm8916-mtp.dt.yaml
	arch/arm64/boot/dts/qcom/msm8916-samsung-a3u-eur.dt.yaml
	arch/arm64/boot/dts/qcom/msm8916-samsung-a5u-eur.dt.yaml
	arch/arm64/boot/dts/qcom/msm8916-samsung-serranove.dt.yaml
	arch/arm64/boot/dts/qcom/msm8916-wingtech-wt88047.dt.yaml
	arch/arm/boot/dts/qcom-msm8916-samsung-serranove.dt.yaml

spmi@200f000: 'pms405@0', 'pms405@1' do not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm64/boot/dts/qcom/qcs404-evb-1000.dt.yaml
	arch/arm64/boot/dts/qcom/qcs404-evb-4000.dt.yaml

spmi@200f000: reg-names: 'oneOf' conditional failed, one must be fixed:
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
	arch/arm64/boot/dts/qcom/msm8916-samsung-serranove.dt.yaml
	arch/arm64/boot/dts/qcom/msm8916-wingtech-wt88047.dt.yaml
	arch/arm64/boot/dts/qcom/qcs404-evb-1000.dt.yaml
	arch/arm64/boot/dts/qcom/qcs404-evb-4000.dt.yaml
	arch/arm/boot/dts/qcom-msm8916-samsung-serranove.dt.yaml

spmi@800f000: 'cell-index' does not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm64/boot/dts/qcom/sdm660-xiaomi-lavender.dt.yaml

spmi@800f000: 'cell-index', 'pmic@0', 'pmic@1', 'pmic@2', 'pmic@3' do not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm64/boot/dts/qcom/sdm630-sony-xperia-ganges-kirin.dt.yaml
	arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile-discovery.dt.yaml
	arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile-pioneer.dt.yaml
	arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile-voyager.dt.yaml
	arch/arm64/boot/dts/qcom/sdm636-sony-xperia-ganges-mermaid.dt.yaml

spmi@800f000: 'cell-index', 'pmic@0', 'pmic@1', 'pmic@2', 'pmic@3', 'pmic@4', 'pmic@5' do not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm64/boot/dts/qcom/msm8998-fxtec-pro1.dt.yaml
	arch/arm64/boot/dts/qcom/msm8998-mtp.dt.yaml
	arch/arm64/boot/dts/qcom/msm8998-oneplus-cheeseburger.dt.yaml
	arch/arm64/boot/dts/qcom/msm8998-oneplus-dumpling.dt.yaml
	arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino-lilac.dt.yaml
	arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino-maple.dt.yaml
	arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino-poplar.dt.yaml

spmi@800f000: 'cell-index', 'pmic@0', 'pmic@1', 'pmic@4', 'pmic@5' do not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm64/boot/dts/qcom/msm8998-asus-novago-tp370ql.dt.yaml
	arch/arm64/boot/dts/qcom/msm8998-hp-envy-x2.dt.yaml
	arch/arm64/boot/dts/qcom/msm8998-lenovo-miix-630.dt.yaml

spmi@800f000: reg-names: 'oneOf' conditional failed, one must be fixed:
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
	arch/arm64/boot/dts/qcom/sc7180-idp.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-idp.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r1.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r1.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r1.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r1-lte.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r1-lte.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r1-lte.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r3.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r3.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r3.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r3-lte.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r3-lte.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r3-lte.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar-r2.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar-r2.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar-r2.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar-r3.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar-r3.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar-r3.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots-r4.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots-r4.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots-r4.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r0.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r0.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r0.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1-kb.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1-kb.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1-kb.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1-lte.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1-lte.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1-lte.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3-kb.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3-kb.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3-kb.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3-lte.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3-lte.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3-lte.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r1.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r1.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r1.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r1-lte.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r1-lte.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r1-lte.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r2.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r2.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r2.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r2-lte.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r2-lte.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r2-lte.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r3.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r3.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r3.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r3-lte.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r3-lte.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r3-lte.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-r1.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-r1.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-r1.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-r1-lte.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-r1-lte.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-r1-lte.dt.yaml
	arch/arm64/boot/dts/qcom/sc7280-herobrine.dt.yaml
	arch/arm64/boot/dts/qcom/sc7280-herobrine.dt.yaml
	arch/arm64/boot/dts/qcom/sc7280-herobrine.dt.yaml
	arch/arm64/boot/dts/qcom/sc7280-idp2.dt.yaml
	arch/arm64/boot/dts/qcom/sc7280-idp2.dt.yaml
	arch/arm64/boot/dts/qcom/sc7280-idp2.dt.yaml
	arch/arm64/boot/dts/qcom/sc7280-idp.dt.yaml
	arch/arm64/boot/dts/qcom/sc7280-idp.dt.yaml
	arch/arm64/boot/dts/qcom/sc7280-idp.dt.yaml

spmi@c440000: 'cell-index' does not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm64/boot/dts/qcom/sdm845-mtp.dt.yaml

spmi@c440000: 'cell-index', 'pmic@0', 'pmic@1' do not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dt.yaml

spmi@c440000: 'cell-index', 'pmic@0', 'pmic@1', 'pmic@2', 'pmic@3' do not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm64/boot/dts/qcom/sdm845-db845c.dt.yaml
	arch/arm64/boot/dts/qcom/sdm845-oneplus-enchilada.dt.yaml
	arch/arm64/boot/dts/qcom/sdm845-oneplus-fajita.dt.yaml
	arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dt.yaml

spmi@c440000: 'cell-index', 'pmic@0', 'pmic@1', 'pmic@2', 'pmic@3', 'pmic@4', 'pmic@5' do not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm64/boot/dts/qcom/sm8150-hdk.dt.yaml
	arch/arm64/boot/dts/qcom/sm8150-microsoft-surface-duo.dt.yaml
	arch/arm64/boot/dts/qcom/sm8150-mtp.dt.yaml
	arch/arm64/boot/dts/qcom/sm8150-sony-xperia-kumano-bahamut.dt.yaml
	arch/arm64/boot/dts/qcom/sm8150-sony-xperia-kumano-griffin.dt.yaml

spmi@c440000: 'cell-index', 'pmic@0', 'pmic@1', 'pmic@4', 'pmic@5' do not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm64/boot/dts/qcom/sa8155p-adp.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-idp.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r1.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r1-lte.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r3.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r3-lte.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar-r2.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar-r3.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots-r4.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r0.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1-kb.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1-lte.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3-kb.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3-lte.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r1.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r1-lte.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r2.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r2-lte.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r3.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r3-lte.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-r1.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-r1-lte.dt.yaml
	arch/arm64/boot/dts/qcom/sdm845-cheza-r1.dt.yaml
	arch/arm64/boot/dts/qcom/sdm845-cheza-r2.dt.yaml
	arch/arm64/boot/dts/qcom/sdm845-cheza-r3.dt.yaml

spmi@c440000: 'pmic@0', 'pmic@1' do not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dt.yaml

spmi@c440000: 'pmic@0', 'pmic@1', 'pmic@2' do not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm64/boot/dts/qcom/sc7280-herobrine.dt.yaml
	arch/arm64/boot/dts/qcom/sc7280-idp2.dt.yaml

spmi@c440000: 'pmic@0', 'pmic@1', 'pmic@2', 'pmic@3', 'pmic@4', 'pmic@5' do not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm64/boot/dts/qcom/qrb5165-rb5.dt.yaml
	arch/arm64/boot/dts/qcom/sm8250-hdk.dt.yaml
	arch/arm64/boot/dts/qcom/sm8350-mtp.dt.yaml

spmi@c440000: 'pmic@0', 'pmic@1', 'pmic@2', 'pmic@3', 'pmic@4', 'pmic@5', 'pmic@a', 'pmic@b' do not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm64/boot/dts/qcom/sm8250-mtp.dt.yaml
	arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo-pdx203.dt.yaml
	arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo-pdx206.dt.yaml

spmi@c440000: 'pmic@0', 'pmic@1', 'pmic@2', 'pmic@4' do not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm64/boot/dts/qcom/sc7280-idp.dt.yaml

spmi@c440000: reg-names: 'oneOf' conditional failed, one must be fixed:
	arch/arm64/boot/dts/qcom/qrb5165-rb5.dt.yaml
	arch/arm64/boot/dts/qcom/sa8155p-adp.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-idp.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r1.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r1-lte.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r3.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r3-lte.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar-r2.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar-r3.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots-r4.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r0.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1-kb.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1-lte.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3-kb.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3-lte.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r1.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r1-lte.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r2.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r2-lte.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r3.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r3-lte.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-r1.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-r1-lte.dt.yaml
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
	arch/arm64/boot/dts/qcom/sm8350-mtp.dt.yaml

spmi@c440000: #size-cells:0:0: 0 was expected
	arch/arm64/boot/dts/qcom/sc7180-idp.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-idp.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-idp.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r1.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r1.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r1.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r1-lte.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r1-lte.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r1-lte.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r3.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r3.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r3.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r3-lte.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r3-lte.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r3-lte.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar-r2.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar-r2.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar-r2.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar-r3.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar-r3.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar-r3.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots-r4.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots-r4.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots-r4.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r0.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r0.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r0.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1-kb.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1-kb.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1-kb.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1-lte.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1-lte.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1-lte.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3-kb.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3-kb.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3-kb.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3-lte.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3-lte.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3-lte.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r1.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r1.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r1.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r1-lte.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r1-lte.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r1-lte.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r2.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r2.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r2.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r2-lte.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r2-lte.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r2-lte.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r3.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r3.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r3.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r3-lte.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r3-lte.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r3-lte.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-r1.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-r1.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-r1.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-r1-lte.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-r1-lte.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-r1-lte.dt.yaml
	arch/arm64/boot/dts/qcom/sc7280-herobrine.dt.yaml
	arch/arm64/boot/dts/qcom/sc7280-herobrine.dt.yaml
	arch/arm64/boot/dts/qcom/sc7280-herobrine.dt.yaml
	arch/arm64/boot/dts/qcom/sc7280-idp2.dt.yaml
	arch/arm64/boot/dts/qcom/sc7280-idp2.dt.yaml
	arch/arm64/boot/dts/qcom/sc7280-idp2.dt.yaml
	arch/arm64/boot/dts/qcom/sc7280-idp.dt.yaml
	arch/arm64/boot/dts/qcom/sc7280-idp.dt.yaml
	arch/arm64/boot/dts/qcom/sc7280-idp.dt.yaml

spmi@fc4c0000: 'pmic@0', 'pmic@1', 'pmic@2', 'pmic@3' do not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm64/boot/dts/qcom/apq8094-sony-xperia-kitakami-karin_windy.dt.yaml
	arch/arm64/boot/dts/qcom/msm8992-bullhead-rev-101.dt.yaml
	arch/arm64/boot/dts/qcom/msm8992-msft-lumia-octagon-talkman.dt.yaml
	arch/arm64/boot/dts/qcom/msm8992-xiaomi-libra.dt.yaml
	arch/arm64/boot/dts/qcom/msm8994-msft-lumia-octagon-cityman.dt.yaml
	arch/arm64/boot/dts/qcom/msm8994-sony-xperia-kitakami-ivy.dt.yaml
	arch/arm64/boot/dts/qcom/msm8994-sony-xperia-kitakami-karin.dt.yaml
	arch/arm64/boot/dts/qcom/msm8994-sony-xperia-kitakami-satsuki.dt.yaml
	arch/arm64/boot/dts/qcom/msm8994-sony-xperia-kitakami-sumire.dt.yaml
	arch/arm64/boot/dts/qcom/msm8994-sony-xperia-kitakami-suzuran.dt.yaml

spmi@fc4cf000: 'pm8226@0', 'pm8226@1' do not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm/boot/dts/qcom-apq8026-lg-lenok.dt.yaml

spmi@fc4cf000: 'pm8841@4', 'pm8841@5', 'pm8941@0', 'pm8941@1' do not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm/boot/dts/qcom-apq8074-dragonboard.dt.yaml
	arch/arm/boot/dts/qcom-msm8974-fairphone-fp2.dt.yaml
	arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dt.yaml
	arch/arm/boot/dts/qcom-msm8974-sony-xperia-amami.dt.yaml
	arch/arm/boot/dts/qcom-msm8974-sony-xperia-castor.dt.yaml
	arch/arm/boot/dts/qcom-msm8974-sony-xperia-honami.dt.yaml

spmi@fc4cf000: 'pma8084@0', 'pma8084@1' do not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm/boot/dts/qcom-apq8084-ifc6540.dt.yaml
	arch/arm/boot/dts/qcom-apq8084-mtp.dt.yaml
	arch/arm/boot/dts/qcom-msm8974-samsung-klte.dt.yaml

