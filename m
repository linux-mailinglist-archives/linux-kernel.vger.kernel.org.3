Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E123467CD8
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 18:50:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382488AbhLCRyQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 12:54:16 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:59156 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343541AbhLCRyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 12:54:13 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: adalessandro)
        with ESMTPSA id 5BF591F4724E
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1638553848; bh=sjUDlRzGKvbKVrH0gyQWnGzouzwqlG1XZ4Jt6m71DjQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NwkfaQSTsNOkewcP0B716mc78gWZExuruZKkT+w5vMZK3j5bz16Jz46lMdsSHN6d8
         vbrQW+rczqrkZv7gADP/scWRDEpZELWkgK9yA3WbJZ7dzxsAcQM3cDW6Z1dSMAb2Ph
         DNZF/IGm1DuStbG7DGLsA3ifLF43DOGqZelzCHtFwWuhY9wg8KVgqH+XQ0KWLpha4L
         qG7g0WNvjEWJlWRgAmxQ49gBw/2k9U/fZgKgHc25hoh1vheF6Au/McyIVX/qPQcez6
         qZRfpnnAGXXsjsVkukAqI/r4Gfni8Z3xi3pR/SlzRu6kHkDoRnRsKTWgE+AyRiCnpk
         05KK4eUCt4h8g==
From:   Ariel D'Alessandro <ariel.dalessandro@collabora.com>
To:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc:     Xiubo.Lee@gmail.com, ariel.dalessandro@collabora.com,
        bcousson@baylibre.com, broonie@kernel.org, festevam@gmail.com,
        kuninori.morimoto.gx@renesas.com, lgirdwood@gmail.com,
        michael@amarulasolutions.com, nicoleotsuka@gmail.com,
        perex@perex.cz, robh+dt@kernel.org, shengjiu.wang@gmail.com,
        tiwai@suse.com, tony@atomide.com
Subject: [PATCH 1/1] ASoC: fsl-asoc-card: Add missing Kconfig option for tlv320aic31xx
Date:   Fri,  3 Dec 2021 14:50:18 -0300
Message-Id: <20211203175018.252641-2-ariel.dalessandro@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211203175018.252641-1-ariel.dalessandro@collabora.com>
References: <20211203175018.252641-1-ariel.dalessandro@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit added support for tlv320aic31xx codec to
fsl-asoc-card, but missed the related Kconfig option. Fix this.

  commit 8c9b9cfb7724685ce705f511b882f30597596536
  Author: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
  Date:   Fri Nov 19 12:32:48 2021 -0300

      ASoC: fsl-asoc-card: Support fsl,imx-audio-tlv320aic31xx codec

Signed-off-by: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
---
 sound/soc/fsl/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
index 8e05d092790e..10fa38753453 100644
--- a/sound/soc/fsl/Kconfig
+++ b/sound/soc/fsl/Kconfig
@@ -311,6 +311,7 @@ config SND_SOC_FSL_ASOC_CARD
 	select SND_SOC_FSL_ESAI
 	select SND_SOC_FSL_SAI
 	select SND_SOC_FSL_SSI
+	select SND_SOC_TLV320AIC31XX
 	select SND_SOC_WM8994
 	select MFD_WM8994
 	help
-- 
2.30.2

