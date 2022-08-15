Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E12F5928D3
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 06:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240734AbiHOEem (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 00:34:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbiHOEek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 00:34:40 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70D8A14D00;
        Sun, 14 Aug 2022 21:34:39 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id E3CCB320039A;
        Mon, 15 Aug 2022 00:34:37 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Mon, 15 Aug 2022 00:34:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm2; t=1660538077; x=1660624477; bh=SZ5v7SwKxKRGgP+cCIUCQcwi+
        uzQ6nY+5CX8LY/PRvU=; b=r0dmwSkDzL2DJSVK1OllhF1cmFKiWGI1fsuZQTYeC
        yunxoXucbTAowbsN0JMLq6MfQdfl2dfUedoM7Stu+dSq6d3S+0au//HvXpt9kTAx
        rKUN8oqDITU+D+yJPeao0jqqrapbumDV4+H+5enHQ5GqWTKp26p/IjUGHndwqGTV
        upMKbLozzGtW3wKqbl8ml9omlKJ38zWZyRXnRMNa0KMcC/FXf4p5mhf2kLGEQK8d
        NVCOLrwXkNwvp9TviSTDZjF4IGEEIMRbWa9DoibgGBndLeWn9YUUU0ch8NcOu5uN
        Al7xzYsM5rVik9F2NxedANzEQwFKUlBXWCed4n4hbfjUQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1660538077; x=1660624477; bh=SZ5v7SwKxKRGgP+cCIUCQcwi+uzQ6nY+5CX
        8LY/PRvU=; b=a+As4MBWRZZfnaH6SVQ3b8RutI94ecUfSFXawbhGynFHGXSI1HC
        Fz5IXhM8+xjurIbi1GGGXeUOPAzxLHJ0K8UkBqX4hiWorgdUTZKQmFQW6XuHWYff
        7T7R6NS/IzSJkGBHvMhPmli8AqkoGf/e5qKR1+t2OjCd6N/sMt8nvXntTzzjfFe8
        Ytza7W40iKMLG6zeDqJaKyiJPov3r0fGLDyi3Da9VDUNuWGSjMdmkBApBK9YcuMH
        E5GxPsw1Fcg04anucc9tRUwK8nA0vknL9nAp4WYSgfNS0uf7y4YiPG+6vu51En88
        G9zlw7fvAQRCIEWRfRX6J2OGAgHQccmLxwQ==
X-ME-Sender: <xms:3cz5YsfU42jqkGMhuwz9vnNuHy6qGoULUR0vhntqT9bEn-VEifMong>
    <xme:3cz5YuN-llvgbuNsq8xZ4pIJUvE5JG-AmSjWiqsYV_6ZEvbiP3vA5cP0JY6pI-87R
    0-LQ4COMXKWueMiHg>
X-ME-Received: <xmr:3cz5YthQuP-OHPZ9buI8jCqfnez0A_6ycCCm25pE1scdHl9rbCKK8nQ4MrumnjjOYz_uxkdmq7Wnm7QGmu-CM77ULu-9Xxzu_9oDPzDAApcweAxHSMf2or-Lj0hKkRCcWxruTw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdehuddgkeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecuggftrf
    grthhtvghrnhepkeehffethedtteffgfefteetjedvfeelueevudffgfeutdejvdehledv
    vdffhfevnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghmuhgvlhesshhhohhllhgrnhgu
    rdhorhhg
X-ME-Proxy: <xmx:3cz5Yh_oH5azO04EomE9h090QZhDRgJHW-_SgF-r3gJf5iBA2PRcnA>
    <xmx:3cz5Yotz-bA9P3SLvjrIKM9LQ1l5-EJGbqlvsZV80xSVxdAPaCfLEw>
    <xmx:3cz5YoGwDwexOHo5h0F0AkmIWiVhKUCNU1olsXUJGXlNQn0rv17dew>
    <xmx:3cz5Ypn-n-1O4CCcTAUH6-vo_gUpejwOZUNo_AT9yBz5F97RUYuAWg>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Aug 2022 00:34:36 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Samuel Holland <samuel@sholland.org>,
        Maxime Ripard <mripard@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev
Subject: [PATCH v3 0/4] regulator: Add support for Allwinner D1 LDOs
Date:   Sun, 14 Aug 2022 23:34:31 -0500
Message-Id: <20220815043436.20170-1-samuel@sholland.org>
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

This series adds bindings and a driver for the two pairs of LDOs
inside the Allwinner D1 SoC.

A binding and driver change is required for the SRAM controller, to
accept the regulators device as its child node. The new example in the
SRAM controller binding uses the compatible string added in this series:
https://lore.kernel.org/lkml/20220815041248.53268-1-samuel@sholland.org/

Changes in v3:
 - Add "reg" property to bindings
 - Add "unevaluatedProperties: true" to regulator nodes
 - Minor changes to regulator node name patterns
 - Remove system-ldos example (now added in patch 3)
 - Adjust control flow in sun20i_regulator_get_regmap() for clarity
 - Require the regulators node to have a unit address
 - Reference the regulator schema from the SRAM controller schema
 - Move the system LDOs example to the SRAM controller schema
 - Reorder the patches so the example passes validation

Changes in v2:
 - Remove syscon property from bindings
 - Update binding examples to fix warnings and provide context
 - Use decimal numbers for .n_voltages instead of field widths
 - Get the regmap from the parent device instead of a property/phandle

Samuel Holland (4):
  regulator: dt-bindings: Add Allwinner D1 LDOs
  regulator: sun20i: Add support for Allwinner D1 LDOs
  dt-bindings: sram: sunxi-sram: Add optional regulators child
  soc: sunxi: sram: Only iterate over SRAM children

 .../allwinner,sun20i-d1-analog-ldos.yaml      |  74 ++++++
 .../allwinner,sun20i-d1-system-ldos.yaml      |  37 +++
 .../allwinner,sun4i-a10-system-control.yaml   |  29 +++
 drivers/regulator/Kconfig                     |   8 +
 drivers/regulator/Makefile                    |   1 +
 drivers/regulator/sun20i-regulator.c          | 232 ++++++++++++++++++
 drivers/soc/sunxi/sunxi_sram.c                |   3 +
 7 files changed, 384 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/allwinner,sun20i-d1-analog-ldos.yaml
 create mode 100644 Documentation/devicetree/bindings/regulator/allwinner,sun20i-d1-system-ldos.yaml
 create mode 100644 drivers/regulator/sun20i-regulator.c

-- 
2.35.1

