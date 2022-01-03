Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD926482D67
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 02:24:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231284AbiACBYF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jan 2022 20:24:05 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:32936 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbiACBYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jan 2022 20:24:04 -0500
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id A810772C90A;
        Mon,  3 Jan 2022 04:24:02 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id 7A7117CCA32; Mon,  3 Jan 2022 04:24:02 +0300 (MSK)
Date:   Mon, 3 Jan 2022 04:24:02 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] usr/include/Makefile: add linux/nfc.h to the compile-test
 coverage
Message-ID: <20220103012402.GA25177@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As linux/nfc.h userspace compilation was finally fixed by commits
79b69a83705e621b258ac6d8ae6d3bfdb4b930aa and
7175f02c4e5f5a9430113ab9ca0fd0ce98b28a51, there is no need to keep
the compile-test exception for it in usr/include/Makefile.

Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
---
 usr/include/Makefile | 1 -
 1 file changed, 1 deletion(-)

diff --git a/usr/include/Makefile b/usr/include/Makefile
index 1c2ae1368079..295d51e6ade0 100644
--- a/usr/include/Makefile
+++ b/usr/include/Makefile
@@ -34,7 +34,6 @@ no-header-test += linux/hdlc/ioctl.h
 no-header-test += linux/ivtv.h
 no-header-test += linux/kexec.h
 no-header-test += linux/matroxfb.h
-no-header-test += linux/nfc.h
 no-header-test += linux/omap3isp.h
 no-header-test += linux/omapfb.h
 no-header-test += linux/patchkey.h

-- 
ldv
