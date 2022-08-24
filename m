Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DAAA59FB71
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 15:33:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237289AbiHXNdW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 09:33:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233768AbiHXNdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 09:33:20 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 329F37756B;
        Wed, 24 Aug 2022 06:33:17 -0700 (PDT)
X-QQ-mid: bizesmtp72t1661347918tmdhdsju
Received: from localhost.localdomain ( [182.148.14.124])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 24 Aug 2022 21:31:57 +0800 (CST)
X-QQ-SSF: 01000000002000C0E000B00A0000000
X-QQ-FEAT: +ynUkgUhZJmOvOufKMVwiXDqDb7P8BwNTytl16CMy06ktRpG5RZec8mvvzMj0
        60+bV7I4WApthcSmnffHUxUJELA0GVPDYN+oVdTESTKGOb481Rex7pOa1aEMPXpVjFdjh4o
        SY5BJFdYwP7E4AQ9QyFYJpntvDedwkHp0vscf3c2lXJXAu36TngCYcFL5zlXeUgknTR9sZm
        u8DqOJ54Rl1IJKVNidXxdbSGxZQW9BjYHIde9PfjB9Thi76XDYPTIttBrDK4Ow0l40s5L30
        C6CXBVlRKUvg9UZz8KdJi7RckdmQEpW9hdBkq8I3VwxDlTVIIkKBYUJUt4MOBg81SeEx2PH
        1lb5wz53F2CSCpIv7Em4FC+fcrQQzGhXsSudOvc6KMf+IwTaj1+9gDSm2WN3s2u9Mk8Qepn
        HUOaT5f59MQ=
X-QQ-GoodBg: 0
From:   Jilin Yuan <yuanjilin@cdjrlc.com>
To:     awalls@md.metrocast.net, mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jilin Yuan <yuanjilin@cdjrlc.com>
Subject: [PATCH] pci/cx18: Use 'unsigned int' instead of just 'unsigned'.
Date:   Wed, 24 Aug 2022 21:31:49 +0800
Message-Id: <20220824133149.65002-1-yuanjilin@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
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

Prefer 'unsigned int' to bare use of 'unsigned'.

Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
---
 drivers/media/pci/cx18/cx18-firmware.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/pci/cx18/cx18-firmware.c b/drivers/media/pci/cx18/cx18-firmware.c
index 1b038b2802bf..b72bcbc1fed6 100644
--- a/drivers/media/pci/cx18/cx18-firmware.c
+++ b/drivers/media/pci/cx18/cx18-firmware.c
@@ -88,7 +88,7 @@ static int load_cpu_fw_direct(const char *fn, u8 __iomem *mem, struct cx18 *cx)
 {
 	const struct firmware *fw = NULL;
 	int i, j;
-	unsigned size;
+	unsigned int size;
 	u32 __iomem *dst = (u32 __iomem *)mem;
 	const u32 *src;
 
@@ -128,7 +128,7 @@ static int load_apu_fw_direct(const char *fn, u8 __iomem *dst, struct cx18 *cx,
 {
 	const struct firmware *fw = NULL;
 	int i, j;
-	unsigned size;
+	unsigned int size;
 	const u32 *src;
 	struct cx18_apu_rom_seghdr seghdr;
 	const u8 *vers;
-- 
2.36.1

