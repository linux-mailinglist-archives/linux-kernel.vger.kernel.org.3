Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61AAC53D290
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 21:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347572AbiFCT5v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 15:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238980AbiFCT5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 15:57:42 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D406B1EC5D
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 12:57:40 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-30cb80ee75cso75875927b3.15
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jun 2022 12:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=XOcU1//GuqjLCtdoE1D8IV5nEd33D0c7tJ+gwQbad5E=;
        b=e6fEYDUo91OoVPaX5ty5UCXrN58DvWM9t7/8GzQl3mH2ONxFqrr5H+7STpTjvyqtFx
         6l6aI6xHKjMwhWhklpVT4Myh1bx4KLAdLmL+d0eGCwkXIhedVL0Iz6nLoOHe9idzibk+
         G3mrBED1R6NA7H7EG1S+OoPklF2EOpNvl5/NWzwJ+C1AVsEAGZoc+LkdpTD2CSBiI7SY
         rbuvMjPsxbMItMUgK1d2e+KNmnau5CkuRf828tdvK0esK2Thltgw2fPumX9RLGdmB1iB
         2hz5soTr57eapiLGOCZ0S+ECn8+tjmBHEw/Ffd3d3bajJlAbRsT0GJc+9+cKmvyT8TOZ
         2N1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=XOcU1//GuqjLCtdoE1D8IV5nEd33D0c7tJ+gwQbad5E=;
        b=rKK3Ze/OFG21AdRNCMYNQML/2dhEJrUkeb5OagaWWKkZFKyGD8/GKpoW1WQ3euFHTt
         /6wsS8pK/QoYsQSf59kCXWLnAsqVLG9bYJ9/NFwTJXQUGwDWlHS8cmTfFRfMvV5XnPRC
         IsCKi8ACEHawOau62XbL0VX+5WQMJShA8BrlBgx58t2e7PCjPrxnNQabHGCrCTE/X9gs
         QHCYnVFSaWPvMspvaJlJiz6xOSJo5XWBcqQh+qOT0gjhuK9WnU9g30RGPaqs58/7D1eU
         SL4NZIQiI42P8DxqPd2Z56yixnvhNeqX+dhtnaaMdBYiWtcBWnXpidRo+krUWp/b2mvZ
         uSRw==
X-Gm-Message-State: AOAM531Wi1Vfb+/3hDzJSGPNFYdfH3DzzBkpS/68o4rXPwawETPd+Bu+
        kIoDcu5wxidwNobhKvjhUkYeUFNjzSKfXQ==
X-Google-Smtp-Source: ABdhPJzuiTn4XgRuAYazTdIGWPdwdlHGxDZCpDrrlzUfFEYNoWmmHQXxDCKF6Av//PPoNYqYwc+PYfc8U1jFHw==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:9ff0:c6ec:46df:8f8a])
 (user=dlatypov job=sendgmr) by 2002:a25:1b06:0:b0:65d:4d94:452a with SMTP id
 b6-20020a251b06000000b0065d4d94452amr12747326ybb.96.1654286260040; Fri, 03
 Jun 2022 12:57:40 -0700 (PDT)
Date:   Fri,  3 Jun 2022 12:56:24 -0700
Message-Id: <20220603195626.121922-1-dlatypov@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
Subject: [PATCH 1/3] Documentation: kunit: remove duplicate kunit-tool.rst
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        corbet@lwn.net, linux-doc@vger.kernel.org,
        Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The information is duplicated now in run_wrapper.rst, which was added in
commit 46201d47d6c4 ("Documentation: kunit: Reorganize documentation
related to running tests").

You cna compare these pages here:
https://www.kernel.org/doc/html/v5.18/dev-tools/kunit/run_wrapper.html
https://www.kernel.org/doc/html/v5.18/dev-tools/kunit/kunit-tool.html

We should have deleted it in then but it got overlooked.

Signed-off-by: Daniel Latypov <dlatypov@google.com>
---
 Documentation/dev-tools/kunit/index.rst      |   3 -
 Documentation/dev-tools/kunit/kunit-tool.rst | 232 -------------------
 Documentation/dev-tools/kunit/start.rst      |   2 -
 3 files changed, 237 deletions(-)
 delete mode 100644 Documentation/dev-tools/kunit/kunit-tool.rst

diff --git a/Documentation/dev-tools/kunit/index.rst b/Documentation/dev-tools/kunit/index.rst
index 595205348d2d..84a87c57c7e8 100644
--- a/Documentation/dev-tools/kunit/index.rst
+++ b/Documentation/dev-tools/kunit/index.rst
@@ -13,7 +13,6 @@ KUnit - Linux Kernel Unit Testing
 	run_wrapper
 	run_manual
 	usage
-	kunit-tool
 	api/index
 	style
 	faq
@@ -107,7 +106,5 @@ How do I use it?
     examples.
 *   Documentation/dev-tools/kunit/api/index.rst - KUnit APIs
     used for testing.
-*   Documentation/dev-tools/kunit/kunit-tool.rst - kunit_tool helper
-    script.
 *   Documentation/dev-tools/kunit/faq.rst - KUnit common questions and
     answers.
diff --git a/Documentation/dev-tools/kunit/kunit-tool.rst b/Documentation/dev-tools/kunit/kunit-tool.rst
deleted file mode 100644
index ae52e0f489f9..000000000000
--- a/Documentation/dev-tools/kunit/kunit-tool.rst
+++ /dev/null
@@ -1,232 +0,0 @@
-.. SPDX-License-Identifier: GPL-2.0
-
-=================
-kunit_tool How-To
-=================
-
-What is kunit_tool?
-===================
-
-kunit_tool is a script (``tools/testing/kunit/kunit.py``) that aids in building
-the Linux kernel as UML (`User Mode Linux
-<http://user-mode-linux.sourceforge.net/>`_), running KUnit tests, parsing
-the test results and displaying them in a user friendly manner.
-
-kunit_tool addresses the problem of being able to run tests without needing a
-virtual machine or actual hardware with User Mode Linux. User Mode Linux is a
-Linux architecture, like ARM or x86; however, unlike other architectures it
-compiles the kernel as a standalone Linux executable that can be run like any
-other program directly inside of a host operating system. To be clear, it does
-not require any virtualization support: it is just a regular program.
-
-What is a .kunitconfig?
-=======================
-
-It's just a defconfig that kunit_tool looks for in the build directory
-(``.kunit`` by default).  kunit_tool uses it to generate a .config as you might
-expect. In addition, it verifies that the generated .config contains the CONFIG
-options in the .kunitconfig; the reason it does this is so that it is easy to
-be sure that a CONFIG that enables a test actually ends up in the .config.
-
-It's also possible to pass a separate .kunitconfig fragment to kunit_tool,
-which is useful if you have several different groups of tests you wish
-to run independently, or if you want to use pre-defined test configs for
-certain subsystems.
-
-Getting Started with kunit_tool
-===============================
-
-If a kunitconfig is present at the root directory, all you have to do is:
-
-.. code-block:: bash
-
-	./tools/testing/kunit/kunit.py run
-
-However, you most likely want to use it with the following options:
-
-.. code-block:: bash
-
-	./tools/testing/kunit/kunit.py run --timeout=30 --jobs=`nproc --all`
-
-- ``--timeout`` sets a maximum amount of time to allow tests to run.
-- ``--jobs`` sets the number of threads to use to build the kernel.
-
-.. note::
-	This command will work even without a .kunitconfig file: if no
-	.kunitconfig is present, a default one will be used instead.
-
-If you wish to use a different .kunitconfig file (such as one provided for
-testing a particular subsystem), you can pass it as an option.
-
-.. code-block:: bash
-
-	./tools/testing/kunit/kunit.py run --kunitconfig=fs/ext4/.kunitconfig
-
-For a list of all the flags supported by kunit_tool, you can run:
-
-.. code-block:: bash
-
-	./tools/testing/kunit/kunit.py run --help
-
-Configuring, Building, and Running Tests
-========================================
-
-It's also possible to run just parts of the KUnit build process independently,
-which is useful if you want to make manual changes to part of the process.
-
-A .config can be generated from a .kunitconfig by using the ``config`` argument
-when running kunit_tool:
-
-.. code-block:: bash
-
-	./tools/testing/kunit/kunit.py config
-
-Similarly, if you just want to build a KUnit kernel from the current .config,
-you can use the ``build`` argument:
-
-.. code-block:: bash
-
-	./tools/testing/kunit/kunit.py build
-
-And, if you already have a built UML kernel with built-in KUnit tests, you can
-run the kernel and display the test results with the ``exec`` argument:
-
-.. code-block:: bash
-
-	./tools/testing/kunit/kunit.py exec
-
-The ``run`` command which is discussed above is equivalent to running all three
-of these in sequence.
-
-All of these commands accept a number of optional command-line arguments. The
-``--help`` flag will give a complete list of these, or keep reading this page
-for a guide to some of the more useful ones.
-
-Parsing Test Results
-====================
-
-KUnit tests output their results in TAP (Test Anything Protocol) format.
-kunit_tool will, when running tests, parse this output and print a summary
-which is much more pleasant to read. If you wish to look at the raw test
-results in TAP format, you can pass the ``--raw_output`` argument.
-
-.. code-block:: bash
-
-	./tools/testing/kunit/kunit.py run --raw_output
-
-The raw output from test runs may contain other, non-KUnit kernel log
-lines. You can see just KUnit output with ``--raw_output=kunit``:
-
-.. code-block:: bash
-
-	./tools/testing/kunit/kunit.py run --raw_output=kunit
-
-If you have KUnit results in their raw TAP format, you can parse them and print
-the human-readable summary with the ``parse`` command for kunit_tool. This
-accepts a filename for an argument, or will read from standard input.
-
-.. code-block:: bash
-
-	# Reading from a file
-	./tools/testing/kunit/kunit.py parse /var/log/dmesg
-	# Reading from stdin
-	dmesg | ./tools/testing/kunit/kunit.py parse
-
-This is very useful if you wish to run tests in a configuration not supported
-by kunit_tool (such as on real hardware, or an unsupported architecture).
-
-Filtering Tests
-===============
-
-It's possible to run only a subset of the tests built into a kernel by passing
-a filter to the ``exec`` or ``run`` commands. For example, if you only wanted
-to run KUnit resource tests, you could use:
-
-.. code-block:: bash
-
-	./tools/testing/kunit/kunit.py run 'kunit-resource*'
-
-This uses the standard glob format for wildcards.
-
-Running Tests on QEMU
-=====================
-
-kunit_tool supports running tests on QEMU as well as via UML (as mentioned
-elsewhere). The default way of running tests on QEMU requires two flags:
-
-``--arch``
-	Selects a collection of configs (Kconfig as well as QEMU configs
-	options, etc) that allow KUnit tests to be run on the specified
-	architecture in a minimal way; this is usually not much slower than
-	using UML. The architecture argument is the same as the name of the
-	option passed to the ``ARCH`` variable used by Kbuild. Not all
-	architectures are currently supported by this flag, but can be handled
-	by the ``--qemu_config`` discussed later. If ``um`` is passed (or this
-	this flag is ignored) the tests will run via UML. Non-UML architectures,
-	e.g. i386, x86_64, arm, um, etc. Non-UML run on QEMU.
-
-``--cross_compile``
-	Specifies the use of a toolchain by Kbuild. The argument passed here is
-	the same passed to the ``CROSS_COMPILE`` variable used by Kbuild. As a
-	reminder this will be the prefix for the toolchain binaries such as gcc
-	for example ``sparc64-linux-gnu-`` if you have the sparc toolchain
-	installed on your system, or
-	``$HOME/toolchains/microblaze/gcc-9.2.0-nolibc/microblaze-linux/bin/microblaze-linux-``
-	if you have downloaded the microblaze toolchain from the 0-day website
-	to a directory in your home directory called ``toolchains``.
-
-In many cases it is likely that you may want to run an architecture which is
-not supported by the ``--arch`` flag, or you may want to just run KUnit tests
-on QEMU using a non-default configuration. For this use case, you can write
-your own QemuConfig. These QemuConfigs are written in Python. They must have an
-import line ``from ..qemu_config import QemuArchParams`` at the top of the file
-and the file must contain a variable called ``QEMU_ARCH`` that has an instance
-of ``QemuArchParams`` assigned to it. An example can be seen in
-``tools/testing/kunit/qemu_configs/x86_64.py``.
-
-Once you have a QemuConfig you can pass it into kunit_tool using the
-``--qemu_config`` flag; when used this flag replaces the ``--arch`` flag. If we
-were to do this with the ``x86_64.py`` example from above, the invocation would
-look something like this:
-
-.. code-block:: bash
-
-	./tools/testing/kunit/kunit.py run \
-		--timeout=60 \
-		--jobs=12 \
-		--qemu_config=./tools/testing/kunit/qemu_configs/x86_64.py
-
-Other Useful Options
-====================
-
-kunit_tool has a number of other command-line arguments which can be useful
-when adapting it to fit your environment or needs.
-
-Some of the more useful ones are:
-
-``--help``
-	Lists all of the available options. Note that different commands
-	(``config``, ``build``, ``run``, etc) will have different supported
-	options. Place ``--help`` before the command to list common options,
-	and after the command for options specific to that command.
-
-``--build_dir``
-	Specifies the build directory that kunit_tool will use. This is where
-	the .kunitconfig file is located, as well as where the .config and
-	compiled kernel will be placed. Defaults to ``.kunit``.
-
-``--make_options``
-	Specifies additional options to pass to ``make`` when compiling a
-	kernel (with the ``build`` or ``run`` commands). For example, to enable
-	compiler warnings, you can pass ``--make_options W=1``.
-
-``--alltests``
-        Builds a UML kernel with all config options enabled using ``make
-        allyesconfig``. This allows you to run as many tests as is possible,
-        but is very slow and prone to breakage as new options are added or
-        modified. In most cases, enabling all tests which have satisfied
-        dependencies by adding ``CONFIG_KUNIT_ALL_TESTS=1`` to your
-        .kunitconfig is preferable.
-
-There are several other options (and new ones are often added), so do check
-``--help`` if you're looking for something not mentioned here.
diff --git a/Documentation/dev-tools/kunit/start.rst b/Documentation/dev-tools/kunit/start.rst
index 867a4bba6bf6..e730df1f468e 100644
--- a/Documentation/dev-tools/kunit/start.rst
+++ b/Documentation/dev-tools/kunit/start.rst
@@ -254,7 +254,5 @@ Next Steps
     examples.
 *   Documentation/dev-tools/kunit/api/index.rst - KUnit APIs
     used for testing.
-*   Documentation/dev-tools/kunit/kunit-tool.rst - kunit_tool helper
-    script.
 *   Documentation/dev-tools/kunit/faq.rst - KUnit common questions and
     answers.

base-commit: 50fd82b3a9a9335df5d50c7ddcb81c81d358c4fc
-- 
2.36.1.255.ge46751e96f-goog

