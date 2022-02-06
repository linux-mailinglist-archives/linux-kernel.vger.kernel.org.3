Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74E6D4AAF21
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Feb 2022 13:08:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235316AbiBFMIf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Feb 2022 07:08:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230450AbiBFMIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 07:08:31 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADDC8C06173B
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 04:08:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4DE78B80DFF
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 12:08:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA4D1C340E9;
        Sun,  6 Feb 2022 12:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644149307;
        bh=pRouC042hZRmL8TGaO0qazAzwylRGIQ4wlGW4eABWKI=;
        h=Date:From:To:Cc:Subject:From;
        b=RhObMopuznLQRlO93xeUevqneBxrx5vps6yMiW6/TjYDSVGfyBGErLXvl5sSo0UY3
         17T7R6ywVf7lu6Ov7ZLx4xgWfJMmApVWvV0YmRwAzVTRwyK5HNkmMwC9pWPQZBZf6Q
         pZFfJOBmCUJpxjHNWtQXB6JIIRZ6juXQbWg4O8xQhFATrX7vrdBLcdBqFL2QvlfZ+G
         Z9IMMVnMBapZLcBhoQWP+rneyIgwgRw/pLJJxWtzHM5AvrOJRSaoWLLhNn0wSlkutp
         6jDKlnrgtLoE/zTBnIEWRszd9HwDKfx65wKcbCG84OS0euP/qvSxHmd5yvdal4naMH
         HZWw4tr87wT7w==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E08C3404A6; Sun,  6 Feb 2022 09:08:25 -0300 (-03)
Date:   Sun, 6 Feb 2022 09:08:25 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Dmitry Osipenko <digetx@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/1] tools include UAPI: Sync sound/asound.h copy with the
 kernel sources
Message-ID: <Yf+6OT+2eMrYDEeX@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just FYI I'm carrying this in the perf tools tree.

- Arnaldo

---

Picking the changes from:

  06feec6005c9d950 ("ASoC: hdmi-codec: Fix OOB memory accesses")

Which entails no changes in the tooling side as it doesn't introduce new
SNDRV_PCM_IOCTL_ ioctls.

To silence this perf tools build warning:

  Warning: Kernel ABI header at 'tools/include/uapi/sound/asound.h' differs from latest version at 'include/uapi/sound/asound.h'
  diff -u tools/include/uapi/sound/asound.h include/uapi/sound/asound.h

Cc: Dmitry Osipenko <digetx@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>
Link: https://lore.kernel.org/lkml/
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/sound/asound.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/include/uapi/sound/asound.h b/tools/include/uapi/sound/asound.h
index ef0cafe295b28253..2d3e5df39a59eeec 100644
--- a/tools/include/uapi/sound/asound.h
+++ b/tools/include/uapi/sound/asound.h
@@ -56,8 +56,10 @@
  *                                                                          *
  ****************************************************************************/
 
+#define AES_IEC958_STATUS_SIZE		24
+
 struct snd_aes_iec958 {
-	unsigned char status[24];	/* AES/IEC958 channel status bits */
+	unsigned char status[AES_IEC958_STATUS_SIZE]; /* AES/IEC958 channel status bits */
 	unsigned char subcode[147];	/* AES/IEC958 subcode bits */
 	unsigned char pad;		/* nothing */
 	unsigned char dig_subframe[4];	/* AES/IEC958 subframe bits */
-- 
2.34.1

