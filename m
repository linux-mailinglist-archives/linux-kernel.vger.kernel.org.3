Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBA464775D5
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 16:24:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238494AbhLPPYx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 10:24:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238477AbhLPPYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 10:24:49 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AA56C061574
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 07:24:49 -0800 (PST)
Date:   Thu, 16 Dec 2021 15:24:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639668286;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vjLXsh3ztZre6Ju+lHpJrtIskfrW2pPutzxiVHHx5io=;
        b=ilW/DVcXqKWVWZltDHUvY3XV5EmzMJotWeY5EbBEgunQr+fKjSNqWGOdtkKBR1K45RMane
        PlpNjBObSjgJnjq3BptmESPrT/Zpf++wy+l+ntYcVaXpJBTiqXCQ7u2mnuXP+dqZxOd0pS
        soe4WzIfxDrGDwrj/ZFYLZul7Xwz5ffLbVE6qcXPRpnQmxuy1Jv1LI3IUPyN/O7pELAtQf
        ucxVWWqDOMAnNX6nvwxGGp/1wzZDgTD9XPFk0+/tlJ+V7LxtqvV0FNhV3ri8iKDEjac/Ok
        S8pevweiuHrUoZHWCDrgE8LCt46HRsfKRRcWh9miaAga1QkJBIqTYYq4bq5cmQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639668286;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vjLXsh3ztZre6Ju+lHpJrtIskfrW2pPutzxiVHHx5io=;
        b=parLqWK92LVf/MsVY+rrGu/mQoGhm3uaGzocL0SnqVb6e2UDDlEB1bFlc2m/FSVST3q0hh
        uxl8wDvaeUdMSWDQ==
From:   "irqchip-bot for Xiang wangx" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/gic-v2m: Add const to of_device_id
Cc:     Xiang wangx <wangxiang@cdjrlc.com>, Marc Zyngier <maz@kernel.org>,
        tglx@linutronix.de
In-Reply-To: <20211209132453.25623-1-wangxiang@cdjrlc.com>
References: <20211209132453.25623-1-wangxiang@cdjrlc.com>
MIME-Version: 1.0
Message-ID: <163966828526.23020.11939992630000758407.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     c10f2f8b5d8027c1ea77f777f2d16cb9043a6c09
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/c10f2f8b5d8027c1ea77f777f2d16cb9043a6c09
Author:        Xiang wangx <wangxiang@cdjrlc.com>
AuthorDate:    Thu, 09 Dec 2021 21:24:53 +08:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Thu, 16 Dec 2021 15:19:52 

irqchip/gic-v2m: Add const to of_device_id

struct of_device_id should normally be const.

Signed-off-by: Xiang wangx <wangxiang@cdjrlc.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20211209132453.25623-1-wangxiang@cdjrlc.com
---
 drivers/irqchip/irq-gic-v2m.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v2m.c b/drivers/irqchip/irq-gic-v2m.c
index 9349fc6..f2d252d 100644
--- a/drivers/irqchip/irq-gic-v2m.c
+++ b/drivers/irqchip/irq-gic-v2m.c
@@ -405,7 +405,7 @@ err_free_v2m:
 	return ret;
 }
 
-static struct of_device_id gicv2m_device_id[] = {
+static const struct of_device_id gicv2m_device_id[] = {
 	{	.compatible	= "arm,gic-v2m-frame",	},
 	{},
 };
