Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D36A556C290
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 01:13:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240296AbiGHUy0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 16:54:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240285AbiGHUyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 16:54:24 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63F6A1A837;
        Fri,  8 Jul 2022 13:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1657313659; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:references; bh=gGn/JAlWhoA8iZTvGC0UpxYEbo4/opBKC6mgkgtoZZg=;
        b=dikaKTtrVfFhrGpuWBud1iEnvFCdCR0Lo/FEL/l9tXtz5jld3GUTyXsACSIMqRKppcTcMz
        4OQjsJ24SK/Bqlfjqut4yRa3yCGQnFFM4qixAyH6D6p/H7lGWnYoLYqGvzQWZ63iu/ZHwv
        Q7QoFkGJyq/exJiipzNKgkB+sNip2ZY=
From:   Paul Cercueil <paul@crapouillou.net>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>
Cc:     Sam Ravnborg <sam@ravnborg.org>,
        Christophe Branchereau <cbranchereau@gmail.com>,
        list@opendingux.net, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 0/6] drm/ingenic: JZ4760(B) support and random changes
Date:   Fri,  8 Jul 2022 21:54:00 +0100
Message-Id: <20220708205406.96473-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

A small set of changes to the ingenic-drm driver.

The most notable thing is that ingenic-ipu is now its own platform
driver.

Cheers,
-Paul

Paul Cercueil (6):
  dt-bindings/display: ingenic: Add compatible string for the JZ4760(B)
  drm/ingenic: Fix MODULE_LICENSE() string
  drm/ingenic: Add support for the JZ4760(B)
  drm/ingenic: Don't request full modeset if property is not modified
  drm/ingenic: Make IPU driver its own module
  drm/ingenic: Use the new PM macros

 .../bindings/display/ingenic,lcd.yaml         |  2 +
 drivers/gpu/drm/ingenic/Kconfig               |  2 +-
 drivers/gpu/drm/ingenic/Makefile              |  2 +-
 drivers/gpu/drm/ingenic/ingenic-drm-drv.c     | 72 +++++++++++--------
 drivers/gpu/drm/ingenic/ingenic-drm.h         |  3 -
 drivers/gpu/drm/ingenic/ingenic-ipu.c         | 10 ++-
 6 files changed, 53 insertions(+), 38 deletions(-)

-- 
2.35.1

