Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7CC14B81BD
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 08:42:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbiBPHhJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 02:37:09 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:43862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbiBPHhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 02:37:07 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8587F172884;
        Tue, 15 Feb 2022 23:36:17 -0800 (PST)
Received: from ip4d144895.dynamic.kabel-deutschland.de ([77.20.72.149] helo=truhe.fritz.box); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1nKEA6-00083j-Mr; Wed, 16 Feb 2022 07:51:38 +0100
From:   Thorsten Leemhuis <linux@leemhuis.info>
To:     linux-doc@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     workflows@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        regressions@lists.linux.dev,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH v5 3/3] docs: reporting-issues.rst: link new document about regressions
Date:   Wed, 16 Feb 2022 07:51:35 +0100
Message-Id: <f20114eaddc356a8c79dd62812a6c7f4ca5d87b9.1644994117.git.linux@leemhuis.info>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1644994117.git.linux@leemhuis.info>
References: <cover.1644994117.git.linux@leemhuis.info>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1644996977;2c8732e0;
X-HE-SMSGID: 1nKEA6-00083j-Mr
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make Documentation/admin-guide/reporting-issues.rst point to the newly
created document about regressions
(Documentation/admin-guide/regressions-regressions.rst). This allows to
shorten a few explanations the new document describes better and in more
detail.

While at it move the copyright hint to the end of the file and remove
quotes around links to other places in the documentation. Both issues
came up during the review of the new documents about regressions.

Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
---
 .../admin-guide/reporting-issues.rst          | 73 +++++++++----------
 1 file changed, 36 insertions(+), 37 deletions(-)

diff --git a/Documentation/admin-guide/reporting-issues.rst b/Documentation/admin-guide/reporting-issues.rst
index d7ac13f789cc..ec62151fe672 100644
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
@@ -395,22 +386,16 @@ fixed as soon as possible, hence there are 'issues of high priority' that get
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
+Documentation/admin-guide/reporting-regressions.rst explains this in more
+detail. It also provides a good deal of other information about regressions you
+might want to be aware of; it for example explains how to add your issue to the
+list of tracked regressions, to ensure it won't fall through the cracks.
 
 What qualifies as security issue is left to your judgment. Consider reading
-'Documentation/admin-guide/security-bugs.rst' before proceeding, as it
+Documentation/admin-guide/security-bugs.rst before proceeding, as it
 provides additional details how to best handle security issues.
 
 An issue is a 'really severe problem' when something totally unacceptably bad
@@ -517,7 +502,7 @@ line starting with 'CPU:'. It should end with 'Not tainted' if the kernel was
 not tainted when it noticed the problem; it was tainted if you see 'Tainted:'
 followed by a few spaces and some letters.
 
-If your kernel is tainted, study 'Documentation/admin-guide/tainted-kernels.rst'
+If your kernel is tainted, study Documentation/admin-guide/tainted-kernels.rst
 to find out why. Try to eliminate the reason. Often it's caused by one these
 three things:
 
@@ -1043,7 +1028,7 @@ down the culprit, as maintainers often won't have the time or setup at hand to
 reproduce it themselves.
 
 To find the change there is a process called 'bisection' which the document
-'Documentation/admin-guide/bug-bisect.rst' describes in detail. That process
+Documentation/admin-guide/bug-bisect.rst describes in detail. That process
 will often require you to build about ten to twenty kernel images, trying to
 reproduce the issue with each of them before building the next. Yes, that takes
 some time, but don't worry, it works a lot quicker than most people assume.
@@ -1073,10 +1058,11 @@ When dealing with regressions make sure the issue you face is really caused by
 the kernel and not by something else, as outlined above already.
 
 In the whole process keep in mind: an issue only qualifies as regression if the
-older and the newer kernel got built with a similar configuration. The best way
-to archive this: copy the configuration file (``.config``) from the old working
-kernel freshly to each newer kernel version you try. Afterwards run ``make
-olddefconfig`` to adjust it for the needs of the new version.
+older and the newer kernel got built with a similar configuration. This can be
+achieved by using ``make olddefconfig``, as explained in more detail by
+Documentation/admin-guide/reporting-regressions.rst; that document also
+provides a good deal of other information about regressions you might want to be
+aware of.
 
 
 Write and send the report
@@ -1283,7 +1269,7 @@ them when sending the report by mail. If you filed it in a bug tracker, forward
 the report's text to these addresses; but on top of it put a small note where
 you mention that you filed it with a link to the ticket.
 
-See 'Documentation/admin-guide/security-bugs.rst' for more information.
+See Documentation/admin-guide/security-bugs.rst for more information.
 
 
 Duties after the report went out
@@ -1571,7 +1557,7 @@ Once your report is out your might get asked to do a proper one, as it allows to
 pinpoint the exact change that causes the issue (which then can easily get
 reverted to fix the issue quickly). Hence consider to do a proper bisection
 right away if time permits. See the section 'Special care for regressions' and
-the document 'Documentation/admin-guide/bug-bisect.rst' for details how to
+the document Documentation/admin-guide/bug-bisect.rst for details how to
 perform one. In case of a successful bisection add the author of the culprit to
 the recipients; also CC everyone in the signed-off-by chain, which you find at
 the end of its commit message.
@@ -1594,7 +1580,7 @@ Some fixes are too complex
 Even small and seemingly obvious code-changes sometimes introduce new and
 totally unexpected problems. The maintainers of the stable and longterm kernels
 are very aware of that and thus only apply changes to these kernels that are
-within rules outlined in 'Documentation/process/stable-kernel-rules.rst'.
+within rules outlined in Documentation/process/stable-kernel-rules.rst.
 
 Complex or risky changes for example do not qualify and thus only get applied
 to mainline. Other fixes are easy to get backported to the newest stable and
@@ -1756,10 +1742,23 @@ art will lay some groundwork to improve the situation over time.
 
 
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
2.35.1

