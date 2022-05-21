Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCC6952FBD1
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 13:29:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240744AbiEULYo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 07:24:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355049AbiEULOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 07:14:08 -0400
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 086D1134E2A;
        Sat, 21 May 2022 04:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=NmIVCmT4dEODIMGyk8LH8pCZd+C2yghx1HvoC4Qax7Q=;
  b=NnLnwtnAtSaJFMEOhq45rYw4I0DIITSYYwBiSghECXD2Z9De38Y20eyz
   Y1+CM9PSIRIR0mJfPv4xTKqsHQdvRadz3klUZ8TLftjE/iGSEcFxMmFCQ
   2aPh75DoUkLJhbq11c1wl1iN8pod+k9AWO+2gu9aP6onJnZ4A4GkRE2Qh
   U=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.91,242,1647298800"; 
   d="scan'208";a="14728000"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2022 13:12:08 +0200
From:   Julia Lawall <Julia.Lawall@inria.fr>
To:     Al Cooper <alcooperx@gmail.com>
Cc:     kernel-janitors@vger.kernel.org,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] usb: gadget: bdc: fix typo in comment
Date:   Sat, 21 May 2022 13:11:42 +0200
Message-Id: <20220521111145.81697-92-Julia.Lawall@inria.fr>
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
 drivers/usb/gadget/udc/bdc/bdc_cmd.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/bdc/bdc_cmd.c b/drivers/usb/gadget/udc/bdc/bdc_cmd.c
index 67887316a1a6..1848ced073f8 100644
--- a/drivers/usb/gadget/udc/bdc/bdc_cmd.c
+++ b/drivers/usb/gadget/udc/bdc/bdc_cmd.c
@@ -307,7 +307,7 @@ int bdc_ep_clear_stall(struct bdc *bdc, int epnum)
 	 * his will reset the seq number for non EP0.
 	 */
 	if (epnum != 1) {
-		/* if the endpoint it not stallled */
+		/* if the endpoint it not stalled */
 		if (!(ep->flags & BDC_EP_STALL)) {
 			ret = bdc_ep_set_stall(bdc, epnum);
 			if (ret)

