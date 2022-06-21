Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CFD2552CA6
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 10:15:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348036AbiFUIP2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 04:15:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbiFUIP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 04:15:27 -0400
Received: from mail.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3DEBC237F2;
        Tue, 21 Jun 2022 01:15:26 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 32E821E80D50;
        Tue, 21 Jun 2022 16:15:25 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id aZ1jwiaVgXqG; Tue, 21 Jun 2022 16:15:22 +0800 (CST)
Received: from localhost.localdomain (unknown [112.64.61.97])
        (Authenticated sender: jiaming@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id A204B1E80D2D;
        Tue, 21 Jun 2022 16:15:21 +0800 (CST)
From:   Zhang Jiaming <jiaming@nfschina.com>
To:     rth@twiddle.net, ink@jurassic.park.msu.ru, mattst88@gmail.com
Cc:     linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        liqiong@nfschina.com, renyu@nfschina.com,
        Zhang Jiaming <jiaming@nfschina.com>
Subject: [PATCH] alpha: Add some spaces to ensure format specification
Date:   Tue, 21 Jun 2022 16:15:06 +0800
Message-Id: <20220621081506.50096-1-jiaming@nfschina.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a space after ','.
Add spaces around the '=', '>' and '=='.

Signed-off-by: Zhang Jiaming <jiaming@nfschina.com>
---
 arch/alpha/boot/stdio.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/alpha/boot/stdio.c b/arch/alpha/boot/stdio.c
index 60f73ccd2e89..e6d1ebff4209 100644
--- a/arch/alpha/boot/stdio.c
+++ b/arch/alpha/boot/stdio.c
@@ -42,8 +42,8 @@ static int skip_atoi(const char **s)
 
 static char * number(char * str, unsigned long long num, int base, int size, int precision, int type)
 {
-	char c,sign,tmp[66];
-	const char *digits="0123456789abcdefghijklmnopqrstuvwxyz";
+	char c, sign, tmp[66];
+	const char *digits = "0123456789abcdefghijklmnopqrstuvwxyz";
 	int i;
 
 	if (type & LARGE)
@@ -83,14 +83,14 @@ static char * number(char * str, unsigned long long num, int base, int size, int
 		precision = i;
 	size -= precision;
 	if (!(type&(ZEROPAD+LEFT)))
-		while(size-->0)
+		while (size-- > 0)
 			*str++ = ' ';
 	if (sign)
 		*str++ = sign;
 	if (type & SPECIAL) {
 		if (base==8)
 			*str++ = '0';
-		else if (base==16) {
+		else if (base == 16) {
 			*str++ = '0';
 			*str++ = digits[33];
 		}
@@ -125,7 +125,7 @@ int vsprintf(char *buf, const char *fmt, va_list args)
 				/* 'z' changed to 'Z' --davidm 1/25/99 */
 
 
-	for (str=buf ; *fmt ; ++fmt) {
+	for (str = buf ; *fmt ; ++fmt) {
 		if (*fmt != '%') {
 			*str++ = *fmt;
 			continue;
@@ -296,7 +296,7 @@ int sprintf(char * buf, const char *fmt, ...)
 	int i;
 
 	va_start(args, fmt);
-	i=vsprintf(buf,fmt,args);
+	i = vsprintf(buf, fmt, args);
 	va_end(args);
 	return i;
 }
-- 
2.25.1

