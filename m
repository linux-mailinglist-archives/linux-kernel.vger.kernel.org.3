Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D74395243D0
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 06:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345817AbiELECA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 00:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345623AbiELEBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 00:01:43 -0400
Received: from conuserg-07.nifty.com (conuserg-07.nifty.com [210.131.2.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0039B54FB1
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 21:01:42 -0700 (PDT)
Received: from grover.jp (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id 24C41CNN015198;
        Thu, 12 May 2022 13:01:12 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com 24C41CNN015198
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1652328072;
        bh=KgGewnRxd6B9bmU83w0Z+PwveeUHvuXAra4qE2JWIyE=;
        h=From:To:Cc:Subject:Date:From;
        b=vlFosGTanmeZQaGvHFjlnLwijUmuhtuvzhn0MuXaJzUPI5GnBmdQ4VobdmXppvu0Q
         jH1FNp13pb1zvahqpm3VfETJZX/s2sDwRZP+Dktmdrsxu16YrOzd1cI1YnfXalfPvf
         sBWBKgwG54LigM3Uuv3/hjvlWrD5KPfUcbYHg4yx5qTca6UU8G/v57kWdmglKFzJln
         Xq95YLnJ/phGMgLypDrugil7G2/HiosRuvVsiL8avR5NHH5dHAB71P1vPS9jiLcbBf
         gLjg/zl1Lq3tFF+bEiqTIUL8HocTEMbAlaazRhlL93o8yN3HOuVq4XSOINptUCE/t6
         0Cq4MNsR94L2w==
X-Nifty-SrcIP: [133.32.177.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Guo Ren <guoren@kernel.org>, linux-csky@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 1/4] csky: remove unused $(dtb-y) from arch/csky/boot/Makefile
Date:   Thu, 12 May 2022 12:59:00 +0900
Message-Id: <20220512035903.2779287-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

arch/csky/boot/Makefile does not build DTB.
arch/csky/boot/dts/Makefile does.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/csky/boot/Makefile | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/csky/boot/Makefile b/arch/csky/boot/Makefile
index dbc9b1bd72f0..c3cfde28f8e6 100644
--- a/arch/csky/boot/Makefile
+++ b/arch/csky/boot/Makefile
@@ -1,6 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
 targets := Image zImage uImage
-targets += $(dtb-y)
 
 $(obj)/Image: vmlinux FORCE
 	$(call if_changed,objcopy)
-- 
2.32.0

