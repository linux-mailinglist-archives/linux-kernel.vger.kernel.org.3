Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F3125AC0D7
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 20:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232356AbiICSkj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 14:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232461AbiICSkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 14:40:32 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7051275DF;
        Sat,  3 Sep 2022 11:40:29 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 168295C00EC;
        Sat,  3 Sep 2022 14:40:27 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sat, 03 Sep 2022 14:40:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maxfierke.com;
         h=cc:cc:content-transfer-encoding:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1662230427; x=1662316827; bh=IqiTG1t+/u
        o+949kVmzHS54OgkIf4SBM3u2xKwWgX0k=; b=eIR7SFqm4EG5TV6Vi7SUm9Y4go
        gf/PLH+BddaaCkqTp3iiUi87wW7Q2/hMWP54nTsPBj4bwlUZJbfkDzgPuMje5Xmu
        yx0G878H/5FfZqJ1t9UTRiRHzqjsiNPhfrnOeqDqVy/rHM/ytbX1OvIOCCps10Il
        NX05AcmC0FqjJ+eKYyPTUQ2AtesSIC9hSunbIA+xROxoMre8md/Xd4WvMOpFytx0
        uMrzlVtnEHydoChEKtD4Bmw52c5nANsQzQShIAyoVjzHuiXXTzMZ9Huz0Fg8S5l8
        BtS3dgsTbtKHBFPdVDJ3PGyWnztuWSnU6C9lv2Le947G2p6QaEGt5B4vLIng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1662230427; x=1662316827; bh=IqiTG1t+/uo+949kVmzHS54OgkIf4SBM3u2
        xKwWgX0k=; b=dZknFVdegFPWrBvFPFYzP5krm/GnYOSDoyIDwphRBFlwkVvtGvR
        sKABzgpcOHKYNjyZGKQtdxfU3mKvzHpM1tg+Pw8nB5lDoAz+WQu/TGc2w5jSpqat
        QJIPTGevF97EyVa+ih1F38LrhLt+hM92F/QFBTv4Z+Icvqxw1FCE0vF+tIkPeAOQ
        0irehDy+xfbni6NR7NzDivhcdCZ5OYTgOPkJPCfJzzwOshwmQBJYcxB3uSJ+QA6A
        odTZgfzSkIAWck/a9YEQV2xuE6QC6rxCD5rigU9nVQC4M3DZDpTLOP/mogF87SSQ
        4y0ymVU1m+wOlGsK8aaVJRq2xOe/bDdka2w==
X-ME-Sender: <xms:mp8TY7cihske003pFzWZoHd2sbANtTWIfzUc85N10Llewflqq0xMkA>
    <xme:mp8TYxNO90tIFbgluK9auOQcmdtpOahyOIAon5ZEkKw6wjzZsV_N6kVnMeq2Yr3Ns
    l97YFAFhAZuTp4cssA>
X-ME-Received: <xmr:mp8TY0ioVfP3ylMZueRaxOaVWQ8ypAUeuSvLUGY7ZS8J-FHwGwsQML5w_PLYXMAZcdsXO77KRBex0B8OTIEb9rTtjXerGqwP4ivMQtcs1NCMUs-ceg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdelvddgudefudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgggfestdekre
    dtredttdenucfhrhhomhepofgrgicuhfhivghrkhgvuceomhgrgiesmhgrgihfihgvrhhk
    vgdrtghomheqnecuggftrfgrthhtvghrnhepvddtffffgedvjeehhedugeekfefggffggf
    eguddtieehudehhefhfeegkefgkedtnecuffhomhgrihhnpehgihhthhhusgdrtghomhen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigse
    hmrgigfhhivghrkhgvrdgtohhm
X-ME-Proxy: <xmx:mp8TY8_C7GfSwRpaaAU6hCjNXPB5Ff_CW6AUpGuENSKj9JQrMuwZdQ>
    <xmx:mp8TY3uw7Etx-EwiydFy6-tm3l8UMVCotKuv1zPwjua1MO8Mz4hwow>
    <xmx:mp8TY7FCoNZTzERvxg_W9JaiqvkyiIsQL7HZstyo_g1Nb5ytoK-lRg>
    <xmx:m58TYwH8sYUl_xHTEQotUdjkRSRE9Cgq1hbK0f4_zPJNg3dUcbiahw>
Feedback-ID: idee9475d:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 3 Sep 2022 14:40:25 -0400 (EDT)
From:   Max Fierke <max@maxfierke.com>
To:     thierry.reding@gmail.com, sam@ravnborg.org, airlied@linux.ie,
        daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Max Fierke <max@maxfierke.com>
Subject: [PATCH v2 0/4] Introduce ClockworkPi CWD686 DRM panel driver
Date:   Sat,  3 Sep 2022 13:37:49 -0500
Message-Id: <20220903183753.25736-1-max@maxfierke.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ClockworkPi DevTerm (all models) uses a 6.86" IPS display
of unknown provenance, which uses the Chipone ICNL9707 IC driver[1].

The display panel I have has two model numbers: TXW686001 and WTL068601G,
but cannot find any manufacturer associated with either, so opting for the
ClockworkPi model number.

This driver is based on the GPL-licensed driver released by ClockworkPi[1],
authored by Pinfan Zhu, with some additional cleanup, rotation support,
and display sleep re-enabling done by me.

[1] https://github.com/clockworkpi/DevTerm/blob/main/Schematics/ICNL9707_Datasheet.pdf
[2] https://github.com/clockworkpi/DevTerm/blob/main/Code/patch/armbian_build_a06/patch/kernel-004-panel.patch

Thanks to Krzysztof Kozlowski, Rob Herring, and Sam Ravnborg for their
prior reviews and apologies for the long delay between patch set versions.

Changes in v2:
 - dt-bindings: remove redundant backlight example
 - add missing regulators
 - remove some unused properties from definition (e.g. enable_gpio, supply)
 - reorder includes
 - remove redundant ctx->backlight in favor of backlight through drm_panel_of_backlight
 - remove now-unneeded ctx->enabled and enable/disable hooks
 - replace ICNL9707_DCS macro with mipi_dsi_dcs_write_seq
 - use dev_err_probe instead of checking EPROBE_DEFER
 - fixed return type of cwd686_remove to be void following changes to mipi_dsi_driver
 - add .get_orientation callback

Max Fierke (4):
  dt-bindings: vendor-prefixes: Add prefix for ClockworkPi
  dt-bindings: display: Add ClockworkPi CWD686 panel
  drm: panel: Add driver for ClockworkPi cwd686 panel
  drm/panel: clockworkpi-cwd686: Implement .get_orientation callback

 .../display/panel/clockworkpi,cwd686.yaml     |  63 +++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 drivers/gpu/drm/panel/Kconfig                 |  12 +
 drivers/gpu/drm/panel/Makefile                |   1 +
 .../gpu/drm/panel/panel-clockworkpi-cwd686.c  | 456 ++++++++++++++++++
 5 files changed, 534 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/clockworkpi,cwd686.yaml
 create mode 100644 drivers/gpu/drm/panel/panel-clockworkpi-cwd686.c

-- 
2.37.1
