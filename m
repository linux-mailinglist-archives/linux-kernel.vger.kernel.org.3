Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCCFA55B0A6
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 11:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234229AbiFZJLg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 05:11:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234050AbiFZJLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 05:11:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 323DD12A92;
        Sun, 26 Jun 2022 02:11:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4382661190;
        Sun, 26 Jun 2022 09:11:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A882C36AEC;
        Sun, 26 Jun 2022 09:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656234671;
        bh=IZ7UQBiFTK6+EQSreXzAvegFb5Jyj+NzY1U3aaiZ3co=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oLeod4uCDPfXHCuGZ+Xs15+FPpKxlYQ6PptWyOc4JHTIC1lzjo+abOgBIfUlK07T+
         Dwjrg3iqV8oXSERBz7SdOcGX6xA+hXktGsP3pcpHCNiL+q+3p6eT59Cs/Urd9cxVJw
         Md10WdtEcxez2ccxZeSYpb7UCdG5S7BmNCWFezpKgttNT1uuMgbbnC5idy5EfWSx9S
         1XsSjU4dr39/qBXoMe4Lygsduxg0IRzGEb7VZraGenyazagw0cq9dOGTTOAYybzJqh
         sqmyb3Bb2QICG7qWkqWIQfvtTg5UWd+Vk+2H+G2+lwNNOu4UkIHDZ+C4Qwq0UB9V9Z
         zsBQQXpQ9Qf4A==
Received: from mchehab by mail.kernel.org with local (Exim 4.95)
        (envelope-from <mchehab@kernel.org>)
        id 1o5OIO-001cp6-5Y;
        Sun, 26 Jun 2022 10:11:08 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
        Finn Thain <fthain@linux-m68k.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org
Subject: [PATCH v2 16/20] arch: m68k: q40: README: drop references to IDE driver
Date:   Sun, 26 Jun 2022 10:11:02 +0100
Message-Id: <d6e3482ed622b6953db69cddb70f20c55c96e4da.1656234456.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1656234456.git.mchehab@kernel.org>
References: <cover.1656234456.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since IDE support was deleted by Christoph Hellwig <hch@lst.de>,
Jun 16 2021, drop the left-over from README file, updating the
documentation to point to ata/pata_falcon.c.

Fixes: 44b1fbc0f5f3 ("m68k/q40: Replace q40ide driver with pata_falcon and falconide")
Fixes: b7fb14d3ac63 ("ide: remove the legacy ide driver")
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH v2 00/20] at: https://lore.kernel.org/all/cover.1656234456.git.mchehab@kernel.org/

 arch/m68k/q40/README | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/m68k/q40/README b/arch/m68k/q40/README
index a4991d2d8af6..9760e9081f6f 100644
--- a/arch/m68k/q40/README
+++ b/arch/m68k/q40/README
@@ -30,11 +30,10 @@ drivers used by the Q40, apart from the very obvious (console etc.):
 		     genrtc.c		# RTC
 		char/joystick/*		# most of this should work, not
 				        # in default config.in
-	        block/q40ide.c		# startup for ide
-		      ide*		# see Documentation/ide/ide.rst
-		      floppy.c		# normal PC driver, DMA emu in asm/floppy.h
+	        block/floppy.c		# normal PC driver, DMA emu in asm/floppy.h
 					# and arch/m68k/kernel/entry.S
 					# see drivers/block/README.fd
+		ata/pata_falcon.c
 		net/ne.c
 		video/q40fb.c
 		parport/*
-- 
2.36.1

