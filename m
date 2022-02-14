Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E3754B4278
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 08:08:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240953AbiBNHFz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 02:05:55 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238165AbiBNHFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 02:05:53 -0500
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 189674F9DA
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 23:05:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1644822347; x=1676358347;
  h=from:to:cc:subject:date:message-id;
  bh=OjeT/TGYyRNnb0uHtQL7ANAPK9+9A+1f8diNaOzaOxo=;
  b=PR/GPJRNbg4Z4W/O/PsNgVOEXGvH/oG3f/NCjTkkypck34PFIPUvJxIB
   VQDk59yxqf9nVvRyVuKWWsmE0r4lD0EzFFWaYjdagGjgrJswgcTlWz7d0
   tcaYISnyt0ewJF9A23bZoX0VY25pavt9niEYD1i6DpcB2FT4bfTjIAyWT
   w=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 13 Feb 2022 23:05:47 -0800
X-QCInternal: smtphost
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 13 Feb 2022 23:05:46 -0800
X-QCInternal: smtphost
Received: from hu-rohiagar-hyd.qualcomm.com (HELO hu-sgudaval-hyd.qualcomm.com) ([10.213.106.138])
  by ironmsg01-blr.qualcomm.com with ESMTP; 14 Feb 2022 12:35:43 +0530
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3970568)
        id 109244473; Mon, 14 Feb 2022 12:35:42 +0530 (+0530)
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
To:     linux@armlinux.org.uk, mani@kernel.org, bjorn.andersson@linaro.org,
        sam@ravnborg.org, linus.walleij@linaro.org, dianders@chromium.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rohit Agarwal <quic_rohiagar@quicinc.com>
Subject: [PATCH 8/8] ARM: configs: qcom_defconfig: Enable SDX65 APCS clock
Date:   Mon, 14 Feb 2022 12:35:41 +0530
Message-Id: <1644822341-28035-1-git-send-email-quic_rohiagar@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable APCS clock driver on SDX65 platform.

Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
---
 arch/arm/configs/qcom_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/qcom_defconfig b/arch/arm/configs/qcom_defconfig
index 0daa9c0..bc545c4 100644
--- a/arch/arm/configs/qcom_defconfig
+++ b/arch/arm/configs/qcom_defconfig
@@ -218,6 +218,7 @@ CONFIG_STAGING=y
 CONFIG_COMMON_CLK_QCOM=y
 CONFIG_QCOM_A7PLL=y
 CONFIG_QCOM_CLK_APCS_SDX55=y
+CONFIG_QCOM_CLK_APCS_SDX65=y
 CONFIG_QCOM_CLK_RPM=y
 CONFIG_QCOM_CLK_RPMH=y
 CONFIG_QCOM_CLK_SMD_RPM=y
-- 
2.7.4

