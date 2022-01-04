Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B157A483F60
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 10:50:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbiADJuc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 04:50:32 -0500
Received: from foss.arm.com ([217.140.110.172]:57634 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229501AbiADJub (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 04:50:31 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C1D68ED1;
        Tue,  4 Jan 2022 01:50:30 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id EAAA03F5A1;
        Tue,  4 Jan 2022 01:50:29 -0800 (PST)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     boqun.feng@gmail.com, mark.rutland@arm.com, peterz@infradead.org,
        will@kernel.org
Subject: [PATCH] MAINTAINERS: add myself as reviewer for atomics
Date:   Tue,  4 Jan 2022 09:50:18 +0000
Message-Id: <20220104095018.1990058-1-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As I've fiddled about with the atomic infrastructure a fair bit now,
Peter suggested I should add myself as a reviewer or maintainer to make
sure I'm Cc'd on anything I might have an opinion on.

For now, add myself as a reviewer.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will@kernel.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index fb18ce7168aa..2f7126e104c9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3142,6 +3142,7 @@ ATOMIC INFRASTRUCTURE
 M:	Will Deacon <will@kernel.org>
 M:	Peter Zijlstra <peterz@infradead.org>
 R:	Boqun Feng <boqun.feng@gmail.com>
+R:	Mark Rutland <mark.rutland@arm.com>
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
 F:	arch/*/include/asm/atomic*.h
-- 
2.30.2

