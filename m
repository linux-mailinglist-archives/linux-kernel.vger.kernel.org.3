Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B1D45A39C4
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 21:39:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231760AbiH0Tjj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Aug 2022 15:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231481AbiH0Tjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 15:39:36 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEAFA4B0C4;
        Sat, 27 Aug 2022 12:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=t63ek6wzn1sWs76eOsCuIOgWn2uP5FVAKK7B50IIh4U=; b=K7t3NDw3OclQKkVe6WtTNwQyKi
        svTVu5fXZrvNG3JQT/z0IU8aUNhm88NQaBz0oMVZblr8jLDbCcdRlt+y8czWf3YtGaJ9pdmsq2/X7
        MYlxCsStEwCzdroDqzVPVKzBPFUbw/Cm8FdJ9Wry4FRuofNpPceo4LCcMxfcqN/nfCU9Xnpvczl/1
        u0NtcyW59F8sQpWchIwmRXqkrVd3mxnWeQYK5SfqR/sGpa6maUW6BiVQ2c2rP73GwMr3lWx/rgbqO
        ICtBIQAGuL8sF29MQKtKXe0Ba7NkJJgUB0R7Q5CG9Nv8pu6GfBVXdTZiHJPoPVnPD6P3cF9iX1S6l
        JuKg+G0A==;
Received: from [2601:1c0:6280:3f0::a6b3] (helo=casper.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oS1eV-001eoZ-3M; Sat, 27 Aug 2022 19:39:31 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Bernie Thompson <bernie@plugable.com>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Helge Deller <deller@gmx.de>, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org
Subject: [PATCH] Documentation: fb: udlfb: clean up text and formatting
Date:   Sat, 27 Aug 2022 12:39:25 -0700
Message-Id: <20220827193925.19612-1-rdunlap@infradead.org>
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
---
 Documentation/fb/udlfb.rst |   18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

--- a/Documentation/fb/udlfb.rst
+++ b/Documentation/fb/udlfb.rst
@@ -86,17 +86,21 @@ Module Options
 Special configuration for udlfb is usually unnecessary. There are a few
 options, however.
 
-From the command line, pass options to modprobe
-modprobe udlfb fb_defio=0 console=1 shadow=1
+From the command line, pass options to modprobe::
 
-Or modify options on the fly at /sys/module/udlfb/parameters directory via
-sudo nano fb_defio
-change the parameter in place, and save the file.
+  modprobe udlfb fb_defio=0 console=1 shadow=1
+
+Or modify options on the fly at /sys/module/udlfb/parameters directory via::
+
+  sudo nano fb_defio
+  change the parameter in place, and save the file.
 
 Unplug/replug USB device to apply with new settings
 
-Or for permanent option, create file like /etc/modprobe.d/udlfb.conf with text
-options udlfb fb_defio=0 console=1 shadow=1
+Or for permanent options, create a file like /etc/modprobe.d/udlfb.conf
+with text::
+
+  options udlfb fb_defio=0 console=1 shadow=1
 
 Accepted boolean options:
 
