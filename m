Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92086490966
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 14:21:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235868AbiAQNVq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 08:21:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229474AbiAQNVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 08:21:45 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B651C061574;
        Mon, 17 Jan 2022 05:21:45 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: adalessandro)
        with ESMTPSA id 95D491F439DB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1642425704;
        bh=2RICMHQrkMO5zSBVKKX/QOjg/XRPM2S1SVfQ0XJNulQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oEQdFHQ7mDOuvcs28VptPlgKC63qEcN4K/a7qlzScErykt3VxA7ufhYxjG6hLuGf5
         WMTnRI6Rf1Q5SCT1ISMXt2FzfFBFIsXmjLemoIo2iBdPJh5Wl2Ho/9nEd9hAKW7/BA
         wem4IXfFCZZB/GoKsYHWLIgrwQayvIXgXFQia0rfyI/rXPkTomguAOJpys9imvaXXV
         k52OJBg0UW8eKM7WuoneSA6LklK7a10IMl7ilp1TjIpY5Pfv6Q9TruYNKUoyjJH9fd
         CzXdcKYzphUpcWnI69TNMVdLkiYWcyOsGAILeeVX6T4l1NmtgfkzhBtLrlIeC7FcA4
         ZbQMGNkG/YzCQ==
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
Subject: [PATCH v2 3/5] ASoC: bindings: fsl-asoc-card: Add mclk-id optional property
Date:   Mon, 17 Jan 2022 10:21:07 -0300
Message-Id: <20220117132109.283365-4-ariel.dalessandro@collabora.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220117132109.283365-1-ariel.dalessandro@collabora.com>
References: <20220117132109.283365-1-ariel.dalessandro@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support setting the sound card main clock input from the device-tree
using the mclk-id property.

Signed-off-by: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
---
 Documentation/devicetree/bindings/sound/fsl-asoc-card.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/sound/fsl-asoc-card.txt b/Documentation/devicetree/bindings/sound/fsl-asoc-card.txt
index 23d83fa7609f..b219626a5403 100644
--- a/Documentation/devicetree/bindings/sound/fsl-asoc-card.txt
+++ b/Documentation/devicetree/bindings/sound/fsl-asoc-card.txt
@@ -82,6 +82,7 @@ Optional properties:
   - dai-format		: audio format, for details see simple-card.yaml.
   - frame-inversion	: dai-link uses frame clock inversion, for details see simple-card.yaml.
   - bitclock-inversion	: dai-link uses bit clock inversion, for details see simple-card.yaml.
+  - mclk-id		: main clock id, specific for each card configuration.
 
 Optional unless SSI is selected as a CPU DAI:
 
-- 
2.34.1

