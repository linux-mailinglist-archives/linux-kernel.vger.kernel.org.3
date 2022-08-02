Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D172587CBF
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 14:59:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235884AbiHBM70 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 08:59:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237117AbiHBM7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 08:59:13 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C79AD371B6;
        Tue,  2 Aug 2022 05:58:41 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 148623200930;
        Tue,  2 Aug 2022 08:58:35 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 02 Aug 2022 08:58:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=cc:cc:content-transfer-encoding:content-type:date:date:from
        :from:in-reply-to:message-id:mime-version:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1659445115; x=1659531515; bh=lF
        k/fEqBGfRzPVeA4zR92b29OEVwLUgqcUO6+ieSCuw=; b=De3Ozp7T3KJr7SZH9B
        bdvwSXWKjdJcwUl3KPk2abFFoUT5VfnYQTgF9xQw0RMpDq708rwYzTLfy1qx93gW
        JxWODCyv43eBQrL2MsqfRw1o/F4BsGIWOyYKUOaNDIxmpfZy4L1tdaf89IoM2n6G
        kpNDUhZa5XJBJF4VCFWPEAYhHTqTs0LW473Tiz0wS3sSLbXUn2ggf22jgu6ztEfm
        wrMLhVsCN0K8Y4zX4KYqyaagq2xEIvswfrcpcD+lTvylh9mlAcmjW0BRS/qDlGK+
        sZ3uFYOiV9O+8ZN+y480hqkqKu3gZ8oF6dN55/Wk6eFVwQ56tlfxduRDSco/VgZj
        6qdw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1659445115; x=1659531515; bh=lFk/fEqBGfRzP
        VeA4zR92b29OEVwLUgqcUO6+ieSCuw=; b=zA75VwDG+ZdUQsq4YEMlA09bxhBoc
        u3cEMDCk5J+/KKKaCwQAdLTlBlHUPLAiOe48l9P68E54jqGNp8OQ+Pz16GS2UqBc
        +4GZus9hPXfcZZcuHrAziWtf7cFMr6EJ7FJY/NTQiDNDby11bF46vY1pLCMHq1xl
        vrgPD8P84XvYXWPVMqi9QttikKwMJ9MmyQXz+3ijb75LoVwCLagoBMHvJWI0MruR
        EEqk/yoyF5geYd3Mp7MUyklrYPpAHmFXyPADqBZeDOXxmQMAu1+pcwYwVs1CQz0p
        Su8Ujy4ocy0Qo1fK27A81Sw2VF56OMEMyktYzqNUzOqxuP/MezqChfdJw==
X-ME-Sender: <xms:ex_pYgIsBpK7I1jSMD_iM468W3TmFlAMzxHA_41aN53rhR8pz23rdA>
    <xme:ex_pYgKl-E1dbVT82y3RgthvCmZ-H-Mi85eh0jctP-qvarQIV_M3Sm0wjz25I7AVt
    smnpbDT4nYs6aX8SeE>
X-ME-Received: <xmr:ex_pYgtmVmhq_qTUOdVjy8cm29_q-qQjW3CGH1yHH4jOt8QEUQgyHCed6uNy6D6I1_gGYegBQnEk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvddvhedgheejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgoufhorhhtvggutfgvtghiphdvucdlgedtmdenuc
    fjughrpefhvfevufffkffogggtgfesthekredtredtjeenucfhrhhomheptehlihhsthgr
    ihhrucfhrhgrnhgtihhsuceorghlihhsthgrihhrsegrlhhishhtrghirhdvfedrmhgvqe
    enucggtffrrghtthgvrhhnpeegtddvffefffejkeeggfegteffffdtueevkeefvdejveet
    vdeuuddvvddtiefgleenucffohhmrghinheplhifnhdrnhgvthdpghhithhhuhgsrdgtoh
    hmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghl
    ihhsthgrihhrsegrlhhishhtrghirhdvfedrmhgv
X-ME-Proxy: <xmx:ex_pYtbAfu0vzyPON07SxqCbgYoXmrkfWCNBGxJopFbPPvXiJo3Qog>
    <xmx:ex_pYnYjxJU1kQb4jk_LiAoWquw1E40uBJB22HaSh4d_Od8-narLmw>
    <xmx:ex_pYpC5DYJry9xxwS1avRAoaBZewP9bHnWi9Jho_n-5kprYEH4FpQ>
    <xmx:ex_pYrSVtVCE8cBrdMzyJ6iBSi9vs5dbVRrCndVbFUMUwFZrPMtL1g>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Aug 2022 08:58:30 -0400 (EDT)
From:   Alistair Francis <alistair@alistair23.me>
To:     linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     shawnguo@kernel.org, alistair23@gmail.com, robh+dt@kernel.org,
        linus.walleij@linaro.org, s.hauer@pengutronix.de,
        andreas@kemnade.info, krzysztof.kozlowski+dt@linaro.org,
        rydberg@bitmath.org, dmitry.torokhov@gmail.com,
        Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v8 0/4] Add support for the Cypress cyttsp5
Date:   Tue,  2 Aug 2022 22:58:23 +1000
Message-Id: <20220802125827.34509-1-alistair@alistair23.me>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series builds on top of [1] and adds support for the cyttsp5
touchscreen controller for the reMarkable 2.

I first tried to add an I2C HID device. Although the cyttsp5 has some HID
looking aspects it is not HID compatible. Just in trying to probe the device
I found:
 - The HID descriptor has extra padding
 - The HID descriptor sets the high bytes of the descriptor length
 - The HID descriptor has extra unrecognised tags
 - The HID reset command doesn't appear to work

I don't think there is a way to use the I2C HID framework with the cyttsp5.
For anyone interested you can see the work here [2]. In that branch though I
can only obtain a HID descriptor, nothing else works without more core
changes.

So instead I rebased the series from [1]. Converted to the new yaml DTS
documentation, added regulator support and fixed a x/y miscalculation bug.

1: https://lwn.net/ml/linux-kernel/20180703094309.18514-1-mylene.josserand@bootlin.com/
2: https://github.com/alistair23/linux/commits/rM2-mainline-cyttsp5-hid

v8:
 - Rebase and resend
v7:
 - Fix device tree warnings
v6:
 - Use reg for the button properties
v5:
 - Address review comments from v4

Alistair Francis (4):
  Input: Add driver for Cypress Generation 5 touchscreen
  dt-bindings: input: Add Cypress TT2100 touchscreen controller
  ARM: imx_v6_v7_defconfig: Enable the cyttsp5 touchscreen
  ARM: dts: imx7d-remarkable2: Enable the cyttsp5

 .../input/touchscreen/cypress,tt21000.yaml    | 101 ++
 arch/arm/boot/dts/imx7d-remarkable2.dts       | 100 ++
 arch/arm/configs/imx_v6_v7_defconfig          |   1 +
 drivers/input/touchscreen/Kconfig             |  16 +
 drivers/input/touchscreen/Makefile            |   1 +
 drivers/input/touchscreen/cyttsp5.c           | 902 ++++++++++++++++++
 6 files changed, 1121 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/cypress,tt21000.yaml
 create mode 100644 drivers/input/touchscreen/cyttsp5.c

-- 
2.37.1

