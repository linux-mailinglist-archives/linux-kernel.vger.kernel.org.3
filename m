Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 152E349FF90
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 18:30:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343798AbiA1R3z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 12:29:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240734AbiA1R3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 12:29:51 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 922D6C06173B
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 09:29:51 -0800 (PST)
Date:   Fri, 28 Jan 2022 17:29:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1643390990;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OfrGvvZ5mOwqQxBd5CwUM/7gXSXGhJ1/zpXqU3gSPzE=;
        b=OBD1PXJ550fSnp3GzZ5or9sSvm7fropVzkzeJKFl5sCKqnvUzR02bvL0aPtkgbpzyWnmZM
        MD925QI4wVeoXhxGZnshqosz5cjOXq+n2eosNGNwyiXHqJ/eNKgwLri0QNH5TMidZWLFyk
        KZ56je/NJiqvtUpMyH05y55ptLdKcnY6dI7ngybaUrmecubhNPe+iBNobn91WbCKP4Z7vC
        ZJj/ss5cMIUO+cKXCSAI/ghPxgqVX7CCYCczGYYTreFyFKVnKc4ycsuEQwijCSDa5aC7oe
        r2NOpRLmEPVxDnbdLRKg9tcNqUcSw0MREZe87YJ1nXXg/tPsocUsJqhFbONfIw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1643390990;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OfrGvvZ5mOwqQxBd5CwUM/7gXSXGhJ1/zpXqU3gSPzE=;
        b=xwBrYML9oqPX/Jwrwkx23MooZiS5AZuUq3ZaKwi2wDS7b35XN82qHevqPiUgokJzStkVK+
        cii+FaV4RzICLlAg==
From:   "irqchip-bot for Geert Uytterhoeven" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-fixes] dt-bindings: irqchip: renesas-irqc: Add
 R-Car V3U support
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: =?utf-8?q?=3C85b246cc0792663c72c1bb12a8576bd23d2299d3=2E16432?=
 =?utf-8?q?00256=2Egit=2Egeert+renesas=40glider=2Ebe=3E?=
References: =?utf-8?q?=3C85b246cc0792663c72c1bb12a8576bd23d2299d3=2E164320?=
 =?utf-8?q?0256=2Egit=2Egeert+renesas=40glider=2Ebe=3E?=
MIME-Version: 1.0
Message-ID: <164339098921.16921.15045936430684951717.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-fixes branch of irqchip:

Commit-ID:     e8cc7a5d1ad2d44e7f43664ef6a61e31c0545a5b
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/e8cc7a5d1ad2d44e7f43664ef6a61e31c0545a5b
Author:        Geert Uytterhoeven <geert+renesas@glider.be>
AuthorDate:    Wed, 26 Jan 2022 13:32:05 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Fri, 28 Jan 2022 17:22:17 

dt-bindings: irqchip: renesas-irqc: Add R-Car V3U support

Document support for the Interrupt Controller for External Devices
(INT-EC) in the Renesas R-Car V3U (r8a779a0) SoC.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/85b246cc0792663c72c1bb12a8576bd23d2299d3.1643200256.git.geert+renesas@glider.be
---
 Documentation/devicetree/bindings/interrupt-controller/renesas,irqc.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/renesas,irqc.yaml b/Documentation/devicetree/bindings/interrupt-controller/renesas,irqc.yaml
index 79d0358..620f017 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/renesas,irqc.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/renesas,irqc.yaml
@@ -36,6 +36,7 @@ properties:
           - renesas,intc-ex-r8a77980    # R-Car V3H
           - renesas,intc-ex-r8a77990    # R-Car E3
           - renesas,intc-ex-r8a77995    # R-Car D3
+          - renesas,intc-ex-r8a779a0    # R-Car V3U
       - const: renesas,irqc
 
   '#interrupt-cells':
