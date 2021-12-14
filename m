Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 653FE4745FC
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 16:06:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235241AbhLNPGX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 10:06:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235193AbhLNPGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 10:06:08 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 748D6C061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 07:06:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 118A06148D
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 15:06:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1CA0C34614;
        Tue, 14 Dec 2021 15:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639494367;
        bh=0Ri2sfptrT8oqqFvAyCQHuIRCP1vclu4i7VaYveqpOg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l2AP9isNCxehf/hlaK9q1KDuS0BfXN1XXbVeKRTmG9C7mJmofJfJe9AiOVBXG3w1c
         M+L8Fe2EJNYQRuaQwIF9Ph+cLeCzcDWKOHemfI4tYdg5qLEdcmyX1XdVsjcqOX9R0v
         zlgwYDtNxLz0tkp1FfMUrUwZqL7dmT4KllxNZlOUUC7pMnLRCqGWpTCK2Pc64EqQ7I
         Opxaia7l83fAZ7fkRkyt1uumjOiAilt0BftCAMvpaq7ZM9qVLKCdGbNKheXHXSACwI
         fGWxyApfrjxaR5LbNkUuT6vROGhk7gNo/bO6lmUC6v2I36Vejk2n987qY3DxbQKr5Z
         SdMUQgY5rzokg==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ofir Bitton <obitton@habana.ai>
Subject: [PATCH 09/11] habanalabs: modify cpu boot status error print
Date:   Tue, 14 Dec 2021 17:05:49 +0200
Message-Id: <20211214150551.1568192-9-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211214150551.1568192-1-ogabbay@kernel.org>
References: <20211214150551.1568192-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ofir Bitton <obitton@habana.ai>

As BTL can be replaced by ROM we should modify relevant error print.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/firmware_if.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/habanalabs/common/firmware_if.c b/drivers/misc/habanalabs/common/firmware_if.c
index ba9a17ddc3a4..7c0f56a73399 100644
--- a/drivers/misc/habanalabs/common/firmware_if.c
+++ b/drivers/misc/habanalabs/common/firmware_if.c
@@ -1103,7 +1103,7 @@ static void detect_cpu_boot_status(struct hl_device *hdev, u32 status)
 	switch (status) {
 	case CPU_BOOT_STATUS_NA:
 		dev_err(hdev->dev,
-			"Device boot progress - BTL did NOT run\n");
+			"Device boot progress - BTL/ROM did NOT run\n");
 		break;
 	case CPU_BOOT_STATUS_IN_WFE:
 		dev_err(hdev->dev,
-- 
2.25.1

