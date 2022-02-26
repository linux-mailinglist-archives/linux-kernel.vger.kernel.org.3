Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0315B4C5642
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 14:55:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231953AbiBZNyE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 08:54:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232091AbiBZNxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 08:53:43 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F67B5BE64;
        Sat, 26 Feb 2022 05:52:57 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id qk11so16180731ejb.2;
        Sat, 26 Feb 2022 05:52:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=SlG4ywzyUmV5RVPE5ayw4v/qlfukO174IJM3wwe2oiY=;
        b=CE66bs7vhNsem+E8r+l4hpWVeHL3+ABqtKzQaXYQE5n4B740BkYQkGh3haqyVRv3nq
         LH09CsUAtnLi+4bYAcoLA0GuHpP/1+eaIv2W70SCm3DZ6g98fbRzOencj6HjMi7gpYIP
         BHz8t34RexbGXvag6tNR1XrNmgfj0J2fbSuDYRmFI+rRKm6dJfDUAHGjetEPd1fiFDw5
         DRfHzo8zSNhZKWxvsWuvLZbZ/UPYlBp+LiXvU3sB+xxelS6cEKHqXfGN7AsC9ju0/+Nx
         WIbtUSMKlpXrebz9KNiFZrjiZocFBUmWp7bHetqX1I5pEM1ciZ/y+C1fuiqqh9Jcu+LP
         Q92w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SlG4ywzyUmV5RVPE5ayw4v/qlfukO174IJM3wwe2oiY=;
        b=QJPWQ5SeUY9RQSDwMUU9QdCyVmXtnOX8GH3lqsk3kNhYwK5J3OVMObOqF978nvPIwo
         ZEB4BL4ltPAYbWBRqk+lTlk76RqsZML7JxpK1agQ1JqNbFB8cO8HnNArbrwvVCMHg1j7
         eaFuCUxPJ6yy8D2djzDam26I2zcx6aT/uZbK2FB7q9AadhDsZFThqPgyQCpIzmxvagxb
         wckDpC+/peNSx0Atn1RErSLz7G/rdKiFAZIQLBx7emg7RnyuNjmMJoEZEjaonG0jzZKt
         d0kPJ8TND7YqfAKK3S4vl7ZF1m5t64lyKcwghXuj7mQ1jlgBmUZNTfBx0jj1Ts/aGc1S
         Y5wQ==
X-Gm-Message-State: AOAM533eXNuLKxVgrPawFU3qkBQaj3H/nEMPrcOzr5iPQtdgD2G2BNhY
        1tO+RyO5FnRiewj3/KOHX0hrOyYqdrg=
X-Google-Smtp-Source: ABdhPJxOxhyrdeZMoBM+4nppbZrZs9V+kJkmr7Lq99vVGXiBBewEHum9kIQUWf+rIlAwXybQ3//brw==
X-Received: by 2002:a17:907:788c:b0:6ce:29d5:c075 with SMTP id ku12-20020a170907788c00b006ce29d5c075mr9976360ejc.407.1645883575791;
        Sat, 26 Feb 2022 05:52:55 -0800 (PST)
Received: from Ansuel-xps.localdomain (host-95-251-226-220.retail.telecomitalia.it. [95.251.226.220])
        by smtp.googlemail.com with ESMTPSA id j21-20020aa7c415000000b004127ac9ddc3sm2836369edq.50.2022.02.26.05.52.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Feb 2022 05:52:55 -0800 (PST)
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
Subject: [PATCH v6 14/15] clk: qcom: gcc-ipq806x: add CryptoEngine resets
Date:   Sat, 26 Feb 2022 14:52:34 +0100
Message-Id: <20220226135235.10051-15-ansuelsmth@gmail.com>
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

Add missing CryptoEngine resets.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
Reviewed-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/clk/qcom/gcc-ipq806x.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/clk/qcom/gcc-ipq806x.c b/drivers/clk/qcom/gcc-ipq806x.c
index 711a8b421e8b..718de17a1e60 100644
--- a/drivers/clk/qcom/gcc-ipq806x.c
+++ b/drivers/clk/qcom/gcc-ipq806x.c
@@ -3320,6 +3320,11 @@ static const struct qcom_reset_map gcc_ipq806x_resets[] = {
 	[GMAC_CORE3_RESET] = { 0x3cfc, 0 },
 	[GMAC_CORE4_RESET] = { 0x3d1c, 0 },
 	[GMAC_AHB_RESET] = { 0x3e24, 0 },
+	[CRYPTO_ENG1_RESET] = { 0x3e00, 0},
+	[CRYPTO_ENG2_RESET] = { 0x3e04, 0},
+	[CRYPTO_ENG3_RESET] = { 0x3e08, 0},
+	[CRYPTO_ENG4_RESET] = { 0x3e0c, 0},
+	[CRYPTO_AHB_RESET] = { 0x3e10, 0},
 	[NSS_CH0_RST_RX_CLK_N_RESET] = { 0x3b60, 0 },
 	[NSS_CH0_RST_TX_CLK_N_RESET] = { 0x3b60, 1 },
 	[NSS_CH0_RST_RX_125M_N_RESET] = { 0x3b60, 2 },
-- 
2.34.1

