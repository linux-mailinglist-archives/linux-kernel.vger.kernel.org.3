Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8436E535BA5
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 10:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349865AbiE0Ihd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 04:37:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349775AbiE0Ig0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 04:36:26 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B6BD102758;
        Fri, 27 May 2022 01:36:07 -0700 (PDT)
Date:   Fri, 27 May 2022 08:36:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1653640565;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Qe7r+pZt7515ooXYBaS43jC8BfWrDe1fjfjtxxWyGgA=;
        b=ALuFp5Ju2oZ7LHplisAqDy5GEvYK/lXb3bNWm9cMrDLLqHXUlFgzeHKrawdN8WhSmaX+M3
        q496ob1SE5nDoU7v1vAuIBgvFDWCNHmsOY8SaymWHEAhHXJrdB/F32Mh9PgRt8Ir3SuWop
        ig0mGf2gPu4cNt6HP44WRgcRKc/1RBxPt0j/A2i8gP7Sz3NaFqVQGAiPtyyzDC/OX/m0Jb
        E9lhfR5l0qktc7SWoJXwsBcS9k7ZWdRBPVR/M7Zg+a8Yd+FuCFzhghafFM0HABvi5CVwWq
        Ge9Ha6r0Kop7ry9XhheZEDPFDhvelGaZLJqlTaa0Y/4CbFJTjoSKvKOe+72+Fg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1653640565;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Qe7r+pZt7515ooXYBaS43jC8BfWrDe1fjfjtxxWyGgA=;
        b=rYoeqUnDpeLuUQ1SWW9GXt6kCK7nd+FGKYdUcQo7RuHfmMcYOruySwiU3PA1+J0pDhwq7k
        r0Kbvbf/7Zc01DAQ==
From:   "tip-bot2 for Allen-KH Cheng" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] dt-bindings: timer: Add compatible for Mediatek MT8186
Cc:     "Allen-KH Cheng" <Allen-KH.Cheng@mediatek.com>,
        Rob Herring <robh@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220311130732.22706-2-allen-kh.cheng@mediatek.com>
References: <20220311130732.22706-2-allen-kh.cheng@mediatek.com>
MIME-Version: 1.0
Message-ID: <165364056389.4207.5365427611910591970.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     b8b1ab133e593f0dbfa47b174a54b852af6f856e
Gitweb:        https://git.kernel.org/tip/b8b1ab133e593f0dbfa47b174a54b852af6f856e
Author:        Allen-KH Cheng <Allen-KH.Cheng@mediatek.com>
AuthorDate:    Fri, 11 Mar 2022 21:07:29 +08:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Wed, 18 May 2022 11:08:52 +02:00

dt-bindings: timer: Add compatible for Mediatek MT8186

This commit adds dt-binding documentation of timer for Mediatek MT8186 SoC
Platform.

Signed-off-by: Allen-KH Cheng <Allen-KH.Cheng@mediatek.com>
Acked-by: Rob Herring <robh@kernel.org>
Link: https://lore.kernel.org/r/20220311130732.22706-2-allen-kh.cheng@mediatek.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt b/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt
index fbd76a8..6f1f9db 100644
--- a/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt
+++ b/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt
@@ -23,6 +23,7 @@ Required properties:
 
 	For those SoCs that use SYST
 	* "mediatek,mt8183-timer" for MT8183 compatible timers (SYST)
+	* "mediatek,mt8186-timer" for MT8186 compatible timers (SYST)
 	* "mediatek,mt8192-timer" for MT8192 compatible timers (SYST)
 	* "mediatek,mt8195-timer" for MT8195 compatible timers (SYST)
 	* "mediatek,mt7629-timer" for MT7629 compatible timers (SYST)
