Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 197B05543C9
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 10:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353347AbiFVHaG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 03:30:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350428AbiFVH3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 03:29:54 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB2FA35870
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 00:29:52 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 3C01B5C00D5;
        Wed, 22 Jun 2022 03:29:49 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 22 Jun 2022 03:29:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1655882989; x=
        1655969389; bh=qpQsXRejsI5099x61Mrfm6AobkDq+7MXCwHTQ9iVnz8=; b=2
        CgCq34k2nBXyhUj3Udy0NS2MufzxpNTQFlDwGhgAKDFOafFIs3AdXACqqKWE++QE
        Eul/E1CREI+rQalyY5r1Ljp1MPySRRCh/+xgYhwTAUd7o21IOuf8n5dGlxKSBGfd
        SpD6DBQ+qMaB/BXB676xwVjniaDP0/2E9dQBliQ5fI5ZJAE01VzNZR1r3GOiMOYc
        eEcgWb/7iUHpOr1QkO67dWhn3syCm1dm2QuE94OPnvZIMq/m6aN0lFVq5dnyxAkM
        lepLA2w2q4tyWDdmQxuIh778INABM1sBEUhIKni499QBdh0X+cMNj2zxoMZpRI1o
        WZQjH5aK/pXGD2QCPKuIg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1655882989; x=
        1655969389; bh=qpQsXRejsI5099x61Mrfm6AobkDq+7MXCwHTQ9iVnz8=; b=W
        MoEymr5od0X6+orniJreaujenHudYxcrsGVSjcljTuqX5TI9VEFok7VPkS3fwLh4
        7wT0Uk7sps1SY49zN5cOPcIBh97M/Rjfch/MPfoq8FwdahG84iVdWnnR1lujGTt1
        e/jSdBaRnzmVv0p45WFBCIt/8UKkdmy1Ow+TBxGD1F3Ue2pHteEvszz8nMU0WheW
        OPhEK1icwjLY79v0EWSSru2XUz6i4RUaoKw4em5jRZey1TrWfIT/18xLP27Rmeak
        2XTfjfyiPc1PIAlbId224wGL98nywR5Mk5pHVumb48kbiIuYr6OqIRlannIxrSw2
        qqiJQTBSWY3LALLW8XW5w==
X-ME-Sender: <xms:7MSyYkeZ8P-spzD8jGMKPn1C6MDrjAQ4sRCGFuLDYTSgHMnrrQaEIA>
    <xme:7MSyYmMpkUrBoCGw4HsdxY_4EUd9QsoefM2CzhB3SMzYSYQCJiAGKQDWQvdJ2aU07
    Fm4_uxly4d3wRSjXrA>
X-ME-Received: <xmr:7MSyYljpoSNCrMN2LlRBdI-w4p38wFR-b6PmFrreLY7Ta2vsJCikObtYKDXUT32Z3Aelbzf8Q1VM1rwI-xbGQPMItv8j-1-qEAhXK1o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudefgedguddvvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhggtgfgse
    htkeertdertdejnecuhfhrohhmpeforgigihhmvgcutfhiphgrrhguuceomhgrgihimhgv
    segtvghrnhhordhtvggthheqnecuggftrfgrthhtvghrnhepueeigefghfffffeifeehud
    eiuedvteegueefffevgfetvdffheehkeffvedufeeinecuvehluhhsthgvrhfuihiivgep
    tdenucfrrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:7MSyYp_WmFVfY0bsEuGXgT2qzP5x68Swr9Tb7Gh-YptMfEeatD-1gQ>
    <xmx:7MSyYgsAvruQiYusk_Yw1xBtZUjolIw6Rcwo3pEZhgHoCX3tGSGc1A>
    <xmx:7MSyYgGD-rjguZOZB_1W5vGYKMsjhIWoz4Jgh9klzokMMinseZzkKQ>
    <xmx:7cSyYl_Sc-SVJTj8hk1SaC7tRsNYlO3WlhrW676e3ENxbj-qnLr2CQ>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Jun 2022 03:29:47 -0400 (EDT)
From:   Maxime Ripard <maxime@cerno.tech>
To:     maarten.lankhorst@linux.intel.com, airlied@linux.ie,
        jiangjian@cdjrlc.com, tzimmermann@suse.de, daniel@ffwll.ch,
        mripard@kernel.org
Cc:     Maxime Ripard <maxime@cerno.tech>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH] drm: panel-orientation-quirks: drop unexpected word "the" in the comments
Date:   Wed, 22 Jun 2022 09:29:41 +0200
Message-Id: <165588297922.13818.16761232359247281668.b4-ty@cerno.tech>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220621134401.10290-1-jiangjian@cdjrlc.com>
References: <20220621134401.10290-1-jiangjian@cdjrlc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

On Tue, 21 Jun 2022 21:44:01 +0800, Jiang Jian wrote:
> there is an unexpected word "the" in the comments that need to be dropped
> 
> file: drivers/gpu/drm/drm_panel_orientation_quirks.c
> line: 196
> * GPD Pocket, note that the the DMI data is less generic then
> changed to
> * GPD Pocket, note that the DMI data is less generic then
> 
> [...]

Applied to drm/drm-misc (drm-misc-next).

Thanks!
Maxime
