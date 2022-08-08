Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87F4958CFB4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 23:32:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244462AbiHHVcY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 17:32:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244374AbiHHVcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 17:32:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C70F1B780;
        Mon,  8 Aug 2022 14:32:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 942E660F46;
        Mon,  8 Aug 2022 21:32:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28925C433D6;
        Mon,  8 Aug 2022 21:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1659994324;
        bh=xJhW7d248iritQ4ymw3QmYT6FjZI7Ec9pUmutSBZaCs=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=lo01OUoa00XM8QNR3I3/DoTyrHcvhaacj2U/5fAQu9NHvzaYPpXeSQ7YBhVDpYS29
         1k8l+0xsgIV8x7vlC2DLUm5TE02qEENXv/+Fl/X0QkBJTKEV4ONzl3XkLxe5au+0u4
         mO1JwpMDf1OQqTTw7M6WDqUZtXJoQV297VRAB7H0=
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Date:   Mon, 08 Aug 2022 17:31:53 -0400
Subject: [PATCH v2 5/5] maintainer-pgp-guide: minor wording tweaks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20220727-docs-pgp-guide-v2-5-e3e6954affb6@linuxfoundation.org>
References: <20220727-docs-pgp-guide-v2-0-e3e6954affb6@linuxfoundation.org>
In-Reply-To: <20220727-docs-pgp-guide-v2-0-e3e6954affb6@linuxfoundation.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
X-Mailer: b4 0.10.0-dev-fe10a
X-Developer-Signature: v=1; a=openpgp-sha256; l=991;
 i=konstantin@linuxfoundation.org; h=from:subject:message-id;
 bh=xJhW7d248iritQ4ymw3QmYT6FjZI7Ec9pUmutSBZaCs=;
 b=owGbwMvMwCW27YjM47CUmTmMp9WSGJI+NlyZ8j756aPovvZvE3uf9Tns/FLgmfXvDEsGlxj3PTFn
 O6n+jlIWBjEuBlkxRZayfbGbggofesil95jCzGFlAhnCwMUpABO52cjIcEfhpdb3y+ldndVxN1fpva
 tyb204Mk1huZDKfK7GOkWHDYwM676vvyGcNunVlx07lVtmPK2WuM99PN715PrCKb8EJSZEcwMA
X-Developer-Key: i=konstantin@linuxfoundation.org; a=openpgp;
 fpr=DE0E66E32F1FDD0902666B96E63EDCA9329DD07E
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tweak some wording to remove redundant information.

Signed-off-by: Konstantin Ryabitsev <konstantin@linuxfoundation.org>

diff --git a/Documentation/process/maintainer-pgp-guide.rst b/Documentation/process/maintainer-pgp-guide.rst
index 27c42762edd7..40bfbd3b7648 100644
--- a/Documentation/process/maintainer-pgp-guide.rst
+++ b/Documentation/process/maintainer-pgp-guide.rst
@@ -266,9 +266,7 @@ home, such as your bank vault.
     Your printer is probably no longer a simple dumb device connected to
     your parallel port, but since the output is still encrypted with
     your passphrase, printing out even to "cloud-integrated" modern
-    printers should remain a relatively safe operation. One option is to
-    change the passphrase on your master key immediately after you are
-    done with paperkey.
+    printers should remain a relatively safe operation.
 
 Back up your whole GnuPG directory
 ----------------------------------

-- 
b4 0.10.0-dev-fe10a
