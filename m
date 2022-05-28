Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9902536D89
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 17:31:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237692AbiE1Pbu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 May 2022 11:31:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233773AbiE1Pbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 May 2022 11:31:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4623117AAA;
        Sat, 28 May 2022 08:31:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8889960F22;
        Sat, 28 May 2022 15:31:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92CB9C34100;
        Sat, 28 May 2022 15:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653751905;
        bh=OhZh+NCXc1blY5tIY8ybxiGzNOl9XBbqHxmEXxQG9TI=;
        h=From:To:Cc:Subject:Date:From;
        b=qEgyafTY41siNa2emFWjR2HdOAJF49//bEVPKV8viMir+Pn+eWJbKGKw8e7FnTHuj
         8w1nrj/2B7Fv7YAl8tu/J94+Je4/oBtKb3jNYuwSs3hJU2gNmCEPMTFM+L2w9Divv1
         YlmfrwlObs0Z7EppV5RAX3uuAzg4AEi2UTC3ZxefsZu2RX+CvXVxtLOtsX0+hKM1TY
         ySOfaC1rZP9Fug+tzn2dQY0RTfk/a9itZmqvBNkRQOVnWvFUus+rNQwHpcvKw0k8pH
         wb7K8+rkPzZYJEonqAzPysqGMrst1gzqbp5OM82FdRD7N8t22EItrP4V4KhXrrohdt
         ui9UID28/rW5Q==
From:   Miguel Ojeda <ojeda@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Garrett LeSage <garrett@lesage.us>,
        IFo Hancroft <contact@ifohancroft.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Miguel Ojeda <ojeda@kernel.org>
Subject: [PATCH v2 1/2] docs: move Linux logo into a new `images` folder
Date:   Sat, 28 May 2022 17:31:31 +0200
Message-Id: <20220528153132.8636-1-ojeda@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Having assets in the top-level `Documentation` directory can make
it harder to find the documents one needs, especially if we want
to add more of them later on.

Instead, create a new `images` folder inside it that is used
to hold assets such as logos.

In addition, update the reference in `scripts/spdxcheck-test.sh`.

Link: https://lore.kernel.org/lkml/8735hicoy7.fsf@meer.lwn.net/
Suggested-by: Jonathan Corbet <corbet@lwn.net>
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
v1: https://lore.kernel.org/lkml/20220510172530.29704-1-ojeda@kernel.org/
v2:
  - Added the `scripts/spdxcheck-test.sh` reference update, as noticed
    by Jonathan Corbet.

 Documentation/{ => images}/COPYING-logo |   0
 Documentation/{ => images}/logo.gif     | Bin
 scripts/spdxcheck-test.sh               |   2 +-
 3 files changed, 1 insertion(+), 1 deletion(-)
 rename Documentation/{ => images}/COPYING-logo (100%)
 rename Documentation/{ => images}/logo.gif (100%)

diff --git a/Documentation/COPYING-logo b/Documentation/images/COPYING-logo
similarity index 100%
rename from Documentation/COPYING-logo
rename to Documentation/images/COPYING-logo
diff --git a/Documentation/logo.gif b/Documentation/images/logo.gif
similarity index 100%
rename from Documentation/logo.gif
rename to Documentation/images/logo.gif
diff --git a/scripts/spdxcheck-test.sh b/scripts/spdxcheck-test.sh
index cb76324756bd..9f6d1a74da6e 100644
--- a/scripts/spdxcheck-test.sh
+++ b/scripts/spdxcheck-test.sh
@@ -1,7 +1,7 @@
 #!/bin/sh
 
 # run check on a text and a binary file
-for FILE in Makefile Documentation/logo.gif; do
+for FILE in Makefile Documentation/images/logo.gif; do
 	python3 scripts/spdxcheck.py $FILE
 	python3 scripts/spdxcheck.py - < $FILE
 done

base-commit: 4b0986a3613c92f4ec1bdc7f60ec66fea135991f
-- 
2.36.1

