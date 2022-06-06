Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D5A453EAEC
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240475AbiFFPWw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 11:22:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240471AbiFFPWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 11:22:51 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00BBA35840;
        Mon,  6 Jun 2022 08:22:49 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id n10so29649496ejk.5;
        Mon, 06 Jun 2022 08:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q+Uwlf6qgJvF453WbwLN1jaXprVYO3wmuZLS2RkkxFs=;
        b=m09w9gwjIR2RAinzDyK8VruLeAVFJvHbrpa+jH7oL4BHaYqSW018C8VDZ5FfT4vyLg
         kNefBfLJHsDLZlV8RkJKC8ykSn5cgqkyB6k4jQdfBwSycSwz2Y4276a5v4F77KXSferg
         ZsKhu1CptfVOlueQ7oisLW6pMvU18Zv1B3k7IZq8sAB2opU8HQ1H2/L2XhGAvkO1NjTC
         mSVFBgdgRwsaDa2j/z3wTMl7LluZzvd7rYgBGxwur8G+FAr0zglFNsEyZlsKhYcP0EWW
         VJlrkvanXxE7DYNxjSJLAFFpi170XqtRM3xZi4myMc9TxZ/3uTlRHveq0na6un/jV+D5
         PavA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q+Uwlf6qgJvF453WbwLN1jaXprVYO3wmuZLS2RkkxFs=;
        b=a3C6JCTYfSF/teONzFUt1fgnGkPmaDP3CB3E78mNAzZJVaQJeUiFkq8nOJDT9U8zj3
         PTG9onKPwNMtO33logC5ylrnVsKy0Wk32ljvWoh9ahHCpheiFh2/oDONDaAybHYXYh6W
         DXjDFmcfPJD1p7/Kz1gL64ptQWpB683RW5BepYd0hmRHzij0r1PMwHG7lOlkI3AT79ED
         rK9SZLRcJDTWz/R0b6jbyZXoE/uTh7ySa0yrk0V9UEtTiOfjyBKkvXVo8uvuPogidNPY
         jwbSNyuh9vAoVEUK23mdqSRZRq9zg7wfCOoIIgzWphHCdD3Icgmhpcl30+2mR55BqHiL
         hsKw==
X-Gm-Message-State: AOAM532wHiYGNMuu5pnnl6zc6ZYyV7LzohwNAAFFMzwvhuEFdLGPOwBW
        953bSXSdYPY2oYh33vI+YRA=
X-Google-Smtp-Source: ABdhPJwanu3lq40yFMgYXOPYxN6gLx5qlezisxn9fc6ryWKeN9LAGfPx4pY2ol6YBGm4gXEwZyWM9A==
X-Received: by 2002:a17:907:1c87:b0:6f0:29ea:cc01 with SMTP id nb7-20020a1709071c8700b006f029eacc01mr22180895ejc.671.1654528968351;
        Mon, 06 Jun 2022 08:22:48 -0700 (PDT)
Received: from localhost.localdomain ([138.199.7.159])
        by smtp.gmail.com with ESMTPSA id b3-20020a170906660300b00711aed17047sm2348128ejp.28.2022.06.06.08.22.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 08:22:47 -0700 (PDT)
From:   Yassine Oudjana <yassine.oudjana@gmail.com>
X-Google-Original-From: Yassine Oudjana <y.oudjana@protonmail.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@codeaurora.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        Yassine Oudjana <yassine.oudjana@gmail.com>,
        alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: wcd9335: Remove RX channel from old list before adding it to a new one
Date:   Mon,  6 Jun 2022 19:22:26 +0400
Message-Id: <20220606152226.149164-1-y.oudjana@protonmail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yassine Oudjana <y.oudjana@protonmail.com>

Currently in slim_rx_mux_put, an RX channel gets added to a new list
even if it is already in one. This can mess up links and make either
it, the new list head, or both, get linked to the wrong entries.
This can cause an entry to link to itself which in turn ends up
making list_for_each_entry in other functions loop infinitely.
To avoid issues, always remove the RX channel from any list it's in
before adding it to a new list.

Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
---
 sound/soc/codecs/wcd9335.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wcd9335.c b/sound/soc/codecs/wcd9335.c
index 617a36a89dfe..597420679505 100644
--- a/sound/soc/codecs/wcd9335.c
+++ b/sound/soc/codecs/wcd9335.c
@@ -1289,9 +1289,12 @@ static int slim_rx_mux_put(struct snd_kcontrol *kc,
 
 	wcd->rx_port_value[port_id] = ucontrol->value.enumerated.item[0];
 
+	/* Remove channel from any list it's in before adding it to a new one */
+	list_del_init(&wcd->rx_chs[port_id].list);
+
 	switch (wcd->rx_port_value[port_id]) {
 	case 0:
-		list_del_init(&wcd->rx_chs[port_id].list);
+		/* Channel already removed from lists. Nothing to do here */
 		break;
 	case 1:
 		list_add_tail(&wcd->rx_chs[port_id].list,
-- 
2.36.1

