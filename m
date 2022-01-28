Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D856849FE83
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 17:58:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350375AbiA1Q6S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 11:58:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350360AbiA1Q6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 11:58:14 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E1C0C06173B
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 08:58:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 38F81B80DC0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 16:58:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46C1CC340E6
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 16:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643389091;
        bh=IpIK6smX3WDayyIqLIAhfAAQ9WjUEB8xK2rK6xNhyoM=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=h80AiopjqdQ43Fsz80liKSm0MM0wOaMbnULr48OmXZ0kU3GdKV91SLpPYfkzNENce
         Xqj58QbGJTq41CQcGOnuOrOYmRJDif22WAce+e89ZDuVqzzbe/AtlCPwrdERZnBQMh
         4c/VRbonNID8rpyftHFtJ34r5MRSmv3gRyIGQ4iuCX5hkxvHRLKYZ1HxwGL1Mh2sXU
         /QPWJI0f4NY7LE+tUsKuNEpTtkJUn+MPygDuzKssx+ap6rpIfpwPxr/YPhKJwdMJY0
         5d2i/MPzdePTtexfHWNFk4pYGhhO29PRD9+JwvBBu+0CEVYThWVT2AXBiCmiREY8JE
         q3PG0DwRp+JUw==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] habanalabs: fix spelling mistake
Date:   Fri, 28 Jan 2022 18:58:05 +0200
Message-Id: <20220128165805.2816823-2-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220128165805.2816823-1-ogabbay@kernel.org>
References: <20220128165805.2816823-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The name of the property is hints_range_reservation

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/memory.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/habanalabs/common/memory.c b/drivers/misc/habanalabs/common/memory.c
index c0904081f37e..4778f23d8098 100644
--- a/drivers/misc/habanalabs/common/memory.c
+++ b/drivers/misc/habanalabs/common/memory.c
@@ -655,7 +655,7 @@ static u64 get_va_block(struct hl_device *hdev,
 			continue;
 
 		/*
-		 * In case hint address is 0, and arc_hints_range_reservation
+		 * In case hint address is 0, and hints_range_reservation
 		 * property enabled, then avoid allocating va blocks from the
 		 * range reserved for hint addresses
 		 */
-- 
2.25.1

