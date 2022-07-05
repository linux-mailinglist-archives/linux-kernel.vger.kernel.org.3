Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C75965667B2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 12:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231954AbiGEKU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 06:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiGEKUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 06:20:25 -0400
Received: from mail.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 00F71140A7
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 03:20:20 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 294241E80D71;
        Tue,  5 Jul 2022 18:18:15 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id eaLBT9-2BBQi; Tue,  5 Jul 2022 18:18:12 +0800 (CST)
Received: from node1.localdomain (unknown [219.141.250.2])
        (Authenticated sender: zeming@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 6A2021E80D19;
        Tue,  5 Jul 2022 18:18:12 +0800 (CST)
From:   Li zeming <zeming@nfschina.com>
To:     w.d.hubbs@gmail.com, chris@the-brannons.com, kirk@reisers.ca,
        samuel.thibault@ens-lyon.org
Cc:     speakup@linux-speakup.org, linux-kernel@vger.kernel.org,
        Li zeming <zeming@nfschina.com>
Subject: [PATCH] accessibility/speakup/speakup_acnt: Add header file macro definition
Date:   Tue,  5 Jul 2022 18:19:55 +0800
Message-Id: <20220705101955.27337-1-zeming@nfschina.com>
X-Mailer: git-send-email 2.18.2
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I think the header file could avoid redefinition errors.
 at compile time by adding macro definitions.

Signed-off-by: Li zeming <zeming@nfschina.com>
---
 drivers/accessibility/speakup/speakup_acnt.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/accessibility/speakup/speakup_acnt.h b/drivers/accessibility/speakup/speakup_acnt.h
index cffa938ae580..cea05d770f6d 100644
--- a/drivers/accessibility/speakup/speakup_acnt.h
+++ b/drivers/accessibility/speakup/speakup_acnt.h
@@ -1,5 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /* speakup_acntpc.h - header file for speakups Accent-PC driver. */
+#ifndef _SPEAKUP_ACNT_H
+#define _SPEAKUP_ACNT_H
 
 #define SYNTH_IO_EXTENT	0x02
 
@@ -17,3 +19,4 @@
 #define SYNTH_FULL	'F' /* synth is full. */
 #define SYNTH_ALMOST_EMPTY 'M' /* synth has less than 2 seconds of text left */
 #define SYNTH_SPEAKING	's' /* synth is speaking and has a fare way to go */
+#endif
-- 
2.18.2

