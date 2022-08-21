Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB87059B201
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 07:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbiHUFLr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 01:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiHUFLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 01:11:46 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FE7223149
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 22:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=t5lzcgBW/JvW1f3MFqASyT7ZeCF9DNurgjc7DhLcNv4=; b=f4Her1OlLR97za2/OPRL8dXhMn
        gzsa8wW2ynMKnC8/epKG2O+2pIxS5hZ/Vc1ZbobYpjDcBsVjZZaL9PjcRI/n8EmZtNZ2UUkTAa93i
        jW5V3PqsyPTQv8jbL/4uxr075JRrVFl/jFYW0oerySIy22NQGnuP8qRdKruFu6XSn8ZDvhtH6Ol81
        /CCoO+THkCOw7Smaw0PLjbPigaYMwNmC0mqUtH3/26poDnZwQMPaTs4wb6YRzaSC6VzYUibVEUWFl
        6bMGAgZMMdn2Ssi1zWUXfnjbRmJoW2jn/p5v5jDss8i/C/3ot1YucTPAp0Pr4xZL9dkmWSslOz1ls
        ovcdEkBQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1oPdEm-006aqL-LW;
        Sun, 21 Aug 2022 05:11:04 +0000
Date:   Sun, 21 Aug 2022 06:11:04 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [ammarfaizi2-block:viro/vfs/work.termios2 4/8]
 arch/alpha/kernel/termios.c:5:5: warning: no previous prototype for
 'user_termio_to_kernel_termios'
Message-ID: <YwG+aJKsnkurbSC6@ZenIV>
References: <202208211203.xvc2wVjR-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202208211203.xvc2wVjR-lkp@intel.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 21, 2022 at 12:07:05PM +0800, kernel test robot wrote:
> tree:   https://github.com/ammarfaizi2/linux-block viro/vfs/work.termios2
> head:   efc5ae91c846283431afc7bfc57e947bf1fd4158
> commit: 7f3d795b7f3bd329e9b0eea427bcbbf205ee60d5 [4/8] termios: start unifying non-UAPI parts of asm/termios.h
> config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20220821/202208211203.xvc2wVjR-lkp@intel.com/config)
> compiler: alpha-linux-gcc (GCC) 12.1.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/ammarfaizi2/linux-block/commit/7f3d795b7f3bd329e9b0eea427bcbbf205ee60d5
>         git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
>         git fetch --no-tags ammarfaizi2-block viro/vfs/work.termios2
>         git checkout 7f3d795b7f3bd329e9b0eea427bcbbf205ee60d5
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=alpha SHELL=/bin/bash arch/alpha/kernel/

Fixed and folded; incremental is

diff --git b/arch/alpha/kernel/termios.c a/arch/alpha/kernel/termios.c
index 1534f39cb9fe..a4c29a22edf7 100644
--- b/arch/alpha/kernel/termios.c
+++ a/arch/alpha/kernel/termios.c
@@ -1,6 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <linux/uaccess.h>
-#include <linux/termios.h>
+#include <linux/termios_internal.h>
 
 int user_termio_to_kernel_termios(struct ktermios *termios,
 						struct termio __user *termio)
diff --git b/arch/sparc/kernel/termios.c a/arch/sparc/kernel/termios.c
index 97e23d4ae2e2..ee64965c27cd 100644
--- b/arch/sparc/kernel/termios.c
+++ a/arch/sparc/kernel/termios.c
@@ -1,5 +1,5 @@
-#include <linux/uaccess.h>
-#include <linux/termios.h>
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/termios_internal.h>
 
 /*
  * c_cc characters in the termio structure.  Oh, how I love being
