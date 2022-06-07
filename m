Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D99AE53FB82
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 12:38:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241190AbiFGKis (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 06:38:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239832AbiFGKin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 06:38:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1731D14D0F;
        Tue,  7 Jun 2022 03:38:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CA924B81EDA;
        Tue,  7 Jun 2022 10:38:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9427C385A5;
        Tue,  7 Jun 2022 10:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654598319;
        bh=GKg9cyrVS4q56g3pOJOUkujNq7A106mJ8Uz6aqSinSo=;
        h=From:To:Cc:Subject:Date:From;
        b=QfDww+0QfJxp9F1oOHYUzXC8gHKusHSAaRWA5dfYfr/eRxd4z6zEjEm7tP3DdmbS5
         WWbzVxbeE+FHKzyuq6SiNtrPcIYCsG0Jzp9eQnRuBqC6wManP6grJ8i6bt7qDbUsWl
         7kSowbAZ33IY2FSxUYxij6pYINLw3fhYCr2DNdwA2SFpBVUTHVkY4sQc8ADgENzqyP
         lkReJMJAwhjRIGI2lFnNiYvjlsjP/LH2LTcvilEvP/n7T3qGMXz54tiyOT5l7pHPA2
         XlzZkmp14obViezbfzGI1J10Hj++dBjdfOzdt+N5ymVNteFjLxlsOw6JPeGp4Ue/+r
         reuGiZfoYX8wA==
From:   Vinod Koul <vkoul@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] arm64: defconfig: Enable qcom ss & hs usb phy
Date:   Tue,  7 Jun 2022 16:08:30 +0530
Message-Id: <20220607103831.766162-1-vkoul@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

