Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F54C5B1DBC
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 14:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231743AbiIHM41 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 08:56:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231611AbiIHM4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 08:56:22 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E59C5895DF
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 05:56:19 -0700 (PDT)
X-QQ-mid: bizesmtp86t1662641764t6anmvuv
Received: from localhost.localdomain ( [182.148.14.0])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 08 Sep 2022 20:56:03 +0800 (CST)
X-QQ-SSF: 0100000000200090C000B00A0000000
X-QQ-FEAT: H7ipuM2k/9pzSk/YbezjBnfj2Gmo7EGbkzqs3TI1GW1VhtLkskNeT8bo12+iZ
        YYMQCSM0bMIdOSveI8/4ESFT6BQw4V/ESuyWMZ1kP9J4ukVSKjbReaHo8aOtIigYAVcePGJ
        BT8+QOWb3TflTQWfTJWNEUI7vlAHfUXef/SHgRUxxIwdZtPZr6d7RLzldACO5YbtZZ59J74
        SyNg3Wqq02ZqFiWDJvZepjPgafNcxNnw6faa8MuXPwl665jB7iJoD5y+eJADsstu+p4vOrR
        fS0uctV1WzZS/DAeK2uCdbzWm0Qw8vcXRIB9fzd84U98MJntj/A1NibpmMamkAwyTIUlsB1
        cjGvgIVvapF8odbp8Zt1fhq+fCl0PzmguHbXnQY2QeJHO5N5PsxT9i/07WwTQ==
X-QQ-GoodBg: 0
From:   wangjianli <wangjianli@cdjrlc.com>
To:     daniel@zonque.org, haojian.zhuang@gmail.com, robert.jarzmik@free.fr
Cc:     linux-kernel@vger.kernel.org, wangjianli <wangjianli@cdjrlc.com>
Subject: [PATCH] arm/mach-pxa: fix repeated words in comments
Date:   Thu,  8 Sep 2022 20:55:57 +0800
Message-Id: <20220908125557.29246-1-wangjianli@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr7
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete the redundant word 'in'.

Signed-off-by: wangjianli <wangjianli@cdjrlc.com>
---
 arch/arm/mach-pxa/palm27x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-pxa/palm27x.c b/arch/arm/mach-pxa/palm27x.c
index 1a8d25eecac3..116183859357 100644
--- a/arch/arm/mach-pxa/palm27x.c
+++ b/arch/arm/mach-pxa/palm27x.c
@@ -160,7 +160,7 @@ void __init palm27x_lcd_init(int power, struct pxafb_mode_info *mode)
 #if	defined(CONFIG_USB_PXA27X) || \
 	defined(CONFIG_USB_PXA27X_MODULE)
 
-/* The actual GPIO offsets get filled in in the palm27x_udc_init() call */
+/* The actual GPIO offsets get filled in the palm27x_udc_init() call */
 static struct gpiod_lookup_table palm27x_udc_gpiod_table = {
 	.dev_id = "gpio-vbus",
 	.table = {
-- 
2.36.1

