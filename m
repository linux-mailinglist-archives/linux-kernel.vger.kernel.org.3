Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0270F58D60B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 11:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233053AbiHIJMu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 05:12:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbiHIJMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 05:12:47 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 149DE21824;
        Tue,  9 Aug 2022 02:12:47 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 0389A32000D9;
        Tue,  9 Aug 2022 05:12:44 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 09 Aug 2022 05:12:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=undef.tools; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm1; t=1660036364; x=1660122764; bh=rB0hDcQzcfmipxIVzOCx2wq2L
        3CxDGgdvFX9zfr40wo=; b=j3f3h8I8z89+u/np0MjbsUbJ/qyMFawKi0ER0Qhe5
        nStveoZA6Mk8qnPfq4wYAvohEof6OKeAVV3vgRYpSvP6LqufNIKIWP1zq6Eq7Mhb
        rOY5sQKbHKUpIgVS+krJ/u1GOwjGMo0Ob13jEjFdhpvmUWFr4GHhFw34qz27VNxr
        Ubg2ypPuEpBeU1fmPXh59dMhGdFOvU6S1hdIxXw+byK0r1rlWxEbEZuD8+Py0edJ
        26puMERe0G49+rR7wFAT6Vs5xJR42UDxhCGDAyYbWnNxOPGzboa6OV5cTn7nUlJl
        bzCRl/glO44uVYGMgL9+tyuaIDk5g0DBl2phfWYiyXwXw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1660036364; x=1660122764; bh=rB0hDcQzcfmipxIVzOCx2wq2L3CxDGgdvFX
        9zfr40wo=; b=oJFJUkDBEUD9Bn1BU4LOzSXhwRg9esjaztYvqevUB6PkioNO421
        U+F0fLrD00b6Nj3kDtH5CVamHVeSky3IzG/0hZoJBrkGKuZibPatC/yxiZ8nowpq
        tDzRctcbUsPOqxMlvO4U6AXVmfCsIVNJXViZ+j75Z+B6hYZbiYjnxvsxoRg1e6mH
        HXdJNilBbtQQCigjTEriFUGwcGJ3uSunpNTTf+fyt2tiu3yoZEv9s7Mwz3S5rF8e
        OI0r9yWrHw3YL6Dhau09FryoRi6rvd/1K+9VQ7Z3/d0lffZ0zvCZTIKyVs2LQgIK
        K2jiuF8azRDHOSRnczxLt6QhFrFh1Zxeuhw==
X-ME-Sender: <xms:CyXyYlpb4QPU4ZSvqSSQpwKUi_CeRk73FOdG1HZ0YYxdDGDxLnVTFA>
    <xme:CyXyYnrd9KnS7b0pYF-0wVLaUHoiHWhIcuplR0hR6gyGO6y_l_jF16YTJlyM8O1Yv
    uTuYAFx1omfUuQqxgg>
X-ME-Received: <xmr:CyXyYiNBFkyRLIBo0U20yf0eZZnzLunPrKQK3CEwPGHPrU5lQRFp_HdnyUS9AO61OUsYz5BqF7ijVQdex7Iawpml3-fdbe0_zz4Ul803n-73ZJG9FVtaKzsM_Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdegtddgudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpehkvghrnhgvlhesuhhnuggvfhdrthhoohhlshenucggtffrrght
    thgvrhhnpedttdeiheeggfevgeekgfehkeegleekjeelleekjeeujeektdekteefgffhke
    dtueenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehk
    vghrnhgvlhesuhhnuggvfhdrthhoohhlsh
X-ME-Proxy: <xmx:CyXyYg6aJg_kffOVzVibNpTdQgV8NrwggMn8IMDaj3HumbPBsxX_iQ>
    <xmx:CyXyYk7wA4c9HPqB5l6IgdYud8Ooz0Tb5WnrKp976LZVBN5gfr0a7g>
    <xmx:CyXyYogBYrOAANNbBx7EzUWplZjTUMxz8KaKbGf9LG51c80BV8-Jrg>
    <xmx:DCXyYhtLJI97jbtCNPFhwJsyXGOyZfaMT4syjRBYnOuNI80Qg9SFvA>
Feedback-ID: id76147eb:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Aug 2022 05:12:41 -0400 (EDT)
From:   kernel@undef.tools
To:     hadess@hadess.net, hdegoede@redhat.com, dmitry.torokhov@gmail.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     phone-devel@vger.kernel.org, megi@xff.cz,
        Jarrah Gosbell <kernel@undef.tools>
Subject: [PATCH] Input: goodix: Add support for GT1158
Date:   Tue,  9 Aug 2022 09:12:01 +0000
Message-Id: <20220809091200.290492-1-kernel@undef.tools>
X-Mailer: git-send-email 2.35.1
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

From: Ondrej Jirman <megi@xff.cz>

This controller is used by PinePhone and PinePhone Pro. Support for
the PinePhone Pro will be added in a later patch set.

Signed-off-by: Ondrej Jirman <megi@xff.cz>
Signed-off-by: Jarrah Gosbell <kernel@undef.tools>
---
 drivers/input/touchscreen/goodix.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/touchscreen/goodix.c b/drivers/input/touchscreen/goodix.c
index aa45a9fee6a0..06d4fcafb766 100644
--- a/drivers/input/touchscreen/goodix.c
+++ b/drivers/input/touchscreen/goodix.c
@@ -95,6 +95,7 @@ static const struct goodix_chip_data gt9x_chip_data = {
 
 static const struct goodix_chip_id goodix_chip_ids[] = {
 	{ .id = "1151", .data = &gt1x_chip_data },
+	{ .id = "1158", .data = &gt1x_chip_data },
 	{ .id = "5663", .data = &gt1x_chip_data },
 	{ .id = "5688", .data = &gt1x_chip_data },
 	{ .id = "917S", .data = &gt1x_chip_data },
-- 
2.35.1

