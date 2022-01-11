Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80BA748ACEF
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 12:47:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239193AbiAKLrz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 06:47:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238931AbiAKLry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 06:47:54 -0500
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B34C0C06173F
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 03:47:53 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1641901671;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=fwa8c01ToQsUEDXsCc/5Iu+uzZ38ul2QFI8sqnLUzHw=;
        b=wlnchmItqsMRFA4xAQrzULRfuZwIxd+/bbnnwKOyhnBYbOtUi2v4fc7A6rRFomBrNt/4/A
        Nr7iZdNqM7/4gYGWctXxnp9ZnhrfKbAqgU+cS+HT3Zmro9cVQmZilpGUBlq2rGO9CbtINQ
        CeMFHJVPMUrI2NRuQfwWfkxKSJRpvks=
From:   Cai Huoqing <cai.huoqing@linux.dev>
To:     cai.huoqing@linux.dev
Cc:     Oded Gabbay <ogabbay@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] habanalabs: Remove unused enum member DMA_SRAM_TO_SRAM
Date:   Tue, 11 Jan 2022 19:47:22 +0800
Message-Id: <20220111114724.7987-1-cai.huoqing@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver don't support the SRAM-to-SRAM translation of DMA,
so remove 'DMA_SRAM_TO_SRAM'.

Signed-off-by: Cai Huoqing <cai.huoqing@linux.dev>
---
 drivers/misc/habanalabs/include/goya/goya_packets.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/misc/habanalabs/include/goya/goya_packets.h b/drivers/misc/habanalabs/include/goya/goya_packets.h
index ef54bad20509..25fbebdc6143 100644
--- a/drivers/misc/habanalabs/include/goya/goya_packets.h
+++ b/drivers/misc/habanalabs/include/goya/goya_packets.h
@@ -36,7 +36,6 @@ enum goya_dma_direction {
 	DMA_SRAM_TO_HOST,
 	DMA_DRAM_TO_HOST,
 	DMA_DRAM_TO_DRAM,
-	DMA_SRAM_TO_SRAM,
 	DMA_ENUM_MAX
 };
 
-- 
2.25.1

