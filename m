Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92CA654DC2C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 09:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359448AbiFPHxN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 03:53:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbiFPHxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 03:53:12 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E74B618340
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 00:53:10 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 59FBC5C0812;
        Thu, 16 Jun 2022 03:53:10 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 16 Jun 2022 03:53:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1655365990; x=
        1655452390; bh=yhOcX+f1pknlnytTgSo3UJOLuU3SN3V0jXKkDNX54yg=; b=N
        ka+TyZSVWic/tghSEVeXSrieAnw0Pi73ga8TcqsfG+1MGhmi+edNrtKkvfXeYhnd
        CGqZQgUFxHoQVWekZdhYxitCR0OmMfzElogTesU/WLkbEJ+ZkVqLRDLamcx9LJ6P
        7YWAQ4ULKFjc3oAbL6wmVCUJ+7N4MyxM19QledULNK2TzU76eE1Gl/tZKaYBndj0
        5b9x0WnG1bgK/P8CGRl4EE4yFEE5nNnX85jkdlGjxTuByeXfHiUnroxfHckQbP1R
        rxVNeqLcRO/zI63BJeKAM9oPy/nRuUROtTy+LhJBGohC+rTr4xkSlm2WhKIRMVCq
        hNSq1So+ZDuXQrdcQ5HTA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1655365990; x=
        1655452390; bh=yhOcX+f1pknlnytTgSo3UJOLuU3SN3V0jXKkDNX54yg=; b=s
        bTFpBB2yjwveAUbb2fNl4gs3ahSvFVCKo9VdzIqYGAi2KlMRBSD1mv5vM5PRnqDb
        dU8ggxorxBD+JvnMbt7bKhvr3GOWSWjof694aMztw198ehxRP5lFojIg/wFgwBll
        4BYsRez1AtY/TORweVQXT5pOhNmLOnI3II9orIoWzafimBzQjPLFAz0Tt83G/T1Z
        sBVcG3J2x3rQsx9pxiXB+4CQczzYGZ8gz9lX1d70e64RlHzgC1Q4dygCyv4lANkk
        7a2MvidNV0+T08janD0ETowScSUwKsbp+fb/OpeCAk8saF5rGYPecKuJH2Kp6MPg
        QB+o9TgB8dpYBkK/kzJdA==
X-ME-Sender: <xms:ZuGqYvoEvjDpVoLpEAGrHEdoK9RJgO_9PtOTjisKMdiiRf7ZkogWng>
    <xme:ZuGqYprWziObwUJ43Qo3i-mCedPBxBYF0Asx1qSTMfpKe_W-P8iNU5oq_lFIe3Cji
    VKqUDOjOJyWxPbkFhM>
X-ME-Received: <xmr:ZuGqYsMTOG1LJEVKz5ThTOxS-uP0m8yX2A7EyoNeMZINYzdSCwquS81KBnAlapOHO_sEvpci-ciGaybtrNLFn1d60L_XzXR1tH5nXpQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedruddvvddguddvfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvfevufffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepofgr
    gihimhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtf
    frrghtthgvrhhnpeeuieeggffhffffieefheduieeuvdetgeeufeffvefgtedvffehheek
    ffevudefieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:ZuGqYi4ISXm_oNYcI6nD1vQDadeT-OiSZl5Ay8m426Wt8n1tVrm2ZQ>
    <xmx:ZuGqYu6THeyGX7MsH7kwv8KouuBnC8jjzwSXUPgZDNV47k2kq4W6Xg>
    <xmx:ZuGqYqhszl_jQP7GXfgjOtuhBsdNLiIPZ0zWimS7KUGdGYUb-vRyTA>
    <xmx:ZuGqYhI87U5ez8-gpfDh5yQp6u_2H23IzLXNy7Em8sZ-eQRc6NxKcQ>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Jun 2022 03:53:09 -0400 (EDT)
From:   Maxime Ripard <maxime@cerno.tech>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     Maxime Ripard <maxime@cerno.tech>, linux-sunxi@lists.linux.dev,
        Paul Cercueil <paul@crapouillou.net>,
        Neil Armstrong <narmstrong@baylibre.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        Daniel Vetter <daniel@ffwll.ch>,
        "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH] drm/sun4i: dw-hdmi: Fix ddc-en GPIO consumer conflict
Date:   Thu, 16 Jun 2022 09:53:05 +0200
Message-Id: <165536598378.1275350.12830917316957790338.b4-ty@cerno.tech>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220614073100.11550-1-samuel@sholland.org>
References: <20220614073100.11550-1-samuel@sholland.org>
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

On Tue, 14 Jun 2022 02:31:00 -0500, Samuel Holland wrote:
> commit 6de79dd3a920 ("drm/bridge: display-connector: add ddc-en gpio
> support") added a consumer for this GPIO in the HDMI connector device.
> This new consumer conflicts with the pre-existing GPIO consumer in the
> sun8i HDMI controller driver, which prevents the driver from probing:
> 
>   [    4.983358] display-connector connector: GPIO lookup for consumer ddc-en
>   [    4.983364] display-connector connector: using device tree for GPIO lookup
>   [    4.983392] gpio-226 (ddc-en): gpiod_request: status -16
>   [    4.983399] sun8i-dw-hdmi 6000000.hdmi: Couldn't get ddc-en gpio
>   [    4.983618] sun4i-drm display-engine: failed to bind 6000000.hdmi (ops sun8i_dw_hdmi_ops [sun8i_drm_hdmi]): -16
>   [    4.984082] sun4i-drm display-engine: Couldn't bind all pipelines components
>   [    4.984171] sun4i-drm display-engine: adev bind failed: -16
>   [    4.984179] sun8i-dw-hdmi: probe of 6000000.hdmi failed with error -16
> 
> [...]

Applied to drm/drm-misc (drm-misc-fixes).

Thanks!
Maxime
