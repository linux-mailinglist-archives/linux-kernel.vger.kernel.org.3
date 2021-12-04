Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2937F468778
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 21:32:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235174AbhLDUgI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 15:36:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbhLDUgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 15:36:07 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B47DC061751
        for <linux-kernel@vger.kernel.org>; Sat,  4 Dec 2021 12:32:41 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id r26so15160326lfn.8
        for <linux-kernel@vger.kernel.org>; Sat, 04 Dec 2021 12:32:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VbnObieNhN4HWcKCIDaKmm9vJMYD6S4kiEivj9DQbno=;
        b=qTWmTPzr5SZINLiFebGd1GKy5SqScFEc8DpbfZiPUh2HEwK+4unFEYZ37E+6TFOx4P
         auJ+RrOHY32Ozud0AmRiv2iIo+FdMdHkt+Ke/jiXg7C+WOuUA3b9+iUHb82EhiD0BnIB
         2xuuBEvbgqFbjqo2SFmNxZX704fMAGRH1zmVNIir+3Yho9Se/MYVhSvF2G5gNTFWNaH+
         ZhjT6KcCNA5mdbV3Fh/E5UU4dabez87RLIBHvyeu0Gt8EhFQux2UnIjRu0NU1rucSHWU
         NeaUxM5k4UxkVWGE+zm6/3zo3N5TZAJPsIlKNxrfJgWDk4shZBYF9IcIkVvW5KLOZ9V1
         FzRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VbnObieNhN4HWcKCIDaKmm9vJMYD6S4kiEivj9DQbno=;
        b=jJ9Z2vvwxWrs2qYxHOk8PPDgsNpzNMhirBZW/TUyWYP9xzSk2mPPx000zNpnv7MK0C
         sGfDcB62lGyS7JG4kkCy9bbEIwA0+ntx9ZuICK0R3I84Jx1M3VVqdXcAgWbZ3uWHRxPf
         6YYsvTRkMla01iJykpgyIzcCRdu3+CZfSO8kFNKPu0mFHsUil83PJCCka+MekovLacvC
         QulcARTEWg9KLvVNh3x2s6EOsOTcKf2Bx6PO6wT2QtoyklreGXLkUYdhcbt29c1Raker
         849F+r9NPpu4rRHWvzBCspUfOJY51qeNFW9lMHorz94YfI7Md3WGv2WDw+YR7wMkmixW
         k3cg==
X-Gm-Message-State: AOAM532TCkv+qnp8pLbEVTNeevqje2XVD9ePYXxo654khs55QSVGtNw7
        Iiv0+IaXB0HgwDbb+vv1SuI=
X-Google-Smtp-Source: ABdhPJxer4cUDJ8cf408x7zVsz6ZxrHKFF+7H9r9tcHCQgYBt6n3/uKuWJULjhyVKQLscMciNUdSCw==
X-Received: by 2002:a05:6512:2101:: with SMTP id q1mr24570781lfr.663.1638649959603;
        Sat, 04 Dec 2021 12:32:39 -0800 (PST)
Received: from localhost.localdomain (h-155-4-221-129.NA.cust.bahnhof.se. [155.4.221.129])
        by smtp.gmail.com with ESMTPSA id s4sm861049lfp.198.2021.12.04.12.32.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Dec 2021 12:32:38 -0800 (PST)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        sound-open-firmware@alsa-project.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH] ASoC: SOF: sof-probes: Constify sof_probe_compr_ops
Date:   Sat,  4 Dec 2021 21:32:20 +0100
Message-Id: <20211204203220.54712-1-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only usage of sof_probe_compr_ops is to assign its address to the
cops field in the snd_soc_dai_driver struct (in
sound/soc/sof/intel/hda-dai.c). Make it const to allow the compiler to
put it in read-only memory.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 sound/soc/sof/sof-probes.c | 2 +-
 sound/soc/sof/sof-probes.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sof/sof-probes.c b/sound/soc/sof/sof-probes.c
index 5586af9f1a25..c79026cdb8c7 100644
--- a/sound/soc/sof/sof-probes.c
+++ b/sound/soc/sof/sof-probes.c
@@ -321,7 +321,7 @@ static int sof_probe_compr_pointer(struct snd_compr_stream *cstream,
 	return snd_sof_probe_compr_pointer(sdev, cstream, tstamp, dai);
 }
 
-struct snd_soc_cdai_ops sof_probe_compr_ops = {
+const struct snd_soc_cdai_ops sof_probe_compr_ops = {
 	.startup	= sof_probe_compr_startup,
 	.shutdown	= sof_probe_compr_shutdown,
 	.set_params	= sof_probe_compr_set_params,
diff --git a/sound/soc/sof/sof-probes.h b/sound/soc/sof/sof-probes.h
index 35e1dd8d9e03..4a1ed2942d28 100644
--- a/sound/soc/sof/sof-probes.h
+++ b/sound/soc/sof/sof-probes.h
@@ -32,7 +32,7 @@ int sof_ipc_probe_points_add(struct snd_sof_dev *sdev,
 int sof_ipc_probe_points_remove(struct snd_sof_dev *sdev,
 				unsigned int *buffer_id, size_t num_buffer_id);
 
-extern struct snd_soc_cdai_ops sof_probe_compr_ops;
+extern const struct snd_soc_cdai_ops sof_probe_compr_ops;
 extern const struct snd_compress_ops sof_probe_compressed_ops;
 
 #endif
-- 
2.34.1

