Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0DFC48382E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 22:02:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbiACVCG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 16:02:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiACVCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 16:02:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15F41C061761;
        Mon,  3 Jan 2022 13:02:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8533061219;
        Mon,  3 Jan 2022 21:02:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D57AFC36AEE;
        Mon,  3 Jan 2022 21:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641243721;
        bh=Gql5pyRrklKJkx1itEHAZaR1xa1tyWMcK+SwqwjFv4k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iZqeckK58KwkVYKYTPrwyYh/tkdxDFN3cK/el3HWMdH5Eeh7zGZRa4+7oS4r+isgR
         OoyhTqspNiVnPV4BvemLBKOQuvwi+w1FcX0IA7OLc5pvSDfDYWecW8w43Vly4vkHv2
         KH9uRVOmJllziIfrqrCEUOACXv2S/cjTL5r4FsZyhEJL54FMC1znPjSJIrQcfAhfce
         H2UXtuUS+aEm81BMO3RG7H5gOYmZZVkSi/niLsk9m6bps0/0lT4Z7oTEHkBCiXd+2Z
         /ozrVxyiF6P6qTtlkeAVvIa8iZ8suPLWPvTh0w4DmNypgmFk0zjnGHhsxZ4HwKaYb7
         blM+Be9UrtyCA==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1n4USt-00086h-NT; Mon, 03 Jan 2022 22:01:59 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH 1/1] scripts: sphinx-pre-install: add required ctex dependency
Date:   Mon,  3 Jan 2022 22:01:57 +0100
Message-Id: <165aa6167f21e3892a6e308688c93c756e94f4e0.1641243581.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1641243581.git.mchehab@kernel.org>
References: <cover.1641243581.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After a change meant to fix support for oriental characters
(Chinese, Japanese, Korean), ctex stylesheet is now a requirement
for PDF output.

Reported-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

See [PATCH 0/1] at: https://lore.kernel.org/all/cover.1641243581.git.mchehab@kernel.org/

 scripts/sphinx-pre-install | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/sphinx-pre-install b/scripts/sphinx-pre-install
index 288e86a9d1e5..46aaab414098 100755
--- a/scripts/sphinx-pre-install
+++ b/scripts/sphinx-pre-install
@@ -78,6 +78,7 @@ my %texlive = (
 	'ucs.sty'            => 'texlive-ucs',
 	'upquote.sty'        => 'texlive-upquote',
 	'wrapfig.sty'        => 'texlive-wrapfig',
+	'ctexhook.sty'       => 'texlive-ctex',
 );
 
 #
-- 
2.33.1

