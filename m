Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F70F58B689
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 17:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232952AbiHFPj0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 11:39:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232235AbiHFPjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 11:39:25 -0400
Received: from smtp.smtpout.orange.fr (smtp-24.smtpout.orange.fr [80.12.242.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80FFDB4B3
        for <linux-kernel@vger.kernel.org>; Sat,  6 Aug 2022 08:39:24 -0700 (PDT)
Received: from pop-os.home ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id KLtao3ADLbJVVKLtao45Tg; Sat, 06 Aug 2022 17:39:23 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sat, 06 Aug 2022 17:39:23 +0200
X-ME-IP: 90.11.190.129
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     pablo@netfilter.org, kadlec@netfilter.org, fw@strlen.de
Cc:     netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [RESEND (v2) PATCH] netfilter: Fix a typo in a comment
Date:   Sat,  6 Aug 2022 17:39:20 +0200
Message-Id: <ad1d4dafc856ace9613050e6ac60c9f297f0a87d.1659799260.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

s/_IPT_LOG_H/_IP6T_LOG_H/

While at it add some surrounding space to ease reading.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Resend including the netfilter maintainers.

Does MAINTAINERS need some adjustement?
  ./scripts/get_maintainer.pl --nogit --nogit-fallback --norolestats --nol include/uapi/linux/netfilter_ipv6/ip6t_LOG.h
doesn't find anything.

(this a second resend. The Message-Id was the same as the initial message and
it puzzled ML. Sorry for the noise)
---
 include/uapi/linux/netfilter_ipv6/ip6t_LOG.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/netfilter_ipv6/ip6t_LOG.h b/include/uapi/linux/netfilter_ipv6/ip6t_LOG.h
index 23e91a9c2583..0b7b16dbdec2 100644
--- a/include/uapi/linux/netfilter_ipv6/ip6t_LOG.h
+++ b/include/uapi/linux/netfilter_ipv6/ip6t_LOG.h
@@ -17,4 +17,4 @@ struct ip6t_log_info {
 	char prefix[30];
 };
 
-#endif /*_IPT_LOG_H*/
+#endif /* _IP6T_LOG_H */
-- 
2.34.1

