Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6F9D50C632
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 03:48:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231661AbiDWBv1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 21:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbiDWBvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 21:51:23 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 250173587F;
        Fri, 22 Apr 2022 18:48:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 6A983CE2E18;
        Sat, 23 Apr 2022 01:48:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 912ACC385A0;
        Sat, 23 Apr 2022 01:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650678504;
        bh=hHFunL2zCFYg46oYKDc9LxdH0yRIK7MV5FENkAwkkGg=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=h02VcFEoyKQ4Fuk/0NtUF/t4IhPFhP/8lwznmwiJKzLEHvikMr/ueI/SnFS/dT/p6
         82wQgl7nmeiGUWQe53hoCipE0yHrvzPhkiojhKDm03E7h0Vtq1pfjgZ1Of1CDVnVdl
         jEOTYwnFqpwkj0xs5M2DA9CZda1FzG13SuTqhK19TEUm4Hf0nrDc95KLvQDFfgY70L
         wb1cHeIA4ocg7XwasMFFYKpHZfMCVikbR+Z2Z1+8WfgxHuI3Bs8lOrcSdGSI4hZ9bv
         LF8dbxZz2NlpQkaVQr4p1hWEtDbzPNg16V8k6V8lGyDEZJa3ooIzZZ5mMfk4LRStxP
         G13fDaWWxhfTg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220422230013.1332993-1-bjorn.andersson@linaro.org>
References: <20220422230013.1332993-1-bjorn.andersson@linaro.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: clock: Add Qualcomm SC8280XP GCC bindings
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_tdas@quicinc.com
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>
Date:   Fri, 22 Apr 2022 18:48:22 -0700
User-Agent: alot/0.10
Message-Id: <20220423014824.912ACC385A0@smtp.kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Bjorn Andersson (2022-04-22 16:00:12)
> Add binding for the Qualcomm SC8280XP Global Clock controller.
>=20
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Why no cover letter?

> diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-sc8280xp.ya=
ml b/Documentation/devicetree/bindings/clock/qcom,gcc-sc8280xp.yaml
> new file mode 100644
> index 000000000000..44e5f0d0a795
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/qcom,gcc-sc8280xp.yaml
> @@ -0,0 +1,199 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/qcom,gcc-sc8280xp.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm Global Clock & Reset Controller Binding for SC8280xp
> +
> +maintainers:
> +  - Bjorn Andersson <bjorn.andersson@linaro.org>
> +
> +description: |
> +  Qualcomm global clock control module which supports the clocks, resets=
 and
> +  power domains on SC8280xp.
> +
> +  See also:
> +  - dt-bindings/clock/qcom,gcc-sc8280xp.h
> +
> +properties:
> +  compatible:
> +    const: qcom,gcc-sc8280xp
> +
> +  clocks:
> +    items:
> +      - description: XO reference clock

"clock" is redundant in all these descriptions. Please remove.

> +      - description: Sleep clock
> +      - description: UFS memory first RX symbol clock
> +      - description: UFS memory second RX symbol clock
> +      - description: UFS memory first TX symbol clock
> +      - description: UFS card first RX symbol clock
> +      - description: UFS card second RX symbol clock
> +      - description: UFS card first TX symbol clock
> +      - description: Primary USB SuperSpeed pipe clock
> +      - description: gcc_usb4_phy_pipegmux_clk_src
> +      - description: gcc_usb4_phy_dp_gmux_clk_src
> +      - description: gcc_usb4_phy_sys_pipegmux_clk_src
> +      - description: usb4_phy_gcc_usb4_pcie_pipe_clk
> +      - description: usb4_phy_gcc_usb4rtr_max_pipe_clk
> +      - description: Primary USB4 RX0 clock
> +      - description: Primary USB4 RX1 clock
> +      - description: Secondary USB SuperSpeed pipe clock
> +      - description: gcc_usb4_1_phy_pipegmux_clk_src
> +      - description: gcc_usb4_1_phy_dp_gmux_clk_src
> +      - description: gcc_usb4_1_phy_sys_pipegmux_clk_src
> +      - description: usb4_1_phy_gcc_usb4_pcie_pipe_clk
> +      - description: usb4_1_phy_gcc_usb4rtr_max_pipe_clk
> +      - description: Secondary USB4 RX0 clock
> +      - description: Secondary USB4 RX0 clock
> +      - description: Multiport USB first SupserSpeed pipe clock
> +      - description: Multiport USB second SuperSpeed pipe clock
> +      - description: PCIe 2a pipe clock
> +      - description: PCIe 2b pipe clock
> +      - description: PCIe 3a pipe clock
> +      - description: PCIe 3b pipe clock
> +      - description: PCIe 4 pipe clock
> +      - description: First EMAC controller reference clock
> +      - description: Second EMAC controller reference clock
> +
> +  clock-names:
> +    items:
> +      - const: bi_tcxo
> +      - const: sleep_clk

And "_clk" postfix is redundant in all these strings. Remove?

> +      - const: ufs_phy_rx_symbol_0_clk
> +      - const: ufs_phy_rx_symbol_1_clk
> +      - const: ufs_phy_tx_symbol_0_clk
> +      - const: ufs_card_rx_symbol_0_clk
> +      - const: ufs_card_rx_symbol_1_clk
> +      - const: ufs_card_tx_symbol_0_clk
> +      - const: usb3_phy_wrapper_gcc_usb30_pipe_clk
> +      - const: gcc_usb4_phy_pipegmux_clk_src
> +      - const: gcc_usb4_phy_dp_gmux_clk_src
> +      - const: gcc_usb4_phy_sys_pipegmux_clk_src
> +      - const: usb4_phy_gcc_usb4_pcie_pipe_clk
> +      - const: usb4_phy_gcc_usb4rtr_max_pipe_clk
> +      - const: qusb4phy_gcc_usb4_rx0_clk
> +      - const: qusb4phy_gcc_usb4_rx1_clk
> +      - const: usb3_uni_phy_sec_gcc_usb30_pipe_clk
