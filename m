Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5521754F47D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 11:39:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381214AbiFQJjr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 05:39:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380297AbiFQJjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 05:39:43 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1D0F6899F;
        Fri, 17 Jun 2022 02:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655458783; x=1686994783;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=pjGPnmtr0TEkG61G5nnq7wf+ldeKjCmAuajMs62W8ps=;
  b=Oluwt18SHzy4KCPV36DMY2ovkdo4L95MAjxHHw0uhzT4ln+0/Idna8se
   3c8awuEIpHtpf10WW4mNjaJPvEfPPeWfeph39RifPCHFT1MeUBGUU2xj7
   f9pJzFOk2ugsNuchMsbr/0C8DXEj5hkUR+Z1OhZyaeLOiU7eQBjLgAV3g
   flw16tP2+EhC3QvT17UZLNUHjCPojiDta3RWz8z6/crHkFvNUjKdTxdqu
   OhycNEOVIosj9vwtNk89B+YIHM80dwvgeLXqzLwNqKJETsTZ/azeSuJHR
   0qikThsbCcKnwAtn0C8XdUkpBB1RP+F5kz/76a3aa69O1140BgNnajyed
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="280177532"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="280177532"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2022 02:39:42 -0700
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="641970175"
Received: from ssinisal-mobl.ger.corp.intel.com ([10.249.40.194])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2022 02:39:36 -0700
Date:   Fri, 17 Jun 2022 12:39:29 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
cc:     Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH] MAINTAINERS: Update DW 8250 UART maintainership
Message-ID: <be58b398-71ff-7c12-1bf1-a09181d9c80@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-878701769-1655458778=:1822"
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-878701769-1655458778=:1822
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

Add myself as maintainer for DW 8250 UART and up it to Supported.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

---
 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index a6d3bd9d2a8d..6c90484f395b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19230,8 +19230,9 @@ F:	Documentation/devicetree/bindings/gpio/snps,creg-gpio.txt
 F:	drivers/gpio/gpio-creg-snps.c
 
 SYNOPSYS DESIGNWARE 8250 UART DRIVER
+M:	Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
 R:	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
-S:	Maintained
+S:	Supported
 F:	drivers/tty/serial/8250/8250_dw.c
 F:	drivers/tty/serial/8250/8250_dwlib.*
 F:	drivers/tty/serial/8250/8250_lpss.c

-- 
tg: (f2906aa86338..) dw/maintainer (depends on: tty-next)
--8323329-878701769-1655458778=:1822--
