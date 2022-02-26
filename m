Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9433D4C566B
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 14:55:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231881AbiBZNxs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 08:53:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231889AbiBZNxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 08:53:31 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CE407307E;
        Sat, 26 Feb 2022 05:52:49 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id hw13so16093242ejc.9;
        Sat, 26 Feb 2022 05:52:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=vUOnL6uEOX/bbBhb6FatdtkSxxgTNnJgJtNW/3/QhGU=;
        b=KgCt34ce4jF8sGtMbffbsbQvWM27WxWHZ9Yz0eijxcDJu45uW6wdSaV7f3v2AGfH3f
         YdOIupo9Znd0DYwURG4vFK5Efj8RBL0jL2I1nYgBtFVHZKs1LGBJmzDAQYiM8fg18nJQ
         tvRRTIVqNoMfpI6e/cY9rgGcZmbltCFduAIImMp7Re4oKTc9X3yFohrlOkGcExWLw+Ba
         R3ZRJXtfNgCiiv9z+A3jditudjmQeolx1sIrgRKVHoBNFm9PiE5L73HeL6MTH59HdbE8
         cvvmjgkhq2eRO2djZuHjkBYd8CzoKehahI05nsYafpTATPE6roygJmLwpsbzaJltJQvg
         87gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vUOnL6uEOX/bbBhb6FatdtkSxxgTNnJgJtNW/3/QhGU=;
        b=rcwyFPTdIy2aK2DKXHFLS/gu8efVli3BMG1bgfyvV1ZzgmIiRxB1Oqg170KdUCaYIS
         uF8pkZZXccZwIIpDktURzSUUm0ZvCe4EMNmzI0J25bvQT7r3D7ezezIhpWXhJ9M9vcQQ
         zaO/URoEArD//Oy92DXKmVkkRcOcRDmq+oMuTPf8hzwzBtciaFFGYA2iPIR4fU3ogkVA
         pddoiG5r4GaNnpOZGAHkXloY9GSYOGLqUAFMs7VSqDcPbtKa76vMnMknHp9B6OZeV9iU
         GqBr8WrOJG5QTmVir3PXVWRYJzAhMUqcrBqS/qqKbuHxVEsdsA+NUGIYNTZoRIsT8CxH
         j73Q==
X-Gm-Message-State: AOAM53230mTHdCRtE7yPBulSyUVNlcXZbqEDlS6Hx92wOcSLcIVOCrD3
        XewOPlofJQ1P8NUKIgrEdVQ=
X-Google-Smtp-Source: ABdhPJxc1Slccp3tvMK3MihhkTgFn5N9UDyPbg+qCSFDjzDVeA1F3wW7PllfNGVAVwEMuFwaHrSrBA==
X-Received: by 2002:a17:906:8051:b0:6ce:a85d:ed74 with SMTP id x17-20020a170906805100b006cea85ded74mr9779739ejw.58.1645883567932;
        Sat, 26 Feb 2022 05:52:47 -0800 (PST)
Received: from Ansuel-xps.localdomain (host-95-251-226-220.retail.telecomitalia.it. [95.251.226.220])
        by smtp.googlemail.com with ESMTPSA id j21-20020aa7c415000000b004127ac9ddc3sm2836369edq.50.2022.02.26.05.52.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Feb 2022 05:52:47 -0800 (PST)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Taniya Das <tdas@codeaurora.org>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 08/15] clk: qcom: gcc-ipq806x: add unusued flag for critical clock
Date:   Sat, 26 Feb 2022 14:52:28 +0100
Message-Id: <20220226135235.10051-9-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220226135235.10051-1-ansuelsmth@gmail.com>
References: <20220226135235.10051-1-ansuelsmth@gmail.com>
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

Some clocks are used by other devices present on the SoC. For example
the gsbi4_h_clk is used by RPM and is if disabled cause the RPM to
reject any regulator change command. These clock should never be
disabled.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 drivers/clk/qcom/gcc-ipq806x.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/qcom/gcc-ipq806x.c b/drivers/clk/qcom/gcc-ipq806x.c
index f49fc8b753a8..983d07586930 100644
--- a/drivers/clk/qcom/gcc-ipq806x.c
+++ b/drivers/clk/qcom/gcc-ipq806x.c
@@ -798,7 +798,7 @@ static struct clk_rcg gsbi4_qup_src = {
 			.parent_data = gcc_pxo_pll8,
 			.num_parents = ARRAY_SIZE(gcc_pxo_pll8),
 			.ops = &clk_rcg_ops,
-			.flags = CLK_SET_PARENT_GATE,
+			.flags = CLK_SET_PARENT_GATE | CLK_IGNORE_UNUSED,
 		},
 	},
 };
@@ -816,7 +816,7 @@ static struct clk_branch gsbi4_qup_clk = {
 			},
 			.num_parents = 1,
 			.ops = &clk_branch_ops,
-			.flags = CLK_SET_RATE_PARENT,
+			.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
 		},
 	},
 };
@@ -900,7 +900,7 @@ static struct clk_rcg gsbi6_qup_src = {
 			.parent_data = gcc_pxo_pll8,
 			.num_parents = ARRAY_SIZE(gcc_pxo_pll8),
 			.ops = &clk_rcg_ops,
-			.flags = CLK_SET_PARENT_GATE,
+			.flags = CLK_SET_PARENT_GATE | CLK_IGNORE_UNUSED,
 		},
 	},
 };
@@ -969,7 +969,7 @@ static struct clk_branch gsbi7_qup_clk = {
 			},
 			.num_parents = 1,
 			.ops = &clk_branch_ops,
-			.flags = CLK_SET_RATE_PARENT,
+			.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
 		},
 	},
 };
@@ -1015,6 +1015,7 @@ static struct clk_branch gsbi4_h_clk = {
 		.hw.init = &(struct clk_init_data){
 			.name = "gsbi4_h_clk",
 			.ops = &clk_branch_ops,
+			.flags = CLK_IGNORE_UNUSED,
 		},
 	},
 };
-- 
2.34.1

