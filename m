Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5414954AB16
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 09:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355323AbiFNHwZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 03:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355309AbiFNHvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 03:51:54 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05D0541325;
        Tue, 14 Jun 2022 00:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655193071; x=1686729071;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=W3BLPE/LIaAK46lhfKOSyddpUsD8feI1Cn6S8ocKVYw=;
  b=D6glJPUHx47Ncxc1EjEVUvf0Lr9hy6EX7I2AN+ycnCkXlOyyZWiKsqq2
   HJC5StY4wqKKDdDHNfH/NTvnukKzBXPbsSp/RG7Ww+3KimS+8/bTyc6Oa
   7Aj49UXm6sEDToGCVwGQHsBEbs4boQ5OYHJyY71MJ7nsGHQ5TpbvMwPoG
   zav0hA7zPwsO/hSk8cKQr4mfciPXgVRgmV1vffOWA3kzNr+sIrGKbH4C1
   eT1bN7WRqjYYUUVxedOuF50EP0u4Re/lIjp2NZWrP1KQnt4iGxpIwtIG7
   CwDjJqgcqyjaMWXPAF+OM+sxA0MeYo30/hNfjOr+1h33TEPWpIE1JKfuf
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10377"; a="303948734"
X-IronPort-AV: E=Sophos;i="5.91,299,1647327600"; 
   d="scan'208";a="303948734"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2022 00:51:10 -0700
X-IronPort-AV: E=Sophos;i="5.91,299,1647327600"; 
   d="scan'208";a="640202481"
Received: from jlaghzal-mobl1.ger.corp.intel.com ([10.252.32.175])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2022 00:51:08 -0700
Date:   Tue, 14 Jun 2022 10:50:54 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>
cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH] tty: Add closing marker into comment in tty_ldisc.h
Message-ID: <9bc6d45d-48c8-519-1646-78ba22505b1f@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1457515282-1655193070=:1605"
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1457515282-1655193070=:1605
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

The closing `` is missing. Add it.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Fixes: 6bb6fa6908eb ("tty: Implement lookahead to process XON/XOFF timely")
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

---
 include/linux/tty_ldisc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/tty_ldisc.h b/include/linux/tty_ldisc.h
index 33678e1936f6..ede6f2157f32 100644
--- a/include/linux/tty_ldisc.h
+++ b/include/linux/tty_ldisc.h
@@ -187,7 +187,7 @@ int ldsem_down_write_nested(struct ld_semaphore *sem, int subclass,
  *	function for automatic flow control.
  *
  * @lookahead_buf: [DRV] ``void ()(struct tty_struct *tty,
- *			const unsigned char *cp, const char *fp, int count)
+ *			const unsigned char *cp, const char *fp, int count)``
  *
  *	This function is called by the low-level tty driver for characters
  *	not eaten by ->receive_buf() or ->receive_buf2(). It is useful for

-- 
tg: (65534736d9a5..) ldisc/comment-fix (depends on: tty-next)
--8323329-1457515282-1655193070=:1605--
