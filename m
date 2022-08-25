Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 689385A0DC7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 12:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240796AbiHYKVA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 06:21:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240170AbiHYKU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 06:20:56 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F6404507F;
        Thu, 25 Aug 2022 03:20:51 -0700 (PDT)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id ADE9FFF804;
        Thu, 25 Aug 2022 10:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1661422848;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ugv4J9W/zwbD41U1u+xDsmyK0fRiW+hPNdQFDhLRvAU=;
        b=i4OC2/+LJcTx/tGlHUhO78gl3ygn2stI873qZ657gnY8hEQYk1Bzxg763Owc3x9ZboLgvH
        PKiB21O6PQEOu3r0UbK4yA/yCwpybJsI+QBuiFX2/hicdqbM6e5i9+gB97m0WeSezzcu+r
        7dYAQh1Ba/3Tg7CBSpd8gcqahoPbrtUO5k0/p0sSPeTSAb7P08fCPoxI+H6AppxpYDxhy5
        3kknCA5bG07oanPR9zWYKXopV8skxUp5p7jrAN1u/UK3o/yS18acOTueLGxpUHHbN5o0FU
        00J91wObGPpMMeY9JDKI2xFH+YV/GG0tlEJfV3JNfx9p8aXNWwZgJj6sJPs5Zw==
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Cc:     Maxime Ripard <mripard@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v2 0/7] media: sunxi: Add a Kconfig dependencies on RESET_CONTROLLER
Date:   Thu, 25 Aug 2022 12:20:28 +0200
Message-Id: <20220825102035.419087-1-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v1:
- Added collected tag;
- Added cedrus to the list of drivers to fix;
- Added fixes tags on all commits as requested.

Paul Kocialkowski (7):
  media: sun6i-mipi-csi2: Add a Kconfig dependency on RESET_CONTROLLER
  media: sun8i-a83t-mipi-csi2: Add a Kconfig dependency on
    RESET_CONTROLLER
  media: sun6i-csi: Add a Kconfig dependency on RESET_CONTROLLER
  media: sun4i-csi: Add a Kconfig dependency on RESET_CONTROLLER
  media: sun8i-di: Add a Kconfig dependency on RESET_CONTROLLER
  media: sun8i-rotate: Add a Kconfig dependency on RESET_CONTROLLER
  media: cedrus: Add a Kconfig dependency on RESET_CONTROLLER

 drivers/media/platform/sunxi/sun4i-csi/Kconfig            | 2 +-
 drivers/media/platform/sunxi/sun6i-csi/Kconfig            | 2 +-
 drivers/media/platform/sunxi/sun6i-mipi-csi2/Kconfig      | 2 +-
 drivers/media/platform/sunxi/sun8i-a83t-mipi-csi2/Kconfig | 2 +-
 drivers/media/platform/sunxi/sun8i-di/Kconfig             | 2 +-
 drivers/media/platform/sunxi/sun8i-rotate/Kconfig         | 2 +-
 drivers/staging/media/sunxi/cedrus/Kconfig                | 1 +
 7 files changed, 7 insertions(+), 6 deletions(-)

-- 
2.37.1

