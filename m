Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82400531C88
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 22:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243906AbiEWSko (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 14:40:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243919AbiEWSk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 14:40:28 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EBBF17EC3B
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 11:22:05 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id o190so16150306iof.10
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 11:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language;
        bh=zbQxoeXWfdDf9tLJXo2v8qsAqrlqF8vUFNLDZmhXvw4=;
        b=TkN20OvVwDk6IVxvSj97kgUMpcIuMEdlHaIJsbscilr17bsyM2Z8w0e+AB71q63/0D
         HbT+ihU79B1/h3Zt3J4Cuu5ZRRkdsk/l5GIOP7q29kkIW+Oxmrgomhv1WAmC8LdCQ0aX
         qHKnOttcv2wGDNC2Qnr04jejOCOuvK3GdKZag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language;
        bh=zbQxoeXWfdDf9tLJXo2v8qsAqrlqF8vUFNLDZmhXvw4=;
        b=gkIVdlQ7dT8Ym6cXXtOjPG5Bxl6oPd8xx4HoKEXlbm9Bny77jg0qkfXe26o70hsjvs
         Uli2hBILm7Jj3x817pVlhdEdu5G3eJdYVVrMpqCyt0bLsAS0m4Bq12ngsmx30vbeNO0I
         3zd449ZJpqipknvl60pf1IxcdN6VKMNE9U5CSl2SoQ2gL3o0eot5x3A2XZBzN5zHhuxQ
         3vZ+rYg0Y6TcIct9Il6X+qG5KGYAIicbBtCd1xfE88Z7FONjbyyFG7/ssiarVHA+afXF
         2Czxzx+zybw5aI0oi68ejrQZhmGeb6HSonPj97DWgw7GRV8Y4fmF2UISWFZzze1qPCQI
         lg+w==
X-Gm-Message-State: AOAM533KppdNMvhmdSwof0GaAXzgJFm680EH8LgUu1xspUFtvc3Z/2dE
        OOHIF0BkS9X3Z4SbU0G8rcrMJ/Qxq4eF/g==
X-Google-Smtp-Source: ABdhPJxl2lAzhTDPRg1Twjm4sZFh6AG+hmcXoLGlZS6X23eJ2eP9ZH3eSochPQmhg38bqr+ykBkmNQ==
X-Received: by 2002:a05:6638:2496:b0:32b:7c1b:b523 with SMTP id x22-20020a056638249600b0032b7c1bb523mr12001309jat.198.1653330089047;
        Mon, 23 May 2022 11:21:29 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id j5-20020a02cc65000000b0032ebaebb4d2sm1600838jaq.50.2022.05.23.11.21.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 May 2022 11:21:28 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] KUnit update for Linux 5.19-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        shuah <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Message-ID: <76e8af6c-9757-4367-1407-84fbad96cc8d@linuxfoundation.org>
Date:   Mon, 23 May 2022 12:21:27 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------D6FDE8FDC8613DE24C877C71"
Content-Language: en-US
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------D6FDE8FDC8613DE24C877C71
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Linus,

Please pull the following KUnit update for Linux 5.19-rc1.

This KUnit update for Linux 5.19-rc1 consists of several fixes, cleanups,
and enhancements to tests and framework:

- introduces _NULL and _NOT_NULL macros to pointer error checks

- reworks kunit_resource allocation policy to fix memory leaks when
   caller doesn't specify free() function to be used when allocating
   memory using kunit_add_resource() and kunit_alloc_resource() funcs.

- adds ability to specify suite-level init and exit functions

diff is attached.

thanks,
-- Shuah

----------------------------------------------------------------
The following changes since commit 3123109284176b1532874591f7c81f3837bbdc17:

   Linux 5.18-rc1 (2022-04-03 14:08:21 -0700)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-kunit-5.19-rc1

for you to fetch changes up to e7eaffce47b7db72b077630dbe836f0c4132496d:

   kunit: tool: Use qemu-system-i386 for i386 runs (2022-05-18 17:03:54 -0600)

----------------------------------------------------------------
linux-kselftest-kunit-5.19-rc1

This KUnit update for Linux 5.19-rc1 consists of several fixes, cleanups,
and enhancements to tests and framework:

- introduces _NULL and _NOT_NULL macros to pointer error checks

- reworks kunit_resource allocation policy to fix memory leaks when
   caller doesn't specify free() function to be used when allocating
   memory using kunit_add_resource() and kunit_alloc_resource() funcs.

- adds ability to specify suite-level init and exit functions

----------------------------------------------------------------
Brendan Higgins (2):
       kunit: add support for kunit_suites that reference init code
       kunit: tool: update riscv QEMU config with new serial dependency

Daniel Latypov (25):
       kunit: tool: make --json handling a bit clearer
       kunit: tool: drop unused KernelDirectoryPath var
       kunit: tool: drop last uses of collections.namedtuple
       kunit: tool: simplify code since build_dir can't be None
       kunit: tool: readability tweaks in KernelCI json generation logic
       kunit: tool: refactor how we plumb metadata into JSON
       kunit: tool: properly report the used arch for --json, or '' if not known
       kunit: tool: more descriptive metavars/--help output
       kunit: split resource API from test.h into new resource.h
       kunit: split resource API impl from test.c into new resource.c
       Documentation: kunit: update kconfig options needed for UML coverage
       kunit: rename print_subtest_{start,end} for clarity (s/subtest/suite)
       kunit: add ability to specify suite-level init and exit functions
       kfence: test: use new suite_{init/exit} support, add .kunitconfig
       kunit: fix debugfs code to use enum kunit_status, not bool
       lib/Kconfig.debug: change KUnit tests to default to KUNIT_ALL_TESTS
       kunit: bail out of test filtering logic quicker if OOM
       kunit: tool: update test counts summary line format
       kunit: tool: stop using a shell to run kernel under QEMU
       kunit: tool: print clearer error message when there's no TAP output
       kunit: tool: remove dead parse_crash_in_log() logic
       kunit: tool: make parser stop overwriting status of suites w/ no_tests
       kunit: tool: minor cosmetic cleanups in kunit_parser.py
       kunit: tool: misc cleanups
       kunit: fix executor OOM error handling logic on non-UML

David Gow (5):
       list: test: Test the hlist structure
       kunit: Make kunit_remove_resource() idempotent
       kunit: Rework kunit_resource allocation policy
       kunit: tool: Add list of all valid test configs on UML
       kunit: tool: Use qemu-system-i386 for i386 runs

Kees Cook (1):
       kunit: tool: Do not colorize output when redirected

Marco Elver (1):
       kcsan: test: use new suite_{init,exit} support

Miguel Ojeda (1):
       kunit: take `kunit_assert` as `const`

Ricardo Ribalda (6):
       kunit: Introduce _NULL and _NOT_NULL macros
       kunit: use NULL macros
       thunderbolt: test: use NULL macros
       kasan: test: Use NULL macros
       mctp: test: Use NULL macros
       apparmor: test: Use NULL macros


  Documentation/dev-tools/kunit/api/index.rst        |   5 +
  Documentation/dev-tools/kunit/api/resource.rst     |  13 +
  Documentation/dev-tools/kunit/running_tips.rst     |   3 +-
  Documentation/dev-tools/kunit/usage.rst            |  19 +-
  drivers/thunderbolt/test.c                         | 134 +++----
  include/kunit/resource.h                           | 406 ++++++++++++++++++++
  include/kunit/test.h                               | 418 ++++++---------------
  kernel/kcsan/kcsan_test.c                          |  31 +-
  lib/Kconfig.debug                                  |  15 +-
  lib/kunit/Makefile                                 |   1 +
  lib/kunit/debugfs.c                                |   2 +-
  lib/kunit/executor.c                               |  32 +-
  lib/kunit/executor_test.c                          |   4 +-
  lib/kunit/kunit-example-test.c                     |  16 +
  lib/kunit/kunit-test.c                             |  37 +-
  lib/kunit/resource.c                               |  79 ++++
  lib/kunit/test.c                                   | 145 ++-----
  lib/list-test.c                                    | 397 ++++++++++++++++++-
  lib/test_kasan.c                                   |   2 +-
  mm/kfence/.kunitconfig                             |   6 +
  mm/kfence/kfence_test.c                            |  31 +-
  net/mctp/test/route-test.c                         |   4 +-
  security/apparmor/policy_unpack_test.c             |   6 +-
  tools/testing/kunit/configs/all_tests_uml.config   |  37 ++
  tools/testing/kunit/kunit.py                       |  63 ++--
  tools/testing/kunit/kunit_config.py                |  21 +-
  tools/testing/kunit/kunit_json.py                  |  66 ++--
  tools/testing/kunit/kunit_kernel.py                |  81 ++--
  tools/testing/kunit/kunit_parser.py                | 154 +++-----
  tools/testing/kunit/kunit_tool_test.py             |  44 +--
  tools/testing/kunit/qemu_config.py                 |  17 +-
  tools/testing/kunit/qemu_configs/alpha.py          |   2 +-
  tools/testing/kunit/qemu_configs/arm.py            |   2 +-
  tools/testing/kunit/qemu_configs/arm64.py          |   2 +-
  tools/testing/kunit/qemu_configs/i386.py           |   4 +-
  tools/testing/kunit/qemu_configs/powerpc.py        |   2 +-
  tools/testing/kunit/qemu_configs/riscv.py          |   7 +-
  tools/testing/kunit/qemu_configs/s390.py           |   4 +-
  tools/testing/kunit/qemu_configs/sparc.py          |   2 +-
  tools/testing/kunit/qemu_configs/x86_64.py         |   2 +-
  tools/testing/kunit/run_checks.py                  |   2 +-
  .../kunit/test_data/test_is_test_passed-crash.log  |  70 ----
  .../test_is_test_passed-no_tests_no_plan.log       |   2 +-
  43 files changed, 1499 insertions(+), 891 deletions(-)
  create mode 100644 Documentation/dev-tools/kunit/api/resource.rst
  create mode 100644 include/kunit/resource.h
  create mode 100644 lib/kunit/resource.c
  create mode 100644 mm/kfence/.kunitconfig
  create mode 100644 tools/testing/kunit/configs/all_tests_uml.config
  delete mode 100644 tools/testing/kunit/test_data/test_is_test_passed-crash.log
----------------------------------------------------------------

--------------D6FDE8FDC8613DE24C877C71
Content-Type: text/x-patch; charset=UTF-8;
 name="linux-kselftest-kunit-5.19-rc1.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="linux-kselftest-kunit-5.19-rc1.diff"

diff --git a/Documentation/dev-tools/kunit/api/index.rst b/Documentation/dev-tools/kunit/api/index.rst
index 3006cadcf44a..45ce04823f9f 100644
--- a/Documentation/dev-tools/kunit/api/index.rst
+++ b/Documentation/dev-tools/kunit/api/index.rst
@@ -6,6 +6,7 @@ API Reference
 .. toctree::
 
 	test
+	resource
 
 This section documents the KUnit kernel testing API. It is divided into the
 following sections:
@@ -13,3 +14,7 @@ following sections:
 Documentation/dev-tools/kunit/api/test.rst
 
  - documents all of the standard testing API
+
+Documentation/dev-tools/kunit/api/resource.rst
+
+ - documents the KUnit resource API
diff --git a/Documentation/dev-tools/kunit/api/resource.rst b/Documentation/dev-tools/kunit/api/resource.rst
new file mode 100644
index 000000000000..0a94f831259e
--- /dev/null
+++ b/Documentation/dev-tools/kunit/api/resource.rst
@@ -0,0 +1,13 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+============
+Resource API
+============
+
+This file documents the KUnit resource API.
+
+Most users won't need to use this API directly, power users can use it to store
+state on a per-test basis, register custom cleanup actions, and more.
+
+.. kernel-doc:: include/kunit/resource.h
+   :internal:
diff --git a/Documentation/dev-tools/kunit/running_tips.rst b/Documentation/dev-tools/kunit/running_tips.rst
index 7b6d26a25959..c36f6760087d 100644
--- a/Documentation/dev-tools/kunit/running_tips.rst
+++ b/Documentation/dev-tools/kunit/running_tips.rst
@@ -114,6 +114,7 @@ Instead of enabling ``CONFIG_GCOV_KERNEL=y``, we can set these options:
 
 	CONFIG_DEBUG_KERNEL=y
 	CONFIG_DEBUG_INFO=y
+	CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
 	CONFIG_GCOV=y
 
 
@@ -122,7 +123,7 @@ Putting it together into a copy-pastable sequence of commands:
 .. code-block:: bash
 
 	# Append coverage options to the current config
-	$ echo -e "CONFIG_DEBUG_KERNEL=y\nCONFIG_DEBUG_INFO=y\nCONFIG_GCOV=y" >> .kunit/.kunitconfig
+	$ echo -e "CONFIG_DEBUG_KERNEL=y\nCONFIG_DEBUG_INFO=y\nCONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y\nCONFIG_GCOV=y" >> .kunit/.kunitconfig
 	$ ./tools/testing/kunit/kunit.py run
 	# Extract the coverage information from the build dir (.kunit/)
 	$ lcov -t "my_kunit_tests" -o coverage.info -c -d .kunit/
diff --git a/Documentation/dev-tools/kunit/usage.rst b/Documentation/dev-tools/kunit/usage.rst
index 1c83e7d60a8a..d62a04255c2e 100644
--- a/Documentation/dev-tools/kunit/usage.rst
+++ b/Documentation/dev-tools/kunit/usage.rst
@@ -125,8 +125,8 @@ We need many test cases covering all the unit's behaviors. It is common to have
 many similar tests. In order to reduce duplication in these closely related
 tests, most unit testing frameworks (including KUnit) provide the concept of a
 *test suite*. A test suite is a collection of test cases for a unit of code
-with a setup function that gets invoked before every test case and then a tear
-down function that gets invoked after every test case completes. For example:
+with optional setup and teardown functions that run before/after the whole
+suite and/or every test case. For example:
 
 .. code-block:: c
 
@@ -141,16 +141,19 @@ down function that gets invoked after every test case completes. For example:
 		.name = "example",
 		.init = example_test_init,
 		.exit = example_test_exit,
+		.suite_init = example_suite_init,
+		.suite_exit = example_suite_exit,
 		.test_cases = example_test_cases,
 	};
 	kunit_test_suite(example_test_suite);
 
-In the above example, the test suite ``example_test_suite`` would run the test
-cases ``example_test_foo``, ``example_test_bar``, and ``example_test_baz``. Each
-would have ``example_test_init`` called immediately before it and
-``example_test_exit`` called immediately after it.
-``kunit_test_suite(example_test_suite)`` registers the test suite with the
-KUnit test framework.
+In the above example, the test suite ``example_test_suite`` would first run
+``example_suite_init``, then run the test cases ``example_test_foo``,
+``example_test_bar``, and ``example_test_baz``. Each would have
+``example_test_init`` called immediately before it and ``example_test_exit``
+called immediately after it. Finally, ``example_suite_exit`` would be called
+after everything else. ``kunit_test_suite(example_test_suite)`` registers the
+test suite with the KUnit test framework.
 
 .. note::
    A test case will only run if it is associated with a test suite.
diff --git a/drivers/thunderbolt/test.c b/drivers/thunderbolt/test.c
index 1f69bab236ee..be9b1d7e63d2 100644
--- a/drivers/thunderbolt/test.c
+++ b/drivers/thunderbolt/test.c
@@ -796,9 +796,9 @@ static void tb_test_path_not_connected(struct kunit *test)
 	up = &dev2->ports[9];
 
 	path = tb_path_alloc(NULL, down, 8, up, 8, 0, "PCIe Down");
-	KUNIT_ASSERT_TRUE(test, path == NULL);
+	KUNIT_ASSERT_NULL(test, path);
 	path = tb_path_alloc(NULL, down, 8, up, 8, 1, "PCIe Down");
-	KUNIT_ASSERT_TRUE(test, path == NULL);
+	KUNIT_ASSERT_NULL(test, path);
 }
 
 struct hop_expectation {
@@ -847,7 +847,7 @@ static void tb_test_path_not_bonded_lane0(struct kunit *test)
 	up = &dev->ports[9];
 
 	path = tb_path_alloc(NULL, down, 8, up, 8, 0, "PCIe Down");
-	KUNIT_ASSERT_TRUE(test, path != NULL);
+	KUNIT_ASSERT_NOT_NULL(test, path);
 	KUNIT_ASSERT_EQ(test, path->path_length, ARRAY_SIZE(test_data));
 	for (i = 0; i < ARRAY_SIZE(test_data); i++) {
 		const struct tb_port *in_port, *out_port;
@@ -909,7 +909,7 @@ static void tb_test_path_not_bonded_lane1(struct kunit *test)
 	out = &dev->ports[13];
 
 	path = tb_path_alloc(NULL, in, 9, out, 9, 1, "Video");
-	KUNIT_ASSERT_TRUE(test, path != NULL);
+	KUNIT_ASSERT_NOT_NULL(test, path);
 	KUNIT_ASSERT_EQ(test, path->path_length, ARRAY_SIZE(test_data));
 	for (i = 0; i < ARRAY_SIZE(test_data); i++) {
 		const struct tb_port *in_port, *out_port;
@@ -989,7 +989,7 @@ static void tb_test_path_not_bonded_lane1_chain(struct kunit *test)
 	out = &dev3->ports[13];
 
 	path = tb_path_alloc(NULL, in, 9, out, 9, 1, "Video");
-	KUNIT_ASSERT_TRUE(test, path != NULL);
+	KUNIT_ASSERT_NOT_NULL(test, path);
 	KUNIT_ASSERT_EQ(test, path->path_length, ARRAY_SIZE(test_data));
 	for (i = 0; i < ARRAY_SIZE(test_data); i++) {
 		const struct tb_port *in_port, *out_port;
@@ -1069,7 +1069,7 @@ static void tb_test_path_not_bonded_lane1_chain_reverse(struct kunit *test)
 	out = &host->ports[5];
 
 	path = tb_path_alloc(NULL, in, 9, out, 9, 1, "Video");
-	KUNIT_ASSERT_TRUE(test, path != NULL);
+	KUNIT_ASSERT_NOT_NULL(test, path);
 	KUNIT_ASSERT_EQ(test, path->path_length, ARRAY_SIZE(test_data));
 	for (i = 0; i < ARRAY_SIZE(test_data); i++) {
 		const struct tb_port *in_port, *out_port;
@@ -1161,7 +1161,7 @@ static void tb_test_path_mixed_chain(struct kunit *test)
 	out = &dev4->ports[13];
 
 	path = tb_path_alloc(NULL, in, 9, out, 9, 1, "Video");
-	KUNIT_ASSERT_TRUE(test, path != NULL);
+	KUNIT_ASSERT_NOT_NULL(test, path);
 	KUNIT_ASSERT_EQ(test, path->path_length, ARRAY_SIZE(test_data));
 	for (i = 0; i < ARRAY_SIZE(test_data); i++) {
 		const struct tb_port *in_port, *out_port;
@@ -1253,7 +1253,7 @@ static void tb_test_path_mixed_chain_reverse(struct kunit *test)
 	out = &host->ports[5];
 
 	path = tb_path_alloc(NULL, in, 9, out, 9, 1, "Video");
-	KUNIT_ASSERT_TRUE(test, path != NULL);
+	KUNIT_ASSERT_NOT_NULL(test, path);
 	KUNIT_ASSERT_EQ(test, path->path_length, ARRAY_SIZE(test_data));
 	for (i = 0; i < ARRAY_SIZE(test_data); i++) {
 		const struct tb_port *in_port, *out_port;
@@ -1297,7 +1297,7 @@ static void tb_test_tunnel_pcie(struct kunit *test)
 	down = &host->ports[8];
 	up = &dev1->ports[9];
 	tunnel1 = tb_tunnel_alloc_pci(NULL, up, down);
-	KUNIT_ASSERT_TRUE(test, tunnel1 != NULL);
+	KUNIT_ASSERT_NOT_NULL(test, tunnel1);
 	KUNIT_EXPECT_EQ(test, tunnel1->type, TB_TUNNEL_PCI);
 	KUNIT_EXPECT_PTR_EQ(test, tunnel1->src_port, down);
 	KUNIT_EXPECT_PTR_EQ(test, tunnel1->dst_port, up);
@@ -1312,7 +1312,7 @@ static void tb_test_tunnel_pcie(struct kunit *test)
 	down = &dev1->ports[10];
 	up = &dev2->ports[9];
 	tunnel2 = tb_tunnel_alloc_pci(NULL, up, down);
-	KUNIT_ASSERT_TRUE(test, tunnel2 != NULL);
+	KUNIT_ASSERT_NOT_NULL(test, tunnel2);
 	KUNIT_EXPECT_EQ(test, tunnel2->type, TB_TUNNEL_PCI);
 	KUNIT_EXPECT_PTR_EQ(test, tunnel2->src_port, down);
 	KUNIT_EXPECT_PTR_EQ(test, tunnel2->dst_port, up);
@@ -1349,7 +1349,7 @@ static void tb_test_tunnel_dp(struct kunit *test)
 	out = &dev->ports[13];
 
 	tunnel = tb_tunnel_alloc_dp(NULL, in, out, 0, 0);
-	KUNIT_ASSERT_TRUE(test, tunnel != NULL);
+	KUNIT_ASSERT_NOT_NULL(test, tunnel);
 	KUNIT_EXPECT_EQ(test, tunnel->type, TB_TUNNEL_DP);
 	KUNIT_EXPECT_PTR_EQ(test, tunnel->src_port, in);
 	KUNIT_EXPECT_PTR_EQ(test, tunnel->dst_port, out);
@@ -1395,7 +1395,7 @@ static void tb_test_tunnel_dp_chain(struct kunit *test)
 	out = &dev4->ports[14];
 
 	tunnel = tb_tunnel_alloc_dp(NULL, in, out, 0, 0);
-	KUNIT_ASSERT_TRUE(test, tunnel != NULL);
+	KUNIT_ASSERT_NOT_NULL(test, tunnel);
 	KUNIT_EXPECT_EQ(test, tunnel->type, TB_TUNNEL_DP);
 	KUNIT_EXPECT_PTR_EQ(test, tunnel->src_port, in);
 	KUNIT_EXPECT_PTR_EQ(test, tunnel->dst_port, out);
@@ -1445,7 +1445,7 @@ static void tb_test_tunnel_dp_tree(struct kunit *test)
 	out = &dev5->ports[13];
 
 	tunnel = tb_tunnel_alloc_dp(NULL, in, out, 0, 0);
-	KUNIT_ASSERT_TRUE(test, tunnel != NULL);
+	KUNIT_ASSERT_NOT_NULL(test, tunnel);
 	KUNIT_EXPECT_EQ(test, tunnel->type, TB_TUNNEL_DP);
 	KUNIT_EXPECT_PTR_EQ(test, tunnel->src_port, in);
 	KUNIT_EXPECT_PTR_EQ(test, tunnel->dst_port, out);
@@ -1510,7 +1510,7 @@ static void tb_test_tunnel_dp_max_length(struct kunit *test)
 	out = &dev12->ports[13];
 
 	tunnel = tb_tunnel_alloc_dp(NULL, in, out, 0, 0);
-	KUNIT_ASSERT_TRUE(test, tunnel != NULL);
+	KUNIT_ASSERT_NOT_NULL(test, tunnel);
 	KUNIT_EXPECT_EQ(test, tunnel->type, TB_TUNNEL_DP);
 	KUNIT_EXPECT_PTR_EQ(test, tunnel->src_port, in);
 	KUNIT_EXPECT_PTR_EQ(test, tunnel->dst_port, out);
@@ -1566,7 +1566,7 @@ static void tb_test_tunnel_usb3(struct kunit *test)
 	down = &host->ports[12];
 	up = &dev1->ports[16];
 	tunnel1 = tb_tunnel_alloc_usb3(NULL, up, down, 0, 0);
-	KUNIT_ASSERT_TRUE(test, tunnel1 != NULL);
+	KUNIT_ASSERT_NOT_NULL(test, tunnel1);
 	KUNIT_EXPECT_EQ(test, tunnel1->type, TB_TUNNEL_USB3);
 	KUNIT_EXPECT_PTR_EQ(test, tunnel1->src_port, down);
 	KUNIT_EXPECT_PTR_EQ(test, tunnel1->dst_port, up);
@@ -1581,7 +1581,7 @@ static void tb_test_tunnel_usb3(struct kunit *test)
 	down = &dev1->ports[17];
 	up = &dev2->ports[16];
 	tunnel2 = tb_tunnel_alloc_usb3(NULL, up, down, 0, 0);
-	KUNIT_ASSERT_TRUE(test, tunnel2 != NULL);
+	KUNIT_ASSERT_NOT_NULL(test, tunnel2);
 	KUNIT_EXPECT_EQ(test, tunnel2->type, TB_TUNNEL_USB3);
 	KUNIT_EXPECT_PTR_EQ(test, tunnel2->src_port, down);
 	KUNIT_EXPECT_PTR_EQ(test, tunnel2->dst_port, up);
@@ -1628,7 +1628,7 @@ static void tb_test_tunnel_port_on_path(struct kunit *test)
 	out = &dev5->ports[13];
 
 	dp_tunnel = tb_tunnel_alloc_dp(NULL, in, out, 0, 0);
-	KUNIT_ASSERT_TRUE(test, dp_tunnel != NULL);
+	KUNIT_ASSERT_NOT_NULL(test, dp_tunnel);
 
 	KUNIT_EXPECT_TRUE(test, tb_tunnel_port_on_path(dp_tunnel, in));
 	KUNIT_EXPECT_TRUE(test, tb_tunnel_port_on_path(dp_tunnel, out));
@@ -1685,7 +1685,7 @@ static void tb_test_tunnel_dma(struct kunit *test)
 	port = &host->ports[1];
 
 	tunnel = tb_tunnel_alloc_dma(NULL, nhi, port, 8, 1, 8, 1);
-	KUNIT_ASSERT_TRUE(test, tunnel != NULL);
+	KUNIT_ASSERT_NOT_NULL(test, tunnel);
 	KUNIT_EXPECT_EQ(test, tunnel->type, TB_TUNNEL_DMA);
 	KUNIT_EXPECT_PTR_EQ(test, tunnel->src_port, nhi);
 	KUNIT_EXPECT_PTR_EQ(test, tunnel->dst_port, port);
@@ -1728,7 +1728,7 @@ static void tb_test_tunnel_dma_rx(struct kunit *test)
 	port = &host->ports[1];
 
 	tunnel = tb_tunnel_alloc_dma(NULL, nhi, port, -1, -1, 15, 2);
-	KUNIT_ASSERT_TRUE(test, tunnel != NULL);
+	KUNIT_ASSERT_NOT_NULL(test, tunnel);
 	KUNIT_EXPECT_EQ(test, tunnel->type, TB_TUNNEL_DMA);
 	KUNIT_EXPECT_PTR_EQ(test, tunnel->src_port, nhi);
 	KUNIT_EXPECT_PTR_EQ(test, tunnel->dst_port, port);
@@ -1765,7 +1765,7 @@ static void tb_test_tunnel_dma_tx(struct kunit *test)
 	port = &host->ports[1];
 
 	tunnel = tb_tunnel_alloc_dma(NULL, nhi, port, 15, 2, -1, -1);
-	KUNIT_ASSERT_TRUE(test, tunnel != NULL);
+	KUNIT_ASSERT_NOT_NULL(test, tunnel);
 	KUNIT_EXPECT_EQ(test, tunnel->type, TB_TUNNEL_DMA);
 	KUNIT_EXPECT_PTR_EQ(test, tunnel->src_port, nhi);
 	KUNIT_EXPECT_PTR_EQ(test, tunnel->dst_port, port);
@@ -1811,7 +1811,7 @@ static void tb_test_tunnel_dma_chain(struct kunit *test)
 	nhi = &host->ports[7];
 	port = &dev2->ports[3];
 	tunnel = tb_tunnel_alloc_dma(NULL, nhi, port, 8, 1, 8, 1);
-	KUNIT_ASSERT_TRUE(test, tunnel != NULL);
+	KUNIT_ASSERT_NOT_NULL(test, tunnel);
 	KUNIT_EXPECT_EQ(test, tunnel->type, TB_TUNNEL_DMA);
 	KUNIT_EXPECT_PTR_EQ(test, tunnel->src_port, nhi);
 	KUNIT_EXPECT_PTR_EQ(test, tunnel->dst_port, port);
@@ -1857,7 +1857,7 @@ static void tb_test_tunnel_dma_match(struct kunit *test)
 	port = &host->ports[1];
 
 	tunnel = tb_tunnel_alloc_dma(NULL, nhi, port, 15, 1, 15, 1);
-	KUNIT_ASSERT_TRUE(test, tunnel != NULL);
+	KUNIT_ASSERT_NOT_NULL(test, tunnel);
 
 	KUNIT_ASSERT_TRUE(test, tb_tunnel_match_dma(tunnel, 15, 1, 15, 1));
 	KUNIT_ASSERT_FALSE(test, tb_tunnel_match_dma(tunnel, 8, 1, 15, 1));
@@ -1873,7 +1873,7 @@ static void tb_test_tunnel_dma_match(struct kunit *test)
 	tb_tunnel_free(tunnel);
 
 	tunnel = tb_tunnel_alloc_dma(NULL, nhi, port, 15, 1, -1, -1);
-	KUNIT_ASSERT_TRUE(test, tunnel != NULL);
+	KUNIT_ASSERT_NOT_NULL(test, tunnel);
 	KUNIT_ASSERT_TRUE(test, tb_tunnel_match_dma(tunnel, 15, 1, -1, -1));
 	KUNIT_ASSERT_TRUE(test, tb_tunnel_match_dma(tunnel, 15, -1, -1, -1));
 	KUNIT_ASSERT_TRUE(test, tb_tunnel_match_dma(tunnel, -1, 1, -1, -1));
@@ -1885,7 +1885,7 @@ static void tb_test_tunnel_dma_match(struct kunit *test)
 	tb_tunnel_free(tunnel);
 
 	tunnel = tb_tunnel_alloc_dma(NULL, nhi, port, -1, -1, 15, 11);
-	KUNIT_ASSERT_TRUE(test, tunnel != NULL);
+	KUNIT_ASSERT_NOT_NULL(test, tunnel);
 	KUNIT_ASSERT_TRUE(test, tb_tunnel_match_dma(tunnel, -1, -1, 15, 11));
 	KUNIT_ASSERT_TRUE(test, tb_tunnel_match_dma(tunnel, -1, -1, 15, -1));
 	KUNIT_ASSERT_TRUE(test, tb_tunnel_match_dma(tunnel, -1, -1, -1, 11));
@@ -1910,7 +1910,7 @@ static void tb_test_credit_alloc_legacy_not_bonded(struct kunit *test)
 	down = &host->ports[8];
 	up = &dev->ports[9];
 	tunnel = tb_tunnel_alloc_pci(NULL, up, down);
-	KUNIT_ASSERT_TRUE(test, tunnel != NULL);
+	KUNIT_ASSERT_NOT_NULL(test, tunnel);
 	KUNIT_ASSERT_EQ(test, tunnel->npaths, (size_t)2);
 
 	path = tunnel->paths[0];
@@ -1943,7 +1943,7 @@ static void tb_test_credit_alloc_legacy_bonded(struct kunit *test)
 	down = &host->ports[8];
 	up = &dev->ports[9];
 	tunnel = tb_tunnel_alloc_pci(NULL, up, down);
-	KUNIT_ASSERT_TRUE(test, tunnel != NULL);
+	KUNIT_ASSERT_NOT_NULL(test, tunnel);
 	KUNIT_ASSERT_EQ(test, tunnel->npaths, (size_t)2);
 
 	path = tunnel->paths[0];
@@ -1976,7 +1976,7 @@ static void tb_test_credit_alloc_pcie(struct kunit *test)
 	down = &host->ports[8];
 	up = &dev->ports[9];
 	tunnel = tb_tunnel_alloc_pci(NULL, up, down);
-	KUNIT_ASSERT_TRUE(test, tunnel != NULL);
+	KUNIT_ASSERT_NOT_NULL(test, tunnel);
 	KUNIT_ASSERT_EQ(test, tunnel->npaths, (size_t)2);
 
 	path = tunnel->paths[0];
@@ -2010,7 +2010,7 @@ static void tb_test_credit_alloc_dp(struct kunit *test)
 	out = &dev->ports[14];
 
 	tunnel = tb_tunnel_alloc_dp(NULL, in, out, 0, 0);
-	KUNIT_ASSERT_TRUE(test, tunnel != NULL);
+	KUNIT_ASSERT_NOT_NULL(test, tunnel);
 	KUNIT_ASSERT_EQ(test, tunnel->npaths, (size_t)3);
 
 	/* Video (main) path */
@@ -2053,7 +2053,7 @@ static void tb_test_credit_alloc_usb3(struct kunit *test)
 	down = &host->ports[12];
 	up = &dev->ports[16];
 	tunnel = tb_tunnel_alloc_usb3(NULL, up, down, 0, 0);
-	KUNIT_ASSERT_TRUE(test, tunnel != NULL);
+	KUNIT_ASSERT_NOT_NULL(test, tunnel);
 	KUNIT_ASSERT_EQ(test, tunnel->npaths, (size_t)2);
 
 	path = tunnel->paths[0];
@@ -2087,7 +2087,7 @@ static void tb_test_credit_alloc_dma(struct kunit *test)
 	port = &dev->ports[3];
 
 	tunnel = tb_tunnel_alloc_dma(NULL, nhi, port, 8, 1, 8, 1);
-	KUNIT_ASSERT_TRUE(test, tunnel != NULL);
+	KUNIT_ASSERT_NOT_NULL(test, tunnel);
 	KUNIT_ASSERT_EQ(test, tunnel->npaths, (size_t)2);
 
 	/* DMA RX */
@@ -2141,7 +2141,7 @@ static void tb_test_credit_alloc_dma_multiple(struct kunit *test)
 	 * remaining 1 and then we run out of buffers.
 	 */
 	tunnel1 = tb_tunnel_alloc_dma(NULL, nhi, port, 8, 1, 8, 1);
-	KUNIT_ASSERT_TRUE(test, tunnel1 != NULL);
+	KUNIT_ASSERT_NOT_NULL(test, tunnel1);
 	KUNIT_ASSERT_EQ(test, tunnel1->npaths, (size_t)2);
 
 	path = tunnel1->paths[0];
@@ -2159,7 +2159,7 @@ static void tb_test_credit_alloc_dma_multiple(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, path->hops[1].initial_credits, 14U);
 
 	tunnel2 = tb_tunnel_alloc_dma(NULL, nhi, port, 9, 2, 9, 2);
-	KUNIT_ASSERT_TRUE(test, tunnel2 != NULL);
+	KUNIT_ASSERT_NOT_NULL(test, tunnel2);
 	KUNIT_ASSERT_EQ(test, tunnel2->npaths, (size_t)2);
 
 	path = tunnel2->paths[0];
@@ -2177,7 +2177,7 @@ static void tb_test_credit_alloc_dma_multiple(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, path->hops[1].initial_credits, 1U);
 
 	tunnel3 = tb_tunnel_alloc_dma(NULL, nhi, port, 10, 3, 10, 3);
-	KUNIT_ASSERT_TRUE(test, tunnel3 == NULL);
+	KUNIT_ASSERT_NULL(test, tunnel3);
 
 	/*
 	 * Release the first DMA tunnel. That should make 14 buffers
@@ -2186,7 +2186,7 @@ static void tb_test_credit_alloc_dma_multiple(struct kunit *test)
 	tb_tunnel_free(tunnel1);
 
 	tunnel3 = tb_tunnel_alloc_dma(NULL, nhi, port, 10, 3, 10, 3);
-	KUNIT_ASSERT_TRUE(test, tunnel3 != NULL);
+	KUNIT_ASSERT_NOT_NULL(test, tunnel3);
 
 	path = tunnel3->paths[0];
 	KUNIT_ASSERT_EQ(test, path->path_length, 2);
@@ -2216,7 +2216,7 @@ static struct tb_tunnel *TB_TEST_PCIE_TUNNEL(struct kunit *test,
 	down = &host->ports[8];
 	up = &dev->ports[9];
 	pcie_tunnel = tb_tunnel_alloc_pci(NULL, up, down);
-	KUNIT_ASSERT_TRUE(test, pcie_tunnel != NULL);
+	KUNIT_ASSERT_NOT_NULL(test, pcie_tunnel);
 	KUNIT_ASSERT_EQ(test, pcie_tunnel->npaths, (size_t)2);
 
 	path = pcie_tunnel->paths[0];
@@ -2246,7 +2246,7 @@ static struct tb_tunnel *TB_TEST_DP_TUNNEL1(struct kunit *test,
 	in = &host->ports[5];
 	out = &dev->ports[13];
 	dp_tunnel1 = tb_tunnel_alloc_dp(NULL, in, out, 0, 0);
-	KUNIT_ASSERT_TRUE(test, dp_tunnel1 != NULL);
+	KUNIT_ASSERT_NOT_NULL(test, dp_tunnel1);
 	KUNIT_ASSERT_EQ(test, dp_tunnel1->npaths, (size_t)3);
 
 	path = dp_tunnel1->paths[0];
@@ -2283,7 +2283,7 @@ static struct tb_tunnel *TB_TEST_DP_TUNNEL2(struct kunit *test,
 	in = &host->ports[6];
 	out = &dev->ports[14];
 	dp_tunnel2 = tb_tunnel_alloc_dp(NULL, in, out, 0, 0);
-	KUNIT_ASSERT_TRUE(test, dp_tunnel2 != NULL);
+	KUNIT_ASSERT_NOT_NULL(test, dp_tunnel2);
 	KUNIT_ASSERT_EQ(test, dp_tunnel2->npaths, (size_t)3);
 
 	path = dp_tunnel2->paths[0];
@@ -2320,7 +2320,7 @@ static struct tb_tunnel *TB_TEST_USB3_TUNNEL(struct kunit *test,
 	down = &host->ports[12];
 	up = &dev->ports[16];
 	usb3_tunnel = tb_tunnel_alloc_usb3(NULL, up, down, 0, 0);
-	KUNIT_ASSERT_TRUE(test, usb3_tunnel != NULL);
+	KUNIT_ASSERT_NOT_NULL(test, usb3_tunnel);
 	KUNIT_ASSERT_EQ(test, usb3_tunnel->npaths, (size_t)2);
 
 	path = usb3_tunnel->paths[0];
@@ -2350,7 +2350,7 @@ static struct tb_tunnel *TB_TEST_DMA_TUNNEL1(struct kunit *test,
 	nhi = &host->ports[7];
 	port = &dev->ports[3];
 	dma_tunnel1 = tb_tunnel_alloc_dma(NULL, nhi, port, 8, 1, 8, 1);
-	KUNIT_ASSERT_TRUE(test, dma_tunnel1 != NULL);
+	KUNIT_ASSERT_NOT_NULL(test, dma_tunnel1);
 	KUNIT_ASSERT_EQ(test, dma_tunnel1->npaths, (size_t)2);
 
 	path = dma_tunnel1->paths[0];
@@ -2380,7 +2380,7 @@ static struct tb_tunnel *TB_TEST_DMA_TUNNEL2(struct kunit *test,
 	nhi = &host->ports[7];
 	port = &dev->ports[3];
 	dma_tunnel2 = tb_tunnel_alloc_dma(NULL, nhi, port, 9, 2, 9, 2);
-	KUNIT_ASSERT_TRUE(test, dma_tunnel2 != NULL);
+	KUNIT_ASSERT_NOT_NULL(test, dma_tunnel2);
 	KUNIT_ASSERT_EQ(test, dma_tunnel2->npaths, (size_t)2);
 
 	path = dma_tunnel2->paths[0];
@@ -2496,50 +2496,50 @@ static void tb_test_property_parse(struct kunit *test)
 	struct tb_property *p;
 
 	dir = tb_property_parse_dir(root_directory, ARRAY_SIZE(root_directory));
-	KUNIT_ASSERT_TRUE(test, dir != NULL);
+	KUNIT_ASSERT_NOT_NULL(test, dir);
 
 	p = tb_property_find(dir, "foo", TB_PROPERTY_TYPE_TEXT);
-	KUNIT_ASSERT_TRUE(test, !p);
+	KUNIT_ASSERT_NULL(test, p);
 
 	p = tb_property_find(dir, "vendorid", TB_PROPERTY_TYPE_TEXT);
-	KUNIT_ASSERT_TRUE(test, p != NULL);
+	KUNIT_ASSERT_NOT_NULL(test, p);
 	KUNIT_EXPECT_STREQ(test, p->value.text, "Apple Inc.");
 
 	p = tb_property_find(dir, "vendorid", TB_PROPERTY_TYPE_VALUE);
-	KUNIT_ASSERT_TRUE(test, p != NULL);
+	KUNIT_ASSERT_NOT_NULL(test, p);
 	KUNIT_EXPECT_EQ(test, p->value.immediate, 0xa27);
 
 	p = tb_property_find(dir, "deviceid", TB_PROPERTY_TYPE_TEXT);
-	KUNIT_ASSERT_TRUE(test, p != NULL);
+	KUNIT_ASSERT_NOT_NULL(test, p);
 	KUNIT_EXPECT_STREQ(test, p->value.text, "Macintosh");
 
 	p = tb_property_find(dir, "deviceid", TB_PROPERTY_TYPE_VALUE);
-	KUNIT_ASSERT_TRUE(test, p != NULL);
+	KUNIT_ASSERT_NOT_NULL(test, p);
 	KUNIT_EXPECT_EQ(test, p->value.immediate, 0xa);
 
 	p = tb_property_find(dir, "missing", TB_PROPERTY_TYPE_DIRECTORY);
-	KUNIT_ASSERT_TRUE(test, !p);
+	KUNIT_ASSERT_NULL(test, p);
 
 	p = tb_property_find(dir, "network", TB_PROPERTY_TYPE_DIRECTORY);
-	KUNIT_ASSERT_TRUE(test, p != NULL);
+	KUNIT_ASSERT_NOT_NULL(test, p);
 
 	network_dir = p->value.dir;
 	KUNIT_EXPECT_TRUE(test, uuid_equal(network_dir->uuid, &network_dir_uuid));
 
 	p = tb_property_find(network_dir, "prtcid", TB_PROPERTY_TYPE_VALUE);
-	KUNIT_ASSERT_TRUE(test, p != NULL);
+	KUNIT_ASSERT_NOT_NULL(test, p);
 	KUNIT_EXPECT_EQ(test, p->value.immediate, 0x1);
 
 	p = tb_property_find(network_dir, "prtcvers", TB_PROPERTY_TYPE_VALUE);
-	KUNIT_ASSERT_TRUE(test, p != NULL);
+	KUNIT_ASSERT_NOT_NULL(test, p);
 	KUNIT_EXPECT_EQ(test, p->value.immediate, 0x1);
 
 	p = tb_property_find(network_dir, "prtcrevs", TB_PROPERTY_TYPE_VALUE);
-	KUNIT_ASSERT_TRUE(test, p != NULL);
+	KUNIT_ASSERT_NOT_NULL(test, p);
 	KUNIT_EXPECT_EQ(test, p->value.immediate, 0x1);
 
 	p = tb_property_find(network_dir, "prtcstns", TB_PROPERTY_TYPE_VALUE);
-	KUNIT_ASSERT_TRUE(test, p != NULL);
+	KUNIT_ASSERT_NOT_NULL(test, p);
 	KUNIT_EXPECT_EQ(test, p->value.immediate, 0x0);
 
 	p = tb_property_find(network_dir, "deviceid", TB_PROPERTY_TYPE_VALUE);
@@ -2558,7 +2558,7 @@ static void tb_test_property_format(struct kunit *test)
 	int ret, i;
 
 	dir = tb_property_parse_dir(root_directory, ARRAY_SIZE(root_directory));
-	KUNIT_ASSERT_TRUE(test, dir != NULL);
+	KUNIT_ASSERT_NOT_NULL(test, dir);
 
 	ret = tb_property_format_dir(dir, NULL, 0);
 	KUNIT_ASSERT_EQ(test, ret, ARRAY_SIZE(root_directory));
@@ -2566,7 +2566,7 @@ static void tb_test_property_format(struct kunit *test)
 	block_len = ret;
 
 	block = kunit_kzalloc(test, block_len * sizeof(u32), GFP_KERNEL);
-	KUNIT_ASSERT_TRUE(test, block != NULL);
+	KUNIT_ASSERT_NOT_NULL(test, block);
 
 	ret = tb_property_format_dir(dir, block, block_len);
 	KUNIT_EXPECT_EQ(test, ret, 0);
@@ -2584,10 +2584,10 @@ static void compare_dirs(struct kunit *test, struct tb_property_dir *d1,
 	int n1, n2, i;
 
 	if (d1->uuid) {
-		KUNIT_ASSERT_TRUE(test, d2->uuid != NULL);
+		KUNIT_ASSERT_NOT_NULL(test, d2->uuid);
 		KUNIT_ASSERT_TRUE(test, uuid_equal(d1->uuid, d2->uuid));
 	} else {
-		KUNIT_ASSERT_TRUE(test, d2->uuid == NULL);
+		KUNIT_ASSERT_NULL(test, d2->uuid);
 	}
 
 	n1 = 0;
@@ -2606,9 +2606,9 @@ static void compare_dirs(struct kunit *test, struct tb_property_dir *d1,
 	p2 = NULL;
 	for (i = 0; i < n1; i++) {
 		p1 = tb_property_get_next(d1, p1);
-		KUNIT_ASSERT_TRUE(test, p1 != NULL);
+		KUNIT_ASSERT_NOT_NULL(test, p1);
 		p2 = tb_property_get_next(d2, p2);
-		KUNIT_ASSERT_TRUE(test, p2 != NULL);
+		KUNIT_ASSERT_NOT_NULL(test, p2);
 
 		KUNIT_ASSERT_STREQ(test, &p1->key[0], &p2->key[0]);
 		KUNIT_ASSERT_EQ(test, p1->type, p2->type);
@@ -2616,14 +2616,14 @@ static void compare_dirs(struct kunit *test, struct tb_property_dir *d1,
 
 		switch (p1->type) {
 		case TB_PROPERTY_TYPE_DIRECTORY:
-			KUNIT_ASSERT_TRUE(test, p1->value.dir != NULL);
-			KUNIT_ASSERT_TRUE(test, p2->value.dir != NULL);
+			KUNIT_ASSERT_NOT_NULL(test, p1->value.dir);
+			KUNIT_ASSERT_NOT_NULL(test, p2->value.dir);
 			compare_dirs(test, p1->value.dir, p2->value.dir);
 			break;
 
 		case TB_PROPERTY_TYPE_DATA:
-			KUNIT_ASSERT_TRUE(test, p1->value.data != NULL);
-			KUNIT_ASSERT_TRUE(test, p2->value.data != NULL);
+			KUNIT_ASSERT_NOT_NULL(test, p1->value.data);
+			KUNIT_ASSERT_NOT_NULL(test, p2->value.data);
 			KUNIT_ASSERT_TRUE(test,
 				!memcmp(p1->value.data, p2->value.data,
 					p1->length * 4)
@@ -2631,8 +2631,8 @@ static void compare_dirs(struct kunit *test, struct tb_property_dir *d1,
 			break;
 
 		case TB_PROPERTY_TYPE_TEXT:
-			KUNIT_ASSERT_TRUE(test, p1->value.text != NULL);
-			KUNIT_ASSERT_TRUE(test, p2->value.text != NULL);
+			KUNIT_ASSERT_NOT_NULL(test, p1->value.text);
+			KUNIT_ASSERT_NOT_NULL(test, p2->value.text);
 			KUNIT_ASSERT_STREQ(test, p1->value.text, p2->value.text);
 			break;
 
@@ -2654,10 +2654,10 @@ static void tb_test_property_copy(struct kunit *test)
 	int ret, i;
 
 	src = tb_property_parse_dir(root_directory, ARRAY_SIZE(root_directory));
-	KUNIT_ASSERT_TRUE(test, src != NULL);
+	KUNIT_ASSERT_NOT_NULL(test, src);
 
 	dst = tb_property_copy_dir(src);
-	KUNIT_ASSERT_TRUE(test, dst != NULL);
+	KUNIT_ASSERT_NOT_NULL(test, dst);
 
 	/* Compare the structures */
 	compare_dirs(test, src, dst);
@@ -2667,7 +2667,7 @@ static void tb_test_property_copy(struct kunit *test)
 	KUNIT_ASSERT_EQ(test, ret, ARRAY_SIZE(root_directory));
 
 	block = kunit_kzalloc(test, sizeof(root_directory), GFP_KERNEL);
-	KUNIT_ASSERT_TRUE(test, block != NULL);
+	KUNIT_ASSERT_NOT_NULL(test, block);
 
 	ret = tb_property_format_dir(dst, block, ARRAY_SIZE(root_directory));
 	KUNIT_EXPECT_TRUE(test, !ret);
diff --git a/include/kunit/resource.h b/include/kunit/resource.h
new file mode 100644
index 000000000000..09c2b34d1c61
--- /dev/null
+++ b/include/kunit/resource.h
@@ -0,0 +1,406 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * KUnit resource API for test managed resources (allocations, etc.).
+ *
+ * Copyright (C) 2022, Google LLC.
+ * Author: Daniel Latypov <dlatypov@google.com>
+ */
+
+#ifndef _KUNIT_RESOURCE_H
+#define _KUNIT_RESOURCE_H
+
+#include <kunit/test.h>
+
+#include <linux/kref.h>
+#include <linux/list.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+
+struct kunit_resource;
+
+typedef int (*kunit_resource_init_t)(struct kunit_resource *, void *);
+typedef void (*kunit_resource_free_t)(struct kunit_resource *);
+
+/**
+ * struct kunit_resource - represents a *test managed resource*
+ * @data: for the user to store arbitrary data.
+ * @name: optional name
+ * @free: a user supplied function to free the resource.
+ *
+ * Represents a *test managed resource*, a resource which will automatically be
+ * cleaned up at the end of a test case. This cleanup is performed by the 'free'
+ * function. The struct kunit_resource itself is freed automatically with
+ * kfree() if it was allocated by KUnit (e.g., by kunit_alloc_resource()), but
+ * must be freed by the user otherwise.
+ *
+ * Resources are reference counted so if a resource is retrieved via
+ * kunit_alloc_and_get_resource() or kunit_find_resource(), we need
+ * to call kunit_put_resource() to reduce the resource reference count
+ * when finished with it.  Note that kunit_alloc_resource() does not require a
+ * kunit_resource_put() because it does not retrieve the resource itself.
+ *
+ * Example:
+ *
+ * .. code-block:: c
+ *
+ *	struct kunit_kmalloc_params {
+ *		size_t size;
+ *		gfp_t gfp;
+ *	};
+ *
+ *	static int kunit_kmalloc_init(struct kunit_resource *res, void *context)
+ *	{
+ *		struct kunit_kmalloc_params *params = context;
+ *		res->data = kmalloc(params->size, params->gfp);
+ *
+ *		if (!res->data)
+ *			return -ENOMEM;
+ *
+ *		return 0;
+ *	}
+ *
+ *	static void kunit_kmalloc_free(struct kunit_resource *res)
+ *	{
+ *		kfree(res->data);
+ *	}
+ *
+ *	void *kunit_kmalloc(struct kunit *test, size_t size, gfp_t gfp)
+ *	{
+ *		struct kunit_kmalloc_params params;
+ *
+ *		params.size = size;
+ *		params.gfp = gfp;
+ *
+ *		return kunit_alloc_resource(test, kunit_kmalloc_init,
+ *			kunit_kmalloc_free, &params);
+ *	}
+ *
+ * Resources can also be named, with lookup/removal done on a name
+ * basis also.  kunit_add_named_resource(), kunit_find_named_resource()
+ * and kunit_destroy_named_resource().  Resource names must be
+ * unique within the test instance.
+ */
+struct kunit_resource {
+	void *data;
+	const char *name;
+	kunit_resource_free_t free;
+
+	/* private: internal use only. */
+	struct kref refcount;
+	struct list_head node;
+	bool should_kfree;
+};
+
+/**
+ * kunit_get_resource() - Hold resource for use.  Should not need to be used
+ *			  by most users as we automatically get resources
+ *			  retrieved by kunit_find_resource*().
+ * @res: resource
+ */
+static inline void kunit_get_resource(struct kunit_resource *res)
+{
+	kref_get(&res->refcount);
+}
+
+/*
+ * Called when refcount reaches zero via kunit_put_resource();
+ * should not be called directly.
+ */
+static inline void kunit_release_resource(struct kref *kref)
+{
+	struct kunit_resource *res = container_of(kref, struct kunit_resource,
+						  refcount);
+
+	if (res->free)
+		res->free(res);
+
+	/* 'res' is valid here, as if should_kfree is set, res->free may not free
+	 * 'res' itself, just res->data
+	 */
+	if (res->should_kfree)
+		kfree(res);
+}
+
+/**
+ * kunit_put_resource() - When caller is done with retrieved resource,
+ *			  kunit_put_resource() should be called to drop
+ *			  reference count.  The resource list maintains
+ *			  a reference count on resources, so if no users
+ *			  are utilizing a resource and it is removed from
+ *			  the resource list, it will be freed via the
+ *			  associated free function (if any).  Only
+ *			  needs to be used if we alloc_and_get() or
+ *			  find() resource.
+ * @res: resource
+ */
+static inline void kunit_put_resource(struct kunit_resource *res)
+{
+	kref_put(&res->refcount, kunit_release_resource);
+}
+
+/**
+ * __kunit_add_resource() - Internal helper to add a resource.
+ *
+ * res->should_kfree is not initialised.
+ * @test: The test context object.
+ * @init: a user-supplied function to initialize the result (if needed).  If
+ *        none is supplied, the resource data value is simply set to @data.
+ *	  If an init function is supplied, @data is passed to it instead.
+ * @free: a user-supplied function to free the resource (if needed).
+ * @res: The resource.
+ * @data: value to pass to init function or set in resource data field.
+ */
+int __kunit_add_resource(struct kunit *test,
+			 kunit_resource_init_t init,
+			 kunit_resource_free_t free,
+			 struct kunit_resource *res,
+			 void *data);
+
+/**
+ * kunit_add_resource() - Add a *test managed resource*.
+ * @test: The test context object.
+ * @init: a user-supplied function to initialize the result (if needed).  If
+ *        none is supplied, the resource data value is simply set to @data.
+ *	  If an init function is supplied, @data is passed to it instead.
+ * @free: a user-supplied function to free the resource (if needed).
+ * @res: The resource.
+ * @data: value to pass to init function or set in resource data field.
+ */
+static inline int kunit_add_resource(struct kunit *test,
+				     kunit_resource_init_t init,
+				     kunit_resource_free_t free,
+				     struct kunit_resource *res,
+				     void *data)
+{
+	res->should_kfree = false;
+	return __kunit_add_resource(test, init, free, res, data);
+}
+
+static inline struct kunit_resource *
+kunit_find_named_resource(struct kunit *test, const char *name);
+
+/**
+ * kunit_add_named_resource() - Add a named *test managed resource*.
+ * @test: The test context object.
+ * @init: a user-supplied function to initialize the resource data, if needed.
+ * @free: a user-supplied function to free the resource data, if needed.
+ * @res: The resource.
+ * @name: name to be set for resource.
+ * @data: value to pass to init function or set in resource data field.
+ */
+static inline int kunit_add_named_resource(struct kunit *test,
+					   kunit_resource_init_t init,
+					   kunit_resource_free_t free,
+					   struct kunit_resource *res,
+					   const char *name,
+					   void *data)
+{
+	struct kunit_resource *existing;
+
+	if (!name)
+		return -EINVAL;
+
+	existing = kunit_find_named_resource(test, name);
+	if (existing) {
+		kunit_put_resource(existing);
+		return -EEXIST;
+	}
+
+	res->name = name;
+	res->should_kfree = false;
+
+	return __kunit_add_resource(test, init, free, res, data);
+}
+
+/**
+ * kunit_alloc_and_get_resource() - Allocates and returns a *test managed resource*.
+ * @test: The test context object.
+ * @init: a user supplied function to initialize the resource.
+ * @free: a user supplied function to free the resource (if needed).
+ * @internal_gfp: gfp to use for internal allocations, if unsure, use GFP_KERNEL
+ * @context: for the user to pass in arbitrary data to the init function.
+ *
+ * Allocates a *test managed resource*, a resource which will automatically be
+ * cleaned up at the end of a test case. See &struct kunit_resource for an
+ * example.
+ *
+ * This is effectively identical to kunit_alloc_resource, but returns the
+ * struct kunit_resource pointer, not just the 'data' pointer. It therefore
+ * also increments the resource's refcount, so kunit_put_resource() should be
+ * called when you've finished with it.
+ *
+ * Note: KUnit needs to allocate memory for a kunit_resource object. You must
+ * specify an @internal_gfp that is compatible with the use context of your
+ * resource.
+ */
+static inline struct kunit_resource *
+kunit_alloc_and_get_resource(struct kunit *test,
+			     kunit_resource_init_t init,
+			     kunit_resource_free_t free,
+			     gfp_t internal_gfp,
+			     void *context)
+{
+	struct kunit_resource *res;
+	int ret;
+
+	res = kzalloc(sizeof(*res), internal_gfp);
+	if (!res)
+		return NULL;
+
+	res->should_kfree = true;
+
+	ret = __kunit_add_resource(test, init, free, res, context);
+	if (!ret) {
+		/*
+		 * bump refcount for get; kunit_resource_put() should be called
+		 * when done.
+		 */
+		kunit_get_resource(res);
+		return res;
+	}
+	return NULL;
+}
+
+/**
+ * kunit_alloc_resource() - Allocates a *test managed resource*.
+ * @test: The test context object.
+ * @init: a user supplied function to initialize the resource.
+ * @free: a user supplied function to free the resource (if needed).
+ * @internal_gfp: gfp to use for internal allocations, if unsure, use GFP_KERNEL
+ * @context: for the user to pass in arbitrary data to the init function.
+ *
+ * Allocates a *test managed resource*, a resource which will automatically be
+ * cleaned up at the end of a test case. See &struct kunit_resource for an
+ * example.
+ *
+ * Note: KUnit needs to allocate memory for a kunit_resource object. You must
+ * specify an @internal_gfp that is compatible with the use context of your
+ * resource.
+ */
+static inline void *kunit_alloc_resource(struct kunit *test,
+					 kunit_resource_init_t init,
+					 kunit_resource_free_t free,
+					 gfp_t internal_gfp,
+					 void *context)
+{
+	struct kunit_resource *res;
+
+	res = kzalloc(sizeof(*res), internal_gfp);
+	if (!res)
+		return NULL;
+
+	res->should_kfree = true;
+	if (!__kunit_add_resource(test, init, free, res, context))
+		return res->data;
+
+	return NULL;
+}
+
+typedef bool (*kunit_resource_match_t)(struct kunit *test,
+				       struct kunit_resource *res,
+				       void *match_data);
+
+/**
+ * kunit_resource_instance_match() - Match a resource with the same instance.
+ * @test: Test case to which the resource belongs.
+ * @res: The resource.
+ * @match_data: The resource pointer to match against.
+ *
+ * An instance of kunit_resource_match_t that matches a resource whose
+ * allocation matches @match_data.
+ */
+static inline bool kunit_resource_instance_match(struct kunit *test,
+						 struct kunit_resource *res,
+						 void *match_data)
+{
+	return res->data == match_data;
+}
+
+/**
+ * kunit_resource_name_match() - Match a resource with the same name.
+ * @test: Test case to which the resource belongs.
+ * @res: The resource.
+ * @match_name: The name to match against.
+ */
+static inline bool kunit_resource_name_match(struct kunit *test,
+					     struct kunit_resource *res,
+					     void *match_name)
+{
+	return res->name && strcmp(res->name, match_name) == 0;
+}
+
+/**
+ * kunit_find_resource() - Find a resource using match function/data.
+ * @test: Test case to which the resource belongs.
+ * @match: match function to be applied to resources/match data.
+ * @match_data: data to be used in matching.
+ */
+static inline struct kunit_resource *
+kunit_find_resource(struct kunit *test,
+		    kunit_resource_match_t match,
+		    void *match_data)
+{
+	struct kunit_resource *res, *found = NULL;
+	unsigned long flags;
+
+	spin_lock_irqsave(&test->lock, flags);
+
+	list_for_each_entry_reverse(res, &test->resources, node) {
+		if (match(test, res, (void *)match_data)) {
+			found = res;
+			kunit_get_resource(found);
+			break;
+		}
+	}
+
+	spin_unlock_irqrestore(&test->lock, flags);
+
+	return found;
+}
+
+/**
+ * kunit_find_named_resource() - Find a resource using match name.
+ * @test: Test case to which the resource belongs.
+ * @name: match name.
+ */
+static inline struct kunit_resource *
+kunit_find_named_resource(struct kunit *test,
+			  const char *name)
+{
+	return kunit_find_resource(test, kunit_resource_name_match,
+				   (void *)name);
+}
+
+/**
+ * kunit_destroy_resource() - Find a kunit_resource and destroy it.
+ * @test: Test case to which the resource belongs.
+ * @match: Match function. Returns whether a given resource matches @match_data.
+ * @match_data: Data passed into @match.
+ *
+ * RETURNS:
+ * 0 if kunit_resource is found and freed, -ENOENT if not found.
+ */
+int kunit_destroy_resource(struct kunit *test,
+			   kunit_resource_match_t match,
+			   void *match_data);
+
+static inline int kunit_destroy_named_resource(struct kunit *test,
+					       const char *name)
+{
+	return kunit_destroy_resource(test, kunit_resource_name_match,
+				      (void *)name);
+}
+
+/**
+ * kunit_remove_resource() - remove resource from resource list associated with
+ *			     test.
+ * @test: The test context object.
+ * @res: The resource to be removed.
+ *
+ * Note that the resource will not be immediately freed since it is likely
+ * the caller has a reference to it via alloc_and_get() or find();
+ * in this case a final call to kunit_put_resource() is required.
+ */
+void kunit_remove_resource(struct kunit *test, struct kunit_resource *res);
+
+#endif /* _KUNIT_RESOURCE_H */
diff --git a/include/kunit/test.h b/include/kunit/test.h
index 00b9ff7783ab..8ffcd7de9607 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -27,78 +27,6 @@
 
 #include <asm/rwonce.h>
 
-struct kunit_resource;
-
-typedef int (*kunit_resource_init_t)(struct kunit_resource *, void *);
-typedef void (*kunit_resource_free_t)(struct kunit_resource *);
-
-/**
- * struct kunit_resource - represents a *test managed resource*
- * @data: for the user to store arbitrary data.
- * @name: optional name
- * @free: a user supplied function to free the resource. Populated by
- * kunit_resource_alloc().
- *
- * Represents a *test managed resource*, a resource which will automatically be
- * cleaned up at the end of a test case.
- *
- * Resources are reference counted so if a resource is retrieved via
- * kunit_alloc_and_get_resource() or kunit_find_resource(), we need
- * to call kunit_put_resource() to reduce the resource reference count
- * when finished with it.  Note that kunit_alloc_resource() does not require a
- * kunit_resource_put() because it does not retrieve the resource itself.
- *
- * Example:
- *
- * .. code-block:: c
- *
- *	struct kunit_kmalloc_params {
- *		size_t size;
- *		gfp_t gfp;
- *	};
- *
- *	static int kunit_kmalloc_init(struct kunit_resource *res, void *context)
- *	{
- *		struct kunit_kmalloc_params *params = context;
- *		res->data = kmalloc(params->size, params->gfp);
- *
- *		if (!res->data)
- *			return -ENOMEM;
- *
- *		return 0;
- *	}
- *
- *	static void kunit_kmalloc_free(struct kunit_resource *res)
- *	{
- *		kfree(res->data);
- *	}
- *
- *	void *kunit_kmalloc(struct kunit *test, size_t size, gfp_t gfp)
- *	{
- *		struct kunit_kmalloc_params params;
- *
- *		params.size = size;
- *		params.gfp = gfp;
- *
- *		return kunit_alloc_resource(test, kunit_kmalloc_init,
- *			kunit_kmalloc_free, &params);
- *	}
- *
- * Resources can also be named, with lookup/removal done on a name
- * basis also.  kunit_add_named_resource(), kunit_find_named_resource()
- * and kunit_destroy_named_resource().  Resource names must be
- * unique within the test instance.
- */
-struct kunit_resource {
-	void *data;
-	const char *name;
-	kunit_resource_free_t free;
-
-	/* private: internal use only. */
-	struct kref refcount;
-	struct list_head node;
-};
-
 struct kunit;
 
 /* Size of log associated with test. */
@@ -225,6 +153,8 @@ static inline char *kunit_status_to_ok_not_ok(enum kunit_status status)
  * struct kunit_suite - describes a related collection of &struct kunit_case
  *
  * @name:	the name of the test. Purely informational.
+ * @suite_init:	called once per test suite before the test cases.
+ * @suite_exit:	called once per test suite after all test cases.
  * @init:	called before every test case.
  * @exit:	called after every test case.
  * @test_cases:	a null terminated array of test cases.
@@ -239,6 +169,8 @@ static inline char *kunit_status_to_ok_not_ok(enum kunit_status status)
  */
 struct kunit_suite {
 	const char name[256];
+	int (*suite_init)(struct kunit_suite *suite);
+	void (*suite_exit)(struct kunit_suite *suite);
 	int (*init)(struct kunit *test);
 	void (*exit)(struct kunit *test);
 	struct kunit_case *test_cases;
@@ -247,6 +179,7 @@ struct kunit_suite {
 	char status_comment[KUNIT_STATUS_COMMENT_SIZE];
 	struct dentry *debugfs;
 	char *log;
+	int suite_init_err;
 };
 
 /**
@@ -380,237 +313,38 @@ static inline int kunit_run_all_tests(void)
 
 #define kunit_test_suite(suite)	kunit_test_suites(&suite)
 
-#define kunit_suite_for_each_test_case(suite, test_case)		\
-	for (test_case = suite->test_cases; test_case->run_case; test_case++)
-
-enum kunit_status kunit_suite_has_succeeded(struct kunit_suite *suite);
-
-/*
- * Like kunit_alloc_resource() below, but returns the struct kunit_resource
- * object that contains the allocation. This is mostly for testing purposes.
- */
-struct kunit_resource *kunit_alloc_and_get_resource(struct kunit *test,
-						    kunit_resource_init_t init,
-						    kunit_resource_free_t free,
-						    gfp_t internal_gfp,
-						    void *context);
-
-/**
- * kunit_get_resource() - Hold resource for use.  Should not need to be used
- *			  by most users as we automatically get resources
- *			  retrieved by kunit_find_resource*().
- * @res: resource
- */
-static inline void kunit_get_resource(struct kunit_resource *res)
-{
-	kref_get(&res->refcount);
-}
-
-/*
- * Called when refcount reaches zero via kunit_put_resources();
- * should not be called directly.
- */
-static inline void kunit_release_resource(struct kref *kref)
-{
-	struct kunit_resource *res = container_of(kref, struct kunit_resource,
-						  refcount);
-
-	/* If free function is defined, resource was dynamically allocated. */
-	if (res->free) {
-		res->free(res);
-		kfree(res);
-	}
-}
-
-/**
- * kunit_put_resource() - When caller is done with retrieved resource,
- *			  kunit_put_resource() should be called to drop
- *			  reference count.  The resource list maintains
- *			  a reference count on resources, so if no users
- *			  are utilizing a resource and it is removed from
- *			  the resource list, it will be freed via the
- *			  associated free function (if any).  Only
- *			  needs to be used if we alloc_and_get() or
- *			  find() resource.
- * @res: resource
- */
-static inline void kunit_put_resource(struct kunit_resource *res)
-{
-	kref_put(&res->refcount, kunit_release_resource);
-}
-
-/**
- * kunit_add_resource() - Add a *test managed resource*.
- * @test: The test context object.
- * @init: a user-supplied function to initialize the result (if needed).  If
- *        none is supplied, the resource data value is simply set to @data.
- *	  If an init function is supplied, @data is passed to it instead.
- * @free: a user-supplied function to free the resource (if needed).
- * @res: The resource.
- * @data: value to pass to init function or set in resource data field.
- */
-int kunit_add_resource(struct kunit *test,
-		       kunit_resource_init_t init,
-		       kunit_resource_free_t free,
-		       struct kunit_resource *res,
-		       void *data);
-
 /**
- * kunit_add_named_resource() - Add a named *test managed resource*.
- * @test: The test context object.
- * @init: a user-supplied function to initialize the resource data, if needed.
- * @free: a user-supplied function to free the resource data, if needed.
- * @res: The resource.
- * @name: name to be set for resource.
- * @data: value to pass to init function or set in resource data field.
- */
-int kunit_add_named_resource(struct kunit *test,
-			     kunit_resource_init_t init,
-			     kunit_resource_free_t free,
-			     struct kunit_resource *res,
-			     const char *name,
-			     void *data);
-
-/**
- * kunit_alloc_resource() - Allocates a *test managed resource*.
- * @test: The test context object.
- * @init: a user supplied function to initialize the resource.
- * @free: a user supplied function to free the resource.
- * @internal_gfp: gfp to use for internal allocations, if unsure, use GFP_KERNEL
- * @context: for the user to pass in arbitrary data to the init function.
- *
- * Allocates a *test managed resource*, a resource which will automatically be
- * cleaned up at the end of a test case. See &struct kunit_resource for an
- * example.
- *
- * Note: KUnit needs to allocate memory for a kunit_resource object. You must
- * specify an @internal_gfp that is compatible with the use context of your
- * resource.
- */
-static inline void *kunit_alloc_resource(struct kunit *test,
-					 kunit_resource_init_t init,
-					 kunit_resource_free_t free,
-					 gfp_t internal_gfp,
-					 void *context)
-{
-	struct kunit_resource *res;
-
-	res = kzalloc(sizeof(*res), internal_gfp);
-	if (!res)
-		return NULL;
-
-	if (!kunit_add_resource(test, init, free, res, context))
-		return res->data;
-
-	return NULL;
-}
-
-typedef bool (*kunit_resource_match_t)(struct kunit *test,
-				       struct kunit_resource *res,
-				       void *match_data);
-
-/**
- * kunit_resource_instance_match() - Match a resource with the same instance.
- * @test: Test case to which the resource belongs.
- * @res: The resource.
- * @match_data: The resource pointer to match against.
+ * kunit_test_init_section_suites() - used to register one or more &struct
+ *				      kunit_suite containing init functions or
+ *				      init data.
  *
- * An instance of kunit_resource_match_t that matches a resource whose
- * allocation matches @match_data.
- */
-static inline bool kunit_resource_instance_match(struct kunit *test,
-						 struct kunit_resource *res,
-						 void *match_data)
-{
-	return res->data == match_data;
-}
-
-/**
- * kunit_resource_name_match() - Match a resource with the same name.
- * @test: Test case to which the resource belongs.
- * @res: The resource.
- * @match_name: The name to match against.
- */
-static inline bool kunit_resource_name_match(struct kunit *test,
-					     struct kunit_resource *res,
-					     void *match_name)
-{
-	return res->name && strcmp(res->name, match_name) == 0;
-}
-
-/**
- * kunit_find_resource() - Find a resource using match function/data.
- * @test: Test case to which the resource belongs.
- * @match: match function to be applied to resources/match data.
- * @match_data: data to be used in matching.
- */
-static inline struct kunit_resource *
-kunit_find_resource(struct kunit *test,
-		    kunit_resource_match_t match,
-		    void *match_data)
-{
-	struct kunit_resource *res, *found = NULL;
-	unsigned long flags;
-
-	spin_lock_irqsave(&test->lock, flags);
-
-	list_for_each_entry_reverse(res, &test->resources, node) {
-		if (match(test, res, (void *)match_data)) {
-			found = res;
-			kunit_get_resource(found);
-			break;
-		}
-	}
-
-	spin_unlock_irqrestore(&test->lock, flags);
-
-	return found;
-}
-
-/**
- * kunit_find_named_resource() - Find a resource using match name.
- * @test: Test case to which the resource belongs.
- * @name: match name.
- */
-static inline struct kunit_resource *
-kunit_find_named_resource(struct kunit *test,
-			  const char *name)
-{
-	return kunit_find_resource(test, kunit_resource_name_match,
-				   (void *)name);
-}
-
-/**
- * kunit_destroy_resource() - Find a kunit_resource and destroy it.
- * @test: Test case to which the resource belongs.
- * @match: Match function. Returns whether a given resource matches @match_data.
- * @match_data: Data passed into @match.
+ * @__suites: a statically allocated list of &struct kunit_suite.
  *
- * RETURNS:
- * 0 if kunit_resource is found and freed, -ENOENT if not found.
+ * This functions identically as &kunit_test_suites() except that it suppresses
+ * modpost warnings for referencing functions marked __init or data marked
+ * __initdata; this is OK because currently KUnit only runs tests upon boot
+ * during the init phase or upon loading a module during the init phase.
+ *
+ * NOTE TO KUNIT DEVS: If we ever allow KUnit tests to be run after boot, these
+ * tests must be excluded.
+ *
+ * The only thing this macro does that's different from kunit_test_suites is
+ * that it suffixes the array and suite declarations it makes with _probe;
+ * modpost suppresses warnings about referencing init data for symbols named in
+ * this manner.
  */
-int kunit_destroy_resource(struct kunit *test,
-			   kunit_resource_match_t match,
-			   void *match_data);
+#define kunit_test_init_section_suites(__suites...)			\
+	__kunit_test_suites(CONCATENATE(__UNIQUE_ID(array), _probe),	\
+			    CONCATENATE(__UNIQUE_ID(suites), _probe),	\
+			    ##__suites)
 
-static inline int kunit_destroy_named_resource(struct kunit *test,
-					       const char *name)
-{
-	return kunit_destroy_resource(test, kunit_resource_name_match,
-				      (void *)name);
-}
+#define kunit_test_init_section_suite(suite)	\
+	kunit_test_init_section_suites(&suite)
 
-/**
- * kunit_remove_resource() - remove resource from resource list associated with
- *			     test.
- * @test: The test context object.
- * @res: The resource to be removed.
- *
- * Note that the resource will not be immediately freed since it is likely
- * the caller has a reference to it via alloc_and_get() or find();
- * in this case a final call to kunit_put_resource() is required.
- */
-void kunit_remove_resource(struct kunit *test, struct kunit_resource *res);
+#define kunit_suite_for_each_test_case(suite, test_case)		\
+	for (test_case = suite->test_cases; test_case->run_case; test_case++)
+
+enum kunit_status kunit_suite_has_succeeded(struct kunit_suite *suite);
 
 /**
  * kunit_kmalloc_array() - Like kmalloc_array() except the allocation is *test managed*.
@@ -774,7 +508,7 @@ void __printf(2, 3) kunit_log_append(char *log, const char *fmt, ...);
 void kunit_do_failed_assertion(struct kunit *test,
 			       const struct kunit_loc *loc,
 			       enum kunit_assert_type type,
-			       struct kunit_assert *assert,
+			       const struct kunit_assert *assert,
 			       const char *fmt, ...);
 
 #define KUNIT_ASSERTION(test, assert_type, pass, assert_class, INITIALIZER, fmt, ...) do { \
@@ -1218,6 +952,48 @@ do {									       \
 				   fmt,					       \
 				   ##__VA_ARGS__)
 
+/**
+ * KUNIT_EXPECT_NULL() - Expects that @ptr is null.
+ * @test: The test context object.
+ * @ptr: an arbitrary pointer.
+ *
+ * Sets an expectation that the value that @ptr evaluates to is null. This is
+ * semantically equivalent to KUNIT_EXPECT_PTR_EQ(@test, ptr, NULL).
+ * See KUNIT_EXPECT_TRUE() for more information.
+ */
+#define KUNIT_EXPECT_NULL(test, ptr)				               \
+	KUNIT_EXPECT_NULL_MSG(test,					       \
+			      ptr,					       \
+			      NULL)
+
+#define KUNIT_EXPECT_NULL_MSG(test, ptr, fmt, ...)	                       \
+	KUNIT_BINARY_PTR_ASSERTION(test,				       \
+				   KUNIT_EXPECTATION,			       \
+				   ptr, ==, NULL,			       \
+				   fmt,					       \
+				   ##__VA_ARGS__)
+
+/**
+ * KUNIT_EXPECT_NOT_NULL() - Expects that @ptr is not null.
+ * @test: The test context object.
+ * @ptr: an arbitrary pointer.
+ *
+ * Sets an expectation that the value that @ptr evaluates to is not null. This
+ * is semantically equivalent to KUNIT_EXPECT_PTR_NE(@test, ptr, NULL).
+ * See KUNIT_EXPECT_TRUE() for more information.
+ */
+#define KUNIT_EXPECT_NOT_NULL(test, ptr)			               \
+	KUNIT_EXPECT_NOT_NULL_MSG(test,					       \
+				  ptr,					       \
+				  NULL)
+
+#define KUNIT_EXPECT_NOT_NULL_MSG(test, ptr, fmt, ...)	                       \
+	KUNIT_BINARY_PTR_ASSERTION(test,				       \
+				   KUNIT_EXPECTATION,			       \
+				   ptr, !=, NULL,			       \
+				   fmt,					       \
+				   ##__VA_ARGS__)
+
 /**
  * KUNIT_EXPECT_NOT_ERR_OR_NULL() - Expects that @ptr is not null and not err.
  * @test: The test context object.
@@ -1485,6 +1261,48 @@ do {									       \
 				   fmt,					       \
 				   ##__VA_ARGS__)
 
+/**
+ * KUNIT_ASSERT_NULL() - Asserts that pointers @ptr is null.
+ * @test: The test context object.
+ * @ptr: an arbitrary pointer.
+ *
+ * Sets an assertion that the values that @ptr evaluates to is null. This is
+ * the same as KUNIT_EXPECT_NULL(), except it causes an assertion
+ * failure (see KUNIT_ASSERT_TRUE()) when the assertion is not met.
+ */
+#define KUNIT_ASSERT_NULL(test, ptr) \
+	KUNIT_ASSERT_NULL_MSG(test,					       \
+			      ptr,					       \
+			      NULL)
+
+#define KUNIT_ASSERT_NULL_MSG(test, ptr, fmt, ...) \
+	KUNIT_BINARY_PTR_ASSERTION(test,				       \
+				   KUNIT_ASSERTION,			       \
+				   ptr, ==, NULL,			       \
+				   fmt,					       \
+				   ##__VA_ARGS__)
+
+/**
+ * KUNIT_ASSERT_NOT_NULL() - Asserts that pointers @ptr is not null.
+ * @test: The test context object.
+ * @ptr: an arbitrary pointer.
+ *
+ * Sets an assertion that the values that @ptr evaluates to is not null. This
+ * is the same as KUNIT_EXPECT_NOT_NULL(), except it causes an assertion
+ * failure (see KUNIT_ASSERT_TRUE()) when the assertion is not met.
+ */
+#define KUNIT_ASSERT_NOT_NULL(test, ptr) \
+	KUNIT_ASSERT_NOT_NULL_MSG(test,					       \
+				  ptr,					       \
+				  NULL)
+
+#define KUNIT_ASSERT_NOT_NULL_MSG(test, ptr, fmt, ...) \
+	KUNIT_BINARY_PTR_ASSERTION(test,				       \
+				   KUNIT_ASSERTION,			       \
+				   ptr, !=, NULL,			       \
+				   fmt,					       \
+				   ##__VA_ARGS__)
+
 /**
  * KUNIT_ASSERT_NOT_ERR_OR_NULL() - Assertion that @ptr is not null and not err.
  * @test: The test context object.
@@ -1526,4 +1344,8 @@ do {									       \
 		return NULL;									\
 	}
 
+// TODO(dlatypov@google.com): consider eventually migrating users to explicitly
+// include resource.h themselves if they need it.
+#include <kunit/resource.h>
+
 #endif /* _KUNIT_TEST_H */
diff --git a/kernel/kcsan/kcsan_test.c b/kernel/kcsan/kcsan_test.c
index a36fca063a73..59560b5e1d9c 100644
--- a/kernel/kcsan/kcsan_test.c
+++ b/kernel/kcsan/kcsan_test.c
@@ -1565,14 +1565,6 @@ static void test_exit(struct kunit *test)
 	torture_cleanup_end();
 }
 
-static struct kunit_suite kcsan_test_suite = {
-	.name = "kcsan",
-	.test_cases = kcsan_test_cases,
-	.init = test_init,
-	.exit = test_exit,
-};
-static struct kunit_suite *kcsan_test_suites[] = { &kcsan_test_suite, NULL };
-
 __no_kcsan
 static void register_tracepoints(struct tracepoint *tp, void *ignore)
 {
@@ -1588,11 +1580,7 @@ static void unregister_tracepoints(struct tracepoint *tp, void *ignore)
 		tracepoint_probe_unregister(tp, probe_console, NULL);
 }
 
-/*
- * We only want to do tracepoints setup and teardown once, therefore we have to
- * customize the init and exit functions and cannot rely on kunit_test_suite().
- */
-static int __init kcsan_test_init(void)
+static int kcsan_suite_init(struct kunit_suite *suite)
 {
 	/*
 	 * Because we want to be able to build the test as a module, we need to
@@ -1600,18 +1588,25 @@ static int __init kcsan_test_init(void)
 	 * won't work here.
 	 */
 	for_each_kernel_tracepoint(register_tracepoints, NULL);
-	return __kunit_test_suites_init(kcsan_test_suites);
+	return 0;
 }
 
-static void kcsan_test_exit(void)
+static void kcsan_suite_exit(struct kunit_suite *suite)
 {
-	__kunit_test_suites_exit(kcsan_test_suites);
 	for_each_kernel_tracepoint(unregister_tracepoints, NULL);
 	tracepoint_synchronize_unregister();
 }
 
-late_initcall_sync(kcsan_test_init);
-module_exit(kcsan_test_exit);
+static struct kunit_suite kcsan_test_suite = {
+	.name = "kcsan",
+	.test_cases = kcsan_test_cases,
+	.init = test_init,
+	.exit = test_exit,
+	.suite_init = kcsan_suite_init,
+	.suite_exit = kcsan_suite_exit,
+};
+
+kunit_test_suites(&kcsan_test_suite);
 
 MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Marco Elver <elver@google.com>");
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 075cd25363ac..36865b37b33b 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2140,10 +2140,11 @@ config TEST_DIV64
 	  If unsure, say N.
 
 config KPROBES_SANITY_TEST
-	tristate "Kprobes sanity tests"
+	tristate "Kprobes sanity tests" if !KUNIT_ALL_TESTS
 	depends on DEBUG_KERNEL
 	depends on KPROBES
 	depends on KUNIT
+	default KUNIT_ALL_TESTS
 	help
 	  This option provides for testing basic kprobes functionality on
 	  boot. Samples of kprobe and kretprobe are inserted and
@@ -2417,8 +2418,9 @@ config TEST_SYSCTL
 	  If unsure, say N.
 
 config BITFIELD_KUNIT
-	tristate "KUnit test bitfield functions at runtime"
+	tristate "KUnit test bitfield functions at runtime" if !KUNIT_ALL_TESTS
 	depends on KUNIT
+	default KUNIT_ALL_TESTS
 	help
 	  Enable this option to test the bitfield functions at boot.
 
@@ -2452,8 +2454,9 @@ config HASH_KUNIT_TEST
 	  optimized versions. If unsure, say N.
 
 config RESOURCE_KUNIT_TEST
-	tristate "KUnit test for resource API"
+	tristate "KUnit test for resource API" if !KUNIT_ALL_TESTS
 	depends on KUNIT
+	default KUNIT_ALL_TESTS
 	help
 	  This builds the resource API unit test.
 	  Tests the logic of API provided by resource.c and ioport.h.
@@ -2506,8 +2509,9 @@ config LINEAR_RANGES_TEST
 	  If unsure, say N.
 
 config CMDLINE_KUNIT_TEST
-	tristate "KUnit test for cmdline API"
+	tristate "KUnit test for cmdline API" if !KUNIT_ALL_TESTS
 	depends on KUNIT
+	default KUNIT_ALL_TESTS
 	help
 	  This builds the cmdline API unit test.
 	  Tests the logic of API provided by cmdline.c.
@@ -2517,8 +2521,9 @@ config CMDLINE_KUNIT_TEST
 	  If unsure, say N.
 
 config BITS_TEST
-	tristate "KUnit test for bits.h"
+	tristate "KUnit test for bits.h" if !KUNIT_ALL_TESTS
 	depends on KUNIT
+	default KUNIT_ALL_TESTS
 	help
 	  This builds the bits unit test.
 	  Tests the logic of macros defined in bits.h.
diff --git a/lib/kunit/Makefile b/lib/kunit/Makefile
index c49f4ffb6273..29aff6562b42 100644
--- a/lib/kunit/Makefile
+++ b/lib/kunit/Makefile
@@ -1,6 +1,7 @@
 obj-$(CONFIG_KUNIT) +=			kunit.o
 
 kunit-objs +=				test.o \
+					resource.o \
 					string-stream.o \
 					assert.o \
 					try-catch.o \
diff --git a/lib/kunit/debugfs.c b/lib/kunit/debugfs.c
index b71db0abc12b..1048ef1b8d6e 100644
--- a/lib/kunit/debugfs.c
+++ b/lib/kunit/debugfs.c
@@ -52,7 +52,7 @@ static void debugfs_print_result(struct seq_file *seq,
 static int debugfs_print_results(struct seq_file *seq, void *v)
 {
 	struct kunit_suite *suite = (struct kunit_suite *)seq->private;
-	bool success = kunit_suite_has_succeeded(suite);
+	enum kunit_status success = kunit_suite_has_succeeded(suite);
 	struct kunit_case *test_case;
 
 	if (!suite || !suite->log)
diff --git a/lib/kunit/executor.c b/lib/kunit/executor.c
index 22640c9ee819..96f96e42ce06 100644
--- a/lib/kunit/executor.c
+++ b/lib/kunit/executor.c
@@ -71,9 +71,13 @@ kunit_filter_tests(struct kunit_suite *const suite, const char *test_glob)
 
 	/* Use memcpy to workaround copy->name being const. */
 	copy = kmalloc(sizeof(*copy), GFP_KERNEL);
+	if (!copy)
+		return ERR_PTR(-ENOMEM);
 	memcpy(copy, suite, sizeof(*copy));
 
 	filtered = kcalloc(n + 1, sizeof(*filtered), GFP_KERNEL);
+	if (!filtered)
+		return ERR_PTR(-ENOMEM);
 
 	n = 0;
 	kunit_suite_for_each_test_case(suite, test_case) {
@@ -106,14 +110,16 @@ kunit_filter_subsuite(struct kunit_suite * const * const subsuite,
 
 	filtered = kmalloc_array(n + 1, sizeof(*filtered), GFP_KERNEL);
 	if (!filtered)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 
 	n = 0;
 	for (i = 0; subsuite[i] != NULL; ++i) {
 		if (!glob_match(filter->suite_glob, subsuite[i]->name))
 			continue;
 		filtered_suite = kunit_filter_tests(subsuite[i], filter->test_glob);
-		if (filtered_suite)
+		if (IS_ERR(filtered_suite))
+			return ERR_CAST(filtered_suite);
+		else if (filtered_suite)
 			filtered[n++] = filtered_suite;
 	}
 	filtered[n] = NULL;
@@ -146,7 +152,8 @@ static void kunit_free_suite_set(struct suite_set suite_set)
 }
 
 static struct suite_set kunit_filter_suites(const struct suite_set *suite_set,
-					    const char *filter_glob)
+					    const char *filter_glob,
+					    int *err)
 {
 	int i;
 	struct kunit_suite * const **copy, * const *filtered_subsuite;
@@ -166,6 +173,10 @@ static struct suite_set kunit_filter_suites(const struct suite_set *suite_set,
 
 	for (i = 0; i < max; ++i) {
 		filtered_subsuite = kunit_filter_subsuite(suite_set->start[i], &filter);
+		if (IS_ERR(filtered_subsuite)) {
+			*err = PTR_ERR(filtered_subsuite);
+			return filtered;
+		}
 		if (filtered_subsuite)
 			*copy++ = filtered_subsuite;
 	}
@@ -236,9 +247,15 @@ int kunit_run_all_tests(void)
 		.start = __kunit_suites_start,
 		.end = __kunit_suites_end,
 	};
+	int err = 0;
 
-	if (filter_glob_param)
-		suite_set = kunit_filter_suites(&suite_set, filter_glob_param);
+	if (filter_glob_param) {
+		suite_set = kunit_filter_suites(&suite_set, filter_glob_param, &err);
+		if (err) {
+			pr_err("kunit executor: error filtering suites: %d\n", err);
+			goto out;
+		}
+	}
 
 	if (!action_param)
 		kunit_exec_run_tests(&suite_set);
@@ -251,9 +268,10 @@ int kunit_run_all_tests(void)
 		kunit_free_suite_set(suite_set);
 	}
 
-	kunit_handle_shutdown();
 
-	return 0;
+out:
+	kunit_handle_shutdown();
+	return err;
 }
 
 #if IS_BUILTIN(CONFIG_KUNIT_TEST)
diff --git a/lib/kunit/executor_test.c b/lib/kunit/executor_test.c
index 4ed57fd94e42..eac6ff480273 100644
--- a/lib/kunit/executor_test.c
+++ b/lib/kunit/executor_test.c
@@ -137,14 +137,16 @@ static void filter_suites_test(struct kunit *test)
 		.end = suites + 2,
 	};
 	struct suite_set filtered = {.start = NULL, .end = NULL};
+	int err = 0;
 
 	/* Emulate two files, each having one suite */
 	subsuites[0][0] = alloc_fake_suite(test, "suite0", dummy_test_cases);
 	subsuites[1][0] = alloc_fake_suite(test, "suite1", dummy_test_cases);
 
 	/* Filter out suite1 */
-	filtered = kunit_filter_suites(&suite_set, "suite0");
+	filtered = kunit_filter_suites(&suite_set, "suite0", &err);
 	kfree_subsuites_at_end(test, &filtered); /* let us use ASSERTs without leaking */
+	KUNIT_EXPECT_EQ(test, err, 0);
 	KUNIT_ASSERT_EQ(test, filtered.end - filtered.start, (ptrdiff_t)1);
 
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, filtered.start);
diff --git a/lib/kunit/kunit-example-test.c b/lib/kunit/kunit-example-test.c
index 4bbf37c04eba..f8fe582c9e36 100644
--- a/lib/kunit/kunit-example-test.c
+++ b/lib/kunit/kunit-example-test.c
@@ -40,6 +40,17 @@ static int example_test_init(struct kunit *test)
 	return 0;
 }
 
+/*
+ * This is run once before all test cases in the suite.
+ * See the comment on example_test_suite for more information.
+ */
+static int example_test_init_suite(struct kunit_suite *suite)
+{
+	kunit_info(suite, "initializing suite\n");
+
+	return 0;
+}
+
 /*
  * This test should always be skipped.
  */
@@ -91,6 +102,8 @@ static void example_all_expect_macros_test(struct kunit *test)
 	KUNIT_EXPECT_NOT_ERR_OR_NULL(test, test);
 	KUNIT_EXPECT_PTR_EQ(test, NULL, NULL);
 	KUNIT_EXPECT_PTR_NE(test, test, NULL);
+	KUNIT_EXPECT_NULL(test, NULL);
+	KUNIT_EXPECT_NOT_NULL(test, test);
 
 	/* String assertions */
 	KUNIT_EXPECT_STREQ(test, "hi", "hi");
@@ -140,17 +153,20 @@ static struct kunit_case example_test_cases[] = {
  * may be specified which runs after every test case and can be used to for
  * cleanup. For clarity, running tests in a test suite would behave as follows:
  *
+ * suite.suite_init(suite);
  * suite.init(test);
  * suite.test_case[0](test);
  * suite.exit(test);
  * suite.init(test);
  * suite.test_case[1](test);
  * suite.exit(test);
+ * suite.suite_exit(suite);
  * ...;
  */
 static struct kunit_suite example_test_suite = {
 	.name = "example",
 	.init = example_test_init,
+	.suite_init = example_test_init_suite,
 	.test_cases = example_test_cases,
 };
 
diff --git a/lib/kunit/kunit-test.c b/lib/kunit/kunit-test.c
index 555601d17f79..13d0bd8b07a9 100644
--- a/lib/kunit/kunit-test.c
+++ b/lib/kunit/kunit-test.c
@@ -190,6 +190,40 @@ static void kunit_resource_test_destroy_resource(struct kunit *test)
 	KUNIT_EXPECT_TRUE(test, list_empty(&ctx->test.resources));
 }
 
+static void kunit_resource_test_remove_resource(struct kunit *test)
+{
+	struct kunit_test_resource_context *ctx = test->priv;
+	struct kunit_resource *res = kunit_alloc_and_get_resource(
+			&ctx->test,
+			fake_resource_init,
+			fake_resource_free,
+			GFP_KERNEL,
+			ctx);
+
+	/* The resource is in the list */
+	KUNIT_EXPECT_FALSE(test, list_empty(&ctx->test.resources));
+
+	/* Remove the resource. The pointer is still valid, but it can't be
+	 * found.
+	 */
+	kunit_remove_resource(test, res);
+	KUNIT_EXPECT_TRUE(test, list_empty(&ctx->test.resources));
+	/* We haven't been freed yet. */
+	KUNIT_EXPECT_TRUE(test, ctx->is_resource_initialized);
+
+	/* Removing the resource multiple times is valid. */
+	kunit_remove_resource(test, res);
+	KUNIT_EXPECT_TRUE(test, list_empty(&ctx->test.resources));
+	/* Despite having been removed twice (from only one reference), the
+	 * resource still has not been freed.
+	 */
+	KUNIT_EXPECT_TRUE(test, ctx->is_resource_initialized);
+
+	/* Free the resource. */
+	kunit_put_resource(res);
+	KUNIT_EXPECT_FALSE(test, ctx->is_resource_initialized);
+}
+
 static void kunit_resource_test_cleanup_resources(struct kunit *test)
 {
 	int i;
@@ -387,6 +421,7 @@ static struct kunit_case kunit_resource_test_cases[] = {
 	KUNIT_CASE(kunit_resource_test_init_resources),
 	KUNIT_CASE(kunit_resource_test_alloc_resource),
 	KUNIT_CASE(kunit_resource_test_destroy_resource),
+	KUNIT_CASE(kunit_resource_test_remove_resource),
 	KUNIT_CASE(kunit_resource_test_cleanup_resources),
 	KUNIT_CASE(kunit_resource_test_proper_free_ordering),
 	KUNIT_CASE(kunit_resource_test_static),
@@ -435,7 +470,7 @@ static void kunit_log_test(struct kunit *test)
 	KUNIT_EXPECT_NOT_ERR_OR_NULL(test,
 				     strstr(suite.log, "along with this."));
 #else
-	KUNIT_EXPECT_PTR_EQ(test, test->log, (char *)NULL);
+	KUNIT_EXPECT_NULL(test, test->log);
 #endif
 }
 
diff --git a/lib/kunit/resource.c b/lib/kunit/resource.c
new file mode 100644
index 000000000000..c414df922f34
--- /dev/null
+++ b/lib/kunit/resource.c
@@ -0,0 +1,79 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * KUnit resource API for test managed resources (allocations, etc.).
+ *
+ * Copyright (C) 2022, Google LLC.
+ * Author: Daniel Latypov <dlatypov@google.com>
+ */
+
+#include <kunit/resource.h>
+#include <kunit/test.h>
+#include <linux/kref.h>
+
+/*
+ * Used for static resources and when a kunit_resource * has been created by
+ * kunit_alloc_resource().  When an init function is supplied, @data is passed
+ * into the init function; otherwise, we simply set the resource data field to
+ * the data value passed in. Doesn't initialize res->should_kfree.
+ */
+int __kunit_add_resource(struct kunit *test,
+			 kunit_resource_init_t init,
+			 kunit_resource_free_t free,
+			 struct kunit_resource *res,
+			 void *data)
+{
+	int ret = 0;
+	unsigned long flags;
+
+	res->free = free;
+	kref_init(&res->refcount);
+
+	if (init) {
+		ret = init(res, data);
+		if (ret)
+			return ret;
+	} else {
+		res->data = data;
+	}
+
+	spin_lock_irqsave(&test->lock, flags);
+	list_add_tail(&res->node, &test->resources);
+	/* refcount for list is established by kref_init() */
+	spin_unlock_irqrestore(&test->lock, flags);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(__kunit_add_resource);
+
+void kunit_remove_resource(struct kunit *test, struct kunit_resource *res)
+{
+	unsigned long flags;
+	bool was_linked;
+
+	spin_lock_irqsave(&test->lock, flags);
+	was_linked = !list_empty(&res->node);
+	list_del_init(&res->node);
+	spin_unlock_irqrestore(&test->lock, flags);
+
+	if (was_linked)
+		kunit_put_resource(res);
+}
+EXPORT_SYMBOL_GPL(kunit_remove_resource);
+
+int kunit_destroy_resource(struct kunit *test, kunit_resource_match_t match,
+			   void *match_data)
+{
+	struct kunit_resource *res = kunit_find_resource(test, match,
+							 match_data);
+
+	if (!res)
+		return -ENOENT;
+
+	kunit_remove_resource(test, res);
+
+	/* We have a reference also via _find(); drop it. */
+	kunit_put_resource(res);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(kunit_destroy_resource);
diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index 3bca3bf5c15b..a5053a07409f 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -6,10 +6,10 @@
  * Author: Brendan Higgins <brendanhiggins@google.com>
  */
 
+#include <kunit/resource.h>
 #include <kunit/test.h>
 #include <kunit/test-bug.h>
 #include <linux/kernel.h>
-#include <linux/kref.h>
 #include <linux/moduleparam.h>
 #include <linux/sched/debug.h>
 #include <linux/sched.h>
@@ -134,7 +134,7 @@ size_t kunit_suite_num_test_cases(struct kunit_suite *suite)
 }
 EXPORT_SYMBOL_GPL(kunit_suite_num_test_cases);
 
-static void kunit_print_subtest_start(struct kunit_suite *suite)
+static void kunit_print_suite_start(struct kunit_suite *suite)
 {
 	kunit_log(KERN_INFO, suite, KUNIT_SUBTEST_INDENT "# Subtest: %s",
 		  suite->name);
@@ -179,6 +179,9 @@ enum kunit_status kunit_suite_has_succeeded(struct kunit_suite *suite)
 	const struct kunit_case *test_case;
 	enum kunit_status status = KUNIT_SKIPPED;
 
+	if (suite->suite_init_err)
+		return KUNIT_FAILURE;
+
 	kunit_suite_for_each_test_case(suite, test_case) {
 		if (test_case->status == KUNIT_FAILURE)
 			return KUNIT_FAILURE;
@@ -192,7 +195,7 @@ EXPORT_SYMBOL_GPL(kunit_suite_has_succeeded);
 
 static size_t kunit_suite_counter = 1;
 
-static void kunit_print_subtest_end(struct kunit_suite *suite)
+static void kunit_print_suite_end(struct kunit_suite *suite)
 {
 	kunit_print_ok_not_ok((void *)suite, false,
 			      kunit_suite_has_succeeded(suite),
@@ -241,7 +244,7 @@ static void kunit_print_string_stream(struct kunit *test,
 }
 
 static void kunit_fail(struct kunit *test, const struct kunit_loc *loc,
-		       enum kunit_assert_type type, struct kunit_assert *assert,
+		       enum kunit_assert_type type, const struct kunit_assert *assert,
 		       const struct va_format *message)
 {
 	struct string_stream *stream;
@@ -281,7 +284,7 @@ static void __noreturn kunit_abort(struct kunit *test)
 void kunit_do_failed_assertion(struct kunit *test,
 			       const struct kunit_loc *loc,
 			       enum kunit_assert_type type,
-			       struct kunit_assert *assert,
+			       const struct kunit_assert *assert,
 			       const char *fmt, ...)
 {
 	va_list args;
@@ -498,7 +501,16 @@ int kunit_run_tests(struct kunit_suite *suite)
 	struct kunit_result_stats suite_stats = { 0 };
 	struct kunit_result_stats total_stats = { 0 };
 
-	kunit_print_subtest_start(suite);
+	if (suite->suite_init) {
+		suite->suite_init_err = suite->suite_init(suite);
+		if (suite->suite_init_err) {
+			kunit_err(suite, KUNIT_SUBTEST_INDENT
+				  "# failed to initialize (%d)", suite->suite_init_err);
+			goto suite_end;
+		}
+	}
+
+	kunit_print_suite_start(suite);
 
 	kunit_suite_for_each_test_case(suite, test_case) {
 		struct kunit test = { .param_value = NULL, .param_index = 0 };
@@ -551,8 +563,12 @@ int kunit_run_tests(struct kunit_suite *suite)
 		kunit_accumulate_stats(&total_stats, param_stats);
 	}
 
+	if (suite->suite_exit)
+		suite->suite_exit(suite);
+
 	kunit_print_suite_stats(suite, suite_stats, total_stats);
-	kunit_print_subtest_end(suite);
+suite_end:
+	kunit_print_suite_end(suite);
 
 	return 0;
 }
@@ -562,6 +578,7 @@ static void kunit_init_suite(struct kunit_suite *suite)
 {
 	kunit_debugfs_create_suite(suite);
 	suite->status_comment[0] = '\0';
+	suite->suite_init_err = 0;
 }
 
 int __kunit_test_suites_init(struct kunit_suite * const * const suites)
@@ -592,120 +609,6 @@ void __kunit_test_suites_exit(struct kunit_suite **suites)
 }
 EXPORT_SYMBOL_GPL(__kunit_test_suites_exit);
 
-/*
- * Used for static resources and when a kunit_resource * has been created by
- * kunit_alloc_resource().  When an init function is supplied, @data is passed
- * into the init function; otherwise, we simply set the resource data field to
- * the data value passed in.
- */
-int kunit_add_resource(struct kunit *test,
-		       kunit_resource_init_t init,
-		       kunit_resource_free_t free,
-		       struct kunit_resource *res,
-		       void *data)
-{
-	int ret = 0;
-	unsigned long flags;
-
-	res->free = free;
-	kref_init(&res->refcount);
-
-	if (init) {
-		ret = init(res, data);
-		if (ret)
-			return ret;
-	} else {
-		res->data = data;
-	}
-
-	spin_lock_irqsave(&test->lock, flags);
-	list_add_tail(&res->node, &test->resources);
-	/* refcount for list is established by kref_init() */
-	spin_unlock_irqrestore(&test->lock, flags);
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(kunit_add_resource);
-
-int kunit_add_named_resource(struct kunit *test,
-			     kunit_resource_init_t init,
-			     kunit_resource_free_t free,
-			     struct kunit_resource *res,
-			     const char *name,
-			     void *data)
-{
-	struct kunit_resource *existing;
-
-	if (!name)
-		return -EINVAL;
-
-	existing = kunit_find_named_resource(test, name);
-	if (existing) {
-		kunit_put_resource(existing);
-		return -EEXIST;
-	}
-
-	res->name = name;
-
-	return kunit_add_resource(test, init, free, res, data);
-}
-EXPORT_SYMBOL_GPL(kunit_add_named_resource);
-
-struct kunit_resource *kunit_alloc_and_get_resource(struct kunit *test,
-						    kunit_resource_init_t init,
-						    kunit_resource_free_t free,
-						    gfp_t internal_gfp,
-						    void *data)
-{
-	struct kunit_resource *res;
-	int ret;
-
-	res = kzalloc(sizeof(*res), internal_gfp);
-	if (!res)
-		return NULL;
-
-	ret = kunit_add_resource(test, init, free, res, data);
-	if (!ret) {
-		/*
-		 * bump refcount for get; kunit_resource_put() should be called
-		 * when done.
-		 */
-		kunit_get_resource(res);
-		return res;
-	}
-	return NULL;
-}
-EXPORT_SYMBOL_GPL(kunit_alloc_and_get_resource);
-
-void kunit_remove_resource(struct kunit *test, struct kunit_resource *res)
-{
-	unsigned long flags;
-
-	spin_lock_irqsave(&test->lock, flags);
-	list_del(&res->node);
-	spin_unlock_irqrestore(&test->lock, flags);
-	kunit_put_resource(res);
-}
-EXPORT_SYMBOL_GPL(kunit_remove_resource);
-
-int kunit_destroy_resource(struct kunit *test, kunit_resource_match_t match,
-			   void *match_data)
-{
-	struct kunit_resource *res = kunit_find_resource(test, match,
-							 match_data);
-
-	if (!res)
-		return -ENOENT;
-
-	kunit_remove_resource(test, res);
-
-	/* We have a reference also via _find(); drop it. */
-	kunit_put_resource(res);
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(kunit_destroy_resource);
-
 struct kunit_kmalloc_array_params {
 	size_t n;
 	size_t size;
diff --git a/lib/list-test.c b/lib/list-test.c
index 035ef6597640..d374cf5d1a57 100644
--- a/lib/list-test.c
+++ b/lib/list-test.c
@@ -804,6 +804,401 @@ static struct kunit_suite list_test_module = {
 	.test_cases = list_test_cases,
 };
 
-kunit_test_suites(&list_test_module);
+struct hlist_test_struct {
+	int data;
+	struct hlist_node list;
+};
+
+static void hlist_test_init(struct kunit *test)
+{
+	/* Test the different ways of initialising a list. */
+	struct hlist_head list1 = HLIST_HEAD_INIT;
+	struct hlist_head list2;
+	HLIST_HEAD(list3);
+	struct hlist_head *list4;
+	struct hlist_head *list5;
+
+	INIT_HLIST_HEAD(&list2);
+
+	list4 = kzalloc(sizeof(*list4), GFP_KERNEL | __GFP_NOFAIL);
+	INIT_HLIST_HEAD(list4);
+
+	list5 = kmalloc(sizeof(*list5), GFP_KERNEL | __GFP_NOFAIL);
+	memset(list5, 0xFF, sizeof(*list5));
+	INIT_HLIST_HEAD(list5);
+
+	KUNIT_EXPECT_TRUE(test, hlist_empty(&list1));
+	KUNIT_EXPECT_TRUE(test, hlist_empty(&list2));
+	KUNIT_EXPECT_TRUE(test, hlist_empty(&list3));
+	KUNIT_EXPECT_TRUE(test, hlist_empty(list4));
+	KUNIT_EXPECT_TRUE(test, hlist_empty(list5));
+
+	kfree(list4);
+	kfree(list5);
+}
+
+static void hlist_test_unhashed(struct kunit *test)
+{
+	struct hlist_node a;
+	HLIST_HEAD(list);
+
+	INIT_HLIST_NODE(&a);
+
+	/* is unhashed by default */
+	KUNIT_EXPECT_TRUE(test, hlist_unhashed(&a));
+
+	hlist_add_head(&a, &list);
+
+	/* is hashed once added to list */
+	KUNIT_EXPECT_FALSE(test, hlist_unhashed(&a));
+
+	hlist_del_init(&a);
+
+	/* is again unhashed after del_init */
+	KUNIT_EXPECT_TRUE(test, hlist_unhashed(&a));
+}
+
+/* Doesn't test concurrency guarantees */
+static void hlist_test_unhashed_lockless(struct kunit *test)
+{
+	struct hlist_node a;
+	HLIST_HEAD(list);
+
+	INIT_HLIST_NODE(&a);
+
+	/* is unhashed by default */
+	KUNIT_EXPECT_TRUE(test, hlist_unhashed_lockless(&a));
+
+	hlist_add_head(&a, &list);
+
+	/* is hashed once added to list */
+	KUNIT_EXPECT_FALSE(test, hlist_unhashed_lockless(&a));
+
+	hlist_del_init(&a);
+
+	/* is again unhashed after del_init */
+	KUNIT_EXPECT_TRUE(test, hlist_unhashed_lockless(&a));
+}
+
+static void hlist_test_del(struct kunit *test)
+{
+	struct hlist_node a, b;
+	HLIST_HEAD(list);
+
+	hlist_add_head(&a, &list);
+	hlist_add_behind(&b, &a);
+
+	/* before: [list] -> a -> b */
+	hlist_del(&a);
+
+	/* now: [list] -> b */
+	KUNIT_EXPECT_PTR_EQ(test, list.first, &b);
+	KUNIT_EXPECT_PTR_EQ(test, b.pprev, &list.first);
+}
+
+static void hlist_test_del_init(struct kunit *test)
+{
+	struct hlist_node a, b;
+	HLIST_HEAD(list);
+
+	hlist_add_head(&a, &list);
+	hlist_add_behind(&b, &a);
+
+	/* before: [list] -> a -> b */
+	hlist_del_init(&a);
+
+	/* now: [list] -> b */
+	KUNIT_EXPECT_PTR_EQ(test, list.first, &b);
+	KUNIT_EXPECT_PTR_EQ(test, b.pprev, &list.first);
+
+	/* a is now initialised */
+	KUNIT_EXPECT_PTR_EQ(test, a.next, NULL);
+	KUNIT_EXPECT_PTR_EQ(test, a.pprev, NULL);
+}
+
+/* Tests all three hlist_add_* functions */
+static void hlist_test_add(struct kunit *test)
+{
+	struct hlist_node a, b, c, d;
+	HLIST_HEAD(list);
+
+	hlist_add_head(&a, &list);
+	hlist_add_head(&b, &list);
+	hlist_add_before(&c, &a);
+	hlist_add_behind(&d, &a);
+
+	/* should be [list] -> b -> c -> a -> d */
+	KUNIT_EXPECT_PTR_EQ(test, list.first, &b);
+
+	KUNIT_EXPECT_PTR_EQ(test, c.pprev, &(b.next));
+	KUNIT_EXPECT_PTR_EQ(test, b.next, &c);
+
+	KUNIT_EXPECT_PTR_EQ(test, a.pprev, &(c.next));
+	KUNIT_EXPECT_PTR_EQ(test, c.next, &a);
+
+	KUNIT_EXPECT_PTR_EQ(test, d.pprev, &(a.next));
+	KUNIT_EXPECT_PTR_EQ(test, a.next, &d);
+}
+
+/* Tests both hlist_fake() and hlist_add_fake() */
+static void hlist_test_fake(struct kunit *test)
+{
+	struct hlist_node a;
+
+	INIT_HLIST_NODE(&a);
+
+	/* not fake after init */
+	KUNIT_EXPECT_FALSE(test, hlist_fake(&a));
+
+	hlist_add_fake(&a);
+
+	/* is now fake */
+	KUNIT_EXPECT_TRUE(test, hlist_fake(&a));
+}
+
+static void hlist_test_is_singular_node(struct kunit *test)
+{
+	struct hlist_node a, b;
+	HLIST_HEAD(list);
+
+	INIT_HLIST_NODE(&a);
+	KUNIT_EXPECT_FALSE(test, hlist_is_singular_node(&a, &list));
+
+	hlist_add_head(&a, &list);
+	KUNIT_EXPECT_TRUE(test, hlist_is_singular_node(&a, &list));
+
+	hlist_add_head(&b, &list);
+	KUNIT_EXPECT_FALSE(test, hlist_is_singular_node(&a, &list));
+	KUNIT_EXPECT_FALSE(test, hlist_is_singular_node(&b, &list));
+}
+
+static void hlist_test_empty(struct kunit *test)
+{
+	struct hlist_node a;
+	HLIST_HEAD(list);
+
+	/* list starts off empty */
+	KUNIT_EXPECT_TRUE(test, hlist_empty(&list));
+
+	hlist_add_head(&a, &list);
+
+	/* list is no longer empty */
+	KUNIT_EXPECT_FALSE(test, hlist_empty(&list));
+}
+
+static void hlist_test_move_list(struct kunit *test)
+{
+	struct hlist_node a;
+	HLIST_HEAD(list1);
+	HLIST_HEAD(list2);
+
+	hlist_add_head(&a, &list1);
+
+	KUNIT_EXPECT_FALSE(test, hlist_empty(&list1));
+	KUNIT_EXPECT_TRUE(test, hlist_empty(&list2));
+	hlist_move_list(&list1, &list2);
+	KUNIT_EXPECT_TRUE(test, hlist_empty(&list1));
+	KUNIT_EXPECT_FALSE(test, hlist_empty(&list2));
+
+}
+
+static void hlist_test_entry(struct kunit *test)
+{
+	struct hlist_test_struct test_struct;
+
+	KUNIT_EXPECT_PTR_EQ(test, &test_struct,
+			    hlist_entry(&(test_struct.list),
+				struct hlist_test_struct, list));
+}
+
+static void hlist_test_entry_safe(struct kunit *test)
+{
+	struct hlist_test_struct test_struct;
+
+	KUNIT_EXPECT_PTR_EQ(test, &test_struct,
+			    hlist_entry_safe(&(test_struct.list),
+				struct hlist_test_struct, list));
+
+	KUNIT_EXPECT_PTR_EQ(test, NULL,
+			    hlist_entry_safe((struct hlist_node *)NULL,
+				struct hlist_test_struct, list));
+}
+
+static void hlist_test_for_each(struct kunit *test)
+{
+	struct hlist_node entries[3], *cur;
+	HLIST_HEAD(list);
+	int i = 0;
+
+	hlist_add_head(&entries[0], &list);
+	hlist_add_behind(&entries[1], &entries[0]);
+	hlist_add_behind(&entries[2], &entries[1]);
+
+	hlist_for_each(cur, &list) {
+		KUNIT_EXPECT_PTR_EQ(test, cur, &entries[i]);
+		i++;
+	}
+
+	KUNIT_EXPECT_EQ(test, i, 3);
+}
+
+
+static void hlist_test_for_each_safe(struct kunit *test)
+{
+	struct hlist_node entries[3], *cur, *n;
+	HLIST_HEAD(list);
+	int i = 0;
+
+	hlist_add_head(&entries[0], &list);
+	hlist_add_behind(&entries[1], &entries[0]);
+	hlist_add_behind(&entries[2], &entries[1]);
+
+	hlist_for_each_safe(cur, n, &list) {
+		KUNIT_EXPECT_PTR_EQ(test, cur, &entries[i]);
+		hlist_del(&entries[i]);
+		i++;
+	}
+
+	KUNIT_EXPECT_EQ(test, i, 3);
+	KUNIT_EXPECT_TRUE(test, hlist_empty(&list));
+}
+
+static void hlist_test_for_each_entry(struct kunit *test)
+{
+	struct hlist_test_struct entries[5], *cur;
+	HLIST_HEAD(list);
+	int i = 0;
+
+	entries[0].data = 0;
+	hlist_add_head(&entries[0].list, &list);
+	for (i = 1; i < 5; ++i) {
+		entries[i].data = i;
+		hlist_add_behind(&entries[i].list, &entries[i-1].list);
+	}
+
+	i = 0;
+
+	hlist_for_each_entry(cur, &list, list) {
+		KUNIT_EXPECT_EQ(test, cur->data, i);
+		i++;
+	}
+
+	KUNIT_EXPECT_EQ(test, i, 5);
+}
+
+static void hlist_test_for_each_entry_continue(struct kunit *test)
+{
+	struct hlist_test_struct entries[5], *cur;
+	HLIST_HEAD(list);
+	int i = 0;
+
+	entries[0].data = 0;
+	hlist_add_head(&entries[0].list, &list);
+	for (i = 1; i < 5; ++i) {
+		entries[i].data = i;
+		hlist_add_behind(&entries[i].list, &entries[i-1].list);
+	}
+
+	/* We skip the first (zero-th) entry. */
+	i = 1;
+
+	cur = &entries[0];
+	hlist_for_each_entry_continue(cur, list) {
+		KUNIT_EXPECT_EQ(test, cur->data, i);
+		/* Stamp over the entry. */
+		cur->data = 42;
+		i++;
+	}
+
+	KUNIT_EXPECT_EQ(test, i, 5);
+	/* The first entry was not visited. */
+	KUNIT_EXPECT_EQ(test, entries[0].data, 0);
+	/* The second (and presumably others), were. */
+	KUNIT_EXPECT_EQ(test, entries[1].data, 42);
+}
+
+static void hlist_test_for_each_entry_from(struct kunit *test)
+{
+	struct hlist_test_struct entries[5], *cur;
+	HLIST_HEAD(list);
+	int i = 0;
+
+	entries[0].data = 0;
+	hlist_add_head(&entries[0].list, &list);
+	for (i = 1; i < 5; ++i) {
+		entries[i].data = i;
+		hlist_add_behind(&entries[i].list, &entries[i-1].list);
+	}
+
+	i = 0;
+
+	cur = &entries[0];
+	hlist_for_each_entry_from(cur, list) {
+		KUNIT_EXPECT_EQ(test, cur->data, i);
+		/* Stamp over the entry. */
+		cur->data = 42;
+		i++;
+	}
+
+	KUNIT_EXPECT_EQ(test, i, 5);
+	/* The first entry was visited. */
+	KUNIT_EXPECT_EQ(test, entries[0].data, 42);
+}
+
+static void hlist_test_for_each_entry_safe(struct kunit *test)
+{
+	struct hlist_test_struct entries[5], *cur;
+	struct hlist_node *tmp_node;
+	HLIST_HEAD(list);
+	int i = 0;
+
+	entries[0].data = 0;
+	hlist_add_head(&entries[0].list, &list);
+	for (i = 1; i < 5; ++i) {
+		entries[i].data = i;
+		hlist_add_behind(&entries[i].list, &entries[i-1].list);
+	}
+
+	i = 0;
+
+	hlist_for_each_entry_safe(cur, tmp_node, &list, list) {
+		KUNIT_EXPECT_EQ(test, cur->data, i);
+		hlist_del(&cur->list);
+		i++;
+	}
+
+	KUNIT_EXPECT_EQ(test, i, 5);
+	KUNIT_EXPECT_TRUE(test, hlist_empty(&list));
+}
+
+
+static struct kunit_case hlist_test_cases[] = {
+	KUNIT_CASE(hlist_test_init),
+	KUNIT_CASE(hlist_test_unhashed),
+	KUNIT_CASE(hlist_test_unhashed_lockless),
+	KUNIT_CASE(hlist_test_del),
+	KUNIT_CASE(hlist_test_del_init),
+	KUNIT_CASE(hlist_test_add),
+	KUNIT_CASE(hlist_test_fake),
+	KUNIT_CASE(hlist_test_is_singular_node),
+	KUNIT_CASE(hlist_test_empty),
+	KUNIT_CASE(hlist_test_move_list),
+	KUNIT_CASE(hlist_test_entry),
+	KUNIT_CASE(hlist_test_entry_safe),
+	KUNIT_CASE(hlist_test_for_each),
+	KUNIT_CASE(hlist_test_for_each_safe),
+	KUNIT_CASE(hlist_test_for_each_entry),
+	KUNIT_CASE(hlist_test_for_each_entry_continue),
+	KUNIT_CASE(hlist_test_for_each_entry_from),
+	KUNIT_CASE(hlist_test_for_each_entry_safe),
+	{},
+};
+
+static struct kunit_suite hlist_test_module = {
+	.name = "hlist",
+	.test_cases = hlist_test_cases,
+};
+
+kunit_test_suites(&list_test_module, &hlist_test_module);
 
 MODULE_LICENSE("GPL v2");
diff --git a/lib/test_kasan.c b/lib/test_kasan.c
index ad880231dfa8..c233b1a4e984 100644
--- a/lib/test_kasan.c
+++ b/lib/test_kasan.c
@@ -391,7 +391,7 @@ static void krealloc_uaf(struct kunit *test)
 	kfree(ptr1);
 
 	KUNIT_EXPECT_KASAN_FAIL(test, ptr2 = krealloc(ptr1, size2, GFP_KERNEL));
-	KUNIT_ASSERT_PTR_EQ(test, (void *)ptr2, NULL);
+	KUNIT_ASSERT_NULL(test, ptr2);
 	KUNIT_EXPECT_KASAN_FAIL(test, *(volatile char *)ptr1);
 }
 
diff --git a/mm/kfence/.kunitconfig b/mm/kfence/.kunitconfig
new file mode 100644
index 000000000000..f3d65e939bfa
--- /dev/null
+++ b/mm/kfence/.kunitconfig
@@ -0,0 +1,6 @@
+CONFIG_KUNIT=y
+CONFIG_KFENCE=y
+CONFIG_KFENCE_KUNIT_TEST=y
+
+# Additional dependencies.
+CONFIG_FTRACE=y
diff --git a/mm/kfence/kfence_test.c b/mm/kfence/kfence_test.c
index 1b50f70a4c0f..96206a4ee9ab 100644
--- a/mm/kfence/kfence_test.c
+++ b/mm/kfence/kfence_test.c
@@ -826,14 +826,6 @@ static void test_exit(struct kunit *test)
 	test_cache_destroy();
 }
 
-static struct kunit_suite kfence_test_suite = {
-	.name = "kfence",
-	.test_cases = kfence_test_cases,
-	.init = test_init,
-	.exit = test_exit,
-};
-static struct kunit_suite *kfence_test_suites[] = { &kfence_test_suite, NULL };
-
 static void register_tracepoints(struct tracepoint *tp, void *ignore)
 {
 	check_trace_callback_type_console(probe_console);
@@ -847,11 +839,7 @@ static void unregister_tracepoints(struct tracepoint *tp, void *ignore)
 		tracepoint_probe_unregister(tp, probe_console, NULL);
 }
 
-/*
- * We only want to do tracepoints setup and teardown once, therefore we have to
- * customize the init and exit functions and cannot rely on kunit_test_suite().
- */
-static int __init kfence_test_init(void)
+static int kfence_suite_init(struct kunit_suite *suite)
 {
 	/*
 	 * Because we want to be able to build the test as a module, we need to
@@ -859,18 +847,25 @@ static int __init kfence_test_init(void)
 	 * won't work here.
 	 */
 	for_each_kernel_tracepoint(register_tracepoints, NULL);
-	return __kunit_test_suites_init(kfence_test_suites);
+	return 0;
 }
 
-static void kfence_test_exit(void)
+static void kfence_suite_exit(struct kunit_suite *suite)
 {
-	__kunit_test_suites_exit(kfence_test_suites);
 	for_each_kernel_tracepoint(unregister_tracepoints, NULL);
 	tracepoint_synchronize_unregister();
 }
 
-late_initcall_sync(kfence_test_init);
-module_exit(kfence_test_exit);
+static struct kunit_suite kfence_test_suite = {
+	.name = "kfence",
+	.test_cases = kfence_test_cases,
+	.init = test_init,
+	.exit = test_exit,
+	.suite_init = kfence_suite_init,
+	.suite_exit = kfence_suite_exit,
+};
+
+kunit_test_suites(&kfence_test_suite);
 
 MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>");
diff --git a/net/mctp/test/route-test.c b/net/mctp/test/route-test.c
index 61205cf40074..17d9c49000c5 100644
--- a/net/mctp/test/route-test.c
+++ b/net/mctp/test/route-test.c
@@ -361,7 +361,7 @@ static void mctp_test_route_input_sk(struct kunit *test)
 	} else {
 		KUNIT_EXPECT_NE(test, rc, 0);
 		skb2 = skb_recv_datagram(sock->sk, 0, 1, &rc);
-		KUNIT_EXPECT_PTR_EQ(test, skb2, NULL);
+		KUNIT_EXPECT_NULL(test, skb2);
 	}
 
 	__mctp_route_test_fini(test, dev, rt, sock);
@@ -431,7 +431,7 @@ static void mctp_test_route_input_sk_reasm(struct kunit *test)
 		skb_free_datagram(sock->sk, skb2);
 
 	} else {
-		KUNIT_EXPECT_PTR_EQ(test, skb2, NULL);
+		KUNIT_EXPECT_NULL(test, skb2);
 	}
 
 	__mctp_route_test_fini(test, dev, rt, sock);
diff --git a/security/apparmor/policy_unpack_test.c b/security/apparmor/policy_unpack_test.c
index 533137f45361..5c18d2f19862 100644
--- a/security/apparmor/policy_unpack_test.c
+++ b/security/apparmor/policy_unpack_test.c
@@ -313,7 +313,7 @@ static void policy_unpack_test_unpack_strdup_out_of_bounds(struct kunit *test)
 	size = unpack_strdup(puf->e, &string, TEST_STRING_NAME);
 
 	KUNIT_EXPECT_EQ(test, size, 0);
-	KUNIT_EXPECT_PTR_EQ(test, string, (char *)NULL);
+	KUNIT_EXPECT_NULL(test, string);
 	KUNIT_EXPECT_PTR_EQ(test, puf->e->pos, start);
 }
 
@@ -409,7 +409,7 @@ static void policy_unpack_test_unpack_u16_chunk_out_of_bounds_1(
 	size = unpack_u16_chunk(puf->e, &chunk);
 
 	KUNIT_EXPECT_EQ(test, size, (size_t)0);
-	KUNIT_EXPECT_PTR_EQ(test, chunk, (char *)NULL);
+	KUNIT_EXPECT_NULL(test, chunk);
 	KUNIT_EXPECT_PTR_EQ(test, puf->e->pos, puf->e->end - 1);
 }
 
@@ -431,7 +431,7 @@ static void policy_unpack_test_unpack_u16_chunk_out_of_bounds_2(
 	size = unpack_u16_chunk(puf->e, &chunk);
 
 	KUNIT_EXPECT_EQ(test, size, (size_t)0);
-	KUNIT_EXPECT_PTR_EQ(test, chunk, (char *)NULL);
+	KUNIT_EXPECT_NULL(test, chunk);
 	KUNIT_EXPECT_PTR_EQ(test, puf->e->pos, puf->e->start + TEST_U16_OFFSET);
 }
 
diff --git a/tools/testing/kunit/configs/all_tests_uml.config b/tools/testing/kunit/configs/all_tests_uml.config
new file mode 100644
index 000000000000..bdee36bef4a3
--- /dev/null
+++ b/tools/testing/kunit/configs/all_tests_uml.config
@@ -0,0 +1,37 @@
+# This config enables as many tests as possible under UML.
+# It is intended for use in continuous integration systems and similar for
+# automated testing of as much as possible.
+# The config is manually maintained, though it uses KUNIT_ALL_TESTS=y to enable
+# any tests whose dependencies are already satisfied. Please feel free to add
+# more options if they any new tests.
+
+CONFIG_KUNIT=y
+CONFIG_KUNIT_EXAMPLE_TEST=y
+CONFIG_KUNIT_ALL_TESTS=y
+
+CONFIG_IIO=y
+
+CONFIG_EXT4_FS=y
+
+CONFIG_MSDOS_FS=y
+CONFIG_VFAT_FS=y
+
+CONFIG_VIRTIO_UML=y
+CONFIG_UML_PCI_OVER_VIRTIO=y
+CONFIG_PCI=y
+CONFIG_USB4=y
+
+CONFIG_NET=y
+CONFIG_MCTP=y
+
+CONFIG_INET=y
+CONFIG_MPTCP=y
+
+CONFIG_DAMON=y
+CONFIG_DAMON_VADDR=y
+CONFIG_DAMON_PADDR=y
+CONFIG_DEBUG_FS=y
+CONFIG_DAMON_DBGFS=y
+
+CONFIG_SECURITY=y
+CONFIG_SECURITY_APPARMOR=y
diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
index 9274c6355809..13bd72e47da8 100755
--- a/tools/testing/kunit/kunit.py
+++ b/tools/testing/kunit/kunit.py
@@ -47,11 +47,11 @@ class KunitBuildRequest(KunitConfigRequest):
 @dataclass
 class KunitParseRequest:
 	raw_output: Optional[str]
-	build_dir: str
 	json: Optional[str]
 
 @dataclass
 class KunitExecRequest(KunitParseRequest):
+	build_dir: str
 	timeout: int
 	alltests: bool
 	filter_glob: str
@@ -63,8 +63,6 @@ class KunitRequest(KunitExecRequest, KunitBuildRequest):
 	pass
 
 
-KernelDirectoryPath = sys.argv[0].split('tools/testing/kunit/')[0]
-
 def get_kernel_root_path() -> str:
 	path = sys.argv[0] if not __file__ else __file__
 	parts = os.path.realpath(path).split('tools/testing/kunit')
@@ -126,7 +124,7 @@ def _list_tests(linux: kunit_kernel.LinuxSourceTree, request: KunitExecRequest)
 	lines.pop()
 
 	# Filter out any extraneous non-test output that might have gotten mixed in.
-	return [l for l in lines if re.match('^[^\s.]+\.[^\s.]+$', l)]
+	return [l for l in lines if re.match(r'^[^\s.]+\.[^\s.]+$', l)]
 
 def _suites_from_test_list(tests: List[str]) -> List[str]:
 	"""Extracts all the suites from an ordered list of tests."""
@@ -155,6 +153,8 @@ def exec_tests(linux: kunit_kernel.LinuxSourceTree, request: KunitExecRequest) -
 				test_glob = request.filter_glob.split('.', maxsplit=2)[1]
 				filter_globs = [g + '.'+ test_glob for g in filter_globs]
 
+	metadata = kunit_json.Metadata(arch=linux.arch(), build_dir=request.build_dir, def_config='kunit_defconfig')
+
 	test_counts = kunit_parser.TestCounts()
 	exec_time = 0.0
 	for i, filter_glob in enumerate(filter_globs):
@@ -167,7 +167,7 @@ def exec_tests(linux: kunit_kernel.LinuxSourceTree, request: KunitExecRequest) -
 			filter_glob=filter_glob,
 			build_dir=request.build_dir)
 
-		_, test_result = parse_tests(request, run_result)
+		_, test_result = parse_tests(request, metadata, run_result)
 		# run_kernel() doesn't block on the kernel exiting.
 		# That only happens after we get the last line of output from `run_result`.
 		# So exec_time here actually contains parsing + execution time, which is fine.
@@ -188,10 +188,9 @@ def exec_tests(linux: kunit_kernel.LinuxSourceTree, request: KunitExecRequest) -
 def _map_to_overall_status(test_status: kunit_parser.TestStatus) -> KunitStatus:
 	if test_status in (kunit_parser.TestStatus.SUCCESS, kunit_parser.TestStatus.SKIPPED):
 		return KunitStatus.SUCCESS
-	else:
-		return KunitStatus.TEST_FAILURE
+	return KunitStatus.TEST_FAILURE
 
-def parse_tests(request: KunitParseRequest, input_data: Iterable[str]) -> Tuple[KunitResult, kunit_parser.Test]:
+def parse_tests(request: KunitParseRequest, metadata: kunit_json.Metadata, input_data: Iterable[str]) -> Tuple[KunitResult, kunit_parser.Test]:
 	parse_start = time.time()
 
 	test_result = kunit_parser.Test()
@@ -206,8 +205,6 @@ def parse_tests(request: KunitParseRequest, input_data: Iterable[str]) -> Tuple[
 			pass
 		elif request.raw_output == 'kunit':
 			output = kunit_parser.extract_tap_lines(output)
-		else:
-			print(f'Unknown --raw_output option "{request.raw_output}"', file=sys.stderr)
 		for line in output:
 			print(line.rstrip())
 
@@ -216,13 +213,16 @@ def parse_tests(request: KunitParseRequest, input_data: Iterable[str]) -> Tuple[
 	parse_end = time.time()
 
 	if request.json:
-		json_obj = kunit_json.get_json_result(
+		json_str = kunit_json.get_json_result(
 					test=test_result,
-					def_config='kunit_defconfig',
-					build_dir=request.build_dir,
-					json_path=request.json)
+					metadata=metadata)
 		if request.json == 'stdout':
-			print(json_obj)
+			print(json_str)
+		else:
+			with open(request.json, 'w') as f:
+				f.write(json_str)
+			kunit_parser.print_with_timestamp("Test results stored in %s" %
+				os.path.abspath(request.json))
 
 	if test_result.status != kunit_parser.TestStatus.SUCCESS:
 		return KunitResult(KunitStatus.TEST_FAILURE, parse_end - parse_start), test_result
@@ -281,10 +281,10 @@ def add_common_opts(parser) -> None:
 	parser.add_argument('--build_dir',
 			    help='As in the make command, it specifies the build '
 			    'directory.',
-			    type=str, default='.kunit', metavar='build_dir')
+			    type=str, default='.kunit', metavar='DIR')
 	parser.add_argument('--make_options',
 			    help='X=Y make option, can be repeated.',
-			    action='append')
+			    action='append', metavar='X=Y')
 	parser.add_argument('--alltests',
 			    help='Run all KUnit tests through allyesconfig',
 			    action='store_true')
@@ -292,11 +292,11 @@ def add_common_opts(parser) -> None:
 			     help='Path to Kconfig fragment that enables KUnit tests.'
 			     ' If given a directory, (e.g. lib/kunit), "/.kunitconfig" '
 			     'will get  automatically appended.',
-			     metavar='kunitconfig')
+			     metavar='PATH')
 	parser.add_argument('--kconfig_add',
 			     help='Additional Kconfig options to append to the '
 			     '.kunitconfig, e.g. CONFIG_KASAN=y. Can be repeated.',
-			    action='append')
+			    action='append', metavar='CONFIG_X=Y')
 
 	parser.add_argument('--arch',
 			    help=('Specifies the architecture to run tests under. '
@@ -304,7 +304,7 @@ def add_common_opts(parser) -> None:
 				  'string passed to the ARCH make param, '
 				  'e.g. i386, x86_64, arm, um, etc. Non-UML '
 				  'architectures run on QEMU.'),
-			    type=str, default='um', metavar='arch')
+			    type=str, default='um', metavar='ARCH')
 
 	parser.add_argument('--cross_compile',
 			    help=('Sets make\'s CROSS_COMPILE variable; it should '
@@ -316,18 +316,18 @@ def add_common_opts(parser) -> None:
 				  'if you have downloaded the microblaze toolchain '
 				  'from the 0-day website to a directory in your '
 				  'home directory called `toolchains`).'),
-			    metavar='cross_compile')
+			    metavar='PREFIX')
 
 	parser.add_argument('--qemu_config',
 			    help=('Takes a path to a path to a file containing '
 				  'a QemuArchParams object.'),
-			    type=str, metavar='qemu_config')
+			    type=str, metavar='FILE')
 
 def add_build_opts(parser) -> None:
 	parser.add_argument('--jobs',
 			    help='As in the make command, "Specifies  the number of '
 			    'jobs (commands) to run simultaneously."',
-			    type=int, default=get_default_jobs(), metavar='jobs')
+			    type=int, default=get_default_jobs(), metavar='N')
 
 def add_exec_opts(parser) -> None:
 	parser.add_argument('--timeout',
@@ -336,7 +336,7 @@ def add_exec_opts(parser) -> None:
 			    'tests.',
 			    type=int,
 			    default=300,
-			    metavar='timeout')
+			    metavar='SECONDS')
 	parser.add_argument('filter_glob',
 			    help='Filter which KUnit test suites/tests run at '
 			    'boot-time, e.g. list* or list*.*del_test',
@@ -346,24 +346,24 @@ def add_exec_opts(parser) -> None:
 			    metavar='filter_glob')
 	parser.add_argument('--kernel_args',
 			    help='Kernel command-line parameters. Maybe be repeated',
-			     action='append')
+			     action='append', metavar='')
 	parser.add_argument('--run_isolated', help='If set, boot the kernel for each '
 			    'individual suite/test. This is can be useful for debugging '
 			    'a non-hermetic test, one that might pass/fail based on '
 			    'what ran before it.',
 			    type=str,
-			    choices=['suite', 'test']),
+			    choices=['suite', 'test'])
 
 def add_parse_opts(parser) -> None:
 	parser.add_argument('--raw_output', help='If set don\'t format output from kernel. '
 			    'If set to --raw_output=kunit, filters to just KUnit output.',
-			    type=str, nargs='?', const='all', default=None)
+			     type=str, nargs='?', const='all', default=None, choices=['all', 'kunit'])
 	parser.add_argument('--json',
 			    nargs='?',
 			    help='Stores test results in a JSON, and either '
 			    'prints to stdout or saves to file if a '
 			    'filename is specified',
-			    type=str, const='stdout', default=None)
+			    type=str, const='stdout', default=None, metavar='FILE')
 
 def main(argv, linux=None):
 	parser = argparse.ArgumentParser(
@@ -496,16 +496,17 @@ def main(argv, linux=None):
 		if result.status != KunitStatus.SUCCESS:
 			sys.exit(1)
 	elif cli_args.subcommand == 'parse':
-		if cli_args.file == None:
+		if cli_args.file is None:
 			sys.stdin.reconfigure(errors='backslashreplace')  # pytype: disable=attribute-error
 			kunit_output = sys.stdin
 		else:
 			with open(cli_args.file, 'r', errors='backslashreplace') as f:
 				kunit_output = f.read().splitlines()
+		# We know nothing about how the result was created!
+		metadata = kunit_json.Metadata()
 		request = KunitParseRequest(raw_output=cli_args.raw_output,
-					    build_dir='',
 					    json=cli_args.json)
-		result, _ = parse_tests(request, kunit_output)
+		result, _ = parse_tests(request, metadata, kunit_output)
 		if result.status != KunitStatus.SUCCESS:
 			sys.exit(1)
 	else:
diff --git a/tools/testing/kunit/kunit_config.py b/tools/testing/kunit/kunit_config.py
index 677354546156..75a8dc1683d4 100644
--- a/tools/testing/kunit/kunit_config.py
+++ b/tools/testing/kunit/kunit_config.py
@@ -6,29 +6,29 @@
 # Author: Felix Guo <felixguoxiuping@gmail.com>
 # Author: Brendan Higgins <brendanhiggins@google.com>
 
-import collections
+from dataclasses import dataclass
 import re
 from typing import List, Set
 
 CONFIG_IS_NOT_SET_PATTERN = r'^# CONFIG_(\w+) is not set$'
 CONFIG_PATTERN = r'^CONFIG_(\w+)=(\S+|".*")$'
 
-KconfigEntryBase = collections.namedtuple('KconfigEntryBase', ['name', 'value'])
-
-class KconfigEntry(KconfigEntryBase):
+@dataclass(frozen=True)
+class KconfigEntry:
+	name: str
+	value: str
 
 	def __str__(self) -> str:
 		if self.value == 'n':
-			return r'# CONFIG_%s is not set' % (self.name)
-		else:
-			return r'CONFIG_%s=%s' % (self.name, self.value)
+			return f'# CONFIG_{self.name} is not set'
+		return f'CONFIG_{self.name}={self.value}'
 
 
 class KconfigParseError(Exception):
 	"""Error parsing Kconfig defconfig or .config."""
 
 
-class Kconfig(object):
+class Kconfig:
 	"""Represents defconfig or .config specified using the Kconfig language."""
 
 	def __init__(self) -> None:
@@ -48,7 +48,7 @@ class Kconfig(object):
 				if a.value == 'n':
 					continue
 				return False
-			elif a.value != b:
+			if a.value != b:
 				return False
 		return True
 
@@ -90,6 +90,5 @@ def parse_from_string(blob: str) -> Kconfig:
 
 		if line[0] == '#':
 			continue
-		else:
-			raise KconfigParseError('Failed to parse: ' + line)
+		raise KconfigParseError('Failed to parse: ' + line)
 	return kconfig
diff --git a/tools/testing/kunit/kunit_json.py b/tools/testing/kunit/kunit_json.py
index 6862671709bc..10ff65689dd8 100644
--- a/tools/testing/kunit/kunit_json.py
+++ b/tools/testing/kunit/kunit_json.py
@@ -6,60 +6,58 @@
 # Copyright (C) 2020, Google LLC.
 # Author: Heidi Fahim <heidifahim@google.com>
 
+from dataclasses import dataclass
 import json
-import os
-
-import kunit_parser
+from typing import Any, Dict
 
 from kunit_parser import Test, TestStatus
-from typing import Any, Dict, Optional
+
+@dataclass
+class Metadata:
+	"""Stores metadata about this run to include in get_json_result()."""
+	arch: str = ''
+	def_config: str = ''
+	build_dir: str = ''
 
 JsonObj = Dict[str, Any]
 
-def _get_group_json(test: Test, def_config: str,
-		build_dir: Optional[str]) -> JsonObj:
+_status_map: Dict[TestStatus, str] = {
+	TestStatus.SUCCESS: "PASS",
+	TestStatus.SKIPPED: "SKIP",
+	TestStatus.TEST_CRASHED: "ERROR",
+}
+
+def _get_group_json(test: Test, common_fields: JsonObj) -> JsonObj:
 	sub_groups = []  # List[JsonObj]
 	test_cases = []  # List[JsonObj]
 
 	for subtest in test.subtests:
-		if len(subtest.subtests):
-			sub_group = _get_group_json(subtest, def_config,
-				build_dir)
+		if subtest.subtests:
+			sub_group = _get_group_json(subtest, common_fields)
 			sub_groups.append(sub_group)
-		else:
-			test_case = {"name": subtest.name, "status": "FAIL"}
-			if subtest.status == TestStatus.SUCCESS:
-				test_case["status"] = "PASS"
-			elif subtest.status == TestStatus.SKIPPED:
-				test_case["status"] = "SKIP"
-			elif subtest.status == TestStatus.TEST_CRASHED:
-				test_case["status"] = "ERROR"
-			test_cases.append(test_case)
+			continue
+		status = _status_map.get(subtest.status, "FAIL")
+		test_cases.append({"name": subtest.name, "status": status})
 
 	test_group = {
 		"name": test.name,
-		"arch": "UM",
-		"defconfig": def_config,
-		"build_environment": build_dir,
 		"sub_groups": sub_groups,
 		"test_cases": test_cases,
+	}
+	test_group.update(common_fields)
+	return test_group
+
+def get_json_result(test: Test, metadata: Metadata) -> str:
+	common_fields = {
+		"arch": metadata.arch,
+		"defconfig": metadata.def_config,
+		"build_environment": metadata.build_dir,
 		"lab_name": None,
 		"kernel": None,
 		"job": None,
 		"git_branch": "kselftest",
 	}
-	return test_group
 
-def get_json_result(test: Test, def_config: str,
-		build_dir: Optional[str], json_path: str) -> str:
-	test_group = _get_group_json(test, def_config, build_dir)
+	test_group = _get_group_json(test, common_fields)
 	test_group["name"] = "KUnit Test Group"
-	json_obj = json.dumps(test_group, indent=4)
-	if json_path != 'stdout':
-		with open(json_path, 'w') as result_path:
-			result_path.write(json_obj)
-		root = __file__.split('tools/testing/kunit/')[0]
-		kunit_parser.print_with_timestamp(
-			"Test results stored in %s" %
-			os.path.join(root, result_path.name))
-	return json_obj
+	return json.dumps(test_group, indent=4)
diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
index 3c4196cef3ed..3539efaf99ba 100644
--- a/tools/testing/kunit/kunit_kernel.py
+++ b/tools/testing/kunit/kunit_kernel.py
@@ -11,6 +11,7 @@ import importlib.util
 import logging
 import subprocess
 import os
+import shlex
 import shutil
 import signal
 import threading
@@ -29,11 +30,6 @@ OUTFILE_PATH = 'test.log'
 ABS_TOOL_PATH = os.path.abspath(os.path.dirname(__file__))
 QEMU_CONFIGS_DIR = os.path.join(ABS_TOOL_PATH, 'qemu_configs')
 
-def get_file_path(build_dir, default):
-	if build_dir:
-		default = os.path.join(build_dir, default)
-	return default
-
 class ConfigError(Exception):
 	"""Represents an error trying to configure the Linux kernel."""
 
@@ -42,7 +38,7 @@ class BuildError(Exception):
 	"""Represents an error trying to build the Linux kernel."""
 
 
-class LinuxSourceTreeOperations(object):
+class LinuxSourceTreeOperations:
 	"""An abstraction over command line operations performed on a source tree."""
 
 	def __init__(self, linux_arch: str, cross_compile: Optional[str]):
@@ -57,20 +53,18 @@ class LinuxSourceTreeOperations(object):
 		except subprocess.CalledProcessError as e:
 			raise ConfigError(e.output.decode())
 
-	def make_arch_qemuconfig(self, kconfig: kunit_config.Kconfig) -> None:
+	def make_arch_qemuconfig(self, base_kunitconfig: kunit_config.Kconfig) -> None:
 		pass
 
-	def make_allyesconfig(self, build_dir, make_options) -> None:
+	def make_allyesconfig(self, build_dir: str, make_options) -> None:
 		raise ConfigError('Only the "um" arch is supported for alltests')
 
-	def make_olddefconfig(self, build_dir, make_options) -> None:
-		command = ['make', 'ARCH=' + self._linux_arch, 'olddefconfig']
+	def make_olddefconfig(self, build_dir: str, make_options) -> None:
+		command = ['make', 'ARCH=' + self._linux_arch, 'O=' + build_dir, 'olddefconfig']
 		if self._cross_compile:
 			command += ['CROSS_COMPILE=' + self._cross_compile]
 		if make_options:
 			command.extend(make_options)
-		if build_dir:
-			command += ['O=' + build_dir]
 		print('Populating config with:\n$', ' '.join(command))
 		try:
 			subprocess.check_output(command, stderr=subprocess.STDOUT)
@@ -79,14 +73,12 @@ class LinuxSourceTreeOperations(object):
 		except subprocess.CalledProcessError as e:
 			raise ConfigError(e.output.decode())
 
-	def make(self, jobs, build_dir, make_options) -> None:
-		command = ['make', 'ARCH=' + self._linux_arch, '--jobs=' + str(jobs)]
+	def make(self, jobs, build_dir: str, make_options) -> None:
+		command = ['make', 'ARCH=' + self._linux_arch, 'O=' + build_dir, '--jobs=' + str(jobs)]
 		if make_options:
 			command.extend(make_options)
 		if self._cross_compile:
 			command += ['CROSS_COMPILE=' + self._cross_compile]
-		if build_dir:
-			command += ['O=' + build_dir]
 		print('Building with:\n$', ' '.join(command))
 		try:
 			proc = subprocess.Popen(command,
@@ -127,16 +119,17 @@ class LinuxSourceTreeOperationsQemu(LinuxSourceTreeOperations):
 				'-nodefaults',
 				'-m', '1024',
 				'-kernel', kernel_path,
-				'-append', '\'' + ' '.join(params + [self._kernel_command_line]) + '\'',
+				'-append', ' '.join(params + [self._kernel_command_line]),
 				'-no-reboot',
 				'-nographic',
-				'-serial stdio'] + self._extra_qemu_params
-		print('Running tests with:\n$', ' '.join(qemu_command))
-		return subprocess.Popen(' '.join(qemu_command),
-					   stdin=subprocess.PIPE,
-					   stdout=subprocess.PIPE,
-					   stderr=subprocess.STDOUT,
-					   text=True, shell=True, errors='backslashreplace')
+				'-serial', 'stdio'] + self._extra_qemu_params
+		# Note: shlex.join() does what we want, but requires python 3.8+.
+		print('Running tests with:\n$', ' '.join(shlex.quote(arg) for arg in qemu_command))
+		return subprocess.Popen(qemu_command,
+					stdin=subprocess.PIPE,
+					stdout=subprocess.PIPE,
+					stderr=subprocess.STDOUT,
+					text=True, errors='backslashreplace')
 
 class LinuxSourceTreeOperationsUml(LinuxSourceTreeOperations):
 	"""An abstraction over command line operations performed on a source tree."""
@@ -144,14 +137,12 @@ class LinuxSourceTreeOperationsUml(LinuxSourceTreeOperations):
 	def __init__(self, cross_compile=None):
 		super().__init__(linux_arch='um', cross_compile=cross_compile)
 
-	def make_allyesconfig(self, build_dir, make_options) -> None:
+	def make_allyesconfig(self, build_dir: str, make_options) -> None:
 		kunit_parser.print_with_timestamp(
 			'Enabling all CONFIGs for UML...')
-		command = ['make', 'ARCH=um', 'allyesconfig']
+		command = ['make', 'ARCH=um', 'O=' + build_dir, 'allyesconfig']
 		if make_options:
 			command.extend(make_options)
-		if build_dir:
-			command += ['O=' + build_dir]
 		process = subprocess.Popen(
 			command,
 			stdout=subprocess.DEVNULL,
@@ -168,30 +159,30 @@ class LinuxSourceTreeOperationsUml(LinuxSourceTreeOperations):
 
 	def start(self, params: List[str], build_dir: str) -> subprocess.Popen:
 		"""Runs the Linux UML binary. Must be named 'linux'."""
-		linux_bin = get_file_path(build_dir, 'linux')
+		linux_bin = os.path.join(build_dir, 'linux')
 		return subprocess.Popen([linux_bin] + params,
 					   stdin=subprocess.PIPE,
 					   stdout=subprocess.PIPE,
 					   stderr=subprocess.STDOUT,
 					   text=True, errors='backslashreplace')
 
-def get_kconfig_path(build_dir) -> str:
-	return get_file_path(build_dir, KCONFIG_PATH)
+def get_kconfig_path(build_dir: str) -> str:
+	return os.path.join(build_dir, KCONFIG_PATH)
 
-def get_kunitconfig_path(build_dir) -> str:
-	return get_file_path(build_dir, KUNITCONFIG_PATH)
+def get_kunitconfig_path(build_dir: str) -> str:
+	return os.path.join(build_dir, KUNITCONFIG_PATH)
 
-def get_old_kunitconfig_path(build_dir) -> str:
-	return get_file_path(build_dir, OLD_KUNITCONFIG_PATH)
+def get_old_kunitconfig_path(build_dir: str) -> str:
+	return os.path.join(build_dir, OLD_KUNITCONFIG_PATH)
 
-def get_outfile_path(build_dir) -> str:
-	return get_file_path(build_dir, OUTFILE_PATH)
+def get_outfile_path(build_dir: str) -> str:
+	return os.path.join(build_dir, OUTFILE_PATH)
 
 def get_source_tree_ops(arch: str, cross_compile: Optional[str]) -> LinuxSourceTreeOperations:
 	config_path = os.path.join(QEMU_CONFIGS_DIR, arch + '.py')
 	if arch == 'um':
 		return LinuxSourceTreeOperationsUml(cross_compile=cross_compile)
-	elif os.path.isfile(config_path):
+	if os.path.isfile(config_path):
 		return get_source_tree_ops_from_qemu_config(config_path, cross_compile)[1]
 
 	options = [f[:-3] for f in os.listdir(QEMU_CONFIGS_DIR) if f.endswith('.py')]
@@ -222,7 +213,7 @@ def get_source_tree_ops_from_qemu_config(config_path: str,
 	return params.linux_arch, LinuxSourceTreeOperationsQemu(
 			params, cross_compile=cross_compile)
 
-class LinuxSourceTree(object):
+class LinuxSourceTree:
 	"""Represents a Linux kernel source tree with KUnit tests."""
 
 	def __init__(
@@ -260,6 +251,8 @@ class LinuxSourceTree(object):
 			kconfig = kunit_config.parse_from_string('\n'.join(kconfig_add))
 			self._kconfig.merge_in_entries(kconfig)
 
+	def arch(self) -> str:
+		return self._arch
 
 	def clean(self) -> bool:
 		try:
@@ -269,7 +262,7 @@ class LinuxSourceTree(object):
 			return False
 		return True
 
-	def validate_config(self, build_dir) -> bool:
+	def validate_config(self, build_dir: str) -> bool:
 		kconfig_path = get_kconfig_path(build_dir)
 		validated_kconfig = kunit_config.parse_file(kconfig_path)
 		if self._kconfig.is_subset_of(validated_kconfig):
@@ -284,7 +277,7 @@ class LinuxSourceTree(object):
 		logging.error(message)
 		return False
 
-	def build_config(self, build_dir, make_options) -> bool:
+	def build_config(self, build_dir: str, make_options) -> bool:
 		kconfig_path = get_kconfig_path(build_dir)
 		if build_dir and not os.path.exists(build_dir):
 			os.mkdir(build_dir)
@@ -312,7 +305,7 @@ class LinuxSourceTree(object):
 		old_kconfig = kunit_config.parse_file(old_path)
 		return old_kconfig.entries() != self._kconfig.entries()
 
-	def build_reconfig(self, build_dir, make_options) -> bool:
+	def build_reconfig(self, build_dir: str, make_options) -> bool:
 		"""Creates a new .config if it is not a subset of the .kunitconfig."""
 		kconfig_path = get_kconfig_path(build_dir)
 		if not os.path.exists(kconfig_path):
@@ -327,7 +320,7 @@ class LinuxSourceTree(object):
 		os.remove(kconfig_path)
 		return self.build_config(build_dir, make_options)
 
-	def build_kernel(self, alltests, jobs, build_dir, make_options) -> bool:
+	def build_kernel(self, alltests, jobs, build_dir: str, make_options) -> bool:
 		try:
 			if alltests:
 				self._ops.make_allyesconfig(build_dir, make_options)
@@ -375,6 +368,6 @@ class LinuxSourceTree(object):
 			waiter.join()
 			subprocess.call(['stty', 'sane'])
 
-	def signal_handler(self, sig, frame) -> None:
+	def signal_handler(self, unused_sig, unused_frame) -> None:
 		logging.error('Build interruption occurred. Cleaning console.')
 		subprocess.call(['stty', 'sane'])
diff --git a/tools/testing/kunit/kunit_parser.py b/tools/testing/kunit/kunit_parser.py
index 05ff334761dd..c5569b367c69 100644
--- a/tools/testing/kunit/kunit_parser.py
+++ b/tools/testing/kunit/kunit_parser.py
@@ -11,13 +11,13 @@
 
 from __future__ import annotations
 import re
+import sys
 
 import datetime
 from enum import Enum, auto
-from functools import reduce
 from typing import Iterable, Iterator, List, Optional, Tuple
 
-class Test(object):
+class Test:
 	"""
 	A class to represent a test parsed from KTAP results. All KTAP
 	results within a test log are stored in a main Test object as
@@ -45,10 +45,8 @@ class Test(object):
 
 	def __str__(self) -> str:
 		"""Returns string representation of a Test class object."""
-		return ('Test(' + str(self.status) + ', ' + self.name +
-			', ' + str(self.expected_count) + ', ' +
-			str(self.subtests) + ', ' + str(self.log) + ', ' +
-			str(self.counts) + ')')
+		return (f'Test({self.status}, {self.name}, {self.expected_count}, '
+			f'{self.subtests}, {self.log}, {self.counts})')
 
 	def __repr__(self) -> str:
 		"""Returns string representation of a Test class object."""
@@ -57,7 +55,7 @@ class Test(object):
 	def add_error(self, error_message: str) -> None:
 		"""Records an error that occurred while parsing this test."""
 		self.counts.errors += 1
-		print_error('Test ' + self.name + ': ' + error_message)
+		print_with_timestamp(red('[ERROR]') + f' Test: {self.name}: {error_message}')
 
 class TestStatus(Enum):
 	"""An enumeration class to represent the status of a test."""
@@ -91,13 +89,12 @@ class TestCounts:
 		self.errors = 0
 
 	def __str__(self) -> str:
-		"""Returns the string representation of a TestCounts object.
-		"""
-		return ('Passed: ' + str(self.passed) +
-			', Failed: ' + str(self.failed) +
-			', Crashed: ' + str(self.crashed) +
-			', Skipped: ' + str(self.skipped) +
-			', Errors: ' + str(self.errors))
+		"""Returns the string representation of a TestCounts object."""
+		statuses = [('passed', self.passed), ('failed', self.failed),
+			('crashed', self.crashed), ('skipped', self.skipped),
+			('errors', self.errors)]
+		return f'Ran {self.total()} tests: ' + \
+			', '.join(f'{s}: {n}' for s, n in statuses if n > 0)
 
 	def total(self) -> int:
 		"""Returns the total number of test cases within a test
@@ -128,31 +125,19 @@ class TestCounts:
 		"""
 		if self.total() == 0:
 			return TestStatus.NO_TESTS
-		elif self.crashed:
-			# If one of the subtests crash, the expected status
-			# of the Test is crashed.
+		if self.crashed:
+			# Crashes should take priority.
 			return TestStatus.TEST_CRASHED
-		elif self.failed:
-			# Otherwise if one of the subtests fail, the
-			# expected status of the Test is failed.
+		if self.failed:
 			return TestStatus.FAILURE
-		elif self.passed:
-			# Otherwise if one of the subtests pass, the
-			# expected status of the Test is passed.
+		if self.passed:
+			# No failures or crashes, looks good!
 			return TestStatus.SUCCESS
-		else:
-			# Finally, if none of the subtests have failed,
-			# crashed, or passed, the expected status of the
-			# Test is skipped.
-			return TestStatus.SKIPPED
+		# We have only skipped tests.
+		return TestStatus.SKIPPED
 
 	def add_status(self, status: TestStatus) -> None:
-		"""
-		Increments count of inputted status.
-
-		Parameters:
-		status - status to be added to the TestCounts object
-		"""
+		"""Increments the count for `status`."""
 		if status == TestStatus.SUCCESS:
 			self.passed += 1
 		elif status == TestStatus.FAILURE:
@@ -282,11 +267,9 @@ def check_version(version_num: int, accepted_versions: List[int],
 	test - Test object for current test being parsed
 	"""
 	if version_num < min(accepted_versions):
-		test.add_error(version_type +
-			' version lower than expected!')
+		test.add_error(f'{version_type} version lower than expected!')
 	elif version_num > max(accepted_versions):
-		test.add_error(
-			version_type + ' version higher than expected!')
+		test.add_error(f'{version_type} version higer than expected!')
 
 def parse_ktap_header(lines: LineStream, test: Test) -> bool:
 	"""
@@ -396,7 +379,7 @@ def peek_test_name_match(lines: LineStream, test: Test) -> bool:
 	if not match:
 		return False
 	name = match.group(4)
-	return (name == test.name)
+	return name == test.name
 
 def parse_test_result(lines: LineStream, test: Test,
 			expected_num: int) -> bool:
@@ -439,8 +422,7 @@ def parse_test_result(lines: LineStream, test: Test,
 	# Check test num
 	num = int(match.group(2))
 	if num != expected_num:
-		test.add_error('Expected test number ' +
-			str(expected_num) + ' but found ' + str(num))
+		test.add_error(f'Expected test number {expected_num} but found {num}')
 
 	# Set status of test object
 	status = match.group(1)
@@ -474,26 +456,6 @@ def parse_diagnostic(lines: LineStream) -> List[str]:
 		log.append(lines.pop())
 	return log
 
-DIAGNOSTIC_CRASH_MESSAGE = re.compile(r'^# .*?: kunit test case crashed!$')
-
-def parse_crash_in_log(test: Test) -> bool:
-	"""
-	Iterate through the lines of the log to parse for crash message.
-	If crash message found, set status to crashed and return True.
-	Otherwise return False.
-
-	Parameters:
-	test - Test object for current test being parsed
-
-	Return:
-	True if crash message found in log
-	"""
-	for line in test.log:
-		if DIAGNOSTIC_CRASH_MESSAGE.match(line):
-			test.status = TestStatus.TEST_CRASHED
-			return True
-	return False
-
 
 # Printing helper methods:
 
@@ -503,14 +465,20 @@ RESET = '\033[0;0m'
 
 def red(text: str) -> str:
 	"""Returns inputted string with red color code."""
+	if not sys.stdout.isatty():
+		return text
 	return '\033[1;31m' + text + RESET
 
 def yellow(text: str) -> str:
 	"""Returns inputted string with yellow color code."""
+	if not sys.stdout.isatty():
+		return text
 	return '\033[1;33m' + text + RESET
 
 def green(text: str) -> str:
 	"""Returns inputted string with green color code."""
+	if not sys.stdout.isatty():
+		return text
 	return '\033[1;32m' + text + RESET
 
 ANSI_LEN = len(red(''))
@@ -542,7 +510,7 @@ def format_test_divider(message: str, len_message: int) -> str:
 		# calculate number of dashes for each side of the divider
 		len_1 = int(difference / 2)
 		len_2 = difference - len_1
-	return ('=' * len_1) + ' ' + message + ' ' + ('=' * len_2)
+	return ('=' * len_1) + f' {message} ' + ('=' * len_2)
 
 def print_test_header(test: Test) -> None:
 	"""
@@ -558,20 +526,13 @@ def print_test_header(test: Test) -> None:
 	message = test.name
 	if test.expected_count:
 		if test.expected_count == 1:
-			message += (' (' + str(test.expected_count) +
-				' subtest)')
+			message += ' (1 subtest)'
 		else:
-			message += (' (' + str(test.expected_count) +
-				' subtests)')
+			message += f' ({test.expected_count} subtests)'
 	print_with_timestamp(format_test_divider(message, len(message)))
 
 def print_log(log: Iterable[str]) -> None:
-	"""
-	Prints all strings in saved log for test in yellow.
-
-	Parameters:
-	log - Iterable object with all strings saved in log for test
-	"""
+	"""Prints all strings in saved log for test in yellow."""
 	for m in log:
 		print_with_timestamp(yellow(m))
 
@@ -590,17 +551,16 @@ def format_test_result(test: Test) -> str:
 	String containing formatted test result
 	"""
 	if test.status == TestStatus.SUCCESS:
-		return (green('[PASSED] ') + test.name)
-	elif test.status == TestStatus.SKIPPED:
-		return (yellow('[SKIPPED] ') + test.name)
-	elif test.status == TestStatus.NO_TESTS:
-		return (yellow('[NO TESTS RUN] ') + test.name)
-	elif test.status == TestStatus.TEST_CRASHED:
+		return green('[PASSED] ') + test.name
+	if test.status == TestStatus.SKIPPED:
+		return yellow('[SKIPPED] ') + test.name
+	if test.status == TestStatus.NO_TESTS:
+		return yellow('[NO TESTS RUN] ') + test.name
+	if test.status == TestStatus.TEST_CRASHED:
 		print_log(test.log)
-		return (red('[CRASHED] ') + test.name)
-	else:
-		print_log(test.log)
-		return (red('[FAILED] ') + test.name)
+		return red('[CRASHED] ') + test.name
+	print_log(test.log)
+	return red('[FAILED] ') + test.name
 
 def print_test_result(test: Test) -> None:
 	"""
@@ -644,24 +604,11 @@ def print_summary_line(test: Test) -> None:
 	"""
 	if test.status == TestStatus.SUCCESS:
 		color = green
-	elif test.status == TestStatus.SKIPPED or test.status == TestStatus.NO_TESTS:
+	elif test.status in (TestStatus.SKIPPED, TestStatus.NO_TESTS):
 		color = yellow
 	else:
 		color = red
-	counts = test.counts
-	print_with_timestamp(color('Testing complete. ' + str(counts)))
-
-def print_error(error_message: str) -> None:
-	"""
-	Prints error message with error format.
-
-	Example:
-	"[ERROR] Test example: missing test plan!"
-
-	Parameters:
-	error_message - message describing error
-	"""
-	print_with_timestamp(red('[ERROR] ') + error_message)
+	print_with_timestamp(color(f'Testing complete. {test.counts}'))
 
 # Other methods:
 
@@ -675,7 +622,6 @@ def bubble_up_test_results(test: Test) -> None:
 	Parameters:
 	test - Test object for current test being parsed
 	"""
-	parse_crash_in_log(test)
 	subtests = test.subtests
 	counts = test.counts
 	status = test.status
@@ -789,8 +735,11 @@ def parse_test(lines: LineStream, expected_num: int, log: List[str]) -> Test:
 
 	# Check for there being no tests
 	if parent_test and len(subtests) == 0:
-		test.status = TestStatus.NO_TESTS
-		test.add_error('0 tests run!')
+		# Don't override a bad status if this test had one reported.
+		# Assumption: no subtests means CRASHED is from Test.__init__()
+		if test.status in (TestStatus.TEST_CRASHED, TestStatus.SUCCESS):
+			test.status = TestStatus.NO_TESTS
+			test.add_error('0 tests run!')
 
 	# Add statuses to TestCounts attribute in Test object
 	bubble_up_test_results(test)
@@ -805,7 +754,7 @@ def parse_test(lines: LineStream, expected_num: int, log: List[str]) -> Test:
 def parse_run_tests(kernel_output: Iterable[str]) -> Test:
 	"""
 	Using kernel output, extract KTAP lines, parse the lines for test
-	results and print condensed test results and summary line .
+	results and print condensed test results and summary line.
 
 	Parameters:
 	kernel_output - Iterable object contains lines of kernel output
@@ -817,7 +766,8 @@ def parse_run_tests(kernel_output: Iterable[str]) -> Test:
 	lines = extract_tap_lines(kernel_output)
 	test = Test()
 	if not lines:
-		test.add_error('invalid KTAP input!')
+		test.name = '<missing>'
+		test.add_error('could not find any KTAP output!')
 		test.status = TestStatus.FAILURE_TO_PARSE_TESTS
 	else:
 		test = parse_test(lines, 0, [])
diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
index 352369dffbd9..25a2eb3bf114 100755
--- a/tools/testing/kunit/kunit_tool_test.py
+++ b/tools/testing/kunit/kunit_tool_test.py
@@ -226,19 +226,10 @@ class KUnitParserTest(unittest.TestCase):
 		with open(crash_log) as file:
 			result = kunit_parser.parse_run_tests(
 				kunit_parser.extract_tap_lines(file.readlines()))
-		print_mock.assert_any_call(StrContains('invalid KTAP input!'))
+		print_mock.assert_any_call(StrContains('could not find any KTAP output!'))
 		print_mock.stop()
 		self.assertEqual(0, len(result.subtests))
 
-	def test_crashed_test(self):
-		crashed_log = test_data_path('test_is_test_passed-crash.log')
-		with open(crashed_log) as file:
-			result = kunit_parser.parse_run_tests(
-				file.readlines())
-		self.assertEqual(
-			kunit_parser.TestStatus.TEST_CRASHED,
-			result.status)
-
 	def test_skipped_test(self):
 		skipped_log = test_data_path('test_skip_tests.log')
 		with open(skipped_log) as file:
@@ -260,8 +251,8 @@ class KUnitParserTest(unittest.TestCase):
 
 	def test_ignores_hyphen(self):
 		hyphen_log = test_data_path('test_strip_hyphen.log')
-		file = open(hyphen_log)
-		result = kunit_parser.parse_run_tests(file.readlines())
+		with open(hyphen_log) as file:
+			result = kunit_parser.parse_run_tests(file.readlines())
 
 		# A skipped test does not fail the whole suite.
 		self.assertEqual(
@@ -356,7 +347,7 @@ class LineStreamTest(unittest.TestCase):
 		called_times = 0
 		def generator():
 			nonlocal called_times
-			for i in range(1,5):
+			for _ in range(1,5):
 				called_times += 1
 				yield called_times, str(called_times)
 
@@ -468,9 +459,7 @@ class KUnitJsonTest(unittest.TestCase):
 			test_result = kunit_parser.parse_run_tests(file)
 			json_obj = kunit_json.get_json_result(
 				test=test_result,
-				def_config='kunit_defconfig',
-				build_dir=None,
-				json_path='stdout')
+				metadata=kunit_json.Metadata())
 		return json.loads(json_obj)
 
 	def test_failed_test_json(self):
@@ -480,10 +469,10 @@ class KUnitJsonTest(unittest.TestCase):
 			result["sub_groups"][1]["test_cases"][0])
 
 	def test_crashed_test_json(self):
-		result = self._json_for('test_is_test_passed-crash.log')
+		result = self._json_for('test_kernel_panic_interrupt.log')
 		self.assertEqual(
-			{'name': 'example_simple_test', 'status': 'ERROR'},
-			result["sub_groups"][1]["test_cases"][0])
+			{'name': '', 'status': 'ERROR'},
+			result["sub_groups"][2]["test_cases"][1])
 
 	def test_skipped_test_json(self):
 		result = self._json_for('test_skip_tests.log')
@@ -559,12 +548,13 @@ class KUnitMainTest(unittest.TestCase):
 		self.assertEqual(e.exception.code, 1)
 		self.assertEqual(self.linux_source_mock.build_reconfig.call_count, 1)
 		self.assertEqual(self.linux_source_mock.run_kernel.call_count, 1)
-		self.print_mock.assert_any_call(StrContains('invalid KTAP input!'))
+		self.print_mock.assert_any_call(StrContains('could not find any KTAP output!'))
 
 	def test_exec_no_tests(self):
 		self.linux_source_mock.run_kernel = mock.Mock(return_value=['TAP version 14', '1..0'])
 		with self.assertRaises(SystemExit) as e:
-                  kunit.main(['run'], self.linux_source_mock)
+			kunit.main(['run'], self.linux_source_mock)
+		self.assertEqual(e.exception.code, 1)
 		self.linux_source_mock.run_kernel.assert_called_once_with(
 			args=None, build_dir='.kunit', filter_glob='', timeout=300)
 		self.print_mock.assert_any_call(StrContains(' 0 tests run!'))
@@ -595,6 +585,12 @@ class KUnitMainTest(unittest.TestCase):
 			self.assertNotEqual(call, mock.call(StrContains('Testing complete.')))
 			self.assertNotEqual(call, mock.call(StrContains(' 0 tests run')))
 
+	def test_run_raw_output_invalid(self):
+		self.linux_source_mock.run_kernel = mock.Mock(return_value=[])
+		with self.assertRaises(SystemExit) as e:
+			kunit.main(['run', '--raw_output=invalid'], self.linux_source_mock)
+		self.assertNotEqual(e.exception.code, 0)
+
 	def test_run_raw_output_does_not_take_positional_args(self):
 		# --raw_output is a string flag, but we don't want it to consume
 		# any positional arguments, only ones after an '='
@@ -692,7 +688,7 @@ class KUnitMainTest(unittest.TestCase):
 		self.linux_source_mock.run_kernel.return_value = ['TAP version 14', 'init: random output'] + want
 
 		got = kunit._list_tests(self.linux_source_mock,
-				     kunit.KunitExecRequest(None, '.kunit', None, 300, False, 'suite*', None, 'suite'))
+				     kunit.KunitExecRequest(None, None, '.kunit', 300, False, 'suite*', None, 'suite'))
 
 		self.assertEqual(got, want)
 		# Should respect the user's filter glob when listing tests.
@@ -707,7 +703,7 @@ class KUnitMainTest(unittest.TestCase):
 
 		# Should respect the user's filter glob when listing tests.
 		mock_tests.assert_called_once_with(mock.ANY,
-				     kunit.KunitExecRequest(None, '.kunit', None, 300, False, 'suite*.test*', None, 'suite'))
+				     kunit.KunitExecRequest(None, None, '.kunit', 300, False, 'suite*.test*', None, 'suite'))
 		self.linux_source_mock.run_kernel.assert_has_calls([
 			mock.call(args=None, build_dir='.kunit', filter_glob='suite.test*', timeout=300),
 			mock.call(args=None, build_dir='.kunit', filter_glob='suite2.test*', timeout=300),
@@ -720,7 +716,7 @@ class KUnitMainTest(unittest.TestCase):
 
 		# Should respect the user's filter glob when listing tests.
 		mock_tests.assert_called_once_with(mock.ANY,
-				     kunit.KunitExecRequest(None, '.kunit', None, 300, False, 'suite*', None, 'test'))
+				     kunit.KunitExecRequest(None, None, '.kunit', 300, False, 'suite*', None, 'test'))
 		self.linux_source_mock.run_kernel.assert_has_calls([
 			mock.call(args=None, build_dir='.kunit', filter_glob='suite.test1', timeout=300),
 			mock.call(args=None, build_dir='.kunit', filter_glob='suite.test2', timeout=300),
diff --git a/tools/testing/kunit/qemu_config.py b/tools/testing/kunit/qemu_config.py
index 1672f6184e95..0b6a80398ccc 100644
--- a/tools/testing/kunit/qemu_config.py
+++ b/tools/testing/kunit/qemu_config.py
@@ -5,12 +5,15 @@
 # Copyright (C) 2021, Google LLC.
 # Author: Brendan Higgins <brendanhiggins@google.com>
 
-from collections import namedtuple
+from dataclasses import dataclass
+from typing import List
 
 
-QemuArchParams = namedtuple('QemuArchParams', ['linux_arch',
-					       'kconfig',
-					       'qemu_arch',
-					       'kernel_path',
-					       'kernel_command_line',
-					       'extra_qemu_params'])
+@dataclass(frozen=True)
+class QemuArchParams:
+  linux_arch: str
+  kconfig: str
+  qemu_arch: str
+  kernel_path: str
+  kernel_command_line: str
+  extra_qemu_params: List[str]
diff --git a/tools/testing/kunit/qemu_configs/alpha.py b/tools/testing/kunit/qemu_configs/alpha.py
index 5d0c0cff03bd..3ac846e03a6b 100644
--- a/tools/testing/kunit/qemu_configs/alpha.py
+++ b/tools/testing/kunit/qemu_configs/alpha.py
@@ -7,4 +7,4 @@ CONFIG_SERIAL_8250_CONSOLE=y''',
 			   qemu_arch='alpha',
 			   kernel_path='arch/alpha/boot/vmlinux',
 			   kernel_command_line='console=ttyS0',
-			   extra_qemu_params=[''])
+			   extra_qemu_params=[])
diff --git a/tools/testing/kunit/qemu_configs/arm.py b/tools/testing/kunit/qemu_configs/arm.py
index b9c2a35e0296..db2160200566 100644
--- a/tools/testing/kunit/qemu_configs/arm.py
+++ b/tools/testing/kunit/qemu_configs/arm.py
@@ -10,4 +10,4 @@ CONFIG_SERIAL_AMBA_PL011_CONSOLE=y''',
 			   qemu_arch='arm',
 			   kernel_path='arch/arm/boot/zImage',
 			   kernel_command_line='console=ttyAMA0',
-			   extra_qemu_params=['-machine virt'])
+			   extra_qemu_params=['-machine', 'virt'])
diff --git a/tools/testing/kunit/qemu_configs/arm64.py b/tools/testing/kunit/qemu_configs/arm64.py
index 517c04459f47..67d04064f785 100644
--- a/tools/testing/kunit/qemu_configs/arm64.py
+++ b/tools/testing/kunit/qemu_configs/arm64.py
@@ -9,4 +9,4 @@ CONFIG_SERIAL_AMBA_PL011_CONSOLE=y''',
 			   qemu_arch='aarch64',
 			   kernel_path='arch/arm64/boot/Image.gz',
 			   kernel_command_line='console=ttyAMA0',
-			   extra_qemu_params=['-machine virt', '-cpu cortex-a57'])
+			   extra_qemu_params=['-machine', 'virt', '-cpu', 'cortex-a57'])
diff --git a/tools/testing/kunit/qemu_configs/i386.py b/tools/testing/kunit/qemu_configs/i386.py
index aed3ffd3937d..4463ebefd567 100644
--- a/tools/testing/kunit/qemu_configs/i386.py
+++ b/tools/testing/kunit/qemu_configs/i386.py
@@ -4,7 +4,7 @@ QEMU_ARCH = QemuArchParams(linux_arch='i386',
 			   kconfig='''
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y''',
-			   qemu_arch='x86_64',
+			   qemu_arch='i386',
 			   kernel_path='arch/x86/boot/bzImage',
 			   kernel_command_line='console=ttyS0',
-			   extra_qemu_params=[''])
+			   extra_qemu_params=[])
diff --git a/tools/testing/kunit/qemu_configs/powerpc.py b/tools/testing/kunit/qemu_configs/powerpc.py
index 35e9de24f0db..7ec38d4131f7 100644
--- a/tools/testing/kunit/qemu_configs/powerpc.py
+++ b/tools/testing/kunit/qemu_configs/powerpc.py
@@ -9,4 +9,4 @@ CONFIG_HVC_CONSOLE=y''',
 			   qemu_arch='ppc64',
 			   kernel_path='vmlinux',
 			   kernel_command_line='console=ttyS0',
-			   extra_qemu_params=['-M pseries', '-cpu power8'])
+			   extra_qemu_params=['-M', 'pseries', '-cpu', 'power8'])
diff --git a/tools/testing/kunit/qemu_configs/riscv.py b/tools/testing/kunit/qemu_configs/riscv.py
index 9e528087cd7c..6207be146d26 100644
--- a/tools/testing/kunit/qemu_configs/riscv.py
+++ b/tools/testing/kunit/qemu_configs/riscv.py
@@ -21,11 +21,12 @@ CONFIG_SOC_VIRT=y
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_OF_PLATFORM=y
+CONFIG_RISCV_SBI_V01=y
 CONFIG_SERIAL_EARLYCON_RISCV_SBI=y''',
 			   qemu_arch='riscv64',
 			   kernel_path='arch/riscv/boot/Image',
 			   kernel_command_line='console=ttyS0',
 			   extra_qemu_params=[
-					   '-machine virt',
-					   '-cpu rv64',
-					   '-bios opensbi-riscv64-generic-fw_dynamic.bin'])
+					   '-machine', 'virt',
+					   '-cpu', 'rv64',
+					   '-bios', 'opensbi-riscv64-generic-fw_dynamic.bin'])
diff --git a/tools/testing/kunit/qemu_configs/s390.py b/tools/testing/kunit/qemu_configs/s390.py
index e310bd521113..98fa4fb60c0a 100644
--- a/tools/testing/kunit/qemu_configs/s390.py
+++ b/tools/testing/kunit/qemu_configs/s390.py
@@ -10,5 +10,5 @@ CONFIG_MODULES=y''',
 			   kernel_path='arch/s390/boot/bzImage',
 			   kernel_command_line='console=ttyS0',
 			   extra_qemu_params=[
-					   '-machine s390-ccw-virtio',
-					   '-cpu qemu',])
+					   '-machine', 's390-ccw-virtio',
+					   '-cpu', 'qemu',])
diff --git a/tools/testing/kunit/qemu_configs/sparc.py b/tools/testing/kunit/qemu_configs/sparc.py
index 27f474e7ad6e..e975c4331a7c 100644
--- a/tools/testing/kunit/qemu_configs/sparc.py
+++ b/tools/testing/kunit/qemu_configs/sparc.py
@@ -7,4 +7,4 @@ CONFIG_SERIAL_8250_CONSOLE=y''',
 			   qemu_arch='sparc',
 			   kernel_path='arch/sparc/boot/zImage',
 			   kernel_command_line='console=ttyS0 mem=256M',
-			   extra_qemu_params=['-m 256'])
+			   extra_qemu_params=['-m', '256'])
diff --git a/tools/testing/kunit/qemu_configs/x86_64.py b/tools/testing/kunit/qemu_configs/x86_64.py
index 77ab1aeee8a3..dc7949076863 100644
--- a/tools/testing/kunit/qemu_configs/x86_64.py
+++ b/tools/testing/kunit/qemu_configs/x86_64.py
@@ -7,4 +7,4 @@ CONFIG_SERIAL_8250_CONSOLE=y''',
 			   qemu_arch='x86_64',
 			   kernel_path='arch/x86/boot/bzImage',
 			   kernel_command_line='console=ttyS0',
-			   extra_qemu_params=[''])
+			   extra_qemu_params=[])
diff --git a/tools/testing/kunit/run_checks.py b/tools/testing/kunit/run_checks.py
index 13d854afca9d..066e6f938f6d 100755
--- a/tools/testing/kunit/run_checks.py
+++ b/tools/testing/kunit/run_checks.py
@@ -14,7 +14,7 @@ import shutil
 import subprocess
 import sys
 import textwrap
-from typing import Dict, List, Sequence, Tuple
+from typing import Dict, List, Sequence
 
 ABS_TOOL_PATH = os.path.abspath(os.path.dirname(__file__))
 TIMEOUT = datetime.timedelta(minutes=5).total_seconds()
diff --git a/tools/testing/kunit/test_data/test_is_test_passed-crash.log b/tools/testing/kunit/test_data/test_is_test_passed-crash.log
deleted file mode 100644
index 4d97f6708c4a..000000000000
--- a/tools/testing/kunit/test_data/test_is_test_passed-crash.log
+++ /dev/null
@@ -1,70 +0,0 @@
-printk: console [tty0] enabled
-printk: console [mc-1] enabled
-TAP version 14
-1..2
-	# Subtest: sysctl_test
-	1..8
-	# sysctl_test_dointvec_null_tbl_data: sysctl_test_dointvec_null_tbl_data passed
-	ok 1 - sysctl_test_dointvec_null_tbl_data
-	# sysctl_test_dointvec_table_maxlen_unset: sysctl_test_dointvec_table_maxlen_unset passed
-	ok 2 - sysctl_test_dointvec_table_maxlen_unset
-	# sysctl_test_dointvec_table_len_is_zero: sysctl_test_dointvec_table_len_is_zero passed
-	ok 3 - sysctl_test_dointvec_table_len_is_zero
-	# sysctl_test_dointvec_table_read_but_position_set: sysctl_test_dointvec_table_read_but_position_set passed
-	ok 4 - sysctl_test_dointvec_table_read_but_position_set
-	# sysctl_test_dointvec_happy_single_positive: sysctl_test_dointvec_happy_single_positive passed
-	ok 5 - sysctl_test_dointvec_happy_single_positive
-	# sysctl_test_dointvec_happy_single_negative: sysctl_test_dointvec_happy_single_negative passed
-	ok 6 - sysctl_test_dointvec_happy_single_negative
-	# sysctl_test_dointvec_single_less_int_min: sysctl_test_dointvec_single_less_int_min passed
-	ok 7 - sysctl_test_dointvec_single_less_int_min
-	# sysctl_test_dointvec_single_greater_int_max: sysctl_test_dointvec_single_greater_int_max passed
-	ok 8 - sysctl_test_dointvec_single_greater_int_max
-kunit sysctl_test: all tests passed
-ok 1 - sysctl_test
-	# Subtest: example
-	1..2
-init_suite
-	# example_simple_test: initializing
-Stack:
- 6016f7db 6f81bd30 6f81bdd0 60021450
- 6024b0e8 60021440 60018bbe 16f81bdc0
- 00000001 6f81bd30 6f81bd20 6f81bdd0
-Call Trace:
- [<6016f7db>] ? kunit_try_run_case+0xab/0xf0
- [<60021450>] ? set_signals+0x0/0x60
- [<60021440>] ? get_signals+0x0/0x10
- [<60018bbe>] ? kunit_um_run_try_catch+0x5e/0xc0
- [<60021450>] ? set_signals+0x0/0x60
- [<60021440>] ? get_signals+0x0/0x10
- [<60018bb3>] ? kunit_um_run_try_catch+0x53/0xc0
- [<6016f321>] ? kunit_run_case_catch_errors+0x121/0x1a0
- [<60018b60>] ? kunit_um_run_try_catch+0x0/0xc0
- [<600189e0>] ? kunit_um_throw+0x0/0x180
- [<6016f730>] ? kunit_try_run_case+0x0/0xf0
- [<6016f600>] ? kunit_catch_run_case+0x0/0x130
- [<6016edd0>] ? kunit_vprintk+0x0/0x30
- [<6016ece0>] ? kunit_fail+0x0/0x40
- [<6016eca0>] ? kunit_abort+0x0/0x40
- [<6016ed20>] ? kunit_printk_emit+0x0/0xb0
- [<6016f200>] ? kunit_run_case_catch_errors+0x0/0x1a0
- [<6016f46e>] ? kunit_run_tests+0xce/0x260
- [<6005b390>] ? unregister_console+0x0/0x190
- [<60175b70>] ? suite_kunit_initexample_test_suite+0x0/0x20
- [<60001cbb>] ? do_one_initcall+0x0/0x197
- [<60001d47>] ? do_one_initcall+0x8c/0x197
- [<6005cd20>] ? irq_to_desc+0x0/0x30
- [<60002005>] ? kernel_init_freeable+0x1b3/0x272
- [<6005c5ec>] ? printk+0x0/0x9b
- [<601c0086>] ? kernel_init+0x26/0x160
- [<60014442>] ? new_thread_handler+0x82/0xc0
-
-	# example_simple_test: kunit test case crashed!
-	# example_simple_test: example_simple_test failed
-	not ok 1 - example_simple_test
-	# example_mock_test: initializing
-	# example_mock_test: example_mock_test passed
-	ok 2 - example_mock_test
-kunit example: one or more tests failed
-not ok 2 - example
-List of all partitions:
diff --git a/tools/testing/kunit/test_data/test_is_test_passed-no_tests_no_plan.log b/tools/testing/kunit/test_data/test_is_test_passed-no_tests_no_plan.log
index dd873c981108..4f81876ee6f1 100644
--- a/tools/testing/kunit/test_data/test_is_test_passed-no_tests_no_plan.log
+++ b/tools/testing/kunit/test_data/test_is_test_passed-no_tests_no_plan.log
@@ -3,5 +3,5 @@ TAP version 14
   # Subtest: suite
   1..1
     # Subtest: case
-  ok 1 - case # SKIP
+  ok 1 - case
 ok 1 - suite

--------------D6FDE8FDC8613DE24C877C71--
