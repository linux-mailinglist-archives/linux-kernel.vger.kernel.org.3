Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2334A5AFF12
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 10:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbiIGIf3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 04:35:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbiIGIf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 04:35:26 -0400
Received: from wnew1-smtp.messagingengine.com (wnew1-smtp.messagingengine.com [64.147.123.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A77AA2E9F0
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 01:35:19 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.west.internal (Postfix) with ESMTP id 5074F2B058ED;
        Wed,  7 Sep 2022 04:35:16 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 07 Sep 2022 04:35:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1662539715; x=
        1662546915; bh=igr6qV0Eap7xUGhc2oop9vyUXnwE0FGWJSHkINHCAhI=; b=q
        /5Cpz5wmf1mwzJktQrLqiRJNbE7FRpX5OQ9rnZKjEoNjOTcODD6+ZhKiu8tQOzZB
        rSQlX15NnPEovbWp8NMQKTuvlQT3Sop7RIqzbvKRIFPVZfGmTGG9SpBfUuljPzDs
        EXwg+xlIN3mwm5YMDk7cdUphSv3OYYUFLjh272Zd6JrXUNHUAp7MX8gOs0Rxlf1J
        DPff3VAZmv6ipflX74mSUzdKbDZle4Q1m1LXku19YZwumEcHT1pgorDdsDhRdWl7
        Q+wKdOGX/HfGRo5O+2tnBOADgjfTZ0Oc8HHEhkU7VSpmSZ9qtYaZGk1rBAyLVIZb
        wnSA/DtNHyImh+pgetFKg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1662539715; x=
        1662546915; bh=igr6qV0Eap7xUGhc2oop9vyUXnwE0FGWJSHkINHCAhI=; b=g
        5nMgFf4L+SbZW5HRS12/t7VBHgbkL/z+rbOvxjR/VCekvNEF73oked/eSz7PMgov
        f+Pi2IpkNA9cgYKx7RN7Ns0p/L0GhxDZtmT7bk66JSYXUP7BdjTSSlC6HNA8mlWY
        MOcQ+I/+JYOEmcaqiakd4+tGo/9M3R/Dpv7Qop9bJzD4nYcdwIrvIJHOhXPPZCd/
        gGU2xS6hYhOOWmObEBzZL+89OFSHQ8QpaW1FkKsEpIXx4aPkbtn1FCNIH0bSa12s
        aIQ04+40fq8yS+VXPenRq5RgSczs4SkVBb8Y7tZgf1VjmtG8ARCgRGQe2ZXeBuPN
        6Hx6kFAxRHAXJXBPX3D5Q==
X-ME-Sender: <xms:wlcYYyA5D20iK0dkKl3xZV0Zr0xtX9Cl-s4qTNz0mNEPiZ-Szt_lVw>
    <xme:wlcYY8guRM42Vsz4FMirJ5nd3gTsWFtW8PZAJAcnEA6eSm0Q56zggl7-qtZXTO-7P
    gH5ODvk8DRGDCjMRFg>
X-ME-Received: <xmr:wlcYY1nzz5wnA5jZVnNGqyZJHxlGX7l18PgNy3b6J3zMZUWWsOHKWbonAPA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfedttddgtdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpeforgig
    ihhmvgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrf
    grthhtvghrnhepueeigefghfffffeifeehudeiuedvteegueefffevgfetvdffheehkeff
    vedufeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:wlcYYwz_G2L-cl3Ll3DtPNYWBQ7-RrX9uURvSRH_BQlJTN7iSsT9Zg>
    <xmx:wlcYY3QkZLAgjj7B9kCtDPo0QY2REcE_Db0Xp8IzisSWmScHi7ro4w>
    <xmx:wlcYY7ZZOsebrukJK5WuKsVzXZvvJHznw38uGNDBnEQrHiWiagEQmA>
    <xmx:w1cYY7LvDbHLfmef9qCFQIGfOnFAsRRpVRNR4HQ1DbDGwqvJOEUo30-zx8c>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 Sep 2022 04:35:13 -0400 (EDT)
From:   Maxime Ripard <maxime@cerno.tech>
To:     David Airlie <airlied@linux.ie>,
        Samuel Holland <samuel@sholland.org>,
        Daniel Vetter <daniel@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <mripard@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Emma Anholt <emma@anholt.net>,
        =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Lyude Paul <lyude@redhat.com>,
        Karol Herbst <kherbst@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maxime Ripard <maxime@cerno.tech>
Cc:     Dom Cobley <dom@raspberrypi.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Hans de Goede <hdegoede@redhat.com>,
        intel-gfx@lists.freedesktop.org,
        Phil Elwell <phil@raspberrypi.com>,
        linux-sunxi@lists.linux.dev, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Mateusz Kwiatkowski <kfyatek+publicgit@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        nouveau@lists.freedesktop.org
Subject: Re: (subset) [PATCH v2 24/41] drm/vc4: vec: Remove empty mode_fixup
Date:   Wed,  7 Sep 2022 10:34:59 +0200
Message-Id: <166253967461.2236193.9388419483041463666.b4-ty@cerno.tech>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220728-rpi-analog-tv-properties-v2-24-459522d653a7@cerno.tech>
References: <20220728-rpi-analog-tv-properties-v2-0-459522d653a7@cerno.tech> <20220728-rpi-analog-tv-properties-v2-24-459522d653a7@cerno.tech>
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

On Mon, 29 Aug 2022 15:11:38 +0200, Maxime Ripard wrote:
> The mode_fixup hooks are deprecated, and the behaviour we implement is the
> default one anyway. Let's remove it.
> 
> 

Applied to drm/drm-misc (drm-misc-next).

Thanks!
Maxime
