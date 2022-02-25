Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E476F4C3D5E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 05:41:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237440AbiBYElU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 23:41:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235603AbiBYElS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 23:41:18 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB532C3C36;
        Thu, 24 Feb 2022 20:40:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 383F2CE2286;
        Fri, 25 Feb 2022 04:40:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4E86C340E8;
        Fri, 25 Feb 2022 04:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645764044;
        bh=tPRjZ9n+/Xc8wfzPwQoRyVoCR0b0AGSmXFULvO0PWWk=;
        h=From:To:Cc:Subject:Date:From;
        b=ljhmILSYRjBCCHy2AdGuVfuB8zF2cQabRqNCTVcZU5RA+QfObBXsN5IzH8CHxzpFn
         p87qduepZKGJ2SW/fYBkdDSDLdXuwu0JXuA3Sh8KrklupiVrTiE1sS1Llk56jdAXHt
         Sq5HXAJYlrD2J54wm5cE2gyXZZkhx4FBxptMl85qzbRXApdzcHJHya2eYUTi095zT2
         0PL0AN89bY83mj2Y/EU0rkSkM4U8V5kB3vr/Iw4889NOs4mZ2R5Q3H3DKK748qYVxa
         fwaZiwsw4/sG7rcQkPJQElvQLtFRtpg9NSok2pxiSzg/SU/Izg61XqauV+b8ZJsuNl
         GuqkTdr7it55Q==
From:   Vinod Koul <vkoul@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] arm64: defconfig: Enable Qualcomm GPI DMA Driver
Date:   Fri, 25 Feb 2022 10:10:33 +0530
Message-Id: <20220225044033.1376769-1-vkoul@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Qualcomm GPI DMA Driver is used for DMA transfers for Serial engines
like Geni I2C and SPI.

Enable this dma driver

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---

Changes in v2:
 - As dicussed with Bjorn GPI DMA is used by Serial engines SPI/I2C so we
   can make this a module rather than inbuilt

 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 30516dc0b70e..d73913f082d7 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -948,6 +948,7 @@ CONFIG_PL330_DMA=y
 CONFIG_TEGRA20_APB_DMA=y
 CONFIG_TEGRA210_ADMA=m
 CONFIG_QCOM_BAM_DMA=y
+CONFIG_QCOM_GPI_DMA=y
 CONFIG_QCOM_HIDMA_MGMT=y
 CONFIG_QCOM_HIDMA=y
 CONFIG_RCAR_DMAC=y
-- 
2.34.1

