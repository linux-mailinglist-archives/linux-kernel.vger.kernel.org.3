Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27110524EB9
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 15:49:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354683AbiELNtr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 09:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354652AbiELNte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 09:49:34 -0400
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 364BA16A5EB;
        Thu, 12 May 2022 06:49:30 -0700 (PDT)
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-e93bbb54f9so6640584fac.12;
        Thu, 12 May 2022 06:49:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=44osJfDZTxqyRvw+yDA0ElCvyNoF+27tE2HeH+GqY60=;
        b=NIgM5nVyKaot2SDsB2SxiqkGy1rRaaKzRNpRAwuFWUljIOtvPTbouoOmzV3ZJCFbQE
         TchW1qEaJzLBesyThnr1+cfd3PXf8G5Ozr3OWhuud29QgUViD6Eh08ELRT223x0SOk1w
         bbh1YHU6gLpdJbhRzjUQxdNSbDapEzHdDYyb+WVs5HlcjB2/rk/deJC1yE8Lkv9Jvy4c
         NPPllxd5sO8N1rVjEaESXdByPUS81CszZQ1ntTKg/Hv9z5mcQL1MqmR4hWIMy377/ohr
         tsH1GqUoJEKBVThiGWrx5c+CWPQ0uqW99bruH6G7CqGXkIPaSW+E4L4/GFW5op9lPK6F
         9CuQ==
X-Gm-Message-State: AOAM53275tkWATZQmg+tc+BUMuo2tPCuhUkcnrJuiwNRZzQ7sghHOU6v
        RrTAayvr0dgpP+DnxqVAZwyKV59UfA==
X-Google-Smtp-Source: ABdhPJy3cXoh+zuU3l6JfF0ISzts0QdsIOVdGHEMPluSyoC9GNuEJmyOpAOT9vnc0UhmOIGKpDkCaw==
X-Received: by 2002:a05:6870:a79c:b0:e6:30d9:c7fc with SMTP id x28-20020a056870a79c00b000e630d9c7fcmr5460236oao.248.1652363369393;
        Thu, 12 May 2022 06:49:29 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id s12-20020a056830124c00b00606b1f72fcbsm1916347otp.31.2022.05.12.06.49.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 06:49:28 -0700 (PDT)
Received: (nullmailer pid 2231015 invoked by uid 1000);
        Thu, 12 May 2022 13:49:24 -0000
From:   Rob Herring <robh@kernel.org>
To:     Sireesh Kodali <sireeshkodali1@gmail.com>
Cc:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        phone-devel@vger.kernel.org, bjorn.andersson@linaro.org,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
In-Reply-To: <20220511161602.117772-7-sireeshkodali1@gmail.com>
References: <20220511161602.117772-1-sireeshkodali1@gmail.com> <20220511161602.117772-7-sireeshkodali1@gmail.com>
Subject: Re: [PATCH 6/9] dt-bindings: remoteproc: qcom: mss: Convert bindings to YAML
Date:   Thu, 12 May 2022 08:49:24 -0500
Message-Id: <1652363364.597474.2231014.nullmailer@robh.at.kernel.org>
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

On Wed, 11 May 2022 21:45:59 +0530, Sireesh Kodali wrote:
> Convert the bindings to YAML from txt. The bindings follow a similar
> schema to `qcom,adsp.yaml`.
> 
> Signed-off-by: Sireesh Kodali <sireeshkodali1@gmail.com>
> ---
>  .../bindings/remoteproc/qcom,q6v5.txt         | 302 --------
>  .../bindings/remoteproc/qcom,q6v5.yaml        | 702 ++++++++++++++++++
>  2 files changed, 702 insertions(+), 302 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
>  create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,q6v5.yaml
> 

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/patch/


remoteproc@4080000: memory-region: [[123], [124]] is too long
	arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r1.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r1-lte.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r3.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r3-lte.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots-r9.dtb

remoteproc@4080000: memory-region: [[124], [125]] is too long
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots-r4.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots-r5.dtb

remoteproc@4080000: memory-region: [[125], [126]] is too long
	arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar-r2.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar-r4.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-r9.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r9.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r9-kb.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r9-lte.dtb

remoteproc@4080000: memory-region: [[126], [127]] is too long
	arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar-r3.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-r4.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r0.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1-kb.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1-lte.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3-kb.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3-lte.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r1.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r1-lte.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r2.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r2-lte.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r3.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r3-lte.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-r1.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-r1-lte.dtb

remoteproc@4080000: memory-region: [[193], [194]] is too long
	arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r0.dtb

remoteproc@4080000: memory-region: [[200], [201]] is too long
	arch/arm64/boot/dts/qcom/sc7280-idp.dtb

remoteproc@4080000: memory-region: [[205], [206]] is too long
	arch/arm64/boot/dts/qcom/sc7280-idp2.dtb

remoteproc@4080000: memory-region: [[208], [209]] is too long
	arch/arm64/boot/dts/qcom/sc7280-crd.dtb

remoteproc@4080000: memory-region: [[213], [214]] is too long
	arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r1.dtb

remoteproc@4080000: memory-region: [[98], [99]] is too long
	arch/arm64/boot/dts/qcom/sc7180-idp.dtb

remoteproc@fc880000: 'power-domain-names' is a required property
	arch/arm/boot/dts/qcom-apq8074-dragonboard.dtb
	arch/arm/boot/dts/qcom-msm8974-fairphone-fp2.dtb
	arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dtb
	arch/arm/boot/dts/qcom-msm8974-samsung-klte.dtb
	arch/arm/boot/dts/qcom-msm8974-sony-xperia-amami.dtb
	arch/arm/boot/dts/qcom-msm8974-sony-xperia-castor.dtb
	arch/arm/boot/dts/qcom-msm8974-sony-xperia-honami.dtb

remoteproc@fc880000: 'power-domains' is a required property
	arch/arm/boot/dts/qcom-apq8074-dragonboard.dtb
	arch/arm/boot/dts/qcom-msm8974-fairphone-fp2.dtb
	arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dtb
	arch/arm/boot/dts/qcom-msm8974-samsung-klte.dtb
	arch/arm/boot/dts/qcom-msm8974-sony-xperia-amami.dtb
	arch/arm/boot/dts/qcom-msm8974-sony-xperia-castor.dtb
	arch/arm/boot/dts/qcom-msm8974-sony-xperia-honami.dtb

