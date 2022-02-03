Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 639FE4A86D3
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 15:46:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349502AbiBCOpc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 09:45:32 -0500
Received: from mga09.intel.com ([134.134.136.24]:33600 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234084AbiBCOpb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 09:45:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643899531; x=1675435531;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=hPnbLnVTaq48D56gqfE1aYhZMSXI1G3oHxS79ov0u2E=;
  b=Lr5docwnISbj5+x3SDc72ycV0FQim2KgUchAIhZ2BuPbZXFBJ5hhAi5L
   nJN06FFF8OKmcSE4p6PCFhrw2/ABohX2Poamov8Qwrytq0LEGmLGr0YTE
   8O5L/UE3a4LvVoLwf90OYpc6P9DfQhjiHRRBvkIa6dl2zHZpvD/O1Gx/x
   en29ajChJ2nnWV3/ui77iHCMX/hh3MaTqVquai4UlGf6MdXaKar/0pkoc
   X86o3QmIcDShaR1NM3Ssywo2XRX48K7QH35kztLjB7R+L4qQVKaoBGUFu
   k3Q0xrm/bnt/bWSSenGS/GksUwTkGIm6MpZDm6/svwj+mpyHQ34qDs0gc
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10246"; a="247921009"
X-IronPort-AV: E=Sophos;i="5.88,340,1635231600"; 
   d="scan'208,223";a="247921009"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2022 06:45:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,340,1635231600"; 
   d="scan'208,223";a="771794714"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 03 Feb 2022 06:45:09 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id B4195204; Thu,  3 Feb 2022 16:45:23 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Johan Hovold <johan@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH v1 1/1] serial: core: Fix the definition name in the comment of UPF_* flags
Date:   Thu,  3 Feb 2022 16:45:21 +0200
Message-Id: <20220203144521.16457-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From day 1 the UPF_LAST_USER wasn't defined, a specific number of
the last bit for userspace. Instead the code always relies on
ASYNCB_LAST_USER. Fix comment accordingly.

Fixes: 904326ecac02 ("tty,serial: Unify UPF_* and ASYNC_* flag definitions")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/serial_core.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 9c501dfbaa17..35609821abbf 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -171,7 +171,7 @@ struct uart_port {
 	 * assigned from the serial_struct flags in uart_set_info()
 	 * [for bit definitions in the UPF_CHANGE_MASK]
 	 *
-	 * Bits [0..UPF_LAST_USER] are userspace defined/visible/changeable
+	 * Bits [0..ASYNCB_LAST_USER] are userspace defined/visible/changeable
 	 * The remaining bits are serial-core specific and not modifiable by
 	 * userspace.
 	 */
-- 
2.34.1

