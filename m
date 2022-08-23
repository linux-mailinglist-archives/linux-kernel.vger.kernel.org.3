Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4915059EA21
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 19:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbiHWRqT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 13:46:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233480AbiHWRps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 13:45:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 147EF14027;
        Tue, 23 Aug 2022 08:33:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A9D5BB81CED;
        Tue, 23 Aug 2022 15:33:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1698AC433C1;
        Tue, 23 Aug 2022 15:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661268807;
        bh=RLIZ5nsGECRzprxLzsi6eCjr40Iz5URFLSPHCIA3EPk=;
        h=From:To:Cc:Subject:Date:From;
        b=Q+gn197Qelf7q2bTUQNPI/pER0LE01SfpdrNo9Q/a+NKy0SjCgKNHw0usrHCoB2dx
         usr2Fc2IqSNzElikpE7z7fWaXYQwTN5kqJIQVl91jriVZROeDol1avgfumM5vnq/Vc
         5p5hpf2S+s1FmDg3AT+dHN3hF4Fmq7VqWkZprh3H6UvDWKJR9KSjePGi1YDhdyaU4l
         kYYWAX1TWSO2zottMhM5NIeHwChs8Xs27d6keKLBwKyvKUt27j/1aE7mtf8FqSDyK0
         1kCSqvmujSn/1YKngsHog+NYpEWbCXrcmDPj535Cni37tY1BCs/b505332iseI3nV7
         sRsw6hKBIgaRg==
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, linux-trace-devel@vger.kernel.org,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Joe Perches <joe@perches.com>
Subject: [PATCH] MAINTAINERS: Add Runtime Verification (RV) entry
Date:   Tue, 23 Aug 2022 17:33:16 +0200
Message-Id: <b24c13553b6947a8da16d884ca464e4233eb8fb7.1661268579.git.bristot@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a Runtime Verification (RV) entry in the MAINTAINERS file
with Steven Rostedt and myself as maintainers.

Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Joe Perches <joe@perches.com>
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
---
 MAINTAINERS | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 96f47a7865d6..7baa8e643cff 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17731,6 +17731,17 @@ L:	linux-rdma@vger.kernel.org
 S:	Maintained
 F:	drivers/infiniband/ulp/rtrs/
 
+RUNTIME VERIFICATION (RV)
+M:	Daniel Bristot de Oliveira <bristot@kernel.org>
+M:	Steven Rostedt <rostedt@goodmis.org>
+L:	linux-trace-devel@vger.kernel.org
+S:	Maintained
+F:	Documentation/trace/rv/
+F:	include/linux/rv.h
+F:	include/rv/
+F:	kernel/trace/rv/
+F:	tools/verification/
+
 RXRPC SOCKETS (AF_RXRPC)
 M:	David Howells <dhowells@redhat.com>
 M:	Marc Dionne <marc.dionne@auristor.com>
-- 
2.35.1

