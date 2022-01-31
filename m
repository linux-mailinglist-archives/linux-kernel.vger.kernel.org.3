Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 513CE4A4D12
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 18:25:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380908AbiAaRZI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 12:25:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380008AbiAaRZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 12:25:02 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62384C06173D;
        Mon, 31 Jan 2022 09:25:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1B9EAB82BB7;
        Mon, 31 Jan 2022 17:25:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE5F5C340E8;
        Mon, 31 Jan 2022 17:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643649899;
        bh=kal1m8pOcNxLnVIO/+/2FQSMa/n2Th/4Q780syWmbwo=;
        h=From:To:Cc:Subject:Date:From;
        b=khieSGcpyJEgw7qxdry05F8O4AZr8T29wDWnR8okIkEYb/6UMoXwS9PpG2hY/YW63
         p7RfOpS29l7Qx673Q2tEzdSWG8flwyfeqgPaZu0KKJRLrlBri9QFci74jfVnyi2y4D
         RnRrop69A5Fhz1WruuaHMvf9LyxziBGdE8gJkBZUQ17k5QK1dUvYqet+QS0gTo8VUJ
         YPvQnf2vDl+e9syENQ2Ub8pt1LfJR4AfGPHuUMsm7gdFVZP5f9En9lHWoUwog1wJ2B
         65UUoXHBj5LZZLehAeBRA4qt2b+lfEMo7WKj9a2jBfyRhqL1kzlWXP6zLoDhlrhX6N
         TkV0r1dPkP0Jg==
From:   Vinod Koul <vkoul@kernel.org>
To:     Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        David Collins <quic_collinsd@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        David Dai <daidavid1@codeaurora.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] spmi: pmic-arb: Add support for PMIC v7 and yamlify binding
Date:   Mon, 31 Jan 2022 22:54:47 +0530
Message-Id: <20220131172450.2528065-1-vkoul@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

The is version 2 of support for PMIC v7. I have converted the binding to
yaml format and added a new property qcom,bus-id for supporting v7 and then
add driver changes for v7

Changes since v1:
 - Add yaml conversion patch and new binding
 - fix driver bug report by Jonathan

David Dai (1):
  spmi: pmic-arb: Add support for PMIC v7

Vinod Koul (2):
  dt-bindings: spmi: convert Qualcomm SPMI PMIC ARB to dtschema
  dt-bindings: spmi: Add qcom,bus-id

 .../bindings/spmi/qcom,spmi-pmic-arb.txt      |  65 -----
 .../bindings/spmi/qcom,spmi-pmic-arb.yaml     | 123 +++++++++
 drivers/spmi/spmi-pmic-arb.c                  | 233 ++++++++++++++++--
 3 files changed, 337 insertions(+), 84 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb.txt
 create mode 100644 Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb.yaml

-- 
2.31.1

