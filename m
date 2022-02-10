Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA8764B14CF
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 19:00:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245463AbiBJSAD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 13:00:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243410AbiBJSAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 13:00:01 -0500
X-Greylist: delayed 102 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 10 Feb 2022 09:59:59 PST
Received: from mxout04.lancloud.ru (mxout04.lancloud.ru [45.84.86.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E158DF2D;
        Thu, 10 Feb 2022 09:59:59 -0800 (PST)
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout04.lancloud.ru 00C3F20491FF
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH] MAINTAINERS: specify IRC channel for Renesas ARM64 port
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        <linux-renesas-soc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Magnus Damm <magnus.damm@gmail.com>
Organization: Open Mobile Platform
Message-ID: <6c08e98f-c7bb-9d95-5032-69022e43e39b@omp.ru>
Date:   Thu, 10 Feb 2022 20:59:57 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT01.lancloud.ru (fd00:f066::141) To
 LFEX1907.lancloud.ru (fd00:f066::207)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Renesas ARM ports do have their own IRC channel #renesas-soc (initially
created on Freenode, then moved to Liberta.Chat).  Hopefully, adding it to
this file will attract more people... :-)

Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>

---
This patch is against the 'next' branch of Geert Uytterhoeven's
'renesas-devel.git' repo.

 MAINTAINERS |    1 +
 1 file changed, 1 insertion(+)

Index: renesas-devel/MAINTAINERS
===================================================================
--- renesas-devel.orig/MAINTAINERS
+++ renesas-devel/MAINTAINERS
@@ -2525,6 +2525,7 @@ ARM/RENESAS ARM64 ARCHITECTURE
 M:	Geert Uytterhoeven <geert+renesas@glider.be>
 M:	Magnus Damm <magnus.damm@gmail.com>
 L:	linux-renesas-soc@vger.kernel.org
+C:	irc://irc.libera.chat/renesas-soc
 S:	Supported
 Q:	http://patchwork.kernel.org/project/linux-renesas-soc/list/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-devel.git next
