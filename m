Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0423471305
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 09:57:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbhLKI5O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 03:57:14 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:48938 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbhLKI5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 03:57:13 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 61A85CE2F44;
        Sat, 11 Dec 2021 08:57:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A3FEC004DD;
        Sat, 11 Dec 2021 08:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639213029;
        bh=cGi2ZfKrxWj5jBppcx4xlaYpuQh16Vpj+Yque1d4vt8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aDbNVl1YQ2E8r+C42m48P3glxkMO7t0J9jnvz3DxsDf9agIOsobe0nGHu2/33sDsN
         Oi5c8kFfr9t79YMml8DCs0SdUlU0jKmdvMDFhtiNj0rIyWR8S/XV6yL7d9Wt/mGy27
         hUpjTh20JcTqWsqiAR6aG6pV2fyvuhbhJ5MJpDzrzJNVr15th2OIdgqnFL9PT8UYR9
         UhuUEHUlhXzaK9IAZctwTBnB5WtAjjGifPk/LefPxSFYFEpvtBI36rNMwXir9bYotM
         aq86paX5TLGSC3Ea5j4N8DBXMAH0T3Z3eaHpowBlQgTro3dgCpdXvVfGB1qShKvx3t
         lfaVwWTA52ypw==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mvyBj-000MlO-KT; Sat, 11 Dec 2021 09:57:03 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@protonmail.com>, "Randy Dunlap" <rdunlap@infradead.org>,
        Akira Yokosawa <akiyks@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] docs: address some text issues with css/theme support
Date:   Sat, 11 Dec 2021 09:57:00 +0100
Message-Id: <b0b166025019f7cc4f122bd789c79ba28cc2d29d.1639212812.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1639212812.git.mchehab+huawei@kernel.org>
References: <cover.1639212812.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix:
- overriden ->overridden
- some whitespace issues introduced at the css/theme
  Makefile help.

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---

See [PATCH 0/2] at: https://lore.kernel.org/all/cover.1639212812.git.mchehab+huawei@kernel.org/

 Documentation/Makefile             | 4 ++--
 Documentation/doc-guide/sphinx.rst | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index c9543b63dc6a..9f4bd42cef18 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -159,8 +159,8 @@ dochelp:
 	@echo  '  make SPHINX_CONF={conf-file} [target] use *additional* sphinx-build'
 	@echo  '  configuration. This is e.g. useful to build with nit-picking config.'
 	@echo
-	@echo '   make DOCS_THEME={sphinx-theme} selects a different Sphinx theme.'
+	@echo  '  make DOCS_THEME={sphinx-theme} selects a different Sphinx theme.'
 	@echo
-	@echo '   make DOCS_CSS={a .css file} adds a DOCS_CSS override file for html/epub output.'
+	@echo  '  make DOCS_CSS={a .css file} adds a DOCS_CSS override file for html/epub output.'
 	@echo
 	@echo  '  Default location for the generated documents is Documentation/output'
diff --git a/Documentation/doc-guide/sphinx.rst b/Documentation/doc-guide/sphinx.rst
index 7fb6e6168bbb..673cbb769c08 100644
--- a/Documentation/doc-guide/sphinx.rst
+++ b/Documentation/doc-guide/sphinx.rst
@@ -147,7 +147,7 @@ By default, the build will try to use the Read the Docs sphinx theme:
 
 If the theme is not available, it will fall-back to the classic one.
 
-The Sphinx theme can be overriden by using the ``DOCS_THEME`` make variable.
+The Sphinx theme can be overridden by using the ``DOCS_THEME`` make variable.
 
 To remove the generated documentation, run ``make cleandocs``.
 
-- 
2.33.1

