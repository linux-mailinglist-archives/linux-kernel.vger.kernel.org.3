Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00B434EB3D8
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 21:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240806AbiC2TGz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 15:06:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240790AbiC2TGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 15:06:53 -0400
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18A20122225;
        Tue, 29 Mar 2022 12:05:06 -0700 (PDT)
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-de48295467so19767885fac.2;
        Tue, 29 Mar 2022 12:05:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=C0fHGk8solBUwXEuvvbLiG4BS1qC06k2gDKvwiDcY74=;
        b=aB0D5iqW4E7tdWOVTPHBN9d17OS20n14DWQWg7jg8magYAyo5wlq+aMR3WBxAREOp6
         ZsXa0QdnTh1K6cvmsbFbnVIBNcC02KYbqeN3aqkvPloiF0sJDoYSWLh4MdzgmrOLPIkp
         98/5fNrJeEhD8uPguU/w8BKRY+gCNBwql3URpj7YgQXwDqn6PZUGZqvoeebDNLGv4dkd
         rRta1UUn5DYwugyUvtTHYSe1ZAdhbTZ6FASgDgccjCu7VvFw/pg+3MGZX0mw9qENnGgg
         hGE79GjJ5VkawZSdEd2FSGhZ4dkJPNN44+imnsRiepY08uDbQmLK4kl0XRNXutDLZ9MN
         LSsQ==
X-Gm-Message-State: AOAM530OSYJeUl61Q6HPR/irO+uEd4yrf0trN2D9E5/degr9eIJq0AMP
        ayYeFurSzJZvlS0ChlvuSMJ0ctiqWA==
X-Google-Smtp-Source: ABdhPJz1Bx8ksFzUwFes11/foyFaLpEM9LHtstOTOVAf5T1JXMVinwSbxsyK1H0HtBldY43Q6RaYyQ==
X-Received: by 2002:a05:6871:a5:b0:d4:41d7:d341 with SMTP id u37-20020a05687100a500b000d441d7d341mr405725oaa.6.1648580704727;
        Tue, 29 Mar 2022 12:05:04 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id r8-20020a05683001c800b005cdadc2a837sm9319567ota.70.2022.03.29.12.05.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 12:05:03 -0700 (PDT)
Received: (nullmailer pid 1067579 invoked by uid 1000);
        Tue, 29 Mar 2022 19:05:00 -0000
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Mark Brown <broonie@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-spi@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Gross <agross@kernel.org>
In-Reply-To: <20220329112902.252937-5-krzysztof.kozlowski@linaro.org>
References: <20220329112902.252937-1-krzysztof.kozlowski@linaro.org> <20220329112902.252937-5-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH 4/4] spi: dt-bindings: qcom,spi-qup: convert to dtschema
Date:   Tue, 29 Mar 2022 14:05:00 -0500
Message-Id: <1648580700.650850.1067578.nullmailer@robh.at.kernel.org>
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

On Tue, 29 Mar 2022 13:29:02 +0200, Krzysztof Kozlowski wrote:
> Convert the Qualcomm Universal Peripheral (QUP) Serial Peripheral
> Interface (SPI) bindings to DT Schema.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/spi/qcom,spi-qup.txt  | 103 ------------------
>  .../devicetree/bindings/spi/qcom,spi-qup.yaml |  82 ++++++++++++++
>  2 files changed, 82 insertions(+), 103 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/spi/qcom,spi-qup.txt
>  create mode 100644 Documentation/devicetree/bindings/spi/qcom,spi-qup.yaml
> 

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/patch/1610591


spi@78b5000: clock-names:0: 'core' was expected
	arch/arm64/boot/dts/qcom/qcs404-evb-1000.dt.yaml
	arch/arm64/boot/dts/qcom/qcs404-evb-4000.dt.yaml

spi@78b5000: clock-names:1: 'iface' was expected
	arch/arm64/boot/dts/qcom/qcs404-evb-1000.dt.yaml
	arch/arm64/boot/dts/qcom/qcs404-evb-4000.dt.yaml

spi@78b5000: dma-names:0: 'tx' was expected
	arch/arm64/boot/dts/qcom/apq8016-sbc.dt.yaml
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
	arch/arm/boot/dts/qcom-apq8016-sbc.dt.yaml
	arch/arm/boot/dts/qcom-ipq4018-ap120c-ac-bit.dt.yaml
	arch/arm/boot/dts/qcom-ipq4018-ap120c-ac.dt.yaml
	arch/arm/boot/dts/qcom-ipq4018-jalapeno.dt.yaml
	arch/arm/boot/dts/qcom-ipq4019-ap.dk01.1-c1.dt.yaml
	arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1-c1.dt.yaml
	arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1-c3.dt.yaml
	arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1-c1.dt.yaml
	arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1-c2.dt.yaml
	arch/arm/boot/dts/qcom-msm8916-samsung-serranove.dt.yaml

spi@78b5000: dma-names:1: 'rx' was expected
	arch/arm64/boot/dts/qcom/apq8016-sbc.dt.yaml
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
	arch/arm/boot/dts/qcom-apq8016-sbc.dt.yaml
	arch/arm/boot/dts/qcom-ipq4018-ap120c-ac-bit.dt.yaml
	arch/arm/boot/dts/qcom-ipq4018-ap120c-ac.dt.yaml
	arch/arm/boot/dts/qcom-ipq4018-jalapeno.dt.yaml
	arch/arm/boot/dts/qcom-ipq4019-ap.dk01.1-c1.dt.yaml
	arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1-c1.dt.yaml
	arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1-c3.dt.yaml
	arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1-c1.dt.yaml
	arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1-c2.dt.yaml
	arch/arm/boot/dts/qcom-msm8916-samsung-serranove.dt.yaml

spi@78b6000: clock-names:0: 'core' was expected
	arch/arm64/boot/dts/qcom/qcs404-evb-1000.dt.yaml
	arch/arm64/boot/dts/qcom/qcs404-evb-4000.dt.yaml

spi@78b6000: clock-names:1: 'iface' was expected
	arch/arm64/boot/dts/qcom/qcs404-evb-1000.dt.yaml
	arch/arm64/boot/dts/qcom/qcs404-evb-4000.dt.yaml

spi@78b6000: dma-names:0: 'tx' was expected
	arch/arm64/boot/dts/qcom/apq8016-sbc.dt.yaml
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
	arch/arm/boot/dts/qcom-apq8016-sbc.dt.yaml
	arch/arm/boot/dts/qcom-ipq4018-ap120c-ac-bit.dt.yaml
	arch/arm/boot/dts/qcom-ipq4018-ap120c-ac.dt.yaml
	arch/arm/boot/dts/qcom-ipq4018-jalapeno.dt.yaml
	arch/arm/boot/dts/qcom-ipq4019-ap.dk01.1-c1.dt.yaml
	arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1-c1.dt.yaml
	arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1-c3.dt.yaml
	arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1-c1.dt.yaml
	arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1-c2.dt.yaml
	arch/arm/boot/dts/qcom-msm8916-samsung-serranove.dt.yaml

spi@78b6000: dma-names:1: 'rx' was expected
	arch/arm64/boot/dts/qcom/apq8016-sbc.dt.yaml
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
	arch/arm/boot/dts/qcom-apq8016-sbc.dt.yaml
	arch/arm/boot/dts/qcom-ipq4018-ap120c-ac-bit.dt.yaml
	arch/arm/boot/dts/qcom-ipq4018-ap120c-ac.dt.yaml
	arch/arm/boot/dts/qcom-ipq4018-jalapeno.dt.yaml
	arch/arm/boot/dts/qcom-ipq4019-ap.dk01.1-c1.dt.yaml
	arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1-c1.dt.yaml
	arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1-c3.dt.yaml
	arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1-c1.dt.yaml
	arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1-c2.dt.yaml
	arch/arm/boot/dts/qcom-msm8916-samsung-serranove.dt.yaml

spi@78b7000: clock-names:0: 'core' was expected
	arch/arm64/boot/dts/qcom/qcs404-evb-1000.dt.yaml
	arch/arm64/boot/dts/qcom/qcs404-evb-4000.dt.yaml

spi@78b7000: clock-names:1: 'iface' was expected
	arch/arm64/boot/dts/qcom/qcs404-evb-1000.dt.yaml
	arch/arm64/boot/dts/qcom/qcs404-evb-4000.dt.yaml

spi@78b7000: dma-names:0: 'tx' was expected
	arch/arm64/boot/dts/qcom/apq8016-sbc.dt.yaml
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
	arch/arm/boot/dts/qcom-apq8016-sbc.dt.yaml
	arch/arm/boot/dts/qcom-msm8916-samsung-serranove.dt.yaml

spi@78b7000: dma-names:1: 'rx' was expected
	arch/arm64/boot/dts/qcom/apq8016-sbc.dt.yaml
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
	arch/arm/boot/dts/qcom-apq8016-sbc.dt.yaml
	arch/arm/boot/dts/qcom-msm8916-samsung-serranove.dt.yaml

spi@78b8000: clock-names:0: 'core' was expected
	arch/arm64/boot/dts/qcom/qcs404-evb-1000.dt.yaml
	arch/arm64/boot/dts/qcom/qcs404-evb-4000.dt.yaml

spi@78b8000: clock-names:1: 'iface' was expected
	arch/arm64/boot/dts/qcom/qcs404-evb-1000.dt.yaml
	arch/arm64/boot/dts/qcom/qcs404-evb-4000.dt.yaml

spi@78b8000: dma-names:0: 'tx' was expected
	arch/arm64/boot/dts/qcom/apq8016-sbc.dt.yaml
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
	arch/arm/boot/dts/qcom-apq8016-sbc.dt.yaml
	arch/arm/boot/dts/qcom-msm8916-samsung-serranove.dt.yaml

spi@78b8000: dma-names:1: 'rx' was expected
	arch/arm64/boot/dts/qcom/apq8016-sbc.dt.yaml
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
	arch/arm/boot/dts/qcom-apq8016-sbc.dt.yaml
	arch/arm/boot/dts/qcom-msm8916-samsung-serranove.dt.yaml

spi@78b9000: clock-names:0: 'core' was expected
	arch/arm64/boot/dts/qcom/qcs404-evb-1000.dt.yaml
	arch/arm64/boot/dts/qcom/qcs404-evb-4000.dt.yaml

spi@78b9000: clock-names:1: 'iface' was expected
	arch/arm64/boot/dts/qcom/qcs404-evb-1000.dt.yaml
	arch/arm64/boot/dts/qcom/qcs404-evb-4000.dt.yaml

spi@78b9000: dma-names:0: 'tx' was expected
	arch/arm64/boot/dts/qcom/apq8016-sbc.dt.yaml
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
	arch/arm/boot/dts/qcom-apq8016-sbc.dt.yaml
	arch/arm/boot/dts/qcom-msm8916-samsung-serranove.dt.yaml

spi@78b9000: dma-names:1: 'rx' was expected
	arch/arm64/boot/dts/qcom/apq8016-sbc.dt.yaml
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
	arch/arm/boot/dts/qcom-apq8016-sbc.dt.yaml
	arch/arm/boot/dts/qcom-msm8916-samsung-serranove.dt.yaml

spi@78ba000: dma-names:0: 'tx' was expected
	arch/arm64/boot/dts/qcom/apq8016-sbc.dt.yaml
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
	arch/arm/boot/dts/qcom-apq8016-sbc.dt.yaml
	arch/arm/boot/dts/qcom-msm8916-samsung-serranove.dt.yaml

spi@78ba000: dma-names:1: 'rx' was expected
	arch/arm64/boot/dts/qcom/apq8016-sbc.dt.yaml
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
	arch/arm/boot/dts/qcom-apq8016-sbc.dt.yaml
	arch/arm/boot/dts/qcom-msm8916-samsung-serranove.dt.yaml

spi@7af5000: clock-names:0: 'core' was expected
	arch/arm64/boot/dts/qcom/qcs404-evb-1000.dt.yaml
	arch/arm64/boot/dts/qcom/qcs404-evb-4000.dt.yaml

spi@7af5000: clock-names:1: 'iface' was expected
	arch/arm64/boot/dts/qcom/qcs404-evb-1000.dt.yaml
	arch/arm64/boot/dts/qcom/qcs404-evb-4000.dt.yaml

