Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2E4E559FD0
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 20:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231652AbiFXR10 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 13:27:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231739AbiFXR0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 13:26:54 -0400
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB7352559B;
        Fri, 24 Jun 2022 10:26:45 -0700 (PDT)
Received: by mail-io1-f46.google.com with SMTP id z191so3373901iof.6;
        Fri, 24 Jun 2022 10:26:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=n2XNNHfnlSzPCpBxhAe6aF2TsSHsKDP/VUmQAtti+ps=;
        b=LkkIWWo9Vou612Jvm/ZNYmdNzmnusgkETjkk9tQRpmP+7HFW4C2tTTLGcfvFJp8ljx
         5Eq2u4wlDFg8LenV16TTfBFFNN4TkEvut1sj/UgZ1IhFeSWF5/a7/oo3hZotXtr/m+jV
         HLaaj022f244dviPqbbwlC340fg6fza8XWyjDrPl9+/certNkzAEArA7Sk7IqwUiAEtw
         RIjhwqZKw+QDjf0++UTrFvPIVC0urB+hg/zxD2LXCJUw2RnuFbbWs8IwVxBoEEYAPlb3
         VClnS/8m8hgVE0ttLS+tvF7jUCtGL1eLUUQywdhMOWBUgFZO5/C0548kRNYUCRY8THMk
         er2Q==
X-Gm-Message-State: AJIora/uqdn5JjtJenggTV36v7myioHtklYgbNwUMbe7JCqBxRZ3TpA2
        nZHW8LLXtmt3MFCedD9IdA==
X-Google-Smtp-Source: AGRyM1sf4ha7eK26cIM7jLNomU3rhP57Kcz5dGvzHk+OKIszOwQIVSEmCb7pX+/RoCjgFzkNOR6bYA==
X-Received: by 2002:a05:6638:4889:b0:331:b103:a74c with SMTP id ct9-20020a056638488900b00331b103a74cmr158177jab.66.1656091604724;
        Fri, 24 Jun 2022 10:26:44 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id p70-20020a022949000000b00339d2cd8da1sm1274202jap.152.2022.06.24.10.26.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jun 2022 10:26:44 -0700 (PDT)
Received: (nullmailer pid 146350 invoked by uid 1000);
        Fri, 24 Jun 2022 17:26:34 -0000
From:   Rob Herring <robh@kernel.org>
To:     Sricharan R <quic_srichara@quicinc.com>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, quic_varada@quicinc.com,
        linus.walleij@linaro.org, catalin.marinas@arm.com,
        mturquette@baylibre.com, robh+dt@kernel.org,
        p.zabel@pengutronix.de, linux-clk@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, sboyd@kernel.org,
        bjorn.andersson@linaro.org, linux-arm-msm@vger.kernel.org,
        agross@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20220621161126.15883-3-quic_srichara@quicinc.com>
References: <20220621161126.15883-1-quic_srichara@quicinc.com> <20220621161126.15883-3-quic_srichara@quicinc.com>
Subject: Re: [PATCH V2 2/8] dt-bindings: arm64: ipq5018: Add binding descriptions for clock and reset
Date:   Fri, 24 Jun 2022 11:26:34 -0600
Message-Id: <1656091594.420060.146349.nullmailer@robh.at.kernel.org>
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

On Tue, 21 Jun 2022 21:41:20 +0530, Sricharan R wrote:
> From: Varadarajan Narayanan <quic_varada@quicinc.com>
> 
> This patch adds support for the global clock controller found on
> the IPQ5018 based devices.
> 
> Co-developed-by: Sricharan R <quic_srichara@quicinc.com>
> Signed-off-by: Sricharan R <quic_srichara@quicinc.com>
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
>  .../bindings/clock/qcom,gcc-other.yaml        |   3 +
>  include/dt-bindings/clock/qcom,gcc-ipq5018.h  | 188 ++++++++++++++++++
>  include/dt-bindings/reset/qcom,gcc-ipq5018.h  | 122 ++++++++++++
>  3 files changed, 313 insertions(+)
>  create mode 100644 include/dt-bindings/clock/qcom,gcc-ipq5018.h
>  create mode 100644 include/dt-bindings/reset/qcom,gcc-ipq5018.h
> 

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/patch/


gcc@1800000: '#power-domain-cells' is a required property
	arch/arm64/boot/dts/qcom/ipq6018-cp01-c1.dtb

gcc@1800000: Unevaluated properties are not allowed ('#clock-cells', '#reset-cells', 'clock-names', 'clocks', 'reg' were unexpected)
	arch/arm64/boot/dts/qcom/ipq6018-cp01-c1.dtb

