Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2AAB490191
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 06:37:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234410AbiAQFhH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 00:37:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234465AbiAQFfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 00:35:39 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32245C06173F;
        Sun, 16 Jan 2022 21:35:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E4751B80DD0;
        Mon, 17 Jan 2022 05:35:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E99A1C36AF2;
        Mon, 17 Jan 2022 05:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642397701;
        bh=UQhIy9Bw6cXgCXClfTAGA3KZIJDkY3EVFv4o6aXfHao=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WBj4LSQBgy0jXf/llRyllgX2Td/FG4QfBcTEfJm2X92uC4dHMwQE8EeljVNGo6DMb
         AY+4b2Tfal0bmyjKQOlg0XW+5TUIpoQWQDWhC3AyrSIx/StUZ/YPBB8kwoOovZhIof
         Ix3Kmw1C0O4jQMahyBNvdXPBDICPrBk1X6w6bnUOVY7gDfdbaGc45p+WsXiQSCBdiV
         NbdXhRBLmPJ2tDbvPYRKjF1Dpxj1BRN1t6wtRdoTDKs8P/upp32f3lTqBHIdfNUVUN
         zWqkAfsTqyvhQu0R4EN3nQ+3RZuidzJS5argh3SmuyLMbpNrEMssTDQaNkWbXlSiAs
         CQQoNdCuV2osw==
From:   Miguel Ojeda <ojeda@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     rust-for-linux@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>
Subject: [PATCH v3 17/19] MAINTAINERS: Rust
Date:   Mon, 17 Jan 2022 06:33:47 +0100
Message-Id: <20220117053349.6804-18-ojeda@kernel.org>
In-Reply-To: <20220117053349.6804-1-ojeda@kernel.org>
References: <20220117053349.6804-1-ojeda@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
 MAINTAINERS | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index dd36acc87ce6..5f3816c713fc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16578,6 +16578,22 @@ L:	linux-rdma@vger.kernel.org
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
+F:	lib/rust.h
+F:	scripts/*rust*
+K:	\b(?i:rust)\b
+
 RXRPC SOCKETS (AF_RXRPC)
 M:	David Howells <dhowells@redhat.com>
 M:	Marc Dionne <marc.dionne@auristor.com>
-- 
2.34.1

