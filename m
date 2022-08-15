Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC2CD5944C6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 00:59:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351381AbiHOWwH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 18:52:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351591AbiHOWtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 18:49:00 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACCF613675E
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 12:53:43 -0700 (PDT)
X-QQ-mid: bizesmtp69t1660593215tx3hnipr
Received: from harry-jrlc.. ( [182.148.12.144])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 16 Aug 2022 03:53:23 +0800 (CST)
X-QQ-SSF: 0100000000200050C000B00A0000020
X-QQ-FEAT: LG+NUo/f6sHc2m+cla/T+TR13heGFQ57WGv8lyWz+MZXwhlAK72VuvQreUg9X
        rVxxcEAhGeBkoGVsEE/39EHtyMQH0pfQEbV/+hVdnsli4VHitkd4wWIGCbRhQlkpMtC8gpe
        2FFLHZCnYzl0z2vNe9M1ovLOUHpRiihnkG3QOg0XMHOZQcjau+L1yFYT4jvPQ+2pHutx/3K
        N4/3olFCLPVmPsLNBJMHj1e74R+2bHM3gPGWCK1e4gFnzgZ0Bj6xtMZEhyUwFqhk+ZVpQ5a
        f4k6eoHr0jrE2/Q7t/lZOmIDXZgTPo40w+YSZpkfdixYoD1YWg+YXsofBFD5WPY7DMlTiDa
        vajZB6Kq+id2No9KWmF3NNDU1nrO+lS5GyoL95trIp4iCDT3z004SW1aAK/YQ==
X-QQ-GoodBg: 0
From:   Xin Gao <gaoxin@cdjrlc.com>
To:     mpe@ellerman.id.au
Cc:     benh@kernel.crashing.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Xin Gao <gaoxin@cdjrlc.com>
Subject: [PATCH] treewide: Complete variable type
Date:   Tue, 16 Aug 2022 03:53:22 +0800
Message-Id: <20220815195322.3683-1-gaoxin@cdjrlc.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr6
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is better to use "unsigned int" instead of "unsigned", line 24.

Signed-off-by: Xin Gao <gaoxin@cdjrlc.com>
---
 arch/powerpc/boot/epapr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/boot/epapr.c b/arch/powerpc/boot/epapr.c
index 7c5b26ade6c4..4133bee28673 100644
--- a/arch/powerpc/boot/epapr.c
+++ b/arch/powerpc/boot/epapr.c
@@ -21,7 +21,7 @@ BSS_STACK(4096);
 #define EPAPR_SMAGIC	0x65504150
 #define EPAPR_EMAGIC	0x45504150
 
-static unsigned epapr_magic;
+static unsigned int epapr_magic;
 static unsigned long ima_size;
 static unsigned long fdt_addr;
 
-- 
2.30.2

