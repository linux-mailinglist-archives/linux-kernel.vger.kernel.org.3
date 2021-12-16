Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A0A4476AAC
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 07:55:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234276AbhLPGzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 01:55:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234250AbhLPGzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 01:55:05 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E49FC06173E;
        Wed, 15 Dec 2021 22:55:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 00B92B822E1;
        Thu, 16 Dec 2021 06:55:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AEA3C36AE5;
        Thu, 16 Dec 2021 06:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639637702;
        bh=MgNbXG8p0gk0ZZ775Xv1zd9wjd/hWLiPXvQnc67Kf8A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OTwgEpB5YHNo/DPicD321jRT6S5MrvO5oXWZv5n5G3q6zkz5V4Xj0freANF+DvK5a
         bbVrQhlVLoVGbrVfVo0nzb9g+Mt5CIiRA18FkFHm1gzrBzKVvnWUrevCiOJIK4Pilq
         EBS3giAnxW9j7bJEuRP/eMjejTUEXuF11ipJlHEDG1drGsLw/xhDfyN00g9yzQWSeN
         yIpIGNN2wNzI8kNv8IKb8Iape1giK2/3JmfS5H0d/9f8h9hInqSnxzR9fosAVfPc75
         f33vtTZ+oi9+5W7mFIGnTkX9iPmq3svGUU42Ja2kALPqopreKVu+67DyQ8cXHnPG2c
         2FXbjPnSiNiUQ==
From:   Vinod Koul <vkoul@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] arm64: defconfig: Add SM8450 icc configs
Date:   Thu, 16 Dec 2021 12:24:44 +0530
Message-Id: <20211216065444.650357-4-vkoul@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211216065444.650357-1-vkoul@kernel.org>
References: <20211216065444.650357-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ICC driver config to defconfig as a module

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index eae42284bfe2..a09278516f30 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1185,6 +1185,7 @@ CONFIG_INTERCONNECT_QCOM_SDM845=y
 CONFIG_INTERCONNECT_QCOM_SM8150=m
 CONFIG_INTERCONNECT_QCOM_SM8250=m
 CONFIG_INTERCONNECT_QCOM_SM8350=m
+CONFIG_INTERCONNECT_QCOM_SM8450=m
 CONFIG_EXT2_FS=y
 CONFIG_EXT3_FS=y
 CONFIG_EXT4_FS_POSIX_ACL=y
-- 
2.31.1

