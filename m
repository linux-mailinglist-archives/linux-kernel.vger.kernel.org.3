Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AB6A4A59F7
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 11:27:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236515AbiBAK0t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 05:26:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235817AbiBAK0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 05:26:43 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 547F4C06173E;
        Tue,  1 Feb 2022 02:26:43 -0800 (PST)
Received: from ip4d144895.dynamic.kabel-deutschland.de ([77.20.72.149] helo=truhe.fritz.box); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1nEqMz-0002pB-51; Tue, 01 Feb 2022 11:26:41 +0100
From:   Thorsten Leemhuis <linux@leemhuis.info>
To:     linux-doc@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     workflows@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        regressions@lists.linux.dev,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH v4 3/3] docs: reporting-issues.rst: link new document about regressions
Date:   Tue,  1 Feb 2022 11:26:39 +0100
Message-Id: <978ad91647e93b20b7fe12c3f237f6de8f9eaca1.1643710947.git.linux@leemhuis.info>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1643710947.git.linux@leemhuis.info>
References: <cover.1643710947.git.linux@leemhuis.info>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1643711203;661d3094;
X-HE-SMSGID: 1nEqMz-0002pB-51
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make Documentation/admin-guide/reporting-issues.rst point to the newly
created document about regressions
(Documentation/admin-guide/regressions-users.rst). This allows to
shorten a few explanations the new document describes better and in more
detail.

While at it move the copyright hint to the end of the file, as suggested
during review of the new documents about regressions.

Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
---
 .../admin-guide/reporting-issues.rst          | 60 +++++++++----------
 1 file changed, 29 insertions(+), 31 deletions(-)

diff --git a/Documentation/admin-guide/reporting-issues.rst b/Documentation/admin-guide/reporting-issues.rst
index d7ac13f789cc..3122c5a2fb66 100644
--- a/Documentation/admin-guide/reporting-issues.rst
+++ b/Documentation/admin-guide/reporting-issues.rst
@@ -1,14 +1,5 @@
 .. SPDX-License-Identifier: (GPL-2.0+ OR CC-BY-4.0)
-..
-   If you want to distribute this text under CC-BY-4.0 only, please use 'The
-   Linux kernel developers' for author attribution and link this as source:
-   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/plain/Documentation/admin-guide/reporting-issues.rst
-..
-   Note: Only the content of this RST file as found in the Linux kernel sources
-   is available under CC-BY-4.0, as versions of this text that were processed
-   (for example by the kernel's build system) might contain content taken from
-   files which use a more restrictive license.
-
+.. See the bottom of this file for additional redistribution information.
 
 Reporting issues
 ++++++++++++++++
@@ -395,19 +386,13 @@ fixed as soon as possible, hence there are 'issues of high priority' that get
 handled slightly differently in the reporting process. Three type of cases
 qualify: regressions, security issues, and really severe problems.
 
-You deal with a 'regression' if something that worked with an older version of
-the Linux kernel does not work with a newer one or somehow works worse with it.
-It thus is a regression when a WiFi driver that did a fine job with Linux 5.7
-somehow misbehaves with 5.8 or doesn't work at all. It's also a regression if
-an application shows erratic behavior with a newer kernel, which might happen
-due to incompatible changes in the interface between the kernel and the
-userland (like procfs and sysfs). Significantly reduced performance or
-increased power consumption also qualify as regression. But keep in mind: the
-new kernel needs to be built with a configuration that is similar to the one
-from the old kernel (see below how to achieve that). That's because the kernel
-developers sometimes can not avoid incompatibilities when implementing new
-features; but to avoid regressions such features have to be enabled explicitly
-during build time configuration.
+You deal with a regression if some application or practical use case running
+fine with one Linux kernel works worse or not at all with a newer version
+compiled using a similar configuration. The document
+'Documentation/admin-guide/regressions-users.rst' explains this in more detail.
+It also provides a good deal of other information about regressions you might
+want to be aware of; it for example explains how to add your issue to the list
+of tracked regressions, to ensure it won't fall through the cracks.
 
 What qualifies as security issue is left to your judgment. Consider reading
 'Documentation/admin-guide/security-bugs.rst' before proceeding, as it
@@ -1073,10 +1058,10 @@ When dealing with regressions make sure the issue you face is really caused by
 the kernel and not by something else, as outlined above already.
 
 In the whole process keep in mind: an issue only qualifies as regression if the
-older and the newer kernel got built with a similar configuration. The best way
-to archive this: copy the configuration file (``.config``) from the old working
-kernel freshly to each newer kernel version you try. Afterwards run ``make
-olddefconfig`` to adjust it for the needs of the new version.
+older and the newer kernel got built with a similar configuration. This can be
+achieved by using ``make olddefconfig``, as explained in more detail by
+Documentation/admin-guide/regressions-users.rst; that document also provides a
+good deal of other information about regressions you might want to be aware of.
 
 
 Write and send the report
@@ -1756,10 +1741,23 @@ art will lay some groundwork to improve the situation over time.
 
 
 ..
-   This text is maintained by Thorsten Leemhuis <linux@leemhuis.info>. If you
-   spot a typo or small mistake, feel free to let him know directly and he'll
-   fix it. You are free to do the same in a mostly informal way if you want
-   to contribute changes to the text, but for copyright reasons please CC
+   end-of-content
+..
+   This document is maintained by Thorsten Leemhuis <linux@leemhuis.info>. If
+   you spot a typo or small mistake, feel free to let him know directly and
+   he'll fix it. You are free to do the same in a mostly informal way if you
+   want to contribute changes to the text, but for copyright reasons please CC
    linux-doc@vger.kernel.org and "sign-off" your contribution as
    Documentation/process/submitting-patches.rst outlines in the section "Sign
    your work - the Developer's Certificate of Origin".
+..
+   This text is available under GPL-2.0+ or CC-BY-4.0, as stated at the top
+   of the file. If you want to distribute this text under CC-BY-4.0 only,
+   please use "The Linux kernel developers" for author attribution and link
+   this as source:
+   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/plain/Documentation/admin-guide/reporting-issues.rst
+..
+   Note: Only the content of this RST file as found in the Linux kernel sources
+   is available under CC-BY-4.0, as versions of this text that were processed
+   (for example by the kernel's build system) might contain content taken from
+   files which use a more restrictive license.
-- 
2.31.1

