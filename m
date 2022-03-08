Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CFAC4D1614
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 12:21:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346334AbiCHLWR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 06:22:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346310AbiCHLWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 06:22:15 -0500
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DA1B1D33E
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 03:21:19 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 06C743201D2F;
        Tue,  8 Mar 2022 06:21:17 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 08 Mar 2022 06:21:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; bh=pKOLDup6CMOwYt
        Ms01f3OYDYeaQCLPa97H9UsprugUY=; b=VvA4Pnhx9qU+d6MYTfyKTF1k3A5N7c
        QU5i6l3JMTARjoJTfOz/EG7PtNQe4RFT2gmmGQtOKevu68uc2IrdU0lDonp6rNJo
        G29IoRJEvJ4fitmEqz36A/KKc9Z7FI7bLIWrbsGwUt7JjHLtYbuHF/FAmbnxcOLS
        HorFClux16n9nX3CicIXKZBYfXEWgmezXOlfsPWertrQkp5Y9SBQ1P8YdBQzEqkf
        iw7O1/1qJh7xAehTRuZV/59wVQyUmbM/kuB/QyAKH4sSX+XzwWr9rQ8WfFwdv3Fr
        qPH1qWulQXWnpGV/RWrTAsJPMXNbnlP3yHFzPI5BaB9BWTam9IHkEePQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=pKOLDup6CMOwYtMs01f3OYDYeaQCLPa97H9Usprug
        UY=; b=c43SFXaZPv1kn4o+X4jmfEC62HVt7ROIE+BsQbrQDdtAfBdSlfbs9fTCu
        PJU1t9uvnDo6xPQZJNAWlspwmo3zSY4XNqWt1itsbzgM2t6N9cstdJGypmWC7TMA
        OIwKQqnOWzynePjh0jX9B3IyR3lFRl+dpn8ES/icwky7XSEmlFuxDy9AGOkJqu7p
        gIFVdUJoa7FFOspXX40r61EMS+AkMT6tWlaDfcZVsWApl1pYGFXWyseL2spZlW12
        OHsL3JQJFMKvGCvQkz1cRMmrAI8dD0XP1QKxEYuKAiEXgY6gBB67Yp8s9S1UT9vY
        Qig0IPtzYBFuQzod0j6wXCJYJa+DQ==
X-ME-Sender: <xms:LTwnYi96AiL9MsDM26SVXo1Nuf8sqa50MpadeP0GEUDjBnqO-nwrOQ>
    <xme:LTwnYitcHmJscRYdbhviUC-W4Ds8W-yZVakWQN_v1v_BU7gDg3qB3h-4ajRFuL3Zs
    iEywKhG6yXT2EZ8pt8>
X-ME-Received: <xmr:LTwnYoA4wEZUI8B7cULCj-R_ZseNnEyqeUn5j0NcrHSxQVISqW0Bd-8rzOjMHtO7YTKru9Qv68zgpohysWOPtQWlH2aM-SXp3K3G6O4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudduiedgvdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpeejuefggeekfffgueevtddvudffhfejffejjedvvdduudethefhfefhfeeg
    ieekkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:LTwnYqd6fi050ppkI1keeu99pDV8lOn7uRT4hesNwyItYqn2_HMUbw>
    <xmx:LTwnYnMHRCEhiI-aDiHS8vagCevvyjaRRftk2X3qXZv_do31L72zyA>
    <xmx:LTwnYkkak2GQstm9tyfkp9AN3lBfihK6eNYpv1bI4ednGT5lp3QISg>
    <xmx:LTwnYlsRt7uck-OuMmWt5Lzgs0QgEeF12SgO4o3Rzifw7CCE5NJR6w>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Mar 2022 06:21:17 -0500 (EST)
From:   Maxime Ripard <maxime@cerno.tech>
To:     =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>,
        andrzej.hajda@intel.com
Cc:     Maxime Ripard <maxime@cerno.tech>, linux-kernel@vger.kernel.org,
        jonas@kwiboo.se, narmstrong@baylibre.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, jernej.skrabec@gmail.com,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, airlied@linux.ie,
        Laurent.pinchart@ideasonboard.com, robert.foss@linaro.org,
        matthias.bgg@gmail.com
Subject: Re: (subset) [PATCH] drm/bridge: parade-ps8640: switch to devm_drm_of_get_bridge
Date:   Tue,  8 Mar 2022 12:21:03 +0100
Message-Id: <164673846305.2436174.333287001156624230.b4-ty@cerno.tech>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220228183131.23494-1-jose.exposito89@gmail.com>
References: <20220228183131.23494-1-jose.exposito89@gmail.com>
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

On Mon, 28 Feb 2022 19:31:31 +0100, José Expósito wrote:
> The function "drm_of_find_panel_or_bridge" has been deprecated in
> favor of "devm_drm_of_get_bridge".
> 
> Switch to the new function and reduce boilerplate.
> 
> 

Applied to drm/drm-misc (drm-misc-next).

Thanks!
Maxime
