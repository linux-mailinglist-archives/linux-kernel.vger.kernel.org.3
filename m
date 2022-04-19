Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 343515070A5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 16:34:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353332AbiDSObs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 10:31:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348414AbiDSObo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 10:31:44 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 234A2E0CF
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 07:29:01 -0700 (PDT)
Date:   Tue, 19 Apr 2022 14:28:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1650378540;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JbcZVYeVy7oRTZRSXm6YwXfzAnGw8g2KvwGAxHBzEjc=;
        b=j+AUehvokXqO62h87OGZVisDu2j/pJaXXL77kyXeIh+GMtDuHkTR3G3k6M4NvN6Qdd78li
        Adg40eHmJ0oU2V7rQY3ZnJYx2QgARjmVvwnri4AbQkXI6QvEjjm8xjyksx67mQRgyIf0h2
        7ZhGdH0WWlL7sXWvykZ+E48r2H23LGsnoAV6CMqquOT+cys9u0tNK5+Iy3T9iovfddGX/T
        m9QcXdnnL2Bgje/Uj2UXTJfgnjZuTihHyJiGGcgNSW60rwGzbNFGXZ8X0SkTd7UswZHbOp
        kpJGExyJnYtxdlpl8hLxZTq0GbosfCvmdHCQCc1DF2aRobuKh4fElqIPbQhZGQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1650378540;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JbcZVYeVy7oRTZRSXm6YwXfzAnGw8g2KvwGAxHBzEjc=;
        b=ukCSvCJ70I7pr4fL9aAANPkGd6QrGp9VMTzpyiHdPl8L6raPrp8b/BWW+VHiKAYzCvJaKy
        J+abnBgy7O4+RGAQ==
From:   "irqchip-bot for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] gpio: Update TODO to mention immutable
 irq_chip structures
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20220419141846.598305-10-maz@kernel.org>
References: <20220419141846.598305-10-maz@kernel.org>
MIME-Version: 1.0
Message-ID: <165037853927.4207.17133482140796302494.tip-bot2@tip-bot2>
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

Commit-ID:     afefc3266272d40cdcd0fd713c7b42008fea19d5
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/afefc3266272d40cdcd0fd713c7b42008fea19d5
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Tue, 19 Apr 2022 15:18:45 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Tue, 19 Apr 2022 15:22:26 +01:00

gpio: Update TODO to mention immutable irq_chip structures

5 drivers are converted, a few hundred to go. Definitely worth of
a TODO entry, in the hope that someone will notice it and do
a bulk update.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Reviewed-by: Bartosz Golaszewski <brgl@bgdev.pl>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20220419141846.598305-10-maz@kernel.org
---
 drivers/gpio/TODO | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/gpio/TODO b/drivers/gpio/TODO
index b8b1473..f87ff3f 100644
--- a/drivers/gpio/TODO
+++ b/drivers/gpio/TODO
@@ -178,3 +178,22 @@ discussed but the idea is to provide a low-level access point
 for debugging and hacking and to expose all lines without the
 need of any exporting. Also provide ample ammunition to shoot
 oneself in the foot, because this is debugfs after all.
+
+
+Moving over to immutable irq_chip structures
+
+Most of the gpio chips implementing interrupt support rely on gpiolib
+intercepting some of the irq_chip callbacks, preventing the structures
+from being made read-only and forcing duplication of structures that
+should otherwise be unique.
+
+The solution is to call into the gpiolib code when needed (resource
+management, enable/disable or unmask/mask callbacks), and to let the
+core code know about that by exposing a flag (IRQCHIP_IMMUTABLE) in
+the irq_chip structure. The irq_chip structure can then be made unique
+and const.
+
+A small number of drivers have been converted (pl061, tegra186, msm,
+amd, apple), and can be used as examples of how to proceed with this
+conversion. Note that drivers using the generic irqchip framework
+cannot be converted yet, but watch this space!
