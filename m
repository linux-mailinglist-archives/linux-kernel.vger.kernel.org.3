Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC27748736B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 08:16:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234900AbiAGHQQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 02:16:16 -0500
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:44954 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234869AbiAGHQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 02:16:10 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id 4JVZJQ0lDQz9vBqf
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 07:16:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id enzsbKK0Fnge for <linux-kernel@vger.kernel.org>;
        Fri,  7 Jan 2022 01:16:05 -0600 (CST)
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id 4JVZJP5hm0z9vBqS
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 01:16:05 -0600 (CST)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p5.oit.umn.edu 4JVZJP5hm0z9vBqS
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p5.oit.umn.edu 4JVZJP5hm0z9vBqS
Received: by mail-pj1-f70.google.com with SMTP id u13-20020a17090a450d00b001b1e6726fccso6903849pjg.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jan 2022 23:16:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ELnOV+pqN3Q849i1gjcMqbhQoOoZ3JshEPwLhOy8cck=;
        b=mJxhOVfjZBehnoX6XE2Z/Tk9hdqEvKerQgy0/Y7QTIC1vfVSCTLGGLlMFPU10PzKWx
         Z348s5Qt9exYQtMcHlHNMCkwCUuefjMCGs/RokePMcefE+Gmr7VlKPH1Gl/ppg3P/ZWh
         Ys2I1e8qDg4m2XomsTw1cReGKqTM344DLmHpywnVtyL/jJqb0O6nZHYgcbd8UvFcjooN
         lxBNl8NWRAQBQ9yW1+mA5wD7mlyp6Twg+3qjO2HBy7fSIx1lJaOwDpeeu5RKFJqfj3Tu
         JRG1XTTg9Poo7y+gd0EvxSBNNzaOcGgMzoRHWtS+j6BoKV0oe9o8NF5QxD4wHr3QOqHc
         Upbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ELnOV+pqN3Q849i1gjcMqbhQoOoZ3JshEPwLhOy8cck=;
        b=d/+3pvh0oqEiTBrvSAbJ+kBpMIsb1IKZRElykAKWeJ7t6/LBSGdQnOr81G/05k64Mp
         jD7WPQcV0iqfy77iejsSmMCXa4qp5W8ISseQMCYK+/Glor9u/pSkl827zxg9x7AvaSB1
         hHQMn8wncl2qNZHWPAfyMbXZRRZdI/YNEySXx5Va7O+gsuYxzCdOGdbbf1hRhbsprTnR
         vA21jQF7137DMKyNw+4q8C+YRrLiIsIuiV3b7oE3/WedbRraDVOfSOViaL+Cuz7HmQLJ
         s0ks9EXFUVmjgrI963jU8Hv1HwXVXUQxrIl6emZpMctRh25ci+qKBAi0Cdon6RZctBeV
         IpSg==
X-Gm-Message-State: AOAM533bOIcKRbMqsB/HOpQ+zOueVOp7agWiKxgdZiPg7fa22ztzhHrD
        0SDRiw1+fqBZ2BQIk2iHJayNh7k1OqjbN3wnaFF7qPA3LZliFnl5+6XH9NmZBVCNh1ajv4Ev0nK
        vyUNPOdN/3z6zwOH0+xUEEHvDgDAD
X-Received: by 2002:a17:902:9a8b:b0:149:be04:40ab with SMTP id w11-20020a1709029a8b00b00149be0440abmr20920531plp.159.1641539765008;
        Thu, 06 Jan 2022 23:16:05 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz7gMdE/ph8tXBMDEFca35lW/JrFzxfmNdJW8h7RtU3TZ5eZ+Z2+2GbsLNhys+UQCEcL/AZ5w==
X-Received: by 2002:a17:902:9a8b:b0:149:be04:40ab with SMTP id w11-20020a1709029a8b00b00149be0440abmr20920524plp.159.1641539764788;
        Thu, 06 Jan 2022 23:16:04 -0800 (PST)
Received: from zqy787-GE5S.lan ([36.4.60.247])
        by smtp.gmail.com with ESMTPSA id t25sm3569658pgv.9.2022.01.06.23.16.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 23:16:04 -0800 (PST)
From:   Zhou Qingyang <zhou1615@umn.edu>
To:     zhou1615@umn.edu
Cc:     kjlu@umn.edu, Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Akshu Agrawal <akshu.agrawal@amd.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] clk: x86: Fix a wild pointer dereference in fch_clk_probe()
Date:   Fri,  7 Jan 2022 15:15:58 +0800
Message-Id: <20220107071559.65843-1-zhou1615@umn.edu>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220107015744.22C22C36AE3@smtp.kernel.org>
References: <20220107015744.22C22C36AE3@smtp.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In fch_clk_probe(), the return value of clk_hw_register_mux() is
assigned to hws[ST_CLK_MUX] and there is a dereference of it in
fch_clk_probe(), which could lead to a wild pointer dereference on
failure of clk_hw_register_mux().

Fix this bug by adding a check of hws[ST_CLK_MUX].

This bug was found by a static analyzer.

Builds with CONFIG_X86_AMD_PLATFORM_DEVICE=y show no new warnings, and
our static analyzer no longer warns about this code.

Fixes: 19fe87fd854a ("clk: x86: Support RV architecture")
Signed-off-by: Zhou Qingyang <zhou1615@umn.edu>
--- 
The analysis employs differential checking to identify inconsistent 
security operations (e.g., checks or kfrees) between two code paths
and confirms that the inconsistent operations are not recovered in 
the current function or the callers, so they constitute bugs.

Note that, as a bug found by static analysis, it can be a false
positive or hard to trigger. Multiple researchers have cross-reviewed
the bug.

Changes in v2:
  -  Add error check to every register function calls.
  -  Add error handling logic to every error path.
  -  Turn clk_hw_register_mux to devm_clk_hw_register_mux.
  -  Add error check of clk_set_parent().

 drivers/clk/x86/clk-fch.c | 53 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 49 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/x86/clk-fch.c b/drivers/clk/x86/clk-fch.c
index 8f7c5142b0f0..47754761b19c 100644
--- a/drivers/clk/x86/clk-fch.c
+++ b/drivers/clk/x86/clk-fch.c
@@ -36,6 +36,7 @@ static struct clk_hw *hws[ST_MAX_CLKS];
 static int fch_clk_probe(struct platform_device *pdev)
 {
 	struct fch_clk_data *fch_data;
+	int ret;
 
 	fch_data = dev_get_platdata(&pdev->dev);
 	if (!fch_data || !fch_data->base)
@@ -44,35 +45,79 @@ static int fch_clk_probe(struct platform_device *pdev)
 	if (!fch_data->is_rv) {
 		hws[ST_CLK_48M] = clk_hw_register_fixed_rate(NULL, "clk48MHz",
 			NULL, 0, 48000000);
+		if (IS_ERR(hws[ST_CLK_48M]))
+			return PTR_ERR(hws[ST_CLK_48M]);
+
 		hws[ST_CLK_25M] = clk_hw_register_fixed_rate(NULL, "clk25MHz",
 			NULL, 0, 25000000);
+		if (IS_ERR(hws[ST_CLK_25M])) {
+			ret = PTR_ERR(hws[ST_CLK_25M]);
+			goto err_st_clk_25m;
+		}
 
-		hws[ST_CLK_MUX] = clk_hw_register_mux(NULL, "oscout1_mux",
+		hws[ST_CLK_MUX] = devm_clk_hw_register_mux(NULL, "oscout1_mux",
 			clk_oscout1_parents, ARRAY_SIZE(clk_oscout1_parents),
 			0, fch_data->base + CLKDRVSTR2, OSCOUT1CLK25MHZ, 3, 0,
 			NULL);
+		if (IS_ERR(hws[ST_CLK_MUX])) {
+			ret = PTR_ERR(hws[ST_CLK_MUX]);
+			goto err_st_clk_mux;
+		}
 
-		clk_set_parent(hws[ST_CLK_MUX]->clk, hws[ST_CLK_48M]->clk);
+		ret = clk_set_parent(hws[ST_CLK_MUX]->clk, hws[ST_CLK_48M]->clk);
+		if (ret)
+			goto err_clk_set_parent;
 
 		hws[ST_CLK_GATE] = clk_hw_register_gate(NULL, "oscout1",
 			"oscout1_mux", 0, fch_data->base + MISCCLKCNTL1,
 			OSCCLKENB, CLK_GATE_SET_TO_DISABLE, NULL);
+		if (IS_ERR(hws[ST_CLK_GATE])) {
+			ret = PTR_ERR(hws[ST_CLK_GATE]);
+			goto err_st_clk_gate;
+		}
 
-		devm_clk_hw_register_clkdev(&pdev->dev, hws[ST_CLK_GATE],
+		ret = devm_clk_hw_register_clkdev(&pdev->dev, hws[ST_CLK_GATE],
 			"oscout1", NULL);
+		if (ret)
+			goto err_register_st_clk_gate;
 	} else {
 		hws[RV_CLK_48M] = clk_hw_register_fixed_rate(NULL, "clk48MHz",
 			NULL, 0, 48000000);
+		if (IS_ERR(hws[RV_CLK_48M]))
+			return PTR_ERR(hws[RV_CLK_48M]);
 
 		hws[RV_CLK_GATE] = clk_hw_register_gate(NULL, "oscout1",
 			"clk48MHz", 0, fch_data->base + MISCCLKCNTL1,
 			OSCCLKENB, CLK_GATE_SET_TO_DISABLE, NULL);
+		if (IS_ERR(hws[RV_CLK_GATE])) {
+			ret = PTR_ERR(hws[RV_CLK_GATE]);
+			goto err_rv_clk_gate;
+		}
 
-		devm_clk_hw_register_clkdev(&pdev->dev, hws[RV_CLK_GATE],
+		ret = devm_clk_hw_register_clkdev(&pdev->dev, hws[RV_CLK_GATE],
 			"oscout1", NULL);
+		if (ret)
+			goto err_register_rv_clk_gate;
 	}
 
 	return 0;
+
+err_register_st_clk_gate:
+	clk_hw_unregister_gate(hws[ST_CLK_GATE]);
+err_st_clk_gate:
+err_clk_set_parent:
+	clk_hw_unregister_mux(hws[ST_CLK_MUX]);
+err_st_clk_mux:
+	clk_hw_unregister_fixed_rate(hws[ST_CLK_25M]);
+err_st_clk_25m:
+	clk_hw_unregister_fixed_rate(hws[ST_CLK_48M]);
+	return ret;
+
+err_register_rv_clk_gate:
+	clk_hw_unregister_gate(hws[RV_CLK_GATE]);
+err_rv_clk_gate:
+	clk_hw_unregister_fixed_rate(hws[RV_CLK_48M]);
+	return ret;
 }
 
 static int fch_clk_remove(struct platform_device *pdev)
-- 
2.25.1

