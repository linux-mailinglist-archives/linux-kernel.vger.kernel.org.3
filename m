Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B5D546C7CF
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 23:55:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242388AbhLGW6g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 17:58:36 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:50304 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbhLGW6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 17:58:35 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 2CCC5CE1EB4
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 22:55:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4B16C341C3;
        Tue,  7 Dec 2021 22:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638917701;
        bh=sp0xm1WbDE3Fb/5V0cM4QWZ6D+dNtSoC1dtm8Wt6zSA=;
        h=From:To:Cc:Subject:Date:From;
        b=Kso+dWdkPbHMFoZDjt3VRPukSq7hZyVhE7XTBZP0D7n5/VubjR+3TGhcXxnkBPf3g
         FBQbBYL4lvny9ZiuUuETO0hIBLCP+pYYJLYI0/5ZpiES/Qm/QiNGh4qqDLEp61zKJo
         lXFaL3YktiooHh5iAAqcMGQdN/HD6wUcD1WONc5hR66ePErZrzMaYI9/i2u+XIeMZx
         HLGsvDxwL9b6VbLQYt5jAyHIjZo2I1DFz27fdSVq618oARRGFdD9ShEz3XfIPKysrj
         K6vHr8kzDAFIuXHJPo5z/nNq+tqKjXEDe4w11OlmglL1g6/Pokc2QeYI/6fYJJqdpw
         nt/9pfCZVCBCg==
From:   labbott@kernel.org
To:     Sumit Semwal <sumit.semwal@linaro.org>
Cc:     Laura Abbott <labbott@kernel.org>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: Update e-mail addresses for Laura Abbott
Date:   Tue,  7 Dec 2021 17:54:58 -0500
Message-Id: <20211207225458.622282-1-labbott@kernel.org>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Laura Abbott <labbott@kernel.org>

Consolodate everything under an @kernel.org address.

Signed-off-by: Laura Abbott <labbott@kernel.org>
---
Sumit, can you take this through your tree?
---
 .mailmap    | 3 +++
 MAINTAINERS | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/.mailmap b/.mailmap
index 6277bb27b4bf..e7a5bb0c35ae 100644
--- a/.mailmap
+++ b/.mailmap
@@ -203,6 +203,9 @@ Koushik <raghavendra.koushik@neterion.com>
 Krzysztof Kozlowski <krzk@kernel.org> <k.kozlowski.k@gmail.com>
 Krzysztof Kozlowski <krzk@kernel.org> <k.kozlowski@samsung.com>
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
+Laura Abbott <labbott@kernel.org> <lauraa@codeaurora.org>
+Laura Abbott <labbott@kernel.org> <labbott@redhat.com>
+Laura Abbott <labobtt@kernel.org> <laura@labbott.name>
 Leonardo Bras <leobras.c@gmail.com> <leonardo@linux.ibm.com>
 Leonid I Ananiev <leonid.i.ananiev@intel.com>
 Leon Romanovsky <leon@kernel.org> <leon@leon.nu>
diff --git a/MAINTAINERS b/MAINTAINERS
index 43007f2d29e0..21ab7c9d1bee 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5715,7 +5715,7 @@ DMA-BUF HEAPS FRAMEWORK
 M:	Sumit Semwal <sumit.semwal@linaro.org>
 R:	Benjamin Gaignard <benjamin.gaignard@linaro.org>
 R:	Liam Mark <lmark@codeaurora.org>
-R:	Laura Abbott <labbott@redhat.com>
+R:	Laura Abbott <labbott@kernel.org>
 R:	Brian Starkey <Brian.Starkey@arm.com>
 R:	John Stultz <john.stultz@linaro.org>
 L:	linux-media@vger.kernel.org
-- 
2.33.1

