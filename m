Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE8BC468BF3
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 16:44:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235777AbhLEPrA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 10:47:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236302AbhLEPqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 10:46:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76AAFC061714
        for <linux-kernel@vger.kernel.org>; Sun,  5 Dec 2021 07:42:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 39C34B80DBE
        for <linux-kernel@vger.kernel.org>; Sun,  5 Dec 2021 15:42:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AA2FC341C4;
        Sun,  5 Dec 2021 15:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638718963;
        bh=Z1Ppz8Fict7RzZt8A1gbsCfKAiD80/kCdsktrPhxG5U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WeyUV7B7sNoR0MNc+QPoNjyOXMkZPAqIEGLhzR26384wrCUXK5apBVtcolYoLRNY8
         mf87zesExkqbyoiQK4x+PMsIak67SOmSyRJO5D2sbIlS/XBupLXYx57rilXTZOoXpD
         OLpRvNa0KUv/VteVANBw/DPFQ7a3XnAKP3W6b4FFl9Kq8KfYn5ItskwWDnf3IXweVe
         8JjW65a72YduCAa/LgiaKr1iWmPajfg42sm9ZwHHts6j2yYW46zy8sXOeVSxdPcA5P
         hRdwoZobCVEEiYahix1RQozc1Bu5IN5cdswEy2wQjGJNSUQDUbqxK3zqjVBygIA9X3
         irnm1NXiEMOoA==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Tomer Tayar <ttayar@habana.ai>
Subject: [PATCH 2/9] habanalabs: add missing kernel-doc comments for hl_device fields
Date:   Sun,  5 Dec 2021 17:42:29 +0200
Message-Id: <20211205154236.2198481-2-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211205154236.2198481-1-ogabbay@kernel.org>
References: <20211205154236.2198481-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomer Tayar <ttayar@habana.ai>

Add missing kernel-doc comments for the "last_error" and
"stream_master_qid_arr" fields of the "hl_device" structure".

Signed-off-by: Tomer Tayar <ttayar@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/habanalabs.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 722fc8e69fd6..57bc55c2ddac 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -2512,6 +2512,8 @@ struct last_error_session_info {
  * @state_dump_specs: constants and dictionaries needed to dump system state.
  * @multi_cs_completion: array of multi-CS completion.
  * @clk_throttling: holds information about current/previous clock throttling events
+ * @last_error: holds information about last session in which CS timeout or razwi error occurred.
+ * @stream_master_qid_arr: pointer to array with QIDs of master streams.
  * @dram_used_mem: current DRAM memory consumption.
  * @timeout_jiffies: device CS timeout value.
  * @max_power: the max power of the device, as configured by the sysadmin. This
-- 
2.25.1

