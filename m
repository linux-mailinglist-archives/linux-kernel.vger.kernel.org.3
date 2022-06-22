Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCA4E5546E0
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235528AbiFVKYX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 06:24:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349493AbiFVKXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 06:23:50 -0400
Received: from smtpbg.qq.com (smtpbg138.qq.com [106.55.201.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 108D517E07;
        Wed, 22 Jun 2022 03:23:42 -0700 (PDT)
X-QQ-mid: bizesmtp74t1655893353tybiuful
Received: from localhost.localdomain ( [223.104.103.173])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 22 Jun 2022 18:21:56 +0800 (CST)
X-QQ-SSF: 01000000008000B0B000D00A0000000
X-QQ-FEAT: Rjen8GRx79XiI4aq3GaeUSz/ZbBRBW/664EOYTaqKClkSkpjh331iBDBQ/w9E
        7wtb4fApnboC9GOvKsqcm4+xpe0Ktd3GorNE4yhYtXBArVZMtircvYcu7IWPUS2BO+rcHYE
        V5apFYu3TBy1trfkgA7RQzconYDy6bb8k/tErrkOuDONT2S0CuWSTLGMBwwgCyrZS1Z42ZD
        algS7bmIIx9veoHbzfdeZaKptmH4Lj0IeJ3aBGaj4rIfoOvdsSS0iWtVzv8XLQLakj4ACbj
        j+7QBMHFxBVEEdIxx3x9fz222DwHuc8+2ZihDSNTFTcXCWN7j0LRWTU7yTeCiOWsw0rFAV6
        kjpYHQMJl5aBAP72PJDLSrnmiyOk9ChZAcgU8TU
X-QQ-GoodBg: 0
From:   Jiang Jian <jiangjian@cdjrlc.com>
To:     mathias.nyman@intel.com, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiang Jian <jiangjian@cdjrlc.com>
Subject: [PATCH] xhci: drop unexpected word "the" in the comments
Date:   Wed, 22 Jun 2022 18:21:46 +0800
Message-Id: <20220622102146.3960-1-jiangjian@cdjrlc.com>
X-Mailer: git-send-email 2.17.1
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam10
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

there is an unexpected word "the" in the comments that need to be dropped.

Signed-off-by: Jiang Jian <jiangjian@cdjrlc.com>
---
 drivers/usb/host/xhci-ring.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 46d0b9ad6f74..ad81e9a508b1 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -1964,7 +1964,7 @@ static void handle_port_status(struct xhci_hcd *xhci,
 
 	/*
 	 * Check to see if xhci-hub.c is waiting on RExit to U0 transition (or
-	 * RExit to a disconnect state).  If so, let the the driver know it's
+	 * RExit to a disconnect state).  If so, let the driver know it's
 	 * out of the RExit state.
 	 */
 	if (!DEV_SUPERSPEED_ANY(portsc) && hcd->speed < HCD_USB3 &&
-- 
2.17.1

