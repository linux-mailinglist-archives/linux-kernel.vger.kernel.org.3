Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32BF046485D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 08:29:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347432AbhLAHcs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 02:32:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232254AbhLAHcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 02:32:47 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E02FEC061574;
        Tue, 30 Nov 2021 23:29:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 39316CE1D73;
        Wed,  1 Dec 2021 07:29:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A23BC53FAD;
        Wed,  1 Dec 2021 07:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638343763;
        bh=t3bNC3c6ZjeWZfOS3kzdCyceuti6Qo0imhU6iZf3EI0=;
        h=From:To:Cc:Subject:Date:From;
        b=YHcdCC3v6Xon9aOaOScLhUCfqV12YrxQ9YPIehfS7xtGI3zltwLft9/PN1yhxY4HD
         kdlD5JiXw5GWOMaH8OZxasOjFjczO1CBwsxC+y4EvDpZTPhIHUW6QzBAtMnJIpLhuf
         WLHBekpHIZz9B7rs7J4UE6mmXmSL2J3ZHCJ6vB710Xy9LBa1neugW0zGkCyRx9xKLV
         aqV6gJUn+tOuLYsi58l947AeVwMSY1/7b9Vdl2CggdvWrdlVzxfvazDtANTrmOVlwo
         mH1rZgMMv4wGEUHhlnVDJFfubYDDAkcXAHPvH2Bd54BLDzvM1N9n151WEmE7MZJHwS
         JQ+Rlalj22yDQ==
From:   Vinod Koul <vkoul@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 00/15] arm64: dts: qcom: Add support for SM8450 SoC and QRD board
Date:   Wed,  1 Dec 2021 12:59:00 +0530
Message-Id: <20211201072915.3969178-1-vkoul@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Snapdragon 8 Gen 1 Mobile Platform [1] (SM8450) is the latest Qualcomm SoC
announced today.

This series adds the DTS support including clocks, tlmm, smmu, regulators,
ufs, interconnects, pmics and cpufreq found in the SM8450 QRD board.

[1]: https://www.qualcomm.com/products/snapdragon-8-gen-1-mobile-platform

Dmitry Baryshkov (2):
  arm64: dts: qcom: sm8450: Add rpmhpd node
  arm64: dts: qcom: sm8450: add i2c13 and i2c14 device nodes

Vinod Koul (12):
  arm64: dts: qcom: Add base SM8450 DTSI
  arm64: dts: qcom: Add base SM8450 QRD DTS
  arm64: dts: qcom: sm8450: Add tlmm nodes
  arm64: dts: qcom: sm8450-qrd: Add reserved gpio range for QRD
  arm64: dts: qcom: sm8450: Add reserved memory nodes
  arm64: dts: qcom: sm8450: add smmu nodes
  arm64: dts: qcom: sm8450-qrd: Add rpmh regulator nodes
  arm64: dts: qcom: sm8450: add ufs nodes
  arm64: dts: qcom: sm8450-qrd: enable ufs nodes
  arm64: dts: qcom: sm8450: add interconnect nodes
  arm64: dts: qcom: sm8450: add spmi node
  arm64: dts: qcom: sm8450-qrd: include pmic files

Vladimir Zapolskiy (1):
  arm64: dts: qcom: sm8450: add cpufreq support

 arch/arm64/boot/dts/qcom/Makefile       |    1 +
 arch/arm64/boot/dts/qcom/sm8450-qrd.dts |  379 ++++++++
 arch/arm64/boot/dts/qcom/sm8450.dtsi    | 1142 +++++++++++++++++++++++
 3 files changed, 1522 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/sm8450-qrd.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sm8450.dtsi

-- 
2.31.1

