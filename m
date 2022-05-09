Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82BBF51FC9F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 14:23:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234361AbiEIMZH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 08:25:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234252AbiEIMZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 08:25:00 -0400
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6551D2555B5;
        Mon,  9 May 2022 05:21:06 -0700 (PDT)
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-deb9295679so14476302fac.6;
        Mon, 09 May 2022 05:21:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=1YMoFaBHhMjLkXPx9UtGpLV3eh41Hk7kM5z0duwbKfM=;
        b=bUqgAB7+NzHB3P95FOidshZiFaQ9QrWVfMt2ul3PKRd1UHWPDBdPzj3Y0hk+peWLzq
         Ek/k4+pZYIzn6OZoU+/d1I9Ca67xDPatf5MqEEreWcWO9tw8kIzoWxuJUmDMOn+3fY7A
         Cf2vMgxgKnu5Mt7oX9ziKGBKST9c9FATehHlxKVb36klt0fXYGOazX+Lyh7R5AWdWx+K
         /uwQypb9T8xCY9r4DrXKAHrjxQ9g1Os3l2/UvRPI0BNdKnkloBzbgnODOtyIzQV6yEG/
         foh9WtrHkbLbxD8G9MS4WbsnrIWbiV5IJhBoTQRSSBBUT7urkM/7WJmN8UqAWEF2Sk+F
         aaKQ==
X-Gm-Message-State: AOAM530RChHgwjnn4qgUjveU8RRL8A8bsHedomu2N0rKl652u+XBaJQa
        7UkkgQIRJTM+mAsVCGlmbg==
X-Google-Smtp-Source: ABdhPJxrxqCw4xcwtmH1NwK0lTIRVic4gXA59v04MV73GhVQGdzYIMA1pMp2y/BEu14fL+6T/pBi9A==
X-Received: by 2002:a05:6871:5cb:b0:ed:b5ed:667d with SMTP id v11-20020a05687105cb00b000edb5ed667dmr7068789oan.47.1652098865669;
        Mon, 09 May 2022 05:21:05 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id d131-20020aca3689000000b003266a9846c0sm4303562oia.17.2022.05.09.05.21.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 May 2022 05:21:04 -0700 (PDT)
Received: (nullmailer pid 3576235 invoked by uid 1000);
        Mon, 09 May 2022 12:20:58 -0000
From:   Rob Herring <robh@kernel.org>
To:     Sibi Sankar <quic_sibis@quicinc.com>
Cc:     mka@chromium.org, swboyd@chromium.org,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        bjorn.andersson@linaro.org, robh+dt@kernel.org,
        mathieu.poirier@linaro.org, krzysztof.kozlowski@canonical.com,
        agross@kernel.org, dianders@chromium.org, ohad@wizery.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        evgreen@chromium.org
In-Reply-To: <1652082798-5855-2-git-send-email-quic_sibis@quicinc.com>
References: <1652082798-5855-1-git-send-email-quic_sibis@quicinc.com> <1652082798-5855-2-git-send-email-quic_sibis@quicinc.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: remoteproc: qcom: Add SC7280 MSS bindings
Date:   Mon, 09 May 2022 07:20:58 -0500
Message-Id: <1652098858.589911.3576234.nullmailer@robh.at.kernel.org>
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

On Mon, 09 May 2022 13:23:17 +0530, Sibi Sankar wrote:
> Add MSS PIL loading bindings for SC7280 SoCs.
> 
> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
> ---
>  .../bindings/remoteproc/qcom,sc7280-mss-pil.yaml   | 261 +++++++++++++++++++++
>  1 file changed, 261 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,sc7280-mss-pil.yaml
> 

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/patch/


remoteproc@4080000: clock-names:1: 'snoc_axi' was expected
	arch/arm64/boot/dts/qcom/sc7280-crd.dtb
	arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r0.dtb
	arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r1.dtb
	arch/arm64/boot/dts/qcom/sc7280-idp2.dtb
	arch/arm64/boot/dts/qcom/sc7280-idp.dtb

remoteproc@4080000: clock-names:2: 'offline' was expected
	arch/arm64/boot/dts/qcom/sc7280-crd.dtb
	arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r0.dtb
	arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r1.dtb
	arch/arm64/boot/dts/qcom/sc7280-idp2.dtb
	arch/arm64/boot/dts/qcom/sc7280-idp.dtb

remoteproc@4080000: 'interconnects' is a required property
	arch/arm64/boot/dts/qcom/sc7280-crd.dtb
	arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r0.dtb
	arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r1.dtb
	arch/arm64/boot/dts/qcom/sc7280-idp2.dtb
	arch/arm64/boot/dts/qcom/sc7280-idp.dtb

remoteproc@4080000: reset-names:1: 'pdc_sync' was expected
	arch/arm64/boot/dts/qcom/sc7280-crd.dtb
	arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r0.dtb
	arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r1.dtb
	arch/arm64/boot/dts/qcom/sc7280-idp2.dtb
	arch/arm64/boot/dts/qcom/sc7280-idp.dtb

