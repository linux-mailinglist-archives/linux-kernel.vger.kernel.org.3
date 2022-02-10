Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6860D4B14FA
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 19:09:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245548AbiBJSIE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 13:08:04 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245540AbiBJSID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 13:08:03 -0500
Received: from mxout01.lancloud.ru (mxout01.lancloud.ru [45.84.86.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD0E7B08;
        Thu, 10 Feb 2022 10:08:02 -0800 (PST)
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout01.lancloud.ru AC9A02091EE6
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        <linux-renesas-soc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Magnus Damm <magnus.damm@gmail.com>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH] MAINTAINERS: specify IRC channel for Renesas ARM32 port
Organization: Open Mobile Platform
Message-ID: <2f108f63-0cf7-cc4c-462e-ec63736234cf@omp.ru>
Date:   Thu, 10 Feb 2022 20:58:12 +0300
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
@@ -2638,6 +2638,7 @@ ARM/SHMOBILE ARM ARCHITECTURE
 M:	Geert Uytterhoeven <geert+renesas@glider.be>
 M:	Magnus Damm <magnus.damm@gmail.com>
 L:	linux-renesas-soc@vger.kernel.org
+C:	irc://irc.libera.chat/renesas-soc
 S:	Supported
 Q:	http://patchwork.kernel.org/project/linux-renesas-soc/list/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-devel.git next
