Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C31254A7AFD
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 23:20:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347846AbiBBWTv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 17:19:51 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:45985 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347845AbiBBWTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 17:19:50 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id DC7CB5C0186;
        Wed,  2 Feb 2022 17:19:49 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 02 Feb 2022 17:19:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm1; bh=j5Y8ilTGveXraQd360AMKChOGsivYDofx2aDpvsAavc=; b=AIyzq
        /SYCM+kfIlAcC5s9Nq+kYUc0csQd09IqyUAo6G4YaKILttS8Of7+HwTvXP9bu4CX
        KmON3zLZ0ZTPuq1mEdUEX93eZIcQE9i3NoKd2o+Ox0qVK9xz8+MuDU2PiovM9dIC
        MFq8K+9R6/0BdSiy6vlB0nT9gjpbteOLWX+ScZyJlq4t8zEX6vD7DNgLxDFM5+kN
        wkOJ7ConkZHeibLOE5taa46Dn8dbanJ5GQlRuJsh8Za0wJd+fmhPsgp9WgTMSHHj
        +lI8XWuTnXNTjyCSS/GF/Mb0V4X/m80GgTGfL+w4ou9P9gb/I4rtGIL2hHwIi5wJ
        HJsnN0sJn+oARo7vA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:message-id:mime-version:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; bh=j5Y8ilTGveXraQd360AMKChOGsivY
        Dofx2aDpvsAavc=; b=nWF60lG98jBd9F5MI3qbw2BojNgd/FTXo/pCQsQZq21uT
        qZZJNEzsWr3d42LWc+XTTiKERdHi/DlVEkne0iH1Ceqwk4e2772ko0uEXOVNcPUi
        5LXOdSvw6ShBQumK/51ExVVPzn4jkRThX5SaAW+y0iE1u7NNXAI3p0mP+U2ZWHML
        cJOKL5Y+uyifgdnd28PUsjPjZX4exmYj8qEgR0eBTWKKvyuMdTHHAXiunnQRSWIy
        jBlqIGQwq4XHd6AZRdxFYuETRv9Jx3hz3XUYMIZjQjNC+Dhb4lDEV8G7yirV6ZzP
        sh9mEb0Edcyv1aR67bxWPgvCsRqYHiyEfmwU5vJtQ==
X-ME-Sender: <xms:hQP7YZkDAM3J2peOIWyxXhChGdS9dV7mAkQZ-ElwkXnLHPtqGg93rw>
    <xme:hQP7YU0aP5OuUGXa0qTHxnAQMEdehOVAfTWe1kPOG1SGLI78XSWO-yAtIIFMlUUWg
    ayvjGlfB-uLoJV8jA>
X-ME-Received: <xmr:hQP7Yfq421_YMFLevWxxquY38J6WzLgmUgtBpQUyJJvMn9rTish764UR0e4nzlL00PeLqOXHco3ubf4D5_erXj0Nr_Fyrg9L2bD2bFJlYQ73atx4PVC05sxpeqvnuI_fkHpq6w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrgeehgdduiedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgvlhcu
    jfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtffrrg
    htthgvrhhnpeeiteekhfehuddugfeltddufeejjeefgeevheekueffhffhjeekheeiffdt
    vedtveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:hQP7YZnKGdAXtzHPVBUeq7uSSCJBrki2Ast58EXy2uiryfRsbaL9Bg>
    <xmx:hQP7YX19UHakEV13WmyB1y-qMC2BJRBthCxsKWoG6OTvmSVPvYnp0g>
    <xmx:hQP7YYtYJkfoYBGww_NhPs3_vkYeCdlMosBPm2PVEwpfug7nnFmi9A>
    <xmx:hQP7YRqBybmcPhTVYE0wQRUyj4O5d0HQWjAuLPaqfkFE1NzGLxuO0Q>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Feb 2022 17:19:48 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH v2 0/4] usb: typec: WUSB3801 devicetree bindings and driver
Date:   Wed,  2 Feb 2022 16:19:43 -0600
Message-Id: <20220202221948.5690-1-samuel@sholland.org>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds bindings and a driver for the Willsemi WUSB3801. This
chip's bindings use the standard USB Type-C connector bindings, but the
driver does not use the TCPM library, so a refactoring patch is included
to avoid duplicating some fwnode parsing code.

Changes in v2:
 - Always put the return values from typec_find_* in a signed variable
   for error checking.
 - License the driver as GPL 2 only; probably best anyway as I used a
   lot of other drivers/usb/typec code as inspiration
 - Don't try to be clever; use `default` instead of `unreachable`
 - Free the IRQ before unregistering the partner/port

Samuel Holland (4):
  dt-bindings: vendor-prefixes: Add willsemi
  dt-bindings: usb: Add WUSB3801 Type-C Port Controller
  usb: typec: Factor out non-PD fwnode properties
  usb: typec: Support the WUSB3801 port controller

 .../bindings/usb/willsemi,wusb3801.yaml       |  75 +++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 drivers/usb/typec/Kconfig                     |  10 +
 drivers/usb/typec/Makefile                    |   1 +
 drivers/usb/typec/class.c                     |  52 ++
 drivers/usb/typec/tcpm/tcpm.c                 |  32 +-
 drivers/usb/typec/wusb3801.c                  | 445 ++++++++++++++++++
 include/linux/usb/typec.h                     |   3 +
 8 files changed, 589 insertions(+), 31 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/usb/willsemi,wusb3801.yaml
 create mode 100644 drivers/usb/typec/wusb3801.c

-- 
2.33.1

