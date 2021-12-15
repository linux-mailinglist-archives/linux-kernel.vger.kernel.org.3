Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E8B94751A6
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 05:34:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239721AbhLOEe4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 23:34:56 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:51400 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236512AbhLOEez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 23:34:55 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6C2B7617D6;
        Wed, 15 Dec 2021 04:34:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32055C34600;
        Wed, 15 Dec 2021 04:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639542893;
        bh=undEf/ZeWMt+6rCXPdfTccv22XIYHhICTWGax4E81Gg=;
        h=From:To:Cc:Subject:Date:From;
        b=iPbk7iLwqmxBAIn+/mAdDuaa1s9N813ZnSre/3zDmw4YR+PSyBIuWFybAKb11xlVF
         UJg/EfKk6c8+IRTu3aZmxMbxMfsK66cfP/gwGPHE7SssCzlQbdbGKcjQr9nG/oCveQ
         baQSAE5P3KVYlI8rqVfv7NwroFOmiR5jzJvsxAut6xRNqf2zky36Es8CbqQeVEeSYC
         neIQPAnk8ofIWiGFfsGO87wP7vk2eoytB49Zz/hjrWYW7ZFMSYma9lsSVBfz4tLz8/
         PF4tAG89nNFrjHWTh8aqiAbxHAo1ZFvjcocBhKVs43AvIWgXBAVzY3JMaPYCfIRgiV
         ODPpeBmGQjkEg==
From:   Vinod Koul <vkoul@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 00/11] arm64: dts: qcom: Add support for SM8450 SoC and
Date:   Wed, 15 Dec 2021 10:04:29 +0530
Message-Id: <20211215043440.605624-1-vkoul@kernel.org>
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

Changes in v3:
 - drop spmi and icc patches
 - add the tags recieved

Changes in v2:
 - add the acks recieved
 - move gpio header include to soc dts
 - fix the uart node name
 - rework pinctrol nodes
 - drop cpu clusters
 - fix consistency in nodes for reserved mem and icc
 - Squash some patches into qrd dts patches

Dmitry Baryshkov (2):
  arm64: dts: qcom: sm8450: Add rpmhpd node
  arm64: dts: qcom: sm8450: add i2c13 and i2c14 device nodes

Vinod Koul (8):
  arm64: dts: qcom: Add base SM8450 DTSI
  arm64: dts: qcom: sm8450: Add tlmm nodes
  arm64: dts: qcom: sm8450: Add reserved memory nodes
  arm64: dts: qcom: sm8450: add smmu nodes
  arm64: dts: qcom: Add base SM8450 QRD DTS
  arm64: dts: qcom: sm8450-qrd: Add rpmh regulator nodes
  arm64: dts: qcom: sm8450: add ufs nodes
  arm64: dts: qcom: sm8450-qrd: enable ufs nodes

Vladimir Zapolskiy (1):
  arm64: dts: qcom: sm8450: add cpufreq support

 arch/arm64/boot/dts/qcom/Makefile       |    1 +
 arch/arm64/boot/dts/qcom/sm8450-qrd.dts |  375 +++++++++
 arch/arm64/boot/dts/qcom/sm8450.dtsi    | 1026 +++++++++++++++++++++++
 3 files changed, 1402 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/sm8450-qrd.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sm8450.dtsi

-- 
2.31.1

