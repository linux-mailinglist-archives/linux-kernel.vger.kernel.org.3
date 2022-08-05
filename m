Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F32858A7EE
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 10:19:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240393AbiHEIT0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 04:19:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240197AbiHEITX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 04:19:23 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D666174DF7;
        Fri,  5 Aug 2022 01:19:21 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id E7E33320016F;
        Fri,  5 Aug 2022 04:19:18 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Fri, 05 Aug 2022 04:19:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm2; t=1659687558; x=1659773958; bh=g+1gGUdyp6ZHUgxb6Gt0DXeBu
        7G+WTFmII/7zcLOU9A=; b=TsuywTsCE03Sy99nJPfIovANLEDhP/nb4y6NsRSNo
        FE5kHRyWx9vT3ipH09/jI4C+xJgMCREo5JC9VOUNQ+mGC16Pf+MJVwLGft91bpkY
        DvAPGmE5gXti9da9qB1KYWZ/2uQ3LSEy/6KZmgPaoOb6EtJKw5cNTAiXq1djC77/
        QcIXCgF+L/A9XQ9q0B3aA3A0tVSiJt1OJgNfC1/V4IHbBMD8ZDUVAUMrU6OcI3jQ
        NYKYsR3PN8WPsB8gR6RiGp8KvIgwQYVthwUnEUookZWq1n5LGbrr2nmNSAxLlhfq
        zQrKuDJJOrGhC5OpryGKT2hJ7Vih/u9xjpmg7y9iEjeiA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1659687558; x=1659773958; bh=g+1gGUdyp6ZHUgxb6Gt0DXeBu7G+WTFmII/
        7zcLOU9A=; b=3UJ8h2ts2cM1SSTgNG74UBc9xNJYKMFP3DsZqdmPFd5N25HgnXB
        MgYatxvcBrBMrnYEjUMUBQKR7tZLKJn8dpMEvQiOBGo5n12qnyRJFPSy2WgnNOXR
        cgjQ8lxPBsht5Gu9yENNwPT2eTC575N83c3x/2gAk0JTraEpUtKjGA1cAI6Cm/f5
        cy4eZ2td/ImsAbKgDMOQ+Nher3hQn1bdYJAk3V0IkRWW0xCUJ7LZ8dlIciIPJkN2
        0DukkpDbGyozRIfszJWN1xqVCln2JXAY1J+GBoy1McWh/kIo0yUdOpIWSsL9kR4h
        iV+RIG/AXP1mPy5SKFTjkq6i4/QjXUIAD2g==
X-ME-Sender: <xms:htLsYvTnxa_yoxjCx1_cAxkDmzh9OV2nUgt0jk6C3cKj7nuxelyvnw>
    <xme:htLsYgwXj1rLZyrtTJ5O1Ym69ulHmTFxGyFjyRyEhitCfaqRZIiC7e9zudd4pM3ix
    f5bFVDslYporj_cSyE>
X-ME-Received: <xmr:htLsYk3wEbxfLwJWDobZ8c0b6TFuoAgTAjWmiR5i9xYas1qVp3VHs9hScfCE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdefuddgtdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpedfnfhukhgvucffrdculfhonhgvshdfuceolhhukhgvsehljhho
    nhgvshdruggvvheqnecuggftrfgrthhtvghrnhepgfdujedthfduudekffefkeeiffdttd
    dvhfegudduueffuefhfefggeefteevvdegnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:htLsYvDqZ8MzJaeNGgZ7VW6Ov6TwmqZ1IotZXIB7_OseOeoXWPJNYg>
    <xmx:htLsYohs1oGPjQn4IlyfQ1nkJX0M0lQ1iLLFf3XL54BBMlC1gP4iZA>
    <xmx:htLsYjoCFWz9PbpRQQM2ScEZ7IljAY5BlhtqTudnPOyY24GXHp6GYA>
    <xmx:htLsYruCf84nAVIRDvV9nBNoeUUEHFqp4SjDmEN6aazXceW78HfZJg>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 Aug 2022 04:19:16 -0400 (EDT)
From:   "Luke D. Jones" <luke@ljones.dev>
To:     hdegoede@redhat.com
Cc:     markgross@kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, "Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH 0/5] asus-wmi: Add support for RGB keyboards
Date:   Fri,  5 Aug 2022 20:19:04 +1200
Message-Id: <20220805081909.10962-1-luke@ljones.dev>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a patch series to add RGB support for ASUS laptops.
The laptops with this RGB tend to be the TUF series of gamer laptops.

The first step is initial bringup of support using the multicolor LED API.

These types of keyboards implement a slightly more complex interface than
just RGB control however - they also have modes with can be static LED,
blinking, rainbow, color cycles, and more. They also have some custom
animations that can play depending on device state, such as suspended
playing a fancy colour cycle, or playing a "wave" animation.

Two of the patches add support for these features.

The last patch adds documentation in:
Documentation/ABI/testing/sysfs-platform-asus-wmi

Some notes:

- this patch series obsoletes the previous RGB patches by myself

- it is not possible to add attribute groups to multicolor LED as
  they get overwritten by `led_multicolor_groups` in
  `led_classdev_multicolor_register_ext`.

- the methods for RGB control do not provide a way to fetch exisiting
  state, so these methods are WO.

- There is an existing `asus::kbd_backlight`, this provides a 4-step
  brightness to the RGB (off,low,med,high) individually to multicolor.
  I was unsure of the effect of adding a similar path so have used the
  `asus::multicolour::kbd_backlight` name to be clear about purpose.
  If the `asus::kbd_backlight` is off, then no RGB is shown at all.\

I'm hopeful that this patch series addresses all previous feedback related
to the obsoleted patches.

Luke D. Jones (5):
  asus-wmi: Add basic support for TUF laptop keyboard RGB
  asus-wmi: Add support for TUF laptop keyboard RGB mode control
  asus-wmi: Add support for TUF laptop keyboard states
  asus-wmi: Document many of the undocumented API
  asus-wmi: Convert all attr _show to use sysfs_emit

 .../ABI/testing/sysfs-platform-asus-wmi       |  50 ++++
 drivers/platform/x86/asus-wmi.c               | 263 +++++++++++++++++-
 include/linux/platform_data/x86/asus-wmi.h    |   5 +
 3 files changed, 311 insertions(+), 7 deletions(-)

--
2.37.1

