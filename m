Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD77D583C57
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 12:45:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236471AbiG1Kpf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 06:45:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236440AbiG1Kow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 06:44:52 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4076366133;
        Thu, 28 Jul 2022 03:44:19 -0700 (PDT)
Date:   Thu, 28 Jul 2022 10:44:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1659005057;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Xdr6KqSFOiGLJdxbejB9C9aJ6PdLyJL/7lG9ro8GL34=;
        b=fRzslDkNeDnPASQd29BIpOpa4f9GcPafoIF3MWLtPCskSTeqEzvgliFq0obEaJWNQbSXj0
        11DVMeSkl3CvkbitONp7oTXsCmodBf5WZ7yaVAnKMYE+QSvfHxW3HK4PJU/zWzZL8O8JuR
        YYi1qkU0xfZosl0BOpXiEwC6Ewa2uAydH5rIhedya5R5MBiTpEmzxHVILS5qvjg3p1Qbk7
        0p1aE3xYomh8GocUzKzWGVVL+v1JGsETfrKvC2HZtAcl3vJeQ+8JOvq4Qj7dN6U3hyLDNu
        Wv1BZP1iMkszoMzfhEENBcyUfV55J1gc43VaeXevvZ3e5wsAS7RZB3rWWKn5Mw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1659005057;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Xdr6KqSFOiGLJdxbejB9C9aJ6PdLyJL/7lG9ro8GL34=;
        b=N8dPeP2hYqXHp8j96PkRWJvHp7ChGP5MucGjY5HmzQ7WU3cfakaPKi5acKq7w6yCNRLxa+
        2Sr0+Nvn68aTnnDw==
From:   "tip-bot2 for AngeloGioacchino Del Regno" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] dt-bindings: timer: mediatek: Add CPUX System
 Timer and MT6795 compatible
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Rob Herring <robh@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220613133819.35318-2-angelogioacchino.delregno@collabora.com>
References: <20220613133819.35318-2-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Message-ID: <165900505616.15455.17063110810809942740.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     13b917a585c214c49cfb757fa4d5d6203e00159c
Gitweb:        https://git.kernel.org/tip/13b917a585c214c49cfb757fa4d5d6203e00159c
Author:        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
AuthorDate:    Mon, 13 Jun 2022 15:38:18 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Sat, 16 Jul 2022 00:41:51 +02:00

dt-bindings: timer: mediatek: Add CPUX System Timer and MT6795 compatible

Document the "CPUXGPT" CPU General Purpose Timer, used as ARM/ARM64
System Timer on MediaTek platforms and add the MT6795 compatible for it.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Acked-by: Rob Herring <robh@kernel.org>
Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
Link: https://lore.kernel.org/r/20220613133819.35318-2-angelogioacchino.delregno@collabora.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt b/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt
index 6f1f9db..f1c848a 100644
--- a/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt
+++ b/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt
@@ -1,7 +1,8 @@
 MediaTek Timers
 ---------------
 
-MediaTek SoCs have two different timers on different platforms,
+MediaTek SoCs have different timers on different platforms,
+- CPUX (ARM/ARM64 System Timer)
 - GPT (General Purpose Timer)
 - SYST (System Timer)
 
@@ -29,6 +30,9 @@ Required properties:
 	* "mediatek,mt7629-timer" for MT7629 compatible timers (SYST)
 	* "mediatek,mt6765-timer" for MT6765 and all above compatible timers (SYST)
 
+	For those SoCs that use CPUX
+	* "mediatek,mt6795-systimer" for MT6795 compatible timers (CPUX)
+
 - reg: Should contain location and length for timer register.
 - clocks: Should contain system clock.
 
