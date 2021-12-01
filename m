Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C61994647E5
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 08:23:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347236AbhLAH0t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 02:26:49 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:52500 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347168AbhLAH0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 02:26:47 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 44566CE1D68;
        Wed,  1 Dec 2021 07:23:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14985C53FAD;
        Wed,  1 Dec 2021 07:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638343403;
        bh=QkDYnqLkhpOqGOf8REtEmrkoUi08AcwqoUU69C4hG64=;
        h=From:To:Cc:Subject:Date:From;
        b=CLNLhW2/CHpgb9eszwtFYwrlvYor2KX4jPLFowSflbgOCRT9M5Rdi7lC9zIkoIRVd
         T+j/zrpm/Y45tKRIF8d6YgyZ8gvxcgJ6YtqaUXIqSubs51Mo9sb6/1WZrl9SDAXbdc
         oepD7jw2ejaHlyY+NAUjiEMKqzLU64eOryHYEV3EuRP+/QuML+lsSyeYizvbtJ/eow
         3jCNu0EfyiGY5QXMCs8m5x6g4pT+J1R288neGYvCgFaqXi8y3EJEfP1/N3buRN0gFr
         K8vX4DGsR6CPFn6cOzuUUnKj95oRO2gRIU75EGymTpgZkXx8TGYbiTERD7rlnZ8QjN
         b/WUVn+FqumpQ==
From:   Vinod Koul <vkoul@kernel.org>
To:     Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Vamsi Krishna Lanka <quic_vamslank@quicinc.com>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] clk: qcom: Add clocks for SM8450 SoC
Date:   Wed,  1 Dec 2021 12:53:06 +0530
Message-Id: <20211201072310.3968679-1-vkoul@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds the GCC and RPMH clock support required for SM8450 SoC
along with devicetree binding for these clocks.

Please note that the GCC driver patch depends on new alpha LUCID_EVO
introduced by Vamsi in [1]. That would be required to be picked before this
patch can be applied.

[1]: https://lore.kernel.org/all/a0b04869a20a0afef99dd457ebb6474f50591210.1637302009.git.quic_vamslank@quicinc.com/

Vinod Koul (4):
  dt-bindings: clock: Add SM8450 GCC clock bindings
  dt-bindings: clock: Add RPMHCC bindings for SM8450
  clk: qcom: Add clock driver for SM8450
  clk: qcom: rpmh: add support for SM8450 rpmh clocks

 .../bindings/clock/qcom,gcc-sm8450.yaml       |   85 +
 .../bindings/clock/qcom,rpmhcc.yaml           |    1 +
 drivers/clk/qcom/Kconfig                      |    8 +
 drivers/clk/qcom/Makefile                     |    1 +
 drivers/clk/qcom/clk-rpmh.c                   |   27 +
 drivers/clk/qcom/gcc-sm8450.c                 | 3314 +++++++++++++++++
 include/dt-bindings/clock/qcom,gcc-sm8450.h   |  244 ++
 7 files changed, 3680 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,gcc-sm8450.yaml
 create mode 100644 drivers/clk/qcom/gcc-sm8450.c
 create mode 100644 include/dt-bindings/clock/qcom,gcc-sm8450.h

-- 
2.31.1

