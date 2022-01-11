Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C43848AACF
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 10:50:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245232AbiAKJue (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 04:50:34 -0500
Received: from wnew2-smtp.messagingengine.com ([64.147.123.27]:59373 "EHLO
        wnew2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237058AbiAKJuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 04:50:32 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.west.internal (Postfix) with ESMTP id 584682B001E9;
        Tue, 11 Jan 2022 04:50:30 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 11 Jan 2022 04:50:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-type:content-transfer-encoding; s=fm1; bh=
        6hPH7VzTwcImEPSIhBucunkvcQbFeOcYEPgbNcRFwRg=; b=nXkYVUf+jpBjJ06d
        OY4641f9ffF2adsDoc0+F5oc5k3qXvJOPV7BDv4aYUJ6dBrGh3A3h9BR26q8MgYR
        7uTuW+MX0HGQXb74AIO+XvoC6fh5kUAl/hipA8vAN8T48Qz/D8i/rL/Pp3hwg/3f
        lHdkkHzPB9f/5ZMxSQh0dac2+eE7PAD4RqtCd/wFhKC1Yqa3o6EYj646C8DadGxU
        nhQwdtXo6Z8S+BKexsyChTnCCN9MAKfx644KCxSDkF/FoDC7elQNf9mftQJpZESn
        WnxgPYNq9VMNLCBJj69GLmR66bgCV6o7ICXPZeN+4jikDTlIdnDRSYevIHgjO/cy
        CTP34Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=6hPH7VzTwcImEPSIhBucunkvcQbFeOcYEPgbNcRFw
        Rg=; b=f/yUv9Zmz8D+9R678mtInX8lV6+s4idR8iOlOSXB3XEOYOH+r3FBhzBp9
        Fcoy95l6LNXqqwTFxxODj6vt9VS1AoItVK/OBa/7pGas7BsvUnwjLwrt7OKobmYW
        QbrG+LY46Lhl/HvlE+NF7j2jmvdvguyq1yMgh8xMKMXIidIUCIfJA8Cphc3G3v9A
        N+CXsGQlgMaWqggX+57SwOYarNWttcWypaGKng0JrICkHYwJw1zZURhSWA06iyE3
        Gwgbbd1Z/ngFPJTe7Eu2Xd2eki5mHy6GGugpyyiNmvkWkpAcPXhLBnFDT2/H3i6d
        qaONk/eHzFVJ4TFjXKP5pW1IS3TcQ==
X-ME-Sender: <xms:5FLdYeLItYXZgBSFOsAjqt6PjMmmCAvGpZrVhOJkBbiAVnF-qf9QBw>
    <xme:5FLdYWKwL7XfWoeCQn0OsPJSMqEl5Aiq43DlWy-0XgyqUlpKqg0g4oBi-aVYCm3Qt
    GKEZWpjPX0Vg2UHlGM>
X-ME-Received: <xmr:5FLdYet9fosJ5mK9wyN9TH5PHpkooPWsFtbm4zSmwKnsBUQkpnr0BeZLYII684k_1dv9SVMFtG_KkqQVObWFtSyDl6wNTpXpqABmzis>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrudehfedgtdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpeejuefggeekfffgueevtddvudffhfejffejjedvvdduudethefhfefhfeeg
    ieekkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:5FLdYTYrhC0vsR-rm-AzLAjnvc4jDi8TepMWtxaZ-bj58KxA7XMENA>
    <xmx:5FLdYVauJAbpF7xq2sdGTteicBChaxBUrj77_QcJnfsI5ChjgXdv6Q>
    <xmx:5FLdYfAabl4cY5ZcldcomXNj0WLm1quD6asP6aUz93QaytZbvZITug>
    <xmx:5VLdYbDJgEnSm_-7UQQWf0qkK4wQC2EHHhRMGccm-sDJpf34GgsqZi3wllg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Jan 2022 04:50:28 -0500 (EST)
From:   Maxime Ripard <maxime@cerno.tech>
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     Maxime Ripard <maxime@cerno.tech>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <mripard@kernel.org>,
        Saravana Kannan <saravanak@google.com>,
        linux-arm-kernel@lists.infradead.org,
        Ondrej Jirman <megous@megous.com>,
        linux-kernel@vger.kernel.org, David Airlie <airlied@linux.ie>,
        linux-sunxi@lists.linux.dev
Subject: Re: (subset) [PATCH] drm/sun4i: dw-hdmi: Fix missing put_device() call in sun8i_hdmi_phy_get
Date:   Tue, 11 Jan 2022 10:50:26 +0100
Message-Id: <164189462190.787936.7018811034548071748.b4-ty@cerno.tech>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220107083633.20843-1-linmq006@gmail.com>
References: <20220107083633.20843-1-linmq006@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Jan 2022 08:36:32 +0000, Miaoqian Lin wrote:
> The reference taken by 'of_find_device_by_node()' must be released when
> not needed anymore.
> Add the corresponding 'put_device()' in the error handling path.
> 
> 

Applied to drm/drm-misc (drm-misc-fixes).

Thanks!
Maxime
