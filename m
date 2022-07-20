Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B91AC57B682
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 14:33:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240328AbiGTMdO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 08:33:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240138AbiGTMc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 08:32:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C6C674E0D;
        Wed, 20 Jul 2022 05:31:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 48231613EF;
        Wed, 20 Jul 2022 12:31:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 190B6C3411E;
        Wed, 20 Jul 2022 12:31:51 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="RR7Knc6d"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1658320309;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=udw1gJ5G/fQb+dSVU3NwYjqsSVcMKC4CPMZmBCkl8tw=;
        b=RR7Knc6dhS7KqM1MkcjE726i+u7uFWgCnMxcBxgXb8z1Fg2qQ7CdnY/U1gFhfC86G6yibP
        65NtICLjHFhykOdc85cxHsPySmspjcmI2FMPa6hvjFEb4CB4mup0mzEhIYAhy+aD8wjwNf
        qKJ9l/0nMUVqYmj1qxCpAP0DeNpFf58=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 4f68cf00 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Wed, 20 Jul 2022 12:31:49 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Simon Sapin <simon.sapin@exyr.org>,
        Gabriel Somlo <somlo@cmu.edu>
Subject: [PATCH v2] docs: ABI: correct QEMU fw_cfg spec path
Date:   Wed, 20 Jul 2022 14:31:31 +0200
Message-Id: <20220720123131.341755-1-Jason@zx2c4.com>
In-Reply-To: <CAHmME9rsHKwQ3gDbMLUaN978QaBdNRj87VNgDXc-FUGHZ6APNg@mail.gmail.com>
References: <CAHmME9rsHKwQ3gDbMLUaN978QaBdNRj87VNgDXc-FUGHZ6APNg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A few weeks ago, QEMU switched docs/specs/fw_cfg.txt to be
docs/specs/fw_cfg.rst, so update the reference in the kernel docs to
reflect this. Also add a link to the online documentation to make it
easier to find.

Cc: Simon Sapin <simon.sapin@exyr.org>
Cc: Gabriel Somlo <somlo@cmu.edu>
Cc: Jonathan Corbet <corbet@lwn.net>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 Documentation/ABI/testing/sysfs-firmware-qemu_fw_cfg | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-firmware-qemu_fw_cfg b/Documentation/ABI/testing/sysfs-firmware-qemu_fw_cfg
index ee0d6dbc810e..54d1bfd0db12 100644
--- a/Documentation/ABI/testing/sysfs-firmware-qemu_fw_cfg
+++ b/Documentation/ABI/testing/sysfs-firmware-qemu_fw_cfg
@@ -12,8 +12,9 @@ Description:
 		configuration data to the guest userspace.
 
 		The authoritative guest-side hardware interface documentation
-		to the fw_cfg device can be found in "docs/specs/fw_cfg.txt"
-		in the QEMU source tree.
+		to the fw_cfg device can be found in "docs/specs/fw_cfg.rst"
+		in the QEMU source tree, or online at:
+		https://qemu-project.gitlab.io/qemu/specs/fw_cfg.html
 
 		**SysFS fw_cfg Interface**
 
-- 
2.35.1

