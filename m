Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF475586058
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 20:29:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237342AbiGaS2N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 14:28:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237195AbiGaS2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 14:28:10 -0400
Received: from aer-iport-3.cisco.com (aer-iport-3.cisco.com [173.38.203.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB19BBE30
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 11:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=1746; q=dns/txt; s=iport;
  t=1659292087; x=1660501687;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LGqx0vejJuAYae6H+nUIyKHFgbeJ8fzoZTLoDvP57Sw=;
  b=WNGw2C8KkZOcW1fui1yWGLxYdTqd+KaboIWNEhAdad9ejjzNnCiIxFLI
   R9zt8de1otciGxN2qEE/wgirC2i+Ggb0bQLwf5mi9emCziN8J1jHsO1wj
   QjqzxKKGhrt1DA0sIJP0CS7kDIqi4+TO3fpAhiBNECqnQbLjs8DL6MPB+
   U=;
X-IPAS-Result: =?us-ascii?q?A0AcAwDAyOZi/xbLJq1aHgEBCxIMggQLg3ssEkWNTIgQn?=
 =?us-ascii?q?HmBfAsBAQEPQgQBAYUGAoR1JjQJDgECBAEBAQEDAgMBAQEBAQEDAQEFAQEBA?=
 =?us-ascii?q?gEHBIEJE4V1hkMGMgFGECAxVxmCfYMbA6ZtgiuBAYRvhRKBPYl5hSc9BoFJR?=
 =?us-ascii?q?IR9hRGFbgSYBQMJBAcFSkQDCywPFgUICRcSEBACBBEaCwYDFj8JAgQOA0AID?=
 =?us-ascii?q?QMRBAMPGAkSCBAEBgMxDCULAxQMAQYDBgUDAQMbAxQDBSQHAxwPIw0NBB8dA?=
 =?us-ascii?q?wMFJQMCAhsHAgIDAgYVBgICNhg5CAQIBCsjDwUCBy8FBC8CHgQFBhEIAhYCB?=
 =?us-ascii?q?gQEBAQWAhAIAggnFwcTMxkBBVkQCSEcDhoQBQYTAyBvBQc+DygzNTwrHxsKg?=
 =?us-ascii?q?RIqKxUDBAQDAgYYAwMiAhAuMQMVBikTEi0JKnUJAgMibQMDBCouAwkhHwcJM?=
 =?us-ascii?q?B2YUIEOgmnBV4Nbn34aMadtei2WT6JQNIRQgWE8gVlNIxWDI1EZD44sFo4wQ?=
 =?us-ascii?q?jE7AgYLAQEDCY8GAQE?=
IronPort-Data: A9a23:FMw5DKu680jWOEndeo4iUFKzT+fnVDhfMUV32f8akzHdYApBsoF/q
 tZmKWyBb/uNYmXzeNl/PN+zpkMC7ZLVnYJgTQZo/ixjQSJEgMeUXt7xwmUckM+xwmwvaGo9s
 q3yv/GZdJhcokf0/0vraP65xZVF/fngbqLmD+LZMTxGSwZhSSMw4TpugOdRbrRA2bBVOCvQ/
 4KpyyHjEAX9gWQsbTlNs/vrRC5H5ZwehhtJ5jTSWtgT1LPuvyF9JI4SI6i3M0z5TuF8dgJtb
 7+epF0R1jqxEyYFUrtJoJ6iGqE5auK60Ty1t5Zjc/PKbi6uCcAF+v1T2PI0MS+7gtgS9jx74
 I0lWZeYEW/FMkBQ8QgQe0EwLs1wAUFJ0LSXLki1o5OC8xXfVlSv7LJiVRo7eoJNr46bAUkWn
 RAZADkAdFWIgPi7hev9Qeh3jcNlJ87uVG8dkig/lneCXbB8GcuFGf+iCdxwhF/cguhOEPnCe
 ccVdRJkbQ/LZFtEPVJ/5JcWx7343CCnLVW0rnqu+4MN3TWQ3jZYk77jN8jtdv2zV59ayxPwS
 mXuuj6R7gshHMCO1SGC2netmqnCkT6TcIEfGaaz8flpqFaT3GsWCQATE1yhrpGRhVSzVNFfA
 0gV/Dc+o68v8kCiUtj6WVu/unHslhodXcdAVu438geAzoLK7AuDQGsJVDhMbJohrsBeeNAx/
 laEhZboHTt1rPiTQG7b/baPpjT0Mi8QRYMfWRI5ocI+y4GLiOkOYtjnF76PzIbdYgXJJAzN
IronPort-HdrOrdr: A9a23:B8SIO6iWmVNI9/yY+So2CmJlG3BQXt8ji2hC6mlwRA09TyVXra
 yTdZMgpHvJYVkqNk3I9errBEDEewK+yXcX2/h1AV7dZmjbUQKTRekI0WKh+UyDJ8SUzIFgPM
 lbHpSWcOeRMbC/5vyKhjVR1L0bsb66zJw=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.93,206,1654560000"; 
   d="scan'208";a="3282106"
Received: from aer-iport-nat.cisco.com (HELO aer-core-1.cisco.com) ([173.38.203.22])
  by aer-iport-3.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 31 Jul 2022 18:27:00 +0000
Received: from hce-anki.rd.cisco.com ([10.47.79.243])
        by aer-core-1.cisco.com (8.15.2/8.15.2) with ESMTP id 26VIQpY2008219;
        Sun, 31 Jul 2022 18:27:00 GMT
From:   Hans-Christian Noren Egtvedt <hegtvedt@cisco.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, Kees Cook <keescook@chromium.org>,
        "Theodore Ts'o" <tytso@mit.edu>
Subject: [v4.9 PATCH 6/6] random: move rand_initialize() earlier
Date:   Sun, 31 Jul 2022 20:26:36 +0200
Message-Id: <20220731182635.1910069-7-hegtvedt@cisco.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220731182635.1910069-1-hegtvedt@cisco.com>
References: <20220731182635.1910069-1-hegtvedt@cisco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Outbound-SMTP-Client: 10.47.79.243, [10.47.79.243]
X-Outbound-Node: aer-core-1.cisco.com
X-Spam-Status: No, score=-10.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        SPF_HELO_PASS,SPF_NONE,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kees Cook <keescook@chromium.org>

Right now rand_initialize() is run as an early_initcall(), but it only
depends on timekeeping_init() (for mixing ktime_get_real() into the
pools). However, the call to boot_init_stack_canary() for stack canary
initialization runs earlier, which triggers a warning at boot:

random: get_random_bytes called from start_kernel+0x357/0x548 with crng_init=0

Instead, this moves rand_initialize() to after timekeeping_init(), and moves
canary initialization here as well.

Note that this warning may still remain for machines that do not have
UEFI RNG support (which initializes the RNG pools during setup_arch()),
or for x86 machines without RDRAND (or booting without "random.trust=on"
or CONFIG_RANDOM_TRUST_CPU=y).

Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
(cherry picked from commit d55535232c3dbde9a523a9d10d68670f5fe5dec3)

Adjusted to fit on top of linux-4.9.y branch, suspecting a wrongly
solved conflict when cherry picked earlier.
---
 init/main.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/init/main.c b/init/main.c
index 6bc1a3fa152..6537f51a0ba 100644
--- a/init/main.c
+++ b/init/main.c
@@ -500,13 +500,6 @@ asmlinkage __visible void __init start_kernel(void)
 	page_address_init();
 	pr_notice("%s", linux_banner);
 	setup_arch(&command_line);
-	/*
-	 * Set up the the initial canary and entropy after arch
-	 * and after adding latent and command line entropy.
-	 */
-	add_latent_entropy();
-	add_device_randomness(command_line, strlen(command_line));
-	boot_init_stack_canary();
 	mm_init_cpumask(&init_mm);
 	setup_command_line(command_line);
 	setup_nr_cpu_ids();
-- 
2.34.1

