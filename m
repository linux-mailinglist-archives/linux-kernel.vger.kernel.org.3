Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89C8D487204
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 06:13:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbiAGFNk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 00:13:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiAGFNj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 00:13:39 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3C0BC061245;
        Thu,  6 Jan 2022 21:13:38 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id r139so4897793qke.9;
        Thu, 06 Jan 2022 21:13:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Li/jQ4nlT3gPpvd1NyTQnIxzc9JA+p42BI5110gVryI=;
        b=flgkUHgw4ONbU++HRN0/dcycqmYpQtCeuXbAZ978Y2HlS3hd45yMtsBSdhQcwc8dL6
         69sqSq1ogMCvac19pdxhTNzIZhDwegFYIGfnPiXMZ+4DLXSZt5wRv0OniLkLUBGnB2b7
         XjTjbETLYgbS1L325wN3km5U6+gHDtMKydhcAFVwrcdJ4nebFD1W5I8i/d5AFzezksmg
         R5eCgAJu720OURyKmnAEgKN/CP1b6r0GiTdOTLPcbvcRLtzaC3K+cs4NpK8hSU46Dvoq
         NDsJc9q499uGQ91vEnxGq1JnCW+DAwNuRdUrrOyXZZk/TCHKbbGsUhaormBvLtjqEVd4
         9Ugw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Li/jQ4nlT3gPpvd1NyTQnIxzc9JA+p42BI5110gVryI=;
        b=eTDkMajXar+oSU9wS+F66ugMOfwpuQK+8SLqkEHBZ3EcyhxiduLra0tw0VCKZNGGOF
         Jp1wpfsreg29pG3PjERxy7Co7HFF7x3bTCBZCumXmk30mQTLW+XUBQop0f0XPLpttJRx
         blC/ynLyB5uleZ+AB3Soh4hBiaqt3UrwXBOIaArRIr/q39kKbNyH1rJ7WmiNTSa1Mmnl
         4atKtWBUDx4pTtYVWQ/hO87WYMCGjiXzEWnQgsHYiSGYIYPzeyfM0AkYrCI3GJiJqvGO
         e4C4Ud3R8ogVCQ3mXnCXXaB3LJ6wMN2pBFKc5Hffj1Zn3Z+Ti3V1PDOYGRtrqhaQhwCe
         0zdw==
X-Gm-Message-State: AOAM532WcKcBEyz1smvxhxKbomIL8lW2TNvvTd1AiDdgmASZlO8pdz2x
        76F1GbMnIDevsA+HWlQA5mZ9yRN6uhc=
X-Google-Smtp-Source: ABdhPJwKY6h//TE+tGAQiabm+i9yikHXhF4LBqqUoo9Q9fDk3rh6FQkdWelmqULqZGdTfgcbWDhPpw==
X-Received: by 2002:a05:620a:40ca:: with SMTP id g10mr41638232qko.425.1641532417910;
        Thu, 06 Jan 2022 21:13:37 -0800 (PST)
Received: from master-x64.sparksnet (c-98-233-193-225.hsd1.dc.comcast.net. [98.233.193.225])
        by smtp.gmail.com with ESMTPSA id d15sm1651461qka.3.2022.01.06.21.13.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 21:13:37 -0800 (PST)
From:   Peter Geis <pgwipeout@gmail.com>
Cc:     Peter Geis <pgwipeout@gmail.com>, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: [PATCH 0/4] add pine64 touch panel support to rockpro64
Date:   Fri,  7 Jan 2022 00:13:31 -0500
Message-Id: <20220107051335.3812535-1-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds support for the Pine64 touch panel to the
rockpro64 single board computer.
This panel attaches to the dsi port and includes an i2c touch screen.

The first two patches involve making the reset pin to the Feiyang
fy07024di26a30d panel optional. On the rockpro64 and quartz64-a this pin
is tied to dvdd and automatically comes high when power is applied.
The third patch adds the device tree nodes to rockpro64 to permit the
panel to be used.
The fourth patch is an example patch to enable this support, tagged do
not merge as this is something for the end user to enable only when they
have the panel attached.

Peter Geis (4):
  dt-bindings: display: panel: feiyang,fy07024di26a30d: make reset gpio
    optional
  drm/panel: feiyang-fy07024di26a30d: make reset gpio optional
  arm64: dts: rockchip: add pine64 touch panel display to rockpro64
  arm64: dts: rockchip: enable the pine64 touch screen on rockpro64

 .../panel/feiyang,fy07024di26a30d.yaml        |  1 -
 .../boot/dts/rockchip/rk3399-rockpro64.dtsi   | 80 ++++++++++++++++++-
 .../drm/panel/panel-feiyang-fy07024di26a30d.c | 11 ++-
 3 files changed, 83 insertions(+), 9 deletions(-)

-- 
2.32.0

