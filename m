Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A77D508399
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 10:39:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376802AbiDTImN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 04:42:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376766AbiDTImK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 04:42:10 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF6E43AA74
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 01:39:24 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 97F673200907;
        Wed, 20 Apr 2022 04:39:23 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 20 Apr 2022 04:39:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1650443963; x=
        1650530363; bh=3SrGdyUlIGHjwPve02v+z7KFpEXmCdWDSAufyz8H+V0=; b=M
        EidIBmJtKvdiITV7506Db1V3rtZsA1haJpJScJmKeBbXjPI/O6KXHNPn9EmOVs39
        nJz4OEvhSzZ4IMgJTcuZzM1ovBJWiJ+w1YpbvatLRsr7SslXP6fjCwZBlkXWphEz
        +PHArC6mFPw60sppTSnSkAm9k9ltaKFA+Vr6rzhhRH6d7/fCQ/FAELvfdohQgTq+
        XlipU1lPDh+jXja5csUZZyVBehPp7e9eq9bytFwT5BGXuCzTqjRPTD55mgOX+tz0
        D8HTXX83YcFyDsjB5gOAIc63nQmqODDb1GgtghhjjJaj+ntuybl7MwUMknOzPnhv
        0ZX8N/bXM7r9MbVEY+vUQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1650443963; x=1650530363; bh=3SrGdyUlIGHjw
        Pve02v+z7KFpEXmCdWDSAufyz8H+V0=; b=V4nJywdq0t/iWAywM1mzmyNx/7n3k
        6aulAJdz7ZGJ9nAJqZvon8NLvY9ZBR9pTomqVts4CgUrbwpHyPqcBKUrwydBChZ4
        +gzdC3mJ2s9MuPftgl8Nn681KxZP0qixOdvMp8AG74VNfUu5tiX1SLgFfiJtP1Z3
        phnSN7GY/Er0wRfGixLEI9bt8mgJ8yYgc2z5MKbMn/x1ykNZBgQE3fvoj3fK/hjz
        Y4M8pXW8FaxF1NKTsUK4q8xOUQoG498gCHR+4LI1W5NIfmFN+v52wuPWo3a7Cm7f
        SCzIZ6TEAb74HK1VWtKUQSacxWBcexg8zidkosYwcup74itlivnrY+tDA==
X-ME-Sender: <xms:usZfYv6Ic3YT3G46m2CbXKAs1D45_HeEASJ1XsZ1RgzsKLm56aoNRw>
    <xme:usZfYk6kYxIzPpCtG0EOgyQ_hJVgzJDO89GarWOXyAoiPHgUoKa7NoniLbQlNBudI
    AZFZl0ez9gc3WLcA6M>
X-ME-Received: <xmr:usZfYmdhU21bvNyxX21ssCpPEJ14hOle69kqOgXthCq6MnrNUgFzYQB0BpuRyrbO7okZNrR4874TtCDgEqMwnACC2hZVXcXJwqrEXxQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrvddthedgtdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpeejuefggeekfffgueevtddvudffhfejffejjedvvdduudethefhfefhfeeg
    ieekkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:usZfYgJv2tfYgPvfnaPIbY_VMfoLafDNNQB9eWcg6T_S1e3FoY5a9Q>
    <xmx:usZfYjLU2HUq9vebsHAPQeTaZl5vuyZw3hy8rd3rfJ6J5SLseftrVw>
    <xmx:usZfYpzh9XbKkZd3LICKBB50WtsO1VdGg6XXHCRXCjpGa-wb0lvFLA>
    <xmx:u8ZfYgreVhhpa67kTOhSnBkzU0c54xEAJD46ZAFnDw6A9HQgWoMB1Q>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 Apr 2022 04:39:21 -0400 (EDT)
From:   Maxime Ripard <maxime@cerno.tech>
To:     Stefan Wahren <stefan.wahren@i2se.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     Maxime Ripard <maxime@cerno.tech>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: (subset) [PATCH 1/2] drm/panel/raspberrypi-touchscreen: Avoid NULL deref if not initialised
Date:   Wed, 20 Apr 2022 10:39:17 +0200
Message-Id: <165044395513.303702.1698535902830603869.b4-ty@cerno.tech>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220415162513.42190-2-stefan.wahren@i2se.com>
References: <20220415162513.42190-1-stefan.wahren@i2se.com> <20220415162513.42190-2-stefan.wahren@i2se.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Apr 2022 18:25:12 +0200, Stefan Wahren wrote:
> From: Dave Stevenson <dave.stevenson@raspberrypi.com>
> 
> If a call to rpi_touchscreen_i2c_write from rpi_touchscreen_probe
> fails before mipi_dsi_device_register_full is called, then
> in trying to log the error message if uses ts->dsi->dev when
> it is still NULL.
> 
> [...]

Applied to drm/drm-misc (drm-misc-fixes).

Thanks!
Maxime
