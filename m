Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 546C6467CD5
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 18:50:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382459AbhLCRyI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 12:54:08 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:59124 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343541AbhLCRyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 12:54:08 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: adalessandro)
        with ESMTPSA id 24DA11F41317
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1638553842; bh=yGwScbDhyL1oOF9cERSZ73Apg4NOw/m+9XA+Lj/me2k=;
        h=From:To:Cc:Subject:Date:From;
        b=Vxtjt6famLNA0bPuSzq3bwFuOHlAF37VLUzF6Xnh5G+AEhTP3PK68JyVyLf2GDPSM
         nukyGs3LqgrALzxv8qz6K6lUp3sngRdfKg4ZQ3zP+Sdupj96LyVycjFMvKbylR34ob
         Q0cZlKVmXEVjXVHUNLff+O4/1OCqRFhuOTpCca9ZV9VLs4oSgwLb6Af+009/xCkKDk
         WSN/5bTtQiWnYUTYdjvaeUwcAkpIQZLA6LiGbKeXWiGvz5/xJR6WxiakHvta8BN+QT
         aoM/ptM7faU2Vu1rRGdqm/W7jNx0l2Oh4E6UlLp4r/V/T57DneNnHeKaZmsGj+syxD
         +WHh8is4OL9Sg==
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
Date:   Fri,  3 Dec 2021 14:50:17 -0300
Message-Id: <20211203175018.252641-1-ariel.dalessandro@collabora.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a follow up of patchsets:

  [RFC patch 0/5] Support BCLK input clock in tlv320aic31xx
  [PATCH 0/4] fsl-asoc-card: Add optional dt property for setting mclk-id

Patch "ASoC: fsl-asoc-card: Support fsl,imx-audio-tlv320aic31xx codec"
in "[RFC patch 0/5] Support BCLK input clock in tlv320aic31xx" missed a
Kconfig option. Sending incremental patch fix.

Regards,
Ariel

Ariel D'Alessandro (1):
  ASoC: fsl-asoc-card: Add missing Kconfig option for tlv320aic31xx

 sound/soc/fsl/Kconfig | 1 +
 1 file changed, 1 insertion(+)

-- 
2.30.2

