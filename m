Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C99F747EEF2
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 14:13:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352723AbhLXNLJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 08:11:09 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:37820 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233233AbhLXNLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 08:11:08 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 361326206F
        for <linux-kernel@vger.kernel.org>; Fri, 24 Dec 2021 13:11:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64EE3C36AE5;
        Fri, 24 Dec 2021 13:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640351467;
        bh=MOI2F7NA2AxaR+yfJWOfRlslVPAUrSbCsIU0LjQRwYc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hq9Rc/3Yl+iTJEUYkVVGDA8806KO6rmLWJjMg568u2dTpnfew6yA4X/FxC2SSLNdS
         HbcKqlWuxNdaZ3whJqOaV3L8fAwEesbvg2TemWXjVWeqY0vFps+7O/jYVNVk4w/SR9
         FYVg+LxDU295gUrfXQcP4ccsr2fuJC1DUgdvDPyUaljJr85ToTxQUA0GyZJoOKWQ5G
         jJmcly53yAov9DJ5sTaqir/8vHnh8ZsPmw7Vj3cxSbwxqpH+SyvFccI+G2uD6Nxj7X
         gFrwr5LmK0Kk/+dvr1QxdHnNqyxBpsRO7n5pHsdweafBW18ZVji2L1OQUpoQEmgxLx
         KWLWCkc+ruV7w==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1n0kLh-000UqY-8N; Fri, 24 Dec 2021 14:11:05 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Bard Liao" <yung-chuan.liao@linux.intel.com>,
        "Huajun Li" <huajun.li@intel.com>,
        "Kai Vehmanen" <kai.vehmanen@linux.intel.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Jie Yang <yang.jie@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: [PATCH 1/1] ASoC: Intel: sof_es8336: add quirk for Huawei D15 2021
Date:   Fri, 24 Dec 2021 14:09:50 +0100
Message-Id: <d560a1c76edb633c37acf04a9a82518b6233a719.1640351150.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1640351150.git.mchehab@kernel.org>
References: <cover.1640351150.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Huawei D15 uses SSP_CODEC(0).

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH 0/1] at: https://lore.kernel.org/all/cover.1640351150.git.mchehab@kernel.org/

 sound/soc/intel/boards/sof_es8336.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/soc/intel/boards/sof_es8336.c b/sound/soc/intel/boards/sof_es8336.c
index e38eafd19251..5427285f78d0 100644
--- a/sound/soc/intel/boards/sof_es8336.c
+++ b/sound/soc/intel/boards/sof_es8336.c
@@ -247,6 +247,14 @@ static const struct dmi_system_id sof_es8336_quirk_table[] = {
 					SOF_ES8336_TGL_GPIO_QUIRK |
 					SOF_ES8336_ENABLE_DMIC)
 	},
+	{
+		.callback = sof_es8336_quirk_cb,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "HUAWEI"),
+			DMI_MATCH(DMI_BOARD_NAME, "BOHB-WAX9-PCB-B2"),
+		},
+		.driver_data = (void *)SOF_ES8336_SSP_CODEC(0)
+	},
 	{}
 };
 
-- 
2.33.1

