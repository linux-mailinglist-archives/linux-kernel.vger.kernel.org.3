Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 402B058D08F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 01:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244582AbiHHXrb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 19:47:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbiHHXr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 19:47:29 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D8891C11F;
        Mon,  8 Aug 2022 16:47:28 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id u12so7743295qtk.0;
        Mon, 08 Aug 2022 16:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=NLBC3MzbjIOuPKppogTUtaP4Ze7dHFmf0ps9Kq9iUAc=;
        b=IhRA0U/Rmi2zgoB5cBETPswKNBFZjQ01RIdJCqm5sGosCkd7/zziCY1EJdAuT4XGos
         s8+oefMgq0JVkNv+Pox9cJ3rfwgnLiSgkORx0GXLvaSd4yKdTUnUvebm/eDsI9/wkg9f
         /j/30uoIw3WhX7ORB70pe1MZnJHvcTGAD31/UUIh7ar4YgwysVic04uNWsILqN98un36
         hVQO5BIWhS/fnGQAFAVx8ggWaMcQxxVdhU10DTdz5oRHACLWD3SFE7xyoL6pKfbzPTqo
         acZU3zmCvp3kzsPhCZf8u9v4txuNaiHn0vkjcGiQPrZpC+VRtmBu8MLyR6GI3SETqD0T
         rNsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=NLBC3MzbjIOuPKppogTUtaP4Ze7dHFmf0ps9Kq9iUAc=;
        b=e9lddbL27YRObB61lBlLuBC49O4Z1VmRon18wt5WAXzYKgDjZrIgqQUFOdzxwxldFf
         O8vtEhHOoNjS62QHsf1sqT1H0Mqq4JgMl3mUqKNc5PaMGzibBwiv6pXnysfgnWtQS022
         FmEB8dEvDG8CF9lsKYICY9gzt0VPeIqu5N2ML8rHjLpEF2UG/EZfJ8XPM4U/P3GT3NA+
         X3nff23Bng9sJ2+Dz7rjPP3HwjVgkP1eiy14jQFrEngV/ieakO8nXjs0L4ovsmONHJMU
         TLTkWmt3R31dVL1SRWGLeKGiGJ3VYwSpNDSRrZgBDGuau6/wanXM7lBBhgjRNAS6SayO
         1j3w==
X-Gm-Message-State: ACgBeo1rUpm5lybFN2KqzveErIhybM8wIYSFok47CluPqWXhYpumm8OL
        dqKuIjmlphg0/lv4aKQxvIBevPetDHSjr6jlBCw=
X-Google-Smtp-Source: AA6agR41/8kRDMhubzd1fsJlNghYJmNkW6FFpLnU9EHXatW4l4bGIJKOXDpHNYDdgtVyVm6vMCjQRA==
X-Received: by 2002:a05:622a:1a14:b0:31e:e89f:4dda with SMTP id f20-20020a05622a1a1400b0031ee89f4ddamr18658309qtb.622.1660002447308;
        Mon, 08 Aug 2022 16:47:27 -0700 (PDT)
Received: from Latitude-E6420.mynetworksettings.com ([2600:4040:2036:c00:e57a:4cf3:aa55:7079])
        by smtp.gmail.com with ESMTPSA id d6-20020ac85446000000b00343028a9425sm1346400qtq.16.2022.08.08.16.47.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 16:47:26 -0700 (PDT)
From:   Rudraksha Gupta <guptarud@gmail.com>
To:     krzysztof.kozlowski+dt@linaro.org
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, david@ixit.cz,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        Rudraksha Gupta <guptarud@gmail.com>
Subject: [PATCH 1/2] ARM: msm8960: Rename cxo_board to cxo-board and add alias
Date:   Mon,  8 Aug 2022 19:47:22 -0400
Message-Id: <20220808234723.5184-1-guptarud@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch renames cxo_board to be up to date with the current naming
style. It also adds an alias

Signed-off-by: Rudraksha Gupta <guptarud@gmail.com>
---
 arch/arm/boot/dts/Makefile     | 1 +
 drivers/clk/qcom/gcc-msm8960.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 05d8aef6e5d2..d55f196ad733 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1049,6 +1049,7 @@ dtb-$(CONFIG_ARCH_QCOM) += \
 	qcom-msm8660-surf.dtb \
 	qcom-msm8916-samsung-serranove.dtb \
 	qcom-msm8960-cdp.dtb \
+	qcom-msm8960-samsung-expressatt.dtb \
 	qcom-msm8974-lge-nexus5-hammerhead.dtb \
 	qcom-msm8974-sony-xperia-rhine-amami.dtb \
 	qcom-msm8974-sony-xperia-rhine-honami.dtb \
diff --git a/drivers/clk/qcom/gcc-msm8960.c b/drivers/clk/qcom/gcc-msm8960.c
index 051745ef99c8..56ce05a846dd 100644
--- a/drivers/clk/qcom/gcc-msm8960.c
+++ b/drivers/clk/qcom/gcc-msm8960.c
@@ -3624,7 +3624,7 @@ static int gcc_msm8960_probe(struct platform_device *pdev)
 	if (!match)
 		return -EINVAL;
 
-	ret = qcom_cc_register_board_clk(dev, "cxo_board", "cxo", 19200000);
+	ret = qcom_cc_register_board_clk(dev, "cxo-board", "cxo", 19200000);
 	if (ret)
 		return ret;
 
-- 
2.25.1

