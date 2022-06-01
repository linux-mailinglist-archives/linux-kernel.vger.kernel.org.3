Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DB18539C93
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 07:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349571AbiFAFSY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 01:18:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234492AbiFAFSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 01:18:21 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 990126CAB0;
        Tue, 31 May 2022 22:18:20 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 282175C0278;
        Wed,  1 Jun 2022 01:18:18 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 01 Jun 2022 01:18:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maxfierke.com;
         h=cc:cc:content-transfer-encoding:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1654060698; x=1654147098; bh=x7Bv3nxmlu
        u9ym4u+VJToMmOYHpwt1RgkySeJ5pY4X0=; b=NyrBY6aNyHHEvgDamyn6O4dfCn
        q0w6drK5iTehWoI3RJSAT/Vx/Tivw5ceWUZ2HnDO4gL48suCbb9yCeTeIAqz7DG7
        tueFuyb8/9R/CxHIZB8oLxzmeCGkzbad2CrkUmp55aN2mt9dRqrdQgOuONX2rc9y
        HJYScCsrSnTYjfbs1fnMza597sQlROOEKn7JvZoBypxki72AbWoNRqjktdjtx63z
        57mEOJ35qIM8sDG3N/43MhelmfrLhm/o7jczWxqecLvl068ROo6NLZVK1rHxtg5g
        gImWSvpsDxKZ5Cbd9XWr+23m8ZmvmdpSXBuUGHJ8ugH3HN11ByTXwREwKp3Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1654060698; x=1654147098; bh=x7Bv3nxmluu9ym4u+VJToMmOYHpwt1RgkyS
        eJ5pY4X0=; b=cNVnOWIVK7w7qXsuSJV6bvG4o/hLzH2YBkaLjOPt1oDcXbBpFTr
        V4eGg8XXr64FfT5FNmY3WUws6T1z79hDDfqbzG05dj6F8HMtP5/1/NfM/4O3ZXMj
        quU7df+lz0nbigKimrwthW/3bSjaUTwUIESaWPG+78OLXuW5QfnA8Svhk9K8eCi5
        lXlLuGMMXSqjXwu9WkNXCU6MM+tnO4pmElT7Nbc1meMGqOHDsTNsZx75eJrfxYyz
        FLjsAzYuFBk+f4Q+49prjdDM4FKv5CBQnWwMziRRcfJtpn8dDl5XS+NAjzQ+GR7d
        t+0bF/LnjqY55EUxggzFpV72bN02EOZyyFw==
X-ME-Sender: <xms:mfaWYrfoF_qYw0KBoAOR2KOjjlAnrsSD5Zw8wMjriq_vxQ9baOTrTw>
    <xme:mfaWYhOc7HlrUKvLp8BpambgKFsY3XUT-s2FHmt0ragx-nAuKyzCcgaSilSaPId0o
    sG0Usxrt33pbUK1Xpc>
X-ME-Received: <xmr:mfaWYkje29Dx7ThTkReg1oCXzNoA5RY_A9wgi6CHt4dYiX9SMQwpwNjs-3cwOjXBH5icUP06FTaQDubojpJwFgaPi66zSwNTSzSB5MHg0k19U0NY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrkeelgdeludcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgggfestdekredtre
    dttdenucfhrhhomhepofgrgicuhfhivghrkhgvuceomhgrgiesmhgrgihfihgvrhhkvgdr
    tghomheqnecuggftrfgrthhtvghrnhepvddtffffgedvjeehhedugeekfefggffggfegud
    dtieehudehhefhfeegkefgkedtnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigsehmrg
    igfhhivghrkhgvrdgtohhm
X-ME-Proxy: <xmx:mfaWYs_AlRYAwlznRkQsZWPPedRZfVwOSy3Jlw4xhDi0gypPh0Ro4Q>
    <xmx:mfaWYnvWFKY96fpgFXtSf05yuk3X4YwwOOZhWkRqGzevBFDewl1zxg>
    <xmx:mfaWYrFw3FOjmINJFR99hrHqJy_Auf6cTwECVHnY4F65t0CNo3wIaQ>
    <xmx:mvaWYgESty2l--ca0Ahdyr2ekZuj6z7CkjmlpvLSFUUKB4vW1DRz-w>
Feedback-ID: idee9475d:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Jun 2022 01:18:16 -0400 (EDT)
From:   Max Fierke <max@maxfierke.com>
To:     thierry.reding@gmail.com, sam@ravnborg.org, airlied@linux.ie,
        daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Max Fierke <max@maxfierke.com>
Subject: [PATCH 0/3] Introduce ClockworkPi CWD686 DRM panel driver
Date:   Wed,  1 Jun 2022 00:17:45 -0500
Message-Id: <20220601051748.1305450-1-max@maxfierke.com>
X-Mailer: git-send-email 2.36.1
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

Signed-off-by: Max Fierke <max@maxfierke.com>

Max Fierke (3):
  dt-bindings: vendor-prefixes: Add prefix for ClockworkPi
  dt-bindings: display: Add bindings for ClockworkPi CWD686
  drm: panel: Add driver for ClockworkPi cwd686 panel

 .../display/panel/clockworkpi,cwd686.yaml     |  60 +++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 drivers/gpu/drm/panel/Kconfig                 |  12 +
 drivers/gpu/drm/panel/Makefile                |   1 +
 .../gpu/drm/panel/panel-clockworkpi-cwd686.c  | 458 ++++++++++++++++++
 5 files changed, 533 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/clockworkpi,cwd686.yaml
 create mode 100644 drivers/gpu/drm/panel/panel-clockworkpi-cwd686.c

-- 
2.36.1
