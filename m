Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72F0D465757
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 21:46:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239718AbhLAUtN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 15:49:13 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:43888 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353020AbhLAUoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 15:44:44 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 8B87CCE1DED;
        Wed,  1 Dec 2021 20:41:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB6DFC53FCF;
        Wed,  1 Dec 2021 20:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638391279;
        bh=ERuVyUB0Dw+gqopVgRcEFB6TKIIwtdk9P9zkGW2KS00=;
        h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=RbC7f9f6jntVAOAYYbNmiv2bDBlvEGWZLbxEF/HU/UeAQRYZcQ4sY2ng9m7mYivkj
         fdLhdTGQ8CmjmqWvlF40IjlI9zKpNHPSuSRO62+KR3L7QtUyh76aQwuM0L0TB4vKHz
         c4xUXfU8ghdvIKFMvLJeJ52aDoOGG2oS6E/p5mrf3SLN6iwicXyehW1cNDWYK/OCmq
         uMyvb5QPqELm+czj7JP8/rsNB5FjGQk2CgDc4dJNtS64NI+5Er+mA11hZ989G55U5X
         cC3a6dlLnOE77a3M3hHybn2bBlX/TcmgfWVvWqDNlrK+r0f/gwxBvAbMpRvS9511rK
         0Ce1JHLVMozXA==
From:   zanussi@kernel.org
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <wagi@monom.org>,
        Clark Williams <williams@redhat.com>,
        "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
        Tom Zanussi <zanussi@kernel.org>
Subject: [PATCH RT 8/8] Linux 5.4.161-rt67-rc1
Date:   Wed,  1 Dec 2021 14:41:08 -0600
Message-Id: <fa1ec22578baf666ed5f1774e3e93a04c729cbc5.1638391253.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1638391253.git.zanussi@kernel.org>
References: <cover.1638391253.git.zanussi@kernel.org>
In-Reply-To: <cover.1638391253.git.zanussi@kernel.org>
References: <cover.1638391253.git.zanussi@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Zanussi <zanussi@kernel.org>

v5.4.161-rt67-rc1 stable review patch.
If anyone has any objections, please let me know.

-----------


Signed-off-by: Tom Zanussi <zanussi@kernel.org>
---
 localversion-rt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/localversion-rt b/localversion-rt
index d42c0971b041..6f295236237c 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt66
+-rt67-rc1
-- 
2.17.1

