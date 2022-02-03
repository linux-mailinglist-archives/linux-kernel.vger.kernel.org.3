Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 448194A7DC2
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 03:17:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348908AbiBCCRm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 21:17:42 -0500
Received: from wnew4-smtp.messagingengine.com ([64.147.123.18]:58871 "EHLO
        wnew4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239177AbiBCCRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 21:17:41 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailnew.west.internal (Postfix) with ESMTP id 8CF9E2B0019A;
        Wed,  2 Feb 2022 21:17:39 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 02 Feb 2022 21:17:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm1; bh=RytlSUaDRmapV5YwWfkzWD1+yC9W9mp9nHm/VpHru/A=; b=bE4CU
        dLZC5ycYQ29W6w7WmkiyDhRYKTMXe3ExKn1iFR4QopansEIHFClcQWxukboGv6VF
        5Nn7F6J7ZRN624YP/IRJtbrZ+xjL4tBYLsDbx5sxvZXTKbQcpv9xqNAzQOfvA0Fk
        UwkTqEVQLxqZ/QkFpy1YdzsZ+IjHUYvNkbHf+ne0EXHAzPRAZM+GG252HJX3VBKS
        T+H0OuqawOwYT17AOx1C+jvPvFb7G9M9ixDWaOgGyT0ExM21EPyCnsm7KjlhyEig
        CzH6qmk4fkKMh+tMjWRrXqsh+XeWeqq4qs9MrYBNOQNN9AOk86nsjed6SRpmegEr
        TIolgIvcM5z7/BI2w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:message-id:mime-version:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; bh=RytlSUaDRmapV5YwWfkzWD1+yC9W9
        mp9nHm/VpHru/A=; b=hmnkszU4kAAenV+yP1A3wbLJxeLZ6oKIftjRrKcHNMg6P
        H7woqqxXDgwNbMWGqEaEB9YX78Trk6QLzfq/JdiTYvednxiV1OvCQD1SFoD88TM3
        JVHk7ZarPiQWX3tN2lPo75KYPqPf7SLmJA0mP9uBPxN6hZM8KEOrG/PCYp2cqh+f
        Emltupdy0+4ifCeUqPuZ+6NgmVSRTHiVBAPedO5VcOiHouoB9aPVnToxqXjawLgD
        SVhrFriMEw5MrIuTyYImV9uKfB4quXEtgBhrTa9BWSsOJrAts2ErfYC/oKzCf7+t
        8gTTlyb2jbXwA0KRWQPRImY6V7BIRuIqIyP3drMJw==
X-ME-Sender: <xms:Qjv7YRAuNLQDjAwe3_tyNU40Pc5u_XjVQ-PDqeCcHH9fW2KEPNpXPw>
    <xme:Qjv7YfgYUDrohcDJFZ--Pn5xjV5c5wCDPUluWw5iq8fhNOnWCzEowIPwfZqfC0-8y
    29cDgdlOdFVD-20Jw>
X-ME-Received: <xmr:Qjv7YcnJidYN444D5mCA7QmUBBOBOnJWAqj84jQvplS1HDWTv3kJAucxcP7-Ypxi5WjW0Y0XOCPQwZg7pZ_JXroPAik3OYAX1eoitcW680u9kPgxJOA6T4VwwIA4yzXgkuIJBg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrgeeigdeggecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghlucfj
    ohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecuggftrfgrth
    htvghrnhepieetkefhheduudfgledtudefjeejfeegveehkeeufffhhfejkeehiefftdev
    tdevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsh
    grmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:Qjv7YbzsJLyggIFRfv_r1J4PYohbE5yLUQoLlqV0RPZsmflwyqqUoA>
    <xmx:Qjv7YWR4_cmdqjjeuDQLV29pq3WAMXlee447PfjXouEBxoD6j0IP6A>
    <xmx:Qjv7Yea2LPDaeZV-VpqF9H07aScCg4Xh6XOLX5YCkcAg0wk1AtH56g>
    <xmx:Qzv7YQDTDvxON9ldrBrwAKd6Xo-VXQZl3Odpe4vJdUxI476cnmx-gThNRhc>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Feb 2022 21:17:37 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-sunxi@lists.linux.dev
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Michael Turquette <mturquette@baylibre.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH v3 0/6] clk: sunxi-ng: Add a RTC CCU driver
Date:   Wed,  2 Feb 2022 20:17:30 -0600
Message-Id: <20220203021736.13434-1-samuel@sholland.org>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds a CCU driver for the RTC in the H616, R329 and
D1. The extra patch at the end of this series shows how it would be
explanded to additional hardware variants.

The driver is intended to support the existing binding used for the H6,
but also an updated binding which includes all RTC input clocks.

A future patch series could add functionality to the driver to manage
IOSC calibration at boot and during suspend/resume.

It may be possible to support all of these hardware variants without
adding this new driver, by adding them to the existing RTC clock
provider, but I'm concerned about the complexity there, without any of
the CCU abstraction.

Changes in v3:
 - Add/fix several maxItems attributes for clocks and clock-items
 - Drop the SUNXI_CCU_MUX_HW_WITH_KEY macro, since it is no longer used.
 - Also drop the patch adding the SUNXI_CCU_MUX_DATA_WITH_GATE macro.
 - Rebase on v5.17-rc2 (CCU module support series was merged).
 - Move IOSC calibration control to prepare/unprepare operations.
 - Declare several `struct clk_init_data`s as static variables (instead
   of as anonymous) so they can be modified from the probe function
   without casting away const.
 - Instead of creating two copies of clocks which may or may not have
   muxes, change the number of parents to 1 in the non-mux case.
 - Use a single CCU description for all variants.
 - Use IS_REACHABLE to guard the call to sun6i_rtc_ccu_probe.
 - Allow the driver to be built on !ARM64 (i.e. RISCV).
 - Rebase example on top of driver changes, and drop the second example.

Changes in v2:
 - Combine "const"s to "enum" in the DT binding compatible property.
 - Properly update the DT binding clocks and clock-names properties.
 - Rebase on v2 of the CCU module support series.
 - Load the CCU driver from the RTC driver, not as an OF provider.

Samuel Holland (6):
  dt-bindings: rtc: sun6i: Clean up repetition
  dt-bindings: rtc: sun6i: Add H616, R329, and D1 support
  rtc: sun6i: Enable the bus clock when provided
  clk: sunxi-ng: mux: Allow muxes to have keys
  clk: sunxi-ng: Add support for the sun6i RTC clocks
  [DO NOT MERGE] clk: sunxi-ng: sun6i-rtc: Add support for H6

 .../bindings/rtc/allwinner,sun6i-a31-rtc.yaml |  84 +++-
 drivers/clk/sunxi-ng/Kconfig                  |   5 +
 drivers/clk/sunxi-ng/Makefile                 |   2 +
 drivers/clk/sunxi-ng/ccu-sun6i-rtc.c          | 393 ++++++++++++++++++
 drivers/clk/sunxi-ng/ccu-sun6i-rtc.h          |  15 +
 drivers/clk/sunxi-ng/ccu_common.h             |   1 +
 drivers/clk/sunxi-ng/ccu_mux.c                |   7 +
 drivers/rtc/rtc-sun6i.c                       |  48 ++-
 include/dt-bindings/clock/sun6i-rtc.h         |  10 +
 include/linux/clk/sunxi-ng.h                  |   2 +
 10 files changed, 538 insertions(+), 29 deletions(-)
 create mode 100644 drivers/clk/sunxi-ng/ccu-sun6i-rtc.c
 create mode 100644 drivers/clk/sunxi-ng/ccu-sun6i-rtc.h
 create mode 100644 include/dt-bindings/clock/sun6i-rtc.h

-- 
2.33.1

