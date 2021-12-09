Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C70A46E6A4
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 11:35:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233775AbhLIKiv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 05:38:51 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:53910 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbhLIKiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 05:38:50 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id CBF47CE2578;
        Thu,  9 Dec 2021 10:35:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D382C004DD;
        Thu,  9 Dec 2021 10:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639046114;
        bh=JbtjuPbBb+JNf+a9pC7VQYkM08YoaZ7tren7tIQJZ1g=;
        h=From:To:Cc:Subject:Date:From;
        b=I5Yfa4LKpnDHFZw5hSt3Wstl9A21xTfToKjD6sCFdb0hgBrUgq+BSPoGwQHaOlIMV
         VQI9TG0xpaZkUND3G/jZz1VBYhpIBaufgkuADpxtlKW4O0hTubNu86N3JHY2AOTt0I
         MmmQGi2KxX7z4B8C3CPV91MUB2DZ7POxTtSnjoPfzd0w267m2zI4hpZepn25Hf4M1b
         QlxF3WR8SxGecikNI9p7ugR3r9kWV3UO/00kGmwZhuZ6Q2kli+VPR9Z6lMp2B0WOEr
         SpSZmt2YQqPZNWaiamVeVGBbyYGx8G9R+9p03eQM/050MVcFxf4y6LKDmBqccTQXON
         VCX+4s+f+k3zg==
From:   Vinod Koul <vkoul@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 00/13] arm64: dts: qcom: Add support for SM8450 SoC and QRD board
Date:   Thu,  9 Dec 2021 16:04:52 +0530
Message-Id: <20211209103505.197453-1-vkoul@kernel.org>
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

Vinod Koul (10):
  arm64: dts: qcom: Add base SM8450 DTSI
  arm64: dts: qcom: sm8450: Add tlmm nodes
  arm64: dts: qcom: sm8450: Add reserved memory nodes
  arm64: dts: qcom: sm8450: add smmu nodes
  arm64: dts: qcom: Add base SM8450 QRD DTS
  arm64: dts: qcom: sm8450-qrd: Add rpmh regulator nodes
  arm64: dts: qcom: sm8450: add ufs nodes
  arm64: dts: qcom: sm8450-qrd: enable ufs nodes
  arm64: dts: qcom: sm8450: add interconnect nodes
  arm64: dts: qcom: sm8450: add spmi node

Vladimir Zapolskiy (1):
  arm64: dts: qcom: sm8450: add cpufreq support

 arch/arm64/boot/dts/qcom/Makefile       |    1 +
 arch/arm64/boot/dts/qcom/sm8450-qrd.dts |  378 ++++++++
 arch/arm64/boot/dts/qcom/sm8450.dtsi    | 1125 +++++++++++++++++++++++
 3 files changed, 1504 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/sm8450-qrd.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sm8450.dtsi

-- 
2.31.1

