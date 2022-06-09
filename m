Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2521E545250
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 18:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344492AbiFIQuk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 12:50:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344315AbiFIQu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 12:50:29 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04A5146C8E
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 09:50:25 -0700 (PDT)
Date:   Thu, 09 Jun 2022 16:50:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1654793424;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=egGChtfj3Hq34hywCcqnOmIuiTPyRf2VlvFWb+Lzl0M=;
        b=AEwW5QZDsxnyaOkgW8cQ8dLCxWZoiKAHM25veHfRbhTOCa91i+TV2A3TNrnRZ5/4JlyRO3
        0vd678DYaNqg1K5mL3Q3/yUQvVJXDI2m2yLjQnAIShZlYEzmrrQXJIhmFlbZNNSYYQgazO
        T6vdNrDDezcMnWCHQNq9rO+0HWi1z/RtnDibN9CuqVYAXODrjeQbACiBVrtHDZPw31giUd
        LkiA/E5YWq446ndS42r+qFSrwe+3V3FtPz1zHcLv3E/82LIHXT9ugBPq+LN3AkYp7fLYJw
        q9hw31oiIFnAO3XsvYNVi50gQs8AvzFtgg53aY1O/z9bd9kAt1zuK9Vuo/K0GA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1654793424;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=egGChtfj3Hq34hywCcqnOmIuiTPyRf2VlvFWb+Lzl0M=;
        b=ZmntKlhiiSOGTpzm8pfIEi9OjuANmdLE9Ggq5KVDmEn2p3F0MAoU0/xD0ivffrJYtydd/D
        qeA0/Fj4nRJ65YBA==
From:   "irqchip-bot for Kunihiko Hayashi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-fixes] dt-bindings:
 interrupt-controller/uniphier-aidet: Add bindings for NX1 SoC
Cc:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Rob Herring <robh@kernel.org>, Marc Zyngier <maz@kernel.org>,
        tglx@linutronix.de
In-Reply-To: <1653023822-19229-2-git-send-email-hayashi.kunihiko@socionext.com>
References: <1653023822-19229-2-git-send-email-hayashi.kunihiko@socionext.com>
MIME-Version: 1.0
Message-ID: <165479342298.4207.9360066389555967329.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-fixes branch of irqchip:

Commit-ID:     df089e6f07e3c94cb7a330dc74f5041db800009c
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/df089e6f07e3c94cb7a330dc74f5041db800009c
Author:        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
AuthorDate:    Fri, 20 May 2022 14:17:01 +09:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Thu, 09 Jun 2022 17:41:57 +01:00

dt-bindings: interrupt-controller/uniphier-aidet: Add bindings for NX1 SoC

Update uniphier-aidet binding document for UniPhier NX1 SoC.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/1653023822-19229-2-git-send-email-hayashi.kunihiko@socionext.com
---
 Documentation/devicetree/bindings/interrupt-controller/socionext,uniphier-aidet.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/socionext,uniphier-aidet.yaml b/Documentation/devicetree/bindings/interrupt-controller/socionext,uniphier-aidet.yaml
index f89ebde..de7c5e5 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/socionext,uniphier-aidet.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/socionext,uniphier-aidet.yaml
@@ -30,6 +30,7 @@ properties:
       - socionext,uniphier-ld11-aidet
       - socionext,uniphier-ld20-aidet
       - socionext,uniphier-pxs3-aidet
+      - socionext,uniphier-nx1-aidet
 
   reg:
     maxItems: 1
