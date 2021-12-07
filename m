Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 974DC46BA38
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 12:40:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235773AbhLGLnv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 06:43:51 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:50034 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231258AbhLGLnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 06:43:50 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 87EFFB8174B;
        Tue,  7 Dec 2021 11:40:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC3D5C341C3;
        Tue,  7 Dec 2021 11:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638877218;
        bh=s4wkP8QFJJDrpKObfWQlsbk6GV7MZa4F1T931fS2ovc=;
        h=From:To:Cc:Subject:Date:From;
        b=uQicVVwR5R3FFMcw/xf1Q1Rpp3kzB+592zmR4hgvYvWXU8r1JYd4RI/oiMDMDZH4R
         Pg2L/mO3YRmlnXEW0pfgyIFnQw19HLbw8eMBcDlakzJL5obfQJ3cC6qA4TTMdyKP24
         9ifEhdFJtkBcF3vAEH/lFEn70KHLqZPtTYKHcDgOSnM1OPwZKL4Dcufa41vgIU644M
         /kUfv2MPsP0c5qoGj8OIA9OlIYRaCuMw8rNyCGNUzvdjV80d2VqepckQSBk3puiO8z
         c7dylFapxjyJcW4MsG3Y5L8tFdSC4JHXD9xRn6NTqyYQScHvzYDit0B+Eg6fUv0shu
         7JiRfxQYdSkEA==
From:   Vinod Koul <vkoul@kernel.org>
To:     Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Vamsi Krishna Lanka <quic_vamslank@quicinc.com>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] clk: qcom: Add clocks for SM8450 SoC
Date:   Tue,  7 Dec 2021 17:10:01 +0530
Message-Id: <20211207114003.100693-1-vkoul@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds the GCC clock support required for SM8450 SoC
along with devicetree binding for these clocks.

Please note that the GCC driver patch depends on new alpha LUCID_EVO
introduced by Vamsi in [1]. That would be required to be picked before this
patch can be applied.

[1]: https://lore.kernel.org/all/a0b04869a20a0afef99dd457ebb6474f50591210.1637302009.git.quic_vamslank@quicinc.com/


Changes in v2:
 - Drop rpmhcc patches as they are picked by Bjorn
 - Fix the multi line comment and drop noise in probe
 - Remove .name in clocks coming from firmware

Vinod Koul (2):
  dt-bindings: clock: Add SM8450 GCC clock bindings
  clk: qcom: Add clock driver for SM8450

 .../bindings/clock/qcom,gcc-sm8450.yaml       |   85 +
 drivers/clk/qcom/Kconfig                      |    8 +
 drivers/clk/qcom/Makefile                     |    1 +
 drivers/clk/qcom/gcc-sm8450.c                 | 3303 +++++++++++++++++
 include/dt-bindings/clock/qcom,gcc-sm8450.h   |  244 ++
 5 files changed, 3641 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,gcc-sm8450.yaml
 create mode 100644 drivers/clk/qcom/gcc-sm8450.c
 create mode 100644 include/dt-bindings/clock/qcom,gcc-sm8450.h

-- 
2.31.1

