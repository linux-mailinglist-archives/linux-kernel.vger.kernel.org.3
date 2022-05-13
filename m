Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3475D5261F9
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 14:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380313AbiEMMdq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 08:33:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380289AbiEMMdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 08:33:37 -0400
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7FB5674D8;
        Fri, 13 May 2022 05:33:29 -0700 (PDT)
Received: by mail-oi1-f171.google.com with SMTP id w130so10010174oig.0;
        Fri, 13 May 2022 05:33:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=bWNNZ9BS0dFKmSNywVk/RYUdQbyr62FYM4q6Vs2L/NM=;
        b=Hy0SSDqAdpkoxW1uUVsMzCBlzG2mF3MLABNs19AWPdB9P7D5lbn69I7si9tHvBfAhS
         CJ5A20AAop+Li7tGFziHf/N3w9LFgI4Q9B4+HnVobmFm3LBuu/TiY+7Y3jO5A/6vOCRT
         by5EkecfajygZywgMRvFAojf7HtdvZc5ysBNSwfiRrNtz/4zWfGq3bdPbM2Nk0Zy+MvC
         L8rk8bUvdenBWsXjvO5GmjVBElxI+mzFV2q0WbG+CARPJc6TTHfNLoc3zZNiHZR8Smy3
         9EuLNo+GuIOQeFQ2SXpF3EhogTRUkV4eIuAsOQOI75+oRQ2uX4fu5qxv7rhrQMxatobD
         9U4Q==
X-Gm-Message-State: AOAM533cftWsNHScQRMnr9mo6RNc+w4HFhfsWvzq7M7XJ1pFOrlQomR4
        IDIcyKCX08bMyinYlTI5vA==
X-Google-Smtp-Source: ABdhPJy9g68/EPuUsyXU1h/DaMwrHOo5TFodw06tCWraheAODJX/FWpgAk2uAlrbesg9KgRRzQEXPw==
X-Received: by 2002:a05:6808:124c:b0:2f9:c7cf:146 with SMTP id o12-20020a056808124c00b002f9c7cf0146mr7462531oiv.54.1652445208111;
        Fri, 13 May 2022 05:33:28 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id i20-20020a4a8d94000000b0035eb4e5a6c5sm933295ook.27.2022.05.13.05.33.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 May 2022 05:33:27 -0700 (PDT)
Received: (nullmailer pid 85853 invoked by uid 1000);
        Fri, 13 May 2022 12:33:21 -0000
From:   Rob Herring <robh@kernel.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Rajendra Nayak <quic_rjendra@quicinc.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Alexandru M Stan <amstan@chromium.org>,
        Julius Werner <jwerner@chromium.org>,
        linux-arm-msm@vger.kernel.org,
        "Joseph S . Barrera III" <joebar@chromium.org>,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>
In-Reply-To: <20220512090429.2.I1318c1ae2ce55ade1d092fc21df846360b15c560@changeid>
References: <20220512090429.1.I9804fcd5d6c8552ab25f598dd7a3ea71b15b55f0@changeid> <20220512090429.2.I1318c1ae2ce55ade1d092fc21df846360b15c560@changeid>
Subject: Re: [PATCH 2/3] dt-bindings: arm: qcom: Add / fix sc7280 board bindings
Date:   Fri, 13 May 2022 07:33:21 -0500
Message-Id: <1652445201.115225.85852.nullmailer@robh.at.kernel.org>
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

On Thu, 12 May 2022 09:04:46 -0700, Douglas Anderson wrote:
> This copy-pastes compatibles from sc7280-based boards from the device
> trees to the yaml file. It also fixes the CRD/IDP bindings which had
> gotten stale.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> 
>  .../devicetree/bindings/arm/qcom.yaml         | 40 +++++++++++++++----
>  1 file changed, 33 insertions(+), 7 deletions(-)
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
	arch/arm64/boot/dts/qcom/sc7280-crd.dtb
	arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r0.dtb
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

