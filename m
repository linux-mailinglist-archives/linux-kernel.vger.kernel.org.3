Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7FDB53FB83
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 12:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241222AbiFGKiv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 06:38:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239913AbiFGKio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 06:38:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1A2D21E02;
        Tue,  7 Jun 2022 03:38:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6708261507;
        Tue,  7 Jun 2022 10:38:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B168C34115;
        Tue,  7 Jun 2022 10:38:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654598321;
        bh=0TC8k1w8uVEnPJGctKOzfUABrzMHsmXTcZPtG/q+mgE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GAfoovYXzyWCjj80pWrI93eFexRuLQR/UP+M9lMYmUf+4rIHVfPgD7RXV709oH/S1
         d8eQsrnlH5n0NaTTKqrM1sVMxG6ZCiGGOPmjgA9MioLDmvgOZx+m50RPHLCal62WdB
         SOypPp8UQYVYJWzz4SqcgPEiRqHmxd1ggH+HLeeCFuKlT7xIsabI7vj7ZoAKPPEh6l
         0LL0MgJP/feU0INWE6W/vEIiRq6TJId8yVZ49UKztUPTx+gUV/q/5FQuwjsk1kArCZ
         dHSzywISyDi0A/tQfOtX5x9yMtoGcwujgdLEsaDvee6ELkE0tx+do8Q2oaqCUqW20e
         1sW9rlfJvja8w==
From:   Vinod Koul <vkoul@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] arm64: defconfig: Enable qcom interconnect drivers
Date:   Tue,  7 Jun 2022 16:08:31 +0530
Message-Id: <20220607103831.766162-2-vkoul@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220607103831.766162-1-vkoul@kernel.org>
References: <20220607103831.766162-1-vkoul@kernel.org>
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

While enabling QCS404 interconnect driver, I found that other drivers
are missing too, so add all the interconnect driver

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 arch/arm64/configs/defconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 6d3f4d8d50b8..fc5a340bcacd 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1249,7 +1249,11 @@ CONFIG_INTERCONNECT_IMX8MN=m
 CONFIG_INTERCONNECT_IMX8MQ=m
 CONFIG_INTERCONNECT_QCOM=y
 CONFIG_INTERCONNECT_QCOM_MSM8916=m
+CONFIG_INTERCONNECT_QCOM_MSM8974=m
+CONFIG_INTERCONNECT_QCOM_MSM8996=m
 CONFIG_INTERCONNECT_QCOM_OSM_L3=m
+CONFIG_INTERCONNECT_QCOM_QCS404=m
+CONFIG_INTERCONNECT_QCOM_SC7180=m
 CONFIG_INTERCONNECT_QCOM_SC7280=y
 CONFIG_INTERCONNECT_QCOM_SDM845=y
 CONFIG_INTERCONNECT_QCOM_SM8150=m
-- 
2.34.1

