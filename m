Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A116D46548D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 18:59:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244293AbhLASC7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 13:02:59 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:38480 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244488AbhLASCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 13:02:35 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E539BB820D5;
        Wed,  1 Dec 2021 17:59:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98022C53FD4;
        Wed,  1 Dec 2021 17:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638381551;
        bh=Tt2xl1rtK0Ad1INSFike/R9KEcFXwVEFagzX7PzVvhg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LzKkLlU1PWVvbQlaeBQRoouzNhDhkN+QfHz2CxHLSfLqj303tqME8x71/j9ofGplt
         oh6zMo/CdvMXV4tb0kG/5e2Oc8xPpKUpOll1SArU9Pz8MehJZpLpPghopasDvxnnHt
         Rxbe9qC92DByg1tnEN2Cwrc3QJqpx2xfSq4NJSLIQSwUuhhw5OXF4yzeudjk3zjSEm
         nILxLLcACxxghHOY73amrYLyzG0SFhqbPXgS/SjYTrL6MAtM7fGB8jmjuWM1OKzAd1
         ggWeuwFg8ol7bsRm8DC8PBOumyipZtT39DyjbAzD9ThaoPMR8rMFCxRw6rLU/vZp1m
         IJQB9IEj55LoQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1msTsr-004I6q-F6; Wed, 01 Dec 2021 18:59:09 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Akira Yokosawa" <akiyks@gmail.com>,
        "Jani Nikula" <jani.nikula@linux.intel.com>,
        "Randy Dunlap" <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/4] docs: set format for the classic mode
Date:   Wed,  1 Dec 2021 18:59:07 +0100
Message-Id: <4ec2d5452ff8e6fb6561f792a4823d31a80626d8.1638369365.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1638369365.git.mchehab+huawei@kernel.org>
References: <cover.1638369365.git.mchehab+huawei@kernel.org>
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

See [PATCH v3 0/4] at: https://lore.kernel.org/all/cover.1638369365.git.mchehab+huawei@kernel.org/

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

