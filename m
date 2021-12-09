Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EB9646E437
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 09:30:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234438AbhLIIeF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 03:34:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232375AbhLIIeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 03:34:03 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A746C061746;
        Thu,  9 Dec 2021 00:30:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id C316CCE2503;
        Thu,  9 Dec 2021 08:30:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5E1DC004DD;
        Thu,  9 Dec 2021 08:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639038627;
        bh=MCzxBcEFTEc7oegEyl2A4TZ8NyqD8fdlm7fiXv1HsdM=;
        h=From:To:Cc:Subject:Date:From;
        b=ScRsORoelMLhEai6b2Dx/CfA9BNngH+fw/CqcbrxuX8hpg36Rb9ocgJMDdXlRQhzV
         oFN7OfMdMsCfvTWm8i4XMurvuRuI/+61hTiNr3S0O5rSAI/nZBE90adz7XdN/NoBiG
         INEfEr/IaRs1qgAecUB58/r4SVC/w088N41QGjCK3O6DpZ7mZnJDXjsDjM7j7qGalw
         08p6xoxck2+cGg4W9nXXd/i8OyjaQUGKai0fForICrkeuoTHqD/38g2csNmt2IYYPk
         aOeBKeTye0pBmR8ENsqbEpB4BMxwNrwzqUZhgKJ5dkO+RfMOmQhZI5oCWVehSLR83o
         F73ndaxPi0Gvw==
From:   Jessica Yu <jeyu@kernel.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Lucas De Marchi <lucas.demarchi@intel.com>,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        Jessica Yu <jeyu@kernel.org>
Subject: [PATCH] MAINTAINERS: Remove myself as modules maintainer
Date:   Thu,  9 Dec 2021 09:28:50 +0100
Message-Id: <20211209082850.10021-1-jeyu@kernel.org>
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
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 43007f2d29e0..a92145633fbe 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12866,7 +12866,6 @@ F:	drivers/media/dvb-frontends/mn88473*
 
 MODULE SUPPORT
 M:	Luis Chamberlain <mcgrof@kernel.org>
-M:	Jessica Yu <jeyu@kernel.org>
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/jeyu/linux.git modules-next
 F:	include/linux/module.h
-- 
2.33.1

