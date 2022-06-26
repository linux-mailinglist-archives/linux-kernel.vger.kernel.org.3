Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF30755B0AB
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 11:13:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234277AbiFZJML (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 05:12:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234157AbiFZJLQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 05:11:16 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B5C812AA3;
        Sun, 26 Jun 2022 02:11:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id ABB40CE0FC2;
        Sun, 26 Jun 2022 09:11:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3D09C341CE;
        Sun, 26 Jun 2022 09:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656234671;
        bh=JhDfPGfwYalIu3FfQWaXR15yJqdZynLQ+lt0rtLSh3s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VIkB9mJeWqYWastBN5fDQYZIsWL3N4A5xVXhgzvN/xKUNTujOx5VGx2vc790cUyNv
         UEN7+Fdkkkx0uM1IEhU1OoGRFO91TNzfXeGIEueDobykRkRCBAejfhGYgTWx6y53+3
         8Q5GcIHVfnW9Yxh+fTQZiLm5YNZMX0TlIft7PTPFjvHsMXcCxafgEr+0mPWxrqEVW6
         jafkH3w9Slir737s2mOTWzmkArvxnDxmKVEAhfO6/Piptfj1p7Er6wUxC5wsGXQCwp
         iyEQxrFexyAB6ab5iN1+ALTFajBlSEQ9nXBbVh8bpn71ZixLwKMEyREAR2HrrSZR+B
         dqEX/0HivjqdQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.95)
        (envelope-from <mchehab@kernel.org>)
        id 1o5OIN-001coP-UJ;
        Sun, 26 Jun 2022 10:11:07 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
        Alex Shi <alexs@kernel.org>,
        Huilong Deng <denghuilong@cdjrlc.com>,
        Yanteng Si <siyanteng@loongson.cn>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 05/20] docs: zh_CN/devicetree: fix typos
Date:   Sun, 26 Jun 2022 10:10:51 +0100
Message-Id: <b4ca010ef223ab9cb76e8caa0a3cde734e0b6b2f.1656234456.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1656234456.git.mchehab@kernel.org>
References: <cover.1656234456.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The devicetree directory was using wrong case:

	Devicetree/ -> devicetree/

Fixes: a17b0169f29b ("docs/zh_CN: add devicetree index translation")
Fixes: c56481299df3 ("docs/zh_CN: add devicetree usage-model translation")
Fixes: 09d4466d3f3c ("docs/zh_CN: add devicetree of_unittest translation")
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH v2 00/20] at: https://lore.kernel.org/all/cover.1656234456.git.mchehab@kernel.org/

 Documentation/translations/zh_CN/devicetree/index.rst       | 2 +-
 Documentation/translations/zh_CN/devicetree/of_unittest.rst | 2 +-
 Documentation/translations/zh_CN/devicetree/usage-model.rst | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/translations/zh_CN/devicetree/index.rst b/Documentation/translations/zh_CN/devicetree/index.rst
index 23d0b6fccd58..3fc355fe0037 100644
--- a/Documentation/translations/zh_CN/devicetree/index.rst
+++ b/Documentation/translations/zh_CN/devicetree/index.rst
@@ -1,7 +1,7 @@
 .. SPDX-License-Identifier: GPL-2.0
 .. include:: ../disclaimer-zh_CN.rst
 
-:Original: Documentation/Devicetree/index.rst
+:Original: Documentation/devicetree/index.rst
 
 :翻译:
 
diff --git a/Documentation/translations/zh_CN/devicetree/of_unittest.rst b/Documentation/translations/zh_CN/devicetree/of_unittest.rst
index abd94e771ef8..11eb08ca8866 100644
--- a/Documentation/translations/zh_CN/devicetree/of_unittest.rst
+++ b/Documentation/translations/zh_CN/devicetree/of_unittest.rst
@@ -1,7 +1,7 @@
 .. SPDX-License-Identifier: GPL-2.0
 .. include:: ../disclaimer-zh_CN.rst
 
-:Original: Documentation/Devicetree/of_unittest.rst
+:Original: Documentation/devicetree/of_unittest.rst
 
 :翻译:
 
diff --git a/Documentation/translations/zh_CN/devicetree/usage-model.rst b/Documentation/translations/zh_CN/devicetree/usage-model.rst
index accdc33475a0..c6aee82c7e6e 100644
--- a/Documentation/translations/zh_CN/devicetree/usage-model.rst
+++ b/Documentation/translations/zh_CN/devicetree/usage-model.rst
@@ -1,7 +1,7 @@
 .. SPDX-License-Identifier: GPL-2.0
 .. include:: ../disclaimer-zh_CN.rst
 
-:Original: Documentation/Devicetree/usage-model.rst
+:Original: Documentation/devicetree/usage-model.rst
 
 :翻译:
 
-- 
2.36.1

