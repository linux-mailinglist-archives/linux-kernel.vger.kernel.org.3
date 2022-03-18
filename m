Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C8444DD840
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 11:39:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235175AbiCRKjZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 06:39:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235070AbiCRKi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 06:38:59 -0400
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3449F2D8121;
        Fri, 18 Mar 2022 03:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=TbqOQL4rFrQmaEBw6WsX9DXTat3qEfn2mN36QIANnmI=;
  b=Omdaug2Xr+OZFDMWnYO45KmGogymUJELyoFYLThKbJRsy2q649eVmZq4
   i0o1OHlKZwB+BVcM5KO3izXFq1g3v56U7YyUBHFfAzyXean/+hZU/HdHh
   YB0Yx8+WGLhxW9WRbHpJknXOStvDiEi5xClOGwTnbrCh+A1E9aKBni6Bg
   Y=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.90,192,1643670000"; 
   d="scan'208";a="8935637"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 11:37:36 +0100
From:   Julia Lawall <Julia.Lawall@inria.fr>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     kernel-janitors@vger.kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        uclinux-h8-devel@lists.sourceforge.jp, linux-kernel@vger.kernel.org
Subject: [PATCH] h8300: fix typos in comments
Date:   Fri, 18 Mar 2022 11:37:02 +0100
Message-Id: <20220318103729.157574-7-Julia.Lawall@inria.fr>
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

Various spelling mistakes in comments.
Detected with the help of Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 arch/h8300/kernel/ptrace_h.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/h8300/kernel/ptrace_h.c b/arch/h8300/kernel/ptrace_h.c
index 15db45a03b04..d6eac37ba1b6 100644
--- a/arch/h8300/kernel/ptrace_h.c
+++ b/arch/h8300/kernel/ptrace_h.c
@@ -27,7 +27,7 @@ void user_disable_single_step(struct task_struct *child)
 enum jump_type {none,	 /* normal instruction */
 		jabs,	 /* absolute address jump */
 		ind,	 /* indirect address jump */
-		ret,	 /* return to subrutine */
+		ret,	 /* return to subroutine */
 		reg,	 /* register indexed jump */
 		relb,	 /* pc relative jump (byte offset) */
 		relw,	 /* pc relative jump (word offset) */

