Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0B785A3F6E
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Aug 2022 21:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbiH1TZQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 15:25:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbiH1TZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 15:25:15 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AB0721278;
        Sun, 28 Aug 2022 12:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=zAHYVCWMSa2GkiBj19jjzwY2RqRsZ7LJnQxJnAPq1zg=; b=P8V23faQAMfvwOClKJ6XIrXpzc
        KjvzHK7UOfyVy5euPzpRpwmPhLitNhoO1U1LzN8AITpRZSZbQbMW7NV05FfFcuPV0YVfaEnH8mjCS
        gzTsXoBKPMZ6s2VWNGXcID7GDzzv7T/aEIRQcu5I7YrNv0QbqwehoYqNevXumHr2RlVN8YWn+FrPf
        DPyFU/tqyX8J9yYsmm40FlH9uyGArTnvcwKOo+EXSkluSDpx3S6g7ncmDSd7Y0fzAD7WHJQNQLli0
        AO6xPgDTmdR4cq3W7cThLVs1WfS89quANJpwPMk0IzC1LuAPO+reGc8QqcZr07E8rA/Nh0XCFSVg1
        s4NeraQQ==;
Received: from [2601:1c0:6280:3f0::a6b3] (helo=casper.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oSNu7-002SHO-D7; Sun, 28 Aug 2022 19:25:07 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Bernie Thompson <bernie@plugable.com>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Helge Deller <deller@gmx.de>, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH v2] Documentation: fb: udlfb: clean up text and formatting
Date:   Sun, 28 Aug 2022 12:25:01 -0700
Message-Id: <20220828192501.14232-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up punctuation, spelling, and formatting for command line usage
and modprobe config file usage in udlfb.rst.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Bernie Thompson <bernie@plugable.com>
Cc: linux-fbdev@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: Helge Deller <deller@gmx.de>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: Bagas Sanjaya <bagasdotme@gmail.com>
---
v2: use some text suggestions from Bagas Sanjaya (Thanks);
    add a '.' at the end of a sentence.

 Documentation/fb/udlfb.rst |   23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

--- a/Documentation/fb/udlfb.rst
+++ b/Documentation/fb/udlfb.rst
@@ -86,17 +86,24 @@ Module Options
 Special configuration for udlfb is usually unnecessary. There are a few
 options, however.
 
-From the command line, pass options to modprobe
-modprobe udlfb fb_defio=0 console=1 shadow=1
+From the command line, pass options to modprobe::
 
-Or modify options on the fly at /sys/module/udlfb/parameters directory via
-sudo nano fb_defio
-change the parameter in place, and save the file.
+  modprobe udlfb fb_defio=0 console=1 shadow=1
 
-Unplug/replug USB device to apply with new settings
+Or change options on the fly by editing
+/sys/module/udlfb/parameters/PARAMETER_NAME ::
 
-Or for permanent option, create file like /etc/modprobe.d/udlfb.conf with text
-options udlfb fb_defio=0 console=1 shadow=1
+  cd /sys/module/udlfb/parameters
+  ls # to see a list of parameter names
+  sudo nano PARAMETER_NAME
+  # change the parameter in place, and save the file.
+
+Unplug/replug USB device to apply with new settings.
+
+Or to apply options permanently, create a modprobe configuration file
+like /etc/modprobe.d/udlfb.conf with text::
+
+  options udlfb fb_defio=0 console=1 shadow=1
 
 Accepted boolean options:
 
