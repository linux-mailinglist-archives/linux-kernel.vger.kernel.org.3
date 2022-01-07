Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BDC6487D76
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 21:06:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233950AbiAGUGE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 15:06:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233907AbiAGUGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 15:06:03 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 106C6C06173E
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 12:06:03 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id g2so6308366pgo.9
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jan 2022 12:06:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9aQGqZRmHVofJdgbyQpqYP9ZVw8rgMp4fyAd54UvKjI=;
        b=oKB02UKX2GpWx89gjvdWfZ0z7iFyz6jXVLhUcI83TOu0Dm2uqbBoVD9trbzfsQO5bt
         C9hzF5hu33iB+xe3NVipbIwJ5YLYNGsbtTHg+bzfI9LOPj10iuYdglFU1gmrLqOrSqOC
         6iEb4Atd6HINbMwKeExRhl9iT9grnwCGhzDBY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9aQGqZRmHVofJdgbyQpqYP9ZVw8rgMp4fyAd54UvKjI=;
        b=pjk4KJN5hgBFG+sXS+Ox4J3arVhAs/d2VcZnJof36Z3YRTV3ImPwjDf4Lcll6s/ghv
         tDs+jCUsAhMoqoglBrpsuSoDaxop+jIc59Xq9YNLD58tmkMIBDn1SSAYTt+i6iTtH7tL
         DuxnD9bUx41jfqOMbjpB0d3h9sjpT+swBtru+E3L1iCxARiunqTY5y9LBZFenIwjsg5z
         JE8CATJQX1wq1ImtCsMn8auLRPmVq94AWxfa47IThXVv6UP7MNFerpIKvyMa0PE2Xuqp
         vskXPrLhXd6cEeXyCrn+LKfvrH+RY/GhKV1UF1kZb+z4q9rlaQRTaqnKSZUPL+G5ZHB0
         X9Zg==
X-Gm-Message-State: AOAM531UbNKEsYZrf0AmoN8wMXUoiHE607/qDZ5KAzZhFnhMymqSd40b
        pylIi+icpt7w6RsuE11FnQ60Qg==
X-Google-Smtp-Source: ABdhPJxRLSIDf45pCKTTtVhB5TKIpwBXdiQ5iVWYe9E4TZ3n2ODOwkimZzHR1vjLIHQzP8qdcUQ82g==
X-Received: by 2002:a63:f254:: with SMTP id d20mr57812751pgk.127.1641585962552;
        Fri, 07 Jan 2022 12:06:02 -0800 (PST)
Received: from kuabhs-cdev.c.googlers.com.com (254.80.82.34.bc.googleusercontent.com. [34.82.80.254])
        by smtp.gmail.com with ESMTPSA id y18sm5929492pfn.202.2022.01.07.12.06.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jan 2022 12:06:02 -0800 (PST)
From:   Abhishek Kumar <kuabhs@chromium.org>
To:     kvalo@codeaurora.org, dianders@chromium.org
Cc:     pillair@codeaurora.org, kuabhs@chromium.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Kalle Valo <kvalo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH 2/2] dt: bindings: add dt entry for ath10k default BDF name
Date:   Fri,  7 Jan 2022 20:04:31 +0000
Message-Id: <20220107200417.2.Ia0365467994f8f9085c86b5674b57ff507c669f8@changeid>
X-Mailer: git-send-email 2.34.1.575.g55b058a8bb-goog
In-Reply-To: <20220107200417.1.Ie4dcc45b0bf365077303c596891d460d716bb4c5@changeid>
References: <20220107200417.1.Ie4dcc45b0bf365077303c596891d460d716bb4c5@changeid>
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

