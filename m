Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D72524B39E4
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 08:07:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233982AbiBMHDN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 02:03:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231410AbiBMHDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 02:03:12 -0500
Received: from relay5.hostedemail.com (relay5.hostedemail.com [64.99.140.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E74245DE65
        for <linux-kernel@vger.kernel.org>; Sat, 12 Feb 2022 23:03:05 -0800 (PST)
Received: from omf03.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay07.hostedemail.com (Postfix) with ESMTP id C0B9C20F14;
        Sun, 13 Feb 2022 07:03:04 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf03.hostedemail.com (Postfix) with ESMTPA id A063F6000D;
        Sun, 13 Feb 2022 07:02:37 +0000 (UTC)
Message-ID: <3bd6ada59f411a7685d7e64eeb670540d4bfdcde.camel@perches.com>
Subject: [PATCH] checkpatch: add early_param exception to blank line after
 struct/function test
From:   Joe Perches <joe@perches.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andy Whitcroft <apw@canonical.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel@vger.kernel.org
Date:   Sat, 12 Feb 2022 23:03:02 -0800
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: A063F6000D
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Stat-Signature: x1ao4dhk6jmd4ibbpj3b5hbrz1nkjhcb
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+Iv5VSe0HrJpNOjUgwWIMqpX6LHBkUuPA=
X-HE-Tag: 1644735757-263964
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add early_param as another exception to the blank line preferred after
function/struct/union declaration or definition test.

Signed-off-by: Joe Perches <joe@perches.com>
---
 scripts/checkpatch.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 071b3304f5d7c..727d23b934da2 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3930,7 +3930,7 @@ sub process {
 		if ($prevline =~ /^[\+ ]};?\s*$/ &&
 		    $line =~ /^\+/ &&
 		    !($line =~ /^\+\s*$/ ||
-		      $line =~ /^\+\s*EXPORT_SYMBOL/ ||
+		      $line =~ /^\+\s*(?:EXPORT_SYMBOL|early_param)/ ||
 		      $line =~ /^\+\s*MODULE_/i ||
 		      $line =~ /^\+\s*\#\s*(?:end|elif|else)/ ||
 		      $line =~ /^\+[a-z_]*init/ ||


