Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A6CA504A61
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 03:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235561AbiDRBRc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Apr 2022 21:17:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbiDRBRa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 21:17:30 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7641212094;
        Sun, 17 Apr 2022 18:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=4J8PtHH4PrE8B/9vtKpbIgGLAeLCaFgTs0yhAH8f0cE=; b=1s4i9ZyzkWp2AMDKp7lj0eHfSm
        0Tr3uvfYW33RCr4k9+r/R8IQLoz+6fYJmf3ozlwWqe8vPrU0N+rfVc/M1IwKdzEXzADSgtw0NsLL8
        ffzG1bWg4sqJJ2gb1OrzQ2EfrBwf8hCO6u3py9vNRuPlRbIXCqqItlZWY9LCqG/6x+NBNh+6mVbv9
        w+yihGv9/6+bfsY8zPKDLmXaiuFnK6ZESgCp8vOnalzDBdkPgnZaiB0GDVmpgNZTDQWXAnzFbWpqF
        H+nRD+gBsSOHYW6TKl6toWZl6nNZQDGSWq0gnLWH+CgtPfFwReRFeTUT9CcYiOOngjicu9NpIpjG/
        3EeSU+vg==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ngFyd-00FCIL-9h; Mon, 18 Apr 2022 01:14:51 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-doc@vger.kernel.org, linux-trace-devel@vger.kernel.org
Subject: [PATCH] rtla: Documentation: fix email addresses
Date:   Sun, 17 Apr 2022 18:14:50 -0700
Message-Id: <20220418011450.11821-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct lkml@vger to linux-kernel@vger.
Add linux-trace-devel since that is what is in the MAINTAINERS file.

Fixes: d40d48e1f1f2 ("rtla: Add Documentation")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Daniel Bristot de Oliveira <bristot@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-doc@vger.kernel.org
Cc: linux-trace-devel@vger.kernel.org
---
 Documentation/tools/rtla/common_appendix.rst |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/Documentation/tools/rtla/common_appendix.rst
+++ b/Documentation/tools/rtla/common_appendix.rst
@@ -1,6 +1,7 @@
 REPORTING BUGS
 ==============
-Report bugs to <lkml@vger.kernel.org>
+Report bugs to <linux-kernel@vger.kernel.org>
+and <linux-trace-devel@vger.kernel.org>
 
 LICENSE
 =======
