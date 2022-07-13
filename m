Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32E10573C43
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 19:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236453AbiGMRyu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 13:54:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231910AbiGMRy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 13:54:27 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EA60255B5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 10:54:14 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 136E03200914;
        Wed, 13 Jul 2022 13:54:10 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 13 Jul 2022 13:54:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tycho.pizza; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1657734850; x=1657821250; bh=74
        oXSxFNn1MwBfyW3gXrhD6qD6ZzeAULMw+VqWVUwcI=; b=at0HztpjdQ7Z0JJat7
        ppknirEUW+EpDw1XX7uAF1fPypvBro7wQBb5K4zYziXHJonvshHsbgNhdU7sVnKF
        w5jf8LcF0PbduVXiBjndcGkD4QmLyJwVfwM8Do89KdovMJ8e3zedmsypfQpNUbgI
        bmgOBRnfu5eEmf1pTdsNjZBBmnUxl4wFcornEaOyocToVN1i9StCeCPdlNDlCMkb
        yX17C4wOCxYDvtktAyn542tdVbk3UbPBlzBcy9Uy7Y2hoHEawWCmIQ8i5h0/LkOd
        4lFCSNFed6X97mjcRexAbXEoEyG26gZboF7SBR0BHoDFx7RelPaEd1iGF+mghR15
        Dhdw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1657734850; x=1657821250; bh=74oXSxFNn1MwB
        fyW3gXrhD6qD6ZzeAULMw+VqWVUwcI=; b=lcqzxLuHXa9ACXF6oRy9d8lCdlWrT
        mm8TGuhGjcD114AIMOdKe0AP9jzRav5kr+vCIsSvU+bFoSjmYwGe2x9Y+Ci7OJ5e
        RYLUHAQuv9RwzIzwSNBHcdlVCIetBRF6uLf1RDrht4fAQU4awodY5xNqDshwNrbG
        hNDRsMIUwiYF9Zj2Y+KQ3kQFOwN35cES40OX9hUqNhbXgMHA2L3hkCbaEltr/wEm
        kZtgmT92bRBSJ19BaXfzF8F6rUuXPlLfmFLvS5KL8DECHSmvUePd4FARzLd8v7P3
        pekWkg2CsqgJRsmnEdiCf6U7tx9aP3/MCK0kOs9cpDGsE3uOEFRr66wJw==
X-ME-Sender: <xms:wQbPYqAokUshw0fcv1zGmKbUEAtiVViznY45uM-cqLfTJReteD2yBg>
    <xme:wQbPYkgoxBI9ZnjPRwd0PBPcxElLpYyvKKQ7BqZ5Ea-Gs_5s9bPEAV1SbtnSlzEMG
    0ekSkniZZPGW4lV-gw>
X-ME-Received: <xmr:wQbPYtkudsPrVkh-8peIppN0nXQBwH6C-PhGiyA1_5KS844T3FTYtlG3SYLHb0WECw6ziJ03>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudejjedguddujecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefvhigt
    hhhoucetnhguvghrshgvnhcuoehthigthhhosehthigthhhordhpihiiiigrqeenucggtf
    frrghtthgvrhhnpedvgeffheelvdeljedvtefhgfeifeevvefhieegffffgfehgeeutdei
    kedtieegueenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehthigthhhosehthigthhhordhpihiiiigr
X-ME-Proxy: <xmx:wQbPYoxUWApziLxECi4HJ6skkbe5dvfBdWnkFAsG29jft3ycIqYhHg>
    <xmx:wQbPYvSL5Vj2ziuqMUMD7cp4N-F121m0ILrz0XPGZIOBJSE1I2JGFw>
    <xmx:wQbPYjZrUDO09ce_LLAo8ACbR-dNNxT3XKknuVGvwB7kc0AtH9raAg>
    <xmx:wgbPYqejkoqC5eu0ZXwMUeLOKz11VDNQAtrThUBocZAOFlmyIXZLww>
Feedback-ID: i21f147d5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 Jul 2022 13:54:08 -0400 (EDT)
From:   Tycho Andersen <tycho@tycho.pizza>
To:     "Eric W . Biederman" <ebiederm@xmission.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>, linux-kernel@vger.kernel.org,
        Tycho Andersen <tycho@tycho.pizza>
Subject: [PATCH] sched: __fatal_signal_pending() should also check PF_EXITING
Date:   Wed, 13 Jul 2022 11:53:05 -0600
Message-Id: <20220713175305.1327649-1-tycho@tycho.pizza>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <Ys2PwTS0qFmGNFqy@netflix>
References: <Ys2PwTS0qFmGNFqy@netflix>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The wait_* code uses signal_pending_state() to test whether a thread has
been interrupted, which ultimately uses __fatal_signal_pending() to detect
if there is a fatal signal.

When a pid ns dies, it does:

    group_send_sig_info(SIGKILL, SEND_SIG_PRIV, task, PIDTYPE_MAX);

for all the tasks in the pid ns. That calls through:

    group_send_sig_info() ->
      do_send_sig_info() ->
        send_signal_locked() ->
          __send_signal_locked()

which does:

    pending = (type != PIDTYPE_PID) ? &t->signal->shared_pending : &t->pending;

which puts sigkill in the set of shared signals, but not the individual
pending ones. When complete_signal() is called at the end of
__send_signal_locked(), if the task already had PF_EXITING (i.e. was
already waiting on something in its fd closing path like a fuse flush),
complete_signal() will not wake up the thread, since wants_signal() checks
PF_EXITING before testing for SIGKILL.

If tasks are stuck in a killable wait (e.g. a fuse flush operation), they
won't see this shared signal, and will hang forever, since TIF_SIGPENDING
is set, but the fatal signal can't be detected. So, let's also look for
PF_EXITING in __fatal_signal_pending().

Signed-off-by: Tycho Andersen <tycho@tycho.pizza>
---
 include/linux/sched/signal.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index cafbe03eed01..c20b7e1d89ef 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -402,7 +402,8 @@ static inline int signal_pending(struct task_struct *p)
 
 static inline int __fatal_signal_pending(struct task_struct *p)
 {
-	return unlikely(sigismember(&p->pending.signal, SIGKILL));
+	return unlikely(sigismember(&p->pending.signal, SIGKILL) ||
+			p->flags & PF_EXITING);
 }
 
 static inline int fatal_signal_pending(struct task_struct *p)

base-commit: 32346491ddf24599decca06190ebca03ff9de7f8
-- 
2.34.1

