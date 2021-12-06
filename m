Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7314946A0C3
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 17:09:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388723AbhLFQMu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 11:12:50 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:44330 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389964AbhLFQKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 11:10:19 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E7596612D3;
        Mon,  6 Dec 2021 16:06:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF73CC341C1;
        Mon,  6 Dec 2021 16:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638806809;
        bh=CpWhy6y6679xdjK1yqH31wIahrmeam/ZjNVyj/lHd5s=;
        h=From:To:Cc:Subject:Date:From;
        b=pfiaUI8eOTwSWBl4spQR7cnwWkdFXTZxH7z80sLZ4PpwHaVroJC+EnelB/yxN7ScX
         c8RFYVoMlPCiT/yZtLZdxKCs4grkp0cAHEgv2W48zHHVLkTVZniiGr7B+Oye9N4xM3
         31Iyto3NwMJnTKP8tEbsqXgA44H3rm0+9QwUix29CyrfVy/4H0j5nkissRonb9TE1G
         +nG+VYWEfojf9Nb4Ik7Yiq5lQv0YDaZSwsHpQtFEaIe+i4QSTvnmJkVXO1FufhfYbs
         bSH52G7tjCBWTlI4Rdxls4EdrPsTnjHG2C1ItLWnJ+iHBmV9EaiTHsaLogVw9nVDXq
         Lo6nKW/7ZHMeg==
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI fixes for v5.16-rc4
Date:   Mon, 06 Dec 2021 16:06:34 +0000
Message-Id: <20211206160648.CF73CC341C1@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 6c53b45c71b4920b5e62f0ea8079a1da382b9434:

  spi: fix use-after-free of the add_lock mutex (2021-11-12 18:18:03 +0000)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v5.16-rc4

for you to fetch changes up to 07fb78a78de4e67b5d6d5407aeee1250a327a698:

  spi: spi-rockchip: Add rk3568-spi compatible (2021-11-29 12:19:32 +0000)

----------------------------------------------------------------
spi: Update for v5.16

Just one trivial update adding a device ID to the DT bindings.

----------------------------------------------------------------
Nicolas Frattaroli (1):
      spi: spi-rockchip: Add rk3568-spi compatible

 Documentation/devicetree/bindings/spi/spi-rockchip.yaml | 1 +
 1 file changed, 1 insertion(+)
