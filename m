Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C6F048A382
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 00:16:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345686AbiAJXQI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 18:16:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345683AbiAJXQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 18:16:06 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 388C7C061757
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 15:16:06 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id e19so7705200plc.10
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 15:16:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3m+MSLx1aWfmG9c9/zNheqVQNvN/1RiPSkKxDhXhUc8=;
        b=FAMQ5bXG1ZfRIjz22ZXOpXwVILq33lkpwxmtzGpBLjXF7+qgVHuUiHA0IqeOkC8bnf
         6mYOLEIUEemetr3Z3413MXhVtacNv8CjstL7k17KalyIrrEcMiYBqquu+0XESpYWrlyB
         bA36yrEmUwWyB0vAkd5sj8ujgXq2UelOE8jr8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3m+MSLx1aWfmG9c9/zNheqVQNvN/1RiPSkKxDhXhUc8=;
        b=zbYBgSWnP8JflQOoEaaZizotmNuIO6U/Fx5Z3MdX3M8WfII73zkGR6vUC7OJk9ULSh
         qzJ58sHCON2Qs9ynYe5Gh0Uaelk18z6tmknF9po/Oocg4YpnZ/qraodJ/l3z3ox8E2bP
         3A0A59xG/iv3z/5/S2BCNvsX/y7TSz34W/N/ZSX7LPfKt6bGbljLNatl3ukemoYvvA2G
         vKBETxY1zLWGt3wYrivPTacHkZADI3wermGmDbs5YnAzhQsAw6/nJYOm32/E6gnRZx08
         LR1u944nl+8VZa06cVGEaXYUaXN8DVa7Aq4vJgeVMA5p0fDsrjJXCnJ0CcTPVnDB2Gp/
         gffw==
X-Gm-Message-State: AOAM530xsxpirGyy4z8kwFoqWFQg7ZloRCTLBfTZ5XSex4uNXaHBhnYM
        B7HsUO78X6ooSv1xHOAls4wfCw==
X-Google-Smtp-Source: ABdhPJz6e6Ax9KoaHUu4OKn9vuzroT/JFuIVuYRtgwypH2Qm2t3A+TB6jFw/sR4u3TNPzw9d5v2lIg==
X-Received: by 2002:a17:902:bd05:b0:148:a2f7:9d87 with SMTP id p5-20020a170902bd0500b00148a2f79d87mr1720722pls.166.1641856565660;
        Mon, 10 Jan 2022 15:16:05 -0800 (PST)
Received: from kuabhs-cdev.c.googlers.com.com (254.80.82.34.bc.googleusercontent.com. [34.82.80.254])
        by smtp.gmail.com with ESMTPSA id z12sm6123924pga.28.2022.01.10.15.16.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jan 2022 15:16:05 -0800 (PST)
From:   Abhishek Kumar <kuabhs@chromium.org>
To:     kvalo@codeaurora.org, ath10k@lists.infradead.org
Cc:     pillair@codeaurora.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, kuabhs@chromium.org,
        dianders@chromium.org, "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Kalle Valo <kvalo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH v2 2/2] dt: bindings: add dt entry for ath10k default BDF name
Date:   Mon, 10 Jan 2022 23:14:15 +0000
Message-Id: <20220110231255.v2.2.Ia0365467994f8f9085c86b5674b57ff507c669f8@changeid>
X-Mailer: git-send-email 2.34.1.575.g55b058a8bb-goog
In-Reply-To: <20220110231255.v2.1.Ie4dcc45b0bf365077303c596891d460d716bb4c5@changeid>
References: <20220110231255.v2.1.Ie4dcc45b0bf365077303c596891d460d716bb4c5@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is possible that BDF name with board-id+chip-id+variant
combination is not found in the board-2.bin. Such cases can
cause wlan probe to fail and completely break wifi. In such
case there can be an optional property to define a default
BDF name to search for in the board-2.bin file when none of
the combinations (board-id,chip-id,variant) match.
To address the above concern provide an optional proptery:
qcom,ath10k-default-bdf

Signed-off-by: Abhishek Kumar <kuabhs@chromium.org>
---

Changes in v2:
 - Changes in v2: none

 .../devicetree/bindings/net/wireless/qcom,ath10k.txt          | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.txt b/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.txt
index b61c2d5a0ff7..d76d1392863d 100644
--- a/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.txt
+++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.txt
@@ -63,6 +63,10 @@ Optional properties:
 				 hw versions.
 - qcom,ath10k-pre-calibration-data : pre calibration data as an array,
 				     the length can vary between hw versions.
+- qcom,ath10k-default-bdf : default board data file name to be searched in
+			    board-2.bin. This is searched if no BDF is found
+			    in board-2.bin that matches, chip-id, board-id and
+			    variant combination
 - <supply-name>-supply: handle to the regulator device tree node
 			   optional "supply-name" are "vdd-0.8-cx-mx",
 			   "vdd-1.8-xo", "vdd-1.3-rfa", "vdd-3.3-ch0",
-- 
2.34.1.575.g55b058a8bb-goog

