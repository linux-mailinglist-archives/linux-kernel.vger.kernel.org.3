Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB8D252D388
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 15:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238633AbiESNGL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 09:06:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238431AbiESNFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 09:05:50 -0400
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A9A65FBB;
        Thu, 19 May 2022 06:05:48 -0700 (PDT)
Received: by mail-oi1-f178.google.com with SMTP id s188so2576871oie.4;
        Thu, 19 May 2022 06:05:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=Gt17Lfq2MMgEmt6V/TKx+0AiZ00DH5GmbDvbL37/fjw=;
        b=bfT4tnqPg5ysrJOcizp4HogidXlJ0jyWuU36Pl8Nu0/VsHZG4EUaQxUTJhLeg3XyjP
         2ewk1ulmca2D/SSd1cw7Z55axta65Jf3Hh0uK2u4PBufoUMDXSfJj4mDMl/7CEQzXc0e
         /0HdZn7YvHEjTnvRkPigvLy1Fs+tTxauV6079udCQjEA6W0l4vO8UcvWRJKW3KZeNiBR
         Mv+zuQtf9/i67+ARp3eIFFtJSZrgQzZg0EwvZyfV6jN6mBAi8fBstUGPz1zs1A+I77q0
         kTKiWIk6Lw+rwh1xzxobkymL5Dvr6DgwBS1hAILupnkQZ7fqIj3uA1n3vwhdNuI1Spoa
         3y7g==
X-Gm-Message-State: AOAM532BoO9b1SNzRXpasBiu3cdVInHA3t7AKbzgwfjq2jYgSsJDyYGq
        XM1UTAh4DU8RIOqwnhk2XA==
X-Google-Smtp-Source: ABdhPJxuHzH+IqaJFjpxSmZnR3V5wGp3HRGfFGUUEJOESPOJAfQKGPapqfE24wE16oUt84cf9LCAzw==
X-Received: by 2002:aca:c0c5:0:b0:325:9ed4:a240 with SMTP id q188-20020acac0c5000000b003259ed4a240mr2515515oif.289.1652965547373;
        Thu, 19 May 2022 06:05:47 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id y130-20020aca3288000000b00325cda1ff8dsm1834839oiy.12.2022.05.19.06.05.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 06:05:46 -0700 (PDT)
Received: (nullmailer pid 1359567 invoked by uid 1000);
        Thu, 19 May 2022 13:05:39 -0000
From:   Rob Herring <robh@kernel.org>
To:     Alec Su <ae40515@yahoo.com.tw>
Cc:     linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        bjorn.andersson@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, y.oudjana@protonmail.com,
        krzysztof.kozlowski+dt@linaro.org, agross@kernel.org,
        sboyd@codeaurora.org
In-Reply-To: <20220519074112.25600-3-ae40515@yahoo.com.tw>
References: <20220519074112.25600-1-ae40515@yahoo.com.tw> <20220519074112.25600-3-ae40515@yahoo.com.tw>
Subject: Re: [PATCH 2/2] dt-bindings: arm: qcom: Document xiaomi,natrium board
Date:   Thu, 19 May 2022 08:05:39 -0500
Message-Id: <1652965539.974526.1359566.nullmailer@robh.at.kernel.org>
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

On Thu, 19 May 2022 07:41:12 +0000, Alec Su wrote:
> Document Xiaomi Mi 5s Plus (xiaomi-natrium) smartphone which is based on
> Snapdragon 821 SoC.
> 
> Signed-off-by: Alec Su <ae40515@yahoo.com.tw>
> ---
>  Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/patch/


/: compatible: 'oneOf' conditional failed, one must be fixed:
	arch/arm64/boot/dts/qcom/msm8916-alcatel-idol347.dtb
	arch/arm64/boot/dts/qcom/msm8916-asus-z00l.dtb
	arch/arm64/boot/dts/qcom/msm8916-huawei-g7.dtb
	arch/arm64/boot/dts/qcom/msm8916-longcheer-l8150.dtb
	arch/arm64/boot/dts/qcom/msm8916-longcheer-l8910.dtb
	arch/arm64/boot/dts/qcom/msm8916-mtp.dtb
	arch/arm64/boot/dts/qcom/msm8916-samsung-j5.dtb
	arch/arm64/boot/dts/qcom/msm8916-samsung-serranove.dtb
	arch/arm64/boot/dts/qcom/msm8916-wingtech-wt88047.dtb
	arch/arm64/boot/dts/qcom/msm8994-huawei-angler-rev-101.dtb
	arch/arm64/boot/dts/qcom/msm8994-msft-lumia-octagon-cityman.dtb
	arch/arm64/boot/dts/qcom/msm8994-sony-xperia-kitakami-ivy.dtb
	arch/arm64/boot/dts/qcom/msm8994-sony-xperia-kitakami-karin.dtb
	arch/arm64/boot/dts/qcom/msm8994-sony-xperia-kitakami-satsuki.dtb
	arch/arm64/boot/dts/qcom/msm8994-sony-xperia-kitakami-sumire.dtb
	arch/arm64/boot/dts/qcom/msm8994-sony-xperia-kitakami-suzuran.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r1.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r1-lte.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r3.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r3-lte.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar-r2.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar-r3.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar-r4.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots-r4.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots-r5.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots-r9.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-r4.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-r9.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r0.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1-kb.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1-lte.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3-kb.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3-lte.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r9.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r9-kb.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r9-lte.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r1.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r1-lte.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r2.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r2-lte.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r3.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r3-lte.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-r1.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-r1-lte.dtb
	arch/arm64/boot/dts/qcom/sc7280-crd.dtb
	arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r0.dtb
	arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r1.dtb
	arch/arm64/boot/dts/qcom/sc7280-idp2.dtb
	arch/arm64/boot/dts/qcom/sc7280-idp.dtb
	arch/arm64/boot/dts/qcom/sm8150-hdk.dtb
	arch/arm64/boot/dts/qcom/sm8150-microsoft-surface-duo.dtb
	arch/arm64/boot/dts/qcom/sm8150-sony-xperia-kumano-bahamut.dtb
	arch/arm64/boot/dts/qcom/sm8150-sony-xperia-kumano-griffin.dtb
	arch/arm64/boot/dts/qcom/sm8250-hdk.dtb
	arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo-pdx203.dtb
	arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo-pdx206.dtb
	arch/arm64/boot/dts/qcom/sm8350-microsoft-surface-duo2.dtb
	arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami-pdx214.dtb
	arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami-pdx215.dtb
	arch/arm/boot/dts/qcom-msm8916-samsung-serranove.dtb

