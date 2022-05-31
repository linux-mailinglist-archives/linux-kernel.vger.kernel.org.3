Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B688538AD4
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 07:19:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243959AbiEaFRv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 01:17:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243946AbiEaFRt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 01:17:49 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04F1E33E9D;
        Mon, 30 May 2022 22:17:48 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 8D3593200972;
        Tue, 31 May 2022 01:17:46 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 31 May 2022 01:17:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1653974266; x=1654060666; bh=F8
        1xGIS8G0ZOmU4a6natt6mMHiJ7p/1Yr5bda54vx6o=; b=dsydNz1c/NPBbEDv1i
        NOjssi2PZgYkfBBevF2sF53gV4MU2WED4+iUqD29YHpbnnWFVyEw5hz/ajGSsPuu
        AmKMqhcBRXO8DqAIK+XMNMsqTmEAIt4qHQtYbl/WyGPLMdT6cShX/zooBoBDcEAe
        QA/wT9jQDF+bKQGu8OLJk0qewgNhP29mxzAMULtbqGsyLtVTCsderMLZoWRD7+Sg
        fg5hk5n4LiQhNf2RKQiv9asUWmeL1e7qsYjBzLCc9HiuKcI+zqNLgryWUfis3w7L
        N0f785Eqzv4KeJ9/+tjMKKXXIJAfNUN6kQdZwtrPtpoinClzdwDyxsMuhGh+UY5p
        BxvA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1653974266; x=1654060666; bh=F81xGIS8G0ZOm
        U4a6natt6mMHiJ7p/1Yr5bda54vx6o=; b=vBzQWTO/xZlpP2VsUQ3Gzk6j3L0Bd
        pNRynyAZVzDxturF1GkLURCbfHBunQj26SumVm2Prk6rec0ZIxYZG5v29ishJ469
        Yxy1HRC6Na7hdEs6JdMOvj+y5zuimaW1jS2vYkhA6zpWyXgmJIiJeAixZ1XpgnGc
        vgkzT1q9Uida0h99jpjUdopDkyR5wHSPbggu1JdJQbVux2QfpR/mAaErPfnSaWF0
        BrsceqAMIJENzscuKlIrl4TuWlGE4jx1trlOA4EWVx6HSX3tdcRpkXoowEgMDaqb
        i/fOBx9rHNn5Zl3XsGm5NsFtIpYAbW0ybXCCnULpEmTq5/zIddW9dmZ0A==
X-ME-Sender: <xms:-aSVYjYy2vX2qlyU5SQjzWQKTvkuAkfLpqfGotAp4tq6wvS8bDKitg>
    <xme:-aSVYiYBwhwtIjlp56q5OYmvHIiX0gnNszhzy4uIWO8KT47nf43_SX2YtGN8C5J6y
    7d0aFE0jeTL8hEOIg>
X-ME-Received: <xmr:-aSVYl_5Cobis8TlOCT766UqIVrpV2wP-kJsNDqMjeTyNeQWVhMf5IvL48TmHHQ_cSJiFt41bwuLHh15yW6AYj0mmOUSQxx-nsFYWFZqzr1IAgxurKuBqeusZ6zKLn2mRJEYGw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrkeejgdelgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpedukeetueduhedtleetvefguddvvdejhfefudelgfduveeggeehgfdu
    feeitdevteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:-aSVYprzLnndULNkMmh3jvqM6xU7hVXBgKHJi7d5godojMGM_R6k0w>
    <xmx:-aSVYurYFSK7ENJjW1y51syY9DdUxydOBVYPtX80IfGrQ4YENaf34Q>
    <xmx:-aSVYvQzzog2WPDRLKqoIcEEGQMGLenu79sRFPmwQ8CBiNk0UJM8bw>
    <xmx:-qSVYt0usGGPBP7ewCX3XzLMm1M0IvVmkceNnYaxIiyTdvqqmUz-Wg>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 31 May 2022 01:17:45 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Jernej Skrabec <jernej.skrabec@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <mripard@kernel.org>,
        Samuel Holland <samuel@sholland.org>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH 2/2] dt-bindings: clock: fixed-factor: Drop Allwinner A10 compatible
Date:   Tue, 31 May 2022 00:17:42 -0500
Message-Id: <20220531051742.43273-2-samuel@sholland.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220531051742.43273-1-samuel@sholland.org>
References: <20220531051742.43273-1-samuel@sholland.org>
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

This compatible is part of the legacy sunxi clock support, and has not
been used since commit 6b48644b1d29 ("ARM: gr8: Convert to CCU") in
October 2016. Now that the code for this compatible has been removed,
let's drop the compatible.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

 Documentation/devicetree/bindings/clock/fixed-factor-clock.yaml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/clock/fixed-factor-clock.yaml b/Documentation/devicetree/bindings/clock/fixed-factor-clock.yaml
index f415845b38dd..0b02378a3a0c 100644
--- a/Documentation/devicetree/bindings/clock/fixed-factor-clock.yaml
+++ b/Documentation/devicetree/bindings/clock/fixed-factor-clock.yaml
@@ -13,7 +13,6 @@ maintainers:
 properties:
   compatible:
     enum:
-      - allwinner,sun4i-a10-pll3-2x-clk
       - fixed-factor-clock
 
   "#clock-cells":
-- 
2.35.1

