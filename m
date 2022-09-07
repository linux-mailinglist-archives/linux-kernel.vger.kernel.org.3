Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A02A25AFF1E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 10:36:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbiIGIgS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 04:36:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbiIGIgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 04:36:04 -0400
Received: from wnew1-smtp.messagingengine.com (wnew1-smtp.messagingengine.com [64.147.123.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A4CA86FF4
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 01:35:48 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailnew.west.internal (Postfix) with ESMTP id 8110E2B059B2;
        Wed,  7 Sep 2022 04:35:45 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 07 Sep 2022 04:35:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1662539745; x=
        1662546945; bh=D8IwJpe38ngTqDpXuDooltjCXbTXB1hM4K9sb2AeGwI=; b=s
        hmePre9qZwgHk65Qo/1YPE0ZRfsIfYLkuPp+a29DhFrSCnvxtMjDSfI4wQ4MDnHf
        pYegekdiKhkBVaYgYAkugAm/dHD+6ILdjuYAEqrICW9ieorLGmSL2cQiZNutdlOH
        AivbdsDRUGVmcYZRy//2WMGEc3G8H0JsD7Mx9JcofYqhy1+Isb9BPLeFRL9Abhgx
        /AJTfYBGHUNWiOZBFc8VgMyFvty6M2gfw3GSHhvV53NaD/Vfh4bXlkdU88HSosDm
        1UUULEKgs9RQ0QyCkdZMPUgTZ5dH2anQuPCiBwi8/wfdvCna+nrKNcolw+P8iBUI
        J5v4GKL2W+gV7to9zqMjA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1662539745; x=
        1662546945; bh=D8IwJpe38ngTqDpXuDooltjCXbTXB1hM4K9sb2AeGwI=; b=1
        9fgOsnl6ENiHJFqVxQUzrERFje57iD1iOaroHrGbEKArhcZV6BhOTKasWM/a/uHY
        KQ4xaP0rZyIhndWbOHzt1S2BEaaWyghs99dnYNUkWJ6W2sjTZPBoRTC3AK6ExWL2
        hrEcYh0yLWGoXja2uXqSIkRzYwbJTnbU40+QrIxW8gmayQ4HMbbVhmLtdeE72WTb
        3m5MCAE6kPQy8Al8k9kE4OyUCPCoI+7LTkv+AfkN74gU9PmSkERkUv2Qs5zsXvgI
        t9VlVV+JW3EC93LFiw+GotIOtjTQ/CGPqfz6++K0C3odlB1wvs5Q3LXvaI/Q1ncA
        XBBMkoAQzKmzXoFJUqAVw==
X-ME-Sender: <xms:4FcYYygBRsOruA9xZ7Tg7mJll8X8p4qNIeBm5nNNOCZKCs_Xmbn4yQ>
    <xme:4FcYYzCKrhJQElRzUSNRm5pWS8fzibxC3ClBg2cM6V410pcDZbazoI6QBmvU84YxC
    ybdi0Xj9QYykkWjEAc>
X-ME-Received: <xmr:4FcYY6FOGMAeM8t29VfOxMADej9kubTAqK5L7FV9rE8EEf7LkeY3HoycXHo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfedttddgtdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpeforgig
    ihhmvgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrf
    grthhtvghrnhepueeigefghfffffeifeehudeiuedvteegueefffevgfetvdffheehkeff
    vedufeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:4FcYY7SMTQD8VcYGbenm7TLDZduyOevqKP2XuRVaRqrW9aHlfxuf-Q>
    <xmx:4FcYY_xkotdxKyaRm1FFfVlvybHa4X5CtQTanffxf-v73KPX7-4vgA>
    <xmx:4FcYY54DFtgJoMuTZhLnkZPz9gH8cL0k5GjZ4pasgOUWbwq2xaYC3A>
    <xmx:4VcYY9rjtATBRWJ_MTcJ7_FUZoKCPFMiiiKNXh5mkH8xj6fswXLTSwALACM>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 Sep 2022 04:35:43 -0400 (EDT)
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
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Dom Cobley <dom@raspberrypi.com>,
        intel-gfx@lists.freedesktop.org,
        Phil Elwell <phil@raspberrypi.com>,
        linux-sunxi@lists.linux.dev, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Mateusz Kwiatkowski <kfyatek+publicgit@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        nouveau@lists.freedesktop.org
Subject: Re: (subset) [PATCH v2 28/41] drm/vc4: vec: Fix timings for VEC modes
Date:   Wed,  7 Sep 2022 10:35:03 +0200
Message-Id: <166253967461.2236193.6013044039038178739.b4-ty@cerno.tech>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220728-rpi-analog-tv-properties-v2-28-459522d653a7@cerno.tech>
References: <20220728-rpi-analog-tv-properties-v2-0-459522d653a7@cerno.tech> <20220728-rpi-analog-tv-properties-v2-28-459522d653a7@cerno.tech>
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

On Mon, 29 Aug 2022 15:11:42 +0200, Maxime Ripard wrote:
> From: Mateusz Kwiatkowski <kfyatek+publicgit@gmail.com>
> 
> This commit fixes vertical timings of the VEC (composite output) modes
> to accurately represent the 525-line ("NTSC") and 625-line ("PAL") ITU-R
> standards.
> 
> Previous timings were actually defined as 502 and 601 lines, resulting
> in non-standard 62.69 Hz and 52 Hz signals being generated,
> respectively.
> 
> [...]

Applied to drm/drm-misc (drm-misc-next).

Thanks!
Maxime
