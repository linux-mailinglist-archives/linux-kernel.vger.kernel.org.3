Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6997248621E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 10:29:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237417AbiAFJ3q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 04:29:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237186AbiAFJ3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 04:29:45 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B95EDC061245
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 01:29:44 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id n30-20020a17090a5aa100b001b2b6509685so2552245pji.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jan 2022 01:29:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fPr1nBHiTSgph/tTGH5kJPnXHbDmfAq4bys7S0VY+v0=;
        b=aM/LrGv2rQk/Pv4J+BPxttat1R8Ou8GuDntATvl1kGiENNx9xqFxp5OI8SbG06Trai
         fk80sMZVXCI1GVpWV4iBHN3dYBZvzCvkBnTd9vO7kZ2VLi/q0oHJC9UDyTiD3yHbHwbP
         iZCM7ZrPfybKTDeSjf1yIDrdG273/VFpjnQswo0LmO+3qu//py7U4Jomi/wWazGa0qca
         UniZR83cSOTj+l302efM3g3UtL2R6f7/m5/kVWYZaq645a8vzmvCPNMZq5GjxC7FN5Wu
         UL6y6EyaRccNwxjGdQXq8kNe/mNFrMdaazyQJyNWVjnbU2LkXFhlG/236myRLA2ospE9
         kUrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fPr1nBHiTSgph/tTGH5kJPnXHbDmfAq4bys7S0VY+v0=;
        b=gb1a9ZRziiTrx+xxOwoUUbTQwevfb/LRDTTBKJBWgPBZf/ifztLCavZJUxbCe36P5F
         hamuC3wKgZC/ytI+lFHYJqAFyUaaArfA635UuLH2/ohJLn19ZPV4qdYdvctBeWPLfGRi
         UGy4N2cofL2Kv2y3u5/RwjOtDQrRPcokA49Pt03RathS9gJkQsrWGjcRA/ZlNm/YwgZI
         QBl42WmQRCJwhVmFgREAjl6tPdS9VcaYn6wgMeH1YvIjNvOmq4o+7xW1BO+PJLF15cq1
         7wpWRaW4rHb8UkCN1LiBFff/7G+2smWcvhcQSppiIZ0AmcNW1r7L1EdkbDGoCqFft1jI
         BJLg==
X-Gm-Message-State: AOAM530WMXfcdKyMQPmKG9sTaJ8+dAgzMEF3JWtt0igSq8/JkazES8wY
        Nw6PbEtDVH23D/43BDqJqZI=
X-Google-Smtp-Source: ABdhPJwf73l4jLY2UjJyhmnaA/8ASiTX8YUzJY3tfkfrZJHHEdLXj8Qe9C34SXMZigHJaNJ/vXgxAg==
X-Received: by 2002:a17:902:ab85:b0:149:ca14:4a15 with SMTP id f5-20020a170902ab8500b00149ca144a15mr7738385plr.169.1641461384280;
        Thu, 06 Jan 2022 01:29:44 -0800 (PST)
Received: from localhost.localdomain ([94.177.118.151])
        by smtp.googlemail.com with ESMTPSA id rm6sm5712002pjb.35.2022.01.06.01.29.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 01:29:44 -0800 (PST)
From:   Qinghua Jin <qhjin.dev@gmail.com>
Cc:     Qinghua Jin <qhjin.dev@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: topology: Fix typo
Date:   Thu,  6 Jan 2022 17:28:47 +0800
Message-Id: <20220106092847.357035-1-qhjin.dev@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

change 'postion' to 'position'

Signed-off-by: Qinghua Jin <qhjin.dev@gmail.com>
---
 sound/soc/soc-topology.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index f5b9e66ac3b8..2630df024dff 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -56,7 +56,7 @@ struct soc_tplg {
 	const struct firmware *fw;
 
 	/* runtime FW parsing */
-	const u8 *pos;		/* read postion */
+	const u8 *pos;		/* read position */
 	const u8 *hdr_pos;	/* header position */
 	unsigned int pass;	/* pass number */
 
-- 
2.30.2

