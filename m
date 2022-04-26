Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0E5D50ED8F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 02:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238183AbiDZA3A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 20:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240130AbiDZA26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 20:28:58 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 050FF1A060;
        Mon, 25 Apr 2022 17:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=lTmpX84kge9E7ZGQUef7DLb/Hxor4Jf6qlPXm/vpPvI=; b=iYv4uuxx3QPdPG/vhTt3qy/FtD
        uPTItpjsiqRmbzNzp3BU9uM/5BgThVwoEETQS2tQ15iSS0HLITeAEFjmxcsIm06qBFvZTEKPzhZS9
        5G8Lb0SjWYSBhXBsDiGwBljxlODgpzjFN72rFK5hx1unzk7zdoHkBrFia6cc4TcYHigbOSrFJYvDf
        5cnQngbwXFAOjvCctmaYjPjFrD2sHhW0CUwr/kmm5kgBE20l6jDk2y/Fv4IIvwztLj4DIaxAfe8Bl
        S2bw6GYF0zgc/SGFl9Kh1pJdPCXuMjKF3brumT3ahzBHeOBVXIAwbkFVNr5/IybFuVYBKwQItMIN1
        Br1Z8wJA==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nj91c-00BviB-Ip; Tue, 26 Apr 2022 00:25:52 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org
Subject: [PATCH] Makefile: fix a typo
Date:   Mon, 25 Apr 2022 17:25:51 -0700
Message-Id: <20220426002551.20171-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a typo so that it makes sense.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-kbuild@vger.kernel.org
---
 Makefile |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/Makefile
+++ b/Makefile
@@ -1386,7 +1386,7 @@ scripts_unifdef: scripts_basic
 # Install
 
 # Many distributions have the custom install script, /sbin/installkernel.
-# If DKMS is installed, 'make install' will eventually recuses back
+# If DKMS is installed, 'make install' will eventually recurse back
 # to the this Makefile to build and install external modules.
 # Cancel sub_make_done so that options such as M=, V=, etc. are parsed.
 
