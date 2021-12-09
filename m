Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF88346E47B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 09:44:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235099AbhLIIrq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 03:47:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232771AbhLIIrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 03:47:45 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E752C061746;
        Thu,  9 Dec 2021 00:44:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 65CB9CE2503;
        Thu,  9 Dec 2021 08:44:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6023EC004DD;
        Thu,  9 Dec 2021 08:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639039448;
        bh=tMyfnIzKmgup916YmhKBf/oZD2H/JhJTFwWtKFtSYwg=;
        h=From:To:Cc:Subject:Date:From;
        b=oHMzYpx/U/7+bVVN6bCOXUsB0xcU/0rEUaDV0tEnhUHBvGLrjgaIkLSOjtmQzbaOY
         iDvTqFS0PSQmvEwiLC7skGK6MI1uG/uiOZOgOL4KsJS/Iyq5hBEdlVsRbWbS3t73FA
         EJVuxvOtsqq/bwPnQlVxg9NRowiZG0qmzLG7Ht/s2lVHQN0RuzVV8ZCYnLJNWf7pEf
         /Vn+AMqjByK3HjNc9ngFW27J0iWOa5MoU5QTGjP0DKzovA6RagUn51BPrPcZQheR/x
         tsD3z14ELp1paFUeudQjJjdPPvD/hGl9RdUVQF7lmfUgaCE1lFTP+MpnzccwqRBpJi
         af9JlVsn30rLQ==
From:   Jessica Yu <jeyu@kernel.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Lucas De Marchi <lucas.demarchi@intel.com>,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        Jessica Yu <jeyu@kernel.org>
Subject: [PATCH v2] MAINTAINERS: Remove myself as modules maintainer
Date:   Thu,  9 Dec 2021 09:43:13 +0100
Message-Id: <20211209084313.10621-1-jeyu@kernel.org>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Luis has done a great job maintaining modules so far. As I'm planning to
take a break from work soon, I think we're ready to transition over fully.

Signed-off-by: Jessica Yu <jeyu@kernel.org>
---
v2: Change the git repo too.

 MAINTAINERS | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 43007f2d29e0..84067208c460 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12866,9 +12866,8 @@ F:	drivers/media/dvb-frontends/mn88473*
 
 MODULE SUPPORT
 M:	Luis Chamberlain <mcgrof@kernel.org>
-M:	Jessica Yu <jeyu@kernel.org>
 S:	Maintained
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/jeyu/linux.git modules-next
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git modules-next
 F:	include/linux/module.h
 F:	kernel/module.c
 
-- 
2.33.1

