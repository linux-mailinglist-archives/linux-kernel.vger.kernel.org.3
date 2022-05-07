Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB43751E46E
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 07:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445744AbiEGFfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 01:35:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1445689AbiEGFc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 01:32:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBCB769CF3;
        Fri,  6 May 2022 22:27:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7ABA46009B;
        Sat,  7 May 2022 05:27:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17E5AC385AE;
        Sat,  7 May 2022 05:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651901258;
        bh=CkfZTw3ZzSfZvddpUbW42WBbNg9OdYWpXIeP19wnW2k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PcB1rAZTFDys3TQANgnIzFCfTAstjNigu+m4pdTwdbrDWDZbd0xUurabXjXDvZKIx
         ATQTNww2CDo7VyXqwj90zidDIclo3UnW/INZwgrc8f8SYHp6OWlzyypzNxeygDXcIW
         dF0sqcCdV52A+YCEA/34NkLKOzR+LUBXAsMEsN+JDNhdBoCkCdwRNQIdNp8Qjy1UKg
         tiZJ7pG1mSQ2SM9PpnBjC/IBKPCiwZd6E7mxniT5QbZQwjClyzS2Cj9PabZ2v2pSqg
         COvDDhFBXkMi03KEgzyihaOizD4UzMLuuh+iL1pyrdq6RjcoSvRbAcpxXmbgqRj5Dn
         rL3dk0JjUNuWg==
From:   Miguel Ojeda <ojeda@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>
Subject: [PATCH v6 21/23] MAINTAINERS: Rust
Date:   Sat,  7 May 2022 07:24:19 +0200
Message-Id: <20220507052451.12890-22-ojeda@kernel.org>
In-Reply-To: <20220507052451.12890-1-ojeda@kernel.org>
References: <20220507052451.12890-1-ojeda@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Miguel, Alex and Wedson will be maintaining the Rust support.

Co-developed-by: Alex Gaynor <alex.gaynor@gmail.com>
Signed-off-by: Alex Gaynor <alex.gaynor@gmail.com>
Co-developed-by: Wedson Almeida Filho <wedsonaf@google.com>
Signed-off-by: Wedson Almeida Filho <wedsonaf@google.com>
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 MAINTAINERS | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index edc96cdb85e8..acbe16a8290a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17147,6 +17147,21 @@ L:	linux-rdma@vger.kernel.org
 S:	Maintained
 F:	drivers/infiniband/ulp/rtrs/
 
+RUST
+M:	Miguel Ojeda <ojeda@kernel.org>
+M:	Alex Gaynor <alex.gaynor@gmail.com>
+M:	Wedson Almeida Filho <wedsonaf@google.com>
+L:	rust-for-linux@vger.kernel.org
+S:	Supported
+W:	https://github.com/Rust-for-Linux/linux
+B:	https://github.com/Rust-for-Linux/linux/issues
+T:	git https://github.com/Rust-for-Linux/linux.git rust-next
+F:	rust/
+F:	samples/rust/
+F:	Documentation/rust/
+F:	scripts/*rust*
+K:	\b(?i:rust)\b
+
 RXRPC SOCKETS (AF_RXRPC)
 M:	David Howells <dhowells@redhat.com>
 M:	Marc Dionne <marc.dionne@auristor.com>
-- 
2.35.3

