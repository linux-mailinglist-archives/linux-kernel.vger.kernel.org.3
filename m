Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2472346B829
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 10:55:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234694AbhLGJ4t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 04:56:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234557AbhLGJ4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 04:56:41 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF02AC061746;
        Tue,  7 Dec 2021 01:53:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 48106CE1A3F;
        Tue,  7 Dec 2021 09:53:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70698C341C6;
        Tue,  7 Dec 2021 09:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638870787;
        bh=XujkVJhQLz9DC5cMtcVUHh6OtXlgalOoprRpsJMwWRQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OcL6FbIKmrHgzPZgRkZGtX1bY71FTrnNGXG0nCTx++2ziABo4bLXZlTJwdl+9wGYD
         pA7BHN/zawXR9xYCNxaHZn9qu5ZtLcg/5OkN2OgRjGu26syVpMIvYGrJli+ONtmx1G
         Tjxg7/HP9wkyCDWoIS5P4mVzHvH5eAaevOSuCE/as5Dm7z3Yyd9uXec3QXo98QhIWP
         At/fPmJ9InZ8RUcE0QQXCOV/3IAHNM77CKbtNsg+f2kFBxXKJVdH9bcjOoWKXpVlX6
         VphHO1axHc/7yb7hYGtOKOdQ5alF6AvxFuDVtFANeQc/uEB+61nb7pxo1+qwHE1YmG
         lJDti1B+1yf9A==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1muX9l-00BVtK-9o; Tue, 07 Dec 2021 10:53:05 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Akira Yokosawa" <akiyks@gmail.com>,
        "Jani Nikula" <jani.nikula@linux.intel.com>,
        "Randy Dunlap" <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/4] docs: set format for the classic mode
Date:   Tue,  7 Dec 2021 10:53:01 +0100
Message-Id: <8889380606681a2b7033f73bed9717250302be2a.1638870323.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1638870323.git.mchehab+huawei@kernel.org>
References: <cover.1638870323.git.mchehab+huawei@kernel.org>
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

See [PATCH v4 0/4] at: https://lore.kernel.org/all/cover.1638870323.git.mchehab+huawei@kernel.org/

 Documentation/conf.py | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/Documentation/conf.py b/Documentation/conf.py
index 923496396c3f..c8efe82d1404 100644
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

