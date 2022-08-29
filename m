Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D88DA5A5402
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 20:39:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbiH2SjL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 14:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiH2SjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 14:39:09 -0400
Received: from mx3.wp.pl (mx3.wp.pl [212.77.101.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DC2B7F0B5
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 11:39:07 -0700 (PDT)
Received: (wp-smtpd smtp.wp.pl 11137 invoked from network); 29 Aug 2022 20:39:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=1024a;
          t=1661798341; bh=KYk0F5rL/05QNecCXVHTwCSPO4E26vN1t3B/MPgqtXU=;
          h=From:To:Subject;
          b=oCLypSCnPUWbNEt1vQo9pF0GQA8JSbAWHE6hp4muHV0TZx6fQaVATbRPkaqC8lpl3
           2wkejebz78+YoJwbfNHewVfyuMA79hUu9XWis6T+usiLbLHtXniYrnAIEhpvjliCek
           j5kazUWT3MK409iM+JVTt36t/wUL14KGFcoCpfxU=
Received: from ip-137-21.ds.pw.edu.pl (HELO LAPTOP-OLEK.lan) (olek2@wp.pl@[194.29.137.21])
          (envelope-sender <olek2@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <robh+dt@kernel.org>; 29 Aug 2022 20:39:01 +0200
From:   Aleksander Jan Bajkowski <olek2@wp.pl>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        tsbogend@alpha.franken.de, olek2@wp.pl, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] MIPS: dts: lantiq: rename dts files with soc name being the prefix
Date:   Mon, 29 Aug 2022 20:37:17 +0200
Message-Id: <20220829183717.4394-1-olek2@wp.pl>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-WP-MailID: de3215a5c917005624290f2748c79044
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [4bOU]                               
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename lantiq dts files with soc name being the prefix, so that the
board dts file can be located easily by soc name, and we also gain
the consistency of naming.

This patch is a preparation for the addition of dts for newer SoCs
(Lantiq ARX100, VRX200 and xRX330).

Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>
---
 arch/mips/boot/dts/lantiq/Makefile                              | 2 +-
 .../boot/dts/lantiq/{easy50712.dts => danube_easy50712.dts}     | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename arch/mips/boot/dts/lantiq/{easy50712.dts => danube_easy50712.dts} (100%)

diff --git a/arch/mips/boot/dts/lantiq/Makefile b/arch/mips/boot/dts/lantiq/Makefile
index f5dfc06242b9..ae6e3e21ebeb 100644
--- a/arch/mips/boot/dts/lantiq/Makefile
+++ b/arch/mips/boot/dts/lantiq/Makefile
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
-dtb-$(CONFIG_DT_EASY50712)	+= easy50712.dtb
+dtb-$(CONFIG_DT_EASY50712)	+= danube_easy50712.dtb
 
 obj-$(CONFIG_BUILTIN_DTB)	+= $(addsuffix .o, $(dtb-y))
diff --git a/arch/mips/boot/dts/lantiq/easy50712.dts b/arch/mips/boot/dts/lantiq/danube_easy50712.dts
similarity index 100%
rename from arch/mips/boot/dts/lantiq/easy50712.dts
rename to arch/mips/boot/dts/lantiq/danube_easy50712.dts
-- 
2.30.2

