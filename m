Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75BA655C3EA
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232938AbiF1EzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 00:55:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbiF1EzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 00:55:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD5D160CE;
        Mon, 27 Jun 2022 21:55:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7D6956151E;
        Tue, 28 Jun 2022 04:55:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29FE4C3411D;
        Tue, 28 Jun 2022 04:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656392100;
        bh=pKE+a7g7L/t8hYaLuEve15Ffe9XPMi6MBm93nuboXAQ=;
        h=From:To:Cc:Subject:Date:From;
        b=oizYu/Fd4P1lCRhdo1G2t4xu98ZlZ2Cd6cay4sG6pbsvupTNnxQZa8exk1iUwrh9L
         KRRuISSdH8yEOu3Thup3m9rhS8hCiJrNRZ/a5tqAqi1z3kWCjrL6O14CJkA5fdudoZ
         PoS0dtzIVAKwv03AQaD3ZvaXAKYXF/qcaRdzC0vC/RHYuXUC9GZNfrAFequX6L7tKL
         o8Okx+XTYg25k7AdqvURU2iuXq9Z77xr1QkJQuJihwbFDjCChXtNwon3MyodJzv/pO
         Ub7cg0UQa0JDCTU1KFRLdSgTpOF5UiUQs6SnZLZzBgpVJk9f/jU1EVYCv/p2I03Q9i
         8ho4cpb6Y/1PA==
From:   Vinod Koul <vkoul@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] arm64: defconfig: Enable qcom ss & hs usb phy
Date:   Tue, 28 Jun 2022 10:24:53 +0530
Message-Id: <20220628045454.621175-1-vkoul@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These phys are used for USB controller found in QCS404 board, so enable
them in the defconfig

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---

Changes in v2: none

 arch/arm64/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 7d1105343bc2..6d3f4d8d50b8 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1197,6 +1197,8 @@ CONFIG_PHY_QCOM_QMP=m
 CONFIG_PHY_QCOM_QUSB2=m
 CONFIG_PHY_QCOM_USB_HS=y
 CONFIG_PHY_QCOM_USB_SNPS_FEMTO_V2=y
+CONFIG_PHY_QCOM_USB_HS_28NM=y
+CONFIG_PHY_QCOM_USB_SS=y
 CONFIG_PHY_RCAR_GEN3_PCIE=y
 CONFIG_PHY_RCAR_GEN3_USB2=y
 CONFIG_PHY_RCAR_GEN3_USB3=m
-- 
2.34.1

