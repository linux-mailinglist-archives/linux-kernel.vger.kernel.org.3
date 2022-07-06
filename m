Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9558567B46
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 03:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbiGFBFC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 21:05:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbiGFBFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 21:05:00 -0400
Received: from mail.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ECCDEA458
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 18:04:59 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 4F8D01E80D92;
        Wed,  6 Jul 2022 09:02:49 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id LXd4MQ6rBPOd; Wed,  6 Jul 2022 09:02:46 +0800 (CST)
Received: from node1.localdomain (unknown [219.141.250.2])
        (Authenticated sender: zeming@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 941521E80D40;
        Wed,  6 Jul 2022 09:02:46 +0800 (CST)
From:   Li zeming <zeming@nfschina.com>
To:     w.d.hubbs@gmail.com, chris@the-brannons.com, kirk@reisers.ca,
        samuel.thibault@ens-lyon.org
Cc:     speakup@linux-speakup.org, linux-kernel@vger.kernel.org,
        kernel@nfschina.com, Li zeming <zeming@nfschina.com>
Subject: [PATCH] accessibility/speakup/speakup_dtlk: Add header file macro definition
Date:   Wed,  6 Jul 2022 09:04:30 +0800
Message-Id: <20220706010430.3327-1-zeming@nfschina.com>
X-Mailer: git-send-email 2.18.2
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add header file macro definition.

Signed-off-by: Li zeming <zeming@nfschina.com>
---
 drivers/accessibility/speakup/speakup_dtlk.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/accessibility/speakup/speakup_dtlk.h b/drivers/accessibility/speakup/speakup_dtlk.h
index 9c378b58066e..101848edec2e 100644
--- a/drivers/accessibility/speakup/speakup_dtlk.h
+++ b/drivers/accessibility/speakup/speakup_dtlk.h
@@ -1,5 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /* speakup_dtlk.h - header file for speakups DoubleTalk driver. */
+#ifndef _SPEAKUP_DTLK_H
+#define _SPEAKUP_DTLK_H
 
 #define SYNTH_IO_EXTENT	0x02
 #define SYNTH_CLEAR	0x18		/* stops speech */
@@ -61,3 +63,4 @@ struct synth_settings {
 				 */
 	u_char has_indexing;	/* nonzero if indexing is implemented */
 };
+#endif
-- 
2.18.2

