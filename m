Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C80246498A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 09:22:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347950AbhLAIZr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 03:25:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbhLAIZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 03:25:41 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9545EC061574;
        Wed,  1 Dec 2021 00:22:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id E1577CE1D7B;
        Wed,  1 Dec 2021 08:22:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F16BC53FD0;
        Wed,  1 Dec 2021 08:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638346937;
        bh=KP5FsdsK3MZHlEGGPQTwh5bo4RG8YZYm1ulDx4oq4SU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uErVmkylkSyZ2c/7C1LZX4Hff1uBPp8EGIrweoEsivNwpY6nHxVaPCdPh5HiVgWJl
         +qXicx08LuqDdxG3EE6cdMVo3Fl2PGDE53v2tXFMRKaHeInclFyAdrDY/r1VRC/QBA
         Z5KT2RZ60s1s4YpTnRC2Hg/711+dJcz5/806EPnD8ewGRRf4QNpqKLNm3KbAXDXiS+
         eWRepS4QzWJN3VO/0dm3NqBeXEJM/06w1MGXRFvPmegrElxfli8HqBbGVW7yFvgETh
         S8eh9wcZlQufq5Y86KDhcGcu7/Sp9glMiDS5puqEzsV3RxgtiFANqdx5U4DjGmM9gs
         TWZP69n6i4gNA==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1msKsY-0043DC-UM; Wed, 01 Dec 2021 09:22:14 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Akira Yokosawa" <akiyks@gmail.com>,
        "Jani Nikula" <jani.nikula@linux.intel.com>,
        "Randy Dunlap" <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] docs: add support for dark mode
Date:   Wed,  1 Dec 2021 09:22:03 +0100
Message-Id: <a973d72bc678443b9a0d672327a06595c665a4a8.1638346585.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1638346585.git.mchehab+huawei@kernel.org>
References: <cover.1638346585.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's an extension to RTD theme which allows to switch
between dark mode and normal one. Use it, if available.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH 0/1] at: https://lore.kernel.org/all/cover.1638346585.git.mchehab+huawei@kernel.org/

 Documentation/conf.py | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/conf.py b/Documentation/conf.py
index 76e5eb5cb62b..dfbd4dd4bc5e 100644
--- a/Documentation/conf.py
+++ b/Documentation/conf.py
@@ -216,6 +216,14 @@ try:
     import sphinx_rtd_theme
     html_theme = 'sphinx_rtd_theme'
     html_theme_path = [sphinx_rtd_theme.get_html_theme_path()]
+
+    # If dark mode is available, use it
+    try:
+        extensions.append('sphinx_rtd_dark_mode')
+        html_theme = 'sphinx_rtd_dark_mode'
+    except:
+        pass
+
 except ImportError:
     sys.stderr.write('Warning: The Sphinx \'sphinx_rtd_theme\' HTML theme was not found. Make sure you have the theme installed to produce pretty HTML output. Falling back to the default theme.\n')
 
-- 
2.33.1

