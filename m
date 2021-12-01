Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 952A8464804
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 08:24:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241439AbhLAH2J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 02:28:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbhLAH2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 02:28:08 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5736C061574;
        Tue, 30 Nov 2021 23:24:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 0BF38CE1C91;
        Wed,  1 Dec 2021 07:24:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E38AC53FCC;
        Wed,  1 Dec 2021 07:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638343484;
        bh=Ft/hd/e4uhaI+cG19AXoZx57rLs1d9wyTjoblMySAHc=;
        h=From:To:Cc:Subject:Date:From;
        b=JTSyVBihQk1De3dCpBOIGcAivGgoa+bHQIj/wkJtj+kyZaF15DDxDxd4iw3/v1UaB
         2RYkAhke4etPCcvLgcgBPzwMIgj+tC/olWx6wdQ+rfwtts5HvnjgoMyhA30ZpE0dXb
         tZYSFXS/QHg7j+cDICFFbCSkvBI0Q5BiwsHRHKBW9CUQ61QHXYkYMQsGyEWJ38pc+G
         xTEJkpvbAUM8q476H5PNAYyqo/toiZMXrl5O08kVMcKOCSdkqzUYzaFRNV3gOw0+2R
         fetL67JsHX4j7ZO8FWX62jCV1Nm6Ftj6LtDsPfAP9/cMXJrnmtuEf2SB1GDog70lpV
         StmfTFhJCq+oA==
From:   Vinod Koul <vkoul@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] pinctrl: qcom: Add SM8450 pinctrl
Date:   Wed,  1 Dec 2021 12:54:32 +0530
Message-Id: <20211201072434.3968768-1-vkoul@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for TLMM block found in SM8450 SoC. Add the binding
for the TLMM block followed by the driver for this.

Vinod Koul (2):
  dt-bindings: pinctrl: qcom: Add SM8450 pinctrl bindings
  pinctrl: qcom: Add SM8450 pinctrl driver

 .../bindings/pinctrl/qcom,sm8450-pinctrl.yaml |  143 ++
 drivers/pinctrl/qcom/Kconfig                  |    9 +
 drivers/pinctrl/qcom/Makefile                 |    1 +
 drivers/pinctrl/qcom/pinctrl-sm8450.c         | 1689 +++++++++++++++++
 4 files changed, 1842 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,sm8450-pinctrl.yaml
 create mode 100644 drivers/pinctrl/qcom/pinctrl-sm8450.c

-- 
2.31.1

