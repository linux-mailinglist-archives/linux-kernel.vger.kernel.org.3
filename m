Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4149849D8B4
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 03:56:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230438AbiA0C4v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 21:56:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229979AbiA0C4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 21:56:49 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE8B2C06161C;
        Wed, 26 Jan 2022 18:56:48 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id q189so1424279qkf.10;
        Wed, 26 Jan 2022 18:56:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HDVB+p1llS7YapMSQcwBuqDLwDY/+CjI8SnDF5Gvq1Y=;
        b=kwX60o1uzhZfNNuF4h/tZgue3mLrJXmp07S4VIQkFpHq/+yNCUaHc2JSWAUyqT7Fee
         +gwZLa8efmyDH5DsCl7AqeD5tC+Ki4Cj/S4fvZkJ07M/WiZsuiZ3Wc3D7IVQaa0BWzOy
         KhVEJxUnlNWT4naXCiEC6bhg5qwNpbnL+JECCw7DlojTteQXEVYGZLcnhm8C2O/vucSN
         cuj1fIJXLpWvH1JYsyry+6hoE1mhHSs9zUjkIdv8Y4i4iJrl6zKO4RY7sBOJurKb0xxo
         BGiA/MPTR8KHYwtgxWUu/VKVZ2FqIbaIn7WzA4xqf8igMzd4i2bNM8L6SgS2WrAy0TRz
         i8sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HDVB+p1llS7YapMSQcwBuqDLwDY/+CjI8SnDF5Gvq1Y=;
        b=isOma4UUpzr5ofhs++nTI08DXVhjM0Zl/K+jWAok3T3UbpVl30zjk/0f34tJH8SXsd
         JIFNmFGx2ze5fAaIJuT39f5HBxh4l8sntRpRseJAVq5rg2hxBUa47Ycoxfmy0Du431CD
         ZADw+U1j60l2gCPgKEBu6kkBw+pGBIE+BeTSOzyLDsRBRcozbxmtUp4YjBFGTXZD0a+0
         AEOpz37PE3Mg06o0EjHdBrpc82MoYwhh56UlAO8xyqwQ2B5xLfD0HylKca0PnHKVxwu2
         KCcgaP0h4m1YvBsHg5L/Lm4v3WnbBSzImj5RF6mo7v9A5TfUETvSs+9vp56UmjIcdODQ
         eRjA==
X-Gm-Message-State: AOAM5327k2DXQRqflVC4h62kX2VcL7mC+8esp7H3S0UhTk0Gf8EqSCKs
        50U0KCLcwxDJ/MfXZpy1HCk=
X-Google-Smtp-Source: ABdhPJzmV5swp4bLcp5g+IAwyVHtkCr+jtFvbU9xrPNAyndOdNYjYYNp8Zl5XxIRY+27KhnzNzpunQ==
X-Received: by 2002:a37:44d:: with SMTP id 74mr1307282qke.328.1643252208123;
        Wed, 26 Jan 2022 18:56:48 -0800 (PST)
Received: from Dell-Inspiron-15.dartmouth.edu (c-73-149-219-1.hsd1.ma.comcast.net. [73.149.219.1])
        by smtp.gmail.com with ESMTPSA id s2sm622907qks.60.2022.01.26.18.56.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 18:56:47 -0800 (PST)
From:   Ben Wolsieffer <benwolsieffer@gmail.com>
Cc:     trivial@kernel.org, Ben Wolsieffer <benwolsieffer@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] ARM: dts: qcom-apq8060-dragonboard: fix typo in eMMC
Date:   Wed, 26 Jan 2022 21:53:58 -0500
Message-Id: <20220127025358.2202977-1-benwolsieffer@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

eMMC was misspelled as eMMMC.

Signed-off-by: Ben Wolsieffer <benwolsieffer@gmail.com>
---
 arch/arm/boot/dts/qcom-apq8060-dragonboard.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/qcom-apq8060-dragonboard.dts b/arch/arm/boot/dts/qcom-apq8060-dragonboard.dts
index d664ccd454c5..a03dab5661f5 100644
--- a/arch/arm/boot/dts/qcom-apq8060-dragonboard.dts
+++ b/arch/arm/boot/dts/qcom-apq8060-dragonboard.dts
@@ -83,7 +83,7 @@ cm3605 {
 
 	soc {
 		pinctrl@800000 {
-			/* eMMMC pins, all 8 data lines connected */
+			/* eMMC pins, all 8 data lines connected */
 			dragon_sdcc1_pins: sdcc1 {
 				mux {
 					pins = "gpio159", "gpio160", "gpio161",
-- 
2.34.1

