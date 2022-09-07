Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA4385AFF37
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 10:37:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbiIGIhK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 04:37:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbiIGIhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 04:37:05 -0400
Received: from wnew1-smtp.messagingengine.com (wnew1-smtp.messagingengine.com [64.147.123.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9C5CAE86D
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 01:36:35 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailnew.west.internal (Postfix) with ESMTP id 6E4912B059B3;
        Wed,  7 Sep 2022 04:36:28 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 07 Sep 2022 04:36:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1662539787; x=
        1662546987; bh=po9Xm858L0cddUdWZdiBQdG3q0GGzu520DX8oi90AHk=; b=t
        nTK9Vm0HxO6Dz2vyUXzwimDbDYlwCmlQyjZ7GgmLgpSPym19UNCgba9j/hZgbPDz
        plhRvnZE4tkFDfA6QEu6H1SZUmHSmkaJf7AMF6I6ULSerLZJKaNGn1JXx+5ve9xA
        lfOSLypV51NKc+drg+SY7e97CeM7MVg45FovCocuWRudrN+ynqGtiYIixTIT4sUW
        LO2RJy8hNgXQCKO88w93cvEqVMlTHgy/jmPVvbr91vOfhCzesjnMPGP8HkZZUvy6
        BldlOyGN/fmSRsPmNbG7bPzZPaIjP5yj5G7vQ6a587hK4mvNc6meprt8abnJP83g
        ZwmgfCcRFk7OhyTLTw76Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1662539787; x=
        1662546987; bh=po9Xm858L0cddUdWZdiBQdG3q0GGzu520DX8oi90AHk=; b=A
        p4Fx1/TRiqWHa2y+oaJMxELoiun10IIXj8MIAzE6xrPWAvQGG9d1qXZlRbJckUVI
        Afn2O/7fWg1JIShzwNabM1Zqtgqwkas36Abyp2CI9omix1KWyotBFbLeklVmTpvc
        3NJFOSZcdGRpwwVOPEqwssZELovxLmPJSavIm6iZzqyem8pT8yAyPLn7sLEjXhZv
        E8n9cb3wsXE+OGIfVDJV2ZT8OY3jnqFXP+zXxB027LDU3vO3oUzefyq3Quwji6DD
        doWWRBw+Add2E8xo0L1F7kImsTlOFCSR1AXxta8JD7VY7hHUHO3JBrxRUmiidXGU
        rfVL3Hu5Tdx+gUaxx321A==
X-ME-Sender: <xms:C1gYYylGD6PWkNVmDgOax7oZftfh_BO6Gf7nxG5yoqLDm2MD0IjtLA>
    <xme:C1gYY53RS6pV--bsb_FfxREhb_VFJ7q04WWXl2UfcddOlFmKt462GNtq31Nk0ebdi
    OVu7JQZ4ZnYitCXX8Q>
X-ME-Received: <xmr:C1gYYwqmt_rIHWH1uPAalaANaiwhDkntB5WnmdwLlVO5IaXC2N4JGtMwVOc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfedttddgtdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpeforgig
    ihhmvgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrf
    grthhtvghrnhepueeigefghfffffeifeehudeiuedvteegueefffevgfetvdffheehkeff
    vedufeeinecuvehluhhsthgvrhfuihiivgepfeenucfrrghrrghmpehmrghilhhfrhhomh
    epmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:C1gYY2kaesFMDJteUnwOJadqi1nctjmr8fclh3Ryv7ySqWHqbuSAWQ>
    <xmx:C1gYYw1Zx7eHWPn0Y4zhHvMgszuf8E1s_xe6MwkEuUZ6W3d-f-vPlQ>
    <xmx:C1gYY9s0xTinewcUWfzthCh9e2S1kauqPhnlbLw5f3xuY6ZGzaMHyg>
    <xmx:C1gYY1_eV0VIiPvx_YzD44rNwJKuP3WfNv7tT5koXSbBBFao9odE-Tpb84U>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 Sep 2022 04:36:26 -0400 (EDT)
From:   Maxime Ripard <maxime@cerno.tech>
To:     David Airlie <airlied@linux.ie>,
        Samuel Holland <samuel@sholland.org>,
        Daniel Vetter <daniel@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <mripard@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Emma Anholt <emma@anholt.net>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Lyude Paul <lyude@redhat.com>,
        Karol Herbst <kherbst@redhat.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
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
Subject: Re: (subset) [PATCH v2 40/41] drm/sun4i: tv: Add missing reset assertion
Date:   Wed,  7 Sep 2022 10:35:09 +0200
Message-Id: <166253967462.2236193.8270005092779709066.b4-ty@cerno.tech>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220728-rpi-analog-tv-properties-v2-40-459522d653a7@cerno.tech>
References: <20220728-rpi-analog-tv-properties-v2-0-459522d653a7@cerno.tech> <20220728-rpi-analog-tv-properties-v2-40-459522d653a7@cerno.tech>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NO_DNS_FOR_FROM,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Aug 2022 15:11:54 +0200, Maxime Ripard wrote:
> The reset line is deasserted at bind, and asserted if we ever encounter an
> error there. However, it's never asserted in unbind which will lead to a
> resource unbalance.
> 
> 

Applied to drm/drm-misc (drm-misc-next).

Thanks!
Maxime
