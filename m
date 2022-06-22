Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 372035543D2
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 10:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353324AbiFVHaI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 03:30:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352669AbiFVH34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 03:29:56 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C80D34645
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 00:29:55 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id F15865C00F7;
        Wed, 22 Jun 2022 03:29:54 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Wed, 22 Jun 2022 03:29:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1655882994; x=
        1655969394; bh=FbbDHGfykC29vpo8q1S1GdxTzi9rhuenaGAuTzE9OM8=; b=A
        r3ZAlKsZM2ih/FXS6EZgPWz3r9eI7r1DQQJD+9VpksiUG5KXeIU0M9VHLYMMfCAM
        OOEeg8Bcx0FsnupA362KQmfdxUSveIjo+5cagjx94PQHKH5+ySU+FA7PsTRtiSQc
        sEnUEJ77jRrjkvT8Q/3pq1tdKletutqzegWgerImbDszMWdI7viQM2H9mUQd2zWa
        sKRum2tf3y/42guXwYqRaiDaXP55goBVX4x6+RuW/xWhZRvAgwhv6iSsXfBS/Npi
        h1Fjbv+29qjBVFWimvGiCLFd8YMYY36ZR6S6RacH6b74whQ7XIAv7B0fWjiy+dls
        pwwbAzupdUMLbc47CFGaQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1655882994; x=
        1655969394; bh=FbbDHGfykC29vpo8q1S1GdxTzi9rhuenaGAuTzE9OM8=; b=u
        s008JLqRZuUV3eDndqAHVE2WFSZskVm6nf3be4izr9DOlpdP7xVUonWUWjKSU0c1
        2fz3ErFEIyuFXo2uwWpMIShHwDwiyotAbyli1I7izW7v4R9U0LO97pN93Zoe2zOo
        rSoPGfLHmIU9+760a36h6wfR4jAFdeapxBpKMwcsrpwm7vkXrMHcnApcKTUzPwaF
        CpdDHU1+UxbIhTT2KOaCwsHoGtQUTwtQYsKBb6PDpf6C/uN7v5r5xvJK5fukC8yR
        5qgDcpyiihueD5f/dgaPyEIy3kDc+uTvkNNZSehx0iQYgBHN/PK17beHJZsIzjjG
        FkIE2bfO+Ci0nCaCKwoUg==
X-ME-Sender: <xms:8sSyYosVRlGhEXWXSE_MesvGdgae4IuQLb_NlbRLOXGDVh48FCgY7w>
    <xme:8sSyYlcqTEBQZW1yRoyzd9YIuoT93azMf1l0nOdb-TdYMRyoFpp-auhwaog5Ne_Xd
    p_wN0Oo6e2i3gEoVvM>
X-ME-Received: <xmr:8sSyYjyJDEAIpeq0scNehnJEUfbyXElt2ZoFgwMObgKePqrqmTA0lF4TfWodhSxn3cYkqFQyuTOJGbAd02jyD6YVUH0REWQ5PwSXds0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudefgedguddvudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhggtgfgse
    htkeertdertdejnecuhfhrohhmpeforgigihhmvgcutfhiphgrrhguuceomhgrgihimhgv
    segtvghrnhhordhtvggthheqnecuggftrfgrthhtvghrnhepueeigefghfffffeifeehud
    eiuedvteegueefffevgfetvdffheehkeffvedufeeinecuvehluhhsthgvrhfuihiivgep
    tdenucfrrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:8sSyYrPC1VhCmpIZrmIaYtn0FEDi2_ZvrD4TuuThg2ZmjGDTb9xhiA>
    <xmx:8sSyYo98ONPuhilwKpLY9t6kL3270I1dDuJhSGIUxHyn3L6Q8USMsA>
    <xmx:8sSyYjUfsAVdTc-03NgK5M9_LbJFjDcB5-wUH3EhTqfFMx50QPU3YQ>
    <xmx:8sSyYlP4gK2wUsy5f-wzDzmewKuTXAsecIhVrhdWXBSMSqwXEo6UHw>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Jun 2022 03:29:54 -0400 (EDT)
From:   Maxime Ripard <maxime@cerno.tech>
To:     maarten.lankhorst@linux.intel.com, airlied@linux.ie,
        jiangjian@cdjrlc.com, tzimmermann@suse.de, daniel@ffwll.ch,
        mripard@kernel.org
Cc:     Maxime Ripard <maxime@cerno.tech>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH] GPU: drm: drop unexpected word "the" in the comments
Date:   Wed, 22 Jun 2022 09:29:44 +0200
Message-Id: <165588297922.13818.8703754618322133004.b4-ty@cerno.tech>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220621135140.12200-1-jiangjian@cdjrlc.com>
References: <20220621135140.12200-1-jiangjian@cdjrlc.com>
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

On Tue, 21 Jun 2022 21:51:40 +0800, Jiang Jian wrote:
> there is an unexpected word "the" in the comments that need to be dropped
> 
> file: drivers/gpu/drm/drm_ioctl.c
> line: 86
> *    means the the unique name for the master node just opening is _not_ filled
> changed to
> *    means the unique name for the master node just opening is _not_ filled
> 
> [...]

Applied to drm/drm-misc (drm-misc-next).

Thanks!
Maxime
