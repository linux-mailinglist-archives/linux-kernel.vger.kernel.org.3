Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46F9558D1AB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 03:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244728AbiHIBQs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 21:16:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244736AbiHIBQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 21:16:43 -0400
Received: from mail.thepaulodoom.com (www.thepaulodoom.com [45.77.108.202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C0EA113E
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 18:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thepaulodoom.com;
        s=mail; t=1660007800;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=CFrfupiQ+AG6pqv/VnxtvDcCQjqOVWDVDgyabjPTzA0=;
        b=Y9wg3H4K2JXo8OkCy/CDosDgWsE+YlKNKnmmyMfGOsP9NKeoRwDn+aa+oef+7mRMZUXdcF
        YAjP/TD812FFn9LNql7e1MxUeA79HE9Eh/+EaMe7E+D+tI7bhqAc5PdnMx9ZwkP9RhmC9M
        vPjYDDNhp8fEX2UDtenEd+JBVmGFhpasMOlsAC2j23ILzvBR99/TA3hO1bHiSZgASxyPlv
        JqgjWfDl8OSHIKTfYsqyk8R4Y+b1EWW7K4m3ICwSN/ZHbzpqyRKPPPDuWIRilET5ottYZn
        Qpd6NNjUFGCBovKpVQFEosXsTvuwALbdL/DsC878I+lTq/86rvx4cqciBp5yz2sHBm1nAS
        qAhflHSdw4UCcKM7EmmRJ6UWIuZeQarpPq2Pu8u00LnxgTToJvitFNmIbjEbhkx0DHNKUY
        W7/xUyXcaEQ9F4Ywdzotf+OKiXRgJ4pjhUgR/885+Lj45dZHwPzB0yxSTFbRMlIgs/Wnmx
        VJbxxeeDnIVhPv63aH3NGRYp3tjxUPDPsNdOnsd324uRAx6l/h9MbYlRCbG7wbmqcKWUZv
        AiFdlYvbTionVUZfy3wJRoxd9ze2OLdca9s8Ol0BYrFwE0LSML7dRUJJkeMLAlsBLNpzHq
        GDPK+jsXL0NiZEBhzupuosRdRRGWfdW8SsDw+j8RnEpcvSKDulvpo=
Received: from gus-fring.localdomain (c-98-240-189-147.hsd1.mn.comcast.net [98.240.189.147])
        by vultr.guest (OpenSMTPD) with ESMTPSA id 724f95ef (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 9 Aug 2022 01:16:38 +0000 (UTC)
Date:   Mon, 8 Aug 2022 20:17:05 -0500
From:   Paul Lemmermann <thepaulodoom@thepaulodoom.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] kernel: cpu: added surrounding spaces
Message-ID: <YvG1kYEd8XHyJj2J@gus-fring.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Patchwork-Bot: notify
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added surrounding spaces aroud assignment operator. Found with
checkpatch.

Signed-off-by: Paul Lemmermann <thepaulodoom@thepaulodoom.com>
---
 kernel/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index bbad5e375..60978ca61 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1660,7 +1660,7 @@ static struct cpuhp_step cpuhp_hp_states[] = {
 		.teardown.single	= NULL,
 	},
 #ifdef CONFIG_SMP
-	[CPUHP_CREATE_THREADS]= {
+	[CPUHP_CREATE_THREADS] = {
 		.name			= "threads:prepare",
 		.startup.single		= smpboot_create_threads,
 		.teardown.single	= NULL,
-- 
2.37.1

