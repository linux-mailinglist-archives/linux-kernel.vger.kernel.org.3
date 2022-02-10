Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A6CC4B1638
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 20:23:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343934AbiBJTWk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 14:22:40 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234293AbiBJTWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 14:22:39 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04F5A243;
        Thu, 10 Feb 2022 11:22:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B60D9B82724;
        Thu, 10 Feb 2022 19:22:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CF6EC004E1;
        Thu, 10 Feb 2022 19:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644520956;
        bh=i9p/C04oLaJhQ1HLauMZWaBu/+UdNoIBcrEvFn3VHrY=;
        h=From:To:Cc:Subject:Date:From;
        b=LQkmUJI8gX8F2NqugLnHrgVCbVvtV6oqbvA59w+lvhEFb/mKa/STXNhMm2mvGLQQv
         eHW3MfwRH/OggO/FuwB0NyfRHuTTnbpuN2udp+y0kulVzBNwjm5uEnqwGUTTgooRYb
         Zs+t7bISXhC2+xVq/ejLCcbn9kqnBeC1tQ1lL8t0NzV3L+fJv5XiHlI3P/U8H8qIQk
         esyuap+XmiPAD7rqCyVgRv6mhknIlFCoghphic/EdrOOREt8GY23g62kJKJbmea54P
         M6c1nbSOVVi/3Phw/DTF6pvgLm6D4cme6mpMRFMjEAXndSQxg/ob9qvDcNsRCs/fI/
         VAI4seVDaLf0g==
Received: by pali.im (Postfix)
        id 55EBCA55; Thu, 10 Feb 2022 20:22:33 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Phillip Potter <phil@philpotter.co.uk>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Documentation: Fix links for udftools project and pktcdvd tool
Date:   Thu, 10 Feb 2022 20:22:00 +0100
Message-Id: <20220210192200.30828-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 Documentation/cdrom/packet-writing.rst             | 4 ++--
 Documentation/userspace-api/ioctl/ioctl-number.rst | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/cdrom/packet-writing.rst b/Documentation/cdrom/packet-writing.rst
index c5c957195a5a..43db58c50d29 100644
--- a/Documentation/cdrom/packet-writing.rst
+++ b/Documentation/cdrom/packet-writing.rst
@@ -11,7 +11,7 @@ Getting started quick
 - Compile and install kernel and modules, reboot.
 
 - You need the udftools package (pktsetup, mkudffs, cdrwtool).
-  Download from http://sourceforge.net/projects/linux-udf/
+  Download from https://github.com/pali/udftools
 
 - Grab a new CD-RW disc and format it (assuming CD-RW is hdc, substitute
   as appropriate)::
@@ -102,7 +102,7 @@ Using the pktcdvd sysfs interface
 
 Since Linux 2.6.20, the pktcdvd module has a sysfs interface
 and can be controlled by it. For example the "pktcdvd" tool uses
-this interface. (see http://tom.ist-im-web.de/download/pktcdvd )
+this interface. (see http://tom.ist-im-web.de/linux/software/pktcdvd )
 
 "pktcdvd" works similar to "pktsetup", e.g.::
 
diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
index cfe6cccf0f44..d8d9eabe12c3 100644
--- a/Documentation/userspace-api/ioctl/ioctl-number.rst
+++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
@@ -253,7 +253,7 @@ Code  Seq#    Include File                                           Comments
 'l'   00-3F  linux/tcfs_fs.h                                         transparent cryptographic file system
                                                                      <http://web.archive.org/web/%2A/http://mikonos.dia.unisa.it/tcfs>
 'l'   40-7F  linux/udf_fs_i.h                                        in development:
-                                                                     <http://sourceforge.net/projects/linux-udf/>
+                                                                     <https://github.com/pali/udftools>
 'm'   00-09  linux/mmtimer.h                                         conflict!
 'm'   all    linux/mtio.h                                            conflict!
 'm'   all    linux/soundcard.h                                       conflict!
-- 
2.20.1

