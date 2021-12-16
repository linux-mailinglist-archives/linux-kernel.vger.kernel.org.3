Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCE5C476AAA
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 07:55:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234254AbhLPGzF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 01:55:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234250AbhLPGzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 01:55:03 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 167DBC061574;
        Wed, 15 Dec 2021 22:55:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C707CB822E3;
        Thu, 16 Dec 2021 06:55:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A372FC36AE2;
        Thu, 16 Dec 2021 06:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639637700;
        bh=RWrF5HLPYAkNGCq/aujfI9tnsdDISVu0C1s1+DmiRi4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i0Ceq2dWd/It0Pjmu1SJVv7P8Cl7mQGXm6yOL2M+MMSH4QzODgzQAhiAvoz3L//PI
         eZBvM8m6aWGf42cMQNp7Fz2ATL91qp/gwJeWG9+a5MKSUTgGA7YqDw1eWhSMBqLHdf
         8GqTkhjVZj7N6++CCc3T5zvQieySxP0so3k/mkUwwgyc1ZDWe10kZ5br+lMMML5rzg
         hJJ4PnGApIx8ua073qAY40rWLgrbDC1f7f3o3TkI70uZDgWWFvLH/ZvAfrQZzjpK3W
         MxzegeMfgIrjsSYnQlJ+pBiC/tmr1VomMHqhhdZUSHvAjjsn1tkXAGDbjgLaFA0B/i
         NcH6POF5fWfnw==
From:   Vinod Koul <vkoul@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] arm64: defconfig: Add SM8450 pinctrl config
Date:   Thu, 16 Dec 2021 12:24:43 +0530
Message-Id: <20211216065444.650357-3-vkoul@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211216065444.650357-1-vkoul@kernel.org>
References: <20211216065444.650357-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 5b257b62b155..eae42284bfe2 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -520,6 +520,7 @@ CONFIG_PINCTRL_SDM845=y
 CONFIG_PINCTRL_SM8150=y
 CONFIG_PINCTRL_SM8250=y
 CONFIG_PINCTRL_SM8350=y
+CONFIG_PINCTRL_SM8450=y
 CONFIG_PINCTRL_LPASS_LPI=m
 CONFIG_GPIO_ALTERA=m
 CONFIG_GPIO_DAVINCI=y
-- 
2.31.1

