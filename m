Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2B3D4D1E05
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 17:58:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348616AbiCHQ6S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 11:58:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348528AbiCHQ5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 11:57:46 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69B9F52B14
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 08:56:49 -0800 (PST)
Date:   Tue, 08 Mar 2022 16:56:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1646758608;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=jr6z0ql6NSM1tZ6X4zSCkf0OpjHo/XlT24PW+DWVe1c=;
        b=04tb4ZDvsnXHiuTNY2CI4vw8xdlQfL7FxsX+/Y8Aw10ONaBbKfzcvl8LXP2Tt1NLOxK+BR
        D9ie+m+QZCQEBc2xhWYo40/ftrjgYmadP8nXXdjEg7CTfv6pfL91KWu1pqbilZzQRnF4E9
        QgzEE9/pG8Q2mOYJCyeWzlx4Qp3rmgFKGKJvwZNTY8l7qZnYOcy0eMDDtlFPkqJ+ssSsze
        FL+kQI8t5JMcY4hsv4hpZV2dpwqWw+uUwp3awnMpZZ/4eUARZB3y+6+DMNR7DxvMGz3Hox
        tUZyMlfp3APm89XLfR5fbj8sqEjl3K42Zw9etAD71JlEXBgG3hxG7zJE4M3A4A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1646758608;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=jr6z0ql6NSM1tZ6X4zSCkf0OpjHo/XlT24PW+DWVe1c=;
        b=ilIAyK90cU+yvoXovhukI+oG6jUvKZn+7RKePvtVETlhf6+LEJbv7u7IUHRF4SWedh/ePw
        RsyAya7oHPv3bYBw==
From:   "irqchip-bot for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] dt-bindings: arm-pmu: Document Apple PMU
 compatible strings
Cc:     Rob Herring <robh@kernel.org>, Hector Martin <marcan@marcan.st>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
MIME-Version: 1.0
Message-ID: <164675860706.16921.6958961315324889015.tip-bot2@tip-bot2>
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

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     5a6bbd1d18cabf5a680e726f0ef8f6dda0105fe8
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/5a6bbd1d18cabf5a680e726f0ef8f6dda0105fe8
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Wed, 03 Nov 2021 14:14:53 
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Mon, 07 Feb 2022 16:00:41 

dt-bindings: arm-pmu: Document Apple PMU compatible strings

As we are about to add support fur the Apple PMUs, document the compatible
strings associated with the two micro-architectures present in the Apple M1.

Acked-by: Rob Herring <robh@kernel.org>
Reviewed-by: Hector Martin <marcan@marcan.st>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 Documentation/devicetree/bindings/arm/pmu.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/pmu.yaml b/Documentation/devicetree/bindings/arm/pmu.yaml
index 981bac4..7a04b8a 100644
--- a/Documentation/devicetree/bindings/arm/pmu.yaml
+++ b/Documentation/devicetree/bindings/arm/pmu.yaml
@@ -20,6 +20,8 @@ properties:
     items:
       - enum:
           - apm,potenza-pmu
+          - apple,firestorm-pmu
+          - apple,icestorm-pmu
           - arm,armv8-pmuv3 # Only for s/w models
           - arm,arm1136-pmu
           - arm,arm1176-pmu
