Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83D3C595B4D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 14:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235373AbiHPMI3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 08:08:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235236AbiHPMHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 08:07:36 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C3EF558C;
        Tue, 16 Aug 2022 04:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660651079; x=1692187079;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FWpF8vLkYDl4M3MyshEfxpRafeqCfa7Sw6RRzait/5k=;
  b=XUAZ22TweaypUjnlaWTKw4oZTS8fs47d0+9W6BhLQKzJjjBeNe+0vc+s
   ZPEmQvEem2LAUkgxVMoonTNrsoya9aJxTqhDDKel4FLh9LqOvmUU/InXN
   uvxusMUgpw/YI6XNyt/E4L76JVLeGtuH48ErgvgZY5w6X3fGU3y9cxrlP
   ejxl5nkHVWPzzC8l7ArdFQKMr2IovpEvX/IFq27vK0aeoW0qMDY47e25X
   IzaKJdkhCW1Q55KtUu2p7OyPynbnzcGNCxGb9NvJU22f4g+pXMIqRfRuZ
   TZpS7w9YoawL31L+swc7zRpD+UncDxJtTZEPgwYbazs3Rk4KBd+kE1FP/
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10440"; a="356199319"
X-IronPort-AV: E=Sophos;i="5.93,240,1654585200"; 
   d="scan'208";a="356199319"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2022 04:57:59 -0700
X-IronPort-AV: E=Sophos;i="5.93,240,1654585200"; 
   d="scan'208";a="667080793"
Received: from tturcu-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.51.153])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2022 04:57:56 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Johan Hovold <johan@kernel.org>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 2/8] tty: Fix comment style in tty_termios_input_baud_rate()
Date:   Tue, 16 Aug 2022 14:57:33 +0300
Message-Id: <20220816115739.10928-3-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220816115739.10928-1-ilpo.jarvinen@linux.intel.com>
References: <20220816115739.10928-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add proper spacing to comment.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/tty_baudrate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/tty_baudrate.c b/drivers/tty/tty_baudrate.c
index 4e3fd756dfc7..f9b49939c27b 100644
--- a/drivers/tty/tty_baudrate.c
+++ b/drivers/tty/tty_baudrate.c
@@ -92,7 +92,7 @@ speed_t tty_termios_input_baud_rate(const struct ktermios *termios)
 	if (cbaud == B0)
 		return tty_termios_baud_rate(termios);
 
-	/* Magic token for arbitrary speed via c_ispeed*/
+	/* Magic token for arbitrary speed via c_ispeed */
 	if (cbaud == BOTHER)
 		return termios->c_ispeed;
 
-- 
2.30.2

