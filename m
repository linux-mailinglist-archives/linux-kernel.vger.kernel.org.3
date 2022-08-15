Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79CDC59286E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 06:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232382AbiHOEM7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 00:12:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbiHOEM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 00:12:57 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEF2813E39;
        Sun, 14 Aug 2022 21:12:53 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 49F6A32000EB;
        Mon, 15 Aug 2022 00:12:51 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 15 Aug 2022 00:12:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm2; t=1660536770; x=1660623170; bh=BLGvhPXJZwyKlOHCPFA0QFQvR
        du4sjNkhCzDGkbfI/g=; b=geEopUJJtlAkPnRH3NSENE0S+CXA6KECTI8oRgBXb
        VOpePec/5bzDFoeFD5eUWSmC7hOeCtbiiiOK6jWMLtF5YLh04hRR8eA1rX6XxJWe
        5WyPn4q4Q38Htmvpmb69smOazGRCmnzGvPqxZ1lNOulH/LYTaVpdX8y/xc5aluo6
        JlyrACs0cFiHN0AKNQ62ZC665r/oj7W6wgjD7B4QtDAPoKx4wocpRylHj52VFiHe
        qJG2ODhaFn3QLeeWDFT8MkfFJJ3mgs5cXn5yjCDPoDTMjDp0dmnIgQcIW4wG84Z3
        xWfCcud+2iwUp10daZ+fAWoKQ7S99JkBmMcpoCyBL/F6w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1660536770; x=1660623170; bh=BLGvhPXJZwyKlOHCPFA0QFQvRdu4sjNkhCz
        DGkbfI/g=; b=3EjOrYzX6+bXout+6iHugtmlSio9O5YB3rPS7spf4yMt4OejPpM
        TgtVODs55ytfAJEumyrChHD7G6AAnh2LnRSQqNIt8nfbuJxbZCd2h7wl4HpA6uH4
        PEqRgY7AKgig41CmxLZc984uP3BMl/GLVv9JFna1/57lUBf2LIC0jkx53HSnW7aj
        j8cEtYfWEU804eyCAL9nSPPs6iL0O/TFgjfTy8fv/PTtQ9GLAg3ndvbz5HTa8jne
        CO9hNwhVJE+Fo3H439KPZFbQtTAINwxIrQd7mu/j0rkCh/2G+xq2A6PqcO6gF8D4
        HUR0yo1jOh29qRy2pmwNzduziMAGZykY7uw==
X-ME-Sender: <xms:wsf5YvCrq__oRv3iJB9RYQnBClxYVF5w3qER5HTMCt1FayKRorOsjA>
    <xme:wsf5YljxxwFVU1UmjUOsiFD7zECE5_Al2VyvjA-pfNU7tkDdMzFhvmd5WoiK5p7KF
    cvVm4zcSNNTn-YZPQ>
X-ME-Received: <xmr:wsf5YqkqdylLOaKH4bUARZU-prCWofTfPhUWLw69SuBCO2t__bhEVZlf57GxhVd4EnSiuTWa-xDsN7RpH4HPr_yJGHuD5iyK9DhS77lkAJRovyAMb3B6AuCHh-0w-bqdp3lTOA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdehuddgkeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecuggftrf
    grthhtvghrnhepkeevlefhjeeuleeltedvjedvfeefteegleehueejffehgffffeekhefh
    hfekkeegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:wsf5YhxswN4EKKntiR0Q5r83QyIA3mIt3Lp7gJy2ZJ9-ILRBQFSdKw>
    <xmx:wsf5YkT0Iuf-ODo4hINOhdhYx9v4uVuL3TvqqYPdjPt0nJUwbXLehQ>
    <xmx:wsf5Yka17Xje2BpeEHZSfxRIc_IfnqPwHEP2Hrjnkid9l5oU2-Cgvg>
    <xmx:wsf5YoalEzJoW-jEPXqquOELfwgYIw7DgJCuQ3iFng_DrUKuT6YHRA>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Aug 2022 00:12:49 -0400 (EDT)
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
Subject: [PATCH v2 00/10] soc: sunxi: sram: Fixes and D1 support
Date:   Sun, 14 Aug 2022 23:12:37 -0500
Message-Id: <20220815041248.53268-1-samuel@sholland.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series cleans up a few issues in the system controller driver, and
then expands the exported regmap to support one of the pairs of LDOs
built in to the D1 SoC.

Eventually, we will need to update the SRAM region claiming API so
ownership can be swapped back and forth by consumer drivers. This will
be necessary for uploading firmware to the R329/D1 DSPs, but it is not
needed for initial bringup.

Changes in v2:
 - New patch to first clean up the binding

Samuel Holland (10):
  dt-bindings: sram: sunxi-sram: Clean up the compatible lists
  dt-bindings: sram: sunxi-sram: Add D1 compatible string
  soc: sunxi: sram: Actually claim SRAM regions
  soc: sunxi: sram: Prevent the driver from being unbound
  soc: sunxi: sram: Fix probe function ordering issues
  soc: sunxi: sram: Fix debugfs info for A64 SRAM C
  soc: sunxi: sram: Return void from the release function
  soc: sunxi: sram: Save a pointer to the OF match data
  soc: sunxi: sram: Export the LDO control register
  soc: sunxi: sram: Add support for the D1 system control

 .../allwinner,sun4i-a10-system-control.yaml   | 82 ++++++++-----------
 drivers/soc/sunxi/sunxi_sram.c                | 74 +++++++++--------
 include/linux/soc/sunxi/sunxi_sram.h          |  2 +-
 3 files changed, 73 insertions(+), 85 deletions(-)

-- 
2.35.1

