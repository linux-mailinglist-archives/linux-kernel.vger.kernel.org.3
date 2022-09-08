Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E46835B2007
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 16:03:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232211AbiIHODS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 10:03:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232311AbiIHODL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 10:03:11 -0400
Received: from wnew4-smtp.messagingengine.com (wnew4-smtp.messagingengine.com [64.147.123.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7074CA2A9E
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 07:03:04 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.west.internal (Postfix) with ESMTP id 331AB2B05B92;
        Thu,  8 Sep 2022 10:03:01 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 08 Sep 2022 10:03:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1662645780; x=
        1662652980; bh=ZcIBIDlpdLVKZg4IlXd05S6h4JkWIhQqXXzWfBJ83ow=; b=c
        zNe6gLuyvdjRW551IVFEYSdvQD3T1eshLEO+8vISeoBxTjKAUZaGJdL08oseMrqZ
        Fut6XphRqmkGK1h4QU7mkM6EW6nEBRN/eRh9i/MqyJFJKZ4oq0aEfd3rKhkg/snx
        7lFjef8FWWTagRHm6af1CHCss+2PSst8CB7iPb2m8HnNbecu2BQ4EgjjjVSZTx6W
        Dxga0MidtrFihJM85mmSVwcrI9Rush4dDlAy/Iouc2qHobNbKdWj2voBmEfOyWka
        GGQwayc6261/IF5J7i0pEiv2N0ryPWw/2rgqUlV2pcgIAAktZN3HwNjrAyyJ7ml1
        p04Wsngh4+31AfndU9nSA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1662645780; x=
        1662652980; bh=ZcIBIDlpdLVKZg4IlXd05S6h4JkWIhQqXXzWfBJ83ow=; b=n
        afufB3YRGZd7vArNXwFSQtbB56G4qFj1c2iTf8oXEIZJfq/cpgOEWgDEI2p+EXfl
        0MmREMov9f691O0PEgmDn2QdCY0LcUXjI0veG6f0P84fh/PjdFS3OTYJdDe6uKFm
        ikxXlF689P+AZ32ATwlcdZvGmIgqybmD4OJfmrhg8wREg8k3WyS7epbT7zq+E5Jo
        mWYxQrLdvvDWYibTVAhJTrvUXTUsC2jGvc/1aFrHZG8w+Y3SoYg+c+1VVqHbNxgw
        wY0EyD/EQgciCBrFuGituKnIHN5QfHt786H59uJntnddeH9LMqntUWc3+2fIUDnp
        L0T/cryCIafj8x+1QKqTw==
X-ME-Sender: <xms:E_YZY5vKIBQ3SRZPsaFTs-xNCu4rej7pwqWIobPdZ20jgV8las1G2g>
    <xme:E_YZYyei14DxCSGS2IAfDQugKMVik5VcUneHV-CcrUuimar3TzLS6Xq8-MclN__XH
    VXNLWZiJ50f9Ku_Z9M>
X-ME-Received: <xmr:E_YZY8xs09y0S8XFFwW_yCAdG-1jSOKDZx_cku77g7U-ZMOtMtrWDQiOpw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfedtfedguddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpeforgig
    ihhmvgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrf
    grthhtvghrnhepueeigefghfffffeifeehudeiuedvteegueefffevgfetvdffheehkeff
    vedufeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:E_YZYwMHuHLjTtcD4id5zjudOWWh84hu3GkTVuOPu-ThDVpls32v5Q>
    <xmx:E_YZY59yr3vj3GSjDbehToXaDzaOLHdvPijpyn8hLZT5HDHINbnEGA>
    <xmx:E_YZYwVEKVh_ApDL07RXjXw2dv-oLAeCIMsfsJiNUgiySgC6m7hFFw>
    <xmx:FPYZY5lfjsH1-vUzgP5LB5dOEZNbB11TWY6qNAU_GjLsPJzPD6qV-PBttKk>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Sep 2022 10:02:58 -0400 (EDT)
From:   Maxime Ripard <maxime@cerno.tech>
To:     =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Karol Herbst <kherbst@redhat.com>,
        Samuel Holland <samuel@sholland.org>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Emma Anholt <emma@anholt.net>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Lyude Paul <lyude@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Dom Cobley <dom@raspberrypi.com>, linux-sunxi@lists.linux.dev,
        Hans de Goede <hdegoede@redhat.com>,
        linux-arm-kernel@lists.infradead.org,
        intel-gfx@lists.freedesktop.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        dri-devel@lists.freedesktop.org,
        Phil Elwell <phil@raspberrypi.com>,
        nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Mateusz Kwiatkowski <kfyatek+publicgit@gmail.com>
Subject: Re: (subset) [PATCH v2 36/41] drm/sun4i: tv: Merge mode_set into atomic_enable
Date:   Thu,  8 Sep 2022 16:02:54 +0200
Message-Id: <166264577079.2930603.15990827641277549331.b4-ty@cerno.tech>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220728-rpi-analog-tv-properties-v2-36-459522d653a7@cerno.tech>
References: <20220728-rpi-analog-tv-properties-v2-0-459522d653a7@cerno.tech> <20220728-rpi-analog-tv-properties-v2-36-459522d653a7@cerno.tech>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Aug 2022 15:11:50 +0200, Maxime Ripard wrote:
> Our mode_set implementation can be merged into our atomic_enable
> implementation to simplify things, so let's do this.
> 
> 

Applied to drm/drm-misc (drm-misc-next).

Thanks!
Maxime
