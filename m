Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15D1E465434
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 18:45:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236225AbhLARsU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 12:48:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbhLARsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 12:48:18 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66DD2C061748
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 09:44:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id BBCF4CE1FFF
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 17:44:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5F3BC53FCD;
        Wed,  1 Dec 2021 17:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638380693;
        bh=U8NgDcFMNgk3nRoZQKP7hoYuWyPNJj+grolmtNGGkQs=;
        h=From:To:Cc:Subject:Date:From;
        b=XWD902LgUML7XkZB3r1coG7lEzVgec4KHvQCxVCJNOiUOKGRxD9WDAIzh2ANv73pv
         7akCz8lsqL4lnAxS2BTiaHTEcFun1TFGFaOkVg0qotjZFH2xJDKmQ/RQXk3Qi8kls/
         cW95rN4iyyoiMQN+gOOn+Yn55jTD9hUCQGcmCTTkmme9zE8e9B7n5sK0kahHtc26XI
         qhbBSl2qP94/MQxBZZPDahPhLARpXRvuntOOqaNh8FO+h02kXeZCpu055U+5GopNmX
         67QXRJzMlHaIAEDNFl1Kl0tVwkBXlL1ngQRSRVy5up5qyCdCbaVVg1ZvurU9rTMyez
         t/afQtRP0r2rQ==
From:   Mark Brown <broonie@kernel.org>
To:     tytso@mit.edu, akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH] random: Document add_hwgenerator_randomness() with other input functions
Date:   Wed,  1 Dec 2021 17:44:49 +0000
Message-Id: <20211201174449.1359595-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1207; h=from:subject; bh=U8NgDcFMNgk3nRoZQKP7hoYuWyPNJj+grolmtNGGkQs=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhp7Jy6cjVbMdWyq6gsalVa9Nbr31PYvw6pmety30c 0EtWkRWJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYaeycgAKCRAk1otyXVSH0ANUB/ 0T4FAno8aK3OupWpDeOTDL1YvPOvB1JNQSnOub40L9B6ptlvCwJzgLGHdbBX8Y0Hmptb94J0sg9buQ ve9nqW0C2hNf4vCkBmzPHvHUoE4PaeKUZD6jrh5oQJZtsa4XMKYjGeUHGpTQ2G9XzIDF1pt1ue6+N9 0QtEA6ZtdvOJYDuPxd23YJEjPPtg0woiHXnbKXhr6MUHlLClp7DPvOJoreoGKTpJP3oZPch+ngUkcZ y8res9JPRiVy5hMy6ca7AxXS8G9HUg2xDUGiZ5rajlqEpTfTbEN1qNrK7BGeJrHDUXUyAkh9USBNK/ gpJRhXXNPbcLhUIT1DpXro4M0CyA+I
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The section at the top of random.c which documents the input functions
available does not document add_hwgenerator_randomness() which might lead
a reader to overlook it. Add a brief note about it.

Signed-off-by: Mark Brown <broonie@kernel.org>
---

Ted, I've been sending this for almost two years at this point and
you've not commented on it - if there's some issue please let me know.

 drivers/char/random.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 35fcc09c0228..9192da308f87 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -228,6 +228,14 @@
  * particular randomness source.  They do this by keeping track of the
  * first and second order deltas of the event timings.
  *
+ * There is also an interface for true hardware RNGs:
+ *
+ *	void add_hwgenerator_randomness(const char *buffer, size_t count,
+ *				size_t entropy);
+ *
+ * This will credit entropy as specified by the caller, if the entropy
+ * pool is full it will block until more entropy is needed.
+ *
  * Ensuring unpredictability at system startup
  * ============================================
  *
-- 
2.30.2

