Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5171953EBE6
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:09:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240690AbiFFP0w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 11:26:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240610AbiFFPZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 11:25:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BFAB1CD36E;
        Mon,  6 Jun 2022 08:25:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1069D6154B;
        Mon,  6 Jun 2022 15:25:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EFB2C341E8;
        Mon,  6 Jun 2022 15:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654529149;
        bh=P/ZZQJbpLLBjuQh2G6MF/T6nwAhbQfPWvBqgMsptpx4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ko5+VusQxc88bi5bLZkz9C30n0GqVEWwi7lPqyCxMEfS/5Lxu+WyJ0VpF6r65BQDX
         qtn661HpXY3EA4IdaR5thgiryc0rKlBC6axQoiCvV32js/gPV16tk9NxhIc78lRUxk
         iI50i60mrZNkaNJWyNxg7zWJlZDOgbCdJw5zIVb1wqDd3xnK3smmzpItKxvbqffY5f
         et/sLiJYChTb4jOOP90CXxzpavDcC31r8kMUxHLEqfMB5kpE0mjSEngFywuK+nHr1t
         NVdEAjjQdFYcwWGH3ejTLFckd9zf1RuXsXWDbfR28au5aoFCB3Jzj2wMLrA8r//Kvn
         qm5uA9pEoIQGA==
Received: from mchehab by mail.kernel.org with local (Exim 4.95)
        (envelope-from <mchehab@kernel.org>)
        id 1nyEby-0012Q9-GE;
        Mon, 06 Jun 2022 16:25:46 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org
Subject: [PATCH 23/23] arch: m68k: q40: README: drop references to IDE driver
Date:   Mon,  6 Jun 2022 16:25:45 +0100
Message-Id: <39b24f99f5b71eb5ac025b438b7eb2a0df2258a1.1654529011.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1654529011.git.mchehab@kernel.org>
References: <cover.1654529011.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since IDE support was deleted by Christoph Hellwig <hch@lst.de>,
Jun 16 2021, drop the left-over from README file.

Fixes: b7fb14d3ac63 ("ide: remove the legacy ide driver")
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH 00/23] at: https://lore.kernel.org/all/cover.1654529011.git.mchehab@kernel.org/

 arch/m68k/q40/README | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/m68k/q40/README b/arch/m68k/q40/README
index a4991d2d8af6..4db6db54d57a 100644
--- a/arch/m68k/q40/README
+++ b/arch/m68k/q40/README
@@ -30,9 +30,7 @@ drivers used by the Q40, apart from the very obvious (console etc.):
 		     genrtc.c		# RTC
 		char/joystick/*		# most of this should work, not
 				        # in default config.in
-	        block/q40ide.c		# startup for ide
-		      ide*		# see Documentation/ide/ide.rst
-		      floppy.c		# normal PC driver, DMA emu in asm/floppy.h
+	        block/floppy.c		# normal PC driver, DMA emu in asm/floppy.h
 					# and arch/m68k/kernel/entry.S
 					# see drivers/block/README.fd
 		net/ne.c
-- 
2.36.1

