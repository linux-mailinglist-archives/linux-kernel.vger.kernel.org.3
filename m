Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA6304697F9
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 15:07:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245383AbhLFOKX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 09:10:23 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:60054 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245467AbhLFOJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 09:09:49 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C8671612DC;
        Mon,  6 Dec 2021 14:06:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CEC3C341C1;
        Mon,  6 Dec 2021 14:06:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638799580;
        bh=k/rDa49Yvlv65hXaMj4emQMQraMjbgh+PaX1UN3CxbE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NOfP37FyTs9EbbowTufPtg6jRM4iCNpMblvB2iRJFGVqNFgsmmUh00hjOatRmYb5V
         CiV3iSLa0YOWWvcn7IJabOw7vvjn0pwi3lDH9XSRvTAmtYXW4cJbA/JUq8bqBf80Bv
         L7jNbb5UWCV2zwrCg2rv9jvFnFByZuvEngcYZT0+XqhtoHjC1ZaaEBlEubmieAoTSE
         r8Hz8hNeUkvdwx2WHMrcnvcXRu7lFHHT9hIyaZrbkgg62kQrf6Cooa6khWowUXp4Bb
         ad5EUDeYb46hRALDNtN61TGRJwqqU0tW4S2/oflv46tykBW5fdYTCvz64eraSbHnBM
         yq0EYs7t2cORA==
From:   Miguel Ojeda <ojeda@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     rust-for-linux@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>
Subject: [PATCH 17/19] MAINTAINERS: Rust
Date:   Mon,  6 Dec 2021 15:03:11 +0100
Message-Id: <20211206140313.5653-18-ojeda@kernel.org>
In-Reply-To: <20211206140313.5653-1-ojeda@kernel.org>
References: <20211206140313.5653-1-ojeda@kernel.org>
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
 MAINTAINERS | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 360e9aa0205d..2683d788d060 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16562,6 +16562,20 @@ L:	linux-rdma@vger.kernel.org
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
+K:	\b(?i:rust)\b
+
 RXRPC SOCKETS (AF_RXRPC)
 M:	David Howells <dhowells@redhat.com>
 M:	Marc Dionne <marc.dionne@auristor.com>
-- 
2.34.0

