Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B7394E3633
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 02:51:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235201AbiCVBwb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 21:52:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235123AbiCVBwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 21:52:23 -0400
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 072DF3CA41;
        Mon, 21 Mar 2022 18:50:56 -0700 (PDT)
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-de3f2a19c8so534594fac.1;
        Mon, 21 Mar 2022 18:50:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=XTfyRPLY4sQDF9c/z4SClSeH1b0qndTEbUDUXkbsYko=;
        b=Oh2ZuXmMDvKWDmVOUxy2cKxDelEFwz5Boc6nMkAL/ibQX8mP3HFr/bq3dAl3+ryAo7
         T2nWXTKC74zb3y2Bw4MccM9eE4m1D9sTi6LxAgM+d2l3FNEWFiZgc1pwe0YJuRE8anxK
         kxYwfTaXP7vMaRllgvTiBbDSIGJa+b158W7cWy3YzjEHrZcNtARg/BOOqTAuhILjtRVV
         hTMawHr81NgAqH9aOTw75UXJHvWpMqyJYBHb5zcHRlt+tGE/DTrghcydsiK4W1H80Lu+
         5DnjfF5G26r5dCvZkMyuETFyX20KKPn6dAcA5p5hpm4uDHJoWdJLJ/oWdvu1dTMLECxJ
         tTHg==
X-Gm-Message-State: AOAM531Nb+HPJx29RfAFSiSGhG4Vtxts1Tla2TpF+AH6HwPsFi9mskcN
        FkAZYjrsDDlW8Gmf+nDAzQ==
X-Google-Smtp-Source: ABdhPJyT3MqEyDnmJr8K80wACWutivY++wVNtSdLN2r4omm8urnCUa8ekYxR0ewYs7LLO7WNJDPtLw==
X-Received: by 2002:a05:6870:e99f:b0:dd:9ac0:309e with SMTP id r31-20020a056870e99f00b000dd9ac0309emr731157oao.123.1647913855209;
        Mon, 21 Mar 2022 18:50:55 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id 5-20020a056870100500b000ddac364643sm6557966oai.30.2022.03.21.18.50.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 18:50:54 -0700 (PDT)
Received: (nullmailer pid 941036 invoked by uid 1000);
        Tue, 22 Mar 2022 01:50:51 -0000
From:   Rob Herring <robh@kernel.org>
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
In-Reply-To: <20220321231548.14276-18-ansuelsmth@gmail.com>
References: <20220321231548.14276-1-ansuelsmth@gmail.com> <20220321231548.14276-18-ansuelsmth@gmail.com>
Subject: Re: [PATCH v6 17/18] dt-bindings: arm: msm: Convert kpss-gcc driver Documentation to yaml
Date:   Mon, 21 Mar 2022 20:50:51 -0500
Message-Id: <1647913851.222685.941035.nullmailer@robh.at.kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Mar 2022 00:15:47 +0100, Ansuel Smith wrote:
> Convert kpss-gcc driver Documentation to yaml. Since kpss-gcc expose a
> clock add the required '#clock-cells' binding while converting it.
> 
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> ---
>  .../bindings/arm/msm/qcom,kpss-gcc.txt        | 44 ------------
>  .../bindings/arm/msm/qcom,kpss-gcc.yaml       | 69 +++++++++++++++++++
>  2 files changed, 69 insertions(+), 44 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc.yaml
> 

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/patch/1607962


clock-controller@2011000: '#clock-cells' is a required property
	arch/arm/boot/dts/qcom-ipq8064-ap148.dt.yaml
	arch/arm/boot/dts/qcom-ipq8064-rb3011.dt.yaml

clock-controller@2011000: compatible:0: 'qcom,kpss-gcc' is not one of ['qcom,kpss-gcc-ipq8064', 'qcom,kpss-gcc-apq8064', 'qcom,kpss-gcc-msm8974', 'qcom,kpss-gcc-msm8960']
	arch/arm/boot/dts/qcom-ipq8064-ap148.dt.yaml
	arch/arm/boot/dts/qcom-ipq8064-rb3011.dt.yaml

clock-controller@2011000: compatible:1: 'qcom,kpss-gcc' was expected
	arch/arm/boot/dts/qcom-ipq8064-ap148.dt.yaml
	arch/arm/boot/dts/qcom-ipq8064-rb3011.dt.yaml

clock-controller@2011000: compatible: ['qcom,kpss-gcc', 'syscon'] is too short
	arch/arm/boot/dts/qcom-ipq8064-ap148.dt.yaml
	arch/arm/boot/dts/qcom-ipq8064-rb3011.dt.yaml

