Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6D3C5432B7
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 16:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241460AbiFHOgW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 10:36:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241005AbiFHOgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 10:36:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A811357B35
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 07:36:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4603961B8D
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 14:36:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72E65C34116;
        Wed,  8 Jun 2022 14:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654698978;
        bh=3X/DXsxcjpI4dcOp06iuY7OHxEhJeva0tl/x5kqZNTc=;
        h=From:To:Cc:Subject:Date:From;
        b=kvgyY5tPMuBKazQ1rsSeiTlLEgM7pOQbKk3OZrfsjTayj9VjfQLathntsNzpLe7IQ
         sQcG7S13+c/yk5fdZiy6uQUM2Pnqma96Mba5XlE9v5LkIXiRCPuKFh2kMtp/lXp43b
         pzgng15w19lX2igNCtSNLSDAnxLY2rtpcXCNR4BdkMemgbXQ2zLE8BB1mNehqAcfpG
         2FcGP/36mynBoLIg5JXl216sycbq5X5WjByCoOLP15KPsx/+v+8JSY2zyX6xoNocpT
         5Q/ZPvf3cScMCmF8Yu440CgcgjQt4h62v2kk8y2N1IVlEYF+4SJllGNDBoEt74AXhw
         JlQvUTR796oSg==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc:     linux1394-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH] MAINTAINERS: Mark linux1394-devel as subscribers-only
Date:   Wed,  8 Jun 2022 09:36:14 -0500
Message-Id: <20220608143614.398128-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
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

From: Bjorn Helgaas <bhelgaas@google.com>

The linux1394-devel mailing list rejects messages from non-subscribers, so
mark it as such:

  Your message has been rejected, probably because you are not
  subscribed to the mailing list and the list's policy is to prohibit
  non-members from posting to it.  If you think that your messages are
  being rejected in error, contact the mailing list owner at
  linux1394-devel-owner@lists.sourceforge.net.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 MAINTAINERS | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index a6d3bd9d2a8d..9d5a24d9187b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7697,7 +7697,7 @@ F:	sound/firewire/
 FIREWIRE MEDIA DRIVERS (firedtv)
 M:	Stefan Richter <stefanr@s5r6.in-berlin.de>
 L:	linux-media@vger.kernel.org
-L:	linux1394-devel@lists.sourceforge.net
+L:	linux1394-devel@lists.sourceforge.net (subscribers-only)
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media.git
 F:	drivers/media/firewire/
@@ -7706,14 +7706,14 @@ FIREWIRE SBP-2 TARGET
 M:	Chris Boot <bootc@bootc.net>
 L:	linux-scsi@vger.kernel.org
 L:	target-devel@vger.kernel.org
-L:	linux1394-devel@lists.sourceforge.net
+L:	linux1394-devel@lists.sourceforge.net (subscribers-only)
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/nab/lio-core-2.6.git master
 F:	drivers/target/sbp/
 
 FIREWIRE SUBSYSTEM
 M:	Stefan Richter <stefanr@s5r6.in-berlin.de>
-L:	linux1394-devel@lists.sourceforge.net
+L:	linux1394-devel@lists.sourceforge.net (subscribers-only)
 S:	Maintained
 W:	http://ieee1394.wiki.kernel.org/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/ieee1394/linux1394.git
-- 
2.25.1

