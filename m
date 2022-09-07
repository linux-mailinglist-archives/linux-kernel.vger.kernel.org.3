Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1498C5B1021
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 01:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbiIGXDp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 19:03:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiIGXDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 19:03:43 -0400
Received: from alln-iport-2.cisco.com (alln-iport-2.cisco.com [173.37.142.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AD28A261C
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 16:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=1445; q=dns/txt; s=iport;
  t=1662591822; x=1663801422;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=SLlPm/SYAr6MHV57O37iy4qpo4ZJe+PXVGQYATH7WfQ=;
  b=Inn6MOaqPwdSBLDKlWpc+6hIWGnIOn8PtLnZqerF0qJK7KbNQuBrv2GZ
   F2J89pBEJnD/6Y6mDXzAxdBey8Ib5PM3K8VERVvLS47LR2QUaPhku1c6P
   oo8bzEZPmoSHYpM+lVGDd8ztGmHPe9fREcBRBLAWiiyk9Am4h8BgyFS2t
   0=;
X-IPAS-Result: =?us-ascii?q?A0ATAACWIhljmJRdJa1aHQEBAQEJARIBBQUBgXsIAQsBg?=
 =?us-ascii?q?3k+RYxtiHGdCIElA1QLAQEBD0IEAQGFBoRnAiU0CQ4BAgQBAQEBAwIDAQEBA?=
 =?us-ascii?q?QEBAwEBBQEBAQIBBwQUAQEBAQEBAQEdGQUQDieFdYZ7AUaBPgESgn2DIQOmF?=
 =?us-ascii?q?YIrgQGIHYFlFIEpAYpshVkcgUlEgRWBPIIsil0iBJIxhWUDCQQHBUpCAwsfD?=
 =?us-ascii?q?hY2AxUDFAMFJAcDGQ8jDQ0EHQwDAwUlAwICGwcCAgMCBhUFAgIXHhg4CAQIB?=
 =?us-ascii?q?CskDwUCBy8FBC8CHgQFBhEIAhYCBgQEBAQVAhAIAggmFwcTMxkBBVkQCSEWB?=
 =?us-ascii?q?igNBQYTAyBHJgUHPg8oMjU5Kx0bCoEOKgkfFQMEBAMCBhMDAyACECwxFAQpE?=
 =?us-ascii?q?xItBytzCQIDImwDAwQoLAMJIR8HKCY8B1kSKAUDAxAiPQYDCQMCJBNHfQ4xF?=
 =?us-ascii?q?BcFAxAZmQYBPVEBgi9zomedH4E1g1yBRohGlgIaMpZykgQtllogonGEUIFhO?=
 =?us-ascii?q?oFbMxoIGxWDIlEZD445jlckMTsCBgsBAQMJilIBAQ?=
IronPort-Data: A9a23:d/oTRKLpEbkkMU47FE+RO5UlxSXFcZb7ZxGr2PjKsXjdYENSgjdVx
 zEdUDqCbP7cZmr8e4wnPojg80wGvZeBndZkGwEd+CA2RRqmiyZq6fd1j6vUF3nPRiEWZBs/t
 63yUvGZcIZsCCW0Si6FatANl1EkvU2zbue6WbWs1hxZH1c+En9w0U07xobVv6Yx6TSHK1LV0
 T/Ni5W31G+Ng1aY5UpNtspvADs21BjDkGtwUm4WPJinj3eC/5UhN6/zEInqR5fOria4KcbhL
 wrL5OnREmo0ZH7BAPv9+lrwWhVirrI/oWFih1IOM5VOjCSuqQQT/7kgGvBHZnwMyBO3rfVNx
 /JKvNuZHFJB0q3kwIzxUjFCGC14eKZB4rKCeCL5us2IxEqAeHzpqxlsJBhpZstDpaAmWicXq
 axwxDMlNnhvg8q6ybS6R+1zj+woLdLgO8UUvXQIITTxXK16HsqeHPqWjTNe9GsIv/9FDeiOX
 dIUOAdoQTbvZR4RHkhCXfrSm8/x1iWgLFW0smm9oasx/niWzwFr1rXpGMTad8bMRshPmEuc4
 GXc8AzRBhAcKczayjCY83agrvHAkDm9W48IErC8sPlwjzW7wGAeExQLUV26rOOiokG5XN1bJ
 gof/S9Gha0z/0yiSp/5XBi8iHuNpB0bRdsWFeAmgCmIw7Hd4weDAXksTTNbbtEi8sgsSlQXO
 kShhdjlA3lkt6eYDCvHsLyVtji1fyMSKAfueBPoUyMkzsb4jotogSmUDfBdIouJgfryEHbZl
 mXiQDcFu50fissC1qOe9F/Bgi6xqpWhcuLTzliMNo5Cxl4kDLNJd7BE+nCAt6ccc9zxok2p+
 SlaxJDEs4jiGLnXzESwrPMx8KZFDhpvGAfdil5mBZU68DLFF5WLIt0IsGgWyKuEzq85ldLBe
 kTfv0Za44VeeSLwK6R2eIm2Tc8tyMAM9OgJtNiJP7KigbAoJGdrGR2Cg2bLhQgBd2B3yskC1
 W+zK5rEMJrjIf0PIMCKb+kcy6Q34Ss12HneQ5v2pzz+j+TEOSHIFexebgrRBgzc0E9iiFiFm
 zq4H5baoyizrMWiCsUq2ddJdAtTfSRT6W7e8pALJoZv3TaK6El4W6OOntvNiqRunr9eka/T7
 2qhV0pDoGcTdlWZQThmnktLMeu1Nb4m9CpTFXV1bT6AhSN5Ca7xt/h3SnfCVeR9nACV5aQqH
 6BtlgTpKqkndwkrDBxENcal99Y8JEzw7e9MVgL8CAUCk1dbb1Sh0rfZksHHrUHi0gLfWRMCn
 oCd
IronPort-HdrOrdr: A9a23:zoR4z62zwW9dUMbJFWxypgqjBL0kLtp133Aq2lEZdPWaSKClfq
 eV7ZYmPHDP5gr5NEtLpTniAtjifZqjz/9ICOAqVN/IYOCMggSVxe9ZgLcK6geQfhEWjtQ86U
 +lGJIOb+EZyjNB/KLH3DU=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.93,298,1654560000"; 
   d="scan'208";a="934725774"
Received: from rcdn-core-12.cisco.com ([173.37.93.148])
  by alln-iport-2.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 07 Sep 2022 23:03:41 +0000
Received: from localhost.localdomain ([10.25.130.54])
        by rcdn-core-12.cisco.com (8.15.2/8.15.2) with ESMTP id 287N3deT010146;
        Wed, 7 Sep 2022 23:03:39 GMT
From:   Daniel Walker <danielwa@cisco.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     xe-linux-external@cisco.com, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC-PATCH] Makefile: dts: include directory makefile for DTC_FLAGS
Date:   Wed,  7 Sep 2022 16:03:38 -0700
Message-Id: <20220907230339.271633-1-danielwa@cisco.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-Outbound-SMTP-Client: 10.25.130.54, [10.25.130.54]
X-Outbound-Node: rcdn-core-12.cisco.com
X-Spam-Status: No, score=-11.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current Makefile will drop the DTC_FLAGS depending on how you
build. For example,

make dtbs

includes correct DTC_FLAGS. However if you run,

make nvidia/tegra210-p2371-2180.dtb

The DTC_FLAGS are dropped. This appears to be caused by the top level
Makefile not including the Makefile from the directory where the dts lives.

This normally doesn't matter because most dts files have nothing added
from the Makefile. This changes when you have overlays, and the
DTC_FLAGS modifier is mandatory for the dtb to work correctly.

This change adds a -f argument which includes the Makefile from the
directory where the dts file reside. This change is also required for
dtbo files.

Cc: xe-linux-external@cisco.com
Signed-off-by: Daniel Walker <danielwa@cisco.com>
---
 Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index ac16bd92b156..bc245e2dc8d1 100644
--- a/Makefile
+++ b/Makefile
@@ -1460,10 +1460,10 @@ endif
 ifneq ($(dtstree),)
 
 %.dtb: dtbs_prepare
-	$(Q)$(MAKE) $(build)=$(dtstree) $(dtstree)/$@
+	$(Q)$(MAKE) -f $(srctree)/$(dtstree)/$(dir $@)Makefile $(build)=$(dtstree) $(dtstree)/$@
 
 %.dtbo: dtbs_prepare
-	$(Q)$(MAKE) $(build)=$(dtstree) $(dtstree)/$@
+	$(Q)$(MAKE) -f $(srctree)/$(dtstree)/$(dir $@)Makefile $(build)=$(dtstree) $(dtstree)/$@
 
 PHONY += dtbs dtbs_prepare dtbs_install dtbs_check
 dtbs: dtbs_prepare
-- 
2.25.1

