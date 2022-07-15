Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CACA575950
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 03:59:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241139AbiGOB72 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 21:59:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241124AbiGOB7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 21:59:25 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0740E709B3;
        Thu, 14 Jul 2022 18:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=3k5ynIPk5gFL8otZ8hN+0iIyufHA8XKN0Zzhb4ErqL4=; b=dW5mScD4AvqVDcJ8EB3BYEU1Sy
        OLHbO3QZv4093cULF5MFmUXlOsEsay6ItGXIh9Er5G4fLOPJIFyvKSTh+vF3olnic4A3o+zrXy6L0
        NHYUiN87Po0Z3qiE31B/DZagnUiIjp5YgVRCqe6bZcvItLnlEpbe8dBYGZ//oVbFN2JMB7zt0Pc5x
        aqVqGtuAQYkN3zxakN77C+K+/jtOIGnMBEuAQrGbgfxHEnZvJl8IvnqoJJPbvy/Z1rlDvvck5ZC3f
        WeE+n42NDFe7hZSNREuSOXmTjhGniaMlNbPTFc9nkOaID6ac7RFE5fLZUqtm9tPQ5wjgy8zGKshlF
        iRLxRfiA==;
Received: from [2601:1c0:6280:3f0::a6b3] (helo=casper.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oCAbv-009sYI-2h; Fri, 15 Jul 2022 01:59:19 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org
Subject: [PATCH] crypto: rmd160: fix Kconfig "its" grammar
Date:   Thu, 14 Jul 2022 18:59:14 -0700
Message-Id: <20220715015914.12554-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.37.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the possessive "its" instead of the contraction "it's"
where appropriate.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: linux-crypto@vger.kernel.org
---
 crypto/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -880,7 +880,7 @@ config CRYPTO_RMD160
 
 	  RIPEMD-160 is a 160-bit cryptographic hash function. It is intended
 	  to be used as a secure replacement for the 128-bit hash functions
-	  MD4, MD5 and it's predecessor RIPEMD
+	  MD4, MD5 and its predecessor RIPEMD
 	  (not to be confused with RIPEMD-128).
 
 	  It's speed is comparable to SHA1 and there are no known attacks
