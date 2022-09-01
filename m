Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 987FF5AA394
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 01:17:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235089AbiIAXRB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 19:17:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234915AbiIAXQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 19:16:49 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD5D095AE2;
        Thu,  1 Sep 2022 16:16:48 -0700 (PDT)
Received: from meer.lwn.net (unknown [IPv6:2601:281:8300:73::5f6])
        by ms.lwn.net (Postfix) with ESMTPA id 4A7BE77D;
        Thu,  1 Sep 2022 23:16:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 4A7BE77D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1662074208; bh=5FFDPRQHqb/toPn6VxY6WKFENrWTkLzbve5YcQmY7co=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HdII4Mjz762XWuLa6PcKYSR15TqDCyFH51D3zCSCTVd2CA4Ew6IDpc4t7KldFnu5P
         kz2VG+vuzEqdYbmqeAIcPTTrlrGD8jbNa70/dZYVnhMvN/+S7v1/UVay9/omK9nzFI
         taMfk+nb2wEWu5sIlBfS1CG48uSyEuwOfN/0kx4qHYX+eGE6FO4tzTLbTg9MDXpJu/
         SrYhBrXiGUR3Eo3rob2tyR4V2hQDTFTG1/QgCwOWuIIycWblHJgD2H2L0JFoNDHloR
         tsoftUVW3YyZu/xJP4dZ/VgK+1ZidGczGepykCBp3dvyAiL9tRf3doeRWsPqLh+/JJ
         b2g6PFMQEW1tw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 2/4] docs: Rewrite the front page
Date:   Thu,  1 Sep 2022 17:16:30 -0600
Message-Id: <20220901231632.518583-3-corbet@lwn.net>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220901231632.518583-1-corbet@lwn.net>
References: <20220901231632.518583-1-corbet@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The front page is the entry point to the documentation, especially for
people who read it online.  It's a big mess of everything we could think to
toss into it.  Rewrite the page with an eye toward simplicity and making it
easy for readers to get going toward what they really want to find.

This is only a beginning, but it makes our docs more approachable than
before.

Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 Documentation/index.rst          | 151 ++++++++++++-------------------
 Documentation/subsystem-apis.rst |  56 ++++++++++++
 2 files changed, 113 insertions(+), 94 deletions(-)
 create mode 100644 Documentation/subsystem-apis.rst

diff --git a/Documentation/index.rst b/Documentation/index.rst
index 4737c18c97ff..428cfd8e369b 100644
--- a/Documentation/index.rst
+++ b/Documentation/index.rst
@@ -18,14 +18,52 @@ documents into a coherent whole.  Please note that improvements to the
 documentation are welcome; join the linux-doc list at vger.kernel.org if
 you want to help out.
 
-Licensing documentation
------------------------
+Working with the development community
+--------------------------------------
 
-The following describes the license of the Linux kernel source code
-(GPLv2), how to properly mark the license of individual files in the source
-tree, as well as links to the full license text.
+The essential guides for interacting with the kernel's development
+community and getting your work upstream.
+
+.. toctree::
+   :maxdepth: 1
+
+   process/development-process
+   process/submitting-patches
+   Code of conduct <process/code-of-conduct>
+   maintainer/index
+   All development-process docs <process/index>
+
+
+Internal API manuals
+--------------------
+
+Manuals for use by developers working to interface with the rest of the
+kernel.
+
+.. toctree::
+   :maxdepth: 1
+
+   core-api/index
+   driver-api/index
+   subsystem-apis
+   Locking in the kernel <locking/index>
+
+Development tools and processes
+-------------------------------
+
+Various other manuals with useful information for all kernel developers.
+
+.. toctree::
+   :maxdepth: 1
+
+   process/license-rules
+   doc-guide/index
+   dev-tools/index
+   kernel-hacking/index
+   trace/index
+   fault-injection/index
+   livepatch/index
 
-* :ref:`kernel_licensing`
 
 User-oriented documentation
 ---------------------------
@@ -34,21 +72,10 @@ The following manuals are written for *users* of the kernel — those who are
 trying to get it to work optimally on a given system.
 
 .. toctree::
-   :maxdepth: 2
+   :maxdepth: 1
 
    admin-guide/index
-   kbuild/index
-
-Firmware-related documentation
-------------------------------
-The following holds information on the kernel's expectations regarding the
-platform firmwares.
-
-.. toctree::
-   :maxdepth: 2
-
-   firmware-guide/index
-   devicetree/index
+   The kernel build system <kbuild/index>
 
 Application-developer documentation
 -----------------------------------
@@ -57,92 +84,28 @@ The user-space API manual gathers together documents describing aspects of
 the kernel interface as seen by application developers.
 
 .. toctree::
-   :maxdepth: 2
+   :maxdepth: 1
 
    userspace-api/index
 
 
-Introduction to kernel development
-----------------------------------
-
-These manuals contain overall information about how to develop the kernel.
-The kernel community is quite large, with thousands of developers
-contributing over the course of a year.  As with any large community,
-knowing how things are done will make the process of getting your changes
-merged much easier.
+Firmware-related documentation
+------------------------------
+The following holds information on the kernel's expectations regarding the
+platform firmwares.
 
 .. toctree::
-   :maxdepth: 2
+   :maxdepth: 1
 
-   process/index
-   dev-tools/index
-   doc-guide/index
-   kernel-hacking/index
-   trace/index
-   maintainer/index
-   fault-injection/index
-   livepatch/index
-
-
-Kernel API documentation
-------------------------
-
-These books get into the details of how specific kernel subsystems work
-from the point of view of a kernel developer.  Much of the information here
-is taken directly from the kernel source, with supplemental material added
-as needed (or at least as we managed to add it — probably *not* all that is
-needed).
-
-.. toctree::
-   :maxdepth: 2
+   firmware-guide/index
+   devicetree/index
 
-   driver-api/index
-   core-api/index
-   locking/index
-   accounting/index
-   block/index
-   cdrom/index
-   cpu-freq/index
-   fb/index
-   fpga/index
-   hid/index
-   i2c/index
-   iio/index
-   isdn/index
-   infiniband/index
-   leds/index
-   netlabel/index
-   networking/index
-   pcmcia/index
-   power/index
-   target/index
-   timers/index
-   spi/index
-   w1/index
-   watchdog/index
-   virt/index
-   input/index
-   hwmon/index
-   gpu/index
-   security/index
-   sound/index
-   crypto/index
-   filesystems/index
-   mm/index
-   bpf/index
-   usb/index
-   PCI/index
-   scsi/index
-   misc-devices/index
-   scheduler/index
-   mhi/index
-   peci/index
 
 Architecture-agnostic documentation
 -----------------------------------
 
 .. toctree::
-   :maxdepth: 2
+   :maxdepth: 1
 
    asm-annotations
 
@@ -150,7 +113,7 @@ Architecture-specific documentation
 -----------------------------------
 
 .. toctree::
-   :maxdepth: 2
+   :maxdepth: 1
 
    arch
 
@@ -163,7 +126,7 @@ of the documentation body, or may require some adjustments and/or conversion
 to ReStructured Text format, or are simply too old.
 
 .. toctree::
-   :maxdepth: 2
+   :maxdepth: 1
 
    tools/index
    staging/index
diff --git a/Documentation/subsystem-apis.rst b/Documentation/subsystem-apis.rst
new file mode 100644
index 000000000000..f5d8bcc023c8
--- /dev/null
+++ b/Documentation/subsystem-apis.rst
@@ -0,0 +1,56 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==================================
+Kernel subsystem API documentation
+==================================
+
+These books get into the details of how specific kernel subsystems work
+from the point of view of a kernel developer.  Much of the information here
+is taken directly from the kernel source, with supplemental material added
+as needed (or at least as we managed to add it — probably *not* all that is
+needed).
+
+.. toctree::
+   :maxdepth: 1
+
+   driver-api/index
+   core-api/index
+   locking/index
+   accounting/index
+   block/index
+   cdrom/index
+   cpu-freq/index
+   fb/index
+   fpga/index
+   hid/index
+   i2c/index
+   iio/index
+   isdn/index
+   infiniband/index
+   leds/index
+   netlabel/index
+   networking/index
+   pcmcia/index
+   power/index
+   target/index
+   timers/index
+   spi/index
+   w1/index
+   watchdog/index
+   virt/index
+   input/index
+   hwmon/index
+   gpu/index
+   security/index
+   sound/index
+   crypto/index
+   filesystems/index
+   mm/index
+   bpf/index
+   usb/index
+   PCI/index
+   scsi/index
+   misc-devices/index
+   scheduler/index
+   mhi/index
+   peci/index
-- 
2.37.2

