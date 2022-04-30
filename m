Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E63975160EC
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 01:11:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349884AbiD3XFM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 19:05:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231941AbiD3XFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 19:05:10 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 486F52ED58
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 16:01:45 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 65C2A32000CC;
        Sat, 30 Apr 2022 19:01:41 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Sat, 30 Apr 2022 19:01:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cason.dev; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1651359700; x=1651446100; bh=N/xeKdPiEGiMGCUIqrcz5n0qw0xVZiMTqUU
        GOCEZfzc=; b=H8UoztDdES/iObmUIaqWkf6EgKg+N0hBgJJpKyFPMRqrKIWOHcw
        cRVnyX3zUCg/DKY5UiuxcGR6/PxkiLgN1t+fRuF+GDAxix+Ojz/833acfYUZWqdT
        rGrcry1ab80iRUUBonSe9/nvUnOe61MjfMR1NyKUi1EfVDOS8OJ2hAxeC1gQucMo
        ngWk7dNP0qqeEr0mbIO+8+1wMzJ3gAycnA3NJkcuSvZqF6FDHOl7nVw7c+pTZnqq
        rwue4igYcNsIu+Gsql5974uwKaDyERg6BPtYuCl3wLl9wpPHZRPXwoe3M8FiUGXd
        KTo4C7z3jMhtg2Sd2Qu1FJQOEMVPJDO5fbg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1651359700; x=1651446100; bh=N/xeKdPiEGiMG
        CUIqrcz5n0qw0xVZiMTqUUGOCEZfzc=; b=O/ofyBUmAYq6TOE8LOhlp2WFjqVBU
        93nfmZ0C9UKu0h9TdPUEW81BdvQRWagFl19aEQcUfxCo7zleVxP/SZ4JWT4UcUWY
        6niaGQznhT5WBqnF+UumoL6MB8QPl8pSd4sUDDxK7pBqzs2jnADjpEOu+o4CE7GP
        m3zNqKcsh/rceIGHKP9nhzswOuGVFKsh0bj79Prr3dsUFQsQ0yFpsykTX0rh9Maa
        ynoJz0KSRfDqmJXlJzV/IUpNC64GtOTzvdTE6IAJ7XxYw2QUNKDH8vEqBcSHS4qv
        o29TdBZfMoL8IlLz2ukTwCMhU2pqd8Q2slnmx9Y7GvYt4bZTPlEDN4vOw==
X-ME-Sender: <xms:1L9tYrwcDEHNDa-HeNZyHWN3ulf2lsx3YdOjE6TdnmTEWl5KYu6hwQ>
    <xme:1L9tYjRAP2Ep-EXbdUBVVHMRRHoMDtziYQnZOBtJRhthRwJzluXdaZRudKJIfVevI
    3_Rl0hs6qJ-ZQe9Mng>
X-ME-Received: <xmr:1L9tYlVm7XoZofLypOihyXh2-av7C4cRMi9cGrXJJwN-76-Vf1c-zBv8KXx2>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvddvgdduhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkgggtugesthdtredttd
    dtvdenucfhrhhomheppfhitghkrghlrghsucevrghsohhnuceonhhitghkrghlrghssegt
    rghsohhnrdguvghvqeenucggtffrrghtthgvrhhnpedtudeihfdtffdutdejleelvdefhf
    ekuedtledvjedukeffueetheetfeejjeevleenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehnihgtkhgrlhgrshestggrshhonhdruggvvh
X-ME-Proxy: <xmx:1L9tYlhcRPJa4uTFqj86awSizIit4aHgIQeMrZ0nG0tAlpPoSh_M5g>
    <xmx:1L9tYtAldj83_iaosVXKpt3qCplAXmyphINP6YAQ_I48IrR2x5wk2A>
    <xmx:1L9tYuKV7ecOzhbo7vNWWSfPewLqZtmSRTl2EDbVQWL2LE9beAZtmA>
    <xmx:1L9tYg6e9FaxS6kH8NHq0BKru4Dz-ilBRsNtfOC8WQtaoBcajQyo-A>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 30 Apr 2022 19:01:40 -0400 (EDT)
Date:   Sat, 30 Apr 2022 19:01:39 -0400
From:   Nickalas Cason <nickalas@cason.dev>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        greybus-dev@lists.linaro.org, hvaibhav.linux@gmail.com,
        johan@kernel.org, elder@kernel.org
Subject: [PATCH] staging: greybus: correct typo in comment
Message-ID: <20220430230139.7i772mvejlhevamn@desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct misspelling in comment. Issue found with checkpatch.

Signed-off-by: Nickalas Cason <nickalas@cason.dev>
---
 drivers/staging/greybus/arche-platform.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/greybus/arche-platform.c b/drivers/staging/greybus/arche-platform.c
index e374dfc0c92f..fcbd5f71eff2 100644
--- a/drivers/staging/greybus/arche-platform.c
+++ b/drivers/staging/greybus/arche-platform.c
@@ -591,7 +591,7 @@ static __maybe_unused int arche_platform_suspend(struct device *dev)
 static __maybe_unused int arche_platform_resume(struct device *dev)
 {
 	/*
-	 * Atleast for ES2 we have to meet the delay requirement between
+	 * At least for ES2 we have to meet the delay requirement between
 	 * unipro switch and AP bridge init, depending on whether bridge is in
 	 * OFF state or standby state.
 	 *
-- 
2.35.1

