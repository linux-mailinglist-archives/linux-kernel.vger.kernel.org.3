Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 969D25697C0
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 04:03:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234357AbiGGCAL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 22:00:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbiGGCAK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 22:00:10 -0400
Received: from mail.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C79132ED4B
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 19:00:09 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id D52631E80D82;
        Thu,  7 Jul 2022 09:57:49 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ZZKH5BkaPIZF; Thu,  7 Jul 2022 09:57:47 +0800 (CST)
Received: from localhost.localdomain (unknown [219.141.250.2])
        (Authenticated sender: zeming@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 094C11E80D74;
        Thu,  7 Jul 2022 09:57:47 +0800 (CST)
From:   Li zeming <zeming@nfschina.com>
To:     benh@kernel.crashing.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        kernel@nfschina.com, Li zeming <zeming@nfschina.com>
Subject: [PATCH] macintosh/windfarm_pid: Add header file macro definition
Date:   Thu,  7 Jul 2022 09:59:49 +0800
Message-Id: <20220707015949.3733-1-zeming@nfschina.com>
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
 drivers/macintosh/windfarm_pid.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/macintosh/windfarm_pid.h b/drivers/macintosh/windfarm_pid.h
index 83f747dbeafc..9882e90a5071 100644
--- a/drivers/macintosh/windfarm_pid.h
+++ b/drivers/macintosh/windfarm_pid.h
@@ -1,4 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef _WINDFARM_PID_H
+#define _WINDFARM_PID_H
+
 /*
  * Windfarm PowerMac thermal control. Generic PID helpers
  *
@@ -82,3 +85,4 @@ struct wf_cpu_pid_state {
 extern void wf_cpu_pid_init(struct wf_cpu_pid_state *st,
 			    struct wf_cpu_pid_param *param);
 extern s32 wf_cpu_pid_run(struct wf_cpu_pid_state *st, s32 power, s32 temp);
+#endif
-- 
2.18.2

