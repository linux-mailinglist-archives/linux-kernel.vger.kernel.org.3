Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3856D484642
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 17:53:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235560AbiADQxj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 11:53:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231665AbiADQxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 11:53:37 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D81CC061761;
        Tue,  4 Jan 2022 08:53:37 -0800 (PST)
Received: from ip4d173d02.dynamic.kabel-deutschland.de ([77.23.61.2] helo=truhe.fritz.box); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1n4n42-0001Kt-Jb; Tue, 04 Jan 2022 17:53:34 +0100
From:   Thorsten Leemhuis <linux@leemhuis.info>
To:     linux-doc@vger.kernel.org
Cc:     workflows@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v2] docs: 5.Posting.rst: describe Fixes: and Link: tags
Date:   Tue,  4 Jan 2022 17:53:33 +0100
Message-Id: <c4a5f5e25fa84b26fd383bba6eafde4ab57c9de7.1641314856.git.linux@leemhuis.info>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1641315217;b804d708;
X-HE-SMSGID: 1n4n42-0001Kt-Jb
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Explain Fixes: and Link: tags in Documentation/process/5.Posting.rst,
which are missing in this file for unknown reasons and only described in
Documentation/process/submitting-patches.rst.

Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
CC: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
---
Lo! If there is still a chance I'd like to get this patch into v5.17, as
during my work as regression tracker I noticed quite a few developers
seem to be unaware how the Link: tag should be used. Maybe in parts
that's because Documentation/process/5.Posting.rst doesn't describe it
yet, which described things from a another different angle than
Documentation/process/submitting-patches.rst.

Ciao, Thorsten

v2:
- A few small fixes and changes as suggested by Randy and Jon (thx!)
  during review

v1:
- First version as stand alone patch. It used to be the first patch of
  this series that got abandoned after RFC/v2:
  https://lore.kernel.org/all/cover.1639042966.git.linux@leemhuis.info/
  Patch itself is unchanged, patch description slightly changed. Might
  later submit other changes from that series separately, too, still
  unsure.
---
 Documentation/process/5.Posting.rst | 29 ++++++++++++++++++++++-------
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/Documentation/process/5.Posting.rst b/Documentation/process/5.Posting.rst
index 855a70b80269..bd36ecb29409 100644
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
+One tag is used to refer to earlier commits which introduced problems fixed by
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
+A third kind of tag is used to document who was involved in the development of
+the patch. Each of these uses this format::
 
 	tag: Full Name <email address>  optional-other-stuff
 

base-commit: b36064425a18e29a3bad9c007b4dd1223f8aadc5
-- 
2.31.1

