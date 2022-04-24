Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1BAB50D312
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 18:05:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233374AbiDXQIL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 12:08:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233453AbiDXQIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 12:08:06 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22B43111;
        Sun, 24 Apr 2022 09:05:03 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id BD6055C0186;
        Sun, 24 Apr 2022 12:05:00 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sun, 24 Apr 2022 12:05:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm2; t=1650816300; x=1650902700; bh=2ifXnimlzF9mOdaX4RxX8QFk2
        i4QWGOnS3cijNufVA8=; b=d137+bSzS0+tF9O+osV5Tv2wyLZiivoaOn8z0C9wP
        xXNii2ALeOMvCBmFkfdshnvpeF0eFHPXCB5xpEstCRwfEgsjq3j97hEW3vBs7fKc
        H5PaCpnevQo6d2SO1sJlUBn6zxHM3nYEkDnVeit6FSCs/z+88dciUksbpXVEFnvK
        lakuTSjXajideD7JD1QMXmwj+yjCbeOX3c+lI3hqJ/uOJhFCg3C+3+kq8uhlDypf
        QZRkzdGIkthNHZeaXjG4SqCWHEY5tF043jH9wSBQEOyOY6SvcROpd/5U1L53+BPo
        9sYAXnxDU4TSli4ZkhlUZRi65g78lKUL+wWByi89tfVbw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:message-id:mime-version:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; t=1650816300; x=1650902700; bh=2
        ifXnimlzF9mOdaX4RxX8QFk2i4QWGOnS3cijNufVA8=; b=kLp2w4rRwVpIPY9+v
        6hFxwaK/HK/a6pBIhan5JnscVB7+9ZyzLMYaLuAhrJHgfwliQJXS58m0PBlprxTJ
        H6ZtEGAOmjDpDN7ohg+h+iPRbB7Sc2RkXHQG3HPrSNVwKdwTrbR1V2QTE1QUuQTW
        Y3G6C0kubTHtvqgxyD2YKzBp3raofQLZKEaAlgDscAqoT7xIcY+NfixR5XfRwp2n
        +6X4TbQOjOQF4AfT7yCObd/fhPxloHNlp6rr0WRBAL4YgFmIQTjdYDrOqeJBTkxS
        p30Ry0qnWTORpXOgAFmZ7QpHNc4npavrvCpl5n4PM6oN3r0EzH1k/7asTPqxWB+E
        yEGMg==
X-ME-Sender: <xms:LHVlYt4Kg9pvfDUlHsR2LWF1d-yl2aTLo9qUOypa4JY4EAiDzYamcA>
    <xme:LHVlYq4wLZbNK01UreXSlvl19fAB-LTQLKvF0NzVVP4tn7UadTJTdTh3qQdlV1iLJ
    5dBcjorjsTUgkWnKQ>
X-ME-Received: <xmr:LHVlYkdmwkbx6NwwZ4lwXZZbVDzi7NUt-hykOWlgjGJw2Q6reU0V-JTd6ed_lg1bfraRcnxDEx0rouByAwCVm9sXikxTpRDnQXG7rfuSS5JKrU5LvSbq5EOvj7pBThB8exGsJw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrtdelgdelkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgvlhcu
    jfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtffrrg
    htthgvrhhnpeevudeigeekledvgfevlefgueelkeduieelveejfffhjefggeelfefhteej
    gfegvdenucffohhmrghinhepmhgvghhouhhsrdgtohhmnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghnugdr
    ohhrgh
X-ME-Proxy: <xmx:LHVlYmLCAOkgwA6N4So1xDAz8eg89QFp0DNwwOkA2CB9XLcEju4FBg>
    <xmx:LHVlYhKUkk6FRjNocK_e5KOaYLdNZZ9BENjDbgHrfaeDR3vRrp_R2g>
    <xmx:LHVlYvzT78IM3O9klLki2Up6yCucdVKf8SWiqEgAM3cJl9IcXtQYbQ>
    <xmx:LHVlYp_jYFlkmDWhMLRhChYyUsqZlTiS9ssPCXDxgazQoibrlIprJw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 24 Apr 2022 12:04:59 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>, Ondrej Jirman <x@xff.cz>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH v3 0/4] Pine64 PinePhone keyboard support
Date:   Sun, 24 Apr 2022 11:04:53 -0500
Message-Id: <20220424160458.60370-1-samuel@sholland.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for the official keyboard case for the Pine64
PinePhone and PinePhone Pro. This accessory contains a keyboard MCU and
an IP5209 power bank IC. The keyboard MCU firmware[0] is free software.
It exposes the keyboard scan matrix over I2C, and also provides commands
for SMBus access to the IP5209. In order to keep the IP5209 driver
(CONFIG_IP5XXX_POWER) generic, this is modeled as a child I2C bus.

[0]: https://megous.com/git/pinephone-keyboard/about/

Changes in v3:
 - Replace unevaluatedProperties with additionalProperties
 - Rename i2c-bus to i2c

Changes in v2:
 - Drop keymap DT properties
 - Add vbat-supply property
 - Fix missing key release events when FN state changes
 - Add VBAT consumer to ensure enough power is available for the MCU
 - Use a single fixed-size, fixed-contents keymap for both layers

Samuel Holland (4):
  dt-bindings: input: Add the PinePhone keyboard binding
  Input: pinephone-keyboard - Add PinePhone keyboard driver
  Input: pinephone-keyboard - Support the proxied I2C bus
  [DO NOT MERGE] arm64: dts: allwinner: pinephone: Add keyboard

 .../input/pine64,pinephone-keyboard.yaml      |  66 +++
 MAINTAINERS                                   |   6 +
 .../dts/allwinner/sun50i-a64-pinephone.dtsi   |  18 +
 drivers/input/keyboard/Kconfig                |  10 +
 drivers/input/keyboard/Makefile               |   1 +
 drivers/input/keyboard/pinephone-keyboard.c   | 438 ++++++++++++++++++
 6 files changed, 539 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/pine64,pinephone-keyboard.yaml
 create mode 100644 drivers/input/keyboard/pinephone-keyboard.c

-- 
2.35.1

