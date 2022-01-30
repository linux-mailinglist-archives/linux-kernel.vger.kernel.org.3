Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E57864A3C03
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 01:00:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347823AbiAaAAH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 19:00:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241651AbiAaAAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 19:00:02 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EBDCC061714;
        Sun, 30 Jan 2022 16:00:01 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id y15so23300292lfa.9;
        Sun, 30 Jan 2022 16:00:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qexSNYWB7tiyIuCaaBWHS9YHRPNUyCUhhgTpadvVgtM=;
        b=EBv1/JWzmmsta2iNd/4vCWqpQlnhyzJLB+LZORlFD5E6o+GKw+Bi1KpnETkFxhg/Af
         +ptPl5fFaldPfltEah2n0VZu2sBs1mIkn4IJE94ZPNt/BVorbKUMOWVHiGYzSdOPnaUd
         8g6LzEhARyQiyOM4Rxt7f5zNfh8O06zAqS0wq5d9MXz05/OY4WFQZf0sr99y70Q5IedY
         KTGhFIwA6FUsoN8DE+fcM5c8j2Es9gGcFg8QxHWDCSMIRORvPWA8b7QB2IZIBdaZ1b/Q
         BKzDKXpNIQ0nhIpcnnf8RnNN0+udNOc5CSmEIl0oO+YTID2zleO8vPYeJFUi2joML8NN
         zTRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qexSNYWB7tiyIuCaaBWHS9YHRPNUyCUhhgTpadvVgtM=;
        b=zJS+6rqYLcd79/BvLA0srSwgWk1FsTDJqKdaqQS4dJ+L9B44Z+bPHe+JiPZeI+IqV0
         4We57q1pZXyTuixf7RfTEW227p0CJwhC/SgeO5QkwfhBOa4rjtfEae4am8JE5/22vJu+
         qW35LTqF1cK1LOl7beSivGCA/2NsRuWrI/9+6ToK6hOjb+TUEIz5h/jYJRHAW5z84+ou
         ZWxKYs13PR8EREaE+ahXQ0xPOEClXcQS3RC2fd0C3FoSAsLQ80BmX8j5blULrMEb09BO
         GwMuTGgKqlMedRsbGUH7XKNKiQsPhi6du1BvAIgiqU+/Zo6WgAnAYhEYh/mLXNuSyEP0
         v4HA==
X-Gm-Message-State: AOAM530BwpzOkS4QWbi8XuSGAZgEM93RXtzzz2I49pyMrnK8sM7lgOhJ
        keRGelx1ruz6rkIgJqietB4=
X-Google-Smtp-Source: ABdhPJxlvDzkyoA4bZ+eX1yRXfz7bao5u1AqtrWg5qj9UF+eKcdBIsH+t3x1Y8gksCLxAyQTSNwCXw==
X-Received: by 2002:a05:6512:e82:: with SMTP id bi2mr8530755lfb.590.1643587199935;
        Sun, 30 Jan 2022 15:59:59 -0800 (PST)
Received: from localhost.localdomain (109-252-138-126.dynamic.spd-mgts.ru. [109.252.138.126])
        by smtp.gmail.com with ESMTPSA id e7sm3443193lfb.17.2022.01.30.15.59.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jan 2022 15:59:59 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Svyatoslav Ryhel <clamor95@gmail.com>,
        Anton Bambura <jenneron@protonmail.com>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/3] Support Sharp LQ101R1SX03 and HannStar HSD101PWW2 panels
Date:   Mon, 31 Jan 2022 02:59:42 +0300
Message-Id: <20220130235945.22746-1-digetx@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for Sharp LQ101R1SX03 and HannStar HSD101PWW2
display panels that are used by Asus Transformer tablets, which we're
planning to support since 5.17 kernel.

Changelog:

v3: - No changes. Re-sending for 5.18. Device-trees of devices that use
      these panels were merge to 5.17, so we're missing the display support.

v2: - Added ack from Rob Herring to the HSD101PWW2 binding.

    - Updated LQ101R1SX01 binding, like it was suggested by Rob Herring,
      making LQ101R1SX03 directly compatible with the LQ101R1SX01.
      Such that ["sharp,lq101r1sx03", "sharp,lq101r1sx01"] could be
      used in DT. This removes need to update panel driver with the new
      compatible.

    - Improved commit message of the LQ101R1SX03 patch.

    - Added my s-o-b to all patches.

Anton Bambura (1):
  dt-bindings: sharp,lq101r1sx01: Add compatible for LQ101R1SX03

Svyatoslav Ryhel (2):
  dt-bindings: display: simple: Add HannStar HSD101PWW2
  drm/panel: simple: Add support for HannStar HSD101PWW2 panel

 .../bindings/display/panel/panel-simple.yaml  |  2 ++
 .../display/panel/sharp,lq101r1sx01.yaml      |  7 ++++-
 drivers/gpu/drm/panel/panel-simple.c          | 28 +++++++++++++++++++
 3 files changed, 36 insertions(+), 1 deletion(-)

-- 
2.34.1

