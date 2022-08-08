Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC53458CB8B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 17:48:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243271AbiHHPsu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 11:48:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235458AbiHHPsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 11:48:47 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8902E14D07;
        Mon,  8 Aug 2022 08:48:45 -0700 (PDT)
X-QQ-mid: bizesmtp69t1659973718tufk74ui
Received: from localhost.localdomain ( [182.148.14.53])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 08 Aug 2022 23:48:31 +0800 (CST)
X-QQ-SSF: 0100000000200050B000B00A0000000
X-QQ-FEAT: DRnj/z+SqacO8eHiFBAHCHio+vGP2G+OUCJBlKWS63gGAVtAWWNqwrJ9s6OhL
        bAoFZKGRvlXw3xUteR+d/HTYHB8m+9rGBpJbuVhO+e2PHaROjDa9CH4nZGmqz/98mApm0N1
        lWtWB/hialoaXSkFO8SbLzmR00WJfUvRoC60YeXlLvwicNwyv9f6nKlKkOjWX4Gx2r1M31q
        jkaec0etYliPVFLfWu4AK76qipJfzS5t8/YEa+pEAN7I9uXCL+92suUbYGk78FpCyHDfsxp
        ua8FiwU88LfvjWde0rOhrNyhHcbT78d0BHxMbbyuZRIeUIpkeVBCvZts9n86OvO34hXvHCB
        ZDPAZvBbxMJ++P7BH+upjbuPjAKS+AY+h4kkmw3he/a4C6Ie3Gz5crLRE3R6cAhh8j+1vqt
        2ojEHK+tbA8=
X-QQ-GoodBg: 0
From:   shaomin Deng <dengshaomin@cdjrlc.com>
To:     linux@roeck-us.net, heikki.krogerus@linux.intel.com
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, shaomin Deng <dengshaomin@cdjrlc.com>
Subject: [PATCH] usb: typec: Remove repeated word in comments
Date:   Mon,  8 Aug 2022 11:48:30 -0400
Message-Id: <20220808154830.10965-1-dengshaomin@cdjrlc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the repeated word "to" in comments.

Signed-off-by: shaomin Deng <dengshaomin@cdjrlc.com>
---
 drivers/usb/typec/tcpm/tcpm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index e1126a6c8e46..ea5a917c51b1 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -4520,7 +4520,7 @@ static void run_state_machine(struct tcpm_port *port)
 		 * The specification suggests that dual mode ports in sink
 		 * mode should transition to state PE_SRC_Transition_to_default.
 		 * See USB power delivery specification chapter 8.3.3.6.1.3.
-		 * This would mean to to
+		 * This would mean to
 		 * - turn off VCONN, reset power supply
 		 * - request hardware reset
 		 * - turn on VCONN
-- 
2.35.1

