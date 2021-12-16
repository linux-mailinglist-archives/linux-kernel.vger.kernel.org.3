Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1525B476B4B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 09:02:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234614AbhLPIBR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 03:01:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232196AbhLPIBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 03:01:08 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54F5BC061574;
        Thu, 16 Dec 2021 00:01:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 147D6B822F4;
        Thu, 16 Dec 2021 08:01:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80011C36AE2;
        Thu, 16 Dec 2021 08:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639641665;
        bh=EOAgxELPRuLRqx1KAnQR0YXQTiu5+zs3zblZiLweCSI=;
        h=From:To:Cc:Subject:Date:From;
        b=gesmCZS2CBLq5hQAoBvs6sU54WJMnQfFmvMfyZh/PJLkLAkBnrEdWKy+H3WtMApWI
         /vRDlWoUEKTL7ArUNfBUlaQWCd8x98cuseS202yVP1OFmIvcXsN9oI+wowYt4pf3cL
         n2DnT5GSdPVPqcccxRRKozUKVZBadXBzyPnERp1ZWpmThRGFZsG+h1C+aJhjJljtjo
         /1eW/kB34vqhM47vQvIKRqnFh5IWXfo24JlaTo/FQZ8q3MC4pB2YTnHsHpZwcQF6q6
         L1L3wyKB5WWNSyrpPouLZGmPvGWmkaQ0Dptqxj3h/uHrBmQHfWtcvsb1ww5LI/fRWh
         jR8GOKo7AAPcQ==
From:   broonie@kernel.org
To:     Colin Cross <ccross@android.com>, Olof Johansson <olof@lixom.net>,
        Thierry Reding <treding@nvidia.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        linux-arm-kernel@lists.infradead.org
Subject: linux-next: manual merge of the tegra tree with the qcom tree
Date:   Thu, 16 Dec 2021 08:01:00 +0000
Message-Id: <20211216080100.3496490-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Today's linux-next merge of the tegra tree got a conflict in:

  arch/arm/configs/multi_v7_defconfig

between commit:

  7495af9308354 ("ARM: multi_v7_defconfig: Enable drivers for DragonBoard 410c")

from the qcom tree and commit:

  ca1f7d245f530 ("ARM: config: multi v7: Enable display drivers used by Tegra devices")

from the tegra tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --cc arch/arm/configs/multi_v7_defconfig
index ae227d309dc1b,3d509bc134440..0000000000000
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@@ -705,7 -690,7 +708,8 @@@ CONFIG_DRM_PANEL_ORISETECH_OTM8009A=
  CONFIG_DRM_PANEL_RAYDIUM_RM68200=m
  CONFIG_DRM_PANEL_SAMSUNG_S6E63J0X03=m
  CONFIG_DRM_PANEL_SAMSUNG_S6E8AA0=m
 +CONFIG_DRM_DISPLAY_CONNECTOR=m
+ CONFIG_DRM_LVDS_CODEC=m
  CONFIG_DRM_NXP_PTN3460=m
  CONFIG_DRM_PARADE_PS8622=m
  CONFIG_DRM_SII902X=m
