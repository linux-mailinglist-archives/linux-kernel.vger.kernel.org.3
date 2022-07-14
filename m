Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A32D9574C0D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 13:28:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238848AbiGNL2G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 07:28:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238788AbiGNL16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 07:27:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48A5C59253
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 04:27:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 00AD6B82491
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 11:27:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55773C34114;
        Thu, 14 Jul 2022 11:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657798069;
        bh=sKPoJKo5gEoqW5brFs6s/jGgmmedcT01+Gjpy/c/FYY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i08BFCBZJIL+dcOTCDQoKJQN0LrFXl+XQs/pmlp2kwAD03LQuky2Bgeu6ywQ/xEx4
         aPTf7AvRg/PT5sb6SZ5soljgLVZ0ou+GzMs4YPKkPmTI01sJZruUQ2UZCZG4ooIH63
         j4PtybRIT9jb/CeEmjdzm++FYF3Q6zcltGPnfmpUEUkkWS0Kc0l9GktxqxLi6GrQno
         OL4Tboc571H4XeTwJvtWVg+GhJtqE/crC+gMRu/3mXaCCYJufv10xIuFeSEjR8eBqu
         2YmW4OYKe5Rjjd1iJ7Cfu9mMuxEcOikncTTYzHt8g5ePtEOl9y59IVno9lnsXPmSdP
         kdhHSQGEUoRkg==
From:   Lee Jones <lee@kernel.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 2/8] MAINTAINERS: Use Lee Jones' kernel.org address for Syscon submissions
Date:   Thu, 14 Jul 2022 12:25:27 +0100
Message-Id: <20220714112533.539910-3-lee@kernel.org>
X-Mailer: git-send-email 2.37.0.144.g8ac04bfd2-goog
In-Reply-To: <20220714112533.539910-1-lee@kernel.org>
References: <20220714112533.539910-1-lee@kernel.org>
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

Going forward, I'll be using my kernel.org for upstream work.

Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Lee Jones <lee@kernel.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index dad7f26edf5ac..5fbbeec1fae6b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19633,7 +19633,7 @@ S:	Maintained
 F:	drivers/mmc/host/sdhci-pci-dwc-mshc.c
 
 SYSTEM CONFIGURATION (SYSCON)
-M:	Lee Jones <lee.jones@linaro.org>
+M:	Lee Jones <lee@kernel.org>
 M:	Arnd Bergmann <arnd@arndb.de>
 S:	Supported
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git
-- 
2.37.0.144.g8ac04bfd2-goog

