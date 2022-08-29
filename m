Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B4625A4D44
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 15:14:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbiH2NOU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 09:14:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbiH2NNz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 09:13:55 -0400
Received: from wnew2-smtp.messagingengine.com (wnew2-smtp.messagingengine.com [64.147.123.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28EB8D3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 06:13:27 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 1BDC52B06056;
        Mon, 29 Aug 2022 09:13:22 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 29 Aug 2022 09:13:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1661778801; x=
        1661786001; bh=03XFcTJGiCv9x9hOMYU/IHnyg9+FpgYuQ7Ewjsv6kOA=; b=X
        c7Z5RIAZDbcktvpiPovFQfv/Y+JZDt9Or7HaQL73yJS0K4Gs5Og1xFOgCL66llUO
        AN19C9qauHvTD9elrKkpu6uU27pT+S7+BMmY8zxNEi9Z4eRSvJ7IfXJf95w5SW7B
        CVhJfNFpKTe0B6nHT1lD8RablUVX4mVkdNpB/yG7wuX3iIEeq+74faTTJ4WdJ3K9
        NRLwKnNCuIKPGysxdxJ+RfElAn8MeE63zZMUEu8Dgp4cfXpFLDlfwG2InlkmiXHe
        Pj4SOefke/2JUw+3akKRVKmqoLNKzBteC5Vp28rCeeqSGIR387lbhtUqOkRI/FbZ
        6c5vslviwQEL6X+3/9c4A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1661778801; x=
        1661786001; bh=03XFcTJGiCv9x9hOMYU/IHnyg9+FpgYuQ7Ewjsv6kOA=; b=M
        bBgXynKSTeXOi2Bq2ciTxgZr49tswVd1B67bm33Oe+jsfieBOiGE/jghr/rQau7Q
        jfXnxj108C5/GztijwkGIyt8hYMdZOZhuqYiR5jEICLEN8FsUQiTaB/PMqTwlsDr
        m5xOhYIudZVeAWMzFDlrUNp6lw61f5HB3bp+MZ4MpyQvCPeOTH6KhjCsPzsPIAHA
        7hYNarsPIwcQLMivE+KQpBeAYDF2Ua8cyOUn61E4gzrMp+7N5RLnQQJYVTXwrao+
        jjvXGcY8QVG2ldnvaGx+pHaZO87UEnqo2O94itRw0ttGLi50emoVMQf1M7M7OY11
        ktMxMF29aSYCZnc3i2XFA==
X-ME-Sender: <xms:cbsMY8tav_vASJiMG0a2RhfTqnc7eeJpEA6EP54Nxfg16ToXDWUeYw>
    <xme:cbsMY5cmJiEu7fGKm5d0NqTroPL88gBI0_yOTjFngweFcTHha5oPOt94SKZZKpR3W
    g_Dz_JaeCTbaFUX2js>
X-ME-Received: <xmr:cbsMY3xwfuAvQSXQg_21rauIF77B9eb82JyO5UfAq1WUCZxaqUIO4ejqq0xe>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdekuddgieefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhggtgfogfesthhqredtredtjeenucfhrhhomhepofgr
    gihimhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtf
    frrghtthgvrhhnpeefiedvfefggffgffehveejieffuddtgffhjefggeetieduvdeileet
    lefgveegtdenucevlhhushhtvghrufhiiigvpeefnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:cbsMY_O4GK52eoYHZLbnT_bsjaR_1tqBlWxuweDMPgT-llLT-kzRQA>
    <xmx:cbsMY8_V-MyRTXacBNfAqqtogDrDjuQvoyszW9D5f82Hy1jm6X77_w>
    <xmx:cbsMY3WfxfMHIFrbiI9fsvzLT9Dq2kCY388aZa7ABKLT0UDFxMlRSA>
    <xmx:cbsMY4l49b_7-wit-_-sp9TEtcMDm4VflLXP5Bh8BlvMe4wfea4AF6SkrvY>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Aug 2022 09:13:20 -0400 (EDT)
From:   Maxime Ripard <maxime@cerno.tech>
To:     Maxime Ripard <mripard@kernel.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>, Chen-Yu Tsai <wens@csie.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Lyude Paul <lyude@redhat.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Karol Herbst <kherbst@redhat.com>,
        =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Emma Anholt <emma@anholt.net>, Daniel Vetter <daniel@ffwll.ch>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc:     Maxime Ripard <maxime@cerno.tech>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-arm-kernel@lists.infradead.org,
        Phil Elwell <phil@raspberrypi.com>,
        intel-gfx@lists.freedesktop.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        dri-devel@lists.freedesktop.org, Dom Cobley <dom@raspberrypi.com>,
        linux-kernel@vger.kernel.org, nouveau@lists.freedesktop.org,
        linux-sunxi@lists.linux.dev,
        Mateusz Kwiatkowski <kfyatek+publicgit@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH v2 12/41] drm/modes: parse_cmdline: Add support for named modes containing dashes
Date:   Mon, 29 Aug 2022 15:11:26 +0200
Message-Id: <20220728-rpi-analog-tv-properties-v2-12-459522d653a7@cerno.tech>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220728-rpi-analog-tv-properties-v2-0-459522d653a7@cerno.tech>
References: <20220728-rpi-analog-tv-properties-v2-0-459522d653a7@cerno.tech>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.10.0-dev-65ba7
X-Developer-Signature: v=1; a=openpgp-sha256; l=1069; i=maxime@cerno.tech; h=from:subject:message-id; bh=Ce+TyjEkD5ms8VGGkYRw7EWiyTTKy0ScuMQtAi1SOoM=; b=owGbwMvMwCX2+D1vfrpE4FHG02pJDMk8u+STGJ7KXdfiCpu8Ly6soUhh28WTTV9uP/32bVpCR9ya VT6nO0pZGMS4GGTFFFlihM2XxJ2a9bqTjW8ezBxWJpAhDFycAjARk2eMDDOtWWM3xD1IOvu6Yy7n9E XnpnI6a4mdEj0moHq09aWj+0lGhmbh6am2ujO65oV/3/+qPFxaidez/2Xpil3L5COOa6z4yg4A
X-Developer-Key: i=maxime@cerno.tech; a=openpgp; fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Geert Uytterhoeven <geert@linux-m68k.org>=0D
=0D
It is fairly common for named video modes to contain dashes (e.g.=0D
"tt-mid" on Atari, "dblntsc-ff" on Amiga).  Currently such mode names=0D
are not recognized, as the dash is considered to be a separator between=0D
mode name and bpp.=0D
=0D
Fix this by skipping any dashes that are not followed immediately by a=0D
digit when looking for the separator.=0D
=0D
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>=0D
Reviewed-by: Hans de Goede <hdegoede@redhat.com>=0D
Signed-off-by: Maxime Ripard <maxime@cerno.tech>=0D
=0D
diff --git a/drivers/gpu/drm/drm_modes.c b/drivers/gpu/drm/drm_modes.c=0D
index b4e1ff56b4d8..99a21e5cd00d 100644=0D
--- a/drivers/gpu/drm/drm_modes.c=0D
+++ b/drivers/gpu/drm/drm_modes.c=0D
@@ -2263,6 +2263,8 @@ bool drm_mode_parse_command_line_for_connector(const =
char *mode_option,=0D
 =0D
 	/* Try to locate the bpp and refresh specifiers, if any */=0D
 	bpp_ptr =3D strnchr(name, options_off, '-');=0D
+	while (bpp_ptr && !isdigit(bpp_ptr[1]))=0D
+		bpp_ptr =3D strnchr(bpp_ptr + 1, options_off, '-');=0D
 	if (bpp_ptr)=0D
 		bpp_off =3D bpp_ptr - name;=0D
 =0D
=0D
-- =0D
b4 0.10.0-dev-65ba7=0D
