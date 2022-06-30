Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDBD756146D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 10:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233814AbiF3INx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 04:13:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233795AbiF3INV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 04:13:21 -0400
Received: from conuserg-11.nifty.com (conuserg-11.nifty.com [210.131.2.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05028443F8;
        Thu, 30 Jun 2022 01:11:02 -0700 (PDT)
Received: from grover.sesame ([133.106.249.59]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id 25U89jbd027588;
        Thu, 30 Jun 2022 17:09:46 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com 25U89jbd027588
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1656576587;
        bh=IQNcLr2Q+Rml5vvqNmFGoUixW6iYHrmzrTzAVBg3K38=;
        h=From:To:Cc:Subject:Date:From;
        b=2UbB7kkrA1O4vWKUt5gGyR6+QhuAngLnM8skaKAeuLK7BYDo8qR9P/yZdX6Nl9xtC
         /4D6PKUBj78yatuw8XfT9zbitF+F7kXDkjG7lRA/iIyS+S69u7nrB6+J9ERXZ3juze
         az7+Yx/B8e2VoYaAvWUVJITRRP8Tu964Mnhp4DSM1MOwhSyOAslZKbmC2kcMMo8juV
         9jSg4Lo4RsaenQk4L+BxlQQFjW3AafzTpRQn2Zu+kG7YW7KxtXc+KpxC7b3GEk5Tke
         g7LeC6A3k+7arSN1GqB/R41IPOYWVq2GisMTFydcHG0PDnMBoCUvXI6OwDT6pFoChG
         c2AmcmcRqBlVw==
X-Nifty-SrcIP: [133.106.249.59]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kbuild: remove unused cmd_none in scripts/Makefile.modinst
Date:   Thu, 30 Jun 2022 17:09:35 +0900
Message-Id: <20220630080935.316394-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 65ce9c38326e ("kbuild: move module strip/compression code into
scripts/Makefile.modinst") added this unused code.

Perhaps, I thought cmd_none was useful for CONFIG_MODULE_COMPRESS_NONE,
but I did not use it after all.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/Makefile.modinst | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/scripts/Makefile.modinst b/scripts/Makefile.modinst
index c2c43a0ecfe0..16a02e9237d3 100644
--- a/scripts/Makefile.modinst
+++ b/scripts/Makefile.modinst
@@ -28,9 +28,6 @@ modules := $(patsubst $(extmod_prefix)%, $(dst)/%$(suffix-y), $(modules))
 __modinst: $(modules)
 	@:
 
-quiet_cmd_none =
-      cmd_none = :
-
 #
 # Installation
 #
-- 
2.32.0

