Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7C9C47AAD0
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 15:01:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233281AbhLTOAw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 09:00:52 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:48234 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233260AbhLTOAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 09:00:49 -0500
Date:   Mon, 20 Dec 2021 14:00:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1640008848;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+KcQh3iItRbDP4Z2oavn24TitZ608MXK9XLgWk3bpxU=;
        b=KQUDYBRyIbnwSAvrLB8j/W1uUXM5DMIYA4Z9/CD6RWSBDbv2PRk1Oa0KdaDfJVbZXIk7tY
        ps6wvtL4i0OBSr6iGDr+8Y9rq04qDu+cur2qG5ExCEAkEn5cZSCp8T4dkfAwWpbEYWiVP+
        g2Icovx110eXKzCMBwQ++b4hS8XCFlCNG8n5M9yNMHYyw6eoCPi04DehAIlu/2/rIQg2Oo
        9eBfP768MPbzD5qtMVxrgdSDXOMsHfiZXjgAzllLXRS+n7pKJHTsb/ciXImn3SA9XfBDR9
        d1KBbSe+44Z8MmxNfc/bslO4YuD1DSGFkGRZ5kd1c7gGOh+xh0JG06vF7IB+lw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1640008848;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+KcQh3iItRbDP4Z2oavn24TitZ608MXK9XLgWk3bpxU=;
        b=B3mlTFgR61QldnYzRTmyx0BQJrTMu+LTZv0knEqP/g2lu9hXbsldS6+Qo8fHB1CeT7jDmA
        pd75ztBthbX3HsAA==
From:   "irqchip-bot for Vitaly Kuznetsov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] KVM: Drop stale
 kvm_is_transparent_hugepage() declaration
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20211018151407.2107363-1-vkuznets@redhat.com>
References: <20211018151407.2107363-1-vkuznets@redhat.com>
MIME-Version: 1.0
Message-ID: <164000884699.23020.4987538299959927283.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     f0e6e6fa41b3d2aa1dcb61dd4ed6d7be004bb5a8
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/f0e6e6fa41b3d2aa1dcb61dd4ed6d7be004bb5a8
Author:        Vitaly Kuznetsov <vkuznets@redhat.com>
AuthorDate:    Mon, 18 Oct 2021 17:14:07 +02:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Tue, 07 Dec 2021 09:13:28 

KVM: Drop stale kvm_is_transparent_hugepage() declaration

kvm_is_transparent_hugepage() was removed in commit 205d76ff0684 ("KVM:
Remove kvm_is_transparent_hugepage() and PageTransCompoundMap()") but its
declaration in include/linux/kvm_host.h persisted. Drop it.

Fixes: 205d76ff0684 (""KVM: Remove kvm_is_transparent_hugepage() and PageTransCompoundMap()")
Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20211018151407.2107363-1-vkuznets@redhat.com
---
 include/linux/kvm_host.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index c310648..6d138ad 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1174,7 +1174,6 @@ int kvm_cpu_has_pending_timer(struct kvm_vcpu *vcpu);
 
 bool kvm_is_reserved_pfn(kvm_pfn_t pfn);
 bool kvm_is_zone_device_pfn(kvm_pfn_t pfn);
-bool kvm_is_transparent_hugepage(kvm_pfn_t pfn);
 
 struct kvm_irq_ack_notifier {
 	struct hlist_node link;
