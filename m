Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36A4257B59B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 13:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237132AbiGTLfj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 07:35:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237865AbiGTLff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 07:35:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C82C27165;
        Wed, 20 Jul 2022 04:35:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 344AE60ADD;
        Wed, 20 Jul 2022 11:35:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DD28C341CA;
        Wed, 20 Jul 2022 11:35:31 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="ib6MxC3F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1658316930;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=maGCRrxRpHrSk2PNn1nY2bqa8mZP2c6t0ndugNv6oL0=;
        b=ib6MxC3FnDNkqhSrIqYaGOWQROdPk+nPkpxkg4BbjAxQySIRfiimy+giX5fmszMJboop79
        xt7lA4e6IuWpfqmy675b7ayCBHBPip3dOy7I2MQ7ExizwOPd/Zew2+x4ujNmFujsklGlZf
        DTf5VETcRG0vIzf5/suKivVrynSi/yE=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id f8dec305 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Wed, 20 Jul 2022 11:35:30 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Simon Sapin <simon.sapin@exyr.org>,
        Gabriel Somlo <somlo@cmu.edu>, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH] docs: ABI: correct QEMU fw_cfg spec path
Date:   Wed, 20 Jul 2022 13:35:18 +0200
Message-Id: <20220720113518.317032-1-Jason@zx2c4.com>
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
reflect this.

Cc: Simon Sapin <simon.sapin@exyr.org>
Cc: Gabriel Somlo <somlo@cmu.edu>
Cc: Jonathan Corbet <corbet@lwn.net>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 Documentation/ABI/testing/sysfs-firmware-qemu_fw_cfg | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-firmware-qemu_fw_cfg b/Documentation/ABI/testing/sysfs-firmware-qemu_fw_cfg
index ee0d6dbc810e..7cbce4af6346 100644
--- a/Documentation/ABI/testing/sysfs-firmware-qemu_fw_cfg
+++ b/Documentation/ABI/testing/sysfs-firmware-qemu_fw_cfg
@@ -12,7 +12,7 @@ Description:
 		configuration data to the guest userspace.
 
 		The authoritative guest-side hardware interface documentation
-		to the fw_cfg device can be found in "docs/specs/fw_cfg.txt"
+		to the fw_cfg device can be found in "docs/specs/fw_cfg.rst"
 		in the QEMU source tree.
 
 		**SysFS fw_cfg Interface**
-- 
2.35.1

