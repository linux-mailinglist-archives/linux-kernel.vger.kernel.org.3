Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CCBF50EC38
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 00:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235012AbiDYWnL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 18:43:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234222AbiDYWnJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 18:43:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1D2C13D56;
        Mon, 25 Apr 2022 15:40:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6C0DFB81B3B;
        Mon, 25 Apr 2022 22:40:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB7F3C385A4;
        Mon, 25 Apr 2022 22:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650926400;
        bh=h7RDfe2a3sJr2RK2cGF4nK3ZDfwiN2x7Q64bU+1Ban4=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=fNluzzAJeFvpiOSIejoB1hwIajiWamkuO3xqZ9lU3VQwwnBL18bSXnjGDQs4MO6RA
         LdOsjKB9vib366T34VA1UiuiHwZxZlpKZl8bJY0Sonu1c5Ib5GjDpCMrlp442Sv3p3
         h8ZuRCLS2uVbHbddQp7kzWVrbrpfIBHF/9sVJArWQ8rF+FSYCAexmkfP2QaQv2StJK
         9XyoJJLUnFa0GoxSR2vxCm179uEPnY5LteN2GwnXk6QiAozzmU5yMzPvB1sr7jTft9
         AK8N005F2FRo9aMlCum49qx1nNoIYGc5vCzz89ghLB8tCppS/PZ2VfxXNm25tr0kQ2
         OBkg1mDuNGazw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220425204001.710238-1-krzysztof.kozlowski@linaro.org>
References: <20220425204001.710238-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] dt-bindings: clock: qcom,gcc-apq8064: Fix typo in compatible and split apq8084
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 25 Apr 2022 15:39:58 -0700
User-Agent: alot/0.10
Message-Id: <20220425224000.CB7F3C385A4@smtp.kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Krzysztof Kozlowski (2022-04-25 13:40:01)
> The qcom,gcc-apq8064.yaml was meant to describe only APQ8064 and APQ8084
> should have slightly different bindings (without Qualcomm thermal sensor
> device).
>=20
> Fixes: a469bf89a009 ("dt-bindings: clock: simplify qcom,gcc-apq8064 Docum=
entation")
> Reported-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/clock/qcom,gcc-apq8064.yaml      |  4 +-
>  .../bindings/clock/qcom,gcc-apq8084.yaml      | 42 +++++++++++++++++++
>  2 files changed, 43 insertions(+), 3 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/clock/qcom,gcc-apq8=
084.yaml

If it's generated with 'format-patch -C -M' does it detect the copy?

>=20
> diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-apq8084.yam=
l b/Documentation/devicetree/bindings/clock/qcom,gcc-apq8084.yaml
> new file mode 100644
> index 000000000000..63d08e82b3d8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/qcom,gcc-apq8084.yaml
> @@ -0,0 +1,42 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/qcom,gcc-apq8084.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm Global Clock & Reset Controller Binding for APQ8084
> +
> +maintainers:
> +  - Stephen Boyd <sboyd@kernel.org>
> +  - Taniya Das <tdas@codeaurora.org>

Please fix Taniya's email quic_tdas@quicinc.com

> +
> +description: |
