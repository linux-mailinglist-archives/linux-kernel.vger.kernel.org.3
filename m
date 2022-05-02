Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DC145172B9
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 17:34:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385867AbiEBPhK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 11:37:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385845AbiEBPhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 11:37:06 -0400
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35765B876;
        Mon,  2 May 2022 08:33:34 -0700 (PDT)
Received: by mail-oi1-f175.google.com with SMTP id z8so15557863oix.3;
        Mon, 02 May 2022 08:33:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=9QpaRulQC8AZ5zscgH0b3hoaj7J3nz21/vBgYnNIPPw=;
        b=A34YmIoSqoP9CTq0wKg135ZVJvahHWsAVE1RR4RyUE6hQ8N5L3KsJDKmD1YsC8BZWL
         kP7F4lC5LP3im2kRdYuin1CMkldLvZPFhSx8M3BgWKflasGk4zbyrko8ht49kJAQVcb1
         6saL+Nme/pvLrO9rkZt9mZN2HJUUZDLj0CBUupQSAXmNC56kPS9YaNjXQ41zEj+OunXw
         1dFgOfFhkdzXkDQUSlqCoFDmJJ236/WrdngywkztkBt7i8Ty1Xb+PDawjhAY5bTu17I4
         rFtNXaFvkY6uFOLmjPB5N8MwkCETEfxPJHij89oAX3EewJ7naFJnXdaHy1/g8gENj7nv
         U7sg==
X-Gm-Message-State: AOAM533NZDun9zQMcfrNB8RoTMoc3F2JF7OiW/5YKHrkv/zGxraPdT8N
        ZuZTea7ZGGfqf/kPxt1O4g==
X-Google-Smtp-Source: ABdhPJyzHYFbKa+ShMBcN8tIiGZbPwlTNTmXObgr7xg/aexM3zqccLfj4GXReETanNcu+Ff8bVxnKA==
X-Received: by 2002:a05:6808:1786:b0:323:191:b107 with SMTP id bg6-20020a056808178600b003230191b107mr7626990oib.72.1651505611943;
        Mon, 02 May 2022 08:33:31 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id r4-20020a056830120400b0060603221240sm2950261otp.16.2022.05.02.08.33.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 08:33:31 -0700 (PDT)
Received: (nullmailer pid 1161775 invoked by uid 1000);
        Mon, 02 May 2022 15:33:29 -0000
From:   Rob Herring <robh@kernel.org>
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        bjorn.andersson@linaro.org, ulf.hansson@linaro.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        linux-mmc@vger.kernel.org, agross@kernel.org,
        bhupesh.linux@gmail.com
In-Reply-To: <20220429220833.873672-2-bhupesh.sharma@linaro.org>
References: <20220429220833.873672-1-bhupesh.sharma@linaro.org> <20220429220833.873672-2-bhupesh.sharma@linaro.org>
Subject: Re: [PATCH 1/4] dt-bindings: mmc/sdhci-msm: Convert bindings to yaml
Date:   Mon, 02 May 2022 10:33:29 -0500
Message-Id: <1651505609.486882.1161774.nullmailer@robh.at.kernel.org>
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

On Sat, 30 Apr 2022 03:38:30 +0530, Bhupesh Sharma wrote:
> Convert Qualcomm sdhci-msm devicetree binding to YAML.
> 
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Rob Herring <robh@kernel.org>
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> ---
>  .../devicetree/bindings/mmc/sdhci-msm.txt     | 123 -----------
>  .../devicetree/bindings/mmc/sdhci-msm.yaml    | 192 ++++++++++++++++++
>  2 files changed, 192 insertions(+), 123 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/mmc/sdhci-msm.txt
>  create mode 100644 Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> 

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/patch/


sdcc@7804000: clock-names:0: 'iface' was expected
	arch/arm64/boot/dts/qcom/qcs404-evb-1000.dtb
	arch/arm64/boot/dts/qcom/qcs404-evb-4000.dtb

sdcc@7804000: clock-names:1: 'core' was expected
	arch/arm64/boot/dts/qcom/qcs404-evb-1000.dtb
	arch/arm64/boot/dts/qcom/qcs404-evb-4000.dtb

sdhci@7824000: clock-names:0: 'iface' was expected
	arch/arm64/boot/dts/qcom/apq8016-sbc.dtb
	arch/arm64/boot/dts/qcom/msm8916-alcatel-idol347.dtb
	arch/arm64/boot/dts/qcom/msm8916-asus-z00l.dtb
	arch/arm64/boot/dts/qcom/msm8916-huawei-g7.dtb
	arch/arm64/boot/dts/qcom/msm8916-longcheer-l8150.dtb
	arch/arm64/boot/dts/qcom/msm8916-longcheer-l8910.dtb
	arch/arm64/boot/dts/qcom/msm8916-mtp.dtb
	arch/arm64/boot/dts/qcom/msm8916-samsung-a3u-eur.dtb
	arch/arm64/boot/dts/qcom/msm8916-samsung-a5u-eur.dtb
	arch/arm64/boot/dts/qcom/msm8916-samsung-j5.dtb
	arch/arm64/boot/dts/qcom/msm8916-samsung-serranove.dtb
	arch/arm64/boot/dts/qcom/msm8916-wingtech-wt88047.dtb
	arch/arm/boot/dts/qcom-apq8016-sbc.dtb
	arch/arm/boot/dts/qcom-msm8916-samsung-serranove.dtb

sdhci@7824000: clock-names:1: 'core' was expected
	arch/arm64/boot/dts/qcom/apq8016-sbc.dtb
	arch/arm64/boot/dts/qcom/msm8916-alcatel-idol347.dtb
	arch/arm64/boot/dts/qcom/msm8916-asus-z00l.dtb
	arch/arm64/boot/dts/qcom/msm8916-huawei-g7.dtb
	arch/arm64/boot/dts/qcom/msm8916-longcheer-l8150.dtb
	arch/arm64/boot/dts/qcom/msm8916-longcheer-l8910.dtb
	arch/arm64/boot/dts/qcom/msm8916-mtp.dtb
	arch/arm64/boot/dts/qcom/msm8916-samsung-a3u-eur.dtb
	arch/arm64/boot/dts/qcom/msm8916-samsung-a5u-eur.dtb
	arch/arm64/boot/dts/qcom/msm8916-samsung-j5.dtb
	arch/arm64/boot/dts/qcom/msm8916-samsung-serranove.dtb
	arch/arm64/boot/dts/qcom/msm8916-wingtech-wt88047.dtb
	arch/arm/boot/dts/qcom-apq8016-sbc.dtb
	arch/arm/boot/dts/qcom-msm8916-samsung-serranove.dtb

sdhci@7824900: clock-names:0: 'iface' was expected
	arch/arm64/boot/dts/qcom/ipq8074-hk01.dtb
	arch/arm64/boot/dts/qcom/ipq8074-hk10-c1.dtb
	arch/arm64/boot/dts/qcom/ipq8074-hk10-c2.dtb
	arch/arm/boot/dts/qcom-ipq4018-ap120c-ac-bit.dtb
	arch/arm/boot/dts/qcom-ipq4018-ap120c-ac.dtb
	arch/arm/boot/dts/qcom-ipq4018-jalapeno.dtb
	arch/arm/boot/dts/qcom-ipq4019-ap.dk01.1-c1.dtb
	arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1-c1.dtb
	arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1-c3.dtb
	arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1-c1.dtb
	arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1-c2.dtb

sdhci@7824900: clock-names:1: 'core' was expected
	arch/arm64/boot/dts/qcom/ipq8074-hk01.dtb
	arch/arm64/boot/dts/qcom/ipq8074-hk10-c1.dtb
	arch/arm64/boot/dts/qcom/ipq8074-hk10-c2.dtb
	arch/arm/boot/dts/qcom-ipq4018-ap120c-ac-bit.dtb
	arch/arm/boot/dts/qcom-ipq4018-ap120c-ac.dtb
	arch/arm/boot/dts/qcom-ipq4018-jalapeno.dtb
	arch/arm/boot/dts/qcom-ipq4019-ap.dk01.1-c1.dtb
	arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1-c1.dtb
	arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1-c3.dtb
	arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1-c1.dtb
	arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1-c2.dtb

sdhci@7824900: clock-names:2: 'xo' was expected
	arch/arm64/boot/dts/qcom/ipq8074-hk01.dtb
	arch/arm64/boot/dts/qcom/ipq8074-hk10-c1.dtb
	arch/arm64/boot/dts/qcom/ipq8074-hk10-c2.dtb

sdhci@7864000: clock-names:0: 'iface' was expected
	arch/arm64/boot/dts/qcom/apq8016-sbc.dtb
	arch/arm64/boot/dts/qcom/msm8916-alcatel-idol347.dtb
	arch/arm64/boot/dts/qcom/msm8916-asus-z00l.dtb
	arch/arm64/boot/dts/qcom/msm8916-huawei-g7.dtb
	arch/arm64/boot/dts/qcom/msm8916-longcheer-l8150.dtb
	arch/arm64/boot/dts/qcom/msm8916-longcheer-l8910.dtb
	arch/arm64/boot/dts/qcom/msm8916-mtp.dtb
	arch/arm64/boot/dts/qcom/msm8916-samsung-a3u-eur.dtb
	arch/arm64/boot/dts/qcom/msm8916-samsung-a5u-eur.dtb
	arch/arm64/boot/dts/qcom/msm8916-samsung-j5.dtb
	arch/arm64/boot/dts/qcom/msm8916-samsung-serranove.dtb
	arch/arm64/boot/dts/qcom/msm8916-wingtech-wt88047.dtb
	arch/arm/boot/dts/qcom-apq8016-sbc.dtb
	arch/arm/boot/dts/qcom-msm8916-samsung-serranove.dtb

sdhci@7864000: clock-names:1: 'core' was expected
	arch/arm64/boot/dts/qcom/apq8016-sbc.dtb
	arch/arm64/boot/dts/qcom/msm8916-alcatel-idol347.dtb
	arch/arm64/boot/dts/qcom/msm8916-asus-z00l.dtb
	arch/arm64/boot/dts/qcom/msm8916-huawei-g7.dtb
	arch/arm64/boot/dts/qcom/msm8916-longcheer-l8150.dtb
	arch/arm64/boot/dts/qcom/msm8916-longcheer-l8910.dtb
	arch/arm64/boot/dts/qcom/msm8916-mtp.dtb
	arch/arm64/boot/dts/qcom/msm8916-samsung-a3u-eur.dtb
	arch/arm64/boot/dts/qcom/msm8916-samsung-a5u-eur.dtb
	arch/arm64/boot/dts/qcom/msm8916-samsung-j5.dtb
	arch/arm64/boot/dts/qcom/msm8916-samsung-serranove.dtb
	arch/arm64/boot/dts/qcom/msm8916-wingtech-wt88047.dtb
	arch/arm/boot/dts/qcom-apq8016-sbc.dtb
	arch/arm/boot/dts/qcom-msm8916-samsung-serranove.dtb

sdhci@7c4000: clock-names:0: 'iface' was expected
	arch/arm64/boot/dts/qcom/sc7180-idp.dtb
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

sdhci@7c4000: clock-names:1: 'core' was expected
	arch/arm64/boot/dts/qcom/sc7180-idp.dtb
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

sdhci@8804000: clock-names:0: 'iface' was expected
	arch/arm64/boot/dts/qcom/sc7180-idp.dtb
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

sdhci@8804000: clock-names:1: 'core' was expected
	arch/arm64/boot/dts/qcom/sc7180-idp.dtb
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

sdhci@8804000: clocks: [[13, 70], [13, 71]] is too short
	arch/arm/boot/dts/qcom-sdx55-mtp.dtb
	arch/arm/boot/dts/qcom-sdx55-t55.dtb
	arch/arm/boot/dts/qcom-sdx55-telit-fn980-tlb.dtb

sdhci@c084000: clock-names:0: 'iface' was expected
	arch/arm64/boot/dts/qcom/sdm630-sony-xperia-ganges-kirin.dtb
	arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile-discovery.dtb
	arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile-pioneer.dtb
	arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile-voyager.dtb
	arch/arm64/boot/dts/qcom/sdm636-sony-xperia-ganges-mermaid.dtb
	arch/arm64/boot/dts/qcom/sdm660-xiaomi-lavender.dtb

sdhci@c084000: clock-names:1: 'core' was expected
	arch/arm64/boot/dts/qcom/sdm630-sony-xperia-ganges-kirin.dtb
	arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile-discovery.dtb
	arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile-pioneer.dtb
	arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile-voyager.dtb
	arch/arm64/boot/dts/qcom/sdm636-sony-xperia-ganges-mermaid.dtb
	arch/arm64/boot/dts/qcom/sdm660-xiaomi-lavender.dtb

sdhci@c0c4000: clock-names:0: 'iface' was expected
	arch/arm64/boot/dts/qcom/sdm630-sony-xperia-ganges-kirin.dtb
	arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile-discovery.dtb
	arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile-pioneer.dtb
	arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile-voyager.dtb
	arch/arm64/boot/dts/qcom/sdm636-sony-xperia-ganges-mermaid.dtb
	arch/arm64/boot/dts/qcom/sdm660-xiaomi-lavender.dtb

sdhci@c0c4000: clock-names:1: 'core' was expected
	arch/arm64/boot/dts/qcom/sdm630-sony-xperia-ganges-kirin.dtb
	arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile-discovery.dtb
	arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile-pioneer.dtb
	arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile-voyager.dtb
	arch/arm64/boot/dts/qcom/sdm636-sony-xperia-ganges-mermaid.dtb
	arch/arm64/boot/dts/qcom/sdm660-xiaomi-lavender.dtb

sdhci@c0c4000: interconnect-names:0: 'sdhc-ddr' was expected
	arch/arm64/boot/dts/qcom/sdm630-sony-xperia-ganges-kirin.dtb
	arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile-discovery.dtb
	arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile-pioneer.dtb
	arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile-voyager.dtb
	arch/arm64/boot/dts/qcom/sdm636-sony-xperia-ganges-mermaid.dtb
	arch/arm64/boot/dts/qcom/sdm660-xiaomi-lavender.dtb

sdhci@c0c4000: interconnect-names:1: 'cpu-sdhc' was expected
	arch/arm64/boot/dts/qcom/sdm630-sony-xperia-ganges-kirin.dtb
	arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile-discovery.dtb
	arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile-pioneer.dtb
	arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile-voyager.dtb
	arch/arm64/boot/dts/qcom/sdm636-sony-xperia-ganges-mermaid.dtb
	arch/arm64/boot/dts/qcom/sdm660-xiaomi-lavender.dtb

sdhci@f9824900: clock-names:0: 'iface' was expected
	arch/arm64/boot/dts/qcom/apq8094-sony-xperia-kitakami-karin_windy.dtb
	arch/arm64/boot/dts/qcom/msm8992-lg-bullhead-rev-101.dtb
	arch/arm64/boot/dts/qcom/msm8992-lg-bullhead-rev-10.dtb
	arch/arm64/boot/dts/qcom/msm8992-msft-lumia-octagon-talkman.dtb
	arch/arm64/boot/dts/qcom/msm8992-xiaomi-libra.dtb
	arch/arm64/boot/dts/qcom/msm8994-huawei-angler-rev-101.dtb
	arch/arm64/boot/dts/qcom/msm8994-msft-lumia-octagon-cityman.dtb
	arch/arm64/boot/dts/qcom/msm8994-sony-xperia-kitakami-ivy.dtb
	arch/arm64/boot/dts/qcom/msm8994-sony-xperia-kitakami-karin.dtb
	arch/arm64/boot/dts/qcom/msm8994-sony-xperia-kitakami-satsuki.dtb
	arch/arm64/boot/dts/qcom/msm8994-sony-xperia-kitakami-sumire.dtb
	arch/arm64/boot/dts/qcom/msm8994-sony-xperia-kitakami-suzuran.dtb
	arch/arm/boot/dts/qcom-apq8026-lg-lenok.dtb
	arch/arm/boot/dts/qcom-apq8074-dragonboard.dtb
	arch/arm/boot/dts/qcom-apq8084-ifc6540.dtb
	arch/arm/boot/dts/qcom-apq8084-mtp.dtb
	arch/arm/boot/dts/qcom-msm8226-samsung-s3ve3g.dtb
	arch/arm/boot/dts/qcom-msm8974-fairphone-fp2.dtb
	arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dtb
	arch/arm/boot/dts/qcom-msm8974-samsung-klte.dtb
	arch/arm/boot/dts/qcom-msm8974-sony-xperia-amami.dtb
	arch/arm/boot/dts/qcom-msm8974-sony-xperia-castor.dtb
	arch/arm/boot/dts/qcom-msm8974-sony-xperia-honami.dtb

sdhci@f9824900: clock-names:1: 'core' was expected
	arch/arm64/boot/dts/qcom/apq8094-sony-xperia-kitakami-karin_windy.dtb
	arch/arm64/boot/dts/qcom/msm8992-lg-bullhead-rev-101.dtb
	arch/arm64/boot/dts/qcom/msm8992-lg-bullhead-rev-10.dtb
	arch/arm64/boot/dts/qcom/msm8992-msft-lumia-octagon-talkman.dtb
	arch/arm64/boot/dts/qcom/msm8992-xiaomi-libra.dtb
	arch/arm64/boot/dts/qcom/msm8994-huawei-angler-rev-101.dtb
	arch/arm64/boot/dts/qcom/msm8994-msft-lumia-octagon-cityman.dtb
	arch/arm64/boot/dts/qcom/msm8994-sony-xperia-kitakami-ivy.dtb
	arch/arm64/boot/dts/qcom/msm8994-sony-xperia-kitakami-karin.dtb
	arch/arm64/boot/dts/qcom/msm8994-sony-xperia-kitakami-satsuki.dtb
	arch/arm64/boot/dts/qcom/msm8994-sony-xperia-kitakami-sumire.dtb
	arch/arm64/boot/dts/qcom/msm8994-sony-xperia-kitakami-suzuran.dtb
	arch/arm/boot/dts/qcom-apq8026-lg-lenok.dtb
	arch/arm/boot/dts/qcom-apq8074-dragonboard.dtb
	arch/arm/boot/dts/qcom-apq8084-ifc6540.dtb
	arch/arm/boot/dts/qcom-apq8084-mtp.dtb
	arch/arm/boot/dts/qcom-msm8226-samsung-s3ve3g.dtb
	arch/arm/boot/dts/qcom-msm8974-fairphone-fp2.dtb
	arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dtb
	arch/arm/boot/dts/qcom-msm8974-samsung-klte.dtb
	arch/arm/boot/dts/qcom-msm8974-sony-xperia-amami.dtb
	arch/arm/boot/dts/qcom-msm8974-sony-xperia-castor.dtb
	arch/arm/boot/dts/qcom-msm8974-sony-xperia-honami.dtb

sdhci@f9824900: clock-names:3: 'ice' was expected
	arch/arm/boot/dts/qcom-msm8974-samsung-klte.dtb
	arch/arm/boot/dts/qcom-msm8974-sony-xperia-castor.dtb

sdhci@f9824900: clock-names:4: 'bus' was expected
	arch/arm/boot/dts/qcom-msm8974-samsung-klte.dtb
	arch/arm/boot/dts/qcom-msm8974-sony-xperia-castor.dtb

sdhci@f9864900: clock-names:0: 'iface' was expected
	arch/arm/boot/dts/qcom-apq8026-lg-lenok.dtb
	arch/arm/boot/dts/qcom-apq8074-dragonboard.dtb
	arch/arm/boot/dts/qcom-msm8226-samsung-s3ve3g.dtb
	arch/arm/boot/dts/qcom-msm8974-fairphone-fp2.dtb
	arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dtb
	arch/arm/boot/dts/qcom-msm8974-samsung-klte.dtb
	arch/arm/boot/dts/qcom-msm8974-sony-xperia-amami.dtb
	arch/arm/boot/dts/qcom-msm8974-sony-xperia-castor.dtb
	arch/arm/boot/dts/qcom-msm8974-sony-xperia-honami.dtb

sdhci@f9864900: clock-names:1: 'core' was expected
	arch/arm/boot/dts/qcom-apq8026-lg-lenok.dtb
	arch/arm/boot/dts/qcom-apq8074-dragonboard.dtb
	arch/arm/boot/dts/qcom-msm8226-samsung-s3ve3g.dtb
	arch/arm/boot/dts/qcom-msm8974-fairphone-fp2.dtb
	arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dtb
	arch/arm/boot/dts/qcom-msm8974-samsung-klte.dtb
	arch/arm/boot/dts/qcom-msm8974-sony-xperia-amami.dtb
	arch/arm/boot/dts/qcom-msm8974-sony-xperia-castor.dtb
	arch/arm/boot/dts/qcom-msm8974-sony-xperia-honami.dtb

sdhci@f98a4900: clock-names:0: 'iface' was expected
	arch/arm64/boot/dts/qcom/apq8094-sony-xperia-kitakami-karin_windy.dtb
	arch/arm64/boot/dts/qcom/msm8992-lg-bullhead-rev-101.dtb
	arch/arm64/boot/dts/qcom/msm8992-lg-bullhead-rev-10.dtb
	arch/arm64/boot/dts/qcom/msm8992-msft-lumia-octagon-talkman.dtb
	arch/arm64/boot/dts/qcom/msm8992-xiaomi-libra.dtb
	arch/arm64/boot/dts/qcom/msm8994-huawei-angler-rev-101.dtb
	arch/arm64/boot/dts/qcom/msm8994-msft-lumia-octagon-cityman.dtb
	arch/arm64/boot/dts/qcom/msm8994-sony-xperia-kitakami-ivy.dtb
	arch/arm64/boot/dts/qcom/msm8994-sony-xperia-kitakami-karin.dtb
	arch/arm64/boot/dts/qcom/msm8994-sony-xperia-kitakami-satsuki.dtb
	arch/arm64/boot/dts/qcom/msm8994-sony-xperia-kitakami-sumire.dtb
	arch/arm64/boot/dts/qcom/msm8994-sony-xperia-kitakami-suzuran.dtb
	arch/arm/boot/dts/qcom-apq8026-lg-lenok.dtb
	arch/arm/boot/dts/qcom-apq8074-dragonboard.dtb
	arch/arm/boot/dts/qcom-apq8084-ifc6540.dtb
	arch/arm/boot/dts/qcom-apq8084-mtp.dtb
	arch/arm/boot/dts/qcom-msm8226-samsung-s3ve3g.dtb
	arch/arm/boot/dts/qcom-msm8974-fairphone-fp2.dtb
	arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dtb
	arch/arm/boot/dts/qcom-msm8974-samsung-klte.dtb
	arch/arm/boot/dts/qcom-msm8974-sony-xperia-amami.dtb
	arch/arm/boot/dts/qcom-msm8974-sony-xperia-castor.dtb
	arch/arm/boot/dts/qcom-msm8974-sony-xperia-honami.dtb

sdhci@f98a4900: clock-names:1: 'core' was expected
	arch/arm64/boot/dts/qcom/apq8094-sony-xperia-kitakami-karin_windy.dtb
	arch/arm64/boot/dts/qcom/msm8992-lg-bullhead-rev-101.dtb
	arch/arm64/boot/dts/qcom/msm8992-lg-bullhead-rev-10.dtb
	arch/arm64/boot/dts/qcom/msm8992-msft-lumia-octagon-talkman.dtb
	arch/arm64/boot/dts/qcom/msm8992-xiaomi-libra.dtb
	arch/arm64/boot/dts/qcom/msm8994-huawei-angler-rev-101.dtb
	arch/arm64/boot/dts/qcom/msm8994-msft-lumia-octagon-cityman.dtb
	arch/arm64/boot/dts/qcom/msm8994-sony-xperia-kitakami-ivy.dtb
	arch/arm64/boot/dts/qcom/msm8994-sony-xperia-kitakami-karin.dtb
	arch/arm64/boot/dts/qcom/msm8994-sony-xperia-kitakami-satsuki.dtb
	arch/arm64/boot/dts/qcom/msm8994-sony-xperia-kitakami-sumire.dtb
	arch/arm64/boot/dts/qcom/msm8994-sony-xperia-kitakami-suzuran.dtb
	arch/arm/boot/dts/qcom-apq8026-lg-lenok.dtb
	arch/arm/boot/dts/qcom-apq8074-dragonboard.dtb
	arch/arm/boot/dts/qcom-apq8084-ifc6540.dtb
	arch/arm/boot/dts/qcom-apq8084-mtp.dtb
	arch/arm/boot/dts/qcom-msm8226-samsung-s3ve3g.dtb
	arch/arm/boot/dts/qcom-msm8974-fairphone-fp2.dtb
	arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dtb
	arch/arm/boot/dts/qcom-msm8974-samsung-klte.dtb
	arch/arm/boot/dts/qcom-msm8974-sony-xperia-amami.dtb
	arch/arm/boot/dts/qcom-msm8974-sony-xperia-castor.dtb
	arch/arm/boot/dts/qcom-msm8974-sony-xperia-honami.dtb

