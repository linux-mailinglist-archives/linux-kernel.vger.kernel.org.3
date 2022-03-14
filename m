Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3657F4D84C9
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 13:33:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242564AbiCNMaG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 08:30:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243879AbiCNMVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 08:21:21 -0400
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 321F81140;
        Mon, 14 Mar 2022 05:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FWNbZTFAMBhTgS2R1HpJWQ7vZbciDztq6nj7YGJohCE=;
  b=HQtBKMWZuEVOREaqlRVE/01NtC4d9mTQstV2bcHaHlXi2M27x094itGk
   yuLGQkwQVo5Kd+5w4hU+jps2xadytqyLLJD/jb2fGybRoVlo75MrqeOgt
   CniSZtbcfdKiirA6FrQ75csVKfWVUiiTbUXYzQvGVOJZ2yELq0Y+wq8mE
   U=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.90,180,1643670000"; 
   d="scan'208";a="25997337"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2022 12:53:59 +0100
From:   Julia Lawall <Julia.Lawall@inria.fr>
To:     Justin Ernst <justin.ernst@hpe.com>
Cc:     kernel-janitors@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 05/30] x86/platform/uv: fix typos in comments
Date:   Mon, 14 Mar 2022 12:53:29 +0100
Message-Id: <20220314115354.144023-6-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220314115354.144023-1-Julia.Lawall@inria.fr>
References: <20220314115354.144023-1-Julia.Lawall@inria.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Various spelling mistakes in comments.
Detected with the help of Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 drivers/platform/x86/uv_sysfs.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/uv_sysfs.c b/drivers/platform/x86/uv_sysfs.c
index 625b0b79d185..7c7c95c59908 100644
--- a/drivers/platform/x86/uv_sysfs.c
+++ b/drivers/platform/x86/uv_sysfs.c
@@ -555,7 +555,7 @@ static int init_pci_top_obj(struct uv_pci_top_obj *top_obj, char *line)
 	 */
 	line[6] = '_';
 
-	/* Null terminate after the concatencated name tokens
+	/* Null terminate after the concatenated name tokens
 	 * to produce kobj name string.
 	 */
 	line[14] = '\0';

