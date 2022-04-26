Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A3F750EF6B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 05:53:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243542AbiDZD4h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 23:56:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbiDZD4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 23:56:30 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26D56127A60;
        Mon, 25 Apr 2022 20:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=1T4KZ5vFGVDxcht3VyTnhrUO+4bgslaxn9I+F1Hseq0=; b=ji4r5PmEqCUthPzfoQ6SONkkhD
        fgJPyCKDDERyRD1ysd8x09/rWSgsVOA44W+lmK8lrNs7JGuWP6o3+6c1UaLRvo0NFP/YxTmUNdSiS
        V8VH9bTw8TyTEIqiH40sKPd4V2DhZkNNcvOtVEQm5Ecpmobc9BU56bD0PhXroK4PLe7vj5MJIrubj
        66wf/f7sdu2DiXliNTch7rQZijbQE4QUKXNi2p8D1UTkVmrgdvfubrg3+EETiLmbeubPSO1lwGW2c
        /D6U66mWH9Ncc9h0qolRdopLVPuWHJPh0PxmfQqH7CRZzec5WcE8aS4NHqeGXbvH6/8zWkJsAilpO
        VrqTvc0w==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1njCGN-00CLkd-JK; Tue, 26 Apr 2022 03:53:19 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org
Subject: [PATCH v2] Makefile: fix 2 typos
Date:   Mon, 25 Apr 2022 20:53:18 -0700
Message-Id: <20220426035318.3932-1-rdunlap@infradead.org>
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

Fix typos in comments so that they make sense.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-kbuild@vger.kernel.org
---
v2: drop an extra adjective (Masahiro)

 Makefile |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/Makefile
+++ b/Makefile
@@ -1386,8 +1386,8 @@ scripts_unifdef: scripts_basic
 # Install
 
 # Many distributions have the custom install script, /sbin/installkernel.
-# If DKMS is installed, 'make install' will eventually recuses back
-# to the this Makefile to build and install external modules.
+# If DKMS is installed, 'make install' will eventually recurse back
+# to this Makefile to build and install external modules.
 # Cancel sub_make_done so that options such as M=, V=, etc. are parsed.
 
 install: sub_make_done :=
