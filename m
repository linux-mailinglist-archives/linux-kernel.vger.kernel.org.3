Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CC4C555089
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 17:59:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359822AbiFVP7X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 11:59:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359765AbiFVP7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 11:59:08 -0400
Received: from smtpbg.qq.com (smtpbg138.qq.com [106.55.201.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD4F94199A;
        Wed, 22 Jun 2022 08:55:49 -0700 (PDT)
X-QQ-mid: bizesmtp66t1655913147t3a158w9
Received: from ubuntu.localdomain ( [106.117.78.84])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 22 Jun 2022 23:52:22 +0800 (CST)
X-QQ-SSF: 01000000008000B0C000E00A0000000
X-QQ-FEAT: F3yR32iATbiPoMYvaDYTFsBZP9QS13DHRUXxAF9nw2AecPV51DVC2kmloL/tk
        2mNTwzMeXCZZ1SGC0+j0lExTrDTnubodTIzsw7t/2xgMnCj+mc7Fnvt+JPvh26zQYou9GQ9
        0/BAqjpdfuvmkVwry71ZqbJpH636cOkrUwN9nQt2q49m0il6X/C2BaQQhhVc4j4TXjfzxlk
        EvuXFFSjG2N7yeN6SSziicY4/yaosBlzJxmLNb1Qhg/f5RJsluE+lzbP+THkyVYGGsNNXkF
        otiu1Gk8cA66+padPxGLebmT9OuKratvx95tMPZy1/qjN6qRGTU+XYYZSHARkLSRQ2Bl1+U
        RhBgot9y9W9zx+hbpgHZpPb9Qf9GOcvT8w8o4hR
X-QQ-GoodBg: 0
From:   Jiang Jian <jiangjian@cdjrlc.com>
To:     axboe@kernel.dk
Cc:     philipp.reisner@linbit.com, lars.ellenberg@linbit.com,
        christoph.boehmwalder@linbit.com, drbd-dev@lists.linbit.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiang Jian <jiangjian@cdjrlc.com>
Subject: [PATCH] block: drbd: drbd_state: Fix typo in comments
Date:   Wed, 22 Jun 2022 23:52:20 +0800
Message-Id: <20220622155220.8704-1-jiangjian@cdjrlc.com>
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

Replace 'is' with 'it'

file: drivers/block/drbd/drbd_state.c
line: 1900

* But is is still not save to dreference ldev here, since

changed to:

* But it is still not save to dreference ldev here, since

Signed-off-by: Jiang Jian <jiangjian@cdjrlc.com>
---
 drivers/block/drbd/drbd_state.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/drbd/drbd_state.c b/drivers/block/drbd/drbd_state.c
index 3f7bf9f2d874..99927c44f0c3 100644
--- a/drivers/block/drbd/drbd_state.c
+++ b/drivers/block/drbd/drbd_state.c
@@ -1897,7 +1897,7 @@ static void after_state_ch(struct drbd_device *device, union drbd_state os,
 		int was_io_error = 0;
 		/* corresponding get_ldev was in _drbd_set_state, to serialize
 		 * our cleanup here with the transition to D_DISKLESS.
-		 * But is is still not save to dreference ldev here, since
+		 * But it is still not save to dreference ldev here, since
 		 * we might come from an failed Attach before ldev was set. */
 		if (device->ldev) {
 			rcu_read_lock();
-- 
2.17.1

