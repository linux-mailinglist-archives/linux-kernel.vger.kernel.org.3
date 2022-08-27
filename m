Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8EE05A3880
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 17:52:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233408AbiH0Pue (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Aug 2022 11:50:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233264AbiH0Pub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 11:50:31 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76C2313DF9;
        Sat, 27 Aug 2022 08:50:27 -0700 (PDT)
X-QQ-mid: bizesmtp67t1661615423tbn81paj
Received: from localhost.localdomain ( [182.148.13.26])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 27 Aug 2022 23:50:16 +0800 (CST)
X-QQ-SSF: 01000000002000B0C000B00A0000000
X-QQ-FEAT: +bXiSo2NuBeF/Mh49jC5OgTEh7ucuuQkIRA+Ad2zRZPTVGjFwbXGbHPtU2jtX
        MCx0FawR1nJpOWsmEFp+Iar1iSEhYFqW5rp0J6iyeaQIXRd73n/LH3SmK62c5hjezwI7ylw
        k9nAz5eA/3pA4bnz6jgCyJXhxM8ybT8gFrGAjwkjrfTu3/cc/VJcW2noI9sHrEBT1paEY9W
        vyIjJUuyWcc7r/43GLWkxlrbhCur9vgzssxi5RJsx9pHPHoc7mkszIPAUz2jwkklYV9MmdG
        GsF40k906+gTpnavhtfMnDVxc38RDUH0k6wdCN4gpjSweGOT3MeCuJ069xKFNzetWOAyNPW
        a7qaf9YMkUrzY31F5nYw49EKG3cqMmdMKNZgFDG/ZXFr6/Gn9KHsX7KZcS/uA==
X-QQ-GoodBg: 0
From:   Shaomin Deng <dengshaomin@cdjrlc.com>
To:     tsbogend@alpha.franken.de, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     xkernel.wang@foxmail.com, Shaomin Deng <dengshaomin@cdjrlc.com>
Subject: [PATCH] mips: sgi-ip22: Fix typo in comments
Date:   Sat, 27 Aug 2022 11:50:15 -0400
Message-Id: <20220827155015.10832-1-dengshaomin@cdjrlc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the repeated word "of" in comments.

Signed-off-by: Shaomin Deng <dengshaomin@cdjrlc.com>
---
 arch/mips/sgi-ip22/ip22-gio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/sgi-ip22/ip22-gio.c b/arch/mips/sgi-ip22/ip22-gio.c
index 38d12f417e48..03d96638f957 100644
--- a/arch/mips/sgi-ip22/ip22-gio.c
+++ b/arch/mips/sgi-ip22/ip22-gio.c
@@ -41,7 +41,7 @@ static struct device gio_bus = {
 /**
  * gio_match_device - Tell if an of_device structure has a matching
  * gio_match structure
- * @ids: array of of device match structures to search in
+ * @ids: array of device match structures to search in
  * @dev: the of device structure to match against
  *
  * Used by a driver to check whether an of_device present in the
-- 
2.35.1

