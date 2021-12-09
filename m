Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3C6946E5F7
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 10:52:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231483AbhLIJz7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 04:55:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbhLIJzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 04:55:53 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2C99C061746;
        Thu,  9 Dec 2021 01:52:20 -0800 (PST)
Received: from ip4d173d4a.dynamic.kabel-deutschland.de ([77.23.61.74] helo=truhe.fritz.box); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1mvG66-0008GF-6o; Thu, 09 Dec 2021 10:52:18 +0100
From:   Thorsten Leemhuis <linux@leemhuis.info>
To:     workflows@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ksummit@lists.linux.dev,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: [RFC PATCH v2 1/2] docs: 5.Posting.rst: describe Fixes: and Link: tags
Date:   Thu,  9 Dec 2021 10:52:16 +0100
Message-Id: <e890d9fbee38e26ab4ed330badf46c7e21f06ad6.1639042966.git.linux@leemhuis.info>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1639042966.git.linux@leemhuis.info>
References: <cover.1639042966.git.linux@leemhuis.info>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1639043540;279c6118;
X-HE-SMSGID: 1mvG66-0008GF-6o
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Explain Fixes: and Link: tags in Documentation/process/5.Posting.rst,
which for unknown reasons were not described yet in this file.

Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
---
v2/RFC:
- first version, split off from another patch to make this a preparatory
  patch that can be applied even if the other patch is not
---
 Documentation/process/5.Posting.rst | 29 ++++++++++++++++++++++-------
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/Documentation/process/5.Posting.rst b/Documentation/process/5.Posting.rst
index 855a70b80269..46635310c7c5 100644
--- a/Documentation/process/5.Posting.rst
+++ b/Documentation/process/5.Posting.rst
@@ -197,14 +197,29 @@ the build process, for example, or editor backup files) in the patch.  The
 file "dontdiff" in the Documentation directory can help in this regard;
 pass it to diff with the "-X" option.
 
-The tags mentioned above are used to describe how various developers have
-been associated with the development of this patch.  They are described in
-detail in
-the :ref:`Documentation/process/submitting-patches.rst <submittingpatches>`
-document; what follows here is a brief summary.  Each of these lines has
-the format:
+The tags already briefly mentioned above are used to provide insights how
+the patch came into being. They are described in detail in the
+:ref:`Documentation/process/submitting-patches.rst <submittingpatches>`
+document; what follows here is a brief summary.
 
-::
+One tag is used to refer to earlier commits which had problems fixed by
+the patch::
+
+	Fixes: 1f2e3d4c5b6a ("The first line of the commit specified by the first 12 characters of its SHA-1 ID")
+
+Another tag is used for linking web pages with additional backgrounds or
+details, for example a report about a bug fixed by the patch or a document
+with a specification implemented by the patch::
+
+	Link: https://example.com/somewhere.html  optional-other-stuff
+
+Many maintainers when applying a patch also add this tag to link to the
+latest public review posting of the patch; often this is automatically done
+by tools like b4 or a git hook like the one described in
+'Documentation/maintainer/configure-git.rst'.
+
+A third kind of tags are used to document which developers were involved in
+the development of the patch. Each of these uses this format::
 
 	tag: Full Name <email address>  optional-other-stuff
 
-- 
2.31.1

