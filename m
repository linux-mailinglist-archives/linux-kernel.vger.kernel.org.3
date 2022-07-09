Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A8BF56C96B
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 14:43:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbiGIMnf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 08:43:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiGIMnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 08:43:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CF3326A
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jul 2022 05:43:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 71625B819D3
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jul 2022 12:43:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8ADCC3411C;
        Sat,  9 Jul 2022 12:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657370606;
        bh=nXYb8YzZctpIOUjhb+F2KTD1t1leXFU48frkQUUUoo8=;
        h=From:To:Cc:Subject:Date:From;
        b=B58a5ISetczC6NCJU+6mMVEAUpl/q5hllgS8lWOQjwyWQyEcbkWND6cq+wOI1b57w
         SASyAMxgk4iCthA67IKqSw/2NVXk7eqFGBHzi+Okrnk8lZd9tNXzse4o5cliiwGxSW
         NIq6z8JSkfgL5icynk6j3FP91DYH4Ph2hjFagzgg61NIunqPdKBMWO3WJak3nN0N2G
         CovEpsorx9KVR7XuE4Zcm3/ccG2vV50+qg5fJfrjCsppzlD+3uHosbRBj5i3PgW6Kk
         FUsBuqJgDTJEqJRIO/XACqs77DzYLNFBMy0PMU1kida+FsQkBKIhNu7P7vyClZwTKE
         PMwOsS0zF6LfA==
Received: by pali.im (Postfix)
        id CC341AFA; Sat,  9 Jul 2022 14:43:22 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Scott Wood <oss@buserror.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc/85xx: Fix description of MPC85xx and P1/P2 boards options
Date:   Sat,  9 Jul 2022 14:43:05 +0200
Message-Id: <20220709124305.17559-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

More MPC85xx and P1/P2 boards options have incorrect description. Fix them
to include list of all boards for which they enable/disable support.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 arch/powerpc/platforms/85xx/Kconfig | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/Kconfig b/arch/powerpc/platforms/85xx/Kconfig
index 2be17ffe8714..be16eba0f704 100644
--- a/arch/powerpc/platforms/85xx/Kconfig
+++ b/arch/powerpc/platforms/85xx/Kconfig
@@ -62,13 +62,13 @@ config MPC85xx_CDS
 	  This option enables support for the MPC85xx CDS board
 
 config MPC85xx_MDS
-	bool "Freescale MPC85xx MDS"
+	bool "Freescale MPC8568 MDS / MPC8569 MDS / P1021 MDS"
 	select DEFAULT_UIMAGE
 	select PHYLIB if NETDEVICES
 	select HAVE_RAPIDIO
 	select SWIOTLB
 	help
-	  This option enables support for the MPC85xx MDS board
+	  This option enables support for the MPC8568 MDS, MPC8569 MDS and P1021 MDS boards
 
 config MPC8536_DS
 	bool "Freescale MPC8536 DS"
@@ -78,28 +78,30 @@ config MPC8536_DS
 	  This option enables support for the MPC8536 DS board
 
 config MPC85xx_DS
-	bool "Freescale MPC85xx DS"
+	bool "Freescale MPC8544 DS / MPC8572 DS / P2020 DS"
 	select PPC_I8259
 	select DEFAULT_UIMAGE
 	select FSL_ULI1575 if PCI
 	select SWIOTLB
 	help
-	  This option enables support for the MPC85xx DS (MPC8544 DS) board
+	  This option enables support for the MPC8544 DS, MPC8572 DS and P2020 DS boards
 
 config MPC85xx_RDB
-	bool "Freescale MPC85xx RDB"
+	bool "Freescale P102x MBG/UTM/RDB and P2020 RDB"
 	select PPC_I8259
 	select DEFAULT_UIMAGE
 	select FSL_ULI1575 if PCI
 	select SWIOTLB
 	help
-	  This option enables support for the MPC85xx RDB (P2020 RDB) board
+	  This option enables support for the P1020 MBG PC, P1020 UTM PC,
+	  P1020 RDB PC, P1020 RDB PD, P1020 RDB, P1021 RDB PC, P1024 RDB,
+	  P1025 RDB, P2020 RDB and P2020 RDB PC boards
 
 config P1010_RDB
-	bool "Freescale P1010RDB"
+	bool "Freescale P1010 RDB"
 	select DEFAULT_UIMAGE
 	help
-	  This option enables support for the MPC85xx RDB (P1010 RDB) board
+	  This option enables support for the P1010 RDB board
 
 	  P1010RDB contains P1010Si, which provides CPU performance up to 800
 	  MHz and 1600 DMIPS, additional functionality and faster interfaces
-- 
2.20.1

