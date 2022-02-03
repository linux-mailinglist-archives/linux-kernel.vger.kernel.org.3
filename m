Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34ECF4A80D7
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 10:03:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349681AbiBCJDd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 04:03:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234747AbiBCJDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 04:03:31 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2174C061714
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 01:03:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7BFD460A3C
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 09:03:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5CD2C340E4;
        Thu,  3 Feb 2022 09:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643879009;
        bh=x2aFpdaVgvG8RNeAtaYIpc4g3hbk0nMJdmBngbhRKfc=;
        h=From:To:Cc:Subject:Date:From;
        b=qrKXP6FWoyUv07vRCWvYiYjCkE7cmSb89tNsvxLGYbC+d5s6i6pVInfsuBjgq049P
         +JuK+BSimbZ9IhUajiBR+nQaCPfyu5JiSKuJAAsLQ8D6bHgnelgajqq50a6505V8qg
         /4+H1jnC3hMI0k/6gmG+k5oDhA3xsS4PIyAL2RaNiMeYIceTBrqIRfW5/lugUrYWGE
         Y55rC7j0fZEcMicNan9WrDW+VJAAgR8GfBspMJSbOF8GayazOvC98hgN0dptKQlqrT
         3XPkeqkqoQi7r+BTpyclK5y7E76oqfsYCRZ1bQvke9f+P9w7Tj9MJVMri2jg19jPI/
         0C43mFauAcDZg==
From:   Mike Rapoport <rppt@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>
Subject: [PATCH] MAINTAINERS: update rppt's email
Date:   Thu,  3 Feb 2022 11:03:24 +0200
Message-Id: <20220203090324.3701774-1-rppt@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

Use my @kernel.org address

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index f41088418aae..c820e03c4414 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12400,7 +12400,7 @@ F:	include/uapi/linux/membarrier.h
 F:	kernel/sched/membarrier.c
 
 MEMBLOCK
-M:	Mike Rapoport <rppt@linux.ibm.com>
+M:	Mike Rapoport <rppt@kernel.org>
 L:	linux-mm@kvack.org
 S:	Maintained
 F:	Documentation/core-api/boot-time-mm.rst
-- 
2.34.1

