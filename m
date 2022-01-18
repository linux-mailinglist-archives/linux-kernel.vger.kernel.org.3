Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37C73491378
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 02:38:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243970AbiARBiN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 20:38:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231266AbiARBiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 20:38:11 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70B0CC061574;
        Mon, 17 Jan 2022 17:38:11 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id t24so72828619edi.8;
        Mon, 17 Jan 2022 17:38:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HTyWntryCBF4iZJRg4LVIdA30wsrAuLbxuCKj8lB+YA=;
        b=ZNnuZdnp4aH0xUTo2hVJ3oXzTIxQohV/RtSLFHEYvmOTZJuBrEY2GpF2XLKqjvZp8o
         wkWZDTPw0EPr4qq7Afc6HtUrQiUr4bzMhQvM9iNC1M++YUffmfYt3cHWzE658ruhkbNc
         tVMltG4qTYFyUPf/K1WazsXYxz6UMPOP8m7K0XB5AeZtkRK5pBLV3E1Zc9LMxMZqhTAC
         j67WQ6vhD6LCtZt4Or5gwruI7piplslFNFFZFu0HsBJ9Xp41ADCIm8U8JtZfiMTbruxy
         GiwK6nXM7+uG9rjd53UySclF5f4yqJE9wHJl3r4dOMAt4diMtQ6udG2v1CySODWYhXlQ
         SlMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HTyWntryCBF4iZJRg4LVIdA30wsrAuLbxuCKj8lB+YA=;
        b=V/3HuCNoQicwi+GQquDAdn2c+OQ3EouDK3malLFCWCfclnczgDPOi+DE59ooZnXTLs
         /E9tOxTzKnqHFNWXSMC44XXNxc57gwpZop2Wc1ArxdppKPyLRtpJBKPRf17PfntDjjtA
         R1wGRgjV3s5SUG4Liw2sGTek5KZ7dCrup4zFS05dnk6F2EB4zN2B60q2FPUzCuhCi2Mz
         tpkTf15r4KxiHDFsb9qntDJO2Gcak1Im3CH1jh5AAyHO/yBFB4nKOpx5JgTt1hWKNAWC
         pVgIMd8YMQUzDgHkTrRwpacOZCqov09raoTV6i1JPXAkf77Cjzr4xJBwowSH/QflJF+a
         CAQg==
X-Gm-Message-State: AOAM532wtqwaRrS3Xk4BlZlNNzYX/yj5b4gPj11B0yXsaMw9gP/fJ9Vc
        LOl2c2ETJe4IH6llVR+yvLA=
X-Google-Smtp-Source: ABdhPJzPwaA9CAKXi1XWNkYgNeLcX4kyhh2e9tQqMhJgVNOMwWHa09CnWK7qYu/M/LgBhEseEhljaQ==
X-Received: by 2002:a17:907:72d2:: with SMTP id du18mr18435031ejc.208.1642469889882;
        Mon, 17 Jan 2022 17:38:09 -0800 (PST)
Received: from localhost.localdomain (93-42-71-246.ip85.fastwebnet.it. [93.42.71.246])
        by smtp.googlemail.com with ESMTPSA id kj18sm3990675ejc.139.2022.01.17.17.38.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jan 2022 17:38:09 -0800 (PST)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ansuel Smith <ansuelsmth@gmail.com>
Subject: [PATCH 00/17] Multiple addition to ipq8064 dtsi
Date:   Tue, 18 Jan 2022 02:20:30 +0100
Message-Id: <20220118012051.21691-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This try to complete the ipq8064 dtsi and introduce 2 new dtsi
ipq8064-v2 and ipq8065. While some node are still missing (cpufreq node,
l2 scale node, fab scale node) this would add most of the missing node
to make ipq8064 actually usable.

Some of the changes are the fix for the pci IO that cause any secondary
wifi card with ath10k to fail init.
Adds regulators definition for RPM.
Adds many missing gsbi nodes used by all the devices.
Enable the usb phy by default as they are actually enabled internally by
xlate only if the dwc3 driver is used.
Add opp table and declare idle state for ipq8064.
Fix some dtc warning.

This also add the ipq8064-v2.0 dtsi and the ipq8065 dtsi used by more
recent devices based on this SoC.

Ansuel Smith (17):
  ARM: dts: qcom: add multiple missing pin definition for ipq8064
  ARM: dts: qcom: add gsbi6 missing definition for ipq8064
  ARM: dts: qcom: add missing rpm regulators and cells for ipq8064
  ARM: dts: qcom: add missing snps,dwmac compatible for gmac ipq8064
  ARM: dts: qcom: enable usb phy by default for ipq8064
  ARM: dts: qcom: reduce pci IO size to 64K for ipq8064
  ARM: dts: qcom: fix dtc warning for missing #address-cells for ipq8064
  ARM: dts: qcom: add smem node for ipq8064
  ARM: dts: qcom: add saw for l2 cache and kraitcc for ipq8064
  ARM: dts: qcom: add sic non secure node for ipq8064
  ARM: dts: qcom: fix and add some missing gsbi node for ipq8064
  ARM: dts: qcom: add opp table for cpu and l2 for ipq8064
  ARM: dts: qcom: add speedbin efuse nvmem binding
  ARM: dts: qcom: add multiple missing binding for cpu and l2 for
    ipq8064
  ARM: dts: qcom: remove redundant binding from ipq8064 rb3011 dts
  ARM: dts: qcom: add ipq8064-v2.0 dtsi
  ARM: dts: qcom: add ipq8065 dtsi

 arch/arm/boot/dts/qcom-ipq8064-rb3011.dts |  17 --
 arch/arm/boot/dts/qcom-ipq8064-v2.0.dtsi  |  70 +++++
 arch/arm/boot/dts/qcom-ipq8064.dtsi       | 344 +++++++++++++++++++++-
 arch/arm/boot/dts/qcom-ipq8065.dtsi       | 168 +++++++++++
 4 files changed, 568 insertions(+), 31 deletions(-)
 create mode 100644 arch/arm/boot/dts/qcom-ipq8064-v2.0.dtsi
 create mode 100644 arch/arm/boot/dts/qcom-ipq8065.dtsi

-- 
2.33.1

