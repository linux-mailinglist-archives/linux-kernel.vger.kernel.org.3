Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEB9F4E74C8
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 15:05:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359297AbiCYOHI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 10:07:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359278AbiCYOGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 10:06:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4B45D8F48;
        Fri, 25 Mar 2022 07:05:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8AE6BB82892;
        Fri, 25 Mar 2022 14:05:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B137C340F3;
        Fri, 25 Mar 2022 14:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648217118;
        bh=2D/dTzYT0VeIm/mTkB4UUkqS1y1RpVZCZTgMnIjY/m8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=roKqEQZa30ZCjFSe95w3/zNnmw+s1QUTJp2189zfM8KvKmzCoxEQ41BdGgjrlHBFG
         BKZsA8b09FAaMAaBCLp6b0JrOZ2ZDwFh3sKPdCKRKr6gSgcIF00hbYgtIh2ue+dLHR
         jDvNi1XtAFP/G+jEo7NxfBCyxcXuM927rA+66C2Zy6OPHQ2XX/enFcavFZAOMt7Pyv
         tCX9gEKHxjB+L63m6fyJ2RhvU6ZrrWRFwD6WAS0DUasmGXjySRzxWzGi6CBKJUXMEB
         QfwOVFNtIYmxmeAMKoeCcgt7JwRiAF5mIO3GpVSbI1I339BuYOU3SyD2zSv+MpHCjm
         E/HHdXT5jlQbw==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1nXkZ1-00Axyw-PW; Fri, 25 Mar 2022 15:05:15 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Hans de Goede" <hdegoede@redhat.com>,
        "Stephen Rothwell" <sfr@canb.auug.org.au>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/4] docs: kernel_abi.py: add sphinx build dependencies
Date:   Fri, 25 Mar 2022 15:05:12 +0100
Message-Id: <2c53fbfe3c02a47a5eae4beb298a6db0c95be54a.1648216561.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1648216561.git.mchehab@kernel.org>
References: <cover.1648216561.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ensure that Sphinx-build will handle the files parsed by
get_abi.pl as dependencies. This way, if they are touched,
the ABI output will be regenerated.

Reported-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH v2 0/4] at: https://lore.kernel.org/all/cover.1648216561.git.mchehab@kernel.org/

 Documentation/sphinx/kernel_abi.py | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/sphinx/kernel_abi.py b/Documentation/sphinx/kernel_abi.py
index 4392b3cb4020..efab9b14a9f5 100644
--- a/Documentation/sphinx/kernel_abi.py
+++ b/Documentation/sphinx/kernel_abi.py
@@ -128,6 +128,7 @@ class KernelCmd(Directive):
         return out
 
     def nestedParse(self, lines, fname):
+        env = self.state.document.settings.env
         content = ViewList()
         node = nodes.section()
 
@@ -154,6 +155,9 @@ class KernelCmd(Directive):
                     self.do_parse(content, node)
                     content = ViewList()
 
+                    # Add the file to Sphinx build dependencies
+                    env.note_dependency(os.path.abspath(f))
+
                 f = new_f
 
                 # sphinx counts lines from 0
-- 
2.35.1

