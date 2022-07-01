Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F29965635FD
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 16:42:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232331AbiGAOkA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 10:40:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233509AbiGAOjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 10:39:40 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 929B944A0A
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 07:37:37 -0700 (PDT)
Date:   Fri, 01 Jul 2022 14:37:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1656686256;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P3LEv8JYmTrLA1G5RNIvNWfjCXpRECNXrM+AGMGMFdI=;
        b=4n44rirQb1lZ+5W7q+1WhMzn29kCjvfIsORTi9GcwXv1Q+DKfq4VNrKkmwAC4nRI+9v0Ra
        IPUUhb+pUpZNsIUcfnb/4vYY0mtXM86YPTgaamcQxBnq6EHTx3zL7CCA/mqDlyWtEQSkGj
        zkdZkDDL6WX47uodudbMrcBQuSa+v9WYcmJczl78l/hfH+5xzYyh6ToPkQHv7CZ4kY6mP5
        IUS71oGEhvdFSB9gAajJIdNQ/DQTajHN99t6h3gOd8vsBtIa3b16Opqt1Y4Pui0wvwRC0v
        Pio/CfwcLF+oM3gAzjdEcgtQWEyTZqEdV/wrhaOOZsTEATEmz1x0Sd+n2/10mg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1656686256;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P3LEv8JYmTrLA1G5RNIvNWfjCXpRECNXrM+AGMGMFdI=;
        b=u8zb3QeSzP2bI+CxGKT2EjvrnWx4GcD4wuKtBkqCepHA5l8Scqz6+8Etv7ENYDVrc/uh4j
        2/fjbFJ9mbrntmCw==
From:   "irqchip-bot for Samuel Holland" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] dt-bindings: interrupt-controller:
 Require trigger type for T-HEAD PLIC
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Samuel Holland <samuel@sholland.org>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20220630100241.35233-4-samuel@sholland.org>
References: <20220630100241.35233-4-samuel@sholland.org>
MIME-Version: 1.0
Message-ID: <165668625511.15455.5011406654010196741.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqc=
hip:

Commit-ID:     d60df7fd225af37e31859a9badb0cca73f7aa12d
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platfo=
rms/d60df7fd225af37e31859a9badb0cca73f7aa12d
Author:        Samuel Holland <samuel@sholland.org>
AuthorDate:    Thu, 30 Jun 2022 05:02:40 -05:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Fri, 01 Jul 2022 15:27:23 +01:00

dt-bindings: interrupt-controller: Require trigger type for T-HEAD PLIC

The RISC-V PLIC specification unfortunately allows PLIC implementations
to ignore edges seen while an edge-triggered interrupt is being handled:

  Depending on the design of the device and the interrupt handler,
  in between sending an interrupt request and receiving notice of its
  handler=E2=80=99s completion, the gateway might either ignore additional
  matching edges or increment a counter of pending interrupts.

Like the NCEPLIC100, the T-HEAD C900 PLIC also has this behavior. Thus
it also needs to inform software about each interrupt's trigger type, so
the driver can use the right interrupt flow.

Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Signed-off-by: Samuel Holland <samuel@sholland.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20220630100241.35233-4-samuel@sholland.org
---
 Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yam=
l | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/sifive,pl=
ic-1.0.0.yaml b/Documentation/devicetree/bindings/interrupt-controller/sifive=
,plic-1.0.0.yaml
index cd2b8bc..92e0f8c 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.=
0.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.=
0.yaml
@@ -33,7 +33,7 @@ description:
   it is not included in the interrupt specifier. In the second case, software
   needs to know the trigger type, so it can reorder the interrupt flow to av=
oid
   missing interrupts. This special handling is needed by at least the Renesas
-  RZ/Five SoC (AX45MP AndesCore with a NCEPLIC100).
+  RZ/Five SoC (AX45MP AndesCore with a NCEPLIC100) and the T-HEAD C900 PLIC.
=20
   While the RISC-V ISA doesn't specify a memory layout for the PLIC, the
   "sifive,plic-1.0.0" device is a concrete implementation of the PLIC that
@@ -112,6 +112,7 @@ allOf:
           contains:
             enum:
               - andestech,nceplic100
+              - thead,c900-plic
=20
     then:
       properties:
