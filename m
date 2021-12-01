Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DD54465542
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 19:22:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352299AbhLASZA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 13:25:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243657AbhLASYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 13:24:51 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9B96C061574;
        Wed,  1 Dec 2021 10:21:29 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id p3-20020a05600c1d8300b003334fab53afso437128wms.3;
        Wed, 01 Dec 2021 10:21:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yuM/SdfKQLHrjcyLgHfF3Sato5LO/cQMcLshE9oQn64=;
        b=Oc1glAx9ooL9XMK3XBK3yetsuhBDuKP8OM6GZ59MzIs+PaKJDn+IUDMchSFmbDSvBC
         PnaDnBw32U23IZB0yXjby2F5SiV/dCZoHsAzxQ9TjeNnReylzTLF6TZqLDj8JvblROCC
         xFfCBsmO/w6n9wEo13ChHSS3QFA+eUvdEEkU2p8HCVmQLsj0JWPYXRLOnjgW53NyKAfh
         TPk9Aq3QaowCRIW/qDiQajgc+dpBZGQd2sZMfY0oK9eg4Zr4EkPsZF9Em3BBK8kq4WQN
         J988HMdyPYYvgCJKZkJ5q/241BXIfPUDhvqpKPMC3jaavht0iv04xlxgXPB4uUzUs19Q
         /vbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yuM/SdfKQLHrjcyLgHfF3Sato5LO/cQMcLshE9oQn64=;
        b=KgAfuaNUk/Bk4L1d93uYci43doScAZbumNOtBB1hG5t7T6RzDD/AF5HQxKlD5ZOpdd
         HnxbvDENPzGmXmJIS9nIfofYx6FDjUNIHPxskVpOKJThUPGm6IO9GArDfXG+qdb/j0Zz
         lAVzg1EOFLTuREPfLbpC3kUG49e8THuxobz/fU04U/GTg5OysRUUbcsoJKdbiBIUc0l3
         CRLwJNiEfwoOQsSyVh+iGn5XKWGb3P8tyWd4wJ34ES2QZBnBjNxPNHzNTIHX0UHMCMKe
         pwdhagFUQbAb8Oi8q6I9v1CH+SE8NtQwVdmNPV0JJnEzfYq0cR8mWur5uLmTJ3uKw4be
         KhZg==
X-Gm-Message-State: AOAM5309udnq8Naf/uTNnfnu6PhyWed9Rp/JIsGuKJtdduRoHWrWIFmG
        5InhiNLK1w6rOfetrUM6LHY=
X-Google-Smtp-Source: ABdhPJw7zlCx1zFhjTin5TXNN3RE35rMroict+M40JheekUbsyMM2CUyaTM2OpGtkZ+2YqM6eKZQ5g==
X-Received: by 2002:a7b:c097:: with SMTP id r23mr8794547wmh.193.1638382888511;
        Wed, 01 Dec 2021 10:21:28 -0800 (PST)
Received: from kista.localdomain (cpe-86-58-29-253.static.triera.net. [86.58.29.253])
        by smtp.gmail.com with ESMTPSA id f7sm604705wri.74.2021.12.01.10.21.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 10:21:28 -0800 (PST)
From:   Jernej Skrabec <jernej.skrabec@gmail.com>
To:     mripard@kernel.org, wens@csie.org
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH 0/5] arm64: dts: allwinner: h6: tanix tx6
Date:   Wed,  1 Dec 2021 19:21:13 +0100
Message-Id: <20211201182118.1213806-1-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds new Tanix TX6 mini DT file (less capable as Tanix TX6),
adds MMC1 node for wifi and enables bluetooth on Tanix TX6 (no bluetooth
on mini).

Please take a look.

Best regards,
Jernej

Jernej Skrabec (5):
  arm64: dts: allwinner: h6: tanix-tx6: Split to DT and DTSI
  dt-bindings: arm: sunxi: Add Tanix TX6 mini
  arm64: dts: allwinner: h6: Add Tanix TX6 mini dts
  arm64: dts: allwinner: h6: tanix: Add MMC1 node
  arm64: dts: allwinner: h6: tanix-tx6: Enable bluetooth

 .../devicetree/bindings/arm/sunxi.yaml        |   5 +
 arch/arm64/boot/dts/allwinner/Makefile        |   1 +
 .../allwinner/sun50i-h6-tanix-tx6-mini.dts    |  15 ++
 .../dts/allwinner/sun50i-h6-tanix-tx6.dts     | 168 +---------------
 .../boot/dts/allwinner/sun50i-h6-tanix.dtsi   | 189 ++++++++++++++++++
 5 files changed, 220 insertions(+), 158 deletions(-)
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6-mini.dts
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h6-tanix.dtsi

-- 
2.34.1

