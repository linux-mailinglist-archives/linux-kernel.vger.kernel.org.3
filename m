Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD244CBEB6
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 14:18:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233439AbiCCNTS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 08:19:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232506AbiCCNTP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 08:19:15 -0500
Received: from relay07.th.seeweb.it (relay07.th.seeweb.it [5.144.164.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50550149B85;
        Thu,  3 Mar 2022 05:18:30 -0800 (PST)
Received: from Marijn-Arch-PC.localdomain (94-209-165-62.cable.dynamic.v4.ziggo.nl [94.209.165.62])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 4F3AD3F635;
        Thu,  3 Mar 2022 14:18:28 +0100 (CET)
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     phone-devel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Pavel Dubrova <pashadubrova@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Vamsi Krishna Lanka <quic_vamslank@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/3] clk: qcom: Add display clock controller driver for SM6125
Date:   Thu,  3 Mar 2022 14:18:09 +0100
Message-Id: <20220303131812.302302-1-marijn.suijten@somainline.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v2:
- dt-bindings: Use a sensible `&dsi1_phy 1` example clock for the
  mandatory "dsi1_phy_pll_out_dsiclk", instead of a null phandle.

v2: https://lore.kernel.org/phone-devel/20220226200911.230030-1-marijn.suijten@somainline.org/

Changes since v1:
- Documentation is dual-licensed;
- Documentation example now uses zero-clock for dsi1_phy pixel clock;
- SDX_GCC_65 is sorted in Kconfig/Makefile to easen adding this driver
  in the correct alphabetic spot;
- clk.h is replaced with clk-provider.h;
- ahb, mdp and rot source clocks use rcg2_shared_ops instead of standard
  ops;
- Unnecessary line breaks are removed when remaining under 80 chars.

v1: https://lore.kernel.org/linux-arm-msm/20211130212137.25303-1-martin.botka@somainline.org/T/#u

Marijn Suijten (1):
  clk: qcom: Fix sorting of SDX_GCC_65 in Makefile and Kconfig

Martin Botka (2):
  dt-bindings: clock: add QCOM SM6125 display clock bindings
  clk: qcom: Add display clock controller driver for SM6125

 .../bindings/clock/qcom,dispcc-sm6125.yaml    |  87 +++
 drivers/clk/qcom/Kconfig                      |  21 +-
 drivers/clk/qcom/Makefile                     |   3 +-
 drivers/clk/qcom/dispcc-sm6125.c              | 709 ++++++++++++++++++
 .../dt-bindings/clock/qcom,dispcc-sm6125.h    |  41 +
 5 files changed, 854 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,dispcc-sm6125.yaml
 create mode 100644 drivers/clk/qcom/dispcc-sm6125.c
 create mode 100644 include/dt-bindings/clock/qcom,dispcc-sm6125.h


base-commit: e6ada6df471f847da3b09b357e246c62335bc0bb
--
2.35.1

