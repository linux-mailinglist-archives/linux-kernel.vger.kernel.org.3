Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A90F75862F3
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 05:05:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239554AbiHADFc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 23:05:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238263AbiHADFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 23:05:21 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F2FF2186;
        Sun, 31 Jul 2022 20:05:18 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id D311A32003F4;
        Sun, 31 Jul 2022 23:05:13 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Sun, 31 Jul 2022 23:05:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm1; t=1659323112; x=1659409512; bh=XxoCxtmkFBHeeLZilKhCk3IDS
        CHUhmklYh5m1bb0aro=; b=AQp+l24pufoeCGNMU1bnLc4loOJ5rWuoBQ2KGq9w8
        wHnA2EuyBsSzKQ+66LkZHPpryhPkL05tEPkBGRV7dmqXb4wCy1BABD7WskoiYzcR
        275TkWENPgTKiO2ymIM3IwuSkq9TiDwKIZqv55rVbqWUULA7P2oQcymxEFR+Xy4y
        Fqpw3BogfFI1fsRQXaZ6cBoU2Bf7uDg/oitwPZbuxdMoV32FR9lY6j6ifMR4Usor
        t8hriG0nNvMOlV2hXsn6zVKbwAPTQULWhJyWTCr6E11pyd5FpMPwTLYHnJOlMDOG
        vBhix9n0uokjbifYsCU9Zw0/p77C/LUrpZ3xIHJ5crd7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1659323112; x=1659409512; bh=XxoCxtmkFBHeeLZilKhCk3IDSCHUhmklYh5
        m1bb0aro=; b=WJK0YjhS57JbI6ZBbL2SquueeUnttMHSuAl0+YbX5FteKA+4SFR
        G2++qPRQIZc3mb3Pwr0QpKfo2UHtUG5JvV3DMecaRBNiHEMhG/D56Xbyl9Tw/bB5
        QiioJ0fc/odJppf0sf1uaq84541BZ7Vlg8djrhYqGMULEzv44bse7IdjD1Nm1oBV
        CzpqURPTsNehQUwZuFULNYa2mGma7i0HjSYE3w0hCBp81yKIzDTaAUhuidUcW9YZ
        XlNcCaGn44sQ/JGc9Y9To+rw/vTdlAp6HpE5DREYLA4gkBaQ41qkVOCYJSRZzm24
        DHM7R6mO6T9+I4acs9H+Qikr/zH8iqyKNRw==
X-ME-Sender: <xms:50LnYiKkNQOiGpe1gHlUQ_2Ik9YUgyCnsCl44ABboGFBA69HUJiGmw>
    <xme:50LnYqKKm6I3bW73InYsL6YDXLXiOC2Bju05OrFBHHZk2GvYioRAJYNjeoYtCAb48
    efvbMbq0Hx-RDJJAg>
X-ME-Received: <xmr:50LnYivrfzvi47NG7EzXk_41bTAqasb0emn89svxNthZ99Dc1W4JDMjD3_0-rocqDPrAhUeKYY4iIjWCCvbYLthRD5k-eCBfEiP7t2WOoXq9yhUUR7pYZLvi_fcEU_rZ58K3kg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvddvvddgheejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecuggftrf
    grthhtvghrnhepkeevlefhjeeuleeltedvjedvfeefteegleehueejffehgffffeekhefh
    hfekkeegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:50LnYnYvR53d_HiOb2KT0tJ8NgUC3cG77jlii7Y1iWrNvmj1t0BE9Q>
    <xmx:50LnYpb9_jy-s6DBv1W7UjF04oaJ4dEW9vS5VFFcyjsBFjE1r78M2w>
    <xmx:50LnYjBZlWs3uERH0B5CkfIBRP9f7iEfIqE96uAj0R2cG78kIcVVRQ>
    <xmx:6ELnYvAX9CPME5n9RB1LHjT4R1CUa9jUtdG0HI8VNJWiPSQvQY-8HA>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 31 Jul 2022 23:05:10 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     Samuel Holland <samuel@sholland.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Hans de Goede <hdegoede@redhat.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev
Subject: [PATCH 0/9] soc: sunxi: sram: Fixes and D1 support
Date:   Sun, 31 Jul 2022 22:05:00 -0500
Message-Id: <20220801030509.21966-1-samuel@sholland.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series cleans up a few issues in the system controller driver, and
then expands the exported regmap to support one of the pairs of LDOs
built in to the D1 SoC.

Eventually, we will need to update the SRAM region claiming API so
ownership can be swapped back and forth by consumer drivers. This is
necessary for uploading firmware to the R329/D1 DSPs, but it is not
needed for initial bringup.


Samuel Holland (9):
  dt-bindings: sram: sunxi-sram: Add D1 compatible string
  soc: sunxi: sram: Actually claim SRAM regions
  soc: sunxi: sram: Prevent the driver from being unbound
  soc: sunxi: sram: Fix probe function ordering issues
  soc: sunxi: sram: Fix debugfs info for A64 SRAM C
  soc: sunxi: sram: Return void from the release function
  soc: sunxi: sram: Save a pointer to the OF match data
  soc: sunxi: sram: Export the LDO control register
  soc: sunxi: sram: Add support for the D1 system control

 .../allwinner,sun4i-a10-system-control.yaml   |  1 +
 drivers/soc/sunxi/sunxi_sram.c                | 74 ++++++++++---------
 include/linux/soc/sunxi/sunxi_sram.h          |  2 +-
 3 files changed, 42 insertions(+), 35 deletions(-)

-- 
2.35.1

