Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 014265A84FB
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 20:06:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232151AbiHaSGo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 14:06:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232131AbiHaSGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 14:06:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8096CE3961;
        Wed, 31 Aug 2022 11:06:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8DD8B61C0D;
        Wed, 31 Aug 2022 18:06:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A160EC4314D;
        Wed, 31 Aug 2022 18:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661969187;
        bh=rs0JwDT2NwpNg38wdlwMWQtd1f0wzKLTC7t9vHoDofY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GN6Vr0/SNEhlqwkE+C5hAfS6zQ5Iok6a4N2Fb5De2CM4iQb/KMMVUSP1RkrICOmDl
         SahAKk0uFt3MD0/222qERXCycipcYwy/rm5gNF2yZyIS1ofQS6DMAk0d1sDIOC2t4y
         vqa1JBNrMygaX51m80KrFCMxnnWJfwZ41s0dOInC82vPESXkKmsuSK/SRMpH5EYlux
         v29dm+9+CeMbNeGjzKPavJycTB33Y77UwdTyMCbAydH7QH6T+LjBwTkDGsB7n76/HO
         +QDw7/6HkRZb6WWty68pYAwrvH+dDDg3hNkjrldVy14arAiVrL9JXa8EaOg4j67D7+
         ZeR0mjkoUmv9A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 0AD6A5C0950; Wed, 31 Aug 2022 11:06:27 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, Shao-Tse Hung <ccs100203@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 7/7] doc/rcu: Update LWN article URLs and add 2019 article
Date:   Wed, 31 Aug 2022 11:06:25 -0700
Message-Id: <20220831180625.2692892-7-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220831180617.GA2692480@paulmck-ThinkPad-P17-Gen-1>
References: <20220831180617.GA2692480@paulmck-ThinkPad-P17-Gen-1>
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

From: Shao-Tse Hung <ccs100203@gmail.com>

This patch adds LWN articles about RCU APIs which were released in 2019.
Also, HTTP URLs are replaced by HTTPS.

Signed-off-by: Shao-Tse Hung <ccs100203@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/RCU/whatisRCU.rst | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/Documentation/RCU/whatisRCU.rst b/Documentation/RCU/whatisRCU.rst
index 97f2d0fa84dfa..1c747ac3f2c8e 100644
--- a/Documentation/RCU/whatisRCU.rst
+++ b/Documentation/RCU/whatisRCU.rst
@@ -6,13 +6,15 @@ What is RCU?  --  "Read, Copy, Update"
 Please note that the "What is RCU?" LWN series is an excellent place
 to start learning about RCU:
 
-| 1.	What is RCU, Fundamentally?  http://lwn.net/Articles/262464/
-| 2.	What is RCU? Part 2: Usage   http://lwn.net/Articles/263130/
-| 3.	RCU part 3: the RCU API      http://lwn.net/Articles/264090/
-| 4.	The RCU API, 2010 Edition    http://lwn.net/Articles/418853/
-| 	2010 Big API Table           http://lwn.net/Articles/419086/
-| 5.	The RCU API, 2014 Edition    http://lwn.net/Articles/609904/
-|	2014 Big API Table           http://lwn.net/Articles/609973/
+| 1.	What is RCU, Fundamentally?  https://lwn.net/Articles/262464/
+| 2.	What is RCU? Part 2: Usage   https://lwn.net/Articles/263130/
+| 3.	RCU part 3: the RCU API      https://lwn.net/Articles/264090/
+| 4.	The RCU API, 2010 Edition    https://lwn.net/Articles/418853/
+| 	2010 Big API Table           https://lwn.net/Articles/419086/
+| 5.	The RCU API, 2014 Edition    https://lwn.net/Articles/609904/
+|	2014 Big API Table           https://lwn.net/Articles/609973/
+| 6.	The RCU API, 2019 Edition    https://lwn.net/Articles/777036/
+|	2019 Big API Table           https://lwn.net/Articles/777165/
 
 
 What is RCU?
-- 
2.31.1.189.g2e36527f23

