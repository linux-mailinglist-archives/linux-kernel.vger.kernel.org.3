Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EB76476AA8
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 07:55:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234241AbhLPGzA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 01:55:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234232AbhLPGy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 01:54:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1158AC061574;
        Wed, 15 Dec 2021 22:54:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A5B4961BEF;
        Thu, 16 Dec 2021 06:54:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49963C36AE4;
        Thu, 16 Dec 2021 06:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639637698;
        bh=KkyLoxZQbSxbjGyEX6Axjh8y0dxbxrqtZYcFuIHBdmc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XXLzmZEm44tT4kHK+oVZjS5aZlXIl8fOKEcvXSX6T5pYdirgQxvMQpsuOKa94QUzt
         /AcPH86pBtJrt1xhz8m50Eqpu8+/Au21rSW9p0aRS1UgkYvQh3YTUXNpFhna0XWAi5
         1ZknCnnBnDNat5fpU0v3hayBm3EHUB0EANf7iSCO3Q3X497W18DNC40FEDd+a0zjfM
         KYNEWHOrh5OLipemKOnq7rOL78fIuqgv5z8YtAA7UnyJEGvhLJR3sxv0BkSCijn0e6
         rYXY31Rq12i8DDMGhaBVUF+BBr9m1Mps4bhBKgEPfNqPYNUVPvkiXbnW9pjLltGhY6
         wdPoodNNLvLdA==
From:   Vinod Koul <vkoul@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] arm64: defconfig: Add SM8450 GCC config
Date:   Thu, 16 Dec 2021 12:24:42 +0530
Message-Id: <20211216065444.650357-2-vkoul@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211216065444.650357-1-vkoul@kernel.org>
References: <20211216065444.650357-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the SM8450 GCC config as built-in so that platform can boot to shell
with defconfig

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index f2e2b9bdd702..5b257b62b155 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1003,6 +1003,7 @@ CONFIG_SDM_DISPCC_845=y
 CONFIG_SM_GCC_8150=y
 CONFIG_SM_GCC_8250=y
 CONFIG_SM_GCC_8350=y
+CONFIG_SM_GCC_8450=y
 CONFIG_SM_GPUCC_8150=y
 CONFIG_SM_GPUCC_8250=y
 CONFIG_SM_DISPCC_8250=y
-- 
2.31.1

