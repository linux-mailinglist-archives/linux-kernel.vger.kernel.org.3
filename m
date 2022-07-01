Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC7F0562EE8
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 10:51:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236366AbiGAItZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 04:49:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232946AbiGAItL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 04:49:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 332567393E;
        Fri,  1 Jul 2022 01:48:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C0FD36223B;
        Fri,  1 Jul 2022 08:48:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E63BC341CB;
        Fri,  1 Jul 2022 08:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656665335;
        bh=pVzRk2aOjBqChxhGbyCkErNxF6Xl2nyq8gDIuD1VAr0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DFxRs9rOQ9H4j3Skeg9fNug+kN8gVWr/U7RHSaZDz6vh1bSPdcpQw6WmxQOjDNcgm
         LIBQsp/E+IjQHCybJZzXvQbaY5FHMK2bWiSoVLOHp9YbG27Q27n5OqQhIDIkF8UXEH
         NUfJCn1WU4sj7dyPSFcfA21+uetXFu4xl+9xHwL7IAPIxkXCjdCU/6T/pkiR8piOBl
         BSJFxw41l/Irj3taBZYQW2ISaaTAjqlfyzCXfD7dapDJAwa9ca4Uw9Pfc+wXr2i2MZ
         PHuCcppiGeS3zeopc/jjJJ3YIeYqCl7lmwpzv7mHlqf/INmosSWHLvW9lO0DszrN05
         1SDLTFvFGRI5w==
Received: from mchehab by mail.kernel.org with local (Exim 4.95)
        (envelope-from <mchehab@kernel.org>)
        id 1o7CKZ-006T9H-Rw;
        Fri, 01 Jul 2022 09:48:51 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
        ksummit-discuss@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] scripts: sphinx-pre-install: check for PDF min version later on
Date:   Fri,  1 Jul 2022 09:48:48 +0100
Message-Id: <3f8199555a432aededab38b1df7750ebba07d35c.1656664906.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1656664906.git.mchehab@kernel.org>
References: <cover.1656664906.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cc: "Jonathan Corbet" <corbet@lwn.net>
Cc: "Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: ksummit-discuss@lists.linuxfoundation.org
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Better to add the PDF note late for venv recommendation.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH 0/4] at: https://lore.kernel.org/all/cover.1656664906.git.mchehab@kernel.org/

 scripts/sphinx-pre-install | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/scripts/sphinx-pre-install b/scripts/sphinx-pre-install
index 18537e5af692..930a6d058c12 100755
--- a/scripts/sphinx-pre-install
+++ b/scripts/sphinx-pre-install
@@ -785,12 +785,13 @@ sub recommend_sphinx_version($)
 {
 	my $virtualenv_cmd = shift;
 
-	if ($latest_avail_ver lt $min_pdf_version) {
-		print "note: If you want pdf, you need at least Sphinx $min_pdf_version.\n";
-	}
-
 	# Version is OK. Nothing to do.
-	return if ($cur_version && ($cur_version ge $rec_version));
+	if ($cur_version && ($cur_version ge $rec_version)) {
+		if ($cur_version lt $min_pdf_version) {
+			print "note: If you want pdf, you need at least Sphinx $min_pdf_version.\n";
+		}
+		return;
+	};
 
 	if (!$need_sphinx) {
 		# sphinx-build is present and its version is >= $min_version
@@ -837,6 +838,10 @@ sub recommend_sphinx_version($)
 			printf "\t. $activate_cmd\n";
 			deactivate_help();
 
+			if ($latest_avail_ver lt $min_pdf_version) {
+				print "note: If you want pdf, you need at least Sphinx $min_pdf_version.\n";
+			}
+
 			return;
 		}
 
-- 
2.36.1

