Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C9544771EF
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 13:35:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236856AbhLPMfq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 07:35:46 -0500
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:47160
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236577AbhLPMfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 07:35:46 -0500
Received: from workstation5.fritz.box (ip-88-152-144-157.hsi03.unitymediagroup.de [88.152.144.157])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id BB6C73FFD8;
        Thu, 16 Dec 2021 12:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1639658145;
        bh=onBIMAuw6mLm03QoeN/nW0ZWBvVmeZ7hMRD9CvUNps0=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=OLpjXtShMiRPjeMzVNhApo+LTBy2HkwCP9A/24L1WUusYWpN0tRjlYFAtVduXnLpT
         1nMlwpSUl++weEhyqtNv8cEwjW3Iy2FbziViUWWCR8/4xAHfSDBWMX9zYJ4wxLX4ub
         JJ++OBcn4MIDsC7+aaKXrp7dTdchoN7eNZ8dNZ8mqfBlPyFdlMtaF8PMXY+3Jo+8Sp
         3uALn1f5PslC6COrjhpPHe2l7mvYqzTODyBq2hhncoQFnT6j15//6uUM0qGUllGg81
         9Mb+YzvyCkStZN8GQOUhjfKgV+YkdJesGN4FCtzGPW6eRt5I0mRxpnyCfjEwg525Wp
         0AGR4Lz20bE2g==
From:   Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] riscv: default to CONFIG_RISCV_SBI_V01=n
Date:   Thu, 16 Dec 2021 13:35:38 +0100
Message-Id: <20211216123538.175087-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SBI 0.1 specification is obsolete. The current version is 0.3.
Hence we should not rely by default on SBI 0.1 being implemented.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 arch/riscv/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 09abf62ae0ad..f177ad3bee0f 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -396,7 +396,6 @@ source "kernel/Kconfig.hz"
 
 config RISCV_SBI_V01
 	bool "SBI v0.1 support"
-	default y
 	depends on RISCV_SBI
 	help
 	  This config allows kernel to use SBI v0.1 APIs. This will be
-- 
2.32.0

