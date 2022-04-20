Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B28FC50839A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 10:39:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376807AbiDTImQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 04:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376801AbiDTImN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 04:42:13 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 964CB3AA78
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 01:39:28 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 417053200A6A;
        Wed, 20 Apr 2022 04:39:27 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 20 Apr 2022 04:39:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1650443966; x=
        1650530366; bh=cZy9XWBw5q/DEPYoSdmZpBAbvar+vC4kZjcXt8ISJY4=; b=y
        8AXonnN62kEnRLDXhUzepux+nBZmB84PIkaWOLitFxT48H7k+6Qr2IgXtZMjrxZU
        WE9EDGo+0aAXjMe3BN3OdJMgGN4Hot7r1FkI1Tv5gbk74blhJilX3+FWbXW599iZ
        RaqAj9puFWJdLOGS2mUKputgR+FT9uzjJjI718QZ0GkPuX+RN8v4thWL1foxs8J9
        JXc6SRa6QpIE6tEgFUkeiAKYuYkI750784U9l9Ul/4TcGNr89UFfhO+30RFeY3pn
        YyhqNCU8wmIsJ7QhbyEWvYPDrEMoa0i1smBqXdRz72NVFDrZTDolPwHS9rl8kmcs
        /QdSeQ7MmypNBrVbLOaXg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1650443966; x=1650530366; bh=cZy9XWBw5q/DE
        PYoSdmZpBAbvar+vC4kZjcXt8ISJY4=; b=gHqG2al0wuQmoiBALUnkQ9t76gjlh
        tdbX6fskx3SfxUcxHXprdvTRgDtrXVrt9Pnaed7MK6O8KEdeVZ0RMgjZiOs+zg7U
        fKCZCZS9aSnpFCzBtKfL/0wmsQrM+QPO/NS1N8eAZq0pCDLwrK9oMpV5/Rw1HKAh
        hN1VUTLyqBBOp+1yurbCLjR98Wx/Cf1jDtkjSBJ7SxoUGljDwc24PMTXFaLX2r1d
        gBu3qzvqVSJ2mMcnMWjm8JMivteCdhtzLOuDQcxBCLorbIaAP2C749MvrusYEfNk
        IIlmFnSs/u5slP5XZiC1p4NuKXiX2x0YiXjD5xthsct/Mb3FtOxQyOOCg==
X-ME-Sender: <xms:vsZfYmCXw794ca_KmjaVS3_MlwOOwyT-YKz6joKfeCReluNE94XWkw>
    <xme:vsZfYgjQvXR3oIzjXKQkQILWONvBN2ltxw_WgO23wITYuoKuNQtUY341xUwUlqYPA
    AiV8Kn_gVae8iBdfmw>
X-ME-Received: <xmr:vsZfYpkbeew8jbToZA1-L1jKdIDdA0kUeeNBgCzlYtp1XK5HeM-w1lkUq9QC6IAGjqAc3gKCcmeD-O1BdVw_Bv8WrZO49AJZ9B-fcWI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrvddthedgtdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpeejuefggeekfffgueevtddvudffhfejffejjedvvdduudethefhfefhfeeg
    ieekkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:vsZfYkyiS-Jk36921WvZX6NoF6OXszjZjHM1G31g2wzF2cOVvXw-7A>
    <xmx:vsZfYrQmWBBIwHNNNMLBEVRP2pd-j9kxJbZc4-cfYK2LnGhIhku2MA>
    <xmx:vsZfYvbOJG-9ning0ZsPEZdEP0KJUfjYg4jRW9TvspYEliPeJxJ6LA>
    <xmx:vsZfYkRs21WCQX4WLfzDzBsCztHhZhUz7-UM7KZKbxFqX9EO9Q3Ujw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 Apr 2022 04:39:26 -0400 (EDT)
From:   Maxime Ripard <maxime@cerno.tech>
To:     Stefan Wahren <stefan.wahren@i2se.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     Maxime Ripard <maxime@cerno.tech>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: (subset) [PATCH 2/2] drm/panel/raspberrypi-touchscreen: Initialise the bridge in prepare
Date:   Wed, 20 Apr 2022 10:39:18 +0200
Message-Id: <165044395514.303702.8433526733204616852.b4-ty@cerno.tech>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220415162513.42190-3-stefan.wahren@i2se.com>
References: <20220415162513.42190-1-stefan.wahren@i2se.com> <20220415162513.42190-3-stefan.wahren@i2se.com>
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

On Fri, 15 Apr 2022 18:25:13 +0200, Stefan Wahren wrote:
> From: Dave Stevenson <dave.stevenson@raspberrypi.com>
> 
> The panel has a prepare call which is before video starts, and an
> enable call which is after.
> The Toshiba bridge should be configured before video, so move
> the relevant power and initialisation calls to prepare.
> 
> [...]

Applied to drm/drm-misc (drm-misc-fixes).

Thanks!
Maxime
