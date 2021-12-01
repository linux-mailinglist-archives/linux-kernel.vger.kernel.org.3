Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCC06464F29
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 14:52:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349991AbhLANzZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 08:55:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349777AbhLANxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 08:53:38 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0706C061759;
        Wed,  1 Dec 2021 05:50:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 19628CE1EC8;
        Wed,  1 Dec 2021 13:50:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AA46C53FAD;
        Wed,  1 Dec 2021 13:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638366607;
        bh=oTNEkjztmoHKYfwnF72Wso6inMuAqq2rvOkqi/QzePE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bm5twlth0wPVB8c9it8RmR9e4/uZ6gu3klTEzWeMSAjGTWmFIktDaP38VFMRc2bQf
         LhOP9IKIP+qpVKrqxucMeopqWgwGhadK1bxH14tW9rR4NgVnoUnIGolKhOG5s+tm2E
         KUDbT1d1fwe958uio3gSN5UiNuqC2OmubHs2+wz0AIGK/5Ou99L6d0Q6js7w1YlI+z
         h2C88IzAao9++y8w15QS3h8WbnhNwAaNK3FNnJoTaqGubo0A9DjZhVSjU/0k1ebhU6
         W/5LdtUPWQbQgExQYSMIALzpnbXhsZ4j74k0g1JI/ZidU1OzL3+c1h1VQZ5NHBgFbE
         J8yJqgsyGkFMA==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1msPzp-004F8O-6o; Wed, 01 Dec 2021 14:50:05 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Akira Yokosawa" <akiyks@gmail.com>,
        "Jani Nikula" <jani.nikula@linux.intel.com>,
        "Randy Dunlap" <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/4] docs: set format for the classic mode
Date:   Wed,  1 Dec 2021 14:50:03 +0100
Message-Id: <dfacb0768c0a934fff20e0449526ef2956c79baa.1638366497.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1638366497.git.mchehab+huawei@kernel.org>
References: <cover.1638366497.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When RTD is not installed or when THEME=classic is used, the
produced docs contain some weird selections. As this theme has
several variables to customize it, set them, in order to produce
a nicer output.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---

See [PATCH v2 0/4] at: https://lore.kernel.org/all/cover.1638366497.git.mchehab+huawei@kernel.org/

 Documentation/conf.py | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/Documentation/conf.py b/Documentation/conf.py
index 0e2593e4d357..d1b6f602b34d 100644
--- a/Documentation/conf.py
+++ b/Documentation/conf.py
@@ -244,6 +244,36 @@ if major <= 1 and minor < 8:
     for l in html_css_files:
         html_context['css_files'].append('_static/' + l)
 
+if  html_theme == 'classic':
+    html_theme_options = {
+        'rightsidebar':        False,
+        'stickysidebar':       True,
+        'collapsiblesidebar':  True,
+        'externalrefs':        False,
+
+        'footerbgcolor':       "white",
+        'footertextcolor':     "white",
+        'sidebarbgcolor':      "white",
+        'sidebarbtncolor':     "black",
+        'sidebartextcolor':    "black",
+        'sidebarlinkcolor':    "#686bff",
+        'relbarbgcolor':       "#133f52",
+        'relbartextcolor':     "white",
+        'relbarlinkcolor':     "white",
+        'bgcolor':             "white",
+        'textcolor':           "black",
+        'headbgcolor':         "#f2f2f2",
+        'headtextcolor':       "#20435c",
+        'headlinkcolor':       "#c60f0f",
+        'linkcolor':           "#355f7c",
+        'visitedlinkcolor':    "#355f7c",
+        'codebgcolor':         "#3f3f3f",
+        'codetextcolor':       "white",
+
+        'bodyfont':            "serif",
+        'headfont':            "sans-serif",
+    }
+
 sys.stderr.write("Using %s theme\n" % html_theme)
 
 # Theme options are theme-specific and customize the look and feel of a theme
-- 
2.33.1

