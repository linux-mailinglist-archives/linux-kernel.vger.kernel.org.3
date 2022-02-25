Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F393D4C3D15
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 05:26:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237353AbiBYEZv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 23:25:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbiBYEZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 23:25:48 -0500
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9E35F542B
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 20:25:14 -0800 (PST)
Received: by mail-oo1-xc33.google.com with SMTP id w10-20020a4ae08a000000b0031bdf7a6d76so4747307oos.10
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 20:25:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XTFVYeIxY4qHYdeJotm+HhK/uSnIh4QQgLObwJyD53k=;
        b=DmqQBtaTsC3/PKqsuzdbWvQPRxWjUzug1YuhTJenWC0tbehRmipyZ9cC940PnJRUiO
         DqnfN5kbrynaTXFTQXKWhUdx6MWhV3LLHsXWbg1FtsMxc9rX5AT9tDr2KnNwXr6GJnd7
         tgJLOaY0Ga+cQ2w7+tV0P2LvA3FQd2i+bFHbn/gMEZnrAPE5gg87ML+8oMagUTDIDO7F
         TlyYZHguc80moaFVa4tLQYI86+WAqweIVNVhy3TY91T/nr6+oeFI0uP/JKxBCUqyo396
         TfLtJskjngIzmDwSzcIUfVF2duUHJSpIAxncpr4sQvEsRzwEXUYccCWvMFXUnp5CLlAh
         kL4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XTFVYeIxY4qHYdeJotm+HhK/uSnIh4QQgLObwJyD53k=;
        b=bwg9yiH8SLWQAIIBs/Dy7jb8DQORlaZfSKDAzuk9CC4aSsy/bZ0wfpu8qTlSd5gXPg
         EKtpZ24OZcU8vplS8RQtekKMpykDHKi9iaHQC3eOfuna+KlWKszMBDMrNcf3KUtJIzlF
         n5FgJtgbQv94Rmsf4jzaJc5Tua3w1lFTw0mH4w54qJ6teWNxft7ynZaA/1zuToV0v01G
         15jvA6p2WuBETEI+qg/Pko5s7rfUqHrqtkmTh5dWgj0P+kUJ24ErnPeWQaLMwmzdCw6T
         j5rWmNNJF03+VKpVBSfHIU1P60qaYecNSILvMW7EkRtlFoiD9bTxVkmrQHRa/w3ryOS2
         YHbg==
X-Gm-Message-State: AOAM532g2qka6b/2L0uCxg0c2104PATrTfiEBA14O2MgoGmmU98b4BxZ
        AedtWVIOTLMRQ10T5Lj5FvoH6Q==
X-Google-Smtp-Source: ABdhPJxCN2dBvNlExDU0TwvYwqpJIGMSe1N0L+4J8ODCWuryh04eY5r12J4qwfw/z14rmIhmebx9wg==
X-Received: by 2002:a05:6870:ed4b:b0:cd:7f91:e8d2 with SMTP id ex11-20020a056870ed4b00b000cd7f91e8d2mr575787oab.197.1645763113798;
        Thu, 24 Feb 2022 20:25:13 -0800 (PST)
Received: from ripper.. ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id s18-20020a0568301e1200b005af20e61469sm602013otr.18.2022.02.24.20.25.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 20:25:13 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Georgi Djakov <djakov@kernel.org>,
        Odelu Kukatla <okukatla@codeaurora.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] interconnect: qcom: Add SC8280XP interconnect provider
Date:   Thu, 24 Feb 2022 20:27:10 -0800
Message-Id: <20220225042710.2317732-2-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220225042710.2317732-1-bjorn.andersson@linaro.org>
References: <20220225042710.2317732-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Qualcomm SC8280XP provides the means for the OS to request bus
bandwidth using RPMh. It consists of providers for each of the busses in
the SoC and two virtual providers, for the "memory controller" and a few
of "virtual clocks".

In this initial contribution PCIe is marked keep alive, as the platform
does not yet have PCIe support and as syncstate votes for 0 bandwidth on
the PCI0 BCM the SA8540P ADP locks up. Once PCIe has been implemented
it's expected that the keepalive can be dropped again.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/interconnect/qcom/Kconfig    |    9 +
 drivers/interconnect/qcom/Makefile   |    2 +
 drivers/interconnect/qcom/sc8280xp.c | 2443 ++++++++++++++++++++++++++
 drivers/interconnect/qcom/sc8280xp.h |  209 +++
 4 files changed, 2663 insertions(+)
 create mode 100644 drivers/interconnect/qcom/sc8280xp.c
 create mode 100644 drivers/interconnect/qcom/sc8280xp.h

diff --git a/drivers/interconnect/qcom/Kconfig b/drivers/interconnect/qcom/Kconfig
index 91353e651a52..36a55e6f13b1 100644
--- a/drivers/interconnect/qcom/Kconfig
+++ b/drivers/interconnect/qcom/Kconfig
@@ -110,6 +110,15 @@ config INTERCONNECT_QCOM_SC8180X
 	  This is a driver for the Qualcomm Network-on-Chip on sc8180x-based
 	  platforms.
 
+config INTERCONNECT_QCOM_SC8280XP
+	tristate "Qualcomm SC8280XP interconnect driver"
+	depends on INTERCONNECT_QCOM_RPMH_POSSIBLE
+	select INTERCONNECT_QCOM_RPMH
+	select INTERCONNECT_QCOM_BCM_VOTER
+	help
+	  This is a driver for the Qualcomm Network-on-Chip on SC8280XP-based
+	  platforms.
+
 config INTERCONNECT_QCOM_SDM660
 	tristate "Qualcomm SDM660 interconnect driver"
 	depends on INTERCONNECT_QCOM
diff --git a/drivers/interconnect/qcom/Makefile b/drivers/interconnect/qcom/Makefile
index ceae9bb566c6..d9318bb7bbb4 100644
--- a/drivers/interconnect/qcom/Makefile
+++ b/drivers/interconnect/qcom/Makefile
@@ -12,6 +12,7 @@ icc-rpmh-obj				:= icc-rpmh.o
 qnoc-sc7180-objs			:= sc7180.o
 qnoc-sc7280-objs                        := sc7280.o
 qnoc-sc8180x-objs			:= sc8180x.o
+qnoc-sc8280xp-objs			:= sc8280xp.o
 qnoc-sdm660-objs			:= sdm660.o
 qnoc-sdm845-objs			:= sdm845.o
 qnoc-sdx55-objs				:= sdx55.o
@@ -33,6 +34,7 @@ obj-$(CONFIG_INTERCONNECT_QCOM_RPMH) += icc-rpmh.o
 obj-$(CONFIG_INTERCONNECT_QCOM_SC7180) += qnoc-sc7180.o
 obj-$(CONFIG_INTERCONNECT_QCOM_SC7280) += qnoc-sc7280.o
 obj-$(CONFIG_INTERCONNECT_QCOM_SC8180X) += qnoc-sc8180x.o
+obj-$(CONFIG_INTERCONNECT_QCOM_SC8280XP) += qnoc-sc8280xp.o
 obj-$(CONFIG_INTERCONNECT_QCOM_SDM660) += qnoc-sdm660.o
 obj-$(CONFIG_INTERCONNECT_QCOM_SDM845) += qnoc-sdm845.o
 obj-$(CONFIG_INTERCONNECT_QCOM_SDX55) += qnoc-sdx55.o
diff --git a/drivers/interconnect/qcom/sc8280xp.c b/drivers/interconnect/qcom/sc8280xp.c
new file mode 100644
index 000000000000..de8a3693977d
--- /dev/null
+++ b/drivers/interconnect/qcom/sc8280xp.c
@@ -0,0 +1,2443 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2021, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2022, Linaro Ltd
+ */
+
+#include <linux/device.h>
+#include <linux/interconnect.h>
+#include <linux/interconnect-provider.h>
+#include <linux/module.h>
+#include <linux/of_platform.h>
+#include <dt-bindings/interconnect/qcom,sc8280xp.h>
+
+#include "bcm-voter.h"
+#include "icc-rpmh.h"
+#include "sc8280xp.h"
+
+static struct qcom_icc_node qhm_qspi = {
+	.name = "qhm_qspi",
+	.id = SC8280XP_MASTER_QSPI_0,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SC8280XP_SLAVE_A1NOC_SNOC },
+};
+
+static struct qcom_icc_node qhm_qup1 = {
+	.name = "qhm_qup1",
+	.id = SC8280XP_MASTER_QUP_1,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SC8280XP_SLAVE_A1NOC_SNOC },
+};
+
+static struct qcom_icc_node qhm_qup2 = {
+	.name = "qhm_qup2",
+	.id = SC8280XP_MASTER_QUP_2,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SC8280XP_SLAVE_A1NOC_SNOC },
+};
+
+static struct qcom_icc_node qnm_a1noc_cfg = {
+	.name = "qnm_a1noc_cfg",
+	.id = SC8280XP_MASTER_A1NOC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.links = { SC8280XP_SLAVE_SERVICE_A1NOC },
+};
+
+static struct qcom_icc_node qxm_ipa = {
+	.name = "qxm_ipa",
+	.id = SC8280XP_MASTER_IPA,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SC8280XP_SLAVE_A1NOC_SNOC },
+};
+
+static struct qcom_icc_node xm_emac_1 = {
+	.name = "xm_emac_1",
+	.id = SC8280XP_MASTER_EMAC_1,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SC8280XP_SLAVE_A1NOC_SNOC },
+};
+
+static struct qcom_icc_node xm_sdc4 = {
+	.name = "xm_sdc4",
+	.id = SC8280XP_MASTER_SDCC_4,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SC8280XP_SLAVE_A1NOC_SNOC },
+};
+
+static struct qcom_icc_node xm_ufs_mem = {
+	.name = "xm_ufs_mem",
+	.id = SC8280XP_MASTER_UFS_MEM,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SC8280XP_SLAVE_A1NOC_SNOC },
+};
+
+static struct qcom_icc_node xm_usb3_0 = {
+	.name = "xm_usb3_0",
+	.id = SC8280XP_MASTER_USB3_0,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SC8280XP_SLAVE_USB_NOC_SNOC },
+};
+
+static struct qcom_icc_node xm_usb3_1 = {
+	.name = "xm_usb3_1",
+	.id = SC8280XP_MASTER_USB3_1,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SC8280XP_SLAVE_USB_NOC_SNOC },
+};
+
+static struct qcom_icc_node xm_usb3_mp = {
+	.name = "xm_usb3_mp",
+	.id = SC8280XP_MASTER_USB3_MP,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { SC8280XP_SLAVE_USB_NOC_SNOC },
+};
+
+static struct qcom_icc_node xm_usb4_host0 = {
+	.name = "xm_usb4_host0",
+	.id = SC8280XP_MASTER_USB4_0,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { SC8280XP_SLAVE_USB_NOC_SNOC },
+};
+
+static struct qcom_icc_node xm_usb4_host1 = {
+	.name = "xm_usb4_host1",
+	.id = SC8280XP_MASTER_USB4_1,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { SC8280XP_SLAVE_USB_NOC_SNOC },
+};
+
+static struct qcom_icc_node qhm_qdss_bam = {
+	.name = "qhm_qdss_bam",
+	.id = SC8280XP_MASTER_QDSS_BAM,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SC8280XP_SLAVE_A2NOC_SNOC },
+};
+
+static struct qcom_icc_node qhm_qup0 = {
+	.name = "qhm_qup0",
+	.id = SC8280XP_MASTER_QUP_0,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SC8280XP_SLAVE_A2NOC_SNOC },
+};
+
+static struct qcom_icc_node qnm_a2noc_cfg = {
+	.name = "qnm_a2noc_cfg",
+	.id = SC8280XP_MASTER_A2NOC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SC8280XP_SLAVE_SERVICE_A2NOC },
+};
+
+static struct qcom_icc_node qxm_crypto = {
+	.name = "qxm_crypto",
+	.id = SC8280XP_MASTER_CRYPTO,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SC8280XP_SLAVE_A2NOC_SNOC },
+};
+
+static struct qcom_icc_node qxm_sensorss_q6 = {
+	.name = "qxm_sensorss_q6",
+	.id = SC8280XP_MASTER_SENSORS_PROC,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SC8280XP_SLAVE_A2NOC_SNOC },
+};
+
+static struct qcom_icc_node qxm_sp = {
+	.name = "qxm_sp",
+	.id = SC8280XP_MASTER_SP,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SC8280XP_SLAVE_A2NOC_SNOC },
+};
+
+static struct qcom_icc_node xm_emac_0 = {
+	.name = "xm_emac_0",
+	.id = SC8280XP_MASTER_EMAC,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SC8280XP_SLAVE_A2NOC_SNOC },
+};
+
+static struct qcom_icc_node xm_pcie3_0 = {
+	.name = "xm_pcie3_0",
+	.id = SC8280XP_MASTER_PCIE_0,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { SC8280XP_SLAVE_ANOC_PCIE_GEM_NOC },
+};
+
+static struct qcom_icc_node xm_pcie3_1 = {
+	.name = "xm_pcie3_1",
+	.id = SC8280XP_MASTER_PCIE_1,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { SC8280XP_SLAVE_ANOC_PCIE_GEM_NOC },
+};
+
+static struct qcom_icc_node xm_pcie3_2a = {
+	.name = "xm_pcie3_2a",
+	.id = SC8280XP_MASTER_PCIE_2A,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { SC8280XP_SLAVE_ANOC_PCIE_GEM_NOC },
+};
+
+static struct qcom_icc_node xm_pcie3_2b = {
+	.name = "xm_pcie3_2b",
+	.id = SC8280XP_MASTER_PCIE_2B,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SC8280XP_SLAVE_ANOC_PCIE_GEM_NOC },
+};
+
+static struct qcom_icc_node xm_pcie3_3a = {
+	.name = "xm_pcie3_3a",
+	.id = SC8280XP_MASTER_PCIE_3A,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { SC8280XP_SLAVE_ANOC_PCIE_GEM_NOC },
+};
+
+static struct qcom_icc_node xm_pcie3_3b = {
+	.name = "xm_pcie3_3b",
+	.id = SC8280XP_MASTER_PCIE_3B,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SC8280XP_SLAVE_ANOC_PCIE_GEM_NOC },
+};
+
+static struct qcom_icc_node xm_pcie3_4 = {
+	.name = "xm_pcie3_4",
+	.id = SC8280XP_MASTER_PCIE_4,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SC8280XP_SLAVE_ANOC_PCIE_GEM_NOC },
+};
+
+static struct qcom_icc_node xm_qdss_etr = {
+	.name = "xm_qdss_etr",
+	.id = SC8280XP_MASTER_QDSS_ETR,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SC8280XP_SLAVE_A2NOC_SNOC },
+};
+
+static struct qcom_icc_node xm_sdc2 = {
+	.name = "xm_sdc2",
+	.id = SC8280XP_MASTER_SDCC_2,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SC8280XP_SLAVE_A2NOC_SNOC },
+};
+
+static struct qcom_icc_node xm_ufs_card = {
+	.name = "xm_ufs_card",
+	.id = SC8280XP_MASTER_UFS_CARD,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SC8280XP_SLAVE_A2NOC_SNOC },
+};
+
+static struct qcom_icc_node ipa_core_master = {
+	.name = "ipa_core_master",
+	.id = SC8280XP_MASTER_IPA_CORE,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SC8280XP_SLAVE_IPA_CORE },
+};
+
+static struct qcom_icc_node qup0_core_master = {
+	.name = "qup0_core_master",
+	.id = SC8280XP_MASTER_QUP_CORE_0,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SC8280XP_SLAVE_QUP_CORE_0 },
+};
+
+static struct qcom_icc_node qup1_core_master = {
+	.name = "qup1_core_master",
+	.id = SC8280XP_MASTER_QUP_CORE_1,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SC8280XP_SLAVE_QUP_CORE_1 },
+};
+
+static struct qcom_icc_node qup2_core_master = {
+	.name = "qup2_core_master",
+	.id = SC8280XP_MASTER_QUP_CORE_2,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SC8280XP_SLAVE_QUP_CORE_2 },
+};
+
+static struct qcom_icc_node qnm_gemnoc_cnoc = {
+	.name = "qnm_gemnoc_cnoc",
+	.id = SC8280XP_MASTER_GEM_NOC_CNOC,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 76,
+	.links = { SC8280XP_SLAVE_AHB2PHY_0,
+		   SC8280XP_SLAVE_AHB2PHY_1,
+		   SC8280XP_SLAVE_AHB2PHY_2,
+		   SC8280XP_SLAVE_AOSS,
+		   SC8280XP_SLAVE_APPSS,
+		   SC8280XP_SLAVE_CAMERA_CFG,
+		   SC8280XP_SLAVE_CLK_CTL,
+		   SC8280XP_SLAVE_CDSP_CFG,
+		   SC8280XP_SLAVE_CDSP1_CFG,
+		   SC8280XP_SLAVE_RBCPR_CX_CFG,
+		   SC8280XP_SLAVE_RBCPR_MMCX_CFG,
+		   SC8280XP_SLAVE_RBCPR_MX_CFG,
+		   SC8280XP_SLAVE_CPR_NSPCX,
+		   SC8280XP_SLAVE_CRYPTO_0_CFG,
+		   SC8280XP_SLAVE_CX_RDPM,
+		   SC8280XP_SLAVE_DCC_CFG,
+		   SC8280XP_SLAVE_DISPLAY_CFG,
+		   SC8280XP_SLAVE_DISPLAY1_CFG,
+		   SC8280XP_SLAVE_EMAC_CFG,
+		   SC8280XP_SLAVE_EMAC1_CFG,
+		   SC8280XP_SLAVE_GFX3D_CFG,
+		   SC8280XP_SLAVE_HWKM,
+		   SC8280XP_SLAVE_IMEM_CFG,
+		   SC8280XP_SLAVE_IPA_CFG,
+		   SC8280XP_SLAVE_IPC_ROUTER_CFG,
+		   SC8280XP_SLAVE_LPASS,
+		   SC8280XP_SLAVE_MX_RDPM,
+		   SC8280XP_SLAVE_MXC_RDPM,
+		   SC8280XP_SLAVE_PCIE_0_CFG,
+		   SC8280XP_SLAVE_PCIE_1_CFG,
+		   SC8280XP_SLAVE_PCIE_2A_CFG,
+		   SC8280XP_SLAVE_PCIE_2B_CFG,
+		   SC8280XP_SLAVE_PCIE_3A_CFG,
+		   SC8280XP_SLAVE_PCIE_3B_CFG,
+		   SC8280XP_SLAVE_PCIE_4_CFG,
+		   SC8280XP_SLAVE_PCIE_RSC_CFG,
+		   SC8280XP_SLAVE_PDM,
+		   SC8280XP_SLAVE_PIMEM_CFG,
+		   SC8280XP_SLAVE_PKA_WRAPPER_CFG,
+		   SC8280XP_SLAVE_PMU_WRAPPER_CFG,
+		   SC8280XP_SLAVE_QDSS_CFG,
+		   SC8280XP_SLAVE_QSPI_0,
+		   SC8280XP_SLAVE_QUP_0,
+		   SC8280XP_SLAVE_QUP_1,
+		   SC8280XP_SLAVE_QUP_2,
+		   SC8280XP_SLAVE_SDCC_2,
+		   SC8280XP_SLAVE_SDCC_4,
+		   SC8280XP_SLAVE_SECURITY,
+		   SC8280XP_SLAVE_SMMUV3_CFG,
+		   SC8280XP_SLAVE_SMSS_CFG,
+		   SC8280XP_SLAVE_SPSS_CFG,
+		   SC8280XP_SLAVE_TCSR,
+		   SC8280XP_SLAVE_TLMM,
+		   SC8280XP_SLAVE_UFS_CARD_CFG,
+		   SC8280XP_SLAVE_UFS_MEM_CFG,
+		   SC8280XP_SLAVE_USB3_0,
+		   SC8280XP_SLAVE_USB3_1,
+		   SC8280XP_SLAVE_USB3_MP,
+		   SC8280XP_SLAVE_USB4_0,
+		   SC8280XP_SLAVE_USB4_1,
+		   SC8280XP_SLAVE_VENUS_CFG,
+		   SC8280XP_SLAVE_VSENSE_CTRL_CFG,
+		   SC8280XP_SLAVE_VSENSE_CTRL_R_CFG,
+		   SC8280XP_SLAVE_A1NOC_CFG,
+		   SC8280XP_SLAVE_A2NOC_CFG,
+		   SC8280XP_SLAVE_ANOC_PCIE_BRIDGE_CFG,
+		   SC8280XP_SLAVE_DDRSS_CFG,
+		   SC8280XP_SLAVE_CNOC_MNOC_CFG,
+		   SC8280XP_SLAVE_SNOC_CFG,
+		   SC8280XP_SLAVE_SNOC_SF_BRIDGE_CFG,
+		   SC8280XP_SLAVE_IMEM,
+		   SC8280XP_SLAVE_PIMEM,
+		   SC8280XP_SLAVE_SERVICE_CNOC,
+		   SC8280XP_SLAVE_QDSS_STM,
+		   SC8280XP_SLAVE_SMSS,
+		   SC8280XP_SLAVE_TCU
+	},
+};
+
+static struct qcom_icc_node qnm_gemnoc_pcie = {
+	.name = "qnm_gemnoc_pcie",
+	.id = SC8280XP_MASTER_GEM_NOC_PCIE_SNOC,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 7,
+	.links = { SC8280XP_SLAVE_PCIE_0,
+		   SC8280XP_SLAVE_PCIE_1,
+		   SC8280XP_SLAVE_PCIE_2A,
+		   SC8280XP_SLAVE_PCIE_2B,
+		   SC8280XP_SLAVE_PCIE_3A,
+		   SC8280XP_SLAVE_PCIE_3B,
+		   SC8280XP_SLAVE_PCIE_4
+	},
+};
+
+static struct qcom_icc_node qnm_cnoc_dc_noc = {
+	.name = "qnm_cnoc_dc_noc",
+	.id = SC8280XP_MASTER_CNOC_DC_NOC,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 2,
+	.links = { SC8280XP_SLAVE_LLCC_CFG,
+		   SC8280XP_SLAVE_GEM_NOC_CFG
+	},
+};
+
+static struct qcom_icc_node alm_gpu_tcu = {
+	.name = "alm_gpu_tcu",
+	.id = SC8280XP_MASTER_GPU_TCU,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 2,
+	.links = { SC8280XP_SLAVE_GEM_NOC_CNOC,
+		   SC8280XP_SLAVE_LLCC
+	},
+};
+
+static struct qcom_icc_node alm_pcie_tcu = {
+	.name = "alm_pcie_tcu",
+	.id = SC8280XP_MASTER_PCIE_TCU,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 2,
+	.links = { SC8280XP_SLAVE_GEM_NOC_CNOC,
+		   SC8280XP_SLAVE_LLCC
+	},
+};
+
+static struct qcom_icc_node alm_sys_tcu = {
+	.name = "alm_sys_tcu",
+	.id = SC8280XP_MASTER_SYS_TCU,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 2,
+	.links = { SC8280XP_SLAVE_GEM_NOC_CNOC,
+		   SC8280XP_SLAVE_LLCC
+	},
+};
+
+static struct qcom_icc_node chm_apps = {
+	.name = "chm_apps",
+	.id = SC8280XP_MASTER_APPSS_PROC,
+	.channels = 2,
+	.buswidth = 32,
+	.num_links = 3,
+	.links = { SC8280XP_SLAVE_GEM_NOC_CNOC,
+		   SC8280XP_SLAVE_LLCC,
+		   SC8280XP_SLAVE_GEM_NOC_PCIE_CNOC
+	},
+};
+
+static struct qcom_icc_node qnm_cmpnoc0 = {
+	.name = "qnm_cmpnoc0",
+	.id = SC8280XP_MASTER_COMPUTE_NOC,
+	.channels = 2,
+	.buswidth = 32,
+	.num_links = 2,
+	.links = { SC8280XP_SLAVE_GEM_NOC_CNOC,
+		   SC8280XP_SLAVE_LLCC
+	},
+};
+
+static struct qcom_icc_node qnm_cmpnoc1 = {
+	.name = "qnm_cmpnoc1",
+	.id = SC8280XP_MASTER_COMPUTE_NOC_1,
+	.channels = 2,
+	.buswidth = 32,
+	.num_links = 2,
+	.links = { SC8280XP_SLAVE_GEM_NOC_CNOC,
+		   SC8280XP_SLAVE_LLCC
+	},
+};
+
+static struct qcom_icc_node qnm_gemnoc_cfg = {
+	.name = "qnm_gemnoc_cfg",
+	.id = SC8280XP_MASTER_GEM_NOC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 3,
+	.links = { SC8280XP_SLAVE_SERVICE_GEM_NOC_1,
+		   SC8280XP_SLAVE_SERVICE_GEM_NOC_2,
+		   SC8280XP_SLAVE_SERVICE_GEM_NOC
+	},
+};
+
+static struct qcom_icc_node qnm_gpu = {
+	.name = "qnm_gpu",
+	.id = SC8280XP_MASTER_GFX3D,
+	.channels = 4,
+	.buswidth = 32,
+	.num_links = 2,
+	.links = { SC8280XP_SLAVE_GEM_NOC_CNOC,
+		   SC8280XP_SLAVE_LLCC
+	},
+};
+
+static struct qcom_icc_node qnm_mnoc_hf = {
+	.name = "qnm_mnoc_hf",
+	.id = SC8280XP_MASTER_MNOC_HF_MEM_NOC,
+	.channels = 2,
+	.buswidth = 32,
+	.num_links = 2,
+	.links = { SC8280XP_SLAVE_LLCC,
+		   SC8280XP_SLAVE_GEM_NOC_PCIE_CNOC
+	},
+};
+
+static struct qcom_icc_node qnm_mnoc_sf = {
+	.name = "qnm_mnoc_sf",
+	.id = SC8280XP_MASTER_MNOC_SF_MEM_NOC,
+	.channels = 2,
+	.buswidth = 32,
+	.num_links = 2,
+	.links = { SC8280XP_SLAVE_GEM_NOC_CNOC,
+		   SC8280XP_SLAVE_LLCC
+	},
+};
+
+static struct qcom_icc_node qnm_pcie = {
+	.name = "qnm_pcie",
+	.id = SC8280XP_MASTER_ANOC_PCIE_GEM_NOC,
+	.channels = 1,
+	.buswidth = 32,
+	.num_links = 2,
+	.links = { SC8280XP_SLAVE_GEM_NOC_CNOC,
+		   SC8280XP_SLAVE_LLCC
+	},
+};
+
+static struct qcom_icc_node qnm_snoc_gc = {
+	.name = "qnm_snoc_gc",
+	.id = SC8280XP_MASTER_SNOC_GC_MEM_NOC,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SC8280XP_SLAVE_LLCC },
+};
+
+static struct qcom_icc_node qnm_snoc_sf = {
+	.name = "qnm_snoc_sf",
+	.id = SC8280XP_MASTER_SNOC_SF_MEM_NOC,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 3,
+	.links = { SC8280XP_SLAVE_GEM_NOC_CNOC,
+		   SC8280XP_SLAVE_LLCC,
+		   SC8280XP_SLAVE_GEM_NOC_PCIE_CNOC },
+};
+
+static struct qcom_icc_node qhm_config_noc = {
+	.name = "qhm_config_noc",
+	.id = SC8280XP_MASTER_CNOC_LPASS_AG_NOC,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 6,
+	.links = { SC8280XP_SLAVE_LPASS_CORE_CFG,
+		   SC8280XP_SLAVE_LPASS_LPI_CFG,
+		   SC8280XP_SLAVE_LPASS_MPU_CFG,
+		   SC8280XP_SLAVE_LPASS_TOP_CFG,
+		   SC8280XP_SLAVE_SERVICES_LPASS_AML_NOC,
+		   SC8280XP_SLAVE_SERVICE_LPASS_AG_NOC
+	},
+};
+
+static struct qcom_icc_node qxm_lpass_dsp = {
+	.name = "qxm_lpass_dsp",
+	.id = SC8280XP_MASTER_LPASS_PROC,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 4,
+	.links = { SC8280XP_SLAVE_LPASS_TOP_CFG,
+		   SC8280XP_SLAVE_LPASS_SNOC,
+		   SC8280XP_SLAVE_SERVICES_LPASS_AML_NOC,
+		   SC8280XP_SLAVE_SERVICE_LPASS_AG_NOC
+	},
+};
+
+static struct qcom_icc_node llcc_mc = {
+	.name = "llcc_mc",
+	.id = SC8280XP_MASTER_LLCC,
+	.channels = 8,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SC8280XP_SLAVE_EBI1 },
+};
+
+static struct qcom_icc_node qnm_camnoc_hf = {
+	.name = "qnm_camnoc_hf",
+	.id = SC8280XP_MASTER_CAMNOC_HF,
+	.channels = 2,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SC8280XP_SLAVE_MNOC_HF_MEM_NOC },
+};
+
+static struct qcom_icc_node qnm_mdp0_0 = {
+	.name = "qnm_mdp0_0",
+	.id = SC8280XP_MASTER_MDP0,
+	.channels = 1,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SC8280XP_SLAVE_MNOC_HF_MEM_NOC },
+};
+
+static struct qcom_icc_node qnm_mdp0_1 = {
+	.name = "qnm_mdp0_1",
+	.id = SC8280XP_MASTER_MDP1,
+	.channels = 1,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SC8280XP_SLAVE_MNOC_HF_MEM_NOC },
+};
+
+static struct qcom_icc_node qnm_mdp1_0 = {
+	.name = "qnm_mdp1_0",
+	.id = SC8280XP_MASTER_MDP_CORE1_0,
+	.channels = 1,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SC8280XP_SLAVE_MNOC_HF_MEM_NOC },
+};
+
+static struct qcom_icc_node qnm_mdp1_1 = {
+	.name = "qnm_mdp1_1",
+	.id = SC8280XP_MASTER_MDP_CORE1_1,
+	.channels = 1,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SC8280XP_SLAVE_MNOC_HF_MEM_NOC },
+};
+
+static struct qcom_icc_node qnm_mnoc_cfg = {
+	.name = "qnm_mnoc_cfg",
+	.id = SC8280XP_MASTER_CNOC_MNOC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SC8280XP_SLAVE_SERVICE_MNOC },
+};
+
+static struct qcom_icc_node qnm_rot_0 = {
+	.name = "qnm_rot_0",
+	.id = SC8280XP_MASTER_ROTATOR,
+	.channels = 1,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SC8280XP_SLAVE_MNOC_SF_MEM_NOC },
+};
+
+static struct qcom_icc_node qnm_rot_1 = {
+	.name = "qnm_rot_1",
+	.id = SC8280XP_MASTER_ROTATOR_1,
+	.channels = 1,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SC8280XP_SLAVE_MNOC_SF_MEM_NOC },
+};
+
+static struct qcom_icc_node qnm_video0 = {
+	.name = "qnm_video0",
+	.id = SC8280XP_MASTER_VIDEO_P0,
+	.channels = 1,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SC8280XP_SLAVE_MNOC_SF_MEM_NOC },
+};
+
+static struct qcom_icc_node qnm_video1 = {
+	.name = "qnm_video1",
+	.id = SC8280XP_MASTER_VIDEO_P1,
+	.channels = 1,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SC8280XP_SLAVE_MNOC_SF_MEM_NOC },
+};
+
+static struct qcom_icc_node qnm_video_cvp = {
+	.name = "qnm_video_cvp",
+	.id = SC8280XP_MASTER_VIDEO_PROC,
+	.channels = 1,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SC8280XP_SLAVE_MNOC_SF_MEM_NOC },
+};
+
+static struct qcom_icc_node qxm_camnoc_icp = {
+	.name = "qxm_camnoc_icp",
+	.id = SC8280XP_MASTER_CAMNOC_ICP,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SC8280XP_SLAVE_MNOC_SF_MEM_NOC },
+};
+
+static struct qcom_icc_node qxm_camnoc_sf = {
+	.name = "qxm_camnoc_sf",
+	.id = SC8280XP_MASTER_CAMNOC_SF,
+	.channels = 1,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SC8280XP_SLAVE_MNOC_SF_MEM_NOC },
+};
+
+static struct qcom_icc_node qhm_nsp_noc_config = {
+	.name = "qhm_nsp_noc_config",
+	.id = SC8280XP_MASTER_CDSP_NOC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SC8280XP_SLAVE_SERVICE_NSP_NOC },
+};
+
+static struct qcom_icc_node qxm_nsp = {
+	.name = "qxm_nsp",
+	.id = SC8280XP_MASTER_CDSP_PROC,
+	.channels = 2,
+	.buswidth = 32,
+	.num_links = 2,
+	.links = { SC8280XP_SLAVE_CDSP_MEM_NOC,
+		   SC8280XP_SLAVE_NSP_XFR
+	},
+};
+
+static struct qcom_icc_node qhm_nspb_noc_config = {
+	.name = "qhm_nspb_noc_config",
+	.id = SC8280XP_MASTER_CDSPB_NOC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SC8280XP_SLAVE_SERVICE_NSPB_NOC },
+};
+
+static struct qcom_icc_node qxm_nspb = {
+	.name = "qxm_nspb",
+	.id = SC8280XP_MASTER_CDSP_PROC_B,
+	.channels = 2,
+	.buswidth = 32,
+	.num_links = 2,
+	.links = { SC8280XP_SLAVE_CDSPB_MEM_NOC,
+		   SC8280XP_SLAVE_NSPB_XFR
+	},
+};
+
+static struct qcom_icc_node qnm_aggre1_noc = {
+	.name = "qnm_aggre1_noc",
+	.id = SC8280XP_MASTER_A1NOC_SNOC,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { SC8280XP_SLAVE_SNOC_GEM_NOC_SF },
+};
+
+static struct qcom_icc_node qnm_aggre2_noc = {
+	.name = "qnm_aggre2_noc",
+	.id = SC8280XP_MASTER_A2NOC_SNOC,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { SC8280XP_SLAVE_SNOC_GEM_NOC_SF },
+};
+
+static struct qcom_icc_node qnm_aggre_usb_noc = {
+	.name = "qnm_aggre_usb_noc",
+	.id = SC8280XP_MASTER_USB_NOC_SNOC,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { SC8280XP_SLAVE_SNOC_GEM_NOC_SF },
+};
+
+static struct qcom_icc_node qnm_lpass_noc = {
+	.name = "qnm_lpass_noc",
+	.id = SC8280XP_MASTER_LPASS_ANOC,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { SC8280XP_SLAVE_SNOC_GEM_NOC_SF },
+};
+
+static struct qcom_icc_node qnm_snoc_cfg = {
+	.name = "qnm_snoc_cfg",
+	.id = SC8280XP_MASTER_SNOC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SC8280XP_SLAVE_SERVICE_SNOC },
+};
+
+static struct qcom_icc_node qxm_pimem = {
+	.name = "qxm_pimem",
+	.id = SC8280XP_MASTER_PIMEM,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SC8280XP_SLAVE_SNOC_GEM_NOC_GC },
+};
+
+static struct qcom_icc_node xm_gic = {
+	.name = "xm_gic",
+	.id = SC8280XP_MASTER_GIC,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SC8280XP_SLAVE_SNOC_GEM_NOC_GC },
+};
+
+static struct qcom_icc_node qns_a1noc_snoc = {
+	.name = "qns_a1noc_snoc",
+	.id = SC8280XP_SLAVE_A1NOC_SNOC,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { SC8280XP_MASTER_A1NOC_SNOC },
+};
+
+static struct qcom_icc_node qns_aggre_usb_snoc = {
+	.name = "qns_aggre_usb_snoc",
+	.id = SC8280XP_SLAVE_USB_NOC_SNOC,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { SC8280XP_MASTER_USB_NOC_SNOC },
+};
+
+static struct qcom_icc_node srvc_aggre1_noc = {
+	.name = "srvc_aggre1_noc",
+	.id = SC8280XP_SLAVE_SERVICE_A1NOC,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qns_a2noc_snoc = {
+	.name = "qns_a2noc_snoc",
+	.id = SC8280XP_SLAVE_A2NOC_SNOC,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { SC8280XP_MASTER_A2NOC_SNOC },
+};
+
+static struct qcom_icc_node qns_pcie_gem_noc = {
+	.name = "qns_pcie_gem_noc",
+	.id = SC8280XP_SLAVE_ANOC_PCIE_GEM_NOC,
+	.channels = 1,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SC8280XP_MASTER_ANOC_PCIE_GEM_NOC },
+};
+
+static struct qcom_icc_node srvc_aggre2_noc = {
+	.name = "srvc_aggre2_noc",
+	.id = SC8280XP_SLAVE_SERVICE_A2NOC,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node ipa_core_slave = {
+	.name = "ipa_core_slave",
+	.id = SC8280XP_SLAVE_IPA_CORE,
+	.channels = 1,
+	.buswidth = 8,
+};
+
+static struct qcom_icc_node qup0_core_slave = {
+	.name = "qup0_core_slave",
+	.id = SC8280XP_SLAVE_QUP_CORE_0,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qup1_core_slave = {
+	.name = "qup1_core_slave",
+	.id = SC8280XP_SLAVE_QUP_CORE_1,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qup2_core_slave = {
+	.name = "qup2_core_slave",
+	.id = SC8280XP_SLAVE_QUP_CORE_2,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_ahb2phy0 = {
+	.name = "qhs_ahb2phy0",
+	.id = SC8280XP_SLAVE_AHB2PHY_0,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_ahb2phy1 = {
+	.name = "qhs_ahb2phy1",
+	.id = SC8280XP_SLAVE_AHB2PHY_1,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_ahb2phy2 = {
+	.name = "qhs_ahb2phy2",
+	.id = SC8280XP_SLAVE_AHB2PHY_2,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_aoss = {
+	.name = "qhs_aoss",
+	.id = SC8280XP_SLAVE_AOSS,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_apss = {
+	.name = "qhs_apss",
+	.id = SC8280XP_SLAVE_APPSS,
+	.channels = 1,
+	.buswidth = 8,
+};
+
+static struct qcom_icc_node qhs_camera_cfg = {
+	.name = "qhs_camera_cfg",
+	.id = SC8280XP_SLAVE_CAMERA_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_clk_ctl = {
+	.name = "qhs_clk_ctl",
+	.id = SC8280XP_SLAVE_CLK_CTL,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_compute0_cfg = {
+	.name = "qhs_compute0_cfg",
+	.id = SC8280XP_SLAVE_CDSP_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SC8280XP_MASTER_CDSP_NOC_CFG },
+};
+
+static struct qcom_icc_node qhs_compute1_cfg = {
+	.name = "qhs_compute1_cfg",
+	.id = SC8280XP_SLAVE_CDSP1_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SC8280XP_MASTER_CDSPB_NOC_CFG },
+};
+
+static struct qcom_icc_node qhs_cpr_cx = {
+	.name = "qhs_cpr_cx",
+	.id = SC8280XP_SLAVE_RBCPR_CX_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_cpr_mmcx = {
+	.name = "qhs_cpr_mmcx",
+	.id = SC8280XP_SLAVE_RBCPR_MMCX_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_cpr_mx = {
+	.name = "qhs_cpr_mx",
+	.id = SC8280XP_SLAVE_RBCPR_MX_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_cpr_nspcx = {
+	.name = "qhs_cpr_nspcx",
+	.id = SC8280XP_SLAVE_CPR_NSPCX,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_crypto0_cfg = {
+	.name = "qhs_crypto0_cfg",
+	.id = SC8280XP_SLAVE_CRYPTO_0_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_cx_rdpm = {
+	.name = "qhs_cx_rdpm",
+	.id = SC8280XP_SLAVE_CX_RDPM,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_dcc_cfg = {
+	.name = "qhs_dcc_cfg",
+	.id = SC8280XP_SLAVE_DCC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_display0_cfg = {
+	.name = "qhs_display0_cfg",
+	.id = SC8280XP_SLAVE_DISPLAY_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_display1_cfg = {
+	.name = "qhs_display1_cfg",
+	.id = SC8280XP_SLAVE_DISPLAY1_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_emac0_cfg = {
+	.name = "qhs_emac0_cfg",
+	.id = SC8280XP_SLAVE_EMAC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_emac1_cfg = {
+	.name = "qhs_emac1_cfg",
+	.id = SC8280XP_SLAVE_EMAC1_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_gpuss_cfg = {
+	.name = "qhs_gpuss_cfg",
+	.id = SC8280XP_SLAVE_GFX3D_CFG,
+	.channels = 1,
+	.buswidth = 8,
+};
+
+static struct qcom_icc_node qhs_hwkm = {
+	.name = "qhs_hwkm",
+	.id = SC8280XP_SLAVE_HWKM,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_imem_cfg = {
+	.name = "qhs_imem_cfg",
+	.id = SC8280XP_SLAVE_IMEM_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_ipa = {
+	.name = "qhs_ipa",
+	.id = SC8280XP_SLAVE_IPA_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_ipc_router = {
+	.name = "qhs_ipc_router",
+	.id = SC8280XP_SLAVE_IPC_ROUTER_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_lpass_cfg = {
+	.name = "qhs_lpass_cfg",
+	.id = SC8280XP_SLAVE_LPASS,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SC8280XP_MASTER_CNOC_LPASS_AG_NOC },
+};
+
+static struct qcom_icc_node qhs_mx_rdpm = {
+	.name = "qhs_mx_rdpm",
+	.id = SC8280XP_SLAVE_MX_RDPM,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_mxc_rdpm = {
+	.name = "qhs_mxc_rdpm",
+	.id = SC8280XP_SLAVE_MXC_RDPM,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_pcie0_cfg = {
+	.name = "qhs_pcie0_cfg",
+	.id = SC8280XP_SLAVE_PCIE_0_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_pcie1_cfg = {
+	.name = "qhs_pcie1_cfg",
+	.id = SC8280XP_SLAVE_PCIE_1_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_pcie2a_cfg = {
+	.name = "qhs_pcie2a_cfg",
+	.id = SC8280XP_SLAVE_PCIE_2A_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_pcie2b_cfg = {
+	.name = "qhs_pcie2b_cfg",
+	.id = SC8280XP_SLAVE_PCIE_2B_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_pcie3a_cfg = {
+	.name = "qhs_pcie3a_cfg",
+	.id = SC8280XP_SLAVE_PCIE_3A_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_pcie3b_cfg = {
+	.name = "qhs_pcie3b_cfg",
+	.id = SC8280XP_SLAVE_PCIE_3B_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_pcie4_cfg = {
+	.name = "qhs_pcie4_cfg",
+	.id = SC8280XP_SLAVE_PCIE_4_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_pcie_rsc_cfg = {
+	.name = "qhs_pcie_rsc_cfg",
+	.id = SC8280XP_SLAVE_PCIE_RSC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_pdm = {
+	.name = "qhs_pdm",
+	.id = SC8280XP_SLAVE_PDM,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_pimem_cfg = {
+	.name = "qhs_pimem_cfg",
+	.id = SC8280XP_SLAVE_PIMEM_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_pka_wrapper_cfg = {
+	.name = "qhs_pka_wrapper_cfg",
+	.id = SC8280XP_SLAVE_PKA_WRAPPER_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_pmu_wrapper_cfg = {
+	.name = "qhs_pmu_wrapper_cfg",
+	.id = SC8280XP_SLAVE_PMU_WRAPPER_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_qdss_cfg = {
+	.name = "qhs_qdss_cfg",
+	.id = SC8280XP_SLAVE_QDSS_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_qspi = {
+	.name = "qhs_qspi",
+	.id = SC8280XP_SLAVE_QSPI_0,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_qup0 = {
+	.name = "qhs_qup0",
+	.id = SC8280XP_SLAVE_QUP_0,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_qup1 = {
+	.name = "qhs_qup1",
+	.id = SC8280XP_SLAVE_QUP_1,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_qup2 = {
+	.name = "qhs_qup2",
+	.id = SC8280XP_SLAVE_QUP_2,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_sdc2 = {
+	.name = "qhs_sdc2",
+	.id = SC8280XP_SLAVE_SDCC_2,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_sdc4 = {
+	.name = "qhs_sdc4",
+	.id = SC8280XP_SLAVE_SDCC_4,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_security = {
+	.name = "qhs_security",
+	.id = SC8280XP_SLAVE_SECURITY,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_smmuv3_cfg = {
+	.name = "qhs_smmuv3_cfg",
+	.id = SC8280XP_SLAVE_SMMUV3_CFG,
+	.channels = 1,
+	.buswidth = 8,
+};
+
+static struct qcom_icc_node qhs_smss_cfg = {
+	.name = "qhs_smss_cfg",
+	.id = SC8280XP_SLAVE_SMSS_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_spss_cfg = {
+	.name = "qhs_spss_cfg",
+	.id = SC8280XP_SLAVE_SPSS_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_tcsr = {
+	.name = "qhs_tcsr",
+	.id = SC8280XP_SLAVE_TCSR,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_tlmm = {
+	.name = "qhs_tlmm",
+	.id = SC8280XP_SLAVE_TLMM,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_ufs_card_cfg = {
+	.name = "qhs_ufs_card_cfg",
+	.id = SC8280XP_SLAVE_UFS_CARD_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_ufs_mem_cfg = {
+	.name = "qhs_ufs_mem_cfg",
+	.id = SC8280XP_SLAVE_UFS_MEM_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_usb3_0 = {
+	.name = "qhs_usb3_0",
+	.id = SC8280XP_SLAVE_USB3_0,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_usb3_1 = {
+	.name = "qhs_usb3_1",
+	.id = SC8280XP_SLAVE_USB3_1,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_usb3_mp = {
+	.name = "qhs_usb3_mp",
+	.id = SC8280XP_SLAVE_USB3_MP,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_usb4_host_0 = {
+	.name = "qhs_usb4_host_0",
+	.id = SC8280XP_SLAVE_USB4_0,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_usb4_host_1 = {
+	.name = "qhs_usb4_host_1",
+	.id = SC8280XP_SLAVE_USB4_1,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_venus_cfg = {
+	.name = "qhs_venus_cfg",
+	.id = SC8280XP_SLAVE_VENUS_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_vsense_ctrl_cfg = {
+	.name = "qhs_vsense_ctrl_cfg",
+	.id = SC8280XP_SLAVE_VSENSE_CTRL_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_vsense_ctrl_r_cfg = {
+	.name = "qhs_vsense_ctrl_r_cfg",
+	.id = SC8280XP_SLAVE_VSENSE_CTRL_R_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qns_a1_noc_cfg = {
+	.name = "qns_a1_noc_cfg",
+	.id = SC8280XP_SLAVE_A1NOC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SC8280XP_MASTER_A1NOC_CFG },
+};
+
+static struct qcom_icc_node qns_a2_noc_cfg = {
+	.name = "qns_a2_noc_cfg",
+	.id = SC8280XP_SLAVE_A2NOC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SC8280XP_MASTER_A2NOC_CFG },
+};
+
+static struct qcom_icc_node qns_anoc_pcie_bridge_cfg = {
+	.name = "qns_anoc_pcie_bridge_cfg",
+	.id = SC8280XP_SLAVE_ANOC_PCIE_BRIDGE_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qns_ddrss_cfg = {
+	.name = "qns_ddrss_cfg",
+	.id = SC8280XP_SLAVE_DDRSS_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SC8280XP_MASTER_CNOC_DC_NOC },
+};
+
+static struct qcom_icc_node qns_mnoc_cfg = {
+	.name = "qns_mnoc_cfg",
+	.id = SC8280XP_SLAVE_CNOC_MNOC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SC8280XP_MASTER_CNOC_MNOC_CFG },
+};
+
+static struct qcom_icc_node qns_snoc_cfg = {
+	.name = "qns_snoc_cfg",
+	.id = SC8280XP_SLAVE_SNOC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SC8280XP_MASTER_SNOC_CFG },
+};
+
+static struct qcom_icc_node qns_snoc_sf_bridge_cfg = {
+	.name = "qns_snoc_sf_bridge_cfg",
+	.id = SC8280XP_SLAVE_SNOC_SF_BRIDGE_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qxs_imem = {
+	.name = "qxs_imem",
+	.id = SC8280XP_SLAVE_IMEM,
+	.channels = 1,
+	.buswidth = 8,
+};
+
+static struct qcom_icc_node qxs_pimem = {
+	.name = "qxs_pimem",
+	.id = SC8280XP_SLAVE_PIMEM,
+	.channels = 1,
+	.buswidth = 8,
+};
+
+static struct qcom_icc_node srvc_cnoc = {
+	.name = "srvc_cnoc",
+	.id = SC8280XP_SLAVE_SERVICE_CNOC,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node xs_pcie_0 = {
+	.name = "xs_pcie_0",
+	.id = SC8280XP_SLAVE_PCIE_0,
+	.channels = 1,
+	.buswidth = 16,
+};
+
+static struct qcom_icc_node xs_pcie_1 = {
+	.name = "xs_pcie_1",
+	.id = SC8280XP_SLAVE_PCIE_1,
+	.channels = 1,
+	.buswidth = 16,
+};
+
+static struct qcom_icc_node xs_pcie_2a = {
+	.name = "xs_pcie_2a",
+	.id = SC8280XP_SLAVE_PCIE_2A,
+	.channels = 1,
+	.buswidth = 16,
+};
+
+static struct qcom_icc_node xs_pcie_2b = {
+	.name = "xs_pcie_2b",
+	.id = SC8280XP_SLAVE_PCIE_2B,
+	.channels = 1,
+	.buswidth = 8,
+};
+
+static struct qcom_icc_node xs_pcie_3a = {
+	.name = "xs_pcie_3a",
+	.id = SC8280XP_SLAVE_PCIE_3A,
+	.channels = 1,
+	.buswidth = 16,
+};
+
+static struct qcom_icc_node xs_pcie_3b = {
+	.name = "xs_pcie_3b",
+	.id = SC8280XP_SLAVE_PCIE_3B,
+	.channels = 1,
+	.buswidth = 8,
+};
+
+static struct qcom_icc_node xs_pcie_4 = {
+	.name = "xs_pcie_4",
+	.id = SC8280XP_SLAVE_PCIE_4,
+	.channels = 1,
+	.buswidth = 8,
+};
+
+static struct qcom_icc_node xs_qdss_stm = {
+	.name = "xs_qdss_stm",
+	.id = SC8280XP_SLAVE_QDSS_STM,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node xs_smss = {
+	.name = "xs_smss",
+	.id = SC8280XP_SLAVE_SMSS,
+	.channels = 1,
+	.buswidth = 8,
+};
+
+static struct qcom_icc_node xs_sys_tcu_cfg = {
+	.name = "xs_sys_tcu_cfg",
+	.id = SC8280XP_SLAVE_TCU,
+	.channels = 1,
+	.buswidth = 8,
+};
+
+static struct qcom_icc_node qhs_llcc = {
+	.name = "qhs_llcc",
+	.id = SC8280XP_SLAVE_LLCC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qns_gemnoc = {
+	.name = "qns_gemnoc",
+	.id = SC8280XP_SLAVE_GEM_NOC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SC8280XP_MASTER_GEM_NOC_CFG },
+};
+
+static struct qcom_icc_node qns_gem_noc_cnoc = {
+	.name = "qns_gem_noc_cnoc",
+	.id = SC8280XP_SLAVE_GEM_NOC_CNOC,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { SC8280XP_MASTER_GEM_NOC_CNOC },
+};
+
+static struct qcom_icc_node qns_llcc = {
+	.name = "qns_llcc",
+	.id = SC8280XP_SLAVE_LLCC,
+	.channels = 8,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { SC8280XP_MASTER_LLCC },
+};
+
+static struct qcom_icc_node qns_pcie = {
+	.name = "qns_pcie",
+	.id = SC8280XP_SLAVE_GEM_NOC_PCIE_CNOC,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { SC8280XP_MASTER_GEM_NOC_PCIE_SNOC },
+};
+
+static struct qcom_icc_node srvc_even_gemnoc = {
+	.name = "srvc_even_gemnoc",
+	.id = SC8280XP_SLAVE_SERVICE_GEM_NOC_1,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node srvc_odd_gemnoc = {
+	.name = "srvc_odd_gemnoc",
+	.id = SC8280XP_SLAVE_SERVICE_GEM_NOC_2,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node srvc_sys_gemnoc = {
+	.name = "srvc_sys_gemnoc",
+	.id = SC8280XP_SLAVE_SERVICE_GEM_NOC,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_lpass_core = {
+	.name = "qhs_lpass_core",
+	.id = SC8280XP_SLAVE_LPASS_CORE_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_lpass_lpi = {
+	.name = "qhs_lpass_lpi",
+	.id = SC8280XP_SLAVE_LPASS_LPI_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_lpass_mpu = {
+	.name = "qhs_lpass_mpu",
+	.id = SC8280XP_SLAVE_LPASS_MPU_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_lpass_top = {
+	.name = "qhs_lpass_top",
+	.id = SC8280XP_SLAVE_LPASS_TOP_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qns_sysnoc = {
+	.name = "qns_sysnoc",
+	.id = SC8280XP_SLAVE_LPASS_SNOC,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { SC8280XP_MASTER_LPASS_ANOC },
+};
+
+static struct qcom_icc_node srvc_niu_aml_noc = {
+	.name = "srvc_niu_aml_noc",
+	.id = SC8280XP_SLAVE_SERVICES_LPASS_AML_NOC,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node srvc_niu_lpass_agnoc = {
+	.name = "srvc_niu_lpass_agnoc",
+	.id = SC8280XP_SLAVE_SERVICE_LPASS_AG_NOC,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node ebi = {
+	.name = "ebi",
+	.id = SC8280XP_SLAVE_EBI1,
+	.channels = 8,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qns_mem_noc_hf = {
+	.name = "qns_mem_noc_hf",
+	.id = SC8280XP_SLAVE_MNOC_HF_MEM_NOC,
+	.channels = 2,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SC8280XP_MASTER_MNOC_HF_MEM_NOC },
+};
+
+static struct qcom_icc_node qns_mem_noc_sf = {
+	.name = "qns_mem_noc_sf",
+	.id = SC8280XP_SLAVE_MNOC_SF_MEM_NOC,
+	.channels = 2,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SC8280XP_MASTER_MNOC_SF_MEM_NOC },
+};
+
+static struct qcom_icc_node srvc_mnoc = {
+	.name = "srvc_mnoc",
+	.id = SC8280XP_SLAVE_SERVICE_MNOC,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qns_nsp_gemnoc = {
+	.name = "qns_nsp_gemnoc",
+	.id = SC8280XP_SLAVE_CDSP_MEM_NOC,
+	.channels = 2,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SC8280XP_MASTER_COMPUTE_NOC },
+};
+
+static struct qcom_icc_node qxs_nsp_xfr = {
+	.name = "qxs_nsp_xfr",
+	.id = SC8280XP_SLAVE_NSP_XFR,
+	.channels = 1,
+	.buswidth = 32,
+};
+
+static struct qcom_icc_node service_nsp_noc = {
+	.name = "service_nsp_noc",
+	.id = SC8280XP_SLAVE_SERVICE_NSP_NOC,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qns_nspb_gemnoc = {
+	.name = "qns_nspb_gemnoc",
+	.id = SC8280XP_SLAVE_CDSPB_MEM_NOC,
+	.channels = 2,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SC8280XP_MASTER_COMPUTE_NOC_1 },
+};
+
+static struct qcom_icc_node qxs_nspb_xfr = {
+	.name = "qxs_nspb_xfr",
+	.id = SC8280XP_SLAVE_NSPB_XFR,
+	.channels = 1,
+	.buswidth = 32,
+};
+
+static struct qcom_icc_node service_nspb_noc = {
+	.name = "service_nspb_noc",
+	.id = SC8280XP_SLAVE_SERVICE_NSPB_NOC,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qns_gemnoc_gc = {
+	.name = "qns_gemnoc_gc",
+	.id = SC8280XP_SLAVE_SNOC_GEM_NOC_GC,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SC8280XP_MASTER_SNOC_GC_MEM_NOC },
+};
+
+static struct qcom_icc_node qns_gemnoc_sf = {
+	.name = "qns_gemnoc_sf",
+	.id = SC8280XP_SLAVE_SNOC_GEM_NOC_SF,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { SC8280XP_MASTER_SNOC_SF_MEM_NOC },
+};
+
+static struct qcom_icc_node srvc_snoc = {
+	.name = "srvc_snoc",
+	.id = SC8280XP_SLAVE_SERVICE_SNOC,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_bcm bcm_acv = {
+	.name = "ACV",
+	.num_nodes = 1,
+	.nodes = { &ebi },
+};
+
+static struct qcom_icc_bcm bcm_ce0 = {
+	.name = "CE0",
+	.num_nodes = 1,
+	.nodes = { &qxm_crypto },
+};
+
+static struct qcom_icc_bcm bcm_cn0 = {
+	.name = "CN0",
+	.keepalive = true,
+	.num_nodes = 9,
+	.nodes = { &qnm_gemnoc_cnoc,
+		   &qnm_gemnoc_pcie,
+		   &xs_pcie_0,
+		   &xs_pcie_1,
+		   &xs_pcie_2a,
+		   &xs_pcie_2b,
+		   &xs_pcie_3a,
+		   &xs_pcie_3b,
+		   &xs_pcie_4
+	},
+};
+
+static struct qcom_icc_bcm bcm_cn1 = {
+	.name = "CN1",
+	.num_nodes = 67,
+	.nodes = { &qhs_ahb2phy0,
+		   &qhs_ahb2phy1,
+		   &qhs_ahb2phy2,
+		   &qhs_aoss,
+		   &qhs_apss,
+		   &qhs_camera_cfg,
+		   &qhs_clk_ctl,
+		   &qhs_compute0_cfg,
+		   &qhs_compute1_cfg,
+		   &qhs_cpr_cx,
+		   &qhs_cpr_mmcx,
+		   &qhs_cpr_mx,
+		   &qhs_cpr_nspcx,
+		   &qhs_crypto0_cfg,
+		   &qhs_cx_rdpm,
+		   &qhs_dcc_cfg,
+		   &qhs_display0_cfg,
+		   &qhs_display1_cfg,
+		   &qhs_emac0_cfg,
+		   &qhs_emac1_cfg,
+		   &qhs_gpuss_cfg,
+		   &qhs_hwkm,
+		   &qhs_imem_cfg,
+		   &qhs_ipa,
+		   &qhs_ipc_router,
+		   &qhs_lpass_cfg,
+		   &qhs_mx_rdpm,
+		   &qhs_mxc_rdpm,
+		   &qhs_pcie0_cfg,
+		   &qhs_pcie1_cfg,
+		   &qhs_pcie2a_cfg,
+		   &qhs_pcie2b_cfg,
+		   &qhs_pcie3a_cfg,
+		   &qhs_pcie3b_cfg,
+		   &qhs_pcie4_cfg,
+		   &qhs_pcie_rsc_cfg,
+		   &qhs_pdm,
+		   &qhs_pimem_cfg,
+		   &qhs_pka_wrapper_cfg,
+		   &qhs_pmu_wrapper_cfg,
+		   &qhs_qdss_cfg,
+		   &qhs_sdc2,
+		   &qhs_sdc4,
+		   &qhs_security,
+		   &qhs_smmuv3_cfg,
+		   &qhs_smss_cfg,
+		   &qhs_spss_cfg,
+		   &qhs_tcsr,
+		   &qhs_tlmm,
+		   &qhs_ufs_card_cfg,
+		   &qhs_ufs_mem_cfg,
+		   &qhs_usb3_0,
+		   &qhs_usb3_1,
+		   &qhs_usb3_mp,
+		   &qhs_usb4_host_0,
+		   &qhs_usb4_host_1,
+		   &qhs_venus_cfg,
+		   &qhs_vsense_ctrl_cfg,
+		   &qhs_vsense_ctrl_r_cfg,
+		   &qns_a1_noc_cfg,
+		   &qns_a2_noc_cfg,
+		   &qns_anoc_pcie_bridge_cfg,
+		   &qns_ddrss_cfg,
+		   &qns_mnoc_cfg,
+		   &qns_snoc_cfg,
+		   &qns_snoc_sf_bridge_cfg,
+		   &srvc_cnoc
+	},
+};
+
+static struct qcom_icc_bcm bcm_cn2 = {
+	.name = "CN2",
+	.num_nodes = 4,
+	.nodes = { &qhs_qspi,
+		   &qhs_qup0,
+		   &qhs_qup1,
+		   &qhs_qup2
+	},
+};
+
+static struct qcom_icc_bcm bcm_cn3 = {
+	.name = "CN3",
+	.num_nodes = 3,
+	.nodes = { &qxs_imem,
+		   &xs_smss,
+		   &xs_sys_tcu_cfg
+	},
+};
+
+static struct qcom_icc_bcm bcm_ip0 = {
+	.name = "IP0",
+	.num_nodes = 1,
+	.nodes = { &ipa_core_slave },
+};
+
+static struct qcom_icc_bcm bcm_mc0 = {
+	.name = "MC0",
+	.keepalive = true,
+	.num_nodes = 1,
+	.nodes = { &ebi },
+};
+
+static struct qcom_icc_bcm bcm_mm0 = {
+	.name = "MM0",
+	.keepalive = true,
+	.num_nodes = 5,
+	.nodes = { &qnm_camnoc_hf,
+		   &qnm_mdp0_0,
+		   &qnm_mdp0_1,
+		   &qnm_mdp1_0,
+		   &qns_mem_noc_hf
+	},
+};
+
+static struct qcom_icc_bcm bcm_mm1 = {
+	.name = "MM1",
+	.num_nodes = 8,
+	.nodes = { &qnm_rot_0,
+		   &qnm_rot_1,
+		   &qnm_video0,
+		   &qnm_video1,
+		   &qnm_video_cvp,
+		   &qxm_camnoc_icp,
+		   &qxm_camnoc_sf,
+		   &qns_mem_noc_sf
+	},
+};
+
+static struct qcom_icc_bcm bcm_nsa0 = {
+	.name = "NSA0",
+	.num_nodes = 2,
+	.nodes = { &qns_nsp_gemnoc,
+		   &qxs_nsp_xfr
+	},
+};
+
+static struct qcom_icc_bcm bcm_nsa1 = {
+	.name = "NSA1",
+	.num_nodes = 1,
+	.nodes = { &qxm_nsp },
+};
+
+static struct qcom_icc_bcm bcm_nsb0 = {
+	.name = "NSB0",
+	.num_nodes = 2,
+	.nodes = { &qns_nspb_gemnoc,
+		   &qxs_nspb_xfr
+	},
+};
+
+static struct qcom_icc_bcm bcm_nsb1 = {
+	.name = "NSB1",
+	.num_nodes = 1,
+	.nodes = { &qxm_nspb },
+};
+
+static struct qcom_icc_bcm bcm_pci0 = {
+	.name = "PCI0",
+	.num_nodes = 1,
+	/*
+	 * TODO: Downstream does not have PCIE0 as keepalive, but turning it
+	 * off causes the platform to hang. So leave it keepaliv for now.
+	 */
+	.keepalive = true,
+	.nodes = { &qns_pcie_gem_noc },
+};
+
+static struct qcom_icc_bcm bcm_qup0 = {
+	.name = "QUP0",
+	.vote_scale = 1,
+	.num_nodes = 1,
+	.nodes = { &qup0_core_slave },
+};
+
+static struct qcom_icc_bcm bcm_qup1 = {
+	.name = "QUP1",
+	.vote_scale = 1,
+	.num_nodes = 1,
+	.nodes = { &qup1_core_slave },
+};
+
+static struct qcom_icc_bcm bcm_qup2 = {
+	.name = "QUP2",
+	.vote_scale = 1,
+	.num_nodes = 1,
+	.nodes = { &qup2_core_slave },
+};
+
+static struct qcom_icc_bcm bcm_sh0 = {
+	.name = "SH0",
+	.keepalive = true,
+	.num_nodes = 1,
+	.nodes = { &qns_llcc },
+};
+
+static struct qcom_icc_bcm bcm_sh2 = {
+	.name = "SH2",
+	.num_nodes = 1,
+	.nodes = { &chm_apps },
+};
+
+static struct qcom_icc_bcm bcm_sn0 = {
+	.name = "SN0",
+	.keepalive = true,
+	.num_nodes = 1,
+	.nodes = { &qns_gemnoc_sf },
+};
+
+static struct qcom_icc_bcm bcm_sn1 = {
+	.name = "SN1",
+	.num_nodes = 1,
+	.nodes = { &qns_gemnoc_gc },
+};
+
+static struct qcom_icc_bcm bcm_sn2 = {
+	.name = "SN2",
+	.num_nodes = 1,
+	.nodes = { &qxs_pimem },
+};
+
+static struct qcom_icc_bcm bcm_sn3 = {
+	.name = "SN3",
+	.num_nodes = 2,
+	.nodes = { &qns_a1noc_snoc,
+		   &qnm_aggre1_noc
+	},
+};
+
+static struct qcom_icc_bcm bcm_sn4 = {
+	.name = "SN4",
+	.num_nodes = 2,
+	.nodes = { &qns_a2noc_snoc,
+		   &qnm_aggre2_noc
+	},
+};
+
+static struct qcom_icc_bcm bcm_sn5 = {
+	.name = "SN5",
+	.num_nodes = 2,
+	.nodes = { &qns_aggre_usb_snoc,
+		   &qnm_aggre_usb_noc
+	},
+};
+
+static struct qcom_icc_bcm bcm_sn9 = {
+	.name = "SN9",
+	.num_nodes = 2,
+	.nodes = { &qns_sysnoc,
+		   &qnm_lpass_noc
+	},
+};
+
+static struct qcom_icc_bcm bcm_sn10 = {
+	.name = "SN10",
+	.num_nodes = 1,
+	.nodes = { &xs_qdss_stm },
+};
+
+static struct qcom_icc_bcm *aggre1_noc_bcms[] = {
+	&bcm_sn3,
+	&bcm_sn5,
+};
+
+static struct qcom_icc_node *aggre1_noc_nodes[] = {
+	[MASTER_QSPI_0] = &qhm_qspi,
+	[MASTER_QUP_1] = &qhm_qup1,
+	[MASTER_QUP_2] = &qhm_qup2,
+	[MASTER_A1NOC_CFG] = &qnm_a1noc_cfg,
+	[MASTER_IPA] = &qxm_ipa,
+	[MASTER_EMAC_1] = &xm_emac_1,
+	[MASTER_SDCC_4] = &xm_sdc4,
+	[MASTER_UFS_MEM] = &xm_ufs_mem,
+	[MASTER_USB3_0] = &xm_usb3_0,
+	[MASTER_USB3_1] = &xm_usb3_1,
+	[MASTER_USB3_MP] = &xm_usb3_mp,
+	[MASTER_USB4_0] = &xm_usb4_host0,
+	[MASTER_USB4_1] = &xm_usb4_host1,
+	[SLAVE_A1NOC_SNOC] = &qns_a1noc_snoc,
+	[SLAVE_USB_NOC_SNOC] = &qns_aggre_usb_snoc,
+	[SLAVE_SERVICE_A1NOC] = &srvc_aggre1_noc,
+};
+
+static struct qcom_icc_desc sc8280xp_aggre1_noc = {
+	.nodes = aggre1_noc_nodes,
+	.num_nodes = ARRAY_SIZE(aggre1_noc_nodes),
+	.bcms = aggre1_noc_bcms,
+	.num_bcms = ARRAY_SIZE(aggre1_noc_bcms),
+};
+
+static struct qcom_icc_bcm *aggre2_noc_bcms[] = {
+	&bcm_ce0,
+	&bcm_pci0,
+	&bcm_sn4,
+};
+
+static struct qcom_icc_node *aggre2_noc_nodes[] = {
+	[MASTER_QDSS_BAM] = &qhm_qdss_bam,
+	[MASTER_QUP_0] = &qhm_qup0,
+	[MASTER_A2NOC_CFG] = &qnm_a2noc_cfg,
+	[MASTER_CRYPTO] = &qxm_crypto,
+	[MASTER_SENSORS_PROC] = &qxm_sensorss_q6,
+	[MASTER_SP] = &qxm_sp,
+	[MASTER_EMAC] = &xm_emac_0,
+	[MASTER_PCIE_0] = &xm_pcie3_0,
+	[MASTER_PCIE_1] = &xm_pcie3_1,
+	[MASTER_PCIE_2A] = &xm_pcie3_2a,
+	[MASTER_PCIE_2B] = &xm_pcie3_2b,
+	[MASTER_PCIE_3A] = &xm_pcie3_3a,
+	[MASTER_PCIE_3B] = &xm_pcie3_3b,
+	[MASTER_PCIE_4] = &xm_pcie3_4,
+	[MASTER_QDSS_ETR] = &xm_qdss_etr,
+	[MASTER_SDCC_2] = &xm_sdc2,
+	[MASTER_UFS_CARD] = &xm_ufs_card,
+	[SLAVE_A2NOC_SNOC] = &qns_a2noc_snoc,
+	[SLAVE_ANOC_PCIE_GEM_NOC] = &qns_pcie_gem_noc,
+	[SLAVE_SERVICE_A2NOC] = &srvc_aggre2_noc,
+};
+
+static struct qcom_icc_desc sc8280xp_aggre2_noc = {
+	.nodes = aggre2_noc_nodes,
+	.num_nodes = ARRAY_SIZE(aggre2_noc_nodes),
+	.bcms = aggre2_noc_bcms,
+	.num_bcms = ARRAY_SIZE(aggre2_noc_bcms),
+};
+
+static struct qcom_icc_bcm *clk_virt_bcms[] = {
+	&bcm_ip0,
+	&bcm_qup0,
+	&bcm_qup1,
+	&bcm_qup2,
+};
+
+static struct qcom_icc_node *clk_virt_nodes[] = {
+	[MASTER_IPA_CORE] = &ipa_core_master,
+	[MASTER_QUP_CORE_0] = &qup0_core_master,
+	[MASTER_QUP_CORE_1] = &qup1_core_master,
+	[MASTER_QUP_CORE_2] = &qup2_core_master,
+	[SLAVE_IPA_CORE] = &ipa_core_slave,
+	[SLAVE_QUP_CORE_0] = &qup0_core_slave,
+	[SLAVE_QUP_CORE_1] = &qup1_core_slave,
+	[SLAVE_QUP_CORE_2] = &qup2_core_slave,
+};
+
+static struct qcom_icc_desc sc8280xp_clk_virt = {
+	.nodes = clk_virt_nodes,
+	.num_nodes = ARRAY_SIZE(clk_virt_nodes),
+	.bcms = clk_virt_bcms,
+	.num_bcms = ARRAY_SIZE(clk_virt_bcms),
+};
+
+static struct qcom_icc_bcm *config_noc_bcms[] = {
+	&bcm_cn0,
+	&bcm_cn1,
+	&bcm_cn2,
+	&bcm_cn3,
+	&bcm_sn2,
+	&bcm_sn10,
+};
+
+static struct qcom_icc_node *config_noc_nodes[] = {
+	[MASTER_GEM_NOC_CNOC] = &qnm_gemnoc_cnoc,
+	[MASTER_GEM_NOC_PCIE_SNOC] = &qnm_gemnoc_pcie,
+	[SLAVE_AHB2PHY_0] = &qhs_ahb2phy0,
+	[SLAVE_AHB2PHY_1] = &qhs_ahb2phy1,
+	[SLAVE_AHB2PHY_2] = &qhs_ahb2phy2,
+	[SLAVE_AOSS] = &qhs_aoss,
+	[SLAVE_APPSS] = &qhs_apss,
+	[SLAVE_CAMERA_CFG] = &qhs_camera_cfg,
+	[SLAVE_CLK_CTL] = &qhs_clk_ctl,
+	[SLAVE_CDSP_CFG] = &qhs_compute0_cfg,
+	[SLAVE_CDSP1_CFG] = &qhs_compute1_cfg,
+	[SLAVE_RBCPR_CX_CFG] = &qhs_cpr_cx,
+	[SLAVE_RBCPR_MMCX_CFG] = &qhs_cpr_mmcx,
+	[SLAVE_RBCPR_MX_CFG] = &qhs_cpr_mx,
+	[SLAVE_CPR_NSPCX] = &qhs_cpr_nspcx,
+	[SLAVE_CRYPTO_0_CFG] = &qhs_crypto0_cfg,
+	[SLAVE_CX_RDPM] = &qhs_cx_rdpm,
+	[SLAVE_DCC_CFG] = &qhs_dcc_cfg,
+	[SLAVE_DISPLAY_CFG] = &qhs_display0_cfg,
+	[SLAVE_DISPLAY1_CFG] = &qhs_display1_cfg,
+	[SLAVE_EMAC_CFG] = &qhs_emac0_cfg,
+	[SLAVE_EMAC1_CFG] = &qhs_emac1_cfg,
+	[SLAVE_GFX3D_CFG] = &qhs_gpuss_cfg,
+	[SLAVE_HWKM] = &qhs_hwkm,
+	[SLAVE_IMEM_CFG] = &qhs_imem_cfg,
+	[SLAVE_IPA_CFG] = &qhs_ipa,
+	[SLAVE_IPC_ROUTER_CFG] = &qhs_ipc_router,
+	[SLAVE_LPASS] = &qhs_lpass_cfg,
+	[SLAVE_MX_RDPM] = &qhs_mx_rdpm,
+	[SLAVE_MXC_RDPM] = &qhs_mxc_rdpm,
+	[SLAVE_PCIE_0_CFG] = &qhs_pcie0_cfg,
+	[SLAVE_PCIE_1_CFG] = &qhs_pcie1_cfg,
+	[SLAVE_PCIE_2A_CFG] = &qhs_pcie2a_cfg,
+	[SLAVE_PCIE_2B_CFG] = &qhs_pcie2b_cfg,
+	[SLAVE_PCIE_3A_CFG] = &qhs_pcie3a_cfg,
+	[SLAVE_PCIE_3B_CFG] = &qhs_pcie3b_cfg,
+	[SLAVE_PCIE_4_CFG] = &qhs_pcie4_cfg,
+	[SLAVE_PCIE_RSC_CFG] = &qhs_pcie_rsc_cfg,
+	[SLAVE_PDM] = &qhs_pdm,
+	[SLAVE_PIMEM_CFG] = &qhs_pimem_cfg,
+	[SLAVE_PKA_WRAPPER_CFG] = &qhs_pka_wrapper_cfg,
+	[SLAVE_PMU_WRAPPER_CFG] = &qhs_pmu_wrapper_cfg,
+	[SLAVE_QDSS_CFG] = &qhs_qdss_cfg,
+	[SLAVE_QSPI_0] = &qhs_qspi,
+	[SLAVE_QUP_0] = &qhs_qup0,
+	[SLAVE_QUP_1] = &qhs_qup1,
+	[SLAVE_QUP_2] = &qhs_qup2,
+	[SLAVE_SDCC_2] = &qhs_sdc2,
+	[SLAVE_SDCC_4] = &qhs_sdc4,
+	[SLAVE_SECURITY] = &qhs_security,
+	[SLAVE_SMMUV3_CFG] = &qhs_smmuv3_cfg,
+	[SLAVE_SMSS_CFG] = &qhs_smss_cfg,
+	[SLAVE_SPSS_CFG] = &qhs_spss_cfg,
+	[SLAVE_TCSR] = &qhs_tcsr,
+	[SLAVE_TLMM] = &qhs_tlmm,
+	[SLAVE_UFS_CARD_CFG] = &qhs_ufs_card_cfg,
+	[SLAVE_UFS_MEM_CFG] = &qhs_ufs_mem_cfg,
+	[SLAVE_USB3_0] = &qhs_usb3_0,
+	[SLAVE_USB3_1] = &qhs_usb3_1,
+	[SLAVE_USB3_MP] = &qhs_usb3_mp,
+	[SLAVE_USB4_0] = &qhs_usb4_host_0,
+	[SLAVE_USB4_1] = &qhs_usb4_host_1,
+	[SLAVE_VENUS_CFG] = &qhs_venus_cfg,
+	[SLAVE_VSENSE_CTRL_CFG] = &qhs_vsense_ctrl_cfg,
+	[SLAVE_VSENSE_CTRL_R_CFG] = &qhs_vsense_ctrl_r_cfg,
+	[SLAVE_A1NOC_CFG] = &qns_a1_noc_cfg,
+	[SLAVE_A2NOC_CFG] = &qns_a2_noc_cfg,
+	[SLAVE_ANOC_PCIE_BRIDGE_CFG] = &qns_anoc_pcie_bridge_cfg,
+	[SLAVE_DDRSS_CFG] = &qns_ddrss_cfg,
+	[SLAVE_CNOC_MNOC_CFG] = &qns_mnoc_cfg,
+	[SLAVE_SNOC_CFG] = &qns_snoc_cfg,
+	[SLAVE_SNOC_SF_BRIDGE_CFG] = &qns_snoc_sf_bridge_cfg,
+	[SLAVE_IMEM] = &qxs_imem,
+	[SLAVE_PIMEM] = &qxs_pimem,
+	[SLAVE_SERVICE_CNOC] = &srvc_cnoc,
+	[SLAVE_PCIE_0] = &xs_pcie_0,
+	[SLAVE_PCIE_1] = &xs_pcie_1,
+	[SLAVE_PCIE_2A] = &xs_pcie_2a,
+	[SLAVE_PCIE_2B] = &xs_pcie_2b,
+	[SLAVE_PCIE_3A] = &xs_pcie_3a,
+	[SLAVE_PCIE_3B] = &xs_pcie_3b,
+	[SLAVE_PCIE_4] = &xs_pcie_4,
+	[SLAVE_QDSS_STM] = &xs_qdss_stm,
+	[SLAVE_SMSS] = &xs_smss,
+	[SLAVE_TCU] = &xs_sys_tcu_cfg,
+};
+
+static struct qcom_icc_desc sc8280xp_config_noc = {
+	.nodes = config_noc_nodes,
+	.num_nodes = ARRAY_SIZE(config_noc_nodes),
+	.bcms = config_noc_bcms,
+	.num_bcms = ARRAY_SIZE(config_noc_bcms),
+};
+
+static struct qcom_icc_bcm *dc_noc_bcms[] = {
+};
+
+static struct qcom_icc_node *dc_noc_nodes[] = {
+	[MASTER_CNOC_DC_NOC] = &qnm_cnoc_dc_noc,
+	[SLAVE_LLCC_CFG] = &qhs_llcc,
+	[SLAVE_GEM_NOC_CFG] = &qns_gemnoc,
+};
+
+static struct qcom_icc_desc sc8280xp_dc_noc = {
+	.nodes = dc_noc_nodes,
+	.num_nodes = ARRAY_SIZE(dc_noc_nodes),
+	.bcms = dc_noc_bcms,
+	.num_bcms = ARRAY_SIZE(dc_noc_bcms),
+};
+
+static struct qcom_icc_bcm *gem_noc_bcms[] = {
+	&bcm_sh0,
+	&bcm_sh2,
+};
+
+static struct qcom_icc_node *gem_noc_nodes[] = {
+	[MASTER_GPU_TCU] = &alm_gpu_tcu,
+	[MASTER_PCIE_TCU] = &alm_pcie_tcu,
+	[MASTER_SYS_TCU] = &alm_sys_tcu,
+	[MASTER_APPSS_PROC] = &chm_apps,
+	[MASTER_COMPUTE_NOC] = &qnm_cmpnoc0,
+	[MASTER_COMPUTE_NOC_1] = &qnm_cmpnoc1,
+	[MASTER_GEM_NOC_CFG] = &qnm_gemnoc_cfg,
+	[MASTER_GFX3D] = &qnm_gpu,
+	[MASTER_MNOC_HF_MEM_NOC] = &qnm_mnoc_hf,
+	[MASTER_MNOC_SF_MEM_NOC] = &qnm_mnoc_sf,
+	[MASTER_ANOC_PCIE_GEM_NOC] = &qnm_pcie,
+	[MASTER_SNOC_GC_MEM_NOC] = &qnm_snoc_gc,
+	[MASTER_SNOC_SF_MEM_NOC] = &qnm_snoc_sf,
+	[SLAVE_GEM_NOC_CNOC] = &qns_gem_noc_cnoc,
+	[SLAVE_LLCC] = &qns_llcc,
+	[SLAVE_GEM_NOC_PCIE_CNOC] = &qns_pcie,
+	[SLAVE_SERVICE_GEM_NOC_1] = &srvc_even_gemnoc,
+	[SLAVE_SERVICE_GEM_NOC_2] = &srvc_odd_gemnoc,
+	[SLAVE_SERVICE_GEM_NOC] = &srvc_sys_gemnoc,
+};
+
+static struct qcom_icc_desc sc8280xp_gem_noc = {
+	.nodes = gem_noc_nodes,
+	.num_nodes = ARRAY_SIZE(gem_noc_nodes),
+	.bcms = gem_noc_bcms,
+	.num_bcms = ARRAY_SIZE(gem_noc_bcms),
+};
+
+static struct qcom_icc_bcm *lpass_ag_noc_bcms[] = {
+	&bcm_sn9,
+};
+
+static struct qcom_icc_node *lpass_ag_noc_nodes[] = {
+	[MASTER_CNOC_LPASS_AG_NOC] = &qhm_config_noc,
+	[MASTER_LPASS_PROC] = &qxm_lpass_dsp,
+	[SLAVE_LPASS_CORE_CFG] = &qhs_lpass_core,
+	[SLAVE_LPASS_LPI_CFG] = &qhs_lpass_lpi,
+	[SLAVE_LPASS_MPU_CFG] = &qhs_lpass_mpu,
+	[SLAVE_LPASS_TOP_CFG] = &qhs_lpass_top,
+	[SLAVE_LPASS_SNOC] = &qns_sysnoc,
+	[SLAVE_SERVICES_LPASS_AML_NOC] = &srvc_niu_aml_noc,
+	[SLAVE_SERVICE_LPASS_AG_NOC] = &srvc_niu_lpass_agnoc,
+};
+
+static struct qcom_icc_desc sc8280xp_lpass_ag_noc = {
+	.nodes = lpass_ag_noc_nodes,
+	.num_nodes = ARRAY_SIZE(lpass_ag_noc_nodes),
+	.bcms = lpass_ag_noc_bcms,
+	.num_bcms = ARRAY_SIZE(lpass_ag_noc_bcms),
+};
+
+static struct qcom_icc_bcm *mc_virt_bcms[] = {
+	&bcm_acv,
+	&bcm_mc0,
+};
+
+static struct qcom_icc_node *mc_virt_nodes[] = {
+	[MASTER_LLCC] = &llcc_mc,
+	[SLAVE_EBI1] = &ebi,
+};
+
+static struct qcom_icc_desc sc8280xp_mc_virt = {
+	.nodes = mc_virt_nodes,
+	.num_nodes = ARRAY_SIZE(mc_virt_nodes),
+	.bcms = mc_virt_bcms,
+	.num_bcms = ARRAY_SIZE(mc_virt_bcms),
+};
+
+static struct qcom_icc_bcm *mmss_noc_bcms[] = {
+	&bcm_mm0,
+	&bcm_mm1,
+};
+
+static struct qcom_icc_node *mmss_noc_nodes[] = {
+	[MASTER_CAMNOC_HF] = &qnm_camnoc_hf,
+	[MASTER_MDP0] = &qnm_mdp0_0,
+	[MASTER_MDP1] = &qnm_mdp0_1,
+	[MASTER_MDP_CORE1_0] = &qnm_mdp1_0,
+	[MASTER_MDP_CORE1_1] = &qnm_mdp1_1,
+	[MASTER_CNOC_MNOC_CFG] = &qnm_mnoc_cfg,
+	[MASTER_ROTATOR] = &qnm_rot_0,
+	[MASTER_ROTATOR_1] = &qnm_rot_1,
+	[MASTER_VIDEO_P0] = &qnm_video0,
+	[MASTER_VIDEO_P1] = &qnm_video1,
+	[MASTER_VIDEO_PROC] = &qnm_video_cvp,
+	[MASTER_CAMNOC_ICP] = &qxm_camnoc_icp,
+	[MASTER_CAMNOC_SF] = &qxm_camnoc_sf,
+	[SLAVE_MNOC_HF_MEM_NOC] = &qns_mem_noc_hf,
+	[SLAVE_MNOC_SF_MEM_NOC] = &qns_mem_noc_sf,
+	[SLAVE_SERVICE_MNOC] = &srvc_mnoc,
+};
+
+static struct qcom_icc_desc sc8280xp_mmss_noc = {
+	.nodes = mmss_noc_nodes,
+	.num_nodes = ARRAY_SIZE(mmss_noc_nodes),
+	.bcms = mmss_noc_bcms,
+	.num_bcms = ARRAY_SIZE(mmss_noc_bcms),
+};
+
+static struct qcom_icc_bcm *nspa_noc_bcms[] = {
+	&bcm_nsa0,
+	&bcm_nsa1,
+};
+
+static struct qcom_icc_node *nspa_noc_nodes[] = {
+	[MASTER_CDSP_NOC_CFG] = &qhm_nsp_noc_config,
+	[MASTER_CDSP_PROC] = &qxm_nsp,
+	[SLAVE_CDSP_MEM_NOC] = &qns_nsp_gemnoc,
+	[SLAVE_NSP_XFR] = &qxs_nsp_xfr,
+	[SLAVE_SERVICE_NSP_NOC] = &service_nsp_noc,
+};
+
+static struct qcom_icc_desc sc8280xp_nspa_noc = {
+	.nodes = nspa_noc_nodes,
+	.num_nodes = ARRAY_SIZE(nspa_noc_nodes),
+	.bcms = nspa_noc_bcms,
+	.num_bcms = ARRAY_SIZE(nspa_noc_bcms),
+};
+
+static struct qcom_icc_bcm *nspb_noc_bcms[] = {
+	&bcm_nsb0,
+	&bcm_nsb1,
+};
+
+static struct qcom_icc_node *nspb_noc_nodes[] = {
+	[MASTER_CDSPB_NOC_CFG] = &qhm_nspb_noc_config,
+	[MASTER_CDSP_PROC_B] = &qxm_nspb,
+	[SLAVE_CDSPB_MEM_NOC] = &qns_nspb_gemnoc,
+	[SLAVE_NSPB_XFR] = &qxs_nspb_xfr,
+	[SLAVE_SERVICE_NSPB_NOC] = &service_nspb_noc,
+};
+
+static struct qcom_icc_desc sc8280xp_nspb_noc = {
+	.nodes = nspb_noc_nodes,
+	.num_nodes = ARRAY_SIZE(nspb_noc_nodes),
+	.bcms = nspb_noc_bcms,
+	.num_bcms = ARRAY_SIZE(nspb_noc_bcms),
+};
+
+static struct qcom_icc_bcm *system_noc_main_bcms[] = {
+	&bcm_sn0,
+	&bcm_sn1,
+	&bcm_sn3,
+	&bcm_sn4,
+	&bcm_sn5,
+	&bcm_sn9,
+};
+
+static struct qcom_icc_node *system_noc_main_nodes[] = {
+	[MASTER_A1NOC_SNOC] = &qnm_aggre1_noc,
+	[MASTER_A2NOC_SNOC] = &qnm_aggre2_noc,
+	[MASTER_USB_NOC_SNOC] = &qnm_aggre_usb_noc,
+	[MASTER_LPASS_ANOC] = &qnm_lpass_noc,
+	[MASTER_SNOC_CFG] = &qnm_snoc_cfg,
+	[MASTER_PIMEM] = &qxm_pimem,
+	[MASTER_GIC] = &xm_gic,
+	[SLAVE_SNOC_GEM_NOC_GC] = &qns_gemnoc_gc,
+	[SLAVE_SNOC_GEM_NOC_SF] = &qns_gemnoc_sf,
+	[SLAVE_SERVICE_SNOC] = &srvc_snoc,
+};
+
+static struct qcom_icc_desc sc8280xp_system_noc_main = {
+	.nodes = system_noc_main_nodes,
+	.num_nodes = ARRAY_SIZE(system_noc_main_nodes),
+	.bcms = system_noc_main_bcms,
+	.num_bcms = ARRAY_SIZE(system_noc_main_bcms),
+};
+
+static const struct of_device_id qnoc_of_match[] = {
+	{ .compatible = "qcom,sc8280xp-aggre1_noc", .data = &sc8280xp_aggre1_noc, },
+	{ .compatible = "qcom,sc8280xp-aggre2_noc", .data = &sc8280xp_aggre2_noc, },
+	{ .compatible = "qcom,sc8280xp-clk_virt", .data = &sc8280xp_clk_virt, },
+	{ .compatible = "qcom,sc8280xp-config_noc", .data = &sc8280xp_config_noc, },
+	{ .compatible = "qcom,sc8280xp-dc_noc", .data = &sc8280xp_dc_noc, },
+	{ .compatible = "qcom,sc8280xp-gem_noc", .data = &sc8280xp_gem_noc, },
+	{ .compatible = "qcom,sc8280xp-lpass_ag_noc", .data = &sc8280xp_lpass_ag_noc, },
+	{ .compatible = "qcom,sc8280xp-mc_virt", .data = &sc8280xp_mc_virt, },
+	{ .compatible = "qcom,sc8280xp-mmss_noc", .data = &sc8280xp_mmss_noc, },
+	{ .compatible = "qcom,sc8280xp-nspa_noc", .data = &sc8280xp_nspa_noc, },
+	{ .compatible = "qcom,sc8280xp-nspb_noc", .data = &sc8280xp_nspb_noc, },
+	{ .compatible = "qcom,sc8280xp-system_noc_main", .data = &sc8280xp_system_noc_main, },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, qnoc_of_match);
+
+static struct platform_driver qnoc_driver = {
+	.probe = qcom_icc_rpmh_probe,
+	.remove = qcom_icc_rpmh_remove,
+	.driver = {
+		.name = "qnoc-sc8280xp",
+		.of_match_table = qnoc_of_match,
+		.sync_state = icc_sync_state,
+	},
+};
+
+static int __init qnoc_driver_init(void)
+{
+	return platform_driver_register(&qnoc_driver);
+}
+core_initcall(qnoc_driver_init);
+
+static void __exit qnoc_driver_exit(void)
+{
+	platform_driver_unregister(&qnoc_driver);
+}
+module_exit(qnoc_driver_exit);
+
+MODULE_DESCRIPTION("Qualcomm SC8280XP NoC driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/interconnect/qcom/sc8280xp.h b/drivers/interconnect/qcom/sc8280xp.h
new file mode 100644
index 000000000000..74d8fa412d65
--- /dev/null
+++ b/drivers/interconnect/qcom/sc8280xp.h
@@ -0,0 +1,209 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2021, The Linux Foundation. All rights reserved.
+ */
+
+#ifndef __DRIVERS_INTERCONNECT_QCOM_SC8280XP_H
+#define __DRIVERS_INTERCONNECT_QCOM_SC8280XP_H
+
+#define SC8280XP_MASTER_GPU_TCU				0
+#define SC8280XP_MASTER_PCIE_TCU			1
+#define SC8280XP_MASTER_SYS_TCU				2
+#define SC8280XP_MASTER_APPSS_PROC			3
+#define SC8280XP_MASTER_IPA_CORE			4
+#define SC8280XP_MASTER_LLCC				5
+#define SC8280XP_MASTER_CNOC_LPASS_AG_NOC		6
+#define SC8280XP_MASTER_CDSP_NOC_CFG			7
+#define SC8280XP_MASTER_CDSPB_NOC_CFG			8
+#define SC8280XP_MASTER_QDSS_BAM			9
+#define SC8280XP_MASTER_QSPI_0				10
+#define SC8280XP_MASTER_QUP_0				11
+#define SC8280XP_MASTER_QUP_1				12
+#define SC8280XP_MASTER_QUP_2				13
+#define SC8280XP_MASTER_A1NOC_CFG			14
+#define SC8280XP_MASTER_A2NOC_CFG			15
+#define SC8280XP_MASTER_A1NOC_SNOC			16
+#define SC8280XP_MASTER_A2NOC_SNOC			17
+#define SC8280XP_MASTER_USB_NOC_SNOC			18
+#define SC8280XP_MASTER_CAMNOC_HF			19
+#define SC8280XP_MASTER_COMPUTE_NOC			20
+#define SC8280XP_MASTER_COMPUTE_NOC_1			21
+#define SC8280XP_MASTER_CNOC_DC_NOC			22
+#define SC8280XP_MASTER_GEM_NOC_CFG			23
+#define SC8280XP_MASTER_GEM_NOC_CNOC			24
+#define SC8280XP_MASTER_GEM_NOC_PCIE_SNOC		25
+#define SC8280XP_MASTER_GFX3D				26
+#define SC8280XP_MASTER_LPASS_ANOC			27
+#define SC8280XP_MASTER_MDP0				28
+#define SC8280XP_MASTER_MDP1				29
+#define SC8280XP_MASTER_MDP_CORE1_0			30
+#define SC8280XP_MASTER_MDP_CORE1_1			31
+#define SC8280XP_MASTER_CNOC_MNOC_CFG			32
+#define SC8280XP_MASTER_MNOC_HF_MEM_NOC			33
+#define SC8280XP_MASTER_MNOC_SF_MEM_NOC			34
+#define SC8280XP_MASTER_ANOC_PCIE_GEM_NOC		35
+#define SC8280XP_MASTER_ROTATOR				36
+#define SC8280XP_MASTER_ROTATOR_1			37
+#define SC8280XP_MASTER_SNOC_CFG			38
+#define SC8280XP_MASTER_SNOC_GC_MEM_NOC			39
+#define SC8280XP_MASTER_SNOC_SF_MEM_NOC			40
+#define SC8280XP_MASTER_VIDEO_P0			41
+#define SC8280XP_MASTER_VIDEO_P1			42
+#define SC8280XP_MASTER_VIDEO_PROC			43
+#define SC8280XP_MASTER_QUP_CORE_0			44
+#define SC8280XP_MASTER_QUP_CORE_1			45
+#define SC8280XP_MASTER_QUP_CORE_2			46
+#define SC8280XP_MASTER_CAMNOC_ICP			47
+#define SC8280XP_MASTER_CAMNOC_SF			48
+#define SC8280XP_MASTER_CRYPTO				49
+#define SC8280XP_MASTER_IPA				50
+#define SC8280XP_MASTER_LPASS_PROC			51
+#define SC8280XP_MASTER_CDSP_PROC			52
+#define SC8280XP_MASTER_CDSP_PROC_B			53
+#define SC8280XP_MASTER_PIMEM				54
+#define SC8280XP_MASTER_SENSORS_PROC			55
+#define SC8280XP_MASTER_SP				56
+#define SC8280XP_MASTER_EMAC				57
+#define SC8280XP_MASTER_EMAC_1				58
+#define SC8280XP_MASTER_GIC				59
+#define SC8280XP_MASTER_PCIE_0				60
+#define SC8280XP_MASTER_PCIE_1				61
+#define SC8280XP_MASTER_PCIE_2A				62
+#define SC8280XP_MASTER_PCIE_2B				63
+#define SC8280XP_MASTER_PCIE_3A				64
+#define SC8280XP_MASTER_PCIE_3B				65
+#define SC8280XP_MASTER_PCIE_4				66
+#define SC8280XP_MASTER_QDSS_ETR			67
+#define SC8280XP_MASTER_SDCC_2				68
+#define SC8280XP_MASTER_SDCC_4				69
+#define SC8280XP_MASTER_UFS_CARD			70
+#define SC8280XP_MASTER_UFS_MEM				71
+#define SC8280XP_MASTER_USB3_0				72
+#define SC8280XP_MASTER_USB3_1				73
+#define SC8280XP_MASTER_USB3_MP				74
+#define SC8280XP_MASTER_USB4_0				75
+#define SC8280XP_MASTER_USB4_1				76
+#define SC8280XP_SLAVE_EBI1				512
+#define SC8280XP_SLAVE_IPA_CORE				513
+#define SC8280XP_SLAVE_AHB2PHY_0			514
+#define SC8280XP_SLAVE_AHB2PHY_1			515
+#define SC8280XP_SLAVE_AHB2PHY_2			516
+#define SC8280XP_SLAVE_AOSS				517
+#define SC8280XP_SLAVE_APPSS				518
+#define SC8280XP_SLAVE_CAMERA_CFG			519
+#define SC8280XP_SLAVE_CLK_CTL				520
+#define SC8280XP_SLAVE_CDSP_CFG				521
+#define SC8280XP_SLAVE_CDSP1_CFG			522
+#define SC8280XP_SLAVE_RBCPR_CX_CFG			523
+#define SC8280XP_SLAVE_RBCPR_MMCX_CFG			524
+#define SC8280XP_SLAVE_RBCPR_MX_CFG			525
+#define SC8280XP_SLAVE_CPR_NSPCX			526
+#define SC8280XP_SLAVE_CRYPTO_0_CFG			527
+#define SC8280XP_SLAVE_CX_RDPM				528
+#define SC8280XP_SLAVE_DCC_CFG				529
+#define SC8280XP_SLAVE_DISPLAY_CFG			530
+#define SC8280XP_SLAVE_DISPLAY1_CFG			531
+#define SC8280XP_SLAVE_EMAC_CFG				532
+#define SC8280XP_SLAVE_EMAC1_CFG			533
+#define SC8280XP_SLAVE_GFX3D_CFG			534
+#define SC8280XP_SLAVE_HWKM				535
+#define SC8280XP_SLAVE_IMEM_CFG				536
+#define SC8280XP_SLAVE_IPA_CFG				537
+#define SC8280XP_SLAVE_IPC_ROUTER_CFG			538
+#define SC8280XP_SLAVE_LLCC_CFG				539
+#define SC8280XP_SLAVE_LPASS				540
+#define SC8280XP_SLAVE_LPASS_CORE_CFG			541
+#define SC8280XP_SLAVE_LPASS_LPI_CFG			542
+#define SC8280XP_SLAVE_LPASS_MPU_CFG			543
+#define SC8280XP_SLAVE_LPASS_TOP_CFG			544
+#define SC8280XP_SLAVE_MX_RDPM				545
+#define SC8280XP_SLAVE_MXC_RDPM				546
+#define SC8280XP_SLAVE_PCIE_0_CFG			547
+#define SC8280XP_SLAVE_PCIE_1_CFG			548
+#define SC8280XP_SLAVE_PCIE_2A_CFG			549
+#define SC8280XP_SLAVE_PCIE_2B_CFG			550
+#define SC8280XP_SLAVE_PCIE_3A_CFG			551
+#define SC8280XP_SLAVE_PCIE_3B_CFG			552
+#define SC8280XP_SLAVE_PCIE_4_CFG			553
+#define SC8280XP_SLAVE_PCIE_RSC_CFG			554
+#define SC8280XP_SLAVE_PDM				555
+#define SC8280XP_SLAVE_PIMEM_CFG			556
+#define SC8280XP_SLAVE_PKA_WRAPPER_CFG			557
+#define SC8280XP_SLAVE_PMU_WRAPPER_CFG			558
+#define SC8280XP_SLAVE_QDSS_CFG				559
+#define SC8280XP_SLAVE_QSPI_0				560
+#define SC8280XP_SLAVE_QUP_0				561
+#define SC8280XP_SLAVE_QUP_1				562
+#define SC8280XP_SLAVE_QUP_2				563
+#define SC8280XP_SLAVE_SDCC_2				564
+#define SC8280XP_SLAVE_SDCC_4				565
+#define SC8280XP_SLAVE_SECURITY				566
+#define SC8280XP_SLAVE_SMMUV3_CFG			567
+#define SC8280XP_SLAVE_SMSS_CFG				568
+#define SC8280XP_SLAVE_SPSS_CFG				569
+#define SC8280XP_SLAVE_TCSR				570
+#define SC8280XP_SLAVE_TLMM				571
+#define SC8280XP_SLAVE_UFS_CARD_CFG			572
+#define SC8280XP_SLAVE_UFS_MEM_CFG			573
+#define SC8280XP_SLAVE_USB3_0				574
+#define SC8280XP_SLAVE_USB3_1				575
+#define SC8280XP_SLAVE_USB3_MP				576
+#define SC8280XP_SLAVE_USB4_0				577
+#define SC8280XP_SLAVE_USB4_1				578
+#define SC8280XP_SLAVE_VENUS_CFG			579
+#define SC8280XP_SLAVE_VSENSE_CTRL_CFG			580
+#define SC8280XP_SLAVE_VSENSE_CTRL_R_CFG		581
+#define SC8280XP_SLAVE_A1NOC_CFG			582
+#define SC8280XP_SLAVE_A1NOC_SNOC			583
+#define SC8280XP_SLAVE_A2NOC_CFG			584
+#define SC8280XP_SLAVE_A2NOC_SNOC			585
+#define SC8280XP_SLAVE_USB_NOC_SNOC			586
+#define SC8280XP_SLAVE_ANOC_PCIE_BRIDGE_CFG		587
+#define SC8280XP_SLAVE_DDRSS_CFG			588
+#define SC8280XP_SLAVE_GEM_NOC_CNOC			589
+#define SC8280XP_SLAVE_GEM_NOC_CFG			590
+#define SC8280XP_SLAVE_SNOC_GEM_NOC_GC			591
+#define SC8280XP_SLAVE_SNOC_GEM_NOC_SF			592
+#define SC8280XP_SLAVE_LLCC				593
+#define SC8280XP_SLAVE_MNOC_HF_MEM_NOC			594
+#define SC8280XP_SLAVE_MNOC_SF_MEM_NOC			595
+#define SC8280XP_SLAVE_CNOC_MNOC_CFG			596
+#define SC8280XP_SLAVE_CDSP_MEM_NOC			597
+#define SC8280XP_SLAVE_CDSPB_MEM_NOC			598
+#define SC8280XP_SLAVE_GEM_NOC_PCIE_CNOC		599
+#define SC8280XP_SLAVE_ANOC_PCIE_GEM_NOC		600
+#define SC8280XP_SLAVE_SNOC_CFG				601
+#define SC8280XP_SLAVE_SNOC_SF_BRIDGE_CFG		602
+#define SC8280XP_SLAVE_LPASS_SNOC			603
+#define SC8280XP_SLAVE_QUP_CORE_0			604
+#define SC8280XP_SLAVE_QUP_CORE_1			605
+#define SC8280XP_SLAVE_QUP_CORE_2			606
+#define SC8280XP_SLAVE_IMEM				607
+#define SC8280XP_SLAVE_NSP_XFR				608
+#define SC8280XP_SLAVE_NSPB_XFR				609
+#define SC8280XP_SLAVE_PIMEM				610
+#define SC8280XP_SLAVE_SERVICE_NSP_NOC			611
+#define SC8280XP_SLAVE_SERVICE_NSPB_NOC			612
+#define SC8280XP_SLAVE_SERVICE_A1NOC			613
+#define SC8280XP_SLAVE_SERVICE_A2NOC			614
+#define SC8280XP_SLAVE_SERVICE_CNOC			615
+#define SC8280XP_SLAVE_SERVICE_GEM_NOC_1		616
+#define SC8280XP_SLAVE_SERVICE_MNOC			617
+#define SC8280XP_SLAVE_SERVICES_LPASS_AML_NOC		618
+#define SC8280XP_SLAVE_SERVICE_LPASS_AG_NOC		619
+#define SC8280XP_SLAVE_SERVICE_GEM_NOC_2		620
+#define SC8280XP_SLAVE_SERVICE_SNOC			621
+#define SC8280XP_SLAVE_SERVICE_GEM_NOC			622
+#define SC8280XP_SLAVE_PCIE_0				623
+#define SC8280XP_SLAVE_PCIE_1				624
+#define SC8280XP_SLAVE_PCIE_2A				625
+#define SC8280XP_SLAVE_PCIE_2B				626
+#define SC8280XP_SLAVE_PCIE_3A				627
+#define SC8280XP_SLAVE_PCIE_3B				628
+#define SC8280XP_SLAVE_PCIE_4				629
+#define SC8280XP_SLAVE_QDSS_STM				630
+#define SC8280XP_SLAVE_SMSS				631
+#define SC8280XP_SLAVE_TCU				632
+
+#endif
+
-- 
2.33.1

