Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 970704D31C0
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 16:29:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233894AbiCIP3H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 10:29:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233865AbiCIP24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 10:28:56 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A015643F;
        Wed,  9 Mar 2022 07:27:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DB577614EF;
        Wed,  9 Mar 2022 15:27:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DD08C340F4;
        Wed,  9 Mar 2022 15:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646839674;
        bh=AWGrA2gdjK2l3jA6PIbNml5wRlr2I5vXKUiOzXqwJQs=;
        h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=ZMF7No5gmILphH9Dpsedeg+jnPC5EbU62iEuRJBm5dAFyQ/KtmjUcExSJ71JFxSbc
         MGauN4i5PK+Phg1VOy+UB5eUpTIpOjfWcqI413HBfvzmDpjgsWUF/i2KWPmjsQ3szX
         rUqXPO3IcnG4UwaXRQjjCbxruMTgJivJtCE+9xTm9Z8qXgkKeW9rODPl4gMqbLy0PI
         dmJEWFt4EDDEwYIhELRhKGspBbcYcne3N01GOtwDZX7suOzwjUCwpGtlS6HxfALhyY
         gAkK19s9LeDqxzWIDZUFk79tpKhfEZb3TwLGfJHn1FM10DaZ/0lOzC3ZedQUcQH0Wq
         ckgy0ctcrpDSg==
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
Subject: [PATCH RT 3/3] Linux 5.4.182-rt71-rc1
Date:   Wed,  9 Mar 2022 09:27:48 -0600
Message-Id: <bd340fc79de226f43181694eb693ac5d42712170.1646839649.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1646839649.git.zanussi@kernel.org>
References: <cover.1646839649.git.zanussi@kernel.org>
In-Reply-To: <cover.1646839649.git.zanussi@kernel.org>
References: <cover.1646839649.git.zanussi@kernel.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Zanussi <zanussi@kernel.org>

v5.4.182-rt71-rc1 stable review patch.
If anyone has any objections, please let me know.

-----------


Signed-off-by: Tom Zanussi <zanussi@kernel.org>
---
 localversion-rt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/localversion-rt b/localversion-rt
index f36b5d418dd8..00736430c969 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt70
+-rt71-rc1
-- 
2.17.1

