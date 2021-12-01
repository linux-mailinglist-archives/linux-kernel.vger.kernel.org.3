Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CE2146486F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 08:29:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347519AbhLAHdH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 02:33:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347529AbhLAHc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 02:32:58 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA5C4C061748;
        Tue, 30 Nov 2021 23:29:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6E8C2B81DBD;
        Wed,  1 Dec 2021 07:29:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDC95C53FAD;
        Wed,  1 Dec 2021 07:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638343775;
        bh=W8Ba4kmb3j3MnIYQM59/7uqCDcqW2uCLi9GncnBGpcE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X3bzsrqMBKyY/Ewfhko+QOUCzm6KR4t/I8R80nv/W/ALM09Qd71kS2qKWb/cjlNjm
         suO57BOgco5W8xzJZD15CA/nOWI8Cm+9aRYI1GU8cWo+pPTyyed65YuiREq3D9yfFX
         9x9SykKt2BCb83tq9f6PUjJ4P/Kkx9RCQtYfUsVvHFhURl7visQjtGKhoxtDxr7T0m
         U+XRU1b+Co6gW2XDKNPY0Ca/HUxK0CdnjBYxRzCsqPhFeOhtcDLItwBDoKYjtcXt0Q
         ThugDTxpu8N2jlL50mCrrEPIx/v5hAfDOvG0G92/jVEyZ+DEhdNuPbXiL8WF5DNv+3
         oh/88qUkdwDeg==
From:   Vinod Koul <vkoul@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 04/15] arm64: dts: qcom: sm8450-qrd: Add reserved gpio range for QRD
Date:   Wed,  1 Dec 2021 12:59:04 +0530
Message-Id: <20211201072915.3969178-5-vkoul@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211201072915.3969178-1-vkoul@kernel.org>
References: <20211201072915.3969178-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some tlmm gpios are reserved, so mark them as such in QRD DTS

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 arch/arm64/boot/dts/qcom/sm8450-qrd.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8450-qrd.dts b/arch/arm64/boot/dts/qcom/sm8450-qrd.dts
index 127d32502555..8dcd41c4e5ab 100644
--- a/arch/arm64/boot/dts/qcom/sm8450-qrd.dts
+++ b/arch/arm64/boot/dts/qcom/sm8450-qrd.dts
@@ -24,6 +24,10 @@ &qupv3_id_0 {
 	status = "okay";
 };
 
+&tlmm {
+	gpio-reserved-ranges = <28 4>, <36 4>;
+};
+
 &uart7 {
 	status = "okay";
 };
-- 
2.31.1

