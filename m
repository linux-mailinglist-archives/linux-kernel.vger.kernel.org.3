Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E761C5AFF32
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 10:37:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbiIGIg7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 04:36:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbiIGIgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 04:36:52 -0400
Received: from wnew1-smtp.messagingengine.com (wnew1-smtp.messagingengine.com [64.147.123.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB0F145985
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 01:36:24 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailnew.west.internal (Postfix) with ESMTP id 929822B059B1;
        Wed,  7 Sep 2022 04:36:21 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 07 Sep 2022 04:36:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1662539781; x=
        1662546981; bh=BS4b0Z8Irw23ZNAOM5hB7VebotGLXvfqHpdIa+/zG1s=; b=t
        l09WbowuLbT8jm96WAeCUUrd1eNzmZRfBD/iY6jqiRavJ9I6I5+2Bk50UynJ7yvx
        LSLMOjZdw75uM+VCCZ47mh9rnilWpHQEOJM67vNSKwkWH+g6hUYLrAG2tLPUDGTP
        4qMW2zmZLCWZCuxDdWLHw9lvrWp1kiBnNCMU66TkZMD70hZNkfE24MtIluMcr//n
        QUsowhfhe98S2HueaKBX77vrAA3uR3QinDzFMNY9eakBB5UZjV/v8Mtw1U3Mb6lh
        ipaQ6lk07pWjJ3/OqZJkmDNfQXPmw4YkU/j/h1FXWUW3HmOKom5Esq6Z1e92d/71
        YSN5M24/Xg7X8kJCrGpBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1662539781; x=
        1662546981; bh=BS4b0Z8Irw23ZNAOM5hB7VebotGLXvfqHpdIa+/zG1s=; b=f
        LhRUWCEHefT8J3TyGzBLDcZHumNpJ/UZPQii4UyXLPKzHrxarbey9LZQqiiUDZLS
        agbj79N8olOSV8n5cg7+2g+0MbADaWIvk0x0T6/N8ryI2ytp+Bs180cn9O4SLeCt
        WdvKkDPJnKlGUT0btNWxI4p/d1zY2H9KcoecmpL2l+B8/KGWGMgEKDmHWJKTUj62
        1ZdSQTjL7kk176NrF0ryMAMDMgqFAdxDnvx1/OkFsu/nlwibghLmJ0/aAiCopNpC
        AUW1mITsWt51yGf3gItl0Zvi5LWQg9vxf58XLslFPDvmPQ5j+dXfBhijqWwq2Vqa
        tFncSXJMA0rc7LZltu7hw==
X-ME-Sender: <xms:BFgYY7D2WD-fdibki3_WWEN2ONFsVcM7bKzMdrpCRllbojjc_vC0MA>
    <xme:BFgYYxhFuTgdOaDeASLZRel_22jX_LFfdQMDji4WhLCAyrAZoHMiy_rEe9ynMI0GI
    qnNVsrxXDMmWf4USMo>
X-ME-Received: <xmr:BFgYY2lTdhTGEXYWUHQYhPpV-5BSu9xeVMGXPmEA63dcQLUVcVSyd0INPe8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfedttddgtdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpeforgig
    ihhmvgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrf
    grthhtvghrnhepueeigefghfffffeifeehudeiuedvteegueefffevgfetvdffheehkeff
    vedufeeinecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomh
    epmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:BFgYY9xFAT0FmegtLc-mlF4NS9x4Vxu2ru2lo7vIziG9S2lvCByHbw>
    <xmx:BFgYYwQrYoliWMISbxm9Y5iN_fUqyiqfTGg4qxsfQfk4N5wkqzZv7w>
    <xmx:BFgYYwaFCFJh4BFDn-jQG8VpIzpH4gOt4A2OXwFj4RCnmhazdPh05Q>
    <xmx:BVgYY4L7HGVMfy7l2PhL3b-RnxkJiSXHbCQXpOf5dX-sj_VC30az55TVt2g>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 Sep 2022 04:36:20 -0400 (EDT)
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
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
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
Subject: Re: (subset) [PATCH v2 39/41] drm/sun4i: tv: Rename error label
Date:   Wed,  7 Sep 2022 10:35:08 +0200
Message-Id: <166253967462.2236193.10885754438673118272.b4-ty@cerno.tech>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220728-rpi-analog-tv-properties-v2-39-459522d653a7@cerno.tech>
References: <20220728-rpi-analog-tv-properties-v2-0-459522d653a7@cerno.tech> <20220728-rpi-analog-tv-properties-v2-39-459522d653a7@cerno.tech>
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

On Mon, 29 Aug 2022 15:11:53 +0200, Maxime Ripard wrote:
> The other error labels in sun4i_tv_bind() are named after the task they
> perform (err_disable_clk to call clk_disable_unprepare for example).
> 
> However, the err_cleanup_connector is named after the calling site
> (drm_connector_init failing) and will actually cleanup the encoder. Let's
> rename it to err_cleanup_encoder to be consistent.
> 
> [...]

Applied to drm/drm-misc (drm-misc-next).

Thanks!
Maxime
