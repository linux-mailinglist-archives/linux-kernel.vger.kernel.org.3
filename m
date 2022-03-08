Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D482F4D1619
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 12:21:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346457AbiCHLW1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 06:22:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346454AbiCHLWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 06:22:25 -0500
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9CBF46658
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 03:21:26 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 608553201C39;
        Tue,  8 Mar 2022 06:21:25 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 08 Mar 2022 06:21:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; bh=WQGU1J9bbr3315
        rs6JgpybcLnc3CGCNSMmh1icWwJ2w=; b=EzBZmiAwJM9vaCsbffQ9rSI/xG9kgH
        W7FJPJxo6sbSSpjRQIbTsHRgX2RIuBhwPJqVzyFyUusP80oqgbuzxLxt8h9ZTXAE
        R06sk46QdqCEtrXvoV0S5aBvTkq6HdHCy13oycDTQ3FaPk/sHGnNLatY6Rm3BrdP
        v1vwXLZNAtXlfoVs6Re19UJZv020I4CqZKJ1LAoRx/GROTA9oqT5E773AOJgDg4y
        ZrTJDncxBzngUbN0ShF9tN4fPuHRNW9Qrn0pnbAlFRxWshOZ/h1S3dFQIG23nCaq
        OPcf7HF+JwJjQCyX7ZGIjnEgdY7Vt4dQNQX2ayTesZh90jp6vudBUIow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=WQGU1J9bbr3315rs6JgpybcLnc3CGCNSMmh1icWwJ
        2w=; b=D1gBGIHAzdD6IonqNeul+eWiN74KpQCCJml95QKv5ze8BHSP8NWZCk5bv
        /5iICYG4GfealB52uUM2hHeji68f5tQwDi276N9Mo3NwmMsd0M8d1PmIci8+cmA3
        HTjQ1qUV+3DjHLQ0p2YXxLvFBXpQPqneukUJRWSVptMWKIet9oe36jahjNmj0NeU
        K/hYney2Utj5nIwgS5kqpJ3Vy9+wfHqCyD8hLJSCOCcNKAsSvj/Ybj5G0D/OP19H
        jhRelpGaf0vXAze8j+WBvOgl1VY2J2YONO7eG6Kamm6jOtGppQRfrOI8nsM8vnS3
        ukZ0RjU6vTe0WEz0Kz+G+G5qHDY8g==
X-ME-Sender: <xms:NDwnYo05Mxk2Zw430nOJzoClOqdc8FraBIih_64SoC8DCkD9rBZxUQ>
    <xme:NDwnYjFLdlwbfT3ODMJ5k_aZCCpsGOR97_M_YwdKoucDBFPFs8perdz_43Fs0BY8Y
    b63-5FkRoLa95IZNqU>
X-ME-Received: <xmr:NDwnYg5ieGwG6dgIVNIoWgas08Z-8NwiJCKi86eP7CmQqE4Smf_lpJOQhsgP43CyBBVJmwfQ8uW1cMkRuEw-23Qt-Bs_GyaK8zbAK04>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudduiedgvdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpeejuefggeekfffgueevtddvudffhfejffejjedvvdduudethefhfefhfeeg
    ieekkeenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:NDwnYh3AJSX3D6yawmq_YZd9Tv0mloaqXPTQ06gBpVkS2U9wc1hR_g>
    <xmx:NDwnYrGerDga9K5aQJrujzQRJdKsK1e9pAx6y0PfEbG3f681Ebce0Q>
    <xmx:NDwnYq8zJYJ45yK69b3qteD8ozcKiZf92LRqi2lAmJmEkTCAdsCHCg>
    <xmx:NDwnYj8_rJVpYNxm_DKOhVw1AOpdRgNLpG4YNFVGBvl4rjbKxwKQwA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Mar 2022 06:21:24 -0500 (EST)
From:   Maxime Ripard <maxime@cerno.tech>
To:     =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>,
        andrzej.hajda@intel.com
Cc:     Maxime Ripard <maxime@cerno.tech>, linux-kernel@vger.kernel.org,
        jonas@kwiboo.se, daniel@ffwll.ch, narmstrong@baylibre.com,
        dri-devel@lists.freedesktop.org, jernej.skrabec@gmail.com,
        airlied@linux.ie, Laurent.pinchart@ideasonboard.com,
        robert.foss@linaro.org
Subject: Re: (subset) [PATCH] drm/bridge: tc358775: switch to devm_drm_of_get_bridge
Date:   Tue,  8 Mar 2022 12:21:05 +0100
Message-Id: <164673846305.2436174.6327272600175269390.b4-ty@cerno.tech>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220228183537.24600-1-jose.exposito89@gmail.com>
References: <20220228183537.24600-1-jose.exposito89@gmail.com>
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

On Mon, 28 Feb 2022 19:35:37 +0100, José Expósito wrote:
> The function "drm_of_find_panel_or_bridge" has been deprecated in
> favor of "devm_drm_of_get_bridge".
> 
> Switch to the new function and reduce boilerplate.
> 
> 

Applied to drm/drm-misc (drm-misc-next).

Thanks!
Maxime
