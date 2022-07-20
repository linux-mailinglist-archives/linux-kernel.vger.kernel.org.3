Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B13A57BEDB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 21:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbiGTTsf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 15:48:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiGTTse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 15:48:34 -0400
Received: from smtpbg.qq.com (biz-43-154-54-12.mail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 898DE21251;
        Wed, 20 Jul 2022 12:48:29 -0700 (PDT)
X-QQ-mid: bizesmtp79t1658346498tq4heer9
Received: from harry-jrlc.. ( [125.70.163.183])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 21 Jul 2022 03:48:09 +0800 (CST)
X-QQ-SSF: 0100000000200030C000C00A0000020
X-QQ-FEAT: hoArX50alxF+DlkLpK/znEs8vSXXS42yNM8fy/pw1WkpLuttolCDx8u4ZxPru
        +3fomMndDQLzvzKL9GxM8ipflxICWic0CIb7fbX4tUBgmzkhOZW7ih6yCHr9QhR0w/dF8Bd
        yvccaCovBdCc+1PX1AOMkbbGdOqPPfd5l8/umQA/koLOYIudYCZyXEhAMEup4gKW+bDXgFa
        KYhJTKZuhx+eMkRvqvexuFyF1o+1+oG08VJ9eyZRom9VcQfBE8NRjvxP8iFPw2LyMBJYRoN
        V3UvS9pfRVlK2nQijOVtRn9bugW9kyCEIkhUBoa8TTauz9ziyGJb+6VmMrfOhAUH7CHuc/0
        mZC5uQvI2a9UlE0khMLGsHTUKGuu+Q+PnyHRn3ax0LuLt3msvzeIVK+LGK80w==
X-QQ-GoodBg: 0
From:   Xin Gao <gaoxin@cdjrlc.com>
To:     balbi@kernel.org
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xin Gao <gaoxin@cdjrlc.com>
Subject: [PATCH] USB:do not initialise statics to 0.
Date:   Thu, 21 Jul 2022 03:48:08 +0800
Message-Id: <20220720194808.8799-1-gaoxin@cdjrlc.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr6
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,RDNS_DYNAMIC,
        SPF_PASS,T_SPF_HELO_TEMPERROR autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

do not initialise statics to 0.

Signed-off-by: Xin Gao <gaoxin@cdjrlc.com>
---
 drivers/usb/gadget/legacy/zero.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/legacy/zero.c b/drivers/usb/gadget/legacy/zero.c
index 23312a07efb4..c5f6d496064b 100644
--- a/drivers/usb/gadget/legacy/zero.c
+++ b/drivers/usb/gadget/legacy/zero.c
@@ -56,7 +56,7 @@ static const char longname[] = "Gadget Zero";
  * work better with hosts where config changes are problematic or
  * controllers (like original superh) that only support one config.
  */
-static bool loopdefault = 0;
+static bool loopdefault;
 module_param(loopdefault, bool, S_IRUGO|S_IWUSR);
 
 static struct usb_zero_options gzero_options = {
-- 
2.30.2

