Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3823494258
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 22:06:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245699AbiASVGs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 16:06:48 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:40454 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbiASVGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 16:06:47 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 43C61B81B40;
        Wed, 19 Jan 2022 21:06:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED186C004E1;
        Wed, 19 Jan 2022 21:06:43 +0000 (UTC)
Date:   Wed, 19 Jan 2022 16:06:42 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joe Perches <joe@perches.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: [PATCH] docs: Update the preferred line size to 100 characters
Message-ID: <20220119160642.140e84c6@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

As commit bdc48fa11e46f ("checkpatch/coding-style: deprecate 80-column
warning") states:

    Increase the default limit to 100 characters.  Not because 100
    characters is some hard limit either, but that's certainly a "what are
    you doing" kind of value and less likely to be about the occasional
    slightly longer lines.

It's 2022, people are not using 80x24 terminals anymore (well I'm sure
someone is, but they are the small minority).

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 Documentation/process/coding-style.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/process/coding-style.rst b/Documentation/process/coding-style.rst
index 03eb53fd029a..73be9edffede 100644
--- a/Documentation/process/coding-style.rst
+++ b/Documentation/process/coding-style.rst
@@ -101,10 +101,10 @@ Get a decent editor and don't leave whitespace at the end of lines.
 Coding style is all about readability and maintainability using commonly
 available tools.
 
-The preferred limit on the length of a single line is 80 columns.
+The preferred limit on the length of a single line is 100 columns.
 
-Statements longer than 80 columns should be broken into sensible chunks,
-unless exceeding 80 columns significantly increases readability and does
+Statements longer than 100 columns should be broken into sensible chunks,
+unless exceeding 100 columns significantly increases readability and does
 not hide information.
 
 Descendants are always substantially shorter than the parent and
-- 
2.33.0

