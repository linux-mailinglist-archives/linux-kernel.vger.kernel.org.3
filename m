Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FDC352FBD3
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 13:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356121AbiEULWs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 07:22:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354936AbiEULM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 07:12:59 -0400
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02B7E2AE22;
        Sat, 21 May 2022 04:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=rMKMMl4ihKpnbEEt18X3rlVUd1mf+9F9wh4MmnsL4og=;
  b=S5D4ZzoqiDR1hKQ8lyF25jk02dyp9KlyesV4iAmLzuQO7QQKbeE6PtZR
   ml4eiOQwnq6dmtjybm/XuWywHezEaZ2orGYHSpJMhb3Wirxh9nEDhbjDQ
   G/B0xrqoW+fVWupcuEtijX3q55qBSmeZZW77m8U4koA1SSURzpvifLtWF
   0=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.91,242,1647298800"; 
   d="scan'208";a="14727985"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2022 13:12:05 +0200
From:   Julia Lawall <Julia.Lawall@inria.fr>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     kernel-janitors@vger.kernel.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] nl80211: fix typo in comment
Date:   Sat, 21 May 2022 13:11:27 +0200
Message-Id: <20220521111145.81697-77-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Spelling mistake (triple letters) in comment.
Detected with the help of Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 include/uapi/linux/nl80211.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index d9490e3062a7..98f905f16411 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -5874,7 +5874,7 @@ enum nl80211_ap_sme_features {
  * @NL80211_FEATURE_INACTIVITY_TIMER: This driver takes care of freeing up
  *	the connected inactive stations in AP mode.
  * @NL80211_FEATURE_CELL_BASE_REG_HINTS: This driver has been tested
- *	to work properly to suppport receiving regulatory hints from
+ *	to work properly to support receiving regulatory hints from
  *	cellular base stations.
  * @NL80211_FEATURE_P2P_DEVICE_NEEDS_CHANNEL: (no longer available, only
  *	here to reserve the value for API/ABI compatibility)

